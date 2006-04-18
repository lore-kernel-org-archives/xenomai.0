Message-ID: <444530EA.4020005@domain.hid>
Date: Tue, 18 Apr 2006 20:33:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig44BF1726606F3E4C64455098"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] ipipe-2.6.15-i386-1.2-04 is lacking notrace
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig44BF1726606F3E4C64455098
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

your generation script for the 2.6.15 patch seems to lack the
include/linux/compiler.h patch for notrace - doesn't build with the
tracer switched on.

Jan


--------------enig44BF1726606F3E4C64455098
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERTDqniDOoMHTA+kRAlAPAJ0fL8j4qqGbKMGHxdQ1b520LKzbEACfUlPK
xntvygfmWSlj/+1g5pYKUwQ=
=aGX1
-----END PGP SIGNATURE-----

--------------enig44BF1726606F3E4C64455098--

