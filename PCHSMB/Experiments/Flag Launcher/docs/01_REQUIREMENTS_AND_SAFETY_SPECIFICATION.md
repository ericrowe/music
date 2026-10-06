# PCHSMB 2027 Color Guard Flag Thrower — Requirements & Safety Specification

**Subproject:** `Experiments/Flag Launcher/`  
**Classification:** Mechanical Engineering, Kinetic Prop Safety & Performance Requirements  
**Revision:** Build D1 — Preliminary Engineering Specification  
**Author:** PCHSMB Engineering & Prop Development Team  
**Governing Context:** Colorado Bandmasters Association (CBA) Rules 8.05–9.07 & Bands of America (BOA) Field Safety Standards  

---

## 1. Executive Summary & Operational Intent

The **Color Guard Flag Thrower** is a dedicated mechanical stage prop engineered to execute an automated, choreographed toss of a standard color guard flag during a field marching band performance.

### 1.1 The Choreographic Problem
In high-level competitive marching band (CBA Class 5A / BOA), visual effect judges reward unexpected, highly coordinated prop interactions. Having a flag smoothly tossed from a field scenic piece or grounded fixture into the hands of a marching color guard performer creates a dramatic visual feature. 

Manual human tosses from behind props often suffer from inconsistent release angles, visual distraction of visible throwers, and timing jitter. A precision-engineered mechanical thrower provides:
1. **Millisecond-Repeatable Timing:** Fires on an exact musical downbeat.
2. **Deterministic Parabolic Arc:** Consistent launch velocity ($v_0$) and trajectory angle ($\theta$) landing predictably in the performer's catch window.
3. **Clean Visual Magic:** The flag emerges cleanly from behind or within a scenic element with no visible thrower.

### 1.2 Performance Envelope
- **Effective Toss Range ($R$):** $6.0\text{ to }10.0\text{ feet}$ ($1.8\text{ to }3.0\text{ m}$) horizontal ground displacement.
- **Toss Apex ($H$):** $5.0\text{ to }7.0\text{ feet}$ ($1.5\text{ to }2.1\text{ m}$) above ground level (comfortably within human reach).
- **Target Hang Time ($T_{\text{flight}}$):** $1.0\text{ to }1.3\text{ seconds}$ (matching natural manual flag toss cadences, allowing visual tracking and a clean two-handed catch).
- **Payload:** Standard $6\text{-foot}$ weighted aluminum color guard flag ($1.5\text{–}2.0\text{ lbs}$ total mass).

---

## 2. Payload Characteristics (The Color Guard Flag)

Understanding the physical characteristics of the launched object is paramount to ballistic stability and catching safety.

| Parameter | Value | Engineering Notes |
|---|---|---|
| **Pole Length ($L_{\text{pole}}$)** | $6.0\text{ ft}$ ($72.0\text{ in} / 1.83\text{ m}$) | Standard anodized aluminum thin-wall tubing ($1.0\text{″}$ OD, $0.035\text{″}$ wall). |
| **Total Weight ($W$)** | $1.75\text{ lbs} \pm 0.25\text{ lbs}$ ($0.79\text{ kg}$) | Includes pole, weighted carriage bolts, plastic end stoppers, velcro tabs, and silk. |
| **Silk Dimensions** | $36\text{″} \times 54\text{″}$ ($0.91\text{ m} \times 1.37\text{ m}$) | Lightweight poly-silk fabric ($40\text{–}60\text{ g/m}^2$). |
| **Center of Gravity (CG)** | $32\text{″} \pm 4\text{″}$ from bottom butt cap | Typically balanced near the upper third / center by internal weighting bolts. |
| **End Caps** | Molded rubber / vinyl caps | Standard crutch tips or contoured guard caps protecting against turf impact. |

### 2.1 The Silk Aerodynamics Challenge (Furl vs. Flight)
- **Open Silk (High Drag):** If the flag silk is loose and billowing at release, aerodynamic drag ($F_d = \frac{1}{2} \rho v^2 C_d A$) is catastrophic and unpredictable. Gusting winds ($10\text{–}20\text{ mph}$) will blow the flag off-course, ruining the catch and risking safety.
- **Furled / Controlled Silk (Low Drag):** The flag silk **must be lightly furled or rolled** along the pole during staging and launch:
  - *Retention Method:* Light magnetic break-away clips, lightweight tear-away paper bands, or elastic silicone slip-rings that release as the flag reaches the apex or upon catch.
  - *Deployment:* The performer catches the balanced pole and unfurls the silk on the subsequent musical downbeat as part of the choreographed equipment work.

---

## 3. Mathematical Physics & Spring Energy Calculations

### 3.1 Unit-Consistent Spring & Trajectory Derivations

In standard US Customary units:
- Spring displacement: $x$ ($\text{inches}$)
- Spring constant: $k$ ($\text{lbf/in}$)
- Stored Potential Energy:
  $$PE_{\text{spring}} = \frac{1}{2} k x^2 \quad (\text{in}\cdot\text{lbf}) = \frac{k x^2}{24} \quad (\text{ft}\cdot\text{lbf})$$
- Payload weight: $W$ ($\text{lbf}$), mass: $m = W / g$ ($\text{slugs}$, where $g = 32.174\text{ ft/s}^2$).
- Theoretical Muzzle Velocity (neglecting friction and pusher mass):
  $$v_0 = \sqrt{\frac{2 \cdot PE_{\text{ft}\cdot\text{lbf}}}{m}} = \sqrt{\frac{2 \cdot (k x^2 / 24)}{W / 32.174}} = \sqrt{\frac{2.681 \cdot k x^2}{W}} \quad (\text{ft/s})$$

### 3.2 Ideal Parabolic Flight Profile ($R = 10\text{ ft}$)

For a catchable theatrical toss, a steep launch angle ($\theta = 60^\circ\text{–}70^\circ$) is vastly superior to a flat $45^\circ$ angle:
- A $45^\circ$ angle fires horizontally into the performer's body at low elevation, creating a dangerous direct projectile.
- A **$65^\circ$ angle** lofts the flag upward into a majestic arching parabola that decelerates at the apex, allowing the performer to settle underneath it and execute a standard catch.

Let launch angle $\theta = 65.0^\circ$:
$$\sin(2\theta) = \sin(130^\circ) = 0.7660$$
$$R = \frac{v_0^2}{g} \sin(2\theta) \implies 10.0\text{ ft} = \frac{v_0^2}{32.174} \times 0.7660 \implies v_0^2 = 419.9\text{ ft}^2\text{/s}^2 \implies v_0 \approx \mathbf{20.5\text{ ft/s}} \quad (13.98\text{ mph})$$

From this launch velocity:
1. **Time of Flight ($T$):**
   $$T = \frac{2 v_0 \sin\theta}{g} = \frac{2 \times 20.5 \times \sin(65^\circ)}{32.174} = \frac{41.0 \times 0.9063}{32.174} = \mathbf{1.15\text{ seconds}}$$
2. **Apex Height above Launch Muzzle ($H$):**
   $$H = \frac{v_0^2 \sin^2\theta}{2g} = \frac{419.9 \times (0.9063)^2}{64.348} = \frac{344.9}{64.348} = \mathbf{5.36\text{ feet}} \quad (1.63\text{ m})$$
   *If the launcher muzzle is $2.0\text{ ft}$ off the turf, the apex is $7.36\text{ ft}$ ($2.24\text{ m}$) above the ground—ideal for a standing high school color guard catch.*
3. **Required Kinetic Energy at Release ($W = 1.75\text{ lbs}$):**
   $$KE_{\text{payload}} = \frac{1}{2} \left(\frac{1.75}{32.174}\right) (20.5)^2 = 0.0272 \times 419.9 = \mathbf{11.42\text{ ft}\cdot\text{lbf}} \quad (137.0\text{ in}\cdot\text{lbf} = 15.48\text{ Joules})$$

### 3.3 Mechanical Efficiency & System Energy Losses ($\eta$)

In actual physical testing (documented in `Test 001/README.md`), significant energy was lost to:
1. **Moving Carriage / Pusher Mass ($m_{\text{pusher}}$):**
   If the internal spring pushes a captive carriage of mass $m_p$, the energy divides between the payload and the carriage:
   $$\eta_{\text{mass}} = \frac{m_{\text{flag}}}{m_{\text{flag}} + m_{\text{pusher}}}$$
   *Rule: Keep pusher mass strictly $< 0.25\text{ lbs}$ ($< 15\%$ of flag mass).*
2. **Guide Rail & Sear Friction ($\eta_{\text{friction}} \approx 70\text{–}80\%$):**
   Linear sleeve friction along the barrel and dragging across the trigger catch.
3. **Spring Internal Hysteresis & Incomplete Stroke ($\eta_{\text{stroke}} \approx 85\%$):**
   Overall system efficiency is estimated at:
   $$\eta_{\text{total}} = \eta_{\text{mass}} \times \eta_{\text{friction}} \times \eta_{\text{stroke}} \approx 0.85 \times 0.75 \times 0.85 \approx \mathbf{54\%}$$

**Gross Required Stored Spring Energy:**
$$PE_{\text{gross}} = \frac{KE_{\text{payload}}}{\eta_{\text{total}}} = \frac{137.0\text{ in}\cdot\text{lbf}}{0.54} \approx \mathbf{254\text{ in}\cdot\text{lbf}} \quad (21.2\text{ ft}\cdot\text{lbf})$$

### 3.4 Spring Sizing Matrix for $254\text{ in}\cdot\text{lbf}$ Stored Energy

| Stroke / Deflection ($x$) | Required Spring Constant ($k$) | Peak Cocking Force ($F_{\text{peak}} = k \cdot x$) | Human Feasibility / Cocking Aid |
|---|---|---|---|
| **$6.0\text{ in}$** | $14.1\text{ lbf/in}$ | $84.6\text{ lbf}$ ($38.4\text{ kg}$) | Requires lever cocking bar or winch. |
| **$9.0\text{ in}$** | $6.27\text{ lbf/in}$ | $56.4\text{ lbf}$ ($25.6\text{ kg}$) | Heavy two-hand pull or simple lever. |
| **$12.0\text{ in}$** | $3.53\text{ lbf/in}$ | $42.4\text{ lbf}$ ($19.2\text{ kg}$) | **Optimal:** Manageable foot-stirrup / T-handle pull. |
| **$15.0\text{ in}$** | $2.26\text{ lbf/in}$ | $33.9\text{ lbf}$ ($15.4\text{ kg}$) | Very easy pull; longer overall barrel tube. |

> [!TIP]
> **Engineering Selection:** A **$10\text{–}12\text{ inch}$ stroke** with a spring rate of $k \approx 3.5\text{–}4.5\text{ lbf/in}$ yields an ergonomic peak cocking load of $35\text{–}45\text{ lbs}$, fully achievable by a student or parent crew member without power tools.

---

## 4. Rigorous Safety Engineering & Interlock Architecture

Any device storing $20\text{+ ft}\cdot\text{lbf}$ of mechanical kinetic energy on a field populated by student performers must adhere to **fail-safe industrial design principles**.

```
FLAG THROWER SAFETY LIFE-CYCLE
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│ 1. TRANSPORT    │ ──► │ 2. STAGING CHUTE│ ──► │ 3. FIELD ENTRY  │ ──► │ 4. PERFORMANCE  │
│ Unloaded        │     │ Unloaded        │     │ Pin Locked      │     │ Armed & Fired   │
│ Springs Relaxed │     │ Springs Relaxed │     │ Flag Inserted   │     │ Immediate Egress│
└─────────────────┘     └─────────────────┘     └─────────────────┘     └─────────────────┘
```

### 4.1 Safety Principle 1: Separation of Flag from Release Sear (User Insight from Test 001)
As correctly identified in the preliminary test notes:
> *"For safety reasons I believe incorporating the catch feature into the flag itself should be avoided, as it precludes unloading of the thrower without first firing it."*

- **The Danger of Notch-on-Pole:** If a catch notch is machined directly into the flag pole, the flag itself is under tension while loaded. To remove the flag, the mechanism must be fired, or fingers must enter the pinch zone.
- **The Mandatory Solution: Captive Internal Shuttle / Pusher:**
  The spring acts upon an internal captive shuttle/pusher carriage. The trigger latches the **carriage**, NOT the flag.
  - The flag pole simply rests inside the carriage cup under gravity or light friction.
  - **Zero-Risk Unloading:** If the show is stopped (wind hold, rain, medical timeout), the crew member simply lifts the flag straight out of the barrel tube by hand with **zero stored energy touching the pole**.

### 4.2 Safety Principle 2: Physical Redundant Lockout Pin (The "Arming Pin")
The trigger mechanism must feature a **positive physical lockout pin**:
1. A bright-red anodized aluminum or stainless steel pin ($1/4\text{″}$ or $5/16\text{″}$ dia.) with a prominent **"REMOVE BEFORE PERFORMANCE"** red streamer.
2. The pin passes completely through the outer chassis and physically blocks the internal pusher shuttle from forward travel, independent of the trigger sear.
3. Even if the trigger is bumped, snagged on a uniform, or mechanically fails, the pin mechanically stops all motion with zero energy transfer.
4. **Protocol:** The arming pin remains inserted during trailer loading, field gate staging, and field setup. It is pulled by the crew member only **30 seconds prior to performance downbeat**.

### 4.3 Safety Principle 3: Safe Manual Decocking Mechanism
If the thrower is armed with the spring compressed, but the cue is skipped or cancelled:
- **No Dry-Fire Mandate:** Firing the thrower without the flag payload destroys 3D printed parts due to untamped kinetic shock ($15\text{+ Joules}$ slamming into stops).
- **Controlled Release Lever / Cocking Cable:** The cocking handle or cable must allow an operator to hold the spring tension with one hand, disengage the trigger sear with the other, and gently ease the spring back to its uncompressed rest position.

### 4.4 Safety Principle 4: Controlled Trajectory & "Keep-Out" Zone
1. **Fixed Angle Lock:** The barrel elevation angle ($\theta = 65^\circ \pm 2^\circ$) and azimuth angle must be mechanically locked with positive detents (no loose friction knobs that can slip during a show).
2. **Performer Stand-Off:** The catching performer stands at a marked field coordinate ($10.0\text{ ft}$ downrange). No other student or volunteer may enter the $15\text{-foot}$ conical trajectory corridor during the firing sequence.
3. **Muzzle Blast Damper / Elastomeric Stop:** The internal pusher shuttle must decelerate against dual high-durometer polyurethane (90A TPU or Sorbothane) bump stops at the end of its stroke, capturing the carriage silently and preventing secondary kickback.

---

## 5. Mechanical Design & Release Mechanism Evaluation

Based on findings from `Test 001`, the release mechanism is the critical engineering subsystem.

```
RELEASE MECHANISM ARCHITECTURES
┌───────────────────────────────────┬───────────────────────────────────┐
│ Sliding Sear (Test 001 Prototype) │ Rolling Sear / Rotary Dog (Rec.)  │
├───────────────────────────────────┼───────────────────────────────────┤
│ • High friction under load        │ • Pure rolling contact (bearings) │
│ • Latch slides across pusher      │ • Near-zero trigger break force   │
│ • Energy loss & trigger drag      │ • Instantaneous clean release     │
│ • Wear on 3D printed contact lips │ • Zero drag on moving shuttle     │
└───────────────────────────────────┴───────────────────────────────────┘
```

### 5.1 Critique of Prototype `Test 001` (Sliding Pivot Sear)
In `Test Designs/Releases/Test 001/Release-Catch.step`:
- **Failure Mode 1 (Friction & Velocity Degradation):** As the trigger releases, the sear nose must slide across the loaded face of the test plate under $40\text{+ lbs}$ of normal force. This sliding friction ($F_{\text{friction}} = \mu N$) creates significant drag, robing energy during the first critical inches of acceleration.
- **Failure Mode 2 (Under-Riding Drag):** As noted in the test notes, the ball of the catch rides against the underside of the shuttle mass throughout the launch stroke.
- **Failure Mode 3 (Stroke Truncation):** The spring was constrained from full extension.

### 5.2 Recommended Architecture: Rolling Sear or Over-Center Toggle Lock
To eliminate sliding friction under high spring loads, two proven mechanisms are recommended:

1. **Option A: Rolling Sear (Ball-Bearing Catch):**
   - The shuttle engagement tooth catches against a hardened precision needle or miniature ball bearing mounted on a swinging trigger arm.
   - When the trigger is pulled, the bearing rolls off the tooth rather than sliding.
   - Trigger pull force drops from $\approx 15\text{ lbs}$ down to $< 2.5\text{ lbs}$.
   - Once released, the sear drops completely below the shuttle guide channel with zero contact during the acceleration stroke.

2. **Option B: Push-Rod / Over-Center Pneumatic Assist:**
   - For ultra-clean field operation, an enclosed low-pressure pneumatic cylinder ($30\text{–}50\text{ psi}$ charged from a small bicycle tire inflator or $12\text{V}$ mini compressor) with an electric solenoid valve triggered via sub-GHz 915 MHz RF.
   - *However, per project mandate, a 100% mechanical spring-loaded system is preferred for simplicity and reliability.*

3. **Option C: Drop-Latch / Rotary Sear (Crossbow / Skeet Trap Style):**
   - A rotating sear dog rotates $90^\circ$ to clear the path completely as soon as the trigger lever slips past center.

---

## 6. Colorado Bandmasters Association (CBA) & Competition Rule Compliance

| CBA Rule | Rule Requirement | Flag Thrower Compliance Engineering |
|---|---|---|
| **Rule 8.05 (Turf Protection)** | Props must not tear, gouge, puncture, or stain artificial synthetic turf fields. | Base plate must feature wide, radiused chamfered edges ($> 12\text{″} \times 12\text{″}$ footprint) with smooth marine-grade high-density polyethylene (HDPE) or carpet/felt underlayment. Ground contact pressure $< 2.0\text{ psi}$. |
| **Rule 8.05 (Rapid Egress)** | Props must clear the field gate in $< 2\text{ minutes}$ during continuous exit. | Thrower mounts onto a lightweight rolling prop base or incorporates integral transport wheels ($4\text{″}$ non-marking polyurethane) with an ergonomic pull handle. Total unit mass $< 25\text{ lbs}$. |
| **Rule 9.00 (Prohibited Items)** | Zero pyrotechnics, chemical explosives, compressed flammable gases, or combustion engines. | 100% compliant: System uses purely mechanical helical compression springs (McMaster-Carr stock) or mechanical gas springs. Zero combustion or chemical propellants. |
| **Rule 8.05 (Staging Safety)** | Props staged in the endzone chute must not pose hazards to moving student units. | Redundant mechanical arming pin with bright streamer remains locked in place until the band takes the field. Safe manual decocking protocol allows disarming without firing. |

---

## 7. Shop Fabrication Feasibility (Using Verified Shop Tooling)

The device can be fabricated in the PCHS shop using existing equipment:

1. **3-Axis Woodworking CNC Router:**
   - Mill the main barrel support cradle, chassis side plates, and guide tracks from $1/2\text{″}$ to $3/4\text{″}$ Baltic birch plywood or $1/4\text{″}$ HDPE/Delrin sheet.
   - Precision-cut bearing pockets and sear pivot holes to tight tolerances ($< \pm 0.005\text{″}$).
2. **Bambu X1C / X2D / P2S 3D Printers:**
   - Print the internal pusher shuttle / cup in **PETG-CF** or **ASA** with high infill ($60\text{–}80\%$, 6 perimeters) for maximum impact resistance.
   - Print terminal decelerator bump-stop pads in **90A TPU** to absorb residual shuttle kinetic energy.
   - Print the trigger housing and arming pin guide collars.
3. **Manual Plasma Cutter & Welder:**
   - Fabricate the angled barrel mast bracket and ground stabilization base from standard $1.25\text{″}$ EMT conduit or $1.0\text{″}$ square steel tubing.
   - Weld heavy-duty pivot trunnions for adjusting launch elevation between $55^\circ$ and $75^\circ$.
4. **Standard Off-the-Shelf Hardware (McMaster-Carr):**
   - Helical compression springs (e.g., $k \approx 3.5\text{–}4.5\text{ lbf/in}$, $L_0 \approx 12\text{–}15\text{ in}$).
   - $1/4\text{″}$ stainless steel shoulder bolts for low-friction pivot points.
   - Miniature sealed ball bearings for rolling sear release.
