---
name: cad-python
description: Programmatic CAD, procedural mesh generation, and binary STL export using pure Python or Python CAD libraries (build123d, cadquery, trimesh, numpy-stl). Defines use-case evaluation criteria, algorithmic workflows, and headless CI export.
---

# Python Programmatic CAD & Binary STL Generation Skill

## 1. Dual CAD Architecture Invariant

In the **Server Rack** master workspace, **both Python-based STL generation and OpenSCAD are fully supported and approved engineering pathways** for physical components, rack brackets, sensor mounts, and 3D printable enclosures.

> [!IMPORTANT]
> **Use Case Evaluation Rule**: Neither approach is universally superior. Before writing generative scripts or creating 3D models, evaluate the specific project requirements against the **Decision Matrix** below to select the appropriate toolchain.

---

## 2. Decision Matrix: When to Choose Python-Based CAD

| Criterion | Choose Python CAD (`.py`) | Choose OpenSCAD (`.scad`) |
| :--- | :--- | :--- |
| **Primary Workflow** | Headless, programmatic, or automated batch generation without requiring desktop GUI software. | Rapid visual iteration and live parameter tweaking in the OpenSCAD GUI / Customizer. |
| **Geometric Paradigm** | Algorithmic lofts, procedural cross-sections, mathematical surface rings, or B-Rep sketches. | Constructive Solid Geometry (CSG): boolean unions, differences, intersections, hull, and minkowski. |
| **Hermetic CI / Zero-Install** | Pure Python standard library scripts (`struct`, `math`) generate binary STL directly with **zero external binaries or C++ dependencies**. | Requires OpenSCAD installed for headless CLI compilation (`openscad -o out.stl in.scad`). |
| **Batch Matrix Generation** | Loop over dimensional arrays (e.g. generating 1x1 through 5x5 carriers, varying heights) producing dozens of models in seconds. | Typically renders one file or one customizer preset at a time. |
| **Coupled Metadata & Manifests** | Automatically export `manifest.json`, compute bounding volume, calculate material mass/cost, and write BOM in one step. | Metadata must be maintained separately in markdown documentation. |
| **Automated Pytest Testing** | Direct pytest assertions on vertices, triangle counts, bounding boxes, water-tightness (manifoldness), and clearance tolerances. | Testing typically parses `.scad` text strings or validates output file existence. |
| **CAD Interchange (STEP / B-Rep)** | Export modern **STEP AP214/AP242** solids for CNC CAM toolpaths or CAD exchange (via `build123d`). | Native export limited to polygonal meshes (STL, 3MF, OFF) and 2D DXF. |

### Recommended Use Cases for Python CAD:
1. **Parametric Modular Storage Families (e.g. Gridfinity / Cassettes)**: Generating entire matrices of carriers, bins, and cassettes with automated metadata, JSON manifests, and mass estimates (e.g. `Parts-Database/hardware/carriers/carrier_3x4_14u_test/generate_carrier.py`).
2. **Algorithmic & Lofted Geometries**: Continuous lofted transitions between differing cross-sections (e.g. rectangular-to-round duct adapters, ergonomic hand grips, variable-pitch screw threads).
3. **Automated CI/CD Hardware Pipelines**: Environments where headless builds must run in standard Python virtual environments without native system packages or X11/headless OpenGL display servers.
4. **CNC Machining & CAM Export**: When mechanical parts require STEP export for toolpath generation in Fusion 360 or FreeCAD (via `build123d`).

---

## 3. Directory Layout & File Organization

Organize Python CAD scripts within the project's `hardware/` directory:

```
<project>/hardware/
├── cad/ (or carriers/ / enclosures/)
│   ├── generate_<component>.py   # Generative Python script (pure Python or build123d)
│   ├── build/                    # Output artifacts produced by script
│   │   ├── <component>.stl       # Binary STL ready for slicer
│   │   ├── <component>.step      # Optional STEP file for CAD/CAM
│   │   └── manifest_v0_1.json    # Machine-readable metadata & volume/mass
│   └── README.md                 # Design notes & usage instructions
└── tests/
    └── test_<component>_mesh.py  # Pytest suite validating watertightness & geometry
```

---

## 4. Implementation Patterns

### Pattern A: Zero-Dependency Pure Python Binary STL Generator
For maximum portability across any Python 3 environment without installing CAD packages, generate binary STLs directly using Python's standard `struct` and `math` modules.

#### Binary STL Specification:
- **Header**: Exactly 80 bytes (arbitrary ASCII text / metadata).
- **Triangle Count**: 4-byte unsigned little-endian integer (`<I`).
- **Triangle Records**: Exactly 50 bytes per triangle:
  - Normal vector: 3x 32-bit floats (`<fff`).
  - Vertex 1: 3x 32-bit floats (`<fff`).
  - Vertex 2: 3x 32-bit floats (`<fff`).
  - Vertex 3: 3x 32-bit floats (`<fff`).
  - Attribute byte count: 2-byte unsigned integer (`<H`), typically `0`.

```python
#!/usr/bin/env python3
"""Zero-dependency pure Python binary STL generator."""
from __future__ import annotations
import math, struct
from pathlib import Path
from dataclasses import dataclass

V = tuple[float, float, float]
T = tuple[V, V, V]

@dataclass
class Mesh:
    triangles: list[T]
    def __init__(self): self.triangles = []
    
    def tri(self, a: V, b: V, c: V):
        # Calculate cross product for normal vector
        ux, uy, uz = b[0] - a[0], b[1] - a[1], b[2] - a[2]
        vx, vy, vz = c[0] - a[0], c[1] - a[1], c[2] - a[2]
        nx, ny, nz = uy * vz - uz * vy, uz * vx - ux * vz, ux * vy - uy * vx
        norm = math.sqrt(nx*nx + ny*ny + nz*nz)
        if norm > 1e-12:
            self.triangles.append((a, b, c))
            
    def quad(self, a: V, b: V, c: V, d: V):
        self.tri(a, b, c)
        self.tri(a, c, d)
        
    def write_binary_stl(self, filepath: Path, description: str = "Python Generated STL"):
        header = description.encode("ascii")[:80].ljust(80, b"\0")
        with open(filepath, "wb") as f:
            f.write(header)
            f.write(struct.pack("<I", len(self.triangles)))
            for a, b, c in self.triangles:
                # Compute normal
                ux, uy, uz = b[0]-a[0], b[1]-a[1], b[2]-a[2]
                vx, vy, vz = c[0]-a[0], c[1]-a[1], c[2]-a[2]
                nx, ny, nz = uy*vz - uz*vy, uz*vx - ux*vz, ux*vy - uy*vx
                mag = math.sqrt(nx*nx + ny*ny + nz*nz) or 1.0
                f.write(struct.pack("<fff", nx/mag, ny/mag, nz/mag))
                f.write(struct.pack("<fff", *a))
                f.write(struct.pack("<fff", *b))
                f.write(struct.pack("<fff", *c))
                f.write(struct.pack("<H", 0))
```

### Pattern B: Modern B-Rep CAD with `build123d`
When available or installable in virtual environments, `build123d` provides expressive Python CAD with direct STEP and STL export:

```python
from build123d import *

# Parametric modeling with pythonic context managers
with BuildPart() as part:
    Box(100, 60, 20)
    with Locations((0, 0, 10)):
        Hole(radius=3.2) # RP-SMA 6.4mm bulkhead
    fillet(part.edges().filter_by(Axis.Z), radius=3.0)

# Export both mesh and precision B-Rep
export_stl(part.part, "build/enclosure.stl")
export_step(part.part, "build/enclosure.step")
```

---

## 5. Verification & Testing Standards

Every Python CAD generator must be accompanied by a hermetic pytest suite (`tests/test_<component>_mesh.py`) validating:
1. **Watertight Manifoldness**: Every triangle edge must be shared by exactly 2 triangles with opposite winding.
2. **Bounding Box Integrity**: Max and min coordinate extents match specified exterior dimensions within tolerance ($\pm 0.1\text{mm}$).
3. **Positive Volume Calculation**: Signed tetrahedral volume summation $\sum \frac{1}{6}(v_1 \cdot (v_2 \times v_3)) > 0$.
4. **Metadata & Manifest Validation**: Ensure `manifest.json` contains required fields (layer height, print mass estimate, material, bounding dimensions).
