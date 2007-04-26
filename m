Message-ID: <4630655A.50204@domain.hid>
Date: Thu, 26 Apr 2007 10:39:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig58B0215359E226AD53250F1D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix smp build error of native skin
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
--------------enig58B0215359E226AD53250F1D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

We need nucleus/pod.h because xeno_flush_rq() refers to nklock.

Jan


--- include/native/ppd.h        (Revision 2410)
+++ include/native/ppd.h        (Arbeitskopie)
@@ -22,6 +22,7 @@
 #ifndef _XENO_PPD_H
 #define _XENO_PPD_H

+#include <nucleus/pod.h>
 #include <nucleus/ppd.h>
 #include <nucleus/heap.h>



--------------enig58B0215359E226AD53250F1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMGVaniDOoMHTA+kRArcvAJ49rq4Yj2ITUBTbATTT0KwcjRsIOACfQ4ED
DxNDjKvc4BcUcIkOozqMxzo=
=7g4V
-----END PGP SIGNATURE-----

--------------enig58B0215359E226AD53250F1D--

