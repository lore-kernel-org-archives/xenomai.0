Message-ID: <443E9A8D.2090300@domain.hid>
Date: Thu, 13 Apr 2006 20:38:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC101F93F86ECCB8E18A549C3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] detect problematic kernel configs
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
--------------enigC101F93F86ECCB8E18A549C3
Content-Type: multipart/mixed; boundary="------------010000050502050005060504"

This is a multi-part message in MIME format.
--------------010000050502050005060504
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

this patch tries to reduce the traps newbies may tap by leaving (for us)
well-known problematic kernel switches on. And are there any futher I
forgot, e.g. on other archs?

Jan

--------------010000050502050005060504
Content-Type: text/plain;
 name="latency-warnings.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="latency-warnings.patch"

Index: ksrc/arch/i386/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/i386/Kconfig	(revision 924)
+++ ksrc/arch/i386/Kconfig	(working copy)
@@ -194,3 +194,19 @@ depends on XENO_OPT_NUCLEUS
 source "drivers/xenomai/Kconfig"
=20
 endmenu
+
+if XENOMAI =3D y
+
+comment "WARNING: Potential latency killers detected!"
+        depends on PM || ACPI || CPU_FREQ
+
+comment "Power Management (PM)"
+        depends on PM
+
+comment "ACPI"
+        depends on ACPI
+
+comment "CPU frequency scaling (CPU_FREQ)"
+        depends on CPU_FREQ
+
+endif


--------------010000050502050005060504--

--------------enigC101F93F86ECCB8E18A549C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPpqNniDOoMHTA+kRAltuAJ4qsv/2Qr9+8oB/UUnwMUa8peT7jgCcCPFd
Vu/JfeZ6qY20oCbYB39s2+s=
=k/zb
-----END PGP SIGNATURE-----

--------------enigC101F93F86ECCB8E18A549C3--

