#!/system/bin/sh

jackpal="/data/data/jackpal.androidterm"
jackpal_home="${jackpal}/app_HOME"
root="${jackpal}/r"
eprefix="${root}/data/gentoo"
download="/sdcard/Download"

bb="${jackpal_home}/bin/busybox"
if [[ ! -e "${jackpal_home}/bin/sh" ]]; then
  export PATH="/system/bin"
  hash -r

  if [[ ! -e $bb ]]; then
    mkdir -p "${jackpal_home}/bin" || exit 1
    uri="https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-armv7l"
    curl -k -L -o "$bb" "$uri" || exit 1
  fi
  chmod 755 "$bb" || exit 1
  #"$bb" --install -s "${jackpal_home}/bin" || exit 1
  "$bb" --list | "$bb" xargs -n 1 -I {} "$bb" ln -s busybox "${jackpal_home}/bin/{}" || exit 1

  if [[ ! -e "${jackpal_home}/bin/patchelf" ]]; then
    "$bb" cp "${download}/patchelf" "${jackpal_home}/bin/patchelf" || exit 1
    "$bb" chmod +x "${jackpal_home}/bin/patchelf" || exit 1
  fi
fi

prfx="/sdcard/prfx"
prfx_orig="/data/gentoo"
ld_linux_prfx="${root}/l/l"
ld_linux_orig="${prfx_orig}/lib/ld-linux-armhf.so.3"

prfx_patchbin() {
echo "$@"
local prfx="/sdcard/prfx"
local prfx_orig="/data/gentoo"

if [[ $# = 4 ]] ; then
 [[ ${#3} = ${#4} ]]  || exit 1
 prfx_orig="$3"
 prfx="$4"
fi

od -A n -t x1 -v "$1" \
 | tr -Cd '0123456789abcdef ' \
 | sed -e "s:$(echo -n "$prfx_orig" | od -A n -t x1 -v | tr -Cd '0123456789abcdef ' ):$(echo -n "$prfx" | od -A n -t x1 -v | tr -Cd '0123456789abcdef ' ):g" \
       -e "s:.\(..\):\\\\\\\\x\1:g" \
       -e "s:.\{$(( 5 * 50 ))\}:\0\n:g" \
 | xargs -n 1 echo -n -e > "$2"
}

prfx_patchtxt() {
 if grep -Eo "(${root})?${prfx_orig}" "$1" | grep -q "^${prfx_orig}\$" ; then
  echo "$@"
  sed -i -e "s:${prfx_orig}:${eprefix}:g" -e "s:${root}${root}:${root}:g" "$1" || exit 1
 fi
}

prfx_patchelf() {
 if [[ $(patchelf --print-interpreter "$1") = "$ld_linux_orig" ]] ; then
  echo "$@"
  patchelf --set-interpreter "$ld_linux_prfx" "$1" || exit 1
 fi
}

if [[ ! -e "${eprefix}/bin/bash" ]]; then
  export PATH="${jackpal_home}/bin:/system/bin"
  hash -r

  f="${download}/prefix-stage3-armv7a_hardfp-latest.tar.xz"
  if [[ ! -e $f ]]; then
    uri="http://distfiles.gentoo.org/experimental/prefix/arm/prefix-stage3-armv7a_hardfp-latest.tar.xz"
    curl -k -L -o "$f" "$uri" || exit 1
  fi
  mkdir -p "${eprefix}" || exit 1
  EXTRACT_UNSAFE_SYMLINKS=1 tar x -C "${eprefix}/.." -f "$f" || exit 1
fi

if [[ ! -x "$ld_linux_prfx" ]]; then
  export PATH="${jackpal_home}/bin:/system/bin"
  hash -r

[[ -e "${root}${root}" ]] || ln -s "../../.." "${root}${root}" || exit 1

[[ -e "${eprefix}/home" ]] || mkdir -p "${eprefix}/home" || exit 1
[[ -e "${eprefix}/tmp" ]] || mkdir -p "${eprefix}/tmp" || exit 1
[[ -e "${root}/l" ]] || mkdir -p "${root}/l" || exit 1
[[ -e "${prfx}/etc" ]] || mkdir -p "${prfx}/etc" || exit 1

[[ -e "${root}/proc" ]] || ln -s "/proc" "${root}/proc" || exit 1
[[ -e "${root}/sys" ]] || ln -s "/sys" "${root}/sys" || exit 1
[[ -e "${root}/dev" ]] || mkdir -p "${root}/dev" || exit 1
[[ -e "${root}/dev/null" ]] || ln -s "/dev/null" "${root}/dev/null" || exit 1
[[ -e "${root}/dev/random" ]] || ln -s "/dev/random" "${root}/dev/random" || exit 1
[[ -e "${root}/dev/fd" ]] || ln -s "/proc/self/fd" "${root}/dev/fd" || exit 1
for d in bin etc home lib sbin tmp usr var; do
  [[ -e "${root}/${d}" ]] || ln -s "${eprefix#/}/${d}" "${root}/${d}" || exit 1
done

prfx_patchtxt "${eprefix}/etc/ld.so.conf"
${eprefix}/sbin/ldconfig -X -f "${eprefix}/etc/ld.so.conf" -C "${eprefix}/etc/ld.so.cache"
cp "${eprefix}/etc/ld.so.cache" "$prfx/etc/ld.so.cache"

[[ -e "${ld_linux_prfx}" ]] \
 || prfx_patchbin "${root}${ld_linux_orig}" "${ld_linux_prfx}" "/data/gentoo/etc" "/sdcard/prfx/etc" \
 || exit 1
[[ -x "$ld_linux_prfx" ]] || chmod +x "$ld_linux_prfx" || exit 1

if [[ ! -e "${eprefix}/usr/lib/libmagic.so.1.0.0.orig" ]] ; then
 echo "${eprefix}/usr/lib/libmagic.so.1.0.0"
 mv "${eprefix}/usr/lib/libmagic.so.1.0.0" "${eprefix}/usr/lib/libmagic.so.1.0.0.orig" || exit 1
 prfx_patchbin \
  "${eprefix}/usr/lib/libmagic.so.1.0.0.orig" \
  "${eprefix}/usr/lib/libmagic.so.1.0.0" \
 || exit 1
 chmod +x \
  "${eprefix}/usr/lib/libmagic.so.1.0.0" \
 || exit 1
fi
if [[ ! -e "$prfx/usr/share/misc/magic.mgc" ]] ; then
 echo "$prfx/usr/share/misc/magic.mgc"
 mkdir -p "$prfx/usr/share/misc" || exit 1
 cp "${eprefix}/usr/share/misc/magic.mgc" "$prfx/usr/share/misc/magic.mgc" || exit 1
fi

[[ -e "${eprefix}/usr/bin/armv7a-hardfloat-linux-gnueabi-strings" ]] \
|| ln -sf "${eprefix}/usr/armv7a-hardfloat-linux-gnueabi/bin/strings" "${eprefix}/usr/bin/armv7a-hardfloat-linux-gnueabi-strings" \
|| exit 1
prfx_patchelf "${eprefix}/usr/armv7a-hardfloat-linux-gnueabi/bin/strings"

prfx_patchelf "${eprefix}/bin/bash"
prfx_patchelf "${eprefix}/bin/sed"
prfx_patchelf "${eprefix}/bin/grep"
prfx_patchelf "${eprefix}/bin/tr"
prfx_patchelf "${eprefix}/bin/cat"
prfx_patchelf "${eprefix}/bin/head"
prfx_patchelf "${eprefix}/bin/tail"
prfx_patchelf "${eprefix}/bin/rm"
prfx_patchelf "${eprefix}/bin/mv"
prfx_patchelf "${eprefix}/bin/cp"
prfx_patchelf "${eprefix}/bin/ln"
prfx_patchelf "${eprefix}/bin/chmod"
prfx_patchelf "${eprefix}/bin/mkdir"
prfx_patchelf "${eprefix}/bin/rmdir"
prfx_patchelf "${eprefix}/bin/ls"
prfx_patchelf "${eprefix}/bin/readlink"
prfx_patchelf "${eprefix}/usr/bin/find"
prfx_patchelf "${eprefix}/usr/bin/xargs"
prfx_patchelf "${eprefix}/usr/bin/od"
prfx_patchelf "${eprefix}/usr/bin/test"
prfx_patchelf "${eprefix}/usr/bin/realpath"
prfx_patchelf "${eprefix}/usr/bin/file"
fi

if [[ $1 < 3 ]]; then
  shift
  TMPDIR="${eprefix}/tmp" \
  LD_PRELOAD= \
  LD_LIBRARY_PATH= \
  exec "${eprefix}/bin/bash" $0 3 "$@"
fi

##!/data/gentoo/bin/bash
export PATH="${eprefix}/usr/bin:${eprefix}/bin:${jackpal_home}/bin"
hash -r
export TMPDIR="${eprefix}/tmp"
unset LD_PRELOAD
unset LD_LIBRARY_PATH

find ${eprefix} -type l ! -exec test -e {} \; -print | while read f ; do
 l="$(readlink -n "$f")"
 if [[ ${l#${prfx_orig}} != ${l} ]] ; then
  echo "$f"
  ln -sf "${eprefix}${l#${prfx_orig}}" "$f" || exit 1
 fi
done

##find usr/bin -type l | while read f;do if [[ $(basename $(readlink $f)) = "python-exec2" && -e "usr/lib/python-exec/python2.7/$(basename $f)" ]]; then echo $f; ln -sf "../lib/python-exec/python2.7/$(basename "$f")" "$f";fi;done^C
##find usr/sbin -type l | while read f;do if [[ $(basename $(readlink $f)) = "python-exec2" && -e "usr/lib/python-exec/python2.7/$(basename $f)" ]]; then echo $f; ln -sf "../lib/python-exec/python2.7/$(basename "$f")" "$f";fi;done^C

#find . -type f ! -path './usr/portage/*' ! -path './home/*' -print | while read f; do [[ $(file -b "$f") = *text* ]] && grep -q /data/gentoo "$f" && echo "$f"; done | tee log

##find 'usr/armv7a-hardfloat-linux-gnueabi/binutils-bin/2.30/' -type f | while read f;do if [[ $(patchelf --print-interpreter "$f") = "/data/gentoo/lib/ld-linux-armhf.so.3" ]]; then echo $f; patchbin-prfx "$f" "${f}.patched" "/data/gentoo/lib/ld-linux-armhf.so.3" "/data/data/jackpal.androidterm/g/ld-" || exit 1; mv "${f}.patched" "$f" || exit 1; chmod +x "$f" || exit 1; fi; done
find "${eprefix}/usr/armv7a-hardfloat-linux-gnueabi/binutils-bin/2.30/" -type f \
| while read f;do
  if strings "$f" | grep -q "${ld_linux_orig}"; then
    echo $f
    prfx_patchbin "$f" "${f}.patched" "${ld_linux_orig}" "${ld_linux_prfx}" || exit 1
    mv "${f}.patched" "$f" || exit 1
    chmod +x "$f" || exit 1
  fi
done

##find . -type d -path ./usr/portage -prune -o -type f -name 'ld-*.so*' -prune -o -type f -name 'lib*.so*' -prune -o -type f | while read f;do if [[ $(file "$f") = *ELF*/data/gentoo/lib/ld-linux-armhf.so.3* ]];then echo $f;patchelf-prfx "$f";fi;done
##find . -type d -path ./usr/portage -prune -o -type f -name 'ld-*.so*' -prune -o -type f -name 'lib*.so*' -prune -o -type f | while read f;do if [[ $(file "$f") = *text* && $(head -n 1 "$f") = '#!'*/data/gentoo/* ]];then echo $f;patchtxt-prfx "$f";fi;done
find "${eprefix}" -type d -path "${eprefix}/usr/portage" -prune -o -type f -name 'ld-*.so*' -prune -o -type f -name 'lib*.so*' -prune -o -type f \
| while read f; do
  ff="$(file -b "$f")"
  if [[ $ff = *ELF*/data/gentoo/lib/ld-linux-armhf.so.3* ]]; then
    patchelf-prfx "$f"
  elif [[ $ff = *text* && $(head -n 1 "$f") = '#!'*/data/gentoo/* ]]; then
    prfx_patchtxt "$f"
  fi
done

exit 0

\

#
ld_linux="${eprefix}/lib/ld-linux-armhf.so.3"
unset LD_PRELOAD
export LD_LIBRARY_PATH="${eprefix}/lib:${eprefix}/usr/lib:${eprefix}/usr/lib/binutils/armv7a-hardfloat-linux-gnueabi/2.30"
export PATH="${eprefix}/usr/bin:${eprefix}/bin"
export TMPDIR="${eprefix}/tmp"

[[ -e $TMPDIR ]] || "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/mkdir" -p "$TMPDIR" || exit 1

[[ $("${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/bash" -c "echo prefix!") = "prefix!" ]] || exit 1

prfx_cc1() {
local o="$1";shift
local s="$1";shift
local b="$1";shift
"${eprefix}/lib/ld-linux-armhf.so.3" \
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
"${eprefix}/lib/ld-linux-armhf.so.3" \
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
"${eprefix}/lib/ld-linux-armhf.so.3" \
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
"${eprefix}/lib/ld-linux-armhf.so.3" \
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


HELLO_DIR="${eprefix}/home/chz100p/workspace/hello"
if [[ ! -x "$HELLO_DIR/hello" ]]; then
[[ -e $HELLO_DIR ]] || "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/mkdir" -p "$HELLO_DIR" || exit 1

"${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/rm" -f "$HELLO_DIR"/hello{.c,.s,.o,}

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

if [[ ! -x "${eprefix}/home/chz100p/bin/fakechroot" ]]; then
FAKECHROOT_DIR="${eprefix}/home/chz100p/workspace/fakechroot-master"
if [[ ! -x "$FAKECHROOT_DIR/scripts/fakechroot" ]]; then
  f="${download}/fakechroot-2.19.tar.gz"
  if [[ ! -e $f ]]; then
    uri="https://github.com/dex4er/fakechroot/archive/master/2.19.tar.gz"
    LD_PRELOAD= LD_LIBRARY_PATH=/system/lib /system/bin/curl -k -L -o "$f" "$uri" || exit 1
  fi
[[ ! -e $FAKECHROOT_DIR ]] || "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/rm" -fr "$FAKECHROOT_DIR" || exit 1
[[ -e $FAKECHROOT_DIR ]] || "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/mkdir" -p "$FAKECHROOT_DIR" || exit 1
  "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/cat" "$f" \
  | "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/gzip" -d \
  | "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/tar" x -C "$FAKECHROOT_DIR/.." -f - || exit 1

[[ -e "$FAKECHROOT_DIR/config.h" ]] || "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/cp" "/sdcard/Download/fakechroot_config.h" "$FAKECHROOT_DIR/config.h" || exit 1

objs=( )
for f in $FAKECHROOT_DIR/src/*.c; do
  #echo $f
prfx_cc1 "${f}.s" "${f}" "$FAKECHROOT_DIR/src/libfakechroot.so" "-fPIC -I$FAKECHROOT_DIR" || exit 1
prfx_as "${f}.o" "${f}.s" || exit 1
objs+=( "${f}.o" )
done
prfx_ld_shared "$FAKECHROOT_DIR/src/libfakechroot.so" "${objs[@]}" || exit 1

"${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/sed" \
-e "s:@VERSION@:2.19:g" \
-e "s:@SHELL@:${eprefix}/bin/sh:g" \
-e "s:@ECHO@:${eprefix}/bin/echo:g" \
-e "s:@libpath@:${eprefix}/home/chz100p/lib/libfakechroot.so:g" \
-e "s:@sysconfdir@:${eprefix}/home/chz100p/etc:g" \
< "$FAKECHROOT_DIR/scripts/fakechroot.sh" \
> "$FAKECHROOT_DIR/scripts/fakechroot" \
|| exit 1
"${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/chmod" +x "$FAKECHROOT_DIR/scripts/fakechroot" || exit 1

fi
[[ -d "${eprefix}/home/chz100p/lib" ]] || "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/mkdir" -p "${eprefix}/home/chz100p/lib" || exit 1
[[ -e "${eprefix}/home/chz100p/lib/libfakechroot.so" ]] || "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/cp" "$FAKECHROOT_DIR/src/libfakechroot.so" "${eprefix}/home/chz100p/lib/libfakechroot.so" || exit 1
[[ -d "${eprefix}/home/chz100p/bin" ]] || "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/mkdir" -p "${eprefix}/home/chz100p/bin" || exit 1
[[ -x "${eprefix}/home/chz100p/bin/fakechroot" ]] || "${eprefix}/lib/ld-linux-armhf.so.3" "${eprefix}/bin/cp" "$FAKECHROOT_DIR/scripts/fakechroot" "${eprefix}/home/chz100p/bin/fakechroot" || exit 1
fi

exit 1

#!/system/bin/sh
##!/data/data/jackpal.androidterm/app_HOME/bin/sh

eprefix="/data/data/jackpal.androidterm/gentoo"
user="chz100p"
home="${eprefix}/home/$user"
prfx="/sdcard/prfx"
prfx_orig="/data/gentoo"

ld_linux_prfx="${eprefix}/lib/ld-linux-armhf.so.3.prfx"
ld_linux_orig="$prfx_orig/lib/ld-linux-armhf.so.3"

prfx_patchelf() {
 if [[ $(patchelf --print-interpreter "$1") = "$ld_linux_orig" ]] ; then
  patchelf --set-interpreter "$ld_linux_prfx" "$1" || exit 1
 fi
}

_prfx_patchbin() {
 od -A n -t x1 -v "$1" \
  | tr -Cd '0123456789abcdef ' \
  | sed -e "s:$(echo -n "$3" | od -A n -t x1 -v | tr -Cd '0123456789abcdef ' ):$(echo -n "$4" | od -A n -t x1 -v | tr -Cd '0123456789abcdef ' ):g" \
  | sed -e "s:.\(..\):\1\n:g" \
  | ( while read b; do
       echo -n "\x$b"
    done ) > "$2"
}
prfx_patchbin() {
 _prfx_patchbin "$1" "$2" "$prfx_orig" "$prfx"
}

prfx_patchtxt() {
 if grep -q "$prfx_orig" "$1" ; then
  sed -i -e "s:$prfx_orig:${eprefix}:g" "$1" || exit 1
 fi
}

[[ -e "$prfx/etc" ]] || mkdir -p "$prfx/etc" || exit 1
#[[ -e "$prfx/lib" ]] || mkdir -p "$prfx/lib" || exit 1
#[[ -e "$prfx/lib/ld-linux-armhf.so.3" ]] \
# || prfx_patchbin "${eprefix}/lib/ld-linux-armhf.so.3" "$prfx/lib/ld-linux-armhf.so.3" \
# || exit 1
[[ -e "$ld_linux_prfx" ]] \
 || prfx_patchbin "${eprefix}/lib/ld-linux-armhf.so.3" "$ld_linux_prfx" \
 || exit 1
[[ -x "$ld_linux_prfx" ]] || chmod +x "$ld_linux_prfx" || exit 1
[[ -e "${eprefix}/tmp" ]] || mkdir -p "${eprefix}/tmp" || exit 1
[[ -e "$home/bin" ]] || mkdir -p "$home/bin" || exit 1
[[ -e "$home/bin/ldconfig" ]] \
 || ( \
  cat > "$home/bin/ldconfig" <<EOF || exit 1
#!${eprefix}/bin/bash
if [[ \$# = 0 ]] ; then
 ${eprefix}/sbin/ldconfig -f "${eprefix}/etc/ld.so.conf" -c "${eprefix}/etc/ld.so.cache" || exit 1
 cp "${eprefix}/etc/ld.so.cache" "$prfx/etc/ld.so.cache" || exit 1
 exit 0
else
 exec ${eprefix}/sbin/ldconfig "\$@"
fi
EOF
  chmod +x "$home/bin/ldconfig" || exit 1
 ) \
 || exit 1

prfx_patchelf "${eprefix}/bin/bash"
prfx_patchelf "${eprefix}/bin/ls"

prfx_patchtxt "${eprefix}/etc/ld.so.conf"
${eprefix}/sbin/ldconfig -f "${eprefix}/etc/ld.so.conf" -C "${eprefix}/etc/ld.so.cache"
cp "${eprefix}/etc/ld.so.cache" "$prfx/etc/ld.so.cache"

find ${eprefix} -type l ! -exec test -e {} \; -print | while read f ; do
 l="$(readlink -n "$f")"
 if echo "$l" | grep -q "$prfx_orig" ; then
  echo "$f"
  l1=$(echo -n "$l" | sed -e "s:$prfx_orig:${eprefix}/:")
  ln -sf "$l1" "$f" || exit 1
 fi
done

if [[ ! -e "${eprefix}/usr/lib/libmagic.so.1.0.0.orig" ]] ; then
 mv "${eprefix}/usr/lib/libmagic.so.1.0.0" "${eprefix}/usr/lib/libmagic.so.1.0.0.orig" || exit 1
 prfx_patchbin \
  "${eprefix}/usr/lib/libmagic.so.1.0.0.orig" \
  "${eprefix}/usr/lib/libmagic.so.1.0.0" \
 || exit 1
fi
if [[ ! -e "$prfx/usr/share/misc/magic.mgc" ]] ; then
 mkdir -p "$prfx/usr/share/misc" || exit 1
 cp "${eprefix}/usr/share/misc/magic.mgc" "$prfx/usr/share/misc/magic.mgc" || exit 1
fi

##find usr/bin -type l | while read f;do if [[ $(basename $(readlink $f)) = "python-exec2" && -e "usr/lib/python-exec/python2.7/$(basename $f)" ]]; then echo $f; ln -sf "../lib/python-exec/python2.7/$(basename "$f")" "$f";fi;done^C
##find usr/sbin -type l | while read f;do if [[ $(basename $(readlink $f)) = "python-exec2" && -e "usr/lib/python-exec/python2.7/$(basename $f)" ]]; then echo $f; ln -sf "../lib/python-exec/python2.7/$(basename "$f")" "$f";fi;done^C

#find . -type f ! -path './usr/portage/*' ! -path './home/*' -print | while read f; do [[ $(file -b "$f") = *text* ]] && grep -q /data/gentoo "$f" && echo "$f"; done | tee log

##find 'usr/armv7a-hardfloat-linux-gnueabi/binutils-bin/2.30/' -type f | while read f;do if [[ $(patchelf --print-interpreter "$f") = "/data/gentoo/lib/ld-linux-armhf.so.3" ]]; then echo $f; patchbin-prfx "$f" "${f}.patched" "/data/gentoo/lib/ld-linux-armhf.so.3" "/data/data/jackpal.androidterm/g/ld-" || exit 1; mv "${f}.patched" "$f" || exit 1; chmod +x "$f" || exit 1; fi; done
##find . -type d -path ./usr/portage -prune -o -type f -name 'ld-*.so*' -prune -o -type f -name 'lib*.so*' -prune -o -type f | while read f;do if [[ $(file "$f") = *text* && $(head -n 1 "$f") = '#!'*/data/gentoo/* ]];then echo $f;patchtxt-prfx "$f";fi;done
##find . -type d -path ./usr/portage -prune -o -type f -name 'ld-*.so*' -prune -o -type f -name 'lib*.so*' -prune -o -type f | while read f;do if [[ $(file "$f") = *ELF*/data/gentoo/lib/ld-linux-armhf.so.3* ]];then echo $f;patchelf-prfx "$f";fi;done

exit 0



find ${eprefix} | while read f ; do
if [[ -x $f ]] && i=$(patchelf --print-interpreter "$f" 2>/dev/null) ; then
 if echo $i | grep -q -e "/data/gentoo/" ; then
  echo "$f : $i"
  i1=$(echo $i | sed -e "s:/data/gentoo/:${eprefix}/:")
  patchelf --set-interpreter "$i1" "$f" 
 elif echo $i | grep -q -v -e "${eprefix}" ; then
  echo "$f : $i"
 fi
elif [[ -L $f && ! -e $f ]] ; then
 l=$(readlink -n "$f")
 if echo $l | grep -q -e "/data/gentoo/" ; then
  echo "$f -> $l"
  l1=$(echo $l | sed -e "s:/data/gentoo/:${eprefix}/:")
  rm "$f" || exit 1
  ln -s "$l1" "$f" || exit 1
 else
  echo "$f -> $l"
 fi
elif i=$(strings "$f"|head -n1) && echo $i | grep -q -e '^#!' ; then
 if echo $i | grep -q -e '^#! */data/gentoo/' ; then
  echo "$f : $i"
  sed -i -e "s:/data/gentoo:${eprefix}:g" "$f" || exit 1
 elif echo $i | grep -q -e '^#! *\(/usr\)\?/bin/' ; then
  echo "$f : $i"
  sed -i -e "s:^#! *:#!${eprefix}:" "$f" || exit 1
 elif echo $i | grep -q -v -e "${eprefix}" ; then
  echo "$f : $i"
 fi
fi
done

find ${eprefix}/etc/env.d -type f -exec grep -q /data/gentoo {} \; -print | while read f ; do
	echo ${f}
	sed -i -e "s:/data/gentoo:${eprefix}:g" "$f" || exit 1
done

find ${eprefix}/etc/portage -type f -exec grep -q /data/gentoo {} \; -print | while read f ; do
	echo ${f}
	sed -i -e "s:/data/gentoo:${eprefix}:g" "$f" || exit 1
done

[[ -d "${eprefix}/home/chz100p/bin" ]] || mkdir -p "${eprefix}/home/chz100p/bin" || exit 1
[[ -d "${eprefix}/home/chz100p/tmp" ]] || mkdir -p "${eprefix}/home/chz100p/tmp" || exit 1
[[ -d "${eprefix}/tmp" ]] || mkdir -p "${eprefix}/tmp" || exit 1

exit 0

#!/data/data/jackpal.androidterm/app_HOME/bin/sh

# What is our prefix?
EPREFIX="/data/data/jackpal.androidterm/gentoo"

#!/system/bin/sh
##!/data/data/jackpal.androidterm/gentoo/bin/bash
##!/data/data/jackpal.androidterm/app_HOME/bin/sh

eprefix="/data/data/jackpal.androidterm/r/data/gentoo"
exit 0

#
 | xargs -n 1 echo -n -e > "$2"

#
 | while read b; do echo -n -e "$b"; done > "$2"

