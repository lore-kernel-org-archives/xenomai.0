Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4522A4DA
	for <xenomai@lists.linux.dev>; Wed,  4 Jun 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749038150; cv=none; b=sDIp6gZw0lio4mT2lOM2K8TMEeHUax7A4oKLcyo86uCtBqWhrxRxqiQGJnyaIkC4o6uH+f9coCtCfRwM3rPcTyZPohvQJ7qgVR1OnEXCe9cf0+88XN5BWA5HNYHw2rKo7gTZbI/K0UbZqYitPaAlnuCR1GdNz3C+hv/UASDVLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749038150; c=relaxed/simple;
	bh=YH/kWeGp0pT7AZ0O8HV3oxFBwKQa3KZcGvAPdEVQ4sA=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=e005l/n0RxGbCaL/qR+XXm2R23Ke+bN4tU15md2dXJmOXLHKGs+gaNymNnT4Mv3j7A1EyKxAYja0Wpyc7re+C9dUncOoUdB3noq0c4TlCQWtwNEYcMOE81L8rISSBdMmbwNl7F4AuZBgZZfSh5s+UEFSd/dJKU8IxudVCCvuOm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=uIrdLuvQ; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="uIrdLuvQ"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250604111524ce8ce0627b861616bd
        for <xenomai@lists.linux.dev>;
        Wed, 04 Jun 2025 13:15:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=DvjCaX9Nofl7QSuUyTyTAUscA89gpOIheLmepq7HSKs=;
 b=uIrdLuvQ8WAosch0OB+G/iKxrAoG4VKNzwjIVy+29Upf5in9uh/KkbzrY7vGBXUWp+kj+/
 P0bZoUYUgQ/cC633TFQNd/+zbRMIvHJyUTliDuCDzged2MDikJait7ntRSzpNU684Q9+eQM0
 oDhNQAuiSdIJbT86u0N6LY5BWldtMmhdZt2m0Ew6js2y1BWTVkWQsudxdY/oNLTMF38uanqV
 XWDypPXgtf3DiGOjR97XRTVcXu6RFlBbsJE0fIjrNlZbSCd/8xPmOZAM68yRFSXN2aF5vMxl
 m1IsRAAdVoS3ct9fIMMmD4JwLXusDP5+ldy5SBRcNe7ClNRVKEfX/5MA==;
Message-ID: <954e1b69e7ccb2e1abf7f82d2bcb109e3cd1ac24.camel@siemens.com>
Subject: Dovetail: Adding support for Hyper-v as hypervisor
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 04 Jun 2025 13:15:23 +0200
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

I'm currently experimenting with hyper-v as Hypervisor for dovetail. So
far so good, I'm able to boot the system and the system survives a
inband stress test. The necessary modifications can be found at [1].

But: Running the Xenomai 3 testsuite - especially the gdb test -
freezes the system immediately.

When enabling pipeline and dovetail debug options I get the following
splat report. Ideas welcome...

The following is a mix of two WARN() invocations. I'm assuming
everything around exc_invalid_op() is a follow up problem, as WARN()
triggers the invalid_op trap. Anyway, I copied it unmodified as I got
it over the UART to avoid any mistake while cleaning up.

I think it's worth to mention that there is a strange comment in
hv_qlock_wait() - which I already touched - that expresses that hyper-v
might inject an IRQ on a vcpu with hard IRQs disabled...

[    1.069032] ------------[ cut here ]------------
[    1.069035] Key type blacklist registered
[    1.070098] hard irqs on posting IRQ27 to Linux
[    1.070098] ------------[ cut here ]------------
[    1.070098] DEBUG_LOCKS_WARN_ON(running_inband() && lockdep_hardirq_cont=
ext())
[    1.070098] WARNING: CPU: 0 PID: 28 at kernel/locking/lockdep.c:4457 loc=
kdep_hardirqs_on_prepare+0x112/0x1b0
[    1.070098] Modules linked in:
[    1.070098] CPU: 0 UID: 0 PID: 28 Comm: kworker/u8:1 Tainted: G        W=
           6.15.0-hyprv-xenomai-0+ #49 PREEMPT(voluntary)
[    1.070098] Tainted: [W]=3DWARN
[    1.070098] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS 090008  12/07/2018
[    1.070098] IRQ stage: Linux
[    1.070098] Workqueue: async async_run_entry_fn
[    1.070098] RIP: 0010:lockdep_hardirqs_on_prepare+0x112/0x1b0
[    1.070098] Code: 64 ff ff ff e8 cf 9f 5c 00 85 c0 74 ad 8b 15 35 21 bb =
01 85 d2 75 a3 48 c7 c6 e0 2e 2c 93 48 c7 c7 90 32 2a 93 e8 ee 0d f6 ff <0f=
> 0b eb 8c be 06 00 00 00 48 89 df e8 4d fe ff ff e9 64 ff ff ff
[    1.070098] RSP: 0000:ffffb22680003ed0 EFLAGS: 00010082
[    1.070098] RAX: 0000000000000000 RBX: ffffb22680003f38 RCX: 00000000000=
00027
[    1.070098] RDX: ffff896c3ec1bc08 RSI: 0000000000000001 RDI: ffff896c3ec=
1bc00
[    1.070098] RBP: 0000000000000246 R08: 0000000000000486 R09: 00000000000=
00000
[    1.070098] R10: 00000000ffffffff R11: 0000000000000004 R12: 00000000000=
00000
[    1.070098] R13: ffffffff92184d7e R14: 0000000000000000 R15: 00000000000=
00000
[    1.070098] FS:  0000000000000000(0000) GS:ffff896caa667000(0000) knlGS:=
0000000000000000
[    1.070098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.070098] CR2: ffff896c26202000 CR3: 000000002483a001 CR4: 00000000003=
706f0
[    1.070098] Call Trace:
[    1.070098]  <IRQ>
[    1.070098]  ? irq_post_stage+0x8c/0xc0
[    1.070098]  trace_hardirqs_on+0x53/0xc0
[    1.070098]  handle_bug+0x1ca/0x1e0
[    1.070098]  exc_invalid_op+0xae/0xc0
[    1.070098]  asm_exc_invalid_op+0x16/0x20
[    1.070098] RIP: 0010:irq_post_stage+0x8c/0xc0
[    1.070098] Code: 12 48 0f ab 30 c3 cc cc cc cc 80 3d 06 4e b4 01 00 75 =
f2 48 8b 57 08 48 c7 c7 98 81 2c 93 c6 05 f2 4d b4 01 01 e8 c4 3e f3 ff <0f=
> 0b c3 cc cc cc cc 80 3d de 4d b4 01 00 75 cb 48 8b 57 08 48 c7
[    1.070098] RSP: 0000:ffffb22680003fe0 EFLAGS: 00010286
[    1.070098] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00202
[    1.070098] RDX: 0000000080010002 RSI: 0000000000000000 RDI: 00000000000=
00001
[    1.070098] RBP: ffff896c011f3400 R08: 000000000000005b R09: 000000004b4=
c332f
[    1.070098] R10: 00000000ffffffff R11: 00000000ffffffff R12: 00000000000=
80105
[    1.070098] R13: 00000000000000ed R14: 0000000000000000 R15: 00000000000=
00000
[    1.070098]  __sysvec_hyperv_stimer0+0x2b/0x50
[    1.070098]  arch_do_IRQ_pipelined+0x23c/0x560
[    1.070098]  </IRQ>
[    1.070098]  <TASK>
[    1.070098]  sync_current_irq_stage+0x191/0x230
[    1.070098]  handle_irq_pipelined_finish+0x7b/0x1a0
[    1.070098]  arch_pipeline_entry+0xaa/0xf0
[    1.070098]  asm_sysvec_hyperv_stimer0+0x16/0x20
[    1.070098] RIP: 0010:ZSTD_decompressSequences_bmi2.constprop.0+0x62a/0x=
a80
[    1.070098] Code: 08 48 8b 58 08 48 83 c7 20 48 83 c0 20 48 89 4f e0 48 =
89 5f e8 48 8b 48 f0 48 8b 58 f8 48 89 4f f0 48 89 5f f8 48 39 d7 72 d4 <49=
> 83 fe 88 0f 87 25 fb ff ff 4d 01 f5 83 ad 34 ff ff ff 01 0f 85
[    1.070098] RSP: 0000:ffffb226800ffa10 EFLAGS: 00000283
[    1.070098] RAX: ffffb226807b4fc9 RBX: 000000000000000b RCX: ffffb226803=
fa41c
[    1.070098] RDX: 000000000038b951 RSI: ffffb226804296d8 RDI: ffffb226807=
b5029
[    1.070098] RBP: ffffb226800ffb50 R08: 040000000000003d R09: fc000002850=
00000
[    1.070098] R10: 0000000000000003 R11: 000000000000009f R12: 00000000000=
00060
[    1.070098] R13: ffffb226807b5028 R14: 000000000000000c R15: 00000000000=
55518
[    1.070098]  ZSTD_decompressContinue.part.0+0x359/0x490
[    1.070098]  ZSTD_decompressContinueStream+0x96/0x150
[    1.070098]  ZSTD_decompressStream+0x7c3/0xc00
[    1.070098]  ? __pfx_flush_buffer+0x10/0x10
[    1.070098]  ? __pfx_error+0x10/0x10
[    1.070098]  unzstd+0x340/0x570
[    1.070098]  ? __pfx_unzstd+0x10/0x10
[    1.070098]  unpack_to_rootfs+0x144/0x3a0
[    1.070098]  ? __pfx_error+0x10/0x10
[    1.070098]  ? _printk+0x5f/0x80
[    1.070098]  ? do_populate_rootfs+0x124/0x1d0
[    1.070098]  do_populate_rootfs+0x124/0x1d0
[    1.070098]  ? ktime_get+0x83/0x180
[    1.070098]  async_run_entry_fn+0x2d/0x130
[    1.070098]  process_one_work+0x22d/0x6d0
[    1.070098]  worker_thread+0x184/0x320
[    1.070098]  ? __pfx_worker_thread+0x10/0x10
[    1.070098]  kthread+0xfa/0x240
[    1.070098]  ? __pfx_kthread+0x10/0x10
[    1.070098]  ret_from_fork+0x2d/0x50
[    1.070098]  ? __pfx_kthread+0x10/0x10
[    1.070098]  ret_from_fork_asm+0x1a/0x30
[    1.070098]  </TASK>
[    1.070098] irq event stamp: 14192
[    1.070098] hardirqs last  enabled at (14191): [<ffffffff92d7c95a>] arch=
_pipeline_entry+0x8a/0xf0
[    1.070098] hardirqs last disabled at (14192): [<ffffffff92185fe1>] sync=
_current_irq_stage+0x201/0x230
[    1.070098] softirqs last  enabled at (12424): [<ffffffff920c3cfe>] hand=
le_softirqs+0x33e/0x420
[    1.070098] softirqs last disabled at (12409): [<ffffffff920c3f48>] __ir=
q_exit_rcu+0xe8/0x110
[    1.070098] ---[ end trace 0000000000000000 ]---
[    1.070098] WARNING: CPU: 0 PID: 28 at kernel/irq/pipeline.c:596 irq_pos=
t_stage+0x8c/0xc0
[    1.070098] workingset: timestamp_bits=3D36 max_order=3D18 bucket_order=
=3D0
[    1.070098] Modules linked in:
[    1.070098] integrity: Platform Keyring initialized
[    1.070098]
[    1.070098] CPU: 0 UID: 0 PID: 28 Comm: kworker/u8:1 Tainted: G        W=
           6.15.0-hyprv-xenomai-0+ #49 PREEMPT(voluntary)
[    1.070098] integrity: Machine keyring initialized
[    1.070098] Tainted: [W]=3DWARN
[    1.070098] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS 090008  12/07/2018
[    1.070098] IRQ stage: Linux
[    1.070098] Workqueue: async async_run_entry_fn
[    1.070098] RIP: 0010:irq_post_stage+0x8c/0xc0
[    1.070098] Code: 12 48 0f ab 30 c3 cc cc cc cc 80 3d 06 4e b4 01 00 75 =
f2 48 8b 57 08 48 c7 c7 98 81 2c 93 c6 05 f2 4d b4 01 01 e8 c4 3e f3 ff <0f=
> 0b c3 cc cc cc cc 80 3d de 4d b4 01 00 75 cb 48 8b 57 08 48 c7
[    1.070098] RSP: 0000:ffffb22680003fe0 EFLAGS: 00010286
[    1.070098] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00202
[    1.070098] RDX: 0000000080010002 RSI: 0000000000000000 RDI: 00000000000=
00001
[    1.070098] RBP: ffff896c011f3400 R08: 000000000000005b R09: 000000004b4=
c332f
[    1.070098] R10: 00000000ffffffff R11: 00000000ffffffff R12: 00000000000=
80105
[    1.070098] R13: 00000000000000ed R14: 0000000000000000 R15: 00000000000=
00000
[    1.070098] FS:  0000000000000000(0000) GS:ffff896caa667000(0000) knlGS:=
0000000000000000
[    1.070098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.070098] CR2: ffff896c26202000 CR3: 000000002483a001 CR4: 00000000003=
706f0
[    1.070098] Call Trace:
[    1.070098]  <IRQ>
[    1.070098]  __sysvec_hyperv_stimer0+0x2b/0x50
[    1.070098]  arch_do_IRQ_pipelined+0x23c/0x560
[    1.070098]  </IRQ>
[    1.070098]  <TASK>
[    1.070098]  sync_current_irq_stage+0x191/0x230
[    1.070098]  handle_irq_pipelined_finish+0x7b/0x1a0
[    1.070098]  arch_pipeline_entry+0xaa/0xf0
[    1.070098]  asm_sysvec_hyperv_stimer0+0x16/0x20
[    1.070098] RIP: 0010:ZSTD_decompressSequences_bmi2.constprop.0+0x62a/0x=
a80
[    1.070098] Code: 08 48 8b 58 08 48 83 c7 20 48 83 c0 20 48 89 4f e0 48 =
89 5f e8 48 8b 48 f0 48 8b 58 f8 48 89 4f f0 48 89 5f f8 48 39 d7 72 d4 <49=
> 83 fe 88 0f 87 25 fb ff ff 4d 01 f5 83 ad 34 ff ff ff 01 0f 85
[    1.070098] RSP: 0000:ffffb226800ffa10 EFLAGS: 00000283
[    1.070098] RAX: ffffb226807b4fc9 RBX: 000000000000000b RCX: ffffb226803=
fa41c
[    1.070098] RDX: 000000000038b951 RSI: ffffb226804296d8 RDI: ffffb226807=
b5029
[    1.070098] RBP: ffffb226800ffb50 R08: 040000000000003d R09: fc000002850=
00000
[    1.070098] R10: 0000000000000003 R11: 000000000000009f R12: 00000000000=
00060
[    1.070098] R13: ffffb226807b5028 R14: 000000000000000c R15: 00000000000=
55518
[    1.070098]  ZSTD_decompressContinue.part.0+0x359/0x490
[    1.070098]  ZSTD_decompressContinueStream+0x96/0x150
[    1.070098]  ZSTD_decompressStream+0x7c3/0xc00
[    1.070098]  ? __pfx_flush_buffer+0x10/0x10
[    1.070098]  ? __pfx_error+0x10/0x10
[    1.070098]  unzstd+0x340/0x570
[    1.070098]  ? __pfx_unzstd+0x10/0x10
[    1.070098]  unpack_to_rootfs+0x144/0x3a0
[    1.070098]  ? __pfx_error+0x10/0x10
[    1.070098]  ? _printk+0x5f/0x80
[    1.070098]  ? do_populate_rootfs+0x124/0x1d0
[    1.070098]  do_populate_rootfs+0x124/0x1d0
[    1.070098]  ? ktime_get+0x83/0x180
[    1.070098]  async_run_entry_fn+0x2d/0x130
[    1.070098]  process_one_work+0x22d/0x6d0
[    1.070098]  worker_thread+0x184/0x320
[    1.070098]  ? __pfx_worker_thread+0x10/0x10
[    1.070098]  kthread+0xfa/0x240
[    1.070098]  ? __pfx_kthread+0x10/0x10
[    1.070098]  ret_from_fork+0x2d/0x50
[    1.070098]  ? __pfx_kthread+0x10/0x10
[    1.070098]  ret_from_fork_asm+0x1a/0x30
[    1.070098]  </TASK>
[    1.070098] irq event stamp: 14192
[    1.070098] hardirqs last  enabled at (14191): [<ffffffff92d7c95a>] arch=
_pipeline_entry+0x8a/0xf0
[    1.070098] hardirqs last disabled at (14192): [<ffffffff92185fe1>] sync=
_current_irq_stage+0x201/0x230
[    1.070098] softirqs last  enabled at (12424): [<ffffffff920c3cfe>] hand=
le_softirqs+0x33e/0x420
[    1.070098] softirqs last disabled at (12409): [<ffffffff920c3f48>] __ir=
q_exit_rcu+0xe8/0x110
[    1.070098] ---[ end trace 0000000000000000 ]---

Have you - or someone else - ever tried running dovetail on top of
hyper-v?

The main purpose behind this exercise: Get a feeling about necessary
efforts to fully support hyper-v as hypervisor - if possible at all.

Best regards,
Florian

[1] https://gitlab.com/Xenomai/dovetail-hacker-space/-/tree/flo/add-hyperv-=
support-for-6-15?ref_type=3Dheads

--=20
Siemens AG, Foundational Technologies
Linux Expert Center



