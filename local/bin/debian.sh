#!/usr/bin/sh
exec env -i "LANG=${LANG}" \
	TERM=xterm-256color \
	"${HOME}/.local/bin/proot.static" \
	-S "${HOME}/.local/share/debian" \
	-w /root -b /dev -b /proc -b /sys \
	-b /tmp/proot/tmp:/tmp \
	-b /tmp/proot/run:/run \
	-b /etc/resolv.conf /usr/bin/bash --login
