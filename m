Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B900F2749C6
	for <xenomai@lists.linux.dev>; Wed, 20 Aug 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699707; cv=none; b=Pr3/Z1JzX6P6zcfbiCfIlxKTvoSOSqJssN1nJNcGI5qdyYjfPu9/Ttwcg9OJsMffyKPUf4rtNsgWQ5LrshZvcX3h1tRx+UY3YlAjxOSCj0en8PjgbIu68tvsnBuHMSGaT3cUbnLM08ikKfeZooRHheulHgY8N70FzoSRhILwyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699707; c=relaxed/simple;
	bh=6P9WJxwiZ4n6PT0qhwEXkBje0nDnLqVy1TFq59eZavA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HHRmpMeoeDhzQHR6UjTRZCUXUXl/OkyHaVATV3o3Raqb80+HFEFX1rUJC6O6wG23+sntSy1gFj7ciNOG38bR3Z2/pgt3oP32notQgMK8lXOVUmydVEzV3QYD9UlZygPPQAj55XzdU8jHcUKTc/9+rgTV46TrWR84+xzdCZjbKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ArS+dBH/; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ArS+dBH/"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B65AD4420D;
	Wed, 20 Aug 2025 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1755699697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7kbkKWt47JPChn0GJON2XukwuBy0qJfachuXThUW+Sk=;
	b=ArS+dBH/EWDQ+lSGyhyLZusBiqNtJKU7XWmdKTNbGYymP3L0uQQlClCrfSIF/v9FyLJmHv
	oD+5FeY0SKY88rkd6MEswYAi4lYXwyLfxxffoL3kkObd9VftupxzR74/9XB+HBZl9kn5gc
	Yx3CDEAKZCoK4OQV5FwOAY4Ww3G+3SqbXFdq6QorOss3BK7lo1BKY6MZkXsu/BSOKoTY0+
	+8XkSpLnubiu7A9pINllOH2fvpRnAC6UtWgNw9c/I3jUcYpCfZDV+8TSXMcApAH+AP83Dj
	mmDPsKbg3SbcNRHXrs+bmuKYXCsleDfN6wWWN+Jn6eQFPC5ywsG89BN9EWMW9A==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 1/2] x86/fpu: dovetail: Fix FPU corruption
In-Reply-To: <20250820-wip-flo-fixes-for-dovetail-6-15-v1-1-d44f50cb4b0b@siemens.com>
	(Florian Bezdeka's message of "Wed, 20 Aug 2025 00:53:35 +0200")
References: <20250820-wip-flo-fixes-for-dovetail-6-15-v1-0-d44f50cb4b0b@siemens.com>
	<20250820-wip-flo-fixes-for-dovetail-6-15-v1-1-d44f50cb4b0b@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 20 Aug 2025 16:21:35 +0200
Message-ID: <87tt229iq8.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeffffekleffvdfhffejudethedufedtheduffffvdduudejvdehvdehjeejleehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Align fpu__suspend_inband() and fpu__resume_inband() regarding the
> PF_KTHREAD handling.
>
> The kernel splat looked as follows and could be reproduced by running
> the Xenomai 3 testsuite over a stress-ng produced load.
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
> Link: https://lore.kernel.org/xenomai/80a48c1ddc3721eb8022b77548028aa8e7371928.camel@siemens.com/T/
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/kernel/fpu/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 7b87a04c0b6e..949f89bb5cdc 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -1046,6 +1046,9 @@ void fpu__suspend_inband(void)
>  	struct fpu *kfpu = this_cpu_read(in_kernel_fpstate);
>  	struct task_struct *tsk = current;
>  
> +	if (tsk->flags & PF_KTHREAD)
> +		return;
> +
>  	/*
>  	 * If kernel_fpu_allowed is false, we are dealing with the
>  	 * preemption of an inband kernel context currently using the

IIRC, in x3, switchtest -s should exercise the code path involving
preemption of a kernel_fpu section by an oob task. This code is guarded
by fp_linux_begin() in the switchtest driver, which enables such test
for x86, disables it for other archs.

-- 
Philippe.
