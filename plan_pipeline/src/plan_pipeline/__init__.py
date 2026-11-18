"""
plan_pipeline: Standardized 5-step plan-driven feature development lifecycle,
7-section plan validator, Step 5 link-safe archiver, and multi-agent skill bundle.
"""

from .schema import PlanValidationResult, validate_plan_file
from .archiver import ArchiveResult, archive_plan, create_new_plan, rewrite_relative_links_for_complete_dir
from .scaffolder import init_project, sync_skills
from .template_sync import (
    DEFAULT_GITHUB_TEMPLATE_REPO,
    DEFAULT_GITHUB_TEMPLATE_URL,
    SERVER_RACK_ONLY_SKILLS,
    UNIVERSAL_SKILLS,
    export_template_repository,
    publish_template_to_github,
    pull_from_template_repository,
)
from .workspace import load_workspace_manifest, discover_workspace_status

__version__ = "1.0.0"

__all__ = [
    "PlanValidationResult",
    "validate_plan_file",
    "ArchiveResult",
    "archive_plan",
    "create_new_plan",
    "rewrite_relative_links_for_complete_dir",
    "init_project",
    "sync_skills",
    "DEFAULT_GITHUB_TEMPLATE_REPO",
    "DEFAULT_GITHUB_TEMPLATE_URL",
    "SERVER_RACK_ONLY_SKILLS",
    "UNIVERSAL_SKILLS",
    "export_template_repository",
    "publish_template_to_github",
    "pull_from_template_repository",
    "load_workspace_manifest",
    "discover_workspace_status",
]
