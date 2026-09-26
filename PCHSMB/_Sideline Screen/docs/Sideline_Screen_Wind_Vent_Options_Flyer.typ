#set document(
  title: "PCHSMB Sideline Screen — Wind Vent Options Flyer",
  author: "Pine Creek Band Prop Crew",
  date: auto,
)

// One-Page Flyer Layout (US Letter Portrait)
#set page(
  paper: "us-letter",
  margin: (x: 0.35in, top: 0.28in, bottom: 0.28in),
  header: none,
  footer: [
    #line(length: 100%, stroke: 0.4pt + rgb("#cbd5e0"))
    #v(1.0pt)
    #grid(
      columns: (1.5fr, 1.2fr, 1fr),
      align(left)[#text(size: 6.4pt, fill: rgb("#718096"), weight: "bold")[PCHSMB SIDELINE SCREEN / DUCK BLIND — WIND VENT FLYER]],
      align(center)[#text(size: 6.4pt, fill: rgb("#718096"))[*Release v0 (D1)* | September 2026 | Technical Spec Reference]],
      align(right)[#text(size: 6.4pt, fill: rgb("#718096"), weight: "bold")[Page 1 of 1 (Printable Field Flyer)]]
    )
  ]
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 7.2pt,
  fill: rgb("#1a202c"),
)

#set par(justify: false, leading: 0.38em)

// Color Palette
#let navy = rgb("#1a365d")
#let dark-blue = rgb("#2b6cb0")
#let light-blue = rgb("#ebf8ff")
#let border-blue = rgb("#bee3f8")
#let alert-red = rgb("#c53030")
#let alert-bg = rgb("#fff5f5")
#let alert-border = rgb("#feb2b2")
#let warn-orange = rgb("#c05621")
#let warn-bg = rgb("#fffaf0")
#let warn-border = rgb("#fbd38d")
#let ok-green = rgb("#22543d")
#let ok-bg = rgb("#f0fff4")
#let ok-border = rgb("#9ae6b4")
#let gray-border = rgb("#cbd5e0")
#let gray-bg = rgb("#f8fafc")

// =========================================================================
// HEADER BANNER
// =========================================================================
#rect(
  width: 100%,
  fill: navy,
  radius: (top: 3pt, bottom: 0pt),
  inset: (x: 8pt, y: 4.0pt),
)[
  #grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    [
      #text(fill: rgb("#e2e8f0"), size: 6.8pt, weight: "bold", tracking: 0.12em)[PINE CREEK HIGH SCHOOL MARCHING BAND — SIDELINE SCREEN FLEET (16 UNITS)] \
      #v(0.3pt)
      #text(fill: white, size: 12.0pt, weight: "bold")[SIDELINE SCREEN (DUCK BLIND) WIND VENT OPTIONS]
    ],
    [
      #box(
        fill: rgb("#2b6cb0"),
        radius: 3pt,
        inset: (x: 6pt, y: 2.5pt),
        stroke: 0.5pt + rgb("#63b3ed"),
        text(fill: white, size: 6.6pt, weight: "bold")[
          FABRICATION TRADE STUDY \
          8.0″ Standard vs. 6.25″ Paint Can
        ]
      )
    ]
  )
]

// =========================================================================
// CRITICAL RULES BANNER
// =========================================================================
#rect(
  width: 100%,
  fill: alert-bg,
  stroke: (left: 3.5pt + alert-red, rest: 0.4pt + alert-border),
  radius: (top: 0pt, bottom: 3pt),
  inset: (x: 6pt, y: 3.0pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 5pt,
    align: (top, left),
    [
      #text(size: 8.5pt)[⚠️]
    ],
    [
      #text(weight: "bold", size: 6.8pt, fill: alert-red)[THREE MANDATORY FABRICATION & SAFETY RULES (APPLIES TO ALL SIZES):]
      #v(0.3pt)
      #text(size: 6.4pt, fill: rgb("#2d3748"))[
        *1. MANDATORY PUNCH FIRST:* Punch two clean 3/8″ (10 mm) round holes at chord endpoints *before* razor cutting to eliminate stress risers ($K_t -> 1.0$) and stop tears.
        *2. TOP CHORD NEVER CUT:* The top horizontal line is the gravity hinge.
        *3. EQUIPMENT CONCEALMENT (18″ BUFFER):* All cuts *must* terminate at or above $Y = 20.0$″ ($10$″ buffer above floor equipment at $Y <= 10$″). *Never* cut in lower 18″ zone or cross Rail 3 arm clips!
      ]
    ]
  )
]

#v(2.0pt)

// =========================================================================
// SECTION 1: SIDE-BY-SIDE SCREEN ELEVATIONS (DIAGRAM)
// =========================================================================
#image("assets/sideline_screen_elevation_comparison.svg", width: 100%)

#v(1.5pt)

// =========================================================================
// SECTION 2: FLAP GEOMETRY & TOOLING COMPARISON (DIAGRAM)
// =========================================================================
#image("assets/sideline_screen_flap_detail.svg", width: 100%)

#v(1.5pt)

// =========================================================================
// SECTION 3: HEAD-TO-HEAD SPECIFICATION & WORKLOAD TABLE
// =========================================================================
#table(
  columns: (1.25fr, 1.15fr, 1.15fr, 1.15fr, 1.6fr),
  align: (left + horizon, center + horizon, center + horizon, center + horizon, left + horizon),
  stroke: 0.35pt + gray-border,
  inset: (x: 3.2pt, y: 1.8pt),
  fill: (col, row) => {
    if row == 0 { rgb("#edf2f7") }
    else if calc.even(row) { rgb("#f8fafc") }
    else { white }
  },
  [#text(weight: "bold", size: 6.6pt, fill: navy)[Specification / Metric]],
  [#text(weight: "bold", size: 6.6pt, fill: navy)[Option 1: 8.0″ Standard\ (6 Flaps / 2×3 Grid)]],
  [#text(weight: "bold", size: 6.6pt, fill: warn-orange)[Option 2A: 6.25″ Can\ (8 Flaps / 2×4 Grid)]],
  [#text(weight: "bold", size: 6.6pt, fill: alert-red)[Option 2B: 6.25″ Can\ (6 Flaps / 2×3 Grid)]],
  [#text(weight: "bold", size: 6.6pt, fill: navy)[Engineering Impact / Volunteer Notes]],

  // Row 1: Cut Profile
  [*Flap Dimensions*],
  [8.0″ W × 4.0″ Drop],
  [6.25″ W × 3.125″ Drop],
  [6.25″ W × 3.125″ Drop],
  [6.25″ yields 39% less vent area per flap than 8.0″ standard],

  // Row 2: Single Flap Area
  [*Area Per Flap*],
  [25.13 sq in. (0.175 sq ft)],
  [15.34 sq in. (0.106 sq ft)],
  [15.34 sq in. (0.106 sq ft)],
  [Both maintain $D/W = 0.50$ (zero thermal droop in heat)],

  // Row 3: Total Vent Area & Porosity
  [*Total Vent Area (Porosity)*],
  [*1.05 sq ft* (3.43% face)],
  [*0.85 sq ft* (2.79% face)],
  [0.64 sq ft (2.09% face)],
  [Option 1 clears 3.0% aerodynamic threshold; 2B is under-vented],

  // Row 4: Drag Coefficient
  [*Drag Coefficient ($C_d$)*],
  [*$C_d = 1.02$* (-15.0%)],
  [*$C_d = 1.03$* (-14.2%)],
  [$C_d = 1.09$ (-9.2%)],
  [8-flap grid restores drag relief; 6 paint can cuts degrade drag],

  // Row 5: Turf Sliding Limit
  [*Tier 1 Sliding Limit (6.5k′)*],
  [*17.8 mph* (2× 15-lb bags)],
  [*17.8 mph* (2× 15-lb bags)],
  [17.3 mph (2× 15-lb bags)],
  [Primary failure mode on turf; Option 2B loses -0.5 mph margin],

  // Row 6: Equipment Concealment
  [*Floor Prop Buffer ($Y <= 10″$)*],
  [*10.0″ opaque buffer*],
  [*10.9″ opaque buffer*],
  [10.9″ opaque buffer],
  [All cuts terminate above $Y = 20″$; hides guard rifles/sabres],

  // Row 7: Workload per Screen
  [*Per-Screen Workload*],
  [6 cuts / 12 punch holes],
  [8 cuts / 16 punch holes],
  [6 cuts / 12 punch holes],
  [Option 2A requires *+2 cuts and +4 punches* per screen],

  // Row 8: Fleet Workload (16 Screens)
  [*16-Screen Fleet Total*],
  [*96 cuts / 192 holes*],
  [128 cuts / 256 holes],
  [96 cuts / 192 holes],
  [Option 1 saves 32 razor cuts & 64 hammer punches across fleet]
)

#v(2.0pt)

// =========================================================================
// SECTION 4: RECOMMENDATIONS & VERDICT BOX
// =========================================================================
#grid(
  columns: (1fr, 1fr),
  gutter: 6pt,
  [
    #rect(
      width: 100%,
      fill: ok-bg,
      stroke: 0.6pt + ok-border,
      radius: 3pt,
      inset: (x: 6pt, y: 3.5pt),
    )[
      #text(weight: "bold", size: 7.0pt, fill: ok-green)[RECOMMENDED: OPTION 1 (8.0″ FLEET STANDARD)] \
      #v(0.8pt)
      #text(size: 6.3pt, fill: rgb("#2d3748"))[
        - *Program-Wide Tooling Unity:* Shares 100% tooling with 10 Rolling Backdrops.
        - *Lowest Workload:* 6 cuts per screen (96 total across 16 screens). Fast build.
        - *Optimal 3.43% Porosity:* Provides proven 17.8 mph turf sliding resistance.
        - *Hinged Arm Clip Relief:* Reduces tensile pull on 3D-printed Rail 3 clips (*I*) from 33.9 to 28.8 lbs per clip at 20 mph, preventing unseating.
      ]
    ]
  ],
  [
    #rect(
      width: 100%,
      fill: warn-bg,
      stroke: 0.6pt + warn-border,
      radius: 3pt,
      inset: (x: 6pt, y: 3.5pt),
    )[
      #text(weight: "bold", size: 7.0pt, fill: warn-orange)[FIELD ALTERNATIVE: OPTION 2 (6.25″ PAINT CAN)] \
      #v(0.8pt)
      #text(size: 6.3pt, fill: rgb("#2d3748"))[
        - *Zero-Jig Convenience:* Standard 1-gallon metal paint can traced on site.
        - *Must Use 2×4 Grid (Option 2A):* *Never use 3 rows* on screens (violates 18″ concealment zone). 8 cuts in 2 rows of 4 harmonizes with backdrops.
        - *Do Not Cut 6 Flaps:* 6 paint can cuts gives only 2.09% porosity, losing $-0.5$ mph sliding resistance (slips at 15.6 mph at sea level).
        - *Volunteer Effort:* Adds +32 cuts & +64 punches across the 16 screens.
      ]
    ]
  ]
)
