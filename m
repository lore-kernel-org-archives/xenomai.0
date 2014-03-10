From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Mon, 10 Mar 2014 14:12:20 +0100
Message-Id: <1394457140-11250-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH] registry: use pkg-config to retrieve fuse flags
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This helps forcing Xenomai to use a custom built version of libfuse, instead
of the one it finds in /usr/lib.
---
 configure.ac |   22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/configure.ac b/configure.ac
index 791f12e..5088429 100644
--- a/configure.ac
+++ b/configure.ac
@@ -286,23 +286,9 @@ AC_ARG_ENABLE(registry,
 AC_MSG_RESULT(${use_registry:-no})
 
 if test x$use_registry = xy; then
-	fuse_cflags="-D_FILE_OFFSET_BITS=64 -DFUSE_USE_VERSION=25"
-	fuse_ldflags="-lfuse"
-	AC_LANG_SAVE
-	AC_LANG_C
-	save_CPPFLAGS="$CPPFLAGS"
-	CPPFLAGS=$fuse_cflags
-	AC_CHECK_HEADER(fuse.h,,
-		AC_MSG_ERROR([Cannot find fuse.h (part of libfuse development package) on this system])
-	)
-	AC_CHECK_LIB(fuse, fuse_new,,
-		AC_MSG_ERROR([Cannot find libfuse (FUSE development package) on this system]),
-		[-lpthread -lrt -ldl]
-	)
-	CPPFLAGS="$save_CPPFLAGS"
-	AC_LANG_RESTORE
+        PKG_CHECK_MODULES(FUSE, fuse)
+
 	AC_DEFINE(CONFIG_XENO_REGISTRY,1,[config])
-	AC_DEFINE(_FILE_OFFSET_BITS,64,[config])
 	AC_DEFINE(FUSE_USE_VERSION,25,[config])
 fi
 AM_CONDITIONAL(XENO_REGISTRY,[test x$use_registry = xy])
@@ -614,8 +600,8 @@ XENO_USER_APP_CFLAGS="-D_GNU_SOURCE -D_REENTRANT"
 XENO_USER_APP_LDFLAGS=
 
 if test x$use_registry = xy; then
-   XENO_FUSE_CFLAGS=$fuse_cflags
-   XENO_USER_APP_LDFLAGS="$XENO_USER_APP_LDFLAGS $fuse_ldflags"
+   XENO_FUSE_CFLAGS=$FUSE_CFLAGS
+   XENO_USER_APP_LDFLAGS="$XENO_USER_APP_LDFLAGS $FUSE_LIBS"
 fi
 
 dnl Internal CFLAGS and LDFLAGS, may be enhanced per-arch below
-- 
1.7.10.4


