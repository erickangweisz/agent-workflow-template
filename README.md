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

- `.agent-workflow/agents/`: roles y handoffs
- `.agent-workflow/scripts/`: scripts de arranque e instalacion
- `.agent-workflow/examples/`: notas de uso
- `.agent-workflow/tasks.json`: tareas VS Code (se copian a `.vscode/tasks.json`)
- `.vscode/tasks.json`: launcher minimo para VS Code
- `codex-skills/multi-agent-architect-workflow/`: skill especifica de Codex basada en esta plantilla

## Integracion rapida en cualquier maquina

### Opcion 1. Usar esta plantilla como repo base

1. Clona este repo en tu maquina
2. Copia o instala la plantilla en tu proyecto destino
3. Abre el proyecto en VS Code
4. Si usas Codex, ejecuta la task `Agent Flow: Start Architect Session`
5. Si usas Copilot u otra herramienta, usa `.agent-workflow/agents/bootstrap.md` como punto de entrada

### Opcion 2. Instalarla dentro de otro proyecto

```powershell
powershell -ExecutionPolicy Bypass -File scripts/install-into-project.ps1 -TargetPath "C:\ruta\a\otro-proyecto"
```

Importante: ejecuta el script desde el repo plantilla, no desde el proyecto destino.

Eso copia en el proyecto destino:

- `.agent-workflow/`
- `.vscode/tasks.json`
- una copia del README como `.agent-workflow/AGENT_WORKFLOW_TEMPLATE.md`

Sugerencia: si no quieres versionar esto en tu repo, añade `.agent-workflow/` a tu `.gitignore`.

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

Codex si permite forzar el modelo desde el arranque de una sesion nueva. Esta plantilla ya incluye una task para ello:

1. `Ctrl+Shift+P`
2. `Tasks: Run Task`
3. `Agent Flow: Start Architect Session`

Esa task:

- localiza `codex.exe`
- abre una sesion nueva
- carga el bootstrap del Arquitecto
- fuerza `gpt-5.4`

Nota: el forzado de modelo solo aplica a la sesion de terminal abierta por la task. El panel lateral no puede garantizar modelo.

Ademas, este repo ya incluye una primera skill de Codex en:

- `codex-skills/multi-agent-architect-workflow/`

Importante:

- esta automatizacion aplica a Codex
- arranca una sesion nueva
- no convierte automaticamente un chat ya abierto en el panel lateral

### Copilot

Copilot no expone el mismo mecanismo para forzar un modelo desde el propio repo o desde una task local de esta manera.

Por tanto, en Copilot esta plantilla sirve para:

- definir el flujo
- reutilizar roles
- reutilizar handoffs
- mantener prompts consistentes

Pero no puede garantizar por si sola el modelo exacto del Arquitecto. Si Copilot permite cambiarlo, eso tendra que hacerse desde la propia interfaz o configuracion de Copilot.

## Recomendacion de mantenimiento

Mantener aqui una unica fuente de verdad para:

- roles
- bootstrap
- plantillas de handoff
- tareas y scripts de apoyo
- skill especifica de Codex

Y luego crear adaptadores especificos por herramienta cuando haga falta.
