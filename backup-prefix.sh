#sh /sdcard/Download/start-bash.sh

root="/data/data/jackpal.androidterm/r"
txz="/sdcard/Download/backup-prefix-$(date '+%Y%m%d%H%M%S').txz"

( cd "${root}" && \
find . \
-path ./data/gentoo/usr/portage -print0 -prune -o \
-path ./data/gentoo/tmp -print0 -prune -o \
-path ./home/chz100p/workspace -print0 -prune -o \
-print0 ) | \
tar c -v --xz --no-recursion --null -T - -f "${txz}"

#tar x -C "${root}" -f "${txz}"
