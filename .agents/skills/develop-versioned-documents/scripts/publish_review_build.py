#!/usr/bin/env python3
"""Promote a QA-bound candidate to the stable current DOCX for manual review."""

from __future__ import annotations

import os
import shutil
import sys
import tempfile
from pathlib import Path

from _common import (
    WorkflowError,
    load_project,
    print_result,
    relative_to_project,
    resolve_project_path,
    save_json_atomic,
    sha256_file,
    utc_date,
    utc_now,
    write_text_atomic,
)
from _evidence import read_report, validate_audit, validate_diff, validate_visual


def parse_args():
    import argparse

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("project", help="document project directory")
    parser.add_argument(
        "--approve-audit-warnings",
        action="store_true",
        help="accept explained non-error audit warnings",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    project_dir = Path(args.project).resolve()
    manifest = load_project(project_dir)
    current = manifest["document"].get("current")
    candidate = manifest["document"].get("candidate")
    if not current:
        raise WorkflowError("no current controlled base is registered")
    if not candidate:
        raise WorkflowError("no active candidate is registered")
    if candidate.get("prepare_release"):
        raise WorkflowError("release-preparation builds must use release_document.py")
    if candidate.get("process_state") != "manual_review_required":
        raise WorkflowError("candidate is not in manual_review_required state")

    base_path = resolve_project_path(project_dir, current["file"])
    candidate_path = resolve_project_path(project_dir, candidate["file"])
    if not base_path.is_file() or not candidate_path.is_file():
        raise WorkflowError("current base or candidate file is missing")
    base_hash = sha256_file(base_path)
    candidate_hash = sha256_file(candidate_path)
    if base_hash != current["sha256"]:
        raise WorkflowError("current base changed after candidate creation")
    if candidate["base_sha256"] != base_hash or candidate["base_build"] != current["build"]:
        raise WorkflowError("candidate is not based on the current controlled document")

    qa = candidate.get("qa") or {}
    try:
        audit_path = resolve_project_path(project_dir, qa["audit"])
        diff_path = resolve_project_path(project_dir, qa["diff"])
        visual_path = resolve_project_path(project_dir, qa["visual_review"])
    except KeyError as exc:
        raise WorkflowError("candidate is missing bound QA evidence") from exc
    audit = read_report(audit_path, "audit report")
    diff = read_report(diff_path, "diff report")
    visual = read_report(visual_path, "visual review")
    validate_audit(
        audit,
        candidate_hash,
        expected_build=candidate["build"],
        expected_release=candidate["target_release"],
        expected_status="manual_review_required",
        forbid_development_builds=False,
        expected_text=[candidate["summary"]],
        approve_warnings=args.approve_audit_warnings,
    )
    validate_diff(diff, base_hash, candidate_hash)
    validate_visual(visual, candidate_hash)

    filename = manifest["project"]["document_filename"]
    snapshot = project_dir / "documents" / "builds" / candidate["build"] / filename
    current_path = project_dir / "documents" / "current" / filename
    if snapshot.exists():
        raise WorkflowError(f"build snapshot already exists: {snapshot}")
    snapshot.parent.mkdir(parents=True, exist_ok=True)
    current_path.parent.mkdir(parents=True, exist_ok=True)

    changelog_path = project_dir / "CHANGELOG.md"
    change_path = resolve_project_path(project_dir, candidate["change_record"])
    old_changelog = changelog_path.read_text(encoding="utf-8")
    old_change = change_path.read_text(encoding="utf-8")
    safe_summary = candidate["summary"].replace("|", "\\|")
    new_changelog = (
        old_changelog.rstrip()
        + "\n"
        + f"| {utc_date()} | {candidate['build']} | {candidate['target_release']} | Manual review required | "
        + f"{safe_summary} | `{candidate_hash}` |\n"
    )
    new_change = (
        old_change.rstrip()
        + "\n\n## Review publication\n\n"
        + f"**Process state:** Manual review required  \n"
        + f"**Published:** {utc_date()}  \n"
        + f"**DOCX SHA-256:** `{candidate_hash}`  \n"
        + f"**Audit report:** `{qa['audit']}`  \n"
        + f"**Diff report:** `{qa['diff']}`  \n"
        + f"**Visual review:** `{qa['visual_review']}`  \n"
        + f"**Summary:** {candidate['summary']}\n"
    )

    descriptor, staged_name = tempfile.mkstemp(
        prefix=f".{filename}.", suffix=".pending", dir=str(current_path.parent)
    )
    os.close(descriptor)
    staged = Path(staged_name)
    descriptor, backup_name = tempfile.mkstemp(
        prefix=f".{filename}.", suffix=".backup", dir=str(current_path.parent)
    )
    os.close(descriptor)
    backup = Path(backup_name)
    try:
        shutil.copy2(candidate_path, snapshot)
        if sha256_file(snapshot) != candidate_hash:
            raise WorkflowError("build snapshot failed digest verification")
        shutil.copy2(candidate_path, staged)
        shutil.copy2(current_path, backup)
        if sha256_file(staged) != candidate_hash:
            raise WorkflowError("staged current copy failed digest verification")
        os.replace(staged, current_path)

        published_at = utc_now()
        manifest["document"]["current"] = {
            "build": candidate["build"],
            "release": candidate["target_release"],
            "process_state": "manual_review_required",
            "visible_status": "manual_review_required",
            "file": relative_to_project(project_dir, current_path),
            "snapshot_file": relative_to_project(project_dir, snapshot),
            "sha256": candidate_hash,
            "published_at": published_at,
            "base_build": current["build"],
            "qa": qa,
        }
        manifest["document"]["candidate"] = None
        for entry in reversed(manifest.get("history", [])):
            if entry.get("id") == candidate["build"] and entry.get("kind") == "development_build":
                entry.update(
                    {
                        "status": "manual_review_required",
                        "published_for_review_at": published_at,
                        "file": relative_to_project(project_dir, snapshot),
                        "sha256": candidate_hash,
                        "qa": qa,
                    }
                )
                break

        write_text_atomic(changelog_path, new_changelog)
        write_text_atomic(change_path, new_change)
        save_json_atomic(project_dir / "project.json", manifest)
    except Exception:
        if staged.exists():
            staged.unlink()
        if backup.exists():
            os.replace(backup, current_path)
        if snapshot.exists():
            snapshot.unlink()
        write_text_atomic(changelog_path, old_changelog)
        write_text_atomic(change_path, old_change)
        raise
    else:
        os.unlink(candidate_path)
        if candidate_path.exists():
            raise WorkflowError("stable working file was not cleared after promotion")
        backup.unlink(missing_ok=True)

    print_result(
        {
            "status": "manual_review_required",
            "build": candidate["build"],
            "release": candidate["target_release"],
            "file": str(current_path),
            "snapshot": str(snapshot),
            "sha256": candidate_hash,
            "stable_filename": filename,
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
