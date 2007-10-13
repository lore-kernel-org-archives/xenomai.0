Message-ID: <4710E252.8050405@domain.hid>
Date: Sat, 13 Oct 2007 17:20:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig10119DFCF744E5EB8CEF9923"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [minor BUG] ARM: __check_kvm_seq undefined
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
--------------enig10119DFCF744E5EB8CEF9923
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

building the nucleus (SVN head) as a module for ARM (2.6.20.20,
ipipe-1.7-06) fails due to undefined __check_kvm_seq. Not sure is anyone
will choose such a setup on embedded systems, but who knows... Is this
symbol actually required or just accidentally included?

Jan


--------------enig10119DFCF744E5EB8CEF9923
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHEOJSniDOoMHTA+kRAuNBAJsEoHpwtTDlapoKyKfVSHgvLHqjtgCfan1W
AZ1YPEKPNvHPnB1sSkMDqAg=
=2DE6
-----END PGP SIGNATURE-----

--------------enig10119DFCF744E5EB8CEF9923--

