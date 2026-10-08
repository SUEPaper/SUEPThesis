param(
    [ValidateSet('all','bachelor','master','master-professional','doctor','doctor-professional','doc')]
    [string]$Target = 'all'
)
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
Push-Location $repoRoot
try {
    & xetex -interaction=nonstopmode -halt-on-error suepthesis.ins
    if ($LASTEXITCODE -ne 0) { throw 'DocStrip extraction failed.' }
    $profiles = [ordered]@{
        bachelor = @{Directory='undergraduate-thesis'; Entry='main.tex'}
        master = @{Directory='graduate-thesis'; Entry='main.tex'}
        'master-professional' = @{Directory='graduate-thesis'; Entry='main-professional.tex'}
        doctor = @{Directory='doctoral-thesis'; Entry='main.tex'}
        'doctor-professional' = @{Directory='doctoral-thesis'; Entry='main-professional.tex'}
    }
    foreach ($profile in $profiles.Keys) {
        if ($Target -eq 'all' -or $Target -eq $profile) {
            $exampleDir = Join-Path $repoRoot "templates/$($profiles[$profile].Directory)"
            Copy-Item -LiteralPath (Join-Path $repoRoot 'suepthesis.cls') -Destination $exampleDir
            Copy-Item -LiteralPath (Join-Path $repoRoot 'sueplogo.sty') -Destination $exampleDir
            Push-Location $exampleDir
            try {
                $job = [IO.Path]::GetFileNameWithoutExtension($profiles[$profile].Entry)
                if ((Test-Path -LiteralPath "$job.bbl") -and ((Get-Content -Raw -Encoding utf8 "$job.bbl") -match 'SUEPSampleBibliographyEntry')) {
                    foreach ($extension in @('bbl','aux','fdb_latexmk')) {
                        $generated = "$job.$extension"
                        if (Test-Path -LiteralPath $generated) { Remove-Item -LiteralPath $generated }
                    }
                }
                & latexmk -xelatex -interaction=nonstopmode -halt-on-error $profiles[$profile].Entry
                if ($LASTEXITCODE -ne 0) { throw "Compilation failed: $profile" }
            } finally { Pop-Location }
        }
    }
    if ($Target -eq 'all' -or $Target -eq 'doc') {
        & latexmk -xelatex -interaction=nonstopmode -halt-on-error suepthesis-doc.tex
        if ($LASTEXITCODE -ne 0) { throw 'Manual compilation failed.' }
    }
} finally { Pop-Location }
