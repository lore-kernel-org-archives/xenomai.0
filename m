From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/4] cobalt/pipe: pipeline: convert to abstract synthetic IRQ
 API
Date: Sun, 17 Jan 2021 16:25:01 +0100
Message-Id: <20210117152503.478765-2-rpm@xenomai.org>
In-Reply-To: <20210117152503.478765-1-rpm@xenomai.org>
References: <20210117152503.478765-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/pipe.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
index 8044c3ff7..9465fb2da 100644
--- a/kernel/cobalt/pipe.c
+++ b/kernel/cobalt/pipe.c
@@ -32,6 +32,7 @@
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/pipe.h>
+#include <pipeline/sirq.h>
 
 static int xnpipe_asyncsig = SIGIO;
 
@@ -145,7 +146,7 @@ static inline void xnpipe_dequeue_all(struct xnpipe_state *state, int mask)
 	__sigpending;							\
 })
 
-static void xnpipe_wakeup_proc(unsigned int virq, void *arg)
+static irqreturn_t xnpipe_wakeup_proc(int sirq, void *dev_id)
 {
 	struct xnpipe_state *state;
 	unsigned long rbits;
@@ -219,11 +220,13 @@ check_async:
 	}
 out:
 	xnlock_put_irqrestore(&nklock, s);
+
+	return IRQ_HANDLED;
 }
 
 static inline void xnpipe_schedule_request(void) /* hw IRQs off */
 {
-	ipipe_post_irq_root(xnpipe_wakeup_virq);
+	pipeline_post_sirq(xnpipe_wakeup_virq);
 }
 
 static inline ssize_t xnpipe_flush_bufq(void (*fn)(void *buf, void *xstate),
@@ -1157,17 +1160,13 @@ int xnpipe_mount(void)
 		return -EBUSY;
 	}
 
-	xnpipe_wakeup_virq = ipipe_alloc_virq();
-	if (xnpipe_wakeup_virq == 0) {
+	xnpipe_wakeup_virq = pipeline_create_inband_sirq(xnpipe_wakeup_proc);
+	if (xnpipe_wakeup_virq < 0) {
 		printk(XENO_ERR
 		       "unable to reserve synthetic IRQ for message pipes\n");
-		return -EBUSY;
+		return xnpipe_wakeup_virq;
 	}
 
-	ipipe_request_irq(ipipe_root_domain,
-			  xnpipe_wakeup_virq,
-			  xnpipe_wakeup_proc,
-			  NULL, NULL);
 	return 0;
 }
 
@@ -1175,9 +1174,7 @@ void xnpipe_umount(void)
 {
 	int i;
 
-	ipipe_free_irq(ipipe_root_domain,
-		       xnpipe_wakeup_virq);
-	ipipe_free_virq(xnpipe_wakeup_virq);
+	pipeline_delete_inband_sirq(xnpipe_wakeup_virq);
 
 	unregister_chrdev(XNPIPE_DEV_MAJOR, "rtpipe");
 
-- 
2.26.2


