// ==============================================================================
// PCHSMB Duck Blind Sideline Screen — Universal Two-Piece Corner Protector
// Subproject: PCHSMB/_Sideline Screen/Hardware/Corner Skid Clip
//
// Engineering Purpose:
//   Sacrificial wear shoe, corner bumper, and dual-piece clamp for 3/4" EMT
//   corner brackets (Bracket F, Amazon B0D5BBKCKG) on 4x8 ft Duck Blind screens.
//
// Key Mechanical Invariants:
//   1. Two-Piece Clamp Architecture:
//      - Piece 1 (Outside): Primary wear shoe covering front face (over vinyl),
//        outer perimeter (bottom/side ground contact), and rear face.
//        Slips on from the outside corner. Loose tolerances for vinyl folds.
//      - Piece 2 (Inside): Inside clamp block with embedded hex nuts. Sits in
//        the inside crook, clamping the bracket with zero ground contact.
//   2. Single Common Component:
//      - 100% symmetric across the 45° diagonal (X = Z). Identical for both
//        bottom-left and bottom-right corners! No "Left" and "Right" parts.
//   3. Fastener Retention:
//      - 2x M5x40mm (or #10-24x1.5") bolts inserted through Piece 1 into Piece 2.
//      - Recessed counterbores in Piece 1 protect bolt heads from ground abrasion.
//      - Captured hex nut pockets in Piece 2 eliminate wrench requirements.
//   4. 100% Zero-Support FDM Printability:
//      - Piece 1 prints flat on its front face with self-supporting 45° overhangs.
//      - Piece 2 prints flat on its rear face with zero overhangs.
//
// Author: PCHSMB Prop Engineering / Cross-Agent Standard
// ==============================================================================

$fn = 60; // Smooth curve resolution

// ==============================================================================
// 1. PARAMETERIZATION BLOCK (All units in millimeters)
// ==============================================================================

// Physical Frame & Hardware Dimensions
conduit_od          = 23.42;  // Bare 3/4" EMT conduit OD (~0.922 in)
conduit_r           = conduit_od / 2.0; // 11.71 mm
bracket_od          = 27.20;  // Stamped steel Bracket F sleeve OD (~1.07 in)
bracket_r           = bracket_od / 2.0; // 13.60 mm
bracket_sleeve_len  = 70.0;   // Sleeve length from corner center along each rail

// Loose Tolerances for Bunched Vinyl Banner Folds & Tape
// User: "use very loose tolerances to allow for folds of vinyl to be between this part and the corner bracket"
pocket_dia          = 36.0;   // Internal pocket width/depth (+8.8mm clearance over bracket!)
pocket_r            = pocket_dia / 2.0; // 18.0 mm radius

// Piece 1 (Primary Outside Skid Shoe) Envelope
arm_len             = 82.0;   // Total reach along Rail A & Rail B from corner center
wall_front          = 3.5;    // Front face wall thickness (over vinyl banner)
y_front_max         = pocket_r + wall_front; // +21.5 mm
y_rear_min          = -25.5;  // Rear face plane (-25.5 mm to encapsulate M5 nut pocket)
skid_thick          = 6.0;    // Sacrificial wear wall thickness on ground/outer faces
z_skid_min          = -(pocket_r + skid_thick); // -24.0 mm
x_side_min          = -(pocket_r + skid_thick); // -24.0 mm
corner_apex_r       = 6.0;    // Bullnose fillet on outer corner apex
lead_in_chamfer     = 5.0;    // 45° lead-in ramp at distal ends of arms
rear_socket_relief_r= 17.5;   // 35mm dia cutout for unused 3rd rear socket / Corner Plug H

// Fastener Specifications (Default: M5 Socket Head Cap Screw & Hex Nut)
// Fully parameterized for easy customization to #10-24 or M4
bolt_dia            = 5.5;    // Clearance through-bore diameter (M5 / #10)
bolt_head_dia       = 10.5;   // Counterbore diameter for socket head
bolt_head_depth     = 5.0;    // Deep recessed counterbore depth
nut_flats           = 8.2;    // Across-flats width for M5 hex nut (+0.2mm print tolerance)
nut_depth           = 4.5;    // Hex nut pocket depth
bolt_offset         = 54.0;   // Centerline distance along arm for clamping bolts (mm)
bolt_y_center       = -18.5;  // Y position of bolt centerline (clears 13.6mm bracket radius with 4.9mm margin)

// Piece 2 (Inside Clamp Block) Envelope
clamp_saddle_r      = 14.5;   // Saddle radius matching bracket sleeve (+0.9mm fit tolerance)
clamp_thickness     = 8.0;    // Solid structural core thickness above saddle
clamp_start         = 28.0;   // Inner crook start position along arm
clamp_end           = 74.0;   // Clamp wing distal termination along arm

// Selection parameter for CLI export (-D part="...")
part = "assembly"; // Options: "piece1", "piece2", "pair", "assembly"

// ==============================================================================
// 2. HELPER MODULES & MATHEMATICAL TRANSFORMATIONS
// ==============================================================================

// Reflection across 45° diagonal (X = Z plane) to guarantee 100% symmetry
module mirror_diag() {
    children();
    multmatrix([
        [0, 0, 1, 0],
        [0, 1, 0, 0],
        [1, 0, 0, 0],
        [0, 0, 0, 1]
    ]) children();
}

// Hexagonal nut pocket prism
module hex_nut_pocket(flats, depth) {
    cylinder(r = flats / (2 * cos(30)), h = depth, $fn = 6);
}

// Single arm solid body for Piece 1 (along +X axis, Rail A)
module piece1_arm_solid() {
    total_y = y_front_max - y_rear_min; // 47.0 mm

    union() {
        // Bottom skid runner spanning from X = 0 to arm_len
        translate([0, y_rear_min, z_skid_min])
            cube([arm_len, total_y, skid_thick]);

        // Front wall (spanning Y from pocket_r to y_front_max)
        translate([0, pocket_r, z_skid_min])
            cube([arm_len, wall_front, skid_thick + pocket_r + 6.0]);

        // Rear wall (spanning Y from y_rear_min to -pocket_r + 2.0)
        translate([0, y_rear_min, z_skid_min])
            cube([arm_len, abs(y_rear_min - (-pocket_r + 2.0)), skid_thick + pocket_r + 6.0]);
    }
}

// ==============================================================================
// 3. PIECE 1: PRIMARY OUTSIDE SKID SHOE & CORNER BUMPER
// ==============================================================================

module corner_protector_piece1() {
    total_y = y_front_max - y_rear_min; // 47.0 mm

    difference() {
        // --- 1. POSITIVE SOLID BODY (True L-Shape with Bullnose Apex) ---
        union() {
            // Horizontal Arm 1 (along Rail A, +X)
            piece1_arm_solid();

            // Vertical Arm 2 (along Rail B, +Z) via 45° diagonal reflection
            multmatrix([
                [0, 0, 1, 0],
                [0, 1, 0, 0],
                [1, 0, 0, 0],
                [0, 0, 0, 1]
            ]) piece1_arm_solid();

            // Outer corner apex solid filling & bullnose rounding (X in [-24, 0], Z in [-24, 0])
            hull() {
                // Outer corner rounded edge
                translate([x_side_min + corner_apex_r, y_rear_min, z_skid_min + corner_apex_r])
                    rotate([-90, 0, 0])
                    cylinder(r = corner_apex_r, h = total_y);

                // Blend into Arm 1
                translate([0, y_rear_min, z_skid_min])
                    cube([1.0, total_y, skid_thick]);

                // Blend into Arm 2
                translate([x_side_min, y_rear_min, 0])
                    cube([skid_thick, total_y, 1.0]);

                // Front corner plate
                translate([x_side_min, pocket_r, z_skid_min])
                    cube([skid_thick + corner_apex_r, wall_front, skid_thick + corner_apex_r]);

                // Rear corner plate
                translate([x_side_min, y_rear_min, z_skid_min])
                    cube([skid_thick + corner_apex_r, abs(y_rear_min - (-pocket_r + 2.0)), skid_thick + corner_apex_r]);
            }
        }

        // --- 2. INTERNAL CAVITY (Loose Tolerance Pocket for Bunched Vinyl) ---
        // Cavity along Arm 1 (Rail A): open upwards (+Z)
        translate([-0.5, -pocket_r, -pocket_r])
            cube([arm_len + 5.0, pocket_dia, pocket_dia + 15.0]);

        // Cavity along Arm 2 (Rail B): open inwards (+X)
        translate([-pocket_r, -pocket_r, -0.5])
            cube([pocket_dia + 15.0, pocket_dia, arm_len + 5.0]);

        // Cylindrical bottom saddle rounding along Arm 1
        translate([-1.0, 0, 0])
            rotate([0, 90, 0])
            cylinder(r = pocket_r, h = arm_len + 5.0);

        // Cylindrical outer saddle rounding along Arm 2
        translate([0, 0, -1.0])
            cylinder(r = pocket_r, h = arm_len + 5.0);

        // Corner spherical clearance blend
        sphere(r = pocket_r);

        // --- 3. REAR UNUSED 3RD SOCKET / CORNER PLUG CLEARANCE CUTOUT ---
        // Bracket F has a rearward-facing socket at (0,0) where Corner Plug H seats
        translate([0, y_rear_min - 1.0, 0])
            rotate([-90, 0, 0])
            cylinder(r = rear_socket_relief_r, h = abs(y_rear_min) + 2.0);

        // --- 4. DISTAL LEAD-IN SKI-TIP RAMPS ---
        // Arm 1 bottom ramp (45° turf glide)
        translate([arm_len - lead_in_chamfer, y_rear_min - 1.0, z_skid_min])
            rotate([0, 45, 0])
            translate([0, 0, -10.0])
            cube([20.0, total_y + 2.0, 20.0]);

        // Arm 2 side ramp (45° side glide)
        translate([x_side_min, y_rear_min - 1.0, arm_len - lead_in_chamfer])
            rotate([0, -45, 0])
            translate([-10.0, 0, 0])
            cube([20.0, total_y + 2.0, 20.0]);

        // --- 5. FASTENER RETENTION BORES & COUNTERBORES ---
        // Bolt 1: Vertical bore on Arm 1 (Rail A)
        translate([bolt_offset, bolt_y_center, z_skid_min - 1.0]) {
            cylinder(r = bolt_dia / 2.0, h = 50.0);
            cylinder(r = bolt_head_dia / 2.0, h = bolt_head_depth + 1.0);
        }

        // Bolt 2: Horizontal bore on Arm 2 (Rail B)
        translate([x_side_min - 1.0, bolt_y_center, bolt_offset]) {
            rotate([0, 90, 0]) {
                cylinder(r = bolt_dia / 2.0, h = 50.0);
                cylinder(r = bolt_head_dia / 2.0, h = bolt_head_depth + 1.0);
            }
        }
    }
}

// ==============================================================================
// 4. PIECE 2: INSIDE CLAMP BLOCK & EMBEDDED NUT RETAINER
// ==============================================================================

// Single wing for Piece 2 (along Rail A, +X)
module piece2_wing_solid() {
    clamp_width = abs(y_rear_min - 0.0); // 25.5 mm (from y_rear_min to Y=0)

    union() {
        // Clamping body spanning from clamp_start to clamp_end
        translate([clamp_start, y_rear_min, bracket_r - 2.0])
            cube([clamp_end - clamp_start, clamp_width, clamp_thickness + 6.0]);
    }
}

module corner_protector_piece2() {
    clamp_width = abs(y_rear_min - 0.0); // 25.5 mm

    difference() {
        // --- 1. POSITIVE CLAMP BODY (100% Symmetric via Diagonal Reflection) ---
        union() {
            // Horizontal Wing (along Rail A, +X)
            piece2_wing_solid();

            // Vertical Wing (along Rail B, +Z) via 45° diagonal reflection
            multmatrix([
                [0, 0, 1, 0],
                [0, 1, 0, 0],
                [1, 0, 0, 0],
                [0, 0, 0, 1]
            ]) piece2_wing_solid();

            // Inner crook rigid corner gusset
            hull() {
                translate([clamp_start, y_rear_min, bracket_r - 2.0])
                    cube([14.0, clamp_width, clamp_thickness + 6.0]);
                translate([bracket_r - 2.0, y_rear_min, clamp_start])
                    cube([clamp_thickness + 6.0, clamp_width, 14.0]);
            }
        }

        // --- 2. CONCAVE SADDLE CUTOUTS (Clamps Tight to Bracket F Sleeve) ---
        // Arm 1 saddle (cylindrical cutout along X axis)
        translate([clamp_start - 5.0, 0, 0])
            rotate([0, 90, 0])
            cylinder(r = clamp_saddle_r, h = clamp_end - clamp_start + 15.0);

        // Arm 2 saddle (cylindrical cutout along Z axis)
        translate([0, 0, clamp_start - 5.0])
            cylinder(r = clamp_saddle_r, h = clamp_end - clamp_start + 15.0);

        // Inner crook clearance fillet / chamfer (at apex only)
        translate([bracket_r - 3.0, y_rear_min - 1.0, bracket_r - 3.0])
            rotate([0, 45, 0])
            translate([-10.0, -1.0, -10.0])
            cube([20.0, clamp_width + 2.0, 20.0]);

        // --- 3. EMBEDDED NUT POCKETS & FASTENER BORES ---
        // Nut 1 (Rail A wing): Receives vertical Bolt 1
        translate([bolt_offset, bolt_y_center, 0]) {
            // Clearance through-bore
            translate([0, 0, -5.0])
                cylinder(r = bolt_dia / 2.0, h = 45.0);

            // Hex nut pocket (recessed into top surface of clamp wing)
            translate([0, 0, bracket_r + clamp_thickness - nut_depth + 1.0])
                rotate([0, 0, 30])
                hex_nut_pocket(nut_flats, nut_depth + 2.0);
        }

        // Nut 2 (Rail B wing): Receives horizontal Bolt 2
        translate([0, bolt_y_center, bolt_offset]) {
            // Clearance through-bore
            rotate([0, 90, 0])
                translate([0, 0, -5.0])
                cylinder(r = bolt_dia / 2.0, h = 45.0);

            // Hex nut pocket (recessed into inner surface of clamp wing)
            translate([bracket_r + clamp_thickness - nut_depth + 1.0, 0, 0])
                rotate([0, 90, 0])
                rotate([0, 0, 30])
                hex_nut_pocket(nut_flats, nut_depth + 2.0);
        }
    }
}

// ==============================================================================
// 5. ASSEMBLED PREVIEW & PRINT-READY PLATES
// ==============================================================================

// Preview mode: Assembled together with simulated Bracket F & bolts
module corner_protector_assembly() {
    // Piece 1: Outside Skid Shoe (Charcoal Gray)
    color([0.28, 0.28, 0.32, 0.90])
        corner_protector_piece1();

    // Piece 2: Inside Clamp Block (Safety Cyan Accent)
    color([0.15, 0.60, 0.88, 0.95])
        corner_protector_piece2();

    // Simulated 3/4" EMT Conduit Rails (Silver Ghost)
    color([0.80, 0.82, 0.85, 0.35]) {
        // Rail A
        translate([0, 0, 0])
            rotate([0, 90, 0])
            cylinder(r = conduit_r, h = 105.0);
        // Rail B
        translate([0, 0, 0])
            cylinder(r = conduit_r, h = 105.0);
        // Rear 3rd Socket
        translate([0, 0, 0])
            rotate([-90, 0, 0])
            cylinder(r = bracket_r, h = 35.0);
    }

    // Simulated Clamping Bolts (Gold / Brass)
    color([0.92, 0.75, 0.18, 1.0]) {
        // Bolt 1 (Vertical, M5x40mm)
        translate([bolt_offset, bolt_y_center, z_skid_min + bolt_head_depth])
            cylinder(r = bolt_dia / 2.0 - 0.2, h = 42.0);
        // Bolt 2 (Horizontal, M5x40mm)
        translate([x_side_min + bolt_head_depth, bolt_y_center, bolt_offset])
            rotate([0, 90, 0])
            cylinder(r = bolt_dia / 2.0 - 0.2, h = 42.0);
    }
}

// Dual-print plate layout (Piece 1 + Piece 2 ready for slicing)
module corner_protector_pair_plate() {
    // Piece 1: Oriented resting flat on front face (+Y face down)
    translate([-15.0, 0, y_front_max])
        rotate([90, 0, 0])
        corner_protector_piece1();

    // Piece 2: Oriented resting flat on rear face
    translate([80.0, 30.0, abs(y_rear_min)])
        rotate([-90, 0, 0])
        corner_protector_piece2();
}

// ==============================================================================
// 6. TOP-LEVEL RENDER DISPATCH
// ==============================================================================

if (part == "piece1") {
    corner_protector_piece1();
} else if (part == "piece2") {
    corner_protector_piece2();
} else if (part == "pair") {
    corner_protector_pair_plate();
} else {
    corner_protector_assembly();
}
