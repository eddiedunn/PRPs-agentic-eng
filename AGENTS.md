# AGENTS.md – Master Guidance for AI Agents

*Last updated: 2025-07-10*

This document is the **single source of truth** for an AI agent working in this repository. It defines the core methodology, architectural principles, and language-specific conventions the agent MUST follow. It replaces all previous `CLAUDE.md` or language-specific guidance files.

---

## 1. Core Philosophy & Methodology

- **Role**: You are an autonomous software engineer. Your goal is to deliver production-ready, vertically-sliced features based on the provided Product Requirement Prompt (PRP).
- **Workflow**: You will operate in a plan-and-execute, asynchronous manner. A human will review your plan before you write code, and review your results before merging.
- **Self-contained PRPs:** Every Product Requirement Prompt (PRP) must specify all context (files to read, acceptance criteria, tests to run) so Codex can execute the task autonomously.
- **Explicit Instructions:** Avoid shell commands, file injections, or interactive Q&A. Instead, describe the reasoning steps and context-gathering the agent should perform (e.g., "Read and analyze `src/example.py` to understand the pattern.")
- **Validation-First Design:** Each PRP must include a validation loop—clear, iterative steps for Codex to test and fix its work until all requirements are met.
- **Information Density:** Use codebase-specific patterns, keywords, and gotchas. Reference relevant files and tests as instructions, not as direct context injections.
- **Progressive Success**: Start simple, validate, then enhance. Codex should iterate until all acceptance criteria are satisfied.

## 2. Prompt Structure (Codex-Native PRP Template)

A PRP will always follow this structure:

```markdown
# What
Describe the feature, bugfix, or refactor in clear terms.

# Why
Explain the business/user value and technical motivation.

# All Needed Context
- Instruct Codex to read specific files for patterns (e.g., "Read `src/feature_a.py` to mirror error handling.")
- Summarize critical documentation or gotchas (e.g., "This project uses Pydantic v2; see `src/schemas/` for examples.")

# Implementation Blueprint
- List high-level steps Codex should perform, referencing patterns and best practices from the codebase.

# Validation Loop
After each implementation step, you MUST:
1. **Run Tests:** Execute `python -m pytest tests/`.
2. **Analyze Failure:** If tests fail, read the full error output, identify the root cause, and modify the code to fix the issue. Do not proceed until you have a fix.
3. **Iterate:** Repeat steps 1 and 2 until all tests pass.
4. **Lint:** Ensure the codebase passes all linting checks (e.g., `ruff check .`).
5. **Final Verification:** Confirm that your changes meet all acceptance criteria outlined in the 'What' section before concluding your work.
```

## 3. Style, Anti-Patterns, and Language Conventions

### General Architectural Principles
- **Use relative paths** (e.g., `src/utils/time.py`), never absolute.
- **No interactive questions:** All context is provided up-front in the PRP. You must work with the information given.
- **Standard tools only:** Use `pytest`, `ruff`, `mypy`, `npm test`, etc. Do not reference project-specific CLI tools or shell commands.
- **No direct shell/file injection:** Always instruct Codex to "read and analyze" files, not to inject or import them.
- **Vertical Slice Architecture**: Organize code by features, not layers (e.g., `src/features/user_management/` contains its own handlers, models, and tests).
- **Keep It Simple (KISS)**: Choose straightforward solutions. Simple code is easier to understand, maintain, and debug.
- **Fail Fast**: Validate inputs at the earliest possible moment (e.g., at API boundaries with Pydantic, Zod) and throw descriptive errors.
- **Dependency Inversion**: High-level modules must not depend on low-level modules. Both should depend on abstractions (interfaces or protocols).

### Search Command Requirements
**CRITICAL**: Always use `rg` (ripgrep) instead of traditional `grep` and `find` commands.

```bash
# ❌ Don't use grep
grep -r "pattern" .

# ✅ Use rg instead
rg "pattern"

# ❌ Don't use find with name
find . -name "*.py"

# ✅ Use rg with file filtering
rg --files | rg "\.py$"
# or
rg --files -g "*.py"
```

### Python-Specific Conventions
- **Follow PEP8** with:
  - Line length: 100 characters
  - Double quotes for strings
  - Trailing commas in multi-line structures
- **Type hints:** Required for all functions and class attributes.
- **Format with `ruff format`.**
- **Use `pydantic` v2** for data validation.
- **Tests live next to code they test.**
- **Functions < 50 lines, Classes < 100 lines, Files < 500 lines.**
- **Google-style docstrings** for all public functions/classes.
- **Naming:** `snake_case` for functions/vars, `PascalCase` for classes, `UPPER_SNAKE_CASE` for constants.

### Anti-Patterns
- Do **not** use shell commands, direct file imports, or context injection syntax.
- Avoid interactive prompts—Codex cannot ask for clarification.
- Do **not** reference legacy Claude-specific tools or commands.

## 4. Legacy Notice

The following assets are for historical reference only and **should not be used** in Codex workflows:

| Asset | Replacement |
|-------|-------------|
| `legacy_claude/commands/` | Encode equivalent guidance as bullet points in PRP “Implementation Blueprint”. |
| `prp_runner_legacy.py` | Place runner logic directly in prompt instructions. |
| Markdown files under `claude_md_files/` | Migrate only reusable advice here. |

## 5. Security & Dependency Management

- **Python:** Declare dependencies in `pyproject.toml` (exact versions). Codex will use `pip install -r requirements.txt`.
- **Node:** Pin versions in `package.json` and use a lockfile.
- **No network:** Codex sandbox cannot access external services unless mocked.

---

> **Maintainers:**
> - Continue migrating key insights from `LEGACY_CLAUDE.md` & `claude_md_files/` into this file.
> - Keep this document concise; Codex’s context window is finite.
