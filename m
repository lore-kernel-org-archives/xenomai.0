Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55433307AC6
	for <xenomai@lists.linux.dev>; Mon,  3 Aug 2026 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769057; cv=none; b=JBHW/QX9eLtB/giylevsNDdNZpckWIkkAseCABU4aZbF+aWdoMJ6KFbsIHXgrh0zdMrvadPiphgdsAyM+ddbx7lMEAzyrq+wvHKMPQ19/mPGNWrr/LI36SR7IsMz2+JTq1BN8z1Bz9OXL+f+qreFz9AmI9qdVm7ONydhkUNEwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769057; c=relaxed/simple;
	bh=vDxBYnfvmLombQAyyZTjpQ5Y47OOARkGW9UXKoaKoEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hHym/eFPHC9EFlAKOYrA6FRD8zn1eGaoy2OYep7ITyvxCA03G6adspcj5CnLCQyh5iqnMvTKQ1ncqjbL8l9sbb2lXCYZQALqqM7ev3rcrqjBFm+t9wo4MjdWPjMbpctb91Fj0E+HZmZtbdYneos+iAvpsbZmWaXHdNBnUCvyPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=VR2Rp6K4; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="VR2Rp6K4"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260803145145683a1f295500020742
        for <xenomai@lists.linux.dev>;
        Mon, 03 Aug 2026 16:51:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/nVFAycW5BYmthHVlg5UqmuThxj5ebVcW2g2UVhEq+Q=;
 b=VR2Rp6K4CKzjR93buGB5cPCNZ+egp3JofU7v02BKkYEwnbImvuN4btF2HhNBxOvouNx73K
 KROwnB3vKBxVEAYEhCIALrRewl2x2QMmeAAg8HA28+CvmiY0wX0kTzz9M8AZbPb0cYhUVPTd
 /PTN05u5X/+FitWzbw50SXuISGerliRxJNTmZj73YAzEqFSQc37088VzTqaJUvIRxmqEEyS2
 eEcfyfWh5Is3jYBKMUWarLRQL4CUtZclX0deDqvCFPTyjNAMBr+eupNqn/hCeg7xyuryCgMP
 s0m7SvXZEAyu1N9Ifpfut67Uq8VPdov8Jfi9kqy6FbEjimehRe8nMaCg==;
Message-ID: <0d51e4231b17465c9e946d8e63dc3c39074276ed.camel@siemens.com>
Subject: Re: [PATCH v3] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, linz <powertree@163.com>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, 
 "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Mon, 03 Aug 2026 16:51:45 +0200
In-Reply-To: <87bjbxzquj.fsf@xenomai.org>
References: <30686e71.2228.19f6df11b6e.Coremail.powertree@163.com>
	 <87bjbxzquj.fsf@xenomai.org>
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

On Thu, 2026-07-23 at 17:08 +0200, Philippe Gerum wrote:
> linz <powertree@163.com> writes:
>=20
> > The warning shown below could be observed on dovetail 6.6 with arm64
> > architecture when CONFIG_DEBUG_IRQ_PIPELINE is enabled.
> >=20
> > The reason is the usage of a raw_spinlock_t in hard IRQ masking code
> > path. A migration to hard_spinlock_t fixes this issue.
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
>=20
> This is correct, but we need more changes for this irqchip driver,
> particularly for handlers mentioned by this document [1], like irq_mask,
> irq_unmask.
>=20
> For instance, anything which calls lpi_update_config() needs to be made
> oob-capable, so it looks like gic_data_rdist_cpu(cpu)->rd_lock needs
> care too.

Agreed.

Btw: There is a difference in the display name between the mail address
used for sending (From: header) and the Signed-off-by: tag. So I'm not
sure about the greeting ;-)

linz/zhanglin, do you plan to address the comments from Philippe?

Best regards,
Florian


