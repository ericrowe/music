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
  - **Transport Logistics:** Two-Person Direct Carry. Because screens are deployed fully assembled directly by student pairs (16 pairs, 2 students per screen), no rolling transport carts are fabricated or required on the field.

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

### Fleet Totals (Full Production Run: 16 Screens Total)

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
  - **Standard Engineered Wind Relief Slits Specification:**
    - **Fleet Mandate:** All 16 sideline screens incorporate 6 engineered true semicircular wind relief flaps cut directly into the scrim vinyl face.
    - **Flap Geometry:** True semicircle of constant radius $R = 4.0\text{ in.}$ with an $8.0\text{ in.}$ wide horizontal top hinge chord and a $4.0\text{ in.}$ downward circular drop arc ($A = \frac{1}{2}\pi R^2 \approx 25.13\text{ sq in.}$ vent area per flap; $1.05\text{ sq ft}$ total vent area per screen = 3.43% of sail area). Semicircular geometry allows fast, highly repeatable hand fabrication using a compass, pivot pin jig, or 3D-printed circular guide.
    - **Aerodynamic Performance:** Drops aerodynamic drag coefficient from $C_d = 1.20$ to $C_d = 1.02$ (15.0% drag and overturning moment reduction) and breaks coherent Strouhal vortex shedding (~0.8–1.2 Hz), preventing cyclic flutter and greenhouse snap clamp peel-off.
    - **Layout Coordinates (2 x 3 Grid in Upper 42%–71% Zone):** Positioned at horizontal columns $X = 24.0\text{ in.}$, $48.0\text{ in.}$, and $72.0\text{ in.}$ across the 96-in. width, in two horizontal rows at $Y = 34.0\text{ in.}$ (Upper Row) and $Y = 24.0\text{ in.}$ (Lower Row) above turf. Completely clears internal frame conduit (Rail 3 at 10.0 in., Rail 2 at 42.0 in.).
    - **MANDATORY Tear-Arrest Detail:** Before making any razor cut, punch two clean $\varnothing 3/8\text{ in.}$ ($10\text{ mm}$) circular holes at the top hinge endpoints using a rotary leather/gasket punch against a hardwood block. The semicircular razor cut sweeps along a true $R = 4.0\text{ in.}$ radius starting and terminating tangent to the circular holes. The top 8.0-in. horizontal chord remains UNCUT as a flexible gravity hinge. Circular holes eliminate stress concentration ($K_t \to 1.0$), permanently arresting tear propagation.
    - **Visual Camouflage & Viewing Optics:** Razor cuts have zero material removed (kerf $<0.01\text{ in.}$, over 30× smaller than the human eye's $0.31\text{ in.}$ resolution limit at 30 yards). True semicircular geometry ($1:2$ aspect ratio) provides high beam stiffness, eliminating the thermal tip-sag and curling seen in elongated U-cuts when exposed to $130^\circ\text{F}+$ turf heat. Flaps hang 100% flush under gravity, remaining invisible from spectator stands and the judges' press box.
    - **Floating Flap Artwork Protection Rule:** Flap centerlines are nominal and may float horizontally $\pm 6\text{ to }12\text{ in.}$ along the hinge row into solid colors, sky gradients, shadows, or negative textures. Flaps are **strictly prohibited** from cutting through performer faces, show typography/titles, or band logos.
    - **Backstage Concealment Preservation:** Preserves 96.6% solid, 100% opaque vinyl coverage (rejecting translucent 70/30 mesh banner). Venting begins at $Y \ge 20.0\text{ in.}$, keeping color guard equipment resting flat on turf ($Y \le 10.0\text{ in.}$) completely shielded from view.
    - **Backlight Baffle Option:** In backlit afternoon stadiums, volunteers may apply a $1.5\text{ in.} \times 1.5\text{ in.}$ black Gorilla tape patch to the rear of the punch holes with a lower tangent slit to block direct solar pinpricks.
    - **Full Engineering Analysis:** See dedicated specification [Semicircular Wind Relief Cuts Engineering Specification](WIND_RELIEF_CUTS_SPECIFICATION.md).

---

## 5. Aerodynamic Wind Loading, Ballasting & 2026 CBA Competition Rules

- **Aerodynamic & Geometric Properties:**
  - **Nominal Dimensions:** 4 ft nominal height × 8 ft nominal width.
  - **Actual Vinyl Sail Area:** $A = 30.5\text{ sq ft}$ (3.875 ft H × 7.875 ft W).
  - **Center of Pressure Height:** $h_{cp} = 1.94\text{ ft}$ (at centroid of vertical face).
  - **Triangular Base Stance:** $L_{base} = 2.29\text{ ft}$ (27.5 in. between front bottom rail and rear rail C).
  - **Atmospheric Scaling (Colorado Springs):** Altitude 6,500 ft ASL, air density $\rho = 0.0595\text{ lb/cu ft}$ (~23% reduction vs sea level $\rho = 0.0765\text{ lb/cu ft}$).
  - **Aerodynamic Drag Coefficient:** $C_d = 1.02$ (Standard with 6 engineered wind relief slits; reduces lateral drag by 15.0% vs solid $C_d = 1.20$).
  - **Dry Frame Weight:** 26.0 lbs (without ballast).
- **Turf Sliding Friction vs. Tipping Physics:**
  - **Artificial Turf Sliding Friction ($\mu \approx 0.35$):** Lateral sliding on artificial turf infill is the primary operational limit and occurs *before* tipping.
  - With standard Tier 1 ballast (2x 15-lb bags = 56 lbs total weight), solid vinyl begins sliding at 16.4 mph; engineered wind relief slits increase sliding resistance to **17.8 mph** (+1.4 mph buffer).
- **Critical Forward-Tipping Asymmetry:**
  - **Backward Tipping (Front Wind):** Pivots about rear rail C. Front frame has full 2.29 ft lever arm ($M_{rest, bwd} = 50.4\text{ ft-lb}$). Tips at 20.5 mph unballasted (with slits).
  - **Forward Tipping (Rear Wind - Critical Mode):** Pivots about front bottom rail. Heavy front frame sits directly on pivot with zero lever arm; rear frame provides only 9.2 ft-lb of restoring moment ($M_{rest, fwd} = 9.2\text{ ft-lb}$). Tips at 8.8 mph unballasted (with slits).
- **Ballast Leverage Optimization (Rear Rail C vs Rail 2 Suspension):**
  - **Primary Ballast (Placed over Rear Ground Rail C):** Acts at the maximum possible restoring lever arm ($d = 2.29\text{ ft}$). Two 15-lb bags (30 lbs) add 68.7 ft-lb of restoring moment, boosting forward tipping resistance to 25.5 mph (with slits). Imposes ZERO mechanical stress on 3D-printed clips (I) as weight rests directly on turf.
  - **Supplemental Ballast (Suspended from Upper Inner Rail 2):** Has near-zero lever arm to front rail (0 ft-lb against forward tipping). However, provides full 2.29 ft lever arm against backward tipping (34.4 ft-lb per bag). Strictly used for Tier 2/3 bidirectional wind balancing.
- **Standardized Tiered Ballasting Schedule (Colorado Springs 6,500 ft ASL, with Slits):**
  - **Tier 0 (Calm, 0–8 mph, gusts ≤10 mph):** 0 bags (dry wt 26 lbs). Safe to 8.8 mph fwd / 20.5 mph bwd tipping; turf sliding limit 12.1 mph. Upgrade to Tier 1 if wind >8 mph.
  - **Tier 1 (Normal, 8–12 mph):** 1x to 2x 15-lb bags placed over rear ground rail C (total wt 41–56 lbs). Safe to 19.0–25.5 mph fwd / 20.5 mph bwd tipping; turf sliding limit 15.2–17.8 mph. Zero clip stress.
  - **Tier 2 (Advisory, 12–18 mph):** 2x 15-lb bags over rear rail C + 1x 15-lb bag suspended from Rail 2 (total wt 71 lbs). Balanced stability: 25.5 mph fwd / 26.6 mph bwd; turf sliding limit 20.0 mph.
  - **Tier 3 (High-Wind, 18–22 mph):** 2x 15-lb bags over rear rail C + 2x 15-lb bags suspended from Rail 2 (total wt 86 lbs). Safe to 26.6–31.5 mph max gust; turf sliding limit 22.1 mph. Turf contact pressure ~0.25 psi (zero turf compaction).
  - **Tier 4 (Safety Abort, >20 mph sustained or >25 mph peak gusts):** STRICT NO-GO. Disengage clips (I), collapse rear support frame, and lay screen flat on turf.
- **Severe Wind Feasibility Analysis (30 mph Limits):** For detailed engineering calculations and failure mode evaluations regarding extreme wind regimes, see [30 mph Wind Loading & Ballasting Feasibility Analysis](WIND_LOADING_30MPH_ANALYSIS.md). Ballasting for 30 mph on the field is prohibited due to lateral sliding drift on turf (requires >161 lbs ballast), tensile detachment of 3D-printed snap clips (I) under 153 lbs pull load, and logistical breakdown of deployment timelines.
- **Adopted Field Logistics Architecture: Two-Student Carry Deployment & Egress:**
  - **Paradigm Shift:** Following stochastic Monte Carlo simulation ($N = 5,000$ trials) and aerodynamic drag analysis, PCHSMB has officially adopted the **Two-Student Carry (Walk-Across)** strategy for competition field deployment and post-show egress.
  - **Fleet & Crew Allocation:**
    - Total fleet: **16 screens** deployed across two 8-screen lines flanking the front ensemble.
    - Crew: **32 student performers/handlers** (16 pairs, exactly 2 students per duck blind).
    - Support: Direct student transit. Student pairs carry assembled blinds from trailer/warmup lot directly into the stadium; no transport carts are built or required.
  - **Pre-Show Deployment Walkthrough (Mean: 55.7s | P95: 58.3s | +139s Safety Buffer):**
    - **Queue & Stage:** Prior to entry permission, student pairs carry their fully assembled duck blinds into the stadium through rear gates and queue up along the back sideline/end zone directly across the field from their assigned front sideline coordinate marks.
    - **The Walk-Across:** At the CBA entry signal ($T = 0:00$), all 16 student pairs simultaneously walk straight across the field carrying their assembled screen (13 lbs per student).
    - **Deposit & Align:** At the front sideline, pairs place the screen, fine-align the front face with adjacent screens into a continuous visual wall, and seat the staged ballast bags over the rear ground rail C.
    - **Clearance:** Pairs complete setup and step into their opening show drill sets in **~55–58 seconds**, banking an enormous **+139 seconds** of safety buffer before the 3:15 clock expires.
    - **Zero Adult Penalties:** Because students perform the entire on-field deployment, **zero adult volunteers step onto the turf**, completely eliminating the risk of CBA Rule 4.03 adult field-presence penalties (0.2 pts per occurrence).
  - **Post-Show Field Egress Walkthrough (Mean: 55.0s | P95: 60.4s | +65s Safety Buffer):**
    - **Final Chord Pick-Up:** On the final note of the show, assigned student pairs immediately lift ballast bags gently to the turf (never throwing or dropping sandbags), grasp the assembled 26-lb duck blind between them (13 lbs/student), and hoof it straight off the field toward the stadium exit gate/tunnel.
    - **Field Clearance:** All 16 screens completely clear the field boundary within **~50–60 seconds**, well within the official 2:00 CBA egress window.
    - **Direct Exit to Trailer Lot:** Student pairs carry screens straight out through the exit chute directly to the equipment trailer. Adult volunteers sweep resting ballast sandbags off the front sideline. No carts or off-clock tunnel reloading required.
- **2026 CBA Marching Band Competition Rules Compliance:**
  - **Rule 5.02 (Mandatory Rear Entrance for Props):** CRITICAL MANDATE — All props must enter from the back sideline or rear end zone gates (above goal posts). Never cross directly across front boundary (reserved for pit equipment).
  - **Rule 5.03 & 5.06 (Entry Permission & Timing):** Pre-stage in rear half of end zone up to goal line. Never enter field before T&P judge signals official permission. Total setup and adult clearance window is 3 minutes 15 seconds.
  - **Rule 4.03 & 5.06 (Field Clearance Before Performance):** All non-performer adult volunteers must be COMPLETELY CLEAR of field before introductory announcement ends (3:15 after entry permission; 0.2 pt penalty per occurrence).
  - **Rule 4.03 (Re-Entry Prohibition):** Adults strictly prohibited from entering/re-entering field during performance (0.2 pt penalty per occurrence).
  - **Rule 4.02(c) (Medical Emergency Assistance Exception):** NO PENALTY. Any band member ill or injured may be assisted from the field by adult volunteers, parents, or staff without penalty.
  - **Rule 4.02(a) (High-Wind Prop Restraint Exception):** In high winds when props are in danger of falling over, adults may enter performance field solely to secure props (never move props as choreography).
  - **Rule 8.05 (Continuous Egress & Double-Bagging):** Continuous movement off field to trailer lot required; never de-ballast or park at stadium exit chutes. All sandbags MUST be double-bagged with intact plastic inner liners.
  - **Rule 8.07 & 8.08 (Wheels & Height):** 12-foot rigid height limit strictly observed (screen is 4 ft deployed).
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

### B. Fleet Production Total (16 Screens Total)

| Fleet Category | Description | Est. Cost |
|---|---|:---:|
| **16x Sideline Screens** | Complete frames @ ~$105.00 (excl. vinyl/ballast) | ~$1,680.00 |
| **TOTAL FLEET HARDWARE** | *(No transport carts built — saves $440.00)* | **~$1,680.00** |
