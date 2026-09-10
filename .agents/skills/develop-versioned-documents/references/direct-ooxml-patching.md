# Direct OOXML Package Patching & PDF Rendering Guide

This guide codifies the exact, zero-friction pattern for safely modifying complex `.docx` files at the OpenXML package layer and generating matching PDF deliverables on macOS without triggering Word package repair errors or AppleScript hangs.

---

## 1. Why Full-Tree XML Serialization Fails

When editing existing Word documents that contain complex layouts, drawings, headers, bookmarks, or custom styles, traditional semantic libraries (`python-docx`) or naive DOM serializers (`xml.etree.ElementTree`, `minidom`, `lxml`) frequently corrupt the package:

1. **Namespace Mangling in `.rels` (`<pr:Relationships>`):**
   - Python's `xml.etree.ElementTree` automatically prefixes default namespaces when re-serializing XML without an explicit empty prefix registration.
   - In `word/_rels/document.xml.rels`, serializing `<Relationships>` as `<pr:Relationships>` or `<ns0:Relationships>` immediately breaks Microsoft Word's OpenXML package loader, triggering the fatal error:
     > *"Word found unreadable content in '<filename>.docx'. Do you want to recover the contents of this document?"*
   - **Invariant:** `.rels` files MUST strictly begin with:
     ```xml
     <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
     ```
     with **zero** namespace prefix.

2. **Namespace Stripping on `<w:document>`:**
   - Re-serializing `word/document.xml` using ElementTree strips unused namespace declarations (e.g., `xmlns:w14`, `xmlns:wp14`, `xmlns:mc`) while leaving `mc:Ignorable="w14 wp14"`. Word flags missing namespace declarations as schema errors.
   - **Invariant:** Never discard or re-declare the root `<w:document>` tag attributes from the base document.

3. **ECMA-376 Strict Child Ordering in `<w:tblPr>`:**
   - In Word OpenXML schema (ECMA-376 Part 1, §17.4.34), children of table properties `<w:tblPr>` must appear in strict sequence:
     1. `w:tblStyle`
     2. `w:tblpPr`
     3. `w:tblOverlap`
     4. `w:bidiVisual`
     5. `w:tblStyleRowBandSize`
     6. `w:tblStyleColBandSize`
     7. `w:tblW` (Table Width)
     8. `w:jc` (Table Justification)
     9. `w:tblCellSpacing`
     10. `w:tblInd` (Table Indent)
     11. `w:tblBorders` (Table Borders)
     12. `w:shd` (Shading)
     13. `w:tblLayout` (Table Layout)
     14. `w:tblCellMar` (Cell Margins)
     15. `w:tblLook`
   - Inserting `<w:tblBorders>` before `<w:tblW>` or after `<w:tblLayout>` violates schema validation and will cause Word to report unreadable content.

---

## 2. The Surgical String / Fragment Replacement Pattern

Instead of parsing and re-serializing the entire XML tree with a DOM parser, use **surgical fragment replacement**:

1. Extract the base `.docx` (a standard ZIP archive).
2. Read the target XML part (e.g. `word/document.xml`) as a UTF-8 string.
3. Keep the entire root `<w:document ...>` tag and its hundreds of namespace declarations byte-for-byte identical.
4. Locate the exact anchor point (e.g. an existing heading, placeholder paragraph, table end-tag `</w:tbl>`, or section mark) using substring search or precise regex.
5. Splice the pre-validated XML fragment into place.
6. For `word/_rels/document.xml.rels`, parse existing relationship IDs (`rId#`), find the highest index, and insert new `<Relationship Id="rId#" Type="..." Target="..."/>` elements immediately before `</Relationships>`.
7. Repack the ZIP archive using standard `zipfile.ZIP_DEFLATED`.

### Standard Python Rebuild Skeleton

```python
import os
import zipfile
import re

def patch_docx(base_docx_path, output_docx_path, modifications):
    """
    Unpacks base_docx, applies targeted string substitutions to XML parts,
    and repacks to output_docx without altering unedited parts or namespaces.
    """
    temp_dir = "/tmp/docx_unpack"
    os.makedirs(temp_dir, exist_ok=True)
    
    with zipfile.ZipFile(base_docx_path, 'r') as zin:
        zin.extractall(temp_dir)
        
    # 1. Modify word/document.xml
    doc_xml_path = os.path.join(temp_dir, "word", "document.xml")
    with open(doc_xml_path, "r", encoding="utf-8") as f:
        doc_xml = f.read()
        
    for target_pattern, replacement in modifications.get("document_xml", []):
        doc_xml = doc_xml.replace(target_pattern, replacement)
        
    with open(doc_xml_path, "w", encoding="utf-8") as f:
        f.write(doc_xml)
        
    # 2. Modify word/_rels/document.xml.rels if adding links/media
    if "relationships" in modifications:
        rels_path = os.path.join(temp_dir, "word", "_rels", "document.xml.rels")
        with open(rels_path, "r", encoding="utf-8") as f:
            rels_xml = f.read()
        for rel_entry in modifications["relationships"]:
            # Insert before </Relationships> without modifying root namespace
            rels_xml = rels_xml.replace("</Relationships>", f"  {rel_entry}\n</Relationships>")
        with open(rels_path, "w", encoding="utf-8") as f:
            f.write(rels_xml)

    # 3. Repack cleanly into new DOCX
    with zipfile.ZipFile(output_docx_path, 'w', zipfile.ZIP_DEFLATED) as zout:
        for root, _, files in os.walk(temp_dir):
            for file in files:
                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, temp_dir)
                zout.write(full_path, rel_path)
```

---

## 3. Automated Native PDF Generation (`render_pdf.py`)

Generating an accurate PDF matching Microsoft Word's exact layout, fonts, and pagination is performed natively via macOS AppleScript or headless LibreOffice.

### Critical macOS & Word AppleScript Safeguards

In macOS environments, Microsoft Word is sandboxed (`com.microsoft.Word`). Automated rendering will hang or time out if any of the following occur:

1. **Modal Alerts Hang AppleScript:**
   - Always execute `set display alerts to alerts none` before opening documents. This suppresses font warnings, compatibility mode prompts, and update queries.
2. **File Overwrite Prompts:**
   - If a file with the target PDF name already exists, Word's GUI displays an overwrite confirmation sheet that blocks headless AppleScript execution.
   - **Rule:** Always delete any preexisting destination `.pdf` file prior to executing AppleScript.
3. **Quarantine Extended Attributes:**
   - Files downloaded, extracted, or generated by external processes may carry the `com.apple.quarantine` attribute. macOS Gatekeeper prompts the user to verify opening quarantined files.
   - **Rule:** Run `xattr -d com.apple.quarantine <docx_path>` before launching Word.
4. **AppleEvent Timeout:**
   - The default AppleScript AppleEvent timeout is 120 seconds. Wrap the operation in an explicit `with timeout of 120 seconds` block.
5. **Existing Open Instances / Recovery Windows:**
   - If Word already has the target document open with an unsaved modal dialog or unreadable-content repair prompt, AppleScript calls to Word will fail with `User canceled. (-128)`.
   - Ensure Word is idle or terminate stale instances (`killall "Microsoft Word"`) prior to batch rendering.

### Usage

```bash
python3 .agents/skills/develop-versioned-documents/scripts/render_pdf.py <path_to_docx> [output_pdf_path]
```

When `output_pdf_path` is omitted, the script automatically places `<document_stem>.pdf` in the same directory alongside the `.docx`.

---

## 4. Standard Document Update Checklist

When making an update to a controlled document:

1. **Reserve Build:** Run `start_build.py` to get the next `D<number>`.
2. **Translate Request:** Write `changes/D<number>.md`.
3. **Apply Edits:**
   - If using semantic tools, edit `documents/working/<stable_name>.docx`.
   - If patching OOXML directly, use the surgical string/fragment pattern above.
4. **Render PDF:**
   ```bash
   python3 .agents/skills/develop-versioned-documents/scripts/render_pdf.py "path/to/<stable_name>.docx"
   ```
5. **Run QA Audits:**
   ```bash
   python3 .agents/skills/develop-versioned-documents/scripts/audit_docx.py "path/to/<stable_name>.docx" --expected-build D<#> --expected-release v0 --expected-status working_draft --json "path/to/qa/reports/D<#>-audit.json"
   python3 .agents/skills/develop-versioned-documents/scripts/compare_docx_packages.py "path/to/base.docx" "path/to/<stable_name>.docx" --json "path/to/qa/reports/D<#>-diff.json"
   ```
6. **Update Manifest & Changelog:** Synchronize SHA-256 in `project.json` and `CHANGELOG.md`.
