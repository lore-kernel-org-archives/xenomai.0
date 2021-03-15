References: <3511af9f-f393-a226-0e41-a23d8c1577c8@siemens.com>
 <87ft0xfyj4.fsf@xenomai.org>
 <4f5118a4-d362-7f18-fdcf-da22aabb7344@siemens.com>
 <87czw0g5b5.fsf@xenomai.org>
 <bf661a41-7ddf-196f-e57f-eb0be99ea565@siemens.com>
 <871rcgg34k.fsf@xenomai.org>
 <18836a78-09e7-9032-9b85-7e8b60c40d4f@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 5.4] x86: ipipe: Harden path between use_temporary_mm
 and unuse_temporary_mm
In-reply-to: <18836a78-09e7-9032-9b85-7e8b60c40d4f@siemens.com>
Date: Mon, 15 Mar 2021 13:11:01 +0100
Message-ID: <87sg4wehwq.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 15.03.21 10:47, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 15.03.21 10:00, Philippe Gerum wrote:
>>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> On 14.03.21 18:14, Philippe Gerum wrote:
>>>>>>
>>>>>> Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:
>>>>>>
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> This is only called during early init, e.g. for switching alternatives.
>>>>>>> Still, switch_mm_irqs_off would complain without this, and we are better
>>>>>>> safe than sorry.
>>>>>>>
>>>>>>
>>>>>> The way this is done in Dovetail is fragile too, since the protection we
>>>>>> have there still expects the pipeline entry code not to mess up on
>>>>>> handling an interrupt, which defeats the purpose of such
>>>>>> precaution. Besides, the temp_state should be snapshot under protection
>>>>>> too. IOW, IRQs should be hard disabled fully while using the temporary
>>>>>> mm.
>>>>>>
>>>>>> Upstreaming a similar patch for Dovetail.
>>>>>
>>>>> Just saw it: It's wrong as it left the hard_irq_save_full at the caller
>>>>> site. Would raise a warning when debugging is enabled. Please fix.
>>>>>
>>>>
>>>> I guess you mean local_irq_save_full(). After a second look, the hard
>>>> irqs off section should cover the entire code poking new text into a
>>>> live kernel. This is what switching to the _full() forms enforced
>>>> already. So I see no point in changing the IRQ state in the use/unuse
>>>> helpers eventually.
>>>
>>> Right, either way is needed. If the tlb flush should be fully protected,
>>> the existing pattern is needed. But maybe more:
>>>
>>> Under I-pipe, playing with full disabling didn't work out well. Some
>>> spinlock function called via get_locked_pte reenabled hard IRQs. Not
>>> sure if dovetail is affected by that as well.
>>>
>> 
>> In the case at hand, the PTE of the poking address is locked and
>> returned outside of the locked section, so this should not be a concern
>> for live patching.
>> 
>
> Yeah, I'm carrying this now:
>
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index cbaa584a9f23..affc594cc939 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -808,6 +808,7 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
>  	temp_mm_state_t temp_state;
>  
>  	lockdep_assert_irqs_disabled();
> +	WARN_ON_ONCE(irq_pipeline_debug() && !hard_irqs_disabled());
>  
>  	/*
>  	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
> @@ -821,8 +822,6 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
>  	 * unuse_temporary_mm() assumes hardirqs were off on entry to
>  	 * use_temporary_mm(), assert this condition.
>  	 */
> -	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
> -	hard_cond_local_irq_disable();
>  	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
>  	switch_mm_irqs_off(NULL, mm, current);
>  
> @@ -846,8 +845,8 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
>  static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
>  {
>  	lockdep_assert_irqs_disabled();
> +	WARN_ON_ONCE(irq_pipeline_debug() && !hard_irqs_disabled());
>  	switch_mm_irqs_off(NULL, prev_state.mm, current);
> -	hard_cond_local_irq_enable();
>  
>  	/*
>  	 * Restore the breakpoints if they were disabled before the temporary mm
>
> And no warnings so far.
>
> Jan


I have almost the same here for Dovetail, except that I'm not
duplicating the assertion in unuse_temporary_mm since there is no reason
for the hard irq state flipping in between. No issue observed either.

-- 
Philippe.

