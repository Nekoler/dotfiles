#!/usr/bin/sh
cd $(dirname $0)
find config -type f -exec ln -f "${HOME}/.{}" "{}" \;
find local -type f -exec ln -f "${HOME}/.{}" "{}" \;
