# AGENTS.md – Guidance for OpenAI Codex

*Last updated: 2025-07-10*

This file provides **Codex-native** instructions for working with this repository. It replaces the former `CLAUDE.md` and `.claude/commands` system that targeted the Claude Code IDE.

---

## 1. Core Philosophy

1. **Self-contained PRPs** – Each Product Requirement Prompt (PRP) must include all context (files to read, acceptance criteria, tests to run) so a stateless Codex session can carry the task autonomously.
2. **Asynchronous Delegation** – Think of Codex as a remote engineer. Provide a complete job spec; do not rely on interactive Q&A.
3. **Container-first Mentality** – Assume execution happens inside the default Codex sandbox. Use relative paths, standard tooling (`python −m pytest`, `npm test`, etc.), and declare dependencies in `pyproject.toml` / `package.json`.

## 2. Interaction Model

Codex runs each prompt *once* and returns either code edits or a completion. Therefore:

1. Provide a clear **What & Why** (user story, acceptance criteria).
2. Include a **Implementation Blueprint / Plan** for Codex to follow.
3. Embed a **Validation Loop** so Codex knows how to test its work autonomously.

### Minimal PRP Skeleton

```markdown
# What
Brief description of the feature or bug-fix.

# Why
Business or user value.

# All Needed Context
- Read `src/…/existing_file.py` for pattern reference.
- Review tests in `tests/…`.

# Implementation Blueprint
1. Steps the agent should perform.

# Validation Loop
1. Run `python -m pytest tests/ -q`.
2. If failures, fix code and repeat.
3. Ensure lint passes: `ruff check .`.
```

## 3. Prompt Style & Conventions

| Guideline | Example |
|-----------|---------|
| **Commands vs. Instructions** | *Instead of* `!git status`, say: “Inspect repository status and ensure …”. |
| **Relative Paths Only** | `src/utils/time.py` **not** `/Users/alice/project/src/utils/time.py`. |
| **Standard Tools** | Use `pytest`, `npm test`, `go test`, etc. Avoid host-specific tools such as `uv`, `gh`, `brew`. |
| **No Interactive Questions** | Provide *all* context up-front; Codex cannot ask follow-ups. |

## 4. Legacy Notice

The following assets are kept for historical reference only and **should not be used** in Codex workflows:

| Asset | Replacement |
|-------|-------------|
| `legacy_claude/commands/` | Encode equivalent guidance as bullet points in PRP “Implementation Blueprint”. |
| `prp_runner_legacy.py` | Place the runner logic directly in the prompt instructions. |
| Markdown files under `claude_md_files/` | Review for reusable advice, then migrate key points here. |


## 5. Security & Dependency Management

1. Declare Python deps in `pyproject.toml`\*. Use **exact versions** for reproducibility.
2. Node projects: pin versions in `package.json` + lockfile.
3. Codex sandbox has no network. Ensure tests do not reach external services unless mocked.

\*This repo currently uses `uv` for local workflows. Codex will instead run `pip install -r requirements.txt` automatically.

---

> **Next steps for maintainers:**
> • Continue migrating content from `LEGACY_CLAUDE.md` & `claude_md_files/` into this file.
> • Keep this document concise; Codex context window is finite.
