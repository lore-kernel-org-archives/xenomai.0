Message-ID: <4617FDFB.3050108@domain.hid>
Date: Sat, 07 Apr 2007 22:24:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0E4ED20268E2C8024EBE16E1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] control periodic timer restart via handler
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
--------------enig0E4ED20268E2C8024EBE16E1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[rebase of https://mail.gna.org/public/xenomai-core/2006-08/msg00024.html=
]

The decision if a periodic timer should be restarted after completion of
its handler is currently based on three conditions: timer->interval !=3D
0, timer dequeued, and timer not killed.

This approach puts the decision in the hand of the timer handler via its
return code, also aligning xntimer a bit more with hrtimer. The idea is
both to optimise the timer irq handler a bit and to help us defining
some rtdm_timer abstraction that can be mapped also on native (-rt) Linux=
=2E

Warning: Beyond review, this patch version needs testing, I only compiled=

it so far.

Jan


---
 include/nucleus/timer.h           |   15 +++++++----
 ksrc/drivers/testing/timerbench.c |   11 ++++----
 ksrc/nucleus/pod.c                |   13 ++++------
 ksrc/nucleus/thread.c             |    9 +++++--
 ksrc/nucleus/timer.c              |   48 ++++++++++++++++++++++++++++---=
-------
 ksrc/skins/native/alarm.c         |    6 +++-
 ksrc/skins/posix/timer.c          |    5 +++
 ksrc/skins/psos+/tm.c             |    4 ++-
 ksrc/skins/vxworks/wdLib.c        |    4 ++-
 9 files changed, 80 insertions(+), 35 deletions(-)

Index: xenomai/include/nucleus/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/timer.h
+++ xenomai/include/nucleus/timer.h
@@ -50,6 +50,9 @@
=20
 #define XNTIMER_KEEPER_ID 0
=20
+#define XNTIMER_DONE    0
+#define XNTIMER_FORWARD 1
+
 typedef struct {
 	xnholder_t link;
 	xnticks_t key;
@@ -238,7 +241,7 @@ typedef struct xntimer {
 	struct xnsched *sched;	/* !< Sched structure to which the timer is
 				   attached. */
=20
-	void (*handler)(struct xntimer *timer); /* !< Timeout handler. */
+	int (*handler)(struct xntimer *timer); /* !< Timeout handler. */
=20
 	XNARCH_DECL_DISPLAY_CONTEXT();
=20
@@ -300,7 +303,7 @@ extern xntbops_t nktimer_ops_aperiodic,
=20
 void xntimer_init(xntimer_t *timer,
 		  xntbase_t *base,
-		  void (*handler)(xntimer_t *timer));
+		  int (*handler)(xntimer_t *timer));
=20
 void xntimer_destroy(xntimer_t *timer);
=20
@@ -325,8 +328,10 @@ void xntimer_destroy(xntimer_t *timer);
  *
  * @param interval The reload value of the timer. It is a periodic
  * interval value to be used for reprogramming the next timer shot,
- * expressed in clock ticks (see note). If @a interval is equal to
- * XN_INFINITE, the timer will not be reloaded after it has expired.
+ * expressed in clock ticks (see note). The associated timer handler mus=
t
+ * return XNTIMER_FORWARD to trigger the reloading after the timer has
+ * expired. If @a interval is equal to XN_INFINITE or the timer handler
+ * returns XNTIMER_DONE, the timer will not be reloaded.
  *
  * @param mode The timer mode. It can be either XN_RELATIVE or
  * XN_ABSOLUTE to define if @a value shall be interpreted as a
@@ -595,7 +600,7 @@ void xntimer_freeze(void);
=20
 void xntimer_tick_aperiodic(void);
=20
-void xntimer_tick_periodic(xntimer_t *timer);
+int xntimer_tick_periodic(xntimer_t *timer);
=20
 #ifdef CONFIG_SMP
 int xntimer_migrate(xntimer_t *timer,
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
     xntimer_start(&ctx->timer, xntbase_ns2ticks(rtdm_tbase, ctx->date),
                   XN_INFINITE, XN_ABSOLUTE);
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
@@ -24,14 +24,17 @@
 #include <nucleus/module.h>
 #include <asm/xenomai/bits/thread.h>
=20
-static void xnthread_timeout_handler(xntimer_t *timer)
+static int xnthread_timeout_handler(xntimer_t *timer)
 {
 	xnthread_t *thread =3D container_of(timer, xnthread_t, rtimer);
+
 	xnthread_set_info(thread, XNTIMEO);	/* Interrupts are off. */
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
@@ -39,6 +42,8 @@ static void xnthread_periodic_handler(xn
 	   blocked on a resource. */
 	if (xnthread_test_state(thread, XNDELAY|XNPEND) =3D=3D XNDELAY)
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
@@ -197,19 +197,28 @@ void xntimer_tick_aperiodic(void)
=20
 		if (timer !=3D &nkpod->htimer) {
 			if (!testbits(nktbase.status, XNTBLCK)) {
-				timer->handler(timer);
+				if (timer->handler(timer) =3D=3D XNTIMER_DONE)
+					continue;
=20
 				now =3D xnarch_get_cpu_tsc();
+#if defined(CONFIG_XENO_OPT_DEBUG_NUCLEUS) || defined(__XENO_SIM__)
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
-					continue;
+					   returning XNTIMER_FORWARD is wrong. */
+					xnlogerr("illegal timer restart detected -- "
+						 "status=3D%08lx, interval=3D%lld\n",
+						 timer->status, timer->interval);
+#ifdef __KERNEL__
+					show_stack(NULL, NULL);
+#endif
+ 					continue;
+				}
+#endif /* CONFIG_XENO_OPT_DEBUG_NUCLEUS || __XENO_SIM__ */
 			} else if (timer->interval =3D=3D XN_INFINITE) {
 				xntimerh_date(&timer->aplink) +=3D
 				    nkpod->htimer.interval;
@@ -315,7 +324,7 @@ static void xntimer_move_periodic(xntime
=20
 /*!
  * @internal
- * \fn void xntimer_tick_periodic(xntimer_t *mtimer)
+ * \fn int xntimer_tick_periodic(xntimer_t *mtimer)
  *
  * \brief Process a timer tick for a slave periodic time base.
  *
@@ -344,7 +353,7 @@ static void xntimer_move_periodic(xntime
  * @note Only active timers are inserted into the timer wheel.
  */
=20
-void xntimer_tick_periodic(xntimer_t *mtimer)
+int xntimer_tick_periodic(xntimer_t *mtimer)
 {
 	xntslave_t *slave =3D timer2slave(mtimer);
 	xnsched_t *sched =3D xnpod_current_sched();
@@ -369,12 +378,22 @@ void xntimer_tick_periodic(xntimer_t *mt
=20
 		xntimer_dequeue_periodic(timer);
=20
-		timer->handler(timer);
+		if (timer->handler(timer) =3D=3D XNTIMER_DONE)
+			continue;
=20
+#if defined(CONFIG_XENO_OPT_DEBUG_NUCLEUS) || defined(__XENO_SIM__)
 		if (timer->interval =3D=3D XN_INFINITE ||
 		    !testbits(timer->status, XNTIMER_DEQUEUED)
-		    || testbits(timer->status, XNTIMER_KILLED))
+		    || testbits(timer->status, XNTIMER_KILLED)) {
+			xnlogerr("illegal timer restart detected -- "
+				 "status=3D%08lx, interval=3D%lld\n",
+				 timer->status, timer->interval);
+#ifdef __KERNEL__
+			show_stack(NULL, NULL);
+#endif
 			continue;
+		}
+#endif /* CONFIG_XENO_OPT_DEBUG_NUCLEUS || __XENO_SIM__ */
=20
 		xntlholder_date(&timer->plink) =3D base->jiffies + timer->interval;
 		xntimer_enqueue_periodic(timer);
@@ -384,6 +403,8 @@ void xntimer_tick_periodic(xntimer_t *mt
=20
 	if (base->hook)
 		base->hook();
+
+	return XNTIMER_FORWARD;
 }
=20
 void xntslave_init(xntslave_t *slave)
@@ -484,7 +505,7 @@ xntbops_t nktimer_ops_periodic =3D {
 #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
=20
 /*!=20
- * \fn void xntimer_init(xntimer_t *timer,xntbase_t *base,void (*handler=
)(xntimer_t *timer))
+ * \fn void xntimer_init(xntimer_t *timer,xntbase_t *base,int (*handler)=
(xntimer_t *timer))
  * \brief Initialize a timer object.
  *
  * Creates a timer. When created, a timer is left disarmed; it must be
@@ -499,7 +520,9 @@ xntbops_t nktimer_ops_periodic =3D {
  * depends on. See xntbase_alloc() for detailed explanations about
  * time bases.
  *
- * @param handler The routine to call upon expiration of the timer.
+ * @param handler The routine to call upon expiration of the timer. The =
return
+ * value of this routine must be either XNTIMER_DONE or XNTIMER_FORWARD,=
 while
+ * the latter is only valid for periodic timers. See also xntimer_start(=
).
  *
  * There is no limitation on the number of timers which can be
  * created/active concurrently.
@@ -516,7 +539,8 @@ xntbops_t nktimer_ops_periodic =3D {
  * Rescheduling: never.
  */
=20
-void xntimer_init(xntimer_t *timer, xntbase_t *base, void (*handler) (xn=
timer_t *timer))
+void xntimer_init(xntimer_t *timer, xntbase_t *base,
+		  int (*handler) (xntimer_t *timer))
 {
 	/* CAUTION: Setup from xntimer_init() must not depend on the
 	   periodic/aperiodic timing mode. */
Index: xenomai/ksrc/skins/native/alarm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/alarm.c
+++ xenomai/ksrc/skins/native/alarm.c
@@ -121,11 +121,15 @@ void __native_alarm_pkg_cleanup(void)
 	__native_alarm_flush_rq(&__native_global_rholder.alarmq);
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
@@ -60,7 +60,7 @@ void tm_destroy_internal(psostm_t *tm)
 	xnfree(tm);
 }
=20
-static void tm_evpost_handler(xntimer_t *timer)
+static int tm_evpost_handler(xntimer_t *timer)
 {
 	psostm_t *tm =3D container_of(timer, psostm_t, timerbase);
=20
@@ -68,6 +68,8 @@ static void tm_evpost_handler(xntimer_t=20
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
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -143,7 +143,7 @@ const char *xnpod_fatal_helper(const cha
=20
 /*!=20
  * @internal
- * \fn void xnpod_watchdog_handler(xntimer_t *timer)
+ * \fn int xnpod_watchdog_handler(xntimer_t *timer)
  * \brief Process watchdog ticks.
  *
  * This internal routine handles incoming watchdog ticks to detect
@@ -152,23 +152,22 @@ const char *xnpod_fatal_helper(const cha
  * four seconds.
  */
=20
-void xnpod_watchdog_handler(xntimer_t *timer)
+int xnpod_watchdog_handler(xntimer_t *timer)
 {
 	xnsched_t *sched =3D xnpod_current_sched();
 	xnthread_t *thread =3D sched->runthread;
=20
-	if (likely(xnthread_test_state(thread, XNROOT))) {
+	if (likely(xnthread_test_state(thread, XNROOT)))
 		xnpod_reset_watchdog(sched);
-		return;
-	}
-	=09
-	if (unlikely(++sched->wdcount >=3D 4)) {
+	else if (unlikely(++sched->wdcount >=3D 4)) {
 		xnltt_log_event(xeno_ev_watchdog, thread->name);
 		xnprintf("watchdog triggered -- killing runaway thread '%s'\n",
 			 thread->name);
 		xnpod_delete_thread(thread);
 		xnpod_reset_watchdog(sched);
 	}
+
+	return XNTIMER_FORWARD;
 }
=20
 #endif /* CONFIG_XENO_OPT_WATCHDOG */


--------------enig0E4ED20268E2C8024EBE16E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGF/37niDOoMHTA+kRAmphAJ9O+DH6MWmRNmT/MJYetsK1rmo/aQCfTb5l
VdxHjnfw9Grn/ZNSYZE4xAY=
=k3cC
-----END PGP SIGNATURE-----

--------------enig0E4ED20268E2C8024EBE16E1--

