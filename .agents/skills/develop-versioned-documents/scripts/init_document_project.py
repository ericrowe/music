#!/usr/bin/env python3
"""Initialize a controlled document project with a stable DOCX filename and cross-agent support."""

from __future__ import annotations

import argparse
import shutil
import sys
import zipfile
from pathlib import Path

from _common import (
    VISIBLE_STATUS_LABELS,
    WorkflowError,
    build_id,
    ensure_within,
    next_release,
    parse_build,
    parse_release,
    print_result,
    save_json_atomic,
    sha256_file,
    slugify,
    utc_date,
    utc_now,
    validate_document_stem,
)


DIRECTORIES = (
    "source/originals",
    "documents/current",
    "documents/builds",
    "documents/abandoned",
    "documents/working",
    "documents/releases",
    "assets/incoming",
    "assets/working",
    "assets/approved",
    "changes",
    "qa/baselines",
    "qa/renders",
    "qa/reports",
    "references",
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo-root", default=".", help="repository root; default: current directory")
    parser.add_argument("--project", required=True, help="project directory beneath the repository root")
    parser.add_argument("--title", required=True, help="human-readable project title")
    parser.add_argument(
        "--document-stem",
        required=True,
        help="stable output filename stem; do not include v24, D24, or another version suffix",
    )
    parser.add_argument("--base-docx", help="optional reviewed DOCX to import")
    parser.add_argument("--base-build", help="internal build ID for --base-docx, such as D24")
    parser.add_argument(
        "--base-release",
        default="v0",
        help="release represented by the base; default v0 (unreleased)",
    )
    parser.add_argument(
        "--base-status",
        choices=sorted(VISIBLE_STATUS_LABELS),
        default="manual_review_required",
        help="visible status already present in the imported base",
    )
    return parser.parse_args()


def render_template(source: Path, destination: Path, values: dict[str, str]) -> None:
    text = source.read_text(encoding="utf-8")
    for key, value in values.items():
        text = text.replace("{{" + key + "}}", value)
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(text, encoding="utf-8", newline="\n")


def copy_verified(source: Path, destination: Path) -> str:
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, destination)
    source_hash = sha256_file(source)
    if sha256_file(destination) != source_hash:
        raise WorkflowError(f"copied file failed digest verification: {destination}")
    return source_hash


def main() -> int:
    args = parse_args()
    repo_root = Path(args.repo_root).resolve()
    project_arg = Path(args.project)
    project_dir = ensure_within(
        repo_root, project_arg if project_arg.is_absolute() else repo_root / project_arg
    )
    document_stem = validate_document_stem(args.document_stem)
    document_filename = f"{document_stem}.docx"
    if bool(args.base_docx) != bool(args.base_build):
        raise WorkflowError("--base-docx and --base-build must be supplied together")
    if project_dir.exists() and any(project_dir.iterdir()):
        raise WorkflowError(f"refusing to populate nonempty project directory: {project_dir}")

    base_source: Path | None = None
    base_build: str | None = None
    base_hash: str | None = None
    base_release = args.base_release
    parse_release(base_release)
    if args.base_docx:
        base_source = Path(args.base_docx).resolve()
        if not base_source.is_file():
            raise WorkflowError(f"base DOCX not found: {base_source}")
        if base_source.suffix.lower() != ".docx" or not zipfile.is_zipfile(base_source):
            raise WorkflowError("base document is not a valid DOCX ZIP package")
        base_build = args.base_build
        parse_build(base_build)
        if base_release != "v0" and args.base_status != "released":
            raise WorkflowError("a non-v0 imported base must use --base-status released")

    project_dir.mkdir(parents=True, exist_ok=True)
    for relative in DIRECTORIES:
        directory = project_dir / relative
        directory.mkdir(parents=True, exist_ok=True)
        (directory / ".gitkeep").touch(exist_ok=True)

    current = None
    history: list[dict] = []
    releases: list[dict] = []
    created_at = utc_now()
    if base_source and base_build:
        original = project_dir / "source" / "originals" / base_source.name
        current_path = project_dir / "documents" / "current" / document_filename
        snapshot_path = project_dir / "documents" / "builds" / base_build / document_filename
        base_hash = copy_verified(base_source, original)
        copy_verified(base_source, current_path)
        copy_verified(base_source, snapshot_path)
        current = {
            "build": base_build,
            "release": base_release,
            "process_state": args.base_status,
            "visible_status": args.base_status,
            "file": current_path.relative_to(project_dir).as_posix(),
            "snapshot_file": snapshot_path.relative_to(project_dir).as_posix(),
            "sha256": base_hash,
            "controlled_at": created_at,
            "imported_from": original.relative_to(project_dir).as_posix(),
        }
        history.append(
            {
                "id": base_build,
                "kind": "development_build",
                "release": base_release,
                "status": args.base_status,
                "date": utc_date(),
                "sha256": base_hash,
                "summary": "Imported as controlled base",
            }
        )
        if base_release != "v0":
            release_path = project_dir / "documents" / "releases" / base_release / document_filename
            copy_verified(base_source, release_path)
            releases.append(
                {
                    "version": base_release,
                    "date": utc_date(),
                    "file": release_path.relative_to(project_dir).as_posix(),
                    "sha256": base_hash,
                    "summary": "Imported released base",
                }
            )

    next_build_number = parse_build(base_build) + 1 if base_build else 1
    manifest = {
        "schema_version": 2,
        "project": {
            "title": args.title,
            "slug": slugify(args.title),
            "document_stem": document_stem,
            "document_filename": document_filename,
            "created_at": created_at,
            "status": "active",
        },
        "policy": {
            "document_format": "docx",
            "stable_document_filename": True,
            "development_build_prefix": "D",
            "release_prefix": "v",
            "visible_status_labels": VISIBLE_STATUS_LABELS,
            "full_page_review_required": True,
            "changed_figure_zoom_percent": 200,
            "allow_external_hyperlinks": True,
            "allow_external_content": False,
        },
        "document": {"current": current, "candidate": None},
        "versioning": {
            "current_release": base_release,
            "next_release": next_release(base_release),
            "next_build_number": next_build_number,
        },
        "releases": releases,
        "history": history,
    }
    save_json_atomic(project_dir / "project.json", manifest)

    template_root = Path(__file__).resolve().parents[1] / "assets" / "project-template"
    values = {
        "PROJECT_TITLE": args.title,
        "DOCUMENT_STEM": document_stem,
        "DOCUMENT_FILENAME": document_filename,
        "PROJECT_SLUG": slugify(args.title),
        "INITIAL_CHANGELOG_ROW": (
            f"| {utc_date()} | {base_build} | {base_release} | {args.base_status} | Imported controlled base | `{base_hash}` |"
            if base_build and base_hash
            else "| - | - | v0 | Initialized | Project initialized without a document | - |"
        ),
    }
    render_template(template_root / "AGENTS.md", project_dir / "AGENTS.md", values)
    if (template_root / "GEMINI.md").exists():
        render_template(template_root / "GEMINI.md", project_dir / "GEMINI.md", values)
    if (template_root / "CLAUDE.md").exists():
        render_template(template_root / "CLAUDE.md", project_dir / "CLAUDE.md", values)
    render_template(template_root / "CHANGELOG.md", project_dir / "CHANGELOG.md", values)
    render_template(template_root / "project.gitignore", project_dir / ".gitignore", values)
    for name in ("TECHNICAL_SPEC.md", "FIGURE_STYLE.md", "VERSION_HISTORY.md"):
        render_template(
            template_root / "references" / name,
            project_dir / "references" / name,
            values,
        )
    shutil.copy2(
        template_root / "references" / "FIGURE_REGISTER.csv",
        project_dir / "references" / "FIGURE_REGISTER.csv",
    )

    print_result(
        {
            "status": "initialized",
            "project_dir": str(project_dir),
            "document_filename": document_filename,
            "current_build": base_build,
            "current_release": base_release,
            "current_sha256": base_hash,
            "next_build": build_id(next_build_number),
            "next_release": next_release(base_release),
        }
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except WorkflowError as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(2)
