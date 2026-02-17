Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9324677F
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318194; cv=none; b=kXq8awfBzudivG8CUkvUTIp05hswgoxmtAdDhelEkBdU6WbwtMvYK3QT4Di4lXExMDG6u5RBBe+TMPGeRUap8YkixJmjZcWzN2d4nYCoy0QVz+132GGoO6xHqtS++F+7twhdFtryNyITEY4CQfigwTWrRN6WYOgu4Fr+TV3BGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318194; c=relaxed/simple;
	bh=VPLAcsmfLDNJcni6C+BZub299JGuwKJ1380dwHWJ/+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F9xRjIHhWnaZFW3OUmDZWA7T4Z3tbuZrgKY9wjPcfMuLuqOSdvxT4+IVwl1HmUHng4MnmmRLBBXJMt3UyJ8r8OhCzOv0vhtAlX5Q+u60JdAWm/z9F5E5ByuQqQ6PPY6r9/sm9zJ160QWogXkr+vzWmBaItNJwaCqPPbRl+6QHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=OVo6nVsZ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="OVo6nVsZ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9638341DDB;
	Tue, 17 Feb 2026 08:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771318190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBjrL7fpB4otS6A1TDpMZe4wXDPwMGAQChZVUfDTM1k=;
	b=OVo6nVsZ+h4sB0aJ3jsXkVLmaPhhlg+l1+DY4WqH3sdLI09mepn6kFI86mvmbf7C33o2Ze
	iVvUkMXIIvMXgN4Q5OLM+aug02qZO7RyK/o6vkc1xXbFpkkRanCZ2vZmizCORaR2+jgFH+
	trXJYwJoB93fONRDOtl/MWf1cCnwQKL3kcOIIzNgwUDTIVq80UT1N4n4LcE/rkouEKETKT
	Ij9KjPgYjXwg9eMEJFfFBRuzVmfWYzZxVfkEqhzpxyudCCHioL3gTkApKmnvo/n2no5qri
	HSY78frH8P4ctEneBVU5zQudYBwZ/8B8ULpNX7PPfHGkoJg1vz9IW8K01LepjQ==
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
Date: Tue, 17 Feb 2026 09:49:50 +0100
Message-ID: <878qcrah5d.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepleeifeekfeegudffffeupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

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

This patch runs fine on my end, survives the full evl test suite,
including the hectic test. Which kernel preemption model are you using?
mine is this one:

Linux qemu-arm64-evl 6.18.7-00979-gb2cf536d0898-dirty #286 SMP PREEMPT_RT EVL Tue Feb 17 09:45:50 CET 2026 aarch64 GNU/Linux

-- 
Philippe.
