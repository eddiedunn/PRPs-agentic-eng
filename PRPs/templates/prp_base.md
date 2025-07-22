name: "Base PRP Template - Context-Rich with Validation Loops"
description: |

## Purpose

Template optimized for AI agents to implement features with sufficient context and self-validation capabilities to achieve working code through iterative refinement.

## Core Principles

1. **Context is King**: Include ALL necessary documentation, examples, and caveats
2. **Validation Loops**: Provide executable tests/lints the AI can run and fix
3. **Information Dense**: Use keywords and patterns from the codebase
4. **Progressive Success**: Start simple, validate, then enhance

---

## Goal

[What needs to be built - be specific about the end state and desires]

## Why

- [Business value and user impact]
- [Integration with existing features]
- [Problems this solves and for whom]

## What

[User-visible behavior and technical requirements]

### Success Criteria

- [ ] [Specific measurable outcomes]

## Security & Compliance Requirements

- [List explicit security constraints for this feature. e.g., "All personally identifiable information (PII) must be encrypted at rest."]
- [Specify any compliance standards that must be met, like GDPR or HIPAA.]
- [Define any anti-patterns to avoid, e.g., "Do not use MD5 for hashing."]

## All Needed Context

- **CRITICAL**: You MUST follow all architectural and language-specific conventions defined in the root `AGENTS.md` file.
- Instruct Codex to read and analyze specific files for implementation patterns. For example: "Read `path/to/example.py` to understand how input validation is handled."
- Summarize any critical documentation, library gotchas, or project-specific quirks as actionable instructions. For example: "This project uses Pydantic v2 for all schemas; see `src/schemas/` for examples."
- Do not inject files or documentation directly. Instead, provide clear instructions on what to review and why.

### Current Codebase tree (run `tree` in the root of the project) to get an overview of the codebase

```bash

```

### Desired Codebase tree with files to be added and responsibility of file

```bash

```

### Known Gotchas of our codebase & Library Quirks

```python
# CRITICAL: [Library name] requires [specific setup]
# Example: FastAPI requires `async def` functions for endpoints
# Example: This ORM doesn't support batch inserts over 1000 records
# Example: We use pydantic v2 and

- Instruct the agent to define the desired codebase structure, specifying new files and their responsibilities.
### Known Gotchas of our codebase & Library Quirks

```python
# CRITICAL: [Library name] requires [specific setup]
# Example: FastAPI requires async functions for endpoints
# Example: This ORM doesn't support batch inserts over 1000 records
# Example: We use pydantic v2 and
```

## Implementation Blueprint

- List the high-level steps Codex should perform, referencing patterns and best practices from the codebase.
- For each step, specify what files to analyze, what patterns to follow, and any gotchas to watch for.
- Avoid direct shell commands or file injections—describe the reasoning process instead.

### Data models and structure

Create the core data models, we ensure type safety and consistency.

```python
Examples:
 - orm models
 - pydantic models
 - pydantic schemas
 - pydantic validators

```

### List of tasks to be completed to fulfill the PRP in the order they should be completed

```yaml
Task 1:
MODIFY src/existing_module.py:
  - FIND pattern: "class OldImplementation"
  - INJECT after line containing "def __init__"
  - PRESERVE existing method signatures

CREATE src/new_feature.py:
  - MIRROR pattern from: src/similar_feature.py
  - MODIFY class name and core logic
  - KEEP error handling pattern identical

...(...)

Task N:
...

```

### Per task pseudocode as needed added to each task

```python

# Task 1
# Pseudocode with CRITICAL details don't write entire code
async def new_feature(param: str) -> Result:
    # PATTERN: Always validate input first (see src/validators.py)
    validated = validate_input(param)  # raises ValidationError

    # GOTCHA: This library requires connection pooling
    async with get_connection() as conn:  # see src/db/pool.py
        # PATTERN: Use existing retry decorator
        @retry(attempts=3, backoff=exponential)
        async def _inner():
            # CRITICAL: API returns 429 if >10 req/sec
            await rate_limiter.acquire()
            return await external_api.call(validated)

        result = await _inner()

    # PATTERN: Standardized response format
    return format_response(result)  # see src/utils/responses.py
```

### Integration Points

```yaml
DATABASE:
  - migration: "Add column 'feature_enabled' to users table"
  - index: "CREATE INDEX idx_feature_lookup ON users(feature_id)"

CONFIG:
  - add to: config/settings.py
  - pattern: "FEATURE_TIMEOUT = int(os.getenv('FEATURE_TIMEOUT', '30'))"

ROUTES:
  - add to: src/api/routes.py
  - pattern: "router.include_router(feature_router, prefix='/feature')"

### Data models and structure

Create the core data models, we ensure type safety and consistency.

```python
Examples:
 - orm models
 - pydantic models
 - pydantic schemas
 - pydantic validators

```

### List of tasks to be completed to fulfill the PRP in the order they should be completed

```yaml
Task 1:
MODIFY src/existing_module.py:
  - FIND pattern: "class OldImplementation"
  - INJECT after line containing "def __init__"
  - PRESERVE existing method signatures

CREATE src/new_feature.py:
  - MIRROR pattern from: src/similar_feature.py
  - MODIFY class name and core logic
  - KEEP error handling pattern identical

...(...)

Task N:
...

```

### Per task pseudocode as needed added to each task

```python

# Task 1
# Pseudocode with CRITICAL details don't write entire code
async def new_feature(param: str) -> Result:
    # PATTERN: Always validate input first (see src/validators.py)
    validated = validate_input(param)  # raises ValidationError

    # GOTCHA: This library requires connection pooling
    async with get_connection() as conn:  # see src/db/pool.py
        # PATTERN: Use existing retry decorator
        @retry(attempts=3, backoff=exponential)
        async def _inner():
            # CRITICAL: API returns 429 if >10 req/sec
            await rate_limiter.acquire()
            return await external_api.call(validated)

        result = await _inner()

    # PATTERN: Standardized response format
    return format_response(result)  # see src/utils/responses.py
```

### Integration Points

```yaml
DATABASE:
  - migration: "Add column 'feature_enabled' to users table"
  - index: "CREATE INDEX idx_feature_lookup ON users(feature_id)"

CONFIG:
  - add to: config/settings.py
  - pattern: "FEATURE_TIMEOUT = int(os.getenv('FEATURE_TIMEOUT', '30'))"

ROUTES:
  - add to: src/api/routes.py
  - pattern: "router.include_router(feature_router, prefix='/feature')"
```

## Validation Loop

After each implementation step, you must enter a validation loop. Follow these steps precisely:

1.  **Run Linting and Type Checking:** Execute the project's linting and type-checking scripts (e.g., `npm run lint`, `npm run type-check`).
2.  **Run Tests:** Execute the full test suite (`npm test`).
3.  **Analyze Failure:** If any validation step fails, read the error output, identify the root cause, and modify the code to fix the issue.
4.  **Iterate:** Repeat the validation steps until all checks pass.
5.  **Final Verification:** Confirm that the changes meet all acceptance criteria outlined in the 'What' section before concluding your work.

### Level 3: Integration Test

- To validate integration, instruct the agent to start the service in development mode and test the relevant endpoint using a suitable HTTP request. The agent should verify that the response matches the expected output and, if errors occur, analyze the application logs to diagnose the problem.
### Level 4: Deployment & Creative Validation

- Perform creative or advanced validation relevant to the feature, such as load testing with realistic data, end-to-end user journey testing, performance benchmarking, security scanning, or documentation validation. Specify any custom validation methods required for this feature.
## Final Validation Checklist

- [ ] All tests pass (run the project's full test suite)
- [ ] No linting errors (run the project's standard linter)
- [ ] No type errors (run the project's type checker)
- [ ] Manual testing of endpoints or features is successful (describe the expected result)
- [ ] Error cases are handled gracefully
- [ ] Security requirements from the "Security & Compliance" section are met.
- [ ] Logs are informative but not verbose
- [ ] Documentation is updated if needed
---

## Anti-Patterns to Avoid

- ❌ Don't create new patterns when existing ones work
- ❌ Don't skip validation because "it should work"
- ❌ Don't ignore failing tests - fix them
- ❌ Don't use sync functions in async context
- ❌ Don't hardcode values that should be config
- ❌ Don't catch all exceptions - be specific
