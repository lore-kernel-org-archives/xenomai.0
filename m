Message-ID: <435D4FEE.10301@domain.hid>
Date: Mon, 24 Oct 2005 23:19:42 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E19B0A3D4D33A893023F9ED"
Subject: [Xenomai-core] [patch] RTDM abstraction for priority direction
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
--------------enig7E19B0A3D4D33A893023F9ED
Content-Type: multipart/mixed; boundary="------------010704050204070409070608"

This is a multi-part message in MIME format.
--------------010704050204070409070608
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

it turned out that it is useful to abstract the priority
increment/decrement by one level at the RTDM layer - for systems that
use a different scheme compared to POSIX or Xenomai (so far only classic
RTAI). Please apply.

Jan

--------------010704050204070409070608
Content-Type: text/x-patch;
 name="rtdm_raise_lower_prio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtdm_raise_lower_prio.patch"

Index: skins/rtdm/rtdm_driver.h
===================================================================
--- skins/rtdm/rtdm_driver.h	(Revision 72)
+++ skins/rtdm/rtdm_driver.h	(Arbeitskopie)
@@ -831,8 +831,16 @@
 #define RTDM_TASK_HIGHEST_PRIORITY  XNCORE_HIGH_PRIO
 /** @} */

+/*!
+ * @anchor changetaskprio @name Task Priority Modification
+ * Raise or lower task priorities by one level
+ * @{ */
+#define RTDM_TASK_RAISE_PRIORITY    (+1)
+#define RTDM_TASK_LOWER_PRIORITY    (-1)
 /** @} */

+/** @} */
+
 static inline int rtdm_task_init(rtdm_task_t *task, const char *name,
                                  rtdm_task_proc_t task_proc, void *arg,
                                  int priority, __u64 period)

--------------010704050204070409070608--

--------------enig7E19B0A3D4D33A893023F9ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDXU/uncNeS9Q0k+IRAkCNAKDLb7edgrv50z6UMZMXTcP+TyF4VgCeNZmf
Lhj36bsbrK48IUKHg6Rhz3U=
=fOpd
-----END PGP SIGNATURE-----

--------------enig7E19B0A3D4D33A893023F9ED--

