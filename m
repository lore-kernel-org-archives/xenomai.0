Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1441F8755
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973899; cv=none; b=ARL3AFvIVtw3S1l3NUX+oIwv3Y9HzfPShQ5Kg3mTanm6GkXysFxJXUnCMuckSniQUrxn8ORtK9HbatYVOBwRaJA4CJCH//0Un9YvrVrk/dxLSEVRFBkGUxt/5JNMh3D8Mk4cYxzdUh/S/xsKLmzDx76BcJN3G2p1/DMZIkLmdc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973899; c=relaxed/simple;
	bh=YtlBK30IdRFFzniffYm0yO9dS4sUlZvOaNTwh4gKI/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk3+XMfI1/4bilnGUBEyhmblBaSE/eyRYIYVI4gXUgyRv0ctf65+CosVJrI3XYMYUvMY4KgzAsrgDcu3807EXV2SWnyl5Hc6K2sQ2wlnaw9pA26vvtGrW79wEyqSLRx4d8ducp1FJdLVLsZSGNS5Berw1P2GaJT1dvv/bXXpwd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=kkh5fsLq; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="kkh5fsLq"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 3748B580D50
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 16:16:37 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEC643F5E8;
	Sat, 20 Jun 2026 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781972190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PrsSrbLpid9KMFCBzFA2nqQ4+mhqu4JqFAWDCjbkoI=;
	b=kkh5fsLqAK1yepHbo4BwIMqAlUy3ye6r4O5Q9r0OdKVNd9gKtwthiVcNXCROeYvOI+wCYP
	5z1sBYBkB6XzeUdEsdh6G/Ux4309VuXCpRI8Worl7cd10v67cmy3zst3n1YeFMyYhSkTdL
	sTsjcAwhshbuWWhtycyl9lYkgbpz4bLCMq9900WuFQel9nK/D01zf0D6tZz51PEJHPvrpc
	e59LDfybh+wmt+D7LrWWXAABtrAcQtx595KfLZXoEedGpF2EC6hm9lg3cEMrLlcpKAsJSb
	BzRtgnV9VLRik3IduSVvuEAGxSLzORCQBH0b10XQb90nbZvtPjlgPb3kylWOoQ==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v3 2/2] evl/sched: quota: fix budget tracking on preemption
Date: Sat, 20 Jun 2026 18:08:45 +0200
Message-ID: <20260620161531.422484-3-rpm@xenomai.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620161531.422484-1-rpm@xenomai.org>
References: <20260620161531.422484-1-rpm@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: 0
X-GND-Cause: dmFkZTGJIOk+bsa8eEvzf5ba91NsFllY1F9SyzOk+wdiJoIXYRgkUZdgljX6L/B05YAUCUQxZyYiCVoN6I+pr4QXc4Vic0ckXXQzWzUE0dJO8IWtvv/xGA9qJVxpxej/UcSoJsch28ZkMBS7fmK9HusZhbHKUTprhUBWnUyefF7vHShr1Z4Shx1TIt7zRli7j7lfZtJ8dfWq+pL4zynA7uu6rCSQzluqVUBoNabcq5d5nJqZjHZGiLeizcu/oM39ezvYEbqYl7+kdpYGUI/ekuWzjYNopWN/27VGiwOuSWVmR/Az5kYgP0esYIKtxlqCVjiaRzYMr0jbVsYCQ0pyHWaGOsgDB2tMIjD5alwjfcbm3NG13PRmxbNT3+s/VCB5jtu0j6S8FItxZKHWqTcKDn7RyVp9k8Gn6MtKY12C/svZWucsxD4QMlmgNZPH5RpuA8rqSW4q9PljnpewCWlRoQIbmp+cEGNr//YTSP9lGleZ5Uwmvy7TzrUnScQqCbBA4Kq4BxCYCUog/H/qhW5Cdvmbx3tqpVLnD2pULdWEOfFYvM15P1uT+4BrUFqvBgaRUmEhc33ziB1piVdHSBe0kxZDZMujtVnskvuNLjdzZypOjfmdywVDV5Pi5K5fEGiHt/Nq4+pvO1qB84tiGd71lulCc1xh9u0Q4SD3NSpYKC62tgHhWQ
X-GND-State: clean

From: Philippe Gerum <rpm@xenomai.org>

Upon preemption of a SCHED_QUOTA thread by a SCHED_FIFO one, the
runtime budget of the former is inaccurately tracked. This is due to
the fifo->sched_pick() handler returning a valid thread, which
prevents the quota->sched_pick() handler from being called. As a
result, the last runtime period of the outgoing thread is not
accounted for.

To fix this issue, we use the recently introduced sched_out() handler
to update the remaining budget of preempted threads appropriately.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/evl/sched/quota.c | 190 +++++++++++++++++++--------------------
 1 file changed, 95 insertions(+), 95 deletions(-)

diff --git a/kernel/evl/sched/quota.c b/kernel/evl/sched/quota.c
index 0829da711a66..2f045510b235 100644
--- a/kernel/evl/sched/quota.c
+++ b/kernel/evl/sched/quota.c
@@ -12,45 +12,39 @@
 #include <uapi/evl/sched-abi.h>
 
 /*
- * With this policy, each per-CPU runqueue maintains a list of active
- * thread groups for the sched_fifo class.
+ * Each time a thread is picked from the runnable thread queue, we
+ * check whether the group it belongs to still has runtime budget.  If
+ * so, a timer is armed to fire when that group has no more budget,
+ * would the incoming thread run unpreempted until then
+ * (i.e. quota->limit_timer).
  *
- * Each time a thread is picked from the runqueue, we check whether we
- * still have budget for running it, looking at the group it belongs
- * to. If so, a timer is armed to elapse when that group has no more
- * budget, would the incoming thread run unpreempted until then
- * (i.e. evl_quota->limit_timer).
+ * NOTE: SCHED_QUOTA piggybacks off the per-CPU runqueue of the
+ * SCHED_FIFO class in order for the threads of both classes to
+ * compete for the same CPU.
  *
  * Otherwise, if no budget remains in the group for running the
  * candidate thread, we move the latter to a local expiry queue
  * maintained by the group. This process is done on the fly as we pull
  * from the runqueue.
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
+ * the runqueue.
  *
- * NOTE: since the core logic enforcing the budget entirely happens in
- * evl_quota_pick(), applying a budget change can be done as simply as
- * forcing the rescheduling procedure to be invoked asap. As a result
- * of this, the EVL core will ask for the next thread to run, which
- * means calling evl_quota_pick() eventually.
+ * NOTE: forcing a call to the rescheduling procedure is enough to
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
+ * that group linked to the runqueue, _and_ the threads moved to the
+ * local expiry queue. As a matter of fact, the expired threads -
+ * those for which we consumed all the per-group budget - are still
+ * seen as runnable (i.e. not blocked/suspended) by the EVL core. This
+ * only means that the SCHED_QUOTA policy won't pick them until the
+ * corresponding budget is replenished.
  */
 
 #define MAX_QUOTA_GROUPS  1024
@@ -61,15 +55,19 @@ static DECLARE_BITMAP(group_map, MAX_QUOTA_GROUPS);
 
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
@@ -82,7 +80,7 @@ static inline bool group_is_active(struct evl_quota_group *tg)
 	 * runqueue, in which case tg->nr_active already accounted for
 	 * it.
 	 */
-	return thread_on_quota(tg->rq->curr, tg);
+	return current_on_quota(tg);
 }
 
 static inline void replenish_budget(struct evl_sched_quota *qs,
@@ -134,10 +132,10 @@ static inline void replenish_budget(struct evl_sched_quota *qs,
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
@@ -150,8 +148,8 @@ static inline void replenish_budget(struct evl_sched_quota *qs,
 
 static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled */
 {
-	struct evl_quota_group *tg;
 	struct evl_thread *thread, *tmp;
+	struct evl_quota_group *tg;
 	struct evl_sched_quota *qs;
 	struct evl_rq *rq;
 
@@ -167,7 +165,7 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
 		if (tg->run_budget == 0 || list_empty(&tg->expired))
 			continue;
 		/*
-		 * For each group living on this CPU, move all expired
+		 * For each group pinned on this CPU, move all expired
 		 * threads back to the runqueue. Since those threads
 		 * were moved out of the runqueue as we were
 		 * considering them for execution, we push them back
@@ -195,7 +193,7 @@ static void quota_limit_handler(struct evl_timer *timer) /* oob stage stalled */
 	/*
 	 * Force a rescheduling on the return path of the current
 	 * interrupt, so that the budget is re-evaluated for the
-	 * current group in evl_quota_pick().
+	 * current group in quota_pick().
 	 */
 	raw_spin_lock(&rq->lock);
 	evl_set_self_resched(rq);
@@ -395,69 +393,78 @@ static void quota_requeue(struct evl_thread *thread)
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
-pick:
-	next = evl_get_schedq(&rq->fifo.runnable);
-	if (next == NULL) {
+	now = evl_ktime_monotonic();
+	consumed = ktime_sub(now, tg->run_start);
+	if (consumed < tg->run_budget) {
+		tg->run_start = now;
+		tg->run_budget = ktime_sub(tg->run_budget, consumed);
+	} else {
+		tg->run_budget = 0;
 		evl_stop_timer(&qs->limit_timer);
-		return NULL;
 	}
+}
+
+static struct evl_thread *quota_pick(struct evl_rq *rq)
+{
+	struct evl_thread *next, *curr = rq->curr;
+	struct evl_sched_quota *qs = &rq->quota;
+	struct evl_quota_group *tg;
+
+pick:
+	next = evl_get_schedq(&rq->fifo.runnable);
+	if (next == NULL)
+		goto stop_and_out;
 
 	/*
-	 * As we basically piggyback on the SCHED_FIFO runqueue, make
-	 * sure to detect non-quota threads.
+	 * Since we piggyback off the SCHED_FIFO runqueue, make sure
+	 * to pick plain fifo threads unconditionally.
 	 */
 	tg = next->quota;
 	if (tg == NULL)
-		return next;
+		goto stop_and_out;
 
-	tg->run_start = now;
+	tg->nr_active--;
 
 	/*
 	 * Don't consider budget if kicked, we have to allow this
 	 * thread to run until it eventually switches to in-band
 	 * context.
 	 */
-	if (next->info & EVL_T_KICKED) {
-		evl_stop_timer(&qs->limit_timer);
-		goto out;
-	}
+	if (next->info & EVL_T_KICKED)
+		goto stop_and_out;
 
 	if (ktime_to_ns(tg->run_budget) == 0) {
-		/* Flush expired group members as we go. */
+		/* Park expired group members as we go. */
 		list_add_tail(&next->quota_expired, &tg->expired);
 		goto pick;
 	}
 
-	if (otg == tg && evl_timer_is_running(&qs->limit_timer))
-		/* Same group, leave the running timer untouched. */
-		goto out;
+	/* Arm new limit timer if need be. */
+	if (curr->quota != tg || !evl_timer_is_running(&qs->limit_timer)) {
+		tg->run_start = evl_ktime_monotonic();
+		evl_start_timer(&qs->limit_timer,
+				ktime_add(tg->run_start, tg->run_budget),
+				EVL_INFINITE);
+	}
 
-	/* Arm limit timer for the new running group. */
-	evl_start_timer(&qs->limit_timer,
-			ktime_add(now, tg->run_budget),
-			EVL_INFINITE);
-out:
-	tg->nr_active--;
+	return next;
+
+stop_and_out:
+	evl_stop_timer(&qs->limit_timer);
 
 	return next;
 }
@@ -542,7 +549,7 @@ static int quota_destroy_group(struct evl_quota_group *tg,
 	 * Unregister the group before we drop rq->lock. As a result,
 	 * it won't accept threads anymore while we are busy moving
 	 * the current members to the fifo class, and concurrent
-	 * evl_quota_remove requests would receive -EINVAL.
+	 * quota_remove requests would receive -EINVAL.
 	 */
 	__clear_bit(tg->tgid, group_map);
 	list_del(&tg->next);
@@ -556,7 +563,7 @@ static int quota_destroy_group(struct evl_quota_group *tg,
 	 * hold rq->lock on entry, we do a trylock dance to prevent an
 	 * ABBA issue. No livelock is possible since we unregistered
 	 * that group already, so &tg->members can only be depleted
-	 * (by this loop specifically).
+	 * (by this loop exclusively).
 	 */
 
 	while (!list_empty(&tg->members)) {
@@ -583,10 +590,10 @@ static void quota_set_limit(struct evl_quota_group *tg,
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
@@ -615,26 +622,18 @@ static void quota_set_limit(struct evl_quota_group *tg,
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
 
@@ -786,6 +785,7 @@ struct evl_sched_class evl_sched_quota = {
 	.sched_dequeue		=	quota_dequeue,
 	.sched_requeue		=	quota_requeue,
 	.sched_pick		=	quota_pick,
+	.sched_out		=	quota_out,
 	.sched_migrate		=	quota_migrate,
 	.sched_chkparam		=	quota_chkparam,
 	.sched_setparam		=	quota_setparam,
-- 
2.54.0

