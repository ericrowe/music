# Plan 007: 28mm Rotary Cutter & Safety Finger Guard Cowl Redesign (v1.9)

**Subproject:** PCHSMB Circle Cutter (Parametric Wind Relief Cutter)  
**Status:** Completed (v1.9 Production Release)  
**Author:** AI Pair Programmer (DeepMind Antigravity)  
**Date:** September 2026  
**Target Delivery:** `circle_cutter_arm.stl`, `circle_cutter_blade_cap.stl`, `generate_circle_cutter.py`, `build/manifest.json`, `README.md`, `PHYSICAL_TEST_NOTES.md`

---

## 1. Context & Motivation

### 1.1 Physical Evaluation of X-Acto #11 Baseline
Physical evaluation and geometric analysis proved that standard hobby craft blades (X-Acto #11) are fundamentally unsuitable for field fabrication of wind relief slits in heavy reinforced scrim vinyl:
1. **Vertical Offset Mismatch:** At $39.5\text{ mm}$ blade length, clamping the shank at $Z_{\text{local}} = 7.0\text{ mm}$ projects the tip $18\text{ mm}$ below the roller bearing into the turf; sliding it upward to a $1.0\text{ mm}$ cut depth forces the clamping screw against the razor cutting bevel while projecting $20\text{ mm}$ of exposed razor into the operator's workspace.
2. **Structural Brittleness:** Thin carbon steel hobby blade tips bend and snap when encountering high lateral drag forces against vinyl scrim fibers.
3. **Safety Hazard:** Exposed blade presents an unacceptable laceration risk to parent volunteers.

### 1.2 Transition to Rotary Cutting Platform
The project transitioned to a rolling rotary blade system. Following HITL hardware verification on Amazon:
- **Fastener:** uxcell 304 Stainless Steel Shoulder Bolt ($\varnothing 4.0\text{ mm}$ shoulder $\times 10.0\text{ mm}$ shoulder length, M3 thread).
- **Blade:** Fiskars 28mm Premium Alloy Steel Rotary Cutter Blades (Model 1065938 / ASIN B0C8BSMMN1, 2-Pack) featuring an exact $\varnothing 4.0\text{ mm}$ precision round center bore.
- **Center Hole Compatibility:** 18mm blades were rejected because they feature proprietary keyed/hexagonal holes ($\sim 3.5–3.8\text{ mm}$ across flats) that cannot accept a $\varnothing 4.0\text{ mm}$ round shoulder screw. The 28mm blade's $\varnothing 4.0\text{ mm}$ circular bore creates an ideal, low-friction metal-on-metal journal bearing directly on the ground steel shoulder.

### 1.3 Target Cut Geometry Correction (Radius vs. Diameter)
The PCHSMB Backdrop and Sideline Screen operations manuals ([`WIND_RELIEF_CUTS_SPECIFICATION.md`](../docs/references/WIND_RELIEF_CUTS_SPECIFICATION.md)) define:
- **Shape:** True Semicircular Flap (180° circular arc).
- **Chord (top hinge width):** $8.0\text{ in.} = 203.2\text{ mm} \approx 200\text{ mm}$ (the full circle's *diameter*).
- **Drop (cut depth):** $4.0\text{ in.} = 101.6\text{ mm} \approx 100\text{ mm}$ (the circle's *radius* $R$).
- **Radius:** $R_{\text{cut}} = \mathbf{4.0\text{ in.} = 101.6\text{ mm}}$.

The previous arm had `DISTAL_X = 175.0 mm`, which cut an oversized $13.8\text{ in.}$ chord ($350\text{ mm}$ diameter, $3\times$ target vent area). In this redesign, the cutting radius is standardized to **$R_{\text{cut}} = 101.6\text{ mm}$ ($4.0\text{ inches}$)** so the blade sweeps directly between the two pre-punched $3/8\text{ in.}$ ($10\text{ mm}$) tear-arrest holes.

---

## 2. Engineering Architecture & Mechanical Stackup

### 2.1 Vertical Stackup (World & Local Z)
- **Vinyl Top Surface:** World $Z = 0.0\text{ mm}$.
- **Arm Bottom Plane:** World $Z = +4.0\text{ mm}$ (Local $Z = 0.0\text{ mm}$, providing $1.0\text{ mm}$ air clearance above base plate).
- **608 Roller Bearing:** $22\text{ mm}$ OD, rides on vinyl at World $Z = 0.0\text{ mm} \implies Z_{\text{local, axle}} = \mathbf{+7.0\text{ mm}}$.
- **28mm Rotary Blade:** $28\text{ mm}$ OD ($R = 14.0\text{ mm}$), cut depth $1.0\text{ mm}$ into vinyl (World $Z = -1.0\text{ mm}$, Local $Z = -5.0\text{ mm}$).
  $$Z_{\text{local, axle}} = -5.0\text{ mm} + 14.0\text{ mm} = \mathbf{+9.0\text{ mm}}\text{ Local!}$$
- **Head Strength:** Head height $14.0\text{ mm}$. Axle at $Z = 9.0\text{ mm}$ provides **$5.0\text{ mm}$ of solid PETG ceiling** and **$9.0\text{ mm}$ of solid PETG floor**, securely enclosing the M3 brass heat-set insert ($\varnothing 3.8 \times 10.5\text{ mm}$).

### 2.2 Horizontal Geometry & Cant Angles ($R_{\text{cut}} = 101.6\text{ mm}$)
- **Transverse Spacing:** Blade pad at $Y = +11.5\text{ mm}$, Bearing pad at $Y = -11.5\text{ mm}$ ($23.0\text{ mm}$ center-to-center).
- **Distal $X$ Coordinate:**
  $$X_{\text{distal}} = \sqrt{101.6^2 - 11.5^2} = \sqrt{10190.31} = \mathbf{100.95\text{ mm}}$$
- **Cant Angle:**
  $$\theta_{\text{cant}} = \arcsin(11.5 / 101.6) = \mathbf{6.4992^\circ} \approx \mathbf{6.50^\circ}$$
  - Blade Pad canted at **$+6.50^\circ$** for exact **$0.00^\circ$ yaw angle** (pure tangential slicing).
  - Bearing Pad canted at **$-6.50^\circ$** for exact **$0.00^\circ$ tracking error** (pure radial axle).
- **Chevron Vertex:** $X = 100.95 + 11.5 \cdot \tan(6.50^\circ) = \mathbf{102.26\text{ mm}}$ at $Y = 0.0\text{ mm}$.
- **Outer Corners:** $X = 100.95 - 11.5 \cdot \tan(6.50^\circ) = \mathbf{99.64\text{ mm}}$ at $Y = \pm 23.0\text{ mm}$.

### 2.3 Piece 3: Integrated Rotary Blade Safety Guard Cowl
Piece 3 (`circle_cutter_blade_cap.stl`) is completely redesigned from a flat X-Acto clamping plate into an ergonomic, stationary **Safety Finger Guard Cowl**:
1. **Full Razor Shroud:** Arches over the top $180^\circ$ and outer flank of the 28mm blade with a $31.0\text{ mm}$ ID internal pocket ($1.5\text{ mm}$ radial clearance to blade edge), terminating at Local $Z = -12.0\text{ mm}$ ($1.0\text{ mm}$ air gap above vinyl).
2. **Zero-Friction Axial Running Clearance:** 
   - uxcell shoulder length: $10.0\text{ mm}$.
   - Piece 3 central hub thickness: $9.20\text{ mm}$.
   - Protruding shoulder length: $10.0 - 9.20 = \mathbf{0.80\text{ mm}}$.
   - Fiskars blade thickness: $0.35\text{ mm}$.
   - Net axial float: $0.80 - 0.35 = \mathbf{0.45\text{ mm}}$ free running clearance.
   - When the shoulder bolt is torqued down tight against the M3 insert, Piece 3 is held rigidly to the arm, while the blade spins freely on the precision ground steel shaft without binding or lateral wobble.

### 2.4 Ergonomic Push Knob
- Monolithic cylindrical domed push knob on Piece 2 resized to $\varnothing 24.0\text{ mm}$ ($R = 12.0\text{ mm}$), centered at $(X = 80.0\text{ mm}, Y = 0.0\text{ mm})$.
- Straight vertical cylinder to $Z = 20.0\text{ mm}$, crowned with an exact $R = 12.0\text{ mm}$ hemispherical dome to $Z_{\text{apex}} = 32.0\text{ mm}$.
- Generous $>8.0\text{ mm}$ front clearance shelf preserves unobstructed horizontal and vertical tool access.

---

## 3. Implementation Steps

1. [x] Establish Plan 007 in `Plans/007-rotary-cutter-guard.md`.
2. [x] Update `IDEAS.md` (add Idea 009 for Rotary Blade & Safety Cowl, mark active and complete).
3. [x] Modify `generate_circle_cutter.py`:
   - Update constants: `VERSION = "1.9"`, `DISTAL_X = 100.95`, `CANT_ANGLE_DEG = 6.4992`, `BLADE_AXLE_LOCAL_Z = 9.0`, shoulder screw dimensions.
   - Redesign `build_piece2_arm()` with rotary blade boss, M3 insert pocket, and $\pm 6.50^\circ$ canted chevron dual head.
   - Redesign `build_piece3_blade_cap()` into full 3D safety guard cowl with ray-sampled isomorphic loops, shoulder bolt counterbore, and $0.45\text{ mm}$ axial running clearance.
   - Update assembly scene renders and manifest generation.
4. [x] Run pure-Python pipeline (`python3 generate_circle_cutter.py`):
   - Enforce 4-gate topological quality audits on all 8 STLs.
   - Regenerate multi-view orthographic sheets and 3D assembly/exploded PNG renders.
5. [x] Update `README.md`, `PHYSICAL_TEST_NOTES.md`, and manifest.
6. [ ] Git commit and push to `origin/main`.
