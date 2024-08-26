Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642BC129A74
	for <xenomai@lists.linux.dev>; Mon, 26 Aug 2024 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657828; cv=none; b=m1enLCw5RxiYgkTDSMFGs6KOpr8ibCD35xWFnyOg4RAXIYGGquRBnUi0wRVKNhj+LIKtg8SqigWdvtr4Y0JcVlvxhe6Nujq4inro8EZcDKTI56znsvuT7WjOvWeIFru6ZrM3HHwRg0P4T85GO4+kWly4Nu7UpddXb9K2ZPOfu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657828; c=relaxed/simple;
	bh=Dh86/4xUED7obS79w3vBG9yOQmdVMkPjEjiyrwweK8Y=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=ZLNSJimZ8AilqkYO7iIYp1vBjLnJeABzmmIQi5C76OY2T4cC0ldSsdNOBWMfsclFwL+uyjxdJiIAqYVqhsxIwkShwxx6GqSeV1PBbOgyuRijqaBt609eS9LOz5Smjo5kHOJi8qjxy58KyO/r9Q0lzKTXzM4Ksz4ZnmkLRdsQnW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ijJ8yDL9; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ijJ8yDL9"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024082607365061e0ba61f060262598
        for <xenomai@lists.linux.dev>;
        Mon, 26 Aug 2024 09:36:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Pk89dk/lpH6VHxz57gdieUatiVabMtvKpAi4ImiZXac=;
 b=ijJ8yDL9ZOp9cpHs97e9zldQFZmAuBm5QmJc/paqGN7oYrzyBE0x2i9uZ65MQAXpoZCKZ0
 pmjt/+db5nmIV4Bb4ES6hYOphTx5FwqTZHK1pWU8Fs0mgtxKFZdqWjz7EVbA4oVw/PyceBw4
 n/TZIsR75hDazdIFcdmFKmsopuWiZ4lZ+vRPq7KWkBZbWpvRasOCehww5Q6OGRvzt7VnkHDM
 gEfLw9+Zrf0xBSs4K/7jsUnbiVPyPmlXcc2NuIDeUI9l7gjW4mCnGqdbtyDUDFPIJyWAGxyh
 Vvp2uBDVY7gNQXFA/02NZGSHKmh0tBcbm0joRxhvuzy2PU8L9/OGbLyA==;
Message-ID: <f5d625d498678060902ff7362d72b8b16387fee5.camel@siemens.com>
Subject: Dovetail: x86 compat syscall handling broken, missing backport in
 6.6 and 6.1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 26 Aug 2024 09:36:47 +0200
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

I think we found a missing backport in dovetail 6.6 and 6.1. Jan
observed the kernel splat below while testing.

I'm quite sure that [1] should be applied to both mentioned branches.

Best regards,
Florian

[1] https://source.denx.de/Xenomai/linux-dovetail/-/commit/1e530a1a8bbd0b7d=
b0e660d27a3c191a649718c3

The log:

[  101.430669] ------------[ cut here ]------------
[  101.430671] WARNING: CPU: 3 PID: 1944 at ../kernel/irq/pipeline.c:303 in=
band_irq_enable+0x10/0x20
[  101.430676] Modules linked in: 9p netfs rt_e1000 rt_e1000_new rtnet
[  101.430682] CPU: 3 PID: 1944 Comm: ld-linux.so.2 Not tainted 6.6.41+ #10=
5
[  101.430684] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[  101.430684] IRQ stage: Linux
[  101.430685] RIP: 0010:inband_irq_enable+0x10/0x20
[  101.430687] Code: cc cc 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 80 3d aa 3f 2b 03 00 75 09 9c 58 f6 c4 02 75 02 <0f=
> 0b e9 69 ff ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[  101.430688] RSP: 0000:ffffc900016d7f28 EFLAGS: 00010046
[  101.430690] RAX: 0000000000000046 RBX: ffffc900016d7f58 RCX: 00000000000=
00814
[  101.430691] RDX: 0000000000000000 RSI: ffffffff829c5c37 RDI: ffffffff829=
9b2c4
[  101.430692] RBP: ffffc900016d7f48 R08: 0000000000000001 R09: 00000000000=
00001
[  101.430693] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
0002d
[  101.430694] R13: ffffffffffffffda R14: 0000000000000000 R15: 00000000000=
00000
[  101.430695] FS:  0000000000000000(0000) GS:ffff88803ed80000(0000) knlGS:=
0000000000000000
[  101.430697] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  101.430698] CR2: 00000000f7f79270 CR3: 0000000006676004 CR4: 00000000003=
70ee0
[  101.430699] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  101.430700] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  101.430701] Call Trace:
[  101.430702]  <TASK>
[  101.430704]  ? __warn+0x81/0x180
[  101.430707]  ? inband_irq_enable+0x10/0x20
[  101.430710]  ? report_bug+0x10b/0x200
[  101.430718]  ? handle_bug+0x50/0xc0
[  101.430720]  ? exc_invalid_op+0xc7/0xe0
[  101.430722]  ? asm_exc_invalid_op+0x16/0x20
[  101.430731]  ? inband_irq_enable+0x10/0x20
[  101.430735]  do_int80_emulation+0x62/0x120
[  101.430740]  asm_int80_emulation+0x16/0x20
[  101.430742] RIP: 0023:0xf7f88907
[  101.430744] Code: 00 50 8d 87 34 46 ff ff 50 e8 35 91 ff ff 66 90 66 90 =
90 e8 08 33 00 00 81 c2 eb 26 01 00 53 b8 2d 00 00 00 8b 5c 24 08 cd 80 <89=
> 82 20 0a 00 00 39 d8 72 07 31 c0 5b c3 8d 76 00 c7 82 24 0a 00
[  101.430745] RSP: 002b:00000000ff9b80d8 EFLAGS: 00000292 ORIG_RAX: 000000=
000000002d
[  101.430747] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000000=
0000c
[  101.430747] RDX: 00000000f7f9afe0 RSI: 00000000f7f9afe0 RDI: 00000000000=
007f0
[  101.430748] RBP: 00000000ff9b8294 R08: 0000000000000000 R09: 00000000000=
00000
[  101.430749] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[  101.430749] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[  101.430758]  </TASK>
[  101.430759] irq event stamp: 1889
[  101.430760] hardirqs last  enabled at (1889): [<ffffffff821c444d>] do_in=
t80_emulation+0x5d/0x120
[  101.430762] hardirqs last disabled at (1888): [<ffffffff821c440e>] do_in=
t80_emulation+0x1e/0x120
[  101.430765] softirqs last  enabled at (1724): [<ffffffff810949cf>] handl=
e_softirqs+0x23f/0x3e0
[  101.430767] softirqs last disabled at (1715): [<ffffffff8109525f>] irq_e=
xit_rcu+0x9f/0xd0
[  101.430769] ---[ end trace 0000000000000000 ]---
