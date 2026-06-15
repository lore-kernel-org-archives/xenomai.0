Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049230D3FC
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506513; cv=none; b=Bnfnbao6SGSFnv3hUrvPbDnL5KXZqLGPxpdBYb0VYVUhvY0O4AUy5weQ+A6dfHGMpmvhqqo9qGfvF/Qvh6IwhdFwctlGqQ1IJ2I7QwLWBvdOy8Rpc9n/L714lTxXUEcZC2b3+NqMszKkckw71z/Q//p/5GoBS9QMR+X7clsFGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506513; c=relaxed/simple;
	bh=bl8IqR2/r1sg3/gdW689W+1mLqFriX7FPk5qcq5HgQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HJb0dCoMPpUTYbsgvZdFodwpSgAgDPUKRqk7R2Jl/DHednch7iaWLnY8iYomcBuaYhynZANzXCSgP/bNanixjrCAB/KGDdxbYA+srfsAEz7IhHkeNHDvpzEnh9y6C7JqMxtcGnGKfL0CB5LKjTIp8YZmeQWs1OrSyqo4bqPmaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=hr2rgsM8; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="hr2rgsM8"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 86582580A3E
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 06:28:14 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA43241B8C;
	Mon, 15 Jun 2026 06:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781504887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNDhPpY5JloBcaU3QEygVlTRxlhOq2AJKRWkysDXC90=;
	b=hr2rgsM87DTsWlNP/8cf6jPx810eZTNudblA4V54Cadm8oXHpP60S00At5eZxbqE0rH/EI
	vuUbjmBlmFRhId3cVcW0xalRtfG7Lt8La64k1An3GhGgSfsoL8BnyG6PsbuUi+baDQhTXE
	Sb5nHavXMoZuhW/UGL5e8nhHdBMQmADDykVbkBfrRape9Ui0Hd+jvS3A9Pn+NPgPYhMqou
	U2zxTqfc2ds2JdmAZ+a7TKqNp+qucXtskT6M0FLTIKoN3niEIw3oKYf2qziKK1n7SsJEqB
	eJ9fqLRUPuu2hg70gsc8HAnpQxlNFKYwzp85mK0+YOgaqlPNzBqXcEhiR/apuw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
In-Reply-To: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com> (Jan Kiszka's
	message of "Sun, 14 Jun 2026 21:35:28 +0200")
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 15 Jun 2026 08:28:02 +0200
Message-ID: <87ldcgiah9.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGIBr+0FGSJBD0ShzdGfCadGMkovMXNCA9yqjbXrLCWuizW0fmAv0u2nNxibk7CFBU2LcQtes9qhM1YGlBzUkkczgaqE000wl9Zd6axV4SZXqh8ur66H0QExb4ezQ0eBG4HmoGWuDyHwoJlSl+/qvDg23j7faj/hF3HONqPatPHpLX5ESn1V9arPNlUOMUoaFn8uxhcvy5N3rN5NC7ujxRj1v38kHl+95A+PYUrwpvCZwwlrWQntDD8nvjAx9RK1AupxzHbOr6BGZ+XYURCnAraFyMKrDcXJiWWt5dso8n7iGoe9mfk2V+GKvvpz6yZqOE94SKbK/sGKLBeW73RYaosM7sF8ayZjCvTQHTDy4xofCLf/xyRrwhuoKSHHVq30YtCqD6u6c31kU2YsUzq5hx/ZzUmvCV49Z7EpgimbnCC/yB47VaGQvAokutGpu4Ll56KsLaf8O3srbMNxwWMgS273IdYzVryJUo6LinjoA/me7GRXz3VbIG+NrpSHDd1Ru2LvQodykHc4wQlwfril44onll1e/5+rMsGW2WlbVnqH4D2C21kCUOhQd7PoIwIY1ZrzI7LCaoOQ3l00SBM8MC6kK7yY08JR5Q7tykEcktMO6dR7uTdn0hc5UNZmuLzwCT0L7kbg0LuEoz8PYLAoQJ1JEHEJKwePZx3HzIMTNiVYw

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This shall be invoked before a thread switch, providing both the current
> and the next thread as arguments. Some scheduling classes may need it to
> correctly handle their state as the sched_pick may not be invoked when a
> higher-weighted class is providing the next thread.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/evl/sched.h     | 2 ++
>  kernel/evl/sched/core.c | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/include/evl/sched.h b/include/evl/sched.h
> index ae9690860146c..0b16f1b1cf626 100644
> --- a/include/evl/sched.h
> +++ b/include/evl/sched.h
> @@ -120,6 +120,8 @@ struct evl_sched_class {
>  	void (*sched_dequeue)(struct evl_thread *thread);
>  	void (*sched_requeue)(struct evl_thread *thread);
>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
> +	void (*sched_out)(struct evl_thread *thread,
> +			  struct evl_thread *next);
>  	void (*sched_yield)(struct evl_thread *thread);
>  	void (*sched_migrate)(struct evl_thread *thread,
>  			      struct evl_rq *rq);
> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
> index eb133e334d30f..0d49fc16bd67e 100644
> --- a/kernel/evl/sched/core.c
> +++ b/kernel/evl/sched/core.c
> @@ -910,6 +910,7 @@ static __always_inline bool test_resched(struct evl_rq *this_rq)
>   */
>  void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>  {
> +	struct evl_sched_class *prev_schedclass;
>  	struct evl_rq *this_rq = this_evl_rq();
>  	struct evl_thread *prev, *next, *curr;
>  	bool leaving_inband, inband_tail;
> @@ -990,6 +991,10 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>  	this_rq->curr = next;
>  	leaving_inband = false;
>  
> +	prev_schedclass = prev->sched_class;
> +	if (prev_schedclass->sched_out)
> +		prev_schedclass->sched_out(prev, next);
> +
>  	/*
>  	 * Careful: we _must_ have updated this_rq->curr before
>  	 * performing the rest of the context switch code

I've been working on this lately too. It turns out that we need more
than this, although this is definitely part of the solution. I'll follow
up on this issue.

-- 
Philippe.
