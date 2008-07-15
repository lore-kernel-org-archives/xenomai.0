Message-ID: <487CBC4A.5050309@domain.hid>
Date: Tue, 15 Jul 2008 17:03:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: 0807071745.31720@domain.hid> <48723D5D.6020008@domain.hid>
	<48732793.7090605@domain.hid> <487331AE.5070009@domain.hid>
	<48733483.2050204@domain.hid> <200807091719.17625@domain.hid>
	<4874E1D8.6020307@domain.hid> <200807111518.16150@domain.hid>
	<200807151642.18829@domain.hid>
In-Reply-To: <200807151642.18829@domain.hid>
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel panic: not syncing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

Petr Cervenka wrote:
> I captured also the second type of kernel panic. This one seems to happen during "advanced" configuration of out system. This means lot of work in a low priority (5) xenomai task (WORK_TASK_2056) for a short time.
> Another question is, what does mean "(P)" after the name of our rtdm module (pci171x_rtdm(P))?

That it either does not comply to the GPL or that the author forgot to
announce its compliance via MODULE_LICENSE().

> 
> [ 7815.694296] ------------[ cut here ]------------
> [ 7815.699111] kernel BUG at kernel/posix-cpu-timers.c:1295!
> [ 7815.704715] invalid opcode: 0000 [1] PREEMPT SMP 
> [ 7815.709672] CPU 0 
> [ 7815.711777] Modules linked in: rt_e1000 rt_r8169 rtpacket rtnet ppdev pci171x_rtdm(P) container ac video output sbs sbshc dock battery parport_pc lp parport psmouse serio_raw pcspkr k8temp i2c_nforce2 button i2c_core af_packet ipv6 evdev ext3 jbd mbcache sg sd_mod ide_cd cdrom sata_nv floppy ata_generic libata ohci_hcd forcedeth ehci_hcd scsi_mod amd74xx ide_core usbcore fan fuse
> [ 7815.747844] Pid: 6481, comm: WORK_TASK_2056 Tainted: P        2.6.24-adeos #1
> [ 7815.755321] RIP: 0010:[<ffffffff80256e20>]  [<ffffffff80256e20>] run_posix_cpu_timers+0x810/0x820
> [ 7815.764629] RSP: 0000:ffffffff80664d70  EFLAGS: 00010246
> [ 7815.770122] RAX: ffff81000100a7c0 RBX: ffff81003e082780 RCX: ffffffff805a03a0
> [ 7815.777573] RDX: 0000000000000000 RSI: ffff81003e082780 RDI: ffff81003e082780
> [ 7815.785080] RBP: ffff8100010087a0 R08: 0000000000000004 R09: 0000000000000010
> [ 7815.792566] R10: 0000000000000005 R11: ffffffff80258ee0 R12: ffff81000100a5c0
> [ 7815.800001] R13: 00000719439890f1 R14: 0000000000000000 R15: ffffffff80664d90
> [ 7815.807436] FS:  0000000040112950(0063) GS:ffffffff805d6000(0000) knlGS:0000000000000000
> [ 7815.815909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7815.821915] CR2: 00002b83d55aec80 CR3: 000000003dff8000 CR4: 00000000000006e0
> [ 7815.829357] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 7815.836786] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [ 7815.844238] Process WORK_TASK_2056 (pid: 6481, threadinfo ffff810013f78000, task ffff81003e082780)
> [ 7815.853584] Stack:  ffff810001013180 00000718f7bcb1dd ffffffff80664db0 ffffffff80238af8
> [ 7815.862131]  ffffffff80664d90 ffffffff80664d90 00000719439890f1 ffff81000100a6c0
> [ 7815.869974]  ffff8100010087a0 ffff81000100a5c0 00000719439890f1 0000000000000000
> [ 7815.877667] Call Trace:
> [ 7815.880441]  <IRQ>  [<ffffffff80238af8>] scheduler_tick+0xf8/0x140
> [ 7815.886908]  [<ffffffff8025e89b>] tick_sched_timer+0x7b/0x170
> [ 7815.892929]  [<ffffffff8025900f>] hrtimer_interrupt+0x12f/0x1e0
> [ 7815.899137]  [<ffffffff80220857>] smp_apic_timer_interrupt+0x37/0x60
> [ 7815.905752]  [<ffffffff8020c9f1>] common_interrupt+0x61/0x7d
> [ 7815.911779]  [<ffffffff802777e0>] __ipipe_sync_stage+0x350/0x355
> [ 7815.918085]  [<ffffffff80220820>] smp_apic_timer_interrupt+0x0/0x60
> [ 7815.924655]  [<ffffffff802777e5>] __xirq_end+0x0/0x85
> [ 7815.929964]  [<ffffffff80220820>] smp_apic_timer_interrupt+0x0/0x60
> [ 7815.936587]  [<ffffffff80226b01>] __ipipe_handle_irq+0x91/0x250
> [ 7815.942774]  [<ffffffff8020c9f1>] common_interrupt+0x61/0x7d
> [ 7815.948673]  <EOI> 
> [ 7815.950909] 
> [ 7815.950909] Code: 0f 0b eb fe 66 66 66 2e 0f 1f 84 00 00 00 00 00 41 57 41 56 
> [ 7815.960491] RIP  [<ffffffff80256e20>] run_posix_cpu_timers+0x810/0x820
> [ 7815.967284]  RSP <ffffffff80664d70>
> [ 7815.970982] ---[ end trace d192885d9858c4b2 ]---
> [ 7815.975820] Kernel panic - not syncing: Aiee, killing interrupt handler! 

That's now a totally different spot, and it makes me wonder if can
reproduce all this troubles with vanilla Xenomai and without your driver
being loaded...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

