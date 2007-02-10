Message-ID: <45CDAA95.1070900@domain.hid>
Date: Sat, 10 Feb 2007 12:20:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig39E77A6561484F4C70C62569"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] tracer broken on 2.6.20-i386
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
--------------enig39E77A6561484F4C70C62569
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe,

have you had to adopt any tracer-related code while switching to 2.6.20?
The same .config that worked fine for 2.6.19 doesn't boot here on
2.6.20. The kernel hangs during or after decompression. Disabling the
tracer resolves this.

Jan


--------------enig39E77A6561484F4C70C62569
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFzaqVniDOoMHTA+kRAiT7AJwIGixrra+c92KdfR8SpxWcf+RLRACeKx7h
Vg9ENNT2UltIwvb/nYeBHnA=
=k8cg
-----END PGP SIGNATURE-----

--------------enig39E77A6561484F4C70C62569--

