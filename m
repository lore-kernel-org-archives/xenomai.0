Message-ID: <49A437ED.6070901@domain.hid>
Date: Tue, 24 Feb 2009 19:09:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] lttng: Update markers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Since LTTng for 2.6.27 (most recent release) trace_mark takes an
additional argument: channel. Split up the existing marker names
("channel_event") into this format ("channel, event") and provide
wrappers for older versions.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-generic/wrappers.h |   25 +++++++++++++--------
 include/nucleus/pod.h          |    2 +-
 include/rtdm/rtdm_driver.h     |   10 ++++----
 ksrc/nucleus/intr.c            |   28 ++++++++++++-----------
 ksrc/nucleus/pod.c             |   48 ++++++++++++++++++++--------------------
 ksrc/nucleus/sched.c           |    6 +++--
 ksrc/nucleus/shadow.c          |   23 ++++++++++---------
 ksrc/nucleus/synch.c           |   14 ++++++------
 ksrc/nucleus/timebase.c        |    8 +++----
 ksrc/nucleus/timer.c           |   20 ++++++++---------
 ksrc/skins/rtdm/core.c         |   26 ++++++++++++----------
 ksrc/skins/rtdm/device.c       |   10 ++++----
 ksrc/skins/rtdm/drvlib.c       |   19 ++++++++--------
 13 files changed, 125 insertions(+), 114 deletions(-)

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
index 5fdcd24..285948b 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -454,17 +454,24 @@ unsigned long find_next_bit(const unsigned long *addr,
 #define IRQF_SHARED			SA_SHIRQ
 #endif /* < 2.6.18 */
 
+#ifdef CONFIG_LTT
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,24)
-/* For pre-2.6.24 kernel with LTTng add-on. */
-#ifdef CONFIG_MARKERS
-#include <linux/marker.h>
-#define trace_mark(ev, fmt, args...)	MARK(ev, fmt , ##args)
-#else /* !CONFIG_MARKERS */
-#define trace_mark(ev, fmt, args...)	do { } while (0)
-#endif /* !CONFIG_MARKERS */
-#else /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24) */
+#define trace_mark(channel, ev, fmt, args...)	\
+	MARK(channel##_##ev, fmt , ##args)
+#else /* >= 2.6.24 */
 #include <linux/marker.h>
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24) */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+#undef trace_mark
+#define trace_mark(channel, ev, fmt, args...)	\
+	__trace_mark(0, channel##_##ev, NULL, fmt, ## args)
+#endif /* < 2.6.27 */
+#endif /* >= 2.6.24 */
+
+#else /* !CONFIG_LTT */
+#undef trace_mark
+#define trace_mark(channel, ev, fmt, args...)	do { } while (0)
+#endif /* !CONFIG_LTT */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,22)
 #define KMALLOC_MAX_SIZE 131072
diff --git a/include/nucleus/pod.h b/include/nucleus/pod.h
index 1b231c8..cd9bd2a 100644
--- a/include/nucleus/pod.h
+++ b/include/nucleus/pod.h
@@ -280,7 +280,7 @@ static inline void xnpod_run_hooks(struct xnqueue *q,
 				   struct xnthread *thread, const char *type)
 {
 	if (!emptyq_p(q) && !xnthread_test_state(thread, XNROOT)) {
-		trace_mark(xn_nucleus_thread_callout,
+		trace_mark(xn_nucleus, thread_callout,
 			   "thread %p thread_name %s hook %s",
 			   thread, xnthread_name(thread), type);
 		xnpod_fire_callouts(q, thread);
diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 330f011..d03a12c 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -1075,13 +1075,13 @@ void __rtdm_synch_flush(xnsynch_t *synch, unsigned long reason);
 
 static inline void rtdm_event_pulse(rtdm_event_t *event)
 {
-	trace_mark(xn_rtdm_event_pulse, "event %p", event);
+	trace_mark(xn_rtdm, event_pulse, "event %p", event);
 	__rtdm_synch_flush(&event->synch_base, 0);
 }
 
 static inline void rtdm_event_destroy(rtdm_event_t *event)
 {
-	trace_mark(xn_rtdm_event_destroy, "event %p", event);
+	trace_mark(xn_rtdm, event_destroy, "event %p", event);
 	__rtdm_synch_flush(&event->synch_base, XNRMID);
 	xnselect_destroy(&event->select_block);
 }
@@ -1110,7 +1110,7 @@ void rtdm_sem_up(rtdm_sem_t *sem);
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
 static inline void rtdm_sem_destroy(rtdm_sem_t *sem)
 {
-	trace_mark(xn_rtdm_sem_destroy, "sem %p", sem);
+	trace_mark(xn_rtdm, sem_destroy, "sem %p", sem);
 	__rtdm_synch_flush(&sem->synch_base, XNRMID);
 	xnselect_destroy(&sem->select_block);
 }
@@ -1132,7 +1132,7 @@ static inline void rtdm_mutex_unlock(rtdm_mutex_t *mutex)
 {
 	XENO_ASSERT(RTDM, !xnpod_asynch_p(), return;);
 
-	trace_mark(xn_rtdm_mutex_unlock, "mutex %p", mutex);
+	trace_mark(xn_rtdm, mutex_unlock, "mutex %p", mutex);
 
 	if (unlikely(xnsynch_release(&mutex->synch_base) != NULL))
 		xnpod_schedule();
@@ -1140,7 +1140,7 @@ static inline void rtdm_mutex_unlock(rtdm_mutex_t *mutex)
 
 static inline void rtdm_mutex_destroy(rtdm_mutex_t *mutex)
 {
-	trace_mark(xn_rtdm_mutex_destroy, "mutex %p", mutex);
+	trace_mark(xn_rtdm, mutex_destroy, "mutex %p", mutex);
 
 	__rtdm_synch_flush(&mutex->synch_base, XNRMID);
 }
diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index 1c530cc..870efb1 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -96,8 +96,8 @@ void xnintr_clock_handler(void)
 
 	xnarch_announce_tick();
 
-	trace_mark(xn_nucleus_irq_enter, "irq %u", XNARCH_TIMER_IRQ);
-	trace_mark(xn_nucleus_tbase_tick, "base %s", nktbase.name);
+	trace_mark(xn_nucleus, irq_enter, "irq %u", XNARCH_TIMER_IRQ);
+	trace_mark(xn_nucleus, tbase_tick, "base %s", nktbase.name);
 
 	++sched->inesting;
 	__setbits(sched->status, XNINIRQ);
@@ -125,7 +125,7 @@ void xnintr_clock_handler(void)
 		xnarch_relay_tick();
 	}
 
-	trace_mark(xn_nucleus_irq_exit, "irq %u", XNARCH_TIMER_IRQ);
+	trace_mark(xn_nucleus, irq_exit, "irq %u", XNARCH_TIMER_IRQ);
 	xnstat_exectime_switch(sched, prev);
 }
 
@@ -169,7 +169,7 @@ static void xnintr_shirq_handler(unsigned irq, void *cookie)
 
 	prev  = xnstat_exectime_get_current(sched);
 	start = xnstat_exectime_now();
-	trace_mark(xn_nucleus_irq_enter, "irq %u", irq);
+	trace_mark(xn_nucleus, irq_enter, "irq %u", irq);
 
 	++sched->inesting;
 	__setbits(sched->status, XNINIRQ);
@@ -218,7 +218,7 @@ static void xnintr_shirq_handler(unsigned irq, void *cookie)
 		xnpod_schedule();
 	}
 
-	trace_mark(xn_nucleus_irq_exit, "irq %u", irq);
+	trace_mark(xn_nucleus, irq_exit, "irq %u", irq);
 	xnstat_exectime_switch(sched, prev);
 }
 
@@ -238,7 +238,7 @@ static void xnintr_edge_shirq_handler(unsigned irq, void *cookie)
 
 	prev  = xnstat_exectime_get_current(sched);
 	start = xnstat_exectime_now();
-	trace_mark(xn_nucleus_irq_enter, "irq %u", irq);
+	trace_mark(xn_nucleus, irq_enter, "irq %u", irq);
 
 	++sched->inesting;
 	__setbits(sched->status, XNINIRQ);
@@ -300,7 +300,7 @@ static void xnintr_edge_shirq_handler(unsigned irq, void *cookie)
 		__clrbits(sched->status, XNINIRQ);
 		xnpod_schedule();
 	}
-	trace_mark(xn_nucleus_irq_exit, "irq %u", irq);
+	trace_mark(xn_nucleus, irq_exit, "irq %u", irq);
 	xnstat_exectime_switch(sched, prev);
 }
 
@@ -453,7 +453,7 @@ static void xnintr_irq_handler(unsigned irq, void *cookie)
 
 	prev  = xnstat_exectime_get_current(sched);
 	start = xnstat_exectime_now();
-	trace_mark(xn_nucleus_irq_enter, "irq %u", irq);
+	trace_mark(xn_nucleus, irq_enter, "irq %u", irq);
 
 	++sched->inesting;
 	__setbits(sched->status, XNINIRQ);
@@ -507,7 +507,7 @@ static void xnintr_irq_handler(unsigned irq, void *cookie)
 		xnpod_schedule();
 	}
 
-	trace_mark(xn_nucleus_irq_exit, "irq %u", irq);
+	trace_mark(xn_nucleus, irq_exit, "irq %u", irq);
 	xnstat_exectime_switch(sched, prev);
 }
 
@@ -715,7 +715,7 @@ int xnintr_attach(xnintr_t *intr, void *cookie)
 	int err;
 	spl_t s;
 
-	trace_mark(xn_nucleus_irq_attach, "irq %u name %s",
+	trace_mark(xn_nucleus, irq_attach, "irq %u name %s",
 		   intr->irq, intr->name);
 
 	intr->cookie = cookie;
@@ -773,7 +773,7 @@ int xnintr_detach(xnintr_t *intr)
 	int err;
 	spl_t s;
 
-	trace_mark(xn_nucleus_irq_detach, "irq %u", intr->irq);
+	trace_mark(xn_nucleus, irq_detach, "irq %u", intr->irq);
 
 	xnlock_get_irqsave(&intrlock, s);
 
@@ -815,7 +815,7 @@ EXPORT_SYMBOL_GPL(xnintr_detach);
 
 int xnintr_enable(xnintr_t *intr)
 {
-	trace_mark(xn_nucleus_irq_enable, "irq %u", intr->irq);
+	trace_mark(xn_nucleus, irq_enable, "irq %u", intr->irq);
 
 	return xnarch_enable_irq(intr->irq);
 }
@@ -847,7 +847,7 @@ EXPORT_SYMBOL_GPL(xnintr_enable);
 
 int xnintr_disable(xnintr_t *intr)
 {
-	trace_mark(xn_nucleus_irq_disable, "irq %u", intr->irq);
+	trace_mark(xn_nucleus, irq_disable, "irq %u", intr->irq);
 
 	return xnarch_disable_irq(intr->irq);
 }
@@ -874,7 +874,7 @@ EXPORT_SYMBOL_GPL(xnintr_disable);
 
 xnarch_cpumask_t xnintr_affinity(xnintr_t *intr, xnarch_cpumask_t cpumask)
 {
-	trace_mark(xn_nucleus_irq_affinity, "irq %u %lu",
+	trace_mark(xn_nucleus, irq_affinity, "irq %u %lu",
 		   intr->irq, *(unsigned long *)&cpumask);
 
 	return xnarch_set_irq_affinity(intr->irq, cpumask);
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 7811df5..014cd72 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -280,7 +280,7 @@ void xnpod_schedule_handler(void) /* Called with hw interrupts off. */
 {
 	xnsched_t *sched = xnpod_current_sched();
 
-	trace_mark(xn_nucleus_sched_remote, MARK_NOARGS);
+	trace_mark(xn_nucleus, sched_remote, MARK_NOARGS);
 #if defined(CONFIG_SMP) && defined(CONFIG_XENO_OPT_PRIOCPL)
 	if (testbits(sched->status, XNRPICK)) {
 		clrbits(sched->status, XNRPICK);
@@ -651,7 +651,7 @@ int xnpod_init_thread(struct xnthread *thread,
 	if (ret)
 		return ret;
 
-	trace_mark(xn_nucleus_thread_init,
+	trace_mark(xn_nucleus, thread_init,
 		   "thread %p thread_name %s flags %lu class %s prio %d",
 		   thread, xnthread_name(thread), attr->flags,
 		   sched_class->name, thread->cprio);
@@ -784,7 +784,7 @@ int xnpod_start_thread(struct xnthread *thread,
 	thread->entry = attr->entry;
 	thread->cookie = attr->cookie;
 
-	trace_mark(xn_nucleus_thread_start, "thread %p thread_name %s",
+	trace_mark(xn_nucleus, thread_start, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
@@ -891,7 +891,7 @@ void xnpod_stop_thread(struct xnthread *thread)
 		    xnpod_fatal("attempt to stop the root thread");
 		);
 
-	trace_mark(xn_nucleus_thread_stop, "thread %p thread_name %s",
+	trace_mark(xn_nucleus, thread_stop, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
 	xnlock_get_irqsave(&nklock, s);
@@ -943,7 +943,7 @@ void xnpod_restart_thread(xnthread_t *thread)
 		    xnpod_fatal("attempt to restart a user-space thread");
 		);
 
-	trace_mark(xn_nucleus_thread_restart, "thread %p thread_name %s",
+	trace_mark(xn_nucleus, thread_restart, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
 	if (!xnthread_test_state(thread, XNSTARTED))
@@ -1019,7 +1019,7 @@ xnflags_t xnpod_set_thread_mode(xnthread_t *thread,
 
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_thread_setmode,
+	trace_mark(xn_nucleus, thread_setmode,
 		   "thread %p thread_name %s clrmask %lu setmask %lu",
 		   thread, xnthread_name(thread), clrmask, setmask);
 
@@ -1151,7 +1151,7 @@ void xnpod_delete_thread(xnthread_t *thread)
 	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
-	trace_mark(xn_nucleus_thread_delete, "thread %p thread_name %s",
+	trace_mark(xn_nucleus, thread_delete, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
 	removeq(&nkpod->threadq, &thread->glink);
@@ -1352,7 +1352,7 @@ void xnpod_suspend_thread(xnthread_t *thread, xnflags_t mask,
 
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_thread_suspend,
+	trace_mark(xn_nucleus, thread_suspend,
 		   "thread %p thread_name %s mask %lu timeout %Lu "
 		   "timeout_mode %d wchan %p",
 		   thread, xnthread_name(thread), mask, timeout,
@@ -1553,7 +1553,7 @@ void xnpod_resume_thread(struct xnthread *thread, xnflags_t mask)
 
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_thread_resume,
+	trace_mark(xn_nucleus, thread_resume,
 		   "thread %p thread_name %s mask %lu",
 		   thread, xnthread_name(thread), mask);
 	xnarch_trace_pid(xnthread_user_task(thread) ?
@@ -1699,7 +1699,7 @@ int xnpod_unblock_thread(xnthread_t *thread)
 	 */
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_thread_unblock,
+	trace_mark(xn_nucleus, thread_unblock,
 		   "thread %p thread_name %s state %lu",
 		   thread, xnthread_name(thread),
 		   xnthread_state_flags(thread));
@@ -1813,7 +1813,7 @@ int __xnpod_set_thread_schedparam(struct xnthread *thread,
 
 	new_wprio = xnsched_weighted_cprio(thread);
 
-	trace_mark(xn_nucleus_set_thread_schedparam,
+	trace_mark(xn_nucleus, set_thread_schedparam,
 		   "thread %p thread_name %s class %s prio %d",
 		   thread, xnthread_name(thread),
 		   thread->sched_class->name, thread->cprio);
@@ -1912,7 +1912,7 @@ int xnpod_migrate_thread(int cpu)
 
 	sched = xnpod_sched_slot(cpu);
 
-	trace_mark(xn_nucleus_thread_migrate,
+	trace_mark(xn_nucleus, thread_migrate,
 		   "thread %p thread_name %s cpu %d",
 		   thread, xnthread_name(thread), cpu);
 
@@ -1966,7 +1966,7 @@ void xnpod_dispatch_signals(void)
 	    || thread->asr == XNTHREAD_INVALID_ASR)
 		return;
 
-	trace_mark(xn_nucleus_sched_sigdispatch, "signals %lu",
+	trace_mark(xn_nucleus, sched_sigdispatch, "signals %lu",
 		   thread->signals);
 
 	/* Start the asynchronous service routine */
@@ -2012,7 +2012,7 @@ void xnpod_welcome_thread(xnthread_t *thread, int imask)
 
 	xnsched_finalize_zombie(sched);
 
-	trace_mark(xn_nucleus_thread_boot, "thread %p thread_name %s",
+	trace_mark(xn_nucleus, thread_boot, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
 	xnarch_trace_pid(-1, xnthread_current_priority(thread));
@@ -2141,7 +2141,7 @@ void __xnpod_schedule(struct xnsched *sched)
 	if (xnarch_escalate())
 		return;
 
-	trace_mark(xn_nucleus_sched, MARK_NOARGS);
+	trace_mark(xn_nucleus, sched, MARK_NOARGS);
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -2165,7 +2165,7 @@ void __xnpod_schedule(struct xnsched *sched)
 
 	prev = curr;
 
-	trace_mark(xn_nucleus_sched_switch,
+	trace_mark(xn_nucleus, sched_switch,
 		   "prev %p prev_name %s "
 		   "next %p next_name %s",
 		   prev, xnthread_name(prev),
@@ -2367,7 +2367,7 @@ int xnpod_add_hook(int type, void (*routine) (xnthread_t *))
 
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_sched_addhook, "type %d routine %p",
+	trace_mark(xn_nucleus, sched_addhook, "type %d routine %p",
 		   type, routine);
 
 	switch (type) {
@@ -2439,7 +2439,7 @@ int xnpod_remove_hook(int type, void (*routine) (xnthread_t *))
 
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_sched_removehook, "type %d routine %p",
+	trace_mark(xn_nucleus, sched_removehook, "type %d routine %p",
 		   type, routine);
 
 	switch (type) {
@@ -2504,7 +2504,7 @@ int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo)
 
 	thread = xnpod_current_thread();
 
-	trace_mark(xn_nucleus_thread_fault,
+	trace_mark(xn_nucleus, thread_fault,
 		   "thread %p thread_name %s address %lu type %d",
 		   thread, xnthread_name(thread), xnarch_fault_pc(fltinfo),
 		   xnarch_fault_trap(fltinfo));
@@ -2634,7 +2634,7 @@ int xnpod_enable_timesource(void)
 		return err;
 	}
 
-	trace_mark(xn_nucleus_tbase_start, "base %s", nktbase.name);
+	trace_mark(xn_nucleus, tbase_start, "base %s", nktbase.name);
 
 #ifdef CONFIG_XENO_OPT_STATS
 	/*
@@ -2730,7 +2730,7 @@ void xnpod_disable_timesource(void)
 	spl_t s;
 	int cpu;
 
-	trace_mark(xn_nucleus_tbase_stop, "base %s", nktbase.name);
+	trace_mark(xn_nucleus, tbase_stop, "base %s", nktbase.name);
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -2822,7 +2822,7 @@ int xnpod_set_thread_periodic(xnthread_t *thread,
 
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_thread_setperiodic,
+	trace_mark(xn_nucleus, thread_setperiodic,
 		   "thread %p thread_name %s idate %Lu period %Lu timer %p",
 		   thread, xnthread_name(thread), idate, period,
 		   &thread->ptimer);
@@ -2930,7 +2930,7 @@ int xnpod_wait_thread_period(unsigned long *overruns_r)
 		goto unlock_and_exit;
 	}
 
-	trace_mark(xn_nucleus_thread_waitperiod, "thread %p thread_name %s",
+	trace_mark(xn_nucleus, thread_waitperiod, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
 	/* Work with either TSC or periodic ticks. */
@@ -2952,7 +2952,7 @@ int xnpod_wait_thread_period(unsigned long *overruns_r)
 	if (overruns) {
 		err = -ETIMEDOUT;
 
-		trace_mark(xn_nucleus_thread_missedperiod,
+		trace_mark(xn_nucleus, thread_missedperiod,
 			   "thread %p thread_name %s overruns %lu",
 			   thread, xnthread_name(thread), overruns);
 	}
diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index 25ecb58..e740d26 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -71,7 +71,7 @@ static void xnsched_watchdog_handler(struct xntimer *timer)
 	}
 		
 	if (unlikely(++sched->wdcount >= CONFIG_XENO_OPT_WATCHDOG_TIMEOUT)) {
-		trace_mark(xn_nucleus_watchdog, "thread %p thread_name %s",
+		trace_mark(xn_nucleus, watchdog, "thread %p thread_name %s",
 			   thread, xnthread_name(thread));
 		xnprintf("watchdog triggered -- killing runaway thread '%s'\n",
 			 xnthread_name(thread));
@@ -224,7 +224,7 @@ void xnsched_zombie_hooks(struct xnthread *thread)
 	XENO_BUGON(NUCLEUS, thread->sched->zombie != NULL);
 	thread->sched->zombie = thread;
 
-	trace_mark(xn_nucleus_sched_finalize,
+	trace_mark(xn_nucleus, sched_finalize,
 		   "thread_out %p thread_out_name %s",
 		   thread, xnthread_name(thread));
 
@@ -296,7 +296,7 @@ void xnsched_renice_root(struct xnsched *sched, struct xnthread *target)
 
 	xnsched_track_policy(root, target);
 
-	trace_mark(xn_nucleus_sched_reniceroot, MARK_NOARGS);
+	trace_mark(xn_nucleus, sched_reniceroot, MARK_NOARGS);
 	xnarch_trace_pid(xnarch_user_pid(xnthread_archtcb(root)), root->cprio);
 
 	xnlock_put_irqrestore(&nklock, s);
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 6822fcb..17c3b66 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -727,7 +727,8 @@ static void lostage_handler(void *cookie)
 		struct task_struct *p = rq->req[reqnum].task;
 		rq->out = (reqnum + 1) & (LO_MAX_REQUESTS - 1);
 
-		trace_mark(xn_nucleus_lostage_work, "reqnum %d comm %s pid %d",
+		trace_mark(xn_nucleus, lostage_work,
+			   "reqnum %d comm %s pid %d",
 			   reqnum, p->comm, p->pid);
 
 		switch (rq->req[reqnum].type) {
@@ -952,7 +953,7 @@ redo:
 	 * Linux tasks.
 	 */
 
-	trace_mark(xn_nucleus_shadow_gohard,
+	trace_mark(xn_nucleus, shadow_gohard,
 		   "thread %p thread_name %s comm %s",
 		   thread, xnthread_name(thread), this_task->comm);
 
@@ -1006,7 +1007,7 @@ redo:
 	if (rpi_p(thread))
 		rpi_clear_remote(thread);
 
-	trace_mark(xn_nucleus_shadow_hardened, "thread %p thread_name %s",
+	trace_mark(xn_nucleus, shadow_hardened, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
 	xnsched_resched_after_unlocked_switch();
@@ -1056,7 +1057,7 @@ void xnshadow_relax(int notify)
 	 * domain to the Linux domain.  This will cause the Linux task
 	 * to resume using the register state of the shadow thread.
 	 */
-	trace_mark(xn_nucleus_shadow_gorelax, "thread %p thread_name %s",
+	trace_mark(xn_nucleus, shadow_gorelax, "thread %p thread_name %s",
 		  thread, xnthread_name(thread));
 
 	splhigh(s);
@@ -1109,7 +1110,7 @@ void xnshadow_relax(int notify)
 
 	__xn_put_user(XNRELAX, thread->u_mode);
 
-	trace_mark(xn_nucleus_shadow_relaxed,
+	trace_mark(xn_nucleus, shadow_relaxed,
 		  "thread %p thread_name %s comm %s",
 		  thread, xnthread_name(thread), current->comm);
 }
@@ -1227,7 +1228,7 @@ int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion,
 	affinity = xnarch_cpumask_of_cpu(xnarch_first_cpu(affinity));
 	set_cpus_allowed(current, affinity);
 
-	trace_mark(xn_nucleus_shadow_map,
+	trace_mark(xn_nucleus, shadow_map,
 		   "thread %p thread_name %s pid %d priority %d",
 		   thread, xnthread_name(thread), current->pid,
 		   xnthread_base_priority(thread));
@@ -1306,7 +1307,7 @@ void xnshadow_unmap(xnthread_t *thread)
 	xnthread_clear_state(thread, XNMAPPED);
 	rpi_pop(thread);
 
-	trace_mark(xn_nucleus_shadow_unmap,
+	trace_mark(xn_nucleus, shadow_unmap,
 		   "thread %p thread_name %s pid %d",
 		   thread, xnthread_name(thread), p ? p->pid : -1);
 
@@ -1375,7 +1376,7 @@ void xnshadow_start(struct xnthread *thread)
 	/* A shadow always starts in relaxed mode. */
 	rpi_push(thread->sched, thread);
 
-	trace_mark(xn_nucleus_shadow_start, "thread %p thread_name %s",
+	trace_mark(xn_nucleus, shadow_start, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 	xnpod_resume_thread(thread, XNDORMANT);
 
@@ -1936,7 +1937,7 @@ static inline int do_hisyscall_event(unsigned event, unsigned domid, void *data)
 	muxid = __xn_mux_id(regs);
 	muxop = __xn_mux_op(regs);
 
-	trace_mark(xn_nucleus_syscall_histage,
+	trace_mark(xn_nucleus, syscall_histage,
 		   "thread %p thread_name %s muxid %d muxop %d",
 		   thread, thread ? xnthread_name(thread) : NULL,
 		   muxid, muxop);
@@ -2127,7 +2128,7 @@ static inline int do_losyscall_event(unsigned event, unsigned domid, void *data)
 	muxid = __xn_mux_id(regs);
 	muxop = __xn_mux_op(regs);
 
-	trace_mark(xn_nucleus_syscall_lostage,
+	trace_mark(xn_nucleus, syscall_lostage,
 		   "thread %p thread_name %s muxid %d muxop %d",
 		   xnpod_active_p() ? xnpod_current_thread() : NULL,
 		   xnpod_active_p() ? xnthread_name(xnpod_current_thread()) : NULL,
@@ -2210,7 +2211,7 @@ static inline void do_taskexit_event(struct task_struct *p)
 	xnpod_schedule();
 
 	xnshadow_dereference_skin(magic);
-	trace_mark(xn_nucleus_shadow_exit, "thread %p thread_name %s",
+	trace_mark(xn_nucleus, shadow_exit, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 }
 
diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
index 86d55c3..3173a64 100644
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -177,7 +177,7 @@ void xnsynch_sleep_on(struct xnsynch *synch, xnticks_t timeout,
 
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_synch_sleepon,
+	trace_mark(xn_nucleus, synch_sleepon,
 		   "thread %p thread_name %s synch %p",
 		   thread, xnthread_name(thread), synch);
 
@@ -245,7 +245,7 @@ struct xnthread *xnsynch_wakeup_one_sleeper(struct xnsynch *synch)
 	if (holder) {
 		thread = link2thread(holder, plink);
 		thread->wchan = NULL;
-		trace_mark(xn_nucleus_synch_wakeup_one,
+		trace_mark(xn_nucleus, synch_wakeup_one,
 			   "thread %p thread_name %s synch %p",
 			   thread, xnthread_name(thread), synch);
 		xnpod_resume_thread(thread, XNPEND);
@@ -316,7 +316,7 @@ struct xnpholder *xnsynch_wakeup_this_sleeper(struct xnsynch *synch, struct xnph
 	nholder = poppq(&synch->pendq, holder);
 	thread = link2thread(holder, plink);
 	thread->wchan = NULL;
-	trace_mark(xn_nucleus_synch_wakeup_this,
+	trace_mark(xn_nucleus, synch_wakeup_this,
 		   "thread %p thread_name %s synch %p",
 		   thread, xnthread_name(thread), synch);
 	xnpod_resume_thread(thread, XNPEND);
@@ -405,7 +405,7 @@ void xnsynch_acquire(struct xnsynch *synch, xnticks_t timeout,
 
 	XENO_BUGON(NUCLEUS, !testbits(synch->status, XNSYNCH_OWNER));
 
-	trace_mark(xn_nucleus_synch_acquire, "synch %p", synch);
+	trace_mark(xn_nucleus, synch_acquire, "synch %p", synch);
 
       redo:
 
@@ -708,7 +708,7 @@ struct xnthread *xnsynch_release(struct xnsynch *synch)
 
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_synch_release, "synch %p", synch);
+	trace_mark(xn_nucleus, synch_release, "synch %p", synch);
 
 	holder = getpq(&synch->pendq);
 	if (holder) {
@@ -839,7 +839,7 @@ int xnsynch_flush(struct xnsynch *synch, xnflags_t reason)
 
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_synch_flush, "synch %p reason %lu",
+	trace_mark(xn_nucleus, synch_flush, "synch %p reason %lu",
 		   synch, reason);
 
 	status = emptypq_p(&synch->pendq) ? XNSYNCH_DONE : XNSYNCH_RESCHED;
@@ -889,7 +889,7 @@ void xnsynch_forget_sleeper(struct xnthread *thread)
 	struct xnthread *owner, *target;
 	struct xnpholder *h;
 
-	trace_mark(xn_nucleus_synch_forget,
+	trace_mark(xn_nucleus, synch_forget,
 		   "thread %p thread_name %s synch %p",
 		   thread, xnthread_name(thread), synch);
 
diff --git a/ksrc/nucleus/timebase.c b/ksrc/nucleus/timebase.c
index f097f1f..c2ff733 100644
--- a/ksrc/nucleus/timebase.c
+++ b/ksrc/nucleus/timebase.c
@@ -384,7 +384,7 @@ void xntbase_start(xntbase_t *base)
 	if (base == &nktbase || xntbase_enabled_p(base))
 		return;
 
-	trace_mark(xn_nucleus_tbase_start, "base %s", base->name);
+	trace_mark(xn_nucleus, tbase_start, "base %s", base->name);
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -441,7 +441,7 @@ void xntbase_stop(xntbase_t *base)
 	xntslave_stop(base2slave(base));
 	__clrbits(base->status, XNTBRUN | XNTBSET);
 
-	trace_mark(xn_nucleus_tbase_stop, "base %s", base->name);
+	trace_mark(xn_nucleus, tbase_stop, "base %s", base->name);
 }
 EXPORT_SYMBOL_GPL(xntbase_stop);
 
@@ -479,7 +479,7 @@ void xntbase_tick(xntbase_t *base)
 
 	xnlock_get_irqsave(&nklock, s);
 
-	trace_mark(xn_nucleus_tbase_tick, "base %s", base->name);
+	trace_mark(xn_nucleus, tbase_tick, "base %s", base->name);
 
 	if (base == &nktbase)
 		xntimer_tick_aperiodic();
@@ -613,7 +613,7 @@ void xntbase_adjust_time(xntbase_t *base, xnsticks_t delta)
 	}
 #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
 
-	trace_mark(xn_nucleus_tbase_adjust, "base %s delta %Lu",
+	trace_mark(xn_nucleus, tbase_adjust, "base %s delta %Lu",
 		   base->name, delta);
 }
 EXPORT_SYMBOL_GPL(xntbase_adjust_time);
diff --git a/ksrc/nucleus/timer.c b/ksrc/nucleus/timer.c
index 090df71..c3aaa0e 100644
--- a/ksrc/nucleus/timer.c
+++ b/ksrc/nucleus/timer.c
@@ -225,7 +225,7 @@ int xntimer_start_aperiodic(xntimer_t *timer,
 {
 	xnticks_t date, now;
 
-	trace_mark(xn_nucleus_timer_start,
+	trace_mark(xn_nucleus, timer_start,
 		   "timer %p base %s value %Lu interval %Lu mode %u",
 		   timer, xntimer_base(timer)->name, value, interval, mode);
 
@@ -278,7 +278,7 @@ void xntimer_stop_aperiodic(xntimer_t *timer)
 {
 	int heading;
 
-	trace_mark(xn_nucleus_timer_stop, "timer %p", timer);
+	trace_mark(xn_nucleus, timer_stop, "timer %p", timer);
 
 	heading = xntimer_heading_p(timer);
 	xntimer_dequeue_aperiodic(timer);
@@ -368,7 +368,7 @@ void xntimer_tick_aperiodic(void)
 		if (delta > (xnsticks_t)nklatency)
 			break;
 
-		trace_mark(xn_nucleus_timer_expire, "timer %p", timer);
+		trace_mark(xn_nucleus, timer_expire, "timer %p", timer);
 
 		xntimer_dequeue_aperiodic(timer);
 		xnstat_counter_inc(&timer->fired);
@@ -456,7 +456,7 @@ static int xntimer_start_periodic(xntimer_t *timer,
 				  xnticks_t value, xnticks_t interval,
 				  xntmode_t mode)
 {
-	trace_mark(xn_nucleus_timer_start,
+	trace_mark(xn_nucleus, timer_start,
 		   "timer %p base %s value %Lu interval %Lu mode %u", timer,
 		   xntimer_base(timer)->name, value, interval, mode);
 
@@ -495,7 +495,7 @@ static int xntimer_start_periodic(xntimer_t *timer,
 
 static void xntimer_stop_periodic(xntimer_t *timer)
 {
-	trace_mark(xn_nucleus_timer_stop, "timer %p", timer);
+	trace_mark(xn_nucleus, timer_stop, "timer %p", timer);
 
 	xntimer_dequeue_periodic(timer);
 }
@@ -581,7 +581,7 @@ void xntimer_tick_periodic_inner(xntslave_t *slave)
 				  - base->jiffies) > 0)
 			break;
 
-		trace_mark(xn_nucleus_timer_expire, "timer %p", timer);
+		trace_mark(xn_nucleus, timer_expire, "timer %p", timer);
 
 		xntimer_dequeue_periodic(timer);
 		xnstat_counter_inc(&timer->fired);
@@ -720,7 +720,7 @@ void xntslave_start(xntslave_t *slave, xnticks_t start, xnticks_t interval)
 	int nr_cpus, cpu;
 	spl_t s;
 
-	trace_mark(xn_nucleus_tbase_start, "base %s", slave->base.name);
+	trace_mark(xn_nucleus, tbase_start, "base %s", slave->base.name);
 
 	for (cpu = 0, nr_cpus = xnarch_num_online_cpus(); cpu < nr_cpus; cpu++) {
 
@@ -739,7 +739,7 @@ void xntslave_stop(xntslave_t *slave)
 	int nr_cpus, cpu;
 	spl_t s;
 
-	trace_mark(xn_nucleus_tbase_stop, "base %s", slave->base.name);
+	trace_mark(xn_nucleus, tbase_stop, "base %s", slave->base.name);
 
 	for (cpu = 0, nr_cpus = xnarch_num_online_cpus(); cpu < nr_cpus; cpu++) {
 
@@ -938,7 +938,7 @@ int xntimer_migrate(xntimer_t *timer, xnsched_t *sched)
 	int queued;
 	spl_t s;
 
-	trace_mark(xn_nucleus_timer_migrate, "timer %p cpu %d",
+	trace_mark(xn_nucleus, timer_migrate, "timer %p cpu %d",
 		   timer, (int)xnsched_cpu(sched));
 
 	xnlock_get_irqsave(&nklock, s);
@@ -1039,7 +1039,7 @@ void xntimer_freeze(void)
 	int nr_cpus, cpu;
 	spl_t s;
 
-	trace_mark(xn_nucleus_timer_freeze, MARK_NOARGS);
+	trace_mark(xn_nucleus, timer_freeze, MARK_NOARGS);
 
 	xnlock_get_irqsave(&nklock, s);
 
diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
index cfa45f1..853b8af 100644
--- a/ksrc/skins/rtdm/core.c
+++ b/ksrc/skins/rtdm/core.c
@@ -204,7 +204,7 @@ int __rt_dev_open(rtdm_user_info_t *user_info, const char *path, int oflag)
 	int nrt_mode = !rtdm_in_rt_context();
 
 	device = get_named_device(path);
-	trace_mark(xn_rtdm_open, "user_info %p path %s oflag %d device %p",
+	trace_mark(xn_rtdm, open, "user_info %p path %s oflag %d device %p",
 		   user_info, path, oflag, device);
 	ret = -ENODEV;
 	if (!device)
@@ -229,7 +229,8 @@ int __rt_dev_open(rtdm_user_info_t *user_info, const char *path, int oflag)
 
 	fildes->context = context;
 
-	trace_mark(xn_rtdm_fd_created, "device %p fd %d", device, context->fd);
+	trace_mark(xn_rtdm, fd_created,
+		   "device %p fd %d", device, context->fd);
 
 	return context->fd;
 
@@ -254,7 +255,7 @@ int __rt_dev_socket(rtdm_user_info_t *user_info, int protocol_family,
 	int nrt_mode = !rtdm_in_rt_context();
 
 	device = get_protocol_device(protocol_family, socket_type);
-	trace_mark(xn_rtdm_socket, "user_info %p protocol_family %d "
+	trace_mark(xn_rtdm, socket, "user_info %p protocol_family %d "
 		   "socket_type %d protocol %d device %p",
 		   user_info, protocol_family, socket_type, protocol, device);
 	ret = -EAFNOSUPPORT;
@@ -280,7 +281,8 @@ int __rt_dev_socket(rtdm_user_info_t *user_info, int protocol_family,
 
 	fildes->context = context;
 
-	trace_mark(xn_rtdm_fd_created, "device %p fd %d", device, context->fd);
+	trace_mark(xn_rtdm, fd_created,
+		   "device %p fd %d", device, context->fd);
 
 	return context->fd;
 
@@ -301,7 +303,7 @@ int __rt_dev_close(rtdm_user_info_t *user_info, int fd)
 	int ret;
 	int nrt_mode = !rtdm_in_rt_context();
 
-	trace_mark(xn_rtdm_close, "user_info %p fd %d", user_info, fd);
+	trace_mark(xn_rtdm, close, "user_info %p fd %d", user_info, fd);
 
 	ret = -EBADF;
 	if (unlikely((unsigned int)fd >= RTDM_FD_MAX))
@@ -361,7 +363,7 @@ again:
 			 test_bit(RTDM_CREATED_IN_NRT, &context->context_flags),
 			 s);
 
-	trace_mark(xn_rtdm_fd_closed, "fd %d", fd);
+	trace_mark(xn_rtdm, fd_closed, "fd %d", fd);
 
 	return ret;
 
@@ -426,7 +428,7 @@ do {									\
 	rtdm_context_unlock(context);					\
 									\
 err_out:								\
-	trace_mark(xn_rtdm_##operation##_done, "result %d", ret);	\
+	trace_mark(xn_rtdm, operation##_done, "result %d", ret);	\
 	return ret;							\
 } while (0)
 
@@ -445,7 +447,7 @@ int __rt_dev_ioctl(rtdm_user_info_t *user_info, int fd, int request, ...)
 	arg = va_arg(args, void __user *);
 	va_end(args);
 
-	trace_mark(xn_rtdm_ioctl, "user_info %p fd %d request %d arg %p",
+	trace_mark(xn_rtdm, ioctl, "user_info %p fd %d request %d arg %p",
 		   user_info, fd, request, arg);
 
 	MAJOR_FUNCTION_WRAPPER_TH(ioctl, (unsigned int)request, arg);
@@ -471,7 +473,7 @@ EXPORT_SYMBOL(__rt_dev_ioctl);
 ssize_t __rt_dev_read(rtdm_user_info_t *user_info, int fd, void *buf,
 		      size_t nbyte)
 {
-	trace_mark(xn_rtdm_read, "user_info %p fd %d buf %p nbyte %zu",
+	trace_mark(xn_rtdm, read, "user_info %p fd %d buf %p nbyte %zu",
 		   user_info, fd, buf, nbyte);
 	MAJOR_FUNCTION_WRAPPER(read, buf, nbyte);
 }
@@ -481,7 +483,7 @@ EXPORT_SYMBOL(__rt_dev_read);
 ssize_t __rt_dev_write(rtdm_user_info_t *user_info, int fd, const void *buf,
 		       size_t nbyte)
 {
-	trace_mark(xn_rtdm_write, "user_info %p fd %d buf %p nbyte %zu",
+	trace_mark(xn_rtdm, write, "user_info %p fd %d buf %p nbyte %zu",
 		   user_info, fd, buf, nbyte);
 	MAJOR_FUNCTION_WRAPPER(write, buf, nbyte);
 }
@@ -491,7 +493,7 @@ EXPORT_SYMBOL(__rt_dev_write);
 ssize_t __rt_dev_recvmsg(rtdm_user_info_t *user_info, int fd,
 			 struct msghdr *msg, int flags)
 {
-	trace_mark(xn_rtdm_recvmsg, "user_info %p fd %d msg_name %p "
+	trace_mark(xn_rtdm, recvmsg, "user_info %p fd %d msg_name %p "
 		   "msg_namelen %u msg_iov %p msg_iovlen %zu "
 		   "msg_control %p msg_controllen %zu msg_flags %d",
 		   user_info, fd, msg->msg_name, msg->msg_namelen,
@@ -505,7 +507,7 @@ EXPORT_SYMBOL(__rt_dev_recvmsg);
 ssize_t __rt_dev_sendmsg(rtdm_user_info_t *user_info, int fd,
 			 const struct msghdr *msg, int flags)
 {
-	trace_mark(xn_rtdm_recvmsg, "user_info %p fd %d msg_name %p "
+	trace_mark(xn_rtdm, recvmsg, "user_info %p fd %d msg_name %p "
 		   "msg_namelen %u msg_iov %p msg_iovlen %zu "
 		   "msg_control %p msg_controllen %zu msg_flags %d",
 		   user_info, fd, msg->msg_name, msg->msg_namelen,
diff --git a/ksrc/skins/rtdm/device.c b/ksrc/skins/rtdm/device.c
index af02d37..e927ce7 100644
--- a/ksrc/skins/rtdm/device.c
+++ b/ksrc/skins/rtdm/device.c
@@ -273,7 +273,7 @@ int rtdm_dev_register(struct rtdm_device *device)
 	down(&nrt_dev_lock);
 
 	if ((device->device_flags & RTDM_DEVICE_TYPE_MASK) == RTDM_NAMED_DEVICE) {
-		trace_mark(xn_rtdm_nameddev_register, "device %p name %s "
+		trace_mark(xn_rtdm, nameddev_register, "device %p name %s "
 			   "flags %d class %d sub_class %d profile_version %d "
 			   "driver_version %d", device, device->device_name,
 			   device->device_flags, device->device_class,
@@ -307,7 +307,7 @@ int rtdm_dev_register(struct rtdm_device *device)
 
 		up(&nrt_dev_lock);
 	} else {
-		trace_mark(xn_rtdm_protocol_register, "device %p "
+		trace_mark(xn_rtdm, protocol_register, "device %p "
 			   "protocol_family %d socket_type %d flags %d "
 			   "class %d sub_class %d profile_version %d "
 			   "driver_version %d", device,
@@ -398,7 +398,7 @@ int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay)
 	if (!reg_dev)
 		return -ENODEV;
 
-	trace_mark(xn_rtdm_dev_unregister, "device %p poll_delay %u",
+	trace_mark(xn_rtdm, dev_unregister, "device %p poll_delay %u",
 		   device, poll_delay);
 
 	down(&nrt_dev_lock);
@@ -410,7 +410,7 @@ int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay)
 
 		if (!poll_delay) {
 			rtdm_dereference_device(reg_dev);
-			trace_mark(xn_rtdm_dev_busy, "device %p", device);
+			trace_mark(xn_rtdm, dev_busy, "device %p", device);
 			return -EAGAIN;
 		}
 
@@ -418,7 +418,7 @@ int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay)
 			xnlogwarn("RTDM: device %s still in use - waiting for "
 				  "release...\n", reg_dev->device_name);
 		msleep(poll_delay);
-		trace_mark(xn_rtdm_dev_poll, "device %p", device);
+		trace_mark(xn_rtdm, dev_poll, "device %p", device);
 
 		down(&nrt_dev_lock);
 		xnlock_get_irqsave(&rt_dev_lock, s);
diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
index f1e9e9e..2d28e09 100644
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -431,7 +431,7 @@ void rtdm_task_join_nrt(rtdm_task_t *task, unsigned int poll_delay)
 
 	XENO_ASSERT(RTDM, xnpod_root_p(), return;);
 
-	trace_mark(xn_rtdm_task_joinnrt, "thread %p poll_delay %u",
+	trace_mark(xn_rtdm, task_joinnrt, "thread %p poll_delay %u",
 		   task, poll_delay);
 
 	xnlock_get_irqsave(&nklock, s);
@@ -771,7 +771,8 @@ void rtdm_event_init(rtdm_event_t *event, unsigned long pending)
 {
 	spl_t s;
 
-	trace_mark(xn_rtdm_event_init, "event %p pending %lu", event, pending);
+	trace_mark(xn_rtdm, event_init,
+		   "event %p pending %lu", event, pending);
 
 	/* Make atomic for re-initialisation support */
 	xnlock_get_irqsave(&nklock, s);
@@ -852,7 +853,7 @@ void rtdm_event_signal(rtdm_event_t *event)
 	int resched = 0;
 	spl_t s;
 
-	trace_mark(xn_rtdm_event_signal, "event %p", event);
+	trace_mark(xn_rtdm, event_signal, "event %p", event);
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -947,7 +948,7 @@ int rtdm_event_timedwait(rtdm_event_t *event, nanosecs_rel_t timeout,
 
 	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
 
-	trace_mark(xn_rtdm_event_timedwait,
+	trace_mark(xn_rtdm, event_timedwait,
 		   "event %p timeout %Lu timeout_seq %p timeout_seq_value %Lu",
 		   event, (long long)timeout, timeout_seq, (long long)(timeout_seq ? *timeout_seq : 0));
 
@@ -1021,7 +1022,7 @@ void rtdm_event_clear(rtdm_event_t *event)
 {
 	spl_t s;
 
-	trace_mark(xn_rtdm_event_clear, "event %p", event);
+	trace_mark(xn_rtdm, event_clear, "event %p", event);
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -1118,7 +1119,7 @@ void rtdm_sem_init(rtdm_sem_t *sem, unsigned long value)
 {
 	spl_t s;
 
-	trace_mark(xn_rtdm_sem_init, "sem %p value %lu", sem, value);
+	trace_mark(xn_rtdm, sem_init, "sem %p value %lu", sem, value);
 
 	/* Make atomic for re-initialisation support */
 	xnlock_get_irqsave(&nklock, s);
@@ -1232,7 +1233,7 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem, nanosecs_rel_t timeout,
 
 	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
 
-	trace_mark(xn_rtdm_sem_timedwait,
+	trace_mark(xn_rtdm, sem_timedwait,
 		   "sem %p timeout %Lu timeout_seq %p timeout_seq_value %Lu",
 		   sem, (long long)timeout, timeout_seq, (long long)(timeout_seq ? *timeout_seq : 0));
 
@@ -1300,7 +1301,7 @@ void rtdm_sem_up(rtdm_sem_t *sem)
 {
 	spl_t s;
 
-	trace_mark(xn_rtdm_sem_up, "sem %p", sem);
+	trace_mark(xn_rtdm, sem_up, "sem %p", sem);
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -1523,7 +1524,7 @@ int rtdm_mutex_timedlock(rtdm_mutex_t *mutex, nanosecs_rel_t timeout,
 	spl_t s;
 	int err = 0;
 
-	trace_mark(xn_rtdm_mutex_timedlock,
+	trace_mark(xn_rtdm, mutex_timedlock,
 		   "mutex %p timeout %Lu timeout_seq %p timeout_seq_value %Lu",
 		   mutex, (long long)timeout, timeout_seq, (long long)(timeout_seq ? *timeout_seq : 0));
 

