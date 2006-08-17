Message-ID: <44E420E4.9050008@domain.hid>
Date: Thu, 17 Aug 2006 09:55:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][PATCH 4/4] shorten overrun loops of periodic
	timers
References: <44D19F3D.9060700@domain.hid>	<17618.12731.97405.118098@domain.hid>	<44D24257.10605@domain.hid>	<17635.15652.735628.299134@domain.hid>	<44E345D7.4070904@domain.hid>
	<17635.21607.931068.951138@domain.hid>
In-Reply-To: <17635.21607.931068.951138@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig18AE15C55DE29B1A1367D582"
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
--------------enig18AE15C55DE29B1A1367D582
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > > I am thinking again about this patch: some handlers need to be
>  > > rewritten, for example the posix timers handler, because the handl=
er
>  > > relies on the fact that it is called for every timer expiry to com=
pute
>  > > the overruns count. So maybe this patch should come with the addit=
ion of
>  > > an xntimer_getoverrun service that computes the overrun count usin=
g the
>  > > tsc ?
>  > >=20
>  >=20
>  > Mmh, that gets close to hrtimer_forward now: push an overdue timer t=
o an
>  > expiry date that is in the future and return the number of overruns.=
 But
>  > do we still want this optimisation of the broken path then? It start=
s
>  > getting complex, probably adding more code than it is worth. I'm
>  > starting to vote against my own patch...
>=20
> The code to compute the number of overruns from the tsc exists in
> xnpod_wait_thread_period, is not this just a matter of refactoring this=

> code in an xntimer_getoverrun ?
>=20

That overrun calculation takes place in thread context, we were
discussing this for the timer handler. That means, if we generalise, we
would have to pass the overrun counter somehow from the handler to the
awakened thread. Would take another struct field, probably in xnthread.
On the other hand, if that could save code in the posix skin, it may
make sense.

Jan


--------------enig18AE15C55DE29B1A1367D582
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE5CDkniDOoMHTA+kRAljQAJ4iZkIFF9Yz07mhKDHyFAP1EaSsIwCePORA
Q0fGswWDV6JZ3OcCWrnGUkg=
=g/LC
-----END PGP SIGNATURE-----

--------------enig18AE15C55DE29B1A1367D582--

