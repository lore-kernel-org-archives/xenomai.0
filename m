Message-ID: <44D19F14.90501@domain.hid>
Date: Thu, 03 Aug 2006 09:00:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigECCDD06510BD431E6E482B87"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 3/4] control periodic timers via handler
	return code
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
--------------enigECCDD06510BD431E6E482B87
Content-Type: multipart/mixed; boundary="------------090604020504010806020705"

This is a multi-part message in MIME format.
--------------090604020504010806020705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Here comes another step to move xntimers closer to the hrtimer API of
the latest kernels. A hrtimer handler controls via its return value if
the timer should be restarted or not. This patch introduce a return
value to xntimer handlers as well: XNTIMER_DONE for leaving the timer
alone and XNTIMER_FORWARD for restarting a periodic timer after
forwarding its expiry date.

This is kind of keyhole surgery to xntimer while opening the possibility
for an RTDM timer wrapper to provide

#define RTDM_TIMER_RET_DONE(timer)	return XNTIMER_DONE
#define RTDM_TIMER_RET_FORWARD(timer)   return XNTIMER_FORWARD

The latter can then be replaced with something that both explicitly
forwards and returns HRTIMER_RESTART over a -rt wrapper (sorry for not
also providing a RTDM timer patch here, but that one is in unusable
shape ATM). And this wrapping could be extended to other skins one day.

The net effect on code and efficiency of xntimer hotpaths should be at
least negligible, if not even positive (see tick handler modifications).

Jan

--------------090604020504010806020705
Content-Type: text/x-patch;
 name="xntimer-handler-ret.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xntimer-handler-ret.patch"

---
 include/nucleus/timer.h           |    7 +++++--
 ksrc/drivers/testing/timerbench.c |   11 ++++++-----
 ksrc/nucleus/thread.c             |    9 +++++++--
 ksrc/nucleus/timer.c              |   35 +++++++++++++++++++++++++++----=
----
 ksrc/skins/native/alarm.c         |    6 +++++-
 ksrc/skins/posix/timer.c          |    5 ++++-
 ksrc/skins/psos+/tm.c             |    4 +++-
 ksrc/skins/vxworks/wdLib.c        |    4 +++-
 8 files changed, 60 insertions(+), 21 deletions(-)

Index: xenomai/include/nucleus/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/timer.h
+++ xenomai/include/nucleus/timer.h
@@ -55,6 +55,9 @@
=20
 #define XNTIMER_KEEPER_ID 0
=20
+#define XNTIMER_DONE    0
+#define XNTIMER_FORWARD 1
+
 typedef struct {
     xnholder_t link;
     xnticks_t key;
@@ -231,7 +234,7 @@ typedef struct xntimer {
     struct xnsched *sched;      /* !< Sched structure to which the timer=
 is
                                    attached. */
=20
-    void (*handler)(struct xntimer *timer); /* !< Timeout handler. */
+    int (*handler)(struct xntimer *timer); /* !< Timeout handler. */
=20
     XNARCH_DECL_DISPLAY_CONTEXT();
=20
@@ -292,7 +295,7 @@ extern "C" {
 extern xntmops_t *nktimer;
=20
 void xntimer_init(xntimer_t *timer,
-		  void (*handler)(xntimer_t *timer));
+		  int (*handler)(xntimer_t *timer));
=20
 void xntimer_destroy(xntimer_t *timer);
=20
Index: xenomai/ksrc/drivers/testing/timerbench.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/drivers/testing/timerbench.c
+++ xenomai/ksrc/drivers/testing/timerbench.c
@@ -165,7 +165,7 @@ void timer_task_proc(void *arg)
 }
=20
=20
-void timer_proc(xntimer_t *timer)
+int timer_proc(xntimer_t *timer)
 {
     struct rt_tmbench_context   *ctx =3D
         container_of(timer, struct rt_tmbench_context, timer);
@@ -178,11 +178,12 @@ void timer_proc(xntimer_t *timer)
     xntimer_start(&ctx->timer, xnpod_ns2ticks(ctx->date),
                   XN_INFINITE, XNTIMER_ABSOLUTE);
=20
-    if (++ctx->curr.test_loops < ctx->samples_per_sec)
-        return;
+    if (++ctx->curr.test_loops >=3D ctx->samples_per_sec) {
+        ctx->curr.test_loops =3D 0;
+        eval_outer_loop(ctx);
+    }
=20
-    ctx->curr.test_loops =3D 0;
-    eval_outer_loop(ctx);
+    return XNTIMER_DONE;
 }
=20
=20
Index: xenomai/ksrc/nucleus/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/thread.c
+++ xenomai/ksrc/nucleus/thread.c
@@ -24,19 +24,24 @@
 #include <nucleus/module.h>
 #include <asm/xenomai/bits/thread.h>
=20
-static void xnthread_timeout_handler(xntimer_t *timer)
+static int xnthread_timeout_handler(xntimer_t *timer)
 {
 	xnthread_t *thread =3D container_of(timer, xnthread_t, rtimer);
+
 	__setbits(thread->status, XNTIMEO);	/* Interrupts are off. */
 	xnpod_resume_thread(thread, XNDELAY);
+
+	return XNTIMER_DONE;
 }
=20
-static void xnthread_periodic_handler(xntimer_t *timer)
+static int xnthread_periodic_handler(xntimer_t *timer)
 {
 	xnthread_t *thread =3D container_of(timer, xnthread_t, ptimer);
=20
 	if (xnthread_test_flags(thread, XNDELAY))	/* Prevent unwanted round-rob=
in. */
 		xnpod_resume_thread(thread, XNDELAY);
+
+	return XNTIMER_FORWARD;
 }
=20
 int xnthread_init(xnthread_t *thread,
Index: xenomai/ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timer.c
+++ xenomai/ksrc/nucleus/timer.c
@@ -214,18 +214,27 @@ static void xntimer_do_tick_aperiodic(vo
=20
 		if (timer !=3D &nkpod->htimer) {
 			if (!testbits(nkpod->status, XNTLOCK)) {
-				timer->handler(timer);
+				if (timer->handler(timer) =3D=3D XNTIMER_DONE)
+					continue;
=20
+#if defined(CONFIG_XENO_OPT_DEBUG) || defined(__XENO_SIM__)
 				if (timer->interval =3D=3D XN_INFINITE ||
 				    !testbits(timer->status, XNTIMER_DEQUEUED)
-				    || testbits(timer->status, XNTIMER_KILLED))
+				    || testbits(timer->status, XNTIMER_KILLED)) {
 					/* The elapsed timer has no reload value, or has
 					   been re-enqueued likely as a result of a call
 					   to xntimer_start() from the timeout handler, or
 					   has been killed by the handler. In all cases,
-					   don't attempt to re-enqueue it for the next
-					   shot. */
+					   returning XNTIMER_FORWARD is wrong. */
+					xnlogerr("illegal timer restart detected -- "
+						 "status=3D%08lx, interval=3D%lld\n",
+						 timer->status, timer->interval);
+#ifdef __KERNEL__
+					show_stack(NULL, NULL);
+#endif
 					continue;
+				}
+#endif /* CONFIG_XENO_OPT_DEBUG || __XENO_SIM__ */
 			} else if (timer->interval =3D=3D XN_INFINITE) {
 				xntimerh_date(&timer->aplink) +=3D
 				    nkpod->htimer.interval;
@@ -392,12 +401,22 @@ static void xntimer_do_tick_periodic(voi
=20
 		if (timer !=3D &nkpod->htimer) {
 			if (!testbits(nkpod->status, XNTLOCK)) {
-				timer->handler(timer);
+				if (timer->handler(timer) =3D=3D XNTIMER_DONE)
+					continue;
=20
+#if defined(CONFIG_XENO_OPT_DEBUG) || defined(__XENO_SIM__)
 				if (timer->interval =3D=3D XN_INFINITE ||
 				    !testbits(timer->status, XNTIMER_DEQUEUED)
-				    || testbits(timer->status, XNTIMER_KILLED))
+				    || testbits(timer->status, XNTIMER_KILLED)) {
+					xnlogerr("illegal timer restart detected -- "
+						 "status=3D%08lx, interval=3D%lld\n",
+						 timer->status, timer->interval);
+#ifdef __KERNEL__
+					show_stack(NULL, NULL);
+#endif
 					continue;
+				}
+#endif /* CONFIG_XENO_OPT_DEBUG || __XENO_SIM__ */
 			} else if (timer->interval =3D=3D XN_INFINITE) {
 				xntlholder_date(&timer->plink) =3D
 				    nkpod->jiffies + nkpod->htimer.interval;
@@ -465,7 +484,7 @@ void xntimer_set_periodic_mode(void)
 #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
=20
 /*!=20
- * \fn void xntimer_init(xntimer_t *timer,void (*handler)(xntimer_t *tim=
er))
+ * \fn void xntimer_init(xntimer_t *timer, int (*handler)(xntimer_t *tim=
er))
  * \brief Initialize a timer object.
  *
  * Creates a timer. When created, a timer is left disarmed; it must be
@@ -493,7 +512,7 @@ void xntimer_set_periodic_mode(void)
  * Rescheduling: never.
  */
=20
-void xntimer_init(xntimer_t *timer, void (*handler) (xntimer_t *timer))
+void xntimer_init(xntimer_t *timer, int (*handler) (xntimer_t *timer))
 {
 	/* CAUTION: Setup from xntimer_init() must not depend on the
 	   periodic/aperiodic timing mode. */
Index: xenomai/ksrc/skins/native/alarm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/alarm.c
+++ xenomai/ksrc/skins/native/alarm.c
@@ -117,11 +117,15 @@ void __native_alarm_pkg_cleanup(void)
 {
 }
=20
-static void __alarm_trampoline(xntimer_t *timer)
+static int __alarm_trampoline(xntimer_t *timer)
 {
 	RT_ALARM *alarm =3D container_of(timer, RT_ALARM, timer_base);
+
 	++alarm->expiries;
 	alarm->handler(alarm, alarm->cookie);
+
+	return xntimer_running_p(&alarm->timer_base) ?
+	    XNTIMER_FORWARD : XNTIMER_DONE;
 }
=20
 /**
Index: xenomai/ksrc/skins/posix/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/timer.c
+++ xenomai/ksrc/skins/posix/timer.c
@@ -52,7 +52,7 @@ static xnqueue_t timer_freeq;
=20
 static struct pse51_timer timer_pool[PSE51_TIMER_MAX];
=20
-static void pse51_base_timer_handler(xntimer_t *xntimer)
+static int pse51_base_timer_handler(xntimer_t *xntimer)
 {
 	struct pse51_timer *timer =3D
 		container_of(xntimer, struct pse51_timer, timerbase);
@@ -65,6 +65,9 @@ static void pse51_base_timer_handler(xnt
 		timer->overruns =3D 0;
 		pse51_sigqueue_inner(timer->owner, &timer->si);
 	}
+
+	return (xntimer_interval(&timer->timerbase) =3D=3D XN_INFINITE) ?
+	    XNTIMER_DONE : XNTIMER_FORWARD;
 }
=20
 /* Must be called with nklock locked, irq off. */
Index: xenomai/ksrc/skins/psos+/tm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/psos+/tm.c
+++ xenomai/ksrc/skins/psos+/tm.c
@@ -57,7 +57,7 @@ void tm_destroy_internal(psostm_t *tm)
 	xnfree(tm);
 }
=20
-static void tm_evpost_handler(xntimer_t *timer)
+static int tm_evpost_handler(xntimer_t *timer)
 {
 	psostm_t *tm =3D container_of(timer, psostm_t, timerbase);
=20
@@ -65,6 +65,8 @@ static void tm_evpost_handler(xntimer_t=20
=20
 	if (xntimer_interval(&tm->timerbase) =3D=3D XN_INFINITE)
 		tm_destroy_internal(tm);
+
+	return XNTIMER_DONE;
 }
=20
 static u_long tm_start_event_timer(u_long ticks,
Index: xenomai/ksrc/skins/vxworks/wdLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vxworks/wdLib.c
+++ xenomai/ksrc/skins/vxworks/wdLib.c
@@ -90,11 +90,13 @@ static xnpnode_t wd_pnode =3D {
=20
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
=20
-static void wind_wd_trampoline(xntimer_t *timer)
+static int wind_wd_trampoline(xntimer_t *timer)
 {
 	wind_wd_t *wd =3D container_of(timer, wind_wd_t, timerbase);
=20
 	wd->handler(wd->arg);
+
+	return XNTIMER_DONE;
 }
=20
 void wind_wd_init(void)

--------------090604020504010806020705--

--------------enigECCDD06510BD431E6E482B87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE0Z8VniDOoMHTA+kRAhaBAJ9plJ+fanUjvhjRD27ZUJhkWAxfywCffOet
qVGLhtKDwyaHcorsHpxZ95g=
=Jg5U
-----END PGP SIGNATURE-----

--------------enigECCDD06510BD431E6E482B87--

