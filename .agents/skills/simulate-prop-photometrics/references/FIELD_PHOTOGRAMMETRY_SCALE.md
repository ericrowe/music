# Field Photogrammetry & Performer Scale Calibration

This reference document establishes the photogrammetric measurement standards, fiducial grid scaling, and human anthropometric baselines used to eliminate **scale hallucinations** in AI concept renders of athletic field props.

---

## 1. Athletic Field Grid as Metric Fiducials

An American football field (NCAA / NFHS / CBA) provides an exact, calibrated metric grid:

```
|        |        |        |        |        |
|   40   |   45   |   50   |   45   |   40   |
|        |        |        |        |        |
|<──────>|<──────>|<──────>|<──────>|<──────>|
  5.0 yd   5.0 yd   5.0 yd   5.0 yd   5.0 yd
  15.0 ft  15.0 ft  15.0 ft  15.0 ft  15.0 ft
  180 in   180 in   180 in   180 in   180 in
  4.57 m   4.57 m   4.57 m   4.57 m   4.57 m
```

Every $5\text{-yard}$ interval is exactly **$15.0\text{ ft}$ ($180.0\text{ inches}$ / $4.572\text{ m}$)**.

---

## 2. High School Marching Band Anthropometry

High school marching band performers range in height from approximately $5\text{ ft } 0\text{ in}$ to $6\text{ ft } 0\text{ in}$. 

For rigorous scale calibration, a **$5\text{ ft } 0\text{ in}$ ($60.0\text{ inches}$ / $1.524\text{ m}$)** student performer is chosen as the baseline:

| Anatomical / Equipment Component | Dimension (Inches) | Dimension (Feet) | Dimension (Yards) |
|---|---|---|---|
| **Student Body Height (Barefoot / Shoes)** | **$60.0\text{″}$** | **$5.00\text{ ft}$** | **$1.67\text{ yd}$** |
| **Marching Shako Hat** | $10.0\text{″}$ | $0.83\text{ ft}$ | $0.28\text{ yd}$ |
| **Marching Plume (Horsehair/Feather)** | $8.0\text{″}$ | $0.67\text{ ft}$ | $0.22\text{ yd}$ |
| **Total Performer Height (With Headgear)** | **$78.0\text{″}$** | **$6.50\text{ ft}$** | **$2.17\text{ yd}$** |
| **Shoulder Breadth (Bi-Deltoid)** | **$15.0\text{″}$** | **$1.25\text{ ft}$** | **$0.42\text{ yd}$** |
| **Handheld Field Lantern Prop** | **$12.0\text{″} \times 4.5\text{″}$** | **$1.00\text{ ft} \times 0.38\text{ ft}$** | **$0.33\text{ yd} \times 0.12\text{ yd}$** |

---

## 3. Pixel Calibration on Stadium Renders

When rendering Falcon Stadium from the West Press Box:
1. In a standard render frame ($1920 \times 1080$ or $1024 \times 1024$), the lateral distance between the 50-yard line and 45-yard line is measured:
   $$\text{Interval} = 46.5\text{ pixels across } 5.0\text{ yards}$$
2. **Derived Spatial Resolution:**
   $$\text{Scale} = \frac{46.5\text{ px}}{5.0\text{ yd}} = \mathbf{9.30\text{ px/yd}} = \mathbf{3.10\text{ px/ft}} = \mathbf{0.258\text{ px/in}}$$
3. **Exact Pixel Footprints on Turf:**
   - Student Body ($5\text{' } 0\text{″}$): $5.00\text{ ft} \times 3.10\text{ px/ft} = \mathbf{15.5\text{ px}}$
   - Shako + Plume ($18\text{″}$): $1.50\text{ ft} \times 3.10\text{ px/ft} = \mathbf{4.7\text{ px}}$
   - **Total Performer Figure:** $15.5 + 4.7 = \mathbf{20.2\text{ px}}$
   - **Shoulder Width:** $15\text{″} \times 0.258\text{ px/in} = \mathbf{3.8\text{ px}}$
   - **Handheld Prop:** $12\text{″} \times 4.5\text{″} = \mathbf{3.1\text{ px H}} \times \mathbf{1.2\text{ px W}}$

---

## 4. The "Giant Student" Diffusion Hallucination

When generative AI models are prompted with text alone ("a student standing at the 50-yard line holding a 12-inch lantern"):
1. The model's attention mechanism centers on the human figure and enlarges it to be aesthetically prominent.
2. The performer is typically drawn at **$35\text{–}50\text{ px}$ tall** and **$15\text{–}20\text{ px}$ wide**.
3. At $9.30\text{ px/yd}$, a $35\text{ px}$ figure represents a **$3.76\text{-yard}$ ($11.3\text{-foot}$) tall giant** with a **$2.0\text{-yard}$ ($6.0\text{-foot}$) shoulder span**.
4. The 12-inch lantern is drawn at the performer's arm scale, becoming a **$6.5\text{-foot}$ tall oil drum**!

### Mitigation Protocol (Deterministic Super-Sampled Compositing):
1. **Calibrate:** Run `scripts/calibrate_field_scale.py` to establish the exact pixel height and width bounds.
2. **Supersample:** Render the isolated performer and prop silhouette at $4\times$ resolution ($80.8\text{ px}$ tall).
3. **Downsample & Anti-Alias:** Downscale using Lanczos resampling to exactly $20.2\text{ px}$ tall by $3.8\text{ px}$ wide.
4. **Composite:** Alpha-blend onto the fixed stadium background plate with a subtle contact shadow ($2\text{ px}$ semi-transparent drop shadow on turf).
5. **Verify:** Check lineup comparisons with `scripts/assemble_lineup.py` to confirm identical student scale across all options.
