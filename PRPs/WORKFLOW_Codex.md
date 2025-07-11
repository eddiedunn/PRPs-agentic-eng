# Codex Agentic Workflow: Initiate, Review, Iterate

## Purpose
This document defines the new asynchronous, plan-and-execute workflow for using PRPs with OpenAI Codex or similar containerized agentic systems. It replaces the legacy CLI/REPL-based workflow with a robust, manager-in-the-loop orchestration model.

---

## 1. Initiate the Session
- Always begin by providing the complete, refactored PRP (job brief) as a single, initial prompt to the Codex agent.
- The PRP must be self-contained, with all context, requirements, and validation instructions embedded.

## 2. Review the Agent's Execution Plan
- The agent's first response should be a detailed, multi-step plan for implementation.
- **Do not accept a plan that dives directly into code.**
- As the human-in-the-loop, review the plan for:
  - Completeness and logical order
  - Consideration of edge cases and failure modes
  - Explicit handling of validation and iteration
- Provide feedback, ask clarifying questions, and require revisions until the plan is robust.

## 3. Authorize and Supervise Execution
- Once the plan is approved, explicitly instruct the agent to proceed with implementation.
- The agent will execute the plan asynchronously and return with results (code, test outputs, error logs, etc.).

## 4. Iterate on Results
- Review the agent's output after each phase.
- Direct the agent to analyze failures, debug, and propose fixes if tests or validation steps fail.
- Repeat the review-iterate loop until all acceptance criteria are met and all validations pass.

---

## Parallel and Orchestration Prompts
- When defining parallelizable work, instruct the Codex agent to:
  1. Define all parallel tasks up front, with clear objectives and outputs for each.
  2. Execute tasks in parallel (as supported by the orchestrator).
  3. Wait for all tasks to complete, then synthesize the results into a final deliverable.
- Avoid direct shell commands for task management; use declarative, agent-oriented instructions.

---

## Example Workflow Dialogue

1. **Initiate:**
   > "Here is the PRP for a new authentication feature. Please review and propose a detailed, step-by-step plan."

2. **Review:**
   > Agent returns a multi-step plan.
   > "That plan looks reasonable, but for Task 2, ensure you also account for potential race conditions. Update the plan and present it again."

3. **Authorize:**
   > "The plan is approved. Proceed with implementation."

4. **Iterate:**
   > "The tests for the payment module failed. Analyze the stack trace, identify the bug, and propose a fix."

---

## Key Principles
- **Declarative, not imperative:** Instruct the agent what to achieve, not how to run shell commands.
- **Autonomous validation:** The agent must execute validation loops and iterate until all criteria are satisfied.
- **Manager-in-the-loop:** Human review and approval are required at each major phase.
- **Self-contained briefs:** All context and requirements must be embedded in the initial PRP.

---

## Migration Checklist
- [x] PRP templates refactored for Codex (no host-specific commands)
- [x] Validation loops are explicit instructions, not code
- [x] Workflow documentation updated
- [ ] Parallel orchestration prompts refactored
