# Music Fabrication & Band Prop Engineering Repository

This umbrella repository supports independent music fabrication, 3D parametric CAD modeling, and controlled engineering documentation for musical instruments, accessories, and competitive field marching band props.

---

## 🎺 Subprojects Overview

### 1. Pine Creek High School Marching Band (PCHSMB)

Prop engineering, fabrication guides, and volunteer field operations for the Pine Creek High School Marching Band (Colorado Springs, CO):

| Subproject | Description | Key Deliverables & Manuals |
|---|---|---|
| [**2026 Production: *Continuum***](PCHSMB/2026%20Continuum/) | Master competition day field operations guide coordinating all 35 props (16 Duck Blinds, 11 Backdrops, 4 Stages + 4 Staircases). | • [`Continuum_2026_Prop_Operations_Guide.pdf`](PCHSMB/2026%20Continuum/Continuum_2026_Prop_Operations_Guide.pdf) (15 pp)<br>• NFHS High School & NCAA College field coordinate maps & pocket cards<br>• Wind safety NO-GO threshold (>20 mph) & operational weather briefings |
| [**Rolling Backdrops**](PCHSMB/_Backdrop/) | 11 modular 10 ft H × 8 ft W visual displays on heavy-duty 2x4 rolling carts with 60" mid rails and 3/4" iron wing ballast posts. | • [`Backdrop_Assembly_Guide.pdf`](PCHSMB/_Backdrop/docs/Backdrop_Assembly_Guide.pdf) (Release v0 (D9), 28 pp)<br>• Semicircular wind relief flaps ($R=4.0"$, $8" \times 4"$, 8-flap 3-2-3 primary layout)<br>• Frame CAD, drill alignment jigs & substrate trade study (`TS-BDP-2026-02`) |
| [**Sideline Screens ("Duck Blinds")**](PCHSMB/_Sideline%20Screen/) | 16 folding 4 ft H × 8 ft W front sideline concealers in 3/4" EMT conduit; folds coplanar to $< 2.0"$. | • [`Sideline_Screen_Duck_Blind_Build_Instructions.pdf`](PCHSMB/_Sideline%20Screen/docs/Sideline_Screen_Duck_Blind_Build_Instructions.pdf) (Release v0 (D34), 27 pp)<br>• Two-Student Direct Carry protocol (zero carts)<br>• Semicircular wind relief flaps ($R=4.0"$, 6 flaps) & universal corner protectors |
| [**Performance Stages & Staircases**](PCHSMB/_Stages/) | 4 modular rolling performance stages (8 half-units) and 4 mobile staircases with flush 6.0" inter-section gap bridges. | • [`Stage_Platform_Build_Instructions.pdf`](PCHSMB/_Stages/docs/Stage_Platform_Build_Instructions.pdf) (Release v0 (D1), 11 pp)<br>• 6.0" Inter-Section Gap Bridge Analysis (`TR-STG-2026-01`)<br>• Shaded Lighting Scaffolding Pavilion Trade Study (`TS-STG-2026-02`) |
| [**Universal Field Prop Lighting Platform**](PCHSMB/_Lighting%20Controller/) | Enduring, show-agnostic 915 MHz Sub-GHz wireless lighting control ecosystem (Synapse Pit Master Console & Peripheral Prop Nodes). | • Systems Requirements ([`REQUIREMENTS.md`](PCHSMB/_Lighting%20Controller/docs/REQUIREMENTS.md)) & Schematics ([`CARRIER_BOARD_SCHEMATICS.md`](PCHSMB/_Lighting%20Controller/docs/CARRIER_BOARD_SCHEMATICS.md))<br>• KiCad carrier boards, Pilot & 30-Prop BOM Guides, & zero-code CSV show workflow<br>• HTML5 Field Show Simulator & Prop Power Calculator |
| [**Technical Reports & Concept Planning**](PCHSMB/TECHNICAL_REPORTS_REGISTRY.md) | Master engineering registry (`TR`/`TS`/`SPEC`/`DIR`), 2027 Prop Ecosystem Executive Menu, and Director's Briefing Deck. | • [`TECHNICAL_REPORTS_REGISTRY.md`](PCHSMB/TECHNICAL_REPORTS_REGISTRY.md)<br>• [`PCHSMB/docs/`](PCHSMB/docs/) |
| **Legacy & Research** | Historical show props, mechanical flag launchers, and kinetic mechanisms. | • [`PCHSMB/2023 Firebird/`](PCHSMB/2023%20Firebird/), [`2024 Medusa/`](PCHSMB/2024%20Medusa/), [`2025 Valkyrie/`](PCHSMB/2025%20Valkyrie/)<br>• [`PCHSMB/Experiments/Flag Launcher/`](PCHSMB/Experiments/Flag%20Launcher/) & [`Kinetics/`](PCHSMB/Experiments/Kinetics/) |

---

### 2. Instrument Accessories & Workshop Projects

| Project | Description | Primary Materials / Formats |
|---|---|---|
| [**Standcessories**](Standcessories/) | Stand-mounted accessories (mute holders, pencil clips, tablet mounts) engineered for Manhasset #48 music stands. | FreeCAD (`.FCStd`), 3MF slicer files, Black PETG/PLA |
| [**Trumpet**](Trumpet/) | Trumpet mutes (straight, cup, practice), Jo-Ral mute replacement caps, mouthpiece holders, and lyres. | FreeCAD (`.FCStd`), 3MF slicer files, 3D printed acoustics |
| [**Flutes**](Flutes/) | Wall mounts, display fixtures, and stands for Native American and concert flutes. | FreeCAD (`.FCStd`), 3MF slicer files |
| [**Baritone**](Baritone/) & [**Horn**](Horn/) | Replacement valve finger buttons and instrument-mounted pencil clips. | FreeCAD (`.FCStd`), 3MF slicer files, STL meshes |
| [**Luggage Tags**](Luggage%20Tags/) | Personalized, durable instrument case luggage tags. | 3D printed TPU (flexible) |

---

## 📐 Repository Standards & AI Agent Guidelines

Authoritative engineering and documentation rules are codified in:
- [**`AGENTS.md`**](AGENTS.md): Universal cross-agent architecture, document registries, and cross-project synchronization rules.
- [**`GEMINI.md`**](GEMINI.md): Antigravity / Gemini CLI adapter.
