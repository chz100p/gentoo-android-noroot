#!/system/bin/sh
root="/data/data/jackpal.androidterm/r"
export HOME="${root}/home/chz100p"
export SHELL="${root}/data/gentoo/bin/bash"
ld_linux="${root}/l/l"
export EPREFIX="${root}/data/gentoo"
unset LD_PRELOAD
unset LD_LIBRARY_PATH
#export LD_LIBRARY_PATH="\
#:$EPREFIX/lib\
#:$EPREFIX/usr/lib\
#:$EPREFIX/usr/lib/binutils/armv7a-hardfloat-linux-gnueabi/2.30\
#"
export PATH="\
$HOME/bin\
:$EPREFIX/usr/bin\
:$EPREFIX/bin\
:$EPREFIX/usr/sbin\
:$EPREFIX/sbin\
"
export TMPDIR="$EPREFIX/tmp"
export TERMINFO="$EPREFIX/etc/terminfo"
export TZ="GMT-9"

exec \
fakechroot fakeroot chroot "${root}" \
"$EPREFIX/bin/bash" \

exit 1
