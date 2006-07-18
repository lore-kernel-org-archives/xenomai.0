Message-ID: <44BD7355.60507@domain.hid>
Date: Wed, 19 Jul 2006 01:48:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0536EF66E79AD2C1078AC387"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/2] kill cookie in xntimer_t
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
--------------enig0536EF66E79AD2C1078AC387
Content-Type: multipart/mixed; boundary="------------070303090708090807030508"

This is a multi-part message in MIME format.
--------------070303090708090807030508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[This is only the simplest part of a potential larger xntimer
restructuring. Other parts need to be rebased, rewritten, or even
rethought yet. One goal is to get the abstraction closer to the kernel's
hrtimer, another one is to check for potential optimisations. More
information will follow the next days or so.]


Almost all users of xntimer_t embed this object in the same meta-object
they later define as cookie of the timer handler. Thus, a simple
container_of could also serve to obtain the cookie in the handler.

This conversion is performed by the attached patch. It also handles the
only exception of the rule above: the vwworks skin requires a trampoline
handler for its wdog now. Philippe confirmed earlier that this is
acceptable.

Jan

--------------070303090708090807030508
Content-Type: text/x-patch;
 name="xntimer-arg.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xntimer-arg.patch"

---
 include/asm-sim/system.h             |    4 ++++
 include/asm-uvm/system.h             |    4 ++++
 include/nucleus/timer.h              |    7 ++-----
 ksrc/drivers/testing/timerbench.c    |    7 ++++---
 ksrc/nucleus/pod.c                   |    2 +-
 ksrc/nucleus/thread.c                |   12 ++++++------
 ksrc/nucleus/timer.c                 |   13 ++++---------
 ksrc/skins/native/alarm.c            |    6 +++---
 ksrc/skins/posix/timer.c             |    7 ++++---
 ksrc/skins/psos+/tm.c                |    6 +++---
 ksrc/skins/vxworks/defs.h            |    3 +++
 ksrc/skins/vxworks/wdLib.c           |   11 ++++++++++-
 sim/skins/posix/testsuite/xntest.c   |    4 ++--
 sim/skins/vxworks/testsuite/xntest.c |    4 ++--
 14 files changed, 52 insertions(+), 38 deletions(-)

Index: include/asm-sim/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-sim/system.h.orig
+++ include/asm-sim/system.h
@@ -245,6 +245,10 @@ xnarch_read_environ (const char *name, c
 #define __init
 #define __exit
=20
+#define container_of(ptr, type, member) ({                      \
+        const typeof( ((type *)0)->member ) *__mptr =3D (ptr);    \
+        (type *)( (char *)__mptr - offsetof(type,member) );})
+
 #ifdef __cplusplus
 extern "C" {
 #endif
Index: include/asm-uvm/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-uvm/system.h.orig
+++ include/asm-uvm/system.h
@@ -52,6 +52,10 @@
 #define __init
 #define __exit
=20
+#define container_of(ptr, type, member) ({                      \
+        const typeof( ((type *)0)->member ) *__mptr =3D (ptr);    \
+        (type *)( (char *)__mptr - offsetof(type,member) );})
+
 typedef int spl_t;
=20
 typedef unsigned long cpumask_t;
Index: include/nucleus/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/timer.h.orig
+++ include/nucleus/timer.h
@@ -226,9 +226,7 @@ typedef struct xntimer {
     struct xnsched *sched;      /* !< Sched structure to which the timer=
 is
                                    attached. */
=20
-    void (*handler)(void *cookie); /* !< Timeout handler. */
-
-    void *cookie;	/* !< Cookie to pass to the timeout handler. */
+    void (*handler)(struct xntimer *timer); /* !< Timeout handler. */
=20
     XNARCH_DECL_DISPLAY_CONTEXT();
=20
@@ -288,8 +286,7 @@ extern "C" {
 extern xntmops_t *nktimer;
=20
 void xntimer_init(xntimer_t *timer,
-		  void (*handler)(void *cookie),
-		  void *cookie);
+		  void (*handler)(xntimer_t *timer));
=20
 void xntimer_destroy(xntimer_t *timer);
=20
Index: ksrc/drivers/testing/timerbench.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/testing/timerbench.c.orig
+++ ksrc/drivers/testing/timerbench.c
@@ -165,9 +165,10 @@ void timer_task_proc(void *arg)
 }
=20
=20
-void timer_proc(void *arg)
+void timer_proc(xntimer_t *timer)
 {
-    struct rt_tmbench_context   *ctx =3D (struct rt_tmbench_context *)ar=
g;
+    struct rt_tmbench_context   *ctx =3D
+        container_of(timer, struct rt_tmbench_context, timer);
=20
=20
     eval_inner_loop(ctx, (long)(rtdm_clock_read() - ctx->date));
@@ -309,7 +310,7 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
                 }
             } else {
                 /* FIXME: convert to RTDM timers */
-                xntimer_init(&ctx->timer, timer_proc, ctx);
+                xntimer_init(&ctx->timer, timer_proc);
=20
                 ctx->curr.test_loops =3D 0;
=20
Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c.orig
+++ ksrc/nucleus/pod.c
@@ -390,7 +390,7 @@ int xnpod_init(xnpod_t *pod, int minpri,
 	/* No direct handler here since the host timer processing is
 	   postponed to xnintr_irq_handler(), as part of the interrupt
 	   exit code. */
-	xntimer_init(&pod->htimer, NULL, NULL);
+	xntimer_init(&pod->htimer, NULL);
 	xntimer_set_priority(&pod->htimer, XNTIMER_LOPRIO);
=20
 	xnlock_put_irqrestore(&nklock, s);
Index: ksrc/nucleus/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/thread.c.orig
+++ ksrc/nucleus/thread.c
@@ -25,16 +25,16 @@
 #include <nucleus/thread.h>
 #include <nucleus/module.h>
=20
-static void xnthread_timeout_handler(void *cookie)
+static void xnthread_timeout_handler(xntimer_t *timer)
 {
-	xnthread_t *thread =3D (xnthread_t *)cookie;
+	xnthread_t *thread =3D container_of(timer, xnthread_t, rtimer);
 	__setbits(thread->status, XNTIMEO);	/* Interrupts are off. */
 	xnpod_resume_thread(thread, XNDELAY);
 }
=20
-static void xnthread_periodic_handler(void *cookie)
+static void xnthread_periodic_handler(xntimer_t *timer)
 {
-	xnthread_t *thread =3D (xnthread_t *)cookie;
+	xnthread_t *thread =3D container_of(timer, xnthread_t, ptimer);
=20
 	if (xnthread_test_flags(thread, XNDELAY))	/* Prevent unwanted round-rob=
in. */
 		xnpod_resume_thread(thread, XNDELAY);
@@ -46,9 +46,9 @@ int xnthread_init(xnthread_t *thread,
 {
 	int err;
=20
-	xntimer_init(&thread->rtimer, &xnthread_timeout_handler, thread);
+	xntimer_init(&thread->rtimer, &xnthread_timeout_handler);
 	xntimer_set_priority(&thread->rtimer, XNTIMER_HIPRIO);
-	xntimer_init(&thread->ptimer, &xnthread_periodic_handler, thread);
+	xntimer_init(&thread->ptimer, &xnthread_periodic_handler);
 	xntimer_set_priority(&thread->ptimer, XNTIMER_HIPRIO);
=20
 	/* Setup the TCB. */
Index: ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/timer.c.orig
+++ ksrc/nucleus/timer.c
@@ -212,7 +212,7 @@ static void xntimer_do_tick_aperiodic(vo
=20
 		if (timer !=3D &nkpod->htimer) {
 			if (!testbits(nkpod->status, XNTLOCK)) {
-				timer->handler(timer->cookie);
+				timer->handler(timer);
=20
 				if (timer->interval =3D=3D XN_INFINITE ||
 				    !testbits(timer->status, XNTIMER_DEQUEUED)
@@ -388,7 +388,7 @@ static void xntimer_do_tick_periodic(voi
=20
 		if (timer !=3D &nkpod->htimer) {
 			if (!testbits(nkpod->status, XNTLOCK)) {
-				timer->handler(timer->cookie);
+				timer->handler(timer);
=20
 				if (timer->interval =3D=3D XN_INFINITE ||
 				    !testbits(timer->status, XNTIMER_DEQUEUED)
@@ -461,7 +461,7 @@ void xntimer_set_periodic_mode(void)
 #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
=20
 /*!=20
- * \fn void xntimer_init(xntimer_t *timer,void (*handler)(void *cookie),=
void *cookie)
+ * \fn void xntimer_init(xntimer_t *timer,void (*handler)(xntimer_t *tim=
er))
  * \brief Initialize a timer object.
  *
  * Creates a timer. When created, a timer is left disarmed; it must be
@@ -474,9 +474,6 @@ void xntimer_set_periodic_mode(void)
  *
  * @param handler The routine to call upon expiration of the timer.
  *
- * @param cookie A user-defined opaque cookie the nucleus will pass
- * unmodified to the handler as its unique argument.
- *
  * There is no limitation on the number of timers which can be
  * created/active concurrently.
  *
@@ -492,8 +489,7 @@ void xntimer_set_periodic_mode(void)
  * Rescheduling: never.
  */
=20
-void xntimer_init(xntimer_t *timer,
-		  void (*handler) (void *cookie), void *cookie)
+void xntimer_init(xntimer_t *timer, void (*handler) (xntimer_t *timer))
 {
 	/* CAUTION: Setup from xntimer_init() must not depend on the
 	   periodic/aperiodic timing mode. */
@@ -507,7 +503,6 @@ void xntimer_init(xntimer_t *timer,
 	xntimer_set_priority(timer, XNTIMER_STDPRIO);
 	timer->status =3D XNTIMER_DEQUEUED;
 	timer->handler =3D handler;
-	timer->cookie =3D cookie;
 	timer->interval =3D 0;
 	timer->sched =3D xnpod_current_sched();
=20
Index: ksrc/skins/native/alarm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/alarm.c.orig
+++ ksrc/skins/native/alarm.c
@@ -117,9 +117,9 @@ void __native_alarm_pkg_cleanup(void)
 {
 }
=20
-static void __alarm_trampoline(void *cookie)
+static void __alarm_trampoline(xntimer_t *timer)
 {
-	RT_ALARM *alarm =3D (RT_ALARM *)cookie;
+	RT_ALARM *alarm =3D container_of(timer, RT_ALARM, timer_base);
 	++alarm->expiries;
 	alarm->handler(alarm, alarm->cookie);
 }
@@ -189,7 +189,7 @@ int rt_alarm_create(RT_ALARM *alarm,
 	if (xnpod_asynch_p())
 		return -EPERM;
=20
-	xntimer_init(&alarm->timer_base, &__alarm_trampoline, alarm);
+	xntimer_init(&alarm->timer_base, &__alarm_trampoline);
 	alarm->handle =3D 0;	/* i.e. (still) unregistered alarm. */
 	alarm->magic =3D XENO_ALARM_MAGIC;
 	alarm->expiries =3D 0;
Index: ksrc/skins/posix/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/timer.c.orig
+++ ksrc/skins/posix/timer.c
@@ -52,9 +52,10 @@ static xnqueue_t timer_freeq;
=20
 static struct pse51_timer timer_pool[PSE51_TIMER_MAX];
=20
-static void pse51_base_timer_handler(void *cookie)
+static void pse51_base_timer_handler(xntimer_t *xntimer)
 {
-	struct pse51_timer *timer =3D (struct pse51_timer *)cookie;
+	struct pse51_timer *timer =3D
+		container_of(xntimer, struct pse51_timer, timerbase);
=20
 	if (timer->queued) {
 		if (timer->overruns < DELAYTIMER_MAX)
@@ -166,7 +167,7 @@ int timer_create(clockid_t clockid,
 		timer->si.info.si_value.sival_int =3D (timer - timer_pool);
 	}
=20
-	xntimer_init(&timer->timerbase, &pse51_base_timer_handler, timer);
+	xntimer_init(&timer->timerbase, &pse51_base_timer_handler);
=20
 	timer->overruns =3D 0;
 	timer->owner =3D NULL;
Index: ksrc/skins/psos+/tm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/psos+/tm.c.orig
+++ ksrc/skins/psos+/tm.c
@@ -57,9 +57,9 @@ void tm_destroy_internal(psostm_t *tm)
 	xnfree(tm);
 }
=20
-static void tm_evpost_handler(void *cookie)
+static void tm_evpost_handler(xntimer_t *timer)
 {
-	psostm_t *tm =3D (psostm_t *)cookie;
+	psostm_t *tm =3D container_of(timer, psostm_t, timerbase);
=20
 	ev_send((u_long)tm->owner, tm->events);
=20
@@ -83,7 +83,7 @@ static u_long tm_start_event_timer(u_lon
 	tm->owner =3D psos_current_task();
 	*tmid =3D (u_long)tm;
=20
-	xntimer_init(&tm->timerbase, tm_evpost_handler, tm);
+	xntimer_init(&tm->timerbase, tm_evpost_handler);
 	tm->magic =3D PSOS_TM_MAGIC;
=20
 	xnlock_get_irqsave(&nklock, s);
Index: ksrc/skins/vxworks/defs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/vxworks/defs.h.orig
+++ ksrc/skins/vxworks/defs.h
@@ -139,6 +139,9 @@ typedef struct wind_wd {
=20
     xntimer_t timerbase;
=20
+    wind_timer_t handler;
+    long arg;
+
 #ifdef CONFIG_XENO_OPT_REGISTRY
     xnhandle_t handle;
     char name[XNOBJECT_NAME_LEN];
Index: ksrc/skins/vxworks/wdLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/vxworks/wdLib.c.orig
+++ ksrc/skins/vxworks/wdLib.c
@@ -90,6 +90,13 @@ static xnpnode_t wd_pnode =3D {
=20
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
=20
+static void wind_wd_trampoline(xntimer_t *timer)
+{
+	wind_wd_t *wd =3D container_of(timer, wind_wd_t, timerbase);
+
+	wd->handler(wd->arg);
+}
+
 void wind_wd_init(void)
 {
 	initq(&wind_wd_q);
@@ -172,7 +179,9 @@ STATUS wdStart(WDOG_ID wdog_id, int time
 	else
 		xntimer_stop(&wd->timerbase);
=20
-	xntimer_init(&wd->timerbase, (void (*)(void *))handler, (void *)arg);
+	xntimer_init(&wd->timerbase, wind_wd_trampoline);
+	wd->handler =3D handler;
+	wd->arg =3D arg;
=20
 	xntimer_start(&wd->timerbase, timeout, XN_INFINITE);
=20
Index: sim/skins/posix/testsuite/xntest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- sim/skins/posix/testsuite/xntest.c.orig
+++ sim/skins/posix/testsuite/xntest.c
@@ -63,7 +63,7 @@ static inline int strings_differ(const c
     return ((!str1 || !str2) ? str1!=3Dstr2 : strcmp(str1, str2));
 }
=20
-static void interrupt_test (void *dummy)
+static void interrupt_test (xntimer_t *dummy)
 {
    xnpod_fatal("\ntest interrupted by watchdog.\n");
 }
@@ -78,7 +78,7 @@ void xntest_start(void)
         xntest_verbose =3D module_param_value(xntest_verbose);
=20
     xnlock_get_irqsave(&test_lock, s);
-    xntimer_init(&watchdog, interrupt_test, 0);
+    xntimer_init(&watchdog, interrupt_test);
     xntimer_start(&watchdog, xnpod_ns2ticks(test_timeout * 1000000000ULL=
), XN_INFINITE);
=20
     initq(&marks_q);
Index: sim/skins/vxworks/testsuite/xntest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- sim/skins/vxworks/testsuite/xntest.c.orig
+++ sim/skins/vxworks/testsuite/xntest.c
@@ -63,7 +63,7 @@ static inline int strings_differ(const c
     return ((!str1 || !str2) ? str1!=3Dstr2 : strcmp(str1, str2));
 }
=20
-static void interrupt_test (void *dummy)
+static void interrupt_test (xntimer_t *dummy)
 {
    xnpod_fatal("\ntest interrupted by watchdog.\n");
 }
@@ -78,7 +78,7 @@ void xntest_start(void)
         xntest_verbose =3D module_param_value(xntest_verbose);
=20
     xnlock_get_irqsave(&test_lock, s);
-    xntimer_init(&watchdog, interrupt_test, 0);
+    xntimer_init(&watchdog, interrupt_test);
     xntimer_start(&watchdog, xnpod_ns2ticks(test_timeout * 1000000000ULL=
), XN_INFINITE);
=20
     initq(&marks_q);

--------------070303090708090807030508--

--------------enig0536EF66E79AD2C1078AC387
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEvXNWniDOoMHTA+kRAkHKAJ9vsOyd3HeBM7YuKIsh1tSdl3MhxQCfZ+dC
pEIOZyl7uhd8N/PMWOcs7C4=
=JEON
-----END PGP SIGNATURE-----

--------------enig0536EF66E79AD2C1078AC387--

