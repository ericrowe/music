---
name: simulate-prop-photometrics
description: >-
  Calculate photometric visibility, Weber JND daylight contrast thresholds, atmospheric
  Rayleigh scattering in clean mountain air, and photogrammetric human field scaling for
  stadium marching band props, rolling backdrops, and field luminaires. Generates physics-grounded
  prompts and deterministic sub-pixel composited visuals that eliminate diffusion hallucinations.
---

# Simulate Prop Photometrics & Photogrammetric Field Scaling

This skill provides an automated physics-first simulation engine, optical reference library, and visual compositing pipeline for evaluating and generating realistic concept renders of marching band field props, luminaires, and scenic elements in stadium environments.

---

## 1. When to Use This Skill

Activate this skill when:
- Evaluating **photometric visibility** of prop lighting, LEDs, beacons, screens, or lanterns from high stadium seating (e.g. Falcon Stadium West Press Box at $150\text{–}300\text{+ ft}$ slant range).
- Calculating **Weber-Fechner Just Noticeable Difference (JND)** contrast thresholds under intense ambient conditions ($90,000\text{ lux}$ midday sun vs $1,000\text{ lux}$ night sports lighting).
- Determining whether prop light spills (ground wash) are physically perceptible on turf or washed out by ambient sunlight.
- Modeling **atmospheric optical transmission** (Rayleigh scattering vs volumetric aerosols) to eliminate unphysical "floating neon rings", glowing energy halos, or laser shafts in clean air.
- Calibrating **photogrammetric human and prop scale** on a marked athletic field (5-yard line grid fiducials) to eliminate AI diffusion hallucinations (e.g., giant 8-foot students or 6-foot handheld lanterns).
- Generating physics-grounded prompt specifications and assembling deterministic, side-by-side comparative lineups.

---

## 2. The Simulation-First Visualization Pipeline

Unconstrained diffusion models invariably fail at physical optics and human scale: they draw 8-foot tall performers, 4-yard-wide shoulders, giant 6-foot props, floating neon rings in clear air, and radioactive neon ground wash under full sun.

To guarantee physical accuracy, this skill enforces a **strict 5-phase pipeline**:

```
Design & CAD Specifications (Dimensions, Lumens, Candela, Beam Angles)
  │
  ▼
[Phase 1] Mathematical Optical & Photometric Simulation (Python CLI)
  │  - Slant range & elevation angle from press box (72.5 m, +14.6°)
  │  - Inverse-square law illuminance at judge's eye (E_judge = I / d^2)
  │  - Source apparent luminance vs ambient turf luminance (L_turf = 3,438 cd/m^2)
  │  - Weber JND daylight threshold: ΔI = 0.02 * E_sun = 1,800 lux
  │  - Rayleigh scattering optical depth: μ_s * L ≈ 1.1e-6 (air is 100% transparent)
  ▼
[Phase 2] Photogrammetric Field Scale Calibration
  │  - Field grid measurement (5-yard line = 15 ft = 46.5 px @ 9.30 px/yd)
  │  - Performer height bounding (5'0" student = 15.5 px; + shako/plume = 20.2 px)
  │  - Shoulder width bounding (15" = 3.8 px)
  │  - Prop aperture footprint (12" = 3.1 px)
  ▼
[Phase 3] Physics-Grounded Prompt Specification
  │  - Positive optical signatures (point-source diamond sparks, black-matrix silhouette)
  │  - Strict negative physics constraints (NO floating rings, NO daytime ground wash)
  ▼
[Phase 4] Deterministic Sub-Pixel Compositing & Lineup Assembly
  │  - Identical baseplate stadium plate
  │  - 4x supersampled anti-aliased integration of performers & props
  │  - Exact horizontal registration across options
  ▼
[Phase 5] Human-In-The-Loop (HITL) Visual Review
     - 100% all-figure inspection, Weber contrast compliance, zero artifacts
```

---

## 3. Core Physics & Photometric Principles

### A. Daylight Contrast & Weber-Fechner Law
Under bright Rocky Mountain sunlight at $6,500\text{ ft}$ ASL:
- Ambient solar illuminance: $E_{\text{sun}} \approx 90,000\text{ lux}$
- Synthetic turf diffuse albedo: $\rho_{\text{turf}} \approx 0.12$
- Ambient turf luminance: $L_{\text{turf}} = \frac{E_{\text{sun}} \times \rho_{\text{turf}}}{\pi} \approx 3,438\text{ cd/m}^2$
- Weber contrast threshold for human photopic vision: $\Delta I / I \ge 0.02$ ($2\%$)
- **Minimum detectable ground wash:** $\Delta E_{\text{min}} = 0.02 \times 90,000 = \mathbf{1,800\text{ lux}}$

> [!IMPORTANT]
> **Turf Wash Invariant:** If a prop produces $< 850\text{ lux}$ on adjacent grass blades ($0.25\text{ m}$ away), it delivers less than $47\%$ of the Weber JND perception limit. In direct daylight, the turf MUST be rendered as **clean, natural green grass with zero colored glow or wash**.

### B. Atmospheric Optics in Clean Air
In clear Colorado mountain air ($6,500\text{ ft}$ ASL), the Rayleigh scattering cross section yields an extinction coefficient $\mu_s \approx 1.1 \times 10^{-5}\text{ m}^{-1}$ at $\lambda = 500\text{ nm}$. Over an internal lantern cavity length of $0.1\text{ m}$:
$$\mu_s \times L \approx 1.1 \times 10^{-6} \quad (99.9999\%\text{ transparent})$$
Without artificial smoke, fog, or dust, light traveling through air is **completely invisible**. Emitters appear as brilliant specular cone reflections and point-source sparks, but the air cavity is $100\%$ clear.

### C. Photogrammetric Scale on Athletic Fields
On an athletic field viewed from an elevated press box:
- $5\text{ yards} = 15\text{ feet} = 180\text{ inches} = 4.572\text{ meters}$.
- In a standard $1920 \times 1080$ stadium frame, $5\text{ yards}$ at midfield measures $\approx 46.5\text{ px}$ $\implies \mathbf{9.30\text{ px/yd}}$ ($3.10\text{ px/ft}$).
- A $5\text{ ft } 0\text{ in}$ student ($1.67\text{ yd}$) is exactly **$15.5\text{ px}$ tall**.
- A $10\text{″}$ shako hat adds **$2.6\text{ px}$**; an $8\text{″}$ plume adds **$2.1\text{ px}$** (total figure height $= \mathbf{20.2\text{ px}}$).
- Performer shoulder width ($15\text{ inches}$) is **$3.8\text{ px}$**.
- A $12\text{″} \times 4.5\text{″}$ handheld prop is **$3.1\text{ px} \times 1.2\text{ px}$**.

---

## 4. Helper Scripts & CLI Tooling

The skill provides four standalone CLI scripts in `scripts/`:

```bash
# 1. Photometric simulation of stadium press box visibility & contrast
python3 .agents/skills/simulate-prop-photometrics/scripts/simulate_photometrics.py

# 2. Close-up macro photometrics & Weber JND ground wash analysis
python3 .agents/skills/simulate-prop-photometrics/scripts/simulate_closeups.py

# 3. Photogrammetric field scale calibration from image fiducials
python3 .agents/skills/simulate-prop-photometrics/scripts/calibrate_field_scale.py \
  --image path/to/stadium.jpg --p50-x 960 --p45-x 1006.5

# 4. Deterministic lineup assembly & sub-pixel compositing
python3 .agents/skills/simulate-prop-photometrics/scripts/assemble_lineup.py \
  --base path/to/clean_stadium.jpg --renders-dir path/to/options/ --out path/to/lineup.jpg
```

---

## 5. Technical References

Detailed derivations and optical geometry tables are located in `references/`:
- [`references/FALCON_STADIUM_GEOMETRY.md`](references/FALCON_STADIUM_GEOMETRY.md): West Press Box elevation ($60\text{ ft}$), setback ($150\text{ ft}$), slant range ($238\text{ ft} / 72.5\text{ m}$), and sightline elevation angles.
- [`references/DAYLIGHT_WEBER_CONTRAST.md`](references/DAYLIGHT_WEBER_CONTRAST.md): Solar illuminance at $6,500\text{ ft}$ ASL, synthetic turf albedo, Weber-Fechner photopic threshold derivations, and camera sensor dynamic range limits.
- [`references/OPTICAL_PHYSICS_AIR_SCATTERING.md`](references/OPTICAL_PHYSICS_AIR_SCATTERING.md): Rayleigh scattering math, specular reflectance vs volumetric haze, and the physics debunking the "Tron Ring" optical fallacy.
- [`references/FIELD_PHOTOGRAMMETRY_SCALE.md`](references/FIELD_PHOTOGRAMMETRY_SCALE.md): Athletic field regulation grid lines, performer anthropometry, and sub-pixel compositing standards.
