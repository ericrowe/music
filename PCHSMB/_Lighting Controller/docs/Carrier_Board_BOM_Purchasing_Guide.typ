#set document(
  title: "PCHSMB Field Lighting Controller System — Custom Carrier Boards Verified In-Stock BOM & Purchasing Guide",
  author: "Pine Creek High School Marching Band — Systems & Electronics Engineering",
  date: auto,
)

// Document layout and geometry (Tight 3-page engineering specification)
#set page(
  paper: "us-letter",
  margin: (x: 0.55in, top: 0.55in, bottom: 0.55in),
  header: context {
    if counter(page).get().first() == 1 { return none }
    [
      #text(size: 8pt, fill: rgb("#4a5568"))[
        #grid(
          columns: (1fr, 1fr),
          align(left)[*Pine Creek High School Marching Band — Universal Field Lighting Platform*],
          align(right)[*Custom Carrier Board Verified BOM & Purchasing Specification*]
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
        columns: (1.6fr, 1.2fr, 1fr),
        align(left)[*VERIFIED ORDERABLE COMPONENT SCHEDULE*],
        align(center)[*Release v1.0 (D1)* | October 2026],
        align(right)[Page #counter(page).display() of #counter(page).final().first()]
      )
    ]
  ]
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 8.5pt,
  fill: rgb("#1a202c")
)

#show link: underline
#show link: set text(fill: rgb("#2b6cb0"))

// =============================================================================
// PAGE 1: SYNAPSE PIT MASTER CONTROLLER (PCB-SYNAPSE-V1)
// =============================================================================

#align(center)[
  #text(size: 16pt, weight: "bold", fill: rgb("#1a365d"))[
    PCHS Marching Band — Universal Lighting Platform
  ]
  #v(-2pt)
  #text(size: 11.5pt, weight: "bold", fill: rgb("#2c5282"))[
    Custom PCB Carrier Boards: Verified In-Stock BOM & Purchasing Guide
  ]
  #v(-3pt)
  #text(size: 8pt, style: "italic", fill: rgb("#4a5568"))[
    Orderable Component Schedules & Verified Distributor Links for PCB-SYNAPSE-V1 & PCB-PROP-NODE-V1
  ]
]

#v(2pt)

#rect(
  width: 100%,
  fill: rgb("#f7fafc"),
  stroke: 0.75pt + rgb("#cbd5e0"),
  radius: 3pt,
  inset: (x: 8pt, y: 5pt)
)[
  #text(weight: "bold", size: 8.5pt, fill: rgb("#2b6cb0"))[PROCUREMENT & FOOTPRINT COMPATIBILITY VERIFICATION] \
  #text(size: 7.8pt)[
    All electronic components listed in this document have been cross-referenced against the KiCad 10 layout footprints (lead spacing, body clearances, and pad patterns) and verified in stock at authorized distributors (DigiKey, Mouser, Adafruit, Amazon). Both custom 2-layer PCBs pass Design Rules Check (DRC) with *0 errors and 0 warnings*.
  ]
]

#v(4pt)

== 1. Board 1: Synapse Pit Master Controller (`PCB-SYNAPSE-V1`)

#v(1pt)
#grid(
  columns: (1.7fr, 1fr),
  gutter: 10pt,
  [
    #text(size: 8pt)[
      *Application:* Sideline front ensemble master controller console (Concept 10). Clamped to pit keyboard rail.\
      *Dimensions:* 210.0 x 90.0 mm (8.27 x 3.54 in), 2-layer FR4, 1 oz copper, 4x M3 mounting holes.\
      *Host Platform:* Heltec WiFi LoRa 32 V3 (ESP32-S3 + Semtech SX1262 @ 915 MHz, 0.96″ OLED).\
      *Features:* 16-cue discrete 16mm IP67 metal button interface via I2C (`MCP23017`), four 8-pin pluggable headers (32 dedicated terminals w/ ground returns), rotary encoder, 3.5mm line-in.\
      *KiCad Project:* `hardware/pcb_synapse_controller/pcb_synapse_controller.kicad_pro` | *DRC: 0 Errors*
    ]
  ],
  [
    #image("images/pcb_synapse_controller_3d.png", width: 100%)
  ]
)

#v(2pt)

#table(
  columns: (0.6fr, 0.3fr, 1.8fr, 1.1fr, 1.0fr, 1.4fr, 1.8fr),
  stroke: 0.4pt + rgb("#cbd5e0"),
  inset: (x: 4pt, y: 3.2pt),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if calc.even(row) { rgb("#f7fafc") } else { none },
  align: (col, row) => if col in (0, 1, 4) { center } else { left },
  
  [*Ref*], [*Qty*], [*Description & Function*], [*Manufacturer*], [*Package*], [*Mfr Part Number*], [*Direct Order Link (Distributor)*],
  
  [MOD1], [1], [Heltec WiFi LoRa 32 V3 (ESP32-S3 + SX1262 w/ Antenna + Pigtail)], [Heltec Auto], [Module], [HTIT-WB32LA_V3], [#link("https://www.amazon.com/dp/B0DRSJV1ZL")[Amazon (USD 24.99)] / #link("https://heltec.org/project/wifi-lora-32-v3/")[Heltec Direct]],
  [J3, J4], [2], [18-Pin 2.54mm Female Socket Header Strip], [Sullins Conn], [TH 1x18], [PPTC181LFBN-RC], [#link("https://www.digikey.com/en/products/detail/sullins-connector-solutions/PPTC181LFBN-RC/810156")[DigiKey S7016-ND]],
  [U1], [1], [16-Bit I2C I/O Expander (16 Show Buttons)], [Microchip], [SOIC-28W], [MCP23017-E/SO], [#link("https://www.digikey.com/en/products/detail/microchip-technology/MCP23017-E-SO/894271")[DigiKey MCP23017-E/SO-ND]],
  [BTN1–16], [16], [16mm IP67 Momentary Pre-Wired Buttons (Cues 1-16)], [DMWD / Amazon], [16mm Panel], [16mm Pre-Wired Momentary], [#link("https://www.amazon.com/dp/B0D3KXQ5KK")[Amazon 16mm Pre-Wired (B0D3KXQ5KK)]],
  [BTN17], [1], [16mm IP67 Red Momentary Button (Blackout Mute)], [DMWD / Amazon], [16mm Panel], [16mm Pre-Wired Red], [#link("https://www.amazon.com/dp/B0D3KXQ5KK")[Amazon 16mm Red Button]],
  [J5,6,8,9], [4], [8-Pin 5.08mm Pluggable Header (Buttons 1-4..13-16)], [Phoenix / COTS], [TH 5.08mm], [MSTBA 2,5/8-G-5,08 / 2EDG], [#link("https://www.amazon.com/dp/B09D1JSMCL")[Amazon 8-Pin 10-Pk (B09D1JSMCL)] / #link("https://www.digikey.com/en/products/detail/phoenix-contact/1757307/260635")[DigiKey 1757307]],
  [J2], [1], [2-Pin 5.08mm Pluggable Header (5V DC In)], [Phoenix / COTS], [TH 5.08mm], [MSTBA 2,5/2-G-5,08 / 2EDG], [#link("https://www.amazon.com/dp/B093DV5TJ1")[Amazon 2-Pin 10-Pk (B093DV5TJ1)] / #link("https://www.digikey.com/en/products/detail/phoenix-contact/1757242/260631")[DigiKey 1757242]],
  [J10], [1], [5-Pin 5.08mm Pluggable Header (Rotary Encoder)], [Phoenix / COTS], [TH 5.08mm], [MSTBA 2,5/5-G-5,08 / 2EDG], [#link("https://www.digikey.com/en/products/detail/phoenix-contact/1757271/260632")[DigiKey 1757271 / 1757048]],
  [ENC1], [1], [Panel-Mount Rotary Encoder with Momentary Switch], [Bourns], [Panel M7], [PEC11R-4215F-S0024], [#link("https://www.digikey.com/en/products/detail/bourns-inc/PEC11R-4215F-S0024/4499665")[DigiKey PEC11R-4215F-ND]],
  [KNOB1], [1], [6mm D-Shaft Skirted Knob + M7 Sealing O-Ring], [Taiss / Amazon], [Panel HW], [6mm D-Shaft Skirted], [#link("https://www.amazon.com/dp/B07M6T35M2")[Amazon 6mm Skirted Knob]],
  [J1], [1], [3.5mm Stereo Audio Jack (Line / Click In)], [Same Sky], [TH RA], [SJ1-3523N], [#link("https://www.digikey.com/en/products/detail/same-sky-formerly-cui-devices/SJ1-3523N/738689")[DigiKey CP1-3523N-ND]],
  [C1], [1], [100nF (0.1uF) 50V X7R Ceramic Bypass Cap], [Yageo], [SMD 0805], [CC0805KRX7R9BB104], [#link("https://www.digikey.com/en/products/detail/yageo/CC0805KRX7R9BB104/302898")[DigiKey 311-1140-1-ND]],
  [H1–H4], [4], [M3 x 6mm Brass Standoffs + M3 Screws], [Keystone], [Hardware], [24391], [#link("https://www.digikey.com/en/products/detail/keystone-electronics/24391/1532150")[DigiKey 24391K-ND]],
)

#pagebreak()

// =============================================================================
// PAGE 2: PERIPHERAL PROP RECEIVER & LED DRIVER (PCB-PROP-NODE-V1)
// =============================================================================

== 2. Board 2: Peripheral Prop Receiver & LED Driver (`PCB-PROP-NODE-V1`)

#v(1pt)
#grid(
  columns: (1.7fr, 1fr),
  gutter: 10pt,
  [
    #text(size: 8pt)[
      *Application:* Mounted on all 30 field props (11 Backdrops, 16 Duck Blinds, 1 Lotus, 1 Star Tarp, 11 Solar Rays).\
      *Dimensions:* 95.0 x 90.0 mm (3.74 x 3.54 in), 2-layer FR4, *2 oz heavy copper*, 100% pluggable connectors.\
      *Battery Compatibility:* Standard commercial 18V-21V tool batteries (DeWalt 20V Max / Milwaukee M18).\
      *Protections:* 10A blade fuse, 24V 1500W TVS surge diode, and IRF4905 P-FET reverse polarity clamp (sub-0.02 ohm).\
      *KiCad Project:* `hardware/pcb_prop_node/pcb_prop_node.kicad_pro` | *DRC: 0 Errors*
    ]
  ],
  [
    #image("images/pcb_prop_node_3d.png", width: 100%)
  ]
)

#v(2pt)

#table(
  columns: (0.6fr, 0.3fr, 1.8fr, 1.1fr, 1.0fr, 1.4fr, 1.8fr),
  stroke: 0.4pt + rgb("#cbd5e0"),
  inset: (x: 4pt, y: 3.2pt),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if calc.even(row) { rgb("#f7fafc") } else { none },
  align: (col, row) => if col in (0, 1, 4) { center } else { left },
  
  [*Ref*], [*Qty*], [*Description & Function*], [*Manufacturer*], [*Package*], [*Mfr Part Number*], [*Direct Order Link (Distributor)*],
  
  [MOD1], [1], [Heltec WiFi LoRa 32 V3 (ESP32-S3 + SX1262 w/ Antenna + Pigtail)], [Heltec Auto], [Module], [HTIT-WB32LA_V3], [#link("https://www.amazon.com/dp/B0DRSJV1ZL")[Amazon (USD 24.99)] / #link("https://heltec.org/project/wifi-lora-32-v3/")[Heltec Direct]],
  [J2, J3], [2], [18-Pin 2.54mm Female Socket Header Strip], [Sullins Conn], [TH 1x18], [PPTC181LFBN-RC], [#link("https://www.digikey.com/en/products/detail/sullins-connector-solutions/PPTC181LFBN-RC/810156")[DigiKey S7016-ND]],
  [J1], [1], [2-Pin 5.08mm Pluggable Header (18V-21V Battery In)], [Phoenix / COTS], [TH 5.08mm], [MSTBA 2,5/2-G-5,08 / 2EDG], [#link("https://www.amazon.com/dp/B093DV5TJ1")[Amazon 2-Pin 10-Pk (B093DV5TJ1)] / #link("https://www.digikey.com/en/products/detail/phoenix-contact/1757242/260631")[DigiKey 1757242]],
  [F1], [1], [10A Mini Automotive Blade Fuse PCB Clips], [Keystone], [TH Clip], [3568], [#link("https://www.digikey.com/en/products/detail/keystone-electronics/3568/2137306")[DigiKey 36-3568-ND]],
  [FUSE], [1], [10A Mini Blade Automotive Fuse (Fast-Acting)], [Littelfuse], [Mini Blade], [0297010.WXNV], [#link("https://www.digikey.com/en/products/detail/littelfuse-inc/0297010-WXNV/146591")[DigiKey F1784-ND]],
  [D1], [1], [24V 1500W TVS Surge Protection Diode], [Littelfuse], [SMC], [SMCJ24A], [#link("https://www.digikey.com/en/products/detail/littelfuse-inc/SMCJ24A/762394")[DigiKey SMCJ24ALFCT-ND]],
  [Q1], [1], [55V 74A P-Channel Power MOSFET (TO-220)], [Infineon Tech], [TO-220-3], [IRF4905PBF], [#link("https://www.digikey.com/en/products/detail/infineon-technologies/IRF4905PBF/812139")[DigiKey IRF4905PBF-ND]],
  [D2], [1], [15V 300mW Zener Diode (Gate Clamp)], [Diodes Inc.], [SOT-23], [BZX84C15-7-F], [#link("https://www.digikey.com/en/products/detail/diodes-incorporated/BZX84C15-7-F/703163")[DigiKey BZX84C15-FDICT-ND]],
  [R2], [1], [100k Ohm 1/8W 1% Resistor (P-FET Gate)], [Yageo], [SMD 0805], [RC0805FR-07100KL], [#link("https://www.digikey.com/en/products/detail/yageo/RC0805FR-07100KL/727544")[DigiKey 311-100KCRCT-ND]],
  [R3], [1], [47k Ohm 1/8W 1% Resistor (P-FET Gate Bias)], [Yageo], [SMD 0805], [RC0805FR-0747KL], [#link("https://www.digikey.com/en/products/detail/yageo/RC0805FR-0747KL/727973")[DigiKey 311-47.0KCRCT-ND]],
  [REG1], [1], [5V 20A 100W Waterproof Finned Buck Regulator], [HOMELYLIFE], [Chassis Mount], [B089M5R3NJ], [#link("https://www.amazon.com/dp/B089M5R3NJ")[Amazon 5V 20A Buck (B089M5R3NJ)]],
  [C3], [1], [1000uF 10V Low-ESR Radial Electrolytic Cap], [Panasonic], [Rad 10x12.5mm], [EEU-FR1A102], [#link("https://www.digikey.com/en/products/detail/panasonic-industry/EEU-FR1A102/9921022")[DigiKey P124221-ND]],
  [U1], [1], [Quad Level Shifter (3.3V to 5.0V Buffer)], [TI], [SOIC-14], [SN74AHCT125DR], [#link("https://www.digikey.com/en/products/detail/texas-instruments/SN74AHCT125DR/376412")[DigiKey 296-4652-1-ND]],
  [R1, R4–6], [4], [47 Ohm 1/8W 1% Resistor (Quad LED Damping)], [Yageo], [SMD 0805], [RC0805FR-0747RL], [#link("https://www.digikey.com/en/products/detail/yageo/RC0805FR-0747RL/564344")[DigiKey 311-47.0RCRCT-ND]],
  [SW1], [1], [8-Position Slide DIP Switch (8-Bit Hardware Prop ID)], [CTS Corp], [TH DIP-16], [208-8], [#link("https://www.digikey.com/en/products/detail/cts-electrocomponents/208-8/20787")[DigiKey CT2088-ND]],
  [J4], [1], [2-Pin 5.08mm Pluggable Header (Performer Trigger)], [Phoenix / COTS], [TH 5.08mm], [MSTBA 2,5/2-G-5,08 / 2EDG], [#link("https://www.amazon.com/dp/B093DV5TJ1")[Amazon 2-Pin 10-Pk (B093DV5TJ1)] / #link("https://www.digikey.com/en/products/detail/phoenix-contact/1757242/260631")[DigiKey 1757242]],
  [J5, J7], [2], [6-Pin 5.08mm Pluggable Headers (Quad LED Out CH1–4)], [Phoenix Contact], [TH 5.08mm], [MSTBA 2,5/6-G-5,08 / MSTB 2,5/6-ST], [#link("https://www.digikey.com/en/products/detail/phoenix-contact/1757284/260633")[DigiKey 1757284 (Header)] / #link("https://www.digikey.com/en/products/detail/phoenix-contact/1757051/260601")[1757051 (Plug)]],
  [J6], [1], [4-Pin 2.54mm Header (I2C Diagnostic Port)], [Sullins Conn], [TH 1x4], [PRPC004SAAN-RC], [#link("https://www.digikey.com/en/products/detail/sullins-connector-solutions/PRPC004SAAN-RC/2775250")[DigiKey S1011EC-04-ND]],
  [H1–H4], [4], [M3 x 6mm Brass Standoffs + M3 Screws], [Keystone], [Hardware], [24391], [#link("https://www.digikey.com/en/products/detail/keystone-electronics/24391/1532150")[DigiKey 24391K-ND]],
)

#pagebreak()

// =============================================================================
// PAGE 3: ENCLOSURES, ACCESSORIES & BUDGET ROLLUP
// =============================================================================

== 3. Recommended Field Enclosures & Quick-Order Accessories

#table(
  columns: (1.3fr, 1.7fr, 1.1fr, 1.4fr, 1.8fr),
  stroke: 0.4pt + rgb("#cbd5e0"),
  inset: (x: 4pt, y: 3.5pt),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if calc.even(row) { rgb("#f7fafc") } else { none },
  align: (col, row) => if col in (2,) { center } else { left },
  
  [*Application*], [*Component Description*], [*Supplier*], [*Model / Part Number*], [*Direct Order Link*],
  
  [Prop Node Enclosure], [Custom 3D-Printed Weatherproof Enclosure (PETG / ASA)], [PCHSMB Shop], [Custom 3D Print], [Shop 3D Print (CAD In-House)],
  [Controller Housing], [Custom 3D-Printed Tabletop Console Case (PETG / ASA)], [PCHSMB Shop], [Custom 3D Print], [Shop 3D Print (CAD In-House)],
  [Battery Adapter], [DeWalt 20V Max Battery Adapter with 12 AWG Leads & Fuse], [Commercial / DIY], [DeWalt 20V Dock], [#link("https://www.amazon.com/dp/B0F483GPXL")[Amazon DeWalt 20V Dock (B0F483GPXL)]],
  [5V 20A Buck Regulator], [12V/24V to 5V 20A (100W) Waterproof Finned Buck Converter], [HOMELYLIFE], [B089M5R3NJ], [#link("https://www.amazon.com/dp/B089M5R3NJ")[Amazon 5V 20A Buck (B089M5R3NJ)]],
  [Pluggable 8-Pin Set], [8-Pin 5.08mm Right-Angle Terminal Blocks (10 Pairs)], [LuoQiuFa / Amazon], [B09D1JSMCL (8P RA Set)], [#link("https://www.amazon.com/dp/B09D1JSMCL")[Amazon 8-Pin Pack (USD 9.99)]],
  [Pluggable 2-Pin Set], [2-Pin 5.08mm Right-Angle Terminal Blocks (10 Pairs)], [LuoQiuFa / Amazon], [B093DV5TJ1 (2P RA Set)], [#link("https://www.amazon.com/dp/B093DV5TJ1")[Amazon 2-Pin Pack (USD 6.99)]],
  [Pluggable 6-Pin Set], [6-Pin 5.08mm Pluggable Headers + Plugs (Mating Pairs)], [Phoenix Contact], [MSTBA 2,5/6-G-5,08 & MSTB 2,5/6-ST], [#link("https://www.digikey.com/en/products/detail/phoenix-contact/1757284/260633")[DigiKey 1757284] / #link("https://www.digikey.com/en/products/detail/phoenix-contact/1757051/260601")[1757051]],
  [Conformal Coating (Opt)], [MG Chemicals 422C Silicone Conformal Coating (Weather/Dew)], [MG Chemicals], [422C-340G (12 oz Aerosol)], [#link("https://www.digikey.com/en/products/detail/mg-chemicals/422C-340G/14553808")[DigiKey 473-422C-340G-ND (Opt)]],
)

#v(14pt)

== 4. Estimated Unit & Fleet Cost Rollup (30-Prop Production Fleet)

#table(
  columns: (2.3fr, 0.8fr, 0.8fr, 1.4fr, 1.5fr),
  stroke: 0.4pt + rgb("#cbd5e0"),
  inset: (x: 5pt, y: 4.5pt),
  fill: (col, row) => if row == 0 { rgb("#edf2f7") } else if row == 5 { rgb("#e2e8f0") } else { none },
  align: (col, row) => if col in (1, 2) { center } else if col in (3, 4) { right } else { left },
  
  [*Subsystem / Board*], [*Show Units*], [*Spares*], [*Unit Cost (Parts + PCB)*], [*Total Subsystem Cost*],
  
  [PCB-SYNAPSE-V1 Master Controller (Console + Keypad + LoRa)], [1], [1], [USD 58.50], [USD 117.00],
  [PCB-PROP-NODE-V1 Receiver & LED Driver (Tool Batt + Buck + LoRa)], [30], [4], [USD 49.80], [USD 1,693.20],
  [Shop 3D-Printed Weatherproof Enclosures (PETG / ASA Filament)], [31], [5], [USD 4.00], [USD 144.00],
  [DeWalt 20V Battery Docks & BTF 3-Pin Waterproof Pigtails], [30], [4], [USD 8.50], [USD 289.00],
  [Custom 2-Layer PCB Fabrication (JLCPCB / PCBWay 2 oz Copper)], [32], [5], [USD 2.80], [USD 103.60],
  [*TOTAL FLEET ELECTRONICS PROCUREMENT BUDGET*], [*31*], [*5*], [*USD 65.19 (avg)*], [*USD 2,346.80*],
)

#v(18pt)

#rect(
  width: 100%,
  fill: rgb("#f7fafc"),
  stroke: 0.5pt + rgb("#cbd5e0"),
  radius: 3pt,
  inset: 8pt
)[
  #text(weight: "bold", size: 8.5pt, fill: rgb("#1a365d"))[FABRICATION & ASSEMBLY RECOMMENDATIONS (SHOP CREW CHECKLIST)] \
  #text(size: 8pt)[
    1. *Order PCBs with 2 oz Copper:* When uploading `pcb_prop_node.kicad_pcb` to JLCPCB or PCBWay, select *2 oz (70 µm) outer copper weight* to ensure high-current trace temperature rise remains below 10°C under continuous 8A–20A LED load.\
    2. *Conformal Coating Protocol:* After soldering and verifying power rail voltages (5.00V ± 0.05V) on the bench, spray two coats of MG Chemicals 422C silicone conformal coating over both sides of the board (masking the Heltec socket pins and screw terminal wire openings).\
    3. *Mechanical Mounting:* Secure boards into shop 3D-printed PETG/ASA enclosures using M3 brass standoffs or heat-set threaded inserts tightened to 0.5 N·m torque.
  ]
]

#v(10pt)
#align(center)[
  #text(size: 7.5pt, style: "italic", fill: rgb("#718096"))[
    Pine Creek High School Marching Band • Systems & Electronics Engineering Division • Version 1.0 • October 2026
  ]
]
