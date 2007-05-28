Message-ID: <465AD773.7000609@domain.hid>
Date: Mon, 28 May 2007 15:21:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7289437c0705280043o7b8eaf85hbbfad33b95c243fb@domain.hid>	<1180342178.6188.37.camel@domain.hid>
	<465A9AD6.7040008@domain.hid>	<1180343533.6188.40.camel@domain.hid>
	<7289437c0705280557k2dea8db6r7e4e162078a3c846@domain.hid>
In-Reply-To: <7289437c0705280557k2dea8db6r7e4e162078a3c846@domain.hid>
Content-Type: multipart/mixed; boundary="------------000907010006020108030303"
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000907010006020108030303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit

Perrine Martignoni wrote:
> Sorry for the details.
> I work on an ARM and I use the cross compiler ELDK version 4.1 (build :
> 2007-01-22-uclibc).
>  
> When I compile sources of xenomai, I have this error message :
>  
> 
> -Wl,shm_unlink -Wl,--wrap -Wl,mmap -Wl,--wrap -Wl,munmap
> cyclictest-cyclictest.o  ../../skins/posix/.libs/libpthread_rt.a
> -lpthread -lrt
> 
> ../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-shm.o): In
> function `__wrap_shm_open':
> 
> shm.c:(.text+0x74): undefined reference to `shm_open'
> 
> ../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-shm.o): In
> function `__wrap_shm_unlink':
> 
> shm.c:(.text+0xdc): undefined reference to `shm_unlink'

This was fixed in v2.3.x branch by commit 2339. Please find the patch
attached, that should hopefully apply to v2.3.1, and will avoid having
to re-generate autotools files.

-- 
                                                 Gilles Chanteperdrix

--------------000907010006020108030303
Content-Type: text/x-patch;
 name="xeno-2.3-posix-shm.diff"
Content-Disposition: inline;
 filename="xeno-2.3-posix-shm.diff"
Content-Transfer-Encoding: Quoted-Printable

Index: configure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- configure	(r=C3=A9vision 2338)
+++ configure	(r=C3=A9vision 2339)
@@ -280,15 +280,15 @@
=20
 # The HP-UX ksh and POSIX shell print the target directory to stdout
 # if CDPATH is set.
-(unset CDPATH) >/dev/null 2>&1 && unset CDPATH
+if test "X${CDPATH+set}" =3D Xset; then CDPATH=3D:; export CDPATH; fi
=20
 if test -z "$ECHO"; then
 if test "X${echo_test_string+set}" !=3D Xset; then
 # find a string as large as possible, as long as the shell can cope with=
 it
   for cmd in 'sed 50q "$0"' 'sed 20q "$0"' 'sed 10q "$0"' 'sed 2q "$0"' =
'echo test'; do
     # expected sizes: less than 2Kb, 1Kb, 512 bytes, 16 bytes, ...
-    if (echo_test_string=3D`eval $cmd`) 2>/dev/null &&
-       echo_test_string=3D`eval $cmd` &&
+    if (echo_test_string=3D"`eval $cmd`") 2>/dev/null &&
+       echo_test_string=3D"`eval $cmd`" &&
        (test "X$echo_test_string" =3D "X$echo_test_string") 2>/dev/null
     then
       break
@@ -4557,7 +4557,7 @@
 # Add /usr/xpg4/bin/sed as it is typically found on Solaris
 # along with /bin/sed that truncates output.
 for lt_ac_sed in $lt_ac_sed_list /usr/xpg4/bin/sed; do
-  test ! -f $lt_ac_sed && continue
+  test ! -f $lt_ac_sed && break
   cat /dev/null > conftest.in
   lt_ac_count=3D0
   echo $ECHO_N "0123456789$ECHO_C" >conftest.in
@@ -4582,10 +4582,10 @@
     fi
   done
 done
+SED=3D$lt_cv_path_SED
=20
 fi
=20
-SED=3D$lt_cv_path_SED
 echo "$as_me:$LINENO: result: $SED" >&5
 echo "${ECHO_T}$SED" >&6
=20
@@ -4662,7 +4662,7 @@
     if test -f "$ac_dir/$ac_prog" || test -f "$ac_dir/$ac_prog$ac_exeext=
"; then
       lt_cv_path_LD=3D"$ac_dir/$ac_prog"
       # Check to see if the program is GNU ld.  I'd rather use --version=
,
-      # but apparently some variants of GNU ld only accept -v.
+      # but apparently some GNU ld's only accept -v.
       # Break only if it was the GNU/non-GNU ld that we prefer.
       case `"$lt_cv_path_LD" -v 2>&1 </dev/null` in
       *GNU* | *'with BFD'*)
@@ -4696,7 +4696,7 @@
 if test "${lt_cv_prog_gnu_ld+set}" =3D set; then
   echo $ECHO_N "(cached) $ECHO_C" >&6
 else
-  # I'd rather use --version here, but apparently some GNU lds only acce=
pt -v.
+  # I'd rather use --version here, but apparently some GNU ld's only acc=
ept -v.
 case `$LD -v 2>&1 </dev/null` in
 *GNU* | *'with BFD'*)
   lt_cv_prog_gnu_ld=3Dyes
@@ -4726,15 +4726,6 @@
 *) reload_flag=3D" $reload_flag" ;;
 esac
 reload_cmds=3D'$LD$reload_flag -o $output$reload_objs'
-case $host_os in
-  darwin*)
-    if test "$GCC" =3D yes; then
-      reload_cmds=3D'$LTCC $LTCFLAGS -nostdlib ${wl}-r -o $output$reload=
_objs'
-    else
-      reload_cmds=3D'$LD$reload_flag -o $output$reload_objs'
-    fi
-    ;;
-esac
=20
 echo "$as_me:$LINENO: checking for BSD-compatible nm" >&5
 echo $ECHO_N "checking for BSD-compatible nm... $ECHO_C" >&6
@@ -4745,43 +4736,36 @@
   # Let the user override the test.
   lt_cv_path_NM=3D"$NM"
 else
-  lt_nm_to_check=3D"${ac_tool_prefix}nm"
-  if test -n "$ac_tool_prefix" && test "$build" =3D "$host"; then
-    lt_nm_to_check=3D"$lt_nm_to_check nm"
-  fi
-  for lt_tmp_nm in $lt_nm_to_check; do
-    lt_save_ifs=3D"$IFS"; IFS=3D$PATH_SEPARATOR
-    for ac_dir in $PATH /usr/ccs/bin/elf /usr/ccs/bin /usr/ucb /bin; do
-      IFS=3D"$lt_save_ifs"
-      test -z "$ac_dir" && ac_dir=3D.
-      tmp_nm=3D"$ac_dir/$lt_tmp_nm"
-      if test -f "$tmp_nm" || test -f "$tmp_nm$ac_exeext" ; then
-	# Check to see if the nm accepts a BSD-compat flag.
-	# Adding the `sed 1q' prevents false positives on HP-UX, which says:
-	#   nm: unknown option "B" ignored
-	# Tru64's nm complains that /dev/null is an invalid object file
-	case `"$tmp_nm" -B /dev/null 2>&1 | sed '1q'` in
-	*/dev/null* | *'Invalid file or object type'*)
-	  lt_cv_path_NM=3D"$tmp_nm -B"
+  lt_save_ifs=3D"$IFS"; IFS=3D$PATH_SEPARATOR
+  for ac_dir in $PATH /usr/ccs/bin /usr/ucb /bin; do
+    IFS=3D"$lt_save_ifs"
+    test -z "$ac_dir" && ac_dir=3D.
+    tmp_nm=3D"$ac_dir/${ac_tool_prefix}nm"
+    if test -f "$tmp_nm" || test -f "$tmp_nm$ac_exeext" ; then
+      # Check to see if the nm accepts a BSD-compat flag.
+      # Adding the `sed 1q' prevents false positives on HP-UX, which say=
s:
+      #   nm: unknown option "B" ignored
+      # Tru64's nm complains that /dev/null is an invalid object file
+      case `"$tmp_nm" -B /dev/null 2>&1 | sed '1q'` in
+      */dev/null* | *'Invalid file or object type'*)
+	lt_cv_path_NM=3D"$tmp_nm -B"
+	break
+        ;;
+      *)
+	case `"$tmp_nm" -p /dev/null 2>&1 | sed '1q'` in
+	*/dev/null*)
+	  lt_cv_path_NM=3D"$tmp_nm -p"
 	  break
 	  ;;
 	*)
-	  case `"$tmp_nm" -p /dev/null 2>&1 | sed '1q'` in
-	  */dev/null*)
-	    lt_cv_path_NM=3D"$tmp_nm -p"
-	    break
-	    ;;
-	  *)
-	    lt_cv_path_NM=3D${lt_cv_path_NM=3D"$tmp_nm"} # keep the first match=
, but
-	    continue # so that we can try to find one that supports BSD flags
-	    ;;
-	  esac
+	  lt_cv_path_NM=3D${lt_cv_path_NM=3D"$tmp_nm"} # keep the first match, =
but
+	  continue # so that we can try to find one that supports BSD flags
 	  ;;
 	esac
-      fi
-    done
-    IFS=3D"$lt_save_ifs"
+      esac
+    fi
   done
+  IFS=3D"$lt_save_ifs"
   test -z "$lt_cv_path_NM" && lt_cv_path_NM=3Dnm
 fi
 fi
@@ -4828,7 +4812,7 @@
   lt_cv_deplibs_check_method=3Dpass_all
   ;;
=20
-bsdi[45]*)
+bsdi4*)
   lt_cv_deplibs_check_method=3D'file_magic ELF [0-9][0-9]*-bit [ML]SB (s=
hared object|dynamic lib)'
   lt_cv_file_magic_cmd=3D'/usr/bin/file -L'
   lt_cv_file_magic_test_file=3D/shlib/libc.so
@@ -4851,13 +4835,13 @@
   lt_cv_deplibs_check_method=3Dpass_all
   ;;
=20
-freebsd* | kfreebsd*-gnu | dragonfly*)
+freebsd* | kfreebsd*-gnu)
   if echo __ELF__ | $CC -E - | grep __ELF__ > /dev/null; then
     case $host_cpu in
     i*86 )
       # Not sure whether the presence of OpenBSD here was a mistake.
       # Let's accept both of them until this is cleared up.
-      lt_cv_deplibs_check_method=3D'file_magic (FreeBSD|OpenBSD|DragonFl=
y)/i[3-9]86 (compact )?demand paged shared library'
+      lt_cv_deplibs_check_method=3D'file_magic (FreeBSD|OpenBSD)/i[3-9]8=
6 (compact )?demand paged shared library'
       lt_cv_file_magic_cmd=3D/usr/bin/file
       lt_cv_file_magic_test_file=3D`echo /usr/lib/libc.so.*`
       ;;
@@ -4873,7 +4857,7 @@
=20
 hpux10.20* | hpux11*)
   lt_cv_file_magic_cmd=3D/usr/bin/file
-  case $host_cpu in
+  case "$host_cpu" in
   ia64*)
     lt_cv_deplibs_check_method=3D'file_magic (s[0-9][0-9][0-9]|ELF-[0-9]=
[0-9]) shared object file - IA64'
     lt_cv_file_magic_test_file=3D/usr/lib/hpux32/libc.so
@@ -4889,11 +4873,6 @@
   esac
   ;;
=20
-interix3*)
-  # PIC code is broken on Interix 3.x, that's why |\.a not |_pic\.a here
-  lt_cv_deplibs_check_method=3D'match_pattern /lib[^/]+(\.so|\.a)$'
-  ;;
-
 irix5* | irix6* | nonstopux*)
   case $LD in
   *-32|*"-32 ") libmagic=3D32-bit;;
@@ -4928,10 +4907,12 @@
   ;;
=20
 openbsd*)
+  lt_cv_file_magic_cmd=3D/usr/bin/file
+  lt_cv_file_magic_test_file=3D`echo /usr/lib/libc.so.*`
   if test -z "`echo __ELF__ | $CC -E - | grep __ELF__`" || test "$host_o=
s-$host_cpu" =3D "openbsd2.8-powerpc"; then
-    lt_cv_deplibs_check_method=3D'match_pattern /lib[^/]+(\.so\.[0-9]+\.=
[0-9]+|\.so|_pic\.a)$'
+    lt_cv_deplibs_check_method=3D'file_magic ELF [0-9][0-9]*-bit [LM]SB =
shared object'
   else
-    lt_cv_deplibs_check_method=3D'match_pattern /lib[^/]+(\.so\.[0-9]+\.=
[0-9]+|_pic\.a)$'
+    lt_cv_deplibs_check_method=3D'file_magic OpenBSD.* shared library'
   fi
   ;;
=20
@@ -4939,11 +4920,15 @@
   lt_cv_deplibs_check_method=3Dpass_all
   ;;
=20
+sco3.2v5*)
+  lt_cv_deplibs_check_method=3Dpass_all
+  ;;
+
 solaris*)
   lt_cv_deplibs_check_method=3Dpass_all
   ;;
=20
-sysv4 | sysv4.3*)
+sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
   case $host_vendor in
   motorola)
     lt_cv_deplibs_check_method=3D'file_magic ELF [0-9][0-9]*-bit [ML]SB =
(shared object|dynamic lib) M[0-9][0-9]* Version [0-9]'
@@ -4964,13 +4949,10 @@
   siemens)
     lt_cv_deplibs_check_method=3Dpass_all
     ;;
-  pc)
-    lt_cv_deplibs_check_method=3Dpass_all
-    ;;
   esac
   ;;
=20
-sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX* | sysv4*uw2*)
+sysv5OpenUNIX8* | sysv5UnixWare7* | sysv5uw[78]* | unixware7* | sysv4*uw=
2*)
   lt_cv_deplibs_check_method=3Dpass_all
   ;;
 esac
@@ -4987,9 +4969,6 @@
 # If no C compiler was specified, use CC.
 LTCC=3D${LTCC-"$CC"}
=20
-# If no C compiler flags were specified, use CFLAGS.
-LTCFLAGS=3D${LTCFLAGS-"$CFLAGS"}
-
 # Allow CC to be a program name with arguments.
 compiler=3D$CC
=20
@@ -5025,7 +5004,7 @@
   ;;
 *-*-irix6*)
   # Find out which ABI we are using.
-  echo '#line 5028 "configure"' > conftest.$ac_ext
+  echo '#line 5007 "configure"' > conftest.$ac_ext
   if { (eval echo "$as_me:$LINENO: \"$ac_compile\"") >&5
   (eval $ac_compile) 2>&5
   ac_status=3D$?
@@ -5068,7 +5047,7 @@
   ac_status=3D$?
   echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
   (exit $ac_status); }; then
-    case `/usr/bin/file conftest.o` in
+    case "`/usr/bin/file conftest.o`" in
     *32-bit*)
       case $host in
         x86_64-*linux*)
@@ -5180,27 +5159,7 @@
     CFLAGS=3D"$SAVE_CFLAGS"
   fi
   ;;
-sparc*-*solaris*)
-  # Find out which ABI we are using.
-  echo 'int i;' > conftest.$ac_ext
-  if { (eval echo "$as_me:$LINENO: \"$ac_compile\"") >&5
-  (eval $ac_compile) 2>&5
-  ac_status=3D$?
-  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
-  (exit $ac_status); }; then
-    case `/usr/bin/file conftest.o` in
-    *64-bit*)
-      case $lt_cv_prog_gnu_ld in
-      yes*) LD=3D"${LD-ld} -m elf64_sparc" ;;
-      *)    LD=3D"${LD-ld} -64" ;;
-      esac
-      ;;
-    esac
-  fi
-  rm -rf conftest*
-  ;;
=20
-
 esac
=20
 need_locks=3D"$enable_libtool_lock"
@@ -6052,12 +6011,7 @@
 fi
=20
=20
-
-
-if test -n "$CXX" && ( test "X$CXX" !=3D "Xno" &&
-    ( (test "X$CXX" =3D "Xg++" && `g++ -v >/dev/null 2>&1` ) ||
-    (test "X$CXX" !=3D "Xg++"))) ; then
-  ac_ext=3Dcc
+ac_ext=3Dcc
 ac_cpp=3D'$CXXCPP $CPPFLAGS'
 ac_compile=3D'$CXX -c $CXXFLAGS $CPPFLAGS conftest.$ac_ext >&5'
 ac_link=3D'$CXX -o conftest$ac_exeext $CXXFLAGS $CPPFLAGS $LDFLAGS conft=
est.$ac_ext $LIBS >&5'
@@ -6287,9 +6241,7 @@
 ac_link=3D'$CXX -o conftest$ac_exeext $CXXFLAGS $CPPFLAGS $LDFLAGS conft=
est.$ac_ext $LIBS >&5'
 ac_compiler_gnu=3D$ac_cv_cxx_compiler_gnu
=20
-fi
=20
-
 ac_ext=3Df
 ac_compile=3D'$F77 -c $FFLAGS conftest.$ac_ext >&5'
 ac_link=3D'$F77 -o conftest$ac_exeext $FFLAGS $LDFLAGS conftest.$ac_ext =
$LIBS >&5'
@@ -6382,7 +6334,7 @@
=20
=20
 # Provide some information about the compiler.
-echo "$as_me:6385:" \
+echo "$as_me:6337:" \
      "checking for Fortran 77 compiler version" >&5
 ac_compiler=3D`set X $ac_compile; echo $2`
 { (eval echo "$as_me:$LINENO: \"$ac_compiler --version </dev/null >&5\""=
) >&5
@@ -6570,55 +6522,11 @@
     lt_cv_sys_max_cmd_len=3D8192;
     ;;
=20
-  netbsd* | freebsd* | openbsd* | darwin* | dragonfly*)
-    # This has been around since 386BSD, at least.  Likely further.
-    if test -x /sbin/sysctl; then
-      lt_cv_sys_max_cmd_len=3D`/sbin/sysctl -n kern.argmax`
-    elif test -x /usr/sbin/sysctl; then
-      lt_cv_sys_max_cmd_len=3D`/usr/sbin/sysctl -n kern.argmax`
-    else
-      lt_cv_sys_max_cmd_len=3D65536	# usable default for all BSDs
-    fi
-    # And add a safety zone
-    lt_cv_sys_max_cmd_len=3D`expr $lt_cv_sys_max_cmd_len \/ 4`
-    lt_cv_sys_max_cmd_len=3D`expr $lt_cv_sys_max_cmd_len \* 3`
-    ;;
-
-  interix*)
-    # We know the value 262144 and hardcode it with a safety zone (like =
BSD)
-    lt_cv_sys_max_cmd_len=3D196608
-    ;;
-
-  osf*)
-    # Dr. Hans Ekkehard Plesser reports seeing a kernel panic running co=
nfigure
-    # due to this test when exec_disable_arg_limit is 1 on Tru64. It is =
not
-    # nice to cause kernel panics so lets avoid the loop below.
-    # First set a reasonable default.
-    lt_cv_sys_max_cmd_len=3D16384
-    #
-    if test -x /sbin/sysconfig; then
-      case `/sbin/sysconfig -q proc exec_disable_arg_limit` in
-        *1*) lt_cv_sys_max_cmd_len=3D-1 ;;
-      esac
-    fi
-    ;;
-  sco3.2v5*)
-    lt_cv_sys_max_cmd_len=3D102400
-    ;;
-  sysv5* | sco5v6* | sysv4.2uw2*)
-    kargmax=3D`grep ARG_MAX /etc/conf/cf.d/stune 2>/dev/null`
-    if test -n "$kargmax"; then
-      lt_cv_sys_max_cmd_len=3D`echo $kargmax | sed 's/.*[ 	]//'`
-    else
-      lt_cv_sys_max_cmd_len=3D32768
-    fi
-    ;;
-  *)
+ *)
     # If test is not a shell built-in, we'll probably end up computing a
     # maximum length that is only half of the actual maximum length, but
     # we can't tell.
-    SHELL=3D${SHELL-${CONFIG_SHELL-/bin/sh}}
-    while (test "X"`$SHELL $0 --fallback-echo "X$teststring" 2>/dev/null=
` \
+    while (test "X"`$CONFIG_SHELL $0 --fallback-echo "X$teststring" 2>/d=
ev/null` \
 	       =3D "XX$teststring") >/dev/null 2>&1 &&
 	    new_result=3D`expr "X$teststring" : ".*" 2>&1` &&
 	    lt_cv_sys_max_cmd_len=3D$new_result &&
@@ -6664,6 +6572,9 @@
 # Regexp to match symbols that can be accessed directly from C.
 sympat=3D'\([_A-Za-z][_A-Za-z0-9]*\)'
=20
+# Transform the above into a raw symbol and a C symbol.
+symxfrm=3D'\1 \2\3 \3'
+
 # Transform an extracted symbol line into a proper C declaration
 lt_cv_sys_global_symbol_to_cdecl=3D"sed -n -e 's/^. .* \(.*\)$/extern in=
t \1;/p'"
=20
@@ -6685,31 +6596,15 @@
   lt_cv_sys_global_symbol_to_cdecl=3D"sed -n -e 's/^T .* \(.*\)$/extern =
int \1();/p' -e 's/^$symcode* .* \(.*\)$/extern char \1;/p'"
   lt_cv_sys_global_symbol_to_c_name_address=3D"sed -n -e 's/^: \([^ ]*\)=
 $/  {\\\"\1\\\", (lt_ptr) 0},/p' -e 's/^$symcode* \([^ ]*\) \([^ ]*\)$/ =
 {\"\2\", (lt_ptr) \&\2},/p'"
   ;;
-linux*)
-  if test "$host_cpu" =3D ia64; then
-    symcode=3D'[ABCDGIRSTW]'
-    lt_cv_sys_global_symbol_to_cdecl=3D"sed -n -e 's/^T .* \(.*\)$/exter=
n int \1();/p' -e 's/^$symcode* .* \(.*\)$/extern char \1;/p'"
-    lt_cv_sys_global_symbol_to_c_name_address=3D"sed -n -e 's/^: \([^ ]*=
\) $/  {\\\"\1\\\", (lt_ptr) 0},/p' -e 's/^$symcode* \([^ ]*\) \([^ ]*\)$=
/  {\"\2\", (lt_ptr) \&\2},/p'"
-  fi
-  ;;
 irix* | nonstopux*)
   symcode=3D'[BCDEGRST]'
   ;;
 osf*)
   symcode=3D'[BCDEGQRST]'
   ;;
-solaris*)
+solaris* | sysv5*)
   symcode=3D'[BDRT]'
   ;;
-sco3.2v5*)
-  symcode=3D'[DT]'
-  ;;
-sysv4.2uw2*)
-  symcode=3D'[DT]'
-  ;;
-sysv5* | sco5v6* | unixware* | OpenUNIX*)
-  symcode=3D'[ABDT]'
-  ;;
 sysv4)
   symcode=3D'[DFNSTU]'
   ;;
@@ -6732,11 +6627,8 @@
 # Try without a prefix undercore, then with it.
 for ac_symprfx in "" "_"; do
=20
-  # Transform symcode, sympat, and symprfx into a raw symbol and a C sym=
bol.
-  symxfrm=3D"\\1 $ac_symprfx\\2 \\2"
-
   # Write the raw and C identifiers.
-  lt_cv_sys_global_symbol_pipe=3D"sed -n -e 's/^.*[ 	]\($symcode$symcode=
*\)[ 	][ 	]*$ac_symprfx$sympat$opt_cr$/$symxfrm/p'"
+  lt_cv_sys_global_symbol_pipe=3D"sed -n -e 's/^.*[ 	]\($symcode$symcode=
*\)[ 	][ 	]*\($ac_symprfx\)$sympat$opt_cr$/$symxfrm/p'"
=20
   # Check to see that the pipe works correctly.
   pipe_works=3Dno
@@ -6898,7 +6790,7 @@
=20
 # Sed substitution that helps us do robust quoting.  It backslashifies
 # metacharacters that are still active within double-quoted strings.
-Xsed=3D'sed -e 1s/^X//'
+Xsed=3D'sed -e s/^X//'
 sed_quote_subst=3D's/\([\\"\\`$\\\\]\)/\\\1/g'
=20
 # Same as above, but do not quote variable references.
@@ -6918,7 +6810,7 @@
 default_ofile=3Dlibtool
 can_build_shared=3Dyes
=20
-# All known linkers require a `.a' archive for static linking (except MS=
VC,
+# All known linkers require a `.a' archive for static linking (except M$=
VC,
 # which needs '.lib').
 libext=3Da
 ltmain=3D"$ac_aux_dir/ltmain.sh"
@@ -7175,7 +7067,6 @@
 test -z "$AS" && AS=3Das
 test -z "$CC" && CC=3Dcc
 test -z "$LTCC" && LTCC=3D$CC
-test -z "$LTCFLAGS" && LTCFLAGS=3D$CFLAGS
 test -z "$DLLTOOL" && DLLTOOL=3Ddlltool
 test -z "$LD" && LD=3Dld
 test -z "$LN_S" && LN_S=3D"ln -s"
@@ -7195,26 +7086,15 @@
 if test -n "$RANLIB"; then
   case $host_os in
   openbsd*)
-    old_postinstall_cmds=3D"$old_postinstall_cmds~\$RANLIB -t \$oldlib"
+    old_postinstall_cmds=3D"\$RANLIB -t \$oldlib~$old_postinstall_cmds"
     ;;
   *)
-    old_postinstall_cmds=3D"$old_postinstall_cmds~\$RANLIB \$oldlib"
+    old_postinstall_cmds=3D"\$RANLIB \$oldlib~$old_postinstall_cmds"
     ;;
   esac
   old_archive_cmds=3D"$old_archive_cmds~\$RANLIB \$oldlib"
 fi
=20
-for cc_temp in $compiler""; do
-  case $cc_temp in
-    compile | *[\\/]compile | ccache | *[\\/]ccache ) ;;
-    distcc | *[\\/]distcc | purify | *[\\/]purify ) ;;
-    \-*) ;;
-    *) break;;
-  esac
-done
-cc_basename=3D`$echo "X$cc_temp" | $Xsed -e 's%.*/%%' -e "s%^$host_alias=
-%%"`
-
-
 # Only perform the check for file, if the check method requires it
 case $deplibs_check_method in
 file_magic*)
@@ -7240,7 +7120,7 @@
       if test -n "$file_magic_test_file"; then
 	case $deplibs_check_method in
 	"file_magic "*)
-	  file_magic_regex=3D`expr "$deplibs_check_method" : "file_magic \(.*\)=
"`
+	  file_magic_regex=3D"`expr \"$deplibs_check_method\" : \"file_magic \(=
.*\)\"`"
 	  MAGIC_CMD=3D"$lt_cv_path_MAGIC_CMD"
 	  if eval $file_magic_cmd \$file_magic_test_file 2> /dev/null |
 	    $EGREP "$file_magic_regex" > /dev/null; then
@@ -7302,7 +7182,7 @@
       if test -n "$file_magic_test_file"; then
 	case $deplibs_check_method in
 	"file_magic "*)
-	  file_magic_regex=3D`expr "$deplibs_check_method" : "file_magic \(.*\)=
"`
+	  file_magic_regex=3D"`expr \"$deplibs_check_method\" : \"file_magic \(=
.*\)\"`"
 	  MAGIC_CMD=3D"$lt_cv_path_MAGIC_CMD"
 	  if eval $file_magic_cmd \$file_magic_test_file 2> /dev/null |
 	    $EGREP "$file_magic_regex" > /dev/null; then
@@ -7397,28 +7277,71 @@
 # If no C compiler was specified, use CC.
 LTCC=3D${LTCC-"$CC"}
=20
-# If no C compiler flags were specified, use CFLAGS.
-LTCFLAGS=3D${LTCFLAGS-"$CFLAGS"}
-
 # Allow CC to be a program name with arguments.
 compiler=3D$CC
=20
=20
-# save warnings/boilerplate of simple test code
-ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_compile_test_code" >conftest.$ac_ext
-eval "$ac_compile" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_compiler_boilerplate=3D`cat conftest.err`
-$rm conftest*
+#
+# Check for any special shared library compilation flags.
+#
+lt_prog_cc_shlib=3D
+if test "$GCC" =3D no; then
+  case $host_os in
+  sco3.2v5*)
+    lt_prog_cc_shlib=3D'-belf'
+    ;;
+  esac
+fi
+if test -n "$lt_prog_cc_shlib"; then
+  { echo "$as_me:$LINENO: WARNING: \`$CC' requires \`$lt_prog_cc_shlib' =
to build shared libraries" >&5
+echo "$as_me: WARNING: \`$CC' requires \`$lt_prog_cc_shlib' to build sha=
red libraries" >&2;}
+  if echo "$old_CC $old_CFLAGS " | grep "[ 	]$lt_prog_cc_shlib[ 	]" >/de=
v/null; then :
+  else
+    { echo "$as_me:$LINENO: WARNING: add \`$lt_prog_cc_shlib' to the CC =
or CFLAGS env variable and reconfigure" >&5
+echo "$as_me: WARNING: add \`$lt_prog_cc_shlib' to the CC or CFLAGS env =
variable and reconfigure" >&2;}
+    lt_cv_prog_cc_can_build_shared=3Dno
+  fi
+fi
=20
-ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_link_test_code" >conftest.$ac_ext
-eval "$ac_link" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_linker_boilerplate=3D`cat conftest.err`
-$rm conftest*
=20
+#
+# Check to make sure the static flag actually works.
+#
+echo "$as_me:$LINENO: checking if $compiler static flag $lt_prog_compile=
r_static works" >&5
+echo $ECHO_N "checking if $compiler static flag $lt_prog_compiler_static=
 works... $ECHO_C" >&6
+if test "${lt_prog_compiler_static_works+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  lt_prog_compiler_static_works=3Dno
+   save_LDFLAGS=3D"$LDFLAGS"
+   LDFLAGS=3D"$LDFLAGS $lt_prog_compiler_static"
+   printf "$lt_simple_link_test_code" > conftest.$ac_ext
+   if (eval $ac_link 2>conftest.err) && test -s conftest$ac_exeext; then
+     # The compiler can only warn and ignore the option if not recognize=
d
+     # So say no if there are warnings
+     if test -s conftest.err; then
+       # Append any errors to the config.log.
+       cat conftest.err 1>&5
+     else
+       lt_prog_compiler_static_works=3Dyes
+     fi
+   fi
+   $rm conftest*
+   LDFLAGS=3D"$save_LDFLAGS"
=20
+fi
+echo "$as_me:$LINENO: result: $lt_prog_compiler_static_works" >&5
+echo "${ECHO_T}$lt_prog_compiler_static_works" >&6
=20
+if test x"$lt_prog_compiler_static_works" =3D xyes; then
+    :
+else
+    lt_prog_compiler_static=3D
+fi
+
+
+
+
 lt_prog_compiler_no_builtin_flag=3D
=20
 if test "$GCC" =3D yes; then
@@ -7440,20 +7363,18 @@
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    # The option is referenced via a variable to avoid confusing sed.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [^ ]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
-   (eval echo "\"\$as_me:7446: $lt_compile\"" >&5)
+   (eval echo "\"\$as_me:7369: $lt_compile\"" >&5)
    (eval "$lt_compile" 2>conftest.err)
    ac_status=3D$?
    cat conftest.err >&5
-   echo "$as_me:7450: \$? =3D $ac_status" >&5
+   echo "$as_me:7373: \$? =3D $ac_status" >&5
    if (exit $ac_status) && test -s "$ac_outfile"; then
      # The compiler can only warn and ignore the option if not recognize=
d
-     # So say no if there are warnings other than the usual output.
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' >conftest.exp
-     $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-     if test ! -s conftest.er2 || diff conftest.exp conftest.er2 >/dev/n=
ull; then
+     # So say no if there are warnings
+     if test ! -s conftest.err; then
        lt_cv_prog_compiler_rtti_exceptions=3Dyes
      fi
    fi
@@ -7514,11 +7435,6 @@
       lt_prog_compiler_pic=3D'-fno-common'
       ;;
=20
-    interix3*)
-      # Interix 3.x gcc -fpic/-fPIC options generate broken code.
-      # Instead, we relocate shared libraries at runtime.
-      ;;
-
     msdosdjgpp*)
       # Just because we use GCC doesn't mean we suddenly get shared libr=
aries
       # on systems that don't support them.
@@ -7535,7 +7451,7 @@
     hpux*)
       # PIC is the default for IA64 HP-UX and 64-bit HP-UX, but
       # not for PA HP-UX.
-      case $host_cpu in
+      case "$host_cpu" in
       hppa*64*|ia64*)
 	# +Z the default
 	;;
@@ -7561,16 +7477,6 @@
 	lt_prog_compiler_static=3D'-bnso -bI:/lib/syscalls.exp'
       fi
       ;;
-      darwin*)
-        # PIC is the default on this platform
-        # Common symbols not allowed in MH_DYLIB files
-       case $cc_basename in
-         xlc*)
-         lt_prog_compiler_pic=3D'-qnocommon'
-         lt_prog_compiler_wl=3D'-Wl,'
-         ;;
-       esac
-       ;;
=20
     mingw* | pw32* | os2*)
       # This hack is so that the source file can tell whether it is bein=
g
@@ -7582,7 +7488,7 @@
       lt_prog_compiler_wl=3D'-Wl,'
       # PIC is the default for IA64 HP-UX and 64-bit HP-UX, but
       # not for PA HP-UX.
-      case $host_cpu in
+      case "$host_cpu" in
       hppa*64*|ia64*)
 	# +Z the default
 	;;
@@ -7606,19 +7512,12 @@
       ;;
=20
     linux*)
-      case $cc_basename in
+      case $CC in
       icc* | ecc*)
 	lt_prog_compiler_wl=3D'-Wl,'
 	lt_prog_compiler_pic=3D'-KPIC'
 	lt_prog_compiler_static=3D'-static'
         ;;
-      pgcc* | pgf77* | pgf90* | pgf95*)
-        # Portland Group compilers (*not* the Pentium gcc compiler,
-	# which looks to be a dead project)
-	lt_prog_compiler_wl=3D'-Wl,'
-	lt_prog_compiler_pic=3D'-fpic'
-	lt_prog_compiler_static=3D'-Bstatic'
-        ;;
       ccc*)
         lt_prog_compiler_wl=3D'-Wl,'
         # All Alpha code is PIC.
@@ -7633,15 +7532,15 @@
       lt_prog_compiler_static=3D'-non_shared'
       ;;
=20
+    sco3.2v5*)
+      lt_prog_compiler_pic=3D'-Kpic'
+      lt_prog_compiler_static=3D'-dn'
+      ;;
+
     solaris*)
+      lt_prog_compiler_wl=3D'-Wl,'
       lt_prog_compiler_pic=3D'-KPIC'
       lt_prog_compiler_static=3D'-Bstatic'
-      case $cc_basename in
-      f77* | f90* | f95*)
-	lt_prog_compiler_wl=3D'-Qoption ld ';;
-      *)
-	lt_prog_compiler_wl=3D'-Wl,';;
-      esac
       ;;
=20
     sunos4*)
@@ -7650,7 +7549,7 @@
       lt_prog_compiler_static=3D'-Bstatic'
       ;;
=20
-    sysv4 | sysv4.2uw2* | sysv4.3*)
+    sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
       lt_prog_compiler_wl=3D'-Wl,'
       lt_prog_compiler_pic=3D'-KPIC'
       lt_prog_compiler_static=3D'-Bstatic'
@@ -7663,17 +7562,6 @@
       fi
       ;;
=20
-    sysv5* | unixware* | sco3.2v5* | sco5v6* | OpenUNIX*)
-      lt_prog_compiler_wl=3D'-Wl,'
-      lt_prog_compiler_pic=3D'-KPIC'
-      lt_prog_compiler_static=3D'-Bstatic'
-      ;;
-
-    unicos*)
-      lt_prog_compiler_wl=3D'-Wl,'
-      lt_prog_compiler_can_build_shared=3Dno
-      ;;
-
     uts4*)
       lt_prog_compiler_pic=3D'-pic'
       lt_prog_compiler_static=3D'-Bstatic'
@@ -7708,20 +7596,18 @@
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    # The option is referenced via a variable to avoid confusing sed.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [^ ]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
-   (eval echo "\"\$as_me:7714: $lt_compile\"" >&5)
+   (eval echo "\"\$as_me:7602: $lt_compile\"" >&5)
    (eval "$lt_compile" 2>conftest.err)
    ac_status=3D$?
    cat conftest.err >&5
-   echo "$as_me:7718: \$? =3D $ac_status" >&5
+   echo "$as_me:7606: \$? =3D $ac_status" >&5
    if (exit $ac_status) && test -s "$ac_outfile"; then
      # The compiler can only warn and ignore the option if not recognize=
d
-     # So say no if there are warnings other than the usual output.
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' >conftest.exp
-     $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-     if test ! -s conftest.er2 || diff conftest.exp conftest.er2 >/dev/n=
ull; then
+     # So say no if there are warnings
+     if test ! -s conftest.err; then
        lt_prog_compiler_pic_works=3Dyes
      fi
    fi
@@ -7742,7 +7628,7 @@
 fi
=20
 fi
-case $host_os in
+case "$host_os" in
   # For platforms which do not support PIC, -DPIC is meaningless:
   *djgpp*)
     lt_prog_compiler_pic=3D
@@ -7752,48 +7638,6 @@
     ;;
 esac
=20
-#
-# Check to make sure the static flag actually works.
-#
-wl=3D$lt_prog_compiler_wl eval lt_tmp_static_flag=3D\"$lt_prog_compiler_=
static\"
-echo "$as_me:$LINENO: checking if $compiler static flag $lt_tmp_static_f=
lag works" >&5
-echo $ECHO_N "checking if $compiler static flag $lt_tmp_static_flag work=
s... $ECHO_C" >&6
-if test "${lt_prog_compiler_static_works+set}" =3D set; then
-  echo $ECHO_N "(cached) $ECHO_C" >&6
-else
-  lt_prog_compiler_static_works=3Dno
-   save_LDFLAGS=3D"$LDFLAGS"
-   LDFLAGS=3D"$LDFLAGS $lt_tmp_static_flag"
-   printf "$lt_simple_link_test_code" > conftest.$ac_ext
-   if (eval $ac_link 2>conftest.err) && test -s conftest$ac_exeext; then
-     # The linker can only warn and ignore the option if not recognized
-     # So say no if there are warnings
-     if test -s conftest.err; then
-       # Append any errors to the config.log.
-       cat conftest.err 1>&5
-       $echo "X$_lt_linker_boilerplate" | $Xsed -e '/^$/d' > conftest.ex=
p
-       $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-       if diff conftest.exp conftest.er2 >/dev/null; then
-         lt_prog_compiler_static_works=3Dyes
-       fi
-     else
-       lt_prog_compiler_static_works=3Dyes
-     fi
-   fi
-   $rm conftest*
-   LDFLAGS=3D"$save_LDFLAGS"
-
-fi
-echo "$as_me:$LINENO: result: $lt_prog_compiler_static_works" >&5
-echo "${ECHO_T}$lt_prog_compiler_static_works" >&6
-
-if test x"$lt_prog_compiler_static_works" =3D xyes; then
-    :
-else
-    lt_prog_compiler_static=3D
-fi
-
-
 echo "$as_me:$LINENO: checking if $compiler supports -c -o file.$ac_obje=
xt" >&5
 echo $ECHO_N "checking if $compiler supports -c -o file.$ac_objext... $E=
CHO_C" >&6
 if test "${lt_cv_prog_compiler_c_o+set}" =3D set; then
@@ -7812,25 +7656,23 @@
    # Note that $ac_compile itself does not contain backslashes and begin=
s
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [^ ]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
-   (eval echo "\"\$as_me:7818: $lt_compile\"" >&5)
+   (eval echo "\"\$as_me:7662: $lt_compile\"" >&5)
    (eval "$lt_compile" 2>out/conftest.err)
    ac_status=3D$?
    cat out/conftest.err >&5
-   echo "$as_me:7822: \$? =3D $ac_status" >&5
+   echo "$as_me:7666: \$? =3D $ac_status" >&5
    if (exit $ac_status) && test -s out/conftest2.$ac_objext
    then
      # The compiler can only warn and ignore the option if not recognize=
d
      # So say no if there are warnings
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' > out/conftes=
t.exp
-     $SED '/^$/d; /^ *+/d' out/conftest.err >out/conftest.er2
-     if test ! -s out/conftest.er2 || diff out/conftest.exp out/conftest=
.er2 >/dev/null; then
+     if test ! -s out/conftest.err; then
        lt_cv_prog_compiler_c_o=3Dyes
      fi
    fi
-   chmod u+w . 2>&5
+   chmod u+w .
    $rm conftest*
    # SGI C++ compiler will create directory out/ii_files/ for
    # template instantiation
@@ -7906,16 +7748,6 @@
   # rely on this symbol name, it's probably fine to never include it in
   # preloaded symbol tables.
   extract_expsyms_cmds=3D
-  # Just being paranoid about ensuring that cc_basename is set.
-  for cc_temp in $compiler""; do
-  case $cc_temp in
-    compile | *[\\/]compile | ccache | *[\\/]ccache ) ;;
-    distcc | *[\\/]distcc | purify | *[\\/]purify ) ;;
-    \-*) ;;
-    *) break;;
-  esac
-done
-cc_basename=3D`$echo "X$cc_temp" | $Xsed -e 's%.*/%%' -e "s%^$host_alias=
-%%"`
=20
   case $host_os in
   cygwin* | mingw* | pw32*)
@@ -7926,10 +7758,6 @@
       with_gnu_ld=3Dno
     fi
     ;;
-  interix*)
-    # we just hope/assume this is gcc and not c89 (=3D MSVC++)
-    with_gnu_ld=3Dyes
-    ;;
   openbsd*)
     with_gnu_ld=3Dno
     ;;
@@ -7940,27 +7768,6 @@
     # If archive_cmds runs LD, not CC, wlarc should be empty
     wlarc=3D'${wl}'
=20
-    # Set some defaults for GNU ld with shared library support. These
-    # are reset later if shared libraries are not supported. Putting the=
m
-    # here allows them to be overridden if necessary.
-    runpath_var=3DLD_RUN_PATH
-    hardcode_libdir_flag_spec=3D'${wl}--rpath ${wl}$libdir'
-    export_dynamic_flag_spec=3D'${wl}--export-dynamic'
-    # ancient GNU ld didn't support --whole-archive et. al.
-    if $LD --help 2>&1 | grep 'no-whole-archive' > /dev/null; then
-	whole_archive_flag_spec=3D"$wlarc"'--whole-archive$convenience '"$wlarc=
"'--no-whole-archive'
-      else
-  	whole_archive_flag_spec=3D
-    fi
-    supports_anon_versioning=3Dno
-    case `$LD -v 2>/dev/null` in
-      *\ [01].* | *\ 2.[0-9].* | *\ 2.10.*) ;; # catch versions < 2.11
-      *\ 2.11.93.0.2\ *) supports_anon_versioning=3Dyes ;; # RH7.3 ...
-      *\ 2.11.92.0.12\ *) supports_anon_versioning=3Dyes ;; # Mandrake 8=
.2 ...
-      *\ 2.11.*) ;; # other 2.11 versions
-      *) supports_anon_versioning=3Dyes ;;
-    esac
-
     # See if GNU ld supports shared libraries.
     case $host_os in
     aix3* | aix4* | aix5*)
@@ -8011,10 +7818,10 @@
       allow_undefined_flag=3Dunsupported
       always_export_symbols=3Dno
       enable_shared_with_static_runtimes=3Dyes
-      export_symbols_cmds=3D'$NM $libobjs $convenience | $global_symbol_=
pipe | $SED -e '\''/^[BCDGRS] /s/.* \([^ ]*\)/\1 DATA/'\'' | $SED -e '\''=
/^[AITW] /s/.* //'\'' | sort | uniq > $export_symbols'
+      export_symbols_cmds=3D'$NM $libobjs $convenience | $global_symbol_=
pipe | $SED -e '\''/^[BCDGS] /s/.* \([^ ]*\)/\1 DATA/'\'' | $SED -e '\''/=
^[AITW] /s/.* //'\'' | sort | uniq > $export_symbols'
=20
       if $LD --help 2>&1 | grep 'auto-import' > /dev/null; then
-        archive_cmds=3D'$CC -shared $libobjs $deplibs $compiler_flags -o=
 $output_objdir/$soname ${wl}--enable-auto-image-base -Xlinker --out-impl=
ib -Xlinker $lib'
+        archive_cmds=3D'$CC -shared $libobjs $deplibs $compiler_flags -o=
 $output_objdir/$soname ${wl}--image-base=3D0x10000000 ${wl}--out-implib,=
$lib'
 	# If the export-symbols file already is a .def file (1st line
 	# is EXPORTS), use it as is; otherwise, prepend...
 	archive_expsym_cmds=3D'if test "x`$SED 1q $export_symbols`" =3D xEXPORT=
S; then
@@ -8023,59 +7830,12 @@
 	  echo EXPORTS > $output_objdir/$soname.def;
 	  cat $export_symbols >> $output_objdir/$soname.def;
 	fi~
-	$CC -shared $output_objdir/$soname.def $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--enable-auto-image-base -Xlinker --out-=
implib -Xlinker $lib'
+	$CC -shared $output_objdir/$soname.def $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--image-base=3D0x10000000  ${wl}--out-im=
plib,$lib'
       else
 	ld_shlibs=3Dno
       fi
       ;;
=20
-    interix3*)
-      hardcode_direct=3Dno
-      hardcode_shlibpath_var=3Dno
-      hardcode_libdir_flag_spec=3D'${wl}-rpath,$libdir'
-      export_dynamic_flag_spec=3D'${wl}-E'
-      # Hack: On Interix 3.x, we cannot compile PIC because of a broken =
gcc.
-      # Instead, shared libraries are loaded at an image base (0x1000000=
0 by
-      # default) and relocated if they conflict, which is a slow very me=
mory
-      # consuming and fragmenting process.  To avoid this, we pick a ran=
dom,
-      # 256 KiB-aligned image base between 0x50000000 and 0x6FFC0000 at =
link
-      # time.  Moving up from 0x10000000 also allows more sbrk(2) space.
-      archive_cmds=3D'$CC -shared $pic_flag $libobjs $deplibs $compiler_=
flags ${wl}-h,$soname ${wl}--image-base,`expr ${RANDOM-$$} % 4096 / 2 \* =
262144 + 1342177280` -o $lib'
-      archive_expsym_cmds=3D'sed "s,^,_," $export_symbols >$output_objdi=
r/$soname.expsym~$CC -shared $pic_flag $libobjs $deplibs $compiler_flags =
${wl}-h,$soname ${wl}--retain-symbols-file,$output_objdir/$soname.expsym =
${wl}--image-base,`expr ${RANDOM-$$} % 4096 / 2 \* 262144 + 1342177280` -=
o $lib'
-      ;;
-
-    linux*)
-      if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null=
; then
-	tmp_addflag=3D
-	case $cc_basename,$host_cpu in
-	pgcc*)				# Portland Group C compiler
-	  whole_archive_flag_spec=3D'${wl}--whole-archive`for conv in $convenie=
nce\"\"; do test  -n \"$conv\" && new_convenience=3D\"$new_convenience,$c=
onv\"; done; $echo \"$new_convenience\"` ${wl}--no-whole-archive'
-	  tmp_addflag=3D' $pic_flag'
-	  ;;
-	pgf77* | pgf90* | pgf95*)	# Portland Group f77 and f90 compilers
-	  whole_archive_flag_spec=3D'${wl}--whole-archive`for conv in $convenie=
nce\"\"; do test  -n \"$conv\" && new_convenience=3D\"$new_convenience,$c=
onv\"; done; $echo \"$new_convenience\"` ${wl}--no-whole-archive'
-	  tmp_addflag=3D' $pic_flag -Mnomain' ;;
-	ecc*,ia64* | icc*,ia64*)		# Intel C compiler on ia64
-	  tmp_addflag=3D' -i_dynamic' ;;
-	efc*,ia64* | ifort*,ia64*)	# Intel Fortran compiler on ia64
-	  tmp_addflag=3D' -i_dynamic -nofor_main' ;;
-	ifc* | ifort*)			# Intel Fortran compiler
-	  tmp_addflag=3D' -nofor_main' ;;
-	esac
-	archive_cmds=3D'$CC -shared'"$tmp_addflag"' $libobjs $deplibs $compiler=
_flags ${wl}-soname $wl$soname -o $lib'
-
-	if test $supports_anon_versioning =3D yes; then
-	  archive_expsym_cmds=3D'$echo "{ global:" > $output_objdir/$libname.ve=
r~
-  cat $export_symbols | sed -e "s/\(.*\)/\1;/" >> $output_objdir/$libnam=
e.ver~
-  $echo "local: *; };" >> $output_objdir/$libname.ver~
-	  $CC -shared'"$tmp_addflag"' $libobjs $deplibs $compiler_flags ${wl}-s=
oname $wl$soname ${wl}-version-script ${wl}$output_objdir/$libname.ver -o=
 $lib'
-	fi
-	link_all_deplibs=3Dno
-      else
-	ld_shlibs=3Dno
-      fi
-      ;;
-
     netbsd* | netbsdelf*-gnu | knetbsd*-gnu)
       if echo __ELF__ | $CC -E - | grep __ELF__ >/dev/null; then
 	archive_cmds=3D'$LD -Bshareable $libobjs $deplibs $linker_flags -o $lib=
'
@@ -8086,7 +7846,7 @@
       fi
       ;;
=20
-    solaris*)
+    solaris* | sysv5*)
       if $LD -v 2>&1 | grep 'BFD 2\.8' > /dev/null; then
 	ld_shlibs=3Dno
 	cat <<EOF 1>&2
@@ -8107,33 +7867,6 @@
       fi
       ;;
=20
-    sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX*)
-      case `$LD -v 2>&1` in
-        *\ [01].* | *\ 2.[0-9].* | *\ 2.1[0-5].*)
-	ld_shlibs=3Dno
-	cat <<_LT_EOF 1>&2
-
-*** Warning: Releases of the GNU linker prior to 2.16.91.0.3 can not
-*** reliably create shared libraries on SCO systems.  Therefore, libtool
-*** is disabling shared libraries support.  We urge you to upgrade GNU
-*** binutils to release 2.16.91.0.3 or newer.  Another option is to modi=
fy
-*** your PATH or compiler configuration so that the native linker is
-*** used, and then restart.
-
-_LT_EOF
-	;;
-	*)
-	  if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null; t=
hen
-	    hardcode_libdir_flag_spec=3D'`test -z "$SCOABSPATH" && echo ${wl}-r=
path,$libdir`'
-	    archive_cmds=3D'$CC -shared $libobjs $deplibs $compiler_flags ${wl}=
-soname,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib'
-	    archive_expsym_cmds=3D'$CC -shared $libobjs $deplibs $compiler_flag=
s ${wl}-soname,\${SCOABSPATH:+${install_libdir}/}$soname,-retain-symbols-=
file,$export_symbols -o $lib'
-	  else
-	    ld_shlibs=3Dno
-	  fi
-	;;
-      esac
-      ;;
-
     sunos4*)
       archive_cmds=3D'$LD -assert pure-text -Bshareable -o $lib $libobjs=
 $deplibs $linker_flags'
       wlarc=3D
@@ -8141,6 +7874,32 @@
       hardcode_shlibpath_var=3Dno
       ;;
=20
+  linux*)
+    if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null; =
then
+        tmp_archive_cmds=3D'$CC -shared $libobjs $deplibs $compiler_flag=
s ${wl}-soname $wl$soname -o $lib'
+	archive_cmds=3D"$tmp_archive_cmds"
+      supports_anon_versioning=3Dno
+      case `$LD -v 2>/dev/null` in
+        *\ 01.* | *\ 2.[0-9].* | *\ 2.10.*) ;; # catch versions < 2.11
+        *\ 2.11.93.0.2\ *) supports_anon_versioning=3Dyes ;; # RH7.3 ...
+        *\ 2.11.92.0.12\ *) supports_anon_versioning=3Dyes ;; # Mandrake=
 8.2 ...
+        *\ 2.11.*) ;; # other 2.11 versions
+        *) supports_anon_versioning=3Dyes ;;
+      esac
+      if test $supports_anon_versioning =3D yes; then
+        archive_expsym_cmds=3D'$echo "{ global:" > $output_objdir/$libna=
me.ver~
+cat $export_symbols | sed -e "s/\(.*\)/\1;/" >> $output_objdir/$libname.=
ver~
+$echo "local: *; };" >> $output_objdir/$libname.ver~
+        $CC -shared $libobjs $deplibs $compiler_flags ${wl}-soname $wl$s=
oname ${wl}-version-script ${wl}$output_objdir/$libname.ver -o $lib'
+      else
+        archive_expsym_cmds=3D"$tmp_archive_cmds"
+      fi
+      link_all_deplibs=3Dno
+    else
+      ld_shlibs=3Dno
+    fi
+    ;;
+
     *)
       if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null=
; then
 	archive_cmds=3D'$CC -shared $libobjs $deplibs $compiler_flags ${wl}-son=
ame $wl$soname -o $lib'
@@ -8151,11 +7910,16 @@
       ;;
     esac
=20
-    if test "$ld_shlibs" =3D no; then
-      runpath_var=3D
-      hardcode_libdir_flag_spec=3D
-      export_dynamic_flag_spec=3D
-      whole_archive_flag_spec=3D
+    if test "$ld_shlibs" =3D yes; then
+      runpath_var=3DLD_RUN_PATH
+      hardcode_libdir_flag_spec=3D'${wl}--rpath ${wl}$libdir'
+      export_dynamic_flag_spec=3D'${wl}--export-dynamic'
+      # ancient GNU ld didn't support --whole-archive et. al.
+      if $LD --help 2>&1 | grep 'no-whole-archive' > /dev/null; then
+ 	whole_archive_flag_spec=3D"$wlarc"'--whole-archive$convenience '"$wlar=
c"'--no-whole-archive'
+      else
+  	whole_archive_flag_spec=3D
+      fi
     fi
   else
     # PORTME fill in a description of your system's linker (not GNU ld)
@@ -8167,7 +7931,7 @@
       # Note: this linker hardcodes the directories in LIBPATH if there
       # are no directories specified by -L.
       hardcode_minus_L=3Dyes
-      if test "$GCC" =3D yes && test -z "$lt_prog_compiler_static"; then
+      if test "$GCC" =3D yes && test -z "$link_static_flag"; then
 	# Neither direct hardcoding nor static linking is supported with a
 	# broken collect2.
 	hardcode_direct=3Dunsupported
@@ -8201,7 +7965,6 @@
   	    break
   	  fi
 	  done
-	  ;;
 	esac
=20
 	exp_sym_flag=3D'-bexport'
@@ -8220,7 +7983,7 @@
       link_all_deplibs=3Dyes
=20
       if test "$GCC" =3D yes; then
-	case $host_os in aix4.[012]|aix4.[012].*)
+	case $host_os in aix4.012|aix4.012.*)
 	# We only want to do this on AIX 4.2 and lower, the check
 	# below for broken collect2 doesn't work under 4.3+
 	  collect2name=3D`${CC} -print-prog-name=3Dcollect2`
@@ -8239,12 +8002,8 @@
   	  hardcode_libdir_flag_spec=3D'-L$libdir'
   	  hardcode_libdir_separator=3D
 	  fi
-	  ;;
 	esac
 	shared_flag=3D'-shared'
-	if test "$aix_use_runtimelinking" =3D yes; then
-	  shared_flag=3D"$shared_flag "'${wl}-G'
-	fi
       else
 	# not using gcc
 	if test "$host_cpu" =3D ia64; then
@@ -8252,11 +8011,11 @@
   	# chokes on -Wl,-G. The following line is correct:
 	  shared_flag=3D'-G'
 	else
-	  if test "$aix_use_runtimelinking" =3D yes; then
+  	if test "$aix_use_runtimelinking" =3D yes; then
 	    shared_flag=3D'${wl}-G'
 	  else
 	    shared_flag=3D'${wl}-bM:SRE'
-	  fi
+  	fi
 	fi
       fi
=20
@@ -8320,12 +8079,12 @@
 if test -z "$aix_libpath"; then aix_libpath=3D"/usr/lib:/lib"; fi
=20
        hardcode_libdir_flag_spec=3D'${wl}-blibpath:$libdir:'"$aix_libpat=
h"
-	archive_expsym_cmds=3D"\$CC"' -o $output_objdir/$soname $libobjs $depli=
bs '"\${wl}$no_entry_flag"' $compiler_flags `if test "x${allow_undefined_=
flag}" !=3D "x"; then echo "${wl}${allow_undefined_flag}"; else :; fi` '"=
\${wl}$exp_sym_flag:\$export_symbols $shared_flag"
+	archive_expsym_cmds=3D"\$CC"' -o $output_objdir/$soname $libobjs $depli=
bs $compiler_flags `if test "x${allow_undefined_flag}" !=3D "x"; then ech=
o "${wl}${allow_undefined_flag}"; else :; fi` '"\${wl}$no_entry_flag \${w=
l}$exp_sym_flag:\$export_symbols $shared_flag"
        else
 	if test "$host_cpu" =3D ia64; then
 	  hardcode_libdir_flag_spec=3D'${wl}-R $libdir:/usr/lib:/lib'
 	  allow_undefined_flag=3D"-z nodefs"
-	  archive_expsym_cmds=3D"\$CC $shared_flag"' -o $output_objdir/$soname =
$libobjs $deplibs '"\${wl}$no_entry_flag"' $compiler_flags ${wl}${allow_u=
ndefined_flag} '"\${wl}$exp_sym_flag:\$export_symbols"
+	  archive_expsym_cmds=3D"\$CC $shared_flag"' -o $output_objdir/$soname =
$libobjs $deplibs $compiler_flags ${wl}${allow_undefined_flag} '"\${wl}$n=
o_entry_flag \${wl}$exp_sym_flag:\$export_symbols"
 	else
 	 # Determine the default libpath from the value encoded in an empty exe=
cutable.
 	 cat >conftest.$ac_ext <<_ACEOF
@@ -8384,11 +8143,13 @@
 	  # -berok will link without error, but may produce a broken library.
 	  no_undefined_flag=3D' ${wl}-bernotok'
 	  allow_undefined_flag=3D' ${wl}-berok'
+	  # -bexpall does not export symbols beginning with underscore (_)
+	  always_export_symbols=3Dyes
 	  # Exported symbols can be pulled into shared objects from archives
-	  whole_archive_flag_spec=3D'$convenience'
+	  whole_archive_flag_spec=3D' '
 	  archive_cmds_need_lc=3Dyes
-	  # This is similar to how AIX traditionally builds its shared librarie=
s.
-	  archive_expsym_cmds=3D"\$CC $shared_flag"' -o $output_objdir/$soname =
$libobjs $deplibs ${wl}-bnoentry $compiler_flags ${wl}-bE:$export_symbols=
${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$libname$release.a $=
output_objdir/$soname'
+	  # This is similar to how AIX traditionally builds it's shared librari=
es.
+	  archive_expsym_cmds=3D"\$CC $shared_flag"' -o $output_objdir/$soname =
$libobjs $deplibs $compiler_flags ${wl}-bE:$export_symbols ${wl}-bnoentry=
${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$libname$release.a $=
output_objdir/$soname'
 	fi
       fi
       ;;
@@ -8401,7 +8162,7 @@
       ld_shlibs=3Dno
       ;;
=20
-    bsdi[45]*)
+    bsdi4*)
       export_dynamic_flag_spec=3D-rdynamic
       ;;
=20
@@ -8427,52 +8188,52 @@
       ;;
=20
     darwin* | rhapsody*)
-      case $host_os in
-        rhapsody* | darwin1.[012])
-         allow_undefined_flag=3D'${wl}-undefined ${wl}suppress'
-         ;;
-       *) # Darwin 1.3 on
-         if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
-           allow_undefined_flag=3D'${wl}-flat_namespace ${wl}-undefined =
${wl}suppress'
-         else
-           case ${MACOSX_DEPLOYMENT_TARGET} in
-             10.[012])
-               allow_undefined_flag=3D'${wl}-flat_namespace ${wl}-undefi=
ned ${wl}suppress'
-               ;;
-             10.*)
-               allow_undefined_flag=3D'${wl}-undefined ${wl}dynamic_look=
up'
-               ;;
-           esac
-         fi
-         ;;
+    if test "$GXX" =3D yes ; then
+      archive_cmds_need_lc=3Dno
+      case "$host_os" in
+      rhapsody* | darwin1.[012])
+	allow_undefined_flag=3D'-undefined suppress'
+	;;
+      *) # Darwin 1.3 on
+      if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
+      	allow_undefined_flag=3D'-flat_namespace -undefined suppress'
+      else
+        case ${MACOSX_DEPLOYMENT_TARGET} in
+          10.[012])
+            allow_undefined_flag=3D'-flat_namespace -undefined suppress'
+            ;;
+          10.*)
+            allow_undefined_flag=3D'-undefined dynamic_lookup'
+            ;;
+        esac
+      fi
+	;;
       esac
-      archive_cmds_need_lc=3Dno
+    	lt_int_apple_cc_single_mod=3Dno
+    	output_verbose_link_cmd=3D'echo'
+    	if $CC -dumpspecs 2>&1 | grep 'single_module' >/dev/null ; then
+    	  lt_int_apple_cc_single_mod=3Dyes
+    	fi
+    	if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+    	  archive_cmds=3D'$CC -dynamiclib -single_module $allow_undefined_f=
lag -o $lib $libobjs $deplibs $compiler_flags -install_name $rpath/$sonam=
e $verstring'
+    	else
+        archive_cmds=3D'$CC -r ${wl}-bind_at_load -keep_private_externs =
-nostdlib -o ${lib}-master.o $libobjs~$CC -dynamiclib $allow_undefined_fl=
ag -o $lib ${lib}-master.o $deplibs $compiler_flags -install_name $rpath/=
$soname $verstring'
+      fi
+      module_cmds=3D'$CC ${wl}-bind_at_load $allow_undefined_flag -o $li=
b -bundle $libobjs $deplibs$compiler_flags'
+      # Don't fix this by using the ld -exported_symbols_list flag, it d=
oesn't exist in older darwin ld's
+        if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+          archive_expsym_cmds=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "=
s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exp=
sym~$CC -dynamiclib -single_module $allow_undefined_flag -o $lib $libobjs=
 $deplibs $compiler_flags -install_name $rpath/$soname $verstring~nmedit =
-s $output_objdir/${libname}-symbols.expsym ${lib}'
+        else
+          archive_expsym_cmds=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "=
s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exp=
sym~$CC -r ${wl}-bind_at_load -keep_private_externs -nostdlib -o ${lib}-m=
aster.o $libobjs~$CC -dynamiclib $allow_undefined_flag -o $lib ${lib}-mas=
ter.o $deplibs $compiler_flags -install_name $rpath/$soname $verstring~nm=
edit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+        fi
+          module_expsym_cmds=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "s=
,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exps=
ym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compiler_=
flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
       hardcode_direct=3Dno
       hardcode_automatic=3Dyes
       hardcode_shlibpath_var=3Dunsupported
-      whole_archive_flag_spec=3D''
+      whole_archive_flag_spec=3D'-all_load $convenience'
       link_all_deplibs=3Dyes
-    if test "$GCC" =3D yes ; then
-    	output_verbose_link_cmd=3D'echo'
-        archive_cmds=3D'$CC -dynamiclib $allow_undefined_flag -o $lib $l=
ibobjs $deplibs $compiler_flags -install_name $rpath/$soname $verstring'
-      module_cmds=3D'$CC $allow_undefined_flag -o $lib -bundle $libobjs =
$deplibs$compiler_flags'
-      # Don't fix this by using the ld -exported_symbols_list flag, it d=
oesn't exist in older darwin lds
-      archive_expsym_cmds=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "s,^\=
(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.expsym~=
$CC -dynamiclib $allow_undefined_flag -o $lib $libobjs $deplibs $compiler=
_flags -install_name $rpath/$soname $verstring~nmedit -s $output_objdir/$=
{libname}-symbols.expsym ${lib}'
-      module_expsym_cmds=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "s,^\(=
..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.expsym~$=
CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compiler_flag=
s~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
     else
-      case $cc_basename in
-        xlc*)
-         output_verbose_link_cmd=3D'echo'
-         archive_cmds=3D'$CC -qmkshrobj $allow_undefined_flag -o $lib $l=
ibobjs $deplibs $compiler_flags ${wl}-install_name ${wl}`echo $rpath/$son=
ame` $verstring'
-         module_cmds=3D'$CC $allow_undefined_flag -o $lib -bundle $libob=
js $deplibs$compiler_flags'
-          # Don't fix this by using the ld -exported_symbols_list flag, =
it doesn't exist in older darwin lds
-         archive_expsym_cmds=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "s=
,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exps=
ym~$CC -qmkshrobj $allow_undefined_flag -o $lib $libobjs $deplibs $compil=
er_flags ${wl}-install_name ${wl}$rpath/$soname $verstring~nmedit -s $out=
put_objdir/${libname}-symbols.expsym ${lib}'
-          module_expsym_cmds=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "s=
,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exps=
ym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compiler_=
flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
-          ;;
-       *)
-         ld_shlibs=3Dno
-          ;;
-      esac
+      ld_shlibs=3Dno
     fi
       ;;
=20
@@ -8506,22 +8267,13 @@
       ;;
=20
     # FreeBSD 3 and greater uses gcc -shared to do shared libraries.
-    freebsd* | dragonfly*)
+    freebsd* | kfreebsd*-gnu)
       archive_cmds=3D'$CC -shared -o $lib $libobjs $deplibs $compiler_fl=
ags'
       hardcode_libdir_flag_spec=3D'-R$libdir'
       hardcode_direct=3Dyes
       hardcode_shlibpath_var=3Dno
       ;;
=20
-    # GNU/kFreeBSD uses gcc -shared to do shared libraries.
-    kfreebsd*-gnu)
-      archive_cmds=3D'$CC -shared -o $lib $libobjs $deplibs $compiler_fl=
ags'
-      hardcode_libdir_flag_spec=3D'-R$libdir'
-      hardcode_direct=3Dyes
-      hardcode_shlibpath_var=3Dno
-      link_all_deplibs=3Dno
-      ;;
-
     hpux9*)
       if test "$GCC" =3D yes; then
 	archive_cmds=3D'$rm $output_objdir/$soname~$CC -shared -fPIC ${wl}+b ${=
wl}$install_libdir -o $output_objdir/$soname $libobjs $deplibs $compiler_=
flags~test $output_objdir/$soname =3D $lib || mv $output_objdir/$soname $=
lib'
@@ -8538,62 +8290,47 @@
       export_dynamic_flag_spec=3D'${wl}-E'
       ;;
=20
-    hpux10*)
+    hpux10* | hpux11*)
       if test "$GCC" =3D yes -a "$with_gnu_ld" =3D no; then
-	archive_cmds=3D'$CC -shared -fPIC ${wl}+h ${wl}$soname ${wl}+b ${wl}$in=
stall_libdir -o $lib $libobjs $deplibs $compiler_flags'
-      else
-	archive_cmds=3D'$LD -b +h $soname +b $install_libdir -o $lib $libobjs $=
deplibs $linker_flags'
-      fi
-      if test "$with_gnu_ld" =3D no; then
-	hardcode_libdir_flag_spec=3D'${wl}+b ${wl}$libdir'
-	hardcode_libdir_separator=3D:
-
-	hardcode_direct=3Dyes
-	export_dynamic_flag_spec=3D'${wl}-E'
-
-	# hardcode_minus_L: Not really in the search PATH,
-	# but as the default location of the library.
-	hardcode_minus_L=3Dyes
-      fi
-      ;;
-
-    hpux11*)
-      if test "$GCC" =3D yes -a "$with_gnu_ld" =3D no; then
-	case $host_cpu in
-	hppa*64*)
+	case "$host_cpu" in
+	hppa*64*|ia64*)
 	  archive_cmds=3D'$CC -shared ${wl}+h ${wl}$soname -o $lib $libobjs $de=
plibs $compiler_flags'
 	  ;;
-	ia64*)
-	  archive_cmds=3D'$CC -shared ${wl}+h ${wl}$soname ${wl}+nodefaultrpath=
 -o $lib $libobjs $deplibs $compiler_flags'
-	  ;;
 	*)
 	  archive_cmds=3D'$CC -shared -fPIC ${wl}+h ${wl}$soname ${wl}+b ${wl}$=
install_libdir -o $lib $libobjs $deplibs $compiler_flags'
 	  ;;
 	esac
       else
-	case $host_cpu in
-	hppa*64*)
-	  archive_cmds=3D'$CC -b ${wl}+h ${wl}$soname -o $lib $libobjs $deplibs=
 $compiler_flags'
+	case "$host_cpu" in
+	hppa*64*|ia64*)
+	  archive_cmds=3D'$LD -b +h $soname -o $lib $libobjs $deplibs $linker_f=
lags'
 	  ;;
-	ia64*)
-	  archive_cmds=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+nodefaultrpath -o $=
lib $libobjs $deplibs $compiler_flags'
-	  ;;
 	*)
-	  archive_cmds=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+b ${wl}$install_lib=
dir -o $lib $libobjs $deplibs $compiler_flags'
+	  archive_cmds=3D'$LD -b +h $soname +b $install_libdir -o $lib $libobjs=
 $deplibs $linker_flags'
 	  ;;
 	esac
       fi
       if test "$with_gnu_ld" =3D no; then
-	hardcode_libdir_flag_spec=3D'${wl}+b ${wl}$libdir'
-	hardcode_libdir_separator=3D:
-
-	case $host_cpu in
-	hppa*64*|ia64*)
+	case "$host_cpu" in
+	hppa*64*)
+	  hardcode_libdir_flag_spec=3D'${wl}+b ${wl}$libdir'
 	  hardcode_libdir_flag_spec_ld=3D'+b $libdir'
+	  hardcode_libdir_separator=3D:
 	  hardcode_direct=3Dno
 	  hardcode_shlibpath_var=3Dno
 	  ;;
+	ia64*)
+	  hardcode_libdir_flag_spec=3D'-L$libdir'
+	  hardcode_direct=3Dno
+	  hardcode_shlibpath_var=3Dno
+
+	  # hardcode_minus_L: Not really in the search PATH,
+	  # but as the default location of the library.
+	  hardcode_minus_L=3Dyes
+	  ;;
 	*)
+	  hardcode_libdir_flag_spec=3D'${wl}+b ${wl}$libdir'
+	  hardcode_libdir_separator=3D:
 	  hardcode_direct=3Dyes
 	  export_dynamic_flag_spec=3D'${wl}-E'
=20
@@ -8641,7 +8378,6 @@
       hardcode_shlibpath_var=3Dno
       if test -z "`echo __ELF__ | $CC -E - | grep __ELF__`" || test "$ho=
st_os-$host_cpu" =3D "openbsd2.8-powerpc"; then
 	archive_cmds=3D'$CC -shared $pic_flag -o $lib $libobjs $deplibs $compil=
er_flags'
-	archive_expsym_cmds=3D'$CC -shared $pic_flag -o $lib $libobjs $deplibs =
$compiler_flags ${wl}-retain-symbols-file,$export_symbols'
 	hardcode_libdir_flag_spec=3D'${wl}-rpath,$libdir'
 	export_dynamic_flag_spec=3D'${wl}-E'
       else
@@ -8687,7 +8423,7 @@
 	allow_undefined_flag=3D' -expect_unresolved \*'
 	archive_cmds=3D'$LD -shared${allow_undefined_flag} $libobjs $deplibs $l=
inker_flags -msym -soname $soname `test -n "$verstring" && echo -set_vers=
ion $verstring` -update_registry ${output_objdir}/so_locations -o $lib'
 	archive_expsym_cmds=3D'for i in `cat $export_symbols`; do printf "%s %s=
\\n" -exported_symbol "\$i" >> $lib.exp; done; echo "-hidden">> $lib.exp~
-	$LD -shared${allow_undefined_flag} -input $lib.exp $linker_flags $libob=
js $deplibs -soname $soname `test -n "$verstring" && echo -set_version $v=
erstring` -update_registry ${output_objdir}/so_locations -o $lib~$rm $lib=
.exp'
+	$LD -shared${allow_undefined_flag} -input $lib.exp $linker_flags $libob=
js $deplibs -soname $soname `test -n "$verstring" && echo -set_version $v=
erstring` -update_registry ${objdir}/so_locations -o $lib~$rm $lib.exp'
=20
 	# Both c and cxx compiler support -rpath directly
 	hardcode_libdir_flag_spec=3D'-rpath $libdir'
@@ -8695,15 +8431,21 @@
       hardcode_libdir_separator=3D:
       ;;
=20
+    sco3.2v5*)
+      archive_cmds=3D'$LD -G -h $soname -o $lib $libobjs $deplibs $linke=
r_flags'
+      hardcode_shlibpath_var=3Dno
+      export_dynamic_flag_spec=3D'${wl}-Bexport'
+      runpath_var=3DLD_RUN_PATH
+      hardcode_runpath_var=3Dyes
+      ;;
+
     solaris*)
       no_undefined_flag=3D' -z text'
       if test "$GCC" =3D yes; then
-	wlarc=3D'${wl}'
 	archive_cmds=3D'$CC -shared ${wl}-h ${wl}$soname -o $lib $libobjs $depl=
ibs $compiler_flags'
 	archive_expsym_cmds=3D'$echo "{ global:" > $lib.exp~cat $export_symbols=
 | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *; };" >> $lib.exp~
 	  $CC -shared ${wl}-M ${wl}$lib.exp ${wl}-h ${wl}$soname -o $lib $libob=
js $deplibs $compiler_flags~$rm $lib.exp'
       else
-	wlarc=3D''
 	archive_cmds=3D'$LD -G${allow_undefined_flag} -h $soname -o $lib $libob=
js $deplibs $linker_flags'
 	archive_expsym_cmds=3D'$echo "{ global:" > $lib.exp~cat $export_symbols=
 | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *; };" >> $lib.exp~
   	$LD -G${allow_undefined_flag} -M $lib.exp -h $soname -o $lib $libobjs=
 $deplibs $linker_flags~$rm $lib.exp'
@@ -8712,18 +8454,8 @@
       hardcode_shlibpath_var=3Dno
       case $host_os in
       solaris2.[0-5] | solaris2.[0-5].*) ;;
-      *)
- 	# The compiler driver will combine linker options so we
- 	# cannot just pass the convience library names through
- 	# without $wl, iff we do not link with $LD.
- 	# Luckily, gcc supports the same syntax we need for Sun Studio.
- 	# Supported since Solaris 2.6 (maybe 2.5.1?)
- 	case $wlarc in
- 	'')
- 	  whole_archive_flag_spec=3D'-z allextract$convenience -z defaultextra=
ct' ;;
- 	*)
- 	  whole_archive_flag_spec=3D'${wl}-z ${wl}allextract`for conv in $conv=
enience\"\"; do test -n \"$conv\" && new_convenience=3D\"$new_convenience=
,$conv\"; done; $echo \"$new_convenience\"` ${wl}-z ${wl}defaultextract' =
;;
- 	esac ;;
+      *) # Supported since Solaris 2.6 (maybe 2.5.1?)
+	whole_archive_flag_spec=3D'-z allextract$convenience -z defaultextract'=
 ;;
       esac
       link_all_deplibs=3Dyes
       ;;
@@ -8780,45 +8512,36 @@
       fi
       ;;
=20
-    sysv4*uw2* | sysv5OpenUNIX* | sysv5UnixWare7.[01].[10]* | unixware7*=
)
-      no_undefined_flag=3D'${wl}-z,text'
-      archive_cmds_need_lc=3Dno
+    sysv4.2uw2*)
+      archive_cmds=3D'$LD -G -o $lib $libobjs $deplibs $linker_flags'
+      hardcode_direct=3Dyes
+      hardcode_minus_L=3Dno
       hardcode_shlibpath_var=3Dno
-      runpath_var=3D'LD_RUN_PATH'
+      hardcode_runpath_var=3Dyes
+      runpath_var=3DLD_RUN_PATH
+      ;;
=20
+   sysv5OpenUNIX8* | sysv5UnixWare7* |  sysv5uw[78]* | unixware7*)
+      no_undefined_flag=3D'${wl}-z ${wl}text'
       if test "$GCC" =3D yes; then
-	archive_cmds=3D'$CC -shared ${wl}-h,$soname -o $lib $libobjs $deplibs $=
compiler_flags'
-	archive_expsym_cmds=3D'$CC -shared ${wl}-Bexport:$export_symbols ${wl}-=
h,$soname -o $lib $libobjs $deplibs $compiler_flags'
+	archive_cmds=3D'$CC -shared ${wl}-h ${wl}$soname -o $lib $libobjs $depl=
ibs $compiler_flags'
       else
-	archive_cmds=3D'$CC -G ${wl}-h,$soname -o $lib $libobjs $deplibs $compi=
ler_flags'
-	archive_expsym_cmds=3D'$CC -G ${wl}-Bexport:$export_symbols ${wl}-h,$so=
name -o $lib $libobjs $deplibs $compiler_flags'
+	archive_cmds=3D'$CC -G ${wl}-h ${wl}$soname -o $lib $libobjs $deplibs $=
compiler_flags'
       fi
+      runpath_var=3D'LD_RUN_PATH'
+      hardcode_shlibpath_var=3Dno
       ;;
=20
-    sysv5* | sco3.2v5* | sco5v6*)
-      # Note: We can NOT use -z defs as we might desire, because we do n=
ot
-      # link with -lc, and that would cause any symbols used from libc t=
o
-      # always be unresolved, which means just about no library would
-      # ever link correctly.  If we're not using GNU ld we use -z text
-      # though, which does catch some bad symbols but isn't as heavy-han=
ded
-      # as -z defs.
-      no_undefined_flag=3D'${wl}-z,text'
-      allow_undefined_flag=3D'${wl}-z,nodefs'
-      archive_cmds_need_lc=3Dno
+    sysv5*)
+      no_undefined_flag=3D' -z text'
+      # $CC -shared without GNU ld will not create a library from C++
+      # object files and a static libstdc++, better avoid it by now
+      archive_cmds=3D'$LD -G${allow_undefined_flag} -h $soname -o $lib $=
libobjs $deplibs $linker_flags'
+      archive_expsym_cmds=3D'$echo "{ global:" > $lib.exp~cat $export_sy=
mbols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *; };" >> $lib.=
exp~
+  		$LD -G${allow_undefined_flag} -M $lib.exp -h $soname -o $lib $libobj=
s $deplibs $linker_flags~$rm $lib.exp'
+      hardcode_libdir_flag_spec=3D
       hardcode_shlibpath_var=3Dno
-      hardcode_libdir_flag_spec=3D'`test -z "$SCOABSPATH" && echo ${wl}-=
R,$libdir`'
-      hardcode_libdir_separator=3D':'
-      link_all_deplibs=3Dyes
-      export_dynamic_flag_spec=3D'${wl}-Bexport'
       runpath_var=3D'LD_RUN_PATH'
-
-      if test "$GCC" =3D yes; then
-	archive_cmds=3D'$CC -shared ${wl}-h,\${SCOABSPATH:+${install_libdir}/}$=
soname -o $lib $libobjs $deplibs $compiler_flags'
-	archive_expsym_cmds=3D'$CC -shared ${wl}-Bexport:$export_symbols ${wl}-=
h,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $libobjs $deplibs $co=
mpiler_flags'
-      else
-	archive_cmds=3D'$CC -G ${wl}-h,\${SCOABSPATH:+${install_libdir}/}$sonam=
e -o $lib $libobjs $deplibs $compiler_flags'
-	archive_expsym_cmds=3D'$CC -G ${wl}-Bexport:$export_symbols ${wl}-h,\${=
SCOABSPATH:+${install_libdir}/}$soname -o $lib $libobjs $deplibs $compile=
r_flags'
-      fi
       ;;
=20
     uts4*)
@@ -8837,6 +8560,11 @@
 echo "${ECHO_T}$ld_shlibs" >&6
 test "$ld_shlibs" =3D no && can_build_shared=3Dno
=20
+variables_saved_for_relink=3D"PATH $shlibpath_var $runpath_var"
+if test "$GCC" =3D yes; then
+  variables_saved_for_relink=3D"$variables_saved_for_relink GCC_EXEC_PRE=
FIX COMPILER_PATH LIBRARY_PATH"
+fi
+
 #
 # Do we need to explicitly link libc?
 #
@@ -8869,7 +8597,6 @@
         libobjs=3Dconftest.$ac_objext
         deplibs=3D
         wl=3D$lt_prog_compiler_wl
-	pic_flag=3D$lt_prog_compiler_pic
         compiler_flags=3D-v
         linker_flags=3D-v
         verstring=3D
@@ -9002,7 +8729,7 @@
   shlibpath_var=3DLIBRARY_PATH
   ;;
=20
-bsdi[45]*)
+bsdi4*)
   version_type=3Dlinux
   need_version=3Dno
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
@@ -9030,8 +8757,7 @@
       dlpath=3D`$SHELL 2>&1 -c '\''. $dir/'\''\${base_file}'\''i;echo \$=
dlname'\''`~
       dldir=3D$destdir/`dirname \$dlpath`~
       test -d \$dldir || mkdir -p \$dldir~
-      $install_prog $dir/$dlname \$dldir/$dlname~
-      chmod a+x \$dldir/$dlname'
+      $install_prog $dir/$dlname \$dldir/$dlname'
     postuninstall_cmds=3D'dldll=3D`$SHELL 2>&1 -c '\''. $file; echo \$dl=
name'\''`~
       dlpath=3D$dir/\$dldll~
        $rm \$dlpath'
@@ -9061,7 +8787,7 @@
       ;;
     pw32*)
       # pw32 DLLs use 'pw' prefix rather than 'lib'
-      library_names_spec=3D'`echo ${libname} | sed -e 's/^lib/pw/'``echo=
 ${release} | $SED -e 's/[.]/-/g'`${versuffix}${shared_ext}'
+      library_names_spec=3D'`echo ${libname} | sed -e 's/^lib/pw/'``echo=
 ${release} | $SED -e 's/./-/g'`${versuffix}${shared_ext}'
       ;;
     esac
     ;;
@@ -9084,7 +8810,7 @@
   soname_spec=3D'${libname}${release}${major}$shared_ext'
   shlibpath_overrides_runpath=3Dyes
   shlibpath_var=3DDYLD_LIBRARY_PATH
-  shrext_cmds=3D'`test .$module =3D .yes && echo .so || echo .dylib`'
+  shrext_cmds=3D'$(test .$module =3D .yes && echo .so || echo .dylib)'
   # Apple's gcc prints 'gcc -print-search-dirs' doesn't operate the same=
=2E
   if test "$GCC" =3D yes; then
     sys_lib_search_path_spec=3D`$CC -print-search-dirs | tr "\n" "$PATH_=
SEPARATOR" | sed -e 's/libraries:/@libraries:/' | tr "@" "\n" | grep "^li=
braries:" | sed -e "s/^libraries://" -e "s,=3D/,/,g" -e "s,$PATH_SEPARATO=
R, ,g" -e "s,.*,& /lib /usr/lib /usr/local/lib,g"`
@@ -9119,17 +8845,8 @@
   dynamic_linker=3D'GNU ld.so'
   ;;
=20
-freebsd* | dragonfly*)
-  # DragonFly does not have aout.  When/if they implement a new
-  # versioning mechanism, adjust this.
-  if test -x /usr/bin/objformat; then
-    objformat=3D`/usr/bin/objformat`
-  else
-    case $host_os in
-    freebsd[123]*) objformat=3Daout ;;
-    *) objformat=3Delf ;;
-    esac
-  fi
+freebsd*)
+  objformat=3D`test -x /usr/bin/objformat && /usr/bin/objformat || echo =
aout`
   version_type=3Dfreebsd-$objformat
   case $version_type in
     freebsd-elf*)
@@ -9147,19 +8864,14 @@
   freebsd2*)
     shlibpath_overrides_runpath=3Dyes
     ;;
-  freebsd3.[01]* | freebsdelf3.[01]*)
+  freebsd3.01* | freebsdelf3.01*)
     shlibpath_overrides_runpath=3Dyes
     hardcode_into_libs=3Dyes
     ;;
-  freebsd3.[2-9]* | freebsdelf3.[2-9]* | \
-  freebsd4.[0-5] | freebsdelf4.[0-5] | freebsd4.1.1 | freebsdelf4.1.1)
+  *) # from 3.2 on
     shlibpath_overrides_runpath=3Dno
     hardcode_into_libs=3Dyes
     ;;
-  freebsd*) # from 4.6 on
-    shlibpath_overrides_runpath=3Dyes
-    hardcode_into_libs=3Dyes
-    ;;
   esac
   ;;
=20
@@ -9179,7 +8891,7 @@
   version_type=3Dsunos
   need_lib_prefix=3Dno
   need_version=3Dno
-  case $host_cpu in
+  case "$host_cpu" in
   ia64*)
     shrext_cmds=3D'.so'
     hardcode_into_libs=3Dyes
@@ -9219,18 +8931,6 @@
   postinstall_cmds=3D'chmod 555 $lib'
   ;;
=20
-interix3*)
-  version_type=3Dlinux
-  need_lib_prefix=3Dno
-  need_version=3Dno
-  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major ${libname}${shared_ext}'
-  soname_spec=3D'${libname}${release}${shared_ext}$major'
-  dynamic_linker=3D'Interix 3.x ld.so.1 (PE, like ELF)'
-  shlibpath_var=3DLD_LIBRARY_PATH
-  shlibpath_overrides_runpath=3Dno
-  hardcode_into_libs=3Dyes
-  ;;
-
 irix5* | irix6* | nonstopux*)
   case $host_os in
     nonstopux*) version_type=3Dnonstopux ;;
@@ -9290,7 +8990,7 @@
=20
   # Append ld.so.conf contents to the search path
   if test -f /etc/ld.so.conf; then
-    lt_ld_extra=3D`awk '/^include / { system(sprintf("cd /etc; cat %s", =
\$2)); skip =3D 1; } { if (!skip) print \$0; skip =3D 0; }' < /etc/ld.so.=
conf | $SED -e 's/#.*//;s/[:,	]/ /g;s/=3D[^=3D]*$//;s/=3D[^=3D ]* / /g;/^=
$/d' | tr '\n' ' '`
+    lt_ld_extra=3D`$SED -e 's/:,\t/ /g;s/=3D^=3D*$//;s/=3D^=3D * / /g' /=
etc/ld.so.conf | tr '\n' ' '`
     sys_lib_dlsearch_path_spec=3D"/lib /usr/lib $lt_ld_extra"
   fi
=20
@@ -9364,13 +9064,8 @@
=20
 openbsd*)
   version_type=3Dsunos
-  sys_lib_dlsearch_path_spec=3D"/usr/lib"
   need_lib_prefix=3Dno
-  # Some older versions of OpenBSD (3.3 at least) *do* need versioned li=
bs.
-  case $host_os in
-    openbsd3.3 | openbsd3.3.*) need_version=3Dyes ;;
-    *)                         need_version=3Dno  ;;
-  esac
+  need_version=3Dyes
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${shared_ext}$versuffix'
   finish_cmds=3D'PATH=3D"\$PATH:/sbin" ldconfig -m $libdir'
   shlibpath_var=3DLD_LIBRARY_PATH
@@ -9408,6 +9103,13 @@
   sys_lib_dlsearch_path_spec=3D"$sys_lib_search_path_spec"
   ;;
=20
+sco3.2v5*)
+  version_type=3Dosf
+  soname_spec=3D'${libname}${release}${shared_ext}$major'
+  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
+  shlibpath_var=3DLD_LIBRARY_PATH
+  ;;
+
 solaris*)
   version_type=3Dlinux
   need_lib_prefix=3Dno
@@ -9433,7 +9135,7 @@
   need_version=3Dyes
   ;;
=20
-sysv4 | sysv4.3*)
+sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
   version_type=3Dlinux
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
   soname_spec=3D'${libname}${release}${shared_ext}$major'
@@ -9466,29 +9168,6 @@
   fi
   ;;
=20
-sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX* | sysv4*uw2*)
-  version_type=3Dfreebsd-elf
-  need_lib_prefix=3Dno
-  need_version=3Dno
-  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext} $libname${shared_ext}'
-  soname_spec=3D'${libname}${release}${shared_ext}$major'
-  shlibpath_var=3DLD_LIBRARY_PATH
-  hardcode_into_libs=3Dyes
-  if test "$with_gnu_ld" =3D yes; then
-    sys_lib_search_path_spec=3D'/usr/local/lib /usr/gnu/lib /usr/ccs/lib=
 /usr/lib /lib'
-    shlibpath_overrides_runpath=3Dno
-  else
-    sys_lib_search_path_spec=3D'/usr/ccs/lib /usr/lib'
-    shlibpath_overrides_runpath=3Dyes
-    case $host_os in
-      sco3.2v5*)
-        sys_lib_search_path_spec=3D"$sys_lib_search_path_spec /lib"
-	;;
-    esac
-  fi
-  sys_lib_dlsearch_path_spec=3D'/usr/lib'
-  ;;
-
 uts4*)
   version_type=3Dlinux
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
@@ -9504,17 +9183,12 @@
 echo "${ECHO_T}$dynamic_linker" >&6
 test "$dynamic_linker" =3D no && can_build_shared=3Dno
=20
-variables_saved_for_relink=3D"PATH $shlibpath_var $runpath_var"
-if test "$GCC" =3D yes; then
-  variables_saved_for_relink=3D"$variables_saved_for_relink GCC_EXEC_PRE=
FIX COMPILER_PATH LIBRARY_PATH"
-fi
-
 echo "$as_me:$LINENO: checking how to hardcode library paths into progra=
ms" >&5
 echo $ECHO_N "checking how to hardcode library paths into programs... $E=
CHO_C" >&6
 hardcode_action=3D
 if test -n "$hardcode_libdir_flag_spec" || \
-   test -n "$runpath_var" || \
-   test "X$hardcode_automatic" =3D "Xyes" ; then
+   test -n "$runpath_var " || \
+   test "X$hardcode_automatic"=3D"Xyes" ; then
=20
   # We can hardcode non-existant directories.
   if test "$hardcode_direct" !=3D no &&
@@ -10157,7 +9831,7 @@
     test "x$ac_cv_header_dlfcn_h" =3D xyes && CPPFLAGS=3D"$CPPFLAGS -DHA=
VE_DLFCN_H"
=20
     save_LDFLAGS=3D"$LDFLAGS"
-    wl=3D$lt_prog_compiler_wl eval LDFLAGS=3D\"\$LDFLAGS $export_dynamic=
_flag_spec\"
+    eval LDFLAGS=3D\"\$LDFLAGS $export_dynamic_flag_spec\"
=20
     save_LIBS=3D"$LIBS"
     LIBS=3D"$lt_cv_dlopen_libs $LIBS"
@@ -10173,7 +9847,7 @@
   lt_dlunknown=3D0; lt_dlno_uscore=3D1; lt_dlneed_uscore=3D2
   lt_status=3D$lt_dlunknown
   cat > conftest.$ac_ext <<EOF
-#line 10176 "configure"
+#line 9850 "configure"
 #include "confdefs.h"
=20
 #if HAVE_DLFCN_H
@@ -10230,8 +9904,6 @@
       else if (dlsym( self,"_fnord")) status =3D $lt_dlneed_uscore;
       /* dlclose (self); */
     }
-  else
-    puts (dlerror ());
=20
     exit (status);
 }
@@ -10241,12 +9913,12 @@
   ac_status=3D$?
   echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
   (exit $ac_status); } && test -s conftest${ac_exeext} 2>/dev/null; then
-    (./conftest; exit; ) >&5 2>/dev/null
+    (./conftest; exit; ) 2>/dev/null
     lt_status=3D$?
     case x$lt_status in
       x$lt_dlno_uscore) lt_cv_dlopen_self=3Dyes ;;
       x$lt_dlneed_uscore) lt_cv_dlopen_self=3Dyes ;;
-      x$lt_dlunknown|x*) lt_cv_dlopen_self=3Dno ;;
+      x$lt_unknown|x*) lt_cv_dlopen_self=3Dno ;;
     esac
   else :
     # compilation failed
@@ -10261,7 +9933,7 @@
 echo "${ECHO_T}$lt_cv_dlopen_self" >&6
=20
     if test "x$lt_cv_dlopen_self" =3D xyes; then
-      wl=3D$lt_prog_compiler_wl eval LDFLAGS=3D\"\$LDFLAGS $lt_prog_comp=
iler_static\"
+      LDFLAGS=3D"$LDFLAGS $link_static_flag"
       echo "$as_me:$LINENO: checking whether a statically linked program=
 can dlopen itself" >&5
 echo $ECHO_N "checking whether a statically linked program can dlopen it=
self... $ECHO_C" >&6
 if test "${lt_cv_dlopen_self_static+set}" =3D set; then
@@ -10273,7 +9945,7 @@
   lt_dlunknown=3D0; lt_dlno_uscore=3D1; lt_dlneed_uscore=3D2
   lt_status=3D$lt_dlunknown
   cat > conftest.$ac_ext <<EOF
-#line 10276 "configure"
+#line 9948 "configure"
 #include "confdefs.h"
=20
 #if HAVE_DLFCN_H
@@ -10330,8 +10002,6 @@
       else if (dlsym( self,"_fnord")) status =3D $lt_dlneed_uscore;
       /* dlclose (self); */
     }
-  else
-    puts (dlerror ());
=20
     exit (status);
 }
@@ -10341,12 +10011,12 @@
   ac_status=3D$?
   echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
   (exit $ac_status); } && test -s conftest${ac_exeext} 2>/dev/null; then
-    (./conftest; exit; ) >&5 2>/dev/null
+    (./conftest; exit; ) 2>/dev/null
     lt_status=3D$?
     case x$lt_status in
       x$lt_dlno_uscore) lt_cv_dlopen_self_static=3Dyes ;;
       x$lt_dlneed_uscore) lt_cv_dlopen_self_static=3Dyes ;;
-      x$lt_dlunknown|x*) lt_cv_dlopen_self_static=3Dno ;;
+      x$lt_unknown|x*) lt_cv_dlopen_self_static=3Dno ;;
     esac
   else :
     # compilation failed
@@ -10379,7 +10049,7 @@
 fi
=20
=20
-# Report which library types will actually be built
+# Report which librarie types wil actually be built
 echo "$as_me:$LINENO: checking if libtool supports shared libraries" >&5
 echo $ECHO_N "checking if libtool supports shared libraries... $ECHO_C" =
>&6
 echo "$as_me:$LINENO: result: $can_build_shared" >&5
@@ -10391,7 +10061,7 @@
=20
 # On AIX, shared libraries and static libraries use the same namespace, =
and
 # are all built from PIC.
-case $host_os in
+case "$host_os" in
 aix3*)
   test "$enable_shared" =3D yes && enable_static=3Dno
   if test -n "$RANLIB"; then
@@ -10404,6 +10074,43 @@
   if test "$host_cpu" !=3D ia64 && test "$aix_use_runtimelinking" =3D no=
 ; then
     test "$enable_shared" =3D yes && enable_static=3Dno
   fi
+  ;;
+  darwin* | rhapsody*)
+  if test "$GCC" =3D yes; then
+    archive_cmds_need_lc=3Dno
+    case "$host_os" in
+    rhapsody* | darwin1.[012])
+      allow_undefined_flag=3D'-undefined suppress'
+      ;;
+    *) # Darwin 1.3 on
+      if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
+      	allow_undefined_flag=3D'-flat_namespace -undefined suppress'
+      else
+        case ${MACOSX_DEPLOYMENT_TARGET} in
+          10.[012])
+            allow_undefined_flag=3D'-flat_namespace -undefined suppress'
+            ;;
+          10.*)
+            allow_undefined_flag=3D'-undefined dynamic_lookup'
+            ;;
+        esac
+      fi
+      ;;
+    esac
+    output_verbose_link_cmd=3D'echo'
+    archive_cmds=3D'$CC -dynamiclib $allow_undefined_flag -o $lib $libob=
js $deplibs$compiler_flags -install_name $rpath/$soname $verstring'
+    module_cmds=3D'$CC $allow_undefined_flag -o $lib -bundle $libobjs $d=
eplibs$compiler_flags'
+    # Don't fix this by using the ld -exported_symbols_list flag, it doe=
sn't exist in older darwin ld's
+    archive_expsym_cmds=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "s,^\(.=
.*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.expsym~$C=
C -dynamiclib $allow_undefined_flag  -o $lib $libobjs $deplibs$compiler_f=
lags -install_name $rpath/$soname $verstring~nmedit -s $output_objdir/${l=
ibname}-symbols.expsym ${lib}'
+    module_expsym_cmds=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "s,^\(..=
*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.expsym~$CC=
 $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compiler_flags~=
nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+    hardcode_direct=3Dno
+    hardcode_automatic=3Dyes
+    hardcode_shlibpath_var=3Dunsupported
+    whole_archive_flag_spec=3D'-all_load $convenience'
+    link_all_deplibs=3Dyes
+  else
+    ld_shlibs=3Dno
+  fi
     ;;
 esac
 echo "$as_me:$LINENO: result: $enable_shared" >&5
@@ -10429,7 +10136,7 @@
   # Now quote all the things that may contain metacharacters while being
   # careful not to overquote the AC_SUBSTed values.  We take copies of t=
he
   # variables and quote the copies for generation of the libtool script.
-  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC L=
TCFLAGS NM \
+  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC N=
M \
     SED SHELL STRIP \
     libname_spec library_names_spec soname_spec extract_expsyms_cmds \
     old_striplib striplib file_magic_cmd finish_cmds finish_eval \
@@ -10533,7 +10240,7 @@
 #
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-13=
01, USA.
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, =
USA.
 #
 # As a special exception to the GNU General Public License, if you
 # distribute this file as part of a program that contains a
@@ -10544,11 +10251,11 @@
 SED=3D$lt_SED
=20
 # Sed that helps us avoid accidentally triggering echo(1) options like -=
n.
-Xsed=3D"$SED -e 1s/^X//"
+Xsed=3D"$SED -e s/^X//"
=20
 # The HP-UX ksh and POSIX shell print the target directory to stdout
 # if CDPATH is set.
-(unset CDPATH) >/dev/null 2>&1 && unset CDPATH
+if test "X\${CDPATH+set}" =3D Xset; then CDPATH=3D:; export CDPATH; fi
=20
 # The names of the tagged configurations supported by this script.
 available_tags=3D
@@ -10578,13 +10285,7 @@
 # The host system.
 host_alias=3D$host_alias
 host=3D$host
-host_os=3D$host_os
=20
-# The build system.
-build_alias=3D$build_alias
-build=3D$build
-build_os=3D$build_os
-
 # An echo program that does not interpret backslashes.
 echo=3D$lt_echo
=20
@@ -10595,9 +10296,6 @@
 # A C compiler.
 LTCC=3D$lt_LTCC
=20
-# LTCC compiler flags.
-LTCFLAGS=3D$lt_LTCFLAGS
-
 # A language-specific compiler.
 CC=3D$lt_compiler
=20
@@ -10663,7 +10361,7 @@
 # Does compiler simultaneously support -c and -o options?
 compiler_c_o=3D$lt_lt_cv_prog_compiler_c_o
=20
-# Must we lock files when doing compilation?
+# Must we lock files when doing compilation ?
 need_locks=3D$lt_need_locks
=20
 # Do we need the lib prefix for modules?
@@ -10928,9 +10626,6 @@
 echo "$as_me: WARNING: using \`LTCC=3D$LTCC', extracted from \`$ofile'" =
>&2;}
     fi
   fi
-  if test -z "$LTCFLAGS"; then
-    eval "`$SHELL ${ofile} --config | grep '^LTCFLAGS=3D'`"
-  fi
=20
   # Extract list of available tagged configurations in $ofile.
   # Note that this assumes the entire list is on one line.
@@ -10961,9 +10656,7 @@
=20
       case $tagname in
       CXX)
-	if test -n "$CXX" && ( test "X$CXX" !=3D "Xno" &&
-	    ( (test "X$CXX" =3D "Xg++" && `g++ -v >/dev/null 2>&1` ) ||
-	    (test "X$CXX" !=3D "Xg++"))) ; then
+	if test -n "$CXX" && test "X$CXX" !=3D "Xno"; then
 	  ac_ext=3Dcc
 ac_cpp=3D'$CXXCPP $CPPFLAGS'
 ac_compile=3D'$CXX -c $CXXFLAGS $CPPFLAGS conftest.$ac_ext >&5'
@@ -10983,7 +10676,6 @@
 hardcode_libdir_flag_spec_ld_CXX=3D
 hardcode_libdir_separator_CXX=3D
 hardcode_minus_L_CXX=3Dno
-hardcode_shlibpath_var_CXX=3Dunsupported
 hardcode_automatic_CXX=3Dno
 module_cmds_CXX=3D
 module_expsym_cmds_CXX=3D
@@ -11001,7 +10693,7 @@
 compiler_lib_search_path_CXX=3D
=20
 # Source file extension for C++ test sources.
-ac_ext=3Dcpp
+ac_ext=3Dcc
=20
 # Object file extension for compiled C++ test sources.
 objext=3Do
@@ -11011,34 +10703,17 @@
 lt_simple_compile_test_code=3D"int some_variable =3D 0;\n"
=20
 # Code to be used in simple link tests
-lt_simple_link_test_code=3D'int main(int, char *[]) { return(0); }\n'
+lt_simple_link_test_code=3D'int main(int, char *) { return(0); }\n'
=20
 # ltmain only uses $CC for tagged configurations so make sure $CC is set=
=2E
=20
 # If no C compiler was specified, use CC.
 LTCC=3D${LTCC-"$CC"}
=20
-# If no C compiler flags were specified, use CFLAGS.
-LTCFLAGS=3D${LTCFLAGS-"$CFLAGS"}
-
 # Allow CC to be a program name with arguments.
 compiler=3D$CC
=20
=20
-# save warnings/boilerplate of simple test code
-ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_compile_test_code" >conftest.$ac_ext
-eval "$ac_compile" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_compiler_boilerplate=3D`cat conftest.err`
-$rm conftest*
-
-ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_link_test_code" >conftest.$ac_ext
-eval "$ac_link" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_linker_boilerplate=3D`cat conftest.err`
-$rm conftest*
-
-
 # Allow CC to be a program name with arguments.
 lt_save_CC=3D$CC
 lt_save_LD=3D$LD
@@ -11049,28 +10724,19 @@
 if test -n "${lt_cv_prog_gnu_ldcxx+set}"; then
   lt_cv_prog_gnu_ld=3D$lt_cv_prog_gnu_ldcxx
 else
-  $as_unset lt_cv_prog_gnu_ld
+  unset lt_cv_prog_gnu_ld
 fi
 if test -n "${lt_cv_path_LDCXX+set}"; then
   lt_cv_path_LD=3D$lt_cv_path_LDCXX
 else
-  $as_unset lt_cv_path_LD
+  unset lt_cv_path_LD
 fi
 test -z "${LDCXX+set}" || LD=3D$LDCXX
 CC=3D${CXX-"c++"}
 compiler=3D$CC
 compiler_CXX=3D$CC
-for cc_temp in $compiler""; do
-  case $cc_temp in
-    compile | *[\\/]compile | ccache | *[\\/]ccache ) ;;
-    distcc | *[\\/]distcc | purify | *[\\/]purify ) ;;
-    \-*) ;;
-    *) break;;
-  esac
-done
-cc_basename=3D`$echo "X$cc_temp" | $Xsed -e 's%.*/%%' -e "s%^$host_alias=
-%%"`
+cc_basename=3D`$echo X"$compiler" | $Xsed -e 's%^.*/%%'`
=20
-
 # We don't want -fno-exception wen compiling C++ code, so set the
 # no_builtin_flag separately
 if test "$GXX" =3D yes; then
@@ -11140,7 +10806,7 @@
     if test -f "$ac_dir/$ac_prog" || test -f "$ac_dir/$ac_prog$ac_exeext=
"; then
       lt_cv_path_LD=3D"$ac_dir/$ac_prog"
       # Check to see if the program is GNU ld.  I'd rather use --version=
,
-      # but apparently some variants of GNU ld only accept -v.
+      # but apparently some GNU ld's only accept -v.
       # Break only if it was the GNU/non-GNU ld that we prefer.
       case `"$lt_cv_path_LD" -v 2>&1 </dev/null` in
       *GNU* | *'with BFD'*)
@@ -11174,7 +10840,7 @@
 if test "${lt_cv_prog_gnu_ld+set}" =3D set; then
   echo $ECHO_N "(cached) $ECHO_C" >&6
 else
-  # I'd rather use --version here, but apparently some GNU lds only acce=
pt -v.
+  # I'd rather use --version here, but apparently some GNU ld's only acc=
ept -v.
 case `$LD -v 2>&1 </dev/null` in
 *GNU* | *'with BFD'*)
   lt_cv_prog_gnu_ld=3Dyes
@@ -11265,7 +10931,6 @@
 	    ;;
 	  esac
 	done
-	;;
       esac
=20
       exp_sym_flag=3D'-bexport'
@@ -11284,7 +10949,7 @@
     link_all_deplibs_CXX=3Dyes
=20
     if test "$GXX" =3D yes; then
-      case $host_os in aix4.[012]|aix4.[012].*)
+      case $host_os in aix4.012|aix4.012.*)
       # We only want to do this on AIX 4.2 and lower, the check
       # below for broken collect2 doesn't work under 4.3+
 	collect2name=3D`${CC} -print-prog-name=3Dcollect2`
@@ -11303,12 +10968,8 @@
 	  hardcode_libdir_flag_spec_CXX=3D'-L$libdir'
 	  hardcode_libdir_separator_CXX=3D
 	fi
-	;;
       esac
       shared_flag=3D'-shared'
-      if test "$aix_use_runtimelinking" =3D yes; then
-	shared_flag=3D"$shared_flag "'${wl}-G'
-      fi
     else
       # not using gcc
       if test "$host_cpu" =3D ia64; then
@@ -11385,12 +11046,12 @@
=20
       hardcode_libdir_flag_spec_CXX=3D'${wl}-blibpath:$libdir:'"$aix_lib=
path"
=20
-      archive_expsym_cmds_CXX=3D"\$CC"' -o $output_objdir/$soname $libob=
js $deplibs '"\${wl}$no_entry_flag"' $compiler_flags `if test "x${allow_u=
ndefined_flag}" !=3D "x"; then echo "${wl}${allow_undefined_flag}"; else =
:; fi` '"\${wl}$exp_sym_flag:\$export_symbols $shared_flag"
+      archive_expsym_cmds_CXX=3D"\$CC"' -o $output_objdir/$soname $libob=
js $deplibs $compiler_flags `if test "x${allow_undefined_flag}" !=3D "x";=
 then echo "${wl}${allow_undefined_flag}"; else :; fi` '"\${wl}$no_entry_=
flag \${wl}$exp_sym_flag:\$export_symbols $shared_flag"
      else
       if test "$host_cpu" =3D ia64; then
 	hardcode_libdir_flag_spec_CXX=3D'${wl}-R $libdir:/usr/lib:/lib'
 	allow_undefined_flag_CXX=3D"-z nodefs"
-	archive_expsym_cmds_CXX=3D"\$CC $shared_flag"' -o $output_objdir/$sonam=
e $libobjs $deplibs '"\${wl}$no_entry_flag"' $compiler_flags ${wl}${allow=
_undefined_flag} '"\${wl}$exp_sym_flag:\$export_symbols"
+	archive_expsym_cmds_CXX=3D"\$CC $shared_flag"' -o $output_objdir/$sonam=
e $libobjs $deplibs $compiler_flags ${wl}${allow_undefined_flag} '"\${wl}=
$no_entry_flag \${wl}$exp_sym_flag:\$export_symbols"
       else
 	# Determine the default libpath from the value encoded in an empty exec=
utable.
 	cat >conftest.$ac_ext <<_ACEOF
@@ -11449,26 +11110,16 @@
 	# -berok will link without error, but may produce a broken library.
 	no_undefined_flag_CXX=3D' ${wl}-bernotok'
 	allow_undefined_flag_CXX=3D' ${wl}-berok'
+	# -bexpall does not export symbols beginning with underscore (_)
+	always_export_symbols_CXX=3Dyes
 	# Exported symbols can be pulled into shared objects from archives
-	whole_archive_flag_spec_CXX=3D'$convenience'
+	whole_archive_flag_spec_CXX=3D' '
 	archive_cmds_need_lc_CXX=3Dyes
-	# This is similar to how AIX traditionally builds its shared libraries.
-	archive_expsym_cmds_CXX=3D"\$CC $shared_flag"' -o $output_objdir/$sonam=
e $libobjs $deplibs ${wl}-bnoentry $compiler_flags ${wl}-bE:$export_symbo=
ls${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$libname$release.a=
 $output_objdir/$soname'
+	# This is similar to how AIX traditionally builds it's shared libraries=
=2E
+	archive_expsym_cmds_CXX=3D"\$CC $shared_flag"' -o $output_objdir/$sonam=
e $libobjs $deplibs $compiler_flags ${wl}-bE:$export_symbols ${wl}-bnoent=
ry${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$libname$release.a=
 $output_objdir/$soname'
       fi
     fi
     ;;
-
-  beos*)
-    if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null; =
then
-      allow_undefined_flag_CXX=3Dunsupported
-      # Joseph Beckenbach <jrb3@domain.hid> says some releases of gcc
-      # support --undefined.  This deserves some investigation.  FIXME
-      archive_cmds_CXX=3D'$CC -nostart $libobjs $deplibs $compiler_flags=
 ${wl}-soname $wl$soname -o $lib'
-    else
-      ld_shlibs_CXX=3Dno
-    fi
-    ;;
-
   chorus*)
     case $cc_basename in
       *)
@@ -11487,7 +11138,7 @@
     enable_shared_with_static_runtimes_CXX=3Dyes
=20
     if $LD --help 2>&1 | grep 'auto-import' > /dev/null; then
-      archive_cmds_CXX=3D'$CC -shared -nostdlib $predep_objects $libobjs=
 $deplibs $postdep_objects $compiler_flags -o $output_objdir/$soname ${wl=
}--enable-auto-image-base -Xlinker --out-implib -Xlinker $lib'
+      archive_cmds_CXX=3D'$CC -shared -nostdlib $predep_objects $libobjs=
 $deplibs $postdep_objects $compiler_flags -o $output_objdir/$soname ${wl=
}--image-base=3D0x10000000 ${wl}--out-implib,$lib'
       # If the export-symbols file already is a .def file (1st line
       # is EXPORTS), use it as is; otherwise, prepend...
       archive_expsym_cmds_CXX=3D'if test "x`$SED 1q $export_symbols`" =3D=
 xEXPORTS; then
@@ -11496,81 +11147,70 @@
 	echo EXPORTS > $output_objdir/$soname.def;
 	cat $export_symbols >> $output_objdir/$soname.def;
       fi~
-      $CC -shared -nostdlib $output_objdir/$soname.def $predep_objects $=
libobjs $deplibs $postdep_objects $compiler_flags -o $output_objdir/$sona=
me ${wl}--enable-auto-image-base -Xlinker --out-implib -Xlinker $lib'
+      $CC -shared -nostdlib $output_objdir/$soname.def $predep_objects $=
libobjs $deplibs $postdep_objects $compiler_flags -o $output_objdir/$sona=
me ${wl}--image-base=3D0x10000000 ${wl}--out-implib,$lib'
     else
       ld_shlibs_CXX=3Dno
     fi
   ;;
-      darwin* | rhapsody*)
-        case $host_os in
-        rhapsody* | darwin1.[012])
-         allow_undefined_flag_CXX=3D'${wl}-undefined ${wl}suppress'
-         ;;
-       *) # Darwin 1.3 on
-         if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
-           allow_undefined_flag_CXX=3D'${wl}-flat_namespace ${wl}-undefi=
ned ${wl}suppress'
-         else
-           case ${MACOSX_DEPLOYMENT_TARGET} in
-             10.[012])
-               allow_undefined_flag_CXX=3D'${wl}-flat_namespace ${wl}-un=
defined ${wl}suppress'
-               ;;
-             10.*)
-               allow_undefined_flag_CXX=3D'${wl}-undefined ${wl}dynamic_=
lookup'
-               ;;
-           esac
-         fi
-         ;;
-        esac
-      archive_cmds_need_lc_CXX=3Dno
-      hardcode_direct_CXX=3Dno
-      hardcode_automatic_CXX=3Dyes
-      hardcode_shlibpath_var_CXX=3Dunsupported
-      whole_archive_flag_spec_CXX=3D''
-      link_all_deplibs_CXX=3Dyes
=20
-    if test "$GXX" =3D yes ; then
-      lt_int_apple_cc_single_mod=3Dno
-      output_verbose_link_cmd=3D'echo'
-      if $CC -dumpspecs 2>&1 | $EGREP 'single_module' >/dev/null ; then
-       lt_int_apple_cc_single_mod=3Dyes
-      fi
-      if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
-       archive_cmds_CXX=3D'$CC -dynamiclib -single_module $allow_undefin=
ed_flag -o $lib $libobjs $deplibs $compiler_flags -install_name $rpath/$s=
oname $verstring'
+  darwin* | rhapsody*)
+  if test "$GXX" =3D yes; then
+    archive_cmds_need_lc_CXX=3Dno
+    case "$host_os" in
+    rhapsody* | darwin1.[012])
+      allow_undefined_flag_CXX=3D'-undefined suppress'
+      ;;
+    *) # Darwin 1.3 on
+      if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
+      	allow_undefined_flag_CXX=3D'-flat_namespace -undefined suppress'
       else
-          archive_cmds_CXX=3D'$CC -r -keep_private_externs -nostdlib -o =
${lib}-master.o $libobjs~$CC -dynamiclib $allow_undefined_flag -o $lib ${=
lib}-master.o $deplibs $compiler_flags -install_name $rpath/$soname $vers=
tring'
-        fi
-        module_cmds_CXX=3D'$CC $allow_undefined_flag -o $lib -bundle $li=
bobjs $deplibs$compiler_flags'
-        # Don't fix this by using the ld -exported_symbols_list flag, it=
 doesn't exist in older darwin lds
-          if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
-            archive_expsym_cmds_CXX=3D'sed -e "s,#.*,," -e "s,^[    ]*,,=
" -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbo=
ls.expsym~$CC -dynamiclib -single_module $allow_undefined_flag -o $lib $l=
ibobjs $deplibs $compiler_flags -install_name $rpath/$soname $verstring~n=
medit -s $output_objdir/${libname}-symbols.expsym ${lib}'
-          else
-            archive_expsym_cmds_CXX=3D'sed -e "s,#.*,," -e "s,^[    ]*,,=
" -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbo=
ls.expsym~$CC -r -keep_private_externs -nostdlib -o ${lib}-master.o $libo=
bjs~$CC -dynamiclib $allow_undefined_flag -o $lib ${lib}-master.o $deplib=
s $compiler_flags -install_name $rpath/$soname $verstring~nmedit -s $outp=
ut_objdir/${libname}-symbols.expsym ${lib}'
-          fi
-            module_expsym_cmds_CXX=3D'sed -e "s,#.*,," -e "s,^[    ]*,,"=
 -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbol=
s.expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$com=
piler_flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
-      else
-      case $cc_basename in
-        xlc*)
-         output_verbose_link_cmd=3D'echo'
-          archive_cmds_CXX=3D'$CC -qmkshrobj ${wl}-single_module $allow_=
undefined_flag -o $lib $libobjs $deplibs $compiler_flags ${wl}-install_na=
me ${wl}`echo $rpath/$soname` $verstring'
-          module_cmds_CXX=3D'$CC $allow_undefined_flag -o $lib -bundle $=
libobjs $deplibs$compiler_flags'
-          # Don't fix this by using the ld -exported_symbols_list flag, =
it doesn't exist in older darwin lds
-          archive_expsym_cmds_CXX=3D'sed -e "s,#.*,," -e "s,^[    ]*,," =
-e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols=
.expsym~$CC -qmkshrobj ${wl}-single_module $allow_undefined_flag -o $lib =
$libobjs $deplibs $compiler_flags ${wl}-install_name ${wl}$rpath/$soname =
$verstring~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
-          module_expsym_cmds_CXX=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -=
e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.=
expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compi=
ler_flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
-          ;;
-       *)
-         ld_shlibs_CXX=3Dno
-          ;;
-      esac
+        case ${MACOSX_DEPLOYMENT_TARGET} in
+          10.[012])
+            allow_undefined_flag_CXX=3D'-flat_namespace -undefined suppr=
ess'
+            ;;
+          10.*)
+            allow_undefined_flag_CXX=3D'-undefined dynamic_lookup'
+            ;;
+        esac
       fi
-        ;;
+      ;;
+    esac
+    lt_int_apple_cc_single_mod=3Dno
+    output_verbose_link_cmd=3D'echo'
+    if $CC -dumpspecs 2>&1 | grep 'single_module' >/dev/null ; then
+      lt_int_apple_cc_single_mod=3Dyes
+    fi
+    if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+      archive_cmds_CXX=3D'$CC -dynamiclib -single_module $allow_undefine=
d_flag -o $lib $libobjs $deplibs $compiler_flags -install_name $rpath/$so=
name $verstring'
+    else
+      archive_cmds_CXX=3D'$CC -r ${wl}-bind_at_load -keep_private_extern=
s -nostdlib -o ${lib}-master.o $libobjs~$CC -dynamiclib $allow_undefined_=
flag -o $lib ${lib}-master.o $deplibs $compiler_flags -install_name $rpat=
h/$soname $verstring'
+    fi
+    module_cmds_CXX=3D'$CC ${wl}-bind_at_load $allow_undefined_flag -o $=
lib -bundle $libobjs $deplibs$compiler_flags'
=20
+    # Don't fix this by using the ld -exported_symbols_list flag, it doe=
sn't exist in older darwin ld's
+    if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+      archive_expsym_cmds_CXX=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "=
s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exp=
sym~$CC -dynamiclib -single_module $allow_undefined_flag -o $lib $libobjs=
 $deplibs $compiler_flags -install_name $rpath/$soname $verstring~nmedit =
-s $output_objdir/${libname}-symbols.expsym ${lib}'
+    else
+      archive_expsym_cmds_CXX=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "=
s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exp=
sym~$CC -r ${wl}-bind_at_load -keep_private_externs -nostdlib -o ${lib}-m=
aster.o $libobjs~$CC -dynamiclib $allow_undefined_flag -o $lib ${lib}-mas=
ter.o $deplibs $compiler_flags -install_name $rpath/$soname $verstring~nm=
edit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+    fi
+    module_expsym_cmds_CXX=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "s,^=
\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.expsym=
~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compiler_fl=
ags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+    hardcode_direct_CXX=3Dno
+    hardcode_automatic_CXX=3Dyes
+    hardcode_shlibpath_var_CXX=3Dunsupported
+    whole_archive_flag_spec_CXX=3D'-all_load $convenience'
+    link_all_deplibs_CXX=3Dyes
+  else
+    ld_shlibs_CXX=3Dno
+  fi
+    ;;
+
   dgux*)
     case $cc_basename in
-      ec++*)
+      ec++)
 	# FIXME: insert proper C++ library support
 	ld_shlibs_CXX=3Dno
 	;;
-      ghcx*)
+      ghcx)
 	# Green Hills C++ Compiler
 	# FIXME: insert proper C++ library support
 	ld_shlibs_CXX=3Dno
@@ -11581,14 +11221,14 @@
 	;;
     esac
     ;;
-  freebsd[12]*)
+  freebsd12*)
     # C++ shared libraries reported to be fairly broken before switch to=
 ELF
     ld_shlibs_CXX=3Dno
     ;;
   freebsd-elf*)
     archive_cmds_need_lc_CXX=3Dno
     ;;
-  freebsd* | kfreebsd*-gnu | dragonfly*)
+  freebsd* | kfreebsd*-gnu)
     # FreeBSD 3 and later use GNU C++ and GNU ld with standard ELF
     # conventions
     ld_shlibs_CXX=3Dyes
@@ -11605,11 +11245,11 @@
 				# location of the library.
=20
     case $cc_basename in
-    CC*)
+    CC)
       # FIXME: insert proper C++ library support
       ld_shlibs_CXX=3Dno
       ;;
-    aCC*)
+    aCC)
       archive_cmds_CXX=3D'$rm $output_objdir/$soname~$CC -b ${wl}+b ${wl=
}$install_libdir -o $output_objdir/$soname $predep_objects $libobjs $depl=
ibs $postdep_objects $compiler_flags~test $output_objdir/$soname =3D $lib=
 || mv $output_objdir/$soname $lib'
       # Commands to make compiler produce verbose output that lists
       # what "hidden" libraries, object files and flags are used when
@@ -11619,7 +11259,7 @@
       # explicitly linking system object files so we need to strip them
       # from the output so that they don't get included in the library
       # dependencies.
-      output_verbose_link_cmd=3D'templist=3D`($CC -b $CFLAGS -v conftest=
.$objext 2>&1) | grep "[-]L"`; list=3D""; for z in $templist; do case $z =
in conftest.$objext) list=3D"$list $z";; *.$objext);; *) list=3D"$list $z=
";;esac; done; echo $list'
+      output_verbose_link_cmd=3D'templist=3D`($CC -b $CFLAGS -v conftest=
.$objext 2>&1) | grep "-L"`; list=3D""; for z in $templist; do case $z in=
 conftest.$objext) list=3D"$list $z";; *.$objext);; *) list=3D"$list $z";=
;esac; done; echo $list'
       ;;
     *)
       if test "$GXX" =3D yes; then
@@ -11633,23 +11273,34 @@
     ;;
   hpux10*|hpux11*)
     if test $with_gnu_ld =3D no; then
-      hardcode_libdir_flag_spec_CXX=3D'${wl}+b ${wl}$libdir'
-      hardcode_libdir_separator_CXX=3D:
-
-      case $host_cpu in
-      hppa*64*|ia64*)
+      case "$host_cpu" in
+      hppa*64*)
+	hardcode_libdir_flag_spec_CXX=3D'${wl}+b ${wl}$libdir'
 	hardcode_libdir_flag_spec_ld_CXX=3D'+b $libdir'
+	hardcode_libdir_separator_CXX=3D:
         ;;
+      ia64*)
+	hardcode_libdir_flag_spec_CXX=3D'-L$libdir'
+        ;;
       *)
+	hardcode_libdir_flag_spec_CXX=3D'${wl}+b ${wl}$libdir'
+	hardcode_libdir_separator_CXX=3D:
 	export_dynamic_flag_spec_CXX=3D'${wl}-E'
         ;;
       esac
     fi
-    case $host_cpu in
-    hppa*64*|ia64*)
+    case "$host_cpu" in
+    hppa*64*)
       hardcode_direct_CXX=3Dno
       hardcode_shlibpath_var_CXX=3Dno
       ;;
+    ia64*)
+      hardcode_direct_CXX=3Dno
+      hardcode_shlibpath_var_CXX=3Dno
+      hardcode_minus_L_CXX=3Dyes # Not in the search PATH,
+					      # but as the default
+					      # location of the library.
+      ;;
     *)
       hardcode_direct_CXX=3Dyes
       hardcode_minus_L_CXX=3Dyes # Not in the search PATH,
@@ -11659,18 +11310,15 @@
     esac
=20
     case $cc_basename in
-      CC*)
+      CC)
 	# FIXME: insert proper C++ library support
 	ld_shlibs_CXX=3Dno
 	;;
-      aCC*)
-	case $host_cpu in
-	hppa*64*)
-	  archive_cmds_CXX=3D'$CC -b ${wl}+h ${wl}$soname -o $lib $predep_objec=
ts $libobjs $deplibs $postdep_objects $compiler_flags'
+      aCC)
+	case "$host_cpu" in
+	hppa*64*|ia64*)
+	  archive_cmds_CXX=3D'$LD -b +h $soname -o $lib $linker_flags $libobjs =
$deplibs'
 	  ;;
-	ia64*)
-	  archive_cmds_CXX=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+nodefaultrpath =
-o $lib $predep_objects $libobjs $deplibs $postdep_objects $compiler_flag=
s'
-	  ;;
 	*)
 	  archive_cmds_CXX=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+b ${wl}$install=
_libdir -o $lib $predep_objects $libobjs $deplibs $postdep_objects $compi=
ler_flags'
 	  ;;
@@ -11688,13 +11336,10 @@
       *)
 	if test "$GXX" =3D yes; then
 	  if test $with_gnu_ld =3D no; then
-	    case $host_cpu in
-	    hppa*64*)
-	      archive_cmds_CXX=3D'$CC -shared -nostdlib -fPIC ${wl}+h ${wl}$son=
ame -o $lib $predep_objects $libobjs $deplibs $postdep_objects $compiler_=
flags'
+	    case "$host_cpu" in
+	    ia64*|hppa*64*)
+	      archive_cmds_CXX=3D'$LD -b +h $soname -o $lib $linker_flags $libo=
bjs $deplibs'
 	      ;;
-	    ia64*)
-	      archive_cmds_CXX=3D'$CC -shared -nostdlib -fPIC ${wl}+h ${wl}$son=
ame ${wl}+nodefaultrpath -o $lib $predep_objects $libobjs $deplibs $postd=
ep_objects $compiler_flags'
-	      ;;
 	    *)
 	      archive_cmds_CXX=3D'$CC -shared -nostdlib -fPIC ${wl}+h ${wl}$son=
ame ${wl}+b ${wl}$install_libdir -o $lib $predep_objects $libobjs $deplib=
s $postdep_objects $compiler_flags'
 	      ;;
@@ -11707,25 +11352,11 @@
 	;;
     esac
     ;;
-  interix3*)
-    hardcode_direct_CXX=3Dno
-    hardcode_shlibpath_var_CXX=3Dno
-    hardcode_libdir_flag_spec_CXX=3D'${wl}-rpath,$libdir'
-    export_dynamic_flag_spec_CXX=3D'${wl}-E'
-    # Hack: On Interix 3.x, we cannot compile PIC because of a broken gc=
c.
-    # Instead, shared libraries are loaded at an image base (0x10000000 =
by
-    # default) and relocated if they conflict, which is a slow very memo=
ry
-    # consuming and fragmenting process.  To avoid this, we pick a rando=
m,
-    # 256 KiB-aligned image base between 0x50000000 and 0x6FFC0000 at li=
nk
-    # time.  Moving up from 0x10000000 also allows more sbrk(2) space.
-    archive_cmds_CXX=3D'$CC -shared $pic_flag $libobjs $deplibs $compile=
r_flags ${wl}-h,$soname ${wl}--image-base,`expr ${RANDOM-$$} % 4096 / 2 \=
* 262144 + 1342177280` -o $lib'
-    archive_expsym_cmds_CXX=3D'sed "s,^,_," $export_symbols >$output_obj=
dir/$soname.expsym~$CC -shared $pic_flag $libobjs $deplibs $compiler_flag=
s ${wl}-h,$soname ${wl}--retain-symbols-file,$output_objdir/$soname.expsy=
m ${wl}--image-base,`expr ${RANDOM-$$} % 4096 / 2 \* 262144 + 1342177280`=
 -o $lib'
-    ;;
   irix5* | irix6*)
     case $cc_basename in
-      CC*)
+      CC)
 	# SGI C++
-	archive_cmds_CXX=3D'$CC -shared -all -multigot $predep_objects $libobjs=
 $deplibs $postdep_objects $compiler_flags -soname $soname `test -n "$ver=
string" && echo -set_version $verstring` -update_registry ${output_objdir=
}/so_locations -o $lib'
+	archive_cmds_CXX=3D'$CC -shared -all -multigot $predep_objects $libobjs=
 $deplibs $postdep_objects $compiler_flags -soname $soname `test -n "$ver=
string" && echo -set_version $verstring` -update_registry ${objdir}/so_lo=
cations -o $lib'
=20
 	# Archives containing C++ object files must be created using
 	# "CC -ar", where "CC" is the IRIX C++ compiler.  This is
@@ -11736,7 +11367,7 @@
       *)
 	if test "$GXX" =3D yes; then
 	  if test "$with_gnu_ld" =3D no; then
-	    archive_cmds_CXX=3D'$CC -shared -nostdlib $predep_objects $libobjs =
$deplibs $postdep_objects $compiler_flags ${wl}-soname ${wl}$soname `test=
 -n "$verstring" && echo ${wl}-set_version ${wl}$verstring` ${wl}-update_=
registry ${wl}${output_objdir}/so_locations -o $lib'
+	    archive_cmds_CXX=3D'$CC -shared -nostdlib $predep_objects $libobjs =
$deplibs $postdep_objects $compiler_flags ${wl}-soname ${wl}$soname `test=
 -n "$verstring" && echo ${wl}-set_version ${wl}$verstring` ${wl}-update_=
registry ${wl}${objdir}/so_locations -o $lib'
 	  else
 	    archive_cmds_CXX=3D'$CC -shared -nostdlib $predep_objects $libobjs =
$deplibs $postdep_objects $compiler_flags ${wl}-soname ${wl}$soname `test=
 -n "$verstring" && echo ${wl}-set_version ${wl}$verstring` -o $lib'
 	  fi
@@ -11749,7 +11380,7 @@
     ;;
   linux*)
     case $cc_basename in
-      KCC*)
+      KCC)
 	# Kuck and Associates, Inc. (KAI) C++ Compiler
=20
 	# KCC will only create a shared library if the output file
@@ -11774,41 +11405,17 @@
 	# "CC -Bstatic", where "CC" is the KAI C++ compiler.
 	old_archive_cmds_CXX=3D'$CC -Bstatic -o $oldlib $oldobjs'
 	;;
-      icpc*)
+      icpc)
 	# Intel C++
 	with_gnu_ld=3Dyes
-	# version 8.0 and above of icpc choke on multiply defined symbols
-	# if we add $predep_objects and $postdep_objects, however 7.1 and
-	# earlier do not add the objects themselves.
-	case `$CC -V 2>&1` in
-	*"Version 7."*)
-  	  archive_cmds_CXX=3D'$CC -shared $predep_objects $libobjs $deplibs $=
postdep_objects $compiler_flags ${wl}-soname $wl$soname -o $lib'
-  	  archive_expsym_cmds_CXX=3D'$CC -shared $predep_objects $libobjs $de=
plibs $postdep_objects $compiler_flags ${wl}-soname $wl$soname ${wl}-reta=
in-symbols-file $wl$export_symbols -o $lib'
-	  ;;
-	*)  # Version 8.0 or newer
-	  tmp_idyn=3D
-	  case $host_cpu in
-	    ia64*) tmp_idyn=3D' -i_dynamic';;
-	  esac
-  	  archive_cmds_CXX=3D'$CC -shared'"$tmp_idyn"' $libobjs $deplibs $com=
piler_flags ${wl}-soname $wl$soname -o $lib'
-	  archive_expsym_cmds_CXX=3D'$CC -shared'"$tmp_idyn"' $libobjs $deplibs=
 $compiler_flags ${wl}-soname $wl$soname ${wl}-retain-symbols-file $wl$ex=
port_symbols -o $lib'
-	  ;;
-	esac
 	archive_cmds_need_lc_CXX=3Dno
+	archive_cmds_CXX=3D'$CC -shared $predep_objects $libobjs $deplibs $post=
dep_objects $compiler_flags ${wl}-soname $wl$soname -o $lib'
+	archive_expsym_cmds_CXX=3D'$CC -shared $predep_objects $libobjs $deplib=
s $postdep_objects $compiler_flags ${wl}-soname $wl$soname ${wl}-retain-s=
ymbols-file $wl$export_symbols -o $lib'
 	hardcode_libdir_flag_spec_CXX=3D'${wl}-rpath,$libdir'
 	export_dynamic_flag_spec_CXX=3D'${wl}--export-dynamic'
 	whole_archive_flag_spec_CXX=3D'${wl}--whole-archive$convenience ${wl}--=
no-whole-archive'
 	;;
-      pgCC*)
-        # Portland Group C++ compiler
-	archive_cmds_CXX=3D'$CC -shared $pic_flag $predep_objects $libobjs $dep=
libs $postdep_objects $compiler_flags ${wl}-soname ${wl}$soname -o $lib'
-  	archive_expsym_cmds_CXX=3D'$CC -shared $pic_flag $predep_objects $lib=
objs $deplibs $postdep_objects $compiler_flags ${wl}-soname ${wl}$soname =
${wl}-retain-symbols-file ${wl}$export_symbols -o $lib'
-
-	hardcode_libdir_flag_spec_CXX=3D'${wl}--rpath ${wl}$libdir'
-	export_dynamic_flag_spec_CXX=3D'${wl}--export-dynamic'
-	whole_archive_flag_spec_CXX=3D'${wl}--whole-archive`for conv in $conven=
ience\"\"; do test  -n \"$conv\" && new_convenience=3D\"$new_convenience,=
$conv\"; done; $echo \"$new_convenience\"` ${wl}--no-whole-archive'
-        ;;
-      cxx*)
+      cxx)
 	# Compaq C++
 	archive_cmds_CXX=3D'$CC -shared $predep_objects $libobjs $deplibs $post=
dep_objects $compiler_flags ${wl}-soname $wl$soname -o $lib'
 	archive_expsym_cmds_CXX=3D'$CC -shared $predep_objects $libobjs $deplib=
s $postdep_objects $compiler_flags ${wl}-soname $wl$soname  -o $lib ${wl}=
-retain-symbols-file $wl$export_symbols'
@@ -11839,7 +11446,7 @@
     ;;
   mvs*)
     case $cc_basename in
-      cxx*)
+      cxx)
 	# FIXME: insert proper C++ library support
 	ld_shlibs_CXX=3Dno
 	;;
@@ -11860,25 +11467,9 @@
     # Workaround some broken pre-1.5 toolchains
     output_verbose_link_cmd=3D'$CC -shared $CFLAGS -v conftest.$objext 2=
>&1 | grep conftest.$objext | $SED -e "s:-lgcc -lc -lgcc::"'
     ;;
-  openbsd2*)
-    # C++ shared libraries are fairly broken
-    ld_shlibs_CXX=3Dno
-    ;;
-  openbsd*)
-    hardcode_direct_CXX=3Dyes
-    hardcode_shlibpath_var_CXX=3Dno
-    archive_cmds_CXX=3D'$CC -shared $pic_flag $predep_objects $libobjs $=
deplibs $postdep_objects $compiler_flags -o $lib'
-    hardcode_libdir_flag_spec_CXX=3D'${wl}-rpath,$libdir'
-    if test -z "`echo __ELF__ | $CC -E - | grep __ELF__`" || test "$host=
_os-$host_cpu" =3D "openbsd2.8-powerpc"; then
-      archive_expsym_cmds_CXX=3D'$CC -shared $pic_flag $predep_objects $=
libobjs $deplibs $postdep_objects $compiler_flags ${wl}-retain-symbols-fi=
le,$export_symbols -o $lib'
-      export_dynamic_flag_spec_CXX=3D'${wl}-E'
-      whole_archive_flag_spec_CXX=3D"$wlarc"'--whole-archive$convenience=
 '"$wlarc"'--no-whole-archive'
-    fi
-    output_verbose_link_cmd=3D'echo'
-    ;;
   osf3*)
     case $cc_basename in
-      KCC*)
+      KCC)
 	# Kuck and Associates, Inc. (KAI) C++ Compiler
=20
 	# KCC will only create a shared library if the output file
@@ -11894,14 +11485,14 @@
 	old_archive_cmds_CXX=3D'$CC -Bstatic -o $oldlib $oldobjs'
=20
 	;;
-      RCC*)
+      RCC)
 	# Rational C++ 2.4.1
 	# FIXME: insert proper C++ library support
 	ld_shlibs_CXX=3Dno
 	;;
-      cxx*)
+      cxx)
 	allow_undefined_flag_CXX=3D' ${wl}-expect_unresolved ${wl}\*'
-	archive_cmds_CXX=3D'$CC -shared${allow_undefined_flag} $predep_objects =
$libobjs $deplibs $postdep_objects $compiler_flags ${wl}-soname $soname `=
test -n "$verstring" && echo ${wl}-set_version $verstring` -update_regist=
ry ${output_objdir}/so_locations -o $lib'
+	archive_cmds_CXX=3D'$CC -shared${allow_undefined_flag} $predep_objects =
$libobjs $deplibs $postdep_objects $compiler_flags ${wl}-soname $soname `=
test -n "$verstring" && echo ${wl}-set_version $verstring` -update_regist=
ry ${objdir}/so_locations -o $lib'
=20
 	hardcode_libdir_flag_spec_CXX=3D'${wl}-rpath ${wl}$libdir'
 	hardcode_libdir_separator_CXX=3D:
@@ -11919,7 +11510,7 @@
       *)
 	if test "$GXX" =3D yes && test "$with_gnu_ld" =3D no; then
 	  allow_undefined_flag_CXX=3D' ${wl}-expect_unresolved ${wl}\*'
-	  archive_cmds_CXX=3D'$CC -shared -nostdlib ${allow_undefined_flag} $pr=
edep_objects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-son=
ame ${wl}$soname `test -n "$verstring" && echo ${wl}-set_version ${wl}$ve=
rstring` ${wl}-update_registry ${wl}${output_objdir}/so_locations -o $lib=
'
+	  archive_cmds_CXX=3D'$CC -shared -nostdlib ${allow_undefined_flag} $pr=
edep_objects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-son=
ame ${wl}$soname `test -n "$verstring" && echo ${wl}-set_version ${wl}$ve=
rstring` ${wl}-update_registry ${wl}${objdir}/so_locations -o $lib'
=20
 	  hardcode_libdir_flag_spec_CXX=3D'${wl}-rpath ${wl}$libdir'
 	  hardcode_libdir_separator_CXX=3D:
@@ -11938,7 +11529,7 @@
     ;;
   osf4* | osf5*)
     case $cc_basename in
-      KCC*)
+      KCC)
 	# Kuck and Associates, Inc. (KAI) C++ Compiler
=20
 	# KCC will only create a shared library if the output file
@@ -11953,17 +11544,17 @@
 	# the KAI C++ compiler.
 	old_archive_cmds_CXX=3D'$CC -o $oldlib $oldobjs'
 	;;
-      RCC*)
+      RCC)
 	# Rational C++ 2.4.1
 	# FIXME: insert proper C++ library support
 	ld_shlibs_CXX=3Dno
 	;;
-      cxx*)
+      cxx)
 	allow_undefined_flag_CXX=3D' -expect_unresolved \*'
-	archive_cmds_CXX=3D'$CC -shared${allow_undefined_flag} $predep_objects =
$libobjs $deplibs $postdep_objects $compiler_flags -msym -soname $soname =
`test -n "$verstring" && echo -set_version $verstring` -update_registry $=
{output_objdir}/so_locations -o $lib'
+	archive_cmds_CXX=3D'$CC -shared${allow_undefined_flag} $predep_objects =
$libobjs $deplibs $postdep_objects $compiler_flags -msym -soname $soname =
`test -n "$verstring" && echo -set_version $verstring` -update_registry $=
{objdir}/so_locations -o $lib'
 	archive_expsym_cmds_CXX=3D'for i in `cat $export_symbols`; do printf "%=
s %s\\n" -exported_symbol "\$i" >> $lib.exp; done~
 	  echo "-hidden">> $lib.exp~
-	  $CC -shared$allow_undefined_flag $predep_objects $libobjs $deplibs $p=
ostdep_objects $compiler_flags -msym -soname $soname -Wl,-input -Wl,$lib.=
exp  `test -n "$verstring" && echo -set_version	$verstring` -update_regis=
try ${output_objdir}/so_locations -o $lib~
+	  $CC -shared$allow_undefined_flag $predep_objects $libobjs $deplibs $p=
ostdep_objects $compiler_flags -msym -soname $soname -Wl,-input -Wl,$lib.=
exp  `test -n "$verstring" && echo -set_version	$verstring` -update_regis=
try $objdir/so_locations -o $lib~
 	  $rm $lib.exp'
=20
 	hardcode_libdir_flag_spec_CXX=3D'-rpath $libdir'
@@ -11982,7 +11573,7 @@
       *)
 	if test "$GXX" =3D yes && test "$with_gnu_ld" =3D no; then
 	  allow_undefined_flag_CXX=3D' ${wl}-expect_unresolved ${wl}\*'
-	 archive_cmds_CXX=3D'$CC -shared -nostdlib ${allow_undefined_flag} $pre=
dep_objects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-msym=
 ${wl}-soname ${wl}$soname `test -n "$verstring" && echo ${wl}-set_versio=
n ${wl}$verstring` ${wl}-update_registry ${wl}${output_objdir}/so_locatio=
ns -o $lib'
+	 archive_cmds_CXX=3D'$CC -shared -nostdlib ${allow_undefined_flag} $pre=
dep_objects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-msym=
 ${wl}-soname ${wl}$soname `test -n "$verstring" && echo ${wl}-set_versio=
n ${wl}$verstring` ${wl}-update_registry ${wl}${objdir}/so_locations -o $=
lib'
=20
 	  hardcode_libdir_flag_spec_CXX=3D'${wl}-rpath ${wl}$libdir'
 	  hardcode_libdir_separator_CXX=3D:
@@ -12003,14 +11594,27 @@
     # FIXME: insert proper C++ library support
     ld_shlibs_CXX=3Dno
     ;;
+  sco*)
+    archive_cmds_need_lc_CXX=3Dno
+    case $cc_basename in
+      CC)
+	# FIXME: insert proper C++ library support
+	ld_shlibs_CXX=3Dno
+	;;
+      *)
+	# FIXME: insert proper C++ library support
+	ld_shlibs_CXX=3Dno
+	;;
+    esac
+    ;;
   sunos4*)
     case $cc_basename in
-      CC*)
+      CC)
 	# Sun C++ 4.x
 	# FIXME: insert proper C++ library support
 	ld_shlibs_CXX=3Dno
 	;;
-      lcc*)
+      lcc)
 	# Lucid
 	# FIXME: insert proper C++ library support
 	ld_shlibs_CXX=3Dno
@@ -12023,33 +11627,36 @@
     ;;
   solaris*)
     case $cc_basename in
-      CC*)
+      CC)
 	# Sun C++ 4.2, 5.x and Centerline C++
-        archive_cmds_need_lc_CXX=3Dyes
 	no_undefined_flag_CXX=3D' -zdefs'
-	archive_cmds_CXX=3D'$CC -G${allow_undefined_flag}  -h$soname -o $lib $p=
redep_objects $libobjs $deplibs $postdep_objects $compiler_flags'
+	archive_cmds_CXX=3D'$CC -G${allow_undefined_flag} -nolib -h$soname -o $=
lib $predep_objects $libobjs $deplibs $postdep_objects $compiler_flags'
 	archive_expsym_cmds_CXX=3D'$echo "{ global:" > $lib.exp~cat $export_sym=
bols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *; };" >> $lib.e=
xp~
-	$CC -G${allow_undefined_flag}  ${wl}-M ${wl}$lib.exp -h$soname -o $lib =
$predep_objects $libobjs $deplibs $postdep_objects $compiler_flags~$rm $l=
ib.exp'
+	$CC -G${allow_undefined_flag} -nolib ${wl}-M ${wl}$lib.exp -h$soname -o=
 $lib $predep_objects $libobjs $deplibs $postdep_objects $compiler_flags~=
$rm $lib.exp'
=20
 	hardcode_libdir_flag_spec_CXX=3D'-R$libdir'
 	hardcode_shlibpath_var_CXX=3Dno
 	case $host_os in
-	  solaris2.[0-5] | solaris2.[0-5].*) ;;
+	  solaris2.0-5 | solaris2.0-5.*) ;;
 	  *)
 	    # The C++ compiler is used as linker so we must use $wl
 	    # flag to pass the commands to the underlying system
-	    # linker. We must also pass each convience library through
-	    # to the system linker between allextract/defaultextract.
-	    # The C++ compiler will combine linker options so we
-	    # cannot just pass the convience library names through
-	    # without $wl.
+	    # linker.
 	    # Supported since Solaris 2.6 (maybe 2.5.1?)
-	    whole_archive_flag_spec_CXX=3D'${wl}-z ${wl}allextract`for conv in =
$convenience\"\"; do test -n \"$conv\" && new_convenience=3D\"$new_conven=
ience,$conv\"; done; $echo \"$new_convenience\"` ${wl}-z ${wl}defaultextr=
act'
+	    whole_archive_flag_spec_CXX=3D'${wl}-z ${wl}allextract$convenience =
${wl}-z ${wl}defaultextract'
 	    ;;
 	esac
 	link_all_deplibs_CXX=3Dyes
=20
-	output_verbose_link_cmd=3D'echo'
+	# Commands to make compiler produce verbose output that lists
+	# what "hidden" libraries, object files and flags are used when
+	# linking a shared library.
+	#
+	# There doesn't appear to be a way to prevent this compiler from
+	# explicitly linking system object files so we need to strip them
+	# from the output so that they don't get included in the library
+	# dependencies.
+	output_verbose_link_cmd=3D'templist=3D`$CC -G $CFLAGS -v conftest.$obje=
xt 2>&1 | grep "\-[LR]"`; list=3D""; for z in $templist; do case $z in co=
nftest.$objext) list=3D"$list $z";; *.$objext);; *) list=3D"$list $z";;es=
ac; done; echo $list'
=20
 	# Archives containing C++ object files must be created using
 	# "CC -xar", where "CC" is the Sun C++ compiler.  This is
@@ -12057,7 +11664,7 @@
 	# in the archive.
 	old_archive_cmds_CXX=3D'$CC -xar -o $oldlib $oldobjs'
 	;;
-      gcx*)
+      gcx)
 	# Green Hills C++ Compiler
 	archive_cmds_CXX=3D'$CC -shared $predep_objects $libobjs $deplibs $post=
dep_objects $compiler_flags ${wl}-h $wl$soname -o $lib'
=20
@@ -12095,63 +11702,12 @@
 	;;
     esac
     ;;
-  sysv4*uw2* | sysv5OpenUNIX* | sysv5UnixWare7.[01].[10]* | unixware7* |=
 sco3.2v5.0.[024]*)
-    no_undefined_flag_CXX=3D'${wl}-z,text'
+  sysv5OpenUNIX8* | sysv5UnixWare7* | sysv5uw[78]* | unixware7*)
     archive_cmds_need_lc_CXX=3Dno
-    hardcode_shlibpath_var_CXX=3Dno
-    runpath_var=3D'LD_RUN_PATH'
-
-    case $cc_basename in
-      CC*)
-	archive_cmds_CXX=3D'$CC -G ${wl}-h,$soname -o $lib $libobjs $deplibs $c=
ompiler_flags'
-	archive_expsym_cmds_CXX=3D'$CC -G ${wl}-Bexport:$export_symbols ${wl}-h=
,$soname -o $lib $libobjs $deplibs $compiler_flags'
-	;;
-      *)
-	archive_cmds_CXX=3D'$CC -shared ${wl}-h,$soname -o $lib $libobjs $depli=
bs $compiler_flags'
-	archive_expsym_cmds_CXX=3D'$CC -shared ${wl}-Bexport:$export_symbols ${=
wl}-h,$soname -o $lib $libobjs $deplibs $compiler_flags'
-	;;
-    esac
     ;;
-  sysv5* | sco3.2v5* | sco5v6*)
-    # Note: We can NOT use -z defs as we might desire, because we do not
-    # link with -lc, and that would cause any symbols used from libc to
-    # always be unresolved, which means just about no library would
-    # ever link correctly.  If we're not using GNU ld we use -z text
-    # though, which does catch some bad symbols but isn't as heavy-hande=
d
-    # as -z defs.
-    # For security reasons, it is highly recommended that you always
-    # use absolute paths for naming shared libraries, and exclude the
-    # DT_RUNPATH tag from executables and libraries.  But doing so
-    # requires that you compile everything twice, which is a pain.
-    # So that behaviour is only enabled if SCOABSPATH is set to a
-    # non-empty value in the environment.  Most likely only useful for
-    # creating official distributions of packages.
-    # This is a hack until libtool officially supports absolute path
-    # names for shared libraries.
-    no_undefined_flag_CXX=3D'${wl}-z,text'
-    allow_undefined_flag_CXX=3D'${wl}-z,nodefs'
-    archive_cmds_need_lc_CXX=3Dno
-    hardcode_shlibpath_var_CXX=3Dno
-    hardcode_libdir_flag_spec_CXX=3D'`test -z "$SCOABSPATH" && echo ${wl=
}-R,$libdir`'
-    hardcode_libdir_separator_CXX=3D':'
-    link_all_deplibs_CXX=3Dyes
-    export_dynamic_flag_spec_CXX=3D'${wl}-Bexport'
-    runpath_var=3D'LD_RUN_PATH'
-
-    case $cc_basename in
-      CC*)
-	archive_cmds_CXX=3D'$CC -G ${wl}-h,\${SCOABSPATH:+${install_libdir}/}$s=
oname -o $lib $libobjs $deplibs $compiler_flags'
-	archive_expsym_cmds_CXX=3D'$CC -G ${wl}-Bexport:$export_symbols ${wl}-h=
,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $libobjs $deplibs $com=
piler_flags'
-	;;
-      *)
-	archive_cmds_CXX=3D'$CC -shared ${wl}-h,\${SCOABSPATH:+${install_libdir=
}/}$soname -o $lib $libobjs $deplibs $compiler_flags'
-	archive_expsym_cmds_CXX=3D'$CC -shared ${wl}-Bexport:$export_symbols ${=
wl}-h,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $libobjs $deplibs=
 $compiler_flags'
-	;;
-    esac
-    ;;
   tandem*)
     case $cc_basename in
-      NCC*)
+      NCC)
 	# NonStop-UX NCC 3.20
 	# FIXME: insert proper C++ library support
 	ld_shlibs_CXX=3Dno
@@ -12204,7 +11760,7 @@
   # The `*' in the case matches for architectures that use `case' in
   # $output_verbose_cmd can trigger glob expansion during the loop
   # eval without this substitution.
-  output_verbose_link_cmd=3D`$echo "X$output_verbose_link_cmd" | $Xsed -=
e "$no_glob_subst"`
+  output_verbose_link_cmd=3D"`$echo \"X$output_verbose_link_cmd\" | $Xse=
d -e \"$no_glob_subst\"`"
=20
   for p in `eval $output_verbose_link_cmd`; do
     case $p in
@@ -12280,29 +11836,6 @@
=20
 $rm -f confest.$objext
=20
-# PORTME: override above test on systems where it is broken
-case $host_os in
-interix3*)
-  # Interix 3.5 installs completely hosed .la files for C++, so rather t=
han
-  # hack all around it, let's just trust "g++" to DTRT.
-  predep_objects_CXX=3D
-  postdep_objects_CXX=3D
-  postdeps_CXX=3D
-  ;;
-
-solaris*)
-  case $cc_basename in
-  CC*)
-    # Adding this requires a known-good setup of shared libraries for
-    # Sun compiler versions before 5.6, else PIC objects from an old
-    # archive will be linked into the output, leading to subtle bugs.
-    postdeps_CXX=3D'-lCstd -lCrun'
-    ;;
-  esac
-  ;;
-esac
-
-
 case " $postdeps_CXX " in
 *" -lc "*) archive_cmds_need_lc_CXX=3Dno ;;
 esac
@@ -12350,10 +11883,6 @@
       # DJGPP does not support shared libraries at all
       lt_prog_compiler_pic_CXX=3D
       ;;
-    interix3*)
-      # Interix 3.x gcc -fpic/-fPIC options generate broken code.
-      # Instead, we relocate shared libraries at runtime.
-      ;;
     sysv4*MP*)
       if test -d /usr/nec; then
 	lt_prog_compiler_pic_CXX=3D-Kconform_pic
@@ -12362,7 +11891,7 @@
     hpux*)
       # PIC is the default for IA64 HP-UX and 64-bit HP-UX, but
       # not for PA HP-UX.
-      case $host_cpu in
+      case "$host_cpu" in
       hppa*64*|ia64*)
 	;;
       *)
@@ -12387,28 +11916,18 @@
 	;;
       chorus*)
 	case $cc_basename in
-	cxch68*)
+	cxch68)
 	  # Green Hills C++ Compiler
 	  # _LT_AC_TAGVAR(lt_prog_compiler_static, CXX)=3D"--no_auto_instantiat=
ion -u __main -u __premain -u _abort -r $COOL_DIR/lib/libOrb.a $MVME_DIR/=
lib/CC/libC.a $MVME_DIR/lib/classix/libcx.s.a"
 	  ;;
 	esac
 	;;
-       darwin*)
-         # PIC is the default on this platform
-         # Common symbols not allowed in MH_DYLIB files
-         case $cc_basename in
-           xlc*)
-           lt_prog_compiler_pic_CXX=3D'-qnocommon'
-           lt_prog_compiler_wl_CXX=3D'-Wl,'
-           ;;
-         esac
-       ;;
       dgux*)
 	case $cc_basename in
-	  ec++*)
+	  ec++)
 	    lt_prog_compiler_pic_CXX=3D'-KPIC'
 	    ;;
-	  ghcx*)
+	  ghcx)
 	    # Green Hills C++ Compiler
 	    lt_prog_compiler_pic_CXX=3D'-pic'
 	    ;;
@@ -12416,22 +11935,22 @@
 	    ;;
 	esac
 	;;
-      freebsd* | kfreebsd*-gnu | dragonfly*)
+      freebsd* | kfreebsd*-gnu)
 	# FreeBSD uses GNU C++
 	;;
       hpux9* | hpux10* | hpux11*)
 	case $cc_basename in
-	  CC*)
+	  CC)
 	    lt_prog_compiler_wl_CXX=3D'-Wl,'
-	    lt_prog_compiler_static_CXX=3D'${wl}-a ${wl}archive'
+	    lt_prog_compiler_static_CXX=3D"${ac_cv_prog_cc_wl}-a ${ac_cv_prog_c=
c_wl}archive"
 	    if test "$host_cpu" !=3D ia64; then
 	      lt_prog_compiler_pic_CXX=3D'+Z'
 	    fi
 	    ;;
-	  aCC*)
+	  aCC)
 	    lt_prog_compiler_wl_CXX=3D'-Wl,'
-	    lt_prog_compiler_static_CXX=3D'${wl}-a ${wl}archive'
-	    case $host_cpu in
+	    lt_prog_compiler_static_CXX=3D"${ac_cv_prog_cc_wl}-a ${ac_cv_prog_c=
c_wl}archive"
+	    case "$host_cpu" in
 	    hppa*64*|ia64*)
 	      # +Z the default
 	      ;;
@@ -12444,13 +11963,9 @@
 	    ;;
 	esac
 	;;
-      interix*)
-	# This is c89, which is MS Visual C++ (no shared libs)
-	# Anyone wants to do a port?
-	;;
       irix5* | irix6* | nonstopux*)
 	case $cc_basename in
-	  CC*)
+	  CC)
 	    lt_prog_compiler_wl_CXX=3D'-Wl,'
 	    lt_prog_compiler_static_CXX=3D'-non_shared'
 	    # CC pic flag -KPIC is the default.
@@ -12461,24 +11976,18 @@
 	;;
       linux*)
 	case $cc_basename in
-	  KCC*)
+	  KCC)
 	    # KAI C++ Compiler
 	    lt_prog_compiler_wl_CXX=3D'--backend -Wl,'
 	    lt_prog_compiler_pic_CXX=3D'-fPIC'
 	    ;;
-	  icpc* | ecpc*)
+	  icpc)
 	    # Intel C++
 	    lt_prog_compiler_wl_CXX=3D'-Wl,'
 	    lt_prog_compiler_pic_CXX=3D'-KPIC'
 	    lt_prog_compiler_static_CXX=3D'-static'
 	    ;;
-	  pgCC*)
-	    # Portland Group C++ compiler.
-	    lt_prog_compiler_wl_CXX=3D'-Wl,'
-	    lt_prog_compiler_pic_CXX=3D'-fpic'
-	    lt_prog_compiler_static_CXX=3D'-Bstatic'
-	    ;;
-	  cxx*)
+	  cxx)
 	    # Compaq C++
 	    # Make sure the PIC flag is empty.  It appears that all Alpha
 	    # Linux and Compaq Tru64 Unix objects are PIC.
@@ -12495,7 +12004,7 @@
 	;;
       mvs*)
 	case $cc_basename in
-	  cxx*)
+	  cxx)
 	    lt_prog_compiler_pic_CXX=3D'-W c,exportall'
 	    ;;
 	  *)
@@ -12506,14 +12015,14 @@
 	;;
       osf3* | osf4* | osf5*)
 	case $cc_basename in
-	  KCC*)
+	  KCC)
 	    lt_prog_compiler_wl_CXX=3D'--backend -Wl,'
 	    ;;
-	  RCC*)
+	  RCC)
 	    # Rational C++ 2.4.1
 	    lt_prog_compiler_pic_CXX=3D'-pic'
 	    ;;
-	  cxx*)
+	  cxx)
 	    # Digital/Compaq C++
 	    lt_prog_compiler_wl_CXX=3D'-Wl,'
 	    # Make sure the PIC flag is empty.  It appears that all Alpha
@@ -12527,15 +12036,24 @@
 	;;
       psos*)
 	;;
+      sco*)
+	case $cc_basename in
+	  CC)
+	    lt_prog_compiler_pic_CXX=3D'-fPIC'
+	    ;;
+	  *)
+	    ;;
+	esac
+	;;
       solaris*)
 	case $cc_basename in
-	  CC*)
+	  CC)
 	    # Sun C++ 4.2, 5.x and Centerline C++
 	    lt_prog_compiler_pic_CXX=3D'-KPIC'
 	    lt_prog_compiler_static_CXX=3D'-Bstatic'
 	    lt_prog_compiler_wl_CXX=3D'-Qoption ld '
 	    ;;
-	  gcx*)
+	  gcx)
 	    # Green Hills C++ Compiler
 	    lt_prog_compiler_pic_CXX=3D'-PIC'
 	    ;;
@@ -12545,12 +12063,12 @@
 	;;
       sunos4*)
 	case $cc_basename in
-	  CC*)
+	  CC)
 	    # Sun C++ 4.x
 	    lt_prog_compiler_pic_CXX=3D'-pic'
 	    lt_prog_compiler_static_CXX=3D'-Bstatic'
 	    ;;
-	  lcc*)
+	  lcc)
 	    # Lucid
 	    lt_prog_compiler_pic_CXX=3D'-pic'
 	    ;;
@@ -12560,7 +12078,7 @@
 	;;
       tandem*)
 	case $cc_basename in
-	  NCC*)
+	  NCC)
 	    # NonStop-UX NCC 3.20
 	    lt_prog_compiler_pic_CXX=3D'-KPIC'
 	    ;;
@@ -12568,14 +12086,7 @@
 	    ;;
 	esac
 	;;
-      sysv5* | unixware* | sco3.2v5* | sco5v6* | OpenUNIX*)
-	case $cc_basename in
-	  CC*)
-	    lt_prog_compiler_wl_CXX=3D'-Wl,'
-	    lt_prog_compiler_pic_CXX=3D'-KPIC'
-	    lt_prog_compiler_static_CXX=3D'-Bstatic'
-	    ;;
-	esac
+      unixware*)
 	;;
       vxworks*)
 	;;
@@ -12608,20 +12119,18 @@
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    # The option is referenced via a variable to avoid confusing sed.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [^ ]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
-   (eval echo "\"\$as_me:12614: $lt_compile\"" >&5)
+   (eval echo "\"\$as_me:12125: $lt_compile\"" >&5)
    (eval "$lt_compile" 2>conftest.err)
    ac_status=3D$?
    cat conftest.err >&5
-   echo "$as_me:12618: \$? =3D $ac_status" >&5
+   echo "$as_me:12129: \$? =3D $ac_status" >&5
    if (exit $ac_status) && test -s "$ac_outfile"; then
      # The compiler can only warn and ignore the option if not recognize=
d
-     # So say no if there are warnings other than the usual output.
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' >conftest.exp
-     $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-     if test ! -s conftest.er2 || diff conftest.exp conftest.er2 >/dev/n=
ull; then
+     # So say no if there are warnings
+     if test ! -s conftest.err; then
        lt_prog_compiler_pic_works_CXX=3Dyes
      fi
    fi
@@ -12642,7 +12151,7 @@
 fi
=20
 fi
-case $host_os in
+case "$host_os" in
   # For platforms which do not support PIC, -DPIC is meaningless:
   *djgpp*)
     lt_prog_compiler_pic_CXX=3D
@@ -12652,48 +12161,6 @@
     ;;
 esac
=20
-#
-# Check to make sure the static flag actually works.
-#
-wl=3D$lt_prog_compiler_wl_CXX eval lt_tmp_static_flag=3D\"$lt_prog_compi=
ler_static_CXX\"
-echo "$as_me:$LINENO: checking if $compiler static flag $lt_tmp_static_f=
lag works" >&5
-echo $ECHO_N "checking if $compiler static flag $lt_tmp_static_flag work=
s... $ECHO_C" >&6
-if test "${lt_prog_compiler_static_works_CXX+set}" =3D set; then
-  echo $ECHO_N "(cached) $ECHO_C" >&6
-else
-  lt_prog_compiler_static_works_CXX=3Dno
-   save_LDFLAGS=3D"$LDFLAGS"
-   LDFLAGS=3D"$LDFLAGS $lt_tmp_static_flag"
-   printf "$lt_simple_link_test_code" > conftest.$ac_ext
-   if (eval $ac_link 2>conftest.err) && test -s conftest$ac_exeext; then
-     # The linker can only warn and ignore the option if not recognized
-     # So say no if there are warnings
-     if test -s conftest.err; then
-       # Append any errors to the config.log.
-       cat conftest.err 1>&5
-       $echo "X$_lt_linker_boilerplate" | $Xsed -e '/^$/d' > conftest.ex=
p
-       $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-       if diff conftest.exp conftest.er2 >/dev/null; then
-         lt_prog_compiler_static_works_CXX=3Dyes
-       fi
-     else
-       lt_prog_compiler_static_works_CXX=3Dyes
-     fi
-   fi
-   $rm conftest*
-   LDFLAGS=3D"$save_LDFLAGS"
-
-fi
-echo "$as_me:$LINENO: result: $lt_prog_compiler_static_works_CXX" >&5
-echo "${ECHO_T}$lt_prog_compiler_static_works_CXX" >&6
-
-if test x"$lt_prog_compiler_static_works_CXX" =3D xyes; then
-    :
-else
-    lt_prog_compiler_static_CXX=3D
-fi
-
-
 echo "$as_me:$LINENO: checking if $compiler supports -c -o file.$ac_obje=
xt" >&5
 echo $ECHO_N "checking if $compiler supports -c -o file.$ac_objext... $E=
CHO_C" >&6
 if test "${lt_cv_prog_compiler_c_o_CXX+set}" =3D set; then
@@ -12712,25 +12179,23 @@
    # Note that $ac_compile itself does not contain backslashes and begin=
s
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [^ ]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
-   (eval echo "\"\$as_me:12718: $lt_compile\"" >&5)
+   (eval echo "\"\$as_me:12185: $lt_compile\"" >&5)
    (eval "$lt_compile" 2>out/conftest.err)
    ac_status=3D$?
    cat out/conftest.err >&5
-   echo "$as_me:12722: \$? =3D $ac_status" >&5
+   echo "$as_me:12189: \$? =3D $ac_status" >&5
    if (exit $ac_status) && test -s out/conftest2.$ac_objext
    then
      # The compiler can only warn and ignore the option if not recognize=
d
      # So say no if there are warnings
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' > out/conftes=
t.exp
-     $SED '/^$/d; /^ *+/d' out/conftest.err >out/conftest.er2
-     if test ! -s out/conftest.er2 || diff out/conftest.exp out/conftest=
.er2 >/dev/null; then
+     if test ! -s out/conftest.err; then
        lt_cv_prog_compiler_c_o_CXX=3Dyes
      fi
    fi
-   chmod u+w . 2>&5
+   chmod u+w .
    $rm conftest*
    # SGI C++ compiler will create directory out/ii_files/ for
    # template instantiation
@@ -12785,11 +12250,8 @@
     export_symbols_cmds_CXX=3D"$ltdll_cmds"
   ;;
   cygwin* | mingw*)
-    export_symbols_cmds_CXX=3D'$NM $libobjs $convenience | $global_symbo=
l_pipe | $SED -e '\''/^[BCDGRS] /s/.* \([^ ]*\)/\1 DATA/;/^.* __nm__/s/^.=
* __nm__\([^ ]*\) [^ ]*/\1 DATA/;/^I /d;/^[AITW] /s/.* //'\'' | sort | un=
iq > $export_symbols'
+    export_symbols_cmds_CXX=3D'$NM $libobjs $convenience | $global_symbo=
l_pipe | $SED -e '\''/^[BCDGS] /s/.* \([^ ]*\)/\1 DATA/'\'' | $SED -e '\'=
'/^[AITW] /s/.* //'\'' | sort | uniq > $export_symbols'
   ;;
-  kfreebsd*-gnu)
-    link_all_deplibs_CXX=3Dno
-  ;;
   linux*)
     link_all_deplibs_CXX=3Dno
   ;;
@@ -12802,6 +12264,11 @@
 echo "${ECHO_T}$ld_shlibs_CXX" >&6
 test "$ld_shlibs_CXX" =3D no && can_build_shared=3Dno
=20
+variables_saved_for_relink=3D"PATH $shlibpath_var $runpath_var"
+if test "$GCC" =3D yes; then
+  variables_saved_for_relink=3D"$variables_saved_for_relink GCC_EXEC_PRE=
FIX COMPILER_PATH LIBRARY_PATH"
+fi
+
 #
 # Do we need to explicitly link libc?
 #
@@ -12834,7 +12301,6 @@
         libobjs=3Dconftest.$ac_objext
         deplibs=3D
         wl=3D$lt_prog_compiler_wl_CXX
-	pic_flag=3D$lt_prog_compiler_pic_CXX
         compiler_flags=3D-v
         linker_flags=3D-v
         verstring=3D
@@ -12967,7 +12433,7 @@
   shlibpath_var=3DLIBRARY_PATH
   ;;
=20
-bsdi[45]*)
+bsdi4*)
   version_type=3Dlinux
   need_version=3Dno
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
@@ -12995,8 +12461,7 @@
       dlpath=3D`$SHELL 2>&1 -c '\''. $dir/'\''\${base_file}'\''i;echo \$=
dlname'\''`~
       dldir=3D$destdir/`dirname \$dlpath`~
       test -d \$dldir || mkdir -p \$dldir~
-      $install_prog $dir/$dlname \$dldir/$dlname~
-      chmod a+x \$dldir/$dlname'
+      $install_prog $dir/$dlname \$dldir/$dlname'
     postuninstall_cmds=3D'dldll=3D`$SHELL 2>&1 -c '\''. $file; echo \$dl=
name'\''`~
       dlpath=3D$dir/\$dldll~
        $rm \$dlpath'
@@ -13026,7 +12491,7 @@
       ;;
     pw32*)
       # pw32 DLLs use 'pw' prefix rather than 'lib'
-      library_names_spec=3D'`echo ${libname} | sed -e 's/^lib/pw/'``echo=
 ${release} | $SED -e 's/[.]/-/g'`${versuffix}${shared_ext}'
+      library_names_spec=3D'`echo ${libname} | sed -e 's/^lib/pw/'``echo=
 ${release} | $SED -e 's/./-/g'`${versuffix}${shared_ext}'
       ;;
     esac
     ;;
@@ -13049,7 +12514,7 @@
   soname_spec=3D'${libname}${release}${major}$shared_ext'
   shlibpath_overrides_runpath=3Dyes
   shlibpath_var=3DDYLD_LIBRARY_PATH
-  shrext_cmds=3D'`test .$module =3D .yes && echo .so || echo .dylib`'
+  shrext_cmds=3D'$(test .$module =3D .yes && echo .so || echo .dylib)'
   # Apple's gcc prints 'gcc -print-search-dirs' doesn't operate the same=
=2E
   if test "$GCC" =3D yes; then
     sys_lib_search_path_spec=3D`$CC -print-search-dirs | tr "\n" "$PATH_=
SEPARATOR" | sed -e 's/libraries:/@libraries:/' | tr "@" "\n" | grep "^li=
braries:" | sed -e "s/^libraries://" -e "s,=3D/,/,g" -e "s,$PATH_SEPARATO=
R, ,g" -e "s,.*,& /lib /usr/lib /usr/local/lib,g"`
@@ -13084,17 +12549,8 @@
   dynamic_linker=3D'GNU ld.so'
   ;;
=20
-freebsd* | dragonfly*)
-  # DragonFly does not have aout.  When/if they implement a new
-  # versioning mechanism, adjust this.
-  if test -x /usr/bin/objformat; then
-    objformat=3D`/usr/bin/objformat`
-  else
-    case $host_os in
-    freebsd[123]*) objformat=3Daout ;;
-    *) objformat=3Delf ;;
-    esac
-  fi
+freebsd*)
+  objformat=3D`test -x /usr/bin/objformat && /usr/bin/objformat || echo =
aout`
   version_type=3Dfreebsd-$objformat
   case $version_type in
     freebsd-elf*)
@@ -13112,19 +12568,14 @@
   freebsd2*)
     shlibpath_overrides_runpath=3Dyes
     ;;
-  freebsd3.[01]* | freebsdelf3.[01]*)
+  freebsd3.01* | freebsdelf3.01*)
     shlibpath_overrides_runpath=3Dyes
     hardcode_into_libs=3Dyes
     ;;
-  freebsd3.[2-9]* | freebsdelf3.[2-9]* | \
-  freebsd4.[0-5] | freebsdelf4.[0-5] | freebsd4.1.1 | freebsdelf4.1.1)
+  *) # from 3.2 on
     shlibpath_overrides_runpath=3Dno
     hardcode_into_libs=3Dyes
     ;;
-  freebsd*) # from 4.6 on
-    shlibpath_overrides_runpath=3Dyes
-    hardcode_into_libs=3Dyes
-    ;;
   esac
   ;;
=20
@@ -13144,7 +12595,7 @@
   version_type=3Dsunos
   need_lib_prefix=3Dno
   need_version=3Dno
-  case $host_cpu in
+  case "$host_cpu" in
   ia64*)
     shrext_cmds=3D'.so'
     hardcode_into_libs=3Dyes
@@ -13184,18 +12635,6 @@
   postinstall_cmds=3D'chmod 555 $lib'
   ;;
=20
-interix3*)
-  version_type=3Dlinux
-  need_lib_prefix=3Dno
-  need_version=3Dno
-  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major ${libname}${shared_ext}'
-  soname_spec=3D'${libname}${release}${shared_ext}$major'
-  dynamic_linker=3D'Interix 3.x ld.so.1 (PE, like ELF)'
-  shlibpath_var=3DLD_LIBRARY_PATH
-  shlibpath_overrides_runpath=3Dno
-  hardcode_into_libs=3Dyes
-  ;;
-
 irix5* | irix6* | nonstopux*)
   case $host_os in
     nonstopux*) version_type=3Dnonstopux ;;
@@ -13255,7 +12694,7 @@
=20
   # Append ld.so.conf contents to the search path
   if test -f /etc/ld.so.conf; then
-    lt_ld_extra=3D`awk '/^include / { system(sprintf("cd /etc; cat %s", =
\$2)); skip =3D 1; } { if (!skip) print \$0; skip =3D 0; }' < /etc/ld.so.=
conf | $SED -e 's/#.*//;s/[:,	]/ /g;s/=3D[^=3D]*$//;s/=3D[^=3D ]* / /g;/^=
$/d' | tr '\n' ' '`
+    lt_ld_extra=3D`$SED -e 's/:,\t/ /g;s/=3D^=3D*$//;s/=3D^=3D * / /g' /=
etc/ld.so.conf | tr '\n' ' '`
     sys_lib_dlsearch_path_spec=3D"/lib /usr/lib $lt_ld_extra"
   fi
=20
@@ -13329,13 +12768,8 @@
=20
 openbsd*)
   version_type=3Dsunos
-  sys_lib_dlsearch_path_spec=3D"/usr/lib"
   need_lib_prefix=3Dno
-  # Some older versions of OpenBSD (3.3 at least) *do* need versioned li=
bs.
-  case $host_os in
-    openbsd3.3 | openbsd3.3.*) need_version=3Dyes ;;
-    *)                         need_version=3Dno  ;;
-  esac
+  need_version=3Dyes
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${shared_ext}$versuffix'
   finish_cmds=3D'PATH=3D"\$PATH:/sbin" ldconfig -m $libdir'
   shlibpath_var=3DLD_LIBRARY_PATH
@@ -13373,6 +12807,13 @@
   sys_lib_dlsearch_path_spec=3D"$sys_lib_search_path_spec"
   ;;
=20
+sco3.2v5*)
+  version_type=3Dosf
+  soname_spec=3D'${libname}${release}${shared_ext}$major'
+  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
+  shlibpath_var=3DLD_LIBRARY_PATH
+  ;;
+
 solaris*)
   version_type=3Dlinux
   need_lib_prefix=3Dno
@@ -13398,7 +12839,7 @@
   need_version=3Dyes
   ;;
=20
-sysv4 | sysv4.3*)
+sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
   version_type=3Dlinux
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
   soname_spec=3D'${libname}${release}${shared_ext}$major'
@@ -13431,29 +12872,6 @@
   fi
   ;;
=20
-sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX* | sysv4*uw2*)
-  version_type=3Dfreebsd-elf
-  need_lib_prefix=3Dno
-  need_version=3Dno
-  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext} $libname${shared_ext}'
-  soname_spec=3D'${libname}${release}${shared_ext}$major'
-  shlibpath_var=3DLD_LIBRARY_PATH
-  hardcode_into_libs=3Dyes
-  if test "$with_gnu_ld" =3D yes; then
-    sys_lib_search_path_spec=3D'/usr/local/lib /usr/gnu/lib /usr/ccs/lib=
 /usr/lib /lib'
-    shlibpath_overrides_runpath=3Dno
-  else
-    sys_lib_search_path_spec=3D'/usr/ccs/lib /usr/lib'
-    shlibpath_overrides_runpath=3Dyes
-    case $host_os in
-      sco3.2v5*)
-        sys_lib_search_path_spec=3D"$sys_lib_search_path_spec /lib"
-	;;
-    esac
-  fi
-  sys_lib_dlsearch_path_spec=3D'/usr/lib'
-  ;;
-
 uts4*)
   version_type=3Dlinux
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
@@ -13469,17 +12887,12 @@
 echo "${ECHO_T}$dynamic_linker" >&6
 test "$dynamic_linker" =3D no && can_build_shared=3Dno
=20
-variables_saved_for_relink=3D"PATH $shlibpath_var $runpath_var"
-if test "$GCC" =3D yes; then
-  variables_saved_for_relink=3D"$variables_saved_for_relink GCC_EXEC_PRE=
FIX COMPILER_PATH LIBRARY_PATH"
-fi
-
 echo "$as_me:$LINENO: checking how to hardcode library paths into progra=
ms" >&5
 echo $ECHO_N "checking how to hardcode library paths into programs... $E=
CHO_C" >&6
 hardcode_action_CXX=3D
 if test -n "$hardcode_libdir_flag_spec_CXX" || \
-   test -n "$runpath_var_CXX" || \
-   test "X$hardcode_automatic_CXX" =3D "Xyes" ; then
+   test -n "$runpath_var CXX" || \
+   test "X$hardcode_automatic_CXX"=3D"Xyes" ; then
=20
   # We can hardcode non-existant directories.
   if test "$hardcode_direct_CXX" !=3D no &&
@@ -13511,7 +12924,835 @@
   enable_fast_install=3Dneedless
 fi
=20
+striplib=3D
+old_striplib=3D
+echo "$as_me:$LINENO: checking whether stripping libraries is possible" =
>&5
+echo $ECHO_N "checking whether stripping libraries is possible... $ECHO_=
C" >&6
+if test -n "$STRIP" && $STRIP -V 2>&1 | grep "GNU strip" >/dev/null; the=
n
+  test -z "$old_striplib" && old_striplib=3D"$STRIP --strip-debug"
+  test -z "$striplib" && striplib=3D"$STRIP --strip-unneeded"
+  echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6
+else
+# FIXME - insert some real tests, host_os isn't really good enough
+  case $host_os in
+   darwin*)
+       if test -n "$STRIP" ; then
+         striplib=3D"$STRIP -x"
+         echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6
+       else
+  echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6
+fi
+       ;;
+   *)
+  echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6
+    ;;
+  esac
+fi
=20
+if test "x$enable_dlopen" !=3D xyes; then
+  enable_dlopen=3Dunknown
+  enable_dlopen_self=3Dunknown
+  enable_dlopen_self_static=3Dunknown
+else
+  lt_cv_dlopen=3Dno
+  lt_cv_dlopen_libs=3D
+
+  case $host_os in
+  beos*)
+    lt_cv_dlopen=3D"load_add_on"
+    lt_cv_dlopen_libs=3D
+    lt_cv_dlopen_self=3Dyes
+    ;;
+
+  mingw* | pw32*)
+    lt_cv_dlopen=3D"LoadLibrary"
+    lt_cv_dlopen_libs=3D
+   ;;
+
+  cygwin*)
+    lt_cv_dlopen=3D"dlopen"
+    lt_cv_dlopen_libs=3D
+   ;;
+
+  darwin*)
+  # if libdl is installed we need to link against it
+    echo "$as_me:$LINENO: checking for dlopen in -ldl" >&5
+echo $ECHO_N "checking for dlopen in -ldl... $ECHO_C" >&6
+if test "${ac_cv_lib_dl_dlopen+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-ldl  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char dlopen ();
+int
+main ()
+{
+dlopen ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_cxx_werror_flag"			 || test ! -s conftest.err=
'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_lib_dl_dlopen=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_lib_dl_dlopen=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+echo "$as_me:$LINENO: result: $ac_cv_lib_dl_dlopen" >&5
+echo "${ECHO_T}$ac_cv_lib_dl_dlopen" >&6
+if test $ac_cv_lib_dl_dlopen =3D yes; then
+  lt_cv_dlopen=3D"dlopen" lt_cv_dlopen_libs=3D"-ldl"
+else
+
+    lt_cv_dlopen=3D"dyld"
+    lt_cv_dlopen_libs=3D
+    lt_cv_dlopen_self=3Dyes
+
+fi
+
+   ;;
+
+  *)
+    echo "$as_me:$LINENO: checking for shl_load" >&5
+echo $ECHO_N "checking for shl_load... $ECHO_C" >&6
+if test "${ac_cv_func_shl_load+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+/* Define shl_load to an innocuous variant, in case <limits.h> declares =
shl_load.
+   For example, HP-UX 11i <limits.h> declares gettimeofday.  */
+#define shl_load innocuous_shl_load
+
+/* System header to define __stub macros and hopefully few prototypes,
+    which can conflict with char shl_load (); below.
+    Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+    <limits.h> exists even on freestanding compilers.  */
+
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+
+#undef shl_load
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char shl_load ();
+/* The GNU C library defines this for functions which it implements
+    to always fail with ENOSYS.  Some functions are actually named
+    something starting with __ and the normal name is an alias.  */
+#if defined (__stub_shl_load) || defined (__stub___shl_load)
+choke me
+#else
+char (*f) () =3D shl_load;
+#endif
+#ifdef __cplusplus
+}
+#endif
+
+int
+main ()
+{
+return f !=3D shl_load;
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_cxx_werror_flag"			 || test ! -s conftest.err=
'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_func_shl_load=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_func_shl_load=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+fi
+echo "$as_me:$LINENO: result: $ac_cv_func_shl_load" >&5
+echo "${ECHO_T}$ac_cv_func_shl_load" >&6
+if test $ac_cv_func_shl_load =3D yes; then
+  lt_cv_dlopen=3D"shl_load"
+else
+  echo "$as_me:$LINENO: checking for shl_load in -ldld" >&5
+echo $ECHO_N "checking for shl_load in -ldld... $ECHO_C" >&6
+if test "${ac_cv_lib_dld_shl_load+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-ldld  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char shl_load ();
+int
+main ()
+{
+shl_load ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_cxx_werror_flag"			 || test ! -s conftest.err=
'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_lib_dld_shl_load=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_lib_dld_shl_load=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+echo "$as_me:$LINENO: result: $ac_cv_lib_dld_shl_load" >&5
+echo "${ECHO_T}$ac_cv_lib_dld_shl_load" >&6
+if test $ac_cv_lib_dld_shl_load =3D yes; then
+  lt_cv_dlopen=3D"shl_load" lt_cv_dlopen_libs=3D"-dld"
+else
+  echo "$as_me:$LINENO: checking for dlopen" >&5
+echo $ECHO_N "checking for dlopen... $ECHO_C" >&6
+if test "${ac_cv_func_dlopen+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+/* Define dlopen to an innocuous variant, in case <limits.h> declares dl=
open.
+   For example, HP-UX 11i <limits.h> declares gettimeofday.  */
+#define dlopen innocuous_dlopen
+
+/* System header to define __stub macros and hopefully few prototypes,
+    which can conflict with char dlopen (); below.
+    Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+    <limits.h> exists even on freestanding compilers.  */
+
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+
+#undef dlopen
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char dlopen ();
+/* The GNU C library defines this for functions which it implements
+    to always fail with ENOSYS.  Some functions are actually named
+    something starting with __ and the normal name is an alias.  */
+#if defined (__stub_dlopen) || defined (__stub___dlopen)
+choke me
+#else
+char (*f) () =3D dlopen;
+#endif
+#ifdef __cplusplus
+}
+#endif
+
+int
+main ()
+{
+return f !=3D dlopen;
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_cxx_werror_flag"			 || test ! -s conftest.err=
'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_func_dlopen=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_func_dlopen=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+fi
+echo "$as_me:$LINENO: result: $ac_cv_func_dlopen" >&5
+echo "${ECHO_T}$ac_cv_func_dlopen" >&6
+if test $ac_cv_func_dlopen =3D yes; then
+  lt_cv_dlopen=3D"dlopen"
+else
+  echo "$as_me:$LINENO: checking for dlopen in -ldl" >&5
+echo $ECHO_N "checking for dlopen in -ldl... $ECHO_C" >&6
+if test "${ac_cv_lib_dl_dlopen+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-ldl  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char dlopen ();
+int
+main ()
+{
+dlopen ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_cxx_werror_flag"			 || test ! -s conftest.err=
'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_lib_dl_dlopen=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_lib_dl_dlopen=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+echo "$as_me:$LINENO: result: $ac_cv_lib_dl_dlopen" >&5
+echo "${ECHO_T}$ac_cv_lib_dl_dlopen" >&6
+if test $ac_cv_lib_dl_dlopen =3D yes; then
+  lt_cv_dlopen=3D"dlopen" lt_cv_dlopen_libs=3D"-ldl"
+else
+  echo "$as_me:$LINENO: checking for dlopen in -lsvld" >&5
+echo $ECHO_N "checking for dlopen in -lsvld... $ECHO_C" >&6
+if test "${ac_cv_lib_svld_dlopen+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-lsvld  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char dlopen ();
+int
+main ()
+{
+dlopen ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_cxx_werror_flag"			 || test ! -s conftest.err=
'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_lib_svld_dlopen=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_lib_svld_dlopen=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+echo "$as_me:$LINENO: result: $ac_cv_lib_svld_dlopen" >&5
+echo "${ECHO_T}$ac_cv_lib_svld_dlopen" >&6
+if test $ac_cv_lib_svld_dlopen =3D yes; then
+  lt_cv_dlopen=3D"dlopen" lt_cv_dlopen_libs=3D"-lsvld"
+else
+  echo "$as_me:$LINENO: checking for dld_link in -ldld" >&5
+echo $ECHO_N "checking for dld_link in -ldld... $ECHO_C" >&6
+if test "${ac_cv_lib_dld_dld_link+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-ldld  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char dld_link ();
+int
+main ()
+{
+dld_link ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_cxx_werror_flag"			 || test ! -s conftest.err=
'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_lib_dld_dld_link=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_lib_dld_dld_link=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+echo "$as_me:$LINENO: result: $ac_cv_lib_dld_dld_link" >&5
+echo "${ECHO_T}$ac_cv_lib_dld_dld_link" >&6
+if test $ac_cv_lib_dld_dld_link =3D yes; then
+  lt_cv_dlopen=3D"dld_link" lt_cv_dlopen_libs=3D"-dld"
+fi
+
+
+fi
+
+
+fi
+
+
+fi
+
+
+fi
+
+
+fi
+
+    ;;
+  esac
+
+  if test "x$lt_cv_dlopen" !=3D xno; then
+    enable_dlopen=3Dyes
+  else
+    enable_dlopen=3Dno
+  fi
+
+  case $lt_cv_dlopen in
+  dlopen)
+    save_CPPFLAGS=3D"$CPPFLAGS"
+    test "x$ac_cv_header_dlfcn_h" =3D xyes && CPPFLAGS=3D"$CPPFLAGS -DHA=
VE_DLFCN_H"
+
+    save_LDFLAGS=3D"$LDFLAGS"
+    eval LDFLAGS=3D\"\$LDFLAGS $export_dynamic_flag_spec\"
+
+    save_LIBS=3D"$LIBS"
+    LIBS=3D"$lt_cv_dlopen_libs $LIBS"
+
+    echo "$as_me:$LINENO: checking whether a program can dlopen itself" =
>&5
+echo $ECHO_N "checking whether a program can dlopen itself... $ECHO_C" >=
&6
+if test "${lt_cv_dlopen_self+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  	  if test "$cross_compiling" =3D yes; then :
+  lt_cv_dlopen_self=3Dcross
+else
+  lt_dlunknown=3D0; lt_dlno_uscore=3D1; lt_dlneed_uscore=3D2
+  lt_status=3D$lt_dlunknown
+  cat > conftest.$ac_ext <<EOF
+#line 13554 "configure"
+#include "confdefs.h"
+
+#if HAVE_DLFCN_H
+#include <dlfcn.h>
+#endif
+
+#include <stdio.h>
+
+#ifdef RTLD_GLOBAL
+#  define LT_DLGLOBAL		RTLD_GLOBAL
+#else
+#  ifdef DL_GLOBAL
+#    define LT_DLGLOBAL		DL_GLOBAL
+#  else
+#    define LT_DLGLOBAL		0
+#  endif
+#endif
+
+/* We may have to define LT_DLLAZY_OR_NOW in the command line if we
+   find out it does not work in some platform. */
+#ifndef LT_DLLAZY_OR_NOW
+#  ifdef RTLD_LAZY
+#    define LT_DLLAZY_OR_NOW		RTLD_LAZY
+#  else
+#    ifdef DL_LAZY
+#      define LT_DLLAZY_OR_NOW		DL_LAZY
+#    else
+#      ifdef RTLD_NOW
+#        define LT_DLLAZY_OR_NOW	RTLD_NOW
+#      else
+#        ifdef DL_NOW
+#          define LT_DLLAZY_OR_NOW	DL_NOW
+#        else
+#          define LT_DLLAZY_OR_NOW	0
+#        endif
+#      endif
+#    endif
+#  endif
+#endif
+
+#ifdef __cplusplus
+extern "C" void exit (int);
+#endif
+
+void fnord() { int i=3D42;}
+int main ()
+{
+  void *self =3D dlopen (0, LT_DLGLOBAL|LT_DLLAZY_OR_NOW);
+  int status =3D $lt_dlunknown;
+
+  if (self)
+    {
+      if (dlsym (self,"fnord"))       status =3D $lt_dlno_uscore;
+      else if (dlsym( self,"_fnord")) status =3D $lt_dlneed_uscore;
+      /* dlclose (self); */
+    }
+
+    exit (status);
+}
+EOF
+  if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } && test -s conftest${ac_exeext} 2>/dev/null; then
+    (./conftest; exit; ) 2>/dev/null
+    lt_status=3D$?
+    case x$lt_status in
+      x$lt_dlno_uscore) lt_cv_dlopen_self=3Dyes ;;
+      x$lt_dlneed_uscore) lt_cv_dlopen_self=3Dyes ;;
+      x$lt_unknown|x*) lt_cv_dlopen_self=3Dno ;;
+    esac
+  else :
+    # compilation failed
+    lt_cv_dlopen_self=3Dno
+  fi
+fi
+rm -fr conftest*
+
+
+fi
+echo "$as_me:$LINENO: result: $lt_cv_dlopen_self" >&5
+echo "${ECHO_T}$lt_cv_dlopen_self" >&6
+
+    if test "x$lt_cv_dlopen_self" =3D xyes; then
+      LDFLAGS=3D"$LDFLAGS $link_static_flag"
+      echo "$as_me:$LINENO: checking whether a statically linked program=
 can dlopen itself" >&5
+echo $ECHO_N "checking whether a statically linked program can dlopen it=
self... $ECHO_C" >&6
+if test "${lt_cv_dlopen_self_static+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  	  if test "$cross_compiling" =3D yes; then :
+  lt_cv_dlopen_self_static=3Dcross
+else
+  lt_dlunknown=3D0; lt_dlno_uscore=3D1; lt_dlneed_uscore=3D2
+  lt_status=3D$lt_dlunknown
+  cat > conftest.$ac_ext <<EOF
+#line 13652 "configure"
+#include "confdefs.h"
+
+#if HAVE_DLFCN_H
+#include <dlfcn.h>
+#endif
+
+#include <stdio.h>
+
+#ifdef RTLD_GLOBAL
+#  define LT_DLGLOBAL		RTLD_GLOBAL
+#else
+#  ifdef DL_GLOBAL
+#    define LT_DLGLOBAL		DL_GLOBAL
+#  else
+#    define LT_DLGLOBAL		0
+#  endif
+#endif
+
+/* We may have to define LT_DLLAZY_OR_NOW in the command line if we
+   find out it does not work in some platform. */
+#ifndef LT_DLLAZY_OR_NOW
+#  ifdef RTLD_LAZY
+#    define LT_DLLAZY_OR_NOW		RTLD_LAZY
+#  else
+#    ifdef DL_LAZY
+#      define LT_DLLAZY_OR_NOW		DL_LAZY
+#    else
+#      ifdef RTLD_NOW
+#        define LT_DLLAZY_OR_NOW	RTLD_NOW
+#      else
+#        ifdef DL_NOW
+#          define LT_DLLAZY_OR_NOW	DL_NOW
+#        else
+#          define LT_DLLAZY_OR_NOW	0
+#        endif
+#      endif
+#    endif
+#  endif
+#endif
+
+#ifdef __cplusplus
+extern "C" void exit (int);
+#endif
+
+void fnord() { int i=3D42;}
+int main ()
+{
+  void *self =3D dlopen (0, LT_DLGLOBAL|LT_DLLAZY_OR_NOW);
+  int status =3D $lt_dlunknown;
+
+  if (self)
+    {
+      if (dlsym (self,"fnord"))       status =3D $lt_dlno_uscore;
+      else if (dlsym( self,"_fnord")) status =3D $lt_dlneed_uscore;
+      /* dlclose (self); */
+    }
+
+    exit (status);
+}
+EOF
+  if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } && test -s conftest${ac_exeext} 2>/dev/null; then
+    (./conftest; exit; ) 2>/dev/null
+    lt_status=3D$?
+    case x$lt_status in
+      x$lt_dlno_uscore) lt_cv_dlopen_self_static=3Dyes ;;
+      x$lt_dlneed_uscore) lt_cv_dlopen_self_static=3Dyes ;;
+      x$lt_unknown|x*) lt_cv_dlopen_self_static=3Dno ;;
+    esac
+  else :
+    # compilation failed
+    lt_cv_dlopen_self_static=3Dno
+  fi
+fi
+rm -fr conftest*
+
+
+fi
+echo "$as_me:$LINENO: result: $lt_cv_dlopen_self_static" >&5
+echo "${ECHO_T}$lt_cv_dlopen_self_static" >&6
+    fi
+
+    CPPFLAGS=3D"$save_CPPFLAGS"
+    LDFLAGS=3D"$save_LDFLAGS"
+    LIBS=3D"$save_LIBS"
+    ;;
+  esac
+
+  case $lt_cv_dlopen_self in
+  yes|no) enable_dlopen_self=3D$lt_cv_dlopen_self ;;
+  *) enable_dlopen_self=3Dunknown ;;
+  esac
+
+  case $lt_cv_dlopen_self_static in
+  yes|no) enable_dlopen_self_static=3D$lt_cv_dlopen_self_static ;;
+  *) enable_dlopen_self_static=3Dunknown ;;
+  esac
+fi
+
+
 # The else clause should only fire when bootstrapping the
 # libtool distribution, otherwise you forgot to ship ltmain.sh
 # with your package, and you will get complaints that there are
@@ -13525,7 +13766,7 @@
   # Now quote all the things that may contain metacharacters while being
   # careful not to overquote the AC_SUBSTed values.  We take copies of t=
he
   # variables and quote the copies for generation of the libtool script.
-  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC L=
TCFLAGS NM \
+  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC N=
M \
     SED SHELL STRIP \
     libname_spec library_names_spec soname_spec extract_expsyms_cmds \
     old_striplib striplib file_magic_cmd finish_cmds finish_eval \
@@ -13626,13 +13867,7 @@
 # The host system.
 host_alias=3D$host_alias
 host=3D$host
-host_os=3D$host_os
=20
-# The build system.
-build_alias=3D$build_alias
-build=3D$build
-build_os=3D$build_os
-
 # An echo program that does not interpret backslashes.
 echo=3D$lt_echo
=20
@@ -13643,9 +13878,6 @@
 # A C compiler.
 LTCC=3D$lt_LTCC
=20
-# LTCC compiler flags.
-LTCFLAGS=3D$lt_LTCFLAGS
-
 # A language-specific compiler.
 CC=3D$lt_compiler_CXX
=20
@@ -13711,7 +13943,7 @@
 # Does compiler simultaneously support -c and -o options?
 compiler_c_o=3D$lt_lt_cv_prog_compiler_c_o_CXX
=20
-# Must we lock files when doing compilation?
+# Must we lock files when doing compilation ?
 need_locks=3D$lt_need_locks
=20
 # Do we need the lib prefix for modules?
@@ -13988,43 +14220,17 @@
 # If no C compiler was specified, use CC.
 LTCC=3D${LTCC-"$CC"}
=20
-# If no C compiler flags were specified, use CFLAGS.
-LTCFLAGS=3D${LTCFLAGS-"$CFLAGS"}
-
 # Allow CC to be a program name with arguments.
 compiler=3D$CC
=20
=20
-# save warnings/boilerplate of simple test code
-ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_compile_test_code" >conftest.$ac_ext
-eval "$ac_compile" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_compiler_boilerplate=3D`cat conftest.err`
-$rm conftest*
-
-ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_link_test_code" >conftest.$ac_ext
-eval "$ac_link" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_linker_boilerplate=3D`cat conftest.err`
-$rm conftest*
-
-
 # Allow CC to be a program name with arguments.
 lt_save_CC=3D"$CC"
 CC=3D${F77-"f77"}
 compiler=3D$CC
 compiler_F77=3D$CC
-for cc_temp in $compiler""; do
-  case $cc_temp in
-    compile | *[\\/]compile | ccache | *[\\/]ccache ) ;;
-    distcc | *[\\/]distcc | purify | *[\\/]purify ) ;;
-    \-*) ;;
-    *) break;;
-  esac
-done
-cc_basename=3D`$echo "X$cc_temp" | $Xsed -e 's%.*/%%' -e "s%^$host_alias=
-%%"`
+cc_basename=3D`$echo X"$compiler" | $Xsed -e 's%^.*/%%'`
=20
-
 echo "$as_me:$LINENO: checking if libtool supports shared libraries" >&5
 echo $ECHO_N "checking if libtool supports shared libraries... $ECHO_C" =
>&6
 echo "$as_me:$LINENO: result: $can_build_shared" >&5
@@ -14036,7 +14242,7 @@
=20
 # On AIX, shared libraries and static libraries use the same namespace, =
and
 # are all built from PIC.
-case $host_os in
+case "$host_os" in
 aix3*)
   test "$enable_shared" =3D yes && enable_static=3Dno
   if test -n "$RANLIB"; then
@@ -14045,9 +14251,7 @@
   fi
   ;;
 aix4* | aix5*)
-  if test "$host_cpu" !=3D ia64 && test "$aix_use_runtimelinking" =3D no=
 ; then
-    test "$enable_shared" =3D yes && enable_static=3Dno
-  fi
+  test "$enable_shared" =3D yes && enable_static=3Dno
   ;;
 esac
 echo "$as_me:$LINENO: result: $enable_shared" >&5
@@ -14060,6 +14264,8 @@
 echo "$as_me:$LINENO: result: $enable_static" >&5
 echo "${ECHO_T}$enable_static" >&6
=20
+test "$ld_shlibs_F77" =3D no && can_build_shared=3Dno
+
 GCC_F77=3D"$G77"
 LD_F77=3D"$LD"
=20
@@ -14106,11 +14312,6 @@
       lt_prog_compiler_pic_F77=3D'-fno-common'
       ;;
=20
-    interix3*)
-      # Interix 3.x gcc -fpic/-fPIC options generate broken code.
-      # Instead, we relocate shared libraries at runtime.
-      ;;
-
     msdosdjgpp*)
       # Just because we use GCC doesn't mean we suddenly get shared libr=
aries
       # on systems that don't support them.
@@ -14127,7 +14328,7 @@
     hpux*)
       # PIC is the default for IA64 HP-UX and 64-bit HP-UX, but
       # not for PA HP-UX.
-      case $host_cpu in
+      case "$host_cpu" in
       hppa*64*|ia64*)
 	# +Z the default
 	;;
@@ -14153,16 +14354,6 @@
 	lt_prog_compiler_static_F77=3D'-bnso -bI:/lib/syscalls.exp'
       fi
       ;;
-      darwin*)
-        # PIC is the default on this platform
-        # Common symbols not allowed in MH_DYLIB files
-       case $cc_basename in
-         xlc*)
-         lt_prog_compiler_pic_F77=3D'-qnocommon'
-         lt_prog_compiler_wl_F77=3D'-Wl,'
-         ;;
-       esac
-       ;;
=20
     mingw* | pw32* | os2*)
       # This hack is so that the source file can tell whether it is bein=
g
@@ -14174,7 +14365,7 @@
       lt_prog_compiler_wl_F77=3D'-Wl,'
       # PIC is the default for IA64 HP-UX and 64-bit HP-UX, but
       # not for PA HP-UX.
-      case $host_cpu in
+      case "$host_cpu" in
       hppa*64*|ia64*)
 	# +Z the default
 	;;
@@ -14198,19 +14389,12 @@
       ;;
=20
     linux*)
-      case $cc_basename in
+      case $CC in
       icc* | ecc*)
 	lt_prog_compiler_wl_F77=3D'-Wl,'
 	lt_prog_compiler_pic_F77=3D'-KPIC'
 	lt_prog_compiler_static_F77=3D'-static'
         ;;
-      pgcc* | pgf77* | pgf90* | pgf95*)
-        # Portland Group compilers (*not* the Pentium gcc compiler,
-	# which looks to be a dead project)
-	lt_prog_compiler_wl_F77=3D'-Wl,'
-	lt_prog_compiler_pic_F77=3D'-fpic'
-	lt_prog_compiler_static_F77=3D'-Bstatic'
-        ;;
       ccc*)
         lt_prog_compiler_wl_F77=3D'-Wl,'
         # All Alpha code is PIC.
@@ -14225,15 +14409,15 @@
       lt_prog_compiler_static_F77=3D'-non_shared'
       ;;
=20
+    sco3.2v5*)
+      lt_prog_compiler_pic_F77=3D'-Kpic'
+      lt_prog_compiler_static_F77=3D'-dn'
+      ;;
+
     solaris*)
+      lt_prog_compiler_wl_F77=3D'-Wl,'
       lt_prog_compiler_pic_F77=3D'-KPIC'
       lt_prog_compiler_static_F77=3D'-Bstatic'
-      case $cc_basename in
-      f77* | f90* | f95*)
-	lt_prog_compiler_wl_F77=3D'-Qoption ld ';;
-      *)
-	lt_prog_compiler_wl_F77=3D'-Wl,';;
-      esac
       ;;
=20
     sunos4*)
@@ -14242,7 +14426,7 @@
       lt_prog_compiler_static_F77=3D'-Bstatic'
       ;;
=20
-    sysv4 | sysv4.2uw2* | sysv4.3*)
+    sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
       lt_prog_compiler_wl_F77=3D'-Wl,'
       lt_prog_compiler_pic_F77=3D'-KPIC'
       lt_prog_compiler_static_F77=3D'-Bstatic'
@@ -14255,17 +14439,6 @@
       fi
       ;;
=20
-    sysv5* | unixware* | sco3.2v5* | sco5v6* | OpenUNIX*)
-      lt_prog_compiler_wl_F77=3D'-Wl,'
-      lt_prog_compiler_pic_F77=3D'-KPIC'
-      lt_prog_compiler_static_F77=3D'-Bstatic'
-      ;;
-
-    unicos*)
-      lt_prog_compiler_wl_F77=3D'-Wl,'
-      lt_prog_compiler_can_build_shared_F77=3Dno
-      ;;
-
     uts4*)
       lt_prog_compiler_pic_F77=3D'-pic'
       lt_prog_compiler_static_F77=3D'-Bstatic'
@@ -14300,20 +14473,18 @@
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    # The option is referenced via a variable to avoid confusing sed.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [^ ]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
-   (eval echo "\"\$as_me:14306: $lt_compile\"" >&5)
+   (eval echo "\"\$as_me:14479: $lt_compile\"" >&5)
    (eval "$lt_compile" 2>conftest.err)
    ac_status=3D$?
    cat conftest.err >&5
-   echo "$as_me:14310: \$? =3D $ac_status" >&5
+   echo "$as_me:14483: \$? =3D $ac_status" >&5
    if (exit $ac_status) && test -s "$ac_outfile"; then
      # The compiler can only warn and ignore the option if not recognize=
d
-     # So say no if there are warnings other than the usual output.
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' >conftest.exp
-     $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-     if test ! -s conftest.er2 || diff conftest.exp conftest.er2 >/dev/n=
ull; then
+     # So say no if there are warnings
+     if test ! -s conftest.err; then
        lt_prog_compiler_pic_works_F77=3Dyes
      fi
    fi
@@ -14334,7 +14505,7 @@
 fi
=20
 fi
-case $host_os in
+case "$host_os" in
   # For platforms which do not support PIC, -DPIC is meaningless:
   *djgpp*)
     lt_prog_compiler_pic_F77=3D
@@ -14344,48 +14515,6 @@
     ;;
 esac
=20
-#
-# Check to make sure the static flag actually works.
-#
-wl=3D$lt_prog_compiler_wl_F77 eval lt_tmp_static_flag=3D\"$lt_prog_compi=
ler_static_F77\"
-echo "$as_me:$LINENO: checking if $compiler static flag $lt_tmp_static_f=
lag works" >&5
-echo $ECHO_N "checking if $compiler static flag $lt_tmp_static_flag work=
s... $ECHO_C" >&6
-if test "${lt_prog_compiler_static_works_F77+set}" =3D set; then
-  echo $ECHO_N "(cached) $ECHO_C" >&6
-else
-  lt_prog_compiler_static_works_F77=3Dno
-   save_LDFLAGS=3D"$LDFLAGS"
-   LDFLAGS=3D"$LDFLAGS $lt_tmp_static_flag"
-   printf "$lt_simple_link_test_code" > conftest.$ac_ext
-   if (eval $ac_link 2>conftest.err) && test -s conftest$ac_exeext; then
-     # The linker can only warn and ignore the option if not recognized
-     # So say no if there are warnings
-     if test -s conftest.err; then
-       # Append any errors to the config.log.
-       cat conftest.err 1>&5
-       $echo "X$_lt_linker_boilerplate" | $Xsed -e '/^$/d' > conftest.ex=
p
-       $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-       if diff conftest.exp conftest.er2 >/dev/null; then
-         lt_prog_compiler_static_works_F77=3Dyes
-       fi
-     else
-       lt_prog_compiler_static_works_F77=3Dyes
-     fi
-   fi
-   $rm conftest*
-   LDFLAGS=3D"$save_LDFLAGS"
-
-fi
-echo "$as_me:$LINENO: result: $lt_prog_compiler_static_works_F77" >&5
-echo "${ECHO_T}$lt_prog_compiler_static_works_F77" >&6
-
-if test x"$lt_prog_compiler_static_works_F77" =3D xyes; then
-    :
-else
-    lt_prog_compiler_static_F77=3D
-fi
-
-
 echo "$as_me:$LINENO: checking if $compiler supports -c -o file.$ac_obje=
xt" >&5
 echo $ECHO_N "checking if $compiler supports -c -o file.$ac_objext... $E=
CHO_C" >&6
 if test "${lt_cv_prog_compiler_c_o_F77+set}" =3D set; then
@@ -14404,25 +14533,23 @@
    # Note that $ac_compile itself does not contain backslashes and begin=
s
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [^ ]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
-   (eval echo "\"\$as_me:14410: $lt_compile\"" >&5)
+   (eval echo "\"\$as_me:14539: $lt_compile\"" >&5)
    (eval "$lt_compile" 2>out/conftest.err)
    ac_status=3D$?
    cat out/conftest.err >&5
-   echo "$as_me:14414: \$? =3D $ac_status" >&5
+   echo "$as_me:14543: \$? =3D $ac_status" >&5
    if (exit $ac_status) && test -s out/conftest2.$ac_objext
    then
      # The compiler can only warn and ignore the option if not recognize=
d
      # So say no if there are warnings
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' > out/conftes=
t.exp
-     $SED '/^$/d; /^ *+/d' out/conftest.err >out/conftest.er2
-     if test ! -s out/conftest.er2 || diff out/conftest.exp out/conftest=
.er2 >/dev/null; then
+     if test ! -s out/conftest.err; then
        lt_cv_prog_compiler_c_o_F77=3Dyes
      fi
    fi
-   chmod u+w . 2>&5
+   chmod u+w .
    $rm conftest*
    # SGI C++ compiler will create directory out/ii_files/ for
    # template instantiation
@@ -14498,16 +14625,6 @@
   # rely on this symbol name, it's probably fine to never include it in
   # preloaded symbol tables.
   extract_expsyms_cmds=3D
-  # Just being paranoid about ensuring that cc_basename is set.
-  for cc_temp in $compiler""; do
-  case $cc_temp in
-    compile | *[\\/]compile | ccache | *[\\/]ccache ) ;;
-    distcc | *[\\/]distcc | purify | *[\\/]purify ) ;;
-    \-*) ;;
-    *) break;;
-  esac
-done
-cc_basename=3D`$echo "X$cc_temp" | $Xsed -e 's%.*/%%' -e "s%^$host_alias=
-%%"`
=20
   case $host_os in
   cygwin* | mingw* | pw32*)
@@ -14518,10 +14635,6 @@
       with_gnu_ld=3Dno
     fi
     ;;
-  interix*)
-    # we just hope/assume this is gcc and not c89 (=3D MSVC++)
-    with_gnu_ld=3Dyes
-    ;;
   openbsd*)
     with_gnu_ld=3Dno
     ;;
@@ -14532,27 +14645,6 @@
     # If archive_cmds runs LD, not CC, wlarc should be empty
     wlarc=3D'${wl}'
=20
-    # Set some defaults for GNU ld with shared library support. These
-    # are reset later if shared libraries are not supported. Putting the=
m
-    # here allows them to be overridden if necessary.
-    runpath_var=3DLD_RUN_PATH
-    hardcode_libdir_flag_spec_F77=3D'${wl}--rpath ${wl}$libdir'
-    export_dynamic_flag_spec_F77=3D'${wl}--export-dynamic'
-    # ancient GNU ld didn't support --whole-archive et. al.
-    if $LD --help 2>&1 | grep 'no-whole-archive' > /dev/null; then
-	whole_archive_flag_spec_F77=3D"$wlarc"'--whole-archive$convenience '"$w=
larc"'--no-whole-archive'
-      else
-  	whole_archive_flag_spec_F77=3D
-    fi
-    supports_anon_versioning=3Dno
-    case `$LD -v 2>/dev/null` in
-      *\ [01].* | *\ 2.[0-9].* | *\ 2.10.*) ;; # catch versions < 2.11
-      *\ 2.11.93.0.2\ *) supports_anon_versioning=3Dyes ;; # RH7.3 ...
-      *\ 2.11.92.0.12\ *) supports_anon_versioning=3Dyes ;; # Mandrake 8=
.2 ...
-      *\ 2.11.*) ;; # other 2.11 versions
-      *) supports_anon_versioning=3Dyes ;;
-    esac
-
     # See if GNU ld supports shared libraries.
     case $host_os in
     aix3* | aix4* | aix5*)
@@ -14603,10 +14695,10 @@
       allow_undefined_flag_F77=3Dunsupported
       always_export_symbols_F77=3Dno
       enable_shared_with_static_runtimes_F77=3Dyes
-      export_symbols_cmds_F77=3D'$NM $libobjs $convenience | $global_sym=
bol_pipe | $SED -e '\''/^[BCDGRS] /s/.* \([^ ]*\)/\1 DATA/'\'' | $SED -e =
'\''/^[AITW] /s/.* //'\'' | sort | uniq > $export_symbols'
+      export_symbols_cmds_F77=3D'$NM $libobjs $convenience | $global_sym=
bol_pipe | $SED -e '\''/^[BCDGS] /s/.* \([^ ]*\)/\1 DATA/'\'' | $SED -e '=
\''/^[AITW] /s/.* //'\'' | sort | uniq > $export_symbols'
=20
       if $LD --help 2>&1 | grep 'auto-import' > /dev/null; then
-        archive_cmds_F77=3D'$CC -shared $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--enable-auto-image-base -Xlinker --out-=
implib -Xlinker $lib'
+        archive_cmds_F77=3D'$CC -shared $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--image-base=3D0x10000000 ${wl}--out-imp=
lib,$lib'
 	# If the export-symbols file already is a .def file (1st line
 	# is EXPORTS), use it as is; otherwise, prepend...
 	archive_expsym_cmds_F77=3D'if test "x`$SED 1q $export_symbols`" =3D xEX=
PORTS; then
@@ -14615,59 +14707,12 @@
 	  echo EXPORTS > $output_objdir/$soname.def;
 	  cat $export_symbols >> $output_objdir/$soname.def;
 	fi~
-	$CC -shared $output_objdir/$soname.def $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--enable-auto-image-base -Xlinker --out-=
implib -Xlinker $lib'
+	$CC -shared $output_objdir/$soname.def $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--image-base=3D0x10000000  ${wl}--out-im=
plib,$lib'
       else
-	ld_shlibs_F77=3Dno
+	ld_shlibs=3Dno
       fi
       ;;
=20
-    interix3*)
-      hardcode_direct_F77=3Dno
-      hardcode_shlibpath_var_F77=3Dno
-      hardcode_libdir_flag_spec_F77=3D'${wl}-rpath,$libdir'
-      export_dynamic_flag_spec_F77=3D'${wl}-E'
-      # Hack: On Interix 3.x, we cannot compile PIC because of a broken =
gcc.
-      # Instead, shared libraries are loaded at an image base (0x1000000=
0 by
-      # default) and relocated if they conflict, which is a slow very me=
mory
-      # consuming and fragmenting process.  To avoid this, we pick a ran=
dom,
-      # 256 KiB-aligned image base between 0x50000000 and 0x6FFC0000 at =
link
-      # time.  Moving up from 0x10000000 also allows more sbrk(2) space.
-      archive_cmds_F77=3D'$CC -shared $pic_flag $libobjs $deplibs $compi=
ler_flags ${wl}-h,$soname ${wl}--image-base,`expr ${RANDOM-$$} % 4096 / 2=
 \* 262144 + 1342177280` -o $lib'
-      archive_expsym_cmds_F77=3D'sed "s,^,_," $export_symbols >$output_o=
bjdir/$soname.expsym~$CC -shared $pic_flag $libobjs $deplibs $compiler_fl=
ags ${wl}-h,$soname ${wl}--retain-symbols-file,$output_objdir/$soname.exp=
sym ${wl}--image-base,`expr ${RANDOM-$$} % 4096 / 2 \* 262144 + 134217728=
0` -o $lib'
-      ;;
-
-    linux*)
-      if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null=
; then
-	tmp_addflag=3D
-	case $cc_basename,$host_cpu in
-	pgcc*)				# Portland Group C compiler
-	  whole_archive_flag_spec_F77=3D'${wl}--whole-archive`for conv in $conv=
enience\"\"; do test  -n \"$conv\" && new_convenience=3D\"$new_convenienc=
e,$conv\"; done; $echo \"$new_convenience\"` ${wl}--no-whole-archive'
-	  tmp_addflag=3D' $pic_flag'
-	  ;;
-	pgf77* | pgf90* | pgf95*)	# Portland Group f77 and f90 compilers
-	  whole_archive_flag_spec_F77=3D'${wl}--whole-archive`for conv in $conv=
enience\"\"; do test  -n \"$conv\" && new_convenience=3D\"$new_convenienc=
e,$conv\"; done; $echo \"$new_convenience\"` ${wl}--no-whole-archive'
-	  tmp_addflag=3D' $pic_flag -Mnomain' ;;
-	ecc*,ia64* | icc*,ia64*)		# Intel C compiler on ia64
-	  tmp_addflag=3D' -i_dynamic' ;;
-	efc*,ia64* | ifort*,ia64*)	# Intel Fortran compiler on ia64
-	  tmp_addflag=3D' -i_dynamic -nofor_main' ;;
-	ifc* | ifort*)			# Intel Fortran compiler
-	  tmp_addflag=3D' -nofor_main' ;;
-	esac
-	archive_cmds_F77=3D'$CC -shared'"$tmp_addflag"' $libobjs $deplibs $comp=
iler_flags ${wl}-soname $wl$soname -o $lib'
-
-	if test $supports_anon_versioning =3D yes; then
-	  archive_expsym_cmds_F77=3D'$echo "{ global:" > $output_objdir/$libnam=
e.ver~
-  cat $export_symbols | sed -e "s/\(.*\)/\1;/" >> $output_objdir/$libnam=
e.ver~
-  $echo "local: *; };" >> $output_objdir/$libname.ver~
-	  $CC -shared'"$tmp_addflag"' $libobjs $deplibs $compiler_flags ${wl}-s=
oname $wl$soname ${wl}-version-script ${wl}$output_objdir/$libname.ver -o=
 $lib'
-	fi
-	link_all_deplibs_F77=3Dno
-      else
-	ld_shlibs_F77=3Dno
-      fi
-      ;;
-
     netbsd* | netbsdelf*-gnu | knetbsd*-gnu)
       if echo __ELF__ | $CC -E - | grep __ELF__ >/dev/null; then
 	archive_cmds_F77=3D'$LD -Bshareable $libobjs $deplibs $linker_flags -o =
$lib'
@@ -14678,7 +14723,7 @@
       fi
       ;;
=20
-    solaris*)
+    solaris* | sysv5*)
       if $LD -v 2>&1 | grep 'BFD 2\.8' > /dev/null; then
 	ld_shlibs_F77=3Dno
 	cat <<EOF 1>&2
@@ -14699,33 +14744,6 @@
       fi
       ;;
=20
-    sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX*)
-      case `$LD -v 2>&1` in
-        *\ [01].* | *\ 2.[0-9].* | *\ 2.1[0-5].*)
-	ld_shlibs_F77=3Dno
-	cat <<_LT_EOF 1>&2
-
-*** Warning: Releases of the GNU linker prior to 2.16.91.0.3 can not
-*** reliably create shared libraries on SCO systems.  Therefore, libtool
-*** is disabling shared libraries support.  We urge you to upgrade GNU
-*** binutils to release 2.16.91.0.3 or newer.  Another option is to modi=
fy
-*** your PATH or compiler configuration so that the native linker is
-*** used, and then restart.
-
-_LT_EOF
-	;;
-	*)
-	  if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null; t=
hen
-	    hardcode_libdir_flag_spec_F77=3D'`test -z "$SCOABSPATH" && echo ${w=
l}-rpath,$libdir`'
-	    archive_cmds_F77=3D'$CC -shared $libobjs $deplibs $compiler_flags $=
{wl}-soname,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib'
-	    archive_expsym_cmds_F77=3D'$CC -shared $libobjs $deplibs $compiler_=
flags ${wl}-soname,\${SCOABSPATH:+${install_libdir}/}$soname,-retain-symb=
ols-file,$export_symbols -o $lib'
-	  else
-	    ld_shlibs_F77=3Dno
-	  fi
-	;;
-      esac
-      ;;
-
     sunos4*)
       archive_cmds_F77=3D'$LD -assert pure-text -Bshareable -o $lib $lib=
objs $deplibs $linker_flags'
       wlarc=3D
@@ -14733,6 +14751,32 @@
       hardcode_shlibpath_var_F77=3Dno
       ;;
=20
+  linux*)
+    if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null; =
then
+        tmp_archive_cmds=3D'$CC -shared $libobjs $deplibs $compiler_flag=
s ${wl}-soname $wl$soname -o $lib'
+	archive_cmds_F77=3D"$tmp_archive_cmds"
+      supports_anon_versioning=3Dno
+      case `$LD -v 2>/dev/null` in
+        *\ 01.* | *\ 2.[0-9].* | *\ 2.10.*) ;; # catch versions < 2.11
+        *\ 2.11.93.0.2\ *) supports_anon_versioning=3Dyes ;; # RH7.3 ...
+        *\ 2.11.92.0.12\ *) supports_anon_versioning=3Dyes ;; # Mandrake=
 8.2 ...
+        *\ 2.11.*) ;; # other 2.11 versions
+        *) supports_anon_versioning=3Dyes ;;
+      esac
+      if test $supports_anon_versioning =3D yes; then
+        archive_expsym_cmds_F77=3D'$echo "{ global:" > $output_objdir/$l=
ibname.ver~
+cat $export_symbols | sed -e "s/\(.*\)/\1;/" >> $output_objdir/$libname.=
ver~
+$echo "local: *; };" >> $output_objdir/$libname.ver~
+        $CC -shared $libobjs $deplibs $compiler_flags ${wl}-soname $wl$s=
oname ${wl}-version-script ${wl}$output_objdir/$libname.ver -o $lib'
+      else
+        archive_expsym_cmds_F77=3D"$tmp_archive_cmds"
+      fi
+      link_all_deplibs_F77=3Dno
+    else
+      ld_shlibs_F77=3Dno
+    fi
+    ;;
+
     *)
       if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null=
; then
 	archive_cmds_F77=3D'$CC -shared $libobjs $deplibs $compiler_flags ${wl}=
-soname $wl$soname -o $lib'
@@ -14743,11 +14787,16 @@
       ;;
     esac
=20
-    if test "$ld_shlibs_F77" =3D no; then
-      runpath_var=3D
-      hardcode_libdir_flag_spec_F77=3D
-      export_dynamic_flag_spec_F77=3D
-      whole_archive_flag_spec_F77=3D
+    if test "$ld_shlibs_F77" =3D yes; then
+      runpath_var=3DLD_RUN_PATH
+      hardcode_libdir_flag_spec_F77=3D'${wl}--rpath ${wl}$libdir'
+      export_dynamic_flag_spec_F77=3D'${wl}--export-dynamic'
+      # ancient GNU ld didn't support --whole-archive et. al.
+      if $LD --help 2>&1 | grep 'no-whole-archive' > /dev/null; then
+ 	whole_archive_flag_spec_F77=3D"$wlarc"'--whole-archive$convenience '"$=
wlarc"'--no-whole-archive'
+      else
+  	whole_archive_flag_spec_F77=3D
+      fi
     fi
   else
     # PORTME fill in a description of your system's linker (not GNU ld)
@@ -14759,7 +14808,7 @@
       # Note: this linker hardcodes the directories in LIBPATH if there
       # are no directories specified by -L.
       hardcode_minus_L_F77=3Dyes
-      if test "$GCC" =3D yes && test -z "$lt_prog_compiler_static"; then
+      if test "$GCC" =3D yes && test -z "$link_static_flag"; then
 	# Neither direct hardcoding nor static linking is supported with a
 	# broken collect2.
 	hardcode_direct_F77=3Dunsupported
@@ -14793,7 +14842,6 @@
   	    break
   	  fi
 	  done
-	  ;;
 	esac
=20
 	exp_sym_flag=3D'-bexport'
@@ -14812,7 +14860,7 @@
       link_all_deplibs_F77=3Dyes
=20
       if test "$GCC" =3D yes; then
-	case $host_os in aix4.[012]|aix4.[012].*)
+	case $host_os in aix4.012|aix4.012.*)
 	# We only want to do this on AIX 4.2 and lower, the check
 	# below for broken collect2 doesn't work under 4.3+
 	  collect2name=3D`${CC} -print-prog-name=3Dcollect2`
@@ -14831,12 +14879,8 @@
   	  hardcode_libdir_flag_spec_F77=3D'-L$libdir'
   	  hardcode_libdir_separator_F77=3D
 	  fi
-	  ;;
 	esac
 	shared_flag=3D'-shared'
-	if test "$aix_use_runtimelinking" =3D yes; then
-	  shared_flag=3D"$shared_flag "'${wl}-G'
-	fi
       else
 	# not using gcc
 	if test "$host_cpu" =3D ia64; then
@@ -14844,11 +14888,11 @@
   	# chokes on -Wl,-G. The following line is correct:
 	  shared_flag=3D'-G'
 	else
-	  if test "$aix_use_runtimelinking" =3D yes; then
+  	if test "$aix_use_runtimelinking" =3D yes; then
 	    shared_flag=3D'${wl}-G'
 	  else
 	    shared_flag=3D'${wl}-bM:SRE'
-	  fi
+  	fi
 	fi
       fi
=20
@@ -14902,12 +14946,12 @@
 if test -z "$aix_libpath"; then aix_libpath=3D"/usr/lib:/lib"; fi
=20
        hardcode_libdir_flag_spec_F77=3D'${wl}-blibpath:$libdir:'"$aix_li=
bpath"
-	archive_expsym_cmds_F77=3D"\$CC"' -o $output_objdir/$soname $libobjs $d=
eplibs '"\${wl}$no_entry_flag"' $compiler_flags `if test "x${allow_undefi=
ned_flag}" !=3D "x"; then echo "${wl}${allow_undefined_flag}"; else :; fi=
` '"\${wl}$exp_sym_flag:\$export_symbols $shared_flag"
+	archive_expsym_cmds_F77=3D"\$CC"' -o $output_objdir/$soname $libobjs $d=
eplibs $compiler_flags `if test "x${allow_undefined_flag}" !=3D "x"; then=
 echo "${wl}${allow_undefined_flag}"; else :; fi` '"\${wl}$no_entry_flag =
\${wl}$exp_sym_flag:\$export_symbols $shared_flag"
        else
 	if test "$host_cpu" =3D ia64; then
 	  hardcode_libdir_flag_spec_F77=3D'${wl}-R $libdir:/usr/lib:/lib'
 	  allow_undefined_flag_F77=3D"-z nodefs"
-	  archive_expsym_cmds_F77=3D"\$CC $shared_flag"' -o $output_objdir/$son=
ame $libobjs $deplibs '"\${wl}$no_entry_flag"' $compiler_flags ${wl}${all=
ow_undefined_flag} '"\${wl}$exp_sym_flag:\$export_symbols"
+	  archive_expsym_cmds_F77=3D"\$CC $shared_flag"' -o $output_objdir/$son=
ame $libobjs $deplibs $compiler_flags ${wl}${allow_undefined_flag} '"\${w=
l}$no_entry_flag \${wl}$exp_sym_flag:\$export_symbols"
 	else
 	 # Determine the default libpath from the value encoded in an empty exe=
cutable.
 	 cat >conftest.$ac_ext <<_ACEOF
@@ -14956,11 +15000,13 @@
 	  # -berok will link without error, but may produce a broken library.
 	  no_undefined_flag_F77=3D' ${wl}-bernotok'
 	  allow_undefined_flag_F77=3D' ${wl}-berok'
+	  # -bexpall does not export symbols beginning with underscore (_)
+	  always_export_symbols_F77=3Dyes
 	  # Exported symbols can be pulled into shared objects from archives
-	  whole_archive_flag_spec_F77=3D'$convenience'
+	  whole_archive_flag_spec_F77=3D' '
 	  archive_cmds_need_lc_F77=3Dyes
-	  # This is similar to how AIX traditionally builds its shared librarie=
s.
-	  archive_expsym_cmds_F77=3D"\$CC $shared_flag"' -o $output_objdir/$son=
ame $libobjs $deplibs ${wl}-bnoentry $compiler_flags ${wl}-bE:$export_sym=
bols${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$libname$release=
.a $output_objdir/$soname'
+	  # This is similar to how AIX traditionally builds it's shared librari=
es.
+	  archive_expsym_cmds_F77=3D"\$CC $shared_flag"' -o $output_objdir/$son=
ame $libobjs $deplibs $compiler_flags ${wl}-bE:$export_symbols ${wl}-bnoe=
ntry${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$libname$release=
.a $output_objdir/$soname'
 	fi
       fi
       ;;
@@ -14973,7 +15019,7 @@
       ld_shlibs_F77=3Dno
       ;;
=20
-    bsdi[45]*)
+    bsdi4*)
       export_dynamic_flag_spec_F77=3D-rdynamic
       ;;
=20
@@ -14994,57 +15040,57 @@
       old_archive_From_new_cmds_F77=3D'true'
       # FIXME: Should let the user specify the lib program.
       old_archive_cmds_F77=3D'lib /OUT:$oldlib$oldobjs$old_deplibs'
-      fix_srcfile_path_F77=3D'`cygpath -w "$srcfile"`'
+      fix_srcfile_path=3D'`cygpath -w "$srcfile"`'
       enable_shared_with_static_runtimes_F77=3Dyes
       ;;
=20
     darwin* | rhapsody*)
-      case $host_os in
-        rhapsody* | darwin1.[012])
-         allow_undefined_flag_F77=3D'${wl}-undefined ${wl}suppress'
-         ;;
-       *) # Darwin 1.3 on
-         if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
-           allow_undefined_flag_F77=3D'${wl}-flat_namespace ${wl}-undefi=
ned ${wl}suppress'
-         else
-           case ${MACOSX_DEPLOYMENT_TARGET} in
-             10.[012])
-               allow_undefined_flag_F77=3D'${wl}-flat_namespace ${wl}-un=
defined ${wl}suppress'
-               ;;
-             10.*)
-               allow_undefined_flag_F77=3D'${wl}-undefined ${wl}dynamic_=
lookup'
-               ;;
-           esac
-         fi
-         ;;
+    if test "$GXX" =3D yes ; then
+      archive_cmds_need_lc_F77=3Dno
+      case "$host_os" in
+      rhapsody* | darwin1.[012])
+	allow_undefined_flag_F77=3D'-undefined suppress'
+	;;
+      *) # Darwin 1.3 on
+      if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
+      	allow_undefined_flag_F77=3D'-flat_namespace -undefined suppress'
+      else
+        case ${MACOSX_DEPLOYMENT_TARGET} in
+          10.[012])
+            allow_undefined_flag_F77=3D'-flat_namespace -undefined suppr=
ess'
+            ;;
+          10.*)
+            allow_undefined_flag_F77=3D'-undefined dynamic_lookup'
+            ;;
+        esac
+      fi
+	;;
       esac
-      archive_cmds_need_lc_F77=3Dno
+    	lt_int_apple_cc_single_mod=3Dno
+    	output_verbose_link_cmd=3D'echo'
+    	if $CC -dumpspecs 2>&1 | grep 'single_module' >/dev/null ; then
+    	  lt_int_apple_cc_single_mod=3Dyes
+    	fi
+    	if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+    	  archive_cmds_F77=3D'$CC -dynamiclib -single_module $allow_undefin=
ed_flag -o $lib $libobjs $deplibs $compiler_flags -install_name $rpath/$s=
oname $verstring'
+    	else
+        archive_cmds_F77=3D'$CC -r ${wl}-bind_at_load -keep_private_exte=
rns -nostdlib -o ${lib}-master.o $libobjs~$CC -dynamiclib $allow_undefine=
d_flag -o $lib ${lib}-master.o $deplibs $compiler_flags -install_name $rp=
ath/$soname $verstring'
+      fi
+      module_cmds_F77=3D'$CC ${wl}-bind_at_load $allow_undefined_flag -o=
 $lib -bundle $libobjs $deplibs$compiler_flags'
+      # Don't fix this by using the ld -exported_symbols_list flag, it d=
oesn't exist in older darwin ld's
+        if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+          archive_expsym_cmds_F77=3D'sed -e "s,#.*,," -e "s,^[    ]*,," =
-e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols=
.expsym~$CC -dynamiclib -single_module $allow_undefined_flag -o $lib $lib=
objs $deplibs $compiler_flags -install_name $rpath/$soname $verstring~nme=
dit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+        else
+          archive_expsym_cmds_F77=3D'sed -e "s,#.*,," -e "s,^[    ]*,," =
-e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols=
.expsym~$CC -r ${wl}-bind_at_load -keep_private_externs -nostdlib -o ${li=
b}-master.o $libobjs~$CC -dynamiclib $allow_undefined_flag -o $lib ${lib}=
-master.o $deplibs $compiler_flags -install_name $rpath/$soname $verstrin=
g~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+        fi
+          module_expsym_cmds_F77=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -=
e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.=
expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compi=
ler_flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
       hardcode_direct_F77=3Dno
       hardcode_automatic_F77=3Dyes
       hardcode_shlibpath_var_F77=3Dunsupported
-      whole_archive_flag_spec_F77=3D''
+      whole_archive_flag_spec_F77=3D'-all_load $convenience'
       link_all_deplibs_F77=3Dyes
-    if test "$GCC" =3D yes ; then
-    	output_verbose_link_cmd=3D'echo'
-        archive_cmds_F77=3D'$CC -dynamiclib $allow_undefined_flag -o $li=
b $libobjs $deplibs $compiler_flags -install_name $rpath/$soname $verstri=
ng'
-      module_cmds_F77=3D'$CC $allow_undefined_flag -o $lib -bundle $libo=
bjs $deplibs$compiler_flags'
-      # Don't fix this by using the ld -exported_symbols_list flag, it d=
oesn't exist in older darwin lds
-      archive_expsym_cmds_F77=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "=
s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exp=
sym~$CC -dynamiclib $allow_undefined_flag -o $lib $libobjs $deplibs $comp=
iler_flags -install_name $rpath/$soname $verstring~nmedit -s $output_objd=
ir/${libname}-symbols.expsym ${lib}'
-      module_expsym_cmds_F77=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "s=
,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exps=
ym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compiler_=
flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
     else
-      case $cc_basename in
-        xlc*)
-         output_verbose_link_cmd=3D'echo'
-         archive_cmds_F77=3D'$CC -qmkshrobj $allow_undefined_flag -o $li=
b $libobjs $deplibs $compiler_flags ${wl}-install_name ${wl}`echo $rpath/=
$soname` $verstring'
-         module_cmds_F77=3D'$CC $allow_undefined_flag -o $lib -bundle $l=
ibobjs $deplibs$compiler_flags'
-          # Don't fix this by using the ld -exported_symbols_list flag, =
it doesn't exist in older darwin lds
-         archive_expsym_cmds_F77=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -=
e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.=
expsym~$CC -qmkshrobj $allow_undefined_flag -o $lib $libobjs $deplibs $co=
mpiler_flags ${wl}-install_name ${wl}$rpath/$soname $verstring~nmedit -s =
$output_objdir/${libname}-symbols.expsym ${lib}'
-          module_expsym_cmds_F77=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -=
e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.=
expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compi=
ler_flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
-          ;;
-       *)
-         ld_shlibs_F77=3Dno
-          ;;
-      esac
+      ld_shlibs_F77=3Dno
     fi
       ;;
=20
@@ -15078,22 +15124,13 @@
       ;;
=20
     # FreeBSD 3 and greater uses gcc -shared to do shared libraries.
-    freebsd* | dragonfly*)
+    freebsd* | kfreebsd*-gnu)
       archive_cmds_F77=3D'$CC -shared -o $lib $libobjs $deplibs $compile=
r_flags'
       hardcode_libdir_flag_spec_F77=3D'-R$libdir'
       hardcode_direct_F77=3Dyes
       hardcode_shlibpath_var_F77=3Dno
       ;;
=20
-    # GNU/kFreeBSD uses gcc -shared to do shared libraries.
-    kfreebsd*-gnu)
-      archive_cmds_F77=3D'$CC -shared -o $lib $libobjs $deplibs $compile=
r_flags'
-      hardcode_libdir_flag_spec_F77=3D'-R$libdir'
-      hardcode_direct_F77=3Dyes
-      hardcode_shlibpath_var_F77=3Dno
-      link_all_deplibs_F77=3Dno
-      ;;
-
     hpux9*)
       if test "$GCC" =3D yes; then
 	archive_cmds_F77=3D'$rm $output_objdir/$soname~$CC -shared -fPIC ${wl}+=
b ${wl}$install_libdir -o $output_objdir/$soname $libobjs $deplibs $compi=
ler_flags~test $output_objdir/$soname =3D $lib || mv $output_objdir/$sona=
me $lib'
@@ -15110,62 +15147,47 @@
       export_dynamic_flag_spec_F77=3D'${wl}-E'
       ;;
=20
-    hpux10*)
+    hpux10* | hpux11*)
       if test "$GCC" =3D yes -a "$with_gnu_ld" =3D no; then
-	archive_cmds_F77=3D'$CC -shared -fPIC ${wl}+h ${wl}$soname ${wl}+b ${wl=
}$install_libdir -o $lib $libobjs $deplibs $compiler_flags'
-      else
-	archive_cmds_F77=3D'$LD -b +h $soname +b $install_libdir -o $lib $libob=
js $deplibs $linker_flags'
-      fi
-      if test "$with_gnu_ld" =3D no; then
-	hardcode_libdir_flag_spec_F77=3D'${wl}+b ${wl}$libdir'
-	hardcode_libdir_separator_F77=3D:
-
-	hardcode_direct_F77=3Dyes
-	export_dynamic_flag_spec_F77=3D'${wl}-E'
-
-	# hardcode_minus_L: Not really in the search PATH,
-	# but as the default location of the library.
-	hardcode_minus_L_F77=3Dyes
-      fi
-      ;;
-
-    hpux11*)
-      if test "$GCC" =3D yes -a "$with_gnu_ld" =3D no; then
-	case $host_cpu in
-	hppa*64*)
+	case "$host_cpu" in
+	hppa*64*|ia64*)
 	  archive_cmds_F77=3D'$CC -shared ${wl}+h ${wl}$soname -o $lib $libobjs=
 $deplibs $compiler_flags'
 	  ;;
-	ia64*)
-	  archive_cmds_F77=3D'$CC -shared ${wl}+h ${wl}$soname ${wl}+nodefaultr=
path -o $lib $libobjs $deplibs $compiler_flags'
-	  ;;
 	*)
 	  archive_cmds_F77=3D'$CC -shared -fPIC ${wl}+h ${wl}$soname ${wl}+b ${=
wl}$install_libdir -o $lib $libobjs $deplibs $compiler_flags'
 	  ;;
 	esac
       else
-	case $host_cpu in
-	hppa*64*)
-	  archive_cmds_F77=3D'$CC -b ${wl}+h ${wl}$soname -o $lib $libobjs $dep=
libs $compiler_flags'
+	case "$host_cpu" in
+	hppa*64*|ia64*)
+	  archive_cmds_F77=3D'$LD -b +h $soname -o $lib $libobjs $deplibs $link=
er_flags'
 	  ;;
-	ia64*)
-	  archive_cmds_F77=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+nodefaultrpath =
-o $lib $libobjs $deplibs $compiler_flags'
-	  ;;
 	*)
-	  archive_cmds_F77=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+b ${wl}$install=
_libdir -o $lib $libobjs $deplibs $compiler_flags'
+	  archive_cmds_F77=3D'$LD -b +h $soname +b $install_libdir -o $lib $lib=
objs $deplibs $linker_flags'
 	  ;;
 	esac
       fi
       if test "$with_gnu_ld" =3D no; then
-	hardcode_libdir_flag_spec_F77=3D'${wl}+b ${wl}$libdir'
-	hardcode_libdir_separator_F77=3D:
-
-	case $host_cpu in
-	hppa*64*|ia64*)
+	case "$host_cpu" in
+	hppa*64*)
+	  hardcode_libdir_flag_spec_F77=3D'${wl}+b ${wl}$libdir'
 	  hardcode_libdir_flag_spec_ld_F77=3D'+b $libdir'
+	  hardcode_libdir_separator_F77=3D:
 	  hardcode_direct_F77=3Dno
 	  hardcode_shlibpath_var_F77=3Dno
 	  ;;
+	ia64*)
+	  hardcode_libdir_flag_spec_F77=3D'-L$libdir'
+	  hardcode_direct_F77=3Dno
+	  hardcode_shlibpath_var_F77=3Dno
+
+	  # hardcode_minus_L: Not really in the search PATH,
+	  # but as the default location of the library.
+	  hardcode_minus_L_F77=3Dyes
+	  ;;
 	*)
+	  hardcode_libdir_flag_spec_F77=3D'${wl}+b ${wl}$libdir'
+	  hardcode_libdir_separator_F77=3D:
 	  hardcode_direct_F77=3Dyes
 	  export_dynamic_flag_spec_F77=3D'${wl}-E'
=20
@@ -15213,7 +15235,6 @@
       hardcode_shlibpath_var_F77=3Dno
       if test -z "`echo __ELF__ | $CC -E - | grep __ELF__`" || test "$ho=
st_os-$host_cpu" =3D "openbsd2.8-powerpc"; then
 	archive_cmds_F77=3D'$CC -shared $pic_flag -o $lib $libobjs $deplibs $co=
mpiler_flags'
-	archive_expsym_cmds_F77=3D'$CC -shared $pic_flag -o $lib $libobjs $depl=
ibs $compiler_flags ${wl}-retain-symbols-file,$export_symbols'
 	hardcode_libdir_flag_spec_F77=3D'${wl}-rpath,$libdir'
 	export_dynamic_flag_spec_F77=3D'${wl}-E'
       else
@@ -15259,7 +15280,7 @@
 	allow_undefined_flag_F77=3D' -expect_unresolved \*'
 	archive_cmds_F77=3D'$LD -shared${allow_undefined_flag} $libobjs $deplib=
s $linker_flags -msym -soname $soname `test -n "$verstring" && echo -set_=
version $verstring` -update_registry ${output_objdir}/so_locations -o $li=
b'
 	archive_expsym_cmds_F77=3D'for i in `cat $export_symbols`; do printf "%=
s %s\\n" -exported_symbol "\$i" >> $lib.exp; done; echo "-hidden">> $lib.=
exp~
-	$LD -shared${allow_undefined_flag} -input $lib.exp $linker_flags $libob=
js $deplibs -soname $soname `test -n "$verstring" && echo -set_version $v=
erstring` -update_registry ${output_objdir}/so_locations -o $lib~$rm $lib=
.exp'
+	$LD -shared${allow_undefined_flag} -input $lib.exp $linker_flags $libob=
js $deplibs -soname $soname `test -n "$verstring" && echo -set_version $v=
erstring` -update_registry ${objdir}/so_locations -o $lib~$rm $lib.exp'
=20
 	# Both c and cxx compiler support -rpath directly
 	hardcode_libdir_flag_spec_F77=3D'-rpath $libdir'
@@ -15267,15 +15288,21 @@
       hardcode_libdir_separator_F77=3D:
       ;;
=20
+    sco3.2v5*)
+      archive_cmds_F77=3D'$LD -G -h $soname -o $lib $libobjs $deplibs $l=
inker_flags'
+      hardcode_shlibpath_var_F77=3Dno
+      export_dynamic_flag_spec_F77=3D'${wl}-Bexport'
+      runpath_var=3DLD_RUN_PATH
+      hardcode_runpath_var=3Dyes
+      ;;
+
     solaris*)
       no_undefined_flag_F77=3D' -z text'
       if test "$GCC" =3D yes; then
-	wlarc=3D'${wl}'
 	archive_cmds_F77=3D'$CC -shared ${wl}-h ${wl}$soname -o $lib $libobjs $=
deplibs $compiler_flags'
 	archive_expsym_cmds_F77=3D'$echo "{ global:" > $lib.exp~cat $export_sym=
bols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *; };" >> $lib.e=
xp~
 	  $CC -shared ${wl}-M ${wl}$lib.exp ${wl}-h ${wl}$soname -o $lib $libob=
js $deplibs $compiler_flags~$rm $lib.exp'
       else
-	wlarc=3D''
 	archive_cmds_F77=3D'$LD -G${allow_undefined_flag} -h $soname -o $lib $l=
ibobjs $deplibs $linker_flags'
 	archive_expsym_cmds_F77=3D'$echo "{ global:" > $lib.exp~cat $export_sym=
bols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *; };" >> $lib.e=
xp~
   	$LD -G${allow_undefined_flag} -M $lib.exp -h $soname -o $lib $libobjs=
 $deplibs $linker_flags~$rm $lib.exp'
@@ -15284,18 +15311,8 @@
       hardcode_shlibpath_var_F77=3Dno
       case $host_os in
       solaris2.[0-5] | solaris2.[0-5].*) ;;
-      *)
- 	# The compiler driver will combine linker options so we
- 	# cannot just pass the convience library names through
- 	# without $wl, iff we do not link with $LD.
- 	# Luckily, gcc supports the same syntax we need for Sun Studio.
- 	# Supported since Solaris 2.6 (maybe 2.5.1?)
- 	case $wlarc in
- 	'')
- 	  whole_archive_flag_spec_F77=3D'-z allextract$convenience -z defaulte=
xtract' ;;
- 	*)
- 	  whole_archive_flag_spec_F77=3D'${wl}-z ${wl}allextract`for conv in $=
convenience\"\"; do test -n \"$conv\" && new_convenience=3D\"$new_conveni=
ence,$conv\"; done; $echo \"$new_convenience\"` ${wl}-z ${wl}defaultextra=
ct' ;;
- 	esac ;;
+      *) # Supported since Solaris 2.6 (maybe 2.5.1?)
+	whole_archive_flag_spec_F77=3D'-z allextract$convenience -z defaultextr=
act' ;;
       esac
       link_all_deplibs_F77=3Dyes
       ;;
@@ -15352,45 +15369,36 @@
       fi
       ;;
=20
-    sysv4*uw2* | sysv5OpenUNIX* | sysv5UnixWare7.[01].[10]* | unixware7*=
)
-      no_undefined_flag_F77=3D'${wl}-z,text'
-      archive_cmds_need_lc_F77=3Dno
+    sysv4.2uw2*)
+      archive_cmds_F77=3D'$LD -G -o $lib $libobjs $deplibs $linker_flags=
'
+      hardcode_direct_F77=3Dyes
+      hardcode_minus_L_F77=3Dno
       hardcode_shlibpath_var_F77=3Dno
-      runpath_var=3D'LD_RUN_PATH'
+      hardcode_runpath_var=3Dyes
+      runpath_var=3DLD_RUN_PATH
+      ;;
=20
+   sysv5OpenUNIX8* | sysv5UnixWare7* |  sysv5uw[78]* | unixware7*)
+      no_undefined_flag_F77=3D'${wl}-z ${wl}text'
       if test "$GCC" =3D yes; then
-	archive_cmds_F77=3D'$CC -shared ${wl}-h,$soname -o $lib $libobjs $depli=
bs $compiler_flags'
-	archive_expsym_cmds_F77=3D'$CC -shared ${wl}-Bexport:$export_symbols ${=
wl}-h,$soname -o $lib $libobjs $deplibs $compiler_flags'
+	archive_cmds_F77=3D'$CC -shared ${wl}-h ${wl}$soname -o $lib $libobjs $=
deplibs $compiler_flags'
       else
-	archive_cmds_F77=3D'$CC -G ${wl}-h,$soname -o $lib $libobjs $deplibs $c=
ompiler_flags'
-	archive_expsym_cmds_F77=3D'$CC -G ${wl}-Bexport:$export_symbols ${wl}-h=
,$soname -o $lib $libobjs $deplibs $compiler_flags'
+	archive_cmds_F77=3D'$CC -G ${wl}-h ${wl}$soname -o $lib $libobjs $depli=
bs $compiler_flags'
       fi
+      runpath_var=3D'LD_RUN_PATH'
+      hardcode_shlibpath_var_F77=3Dno
       ;;
=20
-    sysv5* | sco3.2v5* | sco5v6*)
-      # Note: We can NOT use -z defs as we might desire, because we do n=
ot
-      # link with -lc, and that would cause any symbols used from libc t=
o
-      # always be unresolved, which means just about no library would
-      # ever link correctly.  If we're not using GNU ld we use -z text
-      # though, which does catch some bad symbols but isn't as heavy-han=
ded
-      # as -z defs.
-      no_undefined_flag_F77=3D'${wl}-z,text'
-      allow_undefined_flag_F77=3D'${wl}-z,nodefs'
-      archive_cmds_need_lc_F77=3Dno
+    sysv5*)
+      no_undefined_flag_F77=3D' -z text'
+      # $CC -shared without GNU ld will not create a library from C++
+      # object files and a static libstdc++, better avoid it by now
+      archive_cmds_F77=3D'$LD -G${allow_undefined_flag} -h $soname -o $l=
ib $libobjs $deplibs $linker_flags'
+      archive_expsym_cmds_F77=3D'$echo "{ global:" > $lib.exp~cat $expor=
t_symbols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *; };" >> $=
lib.exp~
+  		$LD -G${allow_undefined_flag} -M $lib.exp -h $soname -o $lib $libobj=
s $deplibs $linker_flags~$rm $lib.exp'
+      hardcode_libdir_flag_spec_F77=3D
       hardcode_shlibpath_var_F77=3Dno
-      hardcode_libdir_flag_spec_F77=3D'`test -z "$SCOABSPATH" && echo ${=
wl}-R,$libdir`'
-      hardcode_libdir_separator_F77=3D':'
-      link_all_deplibs_F77=3Dyes
-      export_dynamic_flag_spec_F77=3D'${wl}-Bexport'
       runpath_var=3D'LD_RUN_PATH'
-
-      if test "$GCC" =3D yes; then
-	archive_cmds_F77=3D'$CC -shared ${wl}-h,\${SCOABSPATH:+${install_libdir=
}/}$soname -o $lib $libobjs $deplibs $compiler_flags'
-	archive_expsym_cmds_F77=3D'$CC -shared ${wl}-Bexport:$export_symbols ${=
wl}-h,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $libobjs $deplibs=
 $compiler_flags'
-      else
-	archive_cmds_F77=3D'$CC -G ${wl}-h,\${SCOABSPATH:+${install_libdir}/}$s=
oname -o $lib $libobjs $deplibs $compiler_flags'
-	archive_expsym_cmds_F77=3D'$CC -G ${wl}-Bexport:$export_symbols ${wl}-h=
,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $libobjs $deplibs $com=
piler_flags'
-      fi
       ;;
=20
     uts4*)
@@ -15409,6 +15417,11 @@
 echo "${ECHO_T}$ld_shlibs_F77" >&6
 test "$ld_shlibs_F77" =3D no && can_build_shared=3Dno
=20
+variables_saved_for_relink=3D"PATH $shlibpath_var $runpath_var"
+if test "$GCC" =3D yes; then
+  variables_saved_for_relink=3D"$variables_saved_for_relink GCC_EXEC_PRE=
FIX COMPILER_PATH LIBRARY_PATH"
+fi
+
 #
 # Do we need to explicitly link libc?
 #
@@ -15441,7 +15454,6 @@
         libobjs=3Dconftest.$ac_objext
         deplibs=3D
         wl=3D$lt_prog_compiler_wl_F77
-	pic_flag=3D$lt_prog_compiler_pic_F77
         compiler_flags=3D-v
         linker_flags=3D-v
         verstring=3D
@@ -15574,7 +15586,7 @@
   shlibpath_var=3DLIBRARY_PATH
   ;;
=20
-bsdi[45]*)
+bsdi4*)
   version_type=3Dlinux
   need_version=3Dno
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
@@ -15602,8 +15614,7 @@
       dlpath=3D`$SHELL 2>&1 -c '\''. $dir/'\''\${base_file}'\''i;echo \$=
dlname'\''`~
       dldir=3D$destdir/`dirname \$dlpath`~
       test -d \$dldir || mkdir -p \$dldir~
-      $install_prog $dir/$dlname \$dldir/$dlname~
-      chmod a+x \$dldir/$dlname'
+      $install_prog $dir/$dlname \$dldir/$dlname'
     postuninstall_cmds=3D'dldll=3D`$SHELL 2>&1 -c '\''. $file; echo \$dl=
name'\''`~
       dlpath=3D$dir/\$dldll~
        $rm \$dlpath'
@@ -15633,7 +15644,7 @@
       ;;
     pw32*)
       # pw32 DLLs use 'pw' prefix rather than 'lib'
-      library_names_spec=3D'`echo ${libname} | sed -e 's/^lib/pw/'``echo=
 ${release} | $SED -e 's/[.]/-/g'`${versuffix}${shared_ext}'
+      library_names_spec=3D'`echo ${libname} | sed -e 's/^lib/pw/'``echo=
 ${release} | $SED -e 's/./-/g'`${versuffix}${shared_ext}'
       ;;
     esac
     ;;
@@ -15656,7 +15667,7 @@
   soname_spec=3D'${libname}${release}${major}$shared_ext'
   shlibpath_overrides_runpath=3Dyes
   shlibpath_var=3DDYLD_LIBRARY_PATH
-  shrext_cmds=3D'`test .$module =3D .yes && echo .so || echo .dylib`'
+  shrext_cmds=3D'$(test .$module =3D .yes && echo .so || echo .dylib)'
   # Apple's gcc prints 'gcc -print-search-dirs' doesn't operate the same=
=2E
   if test "$GCC" =3D yes; then
     sys_lib_search_path_spec=3D`$CC -print-search-dirs | tr "\n" "$PATH_=
SEPARATOR" | sed -e 's/libraries:/@libraries:/' | tr "@" "\n" | grep "^li=
braries:" | sed -e "s/^libraries://" -e "s,=3D/,/,g" -e "s,$PATH_SEPARATO=
R, ,g" -e "s,.*,& /lib /usr/lib /usr/local/lib,g"`
@@ -15691,17 +15702,8 @@
   dynamic_linker=3D'GNU ld.so'
   ;;
=20
-freebsd* | dragonfly*)
-  # DragonFly does not have aout.  When/if they implement a new
-  # versioning mechanism, adjust this.
-  if test -x /usr/bin/objformat; then
-    objformat=3D`/usr/bin/objformat`
-  else
-    case $host_os in
-    freebsd[123]*) objformat=3Daout ;;
-    *) objformat=3Delf ;;
-    esac
-  fi
+freebsd*)
+  objformat=3D`test -x /usr/bin/objformat && /usr/bin/objformat || echo =
aout`
   version_type=3Dfreebsd-$objformat
   case $version_type in
     freebsd-elf*)
@@ -15719,19 +15721,14 @@
   freebsd2*)
     shlibpath_overrides_runpath=3Dyes
     ;;
-  freebsd3.[01]* | freebsdelf3.[01]*)
+  freebsd3.01* | freebsdelf3.01*)
     shlibpath_overrides_runpath=3Dyes
     hardcode_into_libs=3Dyes
     ;;
-  freebsd3.[2-9]* | freebsdelf3.[2-9]* | \
-  freebsd4.[0-5] | freebsdelf4.[0-5] | freebsd4.1.1 | freebsdelf4.1.1)
+  *) # from 3.2 on
     shlibpath_overrides_runpath=3Dno
     hardcode_into_libs=3Dyes
     ;;
-  freebsd*) # from 4.6 on
-    shlibpath_overrides_runpath=3Dyes
-    hardcode_into_libs=3Dyes
-    ;;
   esac
   ;;
=20
@@ -15751,7 +15748,7 @@
   version_type=3Dsunos
   need_lib_prefix=3Dno
   need_version=3Dno
-  case $host_cpu in
+  case "$host_cpu" in
   ia64*)
     shrext_cmds=3D'.so'
     hardcode_into_libs=3Dyes
@@ -15791,18 +15788,6 @@
   postinstall_cmds=3D'chmod 555 $lib'
   ;;
=20
-interix3*)
-  version_type=3Dlinux
-  need_lib_prefix=3Dno
-  need_version=3Dno
-  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major ${libname}${shared_ext}'
-  soname_spec=3D'${libname}${release}${shared_ext}$major'
-  dynamic_linker=3D'Interix 3.x ld.so.1 (PE, like ELF)'
-  shlibpath_var=3DLD_LIBRARY_PATH
-  shlibpath_overrides_runpath=3Dno
-  hardcode_into_libs=3Dyes
-  ;;
-
 irix5* | irix6* | nonstopux*)
   case $host_os in
     nonstopux*) version_type=3Dnonstopux ;;
@@ -15862,7 +15847,7 @@
=20
   # Append ld.so.conf contents to the search path
   if test -f /etc/ld.so.conf; then
-    lt_ld_extra=3D`awk '/^include / { system(sprintf("cd /etc; cat %s", =
\$2)); skip =3D 1; } { if (!skip) print \$0; skip =3D 0; }' < /etc/ld.so.=
conf | $SED -e 's/#.*//;s/[:,	]/ /g;s/=3D[^=3D]*$//;s/=3D[^=3D ]* / /g;/^=
$/d' | tr '\n' ' '`
+    lt_ld_extra=3D`$SED -e 's/:,\t/ /g;s/=3D^=3D*$//;s/=3D^=3D * / /g' /=
etc/ld.so.conf | tr '\n' ' '`
     sys_lib_dlsearch_path_spec=3D"/lib /usr/lib $lt_ld_extra"
   fi
=20
@@ -15936,13 +15921,8 @@
=20
 openbsd*)
   version_type=3Dsunos
-  sys_lib_dlsearch_path_spec=3D"/usr/lib"
   need_lib_prefix=3Dno
-  # Some older versions of OpenBSD (3.3 at least) *do* need versioned li=
bs.
-  case $host_os in
-    openbsd3.3 | openbsd3.3.*) need_version=3Dyes ;;
-    *)                         need_version=3Dno  ;;
-  esac
+  need_version=3Dyes
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${shared_ext}$versuffix'
   finish_cmds=3D'PATH=3D"\$PATH:/sbin" ldconfig -m $libdir'
   shlibpath_var=3DLD_LIBRARY_PATH
@@ -15980,6 +15960,13 @@
   sys_lib_dlsearch_path_spec=3D"$sys_lib_search_path_spec"
   ;;
=20
+sco3.2v5*)
+  version_type=3Dosf
+  soname_spec=3D'${libname}${release}${shared_ext}$major'
+  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
+  shlibpath_var=3DLD_LIBRARY_PATH
+  ;;
+
 solaris*)
   version_type=3Dlinux
   need_lib_prefix=3Dno
@@ -16005,7 +15992,7 @@
   need_version=3Dyes
   ;;
=20
-sysv4 | sysv4.3*)
+sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
   version_type=3Dlinux
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
   soname_spec=3D'${libname}${release}${shared_ext}$major'
@@ -16038,29 +16025,6 @@
   fi
   ;;
=20
-sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX* | sysv4*uw2*)
-  version_type=3Dfreebsd-elf
-  need_lib_prefix=3Dno
-  need_version=3Dno
-  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext} $libname${shared_ext}'
-  soname_spec=3D'${libname}${release}${shared_ext}$major'
-  shlibpath_var=3DLD_LIBRARY_PATH
-  hardcode_into_libs=3Dyes
-  if test "$with_gnu_ld" =3D yes; then
-    sys_lib_search_path_spec=3D'/usr/local/lib /usr/gnu/lib /usr/ccs/lib=
 /usr/lib /lib'
-    shlibpath_overrides_runpath=3Dno
-  else
-    sys_lib_search_path_spec=3D'/usr/ccs/lib /usr/lib'
-    shlibpath_overrides_runpath=3Dyes
-    case $host_os in
-      sco3.2v5*)
-        sys_lib_search_path_spec=3D"$sys_lib_search_path_spec /lib"
-	;;
-    esac
-  fi
-  sys_lib_dlsearch_path_spec=3D'/usr/lib'
-  ;;
-
 uts4*)
   version_type=3Dlinux
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
@@ -16076,17 +16040,12 @@
 echo "${ECHO_T}$dynamic_linker" >&6
 test "$dynamic_linker" =3D no && can_build_shared=3Dno
=20
-variables_saved_for_relink=3D"PATH $shlibpath_var $runpath_var"
-if test "$GCC" =3D yes; then
-  variables_saved_for_relink=3D"$variables_saved_for_relink GCC_EXEC_PRE=
FIX COMPILER_PATH LIBRARY_PATH"
-fi
-
 echo "$as_me:$LINENO: checking how to hardcode library paths into progra=
ms" >&5
 echo $ECHO_N "checking how to hardcode library paths into programs... $E=
CHO_C" >&6
 hardcode_action_F77=3D
 if test -n "$hardcode_libdir_flag_spec_F77" || \
-   test -n "$runpath_var_F77" || \
-   test "X$hardcode_automatic_F77" =3D "Xyes" ; then
+   test -n "$runpath_var F77" || \
+   test "X$hardcode_automatic_F77"=3D"Xyes" ; then
=20
   # We can hardcode non-existant directories.
   if test "$hardcode_direct_F77" !=3D no &&
@@ -16118,7 +16077,37 @@
   enable_fast_install=3Dneedless
 fi
=20
+striplib=3D
+old_striplib=3D
+echo "$as_me:$LINENO: checking whether stripping libraries is possible" =
>&5
+echo $ECHO_N "checking whether stripping libraries is possible... $ECHO_=
C" >&6
+if test -n "$STRIP" && $STRIP -V 2>&1 | grep "GNU strip" >/dev/null; the=
n
+  test -z "$old_striplib" && old_striplib=3D"$STRIP --strip-debug"
+  test -z "$striplib" && striplib=3D"$STRIP --strip-unneeded"
+  echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6
+else
+# FIXME - insert some real tests, host_os isn't really good enough
+  case $host_os in
+   darwin*)
+       if test -n "$STRIP" ; then
+         striplib=3D"$STRIP -x"
+         echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6
+       else
+  echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6
+fi
+       ;;
+   *)
+  echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6
+    ;;
+  esac
+fi
=20
+
+
 # The else clause should only fire when bootstrapping the
 # libtool distribution, otherwise you forgot to ship ltmain.sh
 # with your package, and you will get complaints that there are
@@ -16132,7 +16121,7 @@
   # Now quote all the things that may contain metacharacters while being
   # careful not to overquote the AC_SUBSTed values.  We take copies of t=
he
   # variables and quote the copies for generation of the libtool script.
-  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC L=
TCFLAGS NM \
+  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC N=
M \
     SED SHELL STRIP \
     libname_spec library_names_spec soname_spec extract_expsyms_cmds \
     old_striplib striplib file_magic_cmd finish_cmds finish_eval \
@@ -16233,13 +16222,7 @@
 # The host system.
 host_alias=3D$host_alias
 host=3D$host
-host_os=3D$host_os
=20
-# The build system.
-build_alias=3D$build_alias
-build=3D$build
-build_os=3D$build_os
-
 # An echo program that does not interpret backslashes.
 echo=3D$lt_echo
=20
@@ -16250,9 +16233,6 @@
 # A C compiler.
 LTCC=3D$lt_LTCC
=20
-# LTCC compiler flags.
-LTCFLAGS=3D$lt_LTCFLAGS
-
 # A language-specific compiler.
 CC=3D$lt_compiler_F77
=20
@@ -16318,7 +16298,7 @@
 # Does compiler simultaneously support -c and -o options?
 compiler_c_o=3D$lt_lt_cv_prog_compiler_c_o_F77
=20
-# Must we lock files when doing compilation?
+# Must we lock files when doing compilation ?
 need_locks=3D$lt_need_locks
=20
 # Do we need the lib prefix for modules?
@@ -16556,56 +16536,27 @@
 lt_simple_compile_test_code=3D"class foo {}\n"
=20
 # Code to be used in simple link tests
-lt_simple_link_test_code=3D'public class conftest { public static void m=
ain(String[] argv) {}; }\n'
+lt_simple_link_test_code=3D'public class conftest { public static void m=
ain(String argv) {}; }\n'
=20
 # ltmain only uses $CC for tagged configurations so make sure $CC is set=
=2E
=20
 # If no C compiler was specified, use CC.
 LTCC=3D${LTCC-"$CC"}
=20
-# If no C compiler flags were specified, use CFLAGS.
-LTCFLAGS=3D${LTCFLAGS-"$CFLAGS"}
-
 # Allow CC to be a program name with arguments.
 compiler=3D$CC
=20
=20
-# save warnings/boilerplate of simple test code
-ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_compile_test_code" >conftest.$ac_ext
-eval "$ac_compile" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_compiler_boilerplate=3D`cat conftest.err`
-$rm conftest*
-
-ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_link_test_code" >conftest.$ac_ext
-eval "$ac_link" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_linker_boilerplate=3D`cat conftest.err`
-$rm conftest*
-
-
 # Allow CC to be a program name with arguments.
 lt_save_CC=3D"$CC"
 CC=3D${GCJ-"gcj"}
 compiler=3D$CC
 compiler_GCJ=3D$CC
-for cc_temp in $compiler""; do
-  case $cc_temp in
-    compile | *[\\/]compile | ccache | *[\\/]ccache ) ;;
-    distcc | *[\\/]distcc | purify | *[\\/]purify ) ;;
-    \-*) ;;
-    *) break;;
-  esac
-done
-cc_basename=3D`$echo "X$cc_temp" | $Xsed -e 's%.*/%%' -e "s%^$host_alias=
-%%"`
=20
-
 # GCJ did not exist at the time GCC didn't implicitly link libc in.
 archive_cmds_need_lc_GCJ=3Dno
=20
-old_archive_cmds_GCJ=3D$old_archive_cmds
=20
-
 lt_prog_compiler_no_builtin_flag_GCJ=3D
=20
 if test "$GCC" =3D yes; then
@@ -16627,20 +16578,18 @@
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    # The option is referenced via a variable to avoid confusing sed.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [^ ]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
-   (eval echo "\"\$as_me:16633: $lt_compile\"" >&5)
+   (eval echo "\"\$as_me:16584: $lt_compile\"" >&5)
    (eval "$lt_compile" 2>conftest.err)
    ac_status=3D$?
    cat conftest.err >&5
-   echo "$as_me:16637: \$? =3D $ac_status" >&5
+   echo "$as_me:16588: \$? =3D $ac_status" >&5
    if (exit $ac_status) && test -s "$ac_outfile"; then
      # The compiler can only warn and ignore the option if not recognize=
d
-     # So say no if there are warnings other than the usual output.
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' >conftest.exp
-     $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-     if test ! -s conftest.er2 || diff conftest.exp conftest.er2 >/dev/n=
ull; then
+     # So say no if there are warnings
+     if test ! -s conftest.err; then
        lt_cv_prog_compiler_rtti_exceptions=3Dyes
      fi
    fi
@@ -16701,11 +16650,6 @@
       lt_prog_compiler_pic_GCJ=3D'-fno-common'
       ;;
=20
-    interix3*)
-      # Interix 3.x gcc -fpic/-fPIC options generate broken code.
-      # Instead, we relocate shared libraries at runtime.
-      ;;
-
     msdosdjgpp*)
       # Just because we use GCC doesn't mean we suddenly get shared libr=
aries
       # on systems that don't support them.
@@ -16722,7 +16666,7 @@
     hpux*)
       # PIC is the default for IA64 HP-UX and 64-bit HP-UX, but
       # not for PA HP-UX.
-      case $host_cpu in
+      case "$host_cpu" in
       hppa*64*|ia64*)
 	# +Z the default
 	;;
@@ -16748,16 +16692,6 @@
 	lt_prog_compiler_static_GCJ=3D'-bnso -bI:/lib/syscalls.exp'
       fi
       ;;
-      darwin*)
-        # PIC is the default on this platform
-        # Common symbols not allowed in MH_DYLIB files
-       case $cc_basename in
-         xlc*)
-         lt_prog_compiler_pic_GCJ=3D'-qnocommon'
-         lt_prog_compiler_wl_GCJ=3D'-Wl,'
-         ;;
-       esac
-       ;;
=20
     mingw* | pw32* | os2*)
       # This hack is so that the source file can tell whether it is bein=
g
@@ -16769,7 +16703,7 @@
       lt_prog_compiler_wl_GCJ=3D'-Wl,'
       # PIC is the default for IA64 HP-UX and 64-bit HP-UX, but
       # not for PA HP-UX.
-      case $host_cpu in
+      case "$host_cpu" in
       hppa*64*|ia64*)
 	# +Z the default
 	;;
@@ -16793,19 +16727,12 @@
       ;;
=20
     linux*)
-      case $cc_basename in
+      case $CC in
       icc* | ecc*)
 	lt_prog_compiler_wl_GCJ=3D'-Wl,'
 	lt_prog_compiler_pic_GCJ=3D'-KPIC'
 	lt_prog_compiler_static_GCJ=3D'-static'
         ;;
-      pgcc* | pgf77* | pgf90* | pgf95*)
-        # Portland Group compilers (*not* the Pentium gcc compiler,
-	# which looks to be a dead project)
-	lt_prog_compiler_wl_GCJ=3D'-Wl,'
-	lt_prog_compiler_pic_GCJ=3D'-fpic'
-	lt_prog_compiler_static_GCJ=3D'-Bstatic'
-        ;;
       ccc*)
         lt_prog_compiler_wl_GCJ=3D'-Wl,'
         # All Alpha code is PIC.
@@ -16820,15 +16747,15 @@
       lt_prog_compiler_static_GCJ=3D'-non_shared'
       ;;
=20
+    sco3.2v5*)
+      lt_prog_compiler_pic_GCJ=3D'-Kpic'
+      lt_prog_compiler_static_GCJ=3D'-dn'
+      ;;
+
     solaris*)
+      lt_prog_compiler_wl_GCJ=3D'-Wl,'
       lt_prog_compiler_pic_GCJ=3D'-KPIC'
       lt_prog_compiler_static_GCJ=3D'-Bstatic'
-      case $cc_basename in
-      f77* | f90* | f95*)
-	lt_prog_compiler_wl_GCJ=3D'-Qoption ld ';;
-      *)
-	lt_prog_compiler_wl_GCJ=3D'-Wl,';;
-      esac
       ;;
=20
     sunos4*)
@@ -16837,7 +16764,7 @@
       lt_prog_compiler_static_GCJ=3D'-Bstatic'
       ;;
=20
-    sysv4 | sysv4.2uw2* | sysv4.3*)
+    sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
       lt_prog_compiler_wl_GCJ=3D'-Wl,'
       lt_prog_compiler_pic_GCJ=3D'-KPIC'
       lt_prog_compiler_static_GCJ=3D'-Bstatic'
@@ -16850,17 +16777,6 @@
       fi
       ;;
=20
-    sysv5* | unixware* | sco3.2v5* | sco5v6* | OpenUNIX*)
-      lt_prog_compiler_wl_GCJ=3D'-Wl,'
-      lt_prog_compiler_pic_GCJ=3D'-KPIC'
-      lt_prog_compiler_static_GCJ=3D'-Bstatic'
-      ;;
-
-    unicos*)
-      lt_prog_compiler_wl_GCJ=3D'-Wl,'
-      lt_prog_compiler_can_build_shared_GCJ=3Dno
-      ;;
-
     uts4*)
       lt_prog_compiler_pic_GCJ=3D'-pic'
       lt_prog_compiler_static_GCJ=3D'-Bstatic'
@@ -16895,20 +16811,18 @@
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    # The option is referenced via a variable to avoid confusing sed.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [^ ]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
-   (eval echo "\"\$as_me:16901: $lt_compile\"" >&5)
+   (eval echo "\"\$as_me:16817: $lt_compile\"" >&5)
    (eval "$lt_compile" 2>conftest.err)
    ac_status=3D$?
    cat conftest.err >&5
-   echo "$as_me:16905: \$? =3D $ac_status" >&5
+   echo "$as_me:16821: \$? =3D $ac_status" >&5
    if (exit $ac_status) && test -s "$ac_outfile"; then
      # The compiler can only warn and ignore the option if not recognize=
d
-     # So say no if there are warnings other than the usual output.
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' >conftest.exp
-     $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-     if test ! -s conftest.er2 || diff conftest.exp conftest.er2 >/dev/n=
ull; then
+     # So say no if there are warnings
+     if test ! -s conftest.err; then
        lt_prog_compiler_pic_works_GCJ=3Dyes
      fi
    fi
@@ -16929,7 +16843,7 @@
 fi
=20
 fi
-case $host_os in
+case "$host_os" in
   # For platforms which do not support PIC, -DPIC is meaningless:
   *djgpp*)
     lt_prog_compiler_pic_GCJ=3D
@@ -16939,48 +16853,6 @@
     ;;
 esac
=20
-#
-# Check to make sure the static flag actually works.
-#
-wl=3D$lt_prog_compiler_wl_GCJ eval lt_tmp_static_flag=3D\"$lt_prog_compi=
ler_static_GCJ\"
-echo "$as_me:$LINENO: checking if $compiler static flag $lt_tmp_static_f=
lag works" >&5
-echo $ECHO_N "checking if $compiler static flag $lt_tmp_static_flag work=
s... $ECHO_C" >&6
-if test "${lt_prog_compiler_static_works_GCJ+set}" =3D set; then
-  echo $ECHO_N "(cached) $ECHO_C" >&6
-else
-  lt_prog_compiler_static_works_GCJ=3Dno
-   save_LDFLAGS=3D"$LDFLAGS"
-   LDFLAGS=3D"$LDFLAGS $lt_tmp_static_flag"
-   printf "$lt_simple_link_test_code" > conftest.$ac_ext
-   if (eval $ac_link 2>conftest.err) && test -s conftest$ac_exeext; then
-     # The linker can only warn and ignore the option if not recognized
-     # So say no if there are warnings
-     if test -s conftest.err; then
-       # Append any errors to the config.log.
-       cat conftest.err 1>&5
-       $echo "X$_lt_linker_boilerplate" | $Xsed -e '/^$/d' > conftest.ex=
p
-       $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-       if diff conftest.exp conftest.er2 >/dev/null; then
-         lt_prog_compiler_static_works_GCJ=3Dyes
-       fi
-     else
-       lt_prog_compiler_static_works_GCJ=3Dyes
-     fi
-   fi
-   $rm conftest*
-   LDFLAGS=3D"$save_LDFLAGS"
-
-fi
-echo "$as_me:$LINENO: result: $lt_prog_compiler_static_works_GCJ" >&5
-echo "${ECHO_T}$lt_prog_compiler_static_works_GCJ" >&6
-
-if test x"$lt_prog_compiler_static_works_GCJ" =3D xyes; then
-    :
-else
-    lt_prog_compiler_static_GCJ=3D
-fi
-
-
 echo "$as_me:$LINENO: checking if $compiler supports -c -o file.$ac_obje=
xt" >&5
 echo $ECHO_N "checking if $compiler supports -c -o file.$ac_objext... $E=
CHO_C" >&6
 if test "${lt_cv_prog_compiler_c_o_GCJ+set}" =3D set; then
@@ -16999,25 +16871,23 @@
    # Note that $ac_compile itself does not contain backslashes and begin=
s
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [^ ]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
-   (eval echo "\"\$as_me:17005: $lt_compile\"" >&5)
+   (eval echo "\"\$as_me:16877: $lt_compile\"" >&5)
    (eval "$lt_compile" 2>out/conftest.err)
    ac_status=3D$?
    cat out/conftest.err >&5
-   echo "$as_me:17009: \$? =3D $ac_status" >&5
+   echo "$as_me:16881: \$? =3D $ac_status" >&5
    if (exit $ac_status) && test -s out/conftest2.$ac_objext
    then
      # The compiler can only warn and ignore the option if not recognize=
d
      # So say no if there are warnings
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' > out/conftes=
t.exp
-     $SED '/^$/d; /^ *+/d' out/conftest.err >out/conftest.er2
-     if test ! -s out/conftest.er2 || diff out/conftest.exp out/conftest=
.er2 >/dev/null; then
+     if test ! -s out/conftest.err; then
        lt_cv_prog_compiler_c_o_GCJ=3Dyes
      fi
    fi
-   chmod u+w . 2>&5
+   chmod u+w .
    $rm conftest*
    # SGI C++ compiler will create directory out/ii_files/ for
    # template instantiation
@@ -17093,16 +16963,6 @@
   # rely on this symbol name, it's probably fine to never include it in
   # preloaded symbol tables.
   extract_expsyms_cmds=3D
-  # Just being paranoid about ensuring that cc_basename is set.
-  for cc_temp in $compiler""; do
-  case $cc_temp in
-    compile | *[\\/]compile | ccache | *[\\/]ccache ) ;;
-    distcc | *[\\/]distcc | purify | *[\\/]purify ) ;;
-    \-*) ;;
-    *) break;;
-  esac
-done
-cc_basename=3D`$echo "X$cc_temp" | $Xsed -e 's%.*/%%' -e "s%^$host_alias=
-%%"`
=20
   case $host_os in
   cygwin* | mingw* | pw32*)
@@ -17113,10 +16973,6 @@
       with_gnu_ld=3Dno
     fi
     ;;
-  interix*)
-    # we just hope/assume this is gcc and not c89 (=3D MSVC++)
-    with_gnu_ld=3Dyes
-    ;;
   openbsd*)
     with_gnu_ld=3Dno
     ;;
@@ -17127,27 +16983,6 @@
     # If archive_cmds runs LD, not CC, wlarc should be empty
     wlarc=3D'${wl}'
=20
-    # Set some defaults for GNU ld with shared library support. These
-    # are reset later if shared libraries are not supported. Putting the=
m
-    # here allows them to be overridden if necessary.
-    runpath_var=3DLD_RUN_PATH
-    hardcode_libdir_flag_spec_GCJ=3D'${wl}--rpath ${wl}$libdir'
-    export_dynamic_flag_spec_GCJ=3D'${wl}--export-dynamic'
-    # ancient GNU ld didn't support --whole-archive et. al.
-    if $LD --help 2>&1 | grep 'no-whole-archive' > /dev/null; then
-	whole_archive_flag_spec_GCJ=3D"$wlarc"'--whole-archive$convenience '"$w=
larc"'--no-whole-archive'
-      else
-  	whole_archive_flag_spec_GCJ=3D
-    fi
-    supports_anon_versioning=3Dno
-    case `$LD -v 2>/dev/null` in
-      *\ [01].* | *\ 2.[0-9].* | *\ 2.10.*) ;; # catch versions < 2.11
-      *\ 2.11.93.0.2\ *) supports_anon_versioning=3Dyes ;; # RH7.3 ...
-      *\ 2.11.92.0.12\ *) supports_anon_versioning=3Dyes ;; # Mandrake 8=
.2 ...
-      *\ 2.11.*) ;; # other 2.11 versions
-      *) supports_anon_versioning=3Dyes ;;
-    esac
-
     # See if GNU ld supports shared libraries.
     case $host_os in
     aix3* | aix4* | aix5*)
@@ -17198,10 +17033,10 @@
       allow_undefined_flag_GCJ=3Dunsupported
       always_export_symbols_GCJ=3Dno
       enable_shared_with_static_runtimes_GCJ=3Dyes
-      export_symbols_cmds_GCJ=3D'$NM $libobjs $convenience | $global_sym=
bol_pipe | $SED -e '\''/^[BCDGRS] /s/.* \([^ ]*\)/\1 DATA/'\'' | $SED -e =
'\''/^[AITW] /s/.* //'\'' | sort | uniq > $export_symbols'
+      export_symbols_cmds_GCJ=3D'$NM $libobjs $convenience | $global_sym=
bol_pipe | $SED -e '\''/^[BCDGS] /s/.* \([^ ]*\)/\1 DATA/'\'' | $SED -e '=
\''/^[AITW] /s/.* //'\'' | sort | uniq > $export_symbols'
=20
       if $LD --help 2>&1 | grep 'auto-import' > /dev/null; then
-        archive_cmds_GCJ=3D'$CC -shared $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--enable-auto-image-base -Xlinker --out-=
implib -Xlinker $lib'
+        archive_cmds_GCJ=3D'$CC -shared $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--image-base=3D0x10000000 ${wl}--out-imp=
lib,$lib'
 	# If the export-symbols file already is a .def file (1st line
 	# is EXPORTS), use it as is; otherwise, prepend...
 	archive_expsym_cmds_GCJ=3D'if test "x`$SED 1q $export_symbols`" =3D xEX=
PORTS; then
@@ -17210,59 +17045,12 @@
 	  echo EXPORTS > $output_objdir/$soname.def;
 	  cat $export_symbols >> $output_objdir/$soname.def;
 	fi~
-	$CC -shared $output_objdir/$soname.def $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--enable-auto-image-base -Xlinker --out-=
implib -Xlinker $lib'
+	$CC -shared $output_objdir/$soname.def $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--image-base=3D0x10000000  ${wl}--out-im=
plib,$lib'
       else
-	ld_shlibs_GCJ=3Dno
+	ld_shlibs=3Dno
       fi
       ;;
=20
-    interix3*)
-      hardcode_direct_GCJ=3Dno
-      hardcode_shlibpath_var_GCJ=3Dno
-      hardcode_libdir_flag_spec_GCJ=3D'${wl}-rpath,$libdir'
-      export_dynamic_flag_spec_GCJ=3D'${wl}-E'
-      # Hack: On Interix 3.x, we cannot compile PIC because of a broken =
gcc.
-      # Instead, shared libraries are loaded at an image base (0x1000000=
0 by
-      # default) and relocated if they conflict, which is a slow very me=
mory
-      # consuming and fragmenting process.  To avoid this, we pick a ran=
dom,
-      # 256 KiB-aligned image base between 0x50000000 and 0x6FFC0000 at =
link
-      # time.  Moving up from 0x10000000 also allows more sbrk(2) space.
-      archive_cmds_GCJ=3D'$CC -shared $pic_flag $libobjs $deplibs $compi=
ler_flags ${wl}-h,$soname ${wl}--image-base,`expr ${RANDOM-$$} % 4096 / 2=
 \* 262144 + 1342177280` -o $lib'
-      archive_expsym_cmds_GCJ=3D'sed "s,^,_," $export_symbols >$output_o=
bjdir/$soname.expsym~$CC -shared $pic_flag $libobjs $deplibs $compiler_fl=
ags ${wl}-h,$soname ${wl}--retain-symbols-file,$output_objdir/$soname.exp=
sym ${wl}--image-base,`expr ${RANDOM-$$} % 4096 / 2 \* 262144 + 134217728=
0` -o $lib'
-      ;;
-
-    linux*)
-      if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null=
; then
-	tmp_addflag=3D
-	case $cc_basename,$host_cpu in
-	pgcc*)				# Portland Group C compiler
-	  whole_archive_flag_spec_GCJ=3D'${wl}--whole-archive`for conv in $conv=
enience\"\"; do test  -n \"$conv\" && new_convenience=3D\"$new_convenienc=
e,$conv\"; done; $echo \"$new_convenience\"` ${wl}--no-whole-archive'
-	  tmp_addflag=3D' $pic_flag'
-	  ;;
-	pgf77* | pgf90* | pgf95*)	# Portland Group f77 and f90 compilers
-	  whole_archive_flag_spec_GCJ=3D'${wl}--whole-archive`for conv in $conv=
enience\"\"; do test  -n \"$conv\" && new_convenience=3D\"$new_convenienc=
e,$conv\"; done; $echo \"$new_convenience\"` ${wl}--no-whole-archive'
-	  tmp_addflag=3D' $pic_flag -Mnomain' ;;
-	ecc*,ia64* | icc*,ia64*)		# Intel C compiler on ia64
-	  tmp_addflag=3D' -i_dynamic' ;;
-	efc*,ia64* | ifort*,ia64*)	# Intel Fortran compiler on ia64
-	  tmp_addflag=3D' -i_dynamic -nofor_main' ;;
-	ifc* | ifort*)			# Intel Fortran compiler
-	  tmp_addflag=3D' -nofor_main' ;;
-	esac
-	archive_cmds_GCJ=3D'$CC -shared'"$tmp_addflag"' $libobjs $deplibs $comp=
iler_flags ${wl}-soname $wl$soname -o $lib'
-
-	if test $supports_anon_versioning =3D yes; then
-	  archive_expsym_cmds_GCJ=3D'$echo "{ global:" > $output_objdir/$libnam=
e.ver~
-  cat $export_symbols | sed -e "s/\(.*\)/\1;/" >> $output_objdir/$libnam=
e.ver~
-  $echo "local: *; };" >> $output_objdir/$libname.ver~
-	  $CC -shared'"$tmp_addflag"' $libobjs $deplibs $compiler_flags ${wl}-s=
oname $wl$soname ${wl}-version-script ${wl}$output_objdir/$libname.ver -o=
 $lib'
-	fi
-	link_all_deplibs_GCJ=3Dno
-      else
-	ld_shlibs_GCJ=3Dno
-      fi
-      ;;
-
     netbsd* | netbsdelf*-gnu | knetbsd*-gnu)
       if echo __ELF__ | $CC -E - | grep __ELF__ >/dev/null; then
 	archive_cmds_GCJ=3D'$LD -Bshareable $libobjs $deplibs $linker_flags -o =
$lib'
@@ -17273,7 +17061,7 @@
       fi
       ;;
=20
-    solaris*)
+    solaris* | sysv5*)
       if $LD -v 2>&1 | grep 'BFD 2\.8' > /dev/null; then
 	ld_shlibs_GCJ=3Dno
 	cat <<EOF 1>&2
@@ -17294,33 +17082,6 @@
       fi
       ;;
=20
-    sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX*)
-      case `$LD -v 2>&1` in
-        *\ [01].* | *\ 2.[0-9].* | *\ 2.1[0-5].*)
-	ld_shlibs_GCJ=3Dno
-	cat <<_LT_EOF 1>&2
-
-*** Warning: Releases of the GNU linker prior to 2.16.91.0.3 can not
-*** reliably create shared libraries on SCO systems.  Therefore, libtool
-*** is disabling shared libraries support.  We urge you to upgrade GNU
-*** binutils to release 2.16.91.0.3 or newer.  Another option is to modi=
fy
-*** your PATH or compiler configuration so that the native linker is
-*** used, and then restart.
-
-_LT_EOF
-	;;
-	*)
-	  if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null; t=
hen
-	    hardcode_libdir_flag_spec_GCJ=3D'`test -z "$SCOABSPATH" && echo ${w=
l}-rpath,$libdir`'
-	    archive_cmds_GCJ=3D'$CC -shared $libobjs $deplibs $compiler_flags $=
{wl}-soname,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib'
-	    archive_expsym_cmds_GCJ=3D'$CC -shared $libobjs $deplibs $compiler_=
flags ${wl}-soname,\${SCOABSPATH:+${install_libdir}/}$soname,-retain-symb=
ols-file,$export_symbols -o $lib'
-	  else
-	    ld_shlibs_GCJ=3Dno
-	  fi
-	;;
-      esac
-      ;;
-
     sunos4*)
       archive_cmds_GCJ=3D'$LD -assert pure-text -Bshareable -o $lib $lib=
objs $deplibs $linker_flags'
       wlarc=3D
@@ -17328,6 +17089,32 @@
       hardcode_shlibpath_var_GCJ=3Dno
       ;;
=20
+  linux*)
+    if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null; =
then
+        tmp_archive_cmds=3D'$CC -shared $libobjs $deplibs $compiler_flag=
s ${wl}-soname $wl$soname -o $lib'
+	archive_cmds_GCJ=3D"$tmp_archive_cmds"
+      supports_anon_versioning=3Dno
+      case `$LD -v 2>/dev/null` in
+        *\ 01.* | *\ 2.[0-9].* | *\ 2.10.*) ;; # catch versions < 2.11
+        *\ 2.11.93.0.2\ *) supports_anon_versioning=3Dyes ;; # RH7.3 ...
+        *\ 2.11.92.0.12\ *) supports_anon_versioning=3Dyes ;; # Mandrake=
 8.2 ...
+        *\ 2.11.*) ;; # other 2.11 versions
+        *) supports_anon_versioning=3Dyes ;;
+      esac
+      if test $supports_anon_versioning =3D yes; then
+        archive_expsym_cmds_GCJ=3D'$echo "{ global:" > $output_objdir/$l=
ibname.ver~
+cat $export_symbols | sed -e "s/\(.*\)/\1;/" >> $output_objdir/$libname.=
ver~
+$echo "local: *; };" >> $output_objdir/$libname.ver~
+        $CC -shared $libobjs $deplibs $compiler_flags ${wl}-soname $wl$s=
oname ${wl}-version-script ${wl}$output_objdir/$libname.ver -o $lib'
+      else
+        archive_expsym_cmds_GCJ=3D"$tmp_archive_cmds"
+      fi
+      link_all_deplibs_GCJ=3Dno
+    else
+      ld_shlibs_GCJ=3Dno
+    fi
+    ;;
+
     *)
       if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null=
; then
 	archive_cmds_GCJ=3D'$CC -shared $libobjs $deplibs $compiler_flags ${wl}=
-soname $wl$soname -o $lib'
@@ -17338,11 +17125,16 @@
       ;;
     esac
=20
-    if test "$ld_shlibs_GCJ" =3D no; then
-      runpath_var=3D
-      hardcode_libdir_flag_spec_GCJ=3D
-      export_dynamic_flag_spec_GCJ=3D
-      whole_archive_flag_spec_GCJ=3D
+    if test "$ld_shlibs_GCJ" =3D yes; then
+      runpath_var=3DLD_RUN_PATH
+      hardcode_libdir_flag_spec_GCJ=3D'${wl}--rpath ${wl}$libdir'
+      export_dynamic_flag_spec_GCJ=3D'${wl}--export-dynamic'
+      # ancient GNU ld didn't support --whole-archive et. al.
+      if $LD --help 2>&1 | grep 'no-whole-archive' > /dev/null; then
+ 	whole_archive_flag_spec_GCJ=3D"$wlarc"'--whole-archive$convenience '"$=
wlarc"'--no-whole-archive'
+      else
+  	whole_archive_flag_spec_GCJ=3D
+      fi
     fi
   else
     # PORTME fill in a description of your system's linker (not GNU ld)
@@ -17354,7 +17146,7 @@
       # Note: this linker hardcodes the directories in LIBPATH if there
       # are no directories specified by -L.
       hardcode_minus_L_GCJ=3Dyes
-      if test "$GCC" =3D yes && test -z "$lt_prog_compiler_static"; then
+      if test "$GCC" =3D yes && test -z "$link_static_flag"; then
 	# Neither direct hardcoding nor static linking is supported with a
 	# broken collect2.
 	hardcode_direct_GCJ=3Dunsupported
@@ -17388,7 +17180,6 @@
   	    break
   	  fi
 	  done
-	  ;;
 	esac
=20
 	exp_sym_flag=3D'-bexport'
@@ -17407,7 +17198,7 @@
       link_all_deplibs_GCJ=3Dyes
=20
       if test "$GCC" =3D yes; then
-	case $host_os in aix4.[012]|aix4.[012].*)
+	case $host_os in aix4.012|aix4.012.*)
 	# We only want to do this on AIX 4.2 and lower, the check
 	# below for broken collect2 doesn't work under 4.3+
 	  collect2name=3D`${CC} -print-prog-name=3Dcollect2`
@@ -17426,12 +17217,8 @@
   	  hardcode_libdir_flag_spec_GCJ=3D'-L$libdir'
   	  hardcode_libdir_separator_GCJ=3D
 	  fi
-	  ;;
 	esac
 	shared_flag=3D'-shared'
-	if test "$aix_use_runtimelinking" =3D yes; then
-	  shared_flag=3D"$shared_flag "'${wl}-G'
-	fi
       else
 	# not using gcc
 	if test "$host_cpu" =3D ia64; then
@@ -17439,11 +17226,11 @@
   	# chokes on -Wl,-G. The following line is correct:
 	  shared_flag=3D'-G'
 	else
-	  if test "$aix_use_runtimelinking" =3D yes; then
+  	if test "$aix_use_runtimelinking" =3D yes; then
 	    shared_flag=3D'${wl}-G'
 	  else
 	    shared_flag=3D'${wl}-bM:SRE'
-	  fi
+  	fi
 	fi
       fi
=20
@@ -17507,12 +17294,12 @@
 if test -z "$aix_libpath"; then aix_libpath=3D"/usr/lib:/lib"; fi
=20
        hardcode_libdir_flag_spec_GCJ=3D'${wl}-blibpath:$libdir:'"$aix_li=
bpath"
-	archive_expsym_cmds_GCJ=3D"\$CC"' -o $output_objdir/$soname $libobjs $d=
eplibs '"\${wl}$no_entry_flag"' $compiler_flags `if test "x${allow_undefi=
ned_flag}" !=3D "x"; then echo "${wl}${allow_undefined_flag}"; else :; fi=
` '"\${wl}$exp_sym_flag:\$export_symbols $shared_flag"
+	archive_expsym_cmds_GCJ=3D"\$CC"' -o $output_objdir/$soname $libobjs $d=
eplibs $compiler_flags `if test "x${allow_undefined_flag}" !=3D "x"; then=
 echo "${wl}${allow_undefined_flag}"; else :; fi` '"\${wl}$no_entry_flag =
\${wl}$exp_sym_flag:\$export_symbols $shared_flag"
        else
 	if test "$host_cpu" =3D ia64; then
 	  hardcode_libdir_flag_spec_GCJ=3D'${wl}-R $libdir:/usr/lib:/lib'
 	  allow_undefined_flag_GCJ=3D"-z nodefs"
-	  archive_expsym_cmds_GCJ=3D"\$CC $shared_flag"' -o $output_objdir/$son=
ame $libobjs $deplibs '"\${wl}$no_entry_flag"' $compiler_flags ${wl}${all=
ow_undefined_flag} '"\${wl}$exp_sym_flag:\$export_symbols"
+	  archive_expsym_cmds_GCJ=3D"\$CC $shared_flag"' -o $output_objdir/$son=
ame $libobjs $deplibs $compiler_flags ${wl}${allow_undefined_flag} '"\${w=
l}$no_entry_flag \${wl}$exp_sym_flag:\$export_symbols"
 	else
 	 # Determine the default libpath from the value encoded in an empty exe=
cutable.
 	 cat >conftest.$ac_ext <<_ACEOF
@@ -17571,11 +17358,13 @@
 	  # -berok will link without error, but may produce a broken library.
 	  no_undefined_flag_GCJ=3D' ${wl}-bernotok'
 	  allow_undefined_flag_GCJ=3D' ${wl}-berok'
+	  # -bexpall does not export symbols beginning with underscore (_)
+	  always_export_symbols_GCJ=3Dyes
 	  # Exported symbols can be pulled into shared objects from archives
-	  whole_archive_flag_spec_GCJ=3D'$convenience'
+	  whole_archive_flag_spec_GCJ=3D' '
 	  archive_cmds_need_lc_GCJ=3Dyes
-	  # This is similar to how AIX traditionally builds its shared librarie=
s.
-	  archive_expsym_cmds_GCJ=3D"\$CC $shared_flag"' -o $output_objdir/$son=
ame $libobjs $deplibs ${wl}-bnoentry $compiler_flags ${wl}-bE:$export_sym=
bols${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$libname$release=
.a $output_objdir/$soname'
+	  # This is similar to how AIX traditionally builds it's shared librari=
es.
+	  archive_expsym_cmds_GCJ=3D"\$CC $shared_flag"' -o $output_objdir/$son=
ame $libobjs $deplibs $compiler_flags ${wl}-bE:$export_symbols ${wl}-bnoe=
ntry${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$libname$release=
.a $output_objdir/$soname'
 	fi
       fi
       ;;
@@ -17588,7 +17377,7 @@
       ld_shlibs_GCJ=3Dno
       ;;
=20
-    bsdi[45]*)
+    bsdi4*)
       export_dynamic_flag_spec_GCJ=3D-rdynamic
       ;;
=20
@@ -17609,57 +17398,57 @@
       old_archive_From_new_cmds_GCJ=3D'true'
       # FIXME: Should let the user specify the lib program.
       old_archive_cmds_GCJ=3D'lib /OUT:$oldlib$oldobjs$old_deplibs'
-      fix_srcfile_path_GCJ=3D'`cygpath -w "$srcfile"`'
+      fix_srcfile_path=3D'`cygpath -w "$srcfile"`'
       enable_shared_with_static_runtimes_GCJ=3Dyes
       ;;
=20
     darwin* | rhapsody*)
-      case $host_os in
-        rhapsody* | darwin1.[012])
-         allow_undefined_flag_GCJ=3D'${wl}-undefined ${wl}suppress'
-         ;;
-       *) # Darwin 1.3 on
-         if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
-           allow_undefined_flag_GCJ=3D'${wl}-flat_namespace ${wl}-undefi=
ned ${wl}suppress'
-         else
-           case ${MACOSX_DEPLOYMENT_TARGET} in
-             10.[012])
-               allow_undefined_flag_GCJ=3D'${wl}-flat_namespace ${wl}-un=
defined ${wl}suppress'
-               ;;
-             10.*)
-               allow_undefined_flag_GCJ=3D'${wl}-undefined ${wl}dynamic_=
lookup'
-               ;;
-           esac
-         fi
-         ;;
+    if test "$GXX" =3D yes ; then
+      archive_cmds_need_lc_GCJ=3Dno
+      case "$host_os" in
+      rhapsody* | darwin1.[012])
+	allow_undefined_flag_GCJ=3D'-undefined suppress'
+	;;
+      *) # Darwin 1.3 on
+      if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
+      	allow_undefined_flag_GCJ=3D'-flat_namespace -undefined suppress'
+      else
+        case ${MACOSX_DEPLOYMENT_TARGET} in
+          10.[012])
+            allow_undefined_flag_GCJ=3D'-flat_namespace -undefined suppr=
ess'
+            ;;
+          10.*)
+            allow_undefined_flag_GCJ=3D'-undefined dynamic_lookup'
+            ;;
+        esac
+      fi
+	;;
       esac
-      archive_cmds_need_lc_GCJ=3Dno
+    	lt_int_apple_cc_single_mod=3Dno
+    	output_verbose_link_cmd=3D'echo'
+    	if $CC -dumpspecs 2>&1 | grep 'single_module' >/dev/null ; then
+    	  lt_int_apple_cc_single_mod=3Dyes
+    	fi
+    	if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+    	  archive_cmds_GCJ=3D'$CC -dynamiclib -single_module $allow_undefin=
ed_flag -o $lib $libobjs $deplibs $compiler_flags -install_name $rpath/$s=
oname $verstring'
+    	else
+        archive_cmds_GCJ=3D'$CC -r ${wl}-bind_at_load -keep_private_exte=
rns -nostdlib -o ${lib}-master.o $libobjs~$CC -dynamiclib $allow_undefine=
d_flag -o $lib ${lib}-master.o $deplibs $compiler_flags -install_name $rp=
ath/$soname $verstring'
+      fi
+      module_cmds_GCJ=3D'$CC ${wl}-bind_at_load $allow_undefined_flag -o=
 $lib -bundle $libobjs $deplibs$compiler_flags'
+      # Don't fix this by using the ld -exported_symbols_list flag, it d=
oesn't exist in older darwin ld's
+        if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+          archive_expsym_cmds_GCJ=3D'sed -e "s,#.*,," -e "s,^[    ]*,," =
-e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols=
.expsym~$CC -dynamiclib -single_module $allow_undefined_flag -o $lib $lib=
objs $deplibs $compiler_flags -install_name $rpath/$soname $verstring~nme=
dit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+        else
+          archive_expsym_cmds_GCJ=3D'sed -e "s,#.*,," -e "s,^[    ]*,," =
-e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols=
.expsym~$CC -r ${wl}-bind_at_load -keep_private_externs -nostdlib -o ${li=
b}-master.o $libobjs~$CC -dynamiclib $allow_undefined_flag -o $lib ${lib}=
-master.o $deplibs $compiler_flags -install_name $rpath/$soname $verstrin=
g~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+        fi
+          module_expsym_cmds_GCJ=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -=
e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.=
expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compi=
ler_flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
       hardcode_direct_GCJ=3Dno
       hardcode_automatic_GCJ=3Dyes
       hardcode_shlibpath_var_GCJ=3Dunsupported
-      whole_archive_flag_spec_GCJ=3D''
+      whole_archive_flag_spec_GCJ=3D'-all_load $convenience'
       link_all_deplibs_GCJ=3Dyes
-    if test "$GCC" =3D yes ; then
-    	output_verbose_link_cmd=3D'echo'
-        archive_cmds_GCJ=3D'$CC -dynamiclib $allow_undefined_flag -o $li=
b $libobjs $deplibs $compiler_flags -install_name $rpath/$soname $verstri=
ng'
-      module_cmds_GCJ=3D'$CC $allow_undefined_flag -o $lib -bundle $libo=
bjs $deplibs$compiler_flags'
-      # Don't fix this by using the ld -exported_symbols_list flag, it d=
oesn't exist in older darwin lds
-      archive_expsym_cmds_GCJ=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "=
s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exp=
sym~$CC -dynamiclib $allow_undefined_flag -o $lib $libobjs $deplibs $comp=
iler_flags -install_name $rpath/$soname $verstring~nmedit -s $output_objd=
ir/${libname}-symbols.expsym ${lib}'
-      module_expsym_cmds_GCJ=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -e "s=
,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.exps=
ym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compiler_=
flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
     else
-      case $cc_basename in
-        xlc*)
-         output_verbose_link_cmd=3D'echo'
-         archive_cmds_GCJ=3D'$CC -qmkshrobj $allow_undefined_flag -o $li=
b $libobjs $deplibs $compiler_flags ${wl}-install_name ${wl}`echo $rpath/=
$soname` $verstring'
-         module_cmds_GCJ=3D'$CC $allow_undefined_flag -o $lib -bundle $l=
ibobjs $deplibs$compiler_flags'
-          # Don't fix this by using the ld -exported_symbols_list flag, =
it doesn't exist in older darwin lds
-         archive_expsym_cmds_GCJ=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -=
e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.=
expsym~$CC -qmkshrobj $allow_undefined_flag -o $lib $libobjs $deplibs $co=
mpiler_flags ${wl}-install_name ${wl}$rpath/$soname $verstring~nmedit -s =
$output_objdir/${libname}-symbols.expsym ${lib}'
-          module_expsym_cmds_GCJ=3D'sed -e "s,#.*,," -e "s,^[    ]*,," -=
e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}-symbols.=
expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $deplibs$compi=
ler_flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
-          ;;
-       *)
-         ld_shlibs_GCJ=3Dno
-          ;;
-      esac
+      ld_shlibs_GCJ=3Dno
     fi
       ;;
=20
@@ -17693,22 +17482,13 @@
       ;;
=20
     # FreeBSD 3 and greater uses gcc -shared to do shared libraries.
-    freebsd* | dragonfly*)
+    freebsd* | kfreebsd*-gnu)
       archive_cmds_GCJ=3D'$CC -shared -o $lib $libobjs $deplibs $compile=
r_flags'
       hardcode_libdir_flag_spec_GCJ=3D'-R$libdir'
       hardcode_direct_GCJ=3Dyes
       hardcode_shlibpath_var_GCJ=3Dno
       ;;
=20
-    # GNU/kFreeBSD uses gcc -shared to do shared libraries.
-    kfreebsd*-gnu)
-      archive_cmds_GCJ=3D'$CC -shared -o $lib $libobjs $deplibs $compile=
r_flags'
-      hardcode_libdir_flag_spec_GCJ=3D'-R$libdir'
-      hardcode_direct_GCJ=3Dyes
-      hardcode_shlibpath_var_GCJ=3Dno
-      link_all_deplibs_GCJ=3Dno
-      ;;
-
     hpux9*)
       if test "$GCC" =3D yes; then
 	archive_cmds_GCJ=3D'$rm $output_objdir/$soname~$CC -shared -fPIC ${wl}+=
b ${wl}$install_libdir -o $output_objdir/$soname $libobjs $deplibs $compi=
ler_flags~test $output_objdir/$soname =3D $lib || mv $output_objdir/$sona=
me $lib'
@@ -17725,62 +17505,47 @@
       export_dynamic_flag_spec_GCJ=3D'${wl}-E'
       ;;
=20
-    hpux10*)
+    hpux10* | hpux11*)
       if test "$GCC" =3D yes -a "$with_gnu_ld" =3D no; then
-	archive_cmds_GCJ=3D'$CC -shared -fPIC ${wl}+h ${wl}$soname ${wl}+b ${wl=
}$install_libdir -o $lib $libobjs $deplibs $compiler_flags'
-      else
-	archive_cmds_GCJ=3D'$LD -b +h $soname +b $install_libdir -o $lib $libob=
js $deplibs $linker_flags'
-      fi
-      if test "$with_gnu_ld" =3D no; then
-	hardcode_libdir_flag_spec_GCJ=3D'${wl}+b ${wl}$libdir'
-	hardcode_libdir_separator_GCJ=3D:
-
-	hardcode_direct_GCJ=3Dyes
-	export_dynamic_flag_spec_GCJ=3D'${wl}-E'
-
-	# hardcode_minus_L: Not really in the search PATH,
-	# but as the default location of the library.
-	hardcode_minus_L_GCJ=3Dyes
-      fi
-      ;;
-
-    hpux11*)
-      if test "$GCC" =3D yes -a "$with_gnu_ld" =3D no; then
-	case $host_cpu in
-	hppa*64*)
+	case "$host_cpu" in
+	hppa*64*|ia64*)
 	  archive_cmds_GCJ=3D'$CC -shared ${wl}+h ${wl}$soname -o $lib $libobjs=
 $deplibs $compiler_flags'
 	  ;;
-	ia64*)
-	  archive_cmds_GCJ=3D'$CC -shared ${wl}+h ${wl}$soname ${wl}+nodefaultr=
path -o $lib $libobjs $deplibs $compiler_flags'
-	  ;;
 	*)
 	  archive_cmds_GCJ=3D'$CC -shared -fPIC ${wl}+h ${wl}$soname ${wl}+b ${=
wl}$install_libdir -o $lib $libobjs $deplibs $compiler_flags'
 	  ;;
 	esac
       else
-	case $host_cpu in
-	hppa*64*)
-	  archive_cmds_GCJ=3D'$CC -b ${wl}+h ${wl}$soname -o $lib $libobjs $dep=
libs $compiler_flags'
+	case "$host_cpu" in
+	hppa*64*|ia64*)
+	  archive_cmds_GCJ=3D'$LD -b +h $soname -o $lib $libobjs $deplibs $link=
er_flags'
 	  ;;
-	ia64*)
-	  archive_cmds_GCJ=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+nodefaultrpath =
-o $lib $libobjs $deplibs $compiler_flags'
-	  ;;
 	*)
-	  archive_cmds_GCJ=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+b ${wl}$install=
_libdir -o $lib $libobjs $deplibs $compiler_flags'
+	  archive_cmds_GCJ=3D'$LD -b +h $soname +b $install_libdir -o $lib $lib=
objs $deplibs $linker_flags'
 	  ;;
 	esac
       fi
       if test "$with_gnu_ld" =3D no; then
-	hardcode_libdir_flag_spec_GCJ=3D'${wl}+b ${wl}$libdir'
-	hardcode_libdir_separator_GCJ=3D:
-
-	case $host_cpu in
-	hppa*64*|ia64*)
+	case "$host_cpu" in
+	hppa*64*)
+	  hardcode_libdir_flag_spec_GCJ=3D'${wl}+b ${wl}$libdir'
 	  hardcode_libdir_flag_spec_ld_GCJ=3D'+b $libdir'
+	  hardcode_libdir_separator_GCJ=3D:
 	  hardcode_direct_GCJ=3Dno
 	  hardcode_shlibpath_var_GCJ=3Dno
 	  ;;
+	ia64*)
+	  hardcode_libdir_flag_spec_GCJ=3D'-L$libdir'
+	  hardcode_direct_GCJ=3Dno
+	  hardcode_shlibpath_var_GCJ=3Dno
+
+	  # hardcode_minus_L: Not really in the search PATH,
+	  # but as the default location of the library.
+	  hardcode_minus_L_GCJ=3Dyes
+	  ;;
 	*)
+	  hardcode_libdir_flag_spec_GCJ=3D'${wl}+b ${wl}$libdir'
+	  hardcode_libdir_separator_GCJ=3D:
 	  hardcode_direct_GCJ=3Dyes
 	  export_dynamic_flag_spec_GCJ=3D'${wl}-E'
=20
@@ -17828,7 +17593,6 @@
       hardcode_shlibpath_var_GCJ=3Dno
       if test -z "`echo __ELF__ | $CC -E - | grep __ELF__`" || test "$ho=
st_os-$host_cpu" =3D "openbsd2.8-powerpc"; then
 	archive_cmds_GCJ=3D'$CC -shared $pic_flag -o $lib $libobjs $deplibs $co=
mpiler_flags'
-	archive_expsym_cmds_GCJ=3D'$CC -shared $pic_flag -o $lib $libobjs $depl=
ibs $compiler_flags ${wl}-retain-symbols-file,$export_symbols'
 	hardcode_libdir_flag_spec_GCJ=3D'${wl}-rpath,$libdir'
 	export_dynamic_flag_spec_GCJ=3D'${wl}-E'
       else
@@ -17874,7 +17638,7 @@
 	allow_undefined_flag_GCJ=3D' -expect_unresolved \*'
 	archive_cmds_GCJ=3D'$LD -shared${allow_undefined_flag} $libobjs $deplib=
s $linker_flags -msym -soname $soname `test -n "$verstring" && echo -set_=
version $verstring` -update_registry ${output_objdir}/so_locations -o $li=
b'
 	archive_expsym_cmds_GCJ=3D'for i in `cat $export_symbols`; do printf "%=
s %s\\n" -exported_symbol "\$i" >> $lib.exp; done; echo "-hidden">> $lib.=
exp~
-	$LD -shared${allow_undefined_flag} -input $lib.exp $linker_flags $libob=
js $deplibs -soname $soname `test -n "$verstring" && echo -set_version $v=
erstring` -update_registry ${output_objdir}/so_locations -o $lib~$rm $lib=
.exp'
+	$LD -shared${allow_undefined_flag} -input $lib.exp $linker_flags $libob=
js $deplibs -soname $soname `test -n "$verstring" && echo -set_version $v=
erstring` -update_registry ${objdir}/so_locations -o $lib~$rm $lib.exp'
=20
 	# Both c and cxx compiler support -rpath directly
 	hardcode_libdir_flag_spec_GCJ=3D'-rpath $libdir'
@@ -17882,15 +17646,21 @@
       hardcode_libdir_separator_GCJ=3D:
       ;;
=20
+    sco3.2v5*)
+      archive_cmds_GCJ=3D'$LD -G -h $soname -o $lib $libobjs $deplibs $l=
inker_flags'
+      hardcode_shlibpath_var_GCJ=3Dno
+      export_dynamic_flag_spec_GCJ=3D'${wl}-Bexport'
+      runpath_var=3DLD_RUN_PATH
+      hardcode_runpath_var=3Dyes
+      ;;
+
     solaris*)
       no_undefined_flag_GCJ=3D' -z text'
       if test "$GCC" =3D yes; then
-	wlarc=3D'${wl}'
 	archive_cmds_GCJ=3D'$CC -shared ${wl}-h ${wl}$soname -o $lib $libobjs $=
deplibs $compiler_flags'
 	archive_expsym_cmds_GCJ=3D'$echo "{ global:" > $lib.exp~cat $export_sym=
bols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *; };" >> $lib.e=
xp~
 	  $CC -shared ${wl}-M ${wl}$lib.exp ${wl}-h ${wl}$soname -o $lib $libob=
js $deplibs $compiler_flags~$rm $lib.exp'
       else
-	wlarc=3D''
 	archive_cmds_GCJ=3D'$LD -G${allow_undefined_flag} -h $soname -o $lib $l=
ibobjs $deplibs $linker_flags'
 	archive_expsym_cmds_GCJ=3D'$echo "{ global:" > $lib.exp~cat $export_sym=
bols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *; };" >> $lib.e=
xp~
   	$LD -G${allow_undefined_flag} -M $lib.exp -h $soname -o $lib $libobjs=
 $deplibs $linker_flags~$rm $lib.exp'
@@ -17899,18 +17669,8 @@
       hardcode_shlibpath_var_GCJ=3Dno
       case $host_os in
       solaris2.[0-5] | solaris2.[0-5].*) ;;
-      *)
- 	# The compiler driver will combine linker options so we
- 	# cannot just pass the convience library names through
- 	# without $wl, iff we do not link with $LD.
- 	# Luckily, gcc supports the same syntax we need for Sun Studio.
- 	# Supported since Solaris 2.6 (maybe 2.5.1?)
- 	case $wlarc in
- 	'')
- 	  whole_archive_flag_spec_GCJ=3D'-z allextract$convenience -z defaulte=
xtract' ;;
- 	*)
- 	  whole_archive_flag_spec_GCJ=3D'${wl}-z ${wl}allextract`for conv in $=
convenience\"\"; do test -n \"$conv\" && new_convenience=3D\"$new_conveni=
ence,$conv\"; done; $echo \"$new_convenience\"` ${wl}-z ${wl}defaultextra=
ct' ;;
- 	esac ;;
+      *) # Supported since Solaris 2.6 (maybe 2.5.1?)
+	whole_archive_flag_spec_GCJ=3D'-z allextract$convenience -z defaultextr=
act' ;;
       esac
       link_all_deplibs_GCJ=3Dyes
       ;;
@@ -17967,45 +17727,36 @@
       fi
       ;;
=20
-    sysv4*uw2* | sysv5OpenUNIX* | sysv5UnixWare7.[01].[10]* | unixware7*=
)
-      no_undefined_flag_GCJ=3D'${wl}-z,text'
-      archive_cmds_need_lc_GCJ=3Dno
+    sysv4.2uw2*)
+      archive_cmds_GCJ=3D'$LD -G -o $lib $libobjs $deplibs $linker_flags=
'
+      hardcode_direct_GCJ=3Dyes
+      hardcode_minus_L_GCJ=3Dno
       hardcode_shlibpath_var_GCJ=3Dno
-      runpath_var=3D'LD_RUN_PATH'
+      hardcode_runpath_var=3Dyes
+      runpath_var=3DLD_RUN_PATH
+      ;;
=20
+   sysv5OpenUNIX8* | sysv5UnixWare7* |  sysv5uw[78]* | unixware7*)
+      no_undefined_flag_GCJ=3D'${wl}-z ${wl}text'
       if test "$GCC" =3D yes; then
-	archive_cmds_GCJ=3D'$CC -shared ${wl}-h,$soname -o $lib $libobjs $depli=
bs $compiler_flags'
-	archive_expsym_cmds_GCJ=3D'$CC -shared ${wl}-Bexport:$export_symbols ${=
wl}-h,$soname -o $lib $libobjs $deplibs $compiler_flags'
+	archive_cmds_GCJ=3D'$CC -shared ${wl}-h ${wl}$soname -o $lib $libobjs $=
deplibs $compiler_flags'
       else
-	archive_cmds_GCJ=3D'$CC -G ${wl}-h,$soname -o $lib $libobjs $deplibs $c=
ompiler_flags'
-	archive_expsym_cmds_GCJ=3D'$CC -G ${wl}-Bexport:$export_symbols ${wl}-h=
,$soname -o $lib $libobjs $deplibs $compiler_flags'
+	archive_cmds_GCJ=3D'$CC -G ${wl}-h ${wl}$soname -o $lib $libobjs $depli=
bs $compiler_flags'
       fi
+      runpath_var=3D'LD_RUN_PATH'
+      hardcode_shlibpath_var_GCJ=3Dno
       ;;
=20
-    sysv5* | sco3.2v5* | sco5v6*)
-      # Note: We can NOT use -z defs as we might desire, because we do n=
ot
-      # link with -lc, and that would cause any symbols used from libc t=
o
-      # always be unresolved, which means just about no library would
-      # ever link correctly.  If we're not using GNU ld we use -z text
-      # though, which does catch some bad symbols but isn't as heavy-han=
ded
-      # as -z defs.
-      no_undefined_flag_GCJ=3D'${wl}-z,text'
-      allow_undefined_flag_GCJ=3D'${wl}-z,nodefs'
-      archive_cmds_need_lc_GCJ=3Dno
+    sysv5*)
+      no_undefined_flag_GCJ=3D' -z text'
+      # $CC -shared without GNU ld will not create a library from C++
+      # object files and a static libstdc++, better avoid it by now
+      archive_cmds_GCJ=3D'$LD -G${allow_undefined_flag} -h $soname -o $l=
ib $libobjs $deplibs $linker_flags'
+      archive_expsym_cmds_GCJ=3D'$echo "{ global:" > $lib.exp~cat $expor=
t_symbols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *; };" >> $=
lib.exp~
+  		$LD -G${allow_undefined_flag} -M $lib.exp -h $soname -o $lib $libobj=
s $deplibs $linker_flags~$rm $lib.exp'
+      hardcode_libdir_flag_spec_GCJ=3D
       hardcode_shlibpath_var_GCJ=3Dno
-      hardcode_libdir_flag_spec_GCJ=3D'`test -z "$SCOABSPATH" && echo ${=
wl}-R,$libdir`'
-      hardcode_libdir_separator_GCJ=3D':'
-      link_all_deplibs_GCJ=3Dyes
-      export_dynamic_flag_spec_GCJ=3D'${wl}-Bexport'
       runpath_var=3D'LD_RUN_PATH'
-
-      if test "$GCC" =3D yes; then
-	archive_cmds_GCJ=3D'$CC -shared ${wl}-h,\${SCOABSPATH:+${install_libdir=
}/}$soname -o $lib $libobjs $deplibs $compiler_flags'
-	archive_expsym_cmds_GCJ=3D'$CC -shared ${wl}-Bexport:$export_symbols ${=
wl}-h,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $libobjs $deplibs=
 $compiler_flags'
-      else
-	archive_cmds_GCJ=3D'$CC -G ${wl}-h,\${SCOABSPATH:+${install_libdir}/}$s=
oname -o $lib $libobjs $deplibs $compiler_flags'
-	archive_expsym_cmds_GCJ=3D'$CC -G ${wl}-Bexport:$export_symbols ${wl}-h=
,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $libobjs $deplibs $com=
piler_flags'
-      fi
       ;;
=20
     uts4*)
@@ -18024,6 +17775,11 @@
 echo "${ECHO_T}$ld_shlibs_GCJ" >&6
 test "$ld_shlibs_GCJ" =3D no && can_build_shared=3Dno
=20
+variables_saved_for_relink=3D"PATH $shlibpath_var $runpath_var"
+if test "$GCC" =3D yes; then
+  variables_saved_for_relink=3D"$variables_saved_for_relink GCC_EXEC_PRE=
FIX COMPILER_PATH LIBRARY_PATH"
+fi
+
 #
 # Do we need to explicitly link libc?
 #
@@ -18056,7 +17812,6 @@
         libobjs=3Dconftest.$ac_objext
         deplibs=3D
         wl=3D$lt_prog_compiler_wl_GCJ
-	pic_flag=3D$lt_prog_compiler_pic_GCJ
         compiler_flags=3D-v
         linker_flags=3D-v
         verstring=3D
@@ -18189,7 +17944,7 @@
   shlibpath_var=3DLIBRARY_PATH
   ;;
=20
-bsdi[45]*)
+bsdi4*)
   version_type=3Dlinux
   need_version=3Dno
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
@@ -18217,8 +17972,7 @@
       dlpath=3D`$SHELL 2>&1 -c '\''. $dir/'\''\${base_file}'\''i;echo \$=
dlname'\''`~
       dldir=3D$destdir/`dirname \$dlpath`~
       test -d \$dldir || mkdir -p \$dldir~
-      $install_prog $dir/$dlname \$dldir/$dlname~
-      chmod a+x \$dldir/$dlname'
+      $install_prog $dir/$dlname \$dldir/$dlname'
     postuninstall_cmds=3D'dldll=3D`$SHELL 2>&1 -c '\''. $file; echo \$dl=
name'\''`~
       dlpath=3D$dir/\$dldll~
        $rm \$dlpath'
@@ -18248,7 +18002,7 @@
       ;;
     pw32*)
       # pw32 DLLs use 'pw' prefix rather than 'lib'
-      library_names_spec=3D'`echo ${libname} | sed -e 's/^lib/pw/'``echo=
 ${release} | $SED -e 's/[.]/-/g'`${versuffix}${shared_ext}'
+      library_names_spec=3D'`echo ${libname} | sed -e 's/^lib/pw/'``echo=
 ${release} | $SED -e 's/./-/g'`${versuffix}${shared_ext}'
       ;;
     esac
     ;;
@@ -18271,7 +18025,7 @@
   soname_spec=3D'${libname}${release}${major}$shared_ext'
   shlibpath_overrides_runpath=3Dyes
   shlibpath_var=3DDYLD_LIBRARY_PATH
-  shrext_cmds=3D'`test .$module =3D .yes && echo .so || echo .dylib`'
+  shrext_cmds=3D'$(test .$module =3D .yes && echo .so || echo .dylib)'
   # Apple's gcc prints 'gcc -print-search-dirs' doesn't operate the same=
=2E
   if test "$GCC" =3D yes; then
     sys_lib_search_path_spec=3D`$CC -print-search-dirs | tr "\n" "$PATH_=
SEPARATOR" | sed -e 's/libraries:/@libraries:/' | tr "@" "\n" | grep "^li=
braries:" | sed -e "s/^libraries://" -e "s,=3D/,/,g" -e "s,$PATH_SEPARATO=
R, ,g" -e "s,.*,& /lib /usr/lib /usr/local/lib,g"`
@@ -18306,17 +18060,8 @@
   dynamic_linker=3D'GNU ld.so'
   ;;
=20
-freebsd* | dragonfly*)
-  # DragonFly does not have aout.  When/if they implement a new
-  # versioning mechanism, adjust this.
-  if test -x /usr/bin/objformat; then
-    objformat=3D`/usr/bin/objformat`
-  else
-    case $host_os in
-    freebsd[123]*) objformat=3Daout ;;
-    *) objformat=3Delf ;;
-    esac
-  fi
+freebsd*)
+  objformat=3D`test -x /usr/bin/objformat && /usr/bin/objformat || echo =
aout`
   version_type=3Dfreebsd-$objformat
   case $version_type in
     freebsd-elf*)
@@ -18334,19 +18079,14 @@
   freebsd2*)
     shlibpath_overrides_runpath=3Dyes
     ;;
-  freebsd3.[01]* | freebsdelf3.[01]*)
+  freebsd3.01* | freebsdelf3.01*)
     shlibpath_overrides_runpath=3Dyes
     hardcode_into_libs=3Dyes
     ;;
-  freebsd3.[2-9]* | freebsdelf3.[2-9]* | \
-  freebsd4.[0-5] | freebsdelf4.[0-5] | freebsd4.1.1 | freebsdelf4.1.1)
+  *) # from 3.2 on
     shlibpath_overrides_runpath=3Dno
     hardcode_into_libs=3Dyes
     ;;
-  freebsd*) # from 4.6 on
-    shlibpath_overrides_runpath=3Dyes
-    hardcode_into_libs=3Dyes
-    ;;
   esac
   ;;
=20
@@ -18366,7 +18106,7 @@
   version_type=3Dsunos
   need_lib_prefix=3Dno
   need_version=3Dno
-  case $host_cpu in
+  case "$host_cpu" in
   ia64*)
     shrext_cmds=3D'.so'
     hardcode_into_libs=3Dyes
@@ -18406,18 +18146,6 @@
   postinstall_cmds=3D'chmod 555 $lib'
   ;;
=20
-interix3*)
-  version_type=3Dlinux
-  need_lib_prefix=3Dno
-  need_version=3Dno
-  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major ${libname}${shared_ext}'
-  soname_spec=3D'${libname}${release}${shared_ext}$major'
-  dynamic_linker=3D'Interix 3.x ld.so.1 (PE, like ELF)'
-  shlibpath_var=3DLD_LIBRARY_PATH
-  shlibpath_overrides_runpath=3Dno
-  hardcode_into_libs=3Dyes
-  ;;
-
 irix5* | irix6* | nonstopux*)
   case $host_os in
     nonstopux*) version_type=3Dnonstopux ;;
@@ -18477,7 +18205,7 @@
=20
   # Append ld.so.conf contents to the search path
   if test -f /etc/ld.so.conf; then
-    lt_ld_extra=3D`awk '/^include / { system(sprintf("cd /etc; cat %s", =
\$2)); skip =3D 1; } { if (!skip) print \$0; skip =3D 0; }' < /etc/ld.so.=
conf | $SED -e 's/#.*//;s/[:,	]/ /g;s/=3D[^=3D]*$//;s/=3D[^=3D ]* / /g;/^=
$/d' | tr '\n' ' '`
+    lt_ld_extra=3D`$SED -e 's/:,\t/ /g;s/=3D^=3D*$//;s/=3D^=3D * / /g' /=
etc/ld.so.conf | tr '\n' ' '`
     sys_lib_dlsearch_path_spec=3D"/lib /usr/lib $lt_ld_extra"
   fi
=20
@@ -18551,13 +18279,8 @@
=20
 openbsd*)
   version_type=3Dsunos
-  sys_lib_dlsearch_path_spec=3D"/usr/lib"
   need_lib_prefix=3Dno
-  # Some older versions of OpenBSD (3.3 at least) *do* need versioned li=
bs.
-  case $host_os in
-    openbsd3.3 | openbsd3.3.*) need_version=3Dyes ;;
-    *)                         need_version=3Dno  ;;
-  esac
+  need_version=3Dyes
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${shared_ext}$versuffix'
   finish_cmds=3D'PATH=3D"\$PATH:/sbin" ldconfig -m $libdir'
   shlibpath_var=3DLD_LIBRARY_PATH
@@ -18595,6 +18318,13 @@
   sys_lib_dlsearch_path_spec=3D"$sys_lib_search_path_spec"
   ;;
=20
+sco3.2v5*)
+  version_type=3Dosf
+  soname_spec=3D'${libname}${release}${shared_ext}$major'
+  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
+  shlibpath_var=3DLD_LIBRARY_PATH
+  ;;
+
 solaris*)
   version_type=3Dlinux
   need_lib_prefix=3Dno
@@ -18620,7 +18350,7 @@
   need_version=3Dyes
   ;;
=20
-sysv4 | sysv4.3*)
+sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
   version_type=3Dlinux
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
   soname_spec=3D'${libname}${release}${shared_ext}$major'
@@ -18653,29 +18383,6 @@
   fi
   ;;
=20
-sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX* | sysv4*uw2*)
-  version_type=3Dfreebsd-elf
-  need_lib_prefix=3Dno
-  need_version=3Dno
-  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext} $libname${shared_ext}'
-  soname_spec=3D'${libname}${release}${shared_ext}$major'
-  shlibpath_var=3DLD_LIBRARY_PATH
-  hardcode_into_libs=3Dyes
-  if test "$with_gnu_ld" =3D yes; then
-    sys_lib_search_path_spec=3D'/usr/local/lib /usr/gnu/lib /usr/ccs/lib=
 /usr/lib /lib'
-    shlibpath_overrides_runpath=3Dno
-  else
-    sys_lib_search_path_spec=3D'/usr/ccs/lib /usr/lib'
-    shlibpath_overrides_runpath=3Dyes
-    case $host_os in
-      sco3.2v5*)
-        sys_lib_search_path_spec=3D"$sys_lib_search_path_spec /lib"
-	;;
-    esac
-  fi
-  sys_lib_dlsearch_path_spec=3D'/usr/lib'
-  ;;
-
 uts4*)
   version_type=3Dlinux
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
@@ -18691,17 +18398,12 @@
 echo "${ECHO_T}$dynamic_linker" >&6
 test "$dynamic_linker" =3D no && can_build_shared=3Dno
=20
-variables_saved_for_relink=3D"PATH $shlibpath_var $runpath_var"
-if test "$GCC" =3D yes; then
-  variables_saved_for_relink=3D"$variables_saved_for_relink GCC_EXEC_PRE=
FIX COMPILER_PATH LIBRARY_PATH"
-fi
-
 echo "$as_me:$LINENO: checking how to hardcode library paths into progra=
ms" >&5
 echo $ECHO_N "checking how to hardcode library paths into programs... $E=
CHO_C" >&6
 hardcode_action_GCJ=3D
 if test -n "$hardcode_libdir_flag_spec_GCJ" || \
-   test -n "$runpath_var_GCJ" || \
-   test "X$hardcode_automatic_GCJ" =3D "Xyes" ; then
+   test -n "$runpath_var GCJ" || \
+   test "X$hardcode_automatic_GCJ"=3D"Xyes" ; then
=20
   # We can hardcode non-existant directories.
   if test "$hardcode_direct_GCJ" !=3D no &&
@@ -18733,7 +18435,835 @@
   enable_fast_install=3Dneedless
 fi
=20
+striplib=3D
+old_striplib=3D
+echo "$as_me:$LINENO: checking whether stripping libraries is possible" =
>&5
+echo $ECHO_N "checking whether stripping libraries is possible... $ECHO_=
C" >&6
+if test -n "$STRIP" && $STRIP -V 2>&1 | grep "GNU strip" >/dev/null; the=
n
+  test -z "$old_striplib" && old_striplib=3D"$STRIP --strip-debug"
+  test -z "$striplib" && striplib=3D"$STRIP --strip-unneeded"
+  echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6
+else
+# FIXME - insert some real tests, host_os isn't really good enough
+  case $host_os in
+   darwin*)
+       if test -n "$STRIP" ; then
+         striplib=3D"$STRIP -x"
+         echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6
+       else
+  echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6
+fi
+       ;;
+   *)
+  echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6
+    ;;
+  esac
+fi
=20
+if test "x$enable_dlopen" !=3D xyes; then
+  enable_dlopen=3Dunknown
+  enable_dlopen_self=3Dunknown
+  enable_dlopen_self_static=3Dunknown
+else
+  lt_cv_dlopen=3Dno
+  lt_cv_dlopen_libs=3D
+
+  case $host_os in
+  beos*)
+    lt_cv_dlopen=3D"load_add_on"
+    lt_cv_dlopen_libs=3D
+    lt_cv_dlopen_self=3Dyes
+    ;;
+
+  mingw* | pw32*)
+    lt_cv_dlopen=3D"LoadLibrary"
+    lt_cv_dlopen_libs=3D
+   ;;
+
+  cygwin*)
+    lt_cv_dlopen=3D"dlopen"
+    lt_cv_dlopen_libs=3D
+   ;;
+
+  darwin*)
+  # if libdl is installed we need to link against it
+    echo "$as_me:$LINENO: checking for dlopen in -ldl" >&5
+echo $ECHO_N "checking for dlopen in -ldl... $ECHO_C" >&6
+if test "${ac_cv_lib_dl_dlopen+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-ldl  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char dlopen ();
+int
+main ()
+{
+dlopen ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_c_werror_flag"			 || test ! -s conftest.err'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_lib_dl_dlopen=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_lib_dl_dlopen=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+echo "$as_me:$LINENO: result: $ac_cv_lib_dl_dlopen" >&5
+echo "${ECHO_T}$ac_cv_lib_dl_dlopen" >&6
+if test $ac_cv_lib_dl_dlopen =3D yes; then
+  lt_cv_dlopen=3D"dlopen" lt_cv_dlopen_libs=3D"-ldl"
+else
+
+    lt_cv_dlopen=3D"dyld"
+    lt_cv_dlopen_libs=3D
+    lt_cv_dlopen_self=3Dyes
+
+fi
+
+   ;;
+
+  *)
+    echo "$as_me:$LINENO: checking for shl_load" >&5
+echo $ECHO_N "checking for shl_load... $ECHO_C" >&6
+if test "${ac_cv_func_shl_load+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+/* Define shl_load to an innocuous variant, in case <limits.h> declares =
shl_load.
+   For example, HP-UX 11i <limits.h> declares gettimeofday.  */
+#define shl_load innocuous_shl_load
+
+/* System header to define __stub macros and hopefully few prototypes,
+    which can conflict with char shl_load (); below.
+    Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+    <limits.h> exists even on freestanding compilers.  */
+
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+
+#undef shl_load
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char shl_load ();
+/* The GNU C library defines this for functions which it implements
+    to always fail with ENOSYS.  Some functions are actually named
+    something starting with __ and the normal name is an alias.  */
+#if defined (__stub_shl_load) || defined (__stub___shl_load)
+choke me
+#else
+char (*f) () =3D shl_load;
+#endif
+#ifdef __cplusplus
+}
+#endif
+
+int
+main ()
+{
+return f !=3D shl_load;
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_c_werror_flag"			 || test ! -s conftest.err'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_func_shl_load=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_func_shl_load=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+fi
+echo "$as_me:$LINENO: result: $ac_cv_func_shl_load" >&5
+echo "${ECHO_T}$ac_cv_func_shl_load" >&6
+if test $ac_cv_func_shl_load =3D yes; then
+  lt_cv_dlopen=3D"shl_load"
+else
+  echo "$as_me:$LINENO: checking for shl_load in -ldld" >&5
+echo $ECHO_N "checking for shl_load in -ldld... $ECHO_C" >&6
+if test "${ac_cv_lib_dld_shl_load+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-ldld  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char shl_load ();
+int
+main ()
+{
+shl_load ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_c_werror_flag"			 || test ! -s conftest.err'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_lib_dld_shl_load=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_lib_dld_shl_load=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+echo "$as_me:$LINENO: result: $ac_cv_lib_dld_shl_load" >&5
+echo "${ECHO_T}$ac_cv_lib_dld_shl_load" >&6
+if test $ac_cv_lib_dld_shl_load =3D yes; then
+  lt_cv_dlopen=3D"shl_load" lt_cv_dlopen_libs=3D"-dld"
+else
+  echo "$as_me:$LINENO: checking for dlopen" >&5
+echo $ECHO_N "checking for dlopen... $ECHO_C" >&6
+if test "${ac_cv_func_dlopen+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+/* Define dlopen to an innocuous variant, in case <limits.h> declares dl=
open.
+   For example, HP-UX 11i <limits.h> declares gettimeofday.  */
+#define dlopen innocuous_dlopen
+
+/* System header to define __stub macros and hopefully few prototypes,
+    which can conflict with char dlopen (); below.
+    Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+    <limits.h> exists even on freestanding compilers.  */
+
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+
+#undef dlopen
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char dlopen ();
+/* The GNU C library defines this for functions which it implements
+    to always fail with ENOSYS.  Some functions are actually named
+    something starting with __ and the normal name is an alias.  */
+#if defined (__stub_dlopen) || defined (__stub___dlopen)
+choke me
+#else
+char (*f) () =3D dlopen;
+#endif
+#ifdef __cplusplus
+}
+#endif
+
+int
+main ()
+{
+return f !=3D dlopen;
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_c_werror_flag"			 || test ! -s conftest.err'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_func_dlopen=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_func_dlopen=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+fi
+echo "$as_me:$LINENO: result: $ac_cv_func_dlopen" >&5
+echo "${ECHO_T}$ac_cv_func_dlopen" >&6
+if test $ac_cv_func_dlopen =3D yes; then
+  lt_cv_dlopen=3D"dlopen"
+else
+  echo "$as_me:$LINENO: checking for dlopen in -ldl" >&5
+echo $ECHO_N "checking for dlopen in -ldl... $ECHO_C" >&6
+if test "${ac_cv_lib_dl_dlopen+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-ldl  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char dlopen ();
+int
+main ()
+{
+dlopen ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_c_werror_flag"			 || test ! -s conftest.err'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_lib_dl_dlopen=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_lib_dl_dlopen=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+echo "$as_me:$LINENO: result: $ac_cv_lib_dl_dlopen" >&5
+echo "${ECHO_T}$ac_cv_lib_dl_dlopen" >&6
+if test $ac_cv_lib_dl_dlopen =3D yes; then
+  lt_cv_dlopen=3D"dlopen" lt_cv_dlopen_libs=3D"-ldl"
+else
+  echo "$as_me:$LINENO: checking for dlopen in -lsvld" >&5
+echo $ECHO_N "checking for dlopen in -lsvld... $ECHO_C" >&6
+if test "${ac_cv_lib_svld_dlopen+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-lsvld  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char dlopen ();
+int
+main ()
+{
+dlopen ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_c_werror_flag"			 || test ! -s conftest.err'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_lib_svld_dlopen=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_lib_svld_dlopen=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+echo "$as_me:$LINENO: result: $ac_cv_lib_svld_dlopen" >&5
+echo "${ECHO_T}$ac_cv_lib_svld_dlopen" >&6
+if test $ac_cv_lib_svld_dlopen =3D yes; then
+  lt_cv_dlopen=3D"dlopen" lt_cv_dlopen_libs=3D"-lsvld"
+else
+  echo "$as_me:$LINENO: checking for dld_link in -ldld" >&5
+echo $ECHO_N "checking for dld_link in -ldld... $ECHO_C" >&6
+if test "${ac_cv_lib_dld_dld_link+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-ldld  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char dld_link ();
+int
+main ()
+{
+dld_link ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_c_werror_flag"			 || test ! -s conftest.err'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_lib_dld_dld_link=3Dyes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+ac_cv_lib_dld_dld_link=3Dno
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+echo "$as_me:$LINENO: result: $ac_cv_lib_dld_dld_link" >&5
+echo "${ECHO_T}$ac_cv_lib_dld_dld_link" >&6
+if test $ac_cv_lib_dld_dld_link =3D yes; then
+  lt_cv_dlopen=3D"dld_link" lt_cv_dlopen_libs=3D"-dld"
+fi
+
+
+fi
+
+
+fi
+
+
+fi
+
+
+fi
+
+
+fi
+
+    ;;
+  esac
+
+  if test "x$lt_cv_dlopen" !=3D xno; then
+    enable_dlopen=3Dyes
+  else
+    enable_dlopen=3Dno
+  fi
+
+  case $lt_cv_dlopen in
+  dlopen)
+    save_CPPFLAGS=3D"$CPPFLAGS"
+    test "x$ac_cv_header_dlfcn_h" =3D xyes && CPPFLAGS=3D"$CPPFLAGS -DHA=
VE_DLFCN_H"
+
+    save_LDFLAGS=3D"$LDFLAGS"
+    eval LDFLAGS=3D\"\$LDFLAGS $export_dynamic_flag_spec\"
+
+    save_LIBS=3D"$LIBS"
+    LIBS=3D"$lt_cv_dlopen_libs $LIBS"
+
+    echo "$as_me:$LINENO: checking whether a program can dlopen itself" =
>&5
+echo $ECHO_N "checking whether a program can dlopen itself... $ECHO_C" >=
&6
+if test "${lt_cv_dlopen_self+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  	  if test "$cross_compiling" =3D yes; then :
+  lt_cv_dlopen_self=3Dcross
+else
+  lt_dlunknown=3D0; lt_dlno_uscore=3D1; lt_dlneed_uscore=3D2
+  lt_status=3D$lt_dlunknown
+  cat > conftest.$ac_ext <<EOF
+#line 19065 "configure"
+#include "confdefs.h"
+
+#if HAVE_DLFCN_H
+#include <dlfcn.h>
+#endif
+
+#include <stdio.h>
+
+#ifdef RTLD_GLOBAL
+#  define LT_DLGLOBAL		RTLD_GLOBAL
+#else
+#  ifdef DL_GLOBAL
+#    define LT_DLGLOBAL		DL_GLOBAL
+#  else
+#    define LT_DLGLOBAL		0
+#  endif
+#endif
+
+/* We may have to define LT_DLLAZY_OR_NOW in the command line if we
+   find out it does not work in some platform. */
+#ifndef LT_DLLAZY_OR_NOW
+#  ifdef RTLD_LAZY
+#    define LT_DLLAZY_OR_NOW		RTLD_LAZY
+#  else
+#    ifdef DL_LAZY
+#      define LT_DLLAZY_OR_NOW		DL_LAZY
+#    else
+#      ifdef RTLD_NOW
+#        define LT_DLLAZY_OR_NOW	RTLD_NOW
+#      else
+#        ifdef DL_NOW
+#          define LT_DLLAZY_OR_NOW	DL_NOW
+#        else
+#          define LT_DLLAZY_OR_NOW	0
+#        endif
+#      endif
+#    endif
+#  endif
+#endif
+
+#ifdef __cplusplus
+extern "C" void exit (int);
+#endif
+
+void fnord() { int i=3D42;}
+int main ()
+{
+  void *self =3D dlopen (0, LT_DLGLOBAL|LT_DLLAZY_OR_NOW);
+  int status =3D $lt_dlunknown;
+
+  if (self)
+    {
+      if (dlsym (self,"fnord"))       status =3D $lt_dlno_uscore;
+      else if (dlsym( self,"_fnord")) status =3D $lt_dlneed_uscore;
+      /* dlclose (self); */
+    }
+
+    exit (status);
+}
+EOF
+  if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } && test -s conftest${ac_exeext} 2>/dev/null; then
+    (./conftest; exit; ) 2>/dev/null
+    lt_status=3D$?
+    case x$lt_status in
+      x$lt_dlno_uscore) lt_cv_dlopen_self=3Dyes ;;
+      x$lt_dlneed_uscore) lt_cv_dlopen_self=3Dyes ;;
+      x$lt_unknown|x*) lt_cv_dlopen_self=3Dno ;;
+    esac
+  else :
+    # compilation failed
+    lt_cv_dlopen_self=3Dno
+  fi
+fi
+rm -fr conftest*
+
+
+fi
+echo "$as_me:$LINENO: result: $lt_cv_dlopen_self" >&5
+echo "${ECHO_T}$lt_cv_dlopen_self" >&6
+
+    if test "x$lt_cv_dlopen_self" =3D xyes; then
+      LDFLAGS=3D"$LDFLAGS $link_static_flag"
+      echo "$as_me:$LINENO: checking whether a statically linked program=
 can dlopen itself" >&5
+echo $ECHO_N "checking whether a statically linked program can dlopen it=
self... $ECHO_C" >&6
+if test "${lt_cv_dlopen_self_static+set}" =3D set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  	  if test "$cross_compiling" =3D yes; then :
+  lt_cv_dlopen_self_static=3Dcross
+else
+  lt_dlunknown=3D0; lt_dlno_uscore=3D1; lt_dlneed_uscore=3D2
+  lt_status=3D$lt_dlunknown
+  cat > conftest.$ac_ext <<EOF
+#line 19163 "configure"
+#include "confdefs.h"
+
+#if HAVE_DLFCN_H
+#include <dlfcn.h>
+#endif
+
+#include <stdio.h>
+
+#ifdef RTLD_GLOBAL
+#  define LT_DLGLOBAL		RTLD_GLOBAL
+#else
+#  ifdef DL_GLOBAL
+#    define LT_DLGLOBAL		DL_GLOBAL
+#  else
+#    define LT_DLGLOBAL		0
+#  endif
+#endif
+
+/* We may have to define LT_DLLAZY_OR_NOW in the command line if we
+   find out it does not work in some platform. */
+#ifndef LT_DLLAZY_OR_NOW
+#  ifdef RTLD_LAZY
+#    define LT_DLLAZY_OR_NOW		RTLD_LAZY
+#  else
+#    ifdef DL_LAZY
+#      define LT_DLLAZY_OR_NOW		DL_LAZY
+#    else
+#      ifdef RTLD_NOW
+#        define LT_DLLAZY_OR_NOW	RTLD_NOW
+#      else
+#        ifdef DL_NOW
+#          define LT_DLLAZY_OR_NOW	DL_NOW
+#        else
+#          define LT_DLLAZY_OR_NOW	0
+#        endif
+#      endif
+#    endif
+#  endif
+#endif
+
+#ifdef __cplusplus
+extern "C" void exit (int);
+#endif
+
+void fnord() { int i=3D42;}
+int main ()
+{
+  void *self =3D dlopen (0, LT_DLGLOBAL|LT_DLLAZY_OR_NOW);
+  int status =3D $lt_dlunknown;
+
+  if (self)
+    {
+      if (dlsym (self,"fnord"))       status =3D $lt_dlno_uscore;
+      else if (dlsym( self,"_fnord")) status =3D $lt_dlneed_uscore;
+      /* dlclose (self); */
+    }
+
+    exit (status);
+}
+EOF
+  if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } && test -s conftest${ac_exeext} 2>/dev/null; then
+    (./conftest; exit; ) 2>/dev/null
+    lt_status=3D$?
+    case x$lt_status in
+      x$lt_dlno_uscore) lt_cv_dlopen_self_static=3Dyes ;;
+      x$lt_dlneed_uscore) lt_cv_dlopen_self_static=3Dyes ;;
+      x$lt_unknown|x*) lt_cv_dlopen_self_static=3Dno ;;
+    esac
+  else :
+    # compilation failed
+    lt_cv_dlopen_self_static=3Dno
+  fi
+fi
+rm -fr conftest*
+
+
+fi
+echo "$as_me:$LINENO: result: $lt_cv_dlopen_self_static" >&5
+echo "${ECHO_T}$lt_cv_dlopen_self_static" >&6
+    fi
+
+    CPPFLAGS=3D"$save_CPPFLAGS"
+    LDFLAGS=3D"$save_LDFLAGS"
+    LIBS=3D"$save_LIBS"
+    ;;
+  esac
+
+  case $lt_cv_dlopen_self in
+  yes|no) enable_dlopen_self=3D$lt_cv_dlopen_self ;;
+  *) enable_dlopen_self=3Dunknown ;;
+  esac
+
+  case $lt_cv_dlopen_self_static in
+  yes|no) enable_dlopen_self_static=3D$lt_cv_dlopen_self_static ;;
+  *) enable_dlopen_self_static=3Dunknown ;;
+  esac
+fi
+
+
 # The else clause should only fire when bootstrapping the
 # libtool distribution, otherwise you forgot to ship ltmain.sh
 # with your package, and you will get complaints that there are
@@ -18747,7 +19277,7 @@
   # Now quote all the things that may contain metacharacters while being
   # careful not to overquote the AC_SUBSTed values.  We take copies of t=
he
   # variables and quote the copies for generation of the libtool script.
-  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC L=
TCFLAGS NM \
+  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC N=
M \
     SED SHELL STRIP \
     libname_spec library_names_spec soname_spec extract_expsyms_cmds \
     old_striplib striplib file_magic_cmd finish_cmds finish_eval \
@@ -18848,13 +19378,7 @@
 # The host system.
 host_alias=3D$host_alias
 host=3D$host
-host_os=3D$host_os
=20
-# The build system.
-build_alias=3D$build_alias
-build=3D$build
-build_os=3D$build_os
-
 # An echo program that does not interpret backslashes.
 echo=3D$lt_echo
=20
@@ -18865,9 +19389,6 @@
 # A C compiler.
 LTCC=3D$lt_LTCC
=20
-# LTCC compiler flags.
-LTCFLAGS=3D$lt_LTCFLAGS
-
 # A language-specific compiler.
 CC=3D$lt_compiler_GCJ
=20
@@ -18933,7 +19454,7 @@
 # Does compiler simultaneously support -c and -o options?
 compiler_c_o=3D$lt_lt_cv_prog_compiler_c_o_GCJ
=20
-# Must we lock files when doing compilation?
+# Must we lock files when doing compilation ?
 need_locks=3D$lt_need_locks
=20
 # Do we need the lib prefix for modules?
@@ -19177,42 +19698,15 @@
 # If no C compiler was specified, use CC.
 LTCC=3D${LTCC-"$CC"}
=20
-# If no C compiler flags were specified, use CFLAGS.
-LTCFLAGS=3D${LTCFLAGS-"$CFLAGS"}
-
 # Allow CC to be a program name with arguments.
 compiler=3D$CC
=20
=20
-# save warnings/boilerplate of simple test code
-ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_compile_test_code" >conftest.$ac_ext
-eval "$ac_compile" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_compiler_boilerplate=3D`cat conftest.err`
-$rm conftest*
-
-ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_link_test_code" >conftest.$ac_ext
-eval "$ac_link" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_linker_boilerplate=3D`cat conftest.err`
-$rm conftest*
-
-
 # Allow CC to be a program name with arguments.
 lt_save_CC=3D"$CC"
 CC=3D${RC-"windres"}
 compiler=3D$CC
 compiler_RC=3D$CC
-for cc_temp in $compiler""; do
-  case $cc_temp in
-    compile | *[\\/]compile | ccache | *[\\/]ccache ) ;;
-    distcc | *[\\/]distcc | purify | *[\\/]purify ) ;;
-    \-*) ;;
-    *) break;;
-  esac
-done
-cc_basename=3D`$echo "X$cc_temp" | $Xsed -e 's%.*/%%' -e "s%^$host_alias=
-%%"`
-
 lt_cv_prog_compiler_c_o_RC=3Dyes
=20
 # The else clause should only fire when bootstrapping the
@@ -19228,7 +19722,7 @@
   # Now quote all the things that may contain metacharacters while being
   # careful not to overquote the AC_SUBSTed values.  We take copies of t=
he
   # variables and quote the copies for generation of the libtool script.
-  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC L=
TCFLAGS NM \
+  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC N=
M \
     SED SHELL STRIP \
     libname_spec library_names_spec soname_spec extract_expsyms_cmds \
     old_striplib striplib file_magic_cmd finish_cmds finish_eval \
@@ -19329,13 +19823,7 @@
 # The host system.
 host_alias=3D$host_alias
 host=3D$host
-host_os=3D$host_os
=20
-# The build system.
-build_alias=3D$build_alias
-build=3D$build
-build_os=3D$build_os
-
 # An echo program that does not interpret backslashes.
 echo=3D$lt_echo
=20
@@ -19346,9 +19834,6 @@
 # A C compiler.
 LTCC=3D$lt_LTCC
=20
-# LTCC compiler flags.
-LTCFLAGS=3D$lt_LTCFLAGS
-
 # A language-specific compiler.
 CC=3D$lt_compiler_RC
=20
@@ -19414,7 +19899,7 @@
 # Does compiler simultaneously support -c and -o options?
 compiler_c_o=3D$lt_lt_cv_prog_compiler_c_o_RC
=20
-# Must we lock files when doing compilation?
+# Must we lock files when doing compilation ?
 need_locks=3D$lt_need_locks
=20
 # Do we need the lib prefix for modules?
@@ -21215,21 +21700,127 @@
=20
 fi
=20
+save_LIBS=3D"$LIBS"
+LIBS=3D"$LIBS -lrt"
=20
=20
+for ac_func in shm_open shm_unlink
+do
+as_ac_var=3D`echo "ac_cv_func_$ac_func" | $as_tr_sh`
+echo "$as_me:$LINENO: checking for $ac_func" >&5
+echo $ECHO_N "checking for $ac_func... $ECHO_C" >&6
+if eval "test \"\${$as_ac_var+set}\" =3D set"; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+/* Define $ac_func to an innocuous variant, in case <limits.h> declares =
$ac_func.
+   For example, HP-UX 11i <limits.h> declares gettimeofday.  */
+#define $ac_func innocuous_$ac_func
=20
+/* System header to define __stub macros and hopefully few prototypes,
+    which can conflict with char $ac_func (); below.
+    Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+    <limits.h> exists even on freestanding compilers.  */
=20
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
=20
+#undef $ac_func
=20
+/* Override any gcc2 internal prototype to avoid an error.  */
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+/* We use char because int might match the return type of a gcc2
+   builtin and then its argument prototype would still apply.  */
+char $ac_func ();
+/* The GNU C library defines this for functions which it implements
+    to always fail with ENOSYS.  Some functions are actually named
+    something starting with __ and the normal name is an alias.  */
+#if defined (__stub_$ac_func) || defined (__stub___$ac_func)
+choke me
+#else
+char (*f) () =3D $ac_func;
+#endif
+#ifdef __cplusplus
+}
+#endif
=20
+int
+main ()
+{
+return f !=3D $ac_func;
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (eval echo "$as_me:$LINENO: \"$ac_link\"") >&5
+  (eval $ac_link) 2>conftest.er1
+  ac_status=3D$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); } &&
+	 { ac_try=3D'test -z "$ac_c_werror_flag"			 || test ! -s conftest.err'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; } &&
+	 { ac_try=3D'test -s conftest$ac_exeext'
+  { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
+  (eval $ac_try) 2>&5
+  ac_status=3D$?
+  echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
+  (exit $ac_status); }; }; then
+  eval "$as_ac_var=3Dyes"
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
=20
+eval "$as_ac_var=3Dno"
+fi
+rm -f conftest.err conftest.$ac_objext \
+      conftest$ac_exeext conftest.$ac_ext
+fi
+echo "$as_me:$LINENO: result: `eval echo '${'$as_ac_var'}'`" >&5
+echo "${ECHO_T}`eval echo '${'$as_ac_var'}'`" >&6
+if test `eval echo '${'$as_ac_var'}'` =3D yes; then
+  cat >>confdefs.h <<_ACEOF
+#define `echo "HAVE_$ac_func" | $as_tr_cpp` 1
+_ACEOF
=20
+fi
+done
=20
+LIBS=3D"$save_LIBS"
=20
=20
=20
=20
=20
+
+
+
+
+
+
+
+
+
+
+
 CONFIG_STATUS_DEPENDENCIES=3D'$(top_srcdir)/src/skins/posix/posix.wrappe=
rs'
=20
=20
Index: Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- Makefile.in	(r=C3=A9vision 2338)
+++ Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/uitron/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/uitron/Makefile.in	(r=C3=A9vision 2338)
+++ include/uitron/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-ia64/bits/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-ia64/bits/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-ia64/bits/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-ia64/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-ia64/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-ia64/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/Makefile.in	(r=C3=A9vision 2338)
+++ include/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/vxworks/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/vxworks/Makefile.in	(r=C3=A9vision 2338)
+++ include/vxworks/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/native/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/native/Makefile.in	(r=C3=A9vision 2338)
+++ include/native/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-blackfin/bits/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-blackfin/bits/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-blackfin/bits/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-blackfin/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-blackfin/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-blackfin/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-generic/bits/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/bits/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-generic/bits/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-generic/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-generic/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-powerpc/bits/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-powerpc/bits/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-powerpc/bits/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-powerpc/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-powerpc/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-powerpc/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-arm/bits/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/bits/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-arm/bits/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-arm/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-arm/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/rtai/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtai/Makefile.in	(r=C3=A9vision 2338)
+++ include/rtai/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/psos+/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/psos+/Makefile.in	(r=C3=A9vision 2338)
+++ include/psos+/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/posix/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/posix/Makefile.in	(r=C3=A9vision 2338)
+++ include/posix/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/posix/sys/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/posix/sys/Makefile.in	(r=C3=A9vision 2338)
+++ include/posix/sys/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/vrtx/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/vrtx/Makefile.in	(r=C3=A9vision 2338)
+++ include/vrtx/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-sim/bits/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-sim/bits/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-sim/bits/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-sim/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-sim/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-sim/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/rtdm/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/Makefile.in	(r=C3=A9vision 2338)
+++ include/rtdm/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-i386/bits/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-i386/bits/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-i386/bits/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/asm-i386/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-i386/Makefile.in	(r=C3=A9vision 2338)
+++ include/asm-i386/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: include/nucleus/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/Makefile.in	(r=C3=A9vision 2338)
+++ include/nucleus/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- configure.in	(r=C3=A9vision 2338)
+++ configure.in	(r=C3=A9vision 2339)
@@ -567,6 +567,11 @@
 	AC_DEFINE(CONFIG_XENO_POSIX_AUTO_MLOCKALL,1,[config])
 fi
=20
+save_LIBS=3D"$LIBS"
+LIBS=3D"$LIBS -lrt"
+AC_CHECK_FUNCS([shm_open shm_unlink])
+LIBS=3D"$save_LIBS"
+
 dnl
 dnl Build the Makefiles
 dnl
Index: scripts/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/Makefile.in	(r=C3=A9vision 2338)
+++ scripts/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(r=C3=A9vision 2338)
+++ ChangeLog	(r=C3=A9vision 2339)
@@ -1,3 +1,8 @@
+2007-03-28  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
+
+	* src/skins/posix/shm.c (__wrap_shm_open, __wrap_shm_unlink): Only
+	call __real_shm_open and __real_shm_unlink if they exist.
+
 2007-03-25  Philippe Gerum  <rpm@xenomai.org>
=20
         * ksrc/arch/powerpc/patches: Update 2.4.25-ppc-1.2-01 to Denx's
Index: src/utils/can/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/utils/can/Makefile.in	(r=C3=A9vision 2338)
+++ src/utils/can/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(rtcanconfig_SOURCES) $(rtcanrecv_SOURCES) $(rtcansend_SOUR=
CES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/utils/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/utils/Makefile.in	(r=C3=A9vision 2338)
+++ src/utils/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: src/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/Makefile.in	(r=C3=A9vision 2338)
+++ src/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: src/include/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/include/Makefile.in	(r=C3=A9vision 2338)
+++ src/include/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: src/include/xeno_config.h.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/include/xeno_config.h.in	(r=C3=A9vision 2338)
+++ src/include/xeno_config.h.in	(r=C3=A9vision 2339)
@@ -56,6 +56,12 @@
 /* config */
 #undef HAVE_RECENT_SETAFFINITY
=20
+/* Define to 1 if you have the `shm_open' function. */
+#undef HAVE_SHM_OPEN
+
+/* Define to 1 if you have the `shm_unlink' function. */
+#undef HAVE_SHM_UNLINK
+
 /* Define to 1 if you have the <stdint.h> header file. */
 #undef HAVE_STDINT_H
=20
Index: src/skins/psos+/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/psos+/Makefile.in	(r=C3=A9vision 2338)
+++ src/skins/psos+/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(libpsos_la_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/skins/rtai/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/rtai/Makefile.in	(r=C3=A9vision 2338)
+++ src/skins/rtai/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(librtai_la_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/skins/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/Makefile.in	(r=C3=A9vision 2338)
+++ src/skins/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: src/skins/posix/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/Makefile.in	(r=C3=A9vision 2338)
+++ src/skins/posix/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(libpthread_rt_la_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/skins/posix/shm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/shm.c	(r=C3=A9vision 2338)
+++ src/skins/posix/shm.c	(r=C3=A9vision 2339)
@@ -39,8 +39,10 @@
 	if (!err)
 		return fd;
=20
+#ifdef HAVE_SHM_OPEN
 	if (err =3D=3D ENOSYS)
 		return __real_shm_open(name, oflag, mode);
+#endif
=20
 	close(fd);
 	errno =3D err;
@@ -55,8 +57,10 @@
 	if (!err)
 		return 0;
=20
+#ifdef HAVE_SHM_UNLINK
 	if (err =3D=3D ENOSYS)
 		return __real_shm_unlink(name);
+#endif
 =09
 	errno =3D err;
 	return -1;
Index: src/skins/vrtx/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/vrtx/Makefile.in	(r=C3=A9vision 2338)
+++ src/skins/vrtx/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(libvrtx_la_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/skins/vxworks/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/vxworks/Makefile.in	(r=C3=A9vision 2338)
+++ src/skins/vxworks/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(libvxworks_la_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/skins/native/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/native/Makefile.in	(r=C3=A9vision 2338)
+++ src/skins/native/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(libnative_la_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/skins/rtdm/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/rtdm/Makefile.in	(r=C3=A9vision 2338)
+++ src/skins/rtdm/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(librtdm_la_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/testsuite/latency/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/latency/Makefile.in	(r=C3=A9vision 2338)
+++ src/testsuite/latency/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(latency_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/testsuite/switchbench/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchbench/Makefile.in	(r=C3=A9vision 2338)
+++ src/testsuite/switchbench/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(switchbench_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/testsuite/switchtest/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchtest/Makefile.in	(r=C3=A9vision 2338)
+++ src/testsuite/switchtest/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(switchtest_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/testsuite/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/Makefile.in	(r=C3=A9vision 2338)
+++ src/testsuite/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: src/testsuite/cyclic/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/cyclic/Makefile.in	(r=C3=A9vision 2338)
+++ src/testsuite/cyclic/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(cyclictest_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: src/testsuite/irqbench/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/irqbench/Makefile.in	(r=C3=A9vision 2338)
+++ src/testsuite/irqbench/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
@@ -14,6 +14,8 @@
=20
 @SET_MAKE@
=20
+SOURCES =3D $(irqbench_SOURCES) $(irqloop_SOURCES)
+
 srcdir =3D @srcdir@
 top_srcdir =3D @top_srcdir@
 VPATH =3D @srcdir@
Index: doc/txt/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/txt/Makefile.in	(r=C3=A9vision 2338)
+++ doc/txt/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: doc/docbook/xenomai/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/docbook/xenomai/Makefile.in	(r=C3=A9vision 2338)
+++ doc/docbook/xenomai/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: doc/docbook/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/docbook/Makefile.in	(r=C3=A9vision 2338)
+++ doc/docbook/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: doc/docbook/custom-stylesheets/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/docbook/custom-stylesheets/Makefile.in	(r=C3=A9vision 2338)
+++ doc/docbook/custom-stylesheets/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: doc/docbook/custom-stylesheets/xsl/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/docbook/custom-stylesheets/xsl/Makefile.in	(r=C3=A9vision 2338)
+++ doc/docbook/custom-stylesheets/xsl/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: doc/docbook/custom-stylesheets/xsl/fo/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/docbook/custom-stylesheets/xsl/fo/Makefile.in	(r=C3=A9vision 2338=
)
+++ doc/docbook/custom-stylesheets/xsl/fo/Makefile.in	(r=C3=A9vision 2339=
)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: doc/docbook/custom-stylesheets/xsl/html/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/docbook/custom-stylesheets/xsl/html/Makefile.in	(r=C3=A9vision 23=
38)
+++ doc/docbook/custom-stylesheets/xsl/html/Makefile.in	(r=C3=A9vision 23=
39)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: doc/docbook/custom-stylesheets/xsl/common/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/docbook/custom-stylesheets/xsl/common/Makefile.in	(r=C3=A9vision =
2338)
+++ doc/docbook/custom-stylesheets/xsl/common/Makefile.in	(r=C3=A9vision =
2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: doc/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/Makefile.in	(r=C3=A9vision 2338)
+++ doc/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: doc/man/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/man/Makefile.in	(r=C3=A9vision 2338)
+++ doc/man/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: doc/doxygen/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- doc/doxygen/Makefile.in	(r=C3=A9vision 2338)
+++ doc/doxygen/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: config/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- config/Makefile.in	(r=C3=A9vision 2338)
+++ config/Makefile.in	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# Makefile.in generated by automake 1.9.5 from Makefile.am.
 # @configure_input@
=20
 # Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
Index: aclocal.m4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- aclocal.m4	(r=C3=A9vision 2338)
+++ aclocal.m4	(r=C3=A9vision 2339)
@@ -1,4 +1,4 @@
-# generated automatically by aclocal 1.9.6 -*- Autoconf -*-
+# generated automatically by aclocal 1.9.5 -*- Autoconf -*-
=20
 # Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
 # 2005  Free Software Foundation, Inc.
@@ -13,7 +13,8 @@
=20
 # libtool.m4 - Configure libtool for the host system. -*-Autoconf-*-
=20
-# serial 48 Debian 1.5.22-2 AC_PROG_LIBTOOL
+# serial 47 AC_PROG_LIBTOOL
+# Debian $Rev: 214 $
=20
=20
 # AC_PROVIDE_IFELSE(MACRO-NAME, IF-PROVIDED, IF-NOT-PROVIDED)
@@ -123,7 +124,7 @@
=20
 # Sed substitution that helps us do robust quoting.  It backslashifies
 # metacharacters that are still active within double-quoted strings.
-Xsed=3D'sed -e 1s/^X//'
+Xsed=3D'sed -e s/^X//'
 [sed_quote_subst=3D's/\([\\"\\`$\\\\]\)/\\\1/g']
=20
 # Same as above, but do not quote variable references.
@@ -143,7 +144,7 @@
 default_ofile=3Dlibtool
 can_build_shared=3Dyes
=20
-# All known linkers require a `.a' archive for static linking (except MS=
VC,
+# All known linkers require a `.a' archive for static linking (except M$=
VC,
 # which needs '.lib').
 libext=3Da
 ltmain=3D"$ac_aux_dir/ltmain.sh"
@@ -163,7 +164,6 @@
 test -z "$AS" && AS=3Das
 test -z "$CC" && CC=3Dcc
 test -z "$LTCC" && LTCC=3D$CC
-test -z "$LTCFLAGS" && LTCFLAGS=3D$CFLAGS
 test -z "$DLLTOOL" && DLLTOOL=3Ddlltool
 test -z "$LD" && LD=3Dld
 test -z "$LN_S" && LN_S=3D"ln -s"
@@ -183,17 +183,15 @@
 if test -n "$RANLIB"; then
   case $host_os in
   openbsd*)
-    old_postinstall_cmds=3D"$old_postinstall_cmds~\$RANLIB -t \$oldlib"
+    old_postinstall_cmds=3D"\$RANLIB -t \$oldlib~$old_postinstall_cmds"
     ;;
   *)
-    old_postinstall_cmds=3D"$old_postinstall_cmds~\$RANLIB \$oldlib"
+    old_postinstall_cmds=3D"\$RANLIB \$oldlib~$old_postinstall_cmds"
     ;;
   esac
   old_archive_cmds=3D"$old_archive_cmds~\$RANLIB \$oldlib"
 fi
=20
-_LT_CC_BASENAME([$compiler])
-
 # Only perform the check for file, if the check method requires it
 case $deplibs_check_method in
 file_magic*)
@@ -234,56 +232,11 @@
 # If no C compiler was specified, use CC.
 LTCC=3D${LTCC-"$CC"}
=20
-# If no C compiler flags were specified, use CFLAGS.
-LTCFLAGS=3D${LTCFLAGS-"$CFLAGS"}
-
 # Allow CC to be a program name with arguments.
 compiler=3D$CC
 ])# _LT_AC_SYS_COMPILER
=20
=20
-# _LT_CC_BASENAME(CC)
-# -------------------
-# Calculate cc_basename.  Skip known compiler wrappers and cross-prefix.
-AC_DEFUN([_LT_CC_BASENAME],
-[for cc_temp in $1""; do
-  case $cc_temp in
-    compile | *[[\\/]]compile | ccache | *[[\\/]]ccache ) ;;
-    distcc | *[[\\/]]distcc | purify | *[[\\/]]purify ) ;;
-    \-*) ;;
-    *) break;;
-  esac
-done
-cc_basename=3D`$echo "X$cc_temp" | $Xsed -e 's%.*/%%' -e "s%^$host_alias=
-%%"`
-])
-
-
-# _LT_COMPILER_BOILERPLATE
-# ------------------------
-# Check for compiler boilerplate output or warnings with
-# the simple compiler test code.
-AC_DEFUN([_LT_COMPILER_BOILERPLATE],
-[ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_compile_test_code" >conftest.$ac_ext
-eval "$ac_compile" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_compiler_boilerplate=3D`cat conftest.err`
-$rm conftest*
-])# _LT_COMPILER_BOILERPLATE
-
-
-# _LT_LINKER_BOILERPLATE
-# ----------------------
-# Check for linker boilerplate output or warnings with
-# the simple link test code.
-AC_DEFUN([_LT_LINKER_BOILERPLATE],
-[ac_outfile=3Dconftest.$ac_objext
-printf "$lt_simple_link_test_code" >conftest.$ac_ext
-eval "$ac_link" 2>&1 >/dev/null | $SED '/^$/d; /^ *+/d' >conftest.err
-_lt_linker_boilerplate=3D`cat conftest.err`
-$rm conftest*
-])# _LT_LINKER_BOILERPLATE
-
-
 # _LT_AC_SYS_LIBPATH_AIX
 # ----------------------
 # Links a minimal program and checks the executable
@@ -356,15 +309,15 @@
=20
 # The HP-UX ksh and POSIX shell print the target directory to stdout
 # if CDPATH is set.
-(unset CDPATH) >/dev/null 2>&1 && unset CDPATH
+if test "X${CDPATH+set}" =3D Xset; then CDPATH=3D:; export CDPATH; fi
=20
 if test -z "$ECHO"; then
 if test "X${echo_test_string+set}" !=3D Xset; then
 # find a string as large as possible, as long as the shell can cope with=
 it
   for cmd in 'sed 50q "[$]0"' 'sed 20q "[$]0"' 'sed 10q "[$]0"' 'sed 2q =
"[$]0"' 'echo test'; do
     # expected sizes: less than 2Kb, 1Kb, 512 bytes, 16 bytes, ...
-    if (echo_test_string=3D`eval $cmd`) 2>/dev/null &&
-       echo_test_string=3D`eval $cmd` &&
+    if (echo_test_string=3D"`eval $cmd`") 2>/dev/null &&
+       echo_test_string=3D"`eval $cmd`" &&
        (test "X$echo_test_string" =3D "X$echo_test_string") 2>/dev/null
     then
       break
@@ -533,7 +486,7 @@
   # Find out which ABI we are using.
   echo 'int i;' > conftest.$ac_ext
   if AC_TRY_EVAL(ac_compile); then
-    case `/usr/bin/file conftest.o` in
+    case "`/usr/bin/file conftest.o`" in
     *32-bit*)
       case $host in
         x86_64-*linux*)
@@ -584,22 +537,6 @@
     CFLAGS=3D"$SAVE_CFLAGS"
   fi
   ;;
-sparc*-*solaris*)
-  # Find out which ABI we are using.
-  echo 'int i;' > conftest.$ac_ext
-  if AC_TRY_EVAL(ac_compile); then
-    case `/usr/bin/file conftest.o` in
-    *64-bit*)
-      case $lt_cv_prog_gnu_ld in
-      yes*) LD=3D"${LD-ld} -m elf64_sparc" ;;
-      *)    LD=3D"${LD-ld} -64" ;;
-      esac
-      ;;
-    esac
-  fi
-  rm -rf conftest*
-  ;;
-
 AC_PROVIDE_IFELSE([AC_LIBTOOL_WIN32_DLL],
 [*-*-cygwin* | *-*-mingw* | *-*-pw32*)
   AC_CHECK_TOOL(DLLTOOL, dlltool, false)
@@ -631,7 +568,7 @@
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    # The option is referenced via a variable to avoid confusing sed.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [[^ ]]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
    (eval echo "\"\$as_me:__oline__: $lt_compile\"" >&AS_MESSAGE_LOG_FD)
@@ -641,10 +578,8 @@
    echo "$as_me:__oline__: \$? =3D $ac_status" >&AS_MESSAGE_LOG_FD
    if (exit $ac_status) && test -s "$ac_outfile"; then
      # The compiler can only warn and ignore the option if not recognize=
d
-     # So say no if there are warnings other than the usual output.
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' >conftest.exp
-     $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-     if test ! -s conftest.er2 || diff conftest.exp conftest.er2 >/dev/n=
ull; then
+     # So say no if there are warnings
+     if test ! -s conftest.err; then
        $2=3Dyes
      fi
    fi
@@ -670,16 +605,11 @@
    LDFLAGS=3D"$LDFLAGS $3"
    printf "$lt_simple_link_test_code" > conftest.$ac_ext
    if (eval $ac_link 2>conftest.err) && test -s conftest$ac_exeext; then
-     # The linker can only warn and ignore the option if not recognized
+     # The compiler can only warn and ignore the option if not recognize=
d
      # So say no if there are warnings
      if test -s conftest.err; then
        # Append any errors to the config.log.
        cat conftest.err 1>&AS_MESSAGE_LOG_FD
-       $echo "X$_lt_linker_boilerplate" | $Xsed -e '/^$/d' > conftest.ex=
p
-       $SED '/^$/d; /^ *+/d' conftest.err >conftest.er2
-       if diff conftest.exp conftest.er2 >/dev/null; then
-         $2=3Dyes
-       fi
      else
        $2=3Dyes
      fi
@@ -738,55 +668,11 @@
     lt_cv_sys_max_cmd_len=3D8192;
     ;;
=20
-  netbsd* | freebsd* | openbsd* | darwin* | dragonfly*)
-    # This has been around since 386BSD, at least.  Likely further.
-    if test -x /sbin/sysctl; then
-      lt_cv_sys_max_cmd_len=3D`/sbin/sysctl -n kern.argmax`
-    elif test -x /usr/sbin/sysctl; then
-      lt_cv_sys_max_cmd_len=3D`/usr/sbin/sysctl -n kern.argmax`
-    else
-      lt_cv_sys_max_cmd_len=3D65536	# usable default for all BSDs
-    fi
-    # And add a safety zone
-    lt_cv_sys_max_cmd_len=3D`expr $lt_cv_sys_max_cmd_len \/ 4`
-    lt_cv_sys_max_cmd_len=3D`expr $lt_cv_sys_max_cmd_len \* 3`
-    ;;
-
-  interix*)
-    # We know the value 262144 and hardcode it with a safety zone (like =
BSD)
-    lt_cv_sys_max_cmd_len=3D196608
-    ;;
-
-  osf*)
-    # Dr. Hans Ekkehard Plesser reports seeing a kernel panic running co=
nfigure
-    # due to this test when exec_disable_arg_limit is 1 on Tru64. It is =
not
-    # nice to cause kernel panics so lets avoid the loop below.
-    # First set a reasonable default.
-    lt_cv_sys_max_cmd_len=3D16384
-    #
-    if test -x /sbin/sysconfig; then
-      case `/sbin/sysconfig -q proc exec_disable_arg_limit` in
-        *1*) lt_cv_sys_max_cmd_len=3D-1 ;;
-      esac
-    fi
-    ;;
-  sco3.2v5*)
-    lt_cv_sys_max_cmd_len=3D102400
-    ;;
-  sysv5* | sco5v6* | sysv4.2uw2*)
-    kargmax=3D`grep ARG_MAX /etc/conf/cf.d/stune 2>/dev/null`
-    if test -n "$kargmax"; then
-      lt_cv_sys_max_cmd_len=3D`echo $kargmax | sed 's/.*[[ 	]]//'`
-    else
-      lt_cv_sys_max_cmd_len=3D32768
-    fi
-    ;;
-  *)
+ *)
     # If test is not a shell built-in, we'll probably end up computing a
     # maximum length that is only half of the actual maximum length, but
     # we can't tell.
-    SHELL=3D${SHELL-${CONFIG_SHELL-/bin/sh}}
-    while (test "X"`$SHELL [$]0 --fallback-echo "X$teststring" 2>/dev/nu=
ll` \
+    while (test "X"`$CONFIG_SHELL [$]0 --fallback-echo "X$teststring" 2>=
/dev/null` \
 	       =3D "XX$teststring") >/dev/null 2>&1 &&
 	    new_result=3D`expr "X$teststring" : ".*" 2>&1` &&
 	    lt_cv_sys_max_cmd_len=3D$new_result &&
@@ -812,7 +698,7 @@
=20
=20
 # _LT_AC_CHECK_DLFCN
-# ------------------
+# --------------------
 AC_DEFUN([_LT_AC_CHECK_DLFCN],
 [AC_CHECK_HEADERS(dlfcn.h)dnl
 ])# _LT_AC_CHECK_DLFCN
@@ -820,7 +706,7 @@
=20
 # _LT_AC_TRY_DLOPEN_SELF (ACTION-IF-TRUE, ACTION-IF-TRUE-W-USCORE,
 #                           ACTION-IF-FALSE, ACTION-IF-CROSS-COMPILING)
-# ---------------------------------------------------------------------
+# ------------------------------------------------------------------
 AC_DEFUN([_LT_AC_TRY_DLOPEN_SELF],
 [AC_REQUIRE([_LT_AC_CHECK_DLFCN])dnl
 if test "$cross_compiling" =3D yes; then :
@@ -886,19 +772,17 @@
       else if (dlsym( self,"_fnord")) status =3D $lt_dlneed_uscore;
       /* dlclose (self); */
     }
-  else
-    puts (dlerror ());
=20
     exit (status);
 }]
 EOF
   if AC_TRY_EVAL(ac_link) && test -s conftest${ac_exeext} 2>/dev/null; t=
hen
-    (./conftest; exit; ) >&AS_MESSAGE_LOG_FD 2>/dev/null
+    (./conftest; exit; ) 2>/dev/null
     lt_status=3D$?
     case x$lt_status in
       x$lt_dlno_uscore) $1 ;;
       x$lt_dlneed_uscore) $2 ;;
-      x$lt_dlunknown|x*) $3 ;;
+      x$lt_unknown|x*) $3 ;;
     esac
   else :
     # compilation failed
@@ -910,7 +794,7 @@
=20
=20
 # AC_LIBTOOL_DLOPEN_SELF
-# ----------------------
+# -------------------
 AC_DEFUN([AC_LIBTOOL_DLOPEN_SELF],
 [AC_REQUIRE([_LT_AC_CHECK_DLFCN])dnl
 if test "x$enable_dlopen" !=3D xyes; then
@@ -981,7 +865,7 @@
     test "x$ac_cv_header_dlfcn_h" =3D xyes && CPPFLAGS=3D"$CPPFLAGS -DHA=
VE_DLFCN_H"
=20
     save_LDFLAGS=3D"$LDFLAGS"
-    wl=3D$lt_prog_compiler_wl eval LDFLAGS=3D\"\$LDFLAGS $export_dynamic=
_flag_spec\"
+    eval LDFLAGS=3D\"\$LDFLAGS $export_dynamic_flag_spec\"
=20
     save_LIBS=3D"$LIBS"
     LIBS=3D"$lt_cv_dlopen_libs $LIBS"
@@ -994,7 +878,7 @@
     ])
=20
     if test "x$lt_cv_dlopen_self" =3D xyes; then
-      wl=3D$lt_prog_compiler_wl eval LDFLAGS=3D\"\$LDFLAGS $lt_prog_comp=
iler_static\"
+      LDFLAGS=3D"$LDFLAGS $link_static_flag"
       AC_CACHE_CHECK([whether a statically linked program can dlopen its=
elf],
     	  lt_cv_dlopen_self_static, [dnl
 	  _LT_AC_TRY_DLOPEN_SELF(
@@ -1042,7 +926,7 @@
    # Note that $ac_compile itself does not contain backslashes and begin=
s
    # with a dollar sign (not a hyphen), so the echo should work correctl=
y.
    lt_compile=3D`echo "$ac_compile" | $SED \
-   -e 's:.*FLAGS}\{0,1\} :&$lt_compiler_flag :; t' \
+   -e 's:.*FLAGS}? :&$lt_compiler_flag :; t' \
    -e 's: [[^ ]]*conftest\.: $lt_compiler_flag&:; t' \
    -e 's:$: $lt_compiler_flag:'`
    (eval echo "\"\$as_me:__oline__: $lt_compile\"" >&AS_MESSAGE_LOG_FD)
@@ -1054,13 +938,11 @@
    then
      # The compiler can only warn and ignore the option if not recognize=
d
      # So say no if there are warnings
-     $echo "X$_lt_compiler_boilerplate" | $Xsed -e '/^$/d' > out/conftes=
t.exp
-     $SED '/^$/d; /^ *+/d' out/conftest.err >out/conftest.er2
-     if test ! -s out/conftest.er2 || diff out/conftest.exp out/conftest=
.er2 >/dev/null; then
+     if test ! -s out/conftest.err; then
        _LT_AC_TAGVAR(lt_cv_prog_compiler_c_o, $1)=3Dyes
      fi
    fi
-   chmod u+w . 2>&AS_MESSAGE_LOG_FD
+   chmod u+w .
    $rm conftest*
    # SGI C++ compiler will create directory out/ii_files/ for
    # template instantiation
@@ -1124,8 +1006,8 @@
 [AC_MSG_CHECKING([how to hardcode library paths into programs])
 _LT_AC_TAGVAR(hardcode_action, $1)=3D
 if test -n "$_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)" || \
-   test -n "$_LT_AC_TAGVAR(runpath_var, $1)" || \
-   test "X$_LT_AC_TAGVAR(hardcode_automatic, $1)" =3D "Xyes" ; then
+   test -n "$_LT_AC_TAGVAR(runpath_var $1)" || \
+   test "X$_LT_AC_TAGVAR(hardcode_automatic, $1)"=3D"Xyes" ; then
=20
   # We can hardcode non-existant directories.
   if test "$_LT_AC_TAGVAR(hardcode_direct, $1)" !=3D no &&
@@ -1292,7 +1174,7 @@
   shlibpath_var=3DLIBRARY_PATH
   ;;
=20
-bsdi[[45]]*)
+bsdi4*)
   version_type=3Dlinux
   need_version=3Dno
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
@@ -1320,8 +1202,7 @@
       dlpath=3D`$SHELL 2>&1 -c '\''. $dir/'\''\${base_file}'\''i;echo \$=
dlname'\''`~
       dldir=3D$destdir/`dirname \$dlpath`~
       test -d \$dldir || mkdir -p \$dldir~
-      $install_prog $dir/$dlname \$dldir/$dlname~
-      chmod a+x \$dldir/$dlname'
+      $install_prog $dir/$dlname \$dldir/$dlname'
     postuninstall_cmds=3D'dldll=3D`$SHELL 2>&1 -c '\''. $file; echo \$dl=
name'\''`~
       dlpath=3D$dir/\$dldll~
        $rm \$dlpath'
@@ -1351,7 +1232,7 @@
       ;;
     pw32*)
       # pw32 DLLs use 'pw' prefix rather than 'lib'
-      library_names_spec=3D'`echo ${libname} | sed -e 's/^lib/pw/'``echo=
 ${release} | $SED -e 's/[[.]]/-/g'`${versuffix}${shared_ext}'
+      library_names_spec=3D'`echo ${libname} | sed -e 's/^lib/pw/'``echo=
 ${release} | $SED -e 's/[.]/-/g'`${versuffix}${shared_ext}'
       ;;
     esac
     ;;
@@ -1374,7 +1255,7 @@
   soname_spec=3D'${libname}${release}${major}$shared_ext'
   shlibpath_overrides_runpath=3Dyes
   shlibpath_var=3DDYLD_LIBRARY_PATH
-  shrext_cmds=3D'`test .$module =3D .yes && echo .so || echo .dylib`'
+  shrext_cmds=3D'$(test .$module =3D .yes && echo .so || echo .dylib)'
   # Apple's gcc prints 'gcc -print-search-dirs' doesn't operate the same=
=2E
   if test "$GCC" =3D yes; then
     sys_lib_search_path_spec=3D`$CC -print-search-dirs | tr "\n" "$PATH_=
SEPARATOR" | sed -e 's/libraries:/@libraries:/' | tr "@" "\n" | grep "^li=
braries:" | sed -e "s/^libraries://" -e "s,=3D/,/,g" -e "s,$PATH_SEPARATO=
R, ,g" -e "s,.*,& /lib /usr/lib /usr/local/lib,g"`
@@ -1409,17 +1290,8 @@
   dynamic_linker=3D'GNU ld.so'
   ;;
=20
-freebsd* | dragonfly*)
-  # DragonFly does not have aout.  When/if they implement a new
-  # versioning mechanism, adjust this.
-  if test -x /usr/bin/objformat; then
-    objformat=3D`/usr/bin/objformat`
-  else
-    case $host_os in
-    freebsd[[123]]*) objformat=3Daout ;;
-    *) objformat=3Delf ;;
-    esac
-  fi
+freebsd*)
+  objformat=3D`test -x /usr/bin/objformat && /usr/bin/objformat || echo =
aout`
   version_type=3Dfreebsd-$objformat
   case $version_type in
     freebsd-elf*)
@@ -1437,19 +1309,14 @@
   freebsd2*)
     shlibpath_overrides_runpath=3Dyes
     ;;
-  freebsd3.[[01]]* | freebsdelf3.[[01]]*)
+  freebsd3.[01]* | freebsdelf3.[01]*)
     shlibpath_overrides_runpath=3Dyes
     hardcode_into_libs=3Dyes
     ;;
-  freebsd3.[[2-9]]* | freebsdelf3.[[2-9]]* | \
-  freebsd4.[[0-5]] | freebsdelf4.[[0-5]] | freebsd4.1.1 | freebsdelf4.1.=
1)
+  *) # from 3.2 on
     shlibpath_overrides_runpath=3Dno
     hardcode_into_libs=3Dyes
     ;;
-  freebsd*) # from 4.6 on
-    shlibpath_overrides_runpath=3Dyes
-    hardcode_into_libs=3Dyes
-    ;;
   esac
   ;;
=20
@@ -1469,7 +1336,7 @@
   version_type=3Dsunos
   need_lib_prefix=3Dno
   need_version=3Dno
-  case $host_cpu in
+  case "$host_cpu" in
   ia64*)
     shrext_cmds=3D'.so'
     hardcode_into_libs=3Dyes
@@ -1509,18 +1376,6 @@
   postinstall_cmds=3D'chmod 555 $lib'
   ;;
=20
-interix3*)
-  version_type=3Dlinux
-  need_lib_prefix=3Dno
-  need_version=3Dno
-  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major ${libname}${shared_ext}'
-  soname_spec=3D'${libname}${release}${shared_ext}$major'
-  dynamic_linker=3D'Interix 3.x ld.so.1 (PE, like ELF)'
-  shlibpath_var=3DLD_LIBRARY_PATH
-  shlibpath_overrides_runpath=3Dno
-  hardcode_into_libs=3Dyes
-  ;;
-
 irix5* | irix6* | nonstopux*)
   case $host_os in
     nonstopux*) version_type=3Dnonstopux ;;
@@ -1580,7 +1435,7 @@
=20
   # Append ld.so.conf contents to the search path
   if test -f /etc/ld.so.conf; then
-    lt_ld_extra=3D`awk '/^include / { system(sprintf("cd /etc; cat %s", =
\[$]2)); skip =3D 1; } { if (!skip) print \[$]0; skip =3D 0; }' < /etc/ld=
.so.conf | $SED -e 's/#.*//;s/[:,	]/ /g;s/=3D[^=3D]*$//;s/=3D[^=3D ]* / /=
g;/^$/d' | tr '\n' ' '`
+    lt_ld_extra=3D`$SED -e 's/[:,\t]/ /g;s/=3D[^=3D]*$//;s/=3D[^=3D ]* /=
 /g' /etc/ld.so.conf | tr '\n' ' '`
     sys_lib_dlsearch_path_spec=3D"/lib /usr/lib $lt_ld_extra"
   fi
=20
@@ -1654,13 +1509,8 @@
=20
 openbsd*)
   version_type=3Dsunos
-  sys_lib_dlsearch_path_spec=3D"/usr/lib"
   need_lib_prefix=3Dno
-  # Some older versions of OpenBSD (3.3 at least) *do* need versioned li=
bs.
-  case $host_os in
-    openbsd3.3 | openbsd3.3.*) need_version=3Dyes ;;
-    *)                         need_version=3Dno  ;;
-  esac
+  need_version=3Dyes
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${shared_ext}$versuffix'
   finish_cmds=3D'PATH=3D"\$PATH:/sbin" ldconfig -m $libdir'
   shlibpath_var=3DLD_LIBRARY_PATH
@@ -1698,6 +1548,13 @@
   sys_lib_dlsearch_path_spec=3D"$sys_lib_search_path_spec"
   ;;
=20
+sco3.2v5*)
+  version_type=3Dosf
+  soname_spec=3D'${libname}${release}${shared_ext}$major'
+  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
+  shlibpath_var=3DLD_LIBRARY_PATH
+  ;;
+
 solaris*)
   version_type=3Dlinux
   need_lib_prefix=3Dno
@@ -1723,7 +1580,7 @@
   need_version=3Dyes
   ;;
=20
-sysv4 | sysv4.3*)
+sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
   version_type=3Dlinux
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
   soname_spec=3D'${libname}${release}${shared_ext}$major'
@@ -1756,29 +1613,6 @@
   fi
   ;;
=20
-sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX* | sysv4*uw2*)
-  version_type=3Dfreebsd-elf
-  need_lib_prefix=3Dno
-  need_version=3Dno
-  library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext} $libname${shared_ext}'
-  soname_spec=3D'${libname}${release}${shared_ext}$major'
-  shlibpath_var=3DLD_LIBRARY_PATH
-  hardcode_into_libs=3Dyes
-  if test "$with_gnu_ld" =3D yes; then
-    sys_lib_search_path_spec=3D'/usr/local/lib /usr/gnu/lib /usr/ccs/lib=
 /usr/lib /lib'
-    shlibpath_overrides_runpath=3Dno
-  else
-    sys_lib_search_path_spec=3D'/usr/ccs/lib /usr/lib'
-    shlibpath_overrides_runpath=3Dyes
-    case $host_os in
-      sco3.2v5*)
-        sys_lib_search_path_spec=3D"$sys_lib_search_path_spec /lib"
-	;;
-    esac
-  fi
-  sys_lib_dlsearch_path_spec=3D'/usr/lib'
-  ;;
-
 uts4*)
   version_type=3Dlinux
   library_names_spec=3D'${libname}${release}${shared_ext}$versuffix ${li=
bname}${release}${shared_ext}$major $libname${shared_ext}'
@@ -1792,11 +1626,6 @@
 esac
 AC_MSG_RESULT([$dynamic_linker])
 test "$dynamic_linker" =3D no && can_build_shared=3Dno
-
-variables_saved_for_relink=3D"PATH $shlibpath_var $runpath_var"
-if test "$GCC" =3D yes; then
-  variables_saved_for_relink=3D"$variables_saved_for_relink GCC_EXEC_PRE=
FIX COMPILER_PATH LIBRARY_PATH"
-fi
 ])# AC_LIBTOOL_SYS_DYNAMIC_LINKER
=20
=20
@@ -1821,9 +1650,6 @@
       AC_MSG_WARN([using `LTCC=3D$LTCC', extracted from `$ofile'])
     fi
   fi
-  if test -z "$LTCFLAGS"; then
-    eval "`$SHELL ${ofile} --config | grep '^LTCFLAGS=3D'`"
-  fi
=20
   # Extract list of available tagged configurations in $ofile.
   # Note that this assumes the entire list is on one line.
@@ -1850,9 +1676,7 @@
=20
       case $tagname in
       CXX)
-	if test -n "$CXX" && ( test "X$CXX" !=3D "Xno" &&
-	    ( (test "X$CXX" =3D "Xg++" && `g++ -v >/dev/null 2>&1` ) ||
-	    (test "X$CXX" !=3D "Xg++"))) ; then
+	if test -n "$CXX" && test "X$CXX" !=3D "Xno"; then
 	  AC_LIBTOOL_LANG_CXX_CONFIG
 	else
 	  tagname=3D""
@@ -1914,7 +1738,7 @@
=20
 # AC_LIBTOOL_WIN32_DLL
 # --------------------
-# declare package support for building win32 DLLs
+# declare package support for building win32 dll's
 AC_DEFUN([AC_LIBTOOL_WIN32_DLL],
 [AC_BEFORE([$0], [AC_LIBTOOL_SETUP])
 ])# AC_LIBTOOL_WIN32_DLL
@@ -1952,7 +1776,7 @@
=20
 # AC_DISABLE_SHARED
 # -----------------
-# set the default shared flag to --disable-shared
+#- set the default shared flag to --disable-shared
 AC_DEFUN([AC_DISABLE_SHARED],
 [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
 AC_ENABLE_SHARED(no)
@@ -2088,7 +1912,7 @@
       if test -n "$file_magic_test_file"; then
 	case $deplibs_check_method in
 	"file_magic "*)
-	  file_magic_regex=3D`expr "$deplibs_check_method" : "file_magic \(.*\)=
"`
+	  file_magic_regex=3D"`expr \"$deplibs_check_method\" : \"file_magic \(=
.*\)\"`"
 	  MAGIC_CMD=3D"$lt_cv_path_MAGIC_CMD"
 	  if eval $file_magic_cmd \$file_magic_test_file 2> /dev/null |
 	    $EGREP "$file_magic_regex" > /dev/null; then
@@ -2198,7 +2022,7 @@
     if test -f "$ac_dir/$ac_prog" || test -f "$ac_dir/$ac_prog$ac_exeext=
"; then
       lt_cv_path_LD=3D"$ac_dir/$ac_prog"
       # Check to see if the program is GNU ld.  I'd rather use --version=
,
-      # but apparently some variants of GNU ld only accept -v.
+      # but apparently some GNU ld's only accept -v.
       # Break only if it was the GNU/non-GNU ld that we prefer.
       case `"$lt_cv_path_LD" -v 2>&1 </dev/null` in
       *GNU* | *'with BFD'*)
@@ -2230,7 +2054,7 @@
 AC_DEFUN([AC_PROG_LD_GNU],
 [AC_REQUIRE([AC_PROG_EGREP])dnl
 AC_CACHE_CHECK([if the linker ($LD) is GNU ld], lt_cv_prog_gnu_ld,
-[# I'd rather use --version here, but apparently some GNU lds only accep=
t -v.
+[# I'd rather use --version here, but apparently some GNU ld's only acce=
pt -v.
 case `$LD -v 2>&1 </dev/null` in
 *GNU* | *'with BFD'*)
   lt_cv_prog_gnu_ld=3Dyes
@@ -2257,15 +2081,6 @@
 *) reload_flag=3D" $reload_flag" ;;
 esac
 reload_cmds=3D'$LD$reload_flag -o $output$reload_objs'
-case $host_os in
-  darwin*)
-    if test "$GCC" =3D yes; then
-      reload_cmds=3D'$LTCC $LTCFLAGS -nostdlib ${wl}-r -o $output$reload=
_objs'
-    else
-      reload_cmds=3D'$LD$reload_flag -o $output$reload_objs'
-    fi
-    ;;
-esac
 ])# AC_PROG_LD_RELOAD_FLAG
=20
=20
@@ -2299,7 +2114,7 @@
   lt_cv_deplibs_check_method=3Dpass_all
   ;;
=20
-bsdi[[45]]*)
+bsdi4*)
   lt_cv_deplibs_check_method=3D'file_magic ELF [[0-9]][[0-9]]*-bit [[ML]=
]SB (shared object|dynamic lib)'
   lt_cv_file_magic_cmd=3D'/usr/bin/file -L'
   lt_cv_file_magic_test_file=3D/shlib/libc.so
@@ -2322,13 +2137,13 @@
   lt_cv_deplibs_check_method=3Dpass_all
   ;;
=20
-freebsd* | kfreebsd*-gnu | dragonfly*)
+freebsd* | kfreebsd*-gnu)
   if echo __ELF__ | $CC -E - | grep __ELF__ > /dev/null; then
     case $host_cpu in
     i*86 )
       # Not sure whether the presence of OpenBSD here was a mistake.
       # Let's accept both of them until this is cleared up.
-      lt_cv_deplibs_check_method=3D'file_magic (FreeBSD|OpenBSD|DragonFl=
y)/i[[3-9]]86 (compact )?demand paged shared library'
+      lt_cv_deplibs_check_method=3D'file_magic (FreeBSD|OpenBSD)/i[[3-9]=
]86 (compact )?demand paged shared library'
       lt_cv_file_magic_cmd=3D/usr/bin/file
       lt_cv_file_magic_test_file=3D`echo /usr/lib/libc.so.*`
       ;;
@@ -2344,7 +2159,7 @@
=20
 hpux10.20* | hpux11*)
   lt_cv_file_magic_cmd=3D/usr/bin/file
-  case $host_cpu in
+  case "$host_cpu" in
   ia64*)
     lt_cv_deplibs_check_method=3D'file_magic (s[[0-9]][[0-9]][[0-9]]|ELF=
-[[0-9]][[0-9]]) shared object file - IA64'
     lt_cv_file_magic_test_file=3D/usr/lib/hpux32/libc.so
@@ -2360,11 +2175,6 @@
   esac
   ;;
=20
-interix3*)
-  # PIC code is broken on Interix 3.x, that's why |\.a not |_pic\.a here
-  lt_cv_deplibs_check_method=3D'match_pattern /lib[[^/]]+(\.so|\.a)$'
-  ;;
-
 irix5* | irix6* | nonstopux*)
   case $LD in
   *-32|*"-32 ") libmagic=3D32-bit;;
@@ -2399,10 +2209,12 @@
   ;;
=20
 openbsd*)
+  lt_cv_file_magic_cmd=3D/usr/bin/file
+  lt_cv_file_magic_test_file=3D`echo /usr/lib/libc.so.*`
   if test -z "`echo __ELF__ | $CC -E - | grep __ELF__`" || test "$host_o=
s-$host_cpu" =3D "openbsd2.8-powerpc"; then
-    lt_cv_deplibs_check_method=3D'match_pattern /lib[[^/]]+(\.so\.[[0-9]=
]+\.[[0-9]]+|\.so|_pic\.a)$'
+    lt_cv_deplibs_check_method=3D'file_magic ELF [[0-9]][[0-9]]*-bit [[L=
M]]SB shared object'
   else
-    lt_cv_deplibs_check_method=3D'match_pattern /lib[[^/]]+(\.so\.[[0-9]=
]+\.[[0-9]]+|_pic\.a)$'
+    lt_cv_deplibs_check_method=3D'file_magic OpenBSD.* shared library'
   fi
   ;;
=20
@@ -2410,11 +2222,15 @@
   lt_cv_deplibs_check_method=3Dpass_all
   ;;
=20
+sco3.2v5*)
+  lt_cv_deplibs_check_method=3Dpass_all
+  ;;
+
 solaris*)
   lt_cv_deplibs_check_method=3Dpass_all
   ;;
=20
-sysv4 | sysv4.3*)
+sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
   case $host_vendor in
   motorola)
     lt_cv_deplibs_check_method=3D'file_magic ELF [[0-9]][[0-9]]*-bit [[M=
L]]SB (shared object|dynamic lib) M[[0-9]][[0-9]]* Version [[0-9]]'
@@ -2435,13 +2251,10 @@
   siemens)
     lt_cv_deplibs_check_method=3Dpass_all
     ;;
-  pc)
-    lt_cv_deplibs_check_method=3Dpass_all
-    ;;
   esac
   ;;
=20
-sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX* | sysv4*uw2*)
+sysv5OpenUNIX8* | sysv5UnixWare7* | sysv5uw[[78]]* | unixware7* | sysv4*=
uw2*)
   lt_cv_deplibs_check_method=3Dpass_all
   ;;
 esac
@@ -2461,43 +2274,36 @@
   # Let the user override the test.
   lt_cv_path_NM=3D"$NM"
 else
-  lt_nm_to_check=3D"${ac_tool_prefix}nm"
-  if test -n "$ac_tool_prefix" && test "$build" =3D "$host"; then=20
-    lt_nm_to_check=3D"$lt_nm_to_check nm"
-  fi
-  for lt_tmp_nm in $lt_nm_to_check; do
-    lt_save_ifs=3D"$IFS"; IFS=3D$PATH_SEPARATOR
-    for ac_dir in $PATH /usr/ccs/bin/elf /usr/ccs/bin /usr/ucb /bin; do
-      IFS=3D"$lt_save_ifs"
-      test -z "$ac_dir" && ac_dir=3D.
-      tmp_nm=3D"$ac_dir/$lt_tmp_nm"
-      if test -f "$tmp_nm" || test -f "$tmp_nm$ac_exeext" ; then
-	# Check to see if the nm accepts a BSD-compat flag.
-	# Adding the `sed 1q' prevents false positives on HP-UX, which says:
-	#   nm: unknown option "B" ignored
-	# Tru64's nm complains that /dev/null is an invalid object file
-	case `"$tmp_nm" -B /dev/null 2>&1 | sed '1q'` in
-	*/dev/null* | *'Invalid file or object type'*)
-	  lt_cv_path_NM=3D"$tmp_nm -B"
+  lt_save_ifs=3D"$IFS"; IFS=3D$PATH_SEPARATOR
+  for ac_dir in $PATH /usr/ccs/bin /usr/ucb /bin; do
+    IFS=3D"$lt_save_ifs"
+    test -z "$ac_dir" && ac_dir=3D.
+    tmp_nm=3D"$ac_dir/${ac_tool_prefix}nm"
+    if test -f "$tmp_nm" || test -f "$tmp_nm$ac_exeext" ; then
+      # Check to see if the nm accepts a BSD-compat flag.
+      # Adding the `sed 1q' prevents false positives on HP-UX, which say=
s:
+      #   nm: unknown option "B" ignored
+      # Tru64's nm complains that /dev/null is an invalid object file
+      case `"$tmp_nm" -B /dev/null 2>&1 | sed '1q'` in
+      */dev/null* | *'Invalid file or object type'*)
+	lt_cv_path_NM=3D"$tmp_nm -B"
+	break
+        ;;
+      *)
+	case `"$tmp_nm" -p /dev/null 2>&1 | sed '1q'` in
+	*/dev/null*)
+	  lt_cv_path_NM=3D"$tmp_nm -p"
 	  break
 	  ;;
 	*)
-	  case `"$tmp_nm" -p /dev/null 2>&1 | sed '1q'` in
-	  */dev/null*)
-	    lt_cv_path_NM=3D"$tmp_nm -p"
-	    break
-	    ;;
-	  *)
-	    lt_cv_path_NM=3D${lt_cv_path_NM=3D"$tmp_nm"} # keep the first match=
, but
-	    continue # so that we can try to find one that supports BSD flags
-	    ;;
-	  esac
+	  lt_cv_path_NM=3D${lt_cv_path_NM=3D"$tmp_nm"} # keep the first match, =
but
+	  continue # so that we can try to find one that supports BSD flags
 	  ;;
 	esac
-      fi
-    done
-    IFS=3D"$lt_save_ifs"
+      esac
+    fi
   done
+  IFS=3D"$lt_save_ifs"
   test -z "$lt_cv_path_NM" && lt_cv_path_NM=3Dnm
 fi])
 NM=3D"$lt_cv_path_NM"
@@ -2529,13 +2335,13 @@
 # -----------------------------------
 # sets LIBLTDL to the link flags for the libltdl convenience library and
 # LTDLINCL to the include flags for the libltdl header and adds
-# --enable-ltdl-convenience to the configure arguments.  Note that
-# AC_CONFIG_SUBDIRS is not called here.  If DIRECTORY is not provided,
-# it is assumed to be `libltdl'.  LIBLTDL will be prefixed with
-# '${top_builddir}/' and LTDLINCL will be prefixed with '${top_srcdir}/'
-# (note the single quotes!).  If your package is not flat and you're not
-# using automake, define top_builddir and top_srcdir appropriately in
-# the Makefiles.
+# --enable-ltdl-convenience to the configure arguments.  Note that LIBLT=
DL
+# and LTDLINCL are not AC_SUBSTed, nor is AC_CONFIG_SUBDIRS called.  If
+# DIRECTORY is not provided, it is assumed to be `libltdl'.  LIBLTDL wil=
l
+# be prefixed with '${top_builddir}/' and LTDLINCL will be prefixed with
+# '${top_srcdir}/' (note the single quotes!).  If your package is not
+# flat and you're not using automake, define top_builddir and
+# top_srcdir appropriately in the Makefiles.
 AC_DEFUN([AC_LIBLTDL_CONVENIENCE],
 [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
   case $enable_ltdl_convenience in
@@ -2554,13 +2360,13 @@
 # -----------------------------------
 # sets LIBLTDL to the link flags for the libltdl installable library and
 # LTDLINCL to the include flags for the libltdl header and adds
-# --enable-ltdl-install to the configure arguments.  Note that
-# AC_CONFIG_SUBDIRS is not called here.  If DIRECTORY is not provided,
-# and an installed libltdl is not found, it is assumed to be `libltdl'.
-# LIBLTDL will be prefixed with '${top_builddir}/'# and LTDLINCL with
-# '${top_srcdir}/' (note the single quotes!).  If your package is not
-# flat and you're not using automake, define top_builddir and top_srcdir
-# appropriately in the Makefiles.
+# --enable-ltdl-install to the configure arguments.  Note that LIBLTDL
+# and LTDLINCL are not AC_SUBSTed, nor is AC_CONFIG_SUBDIRS called.  If
+# DIRECTORY is not provided and an installed libltdl is not found, it is
+# assumed to be `libltdl'.  LIBLTDL will be prefixed with '${top_builddi=
r}/'
+# and LTDLINCL will be prefixed with '${top_srcdir}/' (note the single
+# quotes!).  If your package is not flat and you're not using automake,
+# define top_builddir and top_srcdir appropriately in the Makefiles.
 # In the future, this macro may have to be called after AC_PROG_LIBTOOL.
 AC_DEFUN([AC_LIBLTDL_INSTALLABLE],
 [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
@@ -2598,21 +2404,10 @@
 # ---------------
 AC_DEFUN([_LT_AC_LANG_CXX],
 [AC_REQUIRE([AC_PROG_CXX])
-AC_REQUIRE([_LT_AC_PROG_CXXCPP])
+AC_REQUIRE([AC_PROG_CXXCPP])
 _LT_AC_SHELL_INIT([tagnames=3D${tagnames+${tagnames},}CXX])
 ])# _LT_AC_LANG_CXX
=20
-# _LT_AC_PROG_CXXCPP
-# ------------------
-AC_DEFUN([_LT_AC_PROG_CXXCPP],
-[
-AC_REQUIRE([AC_PROG_CXX])
-if test -n "$CXX" && ( test "X$CXX" !=3D "Xno" &&
-    ( (test "X$CXX" =3D "Xg++" && `g++ -v >/dev/null 2>&1` ) ||
-    (test "X$CXX" !=3D "Xg++"))) ; then
-  AC_PROG_CXXCPP
-fi
-])# _LT_AC_PROG_CXXCPP
=20
 # AC_LIBTOOL_F77
 # --------------
@@ -2652,7 +2447,7 @@
=20
=20
 # AC_LIBTOOL_RC
-# -------------
+# --------------
 # enable support for Windows resource files
 AC_DEFUN([AC_LIBTOOL_RC],
 [AC_REQUIRE([LT_AC_PROG_RC])
@@ -2685,10 +2480,37 @@
=20
 _LT_AC_SYS_COMPILER
=20
-# save warnings/boilerplate of simple test code
-_LT_COMPILER_BOILERPLATE
-_LT_LINKER_BOILERPLATE
+#
+# Check for any special shared library compilation flags.
+#
+_LT_AC_TAGVAR(lt_prog_cc_shlib, $1)=3D
+if test "$GCC" =3D no; then
+  case $host_os in
+  sco3.2v5*)
+    _LT_AC_TAGVAR(lt_prog_cc_shlib, $1)=3D'-belf'
+    ;;
+  esac
+fi
+if test -n "$_LT_AC_TAGVAR(lt_prog_cc_shlib, $1)"; then
+  AC_MSG_WARN([`$CC' requires `$_LT_AC_TAGVAR(lt_prog_cc_shlib, $1)' to =
build shared libraries])
+  if echo "$old_CC $old_CFLAGS " | grep "[[ 	]]$_LT_AC_TAGVAR(lt_prog_cc=
_shlib, $1)[[ 	]]" >/dev/null; then :
+  else
+    AC_MSG_WARN([add `$_LT_AC_TAGVAR(lt_prog_cc_shlib, $1)' to the CC or=
 CFLAGS env variable and reconfigure])
+    _LT_AC_TAGVAR(lt_cv_prog_cc_can_build_shared, $1)=3Dno
+  fi
+fi
=20
+
+#
+# Check to make sure the static flag actually works.
+#
+AC_LIBTOOL_LINKER_OPTION([if $compiler static flag $_LT_AC_TAGVAR(lt_pro=
g_compiler_static, $1) works],
+  _LT_AC_TAGVAR(lt_prog_compiler_static_works, $1),
+  $_LT_AC_TAGVAR(lt_prog_compiler_static, $1),
+  [],
+  [_LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D])
+
+
 AC_LIBTOOL_PROG_COMPILER_NO_RTTI($1)
 AC_LIBTOOL_PROG_COMPILER_PIC($1)
 AC_LIBTOOL_PROG_CC_C_O($1)
@@ -2697,9 +2519,9 @@
 AC_LIBTOOL_SYS_DYNAMIC_LINKER($1)
 AC_LIBTOOL_PROG_LD_HARDCODE_LIBPATH($1)
 AC_LIBTOOL_SYS_LIB_STRIP
-AC_LIBTOOL_DLOPEN_SELF
+AC_LIBTOOL_DLOPEN_SELF($1)
=20
-# Report which library types will actually be built
+# Report which librarie types wil actually be built
 AC_MSG_CHECKING([if libtool supports shared libraries])
 AC_MSG_RESULT([$can_build_shared])
=20
@@ -2708,7 +2530,7 @@
=20
 # On AIX, shared libraries and static libraries use the same namespace, =
and
 # are all built from PIC.
-case $host_os in
+case "$host_os" in
 aix3*)
   test "$enable_shared" =3D yes && enable_static=3Dno
   if test -n "$RANLIB"; then
@@ -2721,6 +2543,43 @@
   if test "$host_cpu" !=3D ia64 && test "$aix_use_runtimelinking" =3D no=
 ; then
     test "$enable_shared" =3D yes && enable_static=3Dno
   fi
+  ;;
+  darwin* | rhapsody*)
+  if test "$GCC" =3D yes; then
+    _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
+    case "$host_os" in
+    rhapsody* | darwin1.[[012]])
+      _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-undefined suppress'
+      ;;
+    *) # Darwin 1.3 on
+      if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
+      	_LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-flat_namespace -undef=
ined suppress'
+      else
+        case ${MACOSX_DEPLOYMENT_TARGET} in
+          10.[[012]])
+            _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-flat_namespace -=
undefined suppress'
+            ;;
+          10.*)
+            _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-undefined dynami=
c_lookup'
+            ;;
+        esac
+      fi
+      ;;
+    esac
+    output_verbose_link_cmd=3D'echo'
+    _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -dynamiclib $allow_undefined_=
flag -o $lib $libobjs $deplibs$compiler_flags -install_name $rpath/$sonam=
e $verstring'
+    _LT_AC_TAGVAR(module_cmds, $1)=3D'$CC $allow_undefined_flag -o $lib =
-bundle $libobjs $deplibs$compiler_flags'
+    # Don't fix this by using the ld -exported_symbols_list flag, it doe=
sn't exist in older darwin ld's
+    _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "s,^[ =
   ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname=
}-symbols.expsym~$CC -dynamiclib $allow_undefined_flag  -o $lib $libobjs =
$deplibs$compiler_flags -install_name $rpath/$soname $verstring~nmedit -s=
 $output_objdir/${libname}-symbols.expsym ${lib}'
+    _LT_AC_TAGVAR(module_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "s,^[  =
  ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}=
-symbols.expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $depl=
ibs$compiler_flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${l=
ib}'
+    _LT_AC_TAGVAR(hardcode_direct, $1)=3Dno
+    _LT_AC_TAGVAR(hardcode_automatic, $1)=3Dyes
+    _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dunsupported
+    _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'-all_load $convenience=
'
+    _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dyes
+  else
+    _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
+  fi
     ;;
 esac
 AC_MSG_RESULT([$enable_shared])
@@ -2746,7 +2605,7 @@
 AC_DEFUN([_LT_AC_LANG_CXX_CONFIG],
 [AC_LANG_PUSH(C++)
 AC_REQUIRE([AC_PROG_CXX])
-AC_REQUIRE([_LT_AC_PROG_CXXCPP])
+AC_REQUIRE([AC_PROG_CXXCPP])
=20
 _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
 _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D
@@ -2758,7 +2617,6 @@
 _LT_AC_TAGVAR(hardcode_libdir_flag_spec_ld, $1)=3D
 _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D
 _LT_AC_TAGVAR(hardcode_minus_L, $1)=3Dno
-_LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dunsupported
 _LT_AC_TAGVAR(hardcode_automatic, $1)=3Dno
 _LT_AC_TAGVAR(module_cmds, $1)=3D
 _LT_AC_TAGVAR(module_expsym_cmds, $1)=3D
@@ -2776,7 +2634,7 @@
 _LT_AC_TAGVAR(compiler_lib_search_path, $1)=3D
=20
 # Source file extension for C++ test sources.
-ac_ext=3Dcpp
+ac_ext=3Dcc
=20
 # Object file extension for compiled C++ test sources.
 objext=3Do
@@ -2786,15 +2644,11 @@
 lt_simple_compile_test_code=3D"int some_variable =3D 0;\n"
=20
 # Code to be used in simple link tests
-lt_simple_link_test_code=3D'int main(int, char *[[]]) { return(0); }\n'
+lt_simple_link_test_code=3D'int main(int, char *[]) { return(0); }\n'
=20
 # ltmain only uses $CC for tagged configurations so make sure $CC is set=
=2E
 _LT_AC_SYS_COMPILER
=20
-# save warnings/boilerplate of simple test code
-_LT_COMPILER_BOILERPLATE
-_LT_LINKER_BOILERPLATE
-
 # Allow CC to be a program name with arguments.
 lt_save_CC=3D$CC
 lt_save_LD=3D$LD
@@ -2805,18 +2659,18 @@
 if test -n "${lt_cv_prog_gnu_ldcxx+set}"; then
   lt_cv_prog_gnu_ld=3D$lt_cv_prog_gnu_ldcxx
 else
-  $as_unset lt_cv_prog_gnu_ld
+  unset lt_cv_prog_gnu_ld
 fi
 if test -n "${lt_cv_path_LDCXX+set}"; then
   lt_cv_path_LD=3D$lt_cv_path_LDCXX
 else
-  $as_unset lt_cv_path_LD
+  unset lt_cv_path_LD
 fi
 test -z "${LDCXX+set}" || LD=3D$LDCXX
 CC=3D${CXX-"c++"}
 compiler=3D$CC
 _LT_AC_TAGVAR(compiler, $1)=3D$CC
-_LT_CC_BASENAME([$compiler])
+cc_basename=3D`$echo X"$compiler" | $Xsed -e 's%^.*/%%'`
=20
 # We don't want -fno-exception wen compiling C++ code, so set the
 # no_builtin_flag separately
@@ -2905,7 +2759,6 @@
 	    ;;
 	  esac
 	done
-	;;
       esac
=20
       exp_sym_flag=3D'-bexport'
@@ -2924,7 +2777,7 @@
     _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dyes
=20
     if test "$GXX" =3D yes; then
-      case $host_os in aix4.[[012]]|aix4.[[012]].*)
+      case $host_os in aix4.[012]|aix4.[012].*)
       # We only want to do this on AIX 4.2 and lower, the check
       # below for broken collect2 doesn't work under 4.3+
 	collect2name=3D`${CC} -print-prog-name=3Dcollect2`
@@ -2943,12 +2796,8 @@
 	  _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'-L$libdir'
 	  _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D
 	fi
-	;;
       esac
       shared_flag=3D'-shared'
-      if test "$aix_use_runtimelinking" =3D yes; then
-	shared_flag=3D"$shared_flag "'${wl}-G'
-      fi
     else
       # not using gcc
       if test "$host_cpu" =3D ia64; then
@@ -2975,12 +2824,12 @@
       _LT_AC_SYS_LIBPATH_AIX
       _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-blibpath:$li=
bdir:'"$aix_libpath"
=20
-      _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC"' -o $output_objdir=
/$soname $libobjs $deplibs '"\${wl}$no_entry_flag"' $compiler_flags `if t=
est "x${allow_undefined_flag}" !=3D "x"; then echo "${wl}${allow_undefine=
d_flag}"; else :; fi` '"\${wl}$exp_sym_flag:\$export_symbols $shared_flag=
"
+      _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC"' -o $output_objdir=
/$soname $libobjs $deplibs $compiler_flags `if test "x${allow_undefined_f=
lag}" !=3D "x"; then echo "${wl}${allow_undefined_flag}"; else :; fi` '"\=
${wl}$no_entry_flag \${wl}$exp_sym_flag:\$export_symbols $shared_flag"
      else
       if test "$host_cpu" =3D ia64; then
 	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-R $libdir:/usr/li=
b:/lib'
 	_LT_AC_TAGVAR(allow_undefined_flag, $1)=3D"-z nodefs"
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC $shared_flag"' -o $outpu=
t_objdir/$soname $libobjs $deplibs '"\${wl}$no_entry_flag"' $compiler_fla=
gs ${wl}${allow_undefined_flag} '"\${wl}$exp_sym_flag:\$export_symbols"
+	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC $shared_flag"' -o $outpu=
t_objdir/$soname $libobjs $deplibs $compiler_flags ${wl}${allow_undefined=
_flag} '"\${wl}$no_entry_flag \${wl}$exp_sym_flag:\$export_symbols"
       else
 	# Determine the default libpath from the value encoded in an empty exec=
utable.
 	_LT_AC_SYS_LIBPATH_AIX
@@ -2989,26 +2838,16 @@
 	# -berok will link without error, but may produce a broken library.
 	_LT_AC_TAGVAR(no_undefined_flag, $1)=3D' ${wl}-bernotok'
 	_LT_AC_TAGVAR(allow_undefined_flag, $1)=3D' ${wl}-berok'
+	# -bexpall does not export symbols beginning with underscore (_)
+	_LT_AC_TAGVAR(always_export_symbols, $1)=3Dyes
 	# Exported symbols can be pulled into shared objects from archives
-	_LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'$convenience'
+	_LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D' '
 	_LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dyes
-	# This is similar to how AIX traditionally builds its shared libraries.
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC $shared_flag"' -o $outpu=
t_objdir/$soname $libobjs $deplibs ${wl}-bnoentry $compiler_flags ${wl}-b=
E:$export_symbols${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$li=
bname$release.a $output_objdir/$soname'
+	# This is similar to how AIX traditionally builds it's shared libraries=
=2E
+	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC $shared_flag"' -o $outpu=
t_objdir/$soname $libobjs $deplibs $compiler_flags ${wl}-bE:$export_symbo=
ls ${wl}-bnoentry${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$li=
bname$release.a $output_objdir/$soname'
       fi
     fi
     ;;
-
-  beos*)
-    if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null; =
then
-      _LT_AC_TAGVAR(allow_undefined_flag, $1)=3Dunsupported
-      # Joseph Beckenbach <jrb3@domain.hid> says some releases of gcc
-      # support --undefined.  This deserves some investigation.  FIXME
-      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -nostart $libobjs $deplibs =
$compiler_flags ${wl}-soname $wl$soname -o $lib'
-    else
-      _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
-    fi
-    ;;
-
   chorus*)
     case $cc_basename in
       *)
@@ -3027,7 +2866,7 @@
     _LT_AC_TAGVAR(enable_shared_with_static_runtimes, $1)=3Dyes
=20
     if $LD --help 2>&1 | grep 'auto-import' > /dev/null; then
-      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib $predep_o=
bjects $libobjs $deplibs $postdep_objects $compiler_flags -o $output_objd=
ir/$soname ${wl}--enable-auto-image-base -Xlinker --out-implib -Xlinker $=
lib'
+      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib $predep_o=
bjects $libobjs $deplibs $postdep_objects $compiler_flags -o $output_objd=
ir/$soname ${wl}--image-base=3D0x10000000 ${wl}--out-implib,$lib'
       # If the export-symbols file already is a .def file (1st line
       # is EXPORTS), use it as is; otherwise, prepend...
       _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'if test "x`$SED 1q $expo=
rt_symbols`" =3D xEXPORTS; then
@@ -3036,81 +2875,70 @@
 	echo EXPORTS > $output_objdir/$soname.def;
 	cat $export_symbols >> $output_objdir/$soname.def;
       fi~
-      $CC -shared -nostdlib $output_objdir/$soname.def $predep_objects $=
libobjs $deplibs $postdep_objects $compiler_flags -o $output_objdir/$sona=
me ${wl}--enable-auto-image-base -Xlinker --out-implib -Xlinker $lib'
+      $CC -shared -nostdlib $output_objdir/$soname.def $predep_objects $=
libobjs $deplibs $postdep_objects $compiler_flags -o $output_objdir/$sona=
me ${wl}--image-base=3D0x10000000 ${wl}--out-implib,$lib'
     else
       _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
     fi
   ;;
-      darwin* | rhapsody*)
-        case $host_os in
-        rhapsody* | darwin1.[[012]])
-         _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'${wl}-undefined ${wl=
}suppress'
-         ;;
-       *) # Darwin 1.3 on
-         if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
-           _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'${wl}-flat_namespa=
ce ${wl}-undefined ${wl}suppress'
-         else
-           case ${MACOSX_DEPLOYMENT_TARGET} in
-             10.[[012]])
-               _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'${wl}-flat_nam=
espace ${wl}-undefined ${wl}suppress'
-               ;;
-             10.*)
-               _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'${wl}-undefine=
d ${wl}dynamic_lookup'
-               ;;
-           esac
-         fi
-         ;;
-        esac
-      _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
-      _LT_AC_TAGVAR(hardcode_direct, $1)=3Dno
-      _LT_AC_TAGVAR(hardcode_automatic, $1)=3Dyes
-      _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dunsupported
-      _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D''
-      _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dyes
=20
-    if test "$GXX" =3D yes ; then
-      lt_int_apple_cc_single_mod=3Dno
-      output_verbose_link_cmd=3D'echo'
-      if $CC -dumpspecs 2>&1 | $EGREP 'single_module' >/dev/null ; then
-       lt_int_apple_cc_single_mod=3Dyes
-      fi
-      if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
-       _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -dynamiclib -single_module=
 $allow_undefined_flag -o $lib $libobjs $deplibs $compiler_flags -install=
_name $rpath/$soname $verstring'
+  darwin* | rhapsody*)
+  if test "$GXX" =3D yes; then
+    _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
+    case "$host_os" in
+    rhapsody* | darwin1.[[012]])
+      _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-undefined suppress'
+      ;;
+    *) # Darwin 1.3 on
+      if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
+      	_LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-flat_namespace -undef=
ined suppress'
       else
-          _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -r -keep_private_extern=
s -nostdlib -o ${lib}-master.o $libobjs~$CC -dynamiclib $allow_undefined_=
flag -o $lib ${lib}-master.o $deplibs $compiler_flags -install_name $rpat=
h/$soname $verstring'
-        fi
-        _LT_AC_TAGVAR(module_cmds, $1)=3D'$CC $allow_undefined_flag -o $=
lib -bundle $libobjs $deplibs$compiler_flags'
-        # Don't fix this by using the ld -exported_symbols_list flag, it=
 doesn't exist in older darwin lds
-          if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
-            _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed -e "s,#.*,," -=
e "s,^[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/$=
{libname}-symbols.expsym~$CC -dynamiclib -single_module $allow_undefined_=
flag -o $lib $libobjs $deplibs $compiler_flags -install_name $rpath/$sona=
me $verstring~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
-          else
-            _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed -e "s,#.*,," -=
e "s,^[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/$=
{libname}-symbols.expsym~$CC -r -keep_private_externs -nostdlib -o ${lib}=
-master.o $libobjs~$CC -dynamiclib $allow_undefined_flag -o $lib ${lib}-m=
aster.o $deplibs $compiler_flags -install_name $rpath/$soname $verstring~=
nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
-          fi
-            _LT_AC_TAGVAR(module_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e=
 "s,^[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${=
libname}-symbols.expsym~$CC $allow_undefined_flag  -o $lib -bundle $libob=
js $deplibs$compiler_flags~nmedit -s $output_objdir/${libname}-symbols.ex=
psym ${lib}'
-      else
-      case $cc_basename in
-        xlc*)
-         output_verbose_link_cmd=3D'echo'
-          _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -qmkshrobj ${wl}-single=
_module $allow_undefined_flag -o $lib $libobjs $deplibs $compiler_flags $=
{wl}-install_name ${wl}`echo $rpath/$soname` $verstring'
-          _LT_AC_TAGVAR(module_cmds, $1)=3D'$CC $allow_undefined_flag -o=
 $lib -bundle $libobjs $deplibs$compiler_flags'
-          # Don't fix this by using the ld -exported_symbols_list flag, =
it doesn't exist in older darwin lds
-          _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e =
"s,^[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${l=
ibname}-symbols.expsym~$CC -qmkshrobj ${wl}-single_module $allow_undefine=
d_flag -o $lib $libobjs $deplibs $compiler_flags ${wl}-install_name ${wl}=
$rpath/$soname $verstring~nmedit -s $output_objdir/${libname}-symbols.exp=
sym ${lib}'
-          _LT_AC_TAGVAR(module_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "=
s,^[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${li=
bname}-symbols.expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs=
 $deplibs$compiler_flags~nmedit -s $output_objdir/${libname}-symbols.exps=
ym ${lib}'
-          ;;
-       *)
-         _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
-          ;;
-      esac
+        case ${MACOSX_DEPLOYMENT_TARGET} in
+          10.[[012]])
+            _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-flat_namespace -=
undefined suppress'
+            ;;
+          10.*)
+            _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-undefined dynami=
c_lookup'
+            ;;
+        esac
       fi
-        ;;
+      ;;
+    esac
+    lt_int_apple_cc_single_mod=3Dno
+    output_verbose_link_cmd=3D'echo'
+    if $CC -dumpspecs 2>&1 | grep 'single_module' >/dev/null ; then
+      lt_int_apple_cc_single_mod=3Dyes
+    fi
+    if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -dynamiclib -single_module =
$allow_undefined_flag -o $lib $libobjs $deplibs $compiler_flags -install_=
name $rpath/$soname $verstring'
+    else
+      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -r ${wl}-bind_at_load -keep=
_private_externs -nostdlib -o ${lib}-master.o $libobjs~$CC -dynamiclib $a=
llow_undefined_flag -o $lib ${lib}-master.o $deplibs $compiler_flags -ins=
tall_name $rpath/$soname $verstring'
+    fi
+    _LT_AC_TAGVAR(module_cmds, $1)=3D'$CC ${wl}-bind_at_load $allow_unde=
fined_flag -o $lib -bundle $libobjs $deplibs$compiler_flags'
=20
+    # Don't fix this by using the ld -exported_symbols_list flag, it doe=
sn't exist in older darwin ld's
+    if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+      _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "s,^=
[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libna=
me}-symbols.expsym~$CC -dynamiclib -single_module $allow_undefined_flag -=
o $lib $libobjs $deplibs $compiler_flags -install_name $rpath/$soname $ve=
rstring~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+    else
+      _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "s,^=
[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libna=
me}-symbols.expsym~$CC -r ${wl}-bind_at_load -keep_private_externs -nostd=
lib -o ${lib}-master.o $libobjs~$CC -dynamiclib $allow_undefined_flag -o =
$lib ${lib}-master.o $deplibs $compiler_flags -install_name $rpath/$sonam=
e $verstring~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+    fi
+    _LT_AC_TAGVAR(module_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "s,^[  =
  ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libname}=
-symbols.expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $depl=
ibs$compiler_flags~nmedit -s $output_objdir/${libname}-symbols.expsym ${l=
ib}'
+    _LT_AC_TAGVAR(hardcode_direct, $1)=3Dno
+    _LT_AC_TAGVAR(hardcode_automatic, $1)=3Dyes
+    _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dunsupported
+    _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'-all_load $convenience=
'
+    _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dyes
+  else
+    _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
+  fi
+    ;;
+
   dgux*)
     case $cc_basename in
-      ec++*)
+      ec++)
 	# FIXME: insert proper C++ library support
 	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
 	;;
-      ghcx*)
+      ghcx)
 	# Green Hills C++ Compiler
 	# FIXME: insert proper C++ library support
 	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
@@ -3121,14 +2949,14 @@
 	;;
     esac
     ;;
-  freebsd[[12]]*)
+  freebsd[12]*)
     # C++ shared libraries reported to be fairly broken before switch to=
 ELF
     _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
     ;;
   freebsd-elf*)
     _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
     ;;
-  freebsd* | kfreebsd*-gnu | dragonfly*)
+  freebsd* | kfreebsd*-gnu)
     # FreeBSD 3 and later use GNU C++ and GNU ld with standard ELF
     # conventions
     _LT_AC_TAGVAR(ld_shlibs, $1)=3Dyes
@@ -3145,11 +2973,11 @@
 				# location of the library.
=20
     case $cc_basename in
-    CC*)
+    CC)
       # FIXME: insert proper C++ library support
       _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
       ;;
-    aCC*)
+    aCC)
       _LT_AC_TAGVAR(archive_cmds, $1)=3D'$rm $output_objdir/$soname~$CC =
-b ${wl}+b ${wl}$install_libdir -o $output_objdir/$soname $predep_objects=
 $libobjs $deplibs $postdep_objects $compiler_flags~test $output_objdir/$=
soname =3D $lib || mv $output_objdir/$soname $lib'
       # Commands to make compiler produce verbose output that lists
       # what "hidden" libraries, object files and flags are used when
@@ -3159,7 +2987,7 @@
       # explicitly linking system object files so we need to strip them
       # from the output so that they don't get included in the library
       # dependencies.
-      output_verbose_link_cmd=3D'templist=3D`($CC -b $CFLAGS -v conftest=
.$objext 2>&1) | grep "[[-]]L"`; list=3D""; for z in $templist; do case $=
z in conftest.$objext) list=3D"$list $z";; *.$objext);; *) list=3D"$list =
$z";;esac; done; echo $list'
+      output_verbose_link_cmd=3D'templist=3D`($CC -b $CFLAGS -v conftest=
.$objext 2>&1) | grep "[-]L"`; list=3D""; for z in $templist; do case $z =
in conftest.$objext) list=3D"$list $z";; *.$objext);; *) list=3D"$list $z=
";;esac; done; echo $list'
       ;;
     *)
       if test "$GXX" =3D yes; then
@@ -3173,23 +3001,34 @@
     ;;
   hpux10*|hpux11*)
     if test $with_gnu_ld =3D no; then
-      _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}+b ${wl}$libd=
ir'
-      _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
-
-      case $host_cpu in
-      hppa*64*|ia64*)
+      case "$host_cpu" in
+      hppa*64*)
+	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}+b ${wl}$libdir'
 	_LT_AC_TAGVAR(hardcode_libdir_flag_spec_ld, $1)=3D'+b $libdir'
+	_LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
         ;;
+      ia64*)
+	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'-L$libdir'
+        ;;
       *)
+	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}+b ${wl}$libdir'
+	_LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
 	_LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-E'
         ;;
       esac
     fi
-    case $host_cpu in
-    hppa*64*|ia64*)
+    case "$host_cpu" in
+    hppa*64*)
       _LT_AC_TAGVAR(hardcode_direct, $1)=3Dno
       _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
       ;;
+    ia64*)
+      _LT_AC_TAGVAR(hardcode_direct, $1)=3Dno
+      _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
+      _LT_AC_TAGVAR(hardcode_minus_L, $1)=3Dyes # Not in the search PATH=
,
+					      # but as the default
+					      # location of the library.
+      ;;
     *)
       _LT_AC_TAGVAR(hardcode_direct, $1)=3Dyes
       _LT_AC_TAGVAR(hardcode_minus_L, $1)=3Dyes # Not in the search PATH=
,
@@ -3199,18 +3038,15 @@
     esac
=20
     case $cc_basename in
-      CC*)
+      CC)
 	# FIXME: insert proper C++ library support
 	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
 	;;
-      aCC*)
-	case $host_cpu in
-	hppa*64*)
-	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -b ${wl}+h ${wl}$soname -o $li=
b $predep_objects $libobjs $deplibs $postdep_objects $compiler_flags'
+      aCC)
+	case "$host_cpu" in
+	hppa*64*|ia64*)
+	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -b +h $soname -o $lib $linker_=
flags $libobjs $deplibs'
 	  ;;
-	ia64*)
-	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+=
nodefaultrpath -o $lib $predep_objects $libobjs $deplibs $postdep_objects=
 $compiler_flags'
-	  ;;
 	*)
 	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+=
b ${wl}$install_libdir -o $lib $predep_objects $libobjs $deplibs $postdep=
_objects $compiler_flags'
 	  ;;
@@ -3228,13 +3064,10 @@
       *)
 	if test "$GXX" =3D yes; then
 	  if test $with_gnu_ld =3D no; then
-	    case $host_cpu in
-	    hppa*64*)
-	      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib -fPIC ${=
wl}+h ${wl}$soname -o $lib $predep_objects $libobjs $deplibs $postdep_obj=
ects $compiler_flags'
+	    case "$host_cpu" in
+	    ia64*|hppa*64*)
+	      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -b +h $soname -o $lib $lin=
ker_flags $libobjs $deplibs'
 	      ;;
-	    ia64*)
-	      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib -fPIC ${=
wl}+h ${wl}$soname ${wl}+nodefaultrpath -o $lib $predep_objects $libobjs =
$deplibs $postdep_objects $compiler_flags'
-	      ;;
 	    *)
 	      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib -fPIC ${=
wl}+h ${wl}$soname ${wl}+b ${wl}$install_libdir -o $lib $predep_objects $=
libobjs $deplibs $postdep_objects $compiler_flags'
 	      ;;
@@ -3247,25 +3080,11 @@
 	;;
     esac
     ;;
-  interix3*)
-    _LT_AC_TAGVAR(hardcode_direct, $1)=3Dno
-    _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
-    _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-rpath,$libdir'
-    _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-E'
-    # Hack: On Interix 3.x, we cannot compile PIC because of a broken gc=
c.
-    # Instead, shared libraries are loaded at an image base (0x10000000 =
by
-    # default) and relocated if they conflict, which is a slow very memo=
ry
-    # consuming and fragmenting process.  To avoid this, we pick a rando=
m,
-    # 256 KiB-aligned image base between 0x50000000 and 0x6FFC0000 at li=
nk
-    # time.  Moving up from 0x10000000 also allows more sbrk(2) space.
-    _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $pic_flag $libobjs $d=
eplibs $compiler_flags ${wl}-h,$soname ${wl}--image-base,`expr ${RANDOM-$=
$} % 4096 / 2 \* 262144 + 1342177280` -o $lib'
-    _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed "s,^,_," $export_symbo=
ls >$output_objdir/$soname.expsym~$CC -shared $pic_flag $libobjs $deplibs=
 $compiler_flags ${wl}-h,$soname ${wl}--retain-symbols-file,$output_objdi=
r/$soname.expsym ${wl}--image-base,`expr ${RANDOM-$$} % 4096 / 2 \* 26214=
4 + 1342177280` -o $lib'
-    ;;
   irix5* | irix6*)
     case $cc_basename in
-      CC*)
+      CC)
 	# SGI C++
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -all -multigot $predep_o=
bjects $libobjs $deplibs $postdep_objects $compiler_flags -soname $soname=
 `test -n "$verstring" && echo -set_version $verstring` -update_registry =
${output_objdir}/so_locations -o $lib'
+	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -all -multigot $predep_o=
bjects $libobjs $deplibs $postdep_objects $compiler_flags -soname $soname=
 `test -n "$verstring" && echo -set_version $verstring` -update_registry =
${objdir}/so_locations -o $lib'
=20
 	# Archives containing C++ object files must be created using
 	# "CC -ar", where "CC" is the IRIX C++ compiler.  This is
@@ -3276,7 +3095,7 @@
       *)
 	if test "$GXX" =3D yes; then
 	  if test "$with_gnu_ld" =3D no; then
-	    _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib $predep_ob=
jects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-soname ${w=
l}$soname `test -n "$verstring" && echo ${wl}-set_version ${wl}$verstring=
` ${wl}-update_registry ${wl}${output_objdir}/so_locations -o $lib'
+	    _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib $predep_ob=
jects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-soname ${w=
l}$soname `test -n "$verstring" && echo ${wl}-set_version ${wl}$verstring=
` ${wl}-update_registry ${wl}${objdir}/so_locations -o $lib'
 	  else
 	    _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib $predep_ob=
jects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-soname ${w=
l}$soname `test -n "$verstring" && echo ${wl}-set_version ${wl}$verstring=
` -o $lib'
 	  fi
@@ -3289,7 +3108,7 @@
     ;;
   linux*)
     case $cc_basename in
-      KCC*)
+      KCC)
 	# Kuck and Associates, Inc. (KAI) C++ Compiler
=20
 	# KCC will only create a shared library if the output file
@@ -3314,41 +3133,17 @@
 	# "CC -Bstatic", where "CC" is the KAI C++ compiler.
 	_LT_AC_TAGVAR(old_archive_cmds, $1)=3D'$CC -Bstatic -o $oldlib $oldobjs=
'
 	;;
-      icpc*)
+      icpc)
 	# Intel C++
 	with_gnu_ld=3Dyes
-	# version 8.0 and above of icpc choke on multiply defined symbols
-	# if we add $predep_objects and $postdep_objects, however 7.1 and
-	# earlier do not add the objects themselves.
-	case `$CC -V 2>&1` in
-	*"Version 7."*)
-  	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $predep_objects $lib=
objs $deplibs $postdep_objects $compiler_flags ${wl}-soname $wl$soname -o=
 $lib'
-  	  _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared $predep_objec=
ts $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-soname $wl$so=
name ${wl}-retain-symbols-file $wl$export_symbols -o $lib'
-	  ;;
-	*)  # Version 8.0 or newer
-	  tmp_idyn=3D
-	  case $host_cpu in
-	    ia64*) tmp_idyn=3D' -i_dynamic';;
-	  esac
-  	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared'"$tmp_idyn"' $libobj=
s $deplibs $compiler_flags ${wl}-soname $wl$soname -o $lib'
-	  _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared'"$tmp_idyn"' $l=
ibobjs $deplibs $compiler_flags ${wl}-soname $wl$soname ${wl}-retain-symb=
ols-file $wl$export_symbols -o $lib'
-	  ;;
-	esac
 	_LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
+	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $predep_objects $libobjs=
 $deplibs $postdep_objects $compiler_flags ${wl}-soname $wl$soname -o $li=
b'
+	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared $predep_objects $=
libobjs $deplibs $postdep_objects $compiler_flags ${wl}-soname $wl$soname=
 ${wl}-retain-symbols-file $wl$export_symbols -o $lib'
 	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-rpath,$libdir'
 	_LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}--export-dynamic'
 	_LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'${wl}--whole-archive$conv=
enience ${wl}--no-whole-archive'
 	;;
-      pgCC*)
-        # Portland Group C++ compiler
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $pic_flag $predep_object=
s $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-soname ${wl}$s=
oname -o $lib'
-  	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared $pic_flag $pred=
ep_objects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-sonam=
e ${wl}$soname ${wl}-retain-symbols-file ${wl}$export_symbols -o $lib'
-
-	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}--rpath ${wl}$libd=
ir'
-	_LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}--export-dynamic'
-	_LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'${wl}--whole-archive`for =
conv in $convenience\"\"; do test  -n \"$conv\" && new_convenience=3D\"$n=
ew_convenience,$conv\"; done; $echo \"$new_convenience\"` ${wl}--no-whole=
-archive'
-        ;;
-      cxx*)
+      cxx)
 	# Compaq C++
 	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $predep_objects $libobjs=
 $deplibs $postdep_objects $compiler_flags ${wl}-soname $wl$soname -o $li=
b'
 	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared $predep_objects $=
libobjs $deplibs $postdep_objects $compiler_flags ${wl}-soname $wl$soname=
  -o $lib ${wl}-retain-symbols-file $wl$export_symbols'
@@ -3379,7 +3174,7 @@
     ;;
   mvs*)
     case $cc_basename in
-      cxx*)
+      cxx)
 	# FIXME: insert proper C++ library support
 	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
 	;;
@@ -3400,25 +3195,9 @@
     # Workaround some broken pre-1.5 toolchains
     output_verbose_link_cmd=3D'$CC -shared $CFLAGS -v conftest.$objext 2=
>&1 | grep conftest.$objext | $SED -e "s:-lgcc -lc -lgcc::"'
     ;;
-  openbsd2*)
-    # C++ shared libraries are fairly broken
-    _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
-    ;;
-  openbsd*)
-    _LT_AC_TAGVAR(hardcode_direct, $1)=3Dyes
-    _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
-    _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $pic_flag $predep_obj=
ects $libobjs $deplibs $postdep_objects $compiler_flags -o $lib'
-    _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-rpath,$libdir'
-    if test -z "`echo __ELF__ | $CC -E - | grep __ELF__`" || test "$host=
_os-$host_cpu" =3D "openbsd2.8-powerpc"; then
-      _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared $pic_flag $p=
redep_objects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-re=
tain-symbols-file,$export_symbols -o $lib'
-      _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-E'
-      _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D"$wlarc"'--whole-arch=
ive$convenience '"$wlarc"'--no-whole-archive'
-    fi
-    output_verbose_link_cmd=3D'echo'
-    ;;
   osf3*)
     case $cc_basename in
-      KCC*)
+      KCC)
 	# Kuck and Associates, Inc. (KAI) C++ Compiler
=20
 	# KCC will only create a shared library if the output file
@@ -3434,14 +3213,14 @@
 	_LT_AC_TAGVAR(old_archive_cmds, $1)=3D'$CC -Bstatic -o $oldlib $oldobjs=
'
=20
 	;;
-      RCC*)
+      RCC)
 	# Rational C++ 2.4.1
 	# FIXME: insert proper C++ library support
 	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
 	;;
-      cxx*)
+      cxx)
 	_LT_AC_TAGVAR(allow_undefined_flag, $1)=3D' ${wl}-expect_unresolved ${w=
l}\*'
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared${allow_undefined_flag} $=
predep_objects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-s=
oname $soname `test -n "$verstring" && echo ${wl}-set_version $verstring`=
 -update_registry ${output_objdir}/so_locations -o $lib'
+	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared${allow_undefined_flag} $=
predep_objects $libobjs $deplibs $postdep_objects $compiler_flags ${wl}-s=
oname $soname `test -n "$verstring" && echo ${wl}-set_version $verstring`=
 -update_registry ${objdir}/so_locations -o $lib'
=20
 	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-rpath ${wl}$libdi=
r'
 	_LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
@@ -3459,7 +3238,7 @@
       *)
 	if test "$GXX" =3D yes && test "$with_gnu_ld" =3D no; then
 	  _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D' ${wl}-expect_unresolved $=
{wl}\*'
-	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib ${allow_unde=
fined_flag} $predep_objects $libobjs $deplibs $postdep_objects $compiler_=
flags ${wl}-soname ${wl}$soname `test -n "$verstring" && echo ${wl}-set_v=
ersion ${wl}$verstring` ${wl}-update_registry ${wl}${output_objdir}/so_lo=
cations -o $lib'
+	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib ${allow_unde=
fined_flag} $predep_objects $libobjs $deplibs $postdep_objects $compiler_=
flags ${wl}-soname ${wl}$soname `test -n "$verstring" && echo ${wl}-set_v=
ersion ${wl}$verstring` ${wl}-update_registry ${wl}${objdir}/so_locations=
 -o $lib'
=20
 	  _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-rpath ${wl}$lib=
dir'
 	  _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
@@ -3478,7 +3257,7 @@
     ;;
   osf4* | osf5*)
     case $cc_basename in
-      KCC*)
+      KCC)
 	# Kuck and Associates, Inc. (KAI) C++ Compiler
=20
 	# KCC will only create a shared library if the output file
@@ -3493,17 +3272,17 @@
 	# the KAI C++ compiler.
 	_LT_AC_TAGVAR(old_archive_cmds, $1)=3D'$CC -o $oldlib $oldobjs'
 	;;
-      RCC*)
+      RCC)
 	# Rational C++ 2.4.1
 	# FIXME: insert proper C++ library support
 	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
 	;;
-      cxx*)
+      cxx)
 	_LT_AC_TAGVAR(allow_undefined_flag, $1)=3D' -expect_unresolved \*'
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared${allow_undefined_flag} $=
predep_objects $libobjs $deplibs $postdep_objects $compiler_flags -msym -=
soname $soname `test -n "$verstring" && echo -set_version $verstring` -up=
date_registry ${output_objdir}/so_locations -o $lib'
+	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared${allow_undefined_flag} $=
predep_objects $libobjs $deplibs $postdep_objects $compiler_flags -msym -=
soname $soname `test -n "$verstring" && echo -set_version $verstring` -up=
date_registry ${objdir}/so_locations -o $lib'
 	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'for i in `cat $export_symbols=
`; do printf "%s %s\\n" -exported_symbol "\$i" >> $lib.exp; done~
 	  echo "-hidden">> $lib.exp~
-	  $CC -shared$allow_undefined_flag $predep_objects $libobjs $deplibs $p=
ostdep_objects $compiler_flags -msym -soname $soname -Wl,-input -Wl,$lib.=
exp  `test -n "$verstring" && echo -set_version	$verstring` -update_regis=
try ${output_objdir}/so_locations -o $lib~
+	  $CC -shared$allow_undefined_flag $predep_objects $libobjs $deplibs $p=
ostdep_objects $compiler_flags -msym -soname $soname -Wl,-input -Wl,$lib.=
exp  `test -n "$verstring" && echo -set_version	$verstring` -update_regis=
try $objdir/so_locations -o $lib~
 	  $rm $lib.exp'
=20
 	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'-rpath $libdir'
@@ -3522,7 +3301,7 @@
       *)
 	if test "$GXX" =3D yes && test "$with_gnu_ld" =3D no; then
 	  _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D' ${wl}-expect_unresolved $=
{wl}\*'
-	 _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib ${allow_undef=
ined_flag} $predep_objects $libobjs $deplibs $postdep_objects $compiler_f=
lags ${wl}-msym ${wl}-soname ${wl}$soname `test -n "$verstring" && echo $=
{wl}-set_version ${wl}$verstring` ${wl}-update_registry ${wl}${output_obj=
dir}/so_locations -o $lib'
+	 _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -nostdlib ${allow_undef=
ined_flag} $predep_objects $libobjs $deplibs $postdep_objects $compiler_f=
lags ${wl}-msym ${wl}-soname ${wl}$soname `test -n "$verstring" && echo $=
{wl}-set_version ${wl}$verstring` ${wl}-update_registry ${wl}${objdir}/so=
_locations -o $lib'
=20
 	  _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-rpath ${wl}$lib=
dir'
 	  _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
@@ -3543,14 +3322,27 @@
     # FIXME: insert proper C++ library support
     _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
     ;;
+  sco*)
+    _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
+    case $cc_basename in
+      CC)
+	# FIXME: insert proper C++ library support
+	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
+	;;
+      *)
+	# FIXME: insert proper C++ library support
+	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
+	;;
+    esac
+    ;;
   sunos4*)
     case $cc_basename in
-      CC*)
+      CC)
 	# Sun C++ 4.x
 	# FIXME: insert proper C++ library support
 	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
 	;;
-      lcc*)
+      lcc)
 	# Lucid
 	# FIXME: insert proper C++ library support
 	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
@@ -3563,33 +3355,36 @@
     ;;
   solaris*)
     case $cc_basename in
-      CC*)
+      CC)
 	# Sun C++ 4.2, 5.x and Centerline C++
-        _LT_AC_TAGVAR(archive_cmds_need_lc,$1)=3Dyes
 	_LT_AC_TAGVAR(no_undefined_flag, $1)=3D' -zdefs'
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -G${allow_undefined_flag}  -h$so=
name -o $lib $predep_objects $libobjs $deplibs $postdep_objects $compiler=
_flags'
+	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -G${allow_undefined_flag} -nolib=
 -h$soname -o $lib $predep_objects $libobjs $deplibs $postdep_objects $co=
mpiler_flags'
 	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$echo "{ global:" > $lib.exp~=
cat $export_symbols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *=
; };" >> $lib.exp~
-	$CC -G${allow_undefined_flag}  ${wl}-M ${wl}$lib.exp -h$soname -o $lib =
$predep_objects $libobjs $deplibs $postdep_objects $compiler_flags~$rm $l=
ib.exp'
+	$CC -G${allow_undefined_flag} -nolib ${wl}-M ${wl}$lib.exp -h$soname -o=
 $lib $predep_objects $libobjs $deplibs $postdep_objects $compiler_flags~=
$rm $lib.exp'
=20
 	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'-R$libdir'
 	_LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
 	case $host_os in
-	  solaris2.[[0-5]] | solaris2.[[0-5]].*) ;;
+	  solaris2.[0-5] | solaris2.[0-5].*) ;;
 	  *)
 	    # The C++ compiler is used as linker so we must use $wl
 	    # flag to pass the commands to the underlying system
-	    # linker. We must also pass each convience library through
-	    # to the system linker between allextract/defaultextract.
-	    # The C++ compiler will combine linker options so we
-	    # cannot just pass the convience library names through
-	    # without $wl.
+	    # linker.
 	    # Supported since Solaris 2.6 (maybe 2.5.1?)
-	    _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'${wl}-z ${wl}allextra=
ct`for conv in $convenience\"\"; do test -n \"$conv\" && new_convenience=3D=
\"$new_convenience,$conv\"; done; $echo \"$new_convenience\"` ${wl}-z ${w=
l}defaultextract'
+	    _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'${wl}-z ${wl}allextra=
ct$convenience ${wl}-z ${wl}defaultextract'
 	    ;;
 	esac
 	_LT_AC_TAGVAR(link_all_deplibs, $1)=3Dyes
=20
-	output_verbose_link_cmd=3D'echo'
+	# Commands to make compiler produce verbose output that lists
+	# what "hidden" libraries, object files and flags are used when
+	# linking a shared library.
+	#
+	# There doesn't appear to be a way to prevent this compiler from
+	# explicitly linking system object files so we need to strip them
+	# from the output so that they don't get included in the library
+	# dependencies.
+	output_verbose_link_cmd=3D'templist=3D`$CC -G $CFLAGS -v conftest.$obje=
xt 2>&1 | grep "\-[[LR]]"`; list=3D""; for z in $templist; do case $z in =
conftest.$objext) list=3D"$list $z";; *.$objext);; *) list=3D"$list $z";;=
esac; done; echo $list'
=20
 	# Archives containing C++ object files must be created using
 	# "CC -xar", where "CC" is the Sun C++ compiler.  This is
@@ -3597,7 +3392,7 @@
 	# in the archive.
 	_LT_AC_TAGVAR(old_archive_cmds, $1)=3D'$CC -xar -o $oldlib $oldobjs'
 	;;
-      gcx*)
+      gcx)
 	# Green Hills C++ Compiler
 	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $predep_objects $libobjs=
 $deplibs $postdep_objects $compiler_flags ${wl}-h $wl$soname -o $lib'
=20
@@ -3635,63 +3430,12 @@
 	;;
     esac
     ;;
-  sysv4*uw2* | sysv5OpenUNIX* | sysv5UnixWare7.[[01]].[[10]]* | unixware=
7* | sco3.2v5.0.[[024]]*)
-    _LT_AC_TAGVAR(no_undefined_flag, $1)=3D'${wl}-z,text'
+  sysv5OpenUNIX8* | sysv5UnixWare7* | sysv5uw[[78]]* | unixware7*)
     _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
-    _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
-    runpath_var=3D'LD_RUN_PATH'
-
-    case $cc_basename in
-      CC*)
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -G ${wl}-h,$soname -o $lib $libo=
bjs $deplibs $compiler_flags'
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -G ${wl}-Bexport:$export_=
symbols ${wl}-h,$soname -o $lib $libobjs $deplibs $compiler_flags'
-	;;
-      *)
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared ${wl}-h,$soname -o $lib =
$libobjs $deplibs $compiler_flags'
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared ${wl}-Bexport:$ex=
port_symbols ${wl}-h,$soname -o $lib $libobjs $deplibs $compiler_flags'
-	;;
-    esac
     ;;
-  sysv5* | sco3.2v5* | sco5v6*)
-    # Note: We can NOT use -z defs as we might desire, because we do not
-    # link with -lc, and that would cause any symbols used from libc to
-    # always be unresolved, which means just about no library would
-    # ever link correctly.  If we're not using GNU ld we use -z text
-    # though, which does catch some bad symbols but isn't as heavy-hande=
d
-    # as -z defs.
-    # For security reasons, it is highly recommended that you always
-    # use absolute paths for naming shared libraries, and exclude the
-    # DT_RUNPATH tag from executables and libraries.  But doing so
-    # requires that you compile everything twice, which is a pain.
-    # So that behaviour is only enabled if SCOABSPATH is set to a
-    # non-empty value in the environment.  Most likely only useful for
-    # creating official distributions of packages.
-    # This is a hack until libtool officially supports absolute path
-    # names for shared libraries.
-    _LT_AC_TAGVAR(no_undefined_flag, $1)=3D'${wl}-z,text'
-    _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'${wl}-z,nodefs'
-    _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
-    _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
-    _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'`test -z "$SCOABSPAT=
H" && echo ${wl}-R,$libdir`'
-    _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D':'
-    _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dyes
-    _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-Bexport'
-    runpath_var=3D'LD_RUN_PATH'
-
-    case $cc_basename in
-      CC*)
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -G ${wl}-h,\${SCOABSPATH:+${inst=
all_libdir}/}$soname -o $lib $libobjs $deplibs $compiler_flags'
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -G ${wl}-Bexport:$export_=
symbols ${wl}-h,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $libobj=
s $deplibs $compiler_flags'
-	;;
-      *)
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared ${wl}-h,\${SCOABSPATH:+$=
{install_libdir}/}$soname -o $lib $libobjs $deplibs $compiler_flags'
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared ${wl}-Bexport:$ex=
port_symbols ${wl}-h,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $l=
ibobjs $deplibs $compiler_flags'
-	;;
-    esac
-    ;;
   tandem*)
     case $cc_basename in
-      NCC*)
+      NCC)
 	# NonStop-UX NCC 3.20
 	# FIXME: insert proper C++ library support
 	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
@@ -3724,6 +3468,8 @@
 AC_LIBTOOL_PROG_LD_SHLIBS($1)
 AC_LIBTOOL_SYS_DYNAMIC_LINKER($1)
 AC_LIBTOOL_PROG_LD_HARDCODE_LIBPATH($1)
+AC_LIBTOOL_SYS_LIB_STRIP
+AC_LIBTOOL_DLOPEN_SELF($1)
=20
 AC_LIBTOOL_CONFIG($1)
=20
@@ -3741,7 +3487,7 @@
 ])# AC_LIBTOOL_LANG_CXX_CONFIG
=20
 # AC_LIBTOOL_POSTDEP_PREDEP([TAGNAME])
-# ------------------------------------
+# ------------------------
 # Figure out "hidden" library dependencies from verbose
 # compiler output when linking a shared library.
 # Parse the compiler output and extract the necessary
@@ -3795,7 +3541,7 @@
   # The `*' in the case matches for architectures that use `case' in
   # $output_verbose_cmd can trigger glob expansion during the loop
   # eval without this substitution.
-  output_verbose_link_cmd=3D`$echo "X$output_verbose_link_cmd" | $Xsed -=
e "$no_glob_subst"`
+  output_verbose_link_cmd=3D"`$echo \"X$output_verbose_link_cmd\" | $Xse=
d -e \"$no_glob_subst\"`"
=20
   for p in `eval $output_verbose_link_cmd`; do
     case $p in
@@ -3871,37 +3617,13 @@
=20
 $rm -f confest.$objext
=20
-# PORTME: override above test on systems where it is broken
-ifelse([$1],[CXX],
-[case $host_os in
-interix3*)
-  # Interix 3.5 installs completely hosed .la files for C++, so rather t=
han
-  # hack all around it, let's just trust "g++" to DTRT.
-  _LT_AC_TAGVAR(predep_objects,$1)=3D
-  _LT_AC_TAGVAR(postdep_objects,$1)=3D
-  _LT_AC_TAGVAR(postdeps,$1)=3D
-  ;;
-
-solaris*)
-  case $cc_basename in
-  CC*)
-    # Adding this requires a known-good setup of shared libraries for
-    # Sun compiler versions before 5.6, else PIC objects from an old
-    # archive will be linked into the output, leading to subtle bugs.
-    _LT_AC_TAGVAR(postdeps,$1)=3D'-lCstd -lCrun'
-    ;;
-  esac
-  ;;
-esac
-])
-
 case " $_LT_AC_TAGVAR(postdeps, $1) " in
 *" -lc "*) _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno ;;
 esac
 ])# AC_LIBTOOL_POSTDEP_PREDEP
=20
 # AC_LIBTOOL_LANG_F77_CONFIG
-# --------------------------
+# ------------------------
 # Ensure that the configuration vars for the C compiler are
 # suitably defined.  Those variables are subsequently used by
 # AC_LIBTOOL_CONFIG to write the compiler configuration to `libtool'.
@@ -3945,16 +3667,12 @@
 # ltmain only uses $CC for tagged configurations so make sure $CC is set=
=2E
 _LT_AC_SYS_COMPILER
=20
-# save warnings/boilerplate of simple test code
-_LT_COMPILER_BOILERPLATE
-_LT_LINKER_BOILERPLATE
-
 # Allow CC to be a program name with arguments.
 lt_save_CC=3D"$CC"
 CC=3D${F77-"f77"}
 compiler=3D$CC
 _LT_AC_TAGVAR(compiler, $1)=3D$CC
-_LT_CC_BASENAME([$compiler])
+cc_basename=3D`$echo X"$compiler" | $Xsed -e 's%^.*/%%'`
=20
 AC_MSG_CHECKING([if libtool supports shared libraries])
 AC_MSG_RESULT([$can_build_shared])
@@ -3964,7 +3682,7 @@
=20
 # On AIX, shared libraries and static libraries use the same namespace, =
and
 # are all built from PIC.
-case $host_os in
+case "$host_os" in
 aix3*)
   test "$enable_shared" =3D yes && enable_static=3Dno
   if test -n "$RANLIB"; then
@@ -3973,9 +3691,7 @@
   fi
   ;;
 aix4* | aix5*)
-  if test "$host_cpu" !=3D ia64 && test "$aix_use_runtimelinking" =3D no=
 ; then
-    test "$enable_shared" =3D yes && enable_static=3Dno
-  fi
+  test "$enable_shared" =3D yes && enable_static=3Dno
   ;;
 esac
 AC_MSG_RESULT([$enable_shared])
@@ -3985,6 +3701,8 @@
 test "$enable_shared" =3D yes || enable_static=3Dyes
 AC_MSG_RESULT([$enable_static])
=20
+test "$_LT_AC_TAGVAR(ld_shlibs, $1)" =3D no && can_build_shared=3Dno
+
 _LT_AC_TAGVAR(GCC, $1)=3D"$G77"
 _LT_AC_TAGVAR(LD, $1)=3D"$LD"
=20
@@ -3994,7 +3712,9 @@
 AC_LIBTOOL_PROG_LD_SHLIBS($1)
 AC_LIBTOOL_SYS_DYNAMIC_LINKER($1)
 AC_LIBTOOL_PROG_LD_HARDCODE_LIBPATH($1)
+AC_LIBTOOL_SYS_LIB_STRIP
=20
+
 AC_LIBTOOL_CONFIG($1)
=20
 AC_LANG_POP
@@ -4022,27 +3742,20 @@
 lt_simple_compile_test_code=3D"class foo {}\n"
=20
 # Code to be used in simple link tests
-lt_simple_link_test_code=3D'public class conftest { public static void m=
ain(String[[]] argv) {}; }\n'
+lt_simple_link_test_code=3D'public class conftest { public static void m=
ain(String[] argv) {}; }\n'
=20
 # ltmain only uses $CC for tagged configurations so make sure $CC is set=
=2E
 _LT_AC_SYS_COMPILER
=20
-# save warnings/boilerplate of simple test code
-_LT_COMPILER_BOILERPLATE
-_LT_LINKER_BOILERPLATE
-
 # Allow CC to be a program name with arguments.
 lt_save_CC=3D"$CC"
 CC=3D${GCJ-"gcj"}
 compiler=3D$CC
 _LT_AC_TAGVAR(compiler, $1)=3D$CC
-_LT_CC_BASENAME([$compiler])
=20
 # GCJ did not exist at the time GCC didn't implicitly link libc in.
 _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
=20
-_LT_AC_TAGVAR(old_archive_cmds, $1)=3D$old_archive_cmds
-
 AC_LIBTOOL_PROG_COMPILER_NO_RTTI($1)
 AC_LIBTOOL_PROG_COMPILER_PIC($1)
 AC_LIBTOOL_PROG_CC_C_O($1)
@@ -4050,6 +3763,8 @@
 AC_LIBTOOL_PROG_LD_SHLIBS($1)
 AC_LIBTOOL_SYS_DYNAMIC_LINKER($1)
 AC_LIBTOOL_PROG_LD_HARDCODE_LIBPATH($1)
+AC_LIBTOOL_SYS_LIB_STRIP
+AC_LIBTOOL_DLOPEN_SELF($1)
=20
 AC_LIBTOOL_CONFIG($1)
=20
@@ -4059,7 +3774,7 @@
=20
=20
 # AC_LIBTOOL_LANG_RC_CONFIG
-# -------------------------
+# --------------------------
 # Ensure that the configuration vars for the Windows resource compiler a=
re
 # suitably defined.  Those variables are subsequently used by
 # AC_LIBTOOL_CONFIG to write the compiler configuration to `libtool'.
@@ -4083,16 +3798,11 @@
 # ltmain only uses $CC for tagged configurations so make sure $CC is set=
=2E
 _LT_AC_SYS_COMPILER
=20
-# save warnings/boilerplate of simple test code
-_LT_COMPILER_BOILERPLATE
-_LT_LINKER_BOILERPLATE
-
 # Allow CC to be a program name with arguments.
 lt_save_CC=3D"$CC"
 CC=3D${RC-"windres"}
 compiler=3D$CC
 _LT_AC_TAGVAR(compiler, $1)=3D$CC
-_LT_CC_BASENAME([$compiler])
 _LT_AC_TAGVAR(lt_cv_prog_compiler_c_o, $1)=3Dyes
=20
 AC_LIBTOOL_CONFIG($1)
@@ -4122,7 +3832,7 @@
   # Now quote all the things that may contain metacharacters while being
   # careful not to overquote the AC_SUBSTed values.  We take copies of t=
he
   # variables and quote the copies for generation of the libtool script.
-  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC L=
TCFLAGS NM \
+  for var in echo old_CC old_CFLAGS AR AR_FLAGS EGREP RANLIB LN_S LTCC N=
M \
     SED SHELL STRIP \
     libname_spec library_names_spec soname_spec extract_expsyms_cmds \
     old_striplib striplib file_magic_cmd finish_cmds finish_eval \
@@ -4228,7 +3938,7 @@
 #
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-13=
01, USA.
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, =
USA.
 #
 # As a special exception to the GNU General Public License, if you
 # distribute this file as part of a program that contains a
@@ -4239,11 +3949,11 @@
 SED=3D$lt_SED
=20
 # Sed that helps us avoid accidentally triggering echo(1) options like -=
n.
-Xsed=3D"$SED -e 1s/^X//"
+Xsed=3D"$SED -e s/^X//"
=20
 # The HP-UX ksh and POSIX shell print the target directory to stdout
 # if CDPATH is set.
-(unset CDPATH) >/dev/null 2>&1 && unset CDPATH
+if test "X\${CDPATH+set}" =3D Xset; then CDPATH=3D:; export CDPATH; fi
=20
 # The names of the tagged configurations supported by this script.
 available_tags=3D
@@ -4274,13 +3984,7 @@
 # The host system.
 host_alias=3D$host_alias
 host=3D$host
-host_os=3D$host_os
=20
-# The build system.
-build_alias=3D$build_alias
-build=3D$build
-build_os=3D$build_os
-
 # An echo program that does not interpret backslashes.
 echo=3D$lt_echo
=20
@@ -4291,9 +3995,6 @@
 # A C compiler.
 LTCC=3D$lt_LTCC
=20
-# LTCC compiler flags.
-LTCFLAGS=3D$lt_LTCFLAGS
-
 # A language-specific compiler.
 CC=3D$lt_[]_LT_AC_TAGVAR(compiler, $1)
=20
@@ -4359,7 +4060,7 @@
 # Does compiler simultaneously support -c and -o options?
 compiler_c_o=3D$lt_[]_LT_AC_TAGVAR(lt_cv_prog_compiler_c_o, $1)
=20
-# Must we lock files when doing compilation?
+# Must we lock files when doing compilation ?
 need_locks=3D$lt_need_locks
=20
 # Do we need the lib prefix for modules?
@@ -4633,6 +4334,9 @@
 # Regexp to match symbols that can be accessed directly from C.
 sympat=3D'\([[_A-Za-z]][[_A-Za-z0-9]]*\)'
=20
+# Transform the above into a raw symbol and a C symbol.
+symxfrm=3D'\1 \2\3 \3'
+
 # Transform an extracted symbol line into a proper C declaration
 lt_cv_sys_global_symbol_to_cdecl=3D"sed -n -e 's/^. .* \(.*\)$/extern in=
t \1;/p'"
=20
@@ -4654,31 +4358,15 @@
   lt_cv_sys_global_symbol_to_cdecl=3D"sed -n -e 's/^T .* \(.*\)$/extern =
int \1();/p' -e 's/^$symcode* .* \(.*\)$/extern char \1;/p'"
   lt_cv_sys_global_symbol_to_c_name_address=3D"sed -n -e 's/^: \([[^ ]]*=
\) $/  {\\\"\1\\\", (lt_ptr) 0},/p' -e 's/^$symcode* \([[^ ]]*\) \([[^ ]]=
*\)$/  {\"\2\", (lt_ptr) \&\2},/p'"
   ;;
-linux*)
-  if test "$host_cpu" =3D ia64; then
-    symcode=3D'[[ABCDGIRSTW]]'
-    lt_cv_sys_global_symbol_to_cdecl=3D"sed -n -e 's/^T .* \(.*\)$/exter=
n int \1();/p' -e 's/^$symcode* .* \(.*\)$/extern char \1;/p'"
-    lt_cv_sys_global_symbol_to_c_name_address=3D"sed -n -e 's/^: \([[^ ]=
]*\) $/  {\\\"\1\\\", (lt_ptr) 0},/p' -e 's/^$symcode* \([[^ ]]*\) \([[^ =
]]*\)$/  {\"\2\", (lt_ptr) \&\2},/p'"
-  fi
-  ;;
 irix* | nonstopux*)
   symcode=3D'[[BCDEGRST]]'
   ;;
 osf*)
   symcode=3D'[[BCDEGQRST]]'
   ;;
-solaris*)
+solaris* | sysv5*)
   symcode=3D'[[BDRT]]'
   ;;
-sco3.2v5*)
-  symcode=3D'[[DT]]'
-  ;;
-sysv4.2uw2*)
-  symcode=3D'[[DT]]'
-  ;;
-sysv5* | sco5v6* | unixware* | OpenUNIX*)
-  symcode=3D'[[ABDT]]'
-  ;;
 sysv4)
   symcode=3D'[[DFNSTU]]'
   ;;
@@ -4701,11 +4389,8 @@
 # Try without a prefix undercore, then with it.
 for ac_symprfx in "" "_"; do
=20
-  # Transform symcode, sympat, and symprfx into a raw symbol and a C sym=
bol.
-  symxfrm=3D"\\1 $ac_symprfx\\2 \\2"
-
   # Write the raw and C identifiers.
-  lt_cv_sys_global_symbol_pipe=3D"sed -n -e 's/^.*[[ 	]]\($symcode$symco=
de*\)[[ 	]][[ 	]]*$ac_symprfx$sympat$opt_cr$/$symxfrm/p'"
+  lt_cv_sys_global_symbol_pipe=3D"sed -n -e 's/^.*[[ 	]]\($symcode$symco=
de*\)[[ 	]][[ 	]]*\($ac_symprfx\)$sympat$opt_cr$/$symxfrm/p'"
=20
   # Check to see that the pipe works correctly.
   pipe_works=3Dno
@@ -4861,10 +4546,6 @@
       # DJGPP does not support shared libraries at all
       _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D
       ;;
-    interix3*)
-      # Interix 3.x gcc -fpic/-fPIC options generate broken code.
-      # Instead, we relocate shared libraries at runtime.
-      ;;
     sysv4*MP*)
       if test -d /usr/nec; then
 	_LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D-Kconform_pic
@@ -4873,7 +4554,7 @@
     hpux*)
       # PIC is the default for IA64 HP-UX and 64-bit HP-UX, but
       # not for PA HP-UX.
-      case $host_cpu in
+      case "$host_cpu" in
       hppa*64*|ia64*)
 	;;
       *)
@@ -4898,28 +4579,18 @@
 	;;
       chorus*)
 	case $cc_basename in
-	cxch68*)
+	cxch68)
 	  # Green Hills C++ Compiler
 	  # _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D"--no_auto_instantiati=
on -u __main -u __premain -u _abort -r $COOL_DIR/lib/libOrb.a $MVME_DIR/l=
ib/CC/libC.a $MVME_DIR/lib/classix/libcx.s.a"
 	  ;;
 	esac
 	;;
-       darwin*)
-         # PIC is the default on this platform
-         # Common symbols not allowed in MH_DYLIB files
-         case $cc_basename in
-           xlc*)
-           _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-qnocommon'
-           _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
-           ;;
-         esac
-       ;;
       dgux*)
 	case $cc_basename in
-	  ec++*)
+	  ec++)
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-KPIC'
 	    ;;
-	  ghcx*)
+	  ghcx)
 	    # Green Hills C++ Compiler
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-pic'
 	    ;;
@@ -4927,22 +4598,22 @@
 	    ;;
 	esac
 	;;
-      freebsd* | kfreebsd*-gnu | dragonfly*)
+      freebsd* | kfreebsd*-gnu)
 	# FreeBSD uses GNU C++
 	;;
       hpux9* | hpux10* | hpux11*)
 	case $cc_basename in
-	  CC*)
+	  CC)
 	    _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
-	    _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'${wl}-a ${wl}archive'
+	    _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D"${ac_cv_prog_cc_wl}-a=
 ${ac_cv_prog_cc_wl}archive"
 	    if test "$host_cpu" !=3D ia64; then
 	      _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'+Z'
 	    fi
 	    ;;
-	  aCC*)
+	  aCC)
 	    _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
-	    _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'${wl}-a ${wl}archive'
-	    case $host_cpu in
+	    _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D"${ac_cv_prog_cc_wl}-a=
 ${ac_cv_prog_cc_wl}archive"
+	    case "$host_cpu" in
 	    hppa*64*|ia64*)
 	      # +Z the default
 	      ;;
@@ -4955,13 +4626,9 @@
 	    ;;
 	esac
 	;;
-      interix*)
-	# This is c89, which is MS Visual C++ (no shared libs)
-	# Anyone wants to do a port?
-	;;
       irix5* | irix6* | nonstopux*)
 	case $cc_basename in
-	  CC*)
+	  CC)
 	    _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
 	    _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-non_shared'
 	    # CC pic flag -KPIC is the default.
@@ -4972,24 +4639,18 @@
 	;;
       linux*)
 	case $cc_basename in
-	  KCC*)
+	  KCC)
 	    # KAI C++ Compiler
 	    _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'--backend -Wl,'
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-fPIC'
 	    ;;
-	  icpc* | ecpc*)
+	  icpc)
 	    # Intel C++
 	    _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-KPIC'
 	    _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-static'
 	    ;;
-	  pgCC*)
-	    # Portland Group C++ compiler.
-	    _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
-	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-fpic'
-	    _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-Bstatic'
-	    ;;
-	  cxx*)
+	  cxx)
 	    # Compaq C++
 	    # Make sure the PIC flag is empty.  It appears that all Alpha
 	    # Linux and Compaq Tru64 Unix objects are PIC.
@@ -5006,7 +4667,7 @@
 	;;
       mvs*)
 	case $cc_basename in
-	  cxx*)
+	  cxx)
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-W c,exportall'
 	    ;;
 	  *)
@@ -5017,14 +4678,14 @@
 	;;
       osf3* | osf4* | osf5*)
 	case $cc_basename in
-	  KCC*)
+	  KCC)
 	    _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'--backend -Wl,'
 	    ;;
-	  RCC*)
+	  RCC)
 	    # Rational C++ 2.4.1
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-pic'
 	    ;;
-	  cxx*)
+	  cxx)
 	    # Digital/Compaq C++
 	    _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
 	    # Make sure the PIC flag is empty.  It appears that all Alpha
@@ -5038,15 +4699,24 @@
 	;;
       psos*)
 	;;
+      sco*)
+	case $cc_basename in
+	  CC)
+	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-fPIC'
+	    ;;
+	  *)
+	    ;;
+	esac
+	;;
       solaris*)
 	case $cc_basename in
-	  CC*)
+	  CC)
 	    # Sun C++ 4.2, 5.x and Centerline C++
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-KPIC'
 	    _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-Bstatic'
 	    _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Qoption ld '
 	    ;;
-	  gcx*)
+	  gcx)
 	    # Green Hills C++ Compiler
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-PIC'
 	    ;;
@@ -5056,12 +4726,12 @@
 	;;
       sunos4*)
 	case $cc_basename in
-	  CC*)
+	  CC)
 	    # Sun C++ 4.x
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-pic'
 	    _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-Bstatic'
 	    ;;
-	  lcc*)
+	  lcc)
 	    # Lucid
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-pic'
 	    ;;
@@ -5071,7 +4741,7 @@
 	;;
       tandem*)
 	case $cc_basename in
-	  NCC*)
+	  NCC)
 	    # NonStop-UX NCC 3.20
 	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-KPIC'
 	    ;;
@@ -5079,14 +4749,7 @@
 	    ;;
 	esac
 	;;
-      sysv5* | unixware* | sco3.2v5* | sco5v6* | OpenUNIX*)
-	case $cc_basename in
-	  CC*)
-	    _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
-	    _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-KPIC'
-	    _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-Bstatic'
-	    ;;
-	esac
+      unixware*)
 	;;
       vxworks*)
 	;;
@@ -5133,11 +4796,6 @@
       _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-fno-common'
       ;;
=20
-    interix3*)
-      # Interix 3.x gcc -fpic/-fPIC options generate broken code.
-      # Instead, we relocate shared libraries at runtime.
-      ;;
-
     msdosdjgpp*)
       # Just because we use GCC doesn't mean we suddenly get shared libr=
aries
       # on systems that don't support them.
@@ -5154,7 +4812,7 @@
     hpux*)
       # PIC is the default for IA64 HP-UX and 64-bit HP-UX, but
       # not for PA HP-UX.
-      case $host_cpu in
+      case "$host_cpu" in
       hppa*64*|ia64*)
 	# +Z the default
 	;;
@@ -5180,16 +4838,6 @@
 	_LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-bnso -bI:/lib/syscalls.e=
xp'
       fi
       ;;
-      darwin*)
-        # PIC is the default on this platform
-        # Common symbols not allowed in MH_DYLIB files
-       case $cc_basename in
-         xlc*)
-         _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-qnocommon'
-         _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
-         ;;
-       esac
-       ;;
=20
     mingw* | pw32* | os2*)
       # This hack is so that the source file can tell whether it is bein=
g
@@ -5201,7 +4849,7 @@
       _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
       # PIC is the default for IA64 HP-UX and 64-bit HP-UX, but
       # not for PA HP-UX.
-      case $host_cpu in
+      case "$host_cpu" in
       hppa*64*|ia64*)
 	# +Z the default
 	;;
@@ -5225,19 +4873,12 @@
       ;;
=20
     linux*)
-      case $cc_basename in
+      case $CC in
       icc* | ecc*)
 	_LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
 	_LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-KPIC'
 	_LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-static'
         ;;
-      pgcc* | pgf77* | pgf90* | pgf95*)
-        # Portland Group compilers (*not* the Pentium gcc compiler,
-	# which looks to be a dead project)
-	_LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
-	_LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-fpic'
-	_LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-Bstatic'
-        ;;
       ccc*)
         _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
         # All Alpha code is PIC.
@@ -5252,15 +4893,15 @@
       _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-non_shared'
       ;;
=20
+    sco3.2v5*)
+      _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-Kpic'
+      _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-dn'
+      ;;
+
     solaris*)
+      _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
       _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-KPIC'
       _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-Bstatic'
-      case $cc_basename in
-      f77* | f90* | f95*)
-	_LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Qoption ld ';;
-      *)
-	_LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,';;
-      esac
       ;;
=20
     sunos4*)
@@ -5269,7 +4910,7 @@
       _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-Bstatic'
       ;;
=20
-    sysv4 | sysv4.2uw2* | sysv4.3*)
+    sysv4 | sysv4.2uw2* | sysv4.3* | sysv5*)
       _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
       _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-KPIC'
       _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-Bstatic'
@@ -5282,17 +4923,6 @@
       fi
       ;;
=20
-    sysv5* | unixware* | sco3.2v5* | sco5v6* | OpenUNIX*)
-      _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
-      _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-KPIC'
-      _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-Bstatic'
-      ;;
-
-    unicos*)
-      _LT_AC_TAGVAR(lt_prog_compiler_wl, $1)=3D'-Wl,'
-      _LT_AC_TAGVAR(lt_prog_compiler_can_build_shared, $1)=3Dno
-      ;;
-
     uts4*)
       _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D'-pic'
       _LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D'-Bstatic'
@@ -5320,7 +4950,7 @@
     [_LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D
      _LT_AC_TAGVAR(lt_prog_compiler_can_build_shared, $1)=3Dno])
 fi
-case $host_os in
+case "$host_os" in
   # For platforms which do not support PIC, -DPIC is meaningless:
   *djgpp*)
     _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D
@@ -5329,16 +4959,6 @@
     _LT_AC_TAGVAR(lt_prog_compiler_pic, $1)=3D"$_LT_AC_TAGVAR(lt_prog_co=
mpiler_pic, $1)ifelse([$1],[],[ -DPIC],[ifelse([$1],[CXX],[ -DPIC],[])])"
     ;;
 esac
-
-#
-# Check to make sure the static flag actually works.
-#
-wl=3D$_LT_AC_TAGVAR(lt_prog_compiler_wl, $1) eval lt_tmp_static_flag=3D\=
"$_LT_AC_TAGVAR(lt_prog_compiler_static, $1)\"
-AC_LIBTOOL_LINKER_OPTION([if $compiler static flag $lt_tmp_static_flag w=
orks],
-  _LT_AC_TAGVAR(lt_prog_compiler_static_works, $1),
-  $lt_tmp_static_flag,
-  [],
-  [_LT_AC_TAGVAR(lt_prog_compiler_static, $1)=3D])
 ])
=20
=20
@@ -5363,11 +4983,8 @@
     _LT_AC_TAGVAR(export_symbols_cmds, $1)=3D"$ltdll_cmds"
   ;;
   cygwin* | mingw*)
-    _LT_AC_TAGVAR(export_symbols_cmds, $1)=3D'$NM $libobjs $convenience =
| $global_symbol_pipe | $SED -e '\''/^[[BCDGRS]] /s/.* \([[^ ]]*\)/\1 DAT=
A/;/^.* __nm__/s/^.* __nm__\([[^ ]]*\) [[^ ]]*/\1 DATA/;/^I /d;/^[[AITW]]=
 /s/.* //'\'' | sort | uniq > $export_symbols'
+    _LT_AC_TAGVAR(export_symbols_cmds, $1)=3D'$NM $libobjs $convenience =
| $global_symbol_pipe | $SED -e '\''/^[[BCDGS]] /s/.* \([[^ ]]*\)/\1 DATA=
/'\'' | $SED -e '\''/^[[AITW]] /s/.* //'\'' | sort | uniq > $export_symbo=
ls'
   ;;
-  kfreebsd*-gnu)
-    _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dno
-  ;;
   linux*)
     _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dno
   ;;
@@ -5412,8 +5029,7 @@
   # rely on this symbol name, it's probably fine to never include it in
   # preloaded symbol tables.
   extract_expsyms_cmds=3D
-  # Just being paranoid about ensuring that cc_basename is set.
-  _LT_CC_BASENAME([$compiler])
+
   case $host_os in
   cygwin* | mingw* | pw32*)
     # FIXME: the MSVC++ port hasn't been tested in a loooong time
@@ -5423,10 +5039,6 @@
       with_gnu_ld=3Dno
     fi
     ;;
-  interix*)
-    # we just hope/assume this is gcc and not c89 (=3D MSVC++)
-    with_gnu_ld=3Dyes
-    ;;
   openbsd*)
     with_gnu_ld=3Dno
     ;;
@@ -5437,27 +5049,6 @@
     # If archive_cmds runs LD, not CC, wlarc should be empty
     wlarc=3D'${wl}'
=20
-    # Set some defaults for GNU ld with shared library support. These
-    # are reset later if shared libraries are not supported. Putting the=
m
-    # here allows them to be overridden if necessary.
-    runpath_var=3DLD_RUN_PATH
-    _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}--rpath ${wl}$l=
ibdir'
-    _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}--export-dynamic=
'
-    # ancient GNU ld didn't support --whole-archive et. al.
-    if $LD --help 2>&1 | grep 'no-whole-archive' > /dev/null; then
-	_LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D"$wlarc"'--whole-archive$c=
onvenience '"$wlarc"'--no-whole-archive'
-      else
-  	_LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D
-    fi
-    supports_anon_versioning=3Dno
-    case `$LD -v 2>/dev/null` in
-      *\ [[01]].* | *\ 2.[[0-9]].* | *\ 2.10.*) ;; # catch versions < 2.=
11
-      *\ 2.11.93.0.2\ *) supports_anon_versioning=3Dyes ;; # RH7.3 ...
-      *\ 2.11.92.0.12\ *) supports_anon_versioning=3Dyes ;; # Mandrake 8=
.2 ...
-      *\ 2.11.*) ;; # other 2.11 versions
-      *) supports_anon_versioning=3Dyes ;;
-    esac
-
     # See if GNU ld supports shared libraries.
     case $host_os in
     aix3* | aix4* | aix5*)
@@ -5508,10 +5099,10 @@
       _LT_AC_TAGVAR(allow_undefined_flag, $1)=3Dunsupported
       _LT_AC_TAGVAR(always_export_symbols, $1)=3Dno
       _LT_AC_TAGVAR(enable_shared_with_static_runtimes, $1)=3Dyes
-      _LT_AC_TAGVAR(export_symbols_cmds, $1)=3D'$NM $libobjs $convenienc=
e | $global_symbol_pipe | $SED -e '\''/^[[BCDGRS]] /s/.* \([[^ ]]*\)/\1 D=
ATA/'\'' | $SED -e '\''/^[[AITW]] /s/.* //'\'' | sort | uniq > $export_sy=
mbols'
+      _LT_AC_TAGVAR(export_symbols_cmds, $1)=3D'$NM $libobjs $convenienc=
e | $global_symbol_pipe | $SED -e '\''/^[[BCDGS]] /s/.* \([[^ ]]*\)/\1 DA=
TA/'\'' | $SED -e '\''/^[[AITW]] /s/.* //'\'' | sort | uniq > $export_sym=
bols'
=20
       if $LD --help 2>&1 | grep 'auto-import' > /dev/null; then
-        _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $libobjs $deplibs=
 $compiler_flags -o $output_objdir/$soname ${wl}--enable-auto-image-base =
-Xlinker --out-implib -Xlinker $lib'
+        _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $libobjs $deplibs=
 $compiler_flags -o $output_objdir/$soname ${wl}--image-base=3D0x10000000=
 ${wl}--out-implib,$lib'
 	# If the export-symbols file already is a .def file (1st line
 	# is EXPORTS), use it as is; otherwise, prepend...
 	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'if test "x`$SED 1q $export_sy=
mbols`" =3D xEXPORTS; then
@@ -5520,59 +5111,12 @@
 	  echo EXPORTS > $output_objdir/$soname.def;
 	  cat $export_symbols >> $output_objdir/$soname.def;
 	fi~
-	$CC -shared $output_objdir/$soname.def $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--enable-auto-image-base -Xlinker --out-=
implib -Xlinker $lib'
+	$CC -shared $output_objdir/$soname.def $libobjs $deplibs $compiler_flag=
s -o $output_objdir/$soname ${wl}--image-base=3D0x10000000  ${wl}--out-im=
plib,$lib'
       else
-	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
+	ld_shlibs=3Dno
       fi
       ;;
=20
-    interix3*)
-      _LT_AC_TAGVAR(hardcode_direct, $1)=3Dno
-      _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
-      _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-rpath,$libdi=
r'
-      _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-E'
-      # Hack: On Interix 3.x, we cannot compile PIC because of a broken =
gcc.
-      # Instead, shared libraries are loaded at an image base (0x1000000=
0 by
-      # default) and relocated if they conflict, which is a slow very me=
mory
-      # consuming and fragmenting process.  To avoid this, we pick a ran=
dom,
-      # 256 KiB-aligned image base between 0x50000000 and 0x6FFC0000 at =
link
-      # time.  Moving up from 0x10000000 also allows more sbrk(2) space.
-      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $pic_flag $libobjs =
$deplibs $compiler_flags ${wl}-h,$soname ${wl}--image-base,`expr ${RANDOM=
-$$} % 4096 / 2 \* 262144 + 1342177280` -o $lib'
-      _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed "s,^,_," $export_sym=
bols >$output_objdir/$soname.expsym~$CC -shared $pic_flag $libobjs $depli=
bs $compiler_flags ${wl}-h,$soname ${wl}--retain-symbols-file,$output_obj=
dir/$soname.expsym ${wl}--image-base,`expr ${RANDOM-$$} % 4096 / 2 \* 262=
144 + 1342177280` -o $lib'
-      ;;
-
-    linux*)
-      if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null=
; then
-	tmp_addflag=3D
-	case $cc_basename,$host_cpu in
-	pgcc*)				# Portland Group C compiler
-	  _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'${wl}--whole-archive`fo=
r conv in $convenience\"\"; do test  -n \"$conv\" && new_convenience=3D\"=
$new_convenience,$conv\"; done; $echo \"$new_convenience\"` ${wl}--no-who=
le-archive'
-	  tmp_addflag=3D' $pic_flag'
-	  ;;
-	pgf77* | pgf90* | pgf95*)	# Portland Group f77 and f90 compilers
-	  _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'${wl}--whole-archive`fo=
r conv in $convenience\"\"; do test  -n \"$conv\" && new_convenience=3D\"=
$new_convenience,$conv\"; done; $echo \"$new_convenience\"` ${wl}--no-who=
le-archive'
-	  tmp_addflag=3D' $pic_flag -Mnomain' ;;
-	ecc*,ia64* | icc*,ia64*)		# Intel C compiler on ia64
-	  tmp_addflag=3D' -i_dynamic' ;;
-	efc*,ia64* | ifort*,ia64*)	# Intel Fortran compiler on ia64
-	  tmp_addflag=3D' -i_dynamic -nofor_main' ;;
-	ifc* | ifort*)			# Intel Fortran compiler
-	  tmp_addflag=3D' -nofor_main' ;;
-	esac
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared'"$tmp_addflag"' $libobjs=
 $deplibs $compiler_flags ${wl}-soname $wl$soname -o $lib'
-
-	if test $supports_anon_versioning =3D yes; then
-	  _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$echo "{ global:" > $output=
_objdir/$libname.ver~
-  cat $export_symbols | sed -e "s/\(.*\)/\1;/" >> $output_objdir/$libnam=
e.ver~
-  $echo "local: *; };" >> $output_objdir/$libname.ver~
-	  $CC -shared'"$tmp_addflag"' $libobjs $deplibs $compiler_flags ${wl}-s=
oname $wl$soname ${wl}-version-script ${wl}$output_objdir/$libname.ver -o=
 $lib'
-	fi
-	_LT_AC_TAGVAR(link_all_deplibs, $1)=3Dno
-      else
-	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
-      fi
-      ;;
-
     netbsd* | netbsdelf*-gnu | knetbsd*-gnu)
       if echo __ELF__ | $CC -E - | grep __ELF__ >/dev/null; then
 	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -Bshareable $libobjs $deplibs $l=
inker_flags -o $lib'
@@ -5583,7 +5127,7 @@
       fi
       ;;
=20
-    solaris*)
+    solaris* | sysv5*)
       if $LD -v 2>&1 | grep 'BFD 2\.8' > /dev/null; then
 	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
 	cat <<EOF 1>&2
@@ -5604,33 +5148,6 @@
       fi
       ;;
=20
-    sysv5* | sco3.2v5* | sco5v6* | unixware* | OpenUNIX*)
-      case `$LD -v 2>&1` in
-        *\ [[01]].* | *\ 2.[[0-9]].* | *\ 2.1[[0-5]].*)=20
-	_LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
-	cat <<_LT_EOF 1>&2
-
-*** Warning: Releases of the GNU linker prior to 2.16.91.0.3 can not
-*** reliably create shared libraries on SCO systems.  Therefore, libtool
-*** is disabling shared libraries support.  We urge you to upgrade GNU
-*** binutils to release 2.16.91.0.3 or newer.  Another option is to modi=
fy
-*** your PATH or compiler configuration so that the native linker is
-*** used, and then restart.
-
-_LT_EOF
-	;;
-	*)
-	  if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null; t=
hen
-	    _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'`test -z "$SCOABSPA=
TH" && echo ${wl}-rpath,$libdir`'
-	    _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $libobjs $deplibs $c=
ompiler_flags ${wl}-soname,\${SCOABSPATH:+${install_libdir}/}$soname -o $=
lib'
-	    _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared $libobjs $dep=
libs $compiler_flags ${wl}-soname,\${SCOABSPATH:+${install_libdir}/}$sona=
me,-retain-symbols-file,$export_symbols -o $lib'
-	  else
-	    _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
-	  fi
-	;;
-      esac
-      ;;
-
     sunos4*)
       _LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -assert pure-text -Bshareab=
le -o $lib $libobjs $deplibs $linker_flags'
       wlarc=3D
@@ -5638,6 +5155,32 @@
       _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
       ;;
=20
+  linux*)
+    if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null; =
then
+        tmp_archive_cmds=3D'$CC -shared $libobjs $deplibs $compiler_flag=
s ${wl}-soname $wl$soname -o $lib'
+	_LT_AC_TAGVAR(archive_cmds, $1)=3D"$tmp_archive_cmds"
+      supports_anon_versioning=3Dno
+      case `$LD -v 2>/dev/null` in
+        *\ [01].* | *\ 2.[[0-9]].* | *\ 2.10.*) ;; # catch versions < 2.=
11
+        *\ 2.11.93.0.2\ *) supports_anon_versioning=3Dyes ;; # RH7.3 ...
+        *\ 2.11.92.0.12\ *) supports_anon_versioning=3Dyes ;; # Mandrake=
 8.2 ...
+        *\ 2.11.*) ;; # other 2.11 versions
+        *) supports_anon_versioning=3Dyes ;;
+      esac
+      if test $supports_anon_versioning =3D yes; then
+        _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$echo "{ global:" > $o=
utput_objdir/$libname.ver~
+cat $export_symbols | sed -e "s/\(.*\)/\1;/" >> $output_objdir/$libname.=
ver~
+$echo "local: *; };" >> $output_objdir/$libname.ver~
+        $CC -shared $libobjs $deplibs $compiler_flags ${wl}-soname $wl$s=
oname ${wl}-version-script ${wl}$output_objdir/$libname.ver -o $lib'
+      else
+        _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"$tmp_archive_cmds"
+      fi
+      _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dno
+    else
+      _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
+    fi
+    ;;
+
     *)
       if $LD --help 2>&1 | grep ': supported targets:.* elf' > /dev/null=
; then
 	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $libobjs $deplibs $compi=
ler_flags ${wl}-soname $wl$soname -o $lib'
@@ -5648,11 +5191,16 @@
       ;;
     esac
=20
-    if test "$_LT_AC_TAGVAR(ld_shlibs, $1)" =3D no; then
-      runpath_var=3D
-      _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D
-      _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D
-      _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D
+    if test "$_LT_AC_TAGVAR(ld_shlibs, $1)" =3D yes; then
+      runpath_var=3DLD_RUN_PATH
+      _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}--rpath ${wl}=
$libdir'
+      _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}--export-dynam=
ic'
+      # ancient GNU ld didn't support --whole-archive et. al.
+      if $LD --help 2>&1 | grep 'no-whole-archive' > /dev/null; then
+ 	_LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D"$wlarc"'--whole-archive$=
convenience '"$wlarc"'--no-whole-archive'
+      else
+  	_LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D
+      fi
     fi
   else
     # PORTME fill in a description of your system's linker (not GNU ld)
@@ -5664,7 +5212,7 @@
       # Note: this linker hardcodes the directories in LIBPATH if there
       # are no directories specified by -L.
       _LT_AC_TAGVAR(hardcode_minus_L, $1)=3Dyes
-      if test "$GCC" =3D yes && test -z "$lt_prog_compiler_static"; then
+      if test "$GCC" =3D yes && test -z "$link_static_flag"; then
 	# Neither direct hardcoding nor static linking is supported with a
 	# broken collect2.
 	_LT_AC_TAGVAR(hardcode_direct, $1)=3Dunsupported
@@ -5698,7 +5246,6 @@
   	    break
   	  fi
 	  done
-	  ;;
 	esac
=20
 	exp_sym_flag=3D'-bexport'
@@ -5717,7 +5264,7 @@
       _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dyes
=20
       if test "$GCC" =3D yes; then
-	case $host_os in aix4.[[012]]|aix4.[[012]].*)
+	case $host_os in aix4.[012]|aix4.[012].*)
 	# We only want to do this on AIX 4.2 and lower, the check
 	# below for broken collect2 doesn't work under 4.3+
 	  collect2name=3D`${CC} -print-prog-name=3Dcollect2`
@@ -5736,12 +5283,8 @@
   	  _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'-L$libdir'
   	  _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D
 	  fi
-	  ;;
 	esac
 	shared_flag=3D'-shared'
-	if test "$aix_use_runtimelinking" =3D yes; then
-	  shared_flag=3D"$shared_flag "'${wl}-G'
-	fi
       else
 	# not using gcc
 	if test "$host_cpu" =3D ia64; then
@@ -5749,11 +5292,11 @@
   	# chokes on -Wl,-G. The following line is correct:
 	  shared_flag=3D'-G'
 	else
-	  if test "$aix_use_runtimelinking" =3D yes; then
+  	if test "$aix_use_runtimelinking" =3D yes; then
 	    shared_flag=3D'${wl}-G'
 	  else
 	    shared_flag=3D'${wl}-bM:SRE'
-	  fi
+  	fi
 	fi
       fi
=20
@@ -5767,12 +5310,12 @@
        # Determine the default libpath from the value encoded in an empt=
y executable.
        _LT_AC_SYS_LIBPATH_AIX
        _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-blibpath:$l=
ibdir:'"$aix_libpath"
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC"' -o $output_objdir/$son=
ame $libobjs $deplibs '"\${wl}$no_entry_flag"' $compiler_flags `if test "=
x${allow_undefined_flag}" !=3D "x"; then echo "${wl}${allow_undefined_fla=
g}"; else :; fi` '"\${wl}$exp_sym_flag:\$export_symbols $shared_flag"
+	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC"' -o $output_objdir/$son=
ame $libobjs $deplibs $compiler_flags `if test "x${allow_undefined_flag}"=
 !=3D "x"; then echo "${wl}${allow_undefined_flag}"; else :; fi` '"\${wl}=
$no_entry_flag \${wl}$exp_sym_flag:\$export_symbols $shared_flag"
        else
 	if test "$host_cpu" =3D ia64; then
 	  _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-R $libdir:/usr/=
lib:/lib'
 	  _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D"-z nodefs"
-	  _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC $shared_flag"' -o $out=
put_objdir/$soname $libobjs $deplibs '"\${wl}$no_entry_flag"' $compiler_f=
lags ${wl}${allow_undefined_flag} '"\${wl}$exp_sym_flag:\$export_symbols"
+	  _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC $shared_flag"' -o $out=
put_objdir/$soname $libobjs $deplibs $compiler_flags ${wl}${allow_undefin=
ed_flag} '"\${wl}$no_entry_flag \${wl}$exp_sym_flag:\$export_symbols"
 	else
 	 # Determine the default libpath from the value encoded in an empty exe=
cutable.
 	 _LT_AC_SYS_LIBPATH_AIX
@@ -5781,11 +5324,13 @@
 	  # -berok will link without error, but may produce a broken library.
 	  _LT_AC_TAGVAR(no_undefined_flag, $1)=3D' ${wl}-bernotok'
 	  _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D' ${wl}-berok'
+	  # -bexpall does not export symbols beginning with underscore (_)
+	  _LT_AC_TAGVAR(always_export_symbols, $1)=3Dyes
 	  # Exported symbols can be pulled into shared objects from archives
-	  _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'$convenience'
+	  _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D' '
 	  _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dyes
-	  # This is similar to how AIX traditionally builds its shared librarie=
s.
-	  _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC $shared_flag"' -o $out=
put_objdir/$soname $libobjs $deplibs ${wl}-bnoentry $compiler_flags ${wl}=
-bE:$export_symbols${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$=
libname$release.a $output_objdir/$soname'
+	  # This is similar to how AIX traditionally builds it's shared librari=
es.
+	  _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D"\$CC $shared_flag"' -o $out=
put_objdir/$soname $libobjs $deplibs $compiler_flags ${wl}-bE:$export_sym=
bols ${wl}-bnoentry${allow_undefined_flag}~$AR $AR_FLAGS $output_objdir/$=
libname$release.a $output_objdir/$soname'
 	fi
       fi
       ;;
@@ -5798,7 +5343,7 @@
       _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
       ;;
=20
-    bsdi[[45]]*)
+    bsdi4*)
       _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D-rdynamic
       ;;
=20
@@ -5819,57 +5364,57 @@
       _LT_AC_TAGVAR(old_archive_From_new_cmds, $1)=3D'true'
       # FIXME: Should let the user specify the lib program.
       _LT_AC_TAGVAR(old_archive_cmds, $1)=3D'lib /OUT:$oldlib$oldobjs$ol=
d_deplibs'
-      _LT_AC_TAGVAR(fix_srcfile_path, $1)=3D'`cygpath -w "$srcfile"`'
+      fix_srcfile_path=3D'`cygpath -w "$srcfile"`'
       _LT_AC_TAGVAR(enable_shared_with_static_runtimes, $1)=3Dyes
       ;;
=20
     darwin* | rhapsody*)
-      case $host_os in
-        rhapsody* | darwin1.[[012]])
-         _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'${wl}-undefined ${wl=
}suppress'
-         ;;
-       *) # Darwin 1.3 on
-         if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
-           _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'${wl}-flat_namespa=
ce ${wl}-undefined ${wl}suppress'
-         else
-           case ${MACOSX_DEPLOYMENT_TARGET} in
-             10.[[012]])
-               _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'${wl}-flat_nam=
espace ${wl}-undefined ${wl}suppress'
-               ;;
-             10.*)
-               _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'${wl}-undefine=
d ${wl}dynamic_lookup'
-               ;;
-           esac
-         fi
-         ;;
-      esac
+    if test "$GXX" =3D yes ; then
       _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
+      case "$host_os" in
+      rhapsody* | darwin1.[[012]])
+	_LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-undefined suppress'
+	;;
+      *) # Darwin 1.3 on
+      if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
+      	_LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-flat_namespace -undef=
ined suppress'
+      else
+        case ${MACOSX_DEPLOYMENT_TARGET} in
+          10.[[012]])
+            _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-flat_namespace -=
undefined suppress'
+            ;;
+          10.*)
+            _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'-undefined dynami=
c_lookup'
+            ;;
+        esac
+      fi
+	;;
+      esac
+    	lt_int_apple_cc_single_mod=3Dno
+    	output_verbose_link_cmd=3D'echo'
+    	if $CC -dumpspecs 2>&1 | grep 'single_module' >/dev/null ; then
+    	  lt_int_apple_cc_single_mod=3Dyes
+    	fi
+    	if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+    	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -dynamiclib -single_module=
 $allow_undefined_flag -o $lib $libobjs $deplibs $compiler_flags -install=
_name $rpath/$soname $verstring'
+    	else
+        _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -r ${wl}-bind_at_load -ke=
ep_private_externs -nostdlib -o ${lib}-master.o $libobjs~$CC -dynamiclib =
$allow_undefined_flag -o $lib ${lib}-master.o $deplibs $compiler_flags -i=
nstall_name $rpath/$soname $verstring'
+      fi
+      _LT_AC_TAGVAR(module_cmds, $1)=3D'$CC ${wl}-bind_at_load $allow_un=
defined_flag -o $lib -bundle $libobjs $deplibs$compiler_flags'
+      # Don't fix this by using the ld -exported_symbols_list flag, it d=
oesn't exist in older darwin ld's
+        if test "X$lt_int_apple_cc_single_mod" =3D Xyes ; then
+          _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e =
"s,^[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${l=
ibname}-symbols.expsym~$CC -dynamiclib -single_module $allow_undefined_fl=
ag -o $lib $libobjs $deplibs $compiler_flags -install_name $rpath/$soname=
 $verstring~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
+        else
+          _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e =
"s,^[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${l=
ibname}-symbols.expsym~$CC -r ${wl}-bind_at_load -keep_private_externs -n=
ostdlib -o ${lib}-master.o $libobjs~$CC -dynamiclib $allow_undefined_flag=
 -o $lib ${lib}-master.o $deplibs $compiler_flags -install_name $rpath/$s=
oname $verstring~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib=
}'
+        fi
+          _LT_AC_TAGVAR(module_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "=
s,^[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${li=
bname}-symbols.expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs=
 $deplibs$compiler_flags~nmedit -s $output_objdir/${libname}-symbols.exps=
ym ${lib}'
       _LT_AC_TAGVAR(hardcode_direct, $1)=3Dno
       _LT_AC_TAGVAR(hardcode_automatic, $1)=3Dyes
       _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dunsupported
-      _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D''
+      _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'-all_load $convenien=
ce'
       _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dyes
-    if test "$GCC" =3D yes ; then
-    	output_verbose_link_cmd=3D'echo'
-        _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -dynamiclib $allow_undefi=
ned_flag -o $lib $libobjs $deplibs $compiler_flags -install_name $rpath/$=
soname $verstring'
-      _LT_AC_TAGVAR(module_cmds, $1)=3D'$CC $allow_undefined_flag -o $li=
b -bundle $libobjs $deplibs$compiler_flags'
-      # Don't fix this by using the ld -exported_symbols_list flag, it d=
oesn't exist in older darwin lds
-      _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "s,^=
[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libna=
me}-symbols.expsym~$CC -dynamiclib $allow_undefined_flag -o $lib $libobjs=
 $deplibs $compiler_flags -install_name $rpath/$soname $verstring~nmedit =
-s $output_objdir/${libname}-symbols.expsym ${lib}'
-      _LT_AC_TAGVAR(module_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "s,^[=
    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${libnam=
e}-symbols.expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs $de=
plibs$compiler_flags~nmedit -s $output_objdir/${libname}-symbols.expsym $=
{lib}'
     else
-      case $cc_basename in
-        xlc*)
-         output_verbose_link_cmd=3D'echo'
-         _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -qmkshrobj $allow_undefi=
ned_flag -o $lib $libobjs $deplibs $compiler_flags ${wl}-install_name ${w=
l}`echo $rpath/$soname` $verstring'
-         _LT_AC_TAGVAR(module_cmds, $1)=3D'$CC $allow_undefined_flag -o =
$lib -bundle $libobjs $deplibs$compiler_flags'
-          # Don't fix this by using the ld -exported_symbols_list flag, =
it doesn't exist in older darwin lds
-         _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "=
s,^[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${li=
bname}-symbols.expsym~$CC -qmkshrobj $allow_undefined_flag -o $lib $libob=
js $deplibs $compiler_flags ${wl}-install_name ${wl}$rpath/$soname $verst=
ring~nmedit -s $output_objdir/${libname}-symbols.expsym ${lib}'
-          _LT_AC_TAGVAR(module_expsym_cmds, $1)=3D'sed -e "s,#.*,," -e "=
s,^[    ]*,," -e "s,^\(..*\),_&," < $export_symbols > $output_objdir/${li=
bname}-symbols.expsym~$CC $allow_undefined_flag  -o $lib -bundle $libobjs=
 $deplibs$compiler_flags~nmedit -s $output_objdir/${libname}-symbols.exps=
ym ${lib}'
-          ;;
-       *)
-         _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
-          ;;
-      esac
+      _LT_AC_TAGVAR(ld_shlibs, $1)=3Dno
     fi
       ;;
=20
@@ -5903,21 +5448,12 @@
       ;;
=20
     # FreeBSD 3 and greater uses gcc -shared to do shared libraries.
-    freebsd* | dragonfly*)
+    freebsd* | kfreebsd*-gnu)
       _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -o $lib $libobjs $d=
eplibs $compiler_flags'
       _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'-R$libdir'
       _LT_AC_TAGVAR(hardcode_direct, $1)=3Dyes
       _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
       ;;
-     =20
-    # GNU/kFreeBSD uses gcc -shared to do shared libraries.
-    kfreebsd*-gnu)
-      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -o $lib $libobjs $d=
eplibs $compiler_flags'
-      _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'-R$libdir'
-      _LT_AC_TAGVAR(hardcode_direct, $1)=3Dyes
-      _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
-      _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dno
-      ;;
=20
     hpux9*)
       if test "$GCC" =3D yes; then
@@ -5935,62 +5471,47 @@
       _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-E'
       ;;
=20
-    hpux10*)
+    hpux10* | hpux11*)
       if test "$GCC" =3D yes -a "$with_gnu_ld" =3D no; then
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -fPIC ${wl}+h ${wl}$sona=
me ${wl}+b ${wl}$install_libdir -o $lib $libobjs $deplibs $compiler_flags=
'
-      else
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -b +h $soname +b $install_libdir=
 -o $lib $libobjs $deplibs $linker_flags'
-      fi
-      if test "$with_gnu_ld" =3D no; then
-	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}+b ${wl}$libdir'
-	_LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
-
-	_LT_AC_TAGVAR(hardcode_direct, $1)=3Dyes
-	_LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-E'
-
-	# hardcode_minus_L: Not really in the search PATH,
-	# but as the default location of the library.
-	_LT_AC_TAGVAR(hardcode_minus_L, $1)=3Dyes
-      fi
-      ;;
-
-    hpux11*)
-      if test "$GCC" =3D yes -a "$with_gnu_ld" =3D no; then
-	case $host_cpu in
-	hppa*64*)
+	case "$host_cpu" in
+	hppa*64*|ia64*)
 	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared ${wl}+h ${wl}$soname -=
o $lib $libobjs $deplibs $compiler_flags'
 	  ;;
-	ia64*)
-	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared ${wl}+h ${wl}$soname $=
{wl}+nodefaultrpath -o $lib $libobjs $deplibs $compiler_flags'
-	  ;;
 	*)
 	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared -fPIC ${wl}+h ${wl}$so=
name ${wl}+b ${wl}$install_libdir -o $lib $libobjs $deplibs $compiler_fla=
gs'
 	  ;;
 	esac
       else
-	case $host_cpu in
-	hppa*64*)
-	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -b ${wl}+h ${wl}$soname -o $li=
b $libobjs $deplibs $compiler_flags'
+	case "$host_cpu" in
+	hppa*64*|ia64*)
+	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -b +h $soname -o $lib $libobjs=
 $deplibs $linker_flags'
 	  ;;
-	ia64*)
-	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+=
nodefaultrpath -o $lib $libobjs $deplibs $compiler_flags'
-	  ;;
 	*)
-	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -b ${wl}+h ${wl}$soname ${wl}+=
b ${wl}$install_libdir -o $lib $libobjs $deplibs $compiler_flags'
+	  _LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -b +h $soname +b $install_libd=
ir -o $lib $libobjs $deplibs $linker_flags'
 	  ;;
 	esac
       fi
       if test "$with_gnu_ld" =3D no; then
-	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}+b ${wl}$libdir'
-	_LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
-
-	case $host_cpu in
-	hppa*64*|ia64*)
+	case "$host_cpu" in
+	hppa*64*)
+	  _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}+b ${wl}$libdir'
 	  _LT_AC_TAGVAR(hardcode_libdir_flag_spec_ld, $1)=3D'+b $libdir'
+	  _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
 	  _LT_AC_TAGVAR(hardcode_direct, $1)=3Dno
 	  _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
 	  ;;
+	ia64*)
+	  _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'-L$libdir'
+	  _LT_AC_TAGVAR(hardcode_direct, $1)=3Dno
+	  _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
+
+	  # hardcode_minus_L: Not really in the search PATH,
+	  # but as the default location of the library.
+	  _LT_AC_TAGVAR(hardcode_minus_L, $1)=3Dyes
+	  ;;
 	*)
+	  _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}+b ${wl}$libdir'
+	  _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
 	  _LT_AC_TAGVAR(hardcode_direct, $1)=3Dyes
 	  _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-E'
=20
@@ -6038,7 +5559,6 @@
       _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
       if test -z "`echo __ELF__ | $CC -E - | grep __ELF__`" || test "$ho=
st_os-$host_cpu" =3D "openbsd2.8-powerpc"; then
 	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared $pic_flag -o $lib $libob=
js $deplibs $compiler_flags'
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared $pic_flag -o $lib=
 $libobjs $deplibs $compiler_flags ${wl}-retain-symbols-file,$export_symb=
ols'
 	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'${wl}-rpath,$libdir'
 	_LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-E'
       else
@@ -6084,7 +5604,7 @@
 	_LT_AC_TAGVAR(allow_undefined_flag, $1)=3D' -expect_unresolved \*'
 	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -shared${allow_undefined_flag} $=
libobjs $deplibs $linker_flags -msym -soname $soname `test -n "$verstring=
" && echo -set_version $verstring` -update_registry ${output_objdir}/so_l=
ocations -o $lib'
 	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'for i in `cat $export_symbols=
`; do printf "%s %s\\n" -exported_symbol "\$i" >> $lib.exp; done; echo "-=
hidden">> $lib.exp~
-	$LD -shared${allow_undefined_flag} -input $lib.exp $linker_flags $libob=
js $deplibs -soname $soname `test -n "$verstring" && echo -set_version $v=
erstring` -update_registry ${output_objdir}/so_locations -o $lib~$rm $lib=
.exp'
+	$LD -shared${allow_undefined_flag} -input $lib.exp $linker_flags $libob=
js $deplibs -soname $soname `test -n "$verstring" && echo -set_version $v=
erstring` -update_registry ${objdir}/so_locations -o $lib~$rm $lib.exp'
=20
 	# Both c and cxx compiler support -rpath directly
 	_LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'-rpath $libdir'
@@ -6092,15 +5612,21 @@
       _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D:
       ;;
=20
+    sco3.2v5*)
+      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -G -h $soname -o $lib $libo=
bjs $deplibs $linker_flags'
+      _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
+      _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-Bexport'
+      runpath_var=3DLD_RUN_PATH
+      hardcode_runpath_var=3Dyes
+      ;;
+
     solaris*)
       _LT_AC_TAGVAR(no_undefined_flag, $1)=3D' -z text'
       if test "$GCC" =3D yes; then
-	wlarc=3D'${wl}'
 	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared ${wl}-h ${wl}$soname -o =
$lib $libobjs $deplibs $compiler_flags'
 	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$echo "{ global:" > $lib.exp~=
cat $export_symbols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *=
; };" >> $lib.exp~
 	  $CC -shared ${wl}-M ${wl}$lib.exp ${wl}-h ${wl}$soname -o $lib $libob=
js $deplibs $compiler_flags~$rm $lib.exp'
       else
-	wlarc=3D''
 	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -G${allow_undefined_flag} -h $so=
name -o $lib $libobjs $deplibs $linker_flags'
 	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$echo "{ global:" > $lib.exp~=
cat $export_symbols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "local: *=
; };" >> $lib.exp~
   	$LD -G${allow_undefined_flag} -M $lib.exp -h $soname -o $lib $libobjs=
 $deplibs $linker_flags~$rm $lib.exp'
@@ -6109,18 +5635,8 @@
       _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
       case $host_os in
       solaris2.[[0-5]] | solaris2.[[0-5]].*) ;;
-      *)
- 	# The compiler driver will combine linker options so we
- 	# cannot just pass the convience library names through
- 	# without $wl, iff we do not link with $LD.
- 	# Luckily, gcc supports the same syntax we need for Sun Studio.
- 	# Supported since Solaris 2.6 (maybe 2.5.1?)
- 	case $wlarc in
- 	'')
- 	  _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'-z allextract$convenie=
nce -z defaultextract' ;;
- 	*)
- 	  _LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'${wl}-z ${wl}allextrac=
t`for conv in $convenience\"\"; do test -n \"$conv\" && new_convenience=3D=
\"$new_convenience,$conv\"; done; $echo \"$new_convenience\"` ${wl}-z ${w=
l}defaultextract' ;;
- 	esac ;;
+      *) # Supported since Solaris 2.6 (maybe 2.5.1?)
+	_LT_AC_TAGVAR(whole_archive_flag_spec, $1)=3D'-z allextract$convenience=
 -z defaultextract' ;;
       esac
       _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dyes
       ;;
@@ -6177,45 +5693,36 @@
       fi
       ;;
=20
-    sysv4*uw2* | sysv5OpenUNIX* | sysv5UnixWare7.[[01]].[[10]]* | unixwa=
re7*)
-      _LT_AC_TAGVAR(no_undefined_flag, $1)=3D'${wl}-z,text'
-      _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
+    sysv4.2uw2*)
+      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -G -o $lib $libobjs $deplib=
s $linker_flags'
+      _LT_AC_TAGVAR(hardcode_direct, $1)=3Dyes
+      _LT_AC_TAGVAR(hardcode_minus_L, $1)=3Dno
       _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
-      runpath_var=3D'LD_RUN_PATH'
+      hardcode_runpath_var=3Dyes
+      runpath_var=3DLD_RUN_PATH
+      ;;
=20
+   sysv5OpenUNIX8* | sysv5UnixWare7* |  sysv5uw[[78]]* | unixware7*)
+      _LT_AC_TAGVAR(no_undefined_flag, $1)=3D'${wl}-z ${wl}text'
       if test "$GCC" =3D yes; then
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared ${wl}-h,$soname -o $lib =
$libobjs $deplibs $compiler_flags'
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared ${wl}-Bexport:$ex=
port_symbols ${wl}-h,$soname -o $lib $libobjs $deplibs $compiler_flags'
+	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared ${wl}-h ${wl}$soname -o =
$lib $libobjs $deplibs $compiler_flags'
       else
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -G ${wl}-h,$soname -o $lib $libo=
bjs $deplibs $compiler_flags'
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -G ${wl}-Bexport:$export_=
symbols ${wl}-h,$soname -o $lib $libobjs $deplibs $compiler_flags'
+	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -G ${wl}-h ${wl}$soname -o $lib =
$libobjs $deplibs $compiler_flags'
       fi
+      runpath_var=3D'LD_RUN_PATH'
+      _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
       ;;
=20
-    sysv5* | sco3.2v5* | sco5v6*)
-      # Note: We can NOT use -z defs as we might desire, because we do n=
ot
-      # link with -lc, and that would cause any symbols used from libc t=
o
-      # always be unresolved, which means just about no library would
-      # ever link correctly.  If we're not using GNU ld we use -z text
-      # though, which does catch some bad symbols but isn't as heavy-han=
ded
-      # as -z defs.
-      _LT_AC_TAGVAR(no_undefined_flag, $1)=3D'${wl}-z,text'
-      _LT_AC_TAGVAR(allow_undefined_flag, $1)=3D'${wl}-z,nodefs'
-      _LT_AC_TAGVAR(archive_cmds_need_lc, $1)=3Dno
+    sysv5*)
+      _LT_AC_TAGVAR(no_undefined_flag, $1)=3D' -z text'
+      # $CC -shared without GNU ld will not create a library from C++
+      # object files and a static libstdc++, better avoid it by now
+      _LT_AC_TAGVAR(archive_cmds, $1)=3D'$LD -G${allow_undefined_flag} -=
h $soname -o $lib $libobjs $deplibs $linker_flags'
+      _LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$echo "{ global:" > $lib=
.exp~cat $export_symbols | $SED -e "s/\(.*\)/\1;/" >> $lib.exp~$echo "loc=
al: *; };" >> $lib.exp~
+  		$LD -G${allow_undefined_flag} -M $lib.exp -h $soname -o $lib $libobj=
s $deplibs $linker_flags~$rm $lib.exp'
+      _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D
       _LT_AC_TAGVAR(hardcode_shlibpath_var, $1)=3Dno
-      _LT_AC_TAGVAR(hardcode_libdir_flag_spec, $1)=3D'`test -z "$SCOABSP=
ATH" && echo ${wl}-R,$libdir`'
-      _LT_AC_TAGVAR(hardcode_libdir_separator, $1)=3D':'
-      _LT_AC_TAGVAR(link_all_deplibs, $1)=3Dyes
-      _LT_AC_TAGVAR(export_dynamic_flag_spec, $1)=3D'${wl}-Bexport'
       runpath_var=3D'LD_RUN_PATH'
-
-      if test "$GCC" =3D yes; then
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -shared ${wl}-h,\${SCOABSPATH:+$=
{install_libdir}/}$soname -o $lib $libobjs $deplibs $compiler_flags'
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -shared ${wl}-Bexport:$ex=
port_symbols ${wl}-h,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $l=
ibobjs $deplibs $compiler_flags'
-      else
-	_LT_AC_TAGVAR(archive_cmds, $1)=3D'$CC -G ${wl}-h,\${SCOABSPATH:+${inst=
all_libdir}/}$soname -o $lib $libobjs $deplibs $compiler_flags'
-	_LT_AC_TAGVAR(archive_expsym_cmds, $1)=3D'$CC -G ${wl}-Bexport:$export_=
symbols ${wl}-h,\${SCOABSPATH:+${install_libdir}/}$soname -o $lib $libobj=
s $deplibs $compiler_flags'
-      fi
       ;;
=20
     uts4*)
@@ -6233,6 +5740,11 @@
 AC_MSG_RESULT([$_LT_AC_TAGVAR(ld_shlibs, $1)])
 test "$_LT_AC_TAGVAR(ld_shlibs, $1)" =3D no && can_build_shared=3Dno
=20
+variables_saved_for_relink=3D"PATH $shlibpath_var $runpath_var"
+if test "$GCC" =3D yes; then
+  variables_saved_for_relink=3D"$variables_saved_for_relink GCC_EXEC_PRE=
FIX COMPILER_PATH LIBRARY_PATH"
+fi
+
 #
 # Do we need to explicitly link libc?
 #
@@ -6260,7 +5772,6 @@
         libobjs=3Dconftest.$ac_objext
         deplibs=3D
         wl=3D$_LT_AC_TAGVAR(lt_prog_compiler_wl, $1)
-	pic_flag=3D$_LT_AC_TAGVAR(lt_prog_compiler_pic, $1)
         compiler_flags=3D-v
         linker_flags=3D-v
         verstring=3D
@@ -6386,7 +5897,7 @@
 # Add /usr/xpg4/bin/sed as it is typically found on Solaris
 # along with /bin/sed that truncates output.
 for lt_ac_sed in $lt_ac_sed_list /usr/xpg4/bin/sed; do
-  test ! -f $lt_ac_sed && continue
+  test ! -f $lt_ac_sed && break
   cat /dev/null > conftest.in
   lt_ac_count=3D0
   echo $ECHO_N "0123456789$ECHO_C" >conftest.in
@@ -6411,8 +5922,8 @@
     fi
   done
 done
-])
 SED=3D$lt_cv_path_SED
+])
 AC_MSG_RESULT([$SED])
 ])
=20
@@ -6433,7 +5944,7 @@
 # Call AM_AUTOMAKE_VERSION so it can be traced.
 # This function is AC_REQUIREd by AC_INIT_AUTOMAKE.
 AC_DEFUN([AM_SET_CURRENT_AUTOMAKE_VERSION],
-	 [AM_AUTOMAKE_VERSION([1.9.6])])
+	 [AM_AUTOMAKE_VERSION([1.9.5])])
=20
 # Figure out how to run the assembler.                      -*- Autoconf=
 -*-
=20

--------------000907010006020108030303--

