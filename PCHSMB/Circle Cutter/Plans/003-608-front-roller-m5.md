# Implementation Plan 003: 608 Roller Bearing Front Depth-Stop Conversion with Heavy-Duty M5 Axle Retention

**Project:** PCHSMB Field Prop Circle Cutter  
**Status:** Completed & Verified (v1.5)  
**Target Release:** v1.5  
**Components Affected:**
- Piece 2 (`circle_cutter_arm.stl`) — Widened Dual Head ($46.0\text{ mm}$ W), $14.0\text{ mm}$ head height flare, $Z_{\text{local}} = 7.0\text{ mm}$ axle elevation, $\varnothing 11.5\text{ mm}$ inner-race standoff boss, $\varnothing 6.2\text{ mm} \times 11.0\text{ mm}$ M5 heat-set insert bore
- Hardware Accessory (`circle_cutter_reducer_sleeve.stl`) — Precision 608-to-M5 bushing sleeve ($\varnothing 7.92\text{ mm OD} \times \varnothing 5.20\text{ mm ID} \times 6.80\text{ mm L}$)
- Pre-Print Calibration Coupon (`circle_cutter_bearing_coupon.stl`) — Updated for $46.0\text{ mm}$ head profile, $Z = 7.0\text{ mm}$ axle, $\varnothing 11.5\text{ mm}$ standoff boss, and $\varnothing 6.2\text{ mm}$ M5 insert
- Documentation & Manifest (`README.md`, `PHYSICAL_TEST_NOTES.md`, `generate_circle_cutter.py`, `build/manifest.json`)

---

## 1. Problem Statement & Engineering Rationale

### 1.1 BOM Fragmentation
In the v1.4 design, the circle cutter required two distinct miniature bearing SKUs:
1. Top thrust pivot: 608 ball bearing ($8\text{ mm ID} \times 22\text{ mm OD} \times 7\text{ mm W}$)
2. Front depth-stop roller: 625 miniature ball bearing ($5\text{ mm ID} \times 16\text{ mm OD} \times 5\text{ mm W}$)

Converting the front roller to a standard 608 bearing harmonizes the entire bill of materials to a single, ubiquitous bearing type (standard skateboard / 3D printer spool 608 bearings).

### 1.2 Fastener Pullout Risk & Floor Thickness Limitation
The user explicitly mandated retaining M5 hardware over M3:
> *"M3 heat set nuts will definitely rip out under load. The M5 is still suspect."*

In the v1.4 design, the 625 bearing axle was at $Z_{\text{local}} = 4.0\text{ mm}$. With the $\varnothing 6.2\text{ mm}$ M5 heat-set insert hole (radius $3.1\text{ mm}$), the bottom floor of plastic between the hole and the print bed plane ($Z=0$) was only:
$$\text{Floor Thickness}_{\text{v1.4}} = 4.0\text{ mm} - 3.1\text{ mm} = \mathbf{0.9\text{ mm}}$$
Under downward manual cutting pressure ($F_z = 25–45\text{ N}$), this thin $0.9\text{ mm}$ floor presented a structural failure risk. Furthermore, heat-staking an M5 insert at 230°C into an unreinforced $0.9\text{ mm}$ floor risked thermal blow-through to the build plate surface.

### 1.3 The 608 Geometric Stackup Advantage
A 608 bearing has an outer radius $R = 11.0\text{ mm}$ ($22.0\text{ mm}$ OD).
- Roller contact on vinyl occurs at $Z_{\text{world}} = 0.0\text{ mm}$.
- Axle centerline in world coordinates rises to:
  $$Z_{\text{world, axle}} = Z_{\text{world, contact}} + R_{608} = 0.0 + 11.0 = \mathbf{11.0\text{ mm}}$$
- The rotating arm floats at $Z_{\text{world}} = 4.0\text{ mm}$ ($1.0\text{ mm}$ air gap above the $3.0\text{ mm}$ base plate).
- Therefore, the bearing axle height in arm local coordinates rises to:
  $$Z_{\text{local, axle}} = Z_{\text{world, axle}} - Z_{\text{world, arm\_bot}} = 11.0\text{ mm} - 4.0\text{ mm} = \mathbf{7.0\text{ mm}}$$

By elevating the axle from $4.0\text{ mm}$ to $7.0\text{ mm}$, the bottom floor of plastic below the M5 insert hole expands from $0.9\text{ mm}$ to:
$$\text{Floor Thickness}_{\text{v1.5}} = 7.0\text{ mm} - 3.1\text{ mm} = \mathbf{3.9\text{ mm}} \quad (+333\% \text{ increase!})$$

### 1.4 Vertical Flare to 14.0 mm for Maximum Pullout Resistance
In a standard $12.0\text{ mm}$ beam, an axle at $Z=7.0\text{ mm}$ leaves $12.0 - (7.0 + 3.1) = 1.9\text{ mm}$ of ceiling above the hole. While functional, expanding the beam height locally at the dual head from $12.0\text{ mm}$ to **$14.0\text{ mm}$** ($X \in [135.0, 155.0\text{ mm}]$ with a gentle $5.7^\circ$ upward slope):
- Places the M5 axle at the **exact vertical centerline** of the head ($Z = 7.0\text{ mm} \in [0.0, 14.0\text{ mm}]$).
- Delivers a uniform **$3.9\text{ mm}$ of solid PETG** both above and below the M5 insert!
- Gives an $\varnothing 11.5\text{ mm}$ standoff boss ($R = 5.75\text{ mm}$) a generous $1.25\text{ mm}$ perimeter margin to the outer edges.
- Maintains 100% flat bottom bed contact ($Z=0$) with **zero supports and zero overhangs $> 6^\circ$**.

---

## 2. Geometric Stackup & Clearance Budget

### 2.1 Side-by-Side Dual Head Width & Separation
The 608 bearing has an outer diameter of $22.0\text{ mm}$ ($R = 11.0\text{ mm}$).
- To prevent collision with the Blade Clamping Cap ($12.0\text{ mm}$ wide) and raised blade tabs, the Dual Head width is increased from $36.0\text{ mm}$ to **$46.0\text{ mm}$** ($Y \in [-23.0, +23.0\text{ mm}]$).
- **Bearing Pad Center:** $Y = -11.5\text{ mm}$.
  - 608 bearing outer race spans $Y \in [-22.5\text{ mm}, -0.5\text{ mm}]$.
  - Outer edge margin to arm side ($Y = -23.0\text{ mm}$): $0.5\text{ mm}$.
  - Center divider clearance: Bearing outer race terminates at $Y = -0.5\text{ mm}$, leaving $0.5\text{ mm}$ clearance before the $Y = 0.0$ centerline.
- **Blade Pad Center:** $Y = +11.5\text{ mm}$.
  - Blade tang slot ($6.0\text{ mm}$ wide): $Y \in [+8.5\text{ mm}, +14.5\text{ mm}]$.
  - Blade clamping cap ($12.0\text{ mm}$ wide): $Y \in [+5.5\text{ mm}, +17.5\text{ mm}]$.
  - Outer margin to arm side ($Y = +23.0\text{ mm}$): $23.0 - 17.5 = \mathbf{5.5\text{ mm}}$.
- **Inter-Component Safety Air Gap:**
  $$\text{Clearance} = Y_{\text{cap, min}} - Y_{\text{bearing, max}} = 5.5\text{ mm} - (-0.5\text{ mm}) = \mathbf{6.0\text{ mm}}$$
  A massive $6.0\text{ mm}$ physical air gap isolates the rotating 608 bearing from the stationary blade clamp, guaranteeing zero rubbing or interference under all operational tolerances.

```
                  +=============================================+  Z_head = 14.0 mm
                  |                                             |
                  |     BEARING PAD              BLADE PAD      |
                  |   (Center Y=-11.5)         (Center Y=+11.5) |
                  |                                             |
                  |       +-----+                  +-----+      |
                  |     /         \               | M3  |      |  Z_axle = 7.0 mm
                  |    |  M5 Boss  |              | Clamp|      |  (Exact Center)
                  |     \         /               | Pad |      |
                  |       +-----+                  +-----+      |
                  |                                             |
                  |  [3.9mm Floor]             [3.9mm Floor]    |
                  +=============================================+  Z_bed = 0.0 mm
                  :  <-- 22.0mm --> :  6.0mm   :  <-- 12.0mm -->:
                  Y=-23.0        Y=-0.5  Gap   Y=+5.5        Y=+17.5
```

### 2.2 M5 Axle Fastener & Reducer Sleeve Architecture
To couple an $8.0\text{ mm}$ bearing bore to an M5 screw while completely eliminating radial slop and preventing insert distortion:

1. **Integrated Standoff Boss on Arm:**
   - Diameter: $\varnothing 11.5\text{ mm}$ OD (contacts ONLY the stationary $11.5\text{ mm}$ inner race; clears shields and balls).
   - Length: $1.5\text{ mm}$ standoff proud of the $X = 175.0\text{ mm}$ front face.
   - Hole: $\varnothing 6.2\text{ mm}$ through-bore into the arm body to a total depth of $11.0\text{ mm}$.
   - The M5 brass insert is heat-staked flush with the standoff face directly into the massive solid bulk of the arm.

2. **Dedicated 608-to-M5 Reducer Sleeve (`circle_cutter_reducer_sleeve.stl`):**
   - Outer Diameter: $\varnothing 7.92\text{ mm}$ (slip-fit into $8.00\text{ mm}$ bearing bore, radial clearance $0.04\text{ mm}$).
   - Inner Bore: $\varnothing 5.20\text{ mm}$ (close clearance for M5 screw shank per ISO 273).
   - Length: $6.80\text{ mm}$ ($0.20\text{ mm}$ shorter than $7.00\text{ mm}$ bearing width).
   - Wall Thickness: $(7.92 - 5.20) / 2 = \mathbf{1.36\text{ mm}}$ (over 3 solid perimeter passes at $0.4\text{ mm}$ nozzle).
   - Lead-in Chamfers: $0.4\text{ mm} \times 45^\circ$ on both OD and ID ends.
   - Function: Slips inside the 608 bearing bore. The M5 screw passes through the sleeve. Tightening the M5 screw clamps the bearing inner race directly against the arm standoff boss without bottoming out on the sleeve.

3. **Fastener Clamping:**
   - Standard M5 $\times 16\text{ mm}$ or $18\text{ mm}$ button-head machine screw (ISO 7380).
   - Button-head diameter is $\varnothing 9.5\text{ mm}$ (or an M5 flat washer of $\varnothing 10.0\text{ mm}$).
   - The $\varnothing 9.5–10.0\text{ mm}$ clamping face rests firmly against the $8.0–11.5\text{ mm}$ inner race, completely clearing the rotating dust shield ($\ge \varnothing 12.2\text{ mm}$).

---

## 3. Implementation Tasks

- [x] **Task 1: Update CAD Engine Parameters in `generate_circle_cutter.py`**
  - Increment `VERSION = "1.5"`.
  - Update `BEARING_OD = 22.0`, `BEARING_ID = 8.0`, `BEARING_WIDTH = 7.0`.
  - Update `DUAL_HEAD_WIDTH = 46.0`, `BEARING_PAD_Y = -11.5`, `BLADE_PAD_Y = +11.5`.
  - Update `DUAL_HEAD_HEIGHT = 14.0`, `BEARING_AXLE_LOCAL_Z = 7.0`.
  - Update `BEARING_STANDOFF_OD = 11.5`, `BEARING_STANDOFF_LEN = 1.5`.
- [x] **Task 2: Implement Piece 2 Geometry Modifications**
  - Update arm flare from $X = 135.0$ to $X = 155.0$ to expand in $Y$ ($20 \to 46\text{ mm}$) and $Z$ ($12 \to 14\text{ mm}$).
  - Update distal face boundaries `bnd_blade` and `bnd_bearing` for the $46.0 \times 14.0\text{ mm}$ profile.
  - Update polar-matched boss and hole loops for $(Y = -11.5, Z = 7.0)$ and $(Y = +11.5, Z = 7.0)$.
  - Update raised blade retaining tabs on distal face.
- [x] **Task 3: Implement 608-to-M5 Reducer Sleeve Builder**
  - Author `build_piece5_reducer_sleeve()` function generating watertight 2-manifold cylinder mesh with inner/outer chamfers.
- [x] **Task 4: Update Calibration Test Coupons**
  - Update `build_bearing_mount_coupon()` to test $46\text{ mm}$ head profile, $14\text{ mm}$ height, $Z = 7.0\text{ mm}$ axle, $\varnothing 11.5\text{ mm}$ boss, and $\varnothing 6.2\text{ mm}$ M5 insert.
- [x] **Task 5: Execute Pure-Python Pipeline & Verify Quality Gates**
  - Run `python3 generate_circle_cutter.py`.
  - Verify all STLs pass 4 topological quality gates (0 boundary, 0 non-manifold edges).
  - Verify LookAt multi-view sheets and assembly renders.
- [x] **Task 6: Synchronize Documentation & Commit**
  - Update `README.md`, `PHYSICAL_TEST_NOTES.md`, and `IDEAS.md`.
  - Commit cleanly with structured commit message.

---

## 4. Quality Verification Gates

| Gate | Acceptance Criteria | Measured / Verified | Status |
|---|---|:---:|:---:|
| **Gate 1: Watertight Mesh Integrity** | 0 boundary edges, 0 non-manifold edges, 0 degenerate triangles | 0 boundary, 0 non-manifold across all 8 STLs | **PASS** |
| **Gate 2: Axle Elevation** | Axle at $Z_{\text{world}} = 11.0\text{ mm}$, $Z_{\text{local}} = 7.0\text{ mm}$ | $Z_{\text{world}} = 11.0\text{ mm}$, $Z_{\text{local}} = 7.0\text{ mm}$ | **PASS** |
| **Gate 3: M5 Floor & Wall Margins** | $\ge 3.9\text{ mm}$ solid plastic floor and ceiling around M5 insert hole | Exactly $3.90\text{ mm}$ floor and $3.90\text{ mm}$ ceiling | **PASS** |
| **Gate 4: Dual Head Clearance** | $\ge 6.0\text{ mm}$ air gap between bearing outer race and blade clamp | Exactly $6.00\text{ mm}$ clearance ($Y \in [-0.5, +5.5\text{ mm}]$) | **PASS** |
| **Gate 5: Support-Free Upright Printability** | Overhangs $\le 45^\circ$, flat bottom bed plane at $Z=0$ | Flat bed at $Z=0$, max top slope $5.7^\circ \ll 45^\circ$ | **PASS** |
| **Gate 6: Headless Rendering** | Multi-view sheets and multi-component assembly/exploded renders | All 8 sheets and 2 scenes rendered in pure Python | **PASS** |
