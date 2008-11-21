Message-ID: <49268C78.5010600@domain.hid>
Date: Fri, 21 Nov 2008 11:24:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Mark libs with nodlopen when using
	initial-exec TLS
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Some naive optimist once claim that the dynamic linker would detect if
we try to dlopen some Xenomai lib (directly or indirectly) which uses
the optimised initial-exec TLS variables. He was wrong of course. It
takes the special marker nodlopen to achieve this, and that's what the
patch below does when and where required.

Jan

---
 ChangeLog                     |    3 +++
 configure.in                  |    3 +++
 src/skins/native/Makefile.am  |    2 +-
 src/skins/posix/Makefile.am   |    2 +-
 src/skins/psos+/Makefile.am   |    2 +-
 src/skins/rtai/Makefile.am    |    2 +-
 src/skins/rtdm/Makefile.am    |    2 +-
 src/skins/uitron/Makefile.am  |    2 +-
 src/skins/vrtx/Makefile.am    |    2 +-
 src/skins/vxworks/Makefile.am |    2 +-
 10 files changed, 14 insertions(+), 8 deletions(-)

Index: xenomai/configure.in
===================================================================
--- xenomai.orig/configure.in
+++ xenomai/configure.in
@@ -762,6 +762,7 @@ LIBS="$LIBS -lrt"
 AC_CHECK_FUNCS([shm_open shm_unlink])
 LIBS="$save_LIBS"
 
+XENO_DLOPEN_CONSTRAINT=
 AC_ARG_WITH([__thread],
 	    AC_HELP_STRING([--without-__thread],
 			   [do not use TLS features (allows for dlopen'ing Xenomai libs)]),
@@ -782,6 +783,7 @@ EOF
 	rm -f conftest*])
 	if test "$libc_cv_gcc___thread" = yes; then
 		AC_DEFINE(HAVE___THREAD,1,[config])
+		XENO_DLOPEN_CONSTRAINT="-Wl,-z -Wl,nodlopen"
 	fi
 fi
 
@@ -803,6 +805,7 @@ AC_SUBST(XENO_USER_CFLAGS)
 AC_SUBST(XENO_USER_LDFLAGS)
 AC_SUBST(XENO_USER_APP_CFLAGS)
 AC_SUBST(XENO_USER_APP_LDFLAGS)
+AC_SUBST(XENO_DLOPEN_CONSTRAINT)
 AC_SUBST([CONFIG_STATUS_DEPENDENCIES],
         ['$(top_srcdir)/src/skins/posix/posix.wrappers'])
 AC_SUBST(XENO_POSIX_WRAPPERS)
Index: xenomai/src/skins/native/Makefile.am
===================================================================
--- xenomai.orig/src/skins/native/Makefile.am
+++ xenomai/src/skins/native/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libnative.la
 
-libnative_la_LDFLAGS = -version-info 3:0:0 -lpthread
+libnative_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 3:0:0 -lpthread
 
 libnative_la_SOURCES = \
 	alarm.c \
Index: xenomai/src/skins/posix/Makefile.am
===================================================================
--- xenomai.orig/src/skins/posix/Makefile.am
+++ xenomai/src/skins/posix/Makefile.am
@@ -4,7 +4,7 @@ lib_LTLIBRARIES = libpthread_rt.la
 
 CPPFLAGS+=-I$(top_srcdir)/ksrc/skins
 
-libpthread_rt_la_LDFLAGS = -version-info 1:0:0 -lpthread
+libpthread_rt_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 1:0:0 -lpthread
 
 libpthread_rt_la_SOURCES = \
 	init.c \
Index: xenomai/src/skins/psos+/Makefile.am
===================================================================
--- xenomai.orig/src/skins/psos+/Makefile.am
+++ xenomai/src/skins/psos+/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libpsos.la
 
-libpsos_la_LDFLAGS = -version-info 0:0:0 -lpthread
+libpsos_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 0:0:0 -lpthread
 
 libpsos_la_SOURCES = \
 	asr.c \
Index: xenomai/src/skins/rtai/Makefile.am
===================================================================
--- xenomai.orig/src/skins/rtai/Makefile.am
+++ xenomai/src/skins/rtai/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = librtai.la
 
-librtai_la_LDFLAGS = -version-info 0:0:0
+librtai_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 0:0:0
 
 librtai_la_SOURCES = init.c \
 	shm.c
Index: xenomai/src/skins/rtdm/Makefile.am
===================================================================
--- xenomai.orig/src/skins/rtdm/Makefile.am
+++ xenomai/src/skins/rtdm/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = librtdm.la
 
-librtdm_la_LDFLAGS = -version-info 1:0:0 -lpthread
+librtdm_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 1:0:0 -lpthread
 
 librtdm_la_SOURCES = \
 	core.c \
Index: xenomai/src/skins/uitron/Makefile.am
===================================================================
--- xenomai.orig/src/skins/uitron/Makefile.am
+++ xenomai/src/skins/uitron/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libuitron.la
 
-libuitron_la_LDFLAGS = -version-info 0:0:0 -lpthread
+libuitron_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 0:0:0 -lpthread
 
 libuitron_la_SOURCES = \
 	flag.c \
Index: xenomai/src/skins/vrtx/Makefile.am
===================================================================
--- xenomai.orig/src/skins/vrtx/Makefile.am
+++ xenomai/src/skins/vrtx/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libvrtx.la
 
-libvrtx_la_LDFLAGS = -version-info 0:0:0 -lpthread
+libvrtx_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 0:0:0 -lpthread
 
 libvrtx_la_SOURCES = \
 	event.c \
Index: xenomai/src/skins/vxworks/Makefile.am
===================================================================
--- xenomai.orig/src/skins/vxworks/Makefile.am
+++ xenomai/src/skins/vxworks/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libvxworks.la
 
-libvxworks_la_LDFLAGS = -version-info 1:0:0 -lpthread
+libvxworks_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 1:0:0 -lpthread
 
 libvxworks_la_SOURCES = \
 	errnoLib.c \
Index: xenomai/ChangeLog
===================================================================
--- xenomai.orig/ChangeLog
+++ xenomai/ChangeLog
@@ -1,5 +1,8 @@
 2008-11-21  Jan Kiszka  <jan.kiszka@domain.hid>
 
+	* configure.in, src/skins/*/Makefile.am: Mark libs with nodlopen
+	if initial-exec __thread variables are used.
+
 	* ksrc/nucleus/shadow.c (xnshadow_map): Reject already mapped
 	tasks with -EBUSY.
 

-- 
Siemens AG, Corporate Technology, CT SE 2 ES-OS
Corporate Competence Center Embedded Linux

