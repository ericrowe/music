#!/usr/bin/env python3
"""Digest-bound QA evidence checks shared by promotion helpers."""

from __future__ import annotations

import json
from pathlib import Path

from _common import VISIBLE_STATUS_LABELS, WorkflowError, sha256_file


def require(condition: bool, message: str) -> None:
    if not condition:
        raise WorkflowError(message)


def read_report(path: Path, label: str) -> dict:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise WorkflowError(f"cannot read {label}: {exc}") from exc
    if not isinstance(data, dict):
        raise WorkflowError(f"{label} is not a JSON object")
    return data


def validate_audit(
    report: dict,
    document_hash: str,
    *,
    expected_build: str | None,
    expected_release: str,
    expected_status: str,
    forbid_development_builds: bool,
    expected_text: list[str] | None = None,
    approve_warnings: bool = False,
) -> None:
    require(report.get("schema_version") == 2, "audit report uses an unsupported schema")
    require(report.get("status") == "pass", "DOCX audit did not pass")
    require(report.get("file_sha256") == document_hash, "audit report is for different DOCX bytes")
    require(report.get("expected_build") == expected_build, "audit did not verify the expected build")
    require(report.get("expected_release") == expected_release, "audit did not verify the expected release")
    require(report.get("expected_status") == expected_status, "audit did not verify the expected status")
    require(
        report.get("expected_status_label") == VISIBLE_STATUS_LABELS[expected_status],
        "audit used a different visible status label",
    )
    require(
        bool(report.get("require_stable_filename")),
        "audit did not enforce the stable document filename",
    )
    require(
        bool(report.get("forbid_development_builds")) == forbid_development_builds,
        "audit development-build policy does not match this promotion",
    )
    for phrase in expected_text or []:
        require(
            phrase in (report.get("expected_text") or []),
            f"audit did not verify required history text: {phrase}",
        )
    warnings = report.get("warnings") or []
    require(
        not warnings or approve_warnings,
        "audit contains warnings; explain them and pass --approve-audit-warnings",
    )


def validate_visual(report: dict, document_hash: str) -> None:
    require(report.get("status") == "pass", "visual review did not pass")
    require(report.get("file_sha256") == document_hash, "visual review is for different DOCX bytes")
    require(bool(report.get("all_pages_reviewed")), "visual report does not attest all-pages review")


def validate_diff(report: dict, base_hash: str, candidate_hash: str) -> None:
    require(report.get("status") == "pass", "package comparison did not pass")
    require(report.get("base_sha256") == base_hash, "diff report is for a different base")
    require(
        report.get("candidate_sha256") == candidate_hash,
        "diff report is for different candidate bytes",
    )


def report_hash(path: Path) -> str:
    return sha256_file(path)
