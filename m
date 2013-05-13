Message-ID: <51908A64.9080109@siemens.com>
Date: Mon, 13 May 2013 08:38:28 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50F96C89.8010004@siemens.com> <518D11D7.4040409@xenomai.org>
	<518D15DA.3030902@xenomai.org> <518D1EA8.3000006@siemens.com>
	<518E5B72.3030509@xenomai.org>
In-Reply-To: <518E5B72.3030509@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [CRITICAL PATCH] ipipe: Re-read domain context after
 IRQ	processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-05-11 16:53, Philippe Gerum wrote:
> On 05/10/2013 06:22 PM, Jan Kiszka wrote:
>> On 2013-05-10 17:44, Gilles Chanteperdrix wrote:
>>> On 05/10/2013 05:27 PM, Gilles Chanteperdrix wrote:
>>>
>>>> On 01/18/2013 04:38 PM, Jan Kiszka wrote:
>>>>
>>>>> This fixes a nasty bug on SMP boxes: We may migrate to root in the
>>>>> context of an IRQ handler, and then also to a different CPU. Therefore,
>>>>> we must not use domain contexts read before the invocation but update
>>>>> them afterward or use stable information like the domain reference.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>
>>>>> We are still facing stalled, unkillable RT processes despite this fix,
>>>>> but at least the head domain status corruption (and related warnings)
>>>>> seems to be gone now.
>>>>>
>>>>>   kernel/ipipe/core.c |    5 +++--
>>>>>   1 files changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
>>>>> index 68af0b3..6aa9572 100644
>>>>> --- a/kernel/ipipe/core.c
>>>>> +++ b/kernel/ipipe/core.c
>>>>> @@ -1173,18 +1173,19 @@ static void dispatch_irq_head(unsigned int irq) /* hw interrupts off */
>>>>>   	head->irqs[irq].handler(irq, head->irqs[irq].cookie);
>>>>>   	__ipipe_run_irqtail(irq);
>>>>>   	hard_local_irq_disable();
>>>>> +	p = ipipe_this_cpu_head_context();
>>>>>   	__clear_bit(IPIPE_STALL_FLAG, &p->status);
>>>>>
>>>>>   	/* Are we still running in the head domain? */
>>>>>   	if (likely(__ipipe_current_context == p)) {
>>>>>   		/* Did we enter this code over the head domain? */
>>>>> -		if (old == p) {
>>>>> +		if (old->domain == head) {
>>>>>   			/* Yes, do immediate synchronization. */
>>>>>   			if (__ipipe_ipending_p(p))
>>>>>   				__ipipe_sync_stage();
>>>>>   			return;
>>>>>   		}
>>>>> -		__ipipe_set_current_context(old);
>>>>> +		__ipipe_set_current_context(ipipe_this_cpu_root_context());
>>>>>   	}
>>>>>
>>>>>   	/*
>>>>
>>>>
>>>> Hi Jan,
>>>>
>>>> I may have an issue reported which resembles the problem fixed by this
>>>> patch. If I understand your patch, it means that an irq handler may
>>>> migrate domain.
>>
>> Likely not the IRQ handler itself but its bottom-half that may perform a
>> reschedule to an RT task that decides to migrate to handle a fault or a
>> Linux syscall etc.
>>
>>> But if I read __ipipe_sync_stage() code:
>>>>
>>>> void __ipipe_do_sync_stage(void)
>>>> {
>>>> 	struct ipipe_percpu_domain_data *p;
>>>> 	struct ipipe_domain *ipd;
>>>> 	int irq;
>>>>
>>>> 	p = __ipipe_current_context;
>>>> 	ipd = p->domain;
>>>>
>>>> 	__set_bit(IPIPE_STALL_FLAG, &p->status);
>>>> 	smp_wmb();
>>>>
>>>> 	if (ipd == ipipe_root_domain)
>>>> 		trace_hardirqs_off();
>>>>
>>>> 	for (;;) {
>>>> 		irq = __ipipe_next_irq(p);
>>>> 		if (irq < 0)
>>>> 			break;
>>>> 		/*
>>>> 		 * Make sure the compiler does not reorder wrongly, so
>>>> 		 * that all updates to maps are done before the
>>>> 		 * handler gets called.
>>>> 		 */
>>>> 		barrier();
>>>>
>>>> 		if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))
>>>> 			continue;
>>>>
>>>> 		if (ipd != ipipe_head_domain)
>>>> 			hard_local_irq_enable();
>>>>
>>>> 		if (likely(ipd != ipipe_root_domain)) {
>>>> 			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
>>>> 			__ipipe_run_irqtail(irq);
>>>> 			hard_local_irq_disable();
>>>> 		} else if (ipipe_virtual_irq_p(irq)) {
>>>> 			irq_enter();
>>>> 			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
>>>> 			irq_exit();
>>>> 			root_stall_after_handler();
>>>> 			hard_local_irq_disable();
>>>> 			while (__ipipe_check_root_resched())
>>>> 				__ipipe_preempt_schedule_irq();
>>>> 		} else {
>>>> 			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
>>>> 			root_stall_after_handler();
>>>> 			hard_local_irq_disable();
>>>> 		}
>>>>
>>>> 		p = __ipipe_current_context;
>>>> 	}
>>>>
>>>> 	if (ipd == ipipe_root_domain)
>>>> 		trace_hardirqs_on();
>>>>
>>>> 	__clear_bit(IPIPE_STALL_FLAG, &p->status);
>>>> }
>>>>
>>>> It seems to me that at the end of each loop, we re-read p, but we assume
>>>> that p->domain did not change. So I would add:
>>>>
>>>> ipd = p->domain
>>>>
>>>> right after the line
>>>> p = __ipipe_current_context
>>
>> If we are supposed to unstall the current domain and not the old one,
>> that will be required. That case would only affect Linux tracing, what
>> you suggest below is way more critical.
>>
>>>>
>>>> But I am not sure that we are supposed to allow irq handlers to migrate
>>>> domains.
>>
>> We are, see above.
>>
>>>
>>>
>>> And I am not sure that this would not break the logic of
>>> __ipipe_sync_stage, so, maybe replacing:
>>>
>>> p = __ipipe_current_context
>>>
>>> with
>>>
>>> p = ipipe_this_cpu_context(ipd)
>>>
>>> would make more sense?
>>>
>>
>> Yes, this seems more consistent when comparing to dispatch_irq_head: We
> 
> IIRC, the fix in dispatch_irq_head was related to CPU migration, not 
> domain migration.

Yes, though the former typically does not come without the latter.

> 
>> need to remove the stall flag from that domain which we stalled on
>> entry. Philippe?
>>
> 
> Actually, we never migrate domains over an IRQ strictly speaking, 
> although we may migrate CPUs.
> 
> Migrating from root to head over a (root) IRQ handler is invalid, since 
> the hardening machinery may only run over a Linux task context.
> 
> Migrating the other way around implies that a Xenomai thread is relaxing 
> the same way, so we would have a Xenomai context switch interleaved, 
> triggered by the IRQ handler, resuming a thread aslept in primary mode. 
> Whatever that thread does after waking up, moving back to the handler 
> would mean switching back to the preempted head domain context first.

OK, makes sense.

> 
> The test patch below should never trigger. Besides, the patch above 
> would mean to play interrupts from the wrong domain at the next 
> iteration (e.g.  still playing head interrupts despite we moved to 
> root). However such migration should never happen.
> 
> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
> index c4598ad..fe3560c 100644
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -1420,6 +1420,7 @@ void __ipipe_do_sync_stage(void)
>   			hard_local_irq_disable();
>   		}
> 
> +		WARN_ON_ONCE(ipipe_this_cpu_context(ipd) != p);
>   		p = __ipipe_current_context;
>   	}
> 

I have the feeling that it would be very helpful if someone could sit
down on a rainy day and describe the typical control flows with
potential domain and CPU switches for a Xenomai/I-pipe system.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

