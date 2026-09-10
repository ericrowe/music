---
name: calculate-prop-wind-loading
description: >-
  Analyze aerodynamic wind forces, dynamic velocity pressure, overturning moments,
  forward/backward tipping asymmetry, sliding friction on turf, and ballast loading schedules
  for outdoor marching band field props, rolling backdrops, and sideline screens. Supports
  altitude scaling (Colorado Springs 6,500 ft ASL vs sea level) and engineered wind relief slits.
---

# Calculate Prop Wind Loading & Ballasting

This skill provides an automated engineering calculation engine and reference guide for evaluating aerodynamic wind loading, overturning stability, sliding resistance, and ballasting requirements for outdoor marching band field props, backdrops, and sideline screens.

## When to Use This Skill

Activate this skill when:
- Designing new field props, screens, backdrops, or performance structures.
- Calculating overturning wind speeds and factors of safety (FoS) for existing props.
- Determining sandbag ballast requirements and verifying compliance with the **140-lb athletic turf compaction limit**.
- Designing or cutting **engineered wind relief slits** (crescent flaps with tear-arrest holes).
- Evaluating props for high-altitude venues (e.g. Colorado Springs / Falcon Stadium at ~6,500 ft ASL) vs. sea-level travel venues.
- Formulating emergency high-wind field protocols and safety abort thresholds.

---

## Core Engineering Concepts

1. **Velocity Pressure ($q$):**  
   Governed by Bernoulli's equation $q = rac{1}{2} ho V^2$. At high altitude ($6,500\text{ ft}$ ASL), air density is $\approx 0.0620\text{ lb/ft}^3$ ($\sim 23\%$ less dense than sea level at $0.0765\text{ lb/ft}^3$). A prop experiences $23\%$ higher lateral load at sea level for the identical wind speed.
2. **Critical Tipping Asymmetry on Rolling Carts:**  
   When vertical upright frames are mounted at the front perimeter rail of a cart, the critical failure mode is **tipping forward over the front casters under rear wind**. Upright deadweight provides zero restoring moment to the front wheels, whereas front wind has the entire cart depth as restoring leverage.
3. **Rear-Rail Ballast Leverage:**  
   Placing supplemental ballast along the rear frame rail provides more than **double the restoring lever arm** compared to center wing posts ($3.46\text{ ft}$ vs $1.71\text{ ft}$), neutralizing forward tipping without exceeding turf loading limits.
4. **Wind Relief Slits (Crescent Inverted-U):**  
   Reduce net drag coefficient by $\sim 15\%$ ($C_d = 1.02$ vs $1.20$), bleed peak gust dynamic pressure impulses, and suppress destructive vortex-shedding flutter. Endpoint $\varnothing 3/8\text{ in.}$ round punch holes are mandatory to eliminate sharp stress risers ($K_t \ge 3.0$) that tear scrim vinyl.
5. **CBA Rule 8.05 Turf Protection:**  
   Mandatory double-bagging with heavy-duty inner plastic liners for all sandbags; total supplemental ballast restricted to $100–140\text{ lbs}$ to prevent caster rutting into rubber turf infill.

---

## Quick Start: CLI Helper

The skill includes a standalone Python CLI tool in [`scripts/analyze_wind_load.py`](./scripts/analyze_wind_load.py):

```bash
# 1. Analyze the PCHS Rolling Backdrop (10 ft H x 8 ft W)
python3 .agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py --preset backdrop

# 2. Analyze the Sideline Screen / Duck Blind (4 ft H x 8 ft W)
python3 .agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py --preset sideline-screen

# 3. Analyze Backdrop at Sea Level with Markdown output
python3 .agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py --preset backdrop --sea-level --format markdown

# 4. Custom Prop Geometry
python3 .agents/skills/calculate-prop-wind-loading/scripts/analyze_wind_load.py \
  --height 8.0 --width 6.0 --deck-height 0.5 \
  --cart-depth 36.0 --wheelbase 32.0 \
  --weight-cart 75.0 --weight-frame 30.0 --weight-vinyl 5.0 \
  --ballast-wings 60.0 --ballast-rear 30.0 --slits
```

---

## Standard Workflow for Document Authors & Engineers

1. **Retrieve Prop Geometry & Weight:**  
   Inspect the prop's `TECHNICAL_SPEC.md` or CAD models to gather face dimensions ($H \times W$), deck elevation above turf, chassis wheelbase, and dry weights.
2. **Execute Wind Load Analysis:**  
   Run `analyze_wind_load.py` for both the local elevation ($6,500\text{ ft}$) and sea level. Note the unballasted forward tipping wind speed and sliding threshold.
3. **Establish Tiered Ballast Schedule:**  
   - Tier 1 (Normal 0–12 mph): Baseline wing post ballast.
   - Tier 2 (Advisory 12–18 mph): Moderate wing post ballast.
   - Tier 3 (High-Wind 18–22 mph): Maximize wing ballast + rear rail ballast to reach ~135–140 lbs total.
   - Tier 4 (Safety Abort >20 sustained / >25 gusts): Strict field NO-GO.
4. **Specify Wind Relief Slits:**  
   Specify 6 to 8 inverted-U crescent flaps ($8\text{ in. W} \times 5–6\text{ in. drop}$) in the upper 40%–60% zone with $\varnothing 3/8\text{ in.}$ round relief punch holes at endpoints.
5. **Integrate into Manuals:**  
   Insert the analysis tables and procedures into Appendix A (Operations) and Appendix B (Fabrication/Assembly) of the subproject DOCX manual.

---

## Detailed References

- [`references/aerodynamic-models.md`](./references/aerodynamic-models.md): Complete fluid dynamics equations, drag coefficients, barometric scaling, slit mechanics, and CBA competition rules.
