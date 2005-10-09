Message-ID: <4349615F.7010307@domain.hid>
Date: Sun, 09 Oct 2005 20:28:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB9E183B0173496FEAE37FD00"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [patch] include core.h in rtdm_driver.h
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
--------------enigB9E183B0173496FEAE37FD00
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- skins/rtdm/rtdm_driver.h    (Revision 10)
+++ skins/rtdm/rtdm_driver.h    (Arbeitskopie)
@@ -34,6 +34,7 @@
 #include <linux/list.h>

 #include <nucleus/xenomai.h>
+#include <nucleus/core.h>
 #include <nucleus/heap.h>
 #include <nucleus/pod.h>
 #include <nucleus/synch.h>


Required for XNCORE_xxx_PRIO defines.

Jan

--------------enigB9E183B0173496FEAE37FD00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDSWFfniDOoMHTA+kRApVDAJ9HSGTxY36A9SwVkVphILUXwRPHwQCfThYR
8mF85UDLRwFYFBpCoWdNPu0=
=4FzL
-----END PGP SIGNATURE-----

--------------enigB9E183B0173496FEAE37FD00--

