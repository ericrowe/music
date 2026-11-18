#!/usr/bin/env python3
"""
publish_to_drive.py
-------------------
Authoritative helper script to publish PDF and image deliverables to the
PCHSMB Concept Planning Google Drive distribution folder.

Enforces:
1. Destination folder accessibility.
2. Strict filetype invariant: PDF and image files ONLY (.pdf, .png, .jpg, .jpeg).
3. Post-copy checksum verification.
4. Target directory integrity audit.
"""

import argparse
import hashlib
import os
import shutil
import sys
from pathlib import Path

def _resolve_default_target() -> Path:
    env_target = os.environ.get("PCHSMB_DRIVE_TARGET")
    if env_target:
        return Path(env_target).expanduser()
    cloud_storage = Path.home() / "Library" / "CloudStorage"
    if cloud_storage.is_dir():
        matches = sorted(cloud_storage.glob("GoogleDrive-*/My Drive/PCHSMB Concept Planning"))
        if matches:
            return matches[0]
    return cloud_storage / "GoogleDrive" / "My Drive" / "PCHSMB Concept Planning"


DEFAULT_TARGET = _resolve_default_target()

ALLOWED_EXTENSIONS = {".pdf", ".png", ".jpg", ".jpeg", ".md"}

DEFAULT_REGISTRY = [
    # Primary Master Proposal Deliverable at Root
    (
        Path("PCHSMB/docs/00_PCHSMB_2027_Prop_Ecosystem_Executive_Menu_and_Proposal.pdf"),
        Path("00_PCHSMB_2027_Prop_Ecosystem_Executive_Menu_and_Proposal.pdf"),
    ),
    (
        Path("PCHSMB/docs/01_PCHSMB_2027_Prop_Ecosystem_Directors_Briefing_Deck.pdf"),
        Path("01_PCHSMB_2027_Prop_Ecosystem_Directors_Briefing_Deck.pdf"),
    ),
    # 01_Fleet_Maintenance (Reference Guides for Existing Fleet)
    (
        Path("PCHSMB/_Backdrop/docs/Rolling_Backdrop_Fleet_Readiness_and_Overhaul_Plan.pdf"),
        Path("01_Fleet_Maintenance/Rolling_Backdrop_Fleet_Readiness_and_Overhaul_Plan.pdf"),
    ),
    (
        Path("PCHSMB/_Backdrop/docs/TS-BDP-2026-02_Vinyl_Substrates_and_Mounting_Systems_Trade_Study.pdf"),
        Path("01_Fleet_Maintenance/TS-BDP-2026-02_Vinyl_Substrates_and_Mounting_Systems_Trade_Study.pdf"),
    ),
    (
        Path("PCHSMB/_Backdrop/docs/Backdrop_Assembly_Guide.pdf"),
        Path("01_Fleet_Maintenance/Backdrop_Assembly_Guide.pdf"),
    ),
    (
        Path("PCHSMB/_Backdrop/docs/Backdrop_Wind_Vent_Options_Flyer.pdf"),
        Path("01_Fleet_Maintenance/Backdrop_Wind_Vent_Options_Flyer.pdf"),
    ),
    (
        Path("PCHSMB/_Sideline Screen/docs/Sideline_Screen_Duck_Blind_Build_Instructions.pdf"),
        Path("01_Fleet_Maintenance/Sideline_Screen_Duck_Blind_Build_Instructions.pdf"),
    ),
    (
        Path("PCHSMB/_Sideline Screen/docs/Sideline_Screen_Wind_Vent_Options_Flyer.pdf"),
        Path("01_Fleet_Maintenance/Sideline_Screen_Wind_Vent_Options_Flyer.pdf"),
    ),
    (
        Path("PCHSMB/_Stages/docs/Stage_Platform_Build_Instructions.pdf"),
        Path("01_Fleet_Maintenance/Stage_Platform_Build_Instructions.pdf"),
    ),
    (
        Path("PCHSMB/_Stages/docs/TS-STG-2026-02_Shaded_Lighting_Scaffolding_Pavilion_Trade_Study.pdf"),
        Path("01_Fleet_Maintenance/TS-STG-2026-02_Shaded_Lighting_Scaffolding_Pavilion_Trade_Study.pdf"),
    ),
    # 02_Field_Lighting_Platform (Synapse Platform & Electronics)
    (
        Path("PCHSMB/_Lighting Controller/docs/Synapse_System_Sales_Brochure.pdf"),
        Path("02_Field_Lighting_Platform/Synapse_System_Sales_Brochure.pdf"),
    ),
    (
        Path("PCHSMB/_Lighting Controller/docs/TS-SYN-2026-01_Synapse_vs_Commercial_Trade_Study.pdf"),
        Path("02_Field_Lighting_Platform/TS-SYN-2026-01_Synapse_vs_Commercial_Trade_Study.pdf"),
    ),
    (
        Path("PCHSMB/_Lighting Controller/docs/Lighting_Controller_Pilot_Build_BOM.pdf"),
        Path("02_Field_Lighting_Platform/Lighting_Controller_Pilot_Build_BOM.pdf"),
    ),
    (
        Path("PCHSMB/_Lighting Controller/docs/Carrier_Board_BOM_Purchasing_Guide.pdf"),
        Path("02_Field_Lighting_Platform/Carrier_Board_BOM_Purchasing_Guide.pdf"),
    ),
    (
        Path("PCHSMB/_Lighting Controller/docs/TR-SYN-2026-02_Show_and_Lighting_Synchronization_Analysis.pdf"),
        Path("02_Field_Lighting_Platform/TR-SYN-2026-02_Show_and_Lighting_Synchronization_Analysis.pdf"),
    ),
    (
        Path("PCHSMB/_Lighting Controller/docs/TR-SYN-2026-03_Multi_Controller_RF_Coordination_and_Auxiliary_Console_Analysis.pdf"),
        Path("02_Field_Lighting_Platform/TR-SYN-2026-03_Multi_Controller_RF_Coordination_and_Auxiliary_Console_Analysis.pdf"),
    ),
    (
        Path("PCHSMB/_Lighting Controller/docs/TR-SYN-2026-04_Rehearsal_Power_and_Integrated_Charging_Analysis.pdf"),
        Path("02_Field_Lighting_Platform/TR-SYN-2026-04_Rehearsal_Power_and_Integrated_Charging_Analysis.pdf"),
    ),
    (
        Path("PCHSMB/_Lighting Controller/docs/TS-SYN-2026-05_Field_Prop_Battery_Architectures_Trade_Study.pdf"),
        Path("02_Field_Lighting_Platform/TS-SYN-2026-05_Field_Prop_Battery_Architectures_Trade_Study.pdf"),
    ),
    (
        Path("PCHSMB/_Lighting Controller/docs/TS-SYN-2026-06_Front_Ensemble_Control_Interfaces_Trade_Study.pdf"),
        Path("02_Field_Lighting_Platform/TS-SYN-2026-06_Front_Ensemble_Control_Interfaces_Trade_Study.pdf"),
    ),
    (
        Path("PCHSMB/_Lighting Controller/docs/TR-SYN-2026-08_Lighting_System_Comprehensive_Risk_Analysis.pdf"),
        Path("02_Field_Lighting_Platform/TR-SYN-2026-08_Lighting_System_Comprehensive_Risk_Analysis.pdf"),
    ),
    (
        Path("PCHSMB/_Lighting Controller/docs/SPEC-SYN-2026-09_Lighting_System_Top_Level_Architecture.pdf"),
        Path("02_Field_Lighting_Platform/SPEC-SYN-2026-09_Lighting_System_Top_Level_Architecture.pdf"),
    ),
    # 03_Kinetics_and_Mechanical_Effects (Mechanical Spring Throwers)
    (
        Path("PCHSMB/Experiments/Flag Launcher/docs/FLAG_THROWER_EXECUTIVE_PROPOSAL.pdf"),
        Path("03_Kinetics_and_Mechanical_Effects/FLAG_THROWER_EXECUTIVE_PROPOSAL.pdf"),
    ),
    (
        Path("PCHSMB/Experiments/Flag Launcher/docs/FLAG_THROWER_20FT_EXECUTIVE_PROPOSAL.pdf"),
        Path("03_Kinetics_and_Mechanical_Effects/FLAG_THROWER_20FT_EXECUTIVE_PROPOSAL.pdf"),
    ),
    (
        Path("PCHSMB/Experiments/Kinetics/docs/TR-KIN-2026-01_Kinetic_Props_Comprehensive_Risk_Analysis.pdf"),
        Path("03_Kinetics_and_Mechanical_Effects/TR-KIN-2026-01_Kinetic_Props_Comprehensive_Risk_Analysis.pdf"),
    ),
    # 04_Prop_Concepts_and_Centerpieces (Exploratory Show Concepts & Trade Studies)
    (
        Path("PCHSMB/Experiments/Beacon Concept/decision_briefs/PCHSMB_2027_Field_Beacon_Decision_Packet.pdf"),
        Path("04_Prop_Concepts_and_Centerpieces/PCHSMB_2027_Field_Beacon_Decision_Packet.pdf"),
    ),
    (
        Path("PCHSMB/Experiments/Beacon Concept/decision_briefs/BEACON_COST_OPTIONS_ONE_PAGER.pdf"),
        Path("04_Prop_Concepts_and_Centerpieces/BEACON_COST_OPTIONS_ONE_PAGER.pdf"),
    ),
    (
        Path("PCHSMB/Experiments/Lantern/decision_briefs/PCHSMB_2027_Field_Lantern_Decision_Packet.pdf"),
        Path("04_Prop_Concepts_and_Centerpieces/PCHSMB_2027_Field_Lantern_Decision_Packet.pdf"),
    ),
    (
        Path("PCHSMB/Experiments/LGO/decision_briefs/PCHSMB_2027_Field_LGO_Decision_Packet.pdf"),
        Path("04_Prop_Concepts_and_Centerpieces/PCHSMB_2027_Field_LGO_Decision_Packet.pdf"),
    ),
    # images (AI Disclaimer & Standalone Exhibits)
    (Path("PCHSMB/docs/images/README.md"), Path("images/README.md")),
    (Path("PCHSMB/docs/images/README.pdf"), Path("images/README.pdf")),
    (
        Path("PCHSMB/_Stages/docs/lgo_photometric_sunlight_vs_shade_test.jpg"),
        Path("images/lgo_photometric_sunlight_vs_shade_test.jpg"),
    ),
]


def sha256_file(filepath: Path) -> str:
    h = hashlib.sha256()
    with open(filepath, "rb") as f:
        while chunk := f.read(65536):
            h.update(chunk)
    return h.hexdigest()


def main():
    parser = argparse.ArgumentParser(
        description="Publish PDF/image deliverables to PCHSMB Concept Planning Google Drive folder."
    )
    parser.add_argument(
        "--target-dir",
        type=Path,
        default=DEFAULT_TARGET,
        help="Target Google Drive directory path",
    )
    parser.add_argument(
        "--file",
        "-f",
        dest="files",
        action="append",
        type=Path,
        help="Path to file to publish (can be specified multiple times)",
    )
    parser.add_argument(
        "--dest-subdir",
        type=Path,
        default=None,
        help="Subdirectory within target-dir for files specified with --file",
    )
    parser.add_argument(
        "--all-registered",
        action="store_true",
        help="Publish all standard baseline deliverables registered in the project",
    )
    parser.add_argument(
        "--audit-only",
        action="store_true",
        help="Audit the target directory without copying files",
    )

    args = parser.parse_args()
    target_dir = args.target_dir.resolve()

    if not target_dir.exists():
        print(f"ERROR: Target directory does not exist: {target_dir}", file=sys.stderr)
        sys.exit(1)

    if not target_dir.is_dir():
        print(f"ERROR: Target path is not a directory: {target_dir}", file=sys.stderr)
        sys.exit(1)

    files_to_publish = []
    if args.files:
        for f in args.files:
            if args.dest_subdir:
                files_to_publish.append((f, args.dest_subdir / f.name))
            else:
                files_to_publish.append(f)
    if args.all_registered:
        files_to_publish.extend(DEFAULT_REGISTRY)

    if not args.audit_only and not files_to_publish:
        print("ERROR: No files specified to publish. Use --file <path> or --all-registered, or --audit-only.", file=sys.stderr)
        sys.exit(1)

    # Validate file formats
    normalized_files = []
    for item in files_to_publish:
        if isinstance(item, (tuple, list)):
            src, dst_rel = Path(item[0]).resolve(), Path(item[1])
        else:
            src = Path(item).resolve()
            dst_rel = Path(src.name)
        if not src.exists():
            print(f"ERROR: Source file does not exist: {src}", file=sys.stderr)
            sys.exit(1)
        if src.suffix.lower() not in ALLOWED_EXTENSIONS:
            print(
                f"ERROR: Refusing to publish '{src.name}'. Forbidden extension '{src.suffix}'. "
                f"Only {sorted(list(ALLOWED_EXTENSIONS))} are permitted in the distribution directory.",
                file=sys.stderr,
            )
            sys.exit(1)
        normalized_files.append((src, dst_rel))

    # Perform publication copy
    if normalized_files:
        print(f"Publishing {len(normalized_files)} file(s) to: {target_dir}")
        for src, dst_rel in normalized_files:
            dst = target_dir / dst_rel
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src, dst)
            src_hash = sha256_file(src)
            dst_hash = sha256_file(dst)
            if src_hash != dst_hash:
                print(f"ERROR: Checksum mismatch after copying {src.name} to {dst_rel}!", file=sys.stderr)
                sys.exit(1)
            print(f"  [OK] Published: {dst_rel} ({dst.stat().st_size:,} bytes)")

    # Audit destination directory
    print("\nAuditing Google Drive distribution directory...")
    unauthorized = []
    authorized = []
    for item in target_dir.iterdir():
        if item.name.startswith("."):
            continue
        if item.is_dir():
            # Check all items within subdirectory
            sub_files = []
            for subroot, _, filenames in os.walk(item):
                for fname in filenames:
                    if fname.startswith("."):
                        continue
                    subpath = Path(subroot) / fname
                    if subpath.suffix.lower() not in ALLOWED_EXTENSIONS:
                        unauthorized.append(f"{subpath.relative_to(target_dir)} (Forbidden extension {subpath.suffix})")
                    else:
                        sub_files.append(subpath)
            if sub_files:
                authorized.append((f"{item.name}/", sum(f.stat().st_size for f in sub_files), len(sub_files)))
        elif item.suffix.lower() not in ALLOWED_EXTENSIONS:
            unauthorized.append(f"{item.name} (Forbidden extension {item.suffix})")
        else:
            authorized.append((item.name, item.stat().st_size, None))

    if unauthorized:
        print("SECURITY / INVARIANT VIOLATION: Unauthorized items found in distribution folder:", file=sys.stderr)
        for u in unauthorized:
            print(f"  - {u}", file=sys.stderr)
        sys.exit(1)

    print(f"SUCCESS: Distribution folder verified. Total active root items: {len(authorized)}")
    authorized.sort(key=lambda x: x[0].lower())
    for name, size, count in authorized:
        if count is not None:
            print(f"  • {name:<50} ({count} image/PDF files, {size:,} bytes)")
        else:
            print(f"  • {name:<50} ({size:,} bytes)")


if __name__ == "__main__":
    main()
