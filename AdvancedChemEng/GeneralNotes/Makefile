
default:	CourseHandbook_EG5597_2014-15.pdf Syllabus.pdf \
		EG5597_Timetable.pdf

CourseHandbook_EG5597_2014-15.pdf: CourseHandbook_EG5597_2014-15.tex
Syllabus.pdf:	Syllabus.tex
EG5597_Timetable.pdf:	EG5597_Timetable.tex

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
	rm $(TARGETS)*.aux *.log *pdf *out
clean-pdf: 
		rm *.pdf
