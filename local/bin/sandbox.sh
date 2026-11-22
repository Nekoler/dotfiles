#!/usr/bin/sh
[ ! -d /tmp/sandbox ] && mkdir /tmp/sandbox /tmp/sandbox/run /tmp/sandbox/tmp
[ ! -d "${HOME}/.local/share/sandbox/${HOME}" ] &&
	mkdir "${HOME}/.local/share/sandbox/${HOME}" &&
	cp "${HOME}/.bashrc" "${HOME}/.local/share/sandbox/${HOME}" &&
	cp "${HOME}/.profile" "${HOME}/.local/share/sandbox/${HOME}"

exec bwrap --clearenv --setenv HOME "${HOME}" --setenv LANG "${LANG}" --setenv TERM xterm-256color \
	--bind "${HOME}/.local/share/sandbox" / \
	--dev-bind /dev /dev --bind /proc /proc --bind /sys /sys \
	--bind /tmp/sandbox/run /run \
	--bind /tmp/sandbox/tmp /tmp \
	--bind /etc/passwd /etc/passwd \
	--bind /etc/resolv.conf /etc/resolv.conf \
	--chdir "${HOME}" /usr/bin/bash --login
