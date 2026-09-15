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

| Parameter | Recommendation | Engineering Justification |
|---|---|---|
| **Shape** | **True Semicircular Flap** (180° circular arc) | **Strongly preferred over oval / elongated-U.** Single-radius layout, uniform gravity return without tip curl/sag, zero notch risers, and 100% tooling shared with Sideline Screens. |
| **Dimensions** | **8.0" chord × 4.0" drop** (Radius R = 4.0") | Matches Sideline Screen radius and punch tools. Compact 4" drop prevents thermal sagging while venting 25.1 sq in per flap. |
| **Count & Grid** | **8 Flaps (2 Rows × 4 Cols)**<br>*(or 6 Flaps: 2 Rows × 3 Cols)* | 8 flaps = 1.40 sq ft (1.8% of face); 6 flaps = 1.05 sq ft (1.3%). Drops prop drag coefficient from Cd = 1.20 to 1.02 (15% load reduction). |
| **Vertical Zone** | **Upper Venting Zone (6.0 to 8.0 ft above bottom rail)** | Relieves pressure where overturning leverage is highest. Row 1 centered at Y = 96" (8 ft); Row 2 at Y = 72" (6 ft). Avoids top 1 ft and bottom 5 ft. |
| **Horizontal Spacing** | **8-Cut:** X = 19.2", 38.4", 57.6", 76.8"<br>**6-Cut:** X = 24", 48", 72" | Symmetrical spacing across 96" width; minimum 12" frame clearance from side upright posts and greenhouse clamps. |
| **Graphic Clearance** | **±6" to 12" Floating Offset Rule** | Center points float into dark backgrounds or negative space. Strictly prohibited across performer faces, show typography, or crests. |
| **Tear Arrest** | **Pre-Punched 3/8" (10 mm) Holes** | Clean circular punch holes at chord endpoints before razor cutting. Reduces stress concentration (Kt 3.0 → 1.0), stopping tears. |

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

| Wind Tier | Ballast | Solid (Cd 1.20) | With Slits (Cd 1.02) | Gain |
|---|---|:---:|:---:|:---:|
| **Tier 0: Calm** (0–8 mph) | 0 lb (dry wt 153 lb) | 13.3 mph (limit) | **14.4 mph** (limit) | **+1.1 mph** |
| **Tier 1: Normal** (8–12 mph) | 60 lb (4× 15-lb bags) | 15.6 mph | **16.9 mph** | **+1.3 mph** |
| **Tier 2: Advisory** (12–18 mph) | 90 lb (6× 15-lb bags) | 17.0 mph | **18.4 mph** | **+1.4 mph** |
| **Tier 3: High-Wind** (18–22 mph) | 135 lb (6 wing + 3 rear) | 20.8 mph | **22.5 mph** | **+1.7 mph** |

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

| Criteria | Semicircle (8" W × 4" D, R=4") | Oval / Elongated-U (8" W × 5–6" D) | Verdict |
|---|---|---|---|
| **Geometry & Tooling** | **Single radius (R = 4").** Defined by center point and radius. Scribed with compass or 3D disk. | **Dual-axis or composite curve.** Requires straight cuts transitioning into a bottom arc. | **Semicircle:** Simple, zero layout confusion for volunteers. |
| **Fleet Tooling** | **Identical to Sideline Screens.** 16 sideline screens already use R = 4" semicircles. | **Incompatible.** Requires separate templates and volunteer instructions. | **Semicircle:** One standardized jig across the whole program. |
| **Hang & Camouflage** | **Hangs 100% flat.** Aspect ratio D/W = 0.50. Uniform perimeter prevents tip droop. | **Prone to tip curl & sag.** Aspect ratio D/W = 0.63–0.75. Tongue sags in heat (>85°F). | **Semicircle:** Flap remains invisible from stadium stands. |
| **Tear Arrest & Tangency** | **180° smooth tangency.** Sweeps into pre-punched 3/8" holes with exact vertical tangency. | **Corner notch risk.** Straight legs to bottom curve often leave micro-notches at holes. | **Semicircle:** Eliminates stress risers (Kt → 1.0). |
| **Flap Dynamics** | **Clean hinge action.** Symmetrical arc swings open and falls flush without catching. | **Edge catching.** Elongated tongue can twist laterally in gusts and snag on edges. | **Semicircle:** Reliable one-way check-valve action. |

---

## 4. Size Recommendation & Evaluation

| Option | Dimensions (Radius) | Area / Flap | Vent Area (6 / 8 Flaps) | Recommendation |
|---|---|:---:|:---:|---|
| **Option 1 (Fleet Standard)** | **8.0" W × 4.0" drop** (R = 4.0") | 25.1 sq in (0.175 sq ft) | **1.05 sq ft (1.3%)** / **1.40 sq ft (1.8%)** | **PRIMARY STANDARD.** Shared Sideline Screen tooling; optimal stiffness; zero sag; compact footprint. |
| **Option 2 (Approved Minimal)** | **10.0" W × 5.0" drop** (R = 5.0") | 39.3 sq in (0.273 sq ft) | **1.64 sq ft (2.1%)** / **2.18 sq ft (2.7%)** | **APPROVED ALTERNATIVE.** Higher vent area for 6 cuts; slightly larger cut profile. |
| **Option 3 (Discouraged)** | **12.0" W × 6.0" drop** (R = 6.0") | 56.5 sq in (0.393 sq ft) | **2.36 sq ft (3.0%)** / **3.14 sq ft (3.9%)** | **DISCOURAGED.** Large cuts disrupt artwork; heavier flap prone to chatter/sag in heat. |

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

| Cut | Row | Height (Y) | Center (X) | Punch Holes at X | Arc Bottom (Y) |
|:---:|:---:|:---:|:---:|:---:|:---:|
| **F-1** | Row 1 (Upper) | 96" (8.0 ft) | 19.2" (1.6 ft) | 15.2" and 23.2" | 92" (7.7 ft) |
| **F-2** | Row 1 (Upper) | 96" (8.0 ft) | 38.4" (3.2 ft) | 34.4" and 42.4" | 92" (7.7 ft) |
| **F-3** | Row 1 (Upper) | 96" (8.0 ft) | 57.6" (4.8 ft) | 53.6" and 61.6" | 92" (7.7 ft) |
| **F-4** | Row 1 (Upper) | 96" (8.0 ft) | 76.8" (6.4 ft) | 72.8" and 80.8" | 92" (7.7 ft) |
| **F-5** | Row 2 (Mid-Upper) | 72" (6.0 ft) | 19.2" (1.6 ft) | 15.2" and 23.2" | 68" (5.7 ft) |
| **F-6** | Row 2 (Mid-Upper) | 72" (6.0 ft) | 38.4" (3.2 ft) | 34.4" and 42.4" | 68" (5.7 ft) |
| **F-7** | Row 2 (Mid-Upper) | 72" (6.0 ft) | 57.6" (4.8 ft) | 53.6" and 61.6" | 68" (5.7 ft) |
| **F-8** | Row 2 (Mid-Upper) | 72" (6.0 ft) | 76.8" (6.4 ft) | 72.8" and 80.8" | 68" (5.7 ft) |

*(Note: Dimensions are measured above bottom rail. Turf elevation is Y + 9" deck height. Column spacing may be rounded in shop practice to X = 20", 38", 58", 76".)*

---

#### Layout B: 6-Flap Approved Minimal Variant (2 Rows × 3 Columns)

*Approved minimal baseline; fewer cuts per banner.*

| Cut | Row | Height (Y) | Center (X) | Punch Holes at X | Arc Bottom (Y) |
|:---:|:---:|:---:|:---:|:---:|:---:|
| **F-1** | Row 1 (Upper) | 96" (8.0 ft) | 24.0" (2.0 ft) | 20.0" and 28.0" | 92" (7.7 ft) |
| **F-2** | Row 1 (Upper) | 96" (8.0 ft) | 48.0" (4.0 ft) | 44.0" and 52.0" | 92" (7.7 ft) |
| **F-3** | Row 1 (Upper) | 96" (8.0 ft) | 72.0" (6.0 ft) | 68.0" and 76.0" | 92" (7.7 ft) |
| **F-4** | Row 2 (Mid-Upper) | 72" (6.0 ft) | 24.0" (2.0 ft) | 20.0" and 28.0" | 68" (5.7 ft) |
| **F-5** | Row 2 (Mid-Upper) | 72" (6.0 ft) | 48.0" (4.0 ft) | 44.0" and 52.0" | 68" (5.7 ft) |
| **F-6** | Row 2 (Mid-Upper) | 72" (6.0 ft) | 72.0" (6.0 ft) | 68.0" and 76.0" | 68" (5.7 ft) |

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

## 8. Addendum: Wind De-Rating Analysis for Delayed / Unvented Vinyl Operation

### 8.1 Problem Statement & Field Context
If construction timelines or rehearsal schedules require fielding the 10 Rolling Backdrops before the 8 engineered semicircular wind relief flaps can be cut and punched in the upper $6.0–8.0\text{ ft}$ zone, the backdrops operate with **100% solid, unvented $80\text{ sq ft}$ vinyl sails**.

This engineering addendum defines the exact aerodynamic de-rating factors, forward-tipping failure thresholds, and volunteer operational rules required to safely operate unvented rolling backdrops without risking prop tipping, caster rutting, or clamp blow-off.

### 8.2 Aerodynamic Physics & Force Multiplier
1. **Drag Coefficient ($C_d$):** Solid, unvented scrim vinyl exhibits a flat-plate drag coefficient of $C_d = 1.20$. Semicircular relief cuts reduce this to $C_d = 1.02$ ($\sim 15.0\%$ steady-state drag reduction).
2. **Force & Overturning Moment Scaling:**
   Lateral wind force $F_{wind} = q \cdot A \cdot C_d$ and overturning moment $M_{OT} = F_{wind} \cdot z_{cp}$ scale directly with $C_d$.
   $$\frac{F_{\text{solid}}}{F_{\text{vented}}} = \frac{1.20}{1.02} = 1.176 \quad (+17.6\% \text{ higher lateral drag force and forward overturning torque})$$
3. **Allowable Wind Velocity Scaling:**
   Because velocity pressure scales quadratically ($q \propto V^2$), the allowable forward tipping velocity threshold scales as:
   $$V_{\text{solid}} = V_{\text{vented}} \times \sqrt{\frac{1.02}{1.20}} = V_{\text{vented}} \times \sqrt{0.850} \approx 0.922 \cdot V_{\text{vented}} \quad (\sim 7.8\% \text{ reduction in allowable wind speed})$$

### 8.3 Forward Tipping Stability: Solid vs. Vented (Colorado Springs: 6,500 ft ASL)
Calculated using `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py` ($q = 0.001989 \cdot V^2\text{ psf}$, $\rho = 0.0595\text{ lb/ft}^3$, $A = 80.0\text{ sq ft}$, $z_{cp} = 5.79\text{ ft}$ above turf, deck height $9.0\text{ in.}$, critical pivot axis at front casters):

| Ballast Tier | Ballast Configuration | Total Weight on Casters | Solid Tipping Limit ($C_d = 1.20$) | Vented Tipping Limit ($C_d = 1.02$) | Calculated De-Rating |
|---|---|:---:|:---:|:---:|:---:|
| **Tier 0: Calm** | 0 bags (Dry cart, 153 lb) | 153 lb | 13.3 mph | 14.4 mph | **$-1.1\text{ mph}$** |
| **Tier 1: Normal** | 4× 15-lb bags on wing posts | 213 lb | 15.6 mph | 16.9 mph | **$-1.3\text{ mph}$** |
| **Tier 2: Advisory** | 6× 15-lb bags on wing posts | 243 lb | 17.0 mph | 18.4 mph | **$-1.4\text{ mph}$** |
| **Tier 3: High-Wind** | 6 wing + 3 rear rail A (135 lb) | 288 lb | 20.8 mph | 22.5 mph | **$-1.7\text{ mph}$** |

*At sea level venues (e.g. BOA Grand Nationals in Indianapolis, $\rho = 0.0765\text{ lb/ft}^3$), air is 23% denser; solid vinyl on Tier 3 ballast tips forward at $18.8\text{ mph}$ (vs. $20.3\text{ mph}$ with slits).*

### 8.4 Non-Linear Dynamic Risks of Operating Unvented Vinyl
1. **Coherent Vortex-Shedding Flutter & Snap Clamp Pop-Off:**
   A continuous $80\text{ sq ft}$ solid vinyl membrane generates coherent Strouhal vortex shedding (~0.5–1.2 Hz). Under sustained crosswinds, this creates rhythmic billow cycles with localized negative suction spikes ($>3.0\text{ psf}$) that pry the perimeter greenhouse snap clamps off the 1-5/8" steel tubing. Relief flaps bleed pressure across the upper zone, destroying coherent vortices.
2. **Dynamic Gust Impulse Bleed:**
   Sudden stadium downdrafts or thermal gusts exert peak instantaneous pressure spikes ($q = \frac{1}{2}\rho V^2$). Relief flaps rapidly vent peak impulses before the cart's inertia can transition into an overturning roll over the front wheels.

### 8.5 Volunteer Operational Rule (Field Simplification)
Volunteer parent crew and student handlers cannot calculate mathematical percentages or track fractional wind limits during field logistics. To guarantee absolute safety, the calculated de-ratings are **rounded up to a flat 2 mph reduction across all wind regimes**, Tier 4 abort is lowered, and companion duck blinds must carry 2 bags even in Tier 0:

> [!IMPORTANT]
> **Operational Guidance for Unvented Vinyl:**
> *"Without wind relief cuts, the props may be used by derating all wind regimes by 2MPH, decreasing the Tier 4 Abort threshold to 12MPH sustained / 16MPH gusts, and increasing the duck blind tier 0 ballasting to 2 bags."*

---

## 9. Subproject Cross-References

- **Master Subproject README:** [`PCHSMB/_Backdrop/README.md`](../../README.md)
- **Technical Specification:** [`PCHSMB/_Backdrop/docs/references/TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md) (Step 3.1)
- **Wind Loading Skill CLI:** `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py`
- **Aerodynamic Models & Math:** `.agents/skills/calculate-prop-wind-loading/references/aerodynamic-models.md`
- **Sideline Screen Fleet Reference:** `PCHSMB/_Sideline Screen/docs/references/TECHNICAL_SPEC.md`
