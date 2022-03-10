From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 1/4] build: Add c++ build support
Date: Thu, 10 Mar 2022 03:15:10 -0500
Message-Id: <20220310081513.12314-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com, florian.bezdeka@siemens.com

Add c++ build support or use specific c++ compiler

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/configure.ac b/configure.ac
index e7a170161..afe08b8f2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -79,6 +79,18 @@ AC_ARG_WITH(cc,
     ])
 AC_PROG_CC
 
+AC_ARG_WITH(cxx,
+    AS_HELP_STRING([--with-cxx=compiler],[use specific C++ compiler]),
+    [
+	case "$withval" in
+	"" | y | ye | yes | n | no)
+	    AC_MSG_ERROR([You must supply an argument to --with-cxx])
+	  ;;
+	esac
+	CXX="$withval"
+    ])
+AC_PROG_CXX
+
 # Do not let autoconf set the default value of CFLAGS
 if $XENO_EMPTY_CFLAGS; then
 	CFLAGS=""
-- 
2.17.1


