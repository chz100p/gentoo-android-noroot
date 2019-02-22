#!/system/bin/sh
root="/data/data/jackpal.androidterm/r"
export HOME="${root}/home/chz100p"
export SHELL="${root}/data/gentoo/bin/bash"
ld_linux="${root}/l/l"
export EPREFIX="${root}/data/gentoo"
unset LD_PRELOAD
unset LD_LIBRARY_PATH
export PATH="\
$HOME/bin\
:$EPREFIX/usr/bin\
:$EPREFIX/bin\
"
export TMPDIR="$EPREFIX/tmp"
export TERMINFO="$EPREFIX/etc/terminfo"
export TZ="GMT-9"

exec \
"$EPREFIX/bin/bash" \

exit 1
