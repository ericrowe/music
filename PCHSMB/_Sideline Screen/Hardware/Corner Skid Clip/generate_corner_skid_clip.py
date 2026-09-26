#!/usr/bin/env python3
"""
PCHSMB Duck Blind Corner Skid Clip - Pure-Python Parametric CAD Generator
=========================================================================
Subproject: PCHSMB Sideline Screen / Duck Blind (PCHSMB/_Sideline Screen)
Author: Antigravity Agentic Assistant / PCHSMB Engineering
Repository: ericrowe/music (AGENTS.md Section 3 & 5 Compliance)

Physical Function:
  Snaps over the bottom ground rail (3/4" EMT Conduit Rail A) of the Duck Blind
  and extends over the 3-Way Corner Elbow Clamp Bracket (Bracket F, Amazon B0D5BBKCKG).
  Provides a heavy sacrificial plastic glide runner with ski-tip lead-in ramps that
  drags on synthetic turf and asphalt BEFORE the wrapped 13oz scrim vinyl contacts
  the ground, completely eliminating ground-rubbing corner vinyl abrasion and tear.

Engineering Invariants:
  1. Authoritative Pipeline: Sole CAD engine and rendering pipeline. No external CAD
     binaries (OpenSCAD, FreeCAD) queried or invoked.
  2. Zero-Support FDM Printing: Sits completely flat on its sacrificial bottom runner.
     Forms an open upward trough with all sidewall overhangs <= 25° from vertical (65° from bed).
     Prints 100% support-free in Black ASA or PETG.
  3. Clean Top Edge: Completely open U-trough across the top from X = 0 to 140 mm.
     Zero roof or top bridging material, ensuring 100% unobstructed clearance for
     the vertical conduit (Rail B) and corner bracket collar.
  4. Anti-Tear Inside Bevels: Generous 45° internal lead-in bevel on the snap lips (mouth width 25.6 mm)
     and 1.5 mm axial entry chamfer at X = 0 prevent gouging or tearing wrapped vinyl.
  5. Expanded Bracket Cavity: 85 mm Zone 2 shroud length (95 mm total pocket length) and
     37.0 mm inner width easily accommodate the 70 mm bracket sleeve, multi-layer bunched
     corner vinyl folds, and clamping bolt heads.
  6. 4-Gate Topological Verification: 0 boundary edges, 0 non-manifold edges, 0 degenerate
     triangles, all finite coordinates.
"""

import math
import os
import struct
import sys
from pathlib import Path
from typing import List, Tuple, Dict, Any
import numpy as np
from PIL import Image, ImageDraw

# =============================================================================
# 1. PARAMETRIC CONSTANTS & PHYSICAL INTERFACES
# =============================================================================

# 3/4" EMT Conduit & Vinyl Specifications
CONDUIT_34_OD = 23.42                         # 0.922 in. (23.4188 mm) nominal outer diameter
CONDUIT_34_RADIUS = CONDUIT_34_OD / 2.0       # 11.71 mm radius
VINYL_THICKNESS = 0.38                        # 13 oz scrim vinyl nominal thickness
WRAPPED_CONDUIT_OD = CONDUIT_34_OD + 2 * VINYL_THICKNESS  # ~24.18 mm

# Bracket F (3-Way EMT Clamp Bracket - Amazon B0D5BBKCKG)
BRACKET_F_SHELL_THICKNESS = 1.80              # Stamped steel clamp wall thickness
BRACKET_F_OD = CONDUIT_34_OD + 2 * BRACKET_F_SHELL_THICKNESS  # ~27.02 - 27.5 mm OD
BRACKET_F_RADIUS = BRACKET_F_OD / 2.0         # ~13.51 mm radius
BRACKET_F_SLEEVE_LEN = 70.0                   # Nominal bracket sleeve length along Rail A from corner

# Clip Zone 1: Conduit Snap Section
SNAP_INNER_DIA = 24.50                        # 24.50 mm ID (fits 24.18mm wrapped conduit + 0.32mm clearance)
SNAP_INNER_RADIUS = SNAP_INNER_DIA / 2.0      # 12.25 mm radius
WALL_THICKNESS = 3.00                         # 3.00 mm structural spring wall
ZONE1_SNAP_LEN = 45.0                         # 45.0 mm length of straight conduit grip
ZONE1_TOP_Z = 4.50                            # Clean horizontal top lip height in Zone 1

# Clip Zone 2: Over-Bracket Corner Shroud (Extra Length & Width for Bunched Vinyl)
CORNER_INNER_DIA = 37.00                      # 37.00 mm ID (+9.8 mm clearance over 27.2 mm bracket)
CORNER_INNER_RADIUS = CORNER_INNER_DIA / 2.0  # 18.50 mm radius
ZONE2_CORNER_LEN = 85.0                       # 85.0 mm axial length (easily covers 70 mm bracket)
ZONE2_TOP_Z = 2.00                            # Lower top lip height (100% open clearance for vertical Rail B)
TRANSITION_TAPER_LEN = 5.0                    # 5.0 mm 45° internal locating stop shoulder

# Corner Apex Bumper & End Section
END_WALL_THICKNESS = 5.0                      # 5.0 mm outer corner bumper section
TOTAL_CLIP_LEN = ZONE1_SNAP_LEN + TRANSITION_TAPER_LEN + ZONE2_CORNER_LEN + END_WALL_THICKNESS  # 140.0 mm

# Sacrificial Ground Skid Runner (The Raised Section)
# Ground is located at -Z. Conduit center is at Z=0.
# Conduit bottom is at Z = -11.71mm. Bracket F bottom is at Z = -13.51mm.
SKID_GROUND_Z = -19.50                        # -19.50 mm local Z (5.99mm proud of Bracket F, 7.79mm proud of conduit!)
SKID_FLAT_HALF_WIDTH = 9.0                    # 18.0 mm total flat glide runner width (Y in [-9.0, +9.0])
SKID_RUNNER_BEVEL_LEN = 12.0                  # 12.0 mm ski-tip lead-in ramp at inner end (X in [0, 12.0])
SKID_RAMP_HEIGHT = 3.50                       # 3.50 mm upward ramp height at ski tip

# Anti-Tear Lead-in Bevels
ENTRY_BEVEL_DEPTH = 1.50                      # 1.5 mm 45° lead-in bevel on inside mouth of Zone 1
INNER_RIM_CHAMFER = 1.50                      # 1.5 mm 45° circular entry chamfer at X = 0

# 3D Printing & Physical Material Properties
DENSITY_PETG = 1.27                           # g/cm3 for PETG
DENSITY_ASA = 1.07                            # g/cm3 for Black ASA (recommended field material)
NOMINAL_INFILL_RATIO = 0.40                   # 40% gyroid infill + 5 perimeters

# =============================================================================
# 2. MESH DATA STRUCTURES & 4-GATE TOPOLOGICAL AUDITOR
# =============================================================================

Vec3 = Tuple[float, float, float]
Vec2 = Tuple[float, float]
Tri = Tuple[Vec3, Vec3, Vec3]


def _sub(a: Vec3, b: Vec3) -> Vec3:
    return (a[0] - b[0], a[1] - b[1], a[2] - b[2])


def _add(a: Vec3, b: Vec3) -> Vec3:
    return (a[0] + b[0], a[1] + b[1], a[2] + b[2])


def _cross(a: Vec3, b: Vec3) -> Vec3:
    return (
        a[1] * b[2] - a[2] * b[1],
        a[2] * b[0] - a[0] * b[2],
        a[0] * b[1] - a[1] * b[0],
    )


def _dot(a: Vec3, b: Vec3) -> float:
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2]


def _norm(v: Vec3) -> float:
    return math.sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2])


def _normal(t: Tri) -> Vec3:
    u = _sub(t[1], t[0])
    v = _sub(t[2], t[0])
    cp = _cross(u, v)
    mag = _norm(cp)
    if mag == 0.0:
        return (0.0, 0.0, 1.0)
    return (cp[0] / mag, cp[1] / mag, cp[2] / mag)


class Mesh:
    """Watertight triangular boundary representation with Euler-Poincaré topological auditor."""

    def __init__(self, name: str):
        self.name = name
        self.triangles: List[Tri] = []

    def add(self, a: Vec3, b: Vec3, c: Vec3) -> None:
        self.triangles.append((a, b, c))

    def quad(self, a: Vec3, b: Vec3, c: Vec3, d: Vec3) -> None:
        """Adds a quad as two counter-clockwise outward-facing triangles: (a, b, c) and (a, c, d)."""
        self.add(a, b, c)
        self.add(a, c, d)

    def bounds(self) -> Tuple[Vec3, Vec3]:
        xs = [p[0] for t in self.triangles for p in t]
        ys = [p[1] for t in self.triangles for p in t]
        zs = [p[2] for t in self.triangles for p in t]
        return (min(xs), min(ys), min(zs)), (max(xs), max(ys), max(zs))

    def signed_volume(self) -> float:
        """Computes exact volumetric integral via divergence theorem."""
        vol = 0.0
        for p1, p2, p3 in self.triangles:
            v321 = p3[0] * p2[1] * p1[2]
            v231 = p2[0] * p3[1] * p1[2]
            v312 = p3[0] * p1[1] * p2[2]
            v132 = p1[0] * p3[1] * p2[2]
            v213 = p2[0] * p1[1] * p3[2]
            v123 = p1[0] * p2[1] * p3[2]
            vol += (-v321 + v231 + v312 - v132 - v213 + v123) / 6.0
        return vol

    def audit(self) -> Dict[str, Any]:
        """4-Gate Topological Auditor (Gate 1: Manifold, Gate 2: Boundary, Gate 3: Degen, Gate 4: Finite)."""
        edge_counts: Dict[Tuple[Tuple[float, float, float], Tuple[float, float, float]], int] = {}
        degen = 0
        finite = True

        for t in self.triangles:
            for p in t:
                for coord in p:
                    if not math.isfinite(coord):
                        finite = False

            u = _sub(t[1], t[0])
            v = _sub(t[2], t[0])
            if _norm(_cross(u, v)) < 1e-7:
                degen += 1

            for i in range(3):
                p0 = t[i]
                p1 = t[(i + 1) % 3]

                def key_pt(pt: Vec3) -> Tuple[float, float, float]:
                    return (round(pt[0], 4), round(pt[1], 4), round(pt[2], 4))

                e_undir = tuple(sorted([key_pt(p0), key_pt(p1)]))
                edge_counts[e_undir] = edge_counts.get(e_undir, 0) + 1

        boundary_edges = sum(1 for c in edge_counts.values() if c == 1)
        nonmanifold_edges = sum(1 for c in edge_counts.values() if c > 2)
        b_min, b_max = self.bounds()
        vol = abs(self.signed_volume()) / 1000.0  # cm3
        mass_petg = vol * DENSITY_PETG * (0.35 + 0.65 * NOMINAL_INFILL_RATIO)
        mass_asa = vol * DENSITY_ASA * (0.35 + 0.65 * NOMINAL_INFILL_RATIO)

        passed = (boundary_edges == 0) and (nonmanifold_edges == 0) and (degen == 0) and finite
        return {
            "triangles": len(self.triangles),
            "boundary_edges": boundary_edges,
            "nonmanifold_edges": nonmanifold_edges,
            "degenerate_triangles": degen,
            "finite_coordinates": finite,
            "bounds_min": [round(x, 2) for x in b_min],
            "bounds_max": [round(x, 2) for x in b_max],
            "dimensions": [round(b_max[i] - b_min[i], 2) for i in range(3)],
            "volume_cm3": round(vol, 2),
            "estimated_mass_petg_g": round(mass_petg, 1),
            "estimated_mass_asa_g": round(mass_asa, 1),
            "passed": passed,
        }

    def save_stl(self, path: Path) -> None:
        """Exports binary STL with standard 80-byte header and little-endian triangle records."""
        path.parent.mkdir(parents=True, exist_ok=True)
        header = f"PCHSMB Corner Skid Clip - {self.name}".encode("ascii")[:80].ljust(80, b"\0")
        with open(path, "wb") as f:
            f.write(header)
            f.write(struct.pack("<I", len(self.triangles)))
            for t in self.triangles:
                n = _normal(t)
                f.write(struct.pack("<3f", n[0], n[1], n[2]))
                for p in t:
                    f.write(struct.pack("<3f", p[0], p[1], p[2]))
                f.write(struct.pack("<H", 0))

    def mirror_x(self, name_suffix: str = "_mirrored") -> "Mesh":
        """Creates an enantiomer (mirror image) reflected across the YZ plane (X -> -X)."""
        m = Mesh(self.name + name_suffix)
        for a, b, c in self.triangles:
            ma = (-a[0], a[1], a[2])
            mb = (-b[0], b[1], b[2])
            mc = (-c[0], c[1], c[2])
            m.add(ma, mc, mb)
        return m


# =============================================================================
# 3. 2D PROFILE GENERATOR FOR CORNER SKID CLIP
# =============================================================================

def generate_clip_slice(
    x: float,
    r_in: float,
    z_top: float,
    z_skid: float,
    wall_t: float = 3.0,
    is_zone1: bool = True,
    n_half: int = 12
) -> Tuple[List[Vec2], List[Vec2]]:
    """
    Generates inner and outer 2D boundary polygons in the YZ plane at axial coordinate X.
    
    Both loops have exactly 2 * n_half + 1 points, running in 1-to-1 correspondence from
    the rear lip (-Y), around the bottom (-Z), to the front lip (+Y).
    """
    skid_flat_half_w = SKID_FLAT_HALF_WIDTH
    skid_blend_w = 4.0

    inner_pts: List[Vec2] = []
    outer_pts: List[Vec2] = []

    # Angular sweep:
    # Zone 1 sweeps to 105° past equator with 45° anti-tear entry bevels at top.
    # Zone 2 sweeps to 90° with vertical sidewalls up to z_top (wide open U-trough).
    phi_max = math.radians(105.0 if is_zone1 else 90.0)

    for idx in range(2 * n_half + 1):
        frac = (idx - n_half) / float(n_half)
        sign = -1.0 if frac < 0 else 1.0
        abs_frac = abs(frac)

        phi = frac * phi_max
        y_arc = r_in * math.sin(phi)
        z_arc = -r_in * math.cos(phi)

        if is_zone1:
            # Zone 1: Inner profile has a 45° entry bevel on the top 15% to cam open smoothly
            if abs_frac > 0.85:
                t_bev = (abs_frac - 0.85) / 0.15
                phi_b = 0.85 * phi_max
                yb = r_in * math.sin(phi_b)
                zb = -r_in * math.cos(phi_b)
                y_target = (r_in * math.sin(phi_max) + ENTRY_BEVEL_DEPTH)
                z_target = z_top
                y_in = sign * (yb * (1.0 - t_bev) + y_target * t_bev)
                z_in = zb * (1.0 - t_bev) + z_target * t_bev
            else:
                y_in = y_arc
                z_in = z_arc
        else:
            # Zone 2: Straight vertical/draft wall up to z_top
            if abs_frac > 0.80:
                t_wall = (abs_frac - 0.80) / 0.20
                phi_w = 0.80 * phi_max
                yw = r_in * math.sin(phi_w)
                zw = -r_in * math.cos(phi_w)
                y_target = r_in + 0.5  # 0.5 mm draft
                z_target = z_top
                y_in = sign * (yw * (1.0 - t_wall) + y_target * t_wall)
                z_in = zw * (1.0 - t_wall) + z_target * t_wall
            else:
                y_in = y_arc
                z_in = z_arc

        inner_pts.append((round(y_in, 4), round(z_in, 4)))

        # Outer profile:
        r_out = r_in + wall_t
        y_out_cyl = r_out * math.sin(phi)
        z_out_cyl = -r_out * math.cos(phi)

        if abs_frac > 0.80:
            t_lip = (abs_frac - 0.80) / 0.20
            phi_l = 0.80 * phi_max
            yl = r_out * math.sin(phi_l)
            zl = -r_out * math.cos(phi_l)
            y_out_target = abs(y_in) + wall_t
            z_out_target = z_top
            y_out = sign * (yl * (1.0 - t_lip) + y_out_target * t_lip)
            z_out = zl * (1.0 - t_lip) + z_out_target * t_lip
        else:
            y_out = y_out_cyl
            z_out = z_out_cyl

        # Skid runner flat at bottom:
        if abs(y_out) <= skid_flat_half_w:
            z_out = z_skid
        elif abs(y_out) <= skid_flat_half_w + skid_blend_w:
            t_blend = (abs(y_out) - skid_flat_half_w) / skid_blend_w
            z_out = z_skid * (1.0 - t_blend) + min(z_out, z_skid + 2.5) * t_blend

        outer_pts.append((round(y_out, 4), round(z_out, 4)))

    return inner_pts, outer_pts


# =============================================================================
# 4. 3D MESH GENERATION PIPELINE
# =============================================================================

def build_corner_skid_clip_left() -> Mesh:
    """
    Constructs the Left-Hand Corner Skid Clip.
    
    Axial schedule along X:
      X = 0.0 to 12.0 mm: Inner ski-tip lead-in ramp and bore entry chamfer
      X = 12.0 to 45.0 mm: Zone 1 straight 3/4" EMT conduit snap (ID 24.50mm)
      X = 45.0 to 50.0 mm: 45° internal transition stop shoulder (ID 24.50 -> 37.00mm)
      X = 50.0 to 135.0 mm: Zone 2 over-bracket shroud (ID 37.00mm, 85mm long)
      X = 135.0 to 140.0 mm: Corner end bumper with rounded bullnose
    """
    m = Mesh("corner_skid_clip_left")
    n_half = 12

    x_stations = [
        0.0,    # Inner end (entry rim)
        2.0,    # End of entry lead-in bevel
        6.0,    # Ski-tip ramp mid
        12.0,   # End of ski-tip ramp
        25.0,   # Zone 1 mid
        40.0,   # Zone 1 near transition
        45.0,   # Zone 1 / step boundary
        50.0,   # Zone 2 start (after 45° internal taper)
        65.0,   # Zone 2 mid-front
        85.0,   # Zone 2 mid
        105.0,  # Zone 2 mid-rear
        125.0,  # Zone 2 outer
        135.0,  # Start of corner end bullnose
        138.0,  # Bullnose mid
        140.0,  # Outer corner apex
    ]

    slices = []
    for x in x_stations:
        if x <= 45.0:
            is_zone1 = True
            r_in = SNAP_INNER_RADIUS  # 12.25 mm
            z_top = ZONE1_TOP_Z       # 4.50 mm
            wall_t = WALL_THICKNESS   # 3.00 mm
            # Inner bore entry chamfer at X = 0 to 2.0 mm:
            if x <= 2.0:
                t_in_bev = (2.0 - x) / 2.0
                r_in = SNAP_INNER_RADIUS + t_in_bev * INNER_RIM_CHAMFER
        elif x >= 50.0:
            is_zone1 = False
            r_in = CORNER_INNER_RADIUS  # 18.50 mm (37.0 mm ID!)
            z_top = ZONE2_TOP_Z         # 2.00 mm (clean open trough)
            wall_t = WALL_THICKNESS     # 3.00 mm
        else:
            # Transition shoulder (X = 45.0 to 50.0 mm):
            t = (x - 45.0) / TRANSITION_TAPER_LEN
            is_zone1 = (t < 0.5)
            r_in = SNAP_INNER_RADIUS + t * (CORNER_INNER_RADIUS - SNAP_INNER_RADIUS)
            z_top = ZONE1_TOP_Z + t * (ZONE2_TOP_Z - ZONE1_TOP_Z)
            wall_t = WALL_THICKNESS

        # Skid runner bottom profile:
        z_base = SKID_GROUND_Z
        if x <= SKID_RUNNER_BEVEL_LEN:
            t_ramp = (SKID_RUNNER_BEVEL_LEN - x) / SKID_RUNNER_BEVEL_LEN
            z_skid = z_base + t_ramp * SKID_RAMP_HEIGHT  # Ski-tip ramp
        elif x >= 135.0:
            t_bull = (x - 135.0) / 5.0
            z_skid = z_base + t_bull * 3.00              # Outer bullnose
        else:
            z_skid = z_base

        in_pts, out_pts = generate_clip_slice(x, r_in, z_top, z_skid, wall_t, is_zone1, n_half)
        in_3d = [(x, p[0], p[1]) for p in in_pts]
        out_3d = [(x, p[0], p[1]) for p in out_pts]
        slices.append((in_3d, out_3d))

    # Loft between successive axial stations:
    for s in range(len(slices) - 1):
        in0, out0 = slices[s]
        in1, out1 = slices[s + 1]

        # Inner cavity:
        for i in range(len(in0) - 1):
            m.quad(in0[i], in1[i], in1[i + 1], in0[i + 1])

        # Outer shell & skid runner:
        for i in range(len(out0) - 1):
            m.quad(out0[i], out0[i + 1], out1[i + 1], out1[i])

        # Rear top lip (continuous horizontal lip):
        m.quad(out0[0], in0[0], in1[0], out1[0])

        # Front top lip (continuous horizontal lip):
        m.quad(in0[-1], out0[-1], out1[-1], in1[-1])

    # Inner end face at X = 0.0 (normal points -X):
    in_start, out_start = slices[0]
    for i in range(len(in_start) - 1):
        m.quad(out_start[i], in_start[i], in_start[i + 1], out_start[i + 1])

    # Outer end face at X = 140.0 mm (normal points +X, open U-channel profile):
    in_end, out_end = slices[-1]
    for i in range(len(in_end) - 1):
        m.quad(in_end[i], out_end[i], out_end[i + 1], in_end[i + 1])

    return m


def build_corner_skid_clip_right() -> Mesh:
    """Constructs the Right-Hand Corner Skid Clip by reflecting the Left Clip across X."""
    left = build_corner_skid_clip_left()
    right = left.mirror_x()
    right.name = "corner_skid_clip_right"
    return right


def build_corner_skid_clip_pair() -> Mesh:
    """Combines Left and Right clips side-by-side for one-pass dual printing (1 complete screen set)."""
    left = build_corner_skid_clip_left()
    right = build_corner_skid_clip_right()

    pair = Mesh("corner_skid_clip_pair")
    # Offset along Y by 30 mm to clear each other on the print bed:
    for a, b, c in left.triangles:
        pair.add((a[0], a[1] - 30.0, a[2]), (b[0], b[1] - 30.0, b[2]), (c[0], c[1] - 30.0, c[2]))
    for a, b, c in right.triangles:
        pair.add((a[0], a[1] + 30.0, a[2]), (b[0], b[1] + 30.0, b[2]), (c[0], c[1] + 30.0, c[2]))

    return pair


# =============================================================================
# 5. 3MF SLICER PACKAGE GENERATOR
# =============================================================================

def build_3mf_package(stl_path: Path, out_3mf_path: Path) -> None:
    """Packages the pair STL into a standardized 3MF manufacturing archive."""
    import zipfile

    triangles = []
    with open(stl_path, "rb") as f:
        f.read(80)
        n_tris = struct.unpack("<I", f.read(4))[0]
        for _ in range(n_tris):
            f.read(12)
            p1 = struct.unpack("<3f", f.read(12))
            p2 = struct.unpack("<3f", f.read(12))
            p3 = struct.unpack("<3f", f.read(12))
            f.read(2)
            triangles.append((p1, p2, p3))

    vertex_map: Dict[Tuple[float, float, float], int] = {}
    vertices: List[Tuple[float, float, float]] = []
    tri_indices: List[Tuple[int, int, int]] = []

    for p1, p2, p3 in triangles:
        idx_t = []
        for p in (p1, p2, p3):
            kp = (round(p[0], 4), round(p[1], 4), round(p[2], 4))
            if kp not in vertex_map:
                vertex_map[kp] = len(vertices)
                vertices.append(kp)
            idx_t.append(vertex_map[kp])
        tri_indices.append((idx_t[0], idx_t[1], idx_t[2]))

    model_xml = [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<model unit="millimeter" xml:lang="en-US" xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">',
        '  <metadata name="Title">PCHSMB Duck Blind Corner Skid Clip - Pair</metadata>',
        '  <metadata name="Designer">Antigravity Agentic Assistant / PCHSMB Engineering</metadata>',
        '  <metadata name="Application">PrusaSlicer / Bambu Studio / OrcaSlicer</metadata>',
        '  <resources>',
        '    <object id="1" type="model">',
        '      <mesh>',
        '        <vertices>',
    ]
    for v in vertices:
        model_xml.append(f'          <vertex x="{v[0]:.4f}" y="{v[1]:.4f}" z="{v[2]:.4f}" />')
    model_xml.extend([
        '        </vertices>',
        '        <triangles>',
    ])
    for t in tri_indices:
        model_xml.append(f'          <triangle v1="{t[0]}" v2="{t[1]}" v3="{t[2]}" />')
    model_xml.extend([
        '        </triangles>',
        '      </mesh>',
        '    </object>',
        '  </resources>',
        '  <build>',
        '    <item objectid="1" />',
        '  </build>',
        '</model>',
    ])

    rels_xml = (
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">\n'
        '  <Relationship Target="/3D/3dmodel.model" Id="rel0" '
        'Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel" />\n'
        '</Relationships>'
    )

    content_types_xml = (
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">\n'
        '  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml" />\n'
        '  <Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml" />\n'
        '</Types>'
    )

    out_3mf_path.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(out_3mf_path, "w", compression=zipfile.ZIP_DEFLATED) as zf:
        zf.writestr("_rels/.rels", rels_xml)
        zf.writestr("[Content_Types].xml", content_types_xml)
        zf.writestr("3D/3dmodel.model", "\n".join(model_xml))


# =============================================================================
# 6. HIGH-RESOLUTION MULTI-VIEW RENDERING PIPELINE
# =============================================================================

def render_multiview(stl_path: Path, out_path: Path, title: str, subtitle: str) -> None:
    """Renders high-contrast 4-view engineering drawings (Isometric, Plan, Front, End)."""
    tris = []
    with open(stl_path, "rb") as f:
        f.read(80)
        n = struct.unpack("<I", f.read(4))[0]
        for _ in range(n):
            f.read(12)
            pts = [
                struct.unpack("<3f", f.read(12)),
                struct.unpack("<3f", f.read(12)),
                struct.unpack("<3f", f.read(12)),
            ]
            f.read(2)
            tris.append(pts)

    if not tris:
        return

    pts_arr = np.array(tris, dtype=np.float32)
    verts = pts_arr.reshape(-1, 3)
    c_min = verts.min(axis=0)
    c_max = verts.max(axis=0)
    center = (c_min + c_max) / 2.0
    extent = (c_max - c_min).max()
    if extent == 0:
        extent = 1.0

    sheet_w, sheet_h = 1600, 1200
    sheet = Image.new("RGBA", (sheet_w, sheet_h), (255, 255, 255, 255))
    draw = ImageDraw.Draw(sheet)

    def look_at(eye: np.ndarray, target: np.ndarray, up: np.ndarray) -> np.ndarray:
        fwd = target - eye
        fwd /= np.linalg.norm(fwd)
        right = np.cross(fwd, up)
        right /= np.linalg.norm(right)
        true_up = np.cross(right, fwd)
        rot = np.eye(4, dtype=np.float32)
        rot[0, :3] = right
        rot[1, :3] = true_up
        rot[2, :3] = -fwd
        trans = np.eye(4, dtype=np.float32)
        trans[:3, 3] = -eye
        return rot @ trans

    def render_view(view_mat: np.ndarray, color=(40, 120, 200)) -> Image.Image:
        vw, vh = 760, 520
        v_img = Image.new("RGBA", (vw, vh), (255, 255, 255, 255))

        v_homo = np.ones((len(verts), 4), dtype=np.float32)
        v_homo[:, :3] = verts
        v_cam = (view_mat @ v_homo.T).T[:, :3]

        scale = (min(vw, vh) * 0.40) / (extent * 0.55)
        xs = vw / 2.0 + v_cam[:, 0] * scale
        ys = vh / 2.0 - v_cam[:, 1] * scale
        zs = v_cam[:, 2]

        cam_tris = np.stack([
            np.stack([xs[0::3], ys[0::3], zs[0::3]], axis=-1),
            np.stack([xs[1::3], ys[1::3], zs[1::3]], axis=-1),
            np.stack([xs[2::3], ys[2::3], zs[2::3]], axis=-1),
        ], axis=1)

        v_draw = ImageDraw.Draw(v_img)
        light_dir = np.array([0.4, 0.4, 1.0], dtype=np.float32)
        light_dir /= np.linalg.norm(light_dir)

        order = np.argsort(cam_tris[:, :, 2].mean(axis=1))

        for idx in order:
            t = cam_tris[idx]
            u = t[1] - t[0]
            v = t[2] - t[0]
            normal = np.cross(u, v)
            n_mag = np.linalg.norm(normal)
            if n_mag > 1e-6:
                normal /= n_mag
            else:
                normal = np.array([0.0, 0.0, 1.0], dtype=np.float32)

            intensity = max(0.25, float(np.dot(normal, light_dir)))
            poly = [(t[0, 0], t[0, 1]), (t[1, 0], t[1, 1]), (t[2, 0], t[2, 1])]

            f_col = (
                int(color[0] * intensity),
                int(color[1] * intensity),
                int(color[2] * intensity),
                255
            )
            e_col = (
                max(0, int(f_col[0] * 0.7)),
                max(0, int(f_col[1] * 0.7)),
                max(0, int(f_col[2] * 0.7)),
                255
            )
            v_draw.polygon(poly, fill=f_col, outline=e_col)

        return v_img

    views = [
        (look_at(center + np.array([1.2, -1.5, 1.2]) * extent, center, np.array([0.0, 0.0, 1.0])), (50, 130, 210), "Isometric 3D View", 30, 80),
        (look_at(center + np.array([0.0, 0.0, 2.0]) * extent, center, np.array([0.0, 1.0, 0.0])), (45, 110, 180), "Top Plan View (XY) — Open Upward Trough", 810, 80),
        (look_at(center + np.array([0.0, -2.0, 0.0]) * extent, center, np.array([0.0, 0.0, 1.0])), (35, 90, 160), "Front Elevation View (XZ) — Graphic Face", 30, 630),
        (look_at(center + np.array([2.0, 0.0, 0.0]) * extent, center, np.array([0.0, 0.0, 1.0])), (30, 80, 150), "Right Elevation View (YZ) — Corner Apex Profile", 810, 630),
    ]

    for v_mat, v_col, v_title, x_pos, y_pos in views:
        img_v = render_view(v_mat, v_col)
        sheet.paste(img_v, (x_pos, y_pos))
        draw.text((x_pos + 10, y_pos + 10), v_title, fill=(40, 50, 60, 255))

    dims_text = f"Dimensions: {c_max[0]-c_min[0]:.1f} x {c_max[1]-c_min[1]:.1f} x {c_max[2]-c_min[2]:.1f} mm"
    draw.text((30, 20), title, fill=(20, 30, 40, 255))
    draw.text((30, 45), f"{subtitle}  |  {dims_text}", fill=(80, 90, 100, 255))

    out_path.parent.mkdir(parents=True, exist_ok=True)
    sheet.save(out_path)


# =============================================================================
# 7. MACHINE-READABLE MANIFEST GENERATOR
# =============================================================================

def generate_manifest(out_dir: Path, meshes: List[Mesh]) -> dict:
    """Generates machine-readable manifest.json documenting all CAD specs, masses, and QA audits."""
    manifest = {
        "subproject": "PCHSMB Duck Blind Corner Skid Clip",
        "description": "Sacrificial snap-on corner wear shoe and bumper for 3/4in. EMT conduit Duck Blind frames",
        "author": "Antigravity Agentic Assistant / PCHSMB Engineering",
        "governing_specifications": {
            "prop_system": "PCHSMB Sideline Screen / Duck Blind (4 ft x 8 ft)",
            "frame_conduit": "3/4-in. EMT Electrical Metallic Tubing (OD 23.42 mm)",
            "corner_bracket": "3-Way 3/4-in. EMT Clamp Bracket (Bracket F, Amazon B0D5BBKCKG)",
            "vinyl_banner": "13 oz Heavy Scrim Vinyl (thickness ~0.38 mm)",
            "existing_clips": "1-in. Greenhouse Pipe Snap Clamps (Amazon B0BJJYKZ5L)",
        },
        "geometric_architecture": {
            "total_length_mm": TOTAL_CLIP_LEN,
            "conduit_snap_section_length_mm": ZONE1_SNAP_LEN,
            "internal_locating_taper_length_mm": TRANSITION_TAPER_LEN,
            "over_bracket_shroud_length_mm": ZONE2_CORNER_LEN,
            "end_bumper_section_length_mm": END_WALL_THICKNESS,
            "snap_inner_diameter_mm": SNAP_INNER_DIA,
            "corner_inner_diameter_mm": CORNER_INNER_DIA,
            "radial_clearance_over_bracket_mm": round(CORNER_INNER_RADIUS - BRACKET_F_RADIUS, 2),
            "wall_thickness_mm": WALL_THICKNESS,
            "skid_ground_z_mm": SKID_GROUND_Z,
            "skid_protrusion_below_bracket_f_mm": round(abs(SKID_GROUND_Z) - BRACKET_F_RADIUS, 2),
            "skid_protrusion_below_conduit_mm": round(abs(SKID_GROUND_Z) - CONDUIT_34_RADIUS, 2),
            "solid_sacrificial_wear_thickness_mm": round(abs(SKID_GROUND_Z) - (CORNER_INNER_RADIUS - 3.0), 2),
            "skid_flat_glide_width_mm": round(2 * SKID_FLAT_HALF_WIDTH, 2),
            "ski_tip_ramp_length_mm": SKID_RUNNER_BEVEL_LEN,
            "ski_tip_ramp_height_mm": SKID_RAMP_HEIGHT,
            "anti_tear_mouth_bevel_depth_mm": ENTRY_BEVEL_DEPTH,
            "inner_bore_entry_chamfer_mm": INNER_RIM_CHAMFER,
            "zone1_mouth_width_mm": round(2 * (SNAP_INNER_RADIUS * math.sin(math.radians(105.0)) + ENTRY_BEVEL_DEPTH), 2),
            "top_edge_architecture": "100% open upward trough, zero roof bridging, unobstructed vertical rail clearance",
        },
        "manufacturing": {
            "process": "Fused Deposition Modeling (FDM / 3D Printing)",
            "recommended_material": "Black ASA (UV, weather, and abrasion resistant)",
            "alternative_material": "PETG (Outdoor weather resistant)",
            "orientation": "Flat on sacrificial bottom skid runner (zero supports needed)",
            "perimeters": 5,
            "infill_ratio": NOMINAL_INFILL_RATIO,
            "infill_pattern": "Gyroid or Cross-Hatch",
            "layer_height_mm": 0.20,
        },
        "fleet_requirements": {
            "screens_in_fleet": 16,
            "clips_per_screen": 2,
            "total_fleet_clips": 32,
            "left_hand_clips_needed": 16,
            "right_hand_clips_needed": 16,
        },
        "models": {},
    }

    for m in meshes:
        manifest["models"][m.name] = m.audit()

    return manifest


# =============================================================================
# 8. MAIN CLI ENTRY POINT
# =============================================================================

def main() -> int:
    import json

    base_dir = Path(__file__).resolve().parent
    build_dir = base_dir / "build"
    build_dir.mkdir(parents=True, exist_ok=True)

    print("=" * 80)
    print("PCHSMB DUCK BLIND CORNER SKID CLIP — PARAMETRIC CAD GENERATOR")
    print("=" * 80)

    print("\n[1/5] Generating Left-Hand Corner Skid Clip...")
    left = build_corner_skid_clip_left()
    left_audit = left.audit()
    print(f"      Triangles: {left_audit['triangles']}, Volume: {left_audit['volume_cm3']} cm3")
    print(f"      Bounds: {left_audit['dimensions']} mm [L x W x H]")
    print(f"      Topological QA: Boundary={left_audit['boundary_edges']}, Non-Manifold={left_audit['nonmanifold_edges']} -> Passed: {left_audit['passed']}")
    if not left_audit['passed']:
        print("ERROR: Left clip mesh failed topological QA!")
        return 1

    print("\n[2/5] Generating Right-Hand Corner Skid Clip (Mirror Enantiomer)...")
    right = build_corner_skid_clip_right()
    right_audit = right.audit()
    print(f"      Triangles: {right_audit['triangles']}, Volume: {right_audit['volume_cm3']} cm3")
    print(f"      Topological QA: Boundary={right_audit['boundary_edges']}, Non-Manifold={right_audit['nonmanifold_edges']} -> Passed: {right_audit['passed']}")
    if not right_audit['passed']:
        print("ERROR: Right clip mesh failed topological QA!")
        return 1

    print("\n[3/5] Generating Dual-Print Pair (1 Complete Screen Set)...")
    pair = build_corner_skid_clip_pair()
    pair_audit = pair.audit()
    print(f"      Triangles: {pair_audit['triangles']}, Volume: {pair_audit['volume_cm3']} cm3")
    print(f"      Topological QA: Boundary={pair_audit['boundary_edges']}, Non-Manifold={pair_audit['nonmanifold_edges']} -> Passed: {pair_audit['passed']}")
    if not pair_audit['passed']:
        print("ERROR: Pair mesh failed topological QA!")
        return 1

    # Save STLs locally and to build/
    print("\n[4/5] Exporting Watertight Binary STLs and Slicer 3MF Package...")
    left.save_stl(base_dir / "corner_skid_clip_left.stl")
    left.save_stl(build_dir / "corner_skid_clip_left.stl")
    right.save_stl(base_dir / "corner_skid_clip_right.stl")
    right.save_stl(build_dir / "corner_skid_clip_right.stl")
    pair.save_stl(base_dir / "corner_skid_clip_pair.stl")
    pair.save_stl(build_dir / "corner_skid_clip_pair.stl")

    # Mirror to parent Hardware/ directory
    hw_dir = base_dir.parent
    left.save_stl(hw_dir / "Corner Skid Clip Left.stl")
    right.save_stl(hw_dir / "Corner Skid Clip Right.stl")

    # Slicer 3MF
    p3mf = base_dir / "corner_skid_clip_pair.3mf"
    build_3mf_package(base_dir / "corner_skid_clip_pair.stl", p3mf)
    build_3mf_package(base_dir / "corner_skid_clip_pair.stl", hw_dir / "3MF" / "Corner Skid Clip-Pair.3mf")
    print(f"      Exported: corner_skid_clip_left.stl ({os.path.getsize(base_dir / 'corner_skid_clip_left.stl')} bytes)")
    print(f"      Exported: corner_skid_clip_right.stl ({os.path.getsize(base_dir / 'corner_skid_clip_right.stl')} bytes)")
    print(f"      Exported: corner_skid_clip_pair.stl ({os.path.getsize(base_dir / 'corner_skid_clip_pair.stl')} bytes)")
    print(f"      Exported: corner_skid_clip_pair.3mf ({os.path.getsize(p3mf)} bytes)")

    # Render drawings
    print("\n[5/5] Rendering High-Resolution Multi-View Engineering Drawings...")
    render_multiview(
        base_dir / "corner_skid_clip_left.stl",
        build_dir / "corner_skid_clip_left_multiview.png",
        "PCHSMB Duck Blind - Corner Skid Clip (Left Hand)",
        "Sacrificial Bottom-Rail Wear Shoe & Bracket F Shroud"
    )
    render_multiview(
        base_dir / "corner_skid_clip_right.stl",
        build_dir / "corner_skid_clip_right_multiview.png",
        "PCHSMB Duck Blind - Corner Skid Clip (Right Hand)",
        "Sacrificial Bottom-Rail Wear Shoe & Bracket F Shroud"
    )
    render_multiview(
        base_dir / "corner_skid_clip_pair.stl",
        build_dir / "corner_skid_clip_pair_multiview.png",
        "PCHSMB Duck Blind - Corner Skid Clip Dual-Plate Set",
        "1 Screen Set (Left Hand + Right Hand Enantiomers)"
    )
    print("      Rendered: build/corner_skid_clip_left_multiview.png")
    print("      Rendered: build/corner_skid_clip_right_multiview.png")
    print("      Rendered: build/corner_skid_clip_pair_multiview.png")

    # Generate Manifest
    manifest = generate_manifest(build_dir, [left, right, pair])
    manifest_path = build_dir / "manifest.json"
    with open(manifest_path, "w") as f:
        json.dump(manifest, f, indent=2)
    print(f"      Generated: build/manifest.json ({manifest_path.stat().st_size} bytes)")

    print("\nAll tasks completed successfully with 100% QA pass!")
    return 0


if __name__ == "__main__":
    sys.exit(main())
