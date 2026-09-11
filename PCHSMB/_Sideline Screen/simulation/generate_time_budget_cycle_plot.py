#!/usr/bin/env python3
"""
generate_time_budget_cycle_plot.py

Generates a publication-quality circular process diagram representing the
CBA 15:00 Total Field Block and dynamic time budget architecture.
Features:
- Sequential progression arrows for 1 -> 2, 2 -> 3, and 3 -> 4.
- Dotted time-transfer connector (no arrow) between Phase 1 and Phase 4.
- Central badge detailing the master 15-minute contest clock and fungible time tradeoff.
- Captures asymmetric 20/40 entry and zero-doubling-back directional flow.
"""

import os
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch
import numpy as np

def generate_plot():
    fig, ax = plt.subplots(figsize=(10.5, 10.5), dpi=300)
    fig.patch.set_facecolor("#ffffff")
    ax.set_facecolor("#ffffff")

    center = (0.5, 0.5)
    radius = 0.355

    colors = ["#059669", "#2563eb", "#7c3aed", "#d97706"]
    border_colors = ["#047857", "#1d4ed8", "#6d28d9", "#b45309"]

    stages = [
        {
            "title": "1. Deployment & Entry",
            "time": "Target: 2:14  |  Cap: 3:15",
            "desc": "• Asymmetric 20 & 40-yd entry\n• Drop blinds moving away from exit\n• Early signal banks +61s slack",
            "angle": 135
        },
        {
            "title": "2. Official Announcement",
            "time": "~0:35  |  Rule 5.09",
            "desc": "• CBA Standard Script\n• Triggered immediately on signal\n• Band takes opening sets & warms up",
            "angle": 45
        },
        {
            "title": "3. Show Performance",
            "time": "Show Sound: 7:45 – 8:45",
            "desc": "• Judged musical performance\n• Min: 5:30  |  Bulletproof max: 8:45\n• 16 egress performers finish at blinds",
            "angle": 315
        },
        {
            "title": "4. Post-Show Egress",
            "time": "Dynamic: 2:00 – 3:01+",
            "desc": "• Direct hand-carry sprint down sideline\n• Ballast sweep straight towards exit\n• ★ CLOCK STOPS AT TUNNEL MOUTH ★",
            "angle": 225
        }
    ]

    # Track circle (faint background)
    track = patches.Circle(center, radius, fill=False, edgecolor="#e2e8f0", linewidth=5, linestyle=":", zorder=1)
    ax.add_patch(track)

    # ARROW 1 -> 2 (Top: from Box 1 right edge to Box 2 left edge)
    a1 = FancyArrowPatch((0.40, 0.77), (0.60, 0.77),
                         connectionstyle="arc3,rad=-0.18",
                         arrowstyle="Simple,tail_width=4,head_width=13,head_length=13",
                         color="#2563eb", zorder=15)
    ax.add_patch(a1)

    # ARROW 2 -> 3 (Right: from Box 2 bottom edge to Box 3 top edge)
    a2 = FancyArrowPatch((0.77, 0.66), (0.77, 0.34),
                         connectionstyle="arc3,rad=-0.18",
                         arrowstyle="Simple,tail_width=4,head_width=13,head_length=13",
                         color="#7c3aed", zorder=15)
    ax.add_patch(a2)

    # ARROW 3 -> 4 (Bottom: from Box 3 left edge to Box 4 right edge)
    a3 = FancyArrowPatch((0.60, 0.23), (0.40, 0.23),
                         connectionstyle="arc3,rad=-0.18",
                         arrowstyle="Simple,tail_width=4,head_width=13,head_length=13",
                         color="#d97706", zorder=15)
    ax.add_patch(a3)

    # 1 -> 4 (Left side): NO ARROW! Just the dotted line and the text "Fungible...."
    theta_left = np.linspace(np.radians(152), np.radians(208), 100)
    x_left = center[0] + radius * np.cos(theta_left)
    y_left = center[1] + radius * np.sin(theta_left)
    ax.plot(x_left, y_left, linestyle="--", linewidth=4, color="#10b981", zorder=2, dash_capstyle="round", dashes=(3, 3))

    # Label for the dotted line on left
    ax.text(0.09, 0.50, "Fungible Banked\nTime Transfer\n(+61s Slack)",
            ha="center", va="center", color="#047857", fontsize=10, fontweight="bold", linespacing=1.25)

    # Center badge
    c_w, c_h = 0.35, 0.27
    center_card = FancyBboxPatch((center[0] - c_w/2, center[1] - c_h/2), c_w, c_h,
                                 boxstyle="round,pad=0.02,rounding_size=0.03",
                                 facecolor="#0f172a", edgecolor="#334155", linewidth=2.5, zorder=5)
    ax.add_patch(center_card)

    ax.text(0.5, 0.585, "CBA 15:00 TOTAL BLOCK", ha="center", va="center", color="#38bdf8", fontsize=12, fontweight="bold", zorder=6)
    ax.text(0.5, 0.55, "(Class 4A / 5A Contest Rule 5.06)", ha="center", va="center", color="#94a3b8", fontsize=9, zorder=6)

    ax.plot([0.35, 0.65], [0.52, 0.52], color="#334155", linewidth=1.5, zorder=6)

    ax.text(0.5, 0.48, "★ DYNAMIC TIME TRADEOFF ★", ha="center", va="center", color="#fbbf24", fontsize=10.5, fontweight="bold", zorder=6)
    ax.text(0.5, 0.415, "Shaving 61s off Deployment (2:14)\ntransfers directly into Egress,\nexpanding clearance up to 3:01!",
            ha="center", va="center", color="#f8fafc", fontsize=9.5, multialignment="center", linespacing=1.35, zorder=6)

    # Boxes
    box_w, box_h = 0.29, 0.165
    for i, stage in enumerate(stages):
        deg = stage["angle"]
        rad = np.radians(deg)
        bx = center[0] + radius * np.cos(rad)
        by = center[1] + radius * np.sin(rad)
        
        x0 = bx - box_w / 2
        y0 = by - box_h / 2
        
        # Card background
        box = FancyBboxPatch((x0, y0), box_w, box_h,
                             boxstyle="round,pad=0.015,rounding_size=0.025",
                             facecolor="#ffffff", edgecolor=border_colors[i], linewidth=2.5, zorder=10)
        ax.add_patch(box)
        
        # Header banner
        banner = FancyBboxPatch((x0, y0 + box_h - 0.042), box_w, 0.042,
                                boxstyle="round,pad=0.008,rounding_size=0.018",
                                facecolor=colors[i], edgecolor=border_colors[i], linewidth=1.2, zorder=11)
        ax.add_patch(banner)
        
        ax.text(bx, y0 + box_h - 0.021, stage["title"], ha="center", va="center", color="#ffffff", fontsize=10.5, fontweight="bold", zorder=12)
        ax.text(bx, y0 + box_h - 0.065, stage["time"], ha="center", va="center", color=border_colors[i], fontsize=9.5, fontweight="bold", zorder=12)
        ax.text(bx, y0 + 0.04, stage["desc"], ha="center", va="center", color="#334155", fontsize=8.2, multialignment="left", linespacing=1.3, zorder=12)

    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis("off")

    # Title at very top
    ax.text(0.5, 0.97, "CBA 15-Minute Dynamic Time Budget & Operational Flow", ha="center", va="center", color="#0f172a", fontsize=14, fontweight="bold")

    plt.tight_layout()
    
    # Save destinations
    script_dir = os.path.dirname(os.path.abspath(__file__))
    out_plot = os.path.join(script_dir, "plots", "cba_15min_time_budget_cycle.png")
    os.makedirs(os.path.dirname(out_plot), exist_ok=True)
    fig.savefig(out_plot)
    
    brain_plot = "/Users/ericrowe/.gemini/antigravity-cli/brain/480e0d48-2cd8-4c43-8b70-48d3dc0ab38e/cba_15min_time_budget_cycle.png"
    fig.savefig(brain_plot)
    plt.close(fig)
    print(f"Generated plot: {out_plot}")

if __name__ == "__main__":
    generate_plot()
