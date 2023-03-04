$out_dir="out";
$pdf_mode = 5;

$xelatex = "xelatex -shell-escape -synctex=1";
$xdvipdfmx = "xdvipdfmx -q -E -o %D %O %S";

$bibtex_use = 1.5;

$clean_ext = "hd loe ptc run.xml synctex.gz thm xdv nav snm vrb";

@default_files=('main.tex')