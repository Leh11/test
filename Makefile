MAIN = main
TEX_SOURCES = Makefile \
              $(MAIN).tex \
              $(MAIN).bib \

FIGURES := $(shell find img/* -type f)

SHELL=/bin/bash

OPT = --interaction=nonstopmode

all: $(MAIN).pdf

final: final.pdf
	$(MAKE) clean

$(MAIN).pdf: $(TEX_SOURCES) $(FIGURES)
	latexmk -pdf -pdflatex="pdflatex $(OPT)" $(MAIN) 

once: 
	pdflatex $(MAIN)

clean: 
	-rm -f $(MAIN).{pdf,log,blg,bbl,aux,out,toc,idx,bcf,run.xml,ind,ilg,fls,fdb_latexmk} final.pdf

PHONY: clean all
