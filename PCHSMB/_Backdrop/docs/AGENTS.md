# Backdrop Construction and Assembly Guide Document Instructions

## Project Identity

- Stable document filename: `Backdrop_Assembly_Guide.docx`
- Project slug: `backdrop-construction-and-assembly-guide`
- Machine state: `project.json`
- Controlling technical facts: `references/TECHNICAL_SPEC.md`
- Figure system: `references/FIGURE_STYLE.md`
- Figure provenance and status: `references/FIGURE_REGISTER.csv`

## Cross-Agent Compatibility

This project is configured for multi-agent support:
- **Google Gemini / Antigravity**: Uses `.agents/skills/develop-versioned-documents` and `GEMINI.md` / `AGENTS.md`.
- **OpenAI Codex**: Uses `.codex/skills/develop-versioned-documents` and `AGENTS.md`.
- **Anthropic Claude Code**: Reads `CLAUDE.md`.
- **Cursor / Windsurf**: Reads `.cursorrules` / `.windsurfrules`.

## Audience and Purpose

- **Audience:** PCHS Marching Band parent volunteers, fabrication crew, and field logistics handlers.
- **Purpose:** Provide complete, step-by-step instructions for fabricating the rolling wood cart base (96" x 44.5"), assembling the 10' x 8' steel fence post upright frame, installing diagonal support struts, mounting vinyl banners with snap clamps, and operating/ballasting on the field.
- **Universal Architecture Standard:** Adheres strictly to the canonical document architecture defined in [`PCHSMB/AGENTS.md`](../../AGENTS.md). The Cost Breakdown must always appear in Appendix B immediately preceding the assembly stages.

## Durable Terminology

- `PCHS Marching Band Rolling Backdrop` (official prop title)
- `Rolling Cart Base`, `Upright Backdrop Frame`, `Support Struts`
- Lumber items: A (Long rails 96"), B (End rails 44.5"), C (Inner rails), D (Cross joists)
- Fasteners: Red screws (GRK #9 x 2-1/2" wood screws), Blue screws (GRK #10 x 4" structural timber screws)
- Metal hardware: 1-5/8" fence line posts, 1-5/8" 3-way clamp corner brackets, 1-5/8" tension bands, heavy-duty U-bolts
- Vinyl mounting: Heavy-duty carpet tape, 1-5/8" pipe snap clamps

## Source Priority

1. Current explicit reviewer instruction.
2. Current reviewer-supplied artwork (`Drawing.afdesign`, `Drawing.png`) and CAD models.
3. `references/TECHNICAL_SPEC.md`.
4. The controlled document in `project.json`.

## Project-Specific Constraints

- Cart dimensions are strictly 96.0" x 44.5".
- Left deck spans from B to 2nd D; right deck spans from 5th D to B; center bay between 3rd and 4th D must remain open to cradle the HDX 14-gallon tote bin.
- Galvanized steel tubing requires pre-drilling with 1/8" cobalt drill bits using the 3D-printed `Drill Alignment Jig` before driving metal screws into rail ends.
- 3D printed components (Corner Bumper Braces, Drill Jig) must be printed in Black ASA or PETG for outdoor UV and heat durability.

## Version and Status Rules

- Current state: `D1` (unreleased `v0`).
- Markings:
  - Working builds: `WORKING DRAFT — NOT FOR USE`
  - Review builds: `MANUAL REVIEW REQUIRED — NOT RELEASED`
  - First public release: `RELEASED — APPROVED FOR USE` (`v1`)
- Never append `_v1`, `_D1`, or date tokens to `Backdrop_Assembly_Guide.docx`.
