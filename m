Message-ID: <44BDD70F.8080401@domain.hid>
Date: Wed, 19 Jul 2006 08:54:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig24F777F4B46036B0536547E3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 3/2] kill XN_INFINITE xntimer delays
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
--------------enig24F777F4B46036B0536547E3
Content-Type: multipart/mixed; boundary="------------040709090804090109040108"

This is a multi-part message in MIME format.
--------------040709090804090109040108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[Appendix to the xntimer cleanup series.]

Having to take care for infinite delays in xntimer_start (i.e. to NOT
start the timer...) is a bit suboptimal given that his service might be
used heavily to restart timers. This patch converts the only user
(xnpod_start_timer again) and cleans up the timer code.

Jan

--------------040709090804090109040108
Content-Type: text/x-patch;
 name="xntimer-no-inf-timeout.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xntimer-no-inf-timeout.patch"

---
 ksrc/nucleus/pod.c   |   10 ++++++----
 ksrc/nucleus/timer.c |   34 ++++++++++++----------------------
 2 files changed, 18 insertions(+), 26 deletions(-)

Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -3095,10 +3095,12 @@ int xnpod_start_timer(u_long nstick, xni
=20
 	xntimer_set_sched(&nkpod->htimer, xnpod_sched_slot(XNTIMER_KEEPER_ID));=

=20
-	xnlock_get_irqsave(&nklock, s);
-	xntimer_start(&nkpod->htimer, delta,
-		      XNARCH_HOST_TICK / nkpod->tickvalue);
-	xnlock_put_irqrestore(&nklock, s);
+	if (delta) {
+		xnlock_get_irqsave(&nklock, s);
+		xntimer_start(&nkpod->htimer, delta,
+			      XNARCH_HOST_TICK / nkpod->tickvalue);
+		xnlock_put_irqrestore(&nklock, s);
+	}
=20
 	return 0;
 }
Index: xenomai/ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timer.c
+++ xenomai/ksrc/nucleus/timer.c
@@ -99,20 +99,15 @@ static void xntimer_do_start_aperiodic(x
 	if (!testbits(timer->status, XNTIMER_DEQUEUED))
 		xntimer_dequeue_aperiodic(timer);
=20
-	if (value !=3D XN_INFINITE) {
-		xntimerh_date(&timer->aplink) =3D
-		    xnarch_get_cpu_tsc() + xnarch_ns_to_tsc(value);
-		timer->interval =3D xnarch_ns_to_tsc(interval);
-		xntimer_enqueue_aperiodic(timer);
-		if (xntimer_heading_p(timer)) {
-			if (xntimer_sched(timer) !=3D xnpod_current_sched())
-				xntimer_next_remote_shot(xntimer_sched(timer));
-			else
-				xntimer_next_local_shot(xntimer_sched(timer));
-		}
-	} else {
-		xntimerh_date(&timer->aplink) =3D XN_INFINITE;
-		timer->interval =3D XN_INFINITE;
+	xntimerh_date(&timer->aplink) =3D
+	    xnarch_get_cpu_tsc() + xnarch_ns_to_tsc(value);
+	timer->interval =3D xnarch_ns_to_tsc(interval);
+	xntimer_enqueue_aperiodic(timer);
+	if (xntimer_heading_p(timer)) {
+		if (xntimer_sched(timer) !=3D xnpod_current_sched())
+			xntimer_next_remote_shot(xntimer_sched(timer));
+		else
+			xntimer_next_local_shot(xntimer_sched(timer));
 	}
 }
=20
@@ -298,14 +293,9 @@ static void xntimer_do_start_periodic(xn
 	if (!testbits(timer->status, XNTIMER_DEQUEUED))
 		xntimer_dequeue_periodic(timer);
=20
-	if (value !=3D XN_INFINITE) {
-		xntlholder_date(&timer->plink) =3D nkpod->jiffies + value;
-		timer->interval =3D interval;
-		xntimer_enqueue_periodic(timer);
-	} else {
-		xntlholder_date(&timer->plink) =3D XN_INFINITE;
-		timer->interval =3D XN_INFINITE;
-	}
+	xntlholder_date(&timer->plink) =3D nkpod->jiffies + value;
+	timer->interval =3D interval;
+	xntimer_enqueue_periodic(timer);
 }
=20
 static void xntimer_do_stop_periodic(xntimer_t *timer)

--------------040709090804090109040108--

--------------enig24F777F4B46036B0536547E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEvdcPniDOoMHTA+kRAsPNAKCFHLynCS33Sy0ezXhmPVWG1rkMTwCfVv05
jwA+5Dkunyy4XOz+ihJwYL4=
=bHTX
-----END PGP SIGNATURE-----

--------------enig24F777F4B46036B0536547E3--

