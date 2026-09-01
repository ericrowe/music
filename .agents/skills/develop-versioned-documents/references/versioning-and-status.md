# Versioning, history compression, and status

Read this reference whenever a task starts or publishes a build, records a review
decision, prepares a release, changes visible status, or edits version history.

## Two independent sequences

- Development build `D<number>`: unique internal trace identifier; never reused.
- Public release `v<number>`: reader-facing version; `v0` is unreleased.

Do not call D24 “release v24.” A document may be `Release v0 (unreleased),
Development build D24`.

## Stable filename invariant

The DOCX basename is the same under `working`, `current`, `builds/D#`, and
`releases/v#`. Build and release tokens belong in the document, manifest, change
records, QA report names, repository directories, and Git history—not the DOCX
filename.

## Visible lifecycle labels

Use the exact text:

| Visible status key | Required label |
|---|---|
| `working_draft` | `WORKING DRAFT — NOT FOR USE` |
| `manual_review_required` | `MANUAL REVIEW REQUIRED — NOT RELEASED` |
| `release_candidate` | `RELEASE CANDIDATE — APPROVAL REQUIRED` |
| `released` | `RELEASED — APPROVED FOR USE` |

Put the current label in a prominent cover block and preferably the footer. Do
not display internal repository states such as `automated_qa`, `changes_requested`,
or `abandoned` as substitutes for these labels.

## Working history rules

The in-document table uses:

| Version | Date | Status | One-line description |
|---|---|---|---|

- During unreleased review, use D-rows and show release v0.
- After a public release, retain public release rows and add temporary D-rows for
  the new review cycle.
- Keep descriptions concise and user-visible; implementation details stay in the
  repository change record.
- Audit the exact build, release, status label, and one-line description before
  publishing for review.

## Release compression algorithm

1. Identify the last public release row, if any.
2. Summarize all D-build changes after that row in one line.
3. Delete those D-rows from the distributed release candidate.
4. Add one row for the next v-release.
5. For v1, use exactly `Initial release` regardless of how many D-builds preceded it.
6. Retain every earlier v-release row.
7. On the final released bytes, remove D-numbers from cover, footer, body, custom
   properties, and any other text-bearing package part.
8. Run the audit with `--forbid-development-builds`.

Do not delete detailed repository history when compressing the reader-facing table.

## Process-state decisions

- QA failure: return candidate to `working_draft`; all final evidence resets.
- Human changes: leave the reviewed snapshot unchanged, record
  `changes_requested`, and start the next D-build.
- Human approval: start a separate release-preparation build rather than editing
  the current file in place.
- Release defect: return to working draft in the release-preparation candidate.
- Published defect: start a new D-build and later release; never overwrite an
  existing release snapshot.
