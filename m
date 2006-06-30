Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs. PXA)
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <44A4C4CB.5F24DA68@domain.hid>
References: <44A3919C.596DFDAE@vollmann.ch>
	<1151592402.19389.31.camel@domain.hid>
	<44A4C4CB.5F24DA68@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 30 Jun 2006 10:53:41 +0200
Message-Id: <1151657621.3060.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: xenomai@xenomai.org

Le vendredi 30 juin 2006 =E0 08:29 +0200, Detlef Vollmann a =E9crit :
> Stelian Pop wrote:
> > Le jeudi 29 juin 2006 =E0 10:38 +0200, Detlef Vollmann a =E9crit :
>=20
> > >  a) What's the difference between __ipipe_mach_ticks_per_jiffy
> > >     and LATCH?
> >=20
> > As a matter of fact there is no difference.
> Does this mean that __ipipe_mach_ticks_per_jiffy never changes?

Indeed.

> What about the correlation between __ipipe_mach_set_dec() and
> __ipipe_mach_ticks_per_jiffy?  __ipipe_mach_set_dec() seems
> to do a permanent change, and not only a one-time change.

__ipipe_mach_set_dec sets the *next* timer occurence. It functions in a
one-shot way (like a real decrementer, not a auto-reloading one).

> Is the Linux timer interrupt still only called after LATCH ticks?

IPipe doesn't do anything special to the timer (except for acking the
interrupt because this must be done early in some cases).

If Linux handles the timer, then nothing changes, the timer frequency is
LATCH.

If Xenomai handles the timer, then it is its responsability to propagate
the interrupt to Linux when it wants to (look for xnarch_relay_tick() in
Xenomai's nucleus).

> Now I have another question on this: on the PXA I have a hardware
> problem so that I must sometimes set the next match value to the
> match value after the next one, so effectively loosing one
> interrupt.

> If Linux is responsible for reprogramming the timer, I should tell
> ipipe about it, so that ipipe can tell any other domain.
> How can I do that?

If Linux is responsible for reprogramming the timer there is a good
chance there is no other domain, so it doesn't matter much :)

But you will have a problem when Xenomai takes upon the timer, because
its scheduler doesn't expect to lose timer ticks.=20

I can imagine adding a return code to __ipipe_mach_set_dec() which would
tell if the hardware has been programmed successfully or not, and in
this latter case Xenomai (or ipipe ?) would have to busy sleep until the
next (calculated) timer occurence... What do the experts think ?

Stelian.
--=20
Stelian Pop <stelian.pop@domain.hid>


