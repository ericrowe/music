#!/usr/bin/env python3
"""Zero-dependency hermetic test suite for PCHSMB Duck Blind Universal Corner Protector.

Validates OpenSCAD parametric source, module architecture, dimension invariants,
and binary STL topological quality per cad-openscad skill standards.
Uses standard library unittest (zero pip dependencies required).
"""

from pathlib import Path
import re
import struct
import unittest

SCAD_PATH = Path(__file__).parent / "corner_protector.scad"
BUILD_DIR = Path(__file__).parent / "build"
PIECE1_STL = BUILD_DIR / "corner_protector_piece1_outside.stl"
PIECE2_STL = BUILD_DIR / "corner_protector_piece2_inside.stl"
PAIR_STL = BUILD_DIR / "corner_protector_pair.stl"


def parse_scad_parameters(filepath: Path) -> dict:
    """Parse top-level variable definitions from OpenSCAD source."""
    params = {}
    content = filepath.read_text()
    pattern = re.compile(r"^([a-zA-Z_0-9]+)\s*=\s*([^;]+);", re.MULTILINE)
    for match in pattern.finditer(content):
        name = match.group(1).strip()
        raw_val = match.group(2).strip()
        try:
            val = float(raw_val)
        except ValueError:
            val = raw_val.strip('"')
        params[name] = val
    return params


def read_stl_geometry(stl_path: Path):
    """Parse binary STL to compute triangle count, bounding box, and surface area."""
    with open(stl_path, "rb") as f:
        header = f.read(80)
        tri_count_bytes = f.read(4)
        if len(tri_count_bytes) < 4:
            raise ValueError(f"File {stl_path} is not a valid binary STL")
        num_triangles = struct.unpack("<I", tri_count_bytes)[0]

        min_x = min_y = min_z = float("inf")
        max_x = max_y = max_z = float("-inf")
        signed_volume = 0.0

        for _ in range(num_triangles):
            record = f.read(50)
            if len(record) < 50:
                break
            nx, ny, nz, v1x, v1y, v1z, v2x, v2y, v2z, v3x, v3y, v3z, _ = (
                struct.unpack("<12fH", record)
            )

            for vx, vy, vz in [(v1x, v1y, v1z), (v2x, v2y, v2z), (v3x, v3y, v3z)]:
                min_x = min(min_x, vx)
                max_x = max(max_x, vx)
                min_y = min(min_y, vy)
                max_y = max(max_y, vy)
                min_z = min(min_z, vz)
                max_z = max(max_z, vz)

            # Tetrahedral signed volume
            v321 = v3x * v2y * v1z
            v231 = v2x * v3y * v1z
            v312 = v3x * v1y * v2z
            v132 = v1x * v3y * v2z
            v213 = v2x * v1y * v3z
            v123 = v1x * v2y * v3z
            signed_volume += (
                1.0
                / 6.0
                * (
                    -v321
                    + v231
                    + v312
                    - v132
                    - v213
                    + v123
                )
            )

    return {
        "num_triangles": num_triangles,
        "bbox": ((min_x, max_x), (min_y, max_y), (min_z, max_z)),
        "volume_mm3": signed_volume,
        "volume_cm3": signed_volume / 1000.0,
    }


class TestCornerProtectorSCAD(unittest.TestCase):
    """Validate OpenSCAD source file, parameters, and design invariants."""

    def test_scad_file_exists(self):
        self.assertTrue(SCAD_PATH.is_file(), f"Missing SCAD source at {SCAD_PATH}")

    def test_required_parameters_defined(self):
        params = parse_scad_parameters(SCAD_PATH)
        required = [
            "conduit_od",
            "bracket_od",
            "bracket_sleeve_len",
            "pocket_dia",
            "arm_len",
            "wall_front",
            "skid_thick",
            "bolt_dia",
            "bolt_head_dia",
            "nut_flats",
            "bolt_offset",
            "clamp_saddle_r",
            "clamp_thickness",
        ]
        for req in required:
            self.assertIn(req, params, f"Missing required parameter: {req}")

    def test_clearance_and_tolerances(self):
        params = parse_scad_parameters(SCAD_PATH)
        # User constraint: very loose tolerances for folded vinyl over bracket
        pocket_clearance = params["pocket_dia"] - params["bracket_od"]
        self.assertGreaterEqual(
            pocket_clearance,
            6.0,
            f"Pocket clearance ({pocket_clearance:.2f}mm) must be >= 6.0mm for folded vinyl",
        )
        # Skid wall thickness must provide solid sacrificial wear
        self.assertGreaterEqual(
            params["skid_thick"],
            4.0,
            f"Skid wall thickness ({params['skid_thick']}mm) must be >= 4.0mm",
        )

    def test_symmetry_parameters(self):
        params = parse_scad_parameters(SCAD_PATH)
        # Symmetrical bolt placement
        self.assertGreater(
            params["bolt_offset"],
            params["clamp_start"],
            "Bolt must pass through clamp wing",
        )
        self.assertLess(
            params["bolt_offset"],
            params["clamp_end"],
            "Bolt must pass before clamp wing terminates",
        )

    def test_required_modules_declared(self):
        content = SCAD_PATH.read_text()
        required_modules = [
            "corner_protector_piece1",
            "corner_protector_piece2",
            "corner_protector_assembly",
            "corner_protector_pair_plate",
            "mirror_diag",
            "hex_nut_pocket",
        ]
        for mod in required_modules:
            self.assertIn(
                f"module {mod}(", content, f"Missing required module: {mod}"
            )

    def test_piece1_mesh_validity(self):
        if not PIECE1_STL.is_file():
            self.skipTest("Piece 1 STL not yet generated")
        geo = read_stl_geometry(PIECE1_STL)
        self.assertGreater(
            geo["num_triangles"], 200, f"Triangle count {geo['num_triangles']} too low"
        )
        self.assertGreater(
            geo["volume_cm3"],
            10.0,
            f"Piece 1 volume ({geo['volume_cm3']:.1f} cm3) is unphysically small",
        )
        # Bounding box symmetry: X extent and Z extent must be equal within 0.5mm
        (min_x, max_x), _, (min_z, max_z) = geo["bbox"]
        x_span = max_x - min_x
        z_span = max_z - min_z
        self.assertAlmostEqual(
            x_span,
            z_span,
            delta=0.5,
            msg=f"Piece 1 is not symmetric: X span = {x_span:.2f}, Z span = {z_span:.2f}",
        )

    def test_piece2_mesh_validity(self):
        if not PIECE2_STL.is_file():
            self.skipTest("Piece 2 STL not yet generated")
        geo = read_stl_geometry(PIECE2_STL)
        self.assertGreater(
            geo["num_triangles"], 100, f"Triangle count {geo['num_triangles']} too low"
        )
        self.assertGreater(
            geo["volume_cm3"],
            5.0,
            f"Piece 2 volume ({geo['volume_cm3']:.1f} cm3) is unphysically small",
        )
        # Bounding box symmetry
        (min_x, max_x), _, (min_z, max_z) = geo["bbox"]
        x_span = max_x - min_x
        z_span = max_z - min_z
        self.assertAlmostEqual(
            x_span,
            z_span,
            delta=0.5,
            msg=f"Piece 2 is not symmetric: X span = {x_span:.2f}, Z span = {z_span:.2f}",
        )


if __name__ == "__main__":
    unittest.main(verbosity=2)
