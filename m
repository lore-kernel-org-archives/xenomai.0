From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4576B1F1.5040604@domain.hid>
References: <457686F3.1080008@domain.hid> <1165405238.7218.102.camel@domain.hid>
	<4576B1F1.5040604@domain.hid>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 22:52:30 +0100
Message-Id: <1165441950.7218.182.camel@domain.hid>
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

On Wed, 2006-12-06 at 13:05 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:

[...]

> > The other important issue is that patching the call sites does not
> > preclude from analysing each and every PIC control routine, for ironing
> > them. When the number of PICs is small enough, it's clearly safer to
> > have all changes at one location (i.e. the PIC management file). At
> > least, you know what has been adapted; but it's (only) a matter of
> > (maintainer's) taste.
> 
> Having a look at new/updated PIC code is one (unavoidable) thing,
> actually having to touch it and keeping the changes in sync even with
> only minor style changes or the code is another.
> 

It's not a problem to fix minor style changes in arch-dep code; but it
can be very annoying to forget important changes in generic the code. So
your argument cuts both ways. Really, it's a matter of where one thinks
the code is going to change in the most significant way. Regarding x86
(and I'm not arguing for any other arch, here), I see less changes to
happen in the PIC-dependent routines, than at their call sites, as more
archs are being converted to use the genirq layer. In any case, I don't
see this issue as being critical; it would be easy to change the
implementation overnight without any drawback imposed on client code.

[...]

> > 
> > --- arch/i386/kernel/ipipe.c~	2006-12-03 18:12:59.000000000 +0100
> > +++ arch/i386/kernel/ipipe.c	2006-12-06 12:36:21.000000000 +0100
> > @@ -167,10 +167,12 @@
> >  static int __ipipe_ack_irq(unsigned irq)
> >  {
> >  	irq_desc_t *desc = irq_desc + irq;
> > +
> > +	desc->chip->ipipe_ack(irq);
> > +
> 
> Might be NULL for some chips like fasteoi ones, no?
> 

Not for x86, ipipe_ack is always valid, and __ipipe_ack_irq() which
calls it is arch-dependent, so we are safe. Controlling the irq_chip
descriptor, instead of generalizing the logic from the generic code
(which could not have told you that), is an advantage here.

> >  	if (desc->handle_irq == &handle_fasteoi_irq)
> >  		desc->chip->ipipe_eoi(irq);
> > -	else
> > -		desc->chip->ipipe_ack(irq);
> > +
> >  	return 1;
> >  }
> >  
> > This is not relevant to the way we hook genirq though; we need to handle
> > this in the primary I-pipe handler anyway.
> > 
> >>  Generally, the question remains for me
> >> if at least IRQs arriving to a stalled I-pipe domain should always be
> >> masked on ack and unmask when being replayed.
> > 
> > What particular (problematic) case do you have in mind regarding this?
> 
> Recurring IRQs of the same source to a stalled domain, potentially
> disturbing a higher prio domain (even if they do not get beyond I-pipe
> core stubs). -rt has to deal with the same issue for low-prio threaded
> IRQs, and I don't see a reason yet why we should differ when they keep
> the line masked after the first or the second event.
> 

This problem should be addressed at a higher level: how do we prevent
low-priority IRQs from ever happening when a high priority domain is
running, so that such IRQs could not even hit the primary Adeos handler.
Currently, the pipeline head optimization avoids such perturbation when
the high priority domain is stalled by masking the interrupts at CPU
level; what we need is to extend this to the unstalled state.

This issue goes beyond the quick hack of masking recurring IRQs, and
IIRC, we discussed it briefly on this list some months ago. This is what
would bring a significant improvement wrt determinism.

> Jan
> 
-- 
Philippe.



