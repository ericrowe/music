# Plan 009: Full-Width End Cap with Bearing Clearance & Single M3 Blade Screw Retention (v2.1)

## 1. Executive Summary & Problem Statement

In v2.0, Human-in-the-Loop review identified a critical geometric interference:
1. **Bearing Collision:** Piece 3 (the blade safety cowl) had an outer radius of $18.0\text{ mm}$ centered at $Y = +11.5\text{ mm}$, extending toward the bearing to $Y = -6.5\text{ mm}$. The 608 roller bearing ($R = 11.0\text{ mm}$) centered at $Y = -11.5\text{ mm}$ extended to $Y = -0.5\text{ mm}$, causing a **$6.0\text{ mm}$ direct interference** between the cowl and bearing.
2. **Blade vs. Bearing Proximity:** The axle spacing of $23.0\text{ mm}$ was inherited from the narrow X-Acto #11 blade. With a 28mm rotary blade ($R = 14.0\text{ mm}$) and 608 roller bearing ($R = 11.0\text{ mm}$), the sum of radii is $25.0\text{ mm}$, creating a **$2.0\text{ mm}$ planar overlap** ($1.32\text{ mm}$ 3D collision) even without any cowl.
3. **User Architectural Directive:** *"The screw for the end cap should only attach through the blade though, while providing clearance for the bearing."*

---

## 2. Engineering Architecture & Geometric Stackup (v2.1)

### 2.1 Standardized Cutting & Rolling Geometry
- **Standardized Radius:** $R = 101.6\text{ mm}$ ($4.0\text{ in.}$) exact, cutting $8.0\text{ in.}$ chord semicircular wind relief flaps.
- **Widened Axle Spacing:**
  - Blade axle: $Y_{\text{blade}} = \mathbf{+16.0\text{ mm}}$, $Z_{\text{local}} = 9.5\text{ mm}$ ($Z_{\text{world}} = 13.5\text{ mm}$).
  - Bearing axle: $Y_{\text{bearing}} = \mathbf{-16.0\text{ mm}}$, $Z_{\text{local}} = 7.0\text{ mm}$ ($Z_{\text{world}} = 11.0\text{ mm}$).
  - Center-to-center distance: $\mathbf{32.0\text{ mm}}$ (widened from $23.0\text{ mm}$).
  - Circumferential clear gap between blade and bearing: $32.0 - (14.0 + 11.0) = \mathbf{7.00\text{ mm}}$!
- **Distal Axle Plane:**
  - $X_{\text{distal}} = \sqrt{101.6^2 - 16.0^2} = \mathbf{100.3322\text{ mm}}$.
- **Cant Angle:**
  - $\theta_{\text{cant}} = \arcsin(16.0 / 101.6) = 0.158140\text{ rad} = \mathbf{9.0607^\circ}$.
  - Chevron center vertex at $Y = 0.0$: $X_{\text{vertex}} = 100.3322 + 16.0 \times \tan(9.0607^\circ) = \mathbf{102.8838\text{ mm}}$.
- **Dual Head Width:**
  - Width widened to **$64.0\text{ mm}$** ($Y \in [-32.0, +32.0]$) to cleanly encompass both stations and cap walls.
  - Height maintained at **$28.0\text{ mm}$** ($Z \in [0, 28]$).

### 2.2 Piece 3: Full-Width End Cap Design
- **Single M3 Fastener Attachment:**
  - Clamped solely through the 28mm blade bore by the uxcell $\varnothing 4.0\text{ mm} \times 10.0\text{ mm}$ M3 shoulder bolt into the arm's blade boss M3 heat-set insert.
  - Counterbore: $\varnothing 7.8\text{ mm} \times 3.0\text{ mm}$ deep.
  - Through-bore: $\varnothing 4.2\text{ mm} \times 9.20\text{ mm}$ length.
  - Shoulder protrusion: $10.0 - 9.20 = 0.80\text{ mm}$, providing exact **$0.45\text{ mm}$ axial running float** for the $0.35\text{ mm}$ blade.
  - Blade cut depth: $0.50\text{ mm}$ below the 608 roller bearing, $1.50\text{ mm}$ below the cowl rim ($1.0\text{ mm}$ air gap above vinyl).
- **Bearing Clearance Canopy:**
  - Arches over the top ($Z = 18.0\text{ to }28.0\text{ mm}$) and front of the 608 roller bearing.
  - Generous radial clearance ($>2.0\text{ mm}$) and axial depth ($14.0\text{ mm}$) clearing the bearing ($7.0\text{ mm}$ wide) and M5 button head screw ($2.75\text{ mm}$ tall) on the $1.5\text{ mm}$ standoff boss.
  - **Open Bottom Window:** Bottom of bearing compartment is completely open ($Z_{\text{local}} \le 7.0\text{ mm}$ down to $-4.5\text{ mm}$), enabling the 608 bearing to roll directly on the vinyl banner at $Z = -4.0\text{ mm}$ ($Z_{\text{world}} = 0.0\text{ mm}$) with zero friction or contact.
  - **Zero Fasteners on Bearing Side:** No screw holes or clamp points on the bearing side.
- **Anti-Twist Kinematic Registration:**
  - Rear mating face matches the $18.12^\circ$ included chevron $V$-face of the arm across the full $64\text{ mm}$ width.
  - Top registration lip overlaps the top ceiling of the arm ($Z = 28.0\text{ mm}$) by $3.0\text{ mm}$, preventing any rotation or deflection under single-screw clamping.

---

## 3. Implementation Steps

1. Update `IDEAS.md` (Idea 011).
2. Update `generate_circle_cutter.py`:
   - Geometry constants (`VERSION = "2.1"`, `BLADE_PAD_Y = 16.0`, `BEARING_PAD_Y = -16.0`, `DUAL_HEAD_WIDTH = 64.0`, `CANT_ANGLE = 9.0607°`).
   - `build_piece2_arm()` with $64\text{ mm}$ flared head and $Y = \pm 16\text{ mm}$ bosses.
   - `build_piece3_blade_cap()` as a unified full-width end cap with blade chamber, bearing canopy, open roller window, and single M3 counterbore.
   - `build_circle_cutter_bearing_coupon()` with $Y = -16\text{ mm}$ and cant angle $9.06^\circ$.
   - Multi-view and 3D assembly renderer scenes.
   - Manifest metadata.
3. Execute generator script and verify 100% watertight manifold meshes across all 8 STLs.
4. Update `README.md`, `PHYSICAL_TEST_NOTES.md`.
5. Git commit and push.

---

## 4. Verification & Quality Gates (PASSED)

All 8 STL meshes passed the mandatory 4-gate topological audit with **0 boundary edges, 0 non-manifold edges, and 0 degenerate triangles**:
- `circle_cutter_base.stl`: 1600 tris, [50.0, 50.0, 110.0] mm, 131.60 cm³ (~91.9g PETG) — PASS
- `circle_cutter_arm.stl`: 2934 tris, [127.88, 64.0, 108.0] mm, 146.15 cm³ (~102.1g PETG) — PASS
- `circle_cutter_blade_cap.stl`: 520 tris, [18.63, 64.0, 28.0] mm, 53.35 cm³ (~37.3g PETG) — PASS
- `circle_cutter_hub_cap.stl`: 2784 tris, [50.0, 50.0, 9.0] mm, 7.28 cm³ (~5.1g PETG) — PASS
- `circle_cutter_reducer_sleeve.stl`: 512 tris, [7.72, 7.72, 6.8] mm, 0.33 cm³ (~0.2g PETG) — PASS
- `circle_cutter_spindle_bore_coupon.stl`: 1056 tris, [105.0, 50.0, 27.0] mm, 36.98 cm³ (~25.8g PETG) — PASS
- `circle_cutter_bearing_coupon.stl`: 228 tris, [22.55, 32.0, 28.0] mm, 17.49 cm³ (~12.2g PETG) — PASS
- `circle_cutter_snap_cap_coupon.stl`: 4064 tris, [114.0, 50.0, 15.0] mm, 15.48 cm³ (~10.8g PETG) — PASS

**Conclusion:** Plan 009 successfully executed and verified. Single M3 shoulder screw clamping through the blade bore, generous bearing clearance canopy, and positive $18.12^\circ$ chevron anti-rotation lock fully implemented in v2.1.

