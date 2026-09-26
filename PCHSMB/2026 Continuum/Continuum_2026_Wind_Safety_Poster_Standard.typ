#set document(
  title: "Pine Creek High School Marching Band — 2026 Continuum Wind Safety Poster (Standard)",
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
      align(left)[#text(size: 6.8pt, fill: rgb("#718096"), weight: "bold")[PCHSMB 2026 CONTINUUM — FIELD SAFETY STANDARD]],
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
// HEADER BLOCK
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
        fill: rgb("#2b6cb0"),
        radius: 3pt,
        inset: (x: 6.5pt, y: 3.5pt),
        stroke: 0.5pt + rgb("#63b3ed"),
        text(fill: white, size: 7.2pt, weight: "bold")[
          STANDARD SPECIFICATION \
          With Engineered Relief Flaps ($C_d = 1.02$)
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
  radius: (top: 0pt, bottom: 3pt),
  inset: (x: 8.5pt, y: 4.5pt),
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

#v(2pt)

// =========================================================================
// MASTER TIERED WIND & BALLASTING MATRIX
// =========================================================================
#text(weight: "bold", size: 9pt, fill: navy)[
  FIELD PROP WIND TIERS & BALLASTING SCHEDULE (35 PROPS)
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
    #text(size: 6.6pt, fill: rgb("#4a5568"))[Calm Stadium Conditions]
  ],
  [*0 – 8 mph*],
  [$<= 10$ mph],
  [
    *1 bag (15 lb)* flat on rear rail C \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Fleet: 16 bags total (8 bags / wagon)]
  ],
  [
    *0 bags* (153 lb dry cart) \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Safe gust limit: 14.4 mph; Fleet: 0 bags]
  ],
  [#status-badge("GO (Calm)", ok-bg, ok-green, ok-border)],

  // Tier 1
  [
    #text(weight: "bold", size: 7.8pt, fill: ok-green)[🟢 Tier 1] \
    #text(size: 6.6pt, fill: rgb("#4a5568"))[Normal Competition Breeze]
  ],
  [*8 – 12 mph*],
  [$<= 15$ mph],
  [
    *2 bags (30 lb)* flat on rear rail C \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Fleet: 32 bags total (16 bags / wagon)]
  ],
  [
    *4 bags (60 lb: 2 per wing post)* \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Safe gust limit: 16.9 mph; Fleet: 44 bags]
  ],
  [#status-badge("GO (Normal)", ok-bg, ok-green, ok-border)],

  // Tier 2
  [
    #text(weight: "bold", size: 7.8pt, fill: warn-orange)[🟡 Tier 2] \
    #text(size: 6.6pt, fill: rgb("#4a5568"))[Advisory Gusty Conditions]
  ],
  [*12 – 18 mph*],
  [$<= 20$ mph],
  [
    *3 bags (45 lb)* flat on rear rail C \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Fleet: 48 bags total (24 bags / wagon)]
  ],
  [
    *6 bags (90 lb: 3 per wing post)* \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Safe gust limit: 18.4 mph; Fleet: 66 bags]
  ],
  [#status-badge("GO (Advisory)", warn-bg, warn-orange, warn-border)],

  // Tier 3
  [
    #text(weight: "bold", size: 7.8pt, fill: warn-orange)[🟠 Tier 3] \
    #text(size: 6.6pt, fill: rgb("#4a5568"))[High-Wind Max Limit]
  ],
  [*18 – 22 mph*],
  [$<= 25$ mph],
  [
    *4 bags (60 lb)* flat on rear rail C \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Fleet: 64 bags total (32 bags / wagon)]
  ],
  [
    *9 bags (135 lb total):* \
    6 on wing posts + *3 flat on rear rail* \
    #text(size: 6.4pt, fill: rgb("#4a5568"))[Safe gust limit: 22.3 mph; Fleet: 99 bags]
  ],
  [#status-badge("CAUTION (High-Wind)", warn-bg, warn-orange, warn-border)],

  // Tier 4
  [
    #text(weight: "bold", size: 8.2pt, fill: alert-red)[🔴 Tier 4] \
    #text(size: 6.6pt, weight: "bold", fill: alert-red)[Safety Abort Threshold]
  ],
  [
    #text(weight: "bold", fill: alert-red)[> 20 mph \ sustained]
  ],
  [
    #text(weight: "bold", fill: alert-red)[> 25 mph \ peak gusts]
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
// ABSOLUTE NO-GO CALLOUT BANNER
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
        MANDATORY SAFETY ABORT THRESHOLD — SUSTAINED > 20 MPH OR GUSTS > 25 MPH
      ] \
      #text(size: 7.0pt, fill: rgb("#742a2a"))[
        *Hard Rule:* If sustained winds exceed *20 mph* OR gusts are measured/forecasted at *25–30 mph*, props *DO NOT* leave the equipment truck/trailer. Props create severe projectile, pinch, and tipping hazards in high winds. The Prop Lead issues an immediate NO-GO. *Students always perform their clean visual drill without props.*
      ]
    ]
  )
]

#v(1fr)

// =========================================================================
// THREE-COLUMN ENGINEERING & OPERATIONAL REFERENCE CARDS
// =========================================================================
#let card-h = 210pt

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 5.5pt,

  // Card 1: Duck Blind Rules
  rect(
    width: 100%,
    height: card-h,
    fill: gray-bg,
    stroke: 0.6pt + gray-border,
    radius: 3pt,
    inset: (x: 5.5pt, y: 4.5pt),
  )[
    #text(weight: "bold", size: 7.6pt, fill: navy)[🦆 Sideline Screens (Duck Blinds)]
    #v(1.2pt)
    - *Ballast Location:* Sandbags *MUST* rest flat across ground *Rear Rail C* directly behind uprights. Never hang on front face, corner joints, or upright struts.
    - *CBA Rule 8.05:* All sandbags must be double-bagged (15-lb pea gravel/sand inside heavy canvas with webbing handles). Zero sand leakage permitted on turf.
    - *Two-Student Carry:* Handlers carry screens in folded A-frame pairs; wagons deliver ballast along front sideline corridor. Adults clear turf by *2:45*.
    - *Sliding Threshold:* 6 flaps raise turf friction sliding threshold to *17.8 mph* at Tier 1 (2 bags).
  ],

  // Card 2: Rolling Backdrop Rules
  rect(
    width: 100%,
    height: card-h,
    fill: gray-bg,
    stroke: 0.6pt + gray-border,
    radius: 3pt,
    inset: (x: 5.5pt, y: 4.5pt),
  )[
    #text(weight: "bold", size: 7.6pt, fill: navy)[🎪 Rolling Backdrops (11 Carts)]
    #v(1.2pt)
    - *Wing Post Ballast:* Tiers 1–2 seat bags over vertical steel wing iron posts ($L = 1.71$ ft lever arm to front casters).
    - *Rear-Rail Tier 3 Leverage:* Tier 3 places 3 bags flat on rear 2x4 rail ($L = 3.46$ ft lever arm). This provides *2.02× greater overturning leverage*, raising safe gust tipping limit to *22.3 mph*.
    - *No Wheel Brakes / Turf Stability:* Backdrops have no wheel brakes; heavy 153-lb timber cart bases and ballast anchor carts securely against turf friction once in place.
    - *Adult Boundary:* Adults supervise entry from sideline corridor; never touch active turf during show (Rule 4.03).
  ],

  // Card 3: Relief Flaps & Telemetry
  rect(
    width: 100%,
    height: card-h,
    fill: gray-bg,
    stroke: 0.6pt + gray-border,
    radius: 3pt,
    inset: (x: 5.5pt, y: 4.5pt),
  )[
    #text(weight: "bold", size: 7.6pt, fill: navy)[📐 Relief Flaps & Weather Protocol]
    #v(1.2pt)
    - *Engineered Flap Standard:* 16 duck blinds (6 flaps, 2×3 grid) and 11 backdrops (8 flaps, 3-2-3 staggered pattern straddling the 60″ mid rail) feature semicircular flaps ($R = 4.0$ in., 3/8 in. tear-arrest holes) reducing drag by 15% ($C_d = 1.02$).
    - *Wind Tier Call at T-45 min:* Prop Lead measures wind speed with an anemometer in an open area accessible outside the stadium at 6.0 ft AGL and checks local weather feeds.
    - *Staging Lock-In:* Wind tier is locked in at *T-45 min* during staging prep so ballast can be loaded; no field access prior to show and no time to reload at T-15 min. (If winds spike to Tier 4 at gate, issue immediate NO-GO).
    - *Lifting Safety:* Lift ballast with legs, not back; never drop or throw sandbags.
  ]
)
