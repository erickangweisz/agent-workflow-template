$ErrorActionPreference = 'Stop'

$projectRoot = (Get-Location).Path
$bootstrapPath = Join-Path $projectRoot 'agents\bootstrap.md'

if (-not (Test-Path $bootstrapPath)) {
  $nestedBootstrap = Join-Path $projectRoot 'agents\agents\bootstrap.md'
  if (Test-Path $nestedBootstrap) {
    New-Item -ItemType Directory -Force (Join-Path $projectRoot 'agents') | Out-Null
    Get-ChildItem -Path (Join-Path $projectRoot 'agents\agents') -File | ForEach-Object {
      Move-Item -Force $_.FullName (Join-Path $projectRoot 'agents')
    }
    Remove-Item -Recurse -Force (Join-Path $projectRoot 'agents\agents')
  }
}

if (-not (Test-Path $bootstrapPath)) {
  Write-Error "No se encuentra agents/bootstrap.md en $projectRoot"
}

$bootstrap = Get-Content $bootstrapPath -Raw
$prompt = [regex]::Match($bootstrap, '(?s)```text\s*(.*?)\s*```').Groups[1].Value.Trim()
if (-not $prompt) {
  $prompt = $bootstrap.Trim()
}

$skillLine = 'Usa $multi-agent-architect-workflow.'
if ($prompt -notmatch '(?m)^\s*Usa \$multi-agent-architect-workflow\.') {
  $prompt = $skillLine + "`n`n" + $prompt
}

function Find-Codex {
  $cmd = Get-Command codex -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }

  $candidates = @(
    "$env:USERPROFILE\\AppData\\Local\\Programs\\Codex\\codex.exe",
    "$env:USERPROFILE\\.vscode\\extensions\\openai.chatgpt-*\\bin\\windows-x86_64\\codex.exe",
    "$env:USERPROFILE\\.vscode-insiders\\extensions\\openai.chatgpt-*\\bin\\windows-x86_64\\codex.exe"
  )

  foreach ($pattern in $candidates) {
    $match = Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue | Sort-Object FullName -Descending | Select-Object -First 1
    if ($match) { return $match.FullName }
  }

  return $null
}

$codex = Find-Codex
if (-not $codex) {
  Write-Warning 'No se ha encontrado codex.exe en esta maquina.'
  Write-Host 'Abre agents/bootstrap.md e inicia manualmente el flujo del Arquitecto.' -ForegroundColor Yellow
  exit 1
}

$args = @(
  '-m', 'gpt-5.4',
  '-s', 'workspace-write',
  '-a', 'on-request',
  '-C', $projectRoot,
  $prompt
)

Write-Host 'Workflow multiagente activado.' -ForegroundColor Green
Write-Host 'Arquitecto: gpt-5.4' -ForegroundColor Green
Write-Host 'Frontend: gpt-5.3-codex' -ForegroundColor Green
Write-Host 'QA: gpt-5.4-mini' -ForegroundColor Green
Write-Host ''
Write-Host 'Estas hablando con el Arquitecto.' -ForegroundColor Cyan
Write-Host "Proyecto: $projectRoot"
Write-Host "Codex: $codex"
Write-Host ''
Write-Host 'Escribe tu prompt aqui mismo. Esta terminal es la sesion.' -ForegroundColor Cyan
& $codex @args
