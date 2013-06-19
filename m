Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <6e8df1d491e0641abf69.1371670715@BEANTN0L019720>
Date: Wed, 19 Jun 2013 21:38:35 +0200
From: Thomas De Schampheleire <patrickdepinguin@gmail.com>
Subject: [Xenomai] [PATCH] xeno-config: remove duplicate include flags,
 already present in XENO_BASE_CFLAGS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: Thomas De Schampheleire <thomas.de.schampheleire@gmail.com>

---
 scripts/xeno-config-cobalt.in  |  6 +++---
 scripts/xeno-config-mercury.in |  6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -13,10 +13,10 @@ XENO_VERSION="@PACKAGE_VERSION@"
 XENO_PREFIX="${staging}${prefix}"
 XENO_CC="@CC@"
 XENO_TARGET_ARCH="@XENO_TARGET_ARCH@"
-XENO_BASE_CFLAGS="-I${staging}${includedir} @XENO_USER_APP_CFLAGS@ -D__COBALT__"
+XENO_INCLUDE_DIR="${staging}${includedir}"
+XENO_BASE_CFLAGS="-I$XENO_INCLUDE_DIR @XENO_USER_APP_CFLAGS@ -D__COBALT__"
 XENO_POSIX_LDFLAGS="-L${staging}${libdir} -lcobalt -lpthread -lrt @XENO_USER_APP_LDFLAGS@"
 XENO_LIBRARY_DIR="${staging}${libdir}"
-XENO_INCLUDE_DIR="${staging}${includedir}"
 LD_FILE_OPTION="@LD_FILE_OPTION@"
 
 unset prefix exec_prefix libdir datadir datarootdir pkgdatadir includedir skin_list
@@ -111,7 +111,7 @@ while test $# -gt 0; do
 		echo "no skin specified, missing --skin before --cflags" 1>&2
 		exit 1
 	    fi
-	    cflags="$XENO_BASE_CFLAGS -I$XENO_INCLUDE_DIR/cobalt -I$XENO_INCLUDE_DIR"
+	    cflags="$XENO_BASE_CFLAGS -I$XENO_INCLUDE_DIR/cobalt"
 	    for skin in $skin_list; do
 		case "$skin" in
 		    posix|cobalt)
diff --git a/scripts/xeno-config-mercury.in b/scripts/xeno-config-mercury.in
--- a/scripts/xeno-config-mercury.in
+++ b/scripts/xeno-config-mercury.in
@@ -13,10 +13,10 @@ XENO_VERSION="@PACKAGE_VERSION@"
 XENO_PREFIX="${staging}${prefix}"
 XENO_CC="@CC@"
 XENO_TARGET_ARCH="@XENO_BUILD_STRING@"
-XENO_BASE_CFLAGS="-I${staging}${includedir} @XENO_USER_APP_CFLAGS@ -D__MERCURY__"
+XENO_INCLUDE_DIR="${staging}${includedir}"
+XENO_BASE_CFLAGS="-I$XENO_INCLUDE_DIR @XENO_USER_APP_CFLAGS@ -D__MERCURY__"
 XENO_BASE_LDFLAGS="-L${staging}${libdir} @XENO_USER_APP_LDFLAGS@ -lcopperplate -lpthread -lrt"
 XENO_LIBRARY_DIR="${staging}${libdir}"
-XENO_INCLUDE_DIR="${staging}${includedir}"
 
 unset prefix exec_prefix libdir datadir datarootdir pkgdatadir includedir skin_list
 
@@ -90,7 +90,7 @@ while test $# -gt 0; do
 		echo "no skin specified, missing --skin before --cflags" 1>&2
 		exit 1
 	    fi
-	    cflags="$XENO_BASE_CFLAGS -I$XENO_INCLUDE_DIR"
+	    cflags="$XENO_BASE_CFLAGS"
 	    for skin in $skin_list; do
 		case "$skin" in
 		    vxworks|psos|alchemy)

