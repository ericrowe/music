# PCHSMB Circle Cutter — Physical Test Notes & Caliper Verification Log

This document records physical caliper measurements, slicer parameters, print outcomes, and Human-in-the-Loop (HITL) validation notes for the **PCHSMB Circle Cutter** project. Following repository standards from the `carriers` / `Parts-Database` project, all physical findings govern CAD model revisions.

---

## 1. Test Status & Configuration

- **Date Initiated:** 2026-09-14
- **Release Version:** v1.3 (Modular 4-Piece Architecture with Support-Free Snap-in Hub Top Cap & Calibration Coupon)
- **Target Subproject:** PCHSMB Duck Blinds & Rolling Backdrops (Wind Relief Slit Tooling)
- **Target Geometry:** $R = 4.0\text{ in.} = 101.6\text{ mm}$ semicircular wind relief flaps in 13oz heavy vinyl scrim
- **Recommended Material:** PETG (e.g. Bambu PETG Basic / Polymaker PolyLite PETG)
- **Slicer & Print Settings:**
  - Nozzle: 0.40 mm
  - Layer Height: 0.20 mm
  - Wall Loops / Perimeters: 4 (1.6 mm minimum solid shell)
  - Top / Bottom Shells: 5
  - Infill: 25% Gyroid
  - Bed Temp: 70–80°C (Textured PEI plate recommended)
  - Supports: **Zero supports required for ALL parts** (all overhangs $\le 45^\circ$, open through-bore on Piece 2)

---

## 2. Print Set

| Part / Artifact | Quantity | Purpose | Estimated Print Time |
|---|:---:|---|:---:|
| `build/circle_cutter_spindle_bore_coupon.stl` | 1 | **Pre-print calibration coupon** for 40mm spindle vs 42mm bore slip fit | ~18 min |
| `build/circle_cutter_bearing_coupon.stl` | 1 | **Pre-print calibration coupon** for 625 bearing M5 front mount & standoff boss | ~10 min |
| `build/circle_cutter_snap_cap_coupon.stl` | 1 | **Pre-print calibration coupon** for 15mm hub sleeve ring + snap cap set | ~18 min |
| `build/circle_cutter_base.stl` | 1 | Production Piece 1 (Fixed Pivot Base, 4mm level base plate) | ~3 hr 30 min |
| `build/circle_cutter_arm.stl` | 1 | Production Piece 2 (Rotating Arm Assembly, open through-bore, support-free) | ~3 hr 00 min |
| `build/circle_cutter_blade_cap.stl` | 1 | Production Piece 3 (Blade Clamping Cap) | ~8 min |
| `build/circle_cutter_hub_cap.stl` | 1 | Production Piece 4 (Snap-in Hub Top Cap with 4 flex collet fingers) | ~12 min |

> [!TIP]
> **Print Fit Coupons First:** Do not print the large 3-hour arm before verifying the slip fit, bearing standoff, and snap-fit engagement using the three quick calibration coupons.

---

## 3. Modeled Targets vs. Caliper Measurements

Record caliper readings to two decimal places ($\pm 0.02\text{ mm}$) once test parts cool to ambient room temperature ($20^\circ\text{C}$):

| Feature / Dimension | Modeled Target | Measured Physical Print | Tolerance / Delta | Status |
|---|:---:|:---:|:---:|:---:|
| **Piece 1: Base Plate OD** | 50.00 mm | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 1: Base Plate Height** | **4.00 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 1: Crosshair Notch Depth** | 1.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 1: Crosshair Notch Width** | 1.80 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 1: Center Spindle OD** | 40.00 mm | _[Pending print]_ | $+0.00 / -0.20\text{ mm}$ | Pending |
| **Piece 1: Spindle Height Above Base** | 100.00 mm | _[Pending print]_ | $\pm 0.25\text{ mm}$ | Pending |
| **Piece 1: Total Base Height** | **104.00 mm** | _[Pending print]_ | $\pm 0.30\text{ mm}$ | Pending |
| **Piece 2: Hub Outer Diameter** | 50.00 mm | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Hub Recess Bore ID** | 42.00 mm | _[Pending print]_ | $+0.25 / -0.00\text{ mm}$ | Pending |
| **Piece 2: Radial Slip Fit Clearance** | 1.00 mm | _[Pending print]_ | $0.80 - 1.20\text{ mm}$ | Pending |
| **Piece 2: Hub Recess Bore Depth** | 102.00 mm | _[Pending print]_ | $\pm 0.30\text{ mm}$ | Pending |
| **Piece 2: Vertical Bore End-Play** | 2.00 mm | _[Pending print]_ | $1.50 - 2.50\text{ mm}$ | Pending |
| **Piece 2: Arm Extension Length** | 150.00 mm | _[Pending print]_ | $\pm 0.40\text{ mm}$ | Pending |
| **Piece 2: Straight Arm Width** | 20.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Dual Head Width** | **36.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Arm Height** | 12.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Bearing Pad Offset ($Y$)** | **-9.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Blade Pad Offset ($Y$)** | **+9.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: 625 Bearing Axle Height (Local)** | **4.00 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: 625 Bearing Axle Height (World)** | **8.00 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: 625 Standoff Boss OD** | 8.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: 625 Standoff Boss Length** | 1.00 mm | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M5 Insert Hole Diameter** | 7.00 mm | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M5 Insert Hole Depth** | 8.00 mm | _[Pending print]_ | $+0.50 / -0.00\text{ mm}$ | Pending |
| **Piece 2: Distal Blade Slot Width** | 6.00 mm | _[Pending print]_ | $+0.15 / -0.00\text{ mm}$ | Pending |
| **Piece 2: Anti-Rotation Tab Height** | 0.80 mm | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M3 Heat-Set Hole Diameter** | 4.20 mm | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: Internal Retention Groove ID** | 43.60 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 3: Cap Width x Height** | 12.00 x 16.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 3: Cap Thickness** | 3.50 mm | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 3: M3 Clearance Hole Dia** | 3.40 mm | _[Pending print]_ | $+0.20 / -0.05\text{ mm}$ | Pending |
| **Piece 4: Flange Outer Diameter** | 50.00 mm | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 4: Flange Thickness** | 3.00 mm | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 4: Finger Skirt Root OD** | 41.60 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 4: Barb Outer Diameter** | 43.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 4: Total Height** | 9.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Assembly: Controlled Cut Depth** | **1.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Assembly: Arm Air Clearance** | **4.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Assembly: Spindle Air Clearance** | **2.00 mm** | _[Pending print]_ | $\pm 0.25\text{ mm}$ | Pending |

---

## 4. Physical Assembly & Usability Verification Checklist

Complete these physical checks before clearing the circle cutter for prop fabrication:

1. **Slip Fit & Rotation Test:**
   - Slide Piece 2 (Rotating Arm) onto Piece 1 (Pivot Base).
   - Place on a flat table. Verify that the $4.0\text{ mm}$ base plate and the 625 roller bearing touch the table simultaneously, holding the arm dead-level.
   - Verify that the arm rotates through $360^\circ$ smoothly with no tight spots, seam rubbing, or binding.
2. **Snap-in Hub Cap Engagement (Piece 4):**
   - Align Piece 4 with top of Piece 2 hub bore.
   - Press down firmly with thumb. The 4 flex fingers should deflect smoothly past the $\varnothing 42\text{ mm}$ entry and engage the internal $\varnothing 43.6\text{ mm}$ retention groove with a distinct tactile click.
   - Verify flange seats flush against the top face of Piece 2 ($Z = 108\text{ mm}$).
   - Confirm that the cap underside stays $2.0\text{ mm}$ clear of the top of the stationary spindle, producing zero axial rubbing during rotation.
3. **625 Bearing Installation (100% Front-Face Tool Access):**
   - Press M5 brass heat-set insert into the $\varnothing 7.0\text{ mm}$ hole on the Bearing Pad ($Y = -9.0\text{ mm}$) until flush with the $\varnothing 8.0\text{ mm}$ standoff boss.
   - Slide 625 bearing onto an M5 button head screw.
   - Thread directly into the front-face M5 insert with an Allen key (unobstructed open axial clearance).
   - Verify that the inner race clamps firmly against the $8.0\text{ mm}$ standoff boss, and the outer ring spins completely freely with zero rubbing against the arm face.
4. **M3 Heat-Set Insert & Blade Clamping:**
   - Press M3 brass insert into the $\varnothing 4.2\text{ mm}$ hole on the Blade Pad ($Y = +9.0\text{ mm}$).
   - Seat standard X-Acto #11 blade tang into the $6.0\text{ mm}$ slot between anti-rotation tabs.
   - Confirm the blade tip extends exactly **$1.0\text{ mm}$ below the bottom rolling surface of the 625 bearing**.
   - Secure Piece 3 cap with an M3 x 10mm screw. Verify zero rotational play.
5. **Field Vinyl Cut Evaluation (Presser Foot Action):**
   - Place Piece 1 on scrap 13oz vinyl prop banner over a cutting mat. Align crosshairs with marked layout.
   - Rotate arm through $180^\circ$.
   - Confirm that the 625 bearing rolls smoothly across uncut vinyl $18\text{ mm}$ adjacent to the cut line, acting as a presser foot that holds the banner flat with zero bunching, tearing, or flap catching.

---

## 5. Physical Observations & Engineering Revisions

Record all physical observations, anomalies, or proposed geometry adjustments below:

- _[Observations to be added upon physical print testing]_
