MIME-Version: 1.0
In-Reply-To: <221d97aa3f1e31ccf35921da6a86e44c.squirrel@sourcetrek.com>
References: <CANWkrRN9Tyk7bzjdE1NOPA_otGf=Lyspo_CFb33SRgfN8++gYQ@mail.gmail.com>
 <221d97aa3f1e31ccf35921da6a86e44c.squirrel@sourcetrek.com>
From: Michael Smith <2michael.smith@gmail.com>
Date: Fri, 24 Jul 2015 10:38:44 +0200
Message-ID: <CANWkrRN7fFZEskVAJ9Jtkav3uCikEoCaui4RFEWz84aa=x9t7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] RTnet rtcfg thread creation issue (Xenomai 3.x)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Jul 21, 2015 at 4:17 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Michael Smith wrote:
>> Hi I require RTNet for a project I am working on.
>> Because of the previously reported rtcfg issue one of my RTNet nodes
>> does net run start up correctly as the master.
>> So I have spent some time in order to trace the issue in the code to find
>> a
>> solution, and have come up with a question and possible corrections on
>> the existing code.
>>
>> I have used Xenomai-3.0 rc5 as my code base.
>> The symptoms on my system is that when running the RTNet script and
>> setting up the system as
>> a master the whole system locks up completely. I have traced this to
>> the line in the RTNet script
>> where the master is setup -> $RTCFG rteth0 server
>> Then it traced the lockup to
>> kernel/drivers/net/stack/rtcfg/rtcfg_event.c:151
>> This is in function rtcfg_main_state_off() where the rtdm_task_init()
>> is called. This thread creation
>> call completely locks up the system.
>>
>> I checked all the parameters in the call, and one parameter that was
>> incorrect was the pointer to function  void rtcfg_timer(int ifindex)
>> in kernel/drivers/net/stack/rtcfg/rtcfg_timer.c:35.
>> According to the declaration of rtdm_task_init() its parameter
>> task_proc is of type rtdm_task_proc_t which is declared as typedef
>> void(* rtdm_task_proc_t) (void *arg). So I assume the correct function
>> declaration in rtcfg_timer.c should rather be void rtcfg_timer(void *arg).
>>
>> Changing this in the code didn't correct the problem. But then I had a
>> look in the documentation and it specifies that rtdm_task_init()
>> should be called in secondary mode only. I have placed a
>> rtdm_in_rt_context() call before the rtdm_task_init() call and it
>> reports that the context that the
>> thread is running in just before calling the rtdm_task_init() is primary
>> mode.
>> My question is would this cause a lockup if you are trying to call
>> rtdm_task_init() in primary mode?
>
> Yes, calling any Linux service from primary mode may create any kind of
> problems. But that should be easily detected by enabling I-pipe context
> debugging.
>

I have enabled the ipipe debugging and added a xntrace_user_freeze(0,0)
call just before the rtdm_task_init() call that hangs the system.
The output I get is the following:.
I have included the log from where the ioctl is entered in the rtcfg
module, up to the freeze.
I'm not shure what to look for to find out if the thread went into
primary mode or not before calling
the  rtdm_task_init().
Could you maybe point me in a direction on what to look for?


:    +func                 -17    0.322  rtcfg_ioctl+0x0 [rtcfg]
(rtnet_ioctl+0x114 [rtnet])
:    +func                 -17    0.114  rtnet_rtpc_dispatch_call+0x0
[rtnet] (rtcfg_ioctl+0x175 [rtcfg])
:    +func                 -17    0.113  __kmalloc+0x0
(rtnet_rtpc_dispatch_call+0x38 [rtnet])
:    +func                 -17    0.116  kmalloc_slab+0x0 (__kmalloc+0x2e)
:    +func                 -17    0.105  ipipe_root_only+0x0 (__kmalloc+0x55)
:|   +begin   0x80000001   -17    0.130  ipipe_root_only+0xa3 (__kmalloc+0x55)
:|   +end     0x80000001   -17    0.103  ipipe_trace_end+0x19
(ipipe_root_only+0x86)
:    +func                 -16    0.167  _cond_resched+0x0 (__kmalloc+0x5a)
:    +func                 -16    0.144  __init_waitqueue_head+0x0
(rtnet_rtpc_dispatch_call+0x95 [rtnet])
:|   +begin   0x80000000   -16    0.233
rtnet_rtpc_dispatch_call+0x27b [rtnet] (rtcfg_ioctl+0x175 [rtcfg])
:|  *+func                 -16    0.170  ___xnsched_lock+0x0
(rtnet_rtpc_dispatch_call+0x102 [rtnet])
:|  *+func                 -16    0.148  ___xnsched_unlock+0x0
(rtnet_rtpc_dispatch_call+0x137 [rtnet])
:|  *+func                 -16    0.121  __ipipe_restore_head+0x0
(rtnet_rtpc_dispatch_call+0x289 [rtnet])
:|   +end     0x80000000   -15    0.120  ipipe_trace_end+0x19
(__ipipe_restore_head+0x6c)
:    +func                 -15    0.112  rtdm_event_signal+0x0
(rtnet_rtpc_dispatch_call+0x17e [rtnet])
:|   +begin   0x80000000   -15    0.167  rtdm_event_signal+0x30
(rtnet_rtpc_dispatch_call+0x17e [rtnet])
:|  *+func                 -15    0.116
xnlock_dbg_prepare_acquire+0x0 (rtdm_event_signal+0x1b9)
:|  *+func                 -15    0.110  xnlock_dbg_acquired+0x0
(rtdm_event_signal+0x201)
:|  *+func                 -15    0.320  xnsynch_flush+0x0
(rtdm_event_signal+0x92)
:|  *+func                 -15    0.283  xnthread_resume+0x0
(xnsynch_flush+0xfa)
:|  *+[  375] rtnet-rt 0   -14    0.432  xnthread_resume+0xaa
(xnsynch_flush+0xfa)
:|  *+func                 -14    0.169  __xnsched_run+0x0
(rtdm_event_signal+0x215)
:|  *+func                 -14    0.230  xnarch_escalate+0x0
(__xnsched_run+0x1e)
:|  *+func                 -13    0.105  ipipe_raise_irq+0x0
(xnarch_escalate+0x7b)
:|  *+func                 -13    0.175  __ipipe_handle_irq+0x0
(ipipe_raise_irq+0x3b)
:|  *+func                 -13    0.521  __ipipe_dispatch_irq+0x0
(__ipipe_handle_irq+0x8d)
:|  *+func                 -13    0.260  __ipipe_set_irq_pending+0x0
(__ipipe_dispatch_irq+0x564)
:|  *+func                 -12    0.148  xnlock_dbg_release+0x0
(rtdm_event_signal+0x15e)
:|  *+func                 -12    0.183  __ipipe_restore_head+0x0
(rtdm_event_signal+0x11c)
:|   +func                 -12    0.187  __ipipe_do_sync_pipeline+0x0
(__ipipe_sync_pipeline+0x38)
:|  + func                 -12    0.312  __ipipe_do_sync_stage+0x0
(__ipipe_do_sync_pipeline+0x97)
:|  # func                 -12    0.113  __xnsched_run_handler+0x0
(__ipipe_do_sync_stage+0x101)
:|  # func                 -11    0.096  __xnsched_run+0x0
(__xnsched_run_handler+0x85)
:|  # func                 -11    0.169  xnarch_escalate+0x0
(__xnsched_run+0x1e)
:|  # func                 -11    0.112
xnlock_dbg_prepare_acquire+0x0 (__xnsched_run+0x1f9)
:|  # func                 -11    0.099  xnlock_dbg_acquired+0x0
(__xnsched_run+0x244)
:|  # [ 3109] -<?>-   -1   -11    0.219  __xnsched_run+0xcf
(__xnsched_run_handler+0x85)
:|  # func                 -11    0.398  xnsched_pick_next+0x0
(__xnsched_run+0x258)
:|  # func                 -10    0.530
__ipipe_notify_vm_preemption+0x0 (__xnsched_run+0x44d)
:|  # func                 -10    0.281  xnarch_leave_root+0x0
(__xnsched_run+0x48f)
:|  # func                  -9    0.966  xnarch_switch_to+0x0
(__xnsched_run+0x30d)
:|  # func                  -9    0.120  xnthread_switch_fpu+0x0
(__xnsched_run+0x39e)
:|  # [  375] rtnet-rt 0    -8    0.612  __xnsched_run+0x3bb
(xnthread_suspend+0x435)
:|  # func                  -8    0.153  xnlock_dbg_release+0x0
(rtdm_event_timedwait+0x1df)
:|  # func                  -8    0.110  __ipipe_restore_head+0x0
(rtdm_event_timedwait+0x17d)
:|  + end     0x80000000    -8    0.317  ipipe_trace_end+0x19
(__ipipe_restore_head+0x6c)
:|  + begin   0x80000000    -7    0.158  rtpc_dispatch_handler+0x62
[rtnet] (kthread_trampoline+0x68)
:|  # func                  -7    0.105  ___xnsched_lock+0x0
(rtpc_dispatch_handler+0xba [rtnet])
:|  # func                  -7    0.139  ___xnsched_unlock+0x0
(rtpc_dispatch_handler+0x110 [rtnet])
:|  # func                  -7    0.114  __ipipe_restore_head+0x0
(rtpc_dispatch_handler+0x147 [rtnet])
:|  + end     0x80000000    -7    0.194  ipipe_trace_end+0x19
(__ipipe_restore_head+0x6c)
:   + func                  -7    0.197  rtcfg_event_handler+0x0
[rtcfg] (rtpc_dispatch_handler+0x157 [rtnet])
:   + func                  -6    0.178  rtcfg_do_main_event+0x0
[rtcfg] (rtcfg_event_handler+0x1d [rtcfg])
:   + func                  -6    0.163  rtdm_mutex_lock+0x0
(rtcfg_do_main_event+0x34 [rtcfg])
:   + func                  -6    0.193  rtdm_mutex_timedlock+0x0
(rtdm_mutex_lock+0x12)
:|  + begin   0x80000000    -6    0.127  rtdm_mutex_timedlock+0xb0
(rtdm_mutex_lock+0x12)
:|  # func                  -6    0.104
xnlock_dbg_prepare_acquire+0x0 (rtdm_mutex_timedlock+0x1fc)
:|  # func                  -6    0.259  xnlock_dbg_acquired+0x0
(rtdm_mutex_timedlock+0x246)
:|  # func                  -5    0.278  xnsynch_try_acquire+0x0
(rtdm_mutex_timedlock+0x111)
:|  # func                  -5    0.156  xnlock_dbg_release+0x0
(rtdm_mutex_timedlock+0x1cf)
:|  # func                  -5    0.110  __ipipe_restore_head+0x0
(rtdm_mutex_timedlock+0x16e)
:|  + end     0x80000000    -5    0.181  ipipe_trace_end+0x19
(__ipipe_restore_head+0x6c)
:   + func                  -5    0.108  printk+0x0
(rtcfg_do_main_event+0x88 [rtcfg])
:|  + begin   0x80000001    -4    0.229  printk+0x66
(rtcfg_do_main_event+0x88 [rtcfg])
:|  + end     0x80000001    -4    0.139  ipipe_trace_end+0x19 (printk+0x15c)
:   + func                  -4    0.113  __ipipe_spin_lock_irqsave+0x0
(printk+0x199)
:|  + begin   0x80000001    -4+   1.486
__ipipe_spin_lock_irqsave+0x8b (printk+0x199)
:|  # func                  -2    0.110
__ipipe_spin_unlock_irqrestore+0x0 (printk+0x1e0)
:|  + end     0x80000001    -2    0.104  ipipe_trace_end+0x19
(__ipipe_spin_unlock_irqrestore+0x39)
:   + func                  -2    0.110  ipipe_raise_irq+0x0 (printk+0x1ef)
:|  + begin   0x80000001    -2    0.112  ipipe_raise_irq+0x5b (printk+0x1ef)
:|  + func                  -2    0.136  __ipipe_handle_irq+0x0
(ipipe_raise_irq+0x7a)
:|  + func                  -2    0.499  __ipipe_dispatch_irq+0x0
(__ipipe_handle_irq+0x8d)
:|  + func                  -1    0.339  __ipipe_set_irq_pending+0x0
(__ipipe_dispatch_irq+0x216)
:|  + end     0x80000001    -1    0.188  ipipe_trace_end+0x19
(ipipe_raise_irq+0x84)
:   + func                  -1    0.134  rtcfg_main_state_off+0x0
[rtcfg] (rtcfg_do_main_event+0x54 [rtcfg])
:   + func                  -1    0.109  ipipe_trace_frozen_reset+0x0
(rtcfg_main_state_off+0xfe [rtcfg])
:   + func                  -1    0.104  __ipipe_global_path_lock+0x0
(ipipe_trace_frozen_reset+0x23)
:   + func                  -1    0.103  __ipipe_spin_lock_irqsave+0x0
(__ipipe_global_path_lock+0x15)
:|  + begin   0x80000001     0    0.652
__ipipe_spin_lock_irqsave+0x8b (__ipipe_global_path_lock+0x15)
:|  # func                   0    0.148
__ipipe_spin_unlock_irqcomplete+0x0 (__ipipe_global_path_unlock+0x77)
:|  + end     0x80000001     0    0.116  ipipe_trace_end+0x19
(__ipipe_spin_unlock_irqcomplete+0x35)
<   + freeze  0x00000000     0    0.152  rtcfg_main_state_off+0x105
[rtcfg] (rtcfg_do_main_event+0x54 [rtcfg])

Thanks
Michael



>> All the other parameters to the function seems fine, and I see no
>> memory pointer or other issues that will cause this behavior.
>>
>> I also found another issue in the code through my tracing process.
>> kernel/drivers/net/stack/rtnet_rtpc.c:94 - 99. If the kmalloc fails
>> and returns a NULL.
>> The cleanup handler is called as part of the exit process. But the
>> pointer used to call that cleanup
>> code is NULL because of the failed kmalloc. So when the if() condition
>> is tested to see if the cleanup handler exists, it will probably cause
>> a segmentation fault.
>
> Indeed, this is pretty silly code, this will be fixed.
>
>>
>> Regards
>> Michael
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://xenomai.org/mailman/listinfo/xenomai
>>
>
>
> --
>                                             Gilles.
> https://click-hack.org
>

