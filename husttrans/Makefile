
# OS detected
ifeq ($(OS),Windows_NT)
	ifneq ($(findstring .exe,$(SHELL)),)
    OS_TYPE := Windows
	else
    OS_TYPE := Cygwin
	endif
else
    OS_TYPE := $(shell uname -s)
endif

# Program Defintions
TEX    = lualatex -shell-escape -8bit
BIBTEX = bibtex
INDEX  = makeindex -q
RM     = $(if $(filter $(OS_TYPE),Windows),del /f /q ,rm -f )

all:class doc example

unpack:husttrans.dtx husttrans.ins
	@$(TEX) husttrans.ins

%.cls %.tex %.bib:husttrans.dtx husttrans.ins
	@$(TEX) husttrans.ins

class:husttrans.cls

doc:husttrans.pdf

husttrans.pdf:husttrans.dtx
	@$(TEX) $(^F)
	@$(INDEX) -s gind.ist -o $(basename $(^F)).ind $(basename $(^F)).idx
	@$(INDEX) -s gglo.ist -o $(basename $(^F)).gls $(basename $(^F)).glo
	@$(TEX) $(^F)
	@$(TEX) $(^F)

example:husttrans-example.pdf

husttrans-example.pdf:husttrans-example.tex husttrans.cls ref-example.bib
	@$(TEX) $(<F)
	@$(BIBTEX) $(basename $(<F))
	@$(TEX) $(<F)
	@$(TEX) $(<F)

clean:
	-$(RM) *.acn *.acr *.alg *.aux *.bbl \
			*.blg *.dvi *.fdb_latexmk *.glg *.glo \
			*.gls *.idx *.ilg *.hd *.ind *.ist \
			*.lof *.log *.lot *.maf *.mtc \
			*.mtc0 *.nav *.nlo *.out *.pdfsync \
			*.pyg *.snm *.synctex.gz *.thm *.toc \
			*.vrb *.xdy *.tdo \
			*.cls *.tex *.md *.bib *.bst

reallyclean:
	-$(RM) *.acn *.acr *.alg *.aux *.bbl \
			*.blg *.dvi *.fdb_latexmk *.glg *.glo \
			*.gls *.idx *.ilg *.hd *.ind *.ist \
			*.lof *.log *.lot *.maf *.mtc \
			*.mtc0 *.nav *.nlo *.out *.pdfsync \
			*.pyg *.snm *.synctex.gz *.thm *.toc \
			*.vrb *.xdy *.tdo \
			*.cls *.tex *.md *.bib *.bst husttrans*.pdf

checksum:FORCE
	perl adjust_checksum.pl husttrans.dtx

.PHONY:all unpack class doc example clean reallyclean checksum FORCE
