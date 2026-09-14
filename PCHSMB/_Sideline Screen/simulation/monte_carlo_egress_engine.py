#!/usr/bin/env python3
"""
Monte Carlo Simulation Engine for Post-Performance Egress / Extraction.

Evaluates post-show field clearance within the CBA 15-minute total field budget:
- Total Field Time (Rule 5.01 / 5.06): 15:00 total block (4A/5A).
- The 2:00 (120.0s) egress window is an operational planning benchmark, balanced against
  pre-show deployment (max 3:15) and performance duration (~8:30).
  Shaving time off deployment (e.g. 2:15 vs 3:15) transfers directly to egress (expanding to 3:00).
- Clock Stoppage: The official 15-minute clock stops when the last cart/person crosses the
  field boundary line into the exit chute / stadium tunnel (specifically at Falcon Stadium - USAFA
  for State Championships, featuring the tunnel ramp).
  Reloading and securing equipment in the tunnel occurs OFF THE CLOCK while the next band sets up.
- Fleet Scope: 2 Carts Fleet only (Cart 1 on Side 1, Cart 2 on Side 2; 8 screens each)
- Single Exit Gate per stadium (with dual exit benchmark)
- Reload Modes:
    1. 'outside_gate': Students hand-carry to tunnel gate, cross gate (clock stops); reload in tunnel.
    2. 'inside_gate': Students hand-carry to end zone staging area; reload inside gate; loaded cart rolls through gate (clock stops).
    3. 'on_field_loading': Traditional baseline: carts load screens & ballast on field, then push loaded carts to exit.
    4. 'hybrid_split': Near cart loads on field; Far cart hand-carries & reloads at gate.
- Stadium Layouts:
    - 'same_side': Enter Side 1, Exit Side 1 (Cart 2 has long cross-field push on entrance + long cross-field push on egress).
    - 'opposite_side': Enter Side 1, Exit Side 2 (Cart 2 had long entrance push, but has short egress; Cart 1 has long egress).
    - 'dual_exit': Both end zones open for exit.
- Far-Cart Sweep Directions:
    - 'inward': Screen 8 to Screen 1 (saves 20 yd of cross-field push).
    - 'outward': Screen 1 to Screen 8 (88 yd cross-field push).
- Ballast States ('none', 'tier1', 'tier2')
- Pusher Fitness Profiles ('average', 'lower_fitness', 'higher_fitness')
"""

import math
import numpy as np
from typing import Dict, List, NamedTuple, Optional

from egress_model import (
    compute_cart_egress_route, get_student_carry_distances,
    CartEgressRoute, CART_PARK_LOCATIONS
)
from field_model import SCREENS_PER_SIDE, TOTAL_SCREENS, SCREEN_WIDTH_YARDS
from pusher_physics import (
    CART_TARE_WEIGHT_LBS, SCREEN_UNIT_WEIGHT_LBS, BALLAST_BAG_WEIGHT_LBS,
    sample_pusher_fitness, compute_cart_velocity_yards_per_sec,
    compute_turn_penalty_seconds, compute_acceleration_penalty_seconds
)

CBA_EGRESS_LIMIT_SECONDS = 120.0  # 2 minutes post-show clearance window

class EgressTrialResult(NamedTuple):
    trial_id: int
    field_clearance_time_s: float   # Official CBA clock time (when all clear the exit gate)
    total_operation_time_s: float   # Includes outside reload time if reloaded outside
    success: bool                   # True if field_clearance_time_s <= 120.0s
    slack_seconds: float            # 120.0 - field_clearance_time_s
    t_cart1_gate_s: float
    t_cart2_gate_s: float
    t_students_gate_s: float
    t_reload_s: float
    bottleneck: str

class EgressScenarioSummary(NamedTuple):
    stadium_layout: str
    reload_mode: str
    far_sweep_dir: str
    ballast_mode: str
    pusher_profile: str
    num_trials: int
    success_rate: float
    mean_clearance_time: float
    median_clearance_time: float
    std_clearance_time: float
    p90_clearance_time: float
    p95_clearance_time: float
    p99_clearance_time: float
    min_clearance_time: float
    max_clearance_time: float
    mean_slack: float
    mean_total_operation_time: float
    all_clearance_times: np.ndarray

def simulate_cart_and_crew(
    cart_id: int,
    route: CartEgressRoute,
    reload_mode: str,
    ballast_mode: str,
    pusher_fitness: float,
    pusher_profile: str,
    rng: np.random.Generator
) -> Dict[str, float]:
    """
    Simulates one cart (8 screens) and its 8 student handlers.
    """
    num_screens = SCREENS_PER_SIDE # 8
    
    if ballast_mode == "tier1":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 1.0  # 15 lbs
    elif ballast_mode == "tier2":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 2.0  # 30 lbs
    else:
        ballast_per_screen = 0.0
        
    # Student hand-carry distances to gate
    student_dists = get_student_carry_distances(cart_id, route.stadium_layout)
    student_gate_times = []
    student_fold_times = []
    
    # -------------------------------------------------------------
    # Step 1: Student Folding & Hand-Carry Transit
    # -------------------------------------------------------------
    for i in range(num_screens):
        t_fold = rng.triangular(4.5, 6.0, 8.5)
        # If student unclips ballast bag from screen:
        if ballast_mode != "none":
            t_fold += rng.triangular(1.5, 2.2, 3.5)
        # 5% latch hitch
        if rng.random() < 0.05:
            t_fold += rng.uniform(2.0, 4.0)
        student_fold_times.append(t_fold)
        
        # Student jogging/walking with 26-lb screen to gate
        # Speed: 1.6 to 2.8 yd/s (approx 3.3 to 5.7 mph)
        v_student = rng.triangular(1.6, 2.2, 2.8)
        t_transit = student_dists[i] / v_student
        student_gate_times.append(t_fold + t_transit)
        
    t_last_student_at_gate = max(student_gate_times)
    
    # -------------------------------------------------------------
    # Step 2: Cart Movement
    # -------------------------------------------------------------
    current_weight = CART_TARE_WEIGHT_LBS
    current_time = 0.0
    # Pushers rest on sideline during the 7-8 min show; 80% recovery of muscular energy
    SHOW_RECOVERY_FACTOR = 0.80
    dist_accum = route.prior_entrance_dist_yd * (1.0 - SHOW_RECOVERY_FACTOR)
    
    # Cart Approach to first screen
    approach_seg = route.segments[0]
    current_time += compute_acceleration_penalty_seconds(current_weight, rng)
    for _ in range(approach_seg.turns_90deg):
        current_time += compute_turn_penalty_seconds(current_weight, rng)
    v_app = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
    current_time += approach_seg.distance_yards / v_app
    dist_accum += approach_seg.distance_yards
    
    # Cart Collection along Front Sideline
    inter_screen_dist = SCREEN_WIDTH_YARDS
    
    is_on_field_loading = (reload_mode == "on_field_loading") or (reload_mode == "hybrid_split" and route.is_near_cart)
    
    for i in range(num_screens):
        if is_on_field_loading:
            # Cart stops at screen, waits for student to finish folding, loads screen + ballast
            current_time = max(current_time, student_fold_times[i])
            t_l = rng.triangular(2.2, 3.2, 4.6) # load folded frame
            if ballast_mode != "none":
                t_l += rng.triangular(1.8, 2.6, 3.8) # load sandbag
            if rng.random() < 0.05:
                t_l += rng.uniform(2.0, 4.0)
            current_time += t_l
            current_weight += (SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen)
        else:
            # Hand-carry mode: cart only loads ballast sandbag!
            if ballast_mode != "none":
                t_l = rng.triangular(1.8, 2.5, 3.5)
                current_time += t_l
                current_weight += ballast_per_screen
            else:
                current_time += 0.4 # rolls straight past
                
        # Inter-screen transit
        if i < num_screens - 1:
            v_move = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
            current_time += inter_screen_dist / v_move
            dist_accum += inter_screen_dist
            
    # Cart Sprint / Cross-Field Transit to Exit Threshold
    exit_seg = route.segments[-1]
    current_time += compute_acceleration_penalty_seconds(current_weight, rng)
    for _ in range(exit_seg.turns_90deg):
        current_time += compute_turn_penalty_seconds(current_weight, rng)
    v_exit = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
    
    # If reloading inside the gate, staging area is 10 yards before gate
    if reload_mode == "inside_gate" and not is_on_field_loading:
        d_to_staging = max(5.0, exit_seg.distance_yards - 10.0)
        current_time += d_to_staging / v_exit
        dist_accum += d_to_staging
        t_cart_at_staging = current_time
        
        # Staging reload: wait for all 8 screens to arrive at staging area
        # Staging is 10 yd before gate, so students arrive ~4s earlier than gate
        t_students_at_staging = max(0.0, t_last_student_at_gate - (10.0 / 2.2))
        t_reload_start = max(t_cart_at_staging, t_students_at_staging)
        
        # 8 students load 8 folded screens onto cart
        t_reload = rng.triangular(10.0, 14.0, 20.0)
        if rng.random() < 0.05:
            t_reload += rng.uniform(3.0, 6.0) # minor slot alignment
        current_time = t_reload_start + t_reload
        current_weight += (SCREEN_UNIT_WEIGHT_LBS * num_screens)
        
        # Roll final 10 yards through exit gate
        current_time += compute_acceleration_penalty_seconds(current_weight, rng)
        v_final = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
        current_time += 10.0 / v_final
        dist_accum += 10.0
        
        t_cart_cleared_gate = current_time
        t_operation_total = current_time
        
    elif reload_mode == "outside_gate" and not is_on_field_loading:
        # Cart pushes all the way through the gate carrying only ballast
        current_time += exit_seg.distance_yards / v_exit
        dist_accum += exit_seg.distance_yards
        t_cart_cleared_gate = current_time
        
        # Reload happens OUTSIDE the gate (off the CBA clock)
        t_reload_start = max(t_cart_cleared_gate, t_last_student_at_gate)
        t_reload = rng.triangular(10.0, 14.0, 20.0)
        if rng.random() < 0.05:
            t_reload += rng.uniform(3.0, 6.0)
        t_operation_total = t_reload_start + t_reload
        
    else:
        # on_field_loading: Cart is already fully loaded, rolls through gate
        current_time += exit_seg.distance_yards / v_exit
        dist_accum += exit_seg.distance_yards
        t_cart_cleared_gate = current_time
        t_reload = 0.0
        t_operation_total = current_time
        
    return {
        "t_cart_gate": t_cart_cleared_gate,
        "t_students_gate": t_last_student_at_gate,
        "t_operation_total": t_operation_total,
        "t_reload": t_reload if not is_on_field_loading else 0.0,
        "final_weight": current_weight
    }

def simulate_two_student_carry_egress(
    stadium_layout: str,
    ballast_mode: str,
    rng: np.random.Generator
) -> Dict[str, float]:
    """
    Simulates the Two-Student Carry post-show egress / field clearance:
    - On show cutoff chord, the same 16 student pairs (32 students) grab their assigned duck blind.
    - No folding on field, no cart loading on field.
    - Student pairs lift the assembled screen and 'hoof it on out' to the designated stadium exit gate.
    - Clock stops when the LAST student pair clears the exit gate threshold into the chute/tunnel.
    - Off-field (outside gate), screens are restacked onto transport carts/trailers.
    """
    if ballast_mode == "tier1":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 1.0  # 15.0 lbs
    elif ballast_mode == "tier2":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 2.0  # 30.0 lbs
    else:
        ballast_per_screen = 0.0
        
    gross_screen_wt = SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen
    wt_per_student = gross_screen_wt / 2.0
    
    # Jogging speed load factor
    load_factor = 1.0 / (1.0 + 0.006 * wt_per_student)
    
    # Wind resistance factor while jogging with screen
    wind_factor = rng.triangular(0.92, 0.96, 1.00)
    
    # All 16 screen distances to the stadium exit gate
    dists_side1 = get_student_carry_distances(1, stadium_layout)  # Screens 1-8
    dists_side2 = get_student_carry_distances(2, stadium_layout)  # Screens 9-16
    all_dists = dists_side1 + dists_side2
    
    gate_times = []
    for d in all_dists:
        # Reaction time from cutoff chord to grabbing screen
        t_react = rng.triangular(1.5, 2.5, 4.0)
        # Lift screen together
        t_lift = rng.triangular(1.8, 2.8, 4.2)
        if ballast_mode != "none":
            t_lift += rng.triangular(0.8, 1.5, 2.5)  # slightly heavier lift
            
        # Brisk walking / jogging pace carrying 2-person load: ~1.8 to 2.9 yd/s (approx 3.7 - 5.9 mph)
        v_base = rng.triangular(1.8, 2.3, 2.9)
        pair_load = load_factor * rng.uniform(0.96, 1.04)
        v_jog = max(1.1, v_base * pair_load * wind_factor)
        
        # 5% chance of minor gate congestion or turf stumble
        t_congestion = rng.uniform(1.5, 3.5) if rng.random() < 0.05 else 0.0
        
        t_transit = (d / v_jog) + t_congestion
        total_time = t_react + t_lift + t_transit
        gate_times.append(total_time)
        
    t_clearance = max(gate_times)
    
    # Off-field reload time (outside the gate on track/apron into carts/trucks, off the CBA clock)
    t_outside_reload = rng.triangular(15.0, 22.0, 32.0)
    t_operation_total = t_clearance + t_outside_reload
    
    return {
        "t_clearance": t_clearance,
        "t_operation_total": t_operation_total,
        "t_outside_reload": t_outside_reload,
        "t_last_student_gate": t_clearance,
        "bottleneck": "student_carry_exit"
    }

def run_egress_monte_carlo(
    stadium_layout: str = "same_side",
    reload_mode: str = "outside_gate",
    far_sweep_dir: str = "inward",
    ballast_mode: str = "tier1",
    pusher_profile: str = "average",
    num_trials: int = 5000,
    seed: Optional[int] = 42
) -> EgressScenarioSummary:
    """
    Runs N stochastic Monte Carlo trials for post-show egress.
    """
    rng = np.random.default_rng(seed)
    
    clearance_times = np.empty(num_trials, dtype=float)
    operation_times = np.empty(num_trials, dtype=float)
    slacks = np.empty(num_trials, dtype=float)
    successes = 0
    
    if reload_mode == "two_student_carry":
        for i in range(num_trials):
            res = simulate_two_student_carry_egress(stadium_layout, ballast_mode, rng)
            t_clearance = res["t_clearance"]
            t_op = res["t_operation_total"]
            
            clearance_times[i] = t_clearance
            operation_times[i] = t_op
            slacks[i] = CBA_EGRESS_LIMIT_SECONDS - t_clearance
            
            if t_clearance <= CBA_EGRESS_LIMIT_SECONDS:
                successes += 1
    else:
        route1 = compute_cart_egress_route(1, stadium_layout=stadium_layout, far_sweep_dir=far_sweep_dir)
        route2 = compute_cart_egress_route(2, stadium_layout=stadium_layout, far_sweep_dir=far_sweep_dir)
        
        for i in range(num_trials):
            f1 = sample_pusher_fitness(pusher_profile, rng)
            f2 = sample_pusher_fitness(pusher_profile, rng)
            
            res1 = simulate_cart_and_crew(1, route1, reload_mode, ballast_mode, f1, pusher_profile, rng)
            res2 = simulate_cart_and_crew(2, route2, reload_mode, ballast_mode, f2, pusher_profile, rng)
            
            # Field clearance time: when BOTH carts and ALL students have crossed the gate boundary
            t_clearance = max(
                res1["t_cart_gate"],
                res2["t_cart_gate"],
                res1["t_students_gate"],
                res2["t_students_gate"]
            )
            
            t_op = max(res1["t_operation_total"], res2["t_operation_total"])
            
            clearance_times[i] = t_clearance
            operation_times[i] = t_op
            slacks[i] = CBA_EGRESS_LIMIT_SECONDS - t_clearance
            
            if t_clearance <= CBA_EGRESS_LIMIT_SECONDS:
                successes += 1
            
    return EgressScenarioSummary(
        stadium_layout=stadium_layout,
        reload_mode=reload_mode,
        far_sweep_dir=far_sweep_dir,
        ballast_mode=ballast_mode,
        pusher_profile=pusher_profile,
        num_trials=num_trials,
        success_rate=successes / num_trials,
        mean_clearance_time=float(np.mean(clearance_times)),
        median_clearance_time=float(np.median(clearance_times)),
        std_clearance_time=float(np.std(clearance_times)),
        p90_clearance_time=float(np.percentile(clearance_times, 90)),
        p95_clearance_time=float(np.percentile(clearance_times, 95)),
        p99_clearance_time=float(np.percentile(clearance_times, 99)),
        min_clearance_time=float(np.min(clearance_times)),
        max_clearance_time=float(np.max(clearance_times)),
        mean_slack=float(np.mean(slacks)),
        mean_total_operation_time=float(np.mean(operation_times)),
        all_clearance_times=clearance_times
    )

if __name__ == "__main__":
    print("=== TESTING UPDATED EGRESS MONTE CARLO ENGINE ===")
    test_cases = [
        ("same_side", "two_student_carry", "inward", "tier1"),
        ("dual_exit", "two_student_carry", "inward", "tier1"),
        ("same_side", "outside_gate", "inward", "tier1"),
        ("same_side", "inside_gate", "inward", "tier1"),
        ("same_side", "on_field_loading", "inward", "tier1"),
        ("same_side", "hybrid_split", "inward", "tier1"),
        ("opposite_side", "outside_gate", "inward", "tier1"),
        ("opposite_side", "inside_gate", "inward", "tier1"),
        ("dual_exit", "outside_gate", "inward", "tier1"),
    ]
    
    print(f"{'Layout':<14} {'Reload Mode':<18} {'Sweep':<8} {'Mean Time':<12} {'P95 Time':<12} {'Success (<=2:00)':<18}")
    print("-" * 88)
    for lay, rel, swp, bal in test_cases:
        res = run_egress_monte_carlo(lay, rel, swp, bal, num_trials=1000)
        print(f"{lay:<14} {rel:<18} {swp:<8} {res.mean_clearance_time:<12.1f} {res.p95_clearance_time:<12.1f} {res.success_rate * 100:<17.1f}%")
