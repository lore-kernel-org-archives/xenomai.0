From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
Date: Mon, 31 Oct 2005 22:02:07 +0100
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
	<200510312121.14160.dmitry.adamushko@domain.hid>
	<436680D5.4010105@domain.hid>
In-Reply-To: <436680D5.4010105@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510312202.07522.dmitry.adamushko@domain.hid>
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

On Monday 31 October 2005 21:38, you wrote:
> > [...]
> > In our case, the relation between xnintr_irq_handler() and
> > rthal_irq_trampoline() is 1:1. The first one does much more things that
> > the second one which is really almost a pure redirection layer.
> > Hopefully, xnintr_irq_handler() is i-cache-hot as long as possible under
> > high irq load. In this case, I guess, rthal_irq_trampoline() will be in
> > cache as well (since it's really small) and the overhead is only about
> > having one array indexing op. and issuing a call via a pointer to the
> > function (xnintr_irq_handler() in our case).
> > Do you think that really gives a significant overhead? Well, maybe so.
> > I'm not a profie here anyway...
>
> ...compared to the usefulness I still have to understand - yes.
>
> Other option: what about merging [2] into [3], i.e. let
> xnintr_irq_handler deal with the translation IRQ number -> cookie?

In that case, the nucleus must keep track of all the irqs, i.e. some_struct 
irqs[IPIPE_NR_IRQS]. Ok, the rthal_realtime_irq[] may be removed here from 
hal.
But there is already the per-irq array in ipipe_domain struct. Having got [1] 
and [2] merged, we would have this array as the only one and avoid the use of 
rthal_realtime_irq[] at all. Although, the ipipe_domain would become a bit 
more heavy :) Well, but [2] into [3] is leeeess intrusive on the other hand.

>
> Philippe, I guess your wisdom is required here. Are we missing some
> important point in your design right now?
>

He would be glad you/we/someone else would come up with a worthy decision 
(even if it's "keep it as is") without relying on the explanation of the 
current design from his side.
Ok, the morning brings better solutions :o)

> Jan

---
Best regards,
Dmitry

