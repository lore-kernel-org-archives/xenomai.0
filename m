Message-ID: <4776AF17.3070102@domain.hid>
Date: Sat, 29 Dec 2007 21:33:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig08409C760477EFFB82589E12"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] prepare-kernel: get rid of arch_makefile
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
--------------enig08409C760477EFFB82589E12
Content-Type: multipart/mixed;
 boundary="------------070502070503010102010806"

This is a multi-part message in MIME format.
--------------070502070503010102010806
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

For me there appears to be neither a need for nor a benefit of patching
the sub-arch Makefile instead of the top one. The big drawback is that
you have to re-prepare the kernel when you switch between 32 and 64-bit
mode at .config level. So let's kill this special case.

Jan

--------------070502070503010102010806
Content-Type: text/x-patch;
 name="kill-arch_makefile.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="kill-arch_makefile.patch"

Index: xenomai/scripts/prepare-kernel.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/scripts/prepare-kernel.sh	(Revision 3348)
+++ xenomai/scripts/prepare-kernel.sh	(Arbeitskopie)
@@ -334,14 +334,11 @@
    fi
 done
=20
-arch_makefile=3DMakefile
-
 # i386 and x86_64 architectures are merged since 2.6.24. The resulting
 # combo is available from arch/x86 when present.
 if test "$xenomai_arch" =3D x86; then
   if test -d $linux_tree/arch/x86; then
       linux_arch=3Dx86
-      arch_makefile=3DMakefile_$x86_arch_bits
   fi
 fi
=20
@@ -433,9 +430,9 @@
             patch_append init/Kconfig
     fi
=20
-    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/$arch_makef=
ile; then
+    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; t=
hen
 	p=3D"drivers-\$(CONFIG_XENOMAI)		+=3D arch/$linux_arch/xenomai/"
-	( echo ; echo $p ) | patch_append arch/$linux_arch/$arch_makefile
+	( echo ; echo $p ) | patch_append arch/$linux_arch/Makefile
     fi
=20
     patch_architecture_specific=3D"n"

--------------070502070503010102010806--

--------------enig08409C760477EFFB82589E12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHdq8bniDOoMHTA+kRAr3dAJ4iCETpuc9RyVxYMPm+ei4CN4N+mACePbL+
ZtPvBeVIQW+sPfM3Xorckbw=
=WcT6
-----END PGP SIGNATURE-----

--------------enig08409C760477EFFB82589E12--

