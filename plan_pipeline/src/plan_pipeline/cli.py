"""
Command-Line Interface for `plan-pipeline`.
"""

import argparse
import json
from pathlib import Path
import sys
from typing import List, Optional

from .archiver import archive_plan, create_new_plan
from .scaffolder import init_project, sync_skills
from .schema import validate_plan_file
from .template_sync import (
    DEFAULT_GITHUB_TEMPLATE_REPO,
    DEFAULT_GITHUB_TEMPLATE_URL,
    export_template_repository,
    publish_template_to_github,
    pull_from_template_repository,
)
from .workspace import discover_workspace_status


def main(argv: Optional[List[str]] = None) -> int:
    parser = argparse.ArgumentParser(
        prog="plan-pipeline",
        description="Standardized 5-step plan-driven feature development CLI & validator.",
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    # 1. status
    p_status = subparsers.add_parser("status", help="Show active, proposed, queued, and archived plans across workspace")
    p_status.add_argument("--root", default=".", help="Workspace root directory")
    p_status.add_argument("--json", action="store_true", help="Output JSON")

    # 2. validate
    p_val = subparsers.add_parser("validate", help="Validate plan file(s) against 7 mandatory sections & relative links")
    p_val.add_argument("plans", nargs="*", help="Specific plan file paths to validate")
    p_val.add_argument("--all", action="store_true", help="Validate all active IN_PROGRESS/PROPOSED/ACTIVE plans")
    p_val.add_argument("--root", default=".", help="Workspace root directory")

    # 3. new
    p_new = subparsers.add_parser("new", help="Scaffold a new 7-section plan")
    p_new.add_argument("--plans-dir", default="docs/plans", help="Target docs/plans directory")
    p_new.add_argument("--id", required=True, help="Plan ID (e.g. 01, M45, S13)")
    p_new.add_argument("--slug", required=True, help="Short snake_case slug")
    p_new.add_argument("--title", required=True, help="Human-readable plan title")
    p_new.add_argument("--macro", action="store_true", help="Use '# Macro Plan' heading")

    # 4. archive
    p_arch = subparsers.add_parser("archive", help="Execute Step 5 archival & relative link re-anchoring")
    p_arch.add_argument("--plan", required=True, help="Path to the active plan markdown file")
    p_arch.add_argument("--date", default=None, help="Completion date YYYY-MM-DD (defaults to today)")
    p_arch.add_argument("--summary", action="append", default=[], help="Walkthrough summary bullet(s)")
    p_arch.add_argument("--test-cmd", default="./run_tests.sh", help="Automated test command")
    p_arch.add_argument("--test-result", default="100% pass rate", help="Automated test result summary")
    p_arch.add_argument("--stmt-cov", default="88%", help="Statement coverage percentage")
    p_arch.add_argument("--branch-cov", default="82%", help="Branch coverage percentage")

    # 5. init
    p_init = subparsers.add_parser("init", help="Initialize plan-pipeline in a project directory")
    p_init.add_argument("--path", default=".", help="Target repository directory")
    p_init.add_argument("--name", default=None, help="Project display name")

    # 6. sync-skills
    p_sync = subparsers.add_parser("sync-skills", help="Sync canonical plan-pipeline SKILL.md into .agents/skills/")
    p_sync.add_argument("--root", default=".", help="Workspace root directory")

    # 7. sync-template
    p_tmpl = subparsers.add_parser(
        "sync-template",
        help="Bidirectional sync with the GitHub Agentic Project Template repository",
    )
    p_tmpl.add_argument("--root", default=".", help="Workspace root directory")
    p_tmpl.add_argument("--export", default=None, help="Export standalone template repository to local directory")
    p_tmpl.add_argument("--pull", action="store_true", help="Pull latest universal skills and CLI from template")
    p_tmpl.add_argument(
        "--source",
        default=DEFAULT_GITHUB_TEMPLATE_URL,
        help="Template directory or Git URL for --pull",
    )
    p_tmpl.add_argument(
        "--push",
        action="store_true",
        help="Export, test, and push template repository to GitHub with is_template=true",
    )
    p_tmpl.add_argument(
        "--repo",
        default=DEFAULT_GITHUB_TEMPLATE_REPO,
        help="Target GitHub owner/repo slug for --push",
    )

    args = parser.parse_args(argv)

    if args.command == "status":
        root = Path(args.root).resolve()
        report = discover_workspace_status(root)
        if args.json:
            print(json.dumps(report, indent=2))
            return 0

        print(f"=== Plan Pipeline Status: {report['workspace']} ({report['mode']}) ===")
        root_info = report["root"]
        print(f"\n[Root ({root_info['plans_dir']})] — {root_info['archived_count']} archived")
        for p in root_info["active_plans"]:
            badge = "VALID" if p["valid"] else f"INVALID ({len(p['errors'])} errors)"
            print(f"  • {p['plan_id']:4s} [{p['status']:14s}] {p['title']} ({p['file']}) — {badge}")
        for sub_name, sub_info in report["subprojects"].items():
            print(f"\n[{sub_name} ({sub_info['plans_dir']})] — {sub_info['archived_count']} archived")
            for p in sub_info["active_plans"]:
                badge = "VALID" if p["valid"] else f"INVALID ({len(p['errors'])} errors)"
                print(f"  • {p['plan_id']:4s} [{p['status']:14s}] {p['title']} ({p['file']}) — {badge}")
        return 0

    if args.command == "validate":
        root = Path(args.root).resolve()
        targets: List[Path] = [Path(p).resolve() for p in args.plans]
        if args.all and not targets:
            report = discover_workspace_status(root)
            for p in report["root"]["active_plans"]:
                if p["status"] in ("IN_PROGRESS", "ACTIVE", "PROPOSED"):
                    targets.append(root / p["file"])
            for sub_info in report["subprojects"].values():
                for p in sub_info["active_plans"]:
                    if p["status"] in ("IN_PROGRESS", "ACTIVE", "PROPOSED"):
                        targets.append(root / p["file"])

        failures = 0
        for t in targets:
            res = validate_plan_file(t, workspace_root=root)
            if res.is_valid:
                print(f"✅ VALID: {t.relative_to(root) if t.is_relative_to(root) else t}")
            else:
                failures += 1
                print(f"❌ INVALID: {t.relative_to(root) if t.is_relative_to(root) else t}")
                for err in res.errors:
                    print(f"   - {err}")
        return 1 if failures > 0 else 0

    if args.command == "new":
        out = create_new_plan(
            plans_dir=Path(args.plans_dir),
            plan_id=args.id,
            slug=args.slug,
            title=args.title,
            is_macro=args.macro,
        )
        print(f"Created plan: {out}")
        return 0

    if args.command == "archive":
        res = archive_plan(
            plan_path=Path(args.plan),
            completion_date=args.date,
            summary_lines=args.summary or None,
            test_command=args.test_cmd,
            test_result_summary=args.test_result,
            statement_coverage=args.stmt_cov,
            branch_coverage=args.branch_cov,
        )
        print(f"Archived plan: {res.archived_plan_path}")
        print(f"Walkthrough:   {res.walkthrough_path}")
        return 0

    if args.command == "init":
        out_dir = init_project(Path(args.path), project_name=args.name)
        print(f"Initialized plan-pipeline in {out_dir}")
        return 0

    if args.command == "sync-skills":
        sync_skills(Path(args.root))
        print("Synchronized .agents/skills/plan-pipeline/SKILL.md")
        return 0

    if args.command == "sync-template":
        root = Path(args.root).resolve()
        if args.export:
            res = export_template_repository(root, Path(args.export))
            print(f"Exported template repository ({res['skills_exported']} universal skills) to {res['target_dir']}")
        if args.pull:
            res = pull_from_template_repository(root, args.source)
            print(f"Pulled {res['skills_synced']} universal skills and plan_pipeline package from {res['source']}")
        if args.push:
            res = publish_template_to_github(root, repo_slug=args.repo)
            print(
                f"Published GitHub Template Repository: {res['html_url']} "
                f"(is_template={res['is_template']}, skills={res['skills_exported']})"
            )
        return 0

    return 0


if __name__ == "__main__":
    sys.exit(main())
