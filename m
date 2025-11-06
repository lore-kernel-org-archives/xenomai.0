Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF330AAD4
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419940; cv=none; b=W8Y7f1P+dQMG3mJQQXVWPEaIxhBnK7A6QHfm2M11YJq7VuHjCpALyWNUT031VeoiLw3o/S8KdKGT6LCKuozCHf1kBuVNcBFrNM90yPzKbxSVLroOBNyAfCFGkJTO4NCnWuDl537kozkjJYWtAbTroDw3D280KCo7nINRxxXcVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419940; c=relaxed/simple;
	bh=/afhaHFZqruhkS7QNfWcrzCoO8SDq7xCYHUOjo8mnDQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Jm4EysfIp+qYXzuZOS/wiFRo5cjU3D3fP2JVox+31EpTs/5vbynM8sdGQ5Yd8aDNKmwJCe9gMOgVYrHtTbapmSgmHC49jNlNUq8YOKOxCU7pyLdMcX6Pyuzy+nWmD0mgd4Xc9u+aHfqcN/PjHxHzQBrhIBxEfZPDyllPebUD8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=minjievc; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="minjievc"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025110609052218154a45a6000207b0
        for <xenomai@lists.linux.dev>;
        Thu, 06 Nov 2025 10:05:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=QoBncTvGfbQWhaUC4BYPZrY0pXIZqSp6CpOWwm75Pac=;
 b=minjievchJkXooj4ux1Krd6z1odHetmy6FdchaC9SgZZM2N5omfIy5Zq4flBnRCUOF0iXR
 pwXLOj5ONBs/0L8pFOvkPqMqbkbb3dBhE6GhK+tGU6tLydGeRKUqhGwV/XbiiTUxplLBP5JW
 j3C7HS2Vt1PBQLO/p/R5QiJlqaq5yPJ/VNz2pHhm4z4VSTNFYNACPoerdtaoHuo0z1Vk3aI5
 aGP7SLxC+0+bNHXjPtAc1q7sTtxvr66OW0Pp+Vo8bG1ys1+PuCAjrv0Pz4+9uyBbfK2yQUFt
 mbnnz9UU5t5bjldrCDA59xDoKO6zY2PaD1yz5tJTVbvxsrjM+KUmu41Q==;
Message-ID: <10779edbd5633fe1d8fb8df2bea3ca5ca53935cb.camel@siemens.com>
Subject: Dovetail 6.1 arm64: Lockdep report while booting up
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Date: Thu, 06 Nov 2025 10:05:22 +0100
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

Hi all,

I get the following lockdep report on 6.1, arm64. The uart port lock -
which is a spinlock_t - is used in (inband) IRQ context, which seems
wrong to me as well.

Dovetail specifics start in clockevents_register_proxy(), where we print
out (printk) some details about the registered proxy tick device. That
looks like

[    2.054973] CPU2: proxy tick device registered (62.50MHz)
[    2.055008] CPU0: proxy tick device registered (62.50MHz)
[    2.055159] CPU1: proxy tick device registered (62.50MHz)
[    2.055444] CPU3: proxy tick device registered (62.50MHz)

clockevents_register_proxy() is executed on all CPUs in parallel using
an IPI mechanism. So we end up in (inband) IRQ context.

Input on how to solve that is welcome.

I should note that Jan tried to reproduce on his end as well. Obviously
he was not able to trigger that. I have no idea why...

The code paths seems unchanged in newer releases as well. I haven't
tested that yet, but I think they are affected as well.

[    2.218254] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    2.218324] [ BUG: Invalid wait context ]
[    2.218398] 6.1.155-cip47 #442 Not tainted
[    2.218561] -----------------------------
[    2.218575] swapper/1/0 is trying to lock:
[    2.218639] ffffff80038e0898 (&port_lock_key){....}-{3:3}, at: pl011_con=
sole_write+0x140/0x1c4
[    2.219156] other info that might help us debug this:
[    2.219198] context-{2:2}
[    2.219250] 2 locks held by swapper/1/0:
[    2.219295]  #0: ffffffc009c7f4c0 (console_lock){+.+.}-{0:0}, at: vprint=
k_emit+0x2ec/0x420
[    2.219407]  #1: ffffffc009c7f5c0 (console_owner){-...}-{0:0}, at: conso=
le_emit_next_record.constprop.0+0x168/0x36c
[    2.219481] stack backtrace:
[    2.219785] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.155-cip47 #442
[    2.219856] Hardware name: linux,dummy-virt (DT)
[    2.219883] IRQ stage: Linux
[    2.220148] Call trace:
[    2.220177]  dump_backtrace+0xe8/0x140
[    2.220241]  show_stack+0x20/0x30
[    2.220254]  dump_stack_lvl+0xa8/0xf4
[    2.220275]  dump_stack+0x18/0x28
[    2.220289]  __lock_acquire+0x918/0x1fe0
[    2.220308]  lock_acquire+0x1f8/0x324
[    2.220326]  _raw_spin_lock+0x58/0x70
[    2.220343]  pl011_console_write+0x140/0x1c4
[    2.220362]  console_emit_next_record.constprop.0+0x1b0/0x36c
[    2.220381]  console_unlock+0x1dc/0x240
[    2.220393]  vprintk_emit+0x324/0x420
[    2.220405]  vprintk_default+0x40/0x50
[    2.220417]  vprintk+0xdc/0x100
[    2.220429]  _printk+0x64/0x8c
[    2.220443]  clockevents_register_proxy+0x110/0x120
[    2.220462]  register_proxy_device+0x3c/0x80
[    2.220477]  __flush_smp_call_function_queue+0x160/0x30c
[    2.220495]  generic_smp_call_function_single_interrupt+0x1c/0x30
[    2.220511]  ipi_handler+0x68/0x400
[    2.220528]  handle_percpu_devid_irq+0x10c/0x1f4
[    2.220546]  handle_irq_desc+0x4c/0x6c
[    2.220560]  arch_do_IRQ_pipelined+0x4c/0x80
[    2.220577]  sync_current_irq_stage+0x1c4/0x2dc
[    2.220591]  __inband_irq_enable+0x84/0xa0
[    2.220604]  inband_irq_enable+0x1c/0x50
[    2.220618]  arch_cpu_idle+0x1c/0x2c
[    2.220635]  default_idle_call+0x90/0xe4
[    2.220651]  do_idle+0x2a8/0x340
[    2.220664]  cpu_startup_entry+0x3c/0x44
[    2.220677]  secondary_start_kernel+0x164/0x190
[    2.220693]  __secondary_switched+0xb0/0xb4

Best regards,
Florian
