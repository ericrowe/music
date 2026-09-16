#set document(
  title: "Pine Creek High School Marching Band — 2026 Continuum Field Prop Operations Guide",
  author: "PCHS Prop & Field Operations Crew",
  date: auto,
)

// Document typography and page geometry
#set page(
  paper: "us-letter",
  margin: (x: 0.68in, top: 0.72in, bottom: 0.72in),
  header: context {
    if counter(page).get().first() == 1 { return none }
    [
      #text(size: 8pt, fill: rgb("#4a5568"))[
        #grid(
          columns: (1fr, 1fr),
          align(left)[*Pine Creek High School Marching Band*],
          align(right)[*2026 Production: Continuum — Prop Operations Guide*]
        )
      ]
      #v(-3pt)
      #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    ]
  },
  footer: context [
    #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    #v(2pt)
    #text(size: 8pt, fill: rgb("#4a5568"))[
      #grid(
        columns: (1.5fr, 1.2fr, 1fr),
        align(left)[*FIELD VALIDATION — NOT RELEASED*],
        align(center)[*Release v0 (D3)* | September 2026],
        align(right)[Page #counter(page).display() of #counter(page).final().first()]
      )
    ]
  ]
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 9.5pt,
  fill: rgb("#1a202c"),
)

#set par(justify: true, leading: 0.65em)
#show table.cell: set par(justify: false)

// Styled Heading Hierarchy
#show heading.where(level: 1): it => {
  v(10pt)
  text(fill: rgb("#1a365d"), weight: "bold", size: 13pt)[#it]
  v(2.5pt)
}

#show heading.where(level: 2): it => {
  v(8pt)
  text(fill: rgb("#2b6cb0"), weight: "bold", size: 10.5pt)[#it]
  v(2pt)
}

#show heading.where(level: 3): it => {
  v(5pt)
  text(fill: rgb("#2d3748"), weight: "bold", size: 9.5pt)[#it]
  v(2pt)
}

// Callout & Card Components
#let callout(title: none, fill: rgb("#f7fafc"), stroke: rgb("#cbd5e0"), body) = {
  rect(
    width: 100%,
    fill: fill,
    stroke: 1pt + stroke,
    radius: 4pt,
    inset: (x: 9pt, y: 6pt)
  )[
    #if title != none [
      #text(weight: "bold", size: 9.5pt)[#title]
      #v(3pt)
    ]
    #body
  ]
}

// Unified alert formatting for critical safety mandates, penalties, and hard rules
#let alert(body) = text(weight: "bold", fill: rgb("#c53030"))[#body]

#let nogo-box(body) = callout(
  title: [🛑 #text(fill: rgb("#c53030"))[ABSOLUTE WIND NO-GO THRESHOLD (>20 MPH)]],
  fill: rgb("#fff5f5"),
  stroke: rgb("#e53e3e"),
  body
)

#let rule-box(title: "CRITICAL CBA COMPETITION RULE", body) = callout(
  title: [⚠️ #text(fill: rgb("#c05621"))[#title]],
  fill: rgb("#fffaf0"),
  stroke: rgb("#dd6b20"),
  body
)

#let job-card(role: "", personnel: "", tag: "", body) = {
  v(4pt)
  rect(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 1.2pt + rgb("#3182ce"),
    radius: 5pt,
    inset: (x: 9pt, y: 7pt)
  )[
    #grid(
      columns: (1fr, auto),
      gutter: 10pt,
      align(left + horizon)[
        #text(size: 10.5pt, weight: "bold", fill: rgb("#1a365d"))[#role]
        #if tag != "" [
          \ #v(2pt)
          #rect(
            fill: rgb("#ebf8ff"),
            stroke: 0.5pt + rgb("#bee3f8"),
            radius: 3pt,
            inset: (x: 5pt, y: 2pt)
          )[#text(size: 7.5pt, weight: "bold", fill: rgb("#2b6cb0"))[#tag]]
        ]
      ],
      align(right + top)[#text(size: 8.5pt, weight: "bold", fill: rgb("#4a5568"))[Crew: #personnel]]
    )
    #v(2pt)
    #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    #v(3pt)
    #body
  ]
}

// -------------------------------------------------------------------------
// COVER / HEADER BLOCK
// -------------------------------------------------------------------------

#align(center)[
  #text(size: 19pt, weight: "bold", fill: rgb("#1a365d"))[Pine Creek High School Marching Band]
  #v(-4pt)
  #text(size: 14pt, weight: "bold", fill: rgb("#2b6cb0"))[2026 Production: *Continuum* — Field Prop Operations Guide]
  #v(-2pt)
  #text(size: 9pt, style: "italic", fill: rgb("#718096"))[
    Volunteer Handbook with Step-by-Step Competition Day Procedures
  ]
]

#v(4pt)

#rect(
  width: 100%,
  fill: rgb("#edf2f7"),
  stroke: 1pt + rgb("#cbd5e0"),
  radius: 4pt,
  inset: (x: 8pt, y: 4.5pt)
)[
  #text(weight: "bold", fill: rgb("#2d3748"))[🌟 CORE PROGRAM PHILOSOPHY:]
  #v(2pt)
  #text(size: 9pt, fill: rgb("#1a202c"))[
    *The focus is always on the students' performance, not the props.* Props exist strictly to support and enhance the visual spectacle of the students' musicianship and marching. If conditions become hazardous or timing breaks down, props are abandoned or held back without hesitation. *Nothing we do on the prop crew will ever compromise a student's safety or their competitive show.*
  ]
]

// -------------------------------------------------------------------------
// SECTION 1: WIND SAFETY PLAN & NO-GO MATRIX (UP FRONT)
// -------------------------------------------------------------------------

= 1. Wind Safety Plan & Mandatory NO-GO Contingencies

Because Pine Creek High School operates in the high-altitude, wind-prone environment of Colorado Springs (6,500 ft ASL) and competes in open stadium venues, wind safety controls must be understood by every Adult Volunteer before touching a prop. 

#nogo-box[
  #alert[HARD RULE: If sustained winds exceed 20 mph OR gusts are forecasted/reported at 25–30 mph, PROPS DO NOT LEAVE THE TRUCK/TRAILER.]
  
  Last season confirmed that props in >20 mph winds create unacceptable safety risks for students and handlers. When this threshold is met, the Prop Lead makes an immediate #alert[NO-GO] call. Props remain securely locked in the equipment trailer or behind stadium bleachers. *The band performs a clean visual show without props.* If high winds are even possible, props stay off the turf.
]

#v(2pt)

#table(
  columns: (1fr, 0.85fr, 1.25fr, 1.35fr, 0.95fr),
  align: (center + horizon, center + horizon, left + horizon, left + horizon, center + horizon),
  stroke: 0.5pt + rgb("#cbd5e0"),
  inset: (x: 3.5pt, y: 2.5pt),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 5 { rgb("#fff5f5") } else { none },
  [*Wind Regime*#footnote[Without wind relief cuts, the props may be used by derating all wind regimes by 2 mph, decreasing the Tier 4 Abort threshold to 12 mph sustained / 16 mph gusts, and increasing the duck blind Tier 0 ballasting to 2 bags.]], [*Wind Velocity*], [*Duck Blind Ballasting*], [*Backdrop Ballasting*], [*Decision Status*],
  [⚪ *Tier 0: Calm*], [0 – 8 mph], [1 bag on rear rail C], [None (153 lb dry prop)], [*GO* (With Ballast)],
  [🟢 *Tier 1: Normal*], [8 – 12 mph], [2 bags on rear rail C], [4 bags (2/wing post)], [*GO* (Normal)],
  [🟡 *Tier 2: Advisory*], [12 – 18 mph], [3 bags on rear rail C], [6 bags (3/wing post)], [*GO* (With Ballast)],
  [🟠 *Tier 3: High-Wind*], [18 – 22 mph], [4 bags on rear rail C], [9 bags (6 wing + 3 rear rail)], [*CAUTION* (Max Limit)],
  [🔴 #alert[Tier 4: Abort]], [#alert[> 20 mph sust.] \ or #alert[> 25 mph gusts]], table.cell(colspan: 2)[#alert[ABSOLUTE NO-GO.] Props remain in trailer / truck. Field props will not be fielded. Prop Lead notifies Directors.], [#alert[NO-GO] (Hold in Truck)],
)

#v(1.5pt)
#text(size: 6.8pt, style: "italic", fill: rgb("#4a5568"))[
  *Semicircular Wind Relief Standard:* All 16 duck blinds (6 flaps, $2 times 3$ grid) and 10 rolling backdrops (8 flaps, $2 times 4$ primary grid in upper 6–8 ft zone) are equipped with standard semicircular wind relief cuts ($R = 4.0$ in., 8.0 in. chord by 4.0 in. drop, pre-punched 3/8 in. / 10 mm tear-arrest holes). Fabricated with the standardized PCHSMB Field Prop Circle Cutter (`circle_cutter_arm.stl`, #11 blade, dual 608 ball bearings) and 3/8-in. rotary punch. Flaps reduce drag by 15% ($C_d = 1.20 -> 1.02$), bleed dynamic gust impulses, suppress vortex flutter, and elevate forward stability (duck blind turf sliding to 17.8 mph; backdrop forward tipping to 16.9 mph at Tier 1 and 22.5 mph at Tier 3 via 3.46-ft rear-rail leverage) while maintaining 100% visual camouflage from spectator stands. (Backdrops with prominent central artwork may utilize the approved 6-flap minimal variant).
]

#pagebreak()

// -------------------------------------------------------------------------
// SECTION 2: COMPETITION DAY SCHEDULE & CONTACTS (FILLABLE)
// -------------------------------------------------------------------------

= 2. Competition Day Schedule & Contact Information

*Volunteers: Fill in the times and contacts below during morning check-in.* Keep this sheet accessible in your pocket or clipboard throughout competition day.

#table(
  columns: (2.3fr, 2fr, 3.2fr),
  align: (left + horizon, left + horizon, left + horizon),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 5pt, y: 3pt),
  [*Logistical Milestone*], [*Scheduled Time*], [*Specific Location / Gate Instructions*],
  [Competition & Venue], [ \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ ], [ Stadium: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ ],
  [Prop Lead of the Day], [ Name: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ ], [ *Cell Phone:* ( \_\_\_\_\_ ) \_\_\_\_\_ - \_\_\_\_\_\_\_\_ ],
  [Staging Area Location], [ Location / Area: ], [ \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ (Outside Stadium — Common Prop Zone) ],
  [Prop Staging Time], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ All props staged together; return here between Prelims & Finals ],
  [Equipment Truck Arrival], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Parking Lot / Bay: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ ],
  [Adult Volunteer Call Time], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Check-in at Equipment Trailer ],
  [Truck Unload & Assembly], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Equipment Trailer Lot / Staging Lot ],
  [Band Warm-up Departure], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Escort carts to Warm-up Zone / Gate ],
  [Prelims Prop Gate Queue], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ *Rear Entrance Gate* (Back Sideline) ],
  [*Prelims Performance*], [ *\_\_\_\_\_ : \_\_\_\_\_ AM / PM* ], [ *T&P Clock Starts on Judge's Signal* ],
  [Prelims Return to Staging], [ Immediate post-prelims ], [ Return props to Staging Area between runs ],
  [Finals Gate Queue (if adv.)], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Rear Entrance Gate ],
  [*Finals Performance*], [ *\_\_\_\_\_ : \_\_\_\_\_ AM / PM* ], [ Evening Performance Slot ],
  [Final Packdown & Depart], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Trailer locked & ready for transit ],
)

#v(4pt)

// -------------------------------------------------------------------------
// SECTION 3: CBA COMPETITION RULES FOR VOLUNTEERS
// -------------------------------------------------------------------------

= 3. Critical CBA Rules for Adult Volunteers

The Colorado Bandmasters Association (CBA) strictly enforces prop and adult volunteer regulations. #alert[Penalties directly deduct points from the students' score.] All props comply with Rule 8.08 (12-ft height ceiling; backdrops are 10 ft, blinds are 4 ft) and Rule 8.09 (Falcon Stadium 2025/2026 renovation gate clearances). Adhere strictly to the following:

#grid(
  columns: (1fr, 1fr),
  gutter: 7pt,
  rule-box(title: "Rule 9.07 — Field Passes")[
    *Maximum 25 wristbands per band.* Every Adult Volunteer stepping past the gate must wear the official CBA wristband on their wrist (not in pocket or on badge). Prelims and Finals use different colors.
  ],
  rule-box(title: "Rule 5.02 — Rear Entrance Mandate")[
    *Props must enter from the back sideline or rear end zone.* #alert[Never wheel props across the front boundary line] (reserved strictly for pit/percussion equipment). Handlers transit perimeter tracks.
  ],
  rule-box(title: "Rule 4.03 & 5.06 — 3:15 Setup Window")[
    The introductory announcement begins 3 minutes 15 seconds after judge's entry signal. #alert[ALL adults must be completely clear of the field before the announcement ends.] Target all Adult Volunteers off turf by *2:45*.
  ],
  rule-box(title: "Rule 4.03 — In-Show Turf Prohibition")[
    #alert[Adult Volunteers are strictly forbidden from touching the field during the performance] (0.2-point penalty per occurrence). Once you exit, remain behind the front sideline or rear perimeter track.
  ],
  rule-box(title: "Rule 8.05 — 2:00 Egress Clock")[
    Timing clock begins on final chord. All equipment and personnel must clear field boundaries within 2 minutes. With Two-Person Carry, student pairs carry assembled screens straight off the field to the staging area (~50–55s clearance; zero cart loading on field).
  ],
  rule-box(title: "Rule 8.05 — Double-Bagged Sandbags")[
    All ballast sandbags must be heavy-duty and double-bagged with intact plastic inner liners. #alert[Leaking sand on synthetic turf results in severe facility fines and competition penalties.]
  ]
)

#pagebreak()

// -------------------------------------------------------------------------
// SECTION 4: 2026 CONTINUUM PROP FLEET OVERVIEW
// -------------------------------------------------------------------------

= 4. 2026 Continuum Prop Fleet Summary

The 2026 visual design for *Continuum* incorporates three prop families totaling 34 field elements (16 Duck Blinds, 10 Rolling Backdrops, 4 Performance Stages, and 4 Mobile Staircases):

#table(
  columns: (1.6fr, 0.8fr, 1.4fr, 1.8fr, 2.4fr),
  align: (left + horizon, center + horizon, center + horizon, left + horizon, left + horizon),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 5pt, y: 4.5pt),
  [*Prop Category*], [*Quantity*], [*Transport Unit*], [*Field Placement*], [*Crew Allocation*],
  [*Duck Blinds* \ (Sideline Screens)], [16 screens (8 per side)], [Transport on 4 Stages (4/stage) \ between truck & staging; \ 2 Wagons for ballast; \ Direct Carry on field], [Front Sideline \ (Side 1: 20–41 yd; Side 2: 59–80 yd)], [2 Adult Duck Blind Managers & Ballast Handlers (1/side), \ 2 Student Ballast Handlers (1/side), \ 32 Student Performers (16 carry pairs)],
  [*Rolling Backdrops*], [10 backdrops], [10 Rolling Carts \ (1 cart/prop)], [Backfield / Back Hash \ (Spanned across 30–70 yds)], [2 Adult Volunteers (Managers), 20–40 Student Pushers (2–4 per backdrop)],
  [*Performance Stages & Stairs*], [4 stages (8 pieces) \ + 4 staircases], [8 Half-Platforms & \ 4 Mobile Staircases \ (carries 16 collapsed blinds \ [4/stage] truck-to-staging)], [Midfield / Side Stages \ (Exact drill marks per show)], [2 Adult Volunteers (Stage Managers), 16 Student Stage Handlers, 8 Student Staircase Handlers],
)

#v(4pt)
#text(size: 7.2pt, fill: rgb("#4a5568"))[
  *Authoritative Subproject Technical Manuals & Construction Deliverables:* \
  • *Duck Blinds / Sideline Screens:* See _Sideline Screen / Duck Blind Construction and Field Operations Manual_ (Release v0 (D34), 27 pages). Covers 3/4-in. EMT conduit framing, Two-Student Direct Carry, Section 2.9.3 engineered semicircular wind relief flaps (6 flaps, $R = 4.0$ in.), and on-prop placards. \
  • *Rolling Backdrops:* See _Backdrop Construction and Assembly Guide_ (Release v0 (D8), 28 pages). Covers 2x4 rolling cart base, 1-5/8-in. steel frame, 3/4-in. iron wing ballast posts, Section 2.9.3 semicircular wind relief flaps (8 flaps, $R = 4.0$ in.), and rear-rail leverage optimization. \
  • *Wind Relief Tooling:* Standardized _PCHSMB Field Prop Circle Cutter_ (`circle_cutter_arm.stl`, #11 hobby scalpel blade, dual 608 bearings, 3/8-in. rotary punch).
]

#v(4pt)

// -------------------------------------------------------------------------
// SECTION 5: STEP-BY-STEP JOB DESCRIPTIONS
// -------------------------------------------------------------------------

= 5. Individual Job Descriptions & Step-by-Step Instructions

*Find your assigned job card on the following pages. Each job is formatted as an independent, single-page operations sheet that can be printed and carried during competition day.*

The field prop operation is organized into four primary divisions:

1. *Job Group A: Duck Blind Operations (Pages 4–7):* Divided into four specialized single-page job blocks covering the Adult Duck Blind Manager & Ballast Handler (A.1, Page 4), the Student Ballast Handler (A.2, Page 5), the Student Two-Person Carry Deployment (A.3, Page 6), and the Student Two-Person Egress Sprint (A.4, Page 7).
2. *Job Group B: Rolling Backdrop Operations (Pages 8–10):* Divided into three specialized single-page job blocks covering adult backdrop managers (B.1), on-field student pushers (B.2), and off-field student pushers (B.3).
3. *Job Group C: Performance Stage Crew (Pages 11–13):* Divided into three specialized single-page job blocks covering Adult Stage Managers (C.1, Page 11), Student Stage Handlers (C.2, Page 12), and Student Staircase Handlers (C.3, Page 13).
4. *Job Group D: Prop Lead & Field Safety Coordinator (Page 14):* Master oversight, weather telemetry monitoring, judge liaison, and timing control.

Follow all instructions in strict sequential order. Adhere to all safety warnings and CBA competition boundaries.

#pagebreak()

// =========================================================================
// PAGE 4: JOB A.1 — ADULT DUCK BLIND MANAGER & BALLAST HANDLER
// =========================================================================

== Job Group A: Duck Blind Crew (16 Sideline Screens — Two-Person Direct Carry)

#job-card(
  role: "Job A.1: Adult Duck Blind Manager & Ballast Handler",
  personnel: "2 Adult Volunteers (1 per Side: Side 1 or Side 2)",
  tag: "Truck-to-Staging Transport on Stages, Setup, Wagon Ballast Walk & Post-Show Recovery"
)[
  #text(size: 8pt, style: "italic", fill: rgb("#2b6cb0"))[
    You are one of two Adult Duck Blind Managers & Ballast Handlers (Side 1 or Side 2, 8 screens each), paired with one Student Ballast Handler. Prior to show time: determine ballast tier, load your wagon, supervise stage-top transport of the 16 duck blinds (4/stage), and unfold screens in staging. Meet student carry pairs at staging to hand over blinds, then lead the wagon along the front sideline to deposit sandbags on turf. During egress: retrieve sandbags with your wagon, receive blinds at staging, collapse them, and reload 4 blinds onto each stage for transport to trucks.
  ]

  #v(1pt)
  #rect(
    width: 100%,
    fill: rgb("#ffffff"),
    stroke: 0.8pt + rgb("#cbd5e0"),
    radius: 3pt,
    inset: (x: 5pt, y: 2.5pt)
  )[
    #text(weight: "bold", size: 7.5pt, fill: rgb("#2b6cb0"))[DUCK BLIND BALLAST SCHEDULE (PER SIDE / 1 WAGON):]
    #v(1pt)
    #table(
      columns: (0.6fr, 1fr, 2.6fr, 1.8fr),
      align: center + horizon,
      stroke: 0.3pt + rgb("#cbd5e0"),
      inset: (x: 3pt, y: 1.5pt),
      fill: (col, row) => if row == 0 or row == 1 { rgb("#edf2f7") } else if row == 6 { rgb("#fff5f5") } else { none },
      table.cell(colspan: 2)[#text(size: 7pt, weight: "bold")[Wind Regime]],
      table.cell(rowspan: 2)[#text(size: 7pt, weight: "bold")[Sandbags Per Blind (On Ground Rail)]],
      table.cell(rowspan: 2)[#text(size: 7pt, weight: "bold")[Side Payload (8 Blinds / 1 Wagon)]],
      [#text(size: 6.5pt, weight: "bold")[Tier]],
      [#text(size: 6.5pt, weight: "bold")[Wind Speed]],
      [#text(size: 6.5pt)[0]], [#text(size: 6.5pt)[0–8 mph]], [#text(size: 6.5pt)[1 bag (15 lb)]], [#text(size: 6.5pt)[8 bags (120 lb)]],
      [#text(size: 6.5pt)[1]], [#text(size: 6.5pt)[8–12 mph]], [#text(size: 6.5pt)[2 bags (30 lb)]], [#text(size: 6.5pt)[16 bags (240 lb)]],
      [#text(size: 6.5pt)[2]], [#text(size: 6.5pt)[12–18 mph]], [#text(size: 6.5pt)[3 bags (45 lb)]], [#text(size: 6.5pt)[24 bags (360 lb)]],
      [#text(size: 6.5pt)[3]], [#text(size: 6.5pt)[18–22 mph]], [#text(size: 6.5pt)[4 bags (60 lb)]], [#text(size: 6.5pt)[32 bags (480 lb)]],
      [#text(size: 6.5pt, weight: "bold", fill: rgb("#c53030"))[4]],
      [#text(size: 6.5pt, weight: "bold", fill: rgb("#c53030"))[>20 mph]],
      [#text(size: 6.5pt, weight: "bold", fill: rgb("#c53030"))[NO-GO (Hold in Trailer)]],
      [#text(size: 6.5pt, weight: "bold", fill: rgb("#c53030"))[In Trailer (Do Not Deploy)]],
    )
  ]

  #v(1pt)
  #text(size: 6.8pt, style: "italic", fill: rgb("#4a5568"))[
    *Note:* All 16 duck blinds feature 6 standard semicircular wind relief slits ($C_d = 1.02$), reducing drag by 15% and raising turf sliding threshold to 17.8 mph.
  ]

  #v(1pt)
  #text(size: 7.5pt, weight: "bold", fill: rgb("#1a365d"))[Complete Event Lifecycle (Trucks $->$ Staging $->$ Sideline Walk $->$ Egress $->$ Trucks):]

  + *Arrival & Stage-Top Transport to Staging:* Meet at equipment truck at call time. Confirm wind tier with Prop Lead. Assist with unloading the trucks.  Work with the other prop managers to build all props to be deployed that day.  Load 4 collapsed duck blinds flat on top of each of the 4 stages (16 screens total) to distribute load to staging.
  + *Ballast Wagon Loading & Staging Setup:* At trucks, load wagon with double-bagged 15-lb sandbags handle-side up.
  + *Staging Transfer:* At the designated time, transfer with the stages to the staging area.  Note that in some location such as Falcon Stadium, there may be two staging areas in use.
  + *Staging Setup:* At the final staging area, unload blinds, unfold triangular frames, snap plastic clips.  Perform this before the students arrive.  Ensure you work with event personnel to keep egress areas clear for the band leaving the field.
  + *Student Rendezvous:* Meet assigned Student Ballast Handler and 8 student carry pairs (16 performers/side) at staging. Student handler joins you at wagon; students take over assembled screens.
  + *On-Field Wagon Ballast Walk:* Lead Student Ballast Handler pulling wagon along front sideline corridor. Walk past 8 screen marks; deposit sandbags on turf behind screens for student pairs to install.
  + *Field Boundary Rule (Clear by 2:45):* Clear turf immediately after depositing ballast. Target all adults off turf by *2:45* (before 3:15 announcement ends). Stand by in front sideline adult waiting area. #alert[Never touch turf during show (Rule 4.03 penalty)].
  + *Post-Show Egress Ballast Retrieval:* After final chord ($T = 0:00$), enter front sideline corridor with wagon and meet student handler. Reload sandbags left on turf by student pairs into wagon; egress through exit chute to staging area. #alert[WARNING (CBA Rule 5.05 & 5.03): Stay in front of goal post (front half of end zone); do not cross behind it. Do not leave field across front boundary until past the 30-yd line closest to exit chute!]
  + *Staging Reception & Student Departure:* Meet student pairs and Student Ballast Handler at staging. Students depart together to rejoin band block.
  + *Collapsing & Stage Reload:* Release snap clips, fold screens flat, and load 4 flat screens onto each stage platform for return transport to trucks.
  + *Truck Loading:* At end of night, supervise loading of screens onto truck for return to Pine Creek.
]

#pagebreak()

// =========================================================================
// PAGE 5: JOB A.2 — STUDENT BALLAST HANDLER
// =========================================================================

== Job Group A: Duck Blind Crew (Continued)

#job-card(
  role: "Job A.2: Student Ballast Handler",
  personnel: "2 Students (1 assigned to each Adult Manager: Side 1 or Side 2)",
  tag: "On-Field Wagon Movement, Ballast Unloading & Post-Show Reloading Only"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    *Student Instructions:* You are assigned directly to your side's Adult Duck Blind Manager (Side 1 or Side 2). Meet your adult manager at the outside staging area following warm ups, move with your adult manager on field to assist with on-field unloading (depositing ballast) and reloading (post-show retrieval) only, and depart at the same time as the student carry teams.
  ]
  #v(4pt)

  + *Staging Area Rendezvous (Post Warm-up):*
    - Meet your assigned Adult Duck Blind Manager at the common prop staging area outside the stadium after your warmups.
    - The adult manager will have already transported the blinds and loaded your side's ballast wagon with the day's designated sandbags.
    - Confirm with the adult manager how many ballast sandbags to use for that day based on weather conditions.
    - Rendezvous at your side's wagon and prepare for stadium gate entry. Coordinate instrument staging with your section leader.
  + *On-Field Wagon Movement & Unloading (Deployment):*
    - Accompany your adult manager pulling/guiding the ballast wagon onto the field along the front sideline corridor.
    - At each of the 8 screen coordinate marks on your side, assist your adult manager in neatly unloading and depositing the designated sandbags onto the turf approximately 1 yard inside the front sideline (to leave room for the screen to be placed first).
    - Arriving student carry pairs (walking across from the back sideline) will pick up these sandbags and install them onto the screens.
  + *Transition to Opening Drill Set:*
    - Visually confirm all ballast bags have been placed and assist any student screen handlers that may need it.
    - Move quickly to your first set position.
  + *Post-Show On-Field Ballast Reloading:*
    - After the show and per your section leader's direction, return to the location where you left the adult handler, who will return from the sideline and meet you at this location.
    - The student carry pairs will have placed their sandbags on the turf and sprinted off.
    - Rapidly lift and reload all resting sandbags off the turf back into the wagon with zero doubling back. 
    - #alert[SAFETY: LIFT WITH LEGS, NOT BACK; NEVER DROP OR THROW BAGS.]
  + *Egress & Departure with Student Teams:*
    - Maintain continuous forward momentum pulling the reloaded wagon through the exit chute directly to the common outside staging area.
    - At the outside staging area, hand the wagon over to your adult manager. (The adult manager handles screen collapsing and stage-top reloading).
    - Return to the band.
]

#pagebreak()

// =========================================================================
// PAGE 6: JOB A.3 — STUDENT TWO-PERSON CARRY DEPLOYMENT
// =========================================================================

== Job Group A: Duck Blind Crew (Continued)

#job-card(
  role: "Job A.3: Student Two-Person Carry Deployment",
  personnel: "32 Student Performers (16 Pairs: 8 pairs on Side 1, 8 pairs on Side 2)",
  tag: "Staging Takeover, Backfield Queue, Synchronized Walk-Across & Ballast Placement"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    *Student Instructions:* You and your assigned partner carry one fully assembled 26-lb duck blind (13 lbs/student). You meet the Adult Duck Blind Manager at the staging area, take over your pre-assembled screen, queue on the backfield, walk across on the entry signal, deposit on your yard mark, and place the ballast sandbags deposited by the wagon crew onto your screen.
  ]
  #v(4pt)

  + *Staging Area Takeover (T-45 min):*
    - Meet the Adult Duck Blind Manager at the common prop staging area outside the stadium 45 minutes prior to show time (the shared staging area for all props, defined per venue location).
    - Locate your assigned screen (Screens 1–8 on Side 1 or Side 2) and confirm your front sideline yard mark.
    - Confirm your screen has been assembled by the adults: rear triangular frame swung out, both 3D snap clips locked rigid onto Rail 3 with a firm click.
  + *Rear Gate Entry & Backfield Queue:*
    - Lift the fully assembled 26-lb duck blind between you (13 lbs per student), carrying your instrument in your other hand.
    - Transit the perimeter track through the rear stadium entrance gate (CBA Rule 5.02) and queue along the back sideline directly across from your assigned front sideline coordinate mark.
  + *The Synchronized Walk-Across:*
    - When the CBA Timing & Penalties judge signals permission to enter, all 16 student pairs walk straight across the field to the front sideline.
  + *Sequential Center-Outward Placement & Alignment:*
    - *Center-Outward Placement:* Screen placement begins at the center (midfield) position. The center pair places their screen firmly on their yard mark first, followed sequentially by the next pair, then the next, moving progressively outward. This center-outward sequence guarantees exact spacing and eliminates gaps or crowding.
    - *Sighting & Final Alignment:* While waiting for the ballast wagon to reach your position, sight down the sideline to fine-tune lateral alignment so all 8 adjacent screen edges align perfectly flush into an unbroken front visual wall.
  + *Ballast Installation from Wagon Deposit:*
    - The Adult Manager and Student Ballast Handler have walked their wagon along the front sideline and deposited your required sandbags on the turf at your mark approximately 1 yard behind the front sideline.
    - Pick up the sandbags and place them over the rear bar on the ground.
  + *Transition to Opening Drill Set:*
    - Confirm screen rigidity and transition briskly to your opening drill position.
]

#pagebreak()

// =========================================================================
// PAGE 7: JOB A.4 — STUDENT TWO-PERSON EGRESS SPRINT
// =========================================================================

== Job Group A: Duck Blind Crew (Continued)

#job-card(
  role: "Job A.4: Student Two-Person Egress Sprint",
  personnel: "32 Student Performers (16 Pairs: 8 on Side 1, 8 on Side 2)",
  tag: "Post-Show Ballast Release, Two-Person Egress Sprint & Staging Hand-Off"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    *Student Instructions:* Safely leave your ballast on the turf, grab your assembled screen between partners, move quickly out through the exit gate to the staging area, and hand control back to the Adult Duck Blind Manager.
  ]
  #v(4pt)

  + *Immediate Action on Final Show Chord ($T = 0:00$):*
    - Per your section leader's direct, at the completion of the show, break ranks and both partners converge on your assigned duck blind.
  + *Leave Ballast on Turf (Do Not Carry):*
    - *Safe Ballast Removal:* Lift all sandbags off the rear ground rail and place them gently onto the turf next to the rail.
    - #alert[CRITICAL SAFETY MANDATE: NEVER THROW OR DROP SANDBAGS.] Dropping sandbags causes seam rupture and leaks sand, resulting in CBA score penalties. Place bags gently on the turf.
    - *Leave the bags on the turf!* The Adult Duck Blind Manager and Student Ballast Handler will retrieve them with their wagon.
  + *The Two-Person Carry Sprint:*
    - Lift the fully assembled 26-lb duck blind between you, carrying your instrument in your other hand.
    - Maintain a steady, brisk pace straight down the front sideline corridor and through the designated stadium exit gate / tunnel chute.
  + *Direct Transit to Staging Area & Hand-Off:*
    - Maintain continuous forward momentum through the exit gate / tunnel mouth along the perimeter path directly to the common prop staging area outside the stadium.
    - Meet your Adult Duck Blind Manager at the staging area.
    - Hand custody of the duck blind back to the Adult Manager (the adult manager will collapse the screen and load it onto a stage platform for transport).
    - Rejoin the band.
]

#pagebreak()

// =========================================================================
// PAGE 8: JOB B.1 — ADULT ROLLING BACKDROP MANAGERS
// =========================================================================

== Job Group B: Rolling Backdrop Crew (10 Backdrops on Dedicated Carts)

#job-card(
  role: "Job B.1: Adult Rolling Backdrop Managers",
  personnel: "2 Adult Volunteers (Overseeing Backdrops #1 through #10)",
  tag: "Assembly Supervision, Staging Logistics, Ballast & Student Oversight"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    You are one of two Adult Volunteers in charge of the 10 rolling backdrops. You supervise and direct the assembly and disassembly of these props with assistance from prop and pit crew members, ensure all 10 props are transported to and from staging with appropriate wind ballast installed, and meet, supervise, and assist the student pusher teams at the staging area.
  ]

  #v(2pt)
  #rect(
    width: 100%,
    fill: rgb("#ffffff"),
    stroke: 0.8pt + rgb("#cbd5e0"),
    radius: 3pt,
    inset: (x: 5pt, y: 3.5pt)
  )[
    #text(weight: "bold", size: 8pt, fill: rgb("#2b6cb0"))[ROLLING BACKDROP BALLAST SCHEDULE (PER BACKDROP):] \
    #v(1pt)
    #table(
      columns: (0.75fr, 0.85fr, 1.4fr, 1.4fr, 0.85fr),
      align: center + horizon,
      stroke: 0.3pt + rgb("#cbd5e0"),
      inset: (x: 3pt, y: 1.8pt),
      fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 5 { rgb("#fff5f5") } else { none },
      [*Tier*], [*Wind MPH*], [*15-lb Sandbags (Wing Iron Posts)*], [*Supplemental Rail Ballast*], [*Safe Gust*],
      [Tier 0], [0 – 8], [0 bags (unballasted, 153 lb dry prop)], [None], [14.4 mph],
      [Tier 1], [8 – 12], [4 bags (2 per wing post, 60 lb ballast)], [None], [16.9 mph],
      [Tier 2], [12 – 18], [6 bags (3 per wing post, 90 lb ballast)], [None], [18.4 mph],
      [Tier 3], [18 – 22], [6 bags (3 per wing post, 90 lb ballast)], [3 bags flat on rear 2x4 rail (45 lb)], [22.5 mph],
      table.cell(colspan: 2)[#alert[Tier 4 (>20 mph)]],
      table.cell(colspan: 3)[#alert[ABSOLUTE NO-GO — Keep Locked in Equipment Trailer]],
    )
    #v(1pt)
    #text(size: 6.6pt, style: "italic", fill: rgb("#4a5568"))[
      *Rear-Rail Leverage & Relief Cuts:* All 10 backdrops feature 8 semicircular relief flaps (R = 4", 8" chord x 4" drop, upper 6–8 ft zone, $C_d = 1.02$). Placing 3 sandbags across the rear rail yields 3.46 ft lever arm to front casters (vs 1.71 ft on wing posts)—more than double (2.02x) leverage against forward tipping.
    ]
  ]

  #v(2pt)
  #text(size: 8pt, weight: "bold", fill: rgb("#1a365d"))[Step-by-Step Manager Lifecycle:]

  + *Arrival & Assembly Supervision:* Meet at the equipment trailer at call time. Supervise and direct the mechanical assembly of the 10 rolling backdrop carts (installing steel upright posts, diagonal struts, retaining pins, and vinyl banners with snap clamps). Confirm all 8 semicircular wind relief flaps hang flush and swing freely. Verify all strut pins and safety cotters are fully engaged.
  + *Ballast Installation & Pre-Staging Inspection:* Confirm the day's wind tier with the Prop Lead. Seat double-bagged 15-lb sandbags securely over wing iron posts (4 bags Tier 1; 6 bags Tier 2; 6 wing + 3 rear rail bags for Tier 3 22.5 mph stability). Inspect swivel casters and confirm caster foot brakes are in unlocked (UP) position for transit.
  + *Transport to Staging Area:* Lead the transport of all 10 ballasted backdrops from the trailer lot to the designated staging area at the designated staging time. Park carts in numerical order (#1 through #10) and engage wheel brakes.
  + *Student Rendezvous & Supervision at Staging Area:* Meet the assigned Student Backdrop Pushers (2–4 students per backdrop) at the staging area 45 minutes prior to show time. Confirm each student team knows their backdrop number, entry queue sequence, and field position. Supervise and assist the students as they prepare for gate movement.
  + *Adult Field Boundary Rule:* Adults do not push backdrops onto the field. Move with the students onto the field during setup to assist any that need help and check field placement, and then quickly move off the field to the adult volunteer waiting area in front of the front sideline. #alert[Never step onto the turf during the show (Rule 4.03 penalty).]
  + *Post-Show Reception & Return to Trailer:* Meet the student pushers as they return with the backdrops to the staging area following their end zone egress. Take custody of the backdrops from the students so they can rejoin the band block. Push the backdrops back to the staging area (between Prelims and Finals) or to the equipment trailer (after Finals).
  + *Post-Finals Disassembly Supervision:* Direct the safe deballasting (#alert[never drop or throw sandbags]) and mechanical disassembly of frames for secure trailer packing.
  + *Trailer Loading:* Assist the transport team with the secure loading of the trailer for return to Pine Creek.
  + *Trailer Unloading:* Return to Pine Creek and assist with the unloading of the trailer and storage of the props.
]

#pagebreak()

// =========================================================================
// PAGE 9: JOB B.2 — STUDENT BACKDROP PUSHERS (ON FIELD)
// =========================================================================

== Job Group B: Rolling Backdrop Crew (Continued)

#job-card(
  role: "Job B.2: Student Backdrop Pushers — On Field",
  personnel: "20–40 Students (2–4 per Backdrop, #1 through #10)",
  tag: "Staging Takeover, Backfield Entry & Show Positioning"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    *Student Instructions:* You are part of the team of 2 to 4 students assigned to roll your backdrop (#1 through #10) from the staging area onto the field and position it as directed at your marked coordinate.
  ]
  #v(4pt)

  + *Staging Area Takeover:*
    - Meet the Adult Backdrop Managers at the designated staging area 45 minutes prior to show time (following your section warm-ups).
    - Locate your assigned backdrop (#1 through #10).
    - Inspect the 8 semicircular wind relief flaps in the upper banner to confirm they are flush and hanging cleanly by gravity.
    - Confirm all cart caster foot brakes are disengaged (foot lever UP) before moving. For directional stability, push from the rear steering side using the steel uprights, but plan ahead for turns.
  + *Perimeter Transit to Back Sideline:*
    - When directed by the Adult Managers / Prop Lead, take custody of your backdrop and roll it along the designated perimeter track toward the rear stadium entrance gate.
    - Queue in strict numerical order (#1 at front, #10 at rear).
    - Always push using the steel frame uprights. #alert[NEVER push directly against the vinyl display face.]
  + *Back Sideline Staging:*
    - Move through the rear gate and stage along the back sideline directly in line with your final field coordinate.
    - #alert[CRITICAL BOUNDARY RULE: DO NOT CROSS THE BACK SIDELINE MARKERS.] Keep cart wheels completely behind the sideline until the on-field judge gives official entry permission. Doing so will immediately invoke an official CBA penalty.
  + *Field Ingress & Positioning:*
    - When the CBA judge signals entry permission, push your backdrop briskly straight forward onto the field toward your marked coordinate.
    - Steer smoothly; avoid sharp pivots that could scrub or tear synthetic turf infill.
    - Align the front edge of the wood base cart precisely with the yard line and hash mark specified on your coordinate sheet.
  + *Orientation, Rotation & Securing:*
    - Rotate the backdrop display face to the exact angle and orientation instructed during rehearsal training.
    - Confirm all sandbags remain securely seated over the iron posts.
    - If directed by Adult Backdrop Managers (Tier 3 high-wind), confirm the 3 supplemental sandbags remain placed across the rear framing rail.
  + *Transition to Opening Show Position:*
    - Briskly transition to your opening drill position before the introductory announcement ends. You are now cleared for the show!
]

#pagebreak()

// =========================================================================
// PAGE 10: JOB B.3 — STUDENT BACKDROP PUSHERS (OFF FIELD)
// =========================================================================

== Job Group B: Rolling Backdrop Crew (Continued)

#job-card(
  role: "Job B.3: Student Backdrop Pushers — Off Field",
  personnel: "20–40 Students (2–4 per Backdrop, #1 through #10)",
  tag: "Post-Show Egress Sprint & Staging Hand-Off"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    *Student Instructions:* The 2-minute CBA egress clock begins the instant the final note of the show sounds. You are responsible for immediately reaching your assigned backdrop, preparing it for transport, rolling it off the field via the nearest front-half end zone route, and returning it to the staging area.
  ]
  #v(4pt)

  + *Immediate Post-Show Rendezvous:*
    - As directed by your section leader following the show, move immediately to your assigned backdrop (#1 through #10).
  + *Prep for Moving:*
    - If any sandbags were placed across the back rail, move them to the iron posts for transport.
    - If any sandbags were placed as wheel chocks, move them to the iron posts for transport.
  + *Straight-Line Egress to Front Half of End Zone:*
    - Push the backdrop in a straight line toward the closest point located on the *front half of the end zone* (away from the backfield pit/battery flow per CBA field clearance routing).
    - Maintain brisk, continuous forward momentum. #alert[NEVER stop on the turf to adjust equipment, rest, or talk.]
    - Push strictly by the steel uprights; #alert[never push against the vinyl graphic face].
  + *Continuous Motion Past Gate to Staging Area:*
    - Roll through the end zone boundary line and directly into the stadium exit gate / tunnel chute.
    - Roll the backdrop along the perimeter path directly to the designated staging area as directed by the Adult Backdrop Managers.
  + *Hand-Off to Adult Backdrop Managers:*
    - Park the backdrop in proper numerical alignment in the staging area.
    - Hand custody of the backdrop back to the Adult Backdrop Managers.
    - Rejoin the band.
]

#pagebreak()

// =========================================================================
// PAGE 11: JOB C.1 — ADULT STAGE MANAGERS
// =========================================================================

== Job Group C: Performance Stage Crew (4 Platforms, 8 Pieces & 4 Staircases)

#job-card(
  role: "Job C.1: Adult Stage Managers",
  personnel: "2 Adult Volunteers (Overseeing Platforms & Staircases #1–#4)",
  tag: "Assembly, Vinyl Installation, Staging Lineup & Student Oversight"
)[
  #text(size: 8pt, style: "italic", fill: rgb("#2b6cb0"))[
    You are one of two Adult Volunteers in charge of the 4 performance stage platforms (8 mobile pieces) and 4 mobile staircases. You supervise mechanical assembly, vinyl installation, lineup order, staging logistics, and student oversight for 16 Stage Handlers and 8 Staircase Handlers.
  ]

  #v(1.5pt)
  #rect(
    width: 100%,
    fill: rgb("#ffffff"),
    stroke: 0.8pt + rgb("#cbd5e0"),
    radius: 3pt,
    inset: (x: 5pt, y: 2.5pt)
  )[
    #text(weight: "bold", size: 7.5pt, fill: rgb("#2b6cb0"))[STAGE PLATFORM & STAIRCASE FLEET CONFIGURATION:] \
    #v(1pt)
    #table(
      columns: (0.9fr, 1.25fr, 1fr, 1.6fr),
      align: center + horizon,
      stroke: 0.3pt + rgb("#cbd5e0"),
      inset: (x: 4pt, y: 1.5pt),
      fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
      [*Platform*], [*Stage Pieces*], [*Assigned Stairs*], [*Lineup Order & Configuration*],
      [Platform \#1], [2 Pieces (Front + Back)], [Staircase \#1], [\#1F $->$ \#1B $->$ Stairs \#1 (vinyl pinned)],
      [Platform \#2], [2 Pieces (Front + Back)], [Staircase \#2], [\#2F $->$ \#2B $->$ Stairs \#2 (vinyl pinned)],
      [Platform \#3], [2 Pieces (Front + Back)], [Staircase \#3], [\#3F $->$ \#3B $->$ Stairs \#3 (vinyl pinned)],
      [Platform \#4], [2 Pieces (Front + Back)], [Staircase \#4], [\#4F $->$ \#4B $->$ Stairs \#4 (vinyl pinned)],
    )
  ]

  #v(1.5pt)
  #text(size: 7.5pt, weight: "bold", fill: rgb("#1a365d"))[Step-by-Step Manager Lifecycle:]

  + *Assembly Supervision:* Supervise mechanical assembly of the 8 stage pieces and 4 staircases. Verify structural pins and caster mounts are securely seated.
  + *Vinyl Covering Installation:* Install vinyl coverings and skirt graphics. Ensure bridging seam flap on each front piece is pinned back securely for transport so it cannot drag or catch.
  + *Label Verification & Lineup Order:* Verify each piece is labeled (Platform \#1–\#4, Front "F" vs Back "B", Stairs \#1–\#4). Queue pieces with front leading, back following, stairs behind.
  + *Staging Transit & Duck Blind Coordination:* Lead transport of stage pieces to staging. *Coordinate with Adult Duck Blind Managers:* four (4) collapsed duck blinds are loaded flat on top of each stage platform (16 screens total) to distribute weight between trucks and staging.
  + *Student Rendezvous (T-45 min):* Meet 16 Stage Handlers and 8 Staircase Handlers in staging. Confirm assignments and supervise gate movement preparation.
  + *On-Field Setup & Boundary Rule:* Adults assist during setup (verify alignment, ensure seam velcro is sealed flat, stairs seated). Move off turf before show begins. #alert[Never step onto turf during show (Rule 4.03 penalty).]
  + *Post-Show Reception & Duck Blind Reload:* Meet handlers at staging after end zone egress. *Duck Blind Reload:* Coordinate with Duck Blind Managers as they stack 4 collapsed duck blinds flat on each stage platform. Push to staging (between runs) or trailer (after Finals).
  + *Post-Finals Teardown & Loading:* Direct vinyl removal, piece disassembly, and assist with secure trailer loading and unloading at Pine Creek.
]

#pagebreak()

// =========================================================================
// PAGE 12: JOB C.2 — STUDENT STAGE HANDLERS
// =========================================================================

== Job Group C: Performance Stage Crew (Continued)

#job-card(
  role: "Job C.2: Student Stage Handlers",
  personnel: "16 Students (2 Handlers per Piece, Platforms #1–#4)",
  tag: "Staging Takeover, Field Alignment, Seam Velcro & Egress"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    *Student Instructions:* You are part of the team of 2 students assigned to your labeled stage piece (Front Half or Back Half of Platform \#1, \#2, \#3, or \#4). You roll your piece from staging onto the field, lock it in precision alignment with your partner piece, seal the center vinyl seam flap, and sprint it off the field at the end of the show.
  ]
  #v(4pt)

  + *Staging Area Takeover:*
    - Meet the Adult Stage Managers at the designated staging area 45 minutes prior to show time.
    - Locate your assigned labeled stage piece (e.g., Piece \#1F Front, Piece \#1B Back, Piece \#2F Front, Piece \#2B Back, etc.).
    - Confirm with your partner and Adult Managers that your caster wheel brakes are unlocked for transit.
  + *Perimeter Transit to Back Sideline:*
    - When directed by the Adult Stage Managers / Prop Lead, roll your piece along the perimeter track toward the rear stadium entrance gate.
    - *Queue in strict labeled lineup order:* Front pieces (\#F) must lead immediately ahead of their corresponding back pieces (\#B).
    - Stage along the back sideline directly in line with your final field coordinate.
    - #alert[CRITICAL BOUNDARY RULE: DO NOT CROSS THE BACK SIDELINE MARKERS.] Keep wheels completely behind the sideline until the on-field judge signals official entry permission.
  + *Field Ingress & Front Piece Positioning:*
    - When the CBA entry signal is given, push your piece briskly straight forward onto the field toward your marked coordinate.
    - *Front Half (\#F) Team:* Roll directly onto your coordinate mark, align the front edge flush with the yard line and hash mark specified on your sheet, and *immediately step on all caster foot brake levers to lock wheels.*
  + *Back Piece Alignment & Caster Lock:*
    - *Back Half (\#B) Team:* Push directly behind the front half, align the framing flush and tight against the rear edge of the front piece, and *immediately step on all caster foot brake levers to lock wheels.*
  + *Seam Closure (Vinyl Flap & Velcro):*
    - Unpin the protective vinyl flap that was pinned back for transport on the front piece.
    - Pull the flap smoothly across the joint seam to bridge the gap between the front and back pieces.
    - Press the flap firmly down along the heavy-duty velcro strip on the rear piece to create a smooth, seamless performance surface.
  + *Transition to Opening Performance Position:*
    - Briskly transition to your opening drill position before the introductory announcement ends. You are now cleared for the show!
  + *Immediate Post-Show Rendezvous & Prep:*
    - As directed by your section leader following the show, move immediately to your assigned stage piece.
    - *Pull up the velcro seam flap and pin it back securely* onto the front piece for transport.
    - Kick all caster foot brake levers UP into the UNLOCKED position.
  + *Straight-Line Egress & Handoff:*
    - Push your piece in a straight line toward the closest point located on the *front half of the end zone*.
    - Maintain continuous rolling motion through the gate chute along the perimeter path to the staging area as directed by the Adult Stage Managers.
    - Park in numerical alignment, hand custody back to the Adult Stage Managers, and rejoin the band.
]

#pagebreak()

// =========================================================================
// PAGE 13: JOB C.3 — STUDENT STAIRCASE HANDLERS
// =========================================================================

== Job Group C: Performance Stage Crew (Continued)

#job-card(
  role: "Job C.3: Student Staircase Handlers",
  personnel: "8 Students (2 Handlers per Staircase, Staircases #1–#4)",
  tag: "Transport on Side, Stage Flip, Precision Placement & Egress"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    *Student Instructions:* You are part of the team of 2 students assigned to one of the 4 mobile staircases (assigned to Stage Platforms \#1 through \#4). Under the supervision of the Adult Stage Managers, you roll your staircase on its side using its integrated transport casters, wait for your stage platform to assemble on field, then push the staircase into place, flip it upright onto its base, and seat it tight against the stage.
  ]
  #v(4pt)

  + *Staging Area Takeover:*
    - Meet the Adult Stage Managers at the designated staging area 45 minutes prior to show time.
    - Locate your assigned labeled staircase (Staircase \#1, \#2, \#3, or \#4, matching your assigned Stage Platform).
    - Confirm the staircase is resting on its side on its dedicated transport casters and that wheels roll smoothly.
  + *Perimeter Transit to Back Sideline:*
    - When directed by the Adult Stage Managers / Prop Lead, push your staircase along the perimeter track toward the rear stadium entrance gate.
    - *Queue in sequence immediately behind your assigned Stage Platform:* The two stage platform pieces (\#F and \#B) lead first, followed immediately by their assigned staircase (\#1 through \#4).
    - Stage along the back sideline directly in line with your final stage field coordinate.
    - #alert[CRITICAL BOUNDARY RULE: DO NOT CROSS THE BACK SIDELINE MARKERS.] Keep casters completely behind the sideline until the on-field judge signals official entry permission.
  + *Field Ingress & Standby Behind Stage:*
    - When the CBA entry signal is given, push your staircase briskly straight forward onto the field following directly behind your stage platform pieces.
    - Hold the staircase on its side 5 to 10 feet behind the stage mark while the Stage Handlers (Job C.2) align the front and back pieces, lock casters, and seal the center velcro seam.
  + *Stage Approach, Flip & Handle Lift:*
    - Once the stage platform pieces are fully locked and rigid, push your staircase up to its designated access side.
    - With both students coordinating firmly, carefully flip the staircase from its transport side onto its bottom base.
    - Using the built-in lifting handles, lift and slide the staircase snugly into its final position against the stage platform framing.
    - #alert[CRITICAL FIT CHECK:] Minimize any physical gap between the top stair tread and the stage platform decking. Ensure the staircase rests completely flat, level, and stable on the turf.
  + *Transition to Opening Performance Position:*
    - Briskly transition to your opening drill position before the introductory announcement ends. You are now cleared for the show!
  + *Post-Show Rendezvous & Flip to Transport:*
    - As directed by your section leader following the show, move immediately to your assigned staircase.
    - Grasp the built-in lifting handles and pull the staircase back slightly from the stage platform.
    - Carefully flip the staircase back onto its side onto its transport casters.
  + *Straight-Line Egress & Handoff:*
    - Push your staircase on its casters in a straight line toward the closest point located on the *front half of the end zone*.
    - Maintain continuous rolling motion through the gate chute along the perimeter path to the staging area as directed by the Adult Stage Managers.
    - Park in proper numerical alignment, hand custody back to the Adult Stage Managers, and rejoin the band.
]

#pagebreak()

// =========================================================================
// PAGE 14: JOB D.1 — PROP LEAD & FIELD SAFETY COORDINATOR
// =========================================================================

== Job Group D: Prop Lead & Field Safety Coordinator

#job-card(
  role: "Job D.1: Prop Lead & Field Safety Coordinator",
  personnel: "1–2 Experienced Prop Directors / Adult Leads",
  tag: "Master Operations, Weather Monitoring, Gate Liaison & Timing Control"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    You are the overall director and safety coordinator for the 34 field props and the 6 dedicated Prop Crew Adult Volunteers (the majority of the band's 25 CBA adult credentials support the Pit / Front Ensemble). You maintain authoritative weather telemetry, coordinate directly with CBA timing and penalty officials at the stadium gate, execute the countdown clearance call, and manage exit flow.
  ]
  #v(3pt)

  + *Weather Monitoring & Plain-English Weather Sources:*
    - *Handheld Anemometer:* Carry a calibrated handheld digital anemometer to measure live surface wind speed at field level in the trailer lot, staging area, and sideline at morning check-in and 30 minutes prior to gate step-off.
    - *Decoded Airport Weather Feeds:* Official airport weather reports (METARs) use pilot shorthand (e.g., `18015G24KT`). *Do not try to decipher raw pilot code.* Use these recommended tools in plain-English / decoded mode:
      - *AviationWeather.gov (Decoded Mode):* Enter the 4-letter station code for the nearest airport (`KCOS` for Colorado Springs Airport, `KFLY` for Meadow Lake / Falcon, `KBJC` for Rocky Mountain Metro / North Denver, `KAPA` for Centennial / South Denver, `KFNL` for Northern Colorado). Toggle *"Decoded"* to read sustained wind speed and gusts in plain MPH.
      - *Windy.com / Windy App:* Set display units to MPH. Displays real-time surface wind animations, local airport readings, and forecasted wind gusts at stadium coordinates.
      - *Weather Underground (Wunderground):* Search the venue address to view live 1-minute wind and gust readings from Personal Weather Stations (PWS) in the stadium's immediate neighborhood.
    - *Wind Tier Authorization:* Authorize the day's operational wind tier (Tier 0 through Tier 3) and direct ballast loading across backdrops and duck blinds per the Ballast Schedules.
    - #alert[HARD RULE: If sustained winds exceed 20 mph OR gusts reach 25–30 mph, issue an immediate NO-GO directive.] Props remain locked in trailers. Notify Band Directors immediately.
  + *Judge Liaison & Gate Release:*
    - Coordinate directly with the CBA Timing & Penalty (T&P) judge at the stadium gate.
    - Confirm official clock start protocols and verify gate chute clearances.
    - Signal the prop pushers and student teams the instant official entry permission is granted.
  + *The 2:45 Clearance Call & Field Safety:*
    - Monitor stopwatch from the moment props cross the gate boundary.
    - At the 2:30 mark, loudly call *"PROPS CLEAR!"* down the sideline and confirm all 6 Prop Crew Adult Volunteers (and nearby Pit crew adults) are moving behind boundary lines.
    - Ensure 100% of adult personnel are completely off the turf and across the front/back sideline markers before the 3:15 announcement begins #alert[(strictly avoid Rule 4.03 penalties)].
  + *Exit Chute & Traffic Management:*
    - Position yourself at the stadium exit gate during post-show egress.
    - Ensure continuous rolling motion through the tunnel chute per CBA Rule 8.05; prevent student or prop bottlenecks.
    - Direct returning props along designated perimeter paths back to the staging area or equipment trailer lot.
]

#pagebreak()

// =========================================================================
// PAGE 15: SECTION 6 — POST-SHOW PACKDOWN, CHECKLIST & SIGNOFF
// =========================================================================

= 6. Post-Show Deballasting & Trailer Packdown

All teardown and packdown procedures occur *exclusively in the equipment trailer parking lot* after clearing the stadium exit gate.  The transportation team is responsible for all loading activity, and will direct props personnel in the correct loading method and sequence.

+ *Deballasting Safety:* Remove sandbags from backdrop retention posts and duck blind ground rails. Place bags gently into the designated area inside the equipment trailer. #alert[Never drop or throw sandbags] (protects seams and plastic liners).
+ *Duck Blind & Screen Packing:* Duck blinds are returned from the staging area on top of the stages (4 per stage), then unloaded and stacked onto truck cross braces and secured.
+ *All-Clear Check:* Inspect the staging lot for personal belongings, water bottles, and tools. Verify all adult volunteer wristbands across prop and pit crews are accounted for before departing.

#v(10pt)

#rect(
  width: 100%,
  fill: rgb("#edf2f7"),
  stroke: 0.5pt + rgb("#cbd5e0"),
  radius: 4pt,
  inset: (x: 10pt, y: 8pt)
)[
  #grid(
    columns: (1fr, auto),
    align(left)[
      #text(weight: "bold", size: 9pt, fill: rgb("#2d3748"))[Pine Creek High School Marching Band • Field Operations Crew] \
      #text(size: 8pt, fill: rgb("#718096"))[2026 Competitive Field Show: Continuum • Colorado Bandmasters Association]
    ],
    align(right + horizon)[
      #text(size: 8pt, weight: "bold", fill: rgb("#3182ce"))[Release v0 (D3) • September 2026]
    ]
  )
]
