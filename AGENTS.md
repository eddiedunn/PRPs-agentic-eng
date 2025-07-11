# AGENTS.md – Guidance for OpenAI Codex

*Last updated: 2025-07-10*

This file provides **Codex-native** instructions for working with this repository. It replaces the former `CLAUDE.md` and `.claude/commands` system that targeted the Claude Code IDE.

---

## 1. Core Philosophy & Methodology

- **Self-contained PRPs:** Every Product Requirement Prompt (PRP) must specify all context (files to read, acceptance criteria, tests to run) so Codex can execute the task autonomously.
- **Explicit Instructions:** Avoid shell commands, file injections, or interactive Q&A. Instead, describe the reasoning steps and context-gathering the agent should perform (e.g., “Read and analyze `src/example.py` to understand the pattern.”)
- **Validation-First Design:** Each PRP must include a validation loop—clear, iterative steps for Codex to test and fix its work until all requirements are met.
- **Information Density:** Use codebase-specific patterns, keywords, and gotchas. Reference relevant files and tests as instructions, not as direct context injections.
- **Progressive Success:** Start simple, validate, then enhance. Codex should iterate until all acceptance criteria are satisfied.

## 2. Prompt Structure (Codex-Native PRP Template)

```markdown
# What
Describe the feature, bugfix, or refactor in clear terms.

# Why
Explain the business/user value and technical motivation.

# All Needed Context
- Instruct Codex to read specific files for patterns (e.g., “Read `src/feature_a.py` to mirror error handling.”)
- Summarize critical documentation or gotchas (e.g., “This project uses Pydantic v2; see `src/schemas/` for examples.”)

# Implementation Blueprint
- List high-level steps Codex should perform, referencing patterns and best practices from the codebase.

# Validation Loop
After each implementation step, Codex MUST:
1. **Run Tests:** Execute `python -m pytest tests/`.
2. **Analyze Failure:** If tests fail, read the error output, identify the root cause, and modify the code to fix the issue.
3. **Iterate:** Repeat steps 1 and 2 until all tests pass.
4. **Final Verification:** Confirm that the changes meet all acceptance criteria outlined in the 'What' section before concluding.
5. **Lint:** Ensure `ruff check .` passes.
```

## 3. Style, Anti-Patterns, and Language Conventions

### General Principles
- **Use relative paths** (e.g., `src/utils/time.py`), never absolute.
- **No interactive questions:** All context must be provided up-front.
- **Standard tools only:** Use `pytest`, `ruff`, `mypy`, `npm test`, etc. Do not reference project-specific CLI tools or shell commands.
- **No direct shell/file injection:** Always instruct Codex to “read and analyze” files, not to inject or import them.

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
