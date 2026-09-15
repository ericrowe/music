# Gemini / Antigravity Repository Instructions

This repository is configured with a unified multi-agent system. All authoritative guidelines, rules, and procedures are defined in [AGENTS.md](AGENTS.md).

## Quick Reference for Gemini / Antigravity

- **Primary Instruction File:** [AGENTS.md](AGENTS.md)
- **Controlled Documents Skill:** `$develop-versioned-documents` located in `.agents/skills/develop-versioned-documents/`
- **Wind Loading & Stability Skill:** `$calculate-prop-wind-loading` located in `.agents/skills/calculate-prop-wind-loading/`
- **Helper Scripts:** `.agents/skills/develop-versioned-documents/scripts/` (and `.codex/skills/develop-versioned-documents/scripts/`)
- **Key Invariants:**
  - Stable filename only; no version tokens in filename (e.g., `Sideline_Screen_Duck_Blind_Build_Instructions.docx`).
  - Internal builds use `D<number>`; public releases use `v<number>`.
  - Visible lifecycle markings: `WORKING DRAFT — NOT FOR USE`, `MANUAL REVIEW REQUIRED — NOT RELEASED`, `RELEASE CANDIDATE — APPROVAL REQUIRED`, `RELEASED — APPROVED FOR USE`.
  - Full render and 100% all-page review required before review promotion or release.
- **Multi-Project Support:** When working in a subproject directory (e.g., `PCHSMB/_Backdrop/`), Antigravity automatically discovers and loads the local `GEMINI.md` / `AGENTS.md` and `project.json` which override repository defaults.
- **Documentation Concurrency & Continuum Trigger:** When modifying prop designs or build guides, update all registered subproject docs concurrently (AGENTS.md § 5). When Backdrop or Sideline Screen docs change, automatically review `PCHSMB/2026 Continuum/` docs and propose updates to the user.

