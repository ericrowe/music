# Implementation Plan 002: Modular Tablet Touchscreen Soft Controller & Roaming Visuals Stand Mount

**Project:** PCHSMB Universal Field Prop Lighting Control System  
**Status:** Architecture Approved / Backlog Implementation Plan  
**Target Subsystem:** Synapse Master Console Accessory System & Rehearsal Web Engine  
**Applicable Requirements:** `REQ-SYS-03`, `REQ-SYN-01`, `REQ-SYN-09`, `REQ-SW-01`, `REQ-SW-04`, `REQ-SW-09`, `REQ-SW-10`  
**Direct Predecessor:** [Plan 001: Web-Based Rehearsal Configuration Engine](001-rehearsal-web-engine-wifi-fleet.md)

---

## 1. Problem Statement & Motivation

During marching band field rehearsals, show design decisions happen across two vastly different physical locations on the stadium field:

1. **At the Front Sideline (The Pit):**  
   The physical Synapse Master Console (`PCB-SYNAPSE-V1`) is clamped to a front-ensemble percussion cart or keyboard rail. A student musician or pit tech triggers cues using the 16 physical metal pushbuttons. While physical buttons provide unbeatable tactile reliability, editing show parameters (cue timings, colors, group assignments) on the small $128 \times 64$ console OLED screen during the middle of a rehearsal run is constrained.

2. **At Elevated Vantage Points (The Observation Tower / Viewing Stand / Press Box):**  
   The Visual Coordinator, Drill Designer, and Head Band Director stand elevated 20 to 50 feet above the field on a scissor lift, mobile observation tower, or stadium press box. From this elevated perspective, staff observe how lighting cues interact with marching drill geometry, flag tosses, and ambient dusk conditions. Currently, if an amber backdrop wash is too dim or a downbeat cue triggers 0.8 seconds too late, the visual coordinator must radio down to the pit or run down the bleachers to edit the cue file.

### Desired Outcome
Provide an **optional, modular touchscreen controller and roaming tablet mount** that pairs seamlessly with the Synapse Rehearsal Web Engine ([Plan 001](001-rehearsal-web-engine-wifi-fleet.md)).
- **Docked Pit Mode:** Mounts an everyday 10″ tablet (iPad, Android, Fire HD) adjacent to the Synapse console on the front-ensemble rail, serving as a large, visual "soft controller" and telemetry status board.
- **Roaming Visuals Stand Mode:** Uses a heavy-duty quick-release cradle allowing visual staff to detach the tablet in 2 seconds and walk up to the observation tower. From the tower, staff wirelessly trigger soft cues, tweak color palettes, nudge cue timestamps, and inspect field results in real time over the rehearsal Wi-Fi network.
- **Strict Performance Invariant:** The tablet and touchscreen interface are **100% optional**. The core physical Synapse console retains complete operational autonomy. If the tablet is absent, turned off, or out of battery, the show runs flawlessly via the physical buttons and 915 MHz LoRa link.

---

## 2. Operational Dual-Mode Concept

```
===================================================================================================
                                REHEARSAL DUAL-MODE WORKFLOW
===================================================================================================

 [MODE 1: DOCKED PIT PRACTICE CONTROLLER]
 ┌────────────────────────────────────────────────────────────────────────┐
 │ FRONT ENSEMBLE PERCUSSION CART RAIL (FRONT SIDELINE)                   │
 │                                                                        │
 │   ┌──────────────────────┐         ┌───────────────────────────────┐   │
 │   │ SYNAPSE MASTER       │  Dual   │ 10.2" DOCKED TABLET           │   │
 │   │ CONSOLE              │  Sync   │ (RAM Mount Quick-Release)     │   │
 │   │ • 16 Metal Buttons   │◄───────►│ • Large Touch Cue Grid (1-16) │   │
 │   │ • 128x64 OLED        │ USB/WiFi│ • Live Fleet Battery Grid     │   │
 │   │ • 915 MHz LoRa Whip  │         │ • Master Rehearsal Fader      │   │
 │   └──────────┬───────────┘         └───────────────────────────────┘   │
 └──────────────┼─────────────────────────────────────────────────────────┘
                │ 902–928 MHz Sub-GHz Broadcast (To All Field Props)
                ▼

                                      ▲
                                      │ 2-Second Quick-Release Detach
                                      │ (Carried up observation tower)
                                      ▼

 [MODE 2: ROAMING VISUALS STAND CONTROLLER]
 ┌────────────────────────────────────────────────────────────────────────┐
 │ OBSERVATION TOWER / PRESS BOX (ELEVATED 30 FT ABOVE TURF)              │
 │                                                                        │
 │   Visual Coordinator / Director                                        │
 │   Holding 10.2" Tablet with High-Contrast Rehearsal PWA                │
 │   • Watches marching drill arcs & flag silks from above                │
 │   • Taps soft cues to audition lighting timing against drill downbeats │
 │   • Nudges timestamps (±0.2s, ±0.5s) with single-touch buttons         │
 │   • Adjusts color shades live to test against stadium floodlights      │
 │   • Connects wirelessly to Synapse Travel Router (2.4/5GHz Wi-Fi)      │
 └────────────────────────────────────────────────────────────────────────┘
===================================================================================================
```

---

## 3. Physical & Mechanical Mounting Architecture

The tablet mounting system is designed specifically for marching band percussion carts, which face heavy vibration, turf bumps, and rapid outdoor setup:

```
          [Tablet Cradle]
         ┌───────────────┐
         │ ┌───────────┐ │
         │ │  10" PWA  │ │  ◄── Quick-Release Locking Grip
         │ └───────────┘ │
         └───────┬───────┘
                 │
           (1.5" RAM Ball)
                 │
           [Articulating]  ◄── 360° Double-Socket Arm (Adjusts for sun glare)
           [  Arm Joint ]
                 │
           (1.5" RAM Ball)
                 │
           [Heavy-Duty  ]  ◄── Quick-Clamp to 1.5" (38mm) Percussion Rail
           [Rail Clamp  ]      (Mounts directly adjacent to Synapse box)
                 │
   ══════════════╪═══════════════ [Front Ensemble Pit Rail]
```

### 1. Rail Clamp Assembly
- **Mounting Point:** Clamps rigidly onto standard $1.5\text{ in.}$ ($38.1\text{ mm}$) OD stainless steel or aluminum square/round tubing on front ensemble synthesizer frames (Yamaha, Pearl, Gibraltar, Adams).
- **Clamp Style:** Cast aluminum two-bolt drum rack clamp or heavy-duty RAM Mount Tough-Claw (`RAP-404U` or `RAM-271U-12`). Rubber-padded jaws prevent scratching or slipping on powder-coated cart rails during field transit.

### 2. Double-Socket Articulating Arm
- **Adjustment Freedom:** Dual $1.5\text{ in.}$ (C-Size) or $1.0\text{ in.}$ (B-Size) ball-and-socket joints allow 360-degree rotation, forward/backward tilt, and portrait/landscape orientation.
- **Sun Glare Mitigation:** Under midday Colorado sun ($90,000\text{ lux}$), the operator can instantly tilt the tablet downward or angle it away from direct solar reflection with a single twist of the central wing-nut.

### 3. Quick-Release Tablet Cradle
- **Device Support:** Accommodates standard 9.7″ to 11.0″ tablets (e.g., Apple iPad 10.2″/10.9″, iPad Air, Samsung Galaxy Tab A8/S9 FE, Amazon Fire HD 10) enclosed in standard protective rubber shock-absorbing cases.
- **Latching Mechanism:** Spring-loaded roller fingers (RAM Tab-Tite `RAM-HOL-TAB20U` or custom 3D-printed ASA snap-clamp) hold the tablet with $> 25\,\text{N}$ retention force to prevent ejection over turf bumps.
- **One-Handed Egress:** A top spring release allows the visual coordinator to pull the tablet free in $< 2.0\,\text{seconds}$ without unbolting or using tools.

### 4. Docked Auxiliary Power
- An auxiliary $5.0\text{V} / 2.4\text{A}$ USB-C charging pigtail runs from the Synapse console's shore-power auxiliary buck regulator directly to the tablet dock.
- When docked, the tablet charges continuously. When undocked for roaming, the tablet runs on its internal lithium battery ($8\text{–}10\,\text{hours}$ operating time).

---

## 4. Touch-Optimized Progressive Web App (PWA) Interface

The tablet interface is a specialized, touch-first view served directly by the Plan 001 Raspberry Pi at `http://synapse.local/tablet/` or `http://192.168.8.1/tablet/`.

### 1. Progressive Web App (PWA) Architecture
- **Zero App Store Dependencies:** Works on any iOS Safari, Android Chrome, or FireOS browser.
- **Standalone Mode:** Can be saved to the tablet home screen via *"Add to Home Screen"*. When launched, it runs full-screen with native app appearance (`display: standalone`), hiding the browser URL bar, tabs, and navigation buttons.
- **Offline Service Worker:** Interface assets (CSS, SVGs, Vue components) cache locally on the tablet, loading instantly even if network connection momentarily drops.

### 2. Touch UI/UX Design Standards
- **Oversized Touch Targets:** Every interactive button measures at least $96 \times 96\text{ pixels}$ ($> 20\text{ mm}$ physical height on a 10″ display), allowing reliable fingertip strikes without glancing down, even while wearing performance or percussion gloves.
- **Accidental Touch Rejection:**
  - Viewport zoom and double-tap zoom are explicitly disabled (`touch-action: manipulation`, `<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">`).
  - Cue buttons incorporate a $100\,\text{ms}$ software debounce lock to prevent accidental double-triggering.
- **Dual Visual Modes:**
  1. *Daylight High-Contrast Mode:* Crisp black typography on stark white and high-saturation color chips, engineered to be legible under $90,000\text{ lux}$ ambient sunlight.
  2. *Stadium Twilight Mode:* Deep matte-charcoal dark mode (`#121212`) with luminous, warm-glowing button outlines to preserve the operator's night vision without distracting audience members.

### 3. Screen Layout Breakdown

```
+===================================================================================================+
| [PCHSMB SYNAPSE]  SHOW: 2027 BEACON (16 CUES)   [WIFI: -42dBm] [LORA: 915MHz OK]  [SOFT BLACKOUT] |
+===================================================================================================+
| [CUE MATRIX (1–16)]                              | [REHEARSAL QUICK CONTROLS]                     |
|                                                  |                                                |
|  ┌──────────────────┐  ┌──────────────────┐      |  MASTER BRIGHTNESS                             |
|  │ CUE 01           │  │ CUE 02           │      |  [========●==============] 85%                 |
|  │ Pre-Show Horizon │  │ Opener Fanfare   │      |                                                |
|  │ #002244 / #FFB300│  │ #FF8F00 / #FFFFFF│      |  REHEARSAL TRANSPORT                           |
|  │ 24.0s (Trig: P1) │  │ 18.5s (Trig: P2) │      |  [ ◄ PREV ]   [ PAUSE ]   [ NEXT ► ]           |
|  └──────────────────┘  └──────────────────┘      |                                                |
|  ┌──────────────────┐  ┌──────────────────┐      |  LIVE TIMING NUDGE (ACTIVE CUE)                |
|  │ CUE 03           │  │ CUE 04 [ACTIVE]  │      |  [ -0.5s ]  [ -0.1s ]  [ +0.1s ]  [ +0.5s ]    |
|  │ Impact Pulse     │  │ Ballad Bloom     │◄──┐  |  Current Downbeat: 184.2s -> [SAVE TO CSV]     |
|  │ #00E5FF / #FFB300│  │ #FFD54F / #FFFFFF│   │  |                                                |
|  │ 12.0s (Trig: P3) │  │ [==== 6.2s / 15s]│   │  |  QUICK COLOR OVERRIDE                          |
|  └──────────────────┘  └──────────────────┘   │  |  ( ) Original   (●) Warmer   ( ) Cooler        |
|  ┌──────────────────┐  ┌──────────────────┐   │  |  [ Amber #FFB300 ] [ Cyan #00E5FF ]            |
|  │ CUE 05           │  │ CUE 06           │   │  |                                                |
|  │ Drum Break Solo  │  │ Closer Rush      │   │  |  SECTION MUTE / ISOLATION                      |
|  │ #FF1744 / #000000│  │ #00E5FF / #FFD54F│   │  |  [x] Backdrops  [x] Screens  [x] Stages        |
|  │ 16.0s (Trig: P5) │  │ 32.0s (Trig: P6) │   │  |                                                |
|  └──────────────────┘  └──────────────────┘   │  |  SCENE ACTION                                  |
|  [ ... Cues 07–16 displayed in responsive grid ]│  [FREEZE SCENE]  [RESTORE NORMAL]              |
+===============================================│==+================================================+
| [PROP TELEMETRY DRAWER: 32 NODES]             ▼                                                   |
| Prop 01 (BD1): 19.8V [OK] | Prop 02 (BD2): 20.1V [OK] | Prop 17 (DB1): 19.5V [OK] | RSSI: -68dBm  |
+===================================================================================================+
```

---

## 5. Wireless Roaming & Network Architecture

### 1. Dual-Band Rehearsal Wi-Fi Coverage
- **Access Point:** Embedded GL.iNet travel router inside the Synapse console broadcasting $2.4\text{ GHz}$ and $5.0\text{ GHz}$ 802.11ac Wi-Fi.
- **External Antenna Integration:** The router connects to an external high-gain dual-band paddle antenna (`+5\,\text{dBi}`) mounted to the top plate of the Synapse console chassis.
- **RF Coverage Range:**
  - Standard football field: $120\text{ yards} \times 53.3\text{ yards}$ ($110\text{ m} \times 49\text{ m}$).
  - Slant range from front sideline pit (50-yard line) to midfield observation tower ($30\text{ ft}$ high, $20\text{ yards}$ back): $\approx 35\text{–}45\,\text{meters}$.
  - Slant range to press box row 30: $\approx 75\,\text{meters}$.
  - At $75\,\text{meters}$ line-of-sight in open stadium air, $5.0\text{ GHz}$ Wi-Fi provides sustained signal strength of $-62\,\text{dBm}$ with zero packet loss.

### 2. WebSocket Real-Time Synchronization Protocol
- The tablet maintains a persistent WebSocket connection: `ws://synapse.local:8000/ws/rehearsal`.
- **Bi-Directional State Mirroring:**
  1. *Physical Button Pressed in Pit:* Student presses physical Button 4 on the Synapse console $\to$ Heltec MCU sends packet over UART to Raspberry Pi $\to$ Pi broadcasts WebSocket event $\to$ Tablet screen immediately illuminates Cue 4 in bright golden-amber with countdown timer ($T_{\text{latency}} \le 15\,\text{ms}$).
  2. *Soft Button Tapped on Roaming Tablet:* Visual coordinator on the tower taps Cue 4 $\to$ Tablet sends WebSocket command to Pi $\to$ Pi forwards command to Heltec MCU over UART $\to$ Heltec MCU updates OLED screen, lights Button 4 LED, and broadcasts 915 MHz LoRa packet across the field ($T_{\text{latency}} \le 20\,\text{ms}$).
- **Heartbeat & Link Integrity:** The tablet sends a heartbeat ping every $2.0\,\text{seconds}$. If Wi-Fi link drops (e.g. stepping inside concrete stadium concourse), the tablet displays a prominent yellow banner: `[ROAMING WI-FI RECONNECTING...]`, while the physical console continues uninterrupted.

---

## 6. Visual Designer Rehearsal Feature Set

When roaming on the observation stand, the visual coordinator has access to features engineered specifically for marching band rehearsals:

### A. Real-Time Cue Timing Nudge
- Drill instructors often clean drill by repeating 16-count phrases. If a lighting cue is firing 2 counts early, the visual coordinator taps `[ +0.5s ]` or `[ +0.1s ]`.
- The adjusted downbeat timestamp updates in active memory instantly.
- Tapping `[SAVE TO CSV]` writes the new timestamp back into `show_cues.csv` on the Synapse non-volatile flash drive with zero manual typing.

### B. "Freeze Scene" Drill Rehearsal Lock
- When cleaning drill sets, directors often say: *"Hold that shape! Horns down, reset to count 32!"*
- Under normal playback, lighting fades out after its programmed duration.
- Tapping `[FREEZE SCENE]` overrides the cue countdown timer, locking all field props in their current visual state indefinitely so the visual staff can evaluate alignment from the tower.
- Tapping `[RELEASE]` restores normal show playback.

### C. Live Palette Auditioning
- High school stadium lighting varies drastically: older metal-halide lights have strong green/yellow spikes ($4,200\text{K}$), while modern LED floodlights are crisp daylight ($5,600\text{K}$).
- A color that looks great in the band hall may look washed out on the field.
- From the tower, the visual designer can tap a color slider to shift a cue from Pale Amber (`#FFE082`) to Deep Gold (`#FFB300`) and see the physical props update in real time.

---

## 7. Estimated Fabrication & Procurement Add-On Cost

The modular touchscreen controller is engineered as a low-cost, zero-risk accessory utilizing standard COTS mounting hardware. Bands can use an existing school-owned iPad or purchase a dedicated budget tablet:

| Item | Component Description | Source | Part Number / Link | Qty | Unit Cost | Total Cost |
|:---:|---|---|---|:---:|:---:|:---:|
| 1 | Heavy-Duty 1.5″ Percussion Rail Clamp | Amazon / Sweetwater | Gibraltar SC-GPRMC or RAM-271U-12 | 1 | $24.99 | $24.99 |
| 2 | RAM Mount 1.5″ Double-Socket Arm (5.6″) | Amazon / RAM Mount | RAM-201U (C-Size Ball) | 1 | $26.49 | $26.49 |
| 3 | Universal 10″ Spring-Loaded Tablet Cradle | Amazon / RAM Mount | RAM Tab-Tite `RAM-HOL-TAB20U` | 1 | $32.95 | $32.95 |
| 4 | Right-Angle USB-C Charging Pigtail (1.5 ft) | Amazon | CableCreation Right-Angle USB-C | 1 | $6.99 | $6.99 |
| **Subtotal** | **Complete Mechanical Rail Mount & Cradle Kit** | — | — | — | — | **$91.42** |
| *Opt. 5* | *10.2″ Tablet (Amazon Fire HD 10 or iPad 9th Gen)* | *School Stock / Amazon* | *Amazon Fire HD 10 (Refurb/Sale)* | *1* | *$89.99* | *$89.99* |
| **Total** | **Optional Add-On Bundle (Mount + Dedicated Rehearsal Tablet)** | — | — | — | — | **$181.41** |

*Note: If the band program already owns an instructional iPad or student tablet, the total investment is strictly **$91.42** for the commercial-grade rail mounting hardware.*

---

## 8. Verification & Acceptance Criteria

To ensure full compliance with PCHSMB engineering and competition safety rules, Plan 002 must pass the following verification gates:

1. **Autonomous Operation Invariant:**  
   Power down or disconnect the tablet entirely. Execute a full 16-cue show run using only the physical Synapse console buttons. Verify zero errors, zero latency degradation, and 100% cue reception across all field props.
2. **Mechanical Shock & Vibration Test:**  
   Mount the tablet cradle to a Yamaha percussion cart. Wheel the cart over uneven grass turf and a $1.0\text{ in.}$ track curb transition at normal marching pace. Verify zero slippage of the rail clamp and zero dislodgement of the tablet from the cradle fingers.
3. **Quick-Release Egress Speed:**  
   Verify that an operator can unclamp and lift the tablet out of the mount in $T \le 2.0\,\text{seconds}$ using one hand.
4. **Roaming Wi-Fi Coverage & Latency:**  
   With the Synapse console at the front sideline 50-yard line, walk the tablet to:
   - Midfield observation tower ($30\text{ ft}$ height, 20 yards back): Verify RSSI $\ge -65\,\text{dBm}$ and WebSocket round-trip ping latency $\le 20\,\text{ms}$.
   - Home stadium press box (Row 30, elevation 50 ft): Verify RSSI $\ge -75\,\text{dBm}$ and round-trip ping latency $\le 35\,\text{ms}$.
   - Soft cue trigger to physical field prop visual downbeat latency must not exceed $T \le 45.0\,\text{ms}$ total.
5. **Direct Sunlight Legibility:**  
   Deploy tablet in Direct Sunlight ($> 80,000\text{ lux}$). Verify that active cue numbers, progress bars, and battery indicators are clearly legible in High-Contrast Daylight mode from an arm's length viewing distance ($60\text{ cm}$).
