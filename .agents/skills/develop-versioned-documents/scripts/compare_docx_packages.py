#!/usr/bin/env python3
"""Compare two DOCX packages and report structural and extracted-text changes."""

from __future__ import annotations

import argparse
import difflib
import fnmatch
import hashlib
import json
import posixpath
import sys
import zipfile
from collections import Counter
from pathlib import Path
from xml.etree import ElementTree as ET

from _common import WorkflowError, save_json_atomic, sha256_file, utc_now


W_NS = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
W_P = "{" + W_NS + "}p"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("base", help="current controlled base DOCX")
    parser.add_argument("candidate", help="candidate DOCX")
    parser.add_argument("--json", dest="json_path", help="write report to this JSON file")
    parser.add_argument(
        "--allow-part",
        action="append",
        default=[],
        help="glob for an allowed changed/added/removed package part; repeat as needed",
    )
    parser.add_argument(
        "--max-diff-lines", type=int, default=300, help="maximum unified text-diff lines to retain"
    )
    return parser.parse_args()


def member_hash(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def read_package(path: Path) -> tuple[dict[str, str], dict[str, bytes]]:
    if not path.is_file():
        raise WorkflowError(f"DOCX not found: {path}")
    if not zipfile.is_zipfile(path):
        raise WorkflowError(f"not a DOCX ZIP package: {path}")
    with zipfile.ZipFile(path) as package:
        bad = package.testzip()
        if bad:
            raise WorkflowError(f"ZIP integrity failure in {path}: {bad}")
        data = {name: package.read(name) for name in package.namelist()}
    hashes = {name: member_hash(payload) for name, payload in data.items()}
    return hashes, data


def category(name: str) -> str:
    if name.startswith("word/media/"):
        return "media"
    if name.endswith(".rels"):
        return "relationships"
    if name.startswith("word/header"):
        return "headers"
    if name.startswith("word/footer"):
        return "footers"
    if name == "word/document.xml":
        return "main_document"
    if name in {"word/styles.xml", "word/stylesWithEffects.xml", "word/numbering.xml"}:
        return "styles_numbering"
    if name in {"word/settings.xml", "word/webSettings.xml", "word/fontTable.xml"}:
        return "settings"
    if name.startswith("docProps/"):
        return "metadata"
    if name.startswith("customXml/"):
        return "custom_xml"
    if name == "[Content_Types].xml":
        return "content_types"
    return "other"


def is_visible_text_part(name: str) -> bool:
    if not name.startswith("word/") or not name.endswith(".xml"):
        return False
    base = posixpath.basename(name)
    return base.startswith(("document", "header", "footer", "footnotes", "endnotes", "comments"))


def extract_text(parts: dict[str, bytes]) -> list[str]:
    lines: list[str] = []
    for name in sorted(parts):
        if not is_visible_text_part(name):
            continue
        try:
            root = ET.fromstring(parts[name])
        except ET.ParseError:
            continue
        paragraphs = root.findall(".//" + W_P)
        if not paragraphs and root.tag == W_P:
            paragraphs = [root]
        for paragraph in paragraphs:
            text = " ".join(
                piece.strip() for piece in paragraph.itertext() if piece and piece.strip()
            )
            if text:
                lines.append(f"[{name}] {text}")
    return lines


def allowed(name: str, patterns: list[str]) -> bool:
    return any(fnmatch.fnmatchcase(name, pattern) for pattern in patterns)


def main() -> int:
    args = parse_args()
    if args.max_diff_lines < 1:
        raise WorkflowError("--max-diff-lines must be positive")
    base = Path(args.base).resolve()
    candidate = Path(args.candidate).resolve()
    base_hashes, base_parts = read_package(base)
    candidate_hashes, candidate_parts = read_package(candidate)

    base_names = set(base_hashes)
    candidate_names = set(candidate_hashes)
    added = sorted(candidate_names - base_names)
    removed = sorted(base_names - candidate_names)
    changed = sorted(
        name for name in base_names & candidate_names if base_hashes[name] != candidate_hashes[name]
    )
    all_differences = added + removed + changed
    unexpected = (
        sorted(name for name in all_differences if not allowed(name, args.allow_part))
        if args.allow_part
        else []
    )

    categories = Counter(category(name) for name in all_differences)
    base_text = extract_text(base_parts)
    candidate_text = extract_text(candidate_parts)
    full_diff = list(
        difflib.unified_diff(
            base_text,
            candidate_text,
            fromfile=base.name,
            tofile=candidate.name,
            lineterm="",
        )
    )
    truncated = len(full_diff) > args.max_diff_lines
    text_diff = full_diff[: args.max_diff_lines]

    report = {
        "schema_version": 1,
        "generated_at": utc_now(),
        "status": "fail" if unexpected else "pass",
        "base": str(base),
        "candidate": str(candidate),
        "base_sha256": sha256_file(base),
        "candidate_sha256": sha256_file(candidate),
        "summary": {
            "added_count": len(added),
            "removed_count": len(removed),
            "changed_count": len(changed),
            "category_counts": dict(sorted(categories.items())),
            "review_required": bool(all_differences),
        },
        "added_parts": added,
        "removed_parts": removed,
        "changed_parts": changed,
        "media_changes": [name for name in all_differences if name.startswith("word/media/")],
        "allowed_part_patterns": args.allow_part,
        "unexpected_parts": unexpected,
        "text_diff": text_diff,
        "text_diff_truncated": truncated,
    }
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
