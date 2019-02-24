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
export PERL5LIB="\
${root}/etc/perl\
:${root}/data/gentoo/usr/local/lib/perl5/5.26.1/armv7a-linux\
:${root}/data/gentoo/usr/local/lib/perl5/5.26.1\
:${root}/data/gentoo/usr/lib/perl5/vendor_perl/5.26.1/armv7a-linux\
:${root}/data/gentoo/usr/lib/perl5/vendor_perl/5.26.1\
:${root}/data/gentoo/usr/lib/perl5/5.26.1/armv7a-linux\
:${root}/data/gentoo/usr/lib/perl5/5.26.1\
"

exec "$EPREFIX/bin/bash" "$@"

exit 1


