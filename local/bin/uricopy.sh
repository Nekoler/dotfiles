#!/usr/bin/sh
if [ $# -eq 0 ]; then
	echo "Empty, No copy."
	exit 1
fi
urilist=""
for i in "$@"; do
	urilist="${urilist}file://${PWD}/${i}\n"
done
echo -n "${urilist}" | wl-copy --type text/uri-list
