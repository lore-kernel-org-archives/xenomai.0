From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/9] utils/can: prevent unterminated destination buffer with
 strncpy()
Date: Fri, 26 Oct 2018 16:08:17 +0200
Message-Id: <20181026140825.5251-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

GCC 8.x introduced -Wstringop-truncation to help detecting likely
unwanted outcomes of strncpy(dst, src, n), such as omitting the NUL
character into the destination buffer whenever n < sizeof(src).

Fix unsafe strncpy() calls when we do expect a null-terminated
destination buffer.
---
 utils/can/rtcanconfig.c | 7 ++++---
 utils/can/rtcanrecv.c   | 3 ++-
 utils/can/rtcansend.c   | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/utils/can/rtcanconfig.c b/utils/can/rtcanconfig.c
index a285ec73d..395e0368d 100644
--- a/utils/can/rtcanconfig.c
+++ b/utils/can/rtcanconfig.c
@@ -31,6 +31,7 @@
 #include <errno.h>
 #include <getopt.h>
 #include <sys/mman.h>
+#include <boilerplate/ancillaries.h>
 
 #include <rtdm/can.h>
 
@@ -81,7 +82,7 @@ static int string_to_ctrlmode(char *str)
 
 int main(int argc, char *argv[])
 {
-    char    ifname[16];
+    char    ifname[IFNAMSIZ];
     int     can_fd = -1;
     int     new_baudrate = -1;
     int     new_mode = -1;
@@ -159,8 +160,8 @@ int main(int argc, char *argv[])
 	return 0;
     }
 
-    strncpy(ifname, argv[optind], IFNAMSIZ);
-    strncpy(ifr.ifr_name, ifname, IFNAMSIZ);
+    namecpy(ifname, argv[optind]);
+    namecpy(ifr.ifr_name, ifname);
 
     if (optind == argc - 2) {   /* Get mode setting */
 	new_mode = string_to_mode(argv[optind + 1]);
diff --git a/utils/can/rtcanrecv.c b/utils/can/rtcanrecv.c
index 8155ab76d..71e68cc5c 100644
--- a/utils/can/rtcanrecv.c
+++ b/utils/can/rtcanrecv.c
@@ -7,6 +7,7 @@
 #include <getopt.h>
 
 #include <alchemy/task.h>
+#include <boilerplate/ancillaries.h>
 
 #include <rtdm/can.h>
 
@@ -248,7 +249,7 @@ int main(int argc, char **argv)
 	if (verbose)
 	    printf("interface %s\n", argv[optind]);
 
-	strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
+	namecpy(ifr.ifr_name, argv[optind]);
 	if (verbose)
 	    printf("s=%d, ifr_name=%s\n", s, ifr.ifr_name);
 
diff --git a/utils/can/rtcansend.c b/utils/can/rtcansend.c
index 4a692b3bf..bfa3054c2 100644
--- a/utils/can/rtcansend.c
+++ b/utils/can/rtcansend.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <getopt.h>
 
+#include <boilerplate/ancillaries.h>
 #include <alchemy/task.h>
 #include <alchemy/timer.h>
 
@@ -231,7 +232,7 @@ int main(int argc, char **argv)
 	    printf("Using loopback=%d\n", loopback);
     }
 
-    strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
+    namecpy(ifr.ifr_name, argv[optind]);
     if (verbose)
 	printf("s=%d, ifr_name=%s\n", s, ifr.ifr_name);
 
-- 
2.17.2


