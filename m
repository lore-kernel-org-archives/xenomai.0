Message-ID: <507E9424.8060800@siemens.com>
Date: Wed, 17 Oct 2012 13:19:00 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] nucleus: Convert intrlock to a sleeping Linux lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

All users of this lock are supposed to run over Linux context already.
Moreover, latest I-pipe patches complain that ipipe_virtualize_irq is
called with the Xenomai domain stalled. So convert this lock to a
sleeping Linux variant to avoid that alarm.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ksrc/nucleus/intr.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index c75fcac..4747de1 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -39,7 +39,7 @@
 
 #define XNINTR_MAX_UNHANDLED	1000
 
-DEFINE_PRIVATE_XNLOCK(intrlock);
+static DEFINE_BINARY_SEMAPHORE(intrlock);
 
 #ifdef CONFIG_XENO_OPT_STATS
 xnintr_t nkclock;	     /* Only for statistics */
@@ -709,7 +709,6 @@ EXPORT_SYMBOL_GPL(xnintr_destroy);
 int xnintr_attach(xnintr_t *intr, void *cookie)
 {
 	int ret;
-	spl_t s;
 
 	trace_mark(xn_nucleus, irq_attach, "irq %u name %s",
 		   intr->irq, intr->name);
@@ -721,7 +720,7 @@ int xnintr_attach(xnintr_t *intr, void *cookie)
 	xnarch_set_irq_affinity(intr->irq, nkaffinity);
 #endif /* CONFIG_SMP */
 
-	xnlock_get_irqsave(&intrlock, s);
+	down(&intrlock);
 
 	if (__testbits(intr->flags, XN_ISR_ATTACHED)) {
 		ret = -EBUSY;
@@ -735,7 +734,7 @@ int xnintr_attach(xnintr_t *intr, void *cookie)
 	__setbits(intr->flags, XN_ISR_ATTACHED);
 	xnintr_stat_counter_inc();
 out:
-	xnlock_put_irqrestore(&intrlock, s);
+	up(&intrlock);
 
 	return ret;
 }
@@ -775,11 +774,10 @@ EXPORT_SYMBOL_GPL(xnintr_attach);
 int xnintr_detach(xnintr_t *intr)
 {
 	int ret;
-	spl_t s;
 
 	trace_mark(xn_nucleus, irq_detach, "irq %u", intr->irq);
 
-	xnlock_get_irqsave(&intrlock, s);
+	down(&intrlock);
 
 	if (!__testbits(intr->flags, XN_ISR_ATTACHED)) {
 		ret = -EINVAL;
@@ -794,7 +792,7 @@ int xnintr_detach(xnintr_t *intr)
 
 	xnintr_stat_counter_dec();
  out:
-	xnlock_put_irqrestore(&intrlock, s);
+	up(&intrlock);
 
 	return ret;
 }
@@ -920,13 +918,12 @@ int xnintr_query_next(int irq, xnintr_iterator_t *iterator, char *name_buf)
 	xnticks_t last_switch;
 	int cpu_no = iterator->cpu + 1;
 	int err = 0;
-	spl_t s;
 
 	if (cpu_no == xnarch_num_online_cpus())
 		cpu_no = 0;
 	iterator->cpu = cpu_no;
 
-	xnlock_get_irqsave(&intrlock, s);
+	down(&intrlock);
 
 	if (iterator->list_rev != xnintr_list_rev) {
 		err = -EAGAIN;
@@ -969,7 +966,7 @@ int xnintr_query_next(int irq, xnintr_iterator_t *iterator, char *name_buf)
 		iterator->prev = intr;
 
      unlock_and_exit:
-	xnlock_put_irqrestore(&intrlock, s);
+	up(&intrlock);
 
 	return err;
 }
@@ -983,7 +980,6 @@ static inline int format_irq_proc(unsigned int irq,
 				  struct xnvfile_regular_iterator *it)
 {
 	struct xnintr *intr;
-	spl_t s;
 
 	if (irq == XNARCH_TIMER_IRQ) {
 		xnvfile_puts(it, "         [timer]");
@@ -1005,7 +1001,7 @@ static inline int format_irq_proc(unsigned int irq,
 		return 0;
 	}
 
-	xnlock_get_irqsave(&intrlock, s);
+	down(&intrlock);
 
 	intr = xnintr_shirq_first(irq);
 	if (intr) {
@@ -1018,7 +1014,7 @@ static inline int format_irq_proc(unsigned int irq,
 		} while (intr);
 	}
 
-	xnlock_put_irqrestore(&intrlock, s);
+	up(&intrlock);
 
 	return 0;
 }
-- 
1.7.3.4

