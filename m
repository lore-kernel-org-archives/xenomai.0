Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848602AD37
	for <xenomai@lists.linux.dev>; Sat,  5 Sep 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599807; cv=none; b=M4Z4b+9Gh4aBXtdpK0Xdp+I33ktgQnn2xIsfbTzfzwCSQHR5Grp3HGP8mKMxcxA1kwrO2ZdYFU0TgKlvA3n3aDVWMipesezOpGUYmugooZ1Q3u5a2aRHHAgf1eEzjjr79VrDh6+OCYxzu0BDW6ssFswaBuEPhIlOOuiZZurJkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599807; c=relaxed/simple;
	bh=Y04OuOJfQJFexs8oFvyVaBhWsOcdp1XutLjbJ5GQMrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DHReSIVYrdVRkJ/Tb3K/AS+u3NOOo9ADVwa47Krqtg+0pvP8d8Dna0acdzavMk7Dil9QwpXislvEP+lc/5jgqUlq/kGsoGygrqqoq0cJRoSTkZ8QyL4dzjk9OK7ezJybvgZ1WJ7jGu2K7qNBJfwKOTdP4Y03EY22ubjIqTTjvJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=HCKzkYPi; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="HCKzkYPi"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0ACCA3EBE0;
	Sat,  5 Sep 2026 09:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788599796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DEDr+9AvVlVrf2qv7i0VFaSnPhk3KXM3pMZh3nigAZo=;
	b=HCKzkYPipSBwurg5ksMgnpYi+yKuGaKSwCkqmjYA6f8kA76o61Y5zrKxCy+N0dvLwwze22
	0MjlRPa0sc8Koqu8uqChzbINtFUcGWLgsTtZBEccpbXUo46NNaXvhhU3fudSfqR766WJf7
	5SlTK26llNuklfbFvNxQGWJtNUL/UsI62237vMDL8sX6dPlWuch604x12YE1m78K9LZdfE
	Z37j5xCDGk0akGtWQk4SLBbLj0cKHTrdm5R3U6WWYN9pBiEDJbY04x34RxaoYV0UmHd9UX
	bweRrD2m+Qf5eP7YSNg/HEgIfA7YfeYAS8yKlzGCFshi7mA3EVTMwv0WSvtx9Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew MacPherson <andrew@elk.audio>,  xenomai@lists.linux.dev
Subject: Re: perf getting all-zeroes IP on STM32MP1
In-Reply-To: <e729ab55695799eac6eadd30078b72169d932219.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 04 Sep 2026 17:55:29 +0200")
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
	<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
	<87wlt1cafu.fsf@xenomai.org>
	<e729ab55695799eac6eadd30078b72169d932219.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 05 Sep 2026 11:16:34 +0200
Message-ID: <87bjacoy6l.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFgU9OvriaTXQEJeDiRq/Ka1Emoy19Y3Ja5zy4GdZ7Wmjkv4/BNLm3m5JnVOX6Q2nQskK+uK/qPyRyZZCC9Slxpe2V4L7OeTLs7RaHgIzet0Yh8KNgK97rSU13XDZ5cUILpJnRc1gXFP7vH+NmvbDSum4JWYHl/stagDph6NcbCPupFN5mP59f7k5PU78DvY2b2Mh2DwBfFCvy4yeqi5h3oPZdovf5uZU55M3HuxPSq1e4oTqgrLeC7V3PJ5qnyZQnUZnmnJ9S2gc7GPPKWEsMYdsnCF5tjvCpWq3cwCpFN1IUn95AIrPppEGNMHpNSsoI+3zcKhydbG0zlIEDZWqDrk7PbL6prfEDtYytjTBoGlo1kSS0SumtaJDRguJDRoEEOlxj6gmA0kgt5ICPRacxXC/faP9zE5B3OI97TBWz7Gwx5Bw4lKSHsKPxGX3z7867Z8ZDdYu3ms2LEIwYyVRgaok+SY7YdUoku3sFK8nM3P/gvm/p6kW7ecO/DZEHQLb2C8jqfx2Z8N93SIPb19rWlB+mo/XEOtyqmrdhMVA71ucjd8GSt0zKmeW0OJGehS+AtNInAEI16kB6qs8bWLnFfQ9U+x5JGTozSy1CorziKXdYFPuuLb7y+4sHcE2Io9Fngh8/T7pFQg/pfYJxk58/Uc7RgSKA9mCR5+zmj/mukyg

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Fri, 2026-09-04 at 17:17 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > Hi Andrew,
>> > 
>> > [CC + Philippe]
>> > 
>> > On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
>> > > Hello,
>> > > 
>> > > We're working on an STM32MP1-based system running Xenomai and found
>> > > that perf top shows every symbol as "unknown [00000000]", i.e.
>> > > profiling is collecting samples, but they all point at address zero.
>> > > 
>> > > I'm not a kernel developer but went through a few debug kernel builds
>> > > with an agent which eventually led to the attached patch. This change
>> > > does resolve the issue with perf, however I'm not sure if it's the
>> > > correct solution.
>> > > 
>> > > The reasoning is that arm_arch_timer.c's percpu IRQ registration never
>> > > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
>> > > tick_regs, leaving get_irq_regs() to always return an all-zero
>> > > pt_regs, which in turn breaks perf's sample IP.
>> > 
>> > Yep, that is wrong. The patch you provided looks OK to me. I'm just
>> > wondering if that should be addressed in Linux as well / first.
>> > 
>> 
>> In fact, Dovetail is somewhat abusing IRQF_TIMER in that the only bit in
>> that mask we should care about is __IRQF_TIMER, which is only used for
>> recovering from misrouted IRQs these days, specifically excluding some
>> descriptors from the polling loop which tries to find a proper
>> handler. Problem is that we also carry the no-suspend semantics attached
>> to this mask when using it, which is not what we mean.
>> 
>> I think that the mainline code simply acknowledges the fact that per-CPU
>> interrupt handlers should never be polled for solving a misrouted IRQ
>> issue by definition, so there is no point in tagging those lines with
>> __IRQ_TIMER in the first place, which applies to the architected timer
>> interrupt as well. IIRC, that was the point of the recent set of
>> upstream changes to request_percpu_irq(), dropping those flags. Such
>> change prompted us to put back a secondary interface accepting flags so
>> that we can keep on passing IRQF_TIMER.
>> 
>> > @Philippe: Any additional thoughts? Should we take it already?
>> > 
>> 
>> I believe that we should not live much longer with this hack, we should
>> provide a dedicated IRQF_* flag introduced by Dovetail instead that
>> would specifically say "this line generates deferred tick events" or
>> something along these lines.
>> 
>> 
>
> Would the qualify as starting point? We would have to identify all the
> dovetail specific IRQF_TIMER usages, but that should be doable:
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 61a1e33cb2ca3..8258fbaf54a2d 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -76,6 +76,8 @@
>   *            handler any time interrupts are enabled in the CPU,
>   *            regardless of the (virtualized) interrupt state
>   *            maintained by local_irq_save/disable().
> + * IRQF_TIMER_DEFERRED - Dovetail: The interrupt line generates deferred
> + *                       tick events
>   */
>  #define IRQF_SHARED		0x00000080
>  #define IRQF_PROBE_SHARED	0x00000100
> @@ -93,6 +95,7 @@
>  #define IRQF_NO_DEBUG		0x00100000
>  #define IRQF_COND_ONESHOT	0x00200000
>  #define IRQF_OOB		0x00400000
> +#define IRQF_TIMER_DEFERRED	0x00800000
>  
>  #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
>  
> diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
> index de401973c6230..31fd2fc70f74d 100644
> --- a/kernel/irq/pipeline.c
> +++ b/kernel/irq/pipeline.c
> @@ -1065,7 +1065,8 @@ void copy_timer_regs(struct irq_desc *desc, struct pt_regs *regs)
>  {
>  	struct irq_pipeline_data *p;
>  
> -	if (desc->action == NULL || !(desc->action->flags & __IRQF_TIMER))
> +	if (desc->action == NULL ||
> +	    !(desc->action->flags & IRQF_TIMER_DEFERRED))
>  		return;
>  	/*
>  	 * Given our deferred dispatching model for regular IRQs, we

This is indeed what I meant.

However, on second thought, there may be another way based on Dovetail's
tick proxy infrastructure. Given that we are only interested in saving a
portion of the active register file when receiving a clock tick that
might be deferred, we could leverage the routine every oob-capable tick
interrupt handler must call in order to fire the associated clock event
handler: i.e.  clockevents_handle_event().

IOW, instead of marking the interrupt line as a provider of timer ticks,
could we just tell the single piece of code dispatching those ticks to
save the few regs we'd need later on if the event is going to be
deferred?

This idea needs more thought to implement it right, but this would save
us from having to amend every call site which mentions IRQF_TIMER for
that purpose.

-- 
Philippe.
