#!/usr/bin/env python3
"""Audit DOCX integrity, dependencies, accessibility, and internal version/status text."""

from __future__ import annotations

import argparse
import json
import posixpath
import re
import sys
import zipfile
from collections import Counter, defaultdict
from pathlib import Path
from urllib.parse import unquote
from xml.etree import ElementTree as ET

from _common import (
    VISIBLE_STATUS_LABELS,
    WorkflowError,
    parse_build,
    parse_release,
    save_json_atomic,
    sha256_file,
    utc_now,
    validate_stable_docx_filename,
)


NS = {
    "w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main",
    "wp": "http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing",
    "a": "http://schemas.openxmlformats.org/drawingml/2006/main",
    "r": "http://schemas.openxmlformats.org/officeDocument/2006/relationships",
    "pr": "http://schemas.openxmlformats.org/package/2006/relationships",
}
W = "{" + NS["w"] + "}"
WP = "{" + NS["wp"] + "}"
A = "{" + NS["a"] + "}"
R = "{" + NS["r"] + "}"
PR = "{" + NS["pr"] + "}"

FORBIDDEN_FIELD_RE = re.compile(
    r"\b(INCLUDETEXT|INCLUDEPICTURE|LINK|DDEAUTO|DDE|DATABASE)\b", re.IGNORECASE
)
FIELD_NAME_RE = re.compile(r"\b([A-Z][A-Z0-9_]*)\b")
BUILD_TOKEN_RE = re.compile(r"\bD[1-9][0-9]*\b", re.IGNORECASE)
RELEASE_TOKEN_RE = re.compile(r"\bv(?:0|[1-9][0-9]*)\b", re.IGNORECASE)
TRUE_VALUES = {"1", "true", "on", "yes"}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("docx", help="DOCX file to audit")
    parser.add_argument("--json", dest="json_path", help="write the report to this JSON file")
    parser.add_argument("--expected-build", help="expected internal development build, such as D24")
    parser.add_argument("--expected-release", help="expected release marker, such as v0 or v1")
    parser.add_argument(
        "--expected-status",
        choices=sorted(VISIBLE_STATUS_LABELS),
        help="expected visible document status",
    )
    parser.add_argument(
        "--expected-text",
        action="append",
        default=[],
        help="case-insensitive visible/stored text that must occur; repeat as needed",
    )
    parser.add_argument(
        "--forbid-development-builds",
        action="store_true",
        help="fail if any D-number remains in visible or stored document text",
    )
    parser.add_argument(
        "--require-stable-filename",
        action="store_true",
        help="fail if the DOCX filename ends in a build or release token",
    )
    parser.add_argument(
        "--allow-external-content",
        action="store_true",
        help="report but do not fail linked content, templates, or external-data relationships",
    )
    parser.add_argument(
        "--allow-missing-alt",
        action="store_true",
        help="report but do not fail images with blank alt text",
    )
    parser.add_argument(
        "--forbid-update-fields",
        action="store_true",
        help="fail when Word is configured to update fields at open",
    )
    return parser.parse_args()


def relationship_source(rels_name: str) -> tuple[str, str]:
    if rels_name == "_rels/.rels":
        return "", ""
    marker = "/_rels/"
    if marker not in rels_name or not rels_name.endswith(".rels"):
        raise WorkflowError(f"unrecognized relationships part: {rels_name}")
    prefix, rel_file = rels_name.split(marker, 1)
    source_file = rel_file[: -len(".rels")]
    source_part = f"{prefix}/{source_file}" if prefix else source_file
    return source_part, posixpath.dirname(source_part)


def resolve_internal_target(rels_name: str, target: str) -> str | None:
    target = unquote(target.split("#", 1)[0])
    if not target:
        return None
    _, base_dir = relationship_source(rels_name)
    if target.startswith("/"):
        return posixpath.normpath(target.lstrip("/"))
    return posixpath.normpath(posixpath.join(base_dir, target))


def xml_root(package: zipfile.ZipFile, name: str, errors: list[str]) -> ET.Element | None:
    try:
        return ET.fromstring(package.read(name))
    except (KeyError, ET.ParseError, UnicodeDecodeError) as exc:
        errors.append(f"cannot parse {name}: {exc}")
        return None


def bool_xml(value: str | None) -> bool:
    return value is None or value.lower() in TRUE_VALUES


def text_from_root(root: ET.Element) -> str:
    return " ".join(text.strip() for text in root.itertext() if text and text.strip())


def is_text_bearing_part(name: str) -> bool:
    if name in {"docProps/core.xml", "docProps/app.xml", "docProps/custom.xml"}:
        return True
    if name.startswith("customXml/") and name.endswith(".xml"):
        return True
    if not name.startswith("word/") or not name.endswith(".xml"):
        return False
    basename = posixpath.basename(name)
    return basename.startswith(
        ("document", "header", "footer", "footnotes", "endnotes", "comments")
    )


def token_locations(
    pattern: re.Pattern[str], text_by_part: dict[str, str]
) -> dict[str, list[str]]:
    locations: defaultdict[str, list[str]] = defaultdict(list)
    for name, text in text_by_part.items():
        for match in pattern.finditer(text):
            token = match.group(0)
            canonical = token[0].upper() + token[1:] if token[0].lower() == "d" else token.lower()
            if name not in locations[canonical]:
                locations[canonical].append(name)
    return dict(sorted(locations.items()))


def audit(path: Path, args: argparse.Namespace) -> dict:
    errors: list[str] = []
    warnings: list[str] = []
    info: list[str] = []
    if not path.is_file():
        raise WorkflowError(f"DOCX not found: {path}")
    if not zipfile.is_zipfile(path):
        raise WorkflowError("file is not a DOCX ZIP package")
    if args.expected_build:
        parse_build(args.expected_build)
    if args.expected_release:
        parse_release(args.expected_release)
    if args.require_stable_filename:
        try:
            validate_stable_docx_filename(path.name)
        except WorkflowError as exc:
            errors.append(str(exc))

    report: dict = {
        "schema_version": 2,
        "generated_at": utc_now(),
        "file": str(path.resolve()),
        "file_sha256": sha256_file(path),
        "expected_build": args.expected_build,
        "expected_release": args.expected_release,
        "expected_status": args.expected_status,
        "expected_status_label": (
            VISIBLE_STATUS_LABELS[args.expected_status] if args.expected_status else None
        ),
        "expected_text": args.expected_text,
        "forbid_development_builds": args.forbid_development_builds,
        "require_stable_filename": args.require_stable_filename,
    }

    with zipfile.ZipFile(path) as package:
        names = set(package.namelist())
        bad_member = package.testzip()
        if bad_member:
            errors.append(f"ZIP integrity failure in {bad_member}")

        xml_errors: list[str] = []
        external_relationships: list[dict[str, str]] = []
        external_hyperlinks: list[dict[str, str]] = []
        external_content: list[dict[str, str]] = []
        broken_internal: list[dict[str, str]] = []
        relationship_types: Counter[str] = Counter()

        for rels_name in sorted(name for name in names if name.endswith(".rels")):
            root = xml_root(package, rels_name, xml_errors)
            if root is None:
                continue
            for rel in root.findall(PR + "Relationship"):
                rel_type = rel.get("Type", "")
                rel_tail = rel_type.rsplit("/", 1)[-1] or "unknown"
                relationship_types[rel_tail] += 1
                row = {
                    "part": rels_name,
                    "id": rel.get("Id", ""),
                    "type": rel_tail,
                    "target": rel.get("Target", ""),
                }
                if rel.get("TargetMode", "").lower() == "external":
                    external_relationships.append(row)
                    (external_hyperlinks if rel_tail == "hyperlink" else external_content).append(row)
                    continue
                resolved = resolve_internal_target(rels_name, row["target"])
                if resolved and resolved not in names:
                    row["resolved_target"] = resolved
                    broken_internal.append(row)

        errors.extend(xml_errors)
        if broken_internal:
            errors.append(f"{len(broken_internal)} internal relationship target(s) are missing")
        if external_content:
            message = f"{len(external_content)} external content relationship(s) found"
            (warnings if args.allow_external_content else errors).append(message)

        image_counts = Counter()
        image_rows: list[dict[str, str]] = []
        missing_alt: list[dict[str, str]] = []
        linked_blips: list[dict[str, str]] = []
        ole_count = 0
        bookmarks = 0
        hyperlink_counts = Counter()
        tables = 0
        table_header_rows = 0
        heading_levels: list[int] = []
        field_chunks: list[dict[str, str]] = []
        field_names: Counter[str] = Counter()
        forbidden_fields: list[dict[str, str]] = []
        text_by_part: dict[str, str] = {}

        for name in sorted(n for n in names if n.endswith(".xml")):
            root = xml_root(package, name, errors)
            if root is None:
                continue
            if is_text_bearing_part(name):
                text_by_part[name] = text_from_root(root)

            if name.startswith("word/"):
                inline_nodes = root.findall(".//" + WP + "inline")
                anchor_nodes = root.findall(".//" + WP + "anchor")
                image_counts["inline"] += len(inline_nodes)
                image_counts["anchor"] += len(anchor_nodes)
                for kind, nodes in (("inline", inline_nodes), ("anchor", anchor_nodes)):
                    for node in nodes:
                        doc_pr = node.find(".//" + WP + "docPr")
                        alt = (doc_pr.get("descr", "") if doc_pr is not None else "").strip()
                        row = {
                            "part": name,
                            "kind": kind,
                            "name": doc_pr.get("name", "") if doc_pr is not None else "",
                            "alt_text": alt,
                        }
                        image_rows.append(row)
                        if not alt:
                            missing_alt.append(row)
                for blip in root.findall(".//" + A + "blip"):
                    link_id = blip.get(R + "link")
                    if link_id:
                        linked_blips.append({"part": name, "relationship_id": link_id})
                ole_count += sum(
                    1
                    for element in root.iter()
                    if element.tag.rsplit("}", 1)[-1] in {"OLEObject", "object"}
                )
                bookmarks += len(root.findall(".//" + W + "bookmarkStart"))
                for hyperlink in root.findall(".//" + W + "hyperlink"):
                    if hyperlink.get(R + "id"):
                        hyperlink_counts["external"] += 1
                    elif hyperlink.get(W + "anchor"):
                        hyperlink_counts["internal"] += 1
                    else:
                        hyperlink_counts["other"] += 1
                tables += len(root.findall(".//" + W + "tbl"))
                table_header_rows += len(root.findall(".//" + W + "tblHeader"))
                for paragraph in root.findall(".//" + W + "p"):
                    p_style = paragraph.find("./" + W + "pPr/" + W + "pStyle")
                    style_value = p_style.get(W + "val", "") if p_style is not None else ""
                    match = re.fullmatch(r"Heading\s*([1-9])", style_value, re.IGNORECASE)
                    if match:
                        heading_levels.append(int(match.group(1)))

                chunks = [
                    (element.text or "").strip()
                    for element in root.findall(".//" + W + "instrText")
                    if (element.text or "").strip()
                ]
                chunks.extend(
                    element.get(W + "instr", "").strip()
                    for element in root.findall(".//" + W + "fldSimple")
                    if element.get(W + "instr", "").strip()
                )
                for chunk in chunks:
                    row = {"part": name, "instruction": chunk}
                    field_chunks.append(row)
                    field_match = FIELD_NAME_RE.search(chunk.upper())
                    if field_match:
                        field_names[field_match.group(1)] += 1
                    if FORBIDDEN_FIELD_RE.search(chunk):
                        forbidden_fields.append(row)

        if linked_blips:
            message = f"{len(linked_blips)} externally linked picture reference(s) found"
            (warnings if args.allow_external_content else errors).append(message)
        if ole_count:
            message = f"{ole_count} OLE/object element(s) found"
            (warnings if args.allow_external_content else errors).append(message)
        if forbidden_fields:
            message = f"{len(forbidden_fields)} external-data field instruction(s) found"
            (warnings if args.allow_external_content else errors).append(message)
        if missing_alt:
            message = f"{len(missing_alt)} informative drawing(s) have blank alt text"
            (warnings if args.allow_missing_alt else errors).append(message)
        if image_counts["anchor"]:
            warnings.append(f"{image_counts['anchor']} floating image(s) require extra cross-renderer review")

        heading_skips: list[dict[str, int]] = []
        previous_level: int | None = None
        for index, level in enumerate(heading_levels):
            if previous_level is not None and level > previous_level + 1:
                heading_skips.append({"index": index, "from": previous_level, "to": level})
            previous_level = level
        if heading_skips:
            warnings.append(f"{len(heading_skips)} heading-level skip(s) found")

        update_fields_on_open = False
        if "word/settings.xml" in names:
            settings = xml_root(package, "word/settings.xml", errors)
            if settings is not None:
                update = settings.find(".//" + W + "updateFields")
                if update is not None:
                    update_fields_on_open = bool_xml(update.get(W + "val"))
        if update_fields_on_open:
            message = "Word is configured to update fields when the document opens"
            (errors if args.forbid_update_fields else warnings).append(message)

        build_locations = token_locations(BUILD_TOKEN_RE, text_by_part)
        release_locations = token_locations(RELEASE_TOKEN_RE, text_by_part)
        searchable_text = "\n".join(text_by_part.values()).casefold()
        if args.expected_build and args.expected_build not in build_locations:
            errors.append(f"expected development build {args.expected_build} was not found")
        if args.expected_release and args.expected_release not in release_locations:
            errors.append(f"expected release marker {args.expected_release} was not found")
        if args.forbid_development_builds and build_locations:
            errors.append(
                "development build token(s) remain in release document: "
                + ", ".join(build_locations)
            )
        status_label = VISIBLE_STATUS_LABELS.get(args.expected_status or "")
        if status_label and status_label.casefold() not in searchable_text:
            errors.append(f"expected visible status label was not found: {status_label}")
        missing_text = [value for value in args.expected_text if value.casefold() not in searchable_text]
        if missing_text:
            errors.append("expected text not found: " + "; ".join(missing_text))

        report.update(
            {
                "status": "fail" if errors else "pass",
                "errors": errors,
                "warnings": warnings,
                "info": info,
                "package": {
                    "part_count": len(names),
                    "broken_internal_relationships": broken_internal,
                    "relationship_type_counts": dict(sorted(relationship_types.items())),
                    "external_relationships": external_relationships,
                    "external_hyperlinks": external_hyperlinks,
                    "external_content_relationships": external_content,
                },
                "images": {
                    "counts": dict(image_counts),
                    "rows": image_rows,
                    "missing_alt_text": missing_alt,
                    "linked_blips": linked_blips,
                    "ole_object_count": ole_count,
                },
                "navigation": {
                    "bookmark_count": bookmarks,
                    "hyperlink_counts": dict(hyperlink_counts),
                    "heading_levels": heading_levels,
                    "heading_skips": heading_skips,
                },
                "tables": {"count": tables, "header_row_flags": table_header_rows},
                "fields": {
                    "counts": dict(sorted(field_names.items())),
                    "instructions": field_chunks,
                    "forbidden_external_data": forbidden_fields,
                    "update_fields_on_open": update_fields_on_open,
                },
                "version_markers": {
                    "development_build_locations": build_locations,
                    "release_locations": release_locations,
                    "visible_status_label_found": bool(status_label and status_label.casefold() in searchable_text),
                    "missing_expected_text": missing_text,
                },
            }
        )
    return report


def main() -> int:
    args = parse_args()
    path = Path(args.docx).resolve()
    report = audit(path, args)
    if args.json_path:
        save_json_atomic(Path(args.json_path).resolve(), report)
    print(json.dumps(report, indent=2, sort_keys=False))
    return 1 if report["status"] != "pass" else 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except WorkflowError as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(2)
