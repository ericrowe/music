from pathlib import Path
import sys
import unittest

REPO_ROOT = Path(__file__).resolve().parent.parent
PLAN_PIPELINE_SRC = REPO_ROOT / "plan_pipeline" / "src"
if str(PLAN_PIPELINE_SRC) not in sys.path:
    sys.path.insert(0, str(PLAN_PIPELINE_SRC))

from plan_pipeline.schema import validate_plan_file
from plan_pipeline.template_sync import UNIVERSAL_SKILLS
from plan_pipeline.workspace import discover_workspace_status


class TestTemplateIntegrity(unittest.TestCase):
    def test_all_universal_skills_present_and_valid(self):
        skills_dir = REPO_ROOT / ".agents" / "skills"
        for skill in UNIVERSAL_SKILLS:
            skill_md = skills_dir / skill / "SKILL.md"
            self.assertTrue(skill_md.is_file(), f"Missing skill: {skill}")
            content = skill_md.read_text(encoding="utf-8")
            self.assertTrue(content.startswith("---"), f"Missing YAML frontmatter in {skill}")
            self.assertIn("description:", content)

    def test_all_assistant_pointers_present(self):
        for pointer in (
            "AGENTS.md",
            "GEMINI.md",
            "CLAUDE.md",
            "CODEX.md",
            ".cursorrules",
            ".windsurfrules",
            ".github/copilot-instructions.md",
        ):
            p = REPO_ROOT / pointer
            self.assertTrue(p.is_file(), f"Missing pointer file: {pointer}")
            self.assertIn("AGENTS.md", p.read_text(encoding="utf-8"))

    def test_initial_plan_and_workspace_status_valid(self):
        plan_file = REPO_ROOT / "docs" / "plans" / "01_initial_architecture_plan.md"
        res = validate_plan_file(plan_file, workspace_root=REPO_ROOT)
        self.assertTrue(res.is_valid, f"Initial plan invalid: {res.errors}")

        status = discover_workspace_status(REPO_ROOT)
        self.assertGreaterEqual(len(status["root"]["active_plans"]), 1)


if __name__ == "__main__":
    unittest.main()
