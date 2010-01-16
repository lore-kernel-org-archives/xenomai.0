From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 16 Jan 2010 21:04:58 +0100
Message-Id: <1263672300-20868-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4B521B97.7010203@domain.hid>
References: <4B521B97.7010203@domain.hid>
Subject: [Xenomai-core] [PATCH 1/3] nucleus: allow xnlock debugging even on
	UP kernels
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

---
 include/asm-generic/bits/pod.h |    2 +-
 include/asm-generic/system.h   |   19 +++++++++++++------
 include/nucleus/queue.h        |   16 ++++++++--------
 ksrc/nucleus/intr.c            |    4 ++--
 ksrc/nucleus/pod.c             |   16 ++++++++--------
 ksrc/skins/posix/signal.c      |    4 +---
 6 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/include/asm-generic/bits/pod.h b/include/asm-generic/bits/pod.h
index 6cf2f6e..5cebcd4 100644
--- a/include/asm-generic/bits/pod.h
+++ b/include/asm-generic/bits/pod.h
@@ -278,7 +278,7 @@ unsigned long long xnarch_get_cpu_time(void)
 
 EXPORT_SYMBOL(xnarch_get_cpu_time);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 void __xnlock_spin(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS)
 {
 	unsigned int spin_limit;
diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index e872711..b59e364 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -91,7 +91,7 @@ static inline unsigned xnarch_current_cpu(void)
 	return rthal_processor_id();
 }
 
-#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
+#if XENO_DEBUG(NUCLEUS)
 
 typedef struct {
 
@@ -148,11 +148,14 @@ xnlock_dbg_spinning(xnlock_t *lock, int cpu, unsigned int *spin_limit,
 	if (--*spin_limit == 0) {
 		rthal_emergency_console();
 		printk(KERN_ERR "Xenomai: stuck on nucleus lock %p\n"
-				"         waiter = %s:%u (%s(), CPU #%d)\n"
-				"         owner  = %s:%u (%s(), CPU #%d)\n",
+				"	  waiter = %s:%u (%s(), CPU #%d)\n"
+				"	  owner	 = %s:%u (%s(), CPU #%d)\n",
 		       lock, file, line, function, cpu,
 		       lock->file, lock->line, lock->function, lock->cpu);
 		show_stack(NULL, NULL);
+#ifndef CONFIG_SMP
+		BUG();
+#endif
 	}
 }
 
@@ -319,7 +322,7 @@ static inline int xnarch_root_domain_p(void)
 	return rthal_current_domain == rthal_root_domain;
 }
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 
 #define xnlock_get(lock)		__xnlock_get(lock  XNLOCK_DBG_CONTEXT)
 #define xnlock_get_irqsave(lock,x) \
@@ -395,7 +398,11 @@ static inline void xnlock_put_irqrestore(xnlock_t *lock, spl_t flags)
 
 static inline int xnarch_send_ipi(xnarch_cpumask_t cpumask)
 {
+#ifdef CONFIG_SMP
 	return rthal_send_ipi(RTHAL_SERVICE_IPI0, cpumask);
+#else /* !CONFIG_SMP */
+	return 0;
+#endif /* !CONFIG_SMP */
 }
 
 static inline int xnlock_is_owner(xnlock_t *lock)
@@ -403,7 +410,7 @@ static inline int xnlock_is_owner(xnlock_t *lock)
 	return atomic_read(&lock->owner) == xnarch_current_cpu();
 }
 
-#else /* !CONFIG_SMP */
+#else /* !(CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 
 #define xnlock_init(lock)		do { } while(0)
 #define xnlock_get(lock)		do { } while(0)
@@ -424,7 +431,7 @@ static inline int xnarch_send_ipi (xnarch_cpumask_t cpumask)
 	return 0;
 }
 
-#endif /* !CONFIG_SMP */
+#endif /* !(CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 
 #define xnlock_sync_irq(lock, x)			\
 	do {						\
diff --git a/include/nucleus/queue.h b/include/nucleus/queue.h
index b84fa3c..13cde9f 100644
--- a/include/nucleus/queue.h
+++ b/include/nucleus/queue.h
@@ -65,17 +65,17 @@ typedef struct xnqueue {
 
 	xnholder_t head;
 	int elems;
-#if defined(__KERNEL__) && XENO_DEBUG(QUEUES) && defined(CONFIG_SMP)
-	xnlock_t lock;
-#endif				/* __KERNEL__ && XENO_DEBUG(QUEUES) && CONFIG_SMP */
+#if defined(__KERNEL__) && XENO_DEBUG(QUEUES)
+	DECLARE_XNLOCK(lock);
+#endif /* __KERNEL__ && XENO_DEBUG(QUEUES) */
 
 } xnqueue_t;
 
-#if XENO_DEBUG(QUEUES) && defined(CONFIG_SMP)
+#if XENO_DEBUG(QUEUES)
 #define XNQUEUE_INITIALIZER(q) { { &(q).head, &(q).head }, 0, XNARCH_LOCK_UNLOCKED }
-#else /* !(XENO_DEBUG(QUEUES) && CONFIG_SMP) */
+#else /* !(XENO_DEBUG(QUEUES) */
 #define XNQUEUE_INITIALIZER(q) { { &(q).head, &(q).head }, 0 }
-#endif /* XENO_DEBUG(QUEUES) && CONFIG_SMP */
+#endif /* XENO_DEBUG(QUEUES) */
 
 #define DEFINE_XNQUEUE(q) xnqueue_t q = XNQUEUE_INITIALIZER(q)
 
@@ -83,9 +83,9 @@ static inline void initq(xnqueue_t *qslot)
 {
 	inith(&qslot->head);
 	qslot->elems = 0;
-#if defined(__KERNEL__) && XENO_DEBUG(QUEUES) && defined(CONFIG_SMP)
+#if defined(__KERNEL__) && XENO_DEBUG(QUEUES)
 	xnlock_init(&qslot->lock);
-#endif /* __KERNEL__ && XENO_DEBUG(QUEUES) && CONFIG_SMP */
+#endif /* __KERNEL__ && XENO_DEBUG(QUEUES) */
 }
 
 #if XENO_DEBUG(QUEUES)
diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index 97458f5..cfe3041 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -404,7 +404,7 @@ static inline int xnintr_irq_detach(xnintr_t *intr)
 
 #else /* !CONFIG_XENO_OPT_SHIRQ */
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 typedef struct xnintr_irq {
 
 	DECLARE_XNLOCK(lock);
@@ -412,7 +412,7 @@ typedef struct xnintr_irq {
 } ____cacheline_aligned_in_smp xnintr_irq_t;
 
 static xnintr_irq_t xnirqs[XNARCH_NR_IRQS];
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 
 static inline xnintr_t *xnintr_shirq_first(unsigned irq)
 {
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 4144ccd..bc7b241 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -58,9 +58,9 @@ xnpod_t nkpod_struct;
 EXPORT_SYMBOL_GPL(nkpod_struct);
 
 DEFINE_XNLOCK(nklock);
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 EXPORT_SYMBOL_GPL(nklock);
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 
 u_long nklatency = 0;
 EXPORT_SYMBOL_GPL(nklatency);
@@ -3087,7 +3087,7 @@ EXPORT_SYMBOL_GPL(xnpod_set_thread_tslice);
 #include <linux/proc_fs.h>
 #include <linux/ctype.h>
 
-#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 
 xnlockinfo_t xnlock_stats[RTHAL_NR_CPUS];
 
@@ -3134,7 +3134,7 @@ static int lock_read_proc(char *page,
 }
 EXPORT_SYMBOL_GPL(xnlock_stats);
 
-#endif /* CONFIG_SMP && XENO_DEBUG(NUCLEUS) */
+#endif /* CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 
 static int latency_read_proc(char *page,
 			     char **start,
@@ -3217,17 +3217,17 @@ void xnpod_init_proc(void)
 	rthal_add_proc_leaf("version", &version_read_proc, NULL, NULL,
 			    rthal_proc_root);
 
-#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 	rthal_add_proc_leaf("lock", &lock_read_proc, NULL, NULL,
 			    rthal_proc_root);
-#endif /* CONFIG_SMP && XENO_DEBUG(NUCLEUS) */
+#endif /* CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 }
 
 void xnpod_cleanup_proc(void)
 {
-#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 	remove_proc_entry("lock", rthal_proc_root);
-#endif /* CONFIG_SMP && XENO_DEBUG(NUCLEUS) */
+#endif /* CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 	remove_proc_entry("version", rthal_proc_root);
 	remove_proc_entry("latency", rthal_proc_root);
 
diff --git a/ksrc/skins/posix/signal.c b/ksrc/skins/posix/signal.c
index 5d2baf7..193674c 100644
--- a/ksrc/skins/posix/signal.c
+++ b/ksrc/skins/posix/signal.c
@@ -64,9 +64,7 @@ typedef void siginfo_handler_t(int, siginfo_t *, void *);
 #define SIGRTMAX 64
 static struct sigaction actions[SIGRTMAX];
 static pse51_siginfo_t pse51_infos_pool[PSE51_SIGQUEUE_MAX];
-#ifdef CONFIG_SMP
-static xnlock_t pse51_infos_lock = XNARCH_LOCK_UNLOCKED;
-#endif
+DEFINE_XNLOCK(pse51_infos_lock);
 static xnpqueue_t pse51_infos_free_list;
 
 static pse51_siginfo_t *pse51_new_siginfo(int sig, int code, union sigval value)
-- 
1.5.6.5


