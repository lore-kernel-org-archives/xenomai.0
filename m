Message-ID: <52F4F52F.2020901@siemens.com>
Date: Fri, 07 Feb 2014 16:01:03 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] forge: Panic with reduced supported_cpus mask
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

booting forge with a restricted CPU set cause a panic:

[    1.540121] Kernel panic - not syncing: bug at
/data/linux-ipipe/kernel/xenomai/timer.c:484
(!cpu_isset(xnsched_cpu(sched), xnsched_realtime_cpus))
[    1.541935] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.28+ #101
[    1.542907] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[    1.544150]  ffff88003dea1280 ffff88003fa5bc58 ffffffff8164deaf
ffff88003fa5bcd8
[    1.545361]  ffffffff8164da69 0000000000000020 ffff88003fa5bce8
ffff88003fa5bc88
[    1.546566]  ffffffff810d93ec ffff88003dea88c8 ffffffff81850b88
00000000000001e4
[    1.547779] Call Trace:
[    1.548420]  [<ffffffff8164deaf>] dump_stack+0x19/0x22
[    1.549220]  [<ffffffff8164da69>] panic+0xd9/0x1f0
[    1.549966]  [<ffffffff810d93ec>] ? __ipipe_restore_head+0x7c/0x100
[    1.550059]  [<ffffffff8112f748>] __xntimer_migrate+0x118/0x120
[    1.550059]  [<ffffffff81130c19>] xnsched_quota_init+0xc9/0x150
[    1.550059]  [<ffffffff81118dae>] xnsched_init+0x8e/0x280
[    1.550059]  [<ffffffff8111018b>] ? xnheap_set_label+0x15b/0x270
[    1.550059]  [<ffffffff81caf963>] xenomai_init+0x31b/0x6e4
[    1.550059]  [<ffffffff81caf648>] ? xnheap_mount+0x95/0x95
[    1.550059]  [<ffffffff81000272>] do_one_initcall+0x42/0x1a0
[    1.550059]  [<ffffffff81c8ef84>] kernel_init_freeable+0x142/0x1d7
[    1.550059]  [<ffffffff81c8e780>] ? loglevel+0x31/0x31
[    1.550059]  [<ffffffff8163bc10>] ? rest_init+0xa0/0xa0
[    1.550059]  [<ffffffff8163bc1e>] kernel_init+0xe/0xf0
[    1.550059]  [<ffffffff8165afad>] ret_from_fork+0x7d/0xb0
[    1.550059]  [<ffffffff8163bc10>] ? rest_init+0xa0/0xa0

When I look at the (presumed) causing commit 89c3ce894e, I see that you
changed sys_init (and sys_shutdown) to work against all CPUs, not only
the supported ones. However, creating a sched over an unsupported CPU
triggers that BUG_ON in __xntimer_migrate.

Why do we need scheds for all CPUs? Or was that conversion from
for_each_realtime_cpu to for_each_online_cpu done accidentally? Then the
bug is simple to fix, otherwise I need some hint.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

