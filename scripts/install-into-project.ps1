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

$dirs = @(
  'agents',
  '.vscode',
  'examples',
  'scripts'
)

foreach ($dir in $dirs) {
  $src = Join-Path $sourceRoot $dir
  if (Test-Path $src) {
    Copy-Item $src (Join-Path $target $dir) -Recurse -Force
  }
}

Copy-Item (Join-Path $sourceRoot 'README.md') (Join-Path $target 'AGENT_WORKFLOW_TEMPLATE.md') -Force

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
