From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 25/31] utils/net: rtroute: add/del default route
Date: Tue, 11 May 2021 18:05:29 +0200
Message-Id: <20210511160535.26580-26-jean-baptiste.tredez@alstefgroup.com>
In-Reply-To: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 utils/net/rtroute.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/utils/net/rtroute.c b/utils/net/rtroute.c
index ef6b56ecf..42d526f9e 100644
--- a/utils/net/rtroute.c
+++ b/utils/net/rtroute.c
@@ -24,6 +24,7 @@
 
 #include <errno.h>
 #include <fcntl.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -37,9 +38,10 @@
 #include <ipv4_chrdev.h>
 
 
-int             f;
-struct ipv4_cmd cmd;
-struct in_addr  addr;
+static int             f;
+static struct ipv4_cmd cmd;
+static struct in_addr  addr;
+static bool default_route;
 
 
 /* help gcc a bit... */
@@ -52,8 +54,10 @@ void help(void)
         "\trtroute solicit <addr> dev <dev>\n"
         "\trtroute add <addr> <hwaddr> dev <dev>\n"
         "\trtroute add <addr> netmask <mask> gw <gw-addr>\n"
+        "\trtroute add default gw <gw-addr>\n"
         "\trtroute del <addr> [dev <dev>]\n"
         "\trtroute del <addr> netmask <mask>\n"
+        "\trtroute del default gw\n"
         "\trtroute get <addr> [dev <dev>]\n"
         "\trtroute -f <host-routes-file>\n"
         );
@@ -130,7 +134,18 @@ void route_add(int argc, char *argv[])
     int                 ret;
 
 
-    if (argc == 6) {
+    if (default_route) {
+        /*** add default route ***/
+        if (argc != 5 || strcmp(argv[3], "gw") != 0)
+            help();
+
+        cmd.args.addnet.gw_addr = INADDR_ANY;
+        cmd.args.addnet.net_mask = INADDR_ANY;
+        if (!inet_aton(argv[4], &addr))
+            help();
+        cmd.args.addnet.gw_addr = addr.s_addr;
+        ret = ioctl(f, IOC_RT_NET_ROUTE_ADD, &cmd);
+    } else if (argc == 6) {
         /*** add host route ***/
         if ((ether_aton_r(argv[3], &dev_addr) == NULL) ||
             (strcmp(argv[4], "dev") != 0))
@@ -271,7 +286,15 @@ void route_delete(int argc, char *argv[])
     int ret;
 
 
-    if (argc == 3) {
+    if (default_route) {
+        /*** delete default route ***/
+        if (argc != 4 || strcmp(argv[3], "gw") != 0)
+            help();
+
+	cmd.args.delnet.net_addr = INADDR_ANY;
+	cmd.args.delnet.net_mask = INADDR_ANY;
+	ret = ioctl(f, IOC_RT_NET_ROUTE_DELETE, &cmd);
+    } else if (argc == 3) {
         /*** delete host route ***/
         cmd.args.delhost.ip_addr = addr.s_addr;
 
@@ -374,8 +397,10 @@ int main(int argc, char *argv[])
     if (strcmp(argv[1], "-f") == 0)
         route_listadd(argv[2]);
 
-    /* second argument is now always an IP address */
-    if (!inet_aton(argv[2], &addr))
+    /* second argument is now either 'default' (for a gw) or an IP
+       address */
+    default_route = !strcmp(argv[2], "default");
+    if (!default_route && !inet_aton(argv[2], &addr))
         help();
 
     if (strcmp(argv[1], "solicit") == 0)
-- 
2.17.1


