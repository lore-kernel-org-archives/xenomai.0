From: =?UTF-8?q?G=C3=B6kt=C3=BCrk=20Y=C3=BCksek?= <gokturk@gentoo.org>
Date: Fri, 14 Apr 2017 13:54:11 -0400
Message-Id: <20170414175411.11952-1-gokturk@gentoo.org>
Subject: [Xenomai] [PATCH v1] configure: fix the help string for demodir
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The help string uses '--with-demo' instead of '--with-demodir',
misinforming the user about the correct option to pass.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4792e46..d6354f1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -746,7 +746,7 @@ AC_MSG_RESULT($XENO_TEST_DIR)
 demodir='${exec_prefix}/demo'
 AC_MSG_CHECKING(location for demo programs)
 AC_ARG_WITH(demodir,
-    AS_HELP_STRING([--with-demo=<demo-program-dir>],[location for demo programs (defaults to $prefix/demo)]),
+    AS_HELP_STRING([--with-demodir=<demo-program-dir>],[location for demo programs (defaults to $prefix/demo)]),
     [
 	case "$withval" in
 	"" | y | ye | yes | n | no)
-- 
2.10.2


