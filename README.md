# Agentic Engineering with Product Requirement Prompts (PRP) for OpenAI Codex

A comprehensive library of assets and prompt engineering patterns for building production-ready software with AI agents. This repository provides the **Product Requirement Prompt (PRP)** methodology, optimized for OpenAI's containerized **Codex** agent.

It is designed to be used as a template for new projects or to be integrated into existing ones.

## Core Concepts

### What is a PRP?

A Product Requirement Prompt (PRP) is a structured specification that supplies an AI coding agent with everything it needs to deliver a vertical slice of working software. It fuses the disciplined scope of a classic Product Requirements Document (PRD) with the context-rich, instructional nature required for modern, asynchronous AI agents.

A PRP contains three critical layers:
1.  **Context:** Instructions for the agent on what existing code patterns, documentation, and best practices to analyze.
2.  **Implementation Blueprint:** A clear, step-by-step plan for the agent to follow.
3.  **Validation Loop:** A mandate for the agent to autonomously run tests, analyze failures, and iterate until the code is correct.

### The Codex Workflow

This framework is designed for an asynchronous, plan-and-execute workflow with agents like OpenAI's Codex. The key steps are:
1.  **Initiate:** Provide a complete PRP as the initial prompt.
2.  **Review:** The agent returns a detailed execution plan. You must review, critique, and approve this plan before any code is written.
3.  **Authorize & Iterate:** The agent executes the approved plan. You review the results, and instruct the agent to debug and iterate until all validation steps pass.

The most important file for guiding the agent is **`AGENTS.md`**. It provides the base instructions for how the agent should operate within this framework.

## How to Use This Repository

You can use this framework for a brand new project or integrate its principles into an existing one.

### For a New (Greenfield) Project

Use this repository as a starting template for your new project.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Wirasm/PRPs-agentic-eng.git your-new-project
    cd your-new-project
    ```
2.  **Review `AGENTS.md`:** This is the most important file for guiding the AI. Read it and adapt its conventions to match your project's specific needs.
3.  **Explore the Examples:**
    *   `PRPs/examples/`: Contains complete, illustrative PRPs.
    *   `PRPs/agent_guidance_examples/`: Provides language-specific guidance documents (e.g., for Python, Rust, TypeScript) that you can adapt for your `AGENTS.md` file.
4.  **Start building your project:** You can now begin creating your source code, writing PRPs in the `PRPs/` directory using the provided templates, and working with the Codex agent.

### For an Existing (Brownfield) Project

Integrate the PRP methodology into your existing codebase by copying the essential components.

1.  **Create the PRP directory structure** in your project's root:
    ```bash
    mkdir -p PRPs/templates PRPs/examples PRPs/agent_guidance_examples
    ```
2.  **Copy the core templates and examples:**
    ```bash
    # From the cloned PRPs-agentic-eng repo:
    cp -r PRPs/templates/* path/to/your/project/PRPs/templates/
    cp -r PRPs/examples/* path/to/your/project/PRPs/examples/
    cp -r PRPs/agent_guidance_examples/* path/to/your/project/PRPs/agent_guidance_examples/
    ```
3.  **Copy and adapt the agent guidance file:** This is the most critical step.
    ```bash
    cp AGENTS.md path/to/your/project/
    ```
    - **Crucially, edit `AGENTS.md`** to reflect your project's specific architecture, conventions, and tooling. The provided file is a template; it will be most effective once it's tailored to your codebase. You can use the files in `PRPs/agent_guidance_examples` as inspiration.
4.  **Start writing PRPs** for new features or refactoring tasks in your project.

## The PRP Workflow in Practice

1.  **Create a PRP:** Copy a template from `PRPs/templates/` to a new file like `PRPs/my-feature.md`.
2.  **Fill it out:** Provide detailed context, implementation instructions, and validation loops as per the template's structure.
3.  **Initiate an Agent Session:** Provide the entire content of your PRP file as the initial prompt to the Codex agent.
4.  **Review the Plan:** Carefully scrutinize the agent's proposed execution plan.
5.  **Authorize & Supervise:** Once the plan is solid, give the agent the green light to proceed.
6.  **Iterate:** Review the agent's output. If tests fail, instruct the agent to analyze the failure and try again.

---

### ☕ Support This Work

**Found value in these resources?**

👉 **Buy me a coffee:** https://coff.ee/wirasm

I spent a considerable amount of time creating these resources and prompts. If you find value in this project, please consider buying me a coffee to support my work.

### 🎯 Transform Your Team with AI Engineering Workshops

**Ready to move beyond toy demos to production-ready AI systems?**

👉 **Book a workshop:** https://www.rasmuswiding.com/
