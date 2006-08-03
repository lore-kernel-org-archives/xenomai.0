Message-ID: <44D19E42.7020900@domain.hid>
Date: Thu, 03 Aug 2006 08:57:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA77943EDDE0EB0050D19343D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 2/4] apply absolute xntimer_start
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
--------------enigA77943EDDE0EB0050D19343D
Content-Type: multipart/mixed; boundary="------------040207080902020907080704"

This is a multi-part message in MIME format.
--------------040207080902020907080704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This second patch extends xnpod_suspend_thread and xnsynch_sleep_on by a
timeout mode parameter to specify both relative and absolute timeouts on
thread suspension.

All callers of the involved services are at least adapted to the
interface change. Most callers that formerly converted absolute to
relative timeouts now no longer do this - except for the POSIX skin
which requires more refactoring.

I'm now scratching my head, because there was something more I wanted to
remark here. But I forgot to write it down when I hacked the patch, damn.=


Anyway, the patch is tested lightly and seems to include only well
hidden regressions. What remains to be done is an evaluation of what we
may gain (speed for some scenarios) vs. what we may loose (speed in some
other scenarios, code size).

Jan

--------------040207080902020907080704
Content-Type: text/x-patch;
 name="xnpod-xnsynch-abs-timer.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xnpod-xnsynch-abs-timer.patch"

---
 include/nucleus/pod.h             |    5 ++-
 include/nucleus/synch.h           |    3 --
 ksrc/drivers/testing/switchtest.c |    4 +-
 ksrc/nucleus/pipe.c               |    3 +-
 ksrc/nucleus/pod.c                |   45 +++++++++++++++++++-----------
 ksrc/nucleus/registry.c           |    6 ++--
 ksrc/nucleus/shadow.c             |   13 +++++++-
 ksrc/nucleus/synch.c              |   24 ++++++++++------
 ksrc/skins/native/cond.c          |    2 -
 ksrc/skins/native/event.c         |    2 -
 ksrc/skins/native/heap.c          |    2 -
 ksrc/skins/native/mutex.c         |    2 -
 ksrc/skins/native/queue.c         |    2 -
 ksrc/skins/native/sem.c           |    2 -
 ksrc/skins/native/syscall.c       |    4 +-
 ksrc/skins/native/task.c          |   18 +++++-------
 ksrc/skins/posix/clock.c          |    3 +-
 ksrc/skins/posix/cond.c           |    2 -
 ksrc/skins/posix/mq.c             |    4 +-
 ksrc/skins/posix/mutex.c          |    2 -
 ksrc/skins/posix/mutex.h          |    2 -
 ksrc/skins/posix/registry.c       |    3 +-
 ksrc/skins/posix/sem.c            |    2 -
 ksrc/skins/posix/signal.c         |    3 +-
 ksrc/skins/posix/syscall.c        |    2 -
 ksrc/skins/posix/thread.c         |    3 +-
 ksrc/skins/psos+/event.c          |    2 -
 ksrc/skins/psos+/queue.c          |    2 -
 ksrc/skins/psos+/rn.c             |    2 -
 ksrc/skins/psos+/sem.c            |    2 -
 ksrc/skins/psos+/task.c           |    3 +-
 ksrc/skins/rtdm/drvlib.c          |   56 +++++++++++--------------------=
-------
 ksrc/skins/uitron/flag.c          |    2 -
 ksrc/skins/uitron/mbx.c           |    2 -
 ksrc/skins/uitron/sem.c           |    2 -
 ksrc/skins/uitron/task.c          |   15 ++++++----
 ksrc/skins/vrtx/event.c           |    2 -
 ksrc/skins/vrtx/mb.c              |    2 -
 ksrc/skins/vrtx/mx.c              |    2 -
 ksrc/skins/vrtx/queue.c           |    2 -
 ksrc/skins/vrtx/sem.c             |    2 -
 ksrc/skins/vrtx/task.c            |    6 ++--
 ksrc/skins/vxworks/msgQLib.c      |    6 ++--
 ksrc/skins/vxworks/semLib.c       |    4 +-
 ksrc/skins/vxworks/syscall.c      |    2 -
 ksrc/skins/vxworks/taskLib.c      |    6 ++--
 46 files changed, 152 insertions(+), 133 deletions(-)

Index: xenomai/include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/pod.h
+++ xenomai/include/nucleus/pod.h
@@ -454,6 +454,7 @@ xnflags_t xnpod_set_thread_mode(xnthread
 void xnpod_suspend_thread(xnthread_t *thread,
                           xnflags_t mask,
                           xnticks_t timeout,
+                          int timeout_mode,
                           struct xnsynch *resource);
=20
 void xnpod_resume_thread(xnthread_t *thread,
@@ -536,12 +537,12 @@ static inline void xnpod_yield (void)
=20
 static inline void xnpod_delay (xnticks_t timeout)
 {
-    xnpod_suspend_thread(xnpod_current_thread(),XNDELAY,timeout,NULL);
+    xnpod_suspend_thread(xnpod_current_thread(),XNDELAY,timeout,XNTIMER_=
RELATIVE,NULL);
 }
=20
 static inline void xnpod_suspend_self (void)
 {
-    xnpod_suspend_thread(xnpod_current_thread(),XNSUSP,XN_INFINITE,NULL)=
;
+    xnpod_suspend_thread(xnpod_current_thread(),XNSUSP,XN_INFINITE,XNTIM=
ER_RELATIVE,NULL);
 }
=20
 static inline void xnpod_delete_self (void)
Index: xenomai/include/nucleus/synch.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/synch.h
+++ xenomai/include/nucleus/synch.h
@@ -100,8 +100,7 @@ static inline void xnsynch_register_clea
     synch->cleanup =3D handler;
 }
=20
-void xnsynch_sleep_on(xnsynch_t *synch,
-		      xnticks_t timeout);
+void xnsynch_sleep_on(xnsynch_t *synch, xnticks_t timeout, int timeout_m=
ode);
=20
 struct xnthread *xnsynch_wakeup_one_sleeper(xnsynch_t *synch);
=20
Index: xenomai/ksrc/drivers/testing/switchtest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/drivers/testing/switchtest.c
+++ xenomai/ksrc/drivers/testing/switchtest.c
@@ -50,7 +50,7 @@ static int rtswitch_pend_rt(rtswitch_con
 	task =3D &ctx->tasks[idx];
 	task->base.flags |=3D RTSWITCH_RT;
=20
-	xnsynch_sleep_on(&task->rt_synch, XN_INFINITE);
+	xnsynch_sleep_on(&task->rt_synch, XN_INFINITE, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(xnpod_current_thread(), XNBREAK))
 		return -EINTR;
@@ -99,7 +99,7 @@ static int rtswitch_to_rt(rtswitch_conte
 		return -EINVAL;
 	}
=20
-	xnsynch_sleep_on(&from->rt_synch, XN_INFINITE);
+	xnsynch_sleep_on(&from->rt_synch, XN_INFINITE, XNTIMER_RELATIVE);
=20
 	xnlock_put_irqrestore(&nklock, s);
=20
Index: xenomai/ksrc/nucleus/pipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pipe.c
+++ xenomai/ksrc/nucleus/pipe.c
@@ -432,7 +432,8 @@ ssize_t xnpipe_recv(int minor, struct xn
 			goto unlock_and_exit;
 		}
=20
-		xnsynch_sleep_on(&state->synchbase, timeout);
+		xnsynch_sleep_on(&state->synchbase, timeout,
+				 XNTIMER_RELATIVE);
=20
 		thread =3D xnpod_current_thread();
=20
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -180,7 +180,8 @@ static int xnpod_fault_handler(xnarch_fl
 		     thread, thread->name, xnarch_fault_pc(fltinfo),
 		     xnarch_fault_trap(fltinfo));
=20
-		xnpod_suspend_thread(thread, XNSUSP, XN_INFINITE, NULL);
+		xnpod_suspend_thread(thread, XNSUSP, XN_INFINITE,
+				     XNTIMER_RELATIVE, NULL);
=20
 		return 1;
 	}
@@ -819,7 +820,7 @@ int xnpod_init_thread(xnthread_t *thread
 	appendq(&nkpod->threadq, &thread->glink);
 	nkpod->threadq_rev++;
 	xnpod_suspend_thread(thread, XNDORMANT | (flags & XNSUSP), XN_INFINITE,=

-			     NULL);
+			     XNTIMER_RELATIVE, NULL);
 	xnlock_put_irqrestore(&nklock, s);
=20
 	return 0;
@@ -1289,7 +1290,9 @@ void xnpod_delete_thread(xnthread_t *thr
 }
=20
 /*!
- * \fn void xnpod_suspend_thread(xnthread_t *thread,xnflags_t mask,xntic=
ks_t timeout,xnsynch_t *wchan)
+ * \fn void xnpod_suspend_thread(xnthread_t *thread,xnflags_t mask,
+ *                               xnticks_t timeout,int timeout_mode,
+ *                               xnsynch_t *wchan)
  *
  * \brief Suspend a thread.
  *
@@ -1320,12 +1323,17 @@ void xnpod_delete_thread(xnthread_t *thr
  * through the xnsynch_sleep_on() call.
  *
  * @param timeout The timeout which may be used to limit the time the
- * thread pends for a resource. This value is a wait time given in
- * ticks (see note).  Passing XN_INFINITE specifies an unbounded
- * wait. All other values are used to initialize a watchdog timer.  If
- * the current operation mode is oneshot and @a timeout elapses before
- * xnpod_suspend_thread() has completed, then the target thread will
- * not be suspended, and this routine leads to a null effect.
+ * thread pends on a resource. This value is a wait time given in
+ * ticks (see note). It can either be relative or absolute dependent on
+ * @a timeout_mode. Passing XN_INFINITE @b and setting @a timeout_mode
+ * to XNTIMER_RELATIVE specifies an unbounded wait. All other values are=

+ * used to initialize a watchdog timer. If the cusrrent operation mode
+ * of the system timer is oneshot and @a timeout elapses before
+ * xnpod_suspend_thread() has completed, then the target thread will not=

+ * be suspended, and this routine leads to a null effect.
+ *
+ * @param timeout_mode The mode of the @a timeout parameter. It can eith=
er
+ * be set to XNTIMER_RELATIVE or XNTIMER_ABSOLUTE.
  *
  * @param wchan The address of a pended resource. This parameter is
  * used internally by the synchronization object implementation code
@@ -1356,7 +1364,8 @@ void xnpod_delete_thread(xnthread_t *thr
  */
=20
 void xnpod_suspend_thread(xnthread_t *thread,
-			  xnflags_t mask, xnticks_t timeout, xnsynch_t *wchan)
+			  xnflags_t mask, xnticks_t timeout, int timeout_mode,
+			  xnsynch_t *wchan)
 {
 	xnsched_t *sched;
 	spl_t s;
@@ -1372,7 +1381,8 @@ void xnpod_suspend_thread(xnthread_t *th
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thrsuspend, thread->name, mask, timeout, wchan)=
;
+	xnltt_log_event(xeno_ev_thrsuspend, thread->name, mask, timeout,
+		        timeout_mode, wchan);
=20
 	sched =3D thread->sched;
=20
@@ -1424,13 +1434,14 @@ void xnpod_suspend_thread(xnthread_t *th
=20
 	__setbits(thread->status, mask);
=20
-	if (timeout !=3D XN_INFINITE) {
+	if (timeout !=3D XN_INFINITE || timeout_mode =3D=3D XNTIMER_ABSOLUTE) {=

 		/* Don't start the timer for a thread indefinitely delayed by
-		   a call to xnpod_suspend_thread(thread,XNDELAY,0,NULL). */
+		   a call to xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,
+		   XNTIMER_RELATIVE,NULL). */
 		__setbits(thread->status, XNDELAY);
 		xntimer_set_sched(&thread->rtimer, thread->sched);
 		xntimer_start(&thread->rtimer, timeout, XN_INFINITE,
-			      XNTIMER_RELATIVE);
+			      timeout_mode);
 	}
 #ifdef __XENO_SIM__
 	if (nkpod->schedhook)
@@ -3266,7 +3277,7 @@ int xnpod_announce_tick(xnintr_t *intr)
 			    ("watchdog triggered -- suspending runaway thread '%s'\n",
 			     xnpod_current_thread()->name);
 			xnpod_suspend_thread(xnpod_current_thread(), XNSUSP,
-					     XN_INFINITE, NULL);
+					     XN_INFINITE, XNTIMER_RELATIVE, NULL);
 		} else {
 			xnpod_reset_watchdog(sched);
 		}
@@ -3406,7 +3417,7 @@ int xnpod_set_thread_periodic(xnthread_t
 			    xntimer_get_raw_expiry(&thread->ptimer)
 			    + xntimer_interval(&thread->ptimer);
 			xnpod_suspend_thread(thread, XNDELAY, XN_INFINITE,
-					     NULL);
+					     XNTIMER_RELATIVE, NULL);
 		} else
 			err =3D -ETIMEDOUT;
 	}
@@ -3482,7 +3493,7 @@ int xnpod_wait_thread_period(unsigned lo
 	now =3D xntimer_get_rawclock();	/* Work with either TSC or periodic tic=
ks. */
=20
 	if (likely(now < thread->pexpect)) {
-		xnpod_suspend_thread(thread, XNDELAY, XN_INFINITE, NULL);
+		xnpod_suspend_thread(thread, XNDELAY, XN_INFINITE, XNTIMER_RELATIVE, N=
ULL);
=20
 		if (unlikely(xnthread_test_flags(thread, XNBREAK))) {
 			err =3D -EINTR;
Index: xenomai/ksrc/nucleus/registry.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/registry.c
+++ xenomai/ksrc/nucleus/registry.c
@@ -727,7 +727,8 @@ int xnregistry_bind(const char *key, xnt
=20
 		thread =3D xnpod_current_thread();
 		thread->registry.waitkey =3D key;
-		xnsynch_sleep_on(&registry_hash_synch, timeout);
+		xnsynch_sleep_on(&registry_hash_synch, timeout,
+				 XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(thread, XNTIMEO)) {
 			err =3D -ETIMEDOUT;
@@ -915,7 +916,8 @@ int xnregistry_remove_safe(xnhandle_t ha
 	cstamp =3D object->cstamp;
=20
 	do {
-		xnsynch_sleep_on(&object->safesynch, timeout);
+		xnsynch_sleep_on(&object->safesynch, timeout,
+				 XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(xnpod_current_thread(), XNBREAK)) {
 			err =3D -EINTR;
Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -719,7 +719,8 @@ void xnshadow_relax(int notify)
 		xnpod_renice_root(XNPOD_ROOT_PRIO_BASE);
 #endif /* CONFIG_XENO_OPT_RPIDISABLE */
=20
-	xnpod_suspend_thread(thread, XNRELAX, XN_INFINITE, NULL);
+	xnpod_suspend_thread(thread, XNRELAX, XN_INFINITE,
+			     XNTIMER_RELATIVE, NULL);
=20
 	splexit(s);
=20
@@ -845,7 +846,8 @@ int xnshadow_map(xnthread_t *thread, xnc
 	    MAX_RT_PRIO ? xnthread_base_priority(thread) : MAX_RT_PRIO - 1;
 	set_linux_task_priority(current, prio);
 	xnshadow_thrptd(current) =3D thread;
-	xnpod_suspend_thread(thread, XNRELAX, XN_INFINITE, NULL);
+	xnpod_suspend_thread(thread, XNRELAX, XN_INFINITE,
+			     XNTIMER_RELATIVE, NULL);
=20
 	if (u_completion) {
 		xnshadow_signal_completion(u_completion, 0);
@@ -1026,6 +1028,13 @@ static int xnshadow_sys_migrate(struct t
 			if (testbits(xnshadow_thread(curr)->status, XNDORMANT))
 				return 0;
=20
+			/* Paranoid: a corner case where the
+			   user-space side fiddles with SIGCHLD while
+			   the target thread is still waiting to be
+			   started. */
+			if (testbits(xnshadow_thread(curr)->status, XNDORMANT))
+				return 0;
+
 			return xnshadow_harden()? : 1;
 		} else
 			return 0;
Index: xenomai/ksrc/nucleus/synch.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/synch.c
+++ xenomai/ksrc/nucleus/synch.c
@@ -127,7 +127,7 @@ static inline void xnsynch_renice_thread
 }
=20
 /*!=20
- * \fn void xnsynch_sleep_on(xnsynch_t *synch,xnticks_t timeout)
+ * \fn void xnsynch_sleep_on(xnsynch_t *synch,xnticks_t timeout,int time=
out_mode)
  * \brief Sleep on a synchronization object.
  *
  * Makes the calling thread sleep on the specified synchronization
@@ -140,9 +140,14 @@ static inline void xnsynch_renice_thread
  * to sleep on.
  *
  * @param timeout The timeout which may be used to limit the time the
- * thread pends on the resource. This value is a count of ticks (see
- * note).  Passing XN_INFINITE specifies an unbounded wait. All other
- * values are used to initialize a nucleus watchdog timer.
+ * thread pends on the resource. This value is a wait time given in
+ * ticks (see note). It can either be relative or absolute dependent on
+ * @a timeout_mode. Passing XN_INFINITE @b and setting @a timeout_mode
+ * to XNTIMER_RELATIVE specifies an unbounded wait. All other values are=

+ * used to initialize a watchdog timer.
+ *
+ * @param timeout_mode The mode of the @a timeout parameter. It can eith=
er
+ * be set to XNTIMER_RELATIVE or XNTIMER_ABSOLUTE.
  *
  * Environments:
  *
@@ -160,7 +165,7 @@ static inline void xnsynch_renice_thread
  * oneshot mode, clock ticks are interpreted as nanoseconds.
  */
=20
-void xnsynch_sleep_on(xnsynch_t *synch, xnticks_t timeout)
+void xnsynch_sleep_on(xnsynch_t *synch, xnticks_t timeout, int timeout_m=
ode)
 {
 	xnthread_t *thread =3D xnpod_current_thread(), *owner;
 	spl_t s;
@@ -207,13 +212,14 @@ void xnsynch_sleep_on(xnsynch_t *synch,=20
 				insertpqf(&synch->pendq, &thread->plink,
 					  thread->cprio);
=20
-			xnpod_suspend_thread(thread, XNPEND, timeout, synch);
+			xnpod_suspend_thread(thread, XNPEND, timeout,
+					     timeout_mode, synch);
=20
 			if (unlikely(synch->owner !=3D thread)) {
 				/* Somebody stole us the ownership while we were ready to
 				   run, waiting for the CPU: we need to wait again for the
 				   resource. */
-				if (timeout =3D=3D XN_INFINITE)
+				if (timeout =3D=3D XN_INFINITE || timeout_mode =3D=3D XNTIMER_ABSOLU=
TE)
 					goto redo;
 				timeout =3D xnthread_timeout(thread);
 				if (timeout > 1)	/* Otherwise, it's too late, time elapsed. */
@@ -223,11 +229,11 @@ void xnsynch_sleep_on(xnsynch_t *synch,=20
 			}
 		} else {
 			insertpqf(&synch->pendq, &thread->plink, thread->cprio);
-			xnpod_suspend_thread(thread, XNPEND, timeout, synch);
+			xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
 		}
 	} else {		/* otherwise FIFO */
 		appendpq(&synch->pendq, &thread->plink);
-		xnpod_suspend_thread(thread, XNPEND, timeout, synch);
+		xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
 	}
=20
       grab_ownership:
Index: xenomai/ksrc/skins/native/cond.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/cond.c
+++ xenomai/ksrc/skins/native/cond.c
@@ -452,7 +452,7 @@ int rt_cond_wait(RT_COND *cond, RT_MUTEX
=20
 	task =3D xeno_current_task();
=20
-	xnsynch_sleep_on(&cond->synch_base, timeout);
+	xnsynch_sleep_on(&cond->synch_base, timeout, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(&task->thread_base, XNRMID))
 		err =3D -EIDRM;	/* Condvar deleted while pending. */
Index: xenomai/ksrc/skins/native/event.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/event.c
+++ xenomai/ksrc/skins/native/event.c
@@ -495,7 +495,7 @@ int rt_event_wait(RT_EVENT *event,
 	task =3D xeno_current_task();
 	task->wait_args.event.mode =3D mode;
 	task->wait_args.event.mask =3D mask;
-	xnsynch_sleep_on(&event->synch_base, timeout);
+	xnsynch_sleep_on(&event->synch_base, timeout, XNTIMER_RELATIVE);
 	/* The returned mask is only significant if the operation has
 	   succeeded, but do always write it back anyway. */
 	*mask_r =3D task->wait_args.event.mask;
Index: xenomai/ksrc/skins/native/heap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/heap.c
+++ xenomai/ksrc/skins/native/heap.c
@@ -543,7 +543,7 @@ int rt_heap_alloc(RT_HEAP *heap, size_t=20
 	task =3D xeno_current_task();
 	task->wait_args.heap.size =3D size;
 	task->wait_args.heap.block =3D NULL;
-	xnsynch_sleep_on(&heap->synch_base, timeout);
+	xnsynch_sleep_on(&heap->synch_base, timeout, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(&task->thread_base, XNRMID))
 		err =3D -EIDRM;	/* Heap deleted while pending. */
Index: xenomai/ksrc/skins/native/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/mutex.c
+++ xenomai/ksrc/skins/native/mutex.c
@@ -375,7 +375,7 @@ int rt_mutex_lock(RT_MUTEX *mutex, RTIME
 		goto unlock_and_exit;
 	}
=20
-	xnsynch_sleep_on(&mutex->synch_base, timeout);
+	xnsynch_sleep_on(&mutex->synch_base, timeout, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(&task->thread_base, XNRMID))
 		err =3D -EIDRM;	/* Mutex deleted while pending. */
Index: xenomai/ksrc/skins/native/queue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/queue.c
+++ xenomai/ksrc/skins/native/queue.c
@@ -813,7 +813,7 @@ ssize_t rt_queue_receive(RT_QUEUE *q, vo
 			goto unlock_and_exit;
 		}
=20
-		xnsynch_sleep_on(&q->synch_base, timeout);
+		xnsynch_sleep_on(&q->synch_base, timeout, XNTIMER_RELATIVE);
=20
 		task =3D xeno_current_task();
=20
Index: xenomai/ksrc/skins/native/sem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/sem.c
+++ xenomai/ksrc/skins/native/sem.c
@@ -377,7 +377,7 @@ int rt_sem_p(RT_SEM *sem, RTIME timeout)
 	else {
 		RT_TASK *task =3D xeno_current_task();
=20
-		xnsynch_sleep_on(&sem->synch_base, timeout);
+		xnsynch_sleep_on(&sem->synch_base, timeout, XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(&task->thread_base, XNRMID))
 			err =3D -EIDRM;	/* Semaphore deleted while pending. */
Index: xenomai/ksrc/skins/native/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/syscall.c
+++ xenomai/ksrc/skins/native/syscall.c
@@ -2976,7 +2976,7 @@ static int __rt_alarm_wait(struct task_s
 		/* Renice the waiter above all regular tasks if needed. */
 		xnpod_renice_thread(&task->thread_base, XNCORE_IRQ_PRIO);
=20
-	xnsynch_sleep_on(&alarm->synch_base, XN_INFINITE);
+	xnsynch_sleep_on(&alarm->synch_base, XN_INFINITE, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(&task->thread_base, XNRMID))
 		err =3D -EIDRM;	/* Alarm deleted while pending. */
@@ -3219,7 +3219,7 @@ static int __rt_intr_wait(struct task_st
 			xnpod_renice_thread(&task->thread_base,
 					    XNCORE_IRQ_PRIO);
=20
-		xnsynch_sleep_on(&intr->synch_base, timeout);
+		xnsynch_sleep_on(&intr->synch_base, timeout, XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(&task->thread_base, XNRMID))
 			err =3D -EIDRM;	/* Interrupt object deleted while pending. */
Index: xenomai/ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/task.c
+++ xenomai/ksrc/skins/native/task.c
@@ -111,7 +111,8 @@ int __native_task_safewait(RT_TASK *task
 	cstamp =3D task->cstamp;
=20
 	do {
-		xnsynch_sleep_on(&task->safesynch, TM_INFINITE);
+		xnsynch_sleep_on(&task->safesynch, TM_INFINITE,
+				 XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags
 		    (&xeno_current_task()->thread_base, XNBREAK))
@@ -439,7 +440,7 @@ int rt_task_suspend(RT_TASK *task)
=20
 	if (task->suspend_depth++ =3D=3D 0)
 		xnpod_suspend_thread(&task->thread_base, XNSUSP, XN_INFINITE,
-				     NULL);
+				     XNTIMER_RELATIVE, NULL);
       unlock_and_exit:
=20
 	xnlock_put_irqrestore(&nklock, s);
@@ -932,7 +933,7 @@ int rt_task_sleep(RTIME delay)
 	   implicitely calls the rescheduling procedure. */
=20
 	xnpod_suspend_thread(&xeno_current_task()->thread_base,
-			     XNDELAY, delay, NULL);
+			     XNDELAY, delay, XNTIMER_RELATIVE, NULL);
=20
 	return xnthread_test_flags(&xeno_current_task()->thread_base,
 				   XNBREAK) ? -EINTR : 0;
@@ -981,7 +982,6 @@ int rt_task_sleep(RTIME delay)
 int rt_task_sleep_until(RTIME date)
 {
 	int err =3D 0;
-	SRTIME delay;
 	spl_t s;
=20
 	if (xnpod_unblockable_p())
@@ -995,11 +995,9 @@ int rt_task_sleep_until(RTIME date)
 	/* Calling the suspension service on behalf of the current task
 	   implicitely calls the rescheduling procedure. */
=20
-	delay =3D date - xnpod_get_time();
-
-	if (delay > 0) {
+	if (date > xnpod_get_time()) {
 		xnpod_suspend_thread(&xeno_current_task()->thread_base,
-				     XNDELAY, delay, NULL);
+				     XNDELAY, date, XNTIMER_ABSOLUTE, NULL);
=20
 		if (xnthread_test_flags
 		    (&xeno_current_task()->thread_base, XNBREAK))
@@ -1764,7 +1762,7 @@ ssize_t rt_task_send(RT_TASK *task,
 	   required by the priority inheritance protocol
 	   (i.e. prio(sender) > prio(receiver)). */
=20
-	xnsynch_sleep_on(&task->msendq, timeout);
+	xnsynch_sleep_on(&task->msendq, timeout, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(&sender->thread_base, XNRMID))
 		err =3D -EIDRM;	/* Receiver deleted while pending. */
@@ -1924,7 +1922,7 @@ int rt_task_receive(RT_TASK_MCB *mcb_r,=20
 	/* Wait on our receive slot for some sender to enqueue itself in
 	   our send queue. */
=20
-	xnsynch_sleep_on(&receiver->mrecv, timeout);
+	xnsynch_sleep_on(&receiver->mrecv, timeout, XNTIMER_RELATIVE);
=20
 	/* XNRMID cannot happen, since well, the current task would be the
 	   deleted object, so... */
Index: xenomai/ksrc/skins/posix/clock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/clock.c
+++ xenomai/ksrc/skins/posix/clock.c
@@ -246,7 +246,8 @@ int clock_nanosleep(clockid_t clock_id,
=20
 	thread_cancellation_point(cur);
=20
-	xnpod_suspend_thread(cur, XNDELAY, timeout + 1, NULL);
+	xnpod_suspend_thread(cur, XNDELAY, timeout + 1,
+			     XNTIMER_RELATIVE, NULL);
=20
 	thread_cancellation_point(cur);
=20
Index: xenomai/ksrc/skins/posix/cond.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/cond.c
+++ xenomai/ksrc/skins/posix/cond.c
@@ -289,7 +289,7 @@ int pse51_cond_timedwait_internal(struct
 	}
=20
 	/* Wait for another thread to signal the condition. */
-	xnsynch_sleep_on(&cond->synchbase, to);
+	xnsynch_sleep_on(&cond->synchbase, to, XNTIMER_RELATIVE);
=20
 	/* There are four possible wakeup conditions :
 	   - cond_signal / cond_broadcast, no status bit is set, and the functi=
on
Index: xenomai/ksrc/skins/posix/mq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/mq.c
+++ xenomai/ksrc/skins/posix/mq.c
@@ -581,7 +581,7 @@ static int pse51_mq_timedsend_inner(mqd_
=20
 		thread_cancellation_point(cur);
=20
-		xnsynch_sleep_on(&mq->senders, to);
+		xnsynch_sleep_on(&mq->senders, to, XNTIMER_RELATIVE);
=20
 		thread_cancellation_point(cur);
=20
@@ -643,7 +643,7 @@ static int pse51_mq_timedrcv_inner(mqd_t
=20
 		thread_cancellation_point(cur);
=20
-		xnsynch_sleep_on(&mq->receivers, to);
+		xnsynch_sleep_on(&mq->receivers, to, XNTIMER_RELATIVE);
=20
 		thread_cancellation_point(cur);
=20
Index: xenomai/ksrc/skins/posix/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/mutex.c
+++ xenomai/ksrc/skins/posix/mutex.c
@@ -214,7 +214,7 @@ int pse51_mutex_timedlock_break(struct _
 				if (err)
 					break;
=20
-				xnsynch_sleep_on(&mutex->synchbase, to);
+				xnsynch_sleep_on(&mutex->synchbase, to, XNTIMER_RELATIVE);
=20
 				if (xnthread_test_flags(cur, XNBREAK)) {
 					err =3D EINTR;
Index: xenomai/ksrc/skins/posix/mutex.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/mutex.h
+++ xenomai/ksrc/skins/posix/mutex.h
@@ -87,7 +87,7 @@ static inline int mutex_timedlock_intern
             if (err)
                 return err;
            =20
-            xnsynch_sleep_on(&mutex->synchbase, to);
+            xnsynch_sleep_on(&mutex->synchbase, to, XNTIMER_RELATIVE);
            =20
             if (xnthread_test_flags(cur, XNBREAK))
                 return EINTR;
Index: xenomai/ksrc/skins/posix/registry.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/registry.c
+++ xenomai/ksrc/skins/posix/registry.c
@@ -179,7 +179,8 @@ int pse51_node_get(pse51_node_t ** nodep
 				return EPERM;
 			}
=20
-			xnsynch_sleep_on(node->completion_synch, XN_INFINITE);
+			xnsynch_sleep_on(node->completion_synch, XN_INFINITE,
+					 XNTIMER_RELATIVE);
=20
 			cur =3D xnpod_current_thread();
=20
Index: xenomai/ksrc/skins/posix/sem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/sem.c
+++ xenomai/ksrc/skins/posix/sem.c
@@ -537,7 +537,7 @@ static inline int sem_timedwait_internal
=20
 	thread_cancellation_point(cur);
=20
-	xnsynch_sleep_on(&sem->synchbase, to);
+	xnsynch_sleep_on(&sem->synchbase, to, XNTIMER_RELATIVE);
=20
 	/* Handle cancellation requests. */
 	thread_cancellation_point(cur);
Index: xenomai/ksrc/skins/posix/signal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/signal.c
+++ xenomai/ksrc/skins/posix/signal.c
@@ -835,7 +835,8 @@ static int pse51_sigtimedwait_inner(cons
=20
 		thread_cancellation_point(&thread->threadbase);
=20
-		xnpod_suspend_thread(&thread->threadbase, XNDELAY, to, NULL);
+		xnpod_suspend_thread(&thread->threadbase, XNDELAY, to,
+				     XNTIMER_RELATIVE, NULL);
=20
 		thread_cancellation_point(&thread->threadbase);
=20
Index: xenomai/ksrc/skins/posix/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/syscall.c
+++ xenomai/ksrc/skins/posix/syscall.c
@@ -2137,7 +2137,7 @@ static int __intr_wait(struct task_struc
 			/* Renice the waiter above all regular threads if needed. */
 			xnpod_renice_thread(thread, XNCORE_IRQ_PRIO);
=20
-		xnsynch_sleep_on(&intr->synch_base, timeout);
+		xnsynch_sleep_on(&intr->synch_base, timeout, XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(thread, XNRMID))
 			err =3D -EIDRM;	/* Interrupt object deleted while pending. */
Index: xenomai/ksrc/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/thread.c
+++ xenomai/ksrc/skins/posix/thread.c
@@ -414,7 +414,8 @@ int pthread_join(pthread_t thread, void=20
=20
 		thread_cancellation_point(cur);
=20
-		xnsynch_sleep_on(&thread->join_synch, XN_INFINITE);
+		xnsynch_sleep_on(&thread->join_synch, XN_INFINITE,
+				 XNTIMER_RELATIVE);
=20
 		is_last_joiner =3D
 		    xnsynch_wakeup_one_sleeper(&thread->join_synch) =3D=3D NULL;
Index: xenomai/ksrc/skins/psos+/event.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/psos+/event.c
+++ xenomai/ksrc/skins/psos+/event.c
@@ -71,7 +71,7 @@ u_long ev_receive(u_long events, u_long=20
=20
 	psos_current_task()->waitargs.evgroup.flags =3D flags;
 	psos_current_task()->waitargs.evgroup.events =3D events;
-	xnsynch_sleep_on(&evgroup->synchbase, timeout);
+	xnsynch_sleep_on(&evgroup->synchbase, timeout, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(&psos_current_task()->threadbase, XNTIMEO)) {
 		*events_r =3D psos_current_task()->waitargs.evgroup.events;
Index: xenomai/ksrc/skins/psos+/queue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/psos+/queue.c
+++ xenomai/ksrc/skins/psos+/queue.c
@@ -365,7 +365,7 @@ static u_long q_receive_internal(u_long=20
 		xnarch_post_graph_if(&queue->synchbase, 1,	/* PENDED */
 				     xnsynch_nsleepers(&queue->synchbase) =3D=3D 0);
=20
-		xnsynch_sleep_on(&queue->synchbase, timeout);
+		xnsynch_sleep_on(&queue->synchbase, timeout, XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags
 		    (&psos_current_task()->threadbase, XNRMID)) {
Index: xenomai/ksrc/skins/psos+/rn.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/psos+/rn.c
+++ xenomai/ksrc/skins/psos+/rn.c
@@ -210,7 +210,7 @@ u_long rn_getseg(u_long rnid,
 		caller =3D psos_current_task();
 		caller->waitargs.region.size =3D size;
 		caller->waitargs.region.chunk =3D NULL;
-		xnsynch_sleep_on(&rn->synchbase, timeout);
+		xnsynch_sleep_on(&rn->synchbase, timeout, XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(&caller->threadbase, XNRMID))
 			err =3D ERR_RNKILLD;	/* Region deleted while pending. */
Index: xenomai/ksrc/skins/psos+/sem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/psos+/sem.c
+++ xenomai/ksrc/skins/psos+/sem.c
@@ -178,7 +178,7 @@ u_long sm_p(u_long smid, u_long flags, u
 		if (sem->count > 0)
 			sem->count--;
 		else {
-			xnsynch_sleep_on(&sem->synchbase, timeout);
+			xnsynch_sleep_on(&sem->synchbase, timeout, XNTIMER_RELATIVE);
=20
 			if (xnthread_test_flags
 			    (&psos_current_task()->threadbase, XNRMID))
Index: xenomai/ksrc/skins/psos+/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/psos+/task.c
+++ xenomai/ksrc/skins/psos+/task.c
@@ -410,7 +410,8 @@ u_long t_suspend(u_long tid)
 		goto unlock_and_exit;
 	}
=20
-	xnpod_suspend_thread(&task->threadbase, XNSUSP, XN_INFINITE, NULL);
+	xnpod_suspend_thread(&task->threadbase, XNSUSP, XN_INFINITE,
+			     XNTIMER_RELATIVE, NULL);
=20
       unlock_and_exit:
=20
Index: xenomai/ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/rtdm/drvlib.c
+++ xenomai/ksrc/skins/rtdm/drvlib.c
@@ -329,7 +329,8 @@ int rtdm_task_sleep(uint64_t delay)
=20
     XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
=20
-    xnpod_suspend_thread(thread, XNDELAY, xnpod_ns2ticks(delay), NULL);
+    xnpod_suspend_thread(thread, XNDELAY, xnpod_ns2ticks(delay),
+                         XNTIMER_RELATIVE, NULL);
=20
     return xnthread_test_flags(thread, XNBREAK) ? -EINTR : 0;
 }
@@ -362,27 +363,14 @@ EXPORT_SYMBOL(rtdm_task_sleep);
 int rtdm_task_sleep_until(uint64_t wakeup_time)
 {
     xnthread_t  *thread =3D xnpod_current_thread();
-    xnsticks_t  delay;
-    spl_t       s;
-    int         err =3D 0;
=20
=20
     XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
=20
-    xnlock_get_irqsave(&nklock, s);
-
-    delay =3D xnpod_ns2ticks(wakeup_time) - xnpod_get_time();
-
-    if (likely(delay > 0)) {
-        xnpod_suspend_thread(thread, XNDELAY, delay, NULL);
-
-        if (xnthread_test_flags(thread, XNBREAK))
-            err =3D -EINTR;
-    }
-
-    xnlock_put_irqrestore(&nklock, s);
+    xnpod_suspend_thread(thread, XNDELAY, xnpod_ns2ticks(wakeup_time),
+                         XNTIMER_ABSOLUTE, NULL);
=20
-    return err;
+    return xnthread_test_flags(thread, XNBREAK) ? -EINTR : 0;
 }
=20
 EXPORT_SYMBOL(rtdm_task_sleep_until);
@@ -704,15 +692,12 @@ int rtdm_event_timedwait(rtdm_event_t *e
=20
         if (timeout_seq && (timeout > 0)) {
             /* timeout sequence */
-            timeout =3D *timeout_seq - xnpod_get_time();
-            if (unlikely(timeout <=3D 0)) {
-                err =3D -ETIMEDOUT;
-                goto unlock_out;
-            }
-            xnsynch_sleep_on(&event->synch_base, timeout);
+            xnsynch_sleep_on(&event->synch_base, *timeout_seq,
+                             XNTIMER_ABSOLUTE);
         } else {
             /* infinite or relative timeout */
-            xnsynch_sleep_on(&event->synch_base, xnpod_ns2ticks(timeout)=
);
+            xnsynch_sleep_on(&event->synch_base, xnpod_ns2ticks(timeout)=
,
+                             XNTIMER_RELATIVE);
         }
=20
         thread =3D xnpod_current_thread();
@@ -905,15 +890,12 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem,=20
     else {
         if (timeout_seq && (timeout > 0)) {
             /* timeout sequence */
-            timeout =3D *timeout_seq - xnpod_get_time();
-            if (unlikely(timeout <=3D 0)) {
-                err =3D -ETIMEDOUT;
-                goto unlock_out;
-            }
-            xnsynch_sleep_on(&sem->synch_base, timeout);
+            xnsynch_sleep_on(&sem->synch_base, *timeout_seq,
+                             XNTIMER_ABSOLUTE);
         } else {
             /* infinite or relative timeout */
-            xnsynch_sleep_on(&sem->synch_base, xnpod_ns2ticks(timeout));=

+            xnsynch_sleep_on(&sem->synch_base, xnpod_ns2ticks(timeout),
+                             XNTIMER_RELATIVE);
         }
=20
         thread =3D xnpod_current_thread();
@@ -928,7 +910,6 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem,=20
         }
     }
=20
- unlock_out:
     xnlock_put_irqrestore(&nklock, s);
=20
     return err;
@@ -1133,15 +1114,12 @@ int rtdm_mutex_timedlock(rtdm_mutex_t *m
      restart:
         if (timeout_seq && (timeout > 0)) {
             /* timeout sequence */
-            timeout =3D *timeout_seq - xnpod_get_time();
-            if (unlikely(timeout <=3D 0)) {
-                err =3D -ETIMEDOUT;
-                goto unlock_out;
-            }
-            xnsynch_sleep_on(&mutex->synch_base, timeout);
+            xnsynch_sleep_on(&mutex->synch_base, *timeout_seq,
+                             XNTIMER_ABSOLUTE);
         } else {
             /* infinite or relative timeout */
-            xnsynch_sleep_on(&mutex->synch_base, xnpod_ns2ticks(timeout)=
);
+            xnsynch_sleep_on(&mutex->synch_base, xnpod_ns2ticks(timeout)=
,
+                             XNTIMER_RELATIVE);
         }
=20
         if (unlikely(xnthread_test_flags(thread, XNTIMEO|XNRMID|XNBREAK)=
)) {
Index: xenomai/ksrc/skins/uitron/flag.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/uitron/flag.c
+++ xenomai/ksrc/skins/uitron/flag.c
@@ -254,7 +254,7 @@ static ER wai_flg_helper(UINT *p_flgptn,
 	else {
 		task =3D ui_current_task();
=20
-		xnsynch_sleep_on(&flg->synchbase, timeout);
+		xnsynch_sleep_on(&flg->synchbase, timeout, XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(&task->threadbase, XNRMID))
 			err =3D E_DLT;	/* Flag deleted while pending. */
Index: xenomai/ksrc/skins/uitron/mbx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/uitron/mbx.c
+++ xenomai/ksrc/skins/uitron/mbx.c
@@ -223,7 +223,7 @@ static ER rcv_msg_helper(T_MSG ** ppk_ms
 	else {
 		task =3D ui_current_task();
=20
-		xnsynch_sleep_on(&mbx->synchbase, timeout);
+		xnsynch_sleep_on(&mbx->synchbase, timeout, XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(&task->threadbase, XNRMID))
 			err =3D E_DLT;	/* Flag deleted while pending. */
Index: xenomai/ksrc/skins/uitron/sem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/uitron/sem.c
+++ xenomai/ksrc/skins/uitron/sem.c
@@ -205,7 +205,7 @@ static ER wai_sem_helper(ID semid, TMO t
 	else {
 		task =3D ui_current_task();
=20
-		xnsynch_sleep_on(&sem->synchbase, timeout);
+		xnsynch_sleep_on(&sem->synchbase, timeout, XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(&task->threadbase, XNRMID))
 			err =3D E_DLT;	/* Semaphore deleted while pending. */
Index: xenomai/ksrc/skins/uitron/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/uitron/task.c
+++ xenomai/ksrc/skins/uitron/task.c
@@ -226,7 +226,7 @@ void ext_tsk(void)
 	}
=20
 	xnpod_suspend_thread(&ui_current_task()->threadbase,
-			     XNDORMANT, XN_INFINITE, NULL);
+			     XNDORMANT, XN_INFINITE, XNTIMER_RELATIVE, NULL);
 }
=20
 void exd_tsk(void)
@@ -269,7 +269,8 @@ static void ter_tsk_helper(uitask_t * ta
=20
 	xnpod_unblock_thread(&task->threadbase);
=20
-	xnpod_suspend_thread(&task->threadbase, XNDORMANT, XN_INFINITE, NULL);
+	xnpod_suspend_thread(&task->threadbase, XNDORMANT, XN_INFINITE,
+			     XNTIMER_RELATIVE, NULL);
 	xnlock_put_irqrestore(&nklock, s);
 }
=20
@@ -556,8 +557,8 @@ ER sus_tsk(ID tskid)
 	}
=20
 	if (task->suspcnt++ =3D=3D 0)
-		xnpod_suspend_thread(&task->threadbase,
-				     XNSUSP, XN_INFINITE, NULL);
+		xnpod_suspend_thread(&task->threadbase, XNSUSP,
+				     XN_INFINITE, XNTIMER_RELATIVE, NULL);
 	xnlock_put_irqrestore(&nklock, s);
=20
 	return E_OK;
@@ -633,7 +634,8 @@ ER slp_tsk(void)
=20
 	xnthread_set_flags(&task->threadbase, uITRON_TASK_SLEEP);
=20
-	xnpod_suspend_thread(&task->threadbase, XNDELAY, XN_INFINITE, NULL);
+	xnpod_suspend_thread(&task->threadbase, XNDELAY, XN_INFINITE,
+			     XNTIMER_RELATIVE, NULL);
=20
 	xnthread_clear_flags(&task->threadbase, uITRON_TASK_SLEEP);
=20
@@ -674,7 +676,8 @@ ER tslp_tsk(TMO tmout)
=20
 	xnthread_set_flags(&task->threadbase, uITRON_TASK_SLEEP);
=20
-	xnpod_suspend_thread(&task->threadbase, XNDELAY, tmout, NULL);
+	xnpod_suspend_thread(&task->threadbase, XNDELAY, tmout,
+			     XNTIMER_RELATIVE, NULL);
=20
 	xnthread_clear_flags(&task->threadbase, uITRON_TASK_SLEEP);
=20
Index: xenomai/ksrc/skins/vrtx/event.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vrtx/event.c
+++ xenomai/ksrc/skins/vrtx/event.c
@@ -252,7 +252,7 @@ int sc_fpend(int evid, long timeout, int
 	/* xnsynch_sleep_on() called for the current thread automatically
 	   reschedules. */
=20
-	xnsynch_sleep_on(&evgroup->synchbase, timeout);
+	xnsynch_sleep_on(&evgroup->synchbase, timeout, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(&task->threadbase, XNBREAK))
 		*errp =3D -EINTR;
Index: xenomai/ksrc/skins/vrtx/mb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vrtx/mb.c
+++ xenomai/ksrc/skins/vrtx/mb.c
@@ -283,7 +283,7 @@ char *sc_pend(char **mboxp, long timeout
 	if (timeout)
 		task->vrtxtcb.TCBSTAT |=3D TBSDELAY;
=20
-	xnsynch_sleep_on(&mb->synchbase, timeout);
+	xnsynch_sleep_on(&mb->synchbase, timeout, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(&task->threadbase, XNBREAK)) {
 		*errp =3D -EINTR;
Index: xenomai/ksrc/skins/vrtx/mx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vrtx/mx.c
+++ xenomai/ksrc/skins/vrtx/mx.c
@@ -267,7 +267,7 @@ void sc_mpend(int mid, unsigned long tim
 		if (timeout)
 			task->vrtxtcb.TCBSTAT |=3D TBSDELAY;
=20
-		xnsynch_sleep_on(&mx->synchbase, timeout);
+		xnsynch_sleep_on(&mx->synchbase, timeout, XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(&task->threadbase, XNBREAK))
 			*errp =3D -EINTR;
Index: xenomai/ksrc/skins/vrtx/queue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vrtx/queue.c
+++ xenomai/ksrc/skins/vrtx/queue.c
@@ -317,7 +317,7 @@ char *sc_qpend(int qid, long timeout, in
 	if (timeout)
 		task->vrtxtcb.TCBSTAT |=3D TBSDELAY;
=20
-	xnsynch_sleep_on(&queue->synchbase, timeout);
+	xnsynch_sleep_on(&queue->synchbase, timeout, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(&task->threadbase, XNBREAK)) {
 		*errp =3D -EINTR;
Index: xenomai/ksrc/skins/vrtx/sem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vrtx/sem.c
+++ xenomai/ksrc/skins/vrtx/sem.c
@@ -242,7 +242,7 @@ void sc_spend(int semid, long timeout, i
 		if (timeout)
 			task->vrtxtcb.TCBSTAT |=3D TBSDELAY;
=20
-		xnsynch_sleep_on(&sem->synchbase, timeout);
+		xnsynch_sleep_on(&sem->synchbase, timeout, XNTIMER_RELATIVE);
=20
 		if (xnthread_test_flags(&task->threadbase, XNBREAK))
 			*errp =3D -EINTR;
Index: xenomai/ksrc/skins/vrtx/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vrtx/task.c
+++ xenomai/ksrc/skins/vrtx/task.c
@@ -419,7 +419,8 @@ void sc_tsuspend(int tid, int opt, int *
 				task->vrtxtcb.TCBSTAT =3D TBSSUSP;
=20
 				xnpod_suspend_thread(&task->threadbase,
-						     XNSUSP, XN_INFINITE, NULL);
+						     XNSUSP, XN_INFINITE,
+						     XNTIMER_RELATIVE, NULL);
 			}
 		}
=20
@@ -450,7 +451,8 @@ void sc_tsuspend(int tid, int opt, int *
=20
 	*errp =3D RET_OK;
=20
-	xnpod_suspend_thread(&task->threadbase, XNSUSP, XN_INFINITE, NULL);
+	xnpod_suspend_thread(&task->threadbase, XNSUSP, XN_INFINITE,
+			     XNTIMER_RELATIVE, NULL);
       unlock_and_exit:
=20
 	xnlock_put_irqrestore(&nklock, s);
Index: xenomai/ksrc/skins/vxworks/msgQLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vxworks/msgQLib.c
+++ xenomai/ksrc/skins/vxworks/msgQLib.c
@@ -289,7 +289,8 @@ int msgQReceive(MSG_Q_ID qid, char *buf,
 		task->rcv_buf =3D buf;
 		task->rcv_bytes =3D bytes;
=20
-		xnsynch_sleep_on(&queue->synchbase, timeout);
+		xnsynch_sleep_on(&queue->synchbase, timeout,
+				 XNTIMER_RELATIVE);
=20
 		error_check(xnthread_test_flags(thread, XNBREAK), -EINTR,
 			    goto error);
@@ -364,7 +365,8 @@ STATUS msgQSend(MSG_Q_ID qid, const char
 			else
 				timeout =3D to;
=20
-			xnsynch_sleep_on(&queue->synchbase, timeout);
+			xnsynch_sleep_on(&queue->synchbase, timeout,
+					 XNTIMER_RELATIVE);
=20
 			error_check(xnthread_test_flags(thread, XNBREAK),
 				    -EINTR, goto error);
Index: xenomai/ksrc/skins/vxworks/semLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vxworks/semLib.c
+++ xenomai/ksrc/skins/vxworks/semLib.c
@@ -270,7 +270,7 @@ static STATUS semb_take(wind_sem_t *sem,
 		error_check(to =3D=3D XN_NONBLOCK, S_objLib_OBJ_UNAVAILABLE,
 			    return ERROR);
=20
-		xnsynch_sleep_on(&sem->synchbase, to);
+		xnsynch_sleep_on(&sem->synchbase, to, XNTIMER_RELATIVE);
=20
 		error_check(xnthread_test_flags(thread, XNBREAK), -EINTR,
 			    return ERROR);
@@ -345,7 +345,7 @@ static STATUS semm_take(wind_sem_t *sem,
 		error_check(to =3D=3D XN_NONBLOCK, S_objLib_OBJ_UNAVAILABLE,
 			    return ERROR);
=20
-		xnsynch_sleep_on(&sem->synchbase, to);
+		xnsynch_sleep_on(&sem->synchbase, to, XNTIMER_RELATIVE);
=20
 		error_check(xnthread_test_flags(thread, XNBREAK), -EINTR,
 			    return ERROR);
Index: xenomai/ksrc/skins/vxworks/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vxworks/syscall.c
+++ xenomai/ksrc/skins/vxworks/syscall.c
@@ -1166,7 +1166,7 @@ static int __wind_wd_wait(struct task_st
 		/* Renice the waiter above all regular tasks if needed. */
 		xnpod_renice_thread(&pTcb->threadbase, XNCORE_IRQ_PRIO);
=20
-	xnsynch_sleep_on(&wd->synchbase, XN_INFINITE);
+	xnsynch_sleep_on(&wd->synchbase, XN_INFINITE, XNTIMER_RELATIVE);
=20
 	if (xnthread_test_flags(&pTcb->threadbase, XNRMID))
 		err =3D -EIDRM;	/* Watchdog deleted while pending. */
Index: xenomai/ksrc/skins/vxworks/taskLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vxworks/taskLib.c
+++ xenomai/ksrc/skins/vxworks/taskLib.c
@@ -319,7 +319,8 @@ STATUS taskSuspend(TASK_ID task_id)
 	check_OBJ_ID_ERROR(task_id, wind_task_t, task, WIND_TASK_MAGIC,
 			   goto error);
=20
-	xnpod_suspend_thread(&task->threadbase, XNSUSP, XN_INFINITE, NULL);
+	xnpod_suspend_thread(&task->threadbase, XNSUSP, XN_INFINITE,
+			     XNTIMER_RELATIVE, NULL);
=20
 	xnlock_put_irqrestore(&nklock, s);
=20
@@ -564,7 +565,8 @@ TASK_ID taskNameToId(const char *name)
 static int testSafe(wind_task_t *task)
 {
 	while (task->safecnt > 0) {
-		xnsynch_sleep_on(&task->safesync, XN_INFINITE);
+		xnsynch_sleep_on(&task->safesync, XN_INFINITE,
+				 XNTIMER_RELATIVE);
 		error_check(xnthread_test_flags(&task->threadbase, XNBREAK),
 			    -EINTR, return ERROR);
 	}

--------------040207080902020907080704--

--------------enigA77943EDDE0EB0050D19343D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE0Z5CniDOoMHTA+kRAuPrAJ9ndLaBc0i5HHnvGE0qEtNfHNbNDQCeOkTC
9vWWwakDXDO3TcAAXYlH02g=
=sPZY
-----END PGP SIGNATURE-----

--------------enigA77943EDDE0EB0050D19343D--

