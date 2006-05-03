Message-ID: <44589281.1000501@domain.hid>
Date: Wed, 03 May 2006 13:22:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem with kernel module and Xenomai 2.1
References: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD144@domain.hid>
In-Reply-To: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD144@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig957254B13F91D7C6662D1031"
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
To: Antoine.BRUGEAS@fr.thalesgroup.com
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig957254B13F91D7C6662D1031
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Antoine.BRUGEAS@fr.thalesgroup.com wrote:
> Hello,
>=20
> I have a problem, i can't find the following modules on my PC : Xeno_ha=
l.ko, Xeno_nucleus.ko and Xeno_native.ko.=20

Already looked for xeno_*.ko (note the lower case)? Or did you compiled
Xenomai directly into the kernel? Then there are of course no modules.

>=20
> I forgot to do something during the installation??=20
>=20
> Moreover, I search an example of a "Makefile" to compile a kernel modul=
e with xenomai 2.1

Hannes has a nice universal Makefile on his page:

http://www.captain.at/xenomai-real-time-driver-example-extra.php

Jan


--------------enig957254B13F91D7C6662D1031
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEWJKEniDOoMHTA+kRAlTiAJ9EOFifZlGtxNzpWMSIZ9RVqPg38wCeJJKx
q0WKn3S1PKuCcJ60WNdmiko=
=9E4Z
-----END PGP SIGNATURE-----

--------------enig957254B13F91D7C6662D1031--

