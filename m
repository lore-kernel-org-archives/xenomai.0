Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BA3BB100
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507693; cv=none; b=BGfnMLAl8OG6wCdsU27He3goL+CX/X4AReN4oSMLRc0mGe49kNZBDKgeAHGB9scT3w5SiHDgrMjO9cmEO599X6u4Pw5yhge9yyIjJzuRkmleyEy1rV50SB5f+rQVR5UqoG5IJPm215/Y2SoS2SnFrIyvy4sb5yX2Ac0Y53XxQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507693; c=relaxed/simple;
	bh=IuxmjOiX9we1NcEKstXsAGbCmnYQxMjsVcfUZcKVLI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rwj+2MBcCwa/IS628kdARrsqA1xseaqTE0XKWN+7c8Ct4j0MaGk8HOhFykQ0NguLegIUfvneDP9EYIg4sBbb15WNgHJn25m0hCZ9Wnki68bLyIPi9jdFU3aQ+tZjOuS//VKYRFoeDaYXEYHKsSKPvEjGavRhScEnGwDRzqlicWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Wjv48HfV; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Wjv48HfV"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26E083E962;
	Mon, 15 Jun 2026 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781507684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f23AQXfbOCteh8xFHJnr2Gskm5fX0F1pLQqI0wyPmLg=;
	b=Wjv48HfVBu4RE/iJ6Qh2jarKPPnst92cqW3z327UITcCtTy6cODXi7FE+KaAvCa99iIKe5
	Khw9H+zS5bS65SXFZ9fiuDaCpbf6Vu9yib49dFNE780cvIYfDimNzIUegR8SD8Av73Ougn
	lxXe3OOPQki43IQtuf+hOy/ciTKlxMzhwtYCUMQle743exLmIPCUTbhC5N5j9PbS0HMRxX
	ABO+jn53vYadN+Gu78EwacFGc2Efjl2rV20Ig4lZW3PuEfoqPzmHtemQzptViVAgljltOV
	4QLrueG19QDnDyax3pHVsASjx2wmwgAkdnrT+BKwffbLBleyUIy3z04f7a9xGg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
In-Reply-To: <d3d659d9-b327-4f19-89d0-7f53c3b18796@siemens.com> (Jan Kiszka's
	message of "Mon, 15 Jun 2026 08:46:34 +0200")
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
	<87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
	<d3d659d9-b327-4f19-89d0-7f53c3b18796@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 15 Jun 2026 09:14:43 +0200
Message-ID: <87pl1sgtr0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEgmEHg+fM9+gKygnIlPxPwpJURQ5lghUg8Mt/pNsriLDAqOnWycJOWS46FGAKRiVreI+bKXYxbLzGSEED+g2f5WU0/v9nfIw1IjzTOlW25oNjq+zV1Rk65H4QE8dbuzTUJ+QJHJTU3nRPe17Cqo4hPxXCA2/Dw6MDwF+GA0EV9fUPFKTDIqRwNKHVShmdngBlR/cmEDg8Mjof0uPJVn6SC3aJGhQHbrVrYqn/Kayo6TvKrVzfIbL2VsKTp9rFWmBoTunCkLNakcXFP9zJ1wfUGPhLGYy+N+o9YcUNS6GT53RUNim+3SI75yAy9S0upLlkgBbvJ0e6SMTAS8dno8BbRLV+NgXxPNOT9M4GRBh7AxsFMvW30oKe5ShYZhIC+J2aojG7ydnsCvLDvo03FYFHzj5CCb7FcDFAPPCMZ9+asfKaATJH2xv/rMM5/OTbfli+bnv/09eNHNKAY3T3ZZToqIKABmD79N1Nmhgdc/5qSJBgJ6vnqDbOA/ee/twVpDaFaNGOXLedHkf+LTxJKXG8oBq+wTFFf7Q3FB3VwWECv1k3YyP3CUg8adlyaath8ELEIPebBvPQcPTf+XsgASMSmE7I8FJt+W/DcguhaRtlJYOdFu4pPwt7ecdLPPSUxiJWG9NeZYP+PI9lshc5OTEv5ekuQXLTpItMx/6mBxUFpoQ
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 15.06.26 08:42, Philippe Gerum wrote:
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> This shall be invoked before a thread switch, providing both the current
>>>> and the next thread as arguments. Some scheduling classes may need it to
>>>> correctly handle their state as the sched_pick may not be invoked when a
>>>> higher-weighted class is providing the next thread.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  include/evl/sched.h     | 2 ++
>>>>  kernel/evl/sched/core.c | 5 +++++
>>>>  2 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/include/evl/sched.h b/include/evl/sched.h
>>>> index ae9690860146c..0b16f1b1cf626 100644
>>>> --- a/include/evl/sched.h
>>>> +++ b/include/evl/sched.h
>>>> @@ -120,6 +120,8 @@ struct evl_sched_class {
>>>>  	void (*sched_dequeue)(struct evl_thread *thread);
>>>>  	void (*sched_requeue)(struct evl_thread *thread);
>>>>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
>>>> +	void (*sched_out)(struct evl_thread *thread,
>>>> +			  struct evl_thread *next);
>>>>  	void (*sched_yield)(struct evl_thread *thread);
>>>>  	void (*sched_migrate)(struct evl_thread *thread,
>>>>  			      struct evl_rq *rq);
>>>> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
>>>> index eb133e334d30f..0d49fc16bd67e 100644
>>>> --- a/kernel/evl/sched/core.c
>>>> +++ b/kernel/evl/sched/core.c
>>>> @@ -910,6 +910,7 @@ static __always_inline bool test_resched(struct evl_rq *this_rq)
>>>>   */
>>>>  void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>>  {
>>>> +	struct evl_sched_class *prev_schedclass;
>>>>  	struct evl_rq *this_rq = this_evl_rq();
>>>>  	struct evl_thread *prev, *next, *curr;
>>>>  	bool leaving_inband, inband_tail;
>>>> @@ -990,6 +991,10 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>>  	this_rq->curr = next;
>>>>  	leaving_inband = false;
>>>>  
>>>> +	prev_schedclass = prev->sched_class;
>>>> +	if (prev_schedclass->sched_out)
>>>> +		prev_schedclass->sched_out(prev, next);
>>>> +
>>>>  	/*
>>>>  	 * Careful: we _must_ have updated this_rq->curr before
>>>>  	 * performing the rest of the context switch code
>>>
>>> I've been working on this lately too. It turns out that we need more
>>> than this, although this is definitely part of the solution. I'll follow
>>> up on this issue.
>> 
>> This is still wip, I'm sharing this early to discuss details for
>> reconciling both proposals (the hunk in __evl_schedule() is merely
>> cosmetic, no functional change).
>> 
>> commit f49dbd63c1389a6b99508ef0da852545b102d1cc (HEAD -> wip/fix-quota-sched)
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Sun Jun 14 12:08:59 2026 +0200
>> 
>>     evl: sched/quota: fix budget tracking on preemption
>>     
>>     Upon preemption of a SCHED_QUOTA thread by a SCHED_FIFO one, the
>>     runtime budget of the former is inaccurately tracked. This is due to
>>     the fifo->pick() handler returning a valid thread, which prevents the
>>     quota->pick() handler from being called. As a result, the last runtime
>>     period of the outgoing thread is not accounted for.
>>     
>>     To fix this, we introduce a new sched_out() handler which is called
>>     for the outgoing thread, which the quota policy uses to update the
>>     remaining budget of preempted threads appropriately. In addition, the
>>     implementation no longer shares the runnable thread queue with
>>     SCHED_FIFO.
>>     
>>     Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> 
>> diff --git a/include/evl/sched.h b/include/evl/sched.h
>> index ae9690860146..cc824c28004b 100644
>> --- a/include/evl/sched.h
>> +++ b/include/evl/sched.h
>> @@ -120,6 +120,7 @@ struct evl_sched_class {
>>  	void (*sched_dequeue)(struct evl_thread *thread);
>>  	void (*sched_requeue)(struct evl_thread *thread);
>>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
>> +	void (*sched_out)(struct evl_thread *thread);
>
> The out handler also needs the target thread in order to identify if
> there is a tg change or not.
>

Your implementation needs this because the sequence is pick() -> out(),
mine is out() -> pick(), with the latter using the budget updated by the
former to figure out what to do next.

-- 
Philippe.
