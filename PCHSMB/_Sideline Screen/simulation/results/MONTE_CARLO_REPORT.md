# Sideline Screen (Duck Blind) Deployment Monte Carlo Simulation Report
**Simulation Methodology:** Stochastic Monte Carlo Engine ($N = 5,000$ randomized iterations per scenario)
**CBA Competition Rule Limit:** 3 minutes 15 seconds ($195.0\text{ seconds}$, CBA Rule 5.06)
**Fleet Scale:** 16 total screens (8 screens on Side 1, 8 screens on Side 2; centerfield edge on 42-yard line moving outward)

---
## 1. Executive Summary & Core Verdicts
1. **Two-Student Carry (Walk-Across) is the Fastest Field Deployment Paradigm:**
   - **Mean Time: 55.7 seconds (0:55)**; **95th Percentile: 58.3 seconds (0:58)**.
   - **Success Rate: 100.0%** (100% compliant with CBA Rule 5.06).
   - Leaves an astonishing **+139.3 seconds (~2 min 19s) of safety buffer** before the 3:15 clock expires.
   - **Zero Adult Violation Risk:** Requires **0 adult volunteers on the turf**, eliminating any risk of CBA Rule 4.03 adult boundary penalties (0.2 pts/occurrence).
   - **Operational Caveat:** Requires **32 student handlers** (25–30% of a 100-member band) and exposes handlers to aerodynamic wind loading across open turf.

2. **2 Carts with Pre-Set Student Receivers is the Practical Gold Standard:**
   - **Mean Time: 133.7 seconds (2:14)**; **95th Percentile: 147.8 seconds (2:28)**.
   - **Success Rate: 100.0%** under all starting locations.
   - Balances speed with low personnel footprint (only 2 adult pushers + 16 student receivers).

3. **1 Cart Deployment is Operationally Infeasible under Standard Conditions:**
   - With Tier 1 ballast carried on the cart ($786\text{ lbs}$ gross payload), a single cart pushing across both sides of the field takes **234.5 seconds (3:55)** with Pre-Set Receivers, resulting in a **0.2% success rate (99.8% failure/penalty rate)**.
   - With Mobile Pincer setup, 1 Cart takes **321.9 seconds (5:22)**, with **0.0% success rate**.

4. **Optimal Starting Location for Carts: Back Sideline at 20-Yard Line (`Back_20`):**
   - Ingress distance is only **55 yards** straight down the 20-yard line corridor to the outer screen boundary.

---
## 2. Master Comparison Table: Deployment Strategies across Starting Locations
*(Baseline: Tier 1 Ballast, Average Fitness Parent Pusher / Student Pairs)*

| Fleet Config | Starting Location | Setup Strategy | Mean Time | Median | P95 Time | P99 Time | Success Rate ($T \le 3:15$) | Safety Slack |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **Two-Student Carry (32 crew)** | `Back_Sideline` | Walk-Across (Assembled) | **55.7 s (0:55)** | 55.7 s | 58.3 s | 59.7 s | **100.0%** | **+139.3 s** |
| **2 Carts (8/side)** | `EZ_Behind_Goal` | Pre-Set Receivers | 145.0 s (2:24) | 144.2 s | 160.3 s | 168.7 s | **100.0%** | +50.0 s |
| **2 Carts (8/side)** | `EZ_Behind_Goal` | Mobile Pincer | 209.5 s (3:29) | 208.6 s | 225.8 s | 235.6 s | **4.0%** | -14.5 s |
| **2 Carts (8/side)** | `EZ_Corner_Back` | Pre-Set Receivers | 171.9 s (2:51) | 170.7 s | 192.8 s | 203.8 s | **96.2%** | +23.1 s |
| **2 Carts (8/side)** | `EZ_Corner_Back` | Mobile Pincer | 235.9 s (3:55) | 234.6 s | 257.2 s | 269.8 s | **0.0%** | -40.9 s |
| **2 Carts (8/side)** | `Back_20` | Pre-Set Receivers | 133.9 s (2:13) | 133.0 s | 148.5 s | 156.6 s | **100.0%** | +61.1 s |
| **2 Carts (8/side)** | `Back_20` | Mobile Pincer | 198.0 s (3:18) | 197.4 s | 213.4 s | 221.7 s | **38.6%** | -3.0 s |
| **2 Carts (8/side)** | `Back_40` | Pre-Set Receivers | 133.9 s (2:13) | 133.0 s | 148.5 s | 156.5 s | **100.0%** | +61.1 s |
| **2 Carts (8/side)** | `Back_40` | Mobile Pincer | 198.0 s (3:17) | 197.3 s | 213.3 s | 221.6 s | **38.6%** | -3.0 s |
| **2 Carts (8/side)** | `Back_50` | Pre-Set Receivers | 144.9 s (2:24) | 144.0 s | 161.4 s | 170.2 s | **100.0%** | +50.1 s |
| **2 Carts (8/side)** | `Back_50` | Mobile Pincer | 209.0 s (3:29) | 208.2 s | 226.1 s | 235.4 s | **5.3%** | -14.0 s |
| **1 Cart (16 total)** | `EZ_Behind_Goal` | Pre-Set Receivers | 249.4 s (4:09) | 247.8 s | 280.8 s | 298.7 s | **0.0%** | -54.4 s |
| **1 Cart (16 total)** | `EZ_Behind_Goal` | Mobile Pincer | 336.8 s (5:36) | 335.5 s | 366.1 s | 381.7 s | **0.0%** | -141.8 s |
| **1 Cart (16 total)** | `EZ_Corner_Back` | Pre-Set Receivers | 289.5 s (4:49) | 287.5 s | 329.6 s | 353.1 s | **0.0%** | -94.5 s |
| **1 Cart (16 total)** | `EZ_Corner_Back` | Mobile Pincer | 375.7 s (6:15) | 373.8 s | 413.0 s | 433.7 s | **0.0%** | -180.7 s |
| **1 Cart (16 total)** | `Back_20` | Pre-Set Receivers | 234.1 s (3:54) | 232.7 s | 263.9 s | 280.2 s | **0.2%** | -39.1 s |
| **1 Cart (16 total)** | `Back_20` | Mobile Pincer | 321.5 s (5:21) | 320.3 s | 348.4 s | 363.3 s | **0.0%** | -126.5 s |
| **1 Cart (16 total)** | `Back_40` | Pre-Set Receivers | 265.2 s (4:25) | 263.5 s | 300.7 s | 320.8 s | **0.0%** | -70.2 s |
| **1 Cart (16 total)** | `Back_40` | Mobile Pincer | 352.0 s (5:51) | 350.3 s | 384.6 s | 402.7 s | **0.0%** | -157.0 s |
| **1 Cart (16 total)** | `Back_50` | Pre-Set Receivers | 282.6 s (4:42) | 280.6 s | 321.2 s | 343.9 s | **0.0%** | -87.6 s |
| **1 Cart (16 total)** | `Back_50` | Mobile Pincer | 368.9 s (6:08) | 367.1 s | 404.7 s | 424.8 s | **0.0%** | -173.9 s |

---
## 3. Sensitivity Analyses
### A. Pusher Fitness Sensitivity (Start: `Back_20`, Tier 1 Ballast)

| Fleet Config | Strategy | Pusher Fitness Tier | Mean Time | P95 Time | Success Rate |
|:---:|:---:|:---:|:---:|:---:|:---:|
| 2 Carts | Pre-Set Receivers | Sedentary Dad (0.82x) | 153.3 s | 170.9 s | **100.0%** |
| 2 Carts | Pre-Set Receivers | Average Dad (1.00x) | 133.9 s | 148.5 s | **100.0%** |
| 2 Carts | Pre-Set Receivers | Athletic Dad (1.18x) | 120.5 s | 131.3 s | **100.0%** |
| 2 Carts | Mobile Pincer | Sedentary Dad (0.82x) | 216.9 s | 234.8 s | **0.3%** |
| 2 Carts | Mobile Pincer | Average Dad (1.00x) | 198.0 s | 213.4 s | **38.6%** |
| 2 Carts | Mobile Pincer | Athletic Dad (1.18x) | 184.7 s | 196.4 s | **93.1%** |
| 1 Cart | Pre-Set Receivers | Sedentary Dad (0.82x) | 274.1 s | 310.7 s | **0.0%** |
| 1 Cart | Pre-Set Receivers | Average Dad (1.00x) | 234.1 s | 263.9 s | **0.2%** |
| 1 Cart | Pre-Set Receivers | Athletic Dad (1.18x) | 208.8 s | 229.9 s | **11.7%** |
| 1 Cart | Mobile Pincer | Sedentary Dad (0.82x) | 354.3 s | 386.5 s | **0.0%** |
| 1 Cart | Mobile Pincer | Average Dad (1.00x) | 321.5 s | 348.4 s | **0.0%** |
| 1 Cart | Mobile Pincer | Athletic Dad (1.18x) | 299.9 s | 319.9 s | **0.0%** |

### B. Ballast Payload Sensitivity (Start: `Back_20` / `Back_Sideline`)

| Fleet Config | Strategy | Ballast Loading State | Unit / Cart Payload | Mean Time | P95 Time | Success Rate |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **Two-Student Carry** | Walk-Across | Unballasted (Dry Frames) | 26 lbs / blind (13 lbs/student) | 49.9 s | 52.3 s | **100.0%** |
| **Two-Student Carry** | Walk-Across | Tier 1 (15 lbs ballast/blind) | 41 lbs / blind (20.5 lbs/student) | 55.7 s | 58.3 s | **100.0%** |
| **Two-Student Carry** | Walk-Across | Tier 2 (30 lbs ballast/blind) | 56 lbs / blind (28 lbs/student) | 59.3 s | 62.1 s | **100.0%** |
| **Two-Student Carry** | Walk-Across | Pre-Staged at Sideline | 26 lbs / blind (13 lbs/student) | 49.9 s | 52.3 s | **100.0%** |
| 2 Carts | Pre-Set Receivers | Unballasted (Dry Frames) | 338 lbs | 120.1 s | 133.7 s | **100.0%** |
| 2 Carts | Pre-Set Receivers | Tier 1 (15 lbs/screen on cart) | 458 lbs | 133.9 s | 148.5 s | **100.0%** |
| 2 Carts | Pre-Set Receivers | Tier 2 (30 lbs/screen on cart) | 578 lbs | 146.6 s | 163.2 s | **100.0%** |
| 2 Carts | Pre-Set Receivers | Pre-Staged at Sideline (0 lbs on cart) | 338 lbs | 122.1 s | 135.0 s | **100.0%** |
| 2 Carts | Mobile Pincer | Unballasted (Dry Frames) | 338 lbs | 170.9 s | 184.2 s | **99.6%** |
| 2 Carts | Mobile Pincer | Tier 1 (15 lbs/screen on cart) | 458 lbs | 198.0 s | 213.4 s | **38.6%** |
| 2 Carts | Mobile Pincer | Tier 2 (30 lbs/screen on cart) | 578 lbs | 210.7 s | 228.0 s | **3.4%** |
| 2 Carts | Mobile Pincer | Pre-Staged at Sideline (0 lbs on cart) | 338 lbs | 186.2 s | 199.9 s | **87.4%** |
| 1 Cart | Pre-Set Receivers | Unballasted (Dry Frames) | 546 lbs | 199.3 s | 223.8 s | **41.0%** |
| 1 Cart | Pre-Set Receivers | Tier 1 (15 lbs/screen on cart) | 786 lbs | 234.1 s | 263.9 s | **0.2%** |
| 1 Cart | Pre-Set Receivers | Tier 2 (30 lbs/screen on cart) | 1,026 lbs | 270.7 s | 306.9 s | **0.0%** |
| 1 Cart | Pre-Set Receivers | Pre-Staged at Sideline (0 lbs on cart) | 546 lbs | 201.6 s | 225.5 s | **33.3%** |
| 1 Cart | Mobile Pincer | Unballasted (Dry Frames) | 546 lbs | 259.8 s | 281.2 s | **0.0%** |
| 1 Cart | Mobile Pincer | Tier 1 (15 lbs/screen on cart) | 786 lbs | 321.5 s | 348.4 s | **0.0%** |
| 1 Cart | Mobile Pincer | Tier 2 (30 lbs/screen on cart) | 1,026 lbs | 356.4 s | 389.6 s | **0.0%** |
| 1 Cart | Mobile Pincer | Pre-Staged at Sideline (0 lbs on cart) | 546 lbs | 290.6 s | 312.4 s | **0.0%** |

---
## 4. Operational Tradeoff & Feasibility Matrix

| Operational Dimension | Two-Student Carry (Walk-Across) | 2 Carts (Pre-Set Receivers) | 1 Cart (Pre-Set Receivers) |
|:---|:---|:---|:---|
| **Deployment Speed (Mean)** | **55.8 seconds (0:56)** | **133.7 seconds (2:14)** | 234.5 seconds (3:55) |
| **95th Percentile Time** | **58.5 seconds (0:59)** | **147.8 seconds (2:28)** | 265.7 seconds (4:26) |
| **CBA 3:15 Success Rate** | **100.0% (+139s slack)** | **100.0% (+61s slack)** | 0.2% (99.8% penalty risk) |
| **Turf Staffing Footprint** | **32 students** (16 pairs) | **2 adults + 16 students** | 1 adult + 16 students |
| **Adult Boundary Penalty Risk** | **ZERO RISK** (0 adults on turf) | Low (2 adults cross front boundary) | Low (1 adult crosses front boundary) |
| **Instrument Logistics** | **Severe constraint:** 32 students cannot hold instruments while carrying | Minimal: Receivers walk out unencumbered | Minimal: Receivers walk out unencumbered |
| **Wind Loading & Sail Drag** | **High:** 8x4.5 ft vertical panel ($36\text{ sq ft}$) carried across open field in gusts | Negligible: Screens stacked edge-on on cart | Negligible: Screens stacked edge-on on cart |
| **Fatigue / Biomechanics** | 20.5 lbs / student over 53 yd walk | 458 lb cart pushed over 55 yd | 786 lb cart pushed over 230 yd |
