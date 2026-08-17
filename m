Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE044237F
	for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980026; cv=none; b=NhwrKWTZ0TPbAYX4yQvJ0+G4SCLAFy1iuO1F1wtscUX2elBu9/C6qHnX7XY9P+RR8VMyy5YfOlMOZlRLaXJ3z8v9ZnueM1wQRts/qZ4yqdmU5oh64jMClsU8IoRA8hXWdBZ6aAKcr9kxWcvDtB4JEZOPqEGCLRftop3KGjs7XC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980026; c=relaxed/simple;
	bh=jtPcZx6KQ0NdAbo/RyPpof881YH1k/bxjx6mAMuyqXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bzolc15f8CwDNsk81K+sE7bYSw9+ysE+Z4irU87SXfs1L9XBk8KRhA+2BHBcUCurw1Yp/q6gv/vy+8bidJs2iVv4aQ0Z/atKfjJKEWYAYOmDavdPzc42aWkEo/AZlR6b8k5UsDqE/0WncHBly5UW0Kbxynl6qN43VHDWV4hF+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=PzBuHJaJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="PzBuHJaJ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F6C13ED17;
	Mon, 17 Aug 2026 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1786980021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N0365R/g3ULwK0sQkMVM3QT1hRqjrwvp+Duxb4Tfshk=;
	b=PzBuHJaJeBcE8RM0QKNDbClYzw4j1bgGYYoOrhsMuTU4S/C/q8rNXDiYdPO0p2ftdqYG/K
	OtMK9Ax8WgP56buQfHvF+oi6K46iKohQcnVjdplAOtF2ssV+H1CZLSKqHDP8UXjP/B+F67
	5jnubEpgYbI/PAMGAfqVO85aPDWv08NWm4x0nzevvSft7qtR+8wfU9wZGLIe8iORRx6BtJ
	9+SeT6ArUvJJAwvihZpTzJUgpYY+kSEczn1AP2PjAPuMbK/QftkRQ4MQgIuwrEDE9Ttt2z
	qj2s/n9jcl3bUf20YQK06LFzhhXdSjnX5OBdeGIZ0rq933eYLFgKiFYIGCr4/A==
From: Philippe Gerum <rpm@xenomai.org>
To: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
In-Reply-To: <CAKndYJFsiha4BZ1VmyM4-XADyNJ0RusC+TPJAm9k2q99=khLLA@mail.gmail.com>
	(Gerte Hoogewerf's message of "Mon, 17 Aug 2026 14:05:48 +0200")
References: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
	<87v799kt2q.fsf@xenomai.org>
	<CAKndYJFhN5MfybdumExs7b5gTqW_CHa_i=cOL7R6xgjad1ytDQ@mail.gmail.com>
	<b7d8d1e3-0353-49dd-b626-5aaae76f7526@siemens.com>
	<CAKndYJFsiha4BZ1VmyM4-XADyNJ0RusC+TPJAm9k2q99=khLLA@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 17 Aug 2026 17:20:20 +0200
Message-ID: <87bjb0lqob.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFKFgLgcLdlM+vhJ34kdUOOkTnLXRvef1eNvDonvDzsjo/ZCMk0inHvmPgy2r6k5Tgwo9EofXqIhDrnLge7yHPm5M6PqoO1hCveFi6LoiK8aQTBRzp/e+UVeZY9v2sxCIkMxMzmr6KMEzGr3DDnTF2Bft9HDa3jiIbYu/rk8HSXyFmBnXu/VH2en2OIV5LTNhRtqwc1Vh3dKDzaRl4ORPa05lGOuB8tZm+V2C1XXoGRrcK6v4i840jIINQ2Txs0KTWZKeyt6tBPLugA3HISBsx50vv0oHalBT+kXsVSR5/7lK7t5Pxgze4Fn2WLzpHIzLq7jfbw9agZg+xP8M6+fp0tiSLeEfKqUzI1qC7zNx8lbxba+n+C2qDE4MdkxDwsy7HH5oDv32N4iDdOSnto7B4gfOk9JjzX1/ZoS2DbCDwhPeA4o4MVhFhVOP7Is8PYzkmbL4WnePo1hM3QCP6umgp5s0CNWERVr+Dhr7CwWLwfO5EHBQGZrSxQhaUmdrNYim7O1oMuswOsvn+KMNoPdotXPkBZwZ0CGG9ZpNIy0accaMdxakpONFkv7T9rPkdVmqoiiVw8qDcZfA4M3wPF5JCs9REnN014aT7c+qbeT2WPI4ZCP7AhRn4h3ZBxbRwrhqOwF9QG1pD22AJ0Qd7X5vtb9zzVEKttW8HZc2j6O3n4lQ
X-GND-State: clean
X-GND-Score: -100

Gerte Hoogewerf <ghoogewerf@lmi3d.com> writes:

> Hey Jan/Philippe,
>
> Thanks for pointing me in this direction.  I've done a bit of research
> and I'm making good progress.
>
> It actually booted as soon as I disabled the "scutimer" clock source
> via the DTB.  This made the kernel fall back to "arm_global_timer" and
> now it boots properly.
>
> So, the original problem may be in Dovetail's "smp_twd" handoff under SMP.
>

Yes it is, good catch. At least, I could reproduce a crash on a socfpga
cyclone V. Enabling CONFIG_IRQ_PIPELINE is enough to crash the board
when entering user mode on this board:

[   14.199634] 8<--- cut here ---
[   14.199646] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[   14.199655] [00000000] *pgd=00000000
[   14.199666] Internal error: Oops: 5 [#1] SMP ARM
[   14.199673] Modules linked in:
[   14.199681] CPU: 0 UID: 0 PID: 31 Comm: kworker/u8:1 Not tainted 6.18.29-01154-gbeaef3a002b8 #8 NONE 
[   14.199695] Hardware name: Altera SOCFPGA
[   14.199699] IRQ stage: Linux
[   14.199704] Workqueue: xprtiod xs_stream_data_receive_workfn
[   14.199727] PC is at unwind_frame+0x3a8/0x6f8
[   14.199743] LR is at 0x0
[   14.199749] pc : [<c011b1b8>]    lr : [<00000000>]    psr: 60000113
[   14.199755] sp : f0801e10  ip : f0801e5c  fp : 00000000
[   14.199760] r10: 00000001  r9 : 00000003  r8 : 00000000
[   14.199765] r7 : f0801ea8  r6 : 00002000  r5 : 00000000  r4 : 00000000
[   14.199771] r3 : 00000001  r2 : c0c31b4c  r1 : 00000000  r0 : 0000000e
[   14.199776] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   14.199785] Control: 10c5387d  Table: 01d3004a  DAC: 00000051
[   14.199790] Register r0 information: non-paged memory
[   14.199800] Register r1 information: NULL pointer
[   14.199807] Register r2 information: non-slab/vmalloc memory
[   14.199814] Register r3 information: non-paged memory
[   14.199820] Register r4 information: NULL pointer
[   14.199825] Register r5 information: NULL pointer
[   14.199831] Register r6 information: non-paged memory
[   14.199836] Register r7 information: 2-page vmalloc region starting at 0xf0800000 allocated at start_kernel+0x4d0/0x678
[   14.199852] Register r8 information: NULL pointer
[   14.199859] Register r9 information: non-paged memory
[   14.199864] Register r10 information: non-paged memory
[   14.199870] Register r11 information: NULL pointer
[   14.199876] Register r12 information: 2-page vmalloc region starting at 0xf0800000 allocated at start_kernel+0x4d0/0x678
[   14.199889] Process kworker/u8:1 (pid: 31, stack limit = 0x(ptrval))
[   14.199897] Stack: (0xf0801e10 to 0xf0802000)
[   14.199907] 1e00:                                     00000000 c0b32ac0 00000000 ef7d00c0
[   14.199917] 1e20: c10d8b00 4e5cf840 00000001 00000003 c10d8b00 2ea79000 f0801ebc c015c718
[   14.199926] 1e40: 00000001 c10d8880 ef7d0080 ef7d0080 00000000 ef7d00c0 00000000 00000000
[   14.199936] 1e60: 00000000 c015fb44 ef7d0080 c0d57080 ef7d0080 c0147380 ef7d0080 01b9fb81
[   14.199945] 1e80: c0e03f34 ef7cc428 c0e02d40 00000003 4dca536e ef7cc428 00000003 ef7ce1c0
[   14.199955] 1ea0: 00000080 c0116524 00000000 00000000 00000000 c0951e04 4dca536e 01b9fb81
[   14.199964] 1ec0: 00000001 c01adb4c ef7ce1c0 c01c3fb0 00000001 00000022 00000002 ef7cde40
[   14.199973] 1ee0: ef7cde00 ef7cde00 c01c3f10 4dca4dce 00000003 c01b0fb0 ef7cfa00 ef7cde54
[   14.199982] 1f00: 00000000 4dca4dce 00000003 c0e3d316 c133ca6c ef7cde00 00000080 00000003
[   14.199992] 1f20: 4dca4dce ef7cde0c ef7cde88 ef7cdeb0 ef7cded8 c01b1d70 00000080 0000000f
[   14.200001] 1f40: c0e19148 4ce379c6 ef7cdf30 ef7cdf80 ef7cdf50 c0e48eb8 4dca4dce 00000003
[   14.200010] 1f60: c0d56980 00000001 c0a27f30 00000019 f0801fc0 c0e19148 00000001 00000000
[   14.200019] 1f80: 00000019 c011aa70 c1018300 c018f778 c0d56948 c1018300 00000000 f0801fc0
[   14.200029] 1fa0: c0e19148 c018820c c0d56948 c011d3e0 c0e19148 00000001 c10d8880 c0193b40
[   14.200038] 1fc0: c0e04214 c0d53410 c0d56948 c10d8880 ef7cc410 ffffffff f0911d24 c1475320
[   14.200047] 1fe0: c10d8880 00000000 f0911ce8 c0193ec4 c0951e04 60000113 ffffffff c091c95c
[   14.200052] Call trace: 
[   14.200058]  unwind_frame from profile_pc+0x60/0x9c
[   14.200076]  profile_pc from profile_tick+0x2c/0x54
[   14.200094]  profile_tick from tick_nohz_handler+0xa0/0x128
[   14.200113]  tick_nohz_handler from __hrtimer_run_queues+0x158/0x1f4
[   14.200134]  __hrtimer_run_queues from hrtimer_interrupt+0x140/0x2d8
[   14.200156]  hrtimer_interrupt from twd_handler+0x68/0x7c
[   14.200176]  twd_handler from handle_percpu_devid_irq+0xe8/0x1b8
[   14.200191]  handle_percpu_devid_irq from handle_irq_desc+0x5c/0x90
[   14.200209]  handle_irq_desc from arch_do_IRQ_pipelined+0x30/0x50
[   14.200227]  arch_do_IRQ_pipelined from sync_current_irq_stage+0x108/0x1a0
[   14.200248]  sync_current_irq_stage from handle_irq_pipelined_finish+0x64/0xd0
[   14.200266]  handle_irq_pipelined_finish from call_with_stack+0x18/0x20
[   14.200291]  call_with_stack from __irq_svc+0xa0/0xc8
[   14.200309] Exception stack(0xf0911cf0 to 0xf0911d38)
[   14.200317] 1ce0:                                     c1e38fa8 c1e38fb4 c1e38fb4 00000000
[   14.200328] 1d00: c1e38ec0 f0911eb0 0000000c f0911d58 c1475320 c19113c8 00000000 c10d8880
[   14.200336] 1d20: 00000001 f0911d48 c07ec654 c0951e04 60000113 ffffffff
[   14.200343]  __irq_svc from _raw_spin_unlock_bh+0x0/0x30
[   14.200365]  _raw_spin_unlock_bh from 0xf0911d58
[   14.200386] Code: 0afffff9 e35b0000 1a000043 e350000e (e594e000) 
[   14.200393] ---[ end trace 0000000000000000 ]---
[   14.200400] Kernel panic - not syncing: Fatal exception in interrupt

Intuitively, I'd say that trying to walk the interrupt stack frame of a
clock event which is likely to have been deferred due to pipelining is
unlikely to be a great idea, since that frame was already unwound prior
to the call to unwind_frame(). Why such issue wasn't hit earlier still
needs to be explained.

Anyway, the following patch allows the socfpga to boot, could you please
try it on the Zynq?

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index df25c88b2c783..ad3b4256ebbff 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -107,7 +107,7 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
 	instruction_pointer(regs) = val;
 }
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_IRQ_PIPELINE)
 extern unsigned long profile_pc(struct pt_regs *regs);
 #else
 #define profile_pc(regs) instruction_pointer(regs)
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index b3836c94dc748..cd5d7576e5780 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -40,7 +40,7 @@ EXPORT_SYMBOL(rtc_lock);
 /* change this if you have some constant time drift */
 #define USECS_PER_JIFFY	(1000000/HZ)
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_IRQ_PIPELINE)
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	struct stackframe frame;
        

The effect of such change on profiling in SMP still needs to be
assessed, but at any rate, we cannot keep unwinding stale stack frames,
so we need a fix in this area.

Please also note that I had to manually enable CONFIG_VDSO which
socfpga_config did not (for some reason to be determined too), so that
real-time applications can perform clock readouts in a syscall-less
fashion. Latency is fine on the socfpga after enabling it, that would
still work without at the expense of a couple of micro-seconds for each
readout though. You may want to check that VDSO is enabled by the Zynq
config as well.

You may also want to run "evl check" in a shell to make sure no adverse
kernel setting is in the way of minimal latency.

-- 
Philippe.
