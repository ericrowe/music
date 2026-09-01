---
name: develop-versioned-documents
description: Develop or release repository-backed Word documents with stable filenames, internal D-builds, compressed public v-release history, visible lifecycle markings, verified bases, isolated figure approval, full rendered review, OOXML audits, and regression evidence. Cross-agent supported for Gemini, Codex, Claude Code, Cursor, and other AI coding agents.
---

# Develop Controlled Word Documents (Cross-Agent System)

Produce a technically correct, visually verified, structurally sound DOCX whose
internal version, visible status, and repository evidence agree. The distributed
filename remains stable throughout development and release.

Supported in **Gemini** (via `.agents/skills/`), **Codex** (via `.codex/skills/`),
**Claude Code** (via `CLAUDE.md`), **Cursor** (via `.cursorrules`), and other
standard AI coding agents via root `AGENTS.md`.

## Establish control before editing

1. Read the repository `AGENTS.md`, nearest project `AGENTS.md`, `project.json`,
   active D-build change record, and only the references relevant to the request.
2. Resolve the current DOCX from `project.json` and verify its SHA-256 digest.
   Never infer the base from a filename, date, or remembered prior revision.
3. Confirm the stable document filename contains no D-number or v-number suffix.
4. If no candidate exists, run the start build helper script. If one exists, confirm
   its base digest, D-number, target release, and scope before continuing.
5. Stop on a wrong base, digest mismatch, ambiguous target, or attempted overwrite
   of a current, build, release, original, or approved asset.

Read [references/workflow.md](references/workflow.md) for the complete candidate
flow and [references/versioning-and-status.md](references/versioning-and-status.md)
whenever version history, status, review publication, or release is involved.

## Choose the working mode

- **Document edit:** Change only the stable file under `documents/working/`. Use
  the available Word-document workflow for authoring and rendering.
- **Standalone asset review:** If the reviewer wants a figure first or geometry
  is unsettled, work only in `assets/working/`; do not edit the DOCX. Read
  [references/figure-workflow.md](references/figure-workflow.md).
- **Integration:** Integrate only an approved source or identified presentation
  derivative. Update its caption, alt text, register, and coupled instructions.
- **Package repair:** Before direct OOXML work, read
  [references/ooxml-safety.md](references/ooxml-safety.md).

## Non-negotiable controls

- Use D-numbers for internal builds and v-numbers for public releases. `v0` means
  unreleased. Never put either token in the DOCX filename.
- D-numbers are unique and never reused, including abandoned builds.
- Every working or review DOCX has the approved visible status and a version-
  history row with one one-line description.
- At release, compress D-rows since the prior release into one release row. The
  first release is `v1 — Initial release`.
- A released DOCX contains no D-number in visible text or stored metadata.
- Never edit the current controlled file, immutable snapshots, original uploads,
  or approved sources in place.
- Never merge a wrong-base document branch into the correct base.
- Preserve unrelated content and package parts. Broad run or paragraph replacement
  is prohibited for localized edits.
- A standalone preview does not authorize master-document integration.
- Intentional web hyperlinks may remain. Linked pictures, external templates,
  OLE links, and external-data fields require explicit authorization.
- Every informative figure needs a separate caption and meaningful alt text.

## Finish through evidence

For a review build:

1. Mark the candidate `MANUAL REVIEW REQUIRED — NOT RELEASED` and synchronize its
   release, D-number, date, and version-history row.
2. Render every page; inspect all pages at 100% and changed figures at 200%.
3. Run `audit_docx.py` with the expected build, release, status, summary text, and
   stable-filename requirement.
4. Run `compare_docx_packages.py` against the current base.
5. Record the all-page review with `record_visual_review.py`.
6. Apply [references/quality-gates.md](references/quality-gates.md).
7. Bind the reports with `transition_status.py`, then run
   `publish_review_build.py`.

For a public release, start a new `--prepare-release` build, compress the table,
complete release-candidate QA, then change the final bytes to
`RELEASED — APPROVED FOR USE`, remove
all D-numbers, repeat all QA, and use `release_document.py`.

Any byte change after final rendering resets the visual, audit, comparison, and
evidence gates.

## Helper scripts

Scripts are executable from either `.agents/skills/develop-versioned-documents/scripts/`
or `.codex/skills/develop-versioned-documents/scripts/`:

- `init_document_project.py`: Create the stable-filename project layout and
  optionally import a current D-build or release.
- `register_initial_build.py`: Register the first reviewed D-build when no base
  was imported.
- `start_build.py`: Verify the current digest, reserve a unique D-number, and
  create the stable working copy and change record.
- `transition_status.py`: Enforce lifecycle transitions and bind review-ready
  states to digest-matched QA evidence.
- `publish_review_build.py`: Snapshot and promote a QA-passed D-build for human
  review without changing the filename.
- `release_document.py`: Publish a history-compressed release under the stable
  filename and advance the public release sequence.
- `abandon_build.py`: Preserve a rejected candidate and permanently retire its
  D-number.
- `audit_docx.py`: Audit package integrity, dependencies, fields, images, alt
  text, stable filename, build/release markers, status, and release-history text.
- `compare_docx_packages.py`: Report package and extracted-text differences.
- `record_visual_review.py`: Bind an all-pages render inspection to the DOCX digest.

Run a helper with `--help` before first use in an unfamiliar repository.

## Completion report

Report the stable filename, base and resulting D-build or public release, visible
status, material changes, page count, and QA result. Deliver the current stable-
named DOCX unless the reviewer asks for intermediate assets or reports.
