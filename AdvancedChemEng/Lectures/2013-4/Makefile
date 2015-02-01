
default:	Lecture_01.pdf Lecture_02.pdf Lecture_03.pdf \
		ExtraNotes.pdf Tutorial_LinAlg.pdf CA_LinAlg.pdf \
		Tutorial_01.pdf ContinuousAssessment.pdf

Lecture_01.pdf:			Lecture_01.tex 
Lecture_02.pdf:			Lecture_02.tex
Lecture_03.pdf:			Lecture_03.tex 
ExtraNotes.pdf: 		ExtraNotes.tex
Tutorial_LinAlg.pdf:		Tutorial_LinAlg.tex
CA_LinAlg.pdf:			CA_LinAlg.tex
Tutorial_01.pdf:		Tutorial_01.tex
ContinuousAssessment.pdf:	ContinuousAssessment.tex

%.pdf:	%.tex
	rm -f $*.pdf
	pdflatex $<
	pdflatex $<

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




