#!/usr/bin/env python3
"""
analyze_wind_load.py
Standalone engineering CLI tool for calculating aerodynamic wind forces,
dynamic pressure, overturning moments, tipping thresholds, sliding resistance,
and ballast loading schedules for outdoor marching band props.
"""

import sys
import math
import argparse
import json

def calc_air_density(elevation_ft, temp_f=65.0):
    """Calculate atmospheric air density (lb/ft^3) based on elevation (ft ASL)."""
    # Standard sea level: rho0 = 0.0765 lb/ft^3, P0 = 101.325 kPa, T0 = 288.15 K
    # Standard barometric lapse rate L = 0.0019812 K/ft
    # T = T0 - L * h
    # P = P0 * (1 - L*h/T0)^5.25588
    # rho = rho0 * (P / P0) * (T0 / T_actual)
    t_kelvin = (temp_f - 32.0) * (5.0 / 9.0) + 273.15
    t0_kelvin = 288.15
    l_lapse = 0.0019812
    
    if elevation_ft <= 0:
        p_ratio = 1.0
    else:
        p_ratio = (1.0 - (l_lapse * elevation_ft) / t0_kelvin) ** 5.25588
    
    rho_std = 0.07651  # lb/ft^3 at 59F sea level
    density = rho_std * p_ratio * (t0_kelvin / t_kelvin)
    return max(0.01, density)

def evaluate_prop(args):
    # Determine geometry and weights
    if args.preset == "backdrop":
        height = 10.0
        width = 8.0
        deck_height = 0.79
        cart_depth = 44.5
        wheelbase = 41.0
        w_wood_cart = 90.0
        w_steel_frame = 40.0
        w_struts = 15.0
        w_vinyl = 8.0
        x_frame = 1.5
        x_cart_cg = 22.25
        x_struts_cg = 22.25
        x_vinyl = 1.5
        x_wing_ballast = 22.25
        x_rear_ballast = 41.5
        prop_title = "PCHS Marching Band Rolling Backdrop (10 ft H x 8 ft W)"
    elif args.preset == "sideline-screen":
        height = 4.0
        width = 8.0
        deck_height = 0.25
        cart_depth = 27.5
        wheelbase = 25.0
        w_wood_cart = 16.0  # EMT bottom framing & arms
        w_steel_frame = 12.0 # Upper EMT frame
        w_struts = 4.0
        w_vinyl = 4.0
        x_frame = 2.0
        x_cart_cg = 13.75
        x_struts_cg = 13.75
        x_vinyl = 2.0
        x_wing_ballast = 13.75
        x_rear_ballast = 26.0
        prop_title = "PCHS Sideline Screen / Duck Blind (4 ft H x 8 ft W)"
    else:
        height = args.height
        width = args.width
        deck_height = args.deck_height
        cart_depth = args.cart_depth
        wheelbase = args.wheelbase if args.wheelbase else (cart_depth - 4.0)
        w_wood_cart = args.weight_cart
        w_steel_frame = args.weight_frame
        w_struts = args.weight_struts
        w_vinyl = args.weight_vinyl
        x_frame = 1.5
        x_cart_cg = cart_depth / 2.0
        x_struts_cg = cart_depth / 2.0
        x_vinyl = 1.5
        x_wing_ballast = cart_depth / 2.0
        x_rear_ballast = cart_depth - 3.0
        prop_title = f"Custom Field Prop ({height:.1f} ft H x {width:.1f} ft W)"

    # Elevation & density
    elevation = 0.0 if args.sea_level else args.elevation
    rho = calc_air_density(elevation)
    gc = 32.174
    fps_per_mph = 1.46667
    q_factor = 0.5 * (rho / gc) * (fps_per_mph ** 2)

    area = height * width
    h_cp = deck_height + (height / 2.0)

    # Drag coefficient
    cd = 1.02 if args.slits else 1.20
    cd_label = "With Relief Slits (Cd=1.02)" if args.slits else "Solid Vinyl (Cd=1.20)"

    # Wheel contact patches
    # Front wheel pivot
    front_inset = (cart_depth - wheelbase) / 2.0
    x_front_pivot = front_inset - 1.25  # accounts for forward trail
    x_rear_pivot = (cart_depth - front_inset) + 1.25 # accounts for rear trail

    # Restoring lever arms (ft)
    # Forward tipping (pivot front): arm = (x - x_front_pivot) / 12.0
    arm_fwd_frame = (x_frame - x_front_pivot) / 12.0
    arm_fwd_vinyl = (x_vinyl - x_front_pivot) / 12.0
    arm_fwd_cart = (x_cart_cg - x_front_pivot) / 12.0
    arm_fwd_struts = (x_struts_cg - x_front_pivot) / 12.0
    arm_fwd_wing = (x_wing_ballast - x_front_pivot) / 12.0
    arm_fwd_rear = (x_rear_ballast - x_front_pivot) / 12.0

    # Backward tipping (pivot rear): arm = (x_rear_pivot - x) / 12.0
    arm_bwd_frame = (x_rear_pivot - x_frame) / 12.0
    arm_bwd_vinyl = (x_rear_pivot - x_vinyl) / 12.0
    arm_bwd_cart = (x_rear_pivot - x_cart_cg) / 12.0
    arm_bwd_struts = (x_rear_pivot - x_struts_cg) / 12.0
    arm_bwd_wing = (x_rear_pivot - x_wing_ballast) / 12.0
    arm_bwd_rear = (x_rear_pivot - x_rear_ballast) / 12.0

    w_dry = w_wood_cart + w_steel_frame + w_struts + w_vinyl
    w_wing = args.ballast_wings
    w_rear = args.ballast_rear
    w_total = w_dry + w_wing + w_rear

    m_rest_fwd = (
        w_steel_frame * arm_fwd_frame +
        w_vinyl * arm_fwd_vinyl +
        w_wood_cart * arm_fwd_cart +
        w_struts * arm_fwd_struts +
        w_wing * arm_fwd_wing +
        w_rear * arm_fwd_rear
    )
    m_rest_bwd = (
        w_steel_frame * arm_bwd_frame +
        w_vinyl * arm_bwd_vinyl +
        w_wood_cart * arm_bwd_cart +
        w_struts * arm_bwd_struts +
        w_wing * arm_bwd_wing +
        w_rear * arm_bwd_rear
    )

    # Critical wind speeds
    v_tip_fwd = math.sqrt(max(0.1, m_rest_fwd) / (q_factor * cd * area * h_cp))
    v_tip_bwd = math.sqrt(max(0.1, m_rest_bwd) / (q_factor * cd * area * h_cp))
    v_slide = math.sqrt((args.turf_mu * w_total) / (q_factor * cd * area))

    # Wind speed table
    speeds = [float(s) for s in args.wind_speeds.split(",")]
    wind_table = []
    for v in speeds:
        q = q_factor * (v ** 2)
        fw = q * cd * area
        mot = fw * h_cp
        fos_fwd = m_rest_fwd / max(0.01, mot)
        fos_bwd = m_rest_bwd / max(0.01, mot)
        slide_force = args.turf_mu * w_total
        fos_slide = slide_force / max(0.01, fw)
        wind_table.append({
            "speed_mph": v,
            "q_psf": round(q, 3),
            "force_lb": round(fw, 1),
            "moment_ft_lb": round(mot, 1),
            "fos_tip_forward": round(fos_fwd, 2),
            "fos_tip_backward": round(fos_bwd, 2),
            "fos_sliding": round(fos_slide, 2)
        })

    # Standard Tiered Schedule generator
    if args.preset == "backdrop":
        tiers = [
            {"tier": "Tier 1: Normal", "range": "0–12 mph", "wing_ballast": 60, "rear_ballast": 0, "total_ballast": 60, "v_tip_fwd": 16.9 if args.slits else 15.6, "action": "Standard deployment (4x 15-lb bags on wings)"},
            {"tier": "Tier 2: Advisory", "range": "12–18 mph", "wing_ballast": 90, "rear_ballast": 0, "total_ballast": 90, "v_tip_fwd": 18.4 if args.slits else 17.0, "action": "Attentive staging (6x 15-lb bags on wings)"},
            {"tier": "Tier 3: High-Wind", "range": "18–22 mph", "wing_ballast": 90, "rear_ballast": 45, "total_ballast": 135, "v_tip_fwd": 22.5 if args.slits else 20.8, "action": "High-wind reserve (6 on wings + 3 across rear rail)"},
            {"tier": "Tier 4: Safety Abort", "range": ">20 sustained / >25 gusts", "wing_ballast": 0, "rear_ballast": 0, "total_ballast": 0, "v_tip_fwd": 0.0, "action": "STRICT NO-GO / WITHDRAWAL. Lay props flat."}
        ]
    else:
        tiers = []

    return {
        "prop_title": prop_title,
        "elevation_ft": elevation,
        "air_density_lb_cuft": round(rho, 4),
        "q_factor": round(q_factor, 6),
        "frontal_area_sqft": area,
        "center_of_pressure_ft": round(h_cp, 2),
        "drag_coefficient": cd,
        "surface_treatment": cd_label,
        "dry_weight_lb": round(w_dry, 1),
        "ballast_wings_lb": round(w_wing, 1),
        "ballast_rear_lb": round(w_rear, 1),
        "total_weight_lb": round(w_total, 1),
        "lever_arm_fwd_wing_ft": round(arm_fwd_wing, 2),
        "lever_arm_fwd_rear_ft": round(arm_fwd_rear, 2),
        "rear_rail_leverage_multiplier": round(arm_fwd_rear / max(0.01, arm_fwd_wing), 2),
        "restoring_moment_fwd_ft_lb": round(m_rest_fwd, 1),
        "restoring_moment_bwd_ft_lb": round(m_rest_bwd, 1),
        "critical_tipping_forward_mph": round(v_tip_fwd, 1),
        "critical_tipping_backward_mph": round(v_tip_bwd, 1),
        "critical_sliding_turf_mph": round(v_slide, 1),
        "wind_table": wind_table,
        "tiered_schedule": tiers
    }

def print_table_format(res):
    print("=" * 80)
    print(f" WIND LOADING & STABILITY ANALYSIS: {res['prop_title']}")
    print("=" * 80)
    print(f"Venue Elevation:       {res['elevation_ft']:.0f} ft ASL (Air Density: {res['air_density_lb_cuft']:.4f} lb/ft^3)")
    print(f"Frontal Sail Area:     {res['frontal_area_sqft']:.1f} sq ft (Center of Pressure: {res['center_of_pressure_ft']:.2f} ft above turf)")
    print(f"Aerodynamic Drag:      Cd = {res['drag_coefficient']:.2f} [{res['surface_treatment']}]")
    print(f"Prop Weights:          Dry: {res['dry_weight_lb']} lb | Wing Ballast: {res['ballast_wings_lb']} lb | Rear Ballast: {res['ballast_rear_lb']} lb")
    print(f"Total Weight on Turf:  {res['total_weight_lb']} lb (~{res['total_weight_lb']/4:.1f} lb per caster)")
    print(f"Rear-Rail Advantage:   {res['lever_arm_fwd_rear_ft']:.2f} ft vs {res['lever_arm_fwd_wing_ft']:.2f} ft wing ({res['rear_rail_leverage_multiplier']}x mechanical leverage)")
    print("-" * 80)
    print("CRITICAL STABILITY THRESHOLDS:")
    print(f"  * FORWARD TIPPING (Wind from Rear) [CRITICAL]:  {res['critical_tipping_forward_mph']:.1f} mph (M_rest = {res['restoring_moment_fwd_ft_lb']} ft-lb)")
    print(f"  * BACKWARD TIPPING (Wind from Front):          {res['critical_tipping_backward_mph']:.1f} mph (M_rest = {res['restoring_moment_bwd_ft_lb']} ft-lb)")
    print(f"  * SLIDING ON ARTIFICIAL TURF (Locked Casters): {res['critical_sliding_turf_mph']:.1f} mph")
    print("-" * 80)
    print(f"{'Wind Speed':<12} | {'Force':<10} | {'Moment':<14} | {'FoS (Tip Fwd)':<14} | {'FoS (Tip Bwd)':<14} | {'FoS (Slide)':<12}")
    print("-" * 80)
    for row in res['wind_table']:
        print(f"{row['speed_mph']:>4.0f} mph     | {row['force_lb']:>6.1f} lb  | {row['moment_ft_lb']:>7.0f} ft-lb   | {row['fos_tip_forward']:>8.2f}       | {row['fos_tip_backward']:>8.2f}       | {row['fos_sliding']:>7.2f}")
    print("=" * 80)

def print_markdown_format(res):
    print(f"# Wind Loading & Stability Analysis: {res['prop_title']}")
    print()
    print(f"- **Elevation:** {res['elevation_ft']:.0f} ft ASL (Air density rho = {res['air_density_lb_cuft']:.4f} lb/ft^3)")
    print(f"- **Frontal Sail Area:** {res['frontal_area_sqft']:.1f} sq ft (Center of pressure h_cp = {res['center_of_pressure_ft']:.2f} ft)")
    print(f"- **Surface Treatment:** {res['surface_treatment']}")
    print(f"- **Total Weight on Turf:** {res['total_weight_lb']:.1f} lbs (Dry: {res['dry_weight_lb']:.1f} lbs + Ballast: {res['ballast_wings_lb'] + res['ballast_rear_lb']:.1f} lbs)")
    print(f"- **Critical Forward Tipping Speed (Rear Wind):** **{res['critical_tipping_forward_mph']:.1f} mph**")
    print(f"- **Critical Backward Tipping Speed (Front Wind):** **{res['critical_tipping_backward_mph']:.1f} mph**")
    print(f"- **Critical Turf Sliding Speed:** **{res['critical_sliding_turf_mph']:.1f} mph**")
    print()
    print("| Wind Speed | Drag Force | Overturning Moment | FoS (Forward Tip) | FoS (Backward Tip) | FoS (Turf Slide) |")
    print("|:---:|:---:|:---:|:---:|:---:|:---:|")
    for r in res['wind_table']:
        print(f"| {r['speed_mph']:.0f} mph | {r['force_lb']:.1f} lbs | {r['moment_ft_lb']:.0f} ft-lbs | {r['fos_tip_forward']:.2f} | {r['fos_tip_backward']:.2f} | {r['fos_sliding']:.2f} |")

def main():
    parser = argparse.ArgumentParser(description="Calculate marching band prop wind loading, overturning stability, and ballasting.")
    parser.add_argument("--preset", choices=["backdrop", "sideline-screen", "generic"], default="generic", help="Prop preset profile")
    parser.add_argument("--height", type=float, default=10.0, help="Prop face height in feet")
    parser.add_argument("--width", type=float, default=8.0, help="Prop face width in feet")
    parser.add_argument("--deck-height", type=float, default=0.79, help="Height of bottom rail/deck above turf in feet")
    parser.add_argument("--cart-depth", type=float, default=44.5, help="Cart depth (front to back) in inches")
    parser.add_argument("--wheelbase", type=float, default=41.0, help="Caster wheelbase in inches")
    parser.add_argument("--elevation", type=float, default=6500.0, help="Venue elevation in feet ASL (default: 6,500 ft for Colorado Springs)")
    parser.add_argument("--sea-level", action="store_true", help="Force standard sea level atmospheric density")
    parser.add_argument("--slits", action="store_true", default=True, help="Include engineered wind relief slits (default: True)")
    parser.add_argument("--no-slits", action="store_false", dest="slits", help="Evaluate solid unvented vinyl")
    parser.add_argument("--weight-cart", type=float, default=90.0, help="Weight of wood cart base, casters, and tote in lbs")
    parser.add_argument("--weight-frame", type=float, default=40.0, help="Weight of upright steel frame in lbs")
    parser.add_argument("--weight-struts", type=float, default=15.0, help="Weight of diagonal struts in lbs")
    parser.add_argument("--weight-vinyl", type=float, default=8.0, help="Weight of vinyl banner and snap clamps in lbs")
    parser.add_argument("--ballast-wings", type=float, default=60.0, help="Ballast weight on center wing retention posts in lbs")
    parser.add_argument("--ballast-rear", type=float, default=0.0, help="Supplemental ballast weight on rear frame rail in lbs")
    parser.add_argument("--turf-mu", type=float, default=0.50, help="Static friction coefficient of locked casters on artificial turf")
    parser.add_argument("--wind-speeds", default="10,12,15,18,20,22,25,30", help="Comma-separated list of wind speeds in mph to evaluate")
    parser.add_argument("--format", choices=["table", "markdown", "json"], default="table", help="Output format")

    args = parser.parse_args()
    res = evaluate_prop(args)

    if args.format == "json":
        print(json.dumps(res, indent=2))
    elif args.format == "markdown":
        print_markdown_format(res)
    else:
        print_table_format(res)

if __name__ == "__main__":
    main()
