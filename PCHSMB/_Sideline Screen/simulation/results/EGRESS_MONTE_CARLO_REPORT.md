# Sideline Screen (Duck Blind) Post-Show Egress Monte Carlo Simulation Report

**Simulation Methodology:** Stochastic Egress Engine ($N = 5,000$ randomized iterations per scenario)
**CBA Rule 8.05 / 5.06 Field Clearance Benchmark:** 2 minutes 00 seconds ($120.0\text{ seconds}$)
**CBA Rule 5.05 Exit Compliance:** Props exit through the front half of the end zone; 30-yard line clearance rule verified.

---
## 1. Executive Summary & Tactical Verdicts

1. **Direct Hand-Carry Egress is the Ultimate Speed Champion:**
   - **Mean Time: 83.7 seconds (1:24)**; **95th Percentile: 93.3 seconds (1:33)**.
   - **Success Rate: 100.0%** under the 2-minute CBA clock.
   - **How it works:** Each of the 8 student performers on each side unclips and folds their screen (6s), picks up the 26-lb folded frame, and jogs straight out through the front half of the end zone (15s). The cart only rolls down the sideline to collect ballast sandbags, completely avoiding cart loading delays!

2. **Cart Loading with Pre-Folded Screens Requires Fast Handlers to Meet 2:00:**
   - Under Tier 1 ballast, loading both screens and sandbags onto 2 carts averages **129.6 seconds (2:10)**, succeeding in only **6.7%** of trials under 120s.
   - If screens are **unballasted**, cart loading finishes in **100.6 seconds (1:41)** with a **99.2% success rate**.

3. **1 Cart Fleet Egress Fails Catastrophically (0.0% Success):**
   - A single cart attempting to sweep both sides of the field takes **220.7 seconds (3:41)**, exceeding the 2-minute limit by over 100 seconds on every trial.

4. **CBA Rule 5.05 End Zone Routing Advantage:**
   - Because Screen 8 is located at the 22-yard line (already past the 30-yard line), carts and students have legal authorization to exit straight through the front half of the end zone ($Y \in [0, 26.67\text{ yd}]$), running only **32 yards straight ahead** to clear the field with zero corner turns.

---
## 2. Master Egress Comparison Table

| Fleet Config | Exit Gate Mode | Strategy | Ballast State | Mean Time | Median | P95 Time | Success ($\le 2:00$) | Safety Slack |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **2_carts** | `dual` | `direct_hand_carry` | `tier1` | 83.5 s (1:23) | 82.9 s | 93.0 s | **100.0%** | +36.5 s |
| **2_carts** | `dual` | `parallel_pre_fold` | `tier1` | 129.6 s (2:09) | 129.0 s | 141.6 s | **5.4%** | -9.6 s |
| **2_carts** | `dual` | `crew_only_fold` | `tier1` | 206.6 s (3:26) | 205.8 s | 220.0 s | **0.0%** | -86.6 s |
| **1_cart** | `dual` | `direct_hand_carry` | `tier1` | 366.2 s (6:06) | 365.3 s | 389.9 s | **0.0%** | -246.2 s |
| **1_cart** | `dual` | `parallel_pre_fold` | `tier1` | 220.9 s (3:40) | 220.0 s | 242.0 s | **0.0%** | -100.9 s |
| **1_cart** | `dual` | `crew_only_fold` | `tier1` | 366.2 s (6:06) | 365.3 s | 389.9 s | **0.0%** | -246.2 s |
| **2_carts** | `side1_only` | `direct_hand_carry` | `tier1` | 125.8 s (2:05) | 124.9 s | 144.6 s | **30.6%** | -5.8 s |
| **2_carts** | `side1_only` | `parallel_pre_fold` | `tier1` | 186.5 s (3:06) | 185.4 s | 211.0 s | **0.0%** | -66.5 s |

---
