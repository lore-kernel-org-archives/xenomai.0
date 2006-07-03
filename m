Sender: dv@domain.hid
Message-ID: <44A8B191.3DCC39C2@domain.hid>
Date: Mon, 03 Jul 2006 07:56:33 +0200
From: Detlef Vollmann <dv@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator vs.
	PXA)
References: <44A3919C.596DFDAE@vollmann.ch>
	<1151592402.19389.31.camel@domain.hid>
	<44A4C4CB.5F24DA68@domain.hid>
	<1151657621.3060.26.camel@domain.hid>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: Quoted-Printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai@xenomai.org

Stelian Pop wrote:
> Le vendredi 30 juin 2006 =E0 08:29 +0200, Detlef Vollmann a =E9crit :

> __ipipe_mach_set_dec sets the *next* timer occurence. It functions in a
> one-shot way (like a real decrementer, not a auto-reloading one).
In your implementation for the Integrator you set timer_reload in
__ipipe_mach_set_dec() and use that value in the (Linux) interrupt
handler.
And that seems to be the correct behaviour, if I look at Xenomai's
arch/arm/hal.c and see in rthal_timer_release the call
__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy).

> > Is the Linux timer interrupt still only called after LATCH ticks?
>=20
> IPipe doesn't do anything special to the timer (except for acking the
> interrupt because this must be done early in some cases).
>=20
> If Linux handles the timer, then nothing changes, the timer frequency i=
s
> LATCH.
>=20
> If Xenomai handles the timer, then it is its responsability to propagat=
e
> the interrupt to Linux when it wants to (look for xnarch_relay_tick() i=
n
> Xenomai's nucleus).
Thanks for the explanation.

> > Now I have another question on this: on the PXA I have a hardware
> > problem so that I must sometimes set the next match value to the
> > match value after the next one, so effectively loosing one
> > interrupt.
>=20
> > If Linux is responsible for reprogramming the timer, I should tell
> > ipipe about it, so that ipipe can tell any other domain.
> > How can I do that?
>=20
> If Linux is responsible for reprogramming the timer there is a good
> chance there is no other domain, so it doesn't matter much :)
That's probably true.

> But you will have a problem when Xenomai takes upon the timer, because
> its scheduler doesn't expect to lose timer ticks.
Exactly that's the problem...

> I can imagine adding a return code to __ipipe_mach_set_dec() which woul=
d
> tell if the hardware has been programmed successfully or not, and in
> this latter case Xenomai (or ipipe ?)
It should definitely be ipipe.  At least in theory there could be
other domains than Xenomai, and any domain needs to be informed.

> would have to busy sleep until the
> next (calculated) timer occurence...
Hmmm, busy sleeping for several usecs is pretty long.
Couldn't ipipe in that case just fire the interrupt routine
(w/o ack'ing the interrupt), even if a bit out of the correct timing?

But anyway, whoever is responsible for reprogramming the timer needs
to know that it already is reprogrammed this time.

In Linux, it's easy because there are separate functions for dealing
with the hardware (ack the IRQ and reprogram timer) and for actually
doing what has to be done in the system on a timer interrupt
(timer_tick()).
For IPIPE, that separation isn't so easy as the (some) domains have the
illusions that they get their timer interrupts still from the
real hardware.

A simple solution would be a special return value from
__ipipe_mach_set_dec(), and in this case ipipe just calls the
registered handlers from all domains.  But for the domain
that called (indirectly) __ipipe_mach_set_dec() this could mean
that an interrupt handler is called recursively, and this is
something no handler really expects...

So, I have no solution for now and have to live with the fact
that Xenomai might loose a timer tick :-(

Again, thanks a lot for your help
 Detlef

--=20
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

