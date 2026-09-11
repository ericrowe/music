# Sideline Screen / Duck Blind: 30 mph Wind Loading & Ballasting Feasibility Analysis

**Document Status:** Engineering Reference & Feasibility Study  
**Subproject:** Pine Creek High School Marching Band (PCHSMB) Sideline Screen / Duck Blind  
**Authoritative Cross-References:**
- Technical Specification: [`TECHNICAL_SPEC.md`](TECHNICAL_SPEC.md) (Section 5)
- Authoritative Operations Manual (DOCX): [`Sideline_Screen_Duck_Blind_Build_Instructions.docx`](../Sideline_Screen_Duck_Blind_Build_Instructions.docx)
- Authoritative Operations Manual (PDF): [`Sideline_Screen_Duck_Blind_Build_Instructions.pdf`](../Sideline_Screen_Duck_Blind_Build_Instructions.pdf)
- Calculation Engine & CLI: [`calculate-prop-wind-loading`](../../../../.agents/skills/calculate-prop-wind-loading/SKILL.md)
- Primary CAD Models: [`Hinged Arm Clip.FCStd`](../../Hardware/Hinged%20Arm%20Clip.FCStd), [`Weight Clip.FCStd`](../../Hardware/Weight%20Clip.FCStd)

---

## 1. Executive Summary & Core Engineering Verdict

### Question
*Can the PCHS Sideline Screens (Duck Blinds) be ballasted with additional sandbags to safely sustain winds up to 30 mph?*

### Engineering Verdict
**Theoretically (Static Tipping Calculation):** Yes. Adding **~140 to 165 lbs of sandbags per screen** (9 to 11 double-bagged 15-lb bags) can mathematically balance the 30 mph overturning moment.

**Practically & Mechanically: ABSOLUTELY NOT. It is NOT safe or viable for field competition.**  
Attempting to deploy duck blinds in 30 mph winds will cause severe structural, mechanical, and operational failure before overturning ballast is ever tested. At 30 mph, the prop will fail through:
1. **Lateral Sliding / Turf Drift:** The screen will slide across the turf like a sail on ice due to low friction between smooth EMT conduit and rubber turf infill.
2. **Mechanical Detachment of 3D-Printed Snap Clips (I):** Tensile wind loads under headwind exceed the pull-off retention strength of the 3D-printed snap-fit clips, collapsing the rear support frame.
3. **Greenhouse Snap Clamp & Vinyl Peeling:** Dynamic flutter and gust suction will peel snap clamps off the perimeter.
4. **Logistical Impossibility:** High school student handlers cannot safely transport, position, or clear 170+ lbs of prop and ballast within the 15-second deployment window mandated by CBA timing rules.

The **Tier 4 Safety Abort threshold (>20 mph sustained / >25 mph peak gusts)** established in Appendix A and Placard C must remain the strict, non-negotiable operational limit. If 30 mph winds or gusts occur, the only legal, safe action is the **Emergency Lay-Flat Protocol**.

---

## 2. Aerodynamic Force & Moment Calculations (30 mph)

### 2.1 Physical Geometry & Baseline Constants
* **Nominal Dimensions:** 4 ft nominal height × 8 ft nominal width
* **Actual Vinyl Sail Area ($):** .5	ext{ sq ft}$ (.875	ext{ ft vertical projected height} 	imes 7.875	ext{ ft width}$)
* **Center of Pressure ({cp}$):** .94	ext{ ft}$ above ground (geometric centroid of face)
* **Triangular Base Stance ({base}$):** .29	ext{ ft}$ (27.5 in. between front bottom rail and rear rail C)
* **Dry Prop Weight ({dry}$):** .0	ext{ lbs}$ (EMT conduit, brackets, vinyl banner)
* **Dry Center of Gravity ({cg}$):** zsh.354	ext{ ft}$ rearward from front bottom rail (.936	ext{ ft}$ forward of rear rail C)
* **Turf Friction Coefficient ($\mu$):** zsh.35$ (smooth steel conduit on synthetic turf with rubber infill)

### 2.2 Atmospheric Scaling: Colorado Springs vs. Sea Level
Dynamic velocity pressure is governed by Bernoulli's equation:

35611q = rac{1}{2} \left(rac{ho}{g_c}ight) V^235611

Where  = 30	ext{ mph} = 44.0	ext{ ft/s}$:
* **Colorado Springs (6,500 ft ASL):** Air density $ho = 0.0595	ext{ lb/ft}^3$ (~84.2% of sea-level standard)
  35611q = rac{1}{2} \left(rac{0.0595}{32.174}ight) (44.0)^2 = \mathbf{1.79	ext{ psf}}35611
* **Sea Level (0 ft ASL):** Air density $ho = 0.0765	ext{ lb/ft}^3$
  35611q = rac{1}{2} \left(rac{0.0765}{32.174}ight) (44.0)^2 = \mathbf{2.30	ext{ psf}}35611

### 2.3 Aerodynamic Loads at 30 mph
Total lateral wind drag ({	ext{wind}} = q \cdot C_d \cdot A$) and overturning moment ({	ext{wind}} = F_{	ext{wind}} \cdot h_{cp}$):

| Parameter | CO Springs (Solid Vinyl, =1.20$) | CO Springs (With Slits, =1.02$) | Sea Level (Solid Vinyl, =1.20$) | Sea Level (With Slits, =1.02$) |
|---|:---:|:---:|:---:|:---:|
| **Velocity Pressure ($)** | .79	ext{ psf}$ | .79	ext{ psf}$ | .30	ext{ psf}$ | .30	ext{ psf}$ |
| **Lateral Wind Force ({	ext{wind}}$)** | **.5	ext{ lbs}* | **.7	ext{ lbs}* | **.2	ext{ lbs}* | **.6	ext{ lbs}* |
| **Overturning Moment ({	ext{wind}}$)** | **.1	ext{ ft-lb}* | **.0	ext{ ft-lb}* | **.4	ext{ ft-lb}* | **.9	ext{ ft-lb}* |

---

## 3. Four Fatal Failure Modes at 30 mph Winds

### Failure Mode 1: Lateral Sliding on Artificial Turf (The "Sail on Ice" Effect)
Even if ballast prevents tipping, horizontal wind drag pushes the prop laterally across the athletic turf.
* Synthetic turf fibers lubricated with cryogenic crumb rubber infill offer very low sliding resistance against smooth circular galvanized steel tubing ($\mu pprox 0.35$).
* To resist .5	ext{ lbs}$ of lateral sliding force at Factor of Safety FoS = 1.0:
  35611W_{	ext{total}} = rac{F_{	ext{wind}}}{\mu} = rac{65.5	ext{ lbs}}{0.35} = \mathbf{187.2	ext{ lbs}}35611
* Subtracting the 26-lb dry prop weight requires:
  35611	ext{Ballast Required (Sliding)} = 187.2 - 26.0 = \mathbf{161.2	ext{ lbs}} \quad (pprox \mathbf{11	ext{ double-bagged 15-lb sandbags}})35611
* **Field Consequence:** With standard ballast (2 to 4 sandbags = 30 to 60 lbs), lateral sliding occurs at only **15.8 to 19.5 mph**. At 30 mph, the duck blind will skate horizontally across the field into color guard performers, front ensemble keyboard instruments, or audio snakes.

### Failure Mode 2: Tensile Detachment of 3D-Printed Hinged Arm Clips (I)
When wind blows against the front face (headwind pushing backward), the face rotates about rear rail C:
* The bottom support arms (E) act in **tension**, pulling directly outward against the 3D-printed [Hinged Arm Clips (I)](../../Hardware/Hinged%20Arm%20Clip.FCStd) on Rail 3.
* Geometry: Rail 3 sits  pprox 10	ext{ in.} = 0.833	ext{ ft}$ above the turf.
* Horizontal tensile detachment load across the two clips:
  35611F_{	ext{clip, total}} pprox rac{M_{	ext{wind}}}{h_{	ext{clip}}} = rac{127.1	ext{ ft-lb}}{0.833	ext{ ft}} pprox \mathbf{152.6	ext{ lbs total}}35611
  35611F_{	ext{clip, per clip}} pprox rac{152.6}{2} = \mathbf{76.3	ext{ lbs of outward tensile pull per clip}}35611
* **Structural Reality:** Clip (I) is a 3D-printed ASA snap-fit C-collar. It relies on friction and elastic snap retention over the 0.922" OD conduit. It has no through-bolt. Under 	ext{ lbs}$ of continuous dynamic pull, the snap jaws will deform and pop off the conduit. Once one clip disengages, the rear support frame collapses instantly and the entire prop is flattened or rolls downfield.

### Failure Mode 3: Greenhouse Snap Clamp Peeling & Vinyl Flutter
* The vinyl banner is secured with 16 plastic greenhouse snap clamps (1" trade size) over 4" strips of double-sided mounting tape.
* At 30 mph, aerodynamic vortex shedding creates intense cyclic flutter and localized negative pressure spikes (suction) exceeding .5	ext{ psf}$ along the top rail.
* This cyclic buffeting will fatigue the plastic clamps, snapping them off or peeling the vinyl away from the perimeter framing.

### Failure Mode 4: Human Factors & CBA Timed Field Entry
* **CBA Rules 5.03 & 5.06 Mandate:** Bands have approximately 3 to 4 minutes total to move onto the field, stage all equipment, and clear all non-student volunteers before the performance announcement finishes.
* **15-Second Deployment:** Sideline screens must be positioned, unfolded, and ballasted in ~15 seconds by two student handlers.
* Hauling 9 to 11 sandbags (–165	ext{ lbs}$) per prop means:
  - For a full front sideline set of 8 to 12 screens, the logistics crew would need to haul **1,200 to 2,000 lbs of sandbags** onto the field and then sprint them up the stadium hill after the show (Rule 8.05).
  - Student handlers cannot physically carry or accurately position that much weight within timed boundaries without severe risk of injury or competition timing penalties (Rule 4.03).

---

## 4. Engineering Comparison Table across Wind Regimes

All calculations below assume Colorado Springs 6,500 ft ASL baseline, solid vinyl ( = 1.20$),  = 30.5	ext{ sq ft}$, dry weight .0	ext{ lbs}$:

| Wind Speed / Operational Tier | Dynamic Pressure ($) | Lateral Drag ($) | Overturning Moment ($) | Rear Rail C Ballast (Fwd Tip FoS=1.5) | Rail 2 Ballast (Bwd Tip FoS=1.5) | Min Weight for Turf Anti-Slide | Structural / Safety Status |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|---|
| **Tier 0: Calm (0–8 mph)** | zsh.13	ext{ psf}$ | .7	ext{ lbs}$ | .0	ext{ ft-lb}$ | **0 lbs** (0 bags) | **0 lbs** (0 bags) | 	ext{ lbs}$ | Safe. Zero ballast needed. |
| **Tier 1: Normal (8–12 mph)** | zsh.29	ext{ psf}$ | .5	ext{ lbs}$ | .3	ext{ ft-lb}$ | **15 lbs** (1 bag) | **0 lbs** (0 bags) | 	ext{ lbs}$ | Safe. Standard field protocol. |
| **Tier 2: Advisory (12–18 mph)** | zsh.65	ext{ psf}$ | .6	ext{ lbs}$ | .8	ext{ ft-lb}$ | **30 lbs** (2 bags) | **15 lbs** (1 bag) | 	ext{ lbs}$ | Balanced. Attentive staging. |
| **Tier 3: High-Wind (18–22 mph)** | zsh.96	ext{ psf}$ | .3	ext{ lbs}$ | .4	ext{ ft-lb}$ | **45 lbs** (3 bags) | **30 lbs** (2 bags) | 	ext{ lbs}$ | **MAXIMUM SAFE LIMIT.** Total 75 lbs ballast. |
| **25 mph Peak Allowed Gust** | .24	ext{ psf}$ | .5	ext{ lbs}$ | .3	ext{ ft-lb}$ | **54 lbs** (4 bags) | **39 lbs** (3 bags) | 	ext{ lbs}$ | Marginal. Extreme caution. |
| **30 mph Severe Wind** | **.79	ext{ psf}* | **.5	ext{ lbs}* | **.1	ext{ ft-lb}* | **79 lbs** (5–6 bags) | **67 lbs** (4–5 bags) | **	ext{ lbs}* | **CATASTROPHIC FAILURE.** Sliding, clip failure, snap peel. |

---

## 5. High-Wind Operational Protocol at 30 mph

When wind conditions approach or exceed 20 mph sustained or 25 mph peak gusts:

### 5.1 Staging Area Protocol (Trailer Lot)
* **Keep Props Folded Flat:** Keep all sideline screens folded flat on the bed of their rolling transport cart in the trailer staging area.
* In the horizontal folded state, the aerodynamic sail area is negligible, eliminating all overturning and sliding hazards.

### 5.2 On-Field Emergency Abort Sequence
If sudden severe gusts (>25 mph) strike while screens are deployed on the field:
1. **Immediate Clip Disengagement:** Student handlers reach to Rail 3 and pull the bottom support arms (E) upward, snapping them free from the 3D-printed clips (I).
2. **Rear Frame Collapse:** Swing the rear support frame (D/C) flat against the main vertical frame.
3. **Turf Lay-Flat:** Gently lower the entire assembly flat onto the artificial turf with the vinyl facing upward.
4. **CBA Rule 4.02(a) Adult Intervention:** Under CBA Rule 4.02(a), adult staff and volunteer pit crew wearing official Rule 9.07 wristbands may legally enter the performance area to assist in laying props flat or physically holding frames without incurring a 0.2-point boundary or field entry penalty.

---

## 6. Design Hardening Required for Theoretical 30 mph Capability

If future design iterations ever mandate mechanical survival in 30 mph winds, the following engineering modifications would be strictly required:

1. **Positive-Lock Through-Pinning for Clips (I):**
   Replace the friction snap-fit clips with through-bolted 3/4" EMT clevis brackets and push-button quick-release detent hitch pins capable of resisting $>200	ext{ lbs}$ of shear/tensile load.
2. **Engineered Wind Relief Slits:**
   Incorporate 3 rows of horizontal crescent slits ("	ext{ wide} 	imes 5"	ext{ drop}$) with $arnothing 3/8"$ round punch-hole endpoints. This drops the drag coefficient from  = 1.20$ to .02$ (a ~15–18% reduction in lateral drag).
3. **Turf High-Friction Cleats:**
   Install textured high-durometer EPDM rubber foot pads or silicone gripping sleeves along the underside of ground rails B and C to increase the friction coefficient $\mu$ from zsh.35$ to $\ge 0.65$, reducing the weight needed to prevent sliding.
4. **Perimeter Clamp Mechanical Screwing:**
   Install low-profile self-tapping screws through the greenhouse snap clamps into the conduit to prevent wind suction peeling.
