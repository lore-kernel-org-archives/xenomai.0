Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F8B484.7070500@domain.hid>
Message-Id: <20081017154601.242433367@domain.hid>
Date: Fri, 17 Oct 2008 17:46:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081017154559.420723261@domain.hid>
Subject: [Xenomai-core] [PATCH 11/13] Report current shadow thread mode to
	user space
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


With this patch applied, the Xenomai skin libraries are able to obtain
the execution mode the current thread without issuing a syscall. The
kernel-user interface looks as follows:

 - On thread creation (which triggers xnshadow_map), user space passes a
   pointer to an unsigned long.

 - Before going primary and after completing the switch to secondary
   mode, the nucleus writes 0 or XNRELAX to that unsigned long. The mode
   updates use __xn_put_user, so they are fail-safe (write errors are
   ignored, only an initial access_wok check is reported back).

 - User space can check its state by calling xeno_get_current_mode().
   An optional light-weight version based on __thread is also provided.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/bits/bind.h    |   22 +++++++++++++++++++++-
 include/asm-generic/bits/current.h |   20 ++++++++++++++++++++
 include/native/syscall.h           |    1 +
 include/nucleus/shadow.h           |    3 ++-
 include/nucleus/thread.h           |    4 ++++
 include/psos+/syscall.h            |    8 ++++++++
 include/vrtx/syscall.h             |    1 +
 include/vxworks/syscall.h          |    1 +
 ksrc/nucleus/shadow.c              |   22 ++++++++++++++++++++--
 ksrc/skins/native/syscall.c        |    3 ++-
 ksrc/skins/posix/syscall.c         |   14 +++++++++-----
 ksrc/skins/psos+/syscall.c         |   34 +++++++++++++++++++++-------------
 ksrc/skins/uitron/syscall.c        |    8 ++++++--
 ksrc/skins/vrtx/syscall.c          |    4 +++-
 ksrc/skins/vxworks/syscall.c       |    4 +++-
 src/skins/native/task.c            |   10 ++++++++++
 src/skins/posix/thread.c           |   33 +++++++++++++++++++++++++++++++--
 src/skins/psos+/task.c             |   16 +++++++++++++---
 src/skins/uitron/task.c            |   11 +++++++++--
 src/skins/vrtx/task.c              |    6 ++++++
 src/skins/vxworks/taskLib.c        |    6 ++++++
 21 files changed, 197 insertions(+), 34 deletions(-)

Index: b/include/native/syscall.h
===================================================================
--- a/include/native/syscall.h
+++ b/include/native/syscall.h
@@ -134,6 +134,7 @@ struct rt_arg_bulk {
 	u_long a3;
 	u_long a4;
 	u_long a5;
+	u_long a6;
 };
 
 #ifdef __KERNEL__
Index: b/include/nucleus/shadow.h
===================================================================
--- a/include/nucleus/shadow.h
+++ b/include/nucleus/shadow.h
@@ -69,7 +69,8 @@ void xnshadow_grab_events(void);
 void xnshadow_release_events(void);
 
 int xnshadow_map(struct xnthread *thread,
-		 xncompletion_t __user *u_completion);
+		 xncompletion_t __user *u_completion,
+		 unsigned long __user *u_mode);
 
 void xnshadow_unmap(struct xnthread *thread);
 
Index: b/include/nucleus/thread.h
===================================================================
--- a/include/nucleus/thread.h
+++ b/include/nucleus/thread.h
@@ -248,6 +248,10 @@ typedef struct xnthread {
 
 	void *cookie;		/* Cookie to pass to the entry routine */
 
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	unsigned long __user *u_mode;	/* Thread mode variable in userland. */
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
     XNARCH_DECL_DISPLAY_CONTEXT();
 
 } xnthread_t;
Index: b/ksrc/nucleus/shadow.c
===================================================================
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1079,6 +1079,8 @@ redo:
 		/* Grab the request token. */
 		return -ERESTARTSYS;
 
+	__xn_put_user(0, thread->u_mode);
+
 	preempt_disable();
 
 	/* Assume that we might have been migrated while waiting for
@@ -1250,6 +1252,8 @@ void xnshadow_relax(int notify)
 	/* "current" is now running into the Linux domain on behalf of the
 	   root thread. */
 
+	__xn_put_user(XNRELAX, thread->u_mode);
+
 	trace_mark(xn_nucleus_shadow_relaxed,
 		  "thread %p thread_name %s comm %s",
 		  thread, xnthread_name(thread), current->comm);
@@ -1264,7 +1268,9 @@ void xnshadow_exit(void)
 }
 
 /*!
- * \fn int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion)
+ * \fn int xnshadow_map(xnthread_t *thread,
+ *                      xncompletion_t __user *u_completion,
+ *                      unsigned long __user *u_mode)
  * @internal
  * \brief Create a shadow thread context.
  *
@@ -1288,6 +1294,11 @@ void xnshadow_exit(void)
  * immediately started and "current" immediately resumes in the Xenomai
  * domain from this service.
  *
+ * @param: u_mode is the address of a mode variable in user space that
+ * will reflect the current thread mode (primary or secondary). The
+ * nucleus will try to update the variable before switching to secondary
+ * or after switching from primary mode.
+ *
  * @return 0 is returned on success. Otherwise:
  *
  * - -ERESTARTSYS is returned if the current Linux task has received a
@@ -1313,7 +1324,8 @@ void xnshadow_exit(void)
  *
  */
 
-int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion)
+int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion,
+		 unsigned long __user *u_mode)
 {
 	xnarch_cpumask_t affinity;
 	unsigned muxid, magic;
@@ -1325,6 +1337,9 @@ int xnshadow_map(xnthread_t *thread, xnc
 	if (xnthread_test_state(thread, XNMAPPED))
 		return -EINVAL;
 
+	if (!access_wok(u_mode, sizeof(*u_mode)))
+		return -EFAULT;
+
 #ifdef CONFIG_MMU
 	if (!(current->mm->def_flags & VM_LOCKED))
 		send_sig(SIGXCPU, current, 1);
@@ -1385,6 +1400,9 @@ int xnshadow_map(xnthread_t *thread, xnc
 	if (err)
 		return err;
 
+	thread->u_mode = u_mode;
+	__xn_put_user(XNRELAX, u_mode);
+
 	err = xnshadow_harden();
 
 	xnarch_trace_pid(xnarch_user_pid(xnthread_archtcb(thread)),
Index: b/ksrc/skins/native/syscall.c
===================================================================
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -191,7 +191,8 @@ static int __rt_task_create(struct pt_re
 		if (__xn_safe_copy_to_user((void __user *)bulk.a1, &ph, sizeof(ph)))
 			err = -EFAULT;
 		else {
-			err = xnshadow_map(&task->thread_base, u_completion);
+			err = xnshadow_map(&task->thread_base, u_completion,
+					   (unsigned long __user *)bulk.a6);
 			if (!err)
 				goto out;
 		}
Index: b/ksrc/skins/posix/syscall.c
===================================================================
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -180,7 +180,8 @@ static int __pthread_create(struct pt_re
 	if (err)
 		return -err;	/* Conventionally, our error codes are negative. */
 
-	err = xnshadow_map(&k_tid->threadbase, NULL);
+	err = xnshadow_map(&k_tid->threadbase, NULL,
+			   (unsigned long __user *)__xn_reg_arg2(regs));
 
 	if (!err && !__pthread_hash(&hkey, k_tid))
 		err = -ENOMEM;
@@ -196,7 +197,8 @@ static int __pthread_create(struct pt_re
 #define __pthread_detach  __pse51_call_not_available
 
 static pthread_t __pthread_shadow(struct task_struct *p,
-				  struct pse51_hkey *hkey)
+				  struct pse51_hkey *hkey,
+				  unsigned long __user *u_mode)
 {
 	pthread_attr_t attr;
 	pthread_t k_tid;
@@ -211,7 +213,7 @@ static pthread_t __pthread_shadow(struct
 	if (err)
 		return ERR_PTR(-err);
 
-	err = xnshadow_map(&k_tid->threadbase, NULL);
+	err = xnshadow_map(&k_tid->threadbase, NULL, u_mode);
 
 	if (!err && !__pthread_hash(hkey, k_tid))
 		err = -EAGAIN;
@@ -227,11 +229,13 @@ static pthread_t __pthread_shadow(struct
 static int __pthread_setschedparam(struct pt_regs *regs)
 {
 	int policy, err, promoted = 0;
+	unsigned long __user *u_mode;
 	struct sched_param param;
 	struct pse51_hkey hkey;
 	pthread_t k_tid;
 
 	policy = __xn_reg_arg2(regs);
+	u_mode = (unsigned long __user *)__xn_reg_arg4(regs);
 
 	if (__xn_safe_copy_from_user(&param,
 				     (void __user *)__xn_reg_arg3(regs), sizeof(param)))
@@ -241,10 +245,10 @@ static int __pthread_setschedparam(struc
 	hkey.mm = current->mm;
 	k_tid = __pthread_find(&hkey);
 
-	if (!k_tid && __xn_reg_arg1(regs) == __xn_reg_arg4(regs)) {
+	if (!k_tid && u_mode) {
 		/* If the syscall applies to "current", and the latter is not
 		   a Xenomai thread already, then shadow it. */
-		k_tid = __pthread_shadow(current, &hkey);
+		k_tid = __pthread_shadow(current, &hkey, u_mode);
 		if (IS_ERR(k_tid))
 			return PTR_ERR(k_tid);
 
Index: b/ksrc/skins/psos+/syscall.c
===================================================================
--- a/ksrc/skins/psos+/syscall.c
+++ b/ksrc/skins/psos+/syscall.c
@@ -60,11 +60,14 @@ static psostask_t *__psos_task_current(s
 }
 
 /*
- * int __t_create(const char *name,
- *                u_long prio,
- *                u_long flags,
+ * int __t_create(struct psos_arg_bulk *bulk,
  *                u_long *tid_r,
  *                xncompletion_t *completion)
+ * bulk = {
+ * a1: const char *name;
+ * a2: u_long prio;
+ * a3: u_long flags;
+ * a4: unsigned long *mode;
  */
 
 static int __t_create(struct pt_regs *regs)
@@ -73,10 +76,15 @@ static int __t_create(struct pt_regs *re
 	struct task_struct *p = current;
 	u_long prio, flags, tid, err;
 	char name[XNOBJECT_NAME_LEN];
+	struct psos_arg_bulk bulk;
 	psostask_t *task;
 
+	if (__xn_safe_copy_from_user(&bulk, (void __user *)__xn_reg_arg1(regs),
+				     sizeof(bulk)))
+		return -EFAULT;
+
 	/* Get task name. */
-	if (__xn_safe_strncpy_from_user(name, (const char __user *)__xn_reg_arg1(regs),
+	if (__xn_safe_strncpy_from_user(name, (const char __user *)bulk.a1,
 					sizeof(name) - 1) < 0)
 		return -EFAULT;
 
@@ -85,12 +93,12 @@ static int __t_create(struct pt_regs *re
 	p->comm[sizeof(p->comm) - 1] = '\0';
 
 	/* Task priority. */
-	prio = __xn_reg_arg2(regs);
+	prio = bulk.a2;
 	/* Task flags. Force FPU support in user-space. This will lead
 	   to a no-op if the platform does not support it. */
-	flags = __xn_reg_arg3(regs) | T_SHADOW | T_FPU;
+	flags = bulk.a3 | T_SHADOW | T_FPU;
 	/* Completion descriptor our parent thread is pending on. */
-	u_completion = (xncompletion_t __user *)__xn_reg_arg5(regs);
+	u_completion = (xncompletion_t __user *)__xn_reg_arg3(regs);
 
 	err = t_create(name, prio, 0, 0, flags, &tid);
 
@@ -100,14 +108,14 @@ static int __t_create(struct pt_regs *re
 		 * about the new thread id, so we can manipulate its
 		 * TCB pointer freely. */
 		tid = xnthread_handle(&task->threadbase);
-		if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg4(regs), &tid,
+		if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg2(regs), &tid,
 					   sizeof(tid)))
 			return -EFAULT;
-		else {
-			err = xnshadow_map(&task->threadbase, u_completion);	/* May be NULL */
-			if (!err)
-				goto out;
-		}
+
+		err = xnshadow_map(&task->threadbase, u_completion,
+				   (unsigned long __user *)bulk.a4);
+		if (!err)
+			goto out;
 
 		t_delete((u_long)task);
 	}
Index: b/ksrc/skins/vrtx/syscall.c
===================================================================
--- a/ksrc/skins/vrtx/syscall.c
+++ b/ksrc/skins/vrtx/syscall.c
@@ -48,6 +48,7 @@ static int __muxid;
  * a1: int tid;
  * a2: int prio;
  * a3: int mode;
+ * a4: unsigned long *shadow_mode;
  * }
  */
 
@@ -89,7 +90,8 @@ static int __sc_tecreate(struct pt_regs
 					   &tid, sizeof(tid)))
 			err = -EFAULT;
 		else {
-			err = xnshadow_map(&task->threadbase, u_completion);
+			err = xnshadow_map(&task->threadbase, u_completion,
+					   (unsigned long __user *)bulk.a4);
 			if (!err)
 				goto done;
 		}
Index: b/ksrc/skins/vxworks/syscall.c
===================================================================
--- a/ksrc/skins/vxworks/syscall.c
+++ b/ksrc/skins/vxworks/syscall.c
@@ -66,6 +66,7 @@ static WIND_TCB *__wind_task_current(str
  * a2: int prio;
  * a3: int flags;
  * a4: pthread_self();
+ * a5: unsigned long *mode;
  * }
  */
 
@@ -124,7 +125,8 @@ static int __wind_task_init(struct pt_re
 					   sizeof(ph)))
 			err = -EFAULT;
 		else {
-			err = xnshadow_map(&task->threadbase, u_completion);
+			err = xnshadow_map(&task->threadbase, u_completion,
+					   (unsigned long __user *)bulk.a5);
 			if (!err)
 				goto out;
 		}
Index: b/ksrc/skins/uitron/syscall.c
===================================================================
--- a/ksrc/skins/uitron/syscall.c
+++ b/ksrc/skins/uitron/syscall.c
@@ -31,13 +31,15 @@
 int __ui_muxid;
 
 /*
- * int __uitron_cre_tsk(ID tskid, T_CTSK *pk_ctsk, xncompletion_t *completion)
+ * int __uitron_cre_tsk(ID tskid, T_CTSK *pk_ctsk, xncompletion_t *completion,
+ *                      unsigned long *mode)
  */
 
 static int __ui_cre_tsk(struct pt_regs *regs)
 {
 	xncompletion_t __user *u_completion;
 	struct task_struct *p = current;
+	unsigned long __user *u_mode;
 	uitask_t *task;
 	T_CTSK pk_ctsk;
 	ID tskid;
@@ -54,6 +56,8 @@ static int __ui_cre_tsk(struct pt_regs *
 	/* Completion descriptor our parent thread is pending on. */
 	u_completion = (xncompletion_t __user *)__xn_reg_arg3(regs);
 
+	u_mode = (unsigned long __user *)__xn_reg_arg4(regs);
+
 	err = cre_tsk(tskid, &pk_ctsk);
 
 	if (likely(err == E_OK)) {
@@ -74,7 +78,7 @@ static int __ui_cre_tsk(struct pt_regs *
 		 * recycled before we could map it; however, the risk
 		 * is mitigated by consistency checks performed in
 		 * xnshadow_map(). */
-		return xnshadow_map(&task->threadbase, u_completion);	/* May be NULL */
+		return xnshadow_map(&task->threadbase, u_completion, u_mode);
 	}
 
       fail:
Index: b/include/asm-generic/bits/bind.h
===================================================================
--- a/include/asm-generic/bits/bind.h
+++ b/include/asm-generic/bits/bind.h
@@ -17,6 +17,8 @@
 #ifdef HAVE___THREAD
 __thread xnhandle_t xeno_current __attribute__ ((tls_model ("initial-exec"))) =
 	XN_NO_HANDLE;
+__thread unsigned long
+xeno_current_mode __attribute__ ((tls_model ("initial-exec")));
 
 static inline void __xeno_set_current(xnhandle_t current)
 {
@@ -24,17 +26,35 @@ static inline void __xeno_set_current(xn
 }
 #else /* !HAVE___THREAD */
 pthread_key_t xeno_current_key;
+pthread_key_t xeno_current_mode_key;
 
 static inline void __xeno_set_current(xnhandle_t current)
 {
 	pthread_setspecific(xeno_current_key, (void *)current);
 }
 
+unsigned long *xeno_init_current_mode(void)
+{
+	unsigned long *mode = malloc(sizeof(unsigned long));
+	pthread_setspecific(xeno_current_mode_key, mode);
+	return mode;
+}
+
+static void cleanup_current_mode(void *ptr)
+{
+	free(ptr);
+}
+
 static __attribute__ ((constructor))
-void init_current_key(void)
+void init_current_keys(void)
 {
 	int err = pthread_key_create(&xeno_current_key, NULL);
+	if (err)
+		goto error_exit;
+
+	err = pthread_key_create(&xeno_current_mode_key, cleanup_current_mode);
 	if (err) {
+	  error_exit:
 		fprintf(stderr, "Xenomai: error creating TSD key: %s\n",
 			strerror(err));
 		exit(1);
Index: b/include/asm-generic/bits/current.h
===================================================================
--- a/include/asm-generic/bits/current.h
+++ b/include/asm-generic/bits/current.h
@@ -6,14 +6,27 @@
 
 #ifdef HAVE___THREAD
 extern __thread xnhandle_t xeno_current __attribute__ ((tls_model ("initial-exec")));
+extern __thread unsigned long
+xeno_current_mode __attribute__ ((tls_model ("initial-exec")));
 
 static inline xnhandle_t xeno_get_current(void)
 {
 	return xeno_current;
 }
 
+static inline unsigned long xeno_get_current_mode(void)
+{
+	return xeno_current_mode;
+}
+
+static inline unsigned long *xeno_init_current_mode(void)
+{
+	return &xeno_current_mode;
+}
+
 #else /* ! HAVE___THREAD */
 extern pthread_key_t xeno_current_key;
+extern pthread_key_t xeno_current_mode_key;
 
 static inline xnhandle_t xeno_get_current(void)
 {
@@ -24,6 +37,13 @@ static inline xnhandle_t xeno_get_curren
 
 	return (xnhandle_t)val;
 }
+
+static inline unsigned long xeno_get_current_mode(void)
+{
+	return *(unsigned long *)pthread_getspecific(xeno_current_mode_key);
+}
+
+unsigned long *xeno_init_current_mode(void);
 #endif /* ! HAVE___THREAD */
 
 void xeno_set_current(void);
Index: b/src/skins/native/task.c
===================================================================
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -89,6 +89,12 @@ static void *rt_task_trampoline(void *co
 	bulk.a3 = (u_long)iargs->prio;
 	bulk.a4 = (u_long)iargs->mode;
 	bulk.a5 = (u_long)pthread_self();
+	bulk.a6 = (u_long)xeno_init_current_mode();
+
+	if (!bulk.a6) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
 	err = XENOMAI_SKINCALL2(__native_muxid,
 				__native_task_create, &bulk,
@@ -205,6 +211,10 @@ int rt_task_shadow(RT_TASK *task, const
 	bulk.a3 = (u_long)prio;
 	bulk.a4 = (u_long)mode;
 	bulk.a5 = (u_long)pthread_self();
+	bulk.a6 = (u_long)xeno_init_current_mode();
+
+	if (!bulk.a6)
+		return -ENOMEM;
 
 	err = XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk,
 				NULL);
Index: b/src/skins/posix/thread.c
===================================================================
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -47,11 +47,23 @@ int __wrap_pthread_setschedparam(pthread
 				 int policy, const struct sched_param *param)
 {
 	pthread_t myself = pthread_self();
+	unsigned long *mode_buf = NULL;
 	int err, promoted;
 
+	if (thread == myself) {
+#ifdef HAVE___THREAD
+		mode_buf = xeno_init_current_mode();
+#else /* !HAVE___THREAD */
+		mode_buf = malloc(sizeof(*mode_buf));
+
+		if (!mode_buf)
+			return ENOMEM;
+#endif /* !HAVE___THREAD */
+	}
+
 	err = -XENOMAI_SKINCALL5(__pse51_muxid,
 				 __pse51_thread_setschedparam,
-				 thread, policy, param, myself, &promoted);
+				 thread, policy, param, mode_buf, &promoted);
 
 	if (err == EPERM)
 		return __real_pthread_setschedparam(thread, policy, param);
@@ -60,10 +72,17 @@ int __wrap_pthread_setschedparam(pthread
 
 	if (!err && promoted) {
 		old_sigharden_handler = signal(SIGHARDEN, &__pthread_sigharden_handler);
+#ifndef HAVE___THREAD
+		pthread_setspecific(xeno_current_mode_key, mode_buf);
+#endif /* !HAVE___THREAD */
 		xeno_set_current();
 		if (policy != SCHED_OTHER)
 			XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
 	}
+#ifndef HAVE___THREAD
+	else
+		free(mode_buf);
+#endif /* !HAVE___THREAD */
 
 	return err;
 }
@@ -116,6 +135,7 @@ static void *__pthread_trampoline(void *
 	struct sched_param param;
 	void *status = NULL;
 	int parent_prio, policy;
+	unsigned long *mode_buf;
 	long err;
 
 	old_sigharden_handler = signal(SIGHARDEN, &__pthread_sigharden_handler);
@@ -123,10 +143,18 @@ static void *__pthread_trampoline(void *
 	param.sched_priority = iargs->prio;
 	policy = iargs->policy;
 	parent_prio = iargs->parent_prio;
+	mode_buf = xeno_init_current_mode();
+
+	if (!mode_buf) {
+		status = (void *)ENOMEM;
+		iargs->ret = ENOMEM;
+		goto out;
+	}
 
 	/* Do _not_ inline the call to pthread_self() in the syscall
 	   macro: this trashes the syscall regs on some archs. */
-	err = XENOMAI_SKINCALL1(__pse51_muxid, __pse51_thread_create, tid);
+	err = XENOMAI_SKINCALL2(__pse51_muxid, __pse51_thread_create, tid,
+				mode_buf);
 	iargs->ret = -err;
 
 	/* We must save anything we'll need to use from *iargs on our own
@@ -159,6 +187,7 @@ static void *__pthread_trampoline(void *
 	} else
 		status = (void *)-err;
 
+out:
 	pthread_exit(status);
 }
 
Index: b/include/vrtx/syscall.h
===================================================================
--- a/include/vrtx/syscall.h
+++ b/include/vrtx/syscall.h
@@ -85,6 +85,7 @@ struct vrtx_arg_bulk {
     u_long a1;
     u_long a2;
     u_long a3;
+    u_long a4;
 };
 
 #ifdef __KERNEL__
Index: b/include/vxworks/syscall.h
===================================================================
--- a/include/vxworks/syscall.h
+++ b/include/vxworks/syscall.h
@@ -77,6 +77,7 @@ struct wind_arg_bulk {
     u_long a2;
     u_long a3;
     u_long a4;
+    u_long a5;
 };
 
 #ifdef __KERNEL__
Index: b/src/skins/vrtx/task.c
===================================================================
--- a/src/skins/vrtx/task.c
+++ b/src/skins/vrtx/task.c
@@ -118,6 +118,12 @@ static void *vrtx_task_trampoline(void *
 	bulk.a1 = (u_long)iargs->tid;
 	bulk.a2 = (u_long)iargs->prio;
 	bulk.a3 = (u_long)iargs->mode;
+	bulk.a4 = (u_long)xeno_init_current_mode();
+
+	if (!bulk.a4) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
 	err = XENOMAI_SKINCALL3(__vrtx_muxid,
 				__vrtx_tecreate,
Index: b/src/skins/vxworks/taskLib.c
===================================================================
--- a/src/skins/vxworks/taskLib.c
+++ b/src/skins/vxworks/taskLib.c
@@ -118,6 +118,12 @@ static void *wind_task_trampoline(void *
 	bulk.a2 = (u_long)iargs->prio;
 	bulk.a3 = (u_long)iargs->flags;
 	bulk.a4 = (u_long)pthread_self();
+	bulk.a5 = (u_long)xeno_init_current_mode();
+
+	if (!bulk.a5) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
 	err = XENOMAI_SKINCALL3(__vxworks_muxid,
 				__vxworks_task_init,
Index: b/include/psos+/syscall.h
===================================================================
--- a/include/psos+/syscall.h
+++ b/include/psos+/syscall.h
@@ -74,6 +74,14 @@
 /* Xenomai extension: get raw count of jiffies */
 #define __psos_tm_getc      46
 
+struct psos_arg_bulk {
+
+    u_long a1;
+    u_long a2;
+    u_long a3;
+    u_long a4;
+};
+
 #ifdef __KERNEL__
 
 #ifdef __cplusplus
Index: b/src/skins/psos+/task.c
===================================================================
--- a/src/skins/psos+/task.c
+++ b/src/skins/psos+/task.c
@@ -72,6 +72,7 @@ static void *psos_task_trampoline(void *
 	struct psos_task_iargs *iargs = (struct psos_task_iargs *)cookie;
 	void (*entry)(u_long, u_long, u_long, u_long);
 	u_long dummy_args[4] = { 0, 0, 0, 0 }, *targs;
+	struct psos_arg_bulk bulk;
 	struct sched_param param;
 	int policy;
 	long err;
@@ -83,10 +84,19 @@ static void *psos_task_trampoline(void *
 
 	old_sigharden_handler = signal(SIGHARDEN, &psos_task_sigharden);
 
-	err = XENOMAI_SKINCALL5(__psos_muxid,
+	bulk.a1 = (u_long)iargs->name;
+	bulk.a2 = (u_long)iargs->prio;
+	bulk.a3 = (u_long)iargs->flags;
+	bulk.a4 = (u_long)xeno_init_current_mode();
+
+	if (!bulk.a4) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	err = XENOMAI_SKINCALL3(__psos_muxid,
 				__psos_t_create,
-				iargs->name, iargs->prio, iargs->flags,
-				iargs->tid_r, iargs->completionp);
+				&bulk, iargs->tid_r, iargs->completionp);
 	if (err)
 		goto fail;
 
Index: b/src/skins/uitron/task.c
===================================================================
--- a/src/skins/uitron/task.c
+++ b/src/skins/uitron/task.c
@@ -68,6 +68,7 @@ static void *uitron_task_trampoline(void
 {
 	struct uitron_task_iargs *iargs = (struct uitron_task_iargs *)cookie;
 	struct sched_param param;
+	unsigned long *mode;
 	void (*entry)(INT);
 	int policy;
 	long err;
@@ -83,10 +84,16 @@ static void *uitron_task_trampoline(void
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 	old_sigharden_handler = signal(SIGHARDEN, &uitron_task_sigharden);
 
-	err = XENOMAI_SKINCALL3(__uitron_muxid,
+	mode = xeno_init_current_mode();
+	if (!mode) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	err = XENOMAI_SKINCALL4(__uitron_muxid,
 				__uitron_cre_tsk,
 				iargs->tskid, iargs->pk_ctsk,
-				iargs->completionp);
+				iargs->completionp, mode);
 	if (err)
 		goto fail;
 


