Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435543;
	b=3XpfB0tDmkUPJaCSX2rOpDJK4l3tSKS0Cbl+TitaXe6+aB4XRRbq9ShJkycNHRN1cvne
	 nZxZTprUBwr8mUMUKenDWP3CUJ39/HCahwTJorv8W4hJryMXgErDLAPVkV2twoOpnw5YC
	 cPlnqBMKlcpdWCrkct8Zd/JUOAYqFRGRwKgpd31M6uBSOtPUqKEDjPTFqP2x03KQFuWmH
	 AGo7pyOujm0PPUda2qUHfPekt59pKvuK3U6/waj1D2QlV6JgBCzVEg3Sf8h452t6YlRTh
	 LfF1xFSAa5RPO+buLcbOHSY+h3Yns22PNPbLXiwnd2nim0ttwog3PJIY/CyGIO6hWxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435543;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=JGp7FvNto3GATOynRp5QQVkOS0i7FFW+bLB3h7S0B/I=;
	b=yvDWR+yAWtCWwD+WI1wL4iglzS/Nme2C2nlWiyPxnFXhvbnfahHFva+8zls5y7I9nt9t
	 DNjGBsUTB/UJSv1ja7/TTAuEMrkLfe1y3WWLxYgcLCuOOA+DCJ79t0oCE/vska3Z201uF
	 Taa/J5G/OLz/q9DXLLP2VYiU3xRvucDoqQeN3TA+Y3jrVIokRVjYQwQRGKL+LQLqLRzk4
	 w2HiYkeIrT0TEAVYuAcER/B7ERY/hhs0uzXxcEU0OuHE105oZEQZh0xrEoB7fw6hZTJqO
	 w5Qr7yqtZ6bohntLL3HyB1ASoLXOKED6GmvY6UW18qET2HpOWd6Ox4+x1dFzrx8+Q4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=n2mXQ1iY;
	arc=none smtp.remote-ip=185.136.65.227
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777D606A31A
	for <xenomai@lists.linux.dev>; Mon, 23 Nov 2026 12:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D777D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=n2mXQ1iY
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20261123120539bdb7561d580002077a
        for <xenomai@lists.linux.dev>;
        Mon, 23 Nov 2026 13:05:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JGp7FvNto3GATOynRp5QQVkOS0i7FFW+bLB3h7S0B/I=;
 b=n2mXQ1iYxtPtjV+Q3ecivILLAPJwYK9MO/aSWsege5ISdVLE5b9DaYeRTVisncj2dMhpjn
 cOlARWgeIBVS3/V4v/IYi0boVVaHx6waTkcrjOeioB/ZTCxVGleZvlX24qMgrRNYGT2U+WPu
 KuBEMo3ZmgSG9nPLmN1rvJqfFQnbUiY+WBzgtQgpo3IwQMMLaN3IC620VfOWdFbhzvnmrMeY
 df2emhGN9XBCJN34O6JyIRkON4mz0XZAfzjiPICZ3KmrQKTubGgkvQqSGA9ZQHpv56Pmt9Tq
 ykCni/LYB56fGJLcFso2PThwWCeWr8OOnbu0wzSlpJsit327F1Tc9/CA==;
Message-ID: <87afa16be7aada0d995e63364bb9e7785af24675.camel@siemens.com>
Subject: Re: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq
 state on kernel page faults
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Mon, 23 Nov 2026 13:05:38 +0100
In-Reply-To: <915d53fb-fc8b-4c07-935f-a9d4680ee8a5@siemens.com>
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
	 <20261121165933.57310-4-tobias.schaffner@siemens.com>
	 <DN2371TJAB7G.334DTWMEPJTQI@siemens.com>
	 <915d53fb-fc8b-4c07-935f-a9d4680ee8a5@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2026-11-23 at 12:39 +0100, Tobias Schaffner wrote:
> On 11/22/26 23:18, Florian Bezdeka wrote:
> > On Sat Nov 21, 2026 at 5:59 PM CET, Tobias Schaffner wrote:
> > > A page fault may hit kernel code which runs with hard irqs off, e.g. =
a
> > > kprobe whose fetch argument faults within the breakpoint trap. The fa=
ult
> > > handler still enables hard irqs for every kernel mode fault, so an
> > > interrupt may break into that code. If the fault is handled out-of-ba=
nd,
> > > the handler also unstalls the in-band stage over the out-of-band stag=
e.
> > >=20
> > > Enable hard irqs in handle_page_fault() only if the faulting code had
> > > them on and we run in-band, and stall the in-band stage on exit only =
if
> > > we run in-band.
> > >=20
> > > Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
> > > Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> > > ---
> > >   arch/riscv/kernel/traps.c | 11 ++++-------
> > >   arch/riscv/mm/fault.c     |  7 +++++--
> > >   2 files changed, 9 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > > index a8e37ec27cc2..47799f18fa7d 100644
> > > --- a/arch/riscv/kernel/traps.c
> > > +++ b/arch/riscv/kernel/traps.c
> > > @@ -488,17 +488,14 @@ asmlinkage __visible __trap_section void do_tra=
p_software_check(struct pt_regs *
> > >   asmlinkage __visible noinstr void do_page_fault(struct pt_regs *reg=
s)
> > >   {
> > >   =09irqentry_state_t state =3D irqentry_enter(regs);
> > > +=09bool inband =3D mark_trap_entry(regs);
> > >  =20
> > > -=09mark_trap_entry(regs);
> > > -
> > > -=09BUG_ON(dovetail_debug() && !running_inband());
> > > -
> > > -=09if (!user_mode(regs))
> > > -=09=09hard_cond_local_irq_enable();
> > > +=09BUG_ON(dovetail_debug() && !inband && user_mode(regs));
> > >  =20
> > >   =09handle_page_fault(regs, state);
> > >  =20
> > > -=09local_irq_disable();
> > > +=09if (inband)
> > > +=09=09local_irq_disable();
> > >  =20
> > >   =09mark_trap_exit(regs);

Below comes another hard_cond_local_irq_disable() call that is a
duplicate as already handled by mark_trap_exit(). =3D> More code to be
removed.

> > >  =20
> > > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > > index c5709112c346..f72b49d8f15a 100644
> > > --- a/arch/riscv/mm/fault.c
> > > +++ b/arch/riscv/mm/fault.c
> > > @@ -317,8 +317,11 @@ void handle_page_fault(struct pt_regs *regs, irq=
entry_state_t state)
> > >  =20
> > >   =09/* Enable interrupts if they were enabled in the parent context.=
 */
> > >   #ifdef CONFIG_IRQ_PIPELINE
> > > -=09if (state.stage_info !=3D IRQENTRY_INBAND_STALLED)
> > > -=09=09local_irq_enable_full();
> > > +=09if (running_inband() && !regs_irqs_disabled(regs)) {
> > > +=09=09hard_local_irq_enable();
> > > +=09=09if (state.stage_info !=3D IRQENTRY_INBAND_STALLED)
> > > +=09=09=09local_irq_enable();
> > > +=09}
> >=20
> > Is that part aligned with any of the other architectures?
>=20
> Yes. This pattern is taken from cond_reenable_irqs_kernel() in
> arch/x86/mm/fault.c

Let me check, but I think the entry code is a bit different on x86.

The original Linux code here is
=20
=09if (!regs_irqs_disabled(regs))
=09=09local_irq_enable();

The question now is: Why do you still play around with hard IRQs? They
have already been enabled in mark_trap_entry(). =3D> Remove the
hard_local_irq_enable() call, no?=20

>=20
> > I'm asking because it seems that the pattern used here has an ordering
> > problem.
> >=20
> > Once we enabled hard IRQs with hard_local_irq_enable() hardware events
> > might come in, hitting an stalled inband stage. Means we log all the
> > events into the IRQ log.
> >=20
> > When we unstall the inband stage with local_irq_enable(), that will
> > bring us a full IRQ log synchronization - over page fault handling.
>=20
> Is this really a problem? We are handling the running_inband() case here.

In case of an IRQ storm we will not make any progress here. I remember a
discussion with Philippe, where I took the "hardware disablement first"
pattern with me. Let me search for it...

>=20
> Mainline is doing this at the same point to allow IRQ handlers to run
> while page faulting. Why should we prevent handle this differently?
> As long as hard IRQs have been enabled before this should be fine,
> shouldn't it?
>=20
> > As local_irq_enable_full() does it the other way around as well, I
> > think that the ordering is wrong.
> >=20
> > If taken / aligned from/with an other arch: we should check that as wel=
l.
> >=20
> > >   #else
> > >   =09if (!regs_irqs_disabled(regs))
> > >   =09=09local_irq_enable();
> >=20
