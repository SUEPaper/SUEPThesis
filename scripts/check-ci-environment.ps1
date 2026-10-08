$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
Push-Location $repoRoot
try {
    foreach ($command in @('xetex','xelatex','lualatex','latexmk','bibtex','texlua','kpsewhich')) {
        Get-Command $command -ErrorAction Stop | Out-Null
    }
    $version = & xetex --version
    if ($LASTEXITCODE -ne 0 -or $version[0] -notmatch 'TeX Live 2026') {
        throw 'CI requires TeX Live 2026.'
    }
    Write-Output $version[0]
    $checkDir = Join-Path $repoRoot 'tmp/ci-environment'
    New-Item -ItemType Directory -Force $checkDir | Out-Null
    $source = @'
\documentclass{article}
\usepackage{fontspec}
\ExplSyntaxOn
\clist_map_inline:nn
  {SimSun,SimHei,KaiTi,FangSong,STFangsong,Times~New~Roman,
   Times~New~Roman~Bold,Times~New~Roman~Italic,Times~New~Roman~Bold~Italic}
  {\IfFontExistsTF{#1}{}{\PackageError{suep-ci}{Required~font~missing:~#1}{Install~the~named~font~for~the~runner~account.}}}
\ExplSyntaxOff
\begin{document}Font availability check.\end{document}
'@
    Set-Content -LiteralPath (Join-Path $checkDir 'fonts.tex') -Value $source -Encoding utf8
    Push-Location $checkDir
    try {
        foreach ($engine in @('xelatex','lualatex')) {
            & $engine -interaction=nonstopmode -halt-on-error -jobname="fonts-$engine" fonts.tex > "$engine-output.txt" 2>&1
            if ($LASTEXITCODE -ne 0) { throw "Required font check failed with $engine. See $checkDir/$engine-output.txt" }
        }
    } finally { Pop-Location }
    Write-Output 'PASS TeX Live and required fonts in both engines'
} finally { Pop-Location }
