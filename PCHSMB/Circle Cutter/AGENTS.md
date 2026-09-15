# PCHSMB Circle Cutter — Engineering Guidelines & Agent Instructions

This document governs all AI coding agents (Gemini, Claude Code, OpenAI Codex, Cursor, Windsurf, etc.) working on the **PCHSMB Field Prop Circle Cutter** project.

---

## 1. MANDATORY TOOLING INVARIANT: Pure-Python CAD Engine Only

> [!IMPORTANT]
> **ABSOLUTE PROHIBITION ON EXTERNAL CAD BINARIES:**
> - **NEVER invoke or query `openscad`, FreeCAD, Blender, or external CAD CLI tools.**
> - **NEVER create, edit, or rely on `.scad` or `.FCStd` files in this project.**
> - **The single, authoritative source of truth for all CAD geometry, parametric meshes, topological audits, and 3D rendering in this project is [`generate_circle_cutter.py`](generate_circle_cutter.py).**

### Tooling Architecture
1. **Pure Python Standard Library (`struct`, `math`, `dataclasses`, `pathlib`):**
   All 3D STL geometry is generated mathematically in pure Python.
2. **Headless LookAt 3D Renderer (`render_multiview_sheet`):**
   All orthographic and 3D multi-view drawing sheets are rendered directly in Python using standard image arrays (Pillow / NumPy).
3. **Deterministic Execution:**
   Running `python3 generate_circle_cutter.py` generates all production STLs, test coupons, `build/manifest.json`, and 4-view drawing sheets in seconds with zero external dependencies.

---

## 2. Project Architecture & Component Hierarchy

The **PCHSMB Circle Cutter** is a precision 3D-printable field tool engineered specifically to cut semicircular wind relief slits ($R = 4.0\text{ in.} = 101.6\text{ mm}$) into heavy-duty scrim vinyl for the Pine Creek High School Marching Band (PCHSMB) field props.

The tool uses a modular 4-piece concentric rotating pivot architecture:
1. **Piece 1: Fixed Pivot Base** (`circle_cutter_base.stl`): Stationary center pivot with alignment crosshairs and 608 bearing top post.
2. **Piece 2: Rotating Arm Assembly** (`circle_cutter_arm.stl`): $150\text{ mm}$ radial arm with dual head (625 depth-stop roller bearing and X-Acto #11 blade mount).
3. **Piece 3: Blade Clamping Cap** (`circle_cutter_blade_cap.stl`): M3 rigid clamp plate.
4. **Piece 4: Snap-in Hub Top Cap** (`circle_cutter_hub_cap.stl`): Top cap with 4 flex collet fingers and integrated 608 bearing thrust pocket.

---

## 3. Mandatory Engineering Lifecycle: Idea $\to$ Plan $\to$ Implementation $\to$ Commit

All modifications, additions, and enhancements to this project **MUST** strictly follow the 4-stage engineering workflow:

```
  +------------------+       +------------------+       +------------------+       +------------------+
  |     STAGE 1      |  ==>  |     STAGE 2      |  ==>  |     STAGE 3      |  ==>  |     STAGE 4      |
  |   Idea Intake    |       | Implementation   |       |  Implementation  |       | Structured Git   |
  |   (IDEAS.md)     |       | Plan (Plans/)    |       |  & Verification  |       |     Commit       |
  +------------------+       +------------------+       +------------------+       +------------------+
```

### Stage 1: Idea Intake ([`IDEAS.md`](IDEAS.md))
- Every new feature, ergonomic iteration, or hardware adaptation starts as an entry in [`IDEAS.md`](IDEAS.md).
- Must document:
  1. **Problem Statement:** Clear physical/mechanical limitation observed in practice.
  2. **Proposed Mechanical Concept:** Hardware, geometry, and load-path solution.
  3. **Trade-Off Analysis:** Printability, part count, mass, fastener requirements, and complexity.
  4. **Status:** `Active / Promoted`, `In Progress`, `Implemented`, or `Archived / Closed`.
- Ideas are not implemented directly from the inbox; they must first be promoted to a formal Implementation Plan.

### Stage 2: Implementation Plan ([`Plans/`](Plans/))
- Authored in `Plans/NNN-<title>.md` before touching production Python code.
- Must document:
  1. **Components Affected:** Explicit list of STLs, coupons, and docs.
  2. **Geometric Stackup & Clearance Budget:** Exact mathematical coordinates in world ($Z_{\text{world}}$) and local ($Z_{\text{local}}$) frames.
  3. **Inner vs. Outer Race Isolation:** Bearing load paths must eliminate parasitic rubbing.
  4. **Pre-Print Calibration Coupon Specification:** Fast-printing test coupons to verify critical fits prior to full-scale 3-hour prints.
  5. **Implementation Tasks:** Step-by-step checklist.
  6. **Quality Verification Gates:** Topological, geometric, and documentation acceptance criteria.

### Stage 3: Implementation & Quality Gates ([`generate_circle_cutter.py`](generate_circle_cutter.py))
- Implement geometry changes strictly within `generate_circle_cutter.py`.
- **Four Non-Negotiable Topological Mesh Gates:**
  1. `0` boundary edges (100% watertight 2-manifold solid).
  2. `0` non-manifold edges (no internal faces or t-junctions).
  3. `0` degenerate triangles (zero area / collinear vertices).
  4. `100%` finite coordinates (no `NaN` or `Inf`).
- **Support-Free Printability:** All production parts must print upright or flat with zero supports (all overhangs $\le 45^\circ$).
- **Physical Calibration Invariants:**
  - $Z_{\text{world}} = 0.0\text{ mm}$: Vinyl contact plane.
  - 625 roller bearing touches vinyl at $Z_{\text{world}} = 0.0\text{ mm}$ ($Z_{\text{world, axle}} = 8.0\text{ mm}$).
  - Blade tip extends to $Z_{\text{world}} = -1.0\text{ mm}$ ($1.0\text{ mm}$ cutting depth into vinyl below bearing).
  - Arm bottom floats at $Z_{\text{world}} = 4.0\text{ mm}$ ($4.0\text{ mm}$ clearance above vinyl).
  - Arm bottom maintains $1.0\text{ mm}$ uniform air gap above the $3.0\text{ mm}$ base plate shoulder (eliminating plastic sliding contact).
  - Top-mounted 608 ball bearing carries 100% of operator downward thrust.
- **Documentation Synchronization:**
  - Update [`README.md`](README.md) (BOM, specifications, print guidelines).
  - Update [`PHYSICAL_TEST_NOTES.md`](PHYSICAL_TEST_NOTES.md) (caliper measurement table, HITL notes).
  - Update `build/manifest.json` with topological audit and part masses.
  - Mark the plan in `Plans/` as `Completed & Verified`.

### Stage 4: Structured Git Commit
- Group changes logically into conventional commits (`feat(circle-cutter): ...`, `docs(circle-cutter): ...`).
- Include rationale, geometric parameters, and audit verification results in the commit body.
- Maintain a clean working tree.

---

## 4. Order of Precedence
When working within this subproject:
1. This file (`PCHSMB/Circle Cutter/AGENTS.md`) controls subproject engineering workflow, CAD engine invariants, and lifecycle rules.
2. Active implementation plan in `Plans/` controls dimensional stackup and tasks.
3. Subproject `README.md` and `PHYSICAL_TEST_NOTES.md` record physical ground truth.
4. Repository root `AGENTS.md` controls cross-agent baseline and repository safety.
