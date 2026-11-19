#!/usr/bin/sh
option="${1} --output=${1%.*}.docx --citeproc --bibliography=Bibliography.bib --csl=CitationStyle.csl --metadata=reference-section-title=参考文献"
if [ -e reference.docx ]; then
	option="${option} --reference-doc=reference.docx"
fi
exec pandoc ${option}
