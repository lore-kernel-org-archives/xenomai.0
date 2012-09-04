Message-ID: <504621AB.3000402@xenomai.org>
Date: Tue, 04 Sep 2012 17:43:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50461A66.6070805@ruggedcom.com>
In-Reply-To: <50461A66.6070805@ruggedcom.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Powepc 8360 interrupt timing question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Makarand Pradhan <makarandpradhan@ruggedcom.com>
Cc: xenomai@xenomai.org

On 09/04/2012 05:12 PM, Makarand Pradhan wrote:
>  Hi All,
> 
> I am doing real time measurements to determine the time required to
> process an interrupt. The interrupt is being handled in  user space.
> rt_intr_wait is used to wait for the interrupt in a xenomai thread. The
> system is a powepc 8360 running linux 3.0, Xenomai 2.6.

- which I-pipe version exactly? Seven different patches were released
for 3.0.x/powerpc over time.

- which Xenomai release? 2.6.0, 2.6.1, current HEAD?

> 
> The ipipe trace indicates that it takes roughly 60 micro seconds for the
> user space handler to run, after the occurrence of an interrupt. Without
> tracing it roughly takes somewhere between 30 - 50 micro seconds.
> 
> I'm not sure if this time is ok for an 8360 or is it too high? Would

It's way over the top.

> highly appreciate comments on the timings.
>

You seem to be rehashing an old question. The answer at that time was:

- there was an issue with processing cascaded interrupts in the former
pipeline architecture. This has been solved in recent patches with the
introduction of the pipeline "core" series (core-3.2 and above, commit
a4b909ccf80c5a).

- handling level IRQs in userland is generally a bad idea.

> The ipipe trace is given below for reference.
> 
> Warm Rgds,
> Makarand.
> 
> *Occurance of int.*
> :|  + func                -120+   1.560  ipic_get_irq+0x8
> (__ipipe_grab_irq+0x34) **
> :|  + func                -118+   1.545  irq_linear_revmap+0x8
> (ipic_get_irq+0x64)
> :|  + begin   0x00000021  -117    0.893  __ipipe_grab_irq+0x48
> (__ipipe_ret_from_except+0x0)
> :|  + func                -116+   1.878  __ipipe_handle_irq+0x8
> (__ipipe_grab_irq+0x54)
> :|  + func                -114+   1.712  __ipipe_set_irq_pending+0x8
> (__ipipe_handle_irq+0x150)
> :|  + func                -112    0.878  __ipipe_ack_irq+0x8
> (__ipipe_handle_irq+0x178)
> :|  + func                -112+   1.242  qe_ic_cascade_low_ipic+0x8
> (__ipipe_ack_irq+0x2c)
> :|  + func                -110    0.969  qe_ic_get_low_irq+0x8
> (qe_ic_cascade_low_ipic+0x2c)
> :|  + func                -109    0.742  irq_linear_revmap+0x8
> (qe_ic_get_low_irq+0x5c)
> :|  + func                -109    0.606  __ipipe_qe_ic_cascade_irq+0x8
> (qe_ic_cascade_low_ipic+0x3c)
> :|  + begin   0x0000002b  -108    0.651  __ipipe_qe_ic_cascade_irq+0x2c
> (qe_ic_cascade_low_ipic+0x3c)
> :|  + func                -107+   1.015  __ipipe_handle_irq+0x8
> (__ipipe_qe_ic_cascade_irq+0x38)
> :|  + func                -106+   1.121  __ipipe_ack_level_irq+0x8
> (__ipipe_handle_irq+0xbc)
> :|  + func                -105+   1.045  qe_ic_mask_irq+0x8
> (__ipipe_ack_level_irq+0x40)
> :|  + func                -104    0.954  irqd_to_hwirq+0x8
> (qe_ic_mask_irq+0x2c)
> :|  + func                -103+   1.878  __ipipe_spin_lock_irqsave+0x8
> (qe_ic_mask_irq+0x40)
> :|  # func                -101+   1.909 
> __ipipe_spin_unlock_irqrestore+0x8 (qe_ic_mask_irq+0x90)
> :|  + func                -100    0.606  __ipipe_dispatch_wired+0x8
> (__ipipe_handle_irq+0xc8)
> :|  + func                 -99    0.909 
> __ipipe_dispatch_wired_nocheck+0x8 (__ipipe_dispatch_wired+0x48)
> :|  # func                 -98+   1.469  xnintr_irq_handler+0x8
> (__ipipe_dispatch_wired_nocheck+0x84)
> :|  # func                 -97+   1.469  rt_intr_handler+0x8
> [xeno_native] (xnintr_irq_handler+0x84)
> :|  # func                 -95+   1.954  xnsynch_flush+0x8
> (rt_intr_handler+0x48 [xeno_native])
> :|  # func                 -93+   2.287  xnpod_resume_thread+0x8
> (xnsynch_flush+0xc0)
> :|  # [10455] -<?>-  257   -91+   1.409  xnpod_resume_thread+0x6c
> (xnsynch_flush+0xc0)
> :|  # func                 -90    0.727  xnsched_rt_enqueue+0x8
> (xnpod_resume_thread+0xa8)
> :|  # func                 -89+   3.439  addmlq+0x8
> (xnsched_rt_enqueue+0x44)
> :|  # func                 -86+   1.045  __xnpod_schedule+0x8
> (xnintr_irq_handler+0x1f8)
> :|  # [10520] -<?>-   86   -85+   1.015  __xnpod_schedule+0x80
> (xnintr_irq_handler+0x1f8)
> :|  # func                 -84    1.000  xnsched_pick_next+0x8
> (__xnpod_schedule+0xdc)
> :|  # func                 -83+   1.045  xnsched_rt_requeue+0x8
> (xnsched_pick_next+0xb8)
> :|  # func                 -82+   1.636  addmlq+0x8
> (xnsched_rt_requeue+0x44)
> :|  # func                 -80+   1.242  xnsched_tp_pick+0x8
> (xnsched_pick_next+0x74)
> :|  # func                 -79    0.681  xnsched_sporadic_pick+0x8
> (xnsched_pick_next+0x74)
> :|  # func                 -78+   6.666  getmlq+0x8
> (xnsched_sporadic_pick+0x30)
> :|  # [10455] -<?>-  257   -71+   1.393  __xnpod_schedule+0x2d8
> (xnpod_suspend_thread+0x29c)
> :|  # func                 -70+   8.227  xnarch_save_fpu+0x8
> (__xnpod_schedule+0x328)
> 
> *Xeno thread woken up in user space*
> :|  # func                 -62    0.469 
> __ipipe_restore_pipeline_head+0x8 (__rt_intr_wait+0x12c [xeno_native])
> :|  + end     0x80000000   -61+   3.045 
> __ipipe_restore_pipeline_head+0x90 (__rt_intr_wait+0x12c [xeno_native])
> :|  + begin   0x80000001   -58    0.727  __ipipe_dispatch_event+0x1ec
> (__ipipe_syscall_root+0x6c)
> :|  + end     0x80000001   -58    0.787  __ipipe_dispatch_event+0x244
> (__ipipe_syscall_root+0x6c)
> :|  + begin   0x80000000   -57    0.666  __ipipe_syscall_root+0xfc
> (DoSyscall+0x20)
> :|  + end     0x80000000   -56+   9.681  __ipipe_syscall_root+0x108
> (DoSyscall+0x20)
> :   + func                 -47    0.742  __ipipe_syscall_root+0x8
> (DoSyscall+0x20)
> :   + func                 -46    0.606  __ipipe_dispatch_event+0x8
> (__ipipe_syscall_root+0x6c)
> :|  + begin   0x80000001   -45    0.969  __ipipe_dispatch_event+0x274
> (__ipipe_syscall_root+0x6c)
> :|  + end     0x80000001   -45    0.757  __ipipe_dispatch_event+0x1ac
> (__ipipe_syscall_root+0x6c)
> :   + func                 -44    0.893  hisyscall_event+0x8
> (__ipipe_dispatch_event+0x1c4)
> 
> 
> *The first call in the int handler.*
> :   + func                 -43    0.666  __rt_task_set_mode+0x8
> [xeno_native] (hisyscall_event+0x1e4)
> :   + func                 -42    0.772  rt_task_set_mode+0x8
> [xeno_native] (__rt_task_set_mode+0x50 [xeno_native])
> 


-- 
Philippe.

