From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2 5/7] drivers/net: wrap csum_partial_copy_nocheck()
Date: Sat, 27 Mar 2021 11:19:10 +0100
Message-Id: <20210327101912.2291474-6-rpm@xenomai.org>
In-Reply-To: <20210327101912.2291474-1-rpm@xenomai.org>
References: <20210327101912.2291474-1-rpm@xenomai.org>
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
architectures.

Nevertheless, the current ICMP code does expect a non-zero csum seed
to be used in the next computation, so let's wrap net_csum_copy() to
csum_partial_copy_nocheck() for pre-5.9 kernels, and open code it for
later kernels so that we still feed csum_partial() with the user-given
csum. We still expect the x86, ARM and arm64 implementations of
csum_partial() to do the right thing.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../include/asm-generic/xenomai/wrappers.h     | 11 +++++++++++
 kernel/drivers/net/stack/ipv4/icmp.c           | 18 +++++++++---------
 kernel/drivers/net/stack/rtskb.c               |  3 +--
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index cc0cb0896..cfd28fc47 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -209,4 +209,15 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,9,0)
+#define net_csum_copy(__src, __dst, __len, __csum)	\
+	csum_partial_copy_nocheck(__src, __dst, __len, __csum)
+#else
+#define net_csum_copy(__src, __dst, __len, __csum)			\
+	({								\
+		memcpy(__dst, __src, __len);				\
+		csum_partial(__dst, __len, (__force __wsum)__csum);	\
+	})
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
index b723040aa..0671cbc93 100644
--- a/kernel/drivers/net/stack/ipv4/icmp.c
+++ b/kernel/drivers/net/stack/ipv4/icmp.c
@@ -142,9 +142,9 @@ static int rt_icmp_glue_reply_bits(const void *p, unsigned char *to,
 	if (offset != 0)
 		return -EMSGSIZE;
 
-	csum = csum_partial_copy_nocheck((void *)&icmp_param->head, to,
-					 icmp_param->head_len,
-					 icmp_param->csum);
+	csum = net_csum_copy((void *)&icmp_param->head, to,
+			     icmp_param->head_len,
+			     icmp_param->csum);
 
 	csum = rtskb_copy_and_csum_bits(icmp_param->data.skb,
 					icmp_param->offset,
@@ -259,13 +259,13 @@ static int rt_icmp_glue_request_bits(const void *p, unsigned char *to,
 			    __FUNCTION__);
 		return -1;);
 
-	csum = csum_partial_copy_nocheck((void *)&icmp_param->head, to,
-					 icmp_param->head_len,
-					 icmp_param->csum);
+	csum = net_csum_copy((void *)&icmp_param->head, to,
+			     icmp_param->head_len,
+			     icmp_param->csum);
 
-	csum = csum_partial_copy_nocheck(icmp_param->data.buf,
-					 to + icmp_param->head_len,
-					 fraglen - icmp_param->head_len, csum);
+	csum = net_csum_copy(icmp_param->data.buf,
+			     to + icmp_param->head_len,
+			     fraglen - icmp_param->head_len, csum);
 
 	icmph = (struct icmphdr *)to;
 
diff --git a/kernel/drivers/net/stack/rtskb.c b/kernel/drivers/net/stack/rtskb.c
index 84d021d24..0d0c66e58 100644
--- a/kernel/drivers/net/stack/rtskb.c
+++ b/kernel/drivers/net/stack/rtskb.c
@@ -69,8 +69,7 @@ unsigned int rtskb_copy_and_csum_bits(const struct rtskb *skb, int offset,
 	if ((copy = skb->len - offset) > 0) {
 		if (copy > len)
 			copy = len;
-		csum = csum_partial_copy_nocheck(skb->data + offset, to, copy,
-						 csum);
+		csum = net_csum_copy(skb->data + offset, to, copy, csum);
 		if ((len -= copy) == 0)
 			return csum;
 		offset += copy;
-- 
2.29.2


