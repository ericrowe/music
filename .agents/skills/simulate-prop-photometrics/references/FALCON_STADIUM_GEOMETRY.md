# Falcon Stadium Press Box Geometry & Optical Sightlines

This reference document defines the physical sightlines, geometric coordinates, slant range distances, and vertical elevation angles from the West Press Box at **Falcon Stadium (US Air Force Academy, Colorado Springs, CO)** down to an athletic field performer at centerfield (50-yard line).

---

## 1. Stadium Geometry & Coordinate System

Falcon Stadium sits at an elevation of approximately **$6,621\text{ ft}$ ($2,018\text{ m}$)** above sea level. The stadium features a massive multi-tiered West Press Box tower overlooking the field facing East toward the Rampart Range foothills and eastern plains.

```
WEST PRESS BOX
┌──────────────────────┐
│ Adjudicator Booth    │ (Elevation h_pb = 18.29 m / 60.0 ft above turf)
└──────────┬───────────┘
           │ \
           │   \
           │     \  Slant Range: d = 72.45 m (237.7 ft)
           │       \  Elevation Angle: θ = 14.62°
           │         \
           │           \
═══════════╧═════════════▼════════════════════════════════════════
WEST SIDELINE         CENTERFIELD PERFORMER (50-YD LINE)
Setback: d_set = 45.72 m   Field Inset: y_field = 24.38 m
Total Horizontal Distance: D_horiz = 70.10 m (230.0 ft)
```

### Numerical Constants

| Parameter | Metric Value | Imperial Value | Description |
|---|---|---|---|
| **$h_{\text{pb}}$** | $18.29\text{ m}$ | $60.0\text{ ft}$ | Press box window sill / judge eye height above field level. |
| **$d_{\text{setback}}$** | $45.72\text{ m}$ | $150.0\text{ ft}$ | Horizontal setback from West sideline to press box facade. |
| **$y_{\text{field}}$** | $24.38\text{ m}$ | $80.0\text{ ft}$ | Centerfield position (midway between college hashes, 50-yd line). |
| **$D_{\text{horiz}}$** | $70.10\text{ m}$ | $230.0\text{ ft}$ | Total horizontal ground distance ($d_{\text{setback}} + y_{\text{field}}$). |
| **$d_{\text{slant}}$** | **$72.45\text{ m}$** | **$237.7\text{ ft}$** | Line-of-sight distance ($\sqrt{D_{\text{horiz}}^2 + h_{\text{pb}}^2}$). |
| **$\theta_{\text{elev}}$** | **$14.62^\circ$** | $14.62^\circ$ | Downward viewing elevation angle ($\arctan(h_{\text{pb}} / D_{\text{horiz}})$). |

---

## 2. Viewing Angles Across Field Zones

Depending on performer drill positioning, the viewing distance and elevation angle shift:

| Field Position | Horiz Dist ($D_{\text{horiz}}$) | Slant Range ($d$) | Elevation Angle ($\theta$) |
|---|---|---|---|
| **Front Sideline (West)** | $45.72\text{ m}$ ($150\text{ ft}$) | $49.24\text{ m}$ ($161.5\text{ ft}$) | $21.80^\circ$ |
| **Front Hash (West)** | $57.91\text{ m}$ ($190\text{ ft}$) | $60.73\text{ m}$ ($199.2\text{ ft}$) | $17.51^\circ$ |
| **Midfield (Between Hashes)** | **$70.10\text{ m}$ ($230\text{ ft}$)** | **$72.45\text{ m}$ ($237.7\text{ ft}$)** | **$14.62^\circ$** |
| **Back Hash (East)** | $82.30\text{ m}$ ($270\text{ ft}$)** | $84.31\text{ m}$ ($276.6\text{ ft}$) | $12.53^\circ$ |
| **Back Sideline (East)** | $94.49\text{ m}$ ($310\text{ ft}$) | $96.24\text{ m}$ ($315.7\text{ ft}$) | $10.96^\circ$ |

---

## 3. Photometric Implications

### 1. Beam Angle Optimization (Elevation Cant)
Because the line of sight to adjudicators is canted downward at $\mathbf{+14.6^\circ}$, any directional luminaire aimed horizontally ($0^\circ$) loses significant luminous flux. 
- For **Option 2 (Conical Reflector Engine)**, the inverted $47^\circ$ mirror cone is mathematically optimized to reflect vertical COB rays into a fan centered at **$+14.6^\circ$ elevation**, directing peak candela directly into the press box window.
- For **Option 3 and Option 5 (Collimated Lenses)**, performers are instructed to angle fixtures upward by $15^\circ$ toward the home box during key musical hits.

### 2. Perspective Foreshortening on Synthetic Turf
Because of the shallow $14.6^\circ$ viewing angle:
- The apparent vertical dimension of the football field is heavily foreshortened:
  $$\text{Foreshortening Factor} = \sin(14.62^\circ) \approx 0.252$$
- A $5\text{-yard}$ interval ($15\text{ ft}$) in the lateral (X) direction appears **$3.96\times$ wider** than a $5\text{-yard}$ interval in the depth (Y) direction.
- Handheld vertical props retain their full upright silhouette with minimal perspective compression.
