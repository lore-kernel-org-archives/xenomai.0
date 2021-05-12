From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/7] drivers/net: checksum: convert to memcpy+csum
Date: Wed, 12 May 2021 12:05:52 +0200
Message-Id: <a6e9faa07fb02866db53a23cd7f377debc3bef30.1620813957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620813957.git.jan.kiszka@siemens.com>
References: <cover.1620813957.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

Since v5.9-rc1, csum_partial_copy_nocheck() forces a zero seed as its
last argument to csum_partial(). According to #cc44c17baf7f3, passing
a non-zero value would not even yield the proper result on some
architectures. However, other locations still expect a non-zero csum
seed to be used in the next computation.

Meanwhile, some benchmarking (*) revealed that folding copy and
checksum operations may not be as optimal as one would have thought
when the caches are under pressure, so we switch to a split version,
first memcpy() then csum_partial(), so as to always benefit from
memcpy() optimizations. As a bonus, we don't have to wrap calls to
csum_partial_copy_nocheck() to follow the kernel API change. Instead
we can provide a single implementation based on csum_partial() which
works with any kernel version.

(*) Below are benchmark figures of the csum_copy (folded) vs csum+copy
(split) performances in idle vs busy scenarios. Busy means
hackbench+dd loop streaming 128M in the background from zero -> null,
in order to badly trash the D-caches while the test runs. Three
different packet sizes are submitted to checksumming (32, 1024, 1500
bytes), all figures in nanosecs.

iMX6QP (Cortex A9)
------------------

=== idle

CSUM_COPY 32b: min=333, max=1333, avg=439
CSUM_COPY 1024b: min=1000, max=2000, avg=1045
CSUM_COPY 1500b: min=1333, max=2000, avg=1333
COPY+CSUM 32b: min=333, max=1333, avg=443
COPY+CSUM 1024b: min=1000, max=2334, avg=1345
COPY+CSUM 1500b: min=1666, max=2667, avg=1737

=== busy

CSUM_COPY 32b: min=333, max=4333, avg=466
CSUM_COPY 1024b: min=1000, max=5000, avg=1088
CSUM_COPY 1500b: min=1333, max=5667, avg=1393
COPY+CSUM 32b: min=333, max=1334, avg=454
COPY+CSUM 1024b: min=1000, max=2000, avg=1341
COPY+CSUM 1500b: min=1666, max=2666, avg=1745

C4 (Cortex A55)
---------------

=== idle

CSUM_COPY 32b: min=125, max=791, avg=130
CSUM_COPY 1024b: min=541, max=834, avg=550
CSUM_COPY 1500b: min=708, max=1875, avg=740
COPY+CSUM 32b: min=125, max=167, avg=133
COPY+CSUM 1024b: min=541, max=625, avg=553
COPY+CSUM 1500b: min=708, max=750, avg=730

=== busy

CSUM_COPY 32b: min=125, max=792, avg=133
CSUM_COPY 1024b: min=500, max=2000, avg=552
CSUM_COPY 1500b: min=708, max=1542, avg=744
COPY+CSUM 32b: min=125, max=375, avg=133
COPY+CSUM 1024b: min=500, max=709, avg=553
COPY+CSUM 1500b: min=708, max=916, avg=743

x86 (atom x5)
-------------

=== idle

CSUM_COPY 32b: min=67, max=590, avg=70
CSUM_COPY 1024b: min=245, max=385, avg=251
CSUM_COPY 1500b: min=343, max=521, avg=350
COPY+CSUM 32b: min=101, max=679, avg=117
COPY+CSUM 1024b: min=296, max=379, avg=298
COPY+CSUM 1500b: min=399, max=502, avg=404

== busy

CSUM_COPY 32b: min=65, max=709, avg=71
CSUM_COPY 1024b: min=243, max=702, avg=252
CSUM_COPY 1500b: min=340, max=1055, avg=351
COPY+CSUM 32b: min=100, max=665, avg=120
COPY+CSUM 1024b: min=295, max=669, avg=298
COPY+CSUM 1500b: min=399, max=686, avg=403

arm64 which has no folded csum_copy implementation makes the best of
using the split copy+csum path. All architectures seem to benefit from
optimized memcpy under load when it comes to the worst case execution
time. x86 is less prone to jittery under cache trashing than others as
usual, but even there, the max. figures for csum+copy in busy context
look pretty much on par with the csum_copy version. Therefore,
converting all users to csum+copy makes sense.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../net/stack/include/rtnet_checksum.h        | 19 +++++++++++++++++++
 kernel/drivers/net/stack/ipv4/icmp.c          | 19 ++++++++++---------
 kernel/drivers/net/stack/ipv4/tcp/tcp.c       |  7 ++++---
 kernel/drivers/net/stack/ipv4/udp/udp.c       | 10 +++++-----
 kernel/drivers/net/stack/rtskb.c              |  5 ++---
 5 files changed, 40 insertions(+), 20 deletions(-)
 create mode 100644 kernel/drivers/net/stack/include/rtnet_checksum.h

diff --git a/kernel/drivers/net/stack/include/rtnet_checksum.h b/kernel/drivers/net/stack/include/rtnet_checksum.h
new file mode 100644
index 0000000000..7c18413a8e
--- /dev/null
+++ b/kernel/drivers/net/stack/include/rtnet_checksum.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __RTNET_CHECKSUM_H_
+#define __RTNET_CHECKSUM_H_
+
+#include <linux/string.h>
+#include <net/checksum.h>
+
+#define rtnet_csum(__buf, __len, __csum)				\
+	({								\
+		csum_partial(__buf, __len, (__force __wsum)__csum);	\
+	})
+
+#define rtnet_csum_copy(__src, __dst, __len, __csum)			\
+	({								\
+		memcpy(__dst, __src, __len);				\
+		csum_partial(__dst, __len, (__force __wsum)__csum);	\
+	})
+
+#endif /* !__RTNET_CHECKSUM_H_ */
diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
index 7f2248515f..8485614eca 100644
--- a/kernel/drivers/net/stack/ipv4/icmp.c
+++ b/kernel/drivers/net/stack/ipv4/icmp.c
@@ -33,6 +33,7 @@
 
 #include <rtskb.h>
 #include <rtnet_socket.h>
+#include <rtnet_checksum.h>
 #include <ipv4_chrdev.h>
 #include <ipv4/icmp.h>
 #include <ipv4/ip_fragment.h>
@@ -142,9 +143,9 @@ static int rt_icmp_glue_reply_bits(const void *p, unsigned char *to,
 	if (offset != 0)
 		return -EMSGSIZE;
 
-	csum = csum_partial_copy_nocheck((void *)&icmp_param->head, to,
-					 icmp_param->head_len,
-					 icmp_param->csum);
+	csum = rtnet_csum_copy((void *)&icmp_param->head, to,
+			       icmp_param->head_len,
+			       icmp_param->csum);
 
 	csum = rtskb_copy_and_csum_bits(icmp_param->data.skb,
 					icmp_param->offset,
@@ -259,13 +260,13 @@ static int rt_icmp_glue_request_bits(const void *p, unsigned char *to,
 			    __FUNCTION__);
 		return -1;);
 
-	csum = csum_partial_copy_nocheck((void *)&icmp_param->head, to,
-					 icmp_param->head_len,
-					 icmp_param->csum);
+	csum = rtnet_csum_copy((void *)&icmp_param->head, to,
+			       icmp_param->head_len,
+			       icmp_param->csum);
 
-	csum = csum_partial_copy_nocheck(icmp_param->data.buf,
-					 to + icmp_param->head_len,
-					 fraglen - icmp_param->head_len, csum);
+	csum = rtnet_csum_copy(icmp_param->data.buf,
+			       to + icmp_param->head_len,
+			       fraglen - icmp_param->head_len, csum);
 
 	icmph = (struct icmphdr *)to;
 
diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 08753e48ab..71628ba039 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -34,6 +34,7 @@
 #include <rtskb.h>
 #include <rtdev.h>
 #include <rtnet_port.h>
+#include <rtnet_checksum.h>
 #include <ipv4/tcp.h>
 #include <ipv4/ip_sock.h>
 #include <ipv4/ip_output.h>
@@ -637,10 +638,10 @@ static void rt_tcp_build_header(struct tcp_socket *ts, struct rtskb *skb,
 	th->urg_ptr = 0;
 
 	/* compute checksum */
-	wcheck = csum_partial(th, tcphdrlen, 0);
+	wcheck = rtnet_csum(th, tcphdrlen, 0);
 
 	if (skb->len - tcphdrlen - iphdrlen) {
-		wcheck = csum_partial(skb->data + tcphdrlen + iphdrlen,
+		wcheck = rtnet_csum(skb->data + tcphdrlen + iphdrlen,
 				      skb->len - tcphdrlen - iphdrlen, wcheck);
 	}
 
@@ -831,7 +832,7 @@ static struct rtsocket *rt_tcp_dest_socket(struct rtskb *skb)
 	u32 data_len;
 
 	if (tcp_v4_check(skb->len, saddr, daddr,
-			 csum_partial(skb->data, skb->len, 0))) {
+			 rtnet_csum(skb->data, skb->len, 0))) {
 		rtdm_printk("rttcp: invalid TCP packet checksum, dropped\n");
 		return NULL; /* Invalid checksum, drop the packet */
 	}
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 56cc35c7e4..6fe1aeb12e 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -29,11 +29,11 @@
 #include <linux/err.h>
 #include <linux/udp.h>
 #include <linux/tcp.h>
-#include <net/checksum.h>
 #include <linux/list.h>
 
 #include <rtskb.h>
 #include <rtnet_internal.h>
+#include <rtnet_checksum.h>
 #include <rtnet_port.h>
 #include <rtnet_iovec.h>
 #include <rtnet_socket.h>
@@ -548,12 +548,12 @@ static int rt_udp_getfrag(const void *p, unsigned char *to, unsigned int offset,
 
 	/* Checksum of the complete data part of the UDP message: */
 	ufh->wcheck =
-		csum_partial(to + sizeof(struct udphdr),
-			     fraglen - sizeof(struct udphdr), ufh->wcheck);
+		rtnet_csum(to + sizeof(struct udphdr),
+			   fraglen - sizeof(struct udphdr), ufh->wcheck);
 
 	/* Checksum of the udp header: */
-	ufh->wcheck = csum_partial((unsigned char *)ufh, sizeof(struct udphdr),
-				   ufh->wcheck);
+	ufh->wcheck = rtnet_csum((unsigned char *)ufh, sizeof(struct udphdr),
+				 ufh->wcheck);
 
 	ufh->uh.check =
 		csum_tcpudp_magic(ufh->saddr, ufh->daddr, ntohs(ufh->uh.len),
diff --git a/kernel/drivers/net/stack/rtskb.c b/kernel/drivers/net/stack/rtskb.c
index 84d021d245..c9042db93c 100644
--- a/kernel/drivers/net/stack/rtskb.c
+++ b/kernel/drivers/net/stack/rtskb.c
@@ -23,7 +23,7 @@
 
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
-#include <net/checksum.h>
+#include <rtnet_checksum.h>
 
 #include <rtdev.h>
 #include <rtnet_internal.h>
@@ -69,8 +69,7 @@ unsigned int rtskb_copy_and_csum_bits(const struct rtskb *skb, int offset,
 	if ((copy = skb->len - offset) > 0) {
 		if (copy > len)
 			copy = len;
-		csum = csum_partial_copy_nocheck(skb->data + offset, to, copy,
-						 csum);
+		csum = rtnet_csum_copy(skb->data + offset, to, copy, csum);
 		if ((len -= copy) == 0)
 			return csum;
 		offset += copy;
-- 
2.26.2


