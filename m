Sender: dv@domain.hid
Message-ID: <44AC4ED0.4C1BF83E@vollmann.ch>
Date: Thu, 06 Jul 2006 01:44:16 +0200
From: Detlef Vollmann <dv@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs.	PXA)
References: <44A3919C.596DFDAE@vollmann.ch>
	<1151592402.19389.31.camel@domain.hid>
	<44A4C4CB.5F24DA68@domain.hid>
	<1151657621.3060.26.camel@domain.hid>
	<44A8B191.3DCC39C2@domain.hid> <44A8BA2E.9090106@domain.hid>
	<44A8D7A1.4E4E9D27@domain.hid>
	<17577.4096.436840.354535@domain.hid>
	<17577.5372.702355.432641@domain.hid>
	<44AA0E21.3F17401F@vollmann.ch>
	<17579.47238.90918.989854@domain.hid>
Content-Type: text/plain; charset=us-ascii
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
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Gilles Chanteperdrix wrote:
> Detlef Vollmann wrote:

>  > I'll just add another test after the update of OSMR0 for the
>  > case that we got interrupted between the comparison and the
>  > assignment.  And in that (probably very rare) case I accept that
>  > I loose a timer tick :-(
> 
> I do not see what you mean.
Sorry, I didn't see that the code is running under IRQ-lock.

> "delay" value does not change over time.
Well, ipipe_tune_timer() is in the public interface of ipipe,
so it might be used for all kind of things...

> 
>  >
>  > Also, this way the timer comes a bit early, so any handler that
>  > checks the TSC might think that this is the wrong interrupt --
>  > and wait forever for the correct one.
>  > But the only other option would be the busy wait...
> 
> It will work for Xenomai:
> - in periodic mode, each interrupt is treated as a tick
> - in aperiodic mode, there are two guards; first the tsc is compared to
>   the next software timer expiration date using nkschedlat as a margin;
>   second, if the tick is so early that there is no software timer
>   expiration to  handle, no software timer will be dequeued and the next
>   software timer expiration date will be reused to reprogram the
>   hardware timer.
Ok, so the busy wait would be in the loop between do_tick_aperiodic
and __ipipe_mach_set_dec: the next expiration date is not yet
reached, but it is to close to do the update.

> As explained above, this recursion can only happen for a limited time
> (in the worst case, if nkschedlat is 0, during 8 hardware timer ticks).
> Keep in mind that these functions are called with interrupts off, so the
> "recursion", is serialized.
Ok, understood.  Thanks for the detailed explanation.

> You should really have a look at ksrc/nucleus/timer.c, functions
> do_tick_aperiodic and do_tick_periodic.
Thanks for the pointer.

And I think you're correct, for Xenomai it will work.
Unfortunately I'm trying to do a general ipipe port for PXA.
I'm doing this for a polytech who wants to use this with their
students, and so they probably want to use it with other domain
on top of ipipe (rtai 3.3, Siemens' implementation of the Posix
RT interface, and maybe even an own domain for experimenting).

But probably all aperiodic timers need such a scheme, so I'll
not busy loop for now.

Thanks again for your explanation
 Detlef

-- 
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

