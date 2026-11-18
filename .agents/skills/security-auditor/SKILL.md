---
name: security-auditor
description: Universal security auditing runbook enforcing zero hardcoded machine paths, portable relative markdown links, secret hygiene, and dependency safety.
---

# Security Auditor Skill

## 1. Path Hygiene & Portability Standards
- **Zero Absolute Paths**: Never commit `/Volumes/`, `/Users/`, `/home/`, or `file:///` paths in codebase files, plans, or documentation.
- **Relative Link Invariant**: All markdown links must resolve to existing files on disk. Proposed new files in active plans must use code literals (`[NEW]` `path/to/file.py`) until created.
- **Space-in-Path Handling**: Always invoke Python binaries as modules (`.venv/bin/python -m pytest`) to prevent shell shebang parsing failures on paths containing spaces.

## 2. Secret Hygiene
- Ensure API keys, broker tokens, and database passwords reside in secure local `.env` files (e.g. `~/.config/trading_engine/.env`) and are never checked into version control.

## 3. Automated Security & Hygiene Auditor CLI (`scripts/audit_security_and_hygiene.py`)
Run the workspace-wide auditor anytime during development or pre-commit checks:
```bash
# Full workspace scan (paths, secrets, links, databases)
python3 scripts/audit_security_and_hygiene.py

# Focused audit vectors
python3 scripts/audit_security_and_hygiene.py --secrets-only
python3 scripts/audit_security_and_hygiene.py --paths-only
python3 scripts/audit_security_and_hygiene.py --links-only
python3 scripts/audit_security_and_hygiene.py --db-only

# Verbose file-by-file reporting
python3 scripts/audit_security_and_hygiene.py --verbose
```

## 4. Master Test Integration
The auditor is integrated into [`scripts/run_all_tests.sh`](../../../scripts/run_all_tests.sh) and unit-tested in [`tests/test_security_and_hygiene_auditor.py`](../../../tests/test_security_and_hygiene_auditor.py).
