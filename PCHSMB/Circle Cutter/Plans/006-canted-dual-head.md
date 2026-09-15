# Implementation Plan 006: Canted Dual Head (Chevron Face) for Pure Tangential Blade Tracking & 608 Roller Alignment

**Project:** PCHSMB Field Prop Circle Cutter  
**Status:** Completed & Verified (v1.8)  
**Target Release:** v1.8  
**Components Affected:**
- Piece 2 (`circle_cutter_arm.stl`) — Canted dual head with $\pm 3.76^\circ$ chevron face, canted boss, and canted fastener bores
- Piece 3 (`circle_cutter_blade_cap.stl`) — Blade clamping cap matching canted blade pad
- Calibration Coupon (`circle_cutter_bearing_coupon.stl`) — Canted 608 bearing mount coupon
- Generator & Renderer (`generate_circle_cutter.py`) — Pure-Python parametric CAD & LookAt scene renderer
- Documentation & Verification (`README.md`, `PHYSICAL_TEST_NOTES.md`, `IDEAS.md`, `build/manifest.json`)

---

## 1. Problem Statement & Kinematic Rationale

In v1.3 through v1.7, the distal head front face of Piece 2 was modeled as a single flat plane perpendicular to the arm's longitudinal $X$-axis ($X = 175.0\text{ mm}$).

### The $3.76^\circ$ Tracking Error
Because the dual head places the X-Acto #11 blade at $Y = +11.5\text{ mm}$ and the 608 roller bearing at $Y = -11.5\text{ mm}$, their position vectors from the rotation center $(0, 0)$ are not parallel to the $X$-axis:
$$\alpha = \arctan\left(\frac{11.5\text{ mm}}{175.0\text{ mm}}\right) \approx 0.06562\text{ rad} = \mathbf{3.7607^\circ}$$

1. **Blade Tracking Error:**
   - The blade's instantaneous velocity vector points at an angle of $90^\circ + 3.7607^\circ = 93.7607^\circ$ relative to the $+X$ axis.
   - When mounted flat against a $90.0^\circ$ face, the razor blade operates with an unavoidable **$3.76^\circ$ yaw angle**, causing its flat steel flank to drag against the cut kerf, increasing friction and tearing woven scrim fibers.
2. **Roller Bearing Scrubbing Error:**
   - The 608 roller bearing's instantaneous velocity vector points at $90^\circ - 3.7607^\circ = 86.2393^\circ$.
   - With an axle pointing purely along $+X$ ($0.0^\circ$), the bearing's wheel plane is misaligned by **$3.76^\circ$** with its rolling arc, causing the steel outer race to scrub laterally against the vinyl banner.

### The Solution: Symmetric Canted Chevron Dual Head
Cant both mounting pads by their exact respective radial angles:
* **Blade Pad:** Canted by **$+3.7607^\circ$**, making the blade face **identically tangent ($0.00^\circ$ yaw)** to the cut path.
* **Bearing Pad:** Canted by **$-3.7607^\circ$**, making the 608 bearing axle point **identically radial ($0.00^\circ$ axle scrub)** toward the center of rotation.

---

## 2. Mathematical Modeling of the Chevron Face

### 2.1 Coordinate Reference & Normal Vectors
Let the rotation center be $(X, Y) = (0.0, 0.0)$, and let the reference anchor points for the blade and bearing pads be:
* Blade reference center: $(X_0, Y_0) = (175.0, +11.5)\text{ mm}$
* Bearing reference center: $(X_0, Y_0) = (175.0, -11.5)\text{ mm}$
* Cant angle: $\theta = \arctan(11.5 / 175.0) \approx 3.7607^\circ$

The outward normal unit vectors for each pad are:
$$\vec{n}_{\text{blade}} = (\cos(+\theta), \sin(+\theta), 0.0) = (0.99785, +0.06558, 0.0)$$
$$\vec{n}_{\text{bearing}} = (\cos(-\theta), \sin(-\theta), 0.0) = (0.99785, -0.06558, 0.0)$$

### 2.2 Plane Equations & Seamless Centerline Junction
For any point $(Y, Z)$ on the front face:
1. **Blade Pad Plane ($Y \in [0.0, +23.0\text{ mm}]$):**
   $$(X - 175.0) \cos(+\theta) + (Y - 11.5) \sin(+\theta) = 0$$
   $$X(Y) = 175.0 - (Y - 11.5) \tan(+\theta) = 175.0 - (Y - 11.5) \cdot \frac{11.5}{175.0}$$
2. **Bearing Pad Plane ($Y \in [-23.0, 0.0\text{ mm}]$):**
   $$(X - 175.0) \cos(-\theta) + (Y - (-11.5)) \sin(-\theta) = 0$$
   $$X(Y) = 175.0 + (Y + 11.5) \tan(+\theta) = 175.0 + (Y + 11.5) \cdot \frac{11.5}{175.0}$$

### 2.3 Boundary Vertex Coordinates
* **At Centerline ($Y = 0.0\text{ mm}$):**
  $$X_{\text{blade}}(0.0) = 175.0 + \frac{11.5^2}{175.0} = 175.0 + 0.7557 = \mathbf{175.7557\text{ mm}}$$
  $$X_{\text{bearing}}(0.0) = 175.0 + \frac{11.5^2}{175.0} = 175.0 + 0.7557 = \mathbf{175.7557\text{ mm}}$$
  **The two planes intersect seamlessly with 0.00 mm gap at $Y = 0.0\text{ mm}$!**
* **At Pad Centers ($Y = \pm 11.5\text{ mm}$):**
  $$X(\pm 11.5) = \mathbf{175.0000\text{ mm}}$$
* **At Outer Corners ($Y = \pm 23.0\text{ mm}$):**
  $$X(\pm 23.0) = 175.0 - 11.5 \cdot \frac{11.5}{175.0} = 175.0 - 0.7557 = \mathbf{174.2443\text{ mm}}$$

The chevron forms a shallow $1.51\text{ mm}$ forward point at the centerline with a total included angle of $180^\circ - 2(3.76^\circ) = 172.48^\circ$.

---

## 3. Detailed Component Geometry Stackup

### 3.1 Piece 2: Rotating Arm Assembly (`circle_cutter_arm.stl`)
1. **Loft to Chevron Face:**
   - The head sidewalls and top/bottom chamfers terminate on the canted planes $X(Y)$.
2. **Bearing Standoff Boss & M5 Insert Hole:**
   - Center at $(X, Y) = (175.0, -11.5)\text{ mm}$, $Z_{\text{local}} = 7.0\text{ mm}$.
   - Standoff boss extends outward along $\vec{n}_{\text{bearing}}$ by $L = 1.5\text{ mm}$.
   - M5 hole bores inward along $-\vec{n}_{\text{bearing}}$ by $D = 11.0\text{ mm}$.
   - Annular standoff rim sits in a plane perpendicular to $\vec{n}_{\text{bearing}}$, guaranteeing the 608 bearing inner race clamps with zero tilt.
3. **Blade Slot, Retaining Tabs, & M3 Insert Hole:**
   - Center at $(X, Y) = (175.0, +11.5)\text{ mm}$, $Z_{\text{local}} = 7.0\text{ mm}$.
   - M3 hole bores inward along $-\vec{n}_{\text{blade}}$ by $D = 10.5\text{ mm}$.
   - Anti-rotation tabs and $6.0\text{ mm}$ blade slot extend outward along $\vec{n}_{\text{blade}}$ by $0.8\text{ mm}$.
4. **Push Knob Clearance:**
   - Push knob apex at $(X=158.0, Y=0.0\text{ mm})$, $R = 13.0\text{ mm}$.
   - Front clearance shelf: $175.76 - 171.0 = \mathbf{4.76\text{ mm}}$ at centerline, $\mathbf{4.00\text{ mm}}$ at blade pad. Tool access is 100% preserved.

### 3.2 Piece 3: Blade Clamping Cap (`circle_cutter_blade_cap.stl`)
- Clamping plate ($12.0 \times 16.0 \times 3.5\text{ mm}$) seats flush against the $+3.76^\circ$ blade pad.
- M3 clearance through-hole ($\varnothing 3.4\text{ mm}$) aligns coaxially with the canted M3 insert.

---

## 4. Quality Verification Gates

| Gate | Target Criteria | Verification Method |
|---|---|---|
| **Topological Manifold Integrity** | 0 boundary edges, 0 non-manifold edges on all STLs | `Mesh.audit()` in pure Python |
| **Blade Yaw Angle** | $\mathbf{0.00^\circ}$ relative to cut circle | Analytical surface normal check |
| **Roller Axle Angle** | $\mathbf{0.00^\circ}$ relative to radial vector | Analytical axis check |
| **Centerline Junction Gap** | $\mathbf{0.00\text{ mm}}$ seamless continuity at $Y = 0$ | Shared vertex check |
| **Support-Free Printability** | Zero supports required; all overhangs $\le 45^\circ$ | Slicer check (upright on bed) |
| **Tool Clearance** | $\ge 4.0\text{ mm}$ shelf before push knob | Distance check |

---

## 5. Implementation Steps
1. Update `generate_circle_cutter.py` with canted trigonometry and chevron face meshing for Piece 2, Piece 3, and bearing coupon.
2. Execute pure-Python generation and verify all 8 STLs pass 100% watertight manifold audits.
3. Synchronize `PHYSICAL_TEST_NOTES.md`, `README.md`, `IDEAS.md`, and `build/manifest.json`.
4. Stage 4 structured Git commit.
