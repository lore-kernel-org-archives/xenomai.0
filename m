Message-ID: <43675659.7010004@domain.hid>
Date: Tue, 01 Nov 2005 12:49:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
	<43663262.80303@domain.hid>
In-Reply-To: <43663262.80303@domain.hid>
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Dmitry Adamushko wrote:
> 
>>Hi Jan,
>>
>>
>>>I have some code hanging around here which implements IRQ sharing at
>>>skin level for an experimental in-house development over Xenomai. The
>>>code is smart enough to register an IRQ sharing trampoline handler only
>>>in case sharing is actually practiced for a specific line.
>>
>>Could you be a bit more specific on what is meant by "...sharing is
>>actually practiced for a specific line"?
> 
> 
> Ok, one have to remind that my existing code is built on top of the
> non-sharing xnintr_xxx API. This means that I had to define a trampoline
> ISR which does the loop over all registered end-user ISRs. And this
> intermediate handler is only involved when A) the IRQ is sharable and B)
> there is actually more than one ISR registered for it.
> 
> This "smartness" becomes obsolete when we embed a doubly-linked list
> into xnintr_t and already iterate over it in xnintr_irq_handler().
> 
> 
>>To my knowledge, the matter is only about whether a certain device (driver)
>>permits the earlier obtained irq line to be shared with other devices.
>>i.e. a driver [1] may succeed with an irq registration request in case
>>another driver [2] already holds this line but both [1] and [2] have
>>specified a SA_SHIRQ flag.
> 
> 
> Yep.
> 
> 
>>
>>>I think it would be possible to break this out and generate a mainline
>>>patch. Anyway, the question for me is where to put this best, at skin
>>>(RTDM?) or at nucleus level? Both is technically feasible, but which way
>>>is desired? (I would vote for the nucleus...)
>>
>>If we have a policy that all the drivers should be implemented on top of
>>RTDM, then, it can be done there. If no (and I guess so), this feature
>>should be common and I'd vote for the nucleus.
> 
> 
> Drivers should be built over RTDM, that's true. But there may still be
> driver-like applications, also in user space that attach directly to the
> IRQs via the various skin APIs. I think it would be good to let them
> live side-by-side with RTDM drivers or other IRQ-using applications.
> 
> 
>>It seems to me now, that some parts of the hal will be involved
>>(rthal_irq_request/release()) since the nucleus itself doesn't keep track
>>of registered irqs.
> 
> 
> That's true. And it also raises another question to me: why do we have
> those two different IRQ models?
> 
> The HAL only one handler per IRQ which get called with the triggering
> IRQ number. That handler will call the nucleus with an attached cookie.
> And on the other side is the nucleus which works with a xnintr_t per
> IRQ. The xnintr_irq_handler() deals with things like re-enabling IRQs,
> rescheduling, etc.
> 
> I'm asking as this abstraction adds one trampoline call (at HAL level),
> thus may lead to more I-cache misses. Isn't it worth considering some
> HAL mechanisms based on more #defines and static inlines in this regard?
> 

While we are at it, we could just move the HAL's trampoline part to the 
arch/system.h support. Two things to keep in mind: Adeos does not provide 
cookies (yeah, what a pity), but passes an IRQ number the xnarch level doesn't 
grok. Some low-level prototypes would have to be fixed and the cookie array 
moved, but basically, getting rid of the initial trampoline seems like a good 
idea since it brings nothing in the picture.

> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

