# Music Fabrication & Band Prop Engineering Repository

This umbrella repository supports independent music fabrication, 3D parametric CAD modeling, and controlled engineering documentation for musical instruments, accessories, and competitive field marching band props.

---

## 🎺 Subprojects Overview

### 1. Pine Creek High School Marching Band (PCHSMB)

Prop engineering, fabrication guides, and volunteer field operations for the Pine Creek High School Marching Band (Colorado Springs, CO):

| Subproject | Description | Key Deliverables & Manuals |
|---|---|---|
| [**2026 Production: *Continuum***](PCHSMB/2026%20Continuum/) | Master competition day field operations guide coordinating all 34 props (16 Duck Blinds, 10 Backdrops, 4 Stages). | • [`Continuum_2026_Prop_Operations_Guide.pdf`](PCHSMB/2026%20Continuum/Continuum_2026_Prop_Operations_Guide.pdf)<br>• Wind safety NO-GO threshold (>20 mph)<br>• Printable volunteer job cards |
| [**Rolling Backdrops**](PCHSMB/_Backdrop/) | 10 modular 10 ft H × 8 ft W visual displays on heavy-duty 2x4 rolling carts with 3/4" iron wing ballast posts. | • [`Backdrop_Assembly_Guide.pdf`](PCHSMB/_Backdrop/docs/Backdrop_Assembly_Guide.pdf) (Release v0 (D5), 28 pp)<br>• Semicircular wind relief flaps ($R=4.0"$, $8" \times 4"$, 8-flap primary / 6-flap minimal)<br>• Frame CAD & drill alignment jigs |
| [**Sideline Screens ("Duck Blinds")**](PCHSMB/_Sideline%20Screen/) | 16 folding 4 ft H × 8 ft W front sideline concealers in 3/4" EMT conduit; folds coplanar to $< 2.0"$. | • [`Sideline_Screen_Duck_Blind_Build_Instructions.pdf`](PCHSMB/_Sideline%20Screen/docs/Sideline_Screen_Duck_Blind_Build_Instructions.pdf) (Release v0 (D31), 25 pp)<br>• Two-Student Direct Carry protocol (zero carts)<br>• Semicircular wind relief flaps ($R=4.0"$, 6 flaps) |
| [**Field Prop Circle Cutter**](PCHSMB/Circle%20Cutter/) | Parametric 5-piece 3D printable tool for precision semicircular wind relief slit cutting in vinyl. | • Pure-Python CAD generator [`generate_circle_cutter.py`](PCHSMB/Circle%20Cutter/generate_circle_cutter.py)<br>• #11 scalpel blade & dual 608 ball bearings<br>• Canted symmetric chevron head & domed push knob |
| **Legacy & Research** | Historical props and pneumatic launch experiments. | • [`PCHSMB/2023 Firebird/`](PCHSMB/2023%20Firebird/)<br>• [`PCHSMB/Experiments/Flag Launcher/`](PCHSMB/Experiments/Flag%20Launcher/) |

---

### 2. Instrument Accessories & Workshop Projects

| Project | Description | Primary Materials / Formats |
|---|---|---|
| [**Standcessories**](Standcessories/) | Stand-mounted accessories (mute holders, pencil clips, tablet mounts) engineered for Manhasset #48 music stands. | FreeCAD (`.FCStd`), 3MF slicer files, Black PETG/PLA |
| [**Trumpet**](Trumpet/) | Trumpet mutes (straight, cup, practice), Jo-Ral mute replacement caps, mouthpiece holders, and lyres. | FreeCAD (`.FCStd`), 3MF slicer files, 3D printed acoustics |
| [**Flutes**](Flutes/) | Wall mounts and display fixtures for Native American flutes. | FreeCAD (`.FCStd`), 3MF slicer files |
| [**Luggage Tags**](Luggage%20Tags/) | Personalized, durable instrument case luggage tags. | 3D printed TPU (flexible) |

---

## 📐 Repository Standards & AI Agent Guidelines

Authoritative engineering and documentation rules are codified in:
- [**`AGENTS.md`**](AGENTS.md): Universal cross-agent architecture, document registries, and cross-project synchronization rules.
- [**`GEMINI.md`**](GEMINI.md): Antigravity / Gemini CLI adapter.
