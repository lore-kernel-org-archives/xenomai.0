Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC7A3B9D9B
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508588; cv=none; b=J8bl+oQIUN2KUxv6Thajko5ympkOnB7pUZ1LCpx36J4l9UwNbDDrITAArieZV7MWhjIwL0cvWlB6lDl4/UaWKJ2eEaCrjCc4cqZHEY1DImKmQYiBV8GH28uhWv0SNi3pDOe5cm1ZCjNVkCBM7ZJe9aKFVcNvDLR+hsDoOjkG5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508588; c=relaxed/simple;
	bh=hiQSr3c3uoy3yxe4J1ajY+Wmy9vb82EyPHZYCZfk3FM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GtRKnP6oAOYQVpFhNwNmabXmUDScG3GUYlE70lovFqD5zfNHokHzZU/K50tds5MDbqLqNkVqpwBTtf7BtgSiGeuxcpDgvfb0snxaM/C/BQu3Fy9jXJGKvCiP05E5KZw2AU0Did6rd6SCYCksQJOY9fL07925TL3ZjjpAn0452G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=WvcCP49G; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="WvcCP49G"
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE2E83F6B7;
	Mon, 15 Jun 2026 07:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781508585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kwobOhbn/lsrbeN1IQvQnvxEiKjVyu+tc23lVIaRZBo=;
	b=WvcCP49G6ts2o6Dt0fXGQa1zXKxXoUxwiZUWqv5f+a4hNqQfgfKdLCLAdZeWFcEKi54MHK
	RxF8Regk7+/jF5iUwAFk3uTohMNssOy5BA9IaIlW3gQ9ttcTa9xMG0MSRE2xOjJXu7vyDs
	GGEvoUuKrztRXwNGppbCGKtBQXuKnN7r4ZYw1PUMNDLD77w9W1LhGxmvvehZGCODMG72fA
	SG9PB/1feOkUdlGxbHok/KOY4Gr2kRgWdD6ICJg0Eeskj+hcA2Lq3iOyOx6vbFkCUeBwrh
	rzQXhwV0LHC14s/Tq2H61s3IbK7wH8gFB54pzBoL9bAWf9i5fkkrZbV7qqQ34A==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
In-Reply-To: <c9760910-9b99-4cab-a776-c472bfbc445b@siemens.com> (Jan Kiszka's
	message of "Mon, 15 Jun 2026 09:21:12 +0200")
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
	<87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
	<d3d659d9-b327-4f19-89d0-7f53c3b18796@siemens.com>
	<87pl1sgtr0.fsf@xenomai.org>
	<c9760910-9b99-4cab-a776-c472bfbc445b@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 15 Jun 2026 09:29:44 +0200
Message-ID: <87bjdcgt1z.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFxPQwaYjFZf9hxVt63vq76dOffcSDLubzDQft16tvhjGAajXZ7oOoUpEeLevqF+zHUTtCDKbAmj/IxcTuGxiMKMm9hBYemzepslKu1ZGIhR1bfMTTU8PqOuuXmE6RcvDaEYK4ZSkaqrhYynJkUPqHmOqoFnWec+QFVRgsDKuJ1VdjLvKoVQhNRCV7o7NCkoLbI1EnuLMVAHCDra1uagKveITmFIr9UJYlnVA1m8xuG4gYXRF77Ec7NsE9FKsDsNkdAIMNg3vUPdI7+lTAqy1HTFSLOVCFuucn5RofXT08sxFn8zLMkOut9CvUGc/rdFqWkXw8YnjrCwh3v4Z3V9LMUSuxLM/5IXC7BU5ROqOxKmi1G1C2xa8cJsva4BNUq8VAiWFciyn+fCB/uFlpJbm6hs/2oyTNQalRlaDPab6D6xldoYu/Yn3DaaSIZ4zZ+6T2fZ/q3QA5Pzt6wzLAxSsbV6ejzEaUZJQFvpNDqEzA7d2udfbtVawPOHF8Rq9HF7JvBkbbjgQJsXzXKokiRJ7F1wqkFEdjuBqPpz36lsDmFZhSegWuZQL8Y2ITnvBw9agOaTVxYb5xCosLNPPgxVujy9oRrzqAnc29+mxIGN4X6klu7Te/3k2DZhFEFQsA3yVDInB31OqyE5hzSxJdPvKiv4UbnnQiHwmYxzUcAK7cfdg

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 15.06.26 09:14, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 15.06.26 08:42, Philippe Gerum wrote:
>>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>>
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> This shall be invoked before a thread switch, providing both the current
>>>>>> and the next thread as arguments. Some scheduling classes may need it to
>>>>>> correctly handle their state as the sched_pick may not be invoked when a
>>>>>> higher-weighted class is providing the next thread.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>>  include/evl/sched.h     | 2 ++
>>>>>>  kernel/evl/sched/core.c | 5 +++++
>>>>>>  2 files changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/include/evl/sched.h b/include/evl/sched.h
>>>>>> index ae9690860146c..0b16f1b1cf626 100644
>>>>>> --- a/include/evl/sched.h
>>>>>> +++ b/include/evl/sched.h
>>>>>> @@ -120,6 +120,8 @@ struct evl_sched_class {
>>>>>>  	void (*sched_dequeue)(struct evl_thread *thread);
>>>>>>  	void (*sched_requeue)(struct evl_thread *thread);
>>>>>>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
>>>>>> +	void (*sched_out)(struct evl_thread *thread,
>>>>>> +			  struct evl_thread *next);
>>>>>>  	void (*sched_yield)(struct evl_thread *thread);
>>>>>>  	void (*sched_migrate)(struct evl_thread *thread,
>>>>>>  			      struct evl_rq *rq);
>>>>>> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
>>>>>> index eb133e334d30f..0d49fc16bd67e 100644
>>>>>> --- a/kernel/evl/sched/core.c
>>>>>> +++ b/kernel/evl/sched/core.c
>>>>>> @@ -910,6 +910,7 @@ static __always_inline bool test_resched(struct evl_rq *this_rq)
>>>>>>   */
>>>>>>  void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>>>>  {
>>>>>> +	struct evl_sched_class *prev_schedclass;
>>>>>>  	struct evl_rq *this_rq = this_evl_rq();
>>>>>>  	struct evl_thread *prev, *next, *curr;
>>>>>>  	bool leaving_inband, inband_tail;
>>>>>> @@ -990,6 +991,10 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>>>>  	this_rq->curr = next;
>>>>>>  	leaving_inband = false;
>>>>>>  
>>>>>> +	prev_schedclass = prev->sched_class;
>>>>>> +	if (prev_schedclass->sched_out)
>>>>>> +		prev_schedclass->sched_out(prev, next);
>>>>>> +
>>>>>>  	/*
>>>>>>  	 * Careful: we _must_ have updated this_rq->curr before
>>>>>>  	 * performing the rest of the context switch code
>>>>>
>>>>> I've been working on this lately too. It turns out that we need more
>>>>> than this, although this is definitely part of the solution. I'll follow
>>>>> up on this issue.
>>>>
>>>> This is still wip, I'm sharing this early to discuss details for
>>>> reconciling both proposals (the hunk in __evl_schedule() is merely
>>>> cosmetic, no functional change).
>>>>
>>>> commit f49dbd63c1389a6b99508ef0da852545b102d1cc (HEAD -> wip/fix-quota-sched)
>>>> Author: Philippe Gerum <rpm@xenomai.org>
>>>> Date:   Sun Jun 14 12:08:59 2026 +0200
>>>>
>>>>     evl: sched/quota: fix budget tracking on preemption
>>>>     
>>>>     Upon preemption of a SCHED_QUOTA thread by a SCHED_FIFO one, the
>>>>     runtime budget of the former is inaccurately tracked. This is due to
>>>>     the fifo->pick() handler returning a valid thread, which prevents the
>>>>     quota->pick() handler from being called. As a result, the last runtime
>>>>     period of the outgoing thread is not accounted for.
>>>>     
>>>>     To fix this, we introduce a new sched_out() handler which is called
>>>>     for the outgoing thread, which the quota policy uses to update the
>>>>     remaining budget of preempted threads appropriately. In addition, the
>>>>     implementation no longer shares the runnable thread queue with
>>>>     SCHED_FIFO.
>>>>     
>>>>     Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>>>
>>>> diff --git a/include/evl/sched.h b/include/evl/sched.h
>>>> index ae9690860146..cc824c28004b 100644
>>>> --- a/include/evl/sched.h
>>>> +++ b/include/evl/sched.h
>>>> @@ -120,6 +120,7 @@ struct evl_sched_class {
>>>>  	void (*sched_dequeue)(struct evl_thread *thread);
>>>>  	void (*sched_requeue)(struct evl_thread *thread);
>>>>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
>>>> +	void (*sched_out)(struct evl_thread *thread);
>>>
>>> The out handler also needs the target thread in order to identify if
>>> there is a tg change or not.
>>>
>> 
>> Your implementation needs this because the sequence is pick() -> out(),
>> mine is out() -> pick(), with the latter using the budget updated by the
>> former to figure out what to do next.
>
> But that will call out even on old == new - does not sound right.
>

Call to determine that next ends up being prev, then filtered out by
quota_pick() as a consequence. This is strictly identical
performance-wise.

-- 
Philippe.
