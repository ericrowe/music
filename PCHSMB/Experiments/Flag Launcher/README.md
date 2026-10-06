# PCHSMB Color Guard Flag Thrower — Mechanical Engineering & Prototyping

**Subproject:** `Experiments/Flag Launcher/`  
**Purpose:** Mechanical flag delivery system designed to execute a short-range ($6\text{–}10\text{ ft}$), high-arc choreographed toss of a color guard flag to a student catcher during a competitive marching band show.  
**Governing Standard:** Colorado Bandmasters Association (CBA) Rules 8.05–9.07 & Bands of America (BOA) Field Safety  

---

## 1. Project Overview & Performance Goals

The **Flag Thrower** prop is engineered to provide a reliable, repeatable, and safe mechanical toss of a standard $6\text{-foot}$ color guard flag ($1.5\text{–}2.0\text{ lbs}$) from a concealed field scenic prop directly into the hands of a performing color guard student.

### Key Target Specifications:
- **Horizontal Range ($R$):** $6.0\text{ to }10.0\text{ feet}$ ($1.8\text{ to }3.0\text{ m}$).
- **Launch Angle ($\theta$):** Steep $65^\circ \pm 3^\circ$ parabolic theatrical arc (decelerates at apex for visual tracking, rather than a dangerous horizontal dart).
- **Muzzle Velocity ($v_0$):** $\approx 20.5\text{ ft/s}$ ($14.0\text{ mph}$) at release.
- **Flight Hang Time ($T$):** $\approx 1.15\text{ seconds}$ (matching natural two-count flag toss choreography).
- **Trajectory Apex ($H$):** $\approx 5.4\text{ ft}$ above muzzle release height ($7.0\text{–}7.5\text{ ft}$ above turf).
- **Payload Kinetic Energy:** $11.4\text{ ft}\cdot\text{lbf}$ ($15.5\text{ Joules}$) at release.

---

## 2. Directory Structure & Project Assets

```
Experiments/Flag Launcher/
├── README.md                                # Master project documentation & engineering log
├── Flag Launcher Spring Calculations.xlsx   # Spring rate, deflection, kinetic energy & range model
├── docs/
│   └── 01_REQUIREMENTS_AND_SAFETY_SPECIFICATION.md  # Detailed mechanical & safety specification
└── Test Designs/
    ├── README.md
    ├── Model/                               # Scale prototype test files
    │   └── Chopstick Launcher/
    │       ├── README.md                    # Single-spring chopstick launch test notes (18 ft throw)
    │       ├── flag_model.FCStd             # Master FreeCAD assembly
    │       ├── flag_model x2.FCStd          # Dual-spring iteration CAD
    │       ├── Chopstick Scaled 01/         # Scaled geometry study
    │       ├── images/cad.png               # CAD render plate
    │       └── *.step & *.3mf               # Exported solids & slicer mesh parts
    └── Releases/                            # Trigger & sear mechanism development
        ├── README.md                        # Release mechanism evolution overview
        └── Test 001/
            ├── README.md                    # Trigger release test report & friction observations
            ├── Release.FCStd                # FreeCAD release assembly
            ├── images/cad.png               # Mechanism cross-section
            └── *.step & *.3mf               # Component solids & 3D print meshes
```

---

## 3. Empirical Test Findings & Key Learnings

### Test 1: Scale Chopstick Launcher (`Test Designs/Model/Chopstick Launcher/`)
- **Apparatus:** 3D printed scale barrel using McMaster-Carr spring [9657K108](https://www.mcmaster.com/9657K108/) ($k = 4.36\text{ lbf/in}$, $0.795\text{″}$ deflection).
- **Result:** Successfully tossed a scale chopstick payload ($m = 0.00615\text{ lbs} \approx 2.8\text{ g}$) across **$18\text{ feet}$**, verifying basic spring-to-mass kinetic transfer.

### Test 2: Trigger Release Mechanism `Test 001` (`Test Designs/Releases/Test 001/`)
- **Apparatus:** Oversized trigger sear latching onto a sliding test plate/pusher carriage.
- **Critical Observations & Lessons Learned:**
  1. **Sliding Sear Friction:** The sliding sear tooth created heavy friction under normal spring loads, significantly dragging during release and degrading initial velocity.
  2. **Under-Riding Drag:** The catch protrusion continued to drag against the underside of the moving carriage throughout the launch stroke.
  3. **Stroke Limitation:** The spring was partially constrained, preventing full expansion and complete energy release.
  4. **The Safe Unloading Imperative:** Attempting to latch directly onto a notch in the flag pole was rejected. If the flag pole is notched and held under tension, it cannot be safely unloaded in the event of an aborted show without firing the thrower. The sear **must act exclusively upon an internal captive pusher shuttle**, allowing the flag to simply drop in and be safely lifted out at any time.

---

## 4. Mathematical Physics & Calculations Review

### Unit Consistency Review (`Flag Launcher Spring Calculations.xlsx`)
In reviewing the workbook, the kinetic energy equation $v = \sqrt{2 \cdot PE / m}$ requires strict unit consistency:
- Potential energy is calculated in $\text{in}\cdot\text{lbf}$ ($PE = \frac{1}{2} k x^2$).
- To convert to standard velocity in $\text{ft/s}$ with payload weight $W$ in $\text{lbs}$:
  $$v_0 = \sqrt{\frac{2 \cdot g \cdot (PE / 12)}{W}} = \sqrt{\frac{5.362 \cdot PE_{\text{in}\cdot\text{lbf}}}{W}}$$
- For a $W = 1.75\text{ lb}$ flag with $137\text{ in}\cdot\text{lbf}$ of required kinetic energy ($v_0 = 20.5\text{ ft/s}$):
  Accounting for $\approx 54\%$ real-world mechanical efficiency (carriage mass split, rail friction, and spring hysteresis), the gross spring energy required is:
  $$PE_{\text{gross}} \approx \mathbf{254\text{ in}\cdot\text{lbf}} \quad (21.2\text{ ft}\cdot\text{lbf})$$

### Recommended Full-Scale Spring Parameters:
- **Stroke ($x$):** $10.0\text{ to }12.0\text{ inches}$.
- **Spring Constant ($k$):** $3.5\text{ to }4.5\text{ lbf/in}$ (e.g., McMaster [9637K27](https://www.mcmaster.com/9637K27/) or [9637K25](https://www.mcmaster.com/9637K25/) in series/parallel configurations).
- **Peak Cocking Force:** $35\text{–}45\text{ lbs}$ (easily managed with a manual foot-stirrup and T-handle pull cable).

---

## 5. Mandatory Safety Interlock Standards

1. **Captive Internal Shuttle:** Spring force acts solely on an internal sliding carriage; the flag rests freely in a receiver cup and can be lifted out by hand at any moment without discharging energy.
2. **Positive Redundant Arming Pin:** A physical 5/16″ stainless steel lockout pin with a bright red **"REMOVE BEFORE USE"** safety flag physically obstructs carriage forward motion during staging and transport.
3. **Safe Manual Decocking:** A controlled cable/handle allows disarming the compressed spring without dry-firing.
4. **TPU Kinetic Decelerator Pads:** 90A TPU elastomeric bump stops capture the empty carriage at the end of the stroke, preventing mechanical shock or part breakage.
5. **CBA Rule 8.05 Turf Protection:** Wide base plate ($> 12\text{″} \times 12\text{″}$) with chamfered smooth HDPE skids ($< 2.0\text{ psi}$ ground pressure). Zero field damage.
6. **Line-of-Fire Clear Zone:** $15\text{-foot}$ designated conical safety corridor between the thrower and the assigned color guard catcher.

---

## 6. Next Steps & Development Roadmap

1. **Release Mechanism Test 002 (Rolling Sear):**
   - Design and print a miniature ball-bearing rolling sear or rotary dog latch to replace the sliding sear of Test 001, eliminating trigger drag and ensuring full stroke release.
2. **Full-Scale Shuttle & Barrel Prototype:**
   - Mill barrel support cradles on 3-axis CNC router from Baltic birch or HDPE.
   - Print lightweight PETG-CF captive pusher shuttle with integral TPU impact bumpers.
3. **Field Trajectory & Catch Verification:**
   - Conduct physical test throws with a weighted mock flag pole on turf.
   - Measure actual flight times and dispersion patterns in $0\text{–}15\text{ mph}$ Colorado outdoor wind conditions.
