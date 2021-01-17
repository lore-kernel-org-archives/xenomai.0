From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail v2 1/5] cobalt/pipe: drop dependency on APCs
Date: Sun, 17 Jan 2021 16:07:59 +0100
Message-Id: <20210117150803.477767-2-rpm@xenomai.org>
In-Reply-To: <20210117150803.477767-1-rpm@xenomai.org>
References: <20210117150803.477767-1-rpm@xenomai.org>
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

This patch starts a series aiming at dropping the (functionally
redundant) APC interface entirely.

APCs are a relic from the Dark Ages, with no upside compared to open
coded requests triggering virtual/synthetic IRQs to be handled by the
root domain. As a matter of fact, an APC does run as a client handler
of a synthetic IRQ under the hood.

With this change, all APCs will not be multiplexed over a single
synthetic IRQ anymore but each deferred procedure is going to be
assigned its own synthetic IRQ channel, which is hardly a problem
since we only have a couple of APCs to deal with, much fewer than the
number of synthetic IRQs available to us.

As a result, /proc/xenomai/apc will not be available for inspecting
the trigger count of synthetic interrupts used by the core
anymore. Since the I-pipe is on its way out, having this obscure
feature dropped in this context seems acceptable. However, the related
information will still be available to Dovetail-based builds directly
from /proc/interrupts, as synthetic IRQs are (mostly) regular
interrupts there.

Start with using a virtual/synthetic IRQ for kicking the wakeup
procedure for message pipes, dropping the dependency on APCs.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/pipe.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
index 0c83095ba..8044c3ff7 100644
--- a/kernel/cobalt/pipe.c
+++ b/kernel/cobalt/pipe.c
@@ -32,7 +32,6 @@
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/pipe.h>
-#include <cobalt/kernel/apc.h>
 
 static int xnpipe_asyncsig = SIGIO;
 
@@ -47,7 +46,7 @@ static LIST_HEAD(xnpipe_sleepq);
 
 static LIST_HEAD(xnpipe_asyncq);
 
-int xnpipe_wakeup_apc;
+static int xnpipe_wakeup_virq;
 
 static struct class *xnpipe_class;
 
@@ -146,7 +145,7 @@ static inline void xnpipe_dequeue_all(struct xnpipe_state *state, int mask)
 	__sigpending;							\
 })
 
-static void xnpipe_wakeup_proc(void *cookie)
+static void xnpipe_wakeup_proc(unsigned int virq, void *arg)
 {
 	struct xnpipe_state *state;
 	unsigned long rbits;
@@ -224,7 +223,7 @@ out:
 
 static inline void xnpipe_schedule_request(void) /* hw IRQs off */
 {
-	__xnapc_schedule(xnpipe_wakeup_apc);
+	ipipe_post_irq_root(xnpipe_wakeup_virq);
 }
 
 static inline ssize_t xnpipe_flush_bufq(void (*fn)(void *buf, void *xstate),
@@ -1153,14 +1152,22 @@ int xnpipe_mount(void)
 
 	if (register_chrdev(XNPIPE_DEV_MAJOR, "rtpipe", &xnpipe_fops)) {
 		printk(XENO_ERR
-		       "unable to reserve major #%d for message pipe support\n",
+		       "unable to reserve major #%d for message pipes\n",
 		       XNPIPE_DEV_MAJOR);
 		return -EBUSY;
 	}
 
-	xnpipe_wakeup_apc =
-	    xnapc_alloc("pipe_wakeup", &xnpipe_wakeup_proc, NULL);
+	xnpipe_wakeup_virq = ipipe_alloc_virq();
+	if (xnpipe_wakeup_virq == 0) {
+		printk(XENO_ERR
+		       "unable to reserve synthetic IRQ for message pipes\n");
+		return -EBUSY;
+	}
 
+	ipipe_request_irq(ipipe_root_domain,
+			  xnpipe_wakeup_virq,
+			  xnpipe_wakeup_proc,
+			  NULL, NULL);
 	return 0;
 }
 
@@ -1168,7 +1175,10 @@ void xnpipe_umount(void)
 {
 	int i;
 
-	xnapc_free(xnpipe_wakeup_apc);
+	ipipe_free_irq(ipipe_root_domain,
+		       xnpipe_wakeup_virq);
+	ipipe_free_virq(xnpipe_wakeup_virq);
+
 	unregister_chrdev(XNPIPE_DEV_MAJOR, "rtpipe");
 
 	for (i = 0; i < XNPIPE_NDEVS; i++)
-- 
2.26.2


