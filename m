From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2] cobalt/sched: guard against missed rescheduling upon CPU
 migration
Date: Mon,  2 Dec 2019 16:35:20 +0100
Message-Id: <20191202153520.14265-1-rpm@xenomai.org>
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

Kicking the rescheduling procedure (xnsched_run()) from call sites
running over the root thread with hard irqs enabled may lead to
missing a rescheduling opportunity as a consequence of a CPU
migration, e.g.:

    CPU0					CPU1
    ----                         		----
    t0: ...
            <context switch>
    t1: xnthread_resume(t0)
             xnsched_run()
             <CPU MIGRATION -->
                  |                             |
                  |                             |
                  x                             |
          (missed rescheduling)                 v
                                    ___xnsched_run(CPU1.sched)

To address this issue, make sure every call to xnsched_run() either
runs from the head domain which is not affected by CPU migration, or
moves into the latest atomic section which might have changed the
scheduler state.

Turning on CONFIG_XENO_OPT_DEBUG_COBALT also enables a (oneshot)
assertion which detects invalid calls from the root domain with hard
irqs enabled.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/rtdm/driver.h | 11 +++++++-
 include/cobalt/kernel/sched.h       | 41 +++++++++--------------------
 kernel/cobalt/posix/mqueue.c        | 13 ++++-----
 kernel/cobalt/posix/timerfd.c       |  9 +++----
 kernel/cobalt/sched.c               | 24 +++++++++++++----
 kernel/cobalt/select.c              |  6 ++---
 kernel/cobalt/thread.c              |  4 +--
 7 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index d3d5d6b27..57495f12f 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -1044,8 +1044,12 @@ static inline void __deprecated rtdm_task_join_nrt(rtdm_task_t *task,
 static inline void rtdm_task_set_priority(rtdm_task_t *task, int priority)
 {
 	union xnsched_policy_param param = { .rt = { .prio = priority } };
+	spl_t s;
+
+	splhigh(s);
 	xnthread_set_schedparam(task, &xnsched_class_rt, &param);
 	xnsched_run();
+	splexit(s);
 }
 
 static inline int rtdm_task_set_period(rtdm_task_t *task,
@@ -1062,9 +1066,14 @@ static inline int rtdm_task_set_period(rtdm_task_t *task,
 
 static inline int rtdm_task_unblock(rtdm_task_t *task)
 {
-	int res = xnthread_unblock(task);
+	spl_t s;
+	int res;
 
+	splhigh(s);
+	res = xnthread_unblock(task);
 	xnsched_run();
+	splexit(s);
+
 	return res;
 }
 
diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index 3b0825d67..1f5714fe0 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -298,25 +298,8 @@ void __xnsched_run_handler(void);
 static inline int __xnsched_run(struct xnsched *sched)
 {
 	/*
-	 * NOTE: Since ___xnsched_run() won't run immediately if an
-	 * escalation to primary domain is needed, we won't use
-	 * critical scheduler information before we actually run in
-	 * primary mode; therefore we can first test the scheduler
-	 * status then escalate.
-	 *
-	 * Running in the primary domain means that no Linux-triggered
-	 * CPU migration may occur from that point either. Finally,
-	 * since migration is always a self-directed operation for
-	 * Xenomai threads, we can safely read the scheduler state
-	 * bits without holding the nklock.
-	 *
-	 * Said differently, if we race here because of a CPU
-	 * migration, it must have been Linux-triggered because we run
-	 * in secondary mode; in which case we will escalate to the
-	 * primary domain, then unwind the current call frame without
-	 * running the rescheduling procedure in
-	 * ___xnsched_run(). Therefore, the scheduler slot
-	 * (i.e. "sched") will be either valid, or unused.
+	 * Reschedule if XNSCHED is pending, but never over an IRQ
+	 * handler or in the middle of unlocked context switch.
 	 */
 	if (((sched->status|sched->lflags) &
 	     (XNINIRQ|XNINSW|XNRESCHED)) != XNRESCHED)
@@ -329,17 +312,19 @@ static inline int xnsched_run(void)
 {
 	struct xnsched *sched = xnsched_current();
 	/*
-	 * No rescheduling is possible, either if:
-	 *
-	 * - the current thread holds the scheduler lock
-	 * - an ISR context is active
-	 * - we are caught in the middle of an unlocked context switch.
+	 * sched->curr is shared locklessly with ___xnsched_run().
+	 * READ_ONCE() makes sure the compiler never uses load tearing
+	 * for reading this pointer piecemeal, so that multiple stores
+	 * occurring concurrently on remote CPUs never yield a
+	 * spurious merged value on the local one.
 	 */
-	smp_rmb();
-	if (unlikely(sched->curr->lock_count > 0))
-		return 0;
+	struct xnthread *curr = READ_ONCE(sched->curr);
 
-	return __xnsched_run(sched);
+	/*
+	 * If running over the root thread, hard irqs must be off
+	 * (asserted out of line in ___xnsched_run()).
+	 */
+	return curr->lock_count > 0 ? 0 : __xnsched_run(sched);
 }
 
 void xnsched_lock(void);
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 5c644b2c4..cd1cf3ce8 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -158,22 +158,19 @@ static inline int mq_init(struct cobalt_mq *mq, const struct mq_attr *attr)
 
 static inline void mq_destroy(struct cobalt_mq *mq)
 {
-	int resched;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
-	resched = (xnsynch_destroy(&mq->receivers) == XNSYNCH_RESCHED);
-	resched = (xnsynch_destroy(&mq->senders) == XNSYNCH_RESCHED) || resched;
+	xnsynch_destroy(&mq->receivers);
+	xnsynch_destroy(&mq->senders);
 	list_del(&mq->link);
+	xnsched_run();
 	xnlock_put_irqrestore(&nklock, s);
-	xnselect_destroy(&mq->read_select);
-	xnselect_destroy(&mq->write_select);
+	xnselect_destroy(&mq->read_select); /* Reschedules. */
+	xnselect_destroy(&mq->write_select); /* Ditto. */
 	xnregistry_remove(mq->handle);
 	xnheap_vfree(mq->mem);
 	kfree(mq);
-
-	if (resched)
-		xnsched_run();
 }
 
 static int mq_unref_inner(struct cobalt_mq *mq, spl_t s)
diff --git a/kernel/cobalt/posix/timerfd.c b/kernel/cobalt/posix/timerfd.c
index 610206047..29046cfec 100644
--- a/kernel/cobalt/posix/timerfd.c
+++ b/kernel/cobalt/posix/timerfd.c
@@ -131,18 +131,15 @@ timerfd_select(struct rtdm_fd *fd, struct xnselector *selector,
 static void timerfd_close(struct rtdm_fd *fd)
 {
 	struct cobalt_tfd *tfd = container_of(fd, struct cobalt_tfd, fd);
-	int resched;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
 	xntimer_destroy(&tfd->timer);
-	resched = xnsynch_destroy(&tfd->readers) == XNSYNCH_RESCHED;
+	xnsynch_destroy(&tfd->readers);
+	xnsched_run();
 	xnlock_put_irqrestore(&nklock, s);
-	xnselect_destroy(&tfd->read_select);
+	xnselect_destroy(&tfd->read_select); /* Reschedules. */
 	xnfree(tfd);
-
-	if (resched)
-		xnsched_run();
 }
 
 static struct rtdm_fd_ops timerfd_ops = {
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 74dc7a961..75adbc49e 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -376,10 +376,12 @@ struct xnsched *xnsched_finish_unlocked_switch(struct xnsched *sched)
 void xnsched_lock(void)
 {
 	struct xnsched *sched = xnsched_current();
-	struct xnthread *curr = sched->curr;
+	/* See comments in xnsched_run(), ___xnsched_run(). */
+	struct xnthread *curr = READ_ONCE(sched->curr);
 
 	if (sched->lflags & XNINIRQ)
 		return;
+
 	/*
 	 * CAUTION: The fast xnthread_current() accessor carries the
 	 * relevant lock nesting count only if current runs in primary
@@ -398,14 +400,17 @@ EXPORT_SYMBOL_GPL(xnsched_lock);
 void xnsched_unlock(void)
 {
 	struct xnsched *sched = xnsched_current();
-	struct xnthread *curr = sched->curr;
+	struct xnthread *curr = READ_ONCE(sched->curr);
+
+	XENO_WARN_ON_ONCE(COBALT, (curr->state & XNROOT) &&
+			  !hard_irqs_disabled());
 
 	if (sched->lflags & XNINIRQ)
 		return;
-	
+
 	if (!XENO_ASSERT(COBALT, curr->lock_count > 0))
 		return;
-	
+
 	if (--curr->lock_count == 0) {
 		xnthread_clear_localinfo(curr, XNLBALERT);
 		xnsched_run();
@@ -962,6 +967,8 @@ int ___xnsched_run(struct xnsched *sched)
 	int switched, shadow;
 	spl_t s;
 
+	XENO_WARN_ON_ONCE(COBALT, !hard_irqs_disabled() && ipipe_root_p);
+
 	if (xnarch_escalate())
 		return 0;
 
@@ -1000,7 +1007,14 @@ reschedule:
 
 	trace_cobalt_switch_context(prev, next);
 
-	sched->curr = next;
+	/*
+	 * sched->curr is shared locklessly with xnsched_run() and
+	 * xnsched_lock(). WRITE_ONCE() makes sure sched->curr is
+	 * written atomically so that these routines always observe
+	 * consistent values by preventing the compiler from using
+	 * store tearing.
+	 */
+	WRITE_ONCE(sched->curr, next);
 	shadow = 1;
 
 	if (xnthread_test_state(prev, XNROOT)) {
diff --git a/kernel/cobalt/select.c b/kernel/cobalt/select.c
index 7f839f159..df3d960db 100644
--- a/kernel/cobalt/select.c
+++ b/kernel/cobalt/select.c
@@ -409,7 +409,6 @@ static void xnselector_destroy_loop(void *cookie)
 	struct xnselect_binding *binding, *tmpb;
 	struct xnselector *selector, *tmps;
 	struct xnselect *fd;
-	int resched;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -430,12 +429,11 @@ static void xnselector_destroy_loop(void *cookie)
 			xnlock_get_irqsave(&nklock, s);
 		}
 	release:
-		resched = xnsynch_destroy(&selector->synchbase) == XNSYNCH_RESCHED;
+		xnsynch_destroy(&selector->synchbase);
+		xnsched_run();
 		xnlock_put_irqrestore(&nklock, s);
 
 		xnfree(selector);
-		if (resched)
-			xnsched_run();
 
 		xnlock_get_irqsave(&nklock, s);
 	}
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index a5f8e1b00..5260fb1e7 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1582,9 +1582,9 @@ check_self_cancel:
 	} else
 		__xnthread_kick(thread);
 out:
-	xnlock_put_irqrestore(&nklock, s);
-
 	xnsched_run();
+
+	xnlock_put_irqrestore(&nklock, s);
 }
 EXPORT_SYMBOL_GPL(xnthread_cancel);
 
-- 
2.21.0


