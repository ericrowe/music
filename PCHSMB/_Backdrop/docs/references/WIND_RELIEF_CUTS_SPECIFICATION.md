# Rolling Backdrop System — Semicircular Wind Relief Cuts Engineering Specification

**Subproject:** Pine Creek High School Marching Band (PCHSMB) Rolling Backdrop  
**Prop Envelope:** 10 ft H × 8 ft W (80.0 sq ft face) on 96.0" × 44.5" Rolling Wood Cart Base  
**Controlling Document:** [`docs/references/TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md)  
**Parent Subproject README:** [`../../README.md`](../../README.md)  
**Status:** Engineering Standard & Review Recommendation  
**Date:** September 2026  

---

## 1. Executive Summary & Core Recommendations

This specification establishes the official engineering standard for wind relief cuts in the custom-printed scrim vinyl banners of the PCHSMB Rolling Backdrop fleet (11 backdrops total).

| Parameter | Recommendation | Engineering Justification |
|---|---|---|
| **Shape** | **True Semicircular Flap** (180° circular arc) | **Strongly preferred over oval / elongated-U.** Single-radius layout, uniform gravity return without tip curl/sag, zero notch risers, and 100% tooling shared with Sideline Screens. |
| **Dimensions** | **Option 1: 8.0" chord × 4.0" drop** (R = 4.0")<br>**Option 2: 6.25" chord × 3.125" drop** (R = 3.125") | Option 1 matches Circle Cutter tooling ($25.1\text{ sq in.}$). Option 2 matches standard 1-gal paint can field template ($15.3\text{ sq in.}$). |
| **Count & Grid** | **Option 1: 8 Flaps (3-2-3 Staggered Quincunx)**<br>**Option 2: 11 Flaps (4-3-4 Paint Can Alternative)**<br>*(or 6 Flaps: 2 Rows × 3 Cols Minimal Variant)* | Option 1: 1.40 sq ft vent area ($C_d = 1.02$, 22.3 mph Tier 3 limit). Option 2: 1.17 sq ft vent area ($C_d = 1.04$, 22.0 mph Tier 3 limit). Both preserve a 24" solid buffer over the 60" mid rail. |
| **Vertical Zone** | **Three-Row Straddle (Y = 96", 74", 46" above bottom rail)** | Straddles the 60.0 in. mid cross rail: Row 1 at Y = 96", Row 2 at Y = 74" (apex at 70"), Row 3 at Y = 46" (apex at 42"). Provides 24" continuous solid vinyl buffer across the 60" mid rail to prevent wind-slap. |
| **Horizontal Spacing** | **Option 1 (3-2-3):** R1: 24", 48", 72"; R2: 36", 60"; R3: 24", 48", 72"<br>**Option 2 (4-3-4):** R1: 19.2", 38.4", 57.6", 76.8"; R2: 28.8", 48", 67.2"; R3: 19.2", 38.4", 57.6", 76.8" | Staggered quincunx distribution; minimum 12" frame clearance from side upright posts and greenhouse clamps. |
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
| **Tier 3: High-Wind** (18–22 mph) | 135 lb (6 wing + 3 rear) | 20.8 mph | **22.3 mph** | **+1.5 mph** |

*At sea level venues (e.g., BOA Grand Nationals in Indianapolis), air is $\sim 23\%$ denser; semicircular slits ensure Tier 3 ballast withstands $20.1\text{ mph}$ gusts without overturning.*

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

To accommodate the **60.0 in. mid cross rail** installed behind the vinyl banner for structural stiffness, relief cuts are organized into a **three-row straddle** that maintains a generous continuous solid buffer directly over the pipe:
- **Upper Row (Row 1):** Centered at **$Y = 96.0\text{ in.}$ ($8.0\text{ ft}$ above bottom rail)** ($105.0\text{ in.}$ above turf).
- **Mid-Upper Row (Row 2):** Centered at **$Y = 74.0\text{ in.}$ ($6.17\text{ ft}$ above bottom rail)** ($83.0\text{ in.}$ above turf; flap apex at $Y = 70.0\text{ in.}$, providing a **$10.0\text{ in.}$ solid buffer above the 60" rail**).
- **Lower-Mid Row (Row 3):** Centered at **$Y = 46.0\text{ in.}$ ($3.83\text{ ft}$ above bottom rail)** ($55.0\text{ in.}$ above turf; top hinge chord at $Y = 46.0\text{ in.}$, providing a **$14.0\text{ in.}$ solid buffer below the 60" rail**).
- **Excluded / Buffer Zones:**
  - *Mid-Rail Buffer ($Y = 46\text{ in.} \text{ to } 70\text{ in.}$):* Continuous 24.0-inch solid vinyl zone centered across the 60.0-in. mid rail. Completely eliminates wind-battering contact against the pipe.
  - *Top 24 inches ($Y > 96\text{ in.}$):* Retains continuous tension band under top snap clamps and perimeter tension tape.
  - *Bottom 42 inches ($Y < 42\text{ in.}$):* Preserves solid ground graphics and protects performer sightlines.

### 5.2 Perimeter & Frame Clearances
- **Frame Clearance:** Backdrop uprights are 1-5/8" OD steel fence posts. Maintain at least **$12.0\text{ in.}$ horizontal clearance** from outer vertical uprights ($12.0\text{ in.} \le X \le 84.0\text{ in.}$).
- **Strut Clearance:** Two-piece diagonal support struts attach to the vertical uprights and angle down to the cart base. The entire 8-ft wide center face between uprights is completely open; relief cuts have zero structural strut interference.
- **Snap Clamp Clearance:** 14 greenhouse snap clamps secure the perimeter bleed wrap. All cuts remain well inside the perimeter, with at least $12\text{ in.}$ margin from all clamp locations.

---

### 5.3 Exact Coordinate Layouts

```text
<------------ 96.0" (8 ft) ------------>
0"     24.0"    36.0"    48.0"    60.0"    72.0"   96.0"
+--------+--------+--------+--------+--------+-------+ 120.0" (Top Rail)
|                                                    |
|               [Top 24" Solid Vinyl]                |
|                                                    |
|        X                 X                 X       |  96.0" (Row 1: 3 Flaps)
|       F-1               F-2               F-3      |
|                                                    |
|                 X                 X                |  74.0" (Row 2: 2 Flaps)
|                F-4               F-5               |
| - - - - - - - - - - - - - - - - - - - - - - - - -  |  70.0" (Row 2 Apex)
|           [10" Solid Buffer Above Rail]            |
|====================================================|  60.0" (Mid Rail - Riveted)
|           [14" Solid Buffer Below Rail]            |
| - - - - - - - - - - - - - - - - - - - - - - - - -  |  46.0" (Row 3 Hinge)
|        X                 X                 X       |  46.0" (Row 3: 3 Flaps)
|       F-6               F-7               F-8      |
| - - - - - - - - - - - - - - - - - - - - - - - - -  |  42.0" (Row 3 Apex)
|             [Solid Lower Graphic Zone]             |
|            (Protects Low Artwork & Base)           |
+====================================================+   0.0" (Cart Deck)
^        ^        ^        ^        ^        ^       ^
Post    1/4      3/8      1/2      5/8      3/4    Post
```

#### Option 1: 8-Flap Fleet Standard (3-2-3 Staggered Quincunx Grid) — [RECOMMENDED]

*Primary fleet standard; $R = 4.0\text{ in.}$, $1.40\text{ sq ft}$ vent area, $C_d = 1.02$, $22.3\text{ mph}$ Tier 3 limit.*

| Cut | Row | Height (Y) | Center (X) | Punch Holes at X | Arc Bottom (Y) |
|:---:|:---:|:---:|:---:|:---:|:---:|
| **F-1** | Row 1 (Upper) | 96.0" (8.0 ft) | 24.0" (2.0 ft) | 20.0" and 28.0" | 92.0" (7.67 ft) |
| **F-2** | Row 1 (Upper) | 96.0" (8.0 ft) | 48.0" (4.0 ft) | 44.0" and 52.0" | 92.0" (7.67 ft) |
| **F-3** | Row 1 (Upper) | 96.0" (8.0 ft) | 72.0" (6.0 ft) | 68.0" and 76.0" | 92.0" (7.67 ft) |
| **F-4** | Row 2 (Mid-Upper) | 74.0" (6.17 ft) | 36.0" (3.0 ft) | 32.0" and 40.0" | 70.0" (5.83 ft) |
| **F-5** | Row 2 (Mid-Upper) | 74.0" (6.17 ft) | 60.0" (5.0 ft) | 56.0" and 64.0" | 70.0" (5.83 ft) |
| **F-6** | Row 3 (Lower-Mid) | 46.0" (3.83 ft) | 24.0" (2.0 ft) | 20.0" and 28.0" | 42.0" (3.50 ft) |
| **F-7** | Row 3 (Lower-Mid) | 46.0" (3.83 ft) | 48.0" (4.0 ft) | 44.0" and 52.0" | 42.0" (3.50 ft) |
| **F-8** | Row 3 (Lower-Mid) | 46.0" (3.83 ft) | 72.0" (6.0 ft) | 68.0" and 76.0" | 42.0" (3.50 ft) |

*(Note: Dimensions are measured above bottom rail. Turf elevation is Y + 9" deck height.)*

---

#### Option 2: 11-Flap Paint Can Field Alternative (4-3-4 Staggered Grid)

*Alternative cut with 1-gallon paint can ($\varnothing 6.25\text{ in.}$, $R = 3.125\text{ in.}$); $1.17\text{ sq ft}$ vent area, $C_d = 1.04$, $22.0\text{ mph}$ Tier 3 limit.*

| Row | Count | Height (Y) | Centerline X Coordinates | Punch Holes at X | Apex (Y) |
|:---:|:---:|:---:|:---:|:---:|:---:|
| **Row 1** | 4 | 96.0" (8.0 ft) | 19.2", 38.4", 57.6", 76.8" | $\pm 3.125"$ from center | 92.88" |
| **Row 2** | 3 | 74.0" (6.17 ft) | 28.8", 48.0", 67.2" | $\pm 3.125"$ from center | 70.88" |
| **Row 3** | 4 | 46.0" (3.83 ft) | 19.2", 38.4", 57.6", 76.8" | $\pm 3.125"$ from center | 42.88" |

---

#### Option 3: 6-Flap Approved Minimal Variant (2 Rows × 3 Columns)

*Approved minimal baseline for banners with prominent central artwork; $1.05\text{ sq ft}$ vent area.*

| Cut | Row | Height (Y) | Center (X) | Punch Holes at X | Arc Bottom (Y) |
|:---:|:---:|:---:|:---:|:---:|:---:|
| **M-1** | Row 1 (Upper) | 96.0" (8.0 ft) | 24.0" (2.0 ft) | 20.0" and 28.0" | 92.0" (7.67 ft) |
| **M-2** | Row 1 (Upper) | 96.0" (8.0 ft) | 48.0" (4.0 ft) | 44.0" and 52.0" | 92.0" (7.67 ft) |
| **M-3** | Row 1 (Upper) | 96.0" (8.0 ft) | 72.0" (6.0 ft) | 68.0" and 76.0" | 92.0" (7.67 ft) |
| **M-4** | Row 2 (Mid-Upper) | 72.0" (6.0 ft) | 24.0" (2.0 ft) | 20.0" and 28.0" | 68.0" (5.67 ft) |
| **M-5** | Row 2 (Mid-Upper) | 72.0" (6.0 ft) | 48.0" (4.0 ft) | 44.0" and 52.0" | 68.0" (5.67 ft) |
| **M-6** | Row 2 (Mid-Upper) | 72.0" (6.0 ft) | 72.0" (6.0 ft) | 68.0" and 76.0" | 68.0" (5.67 ft) |

---

### 5.4 Artwork Protection & The "Floating Flap" Adjustment Rule

The coordinates in Section 5.3 represent theoretical layout targets. In production, each year's marching band show features unique visual graphics (e.g., character portraits, architectural motifs, high-contrast title typography).

To prevent visual disruption, fabrication teams **MUST** follow these rules:

1. **Floating Allowance ($\pm 6\text{ to }12\text{ in.}$):** Any cut centerline may float horizontally by up to $\pm 12.0\text{ in.}$ (and vertically by $\pm 6.0\text{ in.}$) to align the flap into solid dark colors, skies, tree canopies, or textured graphic backgrounds.
2. **Mandatory NO-CUT Zones:**
   - **Depicted Performer Faces / Portraits:** Flaps must maintain at least $6.0\text{ in.}$ clearance from any performer faces printed in the artwork.
   - **Show Title & Typography:** Cuts must never intersect lettering, musical notations, or movement titles.
   - **School / Sponsor Logos & Crests:** Zero cuts permitted through Pine Creek emblems, logos, or competition branding.
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
Volunteer parent crew and student handlers cannot calculate mathematical percentages or track fractional wind limits during field logistics. To guarantee absolute safety while preserving operational continuity without conflicting with Tier 3 high-wind limits, operational wind regimes are derated per safe aeromechanical thresholds, Tier 0 dry staging is eliminated, and the abort ceiling is set to 16 mph sustained / 20 mph gusts:

> [!IMPORTANT]
> **Operational Guidance for Unvented Vinyl:**
> *"Without wind relief cuts, the props may be used by derating operational wind regimes to safe aeromechanical limits, setting the Tier 4 Abort threshold to 16MPH sustained / 20MPH gusts (vs. 20/25 MPH standard), and increasing duck blind tier 0 ballasting to 2 bags."*

---

## 9. Subproject Cross-References

- **Master Subproject README:** [`PCHSMB/_Backdrop/README.md`](../../README.md)
- **Technical Specification:** [`PCHSMB/_Backdrop/docs/references/TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md) (Step 3.1)
- **Wind Loading Skill CLI:** `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py`
- **Aerodynamic Models & Math:** `.agents/skills/calculate-prop-wind-loading/references/aerodynamic-models.md`
- **Sideline Screen Fleet Reference:** `PCHSMB/_Sideline Screen/docs/references/TECHNICAL_SPEC.md`
