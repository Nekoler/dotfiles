#!/usr/bin/sh
cd $(dirname $0)
find config local -type f | while read i; do
	[ "${HOME}/.${i}" -ef "${i}" ] || ln -f "${HOME}/.${i}" "${i}"
done
