Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067D2BDC09
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915670; cv=none; b=LDZH6ddVknY9y5qVpup+10rTqQUi5OXJYk0LOGE2IFE0zSaiKoWDBHKPUi7xE1rqWluCwNuDm3T0rzJqoVco2rBulO0xVA7BWp1THChKwbRJvECL60n93OlU6SF4rh/V0jjG7943BKo21alfqBTVwd0U0lcsWobHbmzjN2eglPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915670; c=relaxed/simple;
	bh=HeTePOeEH+a7YYqBkDvIfnTmOrrl3y9op8u6DDs15DE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FUj/Yiqqb/7vtSc+5A6ZgUfgT33+PtwBPq1FhEtqhlixj2KeDOA8ZIIYYH5YoOpz0mWnSh/SoAHl3QVKS+IRGFWfyH5ntawi72qyaNBkbicCPow35xN09Jw/QEHtz+m6olbkMfaJC0Ks7nT24maPTdBS/zmU+0QDyIkWzh1CKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLzl9a5o; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLzl9a5o"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b84c9775cso871025e9.0
        for <xenomai@lists.linux.dev>; Wed, 03 Sep 2025 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756915666; x=1757520466; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p9mL3O2t0KIpf09NBJ20+bAozW4z/1VVczIvRyxJmuo=;
        b=dLzl9a5oPL5KRHQL4nUChsxa18ermTCSJF+gRDP6YLwItLDkCLC0biCsS9TZCsBKFe
         m0DN1p85OZkCNfrUSvoSk4PIxZfdNWHuGcCWAYOr114CIfNsjUj4YzR6wTuzAsiH6Vqa
         KHBgNErtLfZ5yJuZ+y98DLKWoexg+MABENOHiOnZCAfIw/02uEn/r5mYhLlAzaPlmIyR
         7Ju1FfiepusysnEYoFCqCW+P2kpdFOGWOn5jgQDCa0Mho5WvH4RqsDqo63wmP3QzebKE
         zihbLoe45SZnXuCr/OE0UgwCrlSxxJdm/JvJSjmAjdFqR54KcHqQzcPMbX3bJkVIM1XE
         m1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915666; x=1757520466;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9mL3O2t0KIpf09NBJ20+bAozW4z/1VVczIvRyxJmuo=;
        b=Ujuj2TncDiJw0xaEutcmtIb7AKwq+zsuHXPopnoiAixI3piV0ui2xb9MzDtZmyttnP
         YqLPYNCo8O/WVq8e/O7SiMSJt6JdOe+QTJVEoTBYmg7utDlLdiXAFy1Mvnzu72V+yXjh
         2ZdoKENr2t0CPARckIKl7qKuhZROcOfCaF2/OSSIu5qu6QhGKZhicBR5kGHiHgRrt1HP
         G7uUjGdSgnjHmV+Vg3T/7ySiK+9otrpVR+TfhBKqnw/nIN4wHcE0W5ipKEh8VksHKxRm
         Hv/zycWwJUy7zn8oeJZeklfIEW4RmVI464n9gmYdcicngk2RnM/ncnQMS2yaBNGB7/6I
         ZMcw==
X-Gm-Message-State: AOJu0Yyj/CaKNpi8kHKmvvmyfoSxanhcWKkk1SR3xarc1oS+/Dw6T1Yc
	5EOINakJXKRr88oMzITcnNTPkepIxwoP7YB4tV98+MOQH7KgIpaqoLtfl9MG5OeK
X-Gm-Gg: ASbGncs3qvg1EJSbcLLn9W9Rzz7OGiJ3ESTBiPxq4yw045PpSVWnDjVoWCHUTNJ1a/y
	Fb13CS5rdhQ1qPu+h8JKS5WuH/VI5ibYXHj33+wh9NN2aEbLwzRCjTZkHmhrG431m5eRWGH2eKD
	iZYMvkXE6FBX742ebe+4IlAAAH4g2084mKIQyfHrxhZ8OpV3gNW7W3R93CYxPkPtSkPWmdkdeOP
	2Ly//TvoH0+5669w9fllT+IW0LptWAUZ3YPpWI22Vw7W5UJDZWkbXKMI6GUV9L730N8Pue7vpCk
	Au9iobErsDNKL/A4zXbMWD2aGvSi8ed36T/bc3k2sXjDRGWTeSBRPRLRoZyw4GLZMDqNZ5uULxV
	mMHq2t9wMRNj/ktg=
X-Google-Smtp-Source: AGHT+IFTbYWlLMLbtBKzIFFr1UFNZ7iHRqorZ7Tv8wp31/YsN6prsQaZtVdxHsFXWKIk7SufmfRqtw==
X-Received: by 2002:a05:600c:1ca4:b0:45d:98be:ee8f with SMTP id 5b1f17b1804b1-45d98bef03bmr4454955e9.26.1756915665655;
        Wed, 03 Sep 2025 09:07:45 -0700 (PDT)
Received: from bogeyman ([2a01:e0a:9e1:e390:3656:699e:ad52:5555])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d2250115fdsm18611346f8f.40.2025.09.03.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:07:44 -0700 (PDT)
From: Philippe Gerum <philippe.gerum@gmail.com>
X-Google-Original-From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v2 1/2] x86/fpu: dovetail: Fix FPU corruption
In-Reply-To: <20250820-wip-flo-fixes-for-dovetail-6-15-v2-1-535e4fa355f7@siemens.com>
	(Florian Bezdeka's message of "Fri, 22 Aug 2025 08:55:00 +0200")
References: <20250820-wip-flo-fixes-for-dovetail-6-15-v2-0-535e4fa355f7@siemens.com>
	<20250820-wip-flo-fixes-for-dovetail-6-15-v2-1-535e4fa355f7@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 03 Sep 2025 18:07:43 +0200
Message-ID: <875xdzldtc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> The kernel splat looked as follows and could be reproduced by running
> the Xenomai 3 testsuite over a stress-ng produced load. The problem is
> specific to Dovetail 6.16.
>
> [19527.937613] ------------[ cut here ]------------
> [19527.937614] WARNING: CPU: 0 PID: 14 at arch/x86/kernel/fpu/core.c:62 x86_task_fpu+0x18/0x30
> [19527.937619] Modules linked in: intel_rapl_msr intel_rapl_common intel_pmc_core pmt_telemetry pmt_class intel_pmc_ssram_telemetry intel_vsec ghash_clmulni_intel sha512_ssse3 sha1_ssse3 aesni_intel gf128mul rapl pcspkr button evdev serio_raw joydev sg loop efi_pstore fuse dm_mod drm dax configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 sr_mod cdrom ata_generic sd_mod hid_generic hid_hyperv ata_piix psmouse hid hv_netvsc hv_storvsc libata scsi_transport_fc floppy i2c_piix4 i2c_smbus scsi_mod scsi_common [last unloaded: xeno_can]
> [19527.937635] CPU: 0 UID: 0 PID: 14 Comm: ksoftirqd/0 Not tainted 6.16.0-hyprv-xenomai-0+ #196 PREEMPT(voluntary)
> [19527.937637] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> [19527.937637] IRQ stage: Xenomai
> [19527.937638] RIP: 0010:x86_task_fpu+0x18/0x30
> [19527.937640] Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8d 87 00 20 00 00 f6 47 3e 20 75 05 c3 cc cc cc cc 90 <0f> 0b 90 31 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f
> [19527.937641] RSP: 0018:ffffba19c0083b60 EFLAGS: 00010002
> [19527.937641] RAX: ffffa0a90133c3c0 RBX: 0000000000000001 RCX: ffffa0a93fc5a6e8
> [19527.937642] RDX: 0000000000000000 RSI: 0000000000000007 RDI: ffffa0a90133a3c0
> [19527.937643] RBP: ffffa0a93fc5a058 R08: 01364d9cb9685197 R09: ffffffff83e406f8
> [19527.937643] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [19527.937643] R13: ffffa0a90133a3c0 R14: ffffba19c0c62008 R15: 0000000000000001
> [19527.937645] FS:  0000000000000000(0000) GS:ffffa0a9ba664000(0000) knlGS:0000000000000000
> [19527.937646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19527.937646] CR2: 00007f5c694363c0 CR3: 000000003e038004 CR4: 00000000003706f0
> [19527.937647] Call Trace:
> [19527.937648]  <TASK>
> [19527.937649]  fpu__suspend_inband+0x3c/0x50
> [19527.937651]  dovetail_context_switch+0x130/0x240
> [19527.937652]  ? xntimer_start+0x101/0x240
> [19527.937656]  ___xnsched_run+0x1f9/0x4d0
> [19527.937659]  run_oob_call+0x87/0x140
> [19527.937662]  handle_irq_pipelined_finish+0x188/0x1a0
> [19527.937664]  arch_pipeline_entry+0x43/0xf0
> [19527.937667]  asm_sysvec_hyperv_stimer0+0x16/0x20
> [19527.937669] RIP: 0010:kernel_fpu_end+0x5/0x50
> [19527.937670] Code: 57 02 e8 9e 12 42 00 31 c0 c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <65> 0f b6 05 03 40 57 02 84 c0 75 31 65 c6 05 f7 3f 57 02 01 65 f6
> [19527.937671] RSP: 0018:ffffba19c0083d28 EFLAGS: 00000246
> [19527.937671] RAX: 000000000000000c RBX: 0000000000000001 RCX: ffffffff842f2260
> [19527.937672] RDX: 0000000000000000 RSI: ffffffff84c67450 RDI: ffffffff84c673e0
> [19527.937672] RBP: 0000000000000001 R08: ffffffff842f2260 R09: 0000000000000000
> [19527.937672] R10: ffffffff84a080c0 R11: 0000000000000001 R12: ffffffff84c67410
> [19527.937673] R13: ffffffff84c673e0 R14: 0000000000000040 R15: 0000000000000004
> [19527.937675]  blake2s_compress+0x52/0xa0
> [19527.937679]  blake2s_update+0x75/0x150
> [19527.937681]  add_timer_randomness+0xac/0x1a0
> [19527.937684]  scsi_end_request+0x297/0x3a0 [scsi_mod]
> [19527.937697]  scsi_io_completion+0x55/0x6a0 [scsi_mod]
> [19527.937707]  blk_done_softirq+0x46/0x60
> [19527.937709]  handle_softirqs+0xd0/0x430
> [19527.937711]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [19527.937713]  run_ksoftirqd+0x47/0x60
> [19527.937714]  smpboot_thread_fn+0xec/0x220
> [19527.937716]  kthread+0xf7/0x240
> [19527.937718]  ? __pfx_kthread+0x10/0x10
> [19527.937720]  ret_from_fork+0x28c/0x310
> [19527.937721]  ? __pfx_kthread+0x10/0x10
> [19527.937722]  ret_from_fork_asm+0x1a/0x30
> [19527.937725]  </TASK>
> [19527.937725] irq event stamp: 1270
> [19527.937726] hardirqs last  enabled at (1269): [<ffffffff830b2b1c>] run_ksoftirqd+0x4c/0x60
> [19527.937727] hardirqs last disabled at (1270): [<ffffffff83d90d53>] __schedule+0x853/0x1080
> [19527.937729] softirqs last  enabled at (1268): [<ffffffff830b29d6>] handle_softirqs+0x346/0x430
> [19527.937730] softirqs last disabled at (1215): [<ffffffff830b2b17>] run_ksoftirqd+0x47/0x60
> [19527.937731] ---[ end trace 0000000000000000 ]---
>
> The main problem was the x86_task_fpu(tsk) helper, which will deliver
> NULL in case CONFIG_X86_DEBUG_FPU is enabled and
> (tsk->flags & PF_KTHREAD) is true. We ended up in dereferencing a
> NULL pointer.
>
> This problem could be fixed by not using the x86_task_fpu().
> But:
>   - It seems that the location of struct fpu is under development.
>   - Moving the preemption marker from struct fpu to
>     struct thread_info::flags synchronizes the amd64 and arm64
>     implementation.
>
> Second, the early exit in fpu__resume_inband() was wrong, as that
> prevented the FPU restore of in-band kthreads.
>
> Link: https://lore.kernel.org/xenomai/80a48c1ddc3721eb8022b77548028aa8e7371928.camel@siemens.com/T/
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/include/asm/fpu/sched.h   | 17 ++++-------------
>  arch/x86/include/asm/fpu/types.h   | 12 ------------
>  arch/x86/include/asm/thread_info.h |  1 +
>  arch/x86/kernel/fpu/core.c         | 12 ++++--------
>  4 files changed, 9 insertions(+), 33 deletions(-)
>
> diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
> index ba677ffa4fbb..2b66960accd4 100644
> --- a/arch/x86/include/asm/fpu/sched.h
> +++ b/arch/x86/include/asm/fpu/sched.h
> @@ -18,19 +18,9 @@ extern void fpu_flush_thread(void);
>  
>  #ifdef CONFIG_DOVETAIL
>  
> -static inline void oob_fpu_set_preempt(struct fpu *fpu)
> +static inline bool oob_fpu_preempted(struct thread_info *old_ti)
>  {
> -	fpu->preempted = true;
> -}
> -
> -static inline void oob_fpu_clear_preempt(struct fpu *fpu)
> -{
> -	fpu->preempted = false;
> -}
> -
> -static inline bool oob_fpu_preempted(struct fpu *old_fpu)
> -{
> -	return old_fpu->preempted;
> +	return test_thread_flag(TIF_KERNEL_FP_PREEMPTED);
>  }
>  
>  #else
> @@ -60,9 +50,10 @@ static inline void switch_fpu(struct task_struct *old, int cpu)
>  {
>  	if (!test_tsk_thread_flag(old, TIF_NEED_FPU_LOAD) &&
>  		cpu_feature_enabled(X86_FEATURE_FPU)) {
> +		struct thread_info *old_ti = task_thread_info(old);
>  		struct fpu *old_fpu = x86_task_fpu(old);
>  		if (!(old->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
> -			!oob_fpu_preempted(old_fpu)) {
> +			!oob_fpu_preempted(old_ti)) {
>  			set_tsk_thread_flag(old, TIF_NEED_FPU_LOAD);
>  			save_fpregs_to_fpstate(old_fpu);
>  			/*
> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> index c329a878a581..1c94121acd3d 100644
> --- a/arch/x86/include/asm/fpu/types.h
> +++ b/arch/x86/include/asm/fpu/types.h
> @@ -473,18 +473,6 @@ struct fpu {
>  	 */
>  	unsigned int			last_cpu;
>  
> -#ifdef CONFIG_DOVETAIL
> -	/*
> -	 * @preempted:
> -	 *
> -	 * When Dovetail is enabled, this flag is set for the inband
> -	 * task context saved when entering a kernel_fpu_begin/end()
> -	 * section before the latter got preempted by an out-of-band
> -	 * task.
> -	 */
> -	bool				preempted : 1;
> -#endif
> -
>  	/*
>  	 * @avx512_timestamp:
>  	 *
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 77c4c632cef2..53f11b73d0f0 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -94,6 +94,7 @@ struct thread_info {
>  #define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling needed */
>  #define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
>  #define TIF_SSBD		6	/* Speculative store bypass disable */
> +#define TIF_KERNEL_FP_PREEMPTED	7	/* Dovetail: kernel mode
> FPU section preempted by OOB */

Only the current task may set/clear/read this flag, so the latter should
rather go to the TLF (synchronous) section. As a consequence, non-atomic
ops would be enough to access it.

>  #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
>  #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
>  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 7b87a04c0b6e..6d185ad1a996 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -1044,7 +1044,6 @@ static int fpu__drop_kernel_fpstate(unsigned int cpu)
>  void fpu__suspend_inband(void)
>  {
>  	struct fpu *kfpu = this_cpu_read(in_kernel_fpstate);
> -	struct task_struct *tsk = current;
>  
>  	/*
>  	 * If kernel_fpu_allowed is false, we are dealing with the
> @@ -1054,23 +1053,20 @@ void fpu__suspend_inband(void)
>  	if (!this_cpu_read(kernel_fpu_allowed)) {
>  		save_fpregs_to_fpstate(kfpu);
>  		__cpu_invalidate_fpregs_state();
> -		oob_fpu_set_preempt(x86_task_fpu(tsk));
> +		set_thread_flag(TIF_KERNEL_FP_PREEMPTED);
>  	}
>  }
>  
>  void fpu__resume_inband(void)
>  {
>  	struct fpu *kfpu = this_cpu_read(in_kernel_fpstate);
> -	struct task_struct *tsk = current;
>  
> -	if (tsk->flags & PF_KTHREAD)
> -		return;
> -
> -	if (oob_fpu_preempted(x86_task_fpu(tsk))) {
> +	if (test_and_clear_thread_flag(TIF_KERNEL_FP_PREEMPTED)) {

In most cases, we won't need to clear this flag, so a split
test then clear-if-set approach would be more efficient.

-- 
Philippe.
