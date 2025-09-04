Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9F29E0ED
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971399; cv=none; b=NQ5z39LCbG+v/8ZTrr9It4/QYXP5OJJFWpy5AcGvSqeFVnz8bqevg0t+K+ln6LtOqZf1w2Sl/34UlkZCmuaCtVwHek2D3dIWIEHJGPkle8xJ0wxphq6cfogJBYyeO7m6prH4MteM55UdFrV60AxFqYk2JSj/EQ7s4tfWtCoR+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971399; c=relaxed/simple;
	bh=/qrVXNDzUVG3QwYrOp0bTs0mFNR+2o6XifpFhyd/GdE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWr15d6zqCb1n4NUJSkaBMNFm3HwNFrDKhh3FhldSxQEDXA89jwA239xXBPNTcju3Lt/3GvS53kX6FXsdgH1zgapXN3UJjhTBTuW64Do1xozL7r4W6913B1OnYBHrx1yzDNZZ3DzQnzL2W/5/5Wrkje9jkGfhj275SYTmvLBnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=EHhTqPix; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="EHhTqPix"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025090407363134664d7c51000207ab
        for <xenomai@lists.linux.dev>;
        Thu, 04 Sep 2025 09:36:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=amTr9TizGGKLf2AvwXQ2xT/uAI7GYS59QBDGQSPdhwI=;
 b=EHhTqPixY9uvEF6xGdFgh1jmbFmkqUki12vaMTJ6dQIKectVDDQkj6OeV5yeJXcy6HnSNI
 FRYLKzVOgEmFVRfhze12d9kV8k2b7JwXZNm3rQ32xrsl9A5h15/Ch6XJHFJYG0HPG8EG4cZS
 lq9dvWTCuPbuD3evECvkofbm4+l4OreHnZ3DialCZlMh2TnqudUq5rlVuT7vPXLrV6r4Wjtn
 7kyIgMJm9mNoYpy81YqXFTHEQXQYJXT2ZhHbXdlMjT0nqe0W2yvLfhmdknx9t3iKHS+MktAv
 afSuC+GpwVbh47bF6Yqe+kbV97lF9fE2Mt4MvQTYV9iQP9vOcVcAlCEA==;
Message-ID: <1e485eb503d0275da44f29b76c676edd4d1bf3c6.camel@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v2 1/2] x86/fpu: dovetail: Fix FPU
 corruption
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 04 Sep 2025 09:36:30 +0200
In-Reply-To: <875xdzldtc.fsf@xenomai.org>
References: 
	<20250820-wip-flo-fixes-for-dovetail-6-15-v2-0-535e4fa355f7@siemens.com>
		<20250820-wip-flo-fixes-for-dovetail-6-15-v2-1-535e4fa355f7@siemens.com>
	 <875xdzldtc.fsf@xenomai.org>
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

On Wed, 2025-09-03 at 18:07 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > The kernel splat looked as follows and could be reproduced by running
> > the Xenomai 3 testsuite over a stress-ng produced load. The problem is
> > specific to Dovetail 6.16.
> >=20
> > [19527.937613] ------------[ cut here ]------------
> > [19527.937614] WARNING: CPU: 0 PID: 14 at arch/x86/kernel/fpu/core.c:62=
 x86_task_fpu+0x18/0x30
> > [19527.937619] Modules linked in: intel_rapl_msr intel_rapl_common inte=
l_pmc_core pmt_telemetry pmt_class intel_pmc_ssram_telemetry intel_vsec gha=
sh_clmulni_intel sha512_ssse3 sha1_ssse3 aesni_intel gf128mul rapl pcspkr b=
utton evdev serio_raw joydev sg loop efi_pstore fuse dm_mod drm dax configf=
s ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 sr_mod cdrom ata_gener=
ic sd_mod hid_generic hid_hyperv ata_piix psmouse hid hv_netvsc hv_storvsc =
libata scsi_transport_fc floppy i2c_piix4 i2c_smbus scsi_mod scsi_common [l=
ast unloaded: xeno_can]
> > [19527.937635] CPU: 0 UID: 0 PID: 14 Comm: ksoftirqd/0 Not tainted 6.16=
.0-hyprv-xenomai-0+ #196 PREEMPT(voluntary)
> > [19527.937637] Hardware name: Microsoft Corporation Virtual Machine/Vir=
tual Machine, BIOS 090008  12/07/2018
> > [19527.937637] IRQ stage: Xenomai
> > [19527.937638] RIP: 0010:x86_task_fpu+0x18/0x30
> > [19527.937640] Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 90 0f 1f 44 00 00 48 8d 87 00 20 00 00 f6 47 3e 20 75 05 c3 cc cc cc cc 90=
 <0f> 0b 90 31 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f
> > [19527.937641] RSP: 0018:ffffba19c0083b60 EFLAGS: 00010002
> > [19527.937641] RAX: ffffa0a90133c3c0 RBX: 0000000000000001 RCX: ffffa0a=
93fc5a6e8
> > [19527.937642] RDX: 0000000000000000 RSI: 0000000000000007 RDI: ffffa0a=
90133a3c0
> > [19527.937643] RBP: ffffa0a93fc5a058 R08: 01364d9cb9685197 R09: fffffff=
f83e406f8
> > [19527.937643] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000001
> > [19527.937643] R13: ffffa0a90133a3c0 R14: ffffba19c0c62008 R15: 0000000=
000000001
> > [19527.937645] FS:  0000000000000000(0000) GS:ffffa0a9ba664000(0000) kn=
lGS:0000000000000000
> > [19527.937646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [19527.937646] CR2: 00007f5c694363c0 CR3: 000000003e038004 CR4: 0000000=
0003706f0
> > [19527.937647] Call Trace:
> > [19527.937648]  <TASK>
> > [19527.937649]  fpu__suspend_inband+0x3c/0x50
> > [19527.937651]  dovetail_context_switch+0x130/0x240
> > [19527.937652]  ? xntimer_start+0x101/0x240
> > [19527.937656]  ___xnsched_run+0x1f9/0x4d0
> > [19527.937659]  run_oob_call+0x87/0x140
> > [19527.937662]  handle_irq_pipelined_finish+0x188/0x1a0
> > [19527.937664]  arch_pipeline_entry+0x43/0xf0
> > [19527.937667]  asm_sysvec_hyperv_stimer0+0x16/0x20
> > [19527.937669] RIP: 0010:kernel_fpu_end+0x5/0x50
> > [19527.937670] Code: 57 02 e8 9e 12 42 00 31 c0 c3 cc cc cc cc 0f 1f 80=
 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00=
 <65> 0f b6 05 03 40 57 02 84 c0 75 31 65 c6 05 f7 3f 57 02 01 65 f6
> > [19527.937671] RSP: 0018:ffffba19c0083d28 EFLAGS: 00000246
> > [19527.937671] RAX: 000000000000000c RBX: 0000000000000001 RCX: fffffff=
f842f2260
> > [19527.937672] RDX: 0000000000000000 RSI: ffffffff84c67450 RDI: fffffff=
f84c673e0
> > [19527.937672] RBP: 0000000000000001 R08: ffffffff842f2260 R09: 0000000=
000000000
> > [19527.937672] R10: ffffffff84a080c0 R11: 0000000000000001 R12: fffffff=
f84c67410
> > [19527.937673] R13: ffffffff84c673e0 R14: 0000000000000040 R15: 0000000=
000000004
> > [19527.937675]  blake2s_compress+0x52/0xa0
> > [19527.937679]  blake2s_update+0x75/0x150
> > [19527.937681]  add_timer_randomness+0xac/0x1a0
> > [19527.937684]  scsi_end_request+0x297/0x3a0 [scsi_mod]
> > [19527.937697]  scsi_io_completion+0x55/0x6a0 [scsi_mod]
> > [19527.937707]  blk_done_softirq+0x46/0x60
> > [19527.937709]  handle_softirqs+0xd0/0x430
> > [19527.937711]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > [19527.937713]  run_ksoftirqd+0x47/0x60
> > [19527.937714]  smpboot_thread_fn+0xec/0x220
> > [19527.937716]  kthread+0xf7/0x240
> > [19527.937718]  ? __pfx_kthread+0x10/0x10
> > [19527.937720]  ret_from_fork+0x28c/0x310
> > [19527.937721]  ? __pfx_kthread+0x10/0x10
> > [19527.937722]  ret_from_fork_asm+0x1a/0x30
> > [19527.937725]  </TASK>
> > [19527.937725] irq event stamp: 1270
> > [19527.937726] hardirqs last  enabled at (1269): [<ffffffff830b2b1c>] r=
un_ksoftirqd+0x4c/0x60
> > [19527.937727] hardirqs last disabled at (1270): [<ffffffff83d90d53>] _=
_schedule+0x853/0x1080
> > [19527.937729] softirqs last  enabled at (1268): [<ffffffff830b29d6>] h=
andle_softirqs+0x346/0x430
> > [19527.937730] softirqs last disabled at (1215): [<ffffffff830b2b17>] r=
un_ksoftirqd+0x47/0x60
> > [19527.937731] ---[ end trace 0000000000000000 ]---
> >=20
> > The main problem was the x86_task_fpu(tsk) helper, which will deliver
> > NULL in case CONFIG_X86_DEBUG_FPU is enabled and
> > (tsk->flags & PF_KTHREAD) is true. We ended up in dereferencing a
> > NULL pointer.
> >=20
> > This problem could be fixed by not using the x86_task_fpu().
> > But:
> >   - It seems that the location of struct fpu is under development.
> >   - Moving the preemption marker from struct fpu to
> >     struct thread_info::flags synchronizes the amd64 and arm64
> >     implementation.
> >=20
> > Second, the early exit in fpu__resume_inband() was wrong, as that
> > prevented the FPU restore of in-band kthreads.
> >=20
> > Link: https://lore.kernel.org/xenomai/80a48c1ddc3721eb8022b77548028aa8e=
7371928.camel@siemens.com/T/
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  arch/x86/include/asm/fpu/sched.h   | 17 ++++-------------
> >  arch/x86/include/asm/fpu/types.h   | 12 ------------
> >  arch/x86/include/asm/thread_info.h |  1 +
> >  arch/x86/kernel/fpu/core.c         | 12 ++++--------
> >  4 files changed, 9 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fp=
u/sched.h
> > index ba677ffa4fbb..2b66960accd4 100644
> > --- a/arch/x86/include/asm/fpu/sched.h
> > +++ b/arch/x86/include/asm/fpu/sched.h
> > @@ -18,19 +18,9 @@ extern void fpu_flush_thread(void);
> > =20
> >  #ifdef CONFIG_DOVETAIL
> > =20
> > -static inline void oob_fpu_set_preempt(struct fpu *fpu)
> > +static inline bool oob_fpu_preempted(struct thread_info *old_ti)
> >  {
> > -	fpu->preempted =3D true;
> > -}
> > -
> > -static inline void oob_fpu_clear_preempt(struct fpu *fpu)
> > -{
> > -	fpu->preempted =3D false;
> > -}
> > -
> > -static inline bool oob_fpu_preempted(struct fpu *old_fpu)
> > -{
> > -	return old_fpu->preempted;
> > +	return test_thread_flag(TIF_KERNEL_FP_PREEMPTED);
> >  }
> > =20
> >  #else
> > @@ -60,9 +50,10 @@ static inline void switch_fpu(struct task_struct *ol=
d, int cpu)
> >  {
> >  	if (!test_tsk_thread_flag(old, TIF_NEED_FPU_LOAD) &&
> >  		cpu_feature_enabled(X86_FEATURE_FPU)) {
> > +		struct thread_info *old_ti =3D task_thread_info(old);
> >  		struct fpu *old_fpu =3D x86_task_fpu(old);
> >  		if (!(old->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
> > -			!oob_fpu_preempted(old_fpu)) {
> > +			!oob_fpu_preempted(old_ti)) {
> >  			set_tsk_thread_flag(old, TIF_NEED_FPU_LOAD);
> >  			save_fpregs_to_fpstate(old_fpu);
> >  			/*
> > diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fp=
u/types.h
> > index c329a878a581..1c94121acd3d 100644
> > --- a/arch/x86/include/asm/fpu/types.h
> > +++ b/arch/x86/include/asm/fpu/types.h
> > @@ -473,18 +473,6 @@ struct fpu {
> >  	 */
> >  	unsigned int			last_cpu;
> > =20
> > -#ifdef CONFIG_DOVETAIL
> > -	/*
> > -	 * @preempted:
> > -	 *
> > -	 * When Dovetail is enabled, this flag is set for the inband
> > -	 * task context saved when entering a kernel_fpu_begin/end()
> > -	 * section before the latter got preempted by an out-of-band
> > -	 * task.
> > -	 */
> > -	bool				preempted : 1;
> > -#endif
> > -
> >  	/*
> >  	 * @avx512_timestamp:
> >  	 *
> > diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/=
thread_info.h
> > index 77c4c632cef2..53f11b73d0f0 100644
> > --- a/arch/x86/include/asm/thread_info.h
> > +++ b/arch/x86/include/asm/thread_info.h
> > @@ -94,6 +94,7 @@ struct thread_info {
> >  #define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling needed */
> >  #define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
> >  #define TIF_SSBD		6	/* Speculative store bypass disable */
> > +#define TIF_KERNEL_FP_PREEMPTED	7	/* Dovetail: kernel mode
> > FPU section preempted by OOB */
>=20
> Only the current task may set/clear/read this flag, so the latter should
> rather go to the TLF (synchronous) section. As a consequence, non-atomic
> ops would be enough to access it.
>=20
> >  #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
> >  #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) =
*/
> >  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return=
 */
> > diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> > index 7b87a04c0b6e..6d185ad1a996 100644
> > --- a/arch/x86/kernel/fpu/core.c
> > +++ b/arch/x86/kernel/fpu/core.c
> > @@ -1044,7 +1044,6 @@ static int fpu__drop_kernel_fpstate(unsigned int =
cpu)
> >  void fpu__suspend_inband(void)
> >  {
> >  	struct fpu *kfpu =3D this_cpu_read(in_kernel_fpstate);
> > -	struct task_struct *tsk =3D current;
> > =20
> >  	/*
> >  	 * If kernel_fpu_allowed is false, we are dealing with the
> > @@ -1054,23 +1053,20 @@ void fpu__suspend_inband(void)
> >  	if (!this_cpu_read(kernel_fpu_allowed)) {
> >  		save_fpregs_to_fpstate(kfpu);
> >  		__cpu_invalidate_fpregs_state();
> > -		oob_fpu_set_preempt(x86_task_fpu(tsk));
> > +		set_thread_flag(TIF_KERNEL_FP_PREEMPTED);
> >  	}
> >  }
> > =20
> >  void fpu__resume_inband(void)
> >  {
> >  	struct fpu *kfpu =3D this_cpu_read(in_kernel_fpstate);
> > -	struct task_struct *tsk =3D current;
> > =20
> > -	if (tsk->flags & PF_KTHREAD)
> > -		return;
> > -
> > -	if (oob_fpu_preempted(x86_task_fpu(tsk))) {
> > +	if (test_and_clear_thread_flag(TIF_KERNEL_FP_PREEMPTED)) {
>=20
> In most cases, we won't need to clear this flag, so a split
> test then clear-if-set approach would be more efficient.

I aligned that with the arm64 implementation of the fpu restore. Should
I fix that up for both implementations afterwards? Same applies to the
flag location / access.

>=20
> --=20
> Philippe.
