#!/usr/bin/sh
for deb in $(apt-mark showmanual); do
	rdepends=$(apt-cache rdepends --installed "${deb}" | sed '2d')
	lines=$(printf "${rdepends}" | wc -l)
	if [ ${lines} -gt 1 ]; then
		echo "${rdepends}"
	fi
done
