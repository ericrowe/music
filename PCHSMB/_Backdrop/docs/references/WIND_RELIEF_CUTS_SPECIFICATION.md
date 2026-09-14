# Rolling Backdrop System — Semicircular Wind Relief Cuts Engineering Specification

**Subproject:** Pine Creek High School Marching Band (PCHSMB) Rolling Backdrop  
**Prop Envelope:** 10 ft H × 8 ft W (80.0 sq ft face) on 96.0" × 44.5" Rolling Wood Cart Base  
**Controlling Document:** [`docs/references/TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md)  
**Parent Subproject README:** [`../../README.md`](../../README.md)  
**Status:** Engineering Standard & Review Recommendation  
**Date:** September 2026  

---

## 1. Executive Summary & Core Recommendations

This specification establishes the official engineering standard for wind relief cuts in the custom-printed scrim vinyl banners of the PCHSMB Rolling Backdrop fleet (10 backdrops total).

| Parameter | Final Engineering Recommendation | Evaluation vs. Alternatives |
|---|---|---|
| **Shape Geometry** | **True Semicircular Flap** ($180^\circ$ circular arc) | **Strongly preferred over oval / elongated-U shapes.** Provides single-radius fabrication simplicity, uniform gravity-return stiffness (no tip curl/sag), zero notch risers at endpoints, and 100% tooling commonality across band prop fleets. |
| **Flap Dimensions** | **$8.0\text{ in.}$ Chord Width $\times 4.0\text{ in.}$ Downward Drop** (Radius $R = 4.0\text{ in.}$) | Matches exact radius and tooling used on the PCHSMB Sideline Screen / Duck Blind fleet. Compact 4.0" drop prevents thermal sagging while providing $25.13\text{ sq in.}$ vent area per flap. |
| **Quantity & Layout** | **8 Flaps (Primary Fleet Standard)** organized as a **2 Row × 4 Column Grid**; or **6 Flaps (Approved Minimal Option)** as a **2 Row × 3 Column Grid** | 8 flaps yield $1.40\text{ sq ft}$ total vent area (1.75% of face); 6 flaps yield $1.05\text{ sq ft}$ (1.31% of face). Drops overall prop drag coefficient from $C_d = 1.20$ to $C_d = 1.02$ (15.0% reduction in lateral drag and overturning moment). |
| **Vertical Placement** | **Upper Venting Zone (Upper 40%–65% of frame: $6.0\text{ ft}$ to $8.0\text{ ft}$ above bottom rail)** | Relieves aerodynamic pressure where overturning leverage ($z \times F$) is highest. Row 1 centered at $Y = 96\text{ in.}$ ($8.0\text{ ft}$); Row 2 centered at $Y = 72\text{ in.}$ ($6.0\text{ ft}$). Avoids bottom 4 ft and top 1 ft. |
| **Horizontal Spacing** | **8-Cut Grid:** $X = 19.2\text{ in.}, 38.4\text{ in.}, 57.6\text{ in.}, 76.8\text{ in.}$<br>**6-Cut Grid:** $X = 24.0\text{ in.}, 48.0\text{ in.}, 72.0\text{ in.}$ | Symmetrical distribution across 96" width; minimum 12" frame clearance from side upright posts and greenhouse snap clamps. |
| **Graphic Clearance** | **$\pm 6\text{ to }12\text{ in.}$ Floating Offset Rule** | Center points may float horizontally into solid backgrounds, shadows, or negative space. **Strictly prohibited** from cutting through performer faces, show typography, or band logos. |
| **Tear-Arrest Mandate** | **Pre-Punched $\varnothing 3/8\text{ in.}$ ($10\text{ mm}$) Circular Holes** | Two clean circular punch holes at chord endpoints **MUST** be executed prior to razor slicing. Eliminates sharp stress risers ($K_t \ge 3.0 \to 1.0$), permanently arresting tear propagation. |

---

## 2. Aerodynamic Physics & Overturning Mechanics

### 2.1 The 80 sq ft Sail & Forward Tipping Asymmetry

Each rolling backdrop presents a nominal $10.0\text{ ft high} \times 8.0\text{ ft wide}$ continuous solid face ($80.0\text{ sq ft}$ sail area). The center of aerodynamic pressure ($z_{cp}$) sits at approximately $5.79\text{ ft}$ ($69.5\text{ in.}$) above the athletic turf (accounting for the cart's $9.0\text{ in.}$ deck height).

The critical stability failure mode of the cart is **forward tipping over the front casters under rear wind**:
- Because the vertical upright frame and banner are attached to the **front perimeter rail** of the cart base, the frame's deadweight ($48\text{ lbs}$) sits directly above the front caster pivot axis ($x_{fwd} \approx 1.75\text{ in.}$).
- Unlike front wind (which allows the entire $3.44\text{ ft}$ cart depth to act as a stabilizing counterweight), rear wind has essentially **zero restoring leverage** from the upright frame.
- Unballasted, the prop tips forward at only **$13.3\text{ mph}$** (solid vinyl at Colorado Springs elevation).

```
          [REAR WIND] ===>                       |=======================|
                                                 |                       |
                                                 |   10' x 8' VINYL      |
                                                 |   DISPLAY SURFACE     |
                                                 |                       |
                                                 |                       |
                                                 |                       |
  [CRITICAL PIVOT AXIS]                          |                       |
          v                                      |=======================|
    (Front Casters)                                      |       |
  ========O==============================================O=======+
          ^                       ^                      ^
     Front Rail               Wing Post              Rear Rail
   (Zero Frame Arm)       (1.71 ft Lever Arm)    (3.46 ft Lever Arm)
```

### 2.2 Aerodynamic Benefit of Engineered Semicircular Relief Flaps

When wind strikes the banner, the semicircular flaps open outward along their uncut top horizontal hinge chords. This provides three critical mechanical benefits:

1. **Steady-State Drag Reduction:** Drops the net drag coefficient from $C_d = 1.20$ to $C_d = 1.02$ ($\sim 15.0\%$ reduction in lateral drag force and overturning moment).
2. **Dynamic Gust Impulse Bleed:** Stadium downdrafts and sudden wind shear create dynamic pressure spikes ($q = \frac{1}{2}\rho V^2$). Flaps rapidly vent peak dynamic pressure pulses before the inertia of the cart can transition into an overturning roll.
3. **Suppression of Destructive Vortex-Shedding Flutter:** Continuous vinyl surfaces suffer from coherent Strouhal vortex shedding (~0.5–1.2 Hz). Under sustained wind, this causes violent rhythmic billow cycles that pry the perimeter greenhouse snap clamps off the 1-5/8" steel tubing. Relief flaps bleed pressure across the surface, destroying coherent vortex formation.

### 2.3 Aerodynamic Stability Comparison (Colorado Springs: 6,500 ft ASL)

Calculated using `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py`:

| Operational Wind Tier | Prop Ballast Configuration | Max Safe Wind (Solid Vinyl: $C_d = 1.20$) | Max Safe Wind (With Semicircular Slits: $C_d = 1.02$) | Safety Margin Improvement |
|---|---|:---:|:---:|:---:|
| **Tier 0: Calm** ($0–8\text{ mph}$) | $0\text{ lbs}$ (dry wt $153\text{ lbs}$) | $13.3\text{ mph}$ (limit) | **$14.4\text{ mph}$** (limit) | **$+1.1\text{ mph}$** buffer |
| **Tier 1: Normal** ($8–12\text{ mph}$) | $60\text{ lbs}$ (4× 15-lb wing bags) | $15.6\text{ mph}$ | **$16.9\text{ mph}$** | **$+1.3\text{ mph}$** buffer |
| **Tier 2: Advisory** ($12–18\text{ mph}$) | $90\text{ lbs}$ (6× 15-lb wing bags) | $17.0\text{ mph}$ | **$18.4\text{ mph}$** | **$+1.4\text{ mph}$** buffer |
| **Tier 3: High-Wind** ($18–22\text{ mph}$) | $135\text{ lbs}$ (6 wing + 3 rear rail) | $20.8\text{ mph}$ | **$22.5\text{ mph}$** | **$+1.7\text{ mph}$** buffer |

*At sea level venues (e.g., BOA Grand Nationals in Indianapolis), air is $\sim 23\%$ denser; semicircular slits ensure Tier 3 ballast withstands $20.3\text{ mph}$ gusts without overturning.*

---

## 3. Shape Analysis: Semicircular vs. Oval / Elongated-U Geometry

The initial draft specification referenced "inverted-U crescent flaps ($8\text{ in. wide} \times 5–6\text{ in. drop}$)". A thorough engineering review reveals that an **exact semicircular geometry is vastly superior to oval, parabolic, or elongated-U geometries** across every functional dimension.

```
       SEMICIRCULAR GEOMETRY                     OVAL / ELONGATED-U GEOMETRY
           (RECOMMENDED)                               (DISCOURAGED)

       Uncut Top Hinge Chord                       Uncut Top Hinge Chord
       |<------ 8.0" ------>|                      |<------ 8.0" ------>|
     (O)==================(O)                    (O)==================(O)
      \         |          /                      |         |          |
       \     R=4.0"       /                       |         |          |  Straight
        \       |        /                        |         |          |  vertical legs
         \      v       /                         \      Drop=6.0"     /
          \____________/                           \        |         /
            True Arc                                \_______v________/
          (Uniform Drop)                               Elongated Tip
                                                  (Prone to Curling & Sag)
```

### 3.1 Detailed Comparative Evaluation

| Engineering Evaluation Criteria | True Semicircle ($8.0\text{ in. W} \times 4.0\text{ in. drop}$, $R = 4.0\text{ in.}$) | Oval / Elongated-U ($8.0\text{ in. W} \times 5.0–6.0\text{ in. drop}$) | Engineering Assessment |
|---|---|---|---|
| **Geometric Definition & Tooling** | **Single Constant Radius ($R$).** Defined solely by a center point and radius. Scribed with a standard pivot compass or 3D-printed disk. | **Dual-Axis Ellipse or Composite Curve.** Requires straight vertical cuts transitioning into a curved bottom arc. | **Semicircle Wins:** Simple, unambiguous, zero layout confusion for parent volunteers. |
| **Fleet Tooling Unification** | **100% Identical to Sideline Screens.** The 16 sideline screens already use $R = 4.0\text{ in.}$ semicircles. | **Incompatible.** Requires separate templates, measuring standards, and training instructions. | **Semicircle Wins:** Allows one standardized 3D-printed cutting jig across the entire band booster program. |
| **Gravitational Hang & Anti-Curling (Camouflage)** | **Excellent (Hangs 100% Flat).** Aspect ratio $D/W = 0.50$. Uniform perimeter curvature distributes tensile and bending stiffness evenly. Zero tip droop. | **Poor (Prone to Tip Curl & Gaping).** Aspect ratio $D/W = 0.63–0.75$. The elongated tongue sags under thermal softening (>85°F) and wind memory. | **Semicircle Wins:** Flap remains invisible from stadium press box and judges' stands when closed. |
| **Endpoint Stress Concentration & Tear Arrest** | **$180^\circ$ Smooth Tangency.** The circular arc sweeps through $180^\circ$, intersecting the pre-punched $\varnothing 3/8\text{ in.}$ holes exactly vertical and tangent. | **Corner Notching Risk.** Straight vertical legs transitioning into bottom curves often leave slight angular notches or overcuts at punch holes. | **Semicircle Wins:** Eliminates stress concentration ($K_t \to 1.0$), ensuring scrim threads do not propagate tears. |
| **Flap Dynamics & Reset Reliability** | **Clean Hinge Action.** Symmetrical arc swings open under pressure and falls flush without catching cut edges upon return. | **Edge Catching.** Elongated tongue can twist laterally under turbulent wind shear and snag outside the cut boundary. | **Semicircle Wins:** Reliable one-way check-valve action. |

---

## 4. Size Recommendation & Evaluation

| Size Option | Dimensions & Radius | Vent Area per Flap | Total Area (6 Flaps) | Total Area (8 Flaps) | % of 80 sq ft Face | Operational Recommendation |
|---|---|:---:|:---:|:---:|:---:|---|
| **Option 1 (Recommended Fleet Standard)** | **$8.0\text{ in. W} \times 4.0\text{ in. drop}$** ($R = 4.0\text{ in.}$) | **$25.13\text{ sq in.}$** ($0.175\text{ sq ft}$) | $1.05\text{ sq ft}$ | **$1.40\text{ sq ft}$** | **$1.75\%$** (8 flaps)<br>$1.31\%$ (6 flaps) | **PRIMARY RECOMMENDATION.** Reuses identical Sideline Screen tooling; optimal stiffness; zero sag; compact visual signature. |
| **Option 2 (Approved Minimal Variant)** | **$10.0\text{ in. W} \times 5.0\text{ in. drop}$** ($R = 5.0\text{ in.}$) | **$39.27\text{ sq in.}$** ($0.273\text{ sq ft}$) | **$1.64\text{ sq ft}$** | $2.18\text{ sq ft}$ | **$2.05\%$** (6 flaps)<br>$2.73\%$ (8 flaps) | **APPROVED ALTERNATIVE.** Excellent vent area for 6-cut layouts; slightly larger visual cut lines. |
| **Option 3 (Not Recommended)** | **$12.0\text{ in. W} \times 6.0\text{ in. drop}$** ($R = 6.0\text{ in.}$) | **$56.55\text{ sq in.}$** ($0.393\text{ sq ft}$) | $2.36\text{ sq ft}$ | $3.14\text{ sq ft}$ | $2.95\%$ (6 flaps) | **DISCOURAGED.** Large 12" cuts visibly disrupt graphic artwork, and heavier flap mass can chatter or sag in heat. |

### Rationale for Standardizing on 8.0" × 4.0" ($R = 4.0"$)
1. **Tooling Efficiency:** PCHSMB volunteers build 16 Sideline Screens and 10 Rolling Backdrops. Standardizing on an $8.0\text{ in.}$ chord and $R = 4.0\text{ in.}$ ensures that volunteers only need one size rotary punch ($\varnothing 3/8"$) and one 3D-printed cutting guide or compass setting for all props.
2. **Structural Banner Integrity:** An $8.0\text{ in.}$ cut is small enough to navigate between printed text, performer portraits, and field graphics without damaging graphic fidelity.
3. **Flap Count Scaling:** By deploying **8 flaps** (2 rows of 4) instead of 6, total vent area reaches **$1.40\text{ sq ft}$** ($201\text{ sq in.}$), achieving full dynamic pressure relief without enlarging the individual flap size.

---

## 5. Positioning & Coordinate Layout Recommendation

### 5.1 Vertical Zonation (Overturning Moment Mechanics)

Overturning moment is the product of lateral force and elevation ($M = F \cdot z$). Relieving $1.0\text{ lb}$ of aerodynamic drag at $9.0\text{ ft}$ elevation eliminates **$9.75\text{ ft-lb}$** of overturning torque, whereas relieving that same force at $3.0\text{ ft}$ eliminates only **$3.75\text{ ft-lb}$** (a **$2.6\times$ leverage differential**).

Therefore, relief cuts are strictly zoned in the **upper 40% to 65% of the frame**:
- **Upper Row (Row 1):** Centered at **$Y = 96.0\text{ in.}$ ($8.0\text{ ft}$ above bottom rail)** ($105.0\text{ in.}$ above turf).
- **Lower Row (Row 2):** Centered at **$Y = 72.0\text{ in.}$ ($6.0\text{ ft}$ above bottom rail)** ($81.0\text{ in.}$ above turf).
- **Excluded Zones:**
  - *Top 12 inches ($Y > 108\text{ in.}$):* Avoided to prevent perimeter tear peel under top snap clamps and perimeter tension tape.
  - *Bottom 5 feet ($Y < 60\text{ in.}$):* Avoided because wind venting near the bottom provides minimal overturning moment relief while falling directly across performer sightlines.

### 5.2 Perimeter & Frame Clearances
- **Frame Clearance:** Backdrop uprights are 1-5/8" OD steel fence posts. Maintain at least **$12.0\text{ in.}$ horizontal clearance** from outer vertical uprights ($12.0\text{ in.} \le X \le 84.0\text{ in.}$).
- **Strut Clearance:** Two-piece diagonal support struts attach to the vertical uprights and angle down to the cart base. The entire 8-ft wide center face between uprights is completely open; relief cuts have zero structural strut interference.
- **Snap Clamp Clearance:** 14 greenhouse snap clamps secure the perimeter bleed wrap. All cuts remain well inside the perimeter, with at least $12\text{ in.}$ margin from all clamp locations.

---

### 5.3 Exact Coordinate Layouts

```
   0"          19.2"           38.4"           57.6"           76.8"         96.0"
  +-------------+---------------+---------------+---------------+-------------+
  |                                                                           | 120" (Top Rail)
  |                                                                           |
  |             (O)==(O)        (O)==(O)        (O)==(O)        (O)==(O)      |
  |              \___/           \___/           \___/           \___/        | 96" (Row 1)
  |                                                                           |
  |                                                                           |
  |             (O)==(O)        (O)==(O)        (O)==(O)        (O)==(O)      |
  |              \___/           \___/           \___/           \___/        | 72" (Row 2)
  |                                                                           |
  |                                                                           |
  |                     [ UNVENTED LOWER GRAPHIC ZONE ]                       |
  |                                                                           |
  |                                                                           |
  +---------------------------------------------------------------------------+ 0" (Bottom Rail)
```

#### Layout A: 8-Flap Fleet Standard (2 Rows × 4 Columns) — [RECOMMENDED]

*Best aerodynamic distribution; 100% tooling unification with Sideline Screens.*

| Cut ID | Row | Elevation Above Bottom Rail ($Y$) | Elevation Above Turf | Centerline Column ($X$) | Punch Hole 1 ($X_1, Y$) | Punch Hole 2 ($X_2, Y$) | Flap Drop Bottom Arc ($Y_{min}$) |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **F-1** | Row 1 (Upper) | $96.0\text{ in.}$ ($8.0\text{ ft}$) | $105.0\text{ in.}$ | $19.2\text{ in.}$ ($1.6\text{ ft}$) | ($15.2\text{ in.}, 96.0\text{ in.}$) | ($23.2\text{ in.}, 96.0\text{ in.}$) | $92.0\text{ in.}$ |
| **F-2** | Row 1 (Upper) | $96.0\text{ in.}$ ($8.0\text{ ft}$) | $105.0\text{ in.}$ | $38.4\text{ in.}$ ($3.2\text{ ft}$) | ($34.4\text{ in.}, 96.0\text{ in.}$) | ($42.4\text{ in.}, 96.0\text{ in.}$) | $92.0\text{ in.}$ |
| **F-3** | Row 1 (Upper) | $96.0\text{ in.}$ ($8.0\text{ ft}$) | $105.0\text{ in.}$ | $57.6\text{ in.}$ ($4.8\text{ ft}$) | ($53.6\text{ in.}, 96.0\text{ in.}$) | ($61.6\text{ in.}, 96.0\text{ in.}$) | $92.0\text{ in.}$ |
| **F-4** | Row 1 (Upper) | $96.0\text{ in.}$ ($8.0\text{ ft}$) | $105.0\text{ in.}$ | $76.8\text{ in.}$ ($6.4\text{ ft}$) | ($72.8\text{ in.}, 96.0\text{ in.}$) | ($80.8\text{ in.}, 96.0\text{ in.}$) | $92.0\text{ in.}$ |
| **F-5** | Row 2 (Mid-Upper) | $72.0\text{ in.}$ ($6.0\text{ ft}$) | $81.0\text{ in.}$ | $19.2\text{ in.}$ ($1.6\text{ ft}$) | ($15.2\text{ in.}, 72.0\text{ in.}$) | ($23.2\text{ in.}, 72.0\text{ in.}$) | $68.0\text{ in.}$ |
| **F-6** | Row 2 (Mid-Upper) | $72.0\text{ in.}$ ($6.0\text{ ft}$) | $81.0\text{ in.}$ | $38.4\text{ in.}$ ($3.2\text{ ft}$) | ($34.4\text{ in.}, 72.0\text{ in.}$) | ($42.4\text{ in.}, 72.0\text{ in.}$) | $68.0\text{ in.}$ |
| **F-7** | Row 2 (Mid-Upper) | $72.0\text{ in.}$ ($6.0\text{ ft}$) | $81.0\text{ in.}$ | $57.6\text{ in.}$ ($4.8\text{ ft}$) | ($53.6\text{ in.}, 72.0\text{ in.}$) | ($61.6\text{ in.}, 72.0\text{ in.}$) | $68.0\text{ in.}$ |
| **F-8** | Row 2 (Mid-Upper) | $72.0\text{ in.}$ ($6.0\text{ ft}$) | $81.0\text{ in.}$ | $76.8\text{ in.}$ ($6.4\text{ ft}$) | ($72.8\text{ in.}, 72.0\text{ in.}$) | ($80.8\text{ in.}, 72.0\text{ in.}$) | $68.0\text{ in.}$ |

*(Note: Horizontal column spacing may be rounded in shop practice to $X = 20.0\text{ in.}, 38.0\text{ in.}, 58.0\text{ in.}, 76.0\text{ in.}$.)*

---

#### Layout B: 6-Flap Approved Minimal Variant (2 Rows × 3 Columns)

*Approved minimal baseline; fewer cuts per banner.*

| Cut ID | Row | Elevation Above Bottom Rail ($Y$) | Elevation Above Turf | Centerline Column ($X$) | Punch Hole 1 ($X_1, Y$) | Punch Hole 2 ($X_2, Y$) | Flap Drop Bottom Arc ($Y_{min}$) |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **F-1** | Row 1 (Upper) | $96.0\text{ in.}$ ($8.0\text{ ft}$) | $105.0\text{ in.}$ | $24.0\text{ in.}$ ($2.0\text{ ft}$) | ($20.0\text{ in.}, 96.0\text{ in.}$) | ($28.0\text{ in.}, 96.0\text{ in.}$) | $92.0\text{ in.}$ |
| **F-2** | Row 1 (Upper) | $96.0\text{ in.}$ ($8.0\text{ ft}$) | $105.0\text{ in.}$ | $48.0\text{ in.}$ ($4.0\text{ ft}$) | ($44.0\text{ in.}, 96.0\text{ in.}$) | ($52.0\text{ in.}, 96.0\text{ in.}$) | $92.0\text{ in.}$ |
| **F-3** | Row 1 (Upper) | $96.0\text{ in.}$ ($8.0\text{ ft}$) | $105.0\text{ in.}$ | $72.0\text{ in.}$ ($6.0\text{ ft}$) | ($68.0\text{ in.}, 96.0\text{ in.}$) | ($76.0\text{ in.}, 96.0\text{ in.}$) | $92.0\text{ in.}$ |
| **F-4** | Row 2 (Mid-Upper) | $72.0\text{ in.}$ ($6.0\text{ ft}$) | $81.0\text{ in.}$ | $24.0\text{ in.}$ ($2.0\text{ ft}$) | ($20.0\text{ in.}, 72.0\text{ in.}$) | ($28.0\text{ in.}, 72.0\text{ in.}$) | $68.0\text{ in.}$ |
| **F-5** | Row 2 (Mid-Upper) | $72.0\text{ in.}$ ($6.0\text{ ft}$) | $81.0\text{ in.}$ | $48.0\text{ in.}$ ($4.0\text{ ft}$) | ($44.0\text{ in.}, 72.0\text{ in.}$) | ($52.0\text{ in.}, 72.0\text{ in.}$) | $68.0\text{ in.}$ |
| **F-6** | Row 2 (Mid-Upper) | $72.0\text{ in.}$ ($6.0\text{ ft}$) | $81.0\text{ in.}$ | $72.0\text{ in.}$ ($6.0\text{ ft}$) | ($68.0\text{ in.}, 72.0\text{ in.}$) | ($76.0\text{ in.}, 72.0\text{ in.}$) | $68.0\text{ in.}$ |

---

### 5.4 Artwork Protection & The "Floating Flap" Adjustment Rule

The coordinates in Section 5.3 represent theoretical layout targets. In production, each year's marching band show features unique visual graphics (e.g., character portraits, architectural motifs, high-contrast title typography).

To prevent visual disruption, fabrication teams **MUST** follow these rules:

1. **Floating Allowance ($\pm 6\text{ to }12\text{ in.}$):** Any cut centerline may float horizontally by up to $\pm 12.0\text{ in.}$ (and vertically by $\pm 6.0\text{ in.}$) to align the flap into solid dark colors, skies, tree canopies, or textured graphic backgrounds.
2. **Mandatory NO-CUT Zones:**
   - **Performer Faces / Portraits:** Flaps must clear facial features by at least $6.0\text{ in.}$.
   - **Show Title & Typography:** Cuts must never intersect lettering, musical notations, or movement titles.
   - **School / Sponsor Crests:** Zero cuts permitted through Pine Creek emblems or competition branding.
3. **Double-Check Before Slicing:** Always flip the banner or inspect the printed face against a bright work light before executing punch holes.

---

## 6. Fabrication Procedure & Quality Assurance Protocol

```
                     STEP-BY-STEP FABRICATION SEQUENCE

    1. Punch Left Hole               2. Punch Right Hole              3. Scribe & Slice Arc
    (Ø 3/8" Rotary Punch)           (Ø 3/8" Rotary Punch)             (R = 4.0" Semicircular Arc)

           (O)                             (O)             (O)              (O)=================(O)  <- UNCUT HINGE
                                                            \                /
                                                             \    R=4.0"    /
                                                              \____________/
```

### Required Tools
- **Tear-Arrest Punch Tool:** $\varnothing 3/8\text{ in.}$ ($10\text{ mm}$) rotary leather punch or hollow gasket punch.
- **Hardwood Backing Block:** Dense end-grain hardwood or high-density plastic block placed behind banner when punching.
- **Marking Guide:** 3D-printed $R = 4.0\text{ in.}$ semicircular stencil, beam compass, or rigid arc template.
- **Cutting Blade:** Heavy-duty utility knife with a brand-new sharp blade.
- **Measuring Tape & Soft White/Yellow Marking Pencil.**

### Execution Steps
1. **Clean Staging:** Spread moving blankets on a flat, clean shop floor. Lay the banner flat with zero grit or dirt underneath.
2. **Mark Coordinates:** Mark the top horizontal chord centerlines and endpoint punch marks ($8.0\text{ in.}$ apart) using the marking pencil.
3. **MANDATORY PUNCH FIRST:** Place the hardwood block directly underneath the first punch location. Align the $\varnothing 3/8\text{ in.}$ punch exactly over the mark and strike firmly with a mallet to punch a clean, circular hole with zero fraying. Repeat for the second hole.
   > [!CRITICAL]
   > **NEVER** use a razor knife before punching the circular holes. Slicing first creates sharp microscopic corner tears ($K_t \ge 3.0$) that will rapidly propagate into a full rip during wind events.
4. **Scribe the Circular Arc:** Place the $R = 4.0\text{ in.}$ template or compass tangent to the bottom edge of the two punched holes.
5. **Execute the Semicircular Cut:** In a single, smooth motion, draw the razor along the curved circular template, starting at the tangent edge of Hole 1 and terminating cleanly at the tangent edge of Hole 2.
6. **LEAVE TOP CHORD UNCUT:** Under no circumstances should the top $8.0\text{ in.}$ line between the holes be cut. This uncut vinyl serves as the permanent gravity hinge.
7. **Inspect Flap Action:** Gently push the flap outward to verify clean separation along the circular arc. Confirm the flap falls immediately flush under gravity when released.

---

## 7. Subproject Cross-References

- **Master Subproject README:** [`PCHSMB/_Backdrop/README.md`](../../README.md)
- **Technical Specification:** [`PCHSMB/_Backdrop/docs/references/TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md) (Step 3.1)
- **Wind Loading Skill CLI:** `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py`
- **Aerodynamic Models & Math:** `.agents/skills/calculate-prop-wind-loading/references/aerodynamic-models.md`
- **Sideline Screen Fleet Reference:** `PCHSMB/_Sideline Screen/docs/references/TECHNICAL_SPEC.md`
