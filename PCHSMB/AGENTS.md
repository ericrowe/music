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

All current subprojects (`PCHSMB/_Backdrop`, `PCHSMB/_Sideline Screen`) and any future projects created in `PCHSMB/` must strictly adhere to this architectural and delivery standard.
