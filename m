From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 3 Sep 2014 09:21:54 -0400
Message-ID: <20140903132154.GJ17690@csclub.uwaterloo.ca>
References: <20140828203532.GA17690@csclub.uwaterloo.ca>
 <53FF93A3.8070101@xenomai.org>
 <20140828220153.GE17690@csclub.uwaterloo.ca>
 <53FFA96E.2090904@xenomai.org>
 <20140828231625.GF17690@csclub.uwaterloo.ca>
 <20140903125422.GI17690@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140903125422.GI17690@csclub.uwaterloo.ca>
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

On Wed, Sep 03, 2014 at 08:54:22AM -0400, Lennart Sorensen wrote:
> OK so far I have:
> 
> static noinline struct kmem_cache_node *free_debug_processing(
>         struct kmem_cache *s, struct page *page, void *object,
>         unsigned long addr, unsigned long *flags)
> {
>         struct kmem_cache_node *n = get_node(s, page_to_nid(page));
> 
> pr_info("n: %p flags: %p\n", n, flags);
>         spin_lock_irqsave(&n->list_lock, *flags);
>         slab_lock(page);
> 
>         if (!check_slab(s, page))
>                 goto fail;
> 
>         if (!check_valid_pointer(s, page, object)) {
>                 slab_err(s, page, "Invalid object pointer 0x%p", object);
>                 goto fail;
>         }
> 
> prints out:
> 
> [  176.234145] n:   (null) flags: ee8f5e04
> 
> n being NULL is obviously a bad thing.

So if I turn of SLUB_DEBUG, then I don't enter that code and it gets
further, but then I get:

[  433.393529] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[  433.405234] Setting up static identity map for 0xc0458758 - 0xc04587b0
[  434.418708] CPU1: failed to come online
[  434.426710] Brought up 1 CPUs
[  434.432918] SP: Total of 1 processors activated.
[  434.442663] CPU: All CPU(s) started in HYP mode.
[  434.452232] CPU: Virtualization extensions available.

which interestingly is right around the same message where it was crashing
with SLUB_DEBUG enabled (where debug functions seemed to be getting
called with an invalid kmem_cache)

Also:

[  434.528377] WARNING: CPU: 0 PID: 1 at /tmp/linux/linux-3.12.26.rr1/arch/arm/mach-omap2/omap_hwmod.c:2574 _init+0x4c0/0x50c()
[  434.551394] omap_hwmod: uart3: doesn't have mpu register target base
[  434.564501] Modules linked in:
[  434.570890] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12-1-am5726 #1 Debian 3.12.26-0.1
[  434.587734] [<c0024fd0>] (unwind_backtrace+0x0/0xf8) from [<c00214ac>] (show_stack+0x10/0x14)
[  434.605277] [<c00214ac>] (show_stack+0x10/0x14) from [<c044f130>] (dump_stack+0x70/0x8c)
[  434.621935] [<c044f130>] (dump_stack+0x70/0x8c) from [<c00504a4>] (warn_slowpath_common+0x68/0x8c)
[  434.640358] [<c00504a4>] (warn_slowpath_common+0x68/0x8c) from [<c005055c>] (warn_slowpath_fmt+0x30/0x40)
[  434.660018] [<c005055c>] (warn_slowpath_fmt+0x30/0x40) from [<c066b220>] (_init+0x4c0/0x50c)
[  434.677383] [<c066b220>] (_init+0x4c0/0x50c) from [<c003aab4>] (omap_hwmod_for_each+0x30/0x5c)
[  434.695100] [<c003aab4>] (omap_hwmod_for_each+0x30/0x5c) from [<c066b728>] (__omap_hwmod_setup_all+0x24/0x40)
[  434.715470] [<c066b728>] (__omap_hwmod_setup_all+0x24/0x40) from [<c0008c78>] (do_one_initcall+0xe4/0x140)
[  434.735309] [<c0008c78>] (do_one_initcall+0xe4/0x140) from [<c065fb78>] (kernel_init_freeable+0x100/0x1cc)
[  434.755148] [<c065fb78>] (kernel_init_freeable+0x100/0x1cc) from [<c0449b2c>] (kernel_init+0x8/0xe4)
[  434.773923] [<c0449b2c>] (kernel_init+0x8/0xe4) from [<c001db20>] (ret_from_fork+0x18/0x38)

and

[  435.976369] NET: Registered protocol family 1
[  435.986006] kvm [1]: interrupt-controller@48214000 IRQ25
[  435.997131] kvm [1]: timer IRQ27
[  436.003886] kvm [1]: Hyp mode initialized successfully
[  436.017503] audit: initializing netlink socket (disabled)
[  436.028800] type=2000 audit(1.478:1): initialized
[  436.128627] bounce pool size: 64 pages
[  436.143714] Unable to handle kernel NULL pointer dereference at virtual address 00000003
[  436.160397] pgd = c0003000, hw pgd = c0003000
[  436.169438] [00000003] *pgd=80000080004003, *pmd=00000000
[  436.180623] Internal error: Oops: a06 [#1] SMP ARM
[  436.190538] Modules linked in:
[  436.196921] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.12-1-am5726 #1 Debian 3.12.26-0.1
[  436.215685] task: ee8f0000 ti: ee8f4000 task.ti: ee8f4000
[  436.226845] PC is at _test_and_set_bit+0x4/0x48
[  436.236235] LR is at unfreeze_partials+0xa0/0x188
[  436.245975] pc : [<c0230114>]    lr : [<c0124880>]    psr: 20000153
[  436.245975] sp : ee8f5e88  ip : 00000003  fp : 538df7d0
[  436.269694] r10: c169b760  r9 : c07419f4  r8 : 00000000
[  436.280494] r7 : 00000000  r6 : 54763746  r5 : d38df7d0  r4 : e20bb003
[  436.293948] r3 : 00000053  r2 : 00000000  r1 : e20bb003  r0 : 00000000
[  436.307404] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[  436.322628] Control: 30c5387d  Table: 80003000  DAC: fffffffd
[  436.334490] Process swapper/0 (pid: 1, stack limit = 0xee8f4248)
[  436.346884] Stack: (0xee8f5e88 to 0xee8f6000)
[  436.355916] 5e80:                   00000000 eeb1a040 eeb21280 538df7d0 8040003f c044df50
[  436.372735] 5ea0: 8040003f 00000000 eeb21280 c0d95760 00000000 c06d95f8 c06d4aa8 00000001
[  436.389554] 5ec0: c07419f4 c065f510 00000000 c044dda0 ee83bd40 c07b4a24 c06aeae8 c0741500
[  436.406373] 5ee0: c067e478 ee8f4000 c065f510 c067e538 00000000 c06c4998 00000006 c0008c78
[  436.423192] 5f00: 00000064 c0fc8bf6 00000000 00000000 00000000 c063326c 00000072 ee8f5f30
[  436.440011] 5f20: c006cd00 c0237744 20000153 ffffffff c0fc8c04 c04906b4 00000064 c006cf24
[  436.456830] 5f40: c05e7ba0 c0632e8c 00000006 00000006 c0707874 c06c4998 00000006 c06aeae8
[  436.473649] 5f60: c0741500 00000064 c06aeaf4 c065f510 00000000 c065fb78 00000006 00000006
[  436.490467] 5f80: c065f510 c0fcfd40 00000000 c0449b24 00000000 00000000 00000000 00000000
[  436.507286] 5fa0: 00000000 c0449b2c 00000000 c001db20 00000000 00000000 00000000 00000000
[  436.524104] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  436.540923] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 646b66f7 f71f7b59
[  436.557749] [<c0230114>] (_test_and_set_bit+0x4/0x48) from [<c0124880>] (unfreeze_partials+0xa0/0x188)
[  436.576875] [<c0124880>] (unfreeze_partials+0xa0/0x188) from [<c044dda0>] (put_cpu_partial+0x90/0x138)
[  436.596000] [<c044dda0>] (put_cpu_partial+0x90/0x138) from [<c067e538>] (slab_sysfs_init+0xc0/0x10c)
[  436.614769] [<c067e538>] (slab_sysfs_init+0xc0/0x10c) from [<c0008c78>] (do_one_initcall+0xe4/0x140)
[  436.633538] [<c0008c78>] (do_one_initcall+0xe4/0x140) from [<c065fb78>] (kernel_init_freeable+0x100/0x1cc)
[  436.653368] [<c065fb78>] (kernel_init_freeable+0x100/0x1cc) from [<c0449b2c>] (kernel_init+0x8/0xe4)
[  436.672136] [<c0449b2c>] (kernel_init+0x8/0xe4) from [<c001db20>] (ret_from_fork+0x18/0x38)
[  436.689310] Code: e3500000 13a00001 e12fff1e e211c003 (15cc1000) 
[  436.701913] ---[ end trace 1b75b31a2719ed1d ]---
[  436.711532] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Given one of the cores didn't come online, it clearly still is far
from happy.

Any idea which parts of memory management IPIPE might mess around with?

-- 
Len Sorensen

