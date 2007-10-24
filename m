Message-ID: <fd6a47a90710240611l76b68672g1af78f8cb5784753@domain.hid>
Date: Wed, 24 Oct 2007 15:11:11 +0200
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4074_14809432.1193231471280"
Subject: [Xenomai-core] I-pipe fasteoi interrupt handling issue
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

------=_Part_4074_14809432.1193231471280
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On my Linux 2.6.23 with latest I-pipe patch (1.10-10), interrupts are
dispatched twice if they are of the fasteoi type.

I have the impression that the I-pipe does the eoi() acknowledgement (in
kernel/irq/chip.c: __ipipe_ack_fasteoi_irq) without first masking off the
IRQ. As the interrupt line hasn't been cleared at this time, the interrupt
is immediately reissued. Afterwards (in __ipipe_end_fasteoi_irq), unmasking
is performed correctly nevertheless. If I add 'desc->chip->mask(irq);'
before the 'desc->chip->eoi(irq);', Linux won't boot anymore; apparently the
timer IRQs no longer make it to the APIC.

I'm now going to try a level-irq, but if in the meantime anyone can explain
me if the above reasoning is totally off track or why the timer locks up
after adding the mask...

Thanks,

Jeroen.



A typical I-pipe trace shows:

     +func                 -29    0.079  try_to_wake_up+0x14
(wake_up_process+0x14)
     +func                 -29    0.084  task_rq_lock+0x14
(try_to_wake_up+0x24)
     +func                 -29    0.464  ipipe_check_context+0x14
(task_rq_lock+0x28)
     #func                 -28    0.094  _spin_lock+0x9 (task_rq_lock+0x63)
     #func                 -28    0.509  ipipe_check_context+0x14
(_spin_lock+0x15)
     #func                 -28    0.479  ipipe_check_context+0x14
(_spin_lock+0x3c)
<<< Here's where the IRQ happens >>>
 |   #func                 -27    0.169  __ipipe_handle_irq+0xe
(common_interrupt+0x21)
 |   #func                 -27    0.119  __ipipe_ack_irq+0x8
(__ipipe_handle_irq+0xc4)
<<< Here's where the APIC already receives its EOI >>>
 |   #func                 -27    0.104  __ipipe_ack_fasteoi_irq+0x8
(__ipipe_ack_irq+0x19)
 |   #func                 -27    0.209  ack_ioapic_quirk_irq+0xa
(__ipipe_ack_fasteoi_irq+0xe)
 |   #func                 -26    0.114  __mask_IO_APIC_irq+0x8
(ack_ioapic_quirk_irq+0xaa)
 |   #func                 -26    0.119  __modify_IO_APIC_irq+0xe
(__mask_IO_APIC_irq+0x14)
 |   #func                 -26    1.859  io_apic_base+0x8
(__modify_IO_APIC_irq+0x4d)
 |   #func                 -24    0.174  io_apic_base+0x8
(__modify_IO_APIC_irq+0x59)
 |   #func                 -24    0.164  __ipipe_dispatch_wired+0x14
(__ipipe_handle_irq+0x73)
 |  #*func                 -24    0.289  xnintr_irq_handler+0xe
(__ipipe_dispatch_wired+0xea)
<<< Here's where our driver gets a chance to process the interrupt and clear
the IRQ line >>>
 |  #*func                 -24    2.109  rt_driver_intr+0xc [rt_driver]
(xnintr_irq_handler+0x15e)
 |  #*func                 -22    0.129  xnarch_get_cpu_time+0x8
(rt_driver_intr+0x4b [rt_driver])
 |  #*func                 -22    0.139  xnarch_tsc_to_ns+0x12
(xnarch_get_cpu_time+0xf)
<<< Our driver signals a pending task and leaves. >>>
 |  #*func                 -21    0.199  rtdm_event_signal+0xe
(rt_driver_intr+0x2e [rt_driver])
 |  #*func                 -21    1.299  xnsynch_flush+0xe
(rtdm_event_signal+0x12f)
 |  #*func                 -20    0.159  xnpod_resume_thread+0xe
(xnsynch_flush+0x3a4)
 |  #*[ 2489] -<?>-   99   -20    0.294  xnpod_resume_thread+0x140
(xnsynch_flush+0x3a4)
 |  #*func                 -19    1.549  xntimer_stop_aperiodic+0xe
(xnpod_resume_thread+0xa0d)
 |  #*func                 -18    0.644  xntimer_next_local_shot+0x16
(xntimer_stop_aperiodic+0x4f4)
 |  #*func                 -17    0.419  xnpod_schedule+0x11
(rtdm_event_signal+0x2b4)
 |  #*func                 -17    0.129  rthal_irq_end+0x8
(xnintr_irq_handler+0x262)
 |  #*func                 -17    0.134  __ipipe_end_fasteoi_irq+0x8
(rthal_irq_end+0x24)
 |  #*func                 -17    0.109  unmask_IO_APIC_irq+0x12
(__ipipe_end_fasteoi_irq+0xe)
 |  #*func                 -16    0.134  __ipipe_spin_lock_irqsave+0x9
(unmask_IO_APIC_irq+0x1e)
 |  #*func                 -16    0.099  __unmask_IO_APIC_irq+0x8
(unmask_IO_APIC_irq+0x27)
 |  #*func                 -16    0.089  __modify_IO_APIC_irq+0xe
(__unmask_IO_APIC_irq+0x14)
 |  #*func                 -16    1.609  io_apic_base+0x8
(__modify_IO_APIC_irq+0x4d)
 |  #*func                 -15    0.159  io_apic_base+0x8
(__modify_IO_APIC_irq+0x59)
 |  #*func                 -14    0.124  __ipipe_unlock_irq+0xe
(unmask_IO_APIC_irq+0x3d)
 |  #*func                 -14    0.184  __ipipe_spin_unlock_irqrestore+0x9
(unmask_IO_APIC_irq+0x49)
 |  #*func                 -14    0.209  xnpod_schedule+0x11
(xnintr_irq_handler+0x28f)
 |  #*[  220] gatekee -1   -14    1.139  xnpod_schedule+0xec
(xnintr_irq_handler+0x28f)
 |  #*func                 -13    0.599  __switch_to+0xe
(xnpod_schedule+0x8b4)
 |  #*[ 2489] -<?>-   99   -12    1.019  xnpod_schedule+0x952
(xnpod_suspend_thread+0x72c)
 |  #*func                 -11    0.589  __ipipe_restore_pipeline_head+0x9
(rtdm_event_timedwait+0x181)
 |  +*func                 -10    0.169  __ipipe_handle_irq+0xe
(common_interrupt+0x21)
 |  +*func                 -10    0.109  __ipipe_ack_irq+0x8
(__ipipe_handle_irq+0xc4)
 |  +*func                 -10    0.109  __ipipe_ack_fasteoi_irq+0x8
(__ipipe_ack_irq+0x19)
 |  +*func                 -10    0.194  ack_ioapic_quirk_irq+0xa
(__ipipe_ack_fasteoi_irq+0xe)
 |  +*func                 -10    0.109  __mask_IO_APIC_irq+0x8
(ack_ioapic_quirk_irq+0xaa)
 |  +*func                 -10    0.109  __modify_IO_APIC_irq+0xe
(__mask_IO_APIC_irq+0x14)
 |  +*func                 -10    1.594  io_apic_base+0x8
(__modify_IO_APIC_irq+0x4d)
 |  +*func                  -8    0.174  io_apic_base+0x8
(__modify_IO_APIC_irq+0x59)
 |  +*func                  -8    0.124  __ipipe_dispatch_wired+0x14
(__ipipe_handle_irq+0x73)
 |  #*func                  -8    0.214  xnintr_irq_handler+0xe
(__ipipe_dispatch_wired+0xea)
<<< Here's where our driver is called again >>>
 |  #*func                  -8    2.024  rt_driver_intr+0xc [rt_driver]
(xnintr_irq_handler+0x15e)
 |  #*func                  -6    0.139  printk+0x14 (rt_driver_intr+0x78
[rt_driver])
 |  #*func                  -5    0.144  __ipipe_spin_lock_irqsave+0x9
(printk+0xbf)
 |  #*func                  -5    0.109  vscnprintf+0xc (printk+0xe7)
 |  #*func                  -5    0.309  vsnprintf+0xe (vscnprintf+0x1b)
 |  #*func                  -5    0.379  number+0xe (vsnprintf+0x2f9)
 |  #*func                  -4    0.164  __ipipe_spin_unlock_irqrestore+0x9
(printk+0xfd)
 |  #*func                  -4    0.139  ipipe_trigger_irq+0xc
(printk+0x10b)
 |  #*func                  -4    0.194  __ipipe_handle_irq+0xe
(ipipe_trigger_irq+0xa7)
 |  #*func                  -4    0.174  __ipipe_set_irq_pending+0x14
(__ipipe_handle_irq+0x1a4)
 |  #*func                  -4    0.259  __ipipe_walk_pipeline+0xe
(__ipipe_handle_irq+0x95)
 |  #*func                  -4    0.114  rthal_irq_end+0x8
(xnintr_irq_handler+0x262)
 |  #*func                  -3    0.104  __ipipe_end_fasteoi_irq+0x8
(rthal_irq_end+0x24)
 |  #*func                  -3    0.104  unmask_IO_APIC_irq+0x12
(__ipipe_end_fasteoi_irq+0xe)
 |  #*func                  -3    0.129  __ipipe_spin_lock_irqsave+0x9
(unmask_IO_APIC_irq+0x1e)
 |  #*func                  -3    0.104  __unmask_IO_APIC_irq+0x8
(unmask_IO_APIC_irq+0x27)
 |  #*func                  -3    0.094  __modify_IO_APIC_irq+0xe
(__unmask_IO_APIC_irq+0x14)
 |  #*func                  -3    1.604  io_apic_base+0x8
(__modify_IO_APIC_irq+0x4d)
 |  #*func                  -1    0.139  io_apic_base+0x8
(__modify_IO_APIC_irq+0x59)
 |  #*func                  -1    0.129  __ipipe_unlock_irq+0xe
(unmask_IO_APIC_irq+0x3d)
 |  #*func                  -1    0.314  __ipipe_spin_unlock_irqrestore+0x9
(unmask_IO_APIC_irq+0x49)
 |  +*func                  -1    0.479  __ipipe_walk_pipeline+0xe
(__ipipe_handle_irq+0x95)
    +*func                   0    0.704  receiveCurrentBuffer+0x11
[rt_driver] (rt_driver_read+0xc1 [rt_driver])
>   +*begin   0x00000000     0+   1.659  rt_driver_read+0x181 [rt_driver]
(__rt_dev_read+0x55)
:   +*func                   1    0.149  __ipipe_syscall_root+0x9
(sysenter_past_esp+0x46)
:   +*func                   1    0.154  __ipipe_dispatch_event+0xe
(__ipipe_syscall_root+0x50)
:

------=_Part_4074_14809432.1193231471280
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>On my Linux 2.6.23 with latest I-pipe patch (1.10-10), interrupts are dispatched twice if they are of the fasteoi type.<br>&nbsp;</div>
<div>I have the impression that the I-pipe does the eoi() acknowledgement (in kernel/irq/chip.c: __ipipe_ack_fasteoi_irq) without first masking off the IRQ. As the interrupt line hasn&#39;t been cleared at this time, the interrupt is immediately reissued.&nbsp;Afterwards (in __ipipe_end_fasteoi_irq), unmasking is performed correctly nevertheless. If I add &#39;desc-&gt;chip-&gt;mask(irq);&#39; before the &#39;desc-&gt;chip-&gt;eoi(irq);&#39;, Linux won&#39;t boot anymore; apparently the timer IRQs no longer make it to the APIC.
</div>
<div>&nbsp;</div>
<div>I&#39;m now going to try a level-irq, but if in the meantime anyone can explain me if the above reasoning is totally off track or why the timer locks up after adding the mask...</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><br>A typical I-pipe trace shows:<br><br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -29&nbsp;&nbsp;&nbsp; 0.079&nbsp; try_to_wake_up+0x14 (wake_up_process+0x14)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -29&nbsp;&nbsp;&nbsp; 0.084&nbsp; task_rq_lock+0x14 (try_to_wake_up+0x24)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -29&nbsp;&nbsp;&nbsp; 
0.464&nbsp; ipipe_check_context+0x14 (task_rq_lock+0x28)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -28&nbsp;&nbsp;&nbsp; 0.094&nbsp; _spin_lock+0x9 (task_rq_lock+0x63)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -28&nbsp;&nbsp;&nbsp; 0.509&nbsp; ipipe_check_context+0x14 (_spin_lock+0x15)<br>
&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -28&nbsp;&nbsp;&nbsp; 0.479&nbsp; ipipe_check_context+0x14 (_spin_lock+0x3c)</div>
<div>&lt;&lt;&lt; Here&#39;s where the IRQ happens &gt;&gt;&gt;<br>&nbsp;|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -27&nbsp;&nbsp;&nbsp; 0.169&nbsp; __ipipe_handle_irq+0xe (common_interrupt+0x21)<br>&nbsp;|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -27&nbsp;&nbsp;&nbsp; 0.119&nbsp; __ipipe_ack_irq+0x8 (__ipipe_handle_irq+0xc4)
<br>&lt;&lt;&lt; Here&#39;s where the APIC already receives its EOI &gt;&gt;&gt;<br>&nbsp;|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -27&nbsp;&nbsp;&nbsp; 0.104&nbsp; __ipipe_ack_fasteoi_irq+0x8 (__ipipe_ack_irq+0x19)</div>
<div>&nbsp;|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -27&nbsp;&nbsp;&nbsp; 0.209&nbsp; ack_ioapic_quirk_irq+0xa (__ipipe_ack_fasteoi_irq+0xe)<br>&nbsp;|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -26&nbsp;&nbsp;&nbsp; 0.114&nbsp; __mask_IO_APIC_irq+0x8 (ack_ioapic_quirk_irq+0xaa)<br>&nbsp;|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -26&nbsp;&nbsp;&nbsp; 
0.119&nbsp; __modify_IO_APIC_irq+0xe (__mask_IO_APIC_irq+0x14)<br>&nbsp;|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -26&nbsp;&nbsp;&nbsp; 1.859&nbsp; io_apic_base+0x8 (__modify_IO_APIC_irq+0x4d)<br>&nbsp;|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -24&nbsp;&nbsp;&nbsp; 0.174&nbsp; io_apic_base+0x8 (__modify_IO_APIC_irq+0x59)
<br>&nbsp;|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -24&nbsp;&nbsp;&nbsp; 0.164&nbsp; __ipipe_dispatch_wired+0x14 (__ipipe_handle_irq+0x73)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -24&nbsp;&nbsp;&nbsp; 0.289&nbsp; xnintr_irq_handler+0xe (__ipipe_dispatch_wired+0xea)</div>
<div>&lt;&lt;&lt; Here&#39;s where our driver gets a chance to process the interrupt and clear the IRQ line &gt;&gt;&gt;<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -24&nbsp;&nbsp;&nbsp; 2.109&nbsp; rt_driver_intr+0xc [rt_driver] (xnintr_irq_handler+0x15e)
<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -22&nbsp;&nbsp;&nbsp; 0.129&nbsp; xnarch_get_cpu_time+0x8 (rt_driver_intr+0x4b [rt_driver])<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -22&nbsp;&nbsp;&nbsp; 0.139&nbsp; xnarch_tsc_to_ns+0x12 (xnarch_get_cpu_time+0xf)</div>
<div>&lt;&lt;&lt; Our driver signals a pending task and leaves. &gt;&gt;&gt;<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -21&nbsp;&nbsp;&nbsp; 0.199&nbsp; rtdm_event_signal+0xe (rt_driver_intr+0x2e [rt_driver])<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -21&nbsp;&nbsp;&nbsp; 1.299&nbsp; xnsynch_flush+0xe (rtdm_event_signal+0x12f)
<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -20&nbsp;&nbsp;&nbsp; 0.159&nbsp; xnpod_resume_thread+0xe (xnsynch_flush+0x3a4)<br>&nbsp;|&nbsp; #*[ 2489] -&lt;?&gt;-&nbsp;&nbsp; 99&nbsp;&nbsp; -20&nbsp;&nbsp;&nbsp; 0.294&nbsp; xnpod_resume_thread+0x140 (xnsynch_flush+0x3a4)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -19&nbsp;&nbsp;&nbsp; 
1.549&nbsp; xntimer_stop_aperiodic+0xe (xnpod_resume_thread+0xa0d)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -18&nbsp;&nbsp;&nbsp; 0.644&nbsp; xntimer_next_local_shot+0x16 (xntimer_stop_aperiodic+0x4f4)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -17&nbsp;&nbsp;&nbsp; 0.419&nbsp; xnpod_schedule+0x11 (rtdm_event_signal+0x2b4)
<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -17&nbsp;&nbsp;&nbsp; 0.129&nbsp; rthal_irq_end+0x8 (xnintr_irq_handler+0x262)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -17&nbsp;&nbsp;&nbsp; 0.134&nbsp; __ipipe_end_fasteoi_irq+0x8 (rthal_irq_end+0x24)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -17&nbsp;&nbsp;&nbsp; 0.109
&nbsp; unmask_IO_APIC_irq+0x12 (__ipipe_end_fasteoi_irq+0xe)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -16&nbsp;&nbsp;&nbsp; 0.134&nbsp; __ipipe_spin_lock_irqsave+0x9 (unmask_IO_APIC_irq+0x1e)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -16&nbsp;&nbsp;&nbsp; 0.099&nbsp; __unmask_IO_APIC_irq+0x8 (unmask_IO_APIC_irq+0x27)
<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -16&nbsp;&nbsp;&nbsp; 0.089&nbsp; __modify_IO_APIC_irq+0xe (__unmask_IO_APIC_irq+0x14)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -16&nbsp;&nbsp;&nbsp; 1.609&nbsp; io_apic_base+0x8 (__modify_IO_APIC_irq+0x4d)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -15&nbsp;&nbsp;&nbsp; 
0.159&nbsp; io_apic_base+0x8 (__modify_IO_APIC_irq+0x59)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -14&nbsp;&nbsp;&nbsp; 0.124&nbsp; __ipipe_unlock_irq+0xe (unmask_IO_APIC_irq+0x3d)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -14&nbsp;&nbsp;&nbsp; 0.184&nbsp; __ipipe_spin_unlock_irqrestore+0x9 (unmask_IO_APIC_irq+0x49)
<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -14&nbsp;&nbsp;&nbsp; 0.209&nbsp; xnpod_schedule+0x11 (xnintr_irq_handler+0x28f)<br>&nbsp;|&nbsp; #*[&nbsp; 220] gatekee -1&nbsp;&nbsp; -14&nbsp;&nbsp;&nbsp; 1.139&nbsp; xnpod_schedule+0xec (xnintr_irq_handler+0x28f)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -13&nbsp;&nbsp;&nbsp; 0.599
&nbsp; __switch_to+0xe (xnpod_schedule+0x8b4)<br>&nbsp;|&nbsp; #*[ 2489] -&lt;?&gt;-&nbsp;&nbsp; 99&nbsp;&nbsp; -12&nbsp;&nbsp;&nbsp; 1.019&nbsp; xnpod_schedule+0x952 (xnpod_suspend_thread+0x72c)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -11&nbsp;&nbsp;&nbsp; 0.589&nbsp; __ipipe_restore_pipeline_head+0x9 (rtdm_event_timedwait+0x181)
</div>
<div>&nbsp;|&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -10&nbsp;&nbsp;&nbsp; 0.169&nbsp; __ipipe_handle_irq+0xe (common_interrupt+0x21)<br>&nbsp;|&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -10&nbsp;&nbsp;&nbsp; 0.109&nbsp; __ipipe_ack_irq+0x8 (__ipipe_handle_irq+0xc4)<br>&nbsp;|&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -10&nbsp;&nbsp;&nbsp; 
0.109&nbsp; __ipipe_ack_fasteoi_irq+0x8 (__ipipe_ack_irq+0x19)<br>&nbsp;|&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -10&nbsp;&nbsp;&nbsp; 0.194&nbsp; ack_ioapic_quirk_irq+0xa (__ipipe_ack_fasteoi_irq+0xe)<br>&nbsp;|&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -10&nbsp;&nbsp;&nbsp; 0.109&nbsp; __mask_IO_APIC_irq+0x8 (ack_ioapic_quirk_irq+0xaa)
<br>&nbsp;|&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -10&nbsp;&nbsp;&nbsp; 0.109&nbsp; __modify_IO_APIC_irq+0xe (__mask_IO_APIC_irq+0x14)<br>&nbsp;|&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -10&nbsp;&nbsp;&nbsp; 1.594&nbsp; io_apic_base+0x8 (__modify_IO_APIC_irq+0x4d)<br>&nbsp;|&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8&nbsp;&nbsp;&nbsp; 
0.174&nbsp; io_apic_base+0x8 (__modify_IO_APIC_irq+0x59)<br>&nbsp;|&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8&nbsp;&nbsp;&nbsp; 0.124&nbsp; __ipipe_dispatch_wired+0x14 (__ipipe_handle_irq+0x73)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8&nbsp;&nbsp;&nbsp; 0.214&nbsp; xnintr_irq_handler+0xe (__ipipe_dispatch_wired+0xea)
<br>&lt;&lt;&lt; Here&#39;s where our driver is called again &gt;&gt;&gt;</div>
<div>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8&nbsp;&nbsp;&nbsp; 2.024&nbsp; rt_driver_intr+0xc [rt_driver] (xnintr_irq_handler+0x15e)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -6&nbsp;&nbsp;&nbsp; 0.139&nbsp; printk+0x14 (rt_driver_intr+0x78 [rt_driver])<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -5&nbsp;&nbsp;&nbsp; 
0.144&nbsp; __ipipe_spin_lock_irqsave+0x9 (printk+0xbf)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -5&nbsp;&nbsp;&nbsp; 0.109&nbsp; vscnprintf+0xc (printk+0xe7)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -5&nbsp;&nbsp;&nbsp; 0.309&nbsp; vsnprintf+0xe (vscnprintf+0x1b)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -5&nbsp;&nbsp;&nbsp; 
0.379&nbsp; number+0xe (vsnprintf+0x2f9)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4&nbsp;&nbsp;&nbsp; 0.164&nbsp; __ipipe_spin_unlock_irqrestore+0x9 (printk+0xfd)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4&nbsp;&nbsp;&nbsp; 0.139&nbsp; ipipe_trigger_irq+0xc (printk+0x10b)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4&nbsp;&nbsp;&nbsp; 
0.194&nbsp; __ipipe_handle_irq+0xe (ipipe_trigger_irq+0xa7)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4&nbsp;&nbsp;&nbsp; 0.174&nbsp; __ipipe_set_irq_pending+0x14 (__ipipe_handle_irq+0x1a4)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4&nbsp;&nbsp;&nbsp; 0.259&nbsp; __ipipe_walk_pipeline+0xe (__ipipe_handle_irq+0x95)
<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4&nbsp;&nbsp;&nbsp; 0.114&nbsp; rthal_irq_end+0x8 (xnintr_irq_handler+0x262)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3&nbsp;&nbsp;&nbsp; 0.104&nbsp; __ipipe_end_fasteoi_irq+0x8 (rthal_irq_end+0x24)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3&nbsp;&nbsp;&nbsp; 0.104
&nbsp; unmask_IO_APIC_irq+0x12 (__ipipe_end_fasteoi_irq+0xe)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3&nbsp;&nbsp;&nbsp; 0.129&nbsp; __ipipe_spin_lock_irqsave+0x9 (unmask_IO_APIC_irq+0x1e)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3&nbsp;&nbsp;&nbsp; 0.104&nbsp; __unmask_IO_APIC_irq+0x8 (unmask_IO_APIC_irq+0x27)
<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3&nbsp;&nbsp;&nbsp; 0.094&nbsp; __modify_IO_APIC_irq+0xe (__unmask_IO_APIC_irq+0x14)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3&nbsp;&nbsp;&nbsp; 1.604&nbsp; io_apic_base+0x8 (__modify_IO_APIC_irq+0x4d)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp; 
0.139&nbsp; io_apic_base+0x8 (__modify_IO_APIC_irq+0x59)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp; 0.129&nbsp; __ipipe_unlock_irq+0xe (unmask_IO_APIC_irq+0x3d)<br>&nbsp;|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp; 0.314&nbsp; __ipipe_spin_unlock_irqrestore+0x9 (unmask_IO_APIC_irq+0x49)
<br>&nbsp;|&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp; 0.479&nbsp; __ipipe_walk_pipeline+0xe (__ipipe_handle_irq+0x95)<br>&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0.704&nbsp; receiveCurrentBuffer+0x11 [rt_driver] (rt_driver_read+0xc1 [rt_driver])<br>&gt;&nbsp;&nbsp; +*begin&nbsp;&nbsp; 0x00000000&nbsp;&nbsp;&nbsp;&nbsp; 0+&nbsp;&nbsp; 
1.659&nbsp; rt_driver_read+0x181 [rt_driver] (__rt_dev_read+0x55)<br>:&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; 0.149&nbsp; __ipipe_syscall_root+0x9 (sysenter_past_esp+0x46)<br>:&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; 0.154&nbsp; __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x50)
<br>:<br>&nbsp;</div>

------=_Part_4074_14809432.1193231471280--

