# PCHS Marching Band — Universal Field Prop Lighting Control System
# Systems Requirements Specification (SRS): Synapse Master Console, Prop Nodes, Firmware & Software

**Document Identifier:** `SRS-PCHSMB-LIGHT-001`  
**Standard Compliance:** INCOSE Guide to Writing Requirements (GtWR), ISO/IEC/IEEE 29148:2018, EARS Syntax  
**Lifecycle Status:** APPROVED BASELINE  
**Author:** Pine Creek High School Marching Band — Systems & Electronics Engineering  
**Scope:** Universal Field Prop Lighting Platform (Hardware, Firmware, Software, and Show Reprogramming)

---

## 1. Executive Summary & Platform Scope

The **PCHSMB Lighting Controller System** is an enduring, show-agnostic field electronics and lighting control platform engineered for the Pine Creek High School Marching Band. It replaces single-use, ad-hoc lighting rigs with a standardized, modular infrastructure capable of synchronizing wireless illumination across up to 64 independent field props (including rolling backdrops, sideline screens, soloist stages, kinetic props, and field tarps) on a regulation outdoor stadium.

The system is decoupled from any single competitive production. Future band productions can completely reprogram all lighting cues, color schemes, dynamic chases, groupings, and downbeat triggers each season **without requiring software development, command-line tools, firmware compilation, or artificial intelligence prompting**.

```
===================================================================================================
                                  SYSTEM ARCHITECTURE & INTERFACES
===================================================================================================

[NON-TECHNICAL SHOW AUTHORING]
Directors / Students edit show_cues.csv in Microsoft Excel / Google Sheets
                                  │
                                  ▼
[SHOW DEPLOYMENT - ZERO CODE / ZERO AI]
  Option A: Drag-and-drop file onto Synapse USB Drive (Mass Storage)
  Option B: Connect phone/tablet to Synapse Web Portal (http://192.168.4.1/)
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│ SYNAPSE MASTER CONSOLE (PCB-SYNAPSE-V1)                                                        │
│ • Front-Ensemble Tabletop Console (Pit Cart Rail Mount)                                         │
│ • 16x 16mm Rugged Momentary Pushbuttons (Screw Terminals, Zero Solder)                         │
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

## 2. Verification Method Legend

In accordance with ISO/IEC/IEEE 29148:2018, each requirement specifies one or more formal verification methods:
* **[T] Test:** Quantitative measurement using calibrated laboratory/bench equipment (oscilloscope, DMM, RF spectrum analyzer, optical photometer).
* **[D] Demonstration:** Observable qualitative operation under simulated or actual field conditions.
* **[I] Inspection:** Visual or dimensional examination of CAD geometry, schematics, PCB artwork, or physical fabrication.
* **[A] Analysis:** Engineering calculations, circuit simulations, RF link budgets, or aerodynamic/thermal modeling.

---

## 3. System-Level Operational Invariants (`REQ-SYS`)

### `REQ-SYS-01`: Field Operational Domain & Range
* **Statement:** The lighting control system shall provide reliable bidirectional wireless control and synchronization across an entire regulation American football field including end zones, corresponding to a line-of-sight slant range of $R \ge 150.0\,\text{m}$ ($492\,\text{ft}$).
* **Rationale:** Front ensemble pit controllers are stationed on the front sideline near the 50-yard line, while backfield props are positioned up to 48 yards backfield and between the opposing 15-yard lines.
* **Verification:** **[T, D]**
* **Acceptance Criteria:**
  1. Successful packet delivery at $150.0\,\text{m}$ line-of-sight with zero antenna obstruction.
  2. Packet delivery rate $\ge 99.9\%$ across 1,000 continuous broadcast transmissions.

### `REQ-SYS-02`: High-Altitude Environmental Viability
* **Statement:** All controller consoles, prop receiver nodes, connectors, and power electronics shall operate continuously without thermal shutdown or derating across an ambient temperature range of $-5.0^\circ\text{C}$ to $+40.0^\circ\text{C}$ ($23^\circ\text{F}$ to $104^\circ\text{F}$) at an altitude of $2,000\,\text{m}$ ($6,562\,\text{ft}$) above sea level.
* **Rationale:** Pine Creek High School operates in Colorado Springs (altitude $6,500\,\text{ft}$ ASL) with early season afternoon heat and late season October freeze conditions. Reduced air density impairs convective heat dissipation.
* **Verification:** **[T, A]**
* **Acceptance Criteria:**
  1. Continuous full-load operation for $60.0\,\text{min}$ at $+40.0^\circ\text{C}$ ambient.
  2. Maximum component surface temperature shall not exceed $85.0^\circ\text{C}$ on any power FET or buck inductor.

### `REQ-SYS-03`: Sub-GHz License-Free RF Band Standard
* **Statement:** The wireless communication link between the master console and all prop nodes shall operate exclusively within the United States license-free 902.0 MHz to 928.0 MHz ISM band.
* **Rationale:** The 2.4 GHz band is heavily saturated in high school and college stadiums by spectator smartphones, wireless microphones, automated timing systems, and press box Wi-Fi networks. Sub-GHz signals offer superior diffraction and field penetration.
* **Verification:** **[T, I]**
* **Acceptance Criteria:**
  1. Center carrier frequency shall be configured between $902.3\,\text{MHz}$ and $927.5\,\text{MHz}$.
  2. RF emission bandwidth shall comply with FCC Part 15.247 for license-free ISM devices.
  3. Master transmission shall not emit any energy in the 2.4 GHz spectrum.

### `REQ-SYS-04`: End-to-End Visual Downbeat Latency
* **Statement:** When an operator presses a cue button on the Synapse console, the system shall actuate the corresponding LED illumination on all field props within an end-to-end latency of $T_{\text{latency}} \le 25.0\,\text{ms}$.
* **Rationale:** Musical timing in competitive marching band requires immediate synchronization between downbeats, percussion strikes, and visual lighting bursts. Latency $> 30\,\text{ms}$ is visually detectable as a lagging drag.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Measured time from physical switch contact closure to first optical flux emission on prop LEDs shall be $\le 25.0\,\text{ms}$ at $R = 100.0\,\text{m}$.
  2. Maximum latency across 500 test trials shall not exceed $30.0\,\text{ms}$.

### `REQ-SYS-05`: Multi-Prop Synchronization Jitter
* **Statement:** The system shall synchronize lighting state transitions across all active field prop nodes such that the maximum relative visual timing skew between any two props is $T_{\text{jitter}} \le 5.0\,\text{ms}$.
* **Rationale:** When an ensemble cue triggers a full-field flash or wave, props must fire in visual unison without an uncoordinated popcorn effect across the field.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Optical photodiode measurements across 10 simultaneous receiver nodes shall show edge transition alignment within $5.0\,\text{ms}$.

### `REQ-SYS-06`: Scalable Fleet Addressing
* **Statement:** The system architecture shall support simultaneous, independent addressing and group broadcast for a minimum of 32 distinct prop nodes, scalable up to 64 prop nodes without protocol redesign.
* **Rationale:** Standard field productions utilize between 10 and 34 props, but multi-movement or joint ensemble shows require address headroom for auxiliary props.
* **Verification:** **[I, T]**
* **Acceptance Criteria:**
  1. Protocol frame supports 8-bit individual addressing ($0\text{–}63$ node IDs) and 8-bit group addressing (up to 16 functional groups).

### `REQ-SYS-07`: Marching Band Rules Compliance & Field Safety
* **Statement:** All electronics enclosures, battery fixtures, and external cabling deployed on the field shall comply with Colorado Bandmasters Association (CBA) and Bands of America (BOA) prop rules, presenting non-marking turf contact surfaces, zero liquid leakage, and zero tripping hazard.
* **Rationale:** Competition rules strictly penalize props that damage artificial turf or impede continuous rapid field entrance and egress ($< 2.0\,\text{min}$).
* **Verification:** **[I, D]**
* **Acceptance Criteria:**
  1. Zero exposed high-voltage AC mains on the competition field (all props battery-powered $\le 24.0\,\text{V}$ DC).
  2. Enclosure footpads and battery brackets use non-marking polymers (HDPE, PETG, TPU).
  3. All external wiring harness runs are secured within prop frames with zero loose loops trailing on the turf.

---

## 4. Synapse Master Console Hardware Requirements (`REQ-SYN`)

### `REQ-SYN-01`: 16-Cue Physical Fingertip Interface
* **Statement:** The Synapse console shall provide 16 discrete, momentary physical pushbutton inputs arranged in an accessible layout for rapid two-handed fingertip triggering.
* **Rationale:** A student front ensemble musician wearing performance gloves must reliably trigger cues by tactile feel without taking their eyes off the drum major.
* **Verification:** **[I, D]**
* **Acceptance Criteria:**
  1. Exactly 16 discrete momentary pushbuttons mounted on the console panel.
  2. Mounting hole diameter shall be $16.0\,\text{mm} \pm 0.2\,\text{mm}$.
  3. Minimum center-to-center button spacing shall be $\ge 25.0\,\text{mm}$ to prevent adjacent mis-triggering with gloved hands.

### `REQ-SYN-02`: Switch Contact Debounce & Registration
* **Statement:** When an operator actuates any of the 16 cue pushbuttons, the Synapse console shall register the valid actuation and initiate the corresponding wireless transmission within $5.0\,\text{ms} \le T \le 10.0\,\text{ms}$.
* **Rationale:** Fast, reliable debounce prevents multiple false triggers while preserving immediate musical response.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Digital and RC debounce filtering shall suppress switch contact chatter $< 5.0\,\text{ms}$.
  2. Zero false triggers or missed actuations across 10,000 consecutive actuations.

### `REQ-SYN-03`: Zero-Solder Screw-Clamp Panel Wiring Interface
* **Statement:** The Synapse carrier board shall interface all external panel pushbuttons, blackout switch, and auxiliary inputs via screw-clamp terminal blocks with a pin pitch of $5.08\,\text{mm} \pm 0.1\,\text{mm}$.
* **Rationale:** Eliminates delicate hand-soldering of switches in the high school shop, enables rapid field repair, and allows standard 20–24 AWG stranded hookup wire.
* **Verification:** **[I, T]**
* **Acceptance Criteria:**
  1. Terminal blocks accept stripped 20 to 24 AWG wire conductors without crimp pins or solder.
  2. Wire retention pull force shall exceed $30.0\,\text{N}$ per terminal screw torqued to $0.4\,\text{N}\cdot\text{m}$.

### `REQ-SYN-04`: Dedicated Hardware Emergency Blackout E-Stop
* **Statement:** The Synapse console shall provide a dedicated physical emergency blackout control that, when actuated, immediately commands all field prop nodes to extinguish all LED outputs.
* **Rationale:** Competition rules and field safety protocols require an instant visual blackout mechanism to abort lighting effects during performance anomalies or injuries.
* **Verification:** **[T, D]**
* **Acceptance Criteria:**
  1. The blackout switch interfaces via a dedicated 2-pin screw terminal block (`J7`) routed to a dedicated microcontroller interrupt pin.
  2. The blackout command frame preempts all scheduled lighting cues.
  3. The time from switch closure to wireless transmission of the blackout packet shall be $T \le 5.0\,\text{ms}$.

### `REQ-SYN-05`: Rotary Parameter Encoder & Menu Control
* **Statement:** The Synapse console shall feature a continuous rotary incremental encoder with an integrated momentary pushbutton switch for menu navigation, cue preview, and master brightness adjustment.
* **Rationale:** Provides rapid, glove-friendly parameter adjustment without requiring a computer or touch screen.
* **Verification:** **[I, D]**
* **Acceptance Criteria:**
  1. Rotary encoder provides 20 or 24 detents per $360^\circ$ rotation with 2-bit quadrature Gray code output.
  2. Integrated momentary push switch provides tactile feedback with actuation force $3.0\,\text{N} \pm 1.0\,\text{N}$.

### `REQ-SYN-06`: High-Contrast Sunlight-Readable OLED Status Display
* **Statement:** The Synapse console shall incorporate a high-contrast visual display readable under direct ambient sunlight ($90,000\,\text{lux}$) and darkness ($0\,\text{lux}$), presenting active cue number, cue label, battery status, and RF link health.
* **Rationale:** Marching band competitions transition from bright afternoon sun during prelims to dark stadium lights during finals.
* **Verification:** **[I, D]**
* **Acceptance Criteria:**
  1. Display resolution shall be at least $128 \times 64$ pixels with an active diagonal of $\ge 0.96\,\text{in.}$
  2. Display contrast ratio shall be $\ge 2000:1$ (monochrome yellow or white OLED).
  3. Display refresh rate shall be $\ge 10\,\text{Hz}$ with zero flicker under video cameras.

### `REQ-SYN-07`: Dual-Source OR-ed Power Bus
* **Statement:** The Synapse console shall operate from either a standard $5.0\,\text{V} \pm 0.25\,\text{V}$ USB power source or an external auxiliary DC input ranging from $7.0\,\text{V}$ to $18.0\,\text{V}$ DC, switching seamlessly between sources without resetting.
* **Rationale:** In the front ensemble pit, the console can be powered by a USB power bank or direct DC from a synthesizer cart power distribution block.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Carrier board incorporates Schottky diode OR-ing or active ideal diode OR-ing between USB and auxiliary DC.
  2. Hot-plugging or removing auxiliary DC while on USB (or vice versa) shall cause zero brownout or MCU reset ($V_{\text{drop}} < 50\,\text{mV}$).
  3. Quiescent operating current of the console shall not exceed $250\,\text{mA}$ at $5.0\,\text{V}$ DC.

### `REQ-SYN-08`: External Antenna Port & Sub-GHz Transceiver
* **Statement:** The Synapse carrier board shall provide an external $50\,\Omega$ RP-SMA antenna connector coupled to a $+22.0\,\text{dBm}$ ($160\,\text{mW}$) output power Sub-GHz transceiver.
* **Rationale:** An external high-gain whip antenna mounted outside the metal console enclosure is mandatory for full-field stadium coverage.
* **Verification:** **[I, T]**
* **Acceptance Criteria:**
  1. Chassis-mounted RP-SMA female jack with $50\,\Omega$ characteristic impedance.
  2. Transmit output power configurable up to $+22.0\,\text{dBm} \pm 1.0\,\text{dBm}$ into $50\,\Omega$ dummy load.

### `REQ-SYN-09`: Front-Ensemble Accessory Rail Mounting
* **Statement:** The Synapse console enclosure shall include mechanical mounting provisions for clamping to standard $1.5\,\text{in.}$ ($38.1\,\text{mm}$) round or square front-ensemble percussion accessory rails.
* **Rationale:** Pit carts (Yamaha, Dynasty, Titan) have standard rack rails where the controller must clamp securely without wobbling during heavy mallet play.
* **Verification:** **[I, D]**
* **Acceptance Criteria:**
  1. Enclosure base provides standard M5 or 1/4"-20 threaded brass inserts for rail clamp brackets.
  2. Withstands $15.0\,\text{G}$ vibration shocks typical of percussion cart transport over rough turf.

---

## 5. Peripheral Prop Node Hardware Requirements (`REQ-PRP`)

### `REQ-PRP-01`: Standard Commercial Tool Battery Interface
* **Statement:** Each prop receiver node shall operate from a standard commercial $18.0\,\text{V}$ nominal ($15.0\,\text{V}$ to $21.0\,\text{V}$ DC operating range) rechargeable power tool battery pack (Milwaukee M18 or DeWalt 20V Max).
* **Rationale:** Commercial power tool batteries provide high discharge rates, rugged latching housings, universal availability in the high school shop, and rapid multi-bay charging.
* **Verification:** **[I, T]**
* **Acceptance Criteria:**
  1. Receiver board accepts DC input voltage from $14.5\,\text{V}$ to $22.0\,\text{V}$ DC without component over-stress.
  2. Mates with 3D-printed or commercial battery receiver plates with locking mechanical latches.

### `REQ-PRP-02`: High-Current Step-Down Buck Regulation
* **Statement:** Each prop receiver node shall integrate a synchronous step-down switching regulator that converts $15.0\,\text{V}\text{–}21.0\,\text{V}$ battery power to a regulated $5.0\,\text{V} \pm 0.15\,\text{V}$ DC bus delivering $\ge 8.0\,\text{A}$ continuous load current at an electrical efficiency of $\ge 90.0\%$.
* **Rationale:** High-density LED strips (up to 4 channels $\times 120$ LEDs) draw up to $7.2\,\text{A}$ at full white brightness. Stable 5V regulation is required to prevent color shift and thermal failure.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Continuous output current: $I_{\text{out}} \ge 8.0\,\text{A}$ at $V_{\text{out}} = 5.0\,\text{V} \pm 0.15\,\text{V}$.
  2. Peak output ripple voltage $\le 50\,\text{mV}_{\text{p-p}}$ at full $8.0\,\text{A}$ load.
  3. Thermal rise on buck inductor and power MOSFETs $\le 45.0^\circ\text{C}$ above ambient at $8.0\,\text{A}$ continuous.

### `REQ-PRP-03`: Hardware Reverse-Polarity P-Channel MOSFET Protection
* **Statement:** The prop receiver board shall incorporate hardware reverse-polarity protection on the battery input using a P-channel power MOSFET that introduces $\le 0.05\,\text{V}$ forward voltage drop at full load and survives indefinite reverse voltage connection without damage.
* **Rationale:** Parent volunteers and students changing battery packs during rapid field prep might accidentally short or miswire terminals; diode drops waste battery energy.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Forward voltage drop at $8.0\,\text{A}$ load shall be $V_{\text{drop}} \le 40\,\text{mV}$ ($R_{\text{DS(on)}} \le 5\,\text{m}\Omega$).
  2. Application of $-24.0\,\text{V}$ DC reverse potential across input terminals for $60.0\,\text{s}$ shall result in zero damage, zero smoke, and zero current draw ($I_{\text{rev}} < 1\,\mu\text{A}$).

### `REQ-PRP-04`: Hardware Undervoltage Lockout (UVLO) Battery Protection
* **Statement:** When battery input voltage drops below $V_{\text{cut}} = 15.0\,\text{V} \pm 0.2\,\text{V}$ DC, the prop node hardware shall automatically disconnect the power buck regulator and LED load to prevent irreversible lithium-ion cell degradation.
* **Rationale:** Milwaukee M18 and DeWalt tool batteries rely on the tool to enforce low-voltage cutoff. Draining cells below $3.0\,\text{V}$ ($15.0\,\text{V}$ pack) permanently destroys battery packs.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Buck regulator output turns OFF when $V_{\text{bat}} \le 14.8\,\text{V}$ DC.
  2. Quiescent leakage current in cutoff state shall be $I_{\text{sleep}} \le 2.0\,\text{mA}$.
  3. System automatically recovers and restarts when a freshly charged battery ($\ge 16.5\,\text{V}$ DC) is connected.

### `REQ-PRP-05`: Quad Parallel 5.0V CMOS Level Shifting
* **Statement:** The prop receiver board shall provide four independent 5.0V push-pull digital output channels driven by a high-speed CMOS buffer (`74AHCT125` or equivalent) powered from the regulated 5.0V rail, converting $3.3\,\text{V}$ microcontroller logic levels to compliant $5.0\,\text{V}$ TTL/CMOS levels.
* **Rationale:** Addressable LED pixel chips (WS2812B, SK6812) require high logic level $V_{\text{IH}} \ge 0.7 \times V_{\text{DD}} = 3.5\,\text{V}$. Driving them directly with 3.3V logic causes erratic pixel flicker and signal corruption.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Output high level $V_{\text{OH}} \ge 4.5\,\text{V}$ at $I_{\text{source}} = 8.0\,\text{mA}$.
  2. Output low level $V_{\text{OL}} \le 0.4\,\text{V}$ at $I_{\text{sink}} = 8.0\,\text{mA}$.
  3. Propagation delay through buffer $\le 8.0\,\text{ns}$.

### `REQ-PRP-06`: Transmission Line Damping & Signal Integrity
* **Statement:** Each of the four LED data output lines shall incorporate a series damping resistor of $33.0\,\Omega \pm 5\%$ placed adjacent to the buffer output to match transmission line impedance and suppress ringing over external cable runs up to $5.0\,\text{m}$ ($16.4\,\text{ft}$).
* **Rationale:** Fast rise times ($< 3\,\text{ns}$) from 74AHCT buffers cause severe transmission line reflection and edge ringing over unshielded prop wiring, causing false pixel data bits.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Oscilloscope waveform at the end of a $5.0\,\text{m}$ cable shows edge overshoot $\le 10\%$ of rail voltage ($V_{\text{peak}} \le 5.5\,\text{V}$).
  2. Zero data bit errors across $1,000,000$ transmitted pixel frames.

### `REQ-PRP-07`: Physical Hardware 8-Bit DIP Switch Bank
* **Statement:** The prop receiver carrier board shall include an 8-position slide DIP switch bank (`SW1`) allowing volunteer crew members to physically set the node's unique hardware serial number ($0\text{–}255$ / `0x00`–`0xFF`) via 8 binary slide actuators without connecting a computer.
* **Rationale:** Decouples physical hardware serial identity from software show timeline profiles. Allows all fleet nodes to run identical firmware binaries and supports transparent spare substitution.
* **Verification:** **[I, D]**
* **Acceptance Criteria:**
  1. 8-position DIP switch provides 8 discrete SPST slide switches connected to ESP32-S3 GPIOs 2, 3, 4, 5, 7, 8, 9, 10.
  2. Microcontroller reads the 8-bit hardware address at boot via internal pullups ($0 = \text{ON/GND}$, $1 = \text{OFF/Pullup}$).
  3. Microcontroller maps the 8-bit serial ID to its assigned local show configuration profile (`config.bin`) stored in flash memory.

### `REQ-PRP-08`: Weatherproof Enclosure & Moisture Protection
* **Statement:** All electronics on the prop receiver node shall be protected against outdoor moisture, morning dew, grass sprinklers, and blowing dust, achieving an enclosure rating of IP65 or conformal coating protection per IPC-CC-830.
* **Rationale:** Colorado fall mornings produce heavy condensation and sprinkler overspray on practice fields.
* **Verification:** **[I, T]**
* **Acceptance Criteria:**
  1. PCB carrier board treated with silicone or acrylic conformal coating covering all SMD components.
  2. External wiring enters enclosure through sealed PG7/PG9 nylon cable glands or IP67 quick-disconnect circular connectors.

---

## 6. Firmware Requirements (`REQ-FW`)

### `REQ-FW-01`: Deterministic Real-Time Execution Partitioning
* **Statement:** The prop node and master console firmware shall partition time-critical radio communications, LED bit-banging/DMA, and background tasks across independent processor cores or deterministic execution queues such that radio packet ingestion never blocks LED frame generation.
* **Rationale:** Missing an incoming wireless cue because the CPU is blocked pushing LED bytes causes dropped cues; conversely, stalling LED transmission causes visual flicker.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Incoming radio packet receive latency is bounded to $T \le 2.0\,\text{ms}$ regardless of LED refresh rate.
  2. Zero frame tearing or dropped pixel pulses during concurrent radio reception and LED rendering.

### `REQ-FW-02`: High-Speed Multi-Channel DMA LED Rendering
* **Statement:** The prop node firmware shall utilize hardware DMA (Direct Memory Access) or peripheral state machines (e.g. I2S/RMT/SPI) to output parallel 800 kHz pixel data streams simultaneously across all 4 channels at a sustained frame rate of $\ge 60.0\,\text{frames/sec}$ with zero CPU polling loops.
* **Rationale:** Driving 4 channels of 120 pixels (480 pixels total) sequentially via bit-banging starves the CPU. Parallel DMA shifts data in hardware while the CPU prepares the next lighting frame.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Output bit timing strictly complies with WS2812B/SK6812 specifications: $T_{\text{0H}} = 350\,\text{ns} \pm 150\,\text{ns}$, $T_{\text{1H}} = 700\,\text{ns} \pm 150\,\text{ns}$, $T_{\text{reset}} \ge 50\,\mu\text{s}$.
  2. CPU utilization during 60 FPS full rendering across 4 channels shall not exceed $25.0\%$.

### `REQ-FW-03`: Wireless Broadcast Framing & Error Detection
* **Statement:** The master console broadcast protocol shall encapsulate all cue triggers, timecodes, and parametric effects into framed packets containing a 16-bit sync word, 8-bit sequence counter, payload, and 16-bit CRC (Cyclic Redundancy Check), discarding any corrupt packets at the receiver.
* **Rationale:** Electromagnetic noise from field stadium lighting, stadium PA systems, and golf cart ignitions can introduce bit flips. Corrupt packets must never cause uncontrolled light flashes.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Receiver calculates CRC-16 on every received frame; packets with mismatched CRC are dropped with zero side effects.
  2. Packet sequence counter detects dropped frames and logs link quality metrics.

### `REQ-FW-04`: Distributed Timeline Engine & Quartz Phase-Locked Clock Sync
* **Statement:** Each prop node shall execute its programmed show animation cues autonomously from local flash memory referenced to its onboard $40\,\text{MHz}$ quartz crystal oscillator. The master console shall broadcast an elapsed millisecond clock-sync heartbeat (`Frame Type = 0x02`, payload `uint32_t master_show_ms`) at $2.0\,\text{Hz}$ ($500\,\text{ms}$ interval) to phase-lock local clocks and correct sub-millisecond crystal drift.
* **Rationale:** Central real-time pixel streaming creates single-point RF failures and buffer starvation on outdoor fields. With distributed local timeline execution, RF dropouts never interrupt visual playback.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Local prop quartz crystal oscillator maintains uncorrected timeline drift $< 15.0\,\text{ms}$ across a complete 720-second (12-minute) competitive show without radio reception.
  2. Phase-Locked Loop (PLL) slews local millisecond clock smoothly toward master time for errors $|\epsilon| \le 200\,\text{ms}$ (slew rate $\le 0.5\,\text{ms/ms}$) to prevent optical tearing.
  3. Clock snaps immediately to master timecode if $|\epsilon| > 200\,\text{ms}$ (e.g. manual cue skip or console reboot).

### `REQ-FW-05`: Autonomous Lost-Link Execution & Show Continuity
* **Statement:** If a prop node fails to receive wireless sync packets from the master console for any duration during a performance, the firmware shall **not** halt, freeze, or extinguish; it shall continue autonomous execution of its programmed show cue timeline on local quartz crystal time. Only if the complete show duration has elapsed and RF remains absent shall it transition to a calm holding aesthetic or gentle fade to warm white.
* **Rationale:** RF shadowing from band members, metal props, or stadium infrastructure must never cause lighting to cut out or visually stutter before judges.
* **Verification:** **[T, D]**
* **Acceptance Criteria:**
  1. Prop continues seamless timeline execution during a continuous 60-second RF dropout.
  2. Accumulated visual phase skew between disconnected nodes remains $< 2.0\,\text{ms}$ after 60 seconds of lost link.
  3. Visual flicker, strobe, and abrupt blackout during RF loss are strictly prohibited.

### `REQ-FW-06`: Rapid Link Restoration & Cue Resynchronization
* **Statement:** When a prop node in the lost-link fail-safe state receives a valid wireless broadcast packet from the master console, it shall restore full synchronized tracking of the active show cue within $T \le 50.0\,\text{ms}$.
* **Rationale:** Ensures that temporary RF blockage (e.g. large metal field prop passing in front of antenna) recovers instantaneously once line-of-sight clears.
* **Verification:** **[T]**
* **Acceptance Criteria:**
  1. Receiver parses restored packet and updates LED output within $50.0\,\text{ms}$.

### `REQ-FW-07`: Real-Time Battery Telemetry & Visual Low-Voltage Warning
* **Statement:** The prop node firmware shall continuously measure battery pack terminal voltage via an internal ADC and, when voltage drops below $15.5\,\text{V} \pm 0.2\,\text{V}$ DC, shall display a non-obtrusive local visual warning (e.g. pulsing a single onboard diagnostic LED or amber blink on the bottom pixel) before hardware cutoff occurs.
* **Rationale:** Alerts stage managers and pit crew to swap batteries between rehearsal blocks before the prop shuts down mid-run.
* **Verification:** **[T, D]**
* **Acceptance Criteria:**
  1. Voltage measurement accuracy $\pm 0.1\,\text{V}$ DC across operating range.
  2. Visual low-voltage indicator activates when $V_{\text{bat}} \le 15.5\,\text{V}$ DC.

### `REQ-FW-08`: Power-On Self-Test (POST) & Hardware Walk Diagnostics
* **Statement:** Upon power application, the prop node firmware shall execute an automated 3-second diagnostic channel walk test, illuminating all connected LED channels sequentially through Red, Green, Blue, and White before entering the idle standby state.
* **Rationale:** Allows shop crew and field volunteers to verify all LED strips and wiring connections immediately upon plugging in the battery without needing the master console turned on.
* **Verification:** **[D, I]**
* **Acceptance Criteria:**
  1. Automated POST executes in $< 3.5\,\text{s}$ on cold boot.
  2. Identifies open circuits or dead data lines before prop rolls out of the staging chute.

### `REQ-FW-09`: Dual-Path Spare Unit Re-Mapping Protocol
* **Statement:** The system shall support rapid re-mapping of any spare receiver node's hardware serial ID to a target prop's timeline profile both off-field via a local Wi-Fi configuration portal in $T \le 2.0\,\text{s}$, and on-field via a high-priority 915 MHz configuration frame (`Frame Type = 0x05`) transmitted directly from the Synapse pit master console in $T \le 100.0\,\text{ms}$ without requiring laptops, Wi-Fi networks, or physical prop opening.
* **Rationale:** If a prop node fails on the field immediately prior to show time, pit crew must be able to deploy a spare unit and assign the damaged prop's exact cue profile instantaneously.
* **Verification:** **[T, D]**
* **Acceptance Criteria:**
  1. Off-field Wi-Fi OTA portal allows selecting and flashing any prop profile to a spare node in $< 2.0\,\text{seconds}$.
  2. Synapse pit console menu transmits Sub-GHz quick-remap frame (`Frame Type = 0x05`) re-mapping a specified hardware DIP serial to the target profile in $< 100.0\,\text{ms}$.

---

## 7. Software & Show Reprogramming Requirements (`REQ-SW`)
### *The Universal Zero-Expertise Seasonal Reprogramming Mandate*

### `REQ-SW-01`: Zero-Software & Zero-AI Seasonal Show Reprogramming Mandate
* **Statement:** The lighting control system shall enable band directors, student section leaders, and volunteer parents to author, edit, and reprogram a complete field show definition (including all cues, colors, timings, triggers, and prop group behaviors) without installing software development tools, without compiling code, without executing command-line scripts, and without artificial intelligence prompting.
* **Rationale:** Marching band staff changes yearly; relying on specialized software engineers, proprietary IDEs, or specific AI prompts guarantees system obsolescence as soon as the author graduates or leaves.
* **Verification:** **[D]**
* **Acceptance Criteria:**
  1. A complete 16-cue marching show can be authored, loaded into the Synapse console, and tested by a non-technical band director in under 15 minutes using standard office software.

### `REQ-SW-02`: Standard Human-Readable Show Definition File Format
* **Statement:** The system shall store and parse all show cues from a standardized, human-readable Comma-Separated Values (`show_cues.csv`) or structured JSON (`show_cues.json`) file adhering to a strictly defined, open tabular schema.
* **Rationale:** CSV files can be edited natively in Microsoft Excel, Google Sheets, Apple Numbers, or plain text editors on any Mac, Windows, Chromebook, iPad, or Android device.
* **Verification:** **[I, D]**
* **Acceptance Criteria:**
  1. The schema defines columns:
     * `Cue_Number` (Integer 1–16 or 1–64)
     * `Cue_Name` (Alphanumeric string $\le 20$ chars, e.g., `"Ballad_Bloom"`)
     * `Trigger_Source` (Enumeration: `BUTTON_1`–`BUTTON_16`, `AUTO_TIME`, `AUDIO_CLICK`)
     * `Trigger_Time_Sec` (Decimal seconds for time-based triggers, e.g., `184.5`)
     * `Target_Group` (Enumeration: `ALL`, `BACKDROPS`, `SCREENS`, `STAGES`, `SOLOIST`, or specific `PROP_01`–`PROP_64`)
     * `Effect_Type` (Enumeration: `STATIC`, `FADE_IN`, `FADE_OUT`, `PULSE_UP`, `CHASE_HORIZ`, `STROBE`, `SPARKLE`, `COLOR_WAVE`, `BLACKOUT`)
     * `Primary_Color` (Standard name e.g. `AMBER`, `GOLD`, `CYAN`, `WHITE`, `NAVY` or 24-bit hex `#RRGGBB`)
     * `Secondary_Color` (Color name or hex `#RRGGBB`)
     * `Duration_Sec` (Decimal seconds, e.g., `12.0`)
     * `Fade_Time_Sec` (Decimal seconds, e.g., `2.5`)
     * `Brightness_Pct` (Integer 1–100)

### `REQ-SW-03`: Direct USB Mass Storage Drag-and-Drop Ingestion
* **Statement:** When connected to any computer via standard USB cable, the Synapse console shall enumerate natively as a USB Mass Storage flash drive (labeled `PCHSMB_LIGHT`), allowing users to drag and drop `show_cues.csv` directly onto the device with zero driver installation.
* **Rationale:** Drag-and-drop file copying is universally understood by all computer users and requires zero IT permissions on school-managed laptops.
* **Verification:** **[D, T]**
* **Acceptance Criteria:**
  1. Synapse enumerates as USB drive on macOS, Windows 10/11, ChromeOS, and Linux without specialized drivers.
  2. Dragging a valid `show_cues.csv` to the drive and safely ejecting triggers automatic parsing, non-volatile flash storage, and OLED confirmation: `"SHOW LOADED: 16 CUES OK"`.

### `REQ-SW-04`: Self-Contained Offline Web Configurator (SoftAP Mode)
* **Statement:** The Synapse console shall provide an integrated Wi-Fi Soft Access Point (SoftAP) mode that serves an offline, mobile-responsive Web Configurator portal at `http://192.168.4.1/`, allowing smartphone, tablet, or laptop connection without internet or external routers.
* **Rationale:** During field rehearsals, directors need to tweak cue timings or colors directly from the sideline or press box using their phone or iPad without returning to a computer.
* **Verification:** **[D, T]**
* **Acceptance Criteria:**
  1. Selecting `"CONFIG MODE"` via the rotary encoder launches Wi-Fi SoftAP `"PCHSMB-Lighting-Config"`.
  2. Navigating to `http://192.168.4.1/` renders an interactive visual show editor displaying:
     * Interactive cue timeline with color pickers and duration sliders.
     * Live `"Test Cue on Field"` button to preview lighting on props in real-time.
     * One-click `"Upload CSV"` and `"Download CSV"` backup buttons.
     * Fleet diagnostics panel showing battery voltages and RF link RSSI for all props.
  3. All web assets (HTML/CSS/JS) are self-contained in onboard flash with zero external internet dependencies.

### `REQ-SW-05`: Over-the-Air Parametric Show Distribution
* **Statement:** The system shall broadcast lighting cues as high-level parametric commands (effect type, color palette, speed, duration) over the 915 MHz RF link during the performance, eliminating any requirement to tether, physically connect, or reflash individual prop nodes when show cues are modified.
* **Rationale:** Physical prop nodes remain permanently sealed inside 30+ props scattered across the field. Changing a show profile must be 100% centralized at the Synapse console.
* **Verification:** **[D, T]**
* **Acceptance Criteria:**
  1. Modifying a cue in `show_cues.csv` at the Synapse console alters the lighting behavior of all props immediately upon the next cue trigger without touching any prop node.

### `REQ-SW-06`: Automated Schema Validation & Plain-English Error Reporting
* **Statement:** If an uploaded `show_cues.csv` file contains syntax errors, invalid color codes, missing required columns, or out-of-range numerical values, the Synapse system shall reject the corrupted file, retain the previous valid show profile in memory, and generate a plain-English error log (`error_log.txt`) specifying the exact row and column of the mistake.
* **Rationale:** A syntax typo in Excel must never crash the console or leave the props unresponsive on the competition field.
* **Verification:** **[T, D]**
* **Acceptance Criteria:**
  1. Uploading a CSV with an invalid color (e.g. `"bluish"`) or brightness `"150%"` produces an immediate OLED warning: `"LOAD ERROR: ROW 4 - SEE LOG"`.
  2. The generated `error_log.txt` on the USB drive states: `"Error in Row 4: Brightness '150%' exceeds maximum 100%."`
  3. The controller continues running the last known good show profile without interruption.

### `REQ-SW-07`: Non-Volatile Profile Storage & Rapid Show Switching
* **Statement:** The Synapse console shall store at least four independent complete show profiles in onboard non-volatile flash memory, selectable via the rotary menu encoder in $< 5.0\,\text{seconds}$.
* **Rationale:** Allows the band to store separate profiles for Preliminary performances, Finals shows, Halftime football games, and Stand Tunes on a single console without reloading files.
* **Verification:** **[D, T]**
* **Acceptance Criteria:**
  1. Rotary menu provides selection between `"SHOW 1: COMPETITION"`, `"SHOW 2: HALFTIME"`, `"SHOW 3: STAND TUNES"`, `"SHOW 4: REHEARSAL"`.
  2. Switching active profile loads all 16 cue definitions into active memory in $< 1.0\,\text{s}$.

### `REQ-SW-08`: Standalone Desktop Offline Simulator & Validator
* **Statement:** The system software suite shall provide a standalone, zero-installation HTML5/JavaScript offline simulator application that allows show designers to load `show_cues.csv`, validate syntax, and preview simulated 2D prop lighting animations on a virtual football field grid directly in any web browser.
* **Rationale:** Enables visual designers to preview and verify show lighting pacing at home before field rehearsal.
* **Verification:** **[D]**
* **Acceptance Criteria:**
  1. Single-file offline HTML application (`PCHSMB_Show_Simulator.html`) runs locally in Chrome, Safari, Edge, or Firefox without internet access.
  2. Renders accurate color playback, timing chases, and fade transitions matching physical prop hardware.

---

## 8. Requirements Traceability Matrix (RTM)

| Requirement ID | Subsystem | Title / Description | EARS Pattern | Verification Method | Acceptance Standard |
| :--- | :--- | :--- | :--- | :--- | :---: | :--- |
| `REQ-SYS-01` | System | Field Operational Domain & Range | Ubiquitous | **[T, D]** | $\ge 150.0\,\text{m}$ slant range; $\ge 99.9\%$ delivery |
| `REQ-SYS-02` | System | High-Altitude Environmental Viability | Ubiquitous | **[T, A]** | $-5^\circ\text{C}$ to $+40^\circ\text{C}$ at $6,500\,\text{ft}$ ASL |
| `REQ-SYS-03` | System | Sub-GHz License-Free RF Band Standard | Ubiquitous | **[T, I]** | 902.0–928.0 MHz ISM band; zero 2.4 GHz |
| `REQ-SYS-04` | System | End-to-End Visual Downbeat Latency | Event-Driven | **[T]** | $T_{\text{latency}} \le 25.0\,\text{ms}$ at $100\,\text{m}$ |
| `REQ-SYS-05` | System | Multi-Prop Synchronization Jitter | Ubiquitous | **[T]** | $T_{\text{jitter}} \le 5.0\,\text{ms}$ across all nodes |
| `REQ-SYS-06` | System | Scalable Fleet Addressing & 8-Bit Space | Ubiquitous | **[I, T]** | $\ge 32$ nodes supported, scalable to 256 |
| `REQ-SYS-07` | System | Marching Band Rules Compliance | Ubiquitous | **[I, D]** | CBA/BOA compliant; non-marking; $< 2\,\text{min}$ egress |
| `REQ-SYN-01` | Synapse | 16-Cue Physical Fingertip Interface | Ubiquitous | **[I, D]** | 16x 16mm momentary buttons, spacing $\ge 25\,\text{mm}$ |
| `REQ-SYN-02` | Synapse | Switch Contact Debounce & Registration | Event-Driven | **[T]** | $5.0\,\text{ms} \le T \le 10.0\,\text{ms}$; zero false triggers |
| `REQ-SYN-03` | Synapse | Zero-Solder Screw-Clamp Panel Wiring | Ubiquitous | **[I, T]** | 5.08mm terminal blocks; retention $\ge 30\,\text{N}$ |
| `REQ-SYN-04` | Synapse | Dedicated Emergency Blackout E-Stop | Event-Driven | **[T, D]** | Priority interrupt; $T \le 5.0\,\text{ms}$ to transmission |
| `REQ-SYN-05` | Synapse | Rotary Parameter Encoder & Menu Control | Ubiquitous | **[I, D]** | 20–24 detent quadrature encoder with push switch |
| `REQ-SYN-06` | Synapse | Sunlight-Readable OLED Status Display | Ubiquitous | **[I, D]** | $128 \times 64$ OLED; contrast $\ge 2000:1$; sunlight readable |
| `REQ-SYN-07` | Synapse | Dual-Source OR-ed Power Bus | Ubiquitous | **[T]** | Seamless 5V USB / 7–18V DC OR-ing; $V_{\text{drop}} < 50\,\text{mV}$ |
| `REQ-SYN-08` | Synapse | External Antenna Port & Sub-GHz Transceiver | Ubiquitous | **[I, T]** | $50\,\Omega$ RP-SMA port; $+22.0\,\text{dBm}$ max power |
| `REQ-SYN-09` | Synapse | Front-Ensemble Accessory Rail Mounting | Ubiquitous | **[I, D]** | Clamps to $1.5\,\text{in.}$ pit rail; withstands $15\,\text{G}$ |
| `REQ-PRP-01` | Prop Node | Standard Commercial Tool Battery Interface | Ubiquitous | **[I, T]** | Milwaukee M18 / DeWalt 20V (15.0–21.0V DC) |
| `REQ-PRP-02` | Prop Node | High-Current Step-Down Buck Regulation | Ubiquitous | **[T]** | $5.0\,\text{V} \pm 0.15\,\text{V}$ at $\ge 8.0\,\text{A}$; $\ge 90\%$ efficiency |
| `REQ-PRP-03` | Prop Node | Reverse-Polarity P-FET Protection | Ubiquitous | **[T]** | $V_{\text{drop}} \le 40\,\text{mV}$; survives $-24.0\,\text{V}$ reverse |
| `REQ-PRP-04` | Prop Node | Hardware Undervoltage Lockout (UVLO) | State-Driven | **[T]** | Disconnects at $V \le 14.8\,\text{V}$; sleep current $\le 2\,\text{mA}$ |
| `REQ-PRP-05` | Prop Node | Quad Parallel 5.0V CMOS Level Shifting | Ubiquitous | **[T]** | 4x 74AHCT125 channels; $V_{\text{OH}} \ge 4.5\,\text{V}$ |
| `REQ-PRP-06` | Prop Node | Transmission Line Damping & Signal Integrity | Ubiquitous | **[T]** | $33\,\Omega$ series resistors; clean edges over $5.0\,\text{m}$ |
| `REQ-PRP-07` | Prop Node | Physical Hardware 8-Bit DIP Switch Bank | Ubiquitous | **[I, D]** | 8-position slide DIP switch ($0\text{–}255$ hardware ID) |
| `REQ-PRP-08` | Prop Node | Weatherproof Enclosure & Moisture Protection | Ubiquitous | **[I, T]** | IP65 enclosure / IPC-CC-830 conformal coating |
| `REQ-FW-01` | Firmware | Deterministic Real-Time Execution Partitioning | Ubiquitous | **[T]** | Radio latency $\le 2.0\,\text{ms}$; zero LED frame tearing |
| `REQ-FW-02` | Firmware | High-Speed Multi-Channel DMA LED Rendering | Ubiquitous | **[T]** | 4-channel parallel DMA; $\ge 60\,\text{FPS}$; CPU $\le 25\%$ |
| `REQ-FW-03` | Firmware | Wireless Broadcast Framing & Error Detection | Event-Driven | **[T]** | 16-bit sync, sequence counter, CRC-16 integrity |
| `REQ-FW-04` | Firmware | Distributed Timeline Engine & Quartz Phase Sync | Ubiquitous | **[T]** | Crystal drift $< 15\,\text{ms}$ over 720s; PLL slew $\le 0.5\,\text{ms/ms}$ |
| `REQ-FW-05` | Firmware | Autonomous Lost-Link Execution & Continuity | Unwanted Event | **[T, D]** | Seamless local timeline playback; zero visual stutter |
| `REQ-FW-06` | Firmware | Rapid Link Restoration & Resynchronization | Event-Driven | **[T]** | Restores cue tracking within $T \le 50.0\,\text{ms}$ |
| `REQ-FW-07` | Firmware | Real-Time Battery Telemetry & Low-V Warning | State-Driven | **[T, D]** | Visual alert when $V_{\text{bat}} \le 15.5\,\text{V}$ DC |
| `REQ-FW-08` | Firmware | Power-On Self-Test (POST) & Channel Walk | Event-Driven | **[D, I]** | R-G-B-W channel walk in $< 3.5\,\text{s}$ on cold boot |
| `REQ-FW-09` | Firmware | Dual-Path Spare Unit Re-Mapping Protocol | Event-Driven | **[T, D]** | Wi-Fi OTA $< 2.0\,\text{s}$; 915 MHz quick-remap $< 100\,\text{ms}$ |
| `REQ-SW-01` | Software | Zero-Software & Zero-AI Reprogramming Mandate | Ubiquitous | **[D]** | Full show reprogramming in $< 15\,\text{min}$ with no code/AI |
| `REQ-SW-02` | Software | Standard Human-Readable Show Definition File | Ubiquitous | **[I, D]** | Schema-validated CSV / JSON editable in Excel/Sheets |
| `REQ-SW-03` | Software | Direct USB Mass Storage Drag-and-Drop Ingestion | Event-Driven | **[D, T]** | Mounts as USB flash drive; automatic parsing upon eject |
| `REQ-SW-04` | Software | Self-Contained Offline Web Configurator (SoftAP) | Ubiquitous | **[D, T]** | Mobile Web UI at `192.168.4.1`; zero internet needed |
| `REQ-SW-05` | Software | Over-the-Air Parametric Show Distribution | Ubiquitous | **[D, T]** | Zero prop tethering needed; live wireless parameters |
| `REQ-SW-06` | Software | Automated Schema Validation & Error Reporting | Unwanted Event | **[T, D]** | Rejects bad files; writes `error_log.txt`; OLED row alert |
| `REQ-SW-07` | Software | Non-Volatile Profile Storage & Show Switching | Ubiquitous | **[D, T]** | $\ge 4$ stored shows; switch profile in $< 5.0\,\text{s}$ |
| `REQ-SW-08` | Software | Standalone Desktop Offline Simulator | Ubiquitous | **[D]** | Offline HTML5/JS field simulator and syntax validator |


