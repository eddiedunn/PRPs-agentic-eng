# Codex Agentic Workflow: Initiate, Review, Iterate

This document defines the new asynchronous, plan-and-execute workflow for using PRPs with OpenAI Codex or similar containerized agentic systems. It replaces the legacy CLI/REPL-based workflow with a robust, manager-in-the-loop orchestration model.

---

## 1. Initiate the Session
- Always begin by providing the complete, refactored PRP (job brief) as a single, initial prompt to the Codex agent.
- The PRP must be self-contained, with all context, requirements, and validation instructions embedded.

## 2. Review the Agent's Execution Plan
- The agent's first response should be a detailed, multi-step plan for implementation.
- **Do not accept a plan that dives directly into code.**
- As the human-in-the-loop, review the plan for completeness, logical order, and handling of edge cases.
- Provide feedback, ask clarifying questions, and require revisions until the plan is robust.

## 3. Authorize and Supervise Execution
- Once the plan is approved, explicitly instruct the agent to proceed with implementation.
- The agent will execute the plan asynchronously and return with results (code, test outputs, error logs, etc.).

## 4. Iterate on Results
- Review the agent's output after each phase.
- Direct the agent to analyze failures, debug, and propose fixes if tests or validation steps fail.
- Repeat the review-iterate loop until all acceptance criteria are met and all validations pass.
