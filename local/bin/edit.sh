#!/usr/bin/sh
exec kitty --single-instance --class=nvim -e nvim "$@"
