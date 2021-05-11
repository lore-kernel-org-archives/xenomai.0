From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 10/31] net/stack: manager: ratelimit printk when dropping
 buffers
Date: Tue, 11 May 2021 18:05:14 +0200
Message-Id: <20210511160535.26580-11-jean-baptiste.tredez@alstefgroup.com>
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
 kernel/drivers/net/stack/stack_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/stack_mgr.c b/kernel/drivers/net/stack/stack_mgr.c
index a7e22458a..482f665f2 100644
--- a/kernel/drivers/net/stack/stack_mgr.c
+++ b/kernel/drivers/net/stack/stack_mgr.c
@@ -111,7 +111,7 @@ void rtnetif_rx(struct rtskb *skb)
 	RTNET_ASSERT(skb->rtdev != NULL, return;);
 
 	if (unlikely(rtskb_fifo_insert_inirq(&rx.fifo, skb) < 0)) {
-		rtdm_printk("RTnet: dropping packet in %s()\n", __FUNCTION__);
+		rtdm_printk_ratelimited("RTnet: dropping packet in %s()\n", __FUNCTION__);
 		kfree_rtskb(skb);
 	}
 }
-- 
2.17.1


