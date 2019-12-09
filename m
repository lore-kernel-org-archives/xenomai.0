MIME-Version: 1.0
References: <CAOf5uw=i62dBaP1KidqJ09RFYz7hwPDj4e9cCwvNQzq9h61n5A@mail.gmail.com>
In-Reply-To: <CAOf5uw=i62dBaP1KidqJ09RFYz7hwPDj4e9cCwvNQzq9h61n5A@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 10 Dec 2019 00:42:50 +0100
Message-ID: <CAFLxGvz9X3qtz-tK6egDLuNn2OB6iYuy__-th=61mAbHynV+qg@mail.gmail.com>
Subject: Lockdep splat around rq->lock (Was: Re: [Xenomai] am335x xenomai)
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: xenomai@xenomai.org

On Fri, Sep 7, 2018 at 5:54 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi all
>
> I have this:
>
>     0.451161]
> [    0.451180] =================================
> [    0.451188] [ INFO: inconsistent lock state ]
> [    0.451201] 4.1.6-ipipe #1 Not tainted
> [    0.451208] ---------------------------------
> [    0.451217] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [    0.451228] irq/156-44e0b00/21 [HC0[0]:SC0[0]:HE1:SE1] takes:
> [    0.451238]  (std_spinlock_raw(&rq->lock)){?.-...}, at:
> [<c063a23c>] __schedule+0xc0/0x9a0
> [    0.451285] {IN-HARDIRQ-W} state was registered at:
> [    0.451294]   [<c063fca4>] _raw_spin_lock+0x34/0x44
> [    0.451314]   [<c006b85c>] scheduler_tick+0x2c/0xb4
> [    0.451337]   [<c00acf54>] update_process_times+0x58/0x64
> [    0.451363]   [<c00bc0b8>] tick_periodic+0x38/0xf8
> [    0.451377]   [<c00bc34c>] tick_handle_periodic+0x1c/0x7c
> [    0.451390]   [<c0027b14>] omap2_gp_timer_interrupt+0x38/0x48
> [    0.451409]   [<c009ace4>] handle_irq_event_percpu+0x74/0x2b4
> [    0.451426]   [<c009af60>] handle_irq_event+0x3c/0x5c
> [    0.451438]   [<c009e368>] handle_level_irq+0xa0/0x118
> [    0.451455]   [<c009a328>] generic_handle_irq+0x28/0x3c
> [    0.451467]   [<c009a628>] __handle_domain_irq+0x74/0xfc
> [    0.451479]   [<c00e3384>] __ipipe_do_sync_stage+0x2cc/0x314
> [    0.451504]   [<c0009408>] __ipipe_grab_irq+0x5c/0x7c
> [    0.451518]   [<c0009704>] omap_intc_handle_irq+0xb8/0xc8
> [    0.451530]   [<dfdff480>] 0xdfdff480
> [    0.451543]   [<c0640a64>] __irq_svc+0x44/0x70
> [    0.451559]   [<c000a3bc>] calibrate_delay+0x390/0x594
> [    0.451572]   [<c000a3bc>] calibrate_delay+0x390/0x594
> [    0.451584]   [<c08c7be4>] start_kernel+0x320/0x3e8
> [    0.451605]   [<8000807c>] 0x8000807c
> [    0.451617] irq event stamp: 40
> [    0.451625] hardirqs last  enabled at (39): [<c063ffec>]
> _raw_spin_unlock_irqrestore+0x68/0x70
> [    0.451640] hardirqs last disabled at (40): [<c063fe14>]
> _raw_spin_lock_irq+0x18/0x4c
> [    0.451653] softirqs last  enabled at (0): [<c0040f88>]
> copy_process.part.7+0x3d8/0x170c
> [    0.451678] softirqs last disabled at (0): [<  (null)>]   (null)
> [    0.451689]
> [    0.451689] other info that might help us debug this:
> [    0.451699]  Possible unsafe locking scenario:
> [    0.451699]
> [    0.451707]        CPU0
> [    0.451713]        ----
> [    0.451720]   lock(std_spinlock_raw(&rq->lock));
> [    0.451733]   <Interrupt>
> [    0.451739]     lock(std_spinlock_raw(&rq->lock));
> [    0.451752]
> [    0.451752]  *** DEADLOCK ***
> [    0.451752]
> [    0.451764] 1 lock held by irq/156-44e0b00/21:
> [    0.451771]  #0:  (std_spinlock_raw(&rq->lock)){?.-...}, at:
> [<c063a23c>] __schedule+0xc0/0x9a0
> [    0.451799]
> [    0.451799] stack backtrace:
> [    0.451814] CPU: 0 PID: 21 Comm: irq/156-44e0b00 Not tainted 4.1.6-ipipe #1
> [    0.451822] Hardware name: Generic AM33XX (Flattened Device Tree)
> [    0.451849] [<c0017410>] (unwind_backtrace) from [<c00136e4>]
> (show_stack+0x10/0x14)
> [    0.451864] [<c00136e4>] (show_stack) from [<c0638938>]
> (dump_stack+0x80/0xc8)
> [    0.451883] [<c0638938>] (dump_stack) from [<c008c568>]
> (print_usage_bug+0x1d8/0x2cc)
> [    0.451897] [<c008c568>] (print_usage_bug) from [<c008cbdc>]
> (mark_lock+0x580/0x6c8)
> [    0.451910] [<c008cbdc>] (mark_lock) from [<c008cd8c>]
> (mark_held_locks+0x68/0x98)
> [    0.451924] [<c008cd8c>] (mark_held_locks) from [<c008ce28>]
> (trace_hardirqs_on_caller+0x6c/0x1f4)
> [    0.451939] [<c008ce28>] (trace_hardirqs_on_caller) from
> [<c0640a94>] (__ipipe_fast_svc_irq_exit+0x4/0x18)
> [    0.451957] [<c0640a94>] (__ipipe_fast_svc_irq_exit) from
> [<c007354c>] (set_next_entity+0x444/0x53c)
> [    0.451973] [<c007354c>] (set_next_entity) from [<c007b6b0>]
> (pick_next_task_fair+0x70/0x66c)
> [    0.451988] [<c007b6b0>] (pick_next_task_fair) from [<c063a684>]
> (__schedule+0x508/0x9a0)
> [    0.452001] [<c063a684>] (__schedule) from [<c063ab5c>] (schedule+0x40/0xa0)
> [    0.452015] [<c063ab5c>] (schedule) from [<c009bcd4>] (irq_thread+0xb8/0x19c)
> [    0.452031] [<c009bcd4>] (irq_thread) from [<c005f788>] (kthread+0xd4/0xf0)
> [    0.452050] [<c005f788>] (kthread) from [<c000fa54>]
> (ret_from_fork+0x18/0x24)
>
> Is ipipe compatible with lockdep?
>
> [    0.000000] Linux version 4.1.6-ipipe (michael@panicking) (gcc
> version 5.5.0 (Buildroot 2018.08-rc3-00031-g2a424a7) ) #1 SMP PREEMPT
> Fri Sep 7 15:26:52 CEST 2018
> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache

Sorry for unearthing this old mail but I'm facing the same issue.
I'm on ipipe-core-4.14.110-arm-7 plus xenomai 3.0.9.

As soon I enable lockdep it complains when a kprobe to Linux's sched_switch()
is attached. My probe is a no-op btw.

[  108.147330] ================================
[  108.147659] WARNING: inconsistent lock state
[  108.147990] 4.14.111 #1 Tainted: G           O
[  108.148516] --------------------------------
[  108.148986] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[  108.149397] init/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  108.149740]  (std_spinlock_raw(&rq->lock)){?.-.}, at: [<c09c294c>]
__schedule+0x84/0x7dc
[  108.150366] {IN-HARDIRQ-W} state was registered at:
[  108.150711]   _raw_spin_lock+0x4c/0x84
[  108.150999]   scheduler_tick+0x3c/0xb4
[  108.151298]   update_process_times+0x6c/0x84
[  108.151613]   tick_handle_periodic+0x24/0x98
[  108.151935]   twd_handler+0x38/0x44
[  108.152301]   handle_percpu_devid_irq+0x158/0x30c
[  108.152654]   generic_handle_irq+0x18/0x28
[  108.153071]   __handle_domain_irq+0xb4/0xcc
[  108.153394]   __ipipe_do_sync_stage+0x23c/0x270
[  108.153728]   ipipe_unstall_root+0x38/0x48
[  108.154042]   _raw_spin_lock+0x4c/0x84
[  108.154333]   inode_sb_list_add+0x14/0x48
[  108.154726]   new_inode+0x18/0x20
[  108.155014]   ramfs_get_inode+0x14/0x11c
[  108.155325]   ramfs_fill_super+0xb8/0x134
[  108.155645]   mount_nodev+0x3c/0x84
[  108.155938]   mount_fs+0x10/0x98
[  108.156204]   vfs_kern_mount+0x54/0x128
[  108.156510]   mnt_init+0x11c/0x204
[  108.156798]   vfs_caches_init+0x54/0x70
[  108.157111]   start_kernel+0x330/0x3bc
[  108.157404]   0x1000807c
[  108.157754] irq event stamp: 225492
[  108.158160] hardirqs last  enabled at (225491): [<c09c8b9c>]
_raw_spin_unlock_irqrestore+0x50/0x58
[  108.158837] hardirqs last disabled at (225492): [<c09c2934>]
__schedule+0x6c/0x7dc
[  108.159311] softirqs last  enabled at (224408): [<c010187c>]
__do_softirq+0x164/0x478
[  108.159799] softirqs last disabled at (224401): [<c0127258>]
irq_exit+0x94/0x118
[  108.160259]
[  108.160259] other info that might help us debug this:
[  108.160901]  Possible unsafe locking scenario:
[  108.160901]
[  108.161305]        CPU0
[  108.161537]        ----
[  108.161766]   lock(std_spinlock_raw(&rq->lock));
[  108.162179]   <Interrupt>
[  108.162415]     lock(std_spinlock_raw(&rq->lock));
[  108.163066]
[  108.163066]  *** DEADLOCK ***
[  108.163066]
[  108.163501] 1 lock held by init/1:
[  108.163775]  #0:  (std_spinlock_raw(&rq->lock)){?.-.}, at:
[<c09c294c>] __schedule+0x84/0x7dc
[  108.164453]
[  108.164453] stack backtrace:
[  108.164955] CPU: 1 PID: 1 Comm: init Tainted: G           O    4.14.111 #1
[  108.165453] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  108.165882] I-pipe domain: Linux
[  108.166153] [<c0110000>] (unwind_backtrace) from [<c010b4f8>]
(show_stack+0x10/0x14)
[  108.166644] [<c010b4f8>] (show_stack) from [<c09af1e8>]
(dump_stack+0xc0/0xec)
[  108.167247] [<c09af1e8>] (dump_stack) from [<c0166cd0>]
(print_usage_bug+0x1c4/0x2cc)
[  108.167926] [<c0166cd0>] (print_usage_bug) from [<c0163964>]
(mark_lock+0x430/0x684)
[  108.168666] [<c0163964>] (mark_lock) from [<c0163c18>]
(mark_held_locks+0x60/0x6c)
[  108.169164] [<c0163c18>] (mark_held_locks) from [<c0163db4>]
(trace_hardirqs_on_caller+0x190/0x21c)
[  108.169712] [<c0163db4>] (trace_hardirqs_on_caller) from
[<c010c214>] (__pabt_svc+0x74/0xa0)
[  108.170228] [<c010c214>] (__pabt_svc) from [<bf052ec0>]
(sched_switch_probe+0x0/0x4 [myprobe])
[  108.170781] [<bf052ec0>] (sched_switch_probe [myprobe]) from
[<c09c2ad8>] (__schedule+0x210/0x7dc)
[  108.171364] [<c09c2ad8>] (__schedule) from [<c09c3148>] (schedule+0xa4/0xdc)
[  108.171816] [<c09c3148>] (schedule) from [<c09c8388>]
(schedule_hrtimeout_range_clock+0xe4/0x130)
[  108.172627] [<c09c8388>] (schedule_hrtimeout_range_clock) from
[<c09c83ec>] (schedule_hrtimeout_range+0x18/0x20)
[  108.173249] [<c09c83ec>] (schedule_hrtimeout_range) from
[<c028ff38>] (poll_schedule_timeout+0x88/0xcc)
[  108.173828] [<c028ff38>] (poll_schedule_timeout) from [<c0290594>]
(do_select+0x294/0x5b4)
[  108.174336] [<c0290594>] (do_select) from [<c0291120>]
(core_sys_select+0x2c0/0x47c)
[  108.174810] [<c0291120>] (core_sys_select) from [<c02913a8>]
(SyS_select+0xcc/0x144)
[  108.175289] [<c02913a8>] (SyS_select) from [<c0107520>]
(ret_fast_syscall+0x0/0x28)

--
Thanks,
//richard

