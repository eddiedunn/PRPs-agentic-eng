# Agentic Engineering with Product Requirement Prompts (PRP)

A framework for building production-ready software with AI agents.

This repository provides the **Product Requirement Prompt (PRP)** methodology, a structured approach to guide AI agents like OpenAI's Codex to write, validate, and deliver high-quality code. It is designed to be used as a template for new projects or integrated into existing ones.

## The Philosophy: Why PRPs?

Standard software requirements often fail AI agents because they specify *what* to build but omit the critical context of *how*. This leads to generic, brittle code that requires heavy rework.

A PRP closes this gap by providing three critical layers:

1.  **Context:** Instructions for the agent on what existing code patterns, documentation, and best practices to analyze.
2.  **Implementation Blueprint:** A clear, step-by-step plan for the agent to follow.
3.  **Validation Loop:** A mandate for the agent to autonomously run tests, lint, and analyze failures, iterating until the code is correct and meets quality standards.

This repository is optimized for the asynchronous, plan-and-execute workflow used by agents like **OpenAI Codex**. The core guidance for the agent is defined in `AGENTS.md`.

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

For a detailed, step-by-step guide on authoring and using PRPs, please see the **[USAGE_GUIDE.md](USAGE_GUIDE.md)**.

### For a New Project

Use this repository as a starting template.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Wirasm/PRPs-agentic-eng.git your-new-project
    cd your-new-project
    ```
2.  **Customize `AGENTS.md`:** This is the master blueprint for the AI. Adapt its conventions to match your project's specific needs, using `PRPs/agent_guidance_examples` for inspiration.
3.  **Start Building:** Begin creating your source code and use the templates in `PRPs/templates` to write PRPs for your features.

### For an Existing Project

1.  **Copy the PRP structure and `AGENTS.md`** into your project:
    ```bash
    # From a clone of this repository, copy the core assets:
    mkdir -p your-project/PRPs
    cp -r PRPs/templates PRPs/examples PRPs/agent_guidance_examples your-project/PRPs/
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
