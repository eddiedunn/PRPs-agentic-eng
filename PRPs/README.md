# The `PRPs` Directory

This directory contains all the assets related to the **Product Requirement Prompt (PRP)** methodology. A PRP is a structured specification that gives an AI agent all the context, instructions, and validation steps it needs to complete a software development task autonomously.

This directory is organized to help you find what you need quickly.

## Directory Structure

*   `PRPs/`
    *   `templates/`: Bare-bones templates for creating new PRPs. This is your starting point.
    *   `examples/`: Fully-realized, high-quality examples of PRPs for complex tasks. Use these for inspiration and to understand best practices.
    *   `agent_guidance_examples/`: A collection of language-specific agent guidance documents. These are not meant to be used directly but serve as excellent references when customizing your project's main `AGENTS.md` file.
    *   `history/` (you create this): An optional directory where you can move completed PRPs to maintain a historical record of development decisions.

## Key Files

-   **[prp_base.md](./templates/prp_base.md):** The standard template for most coding tasks. It's structured to provide context, an implementation plan, and a validation loop.
-   **[pydantic-ai-prp-creation-agent-parallel.md](./examples/pydantic-ai-prp-creation-agent-parallel.md):** A great example of a complex, real-world PRP.
-   **[agent-guidance-python-basic.md](./agent_guidance_examples/agent-guidance-python-basic.md):** An example of the detailed, language-specific rules you should incorporate into your root `AGENTS.md` file.

## How to Use

1.  Refer to the main project `README.md` and `USAGE_GUIDE.md` for the overall workflow.
2.  Copy a file from `templates/` to start a new PRP for your feature.
3.  Review `examples/` to see what a high-quality, complete PRP looks like.

# Product Requirement Prompt (PRP) Concept

"Over-specifying what to build while under-specifying the context, and how to build it, is why so many AI-driven coding attempts stall at 80%. A Product Requirement Prompt (PRP) fixes that by fusing the disciplined scope of a classic Product Requirements Document (PRD) with the “context-is-king” mindset of modern prompt engineering."

## What is a PRP?

Product Requirement Prompt (PRP)
A PRP is a structured prompt that supplies an AI coding agent with everything it needs to deliver a vertical slice of working software—no more, no less.

### How it differs from a PRD

A traditional PRD clarifies what the product must do and why customers need it, but deliberately avoids how it will be built.

A PRP keeps the goal and justification sections of a PRD yet adds three AI-critical layers:

### Context

- Precise file paths and content, library versions and library context, code snippets examples. LLMs generate higher-quality code when given direct, in-prompt references instead of broad descriptions. Usage of a ai_docs/ directory to pipe in library and other docs.

### Implementation Details and Strategy

- In contrast of a traditional PRD, a PRP explicitly states how the product will be built. This includes the use of API endpoints, test runners, or agent patterns (ReAct, Plan-and-Execute) to use. Usage of typehints, dependencies, architectural patterns and other tools to ensure the code is built correctly.

### Validation Gates

- Deterministic checks such as pytest, ruff, or static type passes “Shift-left” quality controls catch defects early and are cheaper than late re-work.
  Example: Each new funtion should be individaully tested, Validation gate = all tests pass.

### PRP Layer Why It Exists

- The PRP folder is used to prepare and pipe PRPs to the agentic coder.

## Why context is non-negotiable

Large-language-model outputs are bounded by their context window; irrelevant or missing context literally squeezes out useful tokens

The industry mantra “Garbage In → Garbage Out” applies doubly to prompt engineering and especially in agentic engineering: sloppy input yields brittle code

## In short

A PRP is PRD + curated codebase intelligence + agent/runbook—the minimum viable packet an AI needs to plausibly ship production-ready code on the first pass.

The PRP can be small and focusing on a single task or large and covering multiple tasks.
The true power of PRP is in the ability to chain tasks together in a PRP to build, self-validate and ship complex features.
