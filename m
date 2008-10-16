Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F764A5.7020501@domain.hid>
Message-Id: <20081016154621.802426487@domain.hid>
Date: Thu, 16 Oct 2008 17:46:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081016154620.320953568@domain.hid>
Content-Disposition: inline;
	filename=optionally-replace-pthread_getspecific-with-tls.patch
Subject: [Xenomai-core] [PATCH 09/12] Optionally replace pthread_getspecific
	with TLS variables
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

On architectures that support the __thread storage class and the
initial-exec TLS model, several use cases of pthread_get/setspecific can
be optimized. On x86, e.g., we are able to implement xeno_get_current()
via just two instructions instead of a call into glibc and all the
included pthread_key lookup. The minor downside of initial-exec TLS is
that libraries using such variables are excluded from dlopen.

This patch adds the required check to configure, also installing a
switch (--without-__thread) in order to disable the support if dlopen
compatibility should be required. It adds a __thread-variant for
xeno_get_current and self-references of the current Native, VRTX and
VxWorks tasks.

RTDK's rt_printf services are intentionally not converted as they are
heavy-weighted anyway and depend on the pthread_key destructor
mechanism.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 configure.in                       |   23 +++++++++++++++++++
 include/asm-generic/bits/bind.h    |   44 ++++++++++++++++++++++++++-----------
 include/asm-generic/bits/current.h |   13 +++++++++-
 src/skins/native/init.c            |    8 +++++-
 src/skins/native/task.c            |   21 +++++++++++++++++
 src/skins/vrtx/init.c              |    8 +++++-
 src/skins/vrtx/task.c              |   14 ++++++++++-
 src/skins/vxworks/init.c           |    8 +++++-
 src/skins/vxworks/taskLib.c        |   20 +++++++++++++++-
 9 files changed, 137 insertions(+), 22 deletions(-)

Index: b/configure.in
===================================================================
--- a/configure.in
+++ b/configure.in
@@ -762,6 +762,29 @@ LIBS="$LIBS -lrt"
 AC_CHECK_FUNCS([shm_open shm_unlink])
 LIBS="$save_LIBS"
 
+AC_ARG_WITH([__thread],
+	    AC_HELP_STRING([--without-__thread],
+			   [do not use TLS features (allows for dlopen'ing Xenomai libs)]),
+	    [use__thread=$withval],
+	    [use__thread=yes])
+
+dnl Check whether the compiler supports the __thread keyword.
+if test "x$use__thread" != xno; then
+	AC_CACHE_CHECK([for __thread], libc_cv_gcc___thread,
+	[cat > conftest.c <<\EOF
+__thread int a __attribute__ ((tls_model ("initial-exec"))) = 42;
+EOF
+	if AC_TRY_COMMAND([${CC-cc} $CFLAGS $CPPFLAGS -c -Werror conftest.c >&AS_MESSAGE_LOG_FD]); then
+		libc_cv_gcc___thread=yes
+	else
+		libc_cv_gcc___thread=no
+	fi
+	rm -f conftest*])
+	if test "$libc_cv_gcc___thread" = yes; then
+		AC_DEFINE(HAVE___THREAD,1,[config])
+	fi
+fi
+
 dnl
 dnl Build the Makefiles
 dnl
Index: b/include/asm-generic/bits/bind.h
===================================================================
--- a/include/asm-generic/bits/bind.h
+++ b/include/asm-generic/bits/bind.h
@@ -11,26 +11,26 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <nucleus/types.h>
 #include <asm/xenomai/syscall.h>
 
+#ifdef HAVE___THREAD
+__thread xnhandle_t xeno_current __attribute__ ((tls_model ("initial-exec"))) =
+	XN_NO_HANDLE;
+
+static inline void __xeno_set_current(xnhandle_t current)
+{
+	xeno_current = current;
+}
+#else /* !HAVE___THREAD */
 __attribute__ ((weak))
 pthread_key_t xeno_current_key;
 __attribute__ ((weak))
 pthread_once_t xeno_init_current_key_once = PTHREAD_ONCE_INIT;
 
-__attribute__ ((weak))
-void xeno_set_current(void)
+static inline void __xeno_set_current(xnhandle_t current)
 {
-	void *kthread_cb;
-	int err;
-
-	err = XENOMAI_SYSCALL1(__xn_sys_current, &kthread_cb);
-	if (err) {
-		fprintf(stderr, "Xenomai: error obtaining handle for current "
-			"thread: %s\n", strerror(err));
-		exit(1);
-	}
-	pthread_setspecific(xeno_current_key, kthread_cb);
+	pthread_setspecific(xeno_current_key, (void *)current);
 }
 
 static void init_current_key(void)
@@ -42,6 +42,22 @@ static void init_current_key(void)
 		exit(1);
 	}
 }
+#endif /* !HAVE___THREAD */
+
+__attribute__ ((weak))
+void xeno_set_current(void)
+{
+	xnhandle_t current;
+	int err;
+
+	err = XENOMAI_SYSCALL1(__xn_sys_current, &current);
+	if (err) {
+		fprintf(stderr, "Xenomai: error obtaining handle for current "
+			"thread: %s\n", strerror(err));
+		exit(1);
+	}
+	__xeno_set_current(current);
+}
 
 #ifdef CONFIG_XENO_FASTSYNCH
 __attribute__ ((weak))
@@ -175,7 +191,9 @@ xeno_bind_skin(unsigned skin_magic, cons
 	sa.sa_flags = 0;
 	sigaction(SIGXCPU, &sa, NULL);
 
+#ifndef HAVE___THREAD
 	pthread_once(&xeno_init_current_key_once, &init_current_key);
+#endif /* !HAVE___THREAD */
 
 #ifdef CONFIG_XENO_FASTSYNCH
 	/* In case we forked, we need to map the new local semaphore heap */
@@ -251,7 +269,9 @@ xeno_bind_skin_opt(unsigned skin_magic,
 	xeno_arch_features_check();
 #endif /* xeno_arch_features_check */
 
+#ifndef HAVE___THREAD
 	pthread_once(&xeno_init_current_key_once, &init_current_key);
+#endif /* !HAVE___THREAD */
 
 #ifdef CONFIG_XENO_FASTSYNCH
 	/* In case we forked, we need to map the new local semaphore heap */
Index: b/include/asm-generic/bits/current.h
===================================================================
--- a/include/asm-generic/bits/current.h
+++ b/include/asm-generic/bits/current.h
@@ -4,13 +4,22 @@
 #include <pthread.h>
 #include <nucleus/types.h>
 
-extern pthread_key_t xeno_current_key;
+#ifdef HAVE___THREAD
+extern __thread xnhandle_t xeno_current __attribute__ ((tls_model ("initial-exec")));
 
-extern void xeno_set_current(void);
+static inline xnhandle_t xeno_get_current(void)
+{
+	return xeno_current;
+}
+#else /* ! HAVE___THREAD */
+extern pthread_key_t xeno_current_key;
 
 static inline xnhandle_t xeno_get_current(void)
 {
 	return (xnhandle_t)pthread_getspecific(xeno_current_key);
 }
+#endif /* ! HAVE___THREAD */
+
+extern void xeno_set_current(void);
 
 #endif /* _XENO_ASM_GENERIC_CURRENT_H */
Index: b/src/skins/native/init.c
===================================================================
--- a/src/skins/native/init.c
+++ b/src/skins/native/init.c
@@ -27,16 +27,18 @@
 #include <asm-generic/bits/bind.h>
 #include <asm-generic/bits/mlock_alert.h>
 
-pthread_key_t __native_tskey;
-
 int __native_muxid = -1;
 void native_timer_init(int);
 
+#ifndef HAVE___THREAD
+pthread_key_t __native_tskey;
+
 static void __flush_tsd(void *tsd)
 {
 	/* Free the task descriptor allocated by rt_task_self(). */
 	free(tsd);
 }
+#endif /* !HAVE___THREAD */
 
 static __attribute__ ((constructor))
 void __init_xeno_interface(void)
@@ -50,10 +52,12 @@ void __init_xeno_interface(void)
 	
 	__native_muxid = __xn_mux_shifted_id(__native_muxid);
 
+#ifndef HAVE___THREAD
 	/* Allocate a TSD key for indexing self task pointers. */
 
 	if (pthread_key_create(&__native_tskey, &__flush_tsd) != 0) {
 		fprintf(stderr, "Xenomai: failed to allocate new TSD key?!\n");
 		exit(1);
 	}
+#endif /* !HAVE___THREAD */
 }
Index: b/src/skins/native/task.c
===================================================================
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -29,7 +29,14 @@
 #include <asm-generic/bits/current.h>
 #include "wrappers.h"
 
+#ifdef HAVE___THREAD
+__thread RT_TASK __native_self __attribute__ ((tls_model ("initial-exec"))) = {
+	.opaque = XN_NO_HANDLE,
+	.opaque2 = 0
+};
+#else /* !HAVE___THREAD */
 extern pthread_key_t __native_tskey;
+#endif /* !HAVE___THREAD */
 
 extern int __native_muxid;
 
@@ -91,6 +98,10 @@ static void *rt_task_trampoline(void *co
 
 	xeno_set_current();
 
+#ifdef HAVE___THREAD
+	__native_self = *iargs->task;
+#endif /* HAVE___THREAD */
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */
@@ -316,6 +327,15 @@ RT_TASK *rt_task_self(void)
 {
 	RT_TASK *self;
 
+#ifdef HAVE___THREAD
+	self = &__native_self;
+
+	if (self->opaque == XN_NO_HANDLE)
+		return NULL;
+
+#else /* !HAVE___THREAD */
+	RT_TASK *self;
+
 	self = (RT_TASK *)pthread_getspecific(__native_tskey);
 
 	if (self)
@@ -330,6 +350,7 @@ RT_TASK *rt_task_self(void)
 	}
 
 	pthread_setspecific(__native_tskey, self);
+#endif /* !HAVE___THREAD */
 
 	return self;
 }
Index: b/src/skins/vxworks/init.c
===================================================================
--- a/src/skins/vxworks/init.c
+++ b/src/skins/vxworks/init.c
@@ -26,15 +26,17 @@
 #include <asm-generic/bits/bind.h>
 #include <asm-generic/bits/mlock_alert.h>
 
-pthread_key_t __vxworks_tskey;
-
 int __vxworks_muxid = -1;
 
+#ifndef HAVE___THREAD
+pthread_key_t __vxworks_tskey;
+
 static void __flush_tsd(void *tsd)
 {
 	/* Free the task descriptor allocated by taskIdSelf(). */
 	free(tsd);
 }
+#endif /* !HAVE___THREAD */
 
 static __attribute__ ((constructor))
 void __init_xeno_interface(void)
@@ -43,10 +45,12 @@ void __init_xeno_interface(void)
 					 "vxworks", "xeno_vxworks");
 	__vxworks_muxid = __xn_mux_shifted_id(__vxworks_muxid);
 
+#ifndef HAVE___THREAD
 	/* Allocate a TSD key for indexing self task pointers. */
 
 	if (pthread_key_create(&__vxworks_tskey, &__flush_tsd) != 0) {
 		fprintf(stderr, "Xenomai: failed to allocate new TSD key?!\n");
 		exit(1);
 	}
+#endif /* !HAVE___THREAD */
 }
Index: b/src/skins/vxworks/taskLib.c
===================================================================
--- a/src/skins/vxworks/taskLib.c
+++ b/src/skins/vxworks/taskLib.c
@@ -30,7 +30,14 @@
 #include <asm-generic/bits/current.h>
 #include "wrappers.h"
 
+#ifdef HAVE___THREAD
+__thread WIND_TCB
+__vxworks_self __attribute__ ((tls_model ("initial-exec"))) = {
+	.handle = XN_NO_HANDLE
+};
+#else /* !HAVE___THREAD */
 extern pthread_key_t __vxworks_tskey;
+#endif /* !HAVE___THREAD */
 
 extern int __vxworks_muxid;
 
@@ -120,6 +127,10 @@ static void *wind_task_trampoline(void *
 
 	xeno_set_current();
 
+#ifdef HAVE___THREAD
+	__vxworks_self = *iargs->pTcb;
+#endif /* HAVE___THREAD */
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */
@@ -309,9 +320,15 @@ STATUS taskResume(TASK_ID task_id)
 
 TASK_ID taskIdSelf(void)
 {
-	WIND_TCB *self = (WIND_TCB *)pthread_getspecific(__vxworks_tskey);
+#ifdef HAVE___THREAD
+	return __vxworks_self.handle;
+
+#else /* !HAVE___THREAD */
+	WIND_TCB *self;
 	int err;
 
+	self = (WIND_TCB *)pthread_getspecific(__vxworks_tskey);
+
 	if (self)
 		return self->handle;
 
@@ -332,6 +349,7 @@ TASK_ID taskIdSelf(void)
 	pthread_setspecific(__vxworks_tskey, self);
 
 	return self->handle;
+#endif /* !HAVE___THREAD */
 }
 
 STATUS taskPrioritySet(TASK_ID task_id, int prio)
Index: b/src/skins/vrtx/init.c
===================================================================
--- a/src/skins/vrtx/init.c
+++ b/src/skins/vrtx/init.c
@@ -26,15 +26,17 @@
 #include <asm-generic/bits/bind.h>
 #include <asm-generic/bits/mlock_alert.h>
 
-pthread_key_t __vrtx_tskey;
-
 int __vrtx_muxid = -1;
 
+#ifndef HAVE___THREAD
+pthread_key_t __vrtx_tskey;
+
 static void __flush_tsd(void *tsd)
 {
 	/* Free the TCB struct. */
 	free(tsd);
 }
+#endif /* !HAVE___THREAD */
 
 static __attribute__ ((constructor))
 void __init_xeno_interface(void)
@@ -43,10 +45,12 @@ void __init_xeno_interface(void)
 	    xeno_bind_skin(VRTX_SKIN_MAGIC, "vrtx", "xeno_vrtx");
 	__vrtx_muxid = __xn_mux_shifted_id(__vrtx_muxid);
 
+#ifndef HAVE___THREAD
 	/* Allocate a TSD key for indexing self task pointers. */
 
 	if (pthread_key_create(&__vrtx_tskey, &__flush_tsd) != 0) {
 		fprintf(stderr, "Xenomai: failed to allocate new TSD key?!\n");
 		exit(1);
 	}
+#endif /* !HAVE___THREAD */
 }
Index: b/src/skins/vrtx/task.c
===================================================================
--- a/src/skins/vrtx/task.c
+++ b/src/skins/vrtx/task.c
@@ -29,7 +29,11 @@
 #include <vrtx/vrtx.h>
 #include <asm-generic/bits/current.h>
 
+#ifdef HAVE___THREAD
+__thread TCB __vrtx_tcb __attribute__ ((tls_model ("initial-exec")));
+#else /* !HAVE___THREAD */
 extern pthread_key_t __vrtx_tskey;
+#endif /* !HAVE___THREAD */
 
 extern int __vrtx_muxid;
 
@@ -81,7 +85,9 @@ static void *vrtx_task_trampoline(void *
 	struct sched_param param;
 	int policy;
 	long err;
+#ifndef HAVE___THREAD
 	TCB *tcb;
+#endif /* !HAVE___THREAD */
 
 	/* Backup the arg struct, it might vanish after completion. */
 	memcpy(&_iargs, iargs, sizeof(_iargs));
@@ -96,6 +102,7 @@ static void *vrtx_task_trampoline(void *
 	/* vrtx_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
+#ifndef HAVE___THREAD
 	tcb = (TCB *) malloc(sizeof(*tcb));
 	if (tcb == NULL) {
 		fprintf(stderr, "Xenomai: failed to allocate local TCB?!\n");
@@ -104,6 +111,7 @@ static void *vrtx_task_trampoline(void *
 	}
 
 	pthread_setspecific(__vrtx_tskey, tcb);
+#endif /* !HAVE___THREAD */
 
 	old_sigharden_handler = signal(SIGHARDEN, &vrtx_task_sigharden);
 
@@ -224,7 +232,11 @@ TCB *sc_tinquiry(int pinfo[], int tid, i
 {
 	TCB *tcb;
 
-	tcb = (TCB *) pthread_getspecific(__vrtx_tskey);	/* Cannot fail. */
+#ifdef HAVE___THREAD
+	tcb = &__vrtx_tcb;
+#else /* !HAVE___THREAD */
+	tcb = (TCB *) pthread_getspecific(__vrtx_tskey); /* Cannot fail. */
+#endif /* !HAVE___THREAD */
 
 	*errp = XENOMAI_SKINCALL3(__vrtx_muxid,
 				  __vrtx_tinquiry, pinfo, tcb, tid);


