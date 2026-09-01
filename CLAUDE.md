# Claude Code Instructions

This repository is governed by the unified cross-agent standard in [AGENTS.md](AGENTS.md).

## Quick Reference for Claude Code

- **Source of Truth:** [AGENTS.md](AGENTS.md)
- **Document Workflow:** Use the helper scripts located in `.agents/skills/develop-versioned-documents/scripts/` (or `.codex/skills/develop-versioned-documents/scripts/`).
- **Stable Filename Rule:** Word documents use one stable filename for their lifetime. Do not add `_v1`, `_D24`, or date suffixes to the filename.

## Common Workflow Commands

```bash
# Start an internal development build
python3 .agents/skills/develop-versioned-documents/scripts/start_build.py <project-dir> --summary "<one-line-summary>"

# Audit DOCX package, accessibility, and status text
python3 .agents/skills/develop-versioned-documents/scripts/audit_docx.py <path/to/doc.docx> --expected-build D# --expected-release v# --expected-status <status> --expected-text "<text>" --require-stable-filename --json <report.json>

# Compare candidate with base
python3 .agents/skills/develop-versioned-documents/scripts/compare_docx_packages.py <base.docx> <candidate.docx> --json <report.json>

# Record 100% visual inspection
python3 .agents/skills/develop-versioned-documents/scripts/record_visual_review.py <candidate.docx> <render_dir> --output <visual.json> --reviewer claude --all-pages-reviewed

# Transition candidate state
python3 .agents/skills/develop-versioned-documents/scripts/transition_status.py <project-dir> --to manual_review_required --note "<note>" --audit-report <audit.json> --diff-report <diff.json> --visual-review <visual.json> --approve-diff

# Promote candidate for review
python3 .agents/skills/develop-versioned-documents/scripts/publish_review_build.py <project-dir>

# Prepare and publish a public release
python3 .agents/skills/develop-versioned-documents/scripts/start_build.py <project-dir> --prepare-release --summary "Initial release"
python3 .agents/skills/develop-versioned-documents/scripts/release_document.py <project-dir> --audit-report <audit.json> --diff-report <diff.json> --visual-review <visual.json> --approve-diff
```
