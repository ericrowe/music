---
name: mesh-auditor
description: >-
  Inspect 3D CAD/STL models for boundary edges, non-manifold geometry, degenerate
  triangles, and coordinate bounds. Activate ONLY when auditing 3D STL meshes in hardware/CAD projects.
---

# 3D Mesh Topological Auditor Skill

Audits binary STL files for 3D printability and manufacturing compliance:
- 0 boundary edges (watertight/closed surface)
- 0 non-manifold edges (exactly 2 faces share each edge)
- Coordinate finiteness & bounding box measurements

## Usage

```bash
python3 .agents/skills/mesh-auditor/scripts/audit_stl.py <path_to_model.stl>
```
