param([string]$ReleaseTag = '', [string]$Python = 'python')
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
Push-Location $repoRoot
try {
    foreach ($script in Get-ChildItem -LiteralPath $PSScriptRoot -Filter '*.ps1') {
        $tokens = $null
        $parseErrors = $null
        [System.Management.Automation.Language.Parser]::ParseFile($script.FullName, [ref]$tokens, [ref]$parseErrors) | Out-Null
        if ($parseErrors.Count) { throw "PowerShell syntax error in $($script.Name): $parseErrors" }
    }
    & $Python (Join-Path $PSScriptRoot 'check_source.py') --tag $ReleaseTag
    if ($LASTEXITCODE -ne 0) { throw 'Source validation failed.' }
    Write-Output 'PASS source syntax, writing examples, version and original Word resources'
} finally { Pop-Location }
