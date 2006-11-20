Message-ID: <456236D2.3050402@domain.hid>
Date: Tue, 21 Nov 2006 00:14:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3DB96D859783C2AAF4443D46"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/3] decouple spinlock stats from
	XENO_OPT_STATS
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
--------------enig3DB96D859783C2AAF4443D46
Content-Type: multipart/mixed; boundary="------------070505080100050102020809"

This is a multi-part message in MIME format.
--------------070505080100050102020809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

As recently discussed, the current implicit coupling of spinlock
statistics/debugging with the XENO_OPT_STATS switch is suboptimal. The
reason: on SMP, it adds noticeable overhead to the STATS feature which
may only be used for thread statistics collection (as also advertised in
the kconfig help).

This patch makes the spinlock debugging and lock length collection
feature only depend on XENO_OPT_DEBUG (as a first step).

Jan


--------------070505080100050102020809
Content-Type: text/x-patch;
 name="decouple-spinlock-dbg-from-stats.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="decouple-spinlock-dbg-from-stats.patch"

---
 include/asm-generic/system.h |   35 ++++++++++++++++-------------------
 ksrc/nucleus/module.c        |   22 +++++++++++-----------
 2 files changed, 27 insertions(+), 30 deletions(-)

Index: xenomai/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -71,9 +71,7 @@ typedef unsigned long spl_t;
 #define spltest()   rthal_local_irq_test()
 #define splget(x)   rthal_local_irq_flags(x)
=20
-#if defined(CONFIG_SMP) && \
-    (defined(CONFIG_XENO_OPT_STATS) || defined(CONFIG_XENO_OPT_DEBUG))
-
+#if defined(CONFIG_SMP) && defined(CONFIG_XENO_OPT_DEBUG)
 typedef struct {
=20
         unsigned long long spin_time;
@@ -96,25 +94,24 @@ typedef struct {
=20
 } xnlock_t;
=20
-#define XNARCH_LOCK_UNLOCKED (xnlock_t) {       \
-	{ ~0 },				        \
-        NULL,                                   \
-        NULL,                                   \
-        0,                                      \
-        -1,                                     \
-        0LL,                                    \
-        0LL,                                    \
+#define XNARCH_LOCK_UNLOCKED (xnlock_t) {	\
+	{ ~0 },					\
+	NULL,					\
+	NULL,					\
+	0,					\
+	-1,					\
+	0LL,					\
+	0LL,					\
 }
=20
 #define CONFIG_XENO_SPINLOCK_DEBUG  1
=20
-#else /* !(CONFIG_XENO_OPT_STATS && CONFIG_SMP) */
+#else /* !(CONFIG_SMP && CONFIG_XENO_OPT_DEBUG) */
=20
 typedef struct { atomic_t owner; } xnlock_t;
=20
 #define XNARCH_LOCK_UNLOCKED (xnlock_t) { { ~0 } }
-
-#endif /* CONFIG_XENO_OPT_STATS && CONFIG_SMP */
+#endif /* CONFIG_SMP && CONFIG_XENO_OPT_DEBUG */
=20
 #define XNARCH_NR_CPUS               RTHAL_NR_CPUS
=20
@@ -253,7 +250,7 @@ static inline int __xnlock_get (xnlock_t
 #else /* !CONFIG_XENO_SPINLOCK_DEBUG */
 static inline int __xnlock_get (xnlock_t *lock)
 {
-#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
     rthal_declare_cpuid;
     int recursing;
=20
@@ -304,7 +301,7 @@ static inline void xnlock_put (xnlock_t=20
     rthal_load_cpuid();
     if (likely(atomic_read(&lock->owner) =3D=3D cpuid)) {
=20
-#ifdef CONFIG_XENO_OPT_STATS
+#ifdef CONFIG_XENO_SPINLOCK_DEBUG
 	    extern xnlockinfo_t xnlock_stats[];
=20
 	    unsigned long long lock_time =3D rthal_rdtsc() - lock->lock_date;
@@ -316,7 +313,7 @@ static inline void xnlock_put (xnlock_t=20
 		    xnlock_stats[cpuid].function =3D lock->function;
 		    xnlock_stats[cpuid].line =3D lock->line;
 	    }
-#endif /* CONFIG_XENO_OPT_STATS */
+#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
 	    atomic_set(&lock->owner, ~0);
     }
 #ifdef CONFIG_XENO_SPINLOCK_DEBUG
@@ -343,7 +340,7 @@ static inline spl_t __xnlock_get_irqsave
 #else /* !CONFIG_XENO_SPINLOCK_DEBUG */
 static inline spl_t __xnlock_get_irqsave (xnlock_t *lock)
 {
-#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
     unsigned long flags;
=20
     rthal_local_irq_save(flags);
@@ -354,7 +351,7 @@ static inline spl_t __xnlock_get_irqsave
 #else /* !CONFIG_XENO_SPINLOCK_DEBUG */
     if (__xnlock_get(lock))
 	    flags |=3D 2;
-#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
 =09
     return flags;
 }
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -472,7 +472,9 @@ static struct file_operations stat_seq_o
 	.release =3D seq_release_private,
 };
=20
-#ifdef CONFIG_SMP
+#endif /* CONFIG_XENO_OPT_STATS */
+
+#ifdef CONFIG_XENO_SPINLOCK_DEBUG
=20
 xnlockinfo_t xnlock_stats[RTHAL_NR_CPUS];
=20
@@ -520,9 +522,7 @@ static int lock_read_proc(char *page,
=20
 EXPORT_SYMBOL(xnlock_stats);
=20
-#endif /* CONFIG_SMP */
-
-#endif /* CONFIG_XENO_OPT_STATS */
+#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
=20
 static int latency_read_proc(char *page,
 			     char **start,
@@ -741,12 +741,12 @@ void xnpod_init_proc(void)
=20
 #ifdef CONFIG_XENO_OPT_STATS
 	add_proc_fops("stat", &stat_seq_operations, 0, rthal_proc_root);
-#ifdef CONFIG_SMP
-	add_proc_leaf("lock", &lock_read_proc, NULL, NULL, rthal_proc_root);
-#endif /* CONFIG_SMP */
-
 #endif /* CONFIG_XENO_OPT_STATS */
=20
+#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+	add_proc_leaf("lock", &lock_read_proc, NULL, NULL, rthal_proc_root);
+#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+
 	add_proc_leaf("latency",
 		      &latency_read_proc,
 		      &latency_write_proc, NULL, rthal_proc_root);
@@ -786,10 +786,10 @@ void xnpod_delete_proc(void)
 	remove_proc_entry("sched", rthal_proc_root);
 #ifdef CONFIG_XENO_OPT_STATS
 	remove_proc_entry("stat", rthal_proc_root);
-#ifdef CONFIG_SMP
-	remove_proc_entry("lock", rthal_proc_root);
-#endif /* CONFIG_SMP */
 #endif /* CONFIG_XENO_OPT_STATS */
+#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+	remove_proc_entry("lock", rthal_proc_root);
+#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
 }
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE


--------------070505080100050102020809--

--------------enig3DB96D859783C2AAF4443D46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYjbaniDOoMHTA+kRApq3AJ9V2y47+YL0elM9pXkGy4bEjX46twCghIW3
b7ojbgEjlnLx/qh6LOIJoEg=
=N+0O
-----END PGP SIGNATURE-----

--------------enig3DB96D859783C2AAF4443D46--

