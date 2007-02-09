From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45CCEB58.8020103@domain.hid>
References: <45CCEB58.8020103@domain.hid>
Content-Type: text/plain
Date: Sat, 10 Feb 2007 00:49:00 +0100
Message-Id: <1171064941.25642.50.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: xnpod_suspend_thread and past absolute timeouts
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2007-02-09 at 22:44 +0100, Jan Kiszka wrote:
> Hi Philippe,
> 
> RTnet revealed a problem of rtdm_task_sleep_until in trunk. When being
> called with a past date, it blocks forever because xnpod_suspend_thread
> considers such timeouts as infinite:
> 
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c?v=SVN-trunk#1456
> 
> Are there users relying on this property of xnpod_suspend_thread? If
> yes, I would unfortunately have to catch this case in RTDM.
> 

Here is the proposed change, absolutely untested; could you give this
hell on your favourite RTNet torture? TIA,

--- ksrc/nucleus/pod.c	(revision 2159)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -1410,13 +1410,6 @@
 	if (thread == sched->runthread)
 		xnsched_set_resched(sched);
 
-	/* We must make sure that we don't clear the wait channel if a
-	   thread is first blocked (wchan != NULL) then forcibly suspended
-	   (wchan == NULL), since these are conjunctive conditions. */
-
-	if (wchan)
-		thread->wchan = wchan;
-
 	/* Is the thread ready to run? */
 
 	if (!xnthread_test_state(thread, XNTHREAD_BLOCK_BITS)) {
@@ -1429,35 +1422,41 @@
 		if (xnthread_test_info(thread, XNKICKED)) {
 			xnthread_clear_info(thread, XNRMID | XNTIMEO);
 			xnthread_set_info(thread, XNBREAK);
-			if (wchan)
-				thread->wchan = NULL;
 			goto unlock_and_exit;
 		}
 #endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */
 
-		/* A newly created thread is not linked to the ready thread
-		   queue yet. */
-
-		if (xnthread_test_state(thread, XNREADY)) {
-			sched_removepq(&sched->readyq, &thread->rlink);
-			xnthread_clear_state(thread, XNREADY);
-		}
-
 		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | XNWAKEN | XNROBBED);
 	}
 
-	xnthread_set_state(thread, mask);
+	/* Don't start the timer for a thread indefinitely delayed by
+	   a call to xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL). */
 
 	if (timeout != XN_INFINITE || mode == XN_ABSOLUTE) {
-		/* Don't start the timer for a thread indefinitely delayed by
-		   a call to xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL). */
-		xnthread_set_state(thread, XNDELAY);
 		xntimer_set_sched(&thread->rtimer, thread->sched);
-		/* In case of preposterous absolute timer setting, the
-		 * thread is never going to wake up; assume that's
-		 * intended. */
-		xntimer_start(&thread->rtimer, timeout, XN_INFINITE, mode);
+		if (xntimer_start(&thread->rtimer, timeout, XN_INFINITE, mode)) {
+			/* (absolute) timeout value in the past, bail out. */
+			xnthread_set_info(thread, XNTIMEO);
+			goto unlock_and_exit;
+		}
+		xnthread_set_state(thread, XNDELAY);
 	}
+
+	if (xnthread_test_state(thread, XNREADY)) {
+		sched_removepq(&sched->readyq, &thread->rlink);
+		xnthread_clear_state(thread, XNREADY);
+	}
+
+	xnthread_set_state(thread, mask);
+
+	/* We must make sure that we don't clear the wait channel if a
+	   thread is first blocked (wchan != NULL) then forcibly
+	   suspended (wchan == NULL), since these are conjunctive
+	   conditions. */
+
+	if (wchan)
+		thread->wchan = wchan;
+
 #ifdef __XENO_SIM__
 	if (nkpod->schedhook)
 		nkpod->schedhook(thread, mask);
-- 
Philippe.



