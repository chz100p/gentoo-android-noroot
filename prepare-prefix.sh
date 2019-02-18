#!/system/bin/sh

JACKPAL="/data/data/jackpal.androidterm"
JACKPAL_HOME="$JACKPAL/app_HOME"
FAKECHROOT_BASE="$JACKPAL/r"
EPREFIX="$FAKECHROOT_BASE/data/gentoo"
DOWNLOAD="/sdcard/Download"

export PATH="/system/bin"
hash -r

if [[ ! -e "$JACKPAL_HOME/bin/sh" ]]; then
  bb="$JACKPAL_HOME/bin/busybox"
  if [[ ! -e $bb ]]; then
    mkdir -p "$JACKPAL_HOME/bin" || exit 1
    uri="https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-armv7l"
    curl -k -L -o "$bb" "$uri" || exit 1
  fi
  chmod 755 "$bb" || exit 1
  #"$bb" --install -s "$JACKPAL_HOME/bin" || exit 1
  "$bb" --list | "$bb" xargs -n 1 -I {} "$bb" ln -s busybox "$JACKPAL_HOME/bin/{}" || exit 1
fi

export PATH="$JACKPAL_HOME/bin:/system/bin"
hash -r

if [[ ! -e "$EPREFIX/bin/bash" ]]; then
  f="$DOWNLOAD/prefix-stage3-armv7a_hardfp-latest.tar.xz"
  if [[ ! -e $f ]]; then
    uri="http://distfiles.gentoo.org/experimental/prefix/arm/prefix-stage3-armv7a_hardfp-latest.tar.xz"
    curl -k -L -o "$f" "$uri" || exit 1
  fi
  mkdir -p "$EPREFIX" || exit 1
  tar x -C "$EPREFIX/.." -f "$f" || exit 1
  if [[ ! -e "$EPREFIX/tmp" ]]; then
    mkdir -p "$EPREFIX/tmp" || exit 1
  fi
fi

#
unset LD_PRELOAD
export LD_LIBRARY_PATH="$EPREFIX/lib:$EPREFIX/usr/lib:$EPREFIX/usr/lib/binutils/armv7a-hardfloat-linux-gnueabi/2.30"
export PATH="$EPREFIX/usr/bin:$EPREFIX/bin"
export TMPDIR="$EPREFIX/tmp"

[[ -e $TMPDIR ]] || "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/mkdir" -p "$TMPDIR" || exit 1

[[ $("$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/bash" -c "echo prefix!") = "prefix!" ]] || exit 1

prfx_cc1() {
local o="$1";shift
local s="$1";shift
local b="$1";shift
"$EPREFIX/lib/ld-linux-armhf.so.3" \
 /data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../libexec/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/cc1 \
-quiet \
-iprefix /data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/ \
-isysroot /data/data/jackpal.androidterm/r/data/gentoo \
"$@" \
"$s" \
-dumpbase "$s" \
-quiet \
-march=armv7-a \
-mfloat-abi=hard \
-mfpu=vfpv3-d16 \
-mtls-dialect=gnu \
-auxbase "$b" \
-o "$o"
}

prfx_as() {
local o="$1";shift
local s="$1";shift
"$EPREFIX/lib/ld-linux-armhf.so.3" \
 /data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/binutils-bin/2.30/as \
-march=armv7-a \
-mfloat-abi=hard \
-mfpu=vfpv3-d16 \
-meabi=5 \
-o "$o" \
"$s"
}

prfx_ld() {
local o="$1";shift
"$EPREFIX/lib/ld-linux-armhf.so.3" \
 /data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/binutils-bin/2.30/ld \
-plugin /data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../libexec/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/liblto_plugin.so \
-plugin-opt=/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../libexec/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/lto-wrapper \
-plugin-opt=-fresolution=./ccYJAv6r.res \
-plugin-opt=-pass-through=-lgcc \
-plugin-opt=-pass-through=-lgcc_s \
-plugin-opt=-pass-through=-lc \
-plugin-opt=-pass-through=-lgcc \
-plugin-opt=-pass-through=-lgcc_s \
--eh-frame-hdr \
-dynamic-linker /data/data/jackpal.androidterm/r/data/gentoo/lib/ld-linux-armhf.so.3 \
-X -m armelf_linux_eabi -pie \
-o "$o" \
/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/../../../Scrt1.o \
/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/../../../crti.o \
/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/crtbeginS.o \
-L/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0 \
-L/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc \
-L/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/../../../../armv7a-hardfloat-linux-gnueabi/lib \
-L/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/../../.. \
-L/data/data/jackpal.androidterm/r/data/gentoo/lib \
-L/data/data/jackpal.androidterm/r/data/gentoo/usr/lib \
--sysroot=/data/data/jackpal.androidterm/r/data/gentoo/../.. \
"$@" \
-lgcc \
--as-needed \
-lgcc_s \
--no-as-needed \
-lc \
-lgcc \
--as-needed \
-lgcc_s \
--no-as-needed \
/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/crtendS.o \
/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/../../../crtn.o
}

prfx_ld_shared() {
local o="$1";shift
"$EPREFIX/lib/ld-linux-armhf.so.3" \
 /data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/binutils-bin/2.30/ld \
-plugin /data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../libexec/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/liblto_plugin.so \
-plugin-opt=/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../libexec/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/lto-wrapper \
-plugin-opt=-fresolution=/data/data/jackpal.androidterm/r/data/gentoo/tmp/ccoHVdeC.res \
-plugin-opt=-pass-through=-lgcc \
-plugin-opt=-pass-through=-lgcc_s \
-plugin-opt=-pass-through=-lc \
-plugin-opt=-pass-through=-lgcc \
-plugin-opt=-pass-through=-lgcc_s \
--eh-frame-hdr \
-shared \
-X \
-m armelf_linux_eabi \
-o "$o" \
/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/../../../crti.o \
/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/crtbeginS.o \
-L/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0 \
-L/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc \
-L/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/../../../../armv7a-hardfloat-linux-gnueabi/lib \
-L/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/../../.. \
-L/data/data/jackpal.androidterm/r/data/gentoo/lib \
-L/data/data/jackpal.androidterm/r/data/gentoo/usr/lib \
--sysroot=/data/data/jackpal.androidterm/r/data/gentoo/../.. \
-ldl \
"$@" \
-lgcc \
--as-needed \
-lgcc_s \
--no-as-needed \
-lc \
-lgcc \
--as-needed \
-lgcc_s \
--no-as-needed \
/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/crtendS.o \
/data/data/jackpal.androidterm/r/data/gentoo/usr/armv7a-hardfloat-linux-gnueabi/gcc-bin/7.3.0/../../../lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0/../../../crtn.o
}


HELLO_DIR="$EPREFIX/home/chz100p/workspace/hello"
if [[ ! -x "$HELLO_DIR/hello" ]]; then
[[ -e $HELLO_DIR ]] || "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/mkdir" -p "$HELLO_DIR" || exit 1

"$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/rm" -f "$HELLO_DIR"/hello{.c,.s,.o,}

echo '
#include <stdlib.h>
#include <stdio.h>
int main()
{
  printf("hello!\\n");
  return 0;
}
' > "$HELLO_DIR/hello.c"

prfx_cc1 "$HELLO_DIR/hello.s" "$HELLO_DIR/hello.c" "$HELLO_DIR/hello"
prfx_as  "$HELLO_DIR/hello.o" "$HELLO_DIR/hello.s"
prfx_ld  "$HELLO_DIR/hello"   "$HELLO_DIR/hello.o"

[[ $("$HELLO_DIR/hello") = "hello!" ]] || exit 1

fi

if [[ ! -x "$EPREFIX/home/chz100p/bin/fakechroot" ]]; then
FAKECHROOT_DIR="$EPREFIX/home/chz100p/workspace/fakechroot-master"
if [[ ! -x "$FAKECHROOT_DIR/scripts/fakechroot" ]]; then
  f="$DOWNLOAD/fakechroot-2.19.tar.gz"
  if [[ ! -e $f ]]; then
    uri="https://github.com/dex4er/fakechroot/archive/master/2.19.tar.gz"
    LD_PRELOAD= LD_LIBRARY_PATH=/system/lib /system/bin/curl -k -L -o "$f" "$uri" || exit 1
  fi
[[ ! -e $FAKECHROOT_DIR ]] || "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/rm" -fr "$FAKECHROOT_DIR" || exit 1
[[ -e $FAKECHROOT_DIR ]] || "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/mkdir" -p "$FAKECHROOT_DIR" || exit 1
  "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/cat" "$f" \
  | "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/gzip" -d \
  | "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/tar" x -C "$FAKECHROOT_DIR/.." -f - || exit 1

[[ -e "$FAKECHROOT_DIR/config.h" ]] || "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/cp" "/sdcard/Download/fakechroot_config.h" "$FAKECHROOT_DIR/config.h" || exit 1

objs=( )
for f in $FAKECHROOT_DIR/src/*.c; do
  #echo $f
prfx_cc1 "${f}.s" "${f}" "$FAKECHROOT_DIR/src/libfakechroot.so" "-fPIC -I$FAKECHROOT_DIR" || exit 1
prfx_as "${f}.o" "${f}.s" || exit 1
objs+=( "${f}.o" )
done
prfx_ld_shared "$FAKECHROOT_DIR/src/libfakechroot.so" "${objs[@]}" || exit 1

"$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/sed" \
-e "s:@VERSION@:2.19:g" \
-e "s:@SHELL@:$EPREFIX/bin/sh:g" \
-e "s:@ECHO@:$EPREFIX/bin/echo:g" \
-e "s:@libpath@:$EPREFIX/home/chz100p/lib/libfakechroot.so:g" \
-e "s:@sysconfdir@:$EPREFIX/home/chz100p/etc:g" \
< "$FAKECHROOT_DIR/scripts/fakechroot.sh" \
> "$FAKECHROOT_DIR/scripts/fakechroot" \
|| exit 1
"$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/chmod" +x "$FAKECHROOT_DIR/scripts/fakechroot" || exit 1

fi
[[ -d "$EPREFIX/home/chz100p/lib" ]] || "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/mkdir" -p "$EPREFIX/home/chz100p/lib" || exit 1
[[ -e "$EPREFIX/home/chz100p/lib/libfakechroot.so" ]] || "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/cp" "$FAKECHROOT_DIR/src/libfakechroot.so" "$EPREFIX/home/chz100p/lib/libfakechroot.so" || exit 1
[[ -d "$EPREFIX/home/chz100p/bin" ]] || "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/mkdir" -p "$EPREFIX/home/chz100p/bin" || exit 1
[[ -x "$EPREFIX/home/chz100p/bin/fakechroot" ]] || "$EPREFIX/lib/ld-linux-armhf.so.3" "$EPREFIX/bin/cp" "$FAKECHROOT_DIR/scripts/fakechroot" "$EPREFIX/home/chz100p/bin/fakechroot" || exit 1
fi


