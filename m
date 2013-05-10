Message-ID: <518D21AD.5050905@xenomai.org>
Date: Fri, 10 May 2013 18:34:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50F96C89.8010004@siemens.com> <518D11D7.4040409@xenomai.org>
	<518D15DA.3030902@xenomai.org> <518D1EA8.3000006@siemens.com>
In-Reply-To: <518D1EA8.3000006@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/10/2013 06:22 PM, Jan Kiszka wrote:

> On 2013-05-10 17:44, Gilles Chanteperdrix wrote:
>> On 05/10/2013 05:27 PM, Gilles Chanteperdrix wrote:
>>
>>> On 01/18/2013 04:38 PM, Jan Kiszka wrote:
>>>
>>>> This fixes a nasty bug on SMP boxes: We may migrate to root in the
>>>> context of an IRQ handler, and then also to a different CPU. Therefore,
>>>> we must not use domain contexts read before the invocation but update
>>>> them afterward or use stable information like the domain reference.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>
>>>> We are still facing stalled, unkillable RT processes despite this fix,
>>>> but at least the head domain status corruption (and related warnings)
>>>> seems to be gone now.
>>>>
>>>>  kernel/ipipe/core.c |    5 +++--
>>>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
>>>> index 68af0b3..6aa9572 100644
>>>> --- a/kernel/ipipe/core.c
>>>> +++ b/kernel/ipipe/core.c
>>>> @@ -1173,18 +1173,19 @@ static void dispatch_irq_head(unsigned int irq) /* hw interrupts off */
>>>>  	head->irqs[irq].handler(irq, head->irqs[irq].cookie);
>>>>  	__ipipe_run_irqtail(irq);
>>>>  	hard_local_irq_disable();
>>>> +	p = ipipe_this_cpu_head_context();
>>>>  	__clear_bit(IPIPE_STALL_FLAG, &p->status);
>>>>  
>>>>  	/* Are we still running in the head domain? */
>>>>  	if (likely(__ipipe_current_context == p)) {
>>>>  		/* Did we enter this code over the head domain? */
>>>> -		if (old == p) {
>>>> +		if (old->domain == head) {
>>>>  			/* Yes, do immediate synchronization. */
>>>>  			if (__ipipe_ipending_p(p))
>>>>  				__ipipe_sync_stage();
>>>>  			return;
>>>>  		}
>>>> -		__ipipe_set_current_context(old);
>>>> +		__ipipe_set_current_context(ipipe_this_cpu_root_context());
>>>>  	}
>>>>  
>>>>  	/*
>>>
>>>
>>> Hi Jan,
>>>
>>> I may have an issue reported which resembles the problem fixed by this
>>> patch. If I understand your patch, it means that an irq handler may
>>> migrate domain.
> 
> Likely not the IRQ handler itself but its bottom-half that may perform a
> reschedule to an RT task that decides to migrate to handle a fault or a
> Linux syscall etc.


In my case, it is probably due to the way signals are handled by the
posix skin: xnshadow_relax() is called in a signal handler invoked by
xnpod_schedule() (xnpod_dispatch_signals()), and I suspect the system go
south when this happens on the context of an irq handler (head domain
irq handlers do invoke xnpod_schedule()). I am probably going to replace
xnshadow_relax() with xnshadow_call_mayday(), as it seems a cleaner way
to force a migration to secondary mode.

-- 
                                                                Gilles.

