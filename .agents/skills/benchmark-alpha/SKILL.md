---
name: benchmark-alpha
description: >-
  Evaluate active portfolio performance, active alpha attribution, period-matched
  SPY relative returns, and broad index beta gating rules.
---

# Benchmark Alpha & Beta Gating Skill

This skill governs the system's mandate to generate verifiable active alpha over the S&P 500 (`SPY`) benchmark over a medium-to-long-term rolling horizon (>1 month).

## Core Principles

1. **Benchmark Alpha Mandate:**
   - Active equity must outperform passive buy-and-hold SPY.
   - Evaluated over a rolling $>1\text{ month}$ horizon.
   - Active Alpha: $\alpha_t = R_{\text{portfolio}} - R_{\text{SPY}}$.
2. **Period-Matched Win/Loss Accounting:**
   - Every individual trade outcome is evaluated relative to SPY over the exact same entry-to-exit holding period:
     $$\alpha_{\text{trade}} = R_{\text{trade}} - R_{\text{SPY}, [t_{\text{entry}}, t_{\text{exit}}]}$$
   - `ALPHA_WIN`: $\alpha > 0.0$
   - `ALPHA_LOSS`: $\alpha \le 0.0$ (Captures opportunity cost failures).
3. **Index Beta Gating & Allocation Ceilings:**
   - Broad index ETFs (`SPY`, `QQQ`, `IWM`, `DIA`) require $\ge 0.85$ confidence and Tier 1/2 macro catalysts.
   - Aggregate index exposure capped at $6,000.00 (20% of portfolio budget).
   - Tactical SPY trading is valid when macro trends indicate index tracking is the highest-probability setup.
