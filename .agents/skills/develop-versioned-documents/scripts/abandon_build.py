#!/usr/bin/env python3
"""Abandon an active development build without reusing its D-number."""

from __future__ import annotations

import argparse
import shutil
import sys
from pathlib import Path

from _common import (
    WorkflowError,
    load_project,
    print_result,
    resolve_project_path,
    save_json_atomic,
    utc_date,
    utc_now,
    validate_one_line,
    write_text_atomic,
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("project", help="document project directory")
    parser.add_argument("--reason", required=True, help="one-line reason the build was abandoned")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    reason = validate_one_line(args.reason, "reason")
    project_dir = Path(args.project).resolve()
    manifest = load_project(project_dir)
    candidate = manifest["document"].get("candidate")
    if not candidate:
        raise WorkflowError("no active candidate is registered")

    change_path = resolve_project_path(project_dir, candidate["change_record"])
    changelog_path = project_dir / "CHANGELOG.md"
    old_change = change_path.read_text(encoding="utf-8")
    old_changelog = changelog_path.read_text(encoding="utf-8")
    safe_reason = reason.replace("|", "\\|")
    new_change = (
        old_change.rstrip()
        + "\n\n## Disposition\n\n"
        + f"**Process state:** Abandoned  \n**Date:** {utc_date()}  \n"
        + f"**Reason:** {reason}\n"
    )
    new_changelog = (
        old_changelog.rstrip()
        + "\n"
        + f"| {utc_date()} | {candidate['build']} | {candidate['target_release']} | Abandoned | "
        + f"{safe_reason} | - |\n"
    )

    working_path = resolve_project_path(project_dir, candidate["file"])
    abandoned_path = (
        project_dir
        / "documents"
        / "abandoned"
        / candidate["build"]
        / manifest["project"]["document_filename"]
    )
    if not working_path.is_file():
        raise WorkflowError(f"working candidate is missing: {working_path}")
    if abandoned_path.exists():
        raise WorkflowError(f"abandoned build destination already exists: {abandoned_path}")
    abandoned_path.parent.mkdir(parents=True, exist_ok=True)

    for entry in reversed(manifest.get("history", [])):
        if entry.get("id") == candidate["build"] and entry.get("kind") == "development_build":
            entry.update(
                {
                    "status": "abandoned",
                    "abandoned_at": utc_now(),
                    "reason": reason,
                    "file": abandoned_path.relative_to(project_dir).as_posix(),
                }
            )
            break
    manifest["document"]["candidate"] = None

    try:
        shutil.move(str(working_path), str(abandoned_path))
        write_text_atomic(change_path, new_change)
        write_text_atomic(changelog_path, new_changelog)
        save_json_atomic(project_dir / "project.json", manifest)
    except Exception:
        if abandoned_path.exists() and not working_path.exists():
            shutil.move(str(abandoned_path), str(working_path))
        write_text_atomic(change_path, old_change)
        write_text_atomic(changelog_path, old_changelog)
        raise

    print_result(
        {
            "status": "abandoned",
            "build": candidate["build"],
            "working_file_preserved": str(abandoned_path),
            "next_build": f"D{manifest['versioning']['next_build_number']}",
            "build_number_reusable": False,
        }
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except WorkflowError as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(2)
