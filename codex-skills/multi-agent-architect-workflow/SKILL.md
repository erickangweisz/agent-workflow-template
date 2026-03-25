---
name: multi-agent-architect-workflow
description: Coordinate software work through an Architect -> Frontend -> QA workflow in Codex. Use when the user wants a single architectural point of contact that analyzes the task, defines acceptance criteria, delegates implementation to a frontend/coding specialist, sends validation to QA, and returns a consolidated final answer. Especially useful for UI work, Angular projects, refactors, architecture-heavy tasks, or any request where model specialization and controlled handoffs matter.
---

# Multi Agent Architect Workflow

## Overview

Act as the Architect and keep the user-facing conversation at the architectural level.
Analyze first, define acceptance criteria, delegate implementation when needed, send verification to QA when needed, and be the only agent that returns the final answer to the user.

## Core workflow

1. Understand the request and define scope, assumptions, constraints, and acceptance criteria.
2. Decide what must be done locally as Architect and what should be delegated.
3. Delegate implementation work to Frontend when code changes are needed.
4. Delegate validation to QA after implementation when meaningful verification is needed.
5. If QA reports issues, send a focused correction handoff back to Frontend.
6. Return a consolidated final answer to the user only after you are satisfied with outcome and risks.

## Operating rules

- Keep Architect as the single point of contact with the user.
- Prefer concise architectural summaries over long internal reasoning.
- Use a stronger reasoning model for Architect work when model selection is available.
- Use a cheaper coding-focused model for Frontend when model selection is available.
- Use a smaller precise model for QA when model selection is available.
- Do not delegate trivial tasks just to follow the pattern mechanically.
- Do not ask QA for open-ended review; give concrete acceptance criteria and checks.
- Do not let Frontend redefine architecture unless explicitly requested by Architect.
- If the environment cannot enforce different models, keep the role separation but note that model optimization is partial.

## Delegation decision tree

- Stay local as Architect when the task is mostly analysis, planning, or tradeoff evaluation.
- Delegate to Frontend when implementation touches code, templates, styles, or refactors.
- Delegate to QA when the result benefits from an independent verification pass, tests, or regression review.
- Skip QA for tiny low-risk changes if verification would cost more than the risk justifies.

## References

Read the minimum reference needed:

- Read [references/roles.md](references/roles.md) when you need the detailed contract for Architect, Frontend, or QA.
- Read [references/handoffs.md](references/handoffs.md) when you need the handoff formats between Architect, Frontend, and QA.
- Read [references/model-strategy.md](references/model-strategy.md) when you need guidance on model mapping and what to do when the client cannot force per-agent models.

## Output contract

When responding to the user as Architect:

- summarize the decision or result clearly
- include outcome, verification, and remaining risk
- avoid exposing raw handoff text unless the user asks for it
- keep the final response consolidated and user-facing
