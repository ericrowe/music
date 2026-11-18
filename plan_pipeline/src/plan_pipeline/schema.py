"""
Schema & Link Portability Validator for 7-Section Engineering Plans.
"""

from dataclasses import dataclass, field
from pathlib import Path
import re
from typing import List, Optional


MANDATORY_SECTIONS = [
    ("1. Goal Description", re.compile(r"^##\s+1\.\s+Goal\s+Description\b", re.MULTILINE | re.IGNORECASE)),
    (
        "2. Architecture & Workflow Diagram",
        re.compile(r"^##\s+2\.\s+Architecture\s*(?:&|and)\s*Workflow\s+Diagram\b", re.MULTILINE | re.IGNORECASE),
    ),
    (
        "3. Code Modifications",
        re.compile(r"^##\s+3\.\s+(?:Code|Hardware|Implementation)\b", re.MULTILINE | re.IGNORECASE),
    ),
    (
        "4. Test Updates & Specifications",
        re.compile(r"^##\s+4\.\s+Test\s+Updates\s*(?:&|and)\s*Specifications\b", re.MULTILINE | re.IGNORECASE),
    ),
    ("5. Documentation Updates", re.compile(r"^##\s+5\.\s+Documentation\s+Updates\b", re.MULTILINE | re.IGNORECASE)),
    ("6. Verification Plan", re.compile(r"^##\s+6\.\s+Verification\s+Plan\b", re.MULTILINE | re.IGNORECASE)),
]

TITLE_HEADER_RE = re.compile(r"^#\s+(?:Macro\s+)?Plan\s+[A-Z0-9-]+:\s+.+", re.MULTILINE)
MERMAID_BLOCK_RE = re.compile(r"```mermaid\s+[\s\S]+?```", re.MULTILINE)
FENCED_CODE_RE = re.compile(r"```[\s\S]*?```", re.MULTILINE)
INLINE_CODE_RE = re.compile(r"`[^`\n]+`")
MARKDOWN_LINK_RE = re.compile(r"(?<!!)\[([^\]]+)\]\(([^)]+)\)")

FORBIDDEN_PATH_PATTERNS = [
    ("/Volumes/", re.compile(r"/Volumes/[A-Za-z0-9_.\-/ ]+")),
    ("/Users/", re.compile(r"/Users/[A-Za-z0-9_.\-/]+")),
    ("/home/", re.compile(r"/home/(?!detour\b)[A-Za-z0-9_.\-/]+")),
    ("file:///", re.compile(r"file:///[A-Za-z0-9_.\-/]+")),
]


@dataclass
class PlanValidationResult:
    plan_path: Path
    is_valid: bool
    errors: List[str] = field(default_factory=list)
    warnings: List[str] = field(default_factory=list)


def _strip_code_spans_for_link_scan(markdown_text: str) -> str:
    """Remove fenced code blocks before scanning markdown hyperlinks."""
    return FENCED_CODE_RE.sub("", markdown_text)


def validate_plan_file(plan_path: Path, workspace_root: Optional[Path] = None) -> PlanValidationResult:
    """
    Validate a plan markdown document against:
    1. Top-level `# Plan <ID>: <Title>` or `# Macro Plan <ID>: <Title>` heading.
    2. All 6 numbered body sections (Sections 1..6, forming the 7 mandatory sections).
    3. At least one ```mermaid diagram block.
    4. Zero hardcoded local workstation paths (/Volumes/, /Users/, file:///).
    5. 100% of relative markdown links resolving to existing files on disk.
    """
    plan_path = Path(plan_path).resolve()
    errors: List[str] = []
    warnings: List[str] = []

    if not plan_path.exists():
        return PlanValidationResult(
            plan_path=plan_path,
            is_valid=False,
            errors=[f"Plan file does not exist: {plan_path}"],
        )

    text = plan_path.read_text(encoding="utf-8")

    # 1. Title header check
    if not TITLE_HEADER_RE.search(text):
        errors.append("Missing top-level '# Plan <ID>: <Title>' or '# Macro Plan <ID>: <Title>' heading.")

    # 2. Mandatory sections 1..6
    for label, pattern in MANDATORY_SECTIONS:
        if not pattern.search(text):
            errors.append(f"Missing mandatory section: '## {label}'")

    # 3. Mermaid diagram check
    if not MERMAID_BLOCK_RE.search(text):
        errors.append("Missing required Mermaid diagram block (```mermaid ... ```) in Section 2.")

    # 4. Forbidden hardcoded paths check
    for label, pattern in FORBIDDEN_PATH_PATTERNS:
        if pattern.search(text):
            errors.append(f"Contains forbidden hardcoded machine path pattern '{label}'.")

    # 5. Relative markdown link resolution check
    scannable = _strip_code_spans_for_link_scan(text)
    for match in MARKDOWN_LINK_RE.finditer(scannable):
        raw_target = match.group(2).strip()
        if not raw_target or raw_target.startswith(("#", "http://", "https://", "mailto:", "conversation://")):
            continue
        if raw_target.startswith("file://"):
            errors.append(f"Non-portable file:// URI link target: {raw_target}")
            continue
        target_path_str = raw_target.split("#", 1)[0].strip()
        if not target_path_str:
            continue
        candidate_paths = [
            (plan_path.parent / target_path_str).resolve(),
            (plan_path.parent.parent / target_path_str).resolve(),
        ]
        if workspace_root is not None:
            candidate_paths.append((Path(workspace_root).resolve() / target_path_str).resolve())
        if not any(c.exists() for c in candidate_paths):
            errors.append(f"Broken relative markdown link '{raw_target}' (resolved to {candidate_paths[0]})")

    return PlanValidationResult(
        plan_path=plan_path,
        is_valid=(len(errors) == 0),
        errors=errors,
        warnings=warnings,
    )
