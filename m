From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C07815F.3010704@domain.hid>
References: <4C0692A9.2080806@domain.hid> <4C06953D.90003@domain.hid>
	<4C0751FC.8050009@domain.hid>
	<1275553646.18250.65.camel@domain.hid>
	<4C076C10.3070708@domain.hid>
	<1275558996.18250.85.camel@domain.hid>
	<4C07815F.3010704@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Jun 2010 12:47:43 +0200
Message-ID: <1275562063.18250.97.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] Break out of endless user space loops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

On Thu, 2010-06-03 at 12:18 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2010-06-03 at 10:47 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Thu, 2010-06-03 at 08:55 +0200, Jan Kiszka wrote:
> >>>> Gilles Chanteperdrix wrote:
> >>>>> Jan Kiszka wrote:
> >>>>>> Hi all,
> >>>>>>
> >>>>>> here is the first apparently working prototype for getting hold of
> >>>>>> endless user space loops in RT threads. A simple test case of mine now
> >>>>>> receive a SIGDEBUG even if it does "while (1);".
> >>>>>>
> >>>>>> The design follows Gilles' suggestion to force a SEGV on victim thread
> >>>>>> but restore the patched PC before migrating the thread after this fault.
> >>>>>> The only drawback of this approach: We need to keep track of the
> >>>>>> preempted register set at I-pipe level. I basically replicated what
> >>>>>> Linux does these days as well and exported it as ipipe_get_irq_regs()
> >>>>>> (the second patch).
> >>>>> You already have the regs in xnarch_fault_info.
> >>>>>
> >>>> We only pass this around for exceptions.
> >>> And for a good reason, exceptions are always delivered synchronously
> >>> upon receipt, not IRQs, given the deferred dispatching scheme. Your
> >>> ipipe_get_irq_regs interface is inherently broken for anything which is
> >>> not a wired-mode timer IRQ, since you could pass the caller a reference
> >>> to an unwound stack frame.
> >> It may not work for certain deferred IRQs, true, but then it will return
> >> NULL. The user of ipipe_get_irq_regs has to take this into account. And
> >> most consumers will be wired IRQ handler anyway.
> >>
> >>> You have to resort to __ipipe_tick_regs, and obviously only use this in
> >>> the context of a timer-triggered code, like the watchdog handler, which
> >>> saves your day.
> >> Doesn't work if the timer IRQ is not the host tick AND doesn't help us
> >> modifying the return path.
> > 
> > That is not the basic issue, copying back regs->ip to the actual frame
> > before yielding to the IRQ trampoline code would be trivial and your
> > patch does require a deeper change in the ipipe already. The issue is:
> > do not provide a service which is not 100% trustable in this area.
> 
> There is no use for ipipe_get_irq_regs in our case outside the call
> stack of the triggering IRQ. If you have nested IRQs inside this stack,
> ipipe_get_irq_regs account for this, if you leave the stack, it returns
> NULL. This is 100% reliable.

Try calling ipipe_get_irq_regs within a root domain IRQ handler, then,
we'll resume this discussion right after - you may have another
perception of the situation. You will get NULL once in a while, albeit
you are running over an IRQ context, from a Linux POV.

100% reliable for a published ipipe interface means that it ought to
work when called from _all_ domains, unless its semantics specifically
dictates a particular context for use. By no mean ipipe_get_irq_regs
tells anyone that it may only be used reliably on behalf of an unlocked,
wired, directly dispatched IRQ.

The only IRQ that fits this description is the pipelined hrtimer irq
(not even the host one, the host one simply inherits this property when
it happens that hrtimer == host timer for the underlying architecture),
and the only domain which may assume this safely is the invariant head,
which certainly restricts quite a bit the valid context for using those
services.

> 
> If you want read-only access to the preempted register set, then we need
> some other mechanism, something like the tick regs. But those already
> exits, and we have no other users beyond the host tick so far.

I agree, we do need something to ALLOWS US fixup the frame for the
return address to be correct. I'm just asking that we do provide a clean
interface for this, since it will be there to stay. 

> 
> Jan
> 


-- 
Philippe.



