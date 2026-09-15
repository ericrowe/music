#set document(
  title: "Pine Creek High School Marching Band — Rolling Backdrop System Manual",
  author: "PCHS Prop & Field Operations Crew",
  date: auto,
)

#let appendix-id = state("appendix-id", "")
#let appendix-title = state("appendix-title", "Rolling Backdrop System Manual")

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
  header: none, // Default suppressed on page 1 of preamble
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
        align(center)[*Release v0 (D5)* | September 2026],
        align(right)[*Page #pg-str*]
      )
    ]
  }
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 9.5pt,
  fill: rgb("#1a202c"),
)

#set par(justify: true, leading: 0.65em)
#show table.cell: set par(justify: false)
#set figure(numbering: none)

// Styled Heading Hierarchy
#show heading.where(level: 1): it => {
  v(10pt)
  text(fill: rgb("#1a365d"), weight: "bold", size: 13pt)[#it]
  v(3pt)
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
  v(3pt)
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
  v(3pt)
}

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

#let warning-box(title: "WARNING", body) = callout(
  title: [⚠️ #text(fill: rgb("#c53030"))[#title]],
  fill: rgb("#fff5f5"),
  stroke: rgb("#feb2b2"),
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
  revision: [Release v0 (unreleased) | Development build D5 | September 2026],
  separation-note: [When separated from the master document, keep this cover as the first page.]
) = [
  #align(center)[
    #text(size: 8.5pt, weight: "bold", fill: rgb("#718096"), tracking: 1.5pt)[
      PART OF THE ROLLING BACKDROP CONSTRUCTION AND FIELD OPERATIONS MANUAL
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

// -----------------------------------------------------------------------------
// MASTER DOCUMENT PREAMBLE (PAGE 1)
// -----------------------------------------------------------------------------

#align(center)[
  #rect(fill: rgb("#fff5f5"), stroke: 1pt + rgb("#feb2b2"), radius: 4pt, inset: (x: 12pt, y: 5pt))[
    #text(size: 9pt, weight: "bold", fill: rgb("#c53030"), tracking: 1.5pt)[WORKING DRAFT — NOT FOR USE]
  ]
  #v(6pt)
  #text(size: 20pt, weight: "bold", fill: rgb("#1a365d"))[Pine Creek High School Marching Band]
  #v(-4pt)
  #text(size: 14pt, weight: "bold", fill: rgb("#2b6cb0"))[Rolling Backdrop System]
  #v(-2pt)
  #text(size: 10pt, style: "italic", fill: rgb("#4a5568"))[
    Illustrated Construction and Field Operations Manual
  ]
]

#v(4pt)

#text(size: 9pt, weight: "bold", fill: rgb("#1a365d"))[Document Revision History]
#v(2pt)
#table(
  columns: (1.5fr, 0.9fr, 1.3fr, 2.5fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 5pt, y: 3.5pt),
  [*Version*], [*Date*], [*Status*], [*One-line description*],
  [Release v0 (unreleased) — Build D1], [2026-09-01], [WORKING DRAFT — NOT FOR USE], [Standardized master manual with 2026 CBA competition rules, 3/4" wing ballast posts, handle sandbag specifications, and instrument tote guidelines],
  [Release v0 (unreleased) — Build D2], [2026-09-10], [WORKING DRAFT — NOT FOR USE], [Add detailed vinyl installation procedure, specifications table, hardware relief slits, and snap clamp fastening],
  [Release v0 (unreleased) — Build D3], [2026-09-10], [WORKING DRAFT — NOT FOR USE], [Add engineered wind relief slit specifications, tiered 15-lb handle sandbag ballast schedule, rear-rail leverage optimization, and high-wind emergency protocol],
  [Release v0 (unreleased) — Build D4], [2026-09-13], [WORKING DRAFT — NOT FOR USE], [Update wind relief flap specification to true semicircular geometry (R = 4.0", 8" × 4"), 8-cut primary grid layout, 3/8" tear-arrest holes, and full Typst document conversion],
  [Release v0 (unreleased) — Build D5], [2026-09-15], [WORKING DRAFT — NOT FOR USE], [Harmonize document architecture, section numbering (1.1–1.7, 2.1–2.10), coordinate schedule tables, and PCHSMB Circle Cutter tooling with Sideline Screen manual],
)

= Intro / Overview

This master manual is organized as three independently printable appendices under one controlled revision history. The complete package contains the system overview, field operations procedures, 2026 competition rules compliance, construction instructions, and purchasing index for the Pine Creek High School Marching Band rolling backdrop prop.

#align(center)[
  #figure(
    image("assets/approved/figure_02_field_deployment.jpg", width: 62%),
    caption: [*Figure 2.* Backdrop units deployed in performance formation on athletic field.]
  )
]

#pagebreak()

// -----------------------------------------------------------------------------
// MASTER DOCUMENT PREAMBLE (PAGE 2)
// -----------------------------------------------------------------------------
#set page(header: make-header("Rolling Backdrop System Manual"))

== Appendix A: Operations Manual
Covers field transport, entrance and exit procedures, student and parent volunteer training drills, 3/4-inch wing ballast retention posts, double-bagged sandbag requirements, student instrument stowage, 2026 CBA competition prop rules, and post-use teardown/trailer storage. Intended for parent field crew, prop handlers, and student stage crew.

== Appendix B: Construction Manual
Covers workshop safety, materials, 2x4 rolling cart base fabrication, decking and 3/4-inch ballast post flange installation, 1-5/8 in. steel pipe upright frame assembly, diagonal support strut pre-drilling and mounting, vinyl banner installation with snap clamps, inspection checklist, and source lookup. Intended for fabrication volunteers and workshop build teams.

== Appendix C: Field Operations Placard
A dedicated one-page quick-reference sheet designed to be printed, laminated, and attached directly to each backdrop cart for instant field reference by trained student handlers and parent pit crew. Contains the tiered wind limits and ballast schedule, emergency abort rules, rapid assembly/teardown steps, and a dedicated 4" × 6" space for each prop's show drill coordinate diagram. (Supported by *Appendix C.1* 4" × 6" Field Placement Card Template and *Appendix D* Parent Volunteer Competition Day Guide).

== Printing and Separation Standard
Each appendix begins with an explicit cover page and uses independent page numbering (labeled A- for operations and B- for construction). When printing work packets for rehearsal or fabrication sessions, print the relevant appendix in its entirety, including its cover sheet.

== Acknowledgments and Design Credit
Special thanks and credit to the Plainfield North Bands for creating the original rolling cart design and foundational engineering concept. The Pine Creek High School Marching Band adapted and refined this design for our field operations, 3/4" vertical wing ballast retention posts, turf ballasting standards, and custom 3D-printed alignment fixtures.

#pagebreak()

// -----------------------------------------------------------------------------
// APPENDIX A: FIELD OPERATIONS MANUAL (PAGE A-1 COVER)
// -----------------------------------------------------------------------------

#set page(header: none)
#appendix-id.update("A")
#appendix-title.update("APPENDIX A | FIELD OPERATIONS MANUAL")
#counter(page).update(1)

#appendix-cover(
  kicker: "APPENDIX A",
  title: "Field Operations Manual",
  subtitle: "Field transport, entrance/exit, training, ballasting posts, instrument stowage, 2026 rules, and storage",
  body-text: [
    This appendix is designed as a complete, independently printable work packet which can be distributed separately to parent volunteers, student stage crew, and field handlers.
  ],
  audience: [Field operators, parent prop crew, and student handlers],
  contents: [Transport & field entrance; student/volunteer training; wing ballast posts; double-bagging rules; student instrument stowage; 2026 CBA rules; trailer storage],
  print-label: [All pages labeled A-],
  revision: [Release v0 (unreleased) | Development build D5 | September 2026],
  separation-note: [When separated from the master document, keep this cover as the first page of Appendix A.]
)

#pagebreak()

// -----------------------------------------------------------------------------
// APPENDIX A: CONTENT PAGES (A-2 THROUGH A-7)
// -----------------------------------------------------------------------------
#set page(header: make-header("APPENDIX A | FIELD OPERATIONS MANUAL"))

= Appendix A: Field Operations Manual

== 1.1 Roles & Division of Responsibilities

Field execution of the rolling backdrop props relies on a coordinated division of responsibility between parent volunteers and student performers:

=== A. Parent Pit & Logistics Crew:

*Trailer Unloading & Field Staging Protocol:* To fit inside equipment trailers, backdrops travel with the 10 ft × 8 ft steel frame detached from the cart base. Logistics crew execute field reassembly in the stadium tunnel or staging chute (Figure 3) as the exact reverse of trailer loading:

1. *Cart Base Offloading:* Release the heavy-duty E-track ratchet straps securing the cart bases against the front nose wall of the trailer. Carefully lower each cart base from its vertical short-end orientation onto all four swivel casters and roll it down the ramp to the level venue staging area.
2. *Vinyl Frame Retrieval & Protective Tennis Ball Removal:* With two operators lifting opposite sides, retrieve the 10 ft × 8 ft steel frames with attached vinyl banners from the trailer's interior cross support beams (Figure 5). Pull off the protective cut tennis balls from the exposed ends of the upper strut arms and stow the tennis balls in the cart's center HDX tough tote for post-show repacking.
3. *Rapid Frame-to-Cart Fastening (Power Driver Recommended):* Set the upright steel frame into the base mounting tension bands / clamp brackets along the front 2x4 rail of the cart base. Retrieve the mounting bolts from the tote. Using a cordless power drill/driver with an appropriate socket is strongly recommended to rapidly spin on and torque the hex nuts and lock washers, securing the upright frame to the cart in seconds.
4. *Two-Piece Strut Mating & Pinning:* Pivot the lower strut section up from the cart base (where it remained attached during transit), align it with the upper strut section attached to the frame upright, slide the sleeved two-piece joint together, and insert and lock the quick-release retaining pin through the aligned pin holes. Confirm both diagonal struts are rigid with zero slop.
5. *Pre-Show Staging & Ballasting:* Roll assembled backdrops to the field entrance gate in numerical show drill order. Load the required tiered sandbag ballast onto the wing posts (and rear rail if high wind), stage extra double-bagged 15-lb ground sandbag chocks for on-field use, verify 360° caster rotation, and prepare for gate ingress.

*Ballast Loading & Staging:* Assess stadium wind conditions and stage double-bagged 15-lb sandbags according to the quick-reference schedule below (see Section 1.5 for full engineering analysis and leverage details):

#v(2pt)
#table(
  columns: (1.5fr, 1.8fr, 1.4fr, 1.1fr, 1.4fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if y == 5 { rgb("#fff5f5") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 5pt, y: 3.5pt),
  [*Wind Condition*], [*Wing Posts (3/4" Pipe)*], [*Rear Rail (2x4 A)*], [*Total Ballast*], [*Field Status*],
  [Calm / Zero-Wind (0–8 mph)], [0 bags (unballasted)], [None], [0 lbs (153 lb prop)], [Safe to 8 mph (10 gust max)],
  [Light Breeze (8–12 mph)], [4x 15-lb bags (2 per wing post)], [None], [60 lbs (213 lb prop)], [Standard Deployment],
  [Advisory (12–18 mph)], [6x 15-lb bags (3 per wing post)], [None], [90 lbs (243 lb prop)], [Attentive Staging],
  [High-Wind (18–22 mph)], [6x 15-lb bags (3 per wing post)], [3x 15-lb bags flat], [135 lbs (288 lb prop)], [Max Safe Turf Limit],
  [*Abort (>20 mph / gusts >25)*], [—], [—], [—], [*NO-GO / LAY FLAT*],
)
#v(2pt)

- *Pre-Show Safety Check:* Verify all four swivel casters rotate freely, 360° swivel action is smooth without binding, mounting hex nuts are tightened securely, and strut hardware has zero play.
- *Staging Order:* Arrange backdrops in numerical show drill order at the field gate.
- *Exit Catch Crew & Uphill Transit Assistance:* Position parent volunteers (holding official Field Pass wristbands per Rule 9.07) at the stadium exit gate to receive carts from student handlers, assist with deceleration, and join students in pushing the fully ballasted carts all the way up the stadium ramp/hill to the trailer staging lot. Props cannot be de-ballasted at the stadium exit chute due to continuous traffic flow regulations.

=== B. Student Prop Handlers / Performers:

- *Field Operators:* Students have sole responsibility for pushing and maneuvering the backdrop carts onto the field, executing show transitions, and pushing them off the field at the conclusion of the performance.
- *Crew Pairing & Incline Safety:* No fewer than two student handlers are assigned to each backdrop cart under normal conditions, positioned on opposite outer end perimeter rails (B). During high-wind conditions or when navigating steep grades—such as the steep concrete tunnel entrance ramp at USAFA Falcon Stadium—additional student handlers (three to four students per cart) must be assigned to maintain positive braking, prevent runaway acceleration on downgrades, and provide adequate uphill momentum.
- *Instrument Stowage & Future Cradle Revision:* The central opening cradles an HDX 14-gallon tough storage tote (Index [9]) for student handlers to temporarily place their musical instruments while pushing carts onto and off the field. Operational Note: The 14-gallon tote accommodates smaller instruments (flutes, clarinets, trumpets, alto saxophones), but is constrained when handlers play larger instruments (mellophones, trombones, baritones, tenor/bari saxes, or battery percussion). A future design revision is planned to engineer an expanded modular instrument cradle system.
- *On-Field Positioning & Ground Chocking:* Carts are equipped with non-locking swivel casters to maximize rolling agility during rapid field entrances and exits. When props reach their drill coordinates in breezy conditions, handlers deploy supplemental double-bagged 15-lb sandbags on the ground directly against the wheels to serve as wheel chocks, preventing field drift during the performance.

#align(center)[
  #figure(
    image("assets/approved/figure_03_staging_assembled.jpg", width: 66%),
    caption: [*Figure 3.* Assembled rolling backdrops staged and ready for field deployment.]
  )
]

#pagebreak()

== 1.2 Staging, Transport & Field Gate Entry

Competitive field execution operates under strict time constraints governed by CBA Rule 5.01 and Rule 5.06 (15:00 master clock; 3:15 entry window; adults clear by 2:45). Smooth staging and gate entry require meticulous preparation:

1. *Pre-Staging Lineup & Gate Queue (Rule 5.02 & 5.03):* All backdrop props must enter from the back sideline or rear end zone gates (above goal posts). Never transit props through the front sideline gate or front end zone corridor. Queue backdrops in exact numerical show order along the rear staging chute.
2. *Adult Field Pass Wristbands (Rule 9.07):* All parent volunteers assisting with field movement must wear designated official Field Pass wristbands (strictly limited to 25 per band). Adults without wristbands must remain in the stadium concourse or spectator areas.
3. *Timing & Penalties (T&P) Gate Permission:* Never cross the stadium gate threshold onto the track or turf until the T&P judge grants official permission to enter. Bands may pre-stage in the rear half of the end zone up to the goal line while the preceding band finishes egress (Rule 5.03).
4. *Steep Ramp Transit & Incline Control:* When moving props from trailer parking down to field level (such as the steep concrete tunnel ramp at USAFA Falcon Stadium), deploy 3 to 4 handlers per cart. Two handlers push from the rear while one or two handlers control descent speed from the front corners, ensuring positive braking and eliminating runaway risk.

== 1.3 Field Deployment Protocol

Once entry permission is signaled, execute rapid field deployment:

1. *Gate-to-Field Transit:* Students take control of the staged carts at the field gate, placing instruments safely inside the central tote bin. Two-student teams push carts with the upright frame facing perpendicular to travel to maximize forward visibility.
2. *Track, Curb & Turf Transitions:* Approach all running track crossings, rubber protector mats, and turf curb transitions square-on at a steady walking pace. Both front casters *must* cross curbs simultaneously. Never approach curbs at an angle, which can bind casters or induce frame racking.
3. *Drill Coordinate Placement & Alignment:* Guide each cart directly to its marked field drill coordinate. Handlers square the cart face to the front sideline or angled show specification. Sight down the row of backdrops to verify flush, uniform visual presentation.
4. *Ground Sandbag Chocking:* Because carts feature non-locking swivel casters for rapid transport maneuverability, handlers must deploy ground chocks when staging on field. In breezy conditions, place extra double-bagged 15-lb sandbags firmly on the turf directly against the caster wheels to eliminate roll drift during the performance.
5. *Low Hand Placement & Push Leverage Rules:* Handlers must *always* keep hands low, grasping the outer wooden 2x4 perimeter rails (B) or inner reinforcement joists. *NEVER push, pull, or apply body weight to the upper 1-5/8 in. steel pipe frame or diagonal struts.* Pushing high creates massive overturning leverage that can tip the prop or bend steel mounting brackets.
6. *Handler Communications:* Handlers maintain continuous verbal communication during entry ('Clear left', 'Approaching curb', 'On coordinate', 'Chocks set'). Retrieve instruments from the central tote bin and assume opening performance sets before the 3:15 entry clock expires.

== 1.4 Post-Performance Retrieval & Continuous Exit

1. *Final Performance Cue:* On the final show chord, handlers immediately stow instruments in the central carrier tote, lift ground sandbag chocks onto the cart base (or hand them to sideline parent crew), and take pushing positions on end rails (B).
2. *Continuous Movement Mandate (CBA Rule 8.05):* Props must enter continuous motion immediately upon the conclusion of the performance and remain in continuous motion until entirely clear of the performance field and stadium concourse.
3. *Stadium Exit Catch Crew:* Parent volunteers with Field Pass wristbands (Rule 9.07) meet student handlers at the stadium exit gate to receive carts, assist with deceleration, and join students in pushing carts.
4. *Uphill Egress to Trailer (NO Chute De-Ballasting):* Props *cannot* be de-ballasted at the stadium exit chute or tunnel due to continuous egress regulations. Props remain fully ballasted (213–288 lbs) and are pushed all the way up the stadium ramp/hill to the equipment trailer staging lot. On steep inclines (USAFA Falcon Stadium), assign 3 to 4 handlers per cart to maintain continuous uphill momentum.

#pagebreak()

== 1.5 Ballasting System, Aerodynamic Stability & Tiered Wind Safety Protocols

To maintain vertical stability against outdoor wind shear while strictly protecting stadium athletic turf from rutting and sand contamination, all backdrop props must adhere to this engineering ballasting standard and operational loading schedule.

=== A. Standardized Tiered Ballasting & Wind Speed Schedule

Ballasting requirements are scaled dynamically based on observed stadium wind velocity and peak gust forecasts prior to field gate ingress:

#block(breakable: false)[
#set text(size: 8.5pt)
#table(
  columns: (1.2fr, 1.4fr, 1.4fr, 1.3fr, 1.0fr, 2.0fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if y == 5 { rgb("#fff5f5") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 4pt, y: 2.6pt),
  [*Tier / State*#footnote[Without wind relief cuts, the props may be used by derating all wind regimes by 2 mph, decreasing the Tier 4 Abort threshold to 12 mph sustained / 16 mph gusts, and increasing the duck blind Tier 0 ballasting to 2 bags.]], [*Wind Velocity*], [*Wing Posts (3/4" Pipe)*], [*Rear Rail (2x4 A)*], [*Total Ballast*], [*Max Safe Gust & Protocol*],
  [Tier 0: Calm], [0–8 mph, gusts #sym.lt.eq 10], [0 bags (unballasted)], [None], [0 lbs (153 lb total)], [10.0 mph safe gust (14.4 mph tip limit). FoS #sym.gt.eq 2.07. Upgrade to Tier 1 if wind >8 mph.],
  [Tier 1: Normal], [Light breeze (8–12 mph)], [4x 15-lb bags (2 per wing post; 30 lb/side)], [None], [60 lbs (213 lb total)], [16.9 mph max gust. Standard operations; zero turf compaction.],
  [Tier 2: Advisory], [Moderate breeze (12–18 mph)], [6x 15-lb bags (3 per wing post; 45 lb/side)], [None], [90 lbs (243 lb total)], [18.4 mph max gust. Handlers deploy ground sandbag chocks if breezy.],
  [Tier 3: High-Wind], [High wind (18–22 mph)], [6x 15-lb bags (3 per wing post; 45 lb/side)], [3x 15-lb bags laid flat along rear rail A], [135 lbs (288 lb total)], [22.5 mph max gust. Symmetrical stability; max safe turf limit.],
  [*Tier 4: Safety Abort*], [Severe gale (>20 sust. / >25 gusts)], [—], [—], [—], [*UNSAFE. Field withdrawal / NO-GO.* Props kept off field or laid flat.],
)
]

=== B. High-Wind Rear-Rail Ballast Leverage Optimization

Because the 10 ft x 8 ft vertical upright steel frame sits on the front perimeter rail (A) of the cart base, the structure possesses an inherent tipping asymmetry:

1. *Critical Failure Mode (Forward Tipping):* When wind blows from the rear toward the front, the cart pivots about the front caster wheels. Because the 48-lb steel frame and vinyl banner sit directly above the front caster line, their deadweight provides zero restoring leverage. As a result, an unballasted prop tips forward at just 12.4 mph (11.2 mph at sea level).
2. *The Rear-Rail Mechanical Advantage:* The 3/4-in. wing pipe posts sit at mid-depth (22.25 in. from front), providing a restoring lever arm of 1.71 ft to the front casters. By contrast, placing supplemental sandbags along the rear 2x4 framing rail (A) behind the instrument tote increases the lever arm to 3.46 ft (41.5 in.)—more than double the mechanical leverage! Three 15-lb bags placed across the rear rail produce the overturning resistance of six bags stacked on the center posts, equalizing forward and backward tipping thresholds to 22.5 mph.
3. *Turf Compaction Ceiling:* Total supplemental ballast must never exceed 140 lbs (293 lbs total prop deadweight). Concentrating more than ~75 lbs per caster wheel causes casters to sink into artificial turf rubber infill, multiplying rolling drag and risking permanent turf depressions or track damage.

=== C. Mandatory Double-Bagging Protocol (CBA Rule 8.05)

All 15-lb sandbags MUST utilize heavy-duty inner plastic liner insert bags (Index [14]) sealed securely inside the outer fabric cordura bags. Under no circumstances may unbagged or single-layer sandbags be brought onto any competition turf. If an outer fabric bag abrades, splits, or suffers seam failure, the heavy-duty inner liner guarantees zero sand escapes onto the performance field.

=== D. Emergency Reserve Protocol (70-lb Tube Sand)

In the event that 15-lb handle sandbags are depleted or extreme wind gusts threaten during stationary staging, crew may deploy 1 to 2 70-lb Sakrete traction tube sand bags (Index [15]) positioned flat across the rear lumber framing rail. MANDATORY: Every 70-lb tube sandbag MUST be completely wrapped and sealed inside a thick contractor-grade garbage bag to satisfy the secondary containment rule before entering the stadium.

=== E. Weather Monitoring & High-Wind Abort Protocol

The Prop Lead carries a digital handheld anemometer and monitors decoded airport METAR feeds (`KCOS`, `KFLY`, `KBJC`, `KAPA`) and Wunderground PWS stations. If sustained winds exceed 20 mph or sudden gusts exceed 25 mph, rolling backdrops *must not* enter the performance field (strict safety NO-GO threshold). If severe gusts strike while props are already on the field, student handlers position themselves on the upwind side of the cart, place ground sandbag chocks firmly against wheels, and brace the lower 2x4 framing. Designated parent volunteers with Field Pass wristbands (Rule 9.07) will step onto the field to provide perimeter stabilization or assist handlers in immediately tipping the props flat onto the turf if ordered by band directors.

#warning-box(title: "CRITICAL TURF OPERATION & DOUBLE-BAGGING MANDATE")[
  Under no circumstances may unbagged or single-layer sandbags be brought onto any competition turf (see Section 1.6, Rule 8.05). In addition, do not exceed 135–140 lbs total ballast under any operational conditions, as excessive weight causes casters to sink into artificial turf rubber infill, multiplying rolling friction and making carts sluggish for student handlers.
]

#pagebreak()

== 1.6 Applicable 2026 CBA Competition Rules

The following governing rules are extracted directly from the official 2026 Colorado Bandmasters Association (CBA) Marching Band Rulebook (Index [17]). All prop builders, parent crew, and student handlers must adhere to these standards:

#note-box(title: "ANNUAL RULEBOOK NOTICE")[
  This section reflects the governing rules for the 2026 competitive season. Logistics staff and build leads must review this section annually against updated CBA and Bands of America (BOA) rulebooks to verify continuing compliance.
]

=== Rule 4.02: Emergency Assistance & Safety Exceptions
- *Medical Emergency (Rule 4.02(c)):* *NO PENALTY.* Any band member becoming ill or injured during performance may be assisted from the field by an adult volunteer, parent, staff member, EMT, or CBA official without penalty.
- *High-Wind Prop Safety Restraint (Rule 4.02(a)):* If high winds threaten props falling over, adults may enter the field for the sole purpose of securing the prop. At no time during the performance may an adult move the prop as part of visual choreography.

=== Rule 4.03 & 5.06: Field Clearance & Adult Turf Penalty
- *Field Clearance Window:* All adult volunteers assisting with props *must be completely clear* of the performance field before the introductory announcement ends (commences 3:15 after entry permission). Any adult still on field when announcement ends incurs an immediate *0.2 point score penalty* for the band.
- *Re-Entry Prohibition:* Adults are strictly prohibited from entering or re-entering the performance field during the show. Unauthorized entry incurs an immediate *0.2 point penalty per occurrence*.

=== Rule 5.02: Rear Entrance Mandate
- *Gate Ingress Routing:* All props and equipment must be brought onto the performance field from the band entrance gate (back sideline or rear end zone gates above goal posts). Never enter across the front boundary line (reserved strictly for pit equipment).

=== Rule 8.05: Props, Equipment, Surface Protection, and Double-Bagging
- *Gate Ingress:* All props and equipment must be designed and of a quantity such that they can be brought onto the Performance Field from the band entrance gate.
- *Continuous Movement:* Following the end of the band's Performance, all props and equipment must be in continuous movement until entirely removed from the stadium.
- *Turf Contact Protection:* All wooden props must be protected with a heavy-duty sustainable plastic product (PVC, Melamine, etc.) where said prop comes in contact with the field surface. Steel props with smooth edges are acceptable without the need for additional protection.
- *Secondary Containment for Sandbags:* Props must not leave holes in the Performance Field surface. Sand bags must be in a secondary container (bucket, double bagged, etc.) that will prevent sand from leaking.

=== Rule 8.07: Equipment Wheel and Turf Protection Standards
- *Pneumatic-Like Tires:* All instruments and equipment wheeled into the stadium from the entrance gate forward must have pneumatic-like tires. Wheels must be able to support the weight of the instrument/prop without creating damage to the field surface.

=== Rule 8.08: Prop Staging Height Restrictions
- *12-Foot Rigid Height Limit:* Staging (props, backdrops, screens, or similar objects) built and/or used by bands at CBA sanctioned events shall be limited to a maximum total height of twelve (12) feet, including wheels, platforms, and safety railings. Materials such as wood, metal, plastic, or aluminum are not permitted above the twelve-foot limit.

=== Rule 8.09: Prop Assembly, Timing, and USAFA Falcon Stadium Clearance
- *Staging Ingress:* A band may bring props into the stadium after the previous band has entered the field. Props must fit in the end zone curve without blocking entrance/exit gates.
- *Falcon Stadium 9'6" Tunnel Rule:* Any prop being used at Falcon Stadium (United States Air Force Academy) must not exceed 9 ft 6 in. to clear the tunnel entrance. Props up to the 12-ft limit may be erected in the tunnel after clearing the initial entrance.
- *Falcon Stadium Venue Update (2025/2026):* While the 9'6" tunnel restriction remains in the printed CBA rulebook, it has been rendered obsolete by stadium renovations completed prior to the 2025 season. The lower overhead crossbeam at the bottom of the Falcon Stadium tunnel was permanently removed, and these backdrop props cleared the tunnel entrance at their full upright height (~10.8 ft) without issue throughout the 2025 season. However, the tunnel concrete ramp is exceptionally steep; crews must assign supplemental handlers (3–4 students per cart) rather than the standard two-student pairing to control cart descent and ascent.

=== Rule 9.07: Parent Field Access & Wristband Limits
- *25 Field Pass Wristbands:* Access to the field is restricted to Directors/Staff with CBA passes and parents assisting with props/front ensemble with designated Field Pass wristbands. Each band receives exactly 25 Field Pass wristbands upon check-in. Additional wristbands are not available.

#pagebreak()

== 1.7 Post-Use Teardown, Inspection & Trailer Packout

1. *Continuous Egress & Uphill Transit to Trailer:* Props CANNOT be de-ballasted at the stadium exit chute or concourse. Rule 8.05 requires continuous movement off the field, and stadium chutes must remain clear for following bands. Student handlers and parent crew push fully ballasted carts (213–288 lbs total) all the way up the hill/ramp to the equipment trailer staging lot. On steep inclines (such as Falcon Stadium), 3 to 4 handlers must be assigned per cart to ensure adequate pushing force and prevent rollbacks.
2. *"Two-Shot" Competitions (Prelims & Finals Inter-Show Staging):* Most marching band competitions feature an afternoon Preliminary contest followed by an evening Finals competition. Between shows, props remain staged in the trailer lot with all sandbag ballast left in place on the carts to minimize volunteer labor and avoid hardware wear. If wind gusts threaten during inter-show lot staging, crew lay the vinyl frames flat directly onto the carts by pulling the quick-release retaining pin from each two-piece diagonal support strut. This eliminates wind sail area while keeping props fully ballasted and ready for rapid re-erection before Finals.
3. *Final Teardown De-Ballasting (At Trailer Only):* Following the final performance of the day (or when preparing for trailer transport), remove all 15-lb sandbags at the trailer. Stack sandbags low over the trailer axles on rubber floor mats to maintain a low center of gravity and balanced axle load during transit.
4. *Two-Piece Strut Disassembly & Pin Stowage:* Pull the quick-release wire-lock retaining pin holding the upper and lower strut sections together. Stow the pins immediately in the hardware container inside the center HDX tough tote to prevent loss during travel.
5. *Strut Lower Arm Stowing & Upper Arm Vinyl Protection (Tennis Balls):* Allow the lower half of each strut to pivot down flat against the cart decking (it remains anchored to the base U-bolt throughout transport). Install a standard tennis ball with a hole cut in it securely over the exposed open end of each upper strut arm (which remains attached to the vertical frame upright). This cushioned ball prevents the metal tube end from puncturing, tearing, or abrading the printed scrim vinyl during transit and handling.
6. *Rapid Frame-to-Cart Unbolting (Power Driver Recommended):* Remove the bolts securing the vertical upright steel frame to the cart base tension bands / clamp brackets along the front lumber rail. Using a cordless power drill/driver with an appropriate socket is strongly recommended to accelerate nut and bolt removal during tight post-show teardown intervals. Stow all mounting bolts, nuts, and washers in the cart's hardware container.
7. *Vinyl Frame Loading onto Trailer Cross Support Beams:* With two operators lifting opposite sides, carry the detached 10 ft × 8 ft steel frame with installed vinyl banner (and tennis-ball protected upper strut arms) into the equipment truck/trailer. Slide the frames onto the trailer's interior cross support beams (load bars / shoring beams / attic deck racks) as shown in Figure 5.
8. *Cart Base Stowing on Short End & Ratchet Strap Restraint:* Roll the detached wooden cart bases into the truck. Stand each cart base vertically on its short end up against the front nose wall of the truck (Figure 4). The 3D-printed ASA corner bumpers prevent scuffing between adjacent carts. Secure the cart bases firmly against the nose wall using heavy-duty E-track ratchet straps wrapped around the 2x4 lumber framing rails. NEVER strap across the steel pipe posts or the lower strut arms.

#v(4pt)
#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  align(center)[
    #figure(
      image("assets/approved/figure_04_trailer_transport.jpg", width: 92%),
      caption: [*Figure 4.* Rolling cart bases strapped to front trailer nose wall for transit.]
    )
  ],
  align(center)[
    #figure(
      image("assets/approved/figure_05_stacked_frames.jpg", width: 92%),
      caption: [*Figure 5.* Stacked steel backdrop frames in trailer storage rack.]
    )
  ]
)

#pagebreak()

// -----------------------------------------------------------------------------
// APPENDIX B: CONSTRUCTION & FABRICATION MANUAL (PAGE B-1 COVER)
// -----------------------------------------------------------------------------

#set page(header: none)
#appendix-id.update("B")
#appendix-title.update("APPENDIX B | CONSTRUCTION MANUAL")
#counter(page).update(1)

#appendix-cover(
  kicker: "APPENDIX B",
  title: "Construction & Fabrication Manual",
  subtitle: "Materials, cutting, cart assembly, ballast retention posts, instrument tote, steel frame, vinyl, and source lookup",
  body-text: [
    This appendix contains the complete bill of materials, workshop safety standards, 2x4 lumber cart base fabrication procedure, 1-5/8 in. steel upright frame assembly, diagonal strut guided pre-drilling protocol, full-bleed vinyl banner installation procedure, inspection checklist, and component index.
  ],
  audience: [Band prop construction leads, parent build volunteers, and fabrication teams],
  contents: [Shop safety; full BOM; 3D-printed fixtures; lumber and steel cut schedules; cost breakdown; 4-stage frame assembly; vinyl tensioning and snap clamping; quality checklist; indexed purchase sources],
  print-label: [All pages labeled B-],
  revision: [Release v0 (unreleased) | Development build D5 | September 2026],
  separation-note: [When separated from the master document, keep this cover as the first page of Appendix B.]
)

#pagebreak()

// -----------------------------------------------------------------------------
// APPENDIX B: CONTENT PAGES (B-2 THROUGH B-12)
// -----------------------------------------------------------------------------
#set page(header: make-header("APPENDIX B | CONSTRUCTION MANUAL"))

= Appendix B: Construction & Fabrication Manual

== 2.1 Safety, Work Area & Shop Protocol

1. *Personal Protective Equipment (PPE):* Always wear ANSI Z87.1 safety glasses and hearing protection when cutting lumber, operating metal saws, or drilling galvanized steel tubing.
2. *Workspace Setup:* Provide a clean, flat 12 ft x 12 ft assembly floor for squaring the 96″ x 44.5″ cart base and 10′ x 8′ steel upright frame.
3. *Cut Edges & Fasteners:* Freshly cut steel pipe ends must be deburred with a half-round file before assembly. Clear metal shavings promptly from work areas to prevent scratching vinyl graphics.

== 2.2 Materials & Component Inventory (BOM)

#block(breakable: false)[
#set text(size: 8.2pt)
#table(
  columns: (1.5fr, 2.5fr, 1.0fr, 1.4fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 4pt, y: 2.1pt),
  [*Component*], [*Specification*], [*Qty / Prop*], [*Source*],
  [2x4 SPF / Doug Fir], [2x4x8 ft framing lumber (96″ rails, 44.5″ joists)], [8 pcs], [Lumber yard],
  [1/2″ Plywood Decking], [1/2 in. CDX / Sanded Plywood (Left & Right wings)], [1 sheet], [Lumber yard],
  [3/4″ Floor Flanges], [3/4 in. Black Iron Threaded Floor Flanges], [2 pcs], [Index [16] / Home Depot],
  [3/4″ x 18″ Iron Pipe], [3/4 in. Dia. x 18 in. Threaded Black Iron Pipe (Posts)], [2 pcs], [Index [16] / Home Depot],
  [Flange Carriage Bolts], [1/4-20 x 1-1/2 in. Carriage Bolts, Washers, Lock Nuts], [8 sets], [Hardware store],
  [HDX 14-Gal. Storage Tote], [14-Gallon Tough Tote (Black/Yellow) - Instrument Carrier], [1 pc], [Index [9] / Home Depot],
  [GRK #9 x 2-1/2″ Screws], [Star-drive R4 multi-purpose screws (Red markers)], [~40 pcs], [Index [5] / Home Depot],
  [GRK #10 x 4″ Screws], [Self-countersinking flat head screws (Blue markers)], [12 pcs], [Index [6] / Home Depot],
  [Swivel Casters], [Heavy-duty turf-compatible non-locking swivel plate casters], [4], [Index [4] / Amazon],
  [Fence Line Posts], [1-5/8″ Dia. x 10 ft 16-Ga. Galvanized Steel Posts (Black)], [2], [Index [1] / Home Depot],
  [Fence Top Rails], [1-5/8″ Dia. x 8 ft Top Rails (Frame & Struts)], [4], [Home Depot],
  [3-Way Corner Clamps], [1-5/8″ 3-Way Clamp Corner Elbow Brackets], [4], [Index [2] / Amazon],
  [Fence Tension Bands], [1-5/8″ Galvanized Steel Tension Bands], [4], [Index [3] / Home Depot],
  [Steel End Caps & U-Bolts], [1-5/8″ Steel Rail End Caps & Heavy-Duty U-Bolts], [4 caps, 2 U-bolts], [Index [7] / Amazon],
  [15-lb Handle Sandbags], [Abccanopy 15-lb Heavy-Duty Sandbags w/ Handle], [4–9 pcs (4–6 wing, 3 rear)], [Index [13] / Amazon],
  [Sandbag Inner Liners], [Heavy-Duty Plastic Sandbag Liner Bags (Double-Bag)], [4–9 pcs (Double-Bag)], [Index [14] / Amazon],
  [70-lb Tube Sand (Reserve)], [Sakrete 70-lb Traction Tube Sand + Contractor Bags], [1–2 pcs (Reserve only)], [Index [15] / Lowe's],
  [Custom Vinyl Banner], [Heavyweight outdoor scrim vinyl (flush cut, no hems/grommets)], [1], [Custom printed],
  [Greenhouse Snap Clamps], [1-1/4″ Greenhouse Snap Clamps (sized for 1-5/8″ fence pipe w/ vinyl)], [14 pcs], [Index [8] / Amazon],
  [Double-Sided Tape], [1-in. heavy-duty mounting tape (14x ~4-in. strips)], [1 roll], [Hardware supplier],
  [Moving Blankets], [Clean protective floor pads for scratch-free vinyl staging], [3–4], [Shop stock],
  [Relief Hole Punch Tool], [3/8-in. (10 mm) Rotary Leather Punch / Gasket Hole Punch], [1 pc], [Workshop stock],
  [Field Prop Circle Cutter], [PCHSMB Circle Cutter arm w/ #11 blade (R = 4.0 in.)], [1 pc], [Index [18] / 3D Print],
  [Strut Retaining Pins], [1/4" or 5/16" Wire lock hitch pins for 2-piece strut joint], [2 pcs], [Hardware stock; in tote],
  [Protective Tennis Balls], [Standard tennis balls with cut hole (protective caps for upper strut ends)], [2 pcs], [Pit crew stock; protects vinyl],
)
]

#pagebreak()

== 2.3 Tools, Equipment & 3D-Printed Jigs

#v(-2pt)
#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    - Miter or circular saw w/ framing blade
    - Metal chop saw or reciprocating saw
    - Impact driver with Torx T-25 bit
    - Cordless drill w/ 1/8" HSS/Cobalt bit
    - PCHSMB Field Prop Circle Cutter (Index [18])
  ],
  [
    - 5/16" socket, 7/16" & U-bolt wrenches
    - Pipe wrench for 3/4" iron pipe/flanges
    - 25-ft tape measure, framing & speed square
    - 3/8-in. (10 mm) rotary leather punch & mallet
    - Isopropyl alcohol and microfiber rags
  ]
)

== 2.4 3D-Printed Parts Specifications

Print all fixtures in Black ASA or PETG for outdoor UV and heat stability. Do not use PLA.

#v(1pt)
#block[
#set text(size: 8.8pt)
#table(
  columns: (1.5fr, 0.6fr, 3.5fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 4pt, y: 2.2pt),
  [*Part / Tool*], [*Qty*], [*Purpose & Source File*],
  [Corner Bumper Braces], [4], [Protects 2x4 outer corners from scuffing; Index [10] (`Hardware/Corner Brace.FCStd`)],
  [Drill Alignment Jig], [1], [Guides 1/8" pilot holes through 1-5/8" fence pipe; Index [11] (`Hardware/Drill Alignment Jig.3mf`)],
  [Strut Bracket Marker], [1], [Locates base U-bolt & upper tension band positions; Index [12] (`Hardware/Steel Support Strut Bracket Marker.FCStd`)],
  [Field Prop Circle Cutter], [1], [R = 4.0 in. radius cutter arm w/ #11 blade; Index [18] (`Circle Cutter/circle_cutter_arm.stl`)],
)
]

== 2.5 Raw Material Cutting Schedules

=== A. Lumber Cut Schedule (2x4 SPF / Doug Fir Framing Lumber — 8 Sticks Total)
- *Outer Rails (A):* 2 pcs @ 96.0 in. (cut from 2 sticks; square factory ends).
- *End Rails (B):* 2 pcs @ 44.5 in. (cut from 1 stick: 44.5" + 44.5" = 89.0", with 7.0" drop).
- *Inner Reinforcement Rails (C):* 2 pcs @ 89.0 in. (cut from 2 sticks; laminates inner face of A rails).
- *Transverse Cross Joists (D):* 6 pcs @ 41.5 in. (cut from 3 sticks: 2 pcs per 8-ft stick @ 41.5" = 83.0", with 13.0" drop).
- *Plywood Decking (1/2" Sanded CDX):* 2 panels @ 44.5 in. wide × 24.0 in. deep (cut from 1 sheet; left wing rail B to 2nd D, right wing 5th D to rail B; center bay between 3rd and 4th D left open at ~19 in. clear to cradle HDX 14-gal tote).

=== B. Galvanized Steel Tubing Cut Schedule (1-5/8" Fence Line Posts & Top Rails)
- *Vertical Upright Posts:* 2 pcs @ 10 ft 0 in. (standard uncut 16-gauge fence line posts).
- *Top & Bottom Cross Rails:* 2 pcs @ 8 ft 0 in. (cut from 1-5/8 in. top rail; trimmed square for 3-way corner brackets).
- *Two-Piece Diagonal Support Struts:* 2 modular strut assemblies with sleeved joint and quick-release wire-lock pin.

== 2.6 Estimated Fabrication Cost Breakdown

The following table itemizes estimated material costs per backdrop prop based on standard retail pricing (excluding custom printed vinyl):

#v(1pt)
#block[
#set text(size: 8.8pt)
#table(
  columns: (1.8fr, 3.2fr, 1.0fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if y == 7 { rgb("#ebf8ff") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 4pt, y: 2.0pt),
  [*Subsystem / Category*], [*Items Included*], [*Est. Cost*],
  [Cart Base Framing], [8x 2x4 SPF lumber, 1/2 sheet 1/2" plywood, GRK screws, paint], [\$98.00],
  [Casters & Bumpers], [4x Heavy-duty non-locking swivel casters, 4x ASA corner bumpers], [\$51.00],
  [Ballast Posts & Tote], [2x 3/4" flanges & 18" pipes, carriage bolts, 1x HDX 14-gal tote], [\$46.00],
  [Upright Steel Frame], [2x 10-ft 16-ga fence posts, 2x 8-ft top rails, 4x 3-way brackets, bands], [\$121.00],
  [Diagonal Struts & Mounts], [1x 10-ft top rail (2 struts), 4x end caps, tension bands, 2x U-bolts], [\$49.50],
  [Vinyl Attachment Hardware], [1-1/4" greenhouse snap clamps pack (14 pcs), 1" heavy-duty tape, pilot hardware], [\$25.00],
  [*TOTAL PER PROP (EXCL. VINYL)*], [*Hardware & lumber complete chassis*], [*\~\$390.00*],
)
]
#v(1pt)

*Optional Rule 8.05 Ballast Pack:* 4–9 Abccanopy 15-lb handle sandbags + inner double-bag liners + traction sand adds approximately *+\$37.00 to \$55.00* per cart (scaled to the Tiered Ballasting Schedule in Section 1.5).

#pagebreak()

== 2.7 Step-by-Step Frame Assembly

=== Stage 1: Assemble the Rolling Cart Base

The rolling cart base is fabricated from 2x4 SPF/Doug Fir lumber according to the component layout and fastener map shown in Figure 1:

#align(center)[
  #figure(
    image("assets/approved/Drawing.png", width: 80%),
    caption: [*Figure 1.* Top-down 2x4 rolling cart frame layout and screw fastening map.]
  )
]

=== Stage 1 Assembly Procedure:
1. *Cut Lumber:* Cut outer longitudinal rails (A) to 96.0 inches and end perimeter rails (B) to 44.5 inches.
2. *Square Perimeter:* Lay the four perimeter members flat on the shop floor. Measure opposite diagonals to confirm exact squareness.
3. *Outer Corners:* Fasten each outer corner joint with two GRK 9 x 2-1/2 in. wood screws (red markers labeled 'x2').
4. *Joist Layout:* Place six cross joists (D): two flush against the inner face of end rails (B), and four interior joists spaced to define the left decking wing, open tote bay, and right decking wing.
5. *End Joists:* Secure each outer end joist (D) to end rail (B) with three GRK 9 x 2-1/2 in. screws.
6. *Structural Screws:* Drive GRK 10 x 4 in. structural screws (blue markers) from outside rail (A) into the end grain of each cross joist (D) (two structural screws per joist).
7. *Lamination:* Laminate inner reinforcement rails (C) to the inside faces of rails (A) using GRK 9 x 2-1/2 in. screws as indicated by the interior red markers.

#pagebreak()

=== Stage 2: Install Decking, Ballast Posts, Casters, and Instrument Tote

1. *Plywood Decking:* Fasten two 1/2-in. plywood panels across the left wing (outer rail B to 2nd joist D) and right wing (5th joist D to outer rail B) with 1-1/4 in. screws. Confirm the center bay between the 3rd and 4th joists remains completely clear to receive the HDX 14-gallon tough tote.
2. *Ballast Retention Post Flange Installation:* Locate the geometric center of each 1/2″ plywood wing panel. Position a 3/4-in. black iron floor flange (Index [16]) and mark four bolt holes. Drill 1/4″ clearance holes through the plywood. Secure each flange from the underside using 1/4-20 x 1-1/2 in. carriage bolts, flat washers, and nylon lock nuts. Thread a 3/4-in. x 18-in. black iron pipe into each flange and tighten firmly with a pipe wrench.
3. *Instrument Carrier Tote Installation:* Insert the central HDX 14-gallon tough storage tote (Index [9]) into the open center frame bay between the 3rd and 4th cross joists (D). The tote rim rests on the 2x4 framing to serve as the student instrument carrier during show operations. (Note: A future design revision is planned to accommodate larger instrument geometries).
4. *Painting:* Paint all cart bases and wood surfaces with exterior-grade semi-gloss black paint before final caster assembly (Figure 7).
5. *Swivel Casters:* Invert the cart base. Mount four heavy-duty swivel plate casters (Index [4]) directly beneath the corner lumber intersections using 5/16 in. x 1-1/2 in. structural timber screws with flat washers (Figure 9).
6. *Corner Bumpers:* Fasten four 3D-printed Corner Braces (Index [10]) over each outer corner with 8 pan-head screws to protect the wood cart from transport impacts.

#v(2pt)
#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  align(center)[
    #figure(
      image("assets/approved/figure_07_cart_painting.jpg", width: 92%),
      caption: [*Figure 7.* Cart base frames painted black with plywood decking wings installed.]
    )
  ],
  align(center)[
    #figure(
      image("assets/approved/figure_09_caster_wheel.jpg", width: 92%),
      caption: [*Figure 9.* Swivel caster wheel assembly mounted beneath corner framing.]
    )
  ]
)

*Operational Caster Fastening Standard:* While early prototype builds utilized wing nuts as pictured in Figure 9, field operations standardized on standard hex nuts. Using standard hex nuts enables parent crew to rapidly remove and secure casters using an impact driver / cordless drill, significantly outperforming manual wing nut threading during teardowns.

=== Stage 3: Assemble the Upright Backdrop Frame

1. *Upright Rectangle:* Join two 10-ft 16-gauge steel fence line posts and two 8-ft top rails using four 1-5/8 in. 3-way clamp corner elbow brackets (Index [2]). Bottom out all tube ends inside the clamp sockets and tighten clamp bolts evenly.
2. *Base Attachment:* Stand the upright frame against the front rail (A) of the cart base. Anchor the bottom of each vertical post using 1-5/8 in. galvanized steel tension bands (Index [3]) through-bolted to the 2x4 lumber frame.

#pagebreak()

=== Stage 4: Fabricate and Install Diagonal Support Struts

Because 16-gauge galvanized steel is exceptionally hard, direct self-tapping screws will skate and dull. Follow this guided drilling protocol:

1. *Strut Preparation:* Cut two diagonal strut lengths from 1-5/8 in. steel top rail and slide 1-5/8 in. steel end caps over each end.
2. *Guided Pre-Drilling:* Clamp the 3D-printed Drill Alignment Jig (Index [11]) over the end cap pilot location. Using a 1/8-in. HSS / Cobalt drill bit rated for steel, drill clean pilot holes through the end cap and underlying pipe wall. Drive self-tapping screws into the pre-drilled holes to lock the end caps permanently.
3. *Frame Mounting:* Mount upper tension bands on the vertical posts using the 3D-printed Strut Bracket Marker template (Index [12]). Bolt the upper strut end caps to the tension bands. Anchor the lower strut end caps to the rear 2x4 cart framing with heavy-duty steel U-bolts (Index [7]) as shown in Figure 8. In production, each diagonal strut is fabricated as a two-piece modular assembly with a mid-span sleeved joint and drilled retaining pin hole (secured with a quick-release wire-lock pin). This enables rapid separation during trailer loading, allowing the lower arm to fold flat onto the cart while the upper arm remains on the frame with a protective tennis ball cap.

#align(center)[
  #figure(
    image("assets/approved/figure_08_completed_frame.jpg", height: 4.8in),
    caption: [*Figure 8.* Completed rolling cart base and upright steel frame assembly.]
  )
]

#pagebreak()

== 2.8 Mechanical Inspection & Quality Assurance Protocol

Verify each checkpoint prior to certifying the mechanical frame and cart assembly for vinyl banner installation:

#v(2pt)
#table(
  columns: (0.4fr, 1.8fr, 3.2fr, 1.2fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 4pt, y: 3.5pt),
  [*#chk*], [*Subsystem / Item*], [*Acceptance Criteria & Standard*], [*QC Status*],
  [#chk], [Cart Base Squareness], [Opposite diagonal measurements within 1/8 in. Frame sits flat.], [[ ] Pass  [ ] Rework],
  [#chk], [Fasteners & Framing], [All GRK red and blue screws fully countersunk; zero split lumber.], [[ ] Pass  [ ] Rework],
  [#chk], [Wing Ballast Posts], [3/4" flanges through-bolted securely; 18" pipes rigid with zero wobble.], [[ ] Pass  [ ] Rework],
  [#chk], [Instrument Tote Bay], [HDX 14-gallon tough tote drops smoothly into center bay.], [[ ] Pass  [ ] Rework],
  [#chk], [Swivel Casters], [Smooth 360° rotation; hex nuts torqued; rolls freely without wobble.], [[ ] Pass  [ ] Rework],
  [#chk], [Corner Bumpers], [4x ASA corner braces secured firmly with pan-head screws.], [[ ] Pass  [ ] Rework],
  [#chk], [Upright Steel Frame], [All four 3-way corner clamp elbow bolts torqued securely.], [[ ] Pass  [ ] Rework],
  [#chk], [Diagonal Struts], [End caps pre-drilled and screwed; 2-piece wire-lock pins locked.], [[ ] Pass  [ ] Rework],
  [#chk], [Frame-to-Cart Mount], [Tension band clamp bolts fully torqued; upright square to base.], [[ ] Pass  [ ] Rework],
)

#v(6pt)
#rect(width: 100%, fill: rgb("#f7fafc"), stroke: 1pt + rgb("#cbd5e0"), radius: 4pt, inset: 10pt)[
  #text(weight: "bold", size: 9pt, fill: rgb("#1a365d"))[MECHANICAL FRAME QUALITY ASSURANCE SIGN-OFF]
  #v(4pt)
  #grid(
    columns: (1fr, 1fr),
    row-gutter: 8pt,
    column-gutter: 14pt,
    [Prop Unit ID / Number: #blank(120pt)],
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

== 2.9 Vinyl Banner Installation & Frame Mounting Protocol

#note-box(title: "VINYL INSTALLATION & WIND FLAP PROTOCOL")[
  Procedure for vinyl installation using perimeter double-sided tape, hardware relief slits, engineered semicircular wind relief flaps, and mechanical greenhouse snap clamps. Follow all steps over clean moving blankets.
]

This section governs the preparation, alignment, dual-axis tensioning, relief slit cutting, and mechanical fastening of custom printed vinyl coverings to completed backdrop upright frames. Installing vinyl on the 10 ft x 8 ft steel frame requires a clean staging area, careful bleed centering, razor relief cuts for protruding frame hardware, double-sided tape adhesion, and mechanical clamping with greenhouse snap clamps to prevent loosening under high stadium wind loads.

=== 2.9.1 Banner Ordering, Bleed & Material Specifications

Custom printed backdrop banners must be ordered to exact dimensions to provide clean full-bleed framing around the outer perimeter of the steel pipe structure. The specifications below define the required production allowances:

#v(2pt)
#table(
  columns: (2.2fr, 3.8fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 6pt, y: 3.5pt),
  [*Specification / Parameter*], [*Engineering Requirement / Dimension*],
  [Nominal Upright Frame Size], [8 ft Width × 10 ft Height (96.0 in. × 120.0 in. outer pipe perimeter)],
  [Visible Graphic / Live Face], [96.0 in. Width × 120.0 in. Height (Front visible image area)],
  [Perimeter Bleed Wrap Allowance], [3.0 in. per border (top, bottom, left, and right outer pipe wrap)],
  [Overall Flat Cut Size], [102.0 in. Width × 126.0 in. Height (Including bleed allowance)],
  [Substrate Material], [13 oz or 18 oz heavy-duty outdoor matte scrim vinyl (UV and tear resistant)],
  [Edge Perimeter Finish], [Square raw-cut perimeter; DO NOT order hemmed borders or brass grommets, as raw edges wrap smoothly under snap clamps.],
)

=== 2.9.2 Step-by-Step Vinyl Tensioning, Wrapping & Clamping Procedure

1. *Clean Staging & Surface Protection:* Clear an unobstructed shop workspace measuring at least 12 ft x 14 ft. Thoroughly sweep and vacuum the area to remove metal chips, drill burrs, or grit that could puncture or scratch the printed vinyl face. Lay clean moving blankets flat across the floor. Carefully unroll the custom vinyl banner face down directly onto the blankets.
2. *Frame Placement & Bleed Alignment:* With two operators lifting opposite ends, carry the assembled 10 ft x 8 ft steel upright frame onto the staging area and place it face down centered over the back side of the vinyl banner. Shift the frame incrementally until an equal reveal of bleed extends evenly on all four sides. Verify frame squareness by measuring crossed diagonals prior to applying tape or making relief cuts.
3. *Hardware Relief Slits:* Use a fresh, sharp utility razor knife to make small, neat relief slits in the bleed wrap to clear protruding frame hardware:
  - *Vertical Uprights:* Cut slits aligned with the diagonal support strut tension band brackets on left and right uprights.
  - *Bottom Rail:* Cut two slits along the bottom rail bleed wrap corresponding to the base mounting tension bands.
4. *Perimeter Double-Sided Tape Application:* Cut fourteen (14) strips of 1-in. heavy-duty double-sided tape (~4 in. length). Apply 4 strips per vertical upright (8 total; 2 flanking each strut bracket) and 3 strips per cross rail (6 total). Burnish firmly to pipe and peel release backing liners.
5. *Long-Side Tensioning & Initial Wrap:* Start along left vertical upright. Ease strut bracket through relief slit, fold vinyl bleed tightly around pipe, and press into tape strips. Move to right upright: pull vinyl firmly across frame face to eliminate all wrinkles and slack, ease second bracket through its slit, fold tightly around pipe, and press into opposing tape strips. Verify uniform longitudinal tension.
6. *Short-Side Dual-Operator Tensioning & Wrap:* Station operators at top and bottom cross rails. Working simultaneously, pull outward in opposing directions to establish balanced transverse tension without racking frame. Wrap top vinyl edge over top rail into tape; wrap bottom edge over bottom rail into tape. Neatly fold corner tabs around 3-way elbow brackets.
7. *Greenhouse Snap Clamp Installation:* Install 1-1/4 in. greenhouse snap clamps directly over wrapped vinyl at every tape location (14 total: 4 on each upright, 3 on each cross rail). Confirm clamps seat firmly and do not interfere with base mounting brackets or elbow clamp bolts.
8. *Final Tension Inspection & Frame Re-Mounting:* Carefully lift the completed backdrop frame upright. Inspect the front vinyl face: verify drum-tight, wrinkle-free graphic presentation. Re-secure upright posts into cart base tension bands and re-pin diagonal support struts.

#v(4pt)
#align(center)[
  #figure(
    image("assets/approved/figure_06_vinyl_installation.jpg", width: 75%),
    caption: [*Figure 6.* Installation team applying carpet tape and securing vinyl banner with pipe snap clamps.]
  )
]

#pagebreak()

=== 2.9.3 Cutting Engineered Semicircular Wind Relief Flaps

To prevent destructive vortex flutter, reduce peak dynamic overturning impulses during stadium wind gusts, and eliminate lateral sliding across crumb-rubber turf, cut engineered semicircular wind relief flaps into the custom vinyl banner:

#callout(
  title: "Aerodynamic & Mechanical Function of Semicircular Relief Flaps",
  [
    - *Steady-State Drag Reduction:* Drops drag coefficient from $C_d = 1.20 -> 1.02$ (15.0% reduction in lateral drag force and overturning moment).
    - *Turf Sliding & Stability:* Raises synthetic turf sliding threshold and matches rear-rail overturning resistance to 22.5 mph at Colorado Springs elevation (6,500 ft ASL).
    - *Vortex Flutter Suppression:* Destroys coherent Strouhal vortex shedding (~0.8–1.2 Hz), preventing negative billow suction (>3.0 psf) that pries greenhouse snap clamps off conduit.
    - *Tear Resistance:* Pre-punched 3/8-in. (10 mm) circular holes eliminate sharp stress risers ($K_t -> 1.0$).
  ]
)

==== Semicircular Geometry Standard ($R = 4.0$ in.)
Each flap is a true semicircle ($180^degree$ circular arc) measuring *8.0 in. horizontal top chord × 4.0 in. downward drop* (Radius $R = 4.0$ in.). Vent area is 25.13 sq in. per flap. Semicircular geometry provides superior thermal beam stiffness over elongated ovals, preventing tip curling and sagging in $130^degree F+$ crumb-rubber heat while sharing 100% tooling commonality with the PCHSMB Sideline Screen fleet.

==== 8-Flap Fleet Primary Standard Coordinate Schedule ($2 times 4$ Grid)
The primary standard deploys 8 semicircular flaps, providing *1.40 sq ft (201 sq in.) total vent area* (1.75% of display face). Venting is concentrated in the upper zone ($Y = 72.0$ to $96.0$ in.) where overturning moment leverage is greatest ($M = F times y$), maintaining 12 in. frame clearance from perimeter tubing:

#table(
  columns: (0.9fr, 1.2fr, 1fr, 1.1fr, 1.8fr, 1.2fr),
  align: (center + horizon, left + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 4pt, y: 2.2pt),
  [*Flap ID*], [*Grid Row*], [*Height (Y)*], [*Center (X)*], [*Punched Endpoints (X)*], [*Apex Clearance*],
  [Flap F-1], [Row 1 (Upper)], [96.0 in.], [19.2 in.], [15.2 in. and 23.2 in.], [92.0 in. to turf],
  [Flap F-2], [Row 1 (Upper)], [96.0 in.], [38.4 in.], [34.4 in. and 42.4 in.], [92.0 in. to turf],
  [Flap F-3], [Row 1 (Upper)], [96.0 in.], [57.6 in.], [53.6 in. and 61.6 in.], [92.0 in. to turf],
  [Flap F-4], [Row 1 (Upper)], [96.0 in.], [76.8 in.], [72.8 in. and 80.8 in.], [92.0 in. to turf],
  [Flap F-5], [Row 2 (Mid-Upper)], [72.0 in.], [19.2 in.], [15.2 in. and 23.2 in.], [68.0 in. to turf],
  [Flap F-6], [Row 2 (Mid-Upper)], [72.0 in.], [38.4 in.], [34.4 in. and 42.4 in.], [68.0 in. to turf],
  [Flap F-7], [Row 2 (Mid-Upper)], [72.0 in.], [57.6 in.], [53.6 in. and 61.6 in.], [68.0 in. to turf],
  [Flap F-8], [Row 2 (Mid-Upper)], [72.0 in.], [76.8 in.], [72.8 in. and 80.8 in.], [68.0 in. to turf],
)

#v(2pt)

==== Approved Minimal Variant Coordinate Schedule ($2 times 3$ Grid — 6 Flaps)
For banners with prominent central artwork, the approved 6-flap minimal variant provides *1.05 sq ft (151 sq in.) total vent area* (1.31% of face):

#table(
  columns: (0.9fr, 1.2fr, 1fr, 1.1fr, 1.8fr, 1.2fr),
  align: (center + horizon, left + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 4pt, y: 2.2pt),
  [*Flap ID*], [*Grid Row*], [*Height (Y)*], [*Center (X)*], [*Punched Endpoints (X)*], [*Apex Clearance*],
  [Flap M-1], [Row 1 (Upper)], [96.0 in.], [24.0 in.], [20.0 in. and 28.0 in.], [92.0 in. to turf],
  [Flap M-2], [Row 1 (Upper)], [96.0 in.], [48.0 in.], [44.0 in. and 52.0 in.], [92.0 in. to turf],
  [Flap M-3], [Row 1 (Upper)], [96.0 in.], [72.0 in.], [68.0 in. and 76.0 in.], [92.0 in. to turf],
  [Flap M-4], [Row 2 (Mid-Upper)], [72.0 in.], [24.0 in.], [20.0 in. and 28.0 in.], [68.0 in. to turf],
  [Flap M-5], [Row 2 (Mid-Upper)], [72.0 in.], [48.0 in.], [44.0 in. and 52.0 in.], [68.0 in. to turf],
  [Flap M-6], [Row 2 (Mid-Upper)], [72.0 in.], [72.0 in.], [68.0 in. and 76.0 in.], [68.0 in. to turf],
)

==== Artwork Protection & The "Floating Flap" Adjustment Rule
- *1-Arcminute Acuity Resolution:* Razor kerf (< 0.01 in.) is 30x smaller than human eye resolution at 30 yards (0.31 in.). Flaps hang 100% flush by gravity and are completely invisible from spectator stands.
- *Floating Allowance:* Centerlines may float horizontally by $plus.minus 6$ to $12$ in. along their row to position flaps into solid backgrounds, dark textures, skies, or negative space.
- *Mandatory NO-CUT Zones:* Flaps must clear student performer faces by $>= 6.0$ in. Never cut across show title typography, movement titles, or Pine Creek school / sponsor crests.

==== Step-by-Step Punch-First Fabrication Procedure
1. *Tooling Checklist:* Obtain a 3/8-in. (10 mm) rotary leather punch, dense end-grain hardwood backing block, PCHSMB Field Prop Circle Cutter with fresh #11 hobby scalpel blade (Index [18]), and soft marking pencil.
2. *Marking & Graphic Inspection:* Measure and mark top horizontal chord centerlines and endpoint punch marks (8.0 in. apart). Verify compliance with Floating Flap artwork rules.
3. *MANDATORY PUNCH FIRST:* Slide hardwood block behind vinyl directly beneath punch mark. Align 3/8-in. rotary punch over mark and strike firmly with mallet. Repeat for opposing hole (8.0 in. apart). Clean circular holes eliminate stress risers ($K_t -> 1.0$). #alert[CRITICAL MANDATE: NEVER SLICE WITH RAZOR BEFORE PUNCHING HOLES.]
4. *Scribe & Slice Semicircular Arc:* Insert center pivot pin of PCHSMB Circle Cutter at midpoint between punched holes (or position R = 4.0 in. template). Perform a smooth, single-pass cut tangent to the bottom edge of both punched holes down through the 4.0-in. apex.
5. *LEAVE TOP CHORD UNCUT:* #alert[The top 8.0-in. horizontal chord between holes must remain uncut.] This uncut vinyl serves as the permanent gravity hinge.
6. *Flap Inspection:* Verify flap hangs 100% flush under gravity and swings open freely when pushed from behind.
7. *Backlight Pinprick Baffle (Optional):* In west-facing venues (low afternoon sun), apply a 1.5 in. × 1.5 in. square of black Gorilla tape behind each punch hole with a horizontal slit along lower edge to eliminate solar pinpricks.

#pagebreak()

=== 2.9.4 Seasonal Vinyl Removal & Teardown Protocol

#warning-box(title: "CRITICAL TEMPERATURE REQUIREMENT FOR VINYL REMOVAL")[
  Do not attempt removal of the vinyl or adhesive tape unless the ambient temperature is above 80°F (27°C). Attempting to peel the vinyl at lower temperatures will cause the material to tear and permanently damage the custom banner face. In cooler weather, warm the shop or gently heat the taped perimeter with a heat gun on low before peeling.
]

When taking down backdrops or preparing frames for graphic replacement:
- *Recommended timing (Defer to Band Camp):* It is usually much easier to leave the vinyl on the frames over the winter and wait until summer band camp of the following season before attempting removal. Cold late-fall temperatures following competition season make adhesive stiff and brittle, drastically increasing tear risk.
- *Solar heating advantage:* The warmer it is outside, the better. Staging the backdrops outdoors in direct sunlight for just a few minutes prior to peeling warms the steel tubing and softens the tape adhesive, allowing the vinyl and tape to release cleanly and effortlessly with minimal pull resistance.
- *Remove greenhouse snap clamps:* Carefully pry off all 14 greenhouse snap clamps from the perimeter tubing.
- *Peel slowly at shallow angle:* Starting at one corner, slowly peel the vinyl wrap back at a shallow angle. Warm adhesive releases cleanly from the bare steel pipe without pulling the scrim or ink layer.
- *Tape stripping & cleanup:* Peel remaining tape strips from the steel pipe. Because the pipe was not aggressively degreased during initial assembly, tape strips will pull off cleanly with minimal adhesive residue.

== 2.10 Appendix B Index & Purchasing References

=== Purchase Sources

#block[
  #set text(size: 8.2pt)
  #set par(leading: 0.52em)

  [1] *1-5/8 in. Dia. x 10 ft Steel Fence Line Posts* — Home Depot   #link("https://www.homedepot.com/p/Everbilt-1-5-8-in-Dia-x-8-ft-16-Gauge-Galvanized-Steel-Chain-Link-Fence-Line-Post-328923DPTSEB/312373067")

  [2] *1-5/8 in. 3-Way Clamp Corner Elbow Brackets* — Amazon   #link("https://www.amazon.com/dp/B0CD7QT6L6")

  [3] *1-5/8 in. Galvanized Steel Tension Bands* — Home Depot   #link("https://www.homedepot.com/p/Everbilt-1-5-8-in-Galvanized-Steel-Chain-Link-Fence-Tension-Band-328521EB/312373099")

  [4] *Heavy-Duty Swivel Plate Casters* — Amazon   #link("https://www.amazon.com/dp/B0CPXFJCJL")

  [5] *GRK #9 x 2-1/2 in. Star Drive R4 Multi-Purpose Screws* — Home Depot   #link("https://www.homedepot.com/p/GRK-Fasteners-9-x-2-1-2-in-Star-Drive-Torx-Bugle-Head-R4-Multi-Purpose-Wood-Screw-300-Pack-100101/203533402")

  [6] *GRK #10 x 4 in. R4 Self-Countersinking Flat-Head Screws* — Home Depot   #link("https://www.homedepot.com/p/GRK-Fasteners-10-x-4-in-R4-Self-Countersinking-Flat-Head-Multi-Purpose-Screw-50-per-Pack-103141/203525231")

  [7] *Heavy-Duty Steel U-Bolts* — Amazon   #link("https://www.amazon.com/dp/B09L41JFMS")

  [8] *Greenhouse Snap Clamps (1-1/4 in.)* — Amazon   #link("https://www.amazon.com/dp/B0CDZP8YVF")

  [9] *HDX 14-Gallon Tough Storage Tote (Black/Yellow)* — Home Depot   #link("https://www.homedepot.com/p/HDX-14-Gal-Tough-Storage-Tote-in-Black-with-Yellow-Lid-999-14G-HDX/328027053")

  [13] *Abccanopy 15-lb Heavy-Duty Sandbags with Handle (4-Pack)* — Amazon   #link("https://www.amazon.com/dp/B0DFVVZDVK")

  [14] *Heavy-Duty Plastic Sandbag Liner Bags (Double-Bag Compliance)* — Amazon   #link("https://www.amazon.com/dp/B0BG3F5XVS")

  [15] *Sakrete 70-lb Traction Tube Sand* — Lowe's   #link("https://www.lowes.com/pd/Sakrete-0-07-cu-ft-70-lb-Traction-Sand/5015728687")

  [16] *3/4 in. Black Iron Floor Flange and 18 in. Threaded Pipe* — Home Depot   #link("https://www.homedepot.com/p/The-Plumber-s-Choice-3-4-in-Black-Malleable-Iron-Floor-Flange-5-Pack-FBNF034-5/308967916")

  [18] *PCHSMB Field Prop Circle Cutter (3D Printed Tooling)* — Custom ASA print with #11 blade   #link("https://github.com/ericrowe/music/tree/main/PCHSMB/Circle%20Cutter")
]

=== Digital Part Files & Governing Rules

#block[
  #set text(size: 8.2pt)
  #set par(leading: 0.52em)

  [10] *3D Printed Corner Bumper Brace — FreeCAD Model*   #link("https://github.com/ericrowe/music/blob/main/PCHSMB/_Backdrop/Hardware/Corner%20Brace.FCStd")

  [11] *3D Printed 1-5/8" Pipe Drill Alignment Jig — Slicer 3MF*   #link("https://github.com/ericrowe/music/blob/main/PCHSMB/_Backdrop/Hardware/Drill%20Alignment%20Jig.3mf")

  [12] *3D Printed Support Strut Bracket Marker — FreeCAD Model*   #link("https://github.com/ericrowe/music/blob/main/PCHSMB/_Backdrop/Hardware/Steel%20Support%20Strut%20Bracket%20Marker.FCStd")

  [17] *2026 Colorado Bandmasters Association (CBA) Marching Band Rulebook (PDF)*   #link("https://ebf5c7e8-3869-4325-bd98-ce10f57d7545.filesusr.com/ugd/83f67e_cb5fe6efdbdb4ce98f619580f694bc94.pdf")

  [18] *PCHSMB Field Prop Circle Cutter Generator & CAD Models*   #link("https://github.com/ericrowe/music/blob/main/PCHSMB/Circle%20Cutter/generate_circle_cutter.py")
]

#pagebreak()

// -----------------------------------------------------------------------------
// APPENDIX C: FIELD OPERATIONS PLACARD (EXACT ONE-PAGE BUDGET)
// -----------------------------------------------------------------------------

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

// 4" x 6" Card Placement Area Placeholder
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
      [Prop \#: #blank(45pt)],
      [Show Segment: #blank(65pt)],
      [Side: [ ] Side 1   [ ] Side 2],
    )
    #v(2pt)
    Field Drill Coordinate: #blank(280pt)     #v(2pt)
    Assigned Handlers (Min. 2; 3–4 on ramps/wind): 1) #blank(60pt)  2) #blank(60pt)  3) #blank(60pt)
  ]
]

#v(2pt)
#text(size: 8.5pt, weight: "bold", fill: rgb("#1a365d"))[1. Wind Velocity Limits & Standardized Ballasting Schedule]
#v(1pt)
#table(
  columns: (1.1fr, 1.3fr, 1.6fr, 0.9fr, 1.9fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if y == 5 { rgb("#fff5f5") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 4pt, y: 2.2pt),
  [*Tier / State*], [*Wind Velocity*], [*Ballast (15-lb Bags)*], [*Total Wt*], [*Operational Limits & Action*],
  [Tier 0: Calm], [0–8 mph (gusts #sym.lt.eq 10)], [0 bags (unballasted)], [153 lbs], [Safe to 8 mph (10 gust max). Upgrade to Tier 1 if >8 mph.],
  [Tier 1: Normal], [8–12 mph], [4x (2 per wing post; 60 lb)], [213 lbs], [Standard staging. 16.9 mph max gust. Zero turf compaction.],
  [Tier 2: Advisory], [12–18 mph], [6x (3 per wing post; 90 lb)], [243 lbs], [Attentive staging. 18.4 mph max gust. Deploy wheel chocks.],
  [Tier 3: High-Wind], [18–22 mph], [6 on wings + 3 on rear rail (135 lb)], [288 lbs], [22.5 mph max gust. Rear rail doubles leverage. Max turf load.],
  [*Tier 4: ABORT*], [*>20 sust. / >25 gust*], [—], [—], [*STRICT SAFETY NO-GO. Withdraw props or lay flat.*],
)

#v(2pt)
#text(size: 8.5pt, weight: "bold", fill: rgb("#1a365d"))[2. Critical On-Field Safety & Turf Protection Rules]
#block[
  #set par(leading: 0.55em)
  #set text(size: 7.5pt)
- *Non-Locking Casters & Ground Chocking:* Carts use non-locking swivel casters for rapid agility. In breezy conditions, place extra double-bagged 15-lb sandbags on turf firmly against wheels as chocks to eliminate roll drift during performance.
- *Hand Placement & Crew Pairing:* Always push from lower 2x4 framing; NEVER push or climb on upright pipes or struts. Min 2 handlers per cart; assign 3 to 4 handlers on steep grades (Falcon Stadium ramp) or in high winds.
- *Mandatory Double-Bagging (Rule 8.05):* All 15-lb sandbags must have intact plastic inner liners. Never bring single-layer bags onto turf. Carts must not exceed 300 lbs total (~75 lb/wheel) to prevent rubber infill rutting.
- *CBA Field Routing (Rule 8.05 & Timing):* Props enter and exit strictly via designated back sideline or rear end zone gates (above goal posts). NEVER cross or stage props in the front sideline end zone area below goal posts (marked with red 'X' on drill cards)—strictly prohibited to protect front ensemble, judge sightlines, and timing intervals.
- *High-Wind Emergency Abort:* If severe gusts strike on-field, handlers brace on the upwind 2x4 base. Authorized parent crew (with Rule 9.07 wristbands) will assist to lay props flat on turf if ordered by directors.
]

#v(2pt)
#text(size: 8.5pt, weight: "bold", fill: rgb("#1a365d"))[3. Rapid Field Assembly, Egress & Two-Shot Staging Checklist]
#block[
  #set par(leading: 0.55em)
  #set text(size: 7.5pt)
- *Unloading & Venue Staging:* 1) Unstrap carts & lower from short ends; 2) Retrieve 10'×8' frames from trailer cross beams; 3) Pull off protective tennis balls (stow in tote); 4) Rapidly bolt frame to cart using cordless power driver; 5) Mate 2-piece struts and lock quick-release retaining pins; 6) Stage required ballast & wheel chocks.
- *Egress, "Two-Shot" Staging & Teardown:* 1) Continuous egress through designated rear end zone exit up hill to trailer lot (NEVER de-ballast at stadium chute; avoid front end zone restricted area); 2) Between Prelims & Finals ("Two-Shot"), leave ballast on carts in trailer lot; if gusts pick up, pull strut pins to lay vinyl frames flat on carts; 3) Final teardown: remove sandbags over axles; 4) Pull strut pins (stow in tote); 5) Install tennis balls over upper strut ends; 6) Unbolt frame using power driver; 7) Frames onto cross beams; 8) Carts vertical on short ends strapped against front nose wall.
]

#pagebreak()

// -----------------------------------------------------------------------------
// APPENDIX C.1: FIELD PLACEMENT CARD TEMPLATE (EXACT ONE-PAGE BUDGET)
// -----------------------------------------------------------------------------

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

// Cutout Box for 4" x 6" Card
#align(center)[
  #rect(
    width: 88%,
    stroke: (paint: rgb("#2b6cb0"), thickness: 1.5pt, dash: "dashed"),
    radius: 4pt,
    fill: white,
    inset: (x: 8pt, y: 6pt)
  )[
    #text(size: 8pt, weight: "bold", fill: rgb("#1a365d"))[
      PCHS MARCHING BAND — BACKDROP FIELD DRILL CARD
    ]
    #v(2pt)
    #table(
      columns: (1.2fr, 1.5fr, 1.3fr),
      stroke: 0.4pt + rgb("#cbd5e0"),
      fill: rgb("#f7fafc"),
      inset: (x: 4pt, y: 2.5pt),
      [Prop \#: #blank(40pt)],
      [Segment: #blank(55pt)],
      [Side: [ ] Side 1   [ ] Side 2],
    )
    #v(1pt)
    #text(size: 7.5pt)[
      *Drill Coordinate:* #blank(240pt)       *Handlers (Min. 2; 3–4 on ramps/wind):* 1) #blank(50pt)  2) #blank(50pt)  3) #blank(50pt)
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
1. *Season Preparation & Card Fabrication:* Coordinate cards are prepared and printed ONCE PER SEASON with all static information at the top filled in (Prop \#, Show Segment, Field Coordinate, Show Side, and assigned student handlers). Cut out along the 6" × 4" dashed border, laminate in standard 4x6 heat-seal pouches, and affix into the Appendix C placard placeholder box using outdoor hook-and-loop (Velcro) coins or corner photo tabs.
2. *Competition Day Route Marking:* On the day of each competition, the ONLY update made to the card is drawing the specific field entrance route, coordinate placement, prop facing orientation, and exit trajectory arrows directly onto the laminated card using a wet-erase or dry-erase marker. Students are pre-trained on facing symbols.
3. *CBA Field Entrance & Exit Routing Rules:* Follow all CBA boundary and timing regulations. Enter and exit strictly through designated back sideline or rear end zone gates (above goal posts). NEVER cross, stage, or transit props in the front sideline end zone area below the goal posts (marked with a bold red 'X'). Maintain continuous egress uphill to the trailer staging lot without de-ballasting at the stadium chute.
4. *Two-Shot Staging Protocol:* During two-shot competitions (Prelims & Finals), leave sandbag ballast intact on the carts in the trailer lot between shows. If winds increase during the afternoon break, simply remove the quick-release pin from each diagonal strut to lay the vinyl frames flat on the carts, eliminating sail area while maintaining readiness.
]

#pagebreak()

// -----------------------------------------------------------------------------
// APPENDIX D: PARENT VOLUNTEER COMPETITION DAY GUIDE (EXACT ONE-PAGE BUDGET)
// -----------------------------------------------------------------------------

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
  columns: (1.3fr, 0.8fr, 1.3fr, 2.6fr),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 3.5pt, y: 1.8pt),
  [*Milestone / Station*], [*Time*], [*Location & Staging Point*], [*Volunteer Duties & Field Logistics*],
  [Trailer Arrival & Spotting], [#blank(26pt) AM/PM], [Equipment Trailer Lot], [Meet trailer, deploy ramps, unstrap cart bases from nose wall.],
  [Unload & Rapid Assembly], [#blank(26pt) AM/PM], [Trailer Staging Area], [Bolt frames using cordless power driver; mate struts & pins; stow tennis balls.],
  [Pit Warmup Area], [#blank(26pt) AM/PM], [Designated Warmup Zone], [Assist front ensemble movement; inspect double-bagged sandbags & chocks.],
  [Prop Staging Gate (Pre-Stage)], [#blank(26pt) AM/PM], [Back Sideline / Rear Gate], [Pre-stage in rear half of end zone above goal post (Rule 5.03); don wristbands.],
  [Prelims Field Performance], [#blank(26pt) AM/PM], [Performance Field], [Await T&P judge permission; set props; CLEAR FIELD BEFORE ANNOUNCEMENT ENDS!],
  [Prelims Catch & Uphill Egress], [#blank(26pt) AM/PM], [Field Exit / Stadium Chute], [Continuous egress up hill to trailer lot (Rule 8.05); DO NOT de-ballast at chute!],
  [Inter-Show Staging ("Two-Shot")], [#blank(26pt) AM/PM], [Trailer Staging Area], [Leave ballast on carts in lot; if gusts pick up, pull strut pins to lay frames flat.],
  [Finals Gate & Performance], [#blank(26pt) AM/PM], [Rear Gate / Perf. Field], [Don Finals wristbands (new color); await T&P judge; set props; clear field.],
  [Finals Catch & Teardown], [#blank(26pt) AM/PM], [Trailer Staging Lot], [Uphill egress to truck; de-ballast; unbolt frames; tennis balls on struts; load trailer.],
  [Extra 1: #blank(45pt)], [#blank(26pt) AM/PM], [#blank(65pt)], [#blank(130pt)],
  [Extra 2: #blank(45pt)], [#blank(26pt) AM/PM], [#blank(65pt)], [#blank(130pt)],
  [Extra 3: #blank(45pt)], [#blank(26pt) AM/PM], [#blank(65pt)], [#blank(130pt)],
  [Extra 4: #blank(45pt)], [#blank(26pt) AM/PM], [#blank(65pt)], [#blank(130pt)],
)

#v(2pt)
#text(size: 8.5pt, weight: "bold", fill: rgb("#1a365d"))[2. 2026 CBA Marching Band Rules Governing Adult On-Field Behavior]
#block[
  #set par(leading: 0.52em)
  #set text(size: 7.2pt)
- *Mandatory Field Pass Wristbands (Rule 9.07):* Access to the performance field for parents assisting with props or front ensemble is strictly restricted to designated Field Pass wristbands (max 25 per band). Wristbands permit access ONLY to the Performance Field (not to spectator stands). Prelims and Finals use distinct wristband colors; Finals wristbands are in the director packet after Prelims awards.
- *Field Entry Permission & Pre-Staging (Rule 5.06 & Rule 5.03):* NEVER enter performance field before Timing & Penalties (T&P) judge gives official permission. Props may pre-stage in rear half of end zone (from middle of goal post to far sideline) up to the goal line prior to permission (Rule 5.03). Exiting bands maintain absolute right-of-way through front half of end zone.
- *Field Clearance Before Performance (Rule 4.03 & Rule 5.06):* All adult volunteers assisting with props MUST BE COMPLETELY CLEAR of the performance field before the introductory announcement ends (commences 3:15 after entry permission). Any adult still on field when announcement ends incurs an immediate *0.2 point score penalty* for the band.
- *Re-Entry Prohibition During Performance (Rule 4.03):* Adults are strictly prohibited from entering or re-entering the performance field during the show. Unauthorized entry incurs an immediate *0.2 point penalty per occurrence* (up to 0.4 max). Adults remain in exterior perimeter staging areas until all performed sound has ceased.
- *Medical Emergency Assistance Exception (Rule 4.02(c)):* *NO PENALTY.* Any band member becoming ill or injured during performance may be assisted from the field by an adult volunteer, parent, staff member, EMT, or CBA official without penalty. Performer health and safety always supersede boundary rules.
- *High-Wind Prop Safety Restraint Exception (Rule 4.02(a)):* If high winds threaten props falling over, adults may enter the field for the sole purpose of securing the prop. At no time during the performance may an adult move the prop as part of visual choreography.
- *Continuous Uphill Egress & Double-Bagging (Rule 8.05):* Continuous movement required off field until removed from stadium. NEVER stop or de-ballast carts at exit chute—maintain momentum up incline to trailer staging lot with 3–4 handlers per cart. All sandbags must have intact plastic inner liners.
]

#v(2pt)
#text(size: 8.5pt, weight: "bold", fill: rgb("#1a365d"))[3. Essential Volunteer Handling & Safety Checkpoints]
#block[
  #set par(leading: 0.52em)
  #set text(size: 7.2pt)
- *Low Base Pushing:* Push strictly from lower 2x4 wooden cart framing. NEVER push, pull, or climb on upright steel posts or diagonal struts to prevent bending tubing or distorting bracket alignment.
- *Steep Ramps & Wind Sizing:* Minimum 2 handlers per cart under normal conditions. On steep stadium inclines (specifically USAFA Falcon Stadium concrete tunnel entrance ramp) or in high winds, assign 3 to 4 handlers per cart to maintain controlled braking and uphill momentum.
- *Strut Tennis Balls & Power Driver:* Ensure slotted tennis balls are installed over upper strut ends whenever vinyl frames are detached. Use cordless power drivers with socket adapters for rapid frame unbolting and bolting during trailer packout.
]
