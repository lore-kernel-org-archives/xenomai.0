From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 28 Aug 2014 18:01:53 -0400
Message-ID: <20140828220153.GE17690@csclub.uwaterloo.ca>
References: <20140828203532.GA17690@csclub.uwaterloo.ca>
 <53FF93A3.8070101@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53FF93A3.8070101@xenomai.org>
Subject: Re: [Xenomai] Xenomai/Ipipe on arm with LPAE enabled not booting -
 now with crash message
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

On Thu, Aug 28, 2014 at 10:40:03PM +0200, Gilles Chanteperdrix wrote:
> On 08/28/2014 10:35 PM, Lennart Sorensen wrote:
> > So I did some experiments on 3.12 kernel on an omap5726.
> > 
> > Xenomai/ipipe seems to work great (after all it managed to pass the
> > xenomai test suite).
> > 
> > LPAE+KVM also works great.
> > 
> > However if you enable LPAE (with or without KVM) while ipipe is enabled
> > (with or without xenomai enabled), then the kernel never boots (no
> > console messages at all).
> > 
> > Any ideas where to start on debugging this problem?
> 
> Chances are high that the kernel starts booting, but encounters a 
> problem before enabling the console. In order to get the traces, see:
> 
> http://xenomai.org/2014/06/porting-xenomai-to-a-new-arm-soc/#The_kernel_stops_after_the_message_8220Uncompressing_Linux8230_done_booting_the_kernel8221

I made the assumption that an OMAP57xx was a lot like an OMAP54xx and
hence got earlyprintk working and we get this:

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.12-1-am5726 (debian-kernel@lists.debian.org) (gcc version 4.7.2 (Debian 4.7.2-5) ) #1 SMP Debian 3.12.26-0.1 (2014-07-14)
[    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=30c7387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine: Generic DRA7XX (Flattened Device Tree), model: RCM RX1400
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] PERCPU: Embedded 11 pages/cpu @c0fcd000 s23552 r8192 d13312 u45056
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 256016
[    0.000000] Kernel command line: root=/dev/mmcblk0p5 ro console=ttyO2,57600n8 rootwait 3 earlyprintk bootver=2014.04RR3
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1012996K/1030144K available (4601K kernel code, 469K rwdata, 1900K rodata, 431K init, 523K bss, 17148K reserved, 251904K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0661a14   (6503 kB)
[    0.000000]       .init : 0xc0662000 - 0xc06cdc00   ( 431 kB)
[    0.000000]       .data : 0xc06ce000 - 0xc07435d8   ( 470 kB)
[    0.000000]        .bss : 0xc07435d8 - 0xc07c6370   ( 524 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Architected cp15 timer(s) running at 6.14MHz (phys).
[    0.000000] I-pipe, 6.144 MHz clocksource
[    0.000000] Switching to timer-based delay loop
[    0.000000] sched_clock: ARM arch timer >56 bits at 6144kHz, resolution 162ns
[    0.000000] Interrupt pipeline (release #1)
[   91.652385] Calibrating delay loop (skipped), value calculated using timer frequency.. 12.28 BogoMIPS (lpj=6144)
[   91.673300] pid_max: default: 32768 minimum: 301
[   91.682962] Security Framework initialized
[   91.691510] Mount-cache hash table entries: 512
[   91.722838] CPU: Testing write buffer coherency: ok
[   91.733166] /cpus/cpu@0 missing clock-frequency property
[   91.744165] /cpus/cpu@1 missing clock-frequency property
[   91.755156] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[   91.766862] Setting up static identity map for 0xc045afd8 - 0xc045b030
[   91.780611] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   91.797264] pgd = c0003000, hw pgd = c0003000
[   91.806303] [00000000] *pgd=80000080004003, *pmd=00000000
[   91.817483] Internal error: Oops: 206 [#1] SMP ARM
[   91.827398] Modules linked in:
[   91.833781] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12-1-am5726 #1 Debian 3.12.26-0.1
[   91.850599] task: ee8f0000 ti: ee8f4000 task.ti: ee8f4000
[   91.861761] PC is at _raw_spin_lock_irqsave+0x10/0x4c
[   91.872209] LR is at _raw_spin_lock_irqsave+0xc/0x4c
[   91.882479] pc : [<c0455c98>]    lr : [<c0455c94>]    psr: 20000153
[   91.882479] sp : ee8f5dc0  ip : 20000153  fp : c0d97760
[   91.906198] r10: 00000000  r9 : c006a46c  r8 : ee8f5e04
[   91.916997] r7 : 00000000  r6 : ee83ba40  r5 : c0743af4  r4 : 00000000
[   91.930451] r3 : c06c8b88  r2 : 00905000  r1 : 00000001  r0 : 00000000
[   91.943907] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[   91.959131] Control: 30c5387d  Table: 80003000  DAC: fffffffd
[   91.970992] Process swapper/0 (pid: 1, stack limit = 0xee8f4248)
[   91.983385] Stack: (0xee8f5dc0 to 0xee8f6000)
[   91.992419] 5dc0: c0d97760 c04502ac ee8f5dec c007a32c 0000071f ee83b9c0 ee8d2200 ee83ba00
[   92.009239] 5de0: c0743af4 ee83ba40 00000000 c045051c ee8f5e04 ee8690e0 00000000 c007c52c
[   92.026058] 5e00: c06db5f8 00000002 ee8d2100 ee8d2200 ee8d2258 ee8d2100 ee83ba00 c06db5f8
[   92.042877] 5e20: c06d6aa8 c006a46c ee804400 ee8d2100 ee83b9c0 ee8d2200 ee83ba00 ee8d2110
[   92.059695] 5e40: ee83ba40 00000000 00000000 c006a46c 00000002 ee8d2100 ee8d2110 00000002
[   92.076515] 5e60: ee8d2108 c0746764 c06d6aa8 00000000 c0460ba4 c006a604 00000055 00000001
[   92.093333] 5e80: ee8d2168 00000000 ee8d50c8 00000000 ee8f5ec4 ee8d50c0 ffffffec 00000000
[   92.110151] 5ea0: c06d6534 00000001 c06d6528 c0746898 c06d6aa8 c07468a0 c0460ba4 c0676314
[   92.126970] 5ec0: 00000000 c06d6aa8 ee8f4000 ee8f5ed4 00000000 ffffffec 00000000 c06c7840
[   92.143789] 5ee0: c06c7870 00000000 00000000 c0676044 ee8f4000 00000000 00000000 c0008c78
[   92.160607] 5f00: 00000000 00000000 00000000 c008b2e0 c059bc00 ee8f5f44 00000000 c044f028
[   92.177426] 5f20: c059bc6c ee8f5f44 00905000 c07439a0 80000000 00000002 00000000 c00287f0
[   92.194244] 5f40: c059bc04 00000000 ffffffff 00000000 00000000 c06c7840 c06c7870 00000000
[   92.211062] 5f60: 00000000 00000000 00000000 00000000 00000000 c0662adc 00000026 c00790e0
[   92.227880] 5f80: ee8f0000 c0fd1d40 00000000 c044bea4 00000000 00000000 00000000 00000000
[   92.244698] 5fa0: 00000000 c044beac 00000000 c001db20 00000000 00000000 00000000 00000000
[   92.261515] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   92.278334] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 646b66f7 f71f7b59
[   92.295163] [<c0455c98>] (_raw_spin_lock_irqsave+0x10/0x4c) from [<c04502ac>] (free_debug_processing+0x28/0x260)
[   92.316057] [<c04502ac>] (free_debug_processing+0x28/0x260) from [<c045051c>] (__slab_free+0x38/0x2a0)
[   92.335184] [<c045051c>] (__slab_free+0x38/0x2a0) from [<c006a46c>] (apply_workqueue_attrs+0x1a0/0x22c)
[   92.354485] [<c006a46c>] (apply_workqueue_attrs+0x1a0/0x22c) from [<c006a604>] (__alloc_workqueue_key+0x10c/0x3a0)
[   92.375733] [<c006a604>] (__alloc_workqueue_key+0x10c/0x3a0) from [<c0676314>] (init_workqueues+0x2d0/0x3d8)
[   92.395917] [<c0676314>] (init_workqueues+0x2d0/0x3d8) from [<c0008c78>] (do_one_initcall+0xe4/0x140)
[   92.414863] [<c0008c78>] (do_one_initcall+0xe4/0x140) from [<c0662adc>] (kernel_init_freeable+0x64/0x1cc)
[   92.434516] [<c0662adc>] (kernel_init_freeable+0x64/0x1cc) from [<c044beac>] (kernel_init+0x8/0xe4)
[   92.453108] [<c044beac>] (kernel_init+0x8/0xe4) from [<c001db20>] (ret_from_fork+0x18/0x38)
[   92.470282] Code: e92d4010 e1a04000 ebef4bd5 e1a00380 (e1943f9f) 
[   92.482882] ---[ end trace 1b75b31a2719ed1c ]---
[   92.492480] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   92.492480] 

-- 
MLen Sorensen

