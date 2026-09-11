#!/usr/bin/env python3
"""
Egress Geometry and Rule Compliance Model for Sideline Screen Post-Show Extraction.

Complies with Colorado Bandmasters Association (CBA) 2026 Rules:
- Rule 5.05: Props exit towards the front half of the end zone (middle of goal post to front sideline).
  Props may cross front boundary once past the 30-yard line closest to the exit.
- Rule 5.03: Exiting band has exclusive right-of-way through the front half of the end zone.
- Rule 8.05: Continuous movement required; props cannot stop or de-ballast at exit chute.
- Target Clock: 2 minutes (120.0 seconds) post-show clearance interval.

Updated Assumptions:
1. 2-Cart Fleet only (1 cart per side, 8 screens per cart).
2. Single exit point per stadium (or dual exit benchmark).
3. Stadium layout variations:
   - 'same_side': Entrance at Side 1, Exit at Side 1 (Same gate used for enter & leave).
   - 'opposite_side': Entrance at Side 1, Exit at Side 2 (Two openings: enter one side, exit the other).
   - 'dual_exit': Benchmark stadium with independent exit gates at both end zones.
4. Far-cart collection direction:
   - 'inward': Screen 8 to Screen 1 (finishes at 42-yd line, saving 20 yards of cross-field push).
   - 'outward': Screen 1 to Screen 8 (finishes at 22-yd line, 88-yard cross-field push).
"""

import math
from typing import Dict, List, NamedTuple, Tuple
from field_model import (
    Point, get_screen_coordinates, SCREENS_PER_SIDE, TOTAL_SCREENS,
    SCREEN_WIDTH_YARDS, GOAL_POST_Y, FRONT_SIDELINE_Y
)

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

class CartEgressRoute(NamedTuple):
    cart_id: int
    is_near_cart: bool
    stadium_layout: str      # 'same_side', 'opposite_side', 'dual_exit'
    far_sweep_dir: str       # 'inward' or 'outward'
    prior_entrance_dist_yd: float
    segments: List[EgressSegment]
    total_distance_yards: float
    total_turns: int
    screen_order: List[int]
    passes_30yd_rule: bool

def get_entrance_distance_pushed(cart_id: int, stadium_layout: str) -> float:
    """
    Returns the distance pushed by this cart during pre-show deployment.
    This informs the cumulative fatigue model.
    Assuming deployment entered from Side 1:
    - Cart 1 deployed Side 1: ~35 yards
    - Cart 2 deployed Side 2: ~100 yards (crossed field loaded)
    """
    if cart_id == 1:
        return 35.0
    else:
        return 100.0

def compute_cart_egress_route(
    cart_id: int,
    stadium_layout: str = "same_side",
    far_sweep_dir: str = "inward",
    park_key: str = "Sideline_20"
) -> CartEgressRoute:
    """
    Computes post-show egress route for Cart 1 (Side 1) or Cart 2 (Side 2).
    
    Layout mapping:
    - 'same_side': Exit is at Side 1 End Zone.
      Cart 1 is Near Cart. Cart 2 is Far Cart (crosses field to Side 1).
    - 'opposite_side': Exit is at Side 2 End Zone (entered Side 1, exits Side 2).
      Cart 2 is Near Cart. Cart 1 is Far Cart (crosses field to Side 2).
    - 'dual_exit': Both end zones have exits. Both carts are Near Carts.
    """
    screens = get_screen_coordinates()
    segments = []
    
    # Determine Near vs Far Cart
    if stadium_layout == "dual_exit":
        is_near = True
    elif stadium_layout == "same_side":
        is_near = (cart_id == 1)
    else: # 'opposite_side' (exit is at Side 2)
        is_near = (cart_id == 2)
        
    prior_entrance_dist = get_entrance_distance_pushed(cart_id, stadium_layout)
    park_pt = CART_PARK_LOCATIONS[park_key]["side1" if cart_id == 1 else "side2"]
    
    # Screen order for collection
    base_screens = list(range(1, 9)) if cart_id == 1 else list(range(9, 17))
    
    if is_near:
        # Near Cart always sweeps from Inner (42-yd line) to Outer (22-yd line)
        # so it is already rolling toward its own exit end zone!
        screen_order = base_screens  # Screen 1 -> 8 (or 9 -> 16)
    else:
        # Far Cart has option:
        if far_sweep_dir == "inward":
            # Start at outer 22-yd line, sweep inward toward centerfield/50!
            # Finishes at 42-yd line, leaving only 68 yards to the exit end line!
            screen_order = list(reversed(base_screens))
        else:
            # Sweep outward to 22-yd line, leaving 88 yards to exit
            screen_order = base_screens
            
    s_first = screens[screen_order[0]]
    s_last = screens[screen_order[-1]]
    
    # Segment 1: Approach from park spot to first screen
    d_approach_x = abs(park_pt.x - s_first.center_x)
    d_approach_y = abs(park_pt.y - FRONT_SIDELINE_Y)
    d_approach = math.hypot(d_approach_x, d_approach_y)
    segments.append(EgressSegment("approach_first_screen", d_approach, 1, "empty"))
    
    # Segment 2: Collection line along front sideline (7 inter-screen intervals)
    d_collect = (SCREENS_PER_SIDE - 1) * SCREEN_WIDTH_YARDS  # 18.67 yd
    segments.append(EgressSegment("collection_line", d_collect, 0, "loading"))
    
    # Segment 3: Sprint from last screen to exit threshold
    if is_near:
        # Near cart sprints straight out its own end zone
        # Distance from Screen 8 (X = +/- 28.0) to End line (+/- 60.0) = 32.0 yd
        d_exit = 32.0
        segments.append(EgressSegment("sprint_to_near_exit", d_exit, 0, "loaded"))
    else:
        # Far cart must cross the field to the opposite end line
        # Target end line is -60.0 if exit is Side 1, or +60.0 if exit is Side 2
        target_end_line = END_LINE_X_SIDE1 if (stadium_layout == "same_side") else END_LINE_X_SIDE2
        d_exit = abs(target_end_line - s_last.center_x)
        # If inward sweep: 60 + 8.0 = 68.0 yards!
        # If outward sweep: 60 + 28.0 = 88.0 yards!
        segments.append(EgressSegment(f"cross_field_to_exit_{far_sweep_dir}", d_exit, 0, "loaded"))
        
    total_dist = sum(s.distance_yards for s in segments)
    total_turns = sum(s.turns_90deg for s in segments)
    
    return CartEgressRoute(
        cart_id=cart_id,
        is_near_cart=is_near,
        stadium_layout=stadium_layout,
        far_sweep_dir=far_sweep_dir,
        prior_entrance_dist_yd=prior_entrance_dist,
        segments=segments,
        total_distance_yards=total_dist,
        total_turns=total_turns,
        screen_order=screen_order,
        passes_30yd_rule=True
    )

def get_student_carry_distances(cart_id: int, stadium_layout: str) -> List[float]:
    """
    Returns the distance (in yards) each of the 8 students on this side must walk/jog
    to reach the designated exit gate.
    
    Near Side:
    - Screen 8 (22-yd line) is 32.0 yd from end line.
    - Screen 1 (42-yd line) is 50.7 yd from end line.
    
    Far Side:
    - Screen 1 (42-yd line) is 69.3 yd from opposite end line.
    - Screen 8 (22-yd line) is 88.0 yd from opposite end line.
    """
    if stadium_layout == "dual_exit":
        is_near = True
    elif stadium_layout == "same_side":
        is_near = (cart_id == 1)
    else:
        is_near = (cart_id == 2)
        
    distances = []
    for i in range(1, SCREENS_PER_SIDE + 1):
        # i = 1 is 42yd line, i = 8 is 22yd line
        dist_from_50 = 8.0 + (i - 0.5) * SCREEN_WIDTH_YARDS
        if is_near:
            # End line is at 60 yd from 50
            d = 60.0 - dist_from_50
        else:
            # Opposite end line is at 60 yd + dist_from_50
            d = 60.0 + dist_from_50
        distances.append(d)
        
    return distances

if __name__ == "__main__":
    print("=== UPDATED EGRESS ROUTE GEOMETRY VERIFICATION ===")
    for layout in ["same_side", "opposite_side", "dual_exit"]:
        print(f"\n--- Layout: {layout.upper()} ---")
        for cid in [1, 2]:
            r_in = compute_cart_egress_route(cid, stadium_layout=layout, far_sweep_dir="inward")
            r_out = compute_cart_egress_route(cid, stadium_layout=layout, far_sweep_dir="outward")
            carry_dists = get_student_carry_distances(cid, layout)
            print(f"Cart {cid} (Near={r_in.is_near_cart}): Total Dist (Inward Sweep) = {r_in.total_distance_yards:.1f} yd, Exit Sprint = {r_in.segments[-1].distance_yards:.1f} yd")
            if not r_in.is_near_cart:
                print(f"   -> Outward Sweep Dist = {r_out.total_distance_yards:.1f} yd (Exit Sprint = {r_out.segments[-1].distance_yards:.1f} yd)")
            print(f"   -> Student Hand-Carry Distances: Min = {min(carry_dists):.1f} yd, Max = {max(carry_dists):.1f} yd")
