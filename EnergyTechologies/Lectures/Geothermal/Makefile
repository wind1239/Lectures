
default:	GeothermalEngineering_Part1.pdf GeothermalEngineering_Part2.pdf \
		Tutorial1.pdf Tutorial2.pdf Tutorial3.pdf \
		ContinuousAssessment.pdf
		#GeothermalEngineering_ReviewThermodinamics.pdf \
		GeothermalEngineering_Part3.pdf

GeothermalEngineering_Part1.pdf:		GeothermalEngineering_Part1.tex
GeothermalEngineering_Part2.pdf:		GeothermalEngineering_Part2.tex
Tutorial1.pdf:					Tutorial1.tex
Tutorial2.pdf:					Tutorial2.tex
Tutorial3.pdf:					Tutorial3.tex
ContinuousAssessment.pdf:			ContinuousAssessment.tex
#GeothermalEngineering_ReviewThermodinamics.pdf:	GeothermalEngineering_ReviewThermodinamics.tex
#GeothermalEngineering_Part3.pdf:		GeothermalEngineering_Part3.tex

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




