Message-ID: <477505A5.6070900@domain.hid>
Date: Fri, 28 Dec 2007 15:18:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF9BE4B0BD90D4C9E3781A7B7"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] fastcall and asmlinkage in x86
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF9BE4B0BD90D4C9E3781A7B7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

most of the code in arch/x86/ipipe_*.c can be pushed into some
ipipe-common.c, reducing the patch size by 10-20k and improving code
maintainability.

But one thing is currently blocking a copy&paste move: a lot of
functions that are declared fastcall on 32 bit are asmlinkage on 64 bit.
As both asmlinkage and fastcall are meaningless on 64 bit, can we safely
switch to fastcall? Or even better, could we drop that redundant
declarations totally, given that everything is fastcall on 32 bit anyway
(unless its marked asmlinkage)?

Thanks,
Jan


--------------enigF9BE4B0BD90D4C9E3781A7B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHdQWpniDOoMHTA+kRAgD/AJsF9kQhPSqwkupGDOo3RklcZH4rgQCeLa5O
btZeRpXfSIObL5gIwdJ2bwc=
=s7XX
-----END PGP SIGNATURE-----

--------------enigF9BE4B0BD90D4C9E3781A7B7--

