From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 3/4] Add --with-kernelshark option
Date: Mon, 28 Feb 2022 00:40:54 -0500
Message-Id: <20220228054055.16112-4-hongzhan.chen@intel.com>
In-Reply-To: <20220228054055.16112-1-hongzhan.chen@intel.com>
References: <20220228054055.16112-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

option to build kernelshark related plugins

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 Makefile.am  |  6 ++++++
 configure.ac | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 604644277..9563f33ca 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -18,6 +18,11 @@ SUBDIRS += 		\
 	testsuite
 endif
 
+if BUILD_KERNELSHARK
+SUBDIRS +=		\
+	kernel-shark
+endif
+
 EXTRA_DIST = kernel debian
 
 DIST_SUBDIRS =		\
@@ -26,6 +31,7 @@ DIST_SUBDIRS =		\
 	doc		\
 	include		\
 	lib 		\
+	kernel-shark	\
 	scripts		\
 	testsuite	\
 	utils
diff --git a/configure.ac b/configure.ac
index 16cffd8f8..b2e233494 100644
--- a/configure.ac
+++ b/configure.ac
@@ -826,6 +826,20 @@ AC_ARG_WITH(demodir,
     ], [XENO_DEMO_DIR=$demodir])
 AC_MSG_RESULT($XENO_DEMO_DIR)
 
+xeno_build_kernelshark=false
+AC_MSG_CHECKING(build kernel-shark plugins)
+AC_ARG_WITH(kernelshark,
+    AS_HELP_STRING([--with-kernelshark],[build kernelshark related plugins]),
+    [
+	case "$withval" in
+	"" | y | ye | yes) xeno_build_kernelshark=true;;
+	n | no) xeno_build_kernelshark=false;;
+	esac
+    ], [xeno_build_kernelshark=false])
+AC_MSG_RESULT($xeno_build_kernelshark)
+
+AM_CONDITIONAL([BUILD_KERNELSHARK], [test x$xeno_build_kernelshark = xtrue])
+
 AC_MSG_CHECKING([for test source generation])
 AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
     [AC_MSG_RESULT(ok)], [AC_MSG_RESULT(failed)], [AC_MSG_RESULT(untestable)])
@@ -943,6 +957,8 @@ AC_CONFIG_FILES([ \
 	scripts/Makefile \
 	scripts/xeno-config:scripts/xeno-config-$rtcore_type.in \
 	scripts/xeno \
+	kernel-shark/Makefile \
+	kernel-shark/kernelshark/Makefile \
 	lib/Makefile \
 	lib/boilerplate/Makefile \
 	lib/boilerplate/init/Makefile \
-- 
2.17.1


