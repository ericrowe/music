# PCHSMB Universal Field Prop Lighting Control System

The **PCHSMB Universal Field Prop Lighting Control System** is an enduring, show-agnostic field electronics and wireless lighting platform engineered for the Pine Creek High School Marching Band. It replaces single-use, ad-hoc wiring rigs with a standardized, modular infrastructure capable of synchronizing dynamic visual illumination across up to 64 independent field props (including rolling backdrops, sideline screens, performance stages, soloist platforms, kinetic props, and field tarps) on a regulation outdoor football stadium.

The system is decoupled from any single competitive production. Future band productions can completely reprogram all lighting cues, color schemes, dynamic chases, groupings, and downbeat triggers each season **without requiring software development, command-line tools, firmware compilation, or artificial intelligence prompting**.

---

## 1. System Architecture & Signal Flow

```
===================================================================================================
                                      SYSTEM SIGNAL FLOW & TOPOLOGY
===================================================================================================

[NON-TECHNICAL SHOW AUTHORING]
Band Directors & Students edit show_cues.csv in Microsoft Excel / Google Sheets
                                  │
                                  ▼
[ZERO-CODE SHOW DEPLOYMENT]
  Method A: Drag-and-drop onto Synapse USB Drive ("PCHSMB_LIGHT")
  Method B: Connect smartphone/tablet to Synapse Wi-Fi Portal (http://192.168.4.1/)
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│ SYNAPSE PIT MASTER CONSOLE (PCB-SYNAPSE-V1)                                                    │
│ • Front-Ensemble Tabletop Console (Pit Cart Accessory Rail Mount)                               │
│ • 16x 16mm Rugged Momentary Pushbuttons (Screw-Clamp Terminals, Zero Solder)                    │
│ • Dedicated Emergency Blackout E-Stop (Hardware Priority Interrupt)                            │
│ • Rotary Parameter Encoder + 128x64 Sunlight-Readable OLED Status Display                       │
│ • 3.5mm Isolated SMPTE LTC / Audio Click Track Line-In                                         │
│ • Dual-Source OR-ed Power Bus (5V USB + 7-18V Auxiliary DC)                                     │
│ • 902–928 MHz Sub-GHz ISM Broadcast Master (Semtech SX1262 Transceiver, RP-SMA Antenna)         │
└────────────────────────────────────────────────┬────────────────────────────────────────────────┘
                                                 │
                                                 │ 902–928 MHz Wireless Broadcast Link
                                                 │ Master Timecode + Cue Packets
                                                 │ Latency ≤ 25.0 ms | Jitter ≤ 5.0 ms | Range ≥ 150 m
                                                 │
                                                 ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│ PERIPHERAL PROP RECEIVER & LED DRIVER (PCB-PROP-NODE-V1) [FLEET: 1 TO 64 PROPS]               │
│ • Deployed Inside Field Props (Backdrops, Sideline Screens, Soloist Platforms, Star Tarps)     │
│ • Standard Commercial Tool Battery Input (Milwaukee M18 / DeWalt 20V, 15V–21V DC)              │
│ • High-Efficiency 5.0V / 8.0A Continuous Synchronous Buck Regulator                            │
│ • Hardware Reverse-Polarity P-FET + Hardware 15.0V Undervoltage Lockout (UVLO)                  │
│ • 16-Position BCD Hardware Rotary Address Dial (Manual Prop ID 0–15)                            │
│ • Quad-Channel 5.0V CMOS Level Shifter (74AHCT125) with 33Ω Transmission Line Resistors        │
│ • Autonomous Lost-Link Fail-Safe (Holds scene or soft fades; zero erratic strobe)              │
└────────────────────────────────────────────────┬────────────────────────────────────────────────┘
                                                 │
                                                 ▼ 4x High-Speed Damped Parallel Data Lines (5V)
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│ PROP LED FIXTURES & SURFACE ARRAYS                                                             │
│ Channel 1: Primary Outline / Perimeter Rail Extrusion (WS2812B / SK6812 / APA102)               │
│ Channel 2: Secondary Accent / Kinetic Graphic Trim                                             │
│ Channel 3: Downward Stage Deck Wash / Soloist Core Luminaire                                   │
│ Channel 4: Ground Runner / Ancillary Ribbon / Auxiliary Luminaire                              │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
===================================================================================================
```

---

## 2. Subsystem Directory Structure

```
_Lighting Controller/
├── IDEAS.md                              # Project Inbox & Engineering Backlog (HitL Workflow)
├── docs/                                 # Controlled Documentation & Schematics
│   ├── REQUIREMENTS.md                   # Authoritative Systems Requirements (INCOSE / ISO 29148)
│   ├── CARRIER_BOARD_SCHEMATICS.md       # Electrical Schematics, Pinouts & Netlists
│   ├── Lighting_Controller_Pilot_Build_BOM.pdf   # 1 Synapse + 3 Peripherals Pilot Procurement Guide
│   ├── Carrier_Board_BOM_Purchasing_Guide.pdf    # Full Fleet 30-Prop Purchasing Schedule
│   ├── project.json                      # Controlled Document Build Manifest
│   ├── AGENTS.md                         # Subproject Engineering Instructions
│   └── images/                           # High-Resolution 3D PCB Previews & Visuals
│
├── hardware/                             # Master CAD, KiCad & PCB Fabrication
│   ├── pcb_synapse_controller/           # Synapse Carrier Board KiCad Project (ERC/DRC 0 Errors)
│   ├── pcb_prop_node/                    # Prop Node Carrier Board KiCad Project (ERC/DRC 0 Errors)
│   └── build_kicad_carrier_boards.py     # Pure-Python Parametric KiCad Generator & DRC Runner
│
├── firmware/                             # Microcontroller Software & Protocol Stack
│   └── README.md                         # Dual-Core ESP32-S3 Tasking, 915 MHz Framing & DMA Engine
│
└── software/                             # Show Reprogramming & Zero-Code Authoring Suite
    ├── README.md                         # Non-Technical Authoring & Ingestion Guide
    ├── show_cues_template.csv            # Master CSV Show Cue Template (Excel / Sheets Friendly)
    └── PCHSMB_Show_Simulator.html        # Interactive Zero-Install HTML5 Field Visualizer & Validator
```

---

## 3. Hardware Subsystem Specifications

### A. Synapse Pit Master Console (`PCB-SYNAPSE-V1`)
* **Form Factor:** Compact tabletop aluminum console clamped to a front-ensemble keyboard or percussion rack rail on the front sideline.
* **Operator Interface:** 16 discrete, heavy-duty $16\,\text{mm}$ IP67 metal momentary pushbuttons arranged for two-handed fingertip triggering by a gloved student musician.
* **Zero-Solder Field Wiring:** All 16 pushbuttons connect to the carrier board via high-retention $5.08\,\text{mm}$ screw-clamp terminal blocks (`J5` and `J6`).
* **Emergency Blackout (E-Stop):** Dedicated 2-pin screw terminal (`J7`) routed to a high-priority hardware interrupt, transmitting a preemptive visual blackout packet across the entire field in $T \le 5.0\,\text{ms}$.
* **Navigation & Feedback:** 24-detent continuous rotary encoder with push switch, paired with a $128 \times 64$ sunlight-readable monochrome OLED display.
* **Audio Synchronization:** Isolated $3.5\,\text{mm}$ line-in jack for SMPTE LTC timecode or front ensemble audio click track pulse detection.
* **Dual Power OR-ing:** Operates seamlessly from either $5.0\,\text{V}$ USB or auxiliary $7.0\,\text{V}\text{–}18.0\,\text{V}$ DC with zero brownout or MCU reset when switching sources.
* **Wireless Transceiver:** Heltec V3 ESP32-S3 module with Semtech SX1262 LoRa/FSK transceiver, outputting $+22\,\text{dBm}$ into a chassis-mounted RP-SMA whip antenna.

### B. Peripheral Prop Receiver & Driver Node (`PCB-PROP-NODE-V1`)
* **Deployment:** Sealed inside weather-resistant 3D-printed enclosures mounted to field props (Rolling Backdrops, Sideline Screens, Soloist Stages, Star Tarps).
* **Power Source:** Universal commercial $18\,\text{V}$ tool battery packs (DeWalt 20V Max / Milwaukee M18, $15.0\,\text{V}\text{–}21.0\,\text{V}$ DC).
* **Step-Down Power Conversion:** Finned waterproof synchronous buck regulator delivering $5.0\,\text{V} \pm 0.15\,\text{V}$ DC regulated at up to $20.0\,\text{A}$ continuous ($100\,\text{W}$, $\ge 95\%$ efficiency).
* **Battery Protection & Safety:**
  - Hardware P-channel power MOSFET reverse-polarity protection ($V_{\text{drop}} \le 40\,\text{mV}$, survives $-24\,\text{V}$ DC indefinitely).
  - Hardware Undervoltage Lockout (UVLO) disconnecting load at $V_{\text{bat}} \le 14.8\,\text{V}$ to prevent permanent lithium cell damage.
* **Parallel Multi-Zone Driving:** Quad $5.0\,\text{V}$ CMOS level-shifted push-pull channels (`74AHCT125`) with $33\,\Omega$ series transmission line resistors, driving up to $5.0\,\text{m}$ of external cable without edge ringing.
* **Hardware Address Dial:** 4-position slide DIP switch / rotary dial allowing parent volunteers to configure prop IDs ($0\text{–}15$) in 5 seconds.

---

## 4. The Zero-Code Show Reprogramming Suite

High school marching band staff change from season to season. The PCHSMB platform enforces a strict **Zero-Software & Zero-AI Reprogramming Mandate** (**`REQ-SW-01`**):

1. **Spreadsheet Authoring:** Directors and visual coordinators edit cues in [`software/show_cues_template.csv`](software/show_cues_template.csv) using **Microsoft Excel, Google Sheets, or Apple Numbers**.
2. **Instant Browser Testing:** Double-clicking [`software/PCHSMB_Show_Simulator.html`](software/PCHSMB_Show_Simulator.html) opens an interactive 2D football field simulator in any browser. Users drag and drop their CSV file to validate syntax and test cues 1–16 on a virtual field grid in real-time.
3. **Plug-and-Play Loading:**
   - **Method A (USB Flash Drive):** Connect Synapse to any computer via USB-C. Drag and drop `show_cues.csv` onto the `PCHSMB_LIGHT` drive. Synapse validates the file upon eject and flashes its memory.
   - **Method B (Rehearsal Web Engine & LoRa-Orchestrated Wi-Fi):** During practices on shore power, an optional integrated Raspberry Pi and travel router host a full browser dashboard, waking up fleet prop Wi-Fi on demand via a LoRa command packet for zero-touch Over-The-Air show updates across all 30+ field props (see [`IDEAS.md`](IDEAS.md) — Idea 001).
4. **Error Protection:** Typos in Excel generate an immediate plain-English report (`error_log.txt` and OLED notification) pinpointing the exact row and column without crashing the system.

---

## 5. Procurement & Budget Schedules

| Scope | Assemblies Included | Estimated Total Cost | Status / Procurement Guide |
|---|---|:---:|---|
| **Pilot Bench Kit** | 1 Synapse Master + 3 Prop Nodes (4-Node Test Mesh) | **$332.25** | [View Pilot Build BOM (PDF)](docs/Lighting_Controller_Pilot_Build_BOM.pdf) |
| **Full Fleet Expansion** | 30 Prop Nodes (Fleet Backdrops, Screens, Stages) | **~$2,346.80** | [View Fleet Purchasing Guide (PDF)](docs/Carrier_Board_BOM_Purchasing_Guide.pdf) |

All components are standard, commercial off-the-shelf (COTS) parts verified in-stock at Digi-Key, Amazon, and JLCPCB. Enclosures are custom 3D-printed in shop (PETG/ASA). Antennas and cables are bundled with the Heltec ESP32-S3 modules.
