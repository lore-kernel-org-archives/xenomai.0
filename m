Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0313F8231
	for <xenomai@lists.linux.dev>; Fri,  5 Jun 2026 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651095; cv=none; b=JCBql6f/ShiFLpM/PtRmnBOoCXkgBOcBHMU5aazfDikoGNeLbm2JGjmJQRUBaWHpKl3EU4Dt+LvyFb+wRDvkyv7rfxdkSTc3IT+wycnpXbxHbzjPVDHynaJSHOGBDc0clMMg9wQL6RojHRJIUuhYgmc8gZF/sR0uQfXNNaFBwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651095; c=relaxed/simple;
	bh=vr9mwHikbmKcFUjJ7vcxmv+HdMpZP9h1Kib3uRHXCgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jwnx5KsCh5VnM8L40yevfnOralIYp6FxKQ9C1Pvruw4b06HzmPdhHp4/4kraO5cCNojLXFVHJoTK31d5JZuV74loJ4sw02Oi2I05ME0jkUQW+XcYLLwgoyJINO0MuBc0Q2iSUej1vC9dpBifPsvI8CbkFZxNVH973tBY4AmDWxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WQCw5iLe; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WQCw5iLe"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202606050918017d1d41188d000207b5
        for <xenomai@lists.linux.dev>;
        Fri, 05 Jun 2026 11:18:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vr9mwHikbmKcFUjJ7vcxmv+HdMpZP9h1Kib3uRHXCgI=;
 b=WQCw5iLemPVstnjzlQlGafLfMWcNMq0AGt0oATzxWrjvobz6mphq/Bw3ru6o4Bfw97yvsA
 fYU/G+rU8mzUAS9/RuzzfNnIDQ13yKfDcmLdSx9pg7ofN++I10gv3cCx836RO+4g3PSqsLdT
 6pYWG9IYufNnD20ICKPO8utbK5Dq547AO/7PxXO+5SvVjzZJA+nx9u/cGOcXk/kyb0I5Arr9
 Ny9D4yEZMaJEyMl04wZ72LnH+c45kkRQIz/DYl04xy2vhvaQukwXmgDwwJXpDm//fd4ToS+s
 PYDipsWABZEppSsDosVN6wwK/G4VWF80fefJg/+eEwxWv2vwLuads4ng==;
Message-ID: <9e41a83f3b14f138a985677616050302114408af.camel@siemens.com>
Subject: Re: [PATCH 0/2] arm: Review irq pipeline
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Tobias Schaffner <tobias.schaffner@siemens.com>
Date: Fri, 05 Jun 2026 11:18:01 +0200
In-Reply-To: <87jysflb9h.fsf@xenomai.org>
References: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
	 <87jysflb9h.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2026-06-03 at 20:38 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Hi Philippe,
> >=20
> > This is the result of a review of the arm implementation of the IRQ
> > pipeline. Triggered by some risc-v reviews.
> >=20
> > I'm sure about the two easy fixes, targeting different Dovetail
> > versions, so split into different patches.
> >=20
> > In addition there is one more, I need your input here:
> >=20
> > We have two calls to interrupts_enabled() in arch/arm/mm/fault.c,
> > both in the do_page_fault() path.
> >=20
> > Assuming that we are handling a page fault over kernel space,
> > inband stage stalled, we would leave the kernel with the inband stage
> > unstalled, as interrupts_enabled() is checking the hardware state (as
> > pushed to the stack on entry) instead of the inband stage stall bit.
> >=20
> > Is that correct?
> >=20
>=20
> Nope.
>=20
> > I'm quite sure we have more real problems that in this case, but
> > maybe we should fix that up?
> >=20
> > We would have to call something that does the HW check in case
> > CONFIG_IRQ_PIPELINE is off, but checks the stall bit in case pipelining
> > is enabled.
> >=20
>=20
> Instead of checking for interrupts_enabled(regs) in do_page_fault() and
> do_kernel_address_page_fault(), we should rather check for
> !(arch_kentry_get_irqstate(regs) & KENTRY_STALL_BIT) when pipelining,
> which would give us the virtual interrupt state on entry, provided we
> run in-band.
>=20
> Inner issue: since do_kernel_address_page_fault() skipped fault_entry()
> on trap from supervisor mode, we might still be running oob, calling
> local_irq_enable() in such a case would be wrong.

Agreed.

I was starting to change the interrupts_enabled() implementation for the
pipelining case, which would affect all users. So I had to check them
first.


I found the following:

arch/arm/kernel/hw_breakpoint.c - hardware break/watchpoint exception:
Are we able to handle that exception from the oob stage?
The implementation would unconditionally change the inband IRQ state.
Missing fault_{entry,exit} with new trap type?

arch/arm/kernel/process.c - reporting
I guess we should report the inband IRQ state, no?
Would be fixed "automatically".

arch/arm/mm/alignment.c - Memory alignment exception
Seems this one was wrongly migrated already. mark_trap_entry() called
too late and enabling hard IRQs instead of inband unstall.
Seems easy to fix.

arch/arm/mm/fault.c - As discussed
Would be fixed "automatically".

drivers/irqchip/irq-gic-v3.c - global IRQ handler
That's the one that bothers me most as it is not limited to arm (used by
arm64 as well) and should be called twice during IRQ flow. Once for
handling the HW IRQ, once for IRQ log sync. Correct?

That user has to stay untouched, always checking the hardware state,
right?

My understanding is that we "fix" or prepare the IRQ states accordingly
before starting IRQ log synchronization.
