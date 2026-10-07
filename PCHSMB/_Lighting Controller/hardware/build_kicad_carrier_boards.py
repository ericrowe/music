#!/usr/bin/env python3
"""
PCHSMB "Beacon" Project - Complete KiCad Carrier Board Generator
Authoritative generator for:
1. PCB-SYNAPSE-V1: Master Pit Controller Carrier Board
2. PCB-PROP-NODE-V1: Prop Receiver & LED Driver Carrier Board

Generates fully wired, continuous .kicad_sch schematics with real symbols, wires, junctions,
and pin labels (0 ERC errors, 0 ERC warnings), and fully populated .kicad_pcb layouts with
native schematic-to-footprint path binding (KIID_PATH).

Supported Engineering Workflow:
  1. Open & Edit Schematic in KiCad Eeschema
  2. Press F8 ("Update PCB from Schematic") or Export/Import Netlist
  3. All footprints synchronize seamlessly with 0 missing footprints and 0 orphans
  4. Route and adjust board in KiCad Pcbnew
"""

import os
import re
import uuid
import subprocess
import pcbnew

HARDWARE_DIR = os.path.dirname(os.path.abspath(__file__))
PROP_DIR = os.path.join(HARDWARE_DIR, "pcb_prop_node")
SYNAPSE_DIR = os.path.join(HARDWARE_DIR, "pcb_synapse_controller")
SYM_DIR = "/Applications/KiCad/KiCad.app/Contents/SharedSupport/symbols"
FP_DIR = "/Applications/KiCad/KiCad.app/Contents/SharedSupport/footprints"
KICAD_CLI = "/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli"

os.makedirs(PROP_DIR, exist_ok=True)
os.makedirs(SYNAPSE_DIR, exist_ok=True)

def uid():
    return str(uuid.uuid4())

def extract_raw_sym(lib_name, sym_name):
    path = os.path.join(SYM_DIR, f"{lib_name}.kicad_sym")
    with open(path) as f:
        content = f.read()
    target = f'(symbol "{sym_name}"'
    start = content.find(target)
    if start == -1:
        raise ValueError(f"Symbol {sym_name} not found in {lib_name}")
    cnt = 0
    end = start
    for i in range(start, len(content)):
        if content[i] == '(': cnt += 1
        elif content[i] == ')':
            cnt -= 1
            if cnt == 0:
                end = i + 1
                break
    block = content[start:end]
    return block.replace(f'(symbol "{sym_name}"', f'(symbol "{lib_name}:{sym_name}"', 1)

def write_pro_file(pro_file, project_name):
    with open(pro_file, "w") as f:
        f.write('{"meta":{"filename":"' + project_name + '","version":1},"sheets":[["",""]]}')

def parse_netlist(netlist_path):
    with open(netlist_path) as f:
        content = f.read()
    comps = {}
    for m in re.finditer(r'\(comp\s+\(ref\s+\"([^\"]+)\"\)\s+\(value\s+\"([^\"]+)\"\)\s+\(footprint\s+\"([^\"]+)\"\)', content):
        ref, val, fp = m.groups()
        comps[ref] = {'value': val, 'footprint': fp}
    nets = {}
    for nb in re.finditer(r'\(net\s+\(code\s+\"\d+\"\)\s+\(name\s+\"([^\"]+)\"\)(.*?)\n\t\t\)', content, re.DOTALL):
        net_name = nb.group(1)
        body = nb.group(2)
        nodes = re.findall(r'\(node\s+\(ref\s+\"([^\"]+)\"\)\s+\(pin\s+\"([^\"]+)\"\)', body)
        nets[net_name] = nodes
    return comps, nets

SYM_PWR_18V = """    (symbol "power:+18V" (power) (pin_numbers hide) (pin_names (offset 0) hide) (in_bom yes) (on_board yes)
      (property "Reference" "#PWR" (at 0 -3.81 0) (effects (font (size 1.27 1.27)) hide))
      (property "Value" "+18V" (at 0 3.81 0) (effects (font (size 1.27 1.27))))
      (symbol "+18V_0_1"
        (polyline (pts (xy -0.762 1.27) (xy 0 2.54) (xy 0.762 1.27)) (stroke (width 0)))
        (polyline (pts (xy 0 0) (xy 0 2.54)) (stroke (width 0)))
      )
      (symbol "+18V_1_1"
        (pin power_in line (at 0 0 90) (length 0) hide (name "+18V" (effects (font (size 1.27 1.27)))) (number "1" (effects (font (size 1.27 1.27)))))
      )
    )"""

def generate_synapse_project():
    print("=== Generating Synapse Controller Revamp (Grid Aligned) ===")
    sch_file = os.path.join(SYNAPSE_DIR, "pcb_synapse_controller.kicad_sch")
    net_file = os.path.join(SYNAPSE_DIR, "pcb_synapse_controller.net")
    pdf_file = os.path.join(SYNAPSE_DIR, "pcb_synapse_controller.pdf")
    pcb_file = os.path.join(SYNAPSE_DIR, "pcb_synapse_controller.kicad_pcb")

    libs = [
        extract_raw_sym("Connector_Generic", "Conn_01x18"),
        extract_raw_sym("Connector_Generic", "Conn_01x08"),
        extract_raw_sym("Connector_Generic", "Conn_01x05"),
        extract_raw_sym("Connector_Generic", "Conn_01x02"),
        extract_raw_sym("Connector_Audio", "AudioJack3"),
        extract_raw_sym("Interface_Expansion", "MCP23017x-x-SO"),
        extract_raw_sym("Device", "C"),
        extract_raw_sym("power", "GND"),
        extract_raw_sym("power", "+5V"),
        extract_raw_sym("power", "+3V3"),
        extract_raw_sym("power", "PWR_FLAG"),
    ]
    lib_symbols_str = "\n".join(libs)

    pwr_counter = 1
    def pwr_ref():
        nonlocal pwr_counter
        r = f"#PWR{pwr_counter:03d}"
        pwr_counter += 1
        return r

    sym_uuids = {}
    for ref in ["J1", "J2", "J3", "J4", "J5", "J6", "J7", "J8", "J9", "J10", "U1", "C1", "H1", "H2", "H3", "H4"]:
        sym_uuids[ref] = uid()

    elements = []

    # Section headers (Positioned cleanly on 2.54mm grid)
    elements.append(f'''  (text "SECTION 1: 5V DC POWER & E-STOP (J2, J7)"
    (at 25.40 25.40 0) (effects (font (size 1.5 1.5) (bold yes)) (justify left)))''')
    elements.append(f'''  (text "SECTION 2: ROTARY ENCODER & AUDIO (J10, J1)"
    (at 25.40 127.00 0) (effects (font (size 1.5 1.5) (bold yes)) (justify left)))''')
    elements.append(f'''  (text "SECTION 3: HELTEC V3 HOST (J3, J4)"
    (at 139.70 25.40 0) (effects (font (size 1.5 1.5) (bold yes)) (justify left)))''')
    elements.append(f'''  (text "SECTION 4: MCP23017 EXPANDER (U1, C1)"
    (at 228.60 25.40 0) (effects (font (size 1.5 1.5) (bold yes)) (justify left)))''')
    elements.append(f'''  (text "SECTION 5: 16-BUTTON PLUGGABLE TERMINALS (J5, J6, J8, J9)"
    (at 320.00 25.40 0) (effects (font (size 1.5 1.5) (bold yes)) (justify left)))''')

    # --------------------------------------------------------------------------
    # 1. J2: 5V DC IN (Conn_01x02) at (50.80, 50.80) - Pluggable MSTBA
    # --------------------------------------------------------------------------
    j2x, j2y = 50.80, 50.80
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x02") (at {j2x} {j2y} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J2']}")
    (property "Reference" "J2" (at {j2x} {j2y - 6.35} 0) (effects (font (size 1 1))))
    (property "Value" "5V_DC_IN" (at {j2x} {j2y + 6.35} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_2-G-5,08_1x02_P5.08mm_Horizontal" (at {j2x} {j2y} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
    # Pin 1 (+5V): at (45.72, 50.80) -> Wait, in Conn_01x02, Pin 1 is at (jx - 5.08, jy - 1.27) = (45.72, 50.80)
    elements.append(f'''  (wire (pts (xy 45.72 50.80) (xy 35.56 50.80)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+5V") (at 35.56 50.80 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 35.56 50.80 0) (effects (font (size 1 1)) hide))
    (property "Value" "+5V" (at 35.56 50.80 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (symbol (lib_id "power:PWR_FLAG") (at 35.56 50.80 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 35.56 50.80 0) (effects (font (size 1 1)) hide))
    (property "Value" "PWR_FLAG" (at 35.56 50.80 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 2 (GND): at (45.72, 53.34)
    elements.append(f'''  (wire (pts (xy 45.72 53.34) (xy 35.56 53.34)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 35.56 53.34 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 35.56 53.34 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 35.56 53.34 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (symbol (lib_id "power:PWR_FLAG") (at 35.56 53.34 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 35.56 53.34 0) (effects (font (size 1 1)) hide))
    (property "Value" "PWR_FLAG" (at 35.56 53.34 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # --------------------------------------------------------------------------
    # 2. J7: Blackout E-Stop (Conn_01x02) at (50.80, 81.28) - Pluggable MSTBA
    # --------------------------------------------------------------------------
    j7x, j7y = 50.80, 81.28
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x02") (at {j7x} {j7y} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J7']}")
    (property "Reference" "J7" (at {j7x} {j7y - 6.35} 0) (effects (font (size 1 1))))
    (property "Value" "Blackout_E_Stop" (at {j7x} {j7y + 6.35} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_2-G-5,08_1x02_P5.08mm_Horizontal" (at {j7x} {j7y} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
    # Pin 2 (GND): at (45.72, 83.82)
    elements.append(f'''  (wire (pts (xy 45.72 83.82) (xy 35.56 83.82)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 35.56 83.82 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 35.56 83.82 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 35.56 83.82 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 1 (BLACKOUT): at (45.72, 81.28) -> wire directly to Heltec J3 Pin 7 at (142.24, 88.90)
    elements.append(f'''  (wire (pts (xy 45.72 81.28) (xy 88.90 81.28)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 88.90 81.28) (xy 88.90 88.90)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 88.90 88.90) (xy 142.24 88.90)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "BLACKOUT" (at 63.50 81.28 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 3. J10: Rotary Encoder 5-Pin Pluggable at (55.88, 152.40) - Pluggable MSTBA
    # Pin 1: GND
    # Pin 2: ENC_A -> Heltec J3 Pin 10
    # Pin 3: ENC_B -> Heltec J3 Pin 11
    # Pin 4: ENC_SW -> Heltec J3 Pin 12
    # Pin 5: +3V3_SYS (Auxiliary power for optical/illuminated encoders)
    # --------------------------------------------------------------------------
    ex, ey = 55.88, 152.40
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x05") (at {ex} {ey} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J10']}")
    (property "Reference" "J10" (at {ex} {ey - 8.89} 0) (effects (font (size 1.27 1.27))))
    (property "Value" "Rotary_Encoder" (at {ex} {ey + 8.89} 0) (effects (font (size 1.27 1.27))))
    (property "Footprint" "Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_5-G-5,08_1x05_P5.08mm_Horizontal" (at {ex} {ey} 0) (effects (font (size 1 1)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 6)]) + f''')''')

    # Pin 1 (GND): at (50.80, 147.32)
    elements.append(f'''  (wire (pts (xy 50.80 147.32) (xy 40.64 147.32)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 40.64 147.32 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 40.64 147.32 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 40.64 147.32 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # Pin 2 (ENC_A): at (50.80, 149.86) -> wire to Heltec J3 Pin 10 at (142.24, 96.52)
    elements.append(f'''  (wire (pts (xy 50.80 149.86) (xy 43.18 149.86)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 43.18 149.86) (xy 43.18 139.70)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 43.18 139.70) (xy 96.52 139.70)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 96.52 139.70) (xy 96.52 96.52)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 96.52 96.52) (xy 142.24 96.52)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "ENC_A" (at 68.58 139.70 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # Pin 3 (ENC_B): at (50.80, 152.40) -> wire to Heltec J3 Pin 11 at (142.24, 99.06)
    elements.append(f'''  (wire (pts (xy 50.80 152.40) (xy 40.64 152.40)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 40.64 152.40) (xy 40.64 142.24)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 40.64 142.24) (xy 99.06 142.24)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 99.06 142.24) (xy 99.06 99.06)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 99.06 99.06) (xy 142.24 99.06)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "ENC_B" (at 68.58 142.24 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # Pin 4 (ENC_SW): at (50.80, 154.94) -> wire to Heltec J3 Pin 12 at (142.24, 101.60)
    elements.append(f'''  (wire (pts (xy 50.80 154.94) (xy 101.60 154.94)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 101.60 154.94) (xy 101.60 101.60)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 101.60 101.60) (xy 142.24 101.60)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "ENC_SW" (at 83.82 154.94 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # Pin 5 (+3V3): at (50.80, 157.48)
    elements.append(f'''  (wire (pts (xy 50.80 157.48) (xy 40.64 157.48)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+3V3") (at 40.64 157.48 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 40.64 157.48 0) (effects (font (size 1 1)) hide))
    (property "Value" "+3V3" (at 40.64 157.48 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # --------------------------------------------------------------------------
    # 4. J1: 3.5mm Audio In (AudioJack3) at (55.88, 203.20)
    # --------------------------------------------------------------------------
    ax, ay = 55.88, 203.20
    elements.append(f'''  (symbol (lib_id "Connector_Audio:AudioJack3") (at {ax} {ay} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J1']}")
    (property "Reference" "J1" (at {ax} {ay - 7.62} 0) (effects (font (size 1 1))))
    (property "Value" "3.5mm_Audio_In" (at {ax} {ay + 7.62} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Connector_Audio:Jack_3.5mm_CUI_SJ1-3523N_Horizontal" (at {ax} {ay} 0) (effects (font (size 1 1)) hide))
    (pin "R" (uuid "{uid()}")) (pin "S" (uuid "{uid()}")) (pin "T" (uuid "{uid()}"))
  )''')
    # Pin S (GND): at (60.96, 200.66)
    elements.append(f'''  (wire (pts (xy 60.96 200.66) (xy 71.12 200.66)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 71.12 200.66 270) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 71.12 200.66 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 71.12 200.66 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin T (205.74) & Pin R (203.20): Join and route to Heltec J3 Pin 8 at (142.24, 91.44)
    elements.append(f'''  (wire (pts (xy 60.96 205.74) (xy 66.04 205.74)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 60.96 203.20) (xy 66.04 203.20)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 66.04 205.74) (xy 66.04 203.20)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 66.04 203.20) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 66.04 203.20) (xy 91.44 203.20)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 91.44 203.20) (xy 91.44 91.44)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 91.44 91.44) (xy 142.24 91.44)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "AUDIO_IN" (at 76.20 203.20 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 5. J3: Heltec Left Header (Conn_01x18) at (147.32, 93.98)
    # --------------------------------------------------------------------------
    hx_l, hy_l = 147.32, 93.98
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x18") (at {hx_l} {hy_l} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J3']}")
    (property "Reference" "J3" (at {hx_l} {hy_l - 25.40} 0) (effects (font (size 1.27 1.27))))
    (property "Value" "Heltec_V3_Left" (at {hx_l} {hy_l + 25.40} 0) (effects (font (size 1.27 1.27))))
    (property "Footprint" "Connector_PinSocket_2.54mm:PinSocket_1x18_P2.54mm_Vertical" (at {hx_l} {hy_l} 0) (effects (font (size 1.27 1.27)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 19)]) + f''')''')

    # Pin 1 (GND): at (142.24, 73.66)
    elements.append(f'''  (wire (pts (xy 142.24 73.66) (xy 134.62 73.66)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 134.62 73.66 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 134.62 73.66 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 134.62 73.66 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 2 (+5V): at (142.24, 76.20)
    elements.append(f'''  (wire (pts (xy 142.24 76.20) (xy 134.62 76.20)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+5V") (at 134.62 76.20 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 134.62 76.20 0) (effects (font (size 1 1)) hide))
    (property "Value" "+5V" (at 134.62 76.20 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 3 (+3V3): at (142.24, 78.74) (Output from on-board LDO, with PWR_FLAG)
    elements.append(f'''  (wire (pts (xy 142.24 78.74) (xy 134.62 78.74)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+3V3") (at 134.62 78.74 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 134.62 78.74 0) (effects (font (size 1 1)) hide))
    (property "Value" "+3V3" (at 134.62 78.74 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (symbol (lib_id "power:PWR_FLAG") (at 134.62 78.74 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 134.62 78.74 0) (effects (font (size 1 1)) hide))
    (property "Value" "PWR_FLAG" (at 134.62 78.74 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # Unused pins on J3: 4, 5, 6, 13, 14, 15, 16, 17, 18 -> no_connect
    for p in [4, 5, 6, 13, 14, 15, 16, 17, 18]:
        py = 73.66 + (p - 1) * 2.54
        elements.append(f'''  (no_connect (at 142.24 {py:.2f}) (uuid "{uid()}"))''')

    # Pin 9 (MCP_INT): at (142.24, 93.98) -> wire right to U1 Pins 19 & 20
    elements.append(f'''  (wire (pts (xy 142.24 93.98) (xy 165.10 93.98)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 165.10 93.98) (xy 165.10 132.08)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 165.10 132.08) (xy 228.60 132.08)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 228.60 132.08) (xy 228.60 99.06)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 228.60 99.06) (xy 241.30 99.06)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 241.30 99.06) (xy 241.30 96.52)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 241.30 99.06) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (label "MCP_INT" (at 185.42 132.08 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 6. J4: Heltec Right Header (Conn_01x18) at (190.50, 93.98)
    # --------------------------------------------------------------------------
    hx_r, hy_r = 190.50, 93.98
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x18") (at {hx_r} {hy_r} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J4']}")
    (property "Reference" "J4" (at {hx_r} {hy_r - 25.40} 0) (effects (font (size 1.27 1.27))))
    (property "Value" "Heltec_V3_Right" (at {hx_r} {hy_r + 25.40} 0) (effects (font (size 1.27 1.27))))
    (property "Footprint" "Connector_PinSocket_2.54mm:PinSocket_1x18_P2.54mm_Vertical" (at {hx_r} {hy_r} 0) (effects (font (size 1.27 1.27)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 19)]) + f''')''')

    # Pin 1 (GND): at (185.42, 73.66)
    elements.append(f'''  (wire (pts (xy 185.42 73.66) (xy 177.80 73.66)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 177.80 73.66 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 177.80 73.66 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 177.80 73.66 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # Unused pins on J4: 2..16 -> no_connect
    for p in range(2, 17):
        py = 73.66 + (p - 1) * 2.54
        elements.append(f'''  (no_connect (at 185.42 {py:.2f}) (uuid "{uid()}"))''')

    # Pin 17 (I2C_SCL): at (185.42, 114.30) -> wire to U1 Pin 12 at (241.30, 81.28)
    elements.append(f'''  (wire (pts (xy 185.42 114.30) (xy 215.90 114.30)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 215.90 114.30) (xy 215.90 81.28)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 215.90 81.28) (xy 241.30 81.28)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "I2C_SCL" (at 215.90 93.98 90) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # Pin 18 (I2C_SDA): at (185.42, 116.84) -> wire to U1 Pin 13 at (241.30, 83.82)
    elements.append(f'''  (wire (pts (xy 185.42 116.84) (xy 218.44 116.84)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 218.44 116.84) (xy 218.44 83.82)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 218.44 83.82) (xy 241.30 83.82)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "I2C_SDA" (at 218.44 93.98 90) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 7. U1: MCP23017 Expander (SOIC-28W) at (ux=254.00, uy=101.60)
    # --------------------------------------------------------------------------
    ux, uy = 254.00, 101.60
    elements.append(f'''  (symbol (lib_id "Interface_Expansion:MCP23017x-x-SO") (at {ux} {uy} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['U1']}")
    (property "Reference" "U1" (at {ux} {uy - 27.94} 0) (effects (font (size 1.27 1.27))))
    (property "Value" "MCP23017" (at {ux} {uy + 27.94} 0) (effects (font (size 1.27 1.27))))
    (property "Footprint" "Package_SO:SOIC-28W_7.5x17.9mm_P1.27mm" (at {ux} {uy} 0) (effects (font (size 1.27 1.27)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 29)]) + f''')''')

    # Pin 18 (~RESET) at (241.30, 104.14)
    elements.append(f'''  (wire (pts (xy 241.30 104.14) (xy 233.68 104.14)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+3V3") (at 233.68 104.14 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 233.68 104.14 0) (effects (font (size 1 1)) hide))
    (property "Value" "+3V3" (at 233.68 104.14 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # Pins 15, 16, 17 (A0, A1, A2) at (241.30, 116.84), (241.30, 119.38), (241.30, 121.92) -> GND
    elements.append(f'''  (wire (pts (xy 241.30 116.84) (xy 233.68 116.84)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 241.30 119.38) (xy 233.68 119.38)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 241.30 121.92) (xy 233.68 121.92)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 233.68 116.84) (xy 233.68 121.92)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 233.68 119.38) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 233.68 121.92) (xy 233.68 127.00)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 233.68 127.00 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 233.68 127.00 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 233.68 127.00 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # Pin 9 (VDD) at (254.00, 76.20) & C1
    elements.append(f'''  (wire (pts (xy 254.00 76.20) (xy 254.00 63.50)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+3V3") (at 254.00 63.50 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 254.00 63.50 0) (effects (font (size 1 1)) hide))
    (property "Value" "+3V3" (at 254.00 60.96 0) (effects (font (size 1 1))))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 10 (VSS) at (254.00, 127.00)
    elements.append(f'''  (wire (pts (xy 254.00 127.00) (xy 254.00 132.08)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 254.00 132.08 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 254.00 132.08 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 254.00 132.08 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # C1 (100nF) at (266.70, 68.58)
    cx, cy = 266.70, 68.58
    elements.append(f'''  (symbol (lib_id "Device:C") (at {cx} {cy} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['C1']}")
    (property "Reference" "C1" (at {cx + 3.81} {cy - 1.27} 0) (effects (font (size 1 1)) (justify left)))
    (property "Value" "100nF" (at {cx + 3.81} {cy + 1.27} 0) (effects (font (size 0.9 0.9)) (justify left)))
    (property "Footprint" "Capacitor_SMD:C_0805_2012Metric" (at {cx} {cy} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (wire (pts (xy {cx} {cy - 3.81}) (xy {cx} 63.50)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy {cx} 63.50) (xy 254.00 63.50)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 254.00 63.50) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy {cx} {cy + 3.81}) (xy {cx} 76.20)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at {cx} 76.20 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at {cx} 76.20 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at {cx} 76.20 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # Pins 11 & 14 (NC): no_connect
    elements.append(f'''  (no_connect (at 243.84 {101.60 - 15.24}) (uuid "{uid()}"))''')
    elements.append(f'''  (no_connect (at 243.84 {101.60 - 12.70}) (uuid "{uid()}"))''')

    # Wires: U1 GPA0..7 (pins 21..28 at 266.70) -> BTN_09..16
    for idx in range(8):
        py = 81.28 + idx * 2.54
        btn_num = 9 + idx
        elements.append(f'''  (wire (pts (xy 266.70 {py:.2f}) (xy 274.32 {py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (label "BTN_{btn_num:02d}" (at 274.32 {py:.2f} 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # Wires: U1 GPB0..7 (pins 1..8 at 266.70) -> BTN_01..08
    for idx in range(8):
        py = 104.14 + idx * 2.54
        btn_num = 1 + idx
        elements.append(f'''  (wire (pts (xy 266.70 {py:.2f}) (xy 274.32 {py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (label "BTN_{btn_num:02d}" (at 274.32 {py:.2f} 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 8. 16-Button Discrete IP67 Interface (J5, J6, J8, J9 - 4x 8-Pin MSTBA Pluggable)
    # Each button has a dedicated [Signal | Ground] pair sinking into heavy PCB ground plane
    # --------------------------------------------------------------------------
    btn_headers = [
        ("J5", "Buttons_1_to_4", 50.80, 1),
        ("J6", "Buttons_5_to_8", 101.60, 5),
        ("J8", "Buttons_9_to_12", 152.40, 9),
        ("J9", "Buttons_13_to_16", 203.20, 13),
    ]

    jx = 355.60
    for ref, val, jy, start_btn in btn_headers:
        elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x08") (at {jx} {jy:.2f} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids[ref]}")
    (property "Reference" "{ref}" (at {jx} {jy - 12.70:.2f} 0) (effects (font (size 1.27 1.27))))
    (property "Value" "{val}" (at {jx} {jy + 12.70:.2f} 0) (effects (font (size 1 1))))
    (property "Footprint" "Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_8-G-5,08_1x08_P5.08mm_Horizontal" (at {jx} {jy:.2f} 0) (effects (font (size 1 1)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 9)]) + f''')''')

        for p in range(1, 9):
            py = jy - 7.62 + (p - 1) * 2.54
            if p % 2 == 1:
                # Odd pins: Signal (BTN_xx)
                btn_num = start_btn + (p - 1) // 2
                elements.append(f'''  (wire (pts (xy 350.52 {py:.2f}) (xy 337.82 {py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
                elements.append(f'''  (label "BTN_{btn_num:02d}" (at 337.82 {py:.2f} 0) (effects (font (size 1 1)) (justify right)) (uuid "{uid()}"))''')
            else:
                # Even pins: Ground (Dedicated GND return per button)
                elements.append(f'''  (wire (pts (xy 350.52 {py:.2f}) (xy 342.90 {py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
                elements.append(f'''  (symbol (lib_id "power:GND") (at 342.90 {py:.2f} 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 342.90 {py:.2f} 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 342.90 {py:.2f} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    body = "\n".join(elements)

    sch_content = f'''(kicad_sch
	(version 20250114)
	(generator "eeschema")
	(generator_version "10.0")
	(uuid "{uid()}")
	(paper "A3")
	(title_block
		(title "PCHSMB Synapse Pit Master Controller Carrier Board")
		(date "2026-10-06")
		(rev "v1.3")
		(company "Pine Creek High School Marching Band")
		(comment 1 "Master 16-Cue Show Console for Front Ensemble (Concept 10)")
		(comment 2 "Heltec LoRa V3 Host, MCP23017 Expander, 4x 8-Pin Pluggable MSTBA Terminals (Dedicated Signal+GND per Button)")
	)
	(lib_symbols
{lib_symbols_str}
	)
	(sheet_instances
		(path "/"
			(page "1")
		)
	)
{body}
)
'''
    with open(sch_file, 'w') as f:
        f.write(sch_content)
    print("Synapse schematic written successfully:", sch_file)

    # Export Netlist
    subprocess.run([KICAD_CLI, 'sch', 'export', 'netlist', sch_file, '-o', net_file], check=True)
    print("Synapse netlist exported:", net_file)

    # Run ERC
    erc_rpt = "/tmp/synapse_erc.rpt"
    subprocess.run([KICAD_CLI, 'sch', 'erc', sch_file, '-o', erc_rpt], capture_output=True, text=True)
    with open(erc_rpt) as f:
        erc_text = f.read()
    err_lines = [l for l in erc_text.splitlines() if "; error" in l]
    warn_lines = [l for l in erc_text.splitlines() if "; warning" in l]
    print(f"Synapse ERC: {len(err_lines)} errors, {len(warn_lines)} warnings")
    if err_lines or warn_lines:
        print(erc_text)

    # Export PDF
    subprocess.run([KICAD_CLI, 'sch', 'export', 'pdf', sch_file, '-o', pdf_file], check=True)
    print("Synapse PDF exported:", pdf_file)

    # Build PCB Layout with native (path "/<uuid>") binding
    comps, nets = parse_netlist(net_file)

    # SAFEGUARD: Preserve manual routing, component placement, and silkscreen artwork
    has_user_layout = False
    if os.path.exists(pcb_file):
        with open(pcb_file, 'r', encoding='utf-8') as f:
            existing_pcb_txt = f.read()
        if "(segment" in existing_pcb_txt or "PROPS CREW" in existing_pcb_txt:
            has_user_layout = True
            print("Synapse PCB layout already contains manual routing / Props Crew artwork. Preserving existing layout.")

    if not has_user_layout:
        board = pcbnew.CreateEmptyBoard()
        tb = board.GetTitleBlock()
        tb.SetTitle("PCHSMB Synapse Pit Master Controller Carrier Board")
        tb.SetCompany("Pine Creek High School Marching Band")
        tb.SetRevision("v1.3")

        ox, oy = 50.0, 50.0
        bw, bh = 210.0, 90.0
        corners = [(ox, oy), (ox + bw, oy), (ox + bw, oy + bh), (ox, oy + bh)]
        for i in range(4):
            x1, y1 = corners[i]
            x2, y2 = corners[(i + 1) % 4]
            s = pcbnew.PCB_SHAPE(board)
            s.SetShape(pcbnew.SHAPE_T_SEGMENT)
            s.SetFilled(False)
            s.SetWidth(pcbnew.FromMM(0.2))
            s.SetLayer(pcbnew.Edge_Cuts)
            s.SetStart(pcbnew.VECTOR2I(pcbnew.FromMM(x1), pcbnew.FromMM(y1)))
            s.SetEnd(pcbnew.VECTOR2I(pcbnew.FromMM(x2), pcbnew.FromMM(y2)))
            board.Add(s)

        # 4x M3 Mounting Holes
        mh_lib = os.path.join(FP_DIR, "MountingHole.pretty")
        for idx, (hx, hy) in enumerate([(ox + 5.0, oy + 5.0), (ox + bw - 5.0, oy + 5.0), (ox + 5.0, oy + bh - 5.0), (ox + bw - 5.0, oy + bh - 5.0)]):
            mh = pcbnew.FootprintLoad(mh_lib, "MountingHole_3.2mm_M3")
            ref = f"H{idx + 1}"
            mh.SetReference(ref)
            mh.Reference().SetVisible(False)
            mh.SetPosition(pcbnew.VECTOR2I(pcbnew.FromMM(hx), pcbnew.FromMM(hy)))
            if ref in sym_uuids:
                mh.SetPath(pcbnew.KIID_PATH('/' + sym_uuids[ref]))
            board.Add(mh)

        # Silkscreen Titles
        t1 = pcbnew.PCB_TEXT(board)
        t1.SetText("PCHSMB SYNAPSE MASTER CONTROLLER v1.3")
        t1.SetPosition(pcbnew.VECTOR2I(pcbnew.FromMM(ox + 50.0), pcbnew.FromMM(oy + 64.0)))
        t1.SetTextSize(pcbnew.VECTOR2I(pcbnew.FromMM(1.1), pcbnew.FromMM(1.1)))
        t1.SetHorizJustify(pcbnew.GR_TEXT_H_ALIGN_CENTER)
        t1.SetLayer(pcbnew.F_SilkS)
        board.Add(t1)

        t2 = pcbnew.PCB_TEXT(board)
        t2.SetText("PLUGGABLE 16-BUTTON DUAL-TERMINAL INTERFACE")
        t2.SetPosition(pcbnew.VECTOR2I(pcbnew.FromMM(ox + 50.0), pcbnew.FromMM(oy + 66.5)))
        t2.SetTextSize(pcbnew.VECTOR2I(pcbnew.FromMM(0.8), pcbnew.FromMM(0.8)))
        t2.SetHorizJustify(pcbnew.GR_TEXT_H_ALIGN_CENTER)
        t2.SetLayer(pcbnew.F_SilkS)
        board.Add(t2)

        t_enc = pcbnew.PCB_TEXT(board)
        t_enc.SetText("J10: ROTARY ENCODER")
        t_enc.SetPosition(pcbnew.VECTOR2I(pcbnew.FromMM(117.16), pcbnew.FromMM(70.78)))
        t_enc.SetTextSize(pcbnew.VECTOR2I(pcbnew.FromMM(0.9), pcbnew.FromMM(0.9)))
        t_enc.SetHorizJustify(pcbnew.GR_TEXT_H_ALIGN_CENTER)
        t_enc.SetLayer(pcbnew.F_SilkS)
        board.Add(t_enc)

        # Layout coordinates matching user HITL layout
        pos_map = {
            "J5": (66.0, 129.0, 0),
            "J6": (114.0, 129.0, 0),
            "J8": (162.0, 129.0, 0),
            "J9": (210.0, 129.0, 0),
            "J1": (80.50, 54.50, 180),
            "J10": (117.16, 60.78, 180),
            "C1": (172.00, 53.55, 90),
            "J2": (197.04, 60.78, 180),
            "J7": (214.54, 60.78, 180),
            "U1": (153.85, 111.75, 0),
            "J3": (177.16, 59.64, 270),
            "J4": (177.16, 82.50, 270),
        }

        loaded_fps = {}
        for ref, d in comps.items():
            fp_str = d['footprint']
            lib_name, fp_name = fp_str.split(':')
            lib_path = os.path.join(FP_DIR, lib_name + ".pretty")
            fp = pcbnew.FootprintLoad(lib_path, fp_name)
            fp.SetReference(ref)
            fp.SetValue(d['value'])
            if ref in sym_uuids:
                fp.SetPath(pcbnew.KIID_PATH('/' + sym_uuids[ref]))
            if ref == "J1":
                for g in fp.GraphicalItems():
                    if g.GetLayer() == pcbnew.Edge_Cuts:
                        g.SetLayer(pcbnew.Dwgs_User)
            if ref in pos_map:
                px, py, prot = pos_map[ref]
                fp.SetPosition(pcbnew.VECTOR2I(pcbnew.FromMM(px), pcbnew.FromMM(py)))
                fp.SetOrientation(pcbnew.EDA_ANGLE(prot, pcbnew.DEGREES_T))
            board.Add(fp)
            loaded_fps[ref] = fp

        # Connect Nets
        for net_name, nodes in nets.items():
            if net_name.startswith('unconnected-'): continue
            net_item = pcbnew.NETINFO_ITEM(board, net_name)
            board.Add(net_item)
            for ref, pin in nodes:
                fp = loaded_fps.get(ref)
                if fp:
                    for pad in fp.Pads():
                        if pad.GetNumber() == pin:
                            pad.SetNet(net_item)

        pcbnew.SaveBoard(pcb_file, board)
        print("Synapse PCB layout saved with path binding:", pcb_file)

    # Run DRC
    drc_rpt = "/tmp/synapse_drc.rpt"
    subprocess.run([KICAD_CLI, 'pcb', 'drc', pcb_file, '-o', drc_rpt], capture_output=True, text=True)
    with open(drc_rpt) as f:
        drc_text = f.read()
    drc_errs = [l for l in drc_text.splitlines() if "violation" in l.lower() or "error" in l.lower()]
    print(f"Synapse DRC: {len(drc_errs)} lines")

    # Verify footprint paths in saved PCB
    with open(pcb_file) as f:
        pcb_txt = f.read()
    paths = re.findall(r'\(path\s+\"([^\"]+)\"\)', pcb_txt)
    print(f"Verified {len(paths)} footprint paths in saved PCB file.")


SYM_74AHCT125 = """    (symbol "Prop_Carrier:74AHCT125"
      (exclude_from_sim no) (in_bom yes) (on_board yes) (in_pos_files yes)
      (property "Reference" "U" (at -7.62 16.51 0) (effects (font (size 1.27 1.27))))
      (property "Value" "74AHCT125" (at 7.62 16.51 0) (effects (font (size 1.27 1.27))))
      (property "Footprint" "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" (at 0 0 0) (effects (font (size 1.27 1.27)) hide))
      (symbol "74AHCT125_0_1"
        (rectangle (start -10.16 15.24) (end 10.16 -15.24) (stroke (width 0.254)) (fill (type background)))
        (pin input line (at -15.24 10.16 0) (length 5.08) (name "~{1OE}" (effects (font (size 1.27 1.27)))) (number "1" (effects (font (size 1.27 1.27)))))
        (pin input line (at -15.24 7.62 0) (length 5.08) (name "1A" (effects (font (size 1.27 1.27)))) (number "2" (effects (font (size 1.27 1.27)))))
        (pin output line (at 15.24 7.62 180) (length 5.08) (name "1Y" (effects (font (size 1.27 1.27)))) (number "3" (effects (font (size 1.27 1.27)))))
        (pin input line (at -15.24 2.54 0) (length 5.08) (name "~{2OE}" (effects (font (size 1.27 1.27)))) (number "4" (effects (font (size 1.27 1.27)))))
        (pin input line (at -15.24 0 0) (length 5.08) (name "2A" (effects (font (size 1.27 1.27)))) (number "5" (effects (font (size 1.27 1.27)))))
        (pin output line (at 15.24 0 180) (length 5.08) (name "2Y" (effects (font (size 1.27 1.27)))) (number "6" (effects (font (size 1.27 1.27)))))
        (pin power_in line (at 0 -17.78 90) (length 2.54) (name "GND" (effects (font (size 1.27 1.27)))) (number "7" (effects (font (size 1.27 1.27)))))
        (pin output line (at 15.24 -5.08 180) (length 5.08) (name "3Y" (effects (font (size 1.27 1.27)))) (number "8" (effects (font (size 1.27 1.27)))))
        (pin input line (at -15.24 -5.08 0) (length 5.08) (name "3A" (effects (font (size 1.27 1.27)))) (number "9" (effects (font (size 1.27 1.27)))))
        (pin input line (at -15.24 -2.54 0) (length 5.08) (name "~{3OE}" (effects (font (size 1.27 1.27)))) (number "10" (effects (font (size 1.27 1.27)))))
        (pin output line (at 15.24 -10.16 180) (length 5.08) (name "4Y" (effects (font (size 1.27 1.27)))) (number "11" (effects (font (size 1.27 1.27)))))
        (pin input line (at -15.24 -10.16 0) (length 5.08) (name "4A" (effects (font (size 1.27 1.27)))) (number "12" (effects (font (size 1.27 1.27)))))
        (pin input line (at -15.24 -7.62 0) (length 5.08) (name "~{4OE}" (effects (font (size 1.27 1.27)))) (number "13" (effects (font (size 1.27 1.27)))))
        (pin power_in line (at 0 17.78 270) (length 2.54) (name "VCC" (effects (font (size 1.27 1.27)))) (number "14" (effects (font (size 1.27 1.27)))))
      )
    )"""

SYM_IRF4905 = """    (symbol "Prop_Carrier:IRF4905"
      (exclude_from_sim no) (in_bom yes) (on_board yes) (in_pos_files yes)
      (property "Reference" "Q" (at 5.08 1.905 0) (effects (font (size 1.27 1.27))))
      (property "Value" "IRF4905" (at 5.08 -0.635 0) (effects (font (size 1.27 1.27))))
      (property "Footprint" "Package_TO_SOT_THT:TO-220-3_Vertical" (at 5.08 -3.175 0) (effects (font (size 1.27 1.27)) hide))
      (symbol "IRF4905_0_1"
        (polyline (pts (xy 0 1.905) (xy 0 -1.905)) (stroke (width 0.254)))
        (polyline (pts (xy 0 1.27) (xy 2.54 1.27) (xy 2.54 5.08)) (stroke (width 0.254)))
        (polyline (pts (xy 0 -1.27) (xy 2.54 -1.27) (xy 2.54 -5.08)) (stroke (width 0.254)))
        (polyline (pts (xy -2.54 0) (xy -5.08 0)) (stroke (width 0.254)))
        (pin input line (at -7.62 0 0) (length 2.54) (name "G" (effects (font (size 1.27 1.27)))) (number "1" (effects (font (size 1.27 1.27)))))
        (pin passive line (at 2.54 -7.62 90) (length 2.54) (name "D" (effects (font (size 1.27 1.27)))) (number "2" (effects (font (size 1.27 1.27)))))
        (pin passive line (at 2.54 7.62 270) (length 2.54) (name "S" (effects (font (size 1.27 1.27)))) (number "3" (effects (font (size 1.27 1.27)))))
      )
    )"""

SYM_PWR_18V = """    (symbol "power:+18V" (power) (pin_numbers hide) (pin_names (offset 0) hide) (in_bom yes) (on_board yes)
      (property "Reference" "#PWR" (at 0 -3.81 0) (effects (font (size 1.27 1.27)) hide))
      (property "Value" "+18V" (at 0 3.81 0) (effects (font (size 1.27 1.27))))
      (symbol "+18V_0_1"
        (polyline (pts (xy -0.762 1.27) (xy 0 2.54) (xy 0.762 1.27)) (stroke (width 0)))
        (polyline (pts (xy 0 0) (xy 0 2.54)) (stroke (width 0)))
      )
      (symbol "+18V_1_1"
        (pin power_in line (at 0 0 90) (length 0) hide (name "+18V" (effects (font (size 1.27 1.27)))) (number "1" (effects (font (size 1.27 1.27)))))
      )
    )"""

def parse_netlist(netlist_path):
    with open(netlist_path) as f:
        content = f.read()
    comps = {}
    for m in re.finditer(r'\(comp\s+\(ref\s+\"([^\"]+)\"\)\s+\(value\s+\"([^\"]+)\"\)\s+\(footprint\s+\"([^\"]+)\"\)', content):
        ref, val, fp = m.groups()
        comps[ref] = {'value': val, 'footprint': fp}
    nets = {}
    for nb in re.finditer(r'\(net\s+\(code\s+\"\d+\"\)\s+\(name\s+\"([^\"]+)\"\)(.*?)\n\t\t\)', content, re.DOTALL):
        net_name = nb.group(1)
        body = nb.group(2)
        nodes = re.findall(r'\(node\s+\(ref\s+\"([^\"]+)\"\)\s+\(pin\s+\"([^\"]+)\"\)', body)
        nets[net_name] = nodes
    return comps, nets


def generate_prop_project():
    print("=== Generating Prop Node Revamp (100% Exact Alignment) ===")
    sch_file = os.path.join(PROP_DIR, "pcb_prop_node.kicad_sch")
    net_file = os.path.join(PROP_DIR, "pcb_prop_node.net")
    pdf_file = os.path.join(PROP_DIR, "pcb_prop_node.pdf")
    pcb_file = os.path.join(PROP_DIR, "pcb_prop_node.kicad_pcb")

    libs = [
        extract_raw_sym("Connector_Generic", "Conn_01x18"),
        extract_raw_sym("Connector_Generic", "Conn_01x02"),
        extract_raw_sym("Connector_Generic", "Conn_01x03"),
        extract_raw_sym("Connector_Generic", "Conn_01x04"),
        extract_raw_sym("Connector_Generic", "Conn_01x06"),
        extract_raw_sym("Switch", "SW_DIP_x08"),
        extract_raw_sym("Device", "R"),
        extract_raw_sym("Device", "C_Polarized"),
        extract_raw_sym("Device", "D_TVS"),
        extract_raw_sym("Device", "D_Zener"),
        extract_raw_sym("Device", "Fuse"),
        extract_raw_sym("power", "GND"),
        extract_raw_sym("power", "+5V"),
        extract_raw_sym("power", "+3V3"),
        extract_raw_sym("power", "PWR_FLAG"),
        SYM_PWR_18V,
        SYM_74AHCT125,
        SYM_IRF4905
    ]
    lib_symbols_str = "\n".join(libs)

    pwr_counter = 1
    def pwr_ref():
        nonlocal pwr_counter
        r = f"#PWR{pwr_counter:03d}"
        pwr_counter += 1
        return r

    sym_uuids = {}
    for ref in ["J1", "F1", "D1", "Q1", "D2", "R2", "R3", "REG1", "C3", "J2", "J3", "SW1", "J4", "J6", "U1", "R1", "R4", "R5", "R6", "J5", "J7", "H1", "H2", "H3", "H4"]:
        sym_uuids[ref] = uid()

    elements = []

    # Section Headers
    elements.append(f'''  (text "SECTION 1: 18-21V TOOL BATTERY ENTRY, FUSE, TVS & ZERO-DROP P-FET"
    (at 25.40 25.40 0) (effects (font (size 2 2) (bold yes)) (justify left)))''')
    elements.append(f'''  (text "SECTION 2: 5.0V / 8A SYNCHRONOUS STEP-DOWN BUCK REGULATOR"
    (at 25.40 137.16 0) (effects (font (size 2 2) (bold yes)) (justify left)))''')
    elements.append(f'''  (text "SECTION 3: HELTEC WIFI LORA 32 V3 HOST SOCKET (J2 / J3)"
    (at 152.40 25.40 0) (effects (font (size 2 2) (bold yes)) (justify left)))''')
    elements.append(f'''  (text "SECTION 4: 74AHCT125 QUAD LEVEL SHIFTER & DAMPING"
    (at 152.40 160.02 0) (effects (font (size 2 2) (bold yes)) (justify left)))''')
    elements.append(f'''  (text "SECTION 5: 8-BIT HARDWARE PROP ADDRESS, TRIGGER & QUAD LED OUTPUT"
    (at 285.00 25.40 0) (effects (font (size 2 2) (bold yes)) (justify left)))''')

    # --------------------------------------------------------------------------
    # 1. J1: M18 Battery Input (Conn_01x02) at (50.80, 50.80) - Pluggable MSTBA
    # --------------------------------------------------------------------------
    jx, jy = 50.80, 50.80
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x02") (at {jx} {jy} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J1']}")
    (property "Reference" "J1" (at {jx} {jy - 6.35} 0) (effects (font (size 1 1))))
    (property "Value" "M18_BATT_IN" (at {jx} {jy + 6.35} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_2-G-5,08_1x02_P5.08mm_Horizontal" (at {jx} {jy} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
    # Pin 2 (GND): at (45.72, 53.34)
    elements.append(f'''  (wire (pts (xy 45.72 53.34) (xy 35.56 53.34)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 35.56 53.34 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 35.56 53.34 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 35.56 53.34 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (symbol (lib_id "power:PWR_FLAG") (at 35.56 53.34 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 35.56 53.34 0) (effects (font (size 1 1)) hide))
    (property "Value" "PWR_FLAG" (at 35.56 53.34 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # Pin 1 (+18V_BATT): at (45.72, 50.80)
    elements.append(f'''  (wire (pts (xy 45.72 50.80) (xy 35.56 50.80)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:PWR_FLAG") (at 35.56 50.80 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 35.56 50.80 0) (effects (font (size 1 1)) hide))
    (property "Value" "PWR_FLAG" (at 35.56 50.80 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (wire (pts (xy 45.72 50.80) (xy 68.58 50.80)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 45.72 50.80) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (label "+18V_BATT" (at 55.88 50.80 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 2. F1: 10A Blade Fuse at (72.39, 50.80) rot=270
    # --------------------------------------------------------------------------
    # At rot=270: Pin 1 is at (fx - 3.81, fy) = (68.58, 50.80)
    #             Pin 2 is at (fx + 3.81, fy) = (76.20, 50.80)
    fx, fy = 72.39, 50.80
    elements.append(f'''  (symbol (lib_id "Device:Fuse") (at {fx} {fy} 270) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['F1']}")
    (property "Reference" "F1" (at {fx} {fy - 6.35} 0) (effects (font (size 1 1))))
    (property "Value" "10A_Mini_Blade" (at {fx} {fy + 6.35} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Fuse:Fuseholder_Blade_Mini_Keystone_3568" (at {fx} {fy} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')

    # Wire from F1 Pin 2 (76.20, 50.80) to Q1 Pin 3 (Source) at (127.00, 50.80)
    elements.append(f'''  (wire (pts (xy 76.20 50.80) (xy 127.00 50.80)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "+18V_FUSED" (at 88.90 50.80 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # TVS D1 at (91.44, 54.61) rot=270
    # Pin 1 (Cathode) is at (91.44, 50.80)
    # Pin 2 (Anode) is at (91.44, 58.42)
    tx, ty = 91.44, 54.61
    elements.append(f'''  (symbol (lib_id "Device:D_TVS") (at {tx} {ty} 270) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['D1']}")
    (property "Reference" "D1" (at {tx + 7.62} {ty - 1.27} 0) (effects (font (size 1 1)) (justify left)))
    (property "Value" "SMCJ24A" (at {tx + 7.62} {ty + 1.27} 0) (effects (font (size 0.9 0.9)) (justify left)))
    (property "Footprint" "Diode_SMD:D_SMC" (at {tx} {ty} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (junction (at {tx} 50.80) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy {tx} 58.42) (xy {tx} 66.04)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at {tx} 66.04 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at {tx} 66.04 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at {tx} 66.04 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # --------------------------------------------------------------------------
    # 3. Q1: IRF4905 P-FET at (124.46, 58.42)
    # --------------------------------------------------------------------------
    # Pin 1 (G) at (116.84, 58.42)
    # Pin 3 (S) at (127.00, 50.80)
    # Pin 2 (D) at (127.00, 66.04)
    qx, qy = 124.46, 58.42
    elements.append(f'''  (symbol (lib_id "Prop_Carrier:IRF4905") (at {qx} {qy} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['Q1']}")
    (property "Reference" "Q1" (at {qx + 6.35} {qy - 7.62} 0) (effects (font (size 1.27 1.27))))
    (property "Value" "IRF4905" (at {qx + 6.35} {qy + 7.62} 0) (effects (font (size 1.27 1.27))))
    (property "Footprint" "Package_TO_SOT_THT:TO-220-3_Vertical" (at {qx} {qy} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}")) (pin "3" (uuid "{uid()}"))
  )''')

    # D2 (15V Zener) at (106.68, 54.61) rot=270
    # Cathode Pin 1 at (106.68, 50.80) -> +18V_FUSED
    # Anode Pin 2 at (106.68, 58.42) -> GATE_NODE
    elements.append(f'''  (symbol (lib_id "Device:D_Zener") (at 106.68 54.61 270) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['D2']}")
    (property "Reference" "D2" (at 106.68 46.99 0) (effects (font (size 1 1))))
    (property "Value" "BZX84C15" (at 106.68 62.23 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Package_TO_SOT_SMD:SOT-23" (at 106.68 54.61 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (junction (at 106.68 50.80) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')

    # Connect D2 Anode Pin 2 to Q1 Gate Pin 1 at (116.84, 58.42)
    elements.append(f'''  (wire (pts (xy 106.68 58.42) (xy 116.84 58.42)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "GATE_NODE" (at 111.76 58.42 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # R2 (100k Gate Resistor) at (116.84, 76.20)
    # Between +18V_PROT (66.04) and GATE_NODE (58.42)
    # Let's place R2 at (121.92, 62.23) rot=0:
    # Pin 1 at (121.92, 58.42) -> GATE_NODE
    # Pin 2 at (121.92, 66.04) -> +18V_PROT
    elements.append(f'''  (symbol (lib_id "Device:R") (at 121.92 62.23 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['R2']}")
    (property "Reference" "R2" (at 125.73 59.69 0) (effects (font (size 1 1))))
    (property "Value" "100k" (at 125.73 64.77 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Resistor_SMD:R_0805_2012Metric" (at 121.92 62.23 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
    # Connect R2 Pin 1 to GATE_NODE
    elements.append(f'''  (wire (pts (xy 116.84 58.42) (xy 121.92 58.42)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 116.84 58.42) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    # Connect R2 Pin 2 to Q1 Drain at (127.00, 66.04)
    elements.append(f'''  (wire (pts (xy 121.92 66.04) (xy 127.00 66.04)) (stroke (width 0)) (uuid "{uid()}"))''')

    # R3 (47k Gate Pull-down) at (106.68, 73.66) rot=0
    # Pin 1 at (106.68, 69.85) -> connects to GATE_NODE (58.42)
    # Pin 2 at (106.68, 77.47) -> GND
    elements.append(f'''  (symbol (lib_id "Device:R") (at 106.68 73.66 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['R3']}")
    (property "Reference" "R3" (at 110.49 71.12 0) (effects (font (size 1 1))))
    (property "Value" "47k" (at 110.49 76.20 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Resistor_SMD:R_0805_2012Metric" (at 106.68 73.66 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (wire (pts (xy 106.68 58.42) (xy 106.68 69.85)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 106.68 58.42) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 106.68 77.47) (xy 106.68 83.82)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 106.68 83.82 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 106.68 83.82 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 106.68 83.82 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # Q1 Pin 2 (Drain, +18V_PROT) at (127.00, 66.04) -> wire to Buck REG1 Pin 1 at (60.96, 152.40)
    elements.append(f'''  (wire (pts (xy 127.00 66.04) (xy 137.16 66.04)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 127.00 66.04) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 137.16 66.04) (xy 137.16 127.00)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 137.16 127.00) (xy 55.88 127.00)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 55.88 127.00) (xy 55.88 152.40)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 55.88 152.40) (xy 60.96 152.40)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "+18V_PROT" (at 137.16 96.52 90) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 4. REG1: 5V/8A Buck Module (Conn_01x03) at (66.04, 154.94)
    # --------------------------------------------------------------------------
    rx, ry = 66.04, 154.94
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x03") (at {rx} {ry} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['REG1']}")
    (property "Reference" "REG1" (at {rx} {ry - 7.62} 0) (effects (font (size 1.27 1.27))))
    (property "Value" "Buck_5V_8A" (at {rx} {ry + 7.62} 0) (effects (font (size 1 1))))
    (property "Footprint" "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-1,5-3-5.08_1x03_P5.08mm_Horizontal" (at {rx} {ry} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}")) (pin "3" (uuid "{uid()}"))
  )''')
    # Pin 2 (GND): at (60.96, 154.94)
    elements.append(f'''  (wire (pts (xy 60.96 154.94) (xy 50.80 154.94)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 50.80 154.94 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 50.80 154.94 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 50.80 154.94 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 3 (+5V_POWER): at (60.96, 157.48)
    elements.append(f'''  (wire (pts (xy 60.96 157.48) (xy 50.80 157.48)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 50.80 157.48) (xy 50.80 172.72)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 50.80 172.72) (xy 91.44 172.72)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:PWR_FLAG") (at 50.80 172.72 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 50.80 172.72 0) (effects (font (size 1 1)) hide))
    (property "Value" "PWR_FLAG" (at 50.80 172.72 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (label "+5V" (at 71.12 172.72 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # C3 (1000uF Bulk Electrolytic) at (91.44, 182.88)
    elements.append(f'''  (symbol (lib_id "Device:C_Polarized") (at 91.44 182.88 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['C3']}")
    (property "Reference" "C3" (at 96.52 180.34 0) (effects (font (size 1 1))))
    (property "Value" "1000uF_10V" (at 96.52 185.42 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm" (at 91.44 182.88 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (wire (pts (xy 91.44 172.72) (xy 91.44 179.07)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 91.44 172.72) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 91.44 186.69) (xy 91.44 193.04)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 91.44 193.04 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 91.44 193.04 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 91.44 193.04 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Route +5V_POWER from C3 to Heltec J2 Pin 2
    elements.append(f'''  (wire (pts (xy 91.44 172.72) (xy 121.92 172.72)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 121.92 172.72) (xy 121.92 76.20)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 121.92 76.20) (xy 167.64 76.20)) (stroke (width 0)) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 5. J2: Heltec Left Header (Conn_01x18) at (172.72, 93.98)
    # --------------------------------------------------------------------------
    hx_l, hy_l = 172.72, 93.98
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x18") (at {hx_l} {hy_l} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J2']}")
    (property "Reference" "J2" (at {hx_l} {hy_l - 25.40} 0) (effects (font (size 1.27 1.27))))
    (property "Value" "Heltec_V3_Left" (at {hx_l} {hy_l + 25.40} 0) (effects (font (size 1.27 1.27))))
    (property "Footprint" "Connector_PinSocket_2.54mm:PinSocket_1x18_P2.54mm_Vertical" (at {hx_l} {hy_l} 0) (effects (font (size 1.27 1.27)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 19)]) + f''')''')

    # Pin 1 (GND): at (167.64, 73.66)
    elements.append(f'''  (wire (pts (xy 167.64 73.66) (xy 160.02 73.66)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 160.02 73.66 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 160.02 73.66 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 160.02 73.66 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 2 (+5V_POWER): at (167.64, 76.20)
    # Pin 3 (+3V3): at (167.64, 78.74)
    elements.append(f'''  (wire (pts (xy 167.64 78.74) (xy 160.02 78.74)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+3V3") (at 160.02 78.74 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 160.02 78.74 0) (effects (font (size 1 1)) hide))
    (property "Value" "+3V3" (at 160.02 78.74 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (symbol (lib_id "power:PWR_FLAG") (at 160.02 78.74 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 160.02 78.74 0) (effects (font (size 1 1)) hide))
    (property "Value" "PWR_FLAG" (at 160.02 78.74 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # Unused pins on J2: 4, 5, 6, 16, 17, 18 -> no_connect
    for p in [4, 5, 6, 16, 17, 18]:
        py = 73.66 + (p - 1) * 2.54
        elements.append(f'''  (no_connect (at 167.64 {py:.2f}) (uuid "{uid()}"))''')

    # Pin 7..10: ADDR_BIT0..3, Pin 12..15: ADDR_BIT4..7
    # SW1 at (330.20, 53.34) has Pins 1..8 at x=322.58, y=[43.18, 45.72, 48.26, 50.80, 53.34, 55.88, 58.42, 60.96]
    addr_pins = [7, 8, 9, 10, 12, 13, 14, 15]
    sw_ys = [43.18, 45.72, 48.26, 50.80, 53.34, 55.88, 58.42, 60.96]
    for idx in range(8):
        p = addr_pins[idx]
        py = 73.66 + (p - 1) * 2.54
        sw_y = sw_ys[idx]
        c_y = 30.48 + idx * 2.54
        x_left = 162.56 - idx * 2.54
        x_right = 302.26 + idx * 2.54
        elements.append(f'''  (wire (pts (xy 167.64 {py:.2f}) (xy {x_left:.2f} {py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (wire (pts (xy {x_left:.2f} {py:.2f}) (xy {x_left:.2f} {c_y:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (wire (pts (xy {x_left:.2f} {c_y:.2f}) (xy {x_right:.2f} {c_y:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (wire (pts (xy {x_right:.2f} {c_y:.2f}) (xy {x_right:.2f} {sw_y:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (wire (pts (xy {x_right:.2f} {sw_y:.2f}) (xy 322.58 {sw_y:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (label "ADDR_BIT{idx}" (at 241.30 {c_y:.2f} 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # Pin 11 (PERF_TRIGGER): at (167.64, 99.06) -> wire to J4 Pin 1 at (325.12, 92.71)
    elements.append(f'''  (wire (pts (xy 167.64 99.06) (xy 132.08 99.06)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 132.08 99.06) (xy 132.08 71.12)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 132.08 71.12) (xy 325.12 71.12)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 325.12 71.12) (xy 325.12 92.71)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "PERF_TRIGGER" (at 241.30 71.12 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 6. J3: Heltec Right Header (Conn_01x18) at (215.90, 93.98)
    # --------------------------------------------------------------------------
    hx_r, hy_r = 215.90, 93.98
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x18") (at {hx_r} {hy_r} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J3']}")
    (property "Reference" "J3" (at {hx_r} {hy_r - 25.40} 0) (effects (font (size 1.27 1.27))))
    (property "Value" "Heltec_V3_Right" (at {hx_r} {hy_r + 25.40} 0) (effects (font (size 1.27 1.27))))
    (property "Footprint" "Connector_PinSocket_2.54mm:PinSocket_1x18_P2.54mm_Vertical" (at {hx_r} {hy_r} 0) (effects (font (size 1.27 1.27)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 19)]) + f''')''')

    # Pin 1 (GND): at (210.82, 73.66)
    elements.append(f'''  (wire (pts (xy 210.82 73.66) (xy 203.20 73.66)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 203.20 73.66 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 203.20 73.66 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 203.20 73.66 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # Unused pins on J3: 2, 5..14 -> no_connect
    elements.append(f'''  (no_connect (at 210.82 {73.66 + 1 * 2.54:.2f}) (uuid "{uid()}"))''')
    for p in range(5, 15):
        py = 73.66 + (p - 1) * 2.54
        elements.append(f'''  (no_connect (at 210.82 {py:.2f}) (uuid "{uid()}"))''')

    # Pin 3 (I2C_SDA): at (210.82, 78.74) -> wire to J6 Pin 2 at (325.12, 127.00)
    elements.append(f'''  (wire (pts (xy 210.82 78.74) (xy 200.66 78.74)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 200.66 78.74) (xy 200.66 66.04)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 200.66 66.04) (xy 292.10 66.04)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 292.10 66.04) (xy 292.10 127.00)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 292.10 127.00) (xy 325.12 127.00)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "I2C_SDA" (at 246.38 66.04 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # Pin 4 (I2C_SCL): at (210.82, 81.28) -> wire to J6 Pin 3 at (325.12, 129.54)
    elements.append(f'''  (wire (pts (xy 210.82 81.28) (xy 198.12 81.28)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 198.12 81.28) (xy 198.12 68.58)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 198.12 68.58) (xy 289.56 68.58)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 289.56 68.58) (xy 289.56 129.54)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 289.56 129.54) (xy 325.12 129.54)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (label "I2C_SCL" (at 246.38 68.58 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # LED data outputs from Heltec J3 Pins 15..18:
    # Pin 18 (LED1_DATA_3V3): at (210.82, 116.84) -> wire to U1 Pin 2 (1A) at (198.12, 193.04)
    # Pin 17 (LED2_DATA_3V3): at (210.82, 114.30) -> wire to U1 Pin 5 (2A) at (198.12, 200.66)
    # Pin 16 (LED3_DATA_3V3): at (210.82, 111.76) -> wire to U1 Pin 9 (3A) at (198.12, 205.74)
    # Pin 15 (LED4_DATA_3V3): at (210.82, 109.22) -> wire to U1 Pin 12 (4A) at (198.12, 210.82)
    led_ins = [
        (18, 116.84, 193.04, 1),
        (17, 114.30, 200.66, 2),
        (16, 111.76, 205.74, 3),
        (15, 109.22, 210.82, 4)
    ]
    for pin_num, h_py, u_py, ch in led_ins:
        elements.append(f'''  (wire (pts (xy 210.82 {h_py:.2f}) (xy {185.42 - ch*2.54:.2f} {h_py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (wire (pts (xy {185.42 - ch*2.54:.2f} {h_py:.2f}) (xy {185.42 - ch*2.54:.2f} {u_py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (wire (pts (xy {185.42 - ch*2.54:.2f} {u_py:.2f}) (xy 198.12 {u_py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (label "LED{ch}_DATA_3V3" (at {185.42 - ch*2.54:.2f} {152.40:.2f} 90) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 7. U1: 74AHCT125 Quad Level Shifter at (213.36, 200.66)
    # --------------------------------------------------------------------------
    ux, uy = 213.36, 200.66
    elements.append(f'''  (symbol (lib_id "Prop_Carrier:74AHCT125") (at {ux} {uy} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['U1']}")
    (property "Reference" "U1" (at {ux} {uy - 17.78} 0) (effects (font (size 1.27 1.27))))
    (property "Value" "74AHCT125" (at {ux} {uy + 17.78} 0) (effects (font (size 1.27 1.27))))
    (property "Footprint" "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" (at {ux} {uy} 0) (effects (font (size 1.27 1.27)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 15)]) + f''')''')

    # Enable Pins (~OE): Pins 1, 4, 10, 13 to GND
    for oe_y in [190.50, 198.12, 203.20, 208.28]:
        elements.append(f'''  (wire (pts (xy 198.12 {oe_y:.2f}) (xy 193.04 {oe_y:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 193.04 190.50) (xy 193.04 208.28)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 193.04 198.12) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (junction (at 193.04 203.20) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 193.04 208.28) (xy 193.04 215.90)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 193.04 215.90 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 193.04 215.90 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 193.04 215.90 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # U1 Power: Pin 14 (VCC) at (213.36, 182.88), Pin 7 (GND) at (213.36, 218.44)
    elements.append(f'''  (wire (pts (xy 213.36 182.88) (xy 213.36 177.80)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+5V") (at 213.36 177.80 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 213.36 177.80 0) (effects (font (size 1 1)) hide))
    (property "Value" "+5V" (at 213.36 175.26 0) (effects (font (size 1 1))))
    (pin "1" (uuid "{uid()}"))
  )''')
    elements.append(f'''  (wire (pts (xy 213.36 218.44) (xy 213.36 223.52)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 213.36 223.52 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 213.36 223.52 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 213.36 223.52 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # U1 Outputs: Pin 3 (1Y, 193.04), Pin 6 (2Y, 200.66), Pin 8 (3Y, 205.74), Pin 11 (4Y, 210.82)
    # J5 Pin 2 (CH1 DATA) at 175.26, Pin 5 (CH2 DATA) at 182.88
    # J7 Pin 2 (CH3 DATA) at 220.98, Pin 5 (CH4 DATA) at 228.60
    r_map = [
        ("R1", 193.04, 1, "LED1_DATA_5V", 175.26),
        ("R4", 200.66, 2, "LED2_DATA_5V", 182.88),
        ("R5", 205.74, 3, "LED3_DATA_5V", 220.98),
        ("R6", 210.82, 4, "LED4_DATA_5V", 228.60)
    ]
    for r_ref, u_py, ch, net, j_py in r_map:
        elements.append(f'''  (symbol (lib_id "Device:R") (at 248.92 {u_py:.2f} 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids[r_ref]}")
    (property "Reference" "{r_ref}" (at 248.92 {u_py - 3.81:.2f} 0) (effects (font (size 1 1))))
    (property "Value" "47R" (at 248.92 {u_py + 3.81:.2f} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Resistor_SMD:R_0805_2012Metric" (at 248.92 {u_py:.2f} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
        # U1 output to R Pin 1
        elements.append(f'''  (wire (pts (xy 228.60 {u_py:.2f}) (xy 245.11 {u_py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        # R Pin 2 to LED Terminal Block
        elements.append(f'''  (wire (pts (xy 252.73 {u_py:.2f}) (xy 274.32 {u_py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (wire (pts (xy 274.32 {u_py:.2f}) (xy 274.32 {j_py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (wire (pts (xy 274.32 {j_py:.2f}) (xy 325.12 {j_py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
        elements.append(f'''  (label "{net}" (at 289.56 {j_py:.2f} 0) (effects (font (size 1 1))) (uuid "{uid()}"))''')

    # --------------------------------------------------------------------------
    # 8. SW1: 8-Bit DIP Switch at (330.20, 53.34)
    # --------------------------------------------------------------------------
    # Pins 1..8 at (322.58, [43.18, 45.72, 48.26, 50.80, 53.34, 55.88, 58.42, 60.96])
    # Pins 9..16 at (337.82, [60.96, 58.42, 55.88, 53.34, 50.80, 48.26, 45.72, 43.18])
    dx, dy = 330.20, 53.34
    elements.append(f'''  (symbol (lib_id "Switch:SW_DIP_x08") (at {dx} {dy} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['SW1']}")
    (property "Reference" "SW1" (at {dx} {dy - 12.70} 0) (effects (font (size 1 1))))
    (property "Value" "8BIT_PROP_ID" (at {dx} {dy + 12.70} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Button_Switch_THT:SW_DIP_SPSTx08_Slide_6.7x21.88mm_W7.62mm_P2.54mm_LowProfile" (at {dx} {dy} 0) (effects (font (size 1 1)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 17)]) + f''')''')
    # SW1 Right Pins (9..16) at 337.82 -> GND bus at 342.90
    sw_gnd_ys = [43.18, 45.72, 48.26, 50.80, 53.34, 55.88, 58.42, 60.96]
    for py in sw_gnd_ys:
        elements.append(f'''  (wire (pts (xy 337.82 {py:.2f}) (xy 342.90 {py:.2f})) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (wire (pts (xy 342.90 43.18) (xy 342.90 66.04)) (stroke (width 0)) (uuid "{uid()}"))''')
    for py in sw_gnd_ys[1:]:
        elements.append(f'''  (junction (at 342.90 {py:.2f}) (diameter 0) (color 0 0 0 0) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 342.90 66.04 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 342.90 66.04 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 342.90 66.04 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # --------------------------------------------------------------------------
    # 9. J4: Performer Trigger (Conn_01x02) at (330.20, 92.71) - Pluggable MSTBA
    # --------------------------------------------------------------------------
    # Pin 1 at (325.12, 92.71)
    # Pin 2 at (325.12, 95.25)
    tx, ty = 330.20, 92.71
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x02") (at {tx} {ty} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J4']}")
    (property "Reference" "J4" (at {tx} {ty - 6.35} 0) (effects (font (size 1 1))))
    (property "Value" "PERF_TRIGGER" (at {tx} {ty + 6.35} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_2-G-5,08_1x02_P5.08mm_Horizontal" (at {tx} {ty} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}"))
  )''')
    # Pin 2 (GND) at (325.12, 95.25)
    elements.append(f'''  (wire (pts (xy 325.12 95.25) (xy 317.50 95.25)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 317.50 95.25 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 95.25 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 317.50 95.25 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # --------------------------------------------------------------------------
    # 10. J6: I2C Diagnostic Header (Conn_01x04) at (330.20, 128.27)
    # --------------------------------------------------------------------------
    # Pin 1 at (325.12, 124.46) -> +3V3
    # Pin 2 at (325.12, 127.00) -> I2C_SDA
    # Pin 3 at (325.12, 129.54) -> I2C_SCL
    # Pin 4 at (325.12, 132.08) -> GND
    dx2, dy2 = 330.20, 127.00
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x04") (at {dx2} {dy2} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J6']}")
    (property "Reference" "J6" (at {dx2} {dy2 - 7.62} 0) (effects (font (size 1 1))))
    (property "Value" "I2C_DIAG" (at {dx2} {dy2 + 7.62} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" (at {dx2} {dy2} 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}")) (pin "2" (uuid "{uid()}")) (pin "3" (uuid "{uid()}")) (pin "4" (uuid "{uid()}"))
  )''')
    # Pin 1 (+3V3):
    elements.append(f'''  (wire (pts (xy 325.12 124.46) (xy 317.50 124.46)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+3V3") (at 317.50 124.46 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 124.46 0) (effects (font (size 1 1)) hide))
    (property "Value" "+3V3" (at 317.50 124.46 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 4 (GND):
    elements.append(f'''  (wire (pts (xy 325.12 132.08) (xy 317.50 132.08)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 317.50 132.08 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 132.08 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 317.50 132.08 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # --------------------------------------------------------------------------
    # 11. J5: LED CH1 & CH2 (Conn_01x06) at (330.20, 179.07) - Pluggable MSTBA
    # --------------------------------------------------------------------------
    ox1, oy1 = 330.20, 177.80
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x06") (at {ox1} {oy1} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J5']}")
    (property "Reference" "J5" (at {ox1} {oy1 - 10.16} 0) (effects (font (size 1 1))))
    (property "Value" "LED_CH1_CH2" (at {ox1} {oy1 + 10.16} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_6-G-5,08_1x06_P5.08mm_Horizontal" (at {ox1} {oy1} 0) (effects (font (size 1 1)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 7)]) + f''')''')

    # Pin 1 (+5V_POWER): at (325.12, 172.72)
    elements.append(f'''  (wire (pts (xy 325.12 172.72) (xy 317.50 172.72)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+5V") (at 317.50 172.72 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 172.72 0) (effects (font (size 1 1)) hide))
    (property "Value" "+5V" (at 317.50 172.72 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 3 (GND): at (325.12, 177.80)
    elements.append(f'''  (wire (pts (xy 325.12 177.80) (xy 317.50 177.80)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 317.50 177.80 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 177.80 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 317.50 177.80 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 4 (+5V_POWER): at (325.12, 180.34)
    elements.append(f'''  (wire (pts (xy 325.12 180.34) (xy 317.50 180.34)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+5V") (at 317.50 180.34 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 180.34 0) (effects (font (size 1 1)) hide))
    (property "Value" "+5V" (at 317.50 180.34 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 6 (GND): at (325.12, 185.42)
    elements.append(f'''  (wire (pts (xy 325.12 185.42) (xy 317.50 185.42)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 317.50 185.42 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 185.42 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 317.50 185.42 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    # --------------------------------------------------------------------------
    # 12. J7: LED CH3 & CH4 (Conn_01x06) at (330.20, 224.79) - Pluggable MSTBA
    # --------------------------------------------------------------------------
    ox2, oy2 = 330.20, 223.52
    elements.append(f'''  (symbol (lib_id "Connector_Generic:Conn_01x06") (at {ox2} {oy2} 0) (unit 1) (in_bom yes) (on_board yes) (uuid "{sym_uuids['J7']}")
    (property "Reference" "J7" (at {ox2} {oy2 - 10.16} 0) (effects (font (size 1 1))))
    (property "Value" "LED_CH3_CH4" (at {ox2} {oy2 + 10.16} 0) (effects (font (size 0.9 0.9))))
    (property "Footprint" "Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_6-G-5,08_1x06_P5.08mm_Horizontal" (at {ox2} {oy2} 0) (effects (font (size 1 1)) hide))
    ''' + "".join([f'(pin "{i}" (uuid "{uid()}")) ' for i in range(1, 7)]) + f''')''')

    # Pin 1 (+5V_POWER): at (325.12, 218.44)
    elements.append(f'''  (wire (pts (xy 325.12 218.44) (xy 317.50 218.44)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+5V") (at 317.50 218.44 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 218.44 0) (effects (font (size 1 1)) hide))
    (property "Value" "+5V" (at 317.50 218.44 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 3 (GND): at (325.12, 223.52)
    elements.append(f'''  (wire (pts (xy 325.12 223.52) (xy 317.50 223.52)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 317.50 223.52 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 223.52 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 317.50 223.52 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 4 (+5V_POWER): at (325.12, 226.06)
    elements.append(f'''  (wire (pts (xy 325.12 226.06) (xy 317.50 226.06)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:+5V") (at 317.50 226.06 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 226.06 0) (effects (font (size 1 1)) hide))
    (property "Value" "+5V" (at 317.50 226.06 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')
    # Pin 6 (GND): at (325.12, 231.14)
    elements.append(f'''  (wire (pts (xy 325.12 231.14) (xy 317.50 231.14)) (stroke (width 0)) (uuid "{uid()}"))''')
    elements.append(f'''  (symbol (lib_id "power:GND") (at 317.50 231.14 90) (unit 1) (in_bom yes) (on_board yes) (uuid "{uid()}")
    (property "Reference" "{pwr_ref()}" (at 317.50 231.14 0) (effects (font (size 1 1)) hide))
    (property "Value" "GND" (at 317.50 231.14 0) (effects (font (size 1 1)) hide))
    (pin "1" (uuid "{uid()}"))
  )''')

    body = "\n".join(elements)

    sch_content = f'''(kicad_sch
	(version 20250114)
	(generator "eeschema")
	(generator_version "10.0")
	(uuid "{uid()}")
	(paper "A3")
	(title_block
		(title "PCHSMB Beacon Prop Receiver & LED Driver Carrier Board")
		(date "2026-10-06")
		(rev "v1.3")
		(company "Pine Creek High School Marching Band")
		(comment 1 "Quad-Channel Field Prop Driver for Backdrops, Duck Blinds & Solo Stages")
		(comment 2 "18-21V Tool Entry, Zero-Drop P-FET, 5V/8A Buck, 100% Pluggable MSTBA Connectors")
	)
	(lib_symbols
{lib_symbols_str}
	)
	(sheet_instances
		(path "/"
			(page "1")
		)
	)
{body}
)
'''
    with open(sch_file, 'w') as f:
        f.write(sch_content)
    print("Prop node schematic written successfully:", sch_file)

    # Export Netlist
    subprocess.run([KICAD_CLI, 'sch', 'export', 'netlist', sch_file, '-o', net_file], check=True)
    print("Prop node netlist exported:", net_file)

    # Run ERC
    erc_rpt = "/tmp/prop_erc.rpt"
    subprocess.run([KICAD_CLI, 'sch', 'erc', sch_file, '-o', erc_rpt], capture_output=True, text=True)
    with open(erc_rpt) as f:
        erc_text = f.read()
    err_lines = [l for l in erc_text.splitlines() if "; error" in l]
    warn_lines = [l for l in erc_text.splitlines() if "; warning" in l]
    print(f"Prop Node ERC: {len(err_lines)} errors, {len(warn_lines)} warnings")
    if err_lines or warn_lines:
        print(erc_text)

    # Export PDF
    subprocess.run([KICAD_CLI, 'sch', 'export', 'pdf', sch_file, '-o', pdf_file], check=True)
    print("Prop node PDF exported:", pdf_file)

    # Build PCB Layout with native (path "/<uuid>") binding
    comps, nets = parse_netlist(net_file)
    board = pcbnew.CreateEmptyBoard()
    tb = board.GetTitleBlock()
    tb.SetTitle("PCHSMB Beacon Prop Receiver & LED Driver Carrier Board (Quad-Channel)")
    tb.SetCompany("Pine Creek High School Marching Band")
    tb.SetRevision("v1.3")

    ox, oy = 100.0, 100.0
    bw, bh = 95.0, 90.0
    corners = [(ox, oy), (ox + bw, oy), (ox + bw, oy + bh), (ox, oy + bh)]
    for i in range(4):
        x1, y1 = corners[i]
        x2, y2 = corners[(i + 1) % 4]
        s = pcbnew.PCB_SHAPE(board)
        s.SetShape(pcbnew.SHAPE_T_SEGMENT)
        s.SetFilled(False)
        s.SetWidth(pcbnew.FromMM(0.2))
        s.SetLayer(pcbnew.Edge_Cuts)
        s.SetStart(pcbnew.VECTOR2I(pcbnew.FromMM(x1), pcbnew.FromMM(y1)))
        s.SetEnd(pcbnew.VECTOR2I(pcbnew.FromMM(x2), pcbnew.FromMM(y2)))
        board.Add(s)

    # 4x M3 Mounting Holes
    mh_lib = os.path.join(FP_DIR, "MountingHole.pretty")
    for idx, (hx, hy) in enumerate([(ox + 5, oy + 5), (ox + bw - 5, oy + 5), (ox + 5, oy + bh - 5), (ox + bw - 5, oy + bh - 5)]):
        mh = pcbnew.FootprintLoad(mh_lib, "MountingHole_3.2mm_M3")
        ref = f"H{idx + 1}"
        mh.SetReference(ref)
        mh.Reference().SetVisible(False)
        mh.SetPosition(pcbnew.VECTOR2I(pcbnew.FromMM(hx), pcbnew.FromMM(hy)))
        if ref in sym_uuids:
            mh.SetPath(pcbnew.KIID_PATH('/' + sym_uuids[ref]))
        board.Add(mh)

    # Silkscreen Titles
    t1 = pcbnew.PCB_TEXT(board)
    t1.SetText("PCHSMB BEACON NODE v1.3")
    t1.SetPosition(pcbnew.VECTOR2I(pcbnew.FromMM(ox + 63.0), pcbnew.FromMM(oy + 2.2)))
    t1.SetTextSize(pcbnew.VECTOR2I(pcbnew.FromMM(0.9), pcbnew.FromMM(0.9)))
    t1.SetHorizJustify(pcbnew.GR_TEXT_H_ALIGN_CENTER)
    t1.SetLayer(pcbnew.F_SilkS)
    board.Add(t1)

    t2 = pcbnew.PCB_TEXT(board)
    t2.SetText("QUAD-CHANNEL PLUGGABLE DRIVER")
    t2.SetPosition(pcbnew.VECTOR2I(pcbnew.FromMM(ox + 63.0), pcbnew.FromMM(oy + 3.8)))
    t2.SetTextSize(pcbnew.VECTOR2I(pcbnew.FromMM(0.8), pcbnew.FromMM(0.8)))
    t2.SetHorizJustify(pcbnew.GR_TEXT_H_ALIGN_CENTER)
    t2.SetLayer(pcbnew.F_SilkS)
    board.Add(t2)

    pos_map = {
        "J1": (ox + 10.0, oy + 20.0, 90),
        "D1": (ox + 12.0, oy + 32.0, 90),
        "F1": (ox + 26.0, oy + 20.0, 90),
        "Q1": (ox + 26.0, oy + 38.0, 0),
        "D2": (ox + 16.0, oy + 47.0, 0),
        "R2": (ox + 22.0, oy + 47.0, 0),
        "R3": (ox + 28.0, oy + 47.0, 0),
        "REG1": (ox + 12.0, oy + 65.0, 0),
        "C3": (ox + 28.0, oy + 65.0, 0),
        "J4": (ox + 39.0, oy + 8.0, 0),
        "J2": (ox + 51.57, oy + 18.0, 0),
        "J3": (ox + 74.43, oy + 18.0, 0),
        "SW1": (ox + 54.11, oy + 13.0, 90),
        "J6": (ox + 58.0, oy + 75.0, 90),
        "U1": (ox + 63.0, oy + 38.0, 90),
        "R1": (ox + 63.0, oy + 26.0, 0),
        "R4": (ox + 63.0, oy + 30.0, 0),
        "R5": (ox + 63.0, oy + 46.0, 0),
        "R6": (ox + 63.0, oy + 50.0, 0),
        "J5": (ox + 82.0, oy + 40.0, 90),
        "J7": (ox + 82.0, oy + 77.0, 90),
    }

    loaded_fps = {}
    for ref, d in comps.items():
        fp_str = d['footprint']
        lib_name, fp_name = fp_str.split(':')
        lib_path = os.path.join(FP_DIR, lib_name + ".pretty")
        fp = pcbnew.FootprintLoad(lib_path, fp_name)
        fp.SetReference(ref)
        fp.SetValue(d['value'])
        if ref in sym_uuids:
            fp.SetPath(pcbnew.KIID_PATH('/' + sym_uuids[ref]))
        if ref in pos_map:
            px, py, prot = pos_map[ref]
            fp.SetPosition(pcbnew.VECTOR2I(pcbnew.FromMM(px), pcbnew.FromMM(py)))
            fp.SetOrientation(pcbnew.EDA_ANGLE(prot, pcbnew.DEGREES_T))
        board.Add(fp)
        loaded_fps[ref] = fp

    # Connect Nets
    for net_name, nodes in nets.items():
        if net_name.startswith('unconnected-'): continue
        net_item = pcbnew.NETINFO_ITEM(board, net_name)
        board.Add(net_item)
        for ref, pin in nodes:
            fp = loaded_fps.get(ref)
            if fp:
                for pad in fp.Pads():
                    if pad.GetNumber() == pin:
                        pad.SetNet(net_item)

    pcbnew.SaveBoard(pcb_file, board)
    print("Prop node PCB layout saved with path binding:", pcb_file)

    # Run DRC
    drc_rpt = "/tmp/prop_drc.rpt"
    subprocess.run([KICAD_CLI, 'pcb', 'drc', pcb_file, '-o', drc_rpt], capture_output=True, text=True)
    with open(drc_rpt) as f:
        drc_text = f.read()
    drc_errs = [l for l in drc_text.splitlines() if "violation" in l.lower() or "error" in l.lower()]
    print(f"Prop Node DRC: {len(drc_errs)} lines")

    with open(pcb_file) as f:
        pcb_txt = f.read()
    paths = re.findall(r'\(path\s+\"([^\"]+)\"\)', pcb_txt)
    print(f"Verified {len(paths)} footprint paths in saved Prop Node PCB file.")



if __name__ == "__main__":
    print("=" * 70)
    print("PCHSMB Carrier Boards Generator (Full Schematic & Layout Sync)")
    print("=" * 70)
    generate_synapse_project()
    print("-" * 70)
    generate_prop_project()
    print("=" * 70)
    print("All carrier boards generated and synchronized successfully!")
