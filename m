Message-ID: <50F96C89.8010004@siemens.com>
Date: Fri, 18 Jan 2013 16:38:49 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [CRITICAL PATCH] ipipe: Re-read domain context after IRQ
	processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

This fixes a nasty bug on SMP boxes: We may migrate to root in the
context of an IRQ handler, and then also to a different CPU. Therefore,
we must not use domain contexts read before the invocation but update
them afterward or use stable information like the domain reference.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

We are still facing stalled, unkillable RT processes despite this fix,
but at least the head domain status corruption (and related warnings)
seems to be gone now.

 kernel/ipipe/core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 68af0b3..6aa9572 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1173,18 +1173,19 @@ static void dispatch_irq_head(unsigned int irq) /* hw interrupts off */
 	head->irqs[irq].handler(irq, head->irqs[irq].cookie);
 	__ipipe_run_irqtail(irq);
 	hard_local_irq_disable();
+	p = ipipe_this_cpu_head_context();
 	__clear_bit(IPIPE_STALL_FLAG, &p->status);
 
 	/* Are we still running in the head domain? */
 	if (likely(__ipipe_current_context == p)) {
 		/* Did we enter this code over the head domain? */
-		if (old == p) {
+		if (old->domain == head) {
 			/* Yes, do immediate synchronization. */
 			if (__ipipe_ipending_p(p))
 				__ipipe_sync_stage();
 			return;
 		}
-		__ipipe_set_current_context(old);
+		__ipipe_set_current_context(ipipe_this_cpu_root_context());
 	}
 
 	/*
-- 
1.7.3.4

