From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 16 May 2017 15:50:36 +0200
Message-Id: <20170516135036.16880-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH] scripts/xeno-config: add -Wl,--no-as-needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Linking with "--as-needed" could cause the linker to not list essential
wrapping libraries as needed for a shared library or a dynamically
linked binary. The result would be runtime ld.so errors for the binaries
or linking problems with the .so.
gcc defaults to "--no-as-needed" that is why we never needed to specify
that flag explicitly. But gcc from Ubuntu is patched to default to
"--as-needed".
This patch enforces "--no-as-needed", which will have no effect on most
toolchains. On Ubuntu it will override the default and make sure xenomai
applications get linked as expected.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 scripts/xeno-config-cobalt.in  | 1 +
 scripts/xeno-config-mercury.in | 1 +
 2 files changed, 2 insertions(+)

diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
index 82815e1936..ae313d3897 100644
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -282,6 +282,7 @@ if test x$do_ldflags = xy; then
 	fi
 	bootstrap="${XENO_LIBRARY_DIR}/xenomai/bootstrap${codegen}.o"
     fi
+    ldflags="-Wl,--no-as-needed $ldflags"
     echo "$ldflags $copperplate $bootstrap $wrap_main $XENO_POSIX_LDFLAGS"
 fi
 
diff --git a/scripts/xeno-config-mercury.in b/scripts/xeno-config-mercury.in
index a0aa75b737..2d2842f300 100644
--- a/scripts/xeno-config-mercury.in
+++ b/scripts/xeno-config-mercury.in
@@ -213,6 +213,7 @@ if test x$do_ldflags = xy; then
 	fi
 	bootstrap="${XENO_LIBRARY_DIR}/xenomai/bootstrap${codegen}.o"
     fi
+    ldflags="-Wl,--no-as-needed $ldflags"
     echo "$ldflags $copperplate $bootstrap $wrap_main $XENO_BASE_LDFLAGS"
 fi
 
-- 
2.13.0


