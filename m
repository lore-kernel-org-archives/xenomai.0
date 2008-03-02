Message-ID: <47CA895B.2050005@domain.hid>
Date: Sun, 02 Mar 2008 12:02:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C51A34.203@domain.hid>
In-Reply-To: <47C51A34.203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8AA2C926298C4F2DE10CD848"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 6/6] Allow xnlock debugging on
	single-CPU	systems
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
--------------enig8AA2C926298C4F2DE10CD848
Content-Type: multipart/mixed;
 boundary="------------010005000305010203000506"

This is a multi-part message in MIME format.
--------------010005000305010203000506
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

After all the refactoring, arming xnlock_dbg services also for
!CONFIG_SMP setups was straightforward.


--------------010005000305010203000506
Content-Type: text/x-patch;
 name="xnlock-debugging-for-up.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xnlock-debugging-for-up.patch"

---
 include/asm-generic/bits/pod.h |    4 ++--
 include/asm-generic/system.h   |   31 +++++++++++++++----------------
 ksrc/nucleus/intr.c            |    4 ++--
 ksrc/nucleus/module.c          |   12 ++++++------
 ksrc/nucleus/pod.c             |    4 ++--
 ksrc/skins/posix/signal.c      |    2 +-
 6 files changed, 28 insertions(+), 29 deletions(-)

Index: b/include/asm-generic/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/bits/pod.h
+++ b/include/asm-generic/bits/pod.h
@@ -295,7 +295,7 @@ unsigned long long xnarch_get_cpu_time(v
=20
 EXPORT_SYMBOL(xnarch_get_cpu_time);
=20
-#if defined(CONFIG_SMP) && !defined(CONFIG_XENO_OPT_TICKET_LOCK)
+#if (defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)) && !defined(CONFIG_XENO=
_OPT_TICKET_LOCK)
 void __xnlock_spin(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS)
 {
 	unsigned int spin_limit;
@@ -311,6 +311,6 @@ void __xnlock_spin(xnlock_t *lock /*, */
 		} while(atomic_read(&lock->owner) !=3D ~0);
 }
 EXPORT_SYMBOL(__xnlock_spin);
-#endif /* CONFIG_SMP && !CONFIG_XENO_OPT_TICKET_LOCK */
+#endif /* (CONFIG_SMP || XENO_DEBUG(NUCLEUS)) && !CONFIG_XENO_OPT_TICKET=
_LOCK */
=20
 #endif /* !_XENO_ASM_GENERIC_BITS_POD_H */
Index: b/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -76,11 +76,11 @@ extern "C" {
 typedef unsigned long spl_t;
=20
 #define splhigh(x)  rthal_local_irq_save(x)
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 #define splexit(x)  rthal_local_irq_restore((x) & 1)
-#else /* !CONFIG_SMP */
+#else /* !CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 #define splexit(x)  rthal_local_irq_restore(x)
-#endif /* !CONFIG_SMP */
+#endif /* !CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 #define splnone()   rthal_local_irq_enable()
 #define spltest()   rthal_local_irq_test()
 #define splget(x)   rthal_local_irq_flags(x)
@@ -90,7 +90,7 @@ static inline unsigned xnarch_current_cp
 	return rthal_processor_id();
 }
=20
-#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
+#if XENO_DEBUG(NUCLEUS)
=20
 typedef struct {
=20
@@ -204,7 +204,7 @@ static inline int xnlock_dbg_release(xnl
 	return 0;
 }
=20
-#else /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
+#else /* !XENO_DEBUG(NUCLEUS) */
=20
 #ifdef CONFIG_XENO_OPT_TICKET_LOCK
 typedef struct {
@@ -237,7 +237,7 @@ static inline int xnlock_dbg_release(xnl
 	return 0;
 }
=20
-#endif /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
+#endif /* !XENO_DEBUG(NUCLEUS) */
=20
 #define XNARCH_NR_CPUS			RTHAL_NR_CPUS
=20
@@ -321,7 +321,7 @@ static inline int xnarch_setimask (int i
 	return !!s;
 }
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
=20
 #define xnlock_get(lock)		__xnlock_get(lock  XNLOCK_DBG_CONTEXT)
 #define xnlock_get_irqsave(lock,x) \
@@ -481,17 +481,12 @@ static inline void xnlock_put_irqrestore
 	rthal_local_irq_restore(flags & 1);
 }
=20
-static inline int xnarch_send_ipi(xnarch_cpumask_t cpumask)
-{
-	return rthal_send_ipi(RTHAL_SERVICE_IPI0, cpumask);
-}
-
 static inline int xnlock_is_owner(xnlock_t *lock)
 {
 	return xnlock_owner(lock) =3D=3D xnarch_current_cpu();
 }
=20
-#else /* !CONFIG_SMP */
+#else /* !(CONFIG_SMP || XENO_DEBUG(NUCLEUS)) */
=20
 #define xnlock_init(lock)		do { } while(0)
 #define xnlock_get(lock)		do { } while(0)
@@ -507,12 +502,16 @@ static inline int xnlock_is_owner(xnlock
 #define DEFINE_XNLOCK(lock)
 #define DEFINE_PRIVATE_XNLOCK(lock)
=20
-static inline int xnarch_send_ipi (xnarch_cpumask_t cpumask)
+#endif /* !(CONFIG_SMP || XENO_DEBUG(NUCLEUS)) */
+
+static inline int xnarch_send_ipi(xnarch_cpumask_t cpumask)
 {
+#ifdef CONFIG_SMP
+	return rthal_send_ipi(RTHAL_SERVICE_IPI0, cpumask);
+#else /* !CONFIG_SMP */
 	return 0;
-}
-
 #endif /* !CONFIG_SMP */
+}
=20
 #define xnlock_sync_irq(lock, x)			\
 	do {						\
Index: b/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -387,7 +387,7 @@ static inline int xnintr_irq_detach(xnin
=20
 #else /* !CONFIG_XENO_OPT_SHIRQ */
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 typedef struct xnintr_irq {
=20
 	DECLARE_XNLOCK(lock);
@@ -395,7 +395,7 @@ typedef struct xnintr_irq {
 } ____cacheline_aligned_in_smp xnintr_irq_t;
=20
 static xnintr_irq_t xnirqs[XNARCH_NR_IRQS];
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
=20
 static inline xnintr_t *xnintr_shirq_first(unsigned irq)
 {
Index: b/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -664,7 +664,7 @@ void xnpod_discard_tbase_proc(xntbase_t=20
=20
 #endif /* CONFIG_XENO_OPT_STATS */
=20
-#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
+#if XENO_DEBUG(NUCLEUS)
=20
 xnlockinfo_t xnlock_stats[RTHAL_NR_CPUS];
=20
@@ -712,7 +712,7 @@ static int lock_read_proc(char *page,
=20
 EXPORT_SYMBOL(xnlock_stats);
=20
-#endif /* CONFIG_SMP && XENO_DEBUG(NUCLEUS) */
+#endif /* XENO_DEBUG(NUCLEUS) */
=20
 static int latency_read_proc(char *page,
 			     char **start,
@@ -1033,9 +1033,9 @@ void xnpod_init_proc(void)
 		create_proc_entry("timerstat", S_IFDIR, rthal_proc_root);
 #endif /* CONFIG_XENO_OPT_STATS */
=20
-#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
+#if XENO_DEBUG(NUCLEUS)
 	add_proc_leaf("lock", &lock_read_proc, NULL, NULL, rthal_proc_root);
-#endif /* CONFIG_SMP && XENO_DEBUG(NUCLEUS) */
+#endif /* XENO_DEBUG(NUCLEUS) */
=20
 	add_proc_leaf("latency",
 		      &latency_read_proc,
@@ -1087,9 +1087,9 @@ void xnpod_delete_proc(void)
 	remove_proc_entry("timerstat", rthal_proc_root);
 	remove_proc_entry("stat", rthal_proc_root);
 #endif /* CONFIG_XENO_OPT_STATS */
-#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
+#if XENO_DEBUG(NUCLEUS)
 	remove_proc_entry("lock", rthal_proc_root);
-#endif /* CONFIG_SMP && XENO_DEBUG(NUCLEUS) */
+#endif /* XENO_DEBUG(NUCLEUS) */
 }
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE
Index: b/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -3472,7 +3472,7 @@ EXPORT_SYMBOL(xnpod_welcome_thread);
=20
 EXPORT_SYMBOL(nkpod_struct);
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 EXPORT_SYMBOL(nklock);
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 EXPORT_SYMBOL(nklatency);
Index: b/ksrc/skins/posix/signal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/signal.c
+++ b/ksrc/skins/posix/signal.c
@@ -64,7 +64,7 @@ typedef void siginfo_handler_t(int, sigi
 #define SIGRTMAX 64
 static struct sigaction actions[SIGRTMAX];
 static pse51_siginfo_t pse51_infos_pool[PSE51_SIGQUEUE_MAX];
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 static xnlock_t pse51_infos_lock =3D XNARCH_LOCK_UNLOCKED;
 #endif
 static xnpqueue_t pse51_infos_free_list;


--------------010005000305010203000506--

--------------enig8AA2C926298C4F2DE10CD848
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHyolbniDOoMHTA+kRAgouAJ9quhCKUnw+AgEJta1xOBnzhxvtSgCePZG3
89HKoaxWn0Xi+/mxISapo0g=
=sYlt
-----END PGP SIGNATURE-----

--------------enig8AA2C926298C4F2DE10CD848--

