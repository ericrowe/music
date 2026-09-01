# Development build workflow

Use this reference when starting, continuing, publishing, abandoning, or releasing
a document build.

## Read order

1. Repository `AGENTS.md` or `GEMINI.md`.
2. Project `AGENTS.md`.
3. `project.json`.
4. Active `changes/D<number>.md`.
5. Relevant technical, figure, and version-history references.
6. Current document and baseline reports.

Do not load unrelated project history merely because it exists. The manifest
current state and active change record control the task.

## Translate the request

Record four categories before editing:

- **Change:** exact targets and requested result.
- **Preserve:** content and package features that must not change.
- **Approve first:** assets or decisions requiring standalone review.
- **Validate:** technical, visual, structural, version, status, and release criteria.

For image mappings, record one row per source and destination and distinguish a
whole-figure replacement from a panel replacement.

## Verify and reserve the base

`start_build.py` confirms that:

- the stable current file exists;
- its digest matches `project.json`;
- no candidate is active;
- the next D-number is unique;
- the stable working path is free.

It copies the base to `documents/working/<stable-name>.docx`, reserves the D-number
permanently, and creates the change record. It does not edit the DOCX's visible
build, status, or history; the author must synchronize those inside the file.

## Baseline before mutation

Capture the current document's package audit and full render before editing.
Retain counts or reports for pages, sections, headings, tables, images, image
placement, alt text, hyperlinks, bookmarks, fields, and external relationships.

Do not silently expand the scope to repair a baseline defect.

## Author in short verified batches

1. Make one coherent change batch in the stable working file.
2. Save and render it.
3. Inspect affected pages and adjacent page flow.
4. Continue only when the batch is sound.

After the final batch, render and inspect every page. A local edit can change
distant pagination, fields, or section geometry.

## Synchronize coupled information

A figure change can require media, placement, crop, frame, label, caption,
numbering, cross-reference, instruction, alt-text, page-reference, and figure-
register updates.

Every review build also requires synchronized:

- stable filename;
- release version and D-number;
- visible lifecycle marking;
- version-history row and one-line description;
- date and document properties;
- headers and footers when they repeat status/version information.

## Review publication

After the exact manual-review bytes pass render, audit, diff, and visual review:

1. Transition the candidate from `automated_qa` to
   `manual_review_required` with the evidence reports.
2. Run `publish_review_build.py`.
3. The helper snapshots the bytes under `documents/builds/D<number>/`, replaces
   the stable current file atomically, closes the candidate, and updates history.

When the reviewer requests changes, record `changes_requested` and start a new
D-build. Do not edit the reviewed current file or its snapshot.

## Release preparation

Use `start_build.py --prepare-release` only after human approval of the current
content. The start summary becomes the one-line public release description; for
the first release it must be exactly `Initial release`.

Before release-candidate QA:

- target the next reserved public release;
- compress D-rows since the prior release into the target release row;
- keep the internal D-number for candidate traceability;
- show `RELEASE CANDIDATE — APPROVAL REQUIRED`.

After candidate QA, change the final file to `RELEASED — APPROVED FOR USE`, remove every D-number,
and repeat the entire QA set. `release_document.py` requires an audit proving the
stable filename, target release, released marking, one-line summary, and absence
of development build tokens.

## Wrong-base recovery

Do not transplant document XML or media from the wrong branch by default:

1. Run `abandon_build.py` and record the reason.
2. Preserve the candidate under its D-number; never reuse that number.
3. Start a new build from the current manifest base.
4. Reapply valid changes deliberately.
5. Repeat baseline comparison and QA.

## Cache behavior

The file's name is not a cache-control mechanism. Keep it stable. When a delivery
surface caches an older download, use the surface's version identity, ETag,
content hash, repository commit, or regenerated download URL.
