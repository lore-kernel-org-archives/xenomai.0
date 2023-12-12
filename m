Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60C73164
	for <xenomai@lists.linux.dev>; Tue, 12 Dec 2023 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Q1gOpM9d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1702393642; x=1702652842;
	bh=CUnO4aC9jfAhFn3rqrGzozH9DUDHwPgAowhJeUt4obk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Q1gOpM9d3NiBhRsOwUJa4E6bd4ehgWWMp1D7yl1WqqnnMH/I6OepEB0bB++Z7IyBh
	 3aofYRWuZnv2Oqt0M2E+55OeozCsBbkHQMAws/jVzufER4j/7p53awweyfIoK+OK81
	 aZvzBzhKHb2dryNNr2bwJlXkN3gCj01EgmxDtn0OH2S0J2FO6fPnA6pjqqFBwcCWUh
	 4Qc+qteMwUbiOzpeoLrX1WnYjp0S56sPixxkSZUQ9uR4DY5nCbCcdRJ7/XhqVFQYz+
	 N2LFy3aR7otCzZSLLXbLAoJjde1eSg2p/jrC9gX6jiH0Z78DOEaWeLsV2p3TkTmfin
	 0fk5kcLV1blYA==
Date: Tue, 12 Dec 2023 15:07:13 +0000
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
From: "josh.nestor" <josh.nestor@protonmail.com>
Subject: Resolving a livelock between Xenomai 3 application and Linux kernel using GDB
Message-ID: <2eRq8h8p8SWhJ6EnmaVwi0DCGy_pWlWDoNQ5lE_y6bQ09xcwtVzNG5Cg7xc24KX92Dj1nULBDiNT9Gj37p3dHriAYApcqWkmvMVUwP8KjIg=@protonmail.com>
Feedback-ID: 6271257:user:proton
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear list,

Apologies if this post appears twice, it looks like it didn't send the firs=
t time.

I am trying to resolve a livelock issue I'm having between between the Linu=
x kernel and my Xenomai application.

I am running Xenomai v3.1.1, with Linux 5.4.72, on a Raspberry Pi CM4. The =
last 2 cores are configured as Xenomai cores. I've enabled debugging symbol=
s on the Linux kernel before compiling. Xenomai is also compiled as part of=
 the kernel rather than a kernel module.

I have attached a JTAG debugger (Segger J-link) to the Raspberry Pi and use=
d OpenOCD connected with 4 instances of GDB, one for each CPU.

From the backtrace it looks like it is stuck at ktime_get() on a sequence l=
ock, probably because somewhere in my application a time-related linux sysc=
all such as gettimeofday() is being called somewhere. I've read that this c=
an lead to livelocks as the reader will have a higher priority than the Lin=
ux writing thread.

I'm trying to get a backtrace of Core 2 to try and figure out where this sy=
scall may be called from, however it looks like the debugging symbols are n=
ot loaded correctly. I have loaded the debugging symbols for Linux and my a=
pplication as below, for each of the GDB instances.
file vmlinux
lx-symbols
add-symbol-file my_realtime_application

Are there any other tricks needed to load the debugging symbols for Xenomai=
 and for my realtime application running under Xenomai? And is there a way =
I can see where each of the realtime threads in my application are currentl=
y?

I've also attached a copy of the thread info and backtraces below.

--- Core 0 ---
(gdb) info threads
  Id   Target Id         Frame
* 1    Remote target     cpu_relax () at ./arch/arm64/include/asm/processor=
.h:247
(gdb) bt
#0  cpu_relax () at ./arch/arm64/include/asm/processor.h:247
#1  __read_seqcount_begin (s=3D<optimized out>) at ./include/linux/seqlock.=
h:115
#2  raw_read_seqcount_begin (s=3D<optimized out>) at ./include/linux/seqloc=
k.h:148
#3  read_seqcount_begin (s=3D<optimized out>) at ./include/linux/seqlock.h:=
165
#4  ktime_get () at kernel/time/timekeeping.c:757
#5  0xffffffc01014e294 in tick_nohz_irq_enter () at kernel/time/tick-sched.=
c:1257
#6  tick_irq_enter () at kernel/time/tick-sched.c:1278
#7  0xffffffc0100d3350 in irq_enter () at kernel/softirq.c:354
#8  0xffffffc010122a1c in __handle_domain_irq (domain=3D0x0, hwirq=3D15, lo=
okup=3Dfalse, regs=3D0xffffff80bf984488)
    at kernel/irq/irqdesc.c:671
#9  0xffffffc01009e000 in __ipipe_do_IRQ (irq=3D<optimized out>, cookie=3D<=
optimized out>) at arch/arm64/kernel/ipipe.c:212
#10 0xffffffc0101856c4 in __ipipe_do_sync_stage () at kernel/ipipe/core.c:1=
702
#11 0xffffffc0101857d0 in __ipipe_sync_stage () at ./include/linux/ipipe.h:=
116
#12 __ipipe_do_sync_pipeline (top=3D0xffffffc010cfd400 <ipipe_root>) at ker=
nel/ipipe/core.c:977
#13 0xffffffc010185c80 in __ipipe_sync_pipeline (top=3D<optimized out>) at =
./include/linux/ipipe.h:332
#14 __ipipe_dispatch_irq (irq=3D1024, flags=3D<optimized out>) at kernel/ip=
ipe/core.c:1575
#15 0xffffffc0100814bc in __ipipe_grab_irq (irq=3D<optimized out>, regs=3D0=
x400) at arch/arm64/kernel/ipipe.c:202
#16 0xffffffc010081c24 in ipipe_handle_domain_irq (regs=3D<optimized out>, =
hwirq=3D<optimized out>, domain=3D<optimized out>)
    at ./arch/arm64/include/asm/ipipe.h:160
#17 gic_handle_irq (regs=3D0xffffffc010cfd400 <ipipe_root>) at drivers/irqc=
hip/irq-gic.c:404
#18 0xffffffc010085e04 in handle_arch_irq_pipelined (regs=3D<optimized out>=
) at arch/arm64/kernel/irq.c:43
#19 0xffffffc0100834c8 in el1_irq () at arch/arm64/kernel/entry.S:696
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb)

--- Core 1 ---
(gdb) info threads
  Id   Target Id         Frame
* 1    Remote target     cpu_relax () at ./arch/arm64/include/asm/processor=
.h:247
(gdb) bt
#0  cpu_relax () at ./arch/arm64/include/asm/processor.h:247
#1  __read_seqcount_begin (s=3D<optimized out>) at ./include/linux/seqlock.=
h:115
#2  raw_read_seqcount_begin (s=3D<optimized out>) at ./include/linux/seqloc=
k.h:148
#3  read_seqcount_begin (s=3D<optimized out>) at ./include/linux/seqlock.h:=
165
#4  ktime_get () at kernel/time/timekeeping.c:757
#5  0xffffffc01014e294 in tick_nohz_irq_enter () at kernel/time/tick-sched.=
c:1257
#6  tick_irq_enter () at kernel/time/tick-sched.c:1278
#7  0xffffffc0100d3350 in irq_enter () at kernel/softirq.c:354
#8  0xffffffc010122a1c in __handle_domain_irq (domain=3D0x0, hwirq=3D3, loo=
kup=3Dfalse, regs=3D0xffffff80bf99f488)
    at kernel/irq/irqdesc.c:671
#9  0xffffffc01009e000 in __ipipe_do_IRQ (irq=3D<optimized out>, cookie=3D<=
optimized out>) at arch/arm64/kernel/ipipe.c:212
#10 0xffffffc0101856c4 in __ipipe_do_sync_stage () at kernel/ipipe/core.c:1=
702
#11 0xffffffc0101857d0 in __ipipe_sync_stage () at ./include/linux/ipipe.h:=
116
#12 __ipipe_do_sync_pipeline (top=3D0xffffffc010cfd400 <ipipe_root>) at ker=
nel/ipipe/core.c:977
#13 0xffffffc010185aec in dispatch_irq_head (irq=3D<optimized out>) at kern=
el/ipipe/core.c:1454
#14 0xffffffc010185c10 in __ipipe_dispatch_irq (irq=3D1, flags=3D<optimized=
 out>) at kernel/ipipe/core.c:1555
#15 0xffffffc0100814bc in __ipipe_grab_irq (irq=3D<optimized out>, regs=3D0=
x100) at arch/arm64/kernel/ipipe.c:202
#16 0xffffffc010081c24 in ipipe_handle_domain_irq (regs=3D<optimized out>, =
hwirq=3D<optimized out>, domain=3D<optimized out>)
    at ./arch/arm64/include/asm/ipipe.h:160
#17 gic_handle_irq (regs=3D0xffffffc010cfd400 <ipipe_root>) at drivers/irqc=
hip/irq-gic.c:404
#18 0xffffffc010085e04 in handle_arch_irq_pipelined (regs=3D<optimized out>=
) at arch/arm64/kernel/irq.c:43
#19 0xffffffc0100834c8 in el1_irq () at arch/arm64/kernel/entry.S:696
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb)

--- Core 2 ---
(gdb) info threads
  Id   Target Id         Frame
* 1    Remote target     0x0000007f8722a308 in ?? ()
(gdb) bt
#0  0x0000007f8722a308 in ?? ()
#1  0x000000555c30a678 in ?? ()
#2  0x97cd1a4acef21b00 in ?? ()
#3  0x0000000000000000 in ?? ()
(gdb)

--- Core 3 ---
(gdb) info threads
  Id   Target Id         Frame
* 1    Remote target     cpu_relax () at ./arch/arm64/include/asm/processor=
.h:247
(gdb) bt
#0  cpu_relax () at ./arch/arm64/include/asm/processor.h:247
#1  __read_seqcount_begin (s=3D<optimized out>) at ./include/linux/seqlock.=
h:115
#2  raw_read_seqcount_begin (s=3D<optimized out>) at ./include/linux/seqloc=
k.h:148
#3  read_seqcount_begin (s=3D<optimized out>) at ./include/linux/seqlock.h:=
165
#4  ktime_get () at kernel/time/timekeeping.c:757
#5  0xffffffc01014e294 in tick_nohz_irq_enter () at kernel/time/tick-sched.=
c:1257
#6  tick_irq_enter () at kernel/time/tick-sched.c:1278
#7  0xffffffc0100d3350 in irq_enter () at kernel/softirq.c:354
#8  0xffffffc010185694 in __ipipe_do_sync_stage () at kernel/ipipe/core.c:1=
696
#9  0xffffffc0101857d0 in __ipipe_sync_stage () at ./include/linux/ipipe.h:=
116
#10 __ipipe_do_sync_pipeline (top=3D0xffffffc010cfd400 <ipipe_root>) at ker=
nel/ipipe/core.c:977
#11 0xffffffc010185aec in dispatch_irq_head (irq=3D<optimized out>) at kern=
el/ipipe/core.c:1454
#12 0xffffffc010185c10 in __ipipe_dispatch_irq (irq=3D1, flags=3D<optimized=
 out>) at kernel/ipipe/core.c:1555
#13 0xffffffc0100814bc in __ipipe_grab_irq (irq=3D<optimized out>, regs=3D0=
x100) at arch/arm64/kernel/ipipe.c:202
#14 0xffffffc010081c24 in ipipe_handle_domain_irq (regs=3D<optimized out>, =
hwirq=3D<optimized out>, domain=3D<optimized out>)
    at ./arch/arm64/include/asm/ipipe.h:160
#15 gic_handle_irq (regs=3D0x6d2c59) at drivers/irqchip/irq-gic.c:404
#16 0xffffffc010085e04 in handle_arch_irq_pipelined (regs=3D<optimized out>=
) at arch/arm64/kernel/irq.c:43
#17 0xffffffc0100834c8 in el1_irq () at arch/arm64/kernel/entry.S:696
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb)


Best regards,
Josh

