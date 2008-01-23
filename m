MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XwDwx/E46I"
Content-Transfer-Encoding: 7bit
Message-ID: <18327.49632.459638.584692@domain.hid>
Date: Wed, 23 Jan 2008 23:38:24 +0100
In-Reply-To: <479788A5.80407@domain.hid>
References: <2ff1a98a0801020231k19be7d89k1a6f04b7d497cc34@domain.hid>
	<18315.63245.160672.547658@domain.hid>
	<18326.21480.397736.413726@domain.hid>
	<47977DE1.8060207@domain.hid>
	<2ff1a98a0801230953m2a67e614s6c921b3b6ec77c3c@domain.hid>
	<479788A5.80407@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] High latencies on ARM.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>


--XwDwx/E46I
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > On Jan 23, 2008 6:48 PM, Philippe Gerum <rpm@xenomai.org> wrote:
 > >> Gilles Chanteperdrix wrote:
 > >>> Gilles Chanteperdrix wrote:
 > >>>  > Please find attached a patch implementing these ideas. This adds some
 > >>>  > clutter, which I would be happy to reduce. Better ideas are welcome.
 > >>>  >
 > >>>
 > >>> Ok. New version of the patch, this time split in two parts, should
 > >>> hopefully make it more readable.
 > >>>
 > >> Ack. I'd suggest the following:
 > >>
 > >> - let's have a rate limiter when walking the zombie queue in
 > >> __xnpod_finalize_zombies. We hold the superlock here, and what the patch
 > >> also introduces is the potential for flushing more than a single TCB at
 > >> a time, which might not always be a cheap operation, depending on which
 > >> cra^H^Hode runs on behalf of the deletion hooks for instance. We may
 > >> take for granted that no sane code would continuously create more
 > >> threads than we would be able to finalize in a given time frame anyway.
 > > 
 > > The maximum number of zombies in the queue is
 > > 1 + XNARCH_WANT_UNLOCKED_CTXSW, since a zombie is added to the queue
 > > only if a deleted thread is xnpod_current_thread(), or if the XNLOCKSW
 > > bit is armed.
 > 
 > Ack. rate_limit = 1? I'm really reluctant to increase the WCET here,
 > thread deletion isn't cheap already.

Here come new patches.

-- 


					    Gilles Chanteperdrix.

--XwDwx/E46I
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-rework-self-deletion.2.diff"
Content-Transfer-Encoding: 7bit

Index: include/asm-ia64/bits/pod.h
===================================================================
--- include/asm-ia64/bits/pod.h	(revision 3441)
+++ include/asm-ia64/bits/pod.h	(working copy)
@@ -100,12 +100,6 @@ static inline void xnarch_switch_to(xnar
 	}
 }
 
-static inline void xnarch_finalize_and_switch(xnarchtcb_t * dead_tcb,
-					      xnarchtcb_t * next_tcb)
-{
-	xnarch_switch_to(dead_tcb, next_tcb);
-}
-
 static inline void xnarch_finalize_no_switch(xnarchtcb_t * dead_tcb)
 {
 	/* Empty */
Index: include/asm-blackfin/bits/pod.h
===================================================================
--- include/asm-blackfin/bits/pod.h	(revision 3441)
+++ include/asm-blackfin/bits/pod.h	(working copy)
@@ -67,12 +67,6 @@ static inline void xnarch_switch_to(xnar
 	rthal_thread_switch(out_tcb->tsp, in_tcb->tsp);
 }
 
-static inline void xnarch_finalize_and_switch(xnarchtcb_t * dead_tcb,
-					      xnarchtcb_t * next_tcb)
-{
-	xnarch_switch_to(dead_tcb, next_tcb);
-}
-
 static inline void xnarch_finalize_no_switch(xnarchtcb_t * dead_tcb)
 {
 	/* Empty */
Index: include/asm-arm/bits/pod.h
===================================================================
--- include/asm-arm/bits/pod.h	(revision 3441)
+++ include/asm-arm/bits/pod.h	(working copy)
@@ -96,12 +96,6 @@ static inline void xnarch_switch_to(xnar
 	rthal_thread_switch(prev, out_tcb->tip, in_tcb->tip);
 }
 
-static inline void xnarch_finalize_and_switch(xnarchtcb_t * dead_tcb,
-					      xnarchtcb_t * next_tcb)
-{
-	xnarch_switch_to(dead_tcb, next_tcb);
-}
-
 static inline void xnarch_finalize_no_switch(xnarchtcb_t * dead_tcb)
 {
 	/* Empty */
Index: include/asm-powerpc/bits/pod.h
===================================================================
--- include/asm-powerpc/bits/pod.h	(revision 3441)
+++ include/asm-powerpc/bits/pod.h	(working copy)
@@ -106,12 +106,6 @@ static inline void xnarch_switch_to(xnar
 	barrier();
 }
 
-static inline void xnarch_finalize_and_switch(xnarchtcb_t * dead_tcb,
-					      xnarchtcb_t * next_tcb)
-{
-	xnarch_switch_to(dead_tcb, next_tcb);
-}
-
 static inline void xnarch_finalize_no_switch(xnarchtcb_t * dead_tcb)
 {
 	/* Empty */
Index: include/asm-x86/bits/pod_64.h
===================================================================
--- include/asm-x86/bits/pod_64.h	(revision 3441)
+++ include/asm-x86/bits/pod_64.h	(working copy)
@@ -96,12 +96,6 @@ static inline void xnarch_switch_to(xnar
 	stts();
 }
 
-static inline void xnarch_finalize_and_switch(xnarchtcb_t * dead_tcb,
-					      xnarchtcb_t * next_tcb)
-{
-	xnarch_switch_to(dead_tcb, next_tcb);
-}
-
 static inline void xnarch_finalize_no_switch(xnarchtcb_t * dead_tcb)
 {
 	/* Empty */
Index: include/asm-x86/bits/pod_32.h
===================================================================
--- include/asm-x86/bits/pod_32.h	(revision 3441)
+++ include/asm-x86/bits/pod_32.h	(working copy)
@@ -123,12 +123,6 @@ static inline void xnarch_switch_to(xnar
 	stts();
 }
 
-static inline void xnarch_finalize_and_switch(xnarchtcb_t * dead_tcb,
-					      xnarchtcb_t * next_tcb)
-{
-	xnarch_switch_to(dead_tcb, next_tcb);
-}
-
 static inline void xnarch_finalize_no_switch(xnarchtcb_t * dead_tcb)
 {
 	/* Empty */
Index: include/asm-sim/bits/pod.h
===================================================================
--- include/asm-sim/bits/pod.h	(revision 3441)
+++ include/asm-sim/bits/pod.h	(working copy)
@@ -38,12 +38,6 @@ static inline void xnarch_switch_to (xna
     __mvm_breakable(mvm_switch_threads)(out_tcb->vmthread,in_tcb->vmthread);
 }
 
-static inline void xnarch_finalize_and_switch (xnarchtcb_t *dead_tcb,
-					       xnarchtcb_t *next_tcb)
-{
-    mvm_finalize_switch_threads(dead_tcb->vmthread,next_tcb->vmthread);
-}
-
 static inline void xnarch_finalize_no_switch (xnarchtcb_t *dead_tcb)
 {
     if (dead_tcb->vmthread)	/* Might be unstarted. */
Index: include/nucleus/pod.h
===================================================================
--- include/nucleus/pod.h	(revision 3441)
+++ include/nucleus/pod.h	(working copy)
@@ -139,6 +139,7 @@ typedef struct xnsched {
 
 	xntimer_t htimer;	/*!< Host timer. */
 
+	xnqueue_t zombies;
 } xnsched_t;
 
 #define nkpod (&nkpod_struct)
@@ -238,6 +239,14 @@ static inline void xnpod_reset_watchdog(
 }
 #endif /* CONFIG_XENO_OPT_WATCHDOG */
 
+void __xnpod_finalize_zombies(xnsched_t *sched);
+
+static inline void xnpod_finalize_zombies(xnsched_t *sched)
+{
+	if (!emptyq_p(&sched->zombies))
+		__xnpod_finalize_zombies(sched);
+}
+
 	/* -- Beginning of the exported interface */
 
 #define xnpod_sched_slot(cpu) \
Index: ksrc/nucleus/pod.c
===================================================================
--- ksrc/nucleus/pod.c	(revision 3441)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -292,6 +292,7 @@ int xnpod_init(void)
 #endif /* CONFIG_SMP */
 		xntimer_set_name(&sched->htimer, htimer_name);
 		xntimer_set_sched(&sched->htimer, sched);
+		initq(&sched->zombies);
 	}
 
 	xnlock_put_irqrestore(&nklock, s);
@@ -545,63 +546,26 @@ static inline void xnpod_fire_callouts(x
 	__clrbits(sched->status, XNKCOUT);
 }
 
-static inline void xnpod_switch_zombie(xnthread_t *threadout,
-				       xnthread_t *threadin)
+void __xnpod_finalize_zombies(xnsched_t *sched)
 {
-	/* Must be called with nklock locked, interrupts off. */
-	xnsched_t *sched = xnpod_current_sched();
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-	int shadow = xnthread_test_state(threadout, XNSHADOW);
-#endif /* CONFIG_XENO_OPT_PERVASIVE */
+	xnthread_t *thread = link2thread(getq(&sched->zombies), glink);
 
+	/* Must be called with nklock locked, interrupts off. */
 	trace_mark(xn_nucleus_sched_finalize,
-		   "thread_out %p thread_out_name %s "
-		   "thread_in %p thread_in_name %s",
-		   threadout, xnthread_name(threadout),
-		   threadin, xnthread_name(threadin));
+		   "thread_out %p thread_out_name %s",
+		   thread, xnthread_name(thread));
 
-	if (!emptyq_p(&nkpod->tdeleteq) && !xnthread_test_state(threadout, XNROOT)) {
+	if (!emptyq_p(&nkpod->tdeleteq)
+	    && !xnthread_test_state(thread, XNROOT)) {
 		trace_mark(xn_nucleus_thread_callout,
 			   "thread %p thread_name %s hook %s",
-			   threadout, xnthread_name(threadout), "DELETE");
-		xnpod_fire_callouts(&nkpod->tdeleteq, threadout);
+			   thread, xnthread_name(thread), "DELETE");
+		xnpod_fire_callouts(&nkpod->tdeleteq, thread);
 	}
 
-	sched->runthread = threadin;
-
-	if (xnthread_test_state(threadin, XNROOT)) {
-		xnpod_reset_watchdog(sched);
-		xnfreesync();
-		xnarch_enter_root(xnthread_archtcb(threadin));
-	}
-
-	/* FIXME: Catch 22 here, whether we choose to run on an invalid
-	   stack (cleanup then hooks), or to access the TCB space shortly
-	   after it has been freed while non-preemptible (hooks then
-	   cleanup)... Option #2 is current. */
-
-	xnthread_cleanup_tcb(threadout);
+	xnthread_cleanup_tcb(thread);
 
-	xnstat_exectime_finalize(sched, &threadin->stat.account);
-
-	xnarch_finalize_and_switch(xnthread_archtcb(threadout),
-				   xnthread_archtcb(threadin));
-
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-	xnarch_trace_pid(xnthread_user_task(threadin) ?
-			 xnarch_user_pid(xnthread_archtcb(threadin)) : -1,
-			 xnthread_current_priority(threadin));
-
-	if (shadow)
-		/* Reap the user-space mate of a deleted real-time shadow.
-		   The Linux task has resumed into the Linux domain at the
-		   last code location executed by the shadow. Remember
-		   that both sides use the Linux task's stack. */
-		xnshadow_exit();
-#endif /* CONFIG_XENO_OPT_PERVASIVE */
-
-	xnpod_fatal("zombie thread %s (%p) would not die...", threadout->name,
-		    threadout);
+	xnarch_finalize_no_switch(xnthread_archtcb(thread));
 }
 
 /*! 
@@ -1216,6 +1180,7 @@ void xnpod_delete_thread(xnthread_t *thr
 		   the current one forever. Use the thread zombie state to go
 		   through the rescheduling procedure then actually destroy
 		   the thread object. */
+		appendq(&sched->zombies, &thread->glink);
 		xnsched_set_resched(sched);
 		xnpod_schedule();
 	} else {
@@ -2140,6 +2105,8 @@ void xnpod_dispatch_signals(void)
 
 void xnpod_welcome_thread(xnthread_t *thread, int imask)
 {
+	xnpod_finalize_zombies(thread->sched);
+
 	trace_mark(xn_nucleus_thread_boot, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
@@ -2373,6 +2340,7 @@ void xnpod_schedule(void)
 	xnthread_t *threadout, *threadin, *runthread;
 	xnpholder_t *pholder;
 	xnsched_t *sched;
+	int zombie;
 #if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 	int need_resched;
 #endif /* CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
@@ -2402,7 +2370,6 @@ void xnpod_schedule(void)
 	xnarch_trace_pid(xnthread_user_task(runthread) ?
 			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
 			 xnthread_current_priority(runthread));
-
 #if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 	need_resched = xnsched_tst_resched(sched);
 #endif
@@ -2429,13 +2396,16 @@ void xnpod_schedule(void)
 	/* Clear the rescheduling bit */
 	xnsched_clr_resched(sched);
 
+	zombie = xnthread_test_state(runthread, XNZOMBIE);
 	if (!xnthread_test_state(runthread, XNTHREAD_BLOCK_BITS | XNZOMBIE)) {
 
 		/* Do not preempt the current thread if it holds the
 		 * scheduler lock. */
 
-		if (xnthread_test_state(runthread, XNLOCK))
+		if (xnthread_test_state(runthread, XNLOCK)) {
+			xnsched_set_resched(sched);
 			goto signal_unlock_and_exit;
+		}
 
 		pholder = sched_getheadpq(&sched->readyq);
 
@@ -2491,9 +2461,6 @@ void xnpod_schedule(void)
 	shadow = xnthread_test_state(threadout, XNSHADOW);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
-	if (xnthread_test_state(threadout, XNZOMBIE))
-		xnpod_switch_zombie(threadout, threadin);
-
 	sched->runthread = threadin;
 
 	if (xnthread_test_state(threadout, XNROOT))
@@ -2525,23 +2492,16 @@ void xnpod_schedule(void)
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	/* Test whether we are relaxing a thread. In such a case, we are here the
 	   epilogue of Linux' schedule, and should skip xnpod_schedule epilogue. */
-	if (shadow && xnthread_test_state(runthread, XNROOT)) {
-		spl_t ignored;
-		/* Shadow on entry and root without shadow extension on exit? 
-		   Mmmm... This must be the user-space mate of a deleted real-time
-		   shadow we've just rescheduled in the Linux domain to have it
-		   exit properly.  Reap it now. */
-		if (xnshadow_thrptd(current) == NULL)
-			xnshadow_exit();
-
-		/* We need to relock nklock here, since it is not locked and
-		   the caller may expect it to be locked. */
-		xnlock_get_irqsave(&nklock, ignored);
-		xnlock_put_irqrestore(&nklock, s);
-		return;
-	}
+	if (shadow && xnthread_test_state(runthread, XNROOT))
+		goto relax_epilogue;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
+	if (zombie)
+		xnpod_fatal("zombie thread %s (%p) would not die...",
+			    threadout->name, threadout);
+
+	xnpod_finalize_zombies(sched);
+
 #ifdef CONFIG_XENO_HW_FPU
 	__xnpod_switch_fpu(sched);
 #endif /* CONFIG_XENO_HW_FPU */
@@ -2564,6 +2524,25 @@ void xnpod_schedule(void)
 		xnpod_dispatch_signals();
 
 	xnlock_put_irqrestore(&nklock, s);
+	return;
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+      relax_epilogue:
+	{
+		spl_t ignored;
+		/* Shadow on entry and root without shadow extension on exit? 
+		   Mmmm... This must be the user-space mate of a deleted real-time
+		   shadow we've just rescheduled in the Linux domain to have it
+		   exit properly.  Reap it now. */
+		if (xnshadow_thrptd(current) == NULL)
+			xnshadow_exit();
+
+		/* We need to relock nklock here, since it is not locked and
+		   the caller may expect it to be locked. */
+		xnlock_get_irqsave(&nklock, ignored);
+		xnlock_put_irqrestore(&nklock, s);
+	}
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
 }
 
 /*! 
@@ -2664,9 +2643,6 @@ void xnpod_schedule_runnable(xnthread_t 
 	if (threadin == runthread)
 		return;		/* No switch. */
 
-	if (xnthread_test_state(runthread, XNZOMBIE))
-		xnpod_switch_zombie(runthread, threadin);
-
 	sched->runthread = threadin;
 
 	if (xnthread_test_state(runthread, XNROOT))
@@ -2687,15 +2663,17 @@ void xnpod_schedule_runnable(xnthread_t 
 	xnarch_switch_to(xnthread_archtcb(runthread),
 			 xnthread_archtcb(threadin));
 
-	xnarch_trace_pid(xnthread_user_task(runthread) ?
-			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
-			 xnthread_current_priority(runthread));
-
 #ifdef CONFIG_SMP
 	/* If runthread migrated while suspended, sched is no longer correct. */
 	sched = xnpod_current_sched();
 #endif
 
+	xnpod_finalize_zombies(sched);
+
+	xnarch_trace_pid(xnthread_user_task(runthread) ?
+			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
+			 xnthread_current_priority(runthread));
+
 #ifdef CONFIG_XENO_HW_FPU
 	__xnpod_switch_fpu(sched);
 #endif /* CONFIG_XENO_HW_FPU */
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 3441)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -1059,6 +1059,7 @@ int xnshadow_harden(void)
 	struct task_struct *this_task = current;
 	struct __gatekeeper *gk;
 	xnthread_t *thread;
+	xnsched_t *sched;
 	int gk_cpu;
 
 redo:
@@ -1124,9 +1125,12 @@ redo:
 	}
 
 	/* "current" is now running into the Xenomai domain. */
+	sched = xnpod_current_sched();
+
+	xnpod_finalize_zombies(sched);
 
 #ifdef CONFIG_XENO_HW_FPU
-	xnpod_switch_fpu(xnpod_current_sched());
+	xnpod_switch_fpu(sched);
 #endif /* CONFIG_XENO_HW_FPU */
 
 	xnarch_schedule_tail(this_task);

--XwDwx/E46I
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-unlocked-arm-ctx-switch.3.diff"
Content-Transfer-Encoding: 7bit

diff -Naurdp -x .svn -x '*~' -x 'klat_mod.*' rework_self_deletion/include/asm-arm/bits/pod.h trunk/include/asm-arm/bits/pod.h
--- rework_self_deletion/include/asm-arm/bits/pod.h	2008-01-23 22:54:20.000000000 +0100
+++ trunk/include/asm-arm/bits/pod.h	2008-01-15 00:43:50.000000000 +0100
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
diff -Naurdp -x .svn -x '*~' -x 'klat_mod.*' rework_self_deletion/include/asm-arm/system.h trunk/include/asm-arm/system.h
--- rework_self_deletion/include/asm-arm/system.h	2008-01-15 21:13:47.000000000 +0100
+++ trunk/include/asm-arm/system.h	2008-01-15 00:30:47.000000000 +0100
@@ -31,6 +31,8 @@
 
 #define XNARCH_THREAD_STACKSZ   4096
 
+#define XNARCH_WANT_UNLOCKED_CTXSW
+
 #define xnarch_stack_size(tcb)  ((tcb)->stacksize)
 #define xnarch_user_task(tcb)   ((tcb)->user_task)
 #define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
diff -Naurdp -x .svn -x '*~' -x 'klat_mod.*' rework_self_deletion/include/nucleus/pod.h trunk/include/nucleus/pod.h
--- rework_self_deletion/include/nucleus/pod.h	2008-01-15 21:13:28.000000000 +0100
+++ trunk/include/nucleus/pod.h	2008-01-23 22:35:45.000000000 +0100
@@ -140,6 +140,10 @@ typedef struct xnsched {
 	xntimer_t htimer;	/*!< Host timer. */
 
 	xnqueue_t zombies;
+
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+	xnthread_t *lastthread;
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
 } xnsched_t;
 
 #define nkpod (&nkpod_struct)
@@ -457,6 +461,27 @@ static inline void xnpod_delete_self(voi
 	xnpod_delete_thread(xnpod_current_thread());
 }
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+static inline void xnpod_finish_unlocked_switch(xnsched_t *sched)
+{
+	xnthread_clear_state(sched->lastthread, XNSWLOCK);
+	xnthread_clear_state(sched->runthread, XNSWLOCK);
+
+	/* Detect a thread which called xnpod_migrate_thread */
+	if (sched->lastthread->sched != sched)
+		xnpod_resume_thread(sched->lastthread, 0);
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
diff -Naurdp -x .svn -x '*~' -x 'klat_mod.*' rework_self_deletion/include/nucleus/thread.h trunk/include/nucleus/thread.h
--- rework_self_deletion/include/nucleus/thread.h	2008-01-15 21:13:13.000000000 +0100
+++ trunk/include/nucleus/thread.h	2008-01-13 22:21:03.000000000 +0100
@@ -61,6 +61,7 @@
 #define XNFPU     0x00100000 /**< Thread uses FPU */
 #define XNSHADOW  0x00200000 /**< Shadow thread */
 #define XNROOT    0x00400000 /**< Root thread (that is, Linux/IDLE) */
+#define XNSWLOCK  0x00800000 /**< Thread is currently switching context. */
 
 /*! @} */ /* Ends doxygen comment group: nucleus_state_flags */
 
diff -Naurdp -x .svn -x '*~' -x 'klat_mod.*' rework_self_deletion/ksrc/nucleus/pod.c trunk/ksrc/nucleus/pod.c
--- rework_self_deletion/ksrc/nucleus/pod.c	2008-01-23 22:48:38.000000000 +0100
+++ trunk/ksrc/nucleus/pod.c	2008-01-23 23:33:52.000000000 +0100
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
@@ -395,6 +411,9 @@ int xnpod_init(void)
 		appendq(&pod->threadq, &sched->rootcb.glink);
 
 		sched->runthread = &sched->rootcb;
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+		sched->lastthread = &sched->rootcb;
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
 #ifdef CONFIG_XENO_HW_FPU
 		sched->fpuholder = &sched->rootcb;
 #endif /* CONFIG_XENO_HW_FPU */
@@ -550,6 +569,13 @@ void __xnpod_finalize_zombies(xnsched_t 
 {
 	xnthread_t *thread = link2thread(getq(&sched->zombies), glink);
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+	if (thread == sched->runthread) {
+		appendq(&sched->zombies, &thread->glink);
+		return;
+	}
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
+
 	/* Must be called with nklock locked, interrupts off. */
 	trace_mark(xn_nucleus_sched_finalize,
 		   "thread_out %p thread_out_name %s",
@@ -1175,7 +1201,12 @@ void xnpod_delete_thread(xnthread_t *thr
 
 	xnthread_set_state(thread, XNZOMBIE);
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW		
+	if (sched->runthread == thread
+	    || xnthread_test_state(thread, XNSWLOCK)) {
+#else /* XNARCH_WANT_UNLOCKED_CTXSW */
 	if (sched->runthread == thread) {
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
 		/* We first need to elect a new runthread before switching out
 		   the current one forever. Use the thread zombie state to go
 		   through the rescheduling procedure then actually destroy
@@ -1862,8 +1893,10 @@ int xnpod_migrate_thread(int cpu)
 	/* Migrate the thread periodic timer. */
 	xntimer_set_sched(&thread->ptimer, thread->sched);
 
+#ifndef XNARCH_WANT_UNLOCKED_CTXSW
 	/* Put thread in the ready queue of the destination CPU's scheduler. */
 	xnpod_resume_thread(thread, 0);
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
 
 	xnpod_schedule();
 
@@ -2105,6 +2138,8 @@ void xnpod_dispatch_signals(void)
 
 void xnpod_welcome_thread(xnthread_t *thread, int imask)
 {
+	xnpod_finish_unlocked_switch(thread->sched);
+
 	xnpod_finalize_zombies(thread->sched);
 
 	trace_mark(xn_nucleus_thread_boot, "thread %p thread_name %s",
@@ -2141,6 +2176,8 @@ void xnpod_welcome_thread(xnthread_t *th
 
 	xnlock_clear_irqoff(&nklock);
 	splexit(!!imask);
+
+	xnpod_resched_after_unlocked_switch();
 }
 
 #ifdef CONFIG_XENO_HW_FPU
@@ -2370,6 +2407,9 @@ void xnpod_schedule(void)
 	xnarch_trace_pid(xnthread_user_task(runthread) ?
 			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
 			 xnthread_current_priority(runthread));
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+      restart:
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
 #if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 	need_resched = xnsched_tst_resched(sched);
 #endif
@@ -2393,6 +2433,11 @@ void xnpod_schedule(void)
 
 #endif /* CONFIG_SMP */
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+	if (xnthread_test_state(runthread, XNSWLOCK))
+		goto unlock_and_exit;
+#endif /* XNARCH_WANT_UNLOCKED_CTXSW */
+
 	/* Clear the rescheduling bit */
 	xnsched_clr_resched(sched);
 
@@ -2474,8 +2519,7 @@ void xnpod_schedule(void)
 	xnstat_exectime_switch(sched, &threadin->stat.account);
 	xnstat_counter_inc(&threadin->stat.csw);
 
-	xnarch_switch_to(xnthread_archtcb(threadout),
-			 xnthread_archtcb(threadin));
+	xnpod_switch_to(sched, threadout, threadin);
 
 #ifdef CONFIG_SMP
 	/* If threadout migrated while suspended, sched is no longer correct. */
@@ -2500,6 +2544,8 @@ void xnpod_schedule(void)
 		xnpod_fatal("zombie thread %s (%p) would not die...",
 			    threadout->name, threadout);
 
+	xnpod_finish_unlocked_switch(sched);
+
 	xnpod_finalize_zombies(sched);
 
 #ifdef CONFIG_XENO_HW_FPU
@@ -2518,11 +2564,22 @@ void xnpod_schedule(void)
 		xnpod_fire_callouts(&nkpod->tswitchq, runthread);
 	}
 
+#ifdef XNARCH_WANT_UNLOCKED_CTXSW
+	if (xnsched_resched_p()) {
+		if (xnthread_signaled_p(runthread))
+			xnpod_dispatch_signals();
+		goto restart;
+	}
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
 
@@ -2660,14 +2717,15 @@ void xnpod_schedule_runnable(xnthread_t 
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
 	xnpod_finalize_zombies(sched);
 
 	xnarch_trace_pid(xnthread_user_task(runthread) ?
@@ -2682,6 +2740,8 @@ void xnpod_schedule_runnable(xnthread_t 
 	if (nkpod->schedhook && runthread == sched->runthread)
 		nkpod->schedhook(runthread, XNRUNNING);
 #endif /* __XENO_SIM__ */
+
+	xnpod_resched_after_unlocked_switch();
 }
 
 /*! 
diff -Naurdp -x .svn -x '*~' -x 'klat_mod.*' rework_self_deletion/ksrc/nucleus/shadow.c trunk/ksrc/nucleus/shadow.c
--- rework_self_deletion/ksrc/nucleus/shadow.c	2008-01-15 21:14:36.000000000 +0100
+++ trunk/ksrc/nucleus/shadow.c	2008-01-23 22:20:47.000000000 +0100
@@ -1127,6 +1127,8 @@ redo:
 	/* "current" is now running into the Xenomai domain. */
 	sched = xnpod_current_sched();
 
+	xnpod_finish_unlocked_switch(sched);
+
 	xnpod_finalize_zombies(sched);
 
 #ifdef CONFIG_XENO_HW_FPU
@@ -1153,6 +1155,8 @@ redo:
 	trace_mark(xn_nucleus_shadow_hardened, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
+	xnpod_resched_after_unlocked_switch();
+
 	return 0;
 }
 

--XwDwx/E46I--

