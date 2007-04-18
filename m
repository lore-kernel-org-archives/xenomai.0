Message-ID: <4626888F.4010300@domain.hid>
Date: Wed, 18 Apr 2007 23:07:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46265FC8.1070207@domain.hid>	<1176926837.5010.90.camel@domain.hid>
	<17958.32569.506331.124185@domain.hid>
In-Reply-To: <17958.32569.506331.124185@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig858E46D861BBBBC4FFF70629"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] target width of shifts on 64 bits
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
--------------enig858E46D861BBBBC4FFF70629
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > - the posix registry
>=20
> Is it enough to replace 1 << (fd % BITS_PER_LONG)=20
> with 1L << (fd % BITS_PER_LONG) ?
>=20

Yes, of course!

Jan


--------------enig858E46D861BBBBC4FFF70629
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGJoiPniDOoMHTA+kRAi3rAJ9GrderZuNugPCiymYfJ5nIQ5LIGQCfUSOl
1xqxzwhSAj3lv2EBVFRQ+lM=
=2NG5
-----END PGP SIGNATURE-----

--------------enig858E46D861BBBBC4FFF70629--

