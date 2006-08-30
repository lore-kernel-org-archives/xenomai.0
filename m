Subject: Re: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44F5DDF1.3030006@domain.hid>
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<44F49A6C.5050603@domain.hid>
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
	<44F592AD.2000900@domain.hid> <1156960547.4323.68.camel@domain.hid>
	<44F5DDF1.3030006@domain.hid>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 22:47:59 +0200
Message-Id: <1156970880.4323.74.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

On Wed, 2006-08-30 at 20:50 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
> > On Wed, 2006-08-30 at 15:29 +0200, Jan Kiszka wrote:
> >   
> >> Dmitry Adamushko wrote:
> >>     
> >>> On 29/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >>>       
> >>>> Dmitry Adamushko wrote:
> >>>>
> >>>> I think the additional costs of maintaining an error counter are almost
> >>>> negligible. The test is in the unlikely path, and the first condition
> >>>> already keeps us away from touching the counter.
> >>>>         
> >>> But it's updated (unhandled = 0) any time the ISR(s) report something
> >>> different from XN_ISR_NONE.  Hence, it's at the beginning of the xnintr_t
> >>> structure, hopefully, at the same cache line with other highly-used members
> >>> (i.e. isr, cookie and hits).
> >>>       
> >> Mmh, considering this and also the existing code I wonder if we could
> >> optimise this a bit. I'm only looking at xnintr_irq_handler now (sharing
> >> is slow anyway): currently the intr object is touched both before
> >> (naturally...) and after the call to the ISR handler. Maybe we can push
> >> all accesses before the handler for the fast path. E.g.:
> >>
> >> int unhandled = intr->unhandled;
> >>
> >> intr->unhandled = 0;
> >> ++intr->hits;
> >> s = intr->isr(...);
> >>
> >> if (s == XN_ISR_NONE) {
> >> 	intr->unhandled = ++unhandled;
> >> 	if (unhandled == XNINTR_MAX_UNHANDLED)
> >> 		ALARM!
> >> }
> >>
> >>     
> >
> > Without speculating whether this could actually reduce cache misses or
> > not when the branch is taken, the main issue I see here is that we would
> > optimize the error case, at the expense of an additional memory fetching
> 
> No, it's the common path. Otherwise, I would have stopped already. I don't
> expect further memory access because the head of intr should be cached
> already.
> 

Sorry, my brain cells must be glued together, but then, I just don't get
what your patch actually optimizes :o}

> > in the common case, and perhaps one CPU register available less for
> > processing the normal path in the worst scenario, which would not be
> > particularly efficient on x86.
> >
> >   
> At least on x86 it looks good: all local variables are in registers
> anyway, unhandled now too.

That's exactely the problem I'd see...

>  Is someone able to test this? Maybe also
> on a non-x86 arch?
> 
> Jan
> 
> 
> --- ksrc/nucleus/intr.c	(revision 1527)
> +++ ksrc/nucleus/intr.c	(working copy)
> @@ -374,6 +374,7 @@ void xnintr_clock_handler(void)
>  	xnintr_irq_handler(nkclock.irq, &nkclock);
>  }
>  
> +#define XNINTR_MAX_UNHANDLED	1000
>  /*
>   * Low-level interrupt handler dispatching the ISRs -- Called with
>   * interrupts off.
> @@ -383,15 +384,28 @@ static void xnintr_irq_handler(unsigned 
>  {
>  	xnsched_t *sched = xnpod_current_sched();
>  	xnintr_t *intr = (xnintr_t *)cookie;
> +	unsigned int unhandled = intr->unhandled;
>  	int s;
>  
>  	xnarch_memory_barrier();
>  
>  	xnltt_log_event(xeno_ev_ienter, irq);
>  
> +	intr->unhandled = 0;
> +	++intr->hits;
> +
>  	++sched->inesting;
>  	s = intr->isr(intr);
> -	++intr->hits;
> +
> +	if (unlikely(s == XN_ISR_NONE)) {
> +		intr->unhandled = ++unhandled;
> +		if (unlikely(unhandled == XNINTR_MAX_UNHANDLED)) {
> +			xnlogerr("xnintr_check_status: %d of unhandled "
> +				 " consequent interrupts. Disabling the IRQ "
> +				 "line #%d\n", XNINTR_MAX_UNHANDLED, irq);
> +			s |= XN_ISR_NOENABLE;
> +		}
> +	}
>  
>  	if (s & XN_ISR_PROPAGATE)
>  		xnarch_chain_irq(irq);
> 
> 
> 
-- 
Philippe.



