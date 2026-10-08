SHELL := /bin/sh
PROFILES := undergraduate-thesis graduate-thesis doctoral-thesis
.PHONY: all cls examples doc clean
all: examples doc
cls:
	xetex -interaction=nonstopmode -halt-on-error suepthesis.ins
examples: cls
	@for p in $(PROFILES); do cp suepthesis.cls sueplogo.sty suepthesis-graduate.bst templates/$$p/; (cd templates/$$p && latexmk -xelatex -interaction=nonstopmode -halt-on-error main.tex) || exit 1; done
	@for p in graduate-thesis doctoral-thesis; do (cd templates/$$p && latexmk -xelatex -interaction=nonstopmode -halt-on-error main-professional.tex) || exit 1; done
doc: cls
	latexmk -xelatex -interaction=nonstopmode -halt-on-error suepthesis-doc.tex
clean:
	latexmk -c suepthesis-doc.tex
	@for p in $(PROFILES); do (cd templates/$$p && latexmk -c main.tex) || exit 1; done
	@for p in graduate-thesis doctoral-thesis; do (cd templates/$$p && latexmk -c main-professional.tex) || exit 1; done
