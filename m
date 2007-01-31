Subject: Re: Antwort: Re: [Xenomai-core] Questions about pSOS task mode and
	task priority
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45BDF5D8.4020607@domain.hid>
References: <OF5910DE28.1586BCD6-ONC125726F.005E4D75@domain.hid>
	<1169832375.3346.67.camel@domain.hid>  <45BDF5D8.4020607@domain.hid>
Content-Type: multipart/mixed; boundary="=-LMCOr3+Wdf8LpDC1rLt7"
Date: Wed, 31 Jan 2007 01:40:16 +0100
Message-Id: <1170204016.21219.49.camel@domain.hid>
Mime-Version: 1.0
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Markus Osterried <Markus.Osterried@domain.hid>, xenomai@xenomai.org, Thomas Necker <Thomas.Necker@domain.hid>


--=-LMCOr3+Wdf8LpDC1rLt7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2007-01-29 at 14:25 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Fri, 2007-01-26 at 18:16 +0100, Thomas Necker wrote:
> > 
> >>So it clearly states that a non-preemtible task may block (and 
> >>rescheduling occurs in
> >>this case).
> > 
> > 
> > Ok, so this is a must fix. Will do. Thanks for reporting.
> 
> I had a look at the OSEK specification, it also has non-preemptible
> tasks. So, I guess we should add an xnpod_locked_schedule that simply does
> 
> if (xnthread_test_state(xnpod_current_sched()->runthread, XNLOCK)) {
> 	xnpod_unlock_sched();
> 	xnpod_lock_sched();
> } else
> 	xnpod_schedule();
> 
> and call this xnpod_locked_schedule() instead of xnpod_schedule() in
> these skins.

The more I think of it, the more it becomes obvious that the current
implementation of the scheduler locks is uselessly restrictive.
Actually, the only thing we gain from not allowing threads to block
while holding such kind of lock is the opportunity to panic at best if
the debug switch is on, or to go south badly if not.

Even the pattern above would not solve the issue in fact, because things
like xnsynch_sleep_on() which fire a rescheduling call would have to
either get a special argument telling us about the policy in this
matter, or forcibly unlock the scheduler behind the curtains before
calling xnpod_suspend() internally. While we are at it, we would be
better off incorporating the latter at the core, and assume that
callers/skins that do _not_ want to allow sleeping schedlocks did the
proper sanity checks to prevent this before running the rescheduling
procedure. Other would just benefit from the feature.

In short, the following patch against 2.3.0 stock fixes the issue,
allowing threads to block while holding the scheduler lock. 

-- 
Philippe.


--=-LMCOr3+Wdf8LpDC1rLt7
Content-Disposition: attachment; filename=allow-sleeping-schedlock.patch
Content-Type: text/x-patch; name=allow-sleeping-schedlock.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: include/nucleus/thread.h
===================================================================
--- include/nucleus/thread.h	(revision 2090)
+++ include/nucleus/thread.h	(working copy)
@@ -152,6 +152,8 @@
 
     int cprio;			/* Current priority */
 
+    u_long schedlck;		/*!< Scheduler lock count. */
+
     xnpholder_t rlink;		/* Thread holder in ready queue */
 
     xnpholder_t plink;		/* Thread holder in synchronization queue(s) */
@@ -248,6 +250,7 @@
 #define xnthread_test_info(thread,flags)   testbits((thread)->info,flags)
 #define xnthread_set_info(thread,flags)    __setbits((thread)->info,flags)
 #define xnthread_clear_info(thread,flags)  __clrbits((thread)->info,flags)
+#define xnthread_lock_count(thread)        ((thread)->schedlck)
 #define xnthread_initial_priority(thread) ((thread)->iprio)
 #define xnthread_base_priority(thread)     ((thread)->bprio)
 #define xnthread_current_priority(thread) ((thread)->cprio)
Index: include/nucleus/pod.h
===================================================================
--- include/nucleus/pod.h	(revision 2090)
+++ include/nucleus/pod.h	(working copy)
@@ -203,8 +203,6 @@
 	xnqueue_t threadq;	/*!< All existing threads. */
 	int threadq_rev;	/*!< Modification counter of threadq. */
 
-	volatile u_long schedlck;	/*!< Scheduler lock count. */
-
 	xnqueue_t tstartq,	/*!< Thread start hook queue. */
 	 tswitchq,		/*!< Thread switch hook queue. */
 	 tdeleteq;		/*!< Thread delete hook queue. */
@@ -348,7 +346,7 @@
     (!!xnthread_test_state(xnpod_current_thread(),XNLOCK))
 
 #define xnpod_unblockable_p() \
-    (xnpod_asynch_p() || xnthread_test_state(xnpod_current_thread(),XNLOCK|XNROOT))
+    (xnpod_asynch_p() || xnthread_test_state(xnpod_current_thread(),XNROOT))
 
 #define xnpod_root_p() \
     (!!xnthread_test_state(xnpod_current_thread(),XNROOT))
@@ -445,24 +443,26 @@
 
 static inline void xnpod_lock_sched(void)
 {
+	xnthread_t *runthread = xnpod_current_sched()->runthread;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
 
-	if (nkpod->schedlck++ == 0)
-		xnthread_set_state(xnpod_current_sched()->runthread, XNLOCK);
+	if (xnthread_lock_count(runthread)++ == 0)
+		xnthread_set_state(runthread, XNLOCK);
 
 	xnlock_put_irqrestore(&nklock, s);
 }
 
 static inline void xnpod_unlock_sched(void)
 {
+	xnthread_t *runthread = xnpod_current_sched()->runthread;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
 
-	if (--nkpod->schedlck == 0) {
-		xnthread_clear_state(xnpod_current_sched()->runthread, XNLOCK);
+	if (--xnthread_lock_count(runthread) == 0) {
+		xnthread_clear_state(runthread, XNLOCK);
 		xnpod_schedule();
 	}
 
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 2091)
+++ ChangeLog	(working copy)
@@ -1,5 +1,9 @@
 2007-01-30  Philippe Gerum  <rpm@xenomai.org>
 
+	* ksrc/nucleus/pod.c (xnpod_schedule): Allow threads to block
+	while holding the scheduler lock. Move the lock nesting count as a
+	per-thread data (instead of the former global pod attribute).
+
 	* sim/include/Makefile.am: Fix destination directory for
 	xeno_config.h to $(prefix)/asm-sim.
 
Index: ksrc/nucleus/thread.c
===================================================================
--- ksrc/nucleus/thread.c	(revision 2090)
+++ ksrc/nucleus/thread.c	(working copy)
@@ -69,6 +69,7 @@
 
 	thread->state = flags;
 	thread->info = 0;
+	thread->schedlck = 0;
 	thread->signals = 0;
 	thread->asrmode = 0;
 	thread->asrimask = 0;
Index: ksrc/nucleus/pod.c
===================================================================
--- ksrc/nucleus/pod.c	(revision 2090)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -360,7 +360,6 @@
 	initq(&pod->tswitchq);
 	initq(&pod->tdeleteq);
 
-	pod->schedlck = 0;
 	pod->minpri = minpri;
 	pod->maxpri = maxpri;
 	pod->jiffies = 0;
@@ -854,7 +853,9 @@
  *
  * - XNLOCK causes the thread to lock the scheduler when it starts.
  * The target thread will have to call the xnpod_unlock_sched()
- * service to unlock the scheduler.
+ * service to unlock the scheduler. A non-preemptible thread may still
+ * block, in which case, the lock is reasserted when the thread is
+ * scheduled back in.
  *
  * - XNRRB causes the thread to be marked as undergoing the
  * round-robin scheduling policy at startup.  The contents of the
@@ -1061,7 +1062,7 @@
 		/* Clear all sched locks held by the restarted thread. */
 		if (xnthread_test_state(thread, XNLOCK)) {
 			xnthread_clear_state(thread, XNLOCK);
-			nkpod->schedlck = 0;
+			xnthread_lock_count(thread) = 0;
 		}
 
 		xnthread_set_state(thread, XNRESTART);
@@ -1101,7 +1102,9 @@
  *
  * - XNLOCK causes the thread to lock the scheduler.  The target
  * thread will have to call the xnpod_unlock_sched() service to unlock
- * the scheduler or clear the XNLOCK bit forcibly using this service.
+ * the scheduler or clear the XNLOCK bit forcibly using this
+ * service. A non-preemptible thread may still block, in which case,
+ * the lock is reasserted when the thread is scheduled back in.
  *
  * - XNRRB causes the thread to be marked as undergoing the
  * round-robin scheduling policy.  The contents of the thread.rrperiod
@@ -1164,7 +1167,7 @@
 				/* Actually grab the scheduler lock. */
 				xnpod_lock_sched();
 		} else if (!xnthread_test_state(thread, XNLOCK))
-			nkpod->schedlck = 0;
+			xnthread_lock_count(thread) = 0;
 	}
 
 	if (!(oldmode & XNRRB) && xnthread_test_state(thread, XNRRB))
@@ -1249,14 +1252,6 @@
 
 	xntimer_stop(&thread->ptimer);
 
-	/* Ensure the rescheduling can take place if the deleted thread is
-	   the running one. */
-
-	if (xnthread_test_state(thread, XNLOCK)) {
-		xnthread_clear_state(thread, XNLOCK);
-		nkpod->schedlck = 0;
-	}
-
 	if (xnthread_test_state(thread, XNPEND))
 		xnsynch_forget_sleeper(thread);
 
@@ -1385,15 +1380,8 @@
 
 	sched = thread->sched;
 
-	if (thread == sched->runthread) {
-#if XENO_DEBUG(NUCLEUS) || defined(__XENO_SIM__)
-		if (sched == xnpod_current_sched() && xnpod_locked_p())
-			xnpod_fatal
-			    ("suspensive call issued while the scheduler was locked");
-#endif /* XENO_DEBUG(NUCLEUS) || __XENO_SIM__ */
-
+	if (thread == sched->runthread)
 		xnsched_set_resched(sched);
-	}
 
 	/* We must make sure that we don't clear the wait channel if a
 	   thread is first blocked (wchan != NULL) then forcibly suspended
@@ -2288,9 +2276,10 @@
  * therefore the caller does not need to explicitely issue
  * xnpod_schedule() after such operations.
  *
- * The rescheduling procedure always leads to a null-effect if the
- * scheduler is locked (XNLOCK bit set in the status mask of the
- * running thread), or if it is called on behalf of an ISR or callout.
+ * The rescheduling procedure always leads to a null-effect if it is
+ * called on behalf of an ISR or callout. Any outstanding scheduler
+ * lock held by the outgoing thread will be restored when the thread
+ * is scheduled back in.
  *
  * Calling this procedure with no applicable context switch pending is
  * harmless and simply leads to a null-effect.
@@ -2319,6 +2308,7 @@
 void xnpod_schedule(void)
 {
 	xnthread_t *threadout, *threadin, *runthread;
+	xnpholder_t *pholder;
 	xnsched_t *sched;
 #if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 	int need_resched;
@@ -2373,19 +2363,19 @@
 
 #endif /* CONFIG_SMP */
 
-	if (xnthread_test_state(runthread, XNLOCK))
-		/* The running thread has locked the scheduler and is still
-		   ready to run. Just check for (self-posted) pending signals,
-		   then exit the procedure without actually switching
-		   contexts. */
-		goto signal_unlock_and_exit;
-
 	/* Clear the rescheduling bit */
 	xnsched_clr_resched(sched);
 
 	if (!xnthread_test_state(runthread, XNTHREAD_BLOCK_BITS | XNZOMBIE)) {
-		xnpholder_t *pholder = sched_getheadpq(&sched->readyq);
 
+		/* Do not preempt the current thread if it holds the
+		 * scheduler lock. */
+
+		if (xnthread_test_state(runthread, XNLOCK))
+			goto signal_unlock_and_exit;
+
+		pholder = sched_getheadpq(&sched->readyq);
+
 		if (pholder) {
 			xnthread_t *head = link2thread(pholder, rlink);
 
@@ -2405,7 +2395,7 @@
 		goto signal_unlock_and_exit;
 	}
 
-      do_switch:
+     do_switch:
 
 	threadout = runthread;
 	threadin = link2thread(sched_getpq(&sched->readyq), rlink);

--=-LMCOr3+Wdf8LpDC1rLt7--


