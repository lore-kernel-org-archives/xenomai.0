Message-ID: <44101F89.7080109@domain.hid>
Date: Thu, 09 Mar 2006 13:28:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC, Experimental Patch] nested irq disable calls
References: <b647ffbd0603030252h5f54c436l@domain.hid>	
	<440C1C41.5090304@domain.hid>
	<b647ffbd0603070648g6a09b3c5s@domain.hid>
In-Reply-To: <b647ffbd0603070648g6a09b3c5s@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:

<snip>

>  > Additionally, there is another issue we discussed once with Anders, 
> which is
>  > related to not sending EOI twice after the shared IRQ already ended 
> by a RT domain
>  > has been fully propagated down the pipeline to Linux;
>  > some kind of test_and_clear_temporary_disable flag, would do, I 
> guess. The other way would be
>  > to test_and_set some "ended" flag for the outstanding IRQ when the 
> ->end() routine
>  > is entered, clearing this flag before pipelining the IRQ in 
> __ipipe_walk_pipeline().
>  >
>  > Actually, I'm now starting to wonder why we would want to permanently 
> disable an
>  > IRQ line from a RT domain, which is known to be used by Linux.
>  > Is this what IPIPE_DISABLED_FLAG is expected to be used for, or is it 
> only there to handle the
>  > transient disabled state discussed above?
> 
> Why "permanently"?

This is what I thought you wanted to provide support for in order to address all
the pending issues, reading your previous post, but it seems I was wrong.

 > I would see the following scenario - an ISR wants to
> _temporary_ defer an IRQ line enabling
> until some later stage (e.g. rt_task which is a bottom half).
> This is the only reason why xnarch_end_irq() or some later step in it 
> (in this case ->end() ) must be aware
> of IPIPE_DISABLED_FLAG.
> 
> Why the currently used approach is not that good for it (NOENABLE) ?
> 
> 1)   it actually defers (for some PICs) not only "enabling" but sending 
> an EOI too;
>     As a consequence :
>

This is no more the case for ppc over which Adeos had this bug Anders reported and 
fixed. For each arch/pic pairs, ->ack() should now send eoi and likely mask the 
outstanding IRQ, whilst ->end() should only unmask it as needed. AFAICT after a 
brief inspection, x86, ppc, ia64, and blackfin ports look ok regarding this. (I 
did not check neither the ARM nor ppc64 ports yet, though). But in any case, this 
is the way Adeos is expected to behave, and it should be fixed iff it doesn't.

> 2)   rthal_end_irq() (on PPC and not just xnintr_enable() or 
> rthal_enable_irq()) must be called in bottom half
>     to re-endable the IRQ line;
> 
> 3)   does not co-exist well with the shared interrupts support (I don't 
> mean sharing between RT and not-RT doamins here).
>     Although it's not a common case if a few ISRs on the same shared 
> line want to defer enabling, esp. for
>     real-time domain;
>

Talking about intra-domain sharing, I assume that such deferral only makes sense 
for implementing full top/bottom-halves approach involving threads. If we stick to 
the simplest form where all the interrupt processing is done from within the ISRs, 
we only have two issues to deal with:

1. Make sure that interrupt ending (i.e. unmasking) occurs only once at hw level;
2. Make sure not to spuriously re-enable an IRQ line from some ISR which would 
have been disabled by a previously called ISR. Said differently, ensure that ISRs 
  which are part of the same chain of shared IRQ handlers do not step on each 
others toes with respect to the PIC status.

Additionally, the way we solve these issues should be compatible with sharing IRQs 
between different domain handlers. 1. is easy to achieve using a logic that starts 
right before the outstanding IRQ is pipelined, and ends after the first call to 
end the interrupt is seen. 2. is also trivial: if some domain in the pipeline 
wants to disable the IRQ line, it certainly does not want Linux or any other 
domain down the pipeline to either play or end the current IRQ. So the solution is 
to stop propagating the IRQ down the pipeline after it has been disabled, and we 
should be done. In any case, it's a local decision which must be taken by the ISR 
code itself and enforced by the nucleus; I don't see any need for some global 
logic there.

> 4)   it's a bit and if we would like to use only scalar values one day 
> then something
>     like HANDLED, HANDLED_NOENABLE would be needed;
> 
> The support for nested irq enable/disable calls would resolve all the 
> "restrictions" above but the question is
> whether we really need to resolve them.
>
> In the same vein, I'd like to know you vision of the "nested irq 
> enable/disable calls support". Any use cases?
> 

I tend to think that it really depends on the complexity we want to be able to
deal with when it comes to interrupt sharing in a single domain (i.e. the
real-time one). Either,

1) ending the IRQ must happen from within any of the shared interrupt handler 
connected to the interrupt line;

2) ending the IRQ might be delegated to threads in order to support a complete top
and bottom-halves approach.

In case of scenario #1, we need to make sure that unmasking occurs only once:
first because it's safer, second because it's cheaper (e.g. fiddling with the x86
XT-PIC through the ISA bus is expensive, so we'd better do this once as needed, 
since well, freaking x86+ISA is the major reason why we are currently banging our 
heads on the wall devising an interrupt sharing scheme in the first place...).
Instead of trying to check for the unmask-unless-disabled condition, it seems
possible to rather check for the unmask-if-not-done one. IOW, the first handler to
call ->end() would actually unmask, subsequent invocations would lead to a no-op.
As you already stated, the pieces of code implementing such guard against multiple 
ending calls would have to be handled by Adeos directly. Solving the "spurious 
re-enabling" issue without resorting to braindead tricks seems out of reach. This 
is where the disable nesting count would help, I guess.

Having ISRs return scalar values would be possible too, provided that handlers
would then be allowed to call the ->end() routine as many times as they wish, 
while the chained handlers are invoked in loop; i.e. we could get rid of NOENABLE,
just asking each ISR to explicitely end the interrupt as part of their common duty.

2) is more complex, because it's an actual deferral of the ending call unlike 1). 
There, we have to handle the case where all ISRs sharing the same interrupt line 
would run _before_ any threaded bottom-half could execute. IOW, relying on the 
unmask-if-not-done guard flag which is only valid while the domain is in interrupt 
processing state is no more an option, because the logic has to span over non-ISR 
contexts, and some ISR different from the one implementing the top half might well 
decide to end the IRQ under our feet before the bottom half thread had a chance to 
execute. In order to sanely deal with this issue, a disable nesting count is 
likely the best approach.

One way to implement it could be as follows:

- ISRs ask for incrementing (disable) or decrementing if positive (enable) the 
disable nesting count associated with the interrupt line, either by calling a 
specific support routine, or returning a proper action flag to the nucleus. The 
action of decrementing the disable count down to zero would _not_ trigger the 
actual ending at hw level, just bookkeeping the status.
- xnintr_end would be introduced, in order to better fit with the actual semantics 
(i.e. ending != enabling an interrupt). This call would check the current disable 
count for the IRQ and invoke the ->end() routine if zero. ISRs (and bottom halves) 
would be required to use xnintr_end after normal operations, but would still be 
allowed to call xnintr_disable, e.g. in case of emergency situation.
- Upon return from the last ISR, the nucleus would call xnintr_end.
- xnintr_disable would increment the disable count and forward the request to the 
hw as a result of transitioning from 0 to 1.
- xnintr_enable would do the exact opposite of xnintr_disable.
- bottom-halves could then call xnintr_end when they are done with processing the 
outstanding IRQ.

Sharing the count between the enable/disable and ending actions simply reflects 
the reality: ->end() routines have to check for the disable state before 
proceeding, because most of the time, they both deal with the IRQ masking state.
Unlike 1), such implementation could be fully provided by Xenomai, remaining 
unknown from Adeos. We would still need to implement the unmask-if-not-done bit at 
Adeos level to deal with extra-domain sharing, though.

To sum up, I agree with you that addressing #2 directly through a disable nesting 
count would solve those issues quite more elegantly.

>  >
>  > >
>  > >     if (!ipipe_root_domain_p() || !(irq_desc[irq_nr].status &
>  > > (IRQ_DISABLED|IRQ_INPROGRESS))
>  > >         && irq_desc[irq_nr].action)
>  > >         openpic_enable_irq(irq_nr);
>  > >     }
>  > >
>  >
>  > There is another way for most archs, which is to add such code to the 
> ->end()
>  > routine override in ipipe-root.c; this would be simpler and safer 
> than fixing such
>  > routine for each and every kind of interrupt controller. x86 directly 
> pokes into
>  > the PIC code and does not overrides IRQ control routines, though.
> 
> I didn't know about them as I mostly looked at the x86 implementation.
> 
> This gives as control over per-domain irq locking/unlocking 
> (ipipe_irq_lock/unlock()),
> __ipipe_std_irq_dtype[irq].end() is always called unconditionally (as a 
> result, .enable() for some PICs).
> That said, the IRQ line is actually on, the interrupts are just not 
> handled but accumulated in the pipe-log.
> 
> Actually, why is ipipe_irq_unlock(irq) necessary in 
> __ipipe_override_irq_end()? ipipe_irq_lock() is not
> called in __ipipe_ack_irq(). Is it locked somewhere else? At least, I 
> haven't found explicit ipipe_irq_lock()
> or __ipipe_lock_irq() calls anywhere else.

Basically because as documented in __do_IRQ, the ->end() handler has to deal with
interrupts which got disabled while the handler was running. If for some reason,
some IRQ handler decides to disable its own IRQ line, then the lock bit would be
raised in the pipeline for this IRQ too as a result of calling disable_irq().
Therefore, ->end() must unlock the IRQ at pipeline level whenever it eventually 
decides to unmask.

>  
> 
>  > [skip-skip-skip]
>  >
>  > >
>  > >  >From another point of view, this new feature seems not to be too
>  > > intrusive and not something really affecting the "fast path" so it 
> could
>  > > be used by default, I guess. Or maybe we don't need it at all?
>  > >
>  >
>  > The disable nesting count at Xenomai level is needed to let ISRs act 
> independently
>  > from each others wrt interrupt masking - or at the very least, to let 
> them think
>  > they do. This is strictly a Xenomai issue, not an Adeos one. If we 
> keep it at this
>  > level, then using the xnintr struct to store the nesting counter 
> becomes an
>  > option, I guess.
> 
> Let's start from defining possible use cases with nested irq 
> enable/disable calls then.
> Maybe we just don't need them at all (at least the same way Linux deals 
> with them)?
> 
>  >
>  > --
>  >
>  > Philippe.
> 
> 
> -- 
> Best regards,
> Dmitry Adamushko


-- 

Philippe.



