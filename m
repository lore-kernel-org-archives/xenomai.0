Message-ID: <4738DC00.80606@domain.hid>
Date: Tue, 13 Nov 2007 00:04:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3CF2207FE6CA88FCF3D02847"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/2] Refactor clock_event_device emulation
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
--------------enig3CF2207FE6CA88FCF3D02847
Content-Type: multipart/mixed;
 boundary="------------030201040304050106000502"

This is a multi-part message in MIME format.
--------------030201040304050106000502
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I-pipe's current hooking into the GENERIC_CLOCKEVENTS infrastructure
contains an ugly out-of-band argument passing via the device structure
(delta...) and unneeded indirections of the intercepted services. This
patches overcomes both by cleanly modifying relevant properties of the
clock_event_device on takeover.

Jan

--------------030201040304050106000502
Content-Type: text/x-patch;
 name="refactor-tickdev-emulation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="refactor-tickdev-emulation.patch"

---
 include/linux/clockchips.h    |    1=20
 include/linux/ipipe_tickdev.h |   11 +++++---
 kernel/ipipe/core.c           |   54 +++++++++++++++++------------------=
-------
 kernel/time/clockevents.c     |    1=20
 4 files changed, 30 insertions(+), 37 deletions(-)

Index: linux-2.6.23.1-xeno/include/linux/clockchips.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/include/linux/clockchips.h
+++ linux-2.6.23.1-xeno/include/linux/clockchips.h
@@ -91,7 +91,6 @@ struct clock_event_device {
 	struct list_head	list;
 	enum clock_event_mode	mode;
 	ktime_t			next_event;
-	int64_t			delta;
 };
=20
 /*
Index: linux-2.6.23.1-xeno/include/linux/ipipe_tickdev.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/include/linux/ipipe_tickdev.h
+++ linux-2.6.23.1-xeno/include/linux/ipipe_tickdev.h
@@ -31,21 +31,24 @@ struct tick_device;
 struct ipipe_tick_device {
=20
 	void (*emul_set_mode)(enum clock_event_mode,
-			      struct ipipe_tick_device *tdev);
+			      struct clock_event_device *cdev);
 	int (*emul_set_tick)(unsigned long delta,
-			     struct ipipe_tick_device *tdev);
+			     struct clock_event_device *cdev);
 	void (*real_set_mode)(enum clock_event_mode mode,
 			      struct clock_event_device *cdev);
 	int (*real_set_tick)(unsigned long delta,
 			     struct clock_event_device *cdev);
 	struct tick_device *slave;
+	unsigned long real_max_delta_ns;
+	unsigned long real_mult;
+	int real_shift;
 };
=20
 int ipipe_request_tickdev(const char *devname,
 			  void (*emumode)(enum clock_event_mode mode,
-					  struct ipipe_tick_device *tdev),
+					  struct clock_event_device *cdev),
 			  int (*emutick)(unsigned long evt,
-					 struct ipipe_tick_device *tdev),
+					 struct clock_event_device *cdev),
 			  int cpu, unsigned long *tick_freq);
=20
 void ipipe_release_tickdev(int cpu);
Index: linux-2.6.23.1-xeno/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/kernel/ipipe/core.c
+++ linux-2.6.23.1-xeno/kernel/ipipe/core.c
@@ -97,36 +97,16 @@ DECLARE_PER_CPU(struct tick_device, tick
=20
 static DEFINE_PER_CPU(struct ipipe_tick_device, ipipe_tick_cpu_device);
=20
-static void __ipipe_set_tick_mode(enum clock_event_mode mode,
-				  struct clock_event_device *cdev)
-{
-	struct ipipe_tick_device *itd;
-	itd =3D &per_cpu(ipipe_tick_cpu_device, smp_processor_id());
-	itd->emul_set_mode(mode, itd);
-}
-
-static int __ipipe_set_next_tick(unsigned long evt,
-				 struct clock_event_device *cdev)
-{
-	uint64_t delta_ns =3D (uint64_t)cdev->delta;
-	struct ipipe_tick_device *itd;
-
-	if (delta_ns > ULONG_MAX)
-		delta_ns =3D ULONG_MAX;
-
-	itd =3D &per_cpu(ipipe_tick_cpu_device, smp_processor_id());
-	return itd->emul_set_tick((unsigned long)delta_ns, itd);
-}
-
 int ipipe_request_tickdev(const char *devname,
 			  void (*emumode)(enum clock_event_mode mode,
-					  struct ipipe_tick_device *tdev),
+					  struct clock_event_device *cdev),
 			  int (*emutick)(unsigned long delta,
-					 struct ipipe_tick_device *tdev),
+					 struct clock_event_device *cdev),
 			  int cpu, unsigned long *tick_freq)
 {
 	struct ipipe_tick_device *itd;
 	struct tick_device *slave;
+	struct clock_event_device *evtdev;
 	unsigned long long freq;
 	unsigned long flags;
 	int status;
@@ -166,16 +146,23 @@ int ipipe_request_tickdev(const char *de
 	 * to oneshot dynamically (highres/no_hz tick mode).
 	 */
=20
+	evtdev =3D slave->evtdev;
 	itd->slave =3D slave;
 	itd->emul_set_mode =3D emumode;
 	itd->emul_set_tick =3D emutick;
-	itd->real_set_mode =3D slave->evtdev->set_mode;
-	itd->real_set_tick =3D slave->evtdev->set_next_event;
-	freq =3D (1000000000ULL * slave->evtdev->mult) >> slave->evtdev->shift;=

+	itd->real_set_mode =3D evtdev->set_mode;
+	itd->real_set_tick =3D evtdev->set_next_event;
+	itd->real_max_delta_ns =3D evtdev->max_delta_ns;
+	itd->real_mult =3D evtdev->mult;
+	itd->real_shift =3D evtdev->shift;
+	freq =3D (1000000000ULL * evtdev->mult) >> evtdev->shift;
 	*tick_freq =3D (unsigned long)freq;
-	slave->evtdev->set_mode =3D __ipipe_set_tick_mode;
-	slave->evtdev->set_next_event =3D __ipipe_set_next_tick;
-	status =3D slave->evtdev->mode;
+	evtdev->set_mode =3D emumode;
+	evtdev->set_next_event =3D emutick;
+	evtdev->max_delta_ns =3D ULONG_MAX;
+	evtdev->mult =3D 1;
+	evtdev->shift =3D 0;
+	status =3D evtdev->mode;
 out:
 	ipipe_critical_exit(flags);
=20
@@ -186,6 +173,7 @@ void ipipe_release_tickdev(int cpu)
 {
 	struct ipipe_tick_device *itd;
 	struct tick_device *slave;
+	struct clock_event_device *evtdev;
 	unsigned long flags;
=20
 	flags =3D ipipe_critical_enter(NULL);
@@ -194,8 +182,12 @@ void ipipe_release_tickdev(int cpu)
=20
 	if (itd->slave !=3D NULL) {
 		slave =3D &per_cpu(tick_cpu_device, cpu);
-		slave->evtdev->set_mode =3D itd->real_set_mode;
-		slave->evtdev->set_next_event =3D itd->real_set_tick;
+		evtdev =3D slave->evtdev;
+		evtdev->set_mode =3D itd->real_set_mode;
+		evtdev->set_next_event =3D itd->real_set_tick;
+		evtdev->max_delta_ns =3D itd->real_max_delta_ns;
+		evtdev->mult =3D itd->real_mult;
+		evtdev->shift =3D itd->real_shift;
 		itd->slave =3D NULL;
 	}
=20
Index: linux-2.6.23.1-xeno/kernel/time/clockevents.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/kernel/time/clockevents.c
+++ linux-2.6.23.1-xeno/kernel/time/clockevents.c
@@ -84,7 +84,6 @@ int clockevents_program_event(struct clo
 		return -ETIME;
=20
 	dev->next_event =3D expires;
-	dev->delta =3D delta;
=20
 	if (dev->mode =3D=3D CLOCK_EVT_MODE_SHUTDOWN)
 		return 0;

--------------030201040304050106000502--

--------------enig3CF2207FE6CA88FCF3D02847
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHONwAniDOoMHTA+kRAkq2AJ9d51FgZFmGg2BtVcj5cZEx/IH0bQCeLWKC
loYGm8YSDI8/SE2fja4JFuM=
=s3oc
-----END PGP SIGNATURE-----

--------------enig3CF2207FE6CA88FCF3D02847--

