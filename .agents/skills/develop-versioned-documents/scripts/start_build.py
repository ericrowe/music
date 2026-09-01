#!/usr/bin/env python3
"""Create the next internal development build from the hash-verified current DOCX."""

from __future__ import annotations

import argparse
import shutil
import sys
from pathlib import Path

from _common import (
    WorkflowError,
    build_id,
    load_project,
    print_result,
    relative_to_project,
    resolve_project_path,
    save_json_atomic,
    sha256_file,
    utc_date,
    utc_now,
    validate_one_line,
    write_text_atomic,
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("project", help="document project directory")
    parser.add_argument("--summary", required=True, help="one-line scope summary")
    parser.add_argument(
        "--prepare-release",
        action="store_true",
        help="target the next public release and prepare compressed in-document history",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    summary = validate_one_line(args.summary)
    project_dir = Path(args.project).resolve()
    manifest = load_project(project_dir)
    if (
        args.prepare_release
        and manifest["versioning"]["current_release"] == "v0"
        and summary.casefold() != "initial release"
    ):
        raise WorkflowError("the first public release summary must be exactly: Initial release")
    document_state = manifest["document"]
    if document_state.get("candidate") is not None:
        candidate = document_state["candidate"]
        raise WorkflowError(
            f"candidate {candidate.get('build')} is already active; publish or abandon it first"
        )
    current = document_state.get("current")
    if not current:
        raise WorkflowError("no current controlled document is registered")

    current_path = resolve_project_path(project_dir, current["file"])
    if not current_path.is_file():
        raise WorkflowError(f"current document is missing: {current_path}")
    current_hash = sha256_file(current_path)
    if current_hash != current["sha256"]:
        raise WorkflowError(
            "current document digest differs from project.json; resolve the source of truth before editing"
        )

    number = manifest["versioning"]["next_build_number"]
    candidate_build = build_id(number)
    target_release = (
        manifest["versioning"]["next_release"]
        if args.prepare_release
        else manifest["versioning"]["current_release"]
    )
    document_filename = manifest["project"]["document_filename"]
    candidate_path = project_dir / "documents" / "working" / document_filename
    if candidate_path.exists():
        raise WorkflowError(f"stable working path already exists: {candidate_path}")
    change_path = project_dir / "changes" / f"{candidate_build}.md"
    if change_path.exists():
        raise WorkflowError(f"change record already exists: {change_path}")

    candidate_path.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(current_path, candidate_path)
    candidate_hash = sha256_file(candidate_path)
    if candidate_hash != current_hash:
        raise WorkflowError("working copy does not match the current controlled document")

    history_instruction = (
        "Compress all unreleased D-number rows since the previous release into the target release row. "
        "For the first public release, the only release-history description is `Initial release`."
        if args.prepare_release
        else "Add one D-number row with this build and a one-line change description. Keep prior release rows."
    )
    change_text = f"""# Change request {candidate_build}

- **Process state:** Working draft
- **Visible marking required:** `WORKING DRAFT — NOT FOR USE`
- **Started:** {utc_date()}
- **Base build:** {current['build']}
- **Base release:** {current['release']}
- **Base SHA-256:** `{current_hash}`
- **Target release:** {target_release}
- **Release preparation:** {'Yes' if args.prepare_release else 'No'}
- **Summary:** {summary}

## Change

- Convert the request into exact page, section, figure, panel, text, or metadata targets.

## Preserve

- List content, assets, links, bookmarks, fields, sections, and page flow that must remain unchanged.

## Approve first

- List standalone figures or decisions that must be approved before DOCX integration, or write `None`.

## Validate

- List technical, visual, structural, accessibility, status, and version-history acceptance criteria.

## In-document version history

{history_instruction}

## Source mappings

| Supplied source | Destination | Replacement type | Presentation treatment |
|---|---|---|---|

## Implementation notes

Record deviations, discovered base defects, and decisions that affect review.
"""
    write_text_atomic(change_path, change_text)

    document_state["candidate"] = {
        "build": candidate_build,
        "base_build": current["build"],
        "base_release": current["release"],
        "target_release": target_release,
        "prepare_release": args.prepare_release,
        "process_state": "working_draft",
        "visible_status": "working_draft",
        "file": relative_to_project(project_dir, candidate_path),
        "sha256_at_start": candidate_hash,
        "base_file": current["file"],
        "base_sha256": current_hash,
        "started_at": utc_now(),
        "change_record": relative_to_project(project_dir, change_path),
        "summary": summary,
        "qa": {},
    }
    manifest["versioning"]["next_build_number"] = number + 1
    manifest.setdefault("history", []).append(
        {
            "id": candidate_build,
            "kind": "development_build",
            "release": target_release,
            "status": "working_draft",
            "date": utc_date(),
            "started_at": utc_now(),
            "base_build": current["build"],
            "summary": summary,
        }
    )
    save_json_atomic(project_dir / "project.json", manifest)
    print_result(
        {
            "status": "working_draft",
            "candidate_build": candidate_build,
            "candidate_file": str(candidate_path),
            "stable_filename": document_filename,
            "base_build": current["build"],
            "base_sha256": current_hash,
            "target_release": target_release,
            "change_record": str(change_path),
        }
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except WorkflowError as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(2)
