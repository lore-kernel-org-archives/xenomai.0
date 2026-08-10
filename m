Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651537204E
	for <xenomai@lists.linux.dev>; Mon, 10 Aug 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347500; cv=none; b=KnKqG6hRfdmr+UcTvoPZVAQsyVtt7oGnT90cToVc8+JmpW4DkGWj6kd0C/OkYrpg3MtKdNP83YCaeJRGPHk2yKQY+jYwOpO3Pm2OWbfQGLe6uzge4TWKOmz+0/oa27IAlQxPuCQNYHZB3Mr8qqZp5XXXIQB341qWn4RD8VHNaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347500; c=relaxed/simple;
	bh=ao1AjSmpBJMBq5RCDN8O6eP4knCsVXODH6U2I0NZpQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cnw56eig2GQ09QfYJHTzj6TV2slgDw42J6Q41vBOqBxLSydB6qH40bqjiiwo/cI4IovOTiljKCoSjmzglsQKgEpZQuCWAjtWWWw38kYAJDmySPOTJ5YetyZau2HS1JdfYbcQDxLnbrMNyqJ6JN/eKtWuh5SjKNIcFe6FScbq0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=JiikNe4t; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="JiikNe4t"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B6403EBC8;
	Mon, 10 Aug 2026 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1786347489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZCpx18x//jnAS7iHuXI3ZdCuIIwjLq76mREBjQXeCg=;
	b=JiikNe4t4uTzhSimjVyoWJkVHf8gxRyLaLz6kM+i4Svowo5j7YvwyvZCuaTW4n8X1yKr6s
	dCkA7nfsHVuhzGhLn+YCWrm/hjxvFu138aA+/16FIsPgW2V02aGkQAj/VoDLnfWCYrQC65
	P2+cvPPbB6gaxsLeE5J9kbb3IgrvUaYmNRtgbBzvMI2yQD0wErtQiHH3giAL2dps7yz22V
	IqBnFFN4Sh8q3dOLe4UQAg4t7J77zu22M8TrKP0VGOvodie0+K3v0I3S5gEA0A6h596Co0
	NSPBvrxHYHH4l/j2mWj58RFPeF5OjUzykk94k1yCH8e7dKZ2VKTowsQ9aAbkTg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: linz <powertree@163.com>,  jan.kiszka@siemens.com,  xenomai@lists.linux.dev
Subject: Re: [PATCH v4] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
In-Reply-To: <692f56b728b199b1d30b5a471e9be92cf6f0d50d.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 04 Aug 2026 11:58:01 +0200")
References: <3747c1b9.703e.19fcbfac7b2.Coremail.powertree@163.com>
	<e2a0f99724a2b5bd4591e704935b59acc672162c.camel@siemens.com>
	<4217319b.79c1.19fcc1bff5b.Coremail.powertree@163.com>
	<692f56b728b199b1d30b5a471e9be92cf6f0d50d.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 10 Aug 2026 09:38:07 +0200
Message-ID: <87jypyifxc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFkmSfNOXysSDm6AGeznPRS634dywOH00P932z9mwH4KURgUbioBboCYMb2usaWNx8YVNZq+1/4EsnNh+zbd5UPlMDmpfrSFOckCrntm0LNNsG/PSCp4B0BI3KHBprLquF18q/zlbzd448r2hehfcaD5WKXSY2kqu+C6QM6WFL6BxTkhUzaidpP3wLqOFpC+0GML2TAX9XmGUD6wbH7y/fWRVu/8EhOzWAFnUsjnZpGe9FMNwFMZSOnx3yguiCXtMg/pL4tXZ5qXODYqQ+cX1NCTX2c32ok/QDFUUJFTEBh5zqCh82KLM49Bx/Yta5d1hs4Nat+qxuq0gi/YBqNOU9mVzpuwKgLUNUc7xnXBNo1ahwmmD0BV0KqcXkYxUiqp1r6AiaYZCGS/+bq42PISzsSrQ1tfAhIhAYYIrG4kr9URY4D1sdRySAicbXfB4ERZr4m6Al83XuyLVUHGJW59UjYRQJIO/AcFOEQu1ZIls20hT0AAckktpLkcYwQTCXKtMV3Zjka59iBDuXapH6e5fVhPbtgiImPDaKDk95GGW8LRHjvcOTFMtWTg5BvxFmNPUiYYiPTK6xPv/cXOAfiGAjVTDsF8h/VZ40Ym9R+ykvYSIXro46ubsZZknjV13W7N3hzDT9EDo2A/4kQXfjh9nV3h/9rAqh2gwYcZXpO776C6w

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2026-08-04 at 17:30 +0800, linz wrote:
>> At 2026-08-04 16:59:00, "Florian Bezdeka" <florian.bezdeka@siemens.com> =
wrote:
>> > On Tue, 2026-08-04 at 16:53 +0800, linz wrote:
>> > > The warning shown below could be observed on Dovetail 6.6 with arm64
>> > > architecture when CONFIG_DEBUG_IRQ_PIPELINE is enabled.
>> > >=20
>> > > The reason is the usage of a raw_spinlock_t in hard IRQ masking code
>> > > path. A migration to hard_spinlock_t fixes this issue.
>> > >=20
>> > > [=C2=A0 =C2=A0 1.510903] IRQ pipeline: some code running in oob cont=
ext 'Xenomai'
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0called an in-band only routine
>> > > [=C2=A0 =C2=A0 1.510912] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.6.63-doveta=
il2 #8
>> > > [=C2=A0 =C2=A0 1.510918] Hardware name: Pe2204 DEMO DDR4 (DT)
>> > > [=C2=A0 =C2=A0 1.510920] IRQ stage: Xenomai
>> > > [=C2=A0 =C2=A0 1.510923] Call trace:
>> > > [=C2=A0 =C2=A0 1.510926]=C2=A0 dump_backtrace+0x90/0xe4
>> > > [=C2=A0 =C2=A0 1.510940]=C2=A0 show_stack+0x14/0x1c
>> > > [=C2=A0 =C2=A0 1.510946]=C2=A0 dump_stack_lvl+0x84/0xc8
>> > > [=C2=A0 =C2=A0 1.510953]=C2=A0 dump_stack+0x14/0x1c
>> > > [=C2=A0 =C2=A0 1.510957]=C2=A0 check_inband_stage+0xb0/0xc8
>> > > [=C2=A0 =C2=A0 1.510965]=C2=A0 inband_irq_save+0xc/0x28
>> > > [=C2=A0 =C2=A0 1.510971]=C2=A0 _raw_spin_lock_irqsave+0x14/0x90
>> > > [=C2=A0 =C2=A0 1.510977]=C2=A0 its_send_single_command+0x24/0x154
>> > > [=C2=A0 =C2=A0 1.510984]=C2=A0 lpi_update_config+0x9c/0x144
>> > > [=C2=A0 =C2=A0 1.510990]=C2=A0 its_mask_irq+0x2c/0x64
>> > > [=C2=A0 =C2=A0 1.510997]=C2=A0 irq_chip_mask_parent+0x18/0x20
>> > > [=C2=A0 =C2=A0 1.511005]=C2=A0 its_mask_msi_irq+0x1c/0x28
>> > > [=C2=A0 =C2=A0 1.511012]=C2=A0 handle_fasteoi_irq+0x1cc/0x2b4
>> > > [=C2=A0 =C2=A0 1.511016]=C2=A0 generic_pipeline_irq_desc+0x6c/0xa4
>> > > [=C2=A0 =C2=A0 1.511021]=C2=A0 generic_handle_domain_irq+0x18/0x20
>> > > [=C2=A0 =C2=A0 1.511028]=C2=A0 gic_handle_irq+0x4c/0x120
>> > > [=C2=A0 =C2=A0 1.511032]=C2=A0 handle_irq_pipelined+0x40/0x64
>> > > [=C2=A0 =C2=A0 1.511038]=C2=A0 call_on_irq_stack+0x24/0x30
>> > > [=C2=A0 =C2=A0 1.511044]=C2=A0 do_interrupt_handler+0x138/0x158
>> > > [=C2=A0 =C2=A0 1.511050]=C2=A0 el1_interrupt+0x40/0x110
>> > > [=C2=A0 =C2=A0 1.511055]=C2=A0 el1h_64_irq_handler+0x14/0x1c
>> > > [=C2=A0 =C2=A0 1.511061]=C2=A0 el1h_64_irq+0x64/0x68
>> > > [=C2=A0 =C2=A0 1.511064]=C2=A0 default_idle_call+0x30/0x78
>> > > [=C2=A0 =C2=A0 1.511071]=C2=A0 do_idle+0x128/0x150
>> > > [=C2=A0 =C2=A0 1.511077]=C2=A0 cpu_startup_entry+0x34/0x38
>> > > [=C2=A0 =C2=A0 1.511081]=C2=A0 kernel_init+0x0/0x1d4
>> > > [=C2=A0 =C2=A0 1.511088]=C2=A0 arch_post_acpi_subsys_init+0x0/0x8
>> > > [=C2=A0 =C2=A0 1.511096]=C2=A0 start_kernel+0x504/0x5cc
>> > > [=C2=A0 =C2=A0 1.511103]=C2=A0 __primary_switched+0xbc/0xc4
>> > >=20
>> > > Beyond that, note that IRQ chip handlers such as irq_mask / irq_unma=
sk run in
>> > > OOB context. For instance, any code path calling lpi_update_config()=
 must
>> > > be oob=E2=80=91capable, so gic_data_rdist_cpu(cpu)->rd_lock and its_=
vpe->vpe_lock are
>> > > modified in this patch.
>> > >=20
>> > > Convert:
>> > > - its_node->lock
>> > > - rdists.rd_lock
>> > > - its_vpe->vpe_lock
>> > > from raw_spinlock_t to hard_spinlock_t.
>> > >=20
>> > > Signed-off-by: linz <powertree@163.com>
>> > > ---
>> > > =C2=A0drivers/irqchip/irq-gic-v3-its.c=C2=A0 =C2=A0| 2 +-
>> > > =C2=A0include/linux/irqchip/arm-gic-v3.h | 2 +-
>> > > =C2=A0include/linux/irqchip/arm-gic-v4.h | 2 +-
>> > > =C2=A03 files changed, 3 insertions(+), 3 deletions(-)
>> > >=20
>> > > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-=
gic-v3-its.c
>> > > index 0e57735eac..3f2b02b8f4 100644
>> > > --- a/drivers/irqchip/irq-gic-v3-its.c
>> > > +++ b/drivers/irqchip/irq-gic-v3-its.c
>> > > @@ -94,7 +94,7 @@ struct its_device;
>> > > =C2=A0 * list.
>> > > =C2=A0 */
>> > > =C2=A0struct its_node {
>> > > -=C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 lock;
>> > > +=C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 lock;
>> > > =C2=A0 =C2=A0 =C2=A0struct mutex=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_allo=
c_lock;
>> > > =C2=A0 =C2=A0 =C2=A0struct list_head=C2=A0 =C2=A0 entry;
>> > > =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 *base;
>> > > diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqc=
hip/arm-gic-v3.h
>> > > index 7286913654..9dcbf4b331 100644
>> > > --- a/include/linux/irqchip/arm-gic-v3.h
>> > > +++ b/include/linux/irqchip/arm-gic-v3.h
>> > > @@ -613,7 +613,7 @@
>> > > =C2=A0
>> > > =C2=A0struct rdists {
>> > > =C2=A0 =C2=A0 =C2=A0struct {
>> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 rd_lock;
>> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 rd_lock;
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 *rd_base;
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct page=C2=A0 =C2=A0 *pend_pag=
e;
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t=C2=A0 =C2=A0 phys_base;
>> > > diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqc=
hip/arm-gic-v4.h
>> > > index bf9e064028..d7afd9d2cd 100644
>> > > --- a/include/linux/irqchip/arm-gic-v4.h
>> > > +++ b/include/linux/irqchip/arm-gic-v4.h
>> > > @@ -68,7 +68,7 @@ struct its_vpe {
>> > > =C2=A0 =C2=A0 =C2=A0 * Ensures mutual exclusion between affinity set=
ting of the
>> > > =C2=A0 =C2=A0 =C2=A0 * vPE and vLPI operations using vpe->col_idx.
>> > > =C2=A0 =C2=A0 =C2=A0 */
>> > > -=C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 vpe_lock;
>> > > +=C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 vpe_lock;
>> >=20
>> > Can you please share the call stack where this lock is involved in an
>> > OOB code path?
>> >=20
>> > The other two locks are fine. I'm unsure about this one here.
>>=20
>> >=20
>> The vpe_lock can be taken in OOB context via the following call chain wh=
en
>> handling vLPI interrupt masking:
>>=20
>> its_mask_irq()
>> =C2=A0 =C2=A0 lpi_update_config()
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 direct_lpi_inv()
>
> This one here is protected by is_v4_1(), which seems gic-v4 specific.
> The location (arm-gic-v4.h) is also pointing in that direction. Most
> likely the reason why you never saw any warning for that lock. You are
> on v3, right?
>
> The change itself is correct but v4 specific and merged into a patch
> titled v3. That's confusing.
>
> Proposal: Skip that lock for now and revisit it once the v4 irq chip is
> made OOB aware. (Nice additional contribution possibility ;-))
>
> Philippe, any comments from your side?
>

gic-v3 and v4 implementations share some type definitions via
arm-gic-v4.h. Since we need to fix up anything down the
lpi_update_config() path, it looks like the impact of enabling v3 for
oob context is going to spread to v4.

Looking at the its_vm definition in arm-gic-v4.h, there is a helpful
comment stating that the following lock order applies: vmapp_lock ->
vpe_lock ->vmovp_lock.  For this reason, if we are going to convert
vpe_lock to a hard lock, then vmovp_lock must be converted in the same
move too due to nesting constraints. Which means in turn that any code
path going through its_send_vmovp() needs to be inspected.

--=20
Philippe.
