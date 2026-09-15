# PCHSMB Circle Cutter — Ideas & Enhancement Queue

This is the project inbox for future design enhancements and tooling iterations, following the engineering process and HitL workflow defined in `Parts-Database`. Each idea defines a concrete desired outcome before being promoted into an active implementation plan.

---

## Active Inbox

*(No pending ideas currently in queue. The v1.3 design baseline is complete and ready for physical print testing.)*

---

## Resolved / Closed Ideas

### Idea 002: Ergonomic Top Swivel Knob for Smooth One-Handed Operation — *Archived (Not Needed)*
- **Decision:** Archived as unnecessary for this tool.
- **Rationale:** The tool cuts $180^\circ$ semicircular wind relief slits rather than continuous $360^\circ$ circles. A single smooth sweep of the arm by hand across 180° is simple, ergonomic, and provides direct tactile feedback without the extra height, mass, or mechanical play of a swivel knob.

### Idea 003: Tool-Free Captive Quick-Clamp End Cap for Blade Replacement — *Archived (Not Needed)*
- **Decision:** Archived in favor of the standard M3 machine screw clamp.
- **Rationale:** Standard M3 socket/button head screw clamping into a brass heat-set insert provides maximum clamping rigidity, positive blade retention against cutting friction, zero blade flutter, and zero protruding thumb-wheels that could snag. Hex keys are standard shop equipment.

---

---

## Implemented Ideas

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
