Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7F28506C
	for <xenomai@lists.linux.dev>; Wed,  8 Oct 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933401; cv=none; b=NoBK9rBnJLRMULJvpMYqm7eWk3OlgSMW6tKm1QIO7Q/hiZsaorQP90zaZuHNQMKtdf+1W8F84LqEnZL0ryTns6ziO24WafOKrKWi+UJc1CcnRzhs5FpnAGKsmkORT56r6TRF9eskhntWE9A3KTvwWK+dTl1dUfnKS5THDVAb9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933401; c=relaxed/simple;
	bh=Zbml14T7cfEWHjEmpzkf5kmd0QJezcWpy5aE1LbP2DY=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=uPoilFTbdMx17/YR+MYX5jDurUqHjb2w1VsuvyKbRzSW2pi2OTmwETSebx2arYzizOGr59cKdZLxG2YxhP40Q88aw95hZUrsSe7qVhb7W3bT77H6Spiq5gSCOjcPVr6s8wPqHz5rzcWqoc6Bx8ynQ7jPuQzyCozHjBV5TRXd9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XOYW6x4M; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XOYW6x4M"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251008134250d70f4771b000020728
        for <xenomai@lists.linux.dev>;
        Wed, 08 Oct 2025 15:42:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=8dzJTRAVI1isBmvz4fhSc3twoTMcB8ki/8vFgbUpuVw=;
 b=XOYW6x4Mzy+7uX7SmceQQLtKl7WvHPfbzP4uxIbf94MDxche8O/hJ5JX+LwoQVppg7I3bC
 32uen5E1GrkZ/Mx++c3UD0oCWLKE0c1+/5NKZzCwpD+cXrw9QZcAJ1mEmnSSpXt87Jsn4V4f
 OQzE8Y3v5AZdzRjqfmV0MJeq3hV6AGq39zs9+SpDbGh5qfNBO6t69fcgc6DX9KlLkG9QRJo/
 PCPZFFX3MscBP8KFFilhDmG3VX/oGS3W5hYLg2ZmIrrKJZRv81tyAiDaW/FNK85I1rvj5XWb
 /L6Fe8Hepl82FXd3qid/pLATj5xmluxmXUNMA9EJYwLAI442uf0FRdTA==;
Message-ID: <2a7e3aec89be09b63d64c7e42c38837670f6d320.camel@siemens.com>
Subject: Dovetail 6.1-cip: Invalid wait context on qemu-arm64
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Date: Wed, 08 Oct 2025 15:42:49 +0200
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

while investigating the FPU issue on 6.1-cip I came along the following
splat report.

I have not looked into that yet. I'm just reporting that right now as
I'm running out of time. The system is booting up and showed no other
problems - or I missed them.

[    3.938759] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    3.938769] [ BUG: Invalid wait context ]
[    3.938823] 6.1.151-cip46-xenomai-0-00253-g174e34350b7e-dirty #425 Not t=
ainted
[    3.938967] -----------------------------
[    3.939003] swapper/2/0 is trying to lock:
[    3.939057] ffffff80038ed098 (&port_lock_key){....}-{3:3}, at: pl011_con=
sole_write+0x140/0x1c4
[    3.939455] other info that might help us debug this:
[    3.939489] context-{2:2}
[    3.939530] 2 locks held by swapper/2/0:
[    3.939565]  #0: ffffffc009c7f4c0 (console_lock){+.+.}-{0:0}, at: vprint=
k_emit+0x2ec/0x420
[    3.939653]  #1: ffffffc009c7f5c0 (console_owner){-...}-{0:0}, at: conso=
le_emit_next_record.constprop.0+0x168/0x36c
[    3.939707] stack backtrace:
[    3.939904] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.1.151-cip46-xeno=
mai-0-00253-g174e34350b7e-dirty #425
[    3.939957] Hardware name: linux,dummy-virt (DT)
[    3.939979] IRQ stage: Linux
[    3.940191] Call trace:
[    3.940216]  dump_backtrace+0xe8/0x140
[    3.940265]  show_stack+0x20/0x30
[    3.940276]  dump_stack_lvl+0xa8/0xf4
[    3.940293]  dump_stack+0x18/0x28
[    3.940305]  __lock_acquire+0x918/0x1fe0
[    3.940323]  lock_acquire+0x1f8/0x324
[    3.940337]  _raw_spin_lock+0x58/0x70
[    3.940352]  pl011_console_write+0x140/0x1c4
[    3.940367]  console_emit_next_record.constprop.0+0x1b0/0x36c
[    3.940378]  console_unlock+0x1dc/0x240
[    3.940388]  vprintk_emit+0x324/0x420
[    3.940398]  vprintk_default+0x40/0x50
[    3.940408]  vprintk+0xdc/0x100
[    3.940418]  _printk+0x64/0x8c
[    3.940431]  clockevents_register_proxy+0x110/0x120
[    3.940447]  register_proxy_device+0x3c/0x80
[    3.940459]  __flush_smp_call_function_queue+0x160/0x30c
[    3.940474]  generic_smp_call_function_single_interrupt+0x1c/0x30
[    3.940488]  ipi_handler+0x68/0x400
[    3.940502]  handle_percpu_devid_irq+0x10c/0x1f4
[    3.940518]  handle_irq_desc+0x4c/0x6c
[    3.940529]  arch_do_IRQ_pipelined+0x4c/0x80
[    3.940543]  sync_current_irq_stage+0x1c4/0x2dc
[    3.940555]  __inband_irq_enable+0x84/0xa0
[    3.940566]  inband_irq_enable+0x1c/0x50
[    3.940577]  arch_cpu_idle+0x1c/0x2c
[    3.940590]  default_idle_call+0x90/0xe4
[    3.940603]  do_idle+0x2a8/0x340
[    3.940615]  cpu_startup_entry+0x3c/0x44
[    3.940625]  secondary_start_kernel+0x164/0x190
[    3.940639]  __secondary_switched+0xb0/0xb4

Ideas welcome.

Best regards,
Florian

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


