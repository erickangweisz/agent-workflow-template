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

$dirs = @(
  'agents',
  '.vscode',
  'examples'
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
