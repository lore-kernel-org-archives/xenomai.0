Message-ID: <5161BF47.9020007@xenomai.org>
Date: Sun, 07 Apr 2013 20:47:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <515DE96F.7080508@xenomai.org> <515FEF85.5010801@web.de>
	<5161A51C.8050606@xenomai.org>
In-Reply-To: <5161A51C.8050606@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe on ARM platform.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 04/07/2013 06:55 PM, Gilles Chanteperdrix wrote:

> On 04/06/2013 11:48 AM, Jan Kiszka wrote:
> 
>> On 2013-04-04 22:58, Gilles Chanteperdrix wrote:
>>> - ftrace is broken, so I wonder if it would not be simpler to have a 
>>> tracer not relying on ftrace, as we did at the beginning of the I-pipe 
>>> tracer;

> (...)

> 
> Hi,
> 
> I have just pushed a new version of the for-core-3.8.2 branch with all
> the comments addressed.
> 
> I also had tested a merge of the previous version with your next-x86
> branch, and except a few merge conflicts and a build error without SMP,
> adressed by this commit:
> http://git.xenomai.org/ipipe-gch.git/?p=ipipe-gch.git;a=commitdiff;h=fae81444a0bfe12de514ac039f866c0f66abfb3c;hp=1198253580e0d5610ee886e1ff3771461a06f414
> 
> It seemed to work fine on my x86 boxes.


The fixes in the next-x86 branch seem to make the tracer working, 
though it seems very slow (latencies doubled on ARM). The changes in 
timings seem to break some of the regression tests, I also get a 
reproducible bug on at91sam9263 while running the "cond-torture-native" 
test:

[  202.650000] Xenomai: Switching main_task to secondary mode after exception #8 in kernel-space at 0xc0093418 (pid 986)
[  202.650000] I-pipe tracer log (100 points):
[  202.650000]  |  # func    	        0 ipipe_trace_panic_freeze+0x10 (xnpod_trap_fault+0xbc)
[  202.650000]  |  # func    	       -3 xnpod_trap_fault+0x14 (xnarch_trap_fault+0x28)
[  202.650000]  |  # func    	       -5 xnarch_trap_fault+0x14 (exception_event+0x4c)
[  202.650000]  |  # func    	       -9 exception_event+0x10 (ipipe_trap_hook+0x38)
[  202.650000]  |  # func    	      -12 ipipe_trap_hook+0x10 (__ipipe_notify_trap+0xa0)
[  202.650000]  |  # func    	      -15 __ipipe_notify_trap+0x14 (do_alignment+0x5c)
[  202.650000]  |  # func    	      -18 do_alignment+0x14 (do_DataAbort+0x50)
[  202.650000]  |  # func    	      -21 do_DataAbort+0x14 (__dabt_svc+0x50)
[  202.650000]  |  # begin   0x90000000    -24 __dabt_svc+0x44 (registry_touch_vfsnap+0x18)
[  202.650000]  |  # func    	      -28 registry_touch_vfsnap+0x10 (xnregistry_remove+0x1f8)
[  202.650000]  |  # func    	      -34 registry_hash_crunch+0x10 (xnregistry_remove+0x18c)
[  202.650000]  |  # func    	      -38 __ipipe_set_irq_pending+0x10 (__ipipe_dispatch_irq+0x210)
[  202.650000]  |  # func    	      -42 __ipipe_dispatch_irq+0x10 (ipipe_raise_irq+0x40)
[  202.650000]  |  # func    	      -44 ipipe_raise_irq+0x10 (printk+0x178)
[  202.650000]  |  # func    	      -47 __ipipe_spin_unlock_irqrestore+0x10 (printk+0x164)
[  202.650000]  |  # func    	      -72 __ipipe_spin_lock_irqsave+0x10 (printk+0x11c)
[  202.650000]  |  # func    	      -77 printk+0x18 (xnregistry_remove+0x170)
[  202.650000]  |  # func    	      -82 xnregistry_remove+0x14 (rt_mutex_delete+0x1ac)
[  202.650000]  |  # func    	      -87 xnsynch_flush+0x14 (rt_mutex_delete+0x194)
[  202.650000]  |  + begin   0x80000000    -94 rt_mutex_delete+0x60 (__rt_mutex_delete+0x5c)
[  202.650000]     + func    	      -97 rt_mutex_delete+0x14 (__rt_mutex_delete+0x5c)
[  202.650000]     + func    	     -100 xnregistry_fetch+0x10 (__rt_mutex_delete+0xa0)
[  202.650000]     + func    	     -104 __rt_mutex_delete+0x14 (hisyscall_event+0x198)
[  202.650000]     + func    	     -109 hisyscall_event+0x14 (ipipe_syscall_hook+0x40)
[  202.650000]     + func    	     -112 ipipe_syscall_hook+0x10 (__ipipe_notify_syscall+0xa8)
[  202.650000]  |  + end     0x80000001   -114 __ipipe_notify_syscall+0x98 (__ipipe_syscall_root+0x84)
[  202.650000]  |  + begin   0x80000001   -116 __ipipe_notify_syscall+0x34 (__ipipe_syscall_root+0x84)
[  202.650000]     + func    	     -118 __ipipe_notify_syscall+0x10 (__ipipe_syscall_root+0x84)
[  202.650000]     + func    	     -121 __ipipe_syscall_root+0x10 (vector_swi+0x74)
[  202.650000]  |  + begin   0x90000000   -126 vector_swi+0x3c (<018e7b70>)
[  202.650000]  |  + end     0x90000000   -163 __ipipe_ret_to_user_irqs_disabled+0x14 (<018e6c34>)
[  202.650000]  |  + end     0x80000000   -166 __ipipe_syscall_root+0x11c (vector_swi+0x74)
[  202.650000]  |  + begin   0x80000000   -170 __ipipe_syscall_root+0xa8 (vector_swi+0x74)
[  202.650000]  |  + end     0x80000001   -173 __ipipe_notify_syscall+0x12c (__ipipe_syscall_root+0x84)
[  202.650000]  |  + begin   0x80000001   -177 __ipipe_notify_syscall+0xc8 (__ipipe_syscall_root+0x84)
[  202.650000]  |  + end     0x80000000   -182 __ipipe_restore_head+0x108 (rt_cond_wait_epilogue+0x2bc)
[  202.650000]  |  # func    	     -185 __ipipe_restore_head+0x10 (rt_cond_wait_epilogue+0x2bc)
[  202.650000]  |  # func    	     -192 xnsynch_acquire+0x14 (rt_mutex_acquire_inner+0x110)
[  202.650000]  |  # func    	     -197 rt_mutex_acquire_inner+0x14 (rt_mutex_acquire+0x24)
[  202.650000]  |  # func    	     -199 rt_mutex_acquire+0x14 (rt_cond_wait_epilogue+0x150)
[  202.650000]  |  + begin   0x80000000   -205 rt_cond_wait_epilogue+0x40 (__rt_cond_wait_epilogue+0x64)
[  202.650000]     + func    	     -208 rt_cond_wait_epilogue+0x14 (__rt_cond_wait_epilogue+0x64)
[  202.650000]     + func    	     -212 xnregistry_fetch+0x10 (__rt_cond_wait_epilogue+0x84)
[  202.650000]     + func    	     -216 __rt_cond_wait_epilogue+0x14 (losyscall_event+0xd0)
[  202.650000]  |  + end     0x80000000   -221 __ipipe_restore_head+0x108 (__xnpod_schedule+0x9bc)
[  202.650000]  |  # func    	     -223 __ipipe_restore_head+0x10 (__xnpod_schedule+0x9bc)
[  202.650000]  |  # func    	     -228 xnsched_pick_next+0x10 (__xnpod_schedule+0x18c)
[  202.650000]  |  # [  986] main_tas 2   -230 __xnpod_schedule+0x16c (xnshadow_harden+0x348)
[  202.650000]  |  + begin   0x80000000   -236 __xnpod_schedule+0x68 (xnshadow_harden+0x348)
[  202.650000]     + func    	     -238 __xnpod_schedule+0x14 (xnshadow_harden+0x348)
[  202.650000]  |  + end     0x80000000   -241 __ipipe_restore_head+0x108 (xnshadow_harden+0x2f4)
[  202.650000]  |  # func    	     -244 __ipipe_restore_head+0x10 (xnshadow_harden+0x2f4)
[  202.650000]  |  + begin   0x80000000   -252 xnsched_finish_unlocked_switch+0x38 (xnshadow_harden+0x188)
[  202.650000]     + func    	     -254 xnsched_finish_unlocked_switch+0x10 (xnshadow_harden+0x188)
[  202.650000]  |  + end     0x80000000   -258 __ipipe_switch_tail+0x74 (__schedule+0x480)
[  202.650000]  |  + begin   0x80000000   -262 __ipipe_switch_tail+0x34 (__schedule+0x480)
[  202.650000]     + func    	     -264 __ipipe_switch_tail+0x10 (__schedule+0x480)
[  202.650000]  |  + end     0x80000000   -270 __ipipe_restore_head+0x108 (__xnpod_schedule+0x5ec)
[  202.650000]  |  # func    	     -272 __ipipe_restore_head+0x10 (__xnpod_schedule+0x5ec)
[  202.650000]  |  # func    	     -281 at91_mute_pic+0x10 (__xnpod_schedule+0x360)
[  202.650000]  |  # func    	     -287 xnsched_pick_next+0x10 (__xnpod_schedule+0x18c)
[  202.650000]  |  # [  989] -<?>-   -1   -289 __xnpod_schedule+0x16c (xnpod_schedule_handler+0x3c)
[  202.650000]  |  # func    	     -294 __xnpod_schedule+0x14 (xnpod_schedule_handler+0x3c)
[  202.650000]  |  # func    	     -296 xnpod_schedule_handler+0x10 (__ipipe_dispatch_irq+0x19c)
[  202.650000]  |   +func    	     -302 __ipipe_dispatch_irq+0x10 (ipipe_raise_irq+0x40)
[  202.650000]  |   +begin   0x80000001   -305 ipipe_raise_irq+0x34 (__xnpod_schedule+0x44)
[  202.650000]      +func    	     -307 ipipe_raise_irq+0x10 (__xnpod_schedule+0x44)
[  202.650000]      +func    	     -309 __xnpod_schedule+0x14 (gatekeeper_thread+0x38c)
[  202.650000]  |   +end     0x80000000   -312 __ipipe_restore_head+0x108 (gatekeeper_thread+0x364)
[  202.650000]  |  *+func    	     -314 __ipipe_restore_head+0x10 (gatekeeper_thread+0x364)
[  202.650000]  |  *+[  986] main_tas 2   -322 xnpod_resume_thread+0x148 (gatekeeper_thread+0x208)
[  202.650000]  |  *+func    	     -325 xnpod_resume_thread+0x14 (gatekeeper_thread+0x208)
[  202.650000]  |   +begin   0x80000000   -330 gatekeeper_thread+0x11c (kthread+0xbc)
[  202.650000]  |   +end     0x80000000   -333 __ipipe_restore_head+0x108 (xnsched_renice_root+0x2b0)
[  202.650000]  |  *+func    	     -335 __ipipe_restore_head+0x10 (xnsched_renice_root+0x2b0)
[  202.650000]  |  *+[  989] -<?>-   -1   -339 xnsched_renice_root+0x154 (rpi_pop+0x488)
[  202.650000]  |  *+func    	     -344 xnsched_track_policy+0x10 (xnsched_renice_root+0x13c)
[  202.650000]  |   +begin   0x80000000   -349 xnsched_renice_root+0x44 (rpi_pop+0x488)
[  202.650000]      +func    	     -352 xnsched_renice_root+0x14 (rpi_pop+0x488)
[  202.650000]  |   +end     0x80000000   -354 __ipipe_restore_head+0x108 (rpi_pop+0x460)
[  202.650000]  |  *+func    	     -356 __ipipe_restore_head+0x10 (rpi_pop+0x460)
[  202.650000]  |  *+func    	     -361 xnsched_peek_rpi+0x10 (rpi_pop+0x2e4)
[  202.650000]  |   +begin   0x80000000   -367 rpi_pop+0x3c (gatekeeper_thread+0xfc)
[  202.650000]      +func    	     -369 rpi_pop+0x14 (gatekeeper_thread+0xfc)
[  202.650000]      +func    	     -374 kthread_should_stop+0x10 (gatekeeper_thread+0xc4)
[  202.650000]      +func    	     -377 ipipe_root_only+0x10 (sub_preempt_count+0x1c)
[  202.650000]      +func    	     -379 sub_preempt_count+0x10 (__schedule+0x4b0)
[  202.650000]  |   +end     0x80000001   -383 finish_task_switch.clone.57+0x7c (__schedule+0x490)
[  202.650000]  |   +begin   0x80000001   -385 finish_task_switch.clone.57+0x60 (__schedule+0x490)
[  202.650000]      +func    	     -388 ipipe_root_only+0x10 (sub_preempt_count+0x1c)
[  202.650000]      +func    	     -390 sub_preempt_count+0x10 (_raw_spin_unlock_irq+0x24)
[  202.650000]  |   +end     0x80000000   -392 ipipe_unstall_root+0x6c (_raw_spin_unlock_irq+0x1c)
[  202.650000]  |   #func    	     -395 ipipe_root_only+0x10 (ipipe_unstall_root+0x38)
[  202.650000]  |   #begin   0x80000000   -398 ipipe_unstall_root+0x34 (_raw_spin_unlock_irq+0x1c)
[  202.650000]      #func    	     -400 ipipe_unstall_root+0x10 (_raw_spin_unlock_irq+0x1c)
[  202.650000]      #func    	     -404 _raw_spin_unlock_irq+0x10 (finish_task_switch.clone.57+0x44)
[  202.650000]      #func    	     -407 finish_task_switch.clone.57+0x10 (__schedule+0x490)
[  202.650000]  |   #end     0x80000000   -410 __ipipe_switch_tail+0x74 (__schedule+0x480)
[  202.650000]  |   #begin   0x80000000   -413 __ipipe_switch_tail+0x34 (__schedule+0x480)
[  202.650000]      #func    	     -415 __ipipe_switch_tail+0x10 (__schedule+0x480)
[  203.470000] Unable to handle kernel paging request at virtual address 20c0041e
[  203.480000] fcse pid: 84, 0xa8000000, hw pid: 0xa8000000
[  203.490000] pgd = c3358000, hw pgd = c3358000
[  203.490000] [20c0041e] *pgd=00000000
[  203.500000] Internal error: Oops: 1 [#1] PREEMPT ARM
[  203.500000] Modules linked in:
[  203.500000] CPU: 0    Not tainted  (3.8.2 #22)
[  203.500000] PC is at registry_touch_vfsnap+0x18/0x28
[  203.500000] LR is at xnregistry_remove+0x1f8/0x540
[  203.500000] pc : [<c009341c>]    lr : [<c0093fe0>]    psr: 60000093
[  203.500000] sp : c3c95e50  ip : c0093418  fp : c3c95e5c
[  203.500000] r10: 00000000  r9 : 00000000  r8 : c3af0000
[  203.500000] r7 : c3af2fd0  r6 : 00002fd0  r5 : c04cc578  r4 : 00000003
[  203.500000] r3 : 20c0041e  r2 : 00000002  r1 : 0000021e  r0 : c3af2fd0
[  203.500000] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  203.500000] Control: 0005317f  Table: 23358000  DAC: 00000015
[  203.500000] Process main_task (pid: 986, stack limit = 0xc3c941b8)
[  203.500000] Stack: (0xc3c95e50 to 0xc3c96000)
[  203.500000] 5e40:                                     c3c95ea4 c3c95e60 c0093fe0 c0093414
[  203.500000] 5e60: 00000000 80000000 c00cd598 00000000 00000000 c3050f00 00000168 c49ce600
[  203.500000] 5e80: 00000000 00000000 c04cc578 01000000 00000000 80000093 c3c95eec c3c95ea8
[  203.500000] 5ea0: c00cd6e4 c0093df8 c3c95ec4 c3c95eb8 c006b888 c006adf0 c3c95eec c3c95ec8
[  203.500000] 5ec0: c0009958 c3c95fb0 c49ce600 00000000 00000000 c3050f00 00000168 00000001
[  203.500000] 5ee0: c3c95f14 c3c95ef0 c00bee78 c00cd548 c3c95f4c 00000066 016a2000 00000001
[  203.500000] 5f00: c3c95fb0 c49ce010 c3c95f4c c3c95f18 c00a4450 c00bee2c c3c95f34 c051a9c0
[  203.500000] 5f20: c006b888 c04c9898 c051a9c0 c051a9c0 c051a9c0 c3c95fb0 00000000 60000013
[  203.500000] 5f40: c3c95f5c c3c95f50 c006c0c8 c00a42c8 c3c95f8c c3c95f60 c0068608 c006c098
[  203.500000] 5f60: c3050f00 c3c95fb0 00000002 000f0042 000f0042 c0009adc 00000000 00000000
[  203.500000] 5f80: c3c95fac c3c95f90 c00100b8 c0068570 21f6cc97 00000000 00000000 000f0042
[  203.500000] 5fa0: 00000000 c3c95fb0 c0009a14 c0010044 2d01022b 01a42cf4 01a42cf4 00010000
[  203.500000] 5fc0: 21f6cc97 00000000 00000000 000f0042 017e9000 00000000 017e9000 00000000
[  203.500000] 5fe0: 00013d48 01a42c48 00009d68 018e7b74 60000010 2d01022b 00000000 00000000
[  203.500000] Backtrace: 
[  203.500000] [<c0093404>] (registry_touch_vfsnap+0x0/0x28) from [<c0093fe0>] (xnregistry_remove+0x1f8/0x540)
[  203.500000] [<c0093de8>] (xnregistry_remove+0x0/0x540) from [<c00cd6e4>] (rt_mutex_delete+0x1ac/0x3fc)
[  203.500000] [<c00cd538>] (rt_mutex_delete+0x0/0x3fc) from [<c00bee78>] (__rt_mutex_delete+0x5c/0xb0)
[  203.500000] [<c00bee1c>] (__rt_mutex_delete+0x0/0xb0) from [<c00a4450>] (hisyscall_event+0x198/0x35c)
[  203.500000]  r5:c49ce010 r4:c3c95fb0
[  203.500000] [<c00a42b8>] (hisyscall_event+0x0/0x35c) from [<c006c0c8>] (ipipe_syscall_hook+0x40/0x50)
[  203.500000] [<c006c088>] (ipipe_syscall_hook+0x0/0x50) from [<c0068608>] (__ipipe_notify_syscall+0xa8/0x164)
[  203.500000] [<c0068560>] (__ipipe_notify_syscall+0x0/0x164) from [<c00100b8>] (__ipipe_syscall_root+0x84/0x150)
[  203.500000] [<c0010034>] (__ipipe_syscall_root+0x0/0x150) from [<c0009a14>] (vector_swi+0x74/0x8c)
[  203.500000]  r7:000f0042 r6:00000000 r5:00000000 r4:21f6cc97
[  203.500000] Code: e24cb004 e52de004 ebfdd939 e5903060 (e5932000) 
[  203.780000] ---[ end trace 672b7e523f922a3f ]---
[

> 
> Regards.
> 



-- 
                                                                Gilles.

