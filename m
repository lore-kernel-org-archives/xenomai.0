MIME-Version: 1.0
Date: Mon, 22 Sep 2014 13:57:03 -0400
Message-ID: <CAFvTJFEsnycSeft7DEeRFXFTXb8E8xLbzFANk2HVt50ikd14gQ@mail.gmail.com>
From: Sam Hajian <saeid.hajian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] kernel panic with IPIPE and LPAE on ARM OMAP5 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am using ipipe-3.14 on ARM OMAP5 with dual core Cortex A15. When used
IPIPE and LPAE turn on in kernel I get kernel exception. This is after
fixing a compile issue in "arch/arm/mm/fault.c" to include
"__ipipe_pin_range_globally".
If not used LPAE all works fine, but I need that for KVM.
I figured out the initial problems can be resolved if not used
CONFIG_SLUB_DEBUG in mm/kernel, however I ran into another problem with
invalid paging request as shown in second log below, which I think is the
real problem. Any suggestion/help?

[    7.074843] CPU: Testing write buffer coherency: ok
[    7.085164] /cpus/cpu@0 missing clock-frequency property
[    7.096159] /cpus/cpu@1 missing clock-frequency property
[    7.107149] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    7.118852] Setting up static identity map for 0xc04dd6d8 - 0xc04dd730
[    7.132601] Unable to handle kernel NULL pointer dereference at virtual
address 00000000
[    7.149256] pgd = c0003000, hw pgd = c0003000
[    7.158295] [00000000] *pgd=80000080004003, *pmd=00000000
[    7.169475] Internal error: Oops: 206 [#1] SMP ARM
[    7.179390] Modules linked in:
[    7.185772] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12-1-am5726 #1
Debian 3.12.26-0.1RR2
[    7.203120] task: ee8f0000 ti: ee8f4000 task.ti: ee8f4000
[    7.214282] PC is at _raw_spin_lock_irqsave+0x10/0x4c
[    7.224730] LR is at _raw_spin_lock_irqsave+0xc/0x4c
[    7.235001] pc : [<c04d8378>]    lr : [<c04d8374>]    psr: 20000153
[    7.235001] sp : ee8f5dc0  ip : 20000153  fp : c0e5d760
[    7.258718] r10: 00000000  r9 : c0067c7c  r8 : ee8f5e04
[    7.269518] r7 : 00000000  r6 : ee83ba80  r5 : c07e9034  r4 : 00000000
[    7.282972] r3 : c076cb88  r2 : 00948000  r1 : 00000001  r0 : 00000000
[    7.296427] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM
 Segment kernel
[    7.311651] Control: 30c5387d  Table: 80003000  DAC: fffffffd
[    7.323513] Process swapper/0 (pid: 1, stack limit = 0xee8f4248)
[    7.335906] Stack: (0xee8f5dc0 to 0xee8f6000)
.....
[    7.647686] [<c04d8378>] (_raw_spin_lock_irqsave+0x10/0x4c) from
[<c04d2990>] (free_debug_processing+0x28/0x260)
[    7.668578] [<c04d2990>] (free_debug_processing+0x28/0x260) from
[<c04d2c00>] (__slab_free+0x38/0x2a0)
[    7.687704] [<c04d2c00>] (__slab_free+0x38/0x2a0) from [<c0067c7c>]
(apply_workqueue_attrs+0x1a0/0x22c)
[    7.707005] [<c0067c7c>] (apply_workqueue_attrs+0x1a0/0x22c) from
[<c0067e14>] (__alloc_workqueue_key+0x10c/0x3a0)
[    7.728253] [<c0067e14>] (__alloc_workqueue_key+0x10c/0x3a0) from
[<c07101f4>] (init_workqueues+0x2d0/0x3d8)
[    7.748437] [<c07101f4>] (init_workqueues+0x2d0/0x3d8) from [<c0008c78>]
(do_one_initcall+0xe4/0x140)
[    7.767386] [<c0008c78>] (do_one_initcall+0xe4/0x140) from [<c06fcadc>]
(kernel_init_freeable+0x64/0x1cc)
[    7.787040] [<c06fcadc>] (kernel_init_freeable+0x64/0x1cc) from
[<c04ce31c>] (kernel_init+0x8/0xe4)
[    7.805634] [<c04ce31c>] (kernel_init+0x8/0xe4) from [<c001b2c0>]
(ret_from_fork+0x18/0x38)
[    7.822807] Code: e92d4010 e1a04000 ebed3805 e1a00380 (e1943f9f)

If not used CONFIG_SLUB_DEBUG :
....................................................

[    5.216376] Brought up 2 CPUs
[    5.243135] SMP: Total of 2 processors activated.
[    5.252897] CPU: All CPU(s) started in SVC mode.
[    5.264438] devtmpfs: initialized
[    5.282839] VFP support v0.3: implementor 41 architecture 4 part 30
variant f rev 0
[    5.309728] Unable to handle kernel paging request at virtual address
5f3f1c00
[    5.324624] pgd = c0003000, hw pgd = c0003000
[    5.333678] [5f3f1c00] *pgd=80000080005003, *pmd=00000000
[    5.344892] Internal error: Oops: a06 [#1] SMP ARM
[    5.354811] Modules linked in:
[    5.361199] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12-1-am5726 #1
Debian 3.12.27-0.1RR5
[    5.378551] task: ee8f0000 ti: ee8f4000 task.ti: ee8f4000
[    5.389715] PC is at __ipipe_pin_range_globally+0xd8/0x12c
[    5.401049] LR is at 0xbfff3feb
[    5.407607] pc : [<c001c438>]    lr : [<bfff3feb>]    psr: 80000013
[    5.407607] sp : ee8f5d80  ip : ee83b018  fp : c06c84f4
[    5.431328] r10: c0d8a760  r9 : 00000c00  r8 : 00000018
[    5.442132] r7 : 00000000  r6 : fffff000  r5 : 00000000  r4 : c0007000
[    5.455589] r3 : 5f3f1c00  r2 : 5f3f1000  r1 : 00000000  r0 : ae8d4003
[    5.469048] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment
kernel
[    5.484099] Control: 30c5387d  Table: 80003000  DAC: fffffffd
[    5.495964] Process swapper/0 (pid: 1, stack limit = 0xee8f4248)
.......
[    5.853874] [<c001c438>] (__ipipe_pin_range_globally+0xd8/0x12c) from
[<c0220a8c>] (ioremap_page_range+0x264/0x2d4)
[    5.875301] [<c0220a8c>] (ioremap_page_range+0x264/0x2d4) from
[<c001cff4>] (__arm_ioremap_pfn_caller+0x160/0x1cc)
[    5.896548] [<c001cff4>] (__arm_ioremap_pfn_caller+0x160/0x1cc) from
[<c001cd40>] (__arm_ioremap+0x1c/0x24)
[    5.916561] [<c001cd40>] (__arm_ioremap+0x1c/0x24) from [<c03455a4>]
(of_iomap+0x38/0x40)
[    5.933388] [<c03455a4>] (of_iomap+0x38/0x40) from [<c065c838>]
(_init+0xfc/0x50c)
[    5.948975] [<c065c838>] (_init+0xfc/0x50c) from [<c002bdb4>]
(omap_hwmod_for_each+0x30/0x5c)
[    5.966508] [<c002bdb4>] (omap_hwmod_for_each+0x30/0x5c) from
[<c065d104>] (__omap_hwmod_setup_all+0x24/0x40)
[    5.986871] [<c065d104>] (__omap_hwmod_setup_all+0x24/0x40) from
[<c0008d98>] (do_one_initcall+0xe4/0x140)
[    6.006704] [<c0008d98>] (do_one_initcall+0xe4/0x140) from [<c0650bd0>]
(kernel_init_freeable+0x104/0x1d0)
[    6.026537] [<c0650bd0>] (kernel_init_freeable+0x104/0x1d0) from
[<c043cb70>] (kernel_init+0x8/0xe4)
[    6.045309] [<c043cb70>] (kernel_init+0x8/0xe4) from [<c000ee6c>]
(ret_from_fork+0x18/0x2c)
[    6.062488] Code: e0823009 e24444c0 e18400d9 e0055007 (e18200f9)

Saeid
