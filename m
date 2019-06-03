From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH 2/2] xeno-config: dont unconditionally link libmodechk with
 cobalt
Date: Mon,  3 Jun 2019 16:32:28 +0200
Message-Id: <20190603143228.11528-2-norbert.lange@andritz.com>
In-Reply-To: <20190603143228.11528-1-norbert.lange@andritz.com>
References: <20190603143228.11528-1-norbert.lange@andritz.com>
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
To: xenomai@xenomai.org

Allow to build without linking to libmodechk.so.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 scripts/xeno-config-cobalt.in | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
index ae313d389..87d54fbf8 100644
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -15,7 +15,8 @@ XENO_CC="@CC@"
 XENO_TARGET_ARCH="@XENO_TARGET_ARCH@"
 XENO_INCLUDE_DIR="${staging}${includedir}"
 XENO_BASE_CFLAGS="-I$XENO_INCLUDE_DIR/cobalt -I$XENO_INCLUDE_DIR @XENO_USER_APP_CFLAGS@ -D__COBALT__"
-XENO_POSIX_LDFLAGS="-L${staging}${libdir} -lcobalt -lmodechk -lpthread -lrt @XENO_USER_APP_LDFLAGS@"
+XENO_COBALT_LDFLAGS="-L${staging}${libdir} -lcobalt"
+XENO_POSIX_LDFLAGS="-lpthread -lrt @XENO_USER_APP_LDFLAGS@"
 XENO_LIBRARY_DIR="${staging}${libdir}"
 LD_FILE_OPTION="@LD_FILE_OPTION@"
 
@@ -243,9 +244,11 @@ if test x$do_ldflags = xy; then
 	echo "no API specified, missing --skin before --ldflags" 1>&2
 	exit 1
     fi
+    lmodeck=
     ldflags=
     if test x$do_mode_check = xy; then
 	ldflags="`dump_wrappers modechk.wrappers`"
+	lmodeck=-lmodechk
     fi
     test x$compat = xy && ldflags="-ltrank $ldflags"
     copperplate=
@@ -283,7 +286,8 @@ if test x$do_ldflags = xy; then
 	bootstrap="${XENO_LIBRARY_DIR}/xenomai/bootstrap${codegen}.o"
     fi
     ldflags="-Wl,--no-as-needed $ldflags"
-    echo "$ldflags $copperplate $bootstrap $wrap_main $XENO_POSIX_LDFLAGS"
+    echo "$ldflags $copperplate $bootstrap $wrap_main $XENO_COBALT_LDFLAGS" \
+		"$lmodeck $XENO_POSIX_LDFLAGS"
 fi
 
 exit 0
-- 
2.20.1


