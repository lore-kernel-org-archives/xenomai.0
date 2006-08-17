Message-ID: <44E470AA.1040500@domain.hid>
Date: Thu, 17 Aug 2006 15:35:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][PATCH 4/4] shorten overrun loops of periodic
	timers
References: <44D19F3D.9060700@domain.hid>	<17618.12731.97405.118098@domain.hid>	<44D24257.10605@domain.hid>	<17635.15652.735628.299134@domain.hid>	<44E345D7.4070904@domain.hid>	<17635.21607.931068.951138@domain.hid>	<44E420E4.9050008@domain.hid>
	<17636.26900.947012.154313@domain.hid>
In-Reply-To: <17636.26900.947012.154313@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3544BDD6B38FD1FA617B6F3D"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3544BDD6B38FD1FA617B6F3D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > > I am thinking again about this patch: some handlers need to b=
e
>  > >  > > rewritten, for example the posix timers handler, because the =
handler
>  > >  > > relies on the fact that it is called for every timer expiry t=
o compute
>  > >  > > the overruns count. So maybe this patch should come with the =
addition of
>  > >  > > an xntimer_getoverrun service that computes the overrun count=
 using the
>  > >  > > tsc ?
>  > >  > >=20
>  > >  >=20
>  > >  > Mmh, that gets close to hrtimer_forward now: push an overdue ti=
mer to an
>  > >  > expiry date that is in the future and return the number of over=
runs. But
>  > >  > do we still want this optimisation of the broken path then? It =
starts
>  > >  > getting complex, probably adding more code than it is worth. I'=
m
>  > >  > starting to vote against my own patch...
>  > >=20
>  > > The code to compute the number of overruns from the tsc exists in
>  > > xnpod_wait_thread_period, is not this just a matter of refactoring=
 this
>  > > code in an xntimer_getoverrun ?
>  > >=20
>  >=20
>  > That overrun calculation takes place in thread context, we were
>  > discussing this for the timer handler. That means, if we generalise,=
 we
>  > would have to pass the overrun counter somehow from the handler to t=
he
>  > awakened thread. Would take another struct field, probably in xnthre=
ad.
>  > On the other hand, if that could save code in the posix skin, it may=

>  > make sense.
>=20
> What I had in mind was that timer handlers or threads that are
> interested in the overruns count could call xntimer_getoverruns, which
> computes the overruns count "on-the-fly" using the tsc, i.e. without
> requiring any additional field.
>=20

Mmh, may work. I guess we need some code now. I already rebased my
series over trunk, I could give this approach a try later.

Jan


--------------enig3544BDD6B38FD1FA617B6F3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE5HCqniDOoMHTA+kRAuv/AJ4/d+5/pPHDYixMmijDLFuzvbSz+gCdHA7z
pyZnxHwNW/NRPsfnTKYwcKM=
=REKA
-----END PGP SIGNATURE-----

--------------enig3544BDD6B38FD1FA617B6F3D--

