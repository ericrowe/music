# Implementation Plan 004: Ergonomic Raised Push Plate on Distal Arm for Controlled Downward and Rotational Force

**Project:** PCHSMB Field Prop Circle Cutter  
**Status:** Completed & Verified (v1.6)  
**Target Release:** v1.6  
**Components Affected:**
- Piece 2 (`circle_cutter_arm.stl`) — Monolithic raised push plate directly atop dual head ($X \in [136.0, 171.0\text{ mm}]$, $Y \in [-21.0, +21.0\text{ mm}]$, $Z \in [13.0, 26.5\text{ mm}]$)
- Generator & Renderer (`generate_circle_cutter.py`) — `build_push_plate()` module integrated into `build_piece2_arm()`
- Documentation & Verification (`README.md`, `PHYSICAL_TEST_NOTES.md`, `IDEAS.md`, `build/manifest.json`)

---

## 1. Problem Statement & Operational Rationale

### 1.1 Field Operation & Dual-Force Dynamics
When cutting semicircular wind relief slits in heavy scrim vinyl:
1. **Stationary Pivot Force:** The operator's non-dominant hand presses down firmly on Piece 1 / Piece 4 (the top center hub cap) to maintain the center crosshairs over the marked layout point.
2. **Distal Arm Forces:** The operator's dominant hand must simultaneously exert two distinct force vectors at the distal end of Piece 2:
   - **Normal Downward Force ($F_z \approx 25–45\text{ N}$):** Downward pressure directly over the dual head keeps the 608 depth-stop roller bearing in firm, continuous contact with the vinyl sheet, ensuring the #11 blade penetrates to its calibrated $1.0\text{ mm}$ cutting depth without skipping or riding up.
   - **Tangential Sweeping Force ($F_\theta \approx 15–30\text{ N}$):** Tangential force swings the $150\text{ mm}$ arm through the $180^\circ$ arc from the starting punch hole to the terminating punch hole.

### 1.2 Limitations of the v1.5 Flat Head Surface
In the v1.5 design:
- The top surface of the head block is flat at $Z_{\text{local}} = 14.0\text{ mm}$ ($18.0\text{ mm}$ world).
- The operator must press down with their thumb or palm against an untextured, relatively low surface.
- There are no mechanical end stops to prevent the operator's thumb from sliding forward under heavy sweeping force.
- If the thumb slips forward, it risks contacting the clamping screw, blade tang, or the rotating outer race of the 608 bearing.

### 1.3 Proposed Solution: Monolithic Raised Push Plate
Integrating an elevated push plate directly into the top of Piece 2 solves all operational limitations:
- **Ergonomic Elevation:** Rises $10.0\text{ mm}$ above the head ceiling to $Z = 24.0\text{ mm}$ ($+12.0\text{ mm}$ above the $12\text{ mm}$ main arm beam), providing a prominent, comfortable resting pad for the thumb or palm heel with improved mechanical leverage.
- **Generous Push Surface:** Spans $35.0\text{ mm}$ longitudinally ($X \in [136.0, 171.0\text{ mm}]$) and $42.0\text{ mm}$ transversely ($Y \in [-21.0, +21.0\text{ mm}]$), centered directly above the bearing axle and blade tang.
- **Forward Safety Fence:** A raised lip at $X \in [167.0, 171.0\text{ mm}]$ rising to $Z = 26.5\text{ mm}$ ($2.5\text{ mm}$ above the platform) acts as an impassable positive mechanical stop, preventing any forward hand or thumb slippage toward the blade or roller.
- **Transverse Grip Traction Ribs:** Four transverse ridges ($1.2\text{ mm}$ proud at $Z = 25.2\text{ mm}$ with $45^\circ$ self-supporting flanks) provide high-friction mechanical grip against tangential sweeping forces in both rotational directions.
- **Tool Clearance Shelf:** The plate terminates at $X = 171.0\text{ mm}$, leaving a $4.0\text{ mm}$ open clearance shelf in front of the distal face ($X = 175.0\text{ mm}$). This preserves 100% unobstructed vertical access for blade insertion, blade clamp installation, and front hex key access to the M5 axle screw and M3 clamp screw.
- **100% Support-Free:** All overhang angles relative to vertical are $\le 45^\circ$, preserving 100% support-free upright printing with the arm flat on the bed.

---

## 2. Geometric Budget & Stackup Analysis

### 2.1 Coordinate Alignment (Piece 2 Local Frame)
- **Base Plane:** $Z = 0.0\text{ mm}$ (print bed plane, arm bottom at $Z = 4.0\text{ mm}$ world).
- **Arm Beam Top:** $Z = 12.0\text{ mm}$ ($X \in [22.0, 135.0\text{ mm}]$).
- **Dual Head Ceiling:** $Z = 14.0\text{ mm}$ ($X \in [155.0, 175.0\text{ mm}]$).
- **Plate Anchor Base:** $Z = 13.0\text{ mm}$ (submerged $1.0\text{ mm}$ inside the solid $14.0\text{ mm}$ head ceiling for robust fused layer bonding).
- **Main Push Platform:** $Z = 24.0\text{ mm}$ ($+10.0\text{ mm}$ above head ceiling).
- **Traction Rib Crests:** $Z = 25.2\text{ mm}$ ($+1.2\text{ mm}$ above platform).
- **Front Safety Stop Crest:** $Z = 26.5\text{ mm}$ ($+2.5\text{ mm}$ above platform, $+12.5\text{ mm}$ above head ceiling).

### 2.2 Longitudinal Stations ($X$-Axis)
The push plate geometry is defined by 18 transverse cross-sectional stations along $X$:

| Station | $X$ Coordinate (mm) | $Z_{\text{top}}$ (mm) | Description / Feature | Overhang / Slope |
|:---:|:---:|:---:|---|:---:|
| 0 | 136.0 | 14.0 | Rear anchor point on head flare | $0^\circ$ (flush with ceiling) |
| 1 | 146.0 | 24.0 | Rear lead-in ramp crest | $45.0^\circ$ lead-in ramp |
| 2 | 149.0 | 24.0 | Platform flat before Ridge 1 | Horizontal ($0^\circ$) |
| 3 | 150.5 | 25.2 | Ridge 1 crest | $38.7^\circ$ ramp up |
| 4 | 152.0 | 24.0 | Ridge 1 trough | $38.7^\circ$ ramp down |
| 5 | 154.5 | 24.0 | Platform flat before Ridge 2 | Horizontal ($0^\circ$) |
| 6 | 156.0 | 25.2 | Ridge 2 crest (head center) | $38.7^\circ$ ramp up |
| 7 | 157.5 | 24.0 | Ridge 2 trough | $38.7^\circ$ ramp down |
| 8 | 160.0 | 24.0 | Platform flat before Ridge 3 | Horizontal ($0^\circ$) |
| 9 | 161.5 | 25.2 | Ridge 3 crest | $38.7^\circ$ ramp up |
| 10 | 163.0 | 24.0 | Ridge 3 trough | $38.7^\circ$ ramp down |
| 11 | 165.5 | 24.0 | Platform flat before Ridge 4 | Horizontal ($0^\circ$) |
| 12 | 167.0 | 25.2 | Ridge 4 crest | $38.7^\circ$ ramp up |
| 13 | 168.0 | 24.0 | Ridge 4 trough / Safety ramp foot | $50.2^\circ$ ramp down |
| 14 | 169.5 | 26.5 | Front safety stop lip crest | $59.0^\circ$ ramp up ($31^\circ$ from vert) |
| 15 | 170.5 | 26.5 | Front safety stop flat summit | Horizontal ($0^\circ$) |
| 16 | 171.0 | 25.5 | Front bevel chamfer | $45.0^\circ$ chamfer |
| 17 | 171.0 | 14.0 | Front vertical termination wall | $0^\circ$ vertical face |

### 2.3 Transverse Profile ($Y$-Axis)
- **Total Plate Width:** $42.0\text{ mm}$ ($Y \in [-21.0, +21.0\text{ mm}]$).
- **Dual Head Width:** $46.0\text{ mm}$ ($Y \in [-23.0, +23.0\text{ mm}]$).
- **Lateral Margins:** $2.0\text{ mm}$ shoulder on both left and right sides of the head.
- **Side Chamfers:** $1.5\text{ mm} \times 45^\circ$ bevel on left and right upper edges.
- Each station loop consists of 6 vertices in CCW order around the centroid:
  1. $(-21.0, 13.0)$ — Bottom-left anchor
  2. $(+21.0, 13.0)$ — Bottom-right anchor
  3. $(+21.0, Z_{\text{top}} - 1.5)$ — Right side wall
  4. $(+19.5, Z_{\text{top}})$ — Right top chamfer
  5. $(-19.5, Z_{\text{top}})$ — Left top chamfer
  6. $(-21.0, Z_{\text{top}} - 1.5)$ — Left side wall

### 2.4 Front Tool Clearance Budget
- Distal face of arm: $X = 175.0\text{ mm}$.
- Front wall of push plate: $X = 171.0\text{ mm}$.
- Clearance gap: $175.0 - 171.0 = \mathbf{4.0\text{ mm}}$.
- **Blade Tang Clearance:** Standard #11 blade tang slot is at $X = 175.0\text{ mm}$. The $4.0\text{ mm}$ setback leaves completely unobstructed vertical space to insert or remove blades from above.
- **Blade Clamping Cap Clearance:** Piece 3 extends from $X = 175.8\text{ mm}$ to $179.3\text{ mm}$, rising to $Z = 15.0\text{ mm}$. The $4.0\text{ mm}$ setback guarantees zero collision with the blade clamp cap.
- **Fastener Access:** M5 axle screw and M3 blade clamp screw are driven horizontally along the $-X$ vector with standard Allen keys. The push plate is elevated well above ($Z \ge 14.0\text{ mm}$) the screw axes ($Z = 7.0\text{ mm}$), ensuring 100% open tool clearance.

---

## 3. Implementation Tasks

1. **CAD Engine Enhancement (`generate_circle_cutter.py`):**
   - Add push plate geometric constants: `PUSH_PLATE_START_X = 136.0`, `PUSH_PLATE_END_X = 171.0`, `PUSH_PLATE_WIDTH = 42.0`, `PUSH_PLATE_HEIGHT = 24.0`, `PUSH_PLATE_SAFETY_LIP_Z = 26.5`, `PUSH_PLATE_BASE_Z = 13.0`.
   - Implement `build_push_plate() -> Mesh` generating a closed, watertight 2-manifold solid with end caps and quad-strip side walls.
   - Integrate `push_plate` into `build_piece2_arm()` via `m.extend(push_plate)`.
   - Update 3D scene rendering pipeline and manifest generator.
2. **Topological Mesh Verification:**
   - Execute `python3 generate_circle_cutter.py`.
   - Audit all 8 STL deliverables to confirm:
     - 0 boundary edges
     - 0 non-manifold edges
     - 0 degenerate triangles
     - 100% finite coordinates
   - Confirm 3D assembly and exploded scene renders reflect the new push plate.
3. **Documentation & Calibration Logs:**
   - Update `PHYSICAL_TEST_NOTES.md` with push plate caliper inspection dimensions ($Z_{\text{plate}} = 24.0\text{ mm}$, $Z_{\text{lip}} = 26.5\text{ mm}$, width $42.0\text{ mm}$).
   - Update `README.md` (Sections 1, 2, 8, 9, 10) documenting the v1.6 push plate.
   - Mark Idea 006 in `IDEAS.md` and Plan 004 as `Completed & Verified`.
4. **Structured Git Commit:**
   - Commit all v1.6 artifacts with conventional commit message.

---

## 4. Quality Verification Gates

| Verification Gate | Target Value / Criteria | Verification Method |
|---|---|---|
| **Piece 2 Watertight Solid** | 0 boundary edges, 0 non-manifold edges | Python topological audit (`Mesh.audit()`) |
| **Push Plate Width** | $42.0\text{ mm}$ ($Y \in [-21.0, +21.0\text{ mm}]$) | Mesh vertex bounds check |
| **Push Platform Height** | $24.0\text{ mm}$ local ($28.0\text{ mm}$ world) | Mesh vertex bounds check |
| **Safety Fence Height** | $26.5\text{ mm}$ local ($30.5\text{ mm}$ world) | Mesh vertex bounds check |
| **Front Clearance Gap** | $\ge 4.0\text{ mm}$ to distal face ($X = 175.0\text{ mm}$) | Geometric coordinate verification |
| **Overhang Angle** | $\le 45.0^\circ$ relative to vertical ($Z$) | Slope geometry check (zero supports needed) |
| **Tool Clearance** | 100% unobstructed horizontal access to M5 and M3 screws | Alignment analysis |
| **3D Render Alignment** | Multi-view sheets and assembly scenes accurately reflect push plate | Headless LookAt render inspection |
