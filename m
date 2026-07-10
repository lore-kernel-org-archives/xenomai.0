Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFD8411664
	for <xenomai@lists.linux.dev>; Fri, 10 Jul 2026 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681162; cv=none; b=Qir0YxwPTmVtOFQmbTBJXSOZ1nSvzbiO82abphMCtRoCrr0VhT0VTyHV4vF4P6HCfBPl3c9Ao/tpiPHsAQHv65Q0sIzGb4ISkx0B+CS6XrYThKWJG7OxhkL02uhJqRLB0yYeSXEpH6dpU3wA25EtXUwcB8u/72NzvozekRFb4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681162; c=relaxed/simple;
	bh=AVwLKl7jN+SoofIPdkdBpi4wDOidRSN1VYjgI3jZnWM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPaRVZsd8scn0NP7DGFrkFnbmm/l6AOSlbPwhFLiCSrJcftSvVQPMJe8KZWQSPbeBfAQu6GFgJlrZ/wfrdX0W6uxBVagIleTVYCsvaoVZ4+ORkUldCegbpX49f8cd8riPPeS9e/AykhXjbvXDTUU0ZeXvXrEpmBXCM5ruj7qUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=iJ1NvKt1; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="iJ1NvKt1"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026071010590812f678d25b00020762
        for <xenomai@lists.linux.dev>;
        Fri, 10 Jul 2026 12:59:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=AVwLKl7jN+SoofIPdkdBpi4wDOidRSN1VYjgI3jZnWM=;
 b=iJ1NvKt152zXyp12phvobyVYAvzbNkdOycP6HFuKoh8pB/xvp5HvW+br+tsFb85QAdhnGR
 vTpws2HqBuInBYbtA7tMJlUsI7tLl5IxQNtpZjkTyuI8mXzcvQ149O2nXQUPrJPRDozag5Pg
 Qd0bI9peGMlz79CNjfhHBXe430Y1fpRZe08OEyQBL0lXFozg9PM/mJfbbaxETugd+FWm5sL5
 7pWPKIQw+/qWjlcceL561+C4fQjOxm2Kx62kSvZAoXXRO0iE4lTN2sW9oX5zmnZxmFObOpF3
 5QcTLTs7qkbcCj3PXyQTfPv4uFkox1oX2KNTEH5IFHPsO8zb6j7yiBZg==;
Message-ID: <023fa6882b563713cbcc06bd954c8e9db4200d73.camel@siemens.com>
Subject: Re: [PATCH] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, linz <powertree@163.com>, Philippe
 Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
Date: Fri, 10 Jul 2026 12:59:08 +0200
In-Reply-To: <ad8e6855-2d67-49a4-9a52-9819b93b1802@siemens.com>
References: <517534d7.8863.19efe1f45f1.Coremail.powertree@163.com>
	 <ad8e6855-2d67-49a4-9a52-9819b93b1802@siemens.com>
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

On Fri, 2026-07-10 at 12:12 +0200, Jan Kiszka wrote:
> On 25.06.26 11:32, linz wrote:
> > Hi, I find a call trace when I use v6.6.y-dovetail + xenomai v3.3 branc=
h, the call trace is as follows
> >=20
> > [=C2=A0 =C2=A0 1.510903] IRQ pipeline: some code running in oob context=
 'Xenomai'
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0called an in-band only routine
> > [=C2=A0 =C2=A0 1.510912] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.6.63-dovetail2=
 #8
> > [=C2=A0 =C2=A0 1.510918] Hardware name: Pe2204 DEMO DDR4 (DT)
> > [=C2=A0 =C2=A0 1.510920] IRQ stage: Xenomai
> > [=C2=A0 =C2=A0 1.510923] Call trace:
> > [=C2=A0 =C2=A0 1.510926]=C2=A0 dump_backtrace+0x90/0xe4
> > [=C2=A0 =C2=A0 1.510940]=C2=A0 show_stack+0x14/0x1c
> > [=C2=A0 =C2=A0 1.510946]=C2=A0 dump_stack_lvl+0x84/0xc8
> > [=C2=A0 =C2=A0 1.510953]=C2=A0 dump_stack+0x14/0x1c
> > [=C2=A0 =C2=A0 1.510957]=C2=A0 check_inband_stage+0xb0/0xc8
> > [=C2=A0 =C2=A0 1.510965]=C2=A0 inband_irq_save+0xc/0x28
> > [=C2=A0 =C2=A0 1.510971]=C2=A0 _raw_spin_lock_irqsave+0x14/0x90
> > [=C2=A0 =C2=A0 1.510977]=C2=A0 its_send_single_command+0x24/0x154
> > [=C2=A0 =C2=A0 1.510984]=C2=A0 lpi_update_config+0x9c/0x144
> > [=C2=A0 =C2=A0 1.510990]=C2=A0 its_mask_irq+0x2c/0x64
> > [=C2=A0 =C2=A0 1.510997]=C2=A0 irq_chip_mask_parent+0x18/0x20
> > [=C2=A0 =C2=A0 1.511005]=C2=A0 its_mask_msi_irq+0x1c/0x28
> > [=C2=A0 =C2=A0 1.511012]=C2=A0 handle_fasteoi_irq+0x1cc/0x2b4
> > [=C2=A0 =C2=A0 1.511016]=C2=A0 generic_pipeline_irq_desc+0x6c/0xa4
> > [=C2=A0 =C2=A0 1.511021]=C2=A0 generic_handle_domain_irq+0x18/0x20
> > [=C2=A0 =C2=A0 1.511028]=C2=A0 gic_handle_irq+0x4c/0x120
> > [=C2=A0 =C2=A0 1.511032]=C2=A0 handle_irq_pipelined+0x40/0x64
> > [=C2=A0 =C2=A0 1.511038]=C2=A0 call_on_irq_stack+0x24/0x30
> > [=C2=A0 =C2=A0 1.511044]=C2=A0 do_interrupt_handler+0x138/0x158
> > [=C2=A0 =C2=A0 1.511050]=C2=A0 el1_interrupt+0x40/0x110
> > [=C2=A0 =C2=A0 1.511055]=C2=A0 el1h_64_irq_handler+0x14/0x1c
> > [=C2=A0 =C2=A0 1.511061]=C2=A0 el1h_64_irq+0x64/0x68
> > [=C2=A0 =C2=A0 1.511064]=C2=A0 default_idle_call+0x30/0x78
> > [=C2=A0 =C2=A0 1.511071]=C2=A0 do_idle+0x128/0x150
> > [=C2=A0 =C2=A0 1.511077]=C2=A0 cpu_startup_entry+0x34/0x38
> > [=C2=A0 =C2=A0 1.511081]=C2=A0 kernel_init+0x0/0x1d4
> > [=C2=A0 =C2=A0 1.511088]=C2=A0 arch_post_acpi_subsys_init+0x0/0x8
> > [=C2=A0 =C2=A0 1.511096]=C2=A0 start_kernel+0x504/0x5cc
> > [=C2=A0 =C2=A0 1.511103]=C2=A0 __primary_switched+0xbc/0xc4
> >=20
> >=20
> > The function call causing the issue is as follows:
> > generic_handle_domain_irq
> > =C2=A0 =C2=A0 =3D> generic_pipeline_irq_desc
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D> generic_handle_irq_desc
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D> handle_fasteoi_irq
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D> mask_cond_=
eoi_irq
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D> mask_irq
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D> its_mask_msi_irq
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D> irq_chip_mask_parent
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D> its_mask_irq
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D> lpi_update_con=
fig
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D> =
its_send_inv
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D> BUILD_SINGLE_CMD_FUNC
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D> raw_spin_lock_irqsave(&its->lock, flags);
> >=20
> >=20
> > On Dovetail-enabled kernels with Xenomai IRQ pipeline, GICv3 ITS interr=
upt handling runs in OOB (out-of-band) interrupt context. The original raw_=
spinlock_t used for its_node->lock invokes the standard in-band-only raw_sp=
in_lock_irqsave() interface.
> > This triggers the following pipeline context violation warning: IRQ pip=
eline: some code running in oob context 'Xenomai' called an in-band only ro=
utine
> >=20
> > raw_spin_lock_irqsave() is an in-band exclusive API and cannot be safel=
y called from Xenomai OOB interrupt context, which violates the IRQ pipelin=
e isolation rules.
> >=20
> > I think that fix this by replacing raw_spinlock_t with hybrid_spinlock_=
t for the ITS node lock. The hybrid spinlock supports both in-band Linux ke=
rnel context and OOB Xenomai pipeline context, adapting lock/irqsave logic =
dynamically according to the running context, eliminating the context misma=
tch warning while guaranteeing lock mutual exclusion.
> >=20
> > The fixed up patch is as follows:
> >=20
> > From 1037fcf6d75ecf37e1caf283d1198177e7410be3 Mon Sep 17 00:00:00 2001
> > From: zhanglin <powertree@163.com>
> > Date: Thu, 25 Jun 2026 16:56:31 +0800
> > Subject: [PATCH] irqchip: gic-v3-its: irq_pipeline: fix OOB context in-=
band
> > =C2=A0lock warning for ITS lock
> >=20
> > ---
> > =C2=A0drivers/irqchip/irq-gic-v3-its.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic=
-v3-its.c
> > index 0e57735eac..847b008b71 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -94,7 +94,7 @@ struct its_device;
> > =C2=A0 * list.
> > =C2=A0 */
> > =C2=A0struct its_node {
> > -=C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 lock;
> > +=C2=A0 =C2=A0 hybrid_spinlock_t=C2=A0 =C2=A0 =C2=A0lock;
> > =C2=A0 =C2=A0 =C2=A0struct mutex=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_alloc_l=
ock;
> > =C2=A0 =C2=A0 =C2=A0struct list_head=C2=A0 =C2=A0 entry;
> > =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 *base;
> > --=C2=A0
> > 2.34.1
> >=20
> > Please help to review it, thank you.
>=20
> Thanks for reporting.
>=20
> Philippe, Florian, any comments on this?
>=20
> Jan

hybrid_spinlock_t doesn't look right at first glance, it's use should be
limited to struct irq_desc and IRQ chips. I would have expected
hard_spinlock_t, but I might miss something.

Assuming the gic-v3 IRQ chip is already marked / flagged as
IRQCHIP_PIPELINE_SAFE, right?

Florian

