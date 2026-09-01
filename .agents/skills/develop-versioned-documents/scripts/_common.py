#!/usr/bin/env python3
"""Shared helpers for the controlled-document workflow."""

from __future__ import annotations

import hashlib
import json
import os
import re
import tempfile
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


BUILD_RE = re.compile(r"^D(?P<number>[1-9][0-9]*)$")
RELEASE_RE = re.compile(r"^v(?P<number>0|[1-9][0-9]*)$")
VERSIONED_FILENAME_RE = re.compile(r"(?:^|[_ .-])(?:v|d)[0-9]+$", re.IGNORECASE)

VISIBLE_STATUS_LABELS = {
    "working_draft": "WORKING DRAFT — NOT FOR USE",
    "manual_review_required": "MANUAL REVIEW REQUIRED — NOT RELEASED",
    "release_candidate": "RELEASE CANDIDATE — APPROVAL REQUIRED",
    "released": "RELEASED — APPROVED FOR USE",
}

PROCESS_STATES = {
    "working_draft",
    "automated_qa",
    "manual_review_required",
    "changes_requested",
    "release_candidate",
    "released",
    "abandoned",
}

ALLOWED_TRANSITIONS = {
    "working_draft": {"automated_qa", "abandoned"},
    "automated_qa": {"working_draft", "manual_review_required", "release_candidate", "abandoned"},
    "manual_review_required": {"changes_requested", "release_candidate"},
    "changes_requested": {"working_draft"},
    "release_candidate": {"working_draft", "released"},
    "released": {"working_draft"},
    "abandoned": set(),
}


class WorkflowError(RuntimeError):
    """Raised when a workflow invariant is not satisfied."""


def utc_now() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat()


def utc_date() -> str:
    return datetime.now(timezone.utc).date().isoformat()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def slugify(value: str) -> str:
    slug = re.sub(r"[^a-z0-9]+", "-", value.lower()).strip("-")
    if not slug:
        raise WorkflowError("The title does not produce a usable project slug.")
    return slug


def validate_document_stem(value: str) -> str:
    if not re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9._-]*", value):
        raise WorkflowError(
            "document stem must contain only letters, digits, dot, underscore, or hyphen"
        )
    if VERSIONED_FILENAME_RE.search(value):
        raise WorkflowError(
            "document stem must be stable and must not end in a build or release token"
        )
    return value


def validate_stable_docx_filename(value: str) -> str:
    path = Path(value)
    if path.name != value or path.suffix.lower() != ".docx":
        raise WorkflowError("document filename must be a plain .docx filename")
    validate_document_stem(path.stem)
    return value


def parse_build(value: str) -> int:
    match = BUILD_RE.fullmatch(value)
    if not match:
        raise WorkflowError("development build must look like D1, D2, or another positive D-number")
    return int(match.group("number"))


def build_id(number: int) -> str:
    if number < 1:
        raise WorkflowError("development build number must be positive")
    return f"D{number}"


def parse_release(value: str, allow_unreleased: bool = True) -> int:
    match = RELEASE_RE.fullmatch(value)
    if not match:
        raise WorkflowError("release version must look like v0, v1, or another nonnegative v-number")
    number = int(match.group("number"))
    if number == 0 and not allow_unreleased:
        raise WorkflowError("v0 denotes unreleased development and cannot be published")
    return number


def next_release(value: str) -> str:
    return f"v{parse_release(value) + 1}"


def validate_process_state(value: str) -> str:
    if value not in PROCESS_STATES:
        raise WorkflowError(
            "process state must be one of: " + ", ".join(sorted(PROCESS_STATES))
        )
    return value


def validate_one_line(value: str, label: str = "summary") -> str:
    clean = " ".join(value.split()).strip()
    if not clean:
        raise WorkflowError(f"{label} must not be blank")
    if len(clean) > 240:
        raise WorkflowError(f"{label} must be 240 characters or fewer")
    return clean


def ensure_within(root: Path, target: Path) -> Path:
    root = root.resolve()
    target = target.resolve()
    try:
        target.relative_to(root)
    except ValueError as exc:
        raise WorkflowError(f"path is outside allowed root: {target}") from exc
    return target


def load_project(project_dir: Path) -> dict[str, Any]:
    project_dir = project_dir.resolve()
    manifest_path = project_dir / "project.json"
    if not manifest_path.is_file():
        raise WorkflowError(f"project manifest not found: {manifest_path}")
    try:
        data = json.loads(manifest_path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise WorkflowError(f"cannot read project manifest: {exc}") from exc
    if data.get("schema_version") != 2:
        raise WorkflowError("unsupported project.json schema_version; this kit expects schema 2")
    required = {"project", "policy", "document", "versioning", "history", "releases"}
    missing = sorted(required - set(data))
    if missing:
        raise WorkflowError("project.json is missing: " + ", ".join(missing))
    validate_stable_docx_filename(data["project"].get("document_filename", ""))
    return data


def save_json_atomic(path: Path, data: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    descriptor, temp_name = tempfile.mkstemp(
        prefix=f".{path.name}.", suffix=".tmp", dir=str(path.parent)
    )
    try:
        with os.fdopen(descriptor, "w", encoding="utf-8") as stream:
            json.dump(data, stream, indent=2, sort_keys=False)
            stream.write("\n")
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(temp_name, path)
    except Exception:
        try:
            os.unlink(temp_name)
        except FileNotFoundError:
            pass
        raise


def write_text_atomic(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    descriptor, temp_name = tempfile.mkstemp(
        prefix=f".{path.name}.", suffix=".tmp", dir=str(path.parent)
    )
    try:
        with os.fdopen(descriptor, "w", encoding="utf-8", newline="\n") as stream:
            stream.write(text)
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(temp_name, path)
    except Exception:
        try:
            os.unlink(temp_name)
        except FileNotFoundError:
            pass
        raise


def relative_to_project(project_dir: Path, path: Path) -> str:
    path = ensure_within(project_dir, path)
    return path.relative_to(project_dir.resolve()).as_posix()


def resolve_project_path(project_dir: Path, relative: str) -> Path:
    if not relative or Path(relative).is_absolute():
        raise WorkflowError(f"manifest path must be nonempty and relative: {relative!r}")
    return ensure_within(project_dir, project_dir / relative)


def print_result(data: Any) -> None:
    print(json.dumps(data, indent=2, sort_keys=False))
