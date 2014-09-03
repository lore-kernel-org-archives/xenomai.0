From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 3 Sep 2014 10:29:13 -0400
Message-ID: <20140903142913.GK17690@csclub.uwaterloo.ca>
References: <20140828203532.GA17690@csclub.uwaterloo.ca>
 <53FF93A3.8070101@xenomai.org>
 <20140828220153.GE17690@csclub.uwaterloo.ca>
 <53FFA96E.2090904@xenomai.org>
 <20140828231625.GF17690@csclub.uwaterloo.ca>
 <20140903125422.GI17690@csclub.uwaterloo.ca>
 <20140903132154.GJ17690@csclub.uwaterloo.ca>
 <54071A1D.6010101@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54071A1D.6010101@xenomai.org>
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

On Wed, Sep 03, 2014 at 03:39:41PM +0200, Gilles Chanteperdrix wrote:
> On 09/03/2014 03:21 PM, Lennart Sorensen wrote:
> > On Wed, Sep 03, 2014 at 08:54:22AM -0400, Lennart Sorensen wrote:
> >> OK so far I have:
> >>
> >> static noinline struct kmem_cache_node *free_debug_processing(
> >>         struct kmem_cache *s, struct page *page, void *object,
> >>         unsigned long addr, unsigned long *flags)
> >> {
> >>         struct kmem_cache_node *n = get_node(s, page_to_nid(page));
> >>
> >> pr_info("n: %p flags: %p\n", n, flags);
> 
> The next thing to do is to check the get_node and page_to_nid code to
> see how this can result in a NULL pointer. Even before that, is the page
> pointer valid?

That's a good question.

Just for curiousity I tried using SLAB instead of SLUB and got this:

[  393.237099] Setting up static identity map for 0xc04584d8 - 0xc0458530
[  393.250644] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[  393.267294] pgd = c0003000, hw pgd = c0003000
[  393.276332] [00000000] *pgd=80000080004003, *pmd=00000000
[  393.287511] Internal error: Oops: 206 [#1] SMP ARM
[  393.297424] Modules linked in:
[  393.303807] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12-1-am5726 #1 Debian 3.12.26-0.1
[  393.320625] task: ee8e59c0 ti: ee8e6000 task.ti: ee8e6000
[  393.331788] PC is at kfree+0x74/0x148
[  393.339405] LR is at kfree+0x10c/0x148
[  393.347197] pc : [<c0125024>]    lr : [<c01250bc>]    psr: 60000153
[  393.347197] sp : ee8e7dd0  ip : a0000153  fp : 00000002
[  393.370915] r10: 00000000  r9 : 0000003c  r8 : c06d45b8
[  393.381715] r7 : 00000000  r6 : c0741934  r5 : ee850900  r4 : 00000000
[  393.395169] r3 : 00000000  r2 : 0000073f  r1 : ee850900  r0 : ee850900
[  393.408624] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[  393.423847] Control: 30c5387d  Table: 80003000  DAC: fffffffd
[  393.435708] Process swapper/0 (pid: 1, stack limit = 0xee8e6248)
[  393.448101] Stack: (0xee8e7dd0 to 0xee8e8000)
[  393.457133] 7dc0:                                     00000002 ee844740 c06d4520 000000d0
[  393.473952] 7de0: ee850900 c012527c 0000005b 00000008 ee8e5140 ee844740 0000003c 00000078
[  393.490771] 7e00: 000000d0 00000000 00001000 00001000 00000000 c01254a8 000000d0 ee844740
[  393.507590] 7e20: 00040000 ee844740 00040000 00000100 00000100 c0125fbc 00000010 00000000
[  393.524408] 7e40: 00000104 00000100 00000000 00000001 000000d0 00000039 c05a6d64 ee844740
[  393.541227] 7e60: 00000100 00040000 00000100 c05a6d64 ee8e6000 c07aeea4 00000000 c01063e4
[  393.558046] 7e80: 00000100 00000100 c05a6d64 00000000 00000000 c067304c 00000000 c0106500
[  393.574865] 7ea0: 00040000 00000000 00000000 00000000 00000000 ffffffff c06c472c c0673080
[  393.591682] 7ec0: 00000000 c06d4aa8 ee8e6000 00000000 00000000 ffffffec 00000000 c06c46fc
[  393.608501] 7ee0: c06c472c 00000000 00000000 c067304c ee8e6000 00000000 00000000 c0008c78
[  393.625320] 7f00: 00000000 00000000 00000000 c008b2e0 c0599500 ee8e7f44 00000000 c044ce58
[  393.642139] 7f20: c05995cc ee8e7f44 00906000 c07417e0 80000000 00000002 00000000 c00287f0
[  393.658958] 7f40: c0599564 00000000 ffffffff 00000000 00000000 c06c46fc c06c472c 00000000
[  393.675776] 7f60: 00000000 00000000 00000000 00000000 00000000 c065fadc 00000026 c00790e0
[  393.692593] 7f80: ee8e59c0 c0fcfd40 00000000 c0449ac4 00000000 00000000 00000000 00000000
[  393.709412] 7fa0: 00000000 c0449acc 00000000 c001db20 00000000 00000000 00000000 00000000
[  393.726231] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  393.743049] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[  393.759875] [<c0125024>] (kfree+0x74/0x148) from [<c012527c>] (__do_tune_cpucache+0x184/0x35c)
[  393.777583] [<c012527c>] (__do_tune_cpucache+0x184/0x35c) from [<c01254a8>] (enable_cpucache+0x54/0xd0)
[  393.796884] [<c01254a8>] (enable_cpucache+0x54/0xd0) from [<c0125fbc>] (__kmem_cache_create+0x21c/0x2c0)
[  393.816360] [<c0125fbc>] (__kmem_cache_create+0x21c/0x2c0) from [<c01063e4>] (kmem_cache_create_memcg+0x94/0x174)
[  393.837426] [<c01063e4>] (kmem_cache_create_memcg+0x94/0x174) from [<c0106500>] (kmem_cache_create+0x3c/0x44)
[  393.857790] [<c0106500>] (kmem_cache_create+0x3c/0x44) from [<c0673080>] (init_workqueues+0x34/0x3d8)
[  393.876736] [<c0673080>] (init_workqueues+0x34/0x3d8) from [<c0008c78>] (do_one_initcall+0xe4/0x140)
[  393.895505] [<c0008c78>] (do_one_initcall+0xe4/0x140) from [<c065fadc>] (kernel_init_freeable+0x64/0x1cc)
[  393.915159] [<c065fadc>] (kernel_init_freeable+0x64/0x1cc) from [<c0449acc>] (kernel_init+0x8/0xe4)
[  393.933751] [<c0449acc>] (kernel_init+0x8/0xe4) from [<c001db20>] (ret_from_fork+0x18/0x38)
[  393.950925] Code: e0863103 e3120502 e5934054 0a000023 (e894000c) 
[  393.963524] ---[ end trace 1b75b31a2719ed1c ]---
[  393.973120] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

So it too thinks there is something wrong with the init_workqueues startup.

The SLUB stack trace was:

[   92.295163] [<c0455c98>] (_raw_spin_lock_irqsave+0x10/0x4c) from [<c04502ac>] (free_debug_processing+0x28/0x260)                                                                                                                                                            
[   92.316057] [<c04502ac>] (free_debug_processing+0x28/0x260) from [<c045051c>] (__slab_free+0x38/0x2a0)                                                                                                                                                                      
[   92.335184] [<c045051c>] (__slab_free+0x38/0x2a0) from [<c006a46c>] (apply_workqueue_attrs+0x1a0/0x22c)                                                                                                                                                                     
[   92.354485] [<c006a46c>] (apply_workqueue_attrs+0x1a0/0x22c) from [<c006a604>] (__alloc_workqueue_key+0x10c/0x3a0)                                                                                                                                                          
[   92.375733] [<c006a604>] (__alloc_workqueue_key+0x10c/0x3a0) from [<c0676314>] (init_workqueues+0x2d0/0x3d8)                                                                                                                                                                
[   92.395917] [<c0676314>] (init_workqueues+0x2d0/0x3d8) from [<c0008c78>] (do_one_initcall+0xe4/0x140)                                                                                                                                                                       
[   92.414863] [<c0008c78>] (do_one_initcall+0xe4/0x140) from [<c0662adc>] (kernel_init_freeable+0x64/0x1cc)                                                                                                                                                                   
[   92.434516] [<c0662adc>] (kernel_init_freeable+0x64/0x1cc) from [<c044beac>] (kernel_init+0x8/0xe4)                                                                                                                                                                         
[   92.453108] [<c044beac>] (kernel_init+0x8/0xe4) from [<c001db20>] (ret_from_fork+0x18/0x38)                                                                                                                                                                                 

So init_workqueues calls
        pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);

which blows up with SLAB, while with SLUB we blow up while doing these
calls slightly later in init_workqueues:

        system_wq = alloc_workqueue("events", 0, 0);
        system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
        system_long_wq = alloc_workqueue("events_long", 0, 0);
        system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND,
                                            WQ_UNBOUND_MAX_ACTIVE);
        system_freezable_wq = alloc_workqueue("events_freezable",
                                              WQ_FREEZABLE, 0);
        system_power_efficient_wq = alloc_workqueue("events_power_efficient",
                                              WQ_POWER_EFFICIENT, 0);
        system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_power_efficient",
                                              WQ_FREEZABLE | WQ_POWER_EFFICIENT,
                                              0);

-- 
Len Sorensen

