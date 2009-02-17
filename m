Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <499AEE93.9070209@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 17 Feb 2009 18:04:19 +0100
Message-ID: <20090217170419.1425.46245.stgit@domain.hid>
In-Reply-To: <20090217170418.1425.56126.stgit@domain.hid>
References: <20090217170418.1425.56126.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2 2/4] Mark libs nodlopen on initial-exec TLS
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

Mark libs with nodlopen if initial-exec __thread variables are used
because dlopen and this TLS model are in conflict.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 configure.in                  |    3 +++
 src/skins/native/Makefile.am  |    2 +-
 src/skins/posix/Makefile.am   |    2 +-
 src/skins/psos+/Makefile.am   |    2 +-
 src/skins/rtai/Makefile.am    |    2 +-
 src/skins/rtdm/Makefile.am    |    2 +-
 src/skins/uitron/Makefile.am  |    2 +-
 src/skins/vrtx/Makefile.am    |    2 +-
 src/skins/vxworks/Makefile.am |    2 +-
 9 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/configure.in b/configure.in
index c111c4a..1d7f5fa 100644
--- a/configure.in
+++ b/configure.in
@@ -758,6 +758,7 @@ LIBS="$LIBS -lrt"
 AC_CHECK_FUNCS([shm_open shm_unlink])
 LIBS="$save_LIBS"
 
+XENO_DLOPEN_CONSTRAINT=
 AC_ARG_WITH([__thread],
 	    AC_HELP_STRING([--without-__thread],
 			   [do not use TLS features (allows for dlopen'ing Xenomai libs)]),
@@ -778,6 +779,7 @@ EOF
 	rm -f conftest*])
 	if test "$libc_cv_gcc___thread" = yes; then
 		AC_DEFINE(HAVE___THREAD,1,[config])
+		XENO_DLOPEN_CONSTRAINT="-Wl,-z -Wl,nodlopen"
 	fi
 fi
 
@@ -799,6 +801,7 @@ AC_SUBST(XENO_USER_CFLAGS)
 AC_SUBST(XENO_USER_LDFLAGS)
 AC_SUBST(XENO_USER_APP_CFLAGS)
 AC_SUBST(XENO_USER_APP_LDFLAGS)
+AC_SUBST(XENO_DLOPEN_CONSTRAINT)
 AC_SUBST([CONFIG_STATUS_DEPENDENCIES],
         ['$(top_srcdir)/src/skins/posix/posix.wrappers'])
 AC_SUBST(XENO_POSIX_WRAPPERS)
diff --git a/src/skins/native/Makefile.am b/src/skins/native/Makefile.am
index a1f61d9..3497f90 100644
--- a/src/skins/native/Makefile.am
+++ b/src/skins/native/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libnative.la
 
-libnative_la_LDFLAGS = -version-info 3:0:0 -lpthread
+libnative_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 3:0:0 -lpthread
 
 libnative_la_SOURCES = \
 	alarm.c \
diff --git a/src/skins/posix/Makefile.am b/src/skins/posix/Makefile.am
index 2d42a28..d6a0912 100644
--- a/src/skins/posix/Makefile.am
+++ b/src/skins/posix/Makefile.am
@@ -4,7 +4,7 @@ lib_LTLIBRARIES = libpthread_rt.la
 
 CPPFLAGS+=-I$(top_srcdir)/ksrc/skins
 
-libpthread_rt_la_LDFLAGS = -version-info 1:0:0 -lpthread
+libpthread_rt_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 1:0:0 -lpthread
 
 libpthread_rt_la_SOURCES = \
 	init.c \
diff --git a/src/skins/psos+/Makefile.am b/src/skins/psos+/Makefile.am
index a579ebe..3e4464d 100644
--- a/src/skins/psos+/Makefile.am
+++ b/src/skins/psos+/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libpsos.la
 
-libpsos_la_LDFLAGS = -version-info 0:0:0 -lpthread
+libpsos_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 0:0:0 -lpthread
 
 libpsos_la_SOURCES = \
 	asr.c \
diff --git a/src/skins/rtai/Makefile.am b/src/skins/rtai/Makefile.am
index 8a92859..bae83c1 100644
--- a/src/skins/rtai/Makefile.am
+++ b/src/skins/rtai/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = librtai.la
 
-librtai_la_LDFLAGS = -version-info 0:0:0
+librtai_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 0:0:0
 
 librtai_la_SOURCES = init.c \
 	shm.c
diff --git a/src/skins/rtdm/Makefile.am b/src/skins/rtdm/Makefile.am
index 00099be..73f97cf 100644
--- a/src/skins/rtdm/Makefile.am
+++ b/src/skins/rtdm/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = librtdm.la
 
-librtdm_la_LDFLAGS = -version-info 1:0:0 -lpthread
+librtdm_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 1:0:0 -lpthread
 
 librtdm_la_SOURCES = \
 	core.c \
diff --git a/src/skins/uitron/Makefile.am b/src/skins/uitron/Makefile.am
index 3736a9b..a7ff65a 100644
--- a/src/skins/uitron/Makefile.am
+++ b/src/skins/uitron/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libuitron.la
 
-libuitron_la_LDFLAGS = -version-info 0:0:0 -lpthread
+libuitron_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 0:0:0 -lpthread
 
 libuitron_la_SOURCES = \
 	flag.c \
diff --git a/src/skins/vrtx/Makefile.am b/src/skins/vrtx/Makefile.am
index a5517f3..6233548 100644
--- a/src/skins/vrtx/Makefile.am
+++ b/src/skins/vrtx/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libvrtx.la
 
-libvrtx_la_LDFLAGS = -version-info 0:0:0 -lpthread
+libvrtx_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 0:0:0 -lpthread
 
 libvrtx_la_SOURCES = \
 	event.c \
diff --git a/src/skins/vxworks/Makefile.am b/src/skins/vxworks/Makefile.am
index 7a57055..b7b74e6 100644
--- a/src/skins/vxworks/Makefile.am
+++ b/src/skins/vxworks/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libvxworks.la
 
-libvxworks_la_LDFLAGS = -version-info 1:0:0 -lpthread
+libvxworks_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 1:0:0 -lpthread
 
 libvxworks_la_SOURCES = \
 	errnoLib.c \


