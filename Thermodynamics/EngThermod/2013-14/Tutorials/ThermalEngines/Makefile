
default:	Problems.pdf Tutorial_01.pdf Tutorial_02.pdf Tutorial_03.pdf 

Problems.pdf:		Problems.tex 
Tutorial_01.pdf:	Tutorial_01.tex 
Tutorial_02.pdf:	Tutorial_02.tex 
Tutorial_03.pdf:	Tutorial_03.tex 


%.pdf:	%.tex
	rm -f $*.pdf
	pdflatex $<
	pdflatex $<
	if fgrep "Rerun to" $*.log; then $(MAKE) --assume-new $< $@;fi

# We don't rm *.ps because that might clobber image files. Instead, put any
# ps files which should go in $(PSFILES)
clean:	*.pdf
	rm $(TARGETS)*.aux *.log *pdf


