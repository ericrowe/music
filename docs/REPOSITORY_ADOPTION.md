# Repository Adoption Guide (Cross-Agent System)

## Add the process to an existing repository

1. Copy the root `AGENTS.md` into the repository root. If one already exists,
   merge the document-development rules without discarding unrelated instructions.
2. Ensure the skill and helper scripts exist in the repository:
   - For **Google Gemini / Antigravity**: copy to `.agents/skills/develop-versioned-documents/`
   - For **OpenAI Codex**: copy to `.codex/skills/develop-versioned-documents/`
   - Maintain agent adapter files (`GEMINI.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, `.cursorrules`, `.windsurfrules`) pointing to `AGENTS.md`.
3. Keep `docs/DOCUMENT_DEVELOPMENT_PROCESS.md` as the complete standard and
   `docs/DOCUMENT_PROCESS_FLOW.md` as the quick operational view.
4. Commit the process files before starting a project so later document work can
   be traced to a fixed workflow revision.

## Multi-Project Host Repositories (Monorepos)

In an umbrella repository containing multiple independent fabrication, CAD, or accessory projects (such as `PCHSMB/_Backdrop`, `PCHSMB/_Sideline Screen`, `Trumpet/Mutes`, `Flutes/Double Flute Stand`), document development is decentralized:

1. **Autonomous Manifests:** Each subproject directory contains its own `project.json` and local `AGENTS.md`. Subprojects do not share build IDs (`D1`, `D2`, ...) or release numbers.
2. **Centralized Tooling:** All Python scripts live once in `.agents/skills/develop-versioned-documents/scripts/` (and `.codex/skills/...`) and accept `--project <relative-path>`.
3. **Subproject Layout Options:**
   - **Co-Located Layout (Recommended for single-manual components):**
     Initialize directly in the existing CAD directory (e.g. `--project "PCHSMB/_Backdrop"`).
     Source CAD (`.FCStd`), vectors (`.afdesign`), and slicing (`.3mf`) files reside alongside `documents/`, `qa/`, and `references/`.
   - **Subfolder Layout (For multi-manual or deeply nested components):**
     Initialize in a dedicated subfolder (e.g. `--project "PCHSMB/_Backdrop/docs"` or `--project "projects/backdrop-manual"`).

### Example: Initializing Documentation for `PCHSMB/_Backdrop`

```bash
python3 .agents/skills/develop-versioned-documents/scripts/init_document_project.py \
  --repo-root . \
  --project "PCHSMB/_Backdrop" \
  --title "PCHS Backdrop Build & Assembly Guide" \
  --document-stem PCHSMB_Backdrop_Build_Guide
```

This creates:
- `PCHSMB/_Backdrop/project.json` (starts at `D1`, `v0`)
- `PCHSMB/_Backdrop/AGENTS.md`, `GEMINI.md`, `CLAUDE.md` (isolated backdrop instructions)
- `PCHSMB/_Backdrop/documents/` (`working/`, `current/`, `builds/`, `releases/`)
- `PCHSMB/_Backdrop/references/` (`TECHNICAL_SPEC.md`, `FIGURE_STYLE.md`, `FIGURE_REGISTER.csv`)
- `PCHSMB/_Backdrop/qa/` (`reports/`, `renders/`, `baselines/`)

## Initialize a project from an unreleased review build

The canonical output filename is derived from `--document-stem` and remains
stable. An imported source may have an old version suffix; the controlled copy
will not.

```bash
python3 .agents/skills/develop-versioned-documents/scripts/init_document_project.py \
  --repo-root . \
  --project projects/example-manual \
  --title "Example Manual" \
  --document-stem Example_Manual \
  --base-docx /absolute/path/to/Example_Manual_v24.docx \
  --base-build D24 \
  --base-release v0 \
  --base-status manual_review_required
```
*(Note: Codex users may alternatively invoke `.codex/skills/develop-versioned-documents/scripts/...`)*

This creates `documents/current/Example_Manual.docx` and the immutable snapshot
`documents/builds/D24/Example_Manual.docx`.

If there is no document yet, omit the base arguments. After the first stable-
named DOCX passes its audit and all-page review, register it:

```bash
python3 .agents/skills/develop-versioned-documents/scripts/register_initial_build.py \
  projects/example-manual \
  /absolute/path/to/Example_Manual.docx \
  --build D1 \
  --audit-report projects/example-manual/qa/reports/D1-audit.json \
  --visual-review projects/example-manual/qa/reports/D1-visual.json \
  --summary "Created the initial illustrated assembly manual"
```

## Customize the project

Before the first edit:

1. Complete project `AGENTS.md` with audience, terminology, source priority,
   durable constraints, and exclusions.
2. Record controlling facts in `references/TECHNICAL_SPEC.md`.
3. Record the visual system in `references/FIGURE_STYLE.md`.
4. Complete `references/VERSION_HISTORY.md` if the project needs stricter labels.
5. Populate `references/FIGURE_REGISTER.csv`.
6. Verify the stable filename, current build, release, status, path, and digest in
   `project.json`.

## Begin a development build

```bash
python3 .agents/skills/develop-versioned-documents/scripts/start_build.py \
  projects/example-manual \
  --summary "Replace Figures 3 and 8 and preserve all other content"
```

Edit only `documents/working/Example_Manual.docx`. Update its D-number, visible
status, and version-history row inside the document.

## Publish for manual review

After rendering, auditing, comparing, and reviewing every page, transition the
candidate and publish it:

```bash
python3 .agents/skills/develop-versioned-documents/scripts/transition_status.py \
  projects/example-manual \
  --to manual_review_required \
  --note "All automated gates passed" \
  --audit-report projects/example-manual/qa/reports/D25-audit.json \
  --diff-report projects/example-manual/qa/reports/D25-diff.json \
  --visual-review projects/example-manual/qa/reports/D25-visual.json \
  --approve-diff

python3 .agents/skills/develop-versioned-documents/scripts/publish_review_build.py \
  projects/example-manual
```

The reviewer receives `Example_Manual.docx`; the D-number remains inside the
document and in its repository snapshot directory.

## Prepare the first public release

After manual approval, create a release-preparation build. The v1 summary is fixed:

```bash
python3 .agents/skills/develop-versioned-documents/scripts/start_build.py \
  projects/example-manual \
  --prepare-release \
  --summary "Initial release"
```

Compress all D-rows to the single v1 row, run release-candidate QA, and transition
to `release_candidate`. Then change the document marking to
`RELEASED — APPROVED FOR USE`, remove all
D-number text, rerun final QA, and publish:

```bash
python3 .agents/skills/develop-versioned-documents/scripts/release_document.py \
  projects/example-manual \
  --audit-report projects/example-manual/qa/reports/v1-audit.json \
  --diff-report projects/example-manual/qa/reports/v1-diff.json \
  --visual-review projects/example-manual/qa/reports/v1-visual.json \
  --approve-diff
```

The release snapshot is `documents/releases/v1/Example_Manual.docx`. Future
releases follow the same pattern with a one-line summary for each new release.

## Recommended repository policy

- Use Git LFS for large DOCX, raster, CAD, and long-lived render artifacts when
  ordinary Git growth is unreasonable.
- Keep immutable build and release snapshots; exclude only reproducible working
  files and render products under the documented retention policy.
- Use content hashes, repository commits, Library versions, ETags, or download
  URLs for cache control. Do not alter the stable document filename.
