Message-ID: <4662C02D.4010307@domain.hid>
Date: Sun, 03 Jun 2007 15:20:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF910D087287EC49A8F2E96E4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Kill nkpod?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF910D087287EC49A8F2E96E4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

if I got your latest refactoring correctly, there can now only be one
kind of pod registered: nkpod_struct. In that case, wouldn't it be
consequent to remove the nkpod indirection from Xenomai as well? There
are quite a few occurrences, I know...

Jan


--------------enigF910D087287EC49A8F2E96E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGYsAtniDOoMHTA+kRAlI1AJ4mx65xtxdNPzjX2KeoMJaLqRXrHwCfYlvc
prUvbottX9lfjHt6fGLjFRQ=
=gjQy
-----END PGP SIGNATURE-----

--------------enigF910D087287EC49A8F2E96E4--

