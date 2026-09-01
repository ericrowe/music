# {{PROJECT_TITLE}} document instructions

## Project identity

- Stable document filename: `{{DOCUMENT_FILENAME}}`
- Project slug: `{{PROJECT_SLUG}}`
- Machine state: `project.json`
- Controlling technical facts: `references/TECHNICAL_SPEC.md`
- Figure system: `references/FIGURE_STYLE.md`
- Figure provenance and status: `references/FIGURE_REGISTER.csv`

## Cross-agent compatibility

This project is configured for multi-agent support:
- **Google Gemini / Antigravity**: Uses `.agents/skills/develop-versioned-documents` and `GEMINI.md` / `AGENTS.md`.
- **OpenAI Codex**: Uses `.codex/skills/develop-versioned-documents` and `AGENTS.md`.
- **Anthropic Claude Code**: Reads `CLAUDE.md` (references this file).
- **Cursor / Windsurf**: Reads `.cursorrules` / `.windsurfrules` (references this file).

## Audience and purpose

Describe the real reader, use environment, and decision or task the document
must support. State which sections may be printed or distributed independently.

## Durable terminology

Record exact product, assembly, appendix, part, role, and status names. Preserve
capitalization and abbreviations across text, figures, captions, and alt text.

## Source priority

Use sources in this order unless a current reviewer instruction says otherwise:

1. Current explicit reviewer instruction.
2. Current reviewer-supplied artwork, markup, or source file.
3. Approved technical sources and `TECHNICAL_SPEC.md`.
4. The current controlled document in `project.json`.
5. Visual or editorial inference.

Ask when equally authoritative sources conflict. Never let a visually cleaner
drawing override known technical geometry.

## Project-specific constraints

List durable rules that materially change document work, such as dimensions,
orientation, fastener placement, safety wording, approved materials, print size,
figure framing, color meaning, or independently printable sections.

## Explicit exclusions

List content, sections, claims, external dependencies, or visual elements that
must not be added or changed without separate approval.

## Version and status rules

- The current base and digest named in `project.json` are authoritative.
- Never add a D-number or v-number to `{{DOCUMENT_FILENAME}}`. Builds and
  releases live inside the document and in versioned repository directories.
- Use `D<number>` for internal development builds and `v<number>` for public
  releases. `v0` means unreleased.
- Every DOCX must visibly show one approved status marking and contain a version
  history table governed by `references/VERSION_HISTORY.md`.
- Do not edit the current controlled file, build snapshots, releases, original
  uploads, or approved art in place. Work in the stable file under
  `documents/working/`.
- Use `$develop-versioned-documents` and its helper scripts for every build.
- When a standalone figure is requested, do not update the DOCX before approval.
- Keep unrelated text, figures, links, bookmarks, fields, sections, and page flow
  unchanged.
- Complete every review or release gate before promotion.
