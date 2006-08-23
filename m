From: Paul <paul_c@domain.hid>
Date: Wed, 23 Aug 2006 19:31:43 +0100
MIME-Version: 1.0
Message-Id: <200608231931.43452.paul_c@domain.hid>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_P8J7EUB/CabegmV"
Subject: [Xenomai-core] [PATCH] semicolon delimiters & quotes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_P8J7EUB/CabegmV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi Folks

Having found a problem with another project where semicolons in a few make 
targets were causing the shell to barf, I grepped xenomai trunk for similar 
problems. In doing so, I also spotted a few echos where the text wasn't 
quoted - A sure fire problem should anyone run the offending rule.

Small patch attached.


Regards, Paul.


--Boundary-00=_P8J7EUB/CabegmV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="semicolon.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="semicolon.diff"

Index: configure.in
===================================================================
--- configure.in	(revision 1484)
+++ configure.in	(working copy)
@@ -72,7 +72,7 @@
 	XENO_TARGET_ARCH=blackfin
         XENO_LINUX_ARCH=bfinnommu
 	XENO_LINUX_INSTALL_TARGET=install
-	if test x$enable_shared = xyes; then
+	if test x$enable_shared = xyes ; then
 	   AC_MSG_ERROR([Shared libraries unsupported -- reconfigure passing --disable-shared])
 	fi
         ;;
@@ -148,7 +148,7 @@
 
 dnl ARCH support for ARM (default: 4)
 
-if test $XENO_TARGET_ARCH = arm; then
+if test $XENO_TARGET_ARCH = arm ; then
   AC_MSG_CHECKING(for ARM architecture version)
   CONFIG_XENO_ARM_ARCH=4
   CONFIG_XENO_ARM_SA1100=
@@ -184,27 +184,27 @@
 	[case "$enableval" in
 	y | yes) XENO_LINUX_SRCDIR=y ;;
 	n | no) unset XENO_LINUX_SRCDIR ;;
-        *) XENO_LINUX_SRCDIR="`/bin/bash -c \"echo $enableval\"`";;
+        *) XENO_LINUX_SRCDIR="`/bin/bash -c \"echo $enableval\"`" ;;
 	esac])
 
-if test x"$XENO_LINUX_SRCDIR" = x; then
+if test x"$XENO_LINUX_SRCDIR" = x ; then
   AC_MSG_RESULT(no)
 else
   AC_MSG_RESULT(yes)
   AC_MSG_CHECKING(for Linux sources)
   if test x"$XENO_LINUX_SRCDIR" = xy; then
       candidates="linux-* $srcdir/linux-* $srcdir/linux linux"
-      if test x"$cross_compiling" = xno; then
+      if test x"$cross_compiling" = xno ; then
           candidates="$candidates /lib/modules/`uname -r`/source /usr/src/linux"
       fi
-      for dir in $candidates; do
-          if test -r $dir/Makefile; then 
+      for dir in $candidates ; do
+          if test -r $dir/Makefile ; then 
               XENO_LINUX_SRCDIR=$dir
-              break; 
+              break ; 
           fi
       done
   fi
-  if test x"$XENO_LINUX_SRCDIR" = xy || test ! -r $XENO_LINUX_SRCDIR/Makefile; then
+  if test x"$XENO_LINUX_SRCDIR" = xy || test ! -r $XENO_LINUX_SRCDIR/Makefile ; then
      AC_MSG_ERROR([Unable to find Linux kernel sources tree, please pass a valid Linux sources directory to --enable-linux-build])
   else
      XENO_LINUX_SRCDIR=`cd $XENO_LINUX_SRCDIR && pwd`
@@ -222,16 +222,16 @@
      linux_full_version="$linux_base_version$linux_EXTRAVERSION"
 
      if test x"$linux_PATCHLEVEL" = x -o x"$linux_SUBLEVEL" = x || 
-        test x"$linux_VERSION" = x; then
+        test x"$linux_VERSION" = x ; then
         AC_MSG_ERROR([Unable to get version of $XENO_LINUX_SRCDIR, aborting.])
      else
         AC_MSG_RESULT([$XENO_LINUX_SRCDIR (kernel ${linux_full_version})])
      fi
 
      case "$linux_base_version" in
-	2.4.*) XENO_LINUX_ALL_TARGETS="bzImage modules";;
+	2.4.*) XENO_LINUX_ALL_TARGETS="bzImage modules" ;;
         2.6.*) XENO_LINUX_ALL_TARGETS="all";;
-	*) AC_MSG_ERROR([Unknown Linux version $linux_full_version]);;
+	*) AC_MSG_ERROR([Unknown Linux version $linux_full_version]) ;;
      esac
      AC_SUBST(XENO_LINUX_ALL_TARGETS)
      AC_SUBST(XENO_LINUX_INSTALL_TARGET)
@@ -245,11 +245,11 @@
 patch. Default is to infer the patch name from Linux kernel version.]),
         [ADEOS_PATCH="`/bin/bash -c \"echo $withval\"`"])
 
-  if test x"$ADEOS_PATCH" = x && test x"$linux_base_version" != x; then
+  if test x"$ADEOS_PATCH" = x && test x"$linux_base_version" != x ; then
         set -- $srcdir/ksrc/arch/$XENO_TARGET_ARCH/patches/adeos-*$linux_base_version-$XENO_LINUX_ARCH-*
         ADEOS_PATCH=$1
   fi
-  if test x"$ADEOS_PATCH" = x || test ! -e $ADEOS_PATCH; then
+  if test x"$ADEOS_PATCH" = x || test ! -e $ADEOS_PATCH ; then
      AC_MSG_ERROR([Unable to find Adeos patch, please use --with-adeos-patch])
   else
      AC_MSG_RESULT([$ADEOS_PATCH])
@@ -257,10 +257,10 @@
   AC_SUBST(ADEOS_PATCH)
 
   AC_CONFIG_COMMANDS(linux, [
-     if test -e linux/.xenomai-prepared; then
+     if test -e linux/.xenomai-prepared ; then
         . linux/.xenomai-prepared
         if test x"$XENO_LINUX_VERSION" != x"$PREPARED_LINUX_VERSION" ||
-           test x"`basename $ADEOS_PATCH`" != x"$PREPARED_ADEOS_PATCH"; then
+           test x"`basename $ADEOS_PATCH`" != x"$PREPARED_ADEOS_PATCH" ; then
            echo "*** Warning: built version of linux and requested versions are "
            echo "*** different. If you want to build the requested version of "
            echo "*** linux, remove the file: linux/.xenomai-prepared."
@@ -270,8 +270,8 @@
      else
            set -e
            targetdir=$PWD/linux
-           if test \! -e linux || test \! $XENO_LINUX_SRCDIR -ef linux; then
-               if test -e linux; then
+           if test \! -e linux || test \! $XENO_LINUX_SRCDIR -ef linux ; then
+               if test -e linux ; then
                    test -e linux/.config && mv linux/.config .xenomai.config
                    echo $ECHO_N "Removing existing linux directory... $ECHO_C" 
                    rm -Rf linux
@@ -280,7 +280,7 @@
                mkdir linux
                echo $ECHO_N "Making linux a shadow copy of $XENO_LINUX_SRCDIR... $ECHO_C" 
                cd $XENO_LINUX_SRCDIR
-               find . -! -type d | while read f; do
+               find . -! -type d | while read f ; do
                    d=$targetdir/`dirname $f`
                    mkdir -p $d && ln -sf $XENO_LINUX_SRCDIR/$f $d/`basename $f`
                done
@@ -288,14 +288,14 @@
            fi
            cd $targetdir
 
-           if test -e $XENO_LINUX_SRCDIR/.config; then
+           if test -e $XENO_LINUX_SRCDIR/.config ; then
               . $XENO_LINUX_SRCDIR/.config
               test x"$CONFIG_X86" = xy && cfg_arch=i386 || :
               test x"$CONFIG_PPC" = xy && cfg_arch=ppc || :
               test x"$CONFIG_IA64" = xy && cfg_arch=ia64 || :
               test x"$CONFIG_PPC64" = xy && cfg_arch=ppc64 || :
               test x"$CONFIG_BLACKFIN" = xy && cfg_arch=blackfin || :
-              if test $cfg_arch = $XENO_TARGET_ARCH; then
+              if test $cfg_arch = $XENO_TARGET_ARCH ; then
                  cp $XENO_LINUX_SRCDIR/.config .xenomai.config
               fi
               echo "Cleaning linux directory..." 
@@ -322,7 +322,7 @@
 
 dnl Documentation package.
 
-if test \! -d $srcdir/doc; then 
+if test \! -d $srcdir/doc ; then 
     unset XENO_MAYBE_DOCDIR
 else
     XENO_MAYBE_DOCDIR=doc
@@ -337,7 +337,7 @@
 	*) unset CONFIG_XENO_DOC_DOX ;;
 	esac])
 
-if test \! -d $srcdir/doc; then
+if test \! -d $srcdir/doc ; then
     if test x$CONFIG_XENO_DOC_DOX = xy ; 
     then
         AC_MSG_ERROR([documentation tree is missing.])
@@ -349,12 +349,12 @@
 
 AC_CHECK_PROG(DOXYGEN, doxygen, doxygen)
 
-if test x${CONFIG_XENO_DOC_DOX} = xy -a x"$DOXYGEN" = x; then
+if test x${CONFIG_XENO_DOC_DOX} = xy -a x"$DOXYGEN" = x ; then
    AC_MSG_ERROR([Missing the Doxygen tools to generate the documentation.])
 fi
 
 AC_CHECK_PROG(DOXYGEN_HAVE_DOT, dot, YES, NO)
-if test x"$DOXYGEN_HAVE_DOT" = xYES; then
+if test x"$DOXYGEN_HAVE_DOT" = xYES ; then
    DOXYGEN_SHOW_INCLUDE_FILES=NO
 else
    DOXYGEN_SHOW_INCLUDE_FILES=YES
@@ -362,9 +362,9 @@
 
 case "$CONFIG_XENO_DOC_DBX" in
 y | ye | yes)
-    DBX_DOC=yes;;
+    DBX_DOC=yes ;;
 *)
-    DBX_DOC="";;
+    DBX_DOC="" ;;
 esac
 DBX_NET="$CONFIG_XENO_DBX_NET"
 DBX_ROOT="$CONFIG_XENO_DBX_ROOT"
@@ -457,10 +457,10 @@
    [ac_cv_sched_setaffinity=old],
    [ac_cv_sched_setaffinity=no])]
  fi
- if test $ac_cv_sched_setaffinity = old; then
+ if test $ac_cv_sched_setaffinity = old ; then
      AC_MSG_RESULT(old)
      AC_DEFINE(HAVE_OLD_SETAFFINITY,1,[config])
- elif test $ac_cv_sched_setaffinity = new; then
+ elif test $ac_cv_sched_setaffinity = new ; then
      AC_MSG_RESULT(ok)
      AC_DEFINE(HAVE_RECENT_SETAFFINITY,1,[config])
  else
@@ -539,8 +539,8 @@
 if [[ $ac_cv_ld_file_option = yes ]]; then
 	XENO_POSIX_WRAPPERS="-Wl,@`cd $srcdir && pwd`/src/skins/posix/posix.wrappers"
 else
-	XENO_POSIX_WRAPPERS=`while read wrap_option symbol; do \
-			echo -n "-Wl,$wrap_option,$symbol "; \
+	XENO_POSIX_WRAPPERS=`while read wrap_option symbol ; do \
+			echo -n "-Wl,$wrap_option,$symbol " ; \
 		done < $srcdir/src/skins/posix/posix.wrappers`
 fi
 AC_MSG_RESULT(${ac_cv_ld_file_option:-no})
@@ -640,7 +640,7 @@
        	include/vxworks/Makefile \
 	])
 
-if test \! x$XENO_MAYBE_DOCDIR = x; then
+if test \! x$XENO_MAYBE_DOCDIR = x ; then
       AC_CONFIG_FILES([ \
 	doc/Makefile \
 	doc/txt/Makefile \
Index: scripts/Makefile.am
===================================================================
--- scripts/Makefile.am	(revision 1484)
+++ scripts/Makefile.am	(working copy)
@@ -1,7 +1,7 @@
 bin_SCRIPTS=xeno-config xeno-load xeno-test xeno-info
 
 install-exec-local:
-	@if test -r $(srcdir)/postinstall.sh; then \
+	@if test -r $(srcdir)/postinstall.sh ; then \
 	   echo "Running post-install script..." ;\
 	   $(srcdir)/postinstall.sh ; \
 	fi
Index: src/skins/posix/Makefile.am
===================================================================
--- src/skins/posix/Makefile.am	(revision 1484)
+++ src/skins/posix/Makefile.am	(working copy)
@@ -31,9 +31,9 @@
 	$(RM) $(DESTDIR)$(libdir)/posix.wrappers
 
 install-exec-hook:
-	for la in $(lib_LTLIBRARIES); do \
-	    sed -e 's/shouldnotlink=yes/shouldnotlink=no/' $(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
-	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
+	for la in $(lib_LTLIBRARIES) ; do \
+	    sed -e 's/shouldnotlink=yes/shouldnotlink=no/' $(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched ; \
+	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la ; \
 	done
 
 EXTRA_DIST = posix.wrappers
Index: src/skins/vrtx/Makefile.am
===================================================================
--- src/skins/vrtx/Makefile.am	(revision 1484)
+++ src/skins/vrtx/Makefile.am	(working copy)
@@ -19,7 +19,7 @@
 	-I$(top_srcdir)/include
 
 install-exec-hook:
-	for la in $(lib_LTLIBRARIES); do \
-	    sed -e 's/shouldnotlink=yes/shouldnotlink=no/' $(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
-	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
+	for la in $(lib_LTLIBRARIES) ; do \
+	    sed -e 's/shouldnotlink=yes/shouldnotlink=no/' $(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched ; \
+	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la ; \
 	done
Index: src/skins/vxworks/Makefile.am
===================================================================
--- src/skins/vxworks/Makefile.am	(revision 1484)
+++ src/skins/vxworks/Makefile.am	(working copy)
@@ -20,7 +20,7 @@
 	-I$(top_srcdir)/include
 
 install-exec-hook:
-	for la in $(lib_LTLIBRARIES); do \
-	    sed -e 's/shouldnotlink=yes/shouldnotlink=no/' $(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
-	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
+	for la in $(lib_LTLIBRARIES) ; do \
+	    sed -e 's/shouldnotlink=yes/shouldnotlink=no/' $(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched ; \
+	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la ; \
 	done
Index: src/skins/native/Makefile.am
===================================================================
--- src/skins/native/Makefile.am	(revision 1484)
+++ src/skins/native/Makefile.am	(working copy)
@@ -22,7 +22,7 @@
 	-I$(top_srcdir)/include
 
 install-exec-hook:
-	for la in $(lib_LTLIBRARIES); do \
-	    sed -e 's/shouldnotlink=yes/shouldnotlink=no/' $(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
-	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
+	for la in $(lib_LTLIBRARIES) ; do \
+	    sed -e 's/shouldnotlink=yes/shouldnotlink=no/' $(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched ; \
+	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la ; \
 	done
Index: src/skins/rtdm/Makefile.am
===================================================================
--- src/skins/rtdm/Makefile.am	(revision 1484)
+++ src/skins/rtdm/Makefile.am	(working copy)
@@ -11,7 +11,7 @@
 	-I$(top_srcdir)/include
 
 install-exec-hook:
-	for la in $(lib_LTLIBRARIES); do \
-	    sed -e 's/shouldnotlink=yes/shouldnotlink=no/' $(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
-	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
+	for la in $(lib_LTLIBRARIES) ; do \
+	    sed -e 's/shouldnotlink=yes/shouldnotlink=no/' $(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched ; \
+	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la ; \
 	done
Index: sim/configure.in
===================================================================
--- sim/configure.in	(revision 1484)
+++ sim/configure.in	(working copy)
@@ -45,7 +45,7 @@
 AC_PROG_LIBTOOL
 AM_PROG_LEX
 
-if test \! -r $srcdir/../ksrc/nucleus; then
+if test \! -r $srcdir/../ksrc/nucleus ; then
     AC_MSG_ERROR([Missing Xenomai source tree in parent directory])
 fi
 
@@ -107,15 +107,15 @@
 	CONFIG_XENO_MVM_GCC_TARBALL="$withval"
     ])
 
-if test x$CONFIG_XENO_MVM_GCC_TARBALL = x; then
+if test x$CONFIG_XENO_MVM_GCC_TARBALL = x ; then
    CONFIG_XENO_MVM_GCC_TARBALL="/tmp/gcc-2.95.3.tar.bz2"
 fi
 
-if test \! -r $prefix/libexec/gcic/.gcic-installed; then
-   if test \! -r "${CONFIG_XENO_MVM_GCC_TARBALL}"; then
+if test \! -r $prefix/libexec/gcic/.gcic-installed ; then
+   if test \! -r "${CONFIG_XENO_MVM_GCC_TARBALL}" ; then
       dnl We are going to need the source GCC tarball to build the
       dnl instrumenter and we cannot find it: this is bad news.
-      if test x$CONFIG_XENO_MVM_GCC_TARBALL = x; then
+      if test x$CONFIG_XENO_MVM_GCC_TARBALL = x ; then
          AC_MSG_RESULT([unspecified (use --with-gcc-tarball to specify one)])
       else
          AC_MSG_RESULT([not found at $CONFIG_XENO_MVM_GCC_TARBALL])
@@ -316,17 +316,17 @@
 )
 MVM_LDADD=
 AC_CHECK_LIB(elf, elf_begin,
-	[MVM_LDADD="$MVM_LDADD -lelf"; AC_DEFINE(HAVE_LIBELF,1,[config])],
+	[MVM_LDADD="$MVM_LDADD -lelf" ; AC_DEFINE(HAVE_LIBELF,1,[config])],
 	AC_MSG_ERROR([Cannot find libelf (development version) on this system])
 )
 AC_CHECK_LIB(dl, dlopen,
-	[MVM_LDADD="$MVM_LDADD -ldl"; AC_DEFINE(HAVE_LIBDL,1,[config])]
+	[MVM_LDADD="$MVM_LDADD -ldl" ; AC_DEFINE(HAVE_LIBDL,1,[config])]
 )
 AC_CHECK_LIB(nsl, gethostbyname,
-	[MVM_LDADD="$MVM_LDADD -lnsl"; AC_DEFINE(HAVE_LIBNSL,1,[config])]
+	[MVM_LDADD="$MVM_LDADD -lnsl" ; AC_DEFINE(HAVE_LIBNSL,1,[config])]
 )
 AC_CHECK_LIB(socket, connect,
-	[MVM_LDADD="$MVM_LDADD -lsocket"; AC_DEFINE(HAVE_LIBSOCKET,1,[config])]
+	[MVM_LDADD="$MVM_LDADD -lsocket" ; AC_DEFINE(HAVE_LIBSOCKET,1,[config])]
 )
 AC_CHECK_LIB(png, png_read_init, [LIBPNG_OK=1],
 	AC_MSG_ERROR([Cannot find libpng (development version) on this system])
Index: sim/gcic/Makefile.am
===================================================================
--- sim/gcic/Makefile.am	(revision 1484)
+++ sim/gcic/Makefile.am	(working copy)
@@ -14,7 +14,7 @@
 
 GCCTOP=$(shell basename @MVM_GCC_TARBALL@ | sed -e 's,^\(.*\)\.tar.*,\1,')
 GCCVER=$(shell basename @MVM_GCC_TARBALL@ | sed -e 's,gcc-\(.*\)\.tar.*,\1,g')
-GCCDEP=$(shell test -r $(libexecdir)/gcic/.gcic-installed || echo $(libexecdir)/gcic/.gcic-installed)
+GCCDEP=$(shell test -r $(libexecdir)/gcic/.gcic-installed || echo "$(libexecdir)/gcic/.gcic-installed")
 
 all-local: $(GCCDEP)
 
@@ -31,7 +31,7 @@
 	$(srcdir)/gcc-$(GCCVER).patch && touch $@
 
 gcc-build/.gcic-configured: $(GCCTOP)/.gcic-patched $(top_builddir)/config.status
-	@( $(RM) -Rf gcc-build; mkdir gcc-build && cd gcc-build && \
+	@( $(RM) -Rf gcc-build ; mkdir gcc-build && cd gcc-build && \
 	LC_ALL=C CC=$(CC) ../$(GCCTOP)/configure --prefix=$(libexecdir)/gcic \
 	--with-gnu-ld --with-gnu-as && cd .. ) && touch $@
 
Index: doc/Makefile.am
===================================================================
--- doc/Makefile.am	(revision 1484)
+++ doc/Makefile.am	(working copy)
@@ -3,10 +3,10 @@
 GENERATE_DOC=$(top_srcdir)/scripts/maint/generate-doc
 
 generate-doc:
-	@if test \! -e $(GENERATE_DOC) -o \! -e $(srcdir)/.svn; then \
-		echo $@ may only be run from a SVN working copy.; \
+	@if test \! -e $(GENERATE_DOC) -o \! -e $(srcdir)/.svn ; then \
+		echo "$@ may only be run from a SVN working copy." ; \
 	else \
-		srcdir=$(srcdir) $(GENERATE_DOC); \
+		srcdir=$(srcdir) $(GENERATE_DOC) ; \
 	fi
 
 dist-hook:
Index: doc/doxygen/Makefile.am
===================================================================
--- doc/doxygen/Makefile.am	(revision 1484)
+++ doc/doxygen/Makefile.am	(working copy)
@@ -17,8 +17,8 @@
 	$(DOXYGEN) $(DOXYDOC_OPTS)
 
 distclean-local:
-	for dir in $(HTML_DOCS); do \
-	    if test -d $$dir; then $(RM) -R $$dir; fi; \
+	for dir in $(HTML_DOCS) ; do \
+	    if test -d $$dir ; then $(RM) -R $$dir ; fi ; \
 	done
 
 .PHONY: doxygen-api
Index: Makefile.am
===================================================================
--- Makefile.am	(revision 1484)
+++ Makefile.am	(working copy)
@@ -13,38 +13,38 @@
 
 dev devices:
 	@if test x`id -u` = x0; then \
-           sudo=; \
-        else if test \! "x`type $(SUDO)`" = x; then \
-           echo "sudo found (sudo is $(SUDO)), testing it..."; \
+           sudo= ; \
+        else if test \! "x`type $(SUDO)`" = x ; then \
+           echo "sudo found (sudo is $(SUDO)), testing it..." ; \
            $(SUDO) true && sudo="$(SUDO)" || { \
 echo '*** Warning: you are not super-user and sudo does not work, real-time\
-devices'; \
-echo '*** nodes will not be created.'; \
+devices' ; \
+echo '*** nodes will not be created.' ; \
 echo '*** If you do not create these devices by hand, Xenomai test programs\
-will not'; \
-echo '*** work.'; \
-echo '*** To create these devices please run "make devices" with super-user'; \
-echo '*** privileges.'; \
-             exit 0; }; \
-           echo sudo is working.; \
-           fi; \
-        fi; \
-        if test -r $(DESTDIR)/etc/udev/udev.rules; then \
-           for f in $(srcdir)/ksrc/nucleus/udev/*.rules; do \
+will not' ; \
+echo '*** work.' ; \
+echo '*** To create these devices please run "make devices" with super-user' ; \
+echo '*** privileges.' ; \
+             exit 0 ; } ; \
+           echo 'sudo is working.' ; \
+           fi ; \
+        fi ; \
+        if test -r $(DESTDIR)/etc/udev/udev.rules ; then \
+           for f in $(srcdir)/ksrc/nucleus/udev/*.rules ; do \
            b=`basename $$f` ; \
            grep -q Xenomai:`basename $$b .rules` $(DESTDIR)/etc/udev/udev.rules || \
-           $$sudo sh -c "( echo ; cat $$f ) >> $(DESTDIR)/etc/udev/udev.rules"; \
-           done; \
-	fi; \
-        $(mkinstalldirs) $(DESTDIR)/dev; \
-	for n in `seq 0 31`; do \
-           f="$(DESTDIR)/dev/rtp$$n"; \
-           if test \! -c $$f; then \
-              $$sudo mknod -m 666 $$f c 150 $$n; \
-           fi; \
+           $$sudo sh -c "( echo ; cat $$f ) >> $(DESTDIR)/etc/udev/udev.rules" ; \
+           done ; \
+	fi ; \
+        $(mkinstalldirs) $(DESTDIR)/dev ; \
+	for n in `seq 0 31` ; do \
+           f="$(DESTDIR)/dev/rtp$$n" ; \
+           if test \! -c $$f ; then \
+              $$sudo mknod -m 666 $$f c 150 $$n ; \
+           fi ; \
         done ; \
-        if test \! -c $(DESTDIR)/dev/rtheap; then \
-          $$sudo mknod -m 666 $(DESTDIR)/dev/rtheap c 10 254; \
+        if test \! -c $(DESTDIR)/dev/rtheap ; then \
+          $$sudo mknod -m 666 $(DESTDIR)/dev/rtheap c 10 254 ; \
         fi
 
 install-exec-local: devices
@@ -88,9 +88,9 @@
 .PHONY: FORCE
 
 linux/install: linux/all
-	@targets=modules_install; \
+	@targets=modules_install ; \
 	sudo=; if test x`id -u` != x0 && test \! "x`type $(SUDO)`" = x && \
-	$(SUDO) true; then sudo=$(SUDO); targets="$$targets install"; fi && \
+	$(SUDO) true ; then sudo=$(SUDO) ; targets="$$targets install" ; fi && \
 	$(mkinstalldirs) $(DESTDIR) && \
 	$$sudo $(mkinstalldirs) $(DESTDIR)/boot && \
 	cross=`expr $(CC) : '\(.*\)gcc' || :` && \
@@ -103,7 +103,7 @@
 # installation target that simply copy the kernel image and System.map.
 linux/install_image: linux/all
 	sudo=; if test x`id -u` != x0 && test \! "x`type $(SUDO)`" = x && \
-	$(SUDO) true; then sudo=$(SUDO); fi && \
+	$(SUDO) true ; then sudo=$(SUDO) ; fi && \
 	$(mkinstalldirs) $(DESTDIR) && \
 	$$sudo $(mkinstalldirs) $(DESTDIR)/boot && \
 	cross=`expr $(CC) : '\(.*\)gcc' || :` && \
@@ -114,8 +114,8 @@
 
 distclean-linux:
 	@test -e linux/.config && \
-		mv linux/.config linux/.config.saved.xenomai; \
-	$(MAKE) linux/distclean; \
+		mv linux/.config linux/.config.saved.xenomai ; \
+	$(MAKE) linux/distclean ; \
 	test -e linux/.config.saved.xenomai && \
 		mv linux/.config.saved.xenomai linux/.config
 

--Boundary-00=_P8J7EUB/CabegmV--

