# GitHub Copilot Instructions

This repository follows the multi-agent standard documented in [AGENTS.md](../AGENTS.md).

## Key Guidelines

- **Source of Truth:** Always refer to [AGENTS.md](../AGENTS.md), [docs/plans/AGENTS.md](../docs/plans/AGENTS.md), and project `project.json` manifests.
- **Plan Pipeline & Tests:** Use `python3 scripts/plan_pipeline.py status | validate | new | archive` and `./run_tests.sh`.
- **Stable Document Filenames:** Do not rename Word documents with version numbers or dates.
- **CAD & Mesh Files:** Respect FreeCAD (`.FCStd`) models as sources of truth over exported meshes (`.3mf`, `.stl`, `.step`).
- **Controlled Documents:** Execute builds and QA using scripts in `.agents/skills/develop-versioned-documents/scripts/` (or `.codex/skills/...`).
