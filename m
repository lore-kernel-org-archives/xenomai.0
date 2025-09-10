Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C15260587
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540218; cv=none; b=MGg5/iIjrjSIviFkVa8Qt/+41cPjb7F1JGgXLZzocK3OvNc+agc303XDv4MDvDh8e7Hmk3gt7W8KMfLs9F5e3O3SIXjaj+OHRmmM3L2DCO8Gr7pLZc0jFuLBjRs3tFpIpd2KTjbTQFoIJA0PzHjna1v204DDQ4EByC1yofeYFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540218; c=relaxed/simple;
	bh=EkDF99Oy/+cuLK1YZX/gchKMYlA5cpWz98RbnZtF0Ns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lASrCg7ep999LGChtZm3J0WYCWBmePzSwb3QXAtDH94lDwEwz5vnap2txrG6OHRmSYwCldGXBtYL/kWbdrMpjnhO20L/pA2wR9KIUHkfwXXr11sVYiyK3zB8Xv1Zo4wPiUeU3Lxh46Q323SJdb75TyKf5dQzVtwDHESxMZbeZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=eRN4V1AU; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="eRN4V1AU"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250910213643caf30b86cd000207fa
        for <xenomai@lists.linux.dev>;
        Wed, 10 Sep 2025 23:36:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Emud1TXnbX5i1Sf6SUrUvzY/8RYyJQbvhd9LqB0m13k=;
 b=eRN4V1AUpm3IpbHphJTrFDVq2VgPTY7+GLSbAfypaq7ZntsvBl7m6+xbK5JVpQq61hQu6g
 Zb8jXHxkK8fjvHAaMDivt5A69H3SBkhxLwyBcAOiz82Y70bgi3PXx5kdxEPBXz9HYCue/rWl
 LONF95LFW1EvymCjV6+3eFI+7BYsLCO5nhAWh85yzsGYkP3L5pjyUYh4RJ4x8mf6ex988A9f
 4w8iho1mLqCsuAY1xhGyYC1h7aHU73iO3pML81s3ITzSESdMFpAQ9yCtlJTFQMVsFiS7zq4G
 ArRyTYPYQuLfSYmpojuiOEpBstVvm8OMcUKnUT+i9c7w+ZN7QKMw1dyA==;
Message-ID: <c84371b93d69eda2b7a9ce2b2ce0d2394f96f1b3.camel@siemens.com>
Subject: Re: [PATCH Dovetail v3] irq_pipeline: Fix system freeze triggered
 by edge IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 10 Sep 2025 23:36:42 +0200
In-Reply-To: <87ecsexdu6.fsf@xenomai.org>
References: 
	<20250820-wip-flo-fix-edge-irq-handling-v3-1-8cc08939e6ca@siemens.com>
		<87v7lqydag.fsf@xenomai.org>
		<70fc78203891494dc3aac1b8b4869a050485fc1c.camel@siemens.com>
	 <87ecsexdu6.fsf@xenomai.org>
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

On Wed, 2025-09-10 at 22:16 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Wed, 2025-09-10 at 09:31 +0200, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > When IRQ pipelining is enabled, it could happen that handle_edge_ir=
q()
> > > > is interrupted while syncing the IRQ log - for the very same IRQ.
> > > >=20
> > > > The pipeline entry code will set the IRQS_PENDING flag and bail out
> > > > forcing the sync code (lower part in handle_edge_irq()) to loop to
> > > > infinity as the (periodic) IRQ might fire again after calling
> > > > unmask_irq() and reaching the hard IRQ enablement in handle_irq_eve=
nt().
> > > >=20
> > > > There is a "race window" involved. To trigger looping to infinity t=
he
> > > > IRQ(s) must arrive while processing the IRQ log for the same IRQ in
> > > > handle_irq_event().
> > > >=20
> > > > Call graph, delivered by a modified NMI handler and NMI injected by
> > > > hyper-v:
> > > > [    5.929380] Call Trace:
> > > > [    5.929381]  <NMI>
> > > > [    5.929383]  default_do_nmi+0xd9/0x110
> > > > [    5.929387]  exc_nmi+0xde/0x110
> > > > [    5.929388]  end_repeat_nmi+0xf/0x53
> > > > [    5.929390] RIP: 0010:mask_ioapic_irq+0x86/0xf0
> > > > [    5.929392] Code:
> > > > [    5.929392] RSP: 0000:ffffa1c680003e48 EFLAGS: 00010086
> > > > [    5.929393] RAX: ffffffffff5fc000 RBX: 0000000000000086 RCX: fff=
f8e4f01049340
> > > > [    5.929393] RDX: 0000000000203000 RSI: 0000000000010030 RDI: 000=
0000000000014
> > > > [    5.929394] RBP: ffff8e4f01049320 R08: 0000000000000012 R09: 000=
0000000000001
> > > > [    5.929394] R10: 0000000000000000 R11: 770e017136e49082 R12: fff=
fffffac506000
> > > > [    5.929395] R13: ffff8e4f3ec49840 R14: 0000000000000000 R15: 000=
0000000000000
> > > > [    5.929402]  </NMI>
> > > > [    5.929402]  <IRQ>
> > > > [    5.929402]  handle_edge_irq+0x300/0x320
> > > > [    5.929405]  generic_pipeline_irq_desc+0xc2/0x220
> > > > [    5.929408]  arch_handle_irq+0x5d/0x180
> > > > [    5.929410]  arch_pipeline_entry+0x38/0xf0
> > > > [    5.929413]  asm_common_interrupt+0x22/0x40
> > > > [    5.929421]  handle_irq_event+0xbe/0xe0
> > > > [    5.929424]  handle_edge_irq+0x1ec/0x320
> > > > [    5.929425]  arch_do_IRQ_pipelined+0xa5/0x560
> > > > [    5.929427]  </IRQ>
> > > > [    5.929427]  <TASK>
> > > > [    5.929428]  sync_current_irq_stage+0x191/0x240
> > > > [    5.929430]  __inband_irq_enable+0x48/0x60
> > > > [    5.929431]  setup_IO_APIC+0x36b/0x860
> > > > [    5.929434]  ? ioapic_read_entry+0x1a/0x80
> > > > [    5.929436]  ? clear_IO_APIC_pin+0x1d/0x240
> > > > [    5.929437]  ? clear_IO_APIC_pin+0x190/0x240
> > > > [    5.929440]  apic_intr_mode_init+0x6f/0xf0
> > > > [    5.929441]  x86_late_time_init+0x20/0x40
> > > > [    5.929442]  start_kernel+0x743/0x890
> > > > [    5.929445]  x86_64_start_reservations+0x14/0x30
> > > > [    5.929446]  x86_64_start_kernel+0xc1/0xd0
> > > > [    5.929447]  common_startup_64+0x13e/0x148
> > > > [    5.929452]  </TASK>
> > > >=20
> > > > Enabling some debug options like CONFIG_PROVE_LOCKING widens this
> > > > window as execution time increases.
> > > >=20
> > > > If we detect that the very same IRQ line is currently processed whi=
le we
> > > > receive another hard irq, the current event is logged into the IRQ =
log.
> > > > The event gets replayed within the same sync run in
> > > > sync_current_irq_stage().
> > > >=20
> > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > ---
> > > > ---
> > > > Changes in v3:
> > > > - Introduce irq_active_on_this_cpu()=20
> > > > - Link to v2: https://lore.kernel.org/r/20250820-wip-flo-fix-edge-i=
rq-handling-v2-1-1a958d17eace@siemens.com
> > > >=20
> > > > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > > > index f5dfc378ccf2..12b820c99bb9 100644
> > > > --- a/kernel/irq/chip.c
> > > > +++ b/kernel/irq/chip.c
> > > > @@ -639,6 +639,26 @@ static inline bool should_feed_pipeline(struct=
 irq_desc *desc, int state)
> > > >  	return false;
> > > >  }
> > > > =20
> > > > +static bool irq_active_on_this_cpu(struct irq_desc *desc)
> > > > +{
> > > > +	struct irq_data *data =3D &desc->irq_data;
> > > > +	const struct cpumask *aff;
> > > > +
> > >=20
> > >         if (!IS_ENABLED(CONFIG_SMP))
> > >                 return true;
> >=20
> > - That would make the function name somehow "incorrect".
> >=20
> > - irq_active_on_this_cpu() was designed to return true only for one
> >   very specific case: pipeline entry for an edge triggered IRQ while
> >   synchronizing the very same IRQ line on the same CPU.
> >=20
>=20
> irq_active_on_this_cpu() is expected to be called only after
> IRQD_IRQ_INPROGRESS was found in the descriptor,=C2=A0
>=20

Good point. That allows us to drop=20
	/* Check if active on any CPU */
	if (!irqd_irq_inprogress(data))
		return false;

It's always in progress, guaranteed by the caller.

> therefore if
> !CONFIG_SMP in addition, we do have an interrupt in progress on the only
> CPU available on the system, i.e. the current one. If we don't yield
> true in this case, I can't see how this would fix the issue at stake for
> uniprocessor hardware.

I double checked irq_data_get_effective_affinity_mask() again. My=20
understanding is that this will simply return 0, which is equal to
smp_processor_id() on a uniprocessor system, so we would yield true at
the end.

The !SMP check is valid, as long as other flow handlers are not
confused. Should be fine and might be an optimization for those
systems. I will keep it.

In addition v4 will have a #ifdef CONFIG_IRQ_PIPELINE guard around=20
irq_active_on_this_cpu() to avoid a warning in !CONFIG_IRQ_PIPELINE
case.

v4 will be posted after some over-night stress tests.

>=20
> >   The caller (irq_can_handle_pm()) is also involved in non-edge IRQ=20
> >   handling which makes me nervous. Was that on your radar?
> >=20
>=20
> I think those are ok since only the flow handler for edge irqs polls
> IRQS_PENDING, which is the root of the issue.
>=20
> > - I think that !CONFIG_SMP is handled correctly - at least for edge
> >   IRQS - as the effective CPU mask should be 0 and equal to=20
> >   smp_processor_id()
>=20
> --=20
> Philippe.
