
default:	CourseHandbook_EG501V_2015-16.pdf \ 
		EG501V_Timetable.pdf #Syllabus.pdf 

CourseHandbook_EG501V_2015-16.pdf: CourseHandbook_EG501V_2015-16.tex
Syllabus.pdf:	Syllabus.tex
EG501V_Timetable.pdf:	EG501V_Timetable.tex

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
