// =========================================================================
// PCHSMB OPERATIONAL WEATHER BRIEFING — MASTER TYPST TEMPLATE
// Standard: YYYY_Weather_Briefing_MMMDD_<event>_<location>_<GenDay>_<GenTime>.typ
// Skill: $generate-weather-briefing
// =========================================================================

#set document(
  title: "{{DOCUMENT_TITLE}}",
  author: "PCHS Prop & Field Operations Crew",
  date: auto,
)

// Document typography and page geometry (Strictly Two-Page Operational Briefing)
#set page(
  paper: "us-letter",
  margin: (x: 0.40in, top: 0.35in, bottom: 0.38in),
  header: none,
  footer: context [
    #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    #v(1.5pt)
    #grid(
      columns: (1.1fr, 1.8fr, 0.5fr),
      align(left)[#text(size: 6.8pt, fill: rgb("#718096"), weight: "bold")[PCHSMB GAME NIGHT WEATHER BRIEFING]],
      align(center)[#text(size: 6.8pt, fill: rgb("#718096"))[*Operational Directive* • {{EVENT_DATE_LONG}} • {{VENUE_ELEVATION}}]],
      align(right)[#text(size: 6.8pt, fill: rgb("#718096"), weight: "bold")[Page #counter(page).display() of #counter(page).final().first()]]
    )
  ]
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 7.8pt,
  fill: rgb("#1a202c"),
)

#set par(justify: false, leading: 0.42em)
#show table.cell: set par(justify: false, leading: 0.38em)

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
    inset: (x: 4.0pt, y: 1.4pt),
    outset: 0pt,
    baseline: 0%,
    text(weight: "bold", size: 6.3pt, fill: text-col)[#text-str]
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
  inset: (x: 7pt, y: 3.5pt),
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
      #text(fill: rgb("#e2e8f0"), size: 7.0pt, weight: "bold", tracking: 0.08em)[PINE CREEK HIGH SCHOOL MARCHING BAND • OPERATIONAL WEATHER BRIEFING] \
      #v(0.5pt)
      #text(fill: white, size: 10.8pt, weight: "bold")[STUDENT SAFETY & INSTRUMENT PROTECTION] \
      #v(0.5pt)
      #text(fill: rgb("#cbd5e0"), size: 6.8pt, weight: "bold")[{{EVENT_DATE_LONG}} • Game at {{VENUE_NAME}} & Unload at {{UNLOAD_LOCATION}}]
    ],
    [
      #align(right + horizon)[
        #box(
          fill: rgb("#2b6cb0"),
          radius: 2.5pt,
          inset: (x: 5.0pt, y: 2.0pt),
          stroke: 0.5pt + rgb("#63b3ed"),
          text(fill: white, size: 5.8pt, weight: "bold")[
            {{EVENT_TYPE_BADGE}} \
            {{VENUE_SHORT}} & {{UNLOAD_SHORT}}
          ]
        )
        #v(1.8pt)
        #box(
          fill: rgb("#1a202c"),
          radius: 2.5pt,
          inset: (x: 4.5pt, y: 1.8pt),
          stroke: 0.5pt + rgb("#cbd5e0"),
          align(center)[
            #text(fill: rgb("#e2e8f0"), size: 5.0pt, weight: "bold")[ISSUED: {{ISSUED_TIMESTAMP}}] \
            #text(fill: rgb("#fbd38d"), size: 5.2pt, weight: "bold")[{{LEAD_TIME_STRING}}]
          ]
        )
      ]
    ]
  )
]

// Alert Callout Bar
#rect(
  width: 100%,
  fill: {{ALERT_BG_COLOR}},
  stroke: (left: 3.5pt + {{ALERT_ACCENT_COLOR}}, rest: 0.65pt + {{ALERT_BORDER_COLOR}}),
  radius: (top: 0pt, bottom: 0pt),
  inset: (x: 7.0pt, y: 2.8pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 5pt,
    align: (top, left),
    [#status-badge("{{ALERT_BADGE_TEXT}}", {{ALERT_BG_COLOR}}, {{ALERT_ACCENT_COLOR}}, {{ALERT_BORDER_COLOR}})],
    [
      #text(weight: "bold", size: 6.9pt, fill: {{ALERT_ACCENT_COLOR}})[{{ALERT_TITLE}}: ]
      #text(size: 6.5pt, fill: rgb("#742a2a"))[
        {{ALERT_SUMMARY_TEXT}}
      ]
    ]
  )
]

#v(1.0pt)

// Section 1: Hourly Meteorological Timeline Table
#text(weight: "bold", size: 7.6pt, fill: navy)[1. GAME NIGHT HOURLY TIMELINE & VENUE FORECASTS ({{VENUE_SHORT}} & {{UNLOAD_SHORT}})]
#v(0.5pt)

#table(
  columns: (0.95fr, 1.45fr, 0.70fr, 0.75fr, 1.05fr, 0.95fr, 1.15fr),
  align: (left + horizon, left + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
  stroke: 0.35pt + gray-border,
  inset: (x: 2.8pt, y: 1.8pt),
  fill: (col, row) => {
    if row == 0 { rgb("#edf2f7") }
    else if row == {{HALFTIME_ROW_INDEX}} { rgb("#fffaf0") }
    else if calc.even(row) { rgb("#f8fafc") }
    else { white }
  },
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Time Window]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Operational Phase & Location]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Ambient Temp]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Feels Like]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Wind / Peak Gust]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Precip / Thunder]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Student Hazard Level]],

{{HOURLY_TABLE_ROWS}}
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
      inset: (x: 5.5pt, y: 3.5pt),
    )[
      #text(weight: "bold", size: 6.9pt, fill: navy)[RECOMMENDED STUDENT HEALTH & COLD WEATHER PRACTICES]
      #v(1.5pt)
      - *Bleacher "Heat Sink" Effect:* Cold concrete and aluminum bleachers draw heat away quickly. Bringing seat cushions, folded rain jackets, or small blankets to sit on provides helpful insulation during the 1st and 2nd half.
      - *Recommended Thermal Underlayers:* Wearing thermal compression tops, leggings, and thick warm socks under marching uniforms is strongly recommended to protect against cold wind chills.
      - *Hand & Finger Warmth (Chemical Warmers):* Playing pep tunes with cold fingers can be difficult. Having chemical hand warmers ("Hot-Hands") available for students to slip into gloves or pockets between tunes helps maintain playing dexterity.
      - *Cold Weather Hydration:* Cold dry mountain air ({{VENUE_ELEVATION}}) blunts the thirst reflex. Periodic reminders to students to keep drinking water from their bottles help maintain stamina and reduce chills.
      - *Tunnel & Bleacher Footing:* Ramps and bleacher steps can become slick from evening condensation. Students should take a steady, deliberate walk when moving down the tunnel chute.
      - *Severe Weather / Lightning Guideline:* Standard CHSAA/NFHS rules recommend moving indoors if any cloud-to-ground strike occurs within 10 miles.
    ]
  ],
  [
    // Column 2: Instrument Safety & Precipitation Mitigations
    #rect(
      width: 100%,
      fill: purple-bg,
      stroke: (top: 2.0pt + purple, rest: 0.5pt + purple-border),
      radius: 2pt,
      inset: (x: 5.5pt, y: 3.5pt),
    )[
      #text(weight: "bold", size: 6.9pt, fill: purple)[INSTRUMENT CARE: RECOMMENDED COVERS & COLD PROTECTION]
      #v(1.5pt)
      - *Woodwind Pads & Moisture Protection:*
        - *Pad Sensitivity:* Clarinets, flutes, and saxophones have delicate pads that can swell or leak if exposed to moisture, light precipitation, or heavy condensation.
        - *Recommended Covers & Wraps:* Keeping clear plastic instrument rain hoods, bags, or ponchos draped over woodwinds in the stands when not playing helps protect pads.
        - *Thermal Care for Wooden Instruments:* Blowing warm breath into cold wooden instruments (grenadilla clarinets/oboes) can cause bore cracking. Warming instruments gradually inside a jacket and swabbing condensation regularly is recommended.
      - *Front Ensemble (Pit) Cold & Moisture Care:*
        - *Acoustic Percussion:* Rosewood marimba bars are sensitive to cold and dampness. Draping clear vinyl covers or tarps over marimbas and vibes until shortly before halftime helps protect tuning and finishes.
        - *Electronics & Power Drops:* Keyboards, synths, and mixers benefit from plastic shielding against dampness. Keeping power strips elevated slightly off the damp ground helps prevent electrical issues.
      - *Brass Low-Temperature Care:*
        - Valves and rotors can become sluggish in near-freezing temperatures. Applying appropriate valve oil before the game helps keep pistons moving freely. Emptying water keys onto a cloth rather than bleachers helps prevent slippery spots on walkways.
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
  inset: (x: 8.0pt, y: 3.5pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 6pt,
    align: (horizon, left),
    [
      #status-badge("ACTION TIPS", light-blue, navy, dark-blue)
    ],
    [
      #text(weight: "bold", size: 6.9pt, fill: navy)[RECOMMENDED SUGGESTIONS FOR CHAPERONES & SECTION LEADERS]
    ]
  )
  #v(2.0pt)
  #grid(
    columns: (1fr, 1fr),
    gutter: 10pt,
    [
      - *Uniform Layers:* Remind students about warm thermal underlayers, thick socks, and black marching gloves.
      - *Hand Warmers:* Have extra chemical hand warmers available for students in the stands between tunes.
      - *Instrument Bags:* Suggest students keep clear rain bags or protective covers handy in instrument cases.
    ],
    [
      - *Front Ensemble:* Keep protective vinyl covers on pit carts until pre-halftime staging.
      - *Hydration Reminders:* Periodically remind students to keep drinking water from their bottles.
      - *Footing Awareness:* Remind students to watch their footing on cold stadium ramps and bleacher steps.
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
  inset: (x: 7pt, y: 3.5pt),
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
      #text(fill: rgb("#e2e8f0"), size: 7.0pt, weight: "bold", tracking: 0.08em)[PINE CREEK HIGH SCHOOL MARCHING BAND • OPERATIONAL WEATHER BRIEFING] \
      #v(0.5pt)
      #text(fill: white, size: 10.8pt, weight: "bold")[PROP TEAM RIGGING & WIND SAFETY DIRECTIVE] \
      #v(0.5pt)
      #text(fill: rgb("#cbd5e0"), size: 6.8pt, weight: "bold")[{{EVENT_DATE_LONG}} • Game at {{VENUE_NAME}} & Unload at {{UNLOAD_LOCATION}}]
    ],
    [
      #align(right + horizon)[
        #box(
          fill: rgb("#2b6cb0"),
          radius: 2.5pt,
          inset: (x: 5.0pt, y: 2.0pt),
          stroke: 0.5pt + rgb("#63b3ed"),
          text(fill: white, size: 5.8pt, weight: "bold")[
            VOLUNTEER PROP CREW \
            {{VENUE_SHORT}} & {{UNLOAD_SHORT}}
          ]
        )
        #v(1.8pt)
        #box(
          fill: rgb("#1a202c"),
          radius: 2.5pt,
          inset: (x: 4.5pt, y: 1.8pt),
          stroke: 0.5pt + rgb("#cbd5e0"),
          align(center)[
            #text(fill: rgb("#e2e8f0"), size: 5.0pt, weight: "bold")[ISSUED: {{ISSUED_TIMESTAMP}}] \
            #text(fill: rgb("#fbd38d"), size: 5.2pt, weight: "bold")[{{LEAD_TIME_STRING}}]
          ]
        )
      ]
    ]
  )
]

// Prop Crew Operational Logistics Banner
#rect(
  width: 100%,
  fill: purple-bg,
  stroke: (left: 3.5pt + purple, rest: 0.65pt + purple-border),
  radius: (top: 0pt, bottom: 0pt),
  inset: (x: 7.0pt, y: 2.8pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 6pt,
    align: (top, left),
    [#status-badge("CREW WORKFLOW", purple-bg, purple, purple-border)],
    [
      #text(weight: "bold", size: 6.9pt, fill: purple)[TONIGHT'S PROP OPERATIONS WORKFLOW (FIRST HALF ASSEMBLY $arrow.r$ HALFTIME $arrow.r$ TEARDOWN): ]
      #text(size: 6.5pt, fill: rgb("#322659"))[
        *Pre-Game Assembly (Outside Stadium):* Prop crew works outside the stadium during the 1st half assembling Duck Blinds and prepping Backdrops. *Halftime Gate Push:* Band members join prop crew at the exterior staging pad to move props down the entrance tunnel chute. *Post-Show Packout:* Volunteers disassemble props, reload trucks, convoy back to {{UNLOAD_SHORT}}, unload warehouse, and return rental trucks.
      ]
    ]
  )
]

#v(1.0pt)

// Section 1: Prop Operations Timeline & Staging Hazards
#text(weight: "bold", size: 7.6pt, fill: navy)[1. PROP CREW LOGISTICS TIMELINE & VENUE-SPECIFIC WIND EXPOSURE]
#v(0.5pt)

#table(
  columns: (0.90fr, 1.20fr, 1.35fr, 1.75fr, 0.90fr, 0.90fr),
  align: (left + horizon, left + horizon, left + horizon, left + horizon, center + horizon, center + horizon),
  stroke: 0.35pt + gray-border,
  inset: (x: 2.5pt, y: 1.8pt),
  fill: (col, row) => {
    if row == 0 { rgb("#edf2f7") }
    else if row == {{PROP_HALFTIME_ROW_INDEX}} { rgb("#fffaf0") }
    else if calc.even(row) { rgb("#f8fafc") }
    else { white }
  },
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Time Window]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Operational Step]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Staging Zone & Wind Exposure]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Rigging & Ballast Guidelines]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Ballast Tier]],
  [#text(weight: "bold", size: 6.0pt, fill: navy)[Operational Hazard]],

{{PROP_TIMELINE_ROWS}}
)

#v(1.0pt)

// Section 2: Continuum 2026 Authoritative Wind Safety Chart
#text(weight: "bold", size: 7.6pt, fill: navy)[2. 2026 CONTINUUM PROP FLEET WIND TIERS & BALLASTING SPECIFICATION]
#v(0.5pt)

#table(
  columns: (0.90fr, 0.70fr, 0.70fr, 1.75fr, 2.15fr, 1.15fr, 0.90fr),
  align: (left + horizon, center + horizon, center + horizon, left + horizon, left + horizon, left + horizon, center + horizon),
  stroke: 0.35pt + gray-border,
  inset: (x: 2.8pt, y: 1.8pt),
  fill: (col, row) => {
    if row == 0 { rgb("#edf2f7") }
    else if row == {{ACTIVE_TIER_ROW_INDEX}} { rgb("#fffaf0") } // Active tier highlighted
    else if row == 5 { rgb("#fff5f5") } // Abort row
    else if calc.even(row) { rgb("#f8fafc") }
    else { white }
  },
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Operational Tier]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Sustained]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Peak Gusts]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Sideline Screens (16 Props)\ #text(size: 5.2pt, weight: "regular", fill: rgb("#4a5568"))[15-lb Handle Bags — Front Sideline]]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Rolling Backdrops (11 Props)\ #text(size: 5.2pt, weight: "regular", fill: rgb("#4a5568"))[Prioritized Hybrid Schedule]]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Inventory Status\ #text(size: 5.2pt, weight: "regular", fill: rgb("#4a5568"))[80 Bags / 22 Tubes]]],
  [#text(weight: "bold", size: 6.2pt, fill: navy)[Tonight's Call]],

  // Tier 0
  [⚪ *Tier 0* (Calm)],
  [0 – 8 mph],
  [$<= 10$ mph],
  [1 bag (15 lb) flat on rear rail C],
  [0 bags (153 lb dry prop cart)],
  [16/80 Sandbags • 0/22 Body Bags],
  [{{TIER0_STATUS_BADGE}}],

  // Tier 1
  [🟢 *Tier 1* (Normal)],
  [8 – 12 mph],
  [$<= 15$ mph],
  [2 bags (30 lb) flat on rear rail C],
  [4 sandbags (60 lb: 2 / wing post)],
  [76/80 Sandbags • 0/22 Body Bags],
  [{{TIER1_STATUS_BADGE}}],

  // Tier 2
  [🟡 *Tier 2* (Advisory){{TIER2_ACTIVE_MARKER}}],
  [*12 – 18 mph*],
  [*$<= 20$ mph*],
  [*3 bags (45 lb)* flat on rear rail C \ #text(size: 5.2pt, fill: rgb("#4a5568"))[24 bags/wagon (48 fleet total)]],
  [*1 "Body Bag" (70 lb tube sand)* taped to rear rail A with Gorilla Tape \ #text(size: 5.2pt, fill: rgb("#4a5568"))[Restoring moment: 434 ft-lb; safe gust 21.5 mph]],
  [*48/80 Sandbags* \ *11/22 Body Bags*],
  [{{TIER2_STATUS_BADGE}}],

  // Tier 3
  [🟠 *Tier 3* (High-Wind){{TIER3_ACTIVE_MARKER}}],
  [18 – 22 mph],
  [$<= 25$ mph],
  [4 bags (60 lb) flat on rear rail C \ #text(size: 5.2pt, fill: rgb("#4a5568"))[32 bags/wagon (64 fleet total)]],
  [2 "Body Bags" (140 lb) taped to rear rail A \ #text(size: 5.2pt, fill: rgb("#4a5568"))[Prop wt: 293 lb ($<300$ lb limit); safe gust 26.8 mph]],
  [64/80 Sandbags \ 22/22 Body Bags],
  [{{TIER3_STATUS_BADGE}}],

  // Tier 4
  [🔴 *Tier 4* (Abort)],
  [*> 20 mph sust.*],
  [*> 25 mph gust*],
  table.cell(colspan: 3)[
    #align(center)[
      #text(weight: "bold", size: 6.3pt, fill: alert-red)[
        ABSOLUTE NO-GO — PROPS DO NOT LEAVE TRUCK / TRAILER
      ] \
      #text(size: 5.4pt, fill: rgb("#742a2a"))[
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
      inset: (x: 5.5pt, y: 3.5pt),
    )[
      #text(weight: "bold", size: 6.9pt, fill: navy)[1ST HALF EXTERIOR ASSEMBLY DIRECTIVES]
      #v(1.5pt)
      - *Prevent "Kite" Effect Outside:* Unballasted screen frames catch wind instantly in the open parking lot. *Never leave an assembled Duck Blind standing upright without sandbags.* Stage screens riding flat on top of the stages until ready to stand up and ballast.
      - *Gorilla Tape Adhesion in Cold Air:* At cold temperatures (\<45°F), tape adhesive loses initial tack. Wipe any dew or condensation off the wooden rear rail before applying 4 wraps of Gorilla Tape across each 70-lb Body Bag.
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
      inset: (x: 5.5pt, y: 3.5pt),
    )[
      #text(weight: "bold", size: 6.9pt, fill: navy)[POST-PERFORMANCE PACKOUT & {{UNLOAD_SHORT}} UNLOAD]
      #v(1.5pt)
      - *Tunnel Egress Traction & Wheel Chocking:* Post-halftime tunnel push is uphill/sloped. Assign 3 students per cart (2 pushing at rear handles, 1 guiding at front) to maintain positive control. Use a spare 15-lb sandbag to chock wheels on downhill and/or downwind side.
      - *Crew Thermal PPE:* Teardown in cold weather requires volunteers to wear insulated work gloves (to avoid bare skin touching cold metal), safety vests, and headlamps.
      - *Two-Person Team Lift on Body Bags:* 70-lb tube sand is heavy, especially when cold and tired. Using two adults to lift each tube sand off carts and restow over truck axles is strongly recommended.
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
  inset: (x: 6.5pt, y: 2.8pt),
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 6pt,
    align: (horizon, left),
    [#status-badge("ABORT CEILING", alert-bg, alert-red, alert-border)],
    [
      #text(weight: "bold", size: 7.0pt, fill: alert-red)[
        ABSOLUTE PROP ABORT THRESHOLD: SUSTAINED > 20 MPH OR PEAK GUSTS > 25 MPH
      ] \
      #text(size: 6.3pt, fill: rgb("#742a2a"))[
        *Hard Safety Ceiling:* The Prop Lead carries a handheld digital anemometer at 6.0' AGL outside the stadium. If wind speeds sustained exceed *20 mph* or gusts exceed *25 mph* at T-45 min or at halftime call, the Prop Lead issues an immediate *NO-GO*. Props stay in trucks. *Per Core Philosophy: Props exist to support students; nothing on prop crew will ever compromise student safety or their show.*
      ]
    ]
  )
]
