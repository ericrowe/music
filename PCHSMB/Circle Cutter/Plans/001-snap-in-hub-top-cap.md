# Implementation Plan 001: Snap-in Hub Top Cap for Clean Support-Free Printing

**Project:** PCHSMB Field Prop Circle Cutter  
**Status:** Completed & Verified (v1.3)  
**Target Release:** v1.3  
**Components Affected:** Piece 2 (`circle_cutter_arm.stl`), Piece 4 (`circle_cutter_hub_cap.stl`), Fit Coupon (`circle_cutter_snap_cap_coupon.stl`)

---

## 1. Problem Statement & Motivation

In the current v1.2 architecture:
- Piece 2 (Rotating Arm Assembly) integrates a solid $6.0\text{ mm}$ roof cap over a $102\text{ mm}$ deep $\times \varnothing 42.0\text{ mm}$ blind bore.
- **Printing Upright ($Z=0$ on bed):** The arm rests flat on the build plate (ideal for layer line tensile strength and bed adhesion), but the slicer must bridge or support a horizontal $\varnothing 42\text{ mm}$ ceiling 102 mm high inside the narrow cylinder. Removing 102 mm tall support structures from a closed bore is difficult and risks gouging the smooth slip-fit bearing surface.
- **Printing Inverted ($Z=108$ on bed):** The hub top rests on the bed, but the entire $150\text{ mm}$ arm beam is cantilevered $96\text{ mm}$ in mid-air, requiring massive support structures, generating filament waste, and leaving rough support scarring along the bottom gliding surface.

### Desired Outcome
Split the hub ceiling into a separate fourth component: **Piece 4: Snap-in Hub Top Cap** (`circle_cutter_hub_cap.stl`).
- The Hub Sleeve of Piece 2 becomes an open vertical through-bore with an internal annular retention groove.
- Piece 2 prints upright with the arm resting flat on the bed with **zero supports, zero internal bridging, and zero overhangs $> 45^\circ$**.
- Piece 4 prints flat in ~12 minutes with zero supports.
- When assembled, Piece 4 snaps into Piece 2 with a tactile, audible "click", sealing the bore against dirt/grass and establishing the upper thrust boundary.
- Directly establishes the mounting platform for **Idea 002 (Ergonomic Swivel Knob)**.

---

## 2. Geometric Stackup & Tolerances

```
  +=========================================+  Z = 111.0 mm (Cap Top Flange OD 50mm)
  |      Piece 4: Snap-in Hub Top Cap       |
  +----+-------------------------------+----+  Z = 108.0 mm (Hub Sleeve Top Rim)
  |    |  4x Flex Fingers (Collet)     |    |
  |    |  +-\                     /-+  |    |  Z = 104.5 mm (Groove Peak OD 43.6mm, Barb OD 43.0mm)
  |    |  |  \                   /  |  |    |
  |    +--+   \                 /   +--+    |  Z = 102.0 mm (Cap Skirt Bottom / Interior Ceiling)
  |                                         |  
  |       2.0 mm Vertical Air Gap           |
  |                                         |
  |    +-------------------------------+    |  Z = 100.0 mm (Spindle Top / Piece 1 Base)
  |    |                               |    |
  |    |                               |    |
  |    |  Piece 1: Spindle (40mm OD)   |    |
  |    |  Piece 2: Bore (42mm ID)      |    |
  |    |  Radial Clearance: 1.0 mm     |    |
```

### Height and Diametral Budget
1. **Piece 1 (Base Spindle):**
   - Height above shoulder: $100.0\text{ mm}$.
   - Diameter: $\varnothing 40.0\text{ mm}$ ($R = 20.0\text{ mm}$).
   - Spindle top in arm local coordinates: $Z = 100.0\text{ mm}$.
2. **Piece 2 (Arm Hub Sleeve):**
   - Sleeve height: $108.0\text{ mm}$ ($Z = 0.0$ to $108.0\text{ mm}$).
   - Outer diameter: $\varnothing 50.0\text{ mm}$ ($R = 25.0\text{ mm}$).
   - Main bore diameter: $\varnothing 42.0\text{ mm}$ ($R = 21.0\text{ mm}$).
   - Wall thickness: $4.0\text{ mm}$.
   - Internal retention groove:
     - Root location: $Z = 103.5\text{ mm}$ to $105.5\text{ mm}$.
     - Groove diameter: $\varnothing 43.6\text{ mm}$ ($R = 21.8\text{ mm}$, $0.8\text{ mm}$ undercut).
     - Wall thickness at groove root: $3.2\text{ mm}$ (generous structural margin).
     - Overhang angles: $45^\circ$ self-supporting transitions top and bottom.
   - Top entry chamfer: $1.0\text{ mm} \times 45^\circ$ inner lead-in bevel at $Z = 108.0\text{ mm}$ for smooth insertion.
3. **Piece 4 (Snap-in Hub Top Cap):**
   - **Top Flange:** $\varnothing 50.0\text{ mm}$ OD matching hub rim, $3.0\text{ mm}$ thick ($Z = 108.0$ to $111.0\text{ mm}$), $1.5\text{ mm} \times 45^\circ$ perimeter chamfer.
   - **Skirt / Flex Collet:** Extends $6.0\text{ mm}$ downward ($Z = 108.0$ down to $102.0\text{ mm}$).
     - Skirt nominal OD: $\varnothing 41.6\text{ mm}$ ($0.2\text{ mm}$ radial clearance to bore).
     - Skirt wall thickness: $1.8\text{ mm}$ (inner bore $\varnothing 38.0\text{ mm}$).
     - Retention barb: Projects outward to $\varnothing 43.0\text{ mm}$ ($0.5\text{ mm}$ snap engagement).
     - Barb lead-in ramp: $30^\circ$ smooth entry angle.
     - Barb locking shoulder: $45^\circ$ retention angle.
     - Flex relief slots: 4 axial slots ($2.0\text{ mm}$ wide) dividing the skirt into four $90^\circ$ cantilever spring fingers.
     - Elastic deflection required during insertion: $\delta = (43.0 - 42.0) / 2 = 0.50\text{ mm}$ inward flex per finger. For a $6.0\text{ mm}$ long PETG cantilever with $1.8\text{ mm}$ wall, this produces approximately $18\text{ N}$ hand insertion force without yielding.
4. **Vertical Clearance (Anti-Binding):**
   - Skirt terminates at $Z = 102.0\text{ mm}$.
   - Spindle terminates at $Z = 100.0\text{ mm}$.
   - **Vertical air gap = $2.0\text{ mm}$**, guaranteeing zero friction or axial rubbing against the stationary spindle top during arm rotation.

---

## 3. Pre-Print Calibration Coupon (`circle_cutter_snap_cap_coupon.stl`)

To eliminate the risk of printing a 3-hour arm with a tight or loose snap fit:
- **Coupon Sleeve:** A compact $15.0\text{ mm}$ tall ring representing the top of the hub ($Z = 93.0$ to $108.0\text{ mm}$) with the identical $\varnothing 50\text{ mm}$ OD, $\varnothing 42\text{ mm}$ bore, and $\varnothing 43.6\text{ mm}$ internal groove.
- **Mating Cap:** A production-identical Piece 4 snap cap.
- **Print Time:** ~15 minutes total on a standard 0.4mm nozzle.
- **Test Criteria:**
  1. Hand press insertion force $\le 25\text{ N}$ (pressable with thumb without tools).
  2. Distinct tactile and audible snap into groove.
  3. Flange seats dead-flush against the sleeve top rim with zero wobble ($< 0.1\text{ mm}$ axial play).
  4. Axial pull-out resistance $\ge 40\text{ N}$ (will not pull out during tool handling or lifting).

---

## 4. Implementation Steps & Quality Gates

1. **Update `generate_circle_cutter.py`:**
   - Modify `build_piece2_arm()`: remove solid ceiling, add through-bore, and construct internal annular retention groove with $45^\circ$ lead-ins.
   - Implement `build_piece4_hub_cap()`: generate parametric 4-finger snap cap with $30^\circ$ insertion ramp and $45^\circ$ retention barb.
   - Implement `build_snap_cap_coupon()`: generate rapid calibration ring and cap test set.
2. **Topological Mesh Audit (Four Non-Negotiable Gates):**
   - 0 boundary edges.
   - 0 non-manifold edges.
   - 0 degenerate triangles.
   - 100% finite coordinates.
3. **Planar Slicing Verification:**
   - Cross-section slicing across the snap groove ($Z = 103.0$ to $107.0\text{ mm}$) and flex fingers to guarantee manifold 2D polygons with 0 open endpoints.
4. **Documentation & Manifest Sync:**
   - Update `build/manifest.json` with Piece 4 and coupon metadata.
   - Update `README.md` and `PHYSICAL_TEST_NOTES.md`.
   - Move Idea 001 from inbox to active/completed status in `IDEAS.md`.
