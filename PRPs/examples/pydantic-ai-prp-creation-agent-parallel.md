name: "PRP Creation Agent using PydanticAI - Context-Rich Implementation"
description: |
  Comprehensive PRP for building an automated PRP creation agent using PydanticAI framework,
  leveraging parallel research capabilities and existing codebase patterns for maximum efficiency.

## Goal

Build a production-ready PRP creation agent using PydanticAI that can automatically generate comprehensive PRPs by:

- Analyzing user requirements and context
- Conducting parallel research (codebase analysis, external documentation, testing patterns)
- Generating structured PRPs following established templates
- Validating output quality and completeness
- Integrating with existing agentic engineering workflows

**End State**: A Python agent that takes a feature description as input and outputs a complete, validated PRP file ready for implementation.

## Why

- **Efficiency**: Reduce PRP creation time from manual hours to automated minutes
- **Consistency**: Ensure all PRPs follow established patterns and include necessary context
- **Quality**: Leverage AI capabilities for comprehensive research and validation
- **Scalability**: Enable rapid prototyping and feature development across teams

## What

### Core Functionality

- **Input Processing**: Parse natural language feature descriptions into structured requirements.
- **Parallel Research**: Simultaneously analyze codebase patterns, external documentation, and testing strategies.
- **PRP Generation**: Create comprehensive PRPs using established templates and discovered patterns.
- **Quality Validation**: Score and validate generated PRPs against quality metrics.
- **File Management**: Handle PRP file creation, organization, and versioning.

### Success Criteria

- [ ] Generate PRPs with 8+ quality score on all metrics (Context, Clarity, Validation, Success Probability).
- [ ] Complete PRP generation in under 2 minutes for standard features.
- [ ] 90%+ first-pass implementation success rate when the generated PRP is used by another agent.
- [ ] Full integration with this repository's validation gates (`ruff`, `mypy`, `pytest`).

## All Needed Context

### Documentation & References
- Instruct the agent to review the following resources for patterns and best practices.

```yaml
# MUST-READ: Instruct the agent to analyze these resources for patterns.
- url: https://ai.pydantic.dev/
  why: Core PydanticAI framework documentation and API reference.

- url: https://ai.pydantic.dev/agents/
  why: Agent creation patterns and best practices.

- url: https://github.com/pydantic/pydantic-ai
  why: Source code for implementation examples and issue tracking.

- file: PRPs/templates/prp_base.md
  why: To understand the established PRP template structure and validation patterns that the agent must generate.

- file: PRPs/agent_guidance_examples/CLAUDE-PYTHON-BASIC.md
  why: To understand project conventions, architecture patterns, and development standards for Python projects.
```

### Desired Codebase Tree

- Instruct the agent to create the following file and directory structure.

```bash
src/
├── prp_agent/
│   ├── __init__.py
│   ├── main.py                  # CLI entry point
│   ├── agent.py                 # Core PydanticAI agent
│   ├── tests/
│   │   ├── test_agent.py
│   │   ├── test_models.py
│   │   └── conftest.py
│   ├── models/
│   │   ├── __init__.py
│   │   ├── prp_models.py        # Pydantic models for PRP structure
│   │   ├── request_models.py    # Input validation models
│   │   └── tests/
│   │       └── test_models.py
│   ├── features/
│   │   ├── research_coordinator/
│   │   │   ├── coordinator.py   # Parallel research orchestration
│   │   │   └── tests/
│   │   │       └── test_coordinator.py
│   │   ├── prp_generator/
│   │   │   ├── generator.py     # PRP content generation
│   │   │   └── tests/
│   │   │       └── test_generator.py
│   │   └── quality_validator/
│   │       ├── validator.py     # Quality scoring and validation
│   │       └── tests/
│   │           └── test_validator.py
│   └── tools/
│       ├── __init__.py
│       ├── codebase_analyzer.py # Codebase pattern analysis
│       ├── documentation_fetcher.py # External documentation research
│       ├── file_manager.py      # PRP file operations
│       └── tests/
│           └── test_tools.py
```

### Known Gotchas & Library Quirks
- Instruct the agent to be aware of these critical implementation details.
```python
# CRITICAL: PydanticAI requires Python 3.9+
# CRITICAL: Set ALLOW_MODEL_REQUESTS = False in tests to prevent real API calls. Use TestModel() for fast testing.
# CRITICAL: All agent tool functions must be async and decorated with @agent.tool.
# CRITICAL: Pydantic v2 syntax must be used (e.g., Field() for validation).
# CRITICAL: All file operations must use absolute paths within the container's context.
# CRITICAL: Follow file size and function length limits defined in the project's Python agent guidance.
```

## Implementation Blueprint

- Instruct the agent to follow this plan step-by-step.

### Data Models and Structure
- Instruct the agent to create Pydantic models for all data structures to ensure type safety.
```python
# In src/prp_agent/models/prp_models.py
from pydantic import BaseModel, Field, HttpUrl
from typing import List, Optional, Dict, Any
from enum import Enum

class ResearchType(str, Enum):
    CODEBASE = "codebase"
    EXTERNAL = "external"
    TESTING = "testing"
    DOCUMENTATION = "documentation"

class PRPRequest(BaseModel):
    # Pydantic model for input validation
    feature_description: str = Field(..., min_length=10, max_length=1000)
    # ... other request fields

class ResearchResult(BaseModel):
    # Pydantic model for structured research findings
    research_type: ResearchType
    # ... other result fields

class PRPSection(BaseModel):
    # Pydantic model for an individual PRP section
    title: str
    content: str
    # ... other section fields

class PRPResult(BaseModel):
    # Pydantic model for the complete PRP output
    title: str
    sections: List[PRPSection]
    # ... other result fields

    def overall_quality_score(self) -> float:
        # Method to calculate overall quality
        # ... implementation
```

### Task List
- Instruct the agent to perform these tasks in order.
```yaml
- Task 1: Setup Project Structure. Create all necessary directories and `__init__.py` files. Create `prp_models.py` with all required Pydantic models and write corresponding tests in `test_models.py`.

- Task 2: Core Agent Implementation. Create `agent.py` and define the main PydanticAI agent, configuring its model provider and tools. Create placeholder tool files.

- Task 3: Parallel Research Coordination. Implement the `coordinator.py` to manage the execution of multiple research agents in parallel using `asyncio.gather`.

- Task 4: PRP Generation Engine. Implement the `generator.py` to construct the final PRP content by synthesizing research findings and adhering to the `prp_base.md` template.

- Task 5: Quality Validation System. Implement the `validator.py` to score generated PRPs based on the four key metrics: Context Richness, Implementation Clarity, Validation Completeness, and Success Probability.

- Task 6: CLI Interface. Create the `main.py` entry point to handle command-line arguments and orchestrate the agent's workflow.

- Task 7: Testing and Validation. Create a comprehensive test suite covering unit tests for all components, integration tests for the end-to-end PRP generation process, and performance benchmarks.
```

## Validation Loop
- Instruct the agent to run this validation loop after each major task.
1.  **Syntax & Style:** `ruff check . --fix` and `ruff format .`
2.  **Type Checking:** `mypy .`
3.  **Unit Tests:** `pytest`
4.  **Analysis:** If any step fails, analyze the error, fix the code, and repeat the loop until all checks pass.

### Final Validation Checklist
- [ ] All tests pass: `pytest`
- [ ] No linting or type errors: `ruff check .` and `mypy .`
- [ ] CLI interface is functional.
- [ ] Generated PRPs achieve a quality score of >= 8.0 on all metrics.
- [ ] Test coverage is >= 90%.
