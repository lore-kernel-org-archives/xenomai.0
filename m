Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD082145B27
	for <xenomai@lists.linux.dev>; Thu,  7 Aug 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754602093; cv=none; b=Rfz5PVcBUoizahdJPScSInjd66iNJBGdYq8webFNRvT3co3Qhjfcs6fuIsgnYcQoqD+iqVxZAooCIb6y7z9AsTLPhsTq+1PQQe4KAoEGtvhaBLGNxmwb7AQmc8FEfpLfrau3OFIqGHR9HNG64quCp+j+wGqzB7UPNp1WJxndAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754602093; c=relaxed/simple;
	bh=QtJKzWm9TTBpyeJN+dEYF9RiMKwxu74FhnllQUXO704=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Im9zvz1h80HewVt5bj4rKZ0RvW77NqczMMmRZbHaATzSYkLiHNf9KUnuY+EWt+Qqvq1lscaOkK2piKnLELkG/TN4yu7ECeCdKIO80bvkJYSJ9PLdRNSl+hbtIPkQYjE/myy74JESlseu0mZYqf99NL+5T0lRMu8cXid5KoJTqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=X21dqlSD; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="X21dqlSD"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202508072127595dc437668a21a53ef6
        for <xenomai@lists.linux.dev>;
        Thu, 07 Aug 2025 23:27:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=uJ5Gj3FWkLBUHRjBt7aSXzdlqTXt2ejtCJIiEqnrkPA=;
 b=X21dqlSDPJyebgX6Ueho5mexT6LniEeyPz4Nk9D8ElPRWpbfrqh+cbubGzuBEOusxn3YpH
 H9u3FLQzb4d8FFuSXuGS1HrxBPsOTavsjh0tbHMM0f2jifP4XIfl2FPwPiUnvth4ml7I2OXJ
 9KW/L2WnU9zr6w+SZGJ7yGnHomqG7Tf6nRLEJKDA7JEwULIBHHLHl61HrSYwAiSJdxsT2sEx
 BvLti96lb0zUZiMxe2DvMIELvBIjom52HFvZnmF51IiJvP7mdFI5Jcw7tfkclGVybznEIOpp
 M9r96SfGmvcfRc0mzgc40oKOhygp6L4LEAn7gmP7gn5VSGTE8osTd2JQ==;
Message-ID: <4ec97a396ab11101e0fe247828038d09611bbe9d.camel@siemens.com>
Subject: Dovetail 6.16: FPU corruption on x86
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Date: Thu, 07 Aug 2025 23:27:58 +0200
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

Hi Philippe,

I run into the following splat when stressing Dovetail 6.16 on x86 with
stress-ng and trying to execute the Xenomai 3 testsuite in parallel.

That did not happen with 6.15, so I'm quite sure that we missed
something when adapting to latest FPU changes. Likely around
PF_KTHREAD, maybe inside fpu__resume_inband().

The splat:

[19527.937613] ------------[ cut here ]------------
[19527.937614] WARNING: CPU: 0 PID: 14 at arch/x86/kernel/fpu/core.c:62 x86=
_task_fpu+0x18/0x30
[19527.937619] Modules linked in: intel_rapl_msr intel_rapl_common intel_pm=
c_core pmt_telemetry pmt_class intel_pmc_ssram_telemetry intel_vsec ghash_c=
lmulni_intel sha512_ssse3 sha1_ssse3 aesni_intel gf128mul rapl pcspkr butto=
n evdev serio_raw joydev sg loop efi_pstore fuse dm_mod drm dax configfs ip=
_tables x_tables autofs4 ext4 crc16 mbcache jbd2 sr_mod cdrom ata_generic s=
d_mod hid_generic hid_hyperv ata_piix psmouse hid hv_netvsc hv_storvsc liba=
ta scsi_transport_fc floppy i2c_piix4 i2c_smbus scsi_mod scsi_common [last =
unloaded: xeno_can]
[19527.937635] CPU: 0 UID: 0 PID: 14 Comm: ksoftirqd/0 Not tainted 6.16.0-h=
yprv-xenomai-0+ #196 PREEMPT(voluntary)
[19527.937637] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS 090008  12/07/2018
[19527.937637] IRQ stage: Xenomai
[19527.937638] RIP: 0010:x86_task_fpu+0x18/0x30
[19527.937640] Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 =
0f 1f 44 00 00 48 8d 87 00 20 00 00 f6 47 3e 20 75 05 c3 cc cc cc cc 90 <0f=
> 0b 90 31 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f
[19527.937641] RSP: 0018:ffffba19c0083b60 EFLAGS: 00010002
[19527.937641] RAX: ffffa0a90133c3c0 RBX: 0000000000000001 RCX: ffffa0a93fc=
5a6e8
[19527.937642] RDX: 0000000000000000 RSI: 0000000000000007 RDI: ffffa0a9013=
3a3c0
[19527.937643] RBP: ffffa0a93fc5a058 R08: 01364d9cb9685197 R09: ffffffff83e=
406f8
[19527.937643] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00001
[19527.937643] R13: ffffa0a90133a3c0 R14: ffffba19c0c62008 R15: 00000000000=
00001
[19527.937645] FS:  0000000000000000(0000) GS:ffffa0a9ba664000(0000) knlGS:=
0000000000000000
[19527.937646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19527.937646] CR2: 00007f5c694363c0 CR3: 000000003e038004 CR4: 00000000003=
706f0
[19527.937647] Call Trace:
[19527.937648]  <TASK>
[19527.937649]  fpu__suspend_inband+0x3c/0x50
[19527.937651]  dovetail_context_switch+0x130/0x240
[19527.937652]  ? xntimer_start+0x101/0x240
[19527.937656]  ___xnsched_run+0x1f9/0x4d0
[19527.937659]  run_oob_call+0x87/0x140
[19527.937662]  handle_irq_pipelined_finish+0x188/0x1a0
[19527.937664]  arch_pipeline_entry+0x43/0xf0
[19527.937667]  asm_sysvec_hyperv_stimer0+0x16/0x20
[19527.937669] RIP: 0010:kernel_fpu_end+0x5/0x50
[19527.937670] Code: 57 02 e8 9e 12 42 00 31 c0 c3 cc cc cc cc 0f 1f 80 00 =
00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <65=
> 0f b6 05 03 40 57 02 84 c0 75 31 65 c6 05 f7 3f 57 02 01 65 f6
[19527.937671] RSP: 0018:ffffba19c0083d28 EFLAGS: 00000246
[19527.937671] RAX: 000000000000000c RBX: 0000000000000001 RCX: ffffffff842=
f2260
[19527.937672] RDX: 0000000000000000 RSI: ffffffff84c67450 RDI: ffffffff84c=
673e0
[19527.937672] RBP: 0000000000000001 R08: ffffffff842f2260 R09: 00000000000=
00000
[19527.937672] R10: ffffffff84a080c0 R11: 0000000000000001 R12: ffffffff84c=
67410
[19527.937673] R13: ffffffff84c673e0 R14: 0000000000000040 R15: 00000000000=
00004
[19527.937675]  blake2s_compress+0x52/0xa0
[19527.937679]  blake2s_update+0x75/0x150
[19527.937681]  add_timer_randomness+0xac/0x1a0
[19527.937684]  scsi_end_request+0x297/0x3a0 [scsi_mod]
[19527.937697]  scsi_io_completion+0x55/0x6a0 [scsi_mod]
[19527.937707]  blk_done_softirq+0x46/0x60
[19527.937709]  handle_softirqs+0xd0/0x430
[19527.937711]  ? __pfx_smpboot_thread_fn+0x10/0x10
[19527.937713]  run_ksoftirqd+0x47/0x60
[19527.937714]  smpboot_thread_fn+0xec/0x220
[19527.937716]  kthread+0xf7/0x240
[19527.937718]  ? __pfx_kthread+0x10/0x10
[19527.937720]  ret_from_fork+0x28c/0x310
[19527.937721]  ? __pfx_kthread+0x10/0x10
[19527.937722]  ret_from_fork_asm+0x1a/0x30
[19527.937725]  </TASK>
[19527.937725] irq event stamp: 1270
[19527.937726] hardirqs last  enabled at (1269): [<ffffffff830b2b1c>] run_k=
softirqd+0x4c/0x60
[19527.937727] hardirqs last disabled at (1270): [<ffffffff83d90d53>] __sch=
edule+0x853/0x1080
[19527.937729] softirqs last  enabled at (1268): [<ffffffff830b29d6>] handl=
e_softirqs+0x346/0x430
[19527.937730] softirqs last disabled at (1215): [<ffffffff830b2b17>] run_k=
softirqd+0x47/0x60
[19527.937731] ---[ end trace 0000000000000000 ]---

Please note that this is happening on my not-yet-finished hyper-v
enablement branch. But as this seems 6.16 specific I'm optimistic that
something went wrong during the last forword port.

Best regards,
Florian
