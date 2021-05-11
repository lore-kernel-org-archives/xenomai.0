From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 11/31] net/ipv4: icmp: forward unused packets to proxy
Date: Tue, 11 May 2021 18:05:15 +0200
Message-Id: <20210511160535.26580-12-jean-baptiste.tredez@alstefgroup.com>
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

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/ipv4/icmp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
index 8485614ec..61c7db58c 100644
--- a/kernel/drivers/net/stack/ipv4/icmp.c
+++ b/kernel/drivers/net/stack/ipv4/icmp.c
@@ -37,6 +37,7 @@
 #include <ipv4_chrdev.h>
 #include <ipv4/icmp.h>
 #include <ipv4/ip_fragment.h>
+#include <ipv4/ip_input.h>
 #include <ipv4/ip_output.h>
 #include <ipv4/protocol.h>
 #include <ipv4/route.h>
@@ -130,6 +131,14 @@ void rt_icmp_cleanup_echo_requests(void)
  */
 static void rt_icmp_discard(struct rtskb *skb)
 {
+#ifdef CONFIG_XENO_DRIVERS_NET_ADDON_PROXY
+    if (rt_ip_fallback_handler) {
+        /* If a fallback handler for IP protocol has been installed,
+         * call it. */
+	__rtskb_push(skb, skb->nh.iph->ihl*4 + sizeof(struct icmphdr));
+        rt_ip_fallback_handler(skb);
+    }
+#endif
 }
 
 static int rt_icmp_glue_reply_bits(const void *p, unsigned char *to,
@@ -207,6 +216,7 @@ static void rt_icmp_echo_reply(struct rtskb *skb)
 		rtdm_lock_put_irqrestore(&echo_calls_lock, context);
 	} else {
 		rtdm_lock_put_irqrestore(&echo_calls_lock, context);
+		rt_icmp_discard(skb);
 		return;
 	}
 
@@ -420,8 +430,12 @@ static struct rt_icmp_control rt_icmp_pointers[NR_ICMP_TYPES + 1] = {
  */
 struct rtsocket *rt_icmp_dest_socket(struct rtskb *skb)
 {
+	if (!list_empty(&echo_calls)) {
 	rt_socket_reference(icmp_socket);
 	return icmp_socket;
+	}
+
+	return NULL;
 }
 
 /***
-- 
2.17.1


