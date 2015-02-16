
default:	EG501J_Exam1_2014-5.pdf EG501J_Exam2_2014-5.pdf \
		EG3029_Exam1_2014-5.pdf EG3029_Exam2_2014-5.pdf \
		EG3029_SampleExam_2014-15.pdf \
		EG5597_Exam1_2013-4.pdf EG5597_Exam2_2013-4.pdf \
		EG3521_Exam1_2013-4.pdf EG3521_Exam2_2013-4.pdf \
		EG3521_Exam1_2014-5.pdf EG3521_Exam2_2014-5.pdf

EG501J_Exam1_2014-5.pdf:	EG501J_Exam1_2014-5.tex
EG501J_Exam2_2014-5.pdf:	EG501J_Exam2_2014-5.tex
EG3029_Exam1_2014-5.pdf:	EG3029_Exam1_2014-5.tex
EG3029_Exam2_2014-5.pdf:	EG3029_Exam2_2014-5.tex
EG3029_SampleExam_2014-15.pdf:	EG3029_SampleExam_2014-15.tex
EG5597_Exam1_2013-4.pdf:	EG5597_Exam1_2013-4.tex
EG5597_Exam2_2013-4.pdf:	EG5597_Exam2_2013-4.tex
EG3521_Exam1_2013-4.pdf:	EG3521_Exam1_2013-4.tex
EG3521_Exam2_2013-4.pdf:	EG3521_Exam2_2013-4.tex
EG3521_Exam1_2014-5.pdf:	EG3521_Exam1_2014-5.tex
EG3521_Exam2_2014-5.pdf:	EG3521_Exam2_2014-5.tex

%.pdf:	%.tex
	rm -f $*.pdf
	pdflatex $<
	pdflatex $<
	if fgrep "Rerun to" $*.log; then $(MAKE) --assume-new $< $@;fi
	@echo Sticking a cover on $*.pdf

.PHONY: clean clean-pdf

# We don't rm *.ps because that might clobber image files. Instead, put any
# ps files which should go in $(PSFILES)
clean:	
	rm $(TARGETS)*.aux *.log *pdf
clean-pdf: 
		rm *.pdf




