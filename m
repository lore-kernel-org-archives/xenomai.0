From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
Date: Tue, 1 Nov 2005 12:46:53 +0100
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
	<200510312202.07522.dmitry.adamushko@domain.hid>
	<43673A30.4080807@domain.hid>
In-Reply-To: <43673A30.4080807@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011246.54124.dmitry.adamushko@domain.hid>
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

On Tuesday 01 November 2005 10:49, you wrote:

> > In that case, the nucleus must keep track of all the irqs, i.e.
> > some_struct irqs[IPIPE_NR_IRQS]. Ok, the rthal_realtime_irq[] may be
> > removed here from hal.
> > But there is already the per-irq array in ipipe_domain struct. Having got
> > [1] and [2] merged, we would have this array as the only one and avoid
> > the use of rthal_realtime_irq[] at all. Although, the ipipe_domain would
> > become a bit more heavy :) Well, but [2] into [3] is leeeess intrusive on
> > the other hand.
>
> Due to the intrusiveness, I would vote for a [2]->[3] merge.

Yep, obviously.

What about something like this:

[hal/generic.c]

struct rthal_realtime_irq_t {

	struct xnintr_t *handlers; // or xnqueue_t handlers;
	unsigned long hits[RTHAL_NR_CPUS];

	// maybe something else

} rthal_realtime_irq[IPIPE_NR_IRQS];

either this array should be exported so to be available from the nucleus layer 
or should be moved into the nucleus layer completely, but so far I like the 
idea the HAL handles basic irq-related chores, if no then e.g. what to do 
with rthal_linux_irq, apc counterparts.

struct xnintr_t is extended as follows:

...
unsigned flags;		// e.g. IRQ_SHARED
const char *name;
struct xnintr_t *next; // or xnholder_t hlink;
};

actually, xniack_t iack field should gone or a policy on its use should be 
established. e.g. what if a few handlers that share the same irq want to set 
up its own iack handler. I see that it's not a part of the rtdm's 
request_irq() interface (always NULL so that the default one is used) but a 
part of the native and posix skins' interfaces (e.g. rt_intr_create).

Another thing is how different return values of ISR handlers should be 
combined:
e.g. RT_INTR_CHAINED vs. HANDLED

first handler reports CHAINED, the second one - HANDLED and some of them - 
ENABLE.

[nucleus.c]

xnintr_irq_handler(unsigned irq, void *cookie) -> xnintr_irq_handler(unsigned 
irq)

Thus, it may be passed into rthal_virtualize_irq() and called directly from 
the ipipe layer (we don't need that hal::irq_trampoline() any more).

xnintr_irq_handler(unsigned irq)
{
- xnintr_t *intr = (xnintr_t *)cookie;
+ xnintr_t *handlers = hal_realtime_irq(irq)->handlers; // or get a queue 
otherwise
...
- s = intr->isr(intr);
+ iterate through all the handlers
...
}

err, hopefully that looks not like a complete mess, anyway that's what on the 
top of my head at the moment :)

>
> One issue remains in any case: the HAL currently maintains a /proc entry
> for the registered IRQs. It reports if a handler is registered and the
> IRQ hits per CPU. As I think this entry should also report the
> registered driver names in the future, we have to hand the management
> over to whatever part traces all registered handlers. Is this acceptable
> from the layering point of view?

But the same can be done from the HAL if we're still going to keep the per-irq 
array there as well as basic realtime-irq-related chores. Just in that case, 
the HAL would be aware about some extended information, like names.

>
> Jan

---
Best regards,
Dmitry

