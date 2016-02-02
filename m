Date: Tue, 2 Feb 2016 21:02:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160202200235.GB29937@hermes.click-hack.org>
References: <20160202195355.GC27804@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160202195355.GC27804@deathstar>
Subject: Re: [Xenomai] IMX6 Quad inconsistent lock state
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Welling <mwelling@ieee.org>
Cc: xenomai@xenomai.org

On Tue, Feb 02, 2016 at 01:53:55PM -0600, Michael Welling wrote:
> I found the following message while booting the IMX6 Quad with a 3.18.20 based kernel.
> 
> [    0.229171]
> [    0.229186] =================================
> [    0.229195] [ INFO: inconsistent lock state ]
> [    0.229207] 3.18.20 #1 Not tainted
> [    0.229215] ---------------------------------
> [    0.229224] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [    0.229236] swapper/0/0 [HC0[0]:SC0[0]:HE1:SE1] takes:
> [    0.229246]  (std_spinlock_raw(&rq->lock)){?.-...}, at: [<8004adc8>] finish_task_switch+0x48/0x148
> [    0.229286] {IN-HARDIRQ-W} state was registered at:
> [    0.229295]   [<800654bc>] lock_acquire+0x88/0xa4
> [    0.229321]   [<8074ad50>] _raw_spin_lock+0x38/0x48
> [    0.229345]   [<8004e220>] scheduler_tick+0x3c/0xd4
> [    0.229364]   [<8007cba8>] update_process_times+0x5c/0x68
> [    0.229390]   [<8007cc10>] update_root_process_times+0x5c/0x60
> [    0.229406]   [<8008ac10>] tick_periodic+0x3c/0xf4
> [    0.229422]   [<8008aeb8>] tick_handle_periodic+0x30/0x90
> [    0.229436]   [<8001688c>] twd_handler+0x40/0x54
> [    0.229456]   [<80071cfc>] handle_percpu_devid_irq+0x6c/0xe8
> [    0.229480]   [<8006ea40>] generic_handle_irq+0x30/0x44
> [    0.229496]   [<8006ed70>] __handle_domain_irq+0x70/0xd4
> [    0.229510]   [<8000f9c8>] handle_IRQ+0x24/0x28
> [    0.229531]   [<8001bec8>] __ipipe_do_IRQ+0x2c/0x38
> [    0.229554]   [<800a132c>] __ipipe_do_sync_stage+0x2a0/0x2e8
> [    0.229579]   [<800a1490>] ipipe_unstall_root+0x48/0x58
> [    0.229594]   [<8074b034>] _raw_spin_unlock_irq+0x30/0x34
> [    0.229612]   [<8004ae10>] finish_task_switch+0x90/0x148
> [    0.229626]   [<80745e7c>] __schedule+0x204/0x5ec
> [    0.229641]   [<8074629c>] schedule+0x38/0x84
> [    0.229655]   [<8074a294>] schedule_timeout+0x128/0x180
> [    0.229671]   [<80746e2c>] wait_for_common+0xa0/0x15c
> [    0.229685]   [<80746f7c>] wait_for_completion_killable+0x18/0x30
> [    0.229700]   [<80046880>] kthread_create_on_node+0xec/0x19c
> [    0.229718]   [<800404c4>] create_worker+0xa0/0x170
> [    0.229741]   [<8004325c>] workqueue_cpu_up_callback+0x3e0/0x4ac
> [    0.229759]   [<800477f4>] notifier_call_chain+0x4c/0x8c
> [    0.229779]   [<80047910>] __raw_notifier_call_chain+0x1c/0x24
> [    0.229793]   [<8002ca98>] _cpu_up+0xbc/0x184
> [    0.229809]   [<8002cbd0>] cpu_up+0x70/0x9c
> [    0.229823]   [<809e9a1c>] smp_init+0xa4/0xb8
> [    0.229844]   [<809c5d84>] kernel_init_freeable+0x78/0x1d8
> [    0.229860]   [<8073f7e8>] kernel_init+0x10/0xf4
> [    0.229881]   [<8000f0c8>] ret_from_fork+0x18/0x30
> [    0.229899] irq event stamp: 2454
> [    0.229908] hardirqs last  enabled at (2453): [<8008dcf8>] tick_nohz_idle_exit+0x164/0x1fc
> [    0.229928] hardirqs last disabled at (2454): [<8074af20>] _raw_spin_lock_irq+0x20/0x54
> [    0.229944] softirqs last  enabled at (2448): [<8002f61c>] _local_bh_enable+0x2c/0x60
> [    0.229963] softirqs last disabled at (2447): [<8002ffdc>] irq_enter+0x64/0x84
> [    0.229981]
> [    0.229981] other info that might help us debug this:
> [    0.229992]  Possible unsafe locking scenario:
> [    0.229992]
> [    0.230001]        CPU0
> [    0.230009]        ----
> [    0.230015]   lock(std_spinlock_raw(&rq->lock));
> [    0.230031]   <Interrupt>
> [    0.230038]     lock(std_spinlock_raw(&rq->lock));
> [    0.230052]
> [    0.230052]  *** DEADLOCK ***
> [    0.230052]
> [    0.230066] 1 lock held by swapper/0/0:
> [    0.230073]  #0:  (std_spinlock_raw(&rq->lock)){?.-...}, at: [<8004adc8>] finish_task_switch+0x48/0x148
> [    0.230105]
> [    0.230105] stack backtrace:
> [    0.230121] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.18.20 #1
> [    0.230130] Backtrace:
> [    0.230157] [<80012af4>] (dump_backtrace) from [<80012d00>] (show_stack+0x18/0x1c)
> [    0.230166]  r6:80a5d11c r5:00000000 r4:00000000 r3:00000000
> [    0.230201] [<80012ce8>] (show_stack) from [<80743e9c>] (dump_stack+0x8c/0xa4)
> [    0.230222] [<80743e10>] (dump_stack) from [<80062008>] (print_usage_bug+0x1d8/0x2cc)
> [    0.230230]  r6:80a42708 r5:80bcf710 r4:80a422b0 r3:00000002
> [    0.230265] [<80061e30>] (print_usage_bug) from [<800622e0>] (mark_lock+0x1e4/0x6cc)
> [    0.230273]  r9:be080000 r8:00000000 r7:80a422b0 r6:00000002 r5:80a42708 r4:80061580
> [    0.230313] [<800620fc>] (mark_lock) from [<80062840>] (mark_held_locks+0x78/0xa0)
> [    0.230322]  r10:80a52e18 r9:be080000 r8:00000002 r7:00000000 r6:80a422b0 r5:80a42708
> [    0.230353]  r4:00000000 r3:0000000c
> [    0.230378] [<800627c8>] (mark_held_locks) from [<800628e4>] (trace_hardirqs_on_caller+0x7c/0x1e4)
> [    0.230386]  r8:00000002 r7:80013874 r6:00000001 r5:80a422b0 r4:80a36008 r3:80a36000
> [    0.230426] [<80062868>] (trace_hardirqs_on_caller) from [<80062a60>] (trace_hardirqs_on+0x14/0x18)
> [    0.230434]  r7:80a37e6c r6:ffffffff r5:20000113 r4:8074b004
> [    0.230468] [<80062a4c>] (trace_hardirqs_on) from [<80013874>] (__ipipe_fast_svc_irq_exit+0x4/0x18)
> The kernel otherwise appears to be functional.
> How do I fix this?

Disable CONFIG_TRACE_IRQFLAGS. This means disabling CONFIG_LOCKDEP too.

-- 
					    Gilles.
https://click-hack.org

