# Plan 008: Tall Rigid Arm Beam & Calibrated 0.5mm Rotary Cut Depth (v2.0)

**Subproject:** PCHSMB Circle Cutter (Parametric Wind Relief Cutter)  
**Status:** In Progress (v2.0 Architecture)  
**Author:** AI Pair Programmer (DeepMind Antigravity)  
**Date:** September 2026  
**Target Delivery:** `circle_cutter_arm.stl`, `circle_cutter_blade_cap.stl`, `generate_circle_cutter.py`, `build/manifest.json`, `README.md`, `PHYSICAL_TEST_NOTES.md`, `IDEAS.md`

---

## 1. Context & Motivation

### 1.1 Problem Statement & User Inspection
Following the v1.9 implementation of the 28mm rotary blade and safety guard cowl, visual and CAD inspection revealed a significant geometric and structural disproportion:
1. **Vertical Envelope Mismatch:** The arm beam was only $12.0\text{ mm}$ high and the dual head only $14.0\text{ mm}$ high. However, the Fiskars rotary blade is $28.0\text{ mm}$ in diameter, and the Piece 3 safety guard cowl is $30.0\text{ mm}$ tall ($Z \in [-3.0, +27.0\text{ mm}]$). The arm was half the height of the blade it was supposed to support.
2. **Structural Wall Thinness around Axle:** With the blade axle at $Z_{\text{local}} = 9.0\text{ mm}$ and a $\varnothing 9.0\text{ mm}$ standoff boss ($R = 4.5\text{ mm}$), the top of the boss reached $Z = 13.5\text{ mm}$, leaving a fragile $0.5\text{ mm}$ plastic margin beneath the $14.0\text{ mm}$ head ceiling.
3. **Apparent Blade Drop & Cut Depth:** The blade projected $5.0\text{ mm}$ below the bottom of the arm, cutting $1.0\text{ mm}$ deep into the cutting mat. For standard 13 oz scrim vinyl ($\sim 0.38\text{ mm}$ thickness), a $1.0\text{ mm}$ cut depth produces unnecessary blade drag into the mat and causes the blade to hit the work surface before the 608 roller bearing stabilizes the arm.

### 1.2 User Directive
The user directed:
> *"Now, at 28mm, that blade is still way too low. Please check the geometry. Make the arm taller if you need to."*

Upon multiple-choice review, the user selected the recommended **$0.5\text{ mm}$ cut depth** below the 608 roller bearing ($Z_{\text{axle, local}} = 9.5\text{ mm}$).

---

## 2. Engineering Architecture & Mechanical Stackup

### 2.1 Vertical Stackup Comparison (v1.9 vs. v2.0)

| Coordinate / Dimension | v1.9 Baseline | v2.0 Redesign | Engineering Rationale |
|---|:---:|:---:|---|
| **Vinyl Top Surface ($Z_{\text{world}}$)** | $0.0\text{ mm}$ | $0.0\text{ mm}$ | Ground reference datum |
| **Arm Bottom World Plane ($Z_{\text{world}}$)** | $+4.0\text{ mm}$ | $+4.0\text{ mm}$ | Preserves $1.0\text{ mm}$ air gap above $3.0\text{ mm}$ base plate shoulder ($0\text{ mm}^2$ friction) |
| **Arm Beam Height (`ARM_HEIGHT`)** | $12.0\text{ mm}$ | **$20.0\text{ mm}$** | $+67\%$ height increase; **$4.63\times$ higher vertical bending stiffness** ($I \propto h^3$) |
| **Dual Head Height (`DUAL_HEAD_HEIGHT`)** | $14.0\text{ mm}$ | **$28.0\text{ mm}$** | **Exact $1:1$ match** with $28.0\text{ mm}$ blade diameter; fully backs Piece 3 cowl |
| **608 Roller Bearing Axle ($Z_{\text{world}}$)** | $+11.0\text{ mm}$ | $+11.0\text{ mm}$ | $R = 11.0\text{ mm}$ bearing rolls directly on vinyl plane ($Z_{\text{world}} = 0.0\text{ mm}$) |
| **608 Roller Bearing Axle ($Z_{\text{local}}$)** | $+7.0\text{ mm}$ | $+7.0\text{ mm}$ | Bearing bottom at $Z_{\text{local}} = -4.0\text{ mm}$ ($Z_{\text{world}} = 0.0\text{ mm}$) |
| **28mm Blade Cut Depth Below Roller** | $1.0\text{ mm}$ | **$0.5\text{ mm}$** | Slices $0.38\text{ mm}$ scrim vinyl with minimal $0.12\text{ mm}$ mat scoring; prevents dragging |
| **28mm Blade Tip World Plane ($Z_{\text{world}}$)** | $-1.0\text{ mm}$ | **$-0.5\text{ mm}$** | Controlled penetration into self-healing mat |
| **28mm Blade Axle World Plane ($Z_{\text{world}}$)** | $+13.0\text{ mm}$ | **$+13.5\text{ mm}$** | $-0.5\text{ mm} + 14.0\text{ mm}$ |
| **28mm Blade Axle Local Plane ($Z_{\text{local}}$)** | $+9.0\text{ mm}$ | **$+9.5\text{ mm}$** | $13.5\text{ mm} - 4.0\text{ mm}$ |
| **Blade Standoff Boss Ceiling Margin** | $0.5\text{ mm}$ | **$14.0\text{ mm}$** | Eliminates thin-wall fragility; massive solid PETG surround |
| **Piece 3 Cowl Local Bottom ($Z_{\text{bot}}$)** | $-12.0\text{ mm}$ | **$-12.5\text{ mm}$** | Preserves exact $1.0\text{ mm}$ air gap above vinyl ($Z_{\text{world}} = +1.0\text{ mm}$) |
| **Piece 3 Cowl Outer Apex ($Z_{\text{local}}$)** | $+27.0\text{ mm}$ | **$+27.5\text{ mm}$** | Aligns flush with $28.0\text{ mm}$ head ceiling ($0.5\text{ mm}$ margin) |
| **Push Knob Dome Apex ($Z_{\text{local}}$)** | $+32.0\text{ mm}$ | **$+46.0\text{ mm}$** | Tall ergonomic palm knob ($Z_{\text{world}} = 50.0\text{ mm}$) |

### 2.2 Beam & Head Transitions
- **Section 1 ($x_0 = 22.0$ to $x_1 = 55.0\text{ mm}$):** Straight beam with beveled cross-section ($20.0\text{ mm}\text{ W} \times 20.0\text{ mm}\text{ H}$).
- **Section 2 ($x_1 = 55.0$ to $x_2 = 75.0\text{ mm}$):** Smooth 3D loft flaring from $20.0 \times 20.0\text{ mm}$ up to $46.0\text{ mm}\text{ W} \times 28.0\text{ mm}\text{ H}$.
- **Section 3 ($x_2 = 75.0$ to $x_{\text{front}}(y)$):** Full dual head with canted chevron distal face ($\pm 6.4992^\circ$, vertex at $X = 102.26\text{ mm}$).
- **Chevron Face Dividers:** At $Y = 0.0$, the divider points between the positive-$Y$ blade pad and negative-$Y$ bearing pad are scaled to $[(0.0, 18.0), (0.0, 9.0)]$, preserving $N=19$ isomorphic boundary loops and strictly monotonic polar angle sweeps ($360.0^\circ$, zero degenerate quads).

### 2.3 Ergonomic Domed Push Knob
- **Center:** $(X = 80.0\text{ mm}, Y = 0.0\text{ mm})$ centered over the dual head footprint.
- **Base Embedding:** $Z_{\text{base}} = 27.0\text{ mm}$ ($1.0\text{ mm}$ into solid $28.0\text{ mm}$ head ceiling).
- **Cylindrical Shoulder:** Straight vertical cylinder to $Z_{\text{shoulder}} = 34.0\text{ mm}$ ($6.0\text{ mm}$ wall height, $\varnothing 24.0\text{ mm}$).
- **Hemispherical Dome:** $R = 12.0\text{ mm}$ with $C^1$ tangent continuity, rising to $Z_{\text{apex}} = 46.0\text{ mm}$ ($+18.0\text{ mm}$ above head ceiling).

### 2.4 Support-Free Printability Invariant
The arm bottom remains perfectly flat at $Z_{\text{local}} = 0.0\text{ mm}$ across the entire span from the hub through-bore to the distal chevron face. Piece 2 prints standing upright on the print bed with zero overhangs $> 45^\circ$, achieving **100% support-free upright printability**.

---

## 3. Implementation Steps

1. **Update Constants in `generate_circle_cutter.py`:**
   - `VERSION = "2.0"`
   - `ARM_HEIGHT = 20.0`
   - `DUAL_HEAD_HEIGHT = 28.0`
   - `CUT_DEPTH = 0.5`
   - `BLADE_TIP_WORLD_Z = -0.5`
   - `BLADE_AXLE_WORLD_Z = 13.5`
   - `BLADE_AXLE_LOCAL_Z = 9.5`
   - `GUARD_BOTTOM_LOCAL_Z = -12.5`
   - `PUSH_POST_BASE_Z = 27.0`
   - `PUSH_POST_SHOULDER_Z = 34.0`
   - `PUSH_POST_APEX_Z = 46.0`
2. **Update Arm Builder (`build_piece2_arm`):**
   - Update `div_pts_down = [(0.0, 18.0), (0.0, 9.0)]` and `div_pts_up = [(0.0, 9.0), (0.0, 18.0)]`.
3. **Update Bearing Coupon (`build_circle_cutter_bearing_coupon`):**
   - Update `div_pts_up` to match the $28.0\text{ mm}$ head height.
4. **Update Assembly Scene Offsets in `render_assembly_views`:**
   - Update blade cowl Z offset from $13.0$ to $13.5$ (assembly) and $54.0$ to $54.5$ (exploded).
5. **Execute CAD & Audit Pipeline:**
   - Run `python3 generate_circle_cutter.py`.
   - Verify all 8 STLs pass the 4-gate topological quality audit with **0 boundary, 0 non-manifold, 0 degenerate edges**.
6. **Update Documentation:**
   - `IDEAS.md` (Promote Idea 010 to Implemented).
   - `README.md` (Update specifications table, BOM, vertical stackup diagram).
   - `PHYSICAL_TEST_NOTES.md` (Update target dimensions for Piece 2 and Piece 3).
7. **Commit & Push:**
   - Stage all files, commit with structured conventional message, and push to GitHub.
