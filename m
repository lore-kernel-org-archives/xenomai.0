Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE828D83D
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492155; cv=none; b=syYlKOXjYRzIVxUh9SvgMkCugRuZp9kgVRO7WT8c6T/0NJaqBcBydBiqzU2MnsE4tXHz4s6YJK2JTI4uizbBVoKggLifKF4t9SFcT1c7eYI+Vo2t6Q3BWUBQ9e9hSmmmOjmwUgwrCytqikWiCMFfAgm2UFWABYGqjKRAoFMaqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492155; c=relaxed/simple;
	bh=emhiN3mup1iSFMV7aQeLF4f/8XRxMIIykjwnnKcX1VM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsCXLLvZUBArcOLRARTm0XDjfxQ5BhAWOOdOp2BfHEXlPBZm7qGrRBwx9NUPKWbLiPlCTSSZ8/GoEJxJ9D5HCJBgx5S83QNSpTpaCe6Pi965QUsjkVp/UnE3HzjHkOkQj8sRKqFY6n60/Q7TZOCVsLD71ofHt2B3EUf9S6kNxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=pVYpuZg3; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="pVYpuZg3"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250910081538a4f86a4f79000207dd
        for <xenomai@lists.linux.dev>;
        Wed, 10 Sep 2025 10:15:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Q+qJ4iE9Jzmq/caRHiAKJfAI88iHuHNdJePF/cNbB6o=;
 b=pVYpuZg3+8g8kAAUo8kkBNxExoAjl2jqiUIFvd/MJQmxzMks6HsR2JGgFjFKAoM/yQlN7D
 AxC9PO83F2A+rbno200il0WUC7U7YGudPY0vPHGVIsB8q5Rm/Q0PT0KH6kSNHcRRwR5Nv/VE
 ib+GWQ6I5z9MUI25QVSLyZI2LmEgNcI1KvyP/5bUJZzuwcycGNBQuV0uWCzO8bw6rj93tQdv
 8NyNa4F++Frr7MexeQj9b9oFr0dSIU4H0VaarQvdauHgUV69t8Ap5Efo0idEM5hYenzi18+e
 Tr36tyNogLdIA3NKaxS91ROJpkrP59cwi6d8uTQZjeYegrNa0B7yHWlQ==;
Message-ID: <70fc78203891494dc3aac1b8b4869a050485fc1c.camel@siemens.com>
Subject: Re: [PATCH Dovetail v3] irq_pipeline: Fix system freeze triggered
 by edge IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 10 Sep 2025 10:15:38 +0200
In-Reply-To: <87v7lqydag.fsf@xenomai.org>
References: 
	<20250820-wip-flo-fix-edge-irq-handling-v3-1-8cc08939e6ca@siemens.com>
	 <87v7lqydag.fsf@xenomai.org>
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

On Wed, 2025-09-10 at 09:31 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > When IRQ pipelining is enabled, it could happen that handle_edge_irq()
> > is interrupted while syncing the IRQ log - for the very same IRQ.
> >=20
> > The pipeline entry code will set the IRQS_PENDING flag and bail out
> > forcing the sync code (lower part in handle_edge_irq()) to loop to
> > infinity as the (periodic) IRQ might fire again after calling
> > unmask_irq() and reaching the hard IRQ enablement in handle_irq_event()=
.
> >=20
> > There is a "race window" involved. To trigger looping to infinity the
> > IRQ(s) must arrive while processing the IRQ log for the same IRQ in
> > handle_irq_event().
> >=20
> > Call graph, delivered by a modified NMI handler and NMI injected by
> > hyper-v:
> > [    5.929380] Call Trace:
> > [    5.929381]  <NMI>
> > [    5.929383]  default_do_nmi+0xd9/0x110
> > [    5.929387]  exc_nmi+0xde/0x110
> > [    5.929388]  end_repeat_nmi+0xf/0x53
> > [    5.929390] RIP: 0010:mask_ioapic_irq+0x86/0xf0
> > [    5.929392] Code:
> > [    5.929392] RSP: 0000:ffffa1c680003e48 EFLAGS: 00010086
> > [    5.929393] RAX: ffffffffff5fc000 RBX: 0000000000000086 RCX: ffff8e4=
f01049340
> > [    5.929393] RDX: 0000000000203000 RSI: 0000000000010030 RDI: 0000000=
000000014
> > [    5.929394] RBP: ffff8e4f01049320 R08: 0000000000000012 R09: 0000000=
000000001
> > [    5.929394] R10: 0000000000000000 R11: 770e017136e49082 R12: fffffff=
fac506000
> > [    5.929395] R13: ffff8e4f3ec49840 R14: 0000000000000000 R15: 0000000=
000000000
> > [    5.929402]  </NMI>
> > [    5.929402]  <IRQ>
> > [    5.929402]  handle_edge_irq+0x300/0x320
> > [    5.929405]  generic_pipeline_irq_desc+0xc2/0x220
> > [    5.929408]  arch_handle_irq+0x5d/0x180
> > [    5.929410]  arch_pipeline_entry+0x38/0xf0
> > [    5.929413]  asm_common_interrupt+0x22/0x40
> > [    5.929421]  handle_irq_event+0xbe/0xe0
> > [    5.929424]  handle_edge_irq+0x1ec/0x320
> > [    5.929425]  arch_do_IRQ_pipelined+0xa5/0x560
> > [    5.929427]  </IRQ>
> > [    5.929427]  <TASK>
> > [    5.929428]  sync_current_irq_stage+0x191/0x240
> > [    5.929430]  __inband_irq_enable+0x48/0x60
> > [    5.929431]  setup_IO_APIC+0x36b/0x860
> > [    5.929434]  ? ioapic_read_entry+0x1a/0x80
> > [    5.929436]  ? clear_IO_APIC_pin+0x1d/0x240
> > [    5.929437]  ? clear_IO_APIC_pin+0x190/0x240
> > [    5.929440]  apic_intr_mode_init+0x6f/0xf0
> > [    5.929441]  x86_late_time_init+0x20/0x40
> > [    5.929442]  start_kernel+0x743/0x890
> > [    5.929445]  x86_64_start_reservations+0x14/0x30
> > [    5.929446]  x86_64_start_kernel+0xc1/0xd0
> > [    5.929447]  common_startup_64+0x13e/0x148
> > [    5.929452]  </TASK>
> >=20
> > Enabling some debug options like CONFIG_PROVE_LOCKING widens this
> > window as execution time increases.
> >=20
> > If we detect that the very same IRQ line is currently processed while w=
e
> > receive another hard irq, the current event is logged into the IRQ log.
> > The event gets replayed within the same sync run in
> > sync_current_irq_stage().
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> > ---
> > Changes in v3:
> > - Introduce irq_active_on_this_cpu()=20
> > - Link to v2: https://lore.kernel.org/r/20250820-wip-flo-fix-edge-irq-h=
andling-v2-1-1a958d17eace@siemens.com
> >=20
> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > index f5dfc378ccf2..12b820c99bb9 100644
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -639,6 +639,26 @@ static inline bool should_feed_pipeline(struct irq=
_desc *desc, int state)
> >  	return false;
> >  }
> > =20
> > +static bool irq_active_on_this_cpu(struct irq_desc *desc)
> > +{
> > +	struct irq_data *data =3D &desc->irq_data;
> > +	const struct cpumask *aff;
> > +
>=20
>         if (!IS_ENABLED(CONFIG_SMP))
>                 return true;

- That would make the function name somehow "incorrect".

- irq_active_on_this_cpu() was designed to return true only for one
  very specific case: pipeline entry for an edge triggered IRQ while
  synchronizing the very same IRQ line on the same CPU.

  The caller (irq_can_handle_pm()) is also involved in non-edge IRQ=20
  handling which makes me nervous. Was that on your radar?

- I think that !CONFIG_SMP is handled correctly - at least for edge
  IRQS - as the effective CPU mask should be 0 and equal to=20
  smp_processor_id()


>               =20
> > +	/* Check if active on any CPU */
> > +	if (!irqd_irq_inprogress(data))
> > +		return false;
> > +
> > +	/* The below works only for single target interrupts */
> > +	if (!irqd_is_single_target(data) || desc->handle_irq !=3D handle_edge=
_irq)
> > +		return false;
> > +
> > +	aff =3D irq_data_get_effective_affinity_mask(data);
> > +	if (cpumask_first(aff) !=3D smp_processor_id())
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  static bool irq_can_handle_pm(struct irq_desc *desc)
> >  {
> >  	unsigned int mask =3D IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
> > @@ -669,6 +689,8 @@ static bool irq_can_handle_pm(struct irq_desc *desc=
)
> >  		WARN_ON_ONCE(irq_pipeline_debug() && !in_pipeline());
> >  		if (irqd_is_wakeup_armed(&desc->irq_data))
> >  			return true;
> > +		if (irq_active_on_this_cpu(desc))
> > +			return true;
> >  	} else if (irq_pm_check_wakeup(desc))
> >  		return false;
> > =20
> >=20
> > ---
> > base-commit: fd7ae0eaafd268a5d1cbc2876d6cbe2a284b0d8c
> > change-id: 20250820-wip-flo-fix-edge-irq-handling-16e48193aeac
> >=20
> > Best regards,
>=20
> LGTM. Checking the arm* implementation, system peripheral interrupts
> which are the ones we need to care about in this case are all set as
> single targeted by the interrupt controller driver, so we would properly
> check the effective affinity mask as expected.

Nice. Thanks!

>=20
> --=20
> Philippe.
