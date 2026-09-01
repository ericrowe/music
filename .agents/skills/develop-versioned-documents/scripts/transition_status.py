#!/usr/bin/env python3
"""Record an allowed process-state transition and bind review-ready states to QA evidence."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

from _common import (
    ALLOWED_TRANSITIONS,
    VISIBLE_STATUS_LABELS,
    WorkflowError,
    load_project,
    print_result,
    relative_to_project,
    resolve_project_path,
    save_json_atomic,
    sha256_file,
    utc_now,
    validate_one_line,
)
from _evidence import read_report, validate_audit, validate_diff, validate_visual


QA_STATES = {"manual_review_required", "release_candidate"}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("project", help="document project directory")
    parser.add_argument(
        "--to",
        required=True,
        choices=(
            "working_draft",
            "automated_qa",
            "manual_review_required",
            "changes_requested",
            "release_candidate",
        ),
        help="new process state",
    )
    parser.add_argument("--note", required=True, help="one-line reason or review decision")
    parser.add_argument("--audit-report", help="required when entering a review-ready state")
    parser.add_argument("--diff-report", help="required when entering a review-ready state")
    parser.add_argument("--visual-review", help="required when entering a review-ready state")
    parser.add_argument("--approve-diff", action="store_true", help="attest the difference set was reviewed")
    parser.add_argument(
        "--approve-audit-warnings",
        action="store_true",
        help="accept explained non-error audit warnings",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    note = validate_one_line(args.note, "note")
    project_dir = Path(args.project).resolve()
    manifest = load_project(project_dir)
    candidate = manifest["document"].get("candidate")
    record = candidate or manifest["document"].get("current")
    if not record:
        raise WorkflowError("no controlled document is registered")
    target_kind = "candidate" if candidate else "current"
    old_state = record["process_state"]
    new_state = args.to
    if new_state not in ALLOWED_TRANSITIONS.get(old_state, set()):
        raise WorkflowError(f"process transition is not allowed: {old_state} -> {new_state}")
    if new_state == "working_draft" and target_kind == "current":
        raise WorkflowError("do not edit the current file in place; create a new build with start_build.py")
    if new_state == "release_candidate" and target_kind == "current":
        raise WorkflowError("prepare a release in a new build with start_build.py --prepare-release")
    if new_state == "release_candidate" and not record.get("prepare_release"):
        raise WorkflowError("release_candidate requires a build started with --prepare-release")
    if new_state == "changes_requested" and target_kind != "current":
        raise WorkflowError("publish the review build before recording a human change request")

    document_path = resolve_project_path(project_dir, record["file"])
    if not document_path.is_file():
        raise WorkflowError(f"document is missing: {document_path}")
    document_hash = sha256_file(document_path)
    if target_kind == "current" and document_hash != record["sha256"]:
        raise WorkflowError("current document bytes do not match project.json")

    qa: dict[str, str] = {}
    if new_state in QA_STATES:
        if target_kind != "candidate":
            raise WorkflowError("review-ready status must be applied to an active candidate")
        if not all((args.audit_report, args.diff_report, args.visual_review)):
            raise WorkflowError("audit, diff, and visual-review reports are required")
        if not args.approve-diff if hasattr(args, "approve-diff") else not args.approve_diff:
            raise WorkflowError("--approve-diff is required after reviewing the difference set")
        audit_path = Path(args.audit_report).resolve()
        diff_path = Path(args.diff_report).resolve()
        visual_path = Path(args.visual_review).resolve()
        audit = read_report(audit_path, "audit report")
        diff = read_report(diff_path, "diff report")
        visual = read_report(visual_path, "visual review")
        validate_audit(
            audit,
            document_hash,
            expected_build=record["build"],
            expected_release=record["target_release"],
            expected_status=new_state,
            forbid_development_builds=False,
            expected_text=[record["summary"]],
            approve_warnings=args.approve_audit_warnings,
        )
        validate_diff(diff, record["base_sha256"], document_hash)
        validate_visual(visual, document_hash)
        qa = {
            "audit": relative_to_project(project_dir, audit_path),
            "diff": relative_to_project(project_dir, diff_path),
            "visual_review": relative_to_project(project_dir, visual_path),
            "document_sha256": document_hash,
        }

    record["process_state"] = new_state
    if new_state in VISIBLE_STATUS_LABELS:
        record["visible_status"] = new_state
    if qa:
        record["qa"] = qa
    record.setdefault("transitions", []).append(
        {"from": old_state, "to": new_state, "at": utc_now(), "note": note}
    )
    for entry in reversed(manifest.get("history", [])):
        if entry.get("id") == record.get("build") and entry.get("kind") == "development_build":
            entry["status"] = new_state
            entry["updated_at"] = utc_now()
            break
    save_json_atomic(project_dir / "project.json", manifest)

    print_result(
        {
            "status": new_state,
            "target": target_kind,
            "build": record.get("build"),
            "release": record.get("target_release", record.get("release")),
            "visible_status": record.get("visible_status"),
            "visible_label": VISIBLE_STATUS_LABELS.get(record.get("visible_status", "")),
            "document": str(document_path),
            "qa_bound": bool(qa),
        }
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except WorkflowError as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(2)
