#set document(
  title: "Pine Creek High School Marching Band — Sideline Screen / Duck Blind Construction and Field Operations Manual",
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
          align(right)[*Sideline Screen / Duck Blind Manual*]
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
        align(center)[*Release v0 (D30)* | September 2026],
        align(right)[Page #counter(page).display("1 of 1", both: true)]
      )
    ]
  ]
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
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 7 { rgb("#ebf8ff") } else { none },
  inset: (x: 3.5pt, y: 1.8pt),
  [*Version*], [*Date*], [*Document State*], [*Key Modifications & Engineering Decisions*],
  [D24], [2026-09-01], [Working draft], [Imported legacy v24 draft as controlled repository baseline.],
  [D25], [2026-09-01], [Working draft], [Standardized status markings, footers, and visible version history table.],
  [D26], [2026-09-01], [Working draft], [Standardized document architecture, 2026 CBA rules, and cost breakdown tables.],
  [D27], [2026-09-09], [Working draft], [Added vinyl installation procedure, dimensions specifications, and tape/clamp schedule.],
  [D28], [2026-09-10], [Working draft], [Added aerodynamic wind loading analysis, tiered ballasting schedule, and volunteer guide.],
  [D29], [2026-09-11], [Working draft], [Updated field operations with preliminary cart study and asymmetric backfield staging.],
  [*D30*], [*2026-09-13*], [*Working draft*], [*Full Typst rewrite. Adopted Two-Student Direct Carry (16 pairs walk assembled; zero transport carts built, saving \$440). Standardized 6 true semicircular wind relief flaps (R = 4.0 in., 8.0 in. chord by 4.0 in. drop, pre-punched 3/8 in. / 10 mm holes, 15% drag reduction). Updated complete wind stability tables.*],
)
]

#v(2pt)

== Master Manual Organization & Quick-Reference Guide

#text(size: 8pt)[
- *Part 1: Construction & Fabrication Manual (Sections 1–8):* Complete shop guide covering safety, materials, 3D printing parameters, the 7-stick conduit cutting schedule, 4-stage frame assembly, vinyl mounting, and Section 8.3 dedicated semicircular wind relief flap cutting ($R = 4.0$ in., 15% drag drop).
- *Part 2: Field Logistics & Operations Manual (Sections 9–13):* Field-facing guide covering the 15-minute CBA time budget, Two-Student Carry deployment (55.7s, +139s buffer) and egress (55.0s, +65s buffer), zero carts, Section 12 full tiered wind stability tables, and CBA rules.
- *Part 3: Placards & Quick References (Appendices C–D):* Print-ready on-prop laminated field placard, 4 in. × 6 in. field coordinate card template, and competition-day parent volunteer checklist.
]

#pagebreak()

// =========================================================================
// PART 1: CONSTRUCTION & FABRICATION MANUAL (PAGES 2-13)
// =========================================================================

= Part 1: Construction & Fabrication Manual

== 1. Safety, Work Area & Shop Protocol

- *Eye and Ear Protection:* Wear ANSI Z87.1 approved safety glasses during all cutting, deburring, and drilling operations. Use hearing protection when operating abrasive cutoff saws or reciprocating saws.
- *Cut Conduit Edges:* Freshly cut EMT conduit edges are razor-sharp. Every tube end *must* be thoroughly deburred inside and outside using a reaming tool, half-round file, or dedicated rotary deburring tool before handling or assembly.
- *Clean Staging Surface:* Vinyl installation and banner wrapping *must* be performed over clean moving blankets laid on a flat floor. Never allow scrim vinyl to contact shop grit, gravel, or metal shavings.
- *Fastener Safety:* Self-drilling screws (*J*) generate sharp metal shavings when penetrating EMT walls. Clear shavings immediately from work surfaces and moving blankets to prevent puncture damage to printed vinyl faces.

== 2. Materials & Component Inventory

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
)

#pagebreak()

// PAGE 3: FULL-PAGE COMPONENT INVENTORY FIGURE
#align(center)[
  #figure(
    image("assets/figures/fig1_component_inventory.png", width: 96%),
    caption: [Component inventory for one complete sideline screen frame.]
  )
]

#pagebreak()

// PAGE 4: 3D PRINTING SPECS & COST BREAKDOWN
== 3. 3D-Printed Parts Specifications

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

#v(8pt)

== 5. Estimated Fabrication Cost Breakdown

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

// PAGE 5: CONDUIT CUTTING STATION
== 4. Optimized Conduit Cutting Schedule

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

#v(4pt)
#align(center)[
  #figure(
    image("assets/figures/fig2_conduit_cut_diagram.png", width: 95%),
    caption: [Proportional seven-stick conduit cut diagram.]
  )
]

#pagebreak()

// PAGE 6: FOLDED STATE MAP & FASTENING RULES
== 6. Step-by-Step Frame Assembly

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

// PAGE 7: FULL-PAGE EXPLODED FOLDED MAP
#align(center)[
  #figure(
    image("assets/figures/fig3a_exploded_folded_map.png", width: 94%),
    caption: [Exploded folded-state component and connector-fastening map.]
  )
]

#pagebreak()

// PAGE 8: STAGE 1
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

// PAGE 9: STAGE 2
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

// PAGE 10: STAGE 3
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

// PAGE 11: STAGE 4 & QA INSPECTION
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

#v(4pt)

== 7. Mechanical Inspection & Quality Assurance Protocol

Before approving a completed frame for vinyl wrapping, verify the following:
- [ ] *Squareness:* Diagonal measurements across the main outer rectangle match within 1/16 in.
- [ ] *Fastener Count:* Exactly 36 *J* screws installed. No screw heads loose, stripped, or protruding.
- [ ] *Hinge Free-Rotation:* The 4 upper hinges on Rail 2 and 2 lower hinges on Rail C rotate smoothly without binding.
- [ ] *Clip Lockup:* Both 3D clips (*I*) snap securely over Rail 3 and release cleanly with finger thumb pressure.
- [ ] *Coplanar Folding:* Rear frame collapses completely flat inside perimeter frame (*overall thickness <= 2.0 in.*).

#pagebreak()

// PAGE 12: VINYL BANNER MOUNTING PROTOCOL
== 8. Vinyl Banner Installation & Frame Mounting Protocol

=== 8.1 Banner Ordering, Bleed & Material Specifications
- *Face Display Area:* 48.0 in. H × 96.0 in. W nominal ($30.5" sq ft"$ actual display face).
- *Cut Banner Dimensions:* 52.0 in. H × 100.0 in. W (provides a 2.0-in. perimeter wrap bleed on all four sides).
- *Material Specification:* 13 oz heavy-duty matte scrim vinyl (outdoor UV-cured inks, flush cut edges, no grommets, no sewn hems).

#v(4pt)

=== 8.2 Step-by-Step Vinyl Tensioning, Wrapping & Clamping Procedure

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

// PAGE 13: DEDICATED SECTION 8.3 — WIND RELIEF FLAP CUTTING
== 8.3 Cutting Engineered Semicircular Wind Relief Flaps

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

=== Semicircular Geometry Standard ($R = 4.0$ in.)
Each flap is a true semicircle ($180^degree$ circular arc) measuring *8.0 in. horizontal top chord × 4.0 in. downward drop* (Radius R = 4.0 in.). Vent area is 25.13 sq in. per flap (1.05 sq ft total across 6 flaps, or 3.43% of display face). Semicircular geometry provides superior thermal beam stiffness over elongated ovals, preventing tip curling and sagging in $130^degree F+$ crumb-rubber heat.

=== 6-Flap Fleet Standard Coordinate Schedule ($2 times 3$ Grid)
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

=== Artwork Protection & The "Floating Flap" Adjustment Rule
- *1-Arcminute Acuity Resolution:* Razor kerf (< 0.01 in.) is 30x smaller than human eye resolution at 30 yards (0.31 in.). Flaps hang 100% flush by gravity and are completely invisible from spectator stands.
- *Floating Allowance:* Centerlines may float horizontally by $plus.minus 6$ to $12$ in. (and vertically by $plus.minus 2$ to $4$ in.) along their row to position flaps into solid backgrounds, dark textures, or negative space.
- *Mandatory NO-CUT Zones:* Flaps must clear student performer faces by $>= 6.0$ in. Never cut across show title typography, movement titles, or Pine Creek school / sponsor crests.

=== Step-by-Step Punch-First Fabrication Procedure
1. *Tooling Checklist:* Obtain a 3/8-in. (10 mm) rotary leather punch, dense end-grain hardwood backing block, R = 4.0 in. rigid semicircular template, fresh utility knife, and soft marking pencil.
2. *Marking & Graphic Inspection:* Measure and mark the top horizontal chord centerlines and endpoint punch marks (8.0 in. apart). Verify compliance with Floating Flap artwork rules.
3. *MANDATORY PUNCH FIRST:* Slide hardwood block behind vinyl directly beneath punch mark. Align 3/8-in. rotary punch over mark and strike firmly with mallet. Repeat for opposing hole (8.0 in. apart). Clean circular holes eliminate stress risers ($K_t -> 1.0$). #alert[CRITICAL MANDATE: NEVER SLICE WITH RAZOR BEFORE PUNCHING HOLES.]
4. *Scribe & Slice Semicircular Arc:* Place R = 4.0 in. template tangent to the bottom edge of both punched holes. Draw utility razor along template in a single, smooth pass through the 4.0-in. apex.
5. *LEAVE TOP CHORD UNCUT:* #alert[The top 8.0-in. horizontal chord between holes must remain uncut.] This uncut vinyl serves as the permanent gravity hinge.
6. *Flap Inspection:* Verify flap hangs 100% flush under gravity and swings open freely when pushed from behind.
7. *Backlight Pinprick Baffle (Optional):* In west-facing venues (low afternoon sun), apply a 1.5 in. × 1.5 in. square of black Gorilla tape behind each punch hole with a horizontal slit along lower edge to eliminate solar pinpricks.

#pagebreak()

// =========================================================================
// PART 2: FIELD LOGISTICS & OPERATIONS MANUAL (PAGES 14-16)
// =========================================================================

= Part 2: Field Logistics & Operations Manual

== 9. The Dynamic 15-Minute CBA Time Budget Architecture

Under Colorado Bandmasters Association (CBA) Rule 5.01 and Rule 5.06, competitive field shows operate within a rigid *15-minute 00-second (900.0-second)* master clock interval:

$T_"total" = T_"deploy" + T_"announce" + T_"performance" + T_"egress" <= "15:00 (900 seconds)"$

#grid(
  columns: (1.2fr, 0.8fr),
  gutter: 10pt,
  [
    - *The Fungible Time Tradeoff:* The 2:00 egress window is an operational planning benchmark, not a hard standalone rule. Shaving time off deployment transfers directly into the egress and performance budget!
    - *Rule 5.09 Early Announcement Signal:* A band director may signal the Timing & Penalties judge early once props and performers are set, starting the 35-second announcement ahead of the 3:15 cap.
    - *Two-Student Carry Slack Creation:* By deploying in just *55.7 seconds*, the band banks *+139.3 seconds (~2 min 19s)* of safety slack, eliminating all egress time anxiety.
  ],
  figure(
    image("assets/simulation/cba_15min_time_budget_cycle.png", width: 100%),
    caption: [CBA 15-minute time budget dynamic operational cycle.]
  )
)

== 10. Two-Student Carry Deployment Protocol

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

// PAGE 15: EGRESS PROTOCOL & COMPARISON CHART
== 11. Two-Student Carry Post-Show Egress Protocol

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

// PAGE 16: UPDATED WIND TABLES & CBA RULES
== 12. Aerodynamic Wind Loading & Updated Tiered Ballasting Schedule

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
  [*Wind Tier*], [*Wind Velocity*], [*Ballast Configuration*], [*Solid Face (Slide / Tip)*], [*With Slits (Slide / Tip)*], [*Status*],
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

== 13. Applicable 2026 CBA Competition Rules

- *Rule 5.02 (Rear Entrance Mandate):* All props must enter from the back sideline or rear end zone gates. #alert[Never enter across the front boundary line] (reserved strictly for pit equipment).
- *Rule 4.03 & 5.06 (3:15 Setup Window & Adult Turf Ban):* Introductory announcement begins 3:15 after entry signal. All adult volunteers must be off turf by 2:45. #alert[Adults touching turf during performance incur a 0.2-point penalty per occurrence.]
- *Rule 8.05 (2:00 Egress Clock & Double-Bagging):* All props must clear field boundary within 2:00. All sandbags must be double-bagged with intact plastic inner liners. Leaking sand incurs severe facility fines.
- *Rule 8.09 (Tunnel Clearance):* Props must clear 9 ft 6 in. tunnel height limits and maintain continuous movement.

#pagebreak()

// =========================================================================
// PART 3: PLACARDS & QUICK REFERENCES (PAGES 17-18)
// =========================================================================

= Part 3: Reference Placards & Quick Guides

== Appendix C: On-Prop Laminated Field Operations Placard

_Volunteers: Mount this summary card inside a weather-proof adhesive sleeve on the rear EMT conduit of each screen._

#v(6pt)

#rect(
  width: 100%,
  fill: rgb("#ffffff"),
  stroke: 1.5pt + rgb("#1a365d"),
  radius: 4pt,
  inset: (x: 10pt, y: 8pt)
)[
  #align(center)[
    #text(size: 11pt, weight: "bold", fill: rgb("#1a365d"))[PINE CREEK MARCHING BAND • SIDELINE SCREEN FIELD PLACARD] \
    #text(size: 8pt, fill: rgb("#718096"))[2026 Production: Continuum • Nominal 4 ft × 8 ft Folding Duck Blind]
  ]
  #v(3pt)
  #line(length: 100%, stroke: 0.8pt + rgb("#cbd5e0"))
  #v(3pt)

  #grid(
    columns: (1fr, 1fr),
    gutter: 10pt,
    [
      #text(weight: "bold", size: 8.5pt, fill: rgb("#2b6cb0"))[RAPID TWO-STUDENT DEPLOYMENT:] \
      1. *Queue:* 16 student pairs queue along back sideline with assembled screens.
      2. *Walk-Across ($T = "0:00"$):* On horn, walk straight across field (~55 yds at 1.1 yd/s).
      3. *Placement:* Deposit on front yard mark; align face into unbroken visual wall.
      4. *Ballast:* Place sandbags over rear ground rail *C*. Transition to opening drill by *T+0:55*.
      
      #v(4pt)
      #text(weight: "bold", size: 8.5pt, fill: rgb("#2b6cb0"))[RAPID TWO-STUDENT EGRESS:] \
      1. *Final Chord ($T = "0:00"$):* Lift sandbags gently onto turf. #alert[DO NOT THROW BAGS.]
      2. *Sprint ($T = "0:05 to 0:55"$):* Grasp screen uprights; jog down sideline into exit chute.
      3. *Trailer:* Proceed directly through tunnel to trailer lot. Zero on-field cart loading!
    ],
    [
      #text(weight: "bold", size: 8.5pt, fill: rgb("#2b6cb0"))[WIND BALLAST SCHEDULE (REAR RAIL C):] \
      - *Tier 0 (0–8 mph):* 0 bags (dry frame, 26 lbs) -> GO.
      - *Tier 1 (8–12 mph):* 2 bags on rear rail C (30 lbs ballast, 56 lbs total) -> GO.
      - *Tier 2 (12–18 mph):* 3 bags (2 on rear rail C + 1 hung on Rail 2, 71 lbs total) -> GO.
      - *Tier 3 (18–22 mph):* 4 bags (2 on rear rail C + 2 hung on Rail 2, 86 lbs total) -> CAUTION.
      - #alert[Tier 4 (>20 mph sust. / >25 mph gust): ABSOLUTE NO-GO.]
      
      #v(4pt)
      #text(weight: "bold", size: 8.5pt, fill: rgb("#c53030"))[CRITICAL SAFETY & CBA RULES:] \
      - Adults: #alert[STAY OFF TURF DURING SHOW] (Rule 4.03 penalty).
      - Props must enter from REAR GATE only (Rule 5.02).
      - Double-bagged sandbags mandatory; zero sand on turf.
    ]
  )
]

#pagebreak()

// PAGE 18: FIELD PLACEMENT CARD & VOLUNTEER CHECKLIST
== Appendix C.1: 4 in. × 6 in. Field Placement Card Template

_Drill Writers & Logistics Staff: Print this template on 4 in. × 6 in. cardstock for each of the 16 screen locations._

#rect(
  width: 100%,
  fill: rgb("#f7fafc"),
  stroke: (paint: rgb("#3182ce"), thickness: 1pt, dash: "dashed"),
  radius: 4pt,
  inset: (x: 10pt, y: 7pt)
)[
  #grid(
    columns: (1.2fr, 1fr),
    gutter: 10pt,
    [
      #text(weight: "bold", size: 9pt, fill: rgb("#1a365d"))[SCREEN POSITION COORDINATE CARD] \
      #v(2pt)
      - *Screen Number:* Screen \# \_\_\_\_\_ (Side 1 / Side 2)
      - *Front Sideline Mark:* Yard Line \_\_\_\_\_ (+ \_\_\_\_\_ steps)
      - *Facing Orientation:* Front Stands / Angled \_\_\_\_\_ degrees
      - *Ballast Assignment:* \_\_\_\_\_ bags on Rail C; \_\_\_\_\_ hanging
      - *Assigned Student Pair:* \
        1) \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ \
        2) \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
    ],
    figure(
      image("assets/field_template.png", width: 100%),
      caption: [Field coordinate template.]
    )
  )
]

#v(8pt)

== Appendix D: Parent Volunteer Competition Day Guide & Checklist

#table(
  columns: (1.2fr, 1.8fr, 3fr),
  align: (center + horizon, left + horizon, left + horizon),
  stroke: 0.4pt + rgb("#cbd5e0"),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 5pt, y: 3pt),
  [*Time Interval*], [*Operational Milestone*], [*Action Items & Checkpoints*],
  [Call - 90 min], [Truck Arrival & Stage Transport], [Unload screens from truck onto 4 stages (4/stage) to transit to common outside staging area. Setup screens, test clips and wind flaps, and load ballast wagons.],
  [Call - 45 min], [Staging & Student Rendezvous], [Meet student carry pairs (16 pairs) and student ballast handlers (2) at outside staging. Confirm front yard marks. Students take over assembled screens and join wagons.],
  [Call - 15 min], [Gate Queue (Back Sideline)], [Students carry screens through rear gate to back sideline. Adult & student ballast handlers queue wagons at sideline.],
  [*T = "0:00"*], [*Permission to Enter*], [*Wagon teams deposit ballast along sideline corridor; students walk across (~55s) and place ballast on blinds. Adults clear turf by 2:45.*],
  [Show Run], [Performance Standby], [#alert[STAY OFF TURF.] Stand by outside front boundary in volunteer waiting area for entire performance (Rule 4.03).],
  [*Final Chord*], [*Egress & Ballast Sweep*], [Students leave bags on turf and sprint screens to outside staging (~55s). Wagon teams sweep resting sandbags into wagons.],
  [Post-Show], [Staging Hand-Off & Stage Reload], [Students hand blinds and wagons to managers at outside staging and depart together. Managers collapse screens flat, load 4 onto each stage, and return to trucks.],
)
