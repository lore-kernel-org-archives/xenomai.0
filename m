Message-ID: <4774D852.2040406@domain.hid>
Date: Fri, 28 Dec 2007 12:04:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2FAB68F3435521419793DD09"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix prepare-kernel.sh for x86 build
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2FAB68F3435521419793DD09
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Index: xenomai/scripts/prepare-kernel.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/scripts/prepare-kernel.sh	(Revision 3329)
+++ xenomai/scripts/prepare-kernel.sh	(Arbeitskopie)
@@ -428,9 +428,9 @@
             patch_append init/Kconfig
     fi
=20
-    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; t=
hen
+    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_archsrc/Makefile=
; then
 	p=3D"drivers-\$(CONFIG_XENOMAI)		+=3D arch/$linux_archsrc/xenomai/"
-	( echo ; echo $p ) | patch_append arch/$linux_arch/Makefile
+	( echo ; echo $p ) | patch_append arch/$linux_archsrc/Makefile
     fi
=20
     patch_architecture_specific=3D"n"


--------------enig2FAB68F3435521419793DD09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHdNhVniDOoMHTA+kRAslDAJ0drnxm4rGde+rXyF16vq64SWq2AwCfcoEB
qo+WttVHOUHQj2VMCAD6v3s=
=4UA5
-----END PGP SIGNATURE-----

--------------enig2FAB68F3435521419793DD09--

