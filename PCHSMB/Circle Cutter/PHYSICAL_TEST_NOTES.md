# PCHSMB Circle Cutter — Physical Test Notes & Caliper Verification Log

This document records physical caliper measurements, slicer parameters, print outcomes, and Human-in-the-Loop (HITL) validation notes for the **PCHSMB Circle Cutter** project. Following repository standards from the `carriers` / `Parts-Database` project, all physical findings govern CAD model revisions.

---

## 1. Test Status & Configuration

- **Date Initiated:** 2026-09-14
- **Release Version:** v1.6 (Raised Push Plate on Distal Arm & Harmonized 608 Bearings)
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
| `build/circle_cutter_spindle_bore_coupon.stl` | 1 | **Pre-print calibration coupon** for 40mm spindle + 608 post vs 42mm bore slip fit | ~18 min |
| `build/circle_cutter_bearing_coupon.stl` | 1 | **Pre-print calibration coupon** for 608 bearing M5 front mount, 14mm head & standoff boss | ~10 min |
| `build/circle_cutter_snap_cap_coupon.stl` | 1 | **Pre-print calibration coupon** for 15mm hub sleeve ring + snap cap with 608 pocket | ~18 min |
| `build/circle_cutter_base.stl` | 1 | Production Piece 1 (Fixed Pivot Base, 3mm plate, 608 post) | ~3 hr 30 min |
| `build/circle_cutter_arm.stl` | 1 | Production Piece 2 (Rotating Arm Assembly, open through-bore, 46x14mm dual head) | ~3 hr 00 min |
| `build/circle_cutter_blade_cap.stl` | 1 | Production Piece 3 (Blade Clamping Cap) | ~8 min |
| `build/circle_cutter_hub_cap.stl` | 1 | Production Piece 4 (Snap-in Hub Top Cap with 608 bearing pocket) | ~14 min |
| `build/circle_cutter_reducer_sleeve.stl` | 1 | Production Piece 5 (608-to-M5 Precision Reducer Bushing Sleeve) | ~2 min |

> [!TIP]
> **Print Fit Coupons First:** Do not print the large 3-hour arm before verifying the slip fit, 608 bearing seat, and snap-fit engagement using the quick calibration coupons.

---

## 3. Modeled Targets vs. Caliper Measurements

Record caliper readings to two decimal places ($\pm 0.02\text{ mm}$) once test parts cool to ambient room temperature ($20^\circ\text{C}$):

| Feature / Dimension | Modeled Target | Measured Physical Print | Tolerance / Delta | Status |
|---|:---:|:---:|:---:|:---:|
| **Piece 1: Base Plate OD** | 50.00 mm | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 1: Base Plate Height** | **3.00 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 1: Crosshair Notch Depth** | 1.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 1: Crosshair Notch Width** | 1.80 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 1: Center Spindle OD** | 40.00 mm | _[Pending print]_ | $+0.00 / -0.20\text{ mm}$ | Pending |
| **Piece 1: Spindle Height Above Base** | 100.00 mm | _[Pending print]_ | $\pm 0.25\text{ mm}$ | Pending |
| **Piece 1: 608 Inner Shoulder OD** | **11.50 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 1: 608 Inner Shoulder Height** | **1.00 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 1: 608 Pilot Post OD** | **7.90 mm** | _[Pending print]_ | $+0.00 / -0.15\text{ mm}$ | Pending |
| **Piece 1: 608 Pilot Post Height** | **6.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 1: Total Base Height** | **110.00 mm** | _[Pending print]_ | $\pm 0.30\text{ mm}$ | Pending |
| **Piece 2: Hub Outer Diameter** | 50.00 mm | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Hub Recess Bore ID** | 42.00 mm | _[Pending print]_ | $+0.25 / -0.00\text{ mm}$ | Pending |
| **Piece 2: Radial Slip Fit Clearance** | 1.00 mm | _[Pending print]_ | $0.80 - 1.20\text{ mm}$ | Pending |
| **Piece 2: Hub Recess Bore Depth** | 108.00 mm | _[Pending print]_ | $\pm 0.30\text{ mm}$ | Pending |
| **Piece 2: Arm Extension Length** | 150.00 mm | _[Pending print]_ | $\pm 0.40\text{ mm}$ | Pending |
| **Piece 2: Straight Arm Width** | 20.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Dual Head Width** | **46.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Arm Height (Straight Beam)** | 12.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Dual Head Height (Flared)** | **14.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Bearing Pad Offset ($Y$)** | **-11.50 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Blade Pad Offset ($Y$)** | **+11.50 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: 608 Bearing Axle Height (Local)** | **7.00 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: 608 Bearing Axle Height (World)** | **11.00 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: 608 Standoff Boss OD** | **11.50 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: 608 Standoff Boss Length** | **1.50 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M5 Insert Hole Diameter** | **6.20 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M5 Insert Hole Depth** | **11.00 mm** | _[Pending print]_ | $+0.50 / -0.00\text{ mm}$ | Pending |
| **Piece 2: M5 Bottom Floor Thickness** | **3.90 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: M5 Top Ceiling Thickness** | **3.90 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Distal Blade Slot Width** | 6.00 mm | _[Pending print]_ | $+0.15 / -0.00\text{ mm}$ | Pending |
| **Piece 2: Anti-Rotation Tab Height** | 0.80 mm | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M3 Heat-Set Hole Diameter** | **3.80 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M3 Heat-Set Hole Depth** | **10.50 mm** | _[Pending print]_ | $+0.50 / -0.00\text{ mm}$ | Pending |
| **Piece 2: Internal Retention Groove ID** | 43.60 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Push Plate Width** | **42.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Push Plate Platform Height (Local)** | **24.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Push Plate Traction Ridge Height** | **25.20 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Push Plate Front Safety Lip Height** | **26.50 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Front Tool Clearance Shelf** | **4.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 3: Cap Width x Height** | 12.00 x 16.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 3: Cap Thickness** | 3.50 mm | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 3: M3 Clearance Hole Dia** | 3.40 mm | _[Pending print]_ | $+0.20 / -0.05\text{ mm}$ | Pending |
| **Piece 4: Flange Outer Diameter** | 50.00 mm | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 4: Flange Thickness** | 3.00 mm | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 4: 608 Bearing Pocket ID** | **22.20 mm** | _[Pending print]_ | $+0.15 / -0.00\text{ mm}$ | Pending |
| **Piece 4: 608 Bearing Pocket Depth** | **3.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 4: 608 Central Relief ID** | **18.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 4: Finger Skirt Root OD** | 41.60 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 4: Barb Outer Diameter** | 43.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 4: Total Height** | 9.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 5: Reducer Sleeve OD** | **7.92 mm** | _[Pending print]_ | $+0.00 / -0.08\text{ mm}$ | Pending |
| **Piece 5: Reducer Sleeve ID** | **5.20 mm** | _[Pending print]_ | $+0.15 / -0.00\text{ mm}$ | Pending |
| **Piece 5: Reducer Sleeve Length** | **6.80 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Assembly: Controlled Cut Depth** | **1.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Assembly: Arm Air Clearance** | **4.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Assembly: Arm-to-Base Air Gap** | **1.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Assembly: Sliding Contact Area** | **0.00 mm²** | _[Pending print]_ | N/A (floating) | Pending |

---

## 4. Physical Assembly & Usability Verification Checklist

Complete these physical checks before clearing the circle cutter for prop fabrication:

1. **Slip Fit & Rotation Test:**
   - Slide Piece 2 (Rotating Arm) onto Piece 1 (Pivot Base).
   - Place on a flat table. Verify that the $3.0\text{ mm}$ base plate shoulder and top 608 bearing suspend the arm with a uniform **$1.0\text{ mm}$ air gap**, rotating with zero plastic sliding friction.
   - Verify that the arm rotates through $360^\circ$ smoothly with no tight spots, seam rubbing, or binding.
2. **Snap-in Hub Cap Engagement (Piece 4):**
   - Align Piece 4 with top of Piece 2 hub bore.
   - Press down firmly with thumb. The 4 flex fingers should deflect smoothly past the $\varnothing 42\text{ mm}$ entry and engage the internal $\varnothing 43.6\text{ mm}$ retention groove with a distinct tactile click.
   - Verify flange seats flush against the top face of Piece 2 ($Z = 108\text{ mm}$).
   - Confirm that the cap underside captures the top 608 bearing outer race while relieving the inner race and spindle post.
3. **608 Roller Bearing Installation with M5 Hardware (100% Pullout Resistant):**
   - Press M5 brass heat-set insert (8 or 10mm length) into the $\varnothing 6.2\text{ mm}$ hole on the Bearing Pad ($Y = -11.5\text{ mm}$) until flush with the $\varnothing 11.5\text{ mm}$ standoff boss.
   - Verify the $3.9\text{ mm}$ floor and $3.9\text{ mm}$ ceiling show zero thermal distortion or bulging.
   - Slide Piece 5 (Reducer Sleeve: $\varnothing 7.92 \times \varnothing 5.20 \times 6.80\text{ mm}$) into the 608 roller bearing bore ($8.0\text{ mm}$ ID).
   - Pass an M5 $\times 16\text{ mm}$ or $18\text{ mm}$ button-head machine screw through the reducer sleeve and thread into the front-face M5 insert with an Allen key.
   - Tighten firmly. Confirm the M5 button head ($\varnothing 9.5\text{ mm}$) clamps the bearing inner race rigidly against the $\varnothing 11.5\text{ mm}$ standoff boss, while the $22\text{ mm}$ outer race rotates freely with $>6.0\text{ mm}$ clearance to the blade clamp.
4. **M3 Heat-Set Insert & Blade Clamping:**
   - Press M3 brass insert (6, 8, or 10mm length) into the $\varnothing 3.8\text{ mm}$ hole on the Blade Pad ($Y = +11.5\text{ mm}$).
   - Seat standard X-Acto #11 blade tang into the $6.0\text{ mm}$ slot between anti-rotation tabs.
   - Confirm the blade tip extends exactly **$1.0\text{ mm}$ below the bottom rolling surface of the 608 bearing**.
   - Secure Piece 3 cap with an M3 x 10mm screw. Verify zero rotational play.
5. **Field Vinyl Cut Evaluation (Presser Foot Action):**
   - Place Piece 1 on scrap 13oz vinyl prop banner over a cutting mat. Align crosshairs with marked layout.
   - Rotate arm through $180^\circ$.
   - Confirm that the 608 roller bearing rolls smoothly across uncut vinyl $23\text{ mm}$ adjacent to the cut line, acting as a heavy-duty presser foot that holds the banner flat with zero bunching, tearing, or flap catching.
6. **Ergonomic Push Plate & Safety Stop Inspection:**
   - Rest dominant thumb or palm heel on the raised push plate at the distal end of Piece 2 ($Z_{\text{local}} = 24.0\text{ mm}$). Verify natural, comfortable hand posture and solid downward leverage.
   - Push forward vigorously against the front safety fence ($Z_{\text{local}} = 26.5\text{ mm}$). Verify positive physical blockage prevents the thumb from slipping forward toward the blade tang or 608 roller bearing.
   - Apply tangential sweeping force. Verify the 4 transverse traction ridges give secure grip without slippage.
   - Verify that the $4.0\text{ mm}$ front clearance shelf preserves 100% open vertical access for blade insertion/removal and straight horizontal access for M5 and M3 hex keys.

---

## 5. Physical Observations & Engineering Revisions

Record all physical observations, anomalies, or proposed geometry adjustments below:

- _[Observations to be added upon physical print testing]_
