From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FeLJKQTqpj"
Content-Transfer-Encoding: 7bit
Message-ID: <18341.1770.265532.776584@domain.hid>
Date: Sun, 3 Feb 2008 01:12:26 +0100
In-Reply-To: <18341.1681.919618.418201@domain.hid>
References: <18341.1681.919618.418201@domain.hid>
Subject: [Xenomai-core] [PATCH 1/3] rework self deletion.
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


--FeLJKQTqpj
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


This patch splits zombie thread finalization after self-deletion in two parts: 
- running the hooks is made before the context switch;
- freeing the thread stack is done after the context switch;
In order to prevent xnfreesync from freeing the thread tcb before its stack has
been freed:
- xnfreesync is run before running the deletion hooks;
- the nkheap has now an idleq by cpu.

The zombies queue has been replaced with a zombie pointer since there was at
most one element in the queue anyway.

Stats:
 include/asm-arm/bits/pod.h      |    6 -
 include/asm-blackfin/bits/pod.h |    6 -
 include/asm-ia64/bits/pod.h     |    6 -
 include/asm-powerpc/bits/pod.h  |    6 -
 include/asm-sim/bits/pod.h      |    6 -
 include/asm-x86/bits/pod_32.h   |    6 -
 include/asm-x86/bits/pod_64.h   |    6 -
 include/nucleus/heap.h          |    2
 include/nucleus/pod.h           |    9 ++
 ksrc/nucleus/heap.c             |   16 +++-
 ksrc/nucleus/pod.c              |  142 ++++++++++++++++++----------------------
 ksrc/nucleus/shadow.c           |    6 +

-- 


					    Gilles Chanteperdrix.

--FeLJKQTqpj
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-rework-self-deletion.4.diff"
Content-Transfer-Encoding: 7bit

--- include/asm-ia64/bits/pod.h	(revision 3455)
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
--- include/asm-blackfin/bits/pod.h	(revision 3455)
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
--- include/asm-arm/bits/pod.h	(revision 3455)
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
--- include/asm-powerpc/bits/pod.h	(revision 3455)
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
--- include/asm-x86/bits/pod_64.h	(revision 3455)
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
--- include/asm-x86/bits/pod_32.h	(revision 3455)
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
--- include/asm-sim/bits/pod.h	(revision 3455)
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
--- include/nucleus/heap.h	(revision 3455)
+++ include/nucleus/heap.h	(working copy)
@@ -97,7 +97,7 @@ typedef struct xnheap {
 		int fcount;
 	} buckets[XNHEAP_NBUCKETS];
 
-	xnholder_t *idleq;
+	xnholder_t *idleq[XNARCH_NR_CPUS];
 
 	xnarch_heapcb_t archdep;
 
--- include/nucleus/pod.h	(revision 3455)
+++ include/nucleus/pod.h	(working copy)
@@ -139,6 +139,7 @@ typedef struct xnsched {
 
 	xntimer_t htimer;	/*!< Host timer. */
 
+	xnthread_t *zombie;
 } xnsched_t;
 
 #define nkpod (&nkpod_struct)
@@ -238,6 +239,14 @@ static inline void xnpod_reset_watchdog(
 }
 #endif /* CONFIG_XENO_OPT_WATCHDOG */
 
+void __xnpod_finalize_zombie(xnsched_t *sched);
+
+static inline void xnpod_finalize_zombie(xnsched_t *sched)
+{
+	if (sched->zombie)
+		__xnpod_finalize_zombie(sched);
+}
+
 	/* -- Beginning of the exported interface */
 
 #define xnpod_sched_slot(cpu) \
--- ksrc/nucleus/heap.c	(revision 3455)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -163,6 +163,7 @@ static void init_extent(xnheap_t *heap, 
 int xnheap_init(xnheap_t *heap,
 		void *heapaddr, u_long heapsize, u_long pagesize)
 {
+	unsigned cpu, nr_cpus = xnarch_num_online_cpus();
 	u_long hdrsize, shiftsize, pageshift;
 	xnextent_t *extent;
 
@@ -218,7 +219,8 @@ int xnheap_init(xnheap_t *heap,
 
 	heap->ubytes = 0;
 	heap->maxcont = heap->npages * pagesize;
-	heap->idleq = NULL;
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		heap->idleq[cpu] = NULL;
 	inith(&heap->link);
 	initq(&heap->extents);
 	xnlock_init(&heap->lock);
@@ -866,6 +868,7 @@ int xnheap_extend(xnheap_t *heap, void *
 
 void xnheap_schedule_free(xnheap_t *heap, void *block, xnholder_t *link)
 {
+	unsigned cpu;
 	spl_t s;
 
 	xnlock_get_irqsave(&heap->lock, s);
@@ -873,21 +876,24 @@ void xnheap_schedule_free(xnheap_t *heap
 	   idle objects through the 'next' field, so the 'last' field of
 	   the link is used to point at the beginning of the freed
 	   memory. */
+	cpu = xnarch_current_cpu();
 	link->last = (xnholder_t *)block;
-	link->next = heap->idleq;
-	heap->idleq = link;
+	link->next = heap->idleq[cpu];
+	heap->idleq[cpu] = link;
 	xnlock_put_irqrestore(&heap->lock, s);
 }
 
 void xnheap_finalize_free_inner(xnheap_t *heap)
 {
 	xnholder_t *holder;
+	unsigned cpu;
 	spl_t s;
 
 	xnlock_get_irqsave(&heap->lock, s);
+	cpu = xnarch_current_cpu();
 
-	while ((holder = heap->idleq) != NULL) {
-		heap->idleq = holder->next;
+	while ((holder = heap->idleq[cpu]) != NULL) {
+		heap->idleq[cpu] = holder->next;
 		xnheap_free(heap, holder->last);
 	}
 
--- ksrc/nucleus/pod.c	(revision 3455)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -292,6 +292,7 @@ int xnpod_init(void)
 #endif /* CONFIG_SMP */
 		xntimer_set_name(&sched->htimer, htimer_name);
 		xntimer_set_sched(&sched->htimer, sched);
+		sched->zombie = NULL;
 	}
 
 	xnlock_put_irqrestore(&nklock, s);
@@ -545,63 +546,34 @@ static inline void xnpod_fire_callouts(x
 	__clrbits(sched->status, XNKCOUT);
 }
 
-static inline void xnpod_switch_zombie(xnthread_t *threadout,
-				       xnthread_t *threadin)
+static void xnpod_zombie_hooks(xnthread_t *thread)
 {
-	/* Must be called with nklock locked, interrupts off. */
-	xnsched_t *sched = xnpod_current_sched();
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-	int shadow = xnthread_test_state(threadout, XNSHADOW);
-#endif /* CONFIG_XENO_OPT_PERVASIVE */
+	XENO_BUGON(NUCLEUS, thread->sched->zombie != NULL);
+	thread->sched->zombie = thread;
 
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
+}
 
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
-
-	xnstat_exectime_finalize(sched, &threadin->stat.account);
+void __xnpod_finalize_zombie(xnsched_t *sched)
+{
+	xnthread_t *thread = sched->zombie;
 
-	xnarch_finalize_and_switch(xnthread_archtcb(threadout),
-				   xnthread_archtcb(threadin));
+	xnthread_cleanup_tcb(thread);
 
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
+	xnarch_finalize_no_switch(xnthread_archtcb(thread));
 
-	xnpod_fatal("zombie thread %s (%p) would not die...", threadout->name,
-		    threadout);
+	sched->zombie = NULL;
 }
 
 /*! 
@@ -2140,6 +2112,8 @@ void xnpod_dispatch_signals(void)
 
 void xnpod_welcome_thread(xnthread_t *thread, int imask)
 {
+	xnpod_finalize_zombie(thread->sched);
+
 	trace_mark(xn_nucleus_thread_boot, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 
@@ -2373,6 +2347,7 @@ void xnpod_schedule(void)
 	xnthread_t *threadout, *threadin, *runthread;
 	xnpholder_t *pholder;
 	xnsched_t *sched;
+	int zombie;
 #if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 	int need_resched;
 #endif /* CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
@@ -2402,7 +2377,6 @@ void xnpod_schedule(void)
 	xnarch_trace_pid(xnthread_user_task(runthread) ?
 			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
 			 xnthread_current_priority(runthread));
-
 #if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 	need_resched = xnsched_tst_resched(sched);
 #endif
@@ -2429,13 +2403,16 @@ void xnpod_schedule(void)
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
 
@@ -2491,18 +2468,20 @@ void xnpod_schedule(void)
 	shadow = xnthread_test_state(threadout, XNSHADOW);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
-	if (xnthread_test_state(threadout, XNZOMBIE))
-		xnpod_switch_zombie(threadout, threadin);
+	if (xnthread_test_state(threadin, XNROOT)) {
+		xnpod_reset_watchdog(sched);
+		xnfreesync();
+	}
+
+	if (zombie)
+		xnpod_zombie_hooks(threadout);
 
 	sched->runthread = threadin;
 
 	if (xnthread_test_state(threadout, XNROOT))
 		xnarch_leave_root(xnthread_archtcb(threadout));
-	else if (xnthread_test_state(threadin, XNROOT)) {
-		xnpod_reset_watchdog(sched);
-		xnfreesync();
+	else if (xnthread_test_state(threadin, XNROOT))
 		xnarch_enter_root(xnthread_archtcb(threadin));
-	}
 
 	xnstat_exectime_switch(sched, &threadin->stat.account);
 	xnstat_counter_inc(&threadin->stat.csw);
@@ -2525,23 +2504,16 @@ void xnpod_schedule(void)
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
+	xnpod_finalize_zombie(sched);
+
 #ifdef CONFIG_XENO_HW_FPU
 	__xnpod_switch_fpu(sched);
 #endif /* CONFIG_XENO_HW_FPU */
@@ -2564,6 +2536,25 @@ void xnpod_schedule(void)
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
@@ -2664,9 +2655,6 @@ void xnpod_schedule_runnable(xnthread_t 
 	if (threadin == runthread)
 		return;		/* No switch. */
 
-	if (xnthread_test_state(runthread, XNZOMBIE))
-		xnpod_switch_zombie(runthread, threadin);
-
 	sched->runthread = threadin;
 
 	if (xnthread_test_state(runthread, XNROOT))
@@ -2687,15 +2675,17 @@ void xnpod_schedule_runnable(xnthread_t 
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
 
+	xnpod_finalize_zombie(sched);
+
+	xnarch_trace_pid(xnthread_user_task(runthread) ?
+			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
+			 xnthread_current_priority(runthread));
+
 #ifdef CONFIG_XENO_HW_FPU
 	__xnpod_switch_fpu(sched);
 #endif /* CONFIG_XENO_HW_FPU */
--- ksrc/nucleus/shadow.c	(revision 3455)
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
+	xnpod_finalize_zombie(sched);
 
 #ifdef CONFIG_XENO_HW_FPU
-	xnpod_switch_fpu(xnpod_current_sched());
+	xnpod_switch_fpu(sched);
 #endif /* CONFIG_XENO_HW_FPU */
 
 	xnarch_schedule_tail(this_task);

--FeLJKQTqpj--

