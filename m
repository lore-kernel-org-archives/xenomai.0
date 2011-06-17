Message-ID: <4DFB1DC3.80203@domain.hid>
Date: Fri, 17 Jun 2011 11:26:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] nucleus: Fix interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Our current interrupt handlers assume that they leave over the same task
and CPU they entered. But CONFIG_XENO_HW_UNLOCKED_SWITCH and commit
f6af9b831c broke this assumption: xnpod_schedule invoked from the
handler tail can now actually trigger a domain migration, and that can
also include a CPU migration. This causes subtle corruptions as invalid
xnstat_exectime_t objects may be restored and - even worse - we may
improperly flush XNHTICK of the old CPU, leaving Linux timer-wise dead
there (as happened to us).

Fix this by moving XNHTICK replay and exectime accounting before the
scheduling point. Note that this introduces a tiny imprecision in the
accounting.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

This is also 2.5 material.

 ksrc/nucleus/intr.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index 3769949..fd3679a 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -116,10 +116,6 @@ void xnintr_clock_handler(void)
 	xnstat_exectime_lazy_switch(sched,
 		&nkclock.stat[xnsched_cpu(sched)].account, start);
 
-	if (--sched->inesting == 0) {
-		__clrbits(sched->lflags, XNINIRQ);
-		xnpod_schedule();
-	}
 	/*
 	 * If the clock interrupt preempted a real-time thread, any
 	 * transition to the root thread has already triggered a host
@@ -131,8 +127,14 @@ void xnintr_clock_handler(void)
 	    xnthread_test_state(sched->curr, XNROOT))
 		xnintr_host_tick(sched);
 
-	trace_mark(xn_nucleus, irq_exit, "irq %u", XNARCH_TIMER_IRQ);
 	xnstat_exectime_switch(sched, prev);
+
+	if (--sched->inesting == 0) {
+		__clrbits(sched->lflags, XNINIRQ);
+		xnpod_schedule();
+	}
+
+	trace_mark(xn_nucleus, irq_exit, "irq %u", XNARCH_TIMER_IRQ);
 }
 
 /* Optional support for shared interrupts. */
@@ -219,13 +221,14 @@ static void xnintr_shirq_handler(unsigned irq, void *cookie)
 	else if (!(s & XN_ISR_NOENABLE))
 		xnarch_end_irq(irq);
 
+	xnstat_exectime_switch(sched, prev);
+
 	if (--sched->inesting == 0) {
 		__clrbits(sched->lflags, XNINIRQ);
 		xnpod_schedule();
 	}
 
 	trace_mark(xn_nucleus, irq_exit, "irq %u", irq);
-	xnstat_exectime_switch(sched, prev);
 }
 
 /*
@@ -302,12 +305,14 @@ static void xnintr_edge_shirq_handler(unsigned irq, void *cookie)
 	else if (!(s & XN_ISR_NOENABLE))
 		xnarch_end_irq(irq);
 
+	xnstat_exectime_switch(sched, prev);
+
 	if (--sched->inesting == 0) {
 		__clrbits(sched->lflags, XNINIRQ);
 		xnpod_schedule();
 	}
+
 	trace_mark(xn_nucleus, irq_exit, "irq %u", irq);
-	xnstat_exectime_switch(sched, prev);
 }
 
 static inline int xnintr_irq_attach(xnintr_t *intr)
@@ -492,13 +497,14 @@ static void xnintr_irq_handler(unsigned irq, void *cookie)
 	else if (!(s & XN_ISR_NOENABLE))
 		xnarch_end_irq(irq);
 
+	xnstat_exectime_switch(sched, prev);
+
 	if (--sched->inesting == 0) {
 		__clrbits(sched->lflags, XNINIRQ);
 		xnpod_schedule();
 	}
 
 	trace_mark(xn_nucleus, irq_exit, "irq %u", irq);
-	xnstat_exectime_switch(sched, prev);
 }
 
 int __init xnintr_mount(void)
-- 
1.7.1

