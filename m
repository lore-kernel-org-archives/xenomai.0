Message-ID: <54610426.4080707@siemens.com>
Date: Mon, 10 Nov 2014 19:29:58 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
 <20141110124308.GK17476@sisyphus.hd.free.fr> <5460D139.7090709@siemens.com>
 <20141110155634.GM17476@sisyphus.hd.free.fr>
In-Reply-To: <20141110155634.GM17476@sisyphus.hd.free.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2014-11-10 16:56, Gilles Chanteperdrix wrote:
> On Mon, Nov 10, 2014 at 03:52:41PM +0100, Jan Kiszka wrote:
>> On 2014-11-10 13:43, Gilles Chanteperdrix wrote:
>>> On Mon, Nov 10, 2014 at 09:08:47AM +0000, Stoidner, Christoph wrote:
>>>>
>>>> Hi Gilles,
>>>>
>>>>> Do you have the same message with exactly the same kernel
>>>>> configuration, only with CONFIG_XENOMAI and CONFIG_IPIPE disabled?
>>>>
>>>> When CONFIG_XENOMAI and CONFIG_IPIPE are disabled the message does not 
>>>> appear on boot-up.
>>>>
>>>>> Do you have FCSE enabled? If yes, did you try disabling it? same
>>>>> with unlocked context switch.
>>>>
>>>> FCSE is already disabled at all.
>>>>
>>>> Do you have an idea how to overcome the problem?
>>>
>>> I am not sure the lockdep message really is a problem. lockdep could
>>> be confused by the fact that the hardware interrupts are not off
>>> when running the I-pipe, or because we are missing some bit in the
>>> I-pipe arm specific code to get it looking at the virtual mask
>>> instead of the hardware mask.
>>>
>>> As for the scheduling while atomic and random segmentation fault,
>>> you should use the I-pipe tracer, configure it with enough back
>>> trace points, something like 1000 or 10000, and trigger a trace
>>> freeze in the kernell code when the problem happens.
>>>
>>> Also, for the "scheduling while atomic", it may happen if you call
>>> some Linux service which reschedules from primary mode, you can try
>>> enabling I-pipe debugging, and in fact all Xenomai debugging, to try
>>> and catch such mistakes. This is especially important if you are
>>> running a custom skin.
>>
>> "Scheduling while atomic" may have the same reason why lockdep stumbles:
>> some changes of I-pipe messe up with IRQ state tracing of Linux. I just
>> started to look into this issue again. We tried earlier but got distracted.
> 
> I doubt that very much. Though I never run with lockdep, I sometimes
> run with CONFIG_PREEMPT, and never saw this message. From what I can
> see, the "scheduling while atomic" message is based on the
> preempt_count only and does not use irqs_disabled() (which by the
> way is known to work with I-pipe on ARM as well, so, if something is
> broken, that should be something more obscure).

Let's see. I think I've identified one wrong path:

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index d32f8bd..ab911f8 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -198,7 +198,10 @@
 #ifdef CONFIG_TRACE_IRQFLAGS
 	@ The parent context IRQs must have been enabled to get here in
 	@ the first place, so there's no point checking the PSR I bit.
-	bl	trace_hardirqs_on
+	tst	\rpsr, #PSR_I_BIT
+	bleq	trace_hardirqs_off
+	tst	\rpsr, #PSR_I_BIT
+	blne	trace_hardirqs_on
 #endif
 	.else
 	@ IRQs off again before pulling preserved data off the stack

This is probably no fix, but a with that change applied, the warning is
gone. Now the question is what to really test for when returning here. I
suppose we want the pipeline state of root here - should I
__ipipe_check_root_interruptible?

For reference, here is a trace that relates to a lockdep report:

 |   #func           -155 __save_stack_trace+0x14 (save_stack_trace+0x30)
 |   #func           -157 save_stack_trace+0x10 (save_trace+0x3c)
:|   #func           -159 __ipipe_bugon_irqs_enabled+0x10 (__ipipe_fast_svc_irq_exit+0x4)
:|   #func           -160 __ipipe_check_root_interruptible+0x10 (__irq_svc+0x48)
:|   #func           -161 __ipipe_exit_irq+0x10 (__ipipe_grab_irq+0x48)
:|   #func           -164 __ipipe_set_irq_pending+0x10 (__ipipe_dispatch_irq+0x1f0)
:|   #func           -167 irq_gc_mask_disable_reg+0x10 (omap_mask_ack_irq+0x18)
:|   #func           -168 omap_mask_ack_irq+0x10 (__ipipe_ack_level_irq+0x30)
:|   #func           -169 __ipipe_ack_level_irq+0x10 (__ipipe_dispatch_irq+0x6c)
:|   #func           -171 irq_to_desc+0x10 (__ipipe_dispatch_irq+0xc8)
:|   #func           -174 irq_to_desc+0x10 (__ipipe_dispatch_irq+0xb8)
:|   #func           -175 __ipipe_dispatch_irq+0x10 (__ipipe_grab_irq+0x40)
:|   #func           -177 __ipipe_grab_irq+0x10 (omap3_intc_handle_irq+0x94)
:|   #func           -179 irq_find_mapping+0x14 (omap3_intc_handle_irq+0x88)
:|   #func           -180 omap3_intc_handle_irq+0x10 (__irq_svc+0x44)
:    #func           -184 update_curr.constprop.48+0x14 (dequeue_task_fair+0x30)
:    #func           -184 dequeue_task_fair+0x10 (dequeue_task+0x38)
:    #func           -186 update_rq_clock.part.71+0x10 (dequeue_task+0x4c)
:    #func           -187 dequeue_task+0x14 (deactivate_task+0x38)
:    #func           -187 deactivate_task+0x10 (__schedule+0x2b4)
:    #func           -188 do_raw_spin_lock+0x14 (_raw_spin_lock_irq+0x7c)
     +func           -190 _raw_spin_lock_irq+0x14 (__schedule+0x84)
     +func           -190 ipipe_root_only+0x10 (__schedule+0x5c)
 |   #func           -191 ipipe_root_only+0x10 (ipipe_unstall_root+0x1c)
     #func           -192 ipipe_unstall_root+0x10 (rcu_sched_qs+0xa0)
     +func           -193 rcu_sched_qs+0x10 (__schedule+0x48)
     +func           -194 __schedule+0x14 (schedule+0x40)
     +func           -195 schedule+0x10 (smpboot_thread_fn+0x108)

The ":" at the beginning stands for !current->hardirqs_enabled.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

