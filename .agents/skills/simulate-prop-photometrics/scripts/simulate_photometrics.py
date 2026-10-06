#!/usr/bin/env python3
"""
Photometric & Optical Simulation Engine
Skill: simulate-prop-photometrics
Analyzes optical visibility, apparent luminance, and Weber JND daylight contrast
from elevated stadium press box viewpoints down to athletic field performers.

Governing Principles:
- Inverse-Square Law: E = I / d^2
- Weber-Fechner Law of Human Contrast Perception: ΔI / I >= 0.02
- Rayleigh Scattering Optical Depth: μ_s * L << 10^-4 in clean mountain air
"""

import argparse
import json
import math
import os
import sys

def calculate_photometrics(
    elevation_pressbox_m=18.29,     # 60.0 ft height above turf (West Press Box level)
    setback_west_sideline_m=45.72,  # 150.0 ft setback from West sideline
    performer_field_y_m=24.38,      # 80.0 ft from West sideline (dead-center on 50-yd line)
    e_sun_lux=90000.0,              # Midday solar illuminance (lux) at 6,500 ft ASL
    rho_turf=0.12,                  # Synthetic turf diffuse albedo
    weber_fraction=0.02,            # Human contrast threshold
    props_data=None
):
    # Slant range to centerfield performer
    d_horiz_m = setback_west_sideline_m + performer_field_y_m # ~70.10 m (230.0 ft)
    slant_range_m = math.sqrt(d_horiz_m**2 + elevation_pressbox_m**2) # ~72.45 m (237.7 ft)
    elevation_angle_deg = math.degrees(math.atan(elevation_pressbox_m / d_horiz_m)) # ~14.60 degrees

    l_turf_cd_m2 = (e_sun_lux * rho_turf) / math.pi # ~3,437.7 cd/m2
    jnd_threshold_lux = weber_fraction * e_sun_lux   # 1,800 lux

    if props_data is None:
        props_data = {
            "option_1": {
                "name": "Option 1: The Sleek Radial Beacon",
                "archetype": "360° Omnidirectional Radial COB Column",
                "color": "Warm Amber-Gold",
                "wavelength_nm": 595,
                "apparent_aperture_area_m2": 0.020,
                "i_peak_candela": 650.0,
                "collimated": False,
                "black_matrix": False
            },
            "option_2": {
                "name": "Option 2: The Conical Optical Reactor",
                "archetype": "Inverted Specular Conical Reflector Engine",
                "color": "Electric Cyan",
                "wavelength_nm": 500,
                "apparent_aperture_area_m2": 0.0033,
                "i_peak_candela": 3200.0,
                "collimated": True,
                "black_matrix": False
            },
            "option_3": {
                "name": "Option 3: Theatrical Riveted Ironwork",
                "archetype": "Stage-Grade Fresnel Luminaire Core in Riveted Cage",
                "color": "Theatrical Magenta / Violet",
                "wavelength_nm": 420,
                "apparent_aperture_area_m2": math.pi * (0.05**2), # 0.00785 m2
                "i_peak_candela": 11500.0,
                "collimated": True,
                "black_matrix": False
            },
            "option_4": {
                "name": "Option 4: Digital Monolithic Pagoda",
                "archetype": "4-Sided High-Density Outdoor Black-Matrix LED Tile",
                "color": "Fiery Orange & Crimson Flames",
                "wavelength_nm": 605,
                "apparent_aperture_area_m2": 0.0256,
                "i_peak_candela": 185.0,
                "calibrated_nits": 6500.0,
                "collimated": False,
                "black_matrix": True,
                "matrix_absorption_pct": 97.5
            },
            "option_5": {
                "name": "Option 5: Touring Concert Roll-Cage",
                "archetype": "Dual-Emitting High-Flux COB Stage Blinder",
                "color": "Emerald Green",
                "wavelength_nm": 525,
                "apparent_aperture_area_m2": math.pi * (0.04**2), # 0.00503 m2
                "i_peak_candela": 5200.0,
                "collimated": True,
                "black_matrix": False
            }
        }

    results = {
        "metadata": {
            "pressbox_elevation_m": round(elevation_pressbox_m, 2),
            "setback_sideline_m": round(setback_west_sideline_m, 2),
            "performer_field_y_m": round(performer_field_y_m, 2),
            "slant_range_m": round(slant_range_m, 2),
            "elevation_angle_deg": round(elevation_angle_deg, 2),
            "ambient_sun_lux": round(e_sun_lux, 1),
            "ambient_turf_luminance_nits": round(l_turf_cd_m2, 1),
            "weber_jnd_threshold_lux": round(jnd_threshold_lux, 1)
        },
        "options": {}
    }

    for key, opt in props_data.items():
        if opt.get("collimated"):
            i_judge = opt["i_peak_candela"]
        else:
            i_judge = opt["i_peak_candela"] * math.cos(math.radians(elevation_angle_deg))

        e_judge = i_judge / (slant_range_m**2)

        if opt.get("black_matrix"):
            l_emitted = opt.get("calibrated_nits", 6500.0)
            l_refl = (e_sun_lux * (1.0 - opt.get("matrix_absorption_pct", 97.5) / 100.0)) / math.pi
            l_source = l_emitted + l_refl
            contrast_ratio = l_source / l_turf_cd_m2
        else:
            l_source = i_judge / opt["apparent_aperture_area_m2"]
            contrast_ratio = l_source / l_turf_cd_m2

        r_ground = 5.0
        sin_grazing = 0.9 / math.sqrt(r_ground**2 + 0.9**2)
        if opt.get("collimated"):
            i_down = opt["i_peak_candela"] * 0.05
        else:
            i_down = opt["i_peak_candela"] * 0.5

        e_ground = (i_down / (r_ground**2)) * sin_grazing
        ground_visible = e_ground >= jnd_threshold_lux

        if e_judge >= 1.0:
            vis_class = "Dazzling Stage Spotlight Punch (Dominates Sunlight)"
        elif e_judge >= 0.5:
            vis_class = "Brilliant Piercing Beacon (Crisp Scoreable Glint)"
        elif e_judge >= 0.2:
            vis_class = "Clearly Visible Point-Source Color Glint"
        elif opt.get("black_matrix"):
            vis_class = "High-Contrast Dark Monolith with Vivid Burning Embers"
        else:
            vis_class = "Soft Diffuse Cylindrical Glow (Partially Washed Out by Sunlight)"

        results["options"][key] = {
            "name": opt["name"],
            "archetype": opt["archetype"],
            "color": opt["color"],
            "intensity_judge_cd": round(i_judge, 1),
            "illuminance_judge_lux": round(e_judge, 4),
            "source_luminance_nits": round(l_source, 1),
            "luminance_contrast_ratio": round(contrast_ratio, 1),
            "ground_wash_lux": round(e_ground, 2),
            "ground_wash_perceptible": ground_visible,
            "visibility_class": vis_class,
            "air_transparency": "100% crystal clear (zero volumetric beams/halos)",
            "turf_rendering": "Clean natural sunlit turf (zero colored glow)"
        }

    return results

def main():
    parser = argparse.ArgumentParser(description="Photometric & Optical Simulation Engine")
    parser.add_argument("--sun-lux", type=float, default=90000.0, help="Solar illuminance (lux)")
    parser.add_argument("--elevation-m", type=float, default=18.29, help="Press box elevation (m)")
    parser.add_argument("--setback-m", type=float, default=45.72, help="Setback from sideline (m)")
    parser.add_argument("--performer-y-m", type=float, default=24.38, help="Performer distance from sideline (m)")
    parser.add_argument("--json-out", type=str, default="", help="Path to write JSON results")
    args = parser.parse_args()

    results = calculate_photometrics(
        elevation_pressbox_m=args.elevation_m,
        setback_west_sideline_m=args.setback_m,
        performer_field_y_m=args.performer_y_m,
        e_sun_lux=args.sun_lux
    )

    print("=" * 80)
    print("STADIUM PRESS BOX PHOTOMETRIC SIMULATION RESULTS")
    print(f"Slant Range: {results['metadata']['slant_range_m']} m ({results['metadata']['slant_range_m']*3.28084:.1f} ft) | Elevation Angle: {results['metadata']['elevation_angle_deg']}°")
    print(f"Ambient Sun: {results['metadata']['ambient_sun_lux']:,} lux | Weber JND Threshold: {results['metadata']['weber_jnd_threshold_lux']:,} lux")
    print("=" * 80)

    for k, v in results["options"].items():
        print(f"\n[{k.upper()}] {v['name']} ({v['color']})")
        print(f"  Intensity at Eye:  {v['intensity_judge_cd']:,.1f} cd")
        print(f"  Illuminance at Eye:{v['illuminance_judge_lux']:.4f} lux")
        print(f"  Source Luminance:  {v['source_luminance_nits']:,.1f} nits (Contrast: {v['luminance_contrast_ratio']:.1f}:1)")
        print(f"  Ground Wash (5m):  {v['ground_wash_lux']} lux (Visible: {v['ground_wash_perceptible']})")
        print(f"  Visibility Class:  {v['visibility_class']}")
        print(f"  Turf Rendering:    {v['turf_rendering']}")

    if args.json_out:
        with open(args.json_out, "w") as f:
            json.dump(results, f, indent=2)
        print(f"\nSaved JSON results to {args.json_out}")

if __name__ == "__main__":
    main()
