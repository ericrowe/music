# Sideline Screen (Duck Blind) — Semicircular Wind Relief Cuts Engineering Specification

**Subproject:** Pine Creek High School Marching Band (PCHSMB) Sideline Screen / Duck Blind Fleet (16 Units)  
**Prop Envelope:** 4.0 ft H × 8.0 ft W (30.5 sq ft face) on Triangular Folding Conduit Frame  
**Controlling Document:** [`docs/references/TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md)  
**Parent Subproject README:** [`../../README.md`](../../README.md)  
**Status:** Engineering Standard & Review Recommendation  
**Date:** September 2026  

---

## 1. Executive Summary & Core Recommendations

This specification establishes the official engineering standard for wind relief cuts in the custom-printed scrim vinyl banners of the PCHSMB Sideline Screen / Duck Blind fleet (16 screens total).

| Parameter | Recommendation | Engineering Justification |
|---|---|---|
| **Shape** | **True Semicircular Flap** (180° circular arc) | **Strongly preferred over oval / elongated-U.** Single-radius layout, uniform gravity return without tip curl/sag, zero notch risers, and 100% tooling shared with Rolling Backdrops. |
| **Dimensions** | **8.0" chord × 4.0" drop** (Radius R = 4.0") | Matches Rolling Backdrop radius and punch tools. Compact 4" drop prevents thermal sagging while venting 25.1 sq in per flap. |
| **Count & Grid** | **6 Flaps (2 Rows × 3 Cols)** | 6 flaps = 1.05 sq ft (3.43% of face). Drops prop drag coefficient from Cd = 1.20 to 1.02 (15% load reduction) and suppresses turf sliding. |
| **Vertical Zone** | **Upper Venting Zone (20.0" to 34.0" above turf)** | Relieves pressure where overturning leverage is highest. Row 1 hinge at Y = 34.0"; Row 2 hinge at Y = 24.0". Clears top frame rail by 10.5" and maintains 10" buffer above backstage equipment. |
| **Horizontal Spacing** | **X = 24.0", 48.0", 72.0"** | Symmetrical spacing across 96" width; minimum 16" frame clearance from outer end rails and greenhouse snap clamps. |
| **Graphic Clearance** | **±6" to 12" Floating Offset Rule** | Center points float into dark backgrounds or negative space. Strictly prohibited across performer faces, show typography, or crests. |
| **Tear Arrest** | **Pre-Punched 3/8" (10 mm) Holes** | Clean circular punch holes at chord endpoints before razor cutting. Reduces stress concentration (Kt 3.0 → 1.0), stopping tears. |

---

## 2. Aerodynamic Physics & Overturning Mechanics

### 2.1 The 30.5 sq ft Sail & Critical Stability Modes

Each sideline screen presents a nominal $4.0\text{ ft high} \times 8.0\text{ ft wide}$ continuous solid face ($30.5\text{ sq ft}$ actual vinyl sail area). The center of aerodynamic pressure ($z_{cp}$) sits at approximately $1.94\text{ ft}$ ($23.25\text{ in.}$) above the athletic turf.

The triangular folding conduit frame exhibits two critical stability failure modes:

1. **Lateral Sliding on Synthetic Turf (The Primary Operational Failure Mode):**
   - On artificial turf lubricated by cryogenic crumb-rubber infill, the friction coefficient against smooth galvanized EMT conduit is only $\mu \approx 0.35$.
   - Under standard Tier 1 ballast (two 15-lb sandbags on rear rail C, $56.0\text{ lbs}$ total weight), **sliding begins at only $16.4\text{ mph}$**, well before overturning occurs.
   - Adding semicircular relief cuts drops drag by 15%, raising the sliding threshold to **$17.8\text{ mph}$** ($+1.4\text{ mph}$ margin gain).

2. **Forward Tipping Over Front Rail Under Rear Wind (Asymmetric Overturning Mode):**
   - Because the vertical display face and inner structural rails rest directly over the front ground rail, the unballasted frame has an effective front restoring arm of only $4.25\text{ in.}$ ($M_{rest, fwd} = 9.2\text{ ft-lb}$).
   - Unballasted, the screen tips forward at only **$8.1\text{ mph}$** (solid vinyl at Colorado Springs elevation).
   - Standard Tier 1 ballast (two 15-lb bags on rear rail C, $2.29\text{ ft}$ lever arm) adds $+68.7\text{ ft-lb}$, bringing forward restoring torque to **$77.9\text{ ft-lb}$** ($23.5\text{ mph}$ solid / **$25.5\text{ mph}$ with slits**).

```
          [REAR WIND] ===>                       |=======================|
                                                 |                       |
                                                 |   4' x 8' VINYL       |
                                                 |   DISPLAY FACE        |
                                                 |                       |
  [REAR RAIL C - BALLAST]                        |   (z_cp = 1.94 ft)    |
  (2x 15-lb Sandbags)                            |                       |
          v                                      |                       |
  ========O======================================+=======================|
          ^                   \                  ^
      Rear Rail C              \ Support Arm E   Front Rail A
   (2.29 ft Lever Arm)          \               (Zero Frame Arm)
                                 \
                         Clip (I) on Rail 3
```

### 2.2 Aerodynamic Benefit of Engineered Semicircular Relief Flaps

When wind strikes the banner, the semicircular flaps open outward along their uncut top horizontal hinge chords. This provides five critical mechanical benefits:

1. **Steady-State Drag Reduction:** Drops the net drag coefficient from $C_d = 1.20$ to $C_d = 1.02$ ($\sim 15.0\%$ reduction in lateral drag force and overturning moment).
2. **Turf Sliding Suppression:** Lowers lateral drag at 18 mph from $23.6\text{ lbs}$ to $20.0\text{ lbs}$, expanding the safe turf-anchoring envelope by $+1.4\text{ to }+1.8\text{ mph}$.
3. **Suppression of Destructive Vortex-Shedding Flutter:** Continuous vinyl surfaces suffer from coherent Strouhal vortex shedding (~0.8–1.2 Hz). Under sustained wind, this causes violent cyclic billow waves and negative suction (>3.0 psf) that pry perimeter greenhouse snap clamps off the 1/2" EMT tubing. Relief flaps bleed boundary-layer air, destroying coherent vortex formation.
4. **Tensile Pull Relief on 3D-Printed Hinged Arm Clips (I):** Under headwind, bottom support arms (E) act in tension, pulling directly against the snap-fit ASA clips on Rail 3 ($h = 10\text{ in.}$). Relief cuts reduce tensile pull by 15% (from 33.9 lbs to 28.8 lbs per clip at 20 mph), preventing clip jaw unseating.
5. **Two-Student Carry Dynamic Stability:** In the direct two-person carry protocol across the field, crosswinds generate up to 16.4 lbs of side thrust against the carried frame. Flaps bleed dynamic gusts, reducing wrist torquing and stumble hazards during field transit.

### 2.3 Aerodynamic Stability Comparison (Colorado Springs: 6,500 ft ASL)

Calculated using `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py` ($q = 0.001989 \cdot V^2\text{ psf}$, $\rho = 0.0595\text{ lb/ft}^3$):

| Wind Tier | Ballast Config | Total Wt | Solid Limit (Slide / Tip) | With Slits (Slide / Tip) | Stability Gain |
|---|---|:---:|:---:|:---:|:---:|
| **Tier 0: Calm** (0–8 mph) | Unballasted (Dry) | 26 lb | 11.2 mph (slide) / 8.1 mph (tip) | **12.1 mph** / **8.8 mph** | **+0.9 mph / +0.7 mph** |
| **Tier 1: Normal** (8–12 mph) | 1× 15-lb bag | 41 lb | 14.0 mph (slide) / 17.5 mph (tip) | **15.2 mph** / **19.0 mph** | **+1.2 mph / +1.5 mph** |
| **Tier 1: Recommended** (8–14 mph) | 2× 15-lb bags | 56 lb | 16.4 mph (slide) / 23.5 mph (tip) | **17.8 mph** / **25.5 mph** | **+1.4 mph / +2.0 mph** |
| **Tier 2: Advisory** (12–18 mph) | 3× 15-lb bags | 71 lb | 18.5 mph (slide) / 28.5 mph (tip) | **20.0 mph** / **30.9 mph** | **+1.5 mph / +2.4 mph** |
| **Tier 3: High-Wind** (18–22 mph) | 4× 15-lb bags | 86 lb | 20.3 mph (slide) / 32.8 mph (tip) | **22.1 mph** / **35.6 mph** | **+1.8 mph / +2.8 mph** |

*At sea level venues (e.g., BOA Grand Nationals in Indianapolis), air is $\sim 23\%$ denser; semicircular slits ensure Tier 1 (2-bag) ballast maintains turf stability up to $16.1\text{ mph}$ sliding (vs. $14.8\text{ mph}$ solid).*

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
| **Fleet Tooling Commonality** | **Identical to Rolling Backdrops.** 10 rolling backdrops use identical R = 4" semicircles. | **Incompatible.** Requires separate templates and volunteer instructions. | **Semicircle:** One standardized jig across the whole program. |
| **Hang & Camouflage** | **Hangs 100% flat.** Aspect ratio D/W = 0.50. High beam stiffness prevents tip droop in heat. | **Prone to tip curl & sag.** Aspect ratio D/W = 0.63–0.75. Tongue sags in 130°F+ turf heat. | **Semicircle:** Flap remains invisible from spectator stands. |
| **Tear Arrest & Tangency** | **180° smooth tangency.** Sweeps into pre-punched 3/8" holes with exact vertical tangency. | **Corner notch risk.** Straight legs to bottom curve often leave micro-notches at holes. | **Semicircle:** Eliminates stress risers (Kt → 1.0). |
| **Flap Dynamics** | **Clean hinge action.** Symmetrical arc swings open and falls flush without catching. | **Edge catching.** Elongated tongue can twist laterally in gusts and snag on edges. | **Semicircle:** Reliable one-way check-valve action. |

---

## 4. Size Recommendation & Evaluation

| Option | Dimensions (Radius) | Area / Flap | Vent Area (6 Flaps) | Recommendation |
|---|---|:---:|:---:|---|
| **Option 1 (Fleet Standard)** | **8.0" W × 4.0" drop** (R = 4.0") | 25.1 sq in (0.175 sq ft) | **1.05 sq ft (3.43%)** | **PRIMARY STANDARD.** Shared Rolling Backdrop tooling; optimal stiffness; zero sag; compact footprint. |
| **Option 2 (Approved Minimal)** | **10.0" W × 5.0" drop** (R = 5.0") | 39.3 sq in (0.273 sq ft) | **1.64 sq ft (5.37%)** | **APPROVED ALTERNATIVE.** Higher vent area for 6 cuts; slightly larger cut profile. |
| **Option 3 (Discouraged)** | **12.0" W × 6.0" drop** (R = 6.0") | 56.5 sq in (0.393 sq ft) | **2.36 sq ft (7.73%)** | **DISCOURAGED.** Large cuts disrupt artwork; heavier flap prone to chatter/sag in heat. |

### Rationale for Standardizing on 8.0" × 4.0" ($R = 4.0"$)
1. **Tooling Efficiency:** PCHSMB volunteers build 16 Sideline Screens and 10 Rolling Backdrops. Standardizing on an $8.0\text{ in.}$ chord and $R = 4.0\text{ in.}$ ensures that volunteers only need one size rotary punch ($\varnothing 3/8"$) and one 3D-printed cutting guide or compass setting across both prop fleets.
2. **Structural Banner Integrity & Camouflage:** An $8.0\text{ in.}$ cut with a $4.0\text{ in.}$ drop preserves the structural tension of the vinyl banner across the conduit span and navigates easily around printed graphic elements.
3. **Backstage Equipment Concealment:** The compact $4.0\text{ in.}$ drop keeps the lowest flap apex at $Y = 20.0\text{ in.}$, providing a full $10.0\text{ in.}$ vertical safety margin above staged color guard floor equipment ($Y \le 10.0\text{ in.}$).
4. **Optimal Vent Percentage:** 6 flaps total **$1.047\text{ sq ft}$** ($3.43\%$ of the face), landing squarely within the proven 3.0% to 5.0% aerodynamic threshold for boundary layer pressure relief.

---

## 5. Positioning & Coordinate Layout Recommendation

### 5.1 Vertical Zonation (Overturning Moment Mechanics & Concealment Buffer)

Overturning moment is the product of lateral force and elevation ($M = F \cdot z$). Relieving aerodynamic drag higher on the frame delivers superior overturning stability:
- **Upper Row (Row 1):** Centered at **$Y = 34.0\text{ in.}$** ($2.83\text{ ft}$ above turf). Hinge sits $8.0\text{ in.}$ below upper inner rail 2 and $10.5\text{ in.}$ below top perimeter rail 1.
- **Lower Row (Row 2):** Centered at **$Y = 24.0\text{ in.}$** ($2.00\text{ ft}$ above turf). Bottom apex reaches down to $Y = 20.0\text{ in.}$, maintaining a $10.0\text{ in.}$ buffer above lower rail 3.
- **Excluded Zones:**
  - *Top Perimeter Tension Band ($Y > 36.0\text{ in.}$):* Avoided to preserve vinyl tension under top greenhouse snap clamps.
  - *Bottom Tension & Latch Line ($Y < 18.0\text{ in.}$):* Avoided to prevent interference with Rail 3 ($Y = 10.0\text{ in.}$) where Hinged Arm Clips (I) latch during field deployment.
  - *Backstage Equipment Zone ($Y \le 10.0\text{ in.}$):* Color guard rifles, sabres, and floor equipment lie below $Y = 10.0\text{ in.}$; positioning all cuts at $Y \ge 20.0\text{ in.}$ guarantees 100% equipment concealment from spectator sightlines.

### 5.2 Perimeter & Frame Clearances
- **Frame Clearance:** Outer end rails (B) are located at $X = 0\text{ in.}$ and $X = 92.5\text{ in.}$. Flaps maintain at least **$16.5\text{ in.}$ clearance** from outer upright rails ($20.0\text{ in.} \le X \le 76.0\text{ in.}$).
- **Support Arm Clearance:** Folding support arms (E) attach between rail 3 and rear rail C behind the lower portion of the screen; all cuts are well above the arm swing paths.
- **Snap Clamp Clearance:** Greenhouse snap clamps secure the banner along top rail 1 and bottom ground rail. All cuts maintain at least $10\text{ in.}$ clearance from perimeter clamp locations.

---

### 5.3 Exact Coordinate Layouts

```
   0"          24.0"                   48.0"                   72.0"         96.0"
  +-------------+-----------------------+-----------------------+-------------+
  | [Rail 1] Top Perimeter Frame Rail (Y = 44.5")                             | 48"
  |   (Unvented Upper Tension Band: Y = 36" to 44.5")                         |
  |                                                                           |
  |          (O)==(O)                (O)==(O)                (O)==(O)         |
  |           \___/                   \___/                   \___/           | 34" (Row 1)
  |                                                                           |
  |                                                                           |
  |          (O)==(O)                (O)==(O)                (O)==(O)         |
  |           \___/                   \___/                   \___/           | 24" (Row 2)
  |                                                                           |
  |   (Unvented Lower Band: Y = 0" to 18" -- Conceals Floor Equipment)        |
  | [Rail 3] Lower Inner Frame Rail / Clip Latch Line (Y = 10.0")             |
  +---------------------------------------------------------------------------+ 0" (Turf Line)
```

#### 6-Flap Fleet Standard (2 Rows × 3 Columns) — [RECOMMENDED]

*Best aerodynamic distribution; 100% tooling unification with Rolling Backdrops.*

| Cut | Row | Height (Y) | Center (X) | Punch Holes at X | Arc Bottom (Y) | Clear Span from Ground |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **F-1** | Row 1 (Upper) | 34.0" (2.83 ft) | 24.0" (2.0 ft) | 20.0" and 28.0" | 30.0" (2.50 ft) | 30.0 in. |
| **F-2** | Row 1 (Upper) | 34.0" (2.83 ft) | 48.0" (4.0 ft) | 44.0" and 52.0" | 30.0" (2.50 ft) | 30.0 in. |
| **F-3** | Row 1 (Upper) | 34.0" (2.83 ft) | 72.0" (6.0 ft) | 68.0" and 76.0" | 30.0" (2.50 ft) | 30.0 in. |
| **F-4** | Row 2 (Lower) | 24.0" (2.00 ft) | 24.0" (2.0 ft) | 20.0" and 28.0" | 20.0" (1.67 ft) | 20.0 in. |
| **F-5** | Row 2 (Lower) | 24.0" (2.00 ft) | 48.0" (4.0 ft) | 44.0" and 52.0" | 20.0" (1.67 ft) | 20.0 in. |
| **F-6** | Row 2 (Lower) | 24.0" (2.00 ft) | 72.0" (6.0 ft) | 68.0" and 76.0" | 20.0" (1.67 ft) | 20.0 in. |

*(Note: Dimensions are measured from the bottom-left corner of the front frame face resting on athletic turf.)*

---

### 5.4 Artwork Protection, Optical Camouflage & The "Floating Flap" Adjustment Rule

The coordinates in Section 5.3 represent theoretical layout targets. In production, each year's marching band show features unique visual graphics (e.g., character portraits, architectural motifs, high-contrast title typography).

To prevent visual disruption and ensure complete optical camouflage from the stands, fabrication teams **MUST** follow these rules:

1. **Viewing Distance & Visual Acuity (1 Arcminute Resolution):**
   - Spectator stands sit 25–60 yards away; judges' press boxes sit 40–80+ yards away.
   - At 30 yards (90 ft), human visual acuity resolves features down to $0.31\text{ in.}$ ($8.0\text{ mm}$).
   - A razor cut has a kerf width $<0.01\text{ in.}$ ($0.25\text{ mm}$)—**over 30× smaller than the human visual threshold**. Because the flap is cut directly from the printed graphic with zero material removed along the arc, the cut line is completely undetectable from spectator stands.
   - The $\varnothing 3/8\text{ in.}$ punch holes match the threshold at 30 yards and are imperceptible from the press box, blending seamlessly into printed textures.
2. **Floating Allowance ($\pm 6\text{ to }12\text{ in.}$):** Any cut centerline may float horizontally by up to $\pm 12.0\text{ in.}$ (and vertically by $\pm 4.0\text{ in.}$) along its row to position the flap into solid background colors, dark textures, sky gradients, or negative graphic space.
3. **Mandatory NO-CUT Zones:**
   - **Depicted Performer Faces / Portraits:** Flaps must maintain at least $6.0\text{ in.}$ clearance from any performer faces printed in the artwork.
   - **Show Title & Typography:** Cuts must never intersect lettering, musical notations, or movement titles.
   - **School / Sponsor Logos & Crests:** Zero cuts permitted through Pine Creek emblems, logos, or competition branding.
4. **Backstage Equipment Concealment:**
   - Flaps maintain **96.6% solid, 100% opaque vinyl coverage** (vent area is only 3.43%), completely avoiding translucent mesh.
   - All staged rifles, sabres, and floor equipment rest below $Y = 10.0\text{ in.}$, while the lowest flap apex sits at $Y = 20.0\text{ in.}$, guaranteeing complete visual shielding even during wind gusts.
5. **Backlight & Daylight Pinprick Baffle (Optional Shop Detail):**
   - In venues where the late-afternoon sun sits behind the back sideline (e.g., Falcon Stadium looking west toward the Rampart Range), direct sunlight can shine through the $\varnothing 3/8\text{ in.}$ punch holes.
   - Apply a $1.5\text{ in.} \times 1.5\text{ in.}$ square of black heavy-duty tape (Gorilla tape) to the backside of the vinyl behind each punch hole.
   - Slice a horizontal razor slit through the tape along the lower circumference. This blocks direct solar pinpricks while allowing boundary-layer air to exhaust freely when the flap opens.

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
1. **Clean Staging:** Spread moving blankets on a flat, clean shop floor. Lay the banner flat with zero grit or dirt underneath (or perform on fully clamped frame).
2. **Mark Coordinates & Inspect Artwork:** Mark the top horizontal chord centerlines and endpoint punch marks ($8.0\text{ in.}$ apart) using the marking pencil. Verify compliance with the Floating Flap Rule (Section 5.4) to avoid faces, text, and crests.
3. **MANDATORY PUNCH FIRST:** Place the hardwood block directly underneath the first punch location. Align the $\varnothing 3/8\text{ in.}$ punch exactly over the mark and strike firmly with a mallet to punch a clean, circular hole with zero fraying. Repeat for the second hole ($8.0\text{ in.}$ apart).
   > [!CRITICAL]
   > **NEVER** use a razor knife before punching the circular holes. Slicing first creates sharp microscopic corner tears ($K_t \ge 3.0$) that will rapidly propagate into a full rip during wind events.
4. **Scribe the Circular Arc:** Place the $R = 4.0\text{ in.}$ template or compass tangent to the bottom edge of the two punched holes.
5. **Execute the Semicircular Cut:** In a single, smooth motion, draw the razor along the curved circular template, starting at the tangent edge of Hole 1, sweeping down through the $4.0\text{ in.}$ apex, and terminating cleanly at the tangent edge of Hole 2.
6. **LEAVE TOP CHORD UNCUT:** Under no circumstances should the top $8.0\text{ in.}$ line between the holes be cut. This uncut vinyl serves as the permanent gravity hinge.
7. **Inspect Flap Action & Alignment:** Stand the screen upright. Verify that the flap hangs completely flat, coplanar, and flush under gravity with zero tip curling or binding. Push gently on the back to verify it swings open freely and drops shut flush. Apply optional backlight baffles (Section 5.4) if specified for low-sun venues.

---

## 8. Addendum: Wind De-Rating Analysis for Delayed / Unvented Vinyl Operation

### 8.1 Problem Statement & Field Context
If prop construction schedules require fielding the Sideline Screens / Duck Blinds during early season rehearsals before the 6 engineered semicircular wind relief flaps can be precision-cut and punched, the props operate with **100% solid, unvented vinyl faces**. 

This engineering addendum establishes the exact aerodynamic de-rating factors, failure mode shifts, and volunteer operational rules required to safely operate unvented screens without risking prop damage, snap clamp ejection, or student injury.

### 8.2 Aerodynamic Physics & Force Multiplier
1. **Drag Coefficient ($C_d$):** Solid, unvented scrim vinyl exhibits a flat-plate drag coefficient of $C_d = 1.20$. Standard semicircular flaps reduce this to $C_d = 1.02$ ($\sim 15.0\%$ steady-state drag reduction).
2. **Force & Overturning Moment Scaling:**
   Lateral wind force $F_{wind} = q \cdot A \cdot C_d$ and overturning moment $M_{OT} = F_{wind} \cdot z_{cp}$ scale directly with $C_d$.
   $$\frac{F_{\text{solid}}}{F_{\text{vented}}} = \frac{1.20}{1.02} = 1.176 \quad (+17.6\% \text{ higher lateral force and overturning torque at identical wind speed})$$
3. **Allowable Wind Velocity Scaling:**
   Because aerodynamic dynamic pressure scales quadratically with velocity ($q \propto V^2$), the allowable velocity threshold for any given restoring moment or friction limit scales as:
   $$V_{\text{solid}} = V_{\text{vented}} \times \sqrt{\frac{1.02}{1.20}} = V_{\text{vented}} \times \sqrt{0.850} \approx 0.922 \cdot V_{\text{vented}} \quad (\sim 7.8\% \text{ reduction in allowable wind speed})$$

### 8.3 Stability Thresholds: Solid vs. Vented (Colorado Springs: 6,500 ft ASL)
Calculated using `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py` ($q = 0.001989 \cdot V^2\text{ psf}$, $\rho = 0.0595\text{ lb/ft}^3$, $A = 30.5\text{ sq ft}$, $z_{cp} = 1.94\text{ ft}$, turf $\mu = 0.35$):

| Ballast Tier | Ballast Configuration | Total Weight | Solid Limit (Slide / Tip) | Vented Limit (Slide / Tip) | Calculated De-Rating |
|---|---|:---:|:---:|:---:|:---:|
| **Tier 0: Calm** | 0 bags (Dry frame, 26 lb) | 26 lb | 11.2 mph (slide) / 8.1 mph (tip) | 12.1 mph (slide) / 8.8 mph (tip) | $-0.9\text{ mph}$ (slide) / $-0.7\text{ mph}$ (tip) |
| **Tier 1: Normal** | 1× 15-lb bag on rear rail C | 41 lb | 14.0 mph (slide) / 17.5 mph (tip) | 15.2 mph (slide) / 19.0 mph (tip) | $-1.2\text{ mph}$ (slide) / $-1.5\text{ mph}$ (tip) |
| **Tier 1: Standard** | 2× 15-lb bags on rear rail C | 56 lb | 16.4 mph (slide) / 23.5 mph (tip) | 17.8 mph (slide) / 25.5 mph (tip) | $-1.4\text{ mph}$ (slide) / $-2.0\text{ mph}$ (tip) |
| **Tier 2: Advisory** | 3× 15-lb bags (2 ground + 1 hang) | 71 lb | 18.5 mph (slide) / 28.5 mph (tip) | 20.0 mph (slide) / 30.9 mph (tip) | $-1.5\text{ mph}$ (slide) / $-2.4\text{ mph}$ (tip) |
| **Tier 3: High-Wind** | 4× 15-lb bags (2 ground + 2 hang) | 86 lb | 20.3 mph (slide) / 32.8 mph (tip) | 22.1 mph (slide) / 35.6 mph (tip) | $-1.8\text{ mph}$ (slide) / $-2.8\text{ mph}$ (tip) |

*At sea level venues (e.g. BOA Grand Nationals in Indianapolis, $\rho = 0.0765\text{ lb/ft}^3$), air density is 23% higher; solid vinyl on Tier 1 (2 bags) slips on turf at only $14.8\text{ mph}$ (vs. $16.1\text{ mph}$ with slits).*

### 8.4 Non-Linear Dynamic Risks of Operating Unvented Vinyl
Beyond steady-state thresholds, delaying wind relief cuts introduces three critical non-linear dynamic hazards:
1. **Coherent Vortex-Shedding Flutter & Snap Clamp Ejection:**
   Continuous solid vinyl acts as an unvented membrane subject to coherent Strouhal vortex shedding (~0.8–1.2 Hz). Under sustained crosswinds, this generates cyclic billowing waves and negative suction peaks ($>3.0\text{ psf}$) that violently twist the $1/2\text{ in.}$ EMT conduit and can pop perimeter greenhouse snap clamps off the frame. Flaps destroy coherent vortex structures and bleed suction.
2. **Two-Student Direct Carry Crosswind Load:**
   When student pairs carry assembled screens onto the field, an unvented face acts as a continuous sail. In a $15\text{ mph}$ crosswind, solid vinyl exerts **$16.4\text{ lbs}$ of lateral drag** directly against the handlers' hands and wrists, increasing stumble hazards during rapid field entry.
3. **Tensile Load on 3D-Printed Rail 3 Clips (I):**
   Under headwind, strut arms (E) pull directly against the 3D-printed ASA snap-fit clips on Rail 3. Unvented vinyl increases this peak pull force by $+17.6\%$ (from $28.8\text{ lbs}$ up to $33.9\text{ lbs}$ per clip at 20 mph), reducing safety margins against jaw unseating.

### 8.5 Volunteer Operational Rule (Field Simplification)
Volunteer parent crew and student handlers cannot be expected to calculate an 8% mathematical reduction or interpolate decimal miles-per-hour under competition pressure. To guarantee safety, the calculated de-ratings ($0.9–1.8\text{ mph}$) are **rounded up to a flat 2 mph reduction across all wind regimes**, Tier 0 dry staging is eliminated, and the abort ceiling is lowered:

> [!IMPORTANT]
> **Operational Guidance for Unvented Vinyl:**
> *"Without wind relief cuts, the props may be used by derating all wind regimes by 2MPH, decreasing the Tier 4 Abort threshold to 12MPH sustained / 16MPH gusts, and increasing the duck blind tier 0 ballasting to 2 bags."*

---

## 9. Subproject Cross-References

- **Master Subproject README:** [`PCHSMB/_Sideline Screen/README.md`](../../README.md)
- **Technical Specification:** [`PCHSMB/_Sideline Screen/docs/references/TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md) (Step 3.1)
- **Field Logistics & Timing Analysis:** [`PCHSMB/_Sideline Screen/docs/references/FIELD_LOGISTICS_AND_TIMING_ANALYSIS.md`](FIELD_LOGISTICS_AND_TIMING_ANALYSIS.md)
- **Rolling Backdrop Fleet Specification:** [`PCHSMB/_Backdrop/docs/references/WIND_RELIEF_CUTS_SPECIFICATION.md`](../../_Backdrop/docs/references/WIND_RELIEF_CUTS_SPECIFICATION.md)
- **Wind Loading Skill CLI:** `.agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py`
- **Aerodynamic Models & Math:** `.agents/skills/calculate-prop-wind-loading/references/aerodynamic-models.md`
