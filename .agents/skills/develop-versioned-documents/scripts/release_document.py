#!/usr/bin/env python3
"""Publish a release candidate after final released-state QA and history compression."""

from __future__ import annotations

import argparse
import os
import shutil
import sys
import tempfile
from pathlib import Path

from _common import (
    WorkflowError,
    load_project,
    next_release,
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


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("project", help="document project directory")
    parser.add_argument("--audit-report", required=True, help="released-state JSON from audit_docx.py")
    parser.add_argument("--diff-report", required=True, help="JSON from compare_docx_packages.py")
    parser.add_argument("--visual-review", required=True, help="released-state visual-review JSON")
    parser.add_argument(
        "--approve-diff",
        action="store_true",
        help="attest that every reported package/text/visual difference is intended or explained",
    )
    parser.add_argument(
        "--approve-audit-warnings",
        action="store_true",
        help="accept explained non-error audit warnings",
    )
    return parser.parse_args()


def copy_verified(source: Path, destination: Path, expected_hash: str) -> None:
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, destination)
    if sha256_file(destination) != expected_hash:
        raise WorkflowError(f"copied file failed digest verification: {destination}")


def main() -> int:
    args = parse_args()
    if not args.approve_diff:
        raise WorkflowError("--approve-diff is required after reviewing the difference set")
    project_dir = Path(args.project).resolve()
    manifest = load_project(project_dir)
    current = manifest["document"].get("current")
    candidate = manifest["document"].get("candidate")
    if not current or not candidate:
        raise WorkflowError("a current base and active release candidate are required")
    if not candidate.get("prepare_release"):
        raise WorkflowError("candidate was not started with --prepare-release")
    if candidate.get("process_state") != "release_candidate":
        raise WorkflowError("candidate is not in release_candidate state")
    target_release = candidate["target_release"]
    if target_release != manifest["versioning"]["next_release"]:
        raise WorkflowError("candidate does not target the next reserved release")
    summary = candidate["summary"]
    if manifest["versioning"]["current_release"] == "v0" and summary != "Initial release":
        raise WorkflowError("the first public release summary must be exactly: Initial release")

    base_path = resolve_project_path(project_dir, current["file"])
    candidate_path = resolve_project_path(project_dir, candidate["file"])
    if not base_path.is_file() or not candidate_path.is_file():
        raise WorkflowError("current base or release candidate file is missing")
    base_hash = sha256_file(base_path)
    candidate_hash = sha256_file(candidate_path)
    if base_hash != current["sha256"]:
        raise WorkflowError("current base changed after release preparation began")
    if candidate["base_sha256"] != base_hash or candidate["base_build"] != current["build"]:
        raise WorkflowError("release candidate is not based on the current controlled document")

    audit_path = Path(args.audit_report).resolve()
    diff_path = Path(args.diff_report).resolve()
    visual_path = Path(args.visual_review).resolve()
    audit = read_report(audit_path, "audit report")
    diff = read_report(diff_path, "diff report")
    visual = read_report(visual_path, "visual review")
    validate_audit(
        audit,
        candidate_hash,
        expected_build=None,
        expected_release=target_release,
        expected_status="released",
        forbid_development_builds=True,
        expected_text=[summary],
        approve_warnings=args.approve_audit_warnings,
    )
    validate_diff(diff, base_hash, candidate_hash)
    validate_visual(visual, candidate_hash)

    filename = manifest["project"]["document_filename"]
    snapshot = project_dir / "documents" / "builds" / candidate["build"] / filename
    release_path = project_dir / "documents" / "releases" / target_release / filename
    current_path = project_dir / "documents" / "current" / filename
    for destination in (snapshot, release_path):
        if destination.exists():
            raise WorkflowError(f"immutable destination already exists: {destination}")

    changelog_path = project_dir / "CHANGELOG.md"
    change_path = resolve_project_path(project_dir, candidate["change_record"])
    old_changelog = changelog_path.read_text(encoding="utf-8")
    old_change = change_path.read_text(encoding="utf-8")
    safe_summary = summary.replace("|", "\\|")
    previous_release = manifest["versioning"]["current_release"]
    new_changelog = (
        old_changelog.rstrip()
        + "\n"
        + f"| {utc_date()} | {candidate['build']} | {target_release} | Release preparation | {safe_summary} | `{candidate_hash}` |\n"
        + f"| {utc_date()} | {target_release} | {previous_release} | Released | {safe_summary} | `{candidate_hash}` |\n"
    )
    qa = {
        "audit": relative_to_project(project_dir, audit_path),
        "diff": relative_to_project(project_dir, diff_path),
        "visual_review": relative_to_project(project_dir, visual_path),
    }
    new_change = (
        old_change.rstrip()
        + "\n\n## Release disposition\n\n"
        + f"**Process state:** Released  \n"
        + f"**Release:** {target_release}  \n"
        + f"**Released:** {utc_date()}  \n"
        + f"**DOCX SHA-256:** `{candidate_hash}`  \n"
        + f"**Audit report:** `{qa['audit']}`  \n"
        + f"**Diff report:** `{qa['diff']}`  \n"
        + f"**Visual review:** `{qa['visual_review']}`  \n"
        + f"**Compressed history summary:** {summary}\n"
    )

    current_path.parent.mkdir(parents=True, exist_ok=True)
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
        copy_verified(candidate_path, snapshot, candidate_hash)
        copy_verified(candidate_path, release_path, candidate_hash)
        shutil.copy2(candidate_path, staged)
        shutil.copy2(current_path, backup)
        if sha256_file(staged) != candidate_hash:
            raise WorkflowError("staged released copy failed digest verification")
        os.replace(staged, current_path)

        released_at = utc_now()
        manifest["document"]["current"] = {
            "build": candidate["build"],
            "release": target_release,
            "process_state": "released",
            "visible_status": "released",
            "file": relative_to_project(project_dir, current_path),
            "snapshot_file": relative_to_project(project_dir, snapshot),
            "release_file": relative_to_project(project_dir, release_path),
            "sha256": candidate_hash,
            "released_at": released_at,
            "base_build": current["build"],
            "qa": qa,
        }
        manifest["document"]["candidate"] = None
        manifest["versioning"]["current_release"] = target_release
        manifest["versioning"]["next_release"] = next_release(target_release)
        for entry in reversed(manifest.get("history", [])):
            if entry.get("id") == candidate["build"] and entry.get("kind") == "development_build":
                entry.update(
                    {
                        "status": "released",
                        "released_as": target_release,
                        "released_at": released_at,
                        "file": relative_to_project(project_dir, snapshot),
                        "sha256": candidate_hash,
                        "qa": qa,
                    }
                )
                break
        release_entry = {
            "id": target_release,
            "kind": "release",
            "base_release": previous_release,
            "build": candidate["build"],
            "status": "released",
            "date": utc_date(),
            "released_at": released_at,
            "file": relative_to_project(project_dir, release_path),
            "sha256": candidate_hash,
            "summary": summary,
            "qa": qa,
        }
        manifest.setdefault("history", []).append(release_entry)
        manifest.setdefault("releases", []).append(
            {
                "version": target_release,
                "date": utc_date(),
                "file": release_entry["file"],
                "sha256": candidate_hash,
                "summary": summary,
            }
        )
        write_text_atomic(changelog_path, new_changelog)
        write_text_atomic(change_path, new_change)
        save_json_atomic(project_dir / "project.json", manifest)
    except Exception:
        if staged.exists():
            staged.unlink()
        if backup.exists():
            os.replace(backup, current_path)
        for destination in (snapshot, release_path):
            if destination.exists():
                destination.unlink()
        write_text_atomic(changelog_path, old_changelog)
        write_text_atomic(change_path, old_change)
        raise
    else:
        os.unlink(candidate_path)
        if candidate_path.exists():
            raise WorkflowError("stable working file was not cleared after release")
        backup.unlink(missing_ok=True)

    print_result(
        {
            "status": "released",
            "release": target_release,
            "build": candidate["build"],
            "file": str(current_path),
            "release_snapshot": str(release_path),
            "sha256": candidate_hash,
            "summary": summary,
            "stable_filename": filename,
            "next_release": manifest["versioning"]["next_release"],
        }
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except WorkflowError as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(2)
