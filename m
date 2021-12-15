From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] xeno-config: Fix reporting of system information on Dovetail
 kernels
Message-ID: <af8b3ec5-edbf-b0c3-a46a-4e858905d419@siemens.com>
Date: Wed, 15 Dec 2021 18:29:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Presence of /proc/ipipe is no longer a precondition for Xenomai.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/xeno-config-cobalt.in | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
index cd55ad82c7..9f60e90bb3 100644
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -73,17 +73,15 @@ dump_info ()
 	test x"$_version" = x || version="$_version"
     fi
     echo "Xenomai version: ${version}"
+    uname -a 2>/dev/null || echo "Cannot determine system information (uname?)"
+    echo "Kernel parameters: `cat /proc/cmdline`"
     if test -r /proc/ipipe/version; then
-	uname -a 2>/dev/null || echo "Cannot determine system information (uname?)"
-	echo "Kernel parameters: `cat /proc/cmdline`"
 	echo "I-pipe release #`cat /proc/ipipe/version` detected"
-	if test -r /proc/xenomai/version; then
-	    echo "Cobalt core `cat /proc/xenomai/version` detected"
-	else
-	    echo "Cobalt core disabled on this system"
-	fi
+    fi
+    if test -r /proc/xenomai/version; then
+	echo "Cobalt core `cat /proc/xenomai/version` detected"
     else
-	    echo "Cobalt core is NOT present on this system"
+	echo "Cobalt core disabled or not present on this system"
     fi
     echo "Compiler: @XENO_BUILD_COMPILER@"
     eval echo "Build args: @XENO_BUILD_ARGS@"
-- 
2.31.1

