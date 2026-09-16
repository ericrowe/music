#set document(
  title: "Pine Creek High School Marching Band — Sideline Screen / Duck Blind Construction and Field Operations Manual",
  author: "PCHS Prop & Field Operations Crew",
  date: auto,
)

#let appendix-id = state("appendix-id", "")
#let appendix-title = state("appendix-title", "Sideline Screen / Duck Blind Manual")

// Helper function to generate clean running headers
#let make-header(title) = [
  #text(size: 8pt, fill: rgb("#4a5568"))[
    #grid(
      columns: (1fr, 1fr),
      align(left)[*Pine Creek High School Marching Band*],
      align(right)[*#title*]
    )
  ]
  #v(-3pt)
  #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
]

// Document typography and page geometry
#set page(
  paper: "us-letter",
  margin: (x: 0.68in, top: 0.72in, bottom: 0.72in),
  header: none,
  footer: context {
    let app = appendix-id.get()
    let pg = counter(page).get().first()
    let pg-str = if app == "" {
      str(pg)
    } else {
      app + "-" + str(pg)
    }
    line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    v(2pt)
    text(size: 8pt, fill: rgb("#4a5568"))[
      #grid(
        columns: (1.5fr, 1.2fr, 1fr),
        align(left)[*WORKING DRAFT — NOT FOR USE*],
        align(center)[*Release v0 (D34)* | September 2026],
        align(right)[*Page #pg-str*]
      )
    ]
  }
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 8.8pt,
  fill: rgb("#2d3748"),
  spacing: 120%,
)

#set par(
  justify: true,
  leading: 0.52em,
)

#show raw: set text(size: 6pt, font: ("Menlo", "DejaVu Sans Mono", "Courier New", "Courier"), spacing: 100%, tracking: 0pt)

// Reusable formatting helpers
#let primary(body) = text(fill: rgb("#1a365d"), weight: "bold")[#body]
#let accent(body) = text(fill: rgb("#2b6cb0"), weight: "bold")[#body]
#let subhead(body) = text(fill: rgb("#2d3748"), weight: "bold", size: 9.5pt)[#body]

#show heading.where(level: 1): it => block(below: 8pt, above: 12pt)[
  #text(fill: rgb("#1a365d"), weight: "bold", size: 13pt)[#it]
  #v(-4pt)
  #line(length: 100%, stroke: 1.2pt + rgb("#1a365d"))
]

#show heading.where(level: 2): it => block(below: 6pt, above: 10pt)[
  #text(fill: rgb("#2b6cb0"), weight: "bold", size: 10.5pt)[#it]
]

#show heading.where(level: 3): it => block(below: 4pt, above: 7pt)[
  #text(fill: rgb("#2d3748"), weight: "bold", size: 9.2pt)[#it]
]

#show heading.where(level: 4): it => block(below: 3pt, above: 5pt)[
  #text(fill: rgb("#4a5568"), weight: "bold", size: 8.8pt)[#it]
]

#let callout(title: none, fill: rgb("#f7fafc"), stroke: rgb("#cbd5e0"), body) = {
  rect(
    width: 100%,
    fill: fill,
    stroke: 0.8pt + stroke,
    radius: 3pt,
    inset: (x: 8pt, y: 6pt),
    outset: 0pt,
  )[
    #if title != none [
      #text(weight: "bold", size: 8.5pt, fill: rgb("#1a365d"))[#title] \
      #v(2pt)
    ]
    #body
  ]
}

#let alert(body) = text(weight: "bold", fill: rgb("#c53030"))[#body]

#let nogo-box(body) = callout(
  title: [🛑 #text(fill: rgb("#c53030"))[ABSOLUTE WIND NO-GO THRESHOLD (>20 MPH)]],
  fill: rgb("#fff5f5"),
  stroke: rgb("#e53e3e"),
  body
)

#let warning-box(title: "OPERATIONAL WARNING", body) = callout(
  title: [⚠️ #text(fill: rgb("#c05621"))[#title]],
  fill: rgb("#fffaf0"),
  stroke: rgb("#dd6b20"),
  body
)

#let note-box(title: "NOTE", body) = callout(
  title: [ℹ️ #text(fill: rgb("#2b6cb0"))[#title]],
  fill: rgb("#ebf8ff"),
  stroke: rgb("#bee3f8"),
  body
)

#let blank(w) = box(width: w, stroke: (bottom: 0.6pt + rgb("#718096")), baseline: 1pt)[]
#let chk = box(width: 8.5pt, height: 8.5pt, stroke: 0.7pt + rgb("#4a5568"), radius: 1.5pt, baseline: 1.5pt)[]

#let appendix-cover(
  kicker: "APPENDIX",
  title: "Title",
  subtitle: "Subtitle",
  body-text: [],
  audience: [],
  contents: [],
  print-label: [],
  revision: [Release v0 (unreleased) | Development build D34 | September 2026],
  separation-note: [When separated from the master document, keep this cover as the first page.]
) = [
  #align(center)[
    #text(size: 8.5pt, weight: "bold", fill: rgb("#718096"), tracking: 1.5pt)[
      PART OF THE SIDELINE SCREEN / DUCK BLIND CONSTRUCTION AND FIELD OPERATIONS MANUAL
    ]
    #v(14pt)
    #rect(fill: rgb("#ebf8ff"), stroke: 1pt + rgb("#bee3f8"), radius: 4pt, inset: (x: 12pt, y: 6pt))[
      #text(size: 13pt, weight: "bold", fill: rgb("#2b6cb0"), tracking: 2pt)[#kicker]
    ]
    #v(6pt)
    #text(size: 22pt, weight: "bold", fill: rgb("#1a365d"))[#title]
    #v(-4pt)
    #text(size: 10.5pt, style: "italic", fill: rgb("#4a5568"))[#subtitle]
  ]
  #v(14pt)
  #rect(width: 100%, fill: rgb("#f7fafc"), stroke: 1pt + rgb("#cbd5e0"), radius: 6pt, inset: 12pt)[
    #text(size: 9.5pt, fill: rgb("#2d3748"))[#body-text]
    #v(8pt)
    #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    #v(6pt)
    #grid(
      columns: (auto, 1fr),
      row-gutter: 7pt,
      column-gutter: 12pt,
      [*Target Audience:*], [#audience],
      [*Document Contents:*], [#contents],
      [*Print / Carry Scope:*], [#print-label],
      [*Parent Revision:*], [#revision],
    )
  ]
  #v(18pt)
  #rect(width: 100%, fill: rgb("#fffaf0"), stroke: 1pt + rgb("#fbd38d"), radius: 4pt, inset: (x: 10pt, y: 7pt))[
    #text(size: 8.5pt, style: "italic", fill: rgb("#744210"))[
      *Separation Notice:* #separation-note
    ]
  ]
]

// =========================================================================
// COVER & OVERVIEW (PAGE 1)
// =========================================================================

#align(center)[
  #text(size: 9.5pt, weight: "bold", fill: rgb("#718096"))[PINE CREEK HIGH SCHOOL MARCHING BAND • 2026 PRODUCTION: CONTINUUM] \
  #v(3pt)
  #text(size: 15pt, weight: "bold", fill: rgb("#1a365d"))[Sideline Screen / Duck Blind] \
  #v(2pt)
  #text(size: 11pt, weight: "bold", fill: rgb("#2b6cb0"))[Construction & Field Operations Manual] \
  #v(1pt)
  #text(size: 8pt, fill: rgb("#4a5568"))[Nominal 4 ft × 8 ft Folding Field Prop • Two-Person Direct Carry • Semicircular Wind Relief Flaps]
]

#v(3pt)

#rect(
  width: 100%,
  fill: rgb("#f7fafc"),
  stroke: 0.8pt + rgb("#cbd5e0"),
  radius: 3pt,
  inset: (x: 8pt, y: 5pt)
)[
  #grid(
    columns: (1.1fr, 0.9fr),
    gutter: 8pt,
    [
      *Primary Prop Identity & Function:* \
      The nominal 4 ft × 8 ft sideline screen ("duck blind") provides the marching band and color guard with a concealed, professional visual staging barrier along the front sideline. It conceals auxiliary floor equipment (rifles, sabres, flags) and creates a private backstage staging area for rapid costume changes and instrument transitions during competitive performances.
      
      #v(2pt)
      *Structural Architecture:* \
      Constructed from lightweight 3/4-in. EMT galvanized steel conduit, heavy-duty commercial pipe-clamp fittings, and custom 3D-printed ASA components. The entire rear triangular support frame collapses coplanar inside the perimeter framing to a nested storage thickness of *under 2.0 inches*.
    ],
    [
      #grid(
        columns: (1fr, 1fr),
        gutter: 6pt,
        align(center)[
          #image("assets/approved/duck_blind_unfolded.jpg", height: 0.98in)
          #v(2pt)
          #text(size: 6.5pt, fill: rgb("#718096"))[*Deployed State (Triangular)*]
        ],
        align(center)[
          #image("assets/approved/duck_blind_folded.jpg", height: 0.98in)
          #v(2pt)
          #text(size: 6.5pt, fill: rgb("#718096"))[*Folded State (Nested)*]
        ]
      )
    ]
  )
]

#v(3pt)

== Document Controls & Version History

#text(size: 7.5pt)[
#table(
  columns: (0.7fr, 0.9fr, 1.2fr, 3.2fr),
  align: (center + horizon, center + horizon, center + horizon, left + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 11 { rgb("#ebf8ff") } else { none },
  inset: (x: 3.5pt, y: 1.8pt),
  [*Version*], [*Date*], [*Document State*], [*Key Modifications & Engineering Decisions*],
  [D24], [2026-09-01], [Working draft], [Imported legacy v24 draft as controlled repository baseline.],
  [D25], [2026-09-01], [Working draft], [Standardized status markings, footers, and visible version history table.],
  [D26], [2026-09-01], [Working draft], [Standardized document architecture, 2026 CBA rules, and cost breakdown tables.],
  [D27], [2026-09-09], [Working draft], [Added vinyl installation procedure, dimensions specifications, and tape/clamp schedule.],
  [D28], [2026-09-10], [Working draft], [Added aerodynamic wind loading analysis, tiered ballasting schedule, and volunteer guide.],
  [D29], [2026-09-11], [Working draft], [Updated field operations with preliminary cart study and asymmetric backfield staging.],
  [D30], [2026-09-13], [Working draft], [Full Typst rewrite. Adopted Two-Student Direct Carry (16 pairs walk assembled; zero transport carts built, saving \$440). Standardized 6 true semicircular wind relief flaps (R = 4.0 in., 8.0 in. chord by 4.0 in. drop, pre-punched 3/8 in. / 10 mm holes, 15% drag reduction). Updated complete wind stability tables.],
  [D31], [2026-09-15], [Working draft], [Harmonize document architecture, section numbering (1.1–1.7, 2.1–2.10), Appendix A/B ordering, coordinate schedule tables, and Circle Cutter tooling with Backdrop manual.],
  [D32], [2026-09-15], [Working draft], [Add equipment truck packout figure (Section 1.7). Harmonize Appendix A pagination (Pages A-1 through A-7) with Backdrop manual.],
  [D33], [2026-09-15], [Working draft], [Clarify wind relief NO-CUT zones to explicitly protect printed graphic details, depicted faces, and logos.],
  [*D34*], [*2026-09-15*], [*Working draft*], [*Add ASCII diagram illustrating wind relief cut locations ($2 times 3$ grid, 6 semicircular flaps) in Appendix B Section 2.9.3.*],
)
]

#v(2pt)

== Master Manual Organization & Quick-Reference Guide

#text(size: 8pt)[
- *Appendix A: Field Operations Manual (Sections 1.1–1.7):* Field-facing guide covering roles & responsibilities, the 15-minute CBA time budget, Two-Student Direct Carry deployment (55.7s, +139s buffer) and egress (55.0s, +65s buffer), zero carts, Section 1.5 full tiered wind stability tables, 2026 CBA rules, and trailer packout.
- *Appendix B: Construction & Fabrication Manual (Sections 2.1–2.10):* Complete shop guide covering safety, materials BOM, tools and circle cutter, 3D printing parameters, the 7-stick conduit cutting schedule, cost breakdown, 4-stage frame assembly, bare-frame inspection QC checklist, vinyl mounting, and Section 2.9.3 dedicated semicircular wind relief flap cutting ($R = 4.0$ in., 15% drag drop), and purchasing index.
- *Appendix C: On-Prop Laminated Field Operations Placard:* Print-ready on-prop laminated field placard for instant field reference.
- *Appendix C.1: 4 in. × 6 in. Field Placement Card Template:* Position coordinate card template for each screen location.
- *Appendix D: Parent Volunteer Competition Day Guide & Checklist:* Time-indexed milestone checklist for competition day crew.
]

#pagebreak()

// =========================================================================
// APPENDIX A: FIELD OPERATIONS MANUAL (PAGE A-1 COVER)
// =========================================================================

#set page(header: none)
#appendix-id.update("A")
#appendix-title.update("APPENDIX A | FIELD OPERATIONS MANUAL")
#counter(page).update(1)

#appendix-cover(
  kicker: "APPENDIX A",
  title: "Field Operations Manual",
  subtitle: "Two-Student Carry deployment, 15-minute time budget, wind stability, and 2026 CBA competition rules",
  body-text: [
    This appendix is designed as a complete, independently printable work packet which can be distributed separately to parent volunteers, student stage crew, and field handlers.
  ],
  audience: [Field operators, adult duck blind managers, and student carry pairs],
  contents: [Time budget architecture; Two-Student Carry deployment & egress; tiered ballasting; 2026 CBA rules; trailer packout],
  print-label: [All pages labeled A-],
  revision: [Release v0 (unreleased) | Development build D34 | September 2026],
  separation-note: [When separated from the master document, keep this cover as the first page of Appendix A.]
)

#pagebreak()

// =========================================================================
// APPENDIX A: CONTENT PAGES (A-2 THROUGH A-7)
// =========================================================================
#set page(header: make-header("APPENDIX A | FIELD OPERATIONS MANUAL"))

= Appendix A: Field Operations Manual

== 1.1 Roles & Division of Responsibilities

Field execution of the sideline screens relies on a coordinated division of responsibility between adult logistics managers and student performers:

=== A. Parent Logistics Crew & Duck Blind Managers:
- *Stage Transport:* Prior to gate call, managers transport screens from equipment trucks onto 4 mobile stages (4 screens nested flat per stage) to the common outside staging area. Setup screens, verify clips and wind flaps, and load ballast wagons.
- *Ballast Wagon Teams:* Two adult managers and two student ballast handlers manage wagons carrying double-bagged 15-lb sandbags along the sideline corridor.
- *Gate & Boundary Management:* Ensure all adults clear the performance turf before the 2:45 mark to avoid CBA Rule 4.03 boundary penalties. All parents assisting on field must wear designated Field Pass wristbands (strictly limited to 25 per band per Rule 9.07).

=== B. Student Carry Pairs (Performers):
- *Two-Student Direct Carry:* 16 student pairs carry assembled screens (13 lbs per student) directly onto the field.
- *Synchronized Walk-Across:* Pairs walk in synchronized formation across the field, place screens on assigned front sideline marks, and seat sandbag ballast over rear rail *C*.
- *Post-Show Sprint:* At the final chord, pairs gently place sandbags on turf and sprint assembled screens directly through the exit gate into the staging lot.

== 1.2 Staging, Transport & Field Gate Entry

Under Colorado Bandmasters Association (CBA) Rule 5.01 and Rule 5.06, competitive field shows operate within a rigid *15-minute 00-second (900.0-second)* master clock interval:

$T_"total" = T_"deploy" + T_"announce" + T_"performance" + T_"egress" <= "15:00 (900 seconds)"$

#grid(
  columns: (1.2fr, 0.8fr),
  gutter: 10pt,
  [
    - *The Fungible Time Tradeoff:* The 2:00 egress window is an operational planning benchmark, not a hard standalone rule. Shaving time off deployment transfers directly into the egress and performance budget!
    - *Rule 5.09 Early Announcement Signal:* A band director may signal the Timing & Penalties judge early once props and performers are set, starting the 35-second announcement ahead of the 3:15 cap.
    - *Two-Student Carry Slack Creation:* By deploying in just *55.7 seconds*, the band banks *+139.3 seconds (~2 min 19s)* of safety slack, eliminating all egress time anxiety.
    - *Rule 5.02 Rear Entrance Mandate:* All screens must enter from the back sideline or rear end zone gates. Never transit props through the front sideline gate.
  ],
  figure(
    image("assets/simulation/cba_15min_time_budget_cycle.png", width: 100%),
    caption: [CBA 15-minute time budget dynamic operational cycle.]
  )
)

#pagebreak()

== 1.3 Field Deployment Protocol

Stochastic Monte Carlo simulation ($N = 5,000$ randomized trials) establishes Two-Student Carry as the fastest, safest field deployment paradigm:

#table(
  columns: (1.8fr, 1.1fr, 1.1fr, 1.1fr, 1.1fr, 1.8fr),
  align: (left + horizon, center + horizon, center + horizon, center + horizon, center + horizon, left + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 1 { rgb("#ebf8ff") } else { none },
  inset: (x: 4pt, y: 3pt),
  [*Deployment Strategy*], [*Mean Time*], [*P95 Time*], [*P99 Time*], [*Success ($<= "3:15"$)*], [*Operational Status / Notes*],
  [*Two-Student Carry (16 Pairs)*], [*55.7 s (0:56)*], [*58.3 s*], [*59.7 s*], [*100.0%*], [★ *Primary Standard (+139s buffer)*],
  [2 Carts (Pre-Set Receivers)], [133.9 s (2:14)], [148.5 s], [156.6 s], [100.0%], [Superseded Cart Baseline (+61s)],
  [2 Carts (Mobile Pincer)], [198.0 s (3:18)], [213.4 s], [221.7 s], [38.6%], [Failed Cart Option (Violates 3:15)],
  [1 Cart (All 16 Screens, 786 lb)], [234.1 s (3:54)], [263.9 s], [280.2 s], [0.2%], [Infeasible (99.8% Failure Rate)],
)

#v(3pt)

=== Pre-Show Deployment Walkthrough (Expected: 55.7s | Rule Cap: 3:15)
1. *Pre-Staging Lineup:* 16 student pairs carry assembled screens (13 lbs/student) through the rear stadium entrance gate (CBA Rule 5.02) and queue along the back sideline/end zone directly across from their assigned front yard marks.
2. *The Walk-Across ($T = "0:00"$):* On the T&P judge's starting signal, all 16 student pairs walk simultaneously straight across the field in synchronized formation (~55 yards at 1.1 yd/s).
3. *Center-Outward Placement, Alignment & Ballasting ($T = "0:45 to 0:55"$):* Pairs place screens sequentially starting at the center (midfield) position and moving outward to guarantee exact spacing. While waiting for the ballast wagon, pairs sight down the line to achieve flush visual alignment, then seat sandbags (deposited on turf by the wagon walk) over rear rail *C*.
4. *Clear Field ($T <= "0:58"$):* Student pairs transition directly into opening drill sets. Field is completely clear of prop equipment and adult volunteers in *under 1 minute*, banking *+139 seconds* with *0.0% adult boundary penalty risk*!

#pagebreak()

== 1.4 Post-Performance Retrieval & Continuous Exit

At the final chord, student pairs grasp their assembled screens and sprint directly through the exit gate:

#table(
  columns: (1.8fr, 1fr, 1.1fr, 1.1fr, 1.1fr, 1.9fr),
  align: (left + horizon, center + horizon, center + horizon, center + horizon, center + horizon, left + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 1 { rgb("#ebf8ff") } else { none },
  inset: (x: 4pt, y: 3pt),
  [*Egress Strategy & Venue*], [*Ballast*], [*Mean Time*], [*P95 Time*], [*Success ($<= "2:00"$)*], [*Operational Status / Notes*],
  [*Two-Student Carry (Single Exit)*], [*Tier 1*], [*55.1 s (0:55)*], [*61.0 s*], [*100.0%*], [★ *Primary Standard (+65s buffer)*],
  [*Two-Student Carry (Dual Exit)*], [*Tier 1*], [*35.5 s (0:36)*], [*38.9 s*], [*100.0%*], [★ *Dual-Exit Benchmark (+84s)*],
  [Cart Reload Outside Gate], [Tier 1], [99.9 s (1:40)], [113.8 s], [98.8%], [Superseded Cart Baseline (+20s)],
  [Cart Reload Inside Gate], [Tier 1], [121.4 s (2:01)], [136.7 s], [46.7%], [Unacceptable Risk (Fails 2:00)],
  [Traditional On-Field Cart Loading], [Tier 1], [153.4 s (2:33)], [171.2 s], [0.0%], [Catastrophic Failure (100% Fail)],
)

#v(3pt)

=== Post-Show Egress Walkthrough (Expected: 55.0s | Benchmark: 2:00)
1. *Final Show Chord ($T = "0:00"$):* Assigned student pairs converge on their screen. Lift ballast sandbags gently to turf next to the rail. #alert[NEVER DROP OR THROW SANDBAGS.]
2. *The Sprint ($T = "0:05 to 0:55"$):* Grasp upright rails and jog straight down the front sideline corridor directly into the stadium exit chute / tunnel mouth. Field clears in *~50–55 seconds*.
3. *Inward Ballast Sweep:* Two adult duck blind managers and two student ballast handlers enter from off-field with their wagons and retrieve resting sandbags toward the exit gate with zero doubling back.
4. *Staging Hand-Off & Stage Transit:* Performers jog through the exit gate to the common outside staging area (shared by all props) and hand screens back to adult managers. Managers collapse screens flat and load 4 screens onto each of the 4 stages for transport back to the trucks.

#v(4pt)
#align(center)[
  #figure(
    image("assets/simulation/egress_strategy_comparison.png", width: 85%),
    caption: [Egress strategy timing comparison (Two-Student Carry vs cart options).]
  )
]

#pagebreak()

== 1.5 Ballasting System, Aerodynamic Stability & Tiered Wind Safety Protocols

Aerodynamic pressure ($q = 0.001989 times V_"mph"^2$ psf at Colorado Springs 6,500 ft ASL, $rho = 0.0595" lb/ft"^3$) creates two distinct failure modes for the 30.5 sq ft screen face ($z_"cp" = 1.94" ft"$):
- *Lateral Turf Sliding ($mu approx 0.35$):* The primary operational limit. Smooth steel conduit on crumb-rubber turf slides horizontally *before* tipping occurs. Semicircular slits drop drag by 15% ($C_d = 1.20 -> 1.02$), raising the Tier 1 sliding threshold from 16.4 mph to *17.8 mph*.
- *Forward Tipping Asymmetry:* Rear wind has an effective unballasted restoring arm of only 4.25 in. ($M_"rest" = 9.2" ft-lb"$), tipping at 8.8 mph. Placing two 15-lb bags over rear ground rail *C* (2.29 ft arm) adds +68.7 ft-lb, boosting tipping resistance to *25.5 mph* with zero clip stress!

=== Complete Aerodynamic Stability Envelope & Tiered Ballast Schedule

#table(
  columns: (1.1fr, 0.9fr, 1.5fr, 1.3fr, 1.3fr, 0.9fr),
  align: (left + horizon, center + horizon, left + horizon, center + horizon, center + horizon, center + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 5 { rgb("#fff5f5") } else { none },
  inset: (x: 3.5pt, y: 2.2pt),
  [*Wind Tier*#footnote[Without wind relief cuts, the props may be used by derating all wind regimes by 2 mph, decreasing the Tier 4 Abort threshold to 12 mph sustained / 16 mph gusts, and increasing the duck blind Tier 0 ballasting to 2 bags.]], [*Wind Velocity*], [*Ballast Configuration*], [*Solid Face (Slide / Tip)*], [*With Slits (Slide / Tip)*], [*Status*],
  [Tier 0: Calm], [0 – 8 mph], [0 bags (dry wt 26 lb)], [11.2 / 8.1 mph], [*12.1 / 8.8 mph*], [*GO* (Dry)],
  [Tier 1: Normal], [8 – 12 mph], [2 bags on rear rail C (56 lb)], [16.4 / 23.5 mph], [*17.8 / 25.5 mph*], [*GO* (Normal)],
  [Tier 2: Advisory], [12 – 18 mph], [3 bags (2 ground C + 1 hang, 71 lb)], [18.5 / 28.5 mph], [*20.0 / 30.9 mph*], [*GO* (Ballast)],
  [Tier 3: High-Wind], [18 – 22 mph], [4 bags (2 ground C + 2 hang, 86 lb)], [20.3 / 32.8 mph], [*22.1 / 35.6 mph*], [*CAUTION*],
  [#alert[Tier 4: Abort]], [#alert[> 20 sust.] \ #alert[> 25 gust]], table.cell(colspan: 3)[#alert[ABSOLUTE NO-GO.] Props remain locked in trailer. Do not field props.], [#alert[NO-GO]],
)

#v(2pt)
#nogo-box[
  *Weather Monitoring Protocol:* The Prop Lead carries a digital handheld anemometer and monitors decoded airport METAR feeds (`KCOS`, `KFLY`, `KBJC`, `KAPA`) and Wunderground PWS stations. If sustained winds exceed 20 mph or gusts reach 25–30 mph, props do not enter the performance field.
]

#pagebreak()

== 1.6 Applicable 2026 CBA Competition Rules

#note-box(title: "ANNUAL RULEBOOK NOTICE")[
  This section reflects governing rules for the 2026 competitive season. Staff and build leads must review this section annually against updated CBA and BOA rulebooks to verify continuing compliance.
]

=== Rule 4.02: Emergency Assistance & Safety Exceptions
- *Medical Emergency (Rule 4.02(c)):* *NO PENALTY.* Any band member becoming ill or injured during performance may be assisted from the field by an adult volunteer, parent, staff member, EMT, or CBA official without penalty.
- *High-Wind Prop Safety Restraint (Rule 4.02(a)):* If high winds threaten props falling over, adults may enter the field for the sole purpose of securing the prop. At no time during the performance may an adult move the prop as part of visual choreography.

=== Rule 4.03 & 5.06: Field Clearance & Adult Turf Penalty
- *Field Clearance Window:* All adult volunteers assisting with props *must be completely clear* of the performance field before the introductory announcement ends (commences 3:15 after entry permission). Any adult still on field when announcement ends incurs an immediate *0.2 point score penalty* for the band.
- *Re-Entry Prohibition:* Adults are strictly prohibited from entering or re-entering the performance field during the show. Unauthorized entry incurs an immediate *0.2 point penalty per occurrence*.

=== Rule 5.02: Rear Entrance Mandate
- *Gate Ingress Routing:* All props and equipment must enter from the back sideline or rear end zone gates. #alert[Never enter across the front boundary line] (reserved strictly for pit equipment).

=== Rule 8.05: Props, Equipment, Surface Protection, and Double-Bagging
- *Gate Ingress:* All props and equipment must be designed and of a quantity such that they can be brought onto the Performance Field from the band entrance gate.
- *Continuous Movement:* Following the end of the band's Performance, all props and equipment must be in continuous movement until entirely removed from the stadium.
- *Turf Contact Protection:* All wooden props must be protected with a heavy-duty sustainable plastic product (PVC, Melamine, etc.) where said prop comes in contact with the field surface. Steel props with smooth edges are acceptable without additional protection.
- *Secondary Containment for Sandbags:* Props must not leave holes in the Performance Field surface. Sand bags must be in a secondary container (bucket, double bagged, etc.) that will prevent sand from leaking.

=== Rule 8.07: Equipment Wheel and Turf Protection Standards
- *Pneumatic-Like Tires:* All instruments and equipment wheeled into the stadium from the entrance gate forward must have pneumatic-like tires that support the weight without damaging turf.

=== Rule 8.08: Prop Staging Height Restrictions
- *12-Foot Rigid Height Limit:* Staging built and/or used by bands at CBA sanctioned events shall be limited to a maximum total height of twelve (12) feet.

=== Rule 8.09: Prop Assembly, Timing, and USAFA Falcon Stadium Clearance
- *Falcon Stadium 9'6" Tunnel Rule:* Any prop being used at Falcon Stadium must not exceed 9 ft 6 in. to clear the tunnel entrance. Assembled sideline screens (4 ft height) clear this restriction with over 5 feet of safety margin.

=== Rule 9.07: Parent Field Access & Wristband Limits
- *25 Field Pass Wristbands:* Access to the field is restricted to Directors/Staff with CBA passes and parents assisting with props/front ensemble with designated Field Pass wristbands (strictly limited to 25 per band).

#pagebreak()

== 1.7 Post-Use Teardown, Staging & Trailer Packout Protocol

1. *Continuous Egress & Uphill Transit:* Student pairs jog screens through the exit gate directly to the common outside staging area. Props cannot stop or reload in the exit chute.
2. *"Two-Shot" Competitions (Prelims & Finals Inter-Show Staging):* Between shows, screens remain staged in the trailer lot. If high wind gusts threaten, pull the snap clips (*I*) and collapse the rear frames flat (under 2.0 in. thick) to eliminate wind sail area while keeping screens ready for rapid re-erection.
3. *Final Teardown De-Ballasting:* Remove sandbags at the truck/trailer only. Stack bags low over truck axles on rubber floor mats.
4. *Collapsing Triangular Frame Flat:* Unclip both 3D-printed hinged arm clips (*I*) from Lower Inner Rail 3 and swing the rear triangular support frame upward and flat inside the perimeter framing.
5. *Loading Stages & Truck Packout:* Collapsed screens may be transported stacked flat on mobile staging platforms or stacked vertically against the interior sidewalls of equipment trucks/trailers. As shown in the figure below, nested flat screens are stacked vertically against the interior truck sidewall, secured with heavy-duty cargo ratchet straps wrapped around wall rub rails / E-track, and ballasted along the bottom runner with sandbags to prevent shifting during transit.

#v(6pt)
#align(center)[
  #figure(
    image("assets/approved/duck_blind_transport_packout.jpg", width: 70%),
    caption: [Equipment truck packout configuration: nested flat screens secured vertically against truck sidewall with cargo ratchet strap and ballast sandbags lining base.]
  )
]

#pagebreak()

// =========================================================================
// APPENDIX B: CONSTRUCTION & FABRICATION MANUAL (PAGE B-1 COVER)
// =========================================================================

#set page(header: none)
#appendix-id.update("B")
#appendix-title.update("APPENDIX B | CONSTRUCTION MANUAL")
#counter(page).update(1)

#appendix-cover(
  kicker: "APPENDIX B",
  title: "Construction & Fabrication Manual",
  subtitle: "Conduit cutting, 3D printing, 4-stage frame assembly, vinyl wrapping, and semicircular wind relief flaps",
  body-text: [
    This appendix contains the complete bill of materials, workshop safety standards, 7-stick conduit cutting schedule, 4-stage frame assembly, vinyl tensioning and snap clamping, quality checklist, and component index.
  ],
  audience: [Band prop construction leads, parent build volunteers, and fabrication teams],
  contents: [Shop safety; full BOM; 3D-printed parts; 7-stick conduit cut schedule; cost breakdown; 4-stage frame assembly; vinyl mounting; wind relief flap cutting; inspection checklist; indexed purchasing sources],
  print-label: [All pages labeled B-],
  revision: [Release v0 (unreleased) | Development build D34 | September 2026],
  separation-note: [When separated from the master document, keep this cover as the first page of Appendix B.]
)

#pagebreak()

// =========================================================================
// APPENDIX B: CONTENT PAGES (B-2 THROUGH B-15)
// =========================================================================
#set page(header: make-header("APPENDIX B | CONSTRUCTION MANUAL"))

= Appendix B: Construction & Fabrication Manual

== 2.1 Safety, Work Area & Shop Protocol

- *Eye and Ear Protection:* Wear ANSI Z87.1 approved safety glasses during all cutting, deburring, and drilling operations. Use hearing protection when operating abrasive cutoff saws or reciprocating saws.
- *Cut Conduit Edges:* Freshly cut EMT conduit edges are razor-sharp. Every tube end *must* be thoroughly deburred inside and outside using a reaming tool, half-round file, or dedicated rotary deburring tool before handling or assembly.
- *Clean Staging Surface:* Vinyl installation and banner wrapping *must* be performed over clean moving blankets laid on a flat floor. Never allow scrim vinyl to contact shop grit, gravel, or metal shavings.
- *Fastener Safety:* Self-drilling screws (*J*) generate sharp metal shavings when penetrating EMT walls. Clear shavings immediately from work surfaces and moving blankets to prevent puncture damage to printed vinyl faces.

== 2.2 Materials & Component Inventory (BOM)

A single sideline screen requires the following mechanical hardware, commercial clamp brackets, and custom 3D-printed fittings:

#table(
  columns: (0.5fr, 0.5fr, 1.6fr, 1.8fr, 1.6fr),
  align: (center + horizon, center + horizon, left + horizon, left + horizon, left + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 4pt, y: 2.8pt),
  [*ID*], [*Qty*], [*Component Description*], [*Specification / Material*], [*Source / Part Reference*],
  [*A*], [4], [Long main-frame rails], [92.5 in. length, 3/4-in. EMT conduit], [Home Depot (SKU 0550110000)],
  [*B*], [2], [Main-frame end rails], [44.5 in. length, 3/4-in. EMT conduit], [Home Depot (SKU 0550110000)],
  [*C*], [1], [Rear cross rail], [86.5 in. length, 3/4-in. EMT conduit], [Home Depot (SKU 0550110000)],
  [*D*], [2], [Rear-frame arms], [37.0 in. length, 3/4-in. EMT conduit], [Home Depot (SKU 0550110000)],
  [*E*], [2], [Bottom support arms], [27.5 in. length, 3/4-in. EMT conduit], [Home Depot (SKU 0550110000)],
  [*F*], [6], [3-way corner brackets], [3/4-in. EMT clamp bracket], [Amazon (B0D5BBKCKG)],
  [*G*], [8], [T-brackets], [3/4-in. EMT clamp bracket (4 fixed, 4 hinge pivots)], [Amazon (B0CKQW11SJ)],
  [*H*], [6], [Corner plugs], [3D printed, black ASA], [`Corner Plug.FCStd` / STEP],
  [*I*], [2], [Hinged arm clips], [3D printed, black ASA], [`Hinged Arm Clip.FCStd` / STEP],
  [*J*], [36], [Self-drilling screws], [#8 x 1/2-in. hex washer flange head], [Home Depot (Teks 21308)],
  [*--*], [1], [Custom banner], [13 oz scrim vinyl, 48 in. × 96 in. nominal graphic], [Custom print (flush cut)],
  [*--*], [1 roll], [Double-sided tape], [1-in. heavy-duty mounting tape (16x 4-in. strips)], [Amazon (B07BBL4JXJ)],
  [*--*], [16], [Greenhouse snap clamps], [1-in. pipe clamp clips (fits 0.922 in. OD EMT + vinyl)], [Amazon (B0BJJYKZ5L)],
  [*--*], [1 pc], [Field Prop Circle Cutter], [PCHSMB Circle Cutter arm w/ #11 blade (R = 4.0 in.)], [Index [18] / 3D Print],
)

#pagebreak()

// PAGE B-3: FULL-PAGE COMPONENT INVENTORY FIGURE
#align(center)[
  #figure(
    image("assets/figures/fig1_component_inventory.png", width: 96%),
    caption: [Component inventory for one complete sideline screen frame.]
  )
]

#pagebreak()

// PAGE B-4: TOOLS, 3D PRINTING & CUTTING SCHEDULE
== 2.3 Tools, Equipment & 3D-Printed Jigs

#v(-2pt)
#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    - Abrasive cutoff saw or tubing cutter
    - Deburring reamer or half-round file
    - Impact driver with 5/16" magnetic hex bit
    - Cordless drill with 1/8" HSS drill bit
    - PCHSMB Field Prop Circle Cutter (Index [18])
  ],
  [
    - 25-ft tape measure & framing square
    - Soft marking pencil or silver Sharpie
    - 3/8-in. (10 mm) rotary leather punch & mallet
    - Dense end-grain hardwood backing block
    - Moving blankets for clean floor staging
  ]
)

== 2.4 3D-Printed Parts Specifications

Three critical components are custom-manufactured using fused deposition modeling (FDM):

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 7pt,
  rect(
    width: 100%,
    fill: rgb("#f7fafc"),
    stroke: 0.8pt + rgb("#cbd5e0"),
    radius: 3pt,
    inset: (x: 6pt, y: 5pt),
  )[
    *Corner Plugs (Part H)* \
    - *Quantity:* 6 pcs per screen (96 pcs fleet).
    - *Material:* Black ASA (UV/weather-proof).
    - *Function:* Press-fits into open unused third sockets of brackets *F* to seal tubes from moisture, wasp nesting, and sharp burr exposure.
    - *Print Settings:* 4 perimeters, 25% gyroid infill, 0.20 mm layer height.
  ],
  rect(
    width: 100%,
    fill: rgb("#f7fafc"),
    stroke: 0.8pt + rgb("#cbd5e0"),
    radius: 3pt,
    inset: (x: 6pt, y: 5pt),
  )[
    *Hinged Arm Clips (Part I)* \
    - *Quantity:* 2 pcs per screen (32 pcs fleet).
    - *Material:* Black ASA (elastic snap retention).
    - *Function:* Fastened to bottom arms *E*; snaps firmly onto lower inner rail *A* (Rail 3) to lock triangular frame rigid on turf.
    - *Print Settings:* 6 perimeters, 40% infill, oriented on flat face for maximum hoop strength.
  ],
  rect(
    width: 100%,
    fill: rgb("#f7fafc"),
    stroke: 0.8pt + rgb("#cbd5e0"),
    radius: 3pt,
    inset: (x: 6pt, y: 5pt),
  )[
    *Weight Clips (Optional)* \
    - *Quantity:* 2–4 pcs per screen.
    - *Material:* Black ASA.
    - *Function:* Snaps over upper inner rail *A* (Rail 2) to suspend secondary ballast sandbags during Tier 2/3 wind conditions.
    - *Print Settings:* 6 perimeters, 50% infill, high-tensile hook geometry.
  ],
)

#v(6pt)

== 2.5 Raw Material Cutting Schedules

Fabricating one complete screen requires exactly *seven 10-ft sticks of 3/4-in. EMT conduit* (112 sticks for the complete 16-screen fleet). Follow this cut plan to minimize scrap:

#table(
  columns: (0.7fr, 1.6fr, 1.9fr, 1.2fr),
  align: (center + horizon, left + horizon, left + horizon, center + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 5pt, y: 3pt),
  [*Stick \#*], [*Cut Elements (Quantity × Length)*], [*Functions & Part IDs*], [*Remainder / Scrap*],
  [Stick 1], [1 × 92.5 in.], [Rail A (Top Outer Rail 1)], [27.5 in. spare],
  [Stick 2], [1 × 92.5 in.], [Rail A (Upper Inner Rail 2)], [27.5 in. spare],
  [Stick 3], [1 × 92.5 in.], [Rail A (Lower Inner Rail 3)], [27.5 in. spare],
  [Stick 4], [1 × 92.5 in.], [Rail A (Bottom Ground Rail 4)], [27.5 in. spare],
  [Stick 5], [1 × 86.5 in. + 1 × 27.5 in.], [Rail C (Rear Cross) + Arm E (Support)], [6.0 in. scrap],
  [Stick 6], [2 × 44.5 in. + 1 × 27.5 in.], [Rails B (Outer Ends) + Arm E (Support)], [3.5 in. scrap],
  [Stick 7], [2 × 37.0 in.], [Arms D (Rear Frame Diagonals)], [46.0 in. spare],
)

#pagebreak()

// PAGE B-5: CONDUIT CUT DIAGRAM & COST BREAKDOWN
#align(center)[
  #figure(
    image("assets/figures/fig2_conduit_cut_diagram.png", width: 95%),
    caption: [Proportional seven-stick conduit cut diagram.]
  )
]

#v(6pt)

== 2.6 Estimated Fabrication Cost Breakdown

Eliminating the transport carts saves *\$440.00* across the program. Fleet construction costs are summarized below:

#grid(
  columns: (1fr, 1.15fr),
  gutter: 12pt,
  [
    #text(weight: "bold", size: 8.5pt, fill: rgb("#1a365d"))[Per Sideline Screen / Duck Blind (Excl. Vinyl):] \
    #table(
      columns: (1.8fr, 1fr),
      align: (left + horizon, right + horizon),
      stroke: 0.4pt + rgb("#cbd5e0"),
      fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 6 { rgb("#e6fffa") } else { none },
      inset: (x: 4pt, y: 2.5pt),
      [*Material / Item*], [*Unit Cost*],
      [7x 10-ft 3/4-in. EMT Conduit], [\$40.50],
      [6x 3-Way Corner Brackets (F)], [\$27.00],
      [8x 3/4-in. T-Brackets (G)], [\$23.00],
      [36x Self-Drilling Screws (J)], [\$4.00],
      [3D ASA Hardware (6H, 2I)], [\$10.00],
      [*TOTAL PER SCREEN*], [*~\$105.00*],
    )
  ],
  [
    #text(weight: "bold", size: 8.5pt, fill: rgb("#1a365d"))[16-Screen Fleet Production Total:] \
    #table(
      columns: (1.8fr, 1.2fr),
      align: (left + horizon, right + horizon),
      stroke: 0.4pt + rgb("#cbd5e0"),
      fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 3 { rgb("#ebf8ff") } else { none },
      inset: (x: 4pt, y: 2.5pt),
      [*Fleet Item*], [*Total Cost*],
      [16x Sideline Screen Frames], [~\$1,680.00],
      [Transport Carts (0 built)], [\$0.00 (Saved \$440)],
      [*TOTAL FLEET HARDWARE*], [*~\$1,680.00*],
    )
    #v(2pt)
    #text(size: 7.5pt, style: "italic", fill: rgb("#718096"))[
      Packs: Double-bagged sandbags + hardware: +\$18/screen. Vinyl mounting pack (tape + 16 snap clamps): +\$20/screen.
    ]
  ]
)

#pagebreak()

// PAGE B-6: FOLDED STATE MAP & FASTENING RULES
== 2.7 Step-by-Step Frame Assembly

#align(center)[
  #figure(
    image("assets/figures/fig3_folded_state_map.png", width: 92%),
    caption: [Folded-state component and connector-fastening map for the finished frame.]
  )
]

#v(4pt)

=== Fastening Rules & Screw Distribution
Exactly *36 self-drilling screws (J)* are driven per completed screen. #alert[STRICT ASSEMBLY RULE: NEVER DRIVE SCREWS INTO PIVOTING HINGE SLEEVES.]
- *Fixed Joints:* Screws penetrate brackets and conduit to lock geometry rigid.
- *Pivoting Joints (Zero Screws):* The four upper *G* T-brackets rotate freely around the upper inner *A* rail (Rail 2). The two rear *G* T-brackets rotate freely around rear rail *C*. Driving a screw into these sleeves prevents the frame from folding!

#table(
  columns: (1.5fr, 0.9fr, 2fr, 1.8fr),
  align: (left + horizon, center + horizon, left + horizon, left + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 4pt, y: 2.5pt),
  [*Assembly Stage*], [*Screw Count*], [*Target Fastener Locations*], [*Pivoting Interfaces (NO SCREWS)*],
  [Stage 1: Main Outer Frame], [8 screws], [2 screws per corner bracket *F* into *A* & *B*], [None],
  [Stage 2: Inner Cross Rails], [8 screws], [1 screw per *G* bracket sleeve into *A* from rear], [None],
  [Stage 3: Rear Support Frame], [8 screws], [4 in corner *F* brackets; 4 joining *D* into *G*], [4 upper *G* sleeves around Rail 2],
  [Stage 4: Bottom Support Arms], [12 screws], [4 joining *E* into *G*; 8 securing *I* clips to *E*], [2 rear *G* sleeves around Rail C],
  [*TOTAL FASTENERS*], [*36 screws*], [*All 36 fasteners fully accounted for*], [*Zero screws in 6 hinge sleeves*],
)

#pagebreak()

// PAGE B-7: FULL-PAGE EXPLODED FOLDED MAP
#align(center)[
  #figure(
    image("assets/figures/fig3a_exploded_folded_map.png", width: 94%),
    caption: [Exploded folded-state component and connector-fastening map.]
  )
]

#pagebreak()

// PAGE B-8: STAGE 1
=== Stage 1: Assemble the Main Outer Rectangle
1. Lay out two 92.5-in. *A* rails (Top Rail 1 and Bottom Rail 4) and two 44.5-in. *B* end rails on a flat floor.
2. Join corners using four 3-way corner brackets (*F*). Seat tube ends fully against interior bracket stops.
3. Insert four 3D-printed corner plugs (*H*) into the open, unused perpendicular sockets of brackets *F*.
4. Square the frame by measuring diagonal corner-to-corner distances (must match within 1/16 in.).
5. Drive eight *J* screws (one per tube-bracket interface) through bracket pilot holes into conduit walls.

#v(6pt)
#align(center)[
  #figure(
    image("assets/figures/fig4_stage1_main_frame.png", width: 88%),
    caption: [Stage 1 main-frame assembly and corner bracket detail.]
  )
]

#pagebreak()

// PAGE B-9: STAGE 2
=== Stage 2: Install Inner Cross Rails
1. Mark the vertical *B* end rails for the two inner *A* rails:
  - *Upper Inner Rail 2 (Ballast Hanger Rail):* Centerline exactly *2.5 in. below top outer rail A* ($Y = 42.0$ in.).
  - *Lower Inner Rail 3 (Clip Latch Rail):* Centerline exactly *10.0 in. above bottom outer rail A* ($Y = 10.0$ in.).
2. Slide four T-brackets (*G*) onto the *B* end rails (two per side) aligned with your marks.
3. Seat the two remaining 92.5-in. *A* rails into the T-bracket sockets.
4. Verify parallel spacing across the 92.5-in. span, then drive eight *J* screws from the rear face through the *G* bracket sleeves into the *A* rails (locking them rigid).

#v(6pt)
#align(center)[
  #figure(
    image("assets/figures/fig5_stage2_inner_rails.png", width: 88%),
    caption: [Stage 2 inner-rail placement and T-bracket fastening.]
  )
]

#pagebreak()

// PAGE B-10: STAGE 3
=== Stage 3: Assemble and Attach Rear Support Frame
1. Slide four T-brackets (*G*) onto Upper Inner Rail 2 before tightening (two on Left, two on Right). *These brackets act as the upper folding hinges and must rotate freely around Rail 2 with ZERO screws.*
2. Assemble the rear frame: join two 37.0-in. *D* arms to the 86.5-in. *C* rear cross rail using two 3-way corner brackets (*F*). Insert two 3D corner plugs (*H*) into open bracket sockets.
3. Drive four *J* screws into brackets *F* to secure *D* and *C* rigid.
4. Insert the top ends of *D* arms into the hanging sleeves of the four upper *G* brackets. Drive four *J* screws through *G* sleeves into *D* arms. #alert[Do not screw into Rail 2!]

#v(6pt)
#align(center)[
  #figure(
    image("assets/figures/fig6_stage3_rear_support.png", width: 88%),
    caption: [Stage 3 rear-support-frame assembly and hinge fastening.]
  )
]

#pagebreak()

// PAGE B-11: STAGE 4
=== Stage 4: Install Bottom Support Arms & Snap Clips
1. Slide two T-brackets (*G*) onto rear rail *C*. *These brackets act as bottom folding hinges and must rotate freely around Rail C with ZERO screws.*
2. Insert two 27.5-in. *E* bottom support arms into the sleeves of these *G* brackets. Secure *E* to *G* with four *J* screws.
3. Slide 3D-printed hinged arm clips (*I*) onto the free forward ends of arms *E*. Fasten each clip with four *J* screws (eight screws total).
4. Swing the completed rear frame down and forward: snap clips (*I*) must snap firmly over Lower Inner Rail 3 with an audible click, locking the triangular frame into rigid field position.

#v(4pt)
#grid(
  columns: (1.1fr, 0.9fr),
  gutter: 10pt,
  figure(
    image("assets/figures/fig7_stage4_bottom_support.png", width: 100%),
    caption: [Stage 4 bottom support arm and clip installation.]
  ),
  figure(
    image("assets/figures/fig8_deployed_cutaway_elevation.png", width: 100%),
    caption: [Deployed cutaway side elevation.]
  )
)

#pagebreak()

// PAGE B-12: QC INSPECTION PROTOCOL
== 2.8 Mechanical Inspection & Quality Assurance Protocol

Before approving a completed frame for vinyl wrapping, verify the following:

#v(2pt)
#table(
  columns: (0.4fr, 1.8fr, 3.2fr, 1.2fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 4pt, y: 3.5pt),
  [*#chk*], [*Subsystem / Item*], [*Acceptance Criteria & Standard*], [*QC Status*],
  [#chk], [Frame Squareness], [Diagonal measurements across outer rectangle match within 1/16 in.], [[ ] Pass  [ ] Rework],
  [#chk], [Fastener Count], [Exactly 36 J screws installed; no loose, stripped, or protruding heads.], [[ ] Pass  [ ] Rework],
  [#chk], [Hinge Free-Rotation], [4 upper hinges on Rail 2 and 2 lower hinges on Rail C rotate smoothly.], [[ ] Pass  [ ] Rework],
  [#chk], [Clip Lockup], [Both 3D clips (I) snap securely over Rail 3 and release cleanly.], [[ ] Pass  [ ] Rework],
  [#chk], [Coplanar Folding], [Rear frame collapses completely flat inside perimeter frame (#sym.lt.eq 2.0 in.).], [[ ] Pass  [ ] Rework],
)

#v(6pt)
#rect(width: 100%, fill: rgb("#f7fafc"), stroke: 1pt + rgb("#cbd5e0"), radius: 4pt, inset: 10pt)[
  #text(weight: "bold", size: 9pt, fill: rgb("#1a365d"))[MECHANICAL FRAME QUALITY ASSURANCE SIGN-OFF]
  #v(4pt)
  #grid(
    columns: (1fr, 1fr),
    row-gutter: 8pt,
    column-gutter: 14pt,
    [Screen Unit ID / Number: #blank(120pt)],
    [Inspection Date: #blank(120pt)],
    [Lead Fabricator (Print): #blank(120pt)],
    [Inspector Signature: #blank(120pt)],
  )
  #v(4pt)
  #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
  #v(4pt)
  #grid(
    columns: (auto, 1fr),
    column-gutter: 10pt,
    [*Final Disposition:*],
    [[ ] APPROVED FOR VINYL MOUNTING       [ ] REWORK REQUIRED (HOLD)],
  )
  #v(3pt)
  Remediation Notes: #blank(350pt)
]

#pagebreak()

// PAGE B-13: VINYL BANNER MOUNTING PROTOCOL
== 2.9 Vinyl Banner Installation & Frame Mounting Protocol

=== 2.9.1 Banner Ordering, Bleed & Material Specifications
- *Face Display Area:* 48.0 in. H × 96.0 in. W nominal ($30.5" sq ft"$ actual display face).
- *Cut Banner Dimensions:* 52.0 in. H × 100.0 in. W (provides a 2.0-in. perimeter wrap bleed on all four sides).
- *Material Specification:* 13 oz heavy-duty matte scrim vinyl (outdoor UV-cured inks, flush cut edges, no grommets, no sewn hems).

#v(4pt)

=== 2.9.2 Step-by-Step Vinyl Tensioning, Wrapping & Clamping Procedure

#callout(
  title: "Shop Clamping & Wrapping Standard",
  [
    Always execute banner wrapping over clean moving blankets laid on a swept shop floor. Never allow scrim vinyl or printed graphics to contact concrete grit, swarf, or metal filings.
  ]
)

1. *Clean Floor Staging:* Lay moving blankets on floor. Place printed banner face down with the assembled frame centered directly over the 2.0-in. perimeter bleed allowance.
2. *Double-Sided Tape Application:* Cut sixteen (16) 4-in. strips of 1-in. heavy-duty double-sided mounting tape. Apply to the rear-facing surface of outer rails *A* and *B*:
  - *Long Rails A (Top and Bottom):* Apply 5 strips evenly spaced along top rail; 5 strips along bottom ground rail (10 total).
  - *Short End Rails B (Left and Right):* Apply 3 strips evenly spaced along each end rail (6 total).
  - Burnish tape strips firmly to steel conduit, then peel and discard release backing liners.
3. *Long-Side Tensioning & Initial Wrap:* Start along top rail *A*. Fold vinyl bleed margin tightly around conduit and press firmly into the 5 tape strips. Station operators at opposing bottom rail *A*: pull vinyl firmly across frame face to eliminate all slack and wave patterns, wrap bleed over conduit, and press into opposing tape strips. Verify longitudinal face is drum-tight.
4. *Short-Side Dual-Operator Tensioning:* Station operators at opposite short ends (*B* rails). Pull outward simultaneously in opposing directions to establish balanced transverse tension without racking frame out of square. Wrap ends around *B* conduit and press into tape. Neatly fold corner bleed tabs flat over 3-way corner brackets (*F*).
5. *Greenhouse Snap Clamp Installation:* Snap sixteen (16) 1-in. greenhouse pipe snap clamps directly over wrapped vinyl, aligning each clamp precisely over a tape strip:
  - 5 clamps across top outer rail *A*; 5 clamps across bottom ground rail *A*.
  - 3 clamps across left end rail *B*; 3 clamps across right end rail *B*.
  - Confirm clamps are fully seated. Ensure zero mechanical interference with rear folding hinges (*G*) or 3D snap clips (*I*).
6. *Seasonal Removal (>80°F Rule):* #alert[Never attempt to peel vinyl in cold weather.] Cold adhesive becomes brittle, tearing vinyl scrim. Leave frames in direct summer sunlight (>80°F / 27°C) for 10 minutes prior to peeling; heated adhesive releases effortlessly from conduit without residue.

#pagebreak()

// PAGE B-14: DEDICATED SECTION 2.9.3 — WIND RELIEF FLAP CUTTING
=== 2.9.3 Cutting Engineered Semicircular Wind Relief Flaps

To prevent destructive vortex flutter, reduce peak dynamic overturning impulses during stadium wind gusts, and eliminate lateral sliding across crumb-rubber turf, cut *six (6) engineered semicircular wind relief flaps* into the custom vinyl banner:

#callout(
  title: "Aerodynamic & Mechanical Function of Semicircular Relief Flaps",
  [
    - *Steady-State Drag Reduction:* Drops drag coefficient from $C_d = 1.20 -> 1.02$ (15.0% reduction in lateral drag force and overturning moment).
    - *Turf Sliding Resistance:* Raises synthetic turf sliding threshold under Tier 1 ballast from 16.4 mph to *17.8 mph*.
    - *Vortex Flutter Suppression:* Destroys coherent Strouhal vortex shedding (~0.8–1.2 Hz), preventing negative billow suction (>3.0 psf) that pries greenhouse snap clamps off conduit.
    - *Tensile Clip Protection:* Reduces tensile pull on 3D-printed hinged arm clips (*I*) from 33.9 lbs to 28.8 lbs per clip at 20 mph.
  ]
)

==== Semicircular Geometry Standard ($R = 4.0$ in.)
Each flap is a true semicircle ($180^degree$ circular arc) measuring *8.0 in. horizontal top chord × 4.0 in. downward drop* (Radius $R = 4.0$ in.). Vent area is 25.13 sq in. per flap (1.05 sq ft total across 6 flaps, or 3.43% of display face). Semicircular geometry provides superior thermal beam stiffness over elongated ovals, preventing tip curling and sagging in $130^degree F+$ crumb-rubber heat while sharing 100% tooling commonality with the PCHSMB Backdrop fleet.

==== 6-Flap Fleet Standard Coordinate Schedule ($2 times 3$ Grid)
Venting is concentrated in the upper zone ($Y = 20.0$ to $34.0$ in.) where overturning moment leverage is greatest ($M = F times y$), while maintaining a 10-inch unvented opaque barrier ($Y <= 10.0$ in.) to conceal staged floor equipment:

#table(
  columns: (0.9fr, 1.2fr, 1fr, 1.1fr, 1.8fr, 1.2fr),
  align: (center + horizon, left + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 4pt, y: 2.2pt),
  [*Flap ID*], [*Grid Row*], [*Height (Y)*], [*Center (X)*], [*Punched Endpoints (X)*], [*Apex Clearance*],
  [Flap F-1], [Row 1 (Upper)], [34.0 in.], [24.0 in.], [20.0 in. and 28.0 in.], [30.0 in. to turf],
  [Flap F-2], [Row 1 (Upper)], [34.0 in.], [48.0 in.], [44.0 in. and 52.0 in.], [30.0 in. to turf],
  [Flap F-3], [Row 1 (Upper)], [34.0 in.], [72.0 in.], [68.0 in. and 76.0 in.], [30.0 in. to turf],
  [Flap F-4], [Row 2 (Lower)], [24.0 in.], [24.0 in.], [20.0 in. and 28.0 in.], [20.0 in. to turf],
  [Flap F-5], [Row 2 (Lower)], [24.0 in.], [48.0 in.], [44.0 in. and 52.0 in.], [20.0 in. to turf],
  [Flap F-6], [Row 2 (Lower)], [24.0 in.], [72.0 in.], [68.0 in. and 76.0 in.], [20.0 in. to turf],
)

#v(3pt)
#align(center)[
  #block(
    fill: rgb("#f7fafc"),
    stroke: 0.5pt + rgb("#cbd5e0"),
    inset: (x: 8pt, y: 6pt),
    radius: 4pt,
  )[
```text
<------------------------ 96.0" (8 ft) ------------------------->
0"            24.0"           48.0"           72.0"         96.0"
+---------------+---------------+---------------+---------------+ 48.0" (Top Rail)
|                                                               |
| [Top 14" Solid Vinyl Zone]                                    |
|                                                               |
|               X               X               X               | 34.0" (Row 1 / Upper)
|          (Flap F-1)      (Flap F-2)      (Flap F-3)           |
|                                                               |
|               X               X               X               | 24.0" (Row 2 / Lower)
|          (Flap F-4)      (Flap F-5)      (Flap F-6)           |
|                                                               |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - | 20.0" (Cut Apex)
|                                                               |
| [Equipment Concealment Zone — 100% Solid & Opaque Vinyl]      |
| (Conceals floor rifles, sabres, flags, and turf props)        |
|                                                               |
+===============================================================+  0.0" (Turf Level)
^               ^               ^               ^               ^
Left End    1/4 Width       Midpoint        3/4 Width       Right End
```
  ]
]

#pagebreak()

==== Artwork Protection & The "Floating Flap" Adjustment Rule
- *1-Arcminute Acuity Resolution:* Razor kerf (#sym.lt 0.01 in.) is 30x smaller than human eye resolution at 30 yards (0.31 in.). Flaps hang 100% flush by gravity and are completely invisible from spectator stands.
- *Floating Allowance:* Centerlines may float horizontally by $plus.minus 6$ to $12$ in. (and vertically by $plus.minus 2$ to $4$ in.) along their row to position flaps into solid backgrounds, dark textures, or negative space.
- *Mandatory NO-CUT Zones:* Never cut across visually important graphic details printed on the vinyl, such as performer faces, show title typography, movement titles, or school / sponsor logos. Flaps must maintain at least 6.0 in. of clearance from any faces depicted in the artwork.

==== Step-by-Step Punch-First Fabrication Procedure
1. *Tooling Checklist:* Obtain a 3/8-in. (10 mm) rotary leather punch, dense end-grain hardwood backing block, PCHSMB Field Prop Circle Cutter with fresh #11 hobby scalpel blade (Index [18]), and soft marking pencil.
2. *Marking & Graphic Inspection:* Measure and mark top horizontal chord centerlines and endpoint punch marks (8.0 in. apart). Verify compliance with Floating Flap artwork rules.
3. *MANDATORY PUNCH FIRST:* Slide hardwood block behind vinyl directly beneath punch mark. Align 3/8-in. rotary punch over mark and strike firmly with mallet. Repeat for opposing hole (8.0 in. apart). Clean circular holes eliminate stress risers ($K_t -> 1.0$). #alert[CRITICAL MANDATE: NEVER SLICE WITH RAZOR BEFORE PUNCHING HOLES.]
4. *Scribe & Slice Semicircular Arc:* Insert center pivot pin of PCHSMB Circle Cutter at midpoint between punched holes (or position R = 4.0 in. template). Perform a smooth, single-pass cut tangent to the bottom edge of both punched holes down through the 4.0-in. apex.
5. *LEAVE TOP CHORD UNCUT:* #alert[The top 8.0-in. horizontal chord between holes must remain uncut.] This uncut vinyl serves as the permanent gravity hinge.
6. *Flap Inspection:* Verify flap hangs 100% flush under gravity and swings open freely when pushed from behind.
7. *Backlight Pinprick Baffle (Optional):* In west-facing venues (low afternoon sun), apply a 1.5 in. × 1.5 in. square of black Gorilla tape behind each punch hole with a horizontal slit along lower edge to eliminate solar pinpricks.

#pagebreak()

// PAGE B-15: TEARDOWN & INDEX
=== 2.9.4 Seasonal Vinyl Removal & Teardown Protocol

#warning-box(title: "CRITICAL TEMPERATURE REQUIREMENT FOR VINYL REMOVAL")[
  Do not attempt removal of the vinyl or adhesive tape unless the ambient temperature is above 80°F (27°C). Attempting to peel the vinyl at lower temperatures will cause the material to tear and permanently damage the custom banner face.
]

- *Recommended Timing:* Defer vinyl peeling to summer band camp. Cold fall temperatures make adhesive brittle, increasing tear risk.
- *Solar Heating:* Staging frames in direct summer sunlight for 10 minutes softens adhesive for effortless residue-free release.
- *Clamp Removal:* Carefully unclip all sixteen (16) greenhouse snap clamps from perimeter conduit.
- *Peel at Shallow Angle:* Slowly peel vinyl back at a shallow angle. Warm adhesive releases cleanly from EMT conduit.

== 2.10 Appendix B Index & Purchasing References

=== Purchase Sources

#block[
  #set text(size: 8.2pt)
  #set par(leading: 0.52em)

  [1] *3/4-in. EMT Galvanized Steel Conduit (10-ft lengths)* — Home Depot (SKU 0550110000)   #link("https://www.homedepot.com/p/3-4-in-x-10-ft-Electric-Metallic-Tubing-EMT-Conduit-0550110000/100400409")

  [2] *3/4-in. EMT 3-Way Corner Elbow Brackets (6-Pack)* — Amazon (B0D5BBKCKG)   #link("https://www.amazon.com/dp/B0D5BBKCKG")

  [3] *3/4-in. EMT T-Brackets / Clamps (8-Pack)* — Amazon (B0CKQW11SJ)   #link("https://www.amazon.com/dp/B0CKQW11SJ")

  [4] *#8 x 1/2-in. Hex Washer Head Self-Drilling Screws (Teks 21308)* — Home Depot   #link("https://www.homedepot.com/p/Teks-8-x-1-2-in-Zinc-Plated-Steel-Hex-Washer-Head-Self-Drilling-Screws-100-Pack-21308/100145370")

  [5] *1-in. Greenhouse Snap Clamps for 3/4" EMT (16-Pack)* — Amazon (B0BJJYKZ5L)   #link("https://www.amazon.com/dp/B0BJJYKZ5L")

  [6] *1-in. Heavy-Duty Double-Sided Mounting Tape* — Amazon (B07BBL4JXJ)   #link("https://www.amazon.com/dp/B07BBL4JXJ")

  [7] *Abccanopy 15-lb Heavy-Duty Sandbags with Handle (4-Pack)* — Amazon   #link("https://www.amazon.com/dp/B0DFVVZDVK")

  [8] *Heavy-Duty Plastic Sandbag Liner Bags (Double-Bag Compliance)* — Amazon   #link("https://www.amazon.com/dp/B0BG3F5XVS")

  [9] *PCHSMB Field Prop Circle Cutter (3D Printed Tooling)* — Custom ASA print with #11 blade   #link("https://github.com/ericrowe/music/tree/main/PCHSMB/Circle%20Cutter")
]

=== Digital Part Files & Governing Rules

#block[
  #set text(size: 8.2pt)
  #set par(leading: 0.52em)

  [10] *3D Printed Corner Plug (Part H) — FreeCAD Model*   #link("https://github.com/ericrowe/music/blob/main/PCHSMB/_Sideline%20Screen/Hardware/Corner%20Plug.FCStd")

  [11] *3D Printed Hinged Arm Clip (Part I) — FreeCAD Model*   #link("https://github.com/ericrowe/music/blob/main/PCHSMB/_Sideline%20Screen/Hardware/Hinged%20Arm%20Clip.FCStd")

  [12] *3D Printed Weight Clip (Optional Ballast Hanger) — FreeCAD Model*   #link("https://github.com/ericrowe/music/tree/main/PCHSMB/_Sideline%20Screen/Hardware")

  [17] *2026 Colorado Bandmasters Association (CBA) Marching Band Rulebook (PDF)*   #link("https://ebf5c7e8-3869-4325-bd98-ce10f57d7545.filesusr.com/ugd/83f67e_cb5fe6efdbdb4ce98f619580f694bc94.pdf")

  [18] *PCHSMB Field Prop Circle Cutter Generator & CAD Models*   #link("https://github.com/ericrowe/music/blob/main/PCHSMB/Circle%20Cutter/generate_circle_cutter.py")
]

#pagebreak()

// =========================================================================
// APPENDIX C: FIELD OPERATIONS PLACARD (EXACT ONE-PAGE BUDGET)
// =========================================================================

#set page(header: none)
#appendix-id.update("C")
#appendix-title.update("APPENDIX C | FIELD OPERATIONS PLACARD")
#counter(page).update(1)

#align(center)[
  #rect(fill: rgb("#1a365d"), radius: 3pt, inset: (x: 10pt, y: 4pt))[
    #text(size: 10.5pt, weight: "bold", fill: white, tracking: 1.5pt)[APPENDIX C: FIELD OPERATIONS PLACARD]
  ]
  #v(-3pt)
  #text(size: 7.8pt, style: "italic", fill: rgb("#4a5568"))[
    One-Page Laminated Field Reference for Trained Student Handlers & Parent Pit Crew — Mount on Prop Frame
  ]
]

#v(1pt)

#rect(
  width: 100%,
  stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt, dash: "dashed"),
  fill: rgb("#f7fafc"),
  radius: 4pt,
  inset: (x: 8pt, y: 5pt)
)[
  #text(size: 8pt, weight: "bold", fill: rgb("#1a365d"))[
    ATTACH 4" × 6" FIELD PLACEMENT / DRILL CARD HERE (From Appendix C.1)
  ]
  #v(2pt)
  #text(size: 7.5pt, fill: rgb("#2d3748"))[
    #grid(
      columns: (1fr, 1.2fr, 1fr),
      [Screen \#: #blank(45pt)],
      [Show Segment: #blank(65pt)],
      [Side: [ ] Side 1   [ ] Side 2],
    )
    #v(2pt)
    Front Sideline Mark: #blank(120pt)     Yard Line: #blank(80pt)     Facing: #blank(60pt) \
    Assigned Handlers: 1) #blank(80pt)  2) #blank(80pt)  Ballast: #blank(60pt)
  ]
]

#v(2pt)
#text(size: 8.5pt, weight: "bold", fill: rgb("#1a365d"))[1. Rapid Two-Student Deployment & Egress Checklist]
#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  [
    #text(weight: "bold", size: 8pt, fill: rgb("#2b6cb0"))[RAPID DEPLOYMENT (Expected: 55.7s):] \
    #text(size: 7.5pt)[
      1. *Queue:* 16 pairs queue along back sideline with screens.
      2. *Walk-Across ($T = "0:00"$):* Walk straight across field (~55 yds).
      3. *Placement:* Deposit on front yard mark; align into unbroken wall.
      4. *Ballast:* Place sandbags over rear rail *C*. Set drill by *T+0:55*.
    ]
  ],
  [
    #text(weight: "bold", size: 8pt, fill: rgb("#2b6cb0"))[RAPID EGRESS (Expected: 55.0s):] \
    #text(size: 7.5pt)[
      1. *Final Chord ($T = "0:00"$):* Lift bags gently to turf.
      2. *Sprint ($T = "0:05 to 0:55"$):* Grasp uprights; jog down sideline into exit chute.
      3. *Wagon Sweep:* Adult wagon teams retrieve resting sandbags.
      4. *Trailer Transit:* 4 collapsed screens per stage back to truck.
    ]
  ]
)

#v(2pt)
#text(size: 8.5pt, weight: "bold", fill: rgb("#1a365d"))[2. Wind Ballast Schedule (Colorado Springs 6,500 ft ASL)]
#table(
  columns: (1.1fr, 1.2fr, 1.6fr, 1.1fr, 1.6fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if y == 5 { rgb("#fff5f5") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 4pt, y: 2.2pt),
  [*Tier / State*], [*Wind Velocity*], [*Ballast (15-lb Bags)*], [*Total Wt*], [*Status & Safe Gust Limit*],
  [Tier 0: Calm], [0–8 mph], [0 bags (unballasted)], [26 lbs], [Safe to 12.1 mph slide / 8.8 tip],
  [Tier 1: Normal], [8–12 mph], [2 bags on rear rail C], [56 lbs], [17.8 mph safe slide / 25.5 tip],
  [Tier 2: Advisory], [12–18 mph], [3 bags (2 on C + 1 hung)], [71 lbs], [20.0 mph safe slide / 30.9 tip],
  [Tier 3: High-Wind], [18–22 mph], [4 bags (2 on C + 2 hung)], [86 lbs], [22.1 mph safe slide / 35.6 tip],
  [*Tier 4: ABORT*], [*>20 sust. / >25 gust*], [—], [—], [*STRICT NO-GO. Keep locked in trailer.*],
)

#v(2pt)
#text(size: 8.5pt, weight: "bold", fill: rgb("#1a365d"))[3. Critical Safety & CBA Rules Compliance]
#block[
  #set par(leading: 0.55em)
  #set text(size: 7.5pt)
  - *Adult Turf Penalty (Rule 4.03):* Adults *must stay off turf during performance* (0.2 penalty per occurrence). Adults clear turf before 2:45.
  - *Rear Gate Routing (Rule 5.02):* Props must enter strictly from back sideline or rear end zone gates. Never cross front boundary line.
  - *Double-Bagging Mandate (Rule 8.05):* All sandbags must have intact inner plastic liners. Zero sand allowed on athletic turf.
  - *Continuous Movement (Rule 8.05):* Continuous motion required off field until removed from stadium concourse.
]

#pagebreak()

// =========================================================================
// APPENDIX C.1: FIELD PLACEMENT CARD TEMPLATE (EXACT ONE-PAGE BUDGET)
// =========================================================================

#set page(header: none)
#appendix-id.update("C.1")
#appendix-title.update("APPENDIX C.1 | 4″ × 6″ FIELD PLACEMENT CARD TEMPLATE")
#counter(page).update(1)

#align(center)[
  #rect(fill: rgb("#1a365d"), radius: 3pt, inset: (x: 10pt, y: 4pt))[
    #text(size: 10.5pt, weight: "bold", fill: white, tracking: 1.5pt)[APPENDIX C.1: 4" × 6" FIELD PLACEMENT CARD TEMPLATE]
  ]
  #v(-3pt)
  #text(size: 7.8pt, style: "italic", fill: rgb("#4a5568"))[
    Printable & Fillable Coordinate Card for Appendix C On-Prop Placard (Cut along dashed line)
  ]
]

#v(3pt)

#align(center)[
  #rect(
    width: 88%,
    stroke: (paint: rgb("#2b6cb0"), thickness: 1.5pt, dash: "dashed"),
    radius: 4pt,
    fill: white,
    inset: (x: 8pt, y: 6pt)
  )[
    #text(size: 8pt, weight: "bold", fill: rgb("#1a365d"))[
      PCHS MARCHING BAND — SIDELINE SCREEN FIELD DRILL CARD
    ]
    #v(2pt)
    #table(
      columns: (1.2fr, 1.5fr, 1.3fr),
      stroke: 0.4pt + rgb("#cbd5e0"),
      fill: rgb("#f7fafc"),
      inset: (x: 4pt, y: 2.5pt),
      [Screen \#: #blank(40pt)],
      [Segment: #blank(55pt)],
      [Side: [ ] Side 1   [ ] Side 2],
    )
    #v(1pt)
    #text(size: 7.5pt)[
      *Front Sideline Mark:* #blank(120pt)     *Yard Line:* #blank(80pt)     *Facing:* #blank(60pt) \
      *Assigned Student Handlers:* 1) #blank(110pt)  2) #blank(110pt)
    ]
    #v(3pt)
    #image("assets/field_template.png", width: 72%)
    #v(2pt)
    #text(size: 7pt, style: "italic", fill: rgb("#718096"))[
      ✂ Cut along dashed blue border (exact 6.0" × 4.0" card). Mark prop routes with dry/wet-erase marker, laminate, and attach to placard.
    ]
  ]
]

#v(3pt)
#text(size: 9pt, weight: "bold", fill: rgb("#1a365d"))[Field Coordinator & Drill Writer Instructions]

#block[
  #set par(leading: 0.58em)
  #set text(size: 8.2pt)
  1. *Season Preparation & Card Fabrication:* Coordinate cards are prepared and printed ONCE PER SEASON with static information filled in. Cut out along the 6" × 4" dashed border, laminate, and affix into the Appendix C placard placeholder box using outdoor Velcro coins.
  2. *Competition Day Route Marking:* On competition day, draw the field entrance walk route, coordinate mark, and exit trajectory arrows directly onto the laminated card using a wet-erase marker.
  3. *CBA Field Routing Rules:* Follow all CBA boundary and timing regulations. Enter strictly from rear gates (Rule 5.02). Adults clear turf before 2:45. Maintain continuous egress uphill to staging area.
  4. *Two-Shot Staging Protocol:* During Prelims and Finals breaks, leave blinds staged in lot. If wind increases, unclip arms to collapse flat, eliminating sail area while maintaining readiness.
]

#pagebreak()

// =========================================================================
// APPENDIX D: PARENT VOLUNTEER COMPETITION DAY GUIDE (EXACT ONE-PAGE BUDGET)
// =========================================================================

#set page(header: none)
#appendix-id.update("D")
#appendix-title.update("APPENDIX D | VOLUNTEER COMPETITION DAY GUIDE")
#counter(page).update(1)

#align(center)[
  #rect(fill: rgb("#1a365d"), radius: 3pt, inset: (x: 10pt, y: 4pt))[
    #text(size: 10.5pt, weight: "bold", fill: white, tracking: 1.5pt)[APPENDIX D: PARENT VOLUNTEER COMPETITION DAY GUIDE & FIELD PROTOCOL]
  ]
  #v(-3pt)
  #text(size: 7.8pt, style: "italic", fill: rgb("#4a5568"))[
    One-Page Operational Guide & CBA Rules Compliance for Pit Crew & Prop Volunteers
  ]
]

#v(1pt)
#rect(width: 100%, fill: rgb("#f7fafc"), stroke: 0.5pt + rgb("#cbd5e0"), radius: 3pt, inset: (x: 6pt, y: 3pt))[
  #text(size: 7.8pt)[
    #grid(
      columns: (1.5fr, 1fr, 1.5fr),
      [Event: #blank(120pt)],
      [Date: #blank(60pt)],
      [Venue / Stadium: #blank(120pt)],
    )
  ]
]

#v(2pt)
#text(size: 8.5pt, weight: "bold", fill: rgb("#1a365d"))[1. Volunteer Schedule, Staging Milestones & Call Times]
#v(1pt)
#table(
  columns: (1.2fr, 1.8fr, 3fr),
  align: (center + horizon, left + horizon, left + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 5pt, y: 3pt),
  [*Time Interval*], [*Operational Milestone*], [*Action Items & Checkpoints*],
  [Call - 90 min], [Truck Arrival & Stage Transport], [Unload screens from truck onto 4 stages (4/stage) to transit to common outside staging area. Setup screens, test clips and wind flaps, and load ballast wagons.],
  [Call - 45 min], [Staging & Student Rendezvous], [Meet student carry pairs (16 pairs) and student ballast handlers (2) at outside staging. Confirm front yard marks. Students take over assembled screens and join wagons.],
  [Call - 15 min], [Gate Queue (Back Sideline)], [Students carry screens through rear gate to back sideline. Adult & student ballast handlers queue wagons at sideline. Don Rule 9.07 Field Pass wristbands.],
  [*T = "0:00"*], [*Permission to Enter*], [*Wagon teams deposit ballast along sideline corridor; students walk across (~55s) and place ballast on blinds. Adults clear turf by 2:45.*],
  [Show Run], [Performance Standby], [#alert[STAY OFF TURF.] Stand by outside front boundary in volunteer waiting area for entire performance (Rule 4.03).],
  [*Final Chord*], [*Egress & Ballast Sweep*], [Students leave bags on turf and sprint screens to outside staging (~55s). Wagon teams sweep resting sandbags into wagons.],
  [Post-Show], [Staging Hand-Off & Stage Reload], [Students hand blinds and wagons to managers at outside staging and depart together. Managers collapse screens flat, load 4 onto each stage, and return to trucks.],
)

#v(2pt)
#text(size: 8.5pt, weight: "bold", fill: rgb("#1a365d"))[2. 2026 CBA Marching Band Rules Governing Adult On-Field Behavior]
#block[
  #set par(leading: 0.52em)
  #set text(size: 7.2pt)
  - *Mandatory Field Pass Wristbands (Rule 9.07):* Access to the performance field for parents assisting with props is strictly restricted to designated Field Pass wristbands (max 25 per band). Wristbands permit access ONLY to the Performance Field.
  - *Field Clearance Before Performance (Rule 4.03 & Rule 5.06):* All adult volunteers assisting with props *must be completely clear* of the performance field before the introductory announcement ends. Any adult still on field incurs an immediate *0.2 point score penalty*.
  - *Re-Entry Prohibition During Performance (Rule 4.03):* Adults are strictly prohibited from entering or re-entering the performance field during the show (0.2 penalty per occurrence).
  - *Continuous Uphill Egress & Double-Bagging (Rule 8.05):* Continuous movement required off field until removed from stadium concourse. All sandbags must have intact plastic inner liners.
]
