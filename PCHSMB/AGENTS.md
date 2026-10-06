# PCHS Marching Band (PCHSMB) — Document Architecture & Engineering Standard

This document establishes the mandatory, universal standard for all Pine Creek High School Marching Band (PCHSMB) prop, equipment, and fabrication manuals.

---

## 1. Universal PCHSMB Document Architecture

Every PCHSMB deliverable manual **must** follow the exact same high-level document structure, regardless of the number of components or specific fabrication materials.

A volunteer, parent crew member, or staff director must be able to open **any** PCHSMB manual and find every common feature (cost breakdowns, 2026 CBA competition rules, safety protocols, ballasting rules, cutting schedules, and purchasing indexes) in the **exact same location**.

```
Master Document (.docx)
├── Global Preamble
│   ├── Document Title & Subtitle
│   ├── Visible Lifecycle Status Marking
│   ├── Version History Table (Version | Date | Status | One-line description)
│   └── Intro / Overview
│       ├── Prop Identity, Scope & Purpose
│       ├── System Geometry & Mechanics
│       ├── Design Attribution & Credits
│       └── Appendix A & B Printing & Separation Standard
│
├── APPENDIX A: Field Operations Manual (Pages A-1, A-2...)
│   ├── Appendix A Cover Page (Kicker, Title, Subtitle, Metadata, Separation Notice)
│   └── Field Operations
│       ├── Roles and Division of Responsibilities (Parents vs Students, 25-wristband rule)
│       ├── Staging, Transport, and Field Gate Entry (Trailer offload, staging chute, timing)
│       ├── Field Deployment and Show Operations (Placement, instrument cradling, cart stowage)
│       ├── Post-Performance Retrieval and Continuous Exit (Collapsing, reload, egress per Rule 8.05)
│       ├── Ballasting System and Wind Safety Protocols (Wing posts, mandatory double-bagging, tube sand)
│       ├── Applicable Marching Band Competition & Prop Rules (Annual Review Notice, Rules 8.05–9.07)
│       └── Post-Use Inspection, Maintenance, and Storage (Teardown inspection, cleaning, trailer packout)
│
└── APPENDIX B: Construction & Fabrication Manual (Pages B-1, B-2...)
    ├── Appendix B Cover Page (Kicker, Title, Subtitle, Metadata, Separation Notice)
    ├── Construction Overview & Bill of Materials
    │   ├── Safety, PPE, and Workspace Preparation
    │   ├── Materials and Component Schedules (Complete BOM table)
    │   ├── Tools, Equipment, and Jigs
    │   ├── 3D-Printed Parts and Fixtures (CAD sources, slicer files, ASA material)
    │   ├── Raw Material Cutting Schedules (Optimized cutting diagrams)
    │   └── Estimated Fabrication Cost Breakdown [MANDATORY FIXED LOCATION]
    │       ├── Table 1: Primary Prop Component (Excluding Vinyl)
    │       ├── Table 2: Secondary / Transport Components
    │       └── Optional Rule 8.05 Ballast Pack
    ├── Component Fabrication & Assembly Procedures
    │   ├── Component 1: [Primary Frame] Assembly (Stages 1–N)
    │   ├── Component 2: [Base / Transport Cart] Assembly (Stages 1–N)
    │   └── Final Construction Inspection Checklist
    ├── Vinyl Graphics & Banner Installation
    │   ├── Surface Preparation & Tape Underlayment
    │   └── Banner Alignment & Mechanical Snap Clamping
    └── Appendix B Index & References
        ├── Purchase Sources (Numbered [1]..[N] with digital links & printed URLs)
        └── Digital Part Files & Governing Rulebooks (Numbered [10]..[N] with repository links)
```

---

## 2. Invariable Placement Rules

1. **Estimated Cost Breakdown:**
   - **MUST ALWAYS** be located in **Appendix B**, immediately following the *Raw Material Cutting Schedules* and immediately preceding the *Component Fabrication & Assembly Procedures*.
   - Never place the cost breakdown at the end of the document, inside Appendix A, or inside the global intro.

2. **2026 CBA Competition & Prop Rules:**
   - **MUST ALWAYS** be located in **Appendix A (Field Operations)**, immediately following the *Ballasting System and Wind Safety Protocols* and immediately preceding *Post-Use Inspection, Maintenance, and Storage*.
   - Must include the prominent `ANNUAL RULEBOOK NOTICE` directing staff to check rules yearly.

3. **Field Operations Workflow Sequence:**
   - Operational sequence must strictly follow real field progression: *Roles* → *Staging & Ingress* → *Deployment & Show Ops* → *Retrieval & Egress* → *Ballasting* → *Competition Rules* → *Post-Use Inspection & Storage*.

4. **Appendix Cover Pages & Pagination:**
   - Appendix A must have its dedicated cover page with all pages running headers `APPENDIX A | OPERATIONS MANUAL` and footer numbering `Page A-#`.
   - Appendix B must have its dedicated cover page with all pages running headers `APPENDIX B | CONSTRUCTION MANUAL` and footer numbering `Page B-#`.

5. **Dual PDF & DOCX Publication & README Linking:**
   - Prior to committing and pushing any documentation update to GitHub, a complete PDF render **MUST** be generated alongside the `.docx` file (using `.agents/skills/develop-versioned-documents/scripts/render_pdf.py`).
   - The subproject `README.md` **MUST** prominently link to the `.pdf` render as the primary recommended format for web/mobile reading, accompanied by a secondary link to the `.docx` editable source.

---

## 3. Subproject Conformity

All current subprojects (`PCHSMB/_Backdrop`, `PCHSMB/_Sideline Screen`, `PCHSMB/_Stages`, `PCHSMB/_Lighting Controller`) and any future projects created in `PCHSMB/` must strictly adhere to this architectural and delivery standard.

### Electronics & Platform Subprojects
- **`PCHSMB/_Lighting Controller/`:** Governed by [`PCHSMB/_Lighting Controller/docs/AGENTS.md`](_Lighting%20Controller/docs/AGENTS.md) and [`REQUIREMENTS.md`](_Lighting%20Controller/docs/REQUIREMENTS.md). Enforces the **Zero-Software & Zero-AI Seasonal Show Reprogramming Mandate** (`REQ-SW-01`), 902–928 MHz Sub-GHz wireless broadcast, 4-channel parallel DMA pixel driving, and COTS power tool battery architectures.

### Fabrication Tooling Subprojects
- **`PCHSMB/Circle Cutter/`:** Governed by [`PCHSMB/Circle Cutter/AGENTS.md`](Circle%20Cutter/AGENTS.md). Enforces the 4-stage engineering lifecycle (**Idea $\to$ Plan $\to$ Implementation $\to$ Commit**) and the **100% Pure-Python CAD Engine** standard (`generate_circle_cutter.py`). External CAD binaries (`openscad`, FreeCAD) are strictly prohibited.

---

## 4. Simulation-First Hardware Feasibility & Photometric Realism Standard

All props, field equipment, lighting designs, and concept imagery developed for PCHS Marching Band must satisfy strict physical fabrication and environmental optics standards. Renders and visual analyses must depict **actual physical hardware buildable by volunteers in the PCHS shop**, never video-game CGI concepts.

### 4.1 Shop Fabrication & Hardware Feasibility Invariants
1. **Material Realism:** All frames, brackets, and structural elements must use standard commercial stock (6061/5052 aluminum tubing/sheet, schedule 40 PVC/EMT conduit, 3D printed PETG/ASA parts, laser-cut acrylic, rotomolded polyethylene).
2. **Power & Electrical Feasibility:** Props must operate from standard commercial power tool battery packs (e.g., Milwaukee M18 or DeWalt 20V) with latched mechanical battery docks, standard step-down buck converters, fused DC distribution, and sub-GHz (915 MHz) wireless control.
3. **Ergonomics & Rigging:** Handheld or field-carried props must include physical handles, balanced grip centers of gravity, and optional quick-release 1.25″ EMT conduit receiver sockets for stage platform mounting.
4. **CBA Rules Compliance:** All designs must comply with Colorado Bandmasters Association (CBA) Rules 8.05–9.07 (non-marking turf contact, no pyrotechnics, zero field damage, rapid < 2 minute ingress/egress).

### 4.2 Environmental Optics & Stadium Photometric Standards
1. **Clean Air Transparency:** Under clear Colorado high-altitude skies (6,500 ft ASL), atmospheric Rayleigh scattering optical depth is negligible ($\mu_s \times L \approx 10^{-6}$). Volumetric light shafts, visible laser cones, and glowing fog in mid-air are unphysical and strictly forbidden.
2. **Daylight Visibility ($90,000\text{ lux}$ sun):** Ambient sunlight produces $\approx 3,438\text{ cd/m}^2$ turf luminance. Prop light spill on synthetic grass is below the Weber JND perception threshold ($1,800\text{ lux}$). Daylight imagery must show natural green turf with **zero ground wash**. Props must rely on physical silhouette, mechanical motion, or bold contrast.
3. **Night Stadium Illumination ($1,000\text{ lux}$ sports lights):** Sports lighting yields $\approx 38.2\text{ cd/m}^2$ background turf luminance. Inverse-square falloff strictly restricts visible ground wash to a **$3\text{–}4\text{ foot}$ radius** ($< 8\text{–}10\text{ pixels}$ from press box viewpoint). Oversized 20-to-30-yard glowing clouds or radioactive green wash on turf are physical hallucinations and prohibited.
4. **Photogrammetric Press Box Scale:** When viewing midfield from Falcon Stadium Press Box ($72.5\text{ m}$ slant range, $14.6^\circ$ elevation):
   - $5\text{ yards} = 15\text{ ft} \approx 33\text{–}46\text{ px}$ depending on render frame width.
   - High school student ($5\text{ ft}$) is $\approx 11\text{–}15\text{ px}$ tall ($\approx 14\text{–}20\text{ px}$ with shako and plume).
   - Props ($12\text{″}$ to $36\text{″}$) are strictly $\mathbf{3\text{ to }7\text{ pixels}}$ in size. Any image showing midfield props as giant glowing objects spanning multiple yards is rejected.


