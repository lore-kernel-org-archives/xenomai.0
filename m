Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24F322C63
	for <xenomai@lists.linux.dev>; Wed, 20 Aug 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708345; cv=none; b=XegbgQzu05HosajQSzdH4BFHoa4q4Y1ouy4PoVctiaLM+F68po8GHVrf4BJ3fn/4dyZwlZ+Kt4VAzNLpBsd+EtoGfCjP1RuDqeuoeCc3UzZbdlN0EFj2XpvVwYgt/jGt6QC18XKrQ7Ck/6cN96iinSOIH5nT7auM5TdqYdW3xMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708345; c=relaxed/simple;
	bh=LOuXkFJrsqweXS9CghdaI/x75YBWpThy/7kbgmpdZ2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PDRKWvzwJv0E7xZNgmsc3nVNICK8GB+WIE/bc7L+Mc3ibqk06sFVEM46GdaAQRg5eHGbaCxoX7NmwtdGSsa0EoYLGYOwly5No65I7c2WdVymbp0kbCop2HQ8U9rbFzMXY6V04XPhZeg8VHfq0amKmvv6ZoeDfowuRRMuohvf7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=T3pRM688; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="T3pRM688"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250820164528b3787312c104250d2c
        for <xenomai@lists.linux.dev>;
        Wed, 20 Aug 2025 18:45:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kRJIXswWSeBcZ4fmxfphj94U3a8HFIUNW7KBTAu24Kg=;
 b=T3pRM688Kzbng2ER21H71KpJcY2tQv5SHsmj3NETzM5yx4Iaoo5ziKlwUeCEQZBmUU7z33
 s/kxw5RfgiYU/HC2HgeV6CJKxiFGEYSw/z15KdSLwA0enT5LrGWA8I127l067MlyplgRufhB
 DG3ODUc0Njri0/6Ubrm8+X4wSOBqlbMmroMA0j/qu6O+xYP6ddD2H1K7XS7dg6+I38oj48ZU
 Hi/iiBhJowfObGHPceSavKif8fRat7Q9BCHwqszLsTdL/J3GTA5thlA8jS2/b1fC7/w8/B+H
 VNs3MOQI653aGoGy0+xhEKNHmFTBCNj1RNqtugDqtH3g/XZ2CQhx+IuQ==;
Message-ID: <84b0fffcaf89a69225d52fd357d32ba40efcac8c.camel@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 1/2] x86/fpu: dovetail: Fix FPU corruption
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 20 Aug 2025 18:45:28 +0200
In-Reply-To: <878qjeayhv.fsf@xenomai.org>
References: 
	<20250820-wip-flo-fixes-for-dovetail-6-15-v1-0-d44f50cb4b0b@siemens.com>
		<20250820-wip-flo-fixes-for-dovetail-6-15-v1-1-d44f50cb4b0b@siemens.com>
		<87jz2yb6qm.fsf@xenomai.org>
		<e7a3e24a551838ebb00b8174c628c7dd4a6b429a.camel@siemens.com>
	 <878qjeayhv.fsf@xenomai.org>
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

On Wed, 2025-08-20 at 15:55 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Wed, 2025-08-20 at 12:57 +0200, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > Align fpu__suspend_inband() and fpu__resume_inband() regarding the
> > > > PF_KTHREAD handling.
> > > >=20
> > > > The kernel splat looked as follows and could be reproduced by runni=
ng
> > > > the Xenomai 3 testsuite over a stress-ng produced load.
> > > >=20
> > > > [19527.937613] ------------[ cut here ]------------
> > > > [19527.937614] WARNING: CPU: 0 PID: 14 at arch/x86/kernel/fpu/core.=
c:62 x86_task_fpu+0x18/0x30
> > > > [19527.937619] Modules linked in: intel_rapl_msr intel_rapl_common =
intel_pmc_core pmt_telemetry pmt_class intel_pmc_ssram_telemetry intel_vsec=
 ghash_clmulni_intel sha512_ssse3 sha1_ssse3 aesni_intel gf128mul rapl pcsp=
kr button evdev serio_raw joydev sg loop efi_pstore fuse dm_mod drm dax con=
figfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 sr_mod cdrom ata_g=
eneric sd_mod hid_generic hid_hyperv ata_piix psmouse hid hv_netvsc hv_stor=
vsc libata scsi_transport_fc floppy i2c_piix4 i2c_smbus scsi_mod scsi_commo=
n [last unloaded: xeno_can]
> > > > [19527.937635] CPU: 0 UID: 0 PID: 14 Comm: ksoftirqd/0 Not tainted =
6.16.0-hyprv-xenomai-0+ #196 PREEMPT(voluntary)
> > > > [19527.937637] Hardware name: Microsoft Corporation Virtual Machine=
/Virtual Machine, BIOS 090008  12/07/2018
> > > > [19527.937637] IRQ stage: Xenomai
> > > > [19527.937638] RIP: 0010:x86_task_fpu+0x18/0x30
> > > > [19527.937640] Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 90 0f 1f 44 00 00 48 8d 87 00 20 00 00 f6 47 3e 20 75 05 c3 cc cc cc c=
c 90 <0f> 0b 90 31 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f
> > > > [19527.937641] RSP: 0018:ffffba19c0083b60 EFLAGS: 00010002
> > > > [19527.937641] RAX: ffffa0a90133c3c0 RBX: 0000000000000001 RCX: fff=
fa0a93fc5a6e8
> > > > [19527.937642] RDX: 0000000000000000 RSI: 0000000000000007 RDI: fff=
fa0a90133a3c0
> > > > [19527.937643] RBP: ffffa0a93fc5a058 R08: 01364d9cb9685197 R09: fff=
fffff83e406f8
> > > > [19527.937643] R10: 0000000000000000 R11: 0000000000000000 R12: 000=
0000000000001
> > > > [19527.937643] R13: ffffa0a90133a3c0 R14: ffffba19c0c62008 R15: 000=
0000000000001
> > > > [19527.937645] FS:  0000000000000000(0000) GS:ffffa0a9ba664000(0000=
) knlGS:0000000000000000
> > > > [19527.937646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [19527.937646] CR2: 00007f5c694363c0 CR3: 000000003e038004 CR4: 000=
00000003706f0
> > > > [19527.937647] Call Trace:
> > > > [19527.937648]  <TASK>
> > > > [19527.937649]  fpu__suspend_inband+0x3c/0x50
> > > > [19527.937651]  dovetail_context_switch+0x130/0x240
> > > > [19527.937652]  ? xntimer_start+0x101/0x240
> > > > [19527.937656]  ___xnsched_run+0x1f9/0x4d0
> > > > [19527.937659]  run_oob_call+0x87/0x140
> > > > [19527.937662]  handle_irq_pipelined_finish+0x188/0x1a0
> > > > [19527.937664]  arch_pipeline_entry+0x43/0xf0
> > > > [19527.937667]  asm_sysvec_hyperv_stimer0+0x16/0x20
> > > > [19527.937669] RIP: 0010:kernel_fpu_end+0x5/0x50
> > > > [19527.937670] Code: 57 02 e8 9e 12 42 00 31 c0 c3 cc cc cc cc 0f 1=
f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 0=
0 00 <65> 0f b6 05 03 40 57 02 84 c0 75 31 65 c6 05 f7 3f 57 02 01 65 f6
> > > > [19527.937671] RSP: 0018:ffffba19c0083d28 EFLAGS: 00000246
> > > > [19527.937671] RAX: 000000000000000c RBX: 0000000000000001 RCX: fff=
fffff842f2260
> > > > [19527.937672] RDX: 0000000000000000 RSI: ffffffff84c67450 RDI: fff=
fffff84c673e0
> > > > [19527.937672] RBP: 0000000000000001 R08: ffffffff842f2260 R09: 000=
0000000000000
> > > > [19527.937672] R10: ffffffff84a080c0 R11: 0000000000000001 R12: fff=
fffff84c67410
> > > > [19527.937673] R13: ffffffff84c673e0 R14: 0000000000000040 R15: 000=
0000000000004
> > > > [19527.937675]  blake2s_compress+0x52/0xa0
> > > > [19527.937679]  blake2s_update+0x75/0x150
> > > > [19527.937681]  add_timer_randomness+0xac/0x1a0
> > > > [19527.937684]  scsi_end_request+0x297/0x3a0 [scsi_mod]
> > > > [19527.937697]  scsi_io_completion+0x55/0x6a0 [scsi_mod]
> > > > [19527.937707]  blk_done_softirq+0x46/0x60
> > > > [19527.937709]  handle_softirqs+0xd0/0x430
> > > > [19527.937711]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > > > [19527.937713]  run_ksoftirqd+0x47/0x60
> > > > [19527.937714]  smpboot_thread_fn+0xec/0x220
> > > > [19527.937716]  kthread+0xf7/0x240
> > > > [19527.937718]  ? __pfx_kthread+0x10/0x10
> > > > [19527.937720]  ret_from_fork+0x28c/0x310
> > > > [19527.937721]  ? __pfx_kthread+0x10/0x10
> > > > [19527.937722]  ret_from_fork_asm+0x1a/0x30
> > > > [19527.937725]  </TASK>
> > > > [19527.937725] irq event stamp: 1270
> > > > [19527.937726] hardirqs last  enabled at (1269): [<ffffffff830b2b1c=
>] run_ksoftirqd+0x4c/0x60
> > > > [19527.937727] hardirqs last disabled at (1270): [<ffffffff83d90d53=
>] __schedule+0x853/0x1080
> > > > [19527.937729] softirqs last  enabled at (1268): [<ffffffff830b29d6=
>] handle_softirqs+0x346/0x430
> > > > [19527.937730] softirqs last disabled at (1215): [<ffffffff830b2b17=
>] run_ksoftirqd+0x47/0x60
> > > > [19527.937731] ---[ end trace 0000000000000000 ]---
> > > >=20
> > > > Link: https://lore.kernel.org/xenomai/80a48c1ddc3721eb8022b77548028=
aa8e7371928.camel@siemens.com/T/
> > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > ---
> > > >  arch/x86/kernel/fpu/core.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.=
c
> > > > index 7b87a04c0b6e..949f89bb5cdc 100644
> > > > --- a/arch/x86/kernel/fpu/core.c
> > > > +++ b/arch/x86/kernel/fpu/core.c
> > > > @@ -1046,6 +1046,9 @@ void fpu__suspend_inband(void)
> > > >  	struct fpu *kfpu =3D this_cpu_read(in_kernel_fpstate);
> > > >  	struct task_struct *tsk =3D current;
> > > > =20
> > > > +	if (tsk->flags & PF_KTHREAD)
> > > > +		return;
> > > > +
> > > >  	/*
> > > >  	 * If kernel_fpu_allowed is false, we are dealing with the
> > > >  	 * preemption of an inband kernel context currently using the
> > >=20
> > > If an in-band kernel thread is preempted by an oob task while running
> > > inside a kernel_fpu_begin_mask()<->kernel_fpu_end() section, the chan=
ge
> > > above would prevent the fpu hw state from being saved
> > > appropriately. fpu__suspend_inband() and fpu__resume_inband() should =
not
> > > be aligned in this respect, the log is misleading for that reason.
> >=20
> > Let me add some more lines below:
> >=20
> > 	if (!this_cpu_read(kernel_fpu_allowed)) {
> > 		save_fpregs_to_fpstate(kfpu);
> > 		__cpu_invalidate_fpregs_state();
> > 		oob_fpu_set_preempt(x86_task_fpu(tsk));
> > 	}
> >=20
> > x86_task_fpu(tsk) will deliver NULL in case CONFIG_X86_DEBUG_FPU is
> > enabled and (tsk->flags & PF_KTHREAD) is true, so we end up in
> > dereferencing a NULL pointer.
> >=20
> > I think you took care of that during the forward port to 6.16 in
> > fpu__resume_inband() the same way. There is simply no struct fpu
> > reference where we could set the preempted flag.
>=20
> Yeah, but that early exit in fpu__resume_inband() looks wrong now. This
> does silence the warning, but also prevents from reloading the fpu hw
> state from the per-cpu in_kernel_fpstate buffer which is designed to
> hold the fpu context in the preemption case mentioned above.
>=20
> >=20
> > Are kthreads really allowed to use the FPU? Could not find any
> > limitation so far, so we may have to modify x86_task_fpu(tsk) instead?
>=20
> in-band kthreads may enter a fpu-enabled section temporarily by calling
> kernel_fpu_begin_mask() (RAID support used to do so at some point for
> SSE2 IIRC). The explicit check there not to save the hw state when a kthr=
ead
> is running confirms this. As a result, an oob task may preempt such
> context.
>=20
> I believe that x86_task_fpu() should not be called in either routines in
> the first place. The preemption marker should not live in struct fpu.

Where is a better location for it? struct task_struct? I think we have
it in struct fpu for arm64 as well, so in case we decide to move it we
should move it for both archs.

>=20
> --=20
> Philippe.
