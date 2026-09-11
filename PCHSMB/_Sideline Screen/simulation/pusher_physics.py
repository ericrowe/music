#!/usr/bin/env python3
"""
Pusher Biomechanics and Cart Dynamics Model.

Models:
- Middle-aged male parent pusher ergonomics and physical capacity.
- Load-dependent rolling resistance on high school athletic turf (infill turf).
- Velocity degradation under heavy loads (350 lb vs 550 lb vs 786 lb vs 1,026 lb).
- Acceleration latency from standstill.
- 90-degree corner turning scrub penalty.
- Cumulative distance fatigue factor.
- Stochastic fitness variation.
"""

import numpy as np
from typing import NamedTuple

CART_TARE_WEIGHT_LBS = 130.0   # 2x4 framing, 1/2" plywood deck, 4x 8" casters, guide rails
SCREEN_UNIT_WEIGHT_LBS = 26.0  # Dry weight of 1 assembled duck blind frame + vinyl
BALLAST_BAG_WEIGHT_LBS = 15.0  # 1 standard double-bagged gravel/sandbag

class PusherProfile(NamedTuple):
    name: str
    fitness_mean: float
    fitness_std: float
    fatigue_onset_yards: float
    fatigue_rate: float  # Velocity drop per 50 yards beyond onset

PUSHER_PROFILES = {
    "average": PusherProfile(
        name="Average Fitness Dad (40-55yo)",
        fitness_mean=1.00,
        fitness_std=0.10,
        fatigue_onset_yards=50.0,
        fatigue_rate=0.08
    ),
    "lower_fitness": PusherProfile(
        name="Lower Fitness Dad (Sedentary)",
        fitness_mean=0.82,
        fitness_std=0.08,
        fatigue_onset_yards=35.0,
        fatigue_rate=0.14
    ),
    "higher_fitness": PusherProfile(
        name="Athletic / Active Dad",
        fitness_mean=1.18,
        fitness_std=0.10,
        fatigue_onset_yards=75.0,
        fatigue_rate=0.05
    )
}

def sample_pusher_fitness(profile_key: str = "average", rng: np.random.Generator = None) -> float:
    """Samples a randomized fitness multiplier for a single trial."""
    if rng is None:
        rng = np.random.default_rng()
    profile = PUSHER_PROFILES[profile_key]
    fitness = rng.normal(profile.fitness_mean, profile.fitness_std)
    return max(0.60, min(1.45, fitness))

def compute_cart_velocity_yards_per_sec(
    gross_weight_lbs: float,
    fitness_multiplier: float,
    distance_traveled_yards: float,
    profile_key: str = "average",
    rng: np.random.Generator = None
) -> float:
    """
    Computes instantaneous steady-state pushing speed (yards/sec) on athletic turf.
    
    Biomechanical baseline:
    - Unloaded pushing speed (cart empty ~130 lbs): ~4.5 ft/s = 1.50 yd/s (~3.1 mph)
    - Pushing 350 lbs (2-cart empty screens): ~3.4 ft/s = 1.13 yd/s (~2.3 mph)
    - Pushing 460 lbs (2-cart + Tier 1 ballast): ~2.9 ft/s = 0.97 yd/s (~2.0 mph)
    - Pushing 550 lbs (1-cart empty screens): ~2.5 ft/s = 0.83 yd/s (~1.7 mph)
    - Pushing 786 lbs (1-cart + Tier 1 ballast): ~1.9 ft/s = 0.63 yd/s (~1.3 mph)
    - Pushing 1,026 lbs (1-cart + Tier 2 ballast): ~1.4 ft/s = 0.47 yd/s (~1.0 mph)
    """
    if rng is None:
        rng = np.random.default_rng()
        
    profile = PUSHER_PROFILES[profile_key]
    
    # Base unloaded velocity: 1.45 - 1.55 yd/s
    base_v = rng.normal(1.50, 0.06) * fitness_multiplier
    
    # Load degradation factor:
    # Modeled after hyperbolic Hill muscle force-velocity relationship
    # Normalized against reference payload
    payload = max(0.0, gross_weight_lbs - CART_TARE_WEIGHT_LBS)
    # Empirical fit to ergonomics pushing studies on grass/turf
    load_factor = 1.0 / (1.0 + 0.00165 * payload + 0.00000075 * (payload ** 2))
    
    # Distance fatigue factor
    if distance_traveled_yards > profile.fatigue_onset_yards:
        fatigue_dist = distance_traveled_yards - profile.fatigue_onset_yards
        fatigue_factor = max(0.65, 1.0 - (fatigue_dist / 50.0) * profile.fatigue_rate)
    else:
        fatigue_factor = 1.0
        
    v = base_v * load_factor * fatigue_factor
    return max(0.35, v)

def compute_turn_penalty_seconds(gross_weight_lbs: float, rng: np.random.Generator = None) -> float:
    """
    Time lost scrubbing speed, pivoting 4 heavy casters, and re-aligning 96" cart.
    Heavier carts incur significantly more caster scrub resistance.
    """
    if rng is None:
        rng = np.random.default_rng()
    # Base 90-deg turn penalty: 2.0 to 3.0 seconds
    base_turn = rng.triangular(1.8, 2.4, 3.2)
    # Weight scaling: +0.4s per 200 lbs of payload
    weight_penalty = (gross_weight_lbs / 400.0) * rng.uniform(0.6, 1.1)
    return base_turn + weight_penalty

def compute_acceleration_penalty_seconds(gross_weight_lbs: float, rng: np.random.Generator = None) -> float:
    """Latency from dead stop to steady pushing velocity on turf."""
    if rng is None:
        rng = np.random.default_rng()
    # Inertia time to accelerate
    return rng.triangular(1.5, 2.2, 3.5) * (gross_weight_lbs / 400.0) ** 0.5

if __name__ == "__main__":
    print("=== PUSHER BIOMECHANICS & CART SPEED VERIFICATION ===")
    rng = np.random.default_rng(42)
    
    weights = [
        ("Empty Cart", 130.0),
        ("2-Cart (8 screens, no ballast)", 130.0 + 8 * 26.0),
        ("2-Cart (8 screens + Tier 1 ballast)", 130.0 + 8 * 41.0),
        ("1-Cart (16 screens, no ballast)", 130.0 + 16 * 26.0),
        ("1-Cart (16 screens + Tier 1 ballast)", 130.0 + 16 * 41.0),
        ("1-Cart (16 screens + Tier 2 ballast)", 130.0 + 16 * 56.0),
    ]
    
    print(f"{'Configuration':<40} {'Weight (lbs)':<14} {'Speed (yd/s)':<14} {'Speed (mph)':<14} {'Turn Penalty (s)':<16}")
    print("-" * 98)
    for desc, w in weights:
        v = np.mean([compute_cart_velocity_yards_per_sec(w, 1.0, 30.0, "average", rng) for _ in range(500)])
        v_mph = (v * 3.0 / 5280.0) * 3600.0
        turn = np.mean([compute_turn_penalty_seconds(w, rng) for _ in range(500)])
        print(f"{desc:<40} {w:<14.1f} {v:<14.2f} {v_mph:<14.2f} {turn:<16.2f}")
