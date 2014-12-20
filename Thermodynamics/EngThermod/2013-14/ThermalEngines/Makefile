
default:	Module_01_01.pdf Module_01_02.pdf Module_01_03.pdf Module_01_04.pdf Module_01_05.pdf\
		Problems.pdf 

Module_01_01.pdf:	Module_01_01.tex
Module_01_02.pdf:	Module_01_02.tex
Module_01_03.pdf:	Module_01_03.tex
Module_01_04.pdf:	Module_01_04.tex
Module_01_05.pdf:	Module_01_05.tex
Problems.pdf:		Problems.tex

%.pdf:	%.tex
	rm -f $*.pdf
	pdflatex $<
	pdflatex $<
	if fgrep "Rerun to" $*.log; then $(MAKE) --assume-new $< $@;fi
ifndef NOBIBTEX
	if fgrep "There were undefined"  $*.log;\
	then bibtex $*; \
	$(MAKE) NOBIBTEX=true --assume-new $< $@;fi
else
	@echo Sticking a cover on $*.pdf
	pdftk A=figures/ReportCoverTemplateICON.pdf B=$*.pdf cat A2 B A1 output combined.pdf
	mv combined.pdf $*.pdf
endif

%.idx:	%.idx
	makeindex $<

.PHONY: clean clean-pdf

# We don't rm *.ps because that might clobber image files. Instead, put any
# ps files which should go in $(PSFILES)
clean:	*.pdf
	rm $(TARGETS)*.aux *.log *.bbl *.blg *.toc *.lof *ind *idx *ilg *nav *snm \
*.out *pdf *.pdftex *_tex.pdf *.pdftex_t *.pstex *.pstex_t \
$(addsuffix .png, $(XFIG_IMAGES)) 2>/dev/null||true

htclean_%:
	rm $*.4ct $*.4tc $*.css $*.idv $*.lg $*.tmp $*.xref *.html 2>/dev/null||true
clean-aux:
		rm $(TARGETS)*.aux *.log *.bbl *.blg *.toc *.lof *ind *idx *ilg *nav *snm \
*.out 
clean-pdf: 
		rm *.pdf




