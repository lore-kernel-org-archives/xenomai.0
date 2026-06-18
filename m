Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620C3B2FC2
	for <xenomai@lists.linux.dev>; Thu, 18 Jun 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771747; cv=none; b=PFkpIVmRLA7sMzmEhnPNoaCpBRCzDiLSxs9OzgMVQWzTY31f2RyK9PPk27kvOpWYxf3rFg6ZHV7IWB7IQGDHfHHjJtEyjY4/dFSNQrTwCQMH+J66NRjaKhKDg0N7I41Rhqu55YyxF+cqrKBGQ1DcXs7411KQ5JIbrQ8h+vXm6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771747; c=relaxed/simple;
	bh=aVf5my/oGI4AuG4D/nTDGbdYGU1baSCrDJGNfcyjFgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMUICz/8t0UI1ikUoLF3SZUcgQ3bU8Kxm//Oyn1tlepKG4hEMakKvzT83pIE0e9yQPRbXaENNvjLjNNVMtAr9bGerY0SN1cOib+wgzNn/m4hjso9dRNEHPzJyAiaOYO7pw/iFLbGXbi38Z5+qjX9+Igo992BR0Nc0PJ1SSSOGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=SkQL+uGb; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="SkQL+uGb"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 337C120CC7;
	Thu, 18 Jun 2026 08:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781771741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWu5nT+AkJdlgLvViuHAWqx/XaA16B2FUopExNYOecA=;
	b=SkQL+uGbz9pjVNMXyq0NF7jYoPrhLOjrUovd/TgVzjkLOOmLYJ4jm4M6ojlJSXk3ubSuRg
	+fgNGI9IYGe50D9HOek4nBZRMOCbMFAb+zN1o6hi/X69yzaqJ9zJid+5QFZaaqWtnO4V3t
	jn9UojAHMcrkJwT/73Jcy3yMgkQiZy9gtSzOsc0VO2jpLZmDnrBKBzPGuK18dAHvI01bhe
	TmNhDmjt+EaejNOv6fdIyz5KEzdzq41IYDaA/CT7Cgj1/ToY8JXZwV+I15KjwpxirWqDRA
	G8W0EHywJRl8Q/cNyIOUBgcO/VJzXgsqnNY3NuZwVNZO1UNTfWoKE8I3DM8wnw==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v2 2/2] evl/sched: quota: fix budget tracking on preemption
Date: Thu, 18 Jun 2026 10:33:24 +0200
Message-ID: <20260618083524.253860-3-rpm@xenomai.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618083524.253860-1-rpm@xenomai.org>
References: <20260618083524.253860-1-rpm@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFukAoSMPn+zck6wPVZylajpGTRxkfFNbRPLhNZJ7nNOeAPO5x4KHWb6ssDT8ZNJ/oAlmj/pq/GmN3qdVOoXSWjBqRsTwXOKJ/Tc3svFwxLLrlSc6jVwJ1akqX0Y3Tb1E4hcO8c1XxIsOdu3+lzCMHy5Ov5C052XFRt0sSiRlPz2QugL816a795gWVLkv0AfoVGsuGXz8l1jwlkS31jbJdwKCKEoZH0nqmRRqHh+0mdiaJbAWVoyXy7HeAm7fRZgt2riEu3q5O9D5Bwp7C/jgr2UU1WrHiLFT3b/K8/qFG/defYkjs9by8MIDbfky8CIt0yy6uK72au71OCqVJh33isNpRa+qYqbLTa1T1Dd1N0ra8jt2A+5c9l4dJKejz6flO+Xyo1z/7GG52c45aOcOQ3EveIG8Pxv1FnpC2NQqBuwqnpXAd/R3aVbEgKX+WEeZy2aihuaF1qRq1Gi4vC2x12J85Par8ro6Nd5KM4jgVZn+ISAz13fx0HFM3KfoWQ8lYAB0cDIcj2jQRZJA5r2U1Qd56T0uZ97jWUEUP59vyA6mlh2Tfg3gVZG+L+YqquGwlt+Ru/tYXerA4Pj5GAVmbhcnqMnleiFol2vcYlMvI9S8+bUFz+kcI/mjMXzakhpRcad+gIqH6ml9X2rD0Ht6N3+pNyGxv5pT019ZdS9q4MMA

From: Philippe Gerum <rpm@xenomai.org>

Upon preemption of a SCHED_QUOTA thread by a SCHED_FIFO one, the
runtime budget of the former is inaccurately tracked. This is due to
the fifo->sched_pick() handler returning a valid thread, which
prevents the quota->sched_pick() handler from being called. As a
result, the last runtime period of the outgoing thread is not
accounted for.

To fix this issue, we use the recently introduced sched_out() handler
to update the remaining budget of preempted threads appropriately.  In
addition, the SCHED_QUOTA gains its own runnable thread queue, no
longer piggybacks off the SCHED_FIFO queue (no functional change).

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/evl/sched/quota.h |   1 +
 kernel/evl/sched/quota.c  | 201 ++++++++++++++++++--------------------
 2 files changed, 96 insertions(+), 106 deletions(-)

diff --git a/include/evl/sched/quota.h b/include/evl/sched/quota.h
index dfe3b7390958..dc8416645da8 100644
--- a/include/evl/sched/quota.h
+++ b/include/evl/sched/quota.h
@@ -40,6 +40,7 @@ struct evl_quota_group {
 
 struct evl_sched_quota {
 	ktime_t period;
+	struct evl_sched_queue runnable;
 	struct evl_timer refill_timer;
 	struct evl_timer limit_timer;
 	struct list_head groups;
diff --git a/kernel/evl/sched/quota.c b/kernel/evl/sched/quota.c
index 0829da711a66..8f1321d46cac 100644
--- a/kernel/evl/sched/quota.c
+++ b/kernel/evl/sched/quota.c
@@ -12,45 +12,35 @@
 #include <uapi/evl/sched-abi.h>
 
 /*
- * With this policy, each per-CPU runqueue maintains a list of active
- * thread groups for the sched_fifo class.
- *
- * Each time a thread is picked from the runqueue, we check whether we
- * still have budget for running it, looking at the group it belongs
- * to. If so, a timer is armed to elapse when that group has no more
- * budget, would the incoming thread run unpreempted until then
- * (i.e. evl_quota->limit_timer).
+ * Each time a thread is picked from the ->runnable queue, we check
+ * whether the group it belongs to still has runtime budget.  If so, a
+ * timer is armed to fire when that group has no more budget, would
+ * the incoming thread run unpreempted until then
+ * (i.e. quota->limit_timer).
  *
  * Otherwise, if no budget remains in the group for running the
  * candidate thread, we move the latter to a local expiry queue
  * maintained by the group. This process is done on the fly as we pull
- * from the runqueue.
+ * from the ->runnable queue.
  *
- * Updating the remaining budget is done each time the EVL core asks
- * for replacing the current thread with the next runnable one,
- * i.e. evl_quota_pick(). There we charge the elapsed run time of the
- * outgoing thread to the relevant group, and conversely, we check
- * whether the incoming thread has budget.
+ * Updating the remaining budget is done each time the EVL core
+ * schedules out a thread undergoing the quota scheduling policy,
  *
- * Finally, a per-CPU timer (evl_quota->refill_timer) periodically
- * ticks in the background, in accordance to the defined quota
- * interval. Thread group budgets get replenished by its handler in
- * accordance to their respective share, pushing all expired threads
- * back to the run queue in the same move.
+ * Finally, a per-CPU timer (quota->refill_timer) periodically ticks
+ * in the background, in accordance to the defined quota interval,
+ * replenishing per-group budgets, pushing all expired threads back to
+ * the quota ->runqueue too.
  *
- * NOTE: since the core logic enforcing the budget entirely happens in
- * evl_quota_pick(), applying a budget change can be done as simply as
- * forcing the rescheduling procedure to be invoked asap. As a result
- * of this, the EVL core will ask for the next thread to run, which
- * means calling evl_quota_pick() eventually.
+ * NOTE: forcing a call to the rescheduling procedure is enoiugh to
+ * apply a budget change.
  *
- * CAUTION: evl_quota_group->nr_active does count both the threads
- * from that group linked to the sched_fifo runqueue, _and_ the
- * threads moved to the local expiry queue. As a matter of fact, the
- * expired threads - those for which we consumed all the per-group
- * budget - are still seen as runnable (i.e. not blocked/suspended) by
- * the EVL core. This only means that the SCHED_QUOTA policy won't
- * pick them until the corresponding budget is replenished.
+ * CAUTION: quota_group->nr_active does count both the threads from
+ * that group linked to the runnable queue, _and_ the threads moved to
+ * the local expiry queue. As a matter of fact, the expired threads -
+ * those for which we consumed all the per-group budget - are still
+ * seen as runnable (i.e. not blocked/suspended) by the EVL core. This
+ * only means that the SCHED_QUOTA policy won't pick them until the
+ * corresponding budget is replenished.
  */
 
 #define MAX_QUOTA_GROUPS  1024
@@ -61,15 +51,19 @@ static DECLARE_BITMAP(group_map, MAX_QUOTA_GROUPS);
 
 static LIST_HEAD(group_list);
 
-static inline bool thread_on_quota(struct evl_thread *thread,
-				struct evl_quota_group *tg)
+static inline bool current_on_quota(struct evl_quota_group *tg)
 {
-	/*
-	 * Check whether @thread is running on some CPU, and belongs
-	 * to quota group @tg.
-	 */
-	return thread->quota == tg &&
-		!(thread->state & (EVL_T_READY|EVL_THREAD_BLOCK_MASK));
+	struct evl_rq *rq = tg->rq;
+	struct evl_thread *curr = rq->curr;
+	struct evl_sched_quota *qs = &rq->quota;
+
+	if (curr->quota != tg)
+		return false;
+
+	if (curr->state & (EVL_T_READY|EVL_T_KICKED|EVL_THREAD_BLOCK_MASK))
+		return false;
+
+	return evl_timer_is_running(&qs->limit_timer);
 }
 
 static inline bool group_is_active(struct evl_quota_group *tg)
@@ -82,7 +76,7 @@ static inline bool group_is_active(struct evl_quota_group *tg)
 	 * runqueue, in which case tg->nr_active already accounted for
 	 * it.
 	 */
-	return thread_on_quota(tg->rq->curr, tg);
+	return current_on_quota(tg);
 }
 
 static inline void replenish_budget(struct evl_sched_quota *qs,
@@ -134,10 +128,10 @@ static inline void replenish_budget(struct evl_sched_quota *qs,
 	} else if (tg->run_credit) {
 		credit = ktime_sub(tg->quota_peak, budget);
 		/* Consume the accumulated credit. */
-		if (tg->run_credit >= credit)
+		if (tg->run_credit >= credit) {
 			tg->run_credit =
 				ktime_sub(tg->run_credit, credit);
-		else {
+		} else {
 			credit = tg->run_credit;
 			tg->run_credit = 0;
 		}
@@ -150,8 +144,8 @@ static inline void replenish_budget(struct evl_sched_quota *qs,
 
 static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled */
 {
-	struct evl_quota_group *tg;
 	struct evl_thread *thread, *tmp;
+	struct evl_quota_group *tg;
 	struct evl_sched_quota *qs;
 	struct evl_rq *rq;
 
@@ -167,7 +161,7 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
 		if (tg->run_budget == 0 || list_empty(&tg->expired))
 			continue;
 		/*
-		 * For each group living on this CPU, move all expired
+		 * For each group pinned on this CPU, move all expired
 		 * threads back to the runqueue. Since those threads
 		 * were moved out of the runqueue as we were
 		 * considering them for execution, we push them back
@@ -178,7 +172,7 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
 		list_for_each_entry_safe_reverse(thread, tmp,
 						&tg->expired, quota_expired) {
 			list_del_init(&thread->quota_expired);
-			evl_add_schedq(&rq->fifo.runnable, thread);
+			evl_add_schedq(&qs->runnable, thread);
 		}
 	}
 
@@ -195,7 +189,7 @@ static void quota_limit_handler(struct evl_timer *timer) /* oob stage stalled */
 	/*
 	 * Force a rescheduling on the return path of the current
 	 * interrupt, so that the budget is re-evaluated for the
-	 * current group in evl_quota_pick().
+	 * current group in quota_pick().
 	 */
 	raw_spin_lock(&rq->lock);
 	evl_set_self_resched(rq);
@@ -221,6 +215,7 @@ static void quota_init(struct evl_rq *rq)
 {
 	struct evl_sched_quota *qs = &rq->quota;
 
+	evl_init_schedq(&qs->runnable);
 	qs->period = quota_period;
 	INIT_LIST_HEAD(&qs->groups);
 
@@ -337,8 +332,8 @@ static void quota_forget(struct evl_thread *thread)
 
 static void quota_kick(struct evl_thread *thread)
 {
+	struct evl_sched_quota *qs = &thread->rq->quota;
 	struct evl_quota_group *tg = thread->quota;
-	struct evl_rq *rq = thread->rq;
 
 	/*
 	 * Allow a kicked thread to be elected for running until it
@@ -347,7 +342,7 @@ static void quota_kick(struct evl_thread *thread)
 	 */
 	if (tg->run_budget == 0 && !list_empty(&thread->quota_expired)) {
 		list_del_init(&thread->quota_expired);
-		evl_add_schedq_tail(&rq->fifo.runnable, thread);
+		evl_add_schedq_tail(&qs->runnable, thread);
 	}
 }
 
@@ -358,79 +353,83 @@ static inline int thread_is_runnable(struct evl_thread *thread)
 
 static void quota_enqueue(struct evl_thread *thread)
 {
+	struct evl_sched_quota *qs = &thread->rq->quota;
 	struct evl_quota_group *tg = thread->quota;
-	struct evl_rq *rq = thread->rq;
 
 	if (!thread_is_runnable(thread))
 		list_add_tail(&thread->quota_expired, &tg->expired);
 	else
-		evl_add_schedq_tail(&rq->fifo.runnable, thread);
+		evl_add_schedq_tail(&qs->runnable, thread);
 
 	tg->nr_active++;
 }
 
 static void quota_dequeue(struct evl_thread *thread)
 {
+	struct evl_sched_quota *qs = &thread->rq->quota;
 	struct evl_quota_group *tg = thread->quota;
-	struct evl_rq *rq = thread->rq;
 
 	if (!list_empty(&thread->quota_expired))
 		list_del_init(&thread->quota_expired);
 	else
-		evl_del_schedq(&rq->fifo.runnable, thread);
+		evl_del_schedq(&qs->runnable, thread);
 
 	tg->nr_active--;
 }
 
 static void quota_requeue(struct evl_thread *thread)
 {
+	struct evl_sched_quota *qs = &thread->rq->quota;
 	struct evl_quota_group *tg = thread->quota;
-	struct evl_rq *rq = thread->rq;
 
 	if (!thread_is_runnable(thread))
 		list_add(&thread->quota_expired, &tg->expired);
 	else
-		evl_add_schedq(&rq->fifo.runnable, thread);
+		evl_add_schedq(&qs->runnable, thread);
 
 	tg->nr_active++;
 }
 
-static struct evl_thread *quota_pick(struct evl_rq *rq)
+static void quota_out(struct evl_thread *thread)
 {
-	struct evl_thread *next, *curr = rq->curr;
-	struct evl_sched_quota *qs = &rq->quota;
-	struct evl_quota_group *otg, *tg;
-	ktime_t now, elapsed;
+	struct evl_sched_quota *qs = &thread->rq->quota;
+	struct evl_quota_group *tg = thread->quota;
+	ktime_t now, consumed;
+
+	/* Timer off means that we are not tracking quota. */
+	if (!evl_timer_is_running(&qs->limit_timer))
+		return;
 
-	now = evl_ktime_monotonic();
-	otg = curr->quota;
-	if (otg == NULL)
-		goto pick;
 	/*
 	 * Charge the time consumed by the outgoing thread to the
 	 * group it belongs to.
 	 */
-	elapsed = ktime_sub(now, otg->run_start);
-	if (elapsed < otg->run_budget)
-		otg->run_budget = ktime_sub(otg->run_budget, elapsed);
-	else
-		otg->run_budget = 0;
+	now = evl_ktime_monotonic();
+	consumed = ktime_sub(now, tg->run_start);
+	if (consumed < tg->run_budget) {
+		tg->run_start = now;
+		tg->run_budget = ktime_sub(tg->run_budget, consumed);
+	} else {
+		tg->run_budget = 0;
+		evl_stop_timer(&qs->limit_timer);
+	}
+}
+
+static struct evl_thread *quota_pick(struct evl_rq *rq)
+{
+	struct evl_thread *next, *curr = rq->curr;
+	struct evl_sched_quota *qs = &rq->quota;
+	struct evl_quota_group *tg;
+
 pick:
-	next = evl_get_schedq(&rq->fifo.runnable);
+	next = evl_get_schedq(&qs->runnable);
 	if (next == NULL) {
 		evl_stop_timer(&qs->limit_timer);
 		return NULL;
 	}
 
-	/*
-	 * As we basically piggyback on the SCHED_FIFO runqueue, make
-	 * sure to detect non-quota threads.
-	 */
 	tg = next->quota;
-	if (tg == NULL)
-		return next;
-
-	tg->run_start = now;
+	tg->nr_active--;
 
 	/*
 	 * Don't consider budget if kicked, we have to allow this
@@ -439,25 +438,22 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
 	 */
 	if (next->info & EVL_T_KICKED) {
 		evl_stop_timer(&qs->limit_timer);
-		goto out;
+		return next;
 	}
 
 	if (ktime_to_ns(tg->run_budget) == 0) {
-		/* Flush expired group members as we go. */
+		/* Park expired group members as we go. */
 		list_add_tail(&next->quota_expired, &tg->expired);
 		goto pick;
 	}
 
-	if (otg == tg && evl_timer_is_running(&qs->limit_timer))
-		/* Same group, leave the running timer untouched. */
-		goto out;
-
-	/* Arm limit timer for the new running group. */
-	evl_start_timer(&qs->limit_timer,
-			ktime_add(now, tg->run_budget),
-			EVL_INFINITE);
-out:
-	tg->nr_active--;
+	/* Arm new limit timer if need be. */
+	if (curr->quota != tg || !evl_timer_is_running(&qs->limit_timer)) {
+		tg->run_start = evl_ktime_monotonic();
+		evl_start_timer(&qs->limit_timer,
+				ktime_add(tg->run_start, tg->run_budget),
+				EVL_INFINITE);
+	}
 
 	return next;
 }
@@ -542,7 +538,7 @@ static int quota_destroy_group(struct evl_quota_group *tg,
 	 * Unregister the group before we drop rq->lock. As a result,
 	 * it won't accept threads anymore while we are busy moving
 	 * the current members to the fifo class, and concurrent
-	 * evl_quota_remove requests would receive -EINVAL.
+	 * quota_remove requests would receive -EINVAL.
 	 */
 	__clear_bit(tg->tgid, group_map);
 	list_del(&tg->next);
@@ -556,7 +552,7 @@ static int quota_destroy_group(struct evl_quota_group *tg,
 	 * hold rq->lock on entry, we do a trylock dance to prevent an
 	 * ABBA issue. No livelock is possible since we unregistered
 	 * that group already, so &tg->members can only be depleted
-	 * (by this loop specifically).
+	 * (by this loop exclusively).
 	 */
 
 	while (!list_empty(&tg->members)) {
@@ -583,10 +579,10 @@ static void quota_set_limit(struct evl_quota_group *tg,
 			int *quota_sum_r)
 {
 	struct evl_rq *rq = tg->rq;
-	struct evl_thread *thread, *tmp, *curr = rq->curr;
+	struct evl_thread *thread, *tmp;
 	struct evl_sched_quota *qs = &rq->quota;
-	ktime_t now, elapsed, consumed;
 	ktime_t old_quota = tg->quota;
+	ktime_t consumed;
 	u64 n;
 
 	assert_hard_lock(&rq->lock);
@@ -615,26 +611,18 @@ static void quota_set_limit(struct evl_quota_group *tg,
 	tg->quota_percent = quota_percent;
 	tg->quota_peak_percent = quota_peak_percent;
 
-	if (thread_on_quota(curr, tg)) {
-		now = evl_ktime_monotonic();
-
-		elapsed = now - tg->run_start;
-		if (elapsed < tg->run_budget)
-			tg->run_budget -= elapsed;
-		else
-			tg->run_budget = 0;
-
-		tg->run_start = now;
+	if (current_on_quota(tg)) {
+		quota_out(rq->curr);
 		evl_stop_timer(&qs->limit_timer);
 	}
 
 	if (tg->run_budget <= old_quota)
-		consumed = old_quota - tg->run_budget;
+		consumed = ktime_sub(old_quota, tg->run_budget);
 	else
 		consumed = 0;
 
 	if (tg->quota >= consumed)
-		tg->run_budget = tg->quota - consumed;
+		tg->run_budget = ktime_sub(tg->quota, consumed);
 	else
 		tg->run_budget = 0;
 
@@ -646,7 +634,7 @@ static void quota_set_limit(struct evl_quota_group *tg,
 		list_for_each_entry_safe_reverse(thread, tmp, &tg->expired,
 						quota_expired) {
 			list_del_init(&thread->quota_expired);
-			evl_add_schedq(&rq->fifo.runnable, thread);
+			evl_add_schedq(&qs->runnable, thread);
 		}
 	}
 
@@ -786,6 +774,7 @@ struct evl_sched_class evl_sched_quota = {
 	.sched_dequeue		=	quota_dequeue,
 	.sched_requeue		=	quota_requeue,
 	.sched_pick		=	quota_pick,
+	.sched_out		=	quota_out,
 	.sched_migrate		=	quota_migrate,
 	.sched_chkparam		=	quota_chkparam,
 	.sched_setparam		=	quota_setparam,
-- 
2.54.0

