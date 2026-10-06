# Lighting Controller Platform Document Instructions

## Project Identity

- Stable document filenames: `Lighting_Controller_Pilot_Build_BOM.pdf`, `Carrier_Board_BOM_Purchasing_Guide.pdf`, `REQUIREMENTS.md`
- Project slug: `pchs-lighting-controller-system`
- Machine state: `project.json`
- Controlling technical facts: `REQUIREMENTS.md`, `CARRIER_BOARD_SCHEMATICS.md`
- Subproject root: `PCHSMB/_Lighting Controller/`

## Cross-Agent Compatibility

This project is configured for multi-agent support:
- **Google Gemini / Antigravity**: Uses `.agents/skills/develop-versioned-documents`, `.agents/skills/requirements-engineering`, and `AGENTS.md`.
- **OpenAI Codex**: Uses `.codex/skills/develop-versioned-documents`, `.codex/skills/requirements-engineering`, and `AGENTS.md`.
- **Anthropic Claude Code**: Reads `CLAUDE.md`.
- **Cursor / Windsurf**: Reads `.cursorrules` / `.windsurfrules`.

## Universal Architectural Invariants

1. **Platform Independence**: This subproject is a top-level, permanent PCHSMB engineering platform. It must remain decoupled from specific show themes, storylines, or single-season graphic treatments.
2. **Zero-Software Show Reprogramming**: High school band directors and volunteer parents must be able to change show cues, lighting colors, chase patterns, timings, and prop mappings without software development tools, coding, IDEs, or AI prompting (`REQ-SW-01`).
3. **Rigorous Systems Requirements**: All requirements must follow INCOSE GtWR and ISO/IEC/IEEE 29148:2018 EARS syntax (`REQ-SYS`, `REQ-SYN`, `REQ-PRP`, `REQ-FW`, `REQ-SW`).
4. **Hardware Master Standard**: Schematics, PCB layouts, and gerbers under `hardware/` are the authoritative hardware sources of truth.
