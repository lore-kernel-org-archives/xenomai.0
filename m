Message-ID: <434951B2.4060907@domain.hid>
Date: Sun, 09 Oct 2005 19:21:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB7CA53B693AACC9AFA4A80F0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] First patch :)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7CA53B693AACC9AFA4A80F0
Content-Type: multipart/mixed; boundary="------------010403040108070309050106"

This is a multi-part message in MIME format.
--------------010403040108070309050106
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hehe, the show goes on!

Here is the first patch for the new xenomai code base. Fixes some naming
inconsistency discovered while trying to make RTnet compile (still some
work remaining here...).

Jan

--------------010403040108070309050106
Content-Type: text/x-patch;
 name="xeno-config.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-config.patch"

Index: scripts/xeno-config.in
===================================================================
--- scripts/xeno-config.in	(Revision 9)
+++ scripts/xeno-config.in	(Arbeitskopie)
@@ -13,7 +13,7 @@
 XENO_CC="@CC@"
 XENO_TARGET_ARCH="@XENO_TARGET_ARCH@"
 XENO_TARGET_SUBARCH="@XENO_TARGET_SUBARCH@"
-XENO_CONFIG="${staging}${pkgdatadir}/config-xeno-${XENO_VERSION}"
+XENO_CONFIG="${staging}${pkgdatadir}/config-xenomai-${XENO_VERSION}"
 XENO_LINUX_DIR="@XENO_LINUX_DIR@"
 XENO_LINUX_VERSION="@XENO_LINUX_VERSION@"
 XENO_KERNEL_CFLAGS="-I. -I${staging}${includedir} @XENO_KMOD_APP_CFLAGS@ @XENO_FP_CFLAGS@"

--------------010403040108070309050106--

--------------enigB7CA53B693AACC9AFA4A80F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDSVGyniDOoMHTA+kRAunMAJ9Nkp4jmoKVE518rAVdbYxRT1y+fgCeKV3w
bqH01KuWyiOHFqmGowdiFlk=
=gNWa
-----END PGP SIGNATURE-----

--------------enigB7CA53B693AACC9AFA4A80F0--

