Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419DBE6A
	for <xenomai@lists.linux.dev>; Sat,  3 Jun 2023 11:12:30 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 6891CC5108
	for <xenomai@lists.linux.dev>; Sat,  3 Jun 2023 10:42:22 +0000 (UTC)
X-GND-Sasl: rpm@xenomai.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1685788934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbzjEDu/zEisMWD6FYtkLHxDK+aUK1N4c2inoJ4YcPU=;
	b=GHch0IDjK3zoXvbM6Wyr3P6LnvGL/tg89kmVKv3NiYiKf/CWNel1NfsVrdjowy5d56VIdT
	e6bJC6AJMGW111lTScfFXIiuzjVBJITjlTe72c6I36WrWkyujyp/qkyyCgJ+S967spee4d
	TMsbadI+LqTAaCBN5a115bgEppeSYFrBNpWfkWHZ6T1q9//Cbwhw89dUDi6n7ebmdshrYX
	OjO4EslXSYXUraFq8V3+gpO0+wFX/+BrdaRY6+ST2mKWOBIh3Xe36DgKTJZBtBeKgi4t0i
	+55eKq+Lm5NPVqgqIfWv44rZeY/BZlKKrT0yerBHFhwdTqa+vDuSaydOGlwPWQ==
X-GND-Sasl: rpm@xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A61420003;
	Sat,  3 Jun 2023 10:42:13 +0000 (UTC)
References: <CAAm9oxrZ+g7RgBV0SC5GkvEeKKGXOZb2R_BRjf0qRObQM1wCgg@mail.gmail.com>
 <87mt84h3h0.fsf@xenomai.org> <87ilish1z0.fsf@xenomai.org>
 <CAAm9oxp-Zm+25CpxT7wYUiDWxZGBxStB14D8QnEZWDmCp6jYsQ@mail.gmail.com>
 <87359qwclj.fsf@xenomai.org>
 <CAAm9oxoRmKRZhOCa7PVmazCxouy2OdcHAxwCFJBEXwk1JcDnyQ@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Xenomai crash in timer IRQ
Date: Sat, 03 Jun 2023 12:38:59 +0200
In-reply-to: <CAAm9oxoRmKRZhOCa7PVmazCxouy2OdcHAxwCFJBEXwk1JcDnyQ@mail.gmail.com>
Message-ID: <874jnoyghn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Sri Subramanian <sridhar.subramanian@gmail.com> writes:

> Hi Philippe,
>
> Sorry for the long pause in this thread.
>
> However, I am able to reproduce the kernel crash stack (off
> timerfd_oob_read) with a simple test program which does the following:
>
> In a loop:
>   create timer fd
>   create thread which
>        sets up periodic triggers off the monotonic timer
>       closes the timer after a few periods.
>   join w/thread
>
> If the main thread and the timer thread are in the same cpu, I can run
> it with hectic in the background for 2 hrs at least. However, if the
> threads are on different cpus, the kernel crashes within minutes. I am
> attaching the crash and the test program.
>
> Environment:
> HW: Raspberry Pi (CM4)
> SW: Xenomai 5.15.109 tag, Libevl r44
>
> Test steps:
> # hectic -s 200 -q&
> # ./timer-crash1 -a 0 -t 1 -q&
>
> BTW: this thread's history implies changes to the realtime clock, but
> really, this doesn't have anything to do with it.

Ouch, confirmed. Something is wrong, this is a generic issue. Working on
it.

root@homelab-qemu-x86_64:~# ./timerfd_crash -a 1 -t 2
0[  347.430316] ------------[ cut here ]------------
[  347.430319] WARNING: CPU: 2 PID: 3241 at kernel/evl/timer.c:430 evl_get_timer_overruns+0x1ac/0x1c0
[  347.430332] Modules linked in:
[  347.430334] CPU: 2 PID: 3241 Comm: timer-crash1-ch Not tainted 6.1.29+ #178
[  347.430338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
[  347.430340] IRQ stage: EVL
[  347.430342] RIP: 0010:evl_get_timer_overruns+0x1ac/0x1c0
[  347.430348] Code: eb d5 e8 c7 d7 f5 ff 49 89 c4 e9 9f fe ff ff 4c 89 f6 48 89 df e8 44 fd ff ff 48 8b 4b 48 e9 ba fe ff ff 0f 0b e9 13 ff ff ff <0f> 0b e9 2e ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f
[  347.430350] RSP: 0018:ffffc900016c7dc0 EFLAGS: 00010002
[  347.430353] RAX: 0000000000000005 RBX: ffff88810429b400 RCX: 0000000000000007
[  347.430355] RDX: 00000000000025f9 RSI: 00000000000061a8 RDI: ffff888237ac87d0
[  347.430357] RBP: ffff888237ac87d0 R08: 00000000ffffffff R09: 0000000000000001
[  347.430358] R10: 0000000000000082 R11: 0000000000000000 R12: 00000050e066c458
[  347.430360] R13: 0000000000000001 R14: ffff88810429b4b0 R15: ffff88810429b400
[  347.430368] FS:  00007fa304e746c0(0000) GS:ffff888237b00000(0000) knlGS:0000000000000000
[  347.430370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  347.430372] CR2: 0000563c64c7d018 CR3: 00000001050ea000 CR4: 00000000000406e0
[  347.430374] Call Trace:
[  347.430376]  <TASK>
[  347.430378]  timerfd_oob_read+0x190/0x210
[  347.430385]  EVL_read+0x46/0x90
[  347.430388]  do_oob_syscall+0x11a/0x360
[  347.430392]  handle_oob_syscall+0xa5/0xf0
[  347.430395]  pipeline_syscall+0x93/0x110
[  347.430399]  syscall_enter_from_user_mode+0x57/0x120
[  347.430406]  do_syscall_64+0x1d/0xa0
[  347.430410]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  347.430414] RIP: 0033:0x7fa305064308
[  347.430416] Code: Unable to access opcode bytes at 0x7fa3050642de.
[  347.430418] RSP: 002b:00007fa304e73a30 EFLAGS: 00000246 ORIG_RAX: 00000000000

-- 
Philippe.
