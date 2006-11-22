Message-ID: <4563FA59.6070605@domain.hid>
Date: Wed, 22 Nov 2006 08:20:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 1/3] decouple spinlock stats from
	XENO_OPT_STATS
References: <456236D2.3050402@domain.hid>
In-Reply-To: <456236D2.3050402@domain.hid>
Content-Type: multipart/mixed; boundary="------------050203060303010602090809"
Sender: jan.kiszka@domain.hid
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

This is a multi-part message in MIME format.
--------------050203060303010602090809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Here comes version 2 of this patch, now following the new
#if-#else-#endif comment style.

Jan

--------------050203060303010602090809
Content-Type: text/x-patch;
 name="decouple-spinlock-dbg-from-stats-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="decouple-spinlock-dbg-from-stats-v2.patch"

---
 include/asm-generic/system.h |   35 ++++++++++++++++-------------------
 ksrc/nucleus/module.c        |   22 +++++++++++-----------
 2 files changed, 27 insertions(+), 30 deletions(-)

Index: xenomai/include/asm-generic/system.h
===================================================================
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -66,14 +66,12 @@ typedef unsigned long spl_t;
 #define splexit(x)  rthal_local_irq_restore((x) & 1)
 #else /* !CONFIG_SMP */
 #define splexit(x)  rthal_local_irq_restore(x)
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 #define splnone()   rthal_local_irq_enable()
 #define spltest()   rthal_local_irq_test()
 #define splget(x)   rthal_local_irq_flags(x)
 
-#if defined(CONFIG_SMP) && \
-    (defined(CONFIG_XENO_OPT_STATS) || defined(CONFIG_XENO_OPT_DEBUG))
-
+#if defined(CONFIG_SMP) && defined(CONFIG_XENO_OPT_DEBUG)
 typedef struct {
 
         unsigned long long spin_time;
@@ -96,25 +94,24 @@ typedef struct {
 
 } xnlock_t;
 
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
 
 #define CONFIG_XENO_SPINLOCK_DEBUG  1
 
-#else /* !(CONFIG_XENO_OPT_STATS && CONFIG_SMP) */
+#else /* !(CONFIG_SMP && CONFIG_XENO_OPT_DEBUG) */
 
 typedef struct { atomic_t owner; } xnlock_t;
 
 #define XNARCH_LOCK_UNLOCKED (xnlock_t) { { ~0 } }
-
-#endif /* CONFIG_XENO_OPT_STATS && CONFIG_SMP */
+#endif /* !(CONFIG_SMP && CONFIG_XENO_OPT_DEBUG) */
 
 #define XNARCH_NR_CPUS               RTHAL_NR_CPUS
 
@@ -231,7 +228,7 @@ static inline int xnarch_setimask (int i
 #else /* !CONFIG_XENO_SPINLOCK_DEBUG */
 #define xnlock_get(lock)            __xnlock_get(lock)
 #define xnlock_get_irqsave(lock,x)  ((x) = __xnlock_get_irqsave(lock))
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
 #define xnlock_clear_irqoff(lock)   xnlock_put_irqrestore(lock,1)
 #define xnlock_clear_irqon(lock)    xnlock_put_irqrestore(lock,0)
 
@@ -304,7 +301,7 @@ static inline void xnlock_put (xnlock_t 
     rthal_load_cpuid();
     if (likely(atomic_read(&lock->owner) == cpuid)) {
 
-#ifdef CONFIG_XENO_OPT_STATS
+#ifdef CONFIG_XENO_SPINLOCK_DEBUG
 	    extern xnlockinfo_t xnlock_stats[];
 
 	    unsigned long long lock_time = rthal_rdtsc() - lock->lock_date;
@@ -316,7 +313,7 @@ static inline void xnlock_put (xnlock_t 
 		    xnlock_stats[cpuid].function = lock->function;
 		    xnlock_stats[cpuid].line = lock->line;
 	    }
-#endif /* CONFIG_XENO_OPT_STATS */
+#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
 	    atomic_set(&lock->owner, ~0);
     }
 #ifdef CONFIG_XENO_SPINLOCK_DEBUG
@@ -377,7 +374,7 @@ static inline void xnlock_put_irqrestore
 #define xnlock_clear_irqoff(lock)      rthal_local_irq_disable()
 #define xnlock_clear_irqon(lock)       rthal_local_irq_enable()
 
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 static inline int xnarch_remap_vm_page(struct vm_area_struct *vma,
 				       unsigned long from,
Index: xenomai/ksrc/nucleus/module.c
===================================================================
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -472,7 +472,9 @@ static struct file_operations stat_seq_o
 	.release = seq_release_private,
 };
 
-#ifdef CONFIG_SMP
+#endif /* CONFIG_XENO_OPT_STATS */
+
+#ifdef CONFIG_XENO_SPINLOCK_DEBUG
 
 xnlockinfo_t xnlock_stats[RTHAL_NR_CPUS];
 
@@ -520,9 +522,7 @@ static int lock_read_proc(char *page,
 
 EXPORT_SYMBOL(xnlock_stats);
 
-#endif /* CONFIG_SMP */
-
-#endif /* CONFIG_XENO_OPT_STATS */
+#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
 
 static int latency_read_proc(char *page,
 			     char **start,
@@ -741,12 +741,12 @@ void xnpod_init_proc(void)
 
 #ifdef CONFIG_XENO_OPT_STATS
 	add_proc_fops("stat", &stat_seq_operations, 0, rthal_proc_root);
-#ifdef CONFIG_SMP
-	add_proc_leaf("lock", &lock_read_proc, NULL, NULL, rthal_proc_root);
-#endif /* CONFIG_SMP */
-
 #endif /* CONFIG_XENO_OPT_STATS */
 
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
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE

--------------050203060303010602090809--

