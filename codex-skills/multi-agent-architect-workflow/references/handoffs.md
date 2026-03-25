# Handoffs

## Architect -> Frontend

Use this structure:

- Objective: what must be changed
- Constraints: repo conventions, files, non-goals
- Acceptance criteria: concrete checks for done
- Ownership: files/modules Frontend should touch

Example:

```text
Objective: Implement X behavior in the Angular page.
Constraints: Preserve existing UI patterns. Do not touch backend files.
Acceptance criteria:
- Condition A holds
- Condition B holds
Ownership:
- src/app/pages/example/example.component.ts
- src/app/pages/example/example.component.html
```

## Architect -> QA

Use this structure:

- Change summary: what Frontend changed
- Acceptance criteria: exact things to verify
- Checks to run: build/tests/manual checks
- Risks to watch: likely regressions or weak points

Example:

```text
Change summary: Reworked the player modal layout and loading state.
Acceptance criteria:
- Modal fits mobile viewport
- Background scroll is blocked when modal is open
Checks to run:
- npm run build
- Manual mobile verification
Risks to watch:
- topbar overlap
- image transition flicker
```

## QA -> Architect

Use this structure:

- Findings: ordered by severity, with file/behavior references when possible
- Verification run: commands/checks executed
- Residual risks: anything not fully covered
- Verdict: pass or needs-fix

## Architect -> User

Return a consolidated answer with:

- outcome
- verification
- remaining risk if any
- next step only if useful
