Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D78279DB4
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456294; cv=none; b=Qgx3HX9DkMnzA7utvoO07IaNFZjiagE/rH7LUBcIHriS1fG4f90tUrQx2DzX1ZieNYpn8OuotCoKT6I3af6yz+/adW1hlPQmog9IPExUoJZb6/+u7/l7mVfmDJ24QrOXlTM3AhJwinnOgt+a6OnzU3dRto6UJ1011SojK2s79qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456294; c=relaxed/simple;
	bh=uoTUnLpxWy5ezTCZVWTt8hj/yDICaZg+g5Im5f817Ao=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AUeKV0DO5AAXmt4W1OlsNNRZ57kdwb5PSjVALekDpEK1oUDRWy83Ti/MLfw2hgQMnXXMD3fi4uhpops5YEixgR1yp3rBOwbgdhPssk1HERRF45ukwiPsv60IuC57az//orwM6Cm4dgI9PlLSAr15TLvdKP31qnkbY+4uACC4eBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 73CD22C14A6;
	Mon, 26 Jan 2026 20:38:09 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id u0bkhIz2eybm; Mon, 26 Jan 2026 20:38:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 82D3D2C14A8;
	Mon, 26 Jan 2026 20:38:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KHpKD2Hd2auH; Mon, 26 Jan 2026 20:38:08 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 632772C14A6;
	Mon, 26 Jan 2026 20:38:08 +0100 (CET)
Date: Mon, 26 Jan 2026 20:38:08 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <724391155.14329.1769456288068.JavaMail.zimbra@nod.at>
In-Reply-To: <d953a897-92a8-4a83-ba2c-7d95059b4525@siemens.com>
References: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at> <5a4b5aff-fa90-42e1-bdf7-3a42786830bf@siemens.com> <1353891765.13527.1769446729193.JavaMail.zimbra@nod.at> <d953a897-92a8-4a83-ba2c-7d95059b4525@siemens.com>
Subject: Re: CPU Hotplug Splat
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF146 (Linux)/8.8.12_GA_3809)
Thread-Topic: CPU Hotplug Splat
Thread-Index: ObuxiaVKvInjI6M3zM68oz5Tqy2adg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> I'll try a more recent branch.
>> =20
>>> https://gitlab.com/Xenomai/linux-dovetail/-/commit/65f59eefa1043e9414b3=
7312826de2a0fa07624e

v6.18.y-dovetail-rebase contains this fix but the crash still happens.

[ 7299.180846] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[ 7299.180859] #PF: supervisor read access in kernel mode
[ 7299.180861] #PF: error_code(0x0000) - not-present page
[ 7299.180862] PGD 0 P4D 0=20
[ 7299.180865] Oops: Oops: 0000 [#1] SMP PTI IRQ_PIPELINE
[ 7299.180869] CPU: 6 UID: 0 PID: 46 Comm: migration/6 Not tainted 6.18.2-g=
768d3d5bf800-dirty #41 PREEMPT(voluntary)=20
[ 7299.180873] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 7299.180874] IRQ stage: Linux
[ 7299.180875] Stopper: multi_cpu_stop+0x0/0x110 <- __stop_cpus.constprop.0=
+0x79/0xc0
[ 7299.180885] RIP: 0010:proxy_irq_handler+0x13/0x30
[ 7299.180889] Code: 9d 5b e9 00 fa ed 00 90 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 90 f3 0f 1e fa 65 48 8b 05 ac 99 41 02 48 8b bf
[ 7299.180891] RSP: 0018:ffffa861c01e4fd0 EFLAGS: 00010287
[ 7299.180893] RAX: ffff8979e6006000 RBX: 0000000000000000 RCX: ffff8979402=
3ea08
[ 7299.180895] RDX: ffff89794023e800 RSI: ffff89797bd9dac0 RDI: 00000000000=
00000
[ 7299.180896] RBP: ffff897940f0cc00 R08: ffff89794023ea00 R09: 00000000000=
00000
[ 7299.180897] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8979408=
b0c80
[ 7299.180898] R13: 000000000000001b R14: ffffa861c005bd00 R15: 00000000000=
00004
[ 7299.180903] FS:  0000000000000000(0000) GS:ffff8979e6006000(0000) knlGS:=
0000000000000000
[ 7299.180905] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7299.180907] CR2: 0000000000000000 CR3: 0000000028630000 CR4: 00000000000=
006f0
[ 7299.180908] Call Trace:
[ 7299.180940]  <IRQ>
[ 7299.180941]  handle_synthetic_irq+0x9b/0x1b0
[ 7299.180948]  arch_do_IRQ_pipelined+0x85/0x460
[ 7299.180952]  </IRQ>
[ 7299.180953]  <TASK>
[ 7299.180954]  sync_current_irq_stage+0x159/0x160
[ 7299.180957]  inband_irq_restore+0x5d/0x80
[ 7299.180961]  multi_cpu_stop+0xdd/0x110
[ 7299.180964]  ? __pfx_multi_cpu_stop+0x10/0x10
[ 7299.180966]  cpu_stopper_thread+0x85/0x130
[ 7299.180970]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 7299.180974]  smpboot_thread_fn+0xee/0x220
[ 7299.180976]  kthread+0xf9/0x1e0
[ 7299.180980]  ? __pfx_kthread+0x10/0x10
[ 7299.180983]  ret_from_fork+0x15e/0x1a0
[ 7299.180988]  ? __pfx_kthread+0x10/0x10
[ 7299.180990]  ret_from_fork_asm+0x1a/0x30
[ 7299.180996]  </TASK>
[ 7299.180997] Modules linked in:
[ 7299.180999] CR2: 0000000000000000
[ 7299.181001] ---[ end trace 0000000000000000 ]---
[ 7299.181002] RIP: 0010:proxy_irq_handler+0x13/0x30
[ 7299.181005] Code: 9d 5b e9 00 fa ed 00 90 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 90 f3 0f 1e fa 65 48 8b 05 ac 99 41 02 48 8b bf
[ 7299.181007] RSP: 0018:ffffa861c01e4fd0 EFLAGS: 00010287
[ 7299.181009] RAX: ffff8979e6006000 RBX: 0000000000000000 RCX: ffff8979402=
3ea08
[ 7299.181010] RDX: ffff89794023e800 RSI: ffff89797bd9dac0 RDI: 00000000000=
00000
[ 7299.181011] RBP: ffff897940f0cc00 R08: ffff89794023ea00 R09: 00000000000=
00000
[ 7299.181013] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8979408=
b0c80
[ 7299.181013] R13: 000000000000001b R14: ffffa861c005bd00 R15: 00000000000=
00004
[ 7299.181016] FS:  0000000000000000(0000) GS:ffff8979e6006000(0000) knlGS:=
0000000000000000
[ 7299.181018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7299.181019] CR2: 0000000000000000 CR3: 0000000028630000 CR4: 00000000000=
006f0
[ 7299.181020] Kernel panic - not syncing: Fatal exception in interrupt
[ 7299.227448] Kernel Offset: 0x12600000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)

Thanks,
//richard
