#!/usr/bin/env python3
"""Universal Agentic Project Template Initializer (`init_project.py`).

Supports both interactive wizard mode and non-interactive CLI mode:
  python3 init_project.py --non-interactive --name "My-Project" --domain 1 --author "Your Name"
"""

from __future__ import annotations

import argparse
from pathlib import Path
import sys

DEFAULT_GITHUB_TEMPLATE_URL = "https://github.com/ericrowe/agentic-project-template.git"

DOMAIN_CHOICES = {
    "1": (
        "Pure Software Engineering",
        "Software Engineering",
        "Automated hermetic test suites (`./run_tests.sh`), API contracts, CI/CD pipelines, and zero-regression coverage ratchets.",
    ),
    "2": (
        "Physical Hardware & CAD Prototyping",
        "Hardware Prototyping",
        "Dual OpenSCAD (`.scad`) & Python CAD (`build123d`/STL) modeling, mesh manifoldness validation, and tolerance ladders.",
    ),
    "3": (
        "Algorithmic Trading & Quantitative Finance",
        "Algorithmic Trading",
        "Quantitative signal generation, backtesting, benchmark alpha outperformance mandates, and hard risk-manager guardrails.",
    ),
    "4": (
        "Cyber-Physical / Embedded / Hybrid",
        "Cyber-Physical Hybrid",
        "Integrated software stack with physical CAD enclosures, embedded firmware (`secrets.h` isolation), and hardware prototyping.",
    ),
}


def configure_template(
    root: Path,
    project_name: str,
    domain_key: str = "1",
    author: str = "Engineering Team",
    description: str = "AI-assisted engineering repository governed by the 5-step Plan Pipeline.",
) -> None:
    domain_title, domain_short, domain_focus = DOMAIN_CHOICES.get(domain_key, DOMAIN_CHOICES["1"])

    # 1. Update plan-pipeline.yaml
    manifest_path = root / "plan-pipeline.yaml"
    manifest_path.write_text(
        f"""{{
  "version": "1.0",
  "name": "{project_name}",
  "domain": "{domain_short}",
  "author": "{author}",
  "mode": "single-project",
  "plans_dir": "docs/plans",
  "prefix": "",
  "test_command": "./run_tests.sh",
  "template_repo": "{DEFAULT_GITHUB_TEMPLATE_URL}"
}}
""",
        encoding="utf-8",
    )

    # 2. Update AGENTS.md header
    agents_path = root / "AGENTS.md"
    if agents_path.exists():
        text = agents_path.read_text(encoding="utf-8")
        text = text.replace("Universal Agentic Project Template", project_name)
        text = text.replace(
            "{{PROJECT_DESCRIPTION}}",
            f"**Domain**: {domain_title} — {description}\n\n**Primary Engineering Focus**: {domain_focus}",
        )
        agents_path.write_text(text, encoding="utf-8")

    # 3. Update docs/plans/AGENTS.md header
    plans_agents = root / "docs" / "plans" / "AGENTS.md"
    if plans_agents.exists():
        ptext = plans_agents.read_text(encoding="utf-8")
        ptext = ptext.replace("Universal Agentic Project Template", project_name)
        plans_agents.write_text(ptext, encoding="utf-8")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Initialize the Universal Agentic Project Template.")
    parser.add_argument("--non-interactive", action="store_true", help="Run without interactive prompts")
    parser.add_argument("--name", default="My-Agentic-Project", help="Project name")
    parser.add_argument("--domain", default="1", choices=["1", "2", "3", "4"], help="Domain profile (1..4)")
    parser.add_argument("--author", default="Engineering Team", help="Author or organization")
    parser.add_argument(
        "--description",
        default="AI-assisted engineering project governed by the 5-step Plan Pipeline.",
        help="Short project description",
    )
    args = parser.parse_args(argv)
    root = Path(__file__).resolve().parent

    if args.non_interactive:
        configure_template(
            root=root,
            project_name=args.name,
            domain_key=args.domain,
            author=args.author,
            description=args.description,
        )
        print(f"Configured project '{args.name}' (domain={args.domain}).")
        return 0

    print("=" * 70)
    print("   UNIVERSAL AGENTIC PROJECT TEMPLATE INITIALIZER")
    print("=" * 70)
    project_name = input(f"Project Name [{args.name}]: ").strip() or args.name
    print("\nSelect Domain Profile:")
    for k, (title, _, _) in DOMAIN_CHOICES.items():
        print(f"  [{k}] {title}")
    domain_key = input(f"Domain [1-4, default={args.domain}]: ").strip() or args.domain
    author = input(f"Author [{args.author}]: ").strip() or args.author
    description = input(f"Description [{args.description}]: ").strip() or args.description

    configure_template(
        root=root,
        project_name=project_name,
        domain_key=domain_key,
        author=author,
        description=description,
    )
    print(f"\nSuccessfully initialized {project_name}!")
    return 0


if __name__ == "__main__":
    sys.exit(main())
