Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DBD3603F6
	for <xenomai@lists.linux.dev>; Thu, 18 Jun 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768702; cv=none; b=J53srrHpPNKBbaG5DSjFsG0Mjoap/rOOFDhLWw+7E34RAA78PNF3lNN9+5meUADrCF1t9ybSDY3LY+kQxyxk7wicl/WDRZjar/YX9OSmf2XMjBZ2D52V4Kk1m2ZgmamyxVyzvtpHT2sWSosPe5MqORGDEFk68Yh1rB/3ubDxcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768702; c=relaxed/simple;
	bh=xH5A51jl80WfEpDMEDiZ//ZomGtPetAltHLbXPw/IMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NP0ckzR8G0ZYMqd88d/V6LkHF+Q5t0DRxR10URqSU1iE4rgyIHtn8LojlaTDy9SNTM2r+gpBcCnxh7JaxGGv9h8iIO0MZJjUihcO3gtyOcao3S44RH1BiAvNR1+F6vx0Wk60UFAuCJ8Xc1fl/X43a3SNwc1a7ZhDSV5yQ6QRDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=cPteo4t7; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="cPteo4t7"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F34B3F6E9;
	Thu, 18 Jun 2026 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781768692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygJWEeYKKumbTISwQ2rfXyueObiyzNZpAyl2tALrwbg=;
	b=cPteo4t7IfkqHTFJJ5SrZYVM1Euvft5iKpyffoAAHEGcIbyToJUN9A9v18dyw0P9egjSwV
	hBM/a/S2P+Ri1gC4J8JFeHXyPur+CF9rRi43NbOE5klydGLop9ZBiKRQO5xPU1TxqqF2A0
	c5/bCAG3XXJNCgD4rpjET5ygLv33Yy1fY61AC6QAlO4JlwgOahaGcG1fqgJKpnvP2kyNKs
	f2CDhwtPBjQKFaHUSv0h+KVlMdYz6UzQSZyIuh2IZVC2pW/1V5Qdisg5/AkMDpWT1JwY5q
	uuXjlAe96aJnQ23+AFvWRpjITRn2jJw/JF2jTJq6p70dZvqk3ZtTEE7t/1spBw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH v1 1/2] evl/sched: core: introduce schedule out handler
In-Reply-To: <c7f75276-309a-4ed6-91b0-7df82ae8c59d@siemens.com> (Jan Kiszka's
	message of "Thu, 18 Jun 2026 09:38:56 +0200")
References: <20260617142050.477809-1-rpm@xenomai.org>
	<20260617142050.477809-2-rpm@xenomai.org>
	<c7f75276-309a-4ed6-91b0-7df82ae8c59d@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 18 Jun 2026 09:44:48 +0200
Message-ID: <87ik7gs367.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEHlKaglqjlLRuAetW9GSL5vayoB6Ln1HGzyC+P5LitqNRgLLkLvcPpfPOFt4RT9Nnzs5lC5Z/P7j5WdzjpqKWgx4upBLq3pBblTYNa0+tM7YbWo8w4IG2SpklRXPV6LUZaVq3DU5g3jogt4K5B9UJZaFTgRlC3ikAzUKv9OfsOxQm+fijY6nVxSa2j6ZlwAr1ICQoJ4Xjt9+/T4p+17uYKvHuguAGd2Hx1MYkUjKtKNnLLBX4dqi7hNtv17wy0GXXp+SIPe7E+YvS7jS52DHEhL+urenDQpMzsUgpmg+osLKCRBx5DBTtqtlyj4WFKT1By9iK7Imb6wkn6/sYOR15wq1sDu97CqkD/Tr1IMG4wV4C3JmfWf12Q00S5+atGTLbQFzma8LUmV8DBZgGhyPVvMCtnSjuBkyfx96C4ytyVQ5G2YQLa1ZcVubQeQfzAJhSVVbWknUVzOvyMi/m+LV50hcpvHMDcAoKuAHtpfUOm/j9HGclTPKL5FXx9mShpyteyb/GHVs6fYZxXiq3/HZ4a5to+A+qpaEAtmmifrrfUQK3r4LRIXp6Xcr2XNRBLtg2J0yFBUTiCoTd9SuBIrl3A0sc9q/CDwDhHPxRHA/tg++UspJFRSFmuLSGeVXaso3I94TEBvKkxxWGWWHh8kbecM+Zn+l/lqG3BUk0pR7JuBA

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 17.06.26 16:20, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> Some scheduling classes may need a way to perform specific
>> fixup/accounting work for a thread which is being scheduled out.  We
>> cannot rely on the sched_pick() handler for this since the first one
>> to successfully pick a thread prevents other handlers down the class
>> hierarchy to run.
>> 
>> To address this issue, we introduce the sched_out() handler which is
>> called for the current thread when scheduled out. This handler is
>> invoked unconditionally when present prior to picking a new thread.
>> 
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>  include/evl/sched.h     |  1 +
>>  kernel/evl/sched/core.c | 20 +++++++++++++-------
>>  2 files changed, 14 insertions(+), 7 deletions(-)
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
>>  	void (*sched_yield)(struct evl_thread *thread);
>>  	void (*sched_migrate)(struct evl_thread *thread,
>>  			      struct evl_rq *rq);
>> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
>> index d1d025e06a5d..7127d4e52df9 100644
>> --- a/kernel/evl/sched/core.c
>> +++ b/kernel/evl/sched/core.c
>> @@ -773,7 +773,8 @@ static inline void set_next_running(struct evl_rq *rq,
>>  		evl_stop_timer(&rq->rrbtimer);
>>  }
>>  
>> -static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
>> +static __always_inline struct evl_thread *
>> +__pick_next_thread(struct evl_rq *rq)
>>  {
>>  	struct evl_sched_class *sched_class;
>>  	struct evl_thread *curr = rq->curr;
>> @@ -821,8 +822,14 @@ static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
>>  /* rq->curr->lock + rq->lock held, hard irqs off. */
>>  static struct evl_thread *pick_next_thread(struct evl_rq *rq)
>>  {
>> -	struct evl_thread *next = __pick_next_thread(rq);
>> +	struct evl_thread *next, *prev = rq->curr;
>> +	struct evl_sched_class *prev_class = prev->sched_class;
>>  
>> +	if (prev_class->sched_out)
>> +		prev_class->sched_out(prev);
>> +
>> +	next = __pick_next_thread(rq);
>> +	trace_evl_pick_thread(next);
>>  	set_next_running(rq, next);
>>  
>>  	return next;
>> @@ -972,21 +979,20 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>  		return;
>>  	}
>>  
>> +	prev = curr;
>>  	next = pick_next_thread(this_rq);
>> -	trace_evl_pick_thread(next);
>> -	if (next == curr) {
>> -		if (unlikely(next->state & EVL_T_ROOT)) {
>> +	if (next == prev) {
>> +		if (unlikely(prev->state & EVL_T_ROOT)) {
>>  			if (this_rq->local_flags & RQ_TPROXY)
>>  				evl_notify_proxy_tick(this_rq);
>>  			if (this_rq->local_flags & RQ_TDEFER)
>>  				evl_program_local_tick(&evl_mono_clock);
>>  		}
>>  		raw_spin_unlock(&this_rq->lock);
>> -		raw_spin_unlock_irqrestore(&curr->lock, flags);
>> +		raw_spin_unlock_irqrestore(&prev->lock, flags);
>>  		return;
>>  	}
>> - 
>> -	prev = curr;
>
> This hunk subtly look like a pure cosmetic change, without any logical
> impact. If it does have one which I missed, it should be explained in
> the commit message at least.
>

It has none, as mentioned earlier in a previous post. The point of this
change is to clarify the naming, introducing 'prev' as an alias to
'curr' in the swap sequence. So there is no point in documenting this.

-- 
Philippe.
