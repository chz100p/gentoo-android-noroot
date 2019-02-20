/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/* Define to the type of arg 1 for `bind'. */
#define BIND_TYPE_ARG1(_) int _

/* Define to the type of arg 2 for `bind'. */
#define BIND_TYPE_ARG2(_) __CONST_SOCKADDR_ARG _

/* Define to the type of arg 3 for `bind'. */
#define BIND_TYPE_ARG3(_) socklen_t _

/* Define to the type of return value for `bind'. */
#define BIND_TYPE_RETURN int

/* Define to the type of arg 1 for `connect'. */
#define CONNECT_TYPE_ARG1(_) int _

/* Define to the type of arg 2 for `connect'. */
#define CONNECT_TYPE_ARG2(_) __CONST_SOCKADDR_ARG _

/* Define to the type of arg 3 for `connect'. */
#define CONNECT_TYPE_ARG3(_) socklen_t _

/* Define to the type of return value for `connect'. */
#define CONNECT_TYPE_RETURN int

/* Define to one of `_getb67', `GETB67', `getb67' for Cray-2 and Cray-YMP
   systems. This function is required for `alloca.c' support on those systems.
   */
/* #undef CRAY_STACKSEG_END */

/* Define to 1 if using `alloca.c'. */
/* #undef C_ALLOCA */

/* FAKECHROOT */
#define FAKECHROOT PACKAGE_VERSION

/* Define to the type of arg 1 for `fts64_open'. */
#define FTS64_OPEN_TYPE_ARG1(_) char * const *_

/* Define to the type of arg 2 for `fts64_open'. */
#define FTS64_OPEN_TYPE_ARG2(_) int

/* Define to the type of arg 3 for `fts64_open'. */
#define FTS64_OPEN_TYPE_ARG3(_) int (*_)(const FTSENTRY **, const FTSENTRY **)

/* Define to the type of return value for `fts64_open'. */
#define FTS64_OPEN_TYPE_RETURN FTSOBJ *

/* Define to the type of arg 1 for `fts_open'. */
#define FTS_OPEN_TYPE_ARG1(_) char * const *_

/* Define to the type of arg 2 for `fts_open'. */
#define FTS_OPEN_TYPE_ARG2(_) int

/* Define to the type of arg 3 for `fts_open'. */
#define FTS_OPEN_TYPE_ARG3(_) int (*_)(const FTSENTRY **, const FTSENTRY **)

/* Define to the type of return value for `fts_open'. */
#define FTS_OPEN_TYPE_RETURN FTSOBJ *

/* Define to the type of arg 1 for `getpeername'. */
#define GETPEERNAME_TYPE_ARG1(_) int _

/* Define to the type of arg 2 for `getpeername'. */
#define GETPEERNAME_TYPE_ARG2(_) __SOCKADDR_ARG _

/* Define to the type of arg 3 for `getpeername'. */
#define GETPEERNAME_TYPE_ARG3(_) socklen_t *__restrict _

/* Define to the type of return value for `getpeername'. */
#define GETPEERNAME_TYPE_RETURN int

/* Define to the type of arg 1 for `getsockname'. */
#define GETSOCKNAME_TYPE_ARG1(_) int _

/* Define to the type of arg 2 for `getsockname'. */
#define GETSOCKNAME_TYPE_ARG2(_) __SOCKADDR_ARG _

/* Define to the type of arg 3 for `getsockname'. */
#define GETSOCKNAME_TYPE_ARG3(_) socklen_t *__restrict _

/* Define to the type of return value for `getsockname'. */
#define GETSOCKNAME_TYPE_RETURN int

/* Define to 1 if you have the `access' function. */
#define HAVE_ACCESS 1

/* Define to 1 if you have the `acct' function. */
#define HAVE_ACCT 1

/* Define to 1 if you have `alloca', as a function or macro. */
#define HAVE_ALLOCA 1

/* Define to 1 if you have <alloca.h> and it should be used (not on Ultrix).
   */
#define HAVE_ALLOCA_H 1

/* Define to 1 if you have the `audit_log_acct_message' function. */
/* #undef HAVE_AUDIT_LOG_ACCT_MESSAGE */

/* Define to 1 if you have the `bind' function. */
#define HAVE_BIND 1

/* Define to 1 if you have the `bindtextdomain' function. */
#define HAVE_BINDTEXTDOMAIN 1

/* Define to 1 if the type of arg 1 for `bind' is `int _' */
#define HAVE_BIND_TYPE_ARG1_INT__ 1

/* Define to 1 if the type of arg 2 for `bind' is `const struct sockaddr *_'
   */
/* #undef HAVE_BIND_TYPE_ARG2_CONST_STRUCT_SOCKADDR_P_ */

/* Define to 1 if the type of arg 2 for `bind' is `__CONST_SOCKADDR_ARG _' */
#define HAVE_BIND_TYPE_ARG2___CONST_SOCKADDR_ARG__ 1

/* Define to 1 if the type of arg 3 for `bind' is `socklen_t _' */
#define HAVE_BIND_TYPE_ARG3_SOCKLEN_T__ 1

/* Define to 1 if the type of return value for `bind' is `int' */
#define HAVE_BIND_TYPE_RETURN_INT 1

/* Define to 1 if you have the `canonicalize_file_name' function. */
#define HAVE_CANONICALIZE_FILE_NAME 1

/* Define to 1 if you have the `chdir' function. */
#define HAVE_CHDIR 1

/* Define to 1 if you have the `chmod' function. */
#define HAVE_CHMOD 1

/* Define to 1 if you have the `chown' function. */
#define HAVE_CHOWN 1

/* Define to 1 if you have the `chroot' function. */
#define HAVE_CHROOT 1

/* Define to 1 if you have the `clearenv' function. */
#define HAVE_CLEARENV 1

/* Define to 1 if you have the `connect' function. */
#define HAVE_CONNECT 1

/* Define to 1 if the type of arg 1 for `connect' is `int _' */
#define HAVE_CONNECT_TYPE_ARG1_INT__ 1

/* Define to 1 if the type of arg 2 for `connect' is `const struct sockaddr
   *_' */
/* #undef HAVE_CONNECT_TYPE_ARG2_CONST_STRUCT_SOCKADDR_P_ */

/* Define to 1 if the type of arg 2 for `connect' is `__CONST_SOCKADDR_ARG _'
   */
#define HAVE_CONNECT_TYPE_ARG2___CONST_SOCKADDR_ARG__ 1

/* Define to 1 if the type of arg 3 for `connect' is `socklen_t _' */
#define HAVE_CONNECT_TYPE_ARG3_SOCKLEN_T__ 1

/* Define to 1 if the type of return value for `connect' is `int' */
#define HAVE_CONNECT_TYPE_RETURN_INT 1

/* Define to 1 if you have the `creat' function. */
#define HAVE_CREAT 1

/* Define to 1 if you have the `creat64' function. */
#define HAVE_CREAT64 1

/* Define to 1 if you have the <dirent.h> header file. */
#define HAVE_DIRENT_H 1

/* Define to 1 if you have the `dladdr' function. */
#define HAVE_DLADDR 1

/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 1

/* Define to 1 if you have the `dlmopen' function. */
#define HAVE_DLMOPEN 1

/* Define to 1 if you have the `dlopen' function. */
#define HAVE_DLOPEN 1

/* Define to 1 if you have the `dl_iterate_phdr' function. */
#define HAVE_DL_ITERATE_PHDR 1

/* Define to 1 if you have the `eaccess' function. */
#define HAVE_EACCESS 1

/* Define to 1 if you have the <errno.h> header file. */
#define HAVE_ERRNO_H 1

/* Define to 1 if you have the `euidaccess' function. */
#define HAVE_EUIDACCESS 1

/* Define to 1 if you have the `execl' function. */
#define HAVE_EXECL 1

/* Define to 1 if you have the `execle' function. */
#define HAVE_EXECLE 1

/* Define to 1 if you have the `execlp' function. */
#define HAVE_EXECLP 1

/* Define to 1 if you have the `execv' function. */
#define HAVE_EXECV 1

/* Define to 1 if you have the `execve' function. */
#define HAVE_EXECVE 1

/* Define to 1 if you have the `execvp' function. */
#define HAVE_EXECVP 1

/* Define to 1 if you have the `faccessat' function. */
#define HAVE_FACCESSAT 1

/* Define to 1 if you have the `fchdir' function. */
#define HAVE_FCHDIR 1

/* Define to 1 if you have the `fchmodat' function. */
#define HAVE_FCHMODAT 1

/* Define to 1 if you have the `fchownat' function. */
#define HAVE_FCHOWNAT 1

/* Define to 1 if you have the <fcntl.h> header file. */
#define HAVE_FCNTL_H 1

/* Define to 1 if you have the `fopen' function. */
#define HAVE_FOPEN 1

/* Define to 1 if you have the `fopen64' function. */
#define HAVE_FOPEN64 1

/* Define to 1 if you have the `freopen' function. */
#define HAVE_FREOPEN 1

/* Define to 1 if you have the `freopen64' function. */
#define HAVE_FREOPEN64 1

/* Define to 1 if you have the `fstat' function. */
#define HAVE_FSTAT 1

/* Define to 1 if you have the `fstat64' function. */
#define HAVE_FSTAT64 1

/* Define to 1 if you have the `fts64_open' function. */
#define HAVE_FTS64_OPEN 1

/* Define to 1 if the type of arg 1 for `fts64_open' is `char * const *_' */
#define HAVE_FTS64_OPEN_TYPE_ARG1_CHAR_P_CONST_P_ 1

/* Define to 1 if the type of arg 2 for `fts64_open' is `int _' */
/* #undef HAVE_FTS64_OPEN_TYPE_ARG2_INT__ */

/* Define to 1 if the type of return value for `fts64_open' is `FTSOBJ *' */
#define HAVE_FTS64_OPEN_TYPE_RETURN_FTSOBJ_P 1

/* Define to 1 if you have the `fts_children' function. */
#define HAVE_FTS_CHILDREN 1

/* Define to 1 if you have the <fts.h> header file. */
#define HAVE_FTS_H 1

/* Define to 1 if you have the `fts_open' function. */
#define HAVE_FTS_OPEN 1

/* Define to 1 if the type of arg 1 for `fts_open' is `char * const *_' */
#define HAVE_FTS_OPEN_TYPE_ARG1_CHAR_P_CONST_P_ 1

/* Define to 1 if the type of arg 2 for `fts_open' is `int _' */
/* #undef HAVE_FTS_OPEN_TYPE_ARG2_INT__ */

/* Define to 1 if the type of return value for `fts_open' is `FTSOBJ *' */
#define HAVE_FTS_OPEN_TYPE_RETURN_FTSOBJ_P 1

/* Define to 1 if you have the `fts_read' function. */
#define HAVE_FTS_READ 1

/* Define to 1 if you have the `ftw' function. */
#define HAVE_FTW 1

/* Define to 1 if you have the `ftw64' function. */
#define HAVE_FTW64 1

/* Define to 1 if you have the <ftw.h> header file. */
#define HAVE_FTW_H 1

/* Define to 1 if you have the `futimesat' function. */
#define HAVE_FUTIMESAT 1

/* Define to 1 if you have the `getcwd' function. */
#define HAVE_GETCWD 1

/* Define to 1 if you have the `getpeername' function. */
#define HAVE_GETPEERNAME 1

/* Define to 1 if the type of arg 1 for `getpeername' is `int _' */
#define HAVE_GETPEERNAME_TYPE_ARG1_INT__ 1

/* Define to 1 if the type of arg 2 for `getpeername' is `struct sockaddr *_'
   */
/* #undef HAVE_GETPEERNAME_TYPE_ARG2_STRUCT_SOCKADDR_P_ */

/* Define to 1 if the type of arg 2 for `getpeername' is `__SOCKADDR_ARG _' */
#define HAVE_GETPEERNAME_TYPE_ARG2___SOCKADDR_ARG__ 1

/* Define to 1 if the type of arg 3 for `getpeername' is `socket_t *_' */
/* #undef HAVE_GETPEERNAME_TYPE_ARG3_SOCKET_T_P_ */

/* Define to 1 if the type of arg 3 for `getpeername' is `socklen_t
   *__restrict _' */
#define HAVE_GETPEERNAME_TYPE_ARG3_SOCKLEN_T_P__RESTRICT__ 1

/* Define to 1 if the type of return value for `getpeername' is `int' */
#define HAVE_GETPEERNAME_TYPE_RETURN_INT 1

/* Define to 1 if you have the `getsockname' function. */
#define HAVE_GETSOCKNAME 1

/* Define to 1 if the type of arg 1 for `getsockname' is `int _' */
#define HAVE_GETSOCKNAME_TYPE_ARG1_INT__ 1

/* Define to 1 if the type of arg 2 for `getsockname' is `struct sockaddr *_'
   */
/* #undef HAVE_GETSOCKNAME_TYPE_ARG2_STRUCT_SOCKADDR_P_ */

/* Define to 1 if the type of arg 2 for `getsockname' is `__SOCKADDR_ARG _' */
#define HAVE_GETSOCKNAME_TYPE_ARG2___SOCKADDR_ARG__ 1

/* Define to 1 if the type of arg 3 for `getsockname' is `socket_t *_' */
/* #undef HAVE_GETSOCKNAME_TYPE_ARG3_SOCKET_T_P_ */

/* Define to 1 if the type of arg 3 for `getsockname' is `socklen_t
   *__restrict _' */
#define HAVE_GETSOCKNAME_TYPE_ARG3_SOCKLEN_T_P__RESTRICT__ 1

/* Define to 1 if the type of return value for `getsockname' is `int' */
#define HAVE_GETSOCKNAME_TYPE_RETURN_INT 1

/* Define to 1 if you have the `getwd' function. */
#define HAVE_GETWD 1

/* Define to 1 if you have the `getxattr' function. */
#define HAVE_GETXATTR 1

/* Define to 1 if you have the `get_current_dir_name' function. */
#define HAVE_GET_CURRENT_DIR_NAME 1

/* Define to 1 if you have the `glob' function. */
#define HAVE_GLOB 1

/* Define to 1 if you have the `glob64' function. */
#define HAVE_GLOB64 1

/* Define to 1 if you have the <glob.h> header file. */
#define HAVE_GLOB_H 1

/* Define to 1 if you have the `glob_pattern_p' function. */
#define HAVE_GLOB_PATTERN_P 1

/* Define to 1 if you have the `inotify_add_watch' function. */
#define HAVE_INOTIFY_ADD_WATCH 1

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if you have the `lchmod' function. */
/* #undef HAVE_LCHMOD */

/* Define to 1 if you have the `lchown' function. */
#define HAVE_LCHOWN 1

/* Define to 1 if you have the `lckpwdf' function. */
#define HAVE_LCKPWDF 1

/* Define to 1 if you have the `lgetxattr' function. */
#define HAVE_LGETXATTR 1

/* Define to 1 if you have the `dl' library (-ldl). */
#define HAVE_LIBDL 1

/* Define to 1 if you have the <libintl.h> header file. */
#define HAVE_LIBINTL_H 1

/* Define to 1 if you have the `link' function. */
#define HAVE_LINK 1

/* Define to 1 if you have the `linkat' function. */
#define HAVE_LINKAT 1

/* Define to 1 if you have the <link.h> header file. */
#define HAVE_LINK_H 1

/* Define to 1 if you have the `listxattr' function. */
#define HAVE_LISTXATTR 1

/* Define to 1 if you have the `llistxattr' function. */
#define HAVE_LLISTXATTR 1

/* Define to 1 if you have the `lremovexattr' function. */
#define HAVE_LREMOVEXATTR 1

/* Define to 1 if you have the `lsetxattr' function. */
#define HAVE_LSETXATTR 1

/* Define to 1 if you have the `lstat' function. */
#define HAVE_LSTAT 1

/* Define to 1 if you have the `lstat64' function. */
#define HAVE_LSTAT64 1

/* Define to 1 if you have the `lutimes' function. */
#define HAVE_LUTIMES 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `mempcpy' function. */
#define HAVE_MEMPCPY 1

/* Define to 1 if you have the `mkdir' function. */
#define HAVE_MKDIR 1

/* Define to 1 if you have the `mkdirat' function. */
#define HAVE_MKDIRAT 1

/* Define to 1 if you have the `mkdtemp' function. */
#define HAVE_MKDTEMP 1

/* Define to 1 if you have the `mkfifo' function. */
#define HAVE_MKFIFO 1

/* Define to 1 if you have the `mkfifoat' function. */
#define HAVE_MKFIFOAT 1

/* Define to 1 if you have the `mknod' function. */
#define HAVE_MKNOD 1

/* Define to 1 if you have the `mknodat' function. */
#define HAVE_MKNODAT 1

/* Define to 1 if you have the `mkostemp' function. */
#define HAVE_MKOSTEMP 1

/* Define to 1 if you have the `mkostemp64' function. */
#define HAVE_MKOSTEMP64 1

/* Define to 1 if you have the `mkostemps' function. */
#define HAVE_MKOSTEMPS 1

/* Define to 1 if you have the `mkostemps64' function. */
#define HAVE_MKOSTEMPS64 1

/* Define to 1 if you have the `mkstemp' function. */
#define HAVE_MKSTEMP 1

/* Define to 1 if you have the `mkstemp64' function. */
#define HAVE_MKSTEMP64 1

/* Define to 1 if you have the `mkstemps' function. */
#define HAVE_MKSTEMPS 1

/* Define to 1 if you have the `mkstemps64' function. */
#define HAVE_MKSTEMPS64 1

/* Define to 1 if you have the `mktemp' function. */
#define HAVE_MKTEMP 1

/* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
/* #undef HAVE_NDIR_H */

/* Define to 1 if you have the `nftw' function. */
#define HAVE_NFTW 1

/* Define to 1 if you have the `nftw64' function. */
#define HAVE_NFTW64 1

/* Define to 1 if you have the `open' function. */
#define HAVE_OPEN 1

/* Define to 1 if you have the `open64' function. */
#define HAVE_OPEN64 1

/* Define to 1 if you have the `openat' function. */
#define HAVE_OPENAT 1

/* Define to 1 if you have the `openat64' function. */
#define HAVE_OPENAT64 1

/* Define to 1 if you have the `opendir' function. */
#define HAVE_OPENDIR 1

/* Define to 1 if you have the `pathconf' function. */
#define HAVE_PATHCONF 1

/* Define to 1 if you have the `popen' function. */
#define HAVE_POPEN 1

/* Define to 1 if you have the `posix_spawn' function. */
#define HAVE_POSIX_SPAWN 1

/* Define to 1 if you have the `posix_spawnp' function. */
#define HAVE_POSIX_SPAWNP 1

/* Define to 1 if the system has the type `ptrdiff_t'. */
#define HAVE_PTRDIFF_T 1

/* Define to 1 if you have the <pwd.h> header file. */
#define HAVE_PWD_H 1

/* Define to 1 if you have the `rawmemchr' function. */
#define HAVE_RAWMEMCHR 1

/* Define to 1 if you have the `readlink' function. */
#define HAVE_READLINK 1

/* Define to 1 if you have the `readlinkat' function. */
#define HAVE_READLINKAT 1

/* Define to 1 if the type of arg 1 for `readlink' is `const char *_' */
#define HAVE_READLINK_TYPE_ARG1_CONST_CHAR_P_ 1

/* Define to 1 if the type of arg 2 for `readlink' is `char *_' */
#define HAVE_READLINK_TYPE_ARG2_CHAR_P_ 1

/* Define to 1 if the type of arg 3 for `readlink' is `int _' */
/* #undef HAVE_READLINK_TYPE_ARG3_INT__ */

/* Define to 1 if the type of arg 3 for `readlink' is `size_t _' */
#define HAVE_READLINK_TYPE_ARG3_SIZE_T__ 1

/* Define to 1 if the type of return value for `readlink' is `int' */
/* #undef HAVE_READLINK_TYPE_RETURN_INT */

/* Define to 1 if the type of return value for `readlink' is `ssize_t' */
#define HAVE_READLINK_TYPE_RETURN_SSIZE_T 1

/* Define to 1 if you have the `realpath' function. */
#define HAVE_REALPATH 1

/* Define to 1 if you have the `remove' function. */
#define HAVE_REMOVE 1

/* Define to 1 if you have the `removexattr' function. */
#define HAVE_REMOVEXATTR 1

/* Define to 1 if you have the `rename' function. */
#define HAVE_RENAME 1

/* Define to 1 if you have the `renameat' function. */
#define HAVE_RENAMEAT 1

/* Define to 1 if you have the `revoke' function. */
/* #undef HAVE_REVOKE */

/* Define to 1 if you have the `rmdir' function. */
#define HAVE_RMDIR 1

/* Define to 1 if you have the `scandir' function. */
#define HAVE_SCANDIR 1

/* Define to 1 if you have the `scandir64' function. */
#define HAVE_SCANDIR64 1

/* Define to 1 if the type of arg 1 for `scandir64' is `const char *_' */
#define HAVE_SCANDIR64_TYPE_ARG1_CONST_CHAR_P_ 1

/* Define to 1 if the type of arg 2 for `scandir64' is `struct dirent64 ***_'
   */
#define HAVE_SCANDIR64_TYPE_ARG2_STRUCT_DIRENT64_PPP_ 1

/* Define to 1 if the type of return value for `scandir64' is `int' */
#define HAVE_SCANDIR64_TYPE_RETURN_INT 1

/* Define to 1 if the type of arg 1 for `scandir' is `const char *_' */
#define HAVE_SCANDIR_TYPE_ARG1_CONST_CHAR_P_ 1

/* Define to 1 if the type of arg 2 for `scandir' is `struct dirent ***_' */
#define HAVE_SCANDIR_TYPE_ARG2_STRUCT_DIRENT_PPP_ 1

/* Define to 1 if the type of return value for `scandir' is `int' */
#define HAVE_SCANDIR_TYPE_RETURN_INT 1

/* Define to 1 if you have the `setenv' function. */
#define HAVE_SETENV 1

/* Define to 1 if you have the `setxattr' function. */
#define HAVE_SETXATTR 1

/* Define to 1 if you have the <shadow.h> header file. */
#define HAVE_SHADOW_H 1

/* Define to 1 if you have the <signal.h> header file. */
#define HAVE_SIGNAL_H 1

/* Define to 1 if you have the <spawn.h> header file. */
#define HAVE_SPAWN_H 1

/* Define to 1 if you have the `stat' function. */
#define HAVE_STAT 1

/* Define to 1 if you have the `stat64' function. */
#define HAVE_STAT64 1

/* Define to 1 if you have the `statfs' function. */
#define HAVE_STATFS 1

/* Define to 1 if you have the `statfs64' function. */
#define HAVE_STATFS64 1

/* Define to 1 if you have the `statvfs' function. */
#define HAVE_STATVFS 1

/* Define to 1 if you have the `statvfs64' function. */
#define HAVE_STATVFS64 1

/* Define to 1 if you have the <stdarg.h> header file. */
#define HAVE_STDARG_H 1

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdio.h> header file. */
#define HAVE_STDIO_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the `stpcpy' function. */
#define HAVE_STPCPY 1

/* Define to 1 if you have the `strchrnul' function. */
#define HAVE_STRCHRNUL 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the `strlcpy' function. */
/* #undef HAVE_STRLCPY */

/* Define to 1 if `sun_len' is a member of `struct sockaddr_un'. */
/* #undef HAVE_STRUCT_SOCKADDR_UN_SUN_LEN */

/* Define to 1 if `fts_fts' is a member of `struct _ftsent'. */
/* #undef HAVE_STRUCT__FTSENT_FTS_FTS */

/* Define to 1 if `fts_name' is a member of `struct _ftsent'. */
#define HAVE_STRUCT__FTSENT_FTS_NAME 1

/* Define to 1 if the type of struct _ftsent.fts_name is `char *' */
/* #undef HAVE_STRUCT__FTSENT_FTS_NAME_TYPE_CHAR_P */

/* Define to 1 if you have the `symlink' function. */
#define HAVE_SYMLINK 1

/* Define to 1 if you have the `symlinkat' function. */
#define HAVE_SYMLINKAT 1

/* Define to 1 if you have the `system' function. */
#define HAVE_SYSTEM 1

/* Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_DIR_H */

/* Define to 1 if you have the <sys/inotify.h> header file. */
#define HAVE_SYS_INOTIFY_H 1

/* Define to 1 if you have the <sys/mount.h> header file. */
#define HAVE_SYS_MOUNT_H 1

/* Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_NDIR_H */

/* Define to 1 if you have the <sys/param.h> header file. */
#define HAVE_SYS_PARAM_H 1

/* Define to 1 if you have the <sys/socket.h> header file. */
#define HAVE_SYS_SOCKET_H 1

/* Define to 1 if you have the <sys/statfs.h> header file. */
#define HAVE_SYS_STATFS_H 1

/* Define to 1 if you have the <sys/statvfs.h> header file. */
#define HAVE_SYS_STATVFS_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/syscall.h> header file. */
#define HAVE_SYS_SYSCALL_H 1

/* Define to 1 if you have the <sys/times.h> header file. */
#define HAVE_SYS_TIMES_H 1

/* Define to 1 if you have the <sys/time.h> header file. */
#define HAVE_SYS_TIME_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <sys/un.h> header file. */
#define HAVE_SYS_UN_H 1

/* Define to 1 if you have the <sys/vfs.h> header file. */
#define HAVE_SYS_VFS_H 1

/* Define to 1 if you have the <sys/wait.h> header file. */
#define HAVE_SYS_WAIT_H 1

/* Define to 1 if you have the <sys/xattr.h> header file. */
#define HAVE_SYS_XATTR_H 1

/* Define to 1 if you have the `tempnam' function. */
#define HAVE_TEMPNAM 1

/* Define to 1 if you have the `tmpnam' function. */
#define HAVE_TMPNAM 1

/* Define to 1 if you have the `truncate' function. */
#define HAVE_TRUNCATE 1

/* Define to 1 if you have the `truncate64' function. */
#define HAVE_TRUNCATE64 1

/* Define to 1 if you have the `ulckpwdf' function. */
#define HAVE_ULCKPWDF 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if you have the `unlink' function. */
#define HAVE_UNLINK 1

/* Define to 1 if you have the `unlinkat' function. */
#define HAVE_UNLINKAT 1

/* Define to 1 if you have the `unsetenv' function. */
#define HAVE_UNSETENV 1

/* Define to 1 if you have the `utime' function. */
#define HAVE_UTIME 1

/* Define to 1 if you have the `utimensat' function. */
#define HAVE_UTIMENSAT 1

/* Define to 1 if you have the `utimes' function. */
#define HAVE_UTIMES 1

/* Define to 1 if the type of arg 1 for `utimes' is `const char *_' */
#define HAVE_UTIMES_TYPE_ARG1_CONST_CHAR_P_ 1

/* Define to 1 if the type of return value for `utimes' is `int' */
#define HAVE_UTIMES_TYPE_RETURN_INT 1

/* Define to 1 if you have the <utime.h> header file. */
#define HAVE_UTIME_H 1

/* Define to 1 if you have the `vfork' function. */
#define HAVE_VFORK 1

/* Define to 1 if you have the `_xftw' function. */
/* #undef HAVE__XFTW */

/* Define to 1 if you have the `_xftw64' function. */
/* #undef HAVE__XFTW64 */

/* Define to 1 if compiler supports `__alignof__' syntax. */
#define HAVE___ALIGNOF__ 1

/* Define to 1 if compiler supports `__attribute__((constructor))' syntax. */
#define HAVE___ATTRIBUTE__CONSTRUCTOR 1

/* Define to 1 if compiler supports
   `__attribute__((section("data.fakechroot")))' syntax. */
#define HAVE___ATTRIBUTE__SECTION_DATA_FAKECHROOT 1

/* Define to 1 if the compiler supports simple visibility declarations. */
#define HAVE___ATTRIBUTE__VISIBILITY 1

/* Define to 1 if you have the `__chk_fail' function. */
#define HAVE___CHK_FAIL 1

/* Define to 1 if you have the `__fxstat64' function. */
#define HAVE___FXSTAT64 1

/* Define to 1 if you have the `__fxstatat' function. */
#define HAVE___FXSTATAT 1

/* Define to 1 if you have the `__fxstatat64' function. */
#define HAVE___FXSTATAT64 1

/* Define to 1 if you have the `__getcwd_chk' function. */
#define HAVE___GETCWD_CHK 1

/* Define to 1 if you have the `__getwd_chk' function. */
#define HAVE___GETWD_CHK 1

/* Define to 1 if you have the `__lxstat' function. */
#define HAVE___LXSTAT 1

/* Define to 1 if you have the `__lxstat64' function. */
#define HAVE___LXSTAT64 1

/* Define to 1 if you have the `__open' function. */
#define HAVE___OPEN 1

/* Define to 1 if you have the `__open64' function. */
#define HAVE___OPEN64 1

/* Define to 1 if you have the `__open64_2' function. */
#define HAVE___OPEN64_2 1

/* Define to 1 if you have the `__openat64_2' function. */
#define HAVE___OPENAT64_2 1

/* Define to 1 if you have the `__openat_2' function. */
#define HAVE___OPENAT_2 1

/* Define to 1 if you have the `__opendir2' function. */
/* #undef HAVE___OPENDIR2 */

/* Define to 1 if you have the `__open_2' function. */
#define HAVE___OPEN_2 1

/* Define to 1 if you have the `__readlinkat_chk' function. */
#define HAVE___READLINKAT_CHK 1

/* Define to 1 if you have the `__readlink_chk' function. */
#define HAVE___READLINK_CHK 1

/* Define to 1 if you have the `__realpath_chk' function. */
#define HAVE___REALPATH_CHK 1

/* Define to 1 if you have the `__statfs' function. */
#define HAVE___STATFS 1

/* Define to 1 if you have the `__xmknod' function. */
#define HAVE___XMKNOD 1

/* Define to 1 if you have the `__xmknodat' function. */
#define HAVE___XMKNODAT 1

/* Define to 1 if you have the `__xstat' function. */
#define HAVE___XSTAT 1

/* Define to 1 if you have the `__xstat64' function. */
#define HAVE___XSTAT64 1

/* Define to 1 if `lstat' dereferences a symlink specified with a trailing
   slash. */
#define LSTAT_FOLLOWS_SLASHED_SYMLINK 1

/* Define to the sub-directory where libtool stores uninstalled libraries. */
#define LT_OBJDIR ".libs/"

/* Define to 1 if opendir function calls __open function internally. */
/* #undef OPENDIR_CALLS___OPEN */

/* Define to 1 if opendir function calls __opendir2 function internally. */
/* #undef OPENDIR_CALLS___OPENDIR2 */

/* Name of package */
#define PACKAGE "fakechroot"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "dexter@debian.org"

/* Define to the full name of this package. */
#define PACKAGE_NAME "fakechroot"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "fakechroot 2.20"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "fakechroot"

/* Define to the home page for this package. */
#define PACKAGE_URL "https://github.com/dex4er/fakechroot"

/* Define to the version of this package. */
#define PACKAGE_VERSION "2.20"

/* Define to the type of arg 1 for `readlink'. */
#define READLINK_TYPE_ARG1(_) const char *_

/* Define to the type of arg 2 for `readlink'. */
#define READLINK_TYPE_ARG2(_) char *_

/* Define to the type of arg 3 for `readlink'. */
#define READLINK_TYPE_ARG3(_) size_t _

/* Define to the type of return value for `readlink'. */
#define READLINK_TYPE_RETURN ssize_t

/* Define to the type of arg 1 for `scandir64'. */
#define SCANDIR64_TYPE_ARG1(_) const char *_

/* Define to the type of arg 2 for `scandir64'. */
#define SCANDIR64_TYPE_ARG2(_) struct dirent64 ***_

/* Define to the type of arg 3 for `scandir64'. */
#define SCANDIR64_TYPE_ARG3(_) int(*_)(const struct dirent64 *)

/* Define to the type of arg 4 for `scandir64'. */
#define SCANDIR64_TYPE_ARG4(_) int(*_)(const struct dirent64 **, const struct dirent64 **)

/* Define to the type of return value for `scandir64'. */
#define SCANDIR64_TYPE_RETURN int

/* Define to the type of arg 1 for `scandir'. */
#define SCANDIR_TYPE_ARG1(_) const char *_

/* Define to the type of arg 2 for `scandir'. */
#define SCANDIR_TYPE_ARG2(_) struct dirent ***_

/* Define to the type of arg 3 for `scandir'. */
#define SCANDIR_TYPE_ARG3(_) int(*_)(const struct dirent *)

/* Define to the type of arg 4 for `scandir'. */
#define SCANDIR_TYPE_ARG4(_) int(*_)(const struct dirent **, const struct dirent **)

/* Define to the type of return value for `scandir'. */
#define SCANDIR_TYPE_RETURN int

/* If using the C implementation of alloca, define if you know the
   direction of stack growth for your system; otherwise it will be
   automatically deduced at runtime.
	STACK_DIRECTION > 0 => grows toward higher addresses
	STACK_DIRECTION < 0 => grows toward lower addresses
	STACK_DIRECTION = 0 => direction of growth unknown */
/* #undef STACK_DIRECTION */

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Define to the type of arg 1 for `utimes'. */
#define UTIMES_TYPE_ARG1(_) const char *_

/* Define to the type of arg 2 for `utimes'. */
#define UTIMES_TYPE_ARG2(_) const struct timeval _[2]

/* Define to the type of return value for `utimes'. */
#define UTIMES_TYPE_RETURN int

/* Version number of package */
#define VERSION "2.20"

/* Define for Solaris 2.5.1 so the uint32_t typedef from <sys/synch.h>,
   <pthread.h>, or <semaphore.h> is not used. If the typedef were allowed, the
   #define below would cause a syntax error. */
/* #undef _UINT32_T */

/* Define to `int' if <sys/types.h> doesn't define. */
/* #undef gid_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef mode_t */

/* Define to `long int' if <sys/types.h> does not define. */
/* #undef off_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef pid_t */

/* Define to `unsigned int' if <sys/types.h> does not define. */
/* #undef size_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef ssize_t */

/* Define to `int' if <sys/types.h> doesn't define. */
/* #undef uid_t */

/* Define to the type of an unsigned integer type of width exactly 32 bits if
   such a type exists and the standard includes do not define it. */
/* #undef uint32_t */
