From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200709071127.17913.peter.soetens@domain.hid>
References: <200709071127.17913.peter.soetens@domain.hid>
Content-Type: text/plain
Date: Sat, 15 Sep 2007 20:52:59 +0200
Message-Id: <1189882379.25006.181.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [FIX] Summary: Xenomai 2.3.2 and 2.4 lock-ups
	and OOPSes
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
To: Peter Soetens <peter.soetens@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2007-09-07 at 11:27 +0200, Peter Soetens wrote:
> Just in case you hooked off the long discussion about the issues we found from
> Xenomai 2.3.2 on:
> 
>   o We are using the xeno_native skin, create Xeno tasks and semaphores, but 
> have strong indications that the crashes are caused by the memory allocation 
> scheme of Xenomai in combination with task creation/deletion
>   o We found two ways to break Xenomai, causing a 'Killed' (rt_task_delete) 
> and causing an OOPS (rt_task_join).
>   o They happen on 2.6.20 and 2.6.22 kernels
>   o On the 2.3 branch, r2429 works, r2433 causes the faults. The patch is 
> small, and in the ChangLog: 
> 

Please try this patch against v2.3.x. A double free issue on a task TCB
already scheduled for memory release was causing all sorts of troubles,
basically trashing the system heap afterwards:

Index: ChangeLog
===================================================================
--- ChangeLog	(revision 2990)
+++ ChangeLog	(revision 2992)
@@ -1,3 +1,19 @@
+2007-09-15  Philippe Gerum  <rpm@xenomai.org>
+
+	* ksrc/skins/vrtx/syscall.c (__sc_tecreate): 
+	* ksrc/skins/vxworks/syscall.c (__wind_task_init): 
+	* ksrc/skins/native/syscall.c (__rt_task_create): Protect against
+	duplicate TCB memory release (first issued by the deletion hook)
+	upon task creation error.
+	
+	* ksrc/skins/native/syscall.c (__rt_task_create): Make sure we
+	attempt to release the TCB memory after any failure to shadow the
+	task.
+
+	* ksrc/skins/native/task.c (rt_task_create): Get out faster from
+	the error case by calling xnpod_delete_thread() upon registration
+	failure.
+
 2007-09-04  Johan Borkhuis <j.borkhuis@domain.hid>
 
 	* ksrc/nucleus/pod.c: Make the watchdog timeout value configurable.
Index: ksrc/skins/vrtx/syscall.c
===================================================================
--- ksrc/skins/vrtx/syscall.c	(revision 2990)
+++ ksrc/skins/vrtx/syscall.c	(revision 2992)
@@ -86,6 +86,8 @@
 		goto done;
 	}
 
+	xnthread_clear_state(&task->threadbase, XNZOMBIE);
+
 	tid =
 	    sc_tecreate_inner(task, NULL, tid, prio, mode, 0, 0, NULL, 0, &err);
 
@@ -98,7 +100,7 @@
 		err = xnshadow_map(&task->threadbase, u_completion);
 	}
 
-	if (err)
+	if (err && !xnthread_test_state(&task->threadbase, XNZOMBIE))
 		xnfree(task);
 
       done:
Index: ksrc/skins/vxworks/syscall.c
===================================================================
--- ksrc/skins/vxworks/syscall.c	(revision 2990)
+++ ksrc/skins/vxworks/syscall.c	(revision 2992)
@@ -111,6 +111,8 @@
 		return -ENOMEM;
 	}
 
+	xnthread_clear_state(&task->threadbase, XNZOMBIE);
+
 	/* Force FPU support in user-space. This will lead to a no-op if
 	   the platform does not support it. */
 
@@ -132,7 +134,7 @@
 			xnshadow_signal_completion(u_completion, err);
 	}
 
-	if (err)
+	if (err && !xnthread_test_state(&task->threadbase, XNZOMBIE))
 		xnfree(task);
 
 	return err;
Index: ksrc/skins/native/task.c
===================================================================
--- ksrc/skins/native/task.c	(revision 2990)
+++ ksrc/skins/native/task.c	(revision 2992)
@@ -286,7 +286,7 @@
 				       &xnthread_handle(&task->thread_base),
 				       NULL);
 		if (err)
-			rt_task_delete(task);
+			xnpod_delete_thread(&task->thread_base);
 		else if (!*name)
 			/* /proc/xenomai/sched will dump no name for the anonymous
 			   task, but the registry still has a stable reference
Index: ksrc/skins/native/syscall.c
===================================================================
--- ksrc/skins/native/syscall.c	(revision 2990)
+++ ksrc/skins/native/syscall.c	(revision 2992)
@@ -125,8 +125,8 @@
 	char name[XNOBJECT_NAME_LEN];
 	struct rt_arg_bulk bulk;
 	RT_TASK_PLACEHOLDER ph;
+	RT_TASK *task = NULL;
 	int err, prio, mode;
-	RT_TASK *task;
 
 	/* Completion descriptor our parent thread is pending on -- may be NULL. */
 	u_completion = (xncompletion_t __user *)__xn_reg_arg2(regs);
@@ -170,6 +170,8 @@
 		goto fail;
 	}
 
+	xnthread_clear_state(&task->thread_base, XNZOMBIE);
+
 	/* Force FPU support in user-space. This will lead to a no-op if
 	   the platform does not support it. */
 
@@ -183,13 +185,21 @@
 				  sizeof(ph));
 		err = xnshadow_map(&task->thread_base, u_completion);
 	} else {
-		xnfree(task);
 		/* Unblock and pass back error code. */
 fail:
 		if (u_completion)
 			xnshadow_signal_completion(u_completion, err);
 	}
 
+	/* Task memory could have been released by an indirect call to
+	 * the deletion hook, after xnpod_delete_thread() has been
+	 * issued from rt_task_create() (e.g. upon registration
+	 * error). We avoid double memory release when the XNZOMBIE
+	 * flag is raised, meaning the deletion hook has run, and the
+	 * TCB memory is already scheduled for release. */
+	if (err && task != NULL && !xnthread_test_state(&task->thread_base, XNZOMBIE))
+		xnfree(task);
+
 	return err;
 }
 

-- 
Philippe.



