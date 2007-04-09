Message-ID: <461AB788.3080705@domain.hid>
Date: Tue, 10 Apr 2007 00:00:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD214466436C572602D599323"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 1/2] Reprogram timer once per tick
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
--------------enigD214466436C572602D599323
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is an optimisation patch, long pending in my repos, aiming at
making the aperiodic timer tick handling more predictable. It suppresses
any xntimer_next_local_shot() as long as the tick handler is running.
This avoids potential multiple (costly) timer reprogramming when timer
handlers make use of xntimer_start.

Jan


---
 include/nucleus/pod.h |    1 +
 ksrc/nucleus/timer.c  |   15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

Index: xenomai/include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/pod.h
+++ xenomai/include/nucleus/pod.h
@@ -46,6 +46,7 @@
 #define XNKCOUT  0x80000000	/* Sched callout context */
 #define XNHTICK  0x40000000	/* Host tick pending  */
 #define XNRPICK  0x20000000	/* Check RPI state */
+#define XNINTCK  0x10000000	/* In master tick handler context */
=20
 /* These flags are available to the real-time interfaces */
 #define XNPOD_SPARE0  0x01000000
Index: xenomai/ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timer.c
+++ xenomai/ksrc/nucleus/timer.c
@@ -54,14 +54,16 @@ static inline void xntimer_dequeue_aperi
 	__setbits(timer->status, XNTIMER_DEQUEUED);
 }
=20
-static inline void xntimer_next_local_shot(xnsched_t *this_sched)
+static void xntimer_next_local_shot(xnsched_t *this_sched)
 {
 	xntimerh_t *holder =3D xntimerq_head(&this_sched->timerqueue);
 	xnticks_t now, delay, xdate;
 	xntimer_t *timer;
=20
-	if (!holder)
-		return;		/* No pending timer. */
+	/* Do not reprogram locally when inside the tick handler - will be
+	   done on exit anyway. Also exit if there is no pending timer. */
+	if (testbits(this_sched->status, XNINTCK) || !holder)
+		return;
=20
 	timer =3D aplink2timer(holder);
=20
@@ -184,6 +186,11 @@ void xntimer_tick_aperiodic(void)
 	xntimer_t *timer;
 	xnticks_t now;
=20
+	/* Optimisation: any local timer reprogramming triggered by invoked
+	   timer handlers can wait until we leave the tick handler. Use this
+	   status flag as hint to xntimer_start_aperiodic. */
+	__setbits(sched->status, XNINTCK);
+
 	now =3D xnarch_get_cpu_tsc();
 	while ((holder =3D xntimerq_head(timerq)) !=3D NULL) {
 		timer =3D aplink2timer(holder);
@@ -237,6 +244,8 @@ void xntimer_tick_aperiodic(void)
 		xntimer_enqueue_aperiodic(timer);
 	}
=20
+	__clrbits(sched->status, XNINTCK);
+
 	xntimer_next_local_shot(sched);
 }
=20


--------------enigD214466436C572602D599323
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGGreIniDOoMHTA+kRAleTAJ9lmALWgPjVYu3njOAM1BkUJF8CZwCfQz/Z
GY1n7aCqY+pSDAZW/m2JiO8=
=w1vu
-----END PGP SIGNATURE-----

--------------enigD214466436C572602D599323--

