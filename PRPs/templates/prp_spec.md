_See AGENTS.md for Codex workflow_

# Specification Template (prompt inspired by IndyDevDan)

> Ingest the information from this file, implement the Low-Level Tasks, and generate the code that will satisfy the High and Mid-Level Objectives.

## High-Level Objective

- [High level goal goes here - what do you want to build?]

## Mid-Level Objective

- [List of mid-level objectives - what are the steps to achieve the high-level objective?]
- [Each objective should be concrete and measurable]
- [But not too detailed - save details for implementation notes]

## Implementation Notes

- [Important technical details - what are the important technical details?]
- [Dependencies and requirements - what are the dependencies and requirements?]
- [Coding standards to follow - what are the coding standards to follow?]
- [Other technical guidance - what are other technical guidance?]

## Context

### Beginning context

- Instruct Codex to review and analyze the files that exist at the start of the task. For example: "Review the following files to understand the current state: [list files]."

### Ending context

- Instruct Codex to ensure the following files exist and meet the requirements at the end of the task. For example: "Verify that these files are present and satisfy the objectives: [list files]."
## Low-Level Tasks

> Ordered from start to finish

1. [First task - what is the first task?]

```
What prompt would you run to complete this task?
What file do you want to CREATE or UPDATE?
What function do you want to CREATE or UPDATE?
What are details you want to add to drive the code changes?
```

2. [Second task - what is the second task?]

```
What prompt would you run to complete this task?
What file do you want to CREATE or UPDATE?
What function do you want to CREATE or UPDATE?
What are details you want to add to drive the code changes?
```

3. [Third task - what is the third task?]

```
What prompt would you run to complete this task?
What file do you want to CREATE or UPDATE?
What function do you want to CREATE or UPDATE?
What are details you want to add to drive the code changes?
```
