MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17579.47238.90918.989854@domain.hid>
Date: Wed, 5 Jul 2006 15:03:02 +0200
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs.	PXA)
In-Reply-To: <44AA0E21.3F17401F@vollmann.ch>
References: <44A3919C.596DFDAE@vollmann.ch>
	<1151592402.19389.31.camel@domain.hid>
	<44A4C4CB.5F24DA68@domain.hid>
	<1151657621.3060.26.camel@domain.hid>
	<44A8B191.3DCC39C2@domain.hid> <44A8BA2E.9090106@domain.hid>
	<44A8D7A1.4E4E9D27@domain.hid>
	<17577.4096.436840.354535@domain.hid>
	<17577.5372.702355.432641@domain.hid>
	<44AA0E21.3F17401F@vollmann.ch>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Detlef Vollmann <dv@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Detlef Vollmann wrote:
 > Gilles Chanteperdrix wrote:
 > > You can even do this in __ipipe_mach_set_dec, this avoid the need to
 > > modify I-ipipe non-machine specific code. Something like:
 > > 
 > > void __ipipe_mach_set_dec(unsigned long delay)
 > > {
 > >     if (delay < 8)
 > >         ipipe_trigger_irq(__ipipe_mach_timerint);
 > >     else
 > >         OSMR0 = OSCR + delay;
 > > }
 > 
 > Thanks, ipipe_trigger_irq() is exactly what I was looking for.
 > 
 > I'll just add another test after the update of OSMR0 for the
 > case that we got interrupted between the comparison and the
 > assignment.  And in that (probably very rare) case I accept that
 > I loose a timer tick :-(

I do not see what you mean. "delay" value does not change over time.

 > 
 > Also, this way the timer comes a bit early, so any handler that
 > checks the TSC might think that this is the wrong interrupt --
 > and wait forever for the correct one.
 > But the only other option would be the busy wait...

It will work for Xenomai:
- in periodic mode, each interrupt is treated as a tick
- in aperiodic mode, there are two guards; first the tsc is compared to
  the next software timer expiration date using nkschedlat as a margin;
  second, if the tick is so early that there is no software timer
  expiration to  handle, no software timer will be dequeued and the next
  software timer expiration date will be reused to reprogram the
  hardware timer.

 > 
 > The question about recursion remains:
 > If a domain decides in its timer interrupt handler to reprogram
 > the timer by calling __ipipe_mach_set_dec() (indirectly), and
 > we already are too close to the next match, then that interrupt
 > handler is called recursively.
 > Is every ipipe domain expected to cope with this?

As explained above, this recursion can only happen for a limited time
(in the worst case, if nkschedlat is 0, during 8 hardware timer ticks).
Keep in mind that these functions are called with interrupts off, so the
"recursion", is serialized.

You should really have a look at ksrc/nucleus/timer.c, functions
do_tick_aperiodic and do_tick_periodic. 

-- 


					    Gilles Chanteperdrix.

