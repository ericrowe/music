---
name: cad-renderer
description: >-
  Headless software rendering engine generating orthographic multi-view technical
  drawings and exploded assemblies from 3D STL CAD models. Activate ONLY for 3D CAD
  modeling or physical hardware projects.
---

# CAD Multi-View Software Renderer Skill

Generates multi-view projection drawings (Front, Top, Right, Isometric, Exploded) from binary STL meshes using a pure Python LookAt depth-buffer engine without external CAD software dependencies.

## Usage

```bash
python3 .agents/skills/cad-renderer/scripts/render_multiview.py <path_to_model.stl>
```
