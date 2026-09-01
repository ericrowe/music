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
| **-** | 1 | Face covering | Heavyweight vinyl banner with hem and grommets | Custom printed |

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

---

## 5. Field Operations, Ballasting & 2026 CBA Rules

- **Field Form Factor:** 4 ft x 8 ft folding frame with triangular self-supporting stance.
- **Ballast Attachment:** Weights / sandbags must be suspended from upper weight clips; never place weights directly over bottom support arms/clips.
- **Mandatory Double-Bagging Rule (CBA Rule 8.05):** All sandbags MUST utilize heavy-duty inner liner bags or secondary containment to prevent turf contamination.
- **2026 CBA Competition Rules Compliance:**
  - **Rule 8.05:** Heavy-duty plastic protection on all turf-contacting wood surfaces, continuous movement off field, mandatory secondary containment / double-bagging on sandbags.
  - **Rule 8.07:** Pneumatic-like turf-compatible wheels required for rolling equipment.
  - **Rule 8.08:** 12-foot rigid height limit (sideline screen is 4 ft nominal height, safely compliant).
  - **Rule 8.09:** Staging flow & USAFA Falcon Stadium clearance (note: 9'6" restriction obsolete after 2025 crossbeam removal).
  - **Rule 9.07:** 25 parent Field Pass wristbands allocation limit.

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

### B. Sideline Screen Transport Cart (Component 2 Estimate)

| Item / Category | Description | Est. Cost |
|---|---|:---:|
| **Rolling Base Chassis** | Backdrop-spec 2x4 framing, 1/2" plywood deck, 4x heavy-duty casters w/ brakes, paint | $155.00 |
| **Side Guide Rails** | Vertical framing / conduit dividers to hold screens upright | $35.00 |
| **Front & Rear Retention Gates** | Hinged gate framing, strap/barrel hinges, and 3D-printed latches | $30.00 |
| **TOTAL PER TRANSPORT CART** | | **~$220.00** |
