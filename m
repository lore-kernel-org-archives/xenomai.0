Message-ID: <486E6486.5060000@domain.hid>
Date: Fri, 04 Jul 2008 19:57:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0621C02526644B8FF23FE0F4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] comedi: Fix include for do_div
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0621C02526644B8FF23FE0F4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Required with 2.6.26 where there is no more calc64. And asm/div64.h is
what you actually want.

Jan

PS: Kernel-style reformatting would be nice - one day... :->


Index: ksrc/drivers/comedi/instruction.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/comedi/instruction.c	(Revision 4017)
+++ ksrc/drivers/comedi/instruction.c	(Arbeitskopie)
@@ -25,7 +25,7 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/mman.h>
-#include <linux/calc64.h>
+#include <asm/div64.h>
 #include <asm/io.h>
 #include <asm/errno.h>
=20


--------------enig0621C02526644B8FF23FE0F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkhuZIkACgkQniDOoMHTA+mgogCZAUZOllZFtBl6LIp+44z88IF+
yKAAn3m5YXftN0A5IdFuhqjFtz+OETgd
=RuLG
-----END PGP SIGNATURE-----

--------------enig0621C02526644B8FF23FE0F4--

