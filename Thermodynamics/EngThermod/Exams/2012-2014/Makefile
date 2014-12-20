
default:	Exam01_2013-4.pdf Exam01Solutions_2013-4.pdf
Exam01_2013-4.pdf:		Exam01_2013-4.tex
Exam02_2013-4.pdf:		Exam02_2013-4.tex
Exam01Solutions_2013-4.pdf:	Exam01Solutions_2013-4.tex
Exam02Solutions_2013-4.pdf:	Exam02Solutions_2013-4.tex
Exam01_2013-4soln.pdf:		Exam01_2013-4soln.tex
Exam02_2013-4soln.pdf:		Exam02_2013-4soln.tex
ExtraQuestion.pdf:		ExtraQuestion.tex

%.pdf:	%.tex
	rm -f $*.pdf
	pdflatex $<
	pdflatex $<
	if fgrep "Rerun to" $*.log; then $(MAKE) --assume-new $< $@;fi
	@echo Sticking a cover on $*.pdf
	#pdftk A1=Exam01_2013-4.pdf A2=UnitsConversion.pdf A3=Tables_Steam.pdf cat A1 A2 A3 output EG3521_May2014Exam.pdf
	#pdftk A1=CoverSheet_ExamPaper_May2013.pdf A2=Exam01_2013-4.pdf A3=UnitsConversion.pdf A4=Tables_Steam.pdf \
	#cat A1 A2 A3 A4 output EG3521_May2014Exam.pdf
	#pdftk B1=CoverSheet_ExamPaper_August2013.pdf B2=Exam02_2013.pdf B3=UnitsConversion.pdf B4=Tables_R134.pdf \
	#cat B1 B2 B3 B4 output EG3035_Aug2013Exam.pdf

.PHONY: clean clean-pdf

# We don't rm *.ps because that might clobber image files. Instead, put any
# ps files which should go in $(PSFILES)
clean:	
	rm $(TARGETS)*.aux *.log *.bbl *.blg *.toc *.lof *ind *idx *ilg *nav *snm \
	*.out *.pdftex *_tex.pdf *.pdftex_t *.pstex *.pstex_t \
	Exam01_2013-4.pdf Exam01Solutions_2013-4.pdf Exam02_2013-4.pdf Exam02Solutions_2013-4.pdf \
	Exam01_2013-4soln.pdf Exam02_2013-4soln.pdf ExtraQuestion.pdf\
	$(addsuffix .png, $(XFIG_IMAGES)) 2>/dev/null||true

htclean_%:
	rm $*.4ct $*.4tc $*.css $*.idv $*.lg $*.tmp $*.xref *.html 2>/dev/null||true
clean-aux:
		rm $(TARGETS)*.aux *.log *.bbl *.blg *.toc *.lof *ind *idx *ilg *nav *snm \
		*.out 
clean-pdf: 
		rm Exam01_2013-4.pdf Exam01Solutions_2013-4.pdf Exam02_2013-4.pdf Exam02Solutions_2013-4.pdf \
		Exam01_2013-4soln.pdf Exam02_2013-4soln.pdf ExtraQuestion.pdf




