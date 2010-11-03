Message-ID: <4CD1E890.5010702@domain.hid>
Date: Wed, 03 Nov 2010 23:56:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>	<4CC94E0B.9070106@domain.hid>	<4CCEF104.7050409@domain.hid>	<4CD11AB1.8090407@domain.hid>	<4CD13A70.8040702@domain.hid>	<4CD14B1E.4000707@domain.hid>	<4CD14C92.90901@domain.hid>	<4CD14DBC.3060505@domain.hid>	<4CD1509A.3000908@domain.hid>	<4CD152F3.4080203@domain.hid>	<4CD16654.6080704@domain.hid>	<4CD18782.7090607@domain.hid>
	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>
	<4CD1BA29.9000303@domain.hid>
	<1288816871.1842.84.camel@domain.hid> <4CD1DC1B.8060407@domain.hid>
	<4CD1DE12.5010309@domain.hid>
In-Reply-To: <4CD1DE12.5010309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB3DC099FD973D92E09F05B1B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Anders Blomdell <anders.blomdell@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3DC099FD973D92E09F05B1B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 03.11.2010 23:11, Jan Kiszka wrote:
> Am 03.11.2010 23:03, Jan Kiszka wrote:
>> But we not not always use atomic ops for manipulating status bits (but=

>> we do in other cases where this is no need - different story). This ma=
y
>> fix the race:
>=20
> Err, nonsense. As we manipulate xnsched::status also outside of nklock
> protection, we must _always_ use atomic ops.
>=20
> This screams for a cleanup: local-only bits like XNHTICK or XNINIRQ
> should be pushed in a separate status word that can then be safely
> modified non-atomically.

Second try to fix and clean up the sched status bits. Anders, please
test.

Jan

diff --git a/include/nucleus/pod.h b/include/nucleus/pod.h
index 01ff0a7..5987a1f 100644
--- a/include/nucleus/pod.h
+++ b/include/nucleus/pod.h
@@ -277,12 +277,10 @@ static inline void xnpod_schedule(void)
 	 * context is active, or if we are caught in the middle of a
 	 * unlocked context switch.
 	 */
-#if XENO_DEBUG(NUCLEUS)
 	if (testbits(sched->status, XNKCOUT|XNINIRQ|XNSWLOCK))
 		return;
-#else /* !XENO_DEBUG(NUCLEUS) */
-	if (testbits(sched->status,
-		     XNKCOUT|XNINIRQ|XNSWLOCK|XNRESCHED) !=3D XNRESCHED)
+#if !XENO_DEBUG(NUCLEUS)
+	if (!sched->resched)
 		return;
 #endif /* !XENO_DEBUG(NUCLEUS) */
=20
diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
index df56417..1850208 100644
--- a/include/nucleus/sched.h
+++ b/include/nucleus/sched.h
@@ -44,7 +44,6 @@
 #define XNINTCK		0x10000000	/* In master tick handler context */
 #define XNINIRQ		0x08000000	/* In IRQ handling context */
 #define XNSWLOCK	0x04000000	/* In context switch */
-#define XNRESCHED	0x02000000	/* Needs rescheduling */
 #define XNHDEFER	0x01000000	/* Host tick deferred */
=20
 struct xnsched_rt {
@@ -63,7 +62,8 @@ typedef struct xnsched {
 	xnflags_t status;		/*!< Scheduler specific status bitmask. */
 	int cpu;
 	struct xnthread *curr;		/*!< Current thread. */
-	xnarch_cpumask_t resched;	/*!< Mask of CPUs needing rescheduling. */
+	xnarch_cpumask_t remote_resched; /*!< Mask of CPUs needing rescheduling=
=2E */
+	int resched;			/*!< Rescheduling needed. */
=20
 	struct xnsched_rt rt;		/*!< Context of built-in real-time class. */
 #ifdef CONFIG_XENO_OPT_SCHED_TP
@@ -164,30 +164,21 @@ struct xnsched_class {
 #define xnsched_cpu(__sched__)	({ (void)__sched__; 0; })
 #endif /* CONFIG_SMP */
=20
-/* Test all resched flags from the given scheduler mask. */
-static inline int xnsched_resched_p(struct xnsched *sched)
-{
-	return testbits(sched->status, XNRESCHED);
-}
-
-static inline int xnsched_self_resched_p(struct xnsched *sched)
-{
-	return testbits(sched->status, XNRESCHED);
-}
-
 /* Set self resched flag for the given scheduler. */
 #define xnsched_set_self_resched(__sched__) do {		\
-  setbits((__sched__)->status, XNRESCHED);			\
+	(__sched__)->resched =3D 1;				\
 } while (0)
=20
 /* Set specific resched flag into the local scheduler mask. */
 #define xnsched_set_resched(__sched__) do {				\
-  xnsched_t *current_sched =3D xnpod_current_sched();			\
-  setbits(current_sched->status, XNRESCHED);				\
-  if (current_sched !=3D (__sched__))	{				\
-      xnarch_cpu_set(xnsched_cpu(__sched__), current_sched->resched);	\
-      setbits((__sched__)->status, XNRESCHED);				\
-  }									\
+	xnsched_t *current_sched =3D xnpod_current_sched();		\
+	current_sched->resched =3D 1;					\
+	if (current_sched !=3D (__sched__)) {				\
+		xnarch_cpu_set(xnsched_cpu(__sched__),			\
+			       current_sched->remote_resched);		\
+		(__sched__)->resched =3D 1;				\
+		xnarch_memory_barrier();				\
+	}								\
 } while (0)
=20
 void xnsched_zombie_hooks(struct xnthread *thread);
@@ -209,7 +200,7 @@ struct xnsched *xnsched_finish_unlocked_switch(struct=
 xnsched *sched);
 static inline
 int xnsched_maybe_resched_after_unlocked_switch(struct xnsched *sched)
 {
-	return testbits(sched->status, XNRESCHED);
+	return sched->resched;
 }
=20
 #else /* !CONFIG_XENO_HW_UNLOCKED_SWITCH */
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 9e135f3..f7f8b2c 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -284,7 +284,7 @@ void xnpod_schedule_handler(void) /* Called with hw i=
nterrupts off. */
 	trace_xn_nucleus_sched_remote(sched);
 #if defined(CONFIG_SMP) && defined(CONFIG_XENO_OPT_PRIOCPL)
 	if (testbits(sched->status, XNRPICK)) {
-		clrbits(sched->status, XNRPICK);
+		__clrbits(sched->status, XNRPICK);
 		xnshadow_rpi_check();
 	}
 #endif /* CONFIG_SMP && CONFIG_XENO_OPT_PRIOCPL */
@@ -2162,15 +2162,15 @@ static inline void xnpod_switch_to(xnsched_t *sch=
ed,
=20
 static inline int __xnpod_test_resched(struct xnsched *sched)
 {
-	int resched =3D testbits(sched->status, XNRESCHED);
+	int resched =3D sched->resched;
 #ifdef CONFIG_SMP
 	/* Send resched IPI to remote CPU(s). */
-	if (unlikely(xnsched_resched_p(sched))) {
-		xnarch_send_ipi(sched->resched);
-		xnarch_cpus_clear(sched->resched);
+	if (unlikely(resched)) {
+		xnarch_send_ipi(sched->remote_resched);
+		xnarch_cpus_clear(sched->remote_resched);
 	}
 #endif
-	clrbits(sched->status, XNRESCHED);
+	sched->resched =3D 0;
 	return resched;
 }
=20
diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index 04a344e..2effea8 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -152,7 +152,8 @@ void xnsched_init(struct xnsched *sched, int cpu)
 	xntimer_set_name(&sched->htimer, htimer_name);
 	xntimer_set_sched(&sched->htimer, sched);
 	sched->zombie =3D NULL;
-	xnarch_cpus_clear(sched->resched);
+	xnarch_cpus_clear(sched->remote_resched);
+	sched->resched =3D 0;
=20
 	attr.flags =3D XNROOT | XNSTARTED | XNFPU;
 	attr.name =3D root_name;
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index f6bea1a..a3e1372 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -2815,7 +2815,7 @@ static inline void do_setsched_event(struct task_st=
ruct *p, int priority)
 	__xnpod_set_thread_schedparam(thread, &xnsched_class_rt, &param, 0);
 	sched =3D xnpod_current_sched();
=20
-	if (!xnsched_resched_p(sched))
+	if (!sched->resched)
 		return;
=20
 	if (p =3D=3D current &&
diff --git a/ksrc/nucleus/timer.c b/ksrc/nucleus/timer.c
index 1fe3331..1639f28 100644
--- a/ksrc/nucleus/timer.c
+++ b/ksrc/nucleus/timer.c
@@ -97,7 +97,7 @@ void xntimer_next_local_shot(xnsched_t *sched)
 	__clrbits(sched->status, XNHDEFER);
 	timer =3D aplink2timer(h);
 	if (unlikely(timer =3D=3D &sched->htimer)) {
-		if (xnsched_self_resched_p(sched) ||
+		if (sched->resched ||
 		    !xnthread_test_state(sched->curr, XNROOT)) {
 			h =3D xntimerq_it_next(&sched->timerqueue, &it, h);
 			if (h) {


--------------enigB3DC099FD973D92E09F05B1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzR6JYACgkQitSsb3rl5xQXYQCg4xVd1+lHR3gjgE+Pc5WAnVuv
8wMAnj+XHuLcIYkb5yte1uYh00HihEJ6
=mTAe
-----END PGP SIGNATURE-----

--------------enigB3DC099FD973D92E09F05B1B--

