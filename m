Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9BE3DB635
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517566; cv=none; b=kKCexcACoyd46bnxtD5SIeuVOsbt5EPD+ECtEUD7ao8e6rmEVCQ26DzhezqXpMrEOGx6IPEXeLdPTZdGOkA1fQtZF+GlrtJmg3lmtNkz2J94PxxuxxZJ9fsqriJrYjUxi5A72XWkxXuDL0wFq7hR+XUSksW7EqZlIluUv7iFMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517566; c=relaxed/simple;
	bh=vPwtb0qJZUQlNnbYcXaHToqEwYu65ak5ffShm1/FdAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FY4KSikoq4ZvhhCPaHE9QYwbEbviskq4hGUgxCQJttZEt1e9gjyn76zbvKeuPUItBU9R2R5OquhwC58AzjFFMydL3jZhxF5XLIscYjoKk6hUrzyhzX+j7utAHWor5CmzSjfCVwbbhql45WHrTYqsQDgfDArPJBAG9Kj1bRBw0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Gbz9NmvM; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Gbz9NmvM"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C1E63EC21;
	Mon, 15 Jun 2026 09:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781517562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJfqbFww5HGOOenhzcW+p/pDh9iFArXfv/Gg7BClNGs=;
	b=Gbz9NmvMw0pDuRd40AWJTZL4+xdV7Z/ntmA7hIcGcL01n0u2olopBcwBsA2T3owpMvsQcB
	4h5yPkI8Ww/gmXjbblJ3Kso1LtaBaWUlVFl3QhxjEdM30BnQSQMyn0elkmzpBpIg/mFs1M
	XvZLnT6N8+HmxXSHuWxRHNb0qRDsVkloPOKXgmKMr+ZsLmIX4A+X9ipf4v9c+i4/Gp7bia
	FSKSySYErEzgIzWmFM9lSAeOd+9UK4lqX1EmoK2/g8dFTuf72ksxbdPXSZe0qqQufYtc36
	ZSK64AiNRxkdyCsLkK7c06MXkDtsr/aHEffz/28dHlbY0XoHSz3rYp5fZpU+Zw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
In-Reply-To: <4797a713-e16f-4792-ab7a-51a2876fb6ef@siemens.com> (Jan Kiszka's
	message of "Mon, 15 Jun 2026 11:04:32 +0200")
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
	<87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
	<4797a713-e16f-4792-ab7a-51a2876fb6ef@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 15 Jun 2026 11:59:22 +0200
Message-ID: <87wlw0cef9.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFbtLa0/p8TPhL0sXL9aQw2cFoqEvvSE+JDii4G4tsqMgX4Jgsj3CgfVIl8oCH4tAH8VONq63PkPHCW8qvsrC28Mvd1JtBHx7P+Vfy/JbLaN76c9Nu38kK/nPa0lDVxwfqAN5Rcy7bYHzpxUQqX6YfiCbyjz/m6x7YiOqFEHJu33XO8P8UnLYzwhpWqlLIC+LCj3k+hKCyXEJaypEY9LRnusR+qWxWUFI6M+Nx88ny0JBRLT+bTCM8nI6TlarNh8dwNeIqHgYDhwFaAwBwOuvQASvsDpa+zG4bMNPGhf4uxpVtcC5E0Ku/q0rdXibUjOvoo20NqAk0DLb/f+RYP9mQmeZqn2sEC7eLdseK2fOQyRsR4fNnB9uPbCTENElU9RSPwwa+TAiY2gSMDMFGNkgJETjpsFhUwURZ88TYB7nFtf49f2/FDx/PV8VJRse7xaIcUxS0cfnqo3NceC2Df4HRh+XXKm31ok1Zs0O6WRBKxBUKPyf3JjJ2lGIWW8rqpLWxH20DF64Hl6ifPy8VzgGaT+8yKSH77Mv40F2SBwnQvSVqL0Kml7DAhidQxrghtIUw+gsj+dn/k+Q8y+4avUSvqfRcavggeeHxKEJEiFMa7IQNYUDh7PctV2tOF56SYHgR9HCjbbJ8ndjQ2TzJbtu7TmnAQTsLS76kL88CpIg+2DA
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 15.06.26 08:42, Philippe Gerum wrote:
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>
> You also need to update tg->run_start. Otherwise, you will overcharge
> the next time this group is checked here.
>

Yes, this needs fixing.

>> +	} else {
>> +		tg->run_budget = 0;
>> +		evl_stop_timer(&qs->limit_timer);
>> +	}
>> +}
>> +
>> +static struct evl_thread *quota_pick(struct evl_rq *rq)
>> +{
>> +	struct evl_thread *next, *curr = rq->curr;
>> +	struct evl_sched_quota *qs = &rq->quota;
>> +	struct evl_quota_group *tg;
>> +
>>  pick:
>> -	next = evl_get_schedq(&rq->fifo.runnable);
>> +	next = evl_get_schedq(&qs->runnable);
>>  	if (next == NULL) {
>>  		evl_stop_timer(&qs->limit_timer);
>>  		return NULL;
>>  	}
>>  
>> -	/*
>> -	 * As we basically piggyback on the SCHED_FIFO runqueue, make
>> -	 * sure to detect non-quota threads.
>> -	 */
>>  	tg = next->quota;
>> -	if (tg == NULL)
>> -		return next;
>> -
>> -	tg->run_start = now;
>> +	tg->nr_active--;
>>  
>>  	/*
>>  	 * Don't consider budget if kicked, we have to allow this
>> @@ -439,25 +437,29 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>>  	 */
>>  	if (next->info & EVL_T_KICKED) {
>>  		evl_stop_timer(&qs->limit_timer);
>> -		goto out;
>> +		return next;
>>  	}
>>  
>> +	/*
>> +	 * __pick_next_thread() might have requeued the current
>> +	 * thread which is still leading the pack.
>> +	 */
>> +	if (curr == next)
>> +		return next;
>> +
>>  	if (ktime_to_ns(tg->run_budget) == 0) {
>> -		/* Flush expired group members as we go. */
>> +		/* Park expired group members as we go. */
>>  		list_add_tail(&next->quota_expired, &tg->expired);
>>  		goto pick;
>>  	}
>>  
>> -	if (otg == tg && evl_timer_is_running(&qs->limit_timer))
>> -		/* Same group, leave the running timer untouched. */
>> -		goto out;
>> -
>> -	/* Arm limit timer for the new running group. */
>> -	evl_start_timer(&qs->limit_timer,
>> -			ktime_add(now, tg->run_budget),
>> -			EVL_INFINITE);
>> -out:
>> -	tg->nr_active--;
>> +	/* Arm new limit timer on change of running group. */
>> +	if (curr->quota != tg || !evl_timer_is_running(&qs->limit_timer)) {
>> +		tg->run_start = evl_ktime_monotonic();
>> +		evl_start_timer(&qs->limit_timer,
>> +				ktime_add(tg->run_start, tg->run_budget),
>> +				EVL_INFINITE);
>> +	}
>
> I still don't fully get how the limit timer should be started on
> setparam over the current thread. Will curr be NULL in that case, thus
> curr != next? Is that the reason to go for a separate runqueue?
>

Nope, that one is only to make things clearer, since there is no upside
in sharing the runqueues (this was inherited from SCHED_SPORADIC for no
obvious reason with hindsight). At some point, I noticed that it would
even have introduced a bug in a previous tentative implementation using
sched_class as a discriminator between threads, to figure out whether we
should call the sched_out() handler. So, the simpler, the better:
distinct classes, distinct runqueues.

Regarding the limit timer issue, sched_pick() should not shortcut on
curr == next. IOW, the rest of the code should run even in this case. By
turning on the resched bit (which the quota_setparam() caller does), we
would end up in sched_pick() with either of those outcomes out of
quota_setparam():

- 'current' switched group, in which case we would arm a limit timer in
  sched_pick() because curr->quota != next->quota (provided the shortcut
  on curr == next is gone).

- 'current' stays in the same group, so the limit timer still runs unless
  the budget was already fully consumed.

So I would revise my latest patch as follows:

diff --git a/kernel/evl/sched/quota.c b/kernel/evl/sched/quota.c
index 3ac650c08ccb..8f1321d46cac 100644
--- a/kernel/evl/sched/quota.c
+++ b/kernel/evl/sched/quota.c
@@ -407,6 +407,7 @@ static void quota_out(struct evl_thread *thread)
 	now = evl_ktime_monotonic();
 	consumed = ktime_sub(now, tg->run_start);
 	if (consumed < tg->run_budget) {
+		tg->run_start = now;
 		tg->run_budget = ktime_sub(tg->run_budget, consumed);
 	} else {
 		tg->run_budget = 0;
@@ -440,20 +441,13 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
 		return next;
 	}
 
-	/*
-	 * __pick_next_thread() might have requeued the current
-	 * thread which is still leading the pack.
-	 */
-	if (curr == next)
-		return next;
-
 	if (ktime_to_ns(tg->run_budget) == 0) {
 		/* Park expired group members as we go. */
 		list_add_tail(&next->quota_expired, &tg->expired);
 		goto pick;
 	}
 
-	/* Arm new limit timer on change of running group. */
+	/* Arm new limit timer if need be. */
 	if (curr->quota != tg || !evl_timer_is_running(&qs->limit_timer)) {
 		tg->run_start = evl_ktime_monotonic();
 		evl_start_timer(&qs->limit_timer,

>
> Looks ok otherwise, tests pass as well.
>

Uh? Ok. That was absolutely unintentional at this stage!

-- 
Philippe.
