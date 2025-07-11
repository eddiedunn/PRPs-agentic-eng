Below is a repeatable recipe for **authoring a new Product Requirement Prompt (PRP)** with the materials in this repository. Treat it like a checklist you can copy-paste into your own workflow.

---

## 1 · Pick the right starting template

| When to use                                              | File                                                       | Why                                                              |
| -------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------------------- |
| Framing a whole feature or product idea (high-level PRD) | `PRPs/templates/prp_planning.md`                           | Captures user stories, diagrams, success metrics.                |
| Delivering a single vertical slice (code + tests)        | `PRPs/templates/prp_base.md` *or* `prp_base_typescript.md` | Already wired for Validation Loop and language-specific gotchas. |
| Breaking epic work into small Jira/GitHub tasks          | `PRPs/templates/prp_task.md`                               | Produces bite-sized, self-validating chores.                     |
| Writing a spec after research is done                    | `PRPs/templates/prp_spec.md`                               | Turns research into a concrete implementation spec.              |

> **Tip:** If you’re refactoring an existing codebase, use `PRPs/example-codex-refactor-rag.md` as scaffolding.

---

## 2 · Make a copy and name it

```bash
cp PRPs/templates/prp_base.md PRPs/2025-07-auth-service.md
```

* Use a date prefix for easy chronology (`YYYY-MM-topic.md`).
* Commit the blank file so it shows up in code review.

---

## 3 · Fill the template—section by section

1. **Goal / Why**
   *Write one sentence each:* “Add JWT-based auth to the API because enterprise customers require SSO.”

2. **What / Success Criteria**
   *Be testable:* “`POST /login` returns 200 with a signed token; 100 % branch coverage on auth module.”

3. **Security & Compliance (if using base template)**
   List explicit constraints—e.g., “Do **not** log raw JWTs.”

4. **All Needed Context**

   * Point Codex to specific files:
     `- Instruct Codex to read src/routers/user.py for existing patterns`
   * Call out quirks:
     `- CRITICAL: project uses FastAPI async endpoints`

5. **Current and Desired Codebase Trees**
   Use `tree -L 2` for the current state; sketch target folders/files.

6. **Implementation Blueprint**
   Bullet the high-level steps. Keep shell commands out; instead say *“Analyze pattern X, then move code Y.”*

7. **Validation Loop**
   Confirm it includes: **run tests → analyze failure → fix → lint**.

8. **Tasks (if using task template)**
   Write actionable blocks:

   ```yaml
   CREATE src/auth/jwt.py:
     - IMPLEMENT: sign(), verify()
     - VALIDATE: uv run pytest tests/auth -v
   ```

---

## 4 · Sanity-check against `AGENTS.md` rules

* No interactive questions.
* Each file < 500 lines, functions < 50 lines.
* Explicit validation commands (`pytest`, `ruff`, `mypy`, etc.).
* Security criteria present.

---

## 5 · Kick off a Codex session

1. Open ChatGPT (Codex container runtime).
2. Paste the *entire* PRP as the first message.
3. **Wait for the execution plan** (per `WORKFLOW_Codex.md`).
4. Review → iterate → approve.

---

## 6 · Track PRP history

After the slice ships:

```bash
mkdir -p PRPs/history
git mv PRPs/2025-07-auth-service.md PRPs/history/
```

This keeps a living “decision log” for new team members.

---

### Quick mnemonic — **G C P V**

1. **G**oal & Why
2. **C**ontext (files, quirks)
3. **P**lan (blueprint + tasks)
4. **V**alidation loop

If a PRP covers those four zones, Codex can run autonomously until the tests turn green. Happy prompting!
