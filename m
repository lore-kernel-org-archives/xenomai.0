Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01C2D738E
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445490; cv=none; b=YiFrJHZ839F5zwNLn3Ur4znzhFCgyXy3000fPkSefVkDRKNHUt2SV//+4+xm8J+DhquNQCCHahYVj5vAulRGC+alvm/BtYmWSkhR62WcQ4xmVfk5Rbc/ZQWNWKXCY2vhvwHaQLji+2c/oLErJ65iA2B95U8mkYXbefvezWYl4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445490; c=relaxed/simple;
	bh=RedayvQIVoIxFIMJO1W/isr9KesDBeyySS5sWzGsRSQ=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=uvElIH8Ke/ctWSwvv3mSWMY+GuwmySLkaT1JIYYHtIqnSB67Kgdl9dx6a33GxUHao6ja1BjrLvJQ+w0ni7z2yuJ0kILlgq9l2XNdAmTJvT0h/wleSfKdp1USMU5wxtvbWAJb9TT5TxMd9a2L/uMyIilNohwdiqQX9weUn7PVUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 41C902A87F7
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 17:28:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id iT1AS9u245SX for <xenomai@lists.linux.dev>;
	Mon, 26 Jan 2026 17:28:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A00EF2A8813
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 17:28:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vy99qDzb3lzC for <xenomai@lists.linux.dev>;
	Mon, 26 Jan 2026 17:28:04 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 620972A87F7
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 17:28:04 +0100 (CET)
Date: Mon, 26 Jan 2026 17:28:04 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai <xenomai@lists.linux.dev>
Message-ID: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at>
Subject: CPU Hotplug Splat
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF146 (Linux)/8.8.12_GA_3809)
Thread-Index: 6kuHX2WlCB6FGYX9EbHefyuy5vG5mA==
Thread-Topic: CPU Hotplug Splat

Hi!

While toying around with CPU affinities I noticed that offlining a CPU
triggers reliable a crash. Is this known?

[   32.812858] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   32.812879] #PF: supervisor read access in kernel mode
[   32.812881] #PF: error_code(0x0000) - not-present page
[   32.812883] PGD 0 P4D 0 
[   32.812886] Oops: Oops: 0000 [#1] SMP PTI IRQ_PIPELINE
[   32.812892] CPU: 4 UID: 0 PID: 36 Comm: migration/4 Not tainted 6.17.0-g970519241701-dirty #38 PREEMPT(voluntary) 
[   32.812896] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[   32.812898] IRQ stage: Linux
[   32.812899] Stopper: multi_cpu_stop+0x0/0x110 <- __stop_cpus.constprop.0+0x79/0xc0
[   32.812909] RIP: 0010:proxy_irq_handler+0x13/0x30
[   32.812914] Code: 9d 5b e9 00 11 ee 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 05 6c 96 41 02 48 8b bf
[   32.812917] RSP: 0018:ffff9dcf0018cfd0 EFLAGS: 00010287
[   32.812920] RAX: ffff8fdea8989000 RBX: 0000000000000000 RCX: ffff8fde00e64108
[   32.812922] RDX: ffff8fde00e64000 RSI: ffff8fde3bd1dac0 RDI: 0000000000000000
[   32.812923] RBP: ffff8fde00ea6200 R08: ffff8fde00e64100 R09: 0000000000000000
[   32.812938] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8fde00fad600
[   32.812940] R13: 000000000000001b R14: ffff9dcf0005bd00 R15: 0000000000000004
[   32.812947] FS:  0000000000000000(0000) GS:ffff8fdea8989000(0000) knlGS:0000000000000000
[   32.812950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.812952] CR2: 0000000000000000 CR3: 0000000058a30000 CR4: 00000000000006f0
[   32.812954] Call Trace:
[   32.812976]  <IRQ>
[   32.812978]  handle_synthetic_irq+0x9b/0x1b0
[   32.812988]  arch_do_IRQ_pipelined+0x85/0x460
[   32.812995]  </IRQ>
[   32.812996]  <TASK>
[   32.812999]  sync_current_irq_stage+0x159/0x160
[   32.813003]  inband_irq_restore+0x5d/0x80
[   32.813008]  multi_cpu_stop+0xdd/0x110
[   32.813012]  ? __pfx_multi_cpu_stop+0x10/0x10
[   32.813016]  cpu_stopper_thread+0x85/0x130
[   32.813020]  ? __pfx_smpboot_thread_fn+0x10/0x10
[   32.813027]  smpboot_thread_fn+0xee/0x220
[   32.813031]  kthread+0xf9/0x1e0
[   32.813037]  ? __pfx_kthread+0x10/0x10
[   32.813042]  ret_from_fork+0x15a/0x170
[   32.813049]  ? __pfx_kthread+0x10/0x10
[   32.813053]  ret_from_fork_asm+0x1a/0x30
[   32.813064]  </TASK>
[   32.813064] Modules linked in:
[   32.813069] CR2: 0000000000000000
[   32.813072] ---[ end trace 0000000000000000 ]---
[   32.813074] RIP: 0010:proxy_irq_handler+0x13/0x30
[   32.813078] Code: 9d 5b e9 00 11 ee 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 05 6c 96 41 02 48 8b bf
[   32.813081] RSP: 0018:ffff9dcf0018cfd0 EFLAGS: 00010287
[   32.813084] RAX: ffff8fdea8989000 RBX: 0000000000000000 RCX: ffff8fde00e64108
[   32.813085] RDX: ffff8fde00e64000 RSI: ffff8fde3bd1dac0 RDI: 0000000000000000
[   32.813087] RBP: ffff8fde00ea6200 R08: ffff8fde00e64100 R09: 0000000000000000
[   32.813089] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8fde00fad600
[   32.813091] R13: 000000000000001b R14: ffff9dcf0005bd00 R15: 0000000000000004
[   32.813097] FS:  0000000000000000(0000) GS:ffff8fdea8989000(0000) knlGS:0000000000000000
[   32.813099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.813101] CR2: 0000000000000000 CR3: 0000000058a30000 CR4: 00000000000006f0
[   32.813104] Kernel panic - not syncing: Fatal exception in interrupt
[   32.870451] Kernel Offset: 0xfc00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Thanks,
//richard
