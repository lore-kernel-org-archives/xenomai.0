From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 09/16] net/stack: manager: ratelimit printk when dropping
 buffers
Date: Thu, 21 Mar 2019 18:13:23 +0100
Message-Id: <20190321171330.2073-10-rpm@xenomai.org>
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
 kernel/drivers/net/stack/stack_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/stack_mgr.c b/kernel/drivers/net/stack/stack_mgr.c
index 4059e7c4c..0e89900b5 100644
--- a/kernel/drivers/net/stack/stack_mgr.c
+++ b/kernel/drivers/net/stack/stack_mgr.c
@@ -113,7 +113,7 @@ void rtnetif_rx(struct rtskb *skb)
 	    );
 
 	if (unlikely(rtskb_fifo_insert_inirq(&rx.fifo, skb) < 0)) {
-		rtdm_printk("RTnet: dropping packet in %s()\n", __FUNCTION__);
+		rtdm_printk_ratelimited("RTnet: dropping packet in %s()\n", __FUNCTION__);
 		kfree_rtskb(skb);
 	}
 }
-- 
2.20.1


