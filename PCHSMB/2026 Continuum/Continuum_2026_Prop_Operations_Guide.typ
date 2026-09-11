#set document(
  title: "Pine Creek High School Marching Band — 2026 Continuum Field Prop Operations Guide",
  author: "PCHS Prop & Field Operations Crew",
  date: auto,
)

// Document typography and page geometry
#set page(
  paper: "us-letter",
  margin: (x: 0.7in, top: 0.85in, bottom: 0.85in),
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
  v(12pt)
  text(fill: rgb("#1a365d"), weight: "bold", size: 13.5pt)[#it]
  v(3pt)
}

#show heading.where(level: 2): it => {
  v(9pt)
  text(fill: rgb("#2b6cb0"), weight: "bold", size: 11pt)[#it]
  v(2pt)
}

#show heading.where(level: 3): it => {
  v(6pt)
  text(fill: rgb("#2d3748"), weight: "bold", size: 10pt)[#it]
  v(2pt)
}

// Callout & Card Components
#let callout(title: none, fill: rgb("#f7fafc"), stroke: rgb("#cbd5e0"), body) = {
  rect(
    width: 100%,
    fill: fill,
    stroke: 1pt + stroke,
    radius: 4pt,
    inset: (x: 10pt, y: 7pt)
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
  v(5pt)
  rect(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 1.2pt + rgb("#3182ce"),
    radius: 5pt,
    inset: (x: 10pt, y: 8pt)
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
  columns: (2.2fr, 2fr, 3fr),
  align: (left + horizon, left + horizon, left + horizon),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  [*Logistical Milestone*], [*Scheduled Time*], [*Specific Location / Gate Instructions*],
  [Competition & Venue], [ \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ ], [ Stadium: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ ],
  [Prop Lead of the Day], [ Name: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ ], [ *Cell Phone:* ( \_\_\_\_\_ ) \_\_\_\_\_ - \_\_\_\_\_\_\_\_ ],
  [Safety Coordinator], [ Name: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ ], [ Cell: ( \_\_\_\_\_ ) \_\_\_\_\_ - \_\_\_\_\_\_\_\_ ],
  [Equipment Truck Arrival], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Parking Lot / Bay: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ ],
  [Volunteer Crew Call Time], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Check-in at Equipment Trailer ],
  [Truck Unload & Staging], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Staging Area behind Stadium ],
  [Band Warm-up Departure], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Escort carts to Warm-up Zone / Gate ],
  [Prelims Prop Gate Queue], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ *Rear Entrance Gate* (Back Sideline) ],
  [*Prelims Performance*], [ *\_\_\_\_\_ : \_\_\_\_\_ AM / PM* ], [ *T&P Clock Starts on Judge's Signal* ],
  [Post-Show Deballast], [ Immediate post-show ], [ Equipment Trailer Lot (Never at gate!) ],
  [Finals Gate Queue (if adv.)], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Rear Entrance Gate ],
  [*Finals Performance*], [ *\_\_\_\_\_ : \_\_\_\_\_ AM / PM* ], [ Evening Performance Slot ],
  [Final Packdown & Depart], [ \_\_\_\_\_ : \_\_\_\_\_ AM / PM ], [ Trailer locked & ready for transit ],
)

#v(6pt)

// -------------------------------------------------------------------------
// SECTION 3: CBA COMPETITION RULES FOR VOLUNTEERS
// -------------------------------------------------------------------------

= 3. Critical CBA Rules for Parent Volunteers

The Colorado Bandmasters Association (CBA) strictly enforces prop and adult volunteer regulations. *Penalties directly deduct points from the students' score.* Adhere strictly to the following:

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
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
    Timing clock begins on the final chord. All equipment and personnel must clear the field within 2 minutes. *Egress movement must be continuous.* Never stop or de-ballast in the exit gate chute.
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
  columns: (1.3fr, 1fr, 1.4fr, 1.8fr, 2.2fr),
  align: (left + horizon, center + horizon, center + horizon, left + horizon, left + horizon),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  [*Prop Category*], [*Quantity*], [*Transport Unit*], [*Field Placement*], [*Crew Allocation*],
  [*Duck Blinds* \ (Sideline Screens)], [16 screens (8 per side)], [2 Rolling Carts \ (8 screens/cart)], [Front Sideline \ (Side 1: 20–41 yd; Side 2: 59–80 yd)], [2 Adult Pushers, 2 Student Unloaders, 16 Student Receivers],
  [*Rolling Backdrops*], [10 backdrops], [10 Rolling Carts \ (1 cart/prop)], [Backfield / Back Hash \ (Spanned across 30–70 yds)], [10–20 Parent Volunteers \ (1–2 pushers per backdrop)],
  [*Performance Stages*], [4 stages], [4 Mobile Platforms \ (Integrated casters)], [Midfield / Side Stages \ (Exact drill marks per show)], [8 Parent Volunteers \ (2 pushers per stage platform)],
)

#v(4pt)

// -------------------------------------------------------------------------
// SECTION 5: STEP-BY-STEP JOB DESCRIPTIONS
// -------------------------------------------------------------------------

= 5. Individual Job Descriptions & Step-by-Step Instructions

*Find your assigned job below. Follow the numbered steps exactly as written.*

== Job Group A: Duck Blind Crew (16 Sideline Screens on 2 Dedicated Carts)

#job-card(
  role: "Job A.1: Side 1 Duck Blind Cart Pusher",
  personnel: "1 Adult Volunteer",
  tag: "Side 1 (Left / Stage Right)"
)[
  + *Pre-Show Staging:* Report to Equipment Trailer 45 minutes before step-off. Push the loaded Side 1 Cart (containing Screens 1–8 and 16 double-bagged sandbags) to the rear stadium entrance gate. Queue on the back sideline at the *Back 20-yard line*.
  + *Field Ingress:* When the CBA judge signals entry permission, push the cart forward around the perimeter track toward the front sideline. Coordinate with your Student Unloader walking alongside.
  + *Directional Delivery (Away from Exit Gate):* Enter the front sideline at the 20-yard line and roll *away* from the exit gate toward the 41-yard line. Pause for ~6–8 seconds at each 2-yard mark while the unloader deposits one folded screen and ballast to the pre-set student receiver.
  + *Cart Clearance Before Announcement:* Once the 8th screen is dropped at the 41-yard line, immediately push the empty cart across the front boundary line into the front staging area. *You must be off the turf by the 2:15 mark.* Park cart facing the exit gate.
  + *Post-Show Zero-Doubling-Back Ballast Sweep:* On the final show chord, push the cart back onto the front sideline, starting at the far end (Screen 8) and rolling *toward the stadium exit gate*. Scoop ballast bags placed on the turf by students into the cart hopper. Keep moving continuously across the exit gate line to stop the official CBA 2:00 egress clock. Do not stop until you reach the trailer lot!
]

#pagebreak()

#job-card(
  role: "Job A.2: Side 2 Duck Blind Cart Pusher",
  personnel: "1 Adult Volunteer",
  tag: "Side 2 (Right / Stage Left)"
)[
  + *Pre-Show Staging:* Report to Equipment Trailer 45 minutes before step-off. Push the loaded Side 2 Cart (Screens 9–16 + ballast) to the rear stadium entrance gate. Queue on the back sideline at the *Back 40-yard line* (asymmetric staging prevents bottlenecking at the gate).
  + *Field Ingress:* On the judge's signal, push the cart across the backfield to the Side 2 perimeter lane, then transit down to the front sideline at the 59-yard line.
  + *Directional Delivery (Away from Exit Gate):* Roll along the front sideline from the 59-yard line toward the 80-yard line, pausing ~6–8 seconds per screen mark for unloader deposition.
  + *Cart Clearance Before Announcement:* After dropping Screen 16, exit the cart over the front boundary into the Side 2 front staging area. Clear the turf before the 2:15 mark.
  + *Post-Show Ballast Sweep:* On the final chord, execute the directional ballast sweep toward the stadium exit gate. Scoop all ballast bags into the cart, cross the stadium exit threshold to stop the clock, and proceed directly up the hill to the trailer lot.
]

#job-card(
  role: "Job A.3: Duck Blind Cart Unloaders",
  personnel: "2 Volunteers (1 Student / 1 Parent per Cart)",
  tag: "Cart Operations"
)[
  + *Transit:* Walk immediately adjacent to the cart rack during perimeter transit. Hold the retaining gate latch securely in place.
  + *Screen & Ballast Deposition:* At each marked yard line, slide one folded screen horizontally off the cart rack and set it flat on the turf directly at the feet of the pre-set student receiver. Hand two 15-lb sandbags to the student.
  + *Pacing:* Complete each drop within 6 seconds. Move in cadence with the cart pusher down the 8-screen line.
  + *Exit:* Once the 8th screen is handed off, step over the front boundary line with the cart pusher. Remain off the field during the performance.
]

#job-card(
  role: "Job A.4: Student Receivers & Post-Show Screen Egress",
  personnel: "16 Student Performers (8 per side)",
  tag: "Student Role — Reference for Parents"
)[
  *Parent Notice:* Parents do NOT handle screen assembly or disassembly on the field. Students handle this entirely:
  - *Setup:* Pre-set student receivers unfold the rear triangular support, seat snap clips (*I*) into Rail 3, latch adjacent screens, and place ballast on the rear rail. All 8 screens deploy concurrently in ~15 seconds.
  - *Post-Show Egress:* On the final chord, students disengage clips, lay screens flat, set ballast on turf without dropping/throwing, and hand-carry collapsed screens off the field in pairs (13 lbs/student) in a ~35-second sprint.
]

#pagebreak()

== Job Group B: Rolling Backdrop Crew (10 Props, Props #1 through #10)

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

#pagebreak()

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

// -------------------------------------------------------------------------
// SECTION 6: POST-SHOW DEBALLASTING & TRAILER PACKDOWN
// -------------------------------------------------------------------------

= 6. Post-Show Deballasting & Trailer Packdown

All teardown and packdown procedures occur *exclusively in the equipment trailer parking lot* after clearing the stadium exit gate:

+ *Deballasting Safety:* Remove sandbags from backdrop retention posts and duck blind carts. Place bags gently into the designated heavy-duty storage totes inside the equipment trailer. *Never drop or throw sandbags* (protects seams and plastic liners).
+ *Screen Packing:* Stack collapsed sideline screens flat in the transport cart racks (8 screens per cart, hinges alternating to maintain coplanar nesting $<= 2.0$ inches). Secure retaining gate latches with 3D-printed locking pins.
+ *Trailer Loading:* Roll backdrops and carts into the trailer in reverse numerical order. Set wheel brakes, engage wheel chocks, and secure ratcheting cargo straps across each frame before transit.
+ *All-Clear Check:* Inspect the staging lot for personal belongings, water bottles, and tools. Verify all 25 volunteer wristbands are accounted for.

#v(14pt)

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
