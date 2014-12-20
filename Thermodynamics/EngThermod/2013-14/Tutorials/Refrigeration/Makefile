
default:	Problems.pdf 

Problems.pdf:		Problems.tex 


%.pdf:	%.tex
	rm -f $*.pdf
	pdflatex $<
	pdflatex $<
	if fgrep "Rerun to" $*.log; then $(MAKE) --assume-new $< $@;fi

# We don't rm *.ps because that might clobber image files. Instead, put any
# ps files which should go in $(PSFILES)
clean:	*.pdf
	rm $(TARGETS)*.aux *.log *pdf *out


