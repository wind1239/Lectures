
default:	CourseHandbook_EX3029_2016-17.pdf CourseHandbook_EX3029_2015-16.pdf \
		CourseHandbook_EG3029_2014-15.pdf EG501J_Syllabus_and_InitialTimetable_2014-15.pdf \
		FormativeAssessment_LearningOutcomes.pdf \
		CourseHandbook_EX3029_2017-18.pdf

CourseHandbook_EX3029_2017-18.pdf:	CourseHandbook_EX3029_2017-18.tex
CourseHandbook_EX3029_2016-17.pdf:	CourseHandbook_EX3029_2016-17.tex
CourseHandbook_EX501V_2015-16.pdf: CourseHandbook_EX501V_2015-16.tex
CourseHandbook_EG501V_2014-15.pdf: CourseHandbook_EG501V_2014-15.tex
EG501J_Syllabus_and_InitialTimetable_2014-15.pdf: EG501J_Syllabus_and_InitialTimetable_2014-15.tex
FormativeAssessment_LearningOutcomes.pdf:	FormativeAssessment_LearningOutcomes.tex

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
