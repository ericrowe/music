#!/usr/bin/env python3
"""Register the first reviewed development build in a project with no current DOCX."""

from __future__ import annotations

import argparse
import os
import shutil
import sys
import tempfile
import zipfile
from pathlib import Path

from _common import (
    WorkflowError,
    build_id,
    load_project,
    parse_build,
    print_result,
    relative_to_project,
    save_json_atomic,
    sha256_file,
    utc_date,
    utc_now,
    validate_one_line,
    write_text_atomic,
)
from _evidence import read_report, validate_audit, validate_visual


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("project", help="document project directory")
    parser.add_argument("docx", help="reviewed initial DOCX using the stable project filename")
    parser.add_argument("--build", help="internal build ID; defaults to the next reserved D-number")
    parser.add_argument("--audit-report", required=True, help="JSON from audit_docx.py")
    parser.add_argument("--visual-review", required=True, help="JSON from record_visual_review.py")
    parser.add_argument("--summary", required=True, help="one-line build description")
    parser.add_argument(
        "--approve-audit-warnings",
        action="store_true",
        help="accept explained non-error audit warnings",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    summary = validate_one_line(args.summary)
    project_dir = Path(args.project).resolve()
    document = Path(args.docx).resolve()
    manifest = load_project(project_dir)
    if manifest["document"].get("current") is not None:
        raise WorkflowError("a current document is already registered")
    if manifest["document"].get("candidate") is not None:
        raise WorkflowError("an active candidate is already registered")
    if not document.is_file():
        raise WorkflowError(f"initial DOCX not found: {document}")
    if document.suffix.lower() != ".docx" or not zipfile.is_zipfile(document):
        raise WorkflowError("initial file is not a DOCX package")
    filename = manifest["project"]["document_filename"]
    if document.name != filename:
        raise WorkflowError(f"initial DOCX must use the stable filename: {filename}")

    expected_number = manifest["versioning"]["next_build_number"]
    build = args.build or build_id(expected_number)
    if parse_build(build) != expected_number:
        raise WorkflowError(f"initial build must be the next reserved build D{expected_number}")
    document_hash = sha256_file(document)

    audit_path = Path(args.audit_report).resolve()
    visual_path = Path(args.visual_review).resolve()
    audit = read_report(audit_path, "audit report")
    visual = read_report(visual_path, "visual review")
    validate_audit(
        audit,
        document_hash,
        expected_build=build,
        expected_release="v0",
        expected_status="manual_review_required",
        forbid_development_builds=False,
        expected_text=[summary],
        approve_warnings=args.approve_audit_warnings,
    )
    validate_visual(visual, document_hash)

    snapshot = project_dir / "documents" / "builds" / build / filename
    current_path = project_dir / "documents" / "current" / filename
    if snapshot.exists() or current_path.exists():
        raise WorkflowError("initial controlled destination already exists")
    snapshot.parent.mkdir(parents=True, exist_ok=True)
    current_path.parent.mkdir(parents=True, exist_ok=True)

    audit_relative = relative_to_project(project_dir, audit_path)
    visual_relative = relative_to_project(project_dir, visual_path)
    changelog_path = project_dir / "CHANGELOG.md"
    change_path = project_dir / "changes" / f"{build}.md"
    if change_path.exists():
        raise WorkflowError(f"initial change record already exists: {change_path}")
    old_changelog = changelog_path.read_text(encoding="utf-8")
    placeholder = "| - | - | v0 | Initialized | Project initialized without a document | - |"
    clean_changelog = old_changelog.replace(placeholder + "\n", "")
    safe_summary = summary.replace("|", "\\|")
    new_changelog = (
        clean_changelog.rstrip()
        + "\n"
        + f"| {utc_date()} | {build} | v0 | Manual review required | {safe_summary} | `{document_hash}` |\n"
    )
    change_text = f"""# Initial controlled build {build}

- **Process state:** Manual review required
- **Visible marking:** `MANUAL REVIEW REQUIRED — NOT RELEASED`
- **Published:** {utc_date()}
- **Release:** v0
- **DOCX SHA-256:** `{document_hash}`
- **Audit report:** `{audit_relative}`
- **Visual review:** `{visual_relative}`
- **Summary:** {summary}

This is the first controlled development build. No base-to-candidate comparison applies.
"""

    descriptor, staged_name = tempfile.mkstemp(
        prefix=f".{filename}.", suffix=".pending", dir=str(current_path.parent)
    )
    os.close(descriptor)
    staged = Path(staged_name)
    try:
        shutil.copy2(document, snapshot)
        shutil.copy2(document, staged)
        if sha256_file(snapshot) != document_hash or sha256_file(staged) != document_hash:
            raise WorkflowError("initial controlled copy failed digest verification")
        os.replace(staged, current_path)
        published_at = utc_now()
        qa = {"audit": audit_relative, "visual_review": visual_relative}
        manifest["document"]["current"] = {
            "build": build,
            "release": "v0",
            "process_state": "manual_review_required",
            "visible_status": "manual_review_required",
            "file": relative_to_project(project_dir, current_path),
            "snapshot_file": relative_to_project(project_dir, snapshot),
            "sha256": document_hash,
            "published_at": published_at,
            "qa": qa,
        }
        manifest["versioning"]["next_build_number"] = expected_number + 1
        manifest.setdefault("history", []).append(
            {
                "id": build,
                "kind": "development_build",
                "release": "v0",
                "status": "manual_review_required",
                "date": utc_date(),
                "published_for_review_at": published_at,
                "file": relative_to_project(project_dir, snapshot),
                "sha256": document_hash,
                "summary": summary,
                "qa": qa,
            }
        )
        write_text_atomic(changelog_path, new_changelog)
        write_text_atomic(change_path, change_text)
        save_json_atomic(project_dir / "project.json", manifest)
    except Exception:
        if staged.exists():
            staged.unlink()
        if snapshot.exists():
            snapshot.unlink()
        if current_path.exists():
            current_path.unlink()
        write_text_atomic(changelog_path, old_changelog)
        if change_path.exists():
            change_path.unlink()
        raise

    print_result(
        {
            "status": "manual_review_required",
            "build": build,
            "release": "v0",
            "file": str(current_path),
            "snapshot": str(snapshot),
            "sha256": document_hash,
            "next_build": f"D{manifest['versioning']['next_build_number']}",
        }
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except WorkflowError as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(2)
