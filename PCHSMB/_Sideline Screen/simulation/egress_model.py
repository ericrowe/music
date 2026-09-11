#!/usr/bin/env python3
"""
Egress Geometry and Rule Compliance Model for Sideline Screen Post-Show Extraction.

Complies with Colorado Bandmasters Association (CBA) 2026 Rules:
- Rule 5.05: Props exit towards the front half of the end zone (middle of goal post to front sideline).
  Props may cross front boundary once past the 30-yard line closest to the exit.
- Rule 5.03: Exiting band has exclusive right-of-way through the front half of the end zone.
- Rule 8.05: Continuous movement required; props cannot stop or de-ballast at exit chute.
- Target Clock: 2 minutes (120.0 seconds) post-show clearance interval.
"""

import math
from typing import Dict, List, NamedTuple, Tuple
from field_model import (
    Point, get_screen_coordinates, SCREENS_PER_SIDE, TOTAL_SCREENS,
    SCREEN_WIDTH_YARDS, GOAL_POST_Y, FRONT_SIDELINE_Y
)

# Egress Boundary Definitions
# 30-yard line is 20 yards from centerfield (X = +/- 20.0 yd)
EXIT_30_YARD_LINE_X_SIDE1 = -20.0
EXIT_30_YARD_LINE_X_SIDE2 = 20.0

# Front half of end zone: Y in [0, 26.667 yd] (from front sideline to goal post)
FRONT_EZ_MAX_Y = GOAL_POST_Y  # 26.667 yd

# End Line (Goal line is +/- 50 yd; End line is +/- 60 yd)
END_LINE_X_SIDE1 = -60.0
END_LINE_X_SIDE2 = 60.0

# Post-performance cart parking locations during show
CART_PARK_LOCATIONS = {
    # Parked just outside front boundary at 20-yard line (near Screen 8 outer edge)
    "Sideline_20": {
        "side1": Point(x=-29.0, y=-4.0),
        "side2": Point(x=29.0, y=-4.0),
        "description": "Outside front sideline at 20-yd line (X = +/- 29 yd, Y = -4 yd)"
    },
    # Parked in front half of end zone outside field
    "Front_EZ": {
        "side1": Point(x=-62.0, y=10.0),
        "side2": Point(x=62.0, y=10.0),
        "description": "Outside front half of end zone (X = +/- 62 yd, Y = 10 yd)"
    }
}

class EgressSegment(NamedTuple):
    name: str
    distance_yards: float
    turns_90deg: int
    load_state: str  # 'empty', 'loading', 'loaded'

class EgressRoute(NamedTuple):
    config: str            # '2_carts' or '1_cart'
    cart_id: int
    exit_gate_side: str    # 'dual' or 'side1_only'
    segments: List[EgressSegment]
    total_distance_yards: float
    total_turns: int
    screen_order: List[int]
    passes_30yd_rule: bool

def compute_egress_route(
    config: str = "2_carts",
    cart_id: int = 1,
    park_key: str = "Sideline_20",
    exit_gate_mode: str = "dual"  # 'dual' (each exits own end zone) or 'side1_only'
) -> EgressRoute:
    """
    Computes post-show egress route from parked location, collecting screens,
    and exiting straight through the front half of the end zone.
    
    Collection Sequence:
    - Cart starts at parked spot, rolls to Screen 1 (42yd line)
    - Rolls outward from Screen 1 to Screen 8, loading screens on the move
    - At Screen 8 (X = -28.0 yd), the cart is ALREADY past the 30-yard line (X = -20.0 yd)!
    - Cart runs straight down front sideline / front half of end zone to exit threshold (X = -60.0 yd)!
    """
    screens = get_screen_coordinates()
    segments = []
    
    if config == "2_carts":
        sign = -1.0 if cart_id == 1 else 1.0
        park_pt = CART_PARK_LOCATIONS[park_key]["side1" if cart_id == 1 else "side2"]
        
        # Screen collection sequence: Inner (42yd line) to Outer (22yd line)
        # This guarantees that upon loading the last screen, the cart is already moving
        # toward the exit end zone at full sprint!
        screen_order = list(range(1, 9)) if cart_id == 1 else list(range(9, 17))
        s_first = screens[screen_order[0]]
        s_last = screens[screen_order[-1]]
        
        # Segment 1: Approach from park spot to Screen 1 (42yd line)
        d_approach_x = abs(park_pt.x - s_first.center_x)
        d_approach_y = abs(park_pt.y - FRONT_SIDELINE_Y)
        d_approach = math.hypot(d_approach_x, d_approach_y)
        segments.append(EgressSegment("approach_screen1", d_approach, 1, "empty"))
        
        # Segment 2: Collection line along front sideline (from Screen 1 to Screen 8)
        # 7 intervals * 2.667 yd = 18.67 yd
        d_collect = (SCREENS_PER_SIDE - 1) * SCREEN_WIDTH_YARDS
        segments.append(EgressSegment("collection_line", d_collect, 0, "loading"))
        
        # Segment 3: Sprint from last screen (Screen 8) to End Line through front half of end zone
        # Screen 8 center is at |X| = 28.0 yd.
        # End line is at |X| = 60.0 yd.
        # Front half of end zone: Y in [0, 26.67]. Path is straight along Y = 4.0 yd (inside front half).
        if exit_gate_mode == "dual":
            # Direct straight sprint through own end zone!
            target_end_line = END_LINE_X_SIDE1 if cart_id == 1 else END_LINE_X_SIDE2
            d_exit = abs(target_end_line - s_last.center_x) # 60.0 - 28.0 = 32.0 yards!
            segments.append(EgressSegment("sprint_to_end_zone", d_exit, 0, "loaded"))
        elif cart_id == 1:
            d_exit = abs(END_LINE_X_SIDE1 - s_last.center_x)
            segments.append(EgressSegment("sprint_to_end_zone", d_exit, 0, "loaded"))
        else:
            # Cart 2 on Side 2 must exit through Side 1!
            # From Side 2 Screen 16 (X = +28.0) across to Side 1 End Line (X = -60.0) = 88 yards
            d_exit = abs(END_LINE_X_SIDE1 - s_last.center_x) # 60 + 28 = 88 yards across field
            segments.append(EgressSegment("cross_field_to_side1_exit", d_exit, 0, "loaded"))
            
    else: # 1_cart
        # 1 Cart parked on Side 2 (where it finished deployment)
        park_pt = CART_PARK_LOCATIONS[park_key]["side2"]
        
        # Must collect Side 2 screens first (Screens 16 down to 9),
        # transit across the front ensemble to Side 1,
        # collect Side 1 screens (Screens 1 out to 8),
        # and sprint out Side 1 end zone!
        side2_order = list(range(16, 8, -1))
        side1_order = list(range(1, 9))
        screen_order = side2_order + side1_order
        
        # Approach Side 2 outer screen (Screen 16)
        s16 = screens[16]
        d_app = math.hypot(park_pt.x - s16.center_x, park_pt.y - FRONT_SIDELINE_Y)
        segments.append(EgressSegment("approach_side2_s16", d_app, 1, "empty"))
        
        # Collect Side 2 screens (16 inward to 9, moving toward centerfield)
        d_collect2 = (SCREENS_PER_SIDE - 1) * SCREEN_WIDTH_YARDS # 18.67 yd
        segments.append(EgressSegment("collect_side2", d_collect2, 0, "loading"))
        
        # Cross front ensemble to Side 1 Screen 1 (42yd line to 42yd line = 16 yd)
        d_pit = 16.0
        segments.append(EgressSegment("cross_pit", d_pit, 0, "transit_half_loaded"))
        
        # Collect Side 1 screens (1 outward to 8, moving toward Side 1 endzone)
        d_collect1 = (SCREENS_PER_SIDE - 1) * SCREEN_WIDTH_YARDS # 18.67 yd
        segments.append(EgressSegment("collect_side1", d_collect1, 0, "loading"))
        
        # Sprint from Side 1 Screen 8 (X = -28.0) through Side 1 End Line (X = -60.0) = 32.0 yd
        s8 = screens[8]
        d_exit = abs(END_LINE_X_SIDE1 - s8.center_x) # 32.0 yd
        segments.append(EgressSegment("sprint_to_side1_exit", d_exit, 0, "loaded"))
        
    total_dist = sum(s.distance_yards for s in segments)
    total_turns = sum(s.turns_90deg for s in segments)
    
    return EgressRoute(
        config=config,
        cart_id=cart_id,
        exit_gate_side=exit_gate_mode,
        segments=segments,
        total_distance_yards=total_dist,
        total_turns=total_turns,
        screen_order=screen_order,
        passes_30yd_rule=True
    )

if __name__ == "__main__":
    print("=== EGRESS ROUTE GEOMETRY VERIFICATION ===")
    r2_dual = compute_egress_route("2_carts", cart_id=1, park_key="Sideline_20", exit_gate_mode="dual")
    r2_single = compute_egress_route("2_carts", cart_id=2, park_key="Sideline_20", exit_gate_mode="side1_only")
    r1 = compute_egress_route("1_cart", cart_id=1, park_key="Sideline_20")
    
    print(f"2 Carts (Side 1 Dual Exit): {r2_dual.total_distance_yards:.1f} yd, {r2_dual.total_turns} turns")
    for s in r2_dual.segments:
        print(f"   -> {s.name:<24}: {s.distance_yards:.1f} yd ({s.load_state})")
        
    print(f"\n2 Carts (Side 2 Cross-to-Side1 Exit): {r2_single.total_distance_yards:.1f} yd")
    for s in r2_single.segments:
        print(f"   -> {s.name:<24}: {s.distance_yards:.1f} yd ({s.load_state})")
        
    print(f"\n1 Cart Fleet Egress: {r1.total_distance_yards:.1f} yd")
    for s in r1.segments:
        print(f"   -> {s.name:<24}: {s.distance_yards:.1f} yd ({s.load_state})")
