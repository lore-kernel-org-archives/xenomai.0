From: Vitaly Chikunov <vt@altlinux.org>
Subject: [RFC PATCH] Multi-library support with core suffix in soname
Date: Sun, 20 Sep 2020 22:28:08 +0300
Message-Id: <20200920192808.13637-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

This will allow (for users) installing both versions of libs into the
same system and (for distributions) having them without conflicts in
the same repository.

Such script is used to change Makefile.am-s:

  for lib in copperplate alchemy psos smokey trank vxworks
  do
    find -name Makefile.am \
    | xargs -r \
      sed -i -e "s/lib${lib}\.la/lib${lib}@CORE@\.la/g" \
	     -e "s/lib${lib}\_la/lib${lib}@CORE@\_la/g"
  done

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 configure.ac                        |  7 +++++++
 demo/alchemy/Makefile.am            |  4 ++--
 demo/alchemy/cobalt/Makefile.am     |  4 ++--
 lib/alchemy/Makefile.am             | 16 ++++++++--------
 lib/copperplate/Makefile.am         | 24 ++++++++++++------------
 lib/copperplate/regd/Makefile.am    |  2 +-
 lib/psos/Makefile.am                | 14 +++++++-------
 lib/smokey/Makefile.am              | 10 +++++-----
 lib/trank/Makefile.am               | 12 ++++++------
 lib/vxworks/Makefile.am             | 14 +++++++-------
 scripts/xeno-config-cobalt.in       |  5 +++--
 scripts/xeno-config-mercury.in      |  5 +++--
 testsuite/gpiotest/Makefile.am      |  2 +-
 testsuite/smokey/Makefile.am        |  4 ++--
 testsuite/smokey/dlopen/Makefile.am |  6 +++---
 testsuite/spitest/Makefile.am       |  2 +-
 utils/analogy/Makefile.am           |  8 ++++----
 utils/can/Makefile.am               |  8 ++++----
 utils/hdb/Makefile.am               |  2 +-
 19 files changed, 79 insertions(+), 70 deletions(-)

diff --git a/configure.ac b/configure.ac
index 164c44936..00b9a95cf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -859,6 +859,11 @@ dnl in-tree executables which require POSIX symbol wrapping.
    AC_SUBST([CONFIG_STATUS_DEPENDENCIES], ["$modechk_wrappers $cobalt_wrappers"])
 fi
 
+dnl Multi-core support.
+if test $rtcore_type = mercury; then
+	CORE="_$rtcore_type"
+fi
+
 dnl
 dnl Build the Makefiles
 dnl
@@ -898,6 +903,8 @@ AC_SUBST(XENO_TEST_DIR)
 AC_SUBST(XENO_DEMO_DIR)
 AC_SUBST(XENO_BUILD_COMPILER)
 AC_SUBST(XENO_BUILD_ARGS)
+AC_SUBST(XENO_BUILD_ARGS)
+AC_SUBST(CORE)
 
 AC_CONFIG_FILES([ \
 	Makefile \
diff --git a/demo/alchemy/Makefile.am b/demo/alchemy/Makefile.am
index 80def4fac..fed5c1c83 100644
--- a/demo/alchemy/Makefile.am
+++ b/demo/alchemy/Makefile.am
@@ -11,8 +11,8 @@ cppflags = 				\
 	-I$(top_srcdir)/include
 
 ldadd = 					\
-	../../lib/alchemy/libalchemy.la		\
-	../../lib/copperplate/libcopperplate.la	\
+	../../lib/alchemy/libalchemy@CORE@.la		\
+	../../lib/copperplate/libcopperplate@CORE@.la	\
 	@XENO_CORE_LDADD@ 			\
 	@XENO_USER_LDADD@			\
 	-lpthread -lrt -lm
diff --git a/demo/alchemy/cobalt/Makefile.am b/demo/alchemy/cobalt/Makefile.am
index 98d234515..ae2edd71c 100644
--- a/demo/alchemy/cobalt/Makefile.am
+++ b/demo/alchemy/cobalt/Makefile.am
@@ -11,8 +11,8 @@ cppflags = 			\
 ldadd = 					\
 	@XENO_AUTOINIT_LDFLAGS@			\
 	$(XENO_POSIX_WRAPPERS)			\
-	../../../lib/alchemy/libalchemy.la 	\
-	../../../lib/copperplate/libcopperplate.la \
+	../../../lib/alchemy/libalchemy@CORE@.la 	\
+	../../../lib/copperplate/libcopperplate@CORE@.la \
 	@XENO_CORE_LDADD@			\
 	@XENO_USER_LDADD@			\
 	-lrt -lpthread -lm
diff --git a/lib/alchemy/Makefile.am b/lib/alchemy/Makefile.am
index f97bd69bf..d350912ff 100644
--- a/lib/alchemy/Makefile.am
+++ b/lib/alchemy/Makefile.am
@@ -1,12 +1,12 @@
-lib_LTLIBRARIES = libalchemy.la
+lib_LTLIBRARIES = libalchemy@CORE@.la
 
-libalchemy_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
+libalchemy@CORE@_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
 
-libalchemy_la_LIBADD =						\
+libalchemy@CORE@_la_LIBADD =						\
 	@XENO_CORE_LDADD@					\
-	$(top_builddir)/lib/copperplate/libcopperplate.la
+	$(top_builddir)/lib/copperplate/libcopperplate@CORE@.la
 
-libalchemy_la_SOURCES =	\
+libalchemy@CORE@_la_SOURCES =	\
 	init.c		\
 	internal.c	\
 	internal.h	\
@@ -33,12 +33,12 @@ libalchemy_la_SOURCES =	\
 	timer.h
 
 if XENO_COBALT
-libalchemy_la_SOURCES +=	\
+libalchemy@CORE@_la_SOURCES +=	\
 	pipe.c			\
 	pipe.h
 endif
 
-libalchemy_la_CPPFLAGS =				\
+libalchemy@CORE@_la_CPPFLAGS =				\
 	@XENO_USER_CFLAGS@				\
 	-I$(top_srcdir)/include				\
 	-I$(top_srcdir)/lib
@@ -48,6 +48,6 @@ EXTRA_DIST = testsuite
 SPARSE = sparse
 
 sparse:
-	@for i in $(libalchemy_la_SOURCES); do \
+	@for i in $(libalchemy@CORE@_la_SOURCES); do \
 		$(SPARSE) $(CHECKFLAGS) $(srcdir)/$$i; \
 	done
diff --git a/lib/copperplate/Makefile.am b/lib/copperplate/Makefile.am
index c7104eb02..671e87d79 100644
--- a/lib/copperplate/Makefile.am
+++ b/lib/copperplate/Makefile.am
@@ -1,12 +1,12 @@
 
-lib_LTLIBRARIES = libcopperplate.la
+lib_LTLIBRARIES = libcopperplate@CORE@.la
 
-libcopperplate_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -lpthread -lrt -version-info 0:0:0
-libcopperplate_la_LIBADD = @XENO_CORE_LDADD@
+libcopperplate@CORE@_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -lpthread -lrt -version-info 0:0:0
+libcopperplate@CORE@_la_LIBADD = @XENO_CORE_LDADD@
 
 noinst_LTLIBRARIES =
 
-libcopperplate_la_SOURCES =	\
+libcopperplate@CORE@_la_SOURCES =	\
 	clockobj.c	\
 	cluster.c	\
 	eventobj.c 	\
@@ -19,35 +19,35 @@ libcopperplate_la_SOURCES =	\
 	timerobj.c	\
 	traceobj.c
 
-libcopperplate_la_CPPFLAGS =		\
+libcopperplate@CORE@_la_CPPFLAGS =		\
 	@XENO_USER_CFLAGS@		\
 	-I$(top_srcdir)			\
 	-I$(top_srcdir)/include		\
 	-I$(top_srcdir)/lib
 
 if XENO_REGISTRY
-libcopperplate_la_LIBADD += libregistry.la
+libcopperplate@CORE@_la_LIBADD += libregistry.la
 noinst_LTLIBRARIES += libregistry.la
 
 libregistry_la_SOURCES = registry.c
 
 libregistry_la_CPPFLAGS =		\
-	$(libcopperplate_la_CPPFLAGS)	\
+	$(libcopperplate@CORE@_la_CPPFLAGS)	\
 	@XENO_FUSE_CFLAGS@
 endif
 
 if XENO_PSHARED
 # The process shareable heap has real-time properties, therefore it
 # fits both the cobalt and mercury cores equally. Yummie.
-libcopperplate_la_SOURCES += heapobj-pshared.c reference.c
+libcopperplate@CORE@_la_SOURCES += heapobj-pshared.c reference.c
 endif
 if XENO_TLSF
-libcopperplate_la_SOURCES += heapobj-tlsf.c
+libcopperplate@CORE@_la_SOURCES += heapobj-tlsf.c
 else
 if XENO_HEAPMEM
-libcopperplate_la_SOURCES += heapobj-heapmem.c
+libcopperplate@CORE@_la_SOURCES += heapobj-heapmem.c
 else
-libcopperplate_la_SOURCES += heapobj-malloc.c
+libcopperplate@CORE@_la_SOURCES += heapobj-malloc.c
 endif
 endif
 
@@ -62,6 +62,6 @@ DIST_SUBDIRS = regd
 SPARSE = sparse
 
 sparse:
-	@for i in $(libcopperplate_la_SOURCES) ; do \
+	@for i in $(libcopperplate@CORE@_la_SOURCES) ; do \
 		$(SPARSE) $(CHECKFLAGS) $(srcdir)/$$i; \
 	done
diff --git a/lib/copperplate/regd/Makefile.am b/lib/copperplate/regd/Makefile.am
index c1893c105..3b14e9863 100644
--- a/lib/copperplate/regd/Makefile.am
+++ b/lib/copperplate/regd/Makefile.am
@@ -9,7 +9,7 @@ CPPFLAGS = 			\
 LDFLAGS = $(XENO_POSIX_WRAPPERS)
 
 LDADD = 			\
-	../libcopperplate.la	\
+	../libcopperplate@CORE@.la	\
 	@XENO_CORE_LDADD@	\
 	@XENO_USER_LDADD@	\
 	-lpthread -lrt
diff --git a/lib/psos/Makefile.am b/lib/psos/Makefile.am
index 6fe50881c..f54b26001 100644
--- a/lib/psos/Makefile.am
+++ b/lib/psos/Makefile.am
@@ -1,12 +1,12 @@
-lib_LTLIBRARIES = libpsos.la
+lib_LTLIBRARIES = libpsos@CORE@.la
 
-libpsos_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
+libpsos@CORE@_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
 
-libpsos_la_LIBADD =						\
+libpsos@CORE@_la_LIBADD =						\
 	@XENO_CORE_LDADD@					\
-	$(top_builddir)/lib/copperplate/libcopperplate.la
+	$(top_builddir)/lib/copperplate/libcopperplate@CORE@.la
 
-libpsos_la_SOURCES =	\
+libpsos@CORE@_la_SOURCES =	\
 	init.c		\
 	internal.h	\
 	pt.c		\
@@ -23,7 +23,7 @@ libpsos_la_SOURCES =	\
 	tm.h		\
 	reference.h
 
-libpsos_la_CPPFLAGS =					\
+libpsos@CORE@_la_CPPFLAGS =					\
 	@XENO_USER_CFLAGS@				\
 	-I$(top_srcdir)/include				\
 	-I$(top_srcdir)/lib
@@ -33,6 +33,6 @@ EXTRA_DIST = testsuite
 SPARSE = sparse
 
 sparse:
-	@for i in $(libpsos_la_SOURCES); do \
+	@for i in $(libpsos@CORE@_la_SOURCES); do \
 		$(SPARSE) $(CHECKFLAGS) $(srcdir)/$$i; \
 	done
diff --git a/lib/smokey/Makefile.am b/lib/smokey/Makefile.am
index 4ecae1f16..2674e3287 100644
--- a/lib/smokey/Makefile.am
+++ b/lib/smokey/Makefile.am
@@ -1,13 +1,13 @@
-lib_LTLIBRARIES = libsmokey.la
+lib_LTLIBRARIES = libsmokey@CORE@.la
 
-libsmokey_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
-libsmokey_la_LIBADD = @XENO_CORE_LDADD@
+libsmokey@CORE@_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
+libsmokey@CORE@_la_LIBADD = @XENO_CORE_LDADD@
 
-libsmokey_la_SOURCES =	\
+libsmokey@CORE@_la_SOURCES =	\
 	helpers.c	\
 	init.c
 
-libsmokey_la_CPPFLAGS =			\
+libsmokey@CORE@_la_CPPFLAGS =			\
 	@XENO_USER_CFLAGS@		\
 	-I$(top_srcdir)/include		\
 	-I$(top_srcdir)/lib
diff --git a/lib/trank/Makefile.am b/lib/trank/Makefile.am
index ee353c6f2..ec15367d3 100644
--- a/lib/trank/Makefile.am
+++ b/lib/trank/Makefile.am
@@ -1,20 +1,20 @@
 
-lib_LTLIBRARIES = libtrank.la
+lib_LTLIBRARIES = libtrank@CORE@.la
 
-libtrank_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
+libtrank@CORE@_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
 
-libtrank_la_LIBADD =						\
+libtrank@CORE@_la_LIBADD =						\
 	@XENO_CORE_LDADD@					\
-	$(top_builddir)/lib/alchemy/libalchemy.la
+	$(top_builddir)/lib/alchemy/libalchemy@CORE@.la
 
-libtrank_la_SOURCES =	\
+libtrank@CORE@_la_SOURCES =	\
 	init.c		\
 	internal.c	\
 	internal.h	\
 	posix.c		\
 	native.c
 
-libtrank_la_CPPFLAGS =		\
+libtrank@CORE@_la_CPPFLAGS =		\
 	@XENO_USER_CFLAGS@	\
 	-D__XENO_COMPAT__	\
 	-I$(top_srcdir)/include	\
diff --git a/lib/vxworks/Makefile.am b/lib/vxworks/Makefile.am
index 4217a994b..37b8caf7b 100644
--- a/lib/vxworks/Makefile.am
+++ b/lib/vxworks/Makefile.am
@@ -1,12 +1,12 @@
-lib_LTLIBRARIES = libvxworks.la
+lib_LTLIBRARIES = libvxworks@CORE@.la
 
-libvxworks_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
+libvxworks@CORE@_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
 
-libvxworks_la_LIBADD =						\
+libvxworks@CORE@_la_LIBADD =						\
 	@XENO_CORE_LDADD@					\
-	$(top_builddir)/lib/copperplate/libcopperplate.la
+	$(top_builddir)/lib/copperplate/libcopperplate@CORE@.la
 
-libvxworks_la_SOURCES = \
+libvxworks@CORE@_la_SOURCES = \
 	init.c		\
 	errnoLib.c	\
 	intLib.c	\
@@ -32,7 +32,7 @@ libvxworks_la_SOURCES = \
 	sysLib.c	\
 	reference.h
 
-libvxworks_la_CPPFLAGS =				\
+libvxworks@CORE@_la_CPPFLAGS =				\
 	@XENO_USER_CFLAGS@				\
 	-I$(top_srcdir)/include				\
 	-I$(top_srcdir)/lib
@@ -42,6 +42,6 @@ EXTRA_DIST = testsuite
 SPARSE = sparse
 
 sparse:
-	@for i in $(libvxworks_la_SOURCES); do \
+	@for i in $(libvxworks@CORE@_la_SOURCES); do \
 		$(SPARSE) $(CHECKFLAGS) $(srcdir)/$$i; \
 	done
diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
index 87d54fbf8..cd55ad82c 100644
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -8,6 +8,7 @@ datarootdir="@datarootdir@"
 datadir="@datadir@"
 pkgdatadir="${datadir}/@PACKAGE@"
 includedir="@includedir@"
+core="@CORE@"
 
 XENO_VERSION="@PACKAGE_VERSION@"
 XENO_PREFIX="${staging}${prefix}"
@@ -264,8 +265,8 @@ if test x$do_ldflags = xy; then
 		# --[no-]mode-check does.
 		;;
 	    vxworks|psos|alchemy|smokey)
-		copperplate="-lcopperplate"
-		ldflags="$ldflags -l$skin"
+		copperplate="-lcopperplate$core"
+		ldflags="$ldflags -l$skin$core"
 		if [ -r ${XENO_LIBRARY_DIR}/${skin}.wrappers ]; then
 		    ldflags=" `dump_wrappers ${skin}.wrappers` $ldflags"
 		fi
diff --git a/scripts/xeno-config-mercury.in b/scripts/xeno-config-mercury.in
index 2d2842f30..42b0de28a 100644
--- a/scripts/xeno-config-mercury.in
+++ b/scripts/xeno-config-mercury.in
@@ -8,6 +8,7 @@ datarootdir="@datarootdir@"
 datadir="@datadir@"
 pkgdatadir="${datadir}/@PACKAGE@"
 includedir="@includedir@"
+core="@CORE@"
 
 XENO_VERSION="@PACKAGE_VERSION@"
 XENO_PREFIX="${staging}${prefix}"
@@ -195,8 +196,8 @@ if test x$do_ldflags = xy; then
 	    posix|rtdm)
 		;;
 	    vxworks|psos|alchemy|smokey)
-		copperplate="-lcopperplate"
-		ldflags="-l$skin $ldflags"
+		copperplate="-lcopperplate$core"
+		ldflags="-l$skin$core $ldflags"
 		;;
 	    *)
 		echo "unknown API: $skin" 1>&2
diff --git a/testsuite/gpiotest/Makefile.am b/testsuite/gpiotest/Makefile.am
index 7615439cf..6f6ec6d71 100644
--- a/testsuite/gpiotest/Makefile.am
+++ b/testsuite/gpiotest/Makefile.am
@@ -13,7 +13,7 @@ gpiotest_CPPFLAGS = 		\
 gpiotest_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
 
 gpiotest_LDADD =			\
-	../../lib/smokey/libsmokey.la	\
+	../../lib/smokey/libsmokey@CORE@.la	\
 	@XENO_CORE_LDADD@		\
 	@XENO_USER_LDADD@		\
 	-lpthread -lrt
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index 81d0941c4..02613c7dc 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -110,8 +110,8 @@ smokey_LDFLAGS=$(wrappers) @XENO_AUTOINIT_LDFLAGS@ $(undef_list)
 
 smokey_LDADD = 					\
 	$(plugin_list)				\
-	../../lib/smokey/libsmokey.la		\
-	../../lib/copperplate/libcopperplate.la	\
+	../../lib/smokey/libsmokey@CORE@.la		\
+	../../lib/copperplate/libcopperplate@CORE@.la	\
 	@XENO_CORE_LDADD@			\
 	 @XENO_USER_LDADD@			\
 	-lpthread -lrt
diff --git a/testsuite/smokey/dlopen/Makefile.am b/testsuite/smokey/dlopen/Makefile.am
index db5a521d8..4f79ffb5a 100644
--- a/testsuite/smokey/dlopen/Makefile.am
+++ b/testsuite/smokey/dlopen/Makefile.am
@@ -11,8 +11,8 @@ libalchemy_test_la_LIBADD =					\
 	@XENO_CORE_LDADD@					\
 	@XENO_USER_LDADD@					\
 	../../../lib/boilerplate/init/libbootstrap-pic.la	\
-	../../../lib/alchemy/libalchemy.la			\
-	../../../lib/copperplate/libcopperplate.la
+	../../../lib/alchemy/libalchemy@CORE@.la			\
+	../../../lib/copperplate/libcopperplate@CORE@.la
 
 libalchemy_test_la_SOURCES = libalchemy-test.c
 
@@ -29,7 +29,7 @@ libposix_test_la_LIBADD =					\
 	@XENO_CORE_LDADD@					\
 	@XENO_USER_LDADD@					\
 	../../../lib/boilerplate/init/libbootstrap-pic.la	\
-	../../../lib/copperplate/libcopperplate.la
+	../../../lib/copperplate/libcopperplate@CORE@.la
 
 libposix_test_la_SOURCES = libposix-test.c
 
diff --git a/testsuite/spitest/Makefile.am b/testsuite/spitest/Makefile.am
index f5c3091d8..55b57fc2f 100644
--- a/testsuite/spitest/Makefile.am
+++ b/testsuite/spitest/Makefile.am
@@ -13,7 +13,7 @@ spitest_CPPFLAGS = 		\
 spitest_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
 
 spitest_LDADD =			\
-	../../lib/smokey/libsmokey.la	\
+	../../lib/smokey/libsmokey@CORE@.la	\
 	@XENO_CORE_LDADD@		\
 	@XENO_USER_LDADD@		\
 	-lpthread -lrt
diff --git a/utils/analogy/Makefile.am b/utils/analogy/Makefile.am
index 31da2e0b9..f8a304b60 100644
--- a/utils/analogy/Makefile.am
+++ b/utils/analogy/Makefile.am
@@ -42,8 +42,8 @@ cmd_read_SOURCES = cmd_read.c
 cmd_read_LDADD = \
 	@XENO_AUTOINIT_LDFLAGS@		\
 	../../lib/analogy/libanalogy.la \
-	../../lib/alchemy/libalchemy.la \
-	../../lib/copperplate/libcopperplate.la \
+	../../lib/alchemy/libalchemy@CORE@.la \
+	../../lib/copperplate/libcopperplate@CORE@.la \
 	@XENO_CORE_LDADD@		\
 	@XENO_USER_LDADD@		\
 	-lrt -lpthread -lm
@@ -52,8 +52,8 @@ cmd_write_SOURCES = cmd_write.c
 cmd_write_LDADD = \
 	@XENO_AUTOINIT_LDFLAGS@		\
 	../../lib/analogy/libanalogy.la \
-	../../lib/alchemy/libalchemy.la \
-	../../lib/copperplate/libcopperplate.la \
+	../../lib/alchemy/libalchemy@CORE@.la \
+	../../lib/copperplate/libcopperplate@CORE@.la \
 	@XENO_CORE_LDADD@		\
 	@XENO_USER_LDADD@		\
 	-lrt -lpthread -lm
diff --git a/utils/can/Makefile.am b/utils/can/Makefile.am
index 561dc7147..e41d266b9 100644
--- a/utils/can/Makefile.am
+++ b/utils/can/Makefile.am
@@ -20,8 +20,8 @@ rtcanconfig_LDADD = \
 rtcanrecv_SOURCES = rtcanrecv.c
 
 rtcanrecv_LDADD = \
-	../../lib/alchemy/libalchemy.la \
-	../../lib/copperplate/libcopperplate.la \
+	../../lib/alchemy/libalchemy@CORE@.la \
+	../../lib/copperplate/libcopperplate@CORE@.la \
 	@XENO_CORE_LDADD@		\
 	@XENO_USER_LDADD@		\
 	-lpthread -lrt
@@ -29,8 +29,8 @@ rtcanrecv_LDADD = \
 rtcansend_SOURCES = rtcansend.c
 
 rtcansend_LDADD = \
-	../../lib/alchemy/libalchemy.la \
-	../../lib/copperplate/libcopperplate.la \
+	../../lib/alchemy/libalchemy@CORE@.la \
+	../../lib/copperplate/libcopperplate@CORE@.la \
 	@XENO_CORE_LDADD@		\
 	@XENO_USER_LDADD@		\
 	-lpthread -lrt
diff --git a/utils/hdb/Makefile.am b/utils/hdb/Makefile.am
index 5eb3d3ddc..f78f3c2e6 100644
--- a/utils/hdb/Makefile.am
+++ b/utils/hdb/Makefile.am
@@ -9,7 +9,7 @@ hdb_CPPFLAGS = 			\
 hdb_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
 
 hdb_LDADD =					\
-	../../lib/copperplate/libcopperplate.la	\
+	../../lib/copperplate/libcopperplate@CORE@.la	\
 	@XENO_CORE_LDADD@			\
 	@XENO_USER_LDADD@			\
 	-lpthread -lrt
-- 
2.21.0


