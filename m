Message-ID: <44D19F3D.9060700@domain.hid>
Date: Thu, 03 Aug 2006 09:01:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB2B215E9AEFFED7A4F0104E2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 4/4] shorten overrun loops of periodic
	timers
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
--------------enigB2B215E9AEFFED7A4F0104E2
Content-Type: multipart/mixed; boundary="------------090004030609040806020308"

This is a multi-part message in MIME format.
--------------090004030609040806020308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

A simple patch, just like suggested by Gilles, to avoid looping over
periodic xntimer handlers in case of overruns.

It saves the current TSC on loop entry and uses this value later when
forwarding the timer. Is is the overhead of re-reading the TSC on all
archs negligible and should we rather go that way?

Jan

--------------090004030609040806020308
Content-Type: text/x-patch;
 name="xntimer-handle-periodic-overrun.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="xntimer-handle-periodic-overrun.patch"

---
 ksrc/nucleus/timer.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: xenomai/ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timer.c
+++ xenomai/ksrc/nucleus/timer.c
@@ -200,12 +200,13 @@ static void xntimer_do_tick_aperiodic(vo
 	xntimerq_t *timerq =3D &sched->timerqueue;
 	xntimerh_t *holder;
 	xntimer_t *timer;
+	xnticks_t now;
=20
 	while ((holder =3D xntimerq_head(timerq)) !=3D NULL) {
 		timer =3D aplink2timer(holder);
=20
-		if (xntimerh_date(&timer->aplink) - nkschedlat >
-		    xnarch_get_cpu_tsc())
+		now =3D xnarch_get_cpu_tsc();
+		if (xntimerh_date(&timer->aplink) - nkschedlat > now)
 			/* No need to continue in aperiodic mode since timeout
 			   dates are ordered by increasing values. */
 			break;
@@ -236,8 +237,8 @@ static void xntimer_do_tick_aperiodic(vo
 				}
 #endif /* CONFIG_XENO_OPT_DEBUG || __XENO_SIM__ */
 			} else if (timer->interval =3D=3D XN_INFINITE) {
-				xntimerh_date(&timer->aplink) +=3D
-				    nkpod->htimer.interval;
+				while ((xntimerh_date(&timer->aplink) +=3D
+				        nkpod->htimer.interval) < now);
 				continue;
 			}
 		} else

--------------090004030609040806020308--

--------------enigB2B215E9AEFFED7A4F0104E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE0Z89niDOoMHTA+kRArY8AJ9jG7CxBJ5gcwwWA8VJLcYF6IoB9wCdGW1Q
yv0dpU/ogyVCFN2ezEGM54o=
=6Hqc
-----END PGP SIGNATURE-----

--------------enigB2B215E9AEFFED7A4F0104E2--

