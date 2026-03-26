param(
  [Parameter(Mandatory = $true)]
  [string]$TargetPath
)

$sourceRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$target = Resolve-Path $TargetPath -ErrorAction SilentlyContinue
if (-not $target) {
  New-Item -ItemType Directory -Force $TargetPath | Out-Null
  $target = Resolve-Path $TargetPath
}

if ($sourceRoot.Path -eq $target.Path) {
  Write-Error "El script se esta ejecutando desde el mismo proyecto destino. Ejecutalo desde el repo plantilla."
}

$targetRoot = $target.Path
$targetAgentRoot = Join-Path $targetRoot '.agent-workflow'

# Copy encapsulated folder contents (avoid nesting)
if (-not (Test-Path $targetAgentRoot)) {
  New-Item -ItemType Directory -Force $targetAgentRoot | Out-Null
}
Copy-Item -Recurse -Force (Join-Path $sourceRoot '*') $targetAgentRoot

# Ensure root .vscode/tasks.json exists
$rootVscode = Join-Path $targetRoot '.vscode'
if (-not (Test-Path $rootVscode)) {
  New-Item -ItemType Directory -Force $rootVscode | Out-Null
}
$rootTasks = Join-Path $rootVscode 'tasks.json'
$templateTasks = Join-Path $sourceRoot 'tasks.json'
if (Test-Path $templateTasks) {
  Copy-Item -Force $templateTasks $rootTasks
}

# Copy README as a single entry point (inside .agent-workflow)
$templateReadme = Join-Path (Split-Path $sourceRoot -Parent) 'README.md'
if (Test-Path $templateReadme) {
  Copy-Item $templateReadme (Join-Path $targetAgentRoot 'AGENT_WORKFLOW_TEMPLATE.md') -Force
}

# Fix accidental nesting if the script is run from the target or an existing bad state
# Fix accidental nesting for .agent-workflow/.agent-workflow (legacy)
$nestedAgentRoot = Join-Path $targetRoot '.agent-workflow\.agent-workflow'
if (Test-Path $nestedAgentRoot) {
  Get-ChildItem -Path $nestedAgentRoot -Force | ForEach-Object {
    Move-Item -Force $_.FullName $targetAgentRoot
  }
  Remove-Item -Recurse -Force $nestedAgentRoot
}

# Fix accidental nesting for .agent-workflow/agents/agents
$nestedAgents = Join-Path $targetAgentRoot 'agents\agents'
if (Test-Path $nestedAgents) {
  Get-ChildItem -Path $nestedAgents -File | ForEach-Object {
    Move-Item -Force $_.FullName (Join-Path $targetAgentRoot 'agents')
  }
  Remove-Item -Recurse -Force $nestedAgents
}

Write-Host ''
Write-Host 'Plantilla multiagente copiada en:' -ForegroundColor Green
Write-Host $target
Write-Host ''
Write-Host 'Si usas Codex en VS Code:' -ForegroundColor Cyan
Write-Host '- Ejecuta la task: Agent Flow: Start Architect Session'
Write-Host '- Esa task abre una nueva sesion de Codex forzando gpt-5.4 para el Arquitecto'
Write-Host ''
Write-Host 'Si usas Copilot u otra herramienta:' -ForegroundColor Cyan
Write-Host '- Usa agents/bootstrap.md como punto de entrada manual'
Write-Host '- El modelo no se puede forzar desde este repo si la herramienta no lo soporta'
Write-Host ''
