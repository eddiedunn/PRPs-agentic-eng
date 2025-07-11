# Agentic Engineering with Product Requirement Prompts (PRP) for OpenAI Codex

A comprehensive library of assets and prompt engineering patterns for building production-ready software with AI agents. This repository provides the **Product Requirement Prompt (PRP)** methodology, optimized for OpenAI's containerized **Codex** agent.

## What is a PRP for Codex?

A PRP is a structured specification that supplies an AI coding agent with everything it needs to deliver a vertical slice of working software. It fuses the disciplined scope of a classic Product Requirements Document (PRD) with the context-rich, instructional nature required for modern, asynchronous AI agents.

It contains three critical layers:
1.  **Context:** Instructions for the agent on what existing code patterns, documentation, and best practices to analyze.
2.  **Implementation Blueprint:** A clear, step-by-step plan for the agent to follow.
3.  **Validation Loop:** A mandate for the agent to autonomously run tests, analyze failures, and iterate until the code is correct.

## Getting Started

1.  **Clone this repository**:
    ```bash
    git clone https://github.com/Wirasm/PRPs-agentic-eng.git
    cd PRPs-agentic-eng
    ```
2.  **Review the Foundation:** The `AGENTS.md` file is the most important document. It provides the base instructions and constraints for the Codex agent.
3.  **Explore the Templates:** The `PRPs/templates/` directory contains the blueprints for writing effective PRPs. Start with `prp_base.md`.
4.  **Examine the Example:** See the refactored `PRPs/example-codex-refactor-rag.md` for a complete example of a PRP ready for Codex.

## How to Use This Framework

1.  **Create a new PRP** for your feature using a template from `PRPs/templates/`.
2.  **Fill out the PRP** with detailed context, implementation instructions, and validation loops.
3.  **Initiate a session** with the OpenAI Codex agent (e.g., via the ChatGPT interface).
4.  **Provide the entire PRP** as your initial prompt.
5.  **Review the agent's proposed execution plan.** Critique and refine it before giving approval.
6.  **Authorize the agent to proceed.** It will execute the plan asynchronously, including the validation loops.
7.  **Review the results** and continue the dialogue to iterate on the generated code.

## Legacy Framework

The original framework for the Anthropic Claude Code CLI has been archived in the `legacy_claude/` directory for historical reference. Those assets are not compatible with the current Codex workflow.
