From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 19/31] utils/net: ping: display min and average round-trip time
Date: Tue, 11 May 2021 18:05:23 +0200
Message-Id: <20210511160535.26580-20-jean-baptiste.tredez@alstefgroup.com>
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

From: Christophe Carton <christophe.carton@ixblue.com>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 utils/net/rtping.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/utils/net/rtping.c b/utils/net/rtping.c
index bdaf6cb15..878fa6dce 100644
--- a/utils/net/rtping.c
+++ b/utils/net/rtping.c
@@ -29,6 +29,7 @@
 #include <signal.h>
 #include <string.h>
 #include <unistd.h>
+#include <float.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
@@ -46,7 +47,9 @@ unsigned int    count    = 0;
 int             delay    = 1000;
 unsigned int    sent     = 0;
 unsigned int    received = 0;
-float           wc_rtt   = 0;
+float           max_rtt   = FLT_MIN;
+float           min_rtt   = FLT_MAX;
+float           avr_rtt   = 0.0f;
 
 
 void help(void)
@@ -81,9 +84,9 @@ void print_statistics()
 {
     printf("\n--- %s rtping statistics ---\n"
            "%d packets transmitted, %d received, %d%% packet loss\n"
-           "worst case rtt = %.1f us\n",
+           "rtt min/avg/max = %.1f/%.1f/%.1f us\n",
            inet_ntoa(addr), sent, received, 100 - ((received * 100) / sent),
-           wc_rtt);
+           min_rtt, avr_rtt/received, max_rtt);
     exit(0);
 }
 
@@ -117,8 +120,11 @@ void ping(int signal)
     received++;
     from.s_addr = cmd.args.ping.ip_addr;
     rtt = (float)cmd.args.ping.rtt / (float)1000;
-    if (rtt > wc_rtt)
-        wc_rtt = rtt;
+    if (rtt > max_rtt)
+        max_rtt = rtt;
+    if (rtt < min_rtt)
+        min_rtt = rtt;
+    avr_rtt += rtt;
     printf("%d bytes from %s: icmp_seq=%d time=%.1f us\n",
            ret, inet_ntoa(from), cmd.args.ping.sequence, rtt);
 
-- 
2.17.1


