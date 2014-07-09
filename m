Message-ID: <53BD692A.5000202@axelsw.it>
Date: Wed, 09 Jul 2014 18:09:14 +0200
From: Marco Tessore <marco.tessore@axelsw.it>
MIME-Version: 1.0
References: <53A3FAB0.4050100@axelsw.it> <53A4207F.9040801@xenomai.org>
 <53A9AA38.3090005@axelsw.it> <53A9B0FB.1070809@xenomai.org>
 <53AA7F39.90706@axelsw.it> <53AA8AC3.7020100@xenomai.org>
In-Reply-To: <53AA8AC3.7020100@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel freezes in __ipipe_sync_stage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Good morning,
I'm still trying to investigate the deadlock that is keeping me busy for 
quite some time.

I have the following situation occurs:
     the domain root is in its call to __ipipe_sync_stage invoked 
indirectly by
         xnpod_enable_timesource {xnlock_put_irq_restore(lock, x = 0), 
lock is ignored, and this will generate calls
         to __ipipe_restore_pipeline_head, __ipipe_walk_pipeline and 
ipipe_suspend_domain
         }
     here we are: in __ipipe_sync_stage for the Linux domain.
In it I have execution of the timer    interrupt service routine,
     which in my case is a Freescale i.MX25's timer:
         mxc_timer_interrupt in arch/arm/plat_mxc/time.c.

As a note: this file (time.c) have been corrected since it previously 
doesn'n take into account that timer chip for i.MX25 is the same of the 
one for the mx3 and mx5.

Following the chain, from __ipipe_sync_stage, we have a call to 
xnarch_next_ht_shot, xntimer_start_aperiodic;
is finally invoked the __ipipe_set_irq_pending for xenomai domain.


Subsequently, the procedure __xnarch_next_htick_shot  invokes the the 
ipipe_restore_pipeline_head.

than we have this call:

void __ipipe_restore_pipeline_head(unsigned long x)
{
     struct ipipe_percpu_domain_data *p = ipipe_head_cpudom_ptr();

     local_irq_disable_hw();

     if (x) {
#ifdef CONFIG_DEBUG_KERNEL
         static int warned;
         if (!warned && test_and_set_bit(IPIPE_STALL_FLAG, &p->status)) {
             /*
              * Already stalled albeit ipipe_restore_pipeline_head()
              * should have detected it? Send a warning once.
              */
             warned = 1;
             printk(KERN_WARNING
                    "I-pipe: ipipe_restore_pipeline_head() optimization 
failed.\n");
             dump_stack();
         }
#else /* !CONFIG_DEBUG_KERNEL */
         set_bit(IPIPE_STALL_FLAG, &p->status);
#endif /* CONFIG_DEBUG_KERNEL */
     }
     else {
         __clear_bit(IPIPE_STALL_FLAG, &p->status);
         if (unlikely(p->irqpend_himask != 0)) {
             struct ipipe_domain *head_domain = __ipipe_pipeline_head();
             if (likely(head_domain == __ipipe_current_domain))
                 __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
             else
__ipipe_walk_pipeline(&head_domain->p_link); <-- THIS CALL
         }
         local_irq_enable_hw();
     }
}

(as we saw before, irqpend_himask for xenomai domain was set for the 
timer interrupt)

Here the call to the __ipipe_walk_pipeline and from this the 
__ipipe_sync_stage for the xenomai domain.

We have the call to xnintr_clock_handler
xntimer_tick_aperiodic, xntimer_next_local_shot, xnintr_host_tick, 
xnarch_relay_tick
theese calls __ipipe_set_irq_pending for the timer interrupt on linux 
domain.

Since we are already - deeper in the call stack - in the 
__ipipe_sync_stage for the linux domain, we have that at this level
__ipipe_sync_stage clears the flags in the interrupt log for the timer,
it handles the timer interrupt and the chain described above, set in 
turns the flags in the interrupt log for xenomai domain,
which handler sets again the interrupt log for the linux domain;
In the next iteration this repeats infinite times, causing stall of the 
kernel.


Can you help me to understand some more? In particular how it can be 
possible that linux domain triggers xenomain domain that in turns 
triggers linux domain?

As I said in previous mails, this is not a frequent bug, it happens 
randomly when I boot the machine,
but it's still limiting the scope for which the device has been developed.
I can capture the state with an hardware debugger when deadlock happens,
but I cannot find what is happened before.
Surely I know that I havent anomalies in timer interrupt,
driving a pin in the function __ipipe_grab_irq, I can see that timer 
interrupt is quite regular.

As I said in previous mails, this is not a frequent bug, it happens 
randomly when I boot the machine,
but it's still limiting the scope for which the device has been developed.
I can capture the state with an hardware debugger when deadlock happens,
but I cannot find what is happened before.
Surely I know that I haven't anomalies in timer interrupt:
driving a pin in the function __ipipe_grab_irq, I can see that timer 
interrupt is quite regular.

Thank you in advance for any help.
Kind regards
Marco Tessore

In reference to your past email

Il 25/06/2014 10:39, Philippe Gerum ha scritto:
> On 06/25/2014 09:50 AM, Marco Tessore wrote:
>> Il 24/06/2014 19:10, Philippe Gerum ha scritto:
>>> On 06/24/2014 06:41 PM, Marco Tessore wrote:
>>>> Hi,
>>>>
>>>> Il 20/06/2014 13:52, Gilles Chanteperdrix ha scritto:
>>>>> On 06/20/2014 11:11 AM, Marco Tessore wrote:
>>>>>> The kernel is version 2.6.31 for ARM architecture - specifically a
>>>>> Do you have the same problem with a recent I-pipe patches, like 
>>>>> one for
>>>>> 3.8 or 3.10 kernel?
>>>>>
>>>>
>>>> I managed to do some tests on 3.10 kernel but on onother board with
>>>> imx28 CPU, actually it happens that that kernel freezes too,
>>>> but I haven't debugged it with the jtag debugger.
>>>>

> This is because you are running an outdated Xenomai 2.5.x release. A 
> work around is to build all the Xenomai skins as modules in the kernel 
> (native, posix, vxworks etc), refraining from modloading them during 
> the boot process.

I tried this and the event has not occurred,
instead, after hundreds of reboots it happened that the kernel freezed 
in idle_task, and the init process stalled, I don't know where, can be 
related or not to the problem described above.
>
> First step is to determine if the system experiences an IRQ storm of 
> some sort from the timer chip, and why so. By focusing on the IRQ 
> replay loop which basically resyncs the current interrupt state with 
> the past events logged, you may be looking at rays from an ancient sun.
>

It can be excluded, I haven't saw any interrupt storm, the timer 
interrupt is quite regular.

