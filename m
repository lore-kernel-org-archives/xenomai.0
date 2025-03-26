Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF119A298
	for <xenomai@lists.linux.dev>; Wed, 26 Mar 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991209; cv=none; b=DM8KCtRNvpVzchIHlXl30kDrmKv0PBiShjdQIA7Tri6oS3b0OnIzwsI8zUzS02Nq2aVtlOqWJKNhSAp/mTbZ7gwQgaoCzoxss8+xSpFLHbQAGMSrh9ZVfy4eVmxf2i1aYFG/lxDbap4qygL8vbkKs8btGUs9wXSu42upn5hyDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991209; c=relaxed/simple;
	bh=yRr47G5lA28QMbInCbOFt0Yc7hMTMJgo0QnWwRVCMe8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hp7NNzo9s7ekAk4u26kLDuM5aoVTj6HHeEx2Kap+1WYYuuNb1mGKhuN8+A8CkKKzAkxNiosie6WOy1/+hdnRF4H21gkWQ60ANHfOAkj9BFuYyek0/DUkLTfV1g5Iie5gwR8XvXeo6H4IL0lid4fhiVbAwKH4RrFNwpNFZptk4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=f/QNe4/I; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="f/QNe4/I"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025032612132169d1dade761c9dda8c
        for <xenomai@lists.linux.dev>;
        Wed, 26 Mar 2025 13:13:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/OvIl6UvZKx40Uu7H6zijR0ARpSS9DW08L1P1KZ+ajQ=;
 b=f/QNe4/IM4A3Hnrdi8UF31rTXAWA7MlK1mu9jq1zyJJS9S25D8s6oE0B3AblK6v14QR9O2
 eOIFs6jXvUebK+x7s3vQiyenTYNZeJcslt5taJygg+dJPXqSArOjphRBWXLnjDivdH72m1Ht
 HrKV0Tx2a82lyHCVe21/71suIywkaPG/1DF+atDncBs6lIHLdq9ZeWBwmUYEn022xWW1RT58
 TdaR7L6mPuYb31PSAHkdEnGbC4RQvXBcTqiF/KOGHXxEMeoBO4r+nWP+WpSL1weakrbEM8kg
 OqRZ5LkbbQEwSetcAle2l61kRM0HVaGUN3EX1QDiYdptuwXw9c4PVbfA==;
Message-ID: <104dae3bc6f1696c24c5dd89ecea5ae0931c8038.camel@siemens.com>
Subject: Re: [PATCH] x86: dovetail: Fix inverted debug check in
 lock_vector_lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Wed, 26 Mar 2025 13:13:15 +0100
In-Reply-To: <87ldst30cn.fsf@xenomai.org>
References: <e9a4daa3-7a28-45b3-89cb-76c6484a44af@siemens.com>
		<199b7a20107bf6756f3579debb7313ff96e33e7d.camel@siemens.com>
	 <87ldst30cn.fsf@xenomai.org>
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

On Tue, 2025-03-25 at 10:50 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Mon, 2025-03-24 at 18:18 +0100, Jan Kiszka wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >=20
> > > Code and comment were no in line, but the comment actually make more
> > > sense here, given that unlock_vector_lock will unconditionally reenab=
le
> > > hard IRQs.
> > >=20
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > ---
> > >  arch/x86/kernel/apic/vector.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vec=
tor.c
> > > index a08b0dff066ac..af60f138d590b 100644
> > > --- a/arch/x86/kernel/apic/vector.c
> > > +++ b/arch/x86/kernel/apic/vector.c
> > > @@ -142,7 +142,7 @@ void lock_vector_lock(void)
> > >  	 * entry. In addition, we assume that hard irqs are on as well
> > >  	 * (which is the regular case).
> > >  	 */
> > > -	WARN_ON_ONCE(irq_pipeline_debug() && !hard_irqs_disabled());
> > > +	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
> > >  	hard_cond_local_irq_disable();
> > >  	/* Used to the online set of cpus does not change
> > >  	 * during assign_irq_vector.
> > > --=20
> > > 2.43.0
> >=20
> > With that applied there is still one warning left in 6.14:
> >=20
> > [   17.921496] ------------[ cut here ]------------
> > [   17.921502] WARNING: CPU: 3 PID: 33 at arch/x86/mm/tlb.c:516 switch_=
mm_irqs_off+0x39d/0x4f0
> > [   17.921512] Modules linked in:
> > [   17.921517] CPU: 3 UID: 0 PID: 33 Comm: cpuhp/3 Not tainted 6.14.0-r=
c7+ #82
> > [   17.921521] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.2-debian-1.16.2-1 04/01/2014
> > [   17.921523] IRQ stage: Linux
> > [   17.921526] RIP: 0010:switch_mm_irqs_off+0x39d/0x4f0
> > [   17.921531] Code: 06 75 de 65 c6 05 e6 82 db 7e 00 e9 77 fd ff ff 48=
 8b 05 3e 79 18 01 b9 49 00 00 00 48 89 c2 48 c1 ea 20 0f 30 e9 fb fc ff ff=
 <0f> 0b e9 9f fc ff ff 0f 0b e9 4f fd ff ff 65 48 c7 05e
> > [   17.921533] RSP: 0018:ffffc90000133de8 EFLAGS: 00010202
> > [   17.921537] RAX: 0000000000000001 RBX: ffffffff8270e000 RCX: 0000000=
000000207
> > [   17.921539] RDX: 0000000000000206 RSI: ffffffff8270e000 RDI: ffff888=
0065ae3c0
> > [   17.921541] RBP: ffff88800378ab80 R08: ffff88803e79c5c8 R09: 0000000=
00000019d
> > [   17.921543] R10: ffff88803e79c5a0 R11: 0000000000000001 R12: ffff888=
0065ae3c0
> > [   17.921545] R13: 0000000000000000 R14: 0000000000000003 R15: ffff888=
03e79c5c8
> > [   17.921558] FS:  0000000000000000(0000) GS:ffff88803e780000(0000) kn=
lGS:0000000000000000
> > [   17.921574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   17.921577] CR2: 000055ed7e138e28 CR3: 0000000003ea8000 CR4: 0000000=
0003506f0
> > [   17.921579] Call Trace:
> > [   17.921622]  <TASK>
> > [   17.921625]  ? __warn+0x85/0x140
> > [   17.921630]  ? switch_mm_irqs_off+0x39d/0x4f0
> > [   17.921634]  ? report_bug+0x164/0x190
> > [   17.921641]  ? handle_bug+0x65/0xd0
> > [   17.921645]  ? exc_invalid_op+0xb2/0xd0
> > [   17.921648]  ? asm_exc_invalid_op+0x1a/0x20
> > [   17.921653]  ? switch_mm_irqs_off+0x39d/0x4f0
> > [   17.921657]  ? __pfx_sched_cpu_wait_empty+0x10/0x10
> > [   17.921661]  sched_cpu_wait_empty+0x93/0xc0
> > [   17.921665]  cpuhp_invoke_callback+0x114/0x4b0
> > [   17.921669]  cpuhp_thread_fun+0xee/0x190
> > [   17.921674]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > [   17.921678]  smpboot_thread_fn+0xdd/0x1d0
> > [   17.921683]  kthread+0xf1/0x1e0
> > [   17.921689]  ? __pfx_kthread+0x10/0x10
> > [   17.921693]  ret_from_fork+0x34/0x50
> > [   17.921698]  ? __pfx_kthread+0x10/0x10
> > [   17.921701]  ret_from_fork_asm+0x1a/0x30
> > [   17.921717]  </TASK>
> > [   17.921719] ---[ end trace 0000000000000000 ]---
> >=20
> > There were some changes to the scheduler code in between. I'm currently
> > testing with:
> >=20
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 50b082b41e7d..4427fc13086d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8032,10 +8032,10 @@ static void sched_force_init_mm(void)
> > =20
> >         if (mm !=3D &init_mm) {
> >                 mmgrab_lazy_tlb(&init_mm);
> > -               local_irq_disable();
> > +               hard_local_irq_disable();
> >                 current->active_mm =3D &init_mm;
> >                 switch_mm_irqs_off(mm, &init_mm, current);
> > -               local_irq_enable();
> > +               hard_local_irq_enable();
> >                 finish_arch_post_lock_switch();
> >                 mmdrop_lazy_tlb(mm);
> >         }
> >=20
> > Florian
>=20
> Correct. However, since this is an inband call, we want to keep the
> virtual interrupt state in line with the expectations of the kernel, so
> we need to keep the original local_irq* calls in place. Dovetail
> provides a pair of calls namely (un)protect_inband_mm() which is
> dedicated to guarding the mm switch code from hardware interrupts, the
> general logic is visible from switch_mm() in arch/x86/mm/tlb.c. Using
> these calls in this particular case serves as code annotation as well.

This survived testing as well:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 50b082b41e7d..8bcfb8e7046c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8029,12 +8029,15 @@ void sched_setnuma(struct task_struct *p, int
nid)
 static void sched_force_init_mm(void)
 {
        struct mm_struct *mm =3D current->active_mm;
+       long flags;
=20
        if (mm !=3D &init_mm) {
                mmgrab_lazy_tlb(&init_mm);
                local_irq_disable();
+               protect_inband_mm(flags);
                current->active_mm =3D &init_mm;
                switch_mm_irqs_off(mm, &init_mm, current);
+               unprotect_inband_mm(flags);
                local_irq_enable();
                finish_arch_post_lock_switch();
                mmdrop_lazy_tlb(mm);

That should propably squashed into=20
8646b1d5622f ("x86: dovetail: enable alternate scheduling")

Agreed?

>=20
> --=20
> Philippe.

