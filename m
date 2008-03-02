Message-ID: <47CA8388.1020800@domain.hid>
Date: Sun, 02 Mar 2008 11:38:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C51A34.203@domain.hid>
In-Reply-To: <47C51A34.203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF18B034DEC02B216E5657CB9"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] [PATCH 1/6] Refactor xnlock debugging
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF18B034DEC02B216E5657CB9
Content-Type: multipart/mixed;
 boundary="------------040103030206090409060600"

This is a multi-part message in MIME format.
--------------040103030206090409060600
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Concentrate all xnlock debugging related code in static inline wrappers
that can easily be switched on and off without visual harm for the lock
services themselves. This does not yet change the debugging logic, it
just saves a few byte text by avoiding redundant processor-id accesses.

--------------040103030206090409060600
Content-Type: text/x-patch;
 name="refactor-xnlock-debugging.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="refactor-xnlock-debugging.patch"

---
 include/asm-generic/system.h |  296 ++++++++++++++++++++++--------------=
-------
 1 file changed, 154 insertions(+), 142 deletions(-)

Index: b/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -47,6 +47,10 @@
 #define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
 #endif
=20
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 /* Time base export */
 #define xnarch_declare_tbase(base)		do { } while(0)
=20
@@ -81,7 +85,13 @@ typedef unsigned long spl_t;
 #define spltest()   rthal_local_irq_test()
 #define splget(x)   rthal_local_irq_flags(x)
=20
-#if defined(CONFIG_SMP) && defined(CONFIG_XENO_OPT_DEBUG)
+static inline unsigned xnarch_current_cpu(void)
+{
+	return rthal_processor_id();
+}
+
+#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
+
 typedef struct {
=20
         unsigned long long spin_time;
@@ -114,12 +124,96 @@ typedef struct {
 	0LL,					\
 }
=20
-#else /* !(CONFIG_SMP && CONFIG_XENO_OPT_DEBUG) */
+#define XNLOCK_DBG_CONTEXT		, __FILE__, __LINE__, __FUNCTION__
+#define XNLOCK_DBG_CONTEXT_ARGS \
+	, const char *file, int line, const char *function
+#define XNLOCK_DBG_PASS_CONTEXT		, file, line, function
+#define XNLOCK_DBG_MAX_SPINS		10000000
+
+static inline void
+xnlock_dbg_prepare_acquire(unsigned long long *start, unsigned *spin_lim=
it)
+{
+	*start =3D rthal_rdtsc();
+	*spin_limit =3D XNLOCK_DBG_MAX_SPINS;
+}
+
+static inline void
+xnlock_dbg_spinning(xnlock_t *lock, int cpu, unsigned int *spin_limit,
+		    const char *file, int line, const char *function)
+{
+	if (--*spin_limit =3D=3D 0) {
+		rthal_emergency_console();
+		printk(KERN_ERR "Xenomai: stuck on nucleus lock %p\n"
+				"         waiter =3D %s:%u (%s(), CPU #%d)\n"
+				"         owner  =3D %s:%u (%s(), CPU #%d)\n",
+		       lock, file, line, function, cpu,
+		       lock->file, lock->line, lock->function, lock->cpu);
+		show_stack(NULL, NULL);
+	}
+}
+
+static inline void
+xnlock_dbg_acquired(xnlock_t *lock, int cpu, unsigned long long *start,
+		    const char *file, int line, const char *function)
+{
+	lock->lock_date =3D *start;
+	lock->spin_time =3D rthal_rdtsc() - *start;
+	lock->file =3D file;
+	lock->function =3D function;
+	lock->line =3D line;
+	lock->cpu =3D cpu;
+}
+
+static inline void xnlock_dbg_release(xnlock_t *lock)
+{
+	extern xnlockinfo_t xnlock_stats[];
+	unsigned long long lock_time =3D rthal_rdtsc() - lock->lock_date;
+	xnlockinfo_t *stats =3D &xnlock_stats[xnarch_current_cpu()];
+
+	lock->cpu =3D -lock->cpu;	/* File that we released it. */
+
+	if (lock_time > stats->lock_time) {
+		stats->lock_time =3D lock_time;
+		stats->spin_time =3D lock->spin_time;
+		stats->file =3D lock->file;
+		stats->function =3D lock->function;
+		stats->line =3D lock->line;
+	}
+}
+
+static inline void xnlock_dbg_invalid_release(xnlock_t *lock)
+{
+	rthal_emergency_console();
+	printk(KERN_ERR "Xenomai: unlocking unlocked nucleus lock %p\n"
+			"       owner  =3D %s:%u (%s(), CPU #%d)\n",
+	       lock, lock->file, lock->line, lock->function, lock->cpu);
+	show_stack(NULL,NULL);
+}
+
+#else /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
=20
 typedef struct { atomic_t owner; } xnlock_t;
=20
 #define XNARCH_LOCK_UNLOCKED (xnlock_t) { { ~0 } }
-#endif /* !(CONFIG_SMP && CONFIG_XENO_OPT_DEBUG) */
+
+#define XNLOCK_DBG_CONTEXT
+#define XNLOCK_DBG_CONTEXT_ARGS
+#define XNLOCK_DBG_PASS_CONTEXT
+
+static inline void
+xnlock_dbg_prepare_acquire(unsigned long long *start, unsigned *spin_lim=
it)
+{ }
+
+static inline void
+xnlock_dbg_spinning(xnlock_t *lock, int cpu, unsigned int *spin_limit)	{=
 }
+
+static inline void
+xnlock_dbg_acquired(xnlock_t *lock, int cpu, unsigned long long *start)	=
{ }
+
+static inline void xnlock_dbg_release(xnlock_t *lock)			{ }
+static inline void xnlock_dbg_invalid_release(xnlock_t *lock)		{ }
+
+#endif /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
=20
 #define XNARCH_NR_CPUS               RTHAL_NR_CPUS
=20
@@ -167,10 +261,6 @@ typedef struct xnarch_heapcb {
=20
 } xnarch_heapcb_t;
=20
-#ifdef __cplusplus
-extern "C" {
-#endif
-
 unsigned long long xnarch_get_host_time(void);
=20
 long long xnarch_tsc_to_ns(long long ts);
@@ -189,11 +279,6 @@ static inline unsigned long long xnarch_
     return RTHAL_CPU_FREQ;
 }
=20
-static inline unsigned xnarch_current_cpu(void)
-{
-    return rthal_processor_id();
-}
-
 #define xnarch_halt(emsg) \
 do { \
     rthal_emergency_console(); \
@@ -213,17 +298,11 @@ static inline int xnarch_setimask (int i
=20
 #ifdef CONFIG_SMP
=20
-#if XENO_DEBUG(NUCLEUS)
-#define xnlock_get(lock) \
-    __xnlock_get(lock, __FILE__, __LINE__,__FUNCTION__)
+#define xnlock_get(lock)		__xnlock_get(lock  XNLOCK_DBG_CONTEXT)
 #define xnlock_get_irqsave(lock,x) \
-    ((x) =3D __xnlock_get_irqsave(lock, __FILE__, __LINE__,__FUNCTION__)=
)
-#else /* !XENO_DEBUG(NUCLEUS) */
-#define xnlock_get(lock)            __xnlock_get(lock)
-#define xnlock_get_irqsave(lock,x)  ((x) =3D __xnlock_get_irqsave(lock))=

-#endif /* !XENO_DEBUG(NUCLEUS) */
-#define xnlock_clear_irqoff(lock)   xnlock_put_irqrestore(lock,1)
-#define xnlock_clear_irqon(lock)    xnlock_put_irqrestore(lock,0)
+	((x) =3D __xnlock_get_irqsave(lock  XNLOCK_DBG_CONTEXT))
+#define xnlock_clear_irqoff(lock)	xnlock_put_irqrestore(lock, 1)
+#define xnlock_clear_irqon(lock)	xnlock_put_irqrestore(lock, 0)
=20
 static inline void xnlock_init (xnlock_t *lock)
 {
@@ -235,132 +314,65 @@ static inline void xnlock_init (xnlock_t
 #define DEFINE_XNLOCK(lock)		xnlock_t lock =3D XNARCH_LOCK_UNLOCKED
 #define DEFINE_PRIVATE_XNLOCK(lock)	static DEFINE_XNLOCK(lock)
=20
-#if XENO_DEBUG(NUCLEUS)
+static inline int __xnlock_get(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_=
ARGS)
+{
+	unsigned long long start;
+	unsigned int spin_limit;
+	int cpu =3D xnarch_current_cpu();
+
+	if (atomic_read(&lock->owner) =3D=3D cpu)
+		return 1;
+
+	xnlock_dbg_prepare_acquire(&start, &spin_limit);
+
+	while (atomic_cmpxchg(&lock->owner, ~0, cpu) !=3D ~0)
+		do {
+			cpu_relax();
+			xnlock_dbg_spinning(lock, cpu, &spin_limit /*, */
+					    XNLOCK_DBG_PASS_CONTEXT);
+		} while(atomic_read(&lock->owner) !=3D ~0);
+
+	xnlock_dbg_acquired(lock, cpu, &start /*, */ XNLOCK_DBG_PASS_CONTEXT);
+
+	return 0;
+}
+
+static inline void xnlock_put(xnlock_t *lock)
+{
+	if (likely(atomic_read(&lock->owner) =3D=3D xnarch_current_cpu())) {
+		xnlock_dbg_release(lock);
+
+		/*
+		 * Make sure all data written inside the lock is visible to
+		 * other CPUs before we release the lock.
+		 */
+		xnarch_memory_barrier();
+
+		atomic_set(&lock->owner, ~0);
+	} else
+		xnlock_dbg_invalid_release(lock);
+}
+
+static inline spl_t
+__xnlock_get_irqsave(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS)
+{
+	unsigned long flags;
+
+	rthal_local_irq_save(flags);
=20
-#define XNARCH_DEBUG_SPIN_LIMIT 3000000
+	if (__xnlock_get(lock /*, */ XNLOCK_DBG_PASS_CONTEXT))
+		flags |=3D 2;	/* Recursive acquisition */
=20
-static inline int __xnlock_get (xnlock_t *lock,
-				 const char *file,
-				 unsigned line,
-				 const char *function)
-{
-    unsigned spin_count =3D 0;
-#else /* !XENO_DEBUG(NUCLEUS) */
-static inline int __xnlock_get (xnlock_t *lock)
-{
-#endif /* !XENO_DEBUG(NUCLEUS) */
-    int recursing;
-
-    recursing =3D (atomic_read(&lock->owner) =3D=3D rthal_processor_id()=
);
-    if (!recursing) {
-#if XENO_DEBUG(NUCLEUS)
-	    unsigned long long lock_date =3D rthal_rdtsc();
-#endif /* XENO_DEBUG(NUCLEUS) */
-	    while(atomic_cmpxchg(&lock->owner, ~0, rthal_processor_id()) !=3D ~=
0)
-		    do {
-			    cpu_relax();
-
-#if XENO_DEBUG(NUCLEUS)
-			    if (++spin_count =3D=3D XNARCH_DEBUG_SPIN_LIMIT) {
-				    rthal_emergency_console();
-				    printk(KERN_ERR
-					   "Xenomai: stuck on nucleus lock %p\n"
-					   "       waiter =3D %s:%u (%s(), CPU #%d)\n"
-					   "       owner  =3D %s:%u (%s(), CPU #%d)\n",
-					   lock,file,line,function,rthal_processor_id(),
-					   lock->file,lock->line,lock->function,lock->cpu);
-				    show_stack(NULL,NULL);
-				    for (;;)
-					    cpu_relax();
-			    }
-#endif /* XENO_DEBUG(NUCLEUS) */
-		    } while(atomic_read(&lock->owner) !=3D ~0);
-
-#if XENO_DEBUG(NUCLEUS)
-	    lock->spin_time =3D rthal_rdtsc() - lock_date;
-	    lock->lock_date =3D lock_date;
-	    lock->file =3D file;
-	    lock->function =3D function;
-	    lock->line =3D line;
-	    lock->cpu =3D rthal_processor_id();
-#endif /* XENO_DEBUG(NUCLEUS) */
-        }
-
-    return recursing;
-}
-
-static inline void xnlock_put (xnlock_t *lock)
-{
-	if (likely(atomic_read(&lock->owner) =3D=3D rthal_processor_id())) {
-
-#if XENO_DEBUG(NUCLEUS)
-	    extern xnlockinfo_t xnlock_stats[];
-
-	    unsigned long long lock_time =3D rthal_rdtsc() - lock->lock_date;
-	    int cpu =3D rthal_processor_id();
-
-	    if (lock_time > xnlock_stats[cpu].lock_time) {
-		    xnlock_stats[cpu].lock_time =3D lock_time;
-		    xnlock_stats[cpu].spin_time =3D lock->spin_time;
-		    xnlock_stats[cpu].file =3D lock->file;
-		    xnlock_stats[cpu].function =3D lock->function;
-		    xnlock_stats[cpu].line =3D lock->line;
-	    }
-#endif /* XENO_DEBUG(NUCLEUS) */
-	    /*
-	     * Make sure all data written inside the lock is visible to
-	     * other CPUs before we release the lock.
-	     */
-	    xnarch_memory_barrier();
-
-	    atomic_set(&lock->owner, ~0);
-    }
-#if XENO_DEBUG(NUCLEUS)
-    else {
-	    rthal_emergency_console();
-	    printk(KERN_ERR
-		   "Xenomai: unlocking unlocked nucleus lock %p\n"
-		   "       owner  =3D %s:%u (%s(), CPU #%d)\n",
-		   lock,lock->file,lock->line,lock->function,lock->cpu);
-	    show_stack(NULL,NULL);
-	    for (;;)
-		    cpu_relax();
-    }
-#endif /* XENO_DEBUG(NUCLEUS) */
-}
-
-#if XENO_DEBUG(NUCLEUS)
-
-static inline spl_t __xnlock_get_irqsave (xnlock_t *lock,
-                                          const char *file,
-                                          unsigned line,
-                                          const char *function)
-{
-#else /* !XENO_DEBUG(NUCLEUS) */
-static inline spl_t __xnlock_get_irqsave (xnlock_t *lock)
-{
-#endif /* !XENO_DEBUG(NUCLEUS) */
-    unsigned long flags;
-
-    rthal_local_irq_save(flags);
-
-#if XENO_DEBUG(NUCLEUS)
-    if (__xnlock_get(lock, file, line, function))
-	    flags |=3D 2;
-#else /* !XENO_DEBUG(NUCLEUS) */
-    if (__xnlock_get(lock))
-	    flags |=3D 2;
-#endif /* !XENO_DEBUG(NUCLEUS) */
-=09
-    return flags;
+	return flags;
 }
=20
-static inline void xnlock_put_irqrestore (xnlock_t *lock, spl_t flags)
+static inline void xnlock_put_irqrestore(xnlock_t *lock, spl_t flags)
 {
-    if (!(flags & 2))
-	    xnlock_put(lock);
+	/* Only release the lock if we didn't take it recursively. */
+	if (!(flags & 2))
+		xnlock_put(lock);
=20
-    rthal_local_irq_restore(flags & 1);
+	rthal_local_irq_restore(flags & 1);
 }
=20
 static inline int xnarch_send_ipi (xnarch_cpumask_t cpumask)

--------------040103030206090409060600--

--------------enigF18B034DEC02B216E5657CB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHyoOIniDOoMHTA+kRAuNHAJ46VeYLXVhGtJFe6sTP/AANx/zdugCcDhPm
QpMiTlGhHwkvBWjHNWUSNlM=
=nDFY
-----END PGP SIGNATURE-----

--------------enigF18B034DEC02B216E5657CB9--

