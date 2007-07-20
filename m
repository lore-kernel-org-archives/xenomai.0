From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <32098568.1184853156077.JavaMail.ngmail@domain.hid>
References: <1184852543.28303.67.camel@domain.hid>
	<24703926.1184851660664.JavaMail.ngmail@domain.hid>
	<32098568.1184853156077.JavaMail.ngmail@domain.hid>
Content-Type: multipart/mixed; boundary="=-6bYCIXqe2u03aukt+vyL"
Date: Fri, 20 Jul 2007 02:14:11 +0200
Message-Id: <1184890451.28303.356.camel@domain.hid>
Mime-Version: 1.0
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] RPI is good for you
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
Cc: xenomai@xenomai.org


--=-6bYCIXqe2u03aukt+vyL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Mathias,

Could you try applying the attached patch against v2.3.2, and run your
box using the failing configuration. This patch is a _preliminary_
attempt at fixing two major issues, it is not complete, and may not even
be fully correct since it does not address all the pending issues yet.
Still, I would be interested to know whether I'm on the right path, and
if it changes something to your problem, without making your box jump
out of the window, that is.

TIA,

-- 
Philippe.


--=-6bYCIXqe2u03aukt+vyL
Content-Disposition: attachment; filename=fix-rpi-locking-gk.patch
Content-Type: text/x-patch; name=fix-rpi-locking-gk.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: ksrc/skins/psos+/task.c
===================================================================
--- ksrc/skins/psos+/task.c	(revision 2765)
+++ ksrc/skins/psos+/task.c	(working copy)
@@ -288,13 +288,6 @@
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
Index: ksrc/skins/vxworks/taskLib.c
===================================================================
--- ksrc/skins/vxworks/taskLib.c	(revision 2765)
+++ ksrc/skins/vxworks/taskLib.c	(working copy)
@@ -285,13 +285,6 @@
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
 
Index: ksrc/skins/native/task.c
===================================================================
--- ksrc/skins/native/task.c	(revision 2765)
+++ ksrc/skins/native/task.c	(working copy)
@@ -581,29 +581,6 @@
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
 
Index: ksrc/nucleus/pod.c
===================================================================
--- ksrc/nucleus/pod.c	(revision 2765)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -1245,10 +1245,35 @@
 	if (xnthread_test_state(thread, XNZOMBIE))
 		goto unlock_and_exit;	/* No double-deletion. */
 
+	sched = thread->sched;
+
+#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
+	/* xnpod_delete_thread() might be called for cleaning up a
+	   just created shadow task which has not been successfully
+	   mapped, so make sure we have an associated Linux mate
+	   before trying to send it a signal. This will also prevent
+	   any action on kernel-based Xenomai threads for which the
+	   user TCB extension is always NULL.  We don't send any
+	   signal to dormant threads because GDB (6.x) has some
+	   problems dealing with vanishing threads under some
+	   circumstances, likely when asynchronous cancellation is in
+	   effect. In most cases, this is a non-issue since
+	   pthread_cancel() is requested from the skin interface
+	   library in parallel on the target thread, but when calling
+	   xnpod_delete_thread() from kernel space against a created
+	   but unstarted user-space task, the Linux thread mated to
+	   the Xenomai shadow might linger unexpectedly on the startup
+	   barrier. */
+	if (xnthread_user_task(thread) != NULL
+	    && !xnthread_test_state(thread, XNDORMANT)
+	    && (!xnpod_primary_p() || thread != sched->runthread)) {
+		xnshadow_send_sig(thread, SIGKILL, 1);
+		goto unlock_and_exit;
+	}
+#endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */
+
 	xnltt_log_event(xeno_ev_thrdelete, thread->name);
 
-	sched = thread->sched;
-
 	removeq(&nkpod->threadq, &thread->glink);
 	nkpod->threadq_rev++;
 
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 2765)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -837,7 +837,8 @@
 		if (kthread_should_stop())
 			break;
 
-		xnlock_get_irqsave(&nklock, s);
+		/* Real-time shadow TCBs are always removed on behalf
+		   of the killed thread. */
 
 		thread = gk->thread;
 
@@ -846,6 +847,8 @@
 		   pending request, just ignore the latter. */
 
 		if (xnthread_user_task(thread)->state == TASK_INTERRUPTIBLE) {
+			rpi_pop(thread);
+			xnlock_get_irqsave(&nklock, s);
 #ifdef CONFIG_SMP
 			/* If the task changed its CPU while in secondary mode,
 			   change the CPU of the underlying Xenomai shadow too. We
@@ -855,14 +858,12 @@
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

--=-6bYCIXqe2u03aukt+vyL--


