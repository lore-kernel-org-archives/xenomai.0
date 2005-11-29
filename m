Message-ID: <438CA8CB.4090609@domain.hid>
Date: Tue, 29 Nov 2005 20:15:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE03AFBBF0E4176DD4813BD0D"
Subject: [Xenomai-core] [patch] spinlock latency debugging
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
--------------enigE03AFBBF0E4176DD4813BD0D
Content-Type: multipart/mixed; boundary="------------060203060900050605040403"

This is a multi-part message in MIME format.
--------------060203060900050605040403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

this is a first attempt to add some more instrumentation to the Xenomai
core and related modules. It enables the existing spinlock profiling
also for non-SMP setups and adds the exit location to the log. Note that
this is likely not yet ready for inclusion, it's only tested with
debugging on and may break with other configs.

Comments are welcome.


Some first observations: this kind of instrumentation is unfortunately
insufficient to trace the full latency a task may suffer from. In case
some IRQ hits inside a critical section, the tracing will not start
before some functions finally called by the IRQ handler acquires a
xnlock. Task latencies and longest locking periods differ by factor 2
*at least*. What we finally need is IRQ-off tracing.

Jan

--------------060203060900050605040403
Content-Type: text/plain;
 name="spinlock_debug.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="spinlock_debug.patch"

Index: include/asm-ia64/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-ia64/system.h	(revision 202)
+++ include/asm-ia64/system.h	(working copy)
@@ -525,7 +525,7 @@
=20
 static rthal_trap_handler_t xnarch_old_trap_handler;
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
 static xnlock_t xnarch_stacks_lock =3D XNARCH_LOCK_UNLOCKED;
 #endif
 static atomic_counter_t xnarch_allocated_stacks;
Index: include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/system.h	(revision 202)
+++ include/asm-generic/system.h	(working copy)
@@ -54,16 +54,20 @@
 #define splget(x)   rthal_local_irq_flags(x)
 #define splsync(x)  rthal_local_irq_sync(x)
=20
-#if defined(CONFIG_SMP) && \
-    (defined(CONFIG_XENO_OPT_STATS) || defined(CONFIG_XENO_OPT_DEBUG))
+/*#if defined(CONFIG_SMP) && \
+    (defined(CONFIG_XENO_OPT_STATS) || defined(CONFIG_XENO_OPT_DEBUG))*/=

+#ifdef CONFIG_XENO_OPT_SPINLOCK_DEBUG
=20
 typedef struct {
=20
         unsigned long long spin_time;
         unsigned long long lock_time;
-        const char *file;
-        const char *function;
-        unsigned line;
+        const char *get_file;
+        const char *get_function;
+        unsigned get_line;
+        const char *put_file;
+        const char *put_function;
+        unsigned put_line;
=20
 } xnlockinfo_t;
=20
@@ -89,9 +93,9 @@
         0LL,                                    \
 }
=20
-#define CONFIG_XENO_SPINLOCK_DEBUG  1
+//#define CONFIG_XENO_SPINLOCK_DEBUG  1
=20
-#else /* !(CONFIG_XENO_OPT_STATS && CONFIG_SMP) */
+#else /* !CONFIG_XENO_OPT_SPINLOCK_DEBUG */
=20
 typedef struct { volatile unsigned long lock; } xnlock_t;
=20
@@ -197,14 +201,17 @@
     return !!s;
 }
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#ifdef CONFIG_XENO_OPT_SPINLOCK_DEBUG
 #define xnlock_get_irqsave(lock,x) \
     ((x) =3D __xnlock_get_irqsave(lock, __FILE__, __LINE__,__FUNCTION__)=
)
-#else /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#define xnlock_put_irqrestore(lock,x) \
+    __xnlock_put_irqrestore(lock, x, __FILE__, __LINE__,__FUNCTION__)
+#else /* !CONFIG_XENO_OPT_SPINLOCK_DEBUG */
 #define xnlock_get_irqsave(lock,x)  ((x) =3D __xnlock_get_irqsave(lock))=

-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#define xnlock_put_irqrestore(lock,x) __xnlock_put_irqrestore(lock,x)
+#endif /* CONFIG_XENO_OPT_SPINLOCK_DEBUG */
 #define xnlock_clear_irqoff(lock)   xnlock_put_irqrestore(lock,1)
 #define xnlock_clear_irqon(lock)    xnlock_put_irqrestore(lock,0)
=20
@@ -213,7 +220,7 @@
     *lock =3D XNARCH_LOCK_UNLOCKED;
 }
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#ifdef CONFIG_XENO_OPT_SPINLOCK_DEBUG
=20
 #define XNARCH_DEBUG_SPIN_LIMIT 3000000
=20
@@ -223,10 +230,10 @@
                                           const char *function)
 {
     unsigned spin_count =3D 0;
-#else /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#else /* !CONFIG_XENO_OPT_SPINLOCK_DEBUG */
 static inline spl_t __xnlock_get_irqsave (xnlock_t *lock)
 {
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* CONFIG_XENO_OPT_SPINLOCK_DEBUG */
     rthal_declare_cpuid;
     unsigned long flags;
=20
@@ -236,9 +243,9 @@
=20
     if (!test_and_set_bit(cpuid,&lock->lock))
         {
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#ifdef CONFIG_XENO_OPT_SPINLOCK_DEBUG
         unsigned long long lock_date =3D rthal_rdtsc();
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* CONFIG_XENO_OPT_SPINLOCK_DEBUG */
         while (test_and_set_bit(BITS_PER_LONG - 1,&lock->lock))
             /* Use an non-locking test in the inner loop, as Linux'es
                bit_spin_lock. */
@@ -246,7 +253,7 @@
                 {
                 cpu_relax();
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#ifdef CONFIG_XENO_OPT_SPINLOCK_DEBUG
                 if (++spin_count =3D=3D XNARCH_DEBUG_SPIN_LIMIT)
                     {
                     rthal_emergency_console();
@@ -260,17 +267,17 @@
                     for (;;)
                         cpu_relax();
                     }
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* CONFIG_XENO_OPT_SPINLOCK_DEBUG */
                 }
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#ifdef CONFIG_XENO_OPT_SPINLOCK_DEBUG
         lock->spin_time =3D rthal_rdtsc() - lock_date;
         lock->lock_date =3D lock_date;
         lock->file =3D file;
         lock->function =3D function;
         lock->line =3D line;
         lock->cpu =3D cpuid;
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* CONFIG_XENO_OPT_SPINLOCK_DEBUG */
         }
     else
         flags |=3D 2;
@@ -278,8 +285,15 @@
     return flags;
 }
=20
-static inline void xnlock_put_irqrestore (xnlock_t *lock, spl_t flags)
-
+#ifdef CONFIG_XENO_OPT_SPINLOCK_DEBUG
+static inline void __xnlock_put_irqrestore (xnlock_t *lock,
+                                            spl_t flags,
+                                            const char *file,
+                                            unsigned line,
+                                            const char *function)
+#else /* !CONFIG_XENO_OPT_SPINLOCK_DEBUG */
+static inline void __xnlock_put_irqrestore (xnlock_t *lock, spl_t flags)=

+#endif /* CONFIG_XENO_OPT_SPINLOCK_DEBUG */
 {
     if (!(flags & 2))
         {
@@ -299,15 +313,18 @@
                 {
                 xnlock_stats[cpuid].lock_time =3D lock_time;
                 xnlock_stats[cpuid].spin_time =3D lock->spin_time;
-                xnlock_stats[cpuid].file =3D lock->file;
-                xnlock_stats[cpuid].function =3D lock->function;
-                xnlock_stats[cpuid].line =3D lock->line;
+                xnlock_stats[cpuid].get_file =3D lock->file;
+                xnlock_stats[cpuid].get_function =3D lock->function;
+                xnlock_stats[cpuid].get_line =3D lock->line;
+                xnlock_stats[cpuid].put_file =3D file;
+                xnlock_stats[cpuid].put_function =3D function;
+                xnlock_stats[cpuid].put_line =3D line;
                 }
 #endif /* CONFIG_XENO_OPT_STATS */
=20
             clear_bit(BITS_PER_LONG - 1,&lock->lock);
 	    }
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#ifdef CONFIG_XENO_OPT_SPINLOCK_DEBUG
         else
             {
             rthal_emergency_console();
@@ -325,7 +342,7 @@
     rthal_local_irq_restore(flags & 1);
 }
=20
-#else /* !CONFIG_SMP */
+#else /* !(CONFIG_SMP || CONFIG_XENO_OPT_SPINLOCK_DEBUG) */
=20
 #define xnlock_init(lock)              do { } while(0)
 #define xnlock_get_irqsave(lock,x)     rthal_local_irq_save(x)
@@ -333,7 +350,7 @@
 #define xnlock_clear_irqoff(lock)      rthal_local_irq_disable()
 #define xnlock_clear_irqon(lock)       rthal_local_irq_enable()
=20
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP || CONFIG_XENO_OPT_SPINLOCK_DEBUG */
=20
 #ifdef XENO_POD_MODULE
=20
Index: include/rtdm/core.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/core.h	(revision 202)
+++ include/rtdm/core.h	(working copy)
@@ -33,10 +33,7 @@
 };
=20
=20
-#ifdef CONFIG_SMP
 extern xnlock_t             rt_fildes_lock;
-#endif /* CONFIG_SMP */
-
 extern unsigned int         fd_count;
 extern struct rtdm_fildes   *fildes_table;
 extern int                  open_fildes;
Index: include/nucleus/heap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/heap.h	(revision 202)
+++ include/nucleus/heap.h	(working copy)
@@ -87,7 +87,7 @@
=20
     xnqueue_t extents;
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
     xnlock_t lock;
 #endif /* CONFIG_SMP */
=20
Index: include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/pod.h	(revision 202)
+++ include/nucleus/pod.h	(working copy)
@@ -233,7 +233,7 @@
=20
 extern xnpod_t *nkpod;
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
 extern xnlock_t nklock;
 #endif /* CONFIG_SMP */
=20
Index: include/nucleus/queue.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/queue.h	(revision 202)
+++ include/nucleus/queue.h	(working copy)
@@ -57,7 +57,8 @@
=20
     xnholder_t head;
     int elems;
-#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG) && defined(CON=
FIG_SMP)
+#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG) && \
+        (defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCKDEBUG))
     xnlock_t lock;
 #endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG && CONFIG_SMP */
=20
Index: ksrc/skins/posix/signal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/signal.c	(revision 202)
+++ ksrc/skins/posix/signal.c	(working copy)
@@ -32,7 +32,7 @@
=20
 static struct sigaction actions[SIGRTMAX];
 static pse51_siginfo_t pse51_infos_pool[PSE51_SIGQUEUE_MAX];
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
 static xnlock_t pse51_infos_lock;
 #endif
 static xnpqueue_t pse51_infos_free_list;
Index: ksrc/skins/rtdm/device.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/device.c	(revision 202)
+++ ksrc/skins/rtdm/device.c	(working copy)
@@ -62,7 +62,7 @@
=20
 DECLARE_MUTEX(nrt_dev_lock);
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
 xnlock_t             rt_dev_lock =3D XNARCH_LOCK_UNLOCKED;
 #endif /* CONFIG_SMP */
=20
Index: ksrc/skins/rtdm/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/core.c	(revision 202)
+++ ksrc/skins/rtdm/core.c	(working copy)
@@ -44,7 +44,7 @@
 static struct rtdm_fildes   *free_fildes;   /* chain of free descriptors=
 */
 int                         open_fildes;    /* number of used descriptor=
s */
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
 xnlock_t                    rt_fildes_lock =3D XNARCH_LOCK_UNLOCKED;
 #endif /* !CONFIG_SMP */
=20
Index: ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/Kconfig	(revision 202)
+++ ksrc/nucleus/Kconfig	(working copy)
@@ -87,6 +87,14 @@
 	Do not switch this option on unless you really know what you
 	are doing.
=20
+config XENO_OPT_SPINLOCK_DEBUG
+	bool "Spinlock debugging"
+	default n
+#	depends on XENO_OPT_DEBUG
+	help
+
+	no help
+
 config XENO_OPT_WATCHDOG
 	bool "Watchdog support"
 	default n
Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c	(revision 202)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -48,7 +48,7 @@
=20
 xnpod_t *nkpod =3D NULL;
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
 xnlock_t nklock =3D XNARCH_LOCK_UNLOCKED;
 #endif /* CONFIG_SMP */
=20
@@ -3431,6 +3431,6 @@
 EXPORT_SYMBOL(nkclock);
 EXPORT_SYMBOL(nkpod);
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
 EXPORT_SYMBOL(nklock);
 #endif /* CONFIG_SMP */
Index: ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/module.c	(revision 202)
+++ ksrc/nucleus/module.c	(working copy)
@@ -375,7 +375,7 @@
     .release =3D seq_release_private,
 };
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
=20
 xnlockinfo_t xnlock_stats[RTHAL_NR_CPUS];
=20
@@ -405,12 +405,16 @@
         p +=3D sprintf(p,
                      "  longest locked section: %llu ns\n"
                      "  spinning time: %llu ns\n"
-                     "  section entry: %s:%d (%s)\n",
+                     "  section entry: %s:%d (%s)\n"
+                     "  section exit: %s:%d (%s)\n",
                      xnarch_tsc_to_ns(lockinfo.lock_time),
                      xnarch_tsc_to_ns(lockinfo.spin_time),
-                     lockinfo.file,
-                     lockinfo.line,
-                     lockinfo.function);
+                     lockinfo.get_file,
+                     lockinfo.get_line,
+                     lockinfo.get_function,
+                     lockinfo.put_file,
+                     lockinfo.put_line,
+                     lockinfo.put_function);
     }
=20
     len =3D p - page - off;
@@ -425,7 +429,7 @@
=20
 EXPORT_SYMBOL(xnlock_stats);
=20
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP || CONFIG_XENO_OPT_SPINLOCK_DEBUG */
=20
 #endif /* CONFIG_XENO_OPT_STATS */
=20
@@ -612,13 +616,13 @@
 		  &stat_seq_operations,
 		  0,
 		  rthal_proc_root);
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
     add_proc_leaf("lock",
 		  &lock_read_proc,
 		  NULL,
 		  NULL,
 		  rthal_proc_root);
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP || CONFIG_XENO_OPT_SPINLOCK_DEBUG */
=20
 #endif /* CONFIG_XENO_OPT_STATS */
=20
@@ -675,9 +679,9 @@
     remove_proc_entry("sched",rthal_proc_root);
 #ifdef CONFIG_XENO_OPT_STATS
     remove_proc_entry("stat",rthal_proc_root);
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_SPINLOCK_DEBUG)
     remove_proc_entry("lock",rthal_proc_root);
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP || CONFIG_XENO_OPT_SPINLOCK_DEBUG */
 #endif /* CONFIG_XENO_OPT_STATS */
 }
=20

--------------060203060900050605040403--

--------------enigE03AFBBF0E4176DD4813BD0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDjKjLniDOoMHTA+kRApm3AJ9YyJwzUBQC815yz1o7+/jMtSpL5ACfSQF7
5Uq5EoERWF1/fkRRB4uWX8U=
=JgoA
-----END PGP SIGNATURE-----

--------------enigE03AFBBF0E4176DD4813BD0D--

