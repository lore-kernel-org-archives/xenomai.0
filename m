Subject: Re: [PATCH] irq_pipeline: Prevent returning to user space with
 pending inband IRQs
References: <0531d2db-aa87-1950-6d7f-41c80d4fe679@web.de>
 <875yyrf3yo.fsf@xenomai.org>
 <c6633047-7570-294f-e0b0-ab74f0c2a33e@siemens.com>
 <87a6o2b0to.fsf@xenomai.org>
 <50f40c7f-ae8d-7ded-9dc7-91310f0d7909@siemens.com>
 <874ke9bzde.fsf@xenomai.org>
 <3814ce50-b6cd-04e3-587b-40197f905ef8@siemens.com>
 <f701eccc-5407-86ec-512f-460391c80fb9@siemens.com>
 <e9d381b2-deea-d2fa-79df-940bac1c044e@siemens.com>
 <87k0n5af78.fsf@xenomai.org>
 <14f3aaa0-0d59-3b10-c21e-d408a1346673@siemens.com>
 <87eeddabpx.fsf@xenomai.org>
 <a7991626-3080-7789-e003-9e74626de784@siemens.com>
 <87im2o8fn6.fsf@xenomai.org> <87zgw06ysa.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <22521ff4-b3b1-86c7-2486-831fade9f268@siemens.com>
Date: Wed, 9 Jun 2021 07:34:06 +0200
MIME-Version: 1.0
In-Reply-To: <87zgw06ysa.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 08.06.21 19:39, Philippe Gerum wrote:
> 
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 07.06.21 18:19, Philippe Gerum wrote:
>>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> On 07.06.21 17:04, Philippe Gerum wrote:
>>>>>>
>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>
>>>>>>> On 07.06.21 15:48, Jan Kiszka wrote:
>>>>>>>> On 07.06.21 15:44, Jan Kiszka wrote:
>>>>>>>>> On 07.06.21 15:03, Philippe Gerum wrote:
>>>>>>>>>>
>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>
>>>>>>>>>>> On 07.06.21 09:17, Philippe Gerum wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>>>
>>>>>>>>>>>>> On 06.06.21 16:43, Philippe Gerum via Xenomai wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Jan Kiszka <jan.kiszka@web.de> writes:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The correct order is hard IRQs off first, then stalling inband, see also
>>>>>>>>>>>>>>> I-pipe. Otherwise, we risk to take an interrupt for the inband stage but
>>>>>>>>>>>>>>> do not inject it before returning to user space.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Fixes the RCU stalls Florian reported, at least for me.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I'm afraid this wasn't the last regression of translating I-pipe into
>>>>>>>>>>>>>>> dovetail..
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>  include/linux/entry-common.h | 3 ++-
>>>>>>>>>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>>>>>>>>>>>>>>> index 0fb45b2d6094..00540110985e 100644
>>>>>>>>>>>>>>> --- a/include/linux/entry-common.h
>>>>>>>>>>>>>>> +++ b/include/linux/entry-common.h
>>>>>>>>>>>>>>> @@ -203,7 +203,8 @@ static inline void local_irq_disable_exit_to_user(void);
>>>>>>>>>>>>>>>  #ifndef local_irq_disable_exit_to_user
>>>>>>>>>>>>>>>  static inline void local_irq_disable_exit_to_user(void)
>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>> -	local_irq_disable_full();
>>>>>>>>>>>>>>> +	hard_cond_local_irq_disable();
>>>>>>>>>>>>>>> +	local_irq_disable();
>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>  #endif
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Good spot, real issue here, just like the CPU_IDLE code deals with. The
>>>>>>>>>>>>>> fix looks good, but maybe we could do even better.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The way local_irq_disable_full() works tends to introduce this issue in
>>>>>>>>>>>>>> a sneaky way, when the code path does not synchronize the interrupt log
>>>>>>>>>>>>>> (exit_to_user_mode_loop may be at fault in this case, which does not
>>>>>>>>>>>>>> traverses synchronize_pipeline()). Lack of synchronization would still
>>>>>>>>>>>>>> hit us if some trap handler turns hard irqs off -> on -> off the same
>>>>>>>>>>>>>> way, and we don't leave through the user exit path.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Inverting the order of the actions in local_irq_disable_full() may be an
>>>>>>>>>>>>>> option (inband_irq_disable would allow that), making sure we cannot be
>>>>>>>>>>>>>> caught in the same issue when returning to kernel mode is another
>>>>>>>>>>>>>> way. This needs more thought I think.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> So, always this way?
>>>>>>>>>>>>>
>>>>>>>>>>>>> local_irq_disable_full:
>>>>>>>>>>>>> 	hard_local_irq_disable	
>>>>>>>>>>>>> 	local_irq_disable
>>>>>>>>>>>>>
>>>>>>>>>>>>> local_irq_enable_full:
>>>>>>>>>>>>> 	hard_local_irq_enable
>>>>>>>>>>>>> 	local_irq_enable
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Yes.
>>>>>>>>>>>>
>>>>>>>>>>>>> Or even flip local_irq_enable_full as well?
>>>>>>>>>>>>
>>>>>>>>>>>> Not this one, hard irqs must be on before local_irq_enable() is issued
>>>>>>>>>>>> otherwise we would trigger a debug assertion. The reason for such
>>>>>>>>>>>> assertion is that the I-pipe version of local_irq_enable() force enables
>>>>>>>>>>>> hard irqs on, and this is something we want to depart from because
>>>>>>>>>>>> whether the caller expects or not such side-effect is error-prone. For
>>>>>>>>>>>> this reason, inband_irq_enable() expects hard irqs on, which should be
>>>>>>>>>>>> the current hard irq state for the caller under normal circumstances.
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Was there ever code that required ordering local_irq_disable_full the
>>>>>>>>>>>>> other way around?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> After review, I don't think so. The current order for
>>>>>>>>>>>> local_irq_disable_full() was rather determined by applying a reverse
>>>>>>>>>>>> sequence compared to local_irq_enable_full(). So this looks good. I need
>>>>>>>>>>>> to test this on the armv[7/8] side here first before merging.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Is there a commit somewhere that I can drop already?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> 1. These are fine with me in their latest iteration:
>>>>>>>>>>
>>>>>>>>>>   irq_pipeline: Clean up stage_info field and users
>>>>>>>>>>   irq_pipeline: Account for stage migration across faults
>>>>>>>>>>   irq_pipeline: Warn when calling irqentry_enter with oob stalled
>>>>>>>>>>   x86: dovetail: Fix TS flag reservation
>>>>>>>>>>
>>>>>>>>>> 2. This one should be replaced by a fix in local_irq_disable_full(),
>>>>>>>>>> pending some tests ongoing here:
>>>>>>>>>>
>>>>>>>>>> irq_pipeline: Prevent returning to user space with pending inband IRQs
>>>>>>>>>>
>>>>>>>>>> However, as I mentioned earlier, this may not be sufficient per se, we
>>>>>>>>>> may have to synchronize the in-band log when unstalling the stage on the
>>>>>>>>>> kernel exit path, i.e. the exit point fixed up by the "Account for stage
>>>>>>>>>> migration across faults" patch. This would address the following
>>>>>>>>>> scenario:
>>>>>>>>>>
>>>>>>>>>>         irqentry_enter on kernel context:
>>>>>>>>>>                        stall_inband();
>>>>>>>>>>                                 trap_handler();
>>>>>>>>>>                                         hard_local_irq_enable()
>>>>>>>>>>                                         hard_local_irq_disable()
>>>>>>>>>>                        if (state.stage_info == IRQENTRY_INBAND_UNSTALLED ||
>>>>>>>>>>                            state.stage_info == IRQENTRY_OOB) {
>>>>>>>>>>                              unstall_inband();
>>>>>>>>>>                        	     synchronize_pipeline();
>>>>>>>>>
>>>>>>>>> Oh, unstall_inband does not synchronize? Because of
>>>>>>>>> hard_local_irq_disable or in general?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ah, found it - unstall != inband_irq_enable. Why not using the latter
>>>>>>>> directly?
>>>>>>>>
>>>>>>>
>>>>>>> ...because it's instrumented to detect hard_irqs_disabled.
>>>>>>>
>>>>>>> Can we safely sync at that point?
>>>>>>
>>>>>> Yes we may do this, because we restore the original -unstalled- state of
>>>>>> the in-band stage. So if we have pending IRQs, we may play them at this
>>>>>> point. What we may not do obviously, is creating synchronization points
>>>>>> where the kernel does not expect irqs.
>>>>>>
>>>>>
>>>>> Again: When will any reschedules that might be requested by those
>>>>> replayed IRQs be handled then?
>>>>>
>>>>
>>>> Nowhere unless we provide a log synchronization routine dedicated to the
>>>> in-band kernel exit path, which would fold in the rescheduling call via
>>>> irqentry_exit_cond_resched(). I'll write that one.
>>>>
>>>
>>> How about simply moving the replay up, before the kernel checks for
>>> pending reschedules anyway? We can stall inband then again, to please
>>> lockdep & Co., as long as there is no hard-irq-on section before the intret.
>>>
>>
>> Yes, this is the right way to do this. I'm on it.
> 
> Please test this (heavily) with cobalt. This survived a 2-hours long kvm
> test here, running loops of the evl test suite + hackbench over 64 vcpus,
> so far so good. No reason for any difference in behavior between cobalt
> and evl in this area, this is merely a dovetail business.
> 
> commit 30808d958277a525baad33f3c68ccb7910dc3176 (HEAD -> rebase/v5.10.y-evl)
> Author: Philippe Gerum <rpm@xenomai.org>
> 
>     genirq: irq_pipeline: synchronize log on irq exit to kernel
>     
>     We must make sure to play any IRQ which might be pending in the
>     in-band log before leaving an interrupt frame for a preempted kernel
>     context.
>     
>     This completes "irq_pipeline: Account for stage migration across
>     faults", so that we synchronize the log once the in-band stage is
>     unstalled. In addition, we also care to do this before
>     preempt_schedule_irq() runs, so that we won't miss any rescheduling
>     request which might have been triggered by some IRQ we just played.
>     
>     Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>     Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 4e81c0c03e5726a..99512307537561b 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -477,8 +477,57 @@ bool irqexit_may_preempt_schedule(irqentry_state_t state,
>  
>  #endif
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +
> +static bool irqentry_syncstage(irqentry_state_t state) /* hard irqs off */
> +{
> +	/*
> +	 * If pipelining interrupts, enable in-band IRQs then
> +	 * synchronize the interrupt log on exit if:
> +	 *
> +	 * - irqentry_enter() stalled the stage in order to mirror the
> +	 * hardware state.
> +	 *
> +	 * - we where coming from oob, thus went through a stage migration
> +	 * that was caused by taking a CPU exception, e.g., a fault.
> +	 *
> +	 * We run before preempt_schedule_irq() may be called later on
> +	 * by preemptible kernels, so that any rescheduling request
> +	 * triggered by in-band IRQ handlers is considered.
> +	 */
> +	if (state.stage_info == IRQENTRY_INBAND_UNSTALLED ||
> +		state.stage_info == IRQENTRY_OOB) {
> +		unstall_inband_nocheck();
> +		synchronize_pipeline_on_irq();
> +		stall_inband_nocheck();
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void irqentry_unstall(void)
> +{
> +	unstall_inband_nocheck();
> +}
> +
> +#else
> +
> +static bool irqentry_syncstage(irqentry_state_t state)
> +{
> +	return false;
> +}
> +
> +static void irqentry_unstall(void)
> +{
> +}
> +
> +#endif
> +
>  noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  {
> +	bool synchronized = false;
> +
>  	if (running_oob())
>  		return;
>  
> @@ -488,7 +537,11 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  	if (user_mode(regs)) {
>  		irqentry_exit_to_user_mode(regs);
>  		return;
> -	} else if (irqexit_may_preempt_schedule(state, regs)) {
> +	}
> +
> +	synchronized = irqentry_syncstage(state);
> +
> +	if (irqexit_may_preempt_schedule(state, regs)) {
>  		/*
>  		 * If RCU was not watching on entry this needs to be done
>  		 * carefully and needs the same ordering of lockdep/tracing
> @@ -521,17 +574,9 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  	}
>  
>  out:
> -#ifdef CONFIG_IRQ_PIPELINE
> -	/*
> -	 * If pipelining interrupts, clear the in-band stall bit if
> -	 * irqentry_enter() raised it in order to mirror the hardware
> -	 * state. Also clear it when we where coming from oob, thus went
> -	 * through a migration that was caused by taking, e.g., a fault.
> -	 */
> -	if (state.stage_info == IRQENTRY_INBAND_UNSTALLED ||
> -	    state.stage_info == IRQENTRY_OOB)
> -		unstall_inband();
> -#endif
> +	if (synchronized)
> +		irqentry_unstall();
> +
>  	return;
>  }
>  
> 

I've put that into a staging/v5.10.y-dovetail branch, pointed
xenomai-images to that and started a run in our lab. That should give us
some confidence that things work under cobalt across all archs, and we
can make that commit official.

However, heavy stressing would require triggering migration-on-fault in
tighter loops while running something like stress-ng in the background.
Maybe it would make sense to add such a pattern to the switchtest (would
also require a way to silence the related kernel warnings during
runtime, not only build-time)?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

