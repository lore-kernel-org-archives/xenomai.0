Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs. PXA)
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <44A3919C.596DFDAE@vollmann.ch>
References: <44A3919C.596DFDAE@vollmann.ch>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 29 Jun 2006 16:46:41 +0200
Message-Id: <1151592402.19389.31.camel@domain.hid>
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

Le jeudi 29 juin 2006 =E0 10:38 +0200, Detlef Vollmann a =E9crit :
> Hello,

Hi,

>=20
> looking at the ARM Integrator patch (which seems to be something
> like the reference port for ARM), I'm not really clear about some
> of the code:
>=20
>  a) What's the difference between __ipipe_mach_ticks_per_jiffy
>     and LATCH?

As a matter of fact there is no difference.

>  b) Is there some (hidden, intended future) semantics of tscok?
>     Right now it just avoids that garbage is returned before
>     the timer is initialized.

tscok is used to prevent __ipipe_mach_get_tsc() returning bogus values
in the early boot stages (when the timer is not yet initialized but
ipipe is). IIRC this was mainly needed when enabling
CONFIG_IPIPE_STATS...

>  c) In the interrupt routine, the comment currently says:
>     "If Linux is the only domain, ack the timer and reprogram it",
>     but the actual code looks as if the comment should read:
>     "If Linux is running natively, ack the timer.
>     If Linux's the only domain, reprogram it."
>     What's wrong, the code or the comment?

Always trust the code :)

The true meaning of that code is:
	* if Linux is running natively (no ipipe), ack and reprogram the timer
	* if Linux is running under ipipe, but it still has the control over
the timer (no Xenomai for example), then reprogram the timer (ipipe has
already acked it)
	* if some other domain has taken over the timer, then do nothing (ipipe
has acked it, and the other domain has reprogramed it)

>  d) __ipipe_mach_set_dec() sets the next match value of the timer.
>     But the current counter isn't changed.  Correct?
>     Or is setting the match value and setting the current counter
>     the same operation on the Integrator?

Yes, the integrator has a true decrementer and not a match counter.

__ipipe_set_dec(x) must set program the timer so that a timer interrupt
occurs after x ticks.

>     __ipipe_mach_get_dec() doesn't return the next match value, but
>     the current actual counter, i.e. some value between 0 and the
>     next match value.  Correct?

Yes.

>     And if so, which value?  The number of ticks elapsed since the
>     last match or the number of ticks until the next match occurs?

The number of ticks until the next match occurs.

>     The names "..._dec" suggest that the integrator provides a clock
>     register that decrements.  The PXA provides clock registers
>     that are incremented, and the timer used for the Linux ticks
>     is (in Linux) never reset, but instead the match value at
>     which an interrupt occurs is incremented on each interrupt.
>     So, a port to the PXA wouldn't be straightforward, and so I
>     want to make sure that I really understand the semantics
>     of the ARM port.

Indeed, you will need to adapt the PXA incrementer to the ipipe
decrementer semantics.

Stelian.
--=20
Stelian Pop <stelian.pop@domain.hid>


