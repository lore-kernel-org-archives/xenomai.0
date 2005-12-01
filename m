Message-ID: <438E42B7.5080808@domain.hid>
Date: Thu, 01 Dec 2005 01:24:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B8055B45F4219C4139DDECC"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [patch] minor doc clarification
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
--------------enig8B8055B45F4219C4139DDECC
Content-Type: multipart/mixed; boundary="------------080405080206090807050607"

This is a multi-part message in MIME format.
--------------080405080206090807050607
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

this patch clarifies the usage of rtdm_task_join_nrt.

Typically, rtdm_task_join_nrt + target task wakeup should be preferred
over rtdm_task_destroy during cleanup of drivers. It's now intensively
used in RTnet.

Jan

--------------080405080206090807050607
Content-Type: text/x-patch;
 name="join_nrt-doc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="join_nrt-doc.patch"

Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(Revision 219)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,7 @@
+2005-12-01  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/skins/rtdm/drvlib.c (rtdm_task_join_nrt): Clarify doc.
+
 2005-11-30  Philippe Gerum  <rpm@xenomai.org>
=20
 	* ksrc/nucleus/pod.c (xnpod_delete_thread): Prevent double-deletion.
@@ -10,7 +14,7 @@
 	* ksrc/arch/powerpc/patches: Upgrade to Adeos
 	2.4.25-denx-0.9-04, 2.6.10-ppc64-r3.patch.
=20
-2005-11-30  Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid>
+2005-11-30  Ignacio Garcia Perez <iggarpe@domain.hid>
=20
 	* ksrc/nucleus/timer.c: Make internal routines static.
=20
Index: ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/drvlib.c	(Revision 219)
+++ ksrc/skins/rtdm/drvlib.c	(Arbeitskopie)
@@ -250,6 +250,11 @@
  * @param[in,out] task Task handle as returned by rtdm_task_init()
  * @param[in] poll_delay Polling delay in milliseconds
  *
+ * @note It is not required to call rtdm_task_destroy() for a task which=
 has
+ * been passed to rtdm_task_join_nrt(). Moreover, don't forget to inform=
 the
+ * targeted task that it has to terminate. Otherwise, this function will=
 never
+ * return.
+ *
  * Environments:
  *
  * This service can be called from:

--------------080405080206090807050607--

--------------enig8B8055B45F4219C4139DDECC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDjkK6niDOoMHTA+kRApFrAJ91gsgdtlCrMflWSvbA2q2LZn+UgACdEjDH
N0Uctdfi00zOufQk2/VM/cw=
=PxVX
-----END PGP SIGNATURE-----

--------------enig8B8055B45F4219C4139DDECC--

