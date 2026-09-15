# Implementation Plan 005: Cylindrical Domed Push Post / Knob on Distal Arm

**Project:** PCHSMB Field Prop Circle Cutter  
**Status:** Completed & Verified (v1.7)  
**Target Release:** v1.7  
**Components Affected:**
- Piece 2 (`circle_cutter_arm.stl`) — Monolithic vertical cylinder with rounded top dome centered on dual head
- Generator & Renderer (`generate_circle_cutter.py`) — `build_domed_push_post()` module replacing `build_push_plate()` in `build_piece2_arm()`
- Documentation & Verification (`README.md`, `PHYSICAL_TEST_NOTES.md`, `IDEAS.md`, `build/manifest.json`)

---

## 1. Problem Statement & User Directive

Following user feedback on the v1.6 rectangular push plate:
> *"Nope. Lets try just making it a cylinder with a rounded top"*

The complex rectangular push plate (with directional transverse traction ridges, front fence, and rear ramps) is completely replaced with a clean, minimalist vertical cylinder crowned with a smooth hemispherical dome.

### Operational Advantages of a Domed Cylinder
1. **Omnidirectional Ergonomics:** The circular cross-section and smooth spherical dome provide an identical, comfortable tactile surface regardless of hand orientation, attack angle, or rotational position along the $180^\circ$ cut arc.
2. **Minimalist Aesthetic:** Perfectly complements the concentric cylindrical hub and spindle design language of the circle cutter.
3. **Palm Heel or Thumb Rest:** The rounded dome fits smoothly into the palm heel or under the thumb, allowing effortless application of downward normal force ($F_z$) onto the 608 depth-stop roller bearing.
4. **Clean Printability:** Concentric circular perimeters and inward-sloping dome layers require **zero supports** and achieve superior surface finish on any 3D printer.

---

## 2. Geometric Budget & Stackup Analysis

### 2.1 Centerline & Radius
- **Centerline Coordinates:** $(X_c, Y_c) = (158.0\text{ mm}, 0.0\text{ mm})$.
  - Placed dead-center along $Y = 0.0\text{ mm}$, exactly equidistant between the 608 depth-stop roller ($Y = -11.5\text{ mm}$) and the X-Acto blade ($Y = +11.5\text{ mm}$).
- **Cylinder Diameter:** $\varnothing 26.0\text{ mm}$ ($R = 13.0\text{ mm}$).
- **Clearance to Distal Face:**
  - Distal front face of arm: $X = 175.0\text{ mm}$.
  - Frontmost point of cylinder: $X_c + R = 158.0 + 13.0 = \mathbf{171.0\text{ mm}}$.
  - Front clearance shelf: $175.0 - 171.0 = \mathbf{4.0\text{ mm}}$.
  - Preserves 100% open vertical clearance for #11 blade insertion and horizontal tool clearance for M5 and M3 hex keys.
- **Arm Body Margins:**
  - Dual head width: $46.0\text{ mm}$ ($Y \in [-23.0, +23.0\text{ mm}]$).
  - Lateral margins: $(46.0 - 26.0) / 2 = \mathbf{10.0\text{ mm}}$ on both left and right sides.
  - Rearmost point of cylinder: $X_c - R = 158.0 - 13.0 = \mathbf{145.0\text{ mm}}$.
  - At $X = 145.0\text{ mm}$, the head flare width is $33.0\text{ mm} > 26.0\text{ mm}$, guaranteeing the cylinder footprint is 100% solid-backed by the arm beam.

### 2.2 Vertical Profile ($Z$-Axis)
- **Base Anchor Plane:** $Z_{\text{base}} = 13.0\text{ mm}$ (embeds $1.0\text{ mm}$ below the solid $14.0\text{ mm}$ head ceiling for fused layer bonding).
- **Head Ceiling Plane:** $Z_{\text{head}} = 14.0\text{ mm}$.
- **Cylinder Shoulder Plane:** $Z_{\text{shoulder}} = 20.0\text{ mm}$ ($6.0\text{ mm}$ straight vertical wall proud above head).
- **Hemispherical Dome:**
  - Dome radius: $R_{\text{dome}} = 13.0\text{ mm}$.
  - Latitude parameter: $\phi \in [0, \pi/2]$.
  - Radius at height: $r(\phi) = R \cos \phi$.
  - Elevation: $z(\phi) = Z_{\text{shoulder}} + R \sin \phi$.
  - Equator ($\phi = 0$): $r = 13.0\text{ mm}, z = 20.0\text{ mm}$ with vertical slope ($dz/dr = \infty$), matching the cylinder wall with exact $C^1$ tangent continuity.
  - Apex ($\phi = \pi/2$): $r = 0.0\text{ mm}, z = 20.0 + 13.0 = \mathbf{33.0\text{ mm}}$ with horizontal slope ($dz/dr = 0$).
- **Total Height Above Head:** $33.0 - 14.0 = \mathbf{19.0\text{ mm}}$ ($\sim 3/4\text{ in.}$).
- **World Apex Elevation:** $33.0 + 4.0 = \mathbf{37.0\text{ mm}}$ world $Z$.

---

## 3. Implementation Tasks

1. **CAD Engine Enhancement (`generate_circle_cutter.py`):**
   - Replace push plate constants with:
     ```python
     PUSH_POST_X = 158.0
     PUSH_POST_Y = 0.0
     PUSH_POST_RADIUS = 13.0
     PUSH_POST_BASE_Z = 13.0
     PUSH_POST_SHOULDER_Z = 20.0
     PUSH_POST_DOME_RADIUS = 13.0
     PUSH_POST_APEX_Z = 33.0
     ```
   - Implement `build_domed_push_post(xc, yc, r, z_base, z_sh, n_theta=32, n_phi=16) -> Mesh`:
     - Base ring at $Z_{\text{base}}$ with normal $-Z$.
     - Vertical cylinder quad walls from $Z_{\text{base}}$ to $Z_{\text{shoulder}}$.
     - Latitude quad rings on hemispherical dome from $\phi = 0$ to $\phi = \pi/2$.
     - Triangle fan at apex.
   - Integrate `push_post` into `build_piece2_arm()` via `m.extend(push_post)`.
   - Update `VERSION = "1.7"`, scene rendering titles, and `generate_manifest()`.
2. **Topological Mesh Verification:**
   - Run `python3 generate_circle_cutter.py`.
   - Confirm all 8 STLs pass all quality gates (0 boundary, 0 non-manifold edges, 0 degenerate triangles).
3. **Documentation & Calibration Logs:**
   - Update `PHYSICAL_TEST_NOTES.md` with domed cylinder caliper dimensions ($\varnothing 26.0\text{ mm}$, shoulder $Z = 20.0\text{ mm}$, apex $Z = 33.0\text{ mm}$).
   - Update `README.md` (Sections 1, 2, 8, 9, 10).
   - Mark Idea 007 and Plan 005 as `Completed & Verified`.
4. **Structured Git Commit:**
   - Conventional commit: `feat(circle-cutter): replace rectangular push plate with cylindrical domed push knob`.

---

## 4. Quality Verification Gates

| Verification Gate | Target Value / Criteria | Verification Method |
|---|---|---|
| **Piece 2 Watertight Solid** | 0 boundary edges, 0 non-manifold edges | Python topological audit (`Mesh.audit()`) |
| **Cylinder Outer Diameter** | $26.00\text{ mm}$ ($\pm 0.05\text{ mm}$) | Caliper target check |
| **Cylinder Shoulder Height** | $20.00\text{ mm}$ local ($24.00\text{ mm}$ world) | Caliper target check |
| **Dome Apex Height** | $33.00\text{ mm}$ local ($37.00\text{ mm}$ world) | Caliper target check |
| **Front Clearance Gap** | $4.00\text{ mm}$ to distal face ($X = 175.0\text{ mm}$) | Coordinate check |
| **C1 Tangent Continuity** | Smooth equator transition, 0 crease edges | Analytical derivative check |
| **Support-Free Printability** | 0 supports required, inward dome layers | Slice geometry check |
