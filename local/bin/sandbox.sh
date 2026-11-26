#!/usr/bin/sh
[ -d /tmp/sandbox ] || mkdir /tmp/sandbox /tmp/sandbox/run /tmp/sandbox/tmp
exec env --ignore-environment HOME=/root "LANG=${LANG}" TERM=xterm-256color \
	"${HOME}/.local/bin/proot" --root-id \
	--rootfs="${HOME}/.local/share/sandbox" \
	--cwd=/root --bind=/dev --bind=/proc --bind=/sys \
	--bind=/tmp/sandbox/tmp:/tmp --bind=/tmp/sandbox/run:/run \
	--bind=/etc/resolv.conf /usr/bin/bash --login
