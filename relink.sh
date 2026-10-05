#!/usr/bin/sh
base=$(dirname $0)
cd ${base}
find config -type f -exec ln -f "${HOME}/.{}" "{}" \;
find local -type f -exec ln -f "${HOME}/.{}" "{}" \;
