# Agent Orchestration Template

Plantilla agnostica para trabajar con un flujo por roles:

- Arquitecto
- Frontend
- QA

Pensada para reutilizarse en:

- cualquier proyecto
- cualquier maquina
- VS Code
- Codex
- Copilot
- otros entornos con chat asistido

## Que resuelve

Permite trabajar con un flujo estable y repetible:

1. El Arquitecto analiza y habla con el usuario
2. El Frontend implementa
3. QA valida
4. El Arquitecto consolida y responde

Esto reduce improvisacion, mejora la calidad y hace el proceso exportable entre proyectos.

## Estructura

- `agents/architect.md`: rol del Arquitecto
- `agents/frontend.md`: rol del implementador Frontend
- `agents/qa.md`: rol del tester
- `agents/bootstrap.md`: arranque del flujo
- `agents/handoff-architect-to-frontend.md`: plantilla de delegacion a Frontend
- `agents/handoff-architect-to-qa.md`: plantilla de delegacion a QA
- `.vscode/tasks.json`: tareas reutilizables para VS Code
- `scripts/install-into-project.ps1`: script para copiar la plantilla a otro repo
- `examples/codex.md`: nota de integracion con Codex
- `examples/copilot.md`: nota de integracion con Copilot

## Integracion rapida en cualquier maquina

### Opcion 1. Usar esta plantilla como repo base

1. Clona este repo en tu maquina
2. Copia o instala la plantilla en tu proyecto destino
3. Abre el proyecto en VS Code
4. Usa el contenido de `agents/bootstrap.md` como punto de arranque del flujo

### Opcion 2. Instalarla dentro de otro proyecto

```powershell
powershell -ExecutionPolicy Bypass -File scripts/install-into-project.ps1 -TargetPath "C:\ruta\a\otro-proyecto"
```

Eso copia en el proyecto destino:

- `agents/`
- `.vscode/`
- `examples/`
- una copia del README como `AGENT_WORKFLOW_TEMPLATE.md`

## Flujo recomendado

1. Empieza siempre desde el Arquitecto
2. El Arquitecto define alcance y criterios de aceptacion
3. El Arquitecto delega en Frontend
4. El Arquitecto manda verificacion a QA
5. Si QA detecta problemas, vuelve a Frontend
6. El Arquitecto responde al usuario

## Modelos sugeridos

Si la herramienta permite elegir modelo por rol:

- Arquitecto: modelo fuerte de razonamiento
- Frontend: modelo coding-focused
- QA: modelo mini o coding-focused preciso

Ejemplo:

- Arquitecto: GPT-5.4
- Frontend: GPT-5.3-Codex
- QA: GPT-5.4-mini

## Integracion con herramientas

### Codex

Puede arrancarse una sesion nueva con el bootstrap del Arquitecto como prompt inicial.

### Copilot

No tiene el mismo concepto nativo de skill que Codex, pero esta plantilla se puede usar como base de prompts y handoffs.

## Recomendacion de mantenimiento

Mantener aqui una unica fuente de verdad para:

- roles
- bootstrap
- plantillas de handoff
- tareas y scripts de apoyo

Y luego crear adaptadores especificos por herramienta cuando haga falta.
