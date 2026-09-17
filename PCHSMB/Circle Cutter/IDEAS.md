# PCHSMB Circle Cutter — Ideas & Enhancement Queue

This is the project inbox for future design enhancements and tooling iterations, following the engineering process and HitL workflow defined in `Parts-Database`. Each idea defines a concrete desired outcome before being promoted into an active implementation plan.

---

## Active Inbox

*(No pending ideas currently in inbox. Idea 009 implemented in v1.9.)*

---

## Resolved / Closed Ideas

### Idea 006: Rectangular Raised Push Plate with Traction Ribs — *Superseded by Idea 007*
- **Decision:** Superseded by Idea 007 based on user direction: *"Nope. Lets try just making it a cylinder with a rounded top"*.
- **Rationale:** A cylindrical post with a rounded top provides omnidirectional ergonomic comfort, lower print mass, and a cleaner aesthetic.

### Idea 002: Ergonomic Top Swivel Knob for Smooth One-Handed Operation — *Archived (Not Needed)*
- **Decision:** Archived as unnecessary for this tool.
- **Rationale:** The tool cuts $180^\circ$ semicircular wind relief slits rather than continuous $360^\circ$ circles. A single smooth sweep of the arm by hand across 180° is simple, ergonomic, and provides direct tactile feedback without the extra height, mass, or mechanical play of a swivel knob.

### Idea 003: Tool-Free Captive Quick-Clamp End Cap for Blade Replacement — *Archived (Not Needed)*
- **Decision:** Archived in favor of the standard M3 machine screw clamp.
- **Rationale:** Standard M3 socket/button head screw clamping into a brass heat-set insert provides maximum clamping rigidity, positive blade retention against cutting friction, zero blade flutter, and zero snag points. Hex keys are standard shop equipment.

---

## Implemented Ideas

### [Idea 011: Full-Width End Cap with Bearing Clearance & Single M3 Blade Screw Retention](Plans/009-full-width-end-cap.md) — *Implemented in v2.1*
- **Outcome:** Unified Piece 3 into a full-width end cap spanning the $64.0\text{ mm}$ distal chevron head, widening pad spacing from $\pm 11.5\text{ mm}$ to $\pm 16.0\text{ mm}$ ($32.0\text{ mm}$ apart, providing $7.0\text{ mm}$ clearance between blade and bearing), retaining single M3 shoulder screw attachment through the blade axle while providing a full clearance canopy and open rolling window for the 608 roller bearing.
- **Benefits:**
  - Completely resolves the $6.0\text{ mm}$ cowl collision and $2.0\text{ mm}$ blade-to-bearing overlap from inherited v1.8 X-Acto dimensions.
  - Spans the full $64.0\text{ mm}$ width of the flared arm head, eliminating asymmetric overhangs.
  - Features anti-twist kinematic registration against the $18.12^\circ$ included chevron $V$-face and top registration lip.
  - Bearing side provides an overhead canopy shield for operator safety while leaving the bottom completely open for unobstructed vinyl rolling at $Z = 0$.
  - 100% support-free 3D printing maintained for all parts.

### [Idea 010: Tall Rigid Arm Beam & Calibrated 0.5mm Cut Depth for 28mm Rotary Blade](Plans/008-tall-arm-28mm-rotary.md) — *Implemented in v2.0*
- **Outcome:** Increased the arm beam height from $12.0\text{ mm}$ to $20.0\text{ mm}$ ($+67\%$, $4.63\times$ higher vertical stiffness) and the dual head height from $14.0\text{ mm}$ to $28.0\text{ mm}$ (exact 1:1 match with 28mm rotary blade diameter), fully backing the Piece 3 safety guard cowl and standardizing on a calibrated $0.5\text{ mm}$ cut depth below the 608 roller bearing.
- **Benefits:**
  - Standardized blade axle at $Z_{\text{local}} = 9.5\text{ mm}$ ($Z_{\text{world}} = 13.5\text{ mm}$), yielding a controlled $0.5\text{ mm}$ cut depth that cleanly slices $0.38\text{ mm}$ 13 oz scrim vinyl with minimal $0.12\text{ mm}$ mat penetration, preventing blade drag.
  - Head height of $28.0\text{ mm}$ provides a massive $14.0\text{ mm}$ solid PETG ceiling above the M3 heat-set insert and $\varnothing 9.0\text{ mm}$ standoff boss, completely eliminating the thin-wall vulnerability of the $14.0\text{ mm}$ head.
  - Head ceiling perfectly matches the top apex of the Piece 3 safety guard cowl ($Z_{\text{local}} = 27.5\text{ mm}$), creating a flush, robust, professional assembly.
  - Ergonomic push knob base moves up to $Z_{\text{local}} = 27.0\text{ mm}$, rising to $Z_{\text{apex}} = 46.0\text{ mm}$ ($Z_{\text{world}} = 50.0\text{ mm}$) for superior palm leverage.
  - 100% support-free upright 3D printability preserved with flat bed contact at $Z = 0$.

### [Idea 009: 28mm Rotary Cutter & Safety Finger Guard Cowl Redesign](Plans/007-rotary-cutter-guard.md) — *Implemented in v1.9*
- **Outcome:** Clean-sheet redesign of Piece 2 (Arm) and Piece 3 (Safety Guard Cowl) for 28mm rotary cutter blade rolling directly on ground 4.0mm shoulder bolt into M3 heat-set insert; calibrated radius to exact $R = 101.6\text{ mm}$ ($4.0\text{ in.}$) matching the $8.0\text{ in.}$ chord fleet specification.
- **Benefits:**
  - Transitioned from fragile X-Acto #11 hobby blade to industrial-grade 28mm circular rotary blade (Fiskars Model 1065938 / ASIN B0C8BSMMN1).
  - Ground 304 stainless steel shoulder screw (uxcell $\varnothing 4.0\text{ mm} \times 10.0\text{ mm}$, M3 thread) acts as a precision metal journal axle.
  - Piece 3 safety guard cowl shrouds the spinning razor wheel on top and flanks with $1.5\text{ mm}$ radial clearance and leaves $1.0\text{ mm}$ air gap above vinyl, preventing finger injury.
  - Cowl hub axial thickness of $9.20\text{ mm}$ leaves $0.80\text{ mm}$ of exposed shoulder; against $0.35\text{ mm}$ blade thickness, this guarantees $0.45\text{ mm}$ axial running float for zero-binding rotation without wobble.
  - Standardized cutting radius to exact $R = 101.6\text{ mm}$ ($4.0\text{ in.}$), resolving the radius vs. diameter ambiguity to cut true $8.0\text{ in.}$ chord flaps.
  - Recalibrated cant angle to $\pm 6.4992^\circ$ ($\arcsin(11.5 / 101.6)$) for exact $0.00^\circ$ tangential slicing and pure radial roller orientation.
  - All 8 STLs passed strict topological quality gates (0 boundary, 0 non-manifold edges).

### [Idea 008: Canted Dual Head (Chevron Face) for Pure Tangential Blade Tracking & Roller Alignment](Plans/006-canted-dual-head.md) — *Implemented in v1.8*
- **Outcome:** Canted the blade pad (+3.76°) and bearing pad (-3.76°) on Piece 2 (`circle_cutter_arm.stl`), forming a symmetric chevron distal face meeting seamlessly at the centerline ($X = 175.76\text{ mm}, Y = 0.0\text{ mm}$).
- **Benefits:**
  - Blade cuts with exact **$0.00^\circ$ yaw angle**, eliminating lateral kerf dragging, deflection, and scrim fiber tearing.
  - 608 roller bearing axle points identically radial toward the pivot center, eliminating lateral tire scrub.
  - Mathematically continuous chevron face meeting seamlessly at $Y = 0.0\text{ mm}$.
  - Standoff boss, M5 insert hole, M3 insert hole, and blade retaining tabs oriented perpendicular to their respective canted pad planes.
  - All 8 STLs passed strict topological quality gates (0 boundary, 0 non-manifold edges).

### [Idea 007: Cylindrical Domed Push Post / Knob on Distal Arm](Plans/005-cylindrical-domed-push-knob.md) — *Implemented in v1.7*
- **Outcome:** Replaced the v1.6 rectangular push plate with a monolithic cylindrical push knob featuring an exact hemispherical rounded dome top.
- **Benefits:**
  - Standardized on a $\varnothing 26.0\text{ mm}$ cylindrical post centered at $(X = 158.0\text{ mm}, Y = 0.0\text{ mm})$ between the 608 roller and blade clamp.
  - Straight vertical cylinder walls from $Z = 14.0\text{ mm}$ to $Z = 20.0\text{ mm}$ ($6.0\text{ mm}$ proud of the head ceiling).
  - Exact $R = 13.0\text{ mm}$ hemispherical dome with $C^1$ tangent continuity rising to $Z_{\text{apex}} = 33.0\text{ mm}$ ($+19.0\text{ mm}$ above head ceiling, $Z_{\text{world}} = 37.0\text{ mm}$).
  - Omnidirectional ergonomic push surface eliminating localized thumb/palm pressure points during $180^\circ$ sweeps.
  - Generous $4.0\text{ mm}$ front clearance shelf preserves 100% unobstructed vertical #11 blade insertion and horizontal M5/M3 hex key tool access.
  - 100% support-free upright 3D printability (all dome layers inward sloping).
  - All 8 STLs verified 100% watertight 2-manifold (0 boundary, 0 non-manifold edges).

### [Idea 005: 608 Roller Bearing Front Depth-Stop Conversion with Heavy-Duty M5 Axle Retention](Plans/003-608-front-roller-m5.md) — *Implemented in v1.5*
- **Outcome:** Converted the distal roller depth stop on Piece 2 from miniature 625 to standard 608 ball bearing ($8\text{ mm ID} \times 22\text{ mm OD} \times 7\text{ mm W}$), harmonizing the BOM to a single bearing SKU across the entire tool while providing heavy-duty M5 hardware retention.
- **Benefits:**
  - Standardizes the entire tool on standard 608 bearings (top thrust pivot + front depth stop roller).
  - Roller contact on vinyl at $Z_{\text{world}} = 0.0\text{ mm} \implies Z_{\text{world, axle}} = 11.0\text{ mm}$ and $Z_{\text{local, axle}} = \mathbf{7.0\text{ mm}}$.
  - Dual head expands in width ($36 \to 46\text{ mm}$) and flares upward in height ($12 \to 14\text{ mm}$), centering the M5 axle with a massive **$3.9\text{ mm}$ solid PETG floor and ceiling** ($+333\%$ increase in floor thickness over v1.4), completely eliminating pullout and heat-staking failure risks.
  - Inter-component safety gap of **$6.0\text{ mm}$** between the $22\text{ mm}$ OD bearing outer race and the blade clamp.
  - Dedicated Piece 5 (Precision 608-to-M5 Reducer Bushing Sleeve: $\varnothing 7.72 \times \varnothing 5.20 \times 6.80\text{ mm}$, reduced $0.20\text{ mm}$ from $7.92\text{ mm}$ per physical test) allows standard M5 button-head screws ($\varnothing 9.5\text{ mm}$) to clamp the inner race securely with zero radial play.
  - All 8 STLs passed 100% watertight manifold quality gates (0 boundary, 0 non-manifold edges).

### [Idea 004: Top-Mounted 608 Ball Bearing Thrust Pivot for Low-Friction Operation](Plans/002-608-bearing-pivot.md) — *Implemented in v1.4*
- **Outcome:** Integrated a single standard 608 ball bearing ($8\text{ mm ID} \times 22\text{ mm OD} \times 7\text{ mm W}$) horizontally atop the $100\text{ mm}$ center spindle column to carry 100% of operator downward pressure.
- **Benefits:**
  - Base plate height set to $3.0\text{ mm}$, suspending the rotating arm with a **$1.0\text{ mm}$ uniform air gap** ($Z_{\text{world}} = 4.0\text{ mm}$) above the base plate.
  - Reduces plastic-on-plastic sliding shoulder contact area from $707\text{ mm}^2$ to **$0\text{ mm}^2$**.
  - Spindle top adds $\varnothing 11.5\text{ mm} \times 1.0\text{ mm}$ inner-race shoulder and $\varnothing 7.9\text{ mm} \times 6.0\text{ mm}$ pilot post.
  - Piece 4 (Snap-in Hub Cap) integrates an $\varnothing 22.2\text{ mm} \times 3.0\text{ mm}$ outer-race pocket and $\varnothing 18.0\text{ mm} \times 1.5\text{ mm}$ relief cavity.
  - 100% contact isolation: shields, balls, and post are completely relieved with $>1.5\text{ mm}$ air clearances.
  - 625 roller bearing alignment ($Z_{\text{world, axle}} = 8.0\text{ mm}$) and $1.0\text{ mm}$ blade cut depth preserved exactly.
  - All 7 STLs and rapid calibration coupons verified 100% watertight manifold (0 boundary, 0 non-manifold edges).
  - 100% pure-Python CAD & 3D rendering pipeline (`generate_circle_cutter.py`).

### [Idea 001: Snap-in Hub Top Cap for Clean Support-Free Printing](Plans/001-snap-in-hub-top-cap.md) — *Implemented in v1.3*
- **Outcome:** Converted the top ceiling of Piece 2 (Rotating Arm Hub) from an integrated blind ceiling into a separate, snap-in fourth component (`circle_cutter_hub_cap.stl`).
- **Benefits:**
  - Piece 2 prints upright with arm flat on the bed with **zero internal bridging, zero supports, and zero overhangs $> 45^\circ$**.
  - Internal $45^\circ$ self-supporting retention groove ($\varnothing 43.6\text{ mm}$).
  - Snap cap features 4 cantilever flex fingers with $30^\circ$ lead-in ramps and $45^\circ$ retention barbs ($\varnothing 43.0\text{ mm}$).
  - Retains $2.0\text{ mm}$ vertical air gap above spindle to eliminate rotation friction.
  - Accompanied by pre-print calibration coupon set (`circle_cutter_snap_cap_coupon.stl`).
  - Top flange provides the direct mechanical foundation for Idea 002 (Swivel Knob).

---

## Next Steps for Promotion
When an idea is authorized for development:
1. Move the idea from this inbox to an active implementation plan in `Plans/` (e.g., `Plans/001-snap-in-hub-top-cap.md`).
2. Design isolated calibration coupons (e.g., snap-fit annular ring coupon) before generating full-scale production parts.
3. Validate physical prints with calipers and record findings in `PHYSICAL_TEST_NOTES.md`.
