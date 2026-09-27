# Stage Platform Construction and Operations Guide Document Instructions

## Project Identity

- Stable document filename: `Stage_Platform_Build_Instructions.docx` (and `Stage_Platform_Build_Instructions.pdf` / `.typ`)
- Project slug: `stage-platform-construction-and-operations-guide`
- Machine state: `project.json`
- Controlling technical facts: `references/STAGE_GAP_BRIDGE_ANALYSIS.md`
- Subproject root: `PCHSMB/_Stages/`

## Cross-Agent Compatibility

This project is configured for multi-agent support:
- **Google Gemini / Antigravity**: Uses `.agents/skills/develop-versioned-documents` and `GEMINI.md` / `AGENTS.md`.
- **OpenAI Codex**: Uses `.codex/skills/develop-versioned-documents` and `AGENTS.md`.
- **Anthropic Claude Code**: Reads `CLAUDE.md`.
- **Cursor / Windsurf**: Reads `.cursorrules` / `.windsurfrules`.

## Audience and Purpose

- **Audience:** PCHS Marching Band parent volunteers, fabrication crew, stage managers, and student stage handlers.
- **Purpose:** Provide complete, step-by-step instructions for fabricating the rolling stage platform half-units, building mobile staircases, assembling the 6.0-inch inter-section gap bridge, installing vinyl graphics with velcro seam closures, and operating on the competition field.
- **Universal Architecture Standard:** Adheres strictly to the canonical document architecture defined in [`PCHSMB/AGENTS.md`](../../AGENTS.md). The Cost Breakdown must always appear in Appendix B immediately preceding the assembly stages.

## Durable Terminology

- `PCHS Marching Band Performance Stage` (official prop title)
- `Stage Platform Half-Unit (Front "F" & Back "B")`, `Mobile Staircase`
- `Inter-Section Gap Bridge` (6.0-inch gap bridging mechanism)
- `Sub-Deck Ledgers` (recessed cleats supporting the flush bridge)
- `Over-Center Draw Latches` (chassis connection clamping hardware)
- `Velcro Seam Flap` (vinyl graphic transition cover)

## Project-Specific Constraints

- Fleet consists of four (4) complete stages (8 half-units) and four (4) mobile staircases.
- Inter-section gap between docked half-units is nominal 6.0 inches.
- Walking decks must remain **100% flush** across the seam; vertical lips exceeding 1/4 inch are strictly prohibited as athletic trip hazards.
- Stage chassis must be positively clamped together using mechanical draw latches to prevent dynamic gap expansion on turf.
- Flat-top cargo mode: each stage must safely transport four (4) collapsed Sideline Screens (16 total fleet screens) between trucks and staging.

## Version and Status Rules

- Current state: Initial scoping & analysis (`D0` / `Rev 1.0`).
- Markings:
  - Working builds: `WORKING DRAFT — NOT FOR USE`
  - Review builds: `MANUAL REVIEW REQUIRED — NOT RELEASED`
  - First public release: `RELEASED — APPROVED FOR USE` (`v1`)
