#!/system/bin/sh
root="/data/data/jackpal.androidterm/r"
export HOME="${root}/home/chz100p"
ld_linux="${root}/l/l"
export EPREFIX="${root}/data/gentoo"
unset LD_PRELOAD
export LD_LIBRARY_PATH="\
:$EPREFIX/lib\
:$EPREFIX/usr/lib\
:$EPREFIX/usr/lib/binutils/armv7a-hardfloat-linux-gnueabi/2.30\
"
export PATH="\
$HOME/bin\
:$EPREFIX/usr/bin\
:$EPREFIX/bin\
"
export TMPDIR="$EPREFIX/tmp"

[[ -e $TMPDIR ]] || "$EPREFIX/bin/mkdir" -p "$TMPDIR" || exit 1

#"$EPREFIX/bin/bash" -c "echo prefix!"

[[ -d "${root}/data/data/jackpal.androidterm" ]] || "$EPREFIX/bin/mkdir" -p "${root}/data/data/jackpal.androidterm" || exit 1
[[ -e "${root}${root}" ]] || "$EPREFIX/bin/ln" -s "../../.." "${root}${root}" || exit 1

fakechroot_lib="libfakechroot.so"
fakechroot_paths=/data/data/jackpal.androidterm/r/home/chz100p/lib/fakechroot

fakechroot_paths="$fakechroot_paths${LD_LIBRARY_PATH:+${fakechroot_paths:+:}$LD_LIBRARY_PATH}"
fakechroot_lib="$fakechroot_lib${LD_PRELOAD:+ $LD_PRELOAD}"

#fakechroot_paths="$fakechroot_paths${PATH:+${fakechroot_paths:+:}$PATH}"

LD_LIBRARY_PATH="$fakechroot_paths" LD_PRELOAD="$fakechroot_lib" \
exec \
"$EPREFIX/bin/chroot" \
"${root}" \
"$EPREFIX/bin/bash" \

exit 1

/data/gentoo/sbin/ldconfig -C /data/data/jackpal.androidterm/r/data/gentoo/etc/ld.so.cache -f /data/data/jackpal.androidterm/r/data/gentoo/etc/ld.so.conf
exit 1


/data/gentoo/lib/ld-linux-armhf.so.3 \
/data/gentoo/bin/bash

exit 1


#!/data/data/jackpal.androidterm/r/data/gentoo/bin/sh

# fakechroot
#
# Script which sets fake chroot environment
#
# (c) 2011, 2013 Piotr Roszatycki <dexter@debian.org>, LGPL


FAKECHROOT_VERSION=2.19


fakechroot_die () {
    echo "$@" 1>&2
    exit 1
}


fakechroot_usage () {
    fakechroot_die "Usage:
    fakechroot [-l|--lib fakechrootlib]
               [-d|--elfloader ldso]
               [-s|--use-system-libs]
               [-e|--environment type]
               [-c|--config-dir directory]
               [-b|--bindir directory]
               [--] [command]
    fakechroot -v|--version
    fakechroot -h|--help"
}


fakechroot_next_cmd () {
    if [ "$1" = "fakeroot" ]; then
        shift
        # skip the options
        while [ $# -gt 0 ]; do
            case "$1" in
                -h|-v)
                    break
                    ;;
                -u|--unknown-is-real)
                    shift
                    ;;
                -l|--lib|--faked|-s|-i|-b)
                    shift 2
                    ;;
                --)
                    shift
                    break
                    ;;
                *)
                    break
                    ;;
            esac
        done
    fi

    if [ -n "$1" -a "$1" != "-v" -a "$1" != "-h" ]; then
        fakechroot_environment=`basename -- "$1"`
    fi
}


if [ "$FAKECHROOT" = "true" ]; then
    fakechroot_die "fakechroot: nested operation is not supported"
fi


# Default settings
fakechroot_lib=libfakechroot.so
fakechroot_paths=/data/data/jackpal.androidterm/root/data/gentoo/home/chz100p/lib
fakechroot_sysconfdir=/data/data/jackpal.androidterm/root/data/gentoo/home/chz100p/etc
fakechroot_confdir=
fakechroot_environment=
fakechroot_bindir=

if [ "$fakechroot_paths" = "no" ]; then
    fakechroot_paths=
fi


# Get options
fakechroot_getopttest=`getopt --version`
case $fakechroot_getopttest in
    getopt*)
        # GNU getopt
        fakechroot_opts=`getopt -q -l lib: -l elfloader: -l use-system-libs -l config-dir: -l environment: -l bindir: -l version -l help -- +l:d:sc:e:b:vh "$@"`
        ;;
    *)
        # POSIX getopt ?
        fakechroot_opts=`getopt l:d:sc:e:b:vh "$@"`
        ;;
esac

if [ "$?" -ne 0 ]; then
    fakechroot_usage
fi

eval set -- "$fakechroot_opts"

while [ $# -gt 0 ]; do
    fakechroot_opt=$1
    shift
    case "$fakechroot_opt" in
        -h|--help)
            fakechroot_usage
            ;;
        -v|--version)
            echo "fakechroot version $FAKECHROOT_VERSION"
            exit 0
            ;;
        -l|--lib)
            fakechroot_lib=`eval echo "$1"`
            fakechroot_paths=
            shift
            ;;
        -d|--elfloader)
            FAKECHROOT_ELFLOADER=$1
            export FAKECHROOT_ELFLOADER
            shift
            ;;
        -s|--use-system-libs)
            fakechroot_paths="${fakechroot_paths:+$fakechroot_paths:}/usr/lib:/lib"
            ;;
        -c|--config-dir)
            fakechroot_confdir=$1
            shift
            ;;
        -e|--environment)
            fakechroot_environment=$1
            shift
            ;;
        -b|--bindir)
            fakechroot_bindir=$1
            shift
            ;;
        --)
            break
            ;;
    esac
done

if [ -z "$fakechroot_environment" ]; then
    fakechroot_next_cmd "$@"
fi


# Autodetect if dynamic linker supports --argv0 option
if [ -n "$FAKECHROOT_ELFLOADER" ]; then
    fakechroot_detect=`$FAKECHROOT_ELFLOADER --argv0 echo /data/data/jackpal.androidterm/root/data/gentoo/bin/echo yes 2>&1`
    if [ "$fakechroot_detect" = yes ]; then
        FAKECHROOT_ELFLOADER_OPT_ARGV0="--argv0"
        export FAKECHROOT_ELFLOADER_OPT_ARGV0
    fi
fi


# Make sure the preload is available
fakechroot_paths="$fakechroot_paths${LD_LIBRARY_PATH:+${fakechroot_paths:+:}$LD_LIBRARY_PATH}"
fakechroot_lib="$fakechroot_lib${LD_PRELOAD:+ $LD_PRELOAD}"

fakechroot_detect=`LD_LIBRARY_PATH="$fakechroot_paths" LD_PRELOAD="$fakechroot_lib" FAKECHROOT_DETECT=1 /data/data/jackpal.androidterm/root/data/gentoo/bin/echo 2>&1`
case "$fakechroot_detect" in
    fakechroot*)
        fakechroot_libfound=yes
        ;;
    *)
        fakechroot_libfound=no
esac

if [ $fakechroot_libfound = no ]; then
    fakechroot_die "fakechroot: preload library not found, aborting."
fi


# Additional environment setting from configuration file
if [ "$fakechroot_environment" != "none" ]; then
    for fakechroot_e in "$fakechroot_environment" "${fakechroot_environment%.*}" default; do
        for fakechroot_d in "$fakechroot_confdir" "$HOME/.fakechroot" "$fakechroot_sysconfdir"; do
            fakechroot_f="$fakechroot_d/$fakechroot_e.env"
            if [ -f "$fakechroot_f" ]; then
                . "$fakechroot_f"
                break 2
            fi
        done
    done
fi


# Check if substituted command is called
fakechroot_cmd=`command -v "$1"`

fakechroot_cmd_wrapper=`
    IFS=:
    for fakechroot_cmd_subst in $FAKECHROOT_CMD_SUBST; do
        case "$fakechroot_cmd_subst" in
            "$fakechroot_cmd="*)
                echo "${fakechroot_cmd_subst#*=}"
                break 2
                ;;
        esac
    done
`

# Set FAKECHROOT_CMD_ORIG if wrapped
if [ -n "$fakechroot_cmd_wrapper" ]; then
    FAKECHROOT_CMD_ORIG="$fakechroot_cmd"
    export FAKECHROOT_CMD_ORIG
fi

fakechroot_cmd=${fakechroot_cmd_wrapper:-$1}


# Execute command
if [ -z "$*" ]; then
    LD_LIBRARY_PATH="$fakechroot_paths" LD_PRELOAD="$fakechroot_lib" ${SHELL:-/bin/sh}
    exit $?
else
    if [ -n "$fakechroot_cmd" ]; then
        # Call substituted command
        shift
        LD_LIBRARY_PATH="$fakechroot_paths" LD_PRELOAD="$fakechroot_lib" "$fakechroot_cmd" "$@"
        exit $?
    else
        # Call original command
        LD_LIBRARY_PATH="$fakechroot_paths" LD_PRELOAD="$fakechroot_lib" "$@"
        exit $?
    fi
fi
