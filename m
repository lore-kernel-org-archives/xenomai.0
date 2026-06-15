Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4353D1713
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513224; cv=none; b=HR7jnJAbREy2R9IjanRA+EoGt7LyESCoj2P2aAeVTqtLcfEPmLHZrJOFk40NDJPgjJJReNBckwO+lO/whCKJypoEQnrTpLjuFkGbCaddbTZNWxA1XBKhcjUtxlApmvx1Dh0H8uaEu5Ojmg3GvJ+Yc8DjfDPboPIqKEbgNLsmOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513224; c=relaxed/simple;
	bh=39SN0zN8PvLEsnnRqoXuXpz9hUwc2DNfLn3zUaIilek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=obdCpr+1yXv1DFSWL08H+2f96x2Qvxl3oiMVpESnEcLlyHpEYDQuGaCxanTGZTREb/YhxXv3kuEsuQeOZo2Olwtnzau0WqR/b6emeeDwpDRKFw+d6Wl2pRAoKOTOv3e5PtiJq0KkQbgft5Lt/axecxPmMHvcxdXQyhMAR9UcJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Ei/Y+ZTr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Ei/Y+ZTr"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78F7D3EBB3;
	Mon, 15 Jun 2026 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781513220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TyHWLEwoy58eTXngF6rZJzVzvcc61YaNz5YrgW8YpsI=;
	b=Ei/Y+ZTrpvqRUkQpY/11RUiChZ5GDdhG3pS1hybmjxlpj3oybVe8eBMnf7ge5fnt1e/gtE
	ABoOhLkdcebcH/EGY4HXYCasAh+lpBMJVqNTti1URI5UGFu8X+7sMVh16DjP3Km5O4dfGV
	90ryKgARG3WiAagKFxpK3GpENDTpJTwXjPp4fP7qKRTaSNav0MW7T0pcQuq0E8MnErAJ6w
	JeQLGJ3gK88ervVZsF8WgXr/HOD8h/e1Ztjhxi6A02C12pFPMFwK98JMzZpatOREhAzQGf
	xO5NjZAp9+P7hry3rEdQbCL2V09yLm0atPOSW9BcCGPClIgSBIdOADdGSnQ/6w==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH 2/2] evl/sched/quota: Correct budget tracking for
 preempted threads
In-Reply-To: <5e63aec5-e782-4936-a526-c2fffbbc9635@siemens.com> (Jan Kiszka's
	message of "Sun, 14 Jun 2026 21:35:55 +0200")
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
	<5e63aec5-e782-4936-a526-c2fffbbc9635@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 15 Jun 2026 10:47:00 +0200
Message-ID: <87ik7kfawr.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTE8tySOcDkuSbY6EESIHCRi9XZZjLGInR/W7kPeab6u/LKD3xKttI/0y+28Efkzs1XhO33YFn2+lVZffR2pRBdUEJxYqga3v5M3u/xnBebDb47obu4DUMSZ5MUqPPCVln5L+NbouRpHe6CUgg3uTAsHOK38Rt6wQEcMbDhD2z4aPi74RAYKs8yOl/IB+H6pqf8ZQOTEW/0R8obTxRRUDQj88/S/eJUYBZce9nAYHCZQshlnoY3zFRk4kKvO00dt5qUtEDMVAAnElrosbgTgP04egb0mG1ZZIdga9kOoBHCeO4JDUUV8Iy30vcWUrYQNl+tn2CKa90FA5Maigb7YO4vTSOzVeab0r0xZmz3a3eRYnmifiJV8gW0YpY8HI0kJlqfcNoSO3YEJiRplZoEtuyrbCMVXJbE6jF/tJYziSn23WgJoUQ4tiAyo+Vo+QTycgmbhrnPZGGmU6MXb0/kcj3IpKSHez/LJFRoFeScwrw+H/Hz5KMzSf8IYsla/Y7nB9YQkO1eK7UP98eIEblMGta6uuTNL24m7wCQgUlAZ9lRBWVCukLJ0yiN6+8uDAppxhvT80CjdNRQZnmgiEmx5jaZtX3DjJKMILXuOdHL0m17Is30d0DYRmKHSqyL5fTXuw2Gm867/l+py5EIBlWfxCRsNb/trJwj+bfzJnacTwT6hLA

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This was so far not possible due to a missing sched_class callback,
> causing threads being credited for the preemption time of threads from
> higher-weighted classes.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/evl/sched/quota.c | 56 +++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/evl/sched/quota.c b/kernel/evl/sched/quota.c
> index 0829da711a66a..d331dc2e8f7ac 100644
> --- a/kernel/evl/sched/quota.c
> +++ b/kernel/evl/sched/quota.c
> @@ -187,11 +187,28 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
>  	raw_spin_unlock(&rq->lock);
>  }
>  
> +static void charge_usage(struct evl_quota_group *tg, ktime_t now)
> +{
> +	ktime_t elapsed;
> +
> +	elapsed =  ktime_sub(now, tg->run_start);
> +	if (elapsed < tg->run_budget)
> +		tg->run_budget = ktime_sub(tg->run_budget, elapsed);
> +	else
> +		tg->run_budget = 0;
> +}
> +
>  static void quota_limit_handler(struct evl_timer *timer) /* oob stage stalled */
>  {
> +	struct evl_quota_group *tg;
>  	struct evl_rq *rq;
>  
>  	rq = container_of(timer, struct evl_rq, quota.limit_timer);
> +
> +	tg = rq->curr->quota;
> +	if (tg)
> +		charge_usage(tg, evl_ktime_monotonic());
> +
>  	/*
>  	 * Force a rescheduling on the return path of the current
>  	 * interrupt, so that the budget is re-evaluated for the
> @@ -253,6 +270,8 @@ static bool quota_setparam(struct evl_thread *thread,
>  			/* Dequeued earlier by our caller. */
>  			list_del(&thread->quota_next);
>  			thread->quota->nr_threads--;
> +		} else if (thread == evl_current()) {
> +			tg->run_start = evl_ktime_monotonic();
>  		}
>  		thread->quota = tg;
>  		list_add(&thread->quota_next, &tg->members);
> @@ -400,21 +419,11 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>  	struct evl_thread *next, *curr = rq->curr;
>  	struct evl_sched_quota *qs = &rq->quota;
>  	struct evl_quota_group *otg, *tg;
> -	ktime_t now, elapsed;
> +	ktime_t now;
>  
>  	now = evl_ktime_monotonic();
>  	otg = curr->quota;
> -	if (otg == NULL)
> -		goto pick;
> -	/*
> -	 * Charge the time consumed by the outgoing thread to the
> -	 * group it belongs to.
> -	 */
> -	elapsed = ktime_sub(now, otg->run_start);
> -	if (elapsed < otg->run_budget)
> -		otg->run_budget = ktime_sub(otg->run_budget, elapsed);
> -	else
> -		otg->run_budget = 0;
> +
>  pick:
>  	next = evl_get_schedq(&rq->fifo.runnable);
>  	if (next == NULL) {
> @@ -430,8 +439,6 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>  	if (tg == NULL)
>  		return next;
>  
> -	tg->run_start = now;
> -
>  	/*
>  	 * Don't consider budget if kicked, we have to allow this
>  	 * thread to run until it eventually switches to in-band
> @@ -448,9 +455,12 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>  		goto pick;
>  	}
>  
> -	if (otg == tg && evl_timer_is_running(&qs->limit_timer))
> +	if (otg != tg) {
> +		tg->run_start = now;
> +	} else if (evl_timer_is_running(&qs->limit_timer)) {
>  		/* Same group, leave the running timer untouched. */
>  		goto out;
> +	}
>  
>  	/* Arm limit timer for the new running group. */
>  	evl_start_timer(&qs->limit_timer,
> @@ -462,6 +472,21 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>  	return next;
>  }
>  
> +static void quota_out(struct evl_thread *thread, struct evl_thread *next)
> +{
> +	struct evl_quota_group *otg = thread->quota;
> +	struct evl_quota_group *ntg = next->quota;
> +	ktime_t now;
> +
> +	if (otg && otg != ntg) {

otg can't be NULL by construction since quota_out() is called for thread->sched_class.

-- 
Philippe.
