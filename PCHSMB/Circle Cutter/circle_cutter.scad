// =============================================================================
// PCHSMB Circle Cutter - OpenSCAD Parametric Model v1.3
// Semicircular Wind Relief Slit Tooling for Marching Band Field Props
// Modular 4-Piece Architecture with 625 Roller Bearing & Support-Free Snap Cap
// =============================================================================

$fn = 96;

// -----------------------------------------------------------------------------
// Piece 1: Fixed Pivot Base (4.0mm level plate matching arm ground clearance)
// -----------------------------------------------------------------------------
module piece1_base() {
    difference() {
        union() {
            // Base plate (50.0mm dia x 4.0mm tall)
            cylinder(r = 25.0, h = 4.0);
            
            // Center spindle (40.0mm dia x 98.5mm tall above base)
            translate([0, 0, 4.0])
                cylinder(r = 20.0, h = 98.5);
                
            // Top lead-in chamfer (1.5mm x 45 deg)
            translate([0, 0, 102.5])
                cylinder(r1 = 20.0, r2 = 18.5, h = 1.5);
        }
        
        // 4 Vertical crosshair notches (1.0mm deep x 1.8mm wide)
        for (a = [0, 90, 180, 270]) {
            rotate([0, 0, a])
                translate([24.0, -0.9, -0.5])
                    cube([3.0, 1.8, 5.0]);
        }
    }
}

// 2D Beveled profile helper
module beveled_rect(w, h, b) {
    polygon([
        [w/2 - b, -h/2], [w/2, -h/2 + b],
        [w/2, h/2 - b], [w/2 - b, h/2],
        [-w/2 + b, h/2], [-w/2, h/2 - b],
        [-w/2, -h/2 + b], [-w/2 + b, -h/2]
    ]);
}

// -----------------------------------------------------------------------------
// Piece 2: Rotating Arm Assembly (Open through-bore, 625 bearing & blade dual head)
// -----------------------------------------------------------------------------
module piece2_arm() {
    difference() {
        union() {
            // Hub sleeve (50.0mm outer dia, 108.0mm total height)
            cylinder(r = 25.0, h = 108.0);
            
            // Arm straight section (X = 18 to 135mm, 20.0mm W x 12.0mm H)
            translate([18.0, -10.0, 0])
                cube([117.0, 20.0, 12.0]);
                
            // Transition flare (X = 135 to 155mm, 20.0mm -> 36.0mm W)
            hull() {
                translate([135.0, -10.0, 0]) cube([0.1, 20.0, 12.0]);
                translate([155.0, -18.0, 0]) cube([0.1, 36.0, 12.0]);
            }
            
            // Side-by-Side Dual Head block (X = 155 to 175mm, 36.0mm W x 12.0mm H)
            translate([155.0, -18.0, 0])
                cube([20.0, 36.0, 12.0]);
                
            // 625 Bearing Standoff Boss on Bearing Pad (Y = -9.0mm, Z = 4.0mm, X = 175 to 176mm)
            translate([175.0, -9.0, 4.0])
                rotate([0, 90, 0])
                    cylinder(r = 4.0, h = 1.0);
                    
            // Blade Anti-Rotation Retaining Tabs flanking 6.0mm blade slot on Blade Pad (Y = +9.0mm)
            translate([175.0, 0.0, 0])
                cube([0.8, 6.0, 12.0]);
            translate([175.0, 12.0, 0])
                cube([0.8, 6.0, 12.0]);
        }
        
        // Open through-bore (42.0mm dia through entire 108mm sleeve)
        translate([0, 0, -1.0])
            cylinder(r = 21.0, h = 110.0);
            
        // Internal annular retention groove for Piece 4 Snap Cap (43.6mm dia at Z = 103.5 to 105.5mm)
        translate([0, 0, 102.7])
            cylinder(r1 = 21.0, r2 = 21.8, h = 0.8);
        translate([0, 0, 103.5])
            cylinder(r = 21.8, h = 2.0);
        translate([0, 0, 105.5])
            cylinder(r1 = 21.8, r2 = 21.0, h = 0.8);
            
        // Top outer chamfer on hub sleeve rim
        translate([0, 0, 106.5])
            difference() {
                cylinder(r = 27.0, h = 2.0);
                cylinder(r1 = 25.0, r2 = 23.5, h = 1.5);
            }
            
        // Top inner entry chamfer on hub sleeve rim
        translate([0, 0, 107.0])
            cylinder(r1 = 21.0, r2 = 22.0, h = 1.5);
            
        // M5 Heat-Set Insert Hole for 625 bearing axle (7.0mm dia x 8.0mm depth at Y = -9.0, Z = 4.0)
        translate([167.0, -9.0, 4.0])
            rotate([0, 90, 0])
                cylinder(r = 3.5, h = 10.0);
                
        // M3 Heat-Set Insert Hole for blade clamp (4.2mm dia x 6.5mm depth at Y = +9.0, Z = 6.0)
        translate([169.3, 9.0, 6.0])
            rotate([0, 90, 0])
                cylinder(r = 2.1, h = 8.5);
    }
}

// -----------------------------------------------------------------------------
// Piece 3: Blade Clamping Cap
// -----------------------------------------------------------------------------
module piece3_blade_cap() {
    difference() {
        // Chamfered clamping plate (12.0mm W x 16.0mm H x 3.5mm T)
        translate([0, 9.0, 6.0])
            rotate([0, 90, 0])
                linear_extrude(height = 3.5)
                    beveled_rect(16.0, 12.0, 1.0);
                    
        // M3 screw clearance through-hole (3.4mm dia)
        translate([-1.0, 9.0, 6.0])
            rotate([0, 90, 0])
                cylinder(r = 1.7, h = 5.5);
    }
}

// -----------------------------------------------------------------------------
// Piece 4: Snap-in Hub Top Cap (Support-Free, 4 Flex Collet Fingers)
// -----------------------------------------------------------------------------
module piece4_hub_cap() {
    difference() {
        union() {
            // Top Flange (50.0mm OD x 3.0mm thick, Z = 0 to 3mm)
            cylinder(r = 25.0, h = 3.0);
            
            // Collet skirt body (41.6mm OD x 6.0mm deep, Z = -6.0 to 0mm)
            translate([0, 0, -6.0])
                cylinder(r = 20.8, h = 6.0);
                
            // Annular retention barb (43.0mm OD, Z = -3.5 to -2.5mm)
            translate([0, 0, -5.5])
                cylinder(r1 = 20.8, r2 = 21.5, h = 2.0); // 30 deg entry ramp
            translate([0, 0, -3.5])
                cylinder(r1 = 21.5, r2 = 20.8, h = 1.0); // 45 deg retention shoulder
        }
        
        // Inner hollow bore of collet skirt (38.0mm ID)
        translate([0, 0, -7.0])
            cylinder(r = 19.0, h = 8.5);
            
        // Top perimeter bevel (1.5mm x 45 deg)
        translate([0, 0, 1.5])
            difference() {
                cylinder(r = 27.0, h = 2.0);
                cylinder(r1 = 25.0, r2 = 23.5, h = 1.5);
            }
            
        // 4 Vertical flex relief slots (2.4mm wide)
        for (a = [0, 90]) {
            rotate([0, 0, a])
                translate([-25.0, -1.2, -7.0])
                    cube([50.0, 2.4, 8.0]);
        }
    }
}

// -----------------------------------------------------------------------------
// Hardware Reference Models (625 Bearing & X-Acto Blade)
// -----------------------------------------------------------------------------
module hardware_625_bearing() {
    difference() {
        cylinder(r = 8.0, h = 5.0);
        translate([0, 0, -1]) cylinder(r = 2.5, h = 7.0);
    }
}

module hardware_blade() {
    color("silver")
        translate([175.5, 9.0, 6.0])
            rotate([0, 90, 0])
                linear_extrude(height = 0.5)
                    polygon([
                        [6.0, -4.0], [6.0, 4.0], [-10.0, 4.0], [-18.0, -4.0]
                    ]);
}

// -----------------------------------------------------------------------------
// Full Assembly & Exploded Views
// -----------------------------------------------------------------------------
module full_assembly() {
    // Piece 1: Fixed Pivot Base (Ground level Z = 0)
    color("steelblue") piece1_base();
    
    // Piece 2: Rotating Arm Assembly (Seats at Z = 4.0mm on base shoulder)
    color("darkorange", 0.95) translate([0, 0, 4.0]) piece2_arm();
    
    // Piece 3: Blade Clamping Cap
    color("dimgray") translate([176.3, 0, 4.0]) piece3_blade_cap();
    
    // Piece 4: Snap-in Hub Top Cap (Snaps into top of arm at Z = 112.0mm)
    color("forestgreen", 0.95) translate([0, 0, 112.0]) piece4_hub_cap();
    
    // 625 Roller Bearing (Mounted on boss at X = 176.0mm, Y = -9.0mm, Z = 8.0mm)
    color("lightgray")
        translate([176.0, -9.0, 8.0])
            rotate([0, 90, 0])
                hardware_625_bearing();
                
    // X-Acto Blade
    hardware_blade();
}

module exploded_view() {
    // Piece 1: Fixed Pivot Base
    color("steelblue") piece1_base();
    
    // Piece 2: Rotating Arm Assembly (Lifted Z = 45.0mm)
    color("darkorange", 0.95) translate([0, 0, 45.0]) piece2_arm();
    
    // Piece 3: Blade Clamping Cap (Exploded outward +X = 35.0mm)
    color("dimgray") translate([210.0, 0, 45.0]) piece3_blade_cap();
    
    // Piece 4: Snap-in Hub Top Cap (Exploded upward +Z = 50.0mm above arm)
    color("forestgreen", 0.95) translate([0, 0, 195.0]) piece4_hub_cap();
    
    // 625 Roller Bearing (Exploded outward +X = 25.0mm)
    color("lightgray")
        translate([201.0, -9.0, 49.0])
            rotate([0, 90, 0])
                hardware_625_bearing();
}

// Mode selector for headless rendering:
mode = "assembly"; // "assembly" or "exploded"

if (mode == "assembly") {
    full_assembly();
} else if (mode == "exploded") {
    exploded_view();
}
