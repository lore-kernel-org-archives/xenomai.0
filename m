From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Mar 2014 16:53:39 -0400
Message-ID: <20140331205339.GU17765@csclub.uwaterloo.ca>
References: <20140331174555.GO17765@csclub.uwaterloo.ca>
 <5339B015.3080008@xenomai.org>
 <20140331182404.GP17765@csclub.uwaterloo.ca>
 <20140331191502.GQ17765@csclub.uwaterloo.ca>
 <5339BF3C.8090906@xenomai.org>
 <20140331191849.GR17765@csclub.uwaterloo.ca>
 <20140331193742.GS17765@csclub.uwaterloo.ca>
 <5339C5AC.4040409@xenomai.org>
 <20140331204257.GT17765@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140331204257.GT17765@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Mar 31, 2014 at 04:42:57PM -0400, Lennart Sorensen wrote:
> Hmm, I guess that case never is hit in my config.  I am running SMP.
> I am willing to agree mine is probably wrong then.
> 
> So comparing the diff I have against yours so far they are amazingly
> close to identical.  I found the arch_timer_arm.c changes were nicer in
> your version so I am putting that in now, and the powerpc/kernel/irq.c
> you dealt with (I had no idea what was going on there), so i am grabbing
> that too.
> 
> I found a change in your version of kernel/context_tracking.c that I am
> going to grab.  Seems to be mostly an ordering difference, but checking
> ipipe stuff first makes sense.
> 
> I found I had missaplied a bit in kernel/sched/core.c, which explains
> why I thought it looked odd while applying it.
> 
> I moved to your version of barrier.h for arm.  Everything else seems
> like just whitespace differences, so I will give this a try.

Any idea what this means at boot by the way?

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.12-1-dra7xx (debian-kernel@lists.debian.org) (gcc version 4.7.2 (Debian 4.7.2-5) ) #1 SMP PREEMPT Debian 3.12.14-0.1 (2014-03-24)
[    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine: Generic DRA7XX (Flattened Device Tree), model: TI DRA7
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] On node 0 totalpages: 388864
[    0.000000] free_area_init_node: node 0, pgdat c07ef800, node_mem_map c0d8b000
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1520 pages used for memmap
[    0.000000]   HighMem zone: 194304 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 12 pages/cpu @c19a4000 s25216 r8192 d15744 u49152
[    0.000000] pcpu-alloc: s25216 r8192 d15744 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 387344
[    0.000000] Kernel command line: elevator=noop console=ttyO0,115200n8 root=/dev/mmcblk0p2 rw rootwait earlyprintk fixrtc
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1528216K/1555456K available (5138K kernel code, 545K rwdata, 2036K rodata, 392K init, 5714K bss, 27240K reserved, 777216K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0709f54   (7176 kB)
[    0.000000]       .init : 0xc070a000 - 0xc076c280   ( 393 kB)
[    0.000000]       .data : 0xc076e000 - 0xc07f653c   ( 546 kB)
[    0.000000]        .bss : 0xc07f653c - 0xc0d8ae00   (5715 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Architected cp15 timer(s) running at 6.14MHz (virt).
[    0.000000] I-pipe, 6.144 MHz clocksource
[    0.000000] Switching to timer-based delay loop
[    0.000000] sched_clock: ARM arch timer >56 bits at 6144kHz, resolution 162ns
[    0.000000] Interrupt pipeline (release #1)
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[341548.562288] Calibrating delay loop (skipped), value calculated using timer frequency.. 12.28 BogoMIPS (lpj=6144)
[341548.562303] pid_max: default: 32768 minimum: 301
[341548.562633] Security Framework initialized
[341548.562744] Mount-cache hash table entries: 512
[341548.639638] CPU: Testing write buffer coherency: ok
[341548.640576] /cpus/cpu@0 missing clock-frequency property
[341548.640606] /cpus/cpu@1 missing clock-frequency property
[341548.640619] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[341548.640646] Setting up static identity map for 0xc04dec28 - 0xc04dec80
[341548.649022] CPU1: Booted secondary processor
[341548.649061] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[341548.649433] Brought up 2 CPUs
[341548.649448] SMP: Total of 2 processors activated.
[341548.649456] CPU: All CPU(s) started in SVC mode.
[341548.649920] 
[341548.649928] =================================
[341548.649934] [ INFO: inconsistent lock state ]
[341548.649943] 3.12-1-dra7xx #1 Not tainted
[341548.649950] ---------------------------------
[341548.649957] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[341548.649966] swapper/0/0 [HC0[0]:SC0[0]:HE1:SE1] takes:
[341548.649973]  (std_spinlock_raw(&rq->lock)){?.....}, at: [<c04d7720>] __schedule+0x554/0x80c
[341548.650004] {IN-HARDIRQ-W} state was registered at:
[341548.650011]   [<c009801c>] __lock_acquire+0xac4/0x1bb0
[341548.650031]   [<c0099678>] lock_acquire+0x94/0x13c
[341548.650044]   [<c04d8c68>] _raw_spin_lock+0x38/0x48
[341548.650056]   [<c006b9f4>] scheduler_tick+0x2c/0xb4
[341548.650071]   [<c004b3a4>] update_process_times+0x5c/0x68
[341548.650087]   [<c0090d60>] tick_periodic+0x38/0xb4
[341548.650099]   [<c0090eec>] tick_handle_periodic+0x18/0x7c
[341548.650110]   [<c04021e8>] arch_timer_handler_virt+0x64/0x80
[341548.650124]   [<c0085128>] handle_percpu_devid_irq+0x84/0x1e0
[341548.650135]   [<c0082114>] generic_handle_irq+0x20/0x30
[341548.650149]   [<c000f5bc>] handle_IRQ+0x5c/0xd0
[341548.650162]   [<c00ae050>] __ipipe_do_sync_stage+0x2e4/0x300
[341548.650174]   [<c0008678>] __ipipe_grab_irq+0x48/0x8c
[341548.650185]   [<c0008930>] gic_handle_irq+0x28/0x5c
[341548.650196]   [<c04d9a84>] __irq_svc+0x44/0x70
[341548.650208]   [<c00ae260>] ipipe_unstall_root+0x44/0x5c
[341548.650220]   [<c070a99c>] start_kernel+0x1f8/0x31c
[341548.650234]   [<80008074>] 0x80008074
[341548.650246] irq event stamp: 29031
[341548.650253] hardirqs last  enabled at (29030): [<c04d942c>] _raw_spin_unlock_irq+0x24/0x50
[341548.650265] hardirqs last disabled at (29031): [<c04d8d30>] _raw_spin_lock_irqsave+0x1c/0x60
[341548.650277] softirqs last  enabled at (29021): [<c0043318>] irq_enter+0x6c/0x70
[341548.650290] softirqs last disabled at (29020): [<c004330c>] irq_enter+0x60/0x70
[341548.650302] 
[341548.650302] other info that might help us debug this:
[341548.650309]  Possible unsafe locking scenario:
[341548.650309] 
[341548.650317]        CPU0
[341548.650323]        ----
[341548.650328]   lock(std_spinlock_raw(&rq->lock));
[341548.650341]   <Interrupt>
[341548.650346]     lock(std_spinlock_raw(&rq->lock));
[341548.650359] 
[341548.650359]  *** DEADLOCK ***
[341548.650359] 
[341548.650369] 1 lock held by swapper/0/0:
[341548.650375]  #0:  (std_spinlock_raw(&rq->lock)){?.....}, at: [<c04d7720>] __schedule+0x554/0x80c
[341548.650402] 
[341548.650402] stack backtrace:
[341548.650414] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.12-1-dra7xx #1 Debian 3.12.14-0.1
[341548.650434] [<c001610c>] (unwind_backtrace+0x0/0xf8) from [<c00126b4>] (show_stack+0x10/0x14)
[341548.650451] [<c00126b4>] (show_stack+0x10/0x14) from [<c04d3428>] (dump_stack+0x6c/0xac)
[341548.650466] [<c04d3428>] (dump_stack+0x6c/0xac) from [<c04d07b4>] (print_usage_bug+0x258/0x2c8)
[341548.650481] [<c04d07b4>] (print_usage_bug+0x258/0x2c8) from [<c0097120>] (mark_lock+0x290/0x6c8)
[341548.650496] [<c0097120>] (mark_lock+0x290/0x6c8) from [<c0099ee4>] (mark_held_locks+0x60/0x138)
[341548.650511] [<c0099ee4>] (mark_held_locks+0x60/0x138) from [<c009a02c>] (trace_hardirqs_on_caller+0x70/0x1c4)
[341548.650525] [<c009a02c>] (trace_hardirqs_on_caller+0x70/0x1c4) from [<c04d9ab4>] (__ipipe_fast_svc_irq_exit+0x4/0x14)
[341548.650538] [<c04d9ab4>] (__ipipe_fast_svc_irq_exit+0x4/0x14) from [<c0073f44>] (idle_enter_fair+0x0/0x1a4)
[341548.650554] [<c0073f44>] (idle_enter_fair+0x0/0x1a4) from [<c076b2c0>] (runqueues+0x0/0x5c0)
[341548.659443] devtmpfs: initialized

-- 
Len Sorensen

