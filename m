Date: Mon, 3 May 2021 12:01:56 +0200
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: x86 on dovetail: Stress-ng gets my system down
Message-ID: <20210503120156.00a5d23d@md1za8fc.ad001.siemens.net>
In-Reply-To: <6a9b67084f19b080d6b20b02e9385ce94ef1ab66.camel@siemens.com>
References: <6a9b67084f19b080d6b20b02e9385ce94ef1ab66.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "rpm@xenomai.org" <rpm@xenomai.org>, "Kiszka, Jan (T RDA IOT)" <jan.kiszka@siemens.com>

Am Mon, 3 May 2021 11:45:52 +0200
schrieb "Bezdeka, Florian (T RDA IOT SES-DE)"
<florian.bezdeka@siemens.com>:

> Hi,
> 
> while trying to debug one of the Xenomai 3.2 issues listed at [1] I
> run into the situation described below on my x86 system. The problem
> (or at least the "system hang" is reproducible on real hardware and on
> qemu/kvm.
> 
> Once the system is frozen, attaching GDB to the qemu process shows me:
> 
> (gdb) info threads
>   Id   Target Id                  Frame
> * 1    Thread 1 (CPU#0 [running]) csd_lock_wait
> (csd=0xffff88803e92ea00) at kernel/smp.c:228 2    Thread 2 (CPU#1
> [running]) 0x0000564f0b05d36d in ?? () 3    Thread 3 (CPU#2
> [running]) csd_lock_wait (csd=0xffff88803e82f1e0) at kernel/smp.c:228
> 4    Thread 4 (CPU#3 [running]) csd_lock_wait
> (csd=0xffff88803e82f200) at kernel/smp.c:228
> 
> So three of my CPUs are waiting for other CPUs to complete a function
> call IPI. It looks like CPU1 is not responding anymore. The system is
> completely unusable at this point.
> 
> (gdb) bt
> #0  csd_lock_wait (csd=0xffff88803e92ea00) at kernel/smp.c:228
> #1  smp_call_function_many_cond (mask=mask@entry=0xffff88800448c340,
> func=func@entry=0xffffffff81055bb0 <flush_tlb_func_remote>,
> info=info@entry=0xffffffff8200acc0 <full_flush_tlb_info>,
> wait=wait@entry=true, cond_func=cond_func@entry=0xffffffff810550b0
> <tlb_is_not_lazy>) at kernel/smp.c:693 #2  0xffffffff810f56f5 in
> on_each_cpu_cond_mask (cond_func=cond_func@entry=0xffffffff810550b0
> <tlb_is_not_lazy>, func=func@entry=0xffffffff81055bb0
> <flush_tlb_func_remote>, info=info@entry=0xffffffff8200acc0
> <full_flush_tlb_info>, wait=wait@entry=true,
> mask=mask@entry=0xffff88800448c340) at kernel/smp.c:904 #3
> 0xffffffff81055538 in native_flush_tlb_others
> (cpumask=cpumask@entry=0xffff88800448c340,
> info=info@entry=0xffffffff8200acc0 <full_flush_tlb_info>) at
> arch/x86/mm/tlb.c:840 #4  0xffffffff81055fac in flush_tlb_others
> (info=0xffffffff8200acc0 <full_flush_tlb_info>,
> cpumask=0xffff88800448c340) at arch/x86/mm/tlb.c:1170 #5
> arch_tlbbatch_flush (batch=batch@entry=0xffff88800448c340) at
> arch/x86/mm/tlb.c:1170 #6  0xffffffff811ae3e1 in try_to_unmap_flush
> () at mm/rmap.c:602 #7  0xffffffff8117d9d3 in shrink_page_list
> (page_list=page_list@entry=0xffffc9000306f910,
> pgdat=pgdat@entry=0xffff88803ffdb000, sc=sc@entry=0xffffc9000306fb18,
> stat=stat@entry=0xffffc9000306f924,
> ignore_references=ignore_references@entry=false) at mm/vmscan.c:1487
> #8  0xffffffff8117f79c in shrink_inactive_list (nr_to_scan=<optimized
> out>, lruvec=lruvec@entry=0xffff88803ffde508,
> out>sc=sc@entry=0xffffc9000306fb18, lru=lru@entry=LRU_INACTIVE_FILE)
> out>at mm/vmscan.c:1962 #9  0xffffffff811800dc in shrink_list
> out>(sc=0xffffc9000306fb18, lruvec=0xffff88803ffde508,
> out>nr_to_scan=<optimized out>, lru=<optimized out>) at
> out>mm/vmscan.c:2169 #10 shrink_lruvec
> out>(lruvec=lruvec@entry=0xffff88803ffde508,
> out>sc=sc@entry=0xffffc9000306fb18) at mm/vmscan.c:2464 #11
> out>0xffffffff81180374 in shrink_node_memcgs (sc=0xffffc9000306fb18,
> out>pgdat=0xffff88803ffdb000) at mm/vmscan.c:2652 #12 shrink_node
> out>(pgdat=pgdat@entry=0xffff88803ffdb000,
> out>sc=sc@entry=0xffffc9000306fb18) at mm/vmscan.c:2769 #13
> out>0xffffffff811806c8 in shrink_zones (sc=0xffffc9000306fb18,
> out>zonelist=0xffff88803ffdc400) at mm/vmscan.c:2972 #14
> out>do_try_to_free_pages (zonelist=zonelist@entry=0xffff88803ffdc400,
> out>sc=sc@entry=0xffffc9000306fb18) at mm/vmscan.c:3027 #15
> out>0xffffffff811817f6 in try_to_free_pages
> out>(zonelist=0xffff88803ffdc400, order=order@entry=1,
> out>gfp_mask=gfp_mask@entry=4197824, nodemask=<optimized out>) at
> out>mm/vmscan.c:3266 #16 0xffffffff811ba411 in __perform_reclaim
> out>(ac=0xffffc9000306fc90, ac=0xffffc9000306fc90, order=1,
> out>gfp_mask=4197824) at mm/page_alloc.c:4335 #17
> out>__alloc_pages_direct_reclaim (did_some_progress=<synthetic
> out>pointer>, ac=0xffffc9000306fc90, alloc_flags=2112, order=1,
> out>pointer>gfp_mask=4197824) at mm/page_alloc.c:4356 #18
> out>pointer>__alloc_pages_slowpath (gfp_mask=<optimized out>,
> out>pointer>gfp_mask@entry=4197824, order=order@entry=1,
> out>pointer>ac=ac@entry=0xffffc9000306fc90) at mm/page_alloc.c:4760
> out>pointer>#19 0xffffffff811baf44 in __alloc_pages_nodemask
> out>pointer>(gfp_mask=<optimized out>, gfp_mask@entry=4197824,
> out>pointer>order=order@entry=1, preferred_nid=<optimized out>,
> out>pointer>nodemask=0x0 <fixed_percpu_data>) at mm/page_alloc.c:4970
> out>pointer>#20 0xffffffff811ce039 in alloc_pages_current
> out>pointer>(gfp=gfp@entry=4197824, order=order@entry=1) at
> out>pointer>./include/linux/topology.h:88 #21 0xffffffff811b6248 in
> out>pointer>alloc_pages (order=order@entry=1, gfp_mask=4197824) at
> out>pointer>./include/linux/gfp.h:547 #22 __get_free_pages
> out>pointer>(gfp_mask=gfp_mask@entry=4197824, order=order@entry=1) at
> out>pointer>mm/page_alloc.c:4994 #23 0xffffffff8105482c in _pgd_alloc
> out>pointer>() at arch/x86/mm/pgtable.c:430
> #24 pgd_alloc (mm=mm@entry=0xffff88800315e400) at
> arch/x86/mm/pgtable.c:430 #25 0xffffffff8105efae in mm_alloc_pgd
> (mm=0xffff88800315e400) at kernel/fork.c:1054 #26 mm_init
> (mm=mm@entry=0xffff88800315e400, user_ns=<optimized out>,
> p=0xffff888002bbc880) at kernel/fork.c:1054 #27 0xffffffff8105f624 in
> dup_mm (oldmm=0xffff888004efa800, tsk=0xffff888002bbc880) at
> kernel/fork.c:1369 #28 0xffffffff810616a5 in copy_mm
> (tsk=0xffff888002bbc880, clone_flags=0) at
> ./arch/x86/include/asm/current.h:15 #29 copy_process
> (pid=pid@entry=0x0 <fixed_percpu_data>, trace=trace@entry=0,
> node=node@entry=-1, args=args@entry=0xffffc9000306fed0) at
> kernel/fork.c:2110 #30 0xffffffff81061934 in kernel_clone
> (args=args@entry=0xffffc9000306fed0) at kernel/fork.c:2471 #31
> 0xffffffff81061c8f in __do_sys_fork (__unused=<optimized out>) at
> kernel/fork.c:2534 #32 0xffffffff81b41693 in do_syscall_64
> (nr=<optimized out>, regs=0xffffc9000306ff58) at
> arch/x86/entry/common.c:55 #33 0xffffffff81c0007c in entry_SYSCALL_64
> () at arch/x86/entry/entry_64.S:120 #34 0x00000000000526aa in ?? ()
> #35 0x0000564f0b0bc2b0 in ?? () #36 0x0000000000000001 in
> fixed_percpu_data () #37 0x00007ffe0ee549f0 in ?? () #38
> 0x0000564f0b657260 in ?? () #39 0x0000000000000000 in ?? ()
> 
> 
> Kernel-Config: Attached. It's a x86_64 defconfig with the following
> modifications:
>  - CONFIG_XENOMAI disabled
>  - CONFIG_DOVETAIL disabled
>  - CONFIG_MIGRATION disabled
>  - CONFIG_DEBUG_INFO enabled (to be able to debug)
>  - CONFIG_GDB_SCRIPTS enabled (debugging...)
> 
> I disabled Xenomai and Dovetail to limit the search scope. The problem
> remains reproducible without them.
> 
> 
> Workload:
> Stressing the system with stress-ng. After 45 to 60 minutes the system
> is frozen.
> cmdline: stress-ng --cpu 4 --io 2 --vm 2 --vm-bytes 128M --fork 4
> --timeout 0
> 
> 
> IRQ flag:
> All CPUs (or gdb threads) waiting at kernel/smp.c:228 have the IF flag
> (part of eflag register) unset, while other CPUs have it set:
> 
> (gdb) info register
> eflags         0x2                 [ ]
> 
> vs
> 
> eflags         0x202               [ IF ]
> 
> 
> smp_call_function_many_cond() has some notes about deadlocks that
> might appear when being called with IRQs disabled, but I actually
> never saw one of the warnings that should come up. As IF flag is
> unset, someone has to turn off IRQs later (while waiting) and that
> might be the reason for the deadlock.
> 
> Ideas / feedback / advice welcome. Thanks!

Anything in the kernel log? We have this tsc=reliable thing that causes
all sorts of funny issues it seems.

Henning

> Best regards,
> Florian
> 
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.com%2FXenomai%2Fxenomai-hacker-space%2F-%2Fissues%2F16&amp;data=04%7C01%7Cde173c00-e982-4fda-8644-47edf4671d63%40ad011.siemens.com%7C47300555f9b6471527d708d90e183dd7%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637556319536919748%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=jzx060h5pSzs15pPpdPtIhPL8zDDRD5NHFH0Oz6BbqQ%3D&amp;reserved=0


