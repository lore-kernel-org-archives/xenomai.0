Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E753CA499
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855410; cv=none; b=e9aldTn9/Ya7SzZ6Dbo3MPZBQm9fwuv3QCwf0p1kRIiLyvSZt2rP41BvJQHDxzaW2XwzLVBihYebmfM23S0loZ+GADgJ0FuqFTk1lps7f+05FtnfvjBQiuDeDslcDn7hwXXyuDWVukwwUJQ027LeO7EfYRiTqakqdhbEiZberkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855410; c=relaxed/simple;
	bh=wN52yd1EQ+V3TEajt1+92IYvfl5DsJqAR2tRNdkpBuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ARaz+Hl5P0NmM5j7DDltlTwrJsqyN2wcAbF1sBIipPCvKbB5821CjjGK9U8zt7WZV2C6Gqgj/nW7V+TimiLMY2hVYoWk/Czrnqx35UCKRQ4QiFN000t6elKkqRv1HneUSuafxtMj5lxuQkW9OnUIha3iSJ3csDXqLXCb+q8xcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=kJTYSFGO; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="kJTYSFGO"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2B583EB9A;
	Tue,  8 Sep 2026 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788855405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFGjsupUPAHEJTRoD5lohIyVxK7Kj7UF/tFzsIFdxR4=;
	b=kJTYSFGONSD1hEO5aQADmpjmKSqmSZK66fpGTBNZ0RWlRityqBcPDKblbNoWcjTOVfZtxo
	tZKGFUgnVtouAoZCVDJvNoOdiXNJUN8fPAQur1tp9VgejIejsZ5qtTjJ9qe/nVXfIj9pw7
	WuQLw9Vgp1d5Zt0LXCNtVOTLFQXHcSixVNx79or32ACDP3kqnHqKQHAPeIsWA2ON+cDVOE
	3SJ7i30laXNNmHxaj15j1Qkv/iloB1t/2B+qAcl0LaiISvMbU6ZNBuwLHwawZxBdhxijUr
	migLsXSrrXKTqo+rhyP4TNPRiRznT5tJTNcTPrqvyQnjkj9hLMIYmPNbhzYiJQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew MacPherson <andrew@elk.audio>,  xenomai@lists.linux.dev,  Gerte
 Hoogewerf <ghoogewerf@lmi3d.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
In-Reply-To: <396c6e2bee432007d4878f092ed353f3034a2287.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 08 Sep 2026 10:02:02 +0200")
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
	<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
	<CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
	<dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
	<87cxupgrnp.fsf@xenomai.org>
	<a14e0d0f9ec97f6064a1b2fb221f3ee5015e2241.camel@siemens.com>
	<877bkxgl7k.fsf@xenomai.org>
	<396c6e2bee432007d4878f092ed353f3034a2287.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 08 Sep 2026 10:16:44 +0200
Message-ID: <87pkyoduoj.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTENTgPV6pxO3ibQ4O2hP6sj04Gkba3ci8gvAMo6PFBYM3YromxkkLyJQdjpXHIyV9JmxoONkDtT32zbeu3ap0zVnPpXMRIh2CcVceShT4vbApLORoSTXvRxJ0/rysKF3zKk0guqBdnwP5CEZWh6uYe72Jro0yAH+AcnGVgOoHAGrqd+ONINpEQsV7PGympCBcygB3hxPBxb+Kx+ekju1UEbYeCjleZorTkJoP80MfhFsWlzcq1xIx+wKY4Pc4JGvPKbwVqx/rudnHqHcnps1+zZTvhktFyNQeV46aUqGIC5FWxqHDyDCBHkMWPNC1iijT2b1aMMDZ/C6MuCW9eimm52NDAOVuclHZM1682cj5dijNT1YJI7hUPbrhrGlNM5q/P/VGnzSW884UWLCLwTQdbyctHgblkUnGvsNx2lqD41C8ang7v3VxhoEMAPAu73osRg3Ed7DrP73Qnzl0FaO1pOduFSWLaaYXiau8frUYgDZAY6ZtzEjHWxc6bQYX3JE59AhQV/gSWplnOjsvplElv7MIpbhsojdl0Yjvgg6/g7XVcOnUKIaopwhT6z6u46Bj5w4ML33oK0vhDjXsyuqYS7F6jK6l05NM+wF12+IHYYJ0kE9RWhhXAFcd+0aPOT0fQZALea7DcJ34qbcBfTWw1MFE9V9Vu6e5B/Mp8Tdd5OgQ

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2026-09-07 at 17:00 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > On Mon, 2026-09-07 at 14:41 +0200, Philippe Gerum wrote:
>> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > > 
>> > > > On Mon, 2026-09-07 at 10:57 +0200, Andrew MacPherson wrote:
>> > > > > On Fri, 4 Sept 2026 at 16:08, Florian Bezdeka
>> > > > > <florian.bezdeka@siemens.com> wrote:
>> > > > > > 
>> > > > > > Hi Andrew,
>> > > > > > 
>> > > > > > [CC + Philippe]
>> > > > > > 
>> > > > > > On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
>> > > > > > > Hello,
>> > > > > > > 
>> > > > > > > We're working on an STM32MP1-based system running Xenomai and found
>> > > > > > > that perf top shows every symbol as "unknown [00000000]", i.e.
>> > > > > > > profiling is collecting samples, but they all point at address zero.
>> > > > > > > 
>> > > > > > > I'm not a kernel developer but went through a few debug kernel builds
>> > > > > > > with an agent which eventually led to the attached patch. This change
>> > > > > > > does resolve the issue with perf, however I'm not sure if it's the
>> > > > > > > correct solution.
>> > > > > > > 
>> > > > > > > The reasoning is that arm_arch_timer.c's percpu IRQ registration never
>> > > > > > > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
>> > > > > > > tick_regs, leaving get_irq_regs() to always return an all-zero
>> > > > > > > pt_regs, which in turn breaks perf's sample IP.
>> > > > > > 
>> > > > > > Yep, that is wrong. The patch you provided looks OK to me. I'm just
>> > > > > > wondering if that should be addressed in Linux as well / first.
>> > > > > > 
>> > > > > > @Philippe: Any additional thoughts? Should we take it already?
>> > > > > > 
>> > > > > > 
>> > > > > > @Andrew: Could you please provide a formal patch with proper signed-off
>> > > > > > and LLM notice (assuming agent means AI ;-)) targeting the dovetail 7.2.
>> > > > > > branch? That should help to speed things up. Thanks!
>> > > > > > 
>> > > > > > Florian
>> > > > > > 
>> > > > > > --
>> > > > > > Siemens AG, Foundational Technologies
>> > > > > > Linux Expert Center
>> > > > > > 
>> > > > > > 
>> > > > > 
>> > > > > Hi Florian,
>> > > > > 
>> > > > > I've submitted a patch now against dovetail 7.2, let me know if you
>> > > > > need anything else and thanks for the help!
>> > > > > 
>> > > > > 
>> > > > 
>> > > > Thanks! We might consider merging that while working on a better
>> > > > solution - as suggested by Philippe.
>> > > > 
>> > > 
>> > > Unfortunately, thinking a bit more/better, we'd still have an issue with
>> > > what I suggested. i.e. There are three contexts we need to care about in
>> > > this case:
>> > > 
>> > > 1. when a timer tick can be immediately delivered to its handler
>> > >    (i.e. hw irqs on) from a line tagged with IRQF_OOB.
>> > > 
>> > > 2. when a timer tick can be immediately delivered (i.e. in-band stage is
>> > >    installed) from a line set for in-band delivery (i.e. not tagged with
>> > >    IRQF_OOB). In this case, the interrupt log is synchronized before
>> > >    leaving handle_irq_pipelined_finish().
>> > > 
>> > > 3. when a timer tick /should/ but cannot be delivered to the in-band stage
>> > >    because the latter is stalled, i.e. need for deferral via the
>> > >    interrupt log.
>> > > 
>> > > In the first two cases, postponing the copy logic to
>> > > clockevents_handle_event() would be ok, because the interrupt frame of
>> > > the timer event would still be active, therefore using get_irq_regs() to
>> > > find the regs to copy would be correct.
>> > 
>> > Agree.
>> > 
>> > > 
>> > > In case #3, we have a deferral, therefore the interrupt frame is
>> > > certainly gone when the in-band stage is unstalled. Since other
>> > > interrupts could happen in between, we are toast.
>> > > 
>> > 
>> > Hm, when setting up the proxy device, we mark the affected IRQs as OOB
>> > IRQs. Doesn't that mean that we end up in clockevents_handle_event() for
>> > those IRQs as well? That seems to be the case, if my debugging here is
>> > right.
>> > 
>> > We want to copy the registers of the last OOB timer tick, no? That looks
>> > doable, but I might miss something or just did not run into the "inband
>> > stalled" case.
>> 
>> We want to copy those registers every time the profiling code may
>> consume them, including when the tick is delivered to the in-band stage
>> only. The proxy tick infrastructure allows for enabling only a subset of
>> the CPU range for oob traffic, other CPUs would keep on receiving timer
>> events from the in-band stage.
>> 
>> In order to extend the test case, I would tweak oob_cpus and look at the
>> perf results for a task affine to a non-oob processor.
>
> We could ask the clock_event_device (real device) for it's IRQ and mark
> it  as __IRQF_TIMER during proxy registration.
>
> The following seems to work, but might need some more work.
>
> The on_each_cpu() part is likely a overkill due to percpu IRQs, but the
> real_dev part of mark_timer_tick_irq() is local CPU specific as well.
>
> diff --git a/kernel/time/tick-proxy.c b/kernel/time/tick-proxy.c
> index 6ef04fcf5dacd..55526cd99e849 100644
> --- a/kernel/time/tick-proxy.c
> +++ b/kernel/time/tick-proxy.c
> @@ -296,6 +296,22 @@ static int enable_oob_timer(void *arg) /* hard_irqs_disabled() */
>  	return 0;
>  }
>  
> +static void mark_timer_tick_irq(void *arg)
> +{
> +	struct clock_event_device *real_dev;
> +	struct irq_desc *desc;
> +	int irq;
> +
> +	real_dev = raw_cpu_ptr(&tick_cpu_device)->evtdev;
> +	irq = real_dev->irq;
> +	desc = irq_to_desc(irq);
> +
> +	if (!desc || !desc->action)
> +		return;
> +
> +	desc->action->flags |= __IRQF_TIMER;
> +}
> +
>  struct proxy_install_arg {
>  	void (*setup_proxy)(struct clock_proxy_device *dev);
>  	int result;
> @@ -400,6 +416,8 @@ int tick_install_proxy(void (*setup_proxy)(struct clock_proxy_device *dev),
>  		return arg.result;
>  	}
>  
> +	on_each_cpu(mark_timer_tick_irq, NULL, true);
> +
>  	/*
>  	 * Start ticking from the out-of-band interrupt stage upon
>  	 * receipt of out-of-band timer events.

Almost there, but we still need to provide the registers used in
profiling when no proxy is registered, in which case we cannot depend on
proxy registration for this, but on clock event device registration
instead.

-- 
Philippe.
