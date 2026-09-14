#set page(paper: "us-letter", margin: (x: 0.68in, top: 0.72in, bottom: 0.72in))
#set text(font: ("Helvetica Neue", "Helvetica", "Arial"), size: 9.5pt, fill: rgb("#1a202c"), spacing: 120%)

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
    columns: (1fr, 1.45fr),
    gutter: 5pt,
    rect(
      width: 100%,
      fill: rgb("#ffffff"),
      stroke: 0.8pt + rgb("#cbd5e0"),
      radius: 3pt,
      inset: (x: 5pt, y: 4pt)
    )[
      #text(weight: "bold", size: 8pt, fill: rgb("#2b6cb0"))[DAY-OF CART ASSIGNMENT:] \
      #v(2pt)
      #grid(
        columns: (1fr, 1.15fr),
        gutter: 3pt,
        [
          *Side:* \
          #v(2pt)
          #box(stroke: 0.5pt + rgb("#a0aec0"), inset: (x: 2.5pt, y: 1pt), radius: 2pt)[#h(3pt)] Side 1 (Right)\* \
          #v(2pt)
          #box(stroke: 0.5pt + rgb("#a0aec0"), inset: (x: 2.5pt, y: 1pt), radius: 2pt)[#h(3pt)] Side 2 (Left)
        ],
        [
          *Staging Location:* \
          #v(2pt)
          Back \_\_\_\_\_ Yard Line
        ]
      )
      #v(4pt)
      #text(size: 6.5pt, style: "italic", fill: rgb("#718096"))[\* Side 1 is on the right when standing on the backfield facing the stands.]
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
        [#text(size: 6.5pt, weight: "bold", fill: rgb("#c53030"))[NO-GO (Lay Flat / Trailer)]],
        [#text(size: 6.5pt, weight: "bold", fill: rgb("#c53030"))[In Trailer]],
      )
    ]
  )

  #v(2pt)
  #text(size: 8pt, weight: "bold", fill: rgb("#1a365d"))[Complete Event Lifecycle (Truck $->$ Staging $->$ Field $->$ Standby $->$ Exit Chute $->$ Staging/Truck):]

  + *Arrival, Unload & Assembly:* Meet at the equipment trailer at the volunteer crew call time. Assist with unloading the props and pit equipment from the trucks and trailers. Assist with assembly of the props. Note: duck blinds are fully assembled, but the backdrops and stages both require multiple people to perform the assembly work.
  + *Move to Staging Area:* Move props and carts to the designated staging area at the designated staging time.
  + *Pre-Show Inspection:* Meet at the Staging Area 45 minutes prior to show time. Conduct a visual inspection of the cart, screen racks, and latches. Confirm sandbag quantity in the hopper matches the Ballast Schedule above (e.g., 8–16 bags for Tier 1; 24 bags for Tier 2). Push cart to the ready area as directed by the Prop Lead. Meet your assigned Student Unloader who will join you following their warm-ups.
  + *Field Staging A:* When directed by the on-field judge, enter the gates and stage at the prescribed location.
  + *Field Staging B:* When directed by the on-field judge, move to the defined yard line along the back sideline. *DO NOT CROSS THE SIDELINE MARKERS.* Doing so will immediately invoke an official penalty.
  + *Field Ingress & Directional Delivery:* When the CBA judge signals entry permission, push the cart forward toward the front sideline with your Student Unloader. When you reach the front sideline, turn and walk along the front sideline, pausing 6–8 seconds at each 2-yard mark while the unloader deposits one folded screen and sandbags to the pre-set student receiver.
  + *In-Show Standby at Sideline Boundary:* Once the 8th screen is delivered, immediately push the empty cart across the front boundary into the front staging area. *You must be completely off the turf before the 2:15 mark.* Park the cart ready for post-show egress. *Stay with your cart at the boundary for the entire performance.* Never step onto the turf during the show (Rule 4.03 penalty).
  + *Post-Show Ballast Sweep:* Once the show is completed, re-enter the front sideline at the far screen and move along the line of ballast bags you previously deposited. Scoop ballast bags placed on the turf by students directly into the cart hopper as you advance without doubling back. A student will be assigned to assist you in getting this done timely.
  + *Exit Chute Cart Loading:* We will be pausing at the exit chute with the carts to load the blinds. *DO NOT STOP FOR ANY LONGER THAN NECESSARY TO QUICKLY LOAD THE BLINDS.*
  + *Return to Staging Area or Truck:* Return the carts to the staging area (between Prelims and Finals), or directly to the trailer/truck if after Finals.
  + *Final Performance Teardown & Loading:* At the end of the final performance, tear down all equipment and assist with loading the truck and trailer.
]
