Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B63107AA
	for <xenomai@lists.linux.dev>; Mon, 10 Jul 2023 12:11:50 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230710121141b65834cdeb140be40e
        for <xenomai@lists.linux.dev>;
        Mon, 10 Jul 2023 14:11:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=pBT4wytw7MLAMNHVrnHkhg1/DpY7chr/krk0LZCll9I=;
 b=VuVIlMDfbWsvVGqxlFzjRjWqrxtOnCgE7r6eDr99vXIP+W5p4PD0GPJF9nC625HMBvIAG2
 9hlRQCXW4qycZOLPKq7X7PW3yJDGQr3xhY4B2i5XgLxM7lYrMmNgs7ARXBQWZSfTOlWi+0wb
 1VP9c8hHMeEIrajSBDA5zs/lNsCe0=;
Message-ID: <ecada31f7d6376ed073cb485bd21457e1358d357.camel@siemens.com>
Subject: dovetail: IO-APIC IRQ storm
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: rpm@xenomai.org
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 10 Jul 2023 14:11:41 +0200
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

it seems I'm facing a problem with dovetail on x86 related to IRQs
routed through the IO-APIC.

Note the=C2=A0stack trace below, it seems that once we ACK the IRQ in
ioapic_ack_level() by calling __ack_APIC_irq() we immediately get the
next IRQ.

cat /proc/interrupts delivers (minimized to the relevant IRQ):

          CPU0       CPU1       CPU2       CPU3
21:          0       2392          0          0   IO-APIC     21 -fasteoi  =
 ahci[0000:00:0d.0], snd_intel8x0

Seems IRQ masking does not work as expected. I have to add more
debugging code but it looks like an IRQ storm for now. I have the
following options in mind right now, but there might be more:

- Masking of the AHCI IRQ does not work as expected
- HW IRQs are ON where they should be OFF

I'm using a VirtualBox based environment for reproducing this issue.
KVM or qemu based setups are normally not affected. There is no level
triggered IRQ that is routed through IO-APIC.

The following stack trace was triggered by calling stress-ng with the
--iomix parameter. The --iomix stressor is the root cause. Handling the
AHCI controller IRQs causes the kernel splat after some time.

[  250.001238] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  250.006135] rcu:     1-...0: (0 ticks this GP) idle=3D5d2c/1/0x400000000=
0000000 softirq=3D13252/13252 fqs=3D41
[  250.014785]  (detected by 3, t=3D5267 jiffies, g=3D4317, q=3D58979 ncpus=
=3D4)
[  250.018606] Sending NMI from CPU 3 to CPUs 1:
[  250.021755] NMI backtrace for cpu 1
[  250.021759] CPU: 1 PID: 732 Comm: stress-ng-vm Not tainted 6.1.34-xenoma=
i-1 #1
[  250.021764] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS Virt=
ualBox 12/01/2006
[  250.021765] IRQ stage: Xenomai
[  250.021767] RIP: 0010:native_apic_mem_write+0x8/0x10
[  250.021775] Code: 9b 00 0f 1f 44 00 00 be 01 00 00 00 e9 e1 07 0b 00 90 =
0f 1f 44 00 00 b8 01 00 00 00 c3 cc cc cc cc cc 89 ff 89 b7 00 d0 5f ff <c3=
> cc cc cc cc 0f 1f 00 89 ff 8b 87 00 d0 5f ff c3 cc cc cc cc 0f
[  250.021777] RSP: 0000:ffffb401400e0db8 EFLAGS: 00010046
[  250.021780] RAX: ffffffff91a5cdf0 RBX: ffff8a6e82901428 RCX: 00000000000=
00000
[  250.021783] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000000=
000b0
[  250.021784] RBP: ffff8a6eaf5b7d80 R08: 0000000000000000 R09: 00000000000=
00000
[  250.021786] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00004
[  250.021787] R13: 0000000000000022 R14: ffff8a6efdcd0210 R15: ffff8a6e829=
01400
[  250.021789] FS:  00007f7808535740(0000) GS:ffff8a6efdc80000(0000) knlGS:=
0000000000000000
[  250.021792] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  250.021794] CR2: 00007f78085356b8 CR3: 0000000004190002 CR4: 00000000000=
306e0
[  250.021796] Call Trace:
[  250.021798]  <NMI>
[  250.021802]  ? nmi_cpu_backtrace.cold+0x1b/0x91
[  250.021808]  ? native_apic_mem_write+0x8/0x10
[  250.021811]  ? nmi_cpu_backtrace_handler+0xd/0x20
[  250.021813]  ? nmi_handle+0x62/0x130
[  250.021817]  ? native_apic_mem_write+0x8/0x10
[  250.021820]  ? default_do_nmi+0x69/0x170
[  250.021823]  ? exc_nmi+0x119/0x150
[  250.021826]  ? end_repeat_nmi+0x16/0x67
[  250.021829]  ? arch_restore_msi_irqs+0x10/0x10
[  250.021834]  ? native_apic_mem_write+0x8/0x10
[  250.021836]  ? native_apic_mem_write+0x8/0x10
[  250.021839]  ? native_apic_mem_write+0x8/0x10
[  250.021841]  </NMI>
[  250.021842]  <IRQ>
[  250.021843]  ioapic_ack_level+0x91/0xc0
[  250.021846]  handle_fasteoi_irq+0x90/0x280
[  250.021851]  generic_pipeline_irq_desc+0xb0/0x160
[  250.021856]  arch_handle_irq+0x5d/0x1e0
[  250.021860]  arch_pipeline_entry+0x3b/0x110
[  250.021864]  asm_common_interrupt+0x22/0x40
[  250.021867] RIP: 0010:iowrite32+0x1e/0x60
[  250.021871] Code: cc cc cc 66 0f 1f 84 00 00 00 00 00 48 81 fe ff ff 03 =
00 76 07 89 3e c3 cc cc cc cc 48 81 fe 00 00 01 00 76 0a 89 f8 89 f2 ef <c3=
> cc cc cc cc 8b 05 17 0e e6 01 85 c0 75 05 c3 cc cc cc cc 83 e8
[  250.021873] RSP: 0000:ffffb401400e0f30 EFLAGS: 00010206
[  250.021875] RAX: 0000000000000100 RBX: ffff8a6e84404900 RCX: 00000000000=
00000
[  250.021876] RDX: 000000000001d230 RSI: 000000000001d230 RDI: 00000000000=
00100
[  250.021878] RBP: 0000000000000000 R08: ffff8a6e814017a0 R09: ffffffff93c=
cf5e0
[  250.021879] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[  250.021881] R13: 0000000000000100 R14: ffff8a6e82901400 R15: ffff8a6e840=
3e928
[  250.021888]  snd_intel8x0_interrupt+0x1f9/0x260 [snd_intel8x0]
[  250.021898]  __handle_irq_event_percpu+0x4e/0x180
[  250.021903]  handle_irq_event+0x46/0xc0
[  250.021906]  handle_fasteoi_irq+0x119/0x280
[  250.021909]  arch_do_IRQ_pipelined+0x136/0x770
[  250.021912]  </IRQ>
[  250.021913]  <TASK>
[  250.021915]  sync_current_irq_stage+0x1b5/0x260
[  250.021919]  handle_irq_pipelined_finish+0x9f/0x190
[  250.021923]  arch_pipeline_entry+0xd6/0x110
[  250.021926]  asm_common_interrupt+0x22/0x40
[  250.021928] RIP: 0033:0x5595ca6bdbb4
[  250.021931] Code: Unable to access opcode bytes at 0x5595ca6bdb8a.
[  250.021932] RSP: 002b:00007ffcbc3f74d0 EFLAGS: 00010202
[  250.021934] RAX: 000000000000003f RBX: 0000000002000000 RCX: 00000000000=
00006
[  250.021935] RDX: 00007f78077e814c RSI: 0000000042856595 RDI: c40021cdadb=
0a14c
[  250.021937] RBP: 00007f7805cde000 R08: ffffffffffffffff R09: 8f000000001=
7116d
[  250.021938] R10: 0000000000000040 R11: 8f0000000017116d R12: 00007ffcbc3=
f76e0
[  250.021939] R13: 00000000430e4299 R14: 0000000000000001 R15: 00000000000=
00000
[  250.021943]  </TASK>

Any ideas, thoughts? Would love to hear them!

Best regards,
Florian

