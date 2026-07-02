param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,

    [string]$Destination = ".."
)

$TemplateRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Target = Join-Path $Destination $ProjectName

if (Test-Path $Target) {
    Write-Error "Target already exists: $Target"
    exit 1
}

New-Item -ItemType Directory -Force -Path $Target | Out-Null
Get-ChildItem $TemplateRoot -Force | Where-Object { $_.Name -notin @('.git') } | ForEach-Object {
    Copy-Item $_.FullName -Destination $Target -Recurse -Force
}

Write-Host "Created project from template: $Target"
Write-Host "Next: open PROJECT_BRIEF.md and fill in the project details."
