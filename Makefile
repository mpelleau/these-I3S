all:
	pdflatex sommaire
	bibtex sommaire
	bibtex web
	bibtex mine
	pdflatex sommaire
	pdflatex sommaire

clean:
	rm -f *.aux *.bbl *.lbl *.loa *.loe *.lof *.log *.maf *.mlf* *.mlt* *.mtc* *.toc *.blg
