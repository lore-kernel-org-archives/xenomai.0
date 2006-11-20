Message-ID: <456236E5.5060203@domain.hid>
Date: Tue, 21 Nov 2006 00:14:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F1813CF85D6FBF2C64F193A"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 3/3] control POSIX skin debugging
	independently
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
--------------enig4F1813CF85D6FBF2C64F193A
Content-Type: multipart/mixed; boundary="------------080804000805070003040706"

This is a multi-part message in MIME format.
--------------080804000805070003040706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Following the logic of per-subsystem debug feature control, this patch
introduces a separate kconfig switch XENO_OPT_POSIX_DEBUG and updates
the involved source files.

Jan





--------------080804000805070003040706
Content-Type: text/x-patch;
 name="split-posix-debug.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="split-posix-debug.patch"

---
 ksrc/skins/posix/Config.in  |    1 +
 ksrc/skins/posix/Kconfig    |    7 +++++++
 ksrc/skins/posix/cond.c     |   10 +++++-----
 ksrc/skins/posix/internal.h |    7 +++++++
 ksrc/skins/posix/intr.c     |   11 ++++++-----
 ksrc/skins/posix/mq.c       |   16 ++++++++--------
 ksrc/skins/posix/mutex.c    |    8 +++++---
 ksrc/skins/posix/registry.c |   22 ++++++++++++----------
 ksrc/skins/posix/sem.c      |   24 ++++++++++++++----------
 ksrc/skins/posix/shm.c      |   23 +++++++++++------------
 ksrc/skins/posix/signal.c   |   16 ++++++++--------
 ksrc/skins/posix/thread.c   |    7 ++++---
 ksrc/skins/posix/timer.c    |    7 ++++---
 13 files changed, 92 insertions(+), 67 deletions(-)

Index: xenomai/ksrc/skins/posix/cond.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/cond.c
+++ xenomai/ksrc/skins/posix/cond.c
@@ -561,11 +561,11 @@ void pse51_condq_cleanup(pse51_kqueues_t
 	while ((holder =3D getheadq(&q->condq)) !=3D NULL) {
 		cond_destroy_internal(link2cond(holder), q);
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		xnprintf
-		    ("Posix: destroying condition variable %p.\n",
-		     link2cond(holder));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+
+		if (XENO_DEBUG(POSIX))
+			xnprintf("Posix: destroying condition variable %p.\n",
+				 link2cond(holder));
+
 		xnlock_get_irqsave(&nklock, s);
 	}
=20
Index: xenomai/ksrc/skins/posix/internal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/internal.h
+++ xenomai/ksrc/skins/posix/internal.h
@@ -25,6 +25,13 @@
 #include <posix/posix.h>
 #include <posix/registry.h>
=20
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/mq.c
+++ xenomai/ksrc/skins/posix/mq.c
@@ -1127,10 +1127,9 @@ int mq_notify(mqd_t fd, const struct sig
 static void uqd_cleanup(pse51_assoc_t *assoc)
 {
 	pse51_ufd_t *ufd =3D assoc2ufd(assoc);
-#ifdef CONFIG_XENO_OPT_DEBUG
-	xnprintf("Posix: closing message queue descriptor %lu.\n",
-		 pse51_assoc_key(assoc));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+	if (XENO_DEBUG(POSIX))
+		xnprintf("Posix: closing message queue descriptor %lu.\n",
+			 pse51_assoc_key(assoc));
 	mq_close(ufd->kfd);
 	xnfree(ufd);
 }
@@ -1159,12 +1158,13 @@ void pse51_mq_pkg_cleanup(void)
 		pse51_node_t *node;
 		pse51_node_remove(&node, mq->nodebase.name, PSE51_MQ_MAGIC);
 		xnlock_put_irqrestore(&nklock, s);
+
 		pse51_mq_destroy(mq);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		xnprintf("Posix: unlinking message queue \"%s\".\n",
-			 mq->nodebase.name);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+		if (XENO_DEBUG(POSIX))
+			xnprintf("Posix: unlinking message queue \"%s\".\n",
+				 mq->nodebase.name);
 		xnfree(mq);
+
 		xnlock_get_irqsave(&nklock, s);
 	}
 	xnlock_put_irqrestore(&nklock, s);
Index: xenomai/ksrc/skins/posix/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/mutex.c
+++ xenomai/ksrc/skins/posix/mutex.c
@@ -504,9 +504,11 @@ void pse51_mutexq_cleanup(pse51_kqueues_
 	while ((holder =3D getheadq(&q->mutexq)) !=3D NULL) {
 		pse51_mutex_destroy_internal(link2mutex(holder), q);
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		xnprintf("Posix: destroying mutex %p.\n", link2mutex(holder));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+
+		if (XENO_DEBUG(POSIX))
+			xnprintf("Posix: destroying mutex %p.\n",
+				 link2mutex(holder));
+
 		xnlock_get_irqsave(&nklock, s);
 	}
=20
Index: xenomai/ksrc/skins/posix/registry.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/registry.c
+++ xenomai/ksrc/skins/posix/registry.c
@@ -488,18 +488,20 @@ void pse51_reg_pkg_cleanup(void)
 	unsigned i;
 	for (i =3D 0; i < pse51_reg.maxfds; i++)
 		if (pse51_reg.descs[i]) {
-#ifdef CONFIG_XENO_OPT_DEBUG
-			xnprintf("Posix: destroying descriptor %d.\n",i);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+			if (XENO_DEBUG(POSIX))
+				xnprintf("Posix: destroying descriptor %d.\n",
+					 i);
 			pse51_desc_destroy(pse51_reg.descs[i]);
 		}
-#ifdef CONFIG_XENO_OPT_DEBUG
-	for (i =3D 0; i < pse51_reg.buckets_count; i++) {
-		pse51_node_t *node;
-		for (node =3D pse51_reg.node_buckets[i]; node; node =3D node->next)
-			xnprintf("Posix: node \"%s\" left aside.\n", node->name);
-	}
-#endif /* CONFIG_XENO_OPT_DEBUG */
+	if (XENO_DEBUG(POSIX))
+		for (i =3D 0; i < pse51_reg.buckets_count; i++) {
+			pse51_node_t *node;
+			for (node =3D pse51_reg.node_buckets[i];
+			     node;
+			     node =3D node->next)
+				xnprintf("Posix: node \"%s\" left aside.\n",
+					 node->name);
+		}
=20
 	size =3D sizeof(pse51_node_t) * pse51_reg.buckets_count
 		+ sizeof(pse51_desc_t) * pse51_reg.maxfds
Index: xenomai/ksrc/skins/posix/sem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/sem.c
+++ xenomai/ksrc/skins/posix/sem.c
@@ -760,9 +760,9 @@ static void usem_cleanup(pse51_assoc_t *
 	pse51_usem_t *usem =3D assoc2usem(assoc);
 	nsem_t *nsem =3D sem2named_sem(sem);
=20
-#ifdef CONFIG_XENO_OPT_DEBUG
-	xnprintf("Posix: closing semaphore \"%s\".\n", nsem->nodebase.name);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+	if (XENO_DEBUG(POSIX))
+		xnprintf("Posix: closing semaphore \"%s\".\n",
+			 nsem->nodebase.name);
 	sem_close(&nsem->descriptor.native_sem);
 	xnfree(usem);
 }
@@ -784,13 +784,17 @@ void pse51_semq_cleanup(pse51_kqueues_t=20
 		pse51_sem_t *sem =3D link2sem(holder);
 		pse51_node_t *node;
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		if (sem->is_named)=20
-			xnprintf("Posix: unlinking semaphore \"%s\".\n",
-				 sem2named_sem(sem)->nodebase.name);
-		else
-			xnprintf("Posix: destroying semaphore %p.\n",sem);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+
+		if (XENO_DEBUG(POSIX)) {
+			if (sem->is_named)
+				xnprintf("Posix: unlinking semaphore "
+					 "\"%s\".\n",
+					 sem2named_sem(sem)->nodebase.name);
+			else
+				xnprintf("Posix: destroying semaphore %p.\n",
+					 sem);
+		}
+
 		xnlock_get_irqsave(&nklock, s);
 		if (sem->is_named)
 			pse51_node_remove(&node,
Index: xenomai/ksrc/skins/posix/shm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/shm.c
+++ xenomai/ksrc/skins/posix/shm.c
@@ -880,10 +880,9 @@ int pse51_xnheap_get(xnheap_t **pheap, v
 static void ufd_cleanup(pse51_assoc_t *assoc)
 {
 	pse51_ufd_t *ufd =3D assoc2ufd(assoc);
-#ifdef CONFIG_XENO_OPT_DEBUG
-	xnprintf("Posix: closing shared memory descriptor %lu.\n",
-		 pse51_assoc_key(assoc));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+	if (XENO_DEBUG(POSIX))
+		xnprintf("Posix: closing shared memory descriptor %lu.\n",
+			 pse51_assoc_key(assoc));
 	pse51_shm_close(ufd->kfd);
 	xnfree(ufd);
 }
@@ -891,10 +890,9 @@ static void ufd_cleanup(pse51_assoc_t *a
 static void umap_cleanup(pse51_assoc_t *assoc)
 {
 	pse51_umap_t *umap =3D assoc2umap(assoc);
-#ifdef CONFIG_XENO_OPT_DEBUG
-	xnprintf("Posix: unmapping shared memory 0x%08lx.\n",
-		 pse51_assoc_key(assoc));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+	if (XENO_DEBUG(POSIX))
+		xnprintf("Posix: unmapping shared memory 0x%08lx.\n",
+			 pse51_assoc_key(assoc));
 	munmap(umap->kaddr, umap->len);
 	xnfree(umap);
 }
@@ -931,10 +929,11 @@ void pse51_shm_pkg_cleanup(void)
=20
 		pse51_node_remove(&node, shm->nodebase.name, PSE51_SHM_MAGIC);
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		xnprintf("Posix: unlinking shared memory \"%s\".\n",
-			 shm->nodebase.name);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+
+		if (XENO_DEBUG(POSIX))
+			xnprintf("Posix: unlinking shared memory \"%s\".\n",
+				 shm->nodebase.name);
+
 		xnlock_get_irqsave(&nklock, s);
 		pse51_shm_destroy(shm, 1);
 	}
Index: xenomai/ksrc/skins/posix/signal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/signal.c
+++ xenomai/ksrc/skins/posix/signal.c
@@ -1211,15 +1211,15 @@ void pse51_signal_pkg_init(void)
=20
 void pse51_signal_pkg_cleanup(void)
 {
-#ifdef CONFIG_XENO_OPT_DEBUG
-	int i;
+	if (XENO_DEBUG(POSIX)) {
+		int i;
=20
-	for (i =3D 0; i < PSE51_SIGQUEUE_MAX; i++)
-		if (pse51_infos_pool[i].info.si_signo)
-			xnprintf
-			    ("Posix siginfo structure %p was not freed, freeing now.\n",
-			     &pse51_infos_pool[i].info);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+		for (i =3D 0; i < PSE51_SIGQUEUE_MAX; i++)
+			if (pse51_infos_pool[i].info.si_signo)
+				xnprintf("Posix siginfo structure %p was not "
+					 "freed, freeing now.\n",
+					 &pse51_infos_pool[i].info);
+	}
=20
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
 	rthal_apc_free(pse51_signals_apc);
Index: xenomai/ksrc/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/thread.c
+++ xenomai/ksrc/skins/posix/thread.c
@@ -712,9 +712,10 @@ void pse51_threadq_cleanup(pse51_kqueues
 			/* Remaining TCB (joinable thread, which was never joined). */
 			thread_destroy(thread);
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		xnprintf("POSIX: destroyed thread %p\n", thread);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+
+		if (XENO_DEBUG(POSIX))
+			xnprintf("POSIX: destroyed thread %p\n", thread);
+
 		xnlock_get_irqsave(&nklock, s);
 	}
=20
Index: xenomai/ksrc/skins/posix/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/timer.c
+++ xenomai/ksrc/skins/posix/timer.c
@@ -520,9 +520,10 @@ void pse51_timerq_cleanup(pse51_kqueues_
 		timer_t tm =3D (timer_t) (link2tm(holder, link) - timer_pool);
 		pse51_timer_delete_inner(tm, q);
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		xnprintf("Posix timer %u deleted\n", (unsigned) tm);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+
+		if (XENO_DEBUG(POSIX))
+			xnprintf("Posix timer %u deleted\n", (unsigned) tm);
+
 		xnlock_get_irqsave(&nklock, s);
 	}
=20
Index: xenomai/ksrc/skins/posix/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/intr.c
+++ xenomai/ksrc/skins/posix/intr.c
@@ -261,11 +261,12 @@ void pse51_intrq_cleanup(pse51_kqueues_t
 	while ((holder =3D getheadq(&q->intrq)) !=3D NULL) {
 		pthread_intr_detach_np(link2intr(holder));
 		xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_DEBUG
-		xnprintf
-		    ("Posix interruption handler %p was not destroyed,"
-		     " destroying now.\n", link2intr(holder));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+
+		if (XENO_DEBUG(POSIX))
+			xnprintf("Posix interruption handler %p was not "
+				 "destroyed, destroying now.\n",
+				 link2intr(holder));
+
 		xnlock_get_irqsave(&nklock, s);
 	}
=20
Index: xenomai/ksrc/skins/posix/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/Config.in
+++ xenomai/ksrc/skins/posix/Config.in
@@ -9,5 +9,6 @@ if [ "$CONFIG_XENO_SKIN_POSIX" !=3D "n" ];
 	comment 'POSIX interface options'
 	bool 'Shared memory' CONFIG_XENO_OPT_POSIX_SHM
 	bool 'Interrupts' CONFIG_XENO_OPT_POSIX_INTR
+	bool 'Debugging support' CONFIG_XENO_OPT_DEBUG_POSIX
 	endmenu
 fi
Index: xenomai/ksrc/skins/posix/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/Kconfig
+++ xenomai/ksrc/skins/posix/Kconfig
@@ -32,4 +32,11 @@ config XENO_OPT_POSIX_INTR
 	RTDM skin is the preferred way of implementing drivers), leave this
 	option unselected.
=20
+config XENO_OPT_DEBUG_POSIX
+	bool "Debugging support"
+	help
+
+	When enabled, this option makes the skin warn about not properly
+	cleaned up POSIX objects it detects on process termination.
+
 endif


--------------080804000805070003040706--

--------------enig4F1813CF85D6FBF2C64F193A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYjblniDOoMHTA+kRArz9AJ9htl0VH8EnJl9BgoBEHrUJ43uoOwCdG3dA
gsHiRZc7GTzO8SFDL+unW2k=
=mpg7
-----END PGP SIGNATURE-----

--------------enig4F1813CF85D6FBF2C64F193A--

