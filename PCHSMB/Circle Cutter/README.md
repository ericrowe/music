# PCHSMB Field Prop Circle Cutter

Parametric 3D-printable circle cutter engineered specifically for Pine Creek High School Marching Band (PCHSMB) field prop fabrication. Designed to produce precise, repeatable semicircular wind relief slits ($R = 4.0\text{ in.} = 101.6\text{ mm}$) in heavy-duty printed scrim vinyl for the **2026 Continuum** Sideline Screen Duck Blinds and Rolling Backdrops.

---

### 1. Overview & Mechanical Design

The tool utilizes a concentric 5-piece modular rotating pivot architecture with harmonized 608 ball bearings and integrated thrust suspension:
1. **Fixed Pivot Base (Piece 1):** Centered directly over the marked wind relief location. Four exterior vertical crosshair notches allow precise visual alignment against perpendicular layout lines on the vinyl. The top of the $100\text{ mm}$ center spindle features an integrated $\varnothing 11.5\text{ mm} \times 1.0\text{ mm}$ inner-race shoulder and $\varnothing 7.9\text{ mm} \times 6.0\text{ mm}$ center pilot post that securely captures the inner race of a standard 608 ball bearing.
2. **Rotating Arm Assembly (Piece 2):** Sleeves smoothly over the base spindle with a slip fit ($1.0\text{ mm}$ radial clearance). Features an open through-bore and internal annular retention groove ($Z = 103.5–105.5\text{ mm}$), enabling **100% support-free upright printing** with the $150\text{ mm}$ arm resting flat on the build plate. The arm is suspended at world $Z = 4.0\text{ mm}$, maintaining a **$1.0\text{ mm}$ uniform air gap** above the base plate shoulder, reducing plastic sliding contact area from $707\text{ mm}^2$ to **$0\text{ mm}^2$**. The distal end features an expanded $46\text{ mm}$ Side-by-Side Dual Head housing a standard 608 roller bearing depth stop (with $14\text{ mm}$ head flare, M5 axle centered at $Z = 7.0\text{ mm}$, and $3.9\text{ mm}$ solid PETG floor/ceiling) alongside an X-Acto #11 blade mount with **$6.0\text{ mm}$ air clearance** between outer race and blade clamp. Integrated directly atop the head is an **Ergonomic Cylindrical Domed Push Knob** ($\varnothing 26.0\text{ mm}$ cylinder rising to $Z_{\text{apex}} = 33.0\text{ mm}$, $+19.0\text{ mm}$ above head ceiling) featuring seamless $C^1$ tangent continuity at the hemispherical shoulder and a $4.0\text{ mm}$ front tool clearance shelf.
3. **Blade Clamping Cap (Piece 3):** Clamps over the standard X-Acto #11 blade tang, distributing M3 machine screw retention force evenly to prevent blade flutter, skewing, or rotation under cutting friction.
4. **Snap-in Hub Top Cap (Piece 4):** A separate 4-finger flex collet cap that snaps firmly into the internal retention groove at the top of the hub sleeve. Features an integrated $\varnothing 22.2\text{ mm} \times 3.0\text{ mm}$ outer-race pocket and $\varnothing 18.0\text{ mm} \times 1.5\text{ mm}$ inner relief cavity that captures the top 608 ball bearing. Transmits 100% of downward cutting hand pressure through the rolling elements of the 608 bearing directly into the base spindle, eliminating arm-on-base sliding resistance.
5. **608-to-M5 Reducer Bushing Sleeve (Piece 5):** A precision cylindrical bushing ($\varnothing 7.92\text{ mm OD} \times \varnothing 5.20\text{ mm ID} \times 6.80\text{ mm L}$) with dual $0.4\text{ mm} \times 45^\circ$ chamfers. Adapts the $8.0\text{ mm}$ bore of the 608 depth-stop roller bearing to standard M5 button-head machine screws, allowing inner-race clamping against the arm's $\varnothing 11.5\text{ mm}$ standoff boss with zero radial play and zero shield contact.

```
       [Piece 4: Snap-in Hub Top Cap (608 Outer Race Drive Pocket)]
              +====================+
              | [608 Ball Bearing] |  <-- Transmits 100% downward manual cutting thrust
              |   (8x22x7mm Deep)  |
       [Piece 2: Rotating Hub & 150mm Arm]                    [Domed Push Knob (Z=20-33mm)]
              |   42mm Thru-Bore   |--------------------------[46mm Side-by-Side Dual Head]
              |                    |                                 |       |
              |   Internal Groove  |                            [Piece 5 Sleeve]
              |    (Snap Barbs)    |                            [608 Bearing] [Blade]
              |                    |                            (M5 Axle Z=7)  (M3 Tang)
              +--------------------+                                 |       |
              : 1.0mm Air Gap (0mm² Friction!)                       V       V
       +------+--------------------+------+                      (Rolls) (Cuts 1mm)
       |  Piece 1: Base Plate (Crosshairs)|                          |       |
 ======+==================================+==========================+=======+=== (Vinyl Plane)
```

---

## 2. Component Specifications & Dimensions

| Component | Dimensions ($X \times Y \times Z$) | Material / Infill | Primary Features |
|---|---|---|---|
| **Piece 1: Fixed Pivot Base**<br>[`circle_cutter_base.stl`](circle_cutter_base.stl) | $50.0 \times 50.0 \times 110.0\text{ mm}$ | PETG / 25% Gyroid | • $50\text{ mm}$ OD $\times 3.0\text{ mm}$ H base plate (creates $1.0\text{ mm}$ air gap below arm!)<br>• 4 vertical crosshair notches ($1.0\text{ mm}$ D $\times 1.8\text{ mm}$ W) at $0^\circ, 90^\circ, 180^\circ, 270^\circ$<br>• $40\text{ mm}$ OD $\times 100\text{ mm}$ H center spindle<br>• $\varnothing 11.5\text{ mm} \times 1.0\text{ mm}$ inner-race shoulder<br>• $\varnothing 7.9\text{ mm} \times 6.0\text{ mm}$ center pilot post with $0.8\text{ mm} \times 45^\circ$ chamfer |
| **Piece 2: Rotating Arm Assembly**<br>[`circle_cutter_arm.stl`](circle_cutter_arm.stl) | $201.5 \times 50.0 \times 108.0\text{ mm}$ | PETG / 30% Gyroid / 4 walls | • $50\text{ mm}$ OD hub sleeve with open through-bore<br>• $\varnothing 42\text{ mm}$ ID bore with internal $\varnothing 43.6\text{ mm}$ retention groove ($45^\circ$ self-supporting overhangs)<br>• **100% support-free upright printability** with arm flat on bed ($Z=0$)<br>• Suspended at world $Z=4.0\text{ mm}$ with $1.0\text{ mm}$ air gap above base plate ($0\text{ mm}^2$ sliding friction!)<br>• **Widened Dual Head ($46.0\text{ mm}$ W) & $14.0\text{ mm}$ Flared Height:** Axle centered at $Z_{\text{local}} = 7.0\text{ mm}$ ($Z_{\text{world}} = 11.0\text{ mm}$) with **$3.9\text{ mm}$ solid PETG floor and ceiling** (+333% floor over v1.4!), eliminating pullout risk<br>• **Monolithic Cylindrical Domed Push Knob:** $\varnothing 26.0\text{ mm}$ cylinder centered at $(X=158.0\text{ mm}, Y=0.0\text{ mm})$, straight vertical walls from $Z_{\text{local}} = 14.0\text{ mm}$ to $Z_{\text{shoulder}} = 20.0\text{ mm}$, crowned with an exact $R = 13.0\text{ mm}$ hemispherical dome with $C^1$ tangent continuity rising to $Z_{\text{apex}} = 33.0\text{ mm}$ ($+19.0\text{ mm}$ above head ceiling, $Z_{\text{world}} = 37.0\text{ mm}$); provides smooth ergonomic thumb/palm pressure without localized pressure points; $4.0\text{ mm}$ front clearance shelf preserves 100% open vertical access for blade insertion and horizontal tool access for M5/M3 hex keys<br>• **Bearing Pad ($Y = -11.5\text{ mm}$):** $\varnothing 11.5\text{ mm} \times 1.5\text{ mm}$ standoff boss (inner race contact only) + $\varnothing 6.2\text{ mm} \times 11.0\text{ mm}$ M5 heat-set insert hole; 100% open front-face tool clearance<br>• **Blade Pad ($Y = +11.5\text{ mm}$):** Distal blade pocket ($6.0\text{ mm}$ W) with anti-rotation tabs and M3 heat-set hole; **$6.0\text{ mm}$ air clearance** to 608 outer race<br>• Calibrated $1.0\text{ mm}$ cut depth into vinyl below 608 roller bearing |
| **Piece 3: Blade Clamp Cap**<br>[`circle_cutter_blade_cap.stl`](circle_cutter_blade_cap.stl) | $3.5 \times 12.0 \times 16.0\text{ mm}$ | PETG / 100% Solid | • $12\text{ mm} \times 16\text{ mm} \times 3.5\text{ mm}$ clamping pad<br>• $\varnothing 3.4\text{ mm}$ M3 clearance through-hole<br>• Chamfered outer perimeter for smooth handling |
| **Piece 4: Snap-in Hub Top Cap**<br>[`circle_cutter_hub_cap.stl`](circle_cutter_hub_cap.stl) | $50.0 \times 50.0 \times 9.0\text{ mm}$ | PETG / 100% Solid | • $\varnothing 50\text{ mm} \times 3\text{ mm}$ top flange with $1.5\text{ mm} \times 45^\circ$ chamfer<br>• Integrated $\varnothing 22.2\text{ mm}$ outer-race pocket with $1.0\text{ mm}$ thrust face<br>• Central $\varnothing 18.0\text{ mm} \times 1.5\text{ mm}$ relief cavity (isolates inner race, shield, and post)<br>• 4 cantilever flex collet fingers with $30^\circ$ entry ramp and $45^\circ$ retention barb ($\varnothing 43.0\text{ mm}$)<br>• Tactile audible snap fit; seals bore and carries 100% downward manual pressure |
| **Piece 5: 608-to-M5 Reducer Sleeve**<br>[`circle_cutter_reducer_sleeve.stl`](circle_cutter_reducer_sleeve.stl) | $7.92 \times 7.92 \times 6.80\text{ mm}$ | PETG / 100% Solid | • Precision cylindrical bushing ($\varnothing 7.92\text{ mm OD} \times \varnothing 5.20\text{ mm ID} \times 6.80\text{ mm L}$)<br>• Outer diameter fits standard $8.0\text{ mm}$ 608 bearing bore ($0.08\text{ mm}$ clearance)<br>• Inner bore slips smoothly over M5 screw ($0.20\text{ mm}$ clearance)<br>• $6.80\text{ mm}$ length is $0.20\text{ mm}$ sub-flush to $7.0\text{ mm}$ bearing inner race, ensuring M5 button head clamps inner race without pinching sleeve<br>• Dual $0.4\text{ mm} \times 45^\circ$ chamfers for snag-free bearing insertion |

---

## 3. Hardware Bill of Materials (BOM)

| Item | Specification | Qty | Purpose | Source / Notes |
|---|---|:---:|---|---|
| **Ball Bearings** | 608 Miniature Ball Bearing (608ZZ / 608-2RS) | 2 | 1× Top Thrust Pivot (carries 100% downward manual pressure); 1× Front Roller Depth Stop (rolls on vinyl) | $8\text{ mm}$ ID $\times 22\text{ mm}$ OD $\times 7\text{ mm}$ W (standard skateboard/spool bearing) |
| **Bearing Axle Screw** | M5 $\times 16\text{ mm}$ (or $18\text{ mm}$) Button Head Cap Screw | 1 | Secures 608 depth-stop bearing inner race to arm via Piece 5 reducer sleeve | Stainless steel or black oxide ISO 7380 ($\varnothing 9.5\text{ mm}$ head) |
| **Bearing Insert** | M5 Brass Heat-Set Insert | 1 | Durable machine threads for bearing axle; reinforced by $3.9\text{ mm}$ solid PETG wall/floor | $\varnothing 6.2\text{ mm}$ hole spec; length 6, 8, or 10 mm ($11.0\text{ mm}$ bore depth) |
| **Reducer Sleeve** | 3D Printed PETG Bushing (Piece 5) | 1 | Adapts $8\text{ mm}$ bore of 608 bearing to M5 screw; inner-race clamping without sleeve pinch | $\varnothing 7.92\text{ mm OD} \times \varnothing 5.20\text{ mm ID} \times 6.80\text{ mm L}$ |
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
  * **Piece 5 (608-to-M5 Reducer Sleeve):** Print standing upright on either flat annular face ($Z = 0$). 100% solid infill, concentric wall loops. Zero supports required (~3 min).

---

## 5. Assembly & Setup

1. **Install Heat-Set Inserts:**
   * Heat a soldering iron equipped with a metric heat-set installation tip to **$230^\circ\text{C}–245^\circ\text{C}$** for PETG (or $210^\circ\text{C}$ for PLA).
   * **M3 Blade Insert:** Press square into the $\varnothing 3.8\text{ mm}$ hole on the front face of the **Blade Pad** ($Y = +11.5\text{ mm}$) until flush.
   * **M5 Axle Insert:** Press square into the $\varnothing 6.2\text{ mm}$ hole inside the $\varnothing 11.5\text{ mm}$ standoff boss on the front face of the **Bearing Pad** ($Y = -11.5\text{ mm}$) until flush with the standoff face. The reinforced $3.9\text{ mm}$ solid PETG floor completely prevents thermal blow-through.
   * Allow both inserts to cool undisturbed for at least 2 minutes.
2. **Install 608 Roller Bearing & Reducer Sleeve:**
   * Slide the Piece 5 Reducer Sleeve ($\varnothing 7.92\text{ mm OD} \times 6.80\text{ mm L}$) into the center bore of a 608 ball bearing ($8\text{ mm ID} \times 22\text{ mm OD} \times 7\text{ mm W}$). Notice the sleeve sits $0.20\text{ mm}$ sub-flush to the $7.0\text{ mm}$ steel race.
   * Slide an M5 $\times 16\text{ mm}$ (or $18\text{ mm}$) button head screw through the reducer sleeve. The $\varnothing 9.5\text{ mm}$ screw head clamps the steel inner race directly without pinching the sleeve or contacting the dust shield.
   * Thread the screw straight into the M5 heat-set insert on the bearing pad from the front face (100% open tool clearance with standard Allen key).
   * Tighten firmly. Spin the bearing by hand to verify that the outer race spins freely with zero drag or binding against the integrated $\varnothing 11.5\text{ mm}$ standoff boss.
3. **Install X-Acto Blade & Clamp:**
   * Seat the tang of a fresh #11 X-Acto blade into the vertical $6.0\text{ mm}$ slot on the blade pad ($Y = +11.5\text{ mm}$). Verify the tang is captured between the $0.8\text{ mm}$ raised anti-rotation tabs.
   * Place the Blade Clamping Cap (Piece 3) over the blade tang.
   * Insert the M3 $\times 10\text{ mm}$ screw through the cap and blade slot into the M3 heat-set insert.
   * Tighten with a hex key until the blade is rigidly locked without play.
   * Check blade depth: The blade tip should extend exactly **$1.0\text{ mm}$ below the bottom rolling surface of the 608 bearing**.
4. **Install 608 Thrust Bearing & Snap Cap:**
   * Slide the second 608 bearing onto the $\varnothing 7.9\text{ mm}$ center post on top of the Piece 1 spindle until the inner race seats flush on the $\varnothing 11.5\text{ mm}$ shoulder.
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
   - `build/circle_cutter_bearing_coupon.stl`: Verifies the 608 roller bearing M5 heat-set insert hole, $14\text{ mm}$ head flare, and $\varnothing 11.5\text{ mm}$ standoff boss (~10 min).
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
│   ├── 002-608-bearing-pivot.md             # Plan 002 (Completed v1.4)
│   ├── 003-608-front-roller-m5.md           # Plan 003 (Completed v1.5)
│   ├── 004-raised-push-plate.md             # Plan 004 (Superseded by Plan 005)
│   └── 005-cylindrical-domed-push-knob.md   # Plan 005 (Completed v1.7)
├── generate_circle_cutter.py                # Pure-Python parametric CAD & render pipeline
├── circle_cutter_assembly.png               # Pure-Python 3D assembly render
├── circle_cutter_exploded.png               # Pure-Python 3D exploded scene render
├── circle_cutter_base.stl                   # Root production STL (Piece 1)
├── circle_cutter_arm.stl                    # Root production STL (Piece 2)
├── circle_cutter_blade_cap.stl              # Root production STL (Piece 3)
├── circle_cutter_hub_cap.stl                # Root production STL (Piece 4)
├── circle_cutter_reducer_sleeve.stl         # Root production STL (Piece 5)
└── build/                                   # Standardized build directory
    ├── circle_cutter_base.stl               # Piece 1: Fixed Pivot Base (3mm plate, 608 post)
    ├── circle_cutter_arm.stl                # Piece 2: Rotating Arm (46mm head, 608 roller mount, domed push knob)
    ├── circle_cutter_blade_cap.stl          # Piece 3: Blade Clamping Cap
    ├── circle_cutter_hub_cap.stl            # Piece 4: Snap Cap with 608 bearing pocket
    ├── circle_cutter_reducer_sleeve.stl     # Piece 5: 608-to-M5 Reducer Bushing Sleeve
    ├── circle_cutter_spindle_bore_coupon.stl# Fit coupon: 40mm spindle + 608 post / 42mm bore
    ├── circle_cutter_bearing_coupon.stl     # Fit coupon: 608 bearing M5 mount & 11.5mm boss
    ├── circle_cutter_snap_cap_coupon.stl    # Fit coupon: 15mm hub ring + snap cap with 608 pocket
    ├── manifest.json                        # Parametric manifest & audit digests
    ├── circle_cutter_base_multiview.png     # 4-view drawing: Piece 1 Base
    ├── circle_cutter_arm_multiview.png      # 4-view drawing: Piece 2 Arm
    ├── circle_cutter_blade_cap_multiview.png# 4-view drawing: Piece 3 Blade Cap
    ├── circle_cutter_hub_cap_multiview.png  # 4-view drawing: Piece 4 Snap Cap
    ├── circle_cutter_reducer_sleeve_multiview.png # 4-view drawing: Piece 5 Reducer Sleeve
    ├── circle_cutter_spindle_bore_coupon_multiview.png # 4-view drawing: Spindle/Bore coupon
    ├── circle_cutter_bearing_coupon_multiview.png   # 4-view drawing: 608 Bearing coupon
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

| Piece 3: Blade Clamping Cap | Piece 4: Snap-in Hub Top Cap | Piece 5: 608 Reducer Sleeve |
|:---:|:---:|:---:|
| ![Piece 3 Multi-View](build/circle_cutter_blade_cap_multiview.png) | ![Piece 4 Multi-View](build/circle_cutter_hub_cap_multiview.png) | ![Piece 5 Multi-View](build/circle_cutter_reducer_sleeve_multiview.png) |

### Rapid Pre-Print Calibration Coupons
| Spindle / Bore Slip-Fit Coupon | 608 Bearing Mount Coupon | Snap-in Hub Cap Coupon |
|:---:|:---:|:---:|
| ![Spindle Bore Coupon](build/circle_cutter_spindle_bore_coupon_multiview.png) | ![Bearing Mount Coupon](build/circle_cutter_bearing_coupon_multiview.png) | ![Snap Cap Coupon](build/circle_cutter_snap_cap_coupon_multiview.png) |

---

## 10. Design Milestones & Engineering Backlog

### Implemented Milestones
* **v1.3 — Modular Snap-in Hub Top Cap ([Plan 001](Plans/001-snap-in-hub-top-cap.md)):** Converted the hub ceiling into a 4-finger snap-in cap (`circle_cutter_hub_cap.stl`), achieving 100% support-free upright printing with the arm flat on the bed.
* **v1.3 — Side-by-Side Dual Head:** Integrated depth-stop roller bearing and #11 blade mount onto the distal face of Piece 2, locking cut depth to $1.0\text{ mm}$ below the roller plane.
* **v1.4 — Top-Mounted 608 Ball Bearing Thrust Pivot ([Plan 002](Plans/002-608-bearing-pivot.md)):** Integrated standard 608 ball bearing atop center spindle and recalibrated base plate to $3.0\text{ mm}$, suspending the arm with a $1.0\text{ mm}$ air gap and eliminating $707\text{ mm}^2$ of plastic sliding contact.
* **v1.4 — Pure-Python CAD & Headless LookAt 3D Renderer:** 100% pure Python STL and 4-view drawing pipeline (`generate_circle_cutter.py`), permanently retiring external CAD binaries.
* **v1.5 — 608 Front Roller Bearing & Harmonized Single-Bearing BOM ([Plan 003](Plans/003-608-front-roller-m5.md)):** Converted distal depth-stop roller from 625 to standard 608 ball bearing ($8\times 22\times 7\text{ mm}$), harmonizing the entire tool BOM to a single bearing type across both pivot and roller. Flared head height to $14.0\text{ mm}$ and widened head to $46.0\text{ mm}$, elevating M5 axle to $Z_{\text{local}} = 7.0\text{ mm}$ ($Z_{\text{world}} = 11.0\text{ mm}$) to provide a massive **$3.9\text{ mm}$ solid PETG floor and ceiling** (+333% floor over v1.4) to completely eliminate fastener pullout risk. Engineered Piece 5 608-to-M5 reducer sleeve ($\varnothing 7.92 \times \varnothing 5.20 \times 6.80\text{ mm}$) for precision inner-race clamping without sleeve pinch, preserving $6.0\text{ mm}$ air clearance to blade clamp.
* **v1.6 — Monolithic Ergonomic Raised Push Plate ([Plan 004](Plans/004-raised-push-plate.md)):** Integrated an elevated push plate directly atop the distal dual head on Piece 2 (`circle_cutter_arm.stl`). (Superseded by v1.7 based on HITL user feedback in favor of a cylindrical domed push knob).
* **v1.7 — Monolithic Cylindrical Domed Push Knob ([Plan 005](Plans/005-cylindrical-domed-push-knob.md)):** Replaced the rectangular push plate on Piece 2 (`circle_cutter_arm.stl`) with a monolithic cylindrical push knob with a rounded top dome. Centered at $(X=158.0, Y=0.0\text{ mm})$ between the 608 roller and X-Acto blade mounts, the $\varnothing 26.0\text{ mm}$ post rises with straight vertical cylinder walls to $Z_{\text{shoulder}} = 20.0\text{ mm}$ ($6.0\text{ mm}$ above head ceiling) and transitions with seamless $C^1$ tangent continuity into a hemispherical dome reaching $Z_{\text{apex}} = 33.0\text{ mm}$ ($+19.0\text{ mm}$ above ceiling, $Z_{\text{world}} = 37.0\text{ mm}$). Preserves a $4.0\text{ mm}$ front clearance shelf for unobstructed blade insertion and M5/M3 hex key tool access, with 100% support-free upright 3D printability.

### Evaluated & Archived Concepts ([`IDEAS.md`](IDEAS.md))
* **Idea 002: Ergonomic Top Swivel Knob:** Archived. A single 180° sweep by hand provides direct tactile control; an added swivel knob adds unnecessary height, mass, and mechanical play.
* **Idea 003: Tool-Free Captive Quick-Clamp End Cap:** Archived in favor of the standard M3 machine screw clamp. Socket head machine screws into brass heat-set inserts provide maximum clamping rigidity, zero blade flutter, and zero snag points.
* **Idea 006: Ergonomic Raised Push Plate with Directional Traction Ribs:** Superseded by Idea 007 in v1.7 per HITL user feedback.

### Active Enhancement Queue
*(No pending enhancements currently in queue. All v1.7 engineering requirements are fully implemented and verified.)*

