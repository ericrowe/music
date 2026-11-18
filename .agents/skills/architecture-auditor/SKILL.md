---
name: architecture-auditor
description: >-
  Audit codebase architecture, verify documentation-to-code symbol linkage,
  detect architectural drift, and generate pre-flight release audit reports.
---

# Architecture & Code-to-Docs Linkage Auditor Skill

This skill enforces strict parity between written technical specifications and actual codebase implementation, preventing documentation decay.

## Audit Standards

1. **Symbol & Linkage Verification:**
   - Every class, function, database model, REST endpoint, and UI component referenced in documentation must resolve to a real code definition.
   - Code docstrings and guides must match actual parameters and schemas.
2. **Pre-Flight Release Audits:**
   - Produces structured reports (`docs/SYSTEM_AUDIT_AND_LINKAGE_REPORT.md`) assessing architectural health before live deployments.
3. **Single Source of Truth Invariant:**
   - Reconciles persistent storage ledgers against live in-memory representations.
