# `plan-pipeline` — Standardized Plan-Driven Feature Development Lifecycle

`plan-pipeline` is a standalone, zero-dependency Python package, CLI tool, and AI coding agent skill bundle (`plan-pipeline` + `idea-triage`) that enforces a rigorous **5-Step Plan-Driven Feature Development Lifecycle** across single-project repositories and multi-project workspaces:

1. **Step 0: Asynchronous Idea Intake & Interactive Triage (`docs/plans/IDEAS.md`)**
2. **Step 1: Formal 7-Section Plan Creation (`docs/plans/NN_<name>_plan.md`)**
3. **Step 2: Human-in-the-Loop (HITL) Approval Gate**
4. **Step 3: 3-Phase Test-First Execution (`RED/Baseline` $\rightarrow$ `GREEN` $\rightarrow$ `Full Regression`)**
5. **Step 4: Interactive User Validation**
6. **Step 5: Coverage Ratchet Check, Link-Safe Archival (`docs/plans/complete/YYYY-MM-DD-<plan>.md`), Walkthrough & Git Commit**

---

## CLI Commands

```bash
# 1. Initialize plan-pipeline skills, pointer files, and docs/plans/ in any repository
python3 -m plan_pipeline.cli init --path /path/to/repo --name "My-Project"

# 2. View active, proposed, queued, and on-hold plans across a workspace
python3 -m plan_pipeline.cli status

# 3. Validate one or all active plans against the 7 mandatory sections & portable link rules
python3 -m plan_pipeline.cli validate --all

# 4. Scaffold a new 7-section plan and register it in docs/plans/AGENTS.md
python3 -m plan_pipeline.cli new --id 01 --slug feature_name --title "Feature Title"

# 5. Archive a validated plan (moves to complete/YYYY-MM-DD-..., re-anchors relative links, writes walkthrough, updates AGENTS.md)
python3 -m plan_pipeline.cli archive --plan docs/plans/01_feature_name_plan.md --summary "Implemented feature and verified tests."
```
