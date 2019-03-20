From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 5/5] net/drivers: stack: remove unused assertion
Date: Wed, 20 Mar 2019 16:44:25 +0100
Message-Id: <20190320154425.30639-6-rpm@xenomai.org>
In-Reply-To: <20190320154425.30639-1-rpm@xenomai.org>
References: <20190320154425.30639-1-rpm@xenomai.org>
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

We have no more in-tree users for it.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 doc/asciidoc/MIGRATION.adoc              | 4 +---
 kernel/drivers/net/stack/include/rtskb.h | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/doc/asciidoc/MIGRATION.adoc b/doc/asciidoc/MIGRATION.adoc
index b4f95dc45..cf1346415 100644
--- a/doc/asciidoc/MIGRATION.adoc
+++ b/doc/asciidoc/MIGRATION.adoc
@@ -1129,8 +1129,7 @@ unsigned int rtskb_module_pool_init(struct rtskb_pool *pool,
     rtnetdev_priv(), rtdev_emerg(), rtdev_alert(), rtdev_crit(),
     rtdev_err(), rtdev_warn(), rtdev_notice(), rtdev_info(),
     rtdev_dbg(), rtdev_vdbg(), RTDEV_TX_OK, RTDEV_TX_BUSY,
-    rtskb_checksum_none_assert(), rtskb_tx_timestamp(). Their
-    declarations are equivalent to:
+    rtskb_tx_timestamp(). Their declarations are equivalent to:
 
 -----------------------------------------------------------------------
 #define RTDEV_TX_OK	0
@@ -1148,7 +1147,6 @@ void rtdev_info(struct rntet_device *dev, const char *format, ...);
 void rtdev_dbg(struct rntet_device *dev, const char *format, ...);
 void rtdev_vdbg(struct rntet_device *dev, const char *format, ...);
 
-void rtskb_checksum_non_assert(struct rtskb *skb);
 void rtskb_tx_timestamp(struct rtskb *skb);
 -----------------------------------------------------------------------
 
diff --git a/kernel/drivers/net/stack/include/rtskb.h b/kernel/drivers/net/stack/include/rtskb.h
index a1793e9a8..0f7e0bff2 100644
--- a/kernel/drivers/net/stack/include/rtskb.h
+++ b/kernel/drivers/net/stack/include/rtskb.h
@@ -294,8 +294,6 @@ extern void kfree_rtskb(struct rtskb *skb);
 #define dev_kfree_rtskb(a)  kfree_rtskb(a)
 
 
-#define rtskb_checksum_none_assert(skb) (skb->ip_summed = CHECKSUM_NONE)
-
 static inline void rtskb_tx_timestamp(struct rtskb *skb)
 {
 	nanosecs_abs_t *ts = skb->xmit_stamp;
-- 
2.20.1


