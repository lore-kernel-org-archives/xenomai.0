Message-ID: <44D19DFD.80305@domain.hid>
Date: Thu, 03 Aug 2006 08:55:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4565CAC326FF682F3026B24E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 1/4] introduce absolute xntimer_start
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
--------------enig4565CAC326FF682F3026B24E
Content-Type: multipart/mixed; boundary="------------040405030004040605050503"

This is a multi-part message in MIME format.
--------------040405030004040605050503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch introduces an additional parameter to xntimer_start for
specifying if the passed timeout value is relative (like now always) or
absolute. The idea is to simplify the setup of absolute timeouts which
have to be converted into relative ones so far.

All direct callers of xntimer_start are updated as well as the docs.

Jan

--------------040405030004040605050503
Content-Type: text/x-patch;
 name="xntimer-absolute-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xntimer-absolute-v2.patch"

---
 include/nucleus/timer.h              |   25 +++++++++++++++++++------
 ksrc/drivers/testing/timerbench.c    |    9 ++++-----
 ksrc/nucleus/pod.c                   |   12 ++++++++----
 ksrc/nucleus/timer.c                 |   25 ++++++++++++++++++++-----
 ksrc/skins/native/alarm.c            |    2 +-
 ksrc/skins/posix/timer.c             |    3 ++-
 ksrc/skins/psos+/tm.c                |    2 +-
 ksrc/skins/vxworks/wdLib.c           |    2 +-
 sim/skins/posix/testsuite/xntest.c   |    2 +-
 sim/skins/vxworks/testsuite/xntest.c |    2 +-
 10 files changed, 58 insertions(+), 26 deletions(-)

Index: xenomai/include/nucleus/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/timer.h
+++ xenomai/include/nucleus/timer.h
@@ -31,9 +31,14 @@
 #define XNTIMER_WHEELMASK (XNTIMER_WHEELSIZE - 1)
 #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC || CONFIG_XENO_OPT_TIMER_WHEEL=
 */
=20
+/* Timer status */
 #define XNTIMER_DEQUEUED  0x00000001
 #define XNTIMER_KILLED    0x00000002
=20
+/* Timer mode */
+#define XNTIMER_RELATIVE  0
+#define XNTIMER_ABSOLUTE  1
+
 /* These flags are available to the real-time interfaces */
 #define XNTIMER_SPARE0  0x01000000
 #define XNTIMER_SPARE1  0x02000000
@@ -268,7 +273,8 @@ typedef struct xntmops {
     xnticks_t (*get_raw_clock)(void);
     void (*do_timer_start)(xntimer_t *timer,
 			   xnticks_t value,
-			   xnticks_t interval);
+			   xnticks_t interval,
+			   int mode);
     void (*do_timer_stop)(xntimer_t *timer);
     xnticks_t (*get_timer_date)(xntimer_t *timer);
     xnticks_t (*get_timer_timeout)(xntimer_t *timer);
@@ -291,7 +297,8 @@ void xntimer_init(xntimer_t *timer,
 void xntimer_destroy(xntimer_t *timer);
=20
 /*!
- * \fn void xntimer_start(xntimer_t *timer,xnticks_t value,xnticks_t int=
erval)
+ * \fn void xntimer_start(xntimer_t *timer,xnticks_t value,xnticks_t int=
erval,
+ *                        int mode)
  * \brief Arm a timer.
  *
  * Activates a timer so that the associated timeout handler will be
@@ -302,14 +309,19 @@ void xntimer_destroy(xntimer_t *timer);
  *
  * @param timer The address of a valid timer descriptor.
  *
- * @param value The relative date of the initial timer shot, expressed
- * in clock ticks (see note).
+ * @param value The date of the initial timer shot, expressed in clock t=
icks
+ * (see note).
  *
  * @param interval The reload value of the timer. It is a periodic
  * interval value to be used for reprogramming the next timer shot,
  * expressed in clock ticks (see note). If @a interval is equal to
  * XN_INFINITE, the timer will not be reloaded after it has expired.
  *
+ * @param mode The timer mode. It can be either XNTIMER_RELATIVE or
+ * XNTIMER_ABSOLUTE to define if @a value shall be interpreted as a rela=
tive
+ * or absolute date. Absolute dates are based on the nucleus time return=
ed by
+ * xnpod_get_time().
+ *
  * @return 0 is always returned.
  *
  * Environments:
@@ -332,9 +344,10 @@ void xntimer_destroy(xntimer_t *timer);
  */
=20
 static inline void xntimer_start(xntimer_t *timer,
-                                 xnticks_t value, xnticks_t interval)
+                                 xnticks_t value, xnticks_t interval,
+                                 int mode)
 {
-    nktimer->do_timer_start(timer, value, interval);
+    nktimer->do_timer_start(timer, value, interval, mode);
 }
=20
 /*!
Index: xenomai/ksrc/drivers/testing/timerbench.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/drivers/testing/timerbench.c
+++ xenomai/ksrc/drivers/testing/timerbench.c
@@ -175,8 +175,8 @@ void timer_proc(xntimer_t *timer)
=20
     ctx->start_time =3D rtdm_clock_read();
     /* FIXME: convert to RTDM timers */
-    xntimer_start(&ctx->timer, xnpod_ns2ticks(ctx->date-ctx->start_time)=
,
-                  XN_INFINITE);
+    xntimer_start(&ctx->timer, xnpod_ns2ticks(ctx->date),
+                  XN_INFINITE, XNTIMER_ABSOLUTE);
=20
     if (++ctx->curr.test_loops < ctx->samples_per_sec)
         return;
@@ -320,9 +320,8 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
                         ctx->date       =3D ctx->start_time + ctx->perio=
d;
=20
                         /* FIXME: convert to RTDM timers */
-                        xntimer_start(&ctx->timer,
-                                xnpod_ns2ticks(ctx->date-rtdm_clock_read=
()),
-                                XN_INFINITE);
+                        xntimer_start(&ctx->timer, xnpod_ns2ticks(ctx->d=
ate),
+                                      XN_INFINITE, XNTIMER_ABSOLUTE);
                     );
                 }
             }
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -1429,7 +1429,8 @@ void xnpod_suspend_thread(xnthread_t *th
 		   a call to xnpod_suspend_thread(thread,XNDELAY,0,NULL). */
 		__setbits(thread->status, XNDELAY);
 		xntimer_set_sched(&thread->rtimer, thread->sched);
-		xntimer_start(&thread->rtimer, timeout, XN_INFINITE);
+		xntimer_start(&thread->rtimer, timeout, XN_INFINITE,
+			      XNTIMER_RELATIVE);
 	}
 #ifdef __XENO_SIM__
 	if (nkpod->schedhook)
@@ -3101,7 +3102,8 @@ int xnpod_start_timer(u_long nstick, xni
 	if (XNARCH_HOST_TICK) {
 		xnlock_get_irqsave(&nklock, s);
 		xntimer_start(&nkpod->htimer, delta,
-			      XNARCH_HOST_TICK / nkpod->tickvalue);
+			      XNARCH_HOST_TICK / nkpod->tickvalue,
+			      XNTIMER_RELATIVE);
 		xnlock_put_irqrestore(&nklock, s);
 	}
=20
@@ -3390,14 +3392,16 @@ int xnpod_set_thread_periodic(xnthread_t
 	xntimer_set_sched(&thread->ptimer, thread->sched);
=20
 	if (idate =3D=3D XN_INFINITE) {
-		xntimer_start(&thread->ptimer, period, period);
+		xntimer_start(&thread->ptimer, period, period,
+			      XNTIMER_RELATIVE);
 		thread->pexpect =3D xntimer_get_raw_expiry(&thread->ptimer)
 		    + xntimer_interval(&thread->ptimer);
 	} else {
 		now =3D xnpod_get_time();
=20
 		if (idate > now) {
-			xntimer_start(&thread->ptimer, idate - now, period);
+			xntimer_start(&thread->ptimer, idate, period,
+				      XNTIMER_ABSOLUTE);
 			thread->pexpect =3D
 			    xntimer_get_raw_expiry(&thread->ptimer)
 			    + xntimer_interval(&thread->ptimer);
Index: xenomai/ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timer.c
+++ xenomai/ksrc/nucleus/timer.c
@@ -93,14 +93,22 @@ static inline void xntimer_next_remote_s
 }
=20
 static void xntimer_do_start_aperiodic(xntimer_t *timer,
-				       xnticks_t value, xnticks_t interval)
+				       xnticks_t value, xnticks_t interval,
+				       int mode)
 {
+	xnticks_t date;
+
 	if (!testbits(timer->status, XNTIMER_DEQUEUED))
 		xntimer_dequeue_aperiodic(timer);
=20
-	xntimerh_date(&timer->aplink) =3D
-	    xnarch_get_cpu_tsc() + xnarch_ns_to_tsc(value);
+	if (mode =3D=3D XNTIMER_RELATIVE)
+		date =3D xnarch_ns_to_tsc(value) + xnarch_get_cpu_tsc();
+	else
+		date =3D xnarch_ns_to_tsc(value - nkpod->wallclock_offset);
+
+	xntimerh_date(&timer->aplink) =3D date;
 	timer->interval =3D xnarch_ns_to_tsc(interval);
+
 	xntimer_enqueue_aperiodic(timer);
 	if (xntimer_heading_p(timer)) {
 		if (xntimer_sched(timer) !=3D xnpod_current_sched())
@@ -287,13 +295,20 @@ static inline void xntimer_dequeue_perio
 }
=20
 static void xntimer_do_start_periodic(xntimer_t *timer,
-				      xnticks_t value, xnticks_t interval)
+				      xnticks_t value, xnticks_t interval,
+				      int mode)
 {
 	if (!testbits(timer->status, XNTIMER_DEQUEUED))
 		xntimer_dequeue_periodic(timer);
=20
-	xntlholder_date(&timer->plink) =3D nkpod->jiffies + value;
+	if (mode =3D=3D XNTIMER_RELATIVE)
+		value +=3D nkpod->jiffies;
+	else
+		value -=3D nkpod->wallclock_offset;
+
+	xntlholder_date(&timer->plink) =3D value;
 	timer->interval =3D interval;
+
 	xntimer_enqueue_periodic(timer);
 }
=20
Index: xenomai/ksrc/skins/native/alarm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/alarm.c
+++ xenomai/ksrc/skins/native/alarm.c
@@ -360,7 +360,7 @@ int rt_alarm_start(RT_ALARM *alarm, RTIM
 		goto unlock_and_exit;
 	}
=20
-	xntimer_start(&alarm->timer_base, value, interval);
+	xntimer_start(&alarm->timer_base, value, interval, XNTIMER_RELATIVE);
=20
       unlock_and_exit:
=20
Index: xenomai/ksrc/skins/posix/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/timer.c
+++ xenomai/ksrc/skins/posix/timer.c
@@ -372,7 +372,8 @@ int timer_settime(timer_t timerid,
 				start =3D 1;
=20
 		xntimer_start(&timer->timerbase,
-			      start, ts2ticks_ceil(&value->it_interval));
+			      start, ts2ticks_ceil(&value->it_interval),
+			      XNTIMER_RELATIVE);
 		timer->owner =3D cur;
 		inith(&timer->tlink);
 		appendq(&timer->owner->timersq, &timer->tlink);
Index: xenomai/ksrc/skins/psos+/tm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/psos+/tm.c
+++ xenomai/ksrc/skins/psos+/tm.c
@@ -91,7 +91,7 @@ static u_long tm_start_event_timer(u_lon
 	appendq(&psostimerq, &tm->link);
 	appendgq(&tm->owner->alarmq, tm);
=20
-	xntimer_start(&tm->timerbase, ticks, interval);
+	xntimer_start(&tm->timerbase, ticks, interval, XNTIMER_RELATIVE);
=20
 	xnlock_put_irqrestore(&nklock, s);
=20
Index: xenomai/ksrc/skins/vxworks/wdLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vxworks/wdLib.c
+++ xenomai/ksrc/skins/vxworks/wdLib.c
@@ -183,7 +183,7 @@ STATUS wdStart(WDOG_ID wdog_id, int time
 	wd->handler =3D handler;
 	wd->arg =3D arg;
=20
-	xntimer_start(&wd->timerbase, timeout, XN_INFINITE);
+	xntimer_start(&wd->timerbase, timeout, XN_INFINITE, XNTIMER_RELATIVE);
=20
 	xnlock_put_irqrestore(&nklock, s);
 	return OK;
Index: xenomai/sim/skins/posix/testsuite/xntest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/sim/skins/posix/testsuite/xntest.c
+++ xenomai/sim/skins/posix/testsuite/xntest.c
@@ -79,7 +79,7 @@ void xntest_start(void)
=20
     xnlock_get_irqsave(&test_lock, s);
     xntimer_init(&watchdog, interrupt_test);
-    xntimer_start(&watchdog, xnpod_ns2ticks(test_timeout * 1000000000ULL=
), XN_INFINITE);
+    xntimer_start(&watchdog, xnpod_ns2ticks(test_timeout * 1000000000ULL=
), XN_INFINITE, XNTIMER_RELATIVE);
=20
     initq(&marks_q);
     tests=3D0;
Index: xenomai/sim/skins/vxworks/testsuite/xntest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/sim/skins/vxworks/testsuite/xntest.c
+++ xenomai/sim/skins/vxworks/testsuite/xntest.c
@@ -79,7 +79,7 @@ void xntest_start(void)
=20
     xnlock_get_irqsave(&test_lock, s);
     xntimer_init(&watchdog, interrupt_test);
-    xntimer_start(&watchdog, xnpod_ns2ticks(test_timeout * 1000000000ULL=
), XN_INFINITE);
+    xntimer_start(&watchdog, xnpod_ns2ticks(test_timeout * 1000000000ULL=
), XN_INFINITE, XNTIMER_RELATIVE);
=20
     initq(&marks_q);
     tests=3D0;

--------------040405030004040605050503--

--------------enig4565CAC326FF682F3026B24E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE0Z39niDOoMHTA+kRAsZwAJ9Jym8mKcqXsU3W//8IWHS99YJPVwCeJoW2
wyMVxwIdpFcxIwTZqGv/pZc=
=kB/8
-----END PGP SIGNATURE-----

--------------enig4565CAC326FF682F3026B24E--

