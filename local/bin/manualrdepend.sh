#!/usr/bin/sh
for deb in $(apt-mark showmanual); do
	rdepends=$(apt-cache --installed rdepends "${deb}")
	lines=$(echo "${rdepends}" | wc -l)
	if [ "${lines}" -gt 2 ]; then
		echo "${rdepends}" | sed '2d'
	fi
done
