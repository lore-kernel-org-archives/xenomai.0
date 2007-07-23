From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1184933771.5998.3.camel@domain.hid>
References: <16123805.1184916759093.JavaMail.ngmail@domain.hid>
	<1184890451.28303.356.camel@domain.hid>
	<1184852543.28303.67.camel@domain.hid>
	<24703926.1184851660664.JavaMail.ngmail@domain.hid>
	<32098568.1184853156077.JavaMail.ngmail@domain.hid>
	<25782679.1184932464850.JavaMail.ngmail@domain.hid>
	<1184933771.5998.3.camel@domain.hid>
Content-Type: multipart/mixed; boundary="=-Q19w9xDIAzvVbc3YAZc5"
Date: Mon, 23 Jul 2007 17:01:47 +0200
Message-Id: <1185202908.5998.271.camel@domain.hid>
Mime-Version: 1.0
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] RPI is good for you
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org


--=-Q19w9xDIAzvVbc3YAZc5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2007-07-20 at 14:16 +0200, Philippe Gerum wrote: 
> On Fri, 2007-07-20 at 13:54 +0200, M. Koehrer wrote:
> > Hi Philippe,
> > I left my test running for a couple of hours - no freeze so far... 
> > 
> > However, I have to do some other stuff on this machine, I have to stop the test now...
> > 
> 
> Ok, thanks for the feedback. I will send an extended patch later today,
> so that you could test it on a longer period when you see fit.

It took me a bit longer than expected, but here is a patch which
addresses all the pending issues with RPI, hopefully (applies against
2.3.1 stock).

The good thing about Jan grumbling at me, is that this usually makes me
look at the big picture anew. And the RPI picture was not that nice,
that's a fact.

Beside the locking sequence issue, the ex-aequo #1 problem was that CPU
migration of Linux tasks causing a RPI boost had some very nasty
side-effects on RPI management, and would create all sort of funky
situations I'm too shameful to talk about, except under the generic term
of "horrendous mess".

Now, regarding the deadlock issue, suppressing the RPI-specific locking
entirely would have been the best solution, but unfortunately, the
migration scheme makes this out of reach, at least without resorting to
some hairy and likely unreliable implementation. Therefore, the solution
I came with consists of making the RPI lock a per-cpu thing, so that
most RPI routines are actually grabbing a _local_ lock wrt the current
CPU, those routines being allowed hold the nklock as they wish. When
some per-CPU RPI lock is accessed from a remote CPU, it is guaranteed
that _no nklock_ may be held nested. Actually, the remote case only
occurs once, in rpi_clear_remote(), and all its callers are guaranteed
to be nklock-free (a debug assertion even enforces that).

For the migration issue, the RPI transitions have been ironed out to
make sure we deal properly with all the subtleties of the Linux load
balancer.

Mathias, please let me know if the attached patch improves the situation
on your side.

-- 
Philippe.



--=-Q19w9xDIAzvVbc3YAZc5
Content-Disposition: attachment; filename=fix-rpi-cpu-migration.patch
Content-Type: text/x-patch; name=fix-rpi-cpu-migration.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -uNrp xenomai-2.3.1/include/asm-generic/system.h xenomai-2.3.1-rpi/include/asm-generic/system.h
--- xenomai-2.3.1/include/asm-generic/system.h	2007-03-18 17:02:02.000000000 +0100
+++ xenomai-2.3.1-rpi/include/asm-generic/system.h	2007-07-23 14:05:54.000000000 +0200
@@ -374,6 +374,11 @@ static inline int xnarch_send_ipi (xnarc
     return rthal_send_ipi(RTHAL_SERVICE_IPI0, cpumask);
 }
 
+static inline int xnlock_is_owner(xnlock_t *lock)
+{
+	return atomic_read(&lock->owner) == xnarch_current_cpu();
+}
+
 #else /* !CONFIG_SMP */
 
 #define xnlock_init(lock)              do { } while(0)
@@ -383,6 +388,7 @@ static inline int xnarch_send_ipi (xnarc
 #define xnlock_put_irqrestore(lock,x)  rthal_local_irq_restore(x)
 #define xnlock_clear_irqoff(lock)      rthal_local_irq_disable()
 #define xnlock_clear_irqon(lock)       rthal_local_irq_enable()
+#define xnlock_is_owner(lock)	       1
 
 static inline int xnarch_send_ipi (xnarch_cpumask_t cpumask)
 {
diff -uNrp xenomai-2.3.1/include/nucleus/core.h xenomai-2.3.1-rpi/include/nucleus/core.h
--- xenomai-2.3.1/include/nucleus/core.h	2007-02-01 20:00:27.000000000 +0100
+++ xenomai-2.3.1-rpi/include/nucleus/core.h	2007-07-23 14:05:54.000000000 +0200
@@ -33,9 +33,11 @@
 /* Visible priority range supported by the core pod. */
 #define XNCORE_MIN_PRIO     0
 #define XNCORE_MAX_PRIO     257
+/* Base priority of the root thread for the core pod. */
+#define XNCORE_IDLE_PRIO    -1
 
 /* Total number of priority levels (including the hidden root one) */
-#define XNCORE_NR_PRIO      (XNCORE_MAX_PRIO - XNCORE_MIN_PRIO + 2)
+#define XNCORE_NR_PRIO      (XNCORE_MAX_PRIO - XNCORE_IDLE_PRIO + 1)
 
 /* Priority sub-range used by core APIs. */
 #define XNCORE_LOW_PRIO     0
@@ -44,9 +46,6 @@
 /* Priority of IRQ servers in user-space. */
 #define XNCORE_IRQ_PRIO     XNCORE_MAX_PRIO
 
-/* Base priority of the root thread for the core pod. */
-#define XNCORE_BASE_PRIO    -1
-
 #ifdef __KERNEL__
 
 #ifdef __cplusplus
diff -uNrp xenomai-2.3.1/include/nucleus/pod.h xenomai-2.3.1-rpi/include/nucleus/pod.h
--- xenomai-2.3.1/include/nucleus/pod.h	2007-03-18 17:02:02.000000000 +0100
+++ xenomai-2.3.1-rpi/include/nucleus/pod.h	2007-07-23 14:05:54.000000000 +0200
@@ -336,6 +336,11 @@ static inline void xnpod_renice_root(int
 	xnlock_put_irqrestore(&nklock, s);
 }
 
+static inline int xnpod_root_priority(void)
+{
+	return xnthread_current_priority(xnpod_current_root());
+}
+
 static inline int xnpod_get_qdir(xnpod_t *pod)
 {
 	/* Returns the queuing direction of threads for a given pod */
diff -uNrp xenomai-2.3.1/include/nucleus/queue.h xenomai-2.3.1-rpi/include/nucleus/queue.h
--- xenomai-2.3.1/include/nucleus/queue.h	2007-02-04 12:24:23.000000000 +0100
+++ xenomai-2.3.1-rpi/include/nucleus/queue.h	2007-07-23 14:09:20.000000000 +0200
@@ -104,7 +104,8 @@ do { \
     while (curr != &(__qslot)->head && nelems < (__qslot)->elems)	\
         curr = curr->last, nelems++; \
     if (curr != &(__qslot)->head || nelems != (__qslot)->elems)	  \
-        xnpod_fatal("corrupted queue, qslot->elems=%d, qslot=%p at %s:%d", \
+	xnpod_fatal("corrupted queue, qslot->elems=%d/%d, qslot=%p at %s:%d", \
+		    nelems,				\
                     (__qslot)->elems,				  \
                     __qslot,					  \
 		    __FILE__,__LINE__);				  \
@@ -746,14 +747,22 @@ static inline xnpholder_t *findmlqh(xnml
 
 static inline xnpholder_t *getheadmlq(xnmlqueue_t *mlqslot)
 {
+    xnpholder_t *pholder;
     xnqueue_t *queue;
 
     if (emptymlq_p(mlqslot))
         return NULL;
 
     queue = &mlqslot->queue[ffsmlq(mlqslot)];
-    
-    return (xnpholder_t *)getheadq(queue);
+    holder = (xnpholder_t *)getheadq(queue);
+
+    XENO_ASSERT(QUEUES, holder,
+		xnpod_fatal
+		("corrupted multi-level queue, qslot=%p at %s:%d", mlqslot,
+		 __FILE__, __LINE__);
+		);
+
+    return holder;
 }
 
 static inline xnpholder_t *getmlq(xnmlqueue_t *mlqslot)
@@ -775,12 +784,11 @@ static inline xnpholder_t *getmlq(xnmlqu
 		    __FILE__,__LINE__);
         );
 
-    hi = idx / BITS_PER_LONG;
-    lo = idx % BITS_PER_LONG;
-
     mlqslot->elems--;    
 
     if (emptyq_p(queue)) {
+	hi = idx / BITS_PER_LONG;
+        lo = idx % BITS_PER_LONG;
         __clrbits(mlqslot->lomap[hi],1 << lo);
 	if (mlqslot->lomap[hi] == 0)
 	    __clrbits(mlqslot->himap,1 << hi);
diff -uNrp xenomai-2.3.1/include/nucleus/thread.h xenomai-2.3.1-rpi/include/nucleus/thread.h
--- xenomai-2.3.1/include/nucleus/thread.h	2007-03-15 15:10:30.000000000 +0100
+++ xenomai-2.3.1-rpi/include/nucleus/thread.h	2007-07-23 14:05:54.000000000 +0200
@@ -168,9 +168,7 @@ typedef struct xnthread {
 
     xnholder_t glink;		/* Thread holder in global queue */
 
-/* We don't want side-effects on laddr here! */
-#define link2thread(laddr,link) \
-((xnthread_t *)(((char *)laddr) - (int)(&((xnthread_t *)0)->link)))
+#define link2thread(ln, fld)	container_of(ln, xnthread_t, fld)
 
     xnpqueue_t claimq;		/* Owned resources claimed by others (PIP) */
 
diff -uNrp xenomai-2.3.1/ksrc/nucleus/pod.c xenomai-2.3.1-rpi/ksrc/nucleus/pod.c
--- xenomai-2.3.1/ksrc/nucleus/pod.c	2007-03-19 12:14:13.000000000 +0100
+++ xenomai-2.3.1-rpi/ksrc/nucleus/pod.c	2007-07-23 14:05:54.000000000 +0200
@@ -1242,10 +1242,52 @@ void xnpod_delete_thread(xnthread_t *thr
 	if (xnthread_test_state(thread, XNZOMBIE))
 		goto unlock_and_exit;	/* No double-deletion. */
 
-	xnltt_log_event(xeno_ev_thrdelete, thread->name);
-
 	sched = thread->sched;
 
+#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
+	/*
+	 * This block serves two purposes:
+	 *
+	 * 1) Make sure Linux counterparts of shadow threads do exit
+	 * upon deletion request from the nucleus through a call to
+	 * xnpod_delete_thread().
+	 *
+	 * 2) Make sure shadow threads are removed from the system on
+	 * behalf of their own context, by sending them a lethal
+	 * signal when it is not the case instead of wiping out their
+	 * TCB. In such a case, the deletion is asynchronous, and
+	 * killed thread will later enter xnpod_delete_thread() from
+	 * the exit notification handler (I-pipe).
+	 *
+	 * Sidenote: xnpod_delete_thread() might be called for
+	 * cleaning up a just created shadow task which has not been
+	 * successfully mapped, so we need to make sure that we have
+	 * an associated Linux mate before trying to send it a signal
+	 * (i.e. user_task extension != NULL). This will also prevent
+	 * any action on kernel-based Xenomai threads for which the
+	 * user TCB extension is always NULL.  We don't send any
+	 * signal to dormant threads because GDB (6.x) has some
+	 * problems dealing with vanishing threads under some
+	 * circumstances, likely when asynchronous cancellation is in
+	 * effect. In most cases, this is a non-issue since
+	 * pthread_cancel() is requested from the skin interface
+	 * library in parallel on the target thread. In the rare case
+	 * of calling xnpod_delete_thread() from kernel space against
+	 * a created but unstarted user-space task, the Linux thread
+	 * mated to the Xenomai shadow might linger unexpectedly on
+	 * the startup barrier.
+	 */
+
+	if (xnthread_user_task(thread) != NULL &&
+	    !xnthread_test_state(thread, XNDORMANT) &&
+	    thread != sched->runthread) {
+		xnshadow_send_sig(thread, SIGKILL, 1);
+		goto unlock_and_exit;
+	}
+#endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */
+
+	xnltt_log_event(xeno_ev_thrdelete, thread->name);
+
 	removeq(&nkpod->threadq, &thread->glink);
 	nkpod->threadq_rev++;
 
diff -uNrp xenomai-2.3.1/ksrc/nucleus/shadow.c xenomai-2.3.1-rpi/ksrc/nucleus/shadow.c
--- xenomai-2.3.1/ksrc/nucleus/shadow.c	2007-03-19 14:19:49.000000000 +0100
+++ xenomai-2.3.1-rpi/ksrc/nucleus/shadow.c	2007-07-23 14:10:29.000000000 +0200
@@ -75,6 +75,9 @@ static struct __gatekeeper {
 	struct linux_semaphore sync;
 	xnthread_t *thread;
 	struct xnrpi {
+#ifdef CONFIG_SMP
+		xnlock_t lock;
+#endif /* CONFIG_SMP */
 		xnsched_queue_t threadq;
 	} rpislot;
 
@@ -121,20 +124,13 @@ void xnpod_discard_iface_proc(struct xns
 
 #ifndef CONFIG_XENO_OPT_RPIDISABLE
 
-#ifdef CONFIG_SMP
-static xnlock_t rpilock = XNARCH_LOCK_UNLOCKED;
-#endif /* CONFIG_SMP */
-
 #define rpi_p(t)	((t)->rpi != NULL)
 
-static inline void rpi_init(void)
-{
-	xnlock_init(&rpilock);
-}
-
 static inline void rpi_init_gk(struct __gatekeeper *gk)
 {
-	sched_initpq(&gk->rpislot.threadq, xnqueue_down, XNCORE_NR_PRIO);
+ 	struct xnrpi *rpislot = &gk->rpislot;
+ 	xnlock_init(&rpislot->lock);
+ 	sched_initpq(&rpislot->threadq, xnqueue_down, XNCORE_NR_PRIO);
 }
 
 static inline void rpi_none(xnthread_t *thread)
@@ -144,12 +140,12 @@ static inline void rpi_none(xnthread_t *
 
 static void rpi_push(xnthread_t *thread)
 {
-	struct __gatekeeper *gk;
+	struct xnrpi *rpislot;
 	xnthread_t *top;
 	int prio;
 	spl_t s;
 
-	gk = &gatekeeper[rthal_processor_id()];
+	rpislot = &gatekeeper[rthal_processor_id()].rpislot;
 
 	/* non-RT shadows and RT shadows which disabled RPI cause the
 	   root priority to be lowered to its base level. The purpose
@@ -160,187 +156,241 @@ static void rpi_push(xnthread_t *thread)
 
 	if (likely(xnthread_user_task(thread)->policy == SCHED_FIFO &&
 		   !xnthread_test_state(thread, XNRPIOFF))) {
-		xnlock_get_irqsave(&rpilock, s);
+		xnlock_get_irqsave(&rpislot->lock, s);
 
 		if (XENO_DEBUG(NUCLEUS) && rpi_p(thread))
 			xnpod_fatal("re-enqueuing a relaxed thread in the RPI queue");
 
-		sched_insertpqf(&gk->rpislot.threadq, &thread->xlink, xnthread_current_priority(thread));
-		thread->rpi = &gk->rpislot;
+		sched_insertpqf(&rpislot->threadq, &thread->xlink, xnthread_current_priority(thread));
+		thread->rpi = rpislot;
 
-		top = link2thread(sched_getheadpq(&gk->rpislot.threadq), xlink);
+		top = link2thread(sched_getheadpq(&rpislot->threadq), xlink);
 		prio = xnthread_current_priority(top);
-		xnlock_put_irqrestore(&rpilock, s);
+		xnlock_put_irqrestore(&rpislot->lock, s);
 	} else
-		prio = XNCORE_BASE_PRIO;
+		prio = XNCORE_IDLE_PRIO;
 
-	xnpod_renice_root(prio);
+	if (xnpod_root_priority() != prio)
+		xnpod_renice_root(prio);
 }
 
 static void rpi_pop(xnthread_t *thread)
 {
-	struct __gatekeeper *gk;
+	struct xnrpi *rpislot;
 	int prio;
 	spl_t s;
 
-	gk = &gatekeeper[rthal_processor_id()];
+	rpislot = &gatekeeper[rthal_processor_id()].rpislot;
 
-	xnlock_get_irqsave(&rpilock, s);
+	xnlock_get_irqsave(&rpislot->lock, s);
 
 	/* Make sure we don't try to unlink a shadow which is not
-	   linked to the RPI queue. We must be known by the current
-	   RPI slot here, or not be linked at all to any RPI slot. */
-	if (unlikely(!rpi_p(thread))) {
-		xnlock_put_irqrestore(&rpilock, s);
+	   linked to the local RPI queue. This may happen in case a
+	   hardening thread is migrated by the kernel while in flight
+	   to the primary mode. */
+
+	if (likely(thread->rpi == rpislot)) {
+		sched_removepq(&rpislot->threadq, &thread->xlink);
+		rpi_none(thread);
+	} else if (!rpi_p(thread)) {
+		xnlock_put_irqrestore(&rpislot->lock, s);
 		return;
 	}
 
-	sched_removepq(&gk->rpislot.threadq, &thread->xlink);
-	rpi_none(thread);
-
-	if (likely(sched_emptypq_p(&gk->rpislot.threadq)))
-		prio = XNCORE_BASE_PRIO;
+	if (likely(sched_emptypq_p(&rpislot->threadq)))
+		prio = XNCORE_IDLE_PRIO;
 	else {
-		xnthread_t *top = link2thread(sched_getheadpq(&gk->rpislot.threadq), xlink);
+		xnpholder_t *pholder = sched_getheadpq(&rpislot->threadq);
+		xnthread_t *top = link2thread(pholder, xlink);
 		prio = xnthread_current_priority(top);
 	}
 
-	xnlock_put_irqrestore(&rpilock, s);
+	xnlock_put_irqrestore(&rpislot->lock, s);
 
-	xnpod_renice_root(prio);
+	if (xnpod_root_priority() != prio)
+		xnpod_renice_root(prio);
 }
 
-static inline void rpi_update(xnthread_t *thread)
+static void rpi_update(xnthread_t *thread)
 {
+	struct xnrpi *rpislot;
 	spl_t s;
 
-	/* This is the only place where we could unlink a thread from
-	 * a remote RPI slot (after a migration within the Linux
-	 * domain), so let's use the backlink pointer the thread
-	 * provides to fetch the actual slot it is supposed to be
-	 * linked to, _not_ the gatekeeper's RPI slot for the current
-	 * CPU. */
-	xnlock_get_irqsave(&rpilock, s);
+	rpislot = &gatekeeper[rthal_processor_id()].rpislot;
+	xnlock_get_irqsave(&rpislot->lock, s);
+	sched_removepq(&rpislot->threadq, &thread->xlink);
+	rpi_none(thread);
+	rpi_push(thread);
+	xnlock_put_irqrestore(&rpislot->lock, s);
+}
+
+#ifdef CONFIG_SMP
+
+static void rpi_clear_remote(xnthread_t *thread)
+{
+	struct xnrpi *rpislot;
+	int rcpu = -1;
+	spl_t s;
 
-	if (unlikely(!rpi_p(thread))) {
-		xnlock_put_irqrestore(&rpilock, s);
+	/*
+	 * This is the only place where we may touch a remote RPI slot
+	 * (after a migration within the Linux domain), so let's use
+	 * the backlink pointer the thread provides to fetch the
+	 * actual slot it is supposed to be linked to, _not_ the
+	 * gatekeeper's RPI slot for the current CPU.
+	 *
+	 * BIG FAT WARNING: The nklock must NOT be held when entering
+	 * this routine, otherwise a deadlock would be possible,
+	 * caused by conflicting locking sequences between the per-CPU
+	 * RPI lock and the nklock.
+	 */
+
+	if (XENO_DEBUG(NUCLEUS) && xnlock_is_owner(&nklock))
+		xnpod_fatal("nklock held while calling %s - this may deadlock!",
+			    __FUNCTION__);
+
+	rpislot = thread->rpi;
+
+	if (unlikely(rpislot == NULL))
 		return;
-	}
 
-	sched_removepq(&thread->rpi->threadq, &thread->xlink);
+	xnlock_get_irqsave(&rpislot->lock, s);
 
-#ifdef CONFIG_SMP
+	/* The RPI slot - if present - is always valid, and won't
+	 * change since the thread is resuming on this CPU and cannot
+	 * migrate under our feet. We may grab the remote slot lock
+	 * now. */
+
+	sched_removepq(&rpislot->threadq, &thread->xlink);
+	rpi_none(thread);
 
-	/* Ok, this one is not trivial. Unless a relaxed shadow has
+	if (sched_emptypq_p(&rpislot->threadq))
+		rcpu = container_of(rpislot, struct __gatekeeper, rpislot) - gatekeeper;
+
+	xnlock_put_irqrestore(&rpislot->lock, s);
+
+	/*
+	 * Ok, this one is not trivial. Unless a relaxed shadow has
 	 * forced its CPU affinity, it may migrate to another CPU as a
 	 * result of Linux's load balancing strategy. If the last
-	 * relaxed Xenomai thread is moved while in a blocked state
-	 * from a CPU (i.e. != TASK_RUNNING), there is no way for
-	 * rpi_switch() to lower the root thread priority, since
-	 * do_schedule_event() is only called for incoming/outgoing
-	 * Xenomai shadows, and not for regular Linux tasks. This
-	 * would leave the Xenomai root thread for the source CPU with
-	 * a boosted priority, inherited from the last migrated
-	 * shadow. To prevent this, we send an IPI to the source CPU
-	 * when a migration is detected from the destination CPU, so
-	 * that it could adjust its root thread priority whenever no
-	 * other relaxed shadow is undergoing a RPI boost. */
-
-	if (sched_emptypq_p(&thread->rpi->threadq)) {
-		int rcpu = container_of(thread->rpi, struct __gatekeeper, rpislot) - gatekeeper;
-		if (rcpu != rthal_processor_id()) {
-			xnsched_t *rsched = xnpod_sched_slot(rcpu);
-			if (!testbits(rsched->status, XNRPICK)) {
-				xnarch_cpumask_t cpumask;
-				setbits(rsched->status, XNRPICK);
-				xnarch_cpus_clear(cpumask);
-				xnarch_cpu_set(rcpu, cpumask);
-				xnarch_send_ipi(cpumask);
-			}
+	 * relaxed Xenomai thread migrates, there is no way for
+	 * rpi_switch() to lower the root thread priority on the
+	 * source CPU, since do_schedule_event() is only called for
+	 * incoming/outgoing Xenomai shadows. This would leave the
+	 * Xenomai root thread for the source CPU with a boosted
+	 * priority. To prevent this, we send an IPI from the
+	 * destination CPU to the source CPU when a migration is
+	 * detected, so that the latter could adjust its root thread
+	 * priority.
+	 */
+	if (rcpu != -1 && rcpu != rthal_processor_id()) {
+		xnsched_t *rsched = xnpod_sched_slot(rcpu);
+		if (!testbits(rsched->status, XNRPICK)) {
+			xnarch_cpumask_t cpumask;
+			setbits(rsched->status, XNRPICK);
+			xnarch_cpus_clear(cpumask);
+			xnarch_cpu_set(rcpu, cpumask);
+			xnarch_send_ipi(cpumask);
 		}
 	}
-#endif
+}
 
-	rpi_none(thread);
+static void rpi_migrate(xnthread_t *thread)
+{
+	rpi_clear_remote(thread);
 	rpi_push(thread);
-	xnlock_put_irqrestore(&rpilock, s);
 }
 
+#else  /* !CONFIG_SMP */
+#define rpi_clear_remote(t)	do { } while(0)
+#define rpi_migrate(t)		do { } while(0)
+#endif	/* !CONFIG_SMP */
+
 static inline void rpi_switch(struct task_struct *next)
 {
 	xnthread_t *threadin, *threadout;
-	struct __gatekeeper *gk;
+	struct xnrpi *rpislot;
 	int oldprio, newprio;
 	spl_t s;
 
 	threadout = xnshadow_thread(current);
 	threadin = xnshadow_thread(next);
-	gk = &gatekeeper[rthal_processor_id()];
-	oldprio = xnthread_current_priority(xnpod_current_root());
+	rpislot = &gatekeeper[rthal_processor_id()].rpislot;
+	oldprio = xnpod_root_priority();
 
 	if (threadout &&
 	    current->state != TASK_RUNNING &&
 	    !xnthread_test_info(threadout, XNATOMIC)) {
-		/* A blocked Linux task must be removed from the RPI
+		/*
+		 * A blocked Linux task must be removed from the RPI
 		 * list. Checking for XNATOMIC prevents from unlinking
 		 * a thread which is currently in flight to the
 		 * primary domain (see xnshadow_harden()); not doing
 		 * so would open a tiny window for priority
-		 * inversion. */
-		xnlock_get_irqsave(&rpilock, s);
-		if (threadout->rpi != NULL) {
-			sched_removepq(&gk->rpislot.threadq, &threadout->xlink);
+		 * inversion.
+		 *
+		 * BIG FAT WARNING: Do not consider a blocked thread
+		 * linked to another processor's RPI list for removal,
+		 * since this may happen if such thread immediately
+		 * resumes on the remote CPU.
+		 */
+		xnlock_get_irqsave(&rpislot->lock, s);
+		if (threadout->rpi == rpislot) {
+			sched_removepq(&rpislot->threadq, &threadout->xlink);
 			rpi_none(threadout);
 		}
-		xnlock_put_irqrestore(&rpilock, s);
+		xnlock_put_irqrestore(&rpislot->lock, s);
 	}
 
-	if (threadin != NULL &&
-	    next->policy == SCHED_FIFO &&
-	    !xnthread_test_state(threadin, XNRPIOFF)) {
-		newprio = xnthread_current_priority(threadin);
-
-		/* Be careful about two issues affecting a task's RPI
-		 * state here:
-		 *
-		 * 1) A relaxed shadow awakes (Linux-wise) after a
-		 * blocked state, which caused it to be removed from
-		 * the RPI list while it was sleeping; we have to link
-		 * it back again as it resumes.
-		 *
-		 * 2) A relaxed shadow has migrated from another CPU,
-		 * in that case, we end up having a thread linked to
-		 * an RPI slot which is _not_ the current gatekeeper's
-		 * one (keep in mind that we don't care about
-		 * migrations handled by Xenomai in primary mode,
-		 * since the shadow would not be linked to any RPI
-		 * queue in the first place).  Since a migration must
-		 * happen while the task is off the CPU Linux-wise,
-		 * rpi_switch() will be called upon resumption on the
-		 * target CPU by the Linux scheduler. At that point,
-		 * we just need to update the RPI information in case
-		 * the RPI queue backlink does not match the
-		 * gatekeeper's RPI slot for the current CPU. */
-
-		if (unlikely(threadin->rpi == NULL)) {
-			xnlock_get_irqsave(&rpilock, s);
-			sched_insertpqf(&gk->rpislot.threadq, &threadin->xlink, newprio);
-			threadin->rpi = &gk->rpislot;
-			xnlock_put_irqrestore(&rpilock, s);
-		} else if (unlikely(threadin->rpi != &gk->rpislot))
-			rpi_update(threadin);
-	} else {
-		xnlock_get_irqsave(&rpilock, s);
+	if (threadin == NULL ||
+	    next->policy != SCHED_FIFO ||
+	    xnthread_test_state(threadin, XNRPIOFF)) {
+		xnlock_get_irqsave(&rpislot->lock, s);
 
-		if (!sched_emptypq_p(&gk->rpislot.threadq)) {
-			xnthread_t *top = link2thread(sched_getheadpq(&gk->rpislot.threadq), xlink);
+		if (!sched_emptypq_p(&rpislot->threadq)) {
+			xnpholder_t *pholder = sched_getheadpq(&rpislot->threadq);
+			xnthread_t *top = link2thread(pholder, xlink);
 			newprio = xnthread_current_priority(top);
 		} else
-			newprio = XNCORE_BASE_PRIO;
+			newprio = XNCORE_IDLE_PRIO;
 
-		xnlock_put_irqrestore(&rpilock, s);
+		xnlock_put_irqrestore(&rpislot->lock, s);
+		goto boost_root;
 	}
 
+	newprio = xnthread_current_priority(threadin);
+
+	/* Be careful about two issues affecting a task's RPI state
+	 * here:
+	 *
+	 * 1) A relaxed shadow awakes (Linux-wise) after a blocked
+	 * state, which caused it to be removed from the RPI list
+	 * while it was sleeping; we have to link it back again as it
+	 * resumes.
+	 *
+	 * 2) A relaxed shadow has migrated from another CPU, in that
+	 * case, we end up having a thread linked to an RPI slot which
+	 * is _not_ the current gatekeeper's one [sidenote: we don't
+	 * care about migrations handled by Xenomai in primary mode,
+	 * since the shadow would not be linked to any RPI queue in
+	 * the first place].  Since a migration must happen while the
+	 * task is off the CPU Linux-wise, rpi_switch() will be called
+	 * upon resumption on the target CPU by the Linux
+	 * scheduler. At that point, we just need to update the RPI
+	 * information in case the RPI queue backlink does not match
+	 * the gatekeeper's RPI slot for the current CPU. */
+
+	if (unlikely(threadin->rpi == NULL)) {
+		xnlock_get_irqsave(&rpislot->lock, s);
+		sched_insertpqf(&rpislot->threadq, &threadin->xlink, newprio);
+		threadin->rpi = rpislot;
+		xnlock_put_irqrestore(&rpislot->lock, s);
+	} else if (unlikely(threadin->rpi != rpislot))
+		/* We hold no lock here. */
+		rpi_migrate(threadin);
+
+boost_root:
+
 	if (newprio == oldprio)
 		return;
 
@@ -356,38 +406,36 @@ static inline void rpi_switch(struct tas
 		xnpod_schedule();
 }
 
-static inline void rpi_clear(void)
+static inline void rpi_clear_local(xnthread_t *thread)
 {
-	if (!xnshadow_thread(current))
-		xnpod_renice_root(XNCORE_BASE_PRIO);
+	if (thread == NULL && xnpod_root_priority() != XNCORE_IDLE_PRIO)
+		xnpod_renice_root(XNCORE_IDLE_PRIO);
 }
 
 #ifdef CONFIG_SMP
 
 void xnshadow_rpi_check(void)
 {
-	struct __gatekeeper *gk;
+	struct xnrpi *rpislot = &gatekeeper[rthal_processor_id()].rpislot;
  	spl_t s;
  
- 	gk = &gatekeeper[rthal_processor_id()];
- 
- 	xnlock_get_irqsave(&rpilock, s);
+ 	xnlock_get_irqsave(&rpislot->lock, s);
  
- 	if (sched_emptypq_p(&gk->rpislot.threadq)) {
- 		if (xnthread_current_priority(xnpod_current_root()) != XNCORE_BASE_PRIO)
- 			xnpod_renice_root(XNCORE_BASE_PRIO);
+ 	if (sched_emptypq_p(&rpislot->threadq)) {
+ 		if (xnpod_root_priority() != XNCORE_IDLE_PRIO)
+ 			xnpod_renice_root(XNCORE_IDLE_PRIO);
  	}
  
- 	xnlock_put_irqrestore(&rpilock, s);
+ 	xnlock_put_irqrestore(&rpislot->lock, s);
 }
 
 #endif	/* CONFIG_SMP */
  
 #else
 
-#define rpi_init(gk)		do { } while(0)
-#define rpi_init_gk(gk)	do { } while(0)
-#define rpi_clear()		do { } while(0)
+#define rpi_init_gk(gk)		do { } while(0)
+#define rpi_clear_local(t)	do { } while(0)
+#define rpi_clear_remote(t)	do { } while(0)
 #define rpi_push(t)		do { } while(0)
 #define rpi_pop(t)		do { } while(0)
 #define rpi_update(t)		do { } while(0)
@@ -731,7 +779,7 @@ static void lostage_handler(void *cookie
 			   the relaxed shadow actually resumes in
 			   secondary mode. */
 	
-			rpi_clear();
+			rpi_clear_local(xnshadow_thread(current));
 
 		do_wakeup:
 
@@ -827,7 +875,8 @@ static int gatekeeper_thread(void *data)
 		if (kthread_should_stop())
 			break;
 
-		xnlock_get_irqsave(&nklock, s);
+		/* Real-time shadow TCBs are always removed on behalf
+		   of the killed thread. */
 
 		thread = gk->thread;
 
@@ -836,6 +885,8 @@ static int gatekeeper_thread(void *data)
 		   pending request, just ignore the latter. */
 
 		if (xnthread_user_task(thread)->state == TASK_INTERRUPTIBLE) {
+			rpi_pop(thread);
+			xnlock_get_irqsave(&nklock, s);
 #ifdef CONFIG_SMP
 			/* If the task changed its CPU while in secondary mode,
 			   change the CPU of the underlying Xenomai shadow too. We
@@ -845,14 +896,12 @@ static int gatekeeper_thread(void *data)
 			thread->sched = xnpod_sched_slot(cpu);
 #endif /* CONFIG_SMP */
 			xnpod_resume_thread(thread, XNRELAX);
-			rpi_pop(thread);
 #ifdef CONFIG_XENO_OPT_ISHIELD
 			disengage_irq_shield();
 #endif /* CONFIG_XENO_OPT_ISHIELD */
 			xnpod_schedule();
+			xnlock_put_irqrestore(&nklock, s);
 		}
-
-		xnlock_put_irqrestore(&nklock, s);
 	}
 
 	return 0;
@@ -881,21 +930,35 @@ static int gatekeeper_thread(void *data)
 int xnshadow_harden(void)
 {
 	struct task_struct *this_task = current;
-	/* Linux is not allowed to migrate shadow mates on its own, and
-	   shadows cannot be migrated by anyone but themselves, so the cpu
-	   number is constant in this context, despite the potential for
-	   preemption. */
-	struct __gatekeeper *gk = &gatekeeper[task_cpu(this_task)];
-	xnthread_t *thread = xnshadow_thread(this_task);
+	struct __gatekeeper *gk;
+	xnthread_t *thread;
+	int gk_cpu;
+
+redo:
+	gk_cpu = task_cpu(this_task);
+	thread = xnshadow_thread(this_task);
 
 	if (!thread)
 		return -EPERM;
 
+	gk = &gatekeeper[gk_cpu];
+
 	if (signal_pending(this_task) || down_interruptible(&gk->sync))
 		/* Grab the request token. */
 		return -ERESTARTSYS;
 
-	xnltt_log_event(xeno_ev_primarysw, this_task->comm);
+	preempt_disable();
+
+	/* Assume that we might have been migrated while waiting for
+	 * the token. Redo acquisition in such a case, so that we
+	 * don't mistakenly send the request to the wrong
+	 * gatekeeper. */
+
+	if (gk_cpu != task_cpu(this_task)) {
+		preempt_enable();
+		up(&gk->sync);
+		goto redo;
+	}
 
 	/* Set up the request to move "current" from the Linux domain to
 	   the Xenomai domain. This will cause the shadow thread to resume
@@ -907,12 +970,13 @@ int xnshadow_harden(void)
 	   preemption and using the TASK_ATOMICSWITCH cumulative state
 	   provided by Adeos to Linux tasks. */
 
+	xnltt_log_event(xeno_ev_primarysw, this_task->comm);
+
 	gk->thread = thread;
 	xnthread_set_info(thread, XNATOMIC);
-	preempt_disable();
 	set_current_state(TASK_INTERRUPTIBLE | TASK_ATOMICSWITCH);
 	wake_up_interruptible_sync(&gk->waitq);
-	schedule();
+	schedule();	/* Will preempt_enable() thanks to TASK_ATOMICSWITCH */
 	xnthread_clear_info(thread, XNATOMIC);
 
 	/* Rare case: we might have been awaken by a signal before the
@@ -943,6 +1007,16 @@ int xnshadow_harden(void)
 
 	xnlock_clear_irqon(&nklock);
 
+	/*
+	 * Normally, we should not be linked to any RPI list at this
+	 * point, except if Linux sent us to another CPU while in
+	 * flight to the primary domain, waiting to be resumed by the
+	 * gatekeeper; in such a case, we must unlink from the remote
+	 * CPU's RPI list now.
+	 */
+	if (rpi_p(thread))
+		rpi_clear_remote(thread);
+
 	xnltt_log_event(xeno_ev_primary, thread->name);
 
 	return 0;
@@ -1082,7 +1156,7 @@ void xnshadow_exit(void)
  *
  * This service can be called from:
  *
- * - Regular user-space process. 
+ * - Regular user-space process.
  *
  * Rescheduling: always.
  *
@@ -1177,7 +1251,7 @@ void xnshadow_unmap(xnthread_t *thread)
 	    !testbits(xnpod_current_sched()->status, XNKCOUT))
 		xnpod_fatal("xnshadow_unmap() called from invalid context");
 
-	p = xnthread_archtcb(thread)->user_task;	/* May be != current */
+	p = xnthread_archtcb(thread)->user_task;
 
 	magic = xnthread_get_magic(thread);
 
@@ -1206,6 +1280,11 @@ void xnshadow_unmap(xnthread_t *thread)
 	if (!p)
 		return;
 
+	XENO_ASSERT(NUCLEUS, p == current,
+		    xnpod_fatal("%s invoked for a non-current task (t=%s/p=%s)",
+				__FUNCTION__, thread->name, p->comm);
+		);
+
 	xnshadow_thrptd(p) = NULL;
 
 	if (p->state != TASK_RUNNING)
@@ -1277,12 +1356,15 @@ void xnshadow_renice(xnthread_t *thread)
 {
 	/* Called with nklock locked, Xenomai interrupts off. */
 	struct task_struct *p = xnthread_archtcb(thread)->user_task;
+
 	/* We need to bound the priority values in the [1..MAX_RT_PRIO-1]
 	   range, since the core pod's priority scale is a superset of
 	   Linux's priority scale. */
 	int prio = normalize_priority(thread->cprio);
 	schedule_linux_call(LO_RENICE_REQ, p, prio);
-	if (!xnthread_test_state(thread, XNDORMANT))
+
+	if (!xnthread_test_state(thread, XNDORMANT) &&
+	    xnthread_sched(thread) == xnpod_current_sched())
 		rpi_update(thread);
 }
 
@@ -2014,7 +2096,7 @@ static inline void do_sigwake_event(stru
 	xnthread_t *thread = xnshadow_thread(p);
 	spl_t s;
 
-	if (!thread || xnthread_test_state(thread, XNROOT))	/* Eh? root as shadow? */
+	if (!thread)
 		return;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -2080,8 +2162,18 @@ static inline void do_setsched_event(str
 	if (xnthread_current_priority(thread) != priority) {
 		xnpod_renice_thread_inner(thread, priority, 0);
 		if (xnsched_resched_p()) {
-			if (current == p)
+			if (p == current)
+				/* Implies xnthread_sched(thread) == current_sched */
 				rpi_update(thread);
+			/*
+			 * rpi_switch() will fix things properly
+			 * otherwise.  This may delay the update if
+			 * the thread is running on the remote CPU
+			 * until it gets back into rpi_switch() as the
+			 * incoming thread anew, but this is
+			 * acceptable (i.e. strict ordering across
+			 * CPUs is not supported anyway).
+			 */
 			xnpod_schedule();
 		}
 	}
@@ -2272,8 +2364,6 @@ int xnshadow_mount(void)
 	lostage_apc =
 	    rthal_apc_alloc("lostage_handler", &lostage_handler, NULL);
 
-	rpi_init();
-
 	for_each_online_cpu(cpu) {
 		struct __gatekeeper *gk = &gatekeeper[cpu];
 		rpi_init_gk(gk);
diff -uNrp xenomai-2.3.1/ksrc/skins/native/task.c xenomai-2.3.1-rpi/ksrc/skins/native/task.c
--- xenomai-2.3.1/ksrc/skins/native/task.c	2007-02-28 18:25:52.000000000 +0100
+++ xenomai-2.3.1-rpi/ksrc/skins/native/task.c	2007-07-23 14:05:54.000000000 +0200
@@ -581,29 +581,6 @@ int rt_task_delete(RT_TASK *task)
 	if (err)
 		goto unlock_and_exit;
 
-#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
-	/* rt_task_delete() might be called for cleaning up a just
-	   created shadow task which has not been successfully mapped,
-	   so make sure we have an associated Linux mate before trying
-	   to send it a signal. This will also prevent any action on
-	   kernel-based Xenomai threads for which the user TCB
-	   extension is always NULL.
-	   We don't send any signal to dormant threads because GDB
-	   (6.x) has some problems dealing with vanishing threads
-	   under some circumstances, likely when asynchronous
-	   cancellation is in effect. In most cases, this is a
-	   non-issue since pthread_cancel() is requested from the skin
-	   interface library in parallel on the target thread, but
-	   when calling rt_task_delete() from kernel space against a
-	   created but unstarted user-space task, the Linux thread
-	   mated to the Xenomai shadow might linger unexpectedly on
-	   the startup barrier. */
-	if (xnthread_user_task(&task->thread_base) != NULL
-	    && !xnthread_test_state(&task->thread_base,XNDORMANT)
-	    && (!xnpod_primary_p() || task != xeno_current_task()))
-		xnshadow_send_sig(&task->thread_base, SIGKILL, 1);
-#endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */
-
 	/* Does not return if task is current. */
 	xnpod_delete_thread(&task->thread_base);
 
diff -uNrp xenomai-2.3.1/ksrc/skins/psos+/task.c xenomai-2.3.1-rpi/ksrc/skins/psos+/task.c
--- xenomai-2.3.1/ksrc/skins/psos+/task.c	2006-12-26 19:39:04.000000000 +0100
+++ xenomai-2.3.1-rpi/ksrc/skins/psos+/task.c	2007-07-23 14:05:54.000000000 +0200
@@ -284,13 +284,6 @@ u_long t_delete(u_long tid)
 		goto unlock_and_exit;
 	}
 
-#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
-	if (xnthread_user_task(&task->threadbase) != NULL
-	    && !xnthread_test_state(&task->threadbase,XNDORMANT)
-	    && (!xnpod_primary_p() || task != psos_current_task()))
-		xnshadow_send_sig(&task->threadbase, SIGKILL, 1);
-#endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */
-
 	xnpod_delete_thread(&task->threadbase);
 
       unlock_and_exit:
diff -uNrp xenomai-2.3.1/ksrc/skins/vxworks/taskLib.c xenomai-2.3.1-rpi/ksrc/skins/vxworks/taskLib.c
--- xenomai-2.3.1/ksrc/skins/vxworks/taskLib.c	2006-12-26 19:39:05.000000000 +0100
+++ xenomai-2.3.1-rpi/ksrc/skins/vxworks/taskLib.c	2007-07-23 14:05:54.000000000 +0200
@@ -285,13 +285,6 @@ STATUS taskDelete(TASK_ID task_id)
 		goto error;
 	}
 
-#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
-	if (xnthread_user_task(&task->threadbase) != NULL
-	    && !xnthread_test_state(&task->threadbase,XNDORMANT)
-	    && (!xnpod_primary_p() || task != wind_current_task()))
-		xnshadow_send_sig(&task->threadbase, SIGKILL, 1);
-#endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */
-
 	xnpod_delete_thread(&task->threadbase);
 	xnlock_put_irqrestore(&nklock, s);
 

--=-Q19w9xDIAzvVbc3YAZc5--


