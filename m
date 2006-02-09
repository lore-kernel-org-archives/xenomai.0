Message-ID: <43EAFD8B.7020400@domain.hid>
Date: Thu, 09 Feb 2006 09:30:03 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (final)
References: <b647ffbd0602070104s63275903q@domain.hid>	<43E86F4D.4050400@domain.hid>	<43E8DFC4.4010805@domain.hid>
	<43E9CE95.3070806@domain.hid>
In-Reply-To: <43E9CE95.3070806@domain.hid>
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
> Jan Kiszka wrote:
> 
>> Wolfgang Grandegger wrote:
>>
>>> Hello,
>>>
>>> Dmitry Adamushko wrote:
>>>
>>>> Hi,
>>>>
>>>> this is the final set of patches against the SVN trunk of 2006-02-03.
>>>>
>>>> It addresses mostly remarks concerning naming (XN_ISR_ISA ->
>>>> XN_ISR_EDGE), a few cleanups and updated comments.
>>>>
>>>> Functionally, the support for shared interrupts (a few flags) to the
>>
>>
>>
>> Not directly your fault: the increasing number of return flags for IRQ
>> handlers makes me worry that they are used correctly. I can figure out
>> what they mean (not yet that clearly from the docs), but does someone
>> else understand all this:
>>
>> - RT_INTR_HANDLED
> 
> 
> ISR says it has handled the IRQ, and does not want any propagation to 
> take place down the pipeline. IOW, the IRQ processing stops there.
This says that the interrupt will be ->end'ed at some later time (perhaps in the 
interrupt handler task)

>> - RT_INTR_CHAINED
> 
> 
> ISR says it wants the IRQ to be propagated down the pipeline. Nothing is 
> said about the fact that the last ISR did or did not handle the IRQ 
> locally; this is irrelevant.
This says that the interrupt will eventually be ->end'ed by some later stage in 
the pipeline.

>> - RT_INTR_ENABLE
> 
> 
> ISR requests the interrupt dispatcher to re-enable the IRQ line upon 
> return (cumulable with HANDLED/CHAINED).
This says that the interrupt will be ->end'ed when this interrupt handler returns.

> 
>> - RT_INTR_NOINT
>>
> 
> This new one comes from Dmitry's patch for shared IRQ support AFAICS. It 
> would mean to continue processing the chain of handlers because the last 
> ISR invoked was not concerned by the outstanding IRQ.
Sounds like RT_INTR_CHAINED, except that it's for the current pipeline stage?

Now for the quiz question (powerpc arch):

   1. Assume an edge triggered interrupt
   2. The RT-handler returns RT_INTR_ENABLE | RT_INTR_ENABLE (i.e. shared
      interrupt, but no problem since it's edge-triggered)
   3. Interrupt gets ->end'ed right after RT-handler has returned
   4. Linux interrupt eventually handler starts its ->end() handler:
         local_irq_save_hw(flags);
         if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
           ipipe_irq_unlock(irq);
	// Next interrupt occurs here!
         __ipipe_std_irq_dtype[irq].end(irq);
         local_irq_restore_hw(flags);


Wouldn't this lead to a lost interrupt? Or am I overly paranoid?
My distinct feeling is that the return value should be a scalar and not a set!
>...
>> I would vote for the (already scheduled?) extension to register an
>> optimised IRQ trampoline in case there is actually no sharing taking
>> place. This would also make the "if (irq == XNARCH_TIMER_IRQ)" path
>> obsolete.
> 
> 
> I support that. Shared interrupts should be handled properly by Xeno 
> since such - I'd say "last resort" - configuration could be needed; this 
> said, we should not see this as the rule but rather as the exception, 
> since this is basically required to solve some underlying hw limitations 
> wrt interrupt management, and definitely has a significant cost on 
> processing each shared IRQ wrt determinism.
> 
> Incidentally, there is an interesting optimization on the project's todo 
> list 
Is this todo list accessible anywhere?

 > that would allow non-RT interrupts to be masked at IC level when
> the Xenomai domain is active. We could do that on any arch with 
> civilized interrupt management, and that would prevent any asynchronous 
> diversion from the critical code when Xenomai is running RT tasks 
> (kernel or user-space). Think of this as some hw-controlled interrupt 
> shield. Since this feature requires to be able to individually mask each 
> interrupt source at IC level, there should be no point in sharing fully 
> vectored interrupts in such a configuration anyway. This fact also 
> pleads for having the shared IRQ support as a build-time option.

-- 
Anders Blomdell

