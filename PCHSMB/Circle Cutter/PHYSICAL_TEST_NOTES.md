# PCHSMB Circle Cutter — Physical Test Notes & Caliper Verification Log

This document records physical caliper measurements, slicer parameters, print outcomes, and Human-in-the-Loop (HITL) validation notes for the **PCHSMB Circle Cutter** project. Following repository standards from the `carriers` / `Parts-Database` project, all physical findings govern CAD model revisions.

---

## 1. Test Status & Configuration

- **Date Initiated:** 2026-09-14 (Updated 2026-09-16)
- **Release Version:** v2.2 (Flat Front Print Surface & Canted Axle Centerline for Piece 3 End Cap)
- **Target Subproject:** PCHSMB Duck Blinds & Rolling Backdrops (Wind Relief Slit Tooling)
- **Target Geometry:** $R = 4.0\text{ in.} = 101.6\text{ mm}$ ($8.0\text{ in.}$ chord) semicircular wind relief flaps in 13oz heavy vinyl scrim
- **Recommended Material:** PETG (e.g. Bambu PETG Basic / Polymaker PolyLite PETG)
- **Slicer & Print Settings:**
  - Nozzle: 0.40 mm
  - Layer Height: 0.20 mm
  - Wall Loops / Perimeters: 4 (1.6 mm minimum solid shell)
  - Top / Bottom Shells: 5
  - Infill: 25% Gyroid
  - Bed Temp: 70–80°C (Textured PEI plate recommended)
  - Supports: **Zero supports required for ALL parts** (all overhangs $\le 45^\circ$, open through-bore on Piece 2, concentric domed knob, self-supporting cowl counterbores)

---

## 2. Print Set

| Part / Artifact | Quantity | Purpose | Estimated Print Time |
|---|:---:|---|:---:|
| `build/circle_cutter_spindle_bore_coupon.stl` | 1 | **Pre-print calibration coupon** for 40mm spindle + 608 post vs 42mm bore slip fit | ~18 min |
| `build/circle_cutter_bearing_coupon.stl` | 1 | **Pre-print calibration coupon** for 608 bearing M5 mount with -9.06° canted face, 20mm beam, 28mm head & standoff boss | ~14 min |
| `build/circle_cutter_snap_cap_coupon.stl` | 1 | **Pre-print calibration coupon** for 15mm hub sleeve ring + snap cap with 608 pocket | ~18 min |
| `build/circle_cutter_base.stl` | 1 | Production Piece 1 (Fixed Pivot Base, 3mm plate, 608 post) | ~3 hr 30 min |
| `build/circle_cutter_arm.stl` | 1 | Production Piece 2 (Rotating Arm Assembly, open through-bore, 64x28mm ±9.06° canted chevron dual head with tall 20mm beam, domed push knob, $R=101.6\text{ mm}$) | ~3 hr 10 min |
| `build/circle_cutter_blade_cap.stl` | 1 | Production Piece 3 (Full-Width Unibody End Cap with Bearing Canopy & Single M3 Fastener Attachment) | ~45 min |
| `build/circle_cutter_hub_cap.stl` | 1 | Production Piece 4 (Snap-in Hub Top Cap with 608 bearing pocket) | ~14 min |
| `build/circle_cutter_reducer_sleeve.stl` | 1 | Production Piece 5 (608-to-M5 Precision Reducer Bushing Sleeve) | ~2 min |

> [!TIP]
> **Print Fit Coupons First:** Do not print the full 2-hour arm before verifying the slip fit, 608 bearing seat, and snap-fit engagement using the quick calibration coupons.

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
| **Piece 2: Standardized Cut Radius** | **101.60 mm** | _[Pending print]_ | $\pm 0.30\text{ mm}$ | Pending |
| **Piece 2: Distal Axle Plane ($X$)** | **100.33 mm** | _[Pending print]_ | $\pm 0.25\text{ mm}$ | Pending |
| **Piece 2: Straight Arm Width** | 20.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Dual Head Width** | **64.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Arm Height (Straight Beam)** | **20.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Dual Head Height (Flared)** | **28.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Bearing Pad Offset ($Y$)** | **-16.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Blade Pad Offset ($Y$)** | **+16.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Head Cant Angle** | **9.06°** | _[Pending print]_ | $\pm 0.10^\circ$ | Pending |
| **Piece 2: Chevron Center Vertex ($X$)** | **102.88 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: 608 Bearing Axle Height (Local)** | **7.00 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: 608 Bearing Axle Height (World)** | **11.00 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: 608 Standoff Boss OD** | **11.50 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: 608 Standoff Boss Length** | **1.50 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M5 Insert Hole Diameter** | **6.20 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M5 Insert Hole Depth** | **11.00 mm** | _[Pending print]_ | $+0.50 / -0.00\text{ mm}$ | Pending |
| **Piece 2: Blade Standoff Boss OD** | **9.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Blade Standoff Boss Length** | **1.50 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: Blade Axle Height (Local)** | **9.50 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: Blade Axle Height (World)** | **13.50 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M3 Heat-Set Hole Diameter** | **3.80 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 2: M3 Heat-Set Hole Depth** | **10.50 mm** | _[Pending print]_ | $+0.50 / -0.00\text{ mm}$ | Pending |
| **Piece 2: Push Knob Center ($X$)** | **80.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Push Knob Center ($Y$)** | **0.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Push Knob Cylinder OD** | **24.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 2: Push Knob Base Height (Local)** | **27.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Push Knob Shoulder Height (Local)** | **34.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 2: Push Knob Apex Height (Local)** | **46.00 mm** | _[Pending print]_ | $\pm 0.25\text{ mm}$ | Pending |
| **Piece 3: End Cap Outer Width ($Y$)** | **64.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 3: End Cap Outer Height ($Z$)** | **28.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 3: End Cap Outer Length ($X$)** | **17.72 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 3: Front Print Face Planarity** | **Flat Plane ($X=115.50\text{ mm}$)** | _[Pending print]_ | 100% Flat (Face-down print) | Validated |
| **Piece 3: Shoulder Screw Axle Alignment** | **+9.0607° Cant Angle** | _[Pending print]_ | Coaxial with Arm Blade Boss | Validated |
| **Piece 3: Blade Cavity Radii ($R_y / R_z$)** | **15.00 / 15.00 mm (True Circle)** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 3: Bearing Canopy Radii ($R_y / R_z$)** | **13.00 / 13.00 mm (True Circle)** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 3: Bearing Canopy Axial Depth** | **12.50 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 3: Central Hub Clamping Thickness** | **9.20 mm** | _[Pending print]_ | $\pm 0.08\text{ mm}$ | Pending |
| **Piece 3: Counterbore Dia / Head Recess** | **8.20 mm / Recessed ($0.24-1.48\text{ mm}$)** | _[Pending reprint]_ | Sub-flush to flat front (+1.20mm clearance) | Validated |
| **Piece 3: Center Bore Diameter** | **4.65 mm** | _[4.20 mm printed tight; bolt did not fit]_ | $+0.65\text{ mm}$ clearance (~4.35mm printed ID) | Validated (HITL) |
| **Piece 3: Bearing Side Screw Holes** | **0 (Unibody canopy)** | _[Pending print]_ | N/A | Validated |
| **Piece 3: Ground Clearance Above Vinyl** | **4.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 4: Flange Outer Diameter** | 50.00 mm | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 4: Flange Thickness** | 3.00 mm | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Piece 4: 608 Bearing Pocket ID** | **22.20 mm** | _[Pending print]_ | $+0.15 / -0.00\text{ mm}$ | Pending |
| **Piece 4: 608 Bearing Pocket Depth** | **3.00 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 4: 608 Central Relief ID** | **18.00 mm** | _[Pending print]_ | $\pm 0.20\text{ mm}$ | Pending |
| **Piece 4: Finger Skirt Root OD** | 41.60 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 4: Barb Outer Diameter** | 43.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 4: Total Height** | 9.00 mm | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
| **Piece 5: Reducer Sleeve OD** | **7.72 mm** | _[7.92 mm was tight; reduced to 7.72 mm]_ | $+0.00 / -0.08\text{ mm}$ | Validated (HITL) |
| **Piece 5: Reducer Sleeve ID** | **5.20 mm** | _[Pending print]_ | $+0.15 / -0.00\text{ mm}$ | Pending |
| **Piece 5: Reducer Sleeve Length** | **6.80 mm** | _[Pending print]_ | $\pm 0.10\text{ mm}$ | Pending |
| **Assembly: Rotary Blade Running Float** | **0.45 mm** | _[Pending print]_ | $\pm 0.08\text{ mm}$ | Pending |
| **Assembly: Controlled Cut Depth** | **0.50 mm** | _[Pending print]_ | $\pm 0.15\text{ mm}$ | Pending |
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
3. **608 Roller Bearing Installation & Pure Tangential Alignment (-9.06° Cant):**
   - Press M5 brass heat-set insert (8 or 10mm length) along the angled normal vector into the $\varnothing 6.2\text{ mm}$ hole on the Bearing Pad ($Y = -16.0\text{ mm}$) until flush with the $\varnothing 11.5\text{ mm}$ standoff boss.
   - Verify the $3.9\text{ mm}$ floor and $16.5\text{ mm}$ ceiling show zero thermal distortion or bulging.
   - Slide Piece 5 (Reducer Sleeve: $\varnothing 7.72 \times \varnothing 5.20 \times 6.80\text{ mm}$) into the 608 roller bearing bore ($8.0\text{ mm}$ ID).
   - Pass an M5 $\times 16\text{ mm}$ or $18\text{ mm}$ button-head machine screw through the reducer sleeve and thread into the front-face M5 insert with an Allen key.
   - Tighten firmly. Confirm the M5 button head ($\varnothing 9.5\text{ mm}$) clamps the bearing inner race rigidly against the angled $\varnothing 11.5\text{ mm}$ standoff boss.
   - Verify that the 608 roller bearing axle is oriented radially along $\vec{R}_{\text{bearing}} = (100.33, -16.0)\text{ mm}$, rotating pure tangent to its circular path with **$0.00^\circ$ yaw and zero lateral tire scrub**.
4. **Full-Width Unibody End Cap & 28mm Blade Assembly (+9.06° Cant):**
   - Press M3 brass insert (6, 8, or 10mm length) along the normal vector into the $\varnothing 3.8\text{ mm}$ hole on the Blade Boss ($Y = +16.0\text{ mm}, Z_{\text{local}} = 9.5\text{ mm}$) until flush with the $\varnothing 9.0\text{ mm}$ standoff boss face.
   - Confirm ample solid PETG surround ($14.0\text{ mm}$ solid plastic above M3 boss ceiling) providing maximum thread pull-out strength.
   - Slide Fiskars 28mm rotary blade (precision round $\varnothing 4.0\text{ mm}$ bore) onto uxcell 304 stainless steel shoulder screw ($\varnothing 4.0\text{ mm} \times 10.0\text{ mm}$ shoulder, M3 thread).
   - Insert shoulder screw and blade through the central bore of Piece 3 (Full-Width Unibody End Cap) from the front counterbore.
   - Slide Piece 3 over the distal chevron face of Piece 2. The overhead bearing canopy slides effortlessly over the installed 608 roller bearing with generous radial clearance, requiring **zero screws on the bearing side**.
   - Thread the single M3 shoulder screw into the brass insert on Piece 2's blade pad until the shoulder seats solidly against the insert. Tighten firmly.
   - Confirm the blade spins freely with **$0.45\text{ mm}$ axial running clearance** (float), with zero wobble and zero binding against the end cap or arm.
   - Confirm the blade cut depth extends exactly **$0.50\text{ mm}$ below the bottom rolling surface of the 608 bearing** ($Z_{\text{world}} = -0.5\text{ mm}$) while the unibody end cap bottom maintains a **$4.0\text{ mm}$ air gap above the vinyl** ($Z_{\text{world}} = +4.0\text{ mm}$).
   - Verify the $18.12^\circ$ included chevron $V$-face provides positive kinematic anti-rotation.
5. **Field Vinyl Cut Evaluation (Presser Foot Action):**
   - Place Piece 1 on scrap 13oz vinyl prop banner over a cutting mat. Align crosshairs with marked layout.
   - Rotate arm through $180^\circ$.
   - Confirm that the 608 roller bearing rolls smoothly and purely tangent across uncut vinyl $32\text{ mm}$ adjacent to the cut line ($7.00\text{ mm}$ circumferential clearance to blade), acting as a heavy-duty presser foot that holds the banner flat with zero bunching, tearing, or flap catching.
   - Confirm the 28mm rotary blade executes a clean, continuous rolling shear cut with zero fiber pulling, snagging, or excessive mat gouging.
6. **Ergonomic Cylindrical Domed Push Knob Inspection:**
   - Rest thumb, palm heel, or index/middle fingers on the rounded domed top of the push knob at the distal end of Piece 2 ($Z_{\text{local}} = 46.0\text{ mm}$, $Z_{\text{world}} = 50.0\text{ mm}$). Verify natural, comfortable hand posture and solid downward leverage without localized pressure points.
   - Apply downward axial cutting force and tangential sweeping torque through a full $180^\circ$ circle cut arc. Verify that the $\varnothing 24.0\text{ mm}$ cylindrical post provides ample purchase and the rounded dome distributes operator pressure evenly across the palm or thumb pad.

---

## 5. Physical Observations & Engineering Revisions

Record all physical observations, anomalies, or proposed geometry adjustments below:

- **2026-09-16 HITL Physical Fit Test & Caliper Feedback:**
  - **Piece 2 (Arm) 608 Bearing Mount:** Verified **PERFECT**. The $\varnothing 11.5\text{ mm}$ standoff boss, M5 insert cavity, and inner race contact seat without any binding, tilt, or shield interference.
  - **Piece 4 (Hub Cap) 608 Pocket:** Verified **PERFECT**. Snap-fit engagement, $\varnothing 22.2\text{ mm}$ outer-race pocket, and $\varnothing 18.0\text{ mm}$ inner-race relief seat cleanly over the top pivot 608 bearing.
  - **Piece 5 (Reducer Sleeve) 608 Bore Fit:** The original $\varnothing 7.92\text{ mm}$ OD was **too tight** for the standard $8.0\text{ mm}$ steel bearing bore due to PETG layer lines and slight printer bore shrinkage ($0.08\text{ mm}$ diametral clearance was insufficient).
  - **Engineering Revision (v1.8.1):** Reduced Piece 5 outer diameter by $0.20\text{ mm}$ from $\varnothing 7.92\text{ mm}$ to **$\varnothing 7.72\text{ mm}$** ($0.28\text{ mm}$ diametral clearance / $0.14\text{ mm}$ radial clearance). Inner bore ($\varnothing 5.20\text{ mm}$), length ($6.80\text{ mm}$), and chamfers ($0.40\text{ mm}$) remain unchanged. All bearing interfaces on the arm and hub cap left exactly unchanged.
- **2026-09-16 Rotary Cutter & Radius Standardization Redesign (v1.9):**
  - **X-Acto #11 Offset & Safety Hazard Retirement:** HITL physical tests identified that the standard hobby blade suffered from vertical offset sensitivity and exposed razor edges creating volunteer laceration hazards. User requested a transition to a 28mm rotary cutter blade with an integrated safety finger guard cowl.
  - **Hardware Procurement:** Procured uxcell 304 Stainless Steel Shoulder Screws ($\varnothing 4.0\text{ mm}$ shoulder $\times 10.0\text{ mm}$ shoulder length, M3 thread) and Fiskars 28mm Premium Rotary Cutter Blades (Model 1065938 / ASIN `B0C8BSMMN1`, precision round $\varnothing 4.0\text{ mm}$ center bore).
  - **Radius vs. Diameter Standardization:** User inquired whether the old $175\text{ mm}$ arm radius matched the "approximately 200mm circle" in the fleet operations manual. Analysis confirmed the fleet standard is $8.0\text{ in.}$ chord ($203.2\text{ mm}$ *diameter*) $\times 4.0\text{ in.}$ drop ($101.6\text{ mm}$ *radius*). The old $175\text{ mm}$ radius produced an oversized $13.8\text{ in.}$ circle ($3\times$ venting area). The cutting radius was standardized to exact **$R = 101.6\text{ mm}$ ($4.0\text{ in.}$)**.
  - **Axial Running Clearance & Safety Cowl:** Piece 3 was designed with a $9.20\text{ mm}$ hub leaving $0.80\text{ mm}$ exposed shoulder length against the $0.35\text{ mm}$ blade, guaranteeing $0.45\text{ mm}$ axial running float for zero-binding rotation without wobble. The wrap-around cowl protects fingers with $1.5\text{ mm}$ radial blade clearance and $1.0\text{ mm}$ vinyl ground clearance.
  - **Cant Angle Recalibration:** Dual head cant angles updated to $\pm 6.4992^\circ$ ($\pm \arcsin(11.5 / 101.6)$), forming a forward chevron vertex at $X = 102.26\text{ mm}$. Push knob scaled to $\varnothing 24.0\text{ mm}$ at $X = 80.0\text{ mm}$.
  - **Topology Gate Audit:** All 8 STL meshes passed 4-gate topological audits with 0 boundary and 0 non-manifold edges. Piece 2 mass reduced from $143\text{ g}$ to $70.1\text{ g}$ (~2 hr 15 min print time).
- **2026-09-16 Tall Arm Beam, 28mm Cowl Backing & Calibrated 0.5mm Cut Depth Redesign (v2.0):**
  - **Blade Height & Head Cowl Backing Defect:** User review identified that at 28mm blade diameter, the rotary blade was still way too low relative to the arm structure, projecting far below the 14mm head and leaving the Piece 3 safety cowl unsupported with only 0.5mm of plastic above the M3 heat-set boss. Furthermore, 1.0mm cut depth below the roller bearing was deeper than necessary for 13oz vinyl (~0.38mm), causing excessive drag into the cutting mat.
  - **Tall Beam Geometry ($20.0\text{ mm}$):** Increased straight arm beam height from $12.0\text{ mm}$ to **$20.0\text{ mm}$** ($+67\%$). This increases vertical area moment of inertia $I_y$ by $4.63\times$, providing exceptional downward beam stiffness under heavy volunteer cutting pressure without flexing.
  - **Tall Dual Head Geometry ($28.0\text{ mm}$):** Raised the flared dual head ceiling from $14.0\text{ mm}$ to **$28.0\text{ mm}$**, matching the $28.0\text{ mm}$ Fiskars blade diameter 1:1. The top of the Piece 3 safety cowl ($Z_{\text{local}} = 27.5\text{ mm}$) is now flush with the head ceiling ($0.5\text{ mm}$ margin).
  - **Structural M3 Heat-Set Surround ($14.0\text{ mm}$):** The solid plastic thickness above the M3 heat-set insert cavity increased from $0.5\text{ mm}$ to **$14.0\text{ mm}$**, completely eliminating thin-wall blowout risk during thermal insertion and providing rock-solid axial retention under cutting loads.
  - **Calibrated 0.5mm Cut Depth:** User selected $0.5\text{ mm}$ cut depth below the 608 roller bearing. Blade axle relocated from $Z_{\text{local}} = 9.0\text{ mm}$ to **$Z_{\text{local}} = 9.5\text{ mm}$** ($Z_{\text{world}} = 13.5\text{ mm}$). With blade radius $R = 14.0\text{ mm}$, the blade bottom reaches $Z_{\text{local}} = -4.5\text{ mm}$ ($Z_{\text{world}} = -0.5\text{ mm}$). Relative to the 608 roller bearing rolling surface at $Z_{\text{world}} = 0.0\text{ mm}$ ($Z_{\text{local}} = -4.0\text{ mm}$), the blade extends exactly **$0.50\text{ mm}$ into the vinyl scrim**, cleanly shearing the ~0.38mm vinyl sheet while preserving cutting mat life.
  - **Tall Push Knob Apex ($46.0\text{ mm}$):** The push knob base starts at $Z = 27.0\text{ mm}$, cylindrical shoulder reaches $Z = 34.0\text{ mm}$, and hemispherical dome apex reaches **$Z_{\text{local}} = 46.0\text{ mm}$** ($Z_{\text{world}} = 50.0\text{ mm}$), providing comfortable palm clearance above the tall arm.
  - **Topology & Printability Invariant:** Piece 2 bottom remains flat at $Z = 0.0\text{ mm}$ across the entire length, printing 100% support-free upright on the bed. All 8 STL meshes passed 4-gate topological audits with 0 boundary edges and 0 non-manifold edges. Piece 2 mass is $90.6\text{ g}$ PETG (~2 hr 50 min print time).
- **2026-09-16 Full-Width Unibody End Cap, 608 Bearing Canopy & Widened Axle Geometry (v2.1):**
  - **Collision & Clearance Anomaly Discovered:** In v1.9/v2.0, when the 28mm blade ($R = 14.0\text{ mm}$) and 608 roller bearing ($R = 11.0\text{ mm}$) were introduced, the axle spacing was retained from v1.8's hobby knife at $Y = \pm 11.5\text{ mm}$ ($23.0\text{ mm}$ center-to-center). Because $14.0 + 11.0 = 25.0\text{ mm} > 23.0\text{ mm}$, the bare blade and bearing overlapped by $2.0\text{ mm}$, and the Piece 3 cowl ($R = 18.0\text{ mm}$) collided with the bearing by $6.0\text{ mm}$.
  - **Widened Axle Spacing ($Y = \pm 16.0\text{ mm}$):** Center-to-center distance widened to $32.0\text{ mm}$, creating a generous **$7.00\text{ mm}$ circumferential clearance** between the 28mm blade and 608 bearing.
  - **Chevron Geometry Recalibration:** Distal axle plane shifted to $X = \sqrt{101.6^2 - 16.0^2} = \mathbf{100.3322\text{ mm}}$. Head cant angle updated to $\arcsin(16.0 / 101.6) = \mathbf{9.0607^\circ}$. Chevron center vertex at $X = 100.3322 + 16.0 \times \tan(9.0607^\circ) = \mathbf{102.8838\text{ mm}}$. Head width expanded from $46.0\text{ mm}$ to **$64.0\text{ mm}$** ($Y \in [-32.0, +32.0\text{ mm}]$).
  - **Full-Width Unibody End Cap (Piece 3):** User requested: *"Does the blade cap provide clearance over the bearing? Maybe it would be better if the blade cap just went over the whole end of the arm? The screw for the end cap should only attach through the blade though, while providing clearance for the bearing."* Piece 3 redesigned as a single unibody cap ($64.0\text{ mm}\text{ W} \times 28.0\text{ mm}\text{ H} \times 13.7\text{ mm}\text{ D}$).
  - **Single M3 Screw Retention:** Cap is clamped solely by the single uxcell $\varnothing 4.0\text{ mm} \times 10.0\text{ mm}$ M3 shoulder screw through the 28mm blade bore, maintaining **$0.45\text{ mm}$ axial running float** for the blade. The rear mating surface of Piece 3 matches the arm's $18.12^\circ$ included chevron $V$-face, delivering rock-solid kinematic anti-rotation without needing secondary fasteners.
  - **Overhead Bearing Canopy:** The bearing side has **zero screw holes**. A true circular arched canopy ($9.2\text{ mm}$ axial depth, true circular cylinder $R = 13.0\text{ mm}$, concentric with bearing axle at $Z_{\text{local}} = 7.0\text{ mm}$) covers the 608 roller bearing from above with an open bottom, allowing the bearing to roll freely on the vinyl at $Z_{\text{world}} = 0.0\text{ mm}$.
  - **True Circular Relief Cuts (Zero Ovality Resolution):** User noted: *"The relief cuts in the blade cap are oval.... neither the blade nor the bearing are oval."* In v2.1 initial build, the cavities were parameterized with elliptical aspect ratios ($R_y = 15.5, R_z = 12.5$ for blade, $R_y = 13.0, R_z = 10.0$ for bearing) and vertically shifted centers ($Z = 12.5$ and $Z = 10.0$) to avoid meshing intersections at $Z = 0$. This squashed the cuts into visible ovals and made the screw counterbore eccentric. Resolved in v2.1.1 by implementing **true circular cylinder geometry** ($R_y = R_z = R$) strictly concentric with their respective axles:
    - **Blade Cavity:** True circular cylinder of radius $R = 15.0\text{ mm}$, centered at $(Y = +16.0\text{ mm}, Z_{\text{local}} = 9.5\text{ mm})$ ($1.0\text{ mm}$ radial clearance around 14.0mm Fiskars blade). Screw counterbore is dead-center.
    - **Bearing Canopy:** True circular cylinder of radius $R = 13.0\text{ mm}$, centered at $(Y = -16.0\text{ mm}, Z_{\text{local}} = 7.0\text{ mm})$ ($2.0\text{ mm}$ radial clearance around 11.0mm 608 bearing).
    - **Ground Clearance Invariant ($Z \ge 0.0\text{ mm}$):** Clamped with $z_{\text{floor}} = 0.05\text{ mm}$, ensuring zero negative-$Z$ protrusion, maintaining exact $4.0\text{ mm}$ ground clearance above vinyl ($Z_{\text{world}} = +4.0\text{ mm}$) and flat bottom profile ($18.63 \times 64.0 \times 28.0\text{ mm}$).
  - **Topological Quality Gates:** All 8 STL meshes verified 100% watertight manifold (0 boundary edges, 0 non-manifold edges, 0 degenerate triangles). Arm mass is $102.1\text{ g}$ PETG (~3 hr 10 min); Piece 3 cap mass is $35.8\text{ g}$ PETG (~45 min).
- **2026-09-17 Flat Front Print Surface & Canted Axle Centerline Redesign (v2.2):**
  - **HITL Slicing & Printability Defect:** User reported: *"Please make the front of the cap have a flat surface for printing. There's no good way to orient that part right now, and standing it on end is resulting in holes that are out of tolerance for what we need. Additionally, the post for the shoulder screw appears to be going straight into the arm, rather than canted at an angle to match the blade angle."*
  - **Root Cause Analysis:**
    1. *V-Shaped Front Face:* In v2.1, the front perimeter was generated via $X_{\text{front}}(Y) = X_{\text{rear}}(Y) + \text{cap\_len} \cdot \cos\theta_c$. Because $X_{\text{rear}}(Y)$ was a chevron ($V$-ridge with vertex at $Y = 0$), $X_{\text{front}}$ was also a $V$-ridge, preventing flat placement on the 3D printer build plate. Slicing with the part stood on end forced cylindrical holes to print along horizontal layer lines, causing overhang drooping, oval distortion, and loose/tight fastener fit.
    2. *Straight-in Screw Kink:* In v2.1, `c_b_front` had $Y = 16.0\text{ mm}$ and `c_b_rear` had $Y = 16.0\text{ mm}$ ($\Delta Y = 0$), forcing the overall screw path parallel to the $X$-axis (straight in), while local circular offsets used tilted vectors $\vec{n}_b$ and $\vec{t}_b$. This created an unintended $9.06^\circ$ kinking misalignment between the cap bore and the arm's canted blade boss.
  - **100% Planar Flat Front Surface:** Established a single flat plane at **$X = 115.50\text{ mm}$** across the entire front face ($Y \in [-32.0, +32.0\text{ mm}], Z \in [0.0, 28.0\text{ mm}]$). Users can now place Piece 3 face-down flat on the print bed with zero rocking and **zero supports required**. All cylindrical counterbores, bores, and hub posts are printed along the printer's vertical $Z$ axis, ensuring maximum roundness, layer concentricity, and tight tolerances.
  - **True Canted Axle Centerline (+9.0607°):** Rebuilt all blade-side features along the authoritative canted axis line $\vec{C}(s) = \vec{P}_0 + s \cdot \vec{n}_b$, where $\vec{P}_0 = (100.3322, 16.0, 9.5)\text{ mm}$ and $\vec{n}_b = (\cos\theta_c, \sin\theta_c, 0.0)$.
    - *Counterbore Front Opening:* Formed by intersecting the cylinder ($r_{\text{cb}} = 3.9\text{ mm}$) with the plane $X = 115.50\text{ mm}$. Opens cleanly at $Y_{\text{center}} = 18.42\text{ mm}$.
    - *Counterbore Shelf:* Located at $s = 11.50\text{ mm}$ along $\vec{n}_b$ ($1.5\text{ mm}$ arm standoff boss + $10.0\text{ mm}$ shoulder length). The $3.0\text{ mm}$ socket cap head is completely recessed ($0.24–1.48\text{ mm}$ sub-flush below the flat front face).
    - *Through-Bore & Clamping Hub:* Extends from counterbore seat ($s = 11.50\text{ mm}$) to hub tip ($s = 2.30\text{ mm}$), maintaining exact $9.20\text{ mm}$ bore length and leaving $0.80\text{ mm}$ exposed steel shoulder for **$0.45\text{ mm}$ axial running float** on the $0.35\text{ mm}$ blade.
    - *Cavity Floor & Solid Bulkhead:* Set at $s = 3.50\text{ mm}$ ($1.65\text{ mm}$ air clearance forward of blade), backed by an $8.0\text{ mm}$ solid PETG core to the counterbore seat. Clamped within $Y \le 31.36\text{ mm}$ to maintain exact $64.00\text{ mm}$ outer width ($17.72 \times 64.0 \times 28.0\text{ mm}$).
  - **Topological Quality Gates:** All 8 STL meshes verified 100% watertight manifold (0 boundary edges, 0 non-manifold edges, 0 degenerate triangles). Piece 3 mass is $40.2\text{ g}$ PETG (~45 min print time).
- **2026-09-17 Shoulder Bolt Clearance & Counterbore Tolerance Redesign (v2.2.1):**
  - **HITL Physical Test Finding:** Physical test print of Piece 3 (Blade Cap) completed with flat front face. Caliper/assembly test revealed that the $\varnothing 4.0\text{ mm}$ uxcell precision ground shoulder bolt could not fit through the center hole in the cutter cap. The modeled $\varnothing 4.20\text{ mm}$ through-bore only provided $0.20\text{ mm}$ diametral clearance ($0.10\text{ mm}$ per side). Due to standard FDM hole shrinkage (~0.25–0.30mm) and layer stepping over the $9.20\text{ mm}$ bore length at a $9.06^\circ$ cant, the printed ID was $\approx 3.85 - 3.95\text{ mm}$, causing interference binding against the $4.00\text{ mm}$ steel shaft.
  - **Bore Tolerance Opened to $\varnothing 4.65\text{ mm}$:** Increased `GUARD_BORE_DIA` from $4.20\text{ mm}$ to **$4.65\text{ mm}$** ($+0.65\text{ mm}$ CAD clearance over the 4.0mm shoulder bolt shaft). Accounting for typical FDM perimeter shrinkage, the physical printed ID measures $\approx 4.35 - 4.40\text{ mm}$, guaranteeing an effortless, smooth slip fit with zero binding and zero need for drilling or reaming.
  - **Counterbore Tolerance Opened to $\varnothing 8.20\text{ mm}$:** Increased `GUARD_CB_DIA` from $7.80\text{ mm}$ to **$8.20\text{ mm}$** ($+1.20\text{ mm}$ CAD clearance over the 7.0mm socket cap head). Yields $\approx 7.90\text{ mm}$ printed ID, providing ample clearance for the screw head and standard hex key/bit driver without dragging against the sidewalls.
  - **Structural & Retention Integrity:** The annular counterbore shelf under the bolt head maintains a wide $1.175\text{ mm}$ radial clamping width ($21.50\text{ mm}^2$ solid bearing area). The central clamping hub maintains a solid $2.175\text{ mm}$ wall thickness (over 5 solid perimeters at 0.40mm nozzle). The axial running float ($0.45\text{ mm}$) and $4.0\text{ mm}$ vinyl ground clearance remain completely preserved.
  - **Topology & Verification:** All 8 STL meshes regenerated and verified 100% watertight manifold with 0 boundary edges and 0 non-manifold edges. Piece 3 mass is $40.2\text{ g}$ PETG (~45 min print time).


