param(
  [Parameter(Mandatory = $true)]
  [string]$TargetPath
)

$script = Join-Path $PSScriptRoot '..\.agent-workflow\scripts\install-into-project.ps1'
if (-not (Test-Path $script)) {
  Write-Error "No se encuentra el instalador en .agent-workflow/scripts/install-into-project.ps1"
}

& $script -TargetPath $TargetPath
