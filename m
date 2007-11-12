Message-ID: <4738DBA6.8020608@domain.hid>
Date: Tue, 13 Nov 2007 00:03:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF641D43E357AF5AAF6CBB1B1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/2] i386: report timer frequency on tickdev
	take-over
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF641D43E357AF5AAF6CBB1B1
Content-Type: multipart/mixed;
 boundary="------------070304080502000701050900"

This is a multi-part message in MIME format.
--------------070304080502000701050900
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Here comes my favourite approach to report the frequency of the timer
that an I-pipe user takes over: via the very same API. This patch
extends ipipe_request_tickdev by a pointer to a variable that shall
receive the timer frequency as the hijacked clock_event_device carries it=
=2E

This is the most generic, future-proof, and clean approach IMHO, because
it doesn't assume anything about the tickdev selection the user may make
when requesting the device.

Jan

--------------070304080502000701050900
Content-Type: text/x-patch;
 name="report-tickdev-freq-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="report-tickdev-freq-i386.patch"

---
 include/linux/ipipe_tickdev.h |    2 +-
 kernel/ipipe/core.c           |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6.23-ipipe/include/linux/ipipe_tickdev.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/include/linux/ipipe_tickdev.h
+++ linux-2.6.23-ipipe/include/linux/ipipe_tickdev.h
@@ -46,7 +46,7 @@ int ipipe_request_tickdev(const char *de
 					  struct ipipe_tick_device *tdev),
 			  int (*emutick)(unsigned long evt,
 					 struct ipipe_tick_device *tdev),
-			  int cpu);
+			  int cpu, unsigned long *tick_freq);
=20
 void ipipe_release_tickdev(int cpu);
=20
Index: linux-2.6.23-ipipe/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/kernel/ipipe/core.c
+++ linux-2.6.23-ipipe/kernel/ipipe/core.c
@@ -123,10 +123,11 @@ int ipipe_request_tickdev(const char *de
 					  struct ipipe_tick_device *tdev),
 			  int (*emutick)(unsigned long delta,
 					 struct ipipe_tick_device *tdev),
-			  int cpu)
+			  int cpu, unsigned long *tick_freq)
 {
 	struct ipipe_tick_device *itd;
 	struct tick_device *slave;
+	unsigned long long freq;
 	unsigned long flags;
 	int status;
=20
@@ -170,6 +171,8 @@ int ipipe_request_tickdev(const char *de
 	itd->emul_set_tick =3D emutick;
 	itd->real_set_mode =3D slave->evtdev->set_mode;
 	itd->real_set_tick =3D slave->evtdev->set_next_event;
+	freq =3D (1000000000ULL * slave->evtdev->mult) >> slave->evtdev->shift;=

+	*tick_freq =3D (unsigned long)freq;
 	slave->evtdev->set_mode =3D __ipipe_set_tick_mode;
 	slave->evtdev->set_next_event =3D __ipipe_set_next_tick;
 	status =3D slave->evtdev->mode;

--------------070304080502000701050900--

--------------enigF641D43E357AF5AAF6CBB1B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHONumniDOoMHTA+kRAlZiAJ9xjSU2yl97/iD0+HvZ+o6uLqgzigCfTO8F
H5SYv5u2bcTZSVw4nE7pGLM=
=Z3aT
-----END PGP SIGNATURE-----

--------------enigF641D43E357AF5AAF6CBB1B1--

