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
        align(left)[*WORKING DRAFT — NOT FOR USE*],
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
  spacing: 120%,
)

#set par(justify: true, leading: 0.65em)

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
      align(left)[
        #text(size: 10.5pt, weight: "bold", fill: rgb("#1a365d"))[#role]
        #if tag != "" [
          #h(6pt)
          #rect(
            fill: rgb("#ebf8ff"),
            stroke: 0.5pt + rgb("#bee3f8"),
            radius: 3pt,
            inset: (x: 5pt, y: 2pt)
          )[#text(size: 7.5pt, weight: "bold", fill: rgb("#2b6cb0"))[#tag]]
        ]
      ],
      align(right)[#text(size: 8.5pt, weight: "bold", fill: rgb("#4a5568"))[Crew: #personnel]]
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
  inset: (x: 10pt, y: 7pt)
)[
  #text(weight: "bold", fill: rgb("#2d3748"))[🌟 CORE PROGRAM PHILOSOPHY:]
  #v(2pt)
  #text(size: 9.5pt, fill: rgb("#1a202c"))[
    *The focus is always on the kids' performance, not the props.* Props exist strictly to support and enhance the visual spectacle of the students' musicianship and marching. If conditions become hazardous or timing breaks down, props are abandoned or held back without hesitation. *Nothing we do on the prop crew will ever compromise a student's safety or their competitive show.*
  ]
]

// -------------------------------------------------------------------------
// SECTION 1: WIND SAFETY PLAN & NO-GO MATRIX (UP FRONT)
// -------------------------------------------------------------------------

= 1. Wind Safety Plan & Mandatory NO-GO Contingencies

Because Pine Creek High School operates in the high-altitude, wind-prone environment of Colorado Springs (6,500 ft ASL) and competes in open stadium venues, wind safety controls must be understood by every parent and volunteer before touching a prop. 

#nogo-box[
  *HARD RULE: If sustained winds exceed 20 mph OR gusts are forecasted/reported at 25–30 mph, PROPS DO NOT LEAVE THE TRUCK/TRAILER.*
  
  Last season confirmed that props in >20 mph winds create unacceptable safety risks for students and handlers. When this threshold is met, the Prop Lead makes an immediate *NO-GO* call. Props remain securely locked in the equipment trailer or behind stadium bleachers. *The band performs a clean visual show without props.* There is no middle ground, and no emergency lay-flat abort on the field is permitted—if high winds are even possible, props stay off the turf.
]

#v(4pt)

#table(
  columns: (1.1fr, 1fr, 2.5fr, 1.2fr),
  align: (center + horizon, center + horizon, left + horizon, center + horizon),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 3 { rgb("#fff5f5") } else { none },
  [*Wind Regime*], [*Wind Velocity*], [*Operational Action & Ballasting*], [*Decision Status*],
  [🟢 *Tier 1: Calm*], [0 – 12 mph], [Standard deployment. Nominal ballast (Duck Blinds: 1 bag/rail; Backdrops: 4 bags/post; Stages: wheel locks). Normal entry and exit.], [*GO* (Normal)],
  [🟡 *Tier 2: Elevated*], [13 – 18 mph], [Elevated vigilance. Full ballast schedule deployed. Prop pushers maintain positive two-hand grip during transit. Lead monitors gusts.], [*GO* (With Ballast)],
  [🔴 *Tier 3: Extreme*], [*> 20 mph sustained* \ or *25–30 mph gusts*], [*ABSOLUTE NO-GO.* Props remain in trailer. No props touch the field. Prop Lead notifies Band Directors and CBA timing judge.], [*NO-GO* (Hold in Truck)],
)

#v(10pt)
#callout(title: "Why There Is No Emergency Lay-Flat Plan in This Handout")[
  Previous operational drafts included field procedures for laying props flat on the turf during sudden gusts. For volunteer safety and competition clarity, *that procedure has been retired.* If 25–30 mph gusts are even remotely possible, the props will never be staged or moved onto the field.
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
  [Volunteer Crew Call Time], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Check-in at Equipment Trailer ],
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

= 3. Critical CBA Rules for Parent Volunteers

The Colorado Bandmasters Association (CBA) strictly enforces prop and adult volunteer regulations. *Penalties directly deduct points from the students' score.* Adhere strictly to the following:

#grid(
  columns: (1fr, 1fr),
  gutter: 7pt,
  rule-box(title: "Rule 9.07 — Field Passes")[
    *Maximum 25 wristbands per band.* Every parent stepping past the gate must wear the official CBA wristband on their wrist (not in pocket or on badge). Prelims and Finals use different colors.
  ],
  rule-box(title: "Rule 5.02 — Rear Entrance Mandate")[
    *Props must enter from the back sideline or rear end zone.* Never wheel props across the front boundary line (reserved strictly for pit/percussion equipment). Handlers transit perimeter tracks.
  ],
  rule-box(title: "Rule 4.03 & 5.06 — 3:15 Setup Window")[
    The introductory announcement begins 3 minutes 15 seconds after judge's entry signal. *ALL adults must be completely clear of the field before the announcement ends.* Target all adults off turf by *2:45*.
  ],
  rule-box(title: "Rule 4.03 — In-Show Turf Prohibition")[
    *Parents are strictly forbidden from touching the field during the performance.* 0.2-point penalty per occurrence. Once you exit, remain behind the front sideline or rear perimeter track.
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

The 2026 visual design for *Continuum* incorporates three prop families totaling 30 field elements:

#table(
  columns: (1.6fr, 0.8fr, 1.4fr, 1.8fr, 2.4fr),
  align: (left + horizon, center + horizon, center + horizon, left + horizon, left + horizon),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 5pt, y: 4.5pt),
  [*Prop Category*], [*Quantity*], [*Transport Unit*], [*Field Placement*], [*Crew Allocation*],
  [*Duck Blinds* \ (Sideline Screens)], [16 screens (8 per side)], [2 Rolling Carts \ (8 screens/cart)], [Front Sideline \ (Side 1: 20–41 yd; Side 2: 59–80 yd)], [2 Adult Pushers, 2 Student Unloaders, 16 Student Receivers],
  [*Rolling Backdrops*], [10 backdrops], [10 Rolling Carts \ (1 cart/prop)], [Backfield / Back Hash \ (Spanned across 30–70 yds)], [10–20 Parent Volunteers \ (1–2 pushers per backdrop)],
  [*Performance Stages*], [4 stages], [4 Mobile Platforms \ (Integrated casters)], [Midfield / Side Stages \ (Exact drill marks per show)], [8 Parent Volunteers \ (2 pushers per stage platform)],
)

#v(8pt)

// -------------------------------------------------------------------------
// SECTION 5: STEP-BY-STEP JOB DESCRIPTIONS
// -------------------------------------------------------------------------

= 5. Individual Job Descriptions & Step-by-Step Instructions

*Find your assigned job card on the following pages. Each job is formatted as an independent, single-page operations sheet that can be printed and carried during competition day.*

The field prop operation is organized into four primary divisions:

1. *Job Group A: Duck Blind Operations (Pages 4–7):* Divided into four specialized single-page job blocks covering cart pushing, rapid cart offloading, on-field concurrent deployment, and post-show egress.
2. *Job Group B: Rolling Backdrop Crew (Page 8):* Dedicated operations sheet for the 10 parent pushers handling backfield rolling backdrops (#1 through #10).
3. *Job Group C: Performance Stage Crew (Page 9):* Dedicated operations sheet for the 4 midfield mobile platform handler teams.
4. *Job Group D: Prop Lead & Field Safety Coordinator (Page 9):* Master oversight, weather telemetry monitoring, judge liaison, and timing control.

Follow all instructions in strict sequential order. Adhere to all safety warnings and CBA competition boundaries.

#pagebreak()

// =========================================================================
// PAGE 4: JOB A.1 — ADULT DUCK BLIND CART PUSHER
// =========================================================================

== Job Group A: Duck Blind Crew (16 Sideline Screens on 2 Dedicated Carts)

#job-card(
  role: "Job A.1: Adult Duck Blind Cart Pusher",
  personnel: "2 Adult Volunteers (1 per Cart: Side 1 or Side 2)",
  tag: "Front Sideline Carts"
)[
  #grid(
    columns: (1.25fr, 1fr),
    gutter: 6pt,
    rect(
      width: 100%,
      fill: rgb("#ffffff"),
      stroke: 0.8pt + rgb("#cbd5e0"),
      radius: 3pt,
      inset: (x: 6pt, y: 4pt)
    )[
      #text(weight: "bold", size: 8pt, fill: rgb("#2b6cb0"))[DAY-OF CART ASSIGNMENT:] \
      #v(1pt)
      #grid(
        columns: (1fr, 1.2fr),
        gutter: 4pt,
        [
          *Side:* \
          #box(stroke: 0.5pt + rgb("#a0aec0"), inset: (x: 2.5pt, y: 1pt), radius: 2pt)[#h(3pt)] Side 1 (Left) \
          #box(stroke: 0.5pt + rgb("#a0aec0"), inset: (x: 2.5pt, y: 1pt), radius: 2pt)[#h(3pt)] Side 2 (Right)
        ],
        [
          *Staging & Route:* \
          Back \_\_\_\_\_ Yard Line \
          Roll toward: \
          #box(stroke: 0.5pt + rgb("#a0aec0"), inset: (x: 2.5pt, y: 1pt), radius: 2pt)[#h(3pt)] Center / #box(stroke: 0.5pt + rgb("#a0aec0"), inset: (x: 2.5pt, y: 1pt), radius: 2pt)[#h(3pt)] End Zone
        ]
      )
      #v(1pt)
      #text(size: 7pt, style: "italic", fill: rgb("#718096"))[(Directive: "Side 1, Back 20, roll toward center")]
    ],
    rect(
      width: 100%,
      fill: rgb("#ffffff"),
      stroke: 0.8pt + rgb("#cbd5e0"),
      radius: 3pt,
      inset: (x: 6pt, y: 4pt)
    )[
      #text(weight: "bold", size: 8pt, fill: rgb("#2b6cb0"))[DUCK BLIND BALLAST SCHEDULE:] \
      #v(1pt)
      #table(
        columns: (1.2fr, 1fr, 1fr),
        align: (left + horizon, center + horizon, center + horizon),
        stroke: 0.3pt + rgb("#cbd5e0"),
        inset: (x: 3pt, y: 2pt),
        fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 3 { rgb("#fff5f5") } else { none },
        [*Wind Regime*], [*Per Rail*], [*Per Cart*],
        [Tier 1 (0–12 mph)], [1 bag (15 lb)], [8 sandbags],
        [Tier 2 (13–18 mph)], [2 bags (30 lb)], [16 sandbags],
        [Tier 3 (>20 mph)], [NO-GO], [In Trailer],
      )
    ]
  )

  #v(2pt)
  #text(size: 8pt, weight: "bold", fill: rgb("#1a365d"))[Complete Event Lifecycle (Truck $->$ Staging $->$ Field $->$ Standby $->$ Exit Chute $->$ Staging/Truck):]

  + *Phase 1 (Arrival, Unload & Assembly):* Meet at the equipment trailer at the volunteer crew call time. Assist with unloading the props and pit equipment from the trucks and trailers. Assist with assembly of the props.
  + *Phase 2 (Move to Staging Area):* Move props and carts to the designated staging area at the designated staging time (may be immediately after unload or several hours later, depending on the venue schedule).
  + *Phase 3 (Pre-Show Inspection):* Meet at the Staging Area 45 minutes prior to step-off. Conduct a visual inspection of the cart, screen racks, and latches. Confirm sandbag quantity in the hopper matches the Ballast Schedule above (8 bags for Tier 1; 16 bags for Tier 2). Push cart to the ready area as directed by the Prop Lead. Meet your assigned Student Unloader.
  + *Phase 4 (Field Staging A):* When directed by the on-field judge, enter the gates and stage at the prescribed location.
  + *Phase 5 (Field Staging B):* When directed by the on-field judge, move to the defined yard line along the back sideline. *DO NOT CROSS THE SIDELINE MARKERS.* Doing so will immediately invoke an official penalty.
  + *Phase 6 (Field Ingress & Directional Delivery):* When the CBA judge signals entry permission, push the cart forward around the perimeter track toward the front sideline with your Student Unloader. Enter at your starting yard mark and roll *away from the exit gate* (e.g., from 20 toward 41, or 59 toward 80), pausing 6–8 seconds at each 2-yard mark while the unloader deposits one folded screen and sandbags to the pre-set student receiver.
  + *Phase 7 (In-Show Standby at Sideline Boundary):* Once the 8th screen is delivered, immediately push the empty cart across the front boundary into the front staging area. *You must be completely off the turf before the 2:15 mark.* Park the cart facing the stadium exit gate ready for post-show egress. *Stay with your cart at the boundary for the entire performance.* Never step onto the turf during the show (Rule 4.03 penalty).
  + *Phase 8 (Post-Show Ballast Sweep):* On the final show chord, re-enter the front sideline at the far screen and roll *toward the stadium exit gate*. Scoop ballast bags placed on the turf by students directly into the cart hopper as you advance without doubling back.
  + *Phase 9 (Exit Chute Cart Loading):* We will be pausing at the exit chute with the carts to load the blinds. *This is standard procedure.* Rule 8.05 does not mean continuous motion forever after—once we cross the threshold into the tunnel, pause, load the carts with the collapsed screens, and then continue up the tunnel.
  + *Phase 10 (Return to Staging Area or Truck):* Return the carts to the staging area (between Prelims and Finals), or directly to the trailer/truck if after Finals.
  + *Phase 11 (Final Performance Teardown & Loading):* At the end of the final performance, tear down all equipment, stow sandbags in totes, and assist with loading the truck and trailer.
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
    *Student Instructions:* You accompany the Adult Cart Pusher from the rear gate to the front sideline, rapidly offload the 8 screens and 16 sandbags to your fellow student performers, and clear the turf to take your opening drill position.
  ]
  #v(4pt)

  + *Phase 1: Rear Gate Rendezvous (-10 min to Gate Opening):*
    - Meet your assigned Adult Cart Pusher at the rear stadium entrance gate 10 minutes prior to gate release.
    - Confirm whether you are assigned to Cart 1 (Side 1) or Cart 2 (Side 2).
    - Walk alongside the cart during back sideline staging queue. Confirm the retaining gate latch and safety pin are securely engaged.
  + *Phase 2: Perimeter Track Transit & Rack Security:*
    - When the CBA judge gives the entry signal, walk immediately alongside the cart rack along the perimeter track toward the front sideline.
    - Keep one hand resting on the retaining gate latch to ensure locking pins and screens remain fully stabilized during rolling transit.
    - Coordinate pace with the adult pusher so you stay aligned with the rack.
  + *Phase 3: Screen & Ballast Deposition (6-Second Drop Cadence):*
    - As the cart enters the front sideline and rolls past each marked 2-yard line (screens 1 through 8):
      - Slide one folded screen horizontally off the cart rack.
      - Set the folded screen flat on the synthetic turf directly at the feet of the pre-set student receiver.
      - Reach into the cart hopper and hand two 15-lb double-bagged sandbags to the student receiver.
    - Maintain a crisp, rapid pace: complete each handoff within *6 seconds* so the cart maintains forward momentum without stalling.
    - Repeat down the entire 8-screen line.
  + *Phase 4: Field Clearance to Opening Show Drill Set:*
    - Once the 8th screen and final sandbags are deposited, immediately step over the front boundary line with the adult cart pusher.
    - *You must be off the turf before the 2:15 mark.*
    - Briskly transition to your assigned pre-show warm-up mark or opening performance drill set. You are now cleared for the show!
  + *Phase 5: Post-Show Coordination:*
    - At the final chord, you do not need to return to the cart—your cart responsibilities are complete.
    - Exit the field with the marching band block or assist your designated section according to director instructions.
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
    *Student Instructions:* You are responsible for receiving, unfolding, latching, and ballasting the 16 duck blind sideline screens. Parents are strictly forbidden from touching props on the turf; this setup is executed 100% by students in ~15 seconds.
  ]
  #v(4pt)

  + *Phase 1: Pre-Show Field Positioning:*
    - March onto the field with the band during entry and proceed directly to your assigned front sideline coordinate.
    - *Side 1:* Spans from 20 to 41-yard line at 2-yard intervals (Screens #1 through #8).
    - *Side 2:* Spans from 59 to 80-yard line at 2-yard intervals (Screens #9 through #16).
    - Stand at attention facing the backfield awaiting the arrival of your transport cart.
  + *Phase 2: Receiving Screen & Ballast:*
    - As your transport cart arrives at your mark:
      - Receive 1 folded screen from the Student Unloader and position it upright on the turf, display face toward the front spectator stands.
      - Receive two 15-lb double-bagged sandbags and place them temporarily at your feet.
  + *Phase 3: Concurrent Unfolding & Lockup (15 Seconds):*
    - As soon as the screen is on the turf, all 8 performers on your side deploy simultaneously:
      - Swing the rear triangular support frame outward perpendicular to the front display panel.
      - Seat the snap clips (*I*) firmly into Rail 3 until fully engaged with an audible snap.
      - Reach across to the adjacent screen and engage the inter-screen connecting latches to lock the 8 screens into a rigid continuous front visual wall.
  + *Phase 4: Ballast Installation:*
    - Lift both 15-lb sandbags and set them squarely across the rear bottom horizontal rail.
    - Ensure bags rest evenly on the rail so weight is centered directly over the base.
    - Confirm inner plastic liner is not protruding or pinched.
  + *Phase 5: Rigidity Check & Show Posture:*
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
    *Student Instructions:* The 2-minute CBA egress clock starts the instant the final note of the show sounds. Disengage, collapse, and sprint your screens off the field in pairs within 35 seconds.
  ]
  #v(4pt)

  + *Phase 1: Immediate Teardown on Final Show Chord:*
    - The instant the final cutoff rings:
      - *Safe Ballast Placement:* Lift both 15-lb sandbags off the rear bottom rail and place them directly onto the synthetic turf next to the rail.  
        #text(weight: "bold", fill: rgb("#c53030"))[CRITICAL SAFETY MANDATE: NEVER THROW OR DROP SANDBAGS.] Dropping sandbags causes severe seam rupture and leaks sand, resulting in catastrophic facility fines and CBA score penalties. Place bags gently on the turf. Leave them in place for the Adult Cart Pusher to scoop during their sweep.
      - *Disengage Latches & Clips:* Disengage inter-screen side latches. Disengage snap clips (*I*) from Rail 3.
      - *Collapse Screen:* Swing the rear triangular brace flat against the front display frame.
  + *Phase 2: Pair Up for Transport (13 lbs per Performer):*
    - Pair up immediately with your assigned partner on the adjacent screen:
      - Screen 1 pairs with Screen 2; Screen 3 with Screen 4; Screen 5 with Screen 6; Screen 7 with Screen 8.
      - Screen 9 pairs with Screen 10; Screen 11 with Screen 12; Screen 13 with Screen 14; Screen 15 with Screen 16.
    - Each pair grips one collapsed screen by the dedicated carry handles / upright frame rails. Total collapsed weight is ~26 lbs (*only 13 lbs per student*).
  + *Phase 3: The 35-Second Egress Sprint:*
    - Sprint in pairs hand-carrying the collapsed screens across the front sideline boundary and toward the designated stadium exit gate chute.
    - *Goal:* All 16 screens must clear the field boundaries within *35 seconds* of the final chord!
  + *Phase 4: Trailer Lot Stacking:*
    - Carry the collapsed screens directly to the equipment trailer parking lot.
    - Stack screens flat in the transport cart racks (8 screens per cart, alternating hinges to maintain coplanar nesting $<= 2.0$ inches).
    - Insert 3D-printed locking pins into the retaining gate latches. Rejoin the band for awards / debrief.
]

#pagebreak()

// =========================================================================
// PAGE 8: JOB B.1 — ROLLING BACKDROP PUSHERS
// =========================================================================

== Job Group B: Rolling Backdrop Crew (10 Backdrops on Dedicated Carts)

#job-card(
  role: "Job B.1: Rolling Backdrop Pushers",
  personnel: "10 to 20 Parent Volunteers (1–2 per Cart)",
  tag: "Backdrop Props #1 through #10"
)[
  + *Staging & Inspection (45 min prior):* Locate your assigned backdrop cart (#1 through #10) in the staging lot. Verify: (a) graphic banner faces the correct direction; (b) 4 to 6 double-bagged 15-lb sandbags are securely seated over the two vertical iron pipe posts; (c) swivel casters roll freely; (d) caster foot brake levers are in the unlocked (UP) position.
  + *Gate Queue Order:* Queue on the back sideline track in strict numerical order (#1 at front, #10 at rear).
  + *Field Ingress:* When the judge signals, push the cart onto the field following the perimeter lane to your marked backfield yard coordinate. *Safety:* Push using the wooden 2x4 frame uprights or dedicated push handles. *NEVER push directly against the vinyl display face.*
  + *Positioning & Brake Lock:* Align the front edge of the wood base cart precisely with the yard line and hash mark specified on your drill card. *Immediately step on the caster foot brake levers on all four swivel casters to lock wheels.*
  + *Ballast Check:* Confirm the sandbags are resting fully on the plywood deck wings over the iron posts.
  + *Clear Field Before 2:45:* Once the cart is locked, turn and walk briskly off the back sideline into the rear staging area. *Do not linger.* Ensure you are across the boundary before the introductory announcement begins.
  + *Post-Show Egress:* At the final chord of the show, immediately step onto the turf, kick the caster brake levers into the unlocked (UP) position, and push the cart continuously toward the designated stadium exit chute.
  + *Continuous Motion (Rule 8.05):* *DO NOT STOP in the stadium tunnel or exit chute to talk, rest, or de-ballast.* Keep moving until the cart is fully parked in the equipment trailer lot.
]

#pagebreak()

// =========================================================================
// PAGE 9: JOB C.1 & JOB D.1 — STAGES & PROP LEAD
// =========================================================================

== Job Group C: Performance Stage Crew (4 Mobile Platforms, Stages #1 through #4)

#job-card(
  role: "Job C.1: Performance Stage Handlers",
  personnel: "8 Parent Volunteers (2 Handlers per Stage Platform)",
  tag: "Stages #1 through #4"
)[
  + *Staging & Safety Inspection:* Inspect your assigned stage platform. Verify decking surface is clean, dry, and non-slip. Confirm wheel lock levers and retractable leveling outriggers operate smoothly.
  + *Ingress & Positioning:* On the entry signal, two handlers push the stage platform from the rear gate to its designated performance mark. Avoid sudden pivoting on turf.
  + *Locking & Rigidity Verification:* Once at the mark, engage all caster wheel locks and extend/tighten stability outriggers until platform is 100% rigid. Give the platform a firm hand-shake to confirm zero wobble before student performers approach.
  + *Field Clearance:* Clear the performance field before the 2:45 mark and stand by at the nearest boundary.
  + *Post-Show Egress:* At the final chord, immediately return to the stage platform, retract outriggers, disengage wheel locks, and push the platform off the field through the exit gate in continuous motion to the trailer lot.
]

#v(8pt)

== Job Group D: Prop Lead & Field Safety Coordinator

#job-card(
  role: "Job D.1: Prop Lead & Field Safety Coordinator",
  personnel: "1–2 Experienced Prop Directors / Leads",
  tag: "Overall Field Operations & Safety"
)[
  + *Weather Monitoring:* Carry a handheld digital anemometer and monitor live airport METAR weather feeds. Issue the *NO-GO* directive if wind speeds exceed 20 mph sustained or gusts reach 25–30 mph.
  + *Judge Liaison & Gate Release:* Coordinate directly with the CBA Timing & Penalty judge at the gate. Signal the prop crew the instant entry permission is granted.
  + *The 2:45 Clearance Call:* Monitor stopwatch. At 2:30, loudly call *"PROPS CLEAR!"* down the sideline and confirm all 25 adult volunteers are across the boundary line before the 3:15 announcement begins.
  + *Exit Chute Traffic Management:* Stand at the stadium exit gate during post-show egress to prevent cart bottlenecks and ensure continuous flow into the trailer parking lot.
]

#pagebreak()

// =========================================================================
// PAGE 10: SECTION 6 — POST-SHOW PACKDOWN, CHECKLIST & SIGNOFF
// =========================================================================

= 6. Post-Show Deballasting & Trailer Packdown

All teardown and packdown procedures occur *exclusively in the equipment trailer parking lot* after clearing the stadium exit gate:

+ *Deballasting Safety:* Remove sandbags from backdrop retention posts and duck blind carts. Place bags gently into the designated heavy-duty storage totes inside the equipment trailer. *Never drop or throw sandbags* (protects seams and plastic liners).
+ *Screen Packing:* Stack collapsed sideline screens flat in the transport cart racks (8 screens per cart, hinges alternating to maintain coplanar nesting $<= 2.0$ inches). Secure retaining gate latches with 3D-printed locking pins.
+ *Trailer Loading:* Roll backdrops and carts into the trailer in reverse numerical order. Set wheel brakes, engage wheel chocks, and secure ratcheting cargo straps across each frame before transit.
+ *All-Clear Check:* Inspect the staging lot for personal belongings, water bottles, and tools. Verify all 25 volunteer wristbands are accounted for.

#v(8pt)

#rect(
  width: 100%,
  fill: rgb("#f7fafc"),
  stroke: 1pt + rgb("#cbd5e0"),
  radius: 4pt,
  inset: (x: 10pt, y: 8pt)
)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#1a365d"))[📋 Competition Day Volunteer Quick Reference Checklist]
  #v(3pt)
  #grid(
    columns: (1fr, 1fr),
    gutter: 8pt,
    [
      *Before Entering Gate:*
      - Official CBA wristband secured to wrist (Rule 9.07)
      - Arrive at trailer 45 minutes prior to step-off
      - Verify all sandbags loaded on carts/props
      - Review assigned yard marker & roll direction
      - Lock backdrop caster brakes in UNLOCKED position
    ],
    [
      *On Field & Post-Show:*
      - Push cart directly to yard mark on judge's signal
      - Lock all wheel brakes immediately upon arrival
      - *Exit turf before 2:45* (behind front/back line)
      - NEVER step onto field during the performance
      - *Continuous motion* through exit gate to trailer lot!
    ]
  )
]

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
