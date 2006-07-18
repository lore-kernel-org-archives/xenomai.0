Message-ID: <44BD735B.2030502@domain.hid>
Date: Wed, 19 Jul 2006 01:48:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3F981244CE01AAB59C7C76A3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/2] simplify xntimer_start
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
--------------enig3F981244CE01AAB59C7C76A3
Content-Type: multipart/mixed; boundary="------------000904070308070208080005"

This is a multi-part message in MIME format.
--------------000904070308070208080005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Almost all callers of xntimer_start already run in nklock-protected
context. Therefore, we can save the lock reacquisition in that function
and turn it even into a trivial inliner. This patch also takes care of
the two exceptions of the rule above in xnpod_start_timer and psos+'s
tm_start_event_timer.

Jan

--------------000904070308070208080005
Content-Type: text/x-patch;
 name="xntimer-start-no-lock.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xntimer-start-no-lock.patch"

---
 include/nucleus/timer.h |   51 +++++++++++++++++++++++++++++++++++++++++=
++++---
 ksrc/nucleus/pod.c      |    2 +
 ksrc/nucleus/timer.c    |   49 -----------------------------------------=
-----
 ksrc/skins/psos+/tm.c   |    4 ++-
 4 files changed, 53 insertions(+), 53 deletions(-)

Index: include/nucleus/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/timer.h.orig
+++ include/nucleus/timer.h
@@ -290,9 +290,52 @@ void xntimer_init(xntimer_t *timer,
=20
 void xntimer_destroy(xntimer_t *timer);
=20
-void xntimer_start(xntimer_t *timer,
-		   xnticks_t value,
-		   xnticks_t interval);
+/*!
+ * \fn void xntimer_start(xntimer_t *timer,xnticks_t value,xnticks_t int=
erval)
+ * \brief Arm a timer.
+ *
+ * Activates a timer so that the associated timeout handler will be
+ * fired after each expiration time. A timer can be either periodic or
+ * single-shot, depending on the reload value passed to this
+ * routine. The given timer must have been previously initialized by a
+ * call to xntimer_init().
+ *
+ * @param timer The address of a valid timer descriptor.
+ *
+ * @param value The relative date of the initial timer shot, expressed
+ * in clock ticks (see note).
+ *
+ * @param interval The reload value of the timer. It is a periodic
+ * interval value to be used for reprogramming the next timer shot,
+ * expressed in clock ticks (see note). If @a interval is equal to
+ * XN_INFINITE, the timer will not be reloaded after it has expired.
+ *
+ * @return 0 is always returned.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Interrupt service routine
+ * - Kernel-based task
+ * - User-space task
+ *
+ * Rescheduling: never.
+ *
+ * @note This service is sensitive to the current operation mode of
+ * the system timer, as defined by the xnpod_start_timer() service. In
+ * periodic mode, clock ticks are interpreted as periodic jiffies. In
+ * oneshot mode, clock ticks are interpreted as nanoseconds.
+ *
+ * @note Must be called with nklock held, IRQs off.
+ */
+
+static inline void xntimer_start(xntimer_t *timer,
+                                 xnticks_t value, xnticks_t interval)
+{
+    nktimer->do_timer_start(timer, value, interval);
+}
=20
 /*!
  * \fn int xntimer_stop(xntimer_t *timer)
@@ -315,6 +358,8 @@ void xntimer_start(xntimer_t *timer,
  * - User-space task
  *
  * Rescheduling: never.
+ *
+ * @note Must be called with nklock held, IRQs off.
  */
=20
 static inline void xntimer_stop(xntimer_t *timer)
Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c.orig
+++ ksrc/nucleus/pod.c
@@ -3095,8 +3095,10 @@ int xnpod_start_timer(u_long nstick, xni
=20
 	xntimer_set_sched(&nkpod->htimer, xnpod_sched_slot(XNTIMER_KEEPER_ID));=

=20
+	xnlock_get_irqsave(&nklock, s);
 	xntimer_start(&nkpod->htimer, delta,
 		      XNARCH_HOST_TICK / nkpod->tickvalue);
+	xnlock_put_irqrestore(&nklock, s);
=20
 	return 0;
 }
Index: ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/timer.c.orig
+++ ksrc/nucleus/timer.c
@@ -539,54 +539,6 @@ void xntimer_destroy(xntimer_t *timer)
 	timer->sched =3D NULL;
 }
=20
-/*!=20
- * \fn void xntimer_start(xntimer_t *timer,xnticks_t value,xnticks_t int=
erval)
- * \brief Arm a timer.
- *
- * Activates a timer so that the associated timeout handler will be
- * fired after each expiration time. A timer can be either periodic or
- * single-shot, depending on the reload value passed to this
- * routine. The given timer must have been previously initialized by a
- * call to xntimer_init().
- *
- * @param timer The address of a valid timer descriptor.
- *
- * @param value The relative date of the initial timer shot, expressed
- * in clock ticks (see note).
- *
- * @param interval The reload value of the timer. It is a periodic
- * interval value to be used for reprogramming the next timer shot,
- * expressed in clock ticks (see note). If @a interval is equal to
- * XN_INFINITE, the timer will not be reloaded after it has expired.
- *
- * @return 0 is always returned.
- *
- * Environments:
- *
- * This service can be called from:
- *
- * - Kernel module initialization/cleanup code
- * - Interrupt service routine
- * - Kernel-based task
- * - User-space task
- *
- * Rescheduling: never.
- *
- * @note This service is sensitive to the current operation mode of
- * the system timer, as defined by the xnpod_start_timer() service. In
- * periodic mode, clock ticks are interpreted as periodic jiffies. In
- * oneshot mode, clock ticks are interpreted as nanoseconds.
- */
-
-void xntimer_start(xntimer_t *timer, xnticks_t value, xnticks_t interval=
)
-{
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
-	nktimer->do_timer_start(timer, value, interval);
-	xnlock_put_irqrestore(&nklock, s);
-}
-
 #if defined(CONFIG_SMP)
 /**
  * Migrate a timer.
@@ -776,7 +728,6 @@ xntmops_t *nktimer =3D &timer_ops_aperiodi
=20
 EXPORT_SYMBOL(xntimer_init);
 EXPORT_SYMBOL(xntimer_destroy);
-EXPORT_SYMBOL(xntimer_start);
 #if defined(CONFIG_SMP)
 EXPORT_SYMBOL(xntimer_set_sched);
 #endif /* CONFIG_SMP */
Index: ksrc/skins/psos+/tm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/psos+/tm.c.orig
+++ ksrc/skins/psos+/tm.c
@@ -87,12 +87,14 @@ static u_long tm_start_event_timer(u_lon
 	tm->magic =3D PSOS_TM_MAGIC;
=20
 	xnlock_get_irqsave(&nklock, s);
+
 	appendq(&psostimerq, &tm->link);
 	appendgq(&tm->owner->alarmq, tm);
-	xnlock_put_irqrestore(&nklock, s);
=20
 	xntimer_start(&tm->timerbase, ticks, interval);
=20
+	xnlock_put_irqrestore(&nklock, s);
+
 	return SUCCESS;
 }
=20

--------------000904070308070208080005--

--------------enig3F981244CE01AAB59C7C76A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEvXNbniDOoMHTA+kRAkJFAJsEdMUPrcjFnyfw0eDL3Z6UFYYY2gCfXxda
XUvyPl4WkPijHUMpl3q4TYg=
=avCO
-----END PGP SIGNATURE-----

--------------enig3F981244CE01AAB59C7C76A3--

