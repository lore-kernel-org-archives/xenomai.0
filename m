Message-ID: <44E6E6D2.8020204@domain.hid>
Date: Sat, 19 Aug 2006 12:24:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] speed up building of posix apps
References: <44E5ACFA.50905@domain.hid>	<17637.50472.580142.331066@domain.hid>	<44E5ED9A.9040201@domain.hid>	<17637.63696.703047.258987@domain.hid>	<44E5FB40.1050306@domain.hid>
	<17638.11497.402153.649650@domain.hid>
In-Reply-To: <17638.11497.402153.649650@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFC52888BEED214970463EA73"
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
--------------enigFC52888BEED214970463EA73
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > Ok, here comes version 2, now with detection of the required ld=
 feature.
>  > >  > Falls back to normal behaviour if ld is too old. Could you test=
 it please?
>  > >  >=20
>  > >  > [Grmbl, the fun stops where autoconf begins...]
>  > >=20
>  > > Seems to work. But maybe we could find the bottleneck and fix it i=
n a
>  > > general way. What part of the process is slow ?
>  > >=20
>  >=20
>  > Don't know. Maybe it's some automake magic (the arguments look diffe=
rent
>  > between libtool invocation and linker run), maybe just the long list=
 of
>  > arguments.
>  >=20
>  > Anyway, it's also annoying how the screen is filled up with this
>  > irrelevant information. So besides looking for other optimisations (=
but
>  > things run fine now I think), I definitely vote for the @file approa=
ch
>  > for the sake of output reduction. I haven't build a larger POSIX pro=
ject
>  > against Xenomai recently, but I could imagine that the dump size can=

>  > become even more than just annoying...
>=20
> Patch applied, thanks. Since we are talking about optimisation, in shel=
l
> scripts, I prefer to set a variable to true (or better, the : builtin)
> or false, this way, it may be used directly as a condition.
>=20

Sorry, don't get yet what part you are referring to. If you would like
to express something in that patch differently, go ahead. I was already
happy when it worked. :)

Jan


--------------enigFC52888BEED214970463EA73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE5ubSniDOoMHTA+kRAuUhAJ9eCEKkgQa7jOw2prTuTmpjmFFCDACeMZbe
kx0HrBdBGOWPSQu+0xbtg9s=
=bkAk
-----END PGP SIGNATURE-----

--------------enigFC52888BEED214970463EA73--

