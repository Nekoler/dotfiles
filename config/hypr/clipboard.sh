#!/usr/bin/sh
select=$(cliphist list | wofi --dmenu)
if [ $? -eq 0 ]; then
	printf "${select}" | cliphist decode | wl-copy
fi
