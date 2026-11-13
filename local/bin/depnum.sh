#!/usr/bin/sh
for deb in $(apt-mark showmanual); do
	dep=$(apt-cache --installed --recurse depends "${deb}" | sed -e '/^ /!d' -e 's/^.\+: //g' | sort --unique | wc --lines)
	printf '%04d %s\n' "${dep}" "${deb}"
done
