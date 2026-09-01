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
