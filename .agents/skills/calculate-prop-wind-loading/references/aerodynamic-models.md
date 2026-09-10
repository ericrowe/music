# Engineering Aerodynamic Models & Wind Loading Reference

This document provides the foundational fluid mechanics, aerodynamic formulations, stability derivations, and competition turf rules supporting the `calculate-prop-wind-loading` skill.

---

## 1. Velocity Pressure Formulation

Aerodynamic velocity pressure ($q$) is derived from Bernoulli's equation for stagnation pressure:

$$q = \frac{1}{2} \rho V^2$$

Where:
- $\rho$ is mass density of air (slugs/$\text{ft}^3$ or $\text{lb}/\text{ft}^3$ divided by gravitational constant $g_c = 32.174\text{ ft/s}^2$).
- $V$ is wind velocity. Converting $V$ from miles per hour (mph) to feet per second ($1\text{ mph} = 1.46667\text{ ft/s}$):

$$q = \frac{1}{2} \cdot \left(\frac{\rho}{32.174}\right) \cdot (1.46667 \cdot V_{\text{mph}})^2 = 0.03343 \cdot \rho \cdot V_{\text{mph}}^2\text{ (psf)}$$

### Elevation & Barometric Density Scaling

Atmospheric air density decreases with altitude according to the barometric formula (US Standard Atmosphere):

$$\rho(h) = \rho_0 \cdot \left(1 - \frac{L \cdot h}{T_0}\right)^{\frac{g \cdot M}{R \cdot L}}$$

- **Sea Level Reference ($0\text{ ft}$ ASL, 59°F / 15°C):**  
  $\rho_0 = 0.07651\text{ lb/ft}^3$  
  $$q = 0.002557 \cdot V_{\text{mph}}^2\text{ (psf)}$$
- **High Altitude Venue (Colorado Springs, CO, $6,500\text{ ft}$ ASL, 65°F / 18°C):**  
  $\rho = 0.06202\text{ lb/ft}^3$  
  $$q = 0.002073 \cdot V_{\text{mph}}^2\text{ (psf)}$$

> **Travel Venue Note:** Sea-level air is $\sim 23.4\%$ denser than at Colorado Springs. A prop that withstands $18.4\text{ mph}$ gusts in Colorado Springs will reach the equivalent overturning load at just $16.6\text{ mph}$ at sea level (e.g. Lucas Oil Stadium perimeter / BOA Grand Nationals in Indianapolis).

---

## 2. Aerodynamic Drag Coefficients ($C_d$)

For rectangular flat plates perpendicular to the airflow:
- Solid flat plate (aspect ratio $H/W = 10/8 = 1.25$): $C_d \approx 1.20$.
- Banner with engineered inverted-U crescent relief slits: $C_d \approx 1.02$ ($\sim 15\%$ drag reduction).

Lateral wind force:
$$F_{\text{wind}} = q \cdot C_d \cdot A$$

Overturning moment about ground/turf pivot:
$$M_{\text{ot}} = F_{\text{wind}} \cdot h_{\text{cp}}$$
Where $h_{\text{cp}} = h_{\text{deck}} + \frac{H}{2}$.

---

## 3. Tipping Asymmetry & Restoring Moments on Rolling Chassis

When a vertical frame is mounted on the front edge of a rolling cart of depth $B$:
- **Pivot Axes:** Casters trailing under corner lumber establish the effective front pivot at $x_{\text{fwd}} \approx 1.75\text{ in.}$ and rear pivot at $x_{\text{bwd}} \approx B - 1.75\text{ in.}$.
- **Backward Tipping (Front Wind):** Pivot is $x_{\text{bwd}}$. The $48\text{ lbs}$ of vertical frame and vinyl sits at $x = 1.5\text{ in.}$, providing a large restoring arm:
  $$d_{\text{frame,bwd}} = \frac{x_{\text{bwd}} - 1.5}{12.0} \approx 3.44\text{ ft}$$
- **Forward Tipping (Rear Wind) [CRITICAL]:** Pivot is $x_{\text{fwd}}$. The vertical frame sits directly over the pivot line:
  $$d_{\text{frame,fwd}} = \frac{1.5 - x_{\text{fwd}}}{12.0} \approx -0.02\text{ ft (zero restoring arm)}$$

### Rear-Rail Leverage Advantage

The center wing posts sit at mid-depth ($x = 22.25\text{ in.}$, arm to front pivot $d = 1.71\text{ ft}$). Placing supplemental sandbags along the **rear 2x4 rail (A)** ($x = 41.5\text{ in.}$) provides:
$$d_{\text{rear}} = \frac{41.5 - 1.75}{12.0} = 3.31\text{ to }3.46\text{ ft}$$

$$\text{Leverage Multiplier} = \frac{3.46\text{ ft}}{1.71\text{ ft}} \approx 2.02\times$$
Every pound placed on the rear rail produces the forward-tipping overturning resistance of **two pounds** on the wing posts!

---

## 4. Engineered Wind Relief Slit Mechanics

### Why Slits are Necessary
While slits reduce steady-state drag by $\sim 15\%$, their primary engineering purpose is:
1. **Dynamic Gust Pressure Bleed:** Rapidly venting pressure spikes from stadium downdrafts before momentum causes the cart to tip.
2. **Flutter Suppression:** Disrupting periodic vortex shedding across the 80 sq ft surface, preventing destructive flapping oscillations that rip greenhouse snap clamps off the frame.

### Mandatory Tear-Arrest Detail
- Sharp razor corners produce a theoretical stress concentration factor $K_t \ge 3.0$ in tensioned vinyl.
- In high winds, micro-tears at sharp corners propagate instantaneously into catastrophic tears across the whole banner face.
- **Engineering Standard:** Punch two clean $\varnothing 3/8\text{ in.}$ ($10\text{ mm}$) round holes at the upper hinge corners *before* making curved razor cuts. Circular holes distribute tensile stress evenly around the circumference ($K_t \to 1.0$), permanently arresting crack propagation.

---

## 5. Competition Turf & Ballasting Rules (CBA Rule 8.05)

- **Mandatory Double-Bagging:** All sandbags brought onto synthetic turf must utilize secondary containment (heavy-duty plastic liner insert bags sealed inside outer cordura handle bags). Single-layer sandbags are prohibited on competition fields.
- **Turf Compaction Ceiling:** Total prop weight must not exceed $300\text{ lbs}$ ($\sim 75\text{ lbs}$ per caster wheel). Total supplemental ballast must remain between $100\text{ and }140\text{ lbs}$ to prevent casters sinking into rubber turf infill or damaging sub-base drainage.
