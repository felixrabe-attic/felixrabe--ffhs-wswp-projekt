Bevölkerung und Energie
=======================

Semesterarbeit WSWP, FFHS BSc INF 2011

Felix Rabe

8. Juli 2013


Leitfaden zum Quellcode
-----------------------

Die Hauptdatei ist `arbeit.Rnw`.  Sie verweist (indirekt) auf alle Teile der Arbeit, lädt die verwendeten Daten, und führt die Berechnungen aus.

Mit folgenden Befehlen lässt sich auf Mac OS X oder Linux die Datei `arbeit.pdf` generieren:

    # Setzt eine LaTeX-Installation, sowie R und verwendete R-Pakete (siehe arbeit.pdf) voraus.

    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
    export LC_ALL=en_US.UTF-8

    rm -f arbeit.aux arbeit.dvi arbeit.log arbeit.out arbeit.tex arbeit.toc
    rm -f arbeit.pdf
    Rscript -e "library(knitr); knit('arbeit.Rnw')"
    lualatex -interaction=batchmode arbeit.tex
    lualatex -interaction=batchmode arbeit.tex
    lualatex -interaction=batchmode arbeit.tex
    rm -f arbeit.aux arbeit.dvi arbeit.log arbeit.out arbeit.tex arbeit.toc


TODO: Content
-------------

- Variationskoeffizient des Bevölkerungswachstums
- Compare energy consumption per capita among various countries


TODO: Less important clean up tasks
-----------------------------------

- Description for GitHub
- Include build script (or "dump m")
