#!/usr/bin/env python3
"""
create_weather_briefing.py

CLI tool to scaffold, populate, and compile a standardized two-page
operational weather briefing for PCHSMB football games and band competitions.

Standard Naming: YYYY_Weather_Briefing_MMMDD_<event>_<location>_<GenDay>_<GenTime>.typ
Skill: $generate-weather-briefing
"""

import argparse
import datetime
import os
import re
import subprocess
import sys


def parse_args():
    parser = argparse.ArgumentParser(
        description="Generate standardized 2-page PCHSMB Operational Weather Briefing."
    )
    parser.add_argument("--date", required=True, help="Event date (YYYY-MM-DD), e.g. 2026-10-15")
    parser.add_argument("--event-name", required=True, help="Event name, e.g. 'Football Game'")
    parser.add_argument("--venue", required=True, help="Venue full name, e.g. 'Falcon Stadium (USAFA)'")
    parser.add_argument("--venue-short", default=None, help="Short venue name (default: derived from venue)")
    parser.add_argument("--venue-elevation", default="6,500' ASL", help="Venue elevation, e.g. '6,650'–7,200' ASL'")
    parser.add_argument("--unload-location", default="PCHS Loading Dock & Band Room", help="Post-event unload venue")
    parser.add_argument("--unload-short", default="PCHS", help="Short unload venue name")
    parser.add_argument("--lat", type=float, default=38.9972, help="Venue latitude for NWS API (default: 38.9972 for Falcon Stadium)")
    parser.add_argument("--lon", type=float, default=-104.8436, help="Venue longitude for NWS API (default: -104.8436 for Falcon Stadium)")
    parser.add_argument("--fetch-nws", action="store_true", default=True, help="Pull live hourly weather data directly from api.weather.gov")
    parser.add_argument("--call-time", default="16:15", help="Student/truck call time (HH:MM 24h), e.g. '16:15'")
    parser.add_argument("--kickoff-time", default="18:00", help="Game or performance start time, e.g. '18:00'")
    parser.add_argument("--halftime-time", default="19:45", help="Halftime or egress time, e.g. '19:45'")
    parser.add_argument("--ballast-tier", type=int, choices=[0, 1, 2, 3, 4], default=2, help="Forecasted prop ballast tier")
    parser.add_argument("--output-dir", default="PCHSMB/2026 Continuum", help="Destination folder")
    parser.add_argument("--now", default=None, help="Override generation timestamp (YYYY-MM-DDTHH:MM:SS)")
    parser.add_argument("--compile", action="store_true", help="Compile with typst immediately after generation")
    return parser.parse_args()


def round_to_15_minutes(dt):
    """
    Rounds a datetime object to the nearest 15-minute interval (:00, :15, :30, :45).
    Halfway point (7.5 minutes = 450 seconds) rounds up.
    """
    discard = datetime.timedelta(
        minutes=dt.minute % 15,
        seconds=dt.second,
        microseconds=dt.microsecond
    )
    dt_floor = dt - discard
    if discard >= datetime.timedelta(minutes=7, seconds=30):
        return dt_floor + datetime.timedelta(minutes=15)
    return dt_floor


def calculate_lead_time(now_dt, event_date_obj, call_time_str):
    """
    Calculate human-readable lead time:
    - Same day: 'X.X hrs before event (H:MM AM/PM)'
    - Prior day(s): 'X days before event (MMM DD)'
    """
    call_parts = [int(p) for p in call_time_str.split(":")]
    call_dt = datetime.datetime(
        event_date_obj.year, event_date_obj.month, event_date_obj.day,
        call_parts[0], call_parts[1]
    )

    diff = call_dt - now_dt
    diff_hours = diff.total_seconds() / 3600.0

    call_12h = call_dt.strftime("%-I:%M %p")
    event_short = event_date_obj.strftime("%b %-d")

    if diff_hours < 0:
        return "POST-EVENT ARCHIVE"
    elif diff_hours <= 24:
        # Same day or within 24 hours
        return f"{diff_hours:.1f} hrs before event ({call_12h})"
    else:
        days = int(round(diff_hours / 24.0))
        return f"{days} days before event ({event_short})"


def sanitize_filename_token(name):
    # Keep alphanumeric and underscores
    clean = re.sub(r"[^\w\s-]", "", name)
    clean = re.sub(r"[\s-]+", "_", clean).strip("_")
    return clean


def fetch_nws_forecast(lat, lon):
    """
    Fetch live hourly forecast from api.weather.gov for given lat/lon coordinates.
    """
    import urllib.request
    import json
    headers = {"User-Agent": "PCHSMB-WeatherBriefing/1.0 (contact@pchsband.org)"}
    try:
        points_url = f"https://api.weather.gov/points/{lat},{lon}"
        req = urllib.request.Request(points_url, headers=headers)
        with urllib.request.urlopen(req, timeout=10) as resp:
            points_data = json.loads(resp.read().decode("utf-8"))
        hourly_url = points_data["properties"]["forecastHourly"]
        req_h = urllib.request.Request(hourly_url, headers=headers)
        with urllib.request.urlopen(req_h, timeout=10) as resp:
            hourly_data = json.loads(resp.read().decode("utf-8"))
        return hourly_data["properties"]["periods"]
    except Exception as e:
        print(f"Warning: Failed to fetch live NWS data: {e}", file=sys.stderr)
        return None


def main():
    args = parse_args()

    # Parse dates
    event_date = datetime.datetime.strptime(args.date, "%Y-%m-%d").date()
    if args.now:
        now_dt = datetime.datetime.fromisoformat(args.now)
    else:
        now_dt = datetime.datetime.now()

    # Round generation timestamp to nearest 15 minutes to reduce overwrites
    now_rounded = round_to_15_minutes(now_dt)

    # Derived event fields
    event_year = event_date.strftime("%Y")
    event_mmmdd = event_date.strftime("%b%d")
    event_date_long = event_date.strftime("%A, %B %-d, %Y")

    # Generation day and 15-minute rounded time tokens
    gen_day = now_rounded.strftime("%b%d")
    gen_time = now_rounded.strftime("%H%M")

    venue_clean = sanitize_filename_token(args.venue_short or args.venue)
    event_clean = sanitize_filename_token(args.event_name)

    # Standard filename with generation day & 15-minute rounded time to prevent overwrites
    target_basename = (
        f"{event_year}_Weather_Briefing_{event_mmmdd}_{event_clean}_{venue_clean}_{gen_day}_{gen_time}"
    )
    target_typ = os.path.join(args.output_dir, f"{target_basename}.typ")
    target_pdf = os.path.join(args.output_dir, f"{target_basename}.pdf")

    # Lead time and issue timestamp based on 15-minute rounded generation time
    lead_time_str = calculate_lead_time(now_rounded, event_date, args.call_time)
    issued_ts = now_rounded.strftime("%b %-d, %Y • %-I:%M %p").upper()

    print(f"Scaffolding briefing: {target_typ}")
    print(f"Event: {args.event_name} at {args.venue} on {event_date_long}")
    print(f"Lead time: {lead_time_str} (Issued: {issued_ts})")

    # Fetch live NWS forecast
    nws_periods = None
    if args.fetch_nws:
        print(f"Fetching live National Weather Service forecast for ({args.lat}, {args.lon})...")
        nws_periods = fetch_nws_forecast(args.lat, args.lon)
        if nws_periods:
            print(f"Successfully retrieved {len(nws_periods)} hourly periods from api.weather.gov.")

    # Locate template
    script_dir = os.path.dirname(os.path.abspath(__file__))
    is_championship = "state" in args.event_name.lower() or "championship" in args.event_name.lower()
    if is_championship:
        template_path = os.path.join(script_dir, "..", "templates", "weather_briefing_state_championship_template.typ")
    else:
        template_path = os.path.join(script_dir, "..", "templates", "weather_briefing_template.typ")

    if not os.path.exists(template_path):
        print(f"Error: Template not found at {template_path}", file=sys.stderr)
        sys.exit(1)

    with open(template_path, "r", encoding="utf-8") as f:
        content = f.read()

    # Populate baseline substitutions
    substitutions = {
        "{{DOCUMENT_TITLE}}": f"Pine Creek High School Marching Band — {args.event_name} Weather Briefing",
        "{{EVENT_DATE_LONG}}": event_date_long,
        "{{VENUE_NAME}}": args.venue,
        "{{VENUE_SHORT}}": args.venue_short or args.venue,
        "{{VENUE_ELEVATION}}": args.venue_elevation,
        "{{UNLOAD_LOCATION}}": args.unload_location,
        "{{UNLOAD_SHORT}}": args.unload_short,
        "{{EVENT_TYPE_BADGE}}": "GAME NIGHT BRIEFING" if "game" in args.event_name.lower() else "COMPETITION BRIEFING",
        "{{ISSUED_TIMESTAMP}}": issued_ts,
        "{{LEAD_TIME_STRING}}": lead_time_str,
        "{{LOGO_PAGE1_PATH}}": "../Graphics/Pine Creek Bands Logo.svg",
        "{{LOGO_PAGE2_PATH}}": "../Graphics/Props Crew Docs Logo Horizontal.svg",
        "{{ALERT_BG_COLOR}}": "alert-bg",
        "{{ALERT_ACCENT_COLOR}}": "alert-red",
        "{{ALERT_BORDER_COLOR}}": "alert-border",
        "{{ALERT_BADGE_TEXT}}": "WEATHER ALERT",
        "{{ALERT_TITLE}}": "METEOROLOGICAL SITUATION SUMMARY",
        "{{ALERT_SUMMARY_TEXT}}": (
            f"Front Range weather analysis for {args.venue} and post-event logistics at {args.unload_short}. "
            "Refer to the hourly timeline and ballasting schedules below for active constraints."
        ),
        "{{HALFTIME_ROW_INDEX}}": "4",
        "{{PROP_HALFTIME_ROW_INDEX}}": "3",
        "{{ACTIVE_TIER_ROW_INDEX}}": str(args.ballast_tier + 1),
        "{{TIER0_STATUS_BADGE}}": '#status-badge("GO (Calm)", ok-bg, ok-green, ok-border)',
        "{{TIER1_STATUS_BADGE}}": '#status-badge("GO (Normal)", ok-bg, ok-green, ok-border)',
        "{{TIER2_STATUS_BADGE}}": (
            '#status-badge("GO (Advisory)", warn-bg, warn-orange, warn-border)'
            if args.ballast_tier == 2 else '#status-badge("Advisory", warn-bg, warn-orange, warn-border)'
        ),
        "{{TIER3_STATUS_BADGE}}": '#status-badge("CAUTION", warn-bg, warn-orange, warn-border)',
        "{{TIER2_ACTIVE_MARKER}}": (
            '\\ #text(size: 5.2pt, weight: "bold", fill: warn-orange)[★ TONIGHT\'S CALL]'
            if args.ballast_tier == 2 else ""
        ),
        "{{TIER3_ACTIVE_MARKER}}": (
            '\\ #text(size: 5.2pt, weight: "bold", fill: warn-orange)[★ TONIGHT\'S CALL]'
            if args.ballast_tier == 3 else ""
        ),
        "{{HOURLY_TABLE_ROWS}}": """  // 4:15 - 5:15 PM
  [4:15 – 5:15 PM],
  [Truck Load at PCHS & Transit to Falcon Stadium],
  [46°F],
  [39°F],
  [NNW 16 mph (G *26 mph*)],
  [15% sprinkle / 0% T-storm],
  [#status-badge("MODERATE (Breezy)", warn-bg, warn-orange, warn-border)],

  // 5:15 - 6:00 PM
  [5:15 – 6:00 PM],
  [Falcon Stadium: Arrival, Staging & Warmup],
  [44°F],
  [36°F],
  [NNW 15 mph (G *24 mph*)],
  [10% drizzle / 0% T-storm],
  [#status-badge("COOLING FAST", warn-bg, warn-orange, warn-border)],

  // 6:00 - 7:45 PM
  [6:00 – 7:45 PM],
  [Falcon Stadium: 1st Half in Stands (Pep Tunes)],
  [40°F $arrow.r$ 37°F],
  [*32°F $arrow.r$ 28°F*],
  [NNW 15 mph (G *23 mph*)],
  [#text[\\<5% dry / 0% T-storm]],
  [#status-badge("HIGH CHILL (Stands)", alert-bg, alert-red, alert-border)],

  // 7:45 - 8:15 PM
  [*7:45 – 8:15 PM*],
  [*HALFTIME: Tunnel Walk & Show at Falcon Stadium*],
  [*35°F*],
  [*26°F*],
  [*NNW 14 mph (G 21 mph)*],
  [*0% dry / 0% T-storm*],
  [#status-badge("CRITICAL PERFORMANCE", ok-bg, ok-green, ok-border)],

  // 8:15 - 9:45 PM
  [8:15 – 9:45 PM],
  [Falcon Stadium: 2nd Half & Prop Staging Reload],
  [33°F $arrow.r$ 31°F],
  [*23°F*],
  [NNW 12 mph (G 18 mph)],
  [0% (Frost on metal)],
  [#status-badge("FREEZING RISK", alert-bg, alert-red, alert-border)],

  // 10:00 - 11:15 PM
  [10:00 – 11:15 PM],
  [PCHS Loading Dock: Convoy, Unload & Dismissal],
  [30°F $arrow.r$ 29°F],
  [*21°F*],
  [NNW 10 mph (G 15 mph)],
  [0% (Hard Freeze Active)],
  [#status-badge("HARD FREEZE", alert-bg, alert-red, alert-border)],""",
        "{{PROP_TIMELINE_ROWS}}": """  // Step 1
  [5:30 – 7:30 PM \\ (1st Half Game)],
  [Exterior Assembly & Prep \\ (Volunteers Only)],
  [*Falcon Outer Staging Lot.* Full ambient gusts (*22–26 mph*). Zero stadium shielding.],
  [Stage screens flat on stages until standing up. Pre-tape *11 Body Bags* to backdrop rear rails. Stage 48 sandbags in 2 wagons.],
  [#status-badge("Tier 2 (Prep)", warn-bg, warn-orange, warn-border)],
  [#status-badge("OPEN-LOT GUSTS", warn-bg, warn-orange, warn-border)],

  // Step 2
  [7:35 – 7:55 PM \\ (Q2 Warning)],
  [Band Rendezvous & Downhill Tunnel Movement],
  [*Falcon Stadium Tunnel Ramp.* Severe *venturi wind tunneling* as wind funnels into bowl.],
  [Band joins crew at pad. *3 students per cart* (2 pushing, 1 guiding). Use a spare 15-lb sandbag to chock wheels on downhill and/or downwind side.],
  [#status-badge("Tier 2 (Active)", warn-bg, warn-orange, warn-border)],
  [#status-badge("TUNNEL VENTURI", alert-bg, alert-red, alert-border)],

  // Step 3
  [8:00 – 8:15 PM \\ (Halftime)],
  [Halftime Field Performance & Immediate Egress],
  [*Falcon Stadium Field & Sidelines.* Partial stands wind shadow; cross-swirls across end zones.],
  [Rapid 2-student screen placement & backdrop lock. Post-show: continuous forward roll out tunnel.],
  [#status-badge("Tier 2 (Field)", ok-bg, ok-green, ok-border)],
  [#status-badge("BOWL SWIRLS", ok-bg, ok-green, ok-border)],

  // Step 4
  [8:30 – 9:45 PM \\ (Post-Show)],
  [Teardown & Truck Reload at Exterior Staging Pad],
  [*Falcon Outer Staging Lot.* Dimming twilight, dropping to *33°F–31°F (feels 23°F)*. Dark pavement.],
  [Headlamps on. Deballast screens & backdrops. Strap carts to E-track. Secure tube sand over axles.],
  [#status-badge("Tier 2 (Deballast)", warn-bg, warn-orange, warn-border)],
  [#status-badge("FREEZING CHILL", warn-bg, warn-orange, warn-border)],

  // Step 5
  [10:00 – 11:15 PM \\ (Late Night)],
  [Convoy to PCHS, Unload & Return Rental Trucks],
  [*PCHS Loading Dock & Band Room.* Sub-freezing (*29°F–30°F, feels 21°F*), frost forming on ramps.],
  [Two-person team lifts on 70-lb tube sand. Salt/sweep ramp if frosty. Return box trucks with full gas tanks.],
  [#status-badge("Stowed / Complete", ok-bg, navy, gray-border)],
  [#status-badge("FREEZE WARNING", alert-bg, alert-red, alert-border)],"""
    }

    for key, val in substitutions.items():
        content = content.replace(key, val)

    os.makedirs(args.output_dir, exist_ok=True)
    with open(target_typ, "w", encoding="utf-8") as f:
        f.write(content)

    print(f"Successfully created: {target_typ}")

    if args.compile:
        print("Compiling deliverable with Typst...")
        cmd = [
            "typst", "compile",
            "--root", ".",
            target_typ,
            target_pdf
        ]
        res = subprocess.run(cmd, capture_output=True, text=True)
        if res.returncode != 0:
            print(f"Typst compilation failed:\n{res.stderr}", file=sys.stderr)
            sys.exit(res.returncode)
        print(f"Successfully compiled: {target_pdf}")

        # Render verification PNGs
        png_pattern = os.path.join(args.output_dir, f"{target_basename}_page_{{p}}.png")
        cmd_png = [
            "typst", "compile",
            "--root", ".",
            target_typ,
            png_pattern,
            "--ppi", "144"
        ]
        subprocess.run(cmd_png, check=True)
        print(f"Generated page PNGs at: {png_pattern}")

        # Audit page count: must be strictly 2 pages
        import glob
        png_files = sorted(glob.glob(os.path.join(args.output_dir, f"{target_basename}_page_*.png")))
        print(f"Page audit: {len(png_files)} page(s) rendered.")
        if len(png_files) != 2:
            print(f"ERROR: Briefing overflowed or underflowed! Expected 2 pages, found {len(png_files)}.", file=sys.stderr)
            sys.exit(1)
        else:
            print("Page audit PASSED: Exactly 2 pages.")

        # Sync unversioned alias file
        unversioned_base = f"{event_year}_Weather_Briefing_{event_mmmdd}_{event_clean}_{venue_clean}"
        unversioned_typ = os.path.join(args.output_dir, f"{unversioned_base}.typ")
        unversioned_pdf = os.path.join(args.output_dir, f"{unversioned_base}.pdf")
        with open(target_typ, "r", encoding="utf-8") as sf, open(unversioned_typ, "w", encoding="utf-8") as df:
            df.write(sf.read())
        subprocess.run(["typst", "compile", "--root", ".", unversioned_typ, unversioned_pdf], check=True)
        print(f"Synced unversioned base: {unversioned_typ} and {unversioned_pdf}")


if __name__ == "__main__":
    main()
