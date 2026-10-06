#set document(
  title: "PCHSMB Lighting Controller System Pilot Build Consolidated BOM — 1 Synapse + 3 Prop Nodes",
  author: "Pine Creek High School Marching Band — Systems & Electronics Engineering",
  date: auto,
)

#set page(
  paper: "us-letter",
  margin: (x: 0.50in, top: 0.50in, bottom: 0.50in),
  header: context {
    if counter(page).get().first() == 1 { return none }
    [
      #text(size: 8pt, fill: rgb("#4a5568"))[
        #grid(
          columns: (1fr, 1fr),
          align(left)[*Pine Creek High School Marching Band — Universal Field Lighting Platform*],
          align(right)[*Pilot Build Consolidated BOM: 1 Synapse + 3 Prop Nodes*]
        )
      ]
      #v(-3pt)
      #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    ]
  },
  footer: context [
    #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e0"))
    #v(2pt)
    #text(size: 7.5pt, fill: rgb("#4a5568"))[
      #grid(
        columns: (1.8fr, 1.2fr, 1fr),
        align(left)[*CONSOLIDATED PILOT KIT PROCUREMENT SCHEDULE*],
        align(center)[*Pilot Build v1.0* | October 2026],
        align(right)[Page #counter(page).display() of #counter(page).final().first()]
      )
    ]
  ]
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 8.0pt,
  fill: rgb("#1a202c")
)

#show link: underline
#show link: set text(fill: rgb("#2b6cb0"))

// =============================================================================
// PAGE 1: EXECUTIVE SUMMARY, HARDWARE ARCHITECTURE & SILICON / POWER SCHEDULE
// =============================================================================

#align(center)[
  #text(size: 15pt, weight: "bold", fill: rgb("#1a365d"))[
    PCHS Marching Band — Universal Lighting Platform
  ]
  #v(-3pt)
  #text(size: 11pt, weight: "bold", fill: rgb("#2c5282"))[
    Pilot Bench Kit BOM & Purchasing Schedule: 1 Synapse + 3 Prop Nodes
  ]
  #v(-4pt)
  #text(size: 7.8pt, style: "italic", fill: rgb("#4a5568"))[
    Cross-Referenced Component Quantities, Verified Distributor Order Links, and Consolidated Procurement Plan
  ]
]

#v(2pt)

#rect(
  width: 100%,
  fill: rgb("#f7fafc"),
  stroke: 0.75pt + rgb("#cbd5e0"),
  radius: 3pt,
  inset: (x: 8pt, y: 4.5pt)
)[
  #text(weight: "bold", size: 8.2pt, fill: rgb("#2b6cb0"))[PILOT KIT PURPOSE & CROSS-REFERENCE ARCHITECTURE] \
  #text(size: 7.5pt)[
    This consolidated bill of materials specifies all components required to build *one master Synapse Pit Controller* (`PCB-SYNAPSE-V1`) and *three peripheral Prop Receiver & Quad LED Driver nodes* (`PCB-PROP-NODE-V1`). This 4-board configuration forms the complete prototype bench test fleet (1 sideline master console, 1 rolling backdrop, 1 sideline duck blind, and 1 center stage soloist prop). Quantities are cross-referenced across both boards to determine the exact total order quantity for every part number, accounting for shared components (Heltec modules, 74AHCT125 level shifters, socket headers, screw terminals, and passives).
  ]
]

#v(3pt)

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  [
    #rect(width: 100%, stroke: 0.4pt + rgb("#cbd5e0"), radius: 2pt, inset: 4pt)[
      #grid(
        columns: (1.5fr, 1fr),
        gutter: 6pt,
        [
          #text(weight: "bold", size: 7.8pt, fill: rgb("#1a365d"))[BOARD 1: SYNAPSE PIT CONTROLLER]\
          #text(size: 7.0pt, fill: rgb("#4a5568"))[
            *Qty Needed:* 1 Board\
            *Dimensions:* 150 x 90 mm\
            *Host:* Heltec V3 ESP32-S3 LoRa\
            *Features:* Discrete 16mm IP67 metal buttons via MCP23017, dual 10-pin terminals, rotary encoder, 3.5mm line-in.
          ]
        ],
        [
          #image("images/pcb_synapse_controller_3d.png", width: 100%)
        ]
      )
    ]
  ],
  [
    #rect(width: 100%, stroke: 0.4pt + rgb("#cbd5e0"), radius: 2pt, inset: 4pt)[
      #grid(
        columns: (1.5fr, 1fr),
        gutter: 6pt,
        [
          #text(weight: "bold", size: 7.8pt, fill: rgb("#1a365d"))[BOARD 2: PROP RECEIVER & DRIVER]\
          #text(size: 7.0pt, fill: rgb("#4a5568"))[
            *Qty Needed:* 3 Boards\
            *Dimensions:* 85 x 75 mm (2 oz Cu)\
            *Host:* Heltec V3 ESP32-S3 LoRa\
            *Features:* 18V tool battery in, 5V/8A buck, IRF4905 P-FET, 4x parallel LED DMA.
          ]
        ],
        [
          #image("images/pcb_prop_node_3d.png", width: 100%)
        ]
      )
    ]
  ]
)

#v(2pt)

== 1. Master Parts Schedule: Core ICs, Wireless & Power Subsystems

#v(1pt)

#table(
  columns: (1.5fr, 1.1fr, 0.9fr, 0.4fr, 0.4fr, 0.5fr, 1.4fr, 1.8fr),
  stroke: 0.35pt + rgb("#cbd5e0"),
  inset: (x: 3.5pt, y: 3.0pt),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if calc.even(row) { rgb("#f7fafc") } else { none },
  align: (col, row) => if col in (2, 3, 4, 5) { center } else { left },
  
  [*Component & Function*], [*Mfr & Part Number*], [*Package*], [*Syn (x1)*], [*Node (x1)*], [*Total (x3)*], [*Distributor & Stock*], [*Direct Order Link*],
  
  // 1. Core Microcontrollers & Wireless
  [Heltec WiFi LoRa 32 V3 (ESP32-S3 + SX1262 w/ Antenna + Pigtail)], [Heltec HTIT-WB32LA_V3], [Module], [1], [1], [*4*], [Amazon / Heltec], [#link("https://www.amazon.com/dp/B0DRSJV1ZL")[Amazon (USD 24.99)] / #link("https://heltec.org/project/wifi-lora-32-v3/")[Heltec Direct]],
  [18-Pin 2.54mm Female Socket Header Strip], [Sullins PPTC181LFBN-RC], [TH 1x18], [2], [2], [*8*], [DigiKey S7016-ND], [#link("https://www.digikey.com/en/products/detail/sullins-connector-solutions/PPTC181LFBN-RC/810156")[DigiKey S7016-ND]],
  
  // 2. Logic & Level Shifting
  [Quad Level Shifter (3.3V to 5.0V Buffer)], [TI SN74AHCT125DR], [SOIC-14], [0], [1], [*3*], [DigiKey 296-4652-1-ND], [#link("https://www.digikey.com/en/products/detail/texas-instruments/SN74AHCT125DR/376412")[DigiKey 296-4652-1-ND]],
  [16-Bit I2C I/O Expander with Interrupts], [Microchip MCP23017-E/SO], [SOIC-28W], [1], [0], [*1*], [DigiKey MCP23017-E/SO-ND], [#link("https://www.digikey.com/en/products/detail/microchip-technology/MCP23017-E-SO/894271")[DigiKey MCP23017-E/SO]],
  
  // 3. Power Management & Circuit Protection
  [5V 20A 100W Waterproof Finned Buck Regulator], [HOMELYLIFE / Amazon (B089M5R3NJ)], [Chassis Mount], [0], [1], [*3*], [Amazon (USD 13.99)], [#link("https://www.amazon.com/dp/B089M5R3NJ")[Amazon 5V 20A Buck (B089M5R3NJ)]],
  [55V 74A P-Channel MOSFET (Reverse Prot)], [Infineon IRF4905PBF], [TO-220-3], [0], [1], [*3*], [DigiKey IRF4905PBF-ND], [#link("https://www.digikey.com/en/products/detail/infineon-technologies/IRF4905PBF/812139")[DigiKey IRF4905PBF-ND]],
  [10A Mini Blade Fuse PCB Clips], [Keystone 3568], [TH Clip], [0], [2], [*6 (3 sets)*],[DigiKey 36-3568-ND], [#link("https://www.digikey.com/en/products/detail/keystone-electronics/3568/2137306")[DigiKey 36-3568-ND]],
  [10A Mini Blade Automotive Fuse], [Littelfuse 0297010.WXNV], [Mini Blade], [0], [1], [*3 (5pk)*], [DigiKey F1784-ND], [#link("https://www.digikey.com/en/products/detail/littelfuse-inc/0297010-WXNV/146591")[DigiKey F1784-ND]],
  [24V 1500W TVS Surge Protection Diode], [Littelfuse SMCJ24A], [SMC], [0], [1], [*3*], [DigiKey SMCJ24ALFCT-ND], [#link("https://www.digikey.com/en/products/detail/littelfuse-inc/SMCJ24A/762394")[DigiKey SMCJ24ALFCT-ND]],
  [15V 300mW Zener Diode (Gate Clamp)], [Diodes Inc BZX84C15-7-F], [SOT-23], [0], [1], [*3*], [DigiKey BZX84C15-FDICT-ND], [#link("https://www.digikey.com/en/products/detail/diodes-incorporated/BZX84C15-7-F/703163")[DigiKey BZX84C15-FDICT-ND]],
  [3A 40V Schottky Barrier Diode (Power OR)], [Diodes Inc B340A-13-F], [SMA], [2], [0], [*2*], [DigiKey B340A-FDICT-ND], [#link("https://www.digikey.com/en/products/detail/diodes-incorporated/B340A-13-F/725015")[DigiKey B340A-13-F]],
  [1000uF 10V Low-ESR Radial Cap], [Panasonic EEU-FR1A102], [Rad 10x12.5], [0], [1], [*3*], [DigiKey P124221-ND], [#link("https://www.digikey.com/en/products/detail/panasonic-industry/EEU-FR1A102/9921022")[DigiKey P124221-ND]],
)

#pagebreak()

// =============================================================================
// PAGE 2: CONTROLS, CONNECTORS, PASSIVES, HARDWARE & CUSTOM PCBS
// =============================================================================

== 2. Master Parts Schedule: Controls, Connectors, Passives & Hardware

#v(1pt)

#table(
  columns: (1.5fr, 1.1fr, 0.9fr, 0.4fr, 0.4fr, 0.5fr, 1.4fr, 1.8fr),
  stroke: 0.35pt + rgb("#cbd5e0"),
  inset: (x: 3.5pt, y: 3.0pt),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if calc.even(row) { rgb("#f7fafc") } else { none },
  align: (col, row) => if col in (2, 3, 4, 5) { center } else { left },
  
  [*Component & Function*], [*Mfr & Part Number*], [*Package*], [*Syn (x1)*], [*Node (x1)*], [*Total (x3)*], [*Distributor & Stock*], [*Direct Order Link*],
  
  // 4. Operator Controls & Indicators
  [16mm IP67 Momentary Pre-Wired Buttons (Cues 1-16)], [DMWD / Amazon], [16mm Panel], [16], [0], [*16*], [Amazon (Multi-Pack)], [#link("https://www.amazon.com/dp/B0D3KXQ5KK")[Amazon 16mm Pre-Wired (B0D3KXQ5KK)]],
  [16mm IP67 Red Momentary Button (Blackout Mute)], [DMWD / Amazon], [16mm Panel], [1], [0], [*1*], [Amazon (Single / Pack)], [#link("https://www.amazon.com/dp/B0D3KXQ5KK")[Amazon 16mm Red Button]],
  [Rotary Encoder with Push Switch (Menu / Cues)], [Bourns PEC11R-4215F-S0024], [TH Vert], [1], [0], [*1*], [DigiKey PEC11R-4215F-ND], [#link("https://www.digikey.com/en/products/detail/bourns-inc/PEC11R-4215F-S0024/4499665")[DigiKey PEC11R-4215F-ND]],
  [4-Position Slide DIP Switch (Prop Node ID)], [CTS 208-4], [TH DIP-8], [0], [1], [*3*], [DigiKey CT2084-ND], [#link("https://www.digikey.com/en/products/detail/cts-electrocomponents/208-4/20783")[DigiKey CT2084-ND]],
  
  // 5. Connectors & Terminals
  [10-Pin 5.08mm Screw Terminal (Buttons 1-8 / 9-16)], [Phoenix Contact 1715802 / MKDS 1,5/10], [TH 5.08mm], [2], [0], [*2*], [DigiKey 277-1271-ND], [#link("https://www.digikey.com/en/products/detail/phoenix-contact/1715802/260635")[DigiKey 277-1271-ND]],
  [2-Pin 5.08mm Screw Terminal (Power/Trig/Blackout)], [Phoenix Contact 1715721 / MKDS 1,5/2], [TH 5.08mm], [2], [2], [*8*], [DigiKey 277-1263-ND], [#link("https://www.digikey.com/en/products/detail/phoenix-contact/1715721/260631")[DigiKey 277-1263-ND]],
  [6-Pin 5.08mm Screw Terminal (Quad LED Outputs)], [Phoenix Contact 1710726 / MKDS 1,5/6], [TH 5.08mm], [0], [2], [*6*], [DigiKey 277-1267-ND], [#link("https://www.digikey.com/en/products/detail/phoenix-contact/1710726/5198285")[DigiKey 277-1267-ND]],
  [3.5mm Stereo Audio Jack (Line / Click In)], [Same Sky SJ1-3523N], [TH RA], [1], [0], [*1*], [DigiKey CP1-3523N-ND], [#link("https://www.digikey.com/en/products/detail/same-sky-formerly-cui-devices/SJ1-3523N/738689")[DigiKey CP1-3523N-ND]],
  [4-Pin 2.54mm Breakout Pin Header Strip], [Sullins PRPC004SAAN-RC], [TH 1x4], [0], [1], [*3*], [DigiKey S1011EC-04-ND], [#link("https://www.digikey.com/en/products/detail/sullins-connector-solutions/PRPC004SAAN-RC/2775250")[DigiKey S1011EC-04-ND]],
  
  // 6. Passive Components (0805 Resistors & Capacitors)
  [100nF 50V X7R Ceramic Cap (Bypass)], [Yageo CC0805KRX7R9BB104], [SMD 0805], [1], [1], [*4 (10pk)*], [DigiKey 311-1140-1-ND], [#link("https://www.digikey.com/en/products/detail/yageo/CC0805KRX7R9BB104/302898")[DigiKey 311-1140-1-ND]],
  [47 Ohm 1/8W 1% Resistor (LED Damping)], [Yageo RC0805FR-0747RL], [SMD 0805], [0], [4], [*12 (25pk)*],[DigiKey 311-47.0RCRCT-ND], [#link("https://www.digikey.com/en/products/detail/yageo/RC0805FR-0747RL/564344")[DigiKey 311-47.0RCRCT-ND]],
  [47k Ohm 1/8W 1% Resistor (Gate Bias)], [Yageo RC0805FR-0747KL], [SMD 0805], [0], [1], [*3 (10pk)*], [DigiKey 311-47.0KCRCT-ND], [#link("https://www.digikey.com/en/products/detail/yageo/RC0805FR-0747KL/727973")[DigiKey 311-47.0KCRCT-ND]],
  [100k Ohm 1/8W 1% Resistor (Gate Pullup)],[Yageo RC0805FR-07100KL], [SMD 0805], [0], [1], [*3 (10pk)*], [DigiKey 311-100KCRCT-ND], [#link("https://www.digikey.com/en/products/detail/yageo/RC0805FR-07100KL/727544")[DigiKey 311-100KCRCT-ND]],
  
  // 7. Mechanical Hardware & Enclosures
  [M3 x 6mm Brass Standoffs + M3 Screws], [Keystone 24391], [Hardware], [4], [4], [*16*], [DigiKey 24391K-ND], [#link("https://www.digikey.com/en/products/detail/keystone-electronics/24391/1532150")[DigiKey 24391K-ND]],
  [Custom Weatherproof Enclosures (Synapse & Nodes)], [PCHSMB 3D Print (PETG/ASA)], [Custom 3D], [1], [1], [*4*], [In-House Shop 3D Print], [Shop 3D Print (PETG / ASA)],
  [DeWalt 20V Max Battery Adapter Dock], [Generic / DIY Dock Bracket with 12 AWG], [Bracket], [0], [1], [*3 (2x 2pk)*], [Amazon (USD 13.99/2pk)], [#link("https://www.amazon.com/dp/B0F483GPXL")[Amazon DeWalt 20V Adapter (B0F483GPXL)]],
  [3-Pin IP68 Waterproof LED Pigtails], [BTF-LIGHTING 20AWG], [Waterproof], [0], [4], [*12 (10-pair)*], [Amazon (USD 14.99)], [#link("https://www.amazon.com/dp/B01LCV8LGA")[Amazon BTF-LIGHTING 3-Pin Pigtails]],
  [MG Chemicals 422C Silicone Coating (Optional)], [MG Chemicals 422C-340G], [12oz Spray], [—], [—], [*Opt (1 Can)*], [DigiKey 473-422C-340G-ND], [#link("https://www.digikey.com/en/products/detail/mg-chemicals/422C-340G/14553808")[DigiKey 473-422C-340G-ND (Opt)]],
  
  // 8. Custom Printed Circuit Boards
  [PCB-SYNAPSE-V1 Custom Carrier Board], [PCHSMB KiCad 10 Master], [150x95mm], [1], [0], [*5 (Min MOQ)*], [JLCPCB / PCBWay], [Upload `pcb_synapse_controller.kicad_pcb`],
  [PCB-PROP-NODE-V1 Carrier Board (2oz Cu)],[PCHSMB KiCad 10 Master], [85x75mm], [0], [1], [*5 (Min MOQ)*], [JLCPCB / PCBWay], [Upload `pcb_prop_node.kicad_pcb` (2 oz Cu)],
)

#v(8pt)

#rect(
  width: 100%,
  fill: rgb("#f7fafc"),
  stroke: 0.5pt + rgb("#cbd5e0"),
  radius: 2pt,
  inset: 6pt
)[
  #text(weight: "bold", size: 8pt, fill: rgb("#1a365d"))[HARDWARE CROSS-REFERENCE & PACKAGING INSIGHTS:] \
  #text(size: 7.4pt)[
    • *Passive Ordering Increments:* Surface-mount 0805 passives (capacitors and resistors) are packaged in cut-tape strips of 10 or 25 pieces at DigiKey. The total order column lists the exact circuit quantity needed followed by the recommended order pack size in parentheses.\
    • *Terminal Block Flexibility:* The dual 6-pin terminal blocks on Board 2 (`J5` and `J7`) feature standard 5.08mm lead spacing, allowing either two 6-pin blocks (`MKDS 1,5/6-5,08`) or four 3-pin blocks (`MKDS 1,5/3-5,08`) snapped together side-by-side.\
    • *PCB Minimum Orders:* JLCPCB and PCBWay have a 5-board minimum manufacturing order. Building 1 Synapse and 3 Prop Nodes leaves 4 spare Synapse boards and 2 spare Prop Node boards for future fleet growth.
  ]
]

#pagebreak()

// =============================================================================
// PAGE 3: VENDOR SHOPPING LISTS, BUDGET ROLLUP & SHOP ASSEMBLY CHECKLIST
// =============================================================================

== 3. Quick-Order Shopping Summary by Vendor

#v(2pt)

#grid(
  columns: (1.25fr, 1fr),
  gutter: 12pt,
  [
    #rect(width: 100%, stroke: 0.4pt + rgb("#cbd5e0"), radius: 2pt, inset: 6pt, fill: rgb("#f7fafc"))[
      #text(weight: "bold", size: 8.2pt, fill: rgb("#1a365d"))[DigiKey Electronics Cart (Order 1):] \
      #text(size: 7.0pt)[
        • #link("https://www.digikey.com/en/products/detail/sullins-connector-solutions/PPTC181LFBN-RC/810156")[Sullins 18-Pin Socket (`PPTC181LFBN-RC`)]: *8 pcs* \
        • #link("https://www.digikey.com/en/products/detail/texas-instruments/SN74AHCT125DR/376412")[TI Level Shifter (`SN74AHCT125DR`)]: *3 pcs* \
        • #link("https://www.digikey.com/en/products/detail/microchip-technology/MCP23017-E-SO/894271")[Microchip 16-Bit Expander (`MCP23017-E/SO`)]: *1 pc* \
        • #link("https://www.digikey.com/en/products/detail/infineon-technologies/IRF4905PBF/812139")[Infineon TO-220 P-FET (`IRF4905PBF`)]: *3 pcs* \
        • #link("https://www.digikey.com/en/products/detail/keystone-electronics/3568/2137306")[Keystone Blade Fuse Clips (`3568`)]: *6 pcs (3 pr)* \
        • #link("https://www.digikey.com/en/products/detail/littelfuse-inc/0297010-WXNV/146591")[Littelfuse 10A Mini Blade Fuses (`0297010`)]: *5-pk* \
        • #link("https://www.digikey.com/en/products/detail/littelfuse-inc/SMCJ24A/762394")[Littelfuse 24V 1500W TVS (`SMCJ24A`)]: *3 pcs* \
        • #link("https://www.digikey.com/en/products/detail/diodes-incorporated/BZX84C15-7-F/703163")[Diodes Inc 15V Zener (`BZX84C15-7-F`)]: *3 pcs* \
        • #link("https://www.digikey.com/en/products/detail/diodes-incorporated/B340A-13-F/725015")[Diodes Inc 3A Schottky (`B340A-13-F`)]: *2 pcs* \
        • #link("https://www.digikey.com/en/products/detail/panasonic-industry/EEU-FR1A102/9921022")[Panasonic 1000uF 10V Low-ESR Cap (`EEU-FR1A102`)]: *3 pcs* \
        • #link("https://www.digikey.com/en/products/detail/bourns-inc/PEC11R-4215F-S0024/4499665")[Bourns Rotary Encoder (`PEC11R-4215F`)]: *1 pc* \
        • #link("https://www.digikey.com/en/products/detail/cts-electrocomponents/208-4/20783")[CTS 4-Pos Slide DIP Switch (`208-4`)]: *3 pcs* \
        • #link("https://www.digikey.com/en/products/detail/phoenix-contact/1715802/260635")[Phoenix 10-Pin Terminal (`MKDS 1,5/10-5,08`)]: *2 pcs* \
        • #link("https://www.digikey.com/en/products/detail/phoenix-contact/1715721/260631")[Phoenix 2-Pin Terminal (`MKDS 1,5/2-5,08`)]: *8 pcs* \
        • #link("https://www.digikey.com/en/products/detail/phoenix-contact/1710726/5198285")[Phoenix 6-Pin Terminal (`MKDS 1,5/6-5,08`)]: *6 pcs* \
        • #link("https://www.digikey.com/en/products/detail/same-sky-formerly-cui-devices/SJ1-3523N/738689")[Same Sky 3.5mm Audio Jack (`SJ1-3523N`)]: *1 pc* \
        • #link("https://www.digikey.com/en/products/detail/sullins-connector-solutions/PRPC004SAAN-RC/2775250")[Sullins 4-Pin Header (`PRPC004SAAN-RC`)]: *3 pcs* \
        • #link("https://www.digikey.com/en/products/detail/keystone-electronics/24391/1532150")[Keystone M3 x 6mm Standoffs (`24391`)]: *16 sets* \
        • #link("https://www.digikey.com/en/products/detail/mg-chemicals/422C-340G/14553808")[MG Chemicals Silicone Coating (`422C-340G`)]: *Optional (1 can)* \
        • 0805 Passives: #link("https://www.digikey.com/en/products/detail/yageo/CC0805KRX7R9BB104/302898")[100nF (10pk)], #link("https://www.digikey.com/en/products/detail/yageo/RC0805FR-0747RL/564344")[47Ω (25pk)], #link("https://www.digikey.com/en/products/detail/yageo/RC0805FR-0747KL/727973")[47kΩ (10pk)], #link("https://www.digikey.com/en/products/detail/yageo/RC0805FR-07100KL/727544")[100kΩ (10pk)]
      ]
      #v(3pt)
      #text(weight: "bold", size: 8.2pt, fill: rgb("#1a365d"))[Amazon Direct & COTS Cart (Order 2):] \
      #text(size: 7.0pt)[
        • #link("https://www.amazon.com/dp/B0DRSJV1ZL")[Heltec WiFi LoRa 32 V3 Boards (w/ Antenna & IPEX Cable)]: *4 units* (\$99.96) \
        • #link("https://www.amazon.com/dp/B089M5R3NJ")[HOMELYLIFE 5V 20A 100W Waterproof Buck Regulators]: *3 units* (\$41.97) \
        • #link("https://www.amazon.com/dp/B0F483GPXL")[DeWalt 20V Max Battery Dock Adapters]: *2x 2-pks* (\$27.98) \
        • #link("https://www.amazon.com/dp/B0D3KXQ5KK")[DMWD 16mm Pre-Wired Momentary Metal Buttons]: *Cues 1-16 + Red Mute* (\$22.00) \
        • #link("https://www.amazon.com/dp/B01LCV8LGA")[BTF-LIGHTING 3-Pin Waterproof Pigtails]: *10-pair pk* (\$14.99)
      ]
      #v(3pt)
      #text(weight: "bold", size: 8.2pt, fill: rgb("#1a365d"))[Fabrication & Enclosures (Orders 3 & 4):] \
      #text(size: 7.0pt)[
        • #link("https://jlcpcb.com/")[JLCPCB Custom PCBs]: 5x `PCB-SYNAPSE-V1` (\$8) + 5x `PCB-PROP-NODE-V1` (2 oz Cu, \$14) \
        • *Shop 3D-Printed Custom Enclosures:* 4 units in PETG/ASA (In-house shop print, ~\$12 filament)
      ]
    ]
  ],
  [
    == Pilot Kit Budget Rollup Table
    #v(1pt)
    #table(
      columns: (1.8fr, 0.7fr, 1.1fr),
      stroke: 0.35pt + rgb("#cbd5e0"),
      inset: (x: 4pt, y: 3.8pt),
      fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 6 { rgb("#e2e8f0") } else { none },
      align: (col, row) => if col in (1,) { center } else if col in (2,) { right } else { left },
      
      [*Procurement Source*], [*Items*], [*Estimated Cost*],
      [DigiKey Electronics Cart], [16 lines], [USD 72.85],
      [Amazon Direct & COTS Cart], [5 lines], [USD 206.90],
      [JLCPCB Prototype Fab (10 PCBs)], [2 designs], [USD 22.00],
      [Shop 3D-Printed Enclosures (PETG/ASA)], [4 cases], [USD 12.00],
      [Estimated Freight & Taxes], [Consolidated], [USD 18.50],
      [*TOTAL PILOT KIT PROCUREMENT*], [*4 Boards*], [*USD 332.25*],
    )
    
    #v(6pt)
    #rect(width: 100%, stroke: 0.5pt + rgb("#2b6cb0"), fill: rgb("#ebf8ff"), radius: 2pt, inset: 6pt)[
      #text(weight: "bold", size: 7.8pt, fill: rgb("#2b6cb0"))[PILOT BENCH FLEET READINESS] \
      #text(size: 7.2pt)[
        This \$332 pilot kit produces a fully functional, field-tested 4-node wireless mesh running on real DeWalt 20V Max tool batteries with 20A continuous power output per node and custom shop 3D-printed enclosures.
      ]
    ]
    
    #v(6pt)
    #rect(width: 100%, stroke: 0.5pt + rgb("#cbd5e0"), fill: rgb("#f7fafc"), radius: 2pt, inset: 6pt)[
      #text(weight: "bold", size: 7.8pt, fill: rgb("#1a365d"))[SHOP BENCH TESTING CHECKLIST] \
      #text(size: 7.1pt)[
        1. *DMM Power Rail Check:* Before plugging in Heltec modules, power each prop board with 18V and verify 5.00V at `J2` and `J5`/`J7`.\
        2. *Heltec Socket Alignment:* Ensure Pin 1 alignment when inserting Heltec V3 modules into female headers.\
        3. *LoRa Antenna Safety:* Connect the bundled 915 MHz antenna before transmitting to avoid damaging the SX1262 PA.\
        4. *Field Enclosure:* Mount assembled board and 5V 20A buck converter into the shop 3D-printed PETG/ASA enclosure.
      ]
    ]
  ]
)

#v(8pt)
#align(center)[
  #text(size: 7.2pt, style: "italic", fill: rgb("#718096"))[
    Pine Creek High School Marching Band • Systems & Electronics Engineering Division • Pilot Build BOM v1.0 • October 2026
  ]
]
