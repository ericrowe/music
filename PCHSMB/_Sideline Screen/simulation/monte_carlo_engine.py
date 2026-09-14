#!/usr/bin/env python3
"""
Monte Carlo Simulation Engine for Sideline Screen Field Deployment.

Simulates stochastic execution times for:
- 1 Cart vs 2 Carts
- 5 Permitted Starting Locations (EZ_Behind_Goal, EZ_Corner_Back, Back_20, Back_40, Back_50)
- 2 Setup Strategies:
    1. 'mobile_pincer': Cart crew (1 parent + 2 students) drops and deploys screens in pincer.
    2. 'pre_set_receivers': Cart crew only drops; 8 on-field student receivers deploy in parallel.
- Ballast configurations ('none', 'tier1', 'tier2', 'pre_staged')
- Pusher fitness tiers ('average', 'lower_fitness', 'higher_fitness')
- Cross-field pit routing for 1 cart ('front_sideline' vs 'behind_pit')
"""

import math
import numpy as np
from typing import Dict, List, NamedTuple, Optional
from field_model import (
    compute_route, STARTING_LOCATIONS, SCREENS_PER_SIDE, TOTAL_SCREENS,
    SCREEN_WIDTH_YARDS, DeploymentRoute, FIELD_WIDTH_YARDS
)
from pusher_physics import (
    CART_TARE_WEIGHT_LBS, SCREEN_UNIT_WEIGHT_LBS, BALLAST_BAG_WEIGHT_LBS,
    sample_pusher_fitness, compute_cart_velocity_yards_per_sec,
    compute_turn_penalty_seconds, compute_acceleration_penalty_seconds
)

CBA_LIMIT_SECONDS = 195.0  # 3 minutes 15 seconds

class TrialResult(NamedTuple):
    trial_id: int
    total_time_seconds: float
    success: bool
    slack_seconds: float  # 195.0 - total_time
    t_ingress_s: float
    t_drop_s: float
    t_setup_s: float
    t_pit_cross_s: float
    t_stow_s: float
    t_students_ready_s: float
    gross_start_weight_lbs: float
    bottleneck: str

class ScenarioSummary(NamedTuple):
    config: str
    start_location: str
    strategy: str
    ballast_mode: str
    pusher_profile: str
    pit_cross_mode: str
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

def simulate_single_cart_side(
    route: DeploymentRoute,
    strategy: str,
    ballast_mode: str,
    pusher_fitness: float,
    pusher_profile: str,
    rng: np.random.Generator
) -> Dict[str, float]:
    """
    Simulates one cart operating on one side (8 screens) for 2-cart configuration.
    """
    num_screens = len(route.screen_order)
    
    # Compute ballast weight per screen
    if ballast_mode == "tier1":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 1.0  # 15 lbs
    elif ballast_mode == "tier2":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 2.0  # 30 lbs
    else:
        ballast_per_screen = 0.0 # 'none' or 'pre_staged'
        
    gross_weight = CART_TARE_WEIGHT_LBS + num_screens * (SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen)
    start_gross_weight = gross_weight
    
    current_time = 0.0
    dist_accum = 0.0
    
    # 1. Ingress Segment
    ingress_seg = route.segments[0]
    # Acceleration
    current_time += compute_acceleration_penalty_seconds(gross_weight, rng)
    # Turns during ingress
    for _ in range(ingress_seg.turns_90deg):
        current_time += compute_turn_penalty_seconds(gross_weight, rng)
    # Transit velocity
    v_ingress = compute_cart_velocity_yards_per_sec(gross_weight, pusher_fitness, dist_accum, pusher_profile, rng)
    t_ingress = ingress_seg.distance_yards / v_ingress
    current_time += t_ingress
    dist_accum += ingress_seg.distance_yards
    
    t_ingress_total = current_time
    
    # 2. Dropping Screens along Front Sideline
    drop_timestamps = []
    t_drop_start = current_time
    
    # Cart moves along front sideline between screens
    inter_screen_dist = SCREEN_WIDTH_YARDS # 2.667 yd
    
    for i in range(num_screens):
        # Drop time
        if strategy == "pre_set_receivers":
            # Just slide off and lay flat
            t_d = rng.triangular(2.4, 3.4, 4.8)
        else:
            # Mobile pincer drop
            t_d = rng.triangular(3.0, 4.2, 5.8)
            
        # Fumble hitch probability
        if rng.random() < 0.05:
            t_d += rng.uniform(2.5, 4.5)
            
        current_time += t_d
        drop_timestamps.append(current_time)
        
        # Reduce weight as screen is dropped
        gross_weight -= (SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen)
        
        # Move to next screen location (if not last screen)
        if i < num_screens - 1:
            v_move = compute_cart_velocity_yards_per_sec(gross_weight, pusher_fitness, dist_accum, pusher_profile, rng)
            current_time += inter_screen_dist / v_move
            dist_accum += inter_screen_dist
            
    t_drop_total = current_time - t_drop_start
    t_all_dropped = current_time
    
    # 3. Screen Setup
    screen_ready_timestamps = []
    
    if strategy == "pre_set_receivers":
        # On-field students are already at their assigned spots!
        # Each student sets up their single screen concurrently starting at its drop_timestamp
        for i, t_drop_i in enumerate(drop_timestamps):
            t_setup_i = rng.triangular(6.8, 9.0, 12.5)
            if ballast_mode in ["tier1", "tier2", "pre_staged"]:
                t_setup_i += rng.triangular(2.0, 3.2, 4.5)
            # Clip latch hitch
            if rng.random() < 0.06:
                t_setup_i += rng.uniform(2.5, 4.5)
            # Step from screen to opening drill dot (already right there)
            t_step = rng.triangular(2.0, 3.2, 5.0)
            ready_i = t_drop_i + t_setup_i + t_step
            screen_ready_timestamps.append(ready_i)
        t_all_screens_ready = max(screen_ready_timestamps)
        t_students_ready = t_all_screens_ready
        
    else: # "mobile_pincer"
        # 2 Students on cart crew setup all 8 screens in pincer:
        # Student B follows cart, setting up screens from start of line toward center (Screens 1 to 4)
        # Student A waits for last drop, then sets up from end of line toward center (Screens 8 down to 5)
        
        # Student B sequence (first 4 screens)
        t_sb = drop_timestamps[0] # Starts at first drop
        for idx in range(4):
            # Wait if screen hasn't dropped yet
            t_sb = max(t_sb, drop_timestamps[idx])
            t_s = rng.triangular(7.8, 10.2, 13.5)
            if ballast_mode in ["tier1", "tier2", "pre_staged"]:
                t_s += rng.triangular(2.5, 3.8, 5.2)
            if rng.random() < 0.08:
                t_s += rng.uniform(3.0, 5.0)
            t_sb += t_s
            if idx < 3:
                t_sb += inter_screen_dist / 1.5 # Walking to next screen
                
        # Student A sequence (last 4 screens, working backward)
        t_sa = drop_timestamps[-1] # Starts when last screen dropped
        for idx in range(num_screens - 1, num_screens - 5, -1):
            t_s = rng.triangular(7.8, 10.2, 13.5)
            if ballast_mode in ["tier1", "tier2", "pre_staged"]:
                t_s += rng.triangular(2.5, 3.8, 5.2)
            if rng.random() < 0.08:
                t_s += rng.uniform(3.0, 5.0)
            t_sa += t_s
            if idx > num_screens - 4:
                t_sa += inter_screen_dist / 1.5
                
        t_all_screens_ready = max(t_sa, t_sb)
        # Both students sprint to opening drill spots (15-30 yd)
        t_sprint = rng.triangular(6.0, 9.5, 14.0)
        t_students_ready = t_all_screens_ready + t_sprint
        
    # 4. Cart Stowage
    # Parent rolls empty cart off-field across front boundary
    v_stow = compute_cart_velocity_yards_per_sec(CART_TARE_WEIGHT_LBS, pusher_fitness, dist_accum, pusher_profile, rng)
    t_stow_move = route.segments[-1].distance_yards / v_stow
    t_stow_turn = compute_turn_penalty_seconds(CART_TARE_WEIGHT_LBS, rng)
    t_stow_park = rng.triangular(3.0, 5.0, 8.0)
    t_stow = t_all_dropped + t_stow_move + t_stow_turn + t_stow_park
    
    total_time = max(t_stow, t_all_screens_ready, t_students_ready)
    
    bottleneck = "screens_setup" if total_time == t_students_ready else "cart_stowage"
    
    return {
        "total_time": total_time,
        "t_ingress": t_ingress_total,
        "t_drop": t_drop_total,
        "t_setup": t_all_screens_ready - t_ingress_total,
        "t_stow": t_stow,
        "t_students_ready": t_students_ready,
        "start_weight": start_gross_weight,
        "bottleneck": bottleneck
    }

def simulate_full_fleet_single_cart(
    route: DeploymentRoute,
    strategy: str,
    ballast_mode: str,
    pusher_fitness: float,
    pusher_profile: str,
    rng: np.random.Generator
) -> Dict[str, float]:
    """
    Simulates a single cart handling all 16 screens (Side 1 then Side 2).
    """
    total_screens = TOTAL_SCREENS # 16
    
    if ballast_mode == "tier1":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 1.0  # 15 lbs
    elif ballast_mode == "tier2":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 2.0  # 30 lbs
    else:
        ballast_per_screen = 0.0
        
    gross_weight = CART_TARE_WEIGHT_LBS + total_screens * (SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen)
    start_gross_weight = gross_weight
    
    current_time = 0.0
    dist_accum = 0.0
    
    # 1. Ingress to Side 1 Screen 8
    ingress_seg = route.segments[0]
    current_time += compute_acceleration_penalty_seconds(gross_weight, rng)
    for _ in range(ingress_seg.turns_90deg):
        current_time += compute_turn_penalty_seconds(gross_weight, rng)
    v_ingress = compute_cart_velocity_yards_per_sec(gross_weight, pusher_fitness, dist_accum, pusher_profile, rng)
    current_time += ingress_seg.distance_yards / v_ingress
    dist_accum += ingress_seg.distance_yards
    t_ingress_total = current_time
    
    # 2. Drop Side 1 Screens (8 down to 1)
    side1_drops = []
    inter_screen_dist = SCREEN_WIDTH_YARDS
    t_drop_start = current_time
    
    for i in range(SCREENS_PER_SIDE):
        t_d = rng.triangular(2.4, 3.4, 4.8) if strategy == "pre_set_receivers" else rng.triangular(3.0, 4.2, 5.8)
        if rng.random() < 0.05:
            t_d += rng.uniform(2.5, 4.5)
        current_time += t_d
        side1_drops.append(current_time)
        gross_weight -= (SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen)
        
        if i < SCREENS_PER_SIDE - 1:
            v_move = compute_cart_velocity_yards_per_sec(gross_weight, pusher_fitness, dist_accum, pusher_profile, rng)
            current_time += inter_screen_dist / v_move
            dist_accum += inter_screen_dist
            
    # 3. Cross-field Transit across front ensemble (Pit) to Side 2
    pit_seg = route.segments[2]
    t_pit_start = current_time
    for _ in range(pit_seg.turns_90deg):
        current_time += compute_turn_penalty_seconds(gross_weight, rng)
    v_pit = compute_cart_velocity_yards_per_sec(gross_weight, pusher_fitness, dist_accum, pusher_profile, rng)
    current_time += pit_seg.distance_yards / v_pit
    dist_accum += pit_seg.distance_yards
    t_pit_cross = current_time - t_pit_start
    
    # 4. Drop Side 2 Screens (9 out to 16)
    side2_drops = []
    for i in range(SCREENS_PER_SIDE):
        t_d = rng.triangular(2.4, 3.4, 4.8) if strategy == "pre_set_receivers" else rng.triangular(3.0, 4.2, 5.8)
        if rng.random() < 0.05:
            t_d += rng.uniform(2.5, 4.5)
        current_time += t_d
        side2_drops.append(current_time)
        gross_weight -= (SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen)
        
        if i < SCREENS_PER_SIDE - 1:
            v_move = compute_cart_velocity_yards_per_sec(gross_weight, pusher_fitness, dist_accum, pusher_profile, rng)
            current_time += inter_screen_dist / v_move
            dist_accum += inter_screen_dist
            
    t_drop_total = current_time - t_drop_start - t_pit_cross
    t_all_dropped = current_time
    
    # 5. Screen Setup
    all_ready_timestamps = []
    
    if strategy == "pre_set_receivers":
        # 16 students on field (8 on Side 1, 8 on Side 2) each setup their own screen as soon as dropped!
        all_drops = side1_drops + side2_drops
        for t_d in all_drops:
            t_s = rng.triangular(6.8, 9.0, 12.5)
            if ballast_mode in ["tier1", "tier2", "pre_staged"]:
                t_s += rng.triangular(2.0, 3.2, 4.5)
            if rng.random() < 0.06:
                t_s += rng.uniform(2.5, 4.5)
            t_step = rng.triangular(2.0, 3.2, 5.0)
            all_ready_timestamps.append(t_d + t_s + t_step)
            
        t_all_screens_ready = max(all_ready_timestamps)
        t_students_ready = t_all_screens_ready
        
    else: # "mobile_pincer"
        # 1 Cart with 2 students:
        # Student 1 stays on Side 1 to deploy all 8 Side 1 screens.
        # Student 2 rides/walks with cart across pit and deploys all 8 Side 2 screens!
        
        # Student 1 on Side 1 (sets up all 8 screens):
        t_s1 = side1_drops[0]
        for idx in range(SCREENS_PER_SIDE):
            t_s1 = max(t_s1, side1_drops[idx])
            t_s = rng.triangular(7.8, 10.2, 13.5)
            if ballast_mode in ["tier1", "tier2", "pre_staged"]:
                t_s += rng.triangular(2.5, 3.8, 5.2)
            if rng.random() < 0.08:
                t_s += rng.uniform(3.0, 5.0)
            t_s1 += t_s
            if idx < SCREENS_PER_SIDE - 1:
                t_s1 += inter_screen_dist / 1.4
        t_s1 += rng.triangular(6.0, 9.5, 14.0) # sprint to dot
        
        # Student 2 on Side 2 (sets up all 8 screens):
        t_s2 = side2_drops[0]
        for idx in range(SCREENS_PER_SIDE):
            t_s2 = max(t_s2, side2_drops[idx])
            t_s = rng.triangular(7.8, 10.2, 13.5)
            if ballast_mode in ["tier1", "tier2", "pre_staged"]:
                t_s += rng.triangular(2.5, 3.8, 5.2)
            if rng.random() < 0.08:
                t_s += rng.uniform(3.0, 5.0)
            t_s2 += t_s
            if idx < SCREENS_PER_SIDE - 1:
                t_s2 += inter_screen_dist / 1.4
        t_s2 += rng.triangular(6.0, 9.5, 14.0)
        
        t_all_screens_ready = max(t_s1, t_s2)
        t_students_ready = t_all_screens_ready
        
    # 6. Cart Stowage on Side 2
    v_stow = compute_cart_velocity_yards_per_sec(CART_TARE_WEIGHT_LBS, pusher_fitness, dist_accum, pusher_profile, rng)
    t_stow_move = route.segments[-1].distance_yards / v_stow
    t_stow_turn = compute_turn_penalty_seconds(CART_TARE_WEIGHT_LBS, rng)
    t_stow_park = rng.triangular(3.0, 5.0, 8.0)
    t_stow = t_all_dropped + t_stow_move + t_stow_turn + t_stow_park
    
    total_time = max(t_stow, t_all_screens_ready, t_students_ready)
    bottleneck = "screens_setup" if total_time == t_students_ready else "cart_stowage"
    
    return {
        "total_time": total_time,
        "t_ingress": t_ingress_total,
        "t_drop": t_drop_total,
        "t_setup": t_all_screens_ready - t_ingress_total,
        "t_pit_cross": t_pit_cross,
        "t_stow": t_stow,
        "t_students_ready": t_students_ready,
        "start_weight": start_gross_weight,
        "bottleneck": bottleneck
    }

def simulate_two_student_carry_fleet(
    ballast_mode: str,
    rng: np.random.Generator
) -> Dict[str, float]:
    """
    Simulates the Two-Student Carry fleet deployment strategy:
    - 16 fully assembled duck blinds queued along the back sideline directly opposite
      their final front sideline drop locations.
    - 2 students assigned per screen (32 students total).
    - On clock start (0:00), all 16 pairs step off simultaneously and walk 53.33 yards straight
      across the field (0 turns) to the front sideline.
    - Each pair deposits and aligns their screen, secures ballast (if loaded), and steps back into drill position.
    - Parallel execution: Fleet finishes when the LAST of the 16 pairs completes setup.
    """
    if ballast_mode == "tier1":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 1.0  # 15.0 lbs
    elif ballast_mode == "tier2":
        ballast_per_screen = BALLAST_BAG_WEIGHT_LBS * 2.0  # 30.0 lbs
    else:
        ballast_per_screen = 0.0  # 'none' or 'pre_staged'
        
    gross_screen_wt = SCREEN_UNIT_WEIGHT_LBS + ballast_per_screen
    wt_per_student = gross_screen_wt / 2.0  # shared between 2 students
    
    # Weight speed degradation factor: ~0.5% reduction per lb carried per student
    load_factor = 1.0 / (1.0 + 0.005 * wt_per_student)
    
    # Aerodynamic wind buffeting factor for vertical 8x4.5 ft sail carried across open field:
    if ballast_mode in ["none", "pre_staged"]:
        wind_drag = rng.triangular(0.96, 0.99, 1.02)
    elif ballast_mode == "tier1":
        wind_drag = rng.triangular(0.93, 0.96, 1.00)
    else:  # tier2
        wind_drag = rng.triangular(0.88, 0.92, 0.96)
        
    pair_times = []
    t_transits = []
    t_drops = []
    t_setups = []
    
    for _ in range(TOTAL_SCREENS):  # 16 pairs
        # Base student walking pace in step: ~1.35 to 1.75 yd/s (approx 2.8 - 3.6 mph)
        v_base = rng.triangular(1.35, 1.55, 1.75)
        pair_load = load_factor * rng.uniform(0.97, 1.03)
        v_walk = max(0.9, v_base * pair_load * wind_drag)
        
        # Acceleration / step-off reaction
        t_accel = rng.triangular(1.0, 1.5, 2.2)
        # Transit distance across standard field (back sideline to front sideline)
        d_transit = FIELD_WIDTH_YARDS  # 53.333 yd
        t_walk = t_accel + (d_transit / v_walk)
        
        # Deposit and alignment at front sideline mark
        t_dep = rng.triangular(2.5, 3.8, 5.5)
        # 5% probability of minor alignment or footing hitch
        if rng.random() < 0.05:
            t_dep += rng.uniform(1.5, 3.5)
            
        # Ballast adjustment/check on base rail (if attached)
        t_bal = rng.triangular(1.8, 3.0, 4.5) if ballast_mode in ["tier1", "tier2"] else 0.0
        
        # Step back / clearance into performance drill position
        t_clear = rng.triangular(1.8, 2.8, 4.2)
        
        total_pair_time = t_walk + t_dep + t_bal + t_clear
        pair_times.append(total_pair_time)
        t_transits.append(t_walk)
        t_drops.append(t_dep)
        t_setups.append(t_bal + t_clear)
        
    total_time = max(pair_times)
    
    return {
        "total_time": total_time,
        "t_ingress": float(np.mean(t_transits)),
        "t_drop": float(np.mean(t_drops)),
        "t_setup": float(np.mean(t_setups)),
        "t_pit_cross": 0.0,
        "t_stow": 0.0,
        "t_students_ready": total_time,
        "start_weight": gross_screen_wt,
        "bottleneck": "student_carry_arrival"
    }

def run_monte_carlo(
    config: str,
    start_key: str,
    strategy: str = "mobile_pincer",
    ballast_mode: str = "tier1",
    pusher_profile: str = "average",
    pit_cross_mode: str = "front_sideline",
    num_trials: int = 10000,
    seed: Optional[int] = 42
) -> ScenarioSummary:
    """
    Executes N Monte Carlo trials for a specific operational scenario.
    """
    rng = np.random.default_rng(seed)
    
    times = np.empty(num_trials, dtype=float)
    slacks = np.empty(num_trials, dtype=float)
    successes = 0
    
    if config == "two_student_carry" or strategy == "two_student_carry":
        for i in range(num_trials):
            res = simulate_two_student_carry_fleet(ballast_mode, rng)
            t_fleet = res["total_time"]
            times[i] = t_fleet
            slacks[i] = CBA_LIMIT_SECONDS - t_fleet
            if t_fleet <= CBA_LIMIT_SECONDS:
                successes += 1
                
    elif config == "2_carts":
        route1 = compute_route("2_carts", start_key, cart_id=1)
        route2 = compute_route("2_carts", start_key, cart_id=2)
        
        for i in range(num_trials):
            f1 = sample_pusher_fitness(pusher_profile, rng)
            f2 = sample_pusher_fitness(pusher_profile, rng)
            
            res1 = simulate_single_cart_side(route1, strategy, ballast_mode, f1, pusher_profile, rng)
            res2 = simulate_single_cart_side(route2, strategy, ballast_mode, f2, pusher_profile, rng)
            
            # Fleet finishes when BOTH carts/sides finish
            t_fleet = max(res1["total_time"], res2["total_time"])
            times[i] = t_fleet
            slacks[i] = CBA_LIMIT_SECONDS - t_fleet
            if t_fleet <= CBA_LIMIT_SECONDS:
                successes += 1
                
    else: # 1_cart
        route = compute_route("1_cart", start_key, pit_cross_mode=pit_cross_mode)
        for i in range(num_trials):
            f = sample_pusher_fitness(pusher_profile, rng)
            res = simulate_full_fleet_single_cart(route, strategy, ballast_mode, f, pusher_profile, rng)
            t_fleet = res["total_time"]
            times[i] = t_fleet
            slacks[i] = CBA_LIMIT_SECONDS - t_fleet
            if t_fleet <= CBA_LIMIT_SECONDS:
                successes += 1
                
    return ScenarioSummary(
        config=config,
        start_location=start_key,
        strategy=strategy,
        ballast_mode=ballast_mode,
        pusher_profile=pusher_profile,
        pit_cross_mode=pit_cross_mode,
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
    print("=== MONTE CARLO ENGINE TEST (1,000 trials each) ===")
    
    test_cases = [
        ("two_student_carry", "Back_Sideline", "two_student_carry", "tier1", "average"),
        ("2_carts", "Back_20", "mobile_pincer", "tier1", "average"),
        ("2_carts", "Back_20", "pre_set_receivers", "tier1", "average"),
        ("1_cart", "Back_20", "mobile_pincer", "tier1", "average"),
        ("1_cart", "Back_20", "pre_set_receivers", "tier1", "average"),
        ("1_cart", "Back_50", "pre_set_receivers", "tier1", "average"),
    ]
    
    print(f"{'Config':<10} {'Start':<12} {'Strategy':<18} {'Mean (s)':<10} {'Median (s)':<12} {'P95 (s)':<10} {'Success Rate':<14}")
    print("-" * 88)
    for cfg, st, strat, bal, push in test_cases:
        res = run_monte_carlo(cfg, st, strat, bal, push, num_trials=1000)
        print(f"{cfg:<10} {st:<12} {strat:<18} {res.mean_time:<10.1f} {res.median_time:<12.1f} {res.p95_time:<10.1f} {res.success_rate * 100:<13.1f}%")
