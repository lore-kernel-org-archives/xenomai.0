Message-ID: <4563FA75.3000206@domain.hid>
Date: Wed, 22 Nov 2006 08:21:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 3/3] control POSIX skin
	debugging	independently
References: <456236E5.5060203@domain.hid>
In-Reply-To: <456236E5.5060203@domain.hid>
Content-Type: multipart/mixed; boundary="------------060801060408010707080604"
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
--------------060801060408010707080604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Version 2 of this patch with the following changes:

 - switch to #if XENO_DEBUG(POSIX) (instead of "if (XENO_DEBUG(POSIX))")
 - make XENO_OPT_DEBUG_POSIX default y (if debugging is enabled)

Jan


PS: Changelog for the whole series can be provided once it is considered
mergeable.

--------------060801060408010707080604
Content-Type: text/x-patch;
 name="split-posix-debug-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="split-posix-debug-v2.patch"

---
 ksrc/skins/posix/Config.in  |    1 +
 ksrc/skins/posix/Kconfig    |   10 ++++++++--
 ksrc/skins/posix/cond.c     |    9 ++++-----
 ksrc/skins/posix/internal.h |    7 +++++++
 ksrc/skins/posix/intr.c     |    9 ++++-----
 ksrc/skins/posix/mq.c       |    8 ++++----
 ksrc/skins/posix/mutex.c    |    4 ++--
 ksrc/skins/posix/registry.c |   17 ++++++++++-------
 ksrc/skins/posix/sem.c      |   12 ++++++------
 ksrc/skins/posix/shm.c      |   12 ++++++------
 ksrc/skins/posix/signal.c   |    9 ++++-----
 ksrc/skins/posix/thread.c   |    4 ++--
 ksrc/skins/posix/timer.c    |    4 ++--
 13 files changed, 60 insertions(+), 46 deletions(-)

Index: xenomai/ksrc/skins/posix/cond.c
===================================================================
--- xenomai.orig/ksrc/skins/posix/cond.c
+++ xenomai/ksrc/skins/posix/cond.c
@@ -561,11 +561,10 @@ void pse51_condq_cleanup(pse51_kqueues_t
 	while ((holder = getheadq(&q->condq)) != NULL) {
 		cond_destroy_internal(link2cond(holder), q);
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		xnprintf
-		    ("Posix: destroying condition variable %p.\n",
-		     link2cond(holder));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#if XENO_DEBUG(POSIX)
+		xnprintf("Posix: destroying condition variable %p.\n",
+			 link2cond(holder));
+#endif /* XENO_DEBUG(POSIX) */
 		xnlock_get_irqsave(&nklock, s);
 	}
 
Index: xenomai/ksrc/skins/posix/internal.h
===================================================================
--- xenomai.orig/ksrc/skins/posix/internal.h
+++ xenomai/ksrc/skins/posix/internal.h
@@ -25,6 +25,13 @@
 #include <posix/posix.h>
 #include <posix/registry.h>
 
+/* debug support */
+#include <nucleus/assert.h>
+
+#ifndef CONFIG_XENO_OPT_DEBUG_POSIX
+#define CONFIG_XENO_OPT_DEBUG_POSIX 0
+#endif
+
 #define PSE51_MAGIC(n) (0x8686##n##n)
 #define PSE51_ANY_MAGIC         PSE51_MAGIC(00)
 #define PSE51_THREAD_MAGIC      PSE51_MAGIC(01)
Index: xenomai/ksrc/skins/posix/mq.c
===================================================================
--- xenomai.orig/ksrc/skins/posix/mq.c
+++ xenomai/ksrc/skins/posix/mq.c
@@ -1127,10 +1127,10 @@ int mq_notify(mqd_t fd, const struct sig
 static void uqd_cleanup(pse51_assoc_t *assoc)
 {
 	pse51_ufd_t *ufd = assoc2ufd(assoc);
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 	xnprintf("Posix: closing message queue descriptor %lu.\n",
 		 pse51_assoc_key(assoc));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(POSIX) */
 	mq_close(ufd->kfd);
 	xnfree(ufd);
 }
@@ -1160,10 +1160,10 @@ void pse51_mq_pkg_cleanup(void)
 		pse51_node_remove(&node, mq->nodebase.name, PSE51_MQ_MAGIC);
 		xnlock_put_irqrestore(&nklock, s);
 		pse51_mq_destroy(mq);
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 		xnprintf("Posix: unlinking message queue \"%s\".\n",
 			 mq->nodebase.name);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(POSIX) */
 		xnfree(mq);
 		xnlock_get_irqsave(&nklock, s);
 	}
Index: xenomai/ksrc/skins/posix/mutex.c
===================================================================
--- xenomai.orig/ksrc/skins/posix/mutex.c
+++ xenomai/ksrc/skins/posix/mutex.c
@@ -504,9 +504,9 @@ void pse51_mutexq_cleanup(pse51_kqueues_
 	while ((holder = getheadq(&q->mutexq)) != NULL) {
 		pse51_mutex_destroy_internal(link2mutex(holder), q);
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 		xnprintf("Posix: destroying mutex %p.\n", link2mutex(holder));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(POSIX) */
 		xnlock_get_irqsave(&nklock, s);
 	}
 
Index: xenomai/ksrc/skins/posix/registry.c
===================================================================
--- xenomai.orig/ksrc/skins/posix/registry.c
+++ xenomai/ksrc/skins/posix/registry.c
@@ -488,18 +488,21 @@ void pse51_reg_pkg_cleanup(void)
 	unsigned i;
 	for (i = 0; i < pse51_reg.maxfds; i++)
 		if (pse51_reg.descs[i]) {
-#ifdef CONFIG_XENO_OPT_DEBUG
-			xnprintf("Posix: destroying descriptor %d.\n",i);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#if XENO_DEBUG(POSIX)
+			xnprintf("Posix: destroying descriptor %d.\n", i);
+#endif /* XENO_DEBUG(POSIX) */
 			pse51_desc_destroy(pse51_reg.descs[i]);
 		}
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 	for (i = 0; i < pse51_reg.buckets_count; i++) {
 		pse51_node_t *node;
-		for (node = pse51_reg.node_buckets[i]; node; node = node->next)
-			xnprintf("Posix: node \"%s\" left aside.\n", node->name);
+		for (node = pse51_reg.node_buckets[i];
+		     node;
+		     node = node->next)
+			xnprintf("Posix: node \"%s\" left aside.\n",
+				 node->name);
 	}
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(POSIX) */
 
 	size = sizeof(pse51_node_t) * pse51_reg.buckets_count
 		+ sizeof(pse51_desc_t) * pse51_reg.maxfds
Index: xenomai/ksrc/skins/posix/sem.c
===================================================================
--- xenomai.orig/ksrc/skins/posix/sem.c
+++ xenomai/ksrc/skins/posix/sem.c
@@ -760,9 +760,9 @@ static void usem_cleanup(pse51_assoc_t *
 	pse51_usem_t *usem = assoc2usem(assoc);
 	nsem_t *nsem = sem2named_sem(sem);
 
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 	xnprintf("Posix: closing semaphore \"%s\".\n", nsem->nodebase.name);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(POSIX) */
 	sem_close(&nsem->descriptor.native_sem);
 	xnfree(usem);
 }
@@ -784,13 +784,13 @@ void pse51_semq_cleanup(pse51_kqueues_t 
 		pse51_sem_t *sem = link2sem(holder);
 		pse51_node_t *node;
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		if (sem->is_named) 
+#if XENO_DEBUG(POSIX)
+		if (sem->is_named)
 			xnprintf("Posix: unlinking semaphore \"%s\".\n",
 				 sem2named_sem(sem)->nodebase.name);
 		else
-			xnprintf("Posix: destroying semaphore %p.\n",sem);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+			xnprintf("Posix: destroying semaphore %p.\n", sem);
+#endif /* XENO_DEBUG(POSIX) */
 		xnlock_get_irqsave(&nklock, s);
 		if (sem->is_named)
 			pse51_node_remove(&node,
Index: xenomai/ksrc/skins/posix/shm.c
===================================================================
--- xenomai.orig/ksrc/skins/posix/shm.c
+++ xenomai/ksrc/skins/posix/shm.c
@@ -880,10 +880,10 @@ int pse51_xnheap_get(xnheap_t **pheap, v
 static void ufd_cleanup(pse51_assoc_t *assoc)
 {
 	pse51_ufd_t *ufd = assoc2ufd(assoc);
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 	xnprintf("Posix: closing shared memory descriptor %lu.\n",
 		 pse51_assoc_key(assoc));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(POSIX) */
 	pse51_shm_close(ufd->kfd);
 	xnfree(ufd);
 }
@@ -891,10 +891,10 @@ static void ufd_cleanup(pse51_assoc_t *a
 static void umap_cleanup(pse51_assoc_t *assoc)
 {
 	pse51_umap_t *umap = assoc2umap(assoc);
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 	xnprintf("Posix: unmapping shared memory 0x%08lx.\n",
 		 pse51_assoc_key(assoc));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(POSIX) */
 	munmap(umap->kaddr, umap->len);
 	xnfree(umap);
 }
@@ -931,10 +931,10 @@ void pse51_shm_pkg_cleanup(void)
 
 		pse51_node_remove(&node, shm->nodebase.name, PSE51_SHM_MAGIC);
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 		xnprintf("Posix: unlinking shared memory \"%s\".\n",
 			 shm->nodebase.name);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(POSIX) */
 		xnlock_get_irqsave(&nklock, s);
 		pse51_shm_destroy(shm, 1);
 	}
Index: xenomai/ksrc/skins/posix/signal.c
===================================================================
--- xenomai.orig/ksrc/skins/posix/signal.c
+++ xenomai/ksrc/skins/posix/signal.c
@@ -1211,15 +1211,14 @@ void pse51_signal_pkg_init(void)
 
 void pse51_signal_pkg_cleanup(void)
 {
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 	int i;
 
 	for (i = 0; i < PSE51_SIGQUEUE_MAX; i++)
 		if (pse51_infos_pool[i].info.si_signo)
-			xnprintf
-			    ("Posix siginfo structure %p was not freed, freeing now.\n",
-			     &pse51_infos_pool[i].info);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+			xnprintf("Posix siginfo structure %p was not freed, "
+				 "freeing now.\n", &pse51_infos_pool[i].info);
+#endif /* XENO_DEBUG(POSIX) */
 
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
 	rthal_apc_free(pse51_signals_apc);
Index: xenomai/ksrc/skins/posix/thread.c
===================================================================
--- xenomai.orig/ksrc/skins/posix/thread.c
+++ xenomai/ksrc/skins/posix/thread.c
@@ -712,9 +712,9 @@ void pse51_threadq_cleanup(pse51_kqueues
 			/* Remaining TCB (joinable thread, which was never joined). */
 			thread_destroy(thread);
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 		xnprintf("POSIX: destroyed thread %p\n", thread);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(POSIX) */
 		xnlock_get_irqsave(&nklock, s);
 	}
 
Index: xenomai/ksrc/skins/posix/timer.c
===================================================================
--- xenomai.orig/ksrc/skins/posix/timer.c
+++ xenomai/ksrc/skins/posix/timer.c
@@ -520,9 +520,9 @@ void pse51_timerq_cleanup(pse51_kqueues_
 		timer_t tm = (timer_t) (link2tm(holder, link) - timer_pool);
 		pse51_timer_delete_inner(tm, q);
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(POSIX)
 		xnprintf("Posix timer %u deleted\n", (unsigned) tm);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(POSIX) */
 		xnlock_get_irqsave(&nklock, s);
 	}
 
Index: xenomai/ksrc/skins/posix/intr.c
===================================================================
--- xenomai.orig/ksrc/skins/posix/intr.c
+++ xenomai/ksrc/skins/posix/intr.c
@@ -261,11 +261,10 @@ void pse51_intrq_cleanup(pse51_kqueues_t
 	while ((holder = getheadq(&q->intrq)) != NULL) {
 		pthread_intr_detach_np(link2intr(holder));
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		xnprintf
-		    ("Posix interruption handler %p was not destroyed,"
-		     " destroying now.\n", link2intr(holder));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#if XENO_DEBUG(POSIX)
+		xnprintf("Posix interruption handler %p was not destroyed, "
+			 "destroying now.\n", link2intr(holder));
+#endif /* XENO_DEBUG(POSIX) */
 		xnlock_get_irqsave(&nklock, s);
 	}
 
Index: xenomai/ksrc/skins/posix/Config.in
===================================================================
--- xenomai.orig/ksrc/skins/posix/Config.in
+++ xenomai/ksrc/skins/posix/Config.in
@@ -9,5 +9,6 @@ if [ "$CONFIG_XENO_SKIN_POSIX" != "n" ];
 	comment 'POSIX interface options'
 	bool 'Shared memory' CONFIG_XENO_OPT_POSIX_SHM
 	bool 'Interrupts' CONFIG_XENO_OPT_POSIX_INTR
+	bool 'Debugging support' CONFIG_XENO_OPT_DEBUG_POSIX
 	endmenu
 fi
Index: xenomai/ksrc/skins/posix/Kconfig
===================================================================
--- xenomai.orig/ksrc/skins/posix/Kconfig
+++ xenomai/ksrc/skins/posix/Kconfig
@@ -10,7 +10,6 @@ if XENO_SKIN_POSIX != n
 
 config XENO_OPT_POSIX_SHM
 	bool "Shared memory"
-	default n
 	help
 
 	POSIX skin shared memory areas are regions of memory which can be shared
@@ -23,7 +22,6 @@ config XENO_OPT_POSIX_SHM
 
 config XENO_OPT_POSIX_INTR
 	bool "Interrupts"
-	default n
 	help
 
 	This option provides an ad-hoc API to deal with interrupts in programs
@@ -32,4 +30,12 @@ config XENO_OPT_POSIX_INTR
 	RTDM skin is the preferred way of implementing drivers), leave this
 	option unselected.
 
+config XENO_OPT_DEBUG_POSIX
+	bool "Debugging support"
+	default y
+	help
+
+	When enabled, this option makes the skin warn about not properly
+	cleaned up POSIX objects it detects on process termination.
+
 endif

--------------060801060408010707080604--

