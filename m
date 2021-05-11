From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 27/31] net/stack: igmp: resolve default multicast interface
Date: Tue, 11 May 2021 18:05:31 +0200
Message-Id: <20210511160535.26580-28-jean-baptiste.tredez@alstefgroup.com>
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

If INADDR_ANY is passed as the imr_interface address, attempt to
resolve the default multicast interface by finding a route to the
multicast address.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/ipv4/igmp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/igmp.c b/kernel/drivers/net/stack/ipv4/igmp.c
index 9568cedc7..cd193d699 100644
--- a/kernel/drivers/net/stack/ipv4/igmp.c
+++ b/kernel/drivers/net/stack/ipv4/igmp.c
@@ -342,9 +342,17 @@ void rt_ip_mc_dec_group(struct rtnet_device *rtdev, u32 addr)
 static struct rtnet_device *rt_ip_mc_find_dev(const struct ip_mreq *imr)
 {
     struct rtnet_device *rtdev = NULL;
-
-    if (imr->imr_interface.s_addr)
-	rtdev = rt_ip_dev_find(imr->imr_interface.s_addr);
+    struct dest_route rt;
+    int ret;
+
+    if (imr->imr_interface.s_addr != INADDR_ANY) {
+	    rtdev = rt_ip_dev_find(imr->imr_interface.s_addr);
+    } else {
+	    ret = rt_ip_route_output(&rt, imr->imr_multiaddr.s_addr,
+				    INADDR_ANY);
+	    if (!ret)
+		    rtdev = rt.rtdev;
+    }
 
     return rtdev;
 }
-- 
2.17.1


