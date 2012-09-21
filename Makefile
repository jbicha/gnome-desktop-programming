NAME := gnome-desktop-programming

PDFLATEX := $(shell which pdflatex)
BUILDDIR := build
PDFTARGET := $(BUILDDIR)/$(NAME).pdf

all: $(PDFTARGET)

TEX_FILES :=
TEX_FILES += book/commands.tex
TEX_FILES += book/gnome-desktop-programming.tex
TEX_FILES += book/introduction.tex
TEX_FILES += book/preamble.tex
TEX_FILES += book/preface.tex

EXERCISE_FILES :=
EXERCISE_FILES += exercise1.c

$(BUILDDIR)/%.tex: exercises/%.c
	@mkdir -p $(BUILDDIR)
	@echo "  [FORMAT]   $*"
	@./exercises/formatter.py exercises/$*.c $(BUILDDIR)/$*.tex

$(PDFTARGET): $(TEX_FILES) $(foreach var,$(EXERCISE_FILES),$(BUILDDIR)/$(var:.c=.tex))
	@mkdir -p $(BUILDDIR)
	@echo "  [COPY]     styles"
	@cp -a styles/*.sty $(BUILDDIR)
	@echo "  [COPY]     tex"
	@cp -a book/*.tex $(BUILDDIR)
	@echo "  [PDFLATEX] $(NAME).pdf"
	@$(PDFLATEX) -output-directory $(BUILDDIR) -output-format pdf $(BUILDDIR)/$(NAME).tex >/dev/null

view: $(PDFTARGET)
	evince $(PDFTARGET)

clean:
	@echo "  [CLEAN]"
	@rm -rf $(BUILDDIR)
