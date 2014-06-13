From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 13 Jun 2014 14:15:57 -0400
Message-ID: <20140613181557.GN17765@csclub.uwaterloo.ca>
References: <20140402134133.GH17765@csclub.uwaterloo.ca>
 <20140402134609.GI17765@csclub.uwaterloo.ca>
 <533C1709.3090305@xenomai.org>
 <20140402143809.GJ17765@csclub.uwaterloo.ca>
 <533C21A0.30502@xenomai.org>
 <20140403134647.GL17765@csclub.uwaterloo.ca>
 <533D688A.7050609@xenomai.org>
 <20140403141635.GM17765@csclub.uwaterloo.ca>
 <20140414210638.GI17765@csclub.uwaterloo.ca>
 <534D1A74.7010906@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534D1A74.7010906@xenomai.org>
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

On Tue, Apr 15, 2014 at 01:39:32PM +0200, Gilles Chanteperdrix wrote:
> On 04/14/2014 11:06 PM, Lennart Sorensen wrote:
> > On Thu, Apr 03, 2014 at 10:16:35AM -0400, Lennart Sorensen wrote:
> >> On Thu, Apr 03, 2014 at 03:56:26PM +0200, Gilles Chanteperdrix wrote:
> >>> On 04/03/2014 03:46 PM, Lennart Sorensen wrote:
> >>>> Load script terminated, terminating checked scripts
> >>>> ---|-----------|-----------|-----------|--------|------|-------------------------
> >>>> RTS|     -1.140|      2.280|     10.811|       0|     0|    18:21:26/18:21:26
> >>>> RTD|           0|         795|    63498250
> >>>> RTD|           0|        4654|  1051007408
> >>>> RTD|           1|       14862|  1064936835
> >>>> RTD|           1|         134|    63457021
> >>>> pipe_in: /tmp/xeno-test-in-9751
> >>>>
> >>>> I am guessing that looks successful.
> >>>
> >>> Yes, I guess a 15us worst case interrupt latency is unprecedented
> >>> for the ARM architecture. The timer anticipation may be a bit too
> >>> eager for this SOC, which results in negative latencies. What does
> >>> cat /proc/xenomai/timer say?
> >>
> >> root@omap5:~# cat /proc/xenomai/timer
> >> status=on+watchdog:setup=488:clock=3556147959244:timerdev=arch_sys_timer:clockdev=ipipe_tsc
> > 
> > Any more info on this?
> > 
> > The negative minimum latency seems a bit odd after all.
> > 
> No, it is a bit strange, since the anticipation is 488ns, the negative
> latency should be less than twice that. Unfortunately, I can not
> reproduce this issue easily. What you could try is to change the way the
> timer setup time is calculated, and use the average value, instead of
> average + std deviation.

Well I still haven't maanged to figure this out.

I do have a question though.  Any idea what this means:

[4976920.784397] Brought up 2 CPUs
[4976920.784413] SMP: Total of 2 processors activated.
[4976920.784421] CPU: All CPU(s) started in SVC mode.
[4976920.784888] 
[4976920.784897] =================================
[4976920.784903] [ INFO: inconsistent lock state ]
[4976920.784911] 3.12-1-dra7xx #1 Not tainted
[4976920.784918] ---------------------------------
[4976920.784925] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[4976920.784934] swapper/0/0 [HC0[0]:SC0[0]:HE1:SE1] takes:
[4976920.784941]  (std_spinlock_raw(&rq->lock)){?.....}, at: [<c042d100>] __schedule+0x554/0x80c
[4976920.784975] {IN-HARDIRQ-W} state was registered at:
[4976920.784982]   [<c009ab8c>] __lock_acquire+0xac4/0x1bb0
[4976920.784999]   [<c009c1e8>] lock_acquire+0x94/0x13c
[4976920.785012]   [<c042e700>] _raw_spin_lock+0x38/0x48
[4976920.785025]   [<c006e7a8>] scheduler_tick+0x2c/0xb4
[4976920.785038]   [<c004dfa8>] update_process_times+0x5c/0x68
[4976920.785051]   [<c00938b4>] tick_periodic+0x38/0xb4
[4976920.785063]   [<c0093a40>] tick_handle_periodic+0x18/0x7c
[4976920.785075]   [<c034b4ec>] arch_timer_handler_virt+0x64/0x80
[4976920.785088]   [<c0087c70>] handle_percpu_devid_irq+0x84/0x1e0
[4976920.785100]   [<c0084c6c>] generic_handle_irq+0x20/0x30
[4976920.785113]   [<c000f57c>] handle_IRQ+0x5c/0xd0
[4976920.785127]   [<c00c2890>] __ipipe_do_sync_stage+0x2e4/0x300
[4976920.785140]   [<c0008678>] __ipipe_grab_irq+0x48/0x8c
[4976920.785151]   [<c0008988>] gic_handle_irq+0x28/0x5c
[4976920.785161]   [<c042f504>] __irq_svc+0x44/0x70
[4976920.785174]   [<c00c2aa0>] ipipe_unstall_root+0x44/0x5c
[4976920.785186]   [<c063c9a0>] start_kernel+0x1fc/0x2dc
[4976920.785200]   [<80008074>] 0x80008074
[4976920.785212] irq event stamp: 29364
[4976920.785218] hardirqs last  enabled at (29363): [<c042eec4>] _raw_spin_unlock_irq+0x24/0x50
[4976920.785233] hardirqs last disabled at (29364): [<c042e7c8>] _raw_spin_lock_irqsave+0x1c/0x60
[4976920.785246] softirqs last  enabled at (29354): [<c0045ea4>] irq_enter+0x6c/0x70
[4976920.785258] softirqs last disabled at (29353): [<c0045e98>] irq_enter+0x60/0x70
[4976920.785270] 
[4976920.785270] other info that might help us debug this:
[4976920.785277]  Possible unsafe locking scenario:
[4976920.785277] 
[4976920.785285]        CPU0
[4976920.785290]        ----
[4976920.785296]   lock(std_spinlock_raw(&rq->lock));
[4976920.785309]   <Interrupt>
[4976920.785315]     lock(std_spinlock_raw(&rq->lock));
[4976920.785328] 
[4976920.785328]  *** DEADLOCK ***
[4976920.785328] 
[4976920.785338] 1 lock held by swapper/0/0:
[4976920.785344]  #0:  (std_spinlock_raw(&rq->lock)){?.....}, at: [<c042d100>] __schedule+0x554/0x80c
[4976920.785372] 
[4976920.785372] stack backtrace:
[4976920.785384] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.12-1-dra7xx #1 Debian 3.12.22-0.1RR2
[4976920.785403] [<c001612c>] (unwind_backtrace+0x0/0xf8) from [<c00126d8>] (show_stack+0x10/0x14)
[4976920.785417] [<c00126d8>] (show_stack+0x10/0x14) from [<c0429240>] (dump_stack+0x6c/0xac)
[4976920.785430] [<c0429240>] (dump_stack+0x6c/0xac) from [<c0426740>] (print_usage_bug+0x258/0x2c8)
[4976920.785443] [<c0426740>] (print_usage_bug+0x258/0x2c8) from [<c0099c90>] (mark_lock+0x290/0x6c8)
[4976920.785457] [<c0099c90>] (mark_lock+0x290/0x6c8) from [<c009ca54>] (mark_held_locks+0x60/0x138)
[4976920.785471] [<c009ca54>] (mark_held_locks+0x60/0x138) from [<c009cb9c>] (trace_hardirqs_on_caller+0x70/0x1c4)
[4976920.785485] [<c009cb9c>] (trace_hardirqs_on_caller+0x70/0x1c4) from [<c042f534>] (__ipipe_fast_svc_irq_exit+0x4/0x14)
[4976920.785503] [<c042f534>] (__ipipe_fast_svc_irq_exit+0x4/0x14) from [<c0019bbc>] (ipipe_test_and_stall_root+0x4/0x48)
[4976920.785517] [<c0019bbc>] (ipipe_test_and_stall_root+0x4/0x48) from [<c009bf60>] (lock_release+0x30/0x224)
[4976920.785531] [<c009bf60>] (lock_release+0x30/0x224) from [<c042ee58>] (_raw_spin_unlock_irqrestore+0x1c/0x64)
[4976920.785545] [<c042ee58>] (_raw_spin_unlock_irqrestore+0x1c/0x64) from [<c042d12c>] (__schedule+0x580/0x80c)
[4976920.785558] [<c042d12c>] (__schedule+0x580/0x80c) from [<c042d88c>] (schedule_preempt_disabled+0x14/0x20)
[4976920.785572] [<c042d88c>] (schedule_preempt_disabled+0x14/0x20) from [<c00849fc>] (cpu_startup_entry+0x1ec/0x23c)
[4976920.785586] [<c00849fc>] (cpu_startup_entry+0x1ec/0x23c) from [<c063ca3c>] (start_kernel+0x298/0x2dc)
[4976920.785597] [<c063ca3c>] (start_kernel+0x298/0x2dc) from [<80008074>] (0x80008074)
[4976920.905231] devtmpfs: initialized

We see that every boot.  Things seem to work fine afterwards, but it
sure looks wrong.

-- 
Len Sorensen

