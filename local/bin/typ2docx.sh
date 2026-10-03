#!/usr/bin/sh
option=initial.typ --output=initial.docx --citeproc --bibliography=Bibliography.bib --csl=CitationStyle.csl --metadata=reference-section-title=参考文献
if [ -e reference.docx]; then
	option=${option} --reference-doc=reference.docx
fi
pandoc ${option}
