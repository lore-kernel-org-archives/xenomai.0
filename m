Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7C395AC4
	for <xenomai@lists.linux.dev>; Thu, 18 Jun 2026 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771084; cv=none; b=RgVWVGC8B9D/J8nPNvNJzr7NeCi9PnpcXdM2XoRJQ/bSOfLpenZ0zEU6l3XpuCyPx43/bfSN22/OEpzz0Aq+27EtgjXxPe1w5OK4gJrk4SR1BGsBOfvKgTTuFvxjYIJeyB+wz1d3Fhi2bsb8il8irMsAiDyNoo9Xj3sxbuqTOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771084; c=relaxed/simple;
	bh=HTot9CEQuCFomFdqYBOWQLzjT9WKhQ4NW17xsFkpDNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IKAUYDNjMXFgP2hf8tzYnkimjo63FkcolUiIjJDTA8dFLGbTsEG7EkA4OzslMVO0+NcBeuz8vg1ymHnagkq+gUxbr6Kq+W7L8M8OGylheTk//j1nj1Ut1c9//VfV015AzjsBojrDJCew2BYK4WMu/Vj5tasjvGlA1w6OegnFoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Emym/QeN; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Emym/QeN"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B29CF3E9B9;
	Thu, 18 Jun 2026 08:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781771079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xWq6Mk75RcmLB72M/AEC6Z2y1X3J4Th5nBDRbBtjJvo=;
	b=Emym/QeNedwvOS6dQr2ZMlSHPBc6PMTOGZeE/VNvGDzfnkUgS90PwJpOfO+SFGqAo/o00Y
	XbvYkv/3AM7Ovs6EPxtlTqQBovJj5t+haXvtup2TeR1QSoZRaphILFckCTpT2roIaxA0aP
	Bp64g+fcXLXTulucJWoPYfBz+DwP3ksA9NQhBRyM35waoGa0FFhuVbBa1uIGIoH2dw3U1s
	S/4IYLaf+jSw+EbPa1wYDbEP5VZoe6kk5Bm0BG6SjLWPjKOMdYgSts4P9Kuc9VgkHxyuAK
	8k8m0l/2AYfka27/uP/T8AQ4QMJXTYoZMUuvpq8UzH0PSoOPz/6lXHGPjx4KvQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH v1 1/2] evl/sched: core: introduce schedule out handler
In-Reply-To: <58885755-a25b-4b71-86f9-166d0428990e@siemens.com> (Jan Kiszka's
	message of "Thu, 18 Jun 2026 10:04:09 +0200")
References: <20260617142050.477809-1-rpm@xenomai.org>
	<20260617142050.477809-2-rpm@xenomai.org>
	<c7f75276-309a-4ed6-91b0-7df82ae8c59d@siemens.com>
	<87ik7gs367.fsf@xenomai.org>
	<58885755-a25b-4b71-86f9-166d0428990e@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 18 Jun 2026 10:24:39 +0200
Message-ID: <87y0gcqmrc.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFx7m0l4Ff5hMhBAQERsik8+gLkSV6sATqIHmgZobb3choccX5mKLyHzlws53QYviU5xG4rP0R9vQpNtvJZC+goSShRibhOahKTtPx/0fpcdtMdZ/6ktxqH713QdbLjBxGbLZWqvHNWUus9bEuLbZaPxNvwYK83+I1hQ5UeZ/0EzpooY1uYGDZ51NBBCXYJsVR6ueiZq2vouGLNt/4lQmQxUkF3IAhMmGREode4zhiZb8U3dusmMpeEh75CxGn5jqD9DVMN+1m3CwJwPmKsGyLmsCC6HqhhezwC1l8ZGza9gSYX6BpP/bBYSSmpeD9y0LamzAkcjFcblOc6RgcPTmHAsWCC10eKYo1hQevKMrAtjoTWIgddTRxiYCvz3fHXCm2e4+EhdQf/+eYAfwM1VIwc9AYIe+EDhMs8W/JsA+vb/fq+mQzv1V9jpeXTA5Ev1D1J5MbicgXlauPYn4qCvZ/0zd5BHb3LnEYkvquUxUmSXjQWFGSTVre+q/5N8teV4yZiTrMFzbjR3UA1VvUunAdayVsnBsdAgOctvfS4S+SQVolK5mNRbXCf/d976PJUN8kZLZvDJzy4hOVb7havVpCPg/5xjQebpu6KSyEhwGDpE3Tcmkula8AArTkiFp4/TtqWEzwPlUomWzeHZI8MN3VeaWAck5ULwHJRklGLbRsHIQ

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 18.06.26 09:44, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 17.06.26 16:20, Philippe Gerum wrote:
>>>> From: Philippe Gerum <rpm@xenomai.org>
>>>>
>>>> Some scheduling classes may need a way to perform specific
>>>> fixup/accounting work for a thread which is being scheduled out.  We
>>>> cannot rely on the sched_pick() handler for this since the first one
>>>> to successfully pick a thread prevents other handlers down the class
>>>> hierarchy to run.
>>>>
>>>> To address this issue, we introduce the sched_out() handler which is
>>>> called for the current thread when scheduled out. This handler is
>>>> invoked unconditionally when present prior to picking a new thread.
>>>>
>>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>>> ---
>>>>  include/evl/sched.h     |  1 +
>>>>  kernel/evl/sched/core.c | 20 +++++++++++++-------
>>>>  2 files changed, 14 insertions(+), 7 deletions(-)
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
>>>>  	void (*sched_yield)(struct evl_thread *thread);
>>>>  	void (*sched_migrate)(struct evl_thread *thread,
>>>>  			      struct evl_rq *rq);
>>>> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
>>>> index d1d025e06a5d..7127d4e52df9 100644
>>>> --- a/kernel/evl/sched/core.c
>>>> +++ b/kernel/evl/sched/core.c
>>>> @@ -773,7 +773,8 @@ static inline void set_next_running(struct evl_rq *rq,
>>>>  		evl_stop_timer(&rq->rrbtimer);
>>>>  }
>>>>  
>>>> -static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
>>>> +static __always_inline struct evl_thread *
>>>> +__pick_next_thread(struct evl_rq *rq)
>>>>  {
>>>>  	struct evl_sched_class *sched_class;
>>>>  	struct evl_thread *curr = rq->curr;
>>>> @@ -821,8 +822,14 @@ static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
>>>>  /* rq->curr->lock + rq->lock held, hard irqs off. */
>>>>  static struct evl_thread *pick_next_thread(struct evl_rq *rq)
>>>>  {
>>>> -	struct evl_thread *next = __pick_next_thread(rq);
>>>> +	struct evl_thread *next, *prev = rq->curr;
>>>> +	struct evl_sched_class *prev_class = prev->sched_class;
>>>>  
>>>> +	if (prev_class->sched_out)
>>>> +		prev_class->sched_out(prev);
>>>> +
>>>> +	next = __pick_next_thread(rq);
>>>> +	trace_evl_pick_thread(next);
>>>>  	set_next_running(rq, next);
>>>>  
>>>>  	return next;
>>>> @@ -972,21 +979,20 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>>  		return;
>>>>  	}
>>>>  
>>>> +	prev = curr;
>>>>  	next = pick_next_thread(this_rq);
>>>> -	trace_evl_pick_thread(next);
>>>> -	if (next == curr) {
>>>> -		if (unlikely(next->state & EVL_T_ROOT)) {
>>>> +	if (next == prev) {
>>>> +		if (unlikely(prev->state & EVL_T_ROOT)) {
>>>>  			if (this_rq->local_flags & RQ_TPROXY)
>>>>  				evl_notify_proxy_tick(this_rq);
>>>>  			if (this_rq->local_flags & RQ_TDEFER)
>>>>  				evl_program_local_tick(&evl_mono_clock);
>>>>  		}
>>>>  		raw_spin_unlock(&this_rq->lock);
>>>> -		raw_spin_unlock_irqrestore(&curr->lock, flags);
>>>> +		raw_spin_unlock_irqrestore(&prev->lock, flags);
>>>>  		return;
>>>>  	}
>>>> - 
>>>> -	prev = curr;
>>>
>>> This hunk subtly look like a pure cosmetic change, without any logical
>>> impact. If it does have one which I missed, it should be explained in
>>> the commit message at least.
>>>
>> 
>> It has none, as mentioned earlier in a previous post. The point of this
>> change is to clarify the naming, introducing 'prev' as an alias to
>> 'curr' in the swap sequence. So there is no point in documenting this.
>> 
>
> BTW, I would not make lock/unlock work against different variables
> names, though they carry identical pointers. That is more confusing than
> the current code.
>

Yes, that point is valid. But in that case, there is no point in even
clarifying the rest either. Ok, dropping the whole thing together.

-- 
Philippe.
