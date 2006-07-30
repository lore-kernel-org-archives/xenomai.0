Message-ID: <44CD2C06.1070100@domain.hid>
Date: Mon, 31 Jul 2006 00:00:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>	<200607221152.34298.bidsonux@domain.hid>	<44C25DB0.50601@domain.hid>	<200607282317.34990.bidsonux@domain.hid>	<44CB6EB3.5070707@domain.hid>	<1154282619.4970.25.camel@domain.hid>	<44CD099F.9010507@domain.hid>
	<17613.4212.23333.832165@domain.hid>
In-Reply-To: <17613.4212.23333.832165@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC8F1779327E89A50BA0FC728"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8F1779327E89A50BA0FC728
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Philippe Gerum wrote:
>  > > On Sat, 2006-07-29 at 16:20 +0200, Jan Kiszka wrote:
>  > >>>> :|func        6   xnintr_clock_handler (__ipipe_dispatch_wired)=

>  > >>>> :|func        6   xnintr_irq_handler (xnintr_clock_handler)
>  > >>>> :|func        7   xnpod_announce_tick (xnintr_irq_handler)
>  > >>>> :|func        8+  xntimer_do_tick_aperiodic (xnpod_announce_tic=
k)
>  > >>>> :|func        9   xnthread_periodic_handler (xntimer_do_tick_ap=
eriodic)
>  > >>>> :|func       10   xnpod_resume_thread (xnthread_periodic_handle=
r)
>  > >>>> :|[21559]    11+  xnpod_resume_thread (xnthread_periodic_handle=
r)
>  > >>>> :|func       13+  xnthread_periodic_handler (xntimer_do_tick_ap=
eriodic)
>  > >> ...
>  > >>
>  > >>>> :|func      363+  xnthread_periodic_handler (xntimer_do_tick_ap=
eriodic)
>  > >> That are a lot of overruns. Haven't counted, but it should be one=

>  > >> xnthread_periodic_handler per missed 100 us period (20000 / 100 =3D=
 200!).
>  > >> [BTW, I think we should handle even this failure scenario without=

>  > >> looping.
>  > >=20
>  > > We need to loop in the aperiodic handler in order to catch timers =
that
>  > > could have elapsed while processing the current tick. However,
>  >=20
>  > No, that was not what I meant. I know that we need the timer loop. B=
ut I
>  > was thinking of something like this for the tick handler's error pat=
h:
>  >=20
>  > if (unlikely((timer.date +=3D timer.interval) < now))
>  > 	timer.date =3D now + timer.interval -
>  > 		(now - timer.date) % timer.interval;
>=20
> Actually,
>=20
> while (timer.date < now)
>        timer.date +=3D timer.interval
>=20
> cost much less cycles in the normal/fast case than going through a
> division...=20
>=20

Yeah, most probably the right way for the timer IRQ. If we have to loop
here significantly often, then we already had a much too long IRQ-off
period and are toasted anyway.

Jan


--------------enigC8F1779327E89A50BA0FC728
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzSwGniDOoMHTA+kRAve8AJ40IlORA1Y+D8Fkg26fFJ9waQaxGACfcrs/
/4SvgpY4k61h7KKwS7mw2e8=
=q7Vn
-----END PGP SIGNATURE-----

--------------enigC8F1779327E89A50BA0FC728--

