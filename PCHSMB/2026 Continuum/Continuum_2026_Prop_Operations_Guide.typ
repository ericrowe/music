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
        align(center)[*Release v0 (D1)* | September 2026],
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

#let nogo-box(body) = callout(
  title: [🛑 ABSOLUTE WIND NO-GO THRESHOLD (>20 MPH)],
  fill: rgb("#fff5f5"),
  stroke: rgb("#e53e3e"),
  body
)

#let rule-box(title: "CRITICAL CBA COMPETITION RULE", body) = callout(
  title: [⚠️ #title],
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
    Simplified Volunteer Handbook & Step-by-Step Competition Day Procedures
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
  *HARD RULE: If sustained winds exceed 20 mph OR gusts are forecasted/reported at 25–30 mph, PROPS DO NOT LEAVE THE TRUCK/TRAILER.*
  
  Last season confirmed that props in >20 mph winds create unacceptable safety risks for students and handlers. When this threshold is met, the Prop Lead makes an immediate *NO-GO* call. Props remain securely locked in the equipment trailer or behind stadium bleachers. *The band performs a clean visual show without props.* There is no middle ground, and no emergency lay-flat abort on the field is permitted—if high winds are even possible, props stay off the turf.
]

#v(2pt)

#table(
  columns: (1fr, 0.85fr, 1.25fr, 1.35fr, 0.95fr),
  align: (center + horizon, center + horizon, left + horizon, left + horizon, center + horizon),
  stroke: 0.5pt + rgb("#cbd5e0"),
  inset: (x: 3.5pt, y: 2.5pt),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 5 { rgb("#fff5f5") } else { none },
  [*Wind Regime*], [*Wind Velocity*], [*Duck Blind Ballasting*], [*Backdrop Ballasting*], [*Decision Status*],
  [⚪ *Tier 0: Calm*], [0 – 8 mph], [None], [None], [*GO* (Dry)],
  [🟢 *Tier 1: Normal*], [8 – 12 mph], [2 bags], [4 bags (2/wing post)], [*GO* (Normal)],
  [🟡 *Tier 2: Advisory*], [12 – 18 mph], [3 bags (2 ground + 1 hanging)], [6 bags (3/wing post)], [*GO* (With Ballast)],
  [🟠 *Tier 3: High-Wind*], [18 – 22 mph], [4 bags (2 ground + 2 hanging)], [9 bags (6 wing + 3 rear rail)], [*CAUTION* (Max Limit)],
  [🔴 *Tier 4: Abort*], [*> 20 mph sust.* \ or *> 25 mph gusts*], table.cell(colspan: 2)[*ABSOLUTE NO-GO.* Props remain in trailer / truck. Field props will not be fielded. Prop Lead notifies Directors.], [*NO-GO* (Hold in Truck)],
)

#v(3pt)
#callout(title: "Why There Is No Emergency Lay-Flat Plan in This Handout")[
  Previous operational drafts included field procedures for laying props flat on the turf during sudden gusts. For Adult Volunteer safety and competition clarity, *that procedure has been retired.* If 25–30 mph gusts are even remotely possible, the props will never be staged or moved onto the field.
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
  [Staging Area Location], [ Location / Area: ], [ \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ ],
  [Prop Staging Time], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Staged once; props return here between Prelims & Finals ],
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

The Colorado Bandmasters Association (CBA) strictly enforces prop and adult volunteer regulations. *Penalties directly deduct points from the students' score.* Adhere strictly to the following:

#grid(
  columns: (1fr, 1fr),
  gutter: 7pt,
  rule-box(title: "Rule 9.07 — Field Passes")[
    *Maximum 25 wristbands per band.* Every Adult Volunteer stepping past the gate must wear the official CBA wristband on their wrist (not in pocket or on badge). Prelims and Finals use different colors.
  ],
  rule-box(title: "Rule 5.02 — Rear Entrance Mandate")[
    *Props must enter from the back sideline or rear end zone.* Never wheel props across the front boundary line (reserved strictly for pit/percussion equipment). Handlers transit perimeter tracks.
  ],
  rule-box(title: "Rule 4.03 & 5.06 — 3:15 Setup Window")[
    The introductory announcement begins 3 minutes 15 seconds after judge's entry signal. *ALL adults must be completely clear of the field before the announcement ends.* Target all Adult Volunteers off turf by *2:45*.
  ],
  rule-box(title: "Rule 4.03 — In-Show Turf Prohibition")[
    *Adult Volunteers are strictly forbidden from touching the field during the performance.* 0.2-point penalty per occurrence. Once you exit, remain behind the front sideline or rear perimeter track.
  ],
  rule-box(title: "Rule 8.05 — 2:00 Egress Clock")[
    Timing clock begins on final chord. All equipment and personnel must clear field boundaries within 2 minutes. Once past the gate/tunnel threshold, carts pause in the exit chute to load the duck blinds.
  ],
  rule-box(title: "Rule 8.05 — Double-Bagged Sandbags")[
    All ballast sandbags must be heavy-duty and double-bagged with intact plastic inner liners. Leaking sand on synthetic turf results in severe facility fines and competition penalties.
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
  [*Duck Blinds* \ (Sideline Screens)], [16 screens (8 per side)], [2 Rolling Carts \ (8 screens/cart)], [Front Sideline \ (Side 1: 20–41 yd; Side 2: 59–80 yd)], [2 Adult Volunteers (Pushers), 2 Student Unloaders, 16 Student Receivers],
  [*Rolling Backdrops*], [10 backdrops], [10 Rolling Carts \ (1 cart/prop)], [Backfield / Back Hash \ (Spanned across 30–70 yds)], [2 Adult Volunteers (Managers), 20–40 Student Pushers (2–4 per backdrop)],
  [*Performance Stages & Stairs*], [4 stages (8 pieces) \ + 4 staircases], [8 Half-Platforms & \ 4 Mobile Staircases], [Midfield / Side Stages \ (Exact drill marks per show)], [2 Adult Volunteers (Stage Managers), 16 Student Stage Handlers, 8 Student Staircase Handlers],
)

#v(6pt)

// -------------------------------------------------------------------------
// SECTION 5: STEP-BY-STEP JOB DESCRIPTIONS
// -------------------------------------------------------------------------

= 5. Individual Job Descriptions & Step-by-Step Instructions

*Find your assigned job card on the following pages. Each job is formatted as an independent, single-page operations sheet that can be printed and carried during competition day.*

The field prop operation is organized into four primary divisions:

1. *Job Group A: Duck Blind Operations (Pages 4–7):* Divided into four specialized single-page job blocks covering cart pushing, rapid cart offloading, on-field concurrent deployment, and post-show egress.
2. *Job Group B: Rolling Backdrop Operations (Pages 8–10):* Divided into three specialized single-page job blocks covering adult backdrop managers (B.1), on-field student pushers (B.2), and off-field student pushers (B.3).
3. *Job Group C: Performance Stage Crew (Pages 11–13):* Divided into three specialized single-page job blocks covering Adult Stage Managers (C.1, Page 11), Student Stage Handlers (C.2, Page 12), and Student Staircase Handlers (C.3, Page 13).
4. *Job Group D: Prop Lead & Field Safety Coordinator (Page 14):* Master oversight, weather telemetry monitoring, judge liaison, and timing control.

Follow all instructions in strict sequential order. Adhere to all safety warnings and CBA competition boundaries.

#pagebreak()

// =========================================================================
// PAGE 4: JOB A.1 — ADULT DUCK BLIND CART PUSHER
// =========================================================================

== Job Group A: Duck Blind Crew (16 Sideline Screens on 2 Dedicated Carts)

#job-card(
  role: "Job A.1: Adult Duck Blind Cart Pusher",
  personnel: "2 Adult Volunteers (1 per Cart: Side 1 or Side 2)",
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    You will be in charge of one of two carts for transporting the duck blinds to and from the field. You will be in charge of ensuring it is loaded properly with 8 duck blinds and the correct amount of ballast, ensuring that it gets to the field on time, and removing the ballast from the field after the show. You will have student helpers to assist on field.
  ]

  #v(2pt)
  #grid(
    columns: (1.15fr, 1.4fr),
    gutter: 6pt,
    rect(
      width: 100%,
      fill: rgb("#ffffff"),
      stroke: 0.8pt + rgb("#cbd5e0"),
      radius: 3pt,
      inset: (x: 6pt, y: 4pt)
    )[
      #text(weight: "bold", size: 8pt, fill: rgb("#2b6cb0"))[DAY-OF CART ASSIGNMENT:] \
      #v(3pt)
      #grid(
        columns: (1fr, 1.25fr),
        gutter: 4pt,
        [
          *Side:* \
          #v(2pt)
          #box(stroke: 0.5pt + rgb("#a0aec0"), inset: (x: 2.5pt, y: 1pt), radius: 2pt)[#h(3pt)] Side 1 (Right)#footnote[Side 1 is on the right when standing on the backfield and facing the front stands.] \
          #v(2pt)
          #box(stroke: 0.5pt + rgb("#a0aec0"), inset: (x: 2.5pt, y: 1pt), radius: 2pt)[#h(3pt)] Side 2 (Left)
        ],
        [
          *Staging Location:* \
          #v(2pt)
          Back \_\_\_\_\_ Yard Line
        ]
      )
    ],
    rect(
      width: 100%,
      fill: rgb("#ffffff"),
      stroke: 0.8pt + rgb("#cbd5e0"),
      radius: 3pt,
      inset: (x: 3pt, y: 3pt)
    )[
      #text(weight: "bold", size: 8pt, fill: rgb("#2b6cb0"))[DUCK BLIND BALLAST SCHEDULE:] \
      #v(1pt)
      #table(
        columns: (0.45fr, 0.85fr, 1.5fr, 0.95fr),
        align: center + horizon,
        stroke: 0.3pt + rgb("#cbd5e0"),
        inset: (x: 2pt, y: 1.5pt),
        fill: (col, row) => if row == 0 or row == 1 { rgb("#edf2f7") } else if row == 6 { rgb("#fff5f5") } else { none },
        table.cell(colspan: 2)[#text(size: 7pt, weight: "bold")[Wind Regime]],
        table.cell(rowspan: 2)[#text(size: 7pt, weight: "bold")[Per Blind (15-lb Bags)]],
        table.cell(rowspan: 2)[#text(size: 7pt, weight: "bold")[Per Cart]],
        [#text(size: 6.5pt, weight: "bold")[Tier]],
        [#text(size: 6.5pt, weight: "bold")[MPH]],
        [#text(size: 6.5pt)[0]], [#text(size: 6.5pt)[0–8]], [#text(size: 6.5pt)[0 bags (dry frame)]], [#text(size: 6.5pt)[0 bags]],
        [#text(size: 6.5pt)[1]], [#text(size: 6.5pt)[8–12]], [#text(size: 6.5pt)[1–2 on ground (15–30 lb)]], [#text(size: 6.5pt)[8–16 bags]],
        [#text(size: 6.5pt)[2]], [#text(size: 6.5pt)[12–18]], [#text(size: 6.5pt)[2 ground + 1 hang (45 lb)]], [#text(size: 6.5pt)[24 bags]],
        [#text(size: 6.5pt)[3]], [#text(size: 6.5pt)[18–22]], [#text(size: 6.5pt)[2 ground + 2 hang (60 lb)]], [#text(size: 6.5pt)[32 bags]],
        [#text(size: 6.5pt, weight: "bold", fill: rgb("#c53030"))[4]],
        [#text(size: 6.5pt, weight: "bold", fill: rgb("#c53030"))[>20]],
        [#text(size: 6.5pt, weight: "bold", fill: rgb("#c53030"))[NO-GO (Hold in Trailer)]],
        [#text(size: 6.5pt, weight: "bold", fill: rgb("#c53030"))[In Trailer]],
      )
    ]
  )

  #v(2pt)
  #text(size: 8pt, weight: "bold", fill: rgb("#1a365d"))[Complete Event Lifecycle (Truck $->$ Staging $->$ Field $->$ Standby $->$ Exit Chute $->$ Staging/Truck):]

  + *Arrival, Unload & Assembly:* Meet at the equipment trailer at the volunteer crew call time. Assist with unloading the props and pit equipment from the trucks and trailers. Assist with assembly of the props. Note: duck blinds are fully assembled, but the backdrops and stages both require multiple people to perform the assembly work.
  + *Move to Staging Area:* Move props and carts to the designated staging area at the designated staging time.
  + *Pre-Show Inspection:* Meet at the Staging Area 45 minutes prior to show time. Conduct a visual inspection of the cart, screen racks, and latches. Confirm sandbag quantity in the hopper matches the Ballast Schedule above (e.g., 8–16 bags for Tier 1; 24 bags for Tier 2; 32 bags for Tier 3). Push cart to the ready area as directed by the Prop Lead. Meet your assigned Student Unloader who will join you following their warm-ups.
  + *Field Staging A:* When directed by the on-field judge, enter the gates and stage at the prescribed location.
  + *Field Staging B:* When directed by the on-field judge, move to the defined yard line along the back sideline. *DO NOT CROSS THE SIDELINE MARKERS.* Doing so will immediately invoke an official penalty.
  + *Field Ingress & Directional Delivery:* When the CBA judge signals entry permission, push the cart forward toward the front sideline with your Student Unloader. When you reach the front sideline, turn and walk along the front sideline, pausing 6–8 seconds at each 2-yard mark while the unloader deposits one folded screen and sandbags to the pre-set student receiver.
  + *In-Show Standby at Sideline Boundary:* Once the 8th screen is delivered, immediately push the empty cart across the front boundary into the front staging area. *You must be completely off the turf before the 2:15 mark.* Park the cart ready for post-show egress. *Stay with your cart at the boundary for the entire performance.* Never step onto the turf during the show (Rule 4.03 penalty).
  + *Post-Show Ballast Sweep:* Once the show is completed, re-enter the front sideline at the far screen and move along the line of ballast bags you previously deposited. Scoop ballast bags placed on the turf by students directly into the cart hopper as you advance without doubling back. A student will be assigned to assist you in getting this done timely.
  + *Exit Chute Cart Loading:* We will be pausing at the exit chute with the carts to load the blinds. *DO NOT STOP FOR ANY LONGER THAN NECESSARY TO QUICKLY LOAD THE BLINDS.*
  + *Return to Staging Area or Truck:* Return the carts to the staging area (between Prelims and Finals), or directly to the trailer/truck if after Finals.
  + *Final Performance Teardown & Loading:* At the end of the final performance, tear down all equipment and assist with loading the truck and trailer.
]

#pagebreak()

// =========================================================================
// PAGE 5: JOB A.2 — STUDENT DUCK BLIND CART UNLOADER
// =========================================================================

== Job Group A: Duck Blind Crew (Continued)

#job-card(
  role: "Job A.2: Student Duck Blind Cart Unloader",
  personnel: "2 Student Performers / Crew (1 per Cart: Side 1 or Side 2)",
  tag: "Cart Operations & Rapid Offloading"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    *Student Instructions:* You accompany the Adult Cart Pusher from the rear gate to the front sideline, rapidly offload the 8 screens and assigned ballast bags to your fellow student performers, and clear the turf to take your opening drill position.
  ]
  #v(4pt)

  + *Rear Gate Rendezvous:*
    - Meet your assigned Adult Cart Pusher at the rear stadium entrance gate as directed by your section leader.
    - Work with your section leader to get your instrument to your starting location on the field. The cart does not have instrument storage capabilities.
    - Confirm with the Adult Cart Pusher the number of ballast bags to unload with each duck blind. Note this value will change depending on the wind conditions that day.
  + *Perimeter Track Transit:*
    - Remain with the cart during entry and backfield staging as directed.
  + *Field Entrance:*
    - When given the go-ahead by the on-field judge, move quickly with the cart straight forward to the front sideline.
  + *Screen & Ballast Deposition (6-Second Drop Cadence):*
    - Once you reach the front sideline, walk along the sideline with the cart. As it rolls past each marked 2-yard line (screens 1 through 8):
      - Slide one folded screen off the cart rack.
      - Set the folded screen flat on the turf near the final location for that screen. Additional student helpers will be there to set the blind up.
      - Set the correct amount of ballast bags with each duck blind.
    - Maintain a crisp, rapid pace: complete each handoff within *6 seconds* so the cart maintains forward momentum without stalling.
      - Repeat down the entire 8-screen line.
  + *Field Clearance to Opening Show Drill Set:*
    - Once the 8th screen and final sandbags are deposited, briskly transition to your assigned opening performance location. You are now cleared for the show!
]

#pagebreak()

// =========================================================================
// PAGE 6: JOB A.3 — STUDENT SCREEN DEPLOYMENT & BALLASTING
// =========================================================================

== Job Group A: Duck Blind Crew (Continued)

#job-card(
  role: "Job A.3: Student Screen Deployment & Ballasting",
  personnel: "16 Student Performers (8 on Side 1, 8 on Side 2)",
  tag: "On-Field Screen Deployment & Rigidity"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    *Student Instructions:* You are responsible for receiving, unfolding, latching, and ballasting the 16 duck blind sideline screens. You will be assigned one or more duck blinds to be your responsibility.
  ]
  #v(4pt)

  + *Pre-Show Field Positioning:*
    - March onto the field with the band during entry and proceed to your assigned front sideline coordinate. Coordinate with your section leader for instrument placement while you perform your duties.
    - Stand at attention facing the backfield awaiting the arrival of your transport cart.
  + *Receiving Screen & Ballast:*
    - As your transport cart arrives at your mark:
      - Receive 1 folded screen and ballast bags from the Student Unloader. Note that the ballast bag quantity will change based on wind conditions.
      - Place the folded screen standing vertically, display face toward the front audience.
  + *Concurrent Unfolding & Lockup (15 Seconds):*
    - As soon as the screen is on the turf, all 8 performers on your side deploy simultaneously:
      - Swing the rear triangular support frame outward perpendicular to the front display panel.
      - Seat the snap clips (*I*) firmly into Rail 3 until fully engaged with an audible snap.
      - Adjust the position from center field outwards to ensure all blinds are aligned continuously into one front visual wall.
  + *Ballast Installation:*
    - Place the ballast provided onto the duck blind in this order:
      - Place up to 2 bags across the rear ground rail.
      - Place up to 2 bags hanging from the top rail using the attached clips.
  + *Rigidity Check & Show Posture:*
    - Give the frame a firm tap to confirm the snap clips and latches are fully seated and the screen is 100% rigid.
    - Step back into your opening visual set posture before the introductory announcement ends.
]

#pagebreak()

// =========================================================================
// PAGE 7: JOB A.4 — STUDENT SCREEN TEARDOWN, EGRESS & DEBALLASTING
// =========================================================================

== Job Group A: Duck Blind Crew (Continued)

#job-card(
  role: "Job A.4: Student Screen Teardown & Egress",
  personnel: "16 Student Performers (8 on Side 1, 8 on Side 2)",
  tag: "Post-Show Deballasting & Egress Sprint"
)[
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    *Student Instructions:* The 2-minute CBA egress clock starts the instant the final note of the show sounds. Disengage, collapse, and move your screens off the field quickly within the 2-minute egress window.
  ]
  #v(4pt)

  + *Immediate Teardown on Final Show Chord:*
    - After the show as directed by your section leader:
      - *Safe Ballast Placement:* Lift all sandbags off the rear ground rail and unclip any hanging bags; place them gently onto the synthetic turf next to the rail.  
        #text(weight: "bold", fill: rgb("#c53030"))[CRITICAL SAFETY MANDATE: NEVER THROW OR DROP SANDBAGS.] Dropping sandbags causes severe seam rupture and leaks sand, resulting in CBA score penalties. Place bags gently on the turf. Leave them in place for the Adult Cart Pusher to scoop during their sweep.
      - *Disengage Latches & Clips:* Disengage inter-screen side latches. Disengage snap clips (*I*) from Rail 3. Swing the cross arms up into alignment with the rear brace.
      - *Collapse Screen:* Swing the rear triangular brace flat against the front display frame.
  + *The 35-Second Egress Sprint:*
    - Move quickly, hand-carrying the collapsed screens across the front sideline boundary and toward the designated stadium exit gate chute.
  + *Replace on Cart:*
    - Exit the field to the pre-coordinated area to meet the cart rack.
    - Replace screens in the transport cart racks (8 screens per cart).
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
      columns: (0.85fr, 0.95fr, 1.8fr, 1.4fr),
      align: center + horizon,
      stroke: 0.3pt + rgb("#cbd5e0"),
      inset: (x: 4pt, y: 2pt),
      fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 5 { rgb("#fff5f5") } else { none },
      [*Tier*], [*Wind MPH*], [*15-lb Sandbags (Wing Iron Posts)*], [*Supplemental Rail Ballast*],
      [Tier 0], [0 – 8], [0 bags (unballasted, 153 lb dry prop)], [None],
      [Tier 1], [8 – 12], [4 bags (2 per wing post, 60 lb ballast)], [None],
      [Tier 2], [12 – 18], [6 bags (3 per wing post, 90 lb ballast)], [None],
      [Tier 3], [18 – 22], [6 bags (3 per wing post, 90 lb ballast)], [3 bags flat across rear 2x4 rail (45 lb)],
      table.cell(colspan: 2)[#text(weight: "bold", fill: rgb("#c53030"))[Tier 4 (>20 mph)]],
      table.cell(colspan: 2)[#text(weight: "bold", fill: rgb("#c53030"))[ABSOLUTE NO-GO — Keep Locked in Equipment Trailer]],
    )
  ]

  #v(2pt)
  #text(size: 8pt, weight: "bold", fill: rgb("#1a365d"))[Step-by-Step Manager Lifecycle:]

  + *Arrival & Assembly Supervision:* Meet at the equipment trailer at the Adult Volunteer call time. Supervise and direct the mechanical assembly of the 10 rolling backdrop carts (installing steel upright posts, diagonal struts, retaining pins, and vinyl banners with snap clamps). Direct help from other prop and pit crew members who may not have done this assembly before. Verify all strut pins and safety cotters are fully engaged.
  + *Ballast Installation & Pre-Staging Inspection:* Confirm the day's wind tier with the Prop Lead. Seat double-bagged 15-lb sandbags securely over the two vertical iron pipe posts on each cart per the table above (4 bags for Tier 1; 6 bags for Tier 2; 6 wing + 3 rear rail bags for Tier 3). Inspect swivel casters and confirm caster foot brakes are in the unlocked (UP) position for transit.
  + *Transport to Staging Area:* Lead the transport of all 10 ballasted backdrops from the trailer lot to the designated staging area at the designated staging time. Park carts in numerical order (#1 through #10) and engage wheel brakes.
  + *Student Rendezvous & Supervision at Staging Area:* Meet the assigned Student Backdrop Pushers (2–4 students per backdrop) at the staging area 45 minutes prior to show time. Confirm each student team knows their backdrop number, entry queue sequence, and field position. Supervise and assist the students as they prepare for gate movement.
  + *Adult Field Boundary Rule:* Adults do not push backdrops onto the field. Move with the students onto the field during setup to assist any that need help and check field placement, and then quickly move off the field to the adult volunteer waiting area in front of the front sideline. *Never step onto the turf during the show (Rule 4.03 penalty).*
  + *Post-Show Reception & Return to Trailer:* Meet the student pushers as they return with the backdrops to the staging area following their end zone egress. Take custody of the backdrops from the students so they can rejoin the band block. Push the backdrops back to the staging area (between Prelims and Finals) or to the equipment trailer (after Finals).
  + *Post-Finals Disassembly Supervision:* Direct the safe deballasting (never drop or throw) and mechanical disassembly of frames for secure trailer packing.
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
    - Coordinate with your section leader regarding instrument placement while performing your prop duties (the backdrop carts do not have large instrument storage).
    - Note that the backdrops have one set of fixed wheels that do not rotate, and one set that do rotate for steering.  It is typically recommended for stability to push from the side with the rotating steering wheels, however you must plan ahead for turns.
  + *Perimeter Transit to Back Sideline:*
    - When directed by the Adult Managers / Prop Lead, take custody of your backdrop and roll it along the designated perimeter track toward the rear stadium entrance gate.
    - Queue in strict numerical order (#1 at front, #10 at rear).
    - Always push using the steel frame uprights. *NEVER push directly against the vinyl display face.*
  + *Back Sideline Staging:*
    - Move through the rear gate and stage along the back sideline directly in line with your final field coordinate.
    - *CRITICAL BOUNDARY RULE: DO NOT CROSS THE BACK SIDELINE MARKERS.* Keep cart wheels completely behind the sideline until the on-field judge gives official entry permission. Doing so will immediately invoke a CBA penalty.
  + *Field Ingress & Positioning:*
    - When the CBA judge signals entry permission, push your backdrop briskly straight forward onto the field toward your marked coordinate.
    - Steer smoothly; avoid sharp pivots that could scrub or tear synthetic turf infill.
    - Align the front edge of the wood base cart precisely with the yard line and hash mark specified on your coordinate sheet.
  + *Orientation, Rotation & Securing:*
    - Rotate the backdrop display face to the exact angle and orientation instructed during rehearsal training.
    - Confirm all sandbags remain securely seated over the iron posts.
    - If directed by the Adult Backdrop Managers, place additional sandbags across the rear frame and/or use sandbags to chock the wheels in place.
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
    - Maintain brisk, continuous forward momentum. *NEVER stop on the turf to adjust equipment, rest, or talk.*
    - Push strictly by the steel uprights; *never push against the vinyl graphic face*.
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
  #text(size: 8.5pt, style: "italic", fill: rgb("#2b6cb0"))[
    You are one of two Adult Volunteers in charge of the 4 performance stage platforms (8 total mobile stage pieces) and 4 mobile staircases. You supervise and direct mechanical assembly, vinyl installation, labeled lineup order, staging/destaging logistics, and student oversight for both the 16 Stage Handlers and 8 Staircase Handlers.
  ]

  #v(2pt)
  #rect(
    width: 100%,
    fill: rgb("#ffffff"),
    stroke: 0.8pt + rgb("#cbd5e0"),
    radius: 3pt,
    inset: (x: 5pt, y: 3pt)
  )[
    #text(weight: "bold", size: 8pt, fill: rgb("#2b6cb0"))[STAGE PLATFORM & STAIRCASE FLEET CONFIGURATION:] \
    #v(1pt)
    #table(
      columns: (0.9fr, 1.25fr, 1fr, 1.6fr),
      align: center + horizon,
      stroke: 0.3pt + rgb("#cbd5e0"),
      inset: (x: 4pt, y: 2pt),
      fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
      [*Platform*], [*Stage Pieces*], [*Assigned Stairs*], [*Lineup Order & Configuration*],
      [Platform \#1], [2 Pieces (Front + Back)], [Staircase \#1], [\#1F $->$ \#1B $->$ Stairs \#1 (vinyl pinned)],
      [Platform \#2], [2 Pieces (Front + Back)], [Staircase \#2], [\#2F $->$ \#2B $->$ Stairs \#2 (vinyl pinned)],
      [Platform \#3], [2 Pieces (Front + Back)], [Staircase \#3], [\#3F $->$ \#3B $->$ Stairs \#3 (vinyl pinned)],
      [Platform \#4], [2 Pieces (Front + Back)], [Staircase \#4], [\#4F $->$ \#4B $->$ Stairs \#4 (vinyl pinned)],
    )
  ]

  #v(2pt)
  #text(size: 8pt, weight: "bold", fill: rgb("#1a365d"))[Step-by-Step Manager Lifecycle:]

  + *Arrival & Frame Assembly Supervision:* Meet at the equipment trailer at the Adult Volunteer call time. Supervise and direct the mechanical assembly of the 8 mobile stage pieces and 4 staircases per their manuals. Direct help from prop and pit crew members who may not have done this assembly before. Verify all locking hardware, structural pins, and caster mounts are securely seated.
  + *Vinyl Covering Installation:* Install the designated vinyl coverings and skirt graphics onto each assembled stage piece. Ensure that the bridging seam flap on each front piece is folded and pinned back securely for transport so it will not drag or catch on turf during movement.
  + *Label Verification & Lineup Order:* Verify that every stage piece and staircase is clearly labeled for its field position (Platform \#1–\#4, Front "F" vs Back "B", Staircase \#1–\#4). *Lineup order is critical:* organize pieces in strict entry sequence with front pieces leading, back pieces following, and assigned staircases queued directly behind.
  + *Transport to Staging Area:* Lead the transport of all 8 stage pieces and 4 staircases (rolled on their sides on dedicated casters) from the trailer lot to the designated staging area at the designated staging time. Park pieces in lineup order and engage wheel brakes.
  + *Student Handler Rendezvous & Supervision:* Meet the 16 Student Stage Handlers and 8 Student Staircase Handlers at the staging area 45 minutes prior to show time. Confirm each student team knows their assigned label, lineup position, and field coordinate. Supervise and assist the students as they prepare for gate movement.
  + *On-Field Setup & Boundary Rule:* Adults do not push props onto the field (students push). Move with the students onto the field during setup to assist any that need help, verify piece alignment, ensure the vinyl seam flap is velcroed flat, and confirm staircases are seated with minimal gap to the platform. *Quickly move off the field before the performance begins to the adult volunteer waiting area in front of the front sideline. Never step onto the turf during the show (Rule 4.03 penalty).*
  + *Post-Show Reception & Return to Trailer:* Meet the student handlers at the staging area following their end zone egress. Take custody of the stage pieces and staircases so students can rejoin the band block. Push props back to the staging area (between Prelims and Finals) or to the equipment trailer (after Finals).
  + *Post-Finals Disassembly Supervision:* Direct the careful removal of vinyl coverings and mechanical disassembly of stage pieces and staircases per their manuals for secure trailer packing.
  + *Trailer Loading & Unloading:* Assist the transport team with the secure loading of the trailer for return to Pine Creek, and return to Pine Creek to assist with unloading and prop storage.
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
    - *CRITICAL BOUNDARY RULE: DO NOT CROSS THE BACK SIDELINE MARKERS.* Keep wheels completely behind the sideline until the on-field judge signals official entry permission.
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
    - *CRITICAL BOUNDARY RULE: DO NOT CROSS THE BACK SIDELINE MARKERS.* Keep casters completely behind the sideline until the on-field judge signals official entry permission.
  + *Field Ingress & Standby Behind Stage:*
    - When the CBA entry signal is given, push your staircase briskly straight forward onto the field following directly behind your stage platform pieces.
    - Hold the staircase on its side 5 to 10 feet behind the stage mark while the Stage Handlers (Job C.2) align the front and back pieces, lock casters, and seal the center velcro seam.
  + *Stage Approach, Flip & Handle Lift:*
    - Once the stage platform pieces are fully locked and rigid, push your staircase up to its designated access side.
    - With both students coordinating firmly, carefully flip the staircase from its transport side onto its bottom base.
    - Using the built-in lifting handles, lift and slide the staircase snugly into its final position against the stage platform framing.
    - *CRITICAL FIT CHECK:* Minimize any physical gap between the top stair tread and the stage platform decking. Ensure the staircase rests completely flat, level, and stable on the turf.
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
    - *Wind Tier Authorization:* Authorize the day's operational wind tier (Tier 0 through Tier 3) and direct ballast loading across carts and backdrops per the Ballast Schedules.
    - *HARD RULE:* If sustained winds exceed 20 mph OR gusts reach 25–30 mph, issue an immediate *NO-GO* directive. Props remain locked in trailers. Notify Band Directors immediately.
  + *Judge Liaison & Gate Release:*
    - Coordinate directly with the CBA Timing & Penalty (T&P) judge at the stadium gate.
    - Confirm official clock start protocols and verify gate chute clearances.
    - Signal the prop and cart pushers the instant official entry permission is granted.
  + *The 2:45 Clearance Call & Field Safety:*
    - Monitor stopwatch from the moment props cross the gate boundary.
    - At the 2:30 mark, loudly call *"PROPS CLEAR!"* down the sideline and confirm all 6 Prop Crew Adult Volunteers (and nearby Pit crew adults) are moving behind boundary lines.
    - Ensure 100% of adult personnel are completely off the turf and across the front/back sideline markers before the 3:15 announcement begins (*strictly avoid Rule 4.03 penalties*).
  + *Exit Chute & Traffic Management:*
    - Position yourself at the stadium exit gate during post-show egress.
    - Ensure continuous rolling motion through the tunnel chute per CBA Rule 8.05; prevent student or cart bottlenecks.
    - Direct returning props along designated perimeter paths back to the staging area or equipment trailer lot.
]

#pagebreak()

// =========================================================================
// PAGE 15: SECTION 6 — POST-SHOW PACKDOWN, CHECKLIST & SIGNOFF
// =========================================================================

= 6. Post-Show Deballasting & Trailer Packdown

All teardown and packdown procedures occur *exclusively in the equipment trailer parking lot* after clearing the stadium exit gate.  The transportation team is responsible for all loading activity, and will direct props personnel in the correct loading method and sequence.

+ *Deballasting Safety:* Remove sandbags from backdrop retention posts and duck blind carts. Place bags gently into the designated area inside the equipment trailer. *Never drop or throw sandbags* (protects seams and plastic liners).
+ *Screen Packing:* Stack collapsed sideline screens and backdrop screens onto the truck cross braces, and secure.
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
      #text(size: 8pt, weight: "bold", fill: rgb("#3182ce"))[Release v0 (D1) • September 2026]
    ]
  )
]
