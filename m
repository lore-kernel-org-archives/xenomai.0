Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D443CE4E
	for <xenomai@lists.linux.dev>; Tue,  4 Aug 2026 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839912; cv=none; b=oqMww4BVlNJmqgJd/XT2A30snWijUzz9HjgBD7lDWiVE1fC8kjDSG4ujRqN5hKjmtIsBPYdYZQZj8IpTxOp0GD68m60E8Aep9FpUuO+75/6RtqjBHXH3ppL7nsI0NPVy3ueK/Lc13pCFkSHjLzNuXgnG69rYE249pjNOn9Po/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839912; c=relaxed/simple;
	bh=9ReT2Mku5eRGpZuCmZZBVaADw3MBMrnE0wkHDRrE+EM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjIQId9X4nHWEud/0cWIf1ON/G6j7dYv/KGVuBH4kNAsApHZxxuoqgynM4fBm89Fr9MG6t0yRZzddgKo3U2Hhb8pgJun245eKXpws1TCcSL3/4eE+MIh60Ror+ad/7o6GG6Fjrv8LPg6Ks/Q2P7qVRmfzOECAEED+s5ex0n+2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WVpwcNpv; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WVpwcNpv"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260804095802d74bc3341e0002071d
        for <xenomai@lists.linux.dev>;
        Tue, 04 Aug 2026 11:58:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9ReT2Mku5eRGpZuCmZZBVaADw3MBMrnE0wkHDRrE+EM=;
 b=WVpwcNpvWx2LYhxf+eeRC7RzbrfjgjhYUxbhiZqx/K6Pf7MoZjvzlRBiIOv3to/3ntjUUA
 kwDuj41DNjdTrfKHWWDssEs5Qe0OJG2jJjPfRXOa1YW5wq2SpbrCR+h+htj5RG3Sk7gUvpqy
 I7QjjDgdFqKOUvEFOp/C3Mt1sT2zKpdI+KVjD1usQRFepjtelynt7BSE2QdGiTJ7dexzlMWr
 OF7p6NBUZAGUIcejx6LESiX0u/1rOlX77/ZK6Kk6FR/mTPsBPrj+txfI6xEjtWoXFnx4uu0G
 bB2UvyGjW6OYOjzyd+3C1D2q4pKx0Onr+ZKJZzXSfTjlaqClRZhPrkCA==;
Message-ID: <692f56b728b199b1d30b5a471e9be92cf6f0d50d.camel@siemens.com>
Subject: Re: [PATCH v4] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: linz <powertree@163.com>
Cc: Philippe Gerum <rpm@xenomai.org>, jan.kiszka@siemens.com, 
	xenomai@lists.linux.dev
Date: Tue, 04 Aug 2026 11:58:01 +0200
In-Reply-To: <4217319b.79c1.19fcc1bff5b.Coremail.powertree@163.com>
References: <3747c1b9.703e.19fcbfac7b2.Coremail.powertree@163.com>
	 <e2a0f99724a2b5bd4591e704935b59acc672162c.camel@siemens.com>
	 <4217319b.79c1.19fcc1bff5b.Coremail.powertree@163.com>
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

On Tue, 2026-08-04 at 17:30 +0800, linz wrote:
> At 2026-08-04 16:59:00, "Florian Bezdeka" <florian.bezdeka@siemens.com> w=
rote:
> > On Tue, 2026-08-04 at 16:53 +0800, linz wrote:
> > > The warning shown below could be observed on Dovetail 6.6 with arm64
> > > architecture when CONFIG_DEBUG_IRQ_PIPELINE is enabled.
> > >=20
> > > The reason is the usage of a raw_spinlock_t in hard IRQ masking code
> > > path. A migration to hard_spinlock_t fixes this issue.
> > >=20
> > > [=C2=A0 =C2=A0 1.510903] IRQ pipeline: some code running in oob conte=
xt 'Xenomai'
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0called an in-band only routine
> > > [=C2=A0 =C2=A0 1.510912] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.6.63-doveta=
il2 #8
> > > [=C2=A0 =C2=A0 1.510918] Hardware name: Pe2204 DEMO DDR4 (DT)
> > > [=C2=A0 =C2=A0 1.510920] IRQ stage: Xenomai
> > > [=C2=A0 =C2=A0 1.510923] Call trace:
> > > [=C2=A0 =C2=A0 1.510926]=C2=A0 dump_backtrace+0x90/0xe4
> > > [=C2=A0 =C2=A0 1.510940]=C2=A0 show_stack+0x14/0x1c
> > > [=C2=A0 =C2=A0 1.510946]=C2=A0 dump_stack_lvl+0x84/0xc8
> > > [=C2=A0 =C2=A0 1.510953]=C2=A0 dump_stack+0x14/0x1c
> > > [=C2=A0 =C2=A0 1.510957]=C2=A0 check_inband_stage+0xb0/0xc8
> > > [=C2=A0 =C2=A0 1.510965]=C2=A0 inband_irq_save+0xc/0x28
> > > [=C2=A0 =C2=A0 1.510971]=C2=A0 _raw_spin_lock_irqsave+0x14/0x90
> > > [=C2=A0 =C2=A0 1.510977]=C2=A0 its_send_single_command+0x24/0x154
> > > [=C2=A0 =C2=A0 1.510984]=C2=A0 lpi_update_config+0x9c/0x144
> > > [=C2=A0 =C2=A0 1.510990]=C2=A0 its_mask_irq+0x2c/0x64
> > > [=C2=A0 =C2=A0 1.510997]=C2=A0 irq_chip_mask_parent+0x18/0x20
> > > [=C2=A0 =C2=A0 1.511005]=C2=A0 its_mask_msi_irq+0x1c/0x28
> > > [=C2=A0 =C2=A0 1.511012]=C2=A0 handle_fasteoi_irq+0x1cc/0x2b4
> > > [=C2=A0 =C2=A0 1.511016]=C2=A0 generic_pipeline_irq_desc+0x6c/0xa4
> > > [=C2=A0 =C2=A0 1.511021]=C2=A0 generic_handle_domain_irq+0x18/0x20
> > > [=C2=A0 =C2=A0 1.511028]=C2=A0 gic_handle_irq+0x4c/0x120
> > > [=C2=A0 =C2=A0 1.511032]=C2=A0 handle_irq_pipelined+0x40/0x64
> > > [=C2=A0 =C2=A0 1.511038]=C2=A0 call_on_irq_stack+0x24/0x30
> > > [=C2=A0 =C2=A0 1.511044]=C2=A0 do_interrupt_handler+0x138/0x158
> > > [=C2=A0 =C2=A0 1.511050]=C2=A0 el1_interrupt+0x40/0x110
> > > [=C2=A0 =C2=A0 1.511055]=C2=A0 el1h_64_irq_handler+0x14/0x1c
> > > [=C2=A0 =C2=A0 1.511061]=C2=A0 el1h_64_irq+0x64/0x68
> > > [=C2=A0 =C2=A0 1.511064]=C2=A0 default_idle_call+0x30/0x78
> > > [=C2=A0 =C2=A0 1.511071]=C2=A0 do_idle+0x128/0x150
> > > [=C2=A0 =C2=A0 1.511077]=C2=A0 cpu_startup_entry+0x34/0x38
> > > [=C2=A0 =C2=A0 1.511081]=C2=A0 kernel_init+0x0/0x1d4
> > > [=C2=A0 =C2=A0 1.511088]=C2=A0 arch_post_acpi_subsys_init+0x0/0x8
> > > [=C2=A0 =C2=A0 1.511096]=C2=A0 start_kernel+0x504/0x5cc
> > > [=C2=A0 =C2=A0 1.511103]=C2=A0 __primary_switched+0xbc/0xc4
> > >=20
> > > Beyond that, note that IRQ chip handlers such as irq_mask / irq_unmas=
k run in
> > > OOB context. For instance, any code path calling lpi_update_config() =
must
> > > be oob=E2=80=91capable, so gic_data_rdist_cpu(cpu)->rd_lock and its_v=
pe->vpe_lock are
> > > modified in this patch.
> > >=20
> > > Convert:
> > > - its_node->lock
> > > - rdists.rd_lock
> > > - its_vpe->vpe_lock
> > > from raw_spinlock_t to hard_spinlock_t.
> > >=20
> > > Signed-off-by: linz <powertree@163.com>
> > > ---
> > > =C2=A0drivers/irqchip/irq-gic-v3-its.c=C2=A0 =C2=A0| 2 +-
> > > =C2=A0include/linux/irqchip/arm-gic-v3.h | 2 +-
> > > =C2=A0include/linux/irqchip/arm-gic-v4.h | 2 +-
> > > =C2=A03 files changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-g=
ic-v3-its.c
> > > index 0e57735eac..3f2b02b8f4 100644
> > > --- a/drivers/irqchip/irq-gic-v3-its.c
> > > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > > @@ -94,7 +94,7 @@ struct its_device;
> > > =C2=A0 * list.
> > > =C2=A0 */
> > > =C2=A0struct its_node {
> > > -=C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 lock;
> > > +=C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 lock;
> > > =C2=A0 =C2=A0 =C2=A0struct mutex=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_alloc=
_lock;
> > > =C2=A0 =C2=A0 =C2=A0struct list_head=C2=A0 =C2=A0 entry;
> > > =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 *base;
> > > diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqch=
ip/arm-gic-v3.h
> > > index 7286913654..9dcbf4b331 100644
> > > --- a/include/linux/irqchip/arm-gic-v3.h
> > > +++ b/include/linux/irqchip/arm-gic-v3.h
> > > @@ -613,7 +613,7 @@
> > > =C2=A0
> > > =C2=A0struct rdists {
> > > =C2=A0 =C2=A0 =C2=A0struct {
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 rd_lock;
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 rd_lock;
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 *rd_base;
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct page=C2=A0 =C2=A0 *pend_page=
;
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t=C2=A0 =C2=A0 phys_base;
> > > diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqch=
ip/arm-gic-v4.h
> > > index bf9e064028..d7afd9d2cd 100644
> > > --- a/include/linux/irqchip/arm-gic-v4.h
> > > +++ b/include/linux/irqchip/arm-gic-v4.h
> > > @@ -68,7 +68,7 @@ struct its_vpe {
> > > =C2=A0 =C2=A0 =C2=A0 * Ensures mutual exclusion between affinity sett=
ing of the
> > > =C2=A0 =C2=A0 =C2=A0 * vPE and vLPI operations using vpe->col_idx.
> > > =C2=A0 =C2=A0 =C2=A0 */
> > > -=C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 vpe_lock;
> > > +=C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 vpe_lock;
> >=20
> > Can you please share the call stack where this lock is involved in an
> > OOB code path?
> >=20
> > The other two locks are fine. I'm unsure about this one here.
>=20
> >=20
> The vpe_lock can be taken in OOB context via the following call chain whe=
n
> handling vLPI interrupt masking:
>=20
> its_mask_irq()
> =C2=A0 =C2=A0 lpi_update_config()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 direct_lpi_inv()

This one here is protected by is_v4_1(), which seems gic-v4 specific.
The location (arm-gic-v4.h) is also pointing in that direction. Most
likely the reason why you never saw any warning for that lock. You are
on v3, right?

The change itself is correct but v4 specific and merged into a patch
titled v3. That's confusing.

Proposal: Skip that lock for now and revisit it once the v4 irq chip is
made OOB aware. (Nice additional contribution possibility ;-))

Philippe, any comments from your side?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __direct_lpi_inv()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq_to_cpuid_lock=
()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vpe=
_to_cpuid_lock()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 raw_spin_lock_irqsave(&vpe->vpe_lock, *flags);
>=20
> Since its_mask_irq() executes from the out=E2=80=91of=E2=80=91band stage
> under Dovetail=E2=80=99s irq pipeline, raw_spinlock_t here would trigger =
the
> CONFIG_DEBUG_IRQ_PIPELINE warning.
>=20
> I have not physically observed a printed call trace for vpe_lock yet,
> but code inspection confirms this lock is reachable from OOB context.
> So I convert its_vpe->vpe_lock to hard_spinlock_t together with the
> other two locks.
> > > =C2=A0 =C2=A0 =C2=A0/*
> > > =C2=A0 =C2=A0 =C2=A0 * This collection ID is used to indirect the tar=
get
> > > =C2=A0 =C2=A0 =C2=A0 * redistributor for this VPE. The ID itself isn'=
t involved in
> > > --=C2=A0
> > > 2.34.1
