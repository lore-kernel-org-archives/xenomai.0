Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4721F94F
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513607; cv=none; b=n2RDy9+vdbnYp54tM6C+jeXEHTsHE2c4mHZfpXi6J7BRPvYDR1QMtuJvO/19Ny+AjDuqBCZyl7Zu3uDs4lNExxEN78hEW+H0Pa8qxWlXxeeUi+gzI0ZgCMQp77PgFMvO6rmjdwPM0MGWnSlcIoY3G/e/KHLK3g/sVXLvNeE9VRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513607; c=relaxed/simple;
	bh=nmY7z429dx1eiDfC7Llf1fh96qZJabA8L8+Ila3EtaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y2bctXZVDkfz0mEDdYQMt/VUD/Dh6G6BymGhIcQhPLKWZCp77tmmhIjB0yNndeTdzhhnapmI37lhYjz/zbrlqhf23PT2wJT3E+gGKwq3ULc7Ucmi36hv0IfahoziDBm2AwnWKAoJ6IrDuywxvG10I08RmDYce8KTWpclHN9XAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=j6DqEVem; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="j6DqEVem"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF2303EBC1;
	Mon, 15 Jun 2026 08:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781513602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=StaxQHDlLsvQVb6vCZ2BcaDdXA5MMgCUVbx6kmhIu6c=;
	b=j6DqEVemAnRktjIIcNWthtlgyQNkRHMcrhJgfWLxrhvttuwqt5W7rPmCveadvJhuXQiEtD
	N0+eb951P/OPcuHq6grZNjwNkvgiTPWjGcG47ujBbjBW9wzQFJnRnsIYDlFm1XZLh0NOGc
	2hr0oOV0hQ0tMBTxd5+OWzyh9WDDt3c4hHhkW8PXN2A3DWEmEr6W+4vHU77n6xMV19thdo
	GJBO0LbV5XbBQVOMZ6+3733NZgBpFQGEgYJeYkTIg73CmwPE5BV1IJCrV/WYPhhjN+suEb
	M1V96GNZS7Ur6haKJwTCdo0rEUEaV3hGtWfOW1bFkn32Eqqf1vJwe/JkAYxS6w==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
In-Reply-To: <a8cc3e6c-553c-41e9-9911-1129a4444614@siemens.com> (Jan Kiszka's
	message of "Mon, 15 Jun 2026 10:34:17 +0200")
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
	<87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
	<c3ba6b74-6a07-458b-9b5a-255eb9853183@siemens.com>
	<87jys0gtma.fsf@xenomai.org>
	<8a0384df-69b7-43e1-93b7-79a8ba1137d9@siemens.com>
	<875x3kgt0t.fsf@xenomai.org>
	<a8cc3e6c-553c-41e9-9911-1129a4444614@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 15 Jun 2026 10:53:22 +0200
Message-ID: <877bo0fam5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGwfXiDxku0tUB7zju+p6FJK8dJx1REfX1ZCaOQ4gPmw8/oyadHvmQEpe0cSajEjjO7+KN2s4kb9ClnpfFDMs8GstR28rSaPFaOW38QVpsQ069O72JcotEbJvqWDM4sOBUE8rbvaK6gPD9xPj2KZrzLL55Nr0PVvBo6kj6Ca8FnKB1a6i+U97EucJVxaIn3ZXfcj6n9v60VIkb/WUW+b+pIljT3mLn9jVvYhkzuF3EX9XCGyKJKQngw5xCczwyCHhCmq4nv/d8UPg5a/MkE8tpogfFRZh3CCifxEiiNU9E4Cd+XwkMrtXLKIRkpPGZ+XwCYH2R3X7HKYPUbjdRBCnuYFjHPA2vj9CX8icAYqWaWjbJsPurAThc53/cJk14BQR47fWAB0S6Vg2DcvOeOapPIhrYmoYUb2oIM8K3T+vAeowt2ZGZ4VTPdUtIu2u8yrDBxRqo6kXSOr+Txhhr19cjPzW+KyTf0q/yqG47FgCq7QfF6OG+kA4sWepCAOTxPqtI8Z19a+PN/7h1mAYQcgWBjkFcvIlMz+igFWvAPxtftJd+KqtGcRuObDQJVjW8ZxrRHnfNAuxRVgDPIovkJ/3+2kECFLsTFi325ZLMOXmmTIfOJ/OWoaZzX0+jVUTHRxIpZj8hqNJj0UY4H+SlyHAPl85rwUgYa3+JHgovwTMWHGA
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 15.06.26 09:30, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 15.06.26 09:17, Philippe Gerum wrote:
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> On 15.06.26 08:42, Philippe Gerum wrote:
>>>>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>>>>
>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>
>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>
>>>>>>>> This shall be invoked before a thread switch, providing both the current
>>>>>>>> and the next thread as arguments. Some scheduling classes may need it to
>>>>>>>> correctly handle their state as the sched_pick may not be invoked when a
>>>>>>>> higher-weighted class is providing the next thread.
>>>>>>>>
>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>> ---
>>>>>>>>  include/evl/sched.h     | 2 ++
>>>>>>>>  kernel/evl/sched/core.c | 5 +++++
>>>>>>>>  2 files changed, 7 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/evl/sched.h b/include/evl/sched.h
>>>>>>>> index ae9690860146c..0b16f1b1cf626 100644
>>>>>>>> --- a/include/evl/sched.h
>>>>>>>> +++ b/include/evl/sched.h
>>>>>>>> @@ -120,6 +120,8 @@ struct evl_sched_class {
>>>>>>>>  	void (*sched_dequeue)(struct evl_thread *thread);
>>>>>>>>  	void (*sched_requeue)(struct evl_thread *thread);
>>>>>>>>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
>>>>>>>> +	void (*sched_out)(struct evl_thread *thread,
>>>>>>>> +			  struct evl_thread *next);
>>>>>>>>  	void (*sched_yield)(struct evl_thread *thread);
>>>>>>>>  	void (*sched_migrate)(struct evl_thread *thread,
>>>>>>>>  			      struct evl_rq *rq);
>>>>>>>> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
>>>>>>>> index eb133e334d30f..0d49fc16bd67e 100644
>>>>>>>> --- a/kernel/evl/sched/core.c
>>>>>>>> +++ b/kernel/evl/sched/core.c
>>>>>>>> @@ -910,6 +910,7 @@ static __always_inline bool test_resched(struct evl_rq *this_rq)
>>>>>>>>   */
>>>>>>>>  void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>>>>>>  {
>>>>>>>> +	struct evl_sched_class *prev_schedclass;
>>>>>>>>  	struct evl_rq *this_rq = this_evl_rq();
>>>>>>>>  	struct evl_thread *prev, *next, *curr;
>>>>>>>>  	bool leaving_inband, inband_tail;
>>>>>>>> @@ -990,6 +991,10 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>>>>>>  	this_rq->curr = next;
>>>>>>>>  	leaving_inband = false;
>>>>>>>>  
>>>>>>>> +	prev_schedclass = prev->sched_class;
>>>>>>>> +	if (prev_schedclass->sched_out)
>>>>>>>> +		prev_schedclass->sched_out(prev, next);
>>>>>>>> +
>>>>>>>>  	/*
>>>>>>>>  	 * Careful: we _must_ have updated this_rq->curr before
>>>>>>>>  	 * performing the rest of the context switch code
>>>>>>>
>>>>>>> I've been working on this lately too. It turns out that we need more
>>>>>>> than this, although this is definitely part of the solution. I'll follow
>>>>>>> up on this issue.
>>>>>>
>>>>>> This is still wip, I'm sharing this early to discuss details for
>>>>>> reconciling both proposals (the hunk in __evl_schedule() is merely
>>>>>> cosmetic, no functional change).
>>>>>>
>>>>>
>>>>> Please avoid that for the final patch. I already had troubles telling
>>>>> substantial from cosmetical changes apart in your lazy-blocking commit
>>>>> (>50% unrelated changes in there).
>>>>>
>>>>>> commit f49dbd63c1389a6b99508ef0da852545b102d1cc (HEAD -> wip/fix-quota-sched)
>>>>>> Author: Philippe Gerum <rpm@xenomai.org>
>>>>>> Date:   Sun Jun 14 12:08:59 2026 +0200
>>>>>>
>>>>>>     evl: sched/quota: fix budget tracking on preemption
>>>>>>     
>>>>>>     Upon preemption of a SCHED_QUOTA thread by a SCHED_FIFO one, the
>>>>>>     runtime budget of the former is inaccurately tracked. This is due to
>>>>>>     the fifo->pick() handler returning a valid thread, which prevents the
>>>>>>     quota->pick() handler from being called. As a result, the last runtime
>>>>>>     period of the outgoing thread is not accounted for.
>>>>>>     
>>>>>>     To fix this, we introduce a new sched_out() handler which is called
>>>>>>     for the outgoing thread, which the quota policy uses to update the
>>>>>>     remaining budget of preempted threads appropriately. In addition, the
>>>>>>     implementation no longer shares the runnable thread queue with
>>>>>>     SCHED_FIFO.
>>>>>
>>>>> ...and why we need a separate queue now? Please provide reasoning for
>>>>> changes.
>>>>>
>>>>>>     
>>>>>>     Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>>>>>
>>>>>> diff --git a/include/evl/sched.h b/include/evl/sched.h
>>>>>> index ae9690860146..cc824c28004b 100644
>>>>>> --- a/include/evl/sched.h
>>>>>> +++ b/include/evl/sched.h
>>>>>> @@ -120,6 +120,7 @@ struct evl_sched_class {
>>>>>>  	void (*sched_dequeue)(struct evl_thread *thread);
>>>>>>  	void (*sched_requeue)(struct evl_thread *thread);
>>>>>>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
>>>>>> +	void (*sched_out)(struct evl_thread *thread);
>>>>>>  	void (*sched_yield)(struct evl_thread *thread);
>>>>>>  	void (*sched_migrate)(struct evl_thread *thread,
>>>>>>  			      struct evl_rq *rq);
>>>>>> diff --git a/include/evl/sched/quota.h b/include/evl/sched/quota.h
>>>>>> index dfe3b7390958..dc8416645da8 100644
>>>>>> --- a/include/evl/sched/quota.h
>>>>>> +++ b/include/evl/sched/quota.h
>>>>>> @@ -40,6 +40,7 @@ struct evl_quota_group {
>>>>>>  
>>>>>>  struct evl_sched_quota {
>>>>>>  	ktime_t period;
>>>>>> +	struct evl_sched_queue runnable;
>>>>>>  	struct evl_timer refill_timer;
>>>>>>  	struct evl_timer limit_timer;
>>>>>>  	struct list_head groups;
>>>>>> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
>>>>>> index d1d025e06a5d..7127d4e52df9 100644
>>>>>> --- a/kernel/evl/sched/core.c
>>>>>> +++ b/kernel/evl/sched/core.c
>>>>>> @@ -773,7 +773,8 @@ static inline void set_next_running(struct evl_rq *rq,
>>>>>>  		evl_stop_timer(&rq->rrbtimer);
>>>>>>  }
>>>>>>  
>>>>>> -static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
>>>>>> +static __always_inline struct evl_thread *
>>>>>> +__pick_next_thread(struct evl_rq *rq)
>>>>>>  {
>>>>>>  	struct evl_sched_class *sched_class;
>>>>>>  	struct evl_thread *curr = rq->curr;
>>>>>> @@ -821,8 +822,14 @@ static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
>>>>>>  /* rq->curr->lock + rq->lock held, hard irqs off. */
>>>>>>  static struct evl_thread *pick_next_thread(struct evl_rq *rq)
>>>>>>  {
>>>>>> -	struct evl_thread *next = __pick_next_thread(rq);
>>>>>> +	struct evl_thread *next, *prev = rq->curr;
>>>>>> +	struct evl_sched_class *prev_class = prev->sched_class;
>>>>>>  
>>>>>> +	if (prev_class->sched_out)
>>>>>> +		prev_class->sched_out(prev);
>>>>>> +
>>>>>> +	next = __pick_next_thread(rq);
>>>>>> +	trace_evl_pick_thread(next);
>>>>>>  	set_next_running(rq, next);
>>>>>>  
>>>>>>  	return next;
>>>>>> @@ -972,21 +979,20 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>>>>  		return;
>>>>>>  	}
>>>>>>  
>>>>>> +	prev = curr;
>>>>>>  	next = pick_next_thread(this_rq);
>>>>>> -	trace_evl_pick_thread(next);
>>>>>> -	if (next == curr) {
>>>>>> -		if (unlikely(next->state & EVL_T_ROOT)) {
>>>>>> +	if (next == prev) {
>>>>>> +		if (unlikely(prev->state & EVL_T_ROOT)) {
>>>>>>  			if (this_rq->local_flags & RQ_TPROXY)
>>>>>>  				evl_notify_proxy_tick(this_rq);
>>>>>>  			if (this_rq->local_flags & RQ_TDEFER)
>>>>>>  				evl_program_local_tick(&evl_mono_clock);
>>>>>>  		}
>>>>>>  		raw_spin_unlock(&this_rq->lock);
>>>>>> -		raw_spin_unlock_irqrestore(&curr->lock, flags);
>>>>>> +		raw_spin_unlock_irqrestore(&prev->lock, flags);
>>>>>>  		return;
>>>>>>  	}
>>>>>>  
>>>>>> -	prev = curr;
>>>>>>  	this_rq->curr = next;
>>>>>>  	leaving_inband = false;
>>>>>>  
>>>>>> diff --git a/kernel/evl/sched/quota.c b/kernel/evl/sched/quota.c
>>>>>> index 0829da711a66..14748e3a843e 100644
>>>>>> --- a/kernel/evl/sched/quota.c
>>>>>> +++ b/kernel/evl/sched/quota.c
>>>>>> @@ -12,45 +12,35 @@
>>>>>>  #include <uapi/evl/sched-abi.h>
>>>>>>  
>>>>>>  /*
>>>>>> - * With this policy, each per-CPU runqueue maintains a list of active
>>>>>> - * thread groups for the sched_fifo class.
>>>>>> - *
>>>>>> - * Each time a thread is picked from the runqueue, we check whether we
>>>>>> - * still have budget for running it, looking at the group it belongs
>>>>>> - * to. If so, a timer is armed to elapse when that group has no more
>>>>>> - * budget, would the incoming thread run unpreempted until then
>>>>>> - * (i.e. evl_quota->limit_timer).
>>>>>> + * Each time a thread is picked from the ->runnable queue, we check
>>>>>> + * whether the group it belongs to still has runtime budget.  If so, a
>>>>>> + * timer is armed to fire when that group has no more budget, would
>>>>>> + * the incoming thread run unpreempted until then
>>>>>> + * (i.e. quota->limit_timer).
>>>>>>   *
>>>>>>   * Otherwise, if no budget remains in the group for running the
>>>>>>   * candidate thread, we move the latter to a local expiry queue
>>>>>>   * maintained by the group. This process is done on the fly as we pull
>>>>>> - * from the runqueue.
>>>>>> + * from the ->runnable queue.
>>>>>>   *
>>>>>> - * Updating the remaining budget is done each time the EVL core asks
>>>>>> - * for replacing the current thread with the next runnable one,
>>>>>> - * i.e. evl_quota_pick(). There we charge the elapsed run time of the
>>>>>> - * outgoing thread to the relevant group, and conversely, we check
>>>>>> - * whether the incoming thread has budget.
>>>>>> + * Updating the remaining budget is done each time the EVL core
>>>>>> + * schedules out a thread undergoing the quota scheduling policy,
>>>>>>   *
>>>>>> - * Finally, a per-CPU timer (evl_quota->refill_timer) periodically
>>>>>> - * ticks in the background, in accordance to the defined quota
>>>>>> - * interval. Thread group budgets get replenished by its handler in
>>>>>> - * accordance to their respective share, pushing all expired threads
>>>>>> - * back to the run queue in the same move.
>>>>>> + * Finally, a per-CPU timer (quota->refill_timer) periodically ticks
>>>>>> + * in the background, in accordance to the defined quota interval,
>>>>>> + * replenishing per-group budgets, pushing all expired threads back to
>>>>>> + * the quota ->runqueue too.
>>>>>>   *
>>>>>> - * NOTE: since the core logic enforcing the budget entirely happens in
>>>>>> - * evl_quota_pick(), applying a budget change can be done as simply as
>>>>>> - * forcing the rescheduling procedure to be invoked asap. As a result
>>>>>> - * of this, the EVL core will ask for the next thread to run, which
>>>>>> - * means calling evl_quota_pick() eventually.
>>>>>> + * NOTE: forcing a call to the rescheduling procedure is enoiugh to
>>>>>> + * apply a budget change.
>>>>>>   *
>>>>>> - * CAUTION: evl_quota_group->nr_active does count both the threads
>>>>>> - * from that group linked to the sched_fifo runqueue, _and_ the
>>>>>> - * threads moved to the local expiry queue. As a matter of fact, the
>>>>>> - * expired threads - those for which we consumed all the per-group
>>>>>> - * budget - are still seen as runnable (i.e. not blocked/suspended) by
>>>>>> - * the EVL core. This only means that the SCHED_QUOTA policy won't
>>>>>> - * pick them until the corresponding budget is replenished.
>>>>>> + * CAUTION: quota_group->nr_active does count both the threads from
>>>>>> + * that group linked to the runnable queue, _and_ the threads moved to
>>>>>> + * the local expiry queue. As a matter of fact, the expired threads -
>>>>>> + * those for which we consumed all the per-group budget - are still
>>>>>> + * seen as runnable (i.e. not blocked/suspended) by the EVL core. This
>>>>>> + * only means that the SCHED_QUOTA policy won't pick them until the
>>>>>> + * corresponding budget is replenished.
>>>>>>   */
>>>>>>  
>>>>>>  #define MAX_QUOTA_GROUPS  1024
>>>>>> @@ -61,15 +51,19 @@ static DECLARE_BITMAP(group_map, MAX_QUOTA_GROUPS);
>>>>>>  
>>>>>>  static LIST_HEAD(group_list);
>>>>>>  
>>>>>> -static inline bool thread_on_quota(struct evl_thread *thread,
>>>>>> -				struct evl_quota_group *tg)
>>>>>> +static inline bool current_on_quota(struct evl_quota_group *tg)
>>>>>>  {
>>>>>> -	/*
>>>>>> -	 * Check whether @thread is running on some CPU, and belongs
>>>>>> -	 * to quota group @tg.
>>>>>> -	 */
>>>>>> -	return thread->quota == tg &&
>>>>>> -		!(thread->state & (EVL_T_READY|EVL_THREAD_BLOCK_MASK));
>>>>>> +	struct evl_rq *rq = tg->rq;
>>>>>> +	struct evl_thread *curr = rq->curr;
>>>>>> +	struct evl_sched_quota *qs = &rq->quota;
>>>>>> +
>>>>>> +	if (curr->quota != tg)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	if (curr->state & (EVL_T_READY|EVL_T_KICKED|EVL_THREAD_BLOCK_MASK))
>>>>>> +		return false;
>>>>>> +
>>>>>> +	return evl_timer_is_running(&qs->limit_timer);
>>>>>>  }
>>>>>>  
>>>>>>  static inline bool group_is_active(struct evl_quota_group *tg)
>>>>>> @@ -82,7 +76,7 @@ static inline bool group_is_active(struct evl_quota_group *tg)
>>>>>>  	 * runqueue, in which case tg->nr_active already accounted for
>>>>>>  	 * it.
>>>>>>  	 */
>>>>>> -	return thread_on_quota(tg->rq->curr, tg);
>>>>>> +	return current_on_quota(tg);
>>>>>>  }
>>>>>>  
>>>>>>  static inline void replenish_budget(struct evl_sched_quota *qs,
>>>>>> @@ -134,10 +128,10 @@ static inline void replenish_budget(struct evl_sched_quota *qs,
>>>>>>  	} else if (tg->run_credit) {
>>>>>>  		credit = ktime_sub(tg->quota_peak, budget);
>>>>>>  		/* Consume the accumulated credit. */
>>>>>> -		if (tg->run_credit >= credit)
>>>>>> +		if (tg->run_credit >= credit) {
>>>>>>  			tg->run_credit =
>>>>>>  				ktime_sub(tg->run_credit, credit);
>>>>>> -		else {
>>>>>> +		} else {
>>>>>>  			credit = tg->run_credit;
>>>>>>  			tg->run_credit = 0;
>>>>>>  		}
>>>>>> @@ -150,8 +144,8 @@ static inline void replenish_budget(struct evl_sched_quota *qs,
>>>>>>  
>>>>>>  static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled */
>>>>>>  {
>>>>>> -	struct evl_quota_group *tg;
>>>>>>  	struct evl_thread *thread, *tmp;
>>>>>> +	struct evl_quota_group *tg;
>>>>>>  	struct evl_sched_quota *qs;
>>>>>>  	struct evl_rq *rq;
>>>>>>  
>>>>>> @@ -167,7 +161,7 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
>>>>>>  		if (tg->run_budget == 0 || list_empty(&tg->expired))
>>>>>>  			continue;
>>>>>>  		/*
>>>>>> -		 * For each group living on this CPU, move all expired
>>>>>> +		 * For each group pinned on this CPU, move all expired
>>>>>>  		 * threads back to the runqueue. Since those threads
>>>>>>  		 * were moved out of the runqueue as we were
>>>>>>  		 * considering them for execution, we push them back
>>>>>> @@ -178,7 +172,7 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
>>>>>>  		list_for_each_entry_safe_reverse(thread, tmp,
>>>>>>  						&tg->expired, quota_expired) {
>>>>>>  			list_del_init(&thread->quota_expired);
>>>>>> -			evl_add_schedq(&rq->fifo.runnable, thread);
>>>>>> +			evl_add_schedq(&qs->runnable, thread);
>>>>>>  		}
>>>>>>  	}
>>>>>>  
>>>>>> @@ -195,7 +189,7 @@ static void quota_limit_handler(struct evl_timer *timer) /* oob stage stalled */
>>>>>>  	/*
>>>>>>  	 * Force a rescheduling on the return path of the current
>>>>>>  	 * interrupt, so that the budget is re-evaluated for the
>>>>>> -	 * current group in evl_quota_pick().
>>>>>> +	 * current group in quota_pick().
>>>>>>  	 */
>>>>>>  	raw_spin_lock(&rq->lock);
>>>>>>  	evl_set_self_resched(rq);
>>>>>> @@ -221,6 +215,7 @@ static void quota_init(struct evl_rq *rq)
>>>>>>  {
>>>>>>  	struct evl_sched_quota *qs = &rq->quota;
>>>>>>  
>>>>>> +	evl_init_schedq(&qs->runnable);
>>>>>>  	qs->period = quota_period;
>>>>>>  	INIT_LIST_HEAD(&qs->groups);
>>>>>>  
>>>>>> @@ -337,8 +332,8 @@ static void quota_forget(struct evl_thread *thread)
>>>>>>  
>>>>>>  static void quota_kick(struct evl_thread *thread)
>>>>>>  {
>>>>>> +	struct evl_sched_quota *qs = &thread->rq->quota;
>>>>>>  	struct evl_quota_group *tg = thread->quota;
>>>>>> -	struct evl_rq *rq = thread->rq;
>>>>>>  
>>>>>>  	/*
>>>>>>  	 * Allow a kicked thread to be elected for running until it
>>>>>> @@ -347,7 +342,7 @@ static void quota_kick(struct evl_thread *thread)
>>>>>>  	 */
>>>>>>  	if (tg->run_budget == 0 && !list_empty(&thread->quota_expired)) {
>>>>>>  		list_del_init(&thread->quota_expired);
>>>>>> -		evl_add_schedq_tail(&rq->fifo.runnable, thread);
>>>>>> +		evl_add_schedq_tail(&qs->runnable, thread);
>>>>>>  	}
>>>>>>  }
>>>>>>  
>>>>>> @@ -358,79 +353,82 @@ static inline int thread_is_runnable(struct evl_thread *thread)
>>>>>>  
>>>>>>  static void quota_enqueue(struct evl_thread *thread)
>>>>>>  {
>>>>>> +	struct evl_sched_quota *qs = &thread->rq->quota;
>>>>>>  	struct evl_quota_group *tg = thread->quota;
>>>>>> -	struct evl_rq *rq = thread->rq;
>>>>>>  
>>>>>>  	if (!thread_is_runnable(thread))
>>>>>>  		list_add_tail(&thread->quota_expired, &tg->expired);
>>>>>>  	else
>>>>>> -		evl_add_schedq_tail(&rq->fifo.runnable, thread);
>>>>>> +		evl_add_schedq_tail(&qs->runnable, thread);
>>>>>>  
>>>>>>  	tg->nr_active++;
>>>>>>  }
>>>>>>  
>>>>>>  static void quota_dequeue(struct evl_thread *thread)
>>>>>>  {
>>>>>> +	struct evl_sched_quota *qs = &thread->rq->quota;
>>>>>>  	struct evl_quota_group *tg = thread->quota;
>>>>>> -	struct evl_rq *rq = thread->rq;
>>>>>>  
>>>>>>  	if (!list_empty(&thread->quota_expired))
>>>>>>  		list_del_init(&thread->quota_expired);
>>>>>>  	else
>>>>>> -		evl_del_schedq(&rq->fifo.runnable, thread);
>>>>>> +		evl_del_schedq(&qs->runnable, thread);
>>>>>>  
>>>>>>  	tg->nr_active--;
>>>>>>  }
>>>>>>  
>>>>>>  static void quota_requeue(struct evl_thread *thread)
>>>>>>  {
>>>>>> +	struct evl_sched_quota *qs = &thread->rq->quota;
>>>>>>  	struct evl_quota_group *tg = thread->quota;
>>>>>> -	struct evl_rq *rq = thread->rq;
>>>>>>  
>>>>>>  	if (!thread_is_runnable(thread))
>>>>>>  		list_add(&thread->quota_expired, &tg->expired);
>>>>>>  	else
>>>>>> -		evl_add_schedq(&rq->fifo.runnable, thread);
>>>>>> +		evl_add_schedq(&qs->runnable, thread);
>>>>>>  
>>>>>>  	tg->nr_active++;
>>>>>>  }
>>>>>>  
>>>>>> -static struct evl_thread *quota_pick(struct evl_rq *rq)
>>>>>> +static void quota_out(struct evl_thread *thread)
>>>>>>  {
>>>>>> -	struct evl_thread *next, *curr = rq->curr;
>>>>>> -	struct evl_sched_quota *qs = &rq->quota;
>>>>>> -	struct evl_quota_group *otg, *tg;
>>>>>> -	ktime_t now, elapsed;
>>>>>> +	struct evl_sched_quota *qs = &thread->rq->quota;
>>>>>> +	struct evl_quota_group *tg = thread->quota;
>>>>>> +	ktime_t now, consumed;
>>>>>> +
>>>>>> +	/* Timer off means that we are not tracking quota. */
>>>>>> +	if (!evl_timer_is_running(&qs->limit_timer))
>>>>>> +		return;
>>>>>>  
>>>>>> -	now = evl_ktime_monotonic();
>>>>>> -	otg = curr->quota;
>>>>>> -	if (otg == NULL)
>>>>>> -		goto pick;
>>>>>>  	/*
>>>>>>  	 * Charge the time consumed by the outgoing thread to the
>>>>>>  	 * group it belongs to.
>>>>>>  	 */
>>>>>> -	elapsed = ktime_sub(now, otg->run_start);
>>>>>> -	if (elapsed < otg->run_budget)
>>>>>> -		otg->run_budget = ktime_sub(otg->run_budget, elapsed);
>>>>>> -	else
>>>>>> -		otg->run_budget = 0;
>>>>>> +	now = evl_ktime_monotonic();
>>>>>
>>>>> Thing brins some, though minor, glitch when doing the run_start update
>>>>> for the next group already in pick. That's why I'm trying to reuse that
>>>>> stamp when available.
>>>>>
>>>>>> +	consumed = ktime_sub(now, tg->run_start);
>>>>>> +	if (consumed < tg->run_budget) {
>>>>>> +		tg->run_budget = ktime_sub(tg->run_budget, consumed);
>>>>>> +	} else {
>>>>>> +		tg->run_budget = 0;
>>>>>> +		evl_stop_timer(&qs->limit_timer);
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>> +static struct evl_thread *quota_pick(struct evl_rq *rq)
>>>>>> +{
>>>>>> +	struct evl_thread *next, *curr = rq->curr;
>>>>>> +	struct evl_sched_quota *qs = &rq->quota;
>>>>>> +	struct evl_quota_group *tg;
>>>>>> +
>>>>>>  pick:
>>>>>> -	next = evl_get_schedq(&rq->fifo.runnable);
>>>>>> +	next = evl_get_schedq(&qs->runnable);
>>>>>>  	if (next == NULL) {
>>>>>>  		evl_stop_timer(&qs->limit_timer);
>>>>>>  		return NULL;
>>>>>>  	}
>>>>>>  
>>>>>> -	/*
>>>>>> -	 * As we basically piggyback on the SCHED_FIFO runqueue, make
>>>>>> -	 * sure to detect non-quota threads.
>>>>>> -	 */
>>>>>>  	tg = next->quota;
>>>>>> -	if (tg == NULL)
>>>>>> -		return next;
>>>>>> -
>>>>>> -	tg->run_start = now;
>>>>>> +	tg->nr_active--;
>>>>>>  
>>>>>>  	/*
>>>>>>  	 * Don't consider budget if kicked, we have to allow this
>>>>>> @@ -439,25 +437,29 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>>>>>>  	 */
>>>>>>  	if (next->info & EVL_T_KICKED) {
>>>>>>  		evl_stop_timer(&qs->limit_timer);
>>>>>> -		goto out;
>>>>>> +		return next;
>>>>>>  	}
>>>>>>  
>>>>>> +	/*
>>>>>> +	 * __pick_next_thread() might have requeued the current
>>>>>> +	 * thread which is still leading the pack.
>>>>>> +	 */
>>>>>> +	if (curr == next)
>>>>>> +		return next;
>>>>>> +
>>>>>>  	if (ktime_to_ns(tg->run_budget) == 0) {
>>>>>> -		/* Flush expired group members as we go. */
>>>>>> +		/* Park expired group members as we go. */
>>>>>>  		list_add_tail(&next->quota_expired, &tg->expired);
>>>>>>  		goto pick;
>>>>>>  	}
>>>>>>  
>>>>>> -	if (otg == tg && evl_timer_is_running(&qs->limit_timer))
>>>>>> -		/* Same group, leave the running timer untouched. */
>>>>>> -		goto out;
>>>>>> -
>>>>>> -	/* Arm limit timer for the new running group. */
>>>>>> -	evl_start_timer(&qs->limit_timer,
>>>>>> -			ktime_add(now, tg->run_budget),
>>>>>> -			EVL_INFINITE);
>>>>>> -out:
>>>>>> -	tg->nr_active--;
>>>>>> +	/* Arm new limit timer on change of running group. */
>>>>>> +	if (curr->quota != tg || !evl_timer_is_running(&qs->limit_timer)) {
>>>>>> +		tg->run_start = evl_ktime_monotonic();
>>>>>> +		evl_start_timer(&qs->limit_timer,
>>>>>> +				ktime_add(tg->run_start, tg->run_budget),
>>>>>> +				EVL_INFINITE);
>>>>>> +	}
>>>>>>  
>>>>>>  	return next;
>>>>>>  }
>>>>>> @@ -542,7 +544,7 @@ static int quota_destroy_group(struct evl_quota_group *tg,
>>>>>>  	 * Unregister the group before we drop rq->lock. As a result,
>>>>>>  	 * it won't accept threads anymore while we are busy moving
>>>>>>  	 * the current members to the fifo class, and concurrent
>>>>>> -	 * evl_quota_remove requests would receive -EINVAL.
>>>>>> +	 * quota_remove requests would receive -EINVAL.
>>>>>>  	 */
>>>>>>  	__clear_bit(tg->tgid, group_map);
>>>>>>  	list_del(&tg->next);
>>>>>> @@ -556,7 +558,7 @@ static int quota_destroy_group(struct evl_quota_group *tg,
>>>>>>  	 * hold rq->lock on entry, we do a trylock dance to prevent an
>>>>>>  	 * ABBA issue. No livelock is possible since we unregistered
>>>>>>  	 * that group already, so &tg->members can only be depleted
>>>>>> -	 * (by this loop specifically).
>>>>>> +	 * (by this loop exclusively).
>>>>>>  	 */
>>>>>>  
>>>>>>  	while (!list_empty(&tg->members)) {
>>>>>> @@ -583,10 +585,10 @@ static void quota_set_limit(struct evl_quota_group *tg,
>>>>>>  			int *quota_sum_r)
>>>>>>  {
>>>>>>  	struct evl_rq *rq = tg->rq;
>>>>>> -	struct evl_thread *thread, *tmp, *curr = rq->curr;
>>>>>> +	struct evl_thread *thread, *tmp;
>>>>>>  	struct evl_sched_quota *qs = &rq->quota;
>>>>>> -	ktime_t now, elapsed, consumed;
>>>>>>  	ktime_t old_quota = tg->quota;
>>>>>> +	ktime_t consumed;
>>>>>>  	u64 n;
>>>>>>  
>>>>>>  	assert_hard_lock(&rq->lock);
>>>>>> @@ -615,16 +617,8 @@ static void quota_set_limit(struct evl_quota_group *tg,
>>>>>>  	tg->quota_percent = quota_percent;
>>>>>>  	tg->quota_peak_percent = quota_peak_percent;
>>>>>>  
>>>>>> -	if (thread_on_quota(curr, tg)) {
>>>>>> -		now = evl_ktime_monotonic();
>>>>>> -
>>>>>> -		elapsed = now - tg->run_start;
>>>>>> -		if (elapsed < tg->run_budget)
>>>>>> -			tg->run_budget -= elapsed;
>>>>>> -		else
>>>>>> -			tg->run_budget = 0;
>>>>>> -
>>>>>> -		tg->run_start = now;
>>>>>> +	if (current_on_quota(tg)) {
>>>>>> +		quota_out(rq->curr);
>>>>>>  		evl_stop_timer(&qs->limit_timer);
>>>>>>  	}
>>>>>>  
>>>>>> @@ -646,7 +640,7 @@ static void quota_set_limit(struct evl_quota_group *tg,
>>>>>>  		list_for_each_entry_safe_reverse(thread, tmp, &tg->expired,
>>>>>>  						quota_expired) {
>>>>>>  			list_del_init(&thread->quota_expired);
>>>>>> -			evl_add_schedq(&rq->fifo.runnable, thread);
>>>>>> +			evl_add_schedq(&qs->runnable, thread);
>>>>>>  		}
>>>>>>  	}
>>>>>>  
>>>>>> @@ -786,6 +780,7 @@ struct evl_sched_class evl_sched_quota = {
>>>>>>  	.sched_dequeue		=	quota_dequeue,
>>>>>>  	.sched_requeue		=	quota_requeue,
>>>>>>  	.sched_pick		=	quota_pick,
>>>>>> +	.sched_out		=	quota_out,
>>>>>>  	.sched_migrate		=	quota_migrate,
>>>>>>  	.sched_chkparam		=	quota_chkparam,
>>>>>>  	.sched_setparam		=	quota_setparam,
>>>>>>
>>>>>
>>>>> You also seem to miss the case I discovered only yesterday as well: When
>>>>> starting the current thread on a quota via setparam, we also need to set
>>>>> its run_start stamp at that point.
>>>>
>>>> run_start should be meaningful only when a limit timer runs. 
>>>>
>>>
>>> Right, but are you sure it will be started in the case I described...?
>>>
>> 
>> To be started, it must be picked, so yes.
>> 
>
> But prev == next then - nothing new to pick, no?
>
> But let me apply your patch and stop only looking at the diff.
>

Beware: not tested yet.

-- 
Philippe.
