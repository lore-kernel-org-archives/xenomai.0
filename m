Message-ID: <44441BE1.7090602@domain.hid>
Date: Tue, 18 Apr 2006 00:51:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] More progress with the buildbot
References: <200604171047.36531.niklaus.giger@domain.hid>
In-Reply-To: <200604171047.36531.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7F1C87946807060ED0F57D08"
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
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7F1C87946807060ED0F57D08
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi everybody
>=20
> Before leaving for a week of vacation with my son I managed to improve =
the=20
> buildbot.=20
>=20
> a) RTnet on TQM860L compiles successfully. (Took me several hours to di=
scover
>    that rtnet/configure --with-linux=3D only works with absolute paths,=
 not a
>    relative ones).

Oops, sorry. Fixed in latest RTnet SVN revision. A SVN update of RTnet
should also solve the "unknown version 2.2-dev" issue.

Thanks for your effort,
Jan


--------------enig7F1C87946807060ED0F57D08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERBvhniDOoMHTA+kRAqlLAJ909bzGkA3mB6dyggFrh6az9o4NbwCdFZuq
d7MUBV8oEe0iTWIDg8z5X8g=
=3rog
-----END PGP SIGNATURE-----

--------------enig7F1C87946807060ED0F57D08--

