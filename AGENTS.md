# Repository Instructions & Cross-Agent Standard

## 1. Universal Cross-Agent Architecture

This repository uses **`AGENTS.md`** as the single, authoritative source of truth for all AI coding agents. To prevent configuration drift, tool-specific adapter files (`GEMINI.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, `.cursorrules`, `.windsurfrules`) point directly to this file.

### Agent-Specific Discovery & Invocations

| AI Assistant / Agent | Discovery Path | Skill / Workflow Invocation |
|---|---|---|
| **Google Gemini / Antigravity** | `AGENTS.md`, `GEMINI.md`, `.agents/skills/` | `$develop-versioned-documents` skill or Python helpers in `.agents/skills/develop-versioned-documents/scripts/` |
| **OpenAI Codex** | `AGENTS.md`, `.codex/skills/` | `$develop-versioned-documents` skill or Python helpers in `.codex/skills/develop-versioned-documents/scripts/` |
| **Anthropic Claude Code** | `CLAUDE.md` (delegates to `AGENTS.md`) | Python helpers in `.agents/skills/develop-versioned-documents/scripts/` |
| **GitHub Copilot / Workspace** | `.github/copilot-instructions.md` | Python helpers or project workflows |
| **Cursor IDE** | `.cursorrules`, `.cursor/rules/*.mdc` | Python helpers or scoped rule commands |
| **Windsurf (Codeium)** | `.windsurfrules` | Python helpers or cascade workflow commands |
| **Aider / Cline / Roo Code** | `AGENTS.md`, `CONVENTIONS.md` | Terminal execution of Python helper scripts |

---

## 2. Repository Scope & Multi-Project Structure

This repository is an umbrella / host repository supporting multiple independent, loosely coupled projects:
1. **Music & Fabrication Projects:** FreeCAD models (`.FCStd`), 3MF slicer files (`.3mf`), and STL meshes (`.stl`) for instrument accessories, 3D printed mutes, marching band props (PCHSMB), standcessories, flute wall mounts, and luggage tags.
2. **Controlled Document Projects:** Repository-backed illustrated assembly manuals, build guides, operations guides, and technical deliverables in Word (`.docx`) format associated with specific subprojects.

### Multi-Project Isolation Model

- **Autonomous Subprojects:** Each subproject (e.g., `PCHSMB/_Backdrop`, `PCHSMB/_Sideline Screen`, `Trumpet/Mutes`, `Flutes/Double Flute Stand`) operates independently.
- **Local Control:** Subprojects with documentation maintain their own `project.json` manifest, local `AGENTS.md`, internal D-build sequence (`D1`, `D2`, …), public releases (`v1`, `v2`, …), and SHA-256 digests. There is no monolithic document state at the repository root.
- **Task Scope Separation:**
  - When working on **pure 3D CAD / fabrication tasks** (modifying `.FCStd`, exporting `.3mf`/`.stl`), follow **Section 3 (General Engineering & CAD Guidelines)** without triggering document QA gates.
  - When authoring or revising **controlled Word documents**, follow **Section 4 (Controlled Document Development Process)** within that subproject's directory.

---

## 3. General Engineering & CAD Guidelines

- Treat master CAD files (`.FCStd`, Affinity `.afdesign`, SVG vector sources) as authoritative.
- Never overwrite CAD models or mesh exports in place without explicit instruction.
- Preserve file relationships between source CAD files and exported 3MF / STL / STEP files.
- Keep clean Markdown documentation (`README.md`) in subdirectories describing hardware, printing parameters, and assembly.

---

## 4. Controlled Document Development Process

Use `$develop-versioned-documents` (or helper scripts) for any multi-pass Word document, illustrated manual, build guide, operations guide, or repository-backed deliverable.

### 4.1 Order of Precedence Before Editing

When editing or developing documentation within a subproject, read in this order:

1. The nearest project-level `AGENTS.md` (e.g., in `PCHSMB/_Backdrop/AGENTS.md`).
2. The subproject's `project.json` manifest.
3. The active `changes/D<number>.md` record.
4. Technical, figure-style, version-history, or source references relevant to requested changes.
5. This repository root `AGENTS.md` (for global invariants, safety baselines, and cross-agent tooling).

Project-level instructions control over root instructions whenever specific facts, dimensions, or constraints differ.

### 4.2 Source-of-Truth & Filename Rules

- `project.json` and its SHA-256 digest identify the current controlled base. Filenames and modification dates do not.
- The distributed DOCX has one stable descriptive filename (e.g., `Sideline_Screen_Duck_Blind_Build_Instructions.docx`). Never append a development build (`D24`), release (`v1`), or date suffix to that filename.
- `D<number>` is an internal build ID (never reused, including abandoned builds). `v0` means unreleased; `v1` and later are public releases.
- Build and release snapshots use versioned directories with the stable filename:
  - Development build snapshot: `documents/builds/D24/<stable-name>.docx`
  - Public release snapshot: `documents/releases/v1/<stable-name>.docx`
- Do not edit `documents/current/`, build snapshots, releases, raw uploads, or approved figure sources directly. Start a working build with `start_build.py`.
- Browser or download caching is handled by content hashes, repository commits, Library versions, ETags, or delivery URLs—never by renaming the document.

### 4.3 In-Document Version and Status Controls

- Every DOCX contains a visible version-history table with one-line descriptions: `Version | Date | Status | One-line description`.
- Unreleased review builds show `Release v0 (unreleased)`, the current D-number (e.g. `Development build D24`), and the required visible status.
- At the first public release, remove all D-number rows and compress their changes into `v1 — Initial release`.
- At later releases, compress all D-number rows since the prior release into one new release row. Keep earlier public release rows.
- Released documents show only the public release version; no D-number may remain in visible text, headers, footers, properties, or stored metadata.

#### Required Visible Markings

| Document state | Visible marking |
|---|---|
| Authoring / automated QA | `WORKING DRAFT — NOT FOR USE` |
| Human review | `MANUAL REVIEW REQUIRED — NOT RELEASED` |
| Final release QA | `RELEASE CANDIDATE — APPROVAL REQUIRED` |
| Public release | `RELEASED — APPROVED FOR USE` |

`Changes requested`, `Automated QA`, and `Abandoned` are repository states and do not require a separate marking in the DOCX.

### 4.4 Change Boundaries & OOXML Safety

- Translate each request into an explicit change set (`changes/D<number>.md`) before authoring.
- Keep edits local. Preserve unrelated wording, styles, drawings, fields, relationships, links, bookmarks, section breaks, and pagination.
- Do not use broad paragraph or run replacement for a localized change. Word may split text and embedded objects across runs.
- When the user asks to review a standalone figure, do not update the DOCX until that asset is accepted.
- Treat user-provided replacement artwork as authoritative for the mapped figure. Framing, labels, captions, and alt text are separate presentation derivatives.

### 4.5 Word and Figure Safety

- Prefer inline images with a separate caption paragraph immediately following.
- Retain aspect ratio and sufficient resolution at print size.
- Match the project's framing, padding, label, color, line-weight, and part-ID conventions. Technical geometry and dimensions control over appearance.
- Give every informative figure meaningful alt text.
- Preserve intentional web hyperlinks. Prohibit linked pictures, attached templates, OLE links, external-data fields, and other externally loaded content unless explicitly authorized.

### 4.6 Review and Release Gates

No build may be published for manual review, and no release may be published, until all applicable gates pass:

1. DOCX ZIP integrity and internal relationships pass.
2. The final bytes render to page PNGs and every page is inspected at 100%; changed figures are also checked at 200%.
3. Page count, section starts, headings, captions, headers, footers, and page numbers meet expectations.
4. Accessibility, fields, images, external-content, and update-on-open audits pass.
5. Package, text, and visual differences from the current base are explained.
6. The stable filename, internal build/release markers, visible status, version history, date, properties, headers, and footers agree.
7. For a release, no D-number remains and the compressed one-line release summary is present.

### 4.7 Helper Scripts

Scripts are located in `.agents/skills/develop-versioned-documents/scripts/` (and mirrored in `.codex/skills/...`):

- `init_document_project.py`: Initialize project directory and manifest.
- `start_build.py`: Begin internal development build or `--prepare-release` build.
- `audit_docx.py`: Package, accessibility, version, and status audit.
- `compare_docx_packages.py`: Diff package parts and extracted text.
- `record_visual_review.py`: Attest 100% all-page review and 200% figure inspection.
- `transition_status.py`: Enforce lifecycle state transitions and bind QA evidence.
- `publish_review_build.py`: Promote candidate to stable current file and snapshot `documents/builds/D#/`.
- `release_document.py`: Publish public release and snapshot `documents/releases/v#/`.
- `abandon_build.py`: Preserve rejected candidate and retire D-number.
- `register_initial_build.py`: Register initial unreleased D1 build when starting without a base.

### 4.8 Delivery

Deliver the stable-named DOCX. Report its internal build or public release, visible status, material changes, page count, and QA result.
