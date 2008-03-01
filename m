Message-ID: <47C92740.9000203@domain.hid>
Date: Sat, 01 Mar 2008 10:52:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C196EF84BE7461CCC3AF152"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix initial rpi_push
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C196EF84BE7461CCC3AF152
Content-Type: multipart/mixed;
 boundary="------------010900050903010404040003"

This is a multi-part message in MIME format.
--------------010900050903010404040003
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[My favorite again... :->]

The initial rpi_push in xnshadow_start takes place for the caller's CPU,
instead of the thread's target CPU.

I haven't fully made up my mind about the practical impact of this bug,
I just came across it the hard way (rpi_push worked on uninitialized
data) while kicking CPUs out of the set that Xenomai shall support. At
least it should cause quite some RPI "confusion" for a while on both
involved CPUs.

Jan

--------------010900050903010404040003
Content-Type: text/x-patch;
 name="fix-initial-rpi_push.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-initial-rpi_push.patch"

---
 ChangeLog             |    5 ++++
 include/nucleus/pod.h |    8 +++----
 ksrc/nucleus/shadow.c |   56 ++++++++++++++++++++++++++-----------------=
-------
 3 files changed, 39 insertions(+), 30 deletions(-)

Index: b/include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/nucleus/pod.h
+++ b/include/nucleus/pod.h
@@ -313,21 +313,21 @@ static inline void xnpod_finalize_zombie
=20
 #define xnpod_idle_p()		xnpod_root_p()
=20
-static inline void xnpod_renice_root(int prio)
+static inline void xnpod_renice_root(int cpu, int prio)
 {
 	xnthread_t *rootcb;
 	spl_t s;
=20
 	xnlock_get_irqsave(&nklock, s);
-	rootcb =3D xnpod_current_root();
+	rootcb =3D &xnpod_sched_slot(cpu)->rootcb;
 	rootcb->cprio =3D prio;
 	xnpod_schedule_runnable(rootcb, XNPOD_SCHEDLIFO | XNPOD_NOSWITCH);
 	xnlock_put_irqrestore(&nklock, s);
 }
=20
-static inline int xnpod_root_priority(void)
+static inline int xnpod_root_priority(int cpu)
 {
-	return xnthread_current_priority(xnpod_current_root());
+	return xnthread_current_priority(&xnpod_sched_slot(cpu)->rootcb);
 }
=20
 int xnpod_init(void);
Index: b/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -198,15 +198,13 @@ static inline void rpi_none(xnthread_t *
 	xnarch_memory_barrier();
 }
=20
-static void rpi_push(xnthread_t *thread)
+static void rpi_push(xnthread_t *thread, int cpu)
 {
-	struct xnrpi *rpislot;
+	struct xnrpi *rpislot =3D &gatekeeper[cpu].rpislot;
 	xnthread_t *top;
 	int prio;
 	spl_t s;
=20
-	rpislot =3D &gatekeeper[rthal_processor_id()].rpislot;
-
 	/* non-RT shadows and RT shadows which disabled RPI cause the
 	   root priority to be lowered to its base level. The purpose
 	   of the following code is to enqueue the just thread
@@ -230,18 +228,17 @@ static void rpi_push(xnthread_t *thread)
 	} else
 		prio =3D XNCORE_IDLE_PRIO;
=20
-	if (xnpod_root_priority() !=3D prio)
-		xnpod_renice_root(prio);
+	if (xnpod_root_priority(cpu) !=3D prio)
+		xnpod_renice_root(cpu, prio);
 }
=20
 static void rpi_pop(xnthread_t *thread)
 {
-	struct xnrpi *rpislot;
+	int cpu =3D rthal_processor_id();
+	struct xnrpi *rpislot =3D &gatekeeper[cpu].rpislot;
 	int prio;
 	spl_t s;
=20
-	rpislot =3D &gatekeeper[rthal_processor_id()].rpislot;
-
 	xnlock_get_irqsave(&rpislot->lock, s);
=20
 	/* Make sure we don't try to unlink a shadow which is not
@@ -267,20 +264,22 @@ static void rpi_pop(xnthread_t *thread)
=20
 	xnlock_put_irqrestore(&rpislot->lock, s);
=20
-	if (xnpod_root_priority() !=3D prio)
-		xnpod_renice_root(prio);
+	if (xnpod_root_priority(cpu) !=3D prio)
+		xnpod_renice_root(cpu, prio);
 }
=20
 static void rpi_update(xnthread_t *thread)
 {
-	struct xnrpi *rpislot;
+	int cpu =3D rthal_processor_id();
+	struct xnrpi *rpislot =3D &gatekeeper[cpu].rpislot;
 	spl_t s;
=20
-	rpislot =3D &gatekeeper[rthal_processor_id()].rpislot;
 	xnlock_get_irqsave(&rpislot->lock, s);
+
 	sched_removepq(&rpislot->threadq, &thread->xlink);
 	rpi_none(thread);
-	rpi_push(thread);
+	rpi_push(thread, cpu);
+
 	xnlock_put_irqrestore(&rpislot->lock, s);
 }
=20
@@ -358,7 +357,7 @@ static void rpi_clear_remote(xnthread_t=20
 static void rpi_migrate(xnthread_t *thread)
 {
 	rpi_clear_remote(thread);
-	rpi_push(thread);
+	rpi_push(thread, rthal_processor_id());
 }
=20
 #else  /* !CONFIG_SMP */
@@ -368,6 +367,7 @@ static void rpi_migrate(xnthread_t *thre
=20
 static inline void rpi_switch(struct task_struct *next)
 {
+	int cpu =3D rthal_processor_id();
 	xnthread_t *threadin, *threadout;
 	struct xnrpi *rpislot;
 	int oldprio, newprio;
@@ -375,8 +375,8 @@ static inline void rpi_switch(struct tas
=20
 	threadout =3D xnshadow_thread(current);
 	threadin =3D xnshadow_thread(next);
-	rpislot =3D &gatekeeper[rthal_processor_id()].rpislot;
-	oldprio =3D xnpod_root_priority();
+	rpislot =3D &gatekeeper[cpu].rpislot;
+	oldprio =3D xnpod_root_priority(cpu);
=20
 	if (threadout &&
 	    current->state !=3D TASK_RUNNING &&
@@ -456,7 +456,7 @@ boost_root:
 	if (newprio =3D=3D oldprio)
 		return;
=20
-	xnpod_renice_root(newprio);
+	xnpod_renice_root(cpu, newprio);
=20
 	if (newprio < oldprio)
 		/* Subtle: by downgrading the root thread priority,
@@ -470,8 +470,9 @@ boost_root:
=20
 static inline void rpi_clear_local(xnthread_t *thread)
 {
-	if (thread =3D=3D NULL && xnpod_root_priority() !=3D XNCORE_IDLE_PRIO)
-		xnpod_renice_root(XNCORE_IDLE_PRIO);
+	int cpu =3D rthal_processor_id();
+	if (thread =3D=3D NULL && xnpod_root_priority(cpu) !=3D XNCORE_IDLE_PRI=
O)
+		xnpod_renice_root(cpu, XNCORE_IDLE_PRIO);
 }
=20
 #ifdef CONFIG_SMP
@@ -483,15 +484,16 @@ void xnshadow_rpi_check(void)
 	 * otherwise, we would have to mask them while testing the
 	 * queue for emptiness _and_ demoting the boost level.
 	 */
-	struct xnrpi *rpislot =3D &gatekeeper[rthal_processor_id()].rpislot;
+	int cpu =3D rthal_processor_id();
+	struct xnrpi *rpislot =3D &gatekeeper[cpu].rpislot;
 	int norpi;
 =20
  	xnlock_get(&rpislot->lock);
  	norpi =3D sched_emptypq_p(&rpislot->threadq);
  	xnlock_put(&rpislot->lock);
=20
-	if (norpi && xnpod_root_priority() !=3D XNCORE_IDLE_PRIO)
-		xnpod_renice_root(XNCORE_IDLE_PRIO);
+	if (norpi && xnpod_root_priority(cpu) !=3D XNCORE_IDLE_PRIO)
+		xnpod_renice_root(cpu, XNCORE_IDLE_PRIO);
 }
=20
 #endif	/* CONFIG_SMP */
@@ -502,7 +504,7 @@ void xnshadow_rpi_check(void)
 #define rpi_init_gk(gk)		do { } while(0)
 #define rpi_clear_local(t)	do { } while(0)
 #define rpi_clear_remote(t)	do { } while(0)
-#define rpi_push(t)		do { } while(0)
+#define rpi_push(t, cpu)	do { } while(0)
 #define rpi_pop(t)		do { } while(0)
 #define rpi_update(t)		do { } while(0)
 #define rpi_switch(n)		do { } while(0)
@@ -1209,7 +1211,7 @@ void xnshadow_relax(int notify)
=20
 	schedule_linux_call(LO_WAKEUP_REQ, current, 0);
=20
-	rpi_push(thread);
+	rpi_push(thread, rthal_processor_id());
=20
 	clear_task_nowakeup(current);
=20
@@ -1469,7 +1471,9 @@ void xnshadow_start(xnthread_t *thread)
 {
 	struct task_struct *p =3D xnthread_archtcb(thread)->user_task;
=20
-	rpi_push(thread);	/* A shadow always starts in relaxed mode. */
+	/* A shadow always starts in relaxed mode. */
+	rpi_push(thread, xnsched_cpu(thread->sched));
+
 	trace_mark(xn_nucleus_shadow_start, "thread %p thread_name %s",
 		   thread, xnthread_name(thread));
 	xnpod_resume_thread(thread, XNDORMANT);
Index: b/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,11 @@
=20
 	* include/asm-generic/system.h (xnlock_put): Add proper barrier.
=20
+	* ksrc/nucleus/shadow.c, include/nucleus/pod.h: Let rpi_push,
+	xnpod_renice_root, and xnpod_root_priority work on specified CPU
+	instead of the current one. Issue rpi_push for the new thread's
+	target CPU in xnshadow_start.
+
 2008-02-15  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
=20
 	* src/skins/posix/thread.c (__wrap_pthread_create): Follow more

--------------010900050903010404040003--

--------------enig8C196EF84BE7461CCC3AF152
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHySdAniDOoMHTA+kRAkNOAJ9u17TkTgBet6tg3+g0abGCD/HsKQCbBFvZ
s2bnWewS/n2q2bux1DqR+Fc=
=DTlO
-----END PGP SIGNATURE-----

--------------enig8C196EF84BE7461CCC3AF152--

