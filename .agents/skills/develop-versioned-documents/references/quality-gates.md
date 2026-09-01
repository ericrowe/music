# Review and release quality gates

Use this reference for the final QA and promotion cycle.

## Gate 1: Base, identity, and scope

- Stable filename and current digest match `project.json`.
- Candidate records the same base build and digest.
- D-number is unique and target release is correct.
- Change record names intended targets and preservation rules.
- Current files, snapshots, releases, originals, and approved art were not edited.

## Gate 2: Content and technical correctness

- Every requested change is present.
- Quantities, dimensions, part IDs, sequence, and warnings agree with controlling
  specifications.
- Figure geometry follows approved sources and reviewer instructions.
- Unrequested content remains unchanged.

## Gate 3: Version, history, and visible status

For manual review:

- Stable filename contains no version suffix.
- Current release, D-number, date, and status agree throughout the DOCX.
- Visible label is `MANUAL REVIEW REQUIRED — NOT RELEASED`.
- Version-history table contains the D-row and approved one-line description.

For a release candidate:

- Target release and D-number are present.
- Visible label is `RELEASE CANDIDATE — APPROVAL REQUIRED`.
- D-rows since the prior release are compressed into one target-release row.

For released bytes:

- Visible label is `RELEASED — APPROVED FOR USE`.
- Target v-release and one-line summary are present.
- v1 description is exactly `Initial release`.
- No D-number remains in visible or stored document text.
- Previous public release rows remain.

## Gate 4: Final visual render

- Candidate renders to sequential page PNGs.
- Every page is inspected at 100%.
- Changed figures are inspected at 200%.
- Page count and page geometry meet expectations.
- No clipped, overlapping, stretched, missing, or substituted content.
- Captions remain adjacent to figures.
- Section, appendix, and index starts remain intentional.
- Headers, footers, page numbers, dates, status, and version history are correct.

The visual review must name the candidate digest and contain no page gaps.

## Gate 5: DOCX structure and accessibility

- ZIP integrity passes and all internal relationship targets exist.
- External content is absent except intentional hyperlinks.
- No linked picture, OLE object, attached template, or external-data field exists
  without authorization.
- Update-fields-on-open is disabled unless documented as required.
- Informative images have meaningful alt text.
- Image placement is known; floating anchors receive extra review.
- Heading hierarchy, table headers, fields, bookmarks, sections, and page numbers
  meet project requirements.

Warnings require a written explanation. Unexplained warnings fail.

## Gate 6: Regression

- Visual comparison explains every changed page.
- Text comparison explains every changed passage.
- Package comparison explains every added, removed, or changed part.
- Media changes match approved figure mappings.
- Relationship, settings, styles, numbering, header, footer, and property changes
  are intended or documented application side effects.
- No unrelated image, bookmark, hyperlink, field, or table was removed.

## Gate 7: Promotion record

- Audit, diff, and visual-review reports reference the exact DOCX digest.
- Figure register and change record reflect integrated assets.
- Review builds are promoted with `publish_review_build.py`.
- Releases are promoted with `release_document.py`.
- `project.json`, repository `CHANGELOG.md`, in-document version history, snapshot,
  and stable current file agree.
- The repository commit contains the complete promotion set.

Any byte change after Gate 4 resets Gates 4 through 7.
