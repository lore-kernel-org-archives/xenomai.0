From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 10/16] net/ipv4: icmp: forward unused packets to proxy
Date: Thu, 21 Mar 2019 18:13:24 +0100
Message-Id: <20190321171330.2073-11-rpm@xenomai.org>
In-Reply-To: <20190321171330.2073-1-rpm@xenomai.org>
References: <20190321171330.2073-1-rpm@xenomai.org>
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
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/ipv4/icmp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
index 68489709c..556fee869 100644
--- a/kernel/drivers/net/stack/ipv4/icmp.c
+++ b/kernel/drivers/net/stack/ipv4/icmp.c
@@ -36,6 +36,7 @@
 #include <ipv4_chrdev.h>
 #include <ipv4/icmp.h>
 #include <ipv4/ip_fragment.h>
+#include <ipv4/ip_input.h>
 #include <ipv4/ip_output.h>
 #include <ipv4/protocol.h>
 #include <ipv4/route.h>
@@ -129,6 +130,14 @@ void rt_icmp_cleanup_echo_requests(void)
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
 
@@ -407,8 +417,12 @@ static struct rt_icmp_control rt_icmp_pointers[NR_ICMP_TYPES + 1] = {
  */
 struct rtsocket *rt_icmp_dest_socket(struct rtskb *skb)
 {
-	rt_socket_reference(icmp_socket);
-	return icmp_socket;
+	if (!list_empty(&echo_calls)) {
+	   rt_socket_reference(icmp_socket);
+	   return icmp_socket;
+	}
+
+	return NULL;
 }
 
 /***
-- 
2.20.1


