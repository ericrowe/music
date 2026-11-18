"""
Workspace Manifest Loader & Multi-Project Plan Status Discovery.
"""

import json
from pathlib import Path
import re
from typing import Any, Dict, List

from .schema import validate_plan_file


def load_workspace_manifest(manifest_path: Path) -> Dict[str, Any]:
    """
    Load `plan-pipeline.yaml` (supports both JSON-compatible YAML and standard flat/list YAML
    without requiring external dependencies, using PyYAML when available).
    """
    manifest_path = Path(manifest_path).resolve()
    raw_text = manifest_path.read_text(encoding="utf-8")
    try:
        import yaml  # type: ignore

        data = yaml.safe_load(raw_text)
        if isinstance(data, dict):
            return data
    except Exception:
        pass

    # Fallback: try JSON (valid YAML 1.2 subset) or minimal key-value parser
    try:
        return json.loads(raw_text)
    except Exception:
        result: Dict[str, Any] = {"subprojects": []}
        for line in raw_text.splitlines():
            s = line.strip()
            if not s or s.startswith("#"):
                continue
            if ":" in s and not s.startswith("-"):
                k, v = s.split(":", 1)
                val = v.strip().strip('"').strip("'")
                if val:
                    result[k.strip()] = val
        return result


def _discover_plans_in_dir(plans_dir: Path, workspace_root: Path) -> Dict[str, Any]:
    plans_dir = Path(plans_dir).resolve()
    active_plans: List[Dict[str, Any]] = []
    agents_md = plans_dir / "AGENTS.md"
    agents_text = agents_md.read_text(encoding="utf-8") if agents_md.exists() else ""

    if plans_dir.exists():
        for md_file in sorted(plans_dir.glob("*.md")):
            if md_file.name in ("AGENTS.md", "IDEAS.md", "README.md"):
                continue
            text = md_file.read_text(encoding="utf-8")
            m = re.search(r"^#\s+(?:Macro\s+)?Plan\s+([A-Z0-9-]+):\s+(.+)$", text, re.MULTILINE)
            plan_id = m.group(1).strip() if m else md_file.stem.split("_", 1)[0]
            title = m.group(2).strip() if m else md_file.stem

            # Check status in AGENTS.md if present
            status = "ACTIVE"
            for line in agents_text.splitlines():
                if md_file.name in line:
                    sm = re.search(
                        r"`(IN_PROGRESS|ACTIVE|PROPOSED|QUEUED|ON HOLD|BLOCKED_BY:[^`]+|SUPERSEDED[^`]*|CANCELLED)`",
                        line,
                    )
                    if sm:
                        status = sm.group(1)
                        break

            val = validate_plan_file(md_file, workspace_root=workspace_root)
            active_plans.append(
                {
                    "plan_id": plan_id,
                    "title": title,
                    "file": str(md_file.relative_to(workspace_root)),
                    "status": status,
                    "valid": val.is_valid,
                    "errors": val.errors,
                }
            )

    complete_dir = plans_dir / "complete"
    archived_count = 0
    if complete_dir.exists():
        archived_count = len(
            [p for p in complete_dir.glob("*.md") if not p.name.endswith("_walkthrough.md")]
        )

    return {
        "plans_dir": str(plans_dir.relative_to(workspace_root)),
        "active_plans": active_plans,
        "archived_count": archived_count,
    }


def discover_workspace_status(workspace_root: Path) -> Dict[str, Any]:
    """Discover all active, queued, and archived plans across root and all configured subprojects."""
    workspace_root = Path(workspace_root).resolve()
    manifest_path = workspace_root / "plan-pipeline.yaml"
    manifest = load_workspace_manifest(manifest_path) if manifest_path.exists() else {}

    root_plans_dir = workspace_root / manifest.get("plans_dir", "docs/plans")
    report: Dict[str, Any] = {
        "workspace": manifest.get("name", workspace_root.name),
        "mode": manifest.get("mode", "single-project"),
        "root": _discover_plans_in_dir(root_plans_dir, workspace_root),
        "subprojects": {},
    }

    for sub in manifest.get("subprojects", []):
        sub_name = sub["name"]
        sub_plans_dir = workspace_root / sub.get("plans_dir", f"{sub_name}/docs/plans")
        if sub_plans_dir.exists():
            report["subprojects"][sub_name] = _discover_plans_in_dir(sub_plans_dir, workspace_root)

    return report
