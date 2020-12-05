From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/4] cobalt/kernel: drop support for preemptible context
 switching
Date: Sat,  5 Dec 2020 13:00:12 +0100
Message-Id: <20201205120014.2754097-3-rpm@xenomai.org>
In-Reply-To: <20201205120014.2754097-1-rpm@xenomai.org>
References: <20201205120014.2754097-1-rpm@xenomai.org>
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

We have no architecture enabling this feature anymore.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/sched.h       | 34 ---------------
 include/cobalt/kernel/thread.h      |  2 +-
 include/cobalt/uapi/kernel/thread.h |  1 -
 kernel/cobalt/sched.c               | 66 ++---------------------------
 kernel/cobalt/thread.c              | 23 +---------
 5 files changed, 5 insertions(+), 121 deletions(-)

diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index 1f5714fe0..5d278838f 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -94,9 +94,6 @@ struct xnsched {
 	struct xntimer rrbtimer;
 	/*!< Root thread control block. */
 	struct xnthread rootcb;
-#ifdef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
-	struct xnthread *last;
-#endif
 #ifdef CONFIG_XENO_ARCH_FPU
 	/*!< Thread owning the current FPU context. */
 	struct xnthread *fpuholder;
@@ -351,37 +348,6 @@ static inline int xnsched_primary_p(void)
 	return !xnsched_unblockable_p();
 }
 
-#ifdef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
-
-struct xnsched *xnsched_finish_unlocked_switch(struct xnsched *sched);
-
-#define xnsched_resched_after_unlocked_switch() xnsched_run()
-
-static inline
-int xnsched_maybe_resched_after_unlocked_switch(struct xnsched *sched)
-{
-	return sched->status & XNRESCHED;
-}
-
-#else /* !CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH */
-
-static inline struct xnsched *
-xnsched_finish_unlocked_switch(struct xnsched *sched)
-{
-	XENO_BUG_ON(COBALT, !hard_irqs_disabled());
-	return xnsched_current();
-}
-
-static inline void xnsched_resched_after_unlocked_switch(void) { }
-
-static inline int
-xnsched_maybe_resched_after_unlocked_switch(struct xnsched *sched)
-{
-	return 0;
-}
-
-#endif /* !CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH */
-
 bool xnsched_set_effective_priority(struct xnthread *thread,
 				    int prio);
 
diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 03adb2529..21a8603b4 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -38,7 +38,7 @@
  * @addtogroup cobalt_core_thread
  * @{
  */
-#define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNMIGRATE|XNHELD|XNDBGSTOP)
+#define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNHELD|XNDBGSTOP)
 #define XNTHREAD_MODE_BITS    (XNRRB|XNWARN|XNTRAPLB)
 
 struct xnthread;
diff --git a/include/cobalt/uapi/kernel/thread.h b/include/cobalt/uapi/kernel/thread.h
index 0802a16dc..664def08e 100644
--- a/include/cobalt/uapi/kernel/thread.h
+++ b/include/cobalt/uapi/kernel/thread.h
@@ -37,7 +37,6 @@
 #define XNZOMBIE  0x00000020 /**< Zombie thread in deletion process */
 #define XNMAPPED  0x00000040 /**< Thread is mapped to a linux task */
 #define XNRELAX   0x00000080 /**< Relaxed shadow thread (blocking bit) */
-#define XNMIGRATE 0x00000100 /**< Thread is currently migrating to another CPU. */
 #define XNHELD    0x00000200 /**< Thread is held to process emergency. */
 #define XNBOOST   0x00000400 /**< PI/PP boost undergoing */
 #define XNSSTEP   0x00000800 /**< Single-stepped by debugger */
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 75adbc49e..7ff8a6c82 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -345,34 +345,6 @@ struct xnthread *xnsched_pick_next(struct xnsched *sched)
 #endif /* CONFIG_XENO_OPT_SCHED_CLASSES */
 }
 
-#ifdef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
-
-struct xnsched *xnsched_finish_unlocked_switch(struct xnsched *sched)
-{
-	struct xnthread *last;
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
-
-#ifdef CONFIG_SMP
-	/* If current thread migrated while suspended */
-	sched = xnsched_current();
-#endif /* CONFIG_SMP */
-
-	last = sched->last;
-	sched->status &= ~XNINSW;
-
-	/* Detect a thread which has migrated. */
-	if (last->sched != sched) {
-		xnsched_putback(last);
-		xnthread_clear_state(last, XNMIGRATE);
-	}
-
-	return sched;
-}
-
-#endif /* CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH */
-
 void xnsched_lock(void)
 {
 	struct xnsched *sched = xnsched_current();
@@ -628,17 +600,8 @@ void xnsched_migrate(struct xnthread *thread, struct xnsched *sched)
 {
 	xnsched_set_resched(thread->sched);
 	migrate_thread(thread, sched);
-
-#ifdef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
-	/*
-	 * Mark the thread in flight, xnsched_finish_unlocked_switch()
-	 * will put the thread on the remote runqueue.
-	 */
-	xnthread_set_state(thread, XNMIGRATE);
-#else
 	/* Move thread to the remote run queue. */
 	xnsched_putback(thread);
-#endif
 }
 
 /*
@@ -840,18 +803,6 @@ struct xnthread *xnsched_rt_pick(struct xnsched *sched)
 
 #endif /* !CONFIG_XENO_OPT_SCALABLE_SCHED */
 
-static inline void switch_context(struct xnsched *sched,
-				  struct xnthread *prev, struct xnthread *next)
-{
-#ifdef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
-	sched->last = prev;
-	sched->status |= XNINSW;
-	xnlock_clear_irqon(&nklock);
-#endif
-
-	xnarch_switch_to(prev, next);
-}
-
 /**
  * @fn int xnsched_run(void)
  * @brief The rescheduling procedure.
@@ -920,15 +871,9 @@ static inline int test_resched(struct xnsched *sched)
 
 static inline void enter_root(struct xnthread *root)
 {
-	struct xnarchtcb *rootcb __maybe_unused = xnthread_archtcb(root);
-
 #ifdef CONFIG_XENO_OPT_WATCHDOG
 	xntimer_stop(&root->sched->wdtimer);
 #endif
-#ifdef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
-	if (rootcb->core.mm == NULL)
-		set_ti_thread_flag(rootcb->core.tip, TIF_MMSWITCH_INT);
-#endif
 }
 
 static inline void leave_root(struct xnthread *root)
@@ -984,7 +929,7 @@ int ___xnsched_run(struct xnsched *sched)
 	 * "current" for disambiguating.
 	 */
 	xntrace_pid(task_pid_nr(current), xnthread_current_priority(curr));
-reschedule:
+
 	if (xnthread_test_state(curr, XNUSER))
 		do_lazy_user_work(curr);
 
@@ -1030,8 +975,7 @@ reschedule:
 
 	xnstat_exectime_switch(sched, &next->stat.account);
 	xnstat_counter_inc(&next->stat.csw);
-
-	switch_context(sched, prev, next);
+	xnarch_switch_to(prev, next);
 
 	/*
 	 * Test whether we transitioned from primary mode to secondary
@@ -1043,7 +987,7 @@ reschedule:
 		goto shadow_epilogue;
 
 	switched = 1;
-	sched = xnsched_finish_unlocked_switch(sched);
+	sched = xnsched_current();
 	/*
 	 * Re-read the currently running thread, this is needed
 	 * because of relaxed/hardened transitions.
@@ -1052,10 +996,6 @@ reschedule:
 	xnthread_switch_fpu(sched);
 	xntrace_pid(task_pid_nr(current), xnthread_current_priority(curr));
 out:
-	if (switched &&
-	    xnsched_maybe_resched_after_unlocked_switch(sched))
-		goto reschedule;
-
 	xnlock_put_irqrestore(&nklock, s);
 
 	return switched;
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 5260fb1e7..49f749f1c 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -406,22 +406,6 @@ void xnthread_prepare_wait(struct xnthread_wait_context *wc)
 }
 EXPORT_SYMBOL_GPL(xnthread_prepare_wait);
 
-static inline int moving_target(struct xnsched *sched, struct xnthread *thread)
-{
-	int ret = 0;
-#ifdef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
-	/*
-	 * When deleting a thread in the course of a context switch or
-	 * in flight to another CPU with nklock unlocked on a distant
-	 * CPU, do nothing, this case will be caught in
-	 * xnsched_finish_unlocked_switch.
-	 */
-	ret = (sched->status & XNINSW) ||
-		xnthread_test_state(thread, XNMIGRATE);
-#endif
-	return ret;
-}
-
 #ifdef CONFIG_XENO_ARCH_FPU
 
 static inline void giveup_fpu(struct xnsched *sched,
@@ -494,10 +478,6 @@ static inline void cleanup_tcb(struct xnthread *curr) /* nklock held, irqs off *
 	release_all_ownerships(curr);
 
 	giveup_fpu(sched, curr);
-
-	if (moving_target(sched, curr))
-		return;
-
 	xnsched_forget(curr);
 	xnthread_deregister(curr);
 }
@@ -1954,11 +1934,10 @@ int xnthread_harden(void)
 	}
 
 	/* "current" is now running into the Xenomai domain. */
-	sched = xnsched_finish_unlocked_switch(thread->sched);
+	sched = xnsched_current();
 	xnthread_switch_fpu(sched);
 
 	xnlock_clear_irqon(&nklock);
-	xnsched_resched_after_unlocked_switch();
 	xnthread_test_cancel();
 
 	trace_cobalt_shadow_hardened(thread);
-- 
2.26.2


