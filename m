Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72B391835
	for <xenomai@lists.linux.dev>; Mon,  8 Jun 2026 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906171; cv=none; b=BeZQQhyoXYROMXhYbtAWmRqp9FV94zTNkxCDtYn9vHVa/MTumkAF2pVZKjYDX9xvBuuGBSb8OTff4A5kdno6vUl0AJlTiY9qS7riG61vcrnQpeA2cKIbPQc2BKia+ZRijDHWOmzr7eEQqj2Y0W7bINQBwNBZWsvpBuBfSC3J9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906171; c=relaxed/simple;
	bh=hgEMDcFTIY/JvFXLn74MMKauZUzcA+fPBo+g6oxQsf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+dBwM5gjPMD35vNeHiIzXjJwluV2wrWx4iIObNpuCVhWKrEfnnRze3zrqSacINJsJLPW1rLe/ZeRKjnHHUog71Fj4zAp6xGwWkwrZoSyeAPeC+vVYfkdrmM/W8SELSSScKuJyr0sU0RXVelCMVsuTWFlgc4ARSfQ+egxb/6rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=GZmLN/16; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="GZmLN/16"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E12BC3EBC3;
	Mon,  8 Jun 2026 08:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780906161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6wnpM+IU0YPG4oLv6FmoM0iZmpfbw7DDbhPviHQyEMM=;
	b=GZmLN/16jwrDlk01XagPpM4JR5Ae+fdwvlnc2+EuGT6jpFSeBYDCLpewcKUvtZlMmedn5i
	6+4YJSOVHCpRND6lgjT6k21Cb6tTPJP6I30K9HBdUjQWGc22XLUdHv8zdn7654XUl7Pfxp
	dQWr0mTFBKh1QPiXtEPx1I5azP5/pUv7Yo1BHM6Nvim/3Plx4uYbydoY4hcxU+ILwzMW+I
	e88Cn2Zj1jAvRmjBbKPFIoMNAorILnzhPoJxHVb9W6iySqH3rofQh7YWrLFiiog6+H/5J/
	ZFi4uHvrBK0SQtN8izZ609s09TsjmnMtZm6u+HPdzwVLAkX4vZie9G9h232oyw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 0/2] arm: Review irq pipeline
In-Reply-To: <9e41a83f3b14f138a985677616050302114408af.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 05 Jun 2026 11:18:01 +0200")
References: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
	<87jysflb9h.fsf@xenomai.org>
	<9e41a83f3b14f138a985677616050302114408af.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 08 Jun 2026 10:09:16 +0200
Message-ID: <878q8p78sz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEu3jIzQlWNnxsSLz7J5Uf+VXp1aYdXWdKizjkXQFAX9gPHLrt11Mtw3a1cVUcHeiQubsd6Qktk/61f+dOgIbi2+cyXXxrMWwDIdpQziDyfAvdkKctwAdeqYN/16kdSrh/9KUN/TvdG2+RHuIhrCTWHUeuOEx9PzwjRdCO3GLEpi4WH9ikMED1YIQB5+aCIn8lI20J65+QYSf2dWr6+wql6DUDV8Yaezr/eh89sHTX0H5KHQalAHmBPH9dZhybW5QsOy5nxGps/S7uu/uavMyHtPXvPeqiTBxUiH6eE/0dtcImSG7SLUpc/u4KD7XONinOw3vL2vXysGp23NKcLVj6kSRvePa9l83yEZSnCg3R4yAmGIsaBpR3lqgV3zaGvvEPfZhw373TMkZCDqKauI5uhij/OKpvjEoN5hL4qAaGGuNJCDdXug0z7fnQ5Ncba0JfQ22zZkDVXq9lPEvb0R/G8w9NgIAXj2eL02p1nx//0JnJgeMugQOE4iUQ0jI86x6eviGZnyP5b3uNE0XWcZWOipq6vZN4Gx+vIGcuuaCCtwh1RBXBfIz9+1qyqIyCcw8aqvyJs4xLdxaOlsPd8f5cbs7bMbs3rD0jhXMFyAFy84R1yoe9rtqmc/Iubss/ZHREIM+NT10WaXjYHNTDtFbfd6+5UzfmoxF4I9cAsID6Jxg
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Wed, 2026-06-03 at 20:38 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > Hi Philippe,
>> > 
>> > This is the result of a review of the arm implementation of the IRQ
>> > pipeline. Triggered by some risc-v reviews.
>> > 
>> > I'm sure about the two easy fixes, targeting different Dovetail
>> > versions, so split into different patches.
>> > 
>> > In addition there is one more, I need your input here:
>> > 
>> > We have two calls to interrupts_enabled() in arch/arm/mm/fault.c,
>> > both in the do_page_fault() path.
>> > 
>> > Assuming that we are handling a page fault over kernel space,
>> > inband stage stalled, we would leave the kernel with the inband stage
>> > unstalled, as interrupts_enabled() is checking the hardware state (as
>> > pushed to the stack on entry) instead of the inband stage stall bit.
>> > 
>> > Is that correct?
>> > 
>> 
>> Nope.
>> 
>> > I'm quite sure we have more real problems that in this case, but
>> > maybe we should fix that up?
>> > 
>> > We would have to call something that does the HW check in case
>> > CONFIG_IRQ_PIPELINE is off, but checks the stall bit in case pipelining
>> > is enabled.
>> > 
>> 
>> Instead of checking for interrupts_enabled(regs) in do_page_fault() and
>> do_kernel_address_page_fault(), we should rather check for
>> !(arch_kentry_get_irqstate(regs) & KENTRY_STALL_BIT) when pipelining,
>> which would give us the virtual interrupt state on entry, provided we
>> run in-band.
>> 
>> Inner issue: since do_kernel_address_page_fault() skipped fault_entry()
>> on trap from supervisor mode, we might still be running oob, calling
>> local_irq_enable() in such a case would be wrong.
>
> Agreed.
>
> I was starting to change the interrupts_enabled() implementation for the
> pipelining case, which would affect all users. So I had to check them
> first.
>

Um, no. I would not do that. Such systemic change is prone to create
regressions due to unwanted side-effects as new call sites may go
unnoticed as they are added over time. I would introduce a specific
pipeline-aware predicate instead, like interrupt_virtually_enabled() or
whatever fits. That way we could do sweeping reviews of
interrupt_enabled() usage periodically, checking whether conversion to
interrupt_virtually_enabled() is needed for those new call sites.

>
> I found the following:
>
> arch/arm/kernel/hw_breakpoint.c - hardware break/watchpoint exception:
> Are we able to handle that exception from the oob stage?
> The implementation would unconditionally change the inband IRQ state.
> Missing fault_{entry,exit} with new trap type?
>

Hw bp/wp handling is not supported on arm ATM, x86 is the only
architecture where the pipeline would officially support this (Jan
worked on this to enable kgdb/x86 many moons ago IIRC). So yes, we need
to mark trap entries if we'd want to enable this for arm as well.

> arch/arm/kernel/process.c - reporting
> I guess we should report the inband IRQ state, no?
> Would be fixed "automatically".
>

There are pros and cons to report the hw vs virtual interrupt state
here. We may need both for debugging actually.

> arch/arm/mm/alignment.c - Memory alignment exception
> Seems this one was wrongly migrated already. mark_trap_entry() called
> too late

mark_trap_entry() is expected to cause a stage switch to in-band if
running oob, possibly switching to other tasks, in addition to
re-enabling hw IRQ, all in the same move.

Since the branch predictor hardening code mitigates Spectre attacks,
running it early - prior to switching back to a user context - looks
right.

In fact, the current scope of the mark_trap_entry/exit section may be
too broad, since the alignment fixup code looks like oob-safe. Such
section might only be required around force_sig_fault().

> and enabling hard IRQs instead of inband unstall.
> Seems easy to fix.

We want hw interrupts to be enabled while fixing up an alignment trap to
decrease latency for oob. Enabling them virtually would help in
maintaining fine-grained native preemption for in-band exclusively.

>
> arch/arm/mm/fault.c - As discussed
> Would be fixed "automatically".
>
> drivers/irqchip/irq-gic-v3.c - global IRQ handler
> That's the one that bothers me most as it is not limited to arm (used by
> arm64 as well) and should be called twice during IRQ flow. Once for
> handling the HW IRQ, once for IRQ log sync. Correct?
>

gic_handle_irq() is called only once for each event, from entry-armv.S
(irq_service_handler set to handle_arch_irq_pipelined -> ... ->
handle_irq_pipelined -> ... -> gic_handle_irq).

irq_desc->handle_irq() is the one which may be called multiple times via
generic_handle_irq_desc(), if we have to propagate an event to the
in-band stage.

> That user has to stay untouched, always checking the hardware state,
> right?
>

Yes, that one must be left unchanged. We need to check the hw state in
order to figure out whether a NMI was taken.

> My understanding is that we "fix" or prepare the IRQ states accordingly
> before starting IRQ log synchronization.

Are you still referring to gic_handle_irq()? If so, that part merely
decodes the hardware event.

-- 
Philippe.
