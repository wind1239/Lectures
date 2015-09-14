
default:	Topics_2014_15.pdf Topics_MSc-2014_15.pdf \
		Topics_2015-16.pdf UG_Topics_2015_16.pdf \
		UG_MSc_Topics.pdf

UG_MSc_Topics.pdf:	UG_MSc_Topics.tex
Topics_2014_15.pdf:	Topics_2014_15.tex
Topics_MSc-2014_15.pdf:	Topics_MSc-2014_15.tex
Topics_2015-16.pdf:	Topics_2015-16.tex
UG_Topics_2015_16.pdf:	UG_Topics_2015_16.tex

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
