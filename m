From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/2] net/proxy: fix non-rt signal overflow
Date: Fri, 29 Nov 2019 16:03:02 +0100
Message-Id: <20191129150303.11116-1-rpm@xenomai.org>
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

rtdm_nrtsig_pend() is based on ipipe_post_root_work(), which keeps a
copy of every request descriptor internally until it is consumed by
the secondary mode handler. Triggering rtdm_nrtsig_pend() every time a
packet is relayed from the stack to the virtual netdev may cause such
request buffer to overflow under pressure.

To address this issue, trigger the non-rt signal from
rtnetproxy_recv() only when the proxy RX queue transitions from empty
to non-empty as a result of enqueuing the next skb. To this end,
rtskb_queue_tail_check() is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/addons/proxy.c        |  4 ++--
 kernel/drivers/net/stack/include/rtskb.h | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addons/proxy.c
index 9b8d29924..0b3ec74fa 100644
--- a/kernel/drivers/net/addons/proxy.c
+++ b/kernel/drivers/net/addons/proxy.c
@@ -218,8 +218,8 @@ static void rtnetproxy_recv(struct rtskb *rtskb)
 		return;
 	}
 
-	rtskb_queue_tail(&rx_queue, rtskb);
-	rtdm_nrtsig_pend(&rtnetproxy_rx_signal);
+	if (rtskb_queue_tail_check(&rx_queue, rtskb))
+		rtdm_nrtsig_pend(&rtnetproxy_rx_signal);
 }
 
 /* ************************************************************************
diff --git a/kernel/drivers/net/stack/include/rtskb.h b/kernel/drivers/net/stack/include/rtskb.h
index d9839d6ab..8f0294fe3 100644
--- a/kernel/drivers/net/stack/include/rtskb.h
+++ b/kernel/drivers/net/stack/include/rtskb.h
@@ -438,6 +438,26 @@ static inline void rtskb_queue_tail(struct rtskb_queue *queue,
 	rtdm_lock_put_irqrestore(&queue->lock, context);
 }
 
+/***
+ *  rtskb_queue_tail_check - variant of rtskb_queue_tail
+ *          returning true on empty->non empty transition.
+ *  @queue: queue to use
+ *  @skb: buffer to queue
+ */
+static inline bool rtskb_queue_tail_check(struct rtskb_queue *queue,
+					  struct rtskb *skb)
+{
+	rtdm_lockctx_t context;
+	bool ret;
+
+	rtdm_lock_get_irqsave(&queue->lock, context);
+	ret = queue->first == NULL;
+	__rtskb_queue_tail(queue, skb);
+	rtdm_lock_put_irqrestore(&queue->lock, context);
+
+	return ret;
+}
+
 /***
  *  __rtskb_prio_queue_tail - insert a buffer at the prioritized queue tail
  *                            (w/o locks)
-- 
2.21.0


