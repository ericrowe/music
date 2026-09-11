# Sideline Screen / Duck Blind Technical Specification

## 1. Product Identity & Purpose

- **Name:** Sideline Screen / Duck Blind
- **Application:** Pine Creek High School Marching Band (PCHSMB) field prop
- **Primary Function:** Conceals color guard equipment and provides private area for costume/equipment changes during field show performances.
- **Form Factor:** Nominal 4 ft x 8 ft face; folding frame that folds flat for transport/storage and unfolds to self-supporting triangular geometry for field deployment.
- **Folded Envelope & Internal Nesting:** Engineered with complete internal nesting where the rear frame arms (D), rear cross rail (C), and bottom support arms (E) collapse coplanar inside the perimeter framing. Maximum folded thickness is **no more than 2.0 inches** (governed by the 3D-printed hinged arm clip (I) profile; conduit OD is 0.922 in.).
- **Fleet Production Quantity:** **16 screens total** deployed on the performance field:
  - **Side 1 (Left):** 8 screens positioned along the front sideline flanking the front ensemble.
  - **Side 2 (Right):** 8 screens positioned along the front sideline flanking the front ensemble.
  - **Transport Logistics:** 2 dedicated transport carts (Component 2), each carrying 8 folded screens. Because each screen is $\le 2.0\text{ in.}$ thick, 8 screens consume only **16.0 inches** of the 44.5-inch cart bed width, leaving 28.5 inches of deck space for ballast sandbag staging, guide rails, and auxiliary prop storage.

---

## 2. Materials & Components

| ID | Qty | Description | Specification / Material | Source / Part Reference |
|---|---|---|---|---|
| **A** | 4 | Long main-frame rails | 92.5 in. length, 3/4-in. EMT conduit | Home Depot (SKU 0550110000) |
| **B** | 2 | Main-frame end rails | 44.5 in. length, 3/4-in. EMT conduit | Home Depot (SKU 0550110000) |
| **C** | 1 | Rear cross rail | 86.5 in. length, 3/4-in. EMT conduit | Home Depot (SKU 0550110000) |
| **D** | 2 | Rear-frame arms | 37.0 in. length, 3/4-in. EMT conduit | Home Depot (SKU 0550110000) |
| **E** | 2 | Bottom support arms | 27.5 in. length, 3/4-in. EMT conduit | Home Depot (SKU 0550110000) |
| **F** | 6 | 3-way corner brackets | 3/4-in. EMT clamp bracket | Amazon (B0D5BBKCKG) |
| **G** | 8 | T-brackets | 3/4-in. EMT clamp bracket (4 fixed, 4 hinge pivots) | Amazon (B0CKQW11SJ) |
| **H** | 6 | Corner plugs | 3D printed, black ASA | `Corner Plug.FCStd` / `Corner Plug-Part.step` |
| **I** | 2 | Hinged arm clips | 3D printed, black ASA | `Hinged Arm Clip.FCStd` / `Hinged Arm Clip-Part001.step` |
| **J** | 36 | Self-drilling screws | #8 x 1/2-in. external-hex flange head | Home Depot (Teks 21308) |
| **-** | 1 | Face covering | Heavyweight outdoor scrim vinyl banner (dimensions TBD: visual image, bleed wrap, overall cut size; flush straight cut, no hems/grommets) | Custom printed |
| **-** | 1 roll | Double-sided tape | 1-in. heavy-duty mounting tape (16x ~4-in. strips per screen: 5 per long rail, 3 per short rail; TBD) | Amazon (B07BBL4JXJ) |
| **-** | 16 | Greenhouse snap clamps | 1-in. pipe clamp clips (sized for 3/4-in. EMT with wrapped vinyl) | Amazon (B0BJJYKZ5L) |
| **-** | 2-3 | Moving blankets | Clean protective floor pads for scratch-free vinyl staging | Shop stock |

### Fleet Totals (Full Production Run: 16 Screens + 2 Transport Carts)

| Item / Material | Quantity Required | Notes / Specifications |
|---|:---:|---|
| **10-ft 3/4-in. EMT Conduit** | **112 sticks** | 7 sticks per screen × 16 screens (Home Depot SKU 0550110000) |
| **3-Way Corner Brackets (F)** | **96 pcs** | 6 per screen × 16 screens (Amazon B0D5BBKCKG) |
| **3/4-in. T-Brackets (G)** | **128 pcs** | 8 per screen × 16 screens (Amazon B0CKQW11SJ: 64 fixed, 64 pivots) |
| **3D Corner Plugs (H)** | **96 pcs** | 6 per screen × 16 screens (Black ASA) |
| **3D Hinged Arm Clips (I)** | **32 pcs** | 2 per screen × 16 screens (Black ASA) |
| **3D Weight Clips** | **32–64 pcs** | 2 to 4 per screen for hanging ballast (Black ASA) |
| **Self-Drilling Screws (J)** | **576 pcs** | 36 per screen × 16 screens (#8 x 1/2-in. hex flange) |
| **1-in. Greenhouse Snap Clamps** | **256 pcs** | 16 per screen × 16 screens (Amazon B0BJJYKZ5L) |
| **1-in. Double-Sided Tape** | **3–4 rolls** | 256 strips of 4-in. tape (~85 linear feet) |
| **Custom Vinyl Banners** | **16 banners** | 4 ft × 8 ft nominal custom printed graphic |
| **Transport Carts** | **2 carts** | 1 cart per side (carries 8 folded screens + staged ballast) |

---

## 3. Conduit Cutting Schedule (7 Sticks of 10-ft 3/4-in EMT)

| Stick # | Cut Elements | Nominal Remainder / Offcut |
|---|---|---|
| 1 | 1 x 92.5 in. (A) | ~27.5 in. spare |
| 2 | 1 x 92.5 in. (A) | ~27.5 in. spare |
| 3 | 1 x 92.5 in. (A) | ~27.5 in. spare |
| 4 | 1 x 92.5 in. (A) | ~27.5 in. spare |
| 5 | 1 x 86.5 in. (C) + 1 x 27.5 in. (E) | 6.0 in. less kerf loss |
| 6 | 2 x 44.5 in. (B) + 1 x 27.5 in. (E) | 3.5 in. less kerf loss |
| 7 | 2 x 37.0 in. (D) | 46.0 in. less kerf loss |

---

## 4. Assembly & Fastening Rules

- **Total Screw Count:** Exactly 36 screws (J) per completed screen:
  - Stage 1 (Main outer rectangle): 8 screws (2 per corner bracket F into A & B).
  - Stage 2 (Inner A rails): 8 screws (1 per G connector interface from rear).
  - Stage 3 (Rear support frame): 8 screws (4 in corner brackets F, 4 joining D to G).
  - Stage 4 (Bottom support arms & clips): 12 screws (4 joining E to G, 8 securing I clips to lower A rail).
- **Hinge Interfaces (Zero Screws):**
  - The four upper G T-brackets rotate freely around the upper inner A rail.
  - The two rear G T-brackets rotate freely around the C rear cross rail.
  - Never install screws into pivoting interfaces.
- **Vinyl Installation Protocol:**
  - **Surface Protection:** Staged face down on clean moving blankets; zero debris contact.
  - **Bleed Centering:** Frame centered over vinyl with equal bleed margin on all four edges.
  - **Surface Preparation (Optional):** Conduit degreasing is optional; the tape is aggressive, and a lighter bond to tubing is advantageous for easier seasonal removal.
  - **Tape Schedule:** 16x 4-in. strips of 1-in. heavy-duty double-sided tape applied to rear of perimeter EMT tubing (5 per long rail, 3 per short rail; quantities provisional TBD).
  - **Tensioning Sequence:** First long side wrapped to tape; opposing long side pulled taut and wrapped. Opposing short ends pulled outward simultaneously by two operators and wrapped.
  - **Mechanical Retention:** 16x 1-in. greenhouse snap clamps installed over vinyl directly aligned with each tape strip location (5 per long rail, 3 per short rail). Note: While 3/4-in. trade size EMT is used, its actual OD is ~0.922 in. (nearly 1 in.); wrapped with vinyl and tape, 1-in. greenhouse snap clamps provide a snug, secure mechanical fit. Ensure zero interference with hinges and clips.
  - **Vinyl Removal Temperature Requirement:** NEVER attempt vinyl or tape removal unless ambient temperature is above 80°F (27°C). Peeling vinyl at lower temperatures causes material tearing and permanent graphic damage.
  - **Seasonal Teardown Timing & Solar Advantage:** It is usually much easier to leave the vinyl on the frames over the winter and wait until summer band camp of the following season before attempting removal. The warmer outside, the better—leaving the frames in direct sunlight for just a few minutes naturally warms the conduit and softens the adhesive, allowing the tape and vinyl to release cleanly and effortlessly with minimal pull resistance.

---

## 5. Aerodynamic Wind Loading, Ballasting & 2026 CBA Competition Rules

- **Aerodynamic & Geometric Properties:**
  - **Nominal Dimensions:** 4 ft nominal height × 8 ft nominal width.
  - **Actual Vinyl Sail Area:** $A = 30.5\text{ sq ft}$ (3.875 ft H × 7.875 ft W).
  - **Center of Pressure Height:** $h_{cp} = 1.94\text{ ft}$ (at centroid of vertical face).
  - **Triangular Base Stance:** $L_{base} = 2.29\text{ ft}$ (27.5 in. between front bottom rail and rear rail C).
  - **Atmospheric Scaling (Colorado Springs):** Altitude 6,500 ft ASL, air density $\rho = 0.0595\text{ lb/cu ft}$ (~23% reduction vs sea level $\rho = 0.0765\text{ lb/cu ft}$).
  - **Dry Frame Weight:** 26.0 lbs (without vinyl/ballast).
- **Critical Forward-Tipping Asymmetry:**
  - **Backward Tipping (Front Wind):** Pivots about rear rail C. Front frame has full 2.29 ft lever arm ($M_{rest, bwd} = 50.4\text{ ft-lb}$). Tips at 18.9 mph unballasted.
  - **Forward Tipping (Rear Wind - Critical Mode):** Pivots about front bottom rail. Heavy front frame sits directly on pivot with zero lever arm; rear frame provides only 9.2 ft-lb of restoring moment ($M_{rest, fwd} = 9.2\text{ ft-lb}$). Tips at just 8.1 mph unballasted!
- **Ballast Leverage Optimization (Rear Rail C vs Rail 2 Suspension):**
  - **Primary Ballast (Placed over Rear Ground Rail C):** Acts at the maximum possible restoring lever arm ($d = 2.29\text{ ft}$). Two 15-lb bags (30 lbs) add 68.7 ft-lb of restoring moment, boosting forward tipping resistance to 23.5 mph. Imposes ZERO mechanical stress on 3D-printed clips (I) as weight rests directly on turf.
  - **Supplemental Ballast (Suspended from Upper Inner Rail 2):** Has near-zero lever arm to front rail (0 ft-lb against forward tipping). However, provides full 2.29 ft lever arm against backward tipping (34.4 ft-lb per bag). Strictly used for Tier 2/3 bidirectional wind balancing.
- **Standardized Tiered Ballasting Schedule:**
  - **Tier 0 (Calm, 0–8 mph, gusts ≤10 mph):** 0 bags (dry wt 26 lbs). Safe to 8.1 mph fwd / 18.9 mph bwd. Upgrade to Tier 1 if wind >8 mph.
  - **Tier 1 (Normal, 8–12 mph):** 1x to 2x 15-lb bags placed over rear ground rail C (total wt 41–56 lbs). Safe to 17.6–23.5 mph fwd / 18.9 mph bwd. Zero clip stress.
  - **Tier 2 (Advisory, 12–18 mph):** 2x 15-lb bags over rear rail C + 1x 15-lb bag suspended from Rail 2 (total wt 71 lbs). Balanced stability: 23.7 mph fwd / 24.5 mph bwd.
  - **Tier 3 (High-Wind, 18–22 mph):** 2x 15-lb bags over rear rail C + 2x 15-lb bags suspended from Rail 2 (total wt 86 lbs). Safe to 24.5–28.4 mph max gust. Turf contact pressure ~0.25 psi (zero turf compaction).
  - **Tier 4 (Safety Abort, >20 mph sustained or >25 mph peak gusts):** STRICT NO-GO. Disengage clips (I), collapse rear support frame, and lay screen flat on turf.
- **Severe Wind Feasibility Analysis (30 mph Limits):** For detailed engineering calculations and failure mode evaluations regarding extreme wind regimes, see [30 mph Wind Loading & Ballasting Feasibility Analysis](WIND_LOADING_30MPH_ANALYSIS.md). Ballasting for 30 mph on the field is prohibited due to lateral sliding drift on turf (requires >161 lbs ballast), tensile detachment of 3D-printed snap clips (I) under 153 lbs pull load, and logistical breakdown of the 3-person crew deployment timeline under CBA Rule 5.06 (3:15 clock).
- **Field Deployment Crew Architecture & Pre-Set Receiver Protocol (16 Screens Total, 8 Per Side):**
  - **Fleet & Crew Sizing:** Total fleet consists of **16 screens** deployed across two 8-screen lines flanking the front ensemble. Transported on **2 dedicated carts** (8 screens per cart). Operated by **2 adult cart pushers** (1 per cart), **2 student unloaders** (1 per cart), and **16 pre-set student performers/receivers** (8 per side, 1 per screen).
  - **Front Sideline Placement Zones:**
    - **Side 1 (Left / Stage Right):** 8 screens spanning ~64 ft along the front sideline (approx. 20-yd to 41-yd line flanking left of pit).
    - **Side 2 (Right / Stage Left):** 8 screens spanning ~64 ft along the front sideline (approx. 59-yd to 80-yd line flanking right of pit).
  - **Continuous Deployment Choreography:**
    - **Asymmetric Backfield Staging:** Carts pre-stage on the back sideline at the yard line closest to the entry gate on their side (typically Back 20 on gate side, Back 40 on far side) to eliminate traffic bunching.
    - **Transit & Directional Rolling:** Carts transit along perimeter lanes and roll along the front sideline *away from the stadium exit chute* at ~6–8s per screen, finishing at the opposite side so carts are positioned for egress.
    - **Pre-Set Student Receivers:** Student performers are already in position at their assigned yard marks. As the cart passes, unloader drops the folded screen flat on turf with ballast; receiver immediately unfolds the rear triangle, seats arm clips (I) into Rail 3, latches adjacent screens, and places ballast.
    - **Parallel Setup & Cart Staging:** All 8 screens per side are latched and ballasted concurrently in ~15–18s. Carts exit the front sideline and park in front staging areas ready for immediate post-show egress.
  - **Field Egress Protocol (Zero-Doubling-Back Ballast Sweep):**
    - **Final Chord Collapse:** At show conclusion, 16 student performers immediately disengage clips, collapse screens flat, remove ballast bags, and place them carefully on the turf without dropping or throwing.
    - **Hand-Carry Sprint:** Pairs of students hand-carry collapsed screens (13 lbs/student) directly off the field to the stadium exit gate without waiting for carts (~35–45s).
    - **Zero-Doubling-Back Ballast Sweep:** Cart pushers enter from the far end (away from exit gate) and sweep along the front sideline toward the exit gate, rolling ballast into carts without backtracking.
    - **Clock Stop & Off-Field Reload:** Carts cross the stadium exit boundary to stop the official CBA 2:00 egress clock; full secure reload of screens onto carts occurs off-clock in the parking/warmup zone.
  - **Operational Field Timeline vs. CBA Rule 5.06 (3:15 Clock) & Rule 8.05 (2:00 Egress):**
    - Perimeter Ingress & Continuous Delivery: ~1:15–1:35.
    - Concurrent Pre-Set Receiver Latching & Ballasting: ~15–20s.
    - Total Deployment Elapsed Time: **~2:14 (134s)**, banking a safety buffer of **+61 seconds** before the 3:15 announcement ends (zero adult field-presence penalties).
    - Post-Show Egress: Hand-carry sprint clears screens in **~45s**; directional ballast sweep clears field in **~1:15–1:30**, banking **+30 to +45s** before the 2:00 egress penalty clock expires.
- **2026 CBA Marching Band Competition Rules Compliance:**
  - **Rule 5.02 (Mandatory Rear Entrance for Props):** CRITICAL MANDATE — All props must enter from the back sideline or rear end zone gates (above goal posts). Never cross directly across front boundary (reserved for pit equipment). Handlers transit around perimeter to front sideline coordinates.
  - **Rule 5.03 & 5.06 (Entry Permission & Timing):** Pre-stage in rear half of end zone up to goal line. Never enter field before T&P judge signals official permission. Total setup and adult clearance window is 3 minutes 15 seconds.
  - **Rule 4.03 & 5.06 (Field Clearance Before Performance):** All adult volunteers assisting props must be COMPLETELY CLEAR of field before introductory announcement ends (3:15 after entry permission; 0.2 pt penalty per occurrence).
  - **Rule 4.03 (Re-Entry Prohibition):** Adults strictly prohibited from entering/re-entering field during performance (0.2 pt penalty per occurrence).
  - **Rule 4.02(c) (Medical Emergency Assistance Exception):** NO PENALTY. Any band member ill or injured may be assisted from the field by adult volunteers, parents, or staff without penalty.
  - **Rule 4.02(a) (High-Wind Prop Restraint Exception):** In high winds when props are in danger of falling over, adults may enter performance field solely to secure props (never move props as choreography).
  - **Rule 8.05 (Continuous Egress & Double-Bagging):** Continuous movement off field to trailer lot required; never de-ballast or park carts at stadium exit chutes. All sandbags MUST be double-bagged with intact plastic inner liners.
  - **Rule 8.07 & 8.08 (Wheels & Height):** Pneumatic-like turf-compatible wheels required on carts; 12-foot rigid height limit strictly observed (screen is 4 ft deployed).
  - **Rule 9.07 (Field Pass Wristbands):** Maximum 25 wristbands per band; separate colors for Prelims vs Finals.

---

## 6. Estimated Fabrication Cost Breakdown

### A. Per Sideline Screen / Duck Blind (Excl. Vinyl)

| Item / Category | Description | Est. Cost |
|---|---|:---:|
| **3/4-in. EMT Conduit** | 7 sticks of 10-ft EMT (Home Depot SKU 0550110000) | $40.50 |
| **Corner Brackets (F)** | 6x 3-way EMT corner clamp brackets (Amazon B0D5BBKCKG) | $27.00 |
| **T-Brackets (G)** | 8x 3/4-in. EMT T-brackets (Amazon B0CKQW11SJ) | $23.00 |
| **Fasteners (J)** | 36x #8 x 1/2-in. hex flange self-drilling screws | $4.00 |
| **3D-Printed Hardware** | 6x Plugs H, 2x Clips I, 2x Weight Clips in Black ASA | $10.00 |
| **TOTAL PER SCREEN** | | **~$105.00** |

*Optional Rule 8.05 Ballast Pack: 2x 15-lb double-bagged sandbags + suspension hardware: +$18.00 per screen.*  
*Optional Vinyl Mounting Pack: 16x 1" greenhouse clamps (Amazon B0BJJYKZ5L) + 1 roll 1" heavy-duty tape (Amazon B07BBL4JXJ): ~$20.00 per screen (custom vinyl banner quoted separately).*

### B. Sideline Screen Transport Cart (Component 2 Estimate)

| Item / Category | Description | Est. Cost |
|---|---|:---:|
| **Rolling Base Chassis** | Backdrop-spec 2x4 framing, 1/2" plywood deck, 4x heavy-duty casters w/ brakes, paint | $155.00 |
| **Side Guide Rails** | Vertical framing / conduit dividers to hold screens upright | $35.00 |
| **Front & Rear Retention Gates** | Hinged gate framing, strap/barrel hinges, and 3D-printed latches | $30.00 |
| **TOTAL PER TRANSPORT CART** | | **~$220.00** |
