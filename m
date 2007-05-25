From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4656CFFA.1020001@domain.hid>
References: <4656C2D0.7000705@domain.hid>  <4656C583.5040303@domain.hid>
	<1180094224.20410.39.camel@domain.hid>  <4656CFFA.1020001@domain.hid>
Content-Type: text/plain
Date: Fri, 25 May 2007 14:56:56 +0200
Message-Id: <1180097816.20410.78.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Problem with interrupt enabling
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

On Fri, 2007-05-25 at 14:00 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2007-05-25 at 13:16 +0200, Jan Kiszka wrote:
> >> Johan Borkhuis wrote:
> >>> Hello,
> >>>
> >>> I am trying to create an RTDM interrupt handler for an external 
> >>> interrupt. I use a rtdm_irq_request, followed by a rtdm_irq_enable. This 
> >> The rtdm_irq_enable is no longer required with RTDM revision 6 and
> >> higher. But that's trunk, it's rev. 5 which still comes with Xenomai
> >> 2.3.x. And the enable will also cause no harm with rev. 6.
> >>
> >>> caused one interrupt to be processed, but subsequent interrupts were not 
> >>> processed.
> >>> After adding an extra rtdm_irq_enable to the ISR the interrupts are 
> >>> processed. When I look at the other drivers I don't see this. Is this 
> >>> needed, or is there a bug/feature in the interrupt handling on my platform?
> >>> (I use a MVME3100 with a ppc8540 processor and openPIC interrupt 
> >>> controller).
> >> What do you return with your IRQ handler? RTDM_IRQ_HANDLED?
> >>
> >> That explicit rtdm_irq_enable is not required by design, would rather be
> >> a bug on certain platforms (where enable != end IRQ), and indicates that
> >> something else is broken, maybe in Xenomai.
> >>
> > 
> > Xenomai is not involved at this level, it's the I-pipe business here. As
> 
> I would be careful with this judgement when reading further on...
> 
> > a matter of fact, the current I-pipe/ppc implementation forces the slow
> > ack path, i.e. disables the source and send EOI in the openpic code,
> > because we don't want another IRQ from the same source before some stage
> > has processed the current one. This is due to the deferred-by-design
> > nature of IRQ handling introduced by the interrupt pipeline, which has
> > raised some issues (namely interrupt storm) for level-triggered IRQs on
> > some ppc hw, IIRC.
> > 
> > Calling enable/end is thus needed to reactivate the IRQ source at some
> > point, even if it's not required by any vanilla kernel configuration
> > which may instead use the fast ack mode (i.e. send EOI only for
> > level-triggered interrupts, no masking).
> 
> The RTDM API just like the nucleus interrupt layer is precisely about
> removing this need from the driver/application developer. Thus, if you
> say we need ending here because I-pipe can't help on this arch, we would
> see a clear Xenomai bug.

If you reread my post in the intended context, you should understand it
as "the I-pipe is the only one responsible for handling the incoming
interrupts", and the all time approach has been to mask them until they
get processed (save the special exception if IRQ0 on x86 due to ISA bus
sluggishness). In that context, it's a I-pipe issue (the masking), not a
Xenomai one.

Said differently, Xenomai has always assumed that the I-pipe did mask
the incoming IRQ source while processing it, leaving the decision to
unmask it to the driver's ISR, depending on its return value to the
primary ISR handler in the nucleus.

> 
> > 
> > Next powerpc patches should not require this, thanks to the genirq layer
> > which helps differentiating interrupt flows in a much simpler way.
> > 
> 
> But until then we need a fix. Can we patch rthal_irq_end() on PPC to
> address this depending on the I-pipe version?
> 

Looking at the code from rthal_irq_end() in v2.3.1, the presence of a
->end() handler would indeed cause it to be invoked first (before
attempting ->enable() as a fallback option), which would end up in
openpic_end_irq() from arch/ppc/syslib/open_pic.c. What I suspect now is
that no regular action handler has been defined for this IRQ (i.e. no
request_irq() on this source from the Linux world), and therefore this
code would lead to a nop.

In which case, it would be an I-pipe bug, since there is no reason to
prevent the real-time domain from using an IRQ Linux does not care of.

> Jan
> 
-- 
Philippe.



