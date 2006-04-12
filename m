Message-ID: <443D3B15.4000709@domain.hid>
Date: Wed, 12 Apr 2006 19:38:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig02005A01DA148B6602D2E5D6"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] nucleus vs. posix registry
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig02005A01DA148B6602D2E5D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that currently the nucleus registry is not used by the posix
skin, only by the native, vxworks, and vrtx skins. But as it's always on
in case of XENO_OPT_PERVASIVE, this may introduce about 9.7k (x86)
unused code (+ also some data). Why not letting the skins select from
the nucleus what they need?
[patch may follow when time permits]

Jan


--------------enig02005A01DA148B6602D2E5D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPTsVniDOoMHTA+kRAj9LAJwPjkCWwI9WyVd85/fqru2DR1fnYQCfdfG+
O5Z/de2HTNamBtuQgIKLnNg=
=FEUX
-----END PGP SIGNATURE-----

--------------enig02005A01DA148B6602D2E5D6--

