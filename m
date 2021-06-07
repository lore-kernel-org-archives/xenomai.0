References: <0531d2db-aa87-1950-6d7f-41c80d4fe679@web.de>
 <875yyrf3yo.fsf@xenomai.org>
 <c6633047-7570-294f-e0b0-ab74f0c2a33e@siemens.com>
 <87a6o2b0to.fsf@xenomai.org>
 <50f40c7f-ae8d-7ded-9dc7-91310f0d7909@siemens.com>
 <874ke9bzde.fsf@xenomai.org>
 <3814ce50-b6cd-04e3-587b-40197f905ef8@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] irq_pipeline: Prevent returning to user space with
 pending inband IRQs
In-reply-to: <3814ce50-b6cd-04e3-587b-40197f905ef8@siemens.com>
Date: Mon, 07 Jun 2021 16:36:46 +0200
Message-ID: <87sg1taght.fsf@xenomai.org>
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
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 07.06.21 15:03, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 07.06.21 09:17, Philippe Gerum wrote:
>>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> On 06.06.21 16:43, Philippe Gerum via Xenomai wrote:
>>>>>>
>>>>>> Jan Kiszka <jan.kiszka@web.de> writes:
>>>>>>
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> The correct order is hard IRQs off first, then stalling inband, see also
>>>>>>> I-pipe. Otherwise, we risk to take an interrupt for the inband stage but
>>>>>>> do not inject it before returning to user space.
>>>>>>>
>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Fixes the RCU stalls Florian reported, at least for me.
>>>>>>>
>>>>>>> I'm afraid this wasn't the last regression of translating I-pipe into
>>>>>>> dovetail..
>>>>>>>
>>>>>>>  include/linux/entry-common.h | 3 ++-
>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>>>>>>> index 0fb45b2d6094..00540110985e 100644
>>>>>>> --- a/include/linux/entry-common.h
>>>>>>> +++ b/include/linux/entry-common.h
>>>>>>> @@ -203,7 +203,8 @@ static inline void local_irq_disable_exit_to_user(void);
>>>>>>>  #ifndef local_irq_disable_exit_to_user
>>>>>>>  static inline void local_irq_disable_exit_to_user(void)
>>>>>>>  {
>>>>>>> -	local_irq_disable_full();
>>>>>>> +	hard_cond_local_irq_disable();
>>>>>>> +	local_irq_disable();
>>>>>>>  }
>>>>>>>  #endif
>>>>>>
>>>>>> Good spot, real issue here, just like the CPU_IDLE code deals with. The
>>>>>> fix looks good, but maybe we could do even better.
>>>>>>
>>>>>> The way local_irq_disable_full() works tends to introduce this issue in
>>>>>> a sneaky way, when the code path does not synchronize the interrupt log
>>>>>> (exit_to_user_mode_loop may be at fault in this case, which does not
>>>>>> traverses synchronize_pipeline()). Lack of synchronization would still
>>>>>> hit us if some trap handler turns hard irqs off -> on -> off the same
>>>>>> way, and we don't leave through the user exit path.
>>>>>>
>>>>>> Inverting the order of the actions in local_irq_disable_full() may be an
>>>>>> option (inband_irq_disable would allow that), making sure we cannot be
>>>>>> caught in the same issue when returning to kernel mode is another
>>>>>> way. This needs more thought I think.
>>>>>>
>>>>>
>>>>> So, always this way?
>>>>>
>>>>> local_irq_disable_full:
>>>>> 	hard_local_irq_disable	
>>>>> 	local_irq_disable
>>>>>
>>>>> local_irq_enable_full:
>>>>> 	hard_local_irq_enable
>>>>> 	local_irq_enable
>>>>>
>>>>
>>>> Yes.
>>>>
>>>>> Or even flip local_irq_enable_full as well?
>>>>
>>>> Not this one, hard irqs must be on before local_irq_enable() is issued
>>>> otherwise we would trigger a debug assertion. The reason for such
>>>> assertion is that the I-pipe version of local_irq_enable() force enables
>>>> hard irqs on, and this is something we want to depart from because
>>>> whether the caller expects or not such side-effect is error-prone. For
>>>> this reason, inband_irq_enable() expects hard irqs on, which should be
>>>> the current hard irq state for the caller under normal circumstances.
>>>>
>>>>>
>>>>> Was there ever code that required ordering local_irq_disable_full the
>>>>> other way around?
>>>>>
>>>>
>>>> After review, I don't think so. The current order for
>>>> local_irq_disable_full() was rather determined by applying a reverse
>>>> sequence compared to local_irq_enable_full(). So this looks good. I need
>>>> to test this on the armv[7/8] side here first before merging.
>>>>
>>>
>>> Is there a commit somewhere that I can drop already?
>>>
>> 
>> 1. These are fine with me in their latest iteration:
>> 
>>   irq_pipeline: Clean up stage_info field and users
>>   irq_pipeline: Account for stage migration across faults
>>   irq_pipeline: Warn when calling irqentry_enter with oob stalled
>>   x86: dovetail: Fix TS flag reservation
>> 
>> 2. This one should be replaced by a fix in local_irq_disable_full(),
>> pending some tests ongoing here:
>> 
>> irq_pipeline: Prevent returning to user space with pending inband IRQs
>> 
>> However, as I mentioned earlier, this may not be sufficient per se, we
>> may have to synchronize the in-band log when unstalling the stage on the
>> kernel exit path, i.e. the exit point fixed up by the "Account for stage
>> migration across faults" patch. This would address the following
>> scenario:
>> 
>>         irqentry_enter on kernel context:
>>                        stall_inband();
>>                                 trap_handler();
>>                                         hard_local_irq_enable()
>>                                         hard_local_irq_disable()
>>                        if (state.stage_info == IRQENTRY_INBAND_UNSTALLED ||
>>                            state.stage_info == IRQENTRY_OOB) {
>>                              unstall_inband();
>>                        	     synchronize_pipeline();
>
> Oh, unstall_inband does not synchronize? Because of
> hard_local_irq_disable or in general?
>

In general, this is only a bit flip. The caller has to do the right
thing afterwards, e.g. inband_irq_enable() or inband_irq_restore() do
so.

-- 
Philippe.

