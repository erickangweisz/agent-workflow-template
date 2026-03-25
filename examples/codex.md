# Uso Con Codex

## Opcion recomendada

Si quieres automatizar el arranque en Codex, ejecuta la task del proyecto:

- `Agent Flow: Start Architect Session`

Esa task:

- localiza `codex.exe`
- lee `agents/bootstrap.md`
- abre una sesion nueva
- fuerza `gpt-5.4` para el Arquitecto

## Skill especifica de Codex

El repo incluye ademas una primera skill nativa de Codex en:

- `codex-skills/multi-agent-architect-workflow/`

Esa skill encapsula:

- el rol del Arquitecto
- el flujo Architect -> Frontend -> QA
- las reglas de handoff
- la estrategia de modelos cuando el cliente permite forzarlos

## Nota

La task y la skill sirven para Codex. No convierten una conversacion ya abierta en el panel lateral; abren o preparan una sesion nueva.
