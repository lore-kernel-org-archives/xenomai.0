Message-ID: <49A6A42E.5010203@domain.hid>
Date: Thu, 26 Feb 2009 15:16:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 1/3] native: Support T_WARNSW on task creation
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

Extend __rt_task_create to apply the T_WARNSW thread mode after
creation and adopt the user space parts so that the no-mlock check is
disabled as well.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/skins/native/syscall.c |   44 ++++++++++++++++++++++++-------------------
 src/skins/native/task.c     |    8 +++++++-
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
index 1e3d5ab..8146600 100644
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -181,29 +181,35 @@ static int __rt_task_create(struct pt_regs *regs)
 	   the platform does not support it. */
 
 	err = rt_task_create(task, name, 0, prio, XNFPU | XNSHADOW | mode);
+	if (err)
+		goto fail;
 
-	if (err == 0) {
-		/* Apply CPU affinity */
-		set_cpus_allowed(p, task->affinity);
-
-		/* Copy back the registry handle to the ph struct. */
-		ph.opaque = xnthread_handle(&task->thread_base);
-		ph.opaque2 = bulk.a5;	/* hidden pthread_t identifier. */
-		if (__xn_safe_copy_to_user((void __user *)bulk.a1, &ph, sizeof(ph)))
-			err = -EFAULT;
-		else {
-			err = xnshadow_map(&task->thread_base, u_completion,
-					   (unsigned long __user *)bulk.a6);
-			if (!err)
-				goto out;
-		}
+	/* Apply CPU affinity */
+	set_cpus_allowed(p, task->affinity);
 
-		rt_task_delete(task);
+	/* Copy back the registry handle to the ph struct. */
+	ph.opaque = xnthread_handle(&task->thread_base);
+	ph.opaque2 = bulk.a5;	/* hidden pthread_t identifier. */
+	if (__xn_safe_copy_to_user((void __user *)bulk.a1, &ph, sizeof(ph))) {
+		err = -EFAULT;
+		goto delete;
 	}
-		
+
+	err = xnshadow_map(&task->thread_base, u_completion,
+			   (unsigned long __user *)bulk.a6);
+	if (err)
+		goto delete;
+
+	if (bulk.a4 & T_WARNSW)
+		xnpod_set_thread_mode(&task->thread_base, 0, XNTRAPSW);
+
+	return 0;
+
+delete:
+	rt_task_delete(task);
+
 fail:
 	/* Unblock and pass back error code. */
-
 	if (u_completion)
 		xnshadow_signal_completion(u_completion, err);
 
@@ -216,7 +222,7 @@ fail:
 	if (task != NULL
 	    && !xnthread_test_state(&task->thread_base, XNZOMBIE))
 		xnfree(task);
-out:
+
 	return err;
 }
 
diff --git a/src/skins/native/task.c b/src/skins/native/task.c
index 7bcc49c..b3ee9b2 100644
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -40,6 +40,7 @@ extern pthread_key_t __native_tskey;
 #endif /* !HAVE___THREAD */
 
 extern int __native_muxid;
+extern int xeno_sigxcpu_no_mlock;
 
 /* Public Xenomai interface. */
 
@@ -100,6 +101,9 @@ static void *rt_task_trampoline(void *cookie)
 	__native_self = *task;
 #endif /* HAVE___THREAD */
 
+	if (iargs->mode & T_WARNSW)
+		xeno_sigxcpu_no_mlock = 0;
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */
@@ -215,6 +219,9 @@ int rt_task_shadow(RT_TASK *task, const char *name, int prio, int mode)
 		__native_self = *task;
 #endif /* HAVE___THREAD */
 		xeno_set_current();
+
+		if (mode & T_WARNSW)
+			xeno_sigxcpu_no_mlock = 0;
 	}
 
 	return err;
@@ -310,7 +317,6 @@ int rt_task_notify(RT_TASK *task, rt_sigset_t signals)
 
 int rt_task_set_mode(int clrmask, int setmask, int *oldmode)
 {
-	extern int xeno_sigxcpu_no_mlock;
 	int err;
 
 	err = XENOMAI_SKINCALL3(__native_muxid,

