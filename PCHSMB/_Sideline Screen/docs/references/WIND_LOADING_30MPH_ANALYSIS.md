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
1. **Lateral Sliding / Turf Drift:** The screen will slide horizontally across the turf like a sail on ice due to low friction ($\mu \approx 0.35$) between smooth EMT conduit and rubber turf infill.
2. **Mechanical Detachment of 3D-Printed Snap Clips (I):** Tensile wind loads under headwind exceed the pull-off retention strength of the 3D-printed snap-fit clips, collapsing the rear support frame.
3. **Greenhouse Snap Clamp & Vinyl Peeling:** Dynamic flutter and gust suction (>3.0 psf) will peel snap clamps off the perimeter framing.
4. **Logistical & CBA Timing Failure:** Transporting and deploying 140–165 lbs of sandbags per prop completely breaks the 3-person crew deployment choreography, exceeding the CBA Rule 5.06 3:15 field clearance window.

The **Tier 4 Safety Abort threshold (>20 mph sustained / >25 mph peak gusts)** established in Appendix A and Placard C must remain the strict, non-negotiable operational limit. If 30 mph winds or gusts occur, the only legal, safe action is the **Emergency Lay-Flat Protocol**.

---

## 2. Aerodynamic Force & Moment Calculations (30 mph)

### 2.1 Physical Geometry & Baseline Constants
* **Nominal Dimensions:** 4 ft nominal height × 8 ft nominal width
* **Actual Vinyl Sail Area ($A$):** $30.5\text{ sq ft}$ ($3.875\text{ ft vertical projected height} \times 7.875\text{ ft width}$)
* **Center of Pressure ($h_{cp}$):** $1.94\text{ ft}$ above ground (geometric centroid of face)
* **Triangular Base Stance ($L_{base}$):** $2.29\text{ ft}$ (27.5 in. between front bottom rail and rear rail C)
* **Dry Prop Weight ($W_{dry}$):** $26.0\text{ lbs}$ (EMT conduit, brackets, vinyl banner)
* **Dry Center of Gravity ($x_{cg}$):** $0.354\text{ ft}$ rearward from front bottom rail ($1.936\text{ ft}$ forward of rear rail C)
* **Turf Friction Coefficient ($\mu$):** $0.35$ (smooth steel conduit on synthetic turf with rubber infill)

### 2.2 Atmospheric Scaling: Colorado Springs vs. Sea Level
Dynamic velocity pressure is governed by Bernoulli's equation:

$$q = \frac{1}{2} \left(\frac{\rho}{g_c}\right) V^2$$

Where $V = 30\text{ mph} = 44.0\text{ ft/s}$:
* **Colorado Springs (6,500 ft ASL):** Air density $\rho = 0.0595\text{ lb/ft}^3$ (~84.2% of sea-level standard)
  $$q = \frac{1}{2} \left(\frac{0.0595}{32.174}\right) (44.0)^2 = \mathbf{1.79\text{ psf}}$$
* **Sea Level (0 ft ASL):** Air density $\rho = 0.0765\text{ lb/ft}^3$
  $$q = \frac{1}{2} \left(\frac{0.0765}{32.174}\right) (44.0)^2 = \mathbf{2.30\text{ psf}}$$

### 2.3 Aerodynamic Loads at 30 mph
Total lateral wind drag ($F_{\text{wind}} = q \cdot C_d \cdot A$) and overturning moment ($M_{\text{wind}} = F_{\text{wind}} \cdot h_{cp}$):

| Parameter | CO Springs (Solid Vinyl, $C_d=1.20$) | CO Springs (With Slits, $C_d=1.02$) | Sea Level (Solid Vinyl, $C_d=1.20$) | Sea Level (With Slits, $C_d=1.02$) |
|---|:---:|:---:|:---:|:---:|
| **Velocity Pressure ($q$)** | $1.79\text{ psf}$ | $1.79\text{ psf}$ | $2.30\text{ psf}$ | $2.30\text{ psf}$ |
| **Lateral Wind Force ($F_{\text{wind}}$)** | **$65.5\text{ lbs}$** | **$55.7\text{ lbs}$** | **$84.2\text{ lbs}$** | **$71.6\text{ lbs}$** |
| **Overturning Moment ($M_{\text{wind}}$)** | **$127.1\text{ ft-lb}$** | **$108.0\text{ ft-lb}$** | **$163.4\text{ ft-lb}$** | **$138.9\text{ ft-lb}$** |

---

## 3. Four Fatal Failure Modes at 30 mph Winds

### Failure Mode 1: Lateral Sliding on Artificial Turf (The "Sail on Ice" Effect)
Even if ballast prevents tipping, horizontal wind drag pushes the prop laterally across the athletic turf.
* Synthetic turf fibers lubricated with cryogenic crumb rubber infill offer very low sliding resistance against smooth circular galvanized steel tubing ($\mu \approx 0.35$).
* To resist $65.5\text{ lbs}$ of lateral sliding force at Factor of Safety $\text{FoS} = 1.0$:
  $$W_{\text{total}} = \frac{F_{\text{wind}}}{\mu} = \frac{65.5\text{ lbs}}{0.35} = \mathbf{187.2\text{ lbs}}$$
* Subtracting the 26-lb dry prop weight requires:
  $$\text{Ballast Required (Sliding)} = 187.2 - 26.0 = \mathbf{161.2\text{ lbs}} \quad (\approx \mathbf{11\text{ double-bagged 15-lb sandbags}})$$
* **Field Consequence:** With standard ballast (2 to 4 sandbags = 30 to 60 lbs), lateral sliding occurs at only **15.8 to 19.5 mph**. At 30 mph, the duck blind will skate horizontally across the field into color guard performers, front ensemble keyboard instruments, or audio snakes.

### Failure Mode 2: Tensile Detachment of 3D-Printed Hinged Arm Clips (I)
When wind blows against the front face (headwind pushing backward), the face rotates about rear rail C:
* The bottom support arms (E) act in **tension**, pulling directly outward against the 3D-printed [Hinged Arm Clips (I)](../../Hardware/Hinged%20Arm%20Clip.FCStd) on Rail 3.
* Geometry: Rail 3 sits $h \approx 10\text{ in.} = 0.833\text{ ft}$ above the turf.
* Horizontal tensile detachment load across the two clips:
  $$F_{\text{clip, total}} \approx \frac{M_{\text{wind}}}{h_{\text{clip}}} = \frac{127.1\text{ ft-lb}}{0.833\text{ ft}} \approx \mathbf{152.6\text{ lbs total}}$$
  $$F_{\text{clip, per clip}} \approx \frac{152.6}{2} = \mathbf{76.3\text{ lbs of outward tensile pull per clip}}$$
* **Structural Reality:** Clip (I) is a 3D-printed ASA snap-fit C-collar. It relies on friction and elastic snap retention over the 0.922" OD conduit. It has no through-bolt. Under $76\text{ lbs}$ of continuous dynamic pull, the snap jaws will deform and pop off the conduit. Once one clip disengages, the rear support frame collapses instantly and the entire prop is flattened or rolls downfield.

### Failure Mode 3: Greenhouse Snap Clamp Peeling & Vinyl Flutter
* The vinyl banner is secured with 16 plastic greenhouse snap clamps (1" trade size) over 4" strips of double-sided mounting tape.
* At 30 mph, aerodynamic vortex shedding creates intense cyclic flutter and localized negative pressure spikes (suction) exceeding $3.5\text{ psf}$ along the top rail.
* This cyclic buffeting will fatigue the plastic clamps, snapping them off or peeling the vinyl away from the perimeter framing.

### Failure Mode 4: Operational & CBA Timed Field Entry Breakdown

#### CBA Competition Timing Rules (Rules 5.03, 5.06 & 4.03)
Under **CBA Rule 5.06**, the band has exactly **3 minutes and 15 seconds (195 seconds)** total from the moment the Timing & Penalties judge grants field entry permission until the introductory performance announcement concludes.
* By $t = 3:15$, ALL props and front ensemble equipment must be staged, and ALL non-student personnel (adult volunteers, parent pit crew) must be COMPLETELY off the performance field.
* Failure to clear the field by the conclusion of the announcement results in a mandatory **0.2-point penalty** under CBA Rule 4.03.

#### Baseline Deployment Model: 3-Person Crew "Pincer" Deployment
To evaluate field feasibility, the band utilizes a dedicated 3-person deployment crew per cart (or two 3-person crews for dual carts flanking Side 1 and Side 2):
1. **Person 1 (Cart Driver / Pusher):**
   Pushes the loaded transport cart from the rear entrance gate (CBA Rule 5.02) along the perimeter to the front sideline placement zone. Regulates pace, pauses momentarily at each yard-line mark, and once the final screen is pulled, **immediately rolls the empty cart across the front boundary into the sideline staging zone**. Person 1 clears the field first.
2. **Person 2 (Offloader / Opposite-End Deployer):**
   Walks alongside the cart. At each coordinate mark, slides a folded screen out and drops it flat on the turf in its rough position. Once the final screen is dropped, Person 2 moves to that far end of the line and immediately begins setup, working backward toward the middle.
3. **Person 3 (Trailing Deployer):**
   Trails behind the cart. As soon as Screen 1 is dropped, Person 3 begins final deployment: fine-positions on mark, swings rear triangle open, snaps the two clips (I) into Rail 3, and places ballast. Advances down the line toward the middle.
4. **Pincer Convergence:**
   Person 2 and Person 3 meet in the middle, complete the center screens, and step across the front sideline boundary together.

#### Extrapolated Timeline: Normal Operations (Tier 0–2 Ballast, 1–2 Bags/Prop)

| Time ($t$) | Operation Phase | Distance / Actions | Status vs. 3:15 Clock |
|:---:|---|---|---|
| **0:00** | **Entry Permission** | T&P Judge signals permission. Cart starts from rear gate. | $t = 0:00$ (195s remaining) |
| **0:00–1:05** (65s) | **Perimeter Ingress** | Pushes loaded cart ~220 ft around perimeter at ~3.4 ft/s. | $t = 1:05$ (130s remaining) |
| **1:05–1:45** (40s) | **Drop-and-Go Deposition** | Drops 4 screens across 51 ft span (~8–10s per drop). | $t = 1:45$ (90s remaining) |
| **1:45–1:55** (10s) | **Driver Egress** | Driver rolls empty cart off field over front boundary. | **Driver OFF FIELD at $t = 1:55$** |
| **1:10–2:15** (65s) | **Pincer Setup Convergence** | Trailing deployer & offloader meet in middle; 12–15s per screen. | All 4 screens deployed |
| **2:15–2:25** (10s) | **Crew Field Clearance** | Person 2 and Person 3 step across front sideline boundary. | **ALL OFF FIELD at $t = 2:25$** |
| **2:25–3:15** (50s) | **SAFETY MARGIN** | Entire crew clear; band awaits announcement finish. | **+50s BUFFER** (Zero penalty) |

*(Note: For Dual-Cart operations, Side 2 has an additional ~80 ft of perimeter transit around the back sideline, completing field clearance at $t \approx 2:45$, still providing a comfortable **+30s safety margin**).*

#### Why 30 mph Ballast Catastrophically Breaks the Timeline
If props are ballasted for 30 mph (requiring **9 to 11 sandbags = 140–165 lbs per screen**):
* **Weight Overload:** A single cart carrying 4 screens plus 30 mph ballast must haul **$4 \times 165 = 660\text{ lbs}$ of sandbags** in addition to the cart and frames (~850 lbs total rolling weight). This cannot be pushed across artificial turf at 3.4 ft/s.
* **Deposition Paralysis:** A single offloader cannot slide a 26-lb frame PLUS 140 lbs of sandbags off a cart in 10 seconds.
* **Setup Ballooning:** Moving, lifting, and placing 10 heavy sandbags across rear rail C and upper Rail 2 expands per-screen setup from **12–15 seconds to 50–60 seconds**.
* **Total Time Required:** Total setup time escalates to **over 4:30 to 5:00 minutes**, guaranteeing a **Rule 4.03 timing penalty** and stranding adult crew on the field when the band starts playing.

---

## 4. Engineering Comparison Table across Wind Regimes

All calculations below assume Colorado Springs 6,500 ft ASL baseline, solid vinyl ($C_d = 1.20$), $A = 30.5\text{ sq ft}$, dry weight $26.0\text{ lbs}$:

| Wind Speed / Operational Tier | Dynamic Pressure ($q$) | Lateral Drag ($F_w$) | Overturning Moment ($M_w$) | Rear Rail C Ballast (Fwd Tip FoS=1.5) | Rail 2 Ballast (Bwd Tip FoS=1.5) | Min Weight for Turf Anti-Slide | Structural & Operational Status |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|---|
| **Tier 0: Calm (0–8 mph)** | $0.13\text{ psf}$ | $4.7\text{ lbs}$ | $9.0\text{ ft-lb}$ | **0 lbs** (0 bags) | **0 lbs** (0 bags) | $26\text{ lbs}$ | Safe. Zero ballast needed. |
| **Tier 1: Normal (8–12 mph)** | $0.29\text{ psf}$ | $10.5\text{ lbs}$ | $20.3\text{ ft-lb}$ | **15 lbs** (1 bag) | **0 lbs** (0 bags) | $30\text{ lbs}$ | Safe. Standard field protocol. |
| **Tier 2: Advisory (12–18 mph)** | $0.65\text{ psf}$ | $23.6\text{ lbs}$ | $45.8\text{ ft-lb}$ | **30 lbs** (2 bags) | **15 lbs** (1 bag) | $67\text{ lbs}$ | Balanced. Attentive staging. |
| **Tier 3: High-Wind (18–22 mph)** | $0.96\text{ psf}$ | $35.3\text{ lbs}$ | $68.4\text{ ft-lb}$ | **45 lbs** (3 bags) | **30 lbs** (2 bags) | $101\text{ lbs}$ | **MAXIMUM SAFE LIMIT.** Total 75 lbs ballast. |
| **25 mph Peak Allowed Gust** | $1.24\text{ psf}$ | $45.5\text{ lbs}$ | $88.3\text{ ft-lb}$ | **54 lbs** (4 bags) | **39 lbs** (3 bags) | $130\text{ lbs}$ | Marginal. Extreme caution. |
| **30 mph Severe Wind** | **$1.79\text{ psf}$** | **$65.5\text{ lbs}$** | **$127.1\text{ ft-lb}$** | **79 lbs** (5–6 bags) | **67 lbs** (4–5 bags) | **$187\text{ lbs}$** | **CATASTROPHIC FAILURE.** Sliding, clip detachment, timing penalty. |

---

## 5. High-Wind Operational Protocol at 30 mph

When wind conditions approach or exceed 20 mph sustained or 25 mph peak gusts:

### 5.1 Staging Area Protocol (Trailer Lot)
* **Keep Props Folded Flat:** Keep all sideline screens folded flat in the equipment trailer or on moving blankets in the trailer staging area until ready to assemble for warm-up.
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
   Replace the friction snap-fit clips with through-bolted 3/4" EMT clevis brackets and push-button quick-release detent hitch pins capable of resisting $>200\text{ lbs}$ of shear/tensile load.
2. **Engineered Wind Relief Slits [ADOPTED AS STANDARD FLEET SPECIFICATION]:**
   Incorporate 6 engineered true semicircular slits ($8"\text{ wide} \times 4"\text{ drop}$, radius $R = 4"$) arranged in a $2 \times 3$ grid with $\varnothing 3/8"$ round punch-hole endpoints. Semicircular geometry allows fast and repeatable hand fabrication using a compass or circular guide. This drops the drag coefficient from $C_d = 1.20$ to $1.02$ (a 15.0% reduction in lateral drag and overturning moment) and eliminates vortex-shedding flutter, raising turf sliding resistance and lowering clip tensile forces across all operational tiers.
3. **Turf High-Friction Cleats:**
   Install textured high-durometer EPDM rubber foot pads or silicone gripping sleeves along the underside of ground rails B and C to increase the friction coefficient $\mu$ from $0.35$ to $\ge 0.65$, reducing the weight needed to prevent sliding.
4. **Perimeter Clamp Mechanical Screwing:**
   Install low-profile self-tapping screws through the greenhouse snap clamps into the conduit to prevent wind suction peeling.
