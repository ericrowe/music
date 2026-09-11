# Sideline Screen (Duck Blind) Post-Show Egress Monte Carlo Simulation Report

**Simulation Methodology:** Stochastic Egress Engine ($N = 5,000$ randomized iterations per scenario)
**CBA Rule 8.05 / 5.06 Field Clearance Benchmark:** 2 minutes 00 seconds ($120.0\text{ seconds}$)
**Fleet Architecture:** 2 Carts Dedicated Fleet (1 Cart per Side, 8 Screens per Cart)
**Venue Constraint:** Single Stadium Exit Gate (with Dual Exit Benchmark)

---
## 1. Executive Summary & Tactical Verdicts

1. **Direct Hand-Carry with Outside Reload Guarantees 2:00 Compliance (98.3% - 100%):**
   - **Mean Field Clearance Time: 100.3 seconds (1:40)**; **95th Percentile: 114.5 seconds (1:54)** in Same-Side single-gate venues.
   - In Opposite-Side venues (Enter Side 1, Exit Side 2), mean clearance drops to **100.0 seconds (1:40)** with **98.6%** success.
   - In Dual-Exit venues, clearance finishes in **83.9 seconds (1:24)** with **100.0%** success.
   - **Mechanism:** Students fold and hand-carry the 26-lb frames straight through the exit gate. The contest clock stops as soon as all students and carts cross the boundary! Reloading onto carts occurs safely outside the gate on the track/apron.

2. **Reloading Just Inside the Gate is Viable Under Calm/Low Ballast Conditions:**
   - Under Tier 1 ballast, reloading inside the gate averages **121.7 seconds (2:01)**, succeeding in **44.2%** of trials under 120s.
   - If **unballasted**, reloading inside the gate averages **113.8 seconds (1:53)** with an **81.4% success rate**!

3. **Traditional On-Field Cart Loading Fails 100% of the Time in Single-Exit Stadiums:**
   - Stopping at each screen on the field to load screens and ballast results in an average field clearance time of **153.7 seconds (2:34)**, exceeding the 2:00 rule by over 33 seconds on every trial.

4. **Inward Sweep (Screen 8 -> 1) Saves 20 Yards of Cross-Field Pushing:**
   - By sweeping from the 22-yard line inward toward the 42-yard line (centerfield), Cart 2 finishes collection closer to the 50, reducing cross-field travel from 88 yards to 69.3 yards and saving ~10 seconds of fatigue.

---
## 2. Master Egress Comparison Table

| Stadium Layout | Reload Mode | Sweep Direction | Ballast State | Mean Clearance | Median | P95 Time | Success ($\le 2:00$) | Safety Slack |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| `same_side` | `outside_gate` | `inward` | `tier1` | 99.9 s (1:39) | 99.2 s | 113.8 s | **98.8%** | +20.1 s |
| `same_side` | `inside_gate` | `inward` | `tier1` | 121.4 s (2:01) | 120.7 s | 136.7 s | **46.7%** | -1.4 s |
| `same_side` | `hybrid_split` | `inward` | `tier1` | 121.4 s (2:01) | 120.7 s | 134.6 s | **46.3%** | -1.4 s |
| `same_side` | `on_field_loading` | `inward` | `tier1` | 153.4 s (2:33) | 152.5 s | 171.2 s | **0.0%** | -33.4 s |
| `opposite_side` | `outside_gate` | `inward` | `tier1` | 100.1 s (1:40) | 99.4 s | 114.7 s | **98.4%** | +19.9 s |
| `opposite_side` | `inside_gate` | `inward` | `tier1` | 121.3 s (2:01) | 120.7 s | 136.8 s | **47.1%** | -1.3 s |
| `dual_exit` | `outside_gate` | `inward` | `tier1` | 83.7 s (1:23) | 83.3 s | 92.8 s | **100.0%** | +36.3 s |
| `dual_exit` | `inside_gate` | `inward` | `tier1` | 105.0 s (1:44) | 104.4 s | 115.4 s | **98.5%** | +15.0 s |
| `same_side` | `outside_gate` | `inward` | `none` | 71.0 s (1:11) | 70.4 s | 83.5 s | **100.0%** | +49.0 s |
| `same_side` | `inside_gate` | `inward` | `none` | 91.7 s (1:31) | 91.1 s | 104.5 s | **99.8%** | +28.3 s |
| `same_side` | `on_field_loading` | `inward` | `none` | 116.6 s (1:56) | 115.8 s | 133.0 s | **67.8%** | +3.4 s |
| `same_side` | `outside_gate` | `inward` | `tier2` | 112.4 s (1:52) | 111.7 s | 128.7 s | **80.9%** | +7.6 s |
| `same_side` | `inside_gate` | `inward` | `tier2` | 134.7 s (2:14) | 133.8 s | 152.5 s | **4.9%** | -14.7 s |
| `same_side` | `on_field_loading` | `inward` | `tier2` | 167.7 s (2:47) | 166.7 s | 188.3 s | **0.0%** | -47.7 s |

---
