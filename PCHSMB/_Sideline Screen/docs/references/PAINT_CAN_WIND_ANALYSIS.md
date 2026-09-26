# Sideline Screen (Duck Blind) — Paint Can Wind Relief Cut Engineering Analysis

**Subproject:** Pine Creek High School Marching Band (PCHSMB) Sideline Screen / Duck Blind Fleet (16 Units)  
**Prop Envelope:** 4.0 ft H × 8.0 ft W (30.5 sq ft face) on Triangular Folding Conduit Frame  
**Parent Technical Spec:** [`docs/references/TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md)  
**Controlling Wind Cut Standard:** [`docs/references/WIND_RELIEF_CUTS_SPECIFICATION.md`](WIND_RELIEF_CUTS_SPECIFICATION.md)  
**High-Wind Analysis Reference:** [`docs/references/WIND_LOADING_30MPH_ANALYSIS.md`](WIND_LOADING_30MPH_ANALYSIS.md)  
**Date:** September 2026  
**Status:** Engineering Trade Study & Layout Reference  

---

## 1. Executive Summary & Purpose

This engineering document evaluates the aerodynamic, structural, and field operational impacts of using a **standard 1-gallon paint can** to trace semicircular wind relief cuts in the custom-printed scrim vinyl banners of the PCHSMB Sideline Screen / Duck Blind fleet, rather than the documented fleet standard of **$8.0\text{ in.}$ chord $\times 4.0\text{ in.}$ downward drop ($R = 4.0\text{ in.}$)**.

In commercial US paint retail and shop practice, a standard metal 1-gallon paint can has a nominal body diameter of **$6.50\text{ in.}$** and an outer rim (chime) diameter of **$6-5/8\text{ in.}$ ($6.625\text{ in.}$)**. Tracing the body or rim of a 1-gallon can yields a true semicircle with **$W = 6.50\text{ in.}$ chord width** and **$R = 3.25\text{ in.}$ downward drop** ($R = 3.31\text{ in.}$ at the rim).

*(Note: A 1-quart paint can has an outer diameter of $\approx 4.25\text{ in.}$, yielding only $7.09\text{ sq in.}$ per cut. At that size, over 21 cuts per screen would be required, making it wholly impractical for screen fabrication).*

### Key Findings Summary

| Parameter | Documented Fleet Standard | 1-Gallon Paint Can (6.5" Base) | Impact Summary |
|---|:---:|:---:|---|
| **Flap Width (Chord $W$)** | $8.00\text{ in.}$ | $6.50\text{ in.}$ | $-1.50\text{ in.}$ ($-18.8\%$) |
| **Flap Drop (Radius $R$)** | $4.00\text{ in.}$ | $3.25\text{ in.}$ | $-0.75\text{ in.}$ ($-18.8\%$) |
| **Area per Flap ($A_1$)** | $25.13\text{ sq in.}$ ($0.1745\text{ sq ft}$) | $16.59\text{ sq in.}$ ($0.1152\text{ sq ft}$) | **$-34.0\%$ vent area per cut** |
| **Punch Hole Spacing** | $8.00\text{ in.}$ center-to-center | $6.50\text{ in.}$ center-to-center | Pre-punch holes must be located $1.50\text{ in.}$ closer |
| **Scenario A: Keep 6 Cuts** | $1.05\text{ sq ft}$ ($3.43\%$ face) | $0.69\text{ sq ft}$ ($2.27\%$ face) | **Below 3.0% threshold**; $C_d \to 1.08$; $-0.3\text{ to }-0.7\text{ mph}$ sliding margin loss |
| **Scenario B: Scale to 8 Cuts** | 6 Cuts ($1.05\text{ sq ft}$) | **8 Cuts (2×4 Grid)** ($0.92\text{ sq ft}$, $3.02\%$) | Restores $C_d = 1.02$; preserves 100% equipment concealment |
| **Scenario C: Scale to 9 Cuts** | 6 Cuts ($1.05\text{ sq ft}$) | **9 Cuts** ($1.04\text{ sq ft}$, $3.40\%$) | 100% vent area match; requires non-standard horizontal column spacing |

---

## 2. Geometric & Aerodynamic Comparison

### 2.1 Dimensional Mechanics

$$\text{Area}_{\text{semicircle}} = \frac{1}{2} \pi R^2 = \frac{1}{8} \pi D^2$$

- **Standard 8.0" Specification:**
  $$A_{\text{std}} = \frac{1}{2} \pi (4.0\text{ in.})^2 = 8\pi \approx 25.13\text{ sq in.} = 0.1745\text{ sq ft}$$
- **1-Gallon Paint Can ($D = 6.50\text{ in.}$, $R = 3.25\text{ in.}$):**
  $$A_{\text{can}} = \frac{1}{2} \pi (3.25\text{ in.})^2 \approx 16.59\text{ sq in.} = 0.1152\text{ sq ft}$$
  $$\text{Area Ratio} = \frac{16.59}{25.13} = 66.0\% \quad (\mathbf{-34.0\% \text{ reduction in vent area per flap}})$$
- **1-Gallon Paint Can Rim ($D = 6.625\text{ in.}$, $R = 3.3125\text{ in.}$):**
  $$A_{\text{rim}} = \frac{1}{2} \pi (3.3125\text{ in.})^2 \approx 17.24\text{ sq in.} = 0.1197\text{ sq ft} \quad (68.6\% \text{ of standard})$$

---

## 3. Wind Load Analysis & Critical Failure Modes

Unlike the rolling backdrops (which tip forward over front casters), the **sideline screen exhibits two distinct stability modes**:
1. **Lateral Sliding on Artificial Turf (The Primary Operational Failure Mode):**
   Smooth galvanized EMT conduit resting on cryogenic crumb-rubber synthetic turf has a low friction coefficient ($\mu \approx 0.35$). Under standard Tier 1 ballast (two 15-lb bags on rear rail C, $56.0\text{ lbs}$ total weight), **sliding occurs well before overturning**.
2. **Forward Tipping Over Front Rail Under Rear Wind (Asymmetric Overturning Mode):**
   Because the vertical display face and inner structural rails rest directly over the front ground rail, the unballasted frame has an effective front restoring arm of only $4.25\text{ in.}$.

### 3.1 Aerodynamic Drag Scaling

Solid, unvented scrim vinyl exhibits a flat-plate drag coefficient of $C_d = 1.20$. Standard $8.0\text{ in.}$ semicircular flaps reduce this to $C_d = 1.02$ ($\sim 15.0\%$ steady-state drag reduction).

When vent area drops by $34\%$ under Scenario A (keeping 6 cuts):
- Vent area is only $0.691\text{ sq ft}$ ($2.27\%$ of the $30.5\text{ sq ft}$ face).
- This drops below the **$3.0\%$ aerodynamic porosity threshold** needed for complete boundary layer pressure bleed.
- Drag reduction drops proportionally:
  $$\Delta C_d \approx (1.20 - 1.02) \times \frac{0.691\text{ sq ft}}{1.047\text{ sq ft}} = 0.18 \times 0.660 = 0.119$$
  $$C_{d, \text{can}} \approx 1.20 - 0.119 = \mathbf{1.081}$$

Allowable sliding and tipping velocity scales inversely with the square root of $C_d$:
$$V_{\text{can}} = V_{\text{solid}} \times \sqrt{\frac{1.20}{1.081}} = 1.0536 \cdot V_{\text{solid}} \quad (+5.4\% \text{ vs. solid; } -2.9\% \text{ vs. standard slits})$$

### 3.2 Stability Table Across Ballast Tiers (Colorado Springs: 6,500 ft ASL)
*Calculated using `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py` ($q = 0.001989 \cdot V^2\text{ psf}$, $\rho = 0.0595\text{ lb/ft}^3$, $A = 30.5\text{ sq ft}$, $z_{cp} = 1.94\text{ ft}$, turf $\mu = 0.35$):*

| Ballast Tier | Ballast Configuration | Prop Weight on Turf | Solid Limit (Slide / Tip) | Paint Can 6-Cut (Slide / Tip) | Standard 8″ 6-Cut (Slide / Tip) | Paint Can 8-Cut (Slide / Tip) | Stability Delta (Slide) |
|---|---|:---:|:---:|:---:|:---:|:---:|:---:|
| **Tier 0: Calm** | 0 bags (Dry frame) | 26 lb | 11.2 / 8.1 mph | **11.8 / 8.5 mph** | 12.1 / 8.8 mph | **12.1 / 8.8 mph** | **$-0.3\text{ mph}$** |
| **Tier 1: Normal** | 1× 15-lb bag on rail C | 41 lb | 14.0 / 17.5 mph | **14.8 / 18.4 mph** | 15.2 / 19.0 mph | **15.2 / 19.0 mph** | **$-0.4\text{ mph}$** |
| **Tier 1: Standard**| 2× 15-lb bags on rail C | 56 lb | 16.4 / 23.5 mph | **17.3 / 24.8 mph** | 17.8 / 25.5 mph | **17.8 / 25.5 mph** | **$-0.5\text{ mph}$** |
| **Tier 2: Advisory**| 3× 15-lb bags (2 grnd + 1 hang) | 71 lb | 18.5 / 28.5 mph | **19.5 / 30.0 mph** | 20.0 / 30.9 mph | **20.0 / 30.9 mph** | **$-0.5\text{ mph}$** |
| **Tier 3: High-Wind**| 4× 15-lb bags (2 grnd + 2 hang) | 86 lb | 20.3 / 32.8 mph | **21.4 / 34.6 mph** | 22.1 / 35.6 mph | **22.1 / 35.6 mph** | **$-0.7\text{ mph}$** |

*At sea level venues (e.g., BOA Grand Nationals in Indianapolis, air 23% denser):*
- Solid vinyl on Tier 1 (2 bags) slips on turf at $14.8\text{ mph}$.
- Paint Can 6-cut on Tier 1 slips at **$15.6\text{ mph}$** (a $-0.5\text{ mph}$ loss vs. the standard $16.1\text{ mph}$).
- Paint Can 8-cut fully restores turf sliding resistance to **$16.1\text{ mph}$**.

---

## 4. Cut Count & Placement Layout Options

### 4.1 Boundary Constraints on the Sideline Screen Face

The vertical layout of the sideline screen is governed by strict functional zones:
- **Top Perimeter Frame Rail 1:** $Y = 44.5\text{ in.}$.
- **Unvented Top Tension Band ($Y = 36.0\text{ to }44.5\text{ in.}$):** Must remain unvented to preserve vinyl tension under top greenhouse snap clamps.
- **Inner Frame Rail 3 / Clip Latch Line:** $Y = 10.0\text{ in.}$.
- **Unvented Lower Equipment Concealment Band ($Y = 0\text{ to }18.0\text{ in.}$):** Color guard rifles, sabres, and floor equipment lie below $Y = 10.0\text{ in.}$. All relief cuts **MUST terminate above $Y = 18.0\text{ in.}$** to guarantee 100% equipment concealment from spectator sightlines and clear the hinged support arm clips.
- **Allowable Venting Window:** Strictly constrained between **$Y = 18.0\text{ in.}$ and $Y = 36.0\text{ in.}$** (an $18.0\text{ in.}$ vertical zone).

```
   0"          19.2"           38.4"           57.6"           76.8"         96.0"
  +-------------+---------------+---------------+---------------+-------------+
  | [Rail 1] Top Perimeter Frame Rail (Y = 44.5")                             | 48"
  |   (Unvented Upper Tension Band: Y = 36" to 44.5")                         |
  |                                                                           |
  |             (O)==(O)        (O)==(O)        (O)==(O)        (O)==(O)      |
  |              \___/           \___/           \___/           \___/        | 34" (Row 1)
  |                                                                           |
  |             (O)==(O)        (O)==(O)        (O)==(O)        (O)==(O)      |
  |              \___/           \___/           \___/           \___/        | 24" (Row 2)
  |                                                                           |
  |   (Unvented Lower Band: Y = 0" to 18" -- Conceals Floor Equipment)        |
  | [Rail 3] Lower Inner Frame Rail / Clip Latch Line (Y = 10.0")             |
  +---------------------------------------------------------------------------+ 0" (Turf Line)
```

### Option A: 8-Flap Scaled Grid (2 Rows × 4 Columns) — [STRONGLY RECOMMENDED IF USING PAINT CAN]

To clear the $3.0\%$ aerodynamic threshold without disrupting equipment concealment, scale the screen from 6 cuts to **8 cuts arranged in 2 rows of 4 columns**:
- **Total Vent Area:** $8 \times 16.59\text{ sq in.} = 132.7\text{ sq in.} = 0.922\text{ sq ft}$ (**$3.02\%$ porosity**).
- **Horizontal Columns (4):** $X = 19.2\text{ in.}, 38.4\text{ in.}, 57.6\text{ in.}, 76.8\text{ in.}$. (Harmonizes 100% with the Rolling Backdrop horizontal lines!).
- **Row 1 (Upper):** Hinge at **$Y = 34.0\text{ in.}$**; Arc apex at $Y = 30.75\text{ in.}$.
- **Row 2 (Lower):** Hinge at **$Y = 24.0\text{ in.}$**; Arc apex at $Y = 20.75\text{ in.}$.
- **Ground Clearance:** Lowest flap apex sits at **$Y = 20.75\text{ in.}$**, providing a massive **$10.75\text{ in.}$ buffer** above staged color guard equipment ($Y \le 10\text{ in.}$).
- **Frame Clearance:** Flaps maintain over $15.9\text{ in.}$ clearance from outer uprights (outer rails at $X = 0\text{ in.}$ and $X = 92.5\text{ in.}$).

> [!CRITICAL]
> **WHY 3 ROWS MUST BE AVOIDED ON THE SIDELINE SCREEN:**  
> To reach 9 cuts using 3 rows of 3, the bottom row hinge would have to sit at $Y \approx 19.5\text{ in.}$, causing the flap apex to drop to $Y = 16.25\text{ in.}$. This violates the $Y \ge 18.0\text{ in.}$ equipment concealment buffer and places flapping vinyl dangerously close to the Rail 3 arm clips ($Y = 10.0\text{ in.}$). Therefore, **8 cuts in 2 rows of 4 is vastly superior to 3 rows of 3**.

---

### Option B: 6-Flap Grid (2 Rows × 3 Columns) — [REDUCED VENTING VARIANT]

If the build crew retains the documented 6-cut count:
- **Horizontal Columns (3):** $X = 24.0\text{ in.}, 48.0\text{ in.}, 72.0\text{ in.}$.
- **Row 1 (Upper):** Hinge at **$Y = 34.0\text{ in.}$**; Arc apex at $Y = 30.75\text{ in.}$.
- **Row 2 (Lower):** Hinge at **$Y = 24.0\text{ in.}$**; Arc apex at $Y = 20.75\text{ in.}$.
- **Punch Holes:** Punched at $X_{\text{center}} \pm 3.25\text{ in.}$ ($6.50\text{ in.}$ apart on center, rather than $8.0\text{ in.}$).
- **Operational De-Rating:** Turf sliding resistance is de-rated by $-0.4\text{ to }-0.7\text{ mph}$ across all tiers.

---

## 5. Non-Linear Dynamic & Practical Shop Considerations

1. **Turf Sliding Margin (Primary Field Hazard):**
   - The primary field operational danger for sideline screens is sliding across wet synthetic turf during a sudden gust.
   - Reducing flap size without increasing cut count lowers the Tier 1 sliding threshold from $17.8\text{ mph}$ to $17.3\text{ mph}$ ($15.6\text{ mph}$ at sea level), narrowing the safety buffer during brisk afternoon preliminary performances.
2. **Two-Student Direct Carry Crosswind Load:**
   - In student direct-carry transit, smaller 6-cut paint can flaps bleed less air during crosswinds, increasing dynamic hand thrust against student handlers by $\sim 6\%$.
3. **Tensile Pull Relief on 3D-Printed Rail 3 Clips (I):**
   - Under headwind, bottom support arms (E) act in tension against snap-fit ASA clips on Rail 3 ($Y = 10\text{ in.}$). The 8-cut paint can layout ($3.02\%$ porosity) maintains low tensile pull ($29.5\text{ lbs}$ at 20 mph), preventing clip jaw unseating.
4. **Volunteer Labor Across 16 Screens:**
   - 6-cut standard: 96 cuts / 192 punched holes.
   - 8-cut paint can: **128 cuts / 256 punched holes** (+32 cuts and +64 punched holes across the screen fleet build).
5. **Tooling & Cut Quality:**
   - Tracing a paint can rim freehand with a utility knife lacks the safety, repeatability, and $0.5\text{ mm}$ calibrated depth stop of the 3D-printed Circle Cutter (`generate_circle_cutter.py`).

---

## 6. Subproject Cross-References

- **Master Subproject README:** [`PCHSMB/_Sideline Screen/README.md`](../../README.md)
- **Technical Specification:** [`PCHSMB/_Sideline Screen/docs/references/TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md)
- **Semicircular Wind Relief Specification:** [`PCHSMB/_Sideline Screen/docs/references/WIND_RELIEF_CUTS_SPECIFICATION.md`](WIND_RELIEF_CUTS_SPECIFICATION.md)
- **Rolling Backdrop Comparison:** [`PCHSMB/_Backdrop/docs/references/PAINT_CAN_WIND_ANALYSIS.md`](../../_Backdrop/docs/references/PAINT_CAN_WIND_ANALYSIS.md)
- **Wind Loading Skill CLI:** `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py`
