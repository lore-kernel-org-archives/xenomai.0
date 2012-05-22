Message-ID: <4FBADE7D.5030609@bbn.com>
Date: Mon, 21 May 2012 20:31:57 -0400
From: Mitchell Tasman <tasman@bbn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] A possible mis-interaction between CONFIG_PREEMPT and
 GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi.  I'm running an OMAP DM3725-based board with a 2.6.38.8 kernel, a 
mid-May 2012 git snapshot of xenomai-2.6, and a backport (really just 
application) of the patch that Gilles referenced in the "IRQ latency" 
thread last week:

http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=81bfc05c4716b76e79f5e486baf4c52015a3b92c

Of perhaps critical note is that I'm building Linux with CONFIG_PREEMPT. 
  The possible problem that I'm about to describe appears specific to 
CONFIG_PREEMPT being defined.  To date, I have not been able to trigger 
the problem if I rebuild the kernel with CONFIG_NONE.

Almost exactly as with last week's "IRQ latency" thread, I have a GPIO 
(164 in my case) configured as an input, and configured to trigger a 
real-time interrupt upon a falling edge of the signal.  The virtual 
interrupt number assigned by Xenomai for that GPIO is 324 (0x144 hex).

What I have found via I-Pipe tracing is that sometimes many, many 
milliseconds elapse within the call to __ipipe_handle_irq() from the 
inlined function ipipe_handle_chained_irq() in gpio_demux_inner(), e.g.:

> :|   +begin   0x00000144 -33547    0.925  gpio_demux_inner+0x74 (gpio_irq_handler+0x178)
> :|   +end     0x00000144  -196+   1.370  gpio_demux_inner+0x88 (gpio_irq_handler+0x178)

The present I-Pipe for 2.6.38.8 for ARM patch set patches the 
plat-omap-specific implementation of gpio_irq_handler() to 
unconditionally disable unmasking of the GPIO bank interrupt until just 
before that function returns.  So, if we somehow get "stuck" in 
gpio_demux_inner() for an extended period, the bank interrupt remains 
masked, and new GPIO line state transitions will go unhandled during 
that period.

I find that the GPIO interrupt is processed as would be expected, and 
any RT tasks that have work to do are scheduled to do that work.

What appears to be going awry is that when it becomes time to return to 
Linux domain, the I-Pipe machinery finds that there is an interrupt 
pending for that domain.  Rather than gpio_demux_inner() running to 
completion, and winding back to gpio_handle_irq(), the new interrupt is 
processed, and it can be many, many milliseconds before 
gpio_demux_inner() gets a chance to run and finish its work.

As it happens, my code is the source of that new (virtual) interrupt, 
and it's possible that I'm exercising a use case that hasn't been 
considered.  On the other hand, I could easily imagine other cases where 
interrupts happen to appear at arbitrary points along the timeline.

The sequence of events is as follows:

1. The interrupt fires while the system is running in the Linux domain, 
and the real-time interrupt handler for GPIO 164 calls rt_sem_v() to 
wake up a native Xenomai kernel task that is blocked on rt_sem_p().
I can see that from Xenomai's perspective, processing of the interrupt 
finishes just after that point, e.g. around -33527 in this sample:

> :|   +func               -33558    0.814  __ipipe_grab_irq+0x10 (__irq_svc+0x3c)
> :|   +begin   0xffffffff -33557    0.851  __ipipe_grab_irq+0x60 (__irq_svc+0x3c)
> :|   +func               -33556+   1.481  __ipipe_handle_irq+0x14 (__ipipe_grab_irq+0x6c)
> :|   +func               -33555+   1.037  __ipipe_set_irq_pending+0x10 (__ipipe_handle_irq+0x120)
> :|   +func               -33554    0.925  gpio_irq_handler+0x10 (__ipipe_handle_irq+0x150)
> :|   +func               -33553+   1.333  omap_mask_ack_irq+0x10 (gpio_irq_handler+0x2c)
> :|   +func               -33552    1.000  irq_get_irq_data+0x10 (gpio_irq_handler+0x34)
> :|   +(0x01)  0xfb058018 -33551+   1.777  gpio_irq_handler+0x1b0 (__ipipe_handle_irq+0x150) /* custom trace point */
> :|   +(0x02)  0x00000010 -33549    0.629  gpio_irq_handler+0x15c (__ipipe_handle_irq+0x150) /* custom trace point */
> :|   +func               -33548    0.740  gpio_demux_inner+0x10 (gpio_irq_handler+0x178)
> :|   +begin   0x00000144 -33547    0.925  gpio_demux_inner+0x74 (gpio_irq_handler+0x178)
> :|   +func               -33547    0.740  __ipipe_handle_irq+0x14 (gpio_demux_inner+0x80)
> :|   +func               -33546    0.925  __ipipe_set_irq_pending+0x10 (__ipipe_handle_irq+0x120)
> :|   +func               -33545    0.925  __ipipe_ack_edge_irq+0x10 (__ipipe_handle_irq+0x150)
> :|   +func               -33544    0.962  gpio_ack_irq+0x10 (__ipipe_ack_edge_irq+0x24)
> :|   +func               -33543+   1.444  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1a0)
> :|  + func               -33542    0.962  ipipe_suspend_domain+0x10 (__ipipe_walk_pipeline+0x68)
> :|  + func               -33541+   1.037  __ipipe_sync_stage+0x14 (ipipe_suspend_domain+0x9c)
> :|  # func               -33540+   1.592  xnintr_irq_handler+0x14 (__ipipe_sync_stage+0x124)
> :|  # func               -33538    1.000  my_isr_rt+0x10 [phy_srv] (xnintr_irq_handler+0x60)
/* do a bit of work */
> :|  # func               -33533    0.703  rt_sem_v+0x10 (physrv_htm_isr_rt+0x24 [phy_srv])
> :|  # func               -33532    1.000  xnsynch_wakeup_one_sleeper+0x10 (rt_sem_v+0x64)
> :|  # func               -33531    0.925  xnpod_resume_thread+0x10 (xnsynch_wakeup_one_sleeper+0xac)
> :|  # [   -1] -<?>-   60 -33530+   1.851  xnpod_resume_thread+0x64 (xnsynch_wakeup_one_sleeper+0xac)
> :|  # func               -33528+   1.222  rthal_irq_end+0x10 (xnintr_irq_handler+0x138)
> :|  # func               -33527+   1.333  __ipipe_end_edge_irq+0x10 (rthal_irq_end+0x3c)
> :|  # func               -33526+   1.037  __xnpod_schedule+0x14 (xnintr_irq_handler+0x1cc)
> :|  # [ 1633] -<?>-   -1 -33525    0.777  __xnpod_schedule+0x9c (xnintr_irq_handler+0x1cc)
> :|  # func               -33524+   1.555  xnsched_pick_next+0x10 (__xnpod_schedule+0xd4)
> :|  # func               -33523    0.888  ipipe_mute_pic+0x10 (__xnpod_schedule+0x17c)
> :|  # func               -33522+   2.111  omap3_intc_mute+0x10 (ipipe_mute_pic+0x1c)
> :|  # func               -33520    0.703  ipipe_unstall_pipeline_head+0x10 (__xnpod_schedule+0x2ac)
> :|  + end     0x80000000 -33519+   1.851  ipipe_unstall_pipeline_head+0x88 (__xnpod_schedule+0x2ac)


2.  That task that had been waiting on rt_sem_p() awakens and collects 
the data signaled by the GPIO transition, and in turn wakes up another 
native Xenomai kernel task via rt_sem_v().

3.  The second task invokes a write entry point on an RTDM driver.

4.  The RTDM driver may decide to place a copy of the data in a known 
location in kernel memory, and call rtdm_nrtsig_pend() to invoke a 
non-realtime handler in Linux kernel space.  This results in a virtual 
interrupt being generated for the Linux domain, e.g.:

> :   + func               -33238+   1.037  ipipe_trigger_irq+0x10 (my_write+0x84 [my_rtdm_driver])
> :|  + begin   0x80000001 -33237    0.925  ipipe_trigger_irq+0x74 (my_write+0x84 [my_rtdm_driver])
> :|  + func               -33236+   1.481  __ipipe_handle_irq+0x14 (ipipe_trigger_irq+0x80)
> :|  + func               -33235+   1.370  __ipipe_set_irq_pending+0x10 (__ipipe_handle_irq+0x120)
> :|  + end     0x80000001 -33233+   1.555  ipipe_trigger_irq+0x90 (my_write+0x84 [my_rtdm_driver])

5.  The non-realtime handler schedules a softint via tasklet_schedule()

6.  The tasklet retrieves the data posted by the real-time task.

My hope would be that steps 5 and 6 would only run after 
gpio_demux_inner() had a chance to unwind back to gpio_handle_irq(). 
Instead, upon transition back to the Linux domain, the new interrupt is 
processed instead, followed by the soft IRQ, and then Linux does various 
housekeeping tasks, here's an example snippet:

> :   + func               -33119    1.000  xnsched_finish_unlocked_switch+0x10 (__xnpod_schedule+0x4c0)
> :|  + begin   0x80000000 -33118+   1.037  xnsched_finish_unlocked_switch+0x30 (__xnpod_schedule+0x4c0)
> :|  # [ 1633] -<?>-   -1 -33116+   1.481  __xnpod_schedule+0x4e4 (xnintr_irq_handler+0x1cc)
> :|   +func               -33115+   1.222  __ipipe_sync_stage+0x14 (ipipe_suspend_domain+0x9c)
> :|   #end     0x80000000 -33114    0.851  __ipipe_sync_stage+0xf8 (ipipe_suspend_domain+0x9c)
> :    #func               -33113    0.666  __ipipe_do_IRQ+0x10 (__ipipe_sync_stage+0x1bc)
> :    #func               -33112+   1.111  asm_do_IRQ+0x10 (__ipipe_do_IRQ+0x1c)
> :    #func               -33111    0.851  irq_enter+0x10 (asm_do_IRQ+0x28)
> :    #func               -33110    0.925  rcu_exit_nohz+0x10 (irq_enter+0x18)
> :    #func               -33109+   1.407  idle_cpu+0x10 (irq_enter+0x20)
> :    #func               -33108    0.814  ipipe_check_context+0x10 (irq_enter+0x60)
> :    #func               -33107+   1.074  __ipipe_noack_irq+0x10 (asm_do_IRQ+0x84)
> :    #func               -33106    0.888  irq_exit+0x10 (asm_do_IRQ+0x88)
> :    #func               -33105+   1.111  ipipe_check_context+0x10 (irq_exit+0x1c)
> :    #func               -33104    1.000  rcu_enter_nohz+0x10 (irq_exit+0x60)
> :    #func               -33103    0.703  idle_cpu+0x10 (irq_exit+0x68)
> :    #func               -33102    0.740  ipipe_check_context+0x10 (irq_exit+0xa8)
> :|   #begin   0x80000000 -33102    0.888  __ipipe_sync_stage+0x1d4 (ipipe_suspend_domain+0x9c)
> :|   #end     0x80000000 -33101    0.592  __ipipe_sync_stage+0xf8 (ipipe_suspend_domain+0x9c)
> :    #func               -33100    0.888  irq_enter+0x10 (__ipipe_sync_stage+0x14c)
> :    #func               -33099    0.666  rcu_exit_nohz+0x10 (irq_enter+0x18)
> :    #func               -33099    0.629  idle_cpu+0x10 (irq_enter+0x20)
> :    #func               -33098+   1.148  ipipe_check_context+0x10 (irq_enter+0x60)
/* __tasklet_schedule */
...
> :    #func               -33091    0.592  __ipipe_restore_root+0x10 (__tasklet_schedule+0x12c)
> :    #func               -33090    0.962  ipipe_check_context+0x10 (__ipipe_restore_root+0x20)
> :|   #begin   0x80000001 -33089    0.666  __ipipe_restore_root+0x40 (__tasklet_schedule+0x12c)
> :|   #end     0x80000001 -33088    0.666  __ipipe_restore_root+0x60 (__tasklet_schedule+0x12c)
> :    #func               -33088    0.851  irq_exit+0x10 (__ipipe_sync_stage+0x168)
> :    #func               -33087    0.740  ipipe_check_context+0x10 (irq_exit+0x1c)
> :    #func               -33086+   1.111  __do_softirq+0x14 (irq_exit+0x5c)
...

We don't seem to get around to finishing gpio_demux_inner() until time -196.

> :|   +begin   0x80000000  -219+   1.481  schedule+0x5ac (schedule_timeout+0x2ec)
> :|   +func                -218    1.000  __ipipe_switch_to_notifier_call_chain+0x10 (__switch_to+0x2c)
> :|   #func                -217    0.666  atomic_notifier_call_chain+0x14 (__ipipe_switch_to_notifier_call_chain+0x6c)
> :|   #func                -216    0.629  __atomic_notifier_call_chain+0x14 (atomic_notifier_call_chain+0x28)
> :|   #func                -216    0.962  ipipe_check_context+0x10 (__atomic_notifier_call_chain+0x3c)
> :|   #func                -215    0.703  notifier_call_chain+0x10 (__atomic_notifier_call_chain+0x64)
> :|   #func                -214    0.851  vfp_notifier+0x10 (notifier_call_chain+0x3c)
> :|   #func                -213+   1.111  thumbee_notifier+0x10 (notifier_call_chain+0x3c)
> :|   #func                -212+   1.666  ipipe_check_context+0x10 (__atomic_notifier_call_chain+0x70
> :|   +end     0x80000000  -210+   1.111  schedule+0x5d4 (preempt_schedule_irq+0x64)
> :    +func                -209    0.666  finish_task_switch+0x10 (schedule+0x60c)
> :|   +begin   0x80000001  -209    0.703  finish_task_switch+0x40 (schedule+0x60c)
> :|   #end     0x80000001  -208    0.925  finish_task_switch+0x60 (schedule+0x60c)
> :    #func                -207    0.888  __ipipe_unstall_root+0x10 (finish_task_switch+0x8c)
> :|   #begin   0x80000000  -206    0.666  __ipipe_unstall_root+0x2c (finish_task_switch+0x8c)
> :|   #func                -205    0.925  ipipe_check_context+0x10 (__ipipe_unstall_root+0x34)
> :|   +end     0x80000000  -205    0.740  __ipipe_unstall_root+0x68 (finish_task_switch+0x8c)
> :    +func                -204+   1.629  ipipe_check_context+0x10 (schedule+0x664)
> :|   +begin   0x80000001  -202    0.814  preempt_schedule_irq+0x7c (__ipipe_preempt_schedule_irq+0x84)
> :|   #end     0x80000001  -201    0.592  preempt_schedule_irq+0x9c (__ipipe_preempt_schedule_irq+0x84)
> :    #func                -201+   1.148  ipipe_check_context+0x10 (preempt_schedule_irq+0xa8)
> :|   #begin   0x80000000  -200+   3.185  __ipipe_preempt_schedule_irq+0x9c (__ipipe_sync_stage+0x188)
> :|   +end     0x00000144  -196+   1.370  gpio_demux_inner+0x88 (gpio_irq_handler+0x178)
> :|   +func                -195+   2.962  gpio_demux_inner+0x10 (gpio_irq_handler+0x18c)
> :|   +(0x02)  0x00000010  -192    0.629  gpio_irq_handler+0x15c (__ipipe_handle_irq+0x150) /* a custom trace point */
> :|   +func                -191    0.925  gpio_demux_inner+0x10 (gpio_irq_handler+0x178)
> :|   +begin   0x00000144  -191+   1.111  gpio_demux_inner+0x74 (gpio_irq_handler+0x178)
> :|   +func                -189+   1.518  __ipipe_handle_irq+0x14 (gpio_demux_inner+0x80)
> :|   +func                -188+   2.148  __ipipe_set_irq_pending+0x10 (__ipipe_handle_irq+0x120)
> :|   +func                -186+   1.074  __ipipe_ack_edge_irq+0x10 (__ipipe_handle_irq+0x150)
> :|   +func                -185+   1.370  gpio_ack_irq+0x10 (__ipipe_ack_edge_irq+0x24)
> :|   +func                -183+   1.333  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1a0)
> :|  + func                -182    0.740  ipipe_suspend_domain+0x10 (__ipipe_walk_pipeline+0x68)
> :|  + func                -181+   1.407  __ipipe_sync_stage+0x14 (ipipe_suspend_domain+0x9c)
> :|  # func                -180+   1.888  xnintr_irq_handler+0x14 (__ipipe_sync_stage+0x124)
/* process the new GPIO interrupt */

I don't presently understand why we get back to running 
gpio_demux_inner() at this particular point, rather than sometime during 
the prior 33 milliseconds.  Note that once gpio_demux_inner() gets a 
chance to unwind, we detect the next (generated long ago) GPIO 
transition almost immediately thereafter.

My intuition is that the overall situation may have something to do with 
the fact that when CONFIG_PREEMPT enabled, __ipipe_sync_stage() calls 
the CONFIG_PREEMPT-specific, non-NULL, implementation 
of__ipipe_preempt_schedule_irq(), but that's speculation.

I'm hoping that the Xenomai community can shed some further light on 
what's going awry, and perhaps suggest a fix.  If possible, I would 
prefer to retain the option to build the kernel with CONFIG_PREEMPT, but 
without encountering the extended latencies documented above.

Thanks much and Best Regards,
Mitch

