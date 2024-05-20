Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DEF28E7
	for <xenomai@lists.linux.dev>; Mon, 20 May 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217928; cv=none; b=jBDIAG6HG1mtsUs+z9Vo7/RE7rr+j7RAAbq6+WkQw8Lqfk8nemxsdm0LWdAvhI/TaqyHwnHTwe1i0r/nHFEHRo2gBW7psCzGTnIdRlbsISK8Tpr5u2mqOLHXi11g4jgxe5YGv5RdZ78xGIbnz/8dVPCJlUpjxZO6ThlGGNtXU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217928; c=relaxed/simple;
	bh=CddQr3vUzmZ7IEd6H2mPa/mhrHgJpcq4CzChJQ5otq4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ig/t1/shgiOmAxX5ymVjWekYeWb9yY+uJxmCXpejMXBFU+bS5hgVk4BPT1WjI62asl8q05hJ3W92Hs/Ly7x9lOzLRJuzgvLT1bnP+0HILQNJKL6RWagrWdhQJwb04uerjRWml+o9rYPx/2LejxoyBcM4qqMJ8ESEG76oscFFHAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fBIuR+1g; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fBIuR+1g"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240520150143101dc06cbefc331c17
        for <xenomai@lists.linux.dev>;
        Mon, 20 May 2024 17:01:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Cc:References:In-Reply-To;
 bh=f/z7JK9JtGR0PDNZE757JKuD5VwV4gr+liLYov8TP+8=;
 b=fBIuR+1gRRDK6y1eOF27WACVtliXX3Le2MhdvINyyxtbHzXtlSD9mKFkG/bZvdiooHGlxY
 zVZi9CC+1sIu96T2tFVbSGaw1ZcZPTIaM2OICbAIjHOk769awWmnvZlASm7KqTUTRZVjXD2s
 I+aYPxYRDWBZGMUogfTi3xtOoOjuM=;
Message-ID: <770b1e4bc42cfa1ba5f4f37cc854956f3e78bb60.camel@siemens.com>
Subject: Re: NX-protected page
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: JerryJun <jerryjun123@163.com>, "Kowalsky, Clara"
	 <clara.kowalsky@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Date: Mon, 20 May 2024 17:01:41 +0200
In-Reply-To: <123d35fb.288.18ee41f9711.Coremail.jerryjun123@163.com>
References: <3ce13f2b.183be.18d2f264758.Coremail.jerryjun123@163.com>
	 <87ca0f83-bb2f-49fd-8e30-8873778cd8a9@web.de>
	 <6bec8d20.61c9.18d5e68d09d.Coremail.jerryjun123@163.com>
	 <e1accac9-4044-4379-8d4f-f0eb7cd9d713@siemens.com>
	 <fd2a3821-c4e6-4866-bc65-0bbadaf603e5@siemens.com>
	 <799babe6.660d.18d68cb571a.Coremail.jerryjun123@163.com>
	 <c79218e4-cc6d-4f34-93b3-e1405978476a@siemens.com>
	 <40cc100b.12313.18de5d67bf5.Coremail.jerryjun123@163.com>
	 <AS5PR10MB817389FE4D3AE120BC80E6D393062@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
	 <123d35fb.288.18ee41f9711.Coremail.jerryjun123@163.com>
Content-Type: multipart/mixed; boundary="=-alrol2+J3Cn1ymy1t3aJ"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

--=-alrol2+J3Cn1ymy1t3aJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I can reproduce this issue - with a slightly different kernel panic -
on dovetail 6.9.

As promised in the last Xenomai community call I will share the
simplified reproducer application and some logs.

The alchemy application in use is attached, the problematic
rt_task_set_affinity() call is currently deactivated. If activated it
crashes my qemu instance within 3 sec. You might have to adjust the
Makefile a bit to find xeno-config on your system.

As rt_task_set_affinity() makes the difference I'm assuming that
something around affine_move_task() is not properly synchronized.

@Philippe, any ideas?

Some more debug info will follow below the kernel crash dump.

xenomai.supported_cpus=3D3 is part of the kernel cmdline on boot, the
test appication tries to set a valid cpu mask (0x1) for the spawned RT
tasks.

[  439.848658] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI IRQ_PIPELINE
[  439.848666] CPU: 0 PID: 1364013 Comm: xeno-app Not tainted 6.9.0+ #15
[  439.848670] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
6.2-debian-1.16.2-1 04/01/2014
[  439.848673] IRQ stage: Linux
[  439.848675] RIP: 0010:srso_return_thunk+0x5/0x5f
[  439.848687] Code: cc cc cc 48 b8 48 8d 64 24 08 c3 cc cc 0f ae e8 e8 f0 =
ff ff ff 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 e8 db ff ff ff <0f=
> 0b 66 66 2e 0f 1f 84 00 00
[  439.848689] RSP: 0018:ffffc90000003f88 EFLAGS: 00010286
[  439.848693] RAX: ffffffff81f48065 RBX: ffffc9000eacbdb0 RCX: ffff888005e=
92408
[  439.848696] RDX: 0000000000000000 RSI: ffff88803e800000 RDI: ffffc9000ea=
cbdb0
[  439.848698] RBP: 0000000000000000 R08: ffff888005e92400 R09: 00000000000=
00000
[  439.848700] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000=
00000
[  439.848701] R13: 0000000000000000 R14: ffffc900006f3db0 R15: ffff888005c=
ac86c
[  439.848732] FS:  00007f616f850580(0000) GS:ffff88803e800000(0000) knlGS:=
0000000000000000
[  439.848735] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  439.848737] CR2: 00007f616faa2080 CR3: 00000000049fe000 CR4: 00000000003=
506f0
[  439.848739] Call Trace:
[  439.848801]  <IRQ>
[  439.848804]  ? die+0x31/0x80
[  439.848813]  ? do_trap+0xd8/0x100
[  439.848817]  ? srso_return_thunk+0x5/0x5f
[  439.848822]  ? do_error_trap+0xf0/0x140
[  439.848825]  ? srso_return_thunk+0x5/0x5f
[  439.848828]  ? srso_return_thunk+0x5/0x5f
[  439.848833]  ? exc_invalid_op+0x90/0xd0
[  439.848837]  ? srso_return_thunk+0x5/0x5f
[  439.848841]  ? asm_exc_invalid_op+0x1a/0x20
[  439.848849]  ? srso_return_thunk+0x5/0x5f
[  439.848853]  ? srso_return_thunk+0x5/0x5f
[  439.848857]  ? srso_return_thunk+0x5/0x5f
[  439.848860]  irq_work_single+0x27/0x60
[  439.848867]  irq_work_run_list+0x2d/0x40
[  439.848870]  irq_work_run+0x18/0x30
[  439.848873]  inband_work_interrupt+0x9/0x20
[  439.848878]  handle_synthetic_irq+0x7a/0x160
[  439.848881]  arch_do_IRQ_pipelined+0x84/0x400
[  439.848887]  </IRQ>
[  439.848888]  <TASK>
[  439.848890]  sync_current_irq_stage+0x111/0x170
[  439.848894]  __inband_irq_enable+0x3e/0x60
[  439.848897]  _raw_spin_unlock_irqrestore+0x1d/0x40
[  439.848900]  affine_move_task+0x104/0x4e0
[  439.848906]  ? __pfx_lostage_task_wakeup+0x10/0x10
[  439.848917]  __set_cpus_allowed_ptr+0x4f/0x90
[  439.848920]  __sched_setaffinity+0x8d/0x100
[  439.848925]  sched_setaffinity+0x166/0x1c0
[  439.848929]  __x64_sys_sched_setaffinity+0x4d/0x80
[  439.848932]  do_syscall_64+0x8d/0x1a0
[  439.848936]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  439.848940] RIP: 0033:0x7f616f93f037
[  439.848944] Code: 31 c0 48 83 c4 08 c3 0f 1f 40 00 48 8b 15 c1 3d 0e 00 =
f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 b8 cb 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 01 c3 48
[  439.848946] RSP: 002b:00007ffc06ff02b8 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000cb
[  439.848949] RAX: ffffffffffffffda RBX: 00007f616ef892d8 RCX: 00007f616f9=
3f037
[  439.848951] RDX: 00007f616ef892d8 RSI: 0000000000000080 RDI: 00000000001=
4d8be
[  439.848952] RBP: 00007ffc06ff02f0 R08: 0000000000000000 R09: 00000000fff=
fffff
[  439.848954] R10: 00007ffc06ff00a0 R11: 0000000000000206 R12: 00000000000=
00000
[  439.848956] R13: 00007ffc06ff0878 R14: 0000563c66118d98 R15: 00007f616fa=
da020
[  439.848962]  </TASK>
[  439.848963] Modules linked in:
[  439.848967] ---[ end trace 0000000000000000 ]---
[  439.848969] RIP: 0010:srso_return_thunk+0x5/0x5f
[  439.848973] Code: cc cc cc 48 b8 48 8d 64 24 08 c3 cc cc 0f ae e8 e8 f0 =
ff ff ff 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 e8 db ff ff ff <0f=
> 0b 66 66 2e 0f 1f 84 00 00
[  439.848975] RSP: 0018:ffffc90000003f88 EFLAGS: 00010286
[  439.848977] RAX: ffffffff81f48065 RBX: ffffc9000eacbdb0 RCX: ffff888005e=
92408
[  439.848979] RDX: 0000000000000000 RSI: ffff88803e800000 RDI: ffffc9000ea=
cbdb0
[  439.848980] RBP: 0000000000000000 R08: ffff888005e92400 R09: 00000000000=
00000
[  439.848982] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000=
00000
[  439.848983] R13: 0000000000000000 R14: ffffc900006f3db0 R15: ffff888005c=
ac86c
[  439.849010] FS:  00007f616f850580(0000) GS:ffff88803e800000(0000) knlGS:=
0000000000000000
[  439.849013] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  439.849015] CR2: 00007f616faa2080 CR3: 00000000049fe000 CR4: 00000000003=
506f0
[  439.849017] Kernel panic - not syncing: Fatal exception in interrupt
[  439.850172] Kernel Offset: disabled
[  439.992548] ---[ end Kernel panic - not syncing: Fatal exception in inte=
rrupt ]---


(gdb) list *(affine_move_task+0x104)
0xffffffff810d0244 is in affine_move_task (kernel/sched/core.c:3091).
3086				}
3087			}
3088			task_rq_unlock(rq, p, rf);
3089=09
3090			if (complete)
3091				complete_all(&pending->done);
3092		}
3093=09
3094		wait_for_completion(&pending->done);
3095=09
(gdb)


Best regards,
Florian

On Tue, 2024-04-16 at 07:37 +0800, JerryJun wrote:
>        Thank you so much for keeping an eye on this.
> 	Yes, we do use xenomai.supported_cpus =3D 0xf but we bind the real-time =
thread to cpu2
> 	You can repeat this problem in the attachment. As can be seen from backt=
race, this problem is related to the rt_set_affinity API. After we removed =
this rt_set_affinity API, it returned to normal, but we do not know the rea=
son
> 	We ran this test on other kernels and got some results from Crash analys=
is by kdump. We don't know if this will help us solve the problem
> =09
> =C2=A0 =C2=A0 =C2=A0 KERNEL: vmlinux-4.19.89-ipipe-9-xenomai-3.1-20201027
> =C2=A0 =C2=A0 DUMPFILE: V10-5T/202403231347/dump.202403231347=C2=A0 [PART=
IAL DUMP]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUS: 4
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 DATE: Sat Mar 23 13:47:22 2024
> =C2=A0 =C2=A0 =C2=A0 UPTIME: 05:29:52
> LOAD AVERAGE: 0.86, 0.67, 0.68
> =C2=A0 =C2=A0 =C2=A0 =C2=A0TASKS: 436
> =C2=A0 =C2=A0 NODENAME: debian
> =C2=A0 =C2=A0 =C2=A0RELEASE: 4.19.89-ipipe-9-xenomai-3.1-20201027
> =C2=A0 =C2=A0 =C2=A0VERSION: #1 SMP PREEMPT Tue Oct 27 19:51:52 CST 2020
> =C2=A0 =C2=A0 =C2=A0MACHINE: x86_64=C2=A0 (3600 Mhz)
> =C2=A0 =C2=A0 =C2=A0 MEMORY: 31.7 GB
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PANIC: "BUG: unable to handle kernel paging re=
quest at 00000000000a22e8"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PID: 26821
> =C2=A0 =C2=A0 =C2=A0COMMAND: "rtThread"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 TASK: ffff888791bc0040=C2=A0 [THREAD_INFO: ff=
ff888791bc0040]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU: 2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0STATE: TASK_RUNNING (PANIC)
> crash_pageoffset> bt -s
> PID: 26821=C2=A0 TASK: ffff888791bc0040=C2=A0 CPU: 2=C2=A0 =C2=A0COMMAND:=
 "rtThread"
> =C2=A0#0 [ffff88885fe03d10] machine_kexec+337 at ffffffff81041051
> =C2=A0#1 [ffff88885fe03d58] __crash_kexec+104 at ffffffff810f2818
> =C2=A0#2 [ffff88885fe03e20] crash_kexec+56 at ffffffff810f39d8
> =C2=A0#3 [ffff88885fe03e38] oops_end+186 at ffffffff8101795a
> =C2=A0#4 [ffff88885fe03e58] no_context+439 at ffffffff8104b2a7
> =C2=A0#5 [ffff88885fe03eb0] __do_page_fault+162 at ffffffff8104b8b2
> =C2=A0#6 [ffff88885fe03f28] ___xnsched_run+507 at ffffffff811838cb
> =C2=A0#7 [ffff88885fe03f60] xnintr_core_clock_handler+540 at ffffffff8117=
cddc
> =C2=A0#8 [ffff88885fe03fa0] dispatch_irq_head+126 at ffffffff8111953e
> =C2=A0#9 [ffff88885fe03fc8] __ipipe_handle_irq+103 at ffffffff81037f07
> #10 [ffff88885fe03ff0] apic_timer_interrupt+18 at ffffffff81801d22
> --- <IRQ stack> ---
> bt: cannot transition from IRQ stack to current process stack:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 IRQ stack pointer: ffff88885fe03d10
> =C2=A0 =C2=A0 process stack pointer: ffff88885fe03c10
> =C2=A0 =C2=A0 =C2=A0 =C2=A0current stack base: ffffc90005a30000
> 	=C2=A0 =C2=A0
> =C2=A0crash> dis -l ___xnsched_run
> linux-4.19.89-ipipe-9-xenomai-3.1/kernel/xenomai/sched.c: 1042=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (shadow && ipipe_root_p)
> 0xffffffff81183887 <___xnsched_run+439>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
=C2=A0 =C2=A0%r15d,%r15d=C2=A0=C2=A0
> 0xffffffff8118388a <___xnsched_run+442>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 je=C2=
=A0 =C2=A0 =C2=A00xffffffff811838b7 <___xnsched_run+487>=C2=A0=C2=A0
> linux-4.19.89-ipipe-9-xenomai-3.1/./arch/x86/include/asm/irqflags.h: 331=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipipe_get_curre=
nt_domain
> 0xffffffff8118388c <___xnsched_run+444>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 pushf=
q
> 0xffffffff8118388d <___xnsched_run+445>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 pop=
=C2=A0 =C2=A0 %rdx
> linux-4.19.89-ipipe-9-xenomai-3.1/./arch/x86/include/asm/irqflags.h: 261
> 0xffffffff8118388e <___xnsched_run+446>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 cli
> linux-4.19.89-ipipe-9-xenomai-3.1/./include/linux/ipipe_domain.h: 331=C2=
=A0 =C2=A0
> 0xffffffff8118388f <___xnsched_run+447>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov=
=C2=A0 =C2=A0 $0xa2260,%rax=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> linux-4.19.89-ipipe-9-xenomai-3.1/./include/linux/ipipe_domain.h: 269
> 0xffffffff81183896 <___xnsched_run+454>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov=
=C2=A0 =C2=A0 %gs:0x7ee8b93a(%rip),%rcx=C2=A0 # 0xf1d8=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return __ipipe_raw_cpu_read=
(ipipe_percpu.curr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 RCX: ffffffff828021c0=C2=A0 =C2=A0 =C2=A0 =C2=A0ffffffff828021c0:=C2=A0=
 0000000000042e80
> 0xffffffff8118389e <___xnsched_run+462>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov=
=C2=A0 =C2=A0 (%rax,%rcx,1),%rax=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0
> 0xffffffff811838a2 <___xnsched_run+466>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov=
=C2=A0 =C2=A0 0x42e70(%rax),%rax=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return __ipipe_get_current_context()->domain;
> linux-4.19.89-ipipe-9-xenomai-3.1/./arch/x86/include/asm/irqflags.h: 336
> 0xffffffff811838a9 <___xnsched_run+473>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 push=
=C2=A0 =C2=A0%rdx
> 0xffffffff811838aa <___xnsched_run+474>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 popfq
> linux-4.19.89-ipipe-9-xenomai-3.1/./include/linux/ipipe_domain.h: 334=C2=
=A0 =C2=A0
> 0xffffffff811838ab <___xnsched_run+475>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmp=
=C2=A0 =C2=A0 $0xffffffff825f8940,%rax=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> 0xffffffff811838b1 <___xnsched_run+481>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 je=C2=
=A0 =C2=A00xffffffff81183b06 <___xnsched_run+1078>=C2=A0=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 goto shadow_epilogue;=C2=A0=C2=A0
> linux-4.19.89-ipipe-9-xenomai-3.1/include/xenomai/cobalt/kernel/sched.h: =
372=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0
> 0xffffffff811838b7 <___xnsched_run+487>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov=
=C2=A0 =C2=A0 $0xa4540,%rdi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xffffffff811838be <___xnsched_run+494>=
:=C2=A0 =C2=A0 =C2=A0 =C2=A0 add=C2=A0 =C2=A0 %gs:0x7ee8b912(%rip),%rdi=C2=
=A0 =C2=A0# 0xf1d8
> linux-4.19.89-ipipe-9-xenomai-3.1/kernel/xenomai/sched.c: 1052=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xnthread_switch_fpu(sc=
hed);
> 0xffffffff811838c6 <___xnsched_run+502>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 callq=
=C2=A0 0xffffffff81189eb0 <xnthread_switch_fpu>
> linux-4.19.89-ipipe-9-xenomai-3.1/include/xenomai/cobalt/kernel/trace.h: =
84
> 0xffffffff811838cb <___xnsched_run+507>:=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov=
=C2=A0 =C2=A0 $0x1,%r15d
>=20
> [78270.764791] BUG: unable to handle kernel paging request at 00000000000=
a22e8
> [78270.771791] PGD 0 P4D 0
> [78270.774375] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [78270.778769] CPU: 2 PID: 26821 Comm: RunCommandActor Kdump: loaded Tain=
ted: P=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0O=C2=A0 =C2=A0 =C2=A0 4.19.8=
9-ipipe-9-xenomai-3.1-20201027 #1
> [78270.790893] Hardware name: Supermicro Super Server/C422-SF, BIOS E906.=
1 04/27/2021
> [78270.798536] I-pipe domain: Linux
> [78270.801787] RIP: a2260:0xffff88885fe1c560
> [78270.805834] Code: 00 00 00 00 00 00 00 00 00 00 c0 8f ea 5f 88 88 ff f=
f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <=
01> 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00
> [78270.824763] RSP: 81037f07:00000000000a2260 EFLAGS: ffff88885fe1c560 OR=
IG_RAX: ffffffff8111953e
> [78270.833421] RAX: 00000000000a2260 RBX: 0000000000000002 RCX: ffffffff8=
28021c0
> [78270.840596] RDX: ffff88885fe1c560 RSI: 0000000000000000 RDI: 000000000=
0000000
> [78270.847790] RBP: ffff88885fea4540 R08: 000000000005f3e0 R09: 000000000=
000fe0c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0
> [78270.854984] R10: ffffffff8117cddc R11: 0000000000000002 R12: ffff88885=
fea5d08=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
> [78270.862185] R13: ffffe8ffffc079c8 R14: ffff88885fea4540 R15: ffffffff8=
11838cb=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0
> [78270.869335] FS:=C2=A0 00007fe12237c700(0000) GS:ffff88885fe00000(0000)=
 knlGS:0000000000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0
> [78270.877499] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [78270.883298] CR2: 00000000000a22e8 CR3: 0000000852a06006 CR4: 000000000=
01606e0
> [78270.890465] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [78270.897658] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [78270.904843] Call Trace:
> [78270.996185] CR2: 00000000000a22e8
>=20
> From the backtrace above, based on the value stored in the CPU register a=
t the time of the kernel crash, the location where the page fault was trigg=
ered appears to be at ___xnsched_run+507.
> Kernel crash occurs with RAX value 0xa2260 from <___xnsched_run+447>: mov=
 $0xa2260,%rax. The value of the GS register is ffff88885fe00000, the addre=
ss of the percpu variable in CPU2.
> crash> kmem -o
> PER-CPU OFFSET VALUES:
> CPU 0: ffff88885fc00000
> CPU 1: ffff88885fd00000
> CPU 2: ffff88885fe00000
> CPU 3: ffff88885ff00000
>=20
> The RDX register has the value ffff88885fe1c560, which is the address of =
the ipipe_percpu variable in CPU2
> crash> p ipipe_percpu
> PER-CPU DATA TYPE:
> struct ipipe_percpu_data ipipe_percpu;
> PER-CPU ADDRESSES:
> [0]: ffff88885fc1c560
> [1]: ffff88885fd1c560
> [2]: ffff88885fe1c560
> [3]: ffff88885ff1c560
>=20
> <___xnsched_run+454>:=C2=A0 mov %gs:0x7ee8b93a(%rip),%rcx # 0xf1d8 namely=
 __ipipe_raw_cpu_read(iPipe_percpu.curr) The member of curr is obtained thr=
ough the ipipe_percpu variable
> crash> ipipe_percpu_data ffff88885fe1c560 -o
> struct ipipe_percpu_data {
> [ffff88885fe1c560] struct ipipe_percpu_domain_data root;
> [ffff88885fe5f3e0] struct ipipe_percpu_domain_data head;
> [ffff88885fea2260] struct ipipe_percpu_domain_data *curr;
> [ffff88885fea2268] struct pt_regs tick_regs;
> [ffff88885fea2310] int hrtimer_irq;
> [ffff88885fea2318] struct task_struct *task_hijacked;
> [ffff88885fea2320] struct task_struct *rqlock_owner;
> [ffff88885fea2328] struct ipipe_vm_notifier *vm_notifier;
> [ffff88885fea2330] unsigned long nmi_state;
> [ffff88885fea2338] struct mm_struct *active_mm;
> }
> SIZE: 548320
>=20
> RIP a2260:0xffff88885fe1c560 is the location of ipipe_percpu.curr,
> CR2 00000000000a22e8 Stores the linear address of the page fault when it =
occurs, which points to the ip member of the struct pt_regs from below, and=
 the value of the GS segment register + CR2 register is ffff88885fea22e8.
> crash_pageoffset> struct pt_regs ffff88885fea2268 -o
> struct pt_regs {
> [ffff88885fea2268] unsigned long r15;
> [ffff88885fea2270] unsigned long r14;
> [ffff88885fea2278] unsigned long r13;
> [ffff88885fea2280] unsigned long r12;
> [ffff88885fea2288] unsigned long bp;
> [ffff88885fea2290] unsigned long bx;
> [ffff88885fea2298] unsigned long r11;
> [ffff88885fea22a0] unsigned long r10;
> [ffff88885fea22a8] unsigned long r9;
> [ffff88885fea22b0] unsigned long r8;
> [ffff88885fea22b8] unsigned long ax;
> [ffff88885fea22c0] unsigned long cx;
> [ffff88885fea22c8] unsigned long dx;
> [ffff88885fea22d0] unsigned long si;
> [ffff88885fea22d8] unsigned long di;
> [ffff88885fea22e0] unsigned long orig_ax;
> [ffff88885fea22e8] unsigned long ip;
> [ffff88885fea22f0] unsigned long cs;
> [ffff88885fea22f8] unsigned long flags;
> [ffff88885fea2300] unsigned long sp;
> [ffff88885fea2308] unsigned long ss;
> }
> SIZE: 168
>=20
> <___xnsched_run+475>:=C2=A0 cmp $0xffffffff825f8940,%rax Where $0xfffffff=
f825f8940 is the address of the ipipe_percpu_domain_data root variable in r=
oot mode.
> The contents of the register when the kernel crashes appear to be the roo=
t domain when executing __ipipe_current_domain =3D=3D ipipe_root_domain to =
determine whether the domain is the root domain at this time. A crash occur=
s when obtaining the ip member of pt_regs on the percpu variable ipipe_perc=
pu_data. At present, the rtThread real-time thread is bound to run in CPU2,=
 and the switch from xenomai mode to linux mode occurs during the run time.=
 From this log, is the kernel crash caused by a mode switch?
> Here are some of the meanings of CPU registers:
> R08 5f3e0: Indicates the offset of ipipe_percpu.head
> a2260: indicates the offset of ipipe_percpu.curr
> RBP ffff88885fea4540: struct xnsched nksched
> R12 ffff88885fea5d08: xnsched.current_account
> 0xffff88885fe1c560: struct ipipe_percpu_data
> RCX FFFFFF828021C0: The value is 0000000000042e80
>=20
>=20
> At 2024-04-10 15:46:48, "Kowalsky, Clara" <clara.kowalsky@siemens.com> wr=
ote:
> > Hi,
> >=20
> > just so you know, we're looking at this issue.
> > Which cmdline did you use? Was xenomai.supported_cpus set?
> > In the meantime, if you have more information or if you have been able =
to create a simplified application where the bug still occurs, please let u=
s know.
> >=20
> > Best
> > Clara
> >=20
> > > -----Original Message-----
> > > From: JerryJun <jerryjun123@163.com>
> > > Sent: Montag, 26. Februar 2024 15:34
> > > To: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
> > > Cc: xenomai <xenomai@lists.linux.dev>
> > > Subject: Re:Re: NX-protected page
> > >=20
> > > hi, Jan,  if  you have reproducted it  after trying to run the case f=
or hours in
> > > qemu=EF=BC=9F or is there any doubt=EF=BC=9F
> > >=20
> > > 2024-02-02 16:37:59, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
> > > > On 02.02.24 08:49, JerryJun wrote:
> > > > >=20
> > > > > how long did you run it=EF=BC=9Fit will take a while for this cra=
sh but not more than
> > > 12 hours at mostly.
> > > > > ok=EF=BC=8Ci will try to run it without get /proc=E2=80=A6=E2=80=
=A6 thank you very much.
> > > > >=20
> > > >=20
> > > > Not for hours, but one setup was running for about 30 min. at least=
.
> > > >=20
> > > > Jan
> > > >=20
> > > > >=20
> > > > > At 2024-02-02 14:49:53, "Jan Kiszka" <jan.kiszka@siemens.com> wro=
te:
> > > > > > On 01.02.24 08:09, Jan Kiszka wrote:
> > > > > > > On 31.01.24 08:25, JerryJun wrote:
> > > > > > > > yet=EF=BC=8C you just do make in the project to product the=
 binary of oop-test,
> > > run kill_test.sh , and finally wait kernel oop .
> > > > > > > > we get the same results of kernel oop in the qemu-amd64, wh=
ich use
> > > the config from xenomai-images
> > > ,"https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fsou
> > > rce.denx.de%2FXenomai%2Fxenomai-images%2F-
> > > %2Fblob%2Fmaster%2Frecipes-
> > > kernel%2Flinux%2Ffiles%2Famd64_defconfig%3Fref_type%3Dheads&data=3D0
> > > 5%7C02%7Cclara.kowalsky%40siemens.com%7C494bca636f6c48566cc208d
> > > c36d843eb%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6384
> > > 45549672638180%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> > > AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&s
> > > data=3DxOckYYYOkjKZ3yKchy4B7kkX2eth%2Bqe88Mrd7XjldFw%3D&reserved=3D
> > > 0", as follow.
> > > > > > > > [ 6191.671953] BUG: kernel NULL pointer dereference, addres=
s:
> > > > > > > > 0000000000000000 [ 6191.671955] #PF: supervisor instruction=
 fetch
> > > > > > > > in kernel mode [ 6191.671956] #PF: error_code(0x0010) -
> > > > > > > > not-present page [ 6191.671956] PGD 0 P4D 0 [ 6191.671958] =
Oops:
> > > > > > > > 0010 [#1] PREEMPT SMP PTI IRQ_PIPELINE [ 6191.671959] CPU: =
3 PID:
> > > > > > > > 7047 Comm: oop-test Kdump: loaded Not tainted
> > > > > > > > 5.10.199-devo-3.2.4-20240130 #1 [ 6191.671960] Hardware nam=
e:
> > > QEMU
> > > > > > > > Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014=
 [
> > > > > > > > 6191.671961] IRQ stage: Linux [ 6191.671961] RIP: 0010:0x0 =
[
> > > > > > > > 6191.671962] Code: Unable to access opcode bytes at RIP
> > > 0xffffffffffffffd6.
> > > > > > > > [ 6191.671962] RSP: 0018:ffffc90000118f80 EFLAGS: 00010246 =
[
> > > > > > > > 6191.671963] RAX: 0000000000000000 RBX: ffff888108d3d730 RC=
X:
> > > > > > > > 0000000000000000 [ 6191.671964] RDX: ffff888108d3d738 RSI:
> > > > > > > > ffffffff82516284 RDI: ffff888108d3d730 [ 6191.671965] RBP:
> > > > > > > > 0000000000000000 R08: 0000000000000000 R09:
> > > 0000000000000001 [
> > > > > > > > 6191.671965] R10: 0000000000000000 R11: 0000000000000001
> > > R12:
> > > > > > > > 0000000000000000 [ 6191.671966] R13: 0000000000000018 R14:
> > > > > > > > ffffffff811d37e0 R15: 0000000000000000 [ 6191.671967] FS:
> > > > > > > > 00007fc6e83ea780(0000) GS:ffff88813bd80000(0000)
> > > > > > > > knlGS:0000000000000000 [ 6191.671967] CS:  0010 DS: 0000 ES=
:
> > > 0000 CR0: 0000000080050033 [ 6191.671968] CR2: ffffffffffffffd6 CR3:
> > > 0000000106750005 CR4: 0000000000170ee0 [ 6191.671968] Call Trace:
> > > > > > > > [ 6191.671968]  <IRQ>
> > > > > > > > [ 6191.671969]  ? show_trace_log_lvl+0x1c2/0x2c9 [ 6191.671=
969]  ?
> > > > > > > > irq_work_single+0x42/0x80 [ 6191.671969]  ?
> > > > > > > > __die_body.cold+0x8/0xd [ 6191.671970]  ? no_context+0x13a/=
0x270
> > > [
> > > > > > > > 6191.671970]  ? exc_page_fault+0x6f/0x200 [ 6191.671970]  ?
> > > > > > > > asm_exc_page_fault+0x1e/0x30 [ 6191.671970]  ?
> > > > > > > > handle_oob_irq+0x90/0x90 [
> > > 6191.671971]  irq_work_single+0x42/0x80
> > > > > > > > [ 6191.671971]  irq_work_run_list+0x2d/0x40 [ 6191.671971]
> > > > > > > > irq_work_run+0x26/0x40 [ 6191.671972]
> > > > > > > > inband_work_interrupt+0xa/0x20 [ 6191.671972]
> > > > > > > > handle_synthetic_irq+0xb1/0x210 [ 6191.671972]
> > > > > > > > asm_call_irq_on_stack+0x12/0x20 [ 6191.671973]  </IRQ> [
> > > > > > > > 6191.671973]  arch_do_IRQ_pipelined+0x15d/0x2a0 [ 6191.6719=
73]
> > > > > > > > sync_current_irq_stage+0x157/0x1f0
> > > > > > > > [ 6191.671974]  __inband_irq_enable+0x4b/0x70 [ 6191.671974=
]
> > > > > > > > _raw_spin_unlock_irqrestore+0x35/0x70
> > > > > > > > [ 6191.671974]  __set_cpus_allowed_ptr+0xbf/0x230 [
> > > 6191.671975]
> > > > > > > > sched_setaffinity+0x383/0x6b0 [ 6191.671975]
> > > > > > > > __x64_sys_sched_setaffinity+0x45/0x80
> > > > > > > > [ 6191.671975]  do_syscall_64+0x39/0x50 [ 6191.671978]
> > > > > > > > entry_SYSCALL_64_after_hwframe+0x62/0xc7
> > > > > > > > [ 6191.671979] RIP: 0033:0x7fc6e84d6617 [ 6191.671979] Code=
: 1f
> > > 40
> > > > > > > > 00 48 8b 15 79 c8 0e 00 f7 d8 41 b9 ff ff ff ff 64 89 02 44=
 89 c8
> > > > > > > > c3 66 2e 0f 1f 84 00 00 00 00 00 b8 cb 00 00 00 0f 05 <48> =
3d 00
> > > > > > > > f0 ff ff 77 29 41 89 c0 83 f8 ff 74 18 64 c7 04 25 38 00 [
> > > > > > > > 6191.671980] RSP: 002b:00007ffd574dfde8 EFLAGS: 00000206
> > > ORIG_RAX:
> > > > > > > > 00000000000000cb [ 6191.671981] RAX: ffffffffffffffda RBX:
> > > > > > > > 00007fc6e7b985c8 RCX: 00007fc6e84d6617 [ 6191.671982] RDX:
> > > > > > > > 00007fc6e7b985f0 RSI: 0000000000000080 RDI:
> > > 0000000000001b8d [
> > > > > > > > 6191.671982] RBP: 00007ffd574dfe70 R08: 00007fc6e83ea780 R0=
9:
> > > 00000000ffffffff [ 6191.671983] R10: fffffffffffffdca R11:
> > > 0000000000000206 R12: 000055a818eb61c0 [ 6191.671983] R13:
> > > 0000000000000000 R14: 0000000000000000 R15: 0000000000000000 [
> > > 6191.671984] Modules linked in:
> > > > > > > > [ 6191.671985] CR2: 0000000000000000
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Okay... that is "good" news - looking for some time slot to
> > > > > > > reproduce and debug myself now.
> > > > > > >=20
> > > > > >=20
> > > > > > I've tried to reproduce, using the .config.yaml below for
> > > > > > xenomai-images, but it does not trigger here. Do I need to run =
this
> > > > > > for hours? What exactly did you do to trigger it in the qemu im=
age
> > > > > > of xenomai-images?
> > > > > >=20
> > > > > > BTW, I assume the access of /proc/xenomai/sched/stat plays an
> > > > > > important role in causing the crash, right? You don't get it wi=
thout them?
> > > > > >=20
> > > > > > Jan
> > > > > >=20
> > > > > > #
> > > > > > # Automatically generated by kas 4.2 #
> > > > > > _source_dir: /repo
> > > > > > build_system: isar
> > > > > > header:
> > > > > >  includes:
> > > > > >  - kas.yml
> > > > > >  - board-qemu-amd64.yml
> > > > > >  - opt-linux-latest-5.10.yml
> > > > > >  version: 16
> > > > > > menu_configuration:
> > > > > >  DEBUG: false
> > > > > >  KERNEL_4_19: false
> > > > > >  KERNEL_4_19_LATEST: false
> > > > > >  KERNEL_5_10: false
> > > > > >  KERNEL_5_10_LATEST: true
> > > > > >  KERNEL_5_15: false
> > > > > >  KERNEL_5_15_LATEST: false
> > > > > >  KERNEL_5_4: false
> > > > > >  KERNEL_5_4_LATEST: false
> > > > > >  KERNEL_6_1: false
> > > > > >  KERNEL_6_1_LATEST: false
> > > > > >  TARGET_BBB: false
> > > > > >  TARGET_HIKEY: false
> > > > > >  TARGET_QEMU_AMD64: true
> > > > > >  TARGET_QEMU_ARM: false
> > > > > >  TARGET_QEMU_ARM64: false
> > > > > >  TARGET_X86_64_EFI: false
> > > > > >  XENOMAI3: true
> > > > > >  XENOMAI4: false
> > > > > >  XENOMAI_3_0_LATEST: false
> > > > > >  XENOMAI_3_1_LATEST: false
> > > > > >  XENOMAI_3_2: true
> > > > > >  XENOMAI_3_2_LATEST: false
> > > > > >  XENOMAI_LATEST: false
> > > > > >=20
> > > > > > --
> > > > > > Siemens AG, Technology
> > > > > > Linux Expert Center
> > > >=20
> > > > --
> > > > Siemens AG, Technology
> > > > Linux Expert Center


--=-alrol2+J3Cn1ymy1t3aJ
Content-Type: application/x-compressed-tar; name="xenomai-alchemy-app.tar.gz"
Content-Disposition: attachment; filename="xenomai-alchemy-app.tar.gz"
Content-Transfer-Encoding: base64

H4sIAAAAAAAAA+1WeW/iRhTPv55P8ZaQlc0ChgRIBck2CTma5qqAVVfdppZjj2EUYyPb7GZb7Xfv
m/EJIUcltFLb+UlozLuvefYD9fypyWqma03o9GvNnM30jTWjgdhtt/nZ3G03imeKjWars73dabfa
nd2NRnOn0d7dgPa6A1mFeRiZAcCG4/rPyr3E/5fiYUX/w8Ba6wz8k/63Gi3e/85OS/b/e+Cp/iPN
q1vr8cEb3Gm1nur/dgfv/GL/W7s7eP8b63H/PP7n/d9knuXObQp7IQ6AXZ+8JzkpGQo9MsN7ziGb
NnWYR2H00+Dk8NjoX49gp0EIljBiFjAvgrHr35muQR9YZEQBG49pAPvQ6GVCn31mQ8jGHkpNTM92
aaBq5C+irNZs9si3Rd0gMvhwquJPxQzGQvvLhLkU1DcrrGiAfGUeupTO1GYDKtDEqUsOrQe6jk8Q
Uoso35adRZOAmnZo8CGJ1MHIGB0OL6CCMfCahFWRcyWWMpgd8lhAsSY4UlzA8Mwp/bTd7tz2iGLN
5kZIUROmyEIC1w1ohLUBpf/LB+O3k8GN+pYztV5CGp6M1GYVUiJRHD8AlSsyUVY89grdwP/v3vF8
MeHQmwUo6KhZIFWs+5/UL1C0KpSCqMb/17bsEqYjnCgYFZpPsjQszC6i6ts060/stgoFq40qtPGH
tURV5oCK6nHRlSSE0qmJ7cFy+hAbE+qwZf/uJU5R9g45vCzYBb2iKI/C4LUzHZw/Fn1dCiatz8vu
0QikRoAX8/lAKjovR95f9IYRsd7j4MSALEWVjCo+LVh4XaDc4AvRPTev/uzxuIqbkk/da4dpOVeb
unRpHlakhNw0KyfLKlZdlZblexHz5rSYGQ9N3HX+gDfdqoK4WhV+7T/Hdy1NMgsmT+A2uWOF4i8w
iRLvIXV4fnZ+PaourSVxFdIUhrwdzBtjyIL+4r5Z3Bz5wijsil5hLVUKy2gaLuhjJ7MG9pLKrG3/
r3r/X5n3uOZdui4fL7z/m8n7H78R8Tux2eTv/zYe8v3/HbD5Rp+HgX7HPPzku6dQcwgZXpxfA6K7
D8lYEHLzYQQJra7784icfDxJCWUVuZrOR4nPDxkO+rksfkxywvH5YBjL4h9Nx/MLc23LDOyUVNE1
LjjMjBYETNsO57i1H6BSt6pCgRvUNI3cHP2cq8zMKJzfhVFqc0tIi+i26n6siFqEXF2gPmr9uA/T
e5sFZHAlQuaEYEo+XvdPz+J/ojyub5mu/vBDRxRKJIr7ymFjQvpxrrH/cEJdF0+hr0GtZlka6Z9e
Hp4Nn5II75m3j4FhzYWC45rjEJ9+NVGuNiaXx7H6q7RdO1FHtcvzo9gpIWiqi18qjo+q2DeNb1bH
7xLlgFoTH0pHcyy1EOiWMmK/30Xxfl/LSUnZu5B3YIGZcorkOHthSjwVWElqnJc8IpOk/eomc4Xi
ZVX0CzOcZUXApvGvDygfaLlO3e8WWg/pIoPMJQDvV3mv9AqrXALTzyOHmoWqUMMyHnCfvJQiShxB
reDi8hhdHJQKBtL0oPxHrC5ovENZ8N1iRNy+5VLTi6mDK/QdOFlBYH37X0JCQkJCQkJCQkJCQkJC
QkJCQkJC4r+JvwFyLhf7ACgAAA==


--=-alrol2+J3Cn1ymy1t3aJ--
