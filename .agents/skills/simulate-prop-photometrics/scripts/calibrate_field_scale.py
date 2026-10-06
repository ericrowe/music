#!/usr/bin/env python3
"""
Photogrammetric Athletic Field Scale Calibrator
Skill: simulate-prop-photometrics

Calibrates pixels-per-yard and pixels-per-foot from football field 5-yard line intervals.
Computes true pixel bounding boxes for performers, headgear, and prop footprints
at specific field coordinates to prevent diffusion model scale hallucinations.
"""

import argparse
import json
import math
import sys

def calibrate_scale(
    interval_px=46.5,      # Measured pixels between 50-yd line and 45-yd line
    interval_yd=5.0,       # 5.0 yards (15.0 ft = 180.0 inches = 4.572 m)
    student_height_ft=5.0, # 5'0" high school performer (60.0 inches)
    shako_height_in=10.0,  # Standard marching shako
    plume_height_in=8.0,   # Standard marching plume
    shoulder_breadth_in=15.0,
    prop_height_in=12.0,   # Handheld prop height
    prop_width_in=4.5      # Handheld prop width
):
    px_per_yard = interval_px / interval_yd
    px_per_foot = px_per_yard / 3.0
    px_per_inch = px_per_foot / 12.0

    # Performer dimensions in pixels
    h_student_px = student_height_ft * px_per_foot
    h_shako_px = shako_height_in * px_per_inch
    h_plume_px = plume_height_in * px_per_inch
    h_total_uniform_px = (student_height_ft * 12.0 + shako_height_in + plume_height_in) * px_per_inch
    w_shoulders_px = shoulder_breadth_in * px_per_inch

    # Prop dimensions in pixels
    h_prop_px = prop_height_in * px_per_inch
    w_prop_px = prop_width_in * px_per_inch

    # Equivalent field yards of figures
    student_equiv_yards = (student_height_ft * 12.0) / 36.0
    total_equiv_yards = (student_height_ft * 12.0 + shako_height_in + plume_height_in) / 36.0
    prop_equiv_yards = prop_height_in / 36.0

    return {
        "calibration": {
            "measured_interval_px": interval_px,
            "field_interval_yards": interval_yd,
            "px_per_yard": round(px_per_yard, 3),
            "px_per_foot": round(px_per_foot, 3),
            "px_per_inch": round(px_per_inch, 4)
        },
        "performer": {
            "height_student_ft": student_height_ft,
            "height_student_px": round(h_student_px, 1),
            "shako_px": round(h_shako_px, 1),
            "plume_px": round(h_plume_px, 1),
            "total_height_with_headgear_px": round(h_total_uniform_px, 1),
            "shoulder_width_px": round(w_shoulders_px, 1),
            "equivalent_field_yards": round(student_equiv_yards, 2),
            "total_equivalent_field_yards": round(total_equiv_yards, 2)
        },
        "prop": {
            "height_inches": prop_height_in,
            "width_inches": prop_width_in,
            "height_px": round(h_prop_px, 1),
            "width_px": round(w_prop_px, 1),
            "equivalent_field_yards": round(prop_equiv_yards, 3)
        },
        "hallucination_audit_thresholds": {
            "max_student_px": round(h_total_uniform_px * 1.25, 1), # +25% tolerance
            "max_prop_px": round(h_prop_px * 1.30, 1),
            "failure_note": "If performer in render exceeds max_student_px, the figure is an unphysical giant!"
        }
    }

def main():
    parser = argparse.ArgumentParser(description="Photogrammetric Athletic Field Scale Calibrator")
    parser.add_argument("--interval-px", type=float, default=46.5, help="Measured pixels between 5-yard lines")
    parser.add_argument("--interval-yd", type=float, default=5.0, help="Yard distance of interval (default: 5.0)")
    parser.add_argument("--student-height-ft", type=float, default=5.0, help="Performer height in feet (default: 5.0)")
    parser.add_argument("--prop-height-in", type=float, default=12.0, help="Prop height in inches (default: 12.0)")
    parser.add_argument("--prop-width-in", type=float, default=4.5, help="Prop width in inches (default: 4.5)")
    parser.add_argument("--json-out", type=str, default="", help="Path to write JSON calibration")
    args = parser.parse_args()

    scale = calibrate_scale(
        interval_px=args.interval_px,
        interval_yd=args.interval_yd,
        student_height_ft=args.student_height_ft,
        prop_height_in=args.prop_height_in,
        prop_width_in=args.prop_width_in
    )

    print("=" * 80)
    print("PHOTOGRAMMETRIC FIELD SCALE CALIBRATION")
    print(f"Interval: {scale['calibration']['measured_interval_px']} px across {scale['calibration']['field_interval_yards']} yards")
    print(f"Scale:    {scale['calibration']['px_per_yard']} px/yd | {scale['calibration']['px_per_foot']} px/ft | {scale['calibration']['px_per_inch']} px/in")
    print("=" * 80)
    print("\n[PERFORMER DIMENSIONS ON TURF]")
    print(f"  Student (5'0\"):              {scale['performer']['height_student_px']} px ({scale['performer']['equivalent_field_yards']} yards)")
    print(f"  Shako (10\") + Plume (8\"):   +{scale['performer']['shako_px'] + scale['performer']['plume_px']:.1f} px")
    print(f"  Total Performer Height:      {scale['performer']['total_height_with_headgear_px']} px ({scale['performer']['total_equivalent_field_yards']} yards)")
    print(f"  Shoulder Breadth (15\"):     {scale['performer']['shoulder_width_px']} px")
    print("\n[HANDHELD PROP FOOTPRINT]")
    print(f"  12\" x 4.5\" Prop Aperture:    {scale['prop']['height_px']} px H x {scale['prop']['width_px']} px W ({scale['prop']['equivalent_field_yards']} yards)")
    print("\n[DIFFUSION HALLUCINATION THRESHOLD]")
    print(f"  Max Acceptable Performer:    {scale['hallucination_audit_thresholds']['max_student_px']} px")
    print(f"  Max Acceptable Prop:         {scale['hallucination_audit_thresholds']['max_prop_px']} px")

    if args.json_out:
        with open(args.json_out, "w") as f:
            json.dump(scale, f, indent=2)
        print(f"\nSaved JSON calibration to {args.json_out}")

if __name__ == "__main__":
    main()
