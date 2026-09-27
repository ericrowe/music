# Performance Stage Inter-Section Gap Bridge Analysis & Engineering Recommendations

**Subproject:** PCHSMB Performance Stages (`PCHSMB/_Stages/`)  
**Associated Show:** *2026 Continuum* (4 Stage Platforms, 8 Mobile Half-Pieces, 4 Mobile Staircases)  
**Author:** PCHSMB Prop & Engineering Crew  
**Date:** September 2026  
**Status:** TECHNICAL MEMORANDUM & DESIGN STUDY — REV 1.0  

---

## 1. Executive Summary & Problem Definition

The Pine Creek High School Marching Band (PCHSMB) field prop fleet includes **four (4) modular rolling performance stages**. Each complete stage platform is assembled on the competition field by docking two independent mobile half-units together:
1. **Front Half Unit (F):** Independent rolling cart on casters.
2. **Back Half Unit (B):** Independent rolling cart on casters.

During field assembly and staging, an **approximate 6.0-inch (nominal 152 mm) open gap** exists between the walking decks of the two halves.

```text
       FRONT HALF UNIT (F)                   BACK HALF UNIT (B)
+================================+   GAP   +================================+
|                                | <-----> |                                |
|       PLYWOOD WALKING DECK     |  ~6.0"  |      PLYWOOD WALKING DECK      |
|                                |         |                                |
+--------------------------------+         +--------------------------------+
  [Frame / Joists]                           [Frame / Joists]
      O                      O                   O                      O
    Caster                 Caster              Caster                 Caster
```

### 1.1 The Operational Hazard
Performers (wind players, battery percussion, soloists, and color guard members dancing or spinning rifles/sabres/flags) move dynamically across the stage surface during competitive performances.
- **Foot Penetration Risk:** A 6.0″ wide trench is wide enough for standard athletic/marching footwear (typical shoe length: 9.5″–12.5″; sole width: 3.5″–4.5″) to drop completely into the opening.
- **Injury Severity:** A performer stepping into an open 6″ void at speed faces acute risks of lateral ankle fractures, syndesmotic (high ankle) sprains, ACL/meniscus tears, or falling off the platform entirely.
- **The "False Floor" Vinyl Hazard:** The current show operations manual specifies a printed vinyl graphic cover with a velcro bridging flap spanning between the front and back units. **If an open 6″ trench exists beneath that vinyl flap, the vinyl creates a deceptive, unsupported membrane.** A performer stepping on the flap would suffer immediate punch-through with zero resistance.

### 1.2 User Design Concept Under Review
The proposed concept utilizes a **nominal 2x6 dimensional lumber board** with an attachment on top to prevent the board from falling through the gap:
- Dimensional lumber 2x6 (actual dimensions: $1.5\text{ in.} \text{ thick} \times 5.5\text{ in.} \text{ wide}$).
- Inserted into the ~6.0″ gap ($5.5\text{ in.}$ width leaves ~0.25″ lateral clearance per side).
- A wider top cap/flange attached to the top face of the 2x6 rests on the adjacent stage decks, suspending the 2x6 core.

This document evaluates the mechanical feasibility, structural capacity, and safety implications of this concept, identifies critical failure modes (specifically **trip hazards** and **chassis racking**), and delivers four actionable engineering designs.

---

## 2. Technical Evaluation of the 2x6 Core + Top Attachment Concept

### 2.1 Load Capacity of a 2x6 Over a 6-Inch Span
A standard 2x6 of Spruce-Pine-Fir (SPF) or Douglas Fir has exceptional structural capacity across a 6.0-inch span:
- **Design Point Load ($P$):** 250 lb performer + 50% dynamic impact factor = **375 lbf (1.67 kN)** point load concentrated over a 3″ × 3″ heel/toe strike area.
- **Span ($L$):** 6.0 inches (0.50 ft).
- **Section Modulus (Flat Orientation, $b = 5.5\text{ in.}$, $h = 1.5\text{ in.}$):**
  $$S = \frac{b \cdot h^2}{6} = \frac{5.5 \times 1.5^2}{6} = 2.0625\text{ in.}^3$$
- **Bending Moment ($M_{\max}$ for center point load):**
  $$M_{\max} = \frac{P \cdot L}{4} = \frac{375\text{ lbf} \times 6.0\text{ in.}}{4} = 562.5\text{ lbf}\cdot\text{in.}$$
- **Maximum Bending Stress ($\sigma$):**
  $$\sigma = \frac{M}{S} = \frac{562.5}{2.0625} \approx 273\text{ psi}$$
- **Allowable Fiber Stress ($F_b$ for No. 2 SPF / Doug Fir):** $F_b \approx 875\text{ to } 1,000\text{ psi}$.
- **Safety Factor:** $\text{SF} = \frac{875}{273} \approx \mathbf{3.2}$ in flat bending (and $\mathbf{> 12}$ if oriented on edge).
- **Deflection ($\Delta$):**
  $$I = \frac{b \cdot h^3}{12} = \frac{5.5 \times 1.5^3}{12} = 1.547\text{ in.}^4$$
  $$\Delta = \frac{P \cdot L^3}{48 \cdot E \cdot I} = \frac{375 \times 6.0^3}{48 \times (1.4 \times 10^6) \times 1.547} \approx \mathbf{0.00078\text{ in.}} \quad (\text{effectively zero})$$

**Structural Conclusion:** The 2x6 lumber core itself is physically indestructible under any realistic live performer load across a 6-inch span. Deflection is virtually unmeasurable.

---

### 2.2 Critical Failure Modes & Engineering Constraints

While the 2x6 core is structurally robust, the overall assembly introduces three critical hazards that must be engineered out:

#### 1. The Raised Lip / Trip Hazard (High Severity)
- If a wooden top plate (e.g., 1/2″ or 3/4″ plywood) is attached across the top of the 2x6 and rests on top of the stage decks, it creates an abrupt **1/2″ to 3/4″ vertical step** along the entire joint seam.
- **Marching Band & Dance Standard:** Any vertical lip exceeding $1/4\text{ in.} \ (6.4\text{ mm})$ is classified as a severe trip hazard under NFHS and athletic staging safety standards. Performers marching backward (roll step) will catch their heels; dancers making rapid leaps will roll their ankles.
- **Graphic Distortion:** The vinyl stage cover will form an unsightly raised "speed bump" that stretches and wears prematurely.

```text
HAZARDOUS OVER-DECK LIP:
                [3/4" Plywood Top Cap]
             +--------------------------+
             |         RAISED LIP       |  <--- 3/4" TRIP HAZARD!
+============+-------+          +-------+============+
| STAGE DECK |       |  2x6     |       | STAGE DECK |
| (Front)    |       |  CORE    |       | (Back)     |
+------------+       |          |       +------------+
```

#### 2. Cantilever Lip Tear-Out / Shear
- If the top plate extends 1.5″ over the edge of each deck, and a performer steps directly on that overhang, the downward force tries to pucker the top plate and pry the fasteners out of the 2x6 core.
- Screws driven from the top of the plate into the narrow face of the 2x6 can suffer fastener pull-through or split the wood if not through-bolted or heavily reinforced.

#### 3. Chassis Racking & Gap Expansion (Dynamic Drift)
- The two stage sections roll on heavy-duty swivel casters over compressible synthetic turf or grass.
- If the two stage sections are **not positively clamped together**, live vibration, performer steps, and turf undulations will cause the two carts to creep apart.
- If the gap expands from $6.0\text{ in.} \to 7.0\text{ in.}$, the 2x6 ($5.5\text{ in.}$ wide) will shift laterally; if it expands to $8.0\text{ in.}$, an unsupported bridge can slip completely off its ledger and drop into the void under load.

---

## 3. Four Architectural Recommendations

To resolve these failure modes, we present four design options ranging from flush integrated framing to low-profile drop-in bridges:

```text
+----------+--------------------------------------+--------------+-------------+---------------+
| Option   | Architecture                         | Deck Surface | Deploy Time | Frame Mod     |
+----------+--------------------------------------+--------------+-------------+---------------+
| Option 1 | Flush Drop-In T-Bridge w/ Ledgers   | 100% Flush   | 3–5 seconds | Low (Ledgers) |
| Option 2 | Hinged Flip-Deck Bridge              | 100% Flush   | 1–2 seconds | Moderate      |
| Option 3 | Low-Profile Beveled Aluminum Bridge  | 1/8" Beveled | 3–5 seconds | None          |
| Option 4 | Inter-Chassis Clamping & Draw Latch  | Standardized | Mandatory   | Hardware only |
+----------+--------------------------------------+--------------+-------------+---------------+
```

---

### Option 1: Flush Drop-In T-Bridge with Sub-Deck Ledgers (RECOMMENDED)

This design adapts the user's 2x6 concept to achieve a **100% flush, seamless walking surface** with zero trip hazard.

```text
RECOMMENDED FLUSH T-BRIDGE (OPTION 1):
             +--------------------------+
             | 3/4" Baltic Birch Deck   |  <--- COMPLETELY FLUSH WITH STAGE
+============+                          +============+
| STAGE DECK |=======+          +=======| STAGE DECK |
| (3/4" Ply) |       |  2x6     |       | (3/4" Ply) |
+------------+       |  CORE    |       +------------+
| STAGE      |       | (5.5" W) |       | STAGE      |
| JOIST      | [L-1] |          | [L-2] | JOIST      |
|            |_______|          |_______|            |
+------------+                          +------------+
```

#### How It Works:
1. **Sub-Deck Ledgers (`[L-1]` and `[L-2]`):** Fasten a continuous 2x2 lumber cleat (or $1.5\text{ in.} \times 1.5\text{ in.} \times 1/8\text{ in.}$ aluminum angle) along the inside face of the perimeter framing of both stage halves, recessed exactly **$2.25\text{ in.}$ below the top of the stage deck** (allowing for $0.75\text{ in.}$ top deck + $1.5\text{ in.}$ 2x6 thickness).
2. **The T-Bridge Assembly:**
   - **Core:** Standard 2x6 Doug Fir/SPF ($1.5\text{ in.} \times 5.5\text{ in.}$).
   - **Cap Plate:** 3/4″ exterior plywood or Baltic birch cut to the exact gap width minus $1/8\text{ in.}$ clearance ($5.875\text{ in.}$ wide).
   - **Wide Support Flanges:** Two $1.5\text{ in.} \times 1.5\text{ in.}$ bearing ears or a bottom ledger cleat on the 2x6 that rests on the stage frame ledgers.
   - Alternatively: The 2x6 itself rests directly on the recessed ledgers `[L-1]` and `[L-2]`, and a 3/4″ plywood cap glued/screwed to its top face sits **perfectly flush** with the adjacent stage decks!
3. **Alignment Pins:** Two 3/8″ bullet-nosed dowel pins on the bottom of the 2x6 drop into matching holes in the ledgers, preventing any lateral or longitudinal sliding.

#### Key Benefits:
- **Zero Lip:** Absolutely flat walking surface. Performers cannot tell where the seam is.
- **Full Load Bearing:** Load transfers directly into the perimeter frame joists through solid wood-on-wood bearing.
- **Rapid Installation:** Handlers simply drop the bridge into the slot; alignment pins ensure it seats instantly.

---

### Option 2: Hinged Flip-Deck Bridge (Fastest Field Ingress)

Designed specifically for the strict **90-second to 2-minute CBA field setup window**, where carrying loose bridging boards onto the field creates logistical friction.

```text
HINGED FLIP-DECK BRIDGE (OPTION 2):
              Heavy-Duty Piano Hinge
                    [ O ]
+=====================v======+-----------------------+
|                            | 3/4" Plywood Bridge   |
| STAGE DECK (Front Half)    | Flips 180 deg on Field|
+----------------------------+                       |
| FRONT CHASSIS JOIST        |                       |
+----------------------------+                       |
                                                     |
                                   GAP (~6.0")       v  (Drops onto Ledger)
                                            +--------+============+
                                            | LEDGER | STAGE DECK |
                                            | [L-2]  | (Back Half)|
                                            +--------+------------+
                                                     | BACK JOIST |
                                                     +------------+
```

#### How It Works:
1. A **6.0-inch wide strip of 3/4″ structural plywood**, reinforced on its underside with structural stiffener blocks, is permanently connected to the Front Half unit using a **continuous heavy-duty stainless steel piano hinge**.
2. **In Transit:** The bridge flap folds back flat against the Front Half deck. The vinyl covering flap folds back over it and is pinned in place.
3. **On-Field Docking:**
   - Front and Back stage halves are rolled into position and locked together.
   - Handlers unpin the flap and simply **flip the bridge over across the gap**.
   - The free edge lands securely on a recessed $2\times 2$ ledger cleat mounted to the Back Half frame.
   - The vinyl graphic flap is smoothed down and velcroed.

#### Key Benefits:
- **Zero Loose Parts:** The bridge cannot be dropped, lost, forgotten in the truck, or loaded onto the wrong stage.
- **1-Second Deployment:** Flip down, step on it, done.
- **Permanent Alignment:** The continuous hinge guarantees precision alignment along the entire seam.

---

### Option 3: Low-Profile Beveled 6061-T6 Aluminum Bridge (Non-Invasive)

If modifying the stage under-framing with recessed ledgers is not practical or time allows only a surface-mount solution, the 2x6 core can be combined with a **heavy-duty aluminum threshold plate**.

```text
LOW-PROFILE BEVELED THRESHOLD (OPTION 3):
           1/8" (0.125") 6061-T6 Aluminum Plate (8.5" Wide)
           Beveled 15 deg Edges (< 1/4" ADA Compliant Threshold)
           +-----------------------------------------------+
     15 deg|                                               |15 deg
    +------+---------------+               +---------------+------+
    |                      |   2x6 CORE    |                      |
+===+======================+   (5.5" W)    +======================+===+
| STAGE DECK (Front)       |               | STAGE DECK (Back)        |
+--------------------------+               +--------------------------+
```

#### How It Works:
1. **Core:** Nominal 2x6 Doug Fir/SPF ($1.5\text{ in.} \times 5.5\text{ in.}$).
2. **Top Plate:** **$1/8\text{ in.} \ (3.18\text{ mm})$ thick 6061-T6 aluminum plate**, 8.50″ wide by the length of the stage seam.
3. **Beveled Edges:** The longitudinal outer edges of the aluminum plate are milled or ground to a **$15^\circ$ bevel**, reducing the exposed edge thickness to under $1/16\text{ in.}$.
4. **Fastening:** The aluminum plate is fastened to the top face of the 2x6 with countersunk 1/4-20 flathead machine screws driven into steel threaded inserts (or through-bolts with counterbored nuts) spaced every 12 inches on center.

#### Why This Works Where Plywood Fails:
- $1/8\text{ in.}$ thickness with a $15^\circ$ beveled ramp meets ADA and commercial architectural standards for zero-trip threshold transitions.
- High-yield 6061-T6 aluminum ($S_y \approx 40,000\text{ psi}$) will not crush, splinter, or curl under point loads.
- The 2x6 core absorbs 100% of the vertical bending moment across the 6.0″ gap, preventing the aluminum plate from sagging or dishing.

---

### Option 4: Mandatory Inter-Chassis Locking Hardware

Regardless of which bridging option (1, 2, or 3) is selected, **the bridge MUST NOT be relied upon to hold the two stage carts together.** If the carts drift apart on turf, the bridge will fail.

The two stage chassis **must be locked together mechanically** using dedicated stage connection hardware:

```text
MANDATORY CHASSIS LOCKING:
+--------------------------+             +--------------------------+
| FRONT STAGE CHASSIS      |             | BACK STAGE CHASSIS       |
|                          |  [LATCH]    |                          |
|  [ Heavy-Duty Over-Center|====\        |  [ Heavy-Duty Strike     |
|    Draw Latch / Toggle ] |     \=======>    Plate / Catch ]       |
+--------------------------+             +--------------------------+
```

#### Recommended Hardware:
1. **Heavy-Duty Over-Center Draw Latches (Southco or Carr Lane):**
   - 2 latches per stage joint (one on the left frame rail, one on the right frame rail).
   - Fastened directly to the 2x4/steel chassis framing below deck level.
   - Provides $300+\text{ lbf}$ of positive draw tension, pulling the two stage halves tight against rubber bumper stops that enforce the exact 6.0″ gap.
2. **Rotary Stage Coffin Locks (Alternative):**
   - Standard theatrical stage deck connectors recessed into the framing.
   - Actuated from above through a 3/8″ hole using an 8 mm hex key.
   - Locked with a half-turn, pulling the units together with over 800 lbs of clamping force.

---

## 4. Operational Integration with *Continuum 2026* Show Manual

The stage gap bridge directly affects **Job Group C (Performance Stage Crew)** in [`Continuum_2026_Prop_Operations_Guide.typ`](file:///Volumes/T9/Sync/Working/Shop/Projects/__Music/PCHSMB/2026%20Continuum/Continuum_2026_Prop_Operations_Guide.typ):

### 4.1 Update to Step 4 & 5 of Job C.2 (Student Stage Handlers)
Current procedure:
> *4. Back Piece Alignment & Caster Lock...*  
> *5. Seam Closure (Vinyl Flap & Velcro)...*

**Revised Operational Sequence (with Gap Bridge):**
1. **Step 4 (Alignment & Chassis Clamping):** Handlers push Back Half tight against Front Half, engage caster wheel locks, and **snap both over-center draw latches shut** on the outer frame rails.
2. **Step 4.1 (Bridge Deployment):**
   - *If Option 1 (Drop-In T-Bridge):* Handler lifts the bridge board from its transport cradle on the Back Half, drops it into the center slot, and steps down to seat the alignment pins.
   - *If Option 2 (Hinged Flip-Deck):* Handler flips the hinged deck section over 180° onto the receiving ledger.
3. **Step 5 (Seam Closure):** Pull the vinyl graphic flap across the bridged gap and press down firmly along the heavy-duty velcro strip.

---

## 5. Bill of Materials & Cost Comparison (Fleet Total: 6 Gaps @ 82.0″ Length)

**Field Geometry Specifications:**
* **Gap Width:** Nominal $6.0\text{ in.}$
* **Gap Length:** Exactly **$82.0\text{ in.}$** ($6\text{ ft } 10\text{ in.}$)
* **Fleet Quantity:** **Six (6) total gaps** across the stage fleet ($492\text{ in.} = 41.0\text{ linear ft}$).

### Sheet Yield Analysis for 6 Strips (8.5″ × 82.0″):
* **Standard 48″ × 96″ Sheet:** Yields only **5 strips** ($48 / 8.5 = 5.64$). Requires **two (2) full sheets** to get 6 strips, resulting in significant scrap.
* **Standard 60″ × 96″ (5′ × 8′) Sheet:** Yields **7 strips** ($60 / 8.5 = 7.05$). **A single 60″ × 96″ sheet yields all 6 required strips plus 1 spare!**
* **3/4″ Plywood Sheet (48″ × 96″):** Yields **8 strips** ($48 / 6.0 = 8.0$). **A single 48″ × 96″ plywood sheet yields all 6 flush cap strips plus 2 spares!**

| Option | Components & Hardware Required | Unit Cost / Gap | Fleet Total (6 Gaps) | Structural & Safety Trade-offs |
|---|---|:---:|:---:|---|
| **Option 1: Flush Drop-In T-Bridge (Recommended)** | 6x 2x6 x 8' SPF lumber ($45), 1x 4x8 sheet 3/4" Baltic birch/ACX ($50), 6x 2x2 x 16' ledger cleats ($25), 12x draw latches ($60), hardware ($20) | **~$33.33** | **~$200.00** | **Best safety.** 100% flush walking deck, zero trip hazard, rock-solid wood bearing. All 6 caps cut from 1 plywood sheet. |
| **Option 2: Hinged Flip-Deck Bridge** | 1x 4x8 sheet 3/4" Baltic birch ($50), 6x 82" stainless piano hinges ($150), 6x 2x2 ledgers ($25), 12x draw latches ($60) | **~$47.50** | **~$285.00** | **Fastest setup.** Zero loose parts; deployed in 1 second; requires hinge mounting. |
| **Option 3: Low-Profile 6061-T6 Aluminum Bridge** | 1x 60" x 96" x 0.125" 6061-T6 sheet sheared to 8.5" ($370), 6x 2x6 x 8' lumber ($45), 12x draw latches ($60), countersunk fasteners ($30) | **~$84.17** | **~$505.00** | **Zero frame mods.** Drops on top of existing decks; 1/8" beveled threshold lip. Requires 60" wide sheet to avoid 2-sheet waste. |

---

## 6. Actionable Recommendations & Immediate Next Steps

1. **Adopt Option 1 (Flush Drop-In T-Bridge with Recessed Ledgers) as Primary Architecture:**
   - Provides the highest performer safety factor.
   - Eliminates the raised trip hazard that would otherwise endanger dancers and backwards-marching brass.
   - Keeps the top vinyl graphic completely flat.
2. **Install Inter-Chassis Over-Center Draw Latches:**
   - Install 2 over-center draw latches per stage platform immediately to lock the two halves at an exact, repeatable gap distance.
3. **Fabricate Prototype for Stage Platform #1:**
   - Test fit a 2x6 core with 3/4″ Baltic birch cap and ledger cleats on Stage #1.
   - Perform live performer drop and stomp testing before outfitting Stages #2, #3, and #4.
4. **Update Continuum Job Card C.2:**
   - Formalize the 3-step sequence: *Dock & Latch $\to$ Seat Bridge $\to$ Velcro Vinyl Flap*.

---
*Document controlled under PCHSMB Engineering Guidelines.*  
*Maintained in `PCHSMB/_Stages/docs/references/STAGE_GAP_BRIDGE_ANALYSIS.md`.*
