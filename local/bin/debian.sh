#!/usr/bin/sh
[ -e /tmp/proot ] || mkdir /tmp/proot /tmp/proot/run /tmp/proot/tmp
exec env --ignore-environment "LANG=${LANG}" TERM=xterm-256color \
	"${HOME}/.local/bin/proot.static" --root-id \
	--rootfs="${HOME}/.local/share/debian" \
	--cwd=/root --bind=/dev --bind=/proc --bind=/sys \
	--bind=/tmp/proot/tmp:/tmp --bind=/tmp/proot/run:/run \
	--bind=/etc/resolv.conf /usr/bin/bash --login
