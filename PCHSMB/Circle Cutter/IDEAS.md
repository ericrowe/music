# PCHSMB Circle Cutter — Ideas & Enhancement Queue

This is the project inbox for future design enhancements and tooling iterations, following the engineering process and HitL workflow defined in `Parts-Database`. Each idea defines a concrete desired outcome before being promoted into an active implementation plan.

---

## Active Inbox

*(No pending ideas in inbox.)*

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
  - Dedicated Piece 5 (Precision 608-to-M5 Reducer Bushing Sleeve: $\varnothing 7.92 \times \varnothing 5.20 \times 6.80\text{ mm}$) allows standard M5 button-head screws ($\varnothing 9.5\text{ mm}$) to clamp the inner race securely with zero radial play.
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
