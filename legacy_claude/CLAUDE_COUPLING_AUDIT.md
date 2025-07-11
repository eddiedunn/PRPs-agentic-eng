# Claude Code Coupling Audit

Date: 2025-07-10

This document enumerates **all repository elements that are tightly coupled to the Claude Code (stateful, local CLI) paradigm**.  These items must be refactored, removed, or rewritten for a Codex-native, stateless container workflow.

---

## 1. Claude-specific Directories & Manifest Files

| Path | Purpose |
|------|---------|
| `.claude/` | Houses slash-command definitions, settings, and permission configuration designed for Claude Code. |
| `.claude/commands/` (6 domain folders) | 28+ pre-configured commands that appear only inside the Claude Code editor. |
| `claude_md_files/` | Framework-specific `CLAUDE-*.md` guidance documents (e.g., Python, Java, Rust). |
| `CLAUDE.md` | Top-level guidance file read automatically by Claude Code. References local commands and CLI usage patterns. |

## 2. Claude-centric Scripts & Runners

| File | Notes |
|------|-------|
| `PRPs/scripts/prp_runner.py` | Entrypoint script that shells out to `RUNNERS/claude_runner.py` and hard-codes `--model "claude"`. Relies on **local** CLI (`uv run`, `claude`) and interactive sessions. |
| (Referenced) `RUNNERS/claude_runner.py` | Mentioned in `prp_runner.py` but **absent** from the repo – indicates further coupling. |

## 3. Documentation & Administrative Guides

| File | Coupling Examples |
|------|------------------|
| `PRPs/ai_docs/cc_administration.md` | Entirely devoted to Claude Code IAM, hooks, and settings. |
| Many docs under `PRPs/ai_docs/` | Link to `claude-code` documentation pages, Bedrock/Vertex instructions, etc. |

## 4. Hard-coded Absolute Paths (macOS home dirs)

Located with `grep "/Users/"` – **cannot work inside Codex container**.

```
PRPs/pydantic-ai-prp-creation-agent-parallel.md:80  - file: /Users/rasmus/Projects/prp-spaces/dynamo-share/PRPs/templates/prp_base.md
PRPs/pydantic-ai-prp-creation-agent-parallel.md:83  - file: /Users/rasmus/Projects/prp-spaces/dynamo-share/PRPs/scripts/prp_runner.py
PRPs/pydantic-ai-prp-creation-agent-parallel.md:86  - file: /Users/rasmus/Projects/prp-spaces/dynamo-share/.claude/commands/create-base-prp-parallel.md
PRPs/pydantic-ai-prp-creation-agent-parallel.md:89  - file: /Users/rasmus/Projects/prp-spaces/dynamo-share/CLAUDE.md
PRPs/pydantic-ai-prp-creation-agent-parallel.md:92  - docfile: /Users/rasmus/Projects/prp-spaces/dynamo-share/PRPs/ai_docs/build_with_claude_code.md
PRPs/pydantic-ai-prp-creation-agent-parallel.md:95  - docfile: /Users/rasmus/Projects/prp-spaces/dynamo-share/PRPs/ai_docs/cc_mcp.md
```

## 5. Local Tooling & Shell Command Assumptions

Pattern search `uv run` (≈40 occurrences)

* Example lines:
  * `CLAUDE.md:38` – `uv run PRPs/scripts/prp_runner.py --prp [prp-name] --interactive`
  * `README.md:175` – `uv run PRPs/scripts/prp_runner.py --prp my-feature --interactive`
  * Numerous PRPs and Claude-specific markdown files (`CLAUDE-PYTHON-BASIC.md`, etc.)

These commands depend on the developer’s machine having **`uv`** and associated interpreters installed, which is outside Codex’s controlled container.

Additional likely tooling (quick scan not exhaustive): `gh`, `npx`, `ruff`, `mypy`, `pre-commit`, `uvicorn`, etc.

## 6. Keyword References to "claude" in Code & Docs

Over 400 matches (`grep -i claude`) across multiple markdown files, templates, and documentation, indicating pervasive brand-specific guidance.

## 7. Security / Permission Model Artifacts

* Settings files (`.claude/settings*.json`) – not presently in repo but referenced throughout docs.
* Sections on `allowedTools`, `apiKeyHelper`, and hooks in `cc_administration.md`.

---

### Coupling Summary

| Area | Migration Effort |
|------|-----------------|
| Runner Scripts | High – must be re-imagined as prompt instructions or removed entirely. |
| `.claude/commands` | High – UI concept irrelevant; extract *intent* into `AGENTS.md` or task templates. |
| Documentation (`CLAUDE*.md`) | Moderate to High – consolidate reusable philosophy, discard CLI specifics. |
| Absolute Paths | Low – straightforward removal; replace with relative references. |
| Tooling Calls (`uv run`, etc.) | Moderate – replace with container-native commands (bare `python`, `pytest`, etc.). |
| Security Docs | Moderate – rewrite toward Codex isolation model. |

---

## Next Steps

1. **Confirm audit completeness** – stakeholders review this file.
2. Begin **Phase 1 refactor**: decommission `prp_runner.py`, archive `.claude/` folder, and strip absolute paths.
3. Draft the new `AGENTS.md` consolidating philosophy and style.
