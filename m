From: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>
Date: Tue, 29 Sep 2015 15:35:45 +0000
Message-ID: <B89CCBE86D4F62448EE4F6367C6D3C89221E32ED@USMLVA0EM24MSX.ww017.siemens.net>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Everyone,

I am noticing a delay of around 1ms from the time I get an interrupt and the time when the user space irq handler task is invoked by Xenomai. Would highly appreciate any suggestions that will help me resolve the issue. Details follow:

System config:
Xenomai: 2.6.4
Linux: 3.14
Processor: MPC8360E (powerpc)

I have a user space task(Task name: 00000193, pid: 30896(ipipe trace)) doing an rt_intr_wait on int 42(2a).

The ipipe trace is attached to the email. Am posting my interpretation of the trace below. It indicates that after the occurance of the int, the previously executing task continues execution before the int handling task gets scheduled:

Occurance of hw interrupt 42(2a)
:|  +*begin   0x00000021 -1178    0.666  __ipipe_grab_irq+0x40 (__ipipe_ret_from_except+0x0)
:|  +*func               -1178    0.878  __ipipe_dispatch_irq+0x8 (__ipipe_grab_irq+0x50)
:|  +*func               -1177+   1.787  irq_to_desc+0x8 (__ipipe_dispatch_irq+0xec)
:|  +*func               -1175+   1.712  irq_to_desc+0x8 (__ipipe_dispatch_irq+0xfc)
:|  +*func               -1173+   1.712  qe_ic_get_low_irq+0x8 (qe_ic_cascade_low_ipic+0x1c)
:|  +*begin   0x0000002a -1172    0.500  qe_ic_cascade_low_ipic+0x28 (__ipipe_dispatch_irq+0x94)
:|  +*func               -1171    0.696  __ipipe_dispatch_irq+0x8 (qe_ic_cascade_low_ipic+0x34)
:|  +*func               -1171    0.727  irq_to_desc+0x8 (__ipipe_dispatch_irq+0xec)
:|  +*func               -1170+   1.242  irq_to_desc+0x8 (__ipipe_dispatch_irq+0xfc)
:|  +*func               -1169+   1.212  __ipipe_ack_level_irq+0x8 (__ipipe_dispatch_irq+0x94)
:|  +*func               -1167    0.924  qe_ic_mask_irq+0x8 (__ipipe_ack_level_irq+0x40)
:|  +*func               -1167+   1.500  __ipipe_spin_lock_irqsave+0x8 (qe_ic_mask_irq+0x3c)
:|  #*func               -1165+   1.636  __ipipe_spin_unlock_irqrestore+0x8 (qe_ic_mask_irq+0x94)
:|  +*func               -1163    0.909  __ipipe_set_irq_pending+0x8 (__ipipe_dispatch_irq+0x314)
:|  +*end     0x0000002a -1163    0.742  qe_ic_cascade_low_ipic+0x3c (__ipipe_dispatch_irq+0x94)
:|  +*func               -1162+   1.606  __ipipe_do_sync_stage+0x8 (__ipipe_dispatch_irq+0x2f0)
:|  #*func               -1160+   2.333  xnintr_irq_handler+0x8 (__ipipe_do_sync_stage+0x150)
:|  #*func               -1158+   1.318  rt_intr_handler+0x8 [xeno_native] (xnintr_irq_handler+0x150)
:|  #*func               -1157+   2.606  xnsynch_flush+0x8 (rt_intr_handler+0x48 [xeno_native])
:|  #*func               -1154+   1.530  xnpod_resume_thread+0x8 (xnsynch_flush+0x170)
:|  #*[30896] -<?>-  257 -1153+   4.606  xnpod_resume_thread+0x134 (xnsynch_flush+0x170)                <- Correct irq handler task identified for resuming
:|  +*end     0x00000021 -1148    0.636  __ipipe_grab_irq+0x58 (__ipipe_ret_from_except+0x0)
:|  +*func               -1147+   1.712  __ipipe_exit_irq+0x8 (__ipipe_grab_irq+0x60)


The previously executing thread continues execution for 1076 us:
:   +*func               -1145    0.833  rt_task_set_mode+0x8 [xeno_native] (__rt_task_set_mode+0x40 [xeno_native])
:   +*func               -1144    0.666  xnpod_set_thread_mode+0x8 (rt_task_set_mode+0x90 [xeno_native])
:|  +*begin   0x80000000 -1144+   1.181  xnpod_set_thread_mode+0x408 (rt_task_set_mode+0x90 [xeno_native])
:|  #*func               -1142    0.666  __ipipe_restore_head+0x8 (xnpod_set_thread_mode+0x3d8)
:|  +*end     0x80000000 -1142+   1.030  __ipipe_restore_head+0xa4 (xnpod_set_thread_mode+0x3d8)

1076 us later the scheduler kicks in to schedule int handling thread doing rt_intr_wait:
:|  +*begin   0x80000000  -118+   1.621  xnpod_suspend_thread+0x344 (rt_task_sleep+0x8c [xeno_native])
:|  #*func                -117+   1.090  xntimer_start_aperiodic+0x8 (xnpod_suspend_thread+0x2e8)
:|  #*func                -116+   7.378  xnarch_ns_to_tsc+0x8 (xntimer_start_aperiodic+0x258)
:|  #*func                -108+   1.500  __xnpod_schedule+0x8 (xnpod_suspend_thread+0x4fc)
:|  #*[30846] -<?>-   40  -107    0.954  __xnpod_schedule+0x150 (xnpod_suspend_thread+0x4fc)
:|  #*func                -106+   3.893  xnsched_pick_next+0x8 (__xnpod_schedule+0x2b4)
:|  #*[30896] -<?>-  257  -102+   1.227  __xnpod_schedule+0x4bc (xnpod_suspend_thread+0x4fc)
:|  #*func                -101+   3.151  xnarch_save_fpu.isra.23+0x8 (__xnpod_schedule+0x510)
:|  #*func                 -98+   6.151  xnarch_restore_fpu+0x8 (__xnpod_schedule+0x518)
:|  #*func                 -92    0.545  __ipipe_restore_head+0x8 (__rt_intr_wait+0x2b8 [xeno_native])
:|  +*end     0x80000000   -91+   2.833  __ipipe_restore_head+0xa4 (__rt_intr_wait+0x2b8 [xeno_native])
:|  +*begin   0x80000001   -88    0.833  __ipipe_notify_syscall+0x144 (pipeline_syscall+0x8)
:|  +*end     0x80000001   -87+   3.181  __ipipe_notify_syscall+0x1b0 (pipeline_syscall+0x8)
:   +*func                 -84    0.560  __ipipe_notify_syscall+0x8 (pipeline_syscall+0x8)
:|  +*begin   0x80000001   -84    0.590  __ipipe_notify_syscall+0x1dc (pipeline_syscall+0x8)
:|  +*end     0x80000001   -83    0.515  __ipipe_notify_syscall+0x110 (pipeline_syscall+0x8)
:   +*func                 -83    0.757  ipipe_syscall_hook+0x8 (__ipipe_notify_syscall+0x120)

...
:   +*func                 -10    0.651  ipipe_syscall_hook+0x8 (__ipipe_notify_syscall+0x120)
:   +*func                  -9+   1.606  hisyscall_event+0x8 (ipipe_syscall_hook+0x48)
:   +*func                  -8+   1.530  xnshadow_sys_trace+0x8 (hisyscall_event+0x19c)
:   +*func                  -6    0.803  ipipe_trace_frozen_reset+0x8 (xnshadow_sys_trace+0x194)


A scheduling delay of close to 1ms seems too high and our application cannot work properly.

Can you please advice on how I can get my user space int handling task to execute immediately after getting the HW int?

Thanks for taking time to ponder on the problem.

Kind Rgds,
Makarand.


This message and any attachments are solely for the use of intended recipients. The information contained herein may include trade secrets, protected health or personal information, privileged or otherwise confidential information. Unauthorized review, forwarding, printing, copying, distributing, or using such information is strictly prohibited and may be unlawful. If you are not an intended recipient, you are hereby notified that you received this email in error, and that any review, dissemination, distribution or copying of this email and any attachment is strictly prohibited. If you have received this email in error, please contact the sender and delete the message and any attachment from your system. Thank you for your cooperation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: frozen
Type: application/octet-stream
Size: 3246228 bytes
Desc: frozen
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150929/bc44dc8c/attachment.obj>
