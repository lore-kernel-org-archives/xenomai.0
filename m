MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 7 Sep 2018 17:54:26 +0200
Message-ID: <CAOf5uw=i62dBaP1KidqJ09RFYz7hwPDj4e9cCwvNQzq9h61n5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] am335x xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all

I have this:

    0.451161]
[    0.451180] =================================
[    0.451188] [ INFO: inconsistent lock state ]
[    0.451201] 4.1.6-ipipe #1 Not tainted
[    0.451208] ---------------------------------
[    0.451217] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[    0.451228] irq/156-44e0b00/21 [HC0[0]:SC0[0]:HE1:SE1] takes:
[    0.451238]  (std_spinlock_raw(&rq->lock)){?.-...}, at:
[<c063a23c>] __schedule+0xc0/0x9a0
[    0.451285] {IN-HARDIRQ-W} state was registered at:
[    0.451294]   [<c063fca4>] _raw_spin_lock+0x34/0x44
[    0.451314]   [<c006b85c>] scheduler_tick+0x2c/0xb4
[    0.451337]   [<c00acf54>] update_process_times+0x58/0x64
[    0.451363]   [<c00bc0b8>] tick_periodic+0x38/0xf8
[    0.451377]   [<c00bc34c>] tick_handle_periodic+0x1c/0x7c
[    0.451390]   [<c0027b14>] omap2_gp_timer_interrupt+0x38/0x48
[    0.451409]   [<c009ace4>] handle_irq_event_percpu+0x74/0x2b4
[    0.451426]   [<c009af60>] handle_irq_event+0x3c/0x5c
[    0.451438]   [<c009e368>] handle_level_irq+0xa0/0x118
[    0.451455]   [<c009a328>] generic_handle_irq+0x28/0x3c
[    0.451467]   [<c009a628>] __handle_domain_irq+0x74/0xfc
[    0.451479]   [<c00e3384>] __ipipe_do_sync_stage+0x2cc/0x314
[    0.451504]   [<c0009408>] __ipipe_grab_irq+0x5c/0x7c
[    0.451518]   [<c0009704>] omap_intc_handle_irq+0xb8/0xc8
[    0.451530]   [<dfdff480>] 0xdfdff480
[    0.451543]   [<c0640a64>] __irq_svc+0x44/0x70
[    0.451559]   [<c000a3bc>] calibrate_delay+0x390/0x594
[    0.451572]   [<c000a3bc>] calibrate_delay+0x390/0x594
[    0.451584]   [<c08c7be4>] start_kernel+0x320/0x3e8
[    0.451605]   [<8000807c>] 0x8000807c
[    0.451617] irq event stamp: 40
[    0.451625] hardirqs last  enabled at (39): [<c063ffec>]
_raw_spin_unlock_irqrestore+0x68/0x70
[    0.451640] hardirqs last disabled at (40): [<c063fe14>]
_raw_spin_lock_irq+0x18/0x4c
[    0.451653] softirqs last  enabled at (0): [<c0040f88>]
copy_process.part.7+0x3d8/0x170c
[    0.451678] softirqs last disabled at (0): [<  (null)>]   (null)
[    0.451689]
[    0.451689] other info that might help us debug this:
[    0.451699]  Possible unsafe locking scenario:
[    0.451699]
[    0.451707]        CPU0
[    0.451713]        ----
[    0.451720]   lock(std_spinlock_raw(&rq->lock));
[    0.451733]   <Interrupt>
[    0.451739]     lock(std_spinlock_raw(&rq->lock));
[    0.451752]
[    0.451752]  *** DEADLOCK ***
[    0.451752]
[    0.451764] 1 lock held by irq/156-44e0b00/21:
[    0.451771]  #0:  (std_spinlock_raw(&rq->lock)){?.-...}, at:
[<c063a23c>] __schedule+0xc0/0x9a0
[    0.451799]
[    0.451799] stack backtrace:
[    0.451814] CPU: 0 PID: 21 Comm: irq/156-44e0b00 Not tainted 4.1.6-ipipe #1
[    0.451822] Hardware name: Generic AM33XX (Flattened Device Tree)
[    0.451849] [<c0017410>] (unwind_backtrace) from [<c00136e4>]
(show_stack+0x10/0x14)
[    0.451864] [<c00136e4>] (show_stack) from [<c0638938>]
(dump_stack+0x80/0xc8)
[    0.451883] [<c0638938>] (dump_stack) from [<c008c568>]
(print_usage_bug+0x1d8/0x2cc)
[    0.451897] [<c008c568>] (print_usage_bug) from [<c008cbdc>]
(mark_lock+0x580/0x6c8)
[    0.451910] [<c008cbdc>] (mark_lock) from [<c008cd8c>]
(mark_held_locks+0x68/0x98)
[    0.451924] [<c008cd8c>] (mark_held_locks) from [<c008ce28>]
(trace_hardirqs_on_caller+0x6c/0x1f4)
[    0.451939] [<c008ce28>] (trace_hardirqs_on_caller) from
[<c0640a94>] (__ipipe_fast_svc_irq_exit+0x4/0x18)
[    0.451957] [<c0640a94>] (__ipipe_fast_svc_irq_exit) from
[<c007354c>] (set_next_entity+0x444/0x53c)
[    0.451973] [<c007354c>] (set_next_entity) from [<c007b6b0>]
(pick_next_task_fair+0x70/0x66c)
[    0.451988] [<c007b6b0>] (pick_next_task_fair) from [<c063a684>]
(__schedule+0x508/0x9a0)
[    0.452001] [<c063a684>] (__schedule) from [<c063ab5c>] (schedule+0x40/0xa0)
[    0.452015] [<c063ab5c>] (schedule) from [<c009bcd4>] (irq_thread+0xb8/0x19c)
[    0.452031] [<c009bcd4>] (irq_thread) from [<c005f788>] (kthread+0xd4/0xf0)
[    0.452050] [<c005f788>] (kthread) from [<c000fa54>]
(ret_from_fork+0x18/0x24)

Is ipipe compatible with lockdep?

[    0.000000] Linux version 4.1.6-ipipe (michael@panicking) (gcc
version 5.5.0 (Buildroot 2018.08-rc3-00031-g2a424a7) ) #1 SMP PREEMPT
Fri Sep 7 15:26:52 CEST 2018
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache

Michael

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |

