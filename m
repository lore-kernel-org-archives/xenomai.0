Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022818872A
	for <xenomai@lists.linux.dev>; Thu, 18 Jun 2026 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770553; cv=none; b=ltcqRtJIwL1ERHPl4B60TeuxW8g0XnKmleM/UDMDCjKxNb8cwRWKCsR1OTcolluamncR+Ul7iOcVsUBjwgsR/2Uyy9EFwGXg/FRB6Io2BDf4QT9A39WEqjP0MW0aSxdXRBdE4MCclGx314ALGsHlDscX0TlAF8rwpReGccnxzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770553; c=relaxed/simple;
	bh=pLmttEV7vvHcriqFhFsJaPyULKoM3Csm1/U/Zzi4Tg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJ7iJ4pBDBjYpevAxQuzrcKklOs8wwEfHa6kR7rxviV2ajvEkwhqJdhOSlt6ULfufA47pI/DDohEtfXPhMQwP/nGBRagPj8Rbm1NrSeFyPukSnU+dilAU53ymtS991XjhjQnxLccfGzklBSUFsYAe7+GZSr0qO0FRe0Ib4Lk8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=bRqt0Hs+; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="bRqt0Hs+"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39D793E9BC;
	Thu, 18 Jun 2026 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781770550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EYEtNY84RhCecMl9tu04NErnN5FSqt+KdVOp8trfTiU=;
	b=bRqt0Hs+owM2hSmrpYm/fC8tEtpMoBL3g/N1qvNiVdGMQjs6mHRDnZUfp0Ee8/7lK0hMCt
	AIwm75cmG44ezQj79biIN/CfBA0NuvTC7EgYXWerInMea02TBC9U2ECuI5jBq6SKpcvsQX
	StntmqyrVubgvAohTDD0+rUMKeF+9/KJdsajCEO4SdF9Pii9I7bN/92MObVKNmgOKIhpIl
	8Q0xQ30/xA1dSanEVKCfsI1sUD4u27hL8ihv8l3xBVQiKg2yxhSIruWLke9e+GXHp6BxG6
	MT+8Y6t8v7Xp5fYaGQd8Dj0D2/AF+Pf4IxWuozLULUTxJV+lwjxUi4DcCsGwXg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH v1 1/2] evl/sched: core: introduce schedule out handler
In-Reply-To: <ce854c70-3f03-4393-81b7-813444280606@siemens.com> (Jan Kiszka's
	message of "Thu, 18 Jun 2026 09:47:02 +0200")
References: <20260617142050.477809-1-rpm@xenomai.org>
	<20260617142050.477809-2-rpm@xenomai.org>
	<c7f75276-309a-4ed6-91b0-7df82ae8c59d@siemens.com>
	<87ik7gs367.fsf@xenomai.org>
	<ce854c70-3f03-4393-81b7-813444280606@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 18 Jun 2026 10:15:49 +0200
Message-ID: <87a4sss1qi.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEHl2oP5GG7E9O3j8oAE9R5Y11PsBfWOt5OciNtJ2WAyrUbiT3etsWeffTEv+6qnwMSrr0OwCbaRR79BEAvF6y2DJJFJWxGVEPkGgnk0OObbA0FLGmZ/jT3M/XsgOfV5sVisuuwVsRCcaNclG6Im1zmz4VdWblfRb7GETKciIY6qiTOJjZj5SttdVpu1pbqlCxo7CSt8Mb4BLBf5jxhMYgMIisQfBIXhGZhenqkYf0HVjsesCJRlZJqGPC7IV+MPjjHVZXXxyDKKfJQmTDB/Jl/Sq26F7jK1OUwzevHf7QKBCJlI2eV9S2HbcfB6gz9H/iRos6LhIm+vZTZUS2xXshUbzF6lrr6YAMEuiiiqEZTc1Dq5q9QU6fVsoub1OkDJYML7rtWsO56pEODedTjiUMLNXZfJvM/APTOUr2sQfsa02NZwS0k4ik4Zy3+4RXaABPrXLTeVOQC2EEzl3Al+TS2jq580Af3+7kwwjG4Ykfyrq/lRSC+3Z2QUg/4m9+no2RD6zz/mTS/+opjhT9UNq4C0IfwOEN1Viq7fAmzzquHocm6XnLsvSlRlkteeTwi8liK0mqKHxlkvS+QeiyVwxByhcsoU5q9euNnubnVJ9FW91vTPY2wNC28f8txfUHtvWcl5Q8j+3IweBBExX7WbkPIU6scDvtjjMKQOFGfNizMrg

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
> Again, it is suboptimal style to fold refactorings into logical code
> changes. If you split this up into two commits, properly explaining the
> purpose of that renaming, things become readable to 3rd parties.
>

I understand your point of view, I simply disagree with the scope of the
requirement as you state it. So let's move on.

-- 
Philippe.
