---
name: cad-openscad
description: Parametric 3D modeling, CSG geometry, and STL generation using OpenSCAD (.scad). Defines use-case evaluation criteria, design patterns, and CLI rendering.
---

# OpenSCAD 3D Modeling & STL Generation Skill

## 1. Dual CAD Architecture Invariant

In the **Server Rack** master workspace, **both OpenSCAD and Python-based STL generation are fully supported and approved engineering pathways** for physical components, rack brackets, sensor mounts, and 3D printable enclosures.

> [!IMPORTANT]
> **Use Case Evaluation Rule**: Neither approach is universally superior. Before creating physical 3D models or enclosures, evaluate the specific project requirements against the **Decision Matrix** below to select the appropriate toolchain.

---

## 2. Decision Matrix: When to Choose OpenSCAD

| Criterion | Choose OpenSCAD (`.scad`) | Choose Python CAD (`.py`) |
| :--- | :--- | :--- |
| **Primary Workflow** | Rapid visual iteration and live preview in the OpenSCAD GUI / Customizer. | Headless, programmatic, or batch generation without installing external desktop GUI apps. |
| **Geometric Paradigm** | Constructive Solid Geometry (CSG): boolean unions, differences, intersections, hull, and minkowski sums. | Boundary Representation (B-Rep), algorithmic lofts, procedural sweeping, or direct mesh math. |
| **Ecosystem & Libraries** | Leveraging mature open-source 3D printing ecosystems: **Gridfinity Rebuilt**, **BOSL2**, **NopSCADlib**, or Printables/Thingiverse customizers. | Custom standalone mathematical geometries or tight coupling with web APIs and databases. |
| **Dependencies** | Pure `.scad` text file; zero Python package dependencies required in virtual environments. | Pure Python script (zero external binaries) or `build123d`/`cadquery`/`trimesh` packages. |
| **Automated Testing** | Parameter schema validation, regex syntax checks, and CLI export via `openscad -o model.stl model.scad`. | Direct unit testing in `pytest` of triangle counts, bounding boxes, volume, manifoldness, and tolerances. |
| **Coupled Metadata** | Enclosure markdown specification (`WALL_MOUNT_SPEC.md`) maintained alongside `.scad`. | Dynamic generation of `manifest.json`, BOM pricing calculations, and mass estimates in one execution. |
| **CAD Interchange** | STL, 3MF, DXF, and CSG export. | STL, 3MF, and native **STEP AP214/AP242** for CNC CAM toolpaths (via `build123d`). |

### Recommended Use Cases for OpenSCAD:
1. **Wall, Rack, and Sensor Enclosures**: Housings with standard rectangular/cylindrical envelopes, PCB standoffs, port cutouts (USB-C, RJ45, SMA), convective vents, and snap-fit lids (e.g. `Garage-Fleet-Telemetry/hardware/enclosure/gateway_enclosure.scad`).
2. **Standard Modular Storage Systems**: Gridfinity bins, tool holders, and modular cassette adapters based on existing open-source SCAD community libraries.
3. **Mechanical Mounting Brackets**: 2U rack ears, DIN-rail clips, and camera swivel mounts where live visual angle adjustment and customizer parameter sliders accelerate design.

---

## 3. Directory Layout & File Organization

Organize OpenSCAD assets within the relevant subsystem's `hardware/` directory:

```
<project>/hardware/
├── enclosure/ (or cad/ / 3d/)
│   ├── WALL_MOUNT_SPEC.md        # Authoritative mechanical & thermal engineering specification
│   ├── gateway_enclosure.scad     # Primary parametric OpenSCAD source file
│   └── modules/                   # Optional reusable submodules (vents, standoffs, connectors)
│       ├── standoffs.scad
│       └── connectors.scad
└── tests/
    └── test_enclosure_spec.py    # Hermetic pytest suite validating dimensions & parameters
```

---

## 4. OpenSCAD Engineering & Design Standards

### 4.1. Parameterization Block
Always define all tunable mechanical, electrical, and slicer parameters at the top of the file:

```openscad
// ==============================================================================
// Component Title & Purpose
// Material: PETG (Heat deflection > 70°C for unconditioned environments)
// ==============================================================================

$fn = 40; // Smooth curve resolution (use $fn=20 for draft preview, $fn=60+ for final render)

// Dimensional Parameters (All units in millimeters)
wall_thickness    = 2.4;   // Minimum 4 perimeters with 0.4mm nozzle
floor_thickness   = 2.4;

// PCB Envelopes & Component Tolerances
pcb_length        = 52.0;
pcb_width         = 28.0;
pcb_height        = 12.0;
tolerance         = 0.25;  // Standard FDM slip-fit tolerance
```

### 4.2. Modular Decomposition
Structure code into distinct, reusable modules for clear hierarchy and isolated testing:
- **Base module**: `component_base()`
- **Lid module**: `component_lid()`
- **Feature cutouts**: `port_cutout()`, `vent_slots()`, `keyhole_slot()`, `sma_bulkhead()`

### 4.3. Manifold Geometry & Coincident Face Guard
> [!CAUTION]
> **Zero Coincident Faces**: In CSG operations, overlapping faces with identical coordinates produce zero-thickness non-manifold artifacts that cause slicer errors.
> **Rule**: Always extend cutout bodies by $\pm 0.1\text{mm}$ to $\pm 1.0\text{mm}$ beyond the boundary of the subtracted body:

```openscad
// Correct: Cutout extends beyond outer surfaces
difference() {
    cube([outer_length, outer_width, outer_height]);
    translate([wall_thickness, wall_thickness, floor_thickness])
        cube([cavity_length, cavity_width, outer_height + 1.0]); // +1.0 ensures clean top opening
}
```

### 4.4. FDM Printability Invariants
1. **$45^\circ$ Rule**: Design internal chamfers and overhangs at $\le 45^\circ$ from vertical to print without support structures.
2. **Keyhole Mounting Slots**: Standardize on dual keyhole slots with $60\text{mm}$ spacing for #6 or #8 drywall screws.
3. **Corner Stress Relief**: Apply internal fillets ($r \ge 1.0\text{mm}$) to inner corners to eliminate stress concentration and layer delamination.
4. **Thermal Dissipation**: Include angled convective louvers or vent slots for active electronics deployed in warm or unconditioned spaces.

---

## 5. Verification & Testing Protocol

### 5.1. Automated Pytest Verification
Validate OpenSCAD files hermetically without requiring external OpenSCAD CLI installation:
- Verify file existence and path resolution.
- Parse parameter names (`wall_thickness`, `sma_diameter`, `pcb_width`, `keyhole_spacing`).
- Verify required modules are declared (`gateway_base`, `gateway_lid`, etc.).
- Ensure linked documentation (`WALL_MOUNT_SPEC.md`) matches defined CAD dimensions.

### 5.2. Command-Line STL Generation (Optional / CI)
When OpenSCAD is available in the environment:

```bash
# Render to binary STL
openscad -o build/enclosure.stl hardware/enclosure/gateway_enclosure.scad

# Render 3D preview PNG
openscad -o build/preview.png --imgsize=1024,768 --colorscheme=Tomorrow hardware/enclosure/gateway_enclosure.scad
```
