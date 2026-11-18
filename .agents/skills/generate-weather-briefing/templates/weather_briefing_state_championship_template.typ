// =========================================================================
// PCHSMB OPERATIONAL WEATHER BRIEFING — CBA STATE CHAMPIONSHIP MASTER TEMPLATE
// Standard: YYYY_Weather_Briefing_MMMDD_<event>_<location>_<GenDay>_<GenTime>.typ
// Skill: $generate-weather-briefing
// =========================================================================

#set document(
  title: "Pine Creek High School Marching Band — CBA State Championship Weather Briefing & Operations Action Plan",
  author: "PCHS Prop & Field Operations Crew",
  date: auto,
)

// Document typography and page geometry (Strictly Two-Page Operational Briefing)
#set page(
  paper: "us-letter",
  margin: (x: 0.38in, top: 0.32in, bottom: 0.35in),
  header: none,
  footer: context [
    #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    #v(1.5pt)
    #grid(
      columns: (1.2fr, 1.8fr, 0.5fr),
      align(left)[#text(size: 6.6pt, fill: rgb("#718096"), weight: "bold")[PCHSMB STATE CHAMPIONSHIP WEATHER BRIEFING]],
      align(center)[#text(size: 6.6pt, fill: rgb("#718096"))[*Operational Directive* • Saturday, Oct 24, 2026 • Falcon Stadium (~6,650'–7,200' ASL)]],
      align(right)[#text(size: 6.6pt, fill: rgb("#718096"), weight: "bold")[Page #counter(page).display() of #counter(page).final().first()]]
    )
  ]
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 7.6pt,
  fill: rgb("#1a202c"),
)

#set par(justify: false, leading: 0.40em)
#show table.cell: set par(justify: false, leading: 0.35em)

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
#let purple = rgb("#553c9a")
#let purple-bg = rgb("#faf5ff")
#let purple-border = rgb("#d6bcfa")
#let gray-border = rgb("#cbd5e0")
#let gray-bg = rgb("#f7fafc")

// Component: Status Badge
#let status-badge(text-str, bg-col, text-col, border-col) = {
  box(
    fill: bg-col,
    stroke: 0.65pt + border-col,
    radius: 2.5pt,
    inset: (x: 3.5pt, y: 1.2pt),
    outset: 0pt,
    baseline: 0%,
    text(weight: "bold", size: 5.9pt, fill: text-col)[#text-str]
  )
}

// =========================================================================
// PAGE 1: STUDENT SAFETY, COLD EXPOSURE & INSTRUMENT PROTECTION BRIEFING
// =========================================================================

// Page 1 Header Banner
#rect(
  width: 100%,
  fill: navy,
  radius: (top: 4pt, bottom: 0pt),
  inset: (x: 7pt, y: 3.0pt),
)[
  #grid(
    columns: (auto, 1fr, auto),
    gutter: 7pt,
    align: (left + horizon, left + horizon, right + horizon),
    [
      #box(fill: white, radius: 2.5pt, inset: (x: 3.5pt, y: 2.0pt))[
        #image("{{LOGO_PAGE1_PATH}}", width: 1.15in)
      ]
    ],
    [
      #text(fill: rgb("#e2e8f0"), size: 6.8pt, weight: "bold", tracking: 0.08em)[PINE CREEK HIGH SCHOOL MARCHING BAND • OPERATIONAL WEATHER BRIEFING] \
      #v(0.4pt)
      #text(fill: white, size: 10.5pt, weight: "bold")[STUDENT SAFETY & INSTRUMENT PROTECTION] \
      #v(0.4pt)
      #text(fill: rgb("#cbd5e0"), size: 6.6pt, weight: "bold")[Saturday, October 24, 2026 • CBA State Championship at Falcon Stadium (USAFA) & Unload at PCHS]
    ],
    [
      #align(right + horizon)[
        #box(
          fill: rgb("#2b6cb0"),
          radius: 2.5pt,
          inset: (x: 5.0pt, y: 2.0pt),
          stroke: 0.5pt + rgb("#63b3ed"),
          text(fill: white, size: 5.6pt, weight: "bold")[
            STATE CHAMPIONSHIP BRIEFING \
            Falcon Stadium & PCHS
          ]
        )
        #v(1.8pt)
        #box(
          fill: rgb("#1a202c"),
          radius: 2.5pt,
          inset: (x: 4.5pt, y: 1.8pt),
          stroke: 0.5pt + rgb("#cbd5e0"),
          align(center)[
            #text(fill: rgb("#e2e8f0"), size: 4.9pt, weight: "bold")[ISSUED: {{ISSUED_TIMESTAMP}}] \
            #text(fill: rgb("#fbd38d"), size: 5.1pt, weight: "bold")[{{LEAD_TIME_STRING}}]
          ]
        )
      ]
    ]
  )
]

// Alert Callout Bar: Climatological Front Range Fall Championship Outlook
#rect(
  width: 100%,
  fill: alert-bg,
  stroke: (left: 3.5pt + alert-red, rest: 0.65pt + alert-border),
  radius: (top: 0pt, bottom: 0pt),
  inset: (x: 7.0pt, y: 2.5pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 5pt,
    align: (top, left),
    [#status-badge("ADVANCE OUTLOOK", alert-bg, alert-red, alert-border)],
    [
      #text(weight: "bold", size: 6.7pt, fill: alert-red)[CBA STATE METEOROLOGICAL SITUATION SUMMARY (3-EVENT CHAMPIONSHIP FORMAT): ]
      #text(size: 6.2pt, fill: rgb("#742a2a"))[
        Official CBA schedule establishes 5A Semi-Finals & Finals (6th place slot): *1. Semifinals:* Trucks arrive 7:00 AM; warmups start 8:50 AM (Perc Area D) / 9:10 AM (Guard D, Body B) / 9:45 AM (Band Area B); Pre-stage 10:25 AM for *10:30 AM Semifinals show* (48°F). 5A Awards at 11:45 AM and team lunch at 12:00 PM. *2. Midday & Finals:* Midday warming to 59°F with downslope mountain gusts (NNW 15 mph, gusts 24 mph) during holding; Finals warmups start 4:05 PM (Perc C) / 4:25 PM (Guard C, Body A) / 5:00 PM (Band A); *Props Pre-stage at 5:00 PM* and Band Pre-stage 5:40 PM for *5:45 PM Finals show* (44°F). Teardown & trucks return to PCHS (8:00–9:15 PM) *prior* to retreat. *3. State Awards (9:30 PM):* Full band in attendance in bleachers/field facing stationary sub-freezing exposure (*29°F–31°F, feels 21°F–23°F*).
      ]
    ]
  )
]

#v(1.0pt)

// Section 1: Hourly Meteorological Timeline Table (All-Day 3-Event Schedule)
#text(weight: "bold", size: 7.4pt, fill: navy)[1. CBA STATE CHAMPIONSHIP ALL-DAY TIMELINE & VENUE FORECASTS (FALCON STADIUM & PCHS)]
#v(0.5pt)

#table(
  columns: (0.95fr, 1.55fr, 0.68fr, 0.72fr, 1.05fr, 0.95fr, 1.10fr),
  align: (left + horizon, left + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
  stroke: 0.35pt + gray-border,
  inset: (x: 2.6pt, y: 1.4pt),
  fill: (col, row) => {
    if row == 0 { rgb("#edf2f7") }
    else if row == 4 { rgb("#fffaf0") } // Semifinals show row highlighted
    else if row == 8 { rgb("#fffaf0") } // Finals show row highlighted
    else if row == 10 { rgb("#fff5f5") } // Awards presentation cold alert highlighted
    else if calc.even(row) { rgb("#f8fafc") }
    else { white }
  },
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Time Window]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Championship Phase & Location]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Ambient Temp]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Feels Like]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Wind / Peak Gust]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Precip / Frost]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Hazard Level]],

  // 1. Friday Pre-Load
  [Fri 5:00 – 6:30 PM],
  [Truck Load at PCHS & Pre-Trip Drive-In],
  [53°F],
  [49°F],
  [NNW 10 mph (G 15 mph)],
  [0% (Crisp / Dry)],
  [#status-badge("STAGING LOAD", ok-bg, dark-blue, border-blue)],

  // 2. Sat Arrival & Unload
  [Sat 7:00 – 8:30 AM],
  [Falcon Outer Lot: Truck Unload & Prop Assembly],
  [32°F $arrow.r$ 37°F],
  [24°F $arrow.r$ 30°F],
  [NNW 10 mph (G 16 mph)],
  [0% (Morning Frost)],
  [#status-badge("FROST PREP", alert-bg, alert-red, alert-border)],

  // 3. Semifinals Warmups
  [Sat 8:50 – 10:15 AM],
  [Semifinals Warmups (Perc D 8:50, Guard/Body 9:10, Band B 9:45)],
  [38°F $arrow.r$ 46°F],
  [32°F $arrow.r$ 41°F],
  [NNW 11 mph (G 17 mph)],
  [0% (Warming Sun)],
  [#status-badge("WARMING UP", ok-bg, ok-green, ok-border)],

  // 4. SEMIFINALS SHOW
  [*Sat 10:25 – 10:55 AM*],
  [*SEMIFINALS: Pre-Stage (10:25 AM) & Show (10:30 AM)*],
  [*48°F*],
  [*43°F*],
  [*NNW 12 mph (G 18 mph)*],
  [*0% dry / crisp*],
  [#status-badge("SEMIFINALS SHOW", ok-bg, ok-green, ok-border)],

  // 5. Semifinals Awards & Lunch
  [Sat 11:45 AM – 1:00 PM],
  [Falcon Stadium: 5A Awards (11:45 AM) & Lunch (12:00 PM)],
  [50°F $arrow.r$ 55°F],
  [46°F $arrow.r$ 51°F],
  [NNW 13 mph (G 20 mph)],
  [0% (Bright Sun)],
  [#status-badge("AWARDS / LUNCH", ok-bg, dark-blue, border-blue)],

  // 6. Midday Holding
  [Sat 1:00 – 4:00 PM],
  [Falcon Outer Lot: Midday Holding & Prop Wind Tie-Down],
  [55°F $arrow.r$ 59°F],
  [51°F $arrow.r$ 55°F],
  [NNW 15 mph (G *24 mph*)],
  [0% (Full Sun / Gusty)],
  [#status-badge("MODERATE (Breezy)", warn-bg, warn-orange, warn-border)],

  // 7. Finals Warmups
  [Sat 4:05 – 5:35 PM],
  [Finals Warmups (Perc C 4:05, Guard/Body 4:25, Band A 5:00)],
  [54°F $arrow.r$ 48°F],
  [47°F $arrow.r$ 40°F],
  [NNW 14 mph (G *21 mph*)],
  [0% (Rapid Sunset Cooling)],
  [#status-badge("COOLING FAST", warn-bg, warn-orange, warn-border)],

  // 8. FINALS SHOW
  [*Sat 5:00 – 6:05 PM*],
  [*FINALS: Props Pre-Stage (5:00), Gate (5:40) & Show (5:45 PM)*],
  [*44°F*],
  [*36°F*],
  [*NNW 13 mph (G 19 mph)*],
  [*0% dry / twilight*],
  [#status-badge("FINALS SHOW", ok-bg, ok-green, ok-border)],

  // 9. Teardown & Early PCHS Unload
  [Sat 6:15 – 9:00 PM],
  [Falcon Lot Teardown & Early PCHS Dock Unload (8:00–9:00)],
  [39°F $arrow.r$ 31°F],
  [29°F $arrow.r$ 24°F],
  [NNW 11 mph (G 16 mph)],
  [0% (Near Freeze Active)],
  [#status-badge("TEARDOWN / UNLOAD", alert-bg, alert-red, alert-border)],

  // 10. AWARDS CEREMONY
  [*Sat 9:15 – 10:45 PM*],
  [*Falcon Stadium: 5A/4A Full Retreat & Awards (9:30 PM)*],
  [*31°F $arrow.r$ 29°F*],
  [*21°F $arrow.r$ 23°F*],
  [*NNW 11 mph (G 16 mph)*],
  [*0% (Hard Freeze Active)*],
  [#status-badge("FREEZING AWARDS", alert-bg, alert-red, alert-border)],
)

#v(1.0pt)

// Section 2: Two-Column Safety & Protection Directives
#grid(
  columns: (1fr, 1fr),
  gutter: 6pt,
  [
    // Column 1: Student Health & Cold Exposure Guidelines
    #rect(
      width: 100%,
      fill: gray-bg,
      stroke: (top: 2.0pt + dark-blue, rest: 0.5pt + gray-border),
      radius: 2pt,
      inset: (x: 5.5pt, y: 3.0pt),
    )[
      #text(weight: "bold", size: 6.8pt, fill: navy)[RECOMMENDED STUDENT HEALTH & COLD WEATHER PRACTICES]
      #v(1.5pt)
      - *30°F All-Day Diurnal Swing:* Temperatures range from 59°F sunny afternoon down to 29°F night retreat. Modular thermal underlayers are essential for shifting between daytime warmth and freezing night air.
      - *Late-Night 9:30 PM Awards Exposure:* The band is in attendance for the full awards ceremony in Falcon Stadium bleachers and field. Facing stationary exposure in sub-freezing cold (*29°F–31°F, feels 21°F–23°F*) requires heavy winter parkas over uniforms, beanies, blankets, and foam seat pads.
      - *Bleacher "Heat Sink" Effect:* Metal and concrete stadium benches drain core warmth rapidly. Foam seat cushions or folded blankets are strongly advised during Semifinals watching and late awards.
      - *Hand Warmers:* Stock chemical hand warmers for students to slip into gloves during morning warmup (8:50 AM), evening warmup (4:05 PM), and the 9:30 PM Full Retreat.
      - *Hydration & Footing:* Cold dry air blunts thirst; remind students to sip water. Watch footing on frosty morning ramps and cold bleacher steps.
    ]
  ],
  [
    // Column 2: Instrument Safety & Precipitation Mitigations
    #rect(
      width: 100%,
      fill: purple-bg,
      stroke: (top: 2.0pt + purple, rest: 0.5pt + purple-border),
      radius: 2pt,
      inset: (x: 5.5pt, y: 3.0pt),
    )[
      #text(weight: "bold", size: 6.8pt, fill: purple)[INSTRUMENT CARE: RECOMMENDED COVERS & COLD PROTECTION]
      #v(1.5pt)
      - *Woodwind Morning Cold & Moisture Protection:*
        - *Gradual Bore Warming:* With 8:50 AM warmups starting in 38°F–42°F air, warm wooden instruments (grenadilla clarinets/oboes) gradually inside jackets before playing to avoid bore stress and cracking. Swab condensation frequently.
        - *Pad Care:* Drape rain hoods or clear bags over woodwinds in stands between performances to prevent moisture condensation on delicate pads.
      - *Front Ensemble (Pit) Mallet & Audio Protection:*
        - *Acoustic Percussion:* Rosewood marimba bars are vulnerable to cold and humidity shifts. Keep fitted vinyl covers over marimbas and vibes during 7:00 AM unload and midday holding.
        - *Electronics & Power Drops:* Keyboards and synths benefit from dampness shielding. Keep power strips and direct boxes elevated off cold turf.
      - *Brass Low-Temperature Valve Care:*
        - Apply synthetic light valve oil before the 8:50 AM block and again before the 4:05 PM block to ensure agile valve action. Empty water keys onto cloths.
    ]
  ]
)

#v(1.0pt)

// Section 3: Helpful Tips for Chaperones & Section Leaders
#rect(
  width: 100%,
  fill: light-blue,
  stroke: (left: 3.5pt + dark-blue, rest: 0.5pt + border-blue),
  radius: 2pt,
  inset: (x: 8.0pt, y: 3.0pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 6pt,
    align: (horizon, left),
    [
      #status-badge("ACTION TIPS", light-blue, navy, dark-blue)
    ],
    [
      #text(weight: "bold", size: 6.8pt, fill: navy)[RECOMMENDED SUGGESTIONS FOR CHAPERONES & SECTION LEADERS]
    ]
  )
  #v(1.5pt)
  #grid(
    columns: (1fr, 1fr),
    gutter: 10pt,
    [
      - *Heavy Outerwear for 9:30 PM Awards:* Ensure heavy winter coats, beanies, and blankets are staged and accessible *before* taking seats for awards.
      - *Modular Underlayers:* Remind students to wear thermal base layers under uniforms for the 8:50 AM warmup block.
      - *Hand Warmers:* Distribute chemical warmers for warmups and awards.
    ],
    [
      - *Front Ensemble:* Keep protective vinyl covers on pit carts until final staging calls.
      - *Hydration Reminders:* Periodically remind students to keep drinking water throughout the long championship day.
      - *Footing Awareness:* Remind students to walk deliberately on cold stadium ramps and night bleachers.
    ]
  )
]

#pagebreak()

// =========================================================================
// PAGE 2: PROP TEAM OPERATIONS, RIGGING & WIND SAFETY BRIEFING
// =========================================================================

// Page 2 Header Banner
#rect(
  width: 100%,
  fill: navy,
  radius: (top: 4pt, bottom: 0pt),
  inset: (x: 7pt, y: 3.0pt),
)[
  #grid(
    columns: (auto, 1fr, auto),
    gutter: 7pt,
    align: (left + horizon, left + horizon, right + horizon),
    [
      #box(fill: white, radius: 2.5pt, inset: (x: 3.5pt, y: 2.0pt))[
        #image("{{LOGO_PAGE2_PATH}}", width: 1.15in)
      ]
    ],
    [
      #text(fill: rgb("#e2e8f0"), size: 6.8pt, weight: "bold", tracking: 0.08em)[PINE CREEK HIGH SCHOOL MARCHING BAND • OPERATIONAL WEATHER BRIEFING] \
      #v(0.4pt)
      #text(fill: white, size: 10.5pt, weight: "bold")[PROP TEAM RIGGING & WIND SAFETY DIRECTIVE] \
      #v(0.4pt)
      #text(fill: rgb("#cbd5e0"), size: 6.6pt, weight: "bold")[Saturday, October 24, 2026 • CBA State Championship at Falcon Stadium (USAFA) & Unload at PCHS]
    ],
    [
      #align(right + horizon)[
        #box(
          fill: rgb("#2b6cb0"),
          radius: 2.5pt,
          inset: (x: 5.0pt, y: 2.0pt),
          stroke: 0.5pt + rgb("#63b3ed"),
          text(fill: white, size: 5.6pt, weight: "bold")[
            VOLUNTEER PROP CREW \
            Falcon Stadium & PCHS Unload
          ]
        )
        #v(1.8pt)
        #box(
          fill: rgb("#1a202c"),
          radius: 2.5pt,
          inset: (x: 4.5pt, y: 1.8pt),
          stroke: 0.5pt + rgb("#cbd5e0"),
          align(center)[
            #text(fill: rgb("#e2e8f0"), size: 4.9pt, weight: "bold")[ISSUED: {{ISSUED_TIMESTAMP}}] \
            #text(fill: rgb("#fbd38d"), size: 5.1pt, weight: "bold")[{{LEAD_TIME_STRING}}]
          ]
        )
      ]
    ]
  )
]

// Prop Crew Operational Logistics Banner (3-Event Schedule Flow)
#rect(
  width: 100%,
  fill: purple-bg,
  stroke: (left: 3.5pt + purple, rest: 0.65pt + purple-border),
  radius: (top: 0pt, bottom: 0pt),
  inset: (x: 7.0pt, y: 2.5pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 6pt,
    align: (top, left),
    [#status-badge("CREW WORKFLOW", purple-bg, purple, purple-border)],
    [
      #text(weight: "bold", size: 6.8pt, fill: purple)[CBA STATE PROP WORKFLOW (PRE-LOAD $arrow.r$ SEMIFINALS $arrow.r$ MIDDAY HOLDING $arrow.r$ FINALS $arrow.r$ EARLY RETURN): ]
      #text(size: 6.3pt, fill: rgb("#322659"))[
        *Friday Pre-Load (5:00 PM):* Trucks loaded at PCHS and driven in. *Saturday Morning (7:00 AM):* Unload trailers and prep props outside Falcon Stadium; rendezvous with band for 10:25 AM Pre-stage & 10:30 AM Semifinals show. *Midday Holding (11:00 AM–4:30 PM):* Restow Duck Blinds flat on stages in trailer lot to eliminate kite risk in 24 mph afternoon gusts; attend 11:45 AM 5A awards & 12:00 PM lunch. *Finals Push:* *Props Pre-stage at 5:00 PM* (CBA official slot); band joins at gate 5:40 PM for 5:45 PM Finals show. *Early Truck Return (8:00–9:15 PM):* Teardown immediately post-finals; trucks convoy back to PCHS, unload, and stow *before* the 9:30 PM Full Retreat.
      ]
    ]
  )
]

#v(1.0pt)

// Section 1: Prop Operations Timeline & Staging Hazards (7 Operational Steps)
#text(weight: "bold", size: 7.4pt, fill: navy)[1. PROP CREW LOGISTICS TIMELINE & VENUE-SPECIFIC WIND EXPOSURE]
#v(0.5pt)

#table(
  columns: (0.90fr, 1.20fr, 1.35fr, 1.75fr, 0.90fr, 0.90fr),
  align: (left + horizon, left + horizon, left + horizon, left + horizon, center + horizon, center + horizon),
  stroke: 0.35pt + gray-border,
  inset: (x: 2.5pt, y: 1.4pt),
  fill: (col, row) => {
    if row == 0 { rgb("#edf2f7") }
    else if row == 3 { rgb("#fffaf0") } // Semifinals show highlighted
    else if row == 5 { rgb("#fffaf0") } // Finals show highlighted
    else if calc.even(row) { rgb("#f8fafc") }
    else { white }
  },
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Time Window]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Operational Step]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Staging Zone & Wind Exposure]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Rigging & Ballast Guidelines]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Ballast Tier]],
  [#text(weight: "bold", size: 5.9pt, fill: navy)[Operational Hazard]],

  // Step 1: Friday Pre-Load
  [Fri 5:00 – 6:30 PM \ (Night Before)],
  [Truck Pre-Load at PCHS & Drive-In Convoy],
  [*PCHS Loading Dock.* Mild fall evening (*53°F*). Clear parking lot.],
  [Load 11 carts, 16 screens, 4 stages, 80 sandbags, 22 Body Bags. Drive trucks to USAFA / staging lot.],
  [#status-badge("Tier 0 (Pre-Trip)", ok-bg, navy, gray-border)],
  [#status-badge("STAGING LOAD", ok-bg, dark-blue, border-blue)],

  // Step 2: Sat Morning Unload & Prep
  [Sat 7:00 – 8:30 AM \ (Early Morning)],
  [Falcon Arrival, Truck Unload & Prop Prep],
  [*Falcon Outer Lot.* Chilly morning (*32°F–37°F, feels 24°F–30°F*). Frost on turf/metal.],
  [Unload trucks at 7:00 AM. Stage screens flat on stages. Wipe dew off wooden rear rails; tape 11 Body Bags. Pre-load wagons.],
  [#status-badge("Tier 2 (Prep)", warn-bg, warn-orange, warn-border)],
  [#status-badge("MORNING FROST", alert-bg, alert-red, alert-border)],

  // Step 3: Semifinals Show
  [9:45 – 10:45 AM \ (Semifinals Show)],
  [Rendezvous, Pre-Stage (10:25) & Show (10:30)],
  [*Falcon Stadium Tunnel Ramp & Field.* Warming (*48°F*). Tunnel venturi effect.],
  [Band joins crew at pad. *3 students per cart* (2 push, 1 guide). Use a spare 15-lb sandbag to chock wheels on downhill/downwind side.],
  [#status-badge("Tier 2 (Active)", warn-bg, warn-orange, warn-border)],
  [#status-badge("TUNNEL VENTURI", alert-bg, alert-red, alert-border)],

  // Step 4: Midday Holding & 5A Awards
  [11:00 AM – 4:30 PM \ (Midday Holding)],
  [Prop Holding between Rounds & Screens Flat],
  [*Falcon Outer Lot.* Sunny (*52°F–59°F*). Downslope mountain gusts (*22–24 mph*).],
  [*Never leave blinds upright unballasted.* Restow screens flat on stages. Attend 11:45 AM 5A awards & 12:00 PM lunch. Prop Lead check at 4:15 PM.],
  [#status-badge("Tier 2 (Holding)", warn-bg, warn-orange, warn-border)],
  [#status-badge("AFTERNOON GUSTS", warn-bg, warn-orange, warn-border)],

  // Step 5: Finals Props Pre-Stage & Show
  [5:00 – 6:05 PM \ (Finals Show)],
  [*Props Pre-Stage (5:00)*, Gate (5:40) & Show (5:45)],
  [*Falcon Tunnel & Turf.* Twilight cooling (*44°F*). Stadium bowl cross-swirls.],
  [*Props Pre-Stage at 5:00 PM* per CBA schedule. 2-student screen placement & backdrop lock. Use a spare 15-lb sandbag to chock wheels.],
  [#status-badge("Tier 2 (Active)", warn-bg, warn-orange, warn-border)],
  [#status-badge("BOWL SWIRLS", ok-bg, ok-green, ok-border)],

  // Step 6: Post-Finals Teardown
  [6:15 – 7:45 PM \ (Post-Finals)],
  [Teardown & Trailer Reload at Falcon Lot],
  [*Falcon Outer Lot.* Dimming dusk (*39°F–35°F, feels 29°F*). Dark pavement.],
  [Headlamps on. Rapid deballast & packout. Two-person lift on 70-lb tube sand over truck axles. Strap carts to E-track.],
  [#status-badge("Tier 2 (Deballast)", warn-bg, warn-orange, warn-border)],
  [#status-badge("RAPID COOLING", warn-bg, warn-orange, warn-border)],

  // Step 7: Early PCHS Unload Before Retreat
  [8:00 – 9:15 PM \ (Early Return)],
  [Convoy to PCHS, Unload & Return Trucks],
  [*PCHS Loading Dock.* Sub-freezing (*33°F–31°F, feels 24°F*). Cold ramp.],
  [Truck returns to PCHS *before* 9:30 PM Full Retreat. Two-person team lift on 70-lb tube sand. Warehouse secured; return for retreat.],
  [#status-badge("Stowed / Complete", ok-bg, navy, gray-border)],
  [#status-badge("NEAR FREEZE", alert-bg, alert-red, alert-border)],
)

#v(1.0pt)

// Section 2: Continuum 2026 Authoritative Wind Safety Chart
#text(weight: "bold", size: 7.4pt, fill: navy)[2. 2026 CONTINUUM PROP FLEET WIND TIERS & BALLASTING SPECIFICATION]
#v(0.5pt)

#table(
  columns: (0.90fr, 0.70fr, 0.70fr, 1.75fr, 2.15fr, 1.15fr, 0.90fr),
  align: (left + horizon, center + horizon, center + horizon, left + horizon, left + horizon, left + horizon, center + horizon),
  stroke: 0.35pt + gray-border,
  inset: (x: 2.8pt, y: 1.6pt),
  fill: (col, row) => {
    if row == 0 { rgb("#edf2f7") }
    else if row == 3 { rgb("#fffaf0") } // Tier 2 highlighted
    else if row == 5 { rgb("#fff5f5") } // Abort row
    else if calc.even(row) { rgb("#f8fafc") }
    else { white }
  },
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Operational Tier]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Sustained]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Peak Gusts]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Sideline Screens (16 Props)\ #text(size: 5.0pt, weight: "regular", fill: rgb("#4a5568"))[15-lb Handle Bags — Front Sideline]]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Rolling Backdrops (11 Props)\ #text(size: 5.0pt, weight: "regular", fill: rgb("#4a5568"))[Prioritized Hybrid Schedule]]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Inventory Status\ #text(size: 5.0pt, weight: "regular", fill: rgb("#4a5568"))[80 Bags / 22 Tubes]]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[State Call]],

  // Tier 0
  [⚪ *Tier 0* (Calm)],
  [0 – 8 mph],
  [$<= 10$ mph],
  [1 bag (15 lb) flat on rear rail C],
  [0 bags (153 lb dry prop cart)],
  [16/80 Sandbags • 0/22 Body Bags],
  [#status-badge("GO (Calm)", ok-bg, ok-green, ok-border)],

  // Tier 1
  [🟢 *Tier 1* (Normal)],
  [8 – 12 mph],
  [$<= 15$ mph],
  [2 bags (30 lb) flat on rear rail C],
  [4 sandbags (60 lb: 2 / wing post)],
  [76/80 Sandbags • 0/22 Body Bags],
  [#status-badge("GO (Normal)", ok-bg, ok-green, ok-border)],

  // Tier 2 (TONIGHT'S OPERATIONAL ZONE)
  [🟡 *Tier 2* (Advisory)\ #text(size: 5.0pt, weight: "bold", fill: warn-orange)[★ STATE CALL]],
  [*12 – 18 mph*],
  [*$<= 20$ mph*],
  [*3 bags (45 lb)* flat on rear rail C \ #text(size: 5.0pt, fill: rgb("#4a5568"))[24 bags/wagon (48 fleet total)]],
  [*1 "Body Bag" (70 lb tube sand)* taped to wooden rail A with Gorilla Tape \ #text(size: 5.0pt, fill: rgb("#4a5568"))[Restoring moment: 434 ft-lb; safe gust 21.5 mph]],
  [*48/80 Sandbags* \ *11/22 Body Bags*],
  [#status-badge("GO (Advisory)", warn-bg, warn-orange, warn-border)],

  // Tier 3
  [🟠 *Tier 3* (High-Wind)],
  [18 – 22 mph],
  [$<= 25$ mph],
  [4 bags (60 lb) flat on rear rail C \ #text(size: 5.0pt, fill: rgb("#4a5568"))[32 bags/wagon (64 fleet total)]],
  [2 "Body Bags" (140 lb) taped to wooden rail A \ #text(size: 5.0pt, fill: rgb("#4a5568"))[Prop wt: 293 lb ($<300$ lb limit); safe gust 26.8 mph]],
  [64/80 Sandbags \ 22/22 Body Bags],
  [#status-badge("CAUTION", warn-bg, warn-orange, warn-border)],

  // Tier 4
  [🔴 *Tier 4* (Abort)],
  [*> 20 mph sust.*],
  [*> 25 mph gust*],
  table.cell(colspan: 3)[
    #align(center)[
      #text(weight: "bold", size: 6.1pt, fill: alert-red)[
        ABSOLUTE NO-GO — PROPS DO NOT LEAVE TRUCK / TRAILER
      ] \
      #text(size: 5.2pt, fill: rgb("#742a2a"))[
        All props remain locked in transport. Band performs clean visual drill without props.
      ]
    ]
  ],
  [#status-badge("NO-GO", alert-bg, alert-red, alert-border)],
)

#v(1.0pt)

// Section 3: Critical Directives for Tonight's Rigging & Packout
#grid(
  columns: (1fr, 1fr),
  gutter: 6pt,
  [
    // Column 1: Rigging & Assembly Directives Outside Stadium
    #rect(
      width: 100%,
      fill: gray-bg,
      stroke: (top: 2.0pt + dark-blue, rest: 0.5pt + gray-border),
      radius: 2pt,
      inset: (x: 5.5pt, y: 3.2pt),
    )[
      #text(weight: "bold", size: 6.8pt, fill: navy)[SEMIFINALS & MIDDAY STAGING DIRECTIVES]
      #v(1.5pt)
      - *Prevent "Kite" Effect in Afternoon Sun:* 24 mph midday gusts will tip unballasted screens instantly. *Never leave an assembled Duck Blind standing upright without sandbags.* Keep screens resting flat on stages between rounds.
      - *Cold Morning Gorilla Tape Adhesion:* At 32°F, tape adhesive loses initial tack. Wipe frost/condensation off the wooden rear rail before applying 4 wraps of Gorilla Tape across each 70-lb Body Bag.
      - *Pre-Load Ballast Wagons:* Load 24 sandbags (15 lb each) into Wagon 1 (Side 1) and Wagon 2 (Side 2). Stage wagons at tunnel gate.
    ]
  ],
  [
    // Column 2: Packout, Teardown & Logistics Directives
    #rect(
      width: 100%,
      fill: gray-bg,
      stroke: (top: 2.0pt + dark-blue, rest: 0.5pt + gray-border),
      radius: 2pt,
      inset: (x: 5.5pt, y: 3.0pt),
    )[
      #text(weight: "bold", size: 6.8pt, fill: navy)[FINALS PROPS PRE-STAGE & EARLY PCHS UNLOAD]
      #v(1.5pt)
      - *Props Pre-Stage at 5:00 PM Sharp:* Official CBA Finals schedule establishes *Props Pre-stage at 5:00 PM* at the tunnel chute (45 min prior to 5:45 PM show). Band joins at 5:40 PM gate call.
      - *Early Convoy Before 9:30 PM Awards:* Equipment trucks convoy to PCHS immediately post-finals packout (8:00–9:15 PM) to unload warehouse and secure props *prior* to the 9:30 PM Full Retreat.
      - *Tunnel Egress Traction & Wheel Chocking:* The post-show tunnel push is uphill. Assign 3 students per cart (2 pushing at rear handles, 1 guiding at front). Use a spare 15-lb sandbag to chock wheels on downhill and/or downwind side.
      - *Two-Person Team Lift on Body Bags:* 70-lb tube sand is heavy after a 16-hour day. Using two adults to lift each tube sand off carts and restow over truck axles is mandatory.
      - *Crew Thermal PPE:* Teardown and PCHS dock unload happen in near-freezing air. Volunteers must wear insulated work gloves, safety vests, and headlamps.
    ]
  ]
)

#v(1.0pt)

// Section 4: Lead Coordinator Abort Threshold Callout
#rect(
  width: 100%,
  fill: alert-bg,
  stroke: 1pt + alert-red,
  radius: 2pt,
  inset: (x: 6.5pt, y: 2.6pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 6pt,
    align: (horizon, left),
    [#status-badge("ABORT CEILING", alert-bg, alert-red, alert-border)],
    [
      #text(weight: "bold", size: 6.8pt, fill: alert-red)[
        ABSOLUTE PROP ABORT THRESHOLD: SUSTAINED > 20 MPH OR PEAK GUSTS > 25 MPH
      ] \
      #text(size: 6.2pt, fill: rgb("#742a2a"))[
        *Hard Safety Ceiling:* The Prop Lead carries a handheld digital anemometer at 6.0' AGL outside the stadium. If wind speeds sustained exceed *20 mph* or gusts exceed *25 mph* at T-45 min (Semifinals or Finals), the Prop Lead issues an immediate *NO-GO*. Props stay in trucks. *Per Core Philosophy: Props exist to support students; nothing on prop crew will ever compromise student safety or their show.*
      ]
    ]
  )
]
