#set document(
  title: "Pine Creek High School Marching Band — Performance Stage & Staircase System Manual",
  author: "PCHS Prop & Field Operations Crew",
  date: auto,
)

#let appendix-id = state("appendix-id", "")
#let appendix-title = state("appendix-title", "Performance Stage System Manual")

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
        align(center)[*Release v0 (D1)* | September 2026],
        align(right)[*Page #pg-str*]
      )
    ]
  }
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 9.2pt,
  fill: rgb("#1a202c"),
)

#set par(justify: true, leading: 0.62em)
#show table.cell: set par(justify: false)
#set figure(numbering: none)

#show raw: set text(size: 6.2pt, font: ("Menlo", "DejaVu Sans Mono", "Courier New", "Courier"), spacing: 100%, tracking: 0pt)

#let status-badge(text-val, bg-color, text-color, border-color) = {
  box(
    fill: bg-color,
    stroke: 0.5pt + border-color,
    radius: 3pt,
    inset: (x: 4pt, y: 1.5pt),
    outset: 0pt,
    baseline: 0%,
    text(size: 6.8pt, weight: "bold", fill: text-color)[#text-val]
  )
}

#let alert(body) = [
  #v(2pt)
  #rect(
    width: 100%,
    fill: rgb("#fff5f5"),
    stroke: (left: 3pt + rgb("#e53e3e"), rest: 0.5pt + rgb("#feb2b2")),
    radius: (top: 0pt, bottom: 3pt),
    inset: (x: 8pt, y: 5pt),
  )[
    #text(size: 8.5pt, weight: "bold", fill: rgb("#9b2c2c"))[SAFETY NOTICE:] \
    #text(size: 8.2pt, fill: rgb("#742a2a"))[#body]
  ]
  #v(2pt)
]

#let tip(body) = [
  #v(2pt)
  #rect(
    width: 100%,
    fill: rgb("#ebf8ff"),
    stroke: (left: 3pt + rgb("#3182ce"), rest: 0.5pt + rgb("#bee3f8")),
    radius: (top: 0pt, bottom: 3pt),
    inset: (x: 8pt, y: 5pt),
  )[
    #text(size: 8.5pt, weight: "bold", fill: rgb("#2b6cb0"))[OPERATIONAL DIRECTIVE:] \
    #text(size: 8.2pt, fill: rgb("#2c5282"))[#body]
  ]
  #v(2pt)
]

// =========================================================================
// GLOBAL PREAMBLE — COVER & SYSTEM IDENTITY
// =========================================================================

#align(center)[
  #v(8pt)
  #text(size: 19pt, weight: "bold", fill: rgb("#1a365d"))[
    PINE CREEK HIGH SCHOOL MARCHING BAND
  ] \
  #v(3pt)
  #text(size: 13.5pt, weight: "bold", fill: rgb("#2b6cb0"))[
    PERFORMANCE STAGE & STAIRCASE SYSTEM MANUAL
  ] \
  #v(2pt)
  #text(size: 9.5pt, style: "italic", fill: rgb("#4a5568"))[
    Off-the-Shelf Modular Scaffolding Assembly, Multi-Tier Staging, Inter-Section Gap Bridging, Vinyl Wrap Installation, and CBA Field Operations Guide
  ] \
  #v(6pt)
  #status-badge("WORKING DRAFT — NOT FOR USE", rgb("#fffaf0"), rgb("#c05621"), rgb("#fbd38d"))
  #v(6pt)
]

#line(length: 100%, stroke: 0.75pt + rgb("#cbd5e0"))
#v(3pt)

== Document History & State Control

#table(
  columns: (1fr, 1.1fr, 1.5fr, 4.4fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if y == 1 { rgb("#ebf8ff") } else { none },
  inset: (x: 5pt, y: 2.5pt),
  [*Version*], [*Date*], [*Status*], [*One-Line Description*],
  [Release v0 (D1)], [September 2026], [WORKING DRAFT], [Initial assembly manual: modular scaffolding architecture, 14'x10' fleet stages, 2-tier stage, caster pinning, aluminum gap bridge, vinyl wrap installation, and field operations.],
)

#v(2pt)

== System Overview & Prop Identity

The *Pine Creek High School Marching Band Performance Stage System* provides elevated, mobile performance platforms for soloists, dance ensembles, battery percussion, and visual features. For the *2026 Continuum* production, the stage fleet consists of:
1. *Three (3) 14' × 10' × 3.5' Uniform Stages (Platforms \#1, \#2, and \#3):* Each platform provides a \140 sq ft elevated performance deck at a \42.0 in. height. Each stage is formed by two \14 ft × 5 ft rolling units docked side-by-side, joined by an engineered center gap bridge.
2. *One (1) Two-Tier Stepped Stage (Platform \#4):* A multi-level platform featuring a \5 ft × 7 ft × 3.5 ft upper tier and a \5 ft × 7 ft × 2.5 ft lower tier constructed using alternate 2-foot vertical risers.
3. *Four (4) Mobile Staircases:* Dedicated rolling stair units that transit on side casters and flip upright to dock against each stage platform.
4. *Stage-Top Equipment Transport Mode:* During truck-to-staging transit, each stage transports four (4) collapsed Sideline Screens flat on its deck, eliminating dedicated screen transport carts and saving volunteer labor.

#v(2pt)

== Master Manual Architecture

In strict adherence to the [PCHSMB Universal Document Standard](../../AGENTS.md), this manual is divided into two independently printable and bindable appendix manuals:
- *Appendix A: Field Operations Manual (Pages A-1 through A-7):* Personnel roles, staging transit, CBA 90-second field deployment, gap bridge placement, vinyl seam closure, continuous end zone egress, and 2026 CBA competition rule compliance.
- *Appendix B: Construction, Assembly & Inspection Manual (Pages B-1 through B-11):* Bill of materials, tools, 82-inch aluminum gap bridge fabrication, cost breakdown, step-by-step scaffolding assembly (Casters -> Verticals -> X-Braces -> Deck Plates -> Docking -> Gap Bridges -> Two-Tier setup), mechanical QA inspection, and seasonal vinyl wrap installation.

#pagebreak()

// =========================================================================
// APPENDIX A: FIELD OPERATIONS MANUAL
// =========================================================================
#appendix-id.update("A")
#appendix-title.update("APPENDIX A: FIELD OPERATIONS MANUAL")
#counter(page).update(1)

#set page(
  header: context {
    make-header("APPENDIX A | FIELD OPERATIONS MANUAL")
  }
)

#align(center)[
  #v(10pt)
  #text(size: 11pt, weight: "bold", fill: rgb("#2b6cb0"))[APPENDIX A] \
  #v(2pt)
  #text(size: 17pt, weight: "bold", fill: rgb("#1a365d"))[
    FIELD OPERATIONS & LOGISTICS MANUAL
  ] \
  #v(3pt)
  #text(size: 9pt, style: "italic", fill: rgb("#4a5568"))[
    Truck Unload, Staging Transit, 90-Second Field Deployment, Seam Bridging, Continuous Egress, and 2026 CBA Rulebook Compliance
  ] \
  #v(6pt)
  #status-badge("APPROVED FOR FIELD OPERATIONS", rgb("#f0fff4"), rgb("#276749"), rgb("#9ae6b4"))
  #v(8pt)
]

#line(length: 100%, stroke: 0.75pt + rgb("#cbd5e0"))
#v(4pt)

== Section 1.1: Crew Roles & Division of Responsibilities

Field operations for the 4 performance stages and 4 staircases require strict coordination between adult logistical volunteers and student prop handlers under CBA Rule 4.03 and Rule 9.07 (25 field wristband limit):

#table(
  columns: (1.5fr, 1.3fr, 4.2fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 5pt, y: 3.5pt),
  [*Personnel Role*], [*Allocation*], [*Primary Responsibilities & Safety Directives*],
  [*Adult Stage Managers* \ (Job C.1)], [2 Adults \ (Field Badged)], [Supervise truck unloading, mechanical assembly, caster pin checks, vinyl wrapping, and staging transit. Escort props to rear entrance gate. Verify alignment during setup; *must exit turf before show begins* (Rule 4.03 penalty).],
  [*Student Stage Handlers* \ (Job C.2)], [16 Students \ (2 per Half-Unit)], [Assigned in pairs to labeled half-units (\#1F, \#1B, \#2F, etc.). Push units from staging to backfield queue, deploy onto field marks, lock wheel brakes, seat gap fill bridges, seal velcro vinyl flaps, and sprint off at show completion.],
  [*Student Staircase Handlers* \ (Job C.3)], [8 Students \ (2 per Staircase)], [Roll mobile staircases on side casters to backfield queue, trail stage units onto field, flip staircases upright onto rubber base feet, dock tight against stage, and retrieve during egress.],
)

#v(2pt)

== Section 1.2: Staging Logistics & Duck Blind Transport Mode

1. *Truck Offload & Assembly Area:* Scaffolding units are assembled in the trailer staging lot. Confirm all caster pins and X-brace gravity catches are fully engaged before rolling.
2. *Duck Blind Flat-Top Cargo Mode:* To maximize logistics efficiency, each of the four stages transports *four (4) collapsed Sideline Screens (Duck Blinds)* flat on top of its deck between the equipment trailer and the staging area (16 total screens). This eliminates 16 separate hand-carries across long stadium parking lots.
3. *Staging Area Rendezvous (T-45 min):* Stage Managers rendezvous with the 16 Student Stage Handlers and 8 Staircase Handlers. Duck blinds are offloaded by Duck Blind managers. Handlers verify wheel brakes are unlocked for transit.
4. *Queue Alignment:* Queue units along the perimeter track leading to the rear gate in exact numerical lineup order:
   #align(center)[
     `[Platform #1F]` -> `[Platform #1B]` -> `[Stairs #1]` | `[Platform #2F]` -> `[Platform #2B]` -> `[Stairs #2]` ...
   ]

#pagebreak()

== Section 1.3: Timed Field Entry & Docking Procedure

Under Colorado Bandmasters Association (CBA) competition timing rules, bands have a strictly enforced setup window (typically 90 seconds to 2 minutes on the turf before performance timing commences).

```text
FIELD DOCKING & SEAM CLOSURE WORKFLOW:
[Front Half 14'x5']           [Back Half 14'x5']
  Roll onto mark                Roll tight behind
  Lock wheel brakes             Lock wheel brakes
         \                             /
          v                           v
  +---------------------------------------+
  | 1. Snap Inter-Chassis Draw Latches    |  <--- Enforces exact 6.0" gap
  +---------------------------------------+
                      |
                      v
  +---------------------------------------+
  | 2. Drop In Two 82" Gap Fill Bridges   |  <--- Wood/Aluminum T-Bridge
  +---------------------------------------+
                      |
                      v
  +---------------------------------------+
  | 3. Smooth Down Center Vinyl Seam Flap |  <--- Press velcro tight
  +---------------------------------------+
                      |
                      v
  +---------------------------------------+
  | 4. Flip & Dock Mobile Staircase       |  <--- Seat tight to stage
  +---------------------------------------+
```

=== Step-by-Step Field Execution:
1. *Gate Ingress:* Upon the CBA field marshal's signal, student pairs push their units briskly through the rear entrance gate directly toward their marked field coordinates.
2. *Front Half Placement:* The Front Half (\#F) team spots their marked coordinate, aligns the front edge flush to the yard line, and *steps down firmly on all caster foot brake levers*.
3. *Back Half Docking:* The Back Half (\#B) team rolls directly behind, docks tight against the front half's rubber bumper stops, and *locks all caster foot brake levers*.
4. *Chassis Latching:* Handlers reach beneath the deck lip and *snap both over-center draw latches shut*, locking the two frames together under tension at an exact 6.0″ spacing.
5. *Gap Fill Bridge Placement:* Handlers retrieve the two *82.0″ gap fill bridges* (carried on the deck during transit) and drop them into the center seam (Bay 1 and Bay 2). Step down to confirm the bridge is fully seated flush.
6. *Vinyl Seam Closure:* Unpin the protective vinyl graphic flap from the front half, pull it taut across the gap bridge, and press it firmly down along the full-length heavy-duty velcro strip on the rear half.
7. *Staircase Docking:* Staircase handlers push the staircase into position at the designated entry point, rotate it upright onto its base pads, and press it flush against the stage frame.

#v(2pt)

== Section 1.4: Post-Performance Egress & Continuous Motion

#alert[
  *CBA RULE 5.06 & 8.05 EGRESS MANDATE:* Props must exit the competition field through the designated end zone within 2 minutes of the final cutoff. Props must maintain continuous forward rolling motion. Pausing or resting on the field triggers severe timing penalties.
]

1. *Immediate Rendezvous:* At the final chord, student handlers sprint directly to their assigned stage platform.
2. *Vinyl Flap Peel & Pin:* Pull up the velcro seam flap and pin it securely back onto the front half deck so it cannot drag on the turf during exit.
3. *Bridge Removal:* Lift both 82″ gap fill bridges and place them flat on the deck surface.
4. *Unlatch & Unlock:* Pop open both chassis draw latches. Kick all caster foot brake levers UP into the UNLOCKED position.
5. *Straight-Line Exit:* Push units in continuous motion toward the front half of the exit end zone, through the gate chute, and back to the equipment staging lot.

#pagebreak()

== Section 1.5: Structural Stability & Wind Operating Limits

Unlike vertical billboard props that present large sail areas, the Performance Stages feature a broad base stance (14 ft × 10 ft), an open lattice scaffolding structure that permits free wind passthrough, and a high deadweight (~450 lbs per complete platform).

#table(
  columns: (1.2fr, 1fr, 1.1fr, 3.7fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 5pt, y: 3.5pt),
  [*Operating Tier*], [*Sustained Wind*], [*Peak Gusts*], [*Stage Platform Action & Ballast Status*],
  [*Tier 0 / 1* \ (Normal)], [0 – 12 mph], [<= 15 mph], [Normal field operation. All 12 caster brakes locked. Zero supplemental ballast required.],
  [*Tier 2* \ (Moderate)], [12 – 16 mph], [<= 20 mph], [Normal field operation. Confirm all 12 caster brakes locked. Caster brakes provide > 300 lbf rolling resistance.],
  [*Tier 3* \ (High Wind)], [16 – 20 mph], [<= 25 mph], [Normal field operation. Platform aerodynamic tipping threshold exceeds \24.3 mph. Staircases must be locked tight.],
  [*Tier 4* \ (Safety Abort)], [> 20 mph sustained], [> 25 mph gusts], [*MANDATORY FLEET ABORT:* All props held at trailer. Performers perform on field level without stages.],
)

#v(2pt)

== Section 1.6: Governing Marching Band Rules (2026 CBA)

- *Rule 4.02 / 5.06 (Timing & Gate Movement):* 2-minute egress limit through front half of end zone. Handlers must keep moving.
- *Rule 4.03 (Adult Field Boundary):* Adults may assist with setup during the 90-second pre-show window, but *must step completely outside the field boundary lines before the performance begins*. Any adult on the field during the performance incurs a 0.5 to 2.0 point penalty.
- *Rule 8.05 (Turf Protection):* All rolling equipment must utilize smooth, non-marking, large-diameter casters (>= 6 in.). No sharp metal edges or dragging fasteners may contact the turf.
- *Rule 8.07 / 8.08 (Height & Safety Rails):* Stages under \4.0 ft deck height do not require perimeter safety railings under CBA/BOA rules; however, performers must observe safe boundary margins (>= 12 in. from edges).
- *Rule 9.07 (Field Credentials):* Exactly 25 wristbands are issued to each band for adult prop/pit crew. Stage managers must wear wristbands visibly.

#v(2pt)

== Section 1.7: Post-Use Teardown & Packout

1. *Vinyl Removal:* Carefully detach printed vinyl skirt wraps, roll graphics print-side out around shipping cores (never fold vinyl graphics, which causes permanent white creasing), and store in protective bags.
2. *Deck Plate Removal:* Lift off aluminum deck plates and stack flat in the trailer cradle.
3. *X-Brace Collapsing:* Disengage spring gravity catches, unhook X-braces from vertical pins, and fold flat.
4. *Caster Removal (if required for packing):* Pull locking wire pins from leg posts, remove stem casters, and store in dedicated hardware tote.
5. *Inventory Audit:* Account for all 12 casters, 8 X-bars, 6 verticals, 12 deck plates, and 2 gap fill bridges per stage before releasing crew.

#pagebreak()

// =========================================================================
// APPENDIX B: CONSTRUCTION, ASSEMBLY & INSPECTION MANUAL
// =========================================================================
#appendix-id.update("B")
#appendix-title.update("APPENDIX B: CONSTRUCTION & ASSEMBLY MANUAL")
#counter(page).update(1)

#set page(
  header: context {
    make-header("APPENDIX B | CONSTRUCTION & ASSEMBLY MANUAL")
  }
)

#align(center)[
  #v(10pt)
  #text(size: 11pt, weight: "bold", fill: rgb("#2b6cb0"))[APPENDIX B] \
  #v(2pt)
  #text(size: 17pt, weight: "bold", fill: rgb("#1a365d"))[
    CONSTRUCTION, ASSEMBLY & INSPECTION MANUAL
  ] \
  #v(3pt)
  #text(size: 9pt, style: "italic", fill: rgb("#4a5568"))[
    Commercial Scaffolding Components, Caster Pinning, Chaining Geometry, Gap Fill Bridge Fabrication, Cost Schedules, and QA Inspection
  ] \
  #v(6pt)
  #status-badge("CONTROLLED FABRICATION & ASSEMBLY STANDARD", rgb("#ebf8ff"), rgb("#2b6cb0"), rgb("#bee3f8"))
  #v(8pt)
]

#line(length: 100%, stroke: 0.75pt + rgb("#cbd5e0"))
#v(4pt)

== Section 2.1: Safety, PPE, and Site Preparation

All personnel involved in assembling, tearing down, or modifying stage platforms must adhere to standard shop and field safety protocols:
- *PPE:* Leather work gloves and steel-toe/composite-toe athletic boots are mandatory when handling aluminum scaffolding risers, deck plates, and steel pins.
- *Pinch Points:* Keep hands clear of scissor points when folding/unfolding aluminum X-braces and when seating aluminum deck plates onto top horizontal rails.
- *Assembly Surface:* Pre-assemble scaffolding units on flat, level asphalt, concrete, or packed gravel. Never attempt primary structural assembly on uneven slope or thick turf.

#v(2pt)

== Section 2.2: Commercial Component Schedules & Fleet Inventory

The entire performance stage system is built from *commercial off-the-shelf (COTS) modular scaffolding components*. No custom structural welding is required:

```text
FLEET COMPONENT ARCHITECTURE:
                  [Aluminum Deck Plates (3 per 7' Bay)]
                     =================================
  +------------------+-------------------------------+------------------+
  | Vertical Riser   |      Aluminum X-Brace         | Vertical Riser   |
  | (3' H x 5' W)    |      (7' Span, Folding)       | (3' H x 5' W)    |
  |                  |                               |                  |
  +--------O---------+-------------------------------+--------O---------+
     Locking Caster                                      Locking Caster
```

#table(
  columns: (1.8fr, 1.2fr, 0.8fr, 2.2fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 5pt, y: 3.5pt),
  [*Component Description*], [*Specification / Size*], [*Fleet Qty*], [*Function & Connection Mode*],
  [*Standard Vertical Risers*], [3′ 0″ H × 5′ 0″ W Aluminum], [20 pcs], [Primary vertical load-bearing frames with multi-hook pins and top deck rails.],
  [*Low-Tier Vertical Risers*], [2′ 0″ H × 5′ 0″ W Aluminum], [2 pcs], [Specialty risers for the lower tier of Stage \#4.],
  [*Folding Aluminum X-Braces*], [7′ 0″ Span (Folding)], [28 pcs], [Lateral shear bracing; hooks over riser pins with gravity safety catches.],
  [*Aluminum Deck Plates*], [7′ 0″ L × 19.5″ W (Offset lip)], [42 pcs], [Heavy-duty extruded aluminum slip-resistant walking decks (3 per 7′ bay).],
  [*Heavy-Duty Swivel Casters*], [6″–8″ Wheel w/ Locking Stem], [42 pcs], [Tubular stem inserts into vertical leg post; secured with wire lock pins.],
  [*Chassis Draw Latches*], [Over-Center Toggle Clamps], [12 pairs], [Pulls adjacent stage units tight against bumper stops at 6.0″ gap.],
  [*Gap Fill Bridge Assemblies*], [8.5″ W × 82.0″ L (Alum + Wood)], [6 units], [Bridges the 6.0″ center joint seam on Stages \#1, \#2, and \#3.],
)

#pagebreak()

== Section 2.3: Inter-Section Gap Fill Bridge Fabrication

When two 14' × 5' stage units are docked side-by-side to form a 14' × 10' stage platform, a *nominal 6.0-inch wide by 82.0-inch long open gap* exists between the walking decks along each 7-foot bay. Two (2) gap fill bridges are required per 14' × 10' stage (six [6] bridges total for the fleet).

```text
GAP FILL BRIDGE CROSS SECTION (OPTION 3 STANDARD):
                1/8" (0.125") 6061-T6 Aluminum Top Plate (8.50" Wide x 82.0" Long)
                15° Beveled Chamfer Edges (< 1/4" ADA Compliant Threshold)
                +-----------------------------------------------------------+
          15°   |                                                           |   15°
         +------+-------------------+                   +-------------------+------+
         |                          |     2x6 CORE      |                          |
+========+==========================+     (5.5" Wide    +==========================+========+
| STAGE DECK (Unit A)               |   x 1.5" Thick)   | STAGE DECK (Unit B)               |
+-----------------------------------+                   +-----------------------------------+
                                    |     x 82.0" Long) |
                                    +-------------------+
```

=== 1. Materials Required (Per Bridge Unit):
- *1x* 1/8″ (0.125″) 6061-T6 Aluminum Plate, cut to *\8.50 in. × 82.0 in.*.
- *1x* Nominal 2x6 Douglas Fir or SPF dimensional lumber board, cut to *\82.0 in.* length (actual size: \1.5 in. × 5.5 in. × 82.0 in.).
- *14x* 1/4-20 × 1-1/2″ Stainless Steel Flathead Countersunk Machine Screws.
- *14x* 1/4-20 × 1/2″ Threaded Brass/Steel Wood Inserts (or through-bolts with counterbored bottom nuts).
- *1x* Roll heavy-duty 2-inch adhesive anti-slip grip tape or velcro underlayment.

=== 2. Sheet Yield & Procurement (Full Fleet of 6 Bridges):
- *Raw Aluminum Sheet:* Sourced from a single *60 in. × 96 in. × 0.125 in. sheet* of 6061-T6 aluminum.
  - Sheared across the 60″ width into *seven (7) strips of 8.50 in. × 96 in.* (7 × 8.5 in. = 59.5 in.).
  - Cross-cut each strip to *82.0 in. length*, producing all six (6) fleet bridges plus one (1) full spare strip from a single sheet!
- *Lumber Cores:* Sourced from *three (3) 2x6 × 14-ft boards* (each 14-ft board yields two 82″ pieces with only 4″ scrap) OR *six (6) 2x6 × 8-ft boards* (trimmed to 82″).

=== 3. Step-by-Step Bridge Assembly Procedure:
1. *Bevel Aluminum Edges:* Mill, route, or grind a *\15° chamfer bevel* along the top outer edge of both 82-inch longitudinal sides. This reduces the outer edge thickness to under \1/16 in., ensuring a smooth transition that will not catch shoes.
2. *Drill & Countersink Top Holes:* Lay out 14 screw holes along two staggered rows (spaced 12″ on center, alternating 1.5″ left and right of center line). Drill with a 17/64″ bit and countersink with an 82° countersink tool so screw heads sit completely flush or slightly sub-flush with the aluminum surface.
3. *Core Preparation:* Square and trim the 2x6 lumber core to exactly \82.0 in.. Sand edges smooth.
4. *Install Threaded Inserts:* Clamp the aluminum plate centered over the 2x6 face (leaving a \1.50 in. aluminum overhang on each side). Mark hole locations into the wood, drill pilot holes, and drive 1/4-20 threaded inserts into the top face of the 2x6.
5. *Fasten Assembly:* Apply construction adhesive (Liquid Nails Fuze-It) between the wood and aluminum. Drive 1/4-20 flathead countersunk screws through the aluminum into the inserts. Confirm all screw heads are flush.
6. *Bottom Alignment Bumper:* Fasten two 1/2″ thick rubber bumper stops or 3/8″ guide dowels to the bottom ends of the 2x6 to lock the bridge longitudinally between the stage vertical risers.

#pagebreak()

== Section 2.4: Estimated Fabrication & Hardware Cost Breakdown

In strict adherence to the [PCHSMB Document Standard](../../AGENTS.md), this section itemizes all fabrication, hardware, and raw material costs associated with the Performance Stage System.

=== Table 1: Complete Fleet Hardware & Scaffolding Budget (4 Stages, 4 Stairs)

#table(
  columns: (2.2fr, 3.2fr, 0.9fr, 1.1fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if y == 8 { rgb("#ebf8ff") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 5pt, y: 2.8pt),
  [*Component / Category*], [*Key Items Included*], [*Unit Cost*], [*Fleet Total*],
  [*Commercial Scaffolding Risers*], [20x 3'x5' verticals, 2x 2'x5' verticals, 28x X-braces], [COTS], [Fleet Stock],
  [*Aluminum Deck Plates*], [42x 7'x19.5" extruded aluminum non-slip deck plates], [COTS], [Fleet Stock],
  [*Heavy-Duty Stem Casters*], [42x 6"–8" swivel locking stem casters w/ wire lock pins], [COTS], [Fleet Stock],
  [*6061-T6 Aluminum Sheet*], [1x 60" x 96" x 0.125" sheet (yields 7 strips of 8.5"x96")], [\$345.00], [\$345.00],
  [*Local Plate Shearing Labor*], [6 precision shear cuts into 8.5" strips + crosscuts to 82"], [\$35.00], [\$35.00],
  [*2x6 Structural Lumber Cores*], [6x 2x6 x 8-ft Douglas Fir boards (trimmed to 82.0")], [\$7.50], [\$45.00],
  [*Inter-Chassis Draw Latches*], [12 pairs heavy-duty adjustable over-center toggle latches], [\$5.00], [\$60.00],
  [*Countersunk Fasteners & Inserts*], [84x 1/4-20 flathead stainless screws, threaded inserts, glue], [\$30.00], [\$30.00],
  [*TOTAL BRIDGE & HARDWARE OUTLAY*], [*Complete gap fill fleet (6 bridges) & clamping latches*], [—], [*\~\$515.00*],
)

#v(2pt)

=== Table 2: Per-Stage Platform Hardware Cost Summary

#table(
  columns: (2.2fr, 3.3fr, 1.5fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else if calc.even(y) { rgb("#f7fafc") } else { white },
  inset: (x: 5pt, y: 2.8pt),
  [*Prop Unit*], [*Subsystem Components*], [*Est. Hardware Cost*],
  [*Stage Platforms \#1, \#2, \#3* (14′ × 10′)], [2x 82″ Aluminum Gap Fill Bridges, 4x Draw Latches, Fasteners], [\~\$145.00 / stage],
  [*Stage Platform \#4* (Two-Tier 5′ × 14′)], [2′ Riser hardware adaptation, Tier Step Latch], [\~\$45.00 / stage],
  [*Mobile Staircases (4 Units)*], [Replacement side casters, rubber base docking bumpers], [\~\$35.00 / staircase],
)

#v(2pt)

> *Seasonal Vinyl Wrap Expense:*  
> Custom printed vinyl skirt graphics (front wrap and side skirts) with reinforced hem grommets and heavy-duty industrial velcro seam flaps add approximately *+\$120.00 to \$160.00 per stage platform* annually depending on show graphic design and sponsor printing rates.

#pagebreak()

== Section 2.5: Step-by-Step Scaffolding Assembly Procedure

=== Stage 1: Caster Pinning & Base Upright Setup
1. *Inspect Leg Posts:* Confirm the inside of all vertical leg posts is clear of dirt or burrs.
2. *Insert Stem Casters:* Slide the tubular stem of a heavy-duty swivel caster into the bottom opening of each leg post until the shoulder seats flush against the post base.
3. *Insert Wire Lock Pins:* Align the cross-hole in the leg post with the hole in the caster stem. Push the provided wire-lock safety pin completely through and snap the wire retainer over the pin head.
4. *Engage Caster Brakes:* Immediately step down on the foot brake lever of all casters to lock the wheels while standing the vertical upright.

```text
CASTER PINNING DETAIL:
+--------------------+
| Vertical Leg Post  |
|         [O]        | <--- Wire-Lock Safety Pin
+---------+----------+
|  Caster Stem       |
+---------+----------+
|  [Brake Lever]     |
|      ( O )         | <--- 6"–8" Wheel
+--------------------+
```

---

=== Stage 2: Install Folding Aluminum X-Braces
1. *Unfold X-Brace:* Open the hinged aluminum X-brace into its full diagonal cross geometry.
2. *Hook onto Fixed Pins:* Lift one vertical riser upright. Hook the teardrop/slotted end fittings of the X-brace over the welded mounting pins on the vertical upright.
3. *Gravity Catch Engagement:* Verify the spring-loaded gravity catch snaps down over the pin, preventing the brace from accidentally lifting off during movement.
4. *Connect Opposite Upright:* Bring the second vertical riser into position (spaced 7′ 0″ away). Hook the opposite ends of the X-brace onto its pins and verify catch engagement.
5. *Install Rear X-Brace:* Repeat the process on the opposite side of the bay. The two vertical risers and two X-braces now form a rigid, freestanding 7′ L × 5′ W rectangular chassis.

---

=== Stage 3: Chaining Units End-to-End (Forming 14′ × 5′ Halves)
1. *Shared Vertical Post Pins:* The mounting pins on the vertical uprights are engineered with sufficient length to accept two stacked X-brace fittings.
2. *Add Third Vertical:* Position a third vertical riser 7′ 0″ beyond the second upright.
3. *Hook Intermediate Braces:* Hook a second set of X-braces over the outer pins of the middle vertical and connect to the third vertical.
4. *Squareness Verification:* Measure opposite diagonals across the 14-foot frame. Adjust until diagonal measurements match within ±1/8 in..

#pagebreak()

=== Stage 4: Drop Aluminum Deck Plates into Position
1. *Three Plates Per Bay:* Each 7′ 0″ bay receives exactly *three (3) extruded aluminum deck plates* running lengthwise.
2. *Seat on Horizontal Rails:* The end hooks of each deck plate rest securely on the top horizontal tube of the vertical risers.
3. *Offset Lip Feature:* The side edges of the deck plates feature an asymmetrical offset lip. When chaining bays end-to-end, the offset lips interlock without overlapping or creating an uneven height step across the joint.
4. *Locking Tabs:* Verify the underside locking tabs seat firmly over the horizontal scaffolding tubes so plates cannot slide laterally.

```text
BAY DECKING TOP VIEW (7' Long x 5' Wide):
+-----------------------------------------------------------+ 5' 0" Wide
|  DECK PLATE 1 (7' 0" Long x 19.5" Wide)                  | Top Rail
+-----------------------------------------------------------+
|  DECK PLATE 2 (7' 0" Long x 19.5" Wide)                  |
+-----------------------------------------------------------+
|  DECK PLATE 3 (7' 0" Long x 19.5" Wide)                  |
+-----------------------------------------------------------+
<----------------------- 7' 0" Long ------------------------>
```

---

=== Stage 5: Side-by-Side Docking (Forming the 14′ × 10′ Complex)
1. *Dock Units Together:* Roll Unit A (Front Half) and Unit B (Back Half) parallel to each other.
2. *Align Perimeter Faces:* Align the outer ends flush so the center seam forms a continuous line.
3. *Enforce 6.0″ Spacing:* Push the units together until the caster horns or rubber frame bumper stops make positive contact, establishing the designed *6.0-inch gap* between the decks.
4. *Lock All Casters:* Depress all twelve (12) caster wheel brakes.

---

=== Stage 6: Install Gap Fill Bridges & Inter-Chassis Latches
1. *Chassis Latching:* Reach underneath the deck edge along the front and rear perimeter frame rails. Engage the *over-center draw latches* and clamp the lever shut. This locks the two 14′ × 5′ chassis together under mechanical tension.
2. *Seat Bay 1 Bridge:* Place the first *8.5″ × 82.0″ gap fill bridge* into the center gap above Bay 1. Press down so the 2x6 core drops into the 6″ opening and the aluminum wings rest on the stage decks.
3. *Seat Bay 2 Bridge:* Place the second *8.5″ × 82.0″ gap fill bridge* into Bay 2. Confirm both bridges butt neatly together at the center upright post.
4. *Check Flushness:* Run your foot across the joint. Confirm the 15° beveled aluminum edges provide a smooth, ramped transition with zero sharp lip.

---

=== Stage 7: Assemble Two-Tier Stage \#4 (Stepped Podium)
Stage Platform \#4 features a two-tier configuration:
- *Upper Tier:* Standard \5 ft × 7 ft × 3.5 ft unit (3′ risers + casters).
- *Lower Tier:* Specialty \5 ft × 7 ft × 2.5 ft unit constructed using the *alternate 2′ 0″ vertical risers* and matching 2-foot braces.
- *Docking:* The lower tier docks against the upper tier. Inter-tier draw latches lock the two frames together. The 1.0-foot height difference creates a built-in step for soloists and dramatic staging.

#pagebreak()

== Section 2.6: Mechanical QA Acceptance & Sign-Off Protocol

Every stage platform must pass complete mechanical inspection before being cleared for rehearsal or competition:

#table(
  columns: (1.5fr, 3.5fr, 1.2fr, 0.8fr),
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: (x, y) => if y == 0 { rgb("#edf2f7") } else { none },
  inset: (x: 5pt, y: 3.2pt),
  [*Inspection Item*], [*Acceptance Criteria & Inspection Method*], [*Governing Rule*], [*Pass/Fail*],
  [*Caster Wire Pins*], [All 12 caster stems fully seated with wire retainer snapped over pin head.], [Safety Mandate], [ [  ] Pass],
  [*Caster Brake Force*], [All 12 caster brakes engage firmly; cart cannot roll under 150 lbf push.], [Rule 8.05], [ [  ] Pass],
  [*X-Brace Catches*], [All 8 folding X-braces locked over vertical pins with gravity catches engaged.], [Structural QA], [ [  ] Pass],
  [*Deck Plate Seating*], [All 12 deck plates seated on horizontal tubes; zero rocking or lateral slip.], [Safety Mandate], [ [  ] Pass],
  [*Chassis Latches*], [Both over-center draw latches clamp shut with positive spring tension.], [Mechanical QA], [ [  ] Pass],
  [*Gap Fill Bridges*], [Both 82" bridges seated flush; beveled edges smooth; zero seesaw under 250 lb step.], [Trip Hazard QA], [ [  ] Pass],
  [*Turf Clearance*], [Minimum 4.0" clearance beneath bottom rails; zero dragging fasteners or pins.], [Rule 8.05], [ [  ] Pass],
  [*Vinyl Seam Velcro*], [Velcro strip bonds continuously; bridging flap lies flat without bubbling.], [Visual Quality], [ [  ] Pass],
)

#v(4pt)

#rect(
  width: 100%,
  stroke: 0.5pt + rgb("#cbd5e0"),
  fill: rgb("#f7fafc"),
  inset: 7pt,
  radius: 3pt,
)[
  #text(weight: "bold", size: 8.8pt, fill: rgb("#1a365d"))[ANNUAL MECHANICAL SIGN-OFF SHEET:] \
  #v(2pt)
  #text(size: 8pt)[
    Stage Platform \#: \_\_\_\_\_\_\_\_\_\_ #h(1.5em) Date Inspected: \_\_\_\_\_\_\_\_\_\_ #h(1.5em) Inspector Name: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ \
    Inspector Signature: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ #h(1.5em) Prop Lead Verification: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
  ]
]

#v(4pt)

== Section 2.7: Seasonal Vinyl Wrap Preparation & Maintenance

1. *Ordering Bleed & Sizing:* Custom vinyl wraps are printed on heavy-duty 13 oz or 15 oz matte vinyl. Skirt banners measure \42.0 in. tall by the stage perimeter length (\14 ft front/back, \10 ft sides).
2. *Top Rail Attachment:* Attach vinyl along the upper perimeter rail using heavy-duty industrial carpet tape and low-profile greenhouse pipe snap clamps spaced every 18 inches.
3. *Center Seam Flap Integration:*
   - The Front Half top vinyl graphic incorporates a *\10.0 in. × 14 ft continuous overhang flap*.
   - The underside of the flap receives a 2-inch wide loop velcro strip.
   - The Back Half top deck receives matching 2-inch wide hook velcro along its leading edge.
   - *Transport Pinning:* During transport, the flap folds backward onto the Front Half deck and is held by two brass grommet pins so it cannot catch wind or drag on wheels.
4. *Cleaning & Storage:* Clean vinyl surfaces with mild dish soap and water. Never fold printed vinyl graphics; roll loosely around 4-inch PVC shipping tubes and store in protective weather bags between competitive events.

#pagebreak()

// =========================================================================
// APPENDIX C & D: FIELD PLACARDS & VOLUNTEER CHECKLIST
// =========================================================================
#appendix-id.update("C")
#appendix-title.update("APPENDIX C: FIELD PLACARD & CHECKLIST")
#counter(page).update(1)

#set page(
  header: context {
    make-header("APPENDIX C | FIELD PLACARDS & CHECKLIST")
  }
)

== Appendix C: On-Prop Laminated Field Placard (5″ × 7″)

Every stage platform half-unit must carry a laminated operations placard riveted or zip-tied to the inner vertical upright post:

#align(center)[
  #rect(
    width: 88%,
    stroke: 1.5pt + rgb("#2b6cb0"),
    fill: rgb("#ffffff"),
    radius: 4pt,
    inset: (x: 10pt, y: 7pt),
  )[
    #text(weight: "bold", size: 11pt, fill: rgb("#1a365d"))[
      PCHSMB PERFORMANCE STAGE FIELD PLACARD
    ] \
    #v(2pt)
    #text(weight: "bold", size: 9pt, fill: rgb("#2b6cb0"))[
      STAGE PLATFORM \#\_\_\_\_ — UNIT [  ] FRONT (F) #h(1.5em) [  ] BACK (B)
    ] \
    #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    #v(3pt)
    #align(left)[
      #text(size: 8pt)[
        *DEPLOYMENT CHECKLIST (90-SECOND INGRESS):* \
        1. Push to marked field coordinate. Spot front edge flush to line. \
        2. *STEP ON ALL CASTER BRAKES TO LOCK.* \
        3. Snap both inter-chassis draw latches shut along bottom rails. \
        4. Drop in both 82" aluminum gap fill bridges. Press down firmly. \
        5. Unpin vinyl flap, smooth across seam, and seal velcro tightly. \
        6. Dock staircase tight against frame. \
        \
        *RETRIEVAL CHECKLIST (2-MINUTE EGRESS):* \
        1. Pull up velcro flap and pin back onto front deck. \
        2. Remove gap fill bridges and place flat on deck. \
        3. Unclamp draw latches. Kick all caster brakes UP to unlock. \
        4. Roll in continuous straight-line motion through exit end zone. \
      ]
    ]
    #v(2pt)
    #status-badge("CBA RULE 4.03: ADULTS OFF TURF BEFORE SHOW BEGINS", rgb("#fff5f5"), rgb("#c53030"), rgb("#feb2b2"))
  ]
]

#v(8pt)

== Appendix D: Parent Volunteer Competition Day Checklist

- [  ] *T-3 Hours (Trailer Lot):* Unload scaffolding crates. Verify all 42 casters, 28 X-braces, 20 verticals, and 42 deck plates are present.
- [  ] *T-2 Hours (Assembly):* Assemble four stages. Pin all casters. Engage X-brace gravity catches. Test all wheel locks.
- [  ] *T-90 Min (Vinyl Wrap):* Install printed vinyl skirts. Fasten top rail snap clamps. Pin back center seam flap.
- [  ] *T-60 Min (Cargo Loading):* Load four (4) collapsed duck blinds flat on top of each stage. Push to staging area.
- [  ] *T-45 Min (Student Handoff):* Meet 16 student stage handlers in staging. Duck blinds offloaded. Review field marks.
- [  ] *T-15 Min (Rear Gate Queue):* Line up in exact numerical order along backfield perimeter track.
- [  ] *Field Setup:* Escort units onto turf. Spot alignment. Verify latches and bridges seated. *Exit field before opening hit.*
- [  ] *Post-Show (End Zone):* Receive stages at end zone exit gate. Reload four duck blinds per stage. Push to truck lot.
- [  ] *Post-Finals Teardown:* Remove vinyl graphics and roll on tubes. Disassemble scaffolding. Pack trailer per load diagram.
