Message-ID: <43E4F63C.4090200@domain.hid>
Date: Sat, 04 Feb 2006 19:45:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E635DE192CE77E7C5415BB0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] SMI-doc improvement / RTDM paper
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E635DE192CE77E7C5415BB0
Content-Type: multipart/mixed; boundary="------------050403050009020704090306"

This is a multi-part message in MIME format.
--------------050403050009020704090306
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

this patch tries to clarify where to solve SMI-related latencies. Or
should we even mention the kconfig path?

Moreover, I would like to upload my RTL-Workshop paper about RTDM to
doc/nodist/pdf (~150k) so that it later makes it on the website as well. =
Ok?

Jan

--------------050403050009020704090306
Content-Type: text/x-patch;
 name="smi-doc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="smi-doc.patch"

Index: ksrc/arch/i386/smi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/i386/smi.c	(Revision 539)
+++ ksrc/arch/i386/smi.c	(Arbeitskopie)
@@ -209,8 +209,8 @@
=20
 #else /* ! CONFIG_XENO_HW_SMI_WORKAROUND */
=20
-    printk("Xenomai: Intel chipset found and SMI workaround not enabled,=
\n"
-           "       you may encounter high interrupt latencies.\n");
+    printk("Xenomai: Intel chipset found but SMI workaround not enabled =
in kernel\n"
+           "         configuration. You may encounter high interrupt lat=
encies.\n");
     pci_dev_put(dev);
=20
 #endif /* ! CONFIG_XENO_HW_SMI_WORKAROUND */

--------------050403050009020704090306--

--------------enig7E635DE192CE77E7C5415BB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD5PY8niDOoMHTA+kRAjUSAJ9xr3VdVyVleJdLgCp6Pk14QlzIPgCdEsy1
qQ8KPo2H43TF1KYhen30bpg=
=QXwZ
-----END PGP SIGNATURE-----

--------------enig7E635DE192CE77E7C5415BB0--

