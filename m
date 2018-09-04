From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 4 Sep 2018 16:24:01 +0200
Message-Id: <E1fxEEk-0004UH-R6@xenomai.org>
Subject: [Xenomai] [PATCH] cobalt/sched: improve watchdog accuracy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The original watchdog mechanism was based on a sampling method: every
second (built-in value), it used to check the runtime mode of the
current task preempted on the ticking CPU. A per-cpu counter was
increased by one every time rt/primary mode was detected, then checked
against the trigger limit (CONFIG_XENO_OPT_WATCHDOG_TIMEOUT).
Otherwise, the counter was reset to zero.

With this fairly naive approach, it only takes a single hit with
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=1 to trigger the watchdog, i.e. if
the system-fixed 1s watchdog tick preempts any Xenomai task when it is
running in primary mode on the current CPU, the watchdog fires.

The default value of 4s papered over the inherent imprecision of such
a coarse-grained method, lengthening the odds of observing false
positive triggers.

To improve the accuracy of the watchdog, arm the watchdog timer to
fire at the final trigger date directly, right before switching the
CPU to primary mode (leave_root()), disarming it when the CPU is about
to switch back to secondary mode (enter_root()).

Better accuracy comes at the expense of slightly more overhead when
transitioning between primary and secondary modes, which should be
acceptable for a debug feature which is not affecting the hot path
anyway (i.e. there is no added cost for strictly rt context switches).

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/sched.h | 13 -------------
 kernel/cobalt/sched.c         | 41 ++++++++++++++++++++++++++---------------
 kernel/cobalt/timer.c         |  7 -------
 3 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index 03436ee82..0d0c71b42 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -104,8 +104,6 @@ struct xnsched {
 #ifdef CONFIG_XENO_OPT_WATCHDOG
 	/*!< Watchdog timer object. */
 	struct xntimer wdtimer;
-	/*!< Watchdog tick count. */
-	int wdcount;
 #endif
 #ifdef CONFIG_XENO_OPT_STATS
 	/*!< Last account switch date (ticks). */
@@ -361,17 +359,6 @@ xnsched_maybe_resched_after_unlocked_switch(struct xnsched *sched)
 
 #endif /* !CONFIG_XENO_ARCH_UNLOCKED_SWITCH */
 
-#ifdef CONFIG_XENO_OPT_WATCHDOG
-static inline void xnsched_reset_watchdog(struct xnsched *sched)
-{
-	sched->wdcount = 0;
-}
-#else /* !CONFIG_XENO_OPT_WATCHDOG */
-static inline void xnsched_reset_watchdog(struct xnsched *sched)
-{
-}
-#endif /* CONFIG_XENO_OPT_WATCHDOG */
-
 #include <cobalt/kernel/sched-idle.h>
 #include <cobalt/kernel/sched-rt.h>
 
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 76e3bc5d7..dd14d4975 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -93,14 +93,20 @@ void xnsched_register_classes(void)
 static unsigned long wd_timeout_arg = CONFIG_XENO_OPT_WATCHDOG_TIMEOUT;
 module_param_named(watchdog_timeout, wd_timeout_arg, ulong, 0644);
 
+static inline xnticks_t get_watchdog_timeout(void)
+{
+	return wd_timeout_arg * 1000000000ULL;
+}
+
 /**
  * @internal
  * @fn void watchdog_handler(struct xntimer *timer)
  * @brief Process watchdog ticks.
  *
- * This internal routine handles incoming watchdog ticks to detect
- * software lockups. It kills any offending thread which is found to
- * monopolize the CPU so as to starve the Linux kernel for too long.
+ * This internal routine handles incoming watchdog triggers to detect
+ * software lockups. It forces the offending thread to stop
+ * monopolizing the CPU, either by kicking it out of primary mode if
+ * running in user space, or cancelling it if kernel-based.
  *
  * @coretags{coreirq-only, atomic-entry}
  */
@@ -109,14 +115,15 @@ static void watchdog_handler(struct xntimer *timer)
 	struct xnsched *sched = xnsched_current();
 	struct xnthread *curr = sched->curr;
 
-	if (likely(xnthread_test_state(curr, XNROOT))) {
-		xnsched_reset_watchdog(sched);
-		return;
-	}
-
-	if (likely(++sched->wdcount < wd_timeout_arg))
+	/*
+	 * CAUTION: The watchdog tick might have been delayed while we
+	 * were busy switching the CPU to secondary mode at the
+	 * trigger date eventually. Make sure that we are not about to
+	 * kick the incoming root thread.
+	 */
+	if (xnthread_test_state(curr, XNROOT))
 		return;
-
+	
 	trace_cobalt_watchdog_signal(curr);
 
 	if (xnthread_test_state(curr, XNUSER)) {
@@ -137,8 +144,6 @@ static void watchdog_handler(struct xntimer *timer)
 		 */
 		xnthread_set_info(curr, XNKICKED|XNCANCELD);
 	}
-
-	xnsched_reset_watchdog(sched);
 }
 
 #endif /* CONFIG_XENO_OPT_WATCHDOG */
@@ -818,6 +823,10 @@ static inline void enter_root(struct xnthread *root)
 {
 	struct xnarchtcb *rootcb __maybe_unused = xnthread_archtcb(root);
 
+#ifdef CONFIG_XENO_OPT_WATCHDOG
+	xntimer_stop(&root->sched->wdtimer);
+#endif
+
 #ifdef CONFIG_XENO_ARCH_UNLOCKED_SWITCH
 	if (rootcb->core.mm == NULL)
 		set_ti_thread_flag(rootcb->core.tip, TIF_MMSWITCH_INT);
@@ -840,6 +849,11 @@ static inline void leave_root(struct xnthread *root)
 	rootcb->core.tip = task_thread_info(p);
 #endif
 	xnarch_leave_root(root);
+
+#ifdef CONFIG_XENO_OPT_WATCHDOG
+	xntimer_start(&root->sched->wdtimer, get_watchdog_timeout(),
+		      XN_INFINITE, XN_RELATIVE);
+#endif
 }
 
 void __xnsched_run_handler(void) /* hw interrupts off. */
@@ -889,9 +903,6 @@ reschedule:
 
 	trace_cobalt_switch_context(prev, next);
 
-	if (xnthread_test_state(next, XNROOT))
-		xnsched_reset_watchdog(sched);
-
 	sched->curr = next;
 	shadow = 1;
 
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index 6d985a995..5d8b3bc76 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -893,10 +893,6 @@ int xntimer_grab_hardware(void)
 		else if (ret == 1)
 			xntimer_start(&sched->htimer, 0, 0, XN_RELATIVE);
 
-#ifdef CONFIG_XENO_OPT_WATCHDOG
-		xntimer_start(&sched->wdtimer, 1000000000UL, 1000000000UL, XN_RELATIVE);
-		xnsched_reset_watchdog(sched);
-#endif
 		xnlock_put_irqrestore(&nklock, s);
 	}
 
@@ -908,9 +904,6 @@ fail:
 		xnlock_get_irqsave(&nklock, s);
 		sched = xnsched_struct(cpu);
 		xntimer_stop(&sched->htimer);
-#ifdef CONFIG_XENO_OPT_WATCHDOG
-		xntimer_stop(&sched->wdtimer);
-#endif
 		xnlock_put_irqrestore(&nklock, s);
 		ipipe_timer_stop(_cpu);
 	}
-- 
2.14.4


