# PCHSMB Duck Blind Universal Corner Protector — Subproject Instructions

This directory houses the authoritative parametric CAD model, build pipeline, and production STLs for the **PCHSMB Duck Blind Universal Corner Protector** subproject.

## 1. Subproject Architecture & Engineering Standards

- **OpenSCAD Parametric CAD Engine (`cad-openscad` skill):** `corner_protector.scad` is the sole authoritative parametric CAD model and rendering pipeline. Rendered headlessly via OpenSCAD CLI:
  ```bash
  /Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD --export-format=binstl -o build/corner_protector_piece1_outside.stl -D 'part="piece1"' corner_protector.scad
  /Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD --export-format=binstl -o build/corner_protector_piece2_inside.stl -D 'part="piece2"' corner_protector.scad
  /Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD --export-format=binstl -o build/corner_protector_pair.stl -D 'part="pair"' corner_protector.scad
  ```
- **Two-Piece Clamp Architecture:**
  1. **Piece 1 (Outside Piece / Skid Shoe):** Covers front face (over vinyl banner), continues around the outside perimeter (bottom ground runner and side bumper), and wraps up the rear face. Slips on from the outside corner with very loose tolerances (+8.8 mm diametral clearance) for folded vinyl tabs.
  2. **Piece 2 (Inside Piece / Clamp Block):** Drops into the inside crook of Bracket F, providing clamping force with captured hex nuts. Elevated +35.5 mm above ground with zero ground contact.
- **Single Common Component:** 100% symmetric across the 45° diagonal ($X = Z$). No separate "Left" or "Right" parts; one common set works on all frame corners.
- **Fastener Retention:** Clamped rigidly via 2x M5x40mm (or #10-24x1.5") socket head cap screws inserted through recessed counterbores in Piece 1 into captured hex nuts in Piece 2.
- **100% Zero-Support FDM Printability:** Piece 1 prints flat on its front face with self-supporting geometry; Piece 2 prints flat on its rear face with zero overhangs.
- **Hermetic Testing:** Validated via standard library unittest suite `test_corner_protector.py` testing dimensional invariants, symmetry, and manifold watertightness.
- **Documentation Synchronization (AGENTS.md § 5):** Whenever protector dimensions change, update `README.md`, production STLs, and Duck Blind build instructions concurrently.
