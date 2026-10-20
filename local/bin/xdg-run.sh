#!/usr/bin/sh
argv=exec
for i in "$@"; do
	argv="${argv} \"${i}\""
done
exec hyprctl dispatch "hl.dsp.exec_raw('${argv}')"
