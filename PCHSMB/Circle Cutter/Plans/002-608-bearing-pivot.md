# Implementation Plan 002: Top-Mounted 608 Ball Bearing Thrust Pivot

**Project:** PCHSMB Field Prop Circle Cutter  
**Status:** Completed & Verified (v1.4)  
**Target Release:** v1.4  
**Components Affected:**
- Piece 1 (`circle_cutter_base.stl`) — Spindle top post & inner-race shoulder
- Piece 2 (`circle_cutter_arm.stl`) — Recalibrated 625 roller bearing axle height
- Piece 4 (`circle_cutter_hub_cap.stl`) — Outer-race thrust pocket & inner relief cavity
- Calibration Coupons (`circle_cutter_snap_cap_coupon.stl`, `circle_cutter_spindle_bore_coupon.stl`)
- Documentation (`README.md`, `PHYSICAL_TEST_NOTES.md`, `circle_cutter.scad`, `build/manifest.json`)

---

## 1. Problem Statement & Engineering Rationale

### The Friction Problem
In the v1.3 design, the rotating arm (Piece 2) sleeved over the base spindle and rested directly on the $50.0\text{ mm}$ OD base plate shoulder.
- Shoulder contact area: $A = \pi (R_{\text{hub\_out}}^2 - R_{\text{spindle}}^2) = \pi (25^2 - 20^2) = 225 \pi \approx 707\text{ mm}^2$.
- Friction coefficient: PETG-on-PETG static friction coefficient $\mu_s \approx 0.35–0.45$.
- Under normal downward cutting hand pressure ($F_z = 25–45\text{ N} \approx 5–10\text{ lbf}$), the resulting frictional resistance torque is:
  $$\tau_f = \mu \cdot F_z \cdot R_{\text{mean}} \approx 0.40 \cdot 35\text{ N} \cdot 0.0225\text{ m} \approx 0.315\text{ N}\cdot\text{m}$$
This large resistance torque caused severe stick-slip, jerky arm motion, and hand fatigue during delicate 180° circular cuts on 13oz banner vinyl.

### Bearing Selection & Axial Thrust Suitability
The user provided standard **608 ball bearings** ($8.0\text{ mm ID} \times 22.0\text{ mm OD} \times 7.0\text{ mm W}$), commonly manufactured for skateboards, inline skates, and 3D printer filament spools.
- **Radial vs. Thrust Loading:** Although standard 608 bearings are deep-groove radial bearings (conforming to DIN 625 / ISO 15), deep-groove ball bearings naturally carry significant pure axial thrust loading because the deep raceway curvature cradles the balls against the raceway sidewalls.
- **Axle Thrust Capacity:** A standard 608 bearing possesses:
  - Basic dynamic radial load rating: $C \approx 3.30\text{ kN}$ ($740\text{ lbf}$)
  - Basic static radial load rating: $C_0 \approx 1.37\text{ kN}$ ($308\text{ lbf}$)
  - Permissible static axial thrust rating: $F_{a, \text{perm}} \approx 0.5 \cdot C_0 \approx 685\text{ N}$ ($154\text{ lbf}$)
- **Operational Safety Factor:** Under maximum manual operator downward pressure ($F_z \le 50\text{ N} \approx 11\text{ lbf}$):
  $$\text{Safety Factor } SF = \frac{685\text{ N}}{50\text{ N}} \approx 13.7$$
The axial loading is $<7.5\%$ of rated capacity, guaranteeing zero damage to bearing raceways and silky-smooth, near-zero rolling friction ($\mu_{\text{rolling}} \approx 0.0015$).

### Top vs. Bottom Mounting Architecture
- **Bottom Mounting Rejected:** Mounting the 608 bearing at the bottom would require shrinking the center spindle from $\varnothing 40.0\text{ mm}$ down to $\varnothing 8.0\text{ mm}$ to pass through the bearing ID. A $100\text{ mm}$ tall, $\varnothing 8.0\text{ mm}$ plastic column would flex under lateral loads, allowing the $150\text{ mm}$ arm to rock and ruining the $1.0\text{ mm}$ cut depth.
- **Top Mounting Selected:** The $\varnothing 40.0\text{ mm}$ rigid column is preserved over the entire $100.0\text{ mm}$ height, preventing arm tilt. Only at the very top ($Z_{\text{world}} = 104.0\text{ mm}$) does the spindle step down to an $\varnothing 11.5\text{ mm}$ inner-race shoulder and an $\varnothing 7.9\text{ mm}$ pilot post. The 608 bearing sits atop the spindle, captured inside Piece 4 (Snap-in Hub Cap).

---

## 2. Geometric Stackup & Clearance Budget

### Reference Coordinates
- Ground reference: $Z_{\text{world}} = 0.0\text{ mm}$ (top surface of vinyl).
- Arm local reference: $Z_{\text{local}} = 0.0\text{ mm}$ at the bottom plane of Piece 2.

```
       +================================================+  Z_world = 115.0 mm (Hub Cap Flange Top)
       |           Piece 4: Snap-in Hub Top Cap         |
       |  +------------------------------------------+  |  Z_world = 112.0 mm (Hub Cap Seating Rim)
       |  |  [Relief Recess ID 18mm x 1.5mm deep]     |  |
       |  |     +------------------------------+     |  |  Z_world = 111.0 mm (608 Bearing Top / Outer Race Drive)
       |  |     |  608 Bearing Outer Race (OD 22mm)  |  |
       |  |     |  [608 Ball Bearing (7mm W)]  |     |  |
       |  |     |  608 Inner Race (ID 8mm)     |     |  |  Z_world = 104.0 mm (608 Inner Race Shoulder)
       |  +-----+------------------------------+-----+  |  Z_world = 103.0 mm (Spindle Top / 1.0mm Relief)
       |        |                              |        |
       |        |   Piece 1: Spindle (40mm OD) |        |
       |        |                              |        |
       |        |   Piece 2: Arm Bore (42mm ID)|        |
       |        |                              |        |
       +--------+                              +--------+  Z_world = 4.0 mm (Piece 2 Arm Bottom / Bed Plane)
       |                                                |
       |        1.0 mm Uniform Air Gap (ZERO FRICTION)  |
       |                                                |
  +----+------------------------------------------------+----+  Z_world = 3.0 mm (Piece 1 Base Shoulder)
  |            Piece 1: Fixed Pivot Base (50mm OD)           |
  +==========================================================+  Z_world = 0.0 mm (Vinyl Reference Plane)
```

### Detailed Height and Diametral Budget

1. **Piece 1 (Fixed Pivot Base):**
   - Base Plate: $Z_{\text{world}} \in [0.0, 3.0\text{ mm}]$, $\varnothing 50.0\text{ mm}$ OD ($3.0\text{ mm}$ thick).
   - Spindle Column: $Z_{\text{world}} \in [3.0, 103.0\text{ mm}]$, $\varnothing 40.0\text{ mm}$ OD ($100.0\text{ mm}$ tall column).
   - Inner Race Shoulder: $Z_{\text{world}} \in [103.0, 104.0\text{ mm}]$, $\varnothing 11.5\text{ mm}$ OD ($1.0\text{ mm}$ height).
     - Provides $1.0\text{ mm}$ vertical clearance between the top of the $\varnothing 40.0\text{ mm}$ spindle and the rotating 608 outer race/shields.
   - Spindle Post: $Z_{\text{world}} \in [104.0, 110.0\text{ mm}]$, $\varnothing 7.90\text{ mm}$ OD ($6.0\text{ mm}$ height, $0.8\text{ mm} \times 45^\circ$ lead-in chamfer).
     - Shorter than $7.0\text{ mm}$ bearing thickness by $1.0\text{ mm}$, guaranteeing the post top never contacts the hub cap.
   - Total Base Height: $3.0 + 100.0 + 1.0 + 6.0 = \mathbf{110.0\text{ mm}}$.

2. **Piece 2 (Rotating Arm Assembly):**
   - Suspended Elevation: Arm bottom rests at $Z_{\text{world}} = 4.0\text{ mm}$, maintaining $4.0\text{ mm}$ uniform air clearance above vinyl.
   - Air Gap to Base Plate: $Z_{\text{world}} = 4.0 - 3.0 = \mathbf{1.0\text{ mm}}$ clearance! Eliminates all plastic shoulder friction.
   - Hub Sleeve Height: $108.0\text{ mm}$ ($Z_{\text{local}} \in [0.0, 108.0\text{ mm}]$, $Z_{\text{world}} \in [4.0, 112.0\text{ mm}]$).
   - Sleeve OD / ID: $\varnothing 50.0\text{ mm}$ OD / $\varnothing 42.0\text{ mm}$ ID ($1.0\text{ mm}$ radial clearance to spindle).
   - Internal Retention Groove: $Z_{\text{local}} = 103.5–105.5\text{ mm}$ ($Z_{\text{world}} = 107.5–109.5\text{ mm}$), $\varnothing 43.6\text{ mm}$ groove diameter ($0.8\text{ mm}$ undercut).
   - 625 Roller Bearing Axle Alignment:
     - 625 bearing touches vinyl at $Z_{\text{world}} = 0.0\text{ mm}$.
     - Bearing radius $R = 8.0\text{ mm} \implies Z_{\text{world, axle}} = 8.0\text{ mm}$.
     - Arm local axle height: $Z_{\text{local, axle}} = Z_{\text{world, axle}} - Z_{\text{world, arm\_bot}} = 8.0 - 4.0 = \mathbf{4.0\text{ mm}}$.
     - By maintaining $Z_{\text{local, axle}} = 4.0\text{ mm}$, the M5 insert hole ($\varnothing 6.2\text{ mm}$) retains its structural $0.9\text{ mm}$ bottom floor above the print bed, and the $\varnothing 8.0\text{ mm}$ standoff boss remains dead flush with the print bed ($Z_{\text{local}} = 0.0$), preserving 100% support-free bed adhesion.
   - Blade Depth: Tip extends to $Z_{\text{world}} = -1.0\text{ mm}$ ($1.0\text{ mm}$ cut depth into vinyl). Preserved exactly.

3. **Piece 4 (Snap-in Hub Top Cap):**
   - Flange: $\varnothing 50.0\text{ mm}$ OD, $3.0\text{ mm}$ thick ($Z_{\text{world}} \in [112.0, 115.0\text{ mm}]$).
   - Skirt (Flex Fingers): 4 cantilever fingers extending downward $6.0\text{ mm}$ ($Z_{\text{world}} = 112.0$ down to $106.0\text{ mm}$).
     - Skirt OD: $\varnothing 41.6\text{ mm}$, Barb OD: $\varnothing 43.0\text{ mm}$, Snaps into Piece 2 groove at $Z_{\text{world}} = 108.5\text{ mm}$.
   - 608 Bearing Pocket (Underside):
     - Pocket Wall: $\varnothing 25.0\text{ mm}$ OD, $\varnothing 22.2\text{ mm}$ ID ($1.4\text{ mm}$ wall thickness).
     - Pocket Depth: $4.0\text{ mm}$ downward from flange underside ($Z_{\text{world}} = 112.0$ down to $108.0\text{ mm}$).
     - Outer-Race Thrust Shoulder: Annular contact face spanning $R \in [9.5, 11.1\text{ mm}]$ at $Z_{\text{world}} = 111.0\text{ mm}$ ($1.0\text{ mm}$ below flange seating rim).
     - Inner Relief Recess: Cavity spanning $R \le 9.0\text{ mm}$ ($\varnothing 18.0\text{ mm}$ ID), recessed an extra $1.5\text{ mm}$ upward ($Z_{\text{world}} = 112.5\text{ mm}$).
     - Guaranteed Clearances: $> 1.5\text{ mm}$ axial clearance to 608 inner race and shields; $> 2.5\text{ mm}$ axial clearance to spindle post top.

---

## 3. Contact Isolation & Parasitic Friction Analysis

To achieve zero parasitic friction, every rotating surface must contact ONLY its designated bearing race:

| Component / Feature | Intended Contact | Prohibited Contact | Clearance Margin |
|---|---|---|:---:|
| **Piece 1: Spindle Top Face** ($\varnothing 40.0\text{ mm}$) | None | 608 Outer Race & Shields | $1.0\text{ mm}$ axial clearance (held by $\varnothing 11.5\text{ mm}$ shoulder) |
| **Piece 1: Inner Race Shoulder** ($\varnothing 11.5\text{ mm}$) | 608 Inner Race ($\varnothing 8.0–11.8\text{ mm}$) | 608 Ball Shield ($\varnothing \ge 12.5\text{ mm}$) | $> 0.5\text{ mm}$ radial clearance |
| **Piece 1: Spindle Post** ($\varnothing 7.90\text{ mm}$) | 608 Inner Bore ($\varnothing 8.00\text{ mm}$) | Piece 4 Hub Cap Roof | $2.5\text{ mm}$ axial clearance |
| **Piece 4: Outer Race Drive Ring** ($\varnothing 19–22.2\text{ mm}$) | 608 Outer Race ($\varnothing 19.2–22.0\text{ mm}$) | 608 Ball Shield & Inner Race | $> 0.7\text{ mm}$ radial clearance |
| **Piece 4: Center Relief Recess** ($\varnothing \le 18.0\text{ mm}$) | None | 608 Inner Race, Shield, Post | $1.5\text{ mm}$ axial clearance |
| **Piece 2: Arm Bottom Shoulder** | None | Piece 1 Base Plate | $\mathbf{1.0\text{ mm}}$ axial air gap ($0\text{ mm}^2$ contact) |

---

## 4. Pre-Print Calibration Coupons

To avoid wasting 3 hours of print time, two rapid test coupons verify all updated interfaces:
1. **`circle_cutter_snap_cap_coupon.stl` (~18 min):**
   - 15mm hub sleeve ring + Piece 4 Hub Cap with 608 bearing pocket.
   - Verifies:
     - 608 bearing snaps/slides cleanly into $\varnothing 22.2\text{ mm}$ pocket without binding.
     - Cap snaps into $15\text{ mm}$ hub sleeve with audible lock.
     - Inner relief cavity leaves free rotation of 608 inner race.
2. **`circle_cutter_spindle_bore_coupon.stl` (~18 min):**
   - 20mm spindle stub + 20mm bore ring.
   - Updated to include the $\varnothing 11.5\text{ mm}$ shoulder and $\varnothing 7.9\text{ mm}$ post.
   - Verifies:
     - 608 bearing slides smoothly onto post and seats flush on shoulder.
     - 608 outer race spins freely above the $\varnothing 40\text{ mm}$ spindle top without rubbing.

---

## 5. Implementation Tasks & Quality Gates

- [x] **Stage 1:** Codify Idea 004 in `IDEAS.md` and link to Plan 002.
- [x] **Stage 2:** Draft complete implementation plan in `Plans/002-608-bearing-pivot.md`.
- [x] **Stage 3.1:** Update `generate_circle_cutter.py`:
  - Add 608 bearing geometric constants and air gap parameters.
  - Update `build_piece1_base()` with $\varnothing 11.5\text{ mm}$ shoulder and $\varnothing 7.9\text{ mm}$ post.
  - Recalibrate base plate height to $3.0\text{ mm}$ to establish $1.0\text{ mm}$ air gap to arm bottom at $Z=4.0\text{ mm}$.
  - Update `build_piece4_hub_cap()` with $\varnothing 22.2\text{ mm}$ outer-race pocket and $\varnothing 18.0\text{ mm}$ relief.
  - Update coupons (`build_snap_cap_coupon()`, `build_spindle_bore_coupon()`).
- [x] **Stage 3.2:** Run pure-Python CAD pipeline:
  - Generate all 7 STLs and verify 4 non-negotiable topological gates (all 7 passed: 0 boundary, 0 non-manifold, 0 degenerate, 100% finite).
  - Update `build/manifest.json`.
- [x] **Stage 3.3:** Pure-Python 3D rendering:
  - Implement pure-Python multi-component scene renderer (`render_assembly_views`) generating `circle_cutter_assembly.png` and `circle_cutter_exploded.png` with zero external CAD dependencies.
  - Remove obsolete OpenSCAD files.
- [x] **Stage 3.4:** Update documentation:
  - Add 608 bearing to BOM in `README.md`.
  - Add caliper targets to `PHYSICAL_TEST_NOTES.md`.
  - Codify subproject engineering lifecycle and pure-Python tooling invariant in `AGENTS.md`.
  - Mark this plan as `Completed & Verified`.
- [x] **Stage 4:** Structured conventional Git commit.
