Date: Mon, 07 Jul 2008 17:45:11 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200807071745.31720@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Kernel panic: not syncing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,
I'm not sure if I'm not off topic.
We use Linux 2.6.24 and Xenomai 2.4.1. Occasionally (once in few days) we get an kernel panic and I don't know If it's our fault or a problem of kernel/xenomai/adeos/configuration/hw/...
If you have any questions, i'll try to answer them. Any help is welcome.
Petr Cervenka

I will try to reproduce the log (visible part of it). I can mail you snapshots for details, if needed:
---------------------------------------------------------------
<IRQ> profile_tick+0x5e/0xa0
tick_sched_timer+0x85/0x170
hrtimer_interrupt+0x12f/0x1e0
smp_apic_timer_interrupt+0x37/0x60
__ipipe_sync_stage+0x350/0x355
smp_apic_timer_interrupt+0x0/0x60
__xirq_end+0x0/0x85
smp_apic_timer_interrupt+0x0/0x60
__ipipe_handle_irq+0x91/0x250
default_idle+0x0/0x40
common_interrupt+0x61/0x7d
<EOI> default_idle+0x29/0x40
cpu_idle+0x8b/0x120
start_kernel+0x2ba/0x350
_sinittext+0x120/0x130

Code: 48 8b 11 48 89 d0 48 c1 e8 16 48 85 c0 75 1b 48 8b 51 08 48

RIP profile_pc+0x46/0x80
RSP <ffffffff80664da0>
CR2: 0000000040090fb8
---[ end trace ccd2184e479f15c8 ]---
Kernel panic - not syncing: Aiee, killing interrupt handler!

Another one is similar, with following differencies:
----------------------------------------------------------------------
<IRQ> scheduler_tick+0xf8/0x140
... /* same part as before */
smp_apic_timer_interrupt+0x0/0x60
ipipe_suspend_domain+0xb2/0xf0
__ipipe_walk_pipeline+0xee/0x150
__ipipe_handle_irq+0x81/0x250
common_interrupt+0x61/0x7d
<EOI>

Code: 0f 0b eb fe 66 66 66 2e 0f 1f 84 00 00 00 00 00 41 57 41 56

RIP run_posix_cpu_timers+0x810/0x280
...


