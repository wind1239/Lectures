
default:	CourseHandbook_EG3521_2014-15.pdf \
		CourseHandbook_EG3521_2013-14.pdf EG3521_Syllabus_and_InitialTimetable.pdf \
		ListOfPapers_2013-14.pdf ListOfPapers.pdf

CourseHandbook_EG3521_2014-15.pdf:	CourseHandbook_EG3521_2014-15.tex
CourseHandbook_EG3521_2013-14.pdf:	CourseHandbook_EG3521_2013-14.tex
EG3521_Syllabus_and_InitialTimetable.pdf: EG3521_Syllabus_and_InitialTimetable.tex
#GeneralInfo.pdf:	GeneralInfo.tex
ListOfPapers_2013-14.pdf:  ListOfPapers_2013-14.tex
ListOfPapers.pdf:	ListOfPapers.tex

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
