# Backdrop Construction and Assembly Guide version and status policy

## Stable filename

The controlled Word file is always named `Backdrop_Assembly_Guide.docx`. Never append a
development build or public release version to that filename. Repository folders,
Git history, `project.json`, and file digests preserve byte-level provenance.

## Identifiers

- `D1`, `D2`, … identify internal development builds. D-numbers are unique and
  never reused, but they are not public release versions.
- `v0` means the document has not been publicly released.
- `v1`, `v2`, … identify public releases.

## Required visible status

Use exactly one current status marking in a prominent cover status block and,
when practical, in the footer:

| Process point | Required visible marking |
|---|---|
| Authoring and automated QA | `WORKING DRAFT — NOT FOR USE` |
| Sent to a person for review | `MANUAL REVIEW REQUIRED — NOT RELEASED` |
| Approved content undergoing final release QA | `RELEASE CANDIDATE — APPROVAL REQUIRED` |
| Published release | `RELEASED — APPROVED FOR USE` |

`Automated QA`, `Changes requested`, and `Abandoned` are repository workflow
states; they do not require a distinct document marking.

## In-document version history table

Use this minimum schema:

| Version | Date | Status | One-line description |
|---|---|---|---|
| D1 | YYYY-MM-DD | Manual review required | Concise description of this review build. |

During unreleased development, retain the D-number rows needed to explain the
active review sequence. Each row has one line only. The repository changelog and
Git history retain the complete implementation detail.

At release, compress every D-number row since the prior release into one release
row and remove the D-number rows from the distributed DOCX:

- First public release: `v1 | <date> | Released | Initial release`
- Later release: one row such as
  `v2 | <date> | Released | Added field inspection and revised deployment steps`

Keep earlier public release rows. Thus the public document contains one row per
release, while an active post-release draft may temporarily contain those release
rows plus new D-number review rows.

## Current-version display

- Unreleased review build: show `Release v0 (unreleased)` and `Development build Dn`.
- Release candidate: show the target public version and the internal D-number.
- Released document: show only the public release version; no D-number may remain
  in visible text, headers, footers, properties, or stored document metadata.
