# Gemini / Antigravity Instructions — Circle Cutter

This subproject uses [AGENTS.md](AGENTS.md) as the authoritative engineering standard and lifecycle specification.

- **MANDATORY TOOLING INVARIANT:** 100% Pure Python CAD only (`generate_circle_cutter.py`). **NEVER query or use OpenSCAD, FreeCAD, or external CAD tools.**
- **Codified Lifecycle:** Idea (`IDEAS.md`) $\to$ Plan (`Plans/`) $\to$ Implementation (`generate_circle_cutter.py`) $\to$ Structured Git Commit.
- **Pure-Python CAD:** All production STLs and 3D LookAt drawings must be generated deterministically via `generate_circle_cutter.py` and pass all 4 topological gates.
- **Physical Calibration Invariants:** 625 roller touches vinyl at $Z_{\text{world}} = 0$, blade cuts $1.0\text{ mm}$ below bearing, arm bottom floats at $Z_{\text{world}} = 4.0\text{ mm}$ with $1.0\text{ mm}$ air gap above $3.0\text{ mm}$ base plate.
