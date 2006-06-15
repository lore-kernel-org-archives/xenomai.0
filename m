Message-ID: <44912ABF.1040300@domain.hid>
Date: Thu, 15 Jun 2006 11:39:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig70D1519A558B22647CCF716C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] gcc-4.1 warnings in switchtest
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
--------------enig70D1519A558B22647CCF716C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

I'm seeing this with gcc-4.1:

src/testsuite/switchtest/switch.c: In function 'main':
src/testsuite/switchtest/switch.c:620: warning: 'params.swt.flags' is
used uninitialized in this function
src/testsuite/switchtest/switch.c:620: warning: 'params.swt.index' is
used uninitialized in this function
src/testsuite/switchtest/switch.c:620: warning: 'params.thread' is used
uninitialized in this function

Real issues or just finickiness?

Jan


--------------enig70D1519A558B22647CCF716C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEkSq/niDOoMHTA+kRAoKoAJwOmm2jQp7lKi5zJ3lUV9vInCtrYACdEkWM
iwwqfMnf5YYzLphr5TWdO2o=
=PiAw
-----END PGP SIGNATURE-----

--------------enig70D1519A558B22647CCF716C--

