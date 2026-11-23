#!/usr/bin/sh
set -- "${1}" --output="${1%.*}.docx" --citeproc --bibliography=Bibliography.bib --csl=CitationStyle.csl --metadata=reference-section-title=参考文献
[ -f reference.docx ] && set -- "${@}" --reference-doc=reference.docx
exec pandoc "${@}"
