#set document(
  title: "Pine Creek High School Marching Band — 2026 Continuum Wind Safety Poster (Derated)",
  author: "PCHS Prop & Field Operations Crew",
  date: auto,
)

// One-Page Poster Layout Geometry (US Letter Portrait)
#set page(
  paper: "us-letter",
  margin: (x: 0.44in, top: 0.35in, bottom: 0.52in),
  header: none,
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    #v(1.5pt)
    #grid(
      columns: (1.5fr, 1.2fr, 1fr),
      align(left)[#text(size: 6.8pt, fill: rgb("#718096"), weight: "bold")[PCHSMB 2026 CONTINUUM — DERATED SAFETY PROTOCOL]],
      align(center)[#text(size: 6.8pt, fill: rgb("#718096"))[*Release v0 (D2)* | September 2026 | Colorado Springs (6,500' ASL)]],
      align(right)[#text(size: 6.8pt, fill: rgb("#718096"), weight: "bold")[Page 1 of 1 (Printable Field Poster)]]
    )
  ]
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 8.2pt,
  fill: rgb("#1a202c"),
)

#set par(justify: false, leading: 0.48em)

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
#let gray-bg = rgb("#f7fafc")

// Component: Badge
#let status-badge(text-str, bg-col, text-col, border-col) = {
  box(
    fill: bg-col,
    stroke: 0.75pt + border-col,
    radius: 3pt,
    inset: (x: 4.5pt, y: 2.2pt),
    outset: 0pt,
    baseline: 0%,
    text(weight: "bold", size: 7.2pt, fill: text-col)[#text-str]
  )
}

// =========================================================================
// HEADER BLOCK (WITH DERATED HIGHLIGHT)
// =========================================================================
#rect(
  width: 100%,
  fill: navy,
  radius: (top: 4pt, bottom: 0pt),
  inset: (x: 9pt, y: 5.5pt),
)[
  #grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    [
      #text(fill: rgb("#e2e8f0"), size: 7.8pt, weight: "bold", tracking: 0.12em)[PINE CREEK HIGH SCHOOL MARCHING BAND] \
      #v(0.5pt)
      #text(fill: white, size: 13.5pt, weight: "bold")[2026 CONTINUUM — WIND SAFETY & BALLAST POSTER]
    ],
    [
      #box(
        fill: rgb("#c05621"),
        radius: 3pt,
        inset: (x: 6.5pt, y: 3.5pt),
        stroke: 0.5pt + rgb("#fbd38d"),
        text(fill: white, size: 7.2pt, weight: "bold")[
          DERATED SPECIFICATION \
          Solid Unvented Vinyl ($C_d = 1.20$) — Pre-Cut
        ]
      )
    ]
  )
]

// =========================================================================
// CORE PROGRAM PHILOSOPHY CALLOUT
// =========================================================================
#rect(
  width: 100%,
  fill: light-blue,
  stroke: (left: 3.5pt + dark-blue, rest: 0.75pt + border-blue),
  radius: 0pt,
  inset: (x: 8.5pt, y: 4.2pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 7pt,
    align: (top, left),
    [
      #text(size: 10.5pt)[🛡️]
    ],
    [
      #text(weight: "bold", size: 7.8pt, fill: navy)[CORE PROGRAM PHILOSOPHY:]
      #v(0.5pt)
      #text(size: 7.4pt, style: "italic", fill: rgb("#2d3748"))[
        "The focus is always on the students' performance, not the props. Props exist strictly to support and enhance the visual spectacle of the students' musicianship and marching. If conditions become hazardous or timing breaks down, props are abandoned or held back without hesitation. Nothing we do on the prop crew will ever compromise a student's safety or their competitive show."
      ]
    ]
  )
]

// =========================================================================
// DERATING RULE MANDATE BANNER
// =========================================================================
#rect(
  width: 100%,
  fill: warn-bg,
  stroke: (left: 3.5pt + warn-orange, rest: 0.75pt + warn-border),
  radius: (top: 0pt, bottom: 3pt),
  inset: (x: 8.5pt, y: 3.8pt),
)[
  #text(weight: "bold", size: 7.6pt, fill: warn-orange)[⚠️ TEMPORARY PRE-CUT OPERATIONAL DE-RATING RULE:]
  #text(size: 7.2pt, fill: rgb("#744210"))[
    Without wind relief cuts, props operate with 100% solid unvented vinyl ($C_d = 1.20$, +17.6% drag and overturning force). *Wind regimes are derated to safe aeromechanical limits: Tier 4 Safety Abort is set at 16 mph sustained / 20 mph gusts (vs 20/25 mph standard), and Duck Blind Tier 0 ballasting is increased to 2 bags (30 lb).*
  ]
]

#v(2pt)

// =========================================================================
// MASTER TIERED WIND & BALLASTING MATRIX (DERATED)
// =========================================================================
#text(weight: "bold", size: 9pt, fill: navy)[
  DERATED FIELD PROP WIND TIERS & BALLASTING SCHEDULE (35 PROPS)
]
#v(1pt)

#table(
  columns: (1.05fr, 0.72fr, 0.72fr, 1.85fr, 2.05fr, 1.05fr),
  align: (left + horizon, center + horizon, center + horizon, left + horizon, left + horizon, center + horizon),
  stroke: 0.4pt + gray-border,
  inset: (x: 3.8pt, y: 2.6pt),
  fill: (col, row) => {
    if row == 0 { rgb("#edf2f7") }
    else if row == 5 { rgb("#fff5f5") }
    else if calc.even(row) { rgb("#f8fafc") }
    else { white }
  },
  [#text(weight: "bold", size: 7.6pt, fill: navy)[Operational Tier]],
  [#text(weight: "bold", size: 7.6pt, fill: navy)[Sustained Wind]],
  [#text(weight: "bold", size: 7.6pt, fill: navy)[Peak Gusts]],
  [#text(weight: "bold", size: 7.6pt, fill: navy)[Sideline Screens (16 Props)\ #text(size: 6.4pt, weight: "regular", fill: rgb("#4a5568"))[Duck Blinds — Front Sideline]]],
  [#text(weight: "bold", size: 7.6pt, fill: navy)[Rolling Backdrops (11 Props)\ #text(size: 6.4pt, weight: "regular", fill: rgb("#4a5568"))[Backfield Carts — 80 sq ft Sail]]],
  [#text(weight: "bold", size: 7.6pt, fill: navy)[Decision Status]],

  // Tier 0
  [
    #text(weight: "bold", size: 7.8pt)[⚪ Tier 0] \
    #text(size: 6.6pt, fill: rgb("#4a5568"))[Calm Conditions]
  ],
  [*0 – 6 mph*],
  [$<= 8$ mph],
  [
    *2 bags (30 lb)* flat on rear rail C \
    #text(size: 6.4pt, fill: rgb("#c05621"), weight: "bold")[Increased to 2 bags (16/side, 32 fleet)]
  ],
  [
    *0 bags* (153 lb dry cart) \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Safe gust limit: 13.3 mph; Fleet: 0 bags]
  ],
  [#status-badge("GO (Calm)", ok-bg, ok-green, ok-border)],

  // Tier 1
  [
    #text(weight: "bold", size: 7.8pt, fill: ok-green)[🟢 Tier 1] \
    #text(size: 6.6pt, fill: rgb("#4a5568"))[Normal Breeze]
  ],
  [*6 – 10 mph*],
  [$<= 12$ mph],
  [
    *2 bags (30 lb)* flat on rear rail C \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Fleet: 32 bags total (16 bags / wagon)]
  ],
  [
    *4 bags (60 lb: 2 per wing post)* \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Safe gust limit: 15.6 mph; Fleet: 44 bags]
  ],
  [#status-badge("GO (Normal)", ok-bg, ok-green, ok-border)],

  // Tier 2
  [
    #text(weight: "bold", size: 7.8pt, fill: warn-orange)[🟡 Tier 2] \
    #text(size: 6.6pt, fill: rgb("#4a5568"))[Advisory Gusts]
  ],
  [*10 – 14 mph*],
  [$<= 16$ mph],
  [
    *3 bags (45 lb)* flat on rear rail C \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Fleet: 48 bags total (24 bags / wagon)]
  ],
  [
    *6 bags (90 lb: 3 per wing post)* \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Safe gust limit: 17.0 mph; Fleet: 66 bags]
  ],
  [#status-badge("GO (Advisory)", warn-bg, warn-orange, warn-border)],

  // Tier 3
  [
    #text(weight: "bold", size: 7.8pt, fill: warn-orange)[🟠 Tier 3] \
    #text(size: 6.6pt, fill: rgb("#4a5568"))[High-Wind Limit]
  ],
  [*14 – 16 mph*],
  [$<= 20$ mph],
  [
    *4 bags (60 lb)* flat on rear rail C \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Fleet: 64 bags total (32 bags / wagon)]
  ],
  [
    *9 bags (135 lb total):* \
    6 on wing posts + *3 flat on rear rail* \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Safe gust limit: 20.8 mph; Fleet: 99 bags]
  ],
  [#status-badge("CAUTION (High-Wind)", warn-bg, warn-orange, warn-border)],

  // Tier 4
  [
    #text(weight: "bold", size: 8.2pt, fill: alert-red)[🔴 Tier 4] \
    #text(size: 6.6pt, weight: "bold", fill: alert-red)[Derated Abort Limit]
  ],
  [
    #text(weight: "bold", fill: alert-red)[> 16 mph \ sustained]
  ],
  [
    #text(weight: "bold", fill: alert-red)[> 20 mph \ peak gusts]
  ],
  table.cell(colspan: 2)[
    #align(center)[
      #text(weight: "bold", size: 7.8pt, fill: alert-red)[
        ABSOLUTE NO-GO — PROPS DO NOT LEAVE TRUCK / TRAILER
      ] \
      #text(size: 6.6pt, fill: rgb("#742a2a"))[
        All 16 duck blinds, 11 rolling backdrops, and 4 stage complexes remain locked. Band performs full show without props.
      ]
    ]
  ],
  [#status-badge("NO-GO (Safety Abort)", alert-bg, alert-red, alert-border)],
)

#v(2.5pt)

// =========================================================================
// ABSOLUTE NO-GO CALLOUT BANNER (DERATED 16 MPH / 20 MPH)
// =========================================================================
#rect(
  width: 100%,
  fill: alert-bg,
  stroke: 1pt + alert-red,
  radius: 3pt,
  inset: (x: 7.5pt, y: 4pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 6.5pt,
    align: (horizon, left),
    [
      #text(size: 13pt)[🛑]
    ],
    [
      #text(weight: "bold", size: 8.2pt, fill: alert-red)[
        MANDATORY DERATED ABORT THRESHOLD — SUSTAINED > 16 MPH OR GUSTS > 20 MPH
      ] \
      #text(size: 7.0pt, fill: rgb("#742a2a"))[
        *Hard Rule:* Because props are unvented, the abort ceiling is derated from 20 mph sustained / 25 mph gusts down to *16 mph sustained / 20 mph peak gusts*. Solid vinyl generates coherent flutter and elevated sail loads. If this threshold is approached, the Prop Lead calls an immediate NO-GO. *Students always perform their clean visual drill without props.*
      ]
    ]
  )
]

#v(1fr)

// =========================================================================
// THREE-COLUMN ENGINEERING & OPERATIONAL REFERENCE CARDS (DERATED)
// =========================================================================
#let card-h = 210pt

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 5.5pt,

  // Card 1: Unvented Duck Blind Rules
  rect(
    width: 100%,
    height: card-h,
    fill: gray-bg,
    stroke: 0.6pt + gray-border,
    radius: 3pt,
    inset: (x: 5.5pt, y: 4.5pt),
  )[
    #text(weight: "bold", size: 7.6pt, fill: navy)[🦆 Unvented Screens (Duck Blinds)]
    #v(1.2pt)
    - *Mandatory Min. 2 Bags:* Unvented screens *MUST* receive 2 bags (30 lb) minimum even in calm Tier 0. Zero unballasted staging permitted on turf.
    - *Ballast Location:* Sandbags lie flat across ground *Rear Rail C*. Never hang on front face or struts. Double-bagged per CBA Rule 8.05.
    - *Carry Sail Hazard:* Solid vinyl acts as a continuous sail. In a 15 mph crosswind, student carry pairs experience *16.4 lbs* lateral drag against wrists during field entry.
    - *Snap Clamp Pop-Off:* Coherent vortex flutter produces suction peaks ($>3$ psf) that can unseat perimeter clips.
  ],

  // Card 2: Unvented Rolling Backdrop Limits
  rect(
    width: 100%,
    height: card-h,
    fill: gray-bg,
    stroke: 0.6pt + gray-border,
    radius: 3pt,
    inset: (x: 5.5pt, y: 4.5pt),
  )[
    #text(weight: "bold", size: 7.6pt, fill: navy)[🎪 Unvented Backdrops (11 Carts)]
    #v(1.2pt)
    - *Forward Tipping Limits:* Solid vinyl lowers tipping limits: dry cart tips at *13.3 mph* (vs 14.4 mph vented); Tier 1 at *15.6 mph*; Tier 2 at *17.0 mph*.
    - *Tier 3 Rear-Rail Ballast:* Placing 3 bags flat on rear 2x4 rail ($L = 3.46$ ft lever arm) yields 2.02× leverage, providing *20.8 mph* forward tipping resistance.
    - *No Wheel Brakes / Turf Stability:* Backdrops have no wheel brakes; heavy 153-lb timber cart bases and ballast anchor carts securely against turf friction once in place.
    - *Adult Boundary:* Adults supervise from sideline corridor; never touch active turf during show (Rule 4.03).
  ],

  // Card 3: Engineering Rationale & Circle Cutter
  rect(
    width: 100%,
    height: card-h,
    fill: gray-bg,
    stroke: 0.6pt + gray-border,
    radius: 3pt,
    inset: (x: 5.5pt, y: 4.5pt),
  )[
    #text(weight: "bold", size: 7.6pt, fill: navy)[📐 Weather Protocol & Pre-Cut Action]
    #v(1.2pt)
    - *Wind Tier Call at T-45 min:* Prop Lead measures wind speed with an anemometer in an open area accessible outside stadium at 6.0 ft AGL and checks weather feeds.
    - *Staging Lock-In:* Wind tier is locked in at *T-45 min* during staging prep so ballast can be loaded; no field access prior to show and no time to reload at T-15 min. (Abort immediately if $>16$ mph sust. / $>20$ mph gusts).
    - *Circle Cutter Action:* Fabricate semicircular relief flaps ($R = 4.0$ in., 3/8 in. holes) using PCHSMB Circle Cutter tool to restore 20 mph / 25 mph limits!
    - *Lifting Safety:* Lift ballast with legs; never drop bags.
  ]
)
