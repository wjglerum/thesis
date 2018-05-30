# Parameters:
mainfile = thesis
language = en_GB

# Basic building of pdf.
.PHONY: final all 
all: $(mainfile).pdf 
final: clean check all

$(mainfile).pdf: *.tex *.bib *.cls 
	pdflatex $(mainfile)
	biber $(mainfile)
	@echo ""
	@echo "Recompiling for references."
	@echo ""
	pdflatex -interaction=batchmode $(mainfile)
	pdflatex -interaction=batchmode $(mainfile)
	mv $(mainfile).pdf ../$(mainfile).pdf

# Checking for smells and bad spelling
.PHONY: check checkspelling checksmells checkweasels checkpassive checkduplicates
check: checkspelling checksmells

checkspelling:
	@echo "Checking Spelling:"
	@find . -name "*.tex" -exec aspell -l $(language) -c {} \;

checksmells: checkweasels checkpassive checkduplicates

checkweasels:
	@echo "Weasel words:"
	@find . -name "*.tex" -exec helpers/weaselwords.sh {} \;

checkpassive:
	@echo "Passive voice:"
	@find . -name "*.tex" -exec helpers/passivevoice.sh {} \;

checkduplicates:
	@echo "Duplicates:"
	@find . -name "*.tex" -exec helpers/checkduplicates.pl {} \;

# Cleaning up stuff
.PHONY: clean
clean: 
	rm -f *~ *.bak *.aux *.log *.toc *.blg *.bbl *.dvi *.ps *.acn *.glo *.ist *.bcf *.run-xml *.run.xml
	rm -f chapters/*.aux chapters/*.bak
	rm -f appendices/*.aux appendices/*.bak
