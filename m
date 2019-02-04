From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 17/18] net/stack: fix assertion testing checksum init value
Date: Mon,  4 Feb 2019 11:56:46 +0100
Message-Id: <20190204105647.5034-18-rpm@xenomai.org>
In-Reply-To: <20190204105647.5034-1-rpm@xenomai.org>
References: <20190204105647.5034-1-rpm@xenomai.org>
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

---
 kernel/drivers/net/stack/include/rtskb.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtskb.h b/kernel/drivers/net/stack/include/rtskb.h
index a1793e9a8..2d95d6ff8 100644
--- a/kernel/drivers/net/stack/include/rtskb.h
+++ b/kernel/drivers/net/stack/include/rtskb.h
@@ -282,6 +282,9 @@ extern unsigned int rtskb_amount_max;   /* maximum number of allocated rtskbs */
 #ifdef CONFIG_XENO_DRIVERS_NET_CHECKED
 extern void rtskb_over_panic(struct rtskb *skb, int len, void *here);
 extern void rtskb_under_panic(struct rtskb *skb, int len, void *here);
+#define rtskb_checksum_none_assert(skb) (WARN_ON_ONCE(skb->ip_summed != CHECKSUM_NONE))
+#else
+#define rtskb_checksum_none_assert(skb) do { (void)skb; } while (0)
 #endif
 
 extern struct rtskb *rtskb_pool_dequeue(struct rtskb_pool *pool);
@@ -294,8 +297,6 @@ extern void kfree_rtskb(struct rtskb *skb);
 #define dev_kfree_rtskb(a)  kfree_rtskb(a)
 
 
-#define rtskb_checksum_none_assert(skb) (skb->ip_summed = CHECKSUM_NONE)
-
 static inline void rtskb_tx_timestamp(struct rtskb *skb)
 {
 	nanosecs_abs_t *ts = skb->xmit_stamp;
-- 
2.17.2


