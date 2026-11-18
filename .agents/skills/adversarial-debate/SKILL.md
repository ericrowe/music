---
name: adversarial-debate
description: >-
  Conduct structured 3-role adversarial red-teaming (Advocate, Critic, Arbiter)
  to stress-test complex architectural decisions or high-risk refactors before coding.
---

# Adversarial Multi-Agent Debate & Red-Teaming Skill

This skill stress-tests architectural proposals, high-risk code refactors, or critical engineering decisions by simulating a structured 3-agent committee before writing code.

## 3-Role Committee Architecture

1. **Advocate (Proponent / Bull):**
   - Presents the optimal upside case, architectural benefits, and performance improvements.
2. **Critic (Adversary / Bear):**
   - Attacks vulnerabilities, edge cases, failure modes, race conditions, and hidden complexities.
3. **Arbiter (Neutral Synthesizer):**
   - Weighs asymmetric risk-reward, resolves contentions, and issues a final consensus verdict with mandatory guardrails.

## Output Format

```markdown
### Adversarial Debate Consensus
- **Decision:** [APPROVED / APPROVED_WITH_GUARDRAILS / REJECTED]
- **Key Risks Identified:** Vulnerabilities surfaced by Critic.
- **Mandatory Guardrails:** Required constraints to protect system integrity.
```
