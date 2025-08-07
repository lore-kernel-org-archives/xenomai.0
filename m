Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6081C8633
	for <xenomai@lists.linux.dev>; Thu,  7 Aug 2025 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604324; cv=none; b=hpXm48tTGjqxPTHwXW6V2CSIgEnerYDHCmkFxXtn3b3HyIpxJ5Hbci7D5rpdYrUK6wKiUyuWwt+CCzzKOp4zMu+iID8orBlWXv42eAGLzGYa4lpa3uUBcIZ+wmcXFCE+SzDj76+eknjVeKYzGUGmUp/Ss4mVmsGje5l2fKKxAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604324; c=relaxed/simple;
	bh=HcDk7Otx4QQIxqoQiXt5nUV3EsX1J2gAaKwy7HL9KjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UMVRMGOz/CQf+SIEHjzNIhRjv4FQmdUcyBvCD1v5LPbmZu0StXDhqhIqWmM1oeprk7k+PdmzGGXKdm3PE9NQ4AyzvSCnDts2MRKV8ECWQnc2dB9g10fhZpjwzxTkgsBydl6+h4ujlzFEH9ezGJ6TfYLDAO0+JOuXqGzjRvyRhw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=BTZAX2E9; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="BTZAX2E9"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 48EF6430D1;
	Thu,  7 Aug 2025 22:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1754604319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/y2d8Jw4vfAR6ehLJ2+VDX7GZsiWYmXnpr8aCTJA8QM=;
	b=BTZAX2E9ARIfZ91dkp2wPF+Cmjb1r7eWi5/SIGxmxS4KDSyrErhVS914doqJJbRZcJhUe3
	MkfeHGQJYBRmpoA5q1M3WX1bF3uNrMlCV+p331IKD34r9JcfWJmBT9/VE12ZTWsrXPOG6k
	nMZ6tS7XT7Xl71VHyw5to5Dz54VjY6D6B3dQT1d0ZAaNb9FFkMpxnWheLw6aLTKeSSWs+9
	h2hcdRZVmrrHPq8Go4O/s8f11WHrPHu0pdFoHYzKxeOxcOBbGFzXq4VEkeb/lihEyAcZfe
	iaezz0FTs7NGssFXoHPfQIDig0/gpurGjgLWksz5Sz+YGkpjCn0DyPKdmiIdiQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Dovetail 6.16: FPU corruption on x86
In-Reply-To: <4ec97a396ab11101e0fe247828038d09611bbe9d.camel@siemens.com>
	(Florian Bezdeka's message of "Thu, 07 Aug 2025 23:27:58 +0200")
References: <4ec97a396ab11101e0fe247828038d09611bbe9d.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 08 Aug 2025 00:05:12 +0200
Message-ID: <87o6sqbxev.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddvtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> I run into the following splat when stressing Dovetail 6.16 on x86 with
> stress-ng and trying to execute the Xenomai 3 testsuite in parallel.
>
> That did not happen with 6.15, so I'm quite sure that we missed
> something when adapting to latest FPU changes. Likely around
> PF_KTHREAD, maybe inside fpu__resume_inband().
>
> The splat:
>
> [19527.937613] ------------[ cut here ]------------
> [19527.937614] WARNING: CPU: 0 PID: 14 at arch/x86/kernel/fpu/core.c:62 x86_task_fpu+0x18/0x30
> [19527.937619] Modules linked in: intel_rapl_msr intel_rapl_common
> intel_pmc_core pmt_telemetry pmt_class intel_pmc_ssram_telemetry
> intel_vsec ghash_clmulni_intel sha512_ssse3 sha1_ssse3 aesni_intel
> gf128mul rapl pcspkr button evdev serio_raw joydev sg loop efi_pstore
> fuse dm_mod drm dax configfs ip_tables x_tables autofs4 ext4 crc16
> mbcache jbd2 sr_mod cdrom ata_generic sd_mod hid_generic hid_hyperv
> ata_piix psmouse hid hv_netvsc hv_storvsc libata scsi_transport_fc
> floppy i2c_piix4 i2c_smbus scsi_mod scsi_common [last unloaded:
> xeno_can]
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
> Please note that this is happening on my not-yet-finished hyper-v
> enablement branch. But as this seems 6.16 specific I'm optimistic that
> something went wrong during the last forword port.
>

Yes, most likely. The changes were non-trivial there. I can have a look
at this sometime next week.

-- 
Philippe.
