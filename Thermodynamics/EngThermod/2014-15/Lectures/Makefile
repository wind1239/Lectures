
default:	Module_01-Full.pdf Module_01.pdf \
		Tutorial_01.pdf Tutorial_02.pdf \
		Module_02_01.pdf \ #Tutorial_02.pdf \
		#Module_03.pdf Tutorial_03.pdf \
		#Practical_01.pdf \
		#Module_04.pdf Tutorial_04.pdf \
		#Practical_02.pdf \
		#Module_05.pdf Tutorial_05.pdf \
		#Module_06.pdf Tutorial_06.pdf \
		#Module_07.pdf Tutorial_07.pdf \
		#EquationsList.pdf


Module_01-Full.pdf:	Module_01-Full.tex
Module_01.pdf:		Module_01.tex
Tutorial_01.pdf:	Tutorial_01.tex
Tutorial_02.pdf:	Tutorial_02.tex
Module_02_01.pdf:	Module_02_01.tex
#Tutorial_02.pdf:	Tutorial_02.tex
#Module_03.pdf:		Module_03.tex
#Tutorial_03.pdf:	Tutorial_03.tex
#Practical_01.pdf:	Practical_01.tex
#Module_04.pdf:		Module_04.tex
#Tutorial_04.pdf:	Tutorial_04.tex
#Practical_02.pdf:	Practical_02.tex
#EquationsList.pdf:	EquationsList.tex
#Module_05.pdf:		Module_05.tex
#Tutorial_05.pdf:	Tutorial_05.tex
#Module_06.pdf:		Module_06.tex
#Tutorial_06.pdf:	Tutorial_06.tex
#Module_07.pdf:		Module_07.tex
#Tutorial_07.pdf:	Tutorial_07.tex

%.pdf:	%.tex
	rm -f $*.pdf
	pdflatex $<
	pdflatex $<
	if fgrep "Rerun to" $*.log; then $(MAKE) --assume-new $< $@;fi
ifndef NOBIBTEX
	if fgrep "There were undefined"  $*.log;\
	then bibtex $*; \
	$(MAKE) NOBIBTEX=true --assume-new $< $@;fi
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




