From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="K8xntcVFjl"
Content-Transfer-Encoding: 7bit
Message-ID: <18341.1842.200110.826268@domain.hid>
Date: Sun, 3 Feb 2008 01:13:38 +0100
In-Reply-To: <18341.1681.919618.418201@domain.hid>
References: <18341.1681.919618.418201@domain.hid>
Subject: [Xenomai-core] [PATCH 2/3] ARM unlocked context switch.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--K8xntcVFjl
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


This patch allows the cache flushing needed by ARM context switches to take
place with the nklock unlocked, irqs on, in the same way as Linux.

To this end, I added a new thread state XNSWLOCK meaning that a thread is
currently switching context. Functions switching contexts set this bit in the
two switching threads status before the context switch, and clear it after. If
xnpod_schedule is entered (due to execution of an ISR which nklock is unlocked
during the cache flush) when the current thread has this bit armed, it exits
immediately with the resched bit remaining set, the routine switching context
will then restart xnpod_schedule when it detects this situation.

Another case arise if one of the two threads switching context is deleted while
the nklock is locked. If this thread is the current thread, the rescheduling bit
is set, so that the normal deletion procedure will take place when
xnpod_schedule is called again. If this thread is the previous thread, it means
that the thread has been deleted by a distant CPU on an SMP system, and its
deletion hooks may be run on any context. We can not delete the thread on the
distant CPU since the thread stack may currently be in use. We can not even run
the thread deletion hooks on the distant CPU since it would put the thread
control block in the distant CPU nkheap idleq, risking that xnfreesync on the
distant CPU frees the thread control block before its finalization. So, the
approach taken is to detect this case after the context swich, running the
deletion hooks immediately so that the finalization can take place normally.

Stats:
 include/asm-arm/bits/pod.h |   60 +++++++++++++++++++-----------------
 include/asm-arm/system.h   |    2 +
 include/nucleus/pod.h      |   40 ++++++++++++++++++++++++
 include/nucleus/thread.h   |    1
 ksrc/nucleus/pod.c         |   75 +++++++++++++++++++++++++++++++++++++++++----
 ksrc/nucleus/shadow.c      |    4 ++
 6 files changed, 149 insertions(+), 33 deletions(-)

-- 


					    Gilles Chanteperdrix.

--K8xntcVFjl
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-unlocked-arm-ctx-switch.4.diff"
Content-Transfer-Encoding: 7bit

--- include/asm-arm/bits/pod.h	2008-01-23 22:54:20.000000000 +0100
+++ include/asm-arm/bits/pod.h	2008-02-03 00:06:05.000000000 +0100
@@ -67,33 +67,39 @@ static inline void xnarch_enter_root(xna
 #endif /* TIF_MMSWITCH_INT */
 }
 
-static inline void xnarch_switch_to(xnarchtcb_t * out_tcb, xnarchtcb_t * in_tcb)
-{
-	struct task_struct *prev = out_tcb->active_task;
-	struct mm_struct *prev_mm = out_tcb->active_mm;
-	struct task_struct *next = in_tcb->user_task;
-
-
-	if (likely(next != NULL)) {
-		in_tcb->active_task = next;
-		in_tcb->active_mm = in_tcb->mm;
-		rthal_clear_foreign_stack(&rthal_domain);
-	} else {
-		in_tcb->active_task = prev;
-		in_tcb->active_mm = prev_mm;
-		rthal_set_foreign_stack(&rthal_domain);
-	}
-
-	if (prev_mm != in_tcb->active_mm) {
-		/* Switch to new user-space thread? */
-		if (in_tcb->active_mm)
-			switch_mm(prev_mm, in_tcb->active_mm, next);
-		if (!next->mm)
-			enter_lazy_tlb(prev_mm, next);
-	}
-
-	/* Kernel-to-kernel context switch. */
-	rthal_thread_switch(prev, out_tcb->tip, in_tcb->tip);
+#define xnarch_switch_to(_out_tcb, _in_tcb, lock)			\
+{									\
+	xnarchtcb_t *in_tcb = (_in_tcb);				\
+	xnarchtcb_t *out_tcb = (_out_tcb);				\
+	struct task_struct *prev = out_tcb->active_task;		\
+	struct mm_struct *prev_mm = out_tcb->active_mm;			\
+	struct task_struct *next = in_tcb->user_task;			\
+									\
+									\
+	if (likely(next != NULL)) {					\
+		in_tcb->active_task = next;				\
+		in_tcb->active_mm = in_tcb->mm;				\
+		rthal_clear_foreign_stack(&rthal_domain);		\
+	} else {							\
+		in_tcb->active_task = prev;				\
+		in_tcb->active_mm = prev_mm;				\
+		rthal_set_foreign_stack(&rthal_domain);			\
+	}								\
+									\
+	if (prev_mm != in_tcb->active_mm) {				\
+		/* Switch to new user-space thread? */			\
+		if (in_tcb->active_mm) {				\
+			spl_t ignored;					\
+			xnlock_clear_irqon(lock);			\
+			switch_mm(prev_mm, in_tcb->active_mm, next);	\
+			xnlock_get_irqsave(lock, ignored);		\
+		}							\
+		if (!next->mm)						\
+			enter_lazy_tlb(prev_mm, next);			\
+	}								\
+									\
+	/* Kernel-to-kernel context switch. */				\
+	rthal_thread_switch(prev, out_tcb->tip, in_tcb->tip);		\
 }
 
 static inline void xnarch_finalize_no_switch(xnarchtcb_t * dead_tcb)
--- include/asm-arm/system.h	2008-01-15 21:13:47.000000000 +0100
+++ include/asm-arm/system.h	2008-02-03 00:06:28.000000000 +0100
@@ -31,6 +31,8 @@
 
 #define XNARCH_THREAD_STACKSZ   4096
 
+#define XNARCH_WANT_UNLOCKED_CTXSW
+
 #define xnarch_stack_size(tcb)  ((tcb)->stacksize)
 #define xnarch_user_task(tcb)   ((tcb)->user_task)
 #define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
--- include/nucleus/pod.h	2008-02-02 22:47:59.000000000 +0100
+++ include/nucleus/pod.h	2008-02-02 22:49:18.000000000 +0100
@@ -140,6 +140,10 @@ typedef struct xnsched {
 	xntimer_t htimer;	/*!< Host timer. */
 
 	xnthread_t *zombie;
+
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+	xnthread_t *lastthread;
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
 } xnsched_t;
 
 #define nkpod (&nkpod_struct)
@@ -457,6 +461,42 @@ static inline void xnpod_delete_self(voi
 	xnpod_delete_thread(xnpod_current_thread());
 }
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+void xnpod_zombie_hooks(xnthread_t *thread);
+
+static inline void xnpod_finish_unlocked_switch(xnsched_t *sched)
+{
+	xnthread_clear_state(sched->lastthread, XNSWLOCK);
+	xnthread_clear_state(sched->runthread, XNSWLOCK);
+
+	/* Detect a thread which called xnpod_migrate_thread */
+	if (sched->lastthread->sched != sched)
+		xnpod_resume_thread(sched->lastthread, 0);
+
+	if (xnthread_test_state(sched->lastthread, XNZOMBIE)) {
+		/* There are two cases where sched->lastthread has the zombie
+		   bit:
+		   - either it had it before the context switch, the hooks
+		   have been executed and sched->zombie is lastthread;
+		   - or it has been killed while the nklocked was unlocked
+		   during the context switch, in which case we must run the
+		   hooks, and we do it now.
+		*/
+		if (sched->zombie != sched->lastthread)
+			xnpod_zombie_hooks(sched->lastthread);
+	}
+}
+
+static inline void xnpod_resched_after_unlocked_switch(void)
+{
+	if (xnsched_resched_p())
+		xnpod_schedule();
+}
+#else /* !XNARCH_WANT_UNLOCKED_CTXSW */
+#define xnpod_finish_unlocked_switch(sched)
+#define xnpod_resched_after_unlocked_switch()
+#endif /* !XNARCH_WANT_UNLOCKED_CTXSW */
+
 #ifdef __cplusplus
 }
 #endif
--- include/nucleus/thread.h	2008-01-15 21:13:13.000000000 +0100
+++ include/nucleus/thread.h	2008-02-02 21:29:53.000000000 +0100
@@ -61,6 +61,7 @@
 #define XNFPU     0x00100000 /**< Thread uses FPU */
 #define XNSHADOW  0x00200000 /**< Shadow thread */
 #define XNROOT    0x00400000 /**< Root thread (that is, Linux/IDLE) */
+#define XNSWLOCK  0x00800000 /**< Thread is currently switching context. */
 
 /*! @} */ /* Ends doxygen comment group: nucleus_state_flags */
 
--- ksrc/nucleus/pod.c	2008-02-03 00:20:17.000000000 +0100
+++ ksrc/nucleus/pod.c	2008-02-03 00:25:26.000000000 +0100
@@ -66,6 +66,22 @@ char *nkmsgbuf = NULL;
 
 xnarch_cpumask_t nkaffinity = XNPOD_ALL_CPUS;
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+static inline void xnpod_switch_to(xnsched_t *sched,
+				   xnthread_t *threadout, xnthread_t *threadin)
+{
+	sched->lastthread = threadout;
+	xnthread_set_state(threadout, XNSWLOCK);
+	xnthread_set_state(threadin, XNSWLOCK);
+
+	xnarch_switch_to(xnthread_archtcb(threadout),
+			 xnthread_archtcb(threadin), &nklock);
+}
+#else /* !XNARCH_WANT_UNLOCKED_CTXSW */
+#define xnpod_switch_to(sched, threadout, threadin) \
+	xnarch_switch_to(xnthread_archtcb(threadout), xnthread_archtcb(threadin))
+#endif /* !XNARCH_WANT_UNLOCKED_CTXSW */
+
 const char *xnpod_fatal_helper(const char *format, ...)
 {
 	const unsigned nr_cpus = xnarch_num_online_cpus();
@@ -546,7 +562,7 @@ static inline void xnpod_fire_callouts(x
 	__clrbits(sched->status, XNKCOUT);
 }
 
-static void xnpod_zombie_hooks(xnthread_t *thread)
+void xnpod_zombie_hooks(xnthread_t *thread)
 {
 	XENO_BUGON(NUCLEUS, thread->sched->zombie != NULL);
 	thread->sched->zombie = thread;
@@ -1190,7 +1206,14 @@ void xnpod_delete_thread(xnthread_t *thr
 		   the thread object. */
 		xnsched_set_resched(sched);
 		xnpod_schedule();
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+	} else if (!xnthread_test_state(thread, XNSWLOCK)) {
+		/* When killing a thread in the course of a context switch
+		   with nklock unlocked on a distant CPU, do nothing, this case
+		   will be caught in xnpod_finish_unlocked_switch. */
+#else /* !XNARCH_WANT_UNLOCKED_CTXSW */
 	} else {
+#endif /* !XNARCH_WANT_UNLOCKED_CTXSW */
 		if (!emptyq_p(&nkpod->tdeleteq)
 		    && !xnthread_test_state(thread, XNROOT)) {
 			trace_mark(xn_nucleus_thread_callout,
@@ -1869,8 +1892,10 @@ int xnpod_migrate_thread(int cpu)
 	/* Migrate the thread periodic timer. */
 	xntimer_set_sched(&thread->ptimer, thread->sched);
 
+#ifndef XNARCH_WANT_UNLOCKED_CTXSW
 	/* Put thread in the ready queue of the destination CPU's scheduler. */
 	xnpod_resume_thread(thread, 0);
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
 
 	xnpod_schedule();
 
@@ -2112,6 +2137,8 @@ void xnpod_dispatch_signals(void)
 
 void xnpod_welcome_thread(xnthread_t *thread, int imask)
 {
+	xnpod_finish_unlocked_switch(thread->sched);
+
 	xnpod_finalize_zombie(thread->sched);
 
 	trace_mark(xn_nucleus_thread_boot, "thread %p thread_name %s",
@@ -2148,6 +2175,8 @@ void xnpod_welcome_thread(xnthread_t *th
 
 	xnlock_clear_irqoff(&nklock);
 	splexit(!!imask);
+
+	xnpod_resched_after_unlocked_switch();
 }
 
 #ifdef CONFIG_XENO_HW_FPU
@@ -2367,6 +2396,10 @@ void xnpod_schedule(void)
 	if (xnpod_callout_p() || xnpod_interrupt_p())
 		return;
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+      restart:
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
+
 	trace_mark(xn_nucleus_sched, MARK_NOARGS);
 
 	xnlock_get_irqsave(&nklock, s);
@@ -2388,7 +2421,7 @@ void xnpod_schedule(void)
 		xnarch_send_ipi(xnsched_resched_mask());
 		xnsched_clr_mask(sched);
 	}
-#if XENO_DEBUG(NUCLEUS)
+#if !XENO_DEBUG(NUCLEUS)
 	if (!need_resched)
 		goto signal_unlock_and_exit;
 
@@ -2400,6 +2433,11 @@ void xnpod_schedule(void)
 
 #endif /* CONFIG_SMP */
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+	if (xnthread_test_state(runthread, XNSWLOCK))
+		goto unlock_and_exit;
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
+
 	/* Clear the rescheduling bit */
 	xnsched_clr_resched(sched);
 
@@ -2486,8 +2524,7 @@ void xnpod_schedule(void)
 	xnstat_exectime_switch(sched, &threadin->stat.account);
 	xnstat_counter_inc(&threadin->stat.csw);
 
-	xnarch_switch_to(xnthread_archtcb(threadout),
-			 xnthread_archtcb(threadin));
+	xnpod_switch_to(sched, threadout, threadin);
 
 #ifdef CONFIG_SMP
 	/* If threadout migrated while suspended, sched is no longer correct. */
@@ -2512,6 +2549,8 @@ void xnpod_schedule(void)
 		xnpod_fatal("zombie thread %s (%p) would not die...",
 			    threadout->name, threadout);
 
+	xnpod_finish_unlocked_switch(sched);
+
 	xnpod_finalize_zombie(sched);
 
 #ifdef CONFIG_XENO_HW_FPU
@@ -2530,11 +2569,19 @@ void xnpod_schedule(void)
 		xnpod_fire_callouts(&nkpod->tswitchq, runthread);
 	}
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+	if (unlikely(xnsched_resched_p()))
+		goto signal_unlock_and_restart;
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
+
       signal_unlock_and_exit:
 
 	if (xnthread_signaled_p(runthread))
 		xnpod_dispatch_signals();
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+      unlock_and_exit:
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
 	xnlock_put_irqrestore(&nklock, s);
 	return;
 
@@ -2553,8 +2600,21 @@ void xnpod_schedule(void)
 		   the caller may expect it to be locked. */
 		xnlock_get_irqsave(&nklock, ignored);
 		xnlock_put_irqrestore(&nklock, s);
+
+		return;
 	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
+
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+  signal_unlock_and_restart:
+	if (xnthread_signaled_p(runthread))
+		xnpod_dispatch_signals();
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	if (xnsched_resched_p())
+		goto restart;
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
 }
 
 /*! 
@@ -2672,14 +2732,15 @@ void xnpod_schedule_runnable(xnthread_t 
 	xnstat_exectime_switch(sched, &threadin->stat.account);
 	xnstat_counter_inc(&threadin->stat.csw);
 
-	xnarch_switch_to(xnthread_archtcb(runthread),
-			 xnthread_archtcb(threadin));
+	xnpod_switch_to(sched, runthread, threadin);
 
 #ifdef CONFIG_SMP
 	/* If runthread migrated while suspended, sched is no longer correct. */
 	sched = xnpod_current_sched();
 #endif
 
+	xnpod_finish_unlocked_switch(sched);
+
 	xnpod_finalize_zombie(sched);
 
 	xnarch_trace_pid(xnthread_user_task(runthread) ?
@@ -2694,6 +2755,8 @@ void xnpod_schedule_runnable(xnthread_t 
 	if (nkpod->schedhook && runthread == sched->runthread)
 		nkpod->schedhook(runthread, XNRUNNING);
 #endif /* __XENO_SIM__ */
+
+	xnpod_resched_after_unlocked_switch();
 }
 
 /*! 
--- ksrc/nucleus/shadow.c	2008-02-02 22:48:08.000000000 +0100
+++ ksrc/nucleus/shadow.c	2008-02-02 22:47:04.000000000 +0100
@@ -1127,6 +1127,8 @@ redo:
 	/* "current" is now running into the Xenomai domain. */
 	sched = xnpod_current_sched();
 
+	xnpod_finish_unlocked_switch(sched);
+
 	xnpod_finalize_zombie(sched);
 
 #ifdef CONFIG_XENO_HW_FPU
@@ -1153,6 +1155,8 @@ redo:
 	trace_mark(xn_nucleus_shadow_hardened, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
+	xnpod_resched_after_unlocked_switch();
+
 	return 0;
 }
 

--K8xntcVFjl--

