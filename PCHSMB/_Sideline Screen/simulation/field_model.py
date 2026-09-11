#!/usr/bin/env python3
"""
Field Geometry and Coordinate System for Sideline Screen Monte Carlo Simulation.

Defines:
- Standard High School Football Field dimensions (120 x 53.33 yards)
- 16 Sideline Screen (Duck Blind) coordinates (8 per side, centered 42yd line moving outward)
- Permitted starting locations (End Zone behind goal, Back Sideline 20/40/50, End Zone corner)
- Route distances, waypoints, and corner turn counts for each configuration.
"""

import math
from typing import Dict, List, Tuple, NamedTuple

# Field Dimensions in Yards
FIELD_LENGTH_YARDS = 100.0  # Goal line to goal line
END_ZONE_DEPTH_YARDS = 10.0 # Depth of each end zone
FIELD_WIDTH_YARDS = 53.333  # 160 feet = 53.333 yards
FRONT_SIDELINE_Y = 0.0      # Front sideline (spectator/judges side)
BACK_SIDELINE_Y = 53.333    # Back sideline
CENTERFIELD_X = 0.0         # 50-yard line is X = 0.0

# Goal posts centered at Y = 26.667 yards (80 ft from sidelines), on end lines (X = +/- 60 yd)
GOAL_POST_Y = FIELD_WIDTH_YARDS / 2.0  # 26.667 yd

# Screen Dimensions
SCREEN_WIDTH_FEET = 8.0     # 8 ft nominal face width
SCREEN_WIDTH_YARDS = SCREEN_WIDTH_FEET / 3.0  # 2.667 yards per screen
SCREENS_PER_SIDE = 8
TOTAL_SCREENS = 16

class Point(NamedTuple):
    x: float
    y: float

class ScreenCoordinate(NamedTuple):
    screen_id: int
    side: int  # 1 (Left / Stage Left / Negative X) or 2 (Right / Stage Right / Positive X)
    centerfield_edge_x: float
    outer_edge_x: float
    center_x: float
    y: float

def get_screen_coordinates() -> Dict[int, ScreenCoordinate]:
    """
    Returns the exact front sideline coordinates for all 16 screens.
    Side 1: Screens 1-8 (X < 0)
      - Screen 1 centerfield edge at 42-yard line (8.0 yd from 50)
      - Lined up end-to-end moving outward toward the endzone.
    Side 2: Screens 9-16 (X > 0, mirrored)
      - Screen 9 (Side 2 Screen 1) centerfield edge at 42-yard line (X = +8.0 yd)
      - Lined up end-to-end moving outward toward Side 2 endzone.
    """
    screens = {}
    
    # Side 1: X is negative
    # 42 yard line is 8.0 yards from centerfield (X = -8.0)
    for i in range(1, SCREENS_PER_SIDE + 1):
        cf_edge = -(8.0 + (i - 1) * SCREEN_WIDTH_YARDS)
        out_edge = -(8.0 + i * SCREEN_WIDTH_YARDS)
        center_x = (cf_edge + out_edge) / 2.0
        screens[i] = ScreenCoordinate(
            screen_id=i,
            side=1,
            centerfield_edge_x=cf_edge,
            outer_edge_x=out_edge,
            center_x=center_x,
            y=FRONT_SIDELINE_Y
        )
        
    # Side 2: X is positive (mirrored)
    for i in range(1, SCREENS_PER_SIDE + 1):
        global_id = i + 8
        cf_edge = 8.0 + (i - 1) * SCREEN_WIDTH_YARDS
        out_edge = 8.0 + i * SCREEN_WIDTH_YARDS
        center_x = (cf_edge + out_edge) / 2.0
        screens[global_id] = ScreenCoordinate(
            screen_id=global_id,
            side=2,
            centerfield_edge_x=cf_edge,
            outer_edge_x=out_edge,
            center_x=center_x,
            y=FRONT_SIDELINE_Y
        )
        
    return screens

# Permitted Starting Locations
# Note: Ingress must comply with CBA Rule 5.02 (Back sideline or rear endzone above goal posts)
STARTING_LOCATIONS = {
    # 1. End Zone behind goal posts, just outside end line (X = +/- 63 yd, Y = 26.67 yd)
    "EZ_Behind_Goal": {
        "side1": Point(x=-63.0, y=GOAL_POST_Y),
        "side2": Point(x=63.0, y=GOAL_POST_Y),
        "description": "Behind goal post outside end line (X = +/- 63 yd, Y = 26.7 yd)"
    },
    # 2. Back corner of end zone / field entry gate (X = +/- 60 yd, Y = 55.0 yd)
    "EZ_Corner_Back": {
        "side1": Point(x=-60.0, y=55.0),
        "side2": Point(x=60.0, y=55.0),
        "description": "Back end zone corner gate (X = +/- 60 yd, Y = 55.0 yd)"
    },
    # 3. Back sideline at 20-yard line (aligned with outer edge of screens)
    "Back_20": {
        "side1": Point(x=-30.0, y=55.0),
        "side2": Point(x=30.0, y=55.0),
        "description": "Back sideline at 20-yard line (aligned with Screen 8, Y = 55.0 yd)"
    },
    # 4. Back sideline at 40-yard line (aligned with inner edge of screens)
    "Back_40": {
        "side1": Point(x=-10.0, y=55.0),
        "side2": Point(x=10.0, y=55.0),
        "description": "Back sideline at 40-yard line (aligned with Screen 1, Y = 55.0 yd)"
    },
    # 5. Back sideline at 50-yard line (centerfield)
    "Back_50": {
        "side1": Point(x=0.0, y=55.0),
        "side2": Point(x=0.0, y=55.0),
        "description": "Back sideline at 50-yard line (centerfield, Y = 55.0 yd)"
    }
}

class RouteSegment(NamedTuple):
    name: str
    distance_yards: float
    turns_90deg: int
    load_state: str  # 'loaded', 'dropping', 'empty'

class DeploymentRoute(NamedTuple):
    config: str            # '1_cart' or '2_carts'
    start_key: str
    cart_id: int           # 1 (Side 1) or 2 (Side 2)
    segments: List[RouteSegment]
    total_distance_yards: float
    total_turns: int
    screen_order: List[int] # Sequence of screen IDs dropped

def compute_route(
    config: str,
    start_key: str,
    cart_id: int = 1,
    pit_cross_mode: str = "front_sideline"  # For 1 cart: 'front_sideline' or 'behind_pit'
) -> DeploymentRoute:
    """
    Computes optimal transit segments, distances, and turns for a cart route.
    
    For 2 Carts:
      - Cart 1 serves Side 1 (Screens 1-8)
      - Cart 2 serves Side 2 (Screens 9-16)
      - Route drops screens in sequence that minimizes travel distance.
      
    For 1 Cart:
      - Starts at chosen location on Side 1 (or Back 50)
      - Drops Side 1 screens (1-8)
      - Transits across centerfield to Side 2
      - Drops Side 2 screens (9-16)
      - Stows off-field at Side 2
    """
    screens = get_screen_coordinates()
    segments = []
    screen_order = []
    
    if config == "2_carts":
        # Operating independently on cart_id side
        start_pt = STARTING_LOCATIONS[start_key]["side1" if cart_id == 1 else "side2"]
        sign = -1.0 if cart_id == 1 else 1.0
        
        # Decide drop direction based on start position
        # Screen 1 is at |X| = 9.33 yd (near 42yd line)
        # Screen 8 is at |X| = 28.0 yd (near 22yd line)
        dist_to_screen1 = math.hypot(start_pt.x - sign * 9.33, start_pt.y - FRONT_SIDELINE_Y)
        dist_to_screen8 = math.hypot(start_pt.x - sign * 28.0, start_pt.y - FRONT_SIDELINE_Y)
        
        if dist_to_screen1 < dist_to_screen8:
            # Drop from Screen 1 outward to Screen 8
            ordered_ids = list(range(1, 9)) if cart_id == 1 else list(range(9, 17))
            entry_target = screens[ordered_ids[0]]
            stow_target = screens[ordered_ids[-1]]
        else:
            # Drop from Screen 8 inward to Screen 1
            ordered_ids = list(range(8, 0, -1)) if cart_id == 1 else list(range(16, 8, -1))
            entry_target = screens[ordered_ids[0]]
            stow_target = screens[ordered_ids[-1]]
            
        screen_order = ordered_ids
        
        # Segment 1: Ingress from Start Point to First Screen Drop
        dx = abs(start_pt.x - entry_target.center_x)
        dy = abs(start_pt.y - FRONT_SIDELINE_Y)
        
        if start_key in ["Back_20", "Back_40"]:
            # Direct shot down yard-line corridor to front sideline
            ingress_dist = math.hypot(dx, dy)
            ingress_turns = 1 # Turn onto front sideline
        elif start_key == "Back_50":
            ingress_dist = dy + dx
            ingress_turns = 1
        elif start_key == "EZ_Corner_Back":
            ingress_dist = dy + dx
            ingress_turns = 1
        else:  # EZ_Behind_Goal
            ingress_dist = dy + dx
            ingress_turns = 2
            
        segments.append(RouteSegment("ingress", ingress_dist, ingress_turns, "loaded"))
        
        # Segment 2: Dropping screens along the front sideline
        drop_transit_dist = (SCREENS_PER_SIDE - 1) * SCREEN_WIDTH_YARDS
        segments.append(RouteSegment("drop_line", drop_transit_dist, 0, "dropping"))
        
        # Segment 3: Cart Stowage (across front sideline off-field)
        stow_dist = 8.0  # 8 yards across front boundary into out-of-bounds parking
        segments.append(RouteSegment("stowage", stow_dist, 1, "empty"))
        
    else:
        # 1 Cart serving all 16 screens (Side 1 then Side 2)
        start_pt = STARTING_LOCATIONS[start_key]["side1"]
        
        # On Side 1, drop from Screen 8 inward to Screen 1
        # so cart ends up at 42-yd line, right next to centerfield to cross to Side 2
        side1_order = list(range(8, 0, -1))
        # On Side 2, drop from Screen 9 (42yd line) outward to Screen 16 (22yd line)
        side2_order = list(range(9, 17))
        screen_order = side1_order + side2_order
        
        # Segment 1: Ingress to Side 1 Screen 8
        target_s8 = screens[8]
        dx = abs(start_pt.x - target_s8.center_x)
        dy = abs(start_pt.y - FRONT_SIDELINE_Y)
        
        if start_key == "Back_20":
            ingress_dist = math.hypot(dx, dy)
            ingress_turns = 1
        elif start_key in ["Back_40", "Back_50"]:
            ingress_dist = dy + dx
            ingress_turns = 1
        elif start_key == "EZ_Behind_Goal":
            ingress_dist = dy + dx
            ingress_turns = 2
        else: # EZ_Corner_Back
            ingress_dist = dy + dx
            ingress_turns = 1
            
        segments.append(RouteSegment("ingress_side1", ingress_dist, ingress_turns, "loaded"))
        
        # Segment 2: Drop Side 1 Screens (8 down to 1, moving toward center)
        drop_s1_dist = (SCREENS_PER_SIDE - 1) * SCREEN_WIDTH_YARDS  # 18.67 yd
        segments.append(RouteSegment("drop_side1", drop_s1_dist, 0, "dropping"))
        
        # Segment 3: Cross-field Transit from Side 1 Screen 1 (X = -8.0) to Side 2 Screen 9 (X = +8.0)
        # Distance between 42yd line Side 1 and 42yd line Side 2 is 16 yards across center
        if pit_cross_mode == "front_sideline":
            pit_dist = 16.0  # 16 yards straight along front sideline
            pit_turns = 0
        else:
            pit_dist = 10.0 + 16.0 + 10.0 # 36 yards
            pit_turns = 2
        segments.append(RouteSegment("pit_cross", pit_dist, pit_turns, "transit_half_loaded"))
        
        # Segment 4: Drop Side 2 Screens (9 out to 16, moving toward Side 2 endzone)
        drop_s2_dist = (SCREENS_PER_SIDE - 1) * SCREEN_WIDTH_YARDS  # 18.67 yd
        segments.append(RouteSegment("drop_side2", drop_s2_dist, 0, "dropping"))
        
        # Segment 5: Stowage on Side 2
        stow_dist = 8.0
        segments.append(RouteSegment("stowage", stow_dist, 1, "empty"))
        
    total_dist = sum(s.distance_yards for s in segments)
    total_turns = sum(s.turns_90deg for s in segments)
    
    return DeploymentRoute(
        config=config,
        start_key=start_key,
        cart_id=cart_id,
        segments=segments,
        total_distance_yards=total_dist,
        total_turns=total_turns,
        screen_order=screen_order
    )

if __name__ == "__main__":
    print("=== FIELD GEOMETRY VERIFICATION ===")
    screens = get_screen_coordinates()
    print(f"Total screens defined: {len(screens)}")
    print(f"Side 1 Screen 1: centerfield edge = {screens[1].centerfield_edge_x:.2f} yd, outer = {screens[1].outer_edge_x:.2f} yd")
    print(f"Side 1 Screen 8: centerfield edge = {screens[8].centerfield_edge_x:.2f} yd, outer = {screens[8].outer_edge_x:.2f} yd")
    print(f"Side 2 Screen 9: centerfield edge = {screens[9].centerfield_edge_x:.2f} yd, outer = {screens[9].outer_edge_x:.2f} yd")
    print(f"Side 2 Screen 16: centerfield edge = {screens[16].centerfield_edge_x:.2f} yd, outer = {screens[16].outer_edge_x:.2f} yd")
    
    print("\n=== ROUTE DISTANCE SUMMARY ===")
    for sk in STARTING_LOCATIONS:
        r2 = compute_route("2_carts", sk, cart_id=1)
        r1 = compute_route("1_cart", sk, pit_cross_mode="front_sideline")
        print(f"[{sk}]")
        print(f"   2 Carts (Side 1): {r2.total_distance_yards:.1f} yd, {r2.total_turns} turns")
        print(f"   1 Cart (Fleet)  : {r1.total_distance_yards:.1f} yd, {r1.total_turns} turns")
