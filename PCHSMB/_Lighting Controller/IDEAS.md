# PCHSMB Universal Field Prop Lighting Control System — Ideas & Engineering Backlog

This document serves as the project inbox and engineering backlog for the **PCHSMB Universal Field Prop Lighting Control System**, following the engineering process and Human-in-the-Loop (HitL) workflow standard across all Pine Creek High School Marching Band subprojects.

---

## Active Ideas & Enhancement Queue

### Idea 001: Web-Based Rehearsal Configuration Engine & LoRa-Orchestrated Wi-Fi Fleet Reprogramming
- **Status:** **Active Backlog / Architectural Concept**
- **Author/Origin:** Staff / User Proposal (October 2026)
- **Concept Overview:**  
  Integrate an optional, shore-powered web configuration engine directly into the Synapse Master Console. When enabled during rehearsals or shop prep, any device with a standard web browser (iPad, iPhone, Android, laptop) connected to the local network can configure show cues, remap LED channels, monitor prop battery levels, and execute fleet-wide Over-The-Air (OTA) updates.

#### 1. Hardware Architecture (Console-Side Expansion)
* **Shore-Power Operation:** The configuration engine is intended primarily for rehearsals on the practice field or shop staging where the console is connected to $120\text{V}$ AC shore power (or a practice cart generator/inverter).
* **Integrated Travel Router:** A compact, high-efficiency COTS micro travel router (e.g., GL.iNet GL-MT300N or GL-SFT1200) embedded inside the Synapse console housing, powered by a switched auxiliary rail. It broadcasts a dedicated, secure private Wi-Fi network (e.g., `PCHSMB-Lighting-Rehearsal`, $2.4\text{ GHz} / 5.0\text{ GHz}$).
* **Embedded Single-Board Computer (SBC):** A low-power Raspberry Pi (e.g., Raspberry Pi Zero 2 W, Pi 4, or Pi 5) connected via Ethernet or internal Wi-Fi to the travel router, hosting a lightweight local web server (Python/FastAPI or Node.js) with a responsive browser dashboard.
* **Master Interconnect:** The Raspberry Pi communicates with the primary Heltec ESP32-S3 Synapse board via high-speed UART (`GPIO 43/44`) or SPI.

#### 2. LoRa-Orchestrated Fleet Wi-Fi Wakeup Protocol
A critical architectural invariant of the PCHSMB platform is that **live competition shows strictly prohibit 2.4 GHz Wi-Fi** due to severe RF congestion from thousands of spectator cellular devices in stadium stands, as well as battery conservation. 

This enhancement preserves that invariant by treating Wi-Fi on the peripheral prop nodes as an **on-demand, temporary service controlled over Sub-GHz LoRa**:

```
[FIELD REHEARSAL / SHORE POWER CONFIGURATION WORKFLOW]

  Staff iPad / Laptop
          │ (Connects to Wi-Fi: "PCHSMB-Lighting-Rehearsal")
          ▼
  ┌───────────────────────────────────────────────────────────┐
  │ SYNAPSE MASTER CONSOLE (SHORE POWERED)                    │
  │ • Compact Travel Router (Private 2.4/5GHz Network)        │
  │ • Raspberry Pi (Web Dashboard / Ingestion Engine)         │
  │ • Master ESP32-S3 + Semtech SX1262 LoRa Transceiver       │
  └─────────────────────────────┬─────────────────────────────┘
                                │
                                │ 902–928 MHz Sub-GHz Broadcast
                                │ Packet: CMD_WIFI_CONFIG_ENTER
                                │ (Payload: SSID, Hash, 10-Min Timeout)
                                │
         ┌──────────────────────┴──────────────────────┐
         ▼                                             ▼
  ┌─────────────────────────────┐               ┌─────────────────────────────┐
  │ PROP NODE 01 (Backdrop 1)   │               │ PROP NODE 16 (Duck Blind 8) │
  │ • SX1262 receives command   │               │ • SX1262 receives command   │
  │ • Enables ESP32-S3 Wi-Fi    │  ... [FLEET]  │ • Enables ESP32-S3 Wi-Fi    │
  │ • Connects to Travel Router │               │ • Connects to Travel Router │
  │ • Exposes OTA Update Socket │               │ • Exposes OTA Update Socket │
  └──────────────┬──────────────┘               └──────────────┬──────────────┘
                 │                                             │
                 └──────────────┐               ┌──────────────┘
                                ▼               ▼
                  High-Speed Parallel Wi-Fi Data Plane
                  • Batch Upload new show_cues.csv
                  • Real-Time Color & Mapping Tweaks
                  • Parallel Firmware OTA Updates
                  • Battery Voltage & RF RSSI Telemetry
                                │
                                ▼
  ┌───────────────────────────────────────────────────────────┐
  │ TIMEOUT OR STAFF COMMAND: "FINALIZE & RETURN TO PERFORMANCE" │
  │ • Synapse broadcasts: CMD_WIFI_CONFIG_EXIT (915 MHz)      │
  │ • All Prop Nodes shut down Wi-Fi radios completely        │
  │ • System enters pure, silent 915 MHz performance mode     │
  └───────────────────────────────────────────────────────────┘
```

#### 3. Operational Advantages & Trade-Offs
* **Advantages:**
  1. **Zero-Touch Fleet Reprogramming:** Band staff can sit in the press box or rehearsal scissor lift with an iPad, tweak cue timings or color hex codes, and push the update to all 30+ props scattered across the football field in $< 10$ seconds.
  2. **Multi-Platform Access:** Zero client apps to install; works on iOS Safari, Android Chrome, Windows, and macOS.
  3. **Preserves Battery & Competition Integrity:** Prop node Wi-Fi stays **100% OFF** during competition performance runs. Zero battery drain from continuous Wi-Fi scanning; zero RF interference during judged shows.
  4. **Parallel Telemetry:** Before running the show, the web dashboard displays a live green/yellow/red battery status and signal strength grid for every prop node on the field.
* **Trade-Offs & Design Considerations:**
  1. **Console Enclosure Size & Weight:** Integrating a Raspberry Pi, travel router, and 5V power supply requires slightly larger console volume (easily accommodated in the 3D-printed modular chassis).
  2. **Power Isolation:** The Pi and router must be on a separate power switch or relay so they draw zero current when running the Synapse console purely on battery during competition field deployment.

---

### Idea 002: Wireless Bluetooth Low Energy (BLE) Local Prop Diagnostics
- **Status:** Creative Backlog
- **Concept:** When a parent volunteer or technician approaches an individual prop with a smartphone, an onboard BLE beacon (using the ESP32-S3's secondary radio) provides instant, close-range ($< 2\text{ m}$) health diagnostics (battery percentage, hardware Prop ID, last received LoRa packet timestamp) without entering network mode.
- **Trade-Off:** Low battery impact; requires an iOS/Android web-Bluetooth page or light terminal.

---

### Idea 003: Onboard Removable MicroSD / USB Mass Storage Logging
- **Status:** Evaluated for Phase 2
- **Concept:** Add a micro-SD card socket to the Synapse Carrier Board to record detailed event logs: packet transmission timestamps, button press latencies, audio click trigger markers, and error events for post-rehearsal analysis.
- **Benefit:** High diagnostic utility during initial season bring-up.

---

### Idea 004: SMPTE LTC Hardware Timecode Decoder Sub-Board
- **Status:** Future Enhancement
- **Concept:** If future marching band productions transition from live manual button triggering to automated electronic backing track sync, design a drop-in analog front-end filter and LTC decoder chip (or dedicated software zero-crossing interrupt detector) on the $3.5\text{ mm}$ line-in jack to auto-fire cues synchronized to the studio click track.
- **Benefit:** Fully automates the light show to electronic audio tracks without human finger latency.


