Message-ID: <528290CE.1030002@xenomai.org>
Date: Tue, 12 Nov 2013 21:34:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] issues with debugging enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Hi,

for a change, I ran the xeno-regression-test with a lot of debugging and
options known to having caused problems in the past and found two issues:

on x86 SMP, with full dynticks and debugging enabled (preemptible kernel
debugging, mutex, spinlocks, and sleep inside spinlocks), I get the
series of warnings at the end of the mail.

on ARM, when a fault occurs, the fault ode is entered with hardware irqs
off (this is a recent change in the mainline kernel, this code used to
be executed with hardware irqs on), so I do:

ipipe_stall_root();
hard_local_irq_enabled();

But the context checking does not like that.

Any idea how to fix these?


------------[ cut here ]------------
WARNING: at kernel/rcutree.c:388 rcu_eqs_enter+0x4e/0x8d()
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.10.18 #3
Hardware name:  /, BIOS
 ffffffff8157e76d ffff88007ed13e78 ffffffff813f7730 ffff88007ed13eb8
 ffffffff8102c006 0000000000000184 0000000000000000 ffff88007f30d580
 ffff88007ed13f00 0000000000000000 0000000000000000 ffff88007ed13ec8
Call Trace:
 [<ffffffff813f7730>] dump_stack+0x19/0x1b
 [<ffffffff8102c006>] warn_slowpath_common+0x68/0x81
 [<ffffffff8102c039>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff81078f1c>] rcu_eqs_enter+0x4e/0x8d
 [<ffffffff81078f76>] rcu_idle_enter+0x1b/0x27
 [<ffffffff8105db0e>] cpu_startup_entry+0xcb/0x151
 [<ffffffff816d4766>] start_secondary+0x1a0/0x1a4
---[ end trace d49a723e441bc5a7 ]---
------------[ cut here ]------------
WARNING: at kernel/rcutree.c:363 rcu_eqs_enter_common.isra.42+0xc0/0xd3()
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W    3.10.18 #3
Hardware name:  /, BIOS
 ffffffff8157e76d ffff88007ed13e38 ffffffff813f7730 ffff88007ed13e78
 ffffffff8102c006 000000000000016b 0000000000000000 ffff88007ecf37d0
 ffff88007f30d580 0000000000000000 0000000000000000 ffff88007ed13e88
Call Trace:
 [<ffffffff813f7730>] dump_stack+0x19/0x1b
 [<ffffffff8102c006>] warn_slowpath_common+0x68/0x81
 [<ffffffff8102c039>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff81078ebb>] rcu_eqs_enter_common.isra.42+0xc0/0xd3
 [<ffffffff81078e00>] ? rcu_eqs_enter_common.isra.42+0x5/0xd3
 [<ffffffff81078f56>] rcu_eqs_enter+0x88/0x8d
 [<ffffffff81078f76>] rcu_idle_enter+0x1b/0x27
 [<ffffffff8105db0e>] cpu_startup_entry+0xcb/0x151
 [<ffffffff816d4766>] start_secondary+0x1a0/0x1a4
---[ end trace d49a723e441bc5a8 ]---
------------[ cut here ]------------
WARNING: at kernel/rcutree.c:480 rcu_irq_exit+0x49/0x70()
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W    3.10.18 #3
Hardware name:  /, BIOS
 ffffffff8157e76d ffff88007ed13e08 ffffffff813f7730 ffff88007ed13e48
 ffffffff8102c006 00000000000001e0 0000000000000000 ffff88007f30d580
 0000000000000000 0000000000001142 0000000000000000 ffff88007ed13e58
Call Trace:
 [<ffffffff813f7730>] dump_stack+0x19/0x1b
 [<ffffffff8102c006>] warn_slowpath_common+0x68/0x81
 [<ffffffff8102c039>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff81079f06>] rcu_irq_exit+0x49/0x70
 [<ffffffff81032c63>] irq_exit+0xb2/0xb6
 [<ffffffff8107e316>] __ipipe_do_sync_stage+0x11e/0x16c
 [<ffffffff8101c3f8>] __ipipe_halt_root+0x23/0x38
 [<ffffffff81009383>] default_idle+0x1f/0x30
 [<ffffffff81009a74>] arch_cpu_idle+0xf/0x11
 [<ffffffff8105db13>] cpu_startup_entry+0xd0/0x151
 [<ffffffff816d4766>] start_secondary+0x1a0/0x1a4
---[ end trace d49a723e441bc5a9 ]---
------------[ cut here ]------------
WARNING: at kernel/rcutree.c:528 rcu_eqs_exit+0x4b/0x91()
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W    3.10.18 #3
Hardware name:  /, BIOS
 ffffffff8157e76d ffff88007ed13e68 ffffffff813f7730 ffff88007ed13ea8
 ffffffff8102c006 0000000000000210 0000000000000000 ffff88007f30d580
 ff00000000000000 0000000000000000 0000000000000000 ffff88007ed13eb8
Call Trace:
 [<ffffffff813f7730>] dump_stack+0x19/0x1b
 [<ffffffff8102c006>] warn_slowpath_common+0x68/0x81
 [<ffffffff8102c039>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff81078d8d>] rcu_eqs_exit+0x4b/0x91
 [<ffffffff81078dee>] rcu_idle_exit+0x1b/0x28
 [<ffffffff8105db62>] cpu_startup_entry+0x11f/0x151
 [<ffffffff816d4766>] start_secondary+0x1a0/0x1a4
---[ end trace d49a723e441bc5aa ]---
------------[ cut here ]------------
WARNING: at kernel/rcutree.c:502 rcu_eqs_exit_common.isra.40+0x41/0xce()
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W    3.10.18 #3
Hardware name:  /, BIOS
 ffffffff8157e76d ffff88007ed13e38 ffffffff813f7730 ffff88007ed13e78
 ffffffff8102c006 00000000000001f6 0000000000000000 ffff88007f30d580
 0000000000000000 0000000000000000 0000000000000000 ffff88007ed13e88
Call Trace:
 [<ffffffff813f7730>] dump_stack+0x19/0x1b
 [<ffffffff8102c006>] warn_slowpath_common+0x68/0x81
 [<ffffffff8102c039>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff81078cb5>] rcu_eqs_exit_common.isra.40+0x41/0xce
 [<ffffffff81078dcb>] rcu_eqs_exit+0x89/0x91
 [<ffffffff81078dee>] rcu_idle_exit+0x1b/0x28
 [<ffffffff8105db62>] cpu_startup_entry+0x11f/0x151
 [<ffffffff816d4766>] start_secondary+0x1a0/0x1a4
---[ end trace d49a723e441bc5ab ]---
WARNING: at kernel/rcutree.c:388 rcu_eqs_enter+0x4e/0x8d()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W    3.10.18 #3
Hardware name:  /, BIOS
 ffffffff8157e76d ffffffff81603e98 ffffffff813f7730 ffffffff81603ed8
 ffffffff8102c006 0000000000000184 0000000000000000 ffff88007f20d580
 ffffffff81603f00 ffffffff817230a0 ffff88007f64be80 ffffffff81603ee8
Call Trace:
 [<ffffffff813f7730>] dump_stack+0x19/0x1b
 [<ffffffff8102c006>] warn_slowpath_common+0x68/0x81
 [<ffffffff8102c039>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff81078f1c>] rcu_eqs_enter+0x4e/0x8d
 [<ffffffff81078f76>] rcu_idle_enter+0x1b/0x27
 [<ffffffff8105db0e>] cpu_startup_entry+0xcb/0x151
 [<ffffffff813f123c>] rest_init+0x80/0x84
 [<ffffffff8169ec65>] start_kernel+0x322/0x330
 [<ffffffff8169e749>] ? repair_env_string+0x5a/0x5a
 [<ffffffff8169e481>] x86_64_start_reservations+0x2a/0x2c
 [<ffffffff8169e54b>] x86_64_start_kernel+0xc8/0xcc
---[ end trace d49a723e441bc5ac ]---
WARNING: at kernel/context_tracking.c:54 user_enter+0x5f/0xb2()
Modules linked in:
CPU: 1 PID: 356 Comm: kworker/1:1 Tainted: G        W    3.10.18 #3
Hardware name:  /, BIOS
Workqueue: events cache_reap
 ffffffff815818be ffff88007cb3bc68 ffffffff813f7730 ffff88007cb3bca8
 ffffffff8102c006 0000000000000036 0000000000000000 0000000000000000
 0000000000000287 ffffffff817bbe80 0000000000000000 ffff88007cb3bcb8
Call Trace:
 [<ffffffff813f7730>] dump_stack+0x19/0x1b
 [<ffffffff8102c006>] warn_slowpath_common+0x68/0x81
 [<ffffffff8102c039>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff810a0a0d>] user_enter+0x5f/0xb2
 [<ffffffff813fad64>] preempt_schedule_irq+0x6c/0x71
 [<ffffffff813fb1e9>] __ipipe_preempt_schedule_irq+0x38/0x78
 [<ffffffff813fbef5>] retint_kernel+0x35/0x40
 [<ffffffff81213b4f>] ? debug_smp_processor_id+0x97/0x198
 [<ffffffff81118580>] cache_reap+0x3e/0x110
 [<ffffffff81045355>] process_one_work+0x188/0x29c
 [<ffffffff8104583a>] worker_thread+0x133/0x200
 [<ffffffff81045707>] ? rescuer_thread+0x26f/0x26f
 [<ffffffff8104a380>] kthread+0xa0/0xa8
 [<ffffffff8104a2e0>] ? __kthread_parkme+0x65/0x65
 [<ffffffff813fc6ad>] ret_from_fork+0x7d/0xb0
 [<ffffffff8104a2e0>] ? __kthread_parkme+0x65/0x65
---[ end trace d49a723e441bc5ad ]---


-- 
                                                                Gilles.

