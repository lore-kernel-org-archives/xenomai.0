From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/3] net/rtpc: fix non-rt signal overflow
Date: Sat, 30 Nov 2019 19:39:29 +0100
Message-Id: <20191130183929.11034-3-rpm@xenomai.org>
In-Reply-To: <20191130183929.11034-1-rpm@xenomai.org>
References: <20191130183929.11034-1-rpm@xenomai.org>
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

To address this issue, trigger the non-rt signal only when the call
completion queue transitions from empty to non-empty state.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/rtnet_rtpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/rtnet_rtpc.c b/kernel/drivers/net/stack/rtnet_rtpc.c
index 4fcf5589e..cd5f0546d 100644
--- a/kernel/drivers/net/stack/rtnet_rtpc.c
+++ b/kernel/drivers/net/stack/rtnet_rtpc.c
@@ -146,12 +146,15 @@ static inline struct rt_proc_call *rtpc_dequeue_pending_call(void)
 static inline void rtpc_queue_processed_call(struct rt_proc_call *call)
 {
 	rtdm_lockctx_t context;
+	bool trigger;
 
 	rtdm_lock_get_irqsave(&processed_calls_lock, context);
+	trigger = list_empty(&processed_calls);
 	list_add_tail(&call->list_entry, &processed_calls);
 	rtdm_lock_put_irqrestore(&processed_calls_lock, context);
 
-	rtdm_nrtsig_pend(&rtpc_nrt_signal);
+	if (trigger)
+		rtdm_nrtsig_pend(&rtpc_nrt_signal);
 }
 
 static inline struct rt_proc_call *rtpc_dequeue_processed_call(void)
-- 
2.21.0


