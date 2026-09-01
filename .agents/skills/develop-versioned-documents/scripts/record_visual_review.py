#!/usr/bin/env python3
"""Record a digest-bound all-pages visual review for a rendered DOCX."""

from __future__ import annotations

import argparse
import json
import re
import struct
import sys
from pathlib import Path

from _common import WorkflowError, save_json_atomic, sha256_file, utc_now


PAGE_RE = re.compile(r"^page-([1-9][0-9]*)\.png$")
PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("docx", help="rendered candidate DOCX")
    parser.add_argument("render_dir", help="directory containing page-<N>.png files")
    parser.add_argument("--output", required=True, help="JSON visual-review record")
    parser.add_argument("--reviewer", required=True, help="reviewer or agent identity")
    parser.add_argument("--expected-page-count", type=int, help="required page count")
    parser.add_argument("--changed-pages", default="", help="comma-separated changed page numbers")
    parser.add_argument("--notes", default="", help="review notes")
    parser.add_argument(
        "--all-pages-reviewed",
        action="store_true",
        help="attest that every page was inspected at 100 percent after the final edit",
    )
    parser.add_argument(
        "--changed-figures-reviewed-at-200",
        action="store_true",
        help="attest that changed figures were also checked at 200 percent",
    )
    return parser.parse_args()


def png_dimensions(path: Path) -> tuple[int, int]:
    with path.open("rb") as stream:
        header = stream.read(24)
    if len(header) < 24 or header[:8] != PNG_SIGNATURE or header[12:16] != b"IHDR":
        raise WorkflowError(f"not a valid PNG page render: {path}")
    return struct.unpack(">II", header[16:24])


def parse_changed_pages(raw: str) -> list[int]:
    if not raw.strip():
        return []
    pages: list[int] = []
    for value in raw.split(","):
        value = value.strip()
        if not value.isdigit() or int(value) < 1:
            raise WorkflowError(f"invalid changed page number: {value!r}")
        pages.append(int(value))
    return sorted(set(pages))


def main() -> int:
    args = parse_args()
    docx = Path(args.docx).resolve()
    render_dir = Path(args.render_dir).resolve()
    if not docx.is_file():
        raise WorkflowError(f"DOCX not found: {docx}")
    if not render_dir.is_dir():
        raise WorkflowError(f"render directory not found: {render_dir}")

    page_files: dict[int, Path] = {}
    for path in render_dir.iterdir():
        match = PAGE_RE.fullmatch(path.name)
        if match:
            page_files[int(match.group(1))] = path
    if not page_files:
        raise WorkflowError("no page-<N>.png files found")
    highest = max(page_files)
    expected_sequence = list(range(1, highest + 1))
    missing = [page for page in expected_sequence if page not in page_files]
    errors: list[str] = []
    if missing:
        errors.append("missing rendered pages: " + ", ".join(map(str, missing)))
    if args.expected_page_count is not None and highest != args.expected_page_count:
        errors.append(
            f"render contains {highest} pages; expected {args.expected_page_count}"
        )

    dimensions: dict[str, dict[str, int]] = {}
    for page, path in sorted(page_files.items()):
        width, height = png_dimensions(path)
        dimensions[str(page)] = {"width": width, "height": height}
        if width < 1 or height < 1:
            errors.append(f"page {page} has invalid dimensions")

    changed_pages = parse_changed_pages(args.changed_pages)
    outside = [page for page in changed_pages if page not in page_files]
    if outside:
        errors.append("changed page(s) absent from render: " + ", ".join(map(str, outside)))
    if not args.all_pages_reviewed:
        errors.append("all-pages 100 percent review was not attested")
    if changed_pages and not args.changed_figures_reviewed_at_200:
        errors.append("changed-page 200 percent figure review was not attested")

    report = {
        "schema_version": 1,
        "generated_at": utc_now(),
        "status": "fail" if errors else "pass",
        "errors": errors,
        "file": str(docx),
        "file_sha256": sha256_file(docx),
        "render_dir": str(render_dir),
        "page_count": highest,
        "page_numbers": sorted(page_files),
        "page_dimensions": dimensions,
        "all_pages_reviewed": args.all_pages_reviewed,
        "changed_pages": changed_pages,
        "changed_figures_reviewed_at-200": args.changed_figures_reviewed_at_200,
        "reviewer": args.reviewer,
        "notes": args.notes,
    }
    save_json_atomic(Path(args.output).resolve(), report)
    print(json.dumps(report, indent=2, sort_keys=False))
    return 1 if report["status"] != "pass" else 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except WorkflowError as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(2)
