References: <0eb03889-d16d-3446-e07b-a4a36964ef15@web.de>
 <87lf7og30f.fsf@xenomai.org> <a538ec15-06cf-71cd-6680-a9cfd5a0892b@web.de>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [v5.13.y-dovetail][PATCH 2/2] irq_pipeline: Account for stage
 migration across faults
In-reply-to: <a538ec15-06cf-71cd-6680-a9cfd5a0892b@web.de>
Date: Sun, 06 Jun 2021 16:32:41 +0200
Message-ID: <87fsxvf4hi.fsf@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@web.de> writes:

> On 05.06.21 09:54, Philippe Gerum via Xenomai wrote:
>>
>> Jan Kiszka <jan.kiszka@web.de> writes:
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> We need to unstall the inband stage when we entered for a fault over OOB
>>> and unstalled and then migrated to inband. So far we kept the inband
>>> stage stalled, causing a state corruption this way.
>>>
>>> Introduce an additional state to irqentry_info for this, tracking the
>>> stalling state on OOB entry.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Note: Tested only as backport to 5.10-x86 so far.
>>>
>>>  include/linux/entry-common.h |  3 ++-
>>>  kernel/entry/common.c        | 10 +++++++---
>>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>>> index 2a08b00632b9..782e94b88076 100644
>>> --- a/include/linux/entry-common.h
>>> +++ b/include/linux/entry-common.h
>>> @@ -402,7 +402,8 @@ void irqentry_exit_to_user_mode(struct pt_regs *regs);
>>>  enum irqentry_info {
>>>  	IRQENTRY_INBAND_UNSTALLED = 0,
>>>  	IRQENTRY_INBAND_STALLED,
>>> -	IRQENTRY_OOB,
>>> +	IRQENTRY_OOB_UNSTALLED,
>>> +	IRQENTRY_OOB_STALLED,
>>>  };
>>>
>>>  #ifndef irqentry_state
>>> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>>> index 5a669f87ec3f..5f2ec6dba1a4 100644
>>> --- a/kernel/entry/common.c
>>> +++ b/kernel/entry/common.c
>>> @@ -410,7 +410,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>>>
>>>  #ifdef CONFIG_IRQ_PIPELINE
>>>  	if (running_oob()) {
>>> -		ret.stage_info = IRQENTRY_OOB;
>>> +		ret.stage_info = test_oob_stall() ? IRQENTRY_OOB_STALLED :
>>> +			IRQENTRY_OOB_UNSTALLED;
>>>  		return ret;
>>>  	}
>>>  #endif
>>> @@ -577,9 +578,12 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>>>  	/*
>>>  	 * If pipelining interrupts, clear the in-band stall bit if
>>>  	 * irqentry_enter() raised it in order to mirror the hardware
>>> -	 * state.
>>> +	 * state. Also clear it when we where coming from OOB_UNSTALLED,
>>> +	 * thus went through a migration that was caused by taking, e.g.,
>>> +	 * a fault.
>>>  	 */
>>> -	if (state.stage_info == IRQENTRY_INBAND_UNSTALLED)
>>> +	if (state.stage_info == IRQENTRY_INBAND_UNSTALLED ||
>>> +	    state.stage_info == IRQENTRY_OOB_UNSTALLED)
>>>  		unstall_inband();
>>>  #endif
>>>  	return;
>>
>> The logic of your previous patch was correct, this one is
>> not. IRQENTRY_OOB_UNSTALLED is useless and should not be used in this
>> context. We have all the guarantees and information we need at the exit
>> point above: we are running in-band, so if IRQENTRY_OOB was set on
>> entry, we must have downgraded the current execution stage in the
>> meantime.
>>
>> The stall bit for the oob stage would be almost always cleared, except
>> when/if a synchronous fault is taken while the pipeline is entirely
>> locked, e.g. hard_spin_lock+irqsave held then oops, which should never
>> happen unless the code is doing something silly. In this case, we would
>> still want the in-band stage to be unstalled on exit after the faulting
>> task is demoted from a mere logic standpoint, although without much hope
>> for the kernel sanity afterwards. Typically, the oob stage must not be
>> stalled when raw_copy_to/from_user() is invoked. IOW, this new state is
>> not conveying any valuable information.
>>
>> Please resend a new iteration of your first patch, dropping the redundant
>> check for running_inband(), this one would be fine.
>>
>
> I would prefer adding a check that detects the folded case (OOB stalled
> on entry, inband on exit) and issue a warning. Or is this caught and
> reported elsewhere already?
>

That case is superseded by the one I just described: taking a trap over
the oob stage when it is stalled is in and of itself a sign of deep
breakage (i.e. when the stall bit is set for the oob stage, not only
when irqs are hard disabled in the CPU). We don't have to wait for a
transition to the in-band stage to determine that. Therefore, the
following snippet would be enough to trap the issue.

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 3582348767c2097..ffe98640ecc4a54 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -410,6 +410,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 
 #ifdef CONFIG_IRQ_PIPELINE
 	if (running_oob()) {
+		WARN_ON_ONCE(irq_pipeline_debug() && oob_irqs_disabled());
 		ret.stage_info = IRQENTRY_OOB_ENTRY;
 		return ret;
 	}


-- 
Philippe.

