Message-ID: <446E0758.4070700@domain.hid>
Date: Fri, 19 May 2006 19:58:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai: suspending kernel thread [...] after
	exception #14
References: <1147877519.8428.17.camel@domain.hid>
In-Reply-To: <1147877519.8428.17.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9E26EED786E6A72CF2D6AF07"
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
To: Alessio Igor Bogani <abogani@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E26EED786E6A72CF2D6AF07
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Alessio Igor Bogani wrote:
> Hi All,
>=20
> I apologize for my (very) bad english.
>=20
> I received this error:
>=20
> Xenomai: suspending kernel thread c8818a50 ('Test') at 0xc881707b after=

> exception #14
>=20
> Somebody can indicate me where may i found information about "exception=

> #14"?

Your test thread caused some segmentation fault which was caught by
Xenomai and the offending thread was suspended.

Jan


--------------enig9E26EED786E6A72CF2D6AF07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEbgdcniDOoMHTA+kRAh7oAJ9ch2m3ztBk1/+euEnO12mWUMKPvACZAeps
M5nE45DnQXAnip88G8tnIJA=
=5vm1
-----END PGP SIGNATURE-----

--------------enig9E26EED786E6A72CF2D6AF07--

