From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v7 1/3] build: add options to build plugins of kernelshark and
 libtraceevent
Date: Sat, 12 Mar 2022 14:00:00 +0100
Message-ID: <0b26bd28e2bfca49a4e7582be9f01e74bd74c409.1647090002.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1647090002.git.jan.kiszka@siemens.com>
References: <cover.1647090002.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Hongzhan Chen <hongzhan.chen@intel.com>

To build plugins of kernelshark and libtraceevent, add options and
do necessary configuration.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
[Jan: cleaned up AC_ARG_ENABLE matches, add missing kshark dep, drop INSTALLDIRs]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/configure.ac b/configure.ac
index 16cffd8f81..ef450aa582 100644
--- a/configure.ac
+++ b/configure.ac
@@ -91,6 +91,8 @@ AC_ARG_WITH(cxx,
     ])
 AC_PROG_CXX
 
+PKG_PROG_PKG_CONFIG
+
 # Do not let autoconf set the default value of CFLAGS
 if $XENO_EMPTY_CFLAGS; then
 	CFLAGS=""
@@ -826,6 +828,37 @@ AC_ARG_WITH(demodir,
     ], [XENO_DEMO_DIR=$demodir])
 AC_MSG_RESULT($XENO_DEMO_DIR)
 
+kernelshark_plugin=
+AC_MSG_CHECKING(whether KernelShark plugin should be built)
+AC_ARG_ENABLE(kernelshark_plugin,
+	AS_HELP_STRING([--enable-kernelshark-plugin], [build KernelShark plugin]),
+	[case "$enableval" in
+	y | yes) kernelshark_plugin=y ;;
+	*) unset kernelshark_plugin ;;
+	esac])
+AC_MSG_RESULT(${kernelshark_plugin:-no})
+AM_CONDITIONAL(XENO_KSHARK_PLUGIN, [test x$kernelshark_plugin = xy])
+
+libtraceevent_plugin=
+AC_MSG_CHECKING(whether libtraceevent plugin should be built)
+AC_ARG_ENABLE(libtraceevent_plugin,
+	AS_HELP_STRING([--enable-libtraceevent-plugin], [build libtraceevent plugin]),
+	[case "$enableval" in
+	y | yes) libtraceevent_plugin=y ;;
+	*) unset libtraceevent_plugin ;;
+	esac])
+AC_MSG_RESULT(${libtraceevent_plugin:-no})
+AM_CONDITIONAL(XENO_LIBTRACEEVENT_PLUGIN, [test x$libtraceevent_plugin = xy])
+
+if test x$kernelshark_plugin = xy -o x$libtraceevent_plugin = xy; then
+	PKG_CHECK_MODULES(LIBTRACEEVENT, libtraceevent)
+fi
+
+if test x$kernelshark_plugin = xy; then
+	PKG_CHECK_MODULES(LIBKSHARK, libkshark)
+	PKG_CHECK_MODULES(LIBTRACEFS, libtracefs)
+fi
+
 AC_MSG_CHECKING([for test source generation])
 AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
     [AC_MSG_RESULT(ok)], [AC_MSG_RESULT(failed)], [AC_MSG_RESULT(untestable)])
-- 
2.34.1


