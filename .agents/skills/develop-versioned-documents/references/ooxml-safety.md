# OOXML patch safety

Use this reference before modifying DOCX package XML directly.

## Prefer the narrowest layer

Use a semantic document library for ordinary paragraphs, styles, lists, tables,
headers, and inline pictures. Use OOXML only for features the semantic layer
cannot preserve, such as exact relationships, fields, bookmarks, comments,
cross-references, or a precisely identified image run.

## Package invariants

A valid edit preserves agreement among:

- the target XML part;
- its `.rels` relationship part;
- `[Content_Types].xml`;
- every referenced media or supporting part;
- the document's visible cached field results where applicable.

After any patch, test ZIP integrity and verify every internal relationship target.

## Run-splitting hazard

Word can split visible text across multiple `w:r` and `w:t` elements because of
formatting, proofing, fields, bookmarks, revisions, or embedded drawings. Do not
delete all runs in a paragraph merely to replace a label. That operation can
remove pictures, page-number fields, bookmarks, and unrelated formatting.

Locate targets by inspected XML context and change only the exact nodes. When a
stable marker can be added during original authoring, prefer it to fuzzy text
matching later.

## Images

- `r:embed` references an embedded package part.
- `r:link` references external content and is normally prohibited.
- Preserve the existing `wp:inline` or `wp:anchor` placement unless layout intent
  changes.
- Preserve `wp:extent`, crop geometry, aspect behavior, `wp:docPr`, caption, and
  alt text unless the change request says otherwise.
- When replacing media bytes under an existing relationship, confirm MIME type
  and extension remain compatible. Otherwise create a new relationship and
  content-type entry deliberately.

## External destinations

Classify external relationships by type, not merely by `TargetMode="External"`.
Normal web hyperlink relationships can be intentional. Linked images, attached
templates, OLE/package links, and external workbook/data relationships are
content dependencies and require explicit authorization.

Inspect field instructions for `INCLUDETEXT`, `INCLUDEPICTURE`, `LINK`, `DDE`,
`DDEAUTO`, `DATABASE`, and similar external-data behavior. Ordinary `PAGE`,
`NUMPAGES`, `REF`, and `PAGEREF` fields are internal.

If Word warns about external links but no external content dependency exists,
inspect `word/settings.xml` for `w:updateFields`. Remove update-on-open only after
confirming that required dynamic fields do not depend on it.

## Build, release, status, and metadata strings

Build, release, and status updates may exist in document text, history tables,
headers, footers, appendix covers, and captions. Hidden or stored values may also
exist in core, custom, or application properties and custom XML. Search all text-
bearing package parts after the final save. A released file must contain its
public release and no D-number.

## Regression after a patch

Re-render every page, re-run the DOCX audit, and compare ZIP members to the base.
If a localized change modifies many unrelated parts, discard the candidate and
replace the patching method rather than repairing the fallout piecemeal.
