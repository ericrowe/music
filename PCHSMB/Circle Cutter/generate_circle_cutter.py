#!/usr/bin/env python3
"""
PCHSMB Circle Cutter - Parametric 3D Printable STL Generator
=============================================================
Semicircular wind relief slit cutter for Pine Creek High School Marching Band
(PCHSMB) outdoor vinyl field props (Duck Blinds & Rolling Backdrops).

Engineering Standards (aligned with Parts-Database / carriers):
  - Pure Python standard library CAD engine (struct, math, dataclasses, pathlib).
  - Strict 4-gate topological mesh audit (0 boundary, 0 non-manifold, 0 degenerate, 100% finite).
  - Rolling depth-stop: integrated 625 roller bearing rides on the vinyl, locking cut depth to 1.0 mm.
  - Self-leveling 2-point bridge: 4.0 mm base plate thickness matches bearing roll plane,
    keeping arm level with 4.0 mm uniform air clearance above vinyl (no graphic scuffing).
  - Parallel axle alignment: bearing rotation axis (axle) is radial (+X), parallel to blade clamping screw.
  - Standardized build/ directory with manifest.json, test coupons, and LookAt 4-view drawings.

Usage:
  python3 generate_circle_cutter.py [--out build] [--no-render]
"""

from __future__ import annotations

import argparse
import json
import math
import struct
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Sequence, Tuple

# =============================================================================
# PARAMETRIC SPECIFICATIONS (MILLIMETERS)
# =============================================================================

VERSION = "1.4"
DESIGN_NAME = "PCHSMB Circle Cutter - Semicircular Wind Relief Slit Tool with 608 Bearing Thrust Pivot"

# -----------------------------------------------------------------------------
# Vertical Stack-Up & Ground Reference (Vinyl Top Surface = Z 0.0 mm)
# -----------------------------------------------------------------------------
VINYL_Z = 0.0                                 # Vinyl surface reference plane
CUT_DEPTH = 1.0                               # Controlled blade depth below bearing (1.0 mm)
BLADE_TIP_WORLD_Z = VINYL_Z - CUT_DEPTH       # -1.0 mm world

# 625 Ball Bearing Specifications (Outer Arm Rolling Depth Stop)
BEARING_OD = 16.0                             # 16.0 mm outer diameter
BEARING_ID = 5.0                              # 5.0 mm inner bore
BEARING_WIDTH = 5.0                           # 5.0 mm thickness
BEARING_RADIUS = BEARING_OD / 2.0             # 8.0 mm
BEARING_AXLE_WORLD_Z = VINYL_Z + BEARING_RADIUS  # +8.0 mm world (bearing touches vinyl at Z 0.0)

# 608 Ball Bearing Specifications (Main Pivot Thrust Bearing atop Spindle)
BEARING_608_OD = 22.0                         # 22.0 mm outer diameter
BEARING_608_ID = 8.0                          # 8.0 mm inner bore
BEARING_608_WIDTH = 7.0                       # 7.0 mm thickness
BEARING_608_INNER_SHOULDER_DIA = 11.5         # 11.5 mm OD shoulder (contacts ONLY inner race, clears shields)
BEARING_608_INNER_SHOULDER_HEIGHT = 1.0       # 1.0 mm height (creates 1.0 mm relief between spindle top & outer race)
BEARING_608_POST_DIA = 7.90                   # 7.90 mm OD pilot post (slip-fit into 8.0mm bore)
BEARING_608_POST_HEIGHT = 6.0                 # 6.0 mm height (1.0 mm below 7.0mm bearing top to prevent bottoming)
BEARING_608_POST_CHAMFER = 0.8                # 0.8 mm 45° lead-in chamfer
BEARING_608_POCKET_DIA = 22.2                 # 22.2 mm ID pocket in Piece 4 (0.1 mm radial slip fit)
BEARING_608_POCKET_WALL_OD = 25.0             # 25.0 mm OD cup wall (1.4 mm wall thickness)
BEARING_608_POCKET_DEPTH = 3.0                # 3.0 mm deep cup wall capturing outer race
BEARING_608_RELIEF_DIA = 18.0                 # 18.0 mm ID central relief cavity in Piece 4 (clears inner race & post)
BEARING_608_RELIEF_DEPTH = 1.5                # 1.5 mm extra upward relief into Piece 4 flange

# Piece 1: Fixed Pivot Base Plate
BASE_PLATE_DIA = 50.0                         # 50.0 mm outer diameter
BASE_PLATE_RADIUS = BASE_PLATE_DIA / 2.0      # 25.0 mm
BASE_PLATE_HEIGHT = 3.0                       # 3.0 mm thickness (provides 1.0 mm air gap to arm bottom at Z=4.0!)
CROSSHAIR_DEPTH = 1.0                         # 1.0 mm radial notch into rim
CROSSHAIR_WIDTH = 1.8                         # 1.8 mm circumferential notch width
SPINDLE_DIA = 40.0                            # 40.0 mm center spindle OD
SPINDLE_RADIUS = SPINDLE_DIA / 2.0            # 20.0 mm
SPINDLE_HEIGHT = 100.0                        # 100.0 mm height above shoulder
SPINDLE_CHAMFER = 1.5                         # 1.5 mm 45° lead-in chamfer
TOTAL_BASE_HEIGHT = BASE_PLATE_HEIGHT + SPINDLE_HEIGHT + BEARING_608_INNER_SHOULDER_HEIGHT + BEARING_608_POST_HEIGHT  # 110.0 mm

# Arm Elevation & Air Clearance
ARM_AIR_GAP = 1.0                             # 1.0 mm uniform air gap between base plate and rotating arm (ZERO friction)
ARM_BOTTOM_WORLD_Z = BASE_PLATE_HEIGHT + ARM_AIR_GAP  # 4.0 mm world (matches 625 bearing roll plane)

# Piece 2: Rotating Arm Assembly (Local coordinates: Z=0 at hub bottom / base shoulder)
# In world coordinates: Z_world = Z_local + BASE_PLATE_HEIGHT (Z_local + 4.0 mm)
HUB_OUTER_DIA = 50.0                          # 50.0 mm OD
HUB_OUTER_RADIUS = HUB_OUTER_DIA / 2.0        # 25.0 mm
HUB_RECESS_DIA = 42.0                         # 42.0 mm ID bore (1.0 mm radial slip fit clearance)
HUB_RECESS_RADIUS = HUB_RECESS_DIA / 2.0      # 21.0 mm
HUB_TOTAL_HEIGHT = 108.0                      # 108.0 mm total sleeve height
HUB_TOP_CHAMFER = 1.5                         # 1.5 mm 45° outer bevel
HUB_INNER_CHAMFER = 1.0                       # 1.0 mm 45° inner lead-in chamfer at top rim
HUB_GROOVE_DEPTH = 0.8                        # 0.8 mm radial undercut (ID 43.6 mm, R 21.8 mm)
HUB_GROOVE_Z_START = 103.5                    # Internal retention groove bottom
HUB_GROOVE_Z_END = 105.5                      # Internal retention groove flat root

ARM_LENGTH = 150.0                            # 150.0 mm extension from hub outer surface
ARM_WIDTH = 20.0                              # 20.0 mm width in Y
ARM_HEIGHT = 12.0                             # 12.0 mm height in Z (local Z in [0, 12])
ARM_BEVEL = 2.0                               # 2.0 mm 45° longitudinal chamfer
ARM_ROOT_X = 22.0                             # Embeds securely inside solid hub wall
DISTAL_X = HUB_OUTER_RADIUS + ARM_LENGTH      # 175.0 mm from pivot center

# Dual Head Geometry (Side-by-Side Head with 625 Bearing and X-Acto Blade)
DUAL_HEAD_START_X = 135.0                     # Transition flare start from 20mm to 36mm
DUAL_HEAD_FULL_X = 155.0                      # Full 36mm dual head width start
DUAL_HEAD_WIDTH = 36.0                        # 36.0 mm total width (Y in [-18, +18])
BEARING_PAD_Y = -9.0                          # Center of 625 bearing pad in Y
BLADE_PAD_Y = +9.0                            # Center of blade & M3 clamping cap in Y

# 625 Bearing Mount on Arm
BEARING_AXLE_LOCAL_Z = BEARING_AXLE_WORLD_Z - ARM_BOTTOM_WORLD_Z  # +4.0 mm local (8.0 - 4.0 = 4.0 mm)
BEARING_MOUNT_X = DISTAL_X                    # 175.0 mm (front face of arm alongside blade)
BEARING_STANDOFF_OD = 8.0                     # 8.0 mm OD (contacts ONLY 5x8mm inner race)
BEARING_STANDOFF_LEN = 1.0                    # 1.0 mm standoff clearance
M5_INSERT_DIA = 6.2                           # 6.2 mm hole for user-specified M5 brass heat-set insert
M5_INSERT_DEPTH = 11.0                        # 11.0 mm bore depth (accommodates 6, 8, or 10 mm inserts)

# Blade Mount & Retention
BLADE_X = DISTAL_X                            # 175.0 mm distal end
BLADE_SLOT_WIDTH = 6.0                        # 6.0 mm slot for #11 blade tang (5.8-6.0 mm)
BLADE_SLOT_DEPTH = 0.8                        # 0.8 mm raised retaining tabs flanking blade
HEAT_SET_M3_DIA = 3.8                         # 3.8 mm hole for user-specified M3 brass insert
HEAT_SET_M3_DEPTH = 10.5                      # 10.5 mm bore depth (accommodates 6, 8, or 10 mm inserts)

# Piece 3: Blade Clamping Cap
CAP_WIDTH = 12.0                              # 12.0 mm width in Y
CAP_HEIGHT = 16.0                             # 16.0 mm height in Z
CAP_THICKNESS = 3.5                           # 3.5 mm thickness in X
CAP_CHAMFER = 1.0                             # 1.0 mm 45° perimeter chamfer
M3_SCREW_HOLE_DIA = 3.4                       # 3.4 mm M3 clearance through-hole

# Piece 4: Snap-in Hub Top Cap (Idea 001 Modular Architecture)
HUB_CAP_FLANGE_DIA = 50.0                         # 50.0 mm outer diameter (matches hub OD)
HUB_CAP_FLANGE_RADIUS = HUB_CAP_FLANGE_DIA / 2.0  # 25.0 mm
HUB_CAP_FLANGE_THICKNESS = 3.0                    # 3.0 mm flange thickness
HUB_CAP_FLANGE_CHAMFER = 1.5                      # 1.5 mm perimeter 45° chamfer
HUB_CAP_SKIRT_IN_DIA = 38.0                       # 38.0 mm inner bore of skirt (R 19.0 mm)
HUB_CAP_SKIRT_IN_RADIUS = HUB_CAP_SKIRT_IN_DIA / 2.0  # 19.0 mm
HUB_CAP_SKIRT_ROOT_DIA = 41.6                     # 41.6 mm nominal skirt OD (R 20.8 mm)
HUB_CAP_SKIRT_ROOT_RADIUS = HUB_CAP_SKIRT_ROOT_DIA / 2.0  # 20.8 mm
HUB_CAP_BARB_DIA = 43.0                           # 43.0 mm retention barb OD (R 21.5 mm, 0.5mm snap)
HUB_CAP_BARB_RADIUS = HUB_CAP_BARB_DIA / 2.0      # 21.5 mm
HUB_CAP_TIP_DIA = 40.8                            # 40.8 mm lead-in tip OD (R 20.4 mm)
HUB_CAP_TIP_RADIUS = HUB_CAP_TIP_DIA / 2.0        # 20.4 mm
HUB_CAP_TOTAL_HEIGHT = 9.0                        # 9.0 mm overall height (3mm flange + 6mm skirt)
HUB_CAP_SLOT_WIDTH = 2.4                          # 2.4 mm axial relief slot width (4 flex fingers)
HUB_CAP_NUM_FINGERS = 4                           # 4 independent cantilever flex fingers

# Material Properties
MATERIAL = "PETG"
PETG_DENSITY_G_CM3 = 1.27
DEFAULT_INFILL = 0.25


# =============================================================================
# PURE-PYTHON GEOMETRY ENGINE
# =============================================================================

Vec3 = Tuple[float, float, float]
Tri = Tuple[Vec3, Vec3, Vec3]
Vec2 = Tuple[float, float]

def _sub(a: Vec3, b: Vec3) -> Vec3:
    return (a[0] - b[0], a[1] - b[1], a[2] - b[2])

def _cross(a: Vec3, b: Vec3) -> Vec3:
    return (
        a[1] * b[2] - a[2] * b[1],
        a[2] * b[0] - a[0] * b[2],
        a[0] * b[1] - a[1] * b[0],
    )

def _dot(a: Vec3, b: Vec3) -> float:
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2]

def _normal(t: Tri) -> Vec3:
    a, b, c = t
    n = _cross(_sub(b, a), _sub(c, a))
    l = math.sqrt(_dot(n, n))
    return (n[0] / l, n[1] / l, n[2] / l) if l > 1e-12 else (0.0, 0.0, 0.0)


@dataclass
class Mesh:
    name: str
    triangles: List[Tri]

    def __init__(self, name: str = "mesh"):
        self.name = name
        self.triangles = []

    def add(self, a: Vec3, b: Vec3, c: Vec3) -> None:
        area = _cross(_sub(b, a), _sub(c, a))
        if _dot(area, area) > 1e-18:
            self.triangles.append((a, b, c))

    def quad(self, a: Vec3, b: Vec3, c: Vec3, d: Vec3) -> None:
        self.add(a, b, c)
        self.add(a, c, d)

    def extend(self, other: "Mesh") -> None:
        self.triangles.extend(other.triangles)

    def bounds(self) -> Tuple[Vec3, Vec3]:
        pts = [p for t in self.triangles for p in t]
        if not pts:
            return ((0.0, 0.0, 0.0), (0.0, 0.0, 0.0))
        return (
            (min(p[0] for p in pts), min(p[1] for p in pts), min(p[2] for p in pts)),
            (max(p[0] for p in pts), max(p[1] for p in pts), max(p[2] for p in pts)),
        )

    def signed_volume(self) -> float:
        total = 0.0
        for a, b, c in self.triangles:
            total += _dot(a, _cross(b, c)) / 6.0
        return total

    def audit(self) -> Dict[str, any]:
        edges: Dict[Tuple[Vec3, Vec3], int] = {}
        deg = 0
        finite = True
        for t in self.triangles:
            for v in t:
                for coord in v:
                    if not math.isfinite(coord):
                        finite = False
            if _normal(t) == (0.0, 0.0, 0.0):
                deg += 1
            for p, q in ((t[0], t[1]), (t[1], t[2]), (t[2], t[0])):
                k = tuple(sorted((
                    (round(p[0], 4), round(p[1], 4), round(p[2], 4)),
                    (round(q[0], 4), round(q[1], 4), round(q[2], 4)),
                )))
                edges[k] = edges.get(k, 0) + 1

        b_edges = sum(1 for v in edges.values() if v == 1)
        nm_edges = sum(1 for v in edges.values() if v > 2)
        b_min, b_max = self.bounds()
        dims = [round(b_max[i] - b_min[i], 2) for i in range(3)]
        vol_cm3 = round(abs(self.signed_volume()) / 1000.0, 2)
        passed = (b_edges == 0 and nm_edges == 0 and deg == 0 and finite)

        return {
            "file": f"{self.name}.stl",
            "triangles": len(self.triangles),
            "boundary_edges": b_edges,
            "nonmanifold_edges": nm_edges,
            "degenerate_triangles": deg,
            "finite_coordinates": finite,
            "bounds_min": [round(x, 2) for x in b_min],
            "bounds_max": [round(x, 2) for x in b_max],
            "dimensions": dims,
            "volume_cm3": vol_cm3,
            "estimated_mass_petg_g": round(vol_cm3 * PETG_DENSITY_G_CM3 * (0.40 + 0.60 * DEFAULT_INFILL), 1),
            "passed": passed,
        }

    def save_stl(self, path: Path) -> None:
        path.parent.mkdir(parents=True, exist_ok=True)
        with path.open("wb") as f:
            header = f"{DESIGN_NAME} - {self.name}".encode("utf-8")[:80].ljust(80, b"\0")
            f.write(header)
            f.write(struct.pack("<I", len(self.triangles)))
            for t in self.triangles:
                norm = _normal(t)
                f.write(struct.pack("<3f", *norm))
                for pt in t:
                    f.write(struct.pack("<3f", *pt))
                f.write(struct.pack("<H", 0))


# =============================================================================
# GEOMETRIC PRIMITIVES
# =============================================================================

def _star_fan(m: Mesh, loop: Sequence[Vec2], z: float, center: Vec2 = (0.0, 0.0), up: bool = True) -> None:
    c = (center[0], center[1], z)
    n = len(loop)
    for i in range(n):
        j = (i + 1) % n
        p0 = (loop[i][0], loop[i][1], z)
        p1 = (loop[j][0], loop[j][1], z)
        if up:
            m.add(c, p0, p1)
        else:
            m.add(c, p1, p0)

def _loop_wall(m: Mesh, loop: Sequence[Vec2], z0: float, z1: float) -> None:
    n = len(loop)
    for i in range(n):
        j = (i + 1) % n
        b0 = (loop[i][0], loop[i][1], z0)
        b1 = (loop[j][0], loop[j][1], z0)
        t0 = (loop[i][0], loop[i][1], z1)
        t1 = (loop[j][0], loop[j][1], z1)
        m.quad(b0, b1, t1, t0)

def _ring_face(m: Mesh, outer: Sequence[Vec2], inner: Sequence[Vec2], z: float, up: bool = True) -> None:
    assert len(outer) == len(inner)
    n = len(outer)
    for i in range(n):
        j = (i + 1) % n
        o0 = (outer[i][0], outer[i][1], z)
        o1 = (outer[j][0], outer[j][1], z)
        i0 = (inner[i][0], inner[i][1], z)
        i1 = (inner[j][0], inner[j][1], z)
        if up:
            m.quad(o0, o1, i1, i0)
        else:
            m.quad(o0, i0, i1, o1)


# =============================================================================
# COMPONENT BUILDERS
# =============================================================================

def build_piece1_base(r_base: float = BASE_PLATE_RADIUS, h_base: float = BASE_PLATE_HEIGHT,
                      r_spindle: float = SPINDLE_RADIUS, h_spindle: float = SPINDLE_HEIGHT,
                      notch_depth: float = CROSSHAIR_DEPTH, notch_width: float = CROSSHAIR_WIDTH,
                      chamfer: float = SPINDLE_CHAMFER,
                      r_shoulder: float = BEARING_608_INNER_SHOULDER_DIA / 2.0,
                      h_shoulder: float = BEARING_608_INNER_SHOULDER_HEIGHT,
                      r_post: float = BEARING_608_POST_DIA / 2.0,
                      h_post: float = BEARING_608_POST_HEIGHT,
                      post_chamfer: float = BEARING_608_POST_CHAMFER,
                      n_arc: int = 16) -> Mesh:
    """Build Piece 1 (Fixed Pivot Base) with 3.0 mm base plate, 4 crosshair notches, and 608 bearing post."""
    m = Mesh("circle_cutter_base")
    r_notch = r_base - notch_depth
    half_w = notch_width / 2.0
    outer_pts: List[Vec2] = []
    spindle_pts: List[Vec2] = []

    for q in range(4):
        ang_c = q * math.pi / 2.0
        d_ang = math.asin(min(half_w / r_base, 0.99))
        ang_start = ang_c + d_ang
        next_c = (q + 1) * math.pi / 2.0
        ang_end = next_c - d_ang

        for i in range(n_arc):
            a = ang_start + (ang_end - ang_start) * i / n_arc
            outer_pts.append((r_base * math.cos(a), r_base * math.sin(a)))

        ux, uy = math.cos(next_c), math.sin(next_c)
        px, py = -uy, ux
        p1 = (r_base * ux - half_w * px, r_base * uy - half_w * py)
        p2 = (r_notch * ux - half_w * px, r_notch * uy - half_w * py)
        p3 = (r_notch * ux + half_w * px, r_notch * uy + half_w * py)
        p4 = (r_base * ux + half_w * px, r_base * uy + half_w * py)
        outer_pts.extend([p1, p2, p3, p4])

    n = len(outer_pts)
    for p in outer_pts:
        ang = math.atan2(p[1], p[0])
        spindle_pts.append((r_spindle * math.cos(ang), r_spindle * math.sin(ang)))

    r_top = r_spindle - chamfer
    z_spindle_top = h_base + h_spindle
    z_chamfer = z_spindle_top - chamfer
    top_pts = [(r_top * math.cos(math.atan2(p[1], p[0])), r_top * math.sin(math.atan2(p[1], p[0]))) for p in spindle_pts]

    # Shoulder and Post loops (all aligned to identical polar angles as spindle_pts)
    shoulder_pts = [(r_shoulder * math.cos(math.atan2(p[1], p[0])), r_shoulder * math.sin(math.atan2(p[1], p[0]))) for p in spindle_pts]
    post_pts = [(r_post * math.cos(math.atan2(p[1], p[0])), r_post * math.sin(math.atan2(p[1], p[0]))) for p in spindle_pts]
    r_post_top = r_post - post_chamfer
    post_top_pts = [(r_post_top * math.cos(math.atan2(p[1], p[0])), r_post_top * math.sin(math.atan2(p[1], p[0]))) for p in spindle_pts]

    z_shoulder_top = z_spindle_top + h_shoulder
    z_post_chamfer = z_shoulder_top + h_post - post_chamfer
    z_post_top = z_shoulder_top + h_post

    # 1. Base bottom cap at Z=0 (vinyl contact plane)
    _star_fan(m, outer_pts, 0.0, up=False)
    # 2. Base plate wall from Z=0 to Z=h_base (3.0 mm)
    _loop_wall(m, outer_pts, 0.0, h_base)
    # 3. Shoulder at Z=h_base
    _ring_face(m, outer_pts, spindle_pts, h_base, up=True)
    # 4. Spindle wall
    _loop_wall(m, spindle_pts, h_base, z_chamfer)
    # 5. Spindle top chamfer
    for i in range(n):
        j = (i + 1) % n
        m.quad((spindle_pts[i][0], spindle_pts[i][1], z_chamfer),
               (spindle_pts[j][0], spindle_pts[j][1], z_chamfer),
               (top_pts[j][0], top_pts[j][1], z_spindle_top),
               (top_pts[i][0], top_pts[i][1], z_spindle_top))
    # 6. Spindle top annular face at z_spindle_top (from top_pts to shoulder_pts, normal +Z)
    _ring_face(m, top_pts, shoulder_pts, z_spindle_top, up=True)
    # 7. Inner race shoulder vertical wall (from z_spindle_top to z_shoulder_top, normal outward)
    _loop_wall(m, shoulder_pts, z_spindle_top, z_shoulder_top)
    # 8. Inner race seating face at z_shoulder_top (from shoulder_pts to post_pts, normal +Z)
    _ring_face(m, shoulder_pts, post_pts, z_shoulder_top, up=True)
    # 9. Center post vertical wall (from z_shoulder_top to z_post_chamfer, normal outward)
    _loop_wall(m, post_pts, z_shoulder_top, z_post_chamfer)
    # 10. Post top lead-in chamfer
    for i in range(n):
        j = (i + 1) % n
        m.quad((post_pts[i][0], post_pts[i][1], z_post_chamfer),
               (post_pts[j][0], post_pts[j][1], z_post_chamfer),
               (post_top_pts[j][0], post_top_pts[j][1], z_post_top),
               (post_top_pts[i][0], post_top_pts[i][1], z_post_top))
    # 11. Post top cap at z_post_top (normal +Z)
    _star_fan(m, post_top_pts, z_post_top, up=True)
    return m


def make_beveled_rect_loop(y_min: float, y_max: float, z_min: float, z_max: float, bevel: float, k: int = 8) -> List[Vec2]:
    """Generate CCW loop of 4*k points for a beveled rectangle in YZ."""
    pts: List[Vec2] = []
    # Side 0: Right side (+Y)
    for i in range(k):
        z = (z_min + bevel) + (z_max - z_min - 2 * bevel) * i / k
        pts.append((y_max, z))
    # Side 1: Top side (+Z)
    for i in range(k):
        y = (y_max - bevel) - (y_max - y_min - 2 * bevel) * i / k
        pts.append((y, z_max))
    # Side 2: Left side (-Y)
    for i in range(k):
        z = (z_max - bevel) - (z_max - z_min - 2 * bevel) * i / k
        pts.append((y_min, z))
    # Side 3: Bottom side (-Z)
    for i in range(k):
        y = (y_min + bevel) + (y_max - y_min - 2 * bevel) * i / k
        pts.append((y, z_min))
    return pts


def build_piece2_arm(r_hub_outer: float = HUB_OUTER_RADIUS, r_bore: float = HUB_RECESS_RADIUS,
                     z_hub_total: float = HUB_TOTAL_HEIGHT,
                     hub_chamfer: float = HUB_TOP_CHAMFER, x0: float = ARM_ROOT_X,
                     x1: float = DUAL_HEAD_START_X, x2: float = DUAL_HEAD_FULL_X,
                     x3: float = DISTAL_X, arm_w: float = ARM_WIDTH, arm_h: float = ARM_HEIGHT,
                     arm_bevel: float = ARM_BEVEL, dual_w: float = DUAL_HEAD_WIDTH,
                     blade_y: float = BLADE_PAD_Y, bearing_y: float = BEARING_PAD_Y,
                     bearing_axle_z: float = BEARING_AXLE_LOCAL_Z,
                     standoff_od: float = BEARING_STANDOFF_OD, standoff_len: float = BEARING_STANDOFF_LEN,
                     m5_dia: float = M5_INSERT_DIA, m5_depth: float = M5_INSERT_DEPTH,
                     m3_dia: float = HEAT_SET_M3_DIA, m3_depth: float = HEAT_SET_M3_DEPTH,
                     slot_w: float = BLADE_SLOT_WIDTH, tab_h: float = BLADE_SLOT_DEPTH,
                     n_hub: int = 64, k: int = 8) -> Mesh:
    """Build Piece 2 (Rotating Arm Assembly) with Side-by-Side Dual Head."""
    m = Mesh("circle_cutter_arm")

    # -------------------------------------------------------------------------
    # Sub-Assembly A: Hub Sleeve with Through-Bore & Internal Retention Groove
    # -------------------------------------------------------------------------
    if r_hub_outer > 0:
        z_hub_ch = z_hub_total - hub_chamfer
        r_hub_top = r_hub_outer - hub_chamfer

        bore_profile = [
            (r_bore, 0.0),
            (r_bore, HUB_GROOVE_Z_START),
            (r_bore + HUB_GROOVE_DEPTH, HUB_GROOVE_Z_START + 0.8),
            (r_bore + HUB_GROOVE_DEPTH, HUB_GROOVE_Z_END),
            (r_bore, HUB_GROOVE_Z_END + 0.8),
            (r_bore, z_hub_total - HUB_INNER_CHAMFER),
            (r_bore + HUB_INNER_CHAMFER, z_hub_total),
        ]
        outer_profile = [
            (r_hub_outer, 0.0),
            (r_hub_outer, z_hub_ch),
            (r_hub_top, z_hub_total),
        ]

        # Bottom annular ring at local Z=0 (normal -Z)
        for i in range(n_hub):
            j = (i + 1) % n_hub
            ai, aj = 2 * math.pi * i / n_hub, 2 * math.pi * j / n_hub
            p_out_i = (r_hub_outer * math.cos(ai), r_hub_outer * math.sin(ai), 0.0)
            p_out_j = (r_hub_outer * math.cos(aj), r_hub_outer * math.sin(aj), 0.0)
            p_in_i = (r_bore * math.cos(ai), r_bore * math.sin(ai), 0.0)
            p_in_j = (r_bore * math.cos(aj), r_bore * math.sin(aj), 0.0)
            m.quad(p_out_i, p_in_i, p_in_j, p_out_j)

        # Top annular ring at local Z=z_hub_total (normal +Z)
        r_in_top = bore_profile[-1][0]
        r_out_top = outer_profile[-1][0]
        for i in range(n_hub):
            j = (i + 1) % n_hub
            ai, aj = 2 * math.pi * i / n_hub, 2 * math.pi * j / n_hub
            p_out_i = (r_out_top * math.cos(ai), r_out_top * math.sin(ai), z_hub_total)
            p_out_j = (r_out_top * math.cos(aj), r_out_top * math.sin(aj), z_hub_total)
            p_in_i = (r_in_top * math.cos(ai), r_in_top * math.sin(ai), z_hub_total)
            p_in_j = (r_in_top * math.cos(aj), r_in_top * math.sin(aj), z_hub_total)
            m.quad(p_out_i, p_out_j, p_in_j, p_in_i)

        # Outer walls (normal outward)
        for s in range(len(outer_profile) - 1):
            r1, z1 = outer_profile[s]
            r2, z2 = outer_profile[s + 1]
            for i in range(n_hub):
                j = (i + 1) % n_hub
                ai, aj = 2 * math.pi * i / n_hub, 2 * math.pi * j / n_hub
                p1_i = (r1 * math.cos(ai), r1 * math.sin(ai), z1)
                p1_j = (r1 * math.cos(aj), r1 * math.sin(aj), z1)
                p2_j = (r2 * math.cos(aj), r2 * math.sin(aj), z2)
                p2_i = (r2 * math.cos(ai), r2 * math.sin(ai), z2)
                m.quad(p1_i, p1_j, p2_j, p2_i)

        # Inner bore walls (normal inward toward center axis)
        for s in range(len(bore_profile) - 1):
            r1, z1 = bore_profile[s]
            r2, z2 = bore_profile[s + 1]
            for i in range(n_hub):
                j = (i + 1) % n_hub
                ai, aj = 2 * math.pi * i / n_hub, 2 * math.pi * j / n_hub
                p1_i = (r1 * math.cos(ai), r1 * math.sin(ai), z1)
                p2_i = (r2 * math.cos(ai), r2 * math.sin(ai), z2)
                p2_j = (r2 * math.cos(aj), r2 * math.sin(aj), z2)
                p1_j = (r1 * math.cos(aj), r1 * math.sin(aj), z1)
                m.quad(p1_i, p2_i, p2_j, p1_j)

    # -------------------------------------------------------------------------
    # Sub-Assembly B: Arm Beam with Side-by-Side Dual Head (Closed Manifold Solid)
    # -------------------------------------------------------------------------
    n_loop = 4 * k  # 32 points
    hw = arm_w / 2.0
    h_dual = dual_w / 2.0

    loop_straight = make_beveled_rect_loop(-hw, hw, 0.0, arm_h, arm_bevel, k)
    loop_dual = make_beveled_rect_loop(-h_dual, h_dual, 0.0, arm_h, arm_bevel, k)

    # Arm root cap at x0 (pointing -X)
    c_root = (x0, 0.0, arm_h / 2.0)
    for i in range(n_loop):
        j = (i + 1) % n_loop
        m.add(c_root, (x0, loop_straight[j][0], loop_straight[j][1]), (x0, loop_straight[i][0], loop_straight[i][1]))

    # Section 1: x0 to x1 (straight beam, 20mm wide)
    for i in range(n_loop):
        j = (i + 1) % n_loop
        m.quad((x0, loop_straight[i][0], loop_straight[i][1]), (x0, loop_straight[j][0], loop_straight[j][1]),
               (x1, loop_straight[j][0], loop_straight[j][1]), (x1, loop_straight[i][0], loop_straight[i][1]))

    # Section 2: x1 to x2 (flare from 20mm to 36mm wide)
    for i in range(n_loop):
        j = (i + 1) % n_loop
        m.quad((x1, loop_straight[i][0], loop_straight[i][1]), (x1, loop_straight[j][0], loop_straight[j][1]),
               (x2, loop_dual[j][0], loop_dual[j][1]), (x2, loop_dual[i][0], loop_dual[i][1]))

    # Section 3: x2 to x3 (dual head beam, 36mm wide)
    for i in range(n_loop):
        j = (i + 1) % n_loop
        m.quad((x2, loop_dual[i][0], loop_dual[i][1]), (x2, loop_dual[j][0], loop_dual[j][1]),
               (x3, loop_dual[j][0], loop_dual[j][1]), (x3, loop_dual[i][0], loop_dual[i][1]))

    # Distal Face at X3 = 175.0 (Dual Head Front Face)
    # Blade boundary (19 pts in CCW order)
    bnd_blade = [loop_dual[idx] for idx in range(28, 32)] + \
                [loop_dual[idx] for idx in range(0, 13)] + \
                [(0.0, 8.0), (0.0, 4.0)]

    # Bearing boundary (19 pts in CCW order)
    bnd_bearing = [loop_dual[idx] for idx in range(12, 29)] + \
                  [(0.0, 4.0), (0.0, 8.0)]

    n_p = 19

    # Blade Pad M3 hole: c = (blade_y, arm_h / 2.0), r = m3_dia / 2.0, depth = m3_depth
    m3_c = (blade_y, arm_h / 2.0)
    m3_r = m3_dia / 2.0

    # Polar-matched circle_m3: each circle vertex matches the polar angle of bnd_blade[i]
    # around m3_c, preventing crossed quads/bowties on the distal face.
    circle_m3 = []
    for p in bnd_blade:
        ang = math.atan2(p[1] - m3_c[1], p[0] - m3_c[0])
        circle_m3.append((m3_c[0] + m3_r * math.cos(ang),
                          m3_c[1] + m3_r * math.sin(ang)))

    # Distal face around M3 hole (+X normal)
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x3, bnd_blade[i][0], bnd_blade[i][1]),
               (x3, bnd_blade[j][0], bnd_blade[j][1]),
               (x3, circle_m3[j][0], circle_m3[j][1]),
               (x3, circle_m3[i][0], circle_m3[i][1]))

    # M3 hole cylinder wall (inward-facing normal into hole void)
    x3_m3_bot = x3 - m3_depth
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x3, circle_m3[i][0], circle_m3[i][1]),
               (x3, circle_m3[j][0], circle_m3[j][1]),
               (x3_m3_bot, circle_m3[j][0], circle_m3[j][1]),
               (x3_m3_bot, circle_m3[i][0], circle_m3[i][1]))

    # M3 hole bottom cap (+X normal into hole void)
    c_m3_bot = (x3_m3_bot, m3_c[0], m3_c[1])
    for i in range(n_p):
        j = (i + 1) % n_p
        m.add(c_m3_bot, (x3_m3_bot, circle_m3[i][0], circle_m3[i][1]),
                        (x3_m3_bot, circle_m3[j][0], circle_m3[j][1]))

    # Bearing Pad:
    boss_c = (bearing_y, bearing_axle_z)
    r_boss = standoff_od / 2.0
    r_m5 = m5_dia / 2.0
    x3_boss = x3 + standoff_len
    x3_m5_bot = x3_boss - m5_depth

    # Polar-matched boss and M5 circles: each vertex matches the polar angle of bnd_bearing[i]
    circle_boss_base = []
    circle_boss_top = []
    circle_m5 = []
    for p in bnd_bearing:
        ang = math.atan2(p[1] - boss_c[1], p[0] - boss_c[0])
        circle_boss_base.append((boss_c[0] + r_boss * math.cos(ang),
                                 boss_c[1] + r_boss * math.sin(ang)))
        circle_boss_top.append((boss_c[0] + r_boss * math.cos(ang),
                                boss_c[1] + r_boss * math.sin(ang)))
        circle_m5.append((boss_c[0] + r_m5 * math.cos(ang),
                          boss_c[1] + r_m5 * math.sin(ang)))

    # Distal face around boss base (+X normal)
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x3, bnd_bearing[i][0], bnd_bearing[i][1]),
               (x3, bnd_bearing[j][0], bnd_bearing[j][1]),
               (x3, circle_boss_base[j][0], circle_boss_base[j][1]),
               (x3, circle_boss_base[i][0], circle_boss_base[i][1]))

    # Boss outer cylinder wall (outward normal away from boss axis)
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x3, circle_boss_base[i][0], circle_boss_base[i][1]),
               (x3, circle_boss_base[j][0], circle_boss_base[j][1]),
               (x3_boss, circle_boss_top[j][0], circle_boss_top[j][1]),
               (x3_boss, circle_boss_top[i][0], circle_boss_top[i][1]))

    # Boss annular top (+X normal)
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x3_boss, circle_boss_top[i][0], circle_boss_top[i][1]),
               (x3_boss, circle_boss_top[j][0], circle_boss_top[j][1]),
               (x3_boss, circle_m5[j][0], circle_m5[j][1]),
               (x3_boss, circle_m5[i][0], circle_m5[i][1]))

    # M5 hole cylinder wall (inward-facing normal into hole void)
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x3_boss, circle_m5[i][0], circle_m5[i][1]),
               (x3_boss, circle_m5[j][0], circle_m5[j][1]),
               (x3_m5_bot, circle_m5[j][0], circle_m5[j][1]),
               (x3_m5_bot, circle_m5[i][0], circle_m5[i][1]))

    # M5 hole bottom cap (+X normal into hole void)
    c_m5_bot = (x3_m5_bot, boss_c[0], boss_c[1])
    for i in range(n_p):
        j = (i + 1) % n_p
        m.add(c_m5_bot, (x3_m5_bot, circle_m5[i][0], circle_m5[i][1]),
                        (x3_m5_bot, circle_m5[j][0], circle_m5[j][1]))

    # -------------------------------------------------------------------------
    # Sub-Assembly C: Retaining Tabs flanking 6.0 mm Blade Slot on Blade Pad
    # -------------------------------------------------------------------------
    def add_tab_box(bx0: float, bx1: float, by0: float, by1: float, bz0: float, bz1: float) -> None:
        corners = [(by0, bz0), (by1, bz0), (by1, bz1), (by0, bz1)]
        m.quad((bx0, by0, bz0), (bx0, by0, bz1), (bx0, by1, bz1), (bx0, by1, bz0))
        m.quad((bx1, by0, bz0), (bx1, by1, bz0), (bx1, by1, bz1), (bx1, by0, bz1))
        for idx in range(4):
            nxt = (idx + 1) % 4
            m.quad((bx0, corners[idx][0], corners[idx][1]), (bx0, corners[nxt][0], corners[nxt][1]),
                   (bx1, corners[nxt][0], corners[nxt][1]), (bx1, corners[idx][0], corners[idx][1]))

    add_tab_box(x3, x3 + tab_h, 0.0, blade_y - slot_w / 2.0, 0.0, arm_h)
    add_tab_box(x3, x3 + tab_h, blade_y + slot_w / 2.0, h_dual, 0.0, arm_h)

    return m


def build_piece3_blade_cap(w: float = CAP_WIDTH, h: float = CAP_HEIGHT, t: float = CAP_THICKNESS,
                           hole_dia: float = M3_SCREW_HOLE_DIA, chamfer: float = CAP_CHAMFER,
                           pts_per_quadrant: int = 8) -> Mesh:
    """Build Piece 3 (Blade Clamping Cap) with perimeter chamfers and M3 clearance hole."""
    m = Mesh("circle_cutter_blade_cap")
    hw = w / 2.0
    hh = h / 2.0
    r_hole = hole_dia / 2.0
    k = pts_per_quadrant

    outer_yz: List[Vec2] = []
    inner_yz: List[Vec2] = []

    # Quadrant 0: Right side (+Y, angles -pi/4 to +pi/4)
    for i in range(k):
        pos = -hh + chamfer + (2 * hh - 2 * chamfer) * i / k
        outer_yz.append((hw, pos))
        ang = -math.pi / 4.0 + (math.pi / 2.0) * i / k
        inner_yz.append((r_hole * math.cos(ang), r_hole * math.sin(ang)))

    # Quadrant 1: Top side (+Z, angles +pi/4 to +3pi/4)
    for i in range(k):
        pos = hw - chamfer - (2 * hw - 2 * chamfer) * i / k
        outer_yz.append((pos, hh))
        ang = math.pi / 4.0 + (math.pi / 2.0) * i / k
        inner_yz.append((r_hole * math.cos(ang), r_hole * math.sin(ang)))

    # Quadrant 2: Left side (-Y, angles +3pi/4 to +5pi/4)
    for i in range(k):
        pos = hh - chamfer - (2 * hh - 2 * chamfer) * i / k
        outer_yz.append((-hw, pos))
        ang = 3 * math.pi / 4.0 + (math.pi / 2.0) * i / k
        inner_yz.append((r_hole * math.cos(ang), r_hole * math.sin(ang)))

    # Quadrant 3: Bottom side (-Z, angles -3pi/4 to -pi/4)
    for i in range(k):
        pos = -hw + chamfer + (2 * hw - 2 * chamfer) * i / k
        outer_yz.append((pos, -hh))
        ang = -3 * math.pi / 4.0 + (math.pi / 2.0) * i / k
        inner_yz.append((r_hole * math.cos(ang), r_hole * math.sin(ang)))

    n = len(outer_yz)

    # Front face at X = 0 (pointing -X)
    for i in range(n):
        j = (i + 1) % n
        m.quad((0.0, outer_yz[i][0], outer_yz[i][1]), (0.0, inner_yz[i][0], inner_yz[i][1]),
               (0.0, inner_yz[j][0], inner_yz[j][1]), (0.0, outer_yz[j][0], outer_yz[j][1]))

    # Back face at X = t (pointing +X)
    for i in range(n):
        j = (i + 1) % n
        m.quad((t, outer_yz[i][0], outer_yz[i][1]), (t, outer_yz[j][0], outer_yz[j][1]),
               (t, inner_yz[j][0], inner_yz[j][1]), (t, inner_yz[i][0], inner_yz[i][1]))

    # Outer perimeter wall from X = 0 to X = t
    for i in range(n):
        j = (i + 1) % n
        m.quad((0.0, outer_yz[i][0], outer_yz[i][1]), (0.0, outer_yz[j][0], outer_yz[j][1]),
               (t, outer_yz[j][0], outer_yz[j][1]), (t, outer_yz[i][0], outer_yz[i][1]))

    # Inner hole wall from X = 0 to X = t (pointing inward)
    for i in range(n):
        j = (i + 1) % n
        m.quad((0.0, inner_yz[i][0], inner_yz[i][1]), (t, inner_yz[i][0], inner_yz[i][1]),
               (t, inner_yz[j][0], inner_yz[j][1]), (0.0, inner_yz[j][0], inner_yz[j][1]))

    return m


def build_piece4_hub_cap(r_flange: float = HUB_CAP_FLANGE_RADIUS,
                         ch_flange: float = HUB_CAP_FLANGE_CHAMFER,
                         h_flange: float = HUB_CAP_FLANGE_THICKNESS,
                         r_skirt_in: float = HUB_CAP_SKIRT_IN_RADIUS,
                         r_skirt_root: float = HUB_CAP_SKIRT_ROOT_RADIUS,
                         r_barb: float = HUB_CAP_BARB_RADIUS,
                         r_tip: float = HUB_CAP_TIP_RADIUS,
                         z_shoulder: float = 5.5,
                         z_crest: float = 6.2,
                         z_ramp: float = 7.2,
                         z_top: float = HUB_CAP_TOTAL_HEIGHT,
                         w_slot: float = HUB_CAP_SLOT_WIDTH,
                         n_fingers: int = HUB_CAP_NUM_FINGERS,
                         r_pocket: float = BEARING_608_POCKET_DIA / 2.0,
                         r_cup_out: float = BEARING_608_POCKET_WALL_OD / 2.0,
                         z_thrust: float = 4.0,
                         z_cup_top: float = 7.0,
                         r_relief: float = BEARING_608_RELIEF_DIA / 2.0,
                         z_relief_bot: float = 1.5,
                         n_f: int = 16, n_s: int = 6) -> Mesh:
    """Build Piece 4 (Snap-in Hub Top Cap) with 4 flex fingers and integrated 608 bearing pocket."""
    m = Mesh("circle_cutter_hub_cap")
    r_bed = r_flange - ch_flange

    skirt_profile = [
        (r_skirt_root, h_flange),
        (r_skirt_root, z_shoulder),
        (r_barb, z_crest),
        (r_barb, z_ramp),
        (r_tip, z_top),
    ]

    r_mid = (r_skirt_root + r_barb) / 2.0
    slot_half_ang = (w_slot / r_mid) / 2.0

    finger_angles = []
    for k in range(n_fingers):
        phi_k = k * (math.pi / 2.0) + (math.pi / 4.0)
        a_start = phi_k - (math.pi / 4.0 - slot_half_ang)
        a_end = phi_k + (math.pi / 4.0 - slot_half_ang)
        finger_angles.append((a_start, a_end))

    all_angles = []
    finger_slices = []
    slot_slices = []
    for k in range(n_fingers):
        a_s, a_e = finger_angles[k]
        s_idx = len(all_angles)
        for i in range(n_f):
            ang = a_s + (a_e - a_s) * i / (n_f - 1)
            all_angles.append(ang)
        e_idx = len(all_angles) - 1
        finger_slices.append((s_idx, e_idx))
        next_as = finger_angles[(k + 1) % n_fingers][0]
        if next_as < a_e:
            next_as += 2 * math.pi
        slot_s = len(all_angles)
        for i in range(1, n_s - 1):
            ang = a_e + (next_as - a_e) * i / (n_s - 1)
            all_angles.append(ang % (2 * math.pi))
        slot_e = len(all_angles) - 1
        slot_slices.append((slot_s, slot_e))

    n_tot = len(all_angles)

    # 1. Flange bottom face at Z=0 (disc of radius r_bed, normal -Z)
    c_bot = (0.0, 0.0, 0.0)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        ai, aj = all_angles[i], all_angles[j]
        pi = (r_bed * math.cos(ai), r_bed * math.sin(ai), 0.0)
        pj = (r_bed * math.cos(aj), r_bed * math.sin(aj), 0.0)
        m.add(c_bot, pj, pi)

    # 2. Flange bottom chamfer (Z=0 to Z=ch_flange)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        ai, aj = all_angles[i], all_angles[j]
        p1_i = (r_bed * math.cos(ai), r_bed * math.sin(ai), 0.0)
        p1_j = (r_bed * math.cos(aj), r_bed * math.sin(aj), 0.0)
        p2_j = (r_flange * math.cos(aj), r_flange * math.sin(aj), ch_flange)
        p2_i = (r_flange * math.cos(ai), r_flange * math.sin(ai), ch_flange)
        m.quad(p1_i, p1_j, p2_j, p2_i)

    # 3. Flange vertical cylinder wall (Z=ch_flange to Z=h_flange)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        ai, aj = all_angles[i], all_angles[j]
        p1_i = (r_flange * math.cos(ai), r_flange * math.sin(ai), ch_flange)
        p1_j = (r_flange * math.cos(aj), r_flange * math.sin(aj), ch_flange)
        p2_j = (r_flange * math.cos(aj), r_flange * math.sin(aj), h_flange)
        p2_i = (r_flange * math.cos(ai), r_flange * math.sin(ai), h_flange)
        m.quad(p1_i, p1_j, p2_j, p2_i)

    # 4. Integrated 608 Ball Bearing Pocket & Outer Race Thrust Seat:
    # Point loops for concentric features across all n_tot angles:
    skirt_in_pts = [(r_skirt_in * math.cos(a), r_skirt_in * math.sin(a)) for a in all_angles]
    cup_out_pts = [(r_cup_out * math.cos(a), r_cup_out * math.sin(a)) for a in all_angles]
    pocket_pts = [(r_pocket * math.cos(a), r_pocket * math.sin(a)) for a in all_angles]
    relief_pts = [(r_relief * math.cos(a), r_relief * math.sin(a)) for a in all_angles]

    # 4A. Flange floor between skirt and bearing cup (at Z = h_flange, normal +Z)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        p_out_i = (skirt_in_pts[i][0], skirt_in_pts[i][1], h_flange)
        p_out_j = (skirt_in_pts[j][0], skirt_in_pts[j][1], h_flange)
        p_in_j = (cup_out_pts[j][0], cup_out_pts[j][1], h_flange)
        p_in_i = (cup_out_pts[i][0], cup_out_pts[i][1], h_flange)
        m.quad(p_out_i, p_out_j, p_in_j, p_in_i)

    # 4B. Bearing cup outer cylinder wall (from Z = h_flange to Z = z_cup_top, normal outward)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        p1_i = (cup_out_pts[i][0], cup_out_pts[i][1], h_flange)
        p1_j = (cup_out_pts[j][0], cup_out_pts[j][1], h_flange)
        p2_j = (cup_out_pts[j][0], cup_out_pts[j][1], z_cup_top)
        p2_i = (cup_out_pts[i][0], cup_out_pts[i][1], z_cup_top)
        m.quad(p1_i, p1_j, p2_j, p2_i)

    # 4C. Bearing cup top annular rim (at Z = z_cup_top, from r_pocket to r_cup_out, normal +Z)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        p_out_i = (cup_out_pts[i][0], cup_out_pts[i][1], z_cup_top)
        p_out_j = (cup_out_pts[j][0], cup_out_pts[j][1], z_cup_top)
        p_in_j = (pocket_pts[j][0], pocket_pts[j][1], z_cup_top)
        p_in_i = (pocket_pts[i][0], pocket_pts[i][1], z_cup_top)
        m.quad(p_out_i, p_out_j, p_in_j, p_in_i)

    # 4D. Bearing pocket inner cylinder wall (from Z = z_thrust to Z = z_cup_top, normal inward)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        p1_i = (pocket_pts[i][0], pocket_pts[i][1], z_thrust)
        p2_i = (pocket_pts[i][0], pocket_pts[i][1], z_cup_top)
        p2_j = (pocket_pts[j][0], pocket_pts[j][1], z_cup_top)
        p1_j = (pocket_pts[j][0], pocket_pts[j][1], z_thrust)
        m.quad(p1_i, p2_i, p2_j, p1_j)

    # 4E. Outer race thrust shoulder face (at Z = z_thrust, from r_relief to r_pocket, normal +Z)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        p_out_i = (pocket_pts[i][0], pocket_pts[i][1], z_thrust)
        p_out_j = (pocket_pts[j][0], pocket_pts[j][1], z_thrust)
        p_in_j = (relief_pts[j][0], relief_pts[j][1], z_thrust)
        p_in_i = (relief_pts[i][0], relief_pts[i][1], z_thrust)
        m.quad(p_out_i, p_out_j, p_in_j, p_in_i)

    # 4F. Inner relief cavity cylinder wall (from Z = z_relief_bot to Z = z_thrust, normal inward)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        p1_i = (relief_pts[i][0], relief_pts[i][1], z_relief_bot)
        p2_i = (relief_pts[i][0], relief_pts[i][1], z_thrust)
        p2_j = (relief_pts[j][0], relief_pts[j][1], z_thrust)
        p1_j = (relief_pts[j][0], relief_pts[j][1], z_relief_bot)
        m.quad(p1_i, p2_i, p2_j, p1_j)

    # 4G. Inner relief cavity bottom disc (at Z = z_relief_bot, normal +Z)
    c_relief_bot = (0.0, 0.0, z_relief_bot)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        p_i = (relief_pts[i][0], relief_pts[i][1], z_relief_bot)
        p_j = (relief_pts[j][0], relief_pts[j][1], z_relief_bot)
        m.add(c_relief_bot, p_i, p_j)

    # 5. Top flange annular faces (normal +Z):
    # Outer ring (from r_skirt_root to r_flange, all 360 degrees)
    for i in range(n_tot):
        j = (i + 1) % n_tot
        ai, aj = all_angles[i], all_angles[j]
        p_out_i = (r_flange * math.cos(ai), r_flange * math.sin(ai), h_flange)
        p_out_j = (r_flange * math.cos(aj), r_flange * math.sin(aj), h_flange)
        p_in_j = (r_skirt_root * math.cos(aj), r_skirt_root * math.sin(aj), h_flange)
        p_in_i = (r_skirt_root * math.cos(ai), r_skirt_root * math.sin(ai), h_flange)
        m.quad(p_out_i, p_out_j, p_in_j, p_in_i)

    # Inner slot ring (from r_skirt_in to r_skirt_root, across slots)
    for k in range(n_fingers):
        e_idx = finger_slices[k][1]
        next_k = (k + 1) % n_fingers
        next_s_idx = finger_slices[next_k][0]
        slot_angs = [all_angles[e_idx]]
        if slot_slices[k][0] <= slot_slices[k][1]:
            for idx in range(slot_slices[k][0], slot_slices[k][1] + 1):
                slot_angs.append(all_angles[idx])
        slot_angs.append(all_angles[next_s_idx])
        for idx in range(len(slot_angs) - 1):
            ai, aj = slot_angs[idx], slot_angs[idx + 1]
            p_out_i = (r_skirt_root * math.cos(ai), r_skirt_root * math.sin(ai), h_flange)
            p_out_j = (r_skirt_root * math.cos(aj), r_skirt_root * math.sin(aj), h_flange)
            p_in_j = (r_skirt_in * math.cos(aj), r_skirt_in * math.sin(aj), h_flange)
            p_in_i = (r_skirt_in * math.cos(ai), r_skirt_in * math.sin(ai), h_flange)
            m.quad(p_out_i, p_out_j, p_in_j, p_in_i)

    # 6. Four Cantilever Flex Fingers:
    for k in range(n_fingers):
        s_idx, e_idx = finger_slices[k]
        finger_angs = [all_angles[idx] for idx in range(s_idx, e_idx + 1)]
        nf = len(finger_angs)

        # A) Inner cylindrical wall (r=r_skirt_in, matching z levels, normal inward)
        for s in range(len(skirt_profile) - 1):
            z1 = skirt_profile[s][1]
            z2 = skirt_profile[s + 1][1]
            for i in range(nf - 1):
                ai, aj = finger_angs[i], finger_angs[i + 1]
                p1_i = (r_skirt_in * math.cos(ai), r_skirt_in * math.sin(ai), z1)
                p2_i = (r_skirt_in * math.cos(ai), r_skirt_in * math.sin(ai), z2)
                p2_j = (r_skirt_in * math.cos(aj), r_skirt_in * math.sin(aj), z2)
                p1_j = (r_skirt_in * math.cos(aj), r_skirt_in * math.sin(aj), z1)
                m.quad(p1_i, p2_i, p2_j, p1_j)

        # B) Outer profiled wall (normal outward)
        for s in range(len(skirt_profile) - 1):
            r1, z1 = skirt_profile[s]
            r2, z2 = skirt_profile[s + 1]
            for i in range(nf - 1):
                ai, aj = finger_angs[i], finger_angs[i + 1]
                p1_i = (r1 * math.cos(ai), r1 * math.sin(ai), z1)
                p1_j = (r1 * math.cos(aj), r1 * math.sin(aj), z1)
                p2_j = (r2 * math.cos(aj), r2 * math.sin(aj), z2)
                p2_i = (r2 * math.cos(ai), r2 * math.sin(ai), z2)
                m.quad(p1_i, p1_j, p2_j, p2_i)

        # C) Top annular tip at Z=z_top (normal +Z)
        for i in range(nf - 1):
            ai, aj = finger_angs[i], finger_angs[i + 1]
            p_out_i = (r_tip * math.cos(ai), r_tip * math.sin(ai), z_top)
            p_out_j = (r_tip * math.cos(aj), r_tip * math.sin(aj), z_top)
            p_in_j = (r_skirt_in * math.cos(aj), r_skirt_in * math.sin(aj), z_top)
            p_in_i = (r_skirt_in * math.cos(ai), r_skirt_in * math.sin(ai), z_top)
            m.quad(p_out_i, p_out_j, p_in_j, p_in_i)

        # D) Side wall at start (angle = a_start, normal -theta)
        a_start = finger_angs[0]
        ux, uy = math.cos(a_start), math.sin(a_start)
        for s in range(len(skirt_profile) - 1):
            r1, z1 = skirt_profile[s]
            r2, z2 = skirt_profile[s + 1]
            p_in_1 = (r_skirt_in * ux, r_skirt_in * uy, z1)
            p_out_1 = (r1 * ux, r1 * uy, z1)
            p_out_2 = (r2 * ux, r2 * uy, z2)
            p_in_2 = (r_skirt_in * ux, r_skirt_in * uy, z2)
            m.quad(p_in_1, p_out_1, p_out_2, p_in_2)

        # E) Side wall at end (angle = a_end, normal +theta)
        a_end = finger_angs[-1]
        ux, uy = math.cos(a_end), math.sin(a_end)
        for s in range(len(skirt_profile) - 1):
            r1, z1 = skirt_profile[s]
            r2, z2 = skirt_profile[s + 1]
            p_in_1 = (r_skirt_in * ux, r_skirt_in * uy, z1)
            p_out_1 = (r1 * ux, r1 * uy, z1)
            p_out_2 = (r2 * ux, r2 * uy, z2)
            p_in_2 = (r_skirt_in * ux, r_skirt_in * uy, z2)
            m.quad(p_in_1, p_in_2, p_out_2, p_out_1)

    return m


def build_spindle_bore_coupon() -> Mesh:
    """Rapid 18-minute calibration coupon testing 40mm spindle vs 42mm bore slip fit AND 608 bearing post."""
    m = Mesh("circle_cutter_spindle_bore_coupon")
    n = 48
    h = 20.0
    r_shoulder = BEARING_608_INNER_SHOULDER_DIA / 2.0
    h_shoulder = BEARING_608_INNER_SHOULDER_HEIGHT
    r_post = BEARING_608_POST_DIA / 2.0
    h_post = BEARING_608_POST_HEIGHT
    post_chamfer = BEARING_608_POST_CHAMFER

    # Left: 40mm spindle coupon with 608 bearing shoulder and post
    c_x = -30.0
    spindle = [(20.0 * math.cos(2 * math.pi * i / n) + c_x, 20.0 * math.sin(2 * math.pi * i / n)) for i in range(n)]
    shoulder_pts = [(r_shoulder * math.cos(2 * math.pi * i / n) + c_x, r_shoulder * math.sin(2 * math.pi * i / n)) for i in range(n)]
    post_pts = [(r_post * math.cos(2 * math.pi * i / n) + c_x, r_post * math.sin(2 * math.pi * i / n)) for i in range(n)]
    r_post_top = r_post - post_chamfer
    post_top_pts = [(r_post_top * math.cos(2 * math.pi * i / n) + c_x, r_post_top * math.sin(2 * math.pi * i / n)) for i in range(n)]

    z_sh_top = h + h_shoulder
    z_post_ch = z_sh_top + h_post - post_chamfer
    z_post_top = z_sh_top + h_post

    c_bot_s = (c_x, 0.0, 0.0)
    for i in range(n):
        j = (i + 1) % n
        m.add(c_bot_s, (spindle[j][0], spindle[j][1], 0.0), (spindle[i][0], spindle[i][1], 0.0))
        m.quad((spindle[i][0], spindle[i][1], 0.0), (spindle[j][0], spindle[j][1], 0.0),
               (spindle[j][0], spindle[j][1], h), (spindle[i][0], spindle[i][1], h))
        # Annular face at h (from spindle to shoulder, normal +Z)
        m.quad((spindle[i][0], spindle[i][1], h), (spindle[j][0], spindle[j][1], h),
               (shoulder_pts[j][0], shoulder_pts[j][1], h), (shoulder_pts[i][0], shoulder_pts[i][1], h))
        # Shoulder cylinder wall
        m.quad((shoulder_pts[i][0], shoulder_pts[i][1], h), (shoulder_pts[j][0], shoulder_pts[j][1], h),
               (shoulder_pts[j][0], shoulder_pts[j][1], z_sh_top), (shoulder_pts[i][0], shoulder_pts[i][1], z_sh_top))
        # Shoulder top face (from shoulder to post, normal +Z)
        m.quad((shoulder_pts[i][0], shoulder_pts[i][1], z_sh_top), (shoulder_pts[j][0], shoulder_pts[j][1], z_sh_top),
               (post_pts[j][0], post_pts[j][1], z_sh_top), (post_pts[i][0], post_pts[i][1], z_sh_top))
        # Post cylinder wall
        m.quad((post_pts[i][0], post_pts[i][1], z_sh_top), (post_pts[j][0], post_pts[j][1], z_sh_top),
               (post_pts[j][0], post_pts[j][1], z_post_ch), (post_pts[i][0], post_pts[i][1], z_post_ch))
        # Post chamfer
        m.quad((post_pts[i][0], post_pts[i][1], z_post_ch), (post_pts[j][0], post_pts[j][1], z_post_ch),
               (post_top_pts[j][0], post_top_pts[j][1], z_post_top), (post_top_pts[i][0], post_top_pts[i][1], z_post_top))
        # Post top cap
        m.add((c_x, 0.0, z_post_top), (post_top_pts[i][0], post_top_pts[i][1], z_post_top),
              (post_top_pts[j][0], post_top_pts[j][1], z_post_top))

    # Right: 42mm bore sleeve coupon (50mm OD x 42mm ID x 20mm H)
    outer = [(25.0 * math.cos(2 * math.pi * i / n) + 30.0, 25.0 * math.sin(2 * math.pi * i / n)) for i in range(n)]
    inner = [(21.0 * math.cos(2 * math.pi * i / n) + 30.0, 21.0 * math.sin(2 * math.pi * i / n)) for i in range(n)]
    for i in range(n):
        j = (i + 1) % n
        m.quad((outer[i][0], outer[i][1], 0.0), (inner[i][0], inner[i][1], 0.0),
               (inner[j][0], inner[j][1], 0.0), (outer[j][0], outer[j][1], 0.0))
        m.quad((outer[i][0], outer[i][1], h), (outer[j][0], outer[j][1], h),
               (inner[j][0], inner[j][1], h), (inner[i][0], inner[i][1], h))
        m.quad((outer[i][0], outer[i][1], 0.0), (outer[j][0], outer[j][1], 0.0),
               (outer[j][0], outer[j][1], h), (outer[i][0], outer[i][1], h))
        m.quad((inner[i][0], inner[i][1], 0.0), (inner[i][0], inner[i][1], h),
               (inner[j][0], inner[j][1], h), (inner[j][0], inner[j][1], 0.0))
    return m


def build_bearing_mount_coupon(x_len: float = 20.0, arm_h: float = ARM_HEIGHT,
                               arm_bevel: float = ARM_BEVEL, dual_w: float = DUAL_HEAD_WIDTH,
                               bearing_y: float = BEARING_PAD_Y,
                               bearing_axle_z: float = BEARING_AXLE_LOCAL_Z,
                               standoff_od: float = BEARING_STANDOFF_OD,
                               standoff_len: float = BEARING_STANDOFF_LEN,
                               m5_dia: float = M5_INSERT_DIA,
                               m5_depth: float = M5_INSERT_DEPTH,
                               k: int = 8) -> Mesh:
    """Rapid 10-minute calibration coupon testing 625 bearing fit, standoff boss, and M5 heat-set insert."""
    m = Mesh("circle_cutter_bearing_coupon")
    x_start = 0.0
    x_end = x_len
    h_dual = dual_w / 2.0

    loop_dual = make_beveled_rect_loop(-h_dual, h_dual, 0.0, arm_h, arm_bevel, k)
    bnd_bearing = [loop_dual[idx] for idx in range(12, 29)] + [(0.0, 4.0), (0.0, 8.0)]
    n_p = 19

    # Back cap (-X)
    c_back = (x_start, bearing_y, arm_h / 2.0)
    for i in range(n_p):
        j = (i + 1) % n_p
        m.add(c_back, (x_start, bnd_bearing[j][0], bnd_bearing[j][1]),
                      (x_start, bnd_bearing[i][0], bnd_bearing[i][1]))

    # Outer longitudinal walls
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x_start, bnd_bearing[i][0], bnd_bearing[i][1]),
               (x_start, bnd_bearing[j][0], bnd_bearing[j][1]),
               (x_end, bnd_bearing[j][0], bnd_bearing[j][1]),
               (x_end, bnd_bearing[i][0], bnd_bearing[i][1]))

    # Standoff boss and M5 hole
    boss_c = (bearing_y, bearing_axle_z)
    r_boss = standoff_od / 2.0
    r_m5 = m5_dia / 2.0
    x_boss = x_end + standoff_len
    x_m5_bot = x_boss - m5_depth

    # Polar-matched boss and M5 circles
    circle_boss_base = []
    circle_boss_top = []
    circle_m5 = []
    for p in bnd_bearing:
        ang = math.atan2(p[1] - boss_c[1], p[0] - boss_c[0])
        circle_boss_base.append((boss_c[0] + r_boss * math.cos(ang),
                                 boss_c[1] + r_boss * math.sin(ang)))
        circle_boss_top.append((boss_c[0] + r_boss * math.cos(ang),
                                boss_c[1] + r_boss * math.sin(ang)))
        circle_m5.append((boss_c[0] + r_m5 * math.cos(ang),
                          boss_c[1] + r_m5 * math.sin(ang)))

    # Face around boss (+X)
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x_end, bnd_bearing[i][0], bnd_bearing[i][1]),
               (x_end, bnd_bearing[j][0], bnd_bearing[j][1]),
               (x_end, circle_boss_base[j][0], circle_boss_base[j][1]),
               (x_end, circle_boss_base[i][0], circle_boss_base[i][1]))

    # Boss outer cylinder wall (outward)
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x_end, circle_boss_base[i][0], circle_boss_base[i][1]),
               (x_end, circle_boss_base[j][0], circle_boss_base[j][1]),
               (x_boss, circle_boss_top[j][0], circle_boss_top[j][1]),
               (x_boss, circle_boss_top[i][0], circle_boss_top[i][1]))

    # Boss annular top (+X)
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x_boss, circle_boss_top[i][0], circle_boss_top[i][1]),
               (x_boss, circle_boss_top[j][0], circle_boss_top[j][1]),
               (x_boss, circle_m5[j][0], circle_m5[j][1]),
               (x_boss, circle_m5[i][0], circle_m5[i][1]))

    # M5 hole cylinder wall (inward into hole)
    for i in range(n_p):
        j = (i + 1) % n_p
        m.quad((x_boss, circle_m5[i][0], circle_m5[i][1]),
               (x_boss, circle_m5[j][0], circle_m5[j][1]),
               (x_m5_bot, circle_m5[j][0], circle_m5[j][1]),
               (x_m5_bot, circle_m5[i][0], circle_m5[i][1]))

    # M5 hole bottom cap (+X into hole)
    c_m5_bot = (x_m5_bot, boss_c[0], boss_c[1])
    for i in range(n_p):
        j = (i + 1) % n_p
        m.add(c_m5_bot, (x_m5_bot, circle_m5[i][0], circle_m5[i][1]),
                        (x_m5_bot, circle_m5[j][0], circle_m5[j][1]))

    return m


def build_snap_cap_coupon(x_ring: float = -32.0, x_cap: float = 32.0, h_ring: float = 15.0) -> Mesh:
    """Rapid 18-minute calibration coupon testing Piece 4 snap cap against 15mm hub sleeve ring."""
    m = Mesh("circle_cutter_snap_cap_coupon")
    n_hub = 64
    r_hub_outer = HUB_OUTER_RADIUS
    r_bore = HUB_RECESS_RADIUS
    hub_chamfer = HUB_TOP_CHAMFER
    inner_chamfer = HUB_INNER_CHAMFER

    z_hub_ch = h_ring - hub_chamfer
    r_hub_top = r_hub_outer - hub_chamfer

    bore_profile = [
        (r_bore, 0.0),
        (r_bore, 10.5),
        (r_bore + HUB_GROOVE_DEPTH, 11.3),
        (r_bore + HUB_GROOVE_DEPTH, 12.5),
        (r_bore, 13.3),
        (r_bore, 14.0),
        (r_bore + inner_chamfer, h_ring),
    ]
    outer_profile = [
        (r_hub_outer, 0.0),
        (r_hub_outer, z_hub_ch),
        (r_hub_top, h_ring),
    ]

    # 1. Hub Sleeve Test Ring at x_ring
    # Bottom annular face
    for i in range(n_hub):
        j = (i + 1) % n_hub
        ai, aj = 2 * math.pi * i / n_hub, 2 * math.pi * j / n_hub
        p_out_i = (x_ring + r_hub_outer * math.cos(ai), r_hub_outer * math.sin(ai), 0.0)
        p_out_j = (x_ring + r_hub_outer * math.cos(aj), r_hub_outer * math.sin(aj), 0.0)
        p_in_i = (x_ring + r_bore * math.cos(ai), r_bore * math.sin(ai), 0.0)
        p_in_j = (x_ring + r_bore * math.cos(aj), r_bore * math.sin(aj), 0.0)
        m.quad(p_out_i, p_in_i, p_in_j, p_out_j)

    # Top annular face
    r_in_top = bore_profile[-1][0]
    r_out_top = outer_profile[-1][0]
    for i in range(n_hub):
        j = (i + 1) % n_hub
        ai, aj = 2 * math.pi * i / n_hub, 2 * math.pi * j / n_hub
        p_out_i = (x_ring + r_out_top * math.cos(ai), r_out_top * math.sin(ai), h_ring)
        p_out_j = (x_ring + r_out_top * math.cos(aj), r_out_top * math.sin(aj), h_ring)
        p_in_i = (x_ring + r_in_top * math.cos(ai), r_in_top * math.sin(ai), h_ring)
        p_in_j = (x_ring + r_in_top * math.cos(aj), r_in_top * math.sin(aj), h_ring)
        m.quad(p_out_i, p_out_j, p_in_j, p_in_i)

    # Outer walls
    for s in range(len(outer_profile) - 1):
        r1, z1 = outer_profile[s]
        r2, z2 = outer_profile[s + 1]
        for i in range(n_hub):
            j = (i + 1) % n_hub
            ai, aj = 2 * math.pi * i / n_hub, 2 * math.pi * j / n_hub
            p1_i = (x_ring + r1 * math.cos(ai), r1 * math.sin(ai), z1)
            p1_j = (x_ring + r1 * math.cos(aj), r1 * math.sin(aj), z1)
            p2_j = (x_ring + r2 * math.cos(aj), r2 * math.sin(aj), z2)
            p2_i = (x_ring + r2 * math.cos(ai), r2 * math.sin(ai), z2)
            m.quad(p1_i, p1_j, p2_j, p2_i)

    # Inner bore walls
    for s in range(len(bore_profile) - 1):
        r1, z1 = bore_profile[s]
        r2, z2 = bore_profile[s + 1]
        for i in range(n_hub):
            j = (i + 1) % n_hub
            ai, aj = 2 * math.pi * i / n_hub, 2 * math.pi * j / n_hub
            p1_i = (x_ring + r1 * math.cos(ai), r1 * math.sin(ai), z1)
            p2_i = (x_ring + r2 * math.cos(ai), r2 * math.sin(ai), z2)
            p2_j = (x_ring + r2 * math.cos(aj), r2 * math.sin(aj), z2)
            p1_j = (x_ring + r1 * math.cos(aj), r1 * math.sin(aj), z1)
            m.quad(p1_i, p2_i, p2_j, p1_j)

    # 2. Add Cap at x_cap
    cap_mesh = build_piece4_hub_cap()
    for t in cap_mesh.triangles:
        t_shifted = (
            (t[0][0] + x_cap, t[0][1], t[0][2]),
            (t[1][0] + x_cap, t[1][1], t[1][2]),
            (t[2][0] + x_cap, t[2][1], t[2][2]),
        )
        m.triangles.append(t_shifted)

    return m


# =============================================================================
# HEADLESS LOOKAT 3D RENDERER
# =============================================================================

def render_multiview_sheet(stl_path: Path, out_path: Path, title: str = "", subtitle: str = "") -> None:
    try:
        import numpy as np
        from PIL import Image, ImageDraw
    except ImportError:
        return

    with stl_path.open("rb") as f:
        f.read(80)
        n_tris = struct.unpack("<I", f.read(4))[0]
        data = f.read()

    dt = np.dtype([
        ("normal", np.float32, (3,)),
        ("v0", np.float32, (3,)),
        ("v1", np.float32, (3,)),
        ("v2", np.float32, (3,)),
        ("attr", np.uint16, (1,)),
    ])
    arr = np.frombuffer(data, dtype=dt, count=n_tris)
    verts = np.stack([arr["v0"], arr["v1"], arr["v2"]], axis=1)

    min_pt = np.min(verts, axis=(0, 1))
    max_pt = np.max(verts, axis=(0, 1))
    center = (min_pt + max_pt) / 2.0
    v_centered = verts - center
    max_dim = max(float(np.max(max_pt - min_pt)), 1.0)

    w, h = 600, 450
    scale = (w * 0.38) / max_dim

    def look_at(eye: np.ndarray, target: np.ndarray, up: np.ndarray) -> np.ndarray:
        fwd = target - eye
        fwd = fwd / np.linalg.norm(fwd)
        rt = np.cross(fwd, up)
        norm_rt = np.linalg.norm(rt)
        rt = np.array([1.0, 0.0, 0.0]) if norm_rt < 1e-6 else rt / norm_rt
        act_up = np.cross(rt, fwd)
        mat = np.eye(4, dtype=np.float32)
        mat[0, :3] = rt
        mat[1, :3] = act_up
        mat[2, :3] = -fwd
        mat[:3, 3] = -mat[:3, :3] @ eye
        return mat

    def render_view(view_mat: np.ndarray, color=(56, 140, 220)) -> Image.Image:
        v_hom = np.pad(v_centered, ((0, 0), (0, 0), (0, 1)), constant_values=1.0)
        v_trans = (v_hom @ view_mat.T)[:, :, :3]
        sx = w / 2.0 + v_trans[:, :, 0] * scale
        sy = h / 2.0 - v_trans[:, :, 1] * scale
        dz = v_trans[:, :, 2]

        v0, v1, v2 = v_centered[:, 0, :], v_centered[:, 1, :], v_centered[:, 2, :]
        norms = np.cross(v1 - v0, v2 - v0)
        n_len = np.linalg.norm(norms, axis=1, keepdims=True)
        norms = np.divide(norms, n_len, out=np.zeros_like(norms), where=n_len > 1e-6)

        cam_norms = norms @ view_mat[:3, :3].T
        front = (cam_norms @ np.array([0, 0, 1], dtype=np.float32)) < 0.05

        img = np.full((h, w, 3), 255, dtype=np.uint8)
        zbuf = np.full((h, w), np.inf, dtype=np.float32)
        col = np.array(color, dtype=np.float32)

        key_l = np.array([-0.577, 0.577, 0.577], dtype=np.float32)
        fill_l = np.array([0.707, 0.707, 0.0], dtype=np.float32)
        dot1 = np.maximum(0, -np.sum(norms * key_l, axis=1))
        dot2 = np.maximum(0, -np.sum(norms * fill_l, axis=1))
        intensity = np.clip(0.40 + 0.45 * dot1 + 0.15 * dot2, 0.25, 1.0)

        indices = np.where(front)[0]
        for idx in indices:
            x0, x1, x2 = sx[idx]
            y0, y1, y2 = sy[idx]
            z0, z1, z2 = dz[idx]
            min_x = max(0, int(np.floor(min(x0, x1, x2))))
            max_x = min(w - 1, int(np.ceil(max(x0, x1, x2))))
            min_y = max(0, int(np.floor(min(y0, y1, y2))))
            max_y = min(h - 1, int(np.ceil(max(y0, y1, y2))))
            if min_x > max_x or min_y > max_y:
                continue
            denom = (y1 - y2) * (x0 - x2) + (x2 - x1) * (y0 - y2)
            if abs(denom) < 1e-6:
                continue
            px, py = np.meshgrid(np.arange(min_x, max_x + 1), np.arange(min_y, max_y + 1))
            w0 = ((y1 - y2) * (px - x2) + (x2 - x1) * (py - y2)) / denom
            w1 = ((y2 - y0) * (px - x2) + (x0 - x2) * (py - y2)) / denom
            w2 = 1.0 - w0 - w1
            mask = (w0 >= 0) & (w1 >= 0) & (w2 >= 0)
            if not np.any(mask):
                continue
            pz = w0 * z0 + w1 * z1 + w2 * z2
            z_mask = mask & (pz < zbuf[min_y:max_y + 1, min_x:max_x + 1])
            if np.any(z_mask):
                zbuf[min_y:max_y + 1, min_x:max_x + 1][z_mask] = pz[z_mask]
                tri_col = (col * intensity[idx]).astype(np.uint8)
                img[min_y:max_y + 1, min_x:max_x + 1][z_mask] = tri_col

        return Image.fromarray(img)

    iso_m = look_at(np.array([1.2, -1.2, 1.2]), np.array([0.0, 0.0, 0.0]), np.array([0.0, 0.0, 1.0]))
    top_m = look_at(np.array([0.0, 0.0, 2.0]), np.array([0.0, 0.0, 0.0]), np.array([0.0, 1.0, 0.0]))
    frt_m = look_at(np.array([0.0, -2.0, 0.0]), np.array([0.0, 0.0, 0.0]), np.array([0.0, 0.0, 1.0]))
    rgt_m = look_at(np.array([2.0, 0.0, 0.0]), np.array([0.0, 0.0, 0.0]), np.array([0.0, 0.0, 1.0]))

    img_iso = render_view(iso_m, color=(50, 130, 210))
    img_top = render_view(top_m, color=(70, 160, 180))
    img_frt = render_view(frt_m, color=(80, 140, 200))
    img_rgt = render_view(rgt_m, color=(90, 150, 220))

    canvas = Image.new("RGB", (1200, 900), (250, 250, 252))
    canvas.paste(img_iso, (0, 0))
    canvas.paste(img_top, (600, 0))
    canvas.paste(img_frt, (0, 450))
    canvas.paste(img_rgt, (600, 450))

    draw = ImageDraw.Draw(canvas)
    draw.text((25, 20), title or stl_path.name, fill=(20, 30, 45))
    draw.text((25, 40), subtitle or f"Dimensions: {max_pt[0]-min_pt[0]:.1f} x {max_pt[1]-min_pt[1]:.1f} x {max_pt[2]-min_pt[2]:.1f} mm", fill=(90, 105, 120))
    draw.text((25, 65), "Isometric 3D View", fill=(40, 60, 80))
    draw.text((625, 65), "Top Plan View (XY)", fill=(40, 60, 80))
    draw.text((25, 475), "Front Elevation View (XZ)", fill=(40, 60, 80))
    draw.text((625, 475), "Right Elevation View (YZ)", fill=(40, 60, 80))

    out_path.parent.mkdir(parents=True, exist_ok=True)
    canvas.save(out_path)
    print(f"  [Rendered] {out_path.name}")


def render_assembly_views(out_dir: Path, base: Mesh, arm: Mesh, blade_cap: Mesh, hub_cap: Mesh) -> None:
    """Render full assembly and exploded 3D scene views directly in pure Python."""
    try:
        import numpy as np
        from PIL import Image, ImageDraw
    except ImportError:
        return

    root_dir = Path(__file__).resolve().parent

    def mesh_to_verts(m: Mesh, offset=(0.0, 0.0, 0.0)) -> np.ndarray:
        dx, dy, dz = offset
        tris = [[(p[0] + dx, p[1] + dy, p[2] + dz) for p in t] for t in m.triangles]
        return np.array(tris, dtype=np.float32)

    def render_scene(components: List[Tuple[np.ndarray, Tuple[int, int, int]]], out_path: Path, title: str, subtitle: str) -> None:
        all_verts = np.concatenate([c[0] for c in components], axis=0)
        min_pt = np.min(all_verts, axis=(0, 1))
        max_pt = np.max(all_verts, axis=(0, 1))
        center = (min_pt + max_pt) / 2.0
        max_dim = max(float(np.max(max_pt - min_pt)), 1.0)

        w, h = 1200, 900
        scale = (w * 0.46) / max_dim

        def look_at(eye: np.ndarray, target: np.ndarray, up: np.ndarray) -> np.ndarray:
            fwd = target - eye
            fwd = fwd / np.linalg.norm(fwd)
            rt = np.cross(fwd, up)
            norm_rt = np.linalg.norm(rt)
            rt = np.array([1.0, 0.0, 0.0]) if norm_rt < 1e-6 else rt / norm_rt
            act_up = np.cross(rt, fwd)
            mat = np.eye(4, dtype=np.float32)
            mat[0, :3] = rt
            mat[1, :3] = act_up
            mat[2, :3] = -fwd
            mat[:3, 3] = -mat[:3, :3] @ eye
            return mat

        view_mat = look_at(np.array([1.5, -1.4, 1.2]), np.array([0.0, 0.0, 0.0]), np.array([0.0, 0.0, 1.0]))

        img = np.full((h, w, 3), 252, dtype=np.uint8)
        zbuf = np.full((h, w), np.inf, dtype=np.float32)

        key_l = np.array([-0.577, 0.577, 0.577], dtype=np.float32)
        fill_l = np.array([0.707, 0.707, 0.0], dtype=np.float32)

        for verts_raw, col_rgb in components:
            v_centered = verts_raw - center
            v_hom = np.pad(v_centered, ((0, 0), (0, 0), (0, 1)), constant_values=1.0)
            v_trans = (v_hom @ view_mat.T)[:, :, :3]
            sx = w / 2.0 + v_trans[:, :, 0] * scale
            sy = h / 2.0 - v_trans[:, :, 1] * scale
            dz = v_trans[:, :, 2]

            v0, v1, v2 = v_centered[:, 0, :], v_centered[:, 1, :], v_centered[:, 2, :]
            norms = np.cross(v1 - v0, v2 - v0)
            n_len = np.linalg.norm(norms, axis=1, keepdims=True)
            norms = np.divide(norms, n_len, out=np.zeros_like(norms), where=n_len > 1e-6)

            cam_norms = norms @ view_mat[:3, :3].T
            front = (cam_norms @ np.array([0, 0, 1], dtype=np.float32)) < 0.05

            col = np.array(col_rgb, dtype=np.float32)
            dot1 = np.maximum(0, -np.sum(norms * key_l, axis=1))
            dot2 = np.maximum(0, -np.sum(norms * fill_l, axis=1))
            intensity = np.clip(0.38 + 0.48 * dot1 + 0.14 * dot2, 0.20, 1.0)

            indices = np.where(front)[0]
            for idx in indices:
                x0, x1, x2 = sx[idx]
                y0, y1, y2 = sy[idx]
                z0, z1, z2 = dz[idx]
                min_x = max(0, int(np.floor(min(x0, x1, x2))))
                max_x = min(w - 1, int(np.ceil(max(x0, x1, x2))))
                min_y = max(0, int(np.floor(min(y0, y1, y2))))
                max_y = min(h - 1, int(np.ceil(max(y0, y1, y2))))
                if min_x > max_x or min_y > max_y:
                    continue
                denom = (y1 - y2) * (x0 - x2) + (x2 - x1) * (y0 - y2)
                if abs(denom) < 1e-6:
                    continue
                px, py = np.meshgrid(np.arange(min_x, max_x + 1), np.arange(min_y, max_y + 1))
                w0 = ((y1 - y2) * (px - x2) + (x2 - x1) * (py - y2)) / denom
                w1 = ((y2 - y0) * (px - x2) + (x0 - x2) * (py - y2)) / denom
                w2 = 1.0 - w0 - w1
                mask = (w0 >= 0) & (w1 >= 0) & (w2 >= 0)
                if not np.any(mask):
                    continue
                pz = w0 * z0 + w1 * z1 + w2 * z2
                z_mask = mask & (pz < zbuf[min_y:max_y + 1, min_x:max_x + 1])
                if np.any(z_mask):
                    zbuf[min_y:max_y + 1, min_x:max_x + 1][z_mask] = pz[z_mask]
                    tri_col = (col * intensity[idx]).astype(np.uint8)
                    img[min_y:max_y + 1, min_x:max_x + 1][z_mask] = tri_col

        canvas = Image.fromarray(img)
        draw = ImageDraw.Draw(canvas)
        draw.text((30, 25), title, fill=(20, 30, 45))
        draw.text((30, 50), subtitle, fill=(90, 105, 120))
        canvas.save(out_path)
        canvas.save(root_dir / out_path.name)
        print(f"  [Rendered Scene] {out_path.name}")

    col_base = (70, 130, 180)     # Steel Blue
    col_arm = (230, 120, 30)      # Dark Orange
    col_cap = (80, 90, 100)       # Slate Gray
    col_hub = (46, 139, 87)       # Sea Green

    # Assembly Scene
    scene_assembly = [
        (mesh_to_verts(base, (0.0, 0.0, 0.0)), col_base),
        (mesh_to_verts(arm, (0.0, 0.0, 4.0)), col_arm),
        (mesh_to_verts(blade_cap, (176.3, 0.0, 4.0)), col_cap),
        (mesh_to_verts(hub_cap, (0.0, 0.0, 112.0)), col_hub),
    ]
    render_scene(scene_assembly, out_dir / "circle_cutter_assembly.png",
                 "PCHSMB Circle Cutter — Full Assembly (v1.4 with 608 Bearing Pivot)",
                 "Piece 1 (Base, Blue) | Piece 2 (Arm, Orange) | Piece 3 (Clamp, Gray) | Piece 4 (Hub Cap, Green)")

    # Exploded Scene
    scene_exploded = [
        (mesh_to_verts(base, (0.0, 0.0, 0.0)), col_base),
        (mesh_to_verts(arm, (0.0, 0.0, 45.0)), col_arm),
        (mesh_to_verts(blade_cap, (210.0, 0.0, 45.0)), col_cap),
        (mesh_to_verts(hub_cap, (0.0, 0.0, 195.0)), col_hub),
    ]
    render_scene(scene_exploded, out_dir / "circle_cutter_exploded.png",
                 "PCHSMB Circle Cutter — Exploded Alignment View (v1.4)",
                 "Vertical Stackup: Base (Z=0) -> Arm (+45mm) -> Hub Cap (+150mm) | Distal Clamp (+35mm X)")



# =============================================================================
# MANIFEST BUILDER
# =============================================================================

def generate_manifest(out_dir: Path, meshes: List[Mesh]) -> dict:
    audits = {f"{m.name}.stl": m.audit() for m in meshes}
    total_est_mass = sum(a["estimated_mass_petg_g"] for a in audits.values())
    manifest = {
        "design": DESIGN_NAME,
        "version": VERSION,
        "units": "mm",
        "standard": "Pine Creek High School Marching Band Field Prop Tooling",
        "print_material_recommended": MATERIAL,
        "print_density_g_cm3": PETG_DENSITY_G_CM3,
        "estimated_total_print_mass_petg_g": round(total_est_mass, 1),
        "print_quantities": {
            "circle_cutter_base.stl": 1,
            "circle_cutter_arm.stl": 1,
            "circle_cutter_blade_cap.stl": 1,
            "circle_cutter_hub_cap.stl": 1,
            "circle_cutter_spindle_bore_coupon.stl": 0,
            "circle_cutter_bearing_coupon.stl": 0,
            "circle_cutter_snap_cap_coupon.stl": 0,
        },
        "vertical_stackup_and_clearances": {
            "vinyl_surface_world_z_mm": VINYL_Z,
            "bearing_bottom_world_z_mm": VINYL_Z,
            "blade_tip_world_z_mm": BLADE_TIP_WORLD_Z,
            "controlled_cut_depth_mm": CUT_DEPTH,
            "base_plate_thickness_mm": BASE_PLATE_HEIGHT,
            "arm_bottom_world_z_mm": ARM_BOTTOM_WORLD_Z,
            "arm_to_base_plate_air_gap_mm": ARM_AIR_GAP,
            "arm_air_clearance_above_vinyl_mm": ARM_BOTTOM_WORLD_Z,
            "bearing_axle_world_z_mm": BEARING_AXLE_WORLD_Z,
            "bearing_axle_local_z_mm": BEARING_AXLE_LOCAL_Z,
            "self_leveling_bridge": "Base plate and 625 bearing both contact vinyl simultaneously, holding arm dead-level with 4.0mm air gap above vinyl",
            "friction_elimination": "Arm floats 1.0mm above base plate shoulder, reducing plastic sliding contact area from 707mm2 to 0mm2",
        },
        "bearing_specifications_625_roller": {
            "bearing_type": "625 Ball Bearing (625ZZ / 625-2RS)",
            "purpose": "Distal roller depth stop rolling directly on vinyl",
            "outer_diameter_mm": BEARING_OD,
            "inner_bore_mm": BEARING_ID,
            "width_mm": BEARING_WIDTH,
            "standoff_boss_od_mm": BEARING_STANDOFF_OD,
            "standoff_boss_length_mm": BEARING_STANDOFF_LEN,
            "axle_fastener": "M5 button-head machine screw into M5 brass heat-set insert",
            "rotation_axis_alignment": "Radial (+X), parallel to arm length; rolls along tangential cut arc (+Y) alongside blade",
            "head_architecture": "Side-by-Side Dual Head (Bearing Pad at Y=-9mm, Blade Pad at Y=+9mm)",
        },
        "bearing_specifications_608_thrust": {
            "bearing_type": "608 Ball Bearing (608ZZ / 608-2RS)",
            "purpose": "Top-mounted axial thrust pivot carrying 100% of operator downward pressure",
            "outer_diameter_mm": BEARING_608_OD,
            "inner_bore_mm": BEARING_608_ID,
            "width_mm": BEARING_608_WIDTH,
            "inner_race_shoulder_dia_mm": BEARING_608_INNER_SHOULDER_DIA,
            "inner_race_shoulder_height_mm": BEARING_608_INNER_SHOULDER_HEIGHT,
            "spindle_post_dia_mm": BEARING_608_POST_DIA,
            "spindle_post_height_mm": BEARING_608_POST_HEIGHT,
            "hub_cap_pocket_dia_mm": BEARING_608_POCKET_DIA,
            "hub_cap_relief_dia_mm": BEARING_608_RELIEF_DIA,
            "contact_isolation": "Piece 1 seats inner race only; Piece 4 drives outer race only; shields and post relieved with >1.5mm air gap",
        },
        "hub_architecture": {
            "type": "Modular 4-Piece Open Through-Bore with Snap-in Cap & 608 Bearing Pocket",
            "hub_bore_dia_mm": HUB_RECESS_DIA,
            "internal_retention_groove_dia_mm": round(HUB_RECESS_DIA + 2 * HUB_GROOVE_DEPTH, 2),
            "internal_retention_groove_z_mm": [HUB_GROOVE_Z_START, HUB_GROOVE_Z_END],
            "cap_flange_dia_mm": HUB_CAP_FLANGE_DIA,
            "cap_flange_thickness_mm": HUB_CAP_FLANGE_THICKNESS,
            "cap_flex_fingers": HUB_CAP_NUM_FINGERS,
            "cap_retention_barb_dia_mm": HUB_CAP_BARB_DIA,
            "support_free_status": "100% support-free upright printing with arm on build plate",
        },
        "files": audits,
        "mesh_audit_summary": {
            "all_files_passed_topological_audit": all(a["passed"] for a in audits.values()),
            "total_triangles": sum(a["triangles"] for a in audits.values()),
        },
        "status": "production_release_v1_4_608_bearing_pivot",
    }
    (out_dir / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    return manifest


# =============================================================================
# CLI PIPELINE
# =============================================================================

def main() -> None:
    parser = argparse.ArgumentParser(description="Generate PCHSMB Circle Cutter STL files and manifests.")
    parser.add_argument("--out", type=Path, default=Path(__file__).resolve().parent / "build",
                        help="Output directory (default: ./build)")
    parser.add_argument("--no-render", action="store_true", help="Skip headless LookAt PNG rendering")
    parser.add_argument("--coupons", action="store_true", default=True, help="Also generate calibration coupons")
    args = parser.parse_args()

    out_dir = args.out
    out_dir.mkdir(parents=True, exist_ok=True)

    print("=" * 72)
    print("  PCHSMB Circle Cutter - Pure-Python STL Generation Pipeline v1.4")
    print("  Feature: Top-Mounted 608 Ball Bearing Thrust Pivot for Low-Friction Operation")
    print(f"  Target: {out_dir.resolve()}")
    print("=" * 72)

    # 1. Build 4 Production Components
    print("\n[1/4] Generating Production 4-Piece Geometry (Pure Python)...")
    base = build_piece1_base()
    arm = build_piece2_arm()
    blade_cap = build_piece3_blade_cap()
    hub_cap = build_piece4_hub_cap()

    meshes = [base, arm, blade_cap, hub_cap]

    # 2. Build Calibration Test Coupons
    if args.coupons:
        print("  Generating rapid calibration test coupons...")
        coupon_fit = build_spindle_bore_coupon()
        coupon_bearing = build_bearing_mount_coupon()
        coupon_snap = build_snap_cap_coupon()
        meshes.extend([coupon_fit, coupon_bearing, coupon_snap])

    # 3. Save STLs & Audit
    print("\n[2/4] Saving Binary STLs and Enforcing Topological Quality Gates...")
    for m in meshes:
        stl_path = out_dir / f"{m.name}.stl"
        m.save_stl(stl_path)
        audit = m.audit()
        status_sym = "[PASS]" if audit["passed"] else "[FAIL]"
        print(f"  {status_sym} {m.name}.stl: {audit['triangles']} tris, "
              f"{audit['boundary_edges']} boundary, {audit['nonmanifold_edges']} non-manifold, "
              f"{audit['dimensions']} mm, {audit['volume_cm3']} cm3 (~{audit['estimated_mass_petg_g']}g PETG)")
        if not audit["passed"]:
            print(f"  ERROR: Mesh {m.name}.stl failed quality gate!", file=sys.stderr)
            sys.exit(1)

    # Copy primary STLs to root
    root_dir = Path(__file__).resolve().parent
    for m in [base, arm, blade_cap, hub_cap]:
        m.save_stl(root_dir / f"{m.name}.stl")

    # 4. Generate Manifest
    print("\n[3/4] Generating Machine-Readable Manifest (manifest.json)...")
    generate_manifest(out_dir, meshes)
    print(f"  Saved {out_dir / 'manifest.json'}")

    # 5. Headless Rendering
    if not args.no_render:
        print("\n[4/4] Generating Headless 3D Multi-View Sheets & Assembly Scenes (LookAt Engine)...")
        for m in meshes:
            stl_p = out_dir / f"{m.name}.stl"
            png_p = out_dir / f"{m.name}_multiview.png"
            render_multiview_sheet(stl_p, png_p, title=f"PCHSMB Circle Cutter — {m.name}")

        print("  Generating 3D Assembly and Exploded Scene Renders (Pure Python)...")
        render_assembly_views(out_dir, base, arm, blade_cap, hub_cap)

    print("\n" + "=" * 72)
    print("  Generation Complete! All STLs verified 100% watertight manifold.")
    print("=" * 72)


if __name__ == "__main__":
    main()
