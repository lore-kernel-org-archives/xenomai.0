Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F764A5.2090508@domain.hid>
Message-Id: <20081016154621.157659985@domain.hid>
Date: Thu, 16 Oct 2008 17:46:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081016154620.320953568@domain.hid>
Content-Disposition: inline; filename=factor-out-xnsynch_acquire-release.patch
Subject: [Xenomai-core] [PATCH 05/12] Factor out xnsynch_acquire/release
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

This patch addresses the increasing divergence of owner-tracking vs.
owner-less xnsynch objects.

Services dealing with the former will include the new, lockless xnsynch
prologue for optimizing its fastpath. At the the same time, this
additional code should not disturb too much in those cases where we do
not track ownership (condition variables, events, semaphores etc.).
Moreover, I noticed that some of the existing code assumes XNSYNCH_NOPIP
means no ownership, which is surely not true. The already visible effect
is that lock stealing is needlessly restricted to XNSYNCH_PIP.

Going through the API, I dug out three diverging services and replaced
them with two new ones:

Owner-less xnsynch objects:
 - xnsynch_sleep_on
 - xnsynch_wakeup_one_sleeper
 - xnsynch_wakeup_this_sleeper

Owner-tracking xnsynch objects:
 - xnsynch_acquire
 - xnsynch_release

The latter type of objects are marked with the new flag XNSYNCH_OWNER,
used only for debugging and code documentation purposes in the current
implementation.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/nucleus/synch.h     |   16 +
 include/rtdm/rtdm_driver.h  |    2 
 ksrc/nucleus/synch.c        |  418 +++++++++++++++++++++++++++++---------------
 ksrc/skins/native/cond.c    |    2 
 ksrc/skins/native/mutex.c   |    7 
 ksrc/skins/native/task.c    |    5 
 ksrc/skins/posix/cond.c     |    2 
 ksrc/skins/posix/mutex.c    |   10 -
 ksrc/skins/posix/mutex.h    |    6 
 ksrc/skins/rtai/sem.c       |   10 -
 ksrc/skins/rtdm/drvlib.c    |   15 -
 ksrc/skins/vrtx/mx.c        |    6 
 ksrc/skins/vxworks/semLib.c |    6 
 13 files changed, 326 insertions(+), 179 deletions(-)

Index: b/include/nucleus/synch.h
===================================================================
--- a/include/nucleus/synch.h
+++ b/include/nucleus/synch.h
@@ -30,10 +30,11 @@
 #define XNSYNCH_NOPIP   0x0
 #define XNSYNCH_PIP     0x2
 #define XNSYNCH_DREORD  0x4
+#define XNSYNCH_OWNER   0x8
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
-#define XNSYNCH_CLAIMED 0x8	/* Claimed by other thread(s) w/ PIP */
+#define XNSYNCH_CLAIMED 0x10	/* Claimed by other thread(s) w/ PIP */
 
 /* Spare flags usable by upper interfaces */
 #define XNSYNCH_SPARE0  0x01000000
@@ -105,13 +106,18 @@ void xnsynch_sleep_on(xnsynch_t *synch,
 
 struct xnthread *xnsynch_wakeup_one_sleeper(xnsynch_t *synch);
 
-struct xnthread *xnsynch_peek_pendq(xnsynch_t *synch);
-
 xnpholder_t *xnsynch_wakeup_this_sleeper(xnsynch_t *synch,
 					 xnpholder_t *holder);
 
-int xnsynch_flush(xnsynch_t *synch,
-		  xnflags_t reason);
+void xnsynch_acquire(xnsynch_t *synch,
+		     xnticks_t timeout,
+		     xntmode_t timeout_mode);
+
+struct xnthread *xnsynch_release(xnsynch_t *synch);
+
+struct xnthread *xnsynch_peek_pendq(xnsynch_t *synch);
+
+int xnsynch_flush(xnsynch_t *synch, xnflags_t reason);
 
 void xnsynch_release_all_ownerships(struct xnthread *thread);
 
Index: b/ksrc/nucleus/synch.c
===================================================================
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -59,6 +59,12 @@
  * - XNSYNCH_PRIO causes the threads waiting for the resource to pend
  * in priority order. Otherwise, FIFO ordering is used (XNSYNCH_FIFO).
  *
+ * - XNSYNCH_OWNER indicates that the synchronization object shall
+ * track its owning thread (required if XNSYNCH_PIP is selected). Note
+ * that setting this flag implies the use xnsynch_acquire and
+ * xnsynch_release instead of xnsynch_sleep_on and
+ * xnsynch_wakeup_one_sleeper/xnsynch_wakeup_this_sleeper.
+ *
  * - XNSYNCH_PIP causes the priority inheritance mechanism to be
  * automatically activated when a priority inversion is detected among
  * threads using this object. Otherwise, no priority inheritance takes
@@ -89,7 +95,7 @@ void xnsynch_init(xnsynch_t *synch, xnfl
 	initph(&synch->link);
 
 	if (flags & XNSYNCH_PIP)
-		flags |= XNSYNCH_PRIO;	/* Obviously... */
+		flags |= XNSYNCH_PRIO | XNSYNCH_OWNER;	/* Obviously... */
 
 	synch->status = flags & ~XNSYNCH_CLAIMED;
 	synch->owner = NULL;
@@ -98,6 +104,209 @@ void xnsynch_init(xnsynch_t *synch, xnfl
 	xnarch_init_display_context(synch);
 }
 
+/*!
+ * \fn void xnsynch_sleep_on(xnsynch_t *synch, xnticks_t timeout,
+ *                           xntmode_t timeout_mode);
+ * \brief Sleep on an ownerless synchronization object.
+ *
+ * Makes the calling thread sleep on the specified synchronization
+ * object, waiting for it to be signaled.
+ *
+ * This service should be called by upper interfaces wanting the
+ * current thread to pend on the given resource. It must not be used
+ * with synchronization objects that are supposed to track ownership
+ * (XNSYNCH_OWNER).
+ *
+ * @param synch The descriptor address of the synchronization object
+ * to sleep on.
+ *
+ * @param timeout The timeout which may be used to limit the time the
+ * thread pends on the resource. This value is a wait time given in
+ * ticks (see note). It can either be relative, absolute monotonic, or
+ * absolute adjustable depending on @a timeout_mode. Passing XN_INFINITE
+ * @b and setting @a mode to XN_RELATIVE specifies an unbounded wait. All
+ * other values are used to initialize a watchdog timer.
+ *
+ * @param timeout_mode The mode of the @a timeout parameter. It can
+ * either be set to XN_RELATIVE, XN_ABSOLUTE, or XN_REALTIME (see also
+ * xntimer_start()).
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Kernel-based task
+ * - User-space task
+ *
+ * Rescheduling: always.
+ *
+ * @note The @a timeout value will be interpreted as jiffies if the
+ * current thread is bound to a periodic time base (see
+ * xnpod_init_thread), or nanoseconds otherwise.
+ */
+
+void xnsynch_sleep_on(xnsynch_t *synch, xnticks_t timeout,
+		      xntmode_t timeout_mode)
+{
+	xnthread_t *thread = xnpod_current_thread();
+	spl_t s;
+
+	XENO_BUGON(NUCLEUS, testbits(synch->status, XNSYNCH_OWNER));
+
+	xnlock_get_irqsave(&nklock, s);
+
+	trace_mark(xn_nucleus_synch_sleepon,
+		   "thread %p thread_name %s synch %p",
+		   thread, xnthread_name(thread), synch);
+
+	if (!testbits(synch->status, XNSYNCH_PRIO)) /* i.e. FIFO */
+		appendpq(&synch->pendq, &thread->plink);
+	else /* i.e. priority-sorted */
+		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
+
+	xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+/*!
+ * \fn xnthread_t *xnsynch_wakeup_one_sleeper(xnsynch_t *synch);
+ * \brief Give the resource ownership to the next waiting thread.
+ *
+ * This service wakes up the thread which is currently leading the
+ * synchronization object's pending list. The sleeping thread is
+ * unblocked from its pending state, but no reschedule is performed.
+ *
+ * This service should be called by upper interfaces wanting to signal
+ * the given resource so that a single waiter is resumed. It must not
+ * be used with synchronization objects that are supposed to track
+ * ownership (XNSYNCH_OWNER not set).
+ *
+ * @param synch The descriptor address of the synchronization object
+ * whose ownership is changed.
+ *
+ * @return The descriptor address of the unblocked thread.
+ *
+ * Side-effects:
+ *
+ * - The effective priority of the previous resource owner might be
+ * lowered to its base priority value as a consequence of the priority
+ * inheritance boost being cleared.
+ *
+ * - The synchronization object ownership is transfered to the
+ * unblocked thread.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Interrupt service routine
+ * - Kernel-based task
+ * - User-space task
+ *
+ * Rescheduling: never.
+ */
+
+xnthread_t *xnsynch_wakeup_one_sleeper(xnsynch_t *synch)
+{
+	xnthread_t *thread = NULL;
+	xnpholder_t *holder;
+	spl_t s;
+
+	XENO_BUGON(NUCLEUS, testbits(synch->status, XNSYNCH_OWNER));
+
+	xnlock_get_irqsave(&nklock, s);
+
+	holder = getpq(&synch->pendq);
+
+	if (holder) {
+		thread = link2thread(holder, plink);
+		thread->wchan = NULL;
+		trace_mark(xn_nucleus_synch_wakeup_one,
+			   "thread %p thread_name %s synch %p",
+			   thread, xnthread_name(thread), synch);
+		xnpod_resume_thread(thread, XNPEND);
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	xnarch_post_graph_if(synch, 0, emptypq_p(&synch->pendq));
+
+	return thread;
+}
+
+/*!
+ * \fn void xnsynch_wakeup_this_sleeper(xnsynch_t *synch, xnpholder_t *holder);
+ * \brief Give the resource ownership to a given waiting thread.
+ *
+ * This service wakes up a specific thread which is currently pending on
+ * the given synchronization object. The sleeping thread is unblocked
+ * from its pending state, but no reschedule is performed.
+ *
+ * This service should be called by upper interfaces wanting to signal
+ * the given resource so that a specific waiter is resumed. It must not
+ * be used with synchronization objects that are supposed to track
+ * ownership (XNSYNCH_OWNER not set).
+ *
+ * @param synch The descriptor address of the synchronization object
+ * whose ownership is changed.
+ *
+ * @param holder The link holder address of the thread to unblock
+ * (&thread->plink) which MUST be currently linked to the
+ * synchronization object's pending queue (i.e. synch->pendq).
+ *
+ * @return The link address of the unblocked thread in the
+ * synchronization object's pending queue.
+ *
+ * Side-effects:
+ *
+ * - The effective priority of the previous resource owner might be
+ * lowered to its base priority value as a consequence of the priority
+ * inheritance boost being cleared.
+ *
+ * - The synchronization object ownership is transfered to the
+ * unblocked thread.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Interrupt service routine
+ * - Kernel-based task
+ * - User-space task
+ *
+ * Rescheduling: never.
+ */
+
+xnpholder_t *xnsynch_wakeup_this_sleeper(xnsynch_t *synch, xnpholder_t *holder)
+{
+	xnthread_t *thread;
+	xnpholder_t *nholder;
+	spl_t s;
+
+	XENO_BUGON(NUCLEUS, testbits(synch->status, XNSYNCH_OWNER));
+
+	xnlock_get_irqsave(&nklock, s);
+
+	nholder = poppq(&synch->pendq, holder);
+
+	thread = link2thread(holder, plink);
+	thread->wchan = NULL;
+	trace_mark(xn_nucleus_synch_wakeup_this,
+		   "thread %p thread_name %s synch %p",
+		   thread, xnthread_name(thread), synch);
+	xnpod_resume_thread(thread, XNPEND);
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	xnarch_post_graph_if(synch, 0, emptypq_p(&synch->pendq));
+
+	return nholder;
+}
+
 /*
  * xnsynch_renice_thread() -- This service is used by the PIP code to
  * raise/lower a thread's priority. The thread's base priority value
@@ -125,19 +334,20 @@ static void xnsynch_renice_thread(xnthre
 }
 
 /*! 
- * \fn void xnsynch_sleep_on(xnsynch_t *synch, xnticks_t timeout,
- *                           xntmode_t timeout_mode)
- *
- * \brief Sleep on a synchronization object.
- *
- * Makes the calling thread sleep on the specified synchronization
- * object, waiting for it to be signaled.
+ * \fn void xnsynch_acquire(xnsynch_t *synch, xnticks_t timeout,
+ *                          xntmode_t timeout_mode);
+ * \brief Acquire the ownership of a synchronization object.
  *
  * This service should be called by upper interfaces wanting the
- * current thread to pend on the given resource.
+ * current thread to acquire the ownership of the given resource. If
+ * the resource is already assigned to a thread, the caller is
+ * suspended.
+ *
+ * This service must be used only with synchronization objects that
+ * track ownership (XNSYNCH_OWNER set.
  *
  * @param synch The descriptor address of the synchronization object
- * to sleep on.
+ * to acquire.
  *
  * @param timeout The timeout which may be used to limit the time the
  * thread pends on the resource. This value is a wait time given in
@@ -158,36 +368,24 @@ static void xnsynch_renice_thread(xnthre
  * - Kernel-based task
  * - User-space task
  *
- * Rescheduling: always.
+ * Rescheduling: possible.
  *
  * @note The @a timeout value will be interpreted as jiffies if the
  * current thread is bound to a periodic time base (see
  * xnpod_init_thread), or nanoseconds otherwise.
  */
 
-void xnsynch_sleep_on(xnsynch_t *synch, xnticks_t timeout,
-		      xntmode_t timeout_mode)
+void xnsynch_acquire(xnsynch_t *synch, xnticks_t timeout,
+		     xntmode_t timeout_mode)
 {
 	xnthread_t *thread = xnpod_current_thread(), *owner;
 	spl_t s;
 
-	xnlock_get_irqsave(&nklock, s);
+	XENO_BUGON(NUCLEUS, !testbits(synch->status, XNSYNCH_OWNER));
 
-	trace_mark(xn_nucleus_synch_sleepon,
-		   "thread %p thread_name %s synch %p",
-		   thread, xnthread_name(thread), synch);
+	xnlock_get_irqsave(&nklock, s);
 
-	if (!testbits(synch->status, XNSYNCH_PRIO)) { /* i.e. FIFO */
-		appendpq(&synch->pendq, &thread->plink);
-		xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
-		goto unlock_and_exit;
-	}
-
-	if (!testbits(synch->status, XNSYNCH_PIP)) { /* i.e. no ownership */
-		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
-		xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
-		goto unlock_and_exit;
-	}
+	trace_mark(xn_nucleus_synch_acquire, "synch %p", synch);
 
 redo:
 	owner = synch->owner;
@@ -198,6 +396,12 @@ redo:
 		goto unlock_and_exit;
 	}
 
+	if (!testbits(synch->status, XNSYNCH_PRIO)) { /* i.e. FIFO */
+		appendpq(&synch->pendq, &thread->plink);
+		xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
+		goto unlock_and_exit;
+	}
+
 	if (thread->cprio > owner->cprio) {
 		if (xnthread_test_info(owner, XNWAKEN) && owner->wwake == synch) {
 			/* Ownership is still pending, steal the resource. */
@@ -207,19 +411,22 @@ redo:
 			goto unlock_and_exit;
 		}
 
-		if (!xnthread_test_state(owner, XNBOOST)) {
-			owner->bprio = owner->cprio;
-			xnthread_set_state(owner, XNBOOST);
-		}
+		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
 
-		if (testbits(synch->status, XNSYNCH_CLAIMED))
-			removepq(&owner->claimq, &synch->link);
-		else
-			__setbits(synch->status, XNSYNCH_CLAIMED);
+		if (testbits(synch->status, XNSYNCH_PIP)) {
+			if (!xnthread_test_state(owner, XNBOOST)) {
+				owner->bprio = owner->cprio;
+				xnthread_set_state(owner, XNBOOST);
+			}
+
+			if (testbits(synch->status, XNSYNCH_CLAIMED))
+				removepq(&owner->claimq, &synch->link);
+			else
+				__setbits(synch->status, XNSYNCH_CLAIMED);
 
-		insertpqf(&owner->claimq, &synch->link, thread->cprio);
-		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
-		xnsynch_renice_thread(owner, thread->cprio);
+			insertpqf(&owner->claimq, &synch->link, thread->cprio);
+			xnsynch_renice_thread(owner, thread->cprio);
+		}
 	} else
 		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
 
@@ -335,17 +542,17 @@ void xnsynch_renice_sleeper(xnthread_t *
 	}
 }
 
-/*! 
- * \fn xnthread_t *xnsynch_wakeup_one_sleeper(xnsynch_t *synch);
+/*!
+ * \fn xnthread_t *xnsynch_release(xnsynch_t *synch);
  * \brief Give the resource ownership to the next waiting thread.
  *
- * This service gives the ownership of a synchronization object to the
- * thread which is currently leading the object's pending list. The
- * sleeping thread is unblocked, but no action is taken regarding the
- * previous owner of the resource.
+ * This service releases the ownership of the given synchronization
+ * object. The thread which is currently leading the object's pending
+ * list, if any, is unblocked from its pending state. However, no
+ * reschedule is performed.
  *
- * This service should be called by upper interfaces wanting to signal
- * the given resource so that a single waiter is resumed.
+ * This service must be used only with synchronization objects that
+ * track ownership (XNSYNCH_OWNER set.
  *
  * @param synch The descriptor address of the synchronization object
  * whose ownership is changed.
@@ -373,38 +580,41 @@ void xnsynch_renice_sleeper(xnthread_t *
  * Rescheduling: never.
  */
 
-xnthread_t *xnsynch_wakeup_one_sleeper(xnsynch_t *synch)
+struct xnthread *xnsynch_release(xnsynch_t *synch)
 {
-	xnthread_t *thread = NULL, *lastowner;
+	xnthread_t *newowner, *lastowner;
 	xnpholder_t *holder;
 	spl_t s;
 
+	XENO_BUGON(NUCLEUS, !testbits(synch->status, XNSYNCH_OWNER));
+
 	xnlock_get_irqsave(&nklock, s);
 
-	lastowner = synch->owner;
+	trace_mark(xn_nucleus_synch_release, "synch %p", synch);
+
 	holder = getpq(&synch->pendq);
 
 	if (holder) {
-		thread = link2thread(holder, plink);
-		thread->wchan = NULL;
-		thread->wwake = synch;
-		synch->owner = thread;
-		xnthread_set_info(thread, XNWAKEN);
-		trace_mark(xn_nucleus_synch_wakeup_one,
-			   "thread %p thread_name %s synch %p",
-			   thread, xnthread_name(thread), synch);
-		xnpod_resume_thread(thread, XNPEND);
-	} else
-		synch->owner = NULL;
+		newowner = link2thread(holder, plink);
+		newowner->wchan = NULL;
+		newowner->wwake = synch;
+		lastowner = synch->owner;
+		synch->owner = newowner;
+		xnthread_set_info(newowner, XNWAKEN);
+		xnpod_resume_thread(newowner, XNPEND);
 
-	if (testbits(synch->status, XNSYNCH_CLAIMED))
-		xnsynch_clear_boost(synch, lastowner);
+		if (testbits(synch->status, XNSYNCH_CLAIMED))
+			xnsynch_clear_boost(synch, lastowner);
+	} else {
+		newowner = NULL;
+		synch->owner = NULL;
+	}
 
 	xnlock_put_irqrestore(&nklock, s);
 
 	xnarch_post_graph_if(synch, 0, emptypq_p(&synch->pendq));
 
-	return thread;
+	return newowner;
 }
 
 /*! 
@@ -446,80 +656,6 @@ xnthread_t *xnsynch_peek_pendq(xnsynch_t
 }
 
 /*! 
- * \fn void xnsynch_wakeup_this_sleeper(xnsynch_t *synch, xnpholder_t *holder);
- * \brief Give the resource ownership to a given waiting thread.
- *
- * This service gives the ownership of a given synchronization object
- * to a specific thread which is currently pending on it. The sleeping
- * thread is unblocked from its pending state. No action is taken
- * regarding the previous resource owner.
- *
- * This service should be called by upper interfaces wanting to signal
- * the given resource so that a specific waiter is resumed.
- *
- * @param synch The descriptor address of the synchronization object
- * whose ownership is changed.
- *
- * @param holder The link holder address of the thread to unblock
- * (&thread->plink) which MUST be currently linked to the
- * synchronization object's pending queue (i.e. synch->pendq).
- *
- * @return The link address of the unblocked thread in the
- * synchronization object's pending queue.
- *
- * Side-effects:
- *
- * - The effective priority of the previous resource owner might be
- * lowered to its base priority value as a consequence of the priority
- * inheritance boost being cleared.
- *
- * - The synchronization object ownership is transfered to the
- * unblocked thread.
- *
- * Environments:
- *
- * This service can be called from:
- *
- * - Kernel module initialization/cleanup code
- * - Interrupt service routine
- * - Kernel-based task
- * - User-space task
- *
- * Rescheduling: never.
- */
-
-xnpholder_t *xnsynch_wakeup_this_sleeper(xnsynch_t *synch, xnpholder_t *holder)
-{
-	xnthread_t *thread, *lastowner;
-	xnpholder_t *nholder;
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
-
-	lastowner = synch->owner;
-	nholder = poppq(&synch->pendq, holder);
-
-	thread = link2thread(holder, plink);
-	thread->wchan = NULL;
-	thread->wwake = synch;
-	synch->owner = thread;
-	xnthread_set_info(thread, XNWAKEN);
-	trace_mark(xn_nucleus_synch_wakeup_all,
-		   "thread %p thread_name %s synch %p",
-		   thread, xnthread_name(thread), synch);
-	xnpod_resume_thread(thread, XNPEND);
-
-	if (testbits(synch->status, XNSYNCH_CLAIMED))
-		xnsynch_clear_boost(synch, lastowner);
-
-	xnlock_put_irqrestore(&nklock, s);
-
-	xnarch_post_graph_if(synch, 0, emptypq_p(&synch->pendq));
-
-	return nholder;
-}
-
-/*! 
  * \fn void xnsynch_flush(xnsynch_t *synch, xnflags_t reason);
  * \brief Unblock all waiters pending on a resource.
  *
@@ -679,12 +815,12 @@ void xnsynch_release_all_ownerships(xnth
 
 	for (holder = getheadpq(&thread->claimq); holder != NULL;
 	     holder = nholder) {
-		/* Since xnsynch_wakeup_one_sleeper() alters the claim
+		/* Since xnsynch_release() alters the claim
 		   queue, we need to be conservative while scanning
 		   it. */
 		xnsynch_t *synch = link2synch(holder);
 		nholder = nextpq(&thread->claimq, holder);
-		xnsynch_wakeup_one_sleeper(synch);
+		xnsynch_release(synch);
 		if (synch->cleanup)
 			synch->cleanup(synch);
 	}
@@ -701,3 +837,5 @@ EXPORT_SYMBOL(xnsynch_sleep_on);
 EXPORT_SYMBOL(xnsynch_wakeup_one_sleeper);
 EXPORT_SYMBOL(xnsynch_wakeup_this_sleeper);
 EXPORT_SYMBOL(xnsynch_peek_pendq);
+EXPORT_SYMBOL(xnsynch_acquire);
+EXPORT_SYMBOL(xnsynch_release);
Index: b/include/rtdm/rtdm_driver.h
===================================================================
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -1134,7 +1134,7 @@ static inline void rtdm_mutex_unlock(rtd
 
 	trace_mark(xn_rtdm_mutex_unlock, "mutex %p", mutex);
 
-	if (unlikely(xnsynch_wakeup_one_sleeper(&mutex->synch_base) != NULL))
+	if (unlikely(xnsynch_release(&mutex->synch_base) != NULL))
 		xnpod_schedule();
 }
 
Index: b/ksrc/skins/native/cond.c
===================================================================
--- a/ksrc/skins/native/cond.c
+++ b/ksrc/skins/native/cond.c
@@ -421,7 +421,7 @@ int rt_cond_wait_inner(RT_COND *cond, RT
 
 	mutex->lockcnt = 0;
 
-	if (xnsynch_wakeup_one_sleeper(&mutex->synch_base)) {
+	if (xnsynch_release(&mutex->synch_base)) {
 		mutex->lockcnt = 1;
 		/* Scheduling deferred */
 	}
Index: b/ksrc/skins/native/mutex.c
===================================================================
--- a/ksrc/skins/native/mutex.c
+++ b/ksrc/skins/native/mutex.c
@@ -170,7 +170,8 @@ int rt_mutex_create(RT_MUTEX *mutex, con
 	if (xnpod_asynch_p())
 		return -EPERM;
 
-	xnsynch_init(&mutex->synch_base, XNSYNCH_PRIO | XNSYNCH_PIP);
+	xnsynch_init(&mutex->synch_base,
+		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER);
 	mutex->handle = 0;	/* i.e. (still) unregistered mutex. */
 	mutex->magic = XENO_MUTEX_MAGIC;
 	mutex->lockcnt = 0;
@@ -309,7 +310,7 @@ int rt_mutex_acquire_inner(RT_MUTEX *mut
 		goto unlock_and_exit;
 	}
 
-	xnsynch_sleep_on(&mutex->synch_base, timeout, timeout_mode);
+	xnsynch_acquire(&mutex->synch_base, timeout, timeout_mode);
 
 	if (xnthread_test_info(thread, XNRMID))
 		err = -EIDRM;	/* Mutex deleted while pending. */
@@ -523,7 +524,7 @@ int rt_mutex_release(RT_MUTEX *mutex)
 	if (--mutex->lockcnt > 0)
 		goto unlock_and_exit;
 
-	if (xnsynch_wakeup_one_sleeper(&mutex->synch_base)) {
+	if (xnsynch_release(&mutex->synch_base)) {
 		mutex->lockcnt = 1;
 		xnpod_schedule();
 	}
Index: b/ksrc/skins/native/task.c
===================================================================
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -269,7 +269,8 @@ int rt_task_create(RT_TASK *task,
 
 #ifdef CONFIG_XENO_OPT_NATIVE_MPS
 	xnsynch_init(&task->mrecv, XNSYNCH_FIFO);
-	xnsynch_init(&task->msendq, XNSYNCH_PRIO | XNSYNCH_PIP);
+	xnsynch_init(&task->msendq,
+		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER);
 	xnsynch_set_owner(&task->msendq, &task->thread_base);
 	task->flowgen = 0;
 #endif /* CONFIG_XENO_OPT_NATIVE_MPS */
@@ -1773,7 +1774,7 @@ ssize_t rt_task_send(RT_TASK *task,
 	   client in the case required by the priority inheritance
 	   protocol (i.e. prio(client) > prio(server)). */
 
-	xnsynch_sleep_on(&task->msendq, timeout, XN_RELATIVE);
+	xnsynch_acquire(&task->msendq, timeout, XN_RELATIVE);
 
 	/* At this point, the server task might have exited right
 	 * after having replied to us, so do not make optimistic
Index: b/ksrc/skins/posix/cond.c
===================================================================
--- a/ksrc/skins/posix/cond.c
+++ b/ksrc/skins/posix/cond.c
@@ -240,7 +240,7 @@ static inline int mutex_save_count(xnthr
 		   xnthread_handle(cur)))
 		return 0;
 
-	owner = xnsynch_wakeup_one_sleeper(&mutex->synchbase);
+	owner = xnsynch_release(&mutex->synchbase);
 	xnarch_atomic_set(mutex->owner,
 			  set_claimed(xnthread_handle(owner),
 				      xnsynch_nsleepers(&mutex->synchbase)));
Index: b/ksrc/skins/posix/mutex.c
===================================================================
--- a/ksrc/skins/posix/mutex.c
+++ b/ksrc/skins/posix/mutex.c
@@ -85,7 +85,7 @@ int pse51_mutex_init_internal(struct __s
 			      xnarch_atomic_t *ownerp,
 			      const pthread_mutexattr_t *attr)
 {
-	xnflags_t synch_flags = XNSYNCH_PRIO | XNSYNCH_NOPIP;
+	xnflags_t synch_flags = XNSYNCH_PRIO | XNSYNCH_OWNER;
 	struct xnsys_ppd *sys_ppd;
 	pse51_kqueues_t *kq;
 	spl_t s;
@@ -307,11 +307,11 @@ int pse51_mutex_timedlock_break(struct _
 		for (;;) {
 			++mutex->sleepers;
 			if (timed)
-				xnsynch_sleep_on(&mutex->synchbase,
-						 abs_to, XN_REALTIME);
+				xnsynch_acquire(&mutex->synchbase,
+						abs_to, XN_REALTIME);
 			else
-				xnsynch_sleep_on(&mutex->synchbase,
-						 XN_INFINITE, XN_RELATIVE);
+				xnsynch_acquire(&mutex->synchbase,
+						XN_INFINITE, XN_RELATIVE);
 			--mutex->sleepers;
 
 			if (xnthread_test_info(cur, XNBREAK)) {
Index: b/ksrc/skins/posix/mutex.h
===================================================================
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -170,9 +170,9 @@ static inline int pse51_mutex_timedlock_
 	xnsynch_set_owner(&mutex->synchbase, owner);
 	++mutex->sleepers;
 	if (timed)
-		xnsynch_sleep_on(&mutex->synchbase, abs_to, XN_REALTIME);
+		xnsynch_acquire(&mutex->synchbase, abs_to, XN_REALTIME);
 	else
-		xnsynch_sleep_on(&mutex->synchbase, XN_INFINITE, XN_RELATIVE);
+		xnsynch_acquire(&mutex->synchbase, XN_INFINITE, XN_RELATIVE);
 	--mutex->sleepers;
 
 	if (xnthread_test_info(cur, XNBREAK)) {
@@ -216,7 +216,7 @@ static inline void pse51_mutex_unlock_in
 		return;
 
 	xnlock_get_irqsave(&nklock, s);
-	owner = xnsynch_wakeup_one_sleeper(&mutex->synchbase);
+	owner = xnsynch_release(&mutex->synchbase);
 	ownerh = set_claimed(xnthread_handle(owner), mutex->sleepers);
 	xnarch_atomic_set(mutex->owner, ownerh);
 	if (owner)
Index: b/ksrc/skins/rtai/sem.c
===================================================================
--- a/ksrc/skins/rtai/sem.c
+++ b/ksrc/skins/rtai/sem.c
@@ -28,7 +28,7 @@ void rt_typed_sem_init(SEM * sem, int va
 	int mode = XNSYNCH_PRIO;
 
 	if ((type & RES_SEM) == RES_SEM) {
-		mode |= XNSYNCH_PIP;
+		mode |= XNSYNCH_PIP | XNSYNCH_OWNER;
 		value = 0;	/* We will use this as a lock count. */
 	} else {
 		if ((type & BIN_SEM) && value > 1)
@@ -98,7 +98,7 @@ int rt_sem_signal(SEM * sem)
 			goto unlock_and_exit;
 
 		sem->owner =
-		    thread2rtask(xnsynch_wakeup_one_sleeper(&sem->synch_base));
+		    thread2rtask(xnsynch_release(&sem->synch_base));
 
 		if (sem->owner != NULL)
 			xnpod_schedule();
@@ -141,12 +141,12 @@ int rt_sem_wait(SEM * sem)
 			err = ++sem->count;
 			goto unlock_and_exit;
 		}
+		xnsynch_acquire(&sem->synch_base, XN_INFINITE, XN_RELATIVE);
 	} else if (sem->count > 0) {
 		err = sem->count--;
 		goto unlock_and_exit;
-	}
-
-	xnsynch_sleep_on(&sem->synch_base, XN_INFINITE, XN_RELATIVE);
+	} else
+		xnsynch_sleep_on(&sem->synch_base, XN_INFINITE, XN_RELATIVE);
 
 	if (xnthread_test_info(&task->thread_base, XNRMID))
 		err = SEM_ERR;	/* Semaphore deleted while pending. */
Index: b/ksrc/skins/rtdm/drvlib.c
===================================================================
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -1390,7 +1390,8 @@ void rtdm_mutex_init(rtdm_mutex_t *mutex
 	/* Make atomic for re-initialisation support */
 	xnlock_get_irqsave(&nklock, s);
 
-	xnsynch_init(&mutex->synch_base, XNSYNCH_PRIO | XNSYNCH_PIP);
+	xnsynch_init(&mutex->synch_base,
+		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER);
 
 	xnlock_put_irqrestore(&nklock, s);
 }
@@ -1534,14 +1535,14 @@ int rtdm_mutex_timedlock(rtdm_mutex_t *m
 restart:
 		if (timeout_seq && (timeout > 0)) {
 			/* timeout sequence */
-			xnsynch_sleep_on(&mutex->synch_base, *timeout_seq,
-					 XN_ABSOLUTE);
+			xnsynch_acquire(&mutex->synch_base, *timeout_seq,
+					XN_ABSOLUTE);
 		} else {
 			/* infinite or relative timeout */
-			xnsynch_sleep_on(&mutex->synch_base,
-					 xntbase_ns2ticks_ceil
-					 (xnthread_time_base(curr_thread),
-					  timeout), XN_RELATIVE);
+			xnsynch_acquire(&mutex->synch_base,
+					xntbase_ns2ticks_ceil
+					(xnthread_time_base(curr_thread),
+					 timeout), XN_RELATIVE);
 		}
 
 		if (unlikely(xnthread_test_info(curr_thread,
Index: b/ksrc/skins/vrtx/mx.c
===================================================================
--- a/ksrc/skins/vrtx/mx.c
+++ b/ksrc/skins/vrtx/mx.c
@@ -161,7 +161,7 @@ int sc_mcreate(unsigned int opt, int *er
 	inith(&mx->link);
 	mx->mid = mid;
 	mx->owner = NULL;
-	xnsynch_init(&mx->synchbase, bflags | XNSYNCH_DREORD);
+	xnsynch_init(&mx->synchbase, bflags | XNSYNCH_DREORD | XNSYNCH_OWNER);
 
 	xnlock_get_irqsave(&nklock, s);
 	appendq(&vrtx_mx_q, &mx->link);
@@ -192,7 +192,7 @@ void sc_mpost(int mid, int *errp)
 	}
 
 	/* Undefined behaviour if the poster does not own the mutex. */
-	mx->owner = xnsynch_wakeup_one_sleeper(&mx->synchbase);
+	mx->owner = xnsynch_release(&mx->synchbase);
 
 	*errp = RET_OK;
 
@@ -267,7 +267,7 @@ void sc_mpend(int mid, unsigned long tim
 		if (timeout)
 			task->vrtxtcb.TCBSTAT |= TBSDELAY;
 
-		xnsynch_sleep_on(&mx->synchbase, timeout, XN_RELATIVE);
+		xnsynch_acquire(&mx->synchbase, timeout, XN_RELATIVE);
 
 		if (xnthread_test_info(&task->threadbase, XNBREAK))
 			*errp = -EINTR;
Index: b/ksrc/skins/vxworks/semLib.c
===================================================================
--- a/ksrc/skins/vxworks/semLib.c
+++ b/ksrc/skins/vxworks/semLib.c
@@ -138,7 +138,7 @@ SEM_ID semCCreate(int flags, int count)
 
 SEM_ID semMCreate(int flags)
 {
-	int bflags = 0;
+	int bflags = XNSYNCH_OWNER;
 
 	error_check(flags & ~WIND_SEMM_OPTION_MASK, S_semLib_INVALID_QUEUE_TYPE,
 		    return 0);
@@ -346,7 +346,7 @@ static STATUS semm_take(wind_sem_t *sem,
 	error_check(to == XN_NONBLOCK, S_objLib_OBJ_UNAVAILABLE,
 		    return ERROR);
 
-	xnsynch_sleep_on(&sem->synchbase, to, XN_RELATIVE);
+	xnsynch_acquire(&sem->synchbase, to, XN_RELATIVE);
 
 	error_check(xnthread_test_info(cur, XNBREAK),
 		    -EINTR, return ERROR);
@@ -385,7 +385,7 @@ static STATUS semm_give(wind_sem_t *sem)
 	if (--sem->count > 0)
 		return OK;
 
-	if (xnsynch_wakeup_one_sleeper(&sem->synchbase)) {
+	if (xnsynch_release(&sem->synchbase)) {
 		sem->count = 1;
 		resched = 1;
 	}


