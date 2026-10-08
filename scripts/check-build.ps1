param([string]$Python = 'python')
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$previousCache = $env:TEXMFCACHE
$previousVar = $env:TEXMFVAR
$mathSource = @'
\documentclass[@OPTIONS@,twoside=false,cjk-font=fandol]{suepthesis}
\SUEPSetup{info={title=数学字体检查,titleEn={Math Font Check},major=电气工程}}
\begin{document}
\mainmatter
\chapter{数学字体}[Math Fonts]
Inline: $x^{p^{q}}+1=y$.
\begin{equation}\label{eq:math}x^{p^{q}}+1=y\end{equation}
Symbols: $\symbfit{v},\symbf{A},\mathbb{R},\mathcal{F},\alpha,\leq,\infty$.
\begin{align}
f(x)&=\frac{x}{1+x},\label{eq:align}\\
g(x)&=\sqrt{x}+\sum_{i=1}^{n}i.\notag
\end{align}
\begin{equation}h(x)=\begin{cases}x,&x>0,\\0,&x\leq0.\end{cases}\end{equation}
式\eqref{eq:math}与式\eqref{eq:align}采用自动编号。
\ExplSyntaxOn
\hbox_set:Nn \l_tmpa_box {$x^{p^{q}}$}
\cs_new_protected:Npn \suep_check_math_size:nn #1#2
  {\dim_compare:nNnT {\dim_abs:n {#1 - #2}} > {0.03bp}
     {\errmessage{Math~font~size~does~not~match~the~common~degree~configuration}}}
\suep_check_math_size:nn {\fontdimen6\textfont\symoperators}{11.9bp}
\suep_check_math_size:nn {\fontdimen6\scriptfont\symoperators}{6.94bp}
\suep_check_math_size:nn {\fontdimen6\scriptscriptfont\symoperators}{4.96bp}
\iow_log:x {SUEP-MATH-FONT:~\fontname\textfont\symoperators}
\iow_log:n {SUEP-MATH-SIZES-PASS}
\ExplSyntaxOff
\end{document}
'@
Push-Location $repoRoot
try {
    New-Item -ItemType Directory -Force (Join-Path $repoRoot 'tmp') | Out-Null
    & (Join-Path $PSScriptRoot 'check-source.ps1') -Python $Python
    & (Join-Path $PSScriptRoot 'build.ps1') -Target all > (Join-Path $repoRoot 'tmp/check-build-output.txt') 2>&1
    foreach ($directory in @('undergraduate-thesis','graduate-thesis','doctoral-thesis')) {
        $entries = if ($directory -eq 'undergraduate-thesis') { @('main') } else { @('main','main-professional') }
        foreach ($entry in $entries) {
            $logPath = Join-Path $repoRoot "templates/$directory/$entry.log"
            $log = Get-Content -Raw -Encoding utf8 $logPath
            if ($log -notmatch 'Package: unicode-math ' -or $log -match 'Package: amssymb|Package: amsfonts|Overfull|undefined references|Missing character|LaTeX Font Warning|Empty bibliography') {
                throw "Example package/font/layout/reference check failed: $logPath"
            }
            $toc = Get-Content -Raw -Encoding utf8 (Join-Path $repoRoot "templates/$directory/$entry.toc")
            $aux = Get-Content -Raw -Encoding utf8 (Join-Path $repoRoot "templates/$directory/$entry.aux")
            if ($toc -notmatch '参考文献' -or $toc -notmatch '致谢' -or $aux -notmatch '\\newlabel\{eq:' -or $aux -notmatch '\\bibcite\{') {
                throw "Example structure/equation/bibliography check failed: $directory/$entry"
            }
        }
    }
    $manualLog = Get-Content -Raw -Encoding utf8 (Join-Path $repoRoot 'suepthesis-doc.log')
    if ($manualLog -match 'Overfull|Missing character|LaTeX Font Warning|undefined references') { throw 'Manual layout/font/reference check failed.' }
    Write-Output 'PASS five writing examples and handbook: compilation, Unicode maths, fonts and references'
    $env:TEXMFCACHE = (Join-Path $repoRoot 'tmp/check-build/cache').Replace('\','/')
    $env:TEXMFVAR = $env:TEXMFCACHE
    New-Item -ItemType Directory -Force $env:TEXMFCACHE | Out-Null
    & $Python (Join-Path $PSScriptRoot 'check_logo.py')
    if ($LASTEXITCODE -ne 0) { throw 'Vector logo and isolated cover checks failed.' }
    foreach ($engine in @('xelatex','lualatex')) {
        foreach ($font in @('auto','termes')) {
            foreach ($degree in @('bachelor','master','doctor')) {
                $name = "$engine-$font-$degree"
                $caseDir = Join-Path $repoRoot "tmp/check-build/$name"
                New-Item -ItemType Directory -Force $caseDir | Out-Null
                Copy-Item -LiteralPath (Join-Path $repoRoot 'suepthesis.cls') -Destination $caseDir
                Copy-Item -LiteralPath (Join-Path $repoRoot 'sueplogo.sty') -Destination $caseDir
                $caseSource = $mathSource.Replace('@OPTIONS@', "type=$degree,font=$font")
                Set-Content -LiteralPath (Join-Path $caseDir 'main.tex') -Value $caseSource -Encoding utf8
                Push-Location $caseDir
                try {
                    & latexmk "-$engine" -interaction=nonstopmode -halt-on-error main.tex > build-output.txt 2>&1
                    if ($LASTEXITCODE -ne 0) { throw "Math compilation failed: $caseDir/build-output.txt" }
                    $log = Get-Content -Raw -Encoding utf8 main.log
                    if ($log -notmatch 'SUEP-MATH-SIZES-PASS' -or $log -notmatch 'SUEP-MATH-FONT:[^\r\n]*TeX.?Gyre.?Termes.?Math' -or
                        $log -match 'Package: amssymb|Package: amsfonts|Overfull|undefined references|Missing character|LaTeX Font Warning') {
                        throw "Math font/size/symbol/reference check failed: $caseDir/main.log"
                    }
                    $aux = Get-Content -Raw -Encoding utf8 main.aux
                    if ($aux -notmatch '\\newlabel\{eq:math\}\{\{1-1\}' -or $aux -notmatch '\\newlabel\{eq:align\}\{\{1-2\}') {
                        throw "Math numbering check failed: $caseDir/main.aux"
                    }
                } finally { Pop-Location }
                Write-Output "PASS common math fonts/sizes, symbols and numbering: $name"
            }
        }
    }
} finally {
    Pop-Location
    $env:TEXMFCACHE = $previousCache
    $env:TEXMFVAR = $previousVar
}
