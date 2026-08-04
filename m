Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595D459AE6
	for <xenomai@lists.linux.dev>; Tue,  4 Aug 2026 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833949; cv=none; b=pFBu4SC6OGPlgPsHt5uOoz1Q7xPMV9ZGewFFDZiZGfaSJ4mEOs/8w2li3AlGUauWSPEE71xzvjPsCC8Z1MROlb53PGwiFT0jfaHSOrSSnh0I5JlRgKEY0Ora5wx8gRj93e33QNdMlqkvx12ppyMEp8v448iiQozJ3ihuFBoISsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833949; c=relaxed/simple;
	bh=KM1jvgFZ8oABYy+nzMr4w/4CdWBuZVrPP80gpRxT/vg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sobA/N3+1RKEOPhDSrmKPnqClVCc8Ca06c0rwKfEZjPXW4C+fmEF2VTuPop720DagerFsZGEe8QYwL1VCav1SOAQbqzWmcfIS35xusfIQk7o2bHM07E/1yMr/dI5rUbeZE2axxZLZ8TmkOmD+GXqyDONyo766q+y35lDsuujeAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=NuTw8+2r; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NuTw8+2r"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026080408590007d618c21e000207af
        for <xenomai@lists.linux.dev>;
        Tue, 04 Aug 2026 10:59:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KM1jvgFZ8oABYy+nzMr4w/4CdWBuZVrPP80gpRxT/vg=;
 b=NuTw8+2r+JjKSWyz0S1Wig5fC/fuZ64tvWQ1FyTJGh0jnK1kIGSkYSLB+5sdYnou6oGMsb
 9VbILOk676if7OWt/L7Q4FeHmr5IPCVzLPSiOhq8CEXx1vX7M1JT3+QM+0OAMQ0LVEAQS55R
 1TrTMn+P29OnXmGiTkIHSXlTLwDQhlbqvLkMQf6u3Df4ypzUUokU5deutUi7fhGlLcoCiivP
 XsLobEoEkFOM3Y+eSmqtYvNO1oSlJalpPsFdJjEsQgiCKgWNEv4ioCxANIRplhJ30DcZ3wX7
 g20baWM0cTy1pv3Eze/fSMPtoMi7PaMdhqpmx5GrxsPvLZlWY1rgCbDw==;
Message-ID: <e2a0f99724a2b5bd4591e704935b59acc672162c.camel@siemens.com>
Subject: Re: [PATCH v4] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: linz <powertree@163.com>, Philippe Gerum <rpm@xenomai.org>
Cc: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Date: Tue, 04 Aug 2026 10:59:00 +0200
In-Reply-To: <3747c1b9.703e.19fcbfac7b2.Coremail.powertree@163.com>
References: <3747c1b9.703e.19fcbfac7b2.Coremail.powertree@163.com>
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

On Tue, 2026-08-04 at 16:53 +0800, linz wrote:
> The warning shown below could be observed on Dovetail 6.6 with arm64
> architecture when CONFIG_DEBUG_IRQ_PIPELINE is enabled.
>=20
> The reason is the usage of a raw_spinlock_t in hard IRQ masking code
> path. A migration to hard_spinlock_t fixes this issue.
>=20
> [=C2=A0 =C2=A0 1.510903] IRQ pipeline: some code running in oob context '=
Xenomai'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0called an in-band only routine
> [=C2=A0 =C2=A0 1.510912] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.6.63-dovetail2 #8
> [=C2=A0 =C2=A0 1.510918] Hardware name: Pe2204 DEMO DDR4 (DT)
> [=C2=A0 =C2=A0 1.510920] IRQ stage: Xenomai
> [=C2=A0 =C2=A0 1.510923] Call trace:
> [=C2=A0 =C2=A0 1.510926]=C2=A0 dump_backtrace+0x90/0xe4
> [=C2=A0 =C2=A0 1.510940]=C2=A0 show_stack+0x14/0x1c
> [=C2=A0 =C2=A0 1.510946]=C2=A0 dump_stack_lvl+0x84/0xc8
> [=C2=A0 =C2=A0 1.510953]=C2=A0 dump_stack+0x14/0x1c
> [=C2=A0 =C2=A0 1.510957]=C2=A0 check_inband_stage+0xb0/0xc8
> [=C2=A0 =C2=A0 1.510965]=C2=A0 inband_irq_save+0xc/0x28
> [=C2=A0 =C2=A0 1.510971]=C2=A0 _raw_spin_lock_irqsave+0x14/0x90
> [=C2=A0 =C2=A0 1.510977]=C2=A0 its_send_single_command+0x24/0x154
> [=C2=A0 =C2=A0 1.510984]=C2=A0 lpi_update_config+0x9c/0x144
> [=C2=A0 =C2=A0 1.510990]=C2=A0 its_mask_irq+0x2c/0x64
> [=C2=A0 =C2=A0 1.510997]=C2=A0 irq_chip_mask_parent+0x18/0x20
> [=C2=A0 =C2=A0 1.511005]=C2=A0 its_mask_msi_irq+0x1c/0x28
> [=C2=A0 =C2=A0 1.511012]=C2=A0 handle_fasteoi_irq+0x1cc/0x2b4
> [=C2=A0 =C2=A0 1.511016]=C2=A0 generic_pipeline_irq_desc+0x6c/0xa4
> [=C2=A0 =C2=A0 1.511021]=C2=A0 generic_handle_domain_irq+0x18/0x20
> [=C2=A0 =C2=A0 1.511028]=C2=A0 gic_handle_irq+0x4c/0x120
> [=C2=A0 =C2=A0 1.511032]=C2=A0 handle_irq_pipelined+0x40/0x64
> [=C2=A0 =C2=A0 1.511038]=C2=A0 call_on_irq_stack+0x24/0x30
> [=C2=A0 =C2=A0 1.511044]=C2=A0 do_interrupt_handler+0x138/0x158
> [=C2=A0 =C2=A0 1.511050]=C2=A0 el1_interrupt+0x40/0x110
> [=C2=A0 =C2=A0 1.511055]=C2=A0 el1h_64_irq_handler+0x14/0x1c
> [=C2=A0 =C2=A0 1.511061]=C2=A0 el1h_64_irq+0x64/0x68
> [=C2=A0 =C2=A0 1.511064]=C2=A0 default_idle_call+0x30/0x78
> [=C2=A0 =C2=A0 1.511071]=C2=A0 do_idle+0x128/0x150
> [=C2=A0 =C2=A0 1.511077]=C2=A0 cpu_startup_entry+0x34/0x38
> [=C2=A0 =C2=A0 1.511081]=C2=A0 kernel_init+0x0/0x1d4
> [=C2=A0 =C2=A0 1.511088]=C2=A0 arch_post_acpi_subsys_init+0x0/0x8
> [=C2=A0 =C2=A0 1.511096]=C2=A0 start_kernel+0x504/0x5cc
> [=C2=A0 =C2=A0 1.511103]=C2=A0 __primary_switched+0xbc/0xc4
>=20
> Beyond that, note that IRQ chip handlers such as irq_mask / irq_unmask ru=
n in
> OOB context. For instance, any code path calling lpi_update_config() must
> be oob=E2=80=91capable, so gic_data_rdist_cpu(cpu)->rd_lock and its_vpe->=
vpe_lock are
> modified in this patch.
>=20
> Convert:
> - its_node->lock
> - rdists.rd_lock
> - its_vpe->vpe_lock
> from raw_spinlock_t to hard_spinlock_t.
>=20
> Signed-off-by: linz <powertree@163.com>
> ---
> =C2=A0drivers/irqchip/irq-gic-v3-its.c=C2=A0 =C2=A0| 2 +-
> =C2=A0include/linux/irqchip/arm-gic-v3.h | 2 +-
> =C2=A0include/linux/irqchip/arm-gic-v4.h | 2 +-
> =C2=A03 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> index 0e57735eac..3f2b02b8f4 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -94,7 +94,7 @@ struct its_device;
> =C2=A0 * list.
> =C2=A0 */
> =C2=A0struct its_node {
> -=C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 lock;
> +=C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 lock;
> =C2=A0 =C2=A0 =C2=A0struct mutex=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_alloc_loc=
k;
> =C2=A0 =C2=A0 =C2=A0struct list_head=C2=A0 =C2=A0 entry;
> =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 *base;
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/a=
rm-gic-v3.h
> index 7286913654..9dcbf4b331 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -613,7 +613,7 @@
> =C2=A0
> =C2=A0struct rdists {
> =C2=A0 =C2=A0 =C2=A0struct {
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 rd_lock;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 rd_lock;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 *rd_base;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct page=C2=A0 =C2=A0 *pend_page;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t=C2=A0 =C2=A0 phys_base;
> diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/a=
rm-gic-v4.h
> index bf9e064028..d7afd9d2cd 100644
> --- a/include/linux/irqchip/arm-gic-v4.h
> +++ b/include/linux/irqchip/arm-gic-v4.h
> @@ -68,7 +68,7 @@ struct its_vpe {
> =C2=A0 =C2=A0 =C2=A0 * Ensures mutual exclusion between affinity setting =
of the
> =C2=A0 =C2=A0 =C2=A0 * vPE and vLPI operations using vpe->col_idx.
> =C2=A0 =C2=A0 =C2=A0 */
> -=C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 vpe_lock;
> +=C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 vpe_lock;

Can you please share the call stack where this lock is involved in an
OOB code path?

The other two locks are fine. I'm unsure about this one here.

> =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 * This collection ID is used to indirect the target
> =C2=A0 =C2=A0 =C2=A0 * redistributor for this VPE. The ID itself isn't in=
volved in
> --=C2=A0
> 2.34.1
