# PCHSMB Field Prop Circle Cutter

Parametric 3D-printable circle cutter engineered specifically for Pine Creek High School Marching Band (PCHSMB) field prop fabrication. Designed to produce precise, repeatable semicircular wind relief slits ($R = 4.0\text{ in.} = 101.6\text{ mm}$) in heavy-duty printed scrim vinyl for the **2026 Continuum** Sideline Screen Duck Blinds and Rolling Backdrops.

---

### 1. Overview & Mechanical Design

The tool utilizes a concentric 4-piece modular rotating pivot architecture with integrated ball-bearing thrust suspension:
1. **Fixed Pivot Base (Piece 1):** Centered directly over the marked wind relief location. Four exterior vertical crosshair notches allow precise visual alignment against perpendicular layout lines on the vinyl. The top of the $100\text{ mm}$ center spindle features an integrated $\varnothing 11.5\text{ mm} \times 1.0\text{ mm}$ inner-race shoulder and $\varnothing 7.9\text{ mm} \times 6.0\text{ mm}$ center pilot post that securely captures the inner race of a standard 608 ball bearing.
2. **Rotating Arm Assembly (Piece 2):** Sleeves smoothly over the base spindle with a slip fit ($1.0\text{ mm}$ radial clearance). Features an open through-bore and internal annular retention groove ($Z = 103.5–105.5\text{ mm}$), enabling **100% support-free upright printing** with the $150\text{ mm}$ arm resting flat on the build plate. The arm is suspended at world $Z = 4.0\text{ mm}$, maintaining a **$1.0\text{ mm}$ uniform air gap** above the base plate shoulder, reducing plastic sliding contact area from $707\text{ mm}^2$ to **$0\text{ mm}^2$**. The distal end features a Side-by-Side Dual Head housing a roller bearing depth stop and an X-Acto #11 blade mount.
3. **Blade Clamping Cap (Piece 3):** Clamps over the standard X-Acto #11 blade tang, distributing M3 machine screw retention force evenly to prevent blade flutter, skewing, or rotation under cutting friction.
4. **Snap-in Hub Top Cap (Piece 4):** A separate 4-finger flex collet cap that snaps firmly into the internal retention groove at the top of the hub sleeve. Features an integrated $\varnothing 22.2\text{ mm} \times 3.0\text{ mm}$ outer-race pocket and $\varnothing 18.0\text{ mm} \times 1.5\text{ mm}$ inner relief cavity that captures the top 608 ball bearing. Transmits 100% of downward cutting hand pressure through the rolling elements of the 608 bearing directly into the base spindle, eliminating arm-on-base sliding resistance.

```
       [Piece 4: Snap-in Hub Top Cap (608 Outer Race Drive Pocket)]
              +====================+
              | [608 Ball Bearing] |  <-- Transmits 100% downward manual cutting thrust
              |   (8x22x7mm Deep)  |
       [Piece 2: Rotating Hub & 150mm Arm]
              |   42mm Thru-Bore   |----------------------------[Side-by-Side Head]
              |                    |                                 |       |
              |   Internal Groove  |                            [Bearing] [Blade]
              |    (Snap Barbs)    |                                 |       |
              |                    |                                 V       V
              +--------------------+                           (Rolls) (Cuts 1mm)
              : 1.0mm Air Gap (0mm² Friction!)                       |       |
       +------+--------------------+------+                          |       |
       |  Piece 1: Base Plate (Crosshairs)|                          |       |
 ======+==================================+==========================+=======+=== (Vinyl Plane)
```

---

## 2. Component Specifications & Dimensions

| Component | Dimensions ($X \times Y \times Z$) | Material / Infill | Primary Features |
|---|---|---|---|
| **Piece 1: Fixed Pivot Base**<br>[`circle_cutter_base.stl`](circle_cutter_base.stl) | $50.0 \times 50.0 \times 110.0\text{ mm}$ | PETG / 25% Gyroid | • $50\text{ mm}$ OD $\times 3.0\text{ mm}$ H base plate (creates $1.0\text{ mm}$ air gap below arm!)<br>• 4 vertical crosshair notches ($1.0\text{ mm}$ D $\times 1.8\text{ mm}$ W) at $0^\circ, 90^\circ, 180^\circ, 270^\circ$<br>• $40\text{ mm}$ OD $\times 100\text{ mm}$ H center spindle<br>• $\varnothing 11.5\text{ mm} \times 1.0\text{ mm}$ inner-race shoulder<br>• $\varnothing 7.9\text{ mm} \times 6.0\text{ mm}$ center pilot post with $0.8\text{ mm} \times 45^\circ$ chamfer |
| **Piece 2: Rotating Arm Assembly**<br>[`circle_cutter_arm.stl`](circle_cutter_arm.stl) | $201.0 \times 50.0 \times 108.0\text{ mm}$ | PETG / 30% Gyroid / 4 walls | • $50\text{ mm}$ OD hub sleeve with open through-bore<br>• $\varnothing 42\text{ mm}$ ID bore with internal $\varnothing 43.6\text{ mm}$ retention groove ($45^\circ$ self-supporting overhangs)<br>• **100% support-free upright printability** with arm flat on bed ($Z=0$)<br>• Suspended at world $Z=4.0\text{ mm}$ with $1.0\text{ mm}$ air gap above base plate ($0\text{ mm}^2$ sliding friction!)<br>• **Bearing Pad ($Y = -9\text{ mm}$):** $\varnothing 8.0\text{ mm}$ standoff boss + M5 heat-set insert hole; 100% open front-face tool clearance<br>• **Blade Pad ($Y = +9\text{ mm}$):** Distal blade pocket ($6.0\text{ mm}$ W) with anti-rotation tabs and M3 heat-set hole<br>• Calibrated $1.0\text{ mm}$ cut depth into vinyl below 625 bearing |
| **Piece 3: Blade Clamp Cap**<br>[`circle_cutter_blade_cap.stl`](circle_cutter_blade_cap.stl) | $3.5 \times 12.0 \times 16.0\text{ mm}$ | PETG / 100% Solid | • $12\text{ mm} \times 16\text{ mm} \times 3.5\text{ mm}$ clamping pad<br>• $\varnothing 3.4\text{ mm}$ M3 clearance through-hole<br>• Chamfered outer perimeter for smooth handling |
| **Piece 4: Snap-in Hub Top Cap**<br>[`circle_cutter_hub_cap.stl`](circle_cutter_hub_cap.stl) | $50.0 \times 50.0 \times 9.0\text{ mm}$ | PETG / 100% Solid | • $\varnothing 50\text{ mm} \times 3\text{ mm}$ top flange with $1.5\text{ mm} \times 45^\circ$ chamfer<br>• Integrated $\varnothing 22.2\text{ mm}$ outer-race pocket with $1.0\text{ mm}$ thrust face<br>• Central $\varnothing 18.0\text{ mm} \times 1.5\text{ mm}$ relief cavity (isolates inner race, shield, and post)<br>• 4 cantilever flex collet fingers with $30^\circ$ entry ramp and $45^\circ$ retention barb ($\varnothing 43.0\text{ mm}$)<br>• Tactile audible snap fit; seals bore and carries 100% downward manual pressure |

---

## 3. Hardware Bill of Materials (BOM)

| Item | Specification | Qty | Purpose | Source / Notes |
|---|---|:---:|---|---|
| **Thrust Pivot Bearing** | 608 Miniature Ball Bearing (608ZZ / 608-2RS) | 1 | Carries 100% downward cutting thrust; eliminates arm-base friction | $8\text{ mm}$ ID $\times 22\text{ mm}$ OD $\times 7\text{ mm}$ W |
| **Roller Bearing** | 625 Miniature Ball Bearing (625ZZ / 625-2RS) | 1 | Rolls on vinyl; precision $1.0\text{ mm}$ depth stop | $5\text{ mm}$ ID $\times 16\text{ mm}$ OD $\times 5\text{ mm}$ W |
| **Bearing Axle Screw** | M5 $\times 12\text{ mm}$ Button Head Cap Screw | 1 | Secures 625 bearing inner race to arm | Stainless steel or black oxide ISO 7380 |
| **Bearing Insert** | M5 Brass Heat-Set Insert | 1 | Durable machine threads for bearing axle | $\varnothing 6.2\text{ mm}$ hole spec; length 6, 8, or 10 mm ($11.0\text{ mm}$ bore depth) |
| **Cutting Blade** | Standard #11 X-Acto / Hobby Blade | 1 | Precision razor cutting of vinyl | Standard carbon steel with shank slot (e.g. X-Acto X211) |
| **Blade Insert** | M3 Brass Heat-Set Insert | 1 | Durable machine threads for blade clamp | $\varnothing 3.8\text{ mm}$ hole spec; length 6, 8, or 10 mm ($10.5\text{ mm}$ bore depth) |
| **Clamping Screw** | M3 $\times 10\text{ mm}$ Socket / Button Head | 1 | Secures clamp cap and blade tang | Stainless steel or black oxide Class 10.9/12.9 |

---

## 4. 3D Printing Guidelines

* **Recommended Filament:** **PETG** (e.g. Polymaker PolyLite PETG, Bambu PETG Basic, or Prusament PETG). PETG provides superior layer bonding, dimensional impact toughness, and wear resistance over PLA for sliding mechanical fits.
* **Alternative Filament:** PLA+ / Tough PLA (acceptable for indoor shop use).
* **Layer Height:** $0.20\text{ mm}$ standard ($0.16\text{ mm}$ optional for ultra-smooth spindle and bore finishes).
* **Perimeters / Wall Loops:** **4 walls minimum** ($1.6\text{ mm}$ total wall thickness) to ensure maximum torsional stiffness along the $150\text{ mm}$ arm.
* **Infill:** $25\%$ Gyroid or Adaptive Cubic.
* **Print Orientations:**
  * **Piece 1 (Base):** Print standing upright on the flat $50\text{ mm}$ base plate ($Z = 0$). Zero supports required.
  * **Piece 2 (Arm):** Print standing upright on its bottom face ($Z = 0$) with the $150\text{ mm}$ arm resting flat on the build plate. The open through-bore and internal $45^\circ$ groove require **zero supports and zero bridging**.
  * **Piece 3 (Blade Clamp Cap):** Print flat on its back face. Zero supports required (~8 min).
  * **Piece 4 (Snap-in Hub Top Cap):** Print inverted flat on its top face ($Z = 0$) on the bed. Zero supports required (~12 min).

---

## 5. Assembly & Setup

1. **Install Heat-Set Inserts:**
   * Heat a soldering iron equipped with a metric heat-set installation tip to **$230^\circ\text{C}–245^\circ\text{C}$** for PETG (or $210^\circ\text{C}$ for PLA).
   * **M3 Blade Insert:** Press square into the $\varnothing 3.8\text{ mm}$ hole on the front face of the **Blade Pad** ($Y = +9.0\text{ mm}$) until flush.
   * **M5 Axle Insert:** Press square into the $\varnothing 6.2\text{ mm}$ hole inside the $\varnothing 8.0\text{ mm}$ standoff boss on the front face of the **Bearing Pad** ($Y = -9.0\text{ mm}$) until flush with the standoff face.
   * Allow both inserts to cool undisturbed for at least 2 minutes.
2. **Install 625 Roller Bearing:**
   * Slide the 625 bearing ($16\text{ mm}$ OD $\times 5\text{ mm}$ ID $\times 5\text{ mm}$ W) onto an M5 $\times 12\text{ mm}$ or $14\text{ mm}$ button head screw.
   * Thread the screw straight into the M5 heat-set insert on the bearing pad from the front face (100% open tool clearance with standard Allen key).
   * Tighten firmly. Spin the bearing by hand to verify that the outer race spins with zero drag or binding against the integrated $8.0\text{ mm}$ standoff boss.
3. **Install X-Acto Blade & Clamp:**
   * Seat the tang of a fresh #11 X-Acto blade into the vertical $6.0\text{ mm}$ slot on the blade pad ($Y = +9.0\text{ mm}$). Verify the tang is captured between the $0.8\text{ mm}$ raised anti-rotation tabs.
   * Place the Blade Clamping Cap (Piece 3) over the blade tang.
   * Insert the M3 $\times 10\text{ mm}$ screw through the cap and blade slot into the M3 heat-set insert.
   * Tighten with a hex key until the blade is rigidly locked without play.
   * Check blade depth: The blade tip should extend exactly **$1.0\text{ mm}$ below the bottom rolling surface of the bearing**.
4. **Install 608 Thrust Bearing & Snap Cap:**
   * Slide the 608 bearing onto the $\varnothing 7.9\text{ mm}$ center post on top of the Piece 1 spindle until the inner race seats flush on the $\varnothing 11.5\text{ mm}$ shoulder.
   * Slide Piece 2 (Rotating Arm) over the spindle.
   * Align Piece 4 (Snap-in Hub Cap) with the top of the Piece 2 hub bore. Press firmly downward with your thumb until the collet fingers snap audibly into the internal retention groove.
   * Verify that the 608 bearing outer race is captured inside Piece 4's pocket and that the arm bottom is suspended with a **$1.0\text{ mm}$ air gap above the base plate**, rotating with silky-smooth zero-drag ball-bearing action.

---

## 6. Operating Procedure (Cutting Semicircular Wind Relief Slits)

Per the **PCHSMB Field Prop Fabrication Standard** (Section 8.3):
1. **Punch Endpoint Relief Holes First:** Using a heavy-duty rotary punch or $\varnothing 3/8\text{ in.}$ ($10\text{ mm}$) hole punch, punch the two stress-relief boundary holes spaced exactly $8.0\text{ in.}$ apart on the layout baseline.
2. **Position the Base:** Place Piece 1 on the vinyl. Align the 4 perimeter crosshair notches over the marked centerpoint ($4.0\text{ in.}$ equidistant between the two punched holes) and the orthogonal baseline.
3. **Engage the Cutter Arm:** Slide Piece 2 over the spindle until the hub is fully seated on the top 608 ball bearing. Verify that the arm bottom is suspended with a uniform **$1.0\text{ mm}$ air gap above the base plate shoulder** (guaranteeing zero plastic sliding friction during rotation).
4. **Execute the Arc Cut:**
   * Hold the base plate firmly down against the vinyl with your non-dominant hand.
   * Grasp the rotating arm, align the blade with the starting punch hole, and rotate smoothly through $180^\circ$ until the blade terminates cleanly in the opposing punch hole.
   * Verify the flap drops cleanly by gravity and hangs flush with zero binding.

---

## 7. Engineering Standards & Quality Gates

Following the standards codified in [`AGENTS.md`](AGENTS.md) and aligned with `carriers` / `Parts-Database`, all 3D print deliverables in this project satisfy:

1. **Mandatory Tooling Invariant (Pure-Python CAD & LookAt Rendering Engine):** All production STL meshes and 4-view drawing sheets are generated deterministically in pure Python (using only standard library modules: `struct`, `math`, `dataclasses`, `pathlib`, with PIL/NumPy for rasterization). External CAD binaries (`openscad`, FreeCAD, Blender) are strictly prohibited.
2. **Four Non-Negotiable Mesh Quality Gates:**
   - **0 Boundary Edges:** 100% closed, watertight 2-manifold solid (no holes, cracks, or open seams).
   - **0 Non-Manifold Edges:** No internal walls, t-junctions, or self-intersecting shells.
   - **0 Degenerate Triangles:** No zero-area triangles or collinear vertices.
   - **100% Finite Coordinates:** Real, finite coordinate values only (no `NaN` or `Inf`).
3. **Mandatory 4-Stage Engineering Lifecycle:** Every iteration strictly follows **Stage 1 (Idea Intake in `IDEAS.md`) $\to$ Stage 2 (Implementation Plan in `Plans/`) $\to$ Stage 3 (Implementation & Verification in `generate_circle_cutter.py`) $\to$ Stage 4 (Structured Git Commit)**.
4. **Machine-Readable Manifest:** [`build/manifest.json`](build/manifest.json) tracks exact dimensions, volumes, estimated PETG print masses, vertical stackups, and topological audit results.
5. **Physical Calibration Before Full Prints:** Rapid pre-print test coupons are generated alongside production parts:
   - `build/circle_cutter_spindle_bore_coupon.stl`: Verifies the 40mm spindle vs 42mm bore slip fit AND 608 inner-race shoulder / pilot post fit (~18 min).
   - `build/circle_cutter_bearing_coupon.stl`: Verifies the roller bearing M5 heat-set insert hole and standoff boss (~10 min).
   - `build/circle_cutter_snap_cap_coupon.stl`: Verifies the 15mm hub sleeve ring snap fit AND 608 outer-race thrust pocket and relief cavity (~18 min).
6. **Caliper Verification Log:** [`PHYSICAL_TEST_NOTES.md`](PHYSICAL_TEST_NOTES.md) documents modeled targets vs physical caliper measurements and HITL observations.
7. **Engineering Enhancement Backlog:** [`IDEAS.md`](IDEAS.md) tracks all candidate features, trade-off analyses, and promotion statuses.

---

## 8. Build Pipeline & Generated Deliverables

Run the pure-Python pipeline from the project directory:

```bash
# Generate all STLs, test coupons, manifest.json, and 4-view engineering drawings
python3 generate_circle_cutter.py
```

### Directory Structure

```
PCHSMB/Circle Cutter/
├── AGENTS.md                                # Subproject engineering & lifecycle standards
├── GEMINI.md / CLAUDE.md                    # Agent adapter files
├── README.md                                # Master build & assembly manual
├── PHYSICAL_TEST_NOTES.md                   # Caliper measurements and test log
├── IDEAS.md                                 # Engineering enhancement backlog
├── Plans/                                   # Codified implementation plans
│   ├── 001-snap-in-hub-top-cap.md           # Plan 001 (Completed v1.3)
│   └── 002-608-bearing-pivot.md             # Plan 002 (Completed v1.4)
├── generate_circle_cutter.py                # Pure-Python parametric CAD & render pipeline
├── circle_cutter_assembly.png               # Pure-Python 3D assembly render
├── circle_cutter_exploded.png               # Pure-Python 3D exploded scene render
├── circle_cutter_base.stl                   # Root production STL (Piece 1)
├── circle_cutter_arm.stl                    # Root production STL (Piece 2)
├── circle_cutter_blade_cap.stl              # Root production STL (Piece 3)
├── circle_cutter_hub_cap.stl                # Root production STL (Piece 4)
└── build/                                   # Standardized build directory
    ├── circle_cutter_base.stl               # Piece 1: Fixed Pivot Base (3mm plate, 608 post)
    ├── circle_cutter_arm.stl                # Piece 2: Rotating Arm (open bore, 625 bearing)
    ├── circle_cutter_blade_cap.stl          # Piece 3: Blade Clamping Cap
    ├── circle_cutter_hub_cap.stl            # Piece 4: Snap Cap with 608 bearing pocket
    ├── circle_cutter_spindle_bore_coupon.stl# Fit coupon: 40mm spindle + 608 post / 42mm bore
    ├── circle_cutter_bearing_coupon.stl     # Fit coupon: 625 bearing M5 mount & boss
    ├── circle_cutter_snap_cap_coupon.stl    # Fit coupon: 15mm hub ring + snap cap with 608 pocket
    ├── manifest.json                        # Parametric manifest & audit digests
    ├── circle_cutter_base_multiview.png     # 4-view drawing: Piece 1 Base
    ├── circle_cutter_arm_multiview.png      # 4-view drawing: Piece 2 Arm
    ├── circle_cutter_blade_cap_multiview.png# 4-view drawing: Piece 3 Blade Cap
    ├── circle_cutter_hub_cap_multiview.png  # 4-view drawing: Piece 4 Snap Cap
    ├── circle_cutter_spindle_bore_coupon_multiview.png # 4-view drawing: Spindle/Bore coupon
    ├── circle_cutter_bearing_coupon_multiview.png   # 4-view drawing: 625 Bearing coupon
    └── circle_cutter_snap_cap_coupon_multiview.png  # 4-view drawing: Snap Cap coupon
```

---

## 9. Visual Engineering Gallery

### Assembly & Exploded Views
| Assembly View | Exploded Alignment View |
|:---:|:---:|
| ![Circle Cutter Assembly](circle_cutter_assembly.png) | ![Circle Cutter Exploded View](circle_cutter_exploded.png) |

### 4-View Engineering Orthographic Sheets (Production Parts)
| Piece 1: Fixed Pivot Base | Piece 2: Rotating Arm Assembly |
|:---:|:---:|
| ![Piece 1 Multi-View](build/circle_cutter_base_multiview.png) | ![Piece 2 Multi-View](build/circle_cutter_arm_multiview.png) |

| Piece 3: Blade Clamping Cap | Piece 4: Snap-in Hub Top Cap |
|:---:|:---:|
| ![Piece 3 Multi-View](build/circle_cutter_blade_cap_multiview.png) | ![Piece 4 Multi-View](build/circle_cutter_hub_cap_multiview.png) |

### Rapid Pre-Print Calibration Coupons
| Spindle / Bore Slip-Fit Coupon | 625 Bearing Mount Coupon | Snap-in Hub Cap Coupon |
|:---:|:---:|:---:|
| ![Spindle Bore Coupon](build/circle_cutter_spindle_bore_coupon_multiview.png) | ![Bearing Mount Coupon](build/circle_cutter_bearing_coupon_multiview.png) | ![Snap Cap Coupon](build/circle_cutter_snap_cap_coupon_multiview.png) |

---

## 10. Design Milestones & Engineering Backlog

### Implemented Milestones
* **v1.3 — Modular Snap-in Hub Top Cap ([Plan 001](Plans/001-snap-in-hub-top-cap.md)):** Converted the hub ceiling into a 4-finger snap-in cap (`circle_cutter_hub_cap.stl`), achieving 100% support-free upright printing with the arm flat on the bed.
* **v1.3 — Side-by-Side Dual Head:** Integrated depth-stop roller bearing and #11 blade mount onto the distal face of Piece 2, locking cut depth to $1.0\text{ mm}$ below the roller plane.
* **v1.4 — Top-Mounted 608 Ball Bearing Thrust Pivot ([Plan 002](Plans/002-608-bearing-pivot.md)):** Integrated standard 608 ball bearing atop center spindle and recalibrated base plate to $3.0\text{ mm}$, suspending the arm with a $1.0\text{ mm}$ air gap and eliminating $707\text{ mm}^2$ of plastic sliding contact.
* **v1.4 — Pure-Python CAD & Headless LookAt 3D Renderer:** 100% pure Python STL and 4-view drawing pipeline (`generate_circle_cutter.py`), permanently retiring external CAD binaries.

### Evaluated & Archived Concepts ([`IDEAS.md`](IDEAS.md))
* **Idea 002: Ergonomic Top Swivel Knob:** Archived. A single 180° sweep by hand provides direct tactile control; an added swivel knob adds unnecessary height, mass, and mechanical play.
* **Idea 003: Tool-Free Captive Quick-Clamp End Cap:** Archived in favor of the standard M3 machine screw clamp. Socket head machine screws into brass heat-set inserts provide maximum clamping rigidity, zero blade flutter, and zero snag points.

### Active Enhancement Queue
* **Idea 005 / [Plan 003](Plans/003-608-front-roller-m5.md): 608 Front Roller Bearing Conversion with M5 Axle Retention:**
  - Harmonize tool bill of materials to a single bearing type (**608**) across both the center pivot and front roller.
  - Widen the Dual Head to accommodate the larger $22\text{ mm}$ OD bearing while preserving $>4\text{ mm}$ clearance to the blade clamp.
  - Retain heavy-duty M5 hardware with reinforced wall thickness to eliminate insert pullout risk under manual pressure.

