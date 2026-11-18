#!/usr/bin/env python3
"""
Server Rack Workspace Wrapper for the Standalone `plan-pipeline` Package (`plan_pipeline/src`).
"""

from pathlib import Path
import sys

WORKSPACE_ROOT = Path(__file__).resolve().parent.parent
PLAN_PIPELINE_SRC = WORKSPACE_ROOT / "plan_pipeline" / "src"
if str(PLAN_PIPELINE_SRC) not in sys.path:
    sys.path.insert(0, str(PLAN_PIPELINE_SRC))

from plan_pipeline.cli import main  # noqa: E402

if __name__ == "__main__":
    sys.exit(main())
