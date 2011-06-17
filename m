Message-ID: <4DFB1E0B.1070903@domain.hid>
Date: Fri, 17 Jun 2011 11:27:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH] nucleus: Prevent rescheduling while in
	xntbase_tick
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Based on code inspection, it looks like a timer handler triggering a
reschedule in the path xntbase_tick -> xntimer_tick_aperiodic /
xntimer_tick_periodic_inner -> handler can cause problems, e.g. a
reschedule before all expired timers were processed. The timer core is
usually run atomically from an interrupt handler, so better emulate an
IRQ context inside xntbase_tick by setting XNINIRQ.

This patch only affects users of xntbase_tick, ie. psos, vrtx and the
vxworks skin.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

If my analysis is correct, this is also 2.5 material.

 ksrc/nucleus/timebase.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/ksrc/nucleus/timebase.c b/ksrc/nucleus/timebase.c
index 6f7c02f..8f9af04 100644
--- a/ksrc/nucleus/timebase.c
+++ b/ksrc/nucleus/timebase.c
@@ -477,12 +477,16 @@ EXPORT_SYMBOL_GPL(xntbase_stop);
 
 void xntbase_tick(xntbase_t *base)
 {
+	struct xnsched_t *sched;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
 
 	trace_mark(xn_nucleus, tbase_tick, "base %s", base->name);
 
+	++sched->inesting;
+	__setbits(sched->lflags, XNINIRQ);
+
 	if (base == &nktbase)
 		xntimer_tick_aperiodic();
 	else {
@@ -490,6 +494,11 @@ void xntbase_tick(xntbase_t *base)
 		xntimer_tick_periodic_inner(slave);
 	}
 
+	if (--sched->inesting == 0) {
+		__clrbits(sched->lflags, XNINIRQ);
+		xnpod_schedule();
+	}
+
 	xnlock_put_irqrestore(&nklock, s);
 }
 EXPORT_SYMBOL_GPL(xntbase_tick);
-- 
1.7.1

