# Sideline Screen / Duck Blind Technical Specification

## 1. Product Identity & Purpose

- **Name:** Sideline Screen / Duck Blind
- **Application:** Pine Creek High School Marching Band (PCHSMB) field prop
- **Primary Function:** Conceals color guard equipment and provides private area for costume/equipment changes during field show performances.
- **Form Factor:** Nominal 4 ft x 8 ft face; folding frame that folds flat for transport/storage and unfolds to self-supporting triangular geometry for field deployment.

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
- **Field Deployment Crew Architecture & Pincer Deployment Protocol:**
  - **Crew Size:** Minimum 3-person crew per cart (single cart = 3 handlers; dual carts flanking Side 1 and Side 2 = 2x 3-person crews, 6 handlers total).
  - **Role 1 (Cart Driver / Pusher):** Pushes loaded cart from rear entrance gate (Rule 5.02) along perimeter to front sideline. Regulates pace, pauses momentarily at yard-line marks, and once the final screen is pulled, immediately rolls empty cart off the field over the front boundary into the sideline staging zone. Driver clears the field first (at ~1:55).
  - **Role 2 (Offloader / Opposite-End Deployer):** Walks alongside cart, pulls folded screens, and drops them flat on turf at rough coordinate marks. Once the final screen is dropped, moves to that far end of the line and deploys inward (swings triangle, snaps clips into Rail 3, sets ballast).
  - **Role 3 (Trailing Deployer):** Follows behind cart. Begins final deployment on Screen 1 as soon as it is dropped, advancing down the line toward the middle.
  - **Pincer Convergence & Egress:** Handlers 2 and 3 meet in the middle to complete center screens, then step across the front sideline boundary together (~2:15 to 2:25 total elapsed time).
  - **Extrapolated Field Timeline vs. CBA Rule 5.06 (3:15 Clock):**
    - Perimeter Ingress (~200–240 ft @ ~3.4 ft/s): 60–70s
    - Drop-and-Go Deposition (4–6 screens along 51 ft span): 35–45s
    - Pincer Setup Convergence (12–15s per screen): 30–40s
    - Driver Cart Egress & Crew Field Clearance: 10s
    - **Total Elapsed Time:** **~2:15 to 2:25** (Single Cart) / **~2:30 to 2:45** (Dual Carts, accounting for +80 ft far-side transit).
    - **Safety Margin:** **+30 to +50 seconds** of safety buffer before the introductory announcement ends (3:15), ensuring zero Rule 4.03 timing penalties.
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
