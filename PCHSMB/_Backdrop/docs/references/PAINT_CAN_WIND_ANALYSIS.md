# Rolling Backdrop System — Paint Can Wind Relief Cut Engineering Analysis

**Subproject:** Pine Creek High School Marching Band (PCHSMB) Rolling Backdrop Fleet (10 Units)  
**Prop Envelope:** 10.0 ft H × 8.0 ft W (80.0 sq ft face) on 96.0" × 44.5" Rolling Wood Cart Base  
**Parent Technical Spec:** [`docs/references/TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md)  
**Controlling Wind Cut Standard:** [`docs/references/WIND_RELIEF_CUTS_SPECIFICATION.md`](WIND_RELIEF_CUTS_SPECIFICATION.md)  
**Date:** September 2026  
**Status:** Engineering Trade Study & Layout Reference  

---

## 1. Executive Summary & Purpose

This engineering document evaluates the aerodynamic, structural, and field operational impacts of using a **standard 1-gallon paint can** to trace semicircular wind relief cuts in the custom-printed scrim vinyl banners of the PCHSMB Rolling Backdrop fleet, rather than the documented fleet standard of **$8.0\text{ in.}$ chord $\times 4.0\text{ in.}$ downward drop ($R = 4.0\text{ in.}$)**.

In commercial US paint retail and shop practice, a standard metal 1-gallon paint can has a nominal body diameter of **$6.50\text{ in.}$** and an outer lip/rim (chime) diameter of **$6-5/8\text{ in.}$ ($6.625\text{ in.}$)**. Tracing the body or rim of a 1-gallon can yields a true semicircle with **$W = 6.50\text{ in.}$ chord width** and **$R = 3.25\text{ in.}$ downward drop** ($R = 3.31\text{ in.}$ at the rim).

*(Note: A 1-quart paint can has an outer diameter of $\approx 4.25\text{ in.}$, yielding only $7.09\text{ sq in.}$ per cut. At that size, over 28 cuts per backdrop would be required, making it wholly impractical for banner fabrication).*

### Key Findings Summary

| Parameter | Documented Fleet Standard | 1-Gallon Paint Can (6.5" Base) | Impact Summary |
|---|:---:|:---:|---|
| **Flap Width (Chord $W$)** | $8.00\text{ in.}$ | $6.50\text{ in.}$ | $-1.50\text{ in.}$ ($-18.8\%$) |
| **Flap Drop (Radius $R$)** | $4.00\text{ in.}$ | $3.25\text{ in.}$ | $-0.75\text{ in.}$ ($-18.8\%$) |
| **Area per Flap ($A_1$)** | $25.13\text{ sq in.}$ ($0.1745\text{ sq ft}$) | $16.59\text{ sq in.}$ ($0.1152\text{ sq ft}$) | **$-34.0\%$ vent area per cut** |
| **Punch Hole Spacing** | $8.00\text{ in.}$ center-to-center | $6.50\text{ in.}$ center-to-center | Pre-punch holes must be located $1.50\text{ in.}$ closer |
| **Scenario A: Keep 8 Cuts** | $1.40\text{ sq ft}$ ($1.75\%$ face) | $0.92\text{ sq ft}$ ($1.15\%$ face) | $C_d$ degrades to $\approx 1.08$; $-0.4\text{ to }-0.6\text{ mph}$ stability loss |
| **Scenario B: Scale to Match Area** | 8 Cuts ($1.40\text{ sq ft}$) | **12 Cuts** ($1.38\text{ sq ft}$, $1.73\%$ face) | Full $C_d = 1.02$ restored; requires 3 rows of 4 columns |

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

## 3. Wind Load Analysis & Forward Tipping Stability

The critical stability failure mode of the PCHSMB Rolling Backdrop is **forward tipping over the front casters under rear wind**. Because the vertical upright frame sits at the front perimeter rail ($x = 1.5\text{ in.}$), deadweight provides virtually zero restoring lever arm against forward rotation.

### 3.1 Aerodynamic Drag Scaling

Solid, unvented scrim vinyl exhibits a flat-plate drag coefficient of $C_d = 1.20$. Standard $8.0\text{ in.}$ semicircular flaps reduce this to $C_d = 1.02$ ($\sim 15.0\%$ steady-state drag reduction).

When vent area drops by $34\%$ under Scenario A (keeping 8 cuts), net drag reduction drops proportionally:
$$\Delta C_d \approx (1.20 - 1.02) \times \frac{0.922\text{ sq ft}}{1.396\text{ sq ft}} = 0.18 \times 0.660 = 0.119$$
$$C_{d, \text{can}} \approx 1.20 - 0.119 = \mathbf{1.081}$$

Allowable wind velocity scales inversely with the square root of $C_d$:
$$V_{\text{can}} = V_{\text{solid}} \times \sqrt{\frac{1.20}{1.081}} = 1.0536 \cdot V_{\text{solid}} \quad (+5.4\% \text{ vs. solid; } -2.9\% \text{ vs. standard slits})$$

### 3.2 Stability Table Across Ballast Tiers (Colorado Springs: 6,500 ft ASL)
*Calculated using `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py` ($q = 0.001989 \cdot V^2\text{ psf}$, $\rho = 0.0595\text{ lb/ft}^3$, $A = 80.0\text{ sq ft}$, $z_{cp} = 5.79\text{ ft}$ above turf, deck height $9.0\text{ in.}$, critical pivot axis at front casters):*

| Ballast Tier | Ballast Configuration | Prop Weight on Turf | Solid Vinyl ($C_d = 1.20$) | Paint Can 8-Cut ($C_d = 1.08$) | Standard 8″ 8-Cut ($C_d = 1.02$) | Paint Can 12-Cut ($C_d = 1.02$) | Stability Delta vs. Std |
|---|---|:---:|:---:|:---:|:---:|:---:|:---:|
| **Tier 0: Calm** | 0 bags (Dry cart) | 153 lb | 13.3 mph | **14.0 mph** | 14.4 mph | **14.4 mph** | **$-0.4\text{ mph}$** |
| **Tier 1: Normal** | 4× 15-lb bags on wings | 213 lb | 15.6 mph | **16.4 mph** | 16.9 mph | **16.9 mph** | **$-0.5\text{ mph}$** |
| **Tier 2: Advisory** | 6× 15-lb bags on wings | 243 lb | 17.0 mph | **17.9 mph** | 18.4 mph | **18.4 mph** | **$-0.5\text{ mph}$** |
| **Tier 3: High-Wind**| 6 wing + 3 rear rail | 288 lb | 20.8 mph | **21.9 mph** | 22.5 mph | **22.5 mph** | **$-0.6\text{ mph}$** |

*At sea level travel venues (e.g., BOA Grand Nationals in Indianapolis, air 23% denser):*
- Solid vinyl on Tier 3 ballast tips forward at $18.8\text{ mph}$.
- Paint Can 8-cut on Tier 3 ballast tips forward at **$19.7\text{ mph}$** (a $-0.6\text{ mph}$ de-rating below the standard $20.3\text{ mph}$).
- Paint Can 12-cut fully restores the **$20.3\text{ mph}$** threshold.

---

## 4. Cut Count & Placement Layout Options

### Option A: 12-Flap Scaled Grid (3 Rows × 4 Columns) — [RECTANGULAR GRID VARIANT]

To preserve the engineered $1.40\text{ sq ft}$ vent area and maintain the official $C_d = 1.02$ stability thresholds, the cut count can increase from 8 to **12 flaps** in a 3×4 grid:
$$N = \frac{201.06\text{ sq in.}}{16.59\text{ sq in.}} = 12.12 \approx \mathbf{12\text{ flaps}}$$

- **Horizontal Columns (4):** $X = 19.2\text{ in.}, 38.4\text{ in.}, 57.6\text{ in.}, 76.8\text{ in.}$ (nominal shop: $20\text{ in.}, 38\text{ in.}, 58\text{ in.}, 76\text{ in.}$).
- **Row 1 (Upper):** Hinge at **$Y = 96.0\text{ in.}$**; Arc apex at $Y = 92.75\text{ in.}$.
- **Row 2 (Mid-Upper):** Hinge at **$Y = 84.0\text{ in.}$**; Arc apex at $Y = 80.75\text{ in.}$.
- **Row 3 (Lower Vent):** Hinge at **$Y = 72.0\text{ in.}$**; Arc apex at $Y = 68.75\text{ in.}$.
- **Vertical Web:** Leaves **$8.75\text{ in.}$ of solid vinyl** between rows.
- **Drawback:** Orthogonal grid alignment creates visible matrix repetition ("swiss cheese" effect) against show artwork.

---

### Option B: 8-Flap Grid (2 Rows × 4 Columns) — [REDUCED VENTING VARIANT]

If the build crew retains the documented 8-cut count:
- **Horizontal Columns (4):** $X = 19.2\text{ in.}, 38.4\text{ in.}, 57.6\text{ in.}, 76.8\text{ in.}$.
- **Row 1 (Upper):** Hinge at **$Y = 96.0\text{ in.}$**; Arc apex at $Y = 92.75\text{ in.}$.
- **Row 2 (Lower):** Hinge at **$Y = 72.0\text{ in.}$**; Arc apex at $Y = 68.75\text{ in.}$.
- **Punch Holes:** Punched at $X_{\text{center}} \pm 3.25\text{ in.}$ ($6.50\text{ in.}$ apart on center).
- **Operational De-Rating:** Forward tipping limits must be de-rated by $-0.4\text{ to }-0.6\text{ mph}$ across all tiers.

---

### Option C: 11-Flap Straddled Quincunx (4-3-4 Pattern) — [OFFICIAL FLYER FIELD ALTERNATIVE]

To completely eliminate the "swiss cheese" grid appearance, vent both 5-ft billowing spans, and isolate the 60″ mid cross rail inside a continuous 25″ solid vinyl belt, an **11-flap straddled layout** ($Y = 96″, 74″, 46″$) is specified on the official shop flyer:

```
   0"          16.0"      26.7"      37.3"      48.0"      58.7"      69.3"      80.0"       96.0"
  +-------------+----------+----------+----------+----------+----------+----------+----------+----+
  |                                                                                           | 120" (Top)
  |             (O)==(O)              (O)==(O)              (O)==(O)              (O)==(O)    | 96" (Row 1: 4 flaps)
  |              \___/                 \___/                 \___/                 \___/      |
  |                                                                                           | 18.9" Solid Web
  |                        (O)==(O)              (O)==(O)              (O)==(O)               | 74" (Row 2: 3 flaps)
  |                         \___/                 \___/                 \___/                 | 70.9" Apex
  |                         =================================================                 | 10.1" Solid Buffer Above
  | =============================== 60" MID CROSS RAIL (BEHIND VINYL) ======================= | 60" Mid Rail
  |                         =================================================                 | 13.2" Solid Buffer Below
  |             (O)==(O)              (O)==(O)              (O)==(O)              (O)==(O)    | 46" (Row 3: 4 flaps)
  |              \___/                 \___/                 \___/                 \___/      | 42.9" Apex
  |                                                                                           |
  |                           [ UNVENTED LOWER GRAPHIC ZONE — 42.9" SOLID ]                   |
  +-------------------------------------------------------------------------------------------+ 0" (Bottom)
```

#### Exact Coordinate Schedule (11 Flaps — Straddled Across 60″ Rail):
- **Row 1 (Upper, $Y = 96.0\text{ in.}$):** 4 flaps centered at $X = 16.0\text{ in.}, 37.3\text{ in.}, 58.7\text{ in.}, 80.0\text{ in.}$.
- **Row 2 (Mid, $Y = 74.0\text{ in.}$):** 3 flaps staggered between columns at $X = 26.7\text{ in.}, 48.0\text{ in.}, 69.3\text{ in.}$.
- **Row 3 (Lower, $Y = 46.0\text{ in.}$):** 4 flaps centered back at $X = 16.0\text{ in.}, 37.3\text{ in.}, 58.7\text{ in.}, 80.0\text{ in.}$.
- **60″ Mid Rail Belt:** A continuous **$24.9\text{ in.}$ solid vinyl belt** (from $Y = 46.0\text{ in.}$ to $Y = 70.9\text{ in.}$) isolates the steel pipe ($10.1\text{ in.}$ buffer above / $13.2\text{ in.}$ buffer below), completely preventing fabric chafing and mechanical flap obstruction.
- **Harmonized Shop Line Snapping:** Shares identical row heights ($96″, 74″, 46″$) with the 8.0″ Fleet Standard 3-2-3 pattern.
- **Total Vent Area:** $11 \times 15.34\text{ sq in.} = 168.74\text{ sq in.} = \mathbf{1.172\text{ sq ft}}$ ($1.46\%$ porosity).
- **Aerodynamic Stability:** $C_d = \mathbf{1.05}$ ($-12.6\%$ drag reduction); Tier 3 tipping speed is **$22.0\text{ mph}$** (within $0.3\text{ mph}$ of 8″ standard).
- **Diagonal Flap Separation:** Expands to **$24.5\text{ in.} \text{ to } 29.9\text{ in.}$** diagonally, completely dissolving visual clustering.

---

## 5. Non-Linear Dynamic & Practical Shop Considerations

1. **Hinge Stiffness vs. Aerodynamic Opening Force:**
   - Aerodynamic opening torque scales with flap area $\times$ centroid arm ($\propto R^3$).
   - Resistance to bending along the uncut top hinge line scales with chord length ($\propto R$).
   - The ratio $\frac{M_{\text{aero}}}{M_{\text{bend}}} \propto R^2$. A $6.5\text{ in.}$ flap has **$34\%$ less aerodynamic leverage to flex heavy 13–18 oz scrim vinyl** than an $8\text{ in.}$ flap. In light breezes ($6–10\text{ mph}$), smaller flaps may remain partially closed until dynamic pressure rises.
2. **Thermal Sagging & Optical Camouflage:**
   - Because true semicircular geometry ($D/W = 0.50$) is preserved, gravity stiffness is outstanding. The shorter $3.25\text{ in.}$ drop hangs 100% flat with zero thermal tongue droop, remaining completely undetectable from spectator stands.
3. **Volunteer Labor Across 10 Backdrops:**
   - 8-cut standard: 80 cuts / 160 punched holes.
   - 12-cut paint can: **120 cuts / 240 punched holes** (+40 cuts and +80 punched holes across the backdrop build session).
4. **Tooling & Cut Quality:**
   - Freehand tracing around a metal paint can rim with a razor knife on loose vinyl can be awkward due to the rolled chime lip and bail ears, increasing the risk of edge micro-nicks.
   - Using the project's dedicated 3D-printable **Circle Cutter** tool ([`generate_circle_cutter.py`](../../Circle%20Cutter/generate_circle_cutter.py)) is strongly recommended whenever possible, as it provides a guided rotary blade with a precision $0.5\text{ mm}$ depth stop that guarantees clean, notch-free arcs.
