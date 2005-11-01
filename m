Message-ID: <43675AB8.8000109@domain.hid>
Date: Tue, 01 Nov 2005 13:08:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>	<43663262.80303@domain.hid>	<200510312121.14160.dmitry.adamushko@domain.hid>
	<436680D5.4010105@domain.hid>
In-Reply-To: <436680D5.4010105@domain.hid>
Content-Type: text/plain; charset=KOI8-R; format=flowed
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
>>On Monday 31 October 2005 16:04, you wrote:
>>
>>
>>>Dmitry Adamushko wrote:
>>>
>>>
>>>>It seems to me now, that some parts of the hal will be involved
>>>>(rthal_irq_request/release()) since the nucleus itself doesn't keep track
>>>>of registered irqs.
>>>
>>>That's true. And it also raises another question to me: why do we have
>>>those two different IRQ models?
>>>
>>>The HAL only one handler per IRQ which get called with the triggering
>>>IRQ number. That handler will call the nucleus with an attached cookie.
>>>And on the other side is the nucleus which works with a xnintr_t per
>>>IRQ. The xnintr_irq_handler() deals with things like re-enabling IRQs,
>>>rescheduling, etc.
>>>
>>>I'm asking as this abstraction adds one trampoline call (at HAL level),
>>>thus may lead to more I-cache misses. Isn't it worth considering some
>>>HAL mechanisms based on more #defines and static inlines in this regard?
>>
>>
>>Let's take a look at what we have got currently:
>>
>>[1] 	ipipe_domain::irqs[IPIPE_NR_IRQS]	[ADEOS-IPIPE]
>>
>>the handler is defined as void (*handler)(unsigned irq);
>>
>>in our case, this is rthal_irq_trampoline() [2] , but can be different for 
>>some other cases;
>>
>>[2] 	rthal_irq_trampoline()				[HAL]
>>
>>struct rthal_realtime_irq[IPIPE_NR_IRQS]
>>
>>the handler is defined as void (*handler)(unsigned irq, void *cookie);
>>
>>this one normally does a simple thing, just calls xnintr_irq_handler() [3] as 
>>you have mentioned before.
>>
>>[3] 	xnintr_irq_handler()				[nucleus]
>> 
>>this routine calls a certain user's ISR as well as handles some 
>>nucleus-specific chores (re-scheduling, etc.)
>>
>>[4]	user's ISR						[user driver]
>>
>>does user-specific things
>>
>>Well, [3] is necessary anyway since some nucleus-related chores must be done 
>>and this is a correct layer for that (e.g. [2] knows nothing about 
>>scheduling).
>>
>>What can be theoretically merged is [1] + [2] (errr... I said theoretically, 
>>it's still not the case to kill me for just having said that :o). To this 
>>end, ipipe_domain should be extended in order to contain all the fields of 
>>[2]::struct rthal_realtime_irq (at least, handler(irq, cookie) + cookie).
>>btw, ipipe_domain::irqs may even contain a pointer to the slightly modified 
>>xnintr_t structure (which is really e.g. a circular list) that may be passed 
>>as "cockie" to the xnintr_irq_handler().
>>
>>The analogy is irq_desc_t vs. irqaction structures in Linux.
>>
>>This way, xnintr_irq_handler() can be called from adeos-ipipe layer directly 
>>without the [2] layer.
>>
>>But that change looks quite invasive to me so far since 
>>ipipe_domain::irqs::handler(irq - with a single parameter) is used all over 
>>the map.
>>
>>In our case, the relation between xnintr_irq_handler() and 
>>rthal_irq_trampoline() is 1:1. The first one does much more things that the 
>>second one which is really almost a pure redirection layer.
>>Hopefully, xnintr_irq_handler() is i-cache-hot as long as possible under high 
>>irq load. In this case, I guess, rthal_irq_trampoline() will be in cache as 
>>well (since it's really small) and the overhead is only about having one 
>>array indexing op. and issuing a call via a pointer to the function 
>>(xnintr_irq_handler() in our case).
>>Do you think that really gives a significant overhead? Well, maybe so. I'm not 
>>a profie here anyway...
>>
> 
> 
> ...compared to the usefulness I still have to understand - yes.
> 
> Other option: what about merging [2] into [3], i.e. let
> xnintr_irq_handler deal with the translation IRQ number -> cookie?
> 

That's an option, yes. The other one being to teach Adeos to pass an additional 
cookie, but in such a case, only the i-pipe series would be upgraded to allow 
that, which would be a bit rude to people still currently relying on the legacy 
oldgen patches for running Xenomai. This said, at some point in time, upgrading 
will be necessary though.

> Philippe, I guess your wisdom is required here. Are we missing some
> important point in your design right now?
> 

Mmm, for the wisdom thing, please see there: 
http://fr.wikipedia.org/wiki/Mahatma_Gandhi

For the design issue, I agree that the initial trampoline is just a waste of 
cache lines and cycles. The only thing to keep in mind is to preserve a sensible 
layering so that the whole thing is still able to run over the event-driven 
simulation engine we have, but AFAICS, fixing the xnarch layer everywhere would 
grant that.

> Jan
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

