Message-ID: <4429C177.2050009@domain.hid>
Date: Wed, 29 Mar 2006 01:06:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai run-time problem
References: <7C4B97D3898FED44BC087D25490A44A1B6BB64@domain.hid>
In-Reply-To: <7C4B97D3898FED44BC087D25490A44A1B6BB64@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF2B78C9413435B0854E779D1"
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
To: =?ISO-8859-1?Q?Hans_J=F8rgen_Olsen?= <HansJoergen.Olsen@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2B78C9413435B0854E779D1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hans J=F8rgen Olsen wrote:
> Hi.
>=20
> =20
>=20
> First: I'm new to Xenomai and slowly becoming a not_so_new linux user m=
igrating from - aaah, what was it? - win-something, I think it was.
>=20
> =20
>=20
> I have successfully installed Xenomai 2.1 following Hannes Mayer's exce=
llent guide.
>=20
> =20
>=20
> Everything looks fine until testing using the programs in testsuite. Th=
en the process stops with the message:
>=20
> Xenomai: incompatible feature set
>=20
> (required=3D"sep tsc", present=3D"sep", missing=3D"tsc").
>=20
> =20
>=20
> A simple program of my own compile fine but stops running with the same=
 error.
>=20
> =20
>=20
> I have configured Xenomai with options:
>=20
> --enable-x86-sep -enable-x86-tsc
>=20

Are those two flags authentic? In this case you are simply lacking a "-"
in front of the second one: --enable-x86-tsc :)

Jan


--------------enigF2B78C9413435B0854E779D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEKcF4niDOoMHTA+kRAqOpAJ947HmQlwB6/6dpoZVHCy4IJlMfgACfeqer
qa+ctfa6rZ7T4JbJyJgSwuQ=
=H2TT
-----END PGP SIGNATURE-----

--------------enigF2B78C9413435B0854E779D1--

