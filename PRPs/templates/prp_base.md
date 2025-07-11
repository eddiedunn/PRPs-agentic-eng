name: "Base PRP Template v2 - Context-Rich with Validation Loops"
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

- Instruct Codex to read and analyze specific files for implementation patterns. For example: "Read `path/to/example.py` to understand how input validation is handled."
- Summarize any critical documentation, library gotchas, or project-specific quirks as actionable instructions. For example: "This project uses Pydantic v2 for all schemas; see `src/schemas/` for examples."
- Do not inject files or documentation directly. Instead, provide clear instructions on what to review and why.
### Current Codebase tree

- Instruct the agent to generate an overview of the codebase structure by analyzing the project root.

### Desired Codebase tree with files to be added and responsibility of file

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
```

## Validation Loop

After each implementation step, you must enter a validation loop. Follow these steps precisely:

1. **Execute the Full Test Suite:** Use the standard Python test runner to run all tests in the project.
2. **Analyze Output:** If any tests fail, carefully review the full error log to identify the root cause.
3. **Implement Fix:** Modify the code you have written to correct the issue.
4. **Run Security Scan:** Execute a security scan using `semgrep --config="p/default"`.
5. **Analyze Security Findings:** If the scan reports any medium or high-severity issues, you must analyze them and implement a fix before proceeding.
6. **Repeat:** Return to step 1 and re-run the tests and security scan. Do not proceed until all tests and the security scan pass with no unresolved issues.
7. **Final Verification:** Once all tests and security checks pass, confirm that the changes meet all acceptance criteria outlined in the 'What' section before concluding your work.
8. **Lint:** Ensure the codebase passes all linting checks using the project's standard linter.
def test_external_api_timeout():
    """Handles timeouts gracefully"""
    with mock.patch('external_api.call', side_effect=TimeoutError):
        result = new_feature("valid")
        assert result.status == "error"
        assert "timeout" in result.message
```

- For each new or modified feature, repeat the validation loop until all relevant tests pass. Never bypass or mock failures simply to achieve a passing state; always address the root cause.
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
