From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45774C47.9050307@domain.hid>
References: <457686F3.1080008@domain.hid> <1165405238.7218.102.camel@domain.hid>
	<4576B1F1.5040604@domain.hid> <1165441950.7218.182.camel@domain.hid>
	<45774C47.9050307@domain.hid>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 10:18:45 +0100
Message-Id: <1165483125.30543.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: How to hook genirq best
Reply-To: rpm@xenomai.org
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
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

On Thu, 2006-12-07 at 00:03 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > Not for x86, ipipe_ack is always valid, and __ipipe_ack_irq() which
> > calls it is arch-dependent, so we are safe. Controlling the irq_chip
> 
> lapic_chip?
> 

This was missing from the last patch, since it introduces unconditional
acknowledge:

+ .ipipe_ack = lapic_noop_lapic

> Moreover, calling [ipipe_]ack is flow type specific. So you would also
> have to install a no-op handler for fasteoi chips e.g. Given that
> ioapic_chip seems to be used for both edge-triggered and fast irqs, your
> previous version looks better.

Actually, the general problem is that __ipipe_ack_irq() is not currently
flow type specific, albeit it should be. You need this routine to be
flow type aware to properly handle the primary ack/eoi cycle, and this
does not depend on the location where PIC routine calls have been voided
(i.e. generic or arch-dep/irq_chip section).

What we need is a set of companion routines to handle_<flowtype>_irq(),
each of which implementing the required acknowledge code, precisely the
one which has been removed or nop'ed from the original flow handlers.
__set_irq_handler() would then install a magic pointer in the IRQ
descriptor, calling back the right acknowledge code. The very inelegant
thing about that is that we would have to somehow select a companion
handler based on the known values of regular flow handler pointers, but
unless we patch all calls sites of set_irq_chip_and_handler*(), I don't
see another way to do it right now. The flow would look like this:

__ipipe_handle_irq -> irq_desc[irq].ipipe_acknowledge(irq) ->
irq_chip(irq)->ipipe_*

I will work on that in a few days.

[...]

> > This issue goes beyond the quick hack of masking recurring IRQs, and
> > IIRC, we discussed it briefly on this list some months ago. This is what
> > would bring a significant improvement wrt determinism.
> 
> As long as we do not fall back behind previous characteristics of
> I-pipe, I see no problem with addressing this in an even smarter way
> later. Is this patch equivalent, e.g. to 1.5's behaviour?
> 

Talking about edge IRQs, where recurring hits are specifically handled
by the regular Linux code, I see no difference. 2.6.17-1.5 used to let
the ->end() handlers deal with such issue, which it usually did by _not_
unmasking the interrupt channel upon recurring IRQ detection, whilst
2.6.19-1.6 detects this situation directly from the generic handling
code, then refrains from unmasking the source under the same condition.

> Jan
> 
-- 
Philippe.



