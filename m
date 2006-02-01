Message-ID: <43E0CD23.7000502@domain.hid>
Date: Wed, 01 Feb 2006 16:00:51 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Are XN_ISR_CHAINED and XN_ISR_ENABLE mutually
	exclusive?
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>
	<43E0BEC1.2060400@domain.hid> <43E0CB30.7010102@domain.hid>
In-Reply-To: <43E0CB30.7010102@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Anders Blomdell wrote:
> 
>>While looking into how to implement sharing of interrupts between
>>realtime and non-realtime domains (and applying Wolfgang Grandegger's
>>patch [https://mail.gna.org/public/xenomai-core/2006-01/msg00233.html],
>>which is necessary to make XN_ISR_ENABLE work at all on the PowerPC
>>platform), I'm beginning to think that XN_ISR_CHAINED and XN_ISR_ENABLE
>>are mutually exclusive, since if both are set, desc->handler->end will
>>be called twice:
>>
>>  1. When the realtime isr handler returns
>>  2. When the Linux domain calls it in __do_IRQ
> 
> 
> Yes, those bits are semantically exclusive. Actually, I think passing
> both bits could even cause deadlocks if the RT-IRQ is raised again
> before the non-RT handler got a chance to clear the IRQ source in hardware.
My impression as well, but it's nowhere documented, nor enforced in the code.

> 
> 
>>In the solution I have in mind at the moment, I will:
>>
>>  1. Add an extra iend handler argument to xnintr_init
>>  2. If XN_ISR_ENABLE is returned from the isr handler,
>>     replace desc->handler->end with the user supplied
>>     iend handler.
>>
>>Hereby I hope to be able to handle interrupts shared between realtime
>>and non-realtime domain, without having the realtime domain wait for all
>>non-realtime interrupts to finish. This is the scenario I'm thinking of:
>>
>>  1. A non-RT interrupt occurs
>>  2. The (RT) isr handler detects the non-RT interrupt,
>>     disables further non-RT interrupts on that irq-vector, replaces
> 
> 
> This remains vague to me. How precisely will you disable? I guess at
> hardware level, i.e. in a (non-RT) device-specific way: switch off the
> bit in some hardware register that says "this device can produce IRQs",
> right?
Yes.

> 
> 
>>     desc->handler->end with the user supplied iend handler,
>>     returns XN_ISR_CHAINED | XN_ISR_ENABLE.
>>  3. RT interrupts are serviced by the (RT) isr handler,
>>     returns XN_ISR_ENABLE
>>  4. The Linux domain get a chance to run the chained interrupt,
>>     and eventually calls desc->handler->end (supplied iend handler)
>>  5. The iend handler reenables non-RT interrupts.
> 
> 
> Then this would switch on that bit again? Note that this may require to
> synchronise the hardware access with parts of the non-RT driver.
If the non-RT driver sets that bit in its ISR routine, yes. I have the (overly 
optimistic?) view that the non-RT ISR only does whatever is necessary to clear 
the interrupt and leaves the enable/disable bits untouched.

>  Meanwhile I recalled that my hack to realise IRQ sharing between a RT
> device and a non-RT eepro100 is filed on a public archive:
> 
> https://mail.gna.org/public/xenomai-core/2005-11/msg00012.html
Thanks, I'll take a look at it.

-- 

Anders Blomdell

