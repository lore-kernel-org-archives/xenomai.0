Message-ID: <44E5FB40.1050306@domain.hid>
Date: Fri, 18 Aug 2006 19:39:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] speed up building of posix apps
References: <44E5ACFA.50905@domain.hid>	<17637.50472.580142.331066@domain.hid>	<44E5ED9A.9040201@domain.hid>
	<17637.63696.703047.258987@domain.hid>
In-Reply-To: <17637.63696.703047.258987@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5036A07F3EDCA5CB86C3F413"
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
--------------enig5036A07F3EDCA5CB86C3F413
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Ok, here comes version 2, now with detection of the required ld feat=
ure.
>  > Falls back to normal behaviour if ld is too old. Could you test it p=
lease?
>  >=20
>  > [Grmbl, the fun stops where autoconf begins...]
>=20
> Seems to work. But maybe we could find the bottleneck and fix it in a
> general way. What part of the process is slow ?
>=20

Don't know. Maybe it's some automake magic (the arguments look different
between libtool invocation and linker run), maybe just the long list of
arguments.

Anyway, it's also annoying how the screen is filled up with this
irrelevant information. So besides looking for other optimisations (but
things run fine now I think), I definitely vote for the @file approach
for the sake of output reduction. I haven't build a larger POSIX project
against Xenomai recently, but I could imagine that the dump size can
become even more than just annoying...

Jan


--------------enig5036A07F3EDCA5CB86C3F413
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE5ftAniDOoMHTA+kRAt1rAJ41iGuPYvzoBLNSpQM1FsXVKVjpVgCggUCo
AegqTSpMYXJzS1l0ZSUJIwM=
=84U+
-----END PGP SIGNATURE-----

--------------enig5036A07F3EDCA5CB86C3F413--

