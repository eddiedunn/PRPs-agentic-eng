---
Intended for Jira/GitHub tasks or other task management systems to break down and plan the implementation.
---

# Task Template v2 - Information Dense with Validation Loops

> Concise, executable tasks with embedded context and validation commands

## Format

```
[ACTION] path/to/file:
  - [OPERATION]: [DETAILS]
  - VALIDATE: [COMMAND]
  - IF_FAIL: [DEBUG_HINT]
```

## Actions keywords to use when creating tasks for concise and meaningful descriptions

- **READ**: Instruct the agent to analyze existing patterns in the codebase.
- **CREATE**: Direct the agent to generate a new file with specific content.
- **UPDATE**: Guide the agent to modify an existing file.
- **DELETE**: Specify that the agent should remove a file or code section.
- **FIND**: Ask the agent to search for patterns in the codebase.
- **TEST**: Require the agent to verify desired behavior through testing.
- **FIX**: Instruct the agent to debug and repair issues found during validation.

## Critical Context Section

- Instruct Codex to read and analyze relevant files for implementation patterns. For example: "Read `existing/example.py` to understand the model registration pattern."
- Summarize any critical documentation or gotchas as actionable instructions. For example: "Library X requires Y; always do Z first."
- Do not inject files or documentation directly—provide clear instructions on what to review and why.

## Task Examples with Validation

### Setup Tasks

```
READ src/config/py:
  - UNDERSTAND: Current configuration structure
  - FIND: Model configuration pattern
  - NOTE: Config uses pydantic BaseSettings

READ tests/test_models.py:
  - UNDERSTAND: Test pattern for models
  - FIND: Fixture setup approach
  - NOTE: Uses pytest-asyncio for async tests
```

### Implementation Tasks

````
UPDATE path/to/file:
  - FIND: MODEL_REGISTRY = {
  - ADD: "new-model": NewModelClass,
  - VALIDATE: Instruct the agent to verify that 'new-model' is present in MODEL_REGISTRY after the update.
  - IF_FAIL: If validation fails, the agent should check that NewModelClass is correctly imported and referenced.
CREATE path/to/file:
  - COPY_PATTERN: path/to/other/file
  - IMPLEMENT:
   - [Detailed description of what needs to be implemented based on codebase intelligence]
  - VALIDATE: python -m pytest path/to/file -v

UPDATE path/to/file:
  - FIND: app.include_router(
  - ADD_AFTER:
    ```python
    from .endpoints import new_model_router
    app.include_router(new_model_router, prefix="/api/v1")
    ```
  - VALIDATE: python -m pytest path/to/file -v
````

## Validation Loop

After each implementation step, the agent MUST perform the following validation:

1. **Run Tests:** Use the standard Python test runner to execute all tests in the project.
2. **Analyze Failure:** If any tests fail, do not stop. Carefully review the error output, identify the root cause, and modify the code to fix the issue.
3. **Iterate:** Repeat steps 1 and 2 until all tests pass.
4. **Final Verification:** Once all tests pass, confirm that the changes meet all acceptance criteria outlined in the 'What' section before concluding your work.
5. **Lint:** Ensure the codebase passes all linting checks using the project's standard linter.
## Debug Patterns

```
DEBUG import_error:
  - CHECK: File exists at path
  - CHECK: __init__.py in all parent dirs
  - TRY: python -c "import path/to/file"
  - FIX: Add to PYTHONPATH or fix import

DEBUG test_failure:
  - RUN: python -m pytest -vvs path/to/test.py::test_name
  - ADD: print(f"Debug: {variable}")
  - IDENTIFY: Assertion vs implementation issue
  - FIX: Update test or fix code

DEBUG api_error:
  - CHECK: Server running (ps aux | grep uvicorn)
  - TEST: Instruct the agent to verify the health endpoint is reachable and returns the expected response.
  - READ: If errors occur, direct the agent to analyze the server logs for stack traces and diagnose the problem.
  - FIX: The agent should implement a fix based on the specific error identified.```

## Common Task examples

### Add New Feature

```
1. READ existing similar feature
2. CREATE new feature file (COPY pattern)
3. UPDATE registry/router to include
4. CREATE tests for feature
5. TEST all tests pass
6. FIX any linting/type issues
7. TEST integration works
```

### Fix Bug

```
1. CREATE failing test that reproduces bug
2. TEST confirm test fails
3. READ relevant code to understand
4. UPDATE code with fix
5. TEST confirm test now passes
6. TEST no other tests broken
7. UPDATE changelog
```

### Refactor Code

```
1. TEST current tests pass (baseline)
2. CREATE new structure (don't delete old yet)
3. UPDATE one usage to new structure
4. TEST still passes
5. UPDATE remaining usages incrementally
6. DELETE old structure
7. TEST full suite passes
```

## Tips for Effective Tasks

- Use VALIDATE after every change
- Include IF_FAIL hints for common issues
- Reference specific line numbers or patterns
- Keep validation commands simple and fast
- Chain related tasks with clear dependencies
- Always include rollback/undo steps for risky changes
