#!/usr/bin/env python3
"""
Monte Carlo Simulation Engine for Post-Performance Egress / Extraction.

Evaluates post-show field clearance under the strict CBA 2:00 (120.0s) rule:
- 1 Cart vs 2 Carts
- Exit Gate Geometry: 'dual' (each cart exits own end zone) vs 'side1_only' (all exit Side 1)
- 3 Teardown Strategies:
    1. 'parallel_pre_fold': 8 on-field students per side fold screens concurrently; cart team loads.
    2. 'crew_only_fold': Only the 2 cart students unclip, fold, and load screens sequentially.
    3. 'direct_hand_carry': On-field students hand-carry folded screens off; cart carries ballast.
- Pusher Fitness Tiers ('average', 'lower_fitness', 'higher_fitness')
- Ballast States ('tier1', 'tier2', 'none')
"""

import math
import numpy as np
from typing import Dict, List, NamedTuple, Optional

from egress_model import compute_egress_route, EgressRoute, CART_PARK_LOCATIONS
from field_model import SCREENS_PER_SIDE, TOTAL_SCREENS, SCREEN_WIDTH_YARDS
from pusher_physics import (
    CART_TARE_WEIGHT_LBS, SCREEN_UNIT_WEIGHT_LBS, BALLAST_BAG_WEIGHT_LBS,
    sample_pusher_fitness, compute_cart_velocity_yards_per_sec,
    compute_turn_penalty_seconds, compute_acceleration_penalty_seconds
)

CBA_EGRESS_LIMIT_SECONDS = 120.0  # 2 minutes post-show clearance window

class EgressTrialResult(NamedTuple):
    trial_id: int
    total_time_seconds: float
    success: bool
    slack_seconds: float
    t_approach_s: float
    t_load_line_s: float
    t_sprint_exit_s: float
    t_screens_folded_s: float
    gross_final_weight_lbs: float
    bottleneck: str

class EgressScenarioSummary(NamedTuple):
    config: str
    exit_gate_mode: str
    strategy: str
    ballast_mode: str
    pusher_profile: str
    park_location: str
    num_trials: int
    success_rate: float
    mean_time: float
    median_time: float
    std_time: float
    p90_time: float
    p95_time: float
    p99_time: float
    min_time: float
    max_time: float
    mean_slack: float
    all_times: np.ndarray

def simulate_single_cart_egress(
    route: EgressRoute,
    strategy: str,
    ballast_mode: str,
    pusher_fitness: float,
    pusher_profile: str,
    rng: np.random.Generator
) -> Dict[str, float]:
    """
    Simulates egress for one cart handling 8 screens on one side.
    """
    num_screens = len(route.screen_order)
    
    if ballast_mode == "tier1":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 1.0  # 15 lbs
    elif ballast_mode == "tier2":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 2.0  # 30 lbs
    else:
        ballast_per_screen = 0.0
        
    # Cart starts EMPTY at parked location
    current_weight = CART_TARE_WEIGHT_LBS
    current_time = 0.0
    dist_accum = 0.0
    
    # -------------------------------------------------------------
    # Step 1: Pre-Fold / Disassembly Phase
    # -------------------------------------------------------------
    screen_fold_timestamps = []
    
    if strategy == "parallel_pre_fold":
        # All 8 on-field students unclip and fold simultaneously upon show end!
        for i in range(num_screens):
            t_uf = rng.triangular(4.5, 6.0, 8.5)
            if ballast_mode != "none":
                t_uf += rng.triangular(1.5, 2.5, 3.8)
            # Clip latch release hitch
            if rng.random() < 0.05:
                t_uf += rng.uniform(2.0, 4.0)
            screen_fold_timestamps.append(t_uf)
        t_all_folded = max(screen_fold_timestamps)
        
    elif strategy == "direct_hand_carry":
        # Students fold and carry screens directly to end zone
        for i in range(num_screens):
            t_uf = rng.triangular(4.5, 6.0, 8.5)
            # Carry 32-53 yards to end line at ~2.8 yd/s
            dist_to_ez = 32.0 + (num_screens - 1 - i) * SCREEN_WIDTH_YARDS
            t_carry = dist_to_ez / rng.triangular(2.4, 2.8, 3.3)
            screen_fold_timestamps.append(t_uf + t_carry)
        t_all_folded = max(screen_fold_timestamps)
        
    else: # crew_only_fold (sequential)
        t_all_folded = 0.0 # Handled on the fly at each screen
        
    # -------------------------------------------------------------
    # Step 2: Approach from Park Location to Screen 1
    # -------------------------------------------------------------
    approach_seg = route.segments[0]
    current_time += compute_acceleration_penalty_seconds(current_weight, rng)
    for _ in range(approach_seg.turns_90deg):
        current_time += compute_turn_penalty_seconds(current_weight, rng)
        
    v_app = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
    t_app = approach_seg.distance_yards / v_app
    current_time += t_app
    dist_accum += approach_seg.distance_yards
    t_approach_end = current_time
    
    # -------------------------------------------------------------
    # Step 3: Collection along Front Sideline (Screen 1 to Screen 8)
    # -------------------------------------------------------------
    inter_screen_dist = SCREEN_WIDTH_YARDS # 2.667 yd
    t_load_start = current_time
    
    for i in range(num_screens):
        if strategy == "parallel_pre_fold":
            # Cart arrives at pre-folded screen; just lift and slide onto cart
            # If cart arrives before student finished folding, wait for it
            current_time = max(current_time, screen_fold_timestamps[i])
            t_l = rng.triangular(2.2, 3.2, 4.6)
            if ballast_mode != "none":
                t_l += rng.triangular(1.8, 2.6, 3.8) # Load sandbag into bin
            if rng.random() < 0.05:
                t_l += rng.uniform(2.0, 4.0)
            current_time += t_l
            
        elif strategy == "direct_hand_carry":
            # Screen is carried by student; cart only loads ballast sandbag!
            if ballast_mode != "none":
                t_l = rng.triangular(1.8, 2.5, 3.5)
                current_time += t_l
            else:
                current_time += 0.5 # Cart rolls past without stopping
                
        else: # crew_only_fold (sequential disassemble + load)
            t_dl = rng.triangular(8.5, 11.5, 15.0)
            if ballast_mode != "none":
                t_dl += rng.triangular(2.5, 3.8, 5.0)
            if rng.random() < 0.08:
                t_dl += rng.uniform(2.5, 5.0)
            current_time += t_dl
            
        # Accumulate weight onto cart
        if strategy == "direct_hand_carry":
            current_weight += ballast_per_screen
        else:
            current_weight += (SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen)
            
        # Move to next screen
        if i < num_screens - 1:
            v_move = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
            current_time += inter_screen_dist / v_move
            dist_accum += inter_screen_dist
            
    t_load_total = current_time - t_load_start
    final_gross_weight = current_weight
    
    # -------------------------------------------------------------
    # Step 4: Sprint Exit through Front Half of End Zone
    # -------------------------------------------------------------
    # At Screen 8, the cart is at X = -28.0 yd (already past the 30-yd line!)
    # Sprint straight through the front half of the end zone to End Line (X = -60.0 yd) = 32 yards
    exit_seg = route.segments[-1]
    t_sprint_start = current_time
    
    current_time += compute_acceleration_penalty_seconds(final_gross_weight, rng)
    for _ in range(exit_seg.turns_90deg):
        current_time += compute_turn_penalty_seconds(final_gross_weight, rng)
        
    v_sprint = compute_cart_velocity_yards_per_sec(final_gross_weight, pusher_fitness, dist_accum, pusher_profile, rng)
    current_time += exit_seg.distance_yards / v_sprint
    dist_accum += exit_seg.distance_yards
    t_sprint_total = current_time - t_sprint_start
    
    # Students running off field
    if strategy == "direct_hand_carry":
        total_time = max(current_time, t_all_folded)
    else:
        # Student helpers running off field alongside/behind cart
        t_students_clear = current_time + rng.triangular(2.0, 4.0, 7.0)
        total_time = max(current_time, t_students_clear)
        
    bottleneck = "cart_loading" if t_load_total > t_sprint_total else "sprint_exit"
    
    return {
        "total_time": total_time,
        "t_approach": t_approach_end,
        "t_load": t_load_total,
        "t_sprint": t_sprint_total,
        "t_screens_folded": t_all_folded,
        "final_weight": final_gross_weight,
        "bottleneck": bottleneck
    }

def simulate_single_cart_fleet_egress(
    route: EgressRoute,
    strategy: str,
    ballast_mode: str,
    pusher_fitness: float,
    pusher_profile: str,
    rng: np.random.Generator
) -> Dict[str, float]:
    """
    Simulates a single cart attempting to extract all 16 screens across both sides!
    """
    total_screens = TOTAL_SCREENS # 16
    
    if ballast_mode == "tier1":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 1.0
    elif ballast_mode == "tier2":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 2.0
    else:
        ballast_per_screen = 0.0
        
    current_weight = CART_TARE_WEIGHT_LBS
    current_time = 0.0
    dist_accum = 0.0
    
    # Step 1: Pre-fold on both sides
    s1_fold_times = []
    s2_fold_times = []
    
    if strategy == "parallel_pre_fold":
        for _ in range(SCREENS_PER_SIDE):
            t_uf = rng.triangular(4.5, 6.0, 8.5)
            if ballast_mode != "none":
                t_uf += rng.triangular(1.5, 2.5, 3.8)
            s2_fold_times.append(t_uf)
            s1_fold_times.append(t_uf)
    else:
        s2_fold_times = [0.0] * SCREENS_PER_SIDE
        s1_fold_times = [0.0] * SCREENS_PER_SIDE
        
    # Step 2: Approach Side 2 Screen 16 (parked near 20-yd line)
    app_seg = route.segments[0]
    current_time += compute_acceleration_penalty_seconds(current_weight, rng)
    v_app = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
    current_time += app_seg.distance_yards / v_app
    dist_accum += app_seg.distance_yards
    t_approach = current_time
    
    # Step 3: Collect Side 2 screens (16 inward to 9)
    inter_screen_dist = SCREEN_WIDTH_YARDS
    for i in range(SCREENS_PER_SIDE):
        if strategy == "parallel_pre_fold":
            current_time = max(current_time, s2_fold_times[i])
            t_l = rng.triangular(2.2, 3.2, 4.6)
            if ballast_mode != "none":
                t_l += rng.triangular(1.8, 2.6, 3.8)
            current_time += t_l
        else:
            t_dl = rng.triangular(8.5, 11.5, 15.0)
            if ballast_mode != "none":
                t_dl += rng.triangular(2.5, 3.8, 5.0)
            current_time += t_dl
            
        current_weight += (SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen)
        if i < SCREENS_PER_SIDE - 1:
            v_move = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
            current_time += inter_screen_dist / v_move
            dist_accum += inter_screen_dist
            
    # Step 4: Cross Front Ensemble (Pit) to Side 1 (16 yd)
    pit_seg = route.segments[2]
    v_pit = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
    current_time += pit_seg.distance_yards / v_pit
    dist_accum += pit_seg.distance_yards
    
    # Step 5: Collect Side 1 screens (1 outward to 8)
    for i in range(SCREENS_PER_SIDE):
        if strategy == "parallel_pre_fold":
            current_time = max(current_time, s1_fold_times[i])
            t_l = rng.triangular(2.2, 3.2, 4.6)
            if ballast_mode != "none":
                t_l += rng.triangular(1.8, 2.6, 3.8)
            current_time += t_l
        else:
            t_dl = rng.triangular(8.5, 11.5, 15.0)
            if ballast_mode != "none":
                t_dl += rng.triangular(2.5, 3.8, 5.0)
            current_time += t_dl
            
        current_weight += (SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen)
        if i < SCREENS_PER_SIDE - 1:
            v_move = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
            current_time += inter_screen_dist / v_move
            dist_accum += inter_screen_dist
            
    # Step 6: Sprint to Side 1 Exit (32 yd)
    exit_seg = route.segments[-1]
    current_time += compute_acceleration_penalty_seconds(current_weight, rng)
    v_exit = compute_cart_velocity_yards_per_sec(current_weight, pusher_fitness, dist_accum, pusher_profile, rng)
    current_time += exit_seg.distance_yards / v_exit
    dist_accum += exit_seg.distance_yards
    
    return {
        "total_time": current_time,
        "t_approach": t_approach,
        "t_load": current_time - t_approach - (32.0 / v_exit),
        "t_sprint": 32.0 / v_exit,
        "t_screens_folded": max(s1_fold_times),
        "final_weight": current_weight,
        "bottleneck": "full_field_sweep"
    }

def run_egress_monte_carlo(
    config: str = "2_carts",
    exit_gate_mode: str = "dual",
    strategy: str = "parallel_pre_fold",
    ballast_mode: str = "tier1",
    pusher_profile: str = "average",
    park_location: str = "Sideline_20",
    num_trials: int = 5000,
    seed: Optional[int] = 42
) -> EgressScenarioSummary:
    """
    Executes N Monte Carlo trials for post-performance egress.
    """
    rng = np.random.default_rng(seed)
    times = np.empty(num_trials, dtype=float)
    slacks = np.empty(num_trials, dtype=float)
    successes = 0
    
    if config == "2_carts":
        route1 = compute_egress_route("2_carts", cart_id=1, park_key=park_location, exit_gate_mode=exit_gate_mode)
        route2 = compute_egress_route("2_carts", cart_id=2, park_key=park_location, exit_gate_mode=exit_gate_mode)
        
        for i in range(num_trials):
            f1 = sample_pusher_fitness(pusher_profile, rng)
            f2 = sample_pusher_fitness(pusher_profile, rng)
            
            res1 = simulate_single_cart_egress(route1, strategy, ballast_mode, f1, pusher_profile, rng)
            res2 = simulate_single_cart_egress(route2, strategy, ballast_mode, f2, pusher_profile, rng)
            
            # Egress completes when BOTH carts have cleared the field
            t_fleet = max(res1["total_time"], res2["total_time"])
            times[i] = t_fleet
            slacks[i] = CBA_EGRESS_LIMIT_SECONDS - t_fleet
            if t_fleet <= CBA_EGRESS_LIMIT_SECONDS:
                successes += 1
                
    else: # 1_cart
        route = compute_egress_route("1_cart", cart_id=1, park_key=park_location, exit_gate_mode=exit_gate_mode)
        for i in range(num_trials):
            f = sample_pusher_fitness(pusher_profile, rng)
            res = simulate_single_cart_fleet_egress(route, strategy, ballast_mode, f, pusher_profile, rng)
            t_fleet = res["total_time"]
            times[i] = t_fleet
            slacks[i] = CBA_EGRESS_LIMIT_SECONDS - t_fleet
            if t_fleet <= CBA_EGRESS_LIMIT_SECONDS:
                successes += 1
                
    return EgressScenarioSummary(
        config=config,
        exit_gate_mode=exit_gate_mode,
        strategy=strategy,
        ballast_mode=ballast_mode,
        pusher_profile=pusher_profile,
        park_location=park_location,
        num_trials=num_trials,
        success_rate=successes / num_trials,
        mean_time=float(np.mean(times)),
        median_time=float(np.median(times)),
        std_time=float(np.std(times)),
        p90_time=float(np.percentile(times, 90)),
        p95_time=float(np.percentile(times, 95)),
        p99_time=float(np.percentile(times, 99)),
        min_time=float(np.min(times)),
        max_time=float(np.max(times)),
        mean_slack=float(np.mean(slacks)),
        all_times=times
    )

if __name__ == "__main__":
    print("=== EGRESS MONTE CARLO ENGINE TEST (1,000 trials each) ===")
    
    test_cases = [
        ("2_carts", "dual", "parallel_pre_fold", "tier1", "average"),
        ("2_carts", "dual", "crew_only_fold", "tier1", "average"),
        ("2_carts", "dual", "direct_hand_carry", "tier1", "average"),
        ("2_carts", "side1_only", "parallel_pre_fold", "tier1", "average"),
        ("1_cart", "dual", "parallel_pre_fold", "tier1", "average"),
        ("1_cart", "dual", "parallel_pre_fold", "none", "average"),
    ]
    
    print(f"{'Config':<8} {'Exit Gates':<12} {'Strategy':<18} {'Mean (s)':<10} {'Median (s)':<12} {'P95 (s)':<10} {'Success (<=2:00)':<16}")
    print("-" * 92)
    for cfg, egm, strat, bal, push in test_cases:
        res = run_egress_monte_carlo(cfg, egm, strat, bal, push, num_trials=1000)
        print(f"{cfg:<8} {egm:<12} {strat:<18} {res.mean_time:<10.1f} {res.median_time:<12.1f} {res.p95_time:<10.1f} {res.success_rate * 100:<15.1f}%")
