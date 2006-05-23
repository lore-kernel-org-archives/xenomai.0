Message-ID: <447364FD.9090305@domain.hid>
Date: Tue, 23 May 2006 21:39:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig49FC0F7EA87427FE16A75C33"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [patch] fix nmi for gcc-4.1
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
--------------enig49FC0F7EA87427FE16A75C33
Content-Type: multipart/mixed; boundary="------------010400070406030602030605"

This is a multi-part message in MIME format.
--------------010400070406030602030605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

this patch fixes a gcc-4.1 error in the nmi watchdog code on i386.

Jan

--------------010400070406030602030605
Content-Type: text/plain;
 name="nmi-wd-align.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="nmi-wd-align.patch"

Index: ksrc/arch/i386/nmi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/i386/nmi.c	(Revision 1135)
+++ ksrc/arch/i386/nmi.c	(Arbeitskopie)
@@ -54,12 +54,15 @@
     (P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|         =
\
      P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENA=
BLE)
=20
-typedef struct {
-    /* Xenomai watchdog data. */
-    unsigned armed;
-    unsigned long perfctr_msr;
-    unsigned long long next_linux_check;
-    unsigned int p4_cccr_val;
+typedef union {
+    struct {
+        /* Xenomai watchdog data. */
+        unsigned armed;
+        unsigned long perfctr_msr;
+        unsigned long long next_linux_check;
+        unsigned int p4_cccr_val;
+    };
+    char __pad[SMP_CACHE_BYTES];
 } rthal_nmi_wd_t ____cacheline_aligned;
=20
 static rthal_nmi_wd_t rthal_nmi_wds[NR_CPUS];

--------------010400070406030602030605--

--------------enig49FC0F7EA87427FE16A75C33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEc2T9niDOoMHTA+kRAkvXAJ9kiNaBLCOvmNxPhxB8umAbFQdmXQCcC56K
QLDaPOtnHpAE8R47VHdVaCQ=
=Ptoo
-----END PGP SIGNATURE-----

--------------enig49FC0F7EA87427FE16A75C33--

