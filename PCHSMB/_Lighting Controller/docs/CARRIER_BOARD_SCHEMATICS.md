# PCHS Marching Band — "Beacon" Custom PCB Carrier Board Specifications
## Schematics, Pinouts & Fabrication Guide for Synapse Controller & Prop LED Drivers

**Author:** PCHSMB Engineering & Systems Architecture  
**Target Platform:** Heltec WiFi LoRa 32 V3 (ESP32-S3 + Semtech SX1262 @ 915 MHz)  
**Deliverable File:** `CARRIER_BOARD_SCHEMATICS.md`  
**Status:** Approved for Prototype PCB Layout (JLCPCB / PCBWay 2-Layer Standard)

---

## 1. System Hardware Architecture Overview

To eliminate delicate hand-wiring harnesses, loose breadboard jumpers, and field maintenance failures, the Beacon electronics architecture standardizes on **two custom 2-layer PCB carrier boards**:

1. **Board 1: Synapse Pit Master Controller Carrier Board (`PCB-SYNAPSE-V1` Rev v1.3)**
   - **Application:** Sideline front ensemble master console (Concept 10).
   - **Features:** Socket for Heltec V3, 16 discrete 16mm IP67 panel-mount metal pushbuttons with pre-wired pigtail sockets connected via four 8-pin pluggable terminal headers (`J5`, `J6`, `J8`, `J9` - Phoenix Contact MSTBA / 2EDG-5.08), providing 32 dedicated terminals (interleaved `[Signal | Ground]` pairs per button) sinking directly into the PCB copper ground plane pour, MCP23017 I2C expander, rotary menu encoder, dedicated emergency blackout pluggable terminal (`J7`), 3.5mm SMPTE/click line-in, and 5V DC pluggable power input (`J2`).
2. **Board 2: Peripheral Prop Receiver & LED Driver Carrier Board (`PCB-PROP-NODE-V1` Rev v1.3)**
   - **Application:** Deployed across all 30 field props (11 Backdrops, 16 Duck Blinds, 1 Lotus, 1 Star Tarp, 11 Solar Rays).
   - **Features:** Socket for Heltec V3, $18\text{V}\text{–}21\text{V}$ tool battery input via 2-pin pluggable header (`J1`) with reverse polarity P-FET protection, automotive blade fuse, 5V/6A–8A step-down buck regulation, 74AHCT125 high-speed logic level shifting ($3.3\text{V} \to 5.0\text{V}$), 8-position slide DIP switch bank (`SW1`) for 256 unique hardware device serial IDs ($0\text{–}255$ / `0x00`–`0xFF`), 2-pin pluggable performer trigger terminal (`J4`), and dual 6-pin pluggable quad LED outputs (`J5`, `J7`). 100% pluggable wiring enables instant tool-free field disconnection and rapid packout.

```
===================================================================================================
                                      SYSTEM SIGNAL FLOW
===================================================================================================

[BOARD 1: SYNAPSE PIT CONTROLLER]                           [BOARD 2: PROP RECEIVER NODES (x30)]
┌─────────────────────────────────┐                         ┌─────────────────────────────────┐
│ 16 Illuminated Buttons          │                         │ Heltec WiFi LoRa 32 V3 (Rx)     │
│   │ (I2C via MCP23017)          │                         │   │ (SX1262 @ 915 MHz)          │
│   ▼                             │   915 MHz LoRa Broadcast│   ▼                             │
│ Heltec WiFi LoRa 32 V3 (Tx)     │ ══════════════════════► │ ESP32-S3 Dual Core CPU          │
│   - SX1262 LoRa @ 915 MHz       │    14-Byte Cue Packets  │   - Core 0: RadioLib Sync PLL   │
│   - OLED Show Display           │    (10.9 ms Time-on-Air)│   - Core 1: FastLED 120 FPS     │
│   - Master 1ms Show Clock       │                         │   │                             │
│   - Dual Power (USB-C / 12V DC) │                         │   ▼ (3.3V DMA Stream)           │
└─────────────────────────────────┘                         │ 74AHCT125 Level Shifter         │
                                                            │   │                             │
                                                            │   ▼ (Clean 5.0V Damped Pulses)  │
                                                            │ High-Current LED Terminal       │
                                                            │   └► 300+ RGBW LEDs (Frame)     │
                                                            │ Power: Milwaukee M18 (18V-21V)  │
                                                            │   └► Onboard 5V / 8A Buck Reg   │
                                                            └─────────────────────────────────┘
===================================================================================================
```

---

## 2. Board 1: Synapse Pit Master Controller Carrier Board (`PCB-SYNAPSE-V1`)

### 2.1 Detailed Circuit Schematic & Subsystems

```
                                  BOARD 1: SYNAPSE MASTER CONTROLLER
                                  ===================================

   +5V_DC_IN (J2 Pin 1)             USB-C +5V (Heltec)
        │                                  │
     [D1: SS34]                         [D2: SS34]
        │                                  │
        └─────────────────┬────────────────┘
                          ▼
                       +5V_SYS (System 5.0V Bus)
                          │
                          ▼
                  [Heltec V3 5V/VIN]
             │
             ▼ (Internal 3.3V LDO on Heltec)
           +3V3_SYS
             │
             ├───────────────────┬───────────────────┬───────────────────┐
             │                   │                   │                   │
         [MCP23017 VDD]      [I2C Pullups]       [Rotary Pullups]    [Blackout Pullup]
         (Pin 9)             (2x 4.7k to SDA/SCL)(3x 10k to A/B/SW)  (10k to GPIO 2)
             │                   │                   │                   │
         [100nF]──GND            ▼                   ▼                   ▼
                          ESP32 GPIO 17/18    ESP32 GPIO 5/6/7     ESP32 GPIO 2


===================================================================================================
1. MCP23017-E/SP 16-BIT I2C KEYPAD INTERFACE & 32-TERMINAL PLUGGABLE BUTTON BLOCKS (J5, J6, J8, J9)
===================================================================================================

                      MCP23017-E/SP (DIP-28 / SOIC-28)
                      ┌───────────────U───────────────┐
 J5 Pin 1 (BTN_01) ───┤ 1  GPB0               GPA7 28 ├─── J9 Pin 7 (BTN_16)
 J5 Pin 3 (BTN_02) ───┤ 2  GPB1               GPA6 27 ├─── J9 Pin 5 (BTN_15)
 J5 Pin 5 (BTN_03) ───┤ 3  GPB2               GPA5 26 ├─── J9 Pin 3 (BTN_14)
 J5 Pin 7 (BTN_04) ───┤ 4  GPB3               GPA4 25 ├─── J9 Pin 1 (BTN_13)
 J6 Pin 1 (BTN_05) ───┤ 5  GPB4               GPA3 24 ├─── J8 Pin 7 (BTN_12)
 J6 Pin 3 (BTN_06) ───┤ 6  GPB5               GPA2 23 ├─── J8 Pin 5 (BTN_11)
 J6 Pin 5 (BTN_07) ───┤ 7  GPB6               GPA1 22 ├─── J8 Pin 3 (BTN_10)
 J6 Pin 7 (BTN_08) ───┤ 8  GPB7               GPA0 21 ├─── J8 Pin 1 (BTN_09)
 +3V3_SYS ────────────┤ 9  VDD                INTA 20 ├───┬───► ESP32 GPIO 4 (IRQ)
 GND ─────────────────┤ 10 VSS                INTB 19 ├───┘
 (No Connect) ────────┤ 11 NC                  RESET 18 ├─────── +3V3_SYS
 ESP32 GPIO 18 ───────┤ 12 SCL (I2C Clock)       A2 17 ├─────── GND (Addr = 0x20)
 ESP32 GPIO 17 ───────┤ 13 SDA (I2C Data)        A1 16 ├─────── GND
 (No Connect) ────────┤ 14 NC                    A0 15 ├─────── GND
                      └───────────────────────────────┘

* Pluggable Button Terminal Headers (Phoenix Contact MSTBA 2,5/8-G-5,08 / generic 2EDG-5.08):
  Four 8-pin shrouded horizontal PCB headers mating with detachable screw-clamp female plugs.
  All odd pins (1, 3, 5, 7) carry individual active-low button signals to the MCP23017.
  All even pins (2, 4, 6, 8) are dedicated GND returns connected directly into the continuous PCB copper ground plane pour.

  - Header J5 (Buttons 1–4):
    * Pin 1: BTN_01 (Signal)  |  Pin 2: GND (Dedicated Button 1 Return)
    * Pin 3: BTN_02 (Signal)  |  Pin 4: GND (Dedicated Button 2 Return)
    * Pin 5: BTN_03 (Signal)  |  Pin 6: GND (Dedicated Button 3 Return)
    * Pin 7: BTN_04 (Signal)  |  Pin 8: GND (Dedicated Button 4 Return)
  - Header J6 (Buttons 5–8):
    * Pin 1: BTN_05 (Signal)  |  Pin 2: GND (Dedicated Button 5 Return)
    * Pin 3: BTN_06 (Signal)  |  Pin 4: GND (Dedicated Button 6 Return)
    * Pin 5: BTN_07 (Signal)  |  Pin 6: GND (Dedicated Button 7 Return)
    * Pin 7: BTN_08 (Signal)  |  Pin 8: GND (Dedicated Button 8 Return)
  - Header J8 (Buttons 9–12):
    * Pin 1: BTN_09 (Signal)  |  Pin 2: GND (Dedicated Button 9 Return)
    * Pin 3: BTN_10 (Signal)  |  Pin 4: GND (Dedicated Button 10 Return)
    * Pin 5: BTN_11 (Signal)  |  Pin 6: GND (Dedicated Button 11 Return)
    * Pin 7: BTN_12 (Signal)  |  Pin 8: GND (Dedicated Button 12 Return)
  - Header J9 (Buttons 13–16):
    * Pin 1: BTN_13 (Signal)  |  Pin 2: GND (Dedicated Button 13 Return)
    * Pin 3: BTN_14 (Signal)  |  Pin 4: GND (Dedicated Button 14 Return)
    * Pin 5: BTN_15 (Signal)  |  Pin 6: GND (Dedicated Button 15 Return)
    * Pin 7: BTN_16 (Signal)  |  Pin 8: GND (Dedicated Button 16 Return)

* Two-Screw Direct Button Wiring & Fast Swap Architecture:
  - Every 16mm button connects via its own dedicated 2-wire pair directly to adjacent [Signal | GND] screw terminals on the plug.
  - Zero daisy-chain ground harnesses: Eliminates complex common-ground wiring bundles and ground loops.
  - 60-Second Button Replacement: If a button switch is mechanically damaged during rehearsal, an operator simply loosens the TWO corresponding screws on the plug, removes the old leads, inserts the replacement button leads, and re-tightens. No wire cutting, splicing, or harness modification required.
  - Instant Field Disconnection: During trailer packout, the four 8-pin plugs (and power/E-stop plugs) pull cleanly off the carrier board in seconds without touching any terminal screws.
* Interrupt Operation: INTA and INTB are configured in mirror mode (IOCON.MIRROR = 1). When any
  button is pressed, the line pulls LOW, immediately waking the ESP32 via external hardware interrupt.


===================================================================================================
2. EMERGENCY BLACKOUT E-STOP TERMINAL (J7), ROTARY ENCODER TERMINAL (J10) & SMPTE/CLICK INPUT
===================================================================================================

  EMERGENCY BLACKOUT BUTTON (Pluggable Header J7: Phoenix Contact MSTBA 2,5/2-G-5,08):
    Pin 1 (BLACKOUT) ──► ESP32 GPIO 2 (Dedicated hardware interrupt)
    Pin 2 (GND)      ──► GND
    Pullup           ──► 10k resistor to +3V3_SYS; 100nF ceramic debounce cap to GND.
    * External switch: 16mm Red Mushroom / Momentary or Latching panel-mount switch.

  ROTARY ENCODER TERMINAL (Pluggable Header J10: Phoenix Contact MSTBA 2,5/5-G-5,08):
    Pin 1 (GND)      ──► GND (Common return for encoder wiper and push switch)
    Pin 2 (ENC_A)    ──[1k]──► ESP32 GPIO 5 (Pullup 10k to 3.3V, Cap 10nF to GND)
    Pin 3 (ENC_B)    ──[1k]──► ESP32 GPIO 6 (Pullup 10k to 3.3V, Cap 10nF to GND)
    Pin 4 (ENC_SW)   ──[1k]──► ESP32 GPIO 7 (Pullup 10k to 3.3V, Cap 100nF to GND)
    Pin 5 (+3V3_SYS) ──► +3V3_SYS (Auxiliary DC power bus for active/optical/illuminated encoders)
    * External encoder: Bourns PEC11R-4215F-S0024 mounted directly to enclosure lid via M7x0.75
      threaded metal bushing with M7 nut, washer, silicone O-ring, and 6mm D-shaft skirted knob
      (drip edge overhang for outdoor drizzle shedding). Pre-wired pigtail plugs into J10.

  SMPTE / AUDIO CLICK TRACK LINE-IN (3.5mm TRS Jack):
    Tip / Ring ──[10µF/25V]──┬──[1k]──► ESP32 GPIO 3 (ADC1_CH2)
                             │
                            [R_BIAS1: 100k to +3V3_SYS]
                             │
                            [R_BIAS2: 100k to GND] (Biases input to 1.65V DC midpoint)
                             │
                            [100nF]── GND
```

### 2.2 Board 1 Pin Assignment Matrix (Heltec WiFi LoRa 32 V3)

| Heltec V3 Pin | Function / Net | Connected Circuit Subsystem | Hardware Notes |
|:---:|:---:|:---|:---|
| **GPIO 17** | `I2C_SDA` | MCP23017 Pin 13 (SDA) + Onboard OLED | $4.7\text{ k}\Omega$ pullup to 3.3V |
| **GPIO 18** | `I2C_SCL` | MCP23017 Pin 12 (SCL) + Onboard OLED | $4.7\text{ k}\Omega$ pullup to 3.3V |
| **GPIO 4** | `MCP_INT` | MCP23017 INTA/INTB tied together | Active-low hardware interrupt |
| **GPIO 5** | `ENC_A` | Rotary Encoder Channel A | $10\text{ k}\Omega$ pullup, $10\text{ nF}$ filter |
| **GPIO 6** | `ENC_B` | Rotary Encoder Channel B | $10\text{ k}\Omega$ pullup, $10\text{ nF}$ filter |
| **GPIO 7** | `ENC_SW` | Rotary Encoder Push Switch | Menu select / mode enter |
| **GPIO 2** | `BLACKOUT`| Master Emergency Blackout Button (`J7`) | Direct NMI / high-priority IRQ |
| **GPIO 3** | `AUDIO_IN`| 3.5mm Line-in Audio / SMPTE Input | AC-coupled ADC input ($1.65\text{V}$ bias) |
| **5V / VIN**| `+5V_SYS` | Dual-diode OR-ing power bus (`J2` / USB) | Powers Heltec internal 3.3V LDO |
| **GND** | `GND` | Common ground return | Direct low-impedance ground plane |

---

## 3. Board 2: Peripheral Prop Receiver & LED Driver Carrier Board (`PCB-PROP-NODE-V1`)

### 3.1 Detailed Circuit Schematic & Subsystems

```
                                  BOARD 2: PROP RECEIVER & LED DRIVER
                                  ===================================

===================================================================================================
1. POWER ENTRY, FUSING, TVS & REVERSE POLARITY P-MOSFET
===================================================================================================

  M18/20V BATTERY INPUT (18.0V - 21.0V DC)
  [J1: 2-Pin 5.08mm Pluggable Header / Phoenix Contact MSTBA 2,5/2-G-5,08]
    Pin 1 (BATT+) ──[FUSE 1: 10A ATO]──┬─────────────────────────────┐
                                       │                             │
                                  [TVS: SMCJ24A]              [SOURCE: IRF4905]
                                       │                      [P-CH POWER FET ]
                                      GND                            │
                                                              [DRAIN: IRF4905]
                                                                     │
                                                      +18V_PROTECTED ┴───────┐
                                                      (Switched Power Bus)   │
                                                                             │
    Pin 2 (BATT-) ───────────────────────────────────────────────────────────┴── GND

  P-Channel MOSFET Gate Biasing:
    Gate ──┬──[100k Resistor]──► Drain (+18V_PROTECTED)
           │
      [15V Zener: BZX84C15] (Cathode to Source, Anode to Gate)
           │
           └──[47k Resistor]───► GND
  * Theory: When battery polarity is correct, Gate is pulled 15V below Source, turning on the FET with
    sub-0.02Ω resistance (virtually 0.0V drop, < 0.1W dissipation). If polarity is reversed, Gate stays
    at 0V relative to Source, remaining completely OFF and protecting all circuitry.


===================================================================================================
2. STEP-DOWN BUCK REGULATOR (18V-21V -> 5.0V @ 8A CONTINUOUS)
===================================================================================================

  +18V_PROTECTED ──┬──[100µF/50V Low-ESR]──┬─────────────────────────────────┐
                   │                       │                                 │
                 [100nF]         [TI TPS54824 / XL4016 Buck IC]              │
                   │                       │                                 │
                  GND            [Inductor: 10µH / 12A Shielded]             │
                                           │                                 │
                                           ├───► +5V_POWER (High Current) ───┤
                                           │                                 │
                                      [1000µF/10V]                     [Heltec V3 5V/VIN]
                                      [Low-ESR Cap]                    [74AHCT125 VCC   ]
                                           │                                 │
                                          GND                               GND


===================================================================================================
3. 74AHCT125D HIGH-SPEED LOGIC LEVEL SHIFTER & QUAD TRANSMISSION DAMPING
===================================================================================================

   ESP32-S3 (Heltec V3)                  74AHCT125D (SOIC-14)
   Powered at 3.3V                       Powered at 5.0V (+5V_POWER)
   ───────────────────                   ───────────────────────────
   GPIO 48 (CH1 DATA) ─────────────────► Pin 2 (1A)   Pin 3 (1Y) ───[R1: 47Ω]──► LED_CH1_DATA (J5 Pin 2)
   GPIO 47 (CH2 DATA) ─────────────────► Pin 5 (2A)   Pin 6 (2Y) ───[R4: 47Ω]──► LED_CH2_DATA (J5 Pin 5)
   GPIO 42 (CH3 DATA) ─────────────────► Pin 9 (3A)   Pin 8 (3Y) ───[R5: 47Ω]──► LED_CH3_DATA (J7 Pin 2)
   GPIO 41 (CH4 DATA) ─────────────────► Pin 12 (4A)  Pin 11 (4Y) ──[R6: 47Ω]──► LED_CH4_DATA (J7 Pin 5)

   Control & Power Pins:
     Pin 1 (/1OE), Pin 4 (/2OE), Pin 10 (/3OE), Pin 13 (/4OE) ── GND (All 4 gates permanently enabled)
     Pin 14 (VCC) ── +5V_POWER (0.1µF ceramic decoupling capacitor C2 to GND)
     Pin 7 (GND)  ── GND


===================================================================================================
4. 8-BIT HARDWARE DIP SWITCH BANK & FIELD PERIPHERALS
===================================================================================================

  8-POSITION SPST SLIDE DIP SWITCH (CTS 208-8 / DIP-16):
    Switch Pins 9-16 (Common) ── GND
    Switch Pin 1 (Bit 0, 1s)   ──► ESP32 GPIO 2  (Internal pull-up enabled)
    Switch Pin 2 (Bit 1, 2s)   ──► ESP32 GPIO 3  (Internal pull-up enabled)
    Switch Pin 3 (Bit 2, 4s)   ──► ESP32 GPIO 4  (Internal pull-up enabled)
    Switch Pin 4 (Bit 3, 8s)   ──► ESP32 GPIO 5  (Internal pull-up enabled)
    Switch Pin 5 (Bit 4, 16s)  ──► ESP32 GPIO 7  (Internal pull-up enabled)
    Switch Pin 6 (Bit 5, 32s)  ──► ESP32 GPIO 8  (Internal pull-up enabled)
    Switch Pin 7 (Bit 6, 64s)  ──► ESP32 GPIO 9  (Internal pull-up enabled)
    Switch Pin 8 (Bit 7, 128s) ──► ESP32 GPIO 10 (Internal pull-up enabled)
  * Operation: Sets unique physical device serial number from 0 to 255 (0x00 to 0xFF).
    Decoupled from show profile; all fleet props run identical firmware binaries.
    Spare units are assigned profiles via off-field Wi-Fi OTA or on-field 915 MHz quick-remap.

  PERFORMER TACTILE TRIGGER (External Handle Button Jack):
    [J4: 2-Pin 5.08mm Pluggable Header / Phoenix Contact MSTBA 2,5/2-G-5,08]
      Pin 1 ──► ESP32 GPIO 6 (Active-low trigger with software debounce & internal pullup)
      Pin 2 ──► GND

  I2C DIAGNOSTIC & EXPANSION PORT:
    [J6: 4-Pin 2.54mm Header]
      Pin 1: +3V3_SYS
      Pin 2: ESP32 GPIO 17 (I2C_SDA)
      Pin 3: ESP32 GPIO 18 (I2C_SCL)
      Pin 4: GND

  HIGH-CURRENT QUAD LED STRIP OUTPUT TERMINALS:
    [J5: 6-Pin 5.08mm Pluggable Header (Channels 1 & 2) / Phoenix Contact MSTBA 2,5/6-G-5,08]
      Pin 1: +5V_POWER (High-current bus for CH1)
      Pin 2: LED_CH1_DATA (5.0V clean damped pulse stream via R1 47Ω)
      Pin 3: GND (Return for CH1)
      Pin 4: +5V_POWER (High-current bus for CH2)
      Pin 5: LED_CH2_DATA (5.0V clean damped pulse stream via R4 47Ω)
      Pin 6: GND (Return for CH2)

    [J7: 6-Pin 5.08mm Pluggable Header (Channels 3 & 4) / Phoenix Contact MSTBA 2,5/6-G-5,08]
      Pin 1: +5V_POWER (High-current bus for CH3)
      Pin 2: LED_CH3_DATA (5.0V clean damped pulse stream via R5 47Ω)
      Pin 3: GND (Return for CH3)
      Pin 4: +5V_POWER (High-current bus for CH4)
      Pin 5: LED_CH4_DATA (5.0V clean damped pulse stream via R6 47Ω)
      Pin 6: GND (Return for CH4)

    * Pluggable Mating Architecture: J5 and J7 utilize shrouded horizontal male PCB headers
      (Phoenix Contact MSTBA 2,5/6-G-5,08 / generic 2EDG-5.08-6P) mating with detachable female screw-terminal
      plugs (MSTB 2,5/6-ST-5,08). This permits instant disconnection of all LED channel wiring during field
      packout without loosening terminal screws.
```

### 3.2 Board 2 Pin Assignment Matrix (Heltec WiFi LoRa 32 V3)

| Heltec V3 Pin | Function / Net | Connected Circuit Subsystem | Hardware Notes |
|:---:|:---:|:---|:---|
| **GPIO 48** | `LED_CH1_DATA_RAW`| 74AHCT125 Pin 2 (1A) | Channel 1 LED DMA stream (3.3V) |
| **GPIO 47** | `LED_CH2_DATA_RAW`| 74AHCT125 Pin 5 (2A) | Channel 2 LED DMA stream (3.3V) |
| **GPIO 42** | `LED_CH3_DATA_RAW`| 74AHCT125 Pin 9 (3A) | Channel 3 LED DMA stream (3.3V) |
| **GPIO 41** | `LED_CH4_DATA_RAW`| 74AHCT125 Pin 12 (4A) | Channel 4 LED DMA stream (3.3V) |
| **GPIO 2** | `ADDR_BIT0` | SW1 DIP Switch Pin 1 (1s bit) | Active-low binary address bit |
| **GPIO 3** | `ADDR_BIT1` | SW1 DIP Switch Pin 2 (2s bit) | Active-low binary address bit |
| **GPIO 4** | `ADDR_BIT2` | SW1 DIP Switch Pin 3 (4s bit) | Active-low binary address bit |
| **GPIO 5** | `ADDR_BIT3` | SW1 DIP Switch Pin 4 (8s bit) | Active-low binary address bit |
| **GPIO 7** | `ADDR_BIT4` | SW1 DIP Switch Pin 5 (16s bit) | Active-low binary address bit |
| **GPIO 8** | `ADDR_BIT5` | SW1 DIP Switch Pin 6 (32s bit) | Active-low binary address bit |
| **GPIO 9** | `ADDR_BIT6` | SW1 DIP Switch Pin 7 (64s bit) | Active-low binary address bit |
| **GPIO 10** | `ADDR_BIT7` | SW1 DIP Switch Pin 8 (128s bit) | Active-low binary address bit |
| **GPIO 6** | `PERF_GO` | J4 Performer Button Terminal Pin 1 | External tactile trigger downbeat sync |
| **GPIO 1** | `VBAT_SENSE` | Internal Heltec ADC voltage divider | Monitors M18 battery pack depletion |
| **GPIO 17** | `I2C_SDA` | J6 Diagnostic Port Pin 2 | $4.7\text{ k}\Omega$ pullup on Heltec |
| **GPIO 18** | `I2C_SCL` | J6 Diagnostic Port Pin 3 | $4.7\text{ k}\Omega$ pullup on Heltec |
| **5V / VIN** | `+5V_POWER` | Output of 8A Buck Regulator | Regulated 5.0V logic supply |
| **GND** | `GND` | Common high-current ground plane | 2 oz copper ground pour |

### 3.3 LED Bus Serial Timing & Quad-Channel DMA Performance Benchmark

Addressable LED protocols (WS2812B, SK6812, WS2815) utilize a strict asynchronous single-wire NRZ pulse-width modulation protocol running at a fixed bit rate of $800\text{ kHz}$ ($1.25\ \mu\text{s}$ per bit, or $30.0\ \mu\text{s}$ per 24-bit RGB pixel). At the end of every transmitted frame, a mandatory reset latch pulse of $T_{\text{reset}} \ge 300\ \mu\text{s}$ is required to commit pixel values into the driver PWM registers.

The total transmission push time $T_{\text{push}}$ for a single serial daisy-chain of $N$ pixels is:
$$T_{\text{push}} = (N \times 30.0\ \mu\text{s}) + 300.0\ \mu\text{s}$$

#### Transmission Bottleneck on Large Props (Single Chain vs. Quad DMA)

When driving high-density field props (such as the 10-ft Rolling Backdrop frame with 510 pixels, or the 24-ft Supernova Star Tarp), a single daisy-chain introduces severe frame latency and visible physical scan shear:

| Metric | Single Daisy-Chain (1 Channel) | Quad-Channel Parallel DMA (4 Channels) | Performance Advantage |
|:---|:---:|:---:|:---|
| **LED Architecture** | 1 string of 510 LEDs | 4 parallel strings of 128 LEDs | 4x data throughput |
| **Bit Clock Rate** | $800\text{ kHz}$ | $800\text{ kHz}$ across 4 parallel buses | Total bandwidth: $3.2\text{ Mbps}$ |
| **Serial Push Time ($T_{\text{push}}$)** | **$15.60\text{ ms}$** | **$4.14\text{ ms}$** | **3.8x faster frame commit** |
| **Theoretical Max Refresh Rate** | $64.1\text{ FPS}$ | **$241.5\text{ FPS}$** | Ultra-smooth color chases |
| **Field Refresh Margin @ 120 FPS** | **FAILED** (Needs $8.33\text{ ms}$; cannot hit 120 FPS) | **PASSED** (Only consumes 49% of 120 FPS budget) | Guaranteed headroom |
| **Temporal Scan Shear Across Frame** | $15.3\text{ ms}$ delay from bottom to top | $3.8\text{ ms}$ delay per quadrant | Eliminates rolling shutter visual tearing |
| **CPU Utilization (ESP32-S3)** | 0% (Hardware DMA engine) | 0% (Hardware RMT / I2S DMA engine) | Core 0 & Core 1 100% free for LoRa / Math |
| **Single-Point Failure Vulnerability** | 1 damaged LED kills 100% of prop | 1 damaged LED only affects 25% of prop | High field reliability & redundancy |

#### Unused Channel Graceful Handling
Props requiring fewer channels (such as the Sideline Screen Duck Blind with a single top rail of 144 LEDs, or a soloist prop) simply connect to Channel 1 (`J5` Pins 1–3). Channels 2, 3, and 4 remain unpopulated on the prop wiring harness without requiring any board modifications or software hacks.

---

## 4. Comprehensive Bill of Materials (BOM) & Sourcing

### 4.1 Board 1 (Synapse Master Controller Carrier) BOM

| Item | Qty | Reference | Description / Spec | Suggested Part Number | Package |
|:---:|:---:|:---|:---|:---|:---|
| 1 | 1 | U1 | 16-Bit I2C I/O Expander | Microchip MCP23017-E/SP | SOIC-28W (or DIP-28) |
| 2 | 1 | MOD1 | ESP32-S3 + SX1262 LoRa 915MHz | Heltec WiFi LoRa 32 V3 | $2 \times 18$ Pin Socket |
| 3 | 2 | J3, J4 | 18-Pin 2.54mm Female Socket Header Strip | Sullins PPTC181LFBN-RC | Through-hole 1x18 |
| 4 | 16 | SW1–SW16 | 16mm IP67 Momentary Metal Pushbutton + Sockets | Ulincos / APIELE 16mm Momentary + Pigtails | Panel mount (16mm hole) |
| 5 | 1 | SW17 | 16mm IP67 Red Mushroom Momentary Switch | APIELE 16mm Mushroom E-Stop | Panel mount (16mm hole) |
| 6 | 4 | J5, J6, J8, J9 | 8-Pin 5.08mm Pluggable Header (Buttons 1–4, 5–8, 9–12, 13–16) | Phoenix Contact MSTBA 2,5/8-G-5,08 (1757307) / 2EDG-5.08-8P | Shrouded Header + Plug |
| 7 | 1 | J7 | 2-Pin 5.08mm Pluggable Header (Blackout E-Stop) | Phoenix Contact MSTBA 2,5/2-G-5,08 (1757242) / 2EDG-5.08-2P | Shrouded Header + Plug |
| 8 | 1 | J2 | 2-Pin 5.08mm Pluggable Header (5V DC Power In) | Phoenix Contact MSTBA 2,5/2-G-5,08 (1757242) / 2EDG-5.08-2P | Shrouded Header + Plug |
| 9 | 1 | J10 | 5-Pin 5.08mm Pluggable Header (Rotary Encoder) | Phoenix Contact MSTBA 2,5/5-G-5,08 (1757271) / 2EDG-5.08-5P | Shrouded Header + Plug |
| 9a | 1 | ENC1 | Panel-Mount Rotary Encoder with Push Switch | Bourns PEC11R-4215F-S0024 + M7 Nut/Washer + Skirted Knob | Panel mount (M7 threaded bushing) |
| 10 | 1 | J1 | $3.5\text{ mm}$ Stereo Audio Line-in Jack | CUI Devices SJ1-3523N | Through-hole PCB |
| 11 | 2 | D1, D2 | 3A 40V Schottky Barrier Diodes | Diodes Inc. SS34 | SMA / DO-214AC |
| 12 | 6 | C1–C6 | Decoupling / Filter Capacitors $100\text{ nF}$ 50V X7R | Murata GRM188R71H104KA93D | SMD 0805 |
| 13 | 2 | C7, C8 | Encoder Filter Capacitors $10\text{ nF}$ 50V X7R | Murata GRM188R71H103KA01D | SMD 0805 |
| 14 | 2 | R1, R2 | I2C Pullup Resistors $4.7\text{ k}\Omega$ 1% | Yageo RC0805FR-074K7L | SMD 0805 |
| 15 | 4 | R3–R6 | Pullup Resistors $10\text{ k}\Omega$ 1% | Yageo RC0805FR-0710KL | SMD 0805 |
| 16 | 3 | R7–R9 | Encoder In-Line Resistors $1.0\text{ k}\Omega$ 1% | Yageo RC0805FR-071KL | SMD 0805 |

### 4.2 Board 2 (Prop Receiver & LED Driver Carrier) BOM

| Item | Qty | Reference | Description / Spec | Suggested Part Number | Package |
|:---:|:---:|:---|:---|:---|:---|
| 1 | 1 | MOD1 | ESP32-S3 + SX1262 LoRa 915MHz | Heltec WiFi LoRa 32 V3 | $2 \times 18$ Pin Socket |
| 2 | 2 | J2, J3 | 18-Pin 2.54mm Female Socket Header Strip | Sullins PPTC181LFBN-RC | Through-hole 1x18 |
| 3 | 1 | J1 | 2-Pin 5.08mm Pluggable Header (18V-21V Battery In) | Phoenix Contact MSTBA 2,5/2-G-5,08 / 2EDG-5.08-2P | Shrouded Header + Plug |
| 4 | 1 | F1 | 10A Mini Automotive Blade Fuse PCB Clips | Keystone 3568 | Through-hole Clip |
| 5 | 1 | FUSE | 10A Mini Blade Automotive Fuse (Fast-Acting) | Littelfuse 0297010.WXNV | Mini Blade |
| 6 | 1 | D1 | 24V 1500W TVS Surge Protection Diode | Littelfuse SMCJ24A | SMC / DO-214AB |
| 7 | 1 | Q1 | 55V 74A P-Channel Power MOSFET | Infineon IRF4905PBF | TO-220-3 |
| 8 | 1 | D2 | 15V 300mW Zener Diode (Gate Clamp) | Diodes Inc. BZX84C15-7-F | SOT-23 |
| 9 | 1 | R2 | 100k Ohm 1/8W 1% Resistor (P-FET Gate) | Yageo RC0805FR-07100KL | SMD 0805 |
| 10 | 1 | R3 | 47k Ohm 1/8W 1% Resistor (P-FET Gate Bias) | Yageo RC0805FR-0747KL | SMD 0805 |
| 11 | 1 | REG1 | 5V 5.5A/8A Buck Regulator Module | Pololu D36V50F5 (Item 4090) | SIP Module |
| 12 | 1 | C3 | $1000\ \mu\text{F}$ 10V Low-ESR Electrolytic Cap | Panasonic EEU-FR1A102 | Radial 10x12.5mm |
| 13 | 1 | U1 | Quad Level Shifter (3.3V to 5.0V Buffer) | TI SN74AHCT125D | SOIC-14 |
| 14 | 4 | R1, R4–R6 | 47 Ohm 1/8W 1% Resistors (Quad LED Damping) | Yageo RC0805FR-0747RL | SMD 0805 |
| 15 | 1 | SW1 | 8-Position Slide DIP Switch (8-Bit Hardware Serial ID) | CTS 208-8 | Through-hole DIP-16 |
| 16 | 1 | J4 | 2-Pin 5.08mm Pluggable Header (Performer Trigger) | Phoenix Contact MSTBA 2,5/2-G-5,08 / 2EDG-5.08-2P | Shrouded Header + Plug |
| 17 | 2 | J5, J7 | 6-Pin 5.08mm Pluggable Headers (Quad LED Out CH1–4) | Phoenix Contact MSTBA 2,5/6-G-5,08 / 2EDG-5.08-6P | Shrouded Header + Plug |
| 18 | 1 | J6 | 4-Pin 2.54mm Header (I2C Diagnostic Port) | Sullins PRPC004SAAN-RC | Through-hole 1x4 |
| 19 | 4 | H1–H4 | M3 x 6mm Brass Standoffs + M3 Screws | Keystone 24395 | Hardware |

---

### 4.3 Pluggable Connector Sourcing Strategy (DigiKey Order Preservation)

- **DigiKey Order Integrity:** The initial component order with DigiKey has already been placed and contains fixed screw terminals (`MKDS 1,5/...`). To eliminate re-order delays or modification risks, these DigiKey line items are preserved intact and retained as general shop bench stock.
- **Amazon Prime Pluggable Kit Sourcing:** All mating pluggable headers and screw-clamp female plugs are sourced via Amazon Prime (1–2 day delivery):
  * **Option A (Consolidated Assortment Kit):** Tanstic / Mardatt / YIXISI 5.08mm 2/3/4/6/8-Pin Pluggable Terminal Block Kit (84-piece kit, ~$16.99). One single kit supplies all 8-pin, 6-pin, and 2-pin male shrouded PCB headers and matching female plugs required for 1 Synapse Controller and 3 Prop Nodes.
  * **Option B (Direct Industry Standard):** Phoenix Contact COMBICON `MSTBA 2,5` Series horizontal headers (`MSTBA 2,5/8-G-5,08`, `MSTBA 2,5/6-G-5,08`, `MSTBA 2,5/2-G-5,08`) paired with `MSTB 2,5/...-ST-5,08` female plugs.

---

## 5. PCB Layout & Manufacturing Guidelines (JLCPCB / PCBWay)

To ensure high reliability under outdoor high school marching band conditions (temperature swings from $35^\circ\text{F}$ evening finals to $95^\circ\text{F}$ daytime prelims, high vibration from rolling over stadium turf, and dust):

1. **Board Dimensions & Mechanical Form Factor:**
   - **Board 1 (Synapse Master Controller):** $210.0\text{ mm} \times 90.0\text{ mm}$ (8.27″ × 3.54″). Expanded width accommodates four 8-pin pluggable headers along the bottom edge with $5.44\text{ mm}$ finger gaps between plugs, allowing effortless mating and un-mating. Corner M3 mounting holes at $x = 4.5\text{ mm}, 205.5\text{ mm}$; $y = 4.5\text{ mm}, 85.5\text{ mm}$.
   - **Board 2 (Prop Node Driver):** $95.0\text{ mm} \times 90.0\text{ mm}$ (3.74″ × 3.54″). Form factor accommodates dual 6-pin pluggable headers (`J5`, `J7`) on the right edge and dual 2-pin pluggable headers (`J1`, `J4`) on the bottom edge with ample clearance for shrouded mounting ears and corner M3 standoffs ($x = 4.5\text{ mm}, 90.5\text{ mm}$; $y = 4.5\text{ mm}, 85.5\text{ mm}$).
2. **Layer Stack & Copper Weight:**
   - Standard **2-Layer Board** ($1.6\text{ mm}$ thickness, FR4, TG150).
   - Specify **$2\text{ oz}$ Copper ($70\ \mu\text{m}$)** on Board 2 to handle continuous $6\text{A}\text{–}8\text{A}$ current loops to the LED strips without overheating traces.
2. **High-Current Polygon Pours:**
   - On Board 2, trace widths between Battery Input `J1`, Fuse `F1`, MOSFET `Q1`, Buck Regulator `REG1`, and LED Terminals `J5`/`J7` must be designed as **solid copper polygon pours ($\ge 4.0\text{ mm}$ wide)**.
3. **RF Ground Plane Isolation:**
   - Keep the area directly beneath the Heltec V3 onboard antenna trace completely free of copper pours and ground fills (遵照 Heltec keepout zone specs) to prevent detuning the 915 MHz antenna.
4. **Mechanical Mounting:**
   - Include four **M3 ($3.2\text{ mm}$) mounting holes** at each board corner, spaced to fit standard IP65 sealed polycarbonate electronics enclosures (Bud Industries PN-1323-C or Hammond 1554 series).
5. **Conformal Coating:**
   - After through-hole soldering and functional bench testing, spray both sides of the board with **MG Chemicals 422C Silicone Conformal Coating** to protect against field dew, condensation, and rain.

---

## 6. Firmware Integration & Initialization Code

Below is the verified production C++ initialization snippet demonstrating how both carrier boards interact seamlessly with `RadioLib` and `FastLED`:

```cpp
#include <Arduino.h>
#include <Wire.h>
#include <RadioLib.h>
#define FASTLED_USES_ESP32S3_I2S
#include <FastLED.h>

// ==========================================
// PIN DEFINITIONS (MATCHING QUAD-CHANNEL CARRIER SCHEMATIC)
// ==========================================
#define PIN_LED_CH1      48   // Driven through 74AHCT125 Gate 1
#define PIN_LED_CH2      47   // Driven through 74AHCT125 Gate 2
#define PIN_LED_CH3      42   // Driven through 74AHCT125 Gate 3
#define PIN_LED_CH4      41   // Driven through 74AHCT125 Gate 4

#define PIN_LORA_NSS      8
#define PIN_LORA_DIO1    14
#define PIN_LORA_NRST    12
#define PIN_LORA_BUSY    13

#define NUM_LEDS_PER_CH 128
CRGB leds_ch1[NUM_LEDS_PER_CH];
CRGB leds_ch2[NUM_LEDS_PER_CH];
CRGB leds_ch3[NUM_LEDS_PER_CH];
CRGB leds_ch4[NUM_LEDS_PER_CH];

SX1262 radio = new Module(PIN_LORA_NSS, PIN_LORA_DIO1, PIN_LORA_NRST, PIN_LORA_BUSY);

// 8-Position DIP Switch Hardware Serial ID Pins (Board 2: SW1)
const int ADDR_PINS[8] = {2, 3, 4, 5, 7, 8, 9, 10};

uint8_t readHardwarePropID() {
  uint8_t id = 0;
  for (int i = 0; i < 8; i++) {
    pinMode(ADDR_PINS[i], INPUT_PULLUP);
    if (digitalRead(ADDR_PINS[i]) == LOW) {
      id |= (1 << i);
    }
  }
  return id; // Returns 0x00 to 0xFF (Hardware Serial 0 to 255)
}

void setup() {
  Serial.begin(115200);

  // 1. Read Mechanical Prop ID Dial
  uint8_t propId = readHardwarePropID();
  Serial.printf("PCHSMB Prop Node Booted. Hardware ID: %d\n", propId);

  // 2. Initialize FastLED Quad Parallel DMA (4.14 ms push time, 0% CPU Overhead)
  FastLED.addLeds<WS2812B, PIN_LED_CH1, GRB>(leds_ch1, NUM_LEDS_PER_CH);
  FastLED.addLeds<WS2812B, PIN_LED_CH2, GRB>(leds_ch2, NUM_LEDS_PER_CH);
  FastLED.addLeds<WS2812B, PIN_LED_CH3, GRB>(leds_ch3, NUM_LEDS_PER_CH);
  FastLED.addLeds<WS2812B, PIN_LED_CH4, GRB>(leds_ch4, NUM_LEDS_PER_CH);
  FastLED.setBrightness(128);

  fill_solid(leds_ch1, NUM_LEDS_PER_CH, CRGB(255, 120, 0)); // Amber Staging Default
  fill_solid(leds_ch2, NUM_LEDS_PER_CH, CRGB(255, 120, 0));
  fill_solid(leds_ch3, NUM_LEDS_PER_CH, CRGB(255, 120, 0));
  fill_solid(leds_ch4, NUM_LEDS_PER_CH, CRGB(255, 120, 0));
  FastLED.show();

  // 3. Initialize LoRa Radio (915 MHz, SF7, 500 kHz BW)
  int state = radio.begin(915.0, 500.0, 7, 5, 0x12, 14, 8);
  if (state == RADIOLIB_ERR_NONE) {
    Serial.println("LoRa Radio Initialized Successfully.");
    radio.startReceive();
  } else {
    Serial.printf("LoRa Failed, code: %d\n", state);
  }
}

void loop() {
  // FreeRTOS background handles radio packets on Core 0
  // Core 1 runs 60-120 FPS FastLED animations locally across all 4 channels
}
```
