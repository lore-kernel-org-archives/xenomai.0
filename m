Message-ID: <448EECAD.2060706@domain.hid>
Date: Tue, 13 Jun 2006 18:49:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig17707CC58E756E231250EBC8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] duplicate div94by32 macros?
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
--------------enig17707CC58E756E231250EBC8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

__rthal_generic_div96by32 from asm-generic/hal.h looks similar to
__rthal_div96by32 from asm-i386/hal.h. Shouldn't this get cleaned up?

Jan


--------------enig17707CC58E756E231250EBC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjuytniDOoMHTA+kRAn57AJ46agNcgO3d0+qcRHEh1MSUPuO/vgCfXdTA
d4hriEfBN1aq+IPF8lSEtGE=
=16DU
-----END PGP SIGNATURE-----

--------------enig17707CC58E756E231250EBC8--

