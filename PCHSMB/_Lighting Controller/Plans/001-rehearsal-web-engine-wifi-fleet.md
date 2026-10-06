# Implementation Plan 001: Web-Based Rehearsal Configuration Engine & LoRa-Orchestrated Wi-Fi Fleet Reprogramming

**Project:** PCHSMB Universal Field Prop Lighting Control System  
**Status:** Promoted from Idea 001 / Architecture Approved  
**Target Subsystem:** Synapse Master Console (`PCB-SYNAPSE-V1`) & Peripheral Prop Nodes (`PCB-PROP-NODE-V1`)  
**Applicable Requirements:** `REQ-SYS-03`, `REQ-SYN-07`, `REQ-SW-01`, `REQ-SW-04`, `REQ-SW-09`

---

## 1. Problem Statement & Motivation

During competition performances, the PCHSMB Lighting Control System operates with strict RF discipline:
- 100% of communication is conducted over **Sub-GHz (902–928 MHz) LoRa broadcast** (`REQ-SYS-03`).
- 2.4 GHz and 5.0 GHz Wi-Fi radios are **strictly disabled** to prevent packet loss in crowded stadium RF environments and conserve battery power.
- Show definitions are loaded offline via USB flash drive drag-and-drop (`REQ-SW-03`).

However, during **multi-hour daily rehearsals on the practice field** or prep sessions in the shop:
1. Rehearsal staging carts operate from $120\text{V}$ AC shore power or cart inverters.
2. Band directors and visual staff frequently make rapid, iterative adjustments to cue downbeat timings, color shades, fade durations, and group assignments.
3. Manually unplugging USB drives, walking between props, or repeatedly flashing MCU firmware over USB cables slows rehearsal pacing.

### Desired Outcome
Provide an **optional, shore-powered configuration and staging engine** embedded inside the Synapse Master Console. When enabled during rehearsal, any web browser on the local private network can adjust show cues, test lighting scenes, monitor fleet battery levels, and execute fleet-wide Over-The-Air (OTA) updates. Crucially, peripheral prop Wi-Fi is strictly controlled on-demand via 915 MHz LoRa commands, ensuring zero battery waste and guaranteeing the fleet returns to silent Sub-GHz operation before competition performance.

---

## 2. Hardware Architecture & Interconnects

```
+===================================================================================+
|                       SYNAPSE CONSOLE (REHEARSAL EXPANSION)                       |
|                                                                                   |
|  [Shore Power / Aux Bus]                                                          |
|       │                                                                           |
|       ├──────────────► [Aux Switched 5V/3A Buck]                                  |
|       │                     │                                                     |
|       │                     ├───────────────────────┐                             |
|       │                     ▼                       ▼                             |
|       │            ┌─────────────────┐     ┌──────────────────┐                   |
|       │            │ GL.iNet Micro   │     │ Raspberry Pi     │                   |
|       │            │ Travel Router   │◄───►│ (Zero 2 W / 4)   │                   |
|       │            │ (2.4 / 5.0 GHz) │ ETH │ Fast-API Server  │                   |
|       │            └─────────────────┘     └────────┬─────────┘                   |
|       │                                             │ High-Speed UART             |
|       │                                             ▼ (GPIO 43/44, 921600 baud)   |
|       └──────────────► [Dual Ideal Diode OR]                                      |
|                             │                                                     |
|                             ▼                                                     |
|                    ┌──────────────────────────────────────────┐                   |
|                    │ Primary Synapse Carrier (PCB-SYNAPSE-V1) │                   |
|                    │ • Heltec ESP32-S3 Core                   │                   |
|                    │ • Semtech SX1262 LoRa Transceiver        │                   |
|                    │ • 16-Button Physical Fingertip Panel     │                   |
|                    │ • Rotary Encoder & 128x64 OLED           │                   |
|                    └────────────────────┬─────────────────────┘                   |
+=========================================│=========================================+
                                          │ 902–928 MHz LoRa Broadcast
                                          │
                   ┌──────────────────────┴──────────────────────┐
                   ▼                                             ▼
          ┌─────────────────┐                           ┌─────────────────┐
          │   PROP NODE 1   │                           │   PROP NODE N   │
          │ • SX1262 LoRa   │                           │ • SX1262 LoRa   │
          │ • ESP32-S3 Wi-Fi│                           │ • ESP32-S3 Wi-Fi│
          │   (ON-DEMAND)   │                           │   (ON-DEMAND)   │
          └─────────────────┘                           └─────────────────┘
```

### Component Details
1. **Travel Router:** GL.iNet GL-MT300N (Mango) or GL-SFT1200 (Opal). Compact form factor, 5V DC powered, dual-band 2.4/5.0 GHz, private SSID `PCHSMB-Lighting-Rehearsal`.
2. **Single-Board Computer (SBC):** Raspberry Pi Zero 2 W or Raspberry Pi 4. Runs headless Linux, hosting a lightweight FastAPI Python application, WebSockets engine, and local SQLite cache.
3. **Power Isolation:** The SBC and router run on an independently switched 5V auxiliary rail. When running on internal battery during competition field staging, this rail is unpowered, ensuring zero battery drain and complete radio silence.
4. **Primary Console Link:** High-speed full-duplex UART (`GPIO 43/44` on the Heltec ESP32-S3) running at $921,600\,\text{baud}$ with hardware flow control or framed packet messaging.

---

## 3. LoRa-Orchestrated Fleet Wi-Fi Wakeup Protocol

To prevent battery drain and eliminate RF noise during competition, prop nodes never broadcast or listen for Wi-Fi by default. Wi-Fi is treated as a temporary maintenance service triggered exclusively by LoRa packets:

1. **Wakeup Command:** When the user clicks *"Enter Fleet Wi-Fi Config"* on the web dashboard, the Raspberry Pi instructs the Synapse ESP32-S3 to broadcast a `CMD_WIFI_CONFIG_ENTER` packet over 915 MHz LoRa.
2. **Payload:** The packet contains:
   - Target Prop Mask (all props or specific node IDs)
   - Rehearsal SSID & WPA2 PSK hash
   - Automatic Timeout Duration ($T = 600\,\text{seconds}$)
3. **Node Connection:** Prop nodes receiving the packet spin up their ESP32-S3 Wi-Fi radio, authenticate with the travel router, and register with the Raspberry Pi server over HTTP/WebSocket.
4. **Fast Fleet Reprogramming:**
   - Show CSV profiles, individual cue edits, or firmware OTA binaries are transmitted over high-speed Wi-Fi in parallel.
   - Props report back calibration and battery telemetry.
5. **Return to Performance Mode:** Upon clicking *"Finalize & Exit"* (or upon expiration of the 10-minute watchdog timer), Synapse broadcasts `CMD_WIFI_CONFIG_EXIT`. All prop nodes immediately power down their Wi-Fi radios and return to dedicated 915 MHz LoRa listening.

---

## 4. Software Stack & API Architecture

- **Backend:** Python 3.11 + FastAPI + `uvicorn`.
- **Database:** Flat-file `show_cues.csv` backed by in-memory SQLite for instantaneous queries.
- **WebSocket Gateway:** Real-time event streaming (`/ws/rehearsal`) publishing:
  - Active Cue # and elapsed duration
  - Fleet Node telemetry (Prop ID, $V_{\text{bat}}$, RSSI, Wi-Fi status)
  - Console hardware events (button presses, rotary encoder turns)
- **Web Frontend:** Responsive HTML5/Vue.js dashboard providing cue editing, live trigger matrix, color picker, and OTA management.

---

## 5. Verification & Acceptance Criteria

1. **Power Isolation:** With auxiliary power switched OFF, the Synapse console operates entirely on USB or battery with zero current drawn by the Pi/router.
2. **Wakeup Latency:** All powered prop nodes within 100 meters connect to the travel router within $T \le 12.0\,\text{seconds}$ of LoRa wakeup command.
3. **Fleet Flash Speed:** New `show_cues.csv` distributes to 30+ connected nodes in $T \le 5.0\,\text{seconds}$ over Wi-Fi.
4. **Clean Exit:** Upon `CMD_WIFI_CONFIG_EXIT`, all nodes terminate Wi-Fi within $T \le 1.0\,\text{second}$ and verify 915 MHz LoRa reception.
