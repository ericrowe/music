# GitHub Copilot Instructions

This repository follows the multi-agent standard documented in [AGENTS.md](../AGENTS.md).

## Key Guidelines

- **Source of Truth:** Always refer to [AGENTS.md](../AGENTS.md) and project `project.json` manifests.
- **Stable Document Filenames:** Do not rename Word documents with version numbers or dates.
- **CAD & Mesh Files:** Respect FreeCAD (`.FCStd`) models as sources of truth over exported meshes (`.3mf`, `.stl`, `.step`).
- **Controlled Documents:** Execute builds and QA using scripts in `.agents/skills/develop-versioned-documents/scripts/` (or `.codex/skills/...`).
