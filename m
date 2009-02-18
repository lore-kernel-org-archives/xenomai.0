Message-ID: <499C422D.9090203@domain.hid>
Date: Wed, 18 Feb 2009 18:15:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Rework initial Linux schedparam setting
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
Cc: xenomai-core <xenomai@xenomai.org>

[ This obsoletes patch 1 of yesterday's series. ]

This patch enforces Linux task policy and priority alignment for shadow
threads via xnshadow_map and SIGSHADOW instead of solely relying on the
skins for this job. This allows to drop a few explicit
pthread_setschedparam calls from skin trampolines. It also helps to fix
SCHED_RR pthread_create (which is currently not forwarding the
round-robin property to the kernel side).

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/shadow.c        |   12 ++++++++++++
 ksrc/skins/posix/syscall.c   |    6 +++---
 src/skins/native/task.c      |   19 -------------------
 src/skins/native/wrappers.c  |    7 -------
 src/skins/native/wrappers.h  |    3 ---
 src/skins/posix/thread.c     |    9 ++-------
 src/skins/psos+/task.c       |    5 -----
 src/skins/vrtx/task.c        |    9 ---------
 src/skins/vxworks/taskLib.c  |    9 ---------
 src/skins/vxworks/wrappers.c |    7 -------
 src/skins/vxworks/wrappers.h |    3 ---
 11 files changed, 17 insertions(+), 72 deletions(-)

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 8c679ad..4a0f021 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1250,6 +1250,12 @@ int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion,
 	thread->u_mode = u_mode;
 
 	if (u_completion) {
+		/*
+		 * Send the renice signal if we are not migrating so that user
+		 * space will immediately align Linux sched policy and prio.
+		 */
+		xnshadow_renice(thread);
+
  		/*
 		 * We still have the XNDORMANT bit set, so we can't
  		 * link to the RPI queue which only links _runnable_
@@ -1273,6 +1279,12 @@ int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion,
 
 	ret = xnshadow_harden();
 
+	/*
+	 * Ensure that user space will receive the proper Linux task policy
+	 * and prio on next switch to secondary mode.
+	 */
+	xnthread_set_info(thread, XNPRIOSET);
+
 	xnarch_trace_pid(xnarch_user_pid(xnthread_archtcb(thread)),
 			 xnthread_current_priority(thread));
 
diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index 99c2a16..16303b3 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -167,9 +167,9 @@ static int __pthread_create(struct pt_regs *regs)
 	   calling context. */
 
 	pthread_attr_init(&attr);
-	attr.policy = p->policy;
+	attr.policy = __xn_reg_arg2(regs);
 	attr.detachstate = PTHREAD_CREATE_DETACHED;
-	attr.schedparam_ex.sched_priority = p->rt_priority;
+	attr.schedparam_ex.sched_priority = __xn_reg_arg3(regs);
 	attr.fp = 1;
 	attr.name = p->comm;
 
@@ -179,7 +179,7 @@ static int __pthread_create(struct pt_regs *regs)
 		return -err;	/* Conventionally, our error codes are negative. */
 
 	err = xnshadow_map(&k_tid->threadbase, NULL,
-			   (unsigned long __user *)__xn_reg_arg2(regs));
+			   (unsigned long __user *)__xn_reg_arg4(regs));
 
 	if (!err && !__pthread_hash(&hkey, k_tid))
 		err = -ENOMEM;
diff --git a/src/skins/native/task.c b/src/skins/native/task.c
index 7bcc49c..190dc4b 100644
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -55,21 +55,10 @@ static void *rt_task_trampoline(void *cookie)
 {
 	struct rt_task_iargs *iargs = (struct rt_task_iargs *)cookie;
 	void (*entry) (void *cookie);
-	struct sched_param param;
 	struct rt_arg_bulk bulk;
 	RT_TASK *task;
 	long err;
 
-	if (iargs->prio > 0) {
-		/*
-		 * Re-apply sched params here as some libpthread
-		 * implementations fail doing this via pthread_create.
-		 */
-		memset(&param, 0, sizeof(param));
-		param.sched_priority = iargs->prio;
-		__real_pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
-	}
-
 	/* rt_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
@@ -178,7 +167,6 @@ int rt_task_start(RT_TASK *task, void (*entry) (void *cookie), void *cookie)
 
 int rt_task_shadow(RT_TASK *task, const char *name, int prio, int mode)
 {
-	struct sched_param param;
 	struct rt_arg_bulk bulk;
 	RT_TASK task_desc;
 	int err;
@@ -190,13 +178,6 @@ int rt_task_shadow(RT_TASK *task, const char *name, int prio, int mode)
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 	sigshadow_install_once();
 
-	if (prio > 0) {
-		/* Make sure the POSIX library caches the right priority. */
-		memset(&param, 0, sizeof(param));
-		param.sched_priority = prio;
-		__real_pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
-	}
-
 	bulk.a1 = (u_long)task;
 	bulk.a2 = (u_long)name;
 	bulk.a3 = (u_long)prio;
diff --git a/src/skins/native/wrappers.c b/src/skins/native/wrappers.c
index 8421456..4463f6f 100644
--- a/src/skins/native/wrappers.c
+++ b/src/skins/native/wrappers.c
@@ -33,13 +33,6 @@
  */
 
 __attribute__ ((weak))
-int __real_pthread_setschedparam(pthread_t thread,
-				 int policy, const struct sched_param *param)
-{
-	return pthread_setschedparam(thread, policy, param);
-}
-
-__attribute__ ((weak))
 int __real_pthread_create(pthread_t *tid,
 			  const pthread_attr_t * attr,
 			  void *(*start) (void *), void *arg)
diff --git a/src/skins/native/wrappers.h b/src/skins/native/wrappers.h
index f2125a4..99568a9 100644
--- a/src/skins/native/wrappers.h
+++ b/src/skins/native/wrappers.h
@@ -8,9 +8,6 @@ int __real_pthread_create(pthread_t *tid,
 			  const pthread_attr_t * attr,
 			  void *(*start) (void *), void *arg);
 
-int __real_pthread_setschedparam(pthread_t thread,
-				 int policy, const struct sched_param *param);
-
 int __real_pthread_kill(pthread_t tid, int sig);
 
 int __real_open(const char *path, int oflag, ...);
diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
index f32c7e1..e8c50bd 100644
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -203,8 +203,8 @@ static void *__pthread_trampoline(void *arg)
 
 	/* Do _not_ inline the call to pthread_self() in the syscall
 	   macro: this trashes the syscall regs on some archs. */
-	err = XENOMAI_SKINCALL2(__pse51_muxid, __pse51_thread_create, tid,
-				mode_buf);
+	err = XENOMAI_SKINCALL4(__pse51_muxid, __pse51_thread_create, tid,
+				iargs->policy, iargs->prio, mode_buf);
 	iargs->ret = -err;
 
 	/* We must save anything we'll need to use from *iargs on our own
@@ -221,11 +221,6 @@ static void *__pthread_trampoline(void *arg)
 	__real_sem_post(&iargs->sync);
 
 	if (!err) {
-		/* Broken pthread libs ignore some of the thread attribute specs
-		   passed to pthread_create(3), so we force the scheduling policy
-		   once again here. */
-		__real_pthread_setschedparam(tid, policy, &param);
-
 		/* If the thread running pthread_create runs with the same
 		   priority as us, we should leave it running, as if there never
 		   was a synchronization with a semaphore. */
diff --git a/src/skins/psos+/task.c b/src/skins/psos+/task.c
index 265eab2..1bf3565 100644
--- a/src/skins/psos+/task.c
+++ b/src/skins/psos+/task.c
@@ -63,13 +63,8 @@ static void *psos_task_trampoline(void *cookie)
 	void (*entry)(u_long, u_long, u_long, u_long);
 	u_long dummy_args[4] = { 0, 0, 0, 0 }, *targs;
 	struct psos_arg_bulk bulk;
-	struct sched_param param;
-	int policy;
 	long err;
 
-	policy = psos_task_set_posix_priority(iargs->prio, &param);
-	pthread_setschedparam(pthread_self(), policy, &param);
-
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 	sigshadow_install_once();
 
diff --git a/src/skins/vrtx/task.c b/src/skins/vrtx/task.c
index 1b16f68..184c948 100644
--- a/src/skins/vrtx/task.c
+++ b/src/skins/vrtx/task.c
@@ -73,8 +73,6 @@ static void *vrtx_task_trampoline(void *cookie)
 	struct vrtx_task_iargs *iargs =
 	    (struct vrtx_task_iargs *)cookie, _iargs;
 	struct vrtx_arg_bulk bulk;
-	struct sched_param param;
-	int policy;
 	long err;
 #ifndef HAVE___THREAD
 	TCB *tcb;
@@ -83,13 +81,6 @@ static void *vrtx_task_trampoline(void *cookie)
 	/* Backup the arg struct, it might vanish after completion. */
 	memcpy(&_iargs, iargs, sizeof(_iargs));
 
-	/*
-	 * Apply sched params here as some libpthread implementations
-	 * fail doing this properly via pthread_create.
-	 */
-	policy = vrtx_task_set_posix_priority(iargs->prio, &param);
-	pthread_setschedparam(pthread_self(), policy, &param);
-
 	/* vrtx_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
diff --git a/src/skins/vxworks/taskLib.c b/src/skins/vxworks/taskLib.c
index 1ba193e..3249bfc 100644
--- a/src/skins/vxworks/taskLib.c
+++ b/src/skins/vxworks/taskLib.c
@@ -86,21 +86,12 @@ static void *wind_task_trampoline(void *cookie)
 	struct wind_task_iargs *iargs =
 	    (struct wind_task_iargs *)cookie, _iargs;
 	struct wind_arg_bulk bulk;
-	struct sched_param param;
 	WIND_TCB *pTcb;
-	int policy;
 	long err;
 
 	/* Backup the arg struct, it might vanish after completion. */
 	memcpy(&_iargs, iargs, sizeof(_iargs));
 
-	/*
-	 * Apply sched params here as some libpthread implementations
-	 * fail doing this properly via pthread_create.
-	 */
-	policy = wind_task_set_posix_priority(iargs->prio, &param);
-	__real_pthread_setschedparam(pthread_self(), policy, &param);
-
 	/* wind_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 	sigshadow_install_once();
diff --git a/src/skins/vxworks/wrappers.c b/src/skins/vxworks/wrappers.c
index 394ea51..ab50d77 100644
--- a/src/skins/vxworks/wrappers.c
+++ b/src/skins/vxworks/wrappers.c
@@ -33,13 +33,6 @@
  */
 
 __attribute__ ((weak))
-int __real_pthread_setschedparam(pthread_t thread,
-				 int policy, const struct sched_param *param)
-{
-	return pthread_setschedparam(thread, policy, param);
-}
-
-__attribute__ ((weak))
 int __real_pthread_create(pthread_t *tid,
 			  const pthread_attr_t * attr,
 			  void *(*start) (void *), void *arg)
diff --git a/src/skins/vxworks/wrappers.h b/src/skins/vxworks/wrappers.h
index 919309a..e20da86 100644
--- a/src/skins/vxworks/wrappers.h
+++ b/src/skins/vxworks/wrappers.h
@@ -8,9 +8,6 @@ int __real_pthread_create(pthread_t *tid,
 			  const pthread_attr_t * attr,
 			  void *(*start) (void *), void *arg);
 
-int __real_pthread_setschedparam(pthread_t thread,
-				 int policy, const struct sched_param *param);
-
 int __real_pthread_kill(pthread_t tid, int sig);
 
 int __real_open(const char *path, int oflag, ...);

