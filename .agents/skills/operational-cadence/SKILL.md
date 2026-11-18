---
name: operational-cadence
description: >-
  Manage autonomous scheduled operational cadences, automated weekly executive
  briefing generation, literature/paper tracking, and system maintenance routines.
---

# Autonomous Operational Cadence & Executive Briefing Skill

This skill automates periodic maintenance, research tracking, and executive markdown reporting across projects.

## Core Capabilities

1. **Executive Operations Briefing (`docs/reports/YYYY-WNN_executive_briefing.md`):**
   - Summarizes active milestones, closed plans, and critical operational KPIs.
   - Synthesizes research findings and risk assessments into a clean executive format.
2. **Scheduled Operational Maintenance:**
   - Database WAL checkpointing and storage pruning.
   - Link portability and dependency security checks.
3. **Research Literature Tracking:**
   - Scans and indexes relevant technical whitepapers and literature linkages.

## Executive Report Template

```markdown
# Executive Operations Briefing — Week NN, YYYY

## 1. Executive Operations Summary
- **Active Milestones:** Summary of progress.
- **Closed Milestones:** Completed tasks and walkthrough links.
- **Key Performance Indicators:** Measurable outcomes.

## 2. System Health & Maintenance Status
- **Database Status:** WAL integrity verified.
- **Security & Link Hygiene:** 0 broken links, 0 machine paths.
```
