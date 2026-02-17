Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93549275B18
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318089; cv=none; b=kp0mhIT2GhbWgUEDV3UVEMRzf687PefzbuvKwYOi8r2wT/kpeEbouYSxNLu8pHd3PpGW+6JwvPNjDYIy7h+Kv5iA9z5N20vabKr3qe9fTotwgg+s0JIKxFqlX208pxxI7yAykvdGUyjzTH53OHdyJ8SUt6Apsw7j/3G6udzhFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318089; c=relaxed/simple;
	bh=ZCwFeN5sKVeXODDSd6Ey+YT89zRzdENOllyCHzzHDzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mTGuOF/QqhPtq56bDcOcuJvFgL39eBmZ6yq+a2Pr6sixLmMOtGVpdNjfu/V+/diK1zbmpo++4Br4io1o5wS+jtWCkh7eBVKlLAduYxGlCmahi+KYrJ9obHTNsHdKSKfCMdlZCfdOCxu2u1VWdVvbedIQL+iyBeoQ5lqq9KnOXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=gKDuS5UY; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="gKDuS5UY"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 7D6A3581566
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 08:41:08 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A135841DD0;
	Tue, 17 Feb 2026 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771317661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DKMXOy44FfWeoD0zWB0gCA3LS+K/jmzJmwNnvFOdamA=;
	b=gKDuS5UYI2JHUlY6wC5dyvvTMBiLofj3y6U/wPV2BigYpo6nE6aSXaTW31zUBlJ0Rn2IBa
	CwCpn2KfjyfhKvPWGEYf4TvKBUdKgSqq/KdhJLatm0yinmhnefvBR8gXCln7/WFP9EJ+Qq
	odZl4QL7SEGEPUnmR6cT8ETVDdA+LIhxsKIRKf3NRaQwNPyBPOSnj69of5x2t/xo/B10c3
	dH8IA4GnHLCeBjGKkvqjMphHiLIbAg+a4s7/5UcgGWxmOjhL9aKEOEf4NZ/bO1japvZ2lg
	Eg8HqJt6uzcNgbXPu+NAp8hKFVCj0iPT9cWzcpNbz9ZIl5lcl4Oomo8lhAbSww==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 2/2] arm64: irq_pipeline: Fix the demotion
 checks for el0 and el1 IRQs
In-Reply-To: <9e12c4a73df2d24dd1b39ab196b0112cb4e7e6ef.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 17 Feb 2026 09:24:31 +0100")
References: <20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
	<20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
	<87jywbajfy.fsf@xenomai.org>
	<505e35212b6655e0cb65e9fbc418c1171a9c916e.camel@siemens.com>
	<9e12c4a73df2d24dd1b39ab196b0112cb4e7e6ef.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 17 Feb 2026 09:41:00 +0100
Message-ID: <87ecmjahk3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugeptedufeehkeegudffffdtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean
X-GND-Score: -100

WFlorian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2026-02-17 at 09:12 +0100, Florian Bezdeka wrote:
>> On Tue, 2026-02-17 at 09:00 +0100, Philippe Gerum wrote:
>> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > 
>> > > While reviewing some of the low level pipeline code I realized that
>> > > the checks for task demotion are wrong on arm64.
>> > > 
>> > > el0: The demotion check was missing in the oob case. We have to check
>> > >      for running_inband() only as user_mode(regs) will always be true.
>> > >      We are serving an IRQ over el0, so application / user mode.
>> > > 
>> > > el1: The demotion check was unnecessary and "inactive" as
>> > >      user_mode(regs) is never true on el1, we are serving an IRQ over
>> > >      kernel mode.
>> > > 
>> > 
>> > If the demotion happens from el1, you still want to check for a
>> > rescheduling opportunity (i.e. kernel preemption case).
>> > 
>> > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > > ---
>> > >  arch/arm64/kernel/entry-common.c | 8 ++++----
>> > >  1 file changed, 4 insertions(+), 4 deletions(-)
>> > > 
>> > > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> > > index 07fa70713ce04eaf3df9223354babcecde923280..9c99eb3d18c459a90e1f7ce4e4c307e235e457a2 100644
>> > > --- a/arch/arm64/kernel/entry-common.c
>> > > +++ b/arch/arm64/kernel/entry-common.c
>> > > @@ -73,6 +73,10 @@ static noinstr void arm64_pipeline_el0_irq(struct pt_regs *regs,
>> > >  	do_interrupt_handler(regs, handler);
>> > >  	/* Done, unwind now. */
>> > >  	handle_irq_pipelined_finish(prevd, regs);
>> > > +	if (running_inband()) {
>> > > +		stall_inband_nocheck();
>> > > +		irqentry_exit_to_user_mode(regs);
>> > > +	}
>> > >  	instrumentation_end();
>> > >  	arm64_exit_to_user_mode(regs);
>> > >  }
>> > > @@ -90,10 +94,6 @@ static noinstr void arm64_pipeline_el1_irq(struct pt_regs *regs,
>> > >  		prevd = handle_irq_pipelined_prepare(regs);
>> > >  		do_interrupt_handler(regs, handler);
>> > >  		handle_irq_pipelined_finish(prevd, regs);
>> > > -		if (running_inband() && user_mode(regs)) {
>> > > -			stall_inband_nocheck();
>> > > -			irqentry_exit_to_user_mode(regs);
>> > > -		}
>> > >  		instrumentation_end();
>> > >  		mte_check_tfsr_exit();
>> > >  		return;
>> > 
>> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> > index e0227d467cef4..770fc4059e083 100644
>> > --- a/arch/arm64/kernel/entry-common.c
>> > +++ b/arch/arm64/kernel/entry-common.c
>> > @@ -90,10 +90,8 @@ static noinstr void arm64_pipeline_el1_irq(struct pt_regs *regs,
>> >  		prevd = handle_irq_pipelined_prepare(regs);
>> >  		do_interrupt_handler(regs, handler);
>> >  		handle_irq_pipelined_finish(prevd, regs);
>> > -		if (running_inband() && user_mode(regs)) {
>> > -			stall_inband_nocheck();
>> > -			irqentry_exit_to_user_mode(regs);
>> > -		}
>> > +		if (running_inband())
>> > +			goto out_irqentry;
>> >  		instrumentation_end();
>> >  		mte_check_tfsr_exit();
>> >  		return;
>> > @@ -109,6 +107,7 @@ static noinstr void arm64_pipeline_el1_irq(struct pt_regs *regs,
>> >  	trace_hardirqs_on();
>> >  	unstall_inband_nocheck();
>> >  	handle_irq_pipelined_finish(prevd, regs);
>> > +out_irqentry:
>> >  	stall_inband_nocheck();
>> >  	trace_hardirqs_off();
>> >  	instrumentation_end();
>> > 
>> 
>> That would look a bit imbalanced. We would have one additional
>> trace_hardirqs_off() and one irqentry_exit() call without counterparts.
>> 
>> Is that really OK? Testing...
>
> Nope, doesn't boot up on my arm64 qemu.
>
> Comparing with x86 again, I think that my proposal is "correct" in terms
> of identical to what x86 does. Do all architectures have a gap here?

x86 has a single implementation for both user and kernel preemption
paths, arm64 has two since the privilege level is explicitly stated by
the irq handler being called, but this still must translate identically
logically speaking. Your implementation is missing the kernel preemption
path after demotion.

i.e. when checking for running_oob() || irqs_disabled(), the cases
covered are:

(1) in-band user path on entry (implies !irqs_disabled())
(2) oob user path on entry (might be demoted)
(3) (virtually) stalled in-band kernel path on entry (implies no reschedule,
  filtered out by irqentry_exit())
(4) oob kernel path on entry (might be demoted)

Therefore, with your patch in, el1 is now missing (4).

-- 
Philippe.
