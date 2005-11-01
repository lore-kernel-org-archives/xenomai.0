From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
Date: Tue, 1 Nov 2005 14:31:11 +0100
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
	<200510312121.14160.dmitry.adamushko@domain.hid>
	<43675853.1000209@domain.hid>
In-Reply-To: <43675853.1000209@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011431.12506.dmitry.adamushko@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

On Tuesday 01 November 2005 12:58, you wrote:

> > as "cockie" to the xnintr_irq_handler().
> >
> > The analogy is irq_desc_t vs. irqaction structures in Linux.
> >
> > This way, xnintr_irq_handler() can be called from adeos-ipipe layer
> > directly without the [2] layer.
> >
> > But that change looks quite invasive to me so far since
> > ipipe_domain::irqs::handler(irq - with a single parameter) is used all
> > over the map.
>
> I'd really prefer making one invasive change early in the process of
> addressing the issue than several kludges later to work around structural
> shortcomings, so no problem, go wild, I'm all ears.
>

If we only want to get rid of the trampoline-thing then [2] + [3] would work 
out (btw, I have sent a message this morning where I tried to provide even 
some pseudo-code :) 

But if we want to (think that we may) gain the adventage of having a more 
flexible irq-related support from the ipipe layer, then yep, those changes 
might look worthy. I thought that this way, we would even get rid of another 
per-irq (rthal_realtime_irq) array in hal/generic.c, maybe even from 
rthal_linux_irq too. The sole one is provided by the ipipe_domain structure 
and a set of generic interfaces e.g. via system.h so that the HAL or another 
layer may get access of it.

e.g.

the "cookie" remains opaque for the ipipe but when requested by 
HAL::rthal_irq_request() or NUCLEUS::xnintr_irq_handler() it's treated as a 
chain of ISR handlers.


---
Best regards,
Dmitry

