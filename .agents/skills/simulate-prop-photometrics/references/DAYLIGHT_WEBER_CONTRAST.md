# Daylight Photometrics & Weber-Fechner Contrast Thresholds

This reference document defines the mathematical models governing human visual contrast perception and camera sensor dynamic range under direct Rocky Mountain sunlight ($6,500\text{ ft}$ ASL), proving why artificial ground wash on synthetic turf is physically undetectable in daylight.

---

## 1. Environmental Solar Baseline (Colorado Springs, 6,500 ft ASL)

At high elevation, the reduced atmospheric air mass ($AM \approx 1.1$) increases direct solar illuminance:

| Parameter | Value | Notes |
|---|---|---|
| **$E_{\text{sun}}$ (Direct Midday Sun)** | **$90,000\text{–}105,000\text{ lux}$** | Unobstructed Rocky Mountain summer/fall sky. |
| **$\rho_{\text{turf}}$ (Synthetic Turf Albedo)** | **$0.12$ ($12\%$)** | Green polyethylene fibers with black SBR rubber crumb infill. |
| **$L_{\text{turf}}$ (Ambient Turf Luminance)** | **$3,437.7\text{ cd/m}^2$** | Diffuse Lambertian reflection: $L = \frac{E_{\text{sun}} \cdot \rho_{\text{turf}}}{\pi}$. |

---

## 2. Weber-Fechner Law of Human Contrast Perception

The human visual system operates logarithmically over an enormous luminance range. In the **photopic regime** (luminance $> 10\text{ cd/m}^2$), contrast sensitivity is governed by the **Weber Fraction**:

$$\frac{\Delta I}{I} \ge c_W$$

Where:
- $I$ is the background adaptation luminance (or illuminance).
- $\Delta I$ is the incremental threshold luminance/illuminance required to detect a difference.
- $c_W$ is the Weber constant for photopic daylight vision, established by CIE and the Barten CSF model as **$c_W \approx 0.015\text{–}0.020$ ($1.5\%\text{–}2.0\%$)**.

### Calculation of Minimum Detectable Ground Illuminance:

$$\Delta E_{\text{min}} = c_W \times E_{\text{sun}} = 0.02 \times 90,000\text{ lux} = \mathbf{1,800\text{ lux}}$$

Any secondary light source (such as prop beam spill, reflection, or ground scatter) delivering **less than $1,800\text{ lux}$** onto the synthetic turf produces an illuminance delta smaller than the eye's detection threshold.

---

## 3. Ground Wash Analysis for Prop Architectures

### Evaluation at Close Range ($r = 0.25\text{ m}$ / Adjacent Grass Blades)

| Prop Architecture | Intensity ($I$) | Downward Spill ($I_{\text{down}}$) | Turf Illuminance ($E_{\text{turf}}$) | % of Weber JND | Visual Perception on Turf |
|---|---|---|---|---|---|
| **Option 1: Radial COB Column** | $629\text{ cd}$ | $5\%$ uncollimated flux | $222.8\text{ lux}$ | $12.4\%$ | **COMPLETELY INVISIBLE** |
| **Option 2: Conical Reflector** | $3,200\text{ cd}$ | $< 0.5\%$ stray parasitic | $256.0\text{ lux}$ | $14.2\%$ | **COMPLETELY INVISIBLE** |
| **Option 3: 10° Fresnel Spotlight** | $11,500\text{ cd}$ | $1.0\%$ edge halo spill | $1,840.0\text{ lux}$ | $102.2\%$ | **Barely Perceptible Glint** |
| **Option 4: Outdoor LED Tile** | $185\text{ cd}$ | $2.0\%$ diffuse scatter | $59.2\text{ lux}$ | $3.3\%$ | **COMPLETELY INVISIBLE** |
| **Option 5: Dual COB Blinder** | $5,200\text{ cd}$ | $1.0\%$ bezel scatter | $832.0\text{ lux}$ | $46.2\%$ | **COMPLETELY INVISIBLE** |

### Evaluation from Press Box ($d = 72.5\text{ m}$, $r_{\text{ground}} = 5.0\text{ m}$)
At a distance of $5\text{ meters}$ from the performer:
- Ground wash illuminance from any handheld prop is **$< 5.0\text{ lux}$**.
- Compared to the $1,800\text{ lux}$ Weber threshold, ground wash produces **$< 0.28\%$ of the required contrast**.

> [!CAUTION]
> **The "Radioactive Turf" Hallucination:**  
> AI diffusion models typically generate glowing neon circular puddles or spray-painted green washes across the football field under bright daylight. In real-world physics, this is an optical impossibility. All daylight concept renders **MUST depict clean, natural green turf with crisp white painted lines and zero colored ground wash**.

---

## 4. The "Black Matrix" Contrast Multiplier (Option 4)

Option 4 leverages the **Black Matrix Principle** to achieve superior daylight visibility without blinding candela:
1. Molded matte-black polycarbonate louver masks surround each SMD LED package.
2. The black matrix absorbs **$97.5\%$ of incident sunlight** ($\rho_{\text{matrix}} = 0.025$).
3. Ambient sunlight reflected off the tile is reduced to:
   $$L_{\text{refl}} = \frac{90,000 \times 0.025}{\pi} \approx 716.2\text{ cd/m}^2$$
4. With active calibrated pixel emission of $6,500\text{ nits}$, the contrast ratio against the bright sunlit turf is:
   $$\text{Contrast Ratio} = \frac{6,500 + 716.2}{3,437.7} \approx \mathbf{2.1 : 1}$$
5. The prop appears as a crisp, stark, razor-sharp dark monolith displaying saturated, unwashed fiery animations.
