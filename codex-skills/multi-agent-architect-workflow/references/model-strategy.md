# Model Strategy

Preferred mapping when the client can choose models per role:

- Architect: GPT-5.4 or another strong reasoning model
- Frontend: GPT-5.3-Codex or another cheaper coding-focused model
- QA: GPT-5.4-mini or another precise smaller model

## When model forcing is available

Use the strongest model only for Architect work.
Use cheaper specialized models for Frontend and QA to reduce cost.

## When model forcing is not available

Keep the workflow anyway, but treat it as partial optimization:

- role separation still improves clarity
- handoffs still improve discipline
- model cost optimization is not guaranteed

If the environment cannot force models, note that limitation instead of pretending the mapping is enforced.

## Practical recommendation

Use Codex as the primary environment for the full workflow.
Treat Copilot and similar tools as compatible with the role structure, but not equivalent for model control.
