#!/usr/bin/sh
for deb in $(apt-mark showmanual); do
	rdepends=$(apt-cache rdepends --installed --no-suggests "${deb}" | sed '2d')
	lines=$(echo "${rdepends}" | wc -l)
	if [ "${lines}" -gt 1 ]; then
		echo "${rdepends}"
	fi
done
