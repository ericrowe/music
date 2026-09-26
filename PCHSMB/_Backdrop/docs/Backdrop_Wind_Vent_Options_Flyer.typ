#set document(
  title: "PCHSMB Rolling Backdrop — Wind Vent Options Flyer",
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
      align(left)[#text(size: 6.4pt, fill: rgb("#718096"), weight: "bold")[PCHSMB ROLLING BACKDROP — WIND VENT SPECIFICATION FLYER]],
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
      #text(fill: rgb("#e2e8f0"), size: 6.8pt, weight: "bold", tracking: 0.12em)[PINE CREEK HIGH SCHOOL MARCHING BAND — ROLLING BACKDROP FLEET] \
      #v(0.3pt)
      #text(fill: white, size: 12.0pt, weight: "bold")[ROLLING BACKDROP WIND VENT OPTIONS]
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
      #text(weight: "bold", size: 6.8pt, fill: alert-red)[FOUR MANDATORY FABRICATION & SAFETY RULES (APPLIES TO ALL SIZES):]
      #v(0.3pt)
      #text(size: 6.4pt, fill: rgb("#2d3748"))[
        *1. MANDATORY PUNCH FIRST:* Punch two clean 3/8″ (10 mm) round holes at chord endpoints *before* razor cutting to eliminate stress risers ($K_t -> 1.0$) and stop tears.
        *2. TOP CHORD NEVER CUT:* The top horizontal line is the gravity hinge.
        *3. FLOATING FLAP CLEARANCE:* Centerlines may float $plus.minus 6$″ to $12$″ to land in background/negative space; *never* cut across performer faces, logos, or show titles.
        *4. 60″ MID-RAIL STRADDLE:* Flap rows straddle the 60″ mid rail ($Y = 74$″ and $46$″), creating a $24$″ solid vinyl belt across the pipe to prevent chafing or flap jamming.
      ]
    ]
  )
]

#v(2.0pt)

// =========================================================================
// SECTION 1: SIDE-BY-SIDE BACKDROP ELEVATIONS (DIAGRAM)
// =========================================================================
#image("assets/backdrop_vent_elevation_comparison.svg", width: 100%)

#v(1.5pt)

// =========================================================================
// SECTION 2: FLAP GEOMETRY & TOOLING COMPARISON (DIAGRAM)
// =========================================================================
#image("assets/backdrop_vent_flap_detail.svg", width: 100%)

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
  [#text(weight: "bold", size: 6.6pt, fill: navy)[Option 1: 8.0″ Standard\ (8 Flaps / 3-2-3 Staggered)]],
  [#text(weight: "bold", size: 6.6pt, fill: warn-orange)[Option 2A: 6.25″ Can\ (11 Flaps / 4-3-4 Staggered)]],
  [#text(weight: "bold", size: 6.6pt, fill: alert-red)[Option 2B: 6.25″ Can\ (8 Flaps / 2×4 Grid)]],
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
  [Drop/width aspect ratio = 0.50 (zero thermal tip sag)],

  // Row 3: Total Vent Area
  [*Total Vent Area*],
  [*1.40 sq ft* (1.75% face)],
  [*1.17 sq ft* (1.46% face)],
  [0.85 sq ft (1.07% face)],
  [Option 2A preserves target airflow; Option 2B is under-vented],

  // Row 4: Drag Coefficient
  [*Drag Coefficient ($C_d$)*],
  [*$C_d = 1.02$* (-15.0%)],
  [*$C_d = 1.05$* (-12.6%)],
  [$C_d = 1.09$ (-9.2%)],
  [Quincunx patterns prevent vertical shear and matrix effect],

  // Row 5: Forward Tipping Limit
  [*Tier 3 Wind Limit (6.5k′)*],
  [*22.3 mph* (135 lb ballast)],
  [*22.0 mph* (135 lb ballast)],
  [21.9 mph (135 lb ballast)],
  [Both straddled patterns within 0.5 mph of base standard],

  // Row 6: Required Tooling
  [*Cutting Tool / Jig*],
  [PCHSMB Circle Cutter],
  [1-Gal Paint Can Rim],
  [1-Gal Paint Can Rim],
  [Circle Cutter provides 0.5 mm depth stop & rolling blade],

  // Row 7: Workload per Prop
  [*Per-Prop Workload*],
  [8 cuts / 16 punch holes],
  [11 cuts / 22 punch holes],
  [8 cuts / 16 punch holes],
  [Option 1 maintains identical 8 cuts with zero extra labor],

  // Row 8: Fleet Workload
  [*10-Prop Fleet Total*],
  [*80 cuts / 160 holes*],
  [110 cuts / 220 holes],
  [80 cuts / 160 holes],
  [Option 1 saves 30 razor cuts & 60 hammer punches in shop]
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
      #text(weight: "bold", size: 7.0pt, fill: ok-green)[RECOMMENDED: OPTION 1 (8.0″ FLEET STANDARD — 3-2-3)] \
      #v(0.8pt)
      #text(size: 6.3pt, fill: rgb("#2d3748"))[
        - *3-2-3 Staggered Layout:* 8 flaps arranged in a 3-2-3 quincunx ($Y = 96″, 74″, 46″$). Breaks vertical columns with wide 25″–30″ diagonal flap separation.
        - *24″ Solid Mid-Rail Belt:* Row 2 apex is 10″ above 60″ rail; Row 3 hinge is 14″ below. Massive solid vinyl cushion eliminates chafing and vents both 5-ft spans.
        - *Lowest Workload:* 8 cuts per prop (80 total). Fast shop fabrication.
        - *Rotary Cut Quality:* PCHSMB Circle Cutter guarantees clean, notch-free arcs without the burrs or nicks common when tracing metal paint cans.
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
      #text(weight: "bold", size: 7.0pt, fill: warn-orange)[FIELD ALTERNATIVE: OPTION 2 (6.25″ PAINT CAN — 4-3-4)] \
      #v(0.8pt)
      #text(size: 6.3pt, fill: rgb("#2d3748"))[
        - *Harmonized Shop Heights:* Shares exact same row elevations ($96″, 74″, 46″$) as Option 1, making horizontal chalk-line snapping 100% unified across fleet.
        - *Straddled 4-3-4 Pattern:* 11 flaps provide a 25″ solid mid-rail belt, wide flap dispersion, and full 22.0 mph Tier 3 wind safety ($C_d = 1.05$).
        - *Zero-Jig Convenience:* Standard 1-gallon metal paint can traced on site.
        - *Volunteer Effort:* Adds +30 cuts & +60 punches across the 10 props.
      ]
    ]
  ]
)
