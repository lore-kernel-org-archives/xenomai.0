Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25482367D5
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316679; cv=none; b=NeAMXoJqRfXOYkWT4o26KLu1y3ltyFdOV6Fe/d24T2zk0kQA7woO2uZY2/UYpLtKtyKzprYgyt1Z5LEliynPg5arrBECSbUVYZSQrVxkRW/82byqMCJvWRdeJaaSkD8719dHdCM/JuyBsFHf6zwg0LRD7BZUxfG2GP2DvzCw8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316679; c=relaxed/simple;
	bh=4WLQCx1OL7Hu5V+TRnrpxmj+jKKnHstWBkzAXX31HSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I64eNOJbEQ4W/eTn8YWFn/4d2P1VPNYEIObea4rAxvoC6b5eaq5ikrd3wHOghbg5HoQNMRd3zXNKwDzCxhBBY06FLVYfr/c6X/QtpSgF8s1ozY/Dl7kHMOxHjBrDRFW4wecDEJaMA57yqJj1AgUho3N150+SlIMEvb1LRl/7bj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=OjyzJqaq; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="OjyzJqaq"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202602170824315dbee85399000207bf
        for <xenomai@lists.linux.dev>;
        Tue, 17 Feb 2026 09:24:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QbrIYjwhYB+L+uR8mYEMDKK9Z91uEdXbcVrXzQ5BIbY=;
 b=OjyzJqaqirsb+1YhGTBBdQoHRx9uOpvgwEbWF5KQhBnKd/niAcReTosu/R/3jnhlpAbWYU
 HIj0nln0zQaZlZcVqtgaEAwwlt5mbAbSo67MvV3s7yQ57JhlP4MgkA4jC7lpAGeBc7g5mKGG
 w2/SaLKXPbsJi59gCzDNQDGH9O6mRRr/vPD/Ro55lNnzswHdL3vF5NI9OjIhN5rNizIPZ62V
 wJrwGLwoMndJse68bn8Y3Yu5ckt1Oloi6HCBXiiG8w5T26pT6DftiLp0h1xkN6ItTcQwx9P7
 0kBTwP1/yMG43pvn0rQpS/9Ewtf1Vxs+IXVUxwz955dxFZ07rpptx/xg==;
Message-ID: <9e12c4a73df2d24dd1b39ab196b0112cb4e7e6ef.camel@siemens.com>
Subject: Re: [PATCH Dovetail 2/2] arm64: irq_pipeline: Fix the demotion
 checks for el0 and el1 IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 17 Feb 2026 09:24:31 +0100
In-Reply-To: <505e35212b6655e0cb65e9fbc418c1171a9c916e.camel@siemens.com>
References: 
	<20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
			<20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
		 <87jywbajfy.fsf@xenomai.org>
	 <505e35212b6655e0cb65e9fbc418c1171a9c916e.camel@siemens.com>
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

On Tue, 2026-02-17 at 09:12 +0100, Florian Bezdeka wrote:
> On Tue, 2026-02-17 at 09:00 +0100, Philippe Gerum wrote:
> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> >=20
> > > While reviewing some of the low level pipeline code I realized that
> > > the checks for task demotion are wrong on arm64.
> > >=20
> > > el0: The demotion check was missing in the oob case. We have to check
> > >      for running_inband() only as user_mode(regs) will always be true=
.
> > >      We are serving an IRQ over el0, so application / user mode.
> > >=20
> > > el1: The demotion check was unnecessary and "inactive" as
> > >      user_mode(regs) is never true on el1, we are serving an IRQ over
> > >      kernel mode.
> > >=20
> >=20
> > If the demotion happens from el1, you still want to check for a
> > rescheduling opportunity (i.e. kernel preemption case).
> >=20
> > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > ---
> > >  arch/arm64/kernel/entry-common.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/ent=
ry-common.c
> > > index 07fa70713ce04eaf3df9223354babcecde923280..9c99eb3d18c459a90e1f7=
ce4e4c307e235e457a2 100644
> > > --- a/arch/arm64/kernel/entry-common.c
> > > +++ b/arch/arm64/kernel/entry-common.c
> > > @@ -73,6 +73,10 @@ static noinstr void arm64_pipeline_el0_irq(struct =
pt_regs *regs,
> > >  	do_interrupt_handler(regs, handler);
> > >  	/* Done, unwind now. */
> > >  	handle_irq_pipelined_finish(prevd, regs);
> > > +	if (running_inband()) {
> > > +		stall_inband_nocheck();
> > > +		irqentry_exit_to_user_mode(regs);
> > > +	}
> > >  	instrumentation_end();
> > >  	arm64_exit_to_user_mode(regs);
> > >  }
> > > @@ -90,10 +94,6 @@ static noinstr void arm64_pipeline_el1_irq(struct =
pt_regs *regs,
> > >  		prevd =3D handle_irq_pipelined_prepare(regs);
> > >  		do_interrupt_handler(regs, handler);
> > >  		handle_irq_pipelined_finish(prevd, regs);
> > > -		if (running_inband() && user_mode(regs)) {
> > > -			stall_inband_nocheck();
> > > -			irqentry_exit_to_user_mode(regs);
> > > -		}
> > >  		instrumentation_end();
> > >  		mte_check_tfsr_exit();
> > >  		return;
> >=20
> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry=
-common.c
> > index e0227d467cef4..770fc4059e083 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -90,10 +90,8 @@ static noinstr void arm64_pipeline_el1_irq(struct pt=
_regs *regs,
> >  		prevd =3D handle_irq_pipelined_prepare(regs);
> >  		do_interrupt_handler(regs, handler);
> >  		handle_irq_pipelined_finish(prevd, regs);
> > -		if (running_inband() && user_mode(regs)) {
> > -			stall_inband_nocheck();
> > -			irqentry_exit_to_user_mode(regs);
> > -		}
> > +		if (running_inband())
> > +			goto out_irqentry;
> >  		instrumentation_end();
> >  		mte_check_tfsr_exit();
> >  		return;
> > @@ -109,6 +107,7 @@ static noinstr void arm64_pipeline_el1_irq(struct p=
t_regs *regs,
> >  	trace_hardirqs_on();
> >  	unstall_inband_nocheck();
> >  	handle_irq_pipelined_finish(prevd, regs);
> > +out_irqentry:
> >  	stall_inband_nocheck();
> >  	trace_hardirqs_off();
> >  	instrumentation_end();
> >=20
>=20
> That would look a bit imbalanced. We would have one additional
> trace_hardirqs_off() and one irqentry_exit() call without counterparts.
>=20
> Is that really OK? Testing...

Nope, doesn't boot up on my arm64 qemu.

Comparing with x86 again, I think that my proposal is "correct" in terms
of identical to what x86 does. Do all architectures have a gap here?
