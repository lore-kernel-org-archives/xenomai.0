Sender: dv@domain.hid
Message-ID: <44A4C531.221089B3@domain.hid>
Date: Fri, 30 Jun 2006 08:31:23 +0200
From: Detlef Vollmann <dv@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator vs.
	PXA)
References: <44A3919C.596DFDAE@vollmann.ch>
	<1151592402.19389.31.camel@domain.hid>
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
To: dv@domain.hid
Cc: xenomai@xenomai.org

Stelian Pop wrote:
> Le jeudi 29 juin 2006 =E0 10:38 +0200, Detlef Vollmann a =E9crit :

> >  a) What's the difference between __ipipe_mach_ticks_per_jiffy
> >     and LATCH?
>=20
> As a matter of fact there is no difference.
Does this mean that __ipipe_mach_ticks_per_jiffy never changes?
What about the correlation between __ipipe_mach_set_dec() and
__ipipe_mach_ticks_per_jiffy?  __ipipe_mach_set_dec() seems
to do a permanent change, and not only a one-time change.

Is the Linux timer interrupt still only called after LATCH ticks?


> >  b) Is there some (hidden, intended future) semantics of tscok?
> >     Right now it just avoids that garbage is returned before
> >     the timer is initialized.
>=20
> tscok is used to prevent __ipipe_mach_get_tsc() returning bogus values
> in the early boot stages (when the timer is not yet initialized but
> ipipe is). IIRC this was mainly needed when enabling
> CONFIG_IPIPE_STATS...
Ok, thanks.


> >  c) In the interrupt routine, the comment currently says:
> >     "If Linux is the only domain, ack the timer and reprogram it",
> >     but the actual code looks as if the comment should read:
> >     "If Linux is running natively, ack the timer.
> >     If Linux's the only domain, reprogram it."
> >     What's wrong, the code or the comment?
>=20
> Always trust the code :)
>=20
> The true meaning of that code is:
>         * if Linux is running natively (no ipipe), ack and reprogram th=
e timer
>         * if Linux is running under ipipe, but it still has the control=
 over
> the timer (no Xenomai for example), then reprogram the timer (ipipe has
> already acked it)
>         * if some other domain has taken over the timer, then do nothin=
g (ipipe
> has acked it, and the other domain has reprogramed it)
Thanks for the explanation, it really helps.

Now I have another question on this: on the PXA I have a hardware
problem so that I must sometimes set the next match value to the
match value after the next one, so effectively loosing one
interrupt.

If Linux is responsible for reprogramming the timer, I should tell
ipipe about it, so that ipipe can tell any other domain.
How can I do that?

> Indeed, you will need to adapt the PXA incrementer to the ipipe
> decrementer semantics.
Ok, that shouldn't be a problem.

Thanks a lot for your help
 Detlef

--=20
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

