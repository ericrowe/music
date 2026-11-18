---
name: learning-loop
description: >-
  Execute post-mortem reflection on task outcomes, user corrections, or errors,
  and consolidate distilled behavioral rules into .agents/rules/ without token bloat.
---

# Continuous Learning & Reflection Loop Skill

This skill turns real-world task outcomes, runtime anomalies, and user corrections into compact, actionable algorithmic directives while strictly bounding context window token overhead.

## Token-Optimized Memory Architecture

1. **Targeted In-Context Retrieval:**
   - Injects only the top-K relevant rules for the active task context (budget cap $\le 800$ characters / $\approx 200$ tokens).
2. **Knowledge Consolidation:**
   - When $\ge 3$ rules accumulate in a single category, consolidates them into 1 unified directive.
   - Archives raw granular post-mortems in persistent storage.
3. **Structured Lessons File (`.agents/rules/trading_lessons.md` or `.agents/rules/project_lessons.md`):**
   - Maintained automatically by the agent to ensure persistent learning across turns.
