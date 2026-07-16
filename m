Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1A3BE650
	for <xenomai@lists.linux.dev>; Thu, 16 Jul 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188487; cv=none; b=av7mjpJeXO1jGl6q3sCVE03fkPAXYTUYXAvSk9AqeiJghAim+BOnOQhMSzbPs2nWXITVhbN3BHL4d+UYGfuyifl4k8rZE2MMBDzfnzB5mfQDY2wbmk9v8VN7Rs2QUgNkev8M6ysfgVKtVwtoQl8R+F+f5cs/kTyeC+IoQrBjcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188487; c=relaxed/simple;
	bh=WcUJQ08zg0RvEUBjHoRshJk4xm0bmQ+pPCWuvmsftBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XvNIdGmknXQc9YTZpu3SbQ5beGTgaOmAYDcZjpP+40JyugNm4zdHTaKphzwmt9cYktdtGjlmv40mQr0GUYBm+csJpoNHjwWT6g1x5b7YtznKOWrPe5xSZfR7brs+E7IMXanSCBU/UKhYd/qs37hvQb3uBmGfPBr9B0LXfVCvjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YxKHrybV; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YxKHrybV"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260716075430dd9d4daffd00020700
        for <xenomai@lists.linux.dev>;
        Thu, 16 Jul 2026 09:54:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4F46VEKKE76kjpLeeheH3soZMfvMKGPrVtymFzgajdw=;
 b=YxKHrybVtv9Vqo4yAkQES2kitbCt8E9CrvWF2gWkgm6P20zZLMo/XbYn3IHG9bV9RbvVl/
 MsrCItmVm6kalvAQ2idzOjl0jINIr6uKohYRGBxTKyR9rxp/bDPv+jeewUI/2w3pHh4JD+lo
 wtvKL53IgIgPbNWQe3j7MM+S63mvKvYIHq5BQMbV1aoLsHGmuNKLffW/w5UOTHRKpzqlfYpX
 KNDZxCt8Nd/yzkcrDMTDRqW5xZkDbe9/a8mrS5H7bqBuJ62N/gWjXLL333cu7Ua4PzbKGl5x
 3t8pyGOQ10asy4sRK7mMc3AJwAj9m/WLHF4TtG2XK3FEWetuLY2+rCtg==;
Message-ID: <677ed0b439c80f3e8377ee51a5bcd6b96f5cd0de.camel@siemens.com>
Subject: Re: [PATCH v2] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: linz <powertree@163.com>
Cc: Philippe Gerum <rpm@xenomai.org>, "jan.kiszka@siemens.com"
	 <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Thu, 16 Jul 2026 09:54:30 +0200
In-Reply-To: <feebd79f4099b3e917b0e094a1342444fe0093f1.camel@siemens.com>
References: <517534d7.8863.19efe1f45f1.Coremail.powertree@163.com>
		 <ad8e6855-2d67-49a4-9a52-9819b93b1802@siemens.com>
		 <023fa6882b563713cbcc06bd954c8e9db4200d73.camel@siemens.com>
		 <c017bc0.9041.19f5afdb56f.Coremail.powertree@163.com>
		 <6ca12451-a015-4b54-9e22-0256e97d834e@siemens.com>
		 <55bf6b7f.363a.19f5eb8aece.Coremail.powertree@163.com>
	 <feebd79f4099b3e917b0e094a1342444fe0093f1.camel@siemens.com>
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

On Thu, 2026-07-16 at 09:27 +0200, Florian Bezdeka wrote:
> On Tue, 2026-07-14 at 11:43 +0800, linz wrote:
> > Thank you for your feedback
>=20
> Welcome, but that shoudn't be part of the patch description.
>=20
> >=20
> > Under 6.6.63-dovetail2 environment, raw_spinlock_t for the ITS node loc=
k triggers out=E2=80=91of=E2=80=91band context warning in irq=E2=80=91pipel=
ine code.
> > As suggested by Florian, hybrid_spinlock_t should be limited to struct =
irq_desc and irqchip internals. ITS node lock is more suitable to use hard_=
spinlock_t.
> >=20
> > After replacing raw_spinlock_t with hard_spinlock_t, the call=E2=80=91t=
race warning disappears and system runs stably.
>=20
> Which warning? That should be part of the problem description here.
> (I know that it was part of some previous report/patch)
>=20
> >=20
> > In addition, the gic=E2=80=91v3 irqchip already has IRQCHIP_PIPELINE_SA=
FE flag, while its_irq_chip lacks this flag.
> > Enabling IRQCHIP_PIPELINE_SAFE for its_irq_chip has no effect to resolv=
e the warning.
>=20
> To my understanding gic-v3-its is kind of an extension to the gic-v3, so
> that gic-v3-its doesn't need to be flagged with IRQCHIP_PIPELINE_SAFE on
> its own. That part should be fine.
>=20
> The main question for me: Is it an invalid code path that we take or is
> the oob stage not properly synchronized with the inband code? I will try
> to find some time to look at this again. Meanwhile:
>=20
> Philippe, any comment on that?

I revisited v1 right ahead now. Link below.

I'm now quite sure that v2 is correct - code wise - but we should work
on a proper patch description. The description of v1 was quite good.

The raw_spinlock triggers a inband stage check that fires the warning
that was also part of v1. So we have a oob code path (hard IRQ masking)
using an inband only spinlock API. That's wrong and has to be fixed as
done in v2.

v1:
https://lore.kernel.org/xenomai/6ca12451-a015-4b54-9e22-0256e97d834e@siemen=
s.com/T/


Proposal for v3 patch description:

The warning shown below could be observed on dovetail 6.6.

The reason is the usage of a a raw_spinlock_t in hard IRQ masking code
path. A migration to hard_spinlock_t fixes this issue.

[    1.510903] IRQ pipeline: some code running in oob context 'Xenomai'
                             called an in-band only routine
[    1.510912] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S                 6=
.6.63-dovetail2 #8
[    1.510918] Hardware name: Pe2204 DEMO DDR4 (DT)
[    1.510920] IRQ stage: Xenomai
[    1.510923] Call trace:
[    1.510926]  dump_backtrace+0x90/0xe4
[    1.510940]  show_stack+0x14/0x1c
[    1.510946]  dump_stack_lvl+0x84/0xc8
[    1.510953]  dump_stack+0x14/0x1c
[    1.510957]  check_inband_stage+0xb0/0xc8
[    1.510965]  inband_irq_save+0xc/0x28
[    1.510971]  _raw_spin_lock_irqsave+0x14/0x90
[    1.510977]  its_send_single_command+0x24/0x154
[    1.510984]  lpi_update_config+0x9c/0x144
[    1.510990]  its_mask_irq+0x2c/0x64
[    1.510997]  irq_chip_mask_parent+0x18/0x20
[    1.511005]  its_mask_msi_irq+0x1c/0x28
[    1.511012]  handle_fasteoi_irq+0x1cc/0x2b4
[    1.511016]  generic_pipeline_irq_desc+0x6c/0xa4
[    1.511021]  generic_handle_domain_irq+0x18/0x20
[    1.511028]  gic_handle_irq+0x4c/0x120
[    1.511032]  handle_irq_pipelined+0x40/0x64
[    1.511038]  call_on_irq_stack+0x24/0x30
[    1.511044]  do_interrupt_handler+0x138/0x158
[    1.511050]  el1_interrupt+0x40/0x110
[    1.511055]  el1h_64_irq_handler+0x14/0x1c
[    1.511061]  el1h_64_irq+0x64/0x68
[    1.511064]  default_idle_call+0x30/0x78
[    1.511071]  do_idle+0x128/0x150
[    1.511077]  cpu_startup_entry+0x34/0x38
[    1.511081]  kernel_init+0x0/0x1d4
[    1.511088]  arch_post_acpi_subsys_init+0x0/0x8
[    1.511096]  start_kernel+0x504/0x5cc
[    1.511103]  __primary_switched+0xbc/0xc4

>=20
> >=20
> > Signed-off-by: zhanglin <powertree@163.com>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic=
-v3-its.c
> > index 0e57735eac..3f2b02b8f4 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -94,7 +94,7 @@ struct its_device;
> >   * list.
> >   */
> >  struct its_node {
> > -	raw_spinlock_t		lock;
> > +	hard_spinlock_t		lock;
> >  	struct mutex		dev_alloc_lock;
> >  	struct list_head	entry;
> >  	void __iomem		*base;
> > --=20
> > 2.34.1
