Message-ID: <43EB1CCA.9040204@domain.hid>
Date: Thu, 09 Feb 2006 11:43:22 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (final)
References: <b647ffbd0602070104s63275903q@domain.hid>	<43E86F4D.4050400@domain.hid>	<43E8DFC4.4010805@domain.hid>
	<43E9CE95.3070806@domain.hid> <43EAFD8B.7020400@domain.hid>
	<43EB1279.3040902@domain.hid>
In-Reply-To: <43EB1279.3040902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Anders Blomdell wrote:
> 
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Wolfgang Grandegger wrote:
>>>>
>>>>> Hello,
>>>>>
>>>>> Dmitry Adamushko wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> this is the final set of patches against the SVN trunk of 2006-02-03.
>>>>>>
>>>>>> It addresses mostly remarks concerning naming (XN_ISR_ISA ->
>>>>>> XN_ISR_EDGE), a few cleanups and updated comments.
>>>>>>
>>>>>> Functionally, the support for shared interrupts (a few flags) to the
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> Not directly your fault: the increasing number of return flags for IRQ
>>>> handlers makes me worry that they are used correctly. I can figure out
>>>> what they mean (not yet that clearly from the docs), but does someone
>>>> else understand all this:
>>>>
>>>> - RT_INTR_HANDLED
>>>
>>>
>>>
>>>
>>> ISR says it has handled the IRQ, and does not want any propagation to 
>>> take place down the pipeline. IOW, the IRQ processing stops there.
>>
>>
>> This says that the interrupt will be ->end'ed at some later time 
>> (perhaps in the interrupt handler task)
>>
> 
> The ISR may end the IRQ before returning, or leave it to the nucleus 
> upon return by adding the ENABLE bit.
> 
>>>> - RT_INTR_CHAINED
>>>
>>>
>>>
>>>
>>> ISR says it wants the IRQ to be propagated down the pipeline. Nothing 
>>> is said about the fact that the last ISR did or did not handle the 
>>> IRQ locally; this is irrelevant.
>>
>>
>> This says that the interrupt will eventually be ->end'ed by some later 
>> stage in the pipeline.
>>
>>>> - RT_INTR_ENABLE
>>>
>>>
>>>
>>>
>>> ISR requests the interrupt dispatcher to re-enable the IRQ line upon 
>>> return (cumulable with HANDLED/CHAINED).
>>
>>
> 
> This is wrong; we should only associate this to HANDLED; sorry.
> 
>> This says that the interrupt will be ->end'ed when this interrupt 
>> handler returns.
>>
>>>
>>>> - RT_INTR_NOINT
>>>>
>>>
>>> This new one comes from Dmitry's patch for shared IRQ support AFAICS. 
>>> It would mean to continue processing the chain of handlers because 
>>> the last ISR invoked was not concerned by the outstanding IRQ.
>>
>>
>> Sounds like RT_INTR_CHAINED, except that it's for the current pipeline 
>> stage?
>>
> 
> Basically, yes.
> 
>> Now for the quiz question (powerpc arch):
>>
>>   1. Assume an edge triggered interrupt
>>   2. The RT-handler returns RT_INTR_ENABLE | RT_INTR_ENABLE (i.e. shared
>>      interrupt, but no problem since it's edge-triggered)
> 
> 
> ( Assuming RT_INTR_CHAINED | RT_INTR_ENABLE )
> 
>>   3. Interrupt gets ->end'ed right after RT-handler has returned
>>   4. Linux interrupt eventually handler starts its ->end() handler:
>>         local_irq_save_hw(flags);
>>         if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
>>           ipipe_irq_unlock(irq);
>>     // Next interrupt occurs here!
> 
> 
> It can't occur here: hw interrupts are off after local_irq_save_hw, and 
> unlocking some IRQ does not flush the IRQ log.
> 
>>         __ipipe_std_irq_dtype[irq].end(irq);
>>         local_irq_restore_hw(flags);
>>
>>
>> Wouldn't this lead to a lost interrupt? Or am I overly paranoid?
> 
> 
> This could happen, yep. Actually, this would be a possible misuse of the 
> ISR return values.
> If one chains the handler Adeos-wise, it is expected to leave the IC in 
> its original state wrt the processed interrupt. CHAINED should be seen 
> as mutually exclusive with ENABLE.
> 
>> My distinct feeling is that the return value should be a scalar and 
>> not a set!
>>
> 
> To sum up, the valid return values are HANDLED, HANDLED | ENABLE (*), 
> HANDLED | CHAINED and CHAINED. It's currently a set because I once 
> thought that the "handled" indication (or lack of) could be a valuable 
> information to gather at nucleus level to detect unhandled RT 
> interrupts. Fact is that we currently don't use this information, 
> though. IOW, we could indeed define some enum and have a scalar there 
> instead of a set; or we could just leave this as a set, but whine when 
> detecting the invalid ENABLE | CHAINED combination.

agile_programmer_mode_off();
realtime_programmer_hat_on();

I prefer programming errors to show up at compile time!

goto todays_work;

// Will never come here :-(
realtime_programmer_hat_off();
agile_programmer_mode_on();

-- 

Anders

