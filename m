From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH] net/cap: fix non-rt signal overflow
Date: Mon,  2 Dec 2019 16:18:10 +0100
Message-Id: <20191202151810.4743-1-rpm@xenomai.org>
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
packet is relayed from the stack to the tap device may cause such
request buffer to overflow under pressure.

To address this issue, trigger the non-rt signal only when the RX
queue transitions from empty to non-empty state as a result of
enqueuing the next skb.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/addons/cap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
index 4e0795e24..1e8644069 100644
--- a/kernel/drivers/net/addons/cap.c
+++ b/kernel/drivers/net/addons/cap.c
@@ -57,27 +57,32 @@ static struct tap_device_t {
 
 void rtcap_rx_hook(struct rtskb *rtskb)
 {
+	bool			trigger = false;
+
 	if ((rtskb->cap_comp_skb = rtskb_pool_dequeue(&cap_pool)) == 0) {
 		tap_device[rtskb->rtdev->ifindex].tap_dev_stats.rx_dropped++;
 		return;
 	}
 
-	if (cap_queue.first == NULL)
+	if (cap_queue.first == NULL) {
 		cap_queue.first = rtskb;
-	else
+		trigger = true;
+	} else
 		cap_queue.last->cap_next = rtskb;
 	cap_queue.last = rtskb;
 	rtskb->cap_next = NULL;
 
 	rtskb->cap_flags |= RTSKB_CAP_SHARED;
 
-	rtdm_nrtsig_pend(&cap_signal);
+	if (trigger)
+		rtdm_nrtsig_pend(&cap_signal);
 }
 
 int rtcap_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
 {
 	struct tap_device_t *tap_dev = &tap_device[rtskb->rtdev->ifindex];
 	rtdm_lockctx_t context;
+	bool trigger = false;
 
 	if ((rtskb->cap_comp_skb = rtskb_pool_dequeue(&cap_pool)) == 0) {
 		tap_dev->tap_dev_stats.rx_dropped++;
@@ -93,15 +98,17 @@ int rtcap_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
 
 	rtdm_lock_get_irqsave(&rtcap_lock, context);
 
-	if (cap_queue.first == NULL)
+	if (cap_queue.first == NULL) {
 		cap_queue.first = rtskb;
-	else
+		trigger = true;
+	} else
 		cap_queue.last->cap_next = rtskb;
 	cap_queue.last = rtskb;
 
 	rtdm_lock_put_irqrestore(&rtcap_lock, context);
 
-	rtdm_nrtsig_pend(&cap_signal);
+	if (trigger)
+		rtdm_nrtsig_pend(&cap_signal);
 
 	return tap_dev->orig_xmit(rtskb, rtdev);
 }
-- 
2.21.0


