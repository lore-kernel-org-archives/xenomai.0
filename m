From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/2] cobalt: Return error from xnsched_setparam
Message-ID: <a0ae52fe-fa52-124e-b3e2-b82d2755fa10@siemens.com>
Date: Thu, 22 Nov 2018 18:57:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

This allows to remove the user-triggerable XENO_BUG from
xnsched_quota_setparam().

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/sched-idle.h |  4 ++--
 include/cobalt/kernel/sched-rt.h   |  6 +++---
 include/cobalt/kernel/sched.h      | 19 +++++++++----------
 kernel/cobalt/sched-idle.c         |  4 ++--
 kernel/cobalt/sched-quota.c        | 19 +++++++++----------
 kernel/cobalt/sched-rt.c           |  4 ++--
 kernel/cobalt/sched-sporadic.c     | 12 ++++++------
 kernel/cobalt/sched-tp.c           |  4 ++--
 kernel/cobalt/sched-weak.c         |  4 ++--
 kernel/cobalt/sched.c              | 16 ++++++++--------
 10 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/include/cobalt/kernel/sched-idle.h b/include/cobalt/kernel/sched-idle.h
index 75efdec225..8c71022c5d 100644
--- a/include/cobalt/kernel/sched-idle.h
+++ b/include/cobalt/kernel/sched-idle.h
@@ -33,8 +33,8 @@
 
 extern struct xnsched_class xnsched_class_idle;
 
-static inline bool __xnsched_idle_setparam(struct xnthread *thread,
-					   const union xnsched_policy_param *p)
+static inline int __xnsched_idle_setparam(struct xnthread *thread,
+					  const union xnsched_policy_param *p)
 {
 	xnthread_clear_state(thread, XNWEAK);
 	return xnsched_set_effective_priority(thread, p->idle.prio);
diff --git a/include/cobalt/kernel/sched-rt.h b/include/cobalt/kernel/sched-rt.h
index 992a5ba278..9787556477 100644
--- a/include/cobalt/kernel/sched-rt.h
+++ b/include/cobalt/kernel/sched-rt.h
@@ -85,10 +85,10 @@ static inline void __xnsched_rt_track_weakness(struct xnthread *thread)
 		xnthread_set_state(thread, XNWEAK);
 }
 
-static inline bool __xnsched_rt_setparam(struct xnthread *thread,
-					 const union xnsched_policy_param *p)
+static inline int __xnsched_rt_setparam(struct xnthread *thread,
+					const union xnsched_policy_param *p)
 {
-	bool ret = xnsched_set_effective_priority(thread, p->rt.prio);
+	int ret = xnsched_set_effective_priority(thread, p->rt.prio);
 	
 	if (!xnthread_test_state(thread, XNBOOST))
 		__xnsched_rt_track_weakness(thread);
diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index d2b3d0c63a..e9aedf24bf 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -160,10 +160,11 @@ struct xnsched_class {
 	 * @param thread Affected thread.
 	 * @param p New base policy settings.
 	 *
-	 * @return True if the effective priority was updated
-	 * (thread->cprio).
+	 * @return >0 if the effective priority was updated (thread->cprio), 0
+	 * if not, and a negative error code if invalid policy settings were
+	 * provided.
 	 */
-	bool (*sched_setparam)(struct xnthread *thread,
+	int (*sched_setparam)(struct xnthread *thread,
 			       const union xnsched_policy_param *p);
 	void (*sched_getparam)(struct xnthread *thread,
 			       union xnsched_policy_param *p);
@@ -395,8 +396,7 @@ xnsched_maybe_resched_after_unlocked_switch(struct xnsched *sched)
 
 #endif /* !CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH */
 
-bool xnsched_set_effective_priority(struct xnthread *thread,
-				    int prio);
+int xnsched_set_effective_priority(struct xnthread *thread, int prio);
 
 #include <cobalt/kernel/sched-idle.h>
 #include <cobalt/kernel/sched-rt.h>
@@ -562,9 +562,8 @@ static inline void xnsched_requeue(struct xnthread *thread)
 		sched_class->sched_requeue(thread);
 }
 
-static inline
-bool xnsched_setparam(struct xnthread *thread,
-		      const union xnsched_policy_param *p)
+static inline int xnsched_setparam(struct xnthread *thread,
+				   const union xnsched_policy_param *p)
 {
 	return thread->base_class->sched_setparam(thread, p);
 }
@@ -641,8 +640,8 @@ static inline void xnsched_requeue(struct xnthread *thread)
 		__xnsched_rt_requeue(thread);
 }
 
-static inline bool xnsched_setparam(struct xnthread *thread,
-				    const union xnsched_policy_param *p)
+static inline int xnsched_setparam(struct xnthread *thread,
+				   const union xnsched_policy_param *p)
 {
 	struct xnsched_class *sched_class = thread->base_class;
 
diff --git a/kernel/cobalt/sched-idle.c b/kernel/cobalt/sched-idle.c
index e5ca8aee87..e810294409 100644
--- a/kernel/cobalt/sched-idle.c
+++ b/kernel/cobalt/sched-idle.c
@@ -23,8 +23,8 @@ static struct xnthread *xnsched_idle_pick(struct xnsched *sched)
 	return &sched->rootcb;
 }
 
-bool xnsched_idle_setparam(struct xnthread *thread,
-			   const union xnsched_policy_param *p)
+static int xnsched_idle_setparam(struct xnthread *thread,
+				 const union xnsched_policy_param *p)
 {
 	return __xnsched_idle_setparam(thread, p);
 }
diff --git a/kernel/cobalt/sched-quota.c b/kernel/cobalt/sched-quota.c
index 7e58f1b374..8e13f82b0e 100644
--- a/kernel/cobalt/sched-quota.c
+++ b/kernel/cobalt/sched-quota.c
@@ -235,20 +235,21 @@ static void xnsched_quota_init(struct xnsched *sched)
 	xntimer_set_name(&qs->limit_timer, limiter_name);
 }
 
-static bool xnsched_quota_setparam(struct xnthread *thread,
-				   const union xnsched_policy_param *p)
+static int xnsched_quota_setparam(struct xnthread *thread,
+				  const union xnsched_policy_param *p)
 {
 	struct xnsched_quota_group *tg;
 	struct xnsched_quota *qs;
-	bool effective;
-
-	xnthread_clear_state(thread, XNWEAK);
-	effective = xnsched_set_effective_priority(thread, p->quota.prio);
+	int ret;
 
 	qs = &thread->sched->quota;
 	list_for_each_entry(tg, &qs->groups, next) {
 		if (tg->tgid != p->quota.tgid)
 			continue;
+
+		xnthread_clear_state(thread, XNWEAK);
+		ret = xnsched_set_effective_priority(thread, p->quota.prio);
+
 		if (thread->quota) {
 			/* Dequeued earlier by our caller. */
 			list_del(&thread->quota_next);
@@ -257,12 +258,10 @@ static bool xnsched_quota_setparam(struct xnthread *thread,
 		thread->quota = tg;
 		list_add(&thread->quota_next, &tg->members);
 		tg->nr_threads++;
-		return effective;
+		return ret;
 	}
 
-	XENO_BUG(COBALT);
-
-	return false;
+	return -EINVAL;
 }
 
 static void xnsched_quota_getparam(struct xnthread *thread,
diff --git a/kernel/cobalt/sched-rt.c b/kernel/cobalt/sched-rt.c
index 114ddad214..834b242605 100644
--- a/kernel/cobalt/sched-rt.c
+++ b/kernel/cobalt/sched-rt.c
@@ -91,8 +91,8 @@ void xnsched_rt_tick(struct xnsched *sched)
 	xnsched_putback(sched->curr);
 }
 
-bool xnsched_rt_setparam(struct xnthread *thread,
-			 const union xnsched_policy_param *p)
+static int xnsched_rt_setparam(struct xnthread *thread,
+			       const union xnsched_policy_param *p)
 {
 	return __xnsched_rt_setparam(thread, p);
 }
diff --git a/kernel/cobalt/sched-sporadic.c b/kernel/cobalt/sched-sporadic.c
index 4d307a803b..d5d52fa338 100644
--- a/kernel/cobalt/sched-sporadic.c
+++ b/kernel/cobalt/sched-sporadic.c
@@ -235,14 +235,14 @@ static void xnsched_sporadic_init(struct xnsched *sched)
 #endif
 }
 
-static bool xnsched_sporadic_setparam(struct xnthread *thread,
-				      const union xnsched_policy_param *p)
+static int xnsched_sporadic_setparam(struct xnthread *thread,
+				     const union xnsched_policy_param *p)
 {
 	struct xnsched_sporadic_data *pss = thread->pss;
-	bool effective;
+	int ret;
 
 	xnthread_clear_state(thread, XNWEAK);
-	effective = xnsched_set_effective_priority(thread, p->pss.current_prio);
+	ret = xnsched_set_effective_priority(thread, p->pss.current_prio);
 
 	/*
 	 * We use the budget information to determine whether we got
@@ -257,13 +257,13 @@ static bool xnsched_sporadic_setparam(struct xnthread *thread,
 		pss->repl_in = 0;
 		pss->repl_out = 0;
 		pss->repl_pending = 0;
-		if (effective && thread == thread->sched->curr) {
+		if (ret > 0 && thread == thread->sched->curr) {
 			xntimer_stop(&pss->drop_timer);
 			sporadic_schedule_drop(thread);
 		}
 	}
 
-	return effective;
+	return ret;
 }
 
 static void xnsched_sporadic_getparam(struct xnthread *thread,
diff --git a/kernel/cobalt/sched-tp.c b/kernel/cobalt/sched-tp.c
index 982d95e6e9..5d77935707 100644
--- a/kernel/cobalt/sched-tp.c
+++ b/kernel/cobalt/sched-tp.c
@@ -106,8 +106,8 @@ static void xnsched_tp_init(struct xnsched *sched)
 	xntimer_set_name(&tp->tf_timer, timer_name);
 }
 
-static bool xnsched_tp_setparam(struct xnthread *thread,
-				const union xnsched_policy_param *p)
+static int xnsched_tp_setparam(struct xnthread *thread,
+			       const union xnsched_policy_param *p)
 {
 	struct xnsched *sched = thread->sched;
 
diff --git a/kernel/cobalt/sched-weak.c b/kernel/cobalt/sched-weak.c
index fc778b8535..a9933e48a8 100644
--- a/kernel/cobalt/sched-weak.c
+++ b/kernel/cobalt/sched-weak.c
@@ -44,8 +44,8 @@ static struct xnthread *xnsched_weak_pick(struct xnsched *sched)
 	return xnsched_getq(&sched->weak.runnable);
 }
 
-bool xnsched_weak_setparam(struct xnthread *thread,
-			   const union xnsched_policy_param *p)
+static int xnsched_weak_setparam(struct xnthread *thread,
+				 const union xnsched_policy_param *p)
 {
 	if (!xnthread_test_state(thread, XNBOOST))
 		xnthread_set_state(thread, XNWEAK);
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index a3c963bfec..1844a8cba9 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -431,7 +431,6 @@ int xnsched_set_policy(struct xnthread *thread,
 		       const union xnsched_policy_param *p)
 {
 	struct xnsched_class *orig_effective_class __maybe_unused;
-	bool effective;
 	int ret;
 
 	/*
@@ -480,8 +479,9 @@ int xnsched_set_policy(struct xnthread *thread,
 	 * This is the ONLY place where calling xnsched_setparam() is
 	 * legit, sane and safe.
 	 */
-	effective = xnsched_setparam(thread, p);
-	if (effective) {
+	ret = xnsched_setparam(thread, p);
+	if (ret > 0) {
+		/* effective */
 		thread->sched_class = sched_class;
 		thread->wprio = xnsched_calc_wprio(sched_class, thread->cprio);
 	} else if (XENO_DEBUG(COBALT))
@@ -493,18 +493,18 @@ int xnsched_set_policy(struct xnthread *thread,
 	if (!xnthread_test_state(thread, XNDORMANT))
 		xnsched_set_resched(thread->sched);
 
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(xnsched_set_policy);
 
 /* nklock locked, interrupts off. */
-bool xnsched_set_effective_priority(struct xnthread *thread, int prio)
+int xnsched_set_effective_priority(struct xnthread *thread, int prio)
 {
 	int wprio = xnsched_calc_wprio(thread->base_class, prio);
 
 	thread->bprio = prio;
 	if (wprio == thread->wprio)
-		return true;
+		return 1;
 
 	/*
 	 * We may not lower the effective/current priority of a
@@ -514,13 +514,13 @@ bool xnsched_set_effective_priority(struct xnthread *thread, int prio)
 	 * and PP synchs resp.
 	 */
 	if (wprio < thread->wprio && xnthread_test_state(thread, XNBOOST))
-		return false;
+		return 0;
 
 	thread->cprio = prio;
 
 	trace_cobalt_thread_set_current_prio(thread);
 
-	return true;
+	return 1;
 }
 
 /* nklock locked, interrupts off. */
-- 
2.16.4

