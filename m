MIME-Version: 1.0
In-Reply-To: <5048ACDE.2080308@xenomai.org>
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>
	<5022B5E4.7040101@xenomai.org>
	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>
	<50339840.1070202@xenomai.org>
	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>
	<CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>
	<504503DC.4040908@xenomai.org>
	<CAHue_TX3+pr39Mso1SXA83NWVRNoeocD-zDcLPk5mKn-XCkQKQ@mail.gmail.com>
	<50453DCE.5020601@xenomai.org>
	<CAHue_TUfY4f4CdCXyEYQ5mPFNiCazwZLgv9yy29W5r78tfftYA@mail.gmail.com>
	<50485E80.6050800@xenomai.org>
	<CAHue_TX6R8i_8HSNNeBi-JLBv4MGMjtQH6JxGvgj5xqWzU3kkQ@mail.gmail.com>
	<5048ACDE.2080308@xenomai.org>
Date: Fri, 7 Sep 2012 13:16:57 +0200
Message-ID: <CAHue_TW8KR_LQiruQf=ieyRz-n61smD1QUi81ZRx8fhqt2JXQA@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

>
> It is even simpler in the patch for 3.4, gt_setup is called
> automatically, and including asm/smp_twd.h is no longer needed.
>
>
I run the gt_setup at the very end of twd_timer_setup() and the system
hangs:

... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3695 kB
 per task-struct memory footprint: 1152 bytes
kmemleak: Early log buffer exceeded, please increase
DEBUG_KMEMLEAK_EARLY_LOG_SIZE
kmemleak: Kernel memory leak detector disabled
ODEBUG: selftest passed
Calibrating delay loop... 789.70 BogoMIPS (lpj=3D3948544)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
ftrace: allocating 14006 entries in 42 pages
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
local timer: 200.00MHz.
I-pipe, 200.000 MHz clocksource
I-pipe, 200.000 MHz timer
hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters availabl=
e
CPU1: Booted secondary processor
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
local timer: 200.00MHz.
CPU2: Booted secondary processor
CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
local timer: 200.00MHz.
I-pipe, 200.000 MHz timer
CPU2: Unknown IPI message 0x1
CPU3: Booted secondary processor
CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
local timer: 200.00MHz.
I-pipe, 200.000 MHz timer
CPU3: Unknown IPI message 0x1
Brought up 4 CPUs
SMP: Total of 4 processors activated (3176.03 BogoMIPS).
I-pipe, 200.000 MHz timer
CPU1: Unknown IPI message 0x1
BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]
Modules linked in:
irq event stamp: 34903
hardirqs last  enabled at (34902): [<c000e6d0>]
__ipipe_fast_svc_irq_exit+0x0/0x30
hardirqs last disabled at (34903): [<c000e674>] __irq_svc+0x34/0x90
softirqs last  enabled at (34901): [<c0038800>] __do_softirq+0x178/0x23c
softirqs last disabled at (34896): [<c0038dbc>] irq_exit+0x6c/0x74

Pid: 1, comm:            swapper/0
CPU: 0    Not tainted  (3.2.21-ipipe #98)
PC is at clocksource_enqueue+0x3c/0x70
LR is at 0x0
pc : [<c00606a8>]    lr : [<00000000>]    psr: 80000013
sp : 00000000  ip : 00000000  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 6000404a  DAC: 00000017
[<c001568c>] (unwind_backtrace+0x0/0x104) from [<c04644ac>]
(dump_stack+0x20/0x24)
[<c04644ac>] (dump_stack+0x20/0x24) from [<c000ff98>] (show_regs+0x54/0x58)
[<c000ff98>] (show_regs+0x54/0x58) from [<c0083d50>]
(watchdog_timer_fn+0x1ac/0x21c)
[<c0083d50>] (watchdog_timer_fn+0x1ac/0x21c) from [<c0058270>]
(__run_hrtimer+0x84/0x1d0)
[<c0058270>] (__run_hrtimer+0x84/0x1d0) from [<c0059450>]
(hrtimer_run_queues+0xd8/0x19c)
[<c0059450>] (hrtimer_run_queues+0xd8/0x19c) from [<c004157c>]
(run_local_timers+0x18/0x24)
[<c004157c>] (run_local_timers+0x18/0x24) from [<c00415c4>]
(update_process_times+0x3c/0x6c)
[<c00415c4>] (update_process_times+0x3c/0x6c) from [<c0041650>]
(update_root_process_times+0x5c/0x60)
[<c0041650>] (update_root_process_times+0x5c/0x60) from [<c0064384>]
(tick_periodic+0x48/0xbc)
[<c0064384>] (tick_periodic+0x48/0xbc) from [<c00644c8>]
(tick_handle_periodic+0x34/0x98)
[<c00644c8>] (tick_handle_periodic+0x34/0x98) from [<c0014b94>]
(twd_handler+0x50/0x5c)
[<c0014b94>] (twd_handler+0x50/0x5c) from [<c0087630>]
(handle_percpu_devid_irq+0xa4/0x174)
[<c0087630>] (handle_percpu_devid_irq+0xa4/0x174) from [<c008423c>]
(generic_handle_irq+0x2c/0x40)
[<c008423c>] (generic_handle_irq+0x2c/0x40) from [<c000f628>]
(handle_IRQ+0x6c/0xdc)
[<c000f628>] (handle_IRQ+0x6c/0xdc) from [<c0018c10>]
(__ipipe_do_IRQ+0x40/0x48)
[<c0018c10>] (__ipipe_do_IRQ+0x40/0x48) from [<c008ec30>]
(__ipipe_dispatch_irq_fast+0x2b4/0x300)
[<c008ec30>] (__ipipe_dispatch_irq_fast+0x2b4/0x300) from [<c008ed88>]
(__ipipe_dispatch_irq+0x10c/0x388)
[<c008ed88>] (__ipipe_dispatch_irq+0x10c/0x388) from [<c0008574>]
(__ipipe_grab_irq+0xa4/0xec)
[<c0008574>] (__ipipe_grab_irq+0xa4/0xec) from [<c000e67c>]
(__irq_svc+0x3c/0x90)
Exception stack(0xcf905ee8 to 0xcf905f30)
5ee0:                   c06560e0 c064feb0 c064fe80 c0656010 00000001
cf904000
5f00: 8e778000 00000006 70a3d70a a3d70a3d 00000000 cf905f44 c064feb0
cf905f30
5f20: 7fffffff c00606a8 80000013 ffffffff
[<c000e67c>] (__irq_svc+0x3c/0x90) from [<c00606a8>]
(clocksource_enqueue+0x3c/0x70)
[<c00606a8>] (clocksource_enqueue+0x3c/0x70) from [<c0060af4>]
(clocksource_register+0x98/0xfc)
[<c0060af4>] (clocksource_register+0x98/0xfc) from [<c05fe8c8>]
(init_jiffies_clocksource+0x14/0x1c)
[<c05fe8c8>] (init_jiffies_clocksource+0x14/0x1c) from [<c00088b4>]
(do_one_initcall+0x48/0x190)
[<c00088b4>] (do_one_initcall+0x48/0x190) from [<c05f78f4>]
(kernel_init+0xd4/0x17c)
[<c05f78f4>] (kernel_init+0xd4/0x17c) from [<c000f8cc>]
(kernel_thread_exit+0x0/0x8)

After debugging some code I got following:


Booting Linux on physical CPU 0
Initializing cgroup subsys cpuset
Linux version 3.2.21-ipipe (marcin@simisc.EMEA) (gcc version 4.6.0
(crosstool-NG 1.16.0) ) #98 SMP Fri Sep 7 11:35:29 CEST 2012
CPU: ARMv7 Processor [410fc091] revision 1 (ARMv7), cr=3D10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: ARM-Versatile Express
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writealloc
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
PERCPU: Embedded 9 pages/cpu @c0e99000 s13344 r8192 d15328 u36864
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64960
Kernel command line: ip=3Ddhcp earlyprintk console=3DttyAMA0 mem=3D256M
reboot=3Dsoft
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB =3D 256MB total
Memory: 246848k/246848k available, 15296k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc05f6d4c   (6076 kB)
      .init : 0xc05f7000 - 0xc0641420   ( 298 kB)
      .data : 0xc0642000 - 0xc06793e8   ( 221 kB)
       .bss : 0xc067940c - 0xc0c53b6c   (5994 kB)
Hierarchical RCU implementation.
        RCU lockdep checking is enabled.
NR_IRQS:128
I-pipe, 1.000 MHz clocksource
Interrupt pipeline (release #1)
Console: colour dummy device 80x30
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3695 kB
 per task-struct memory footprint: 1152 bytes
kmemleak: Early log buffer exceeded, please increase
DEBUG_KMEMLEAK_EARLY_LOG_SIZE
kmemleak: Kernel memory leak detector disabled
ODEBUG: selftest passed
Calibrating delay loop... 789.70 BogoMIPS (lpj=3D3948544)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
ftrace: allocating 14006 entries in 42 pages
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
local timer: 200.00MHz.
............Global timer setup.............
............If !gt_base.............
............Start Global timer.............
............TSC INFO..........
............tsc_info.freq...........200000000..
............tsc_info.counter_vaddr...........3498066432..
............tsc_info.u.counter_paddr =3D=3D base...........503316992..
............bits =3D=3D 64.............
............Global timer register.............
I-pipe, 200.000 MHz clocksource
I-pipe, 200.000 MHz timer
hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters availabl=
e
CPU1: Booted secondary processor
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
local timer: 200.00MHz.
CPU2: Booted secondary processor
............Global timer setup.............
CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
local timer: 200.00MHz.
............Global timer setup.............
............Global timer setup already done.............
I-pipe, 200.000 MHz timer
CPU2: Unknown IPI message 0x1
CPU3: Booted secondary processor
CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
local timer: 200.00MHz.
............Global timer setup.............
............Global timer setup already done.............
I-pipe, 200.000 MHz timer
CPU3: Unknown IPI message 0x1
Brought up 4 CPUs
SMP: Total of 4 processors activated (3176.03 BogoMIPS).
............Global timer setup already done.............
I-pipe, 200.000 MHz timer
CPU1: Unknown IPI message 0x1
BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]
Modules linked in:
irq event stamp: 34903
hardirqs last  enabled at (34902): [<c000e6d0>]
__ipipe_fast_svc_irq_exit+0x0/0x30
hardirqs last disabled at (34903): [<c000e674>] __irq_svc+0x34/0x90
softirqs last  enabled at (34901): [<c0038800>] __do_softirq+0x178/0x23c
softirqs last disabled at (34896): [<c0038dbc>] irq_exit+0x6c/0x74

Pid: 1, comm:            swapper/0
CPU: 0    Not tainted  (3.2.21-ipipe #98)
PC is at clocksource_enqueue+0x3c/0x70
LR is at 0x0
pc : [<c00606a8>]    lr : [<00000000>]    psr: 80000013
sp : 00000000  ip : 00000000  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 6000404a  DAC: 00000017
[<c001568c>] (unwind_backtrace+0x0/0x104) from [<c04644ac>]
(dump_stack+0x20/0x24)
[<c04644ac>] (dump_stack+0x20/0x24) from [<c000ff98>] (show_regs+0x54/0x58)
[<c000ff98>] (show_regs+0x54/0x58) from [<c0083d50>]
(watchdog_timer_fn+0x1ac/0x21c)
[<c0083d50>] (watchdog_timer_fn+0x1ac/0x21c) from [<c0058270>]
(__run_hrtimer+0x84/0x1d0)
[<c0058270>] (__run_hrtimer+0x84/0x1d0) from [<c0059450>]
(hrtimer_run_queues+0xd8/0x19c)
[<c0059450>] (hrtimer_run_queues+0xd8/0x19c) from [<c004157c>]
(run_local_timers+0x18/0x24)
[<c004157c>] (run_local_timers+0x18/0x24) from [<c00415c4>]
(update_process_times+0x3c/0x6c)
[<c00415c4>] (update_process_times+0x3c/0x6c) from [<c0041650>]
(update_root_process_times+0x5c/0x60)
[<c0041650>] (update_root_process_times+0x5c/0x60) from [<c0064384>]
(tick_periodic+0x48/0xbc)
[<c0064384>] (tick_periodic+0x48/0xbc) from [<c00644c8>]
(tick_handle_periodic+0x34/0x98)
[<c00644c8>] (tick_handle_periodic+0x34/0x98) from [<c0014b94>]
(twd_handler+0x50/0x5c)
[<c0014b94>] (twd_handler+0x50/0x5c) from [<c0087630>]
(handle_percpu_devid_irq+0xa4/0x174)
[<c0087630>] (handle_percpu_devid_irq+0xa4/0x174) from [<c008423c>]
(generic_handle_irq+0x2c/0x40)
[<c008423c>] (generic_handle_irq+0x2c/0x40) from [<c000f628>]
(handle_IRQ+0x6c/0xdc)
[<c000f628>] (handle_IRQ+0x6c/0xdc) from [<c0018c10>]
(__ipipe_do_IRQ+0x40/0x48)
[<c0018c10>] (__ipipe_do_IRQ+0x40/0x48) from [<c008ec30>]
(__ipipe_dispatch_irq_fast+0x2b4/0x300)
[<c008ec30>] (__ipipe_dispatch_irq_fast+0x2b4/0x300) from [<c008ed88>]
(__ipipe_dispatch_irq+0x10c/0x388)
[<c008ed88>] (__ipipe_dispatch_irq+0x10c/0x388) from [<c0008574>]
(__ipipe_grab_irq+0xa4/0xec)
[<c0008574>] (__ipipe_grab_irq+0xa4/0xec) from [<c000e67c>]
(__irq_svc+0x3c/0x90)
Exception stack(0xcf905ee8 to 0xcf905f30)
5ee0:                   c06560e0 c064feb0 c064fe80 c0656010 00000001
cf904000
5f00: 8e778000 00000006 70a3d70a a3d70a3d 00000000 cf905f44 c064feb0
cf905f30
5f20: 7fffffff c00606a8 80000013 ffffffff
[<c000e67c>] (__irq_svc+0x3c/0x90) from [<c00606a8>]
(clocksource_enqueue+0x3c/0x70)
[<c00606a8>] (clocksource_enqueue+0x3c/0x70) from [<c0060af4>]
(clocksource_register+0x98/0xfc)
[<c0060af4>] (clocksource_register+0x98/0xfc) from [<c05fe8c8>]
(init_jiffies_clocksource+0x14/0x1c)
[<c05fe8c8>] (init_jiffies_clocksource+0x14/0x1c) from [<c00088b4>]
(do_one_initcall+0x48/0x190)
[<c00088b4>] (do_one_initcall+0x48/0x190) from [<c05f78f4>]
(kernel_init+0xd4/0x17c)
[<c05f78f4>] (kernel_init+0xd4/0x17c) from [<c000f8cc>]
(kernel_thread_exit+0x0/0x8)

If I don't run gt_setup at all it boots up well and I got even the message
about ipipe_tsc

(...)
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Version 1.0.24.
*Switching to clocksource ipipe_tsc*
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
(...)

Does this problem look familiar to you?

About that "arm-none-linux-gnueabi-objdump -d vmlinux | less" command, I
can't find that address there.

--=20
Marcin Ku=B6ka
