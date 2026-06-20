Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E62D0C7B
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968436; cv=none; b=WOtyL17i2k3MTS1/DXoffwklAtbG6CIjzb8OVh6d0PvPRehFSD6WYuL1PisDB9B9//ykZxeriUEfsEh4BUzeXAKcpkhJtxc+xKlxz69tLfiAluFlhWtZlNnjZafiGhB5bhQPeUBojAuhLbA+ZVb7HMF+Uuz2mjzYcAkVt5XQ3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968436; c=relaxed/simple;
	bh=Kjd9AcMD3M/TP6800gxLMdHxjP5nCS3m0TXL1c+4H4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=olHQSzQh7BOL0TgGDhNuT6Y3nqxMpa30WnmV1k+B0ESPB9l/c4jUH3owxa0wsk/F/M0Q0pIGY324GQ4nzq3J33nZ4ITRn675+VYOKjXjl9rH/qiZDOqfSqdse1EaIIdlAc7SqTnYDAFi03sMDnVQ3HlMSHr5Hgy8pCWYeNiSyls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ogQ8bOjp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ogQ8bOjp"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92AB93F49B;
	Sat, 20 Jun 2026 15:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781968432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C3O5kRX8rNwbP85Umt8bUU0plJ82DHZ/9HuwxavH0wQ=;
	b=ogQ8bOjpOYBH0+WcvXzi9PKU+g8adqKHxiobVZjf94SsVI3WgvBVIsA3zylbj9MSxlmkYW
	cxfatX2htBc+mvTboANh7qojcm5YSPJoqmwdtrzwi18Eo9U4KcJPpavuy7chTmahsjL6P9
	sR4LncmfQ5DwA4MQgN9/gxC+XKXGpUf1aJVL5cJsrDMilv19gjOezcBqMvBvo8BhnX8WXv
	eVyIequB1LIA6ROydGNk/1UnyCHBs25VJ/PX0z6V4rkn/qpZ+hwVIyOiNlLuZOEDfvmZZ+
	AYrR6azWNA9QE/h0hUAVSbY9tRz0Qqt8Gf8DgpcsVbPv82CRlZM4Wy6ecJbkwA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
In-Reply-To: <87wlw0cef9.fsf@xenomai.org> (Philippe Gerum's message of "Mon,
	15 Jun 2026 11:59:22 +0200")
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
	<87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
	<4797a713-e16f-4792-ab7a-51a2876fb6ef@siemens.com>
	<87wlw0cef9.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 20 Jun 2026 17:13:52 +0200
Message-ID: <87wlvt8csv.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTERk/t5qH6SQAVqbtwtnMF0G0P2VwrlThIdGrPtxkmcpDnGtnQate7kRaFh13CqCy8iXjH02DE8/iMAt/TfkBoShap0hY2q79E5Bqa4mBeOd/wCLw+4pHyTwJM3KnBJj8y5Zpo7XveHqjnBOMeIf4JFQ1HyLTdFN9gqkW71KYPgUIWpZkncpPlPN9+cVu+rFz0Qqpa/jpsQYeuc6EeQb/GNd7ru4ISoSPZ1Q3wH2Oz9lcRa6Llh3tqY0Bjo0GUrqEc9In0Hmx+cszr626VehyfQFCU3lOncfAQCcRNYv260WPRtIW7WXovoRAeXxntqRqokbzbXUnIS2d3Cxh0yp2YmHMQXMvRxRXvq4L7LRV2K8fsDBbDcjo7r8qXKJZLMHvmzXCI4Oxff2dfOIcNFJ1DUDdU184t2j0D2GQRcMYmMb6vhUXCCSBADPnG3BxLSkj0R+wEXIMv1fvjkffN6FzvjNcncaVkYsiw5kNDq0jwT09iDKxbv6HKacRtvYLXiUmH20LUr7bbhukmm2ua4Lxlwx2kT4KgbAAS4evlUTmv9MtaHNqi2XQ0r77sd515siRChEePnBtBU6cB/0XIlcyaNbwTDQqg7hLkiZSw6DFS28NPII0DYCgsF46gwIeXuTwOoM5DRU2P7k5ipNC0iYAqVYYyQCvxgTKNhcXLASUwUPA

Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> On 15.06.26 08:42, Philippe Gerum wrote:
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>> 
>>
>> You also need to update tg->run_start. Otherwise, you will overcharge
>> the next time this group is checked here.
>>
>
> Yes, this needs fixing.
>
>>> +	} else {
>>> +		tg->run_budget = 0;
>>> +		evl_stop_timer(&qs->limit_timer);
>>> +	}
>>> +}
>>> +
>>> +static struct evl_thread *quota_pick(struct evl_rq *rq)
>>> +{
>>> +	struct evl_thread *next, *curr = rq->curr;
>>> +	struct evl_sched_quota *qs = &rq->quota;
>>> +	struct evl_quota_group *tg;
>>> +
>>>  pick:
>>> -	next = evl_get_schedq(&rq->fifo.runnable);
>>> +	next = evl_get_schedq(&qs->runnable);
>>>  	if (next == NULL) {
>>>  		evl_stop_timer(&qs->limit_timer);
>>>  		return NULL;
>>>  	}
>>>  
>>> -	/*
>>> -	 * As we basically piggyback on the SCHED_FIFO runqueue, make
>>> -	 * sure to detect non-quota threads.
>>> -	 */
>>>  	tg = next->quota;
>>> -	if (tg == NULL)
>>> -		return next;
>>> -
>>> -	tg->run_start = now;
>>> +	tg->nr_active--;
>>>  
>>>  	/*
>>>  	 * Don't consider budget if kicked, we have to allow this
>>> @@ -439,25 +437,29 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>>>  	 */
>>>  	if (next->info & EVL_T_KICKED) {
>>>  		evl_stop_timer(&qs->limit_timer);
>>> -		goto out;
>>> +		return next;
>>>  	}
>>>  
>>> +	/*
>>> +	 * __pick_next_thread() might have requeued the current
>>> +	 * thread which is still leading the pack.
>>> +	 */
>>> +	if (curr == next)
>>> +		return next;
>>> +
>>>  	if (ktime_to_ns(tg->run_budget) == 0) {
>>> -		/* Flush expired group members as we go. */
>>> +		/* Park expired group members as we go. */
>>>  		list_add_tail(&next->quota_expired, &tg->expired);
>>>  		goto pick;
>>>  	}
>>>  
>>> -	if (otg == tg && evl_timer_is_running(&qs->limit_timer))
>>> -		/* Same group, leave the running timer untouched. */
>>> -		goto out;
>>> -
>>> -	/* Arm limit timer for the new running group. */
>>> -	evl_start_timer(&qs->limit_timer,
>>> -			ktime_add(now, tg->run_budget),
>>> -			EVL_INFINITE);
>>> -out:
>>> -	tg->nr_active--;
>>> +	/* Arm new limit timer on change of running group. */
>>> +	if (curr->quota != tg || !evl_timer_is_running(&qs->limit_timer)) {
>>> +		tg->run_start = evl_ktime_monotonic();
>>> +		evl_start_timer(&qs->limit_timer,
>>> +				ktime_add(tg->run_start, tg->run_budget),
>>> +				EVL_INFINITE);
>>> +	}
>>
>> I still don't fully get how the limit timer should be started on
>> setparam over the current thread. Will curr be NULL in that case, thus
>> curr != next? Is that the reason to go for a separate runqueue?
>>
>
> Nope, that one is only to make things clearer, since there is no upside
> in sharing the runqueues (this was inherited from SCHED_SPORADIC for no
> obvious reason with hindsight).

There was an obvious reason for the quota thread to piggyback off the
fifo runqueue though, i.e. the ability for quota threads to compete for
CPU with fifo threads. Moving the former to their own runqueue, with
SCHED_QUOTA having a lower scheduler weight than SCHED_FIFO, the latter
would always preempt, regardless of the fixed priority.

e.g. we would have the following sequence with the current
implementation (provided T2 still has budget):

[SCHED_FIFO] T1(fifo:3) => T2(quota:2) => T3(fifo:1) 

and that one with the split runqueues:

[SCHED_FIFO]  T1(fifo:3) => => T3(fifo:1)
    |
    v
[SCHED_QUOTA] T2(quota:2)

Which is way different from the current implementation.

> At some point, I noticed that it would
> even have introduced a bug in a previous tentative implementation using
> sched_class as a discriminator between threads, to figure out whether we
> should call the sched_out() handler. So, the simpler, the better:
> distinct classes, distinct runqueues.
>

I'm going to revert to piggyback mode for v3 since this is how it is
supposed to work.

-- 
Philippe.
