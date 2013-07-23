pandoc --latex-engine=xelatex -s -S --template header.latex -f markdown -V geometry:margin=1in  MS.md --bibliography=refs.bib  --csl=style/mystyle.csl  -o MS.pdf
