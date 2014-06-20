# You can change the pdf viewer to your preferred
# one by commenting every line beginning by
# `PDFVIEWER' except the one with your pdf viewer
#PDFVIEWER=evince # GNOME
#PDFVIEWER=okular # KDE
#PDFVIEWER=xpdf # lightweight
PDFVIEWER=xdg-open # Default pdf viewer - GNU/Linux
#PDFVIEWER=open # Default pdf viewer - Mac OS
MAIN_NAME=INGI1131-$(year)-$(month)-$(serie)
MAIN_NAME_SOL=$(MAIN_NAME)-Sol
PDF_NAME=$(MAIN_NAME).pdf
PDF_NAME_SOL=$(MAIN_NAME_SOL).pdf

# You want latexmk to *always* run, because make does not have all the info.
.PHONY: $(PDF_NAME) $(PDF_NAME_SOL)

# If you want the pdf to be opened by your preferred pdf viewer
# after `$ make', comment the following line and uncomment the
# line after
#default: all
default: show

#all: $(PDF_NAME) $(PDF_NAME_SOL)
all: $(PDF_NAME)

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

# Other depences are gessed automatically by latexmk
# see http://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project
$(PDF_NAME_SOL): $(MAIN_NAME).tex
	latexmk -pdf -pdflatex="pdflatex -jobname=$(MAIN_NAME_SOL) -shell-escape \
	  -enable-write18 '\def\Sol{true} \input{%S}'" \
	  -use-make $(MAIN_NAME).tex -jobname=$(MAIN_NAME_SOL)

$(PDF_NAME): $(MAIN_NAME).tex
	latexmk -pdf -pdflatex="pdflatex -shell-escape -enable-write18 \
	  '\def\Sol{false} \input{%S}'" -use-make $(MAIN_NAME).tex

clean:
	latexmk -C

# It makes more sense to show the sol since more can be checked
show: $(PDF_NAME)
	$(PDFVIEWER) $(PDF_NAME) 2> /dev/null &

release: all
	cd ../../../..; smartcp -v config.yml
