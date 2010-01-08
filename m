Message-ID: <4B47B38E.6030408@domain.hid>
Date: Fri, 08 Jan 2010 23:37:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B45F088.9010603@domain.hid>	<4B45F163.4000504@domain.hid>	<4B460255.30200@domain.hid>	<4B46125D.4010602@domain.hid>	<4B471B48.6040301@domain.hid>	<4B471D96.7050001@domain.hid>	<4B473206.90209@domain.hid>	<4B47338E.9080304@domain.hid>	<4B4735F4.6060503@domain.hid>	<4B4738FE.4020605@domain.hid>
	<4B473A59.4090905@domain.hid>	<4B4755DA.3060201@domain.hid>
	<4B476768.2080502@domain.hid>
In-Reply-To: <4B476768.2080502@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] native skin 2.5.0: rt_task_create() segfaults if
 stacksize parameter too small
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> No. I think you are right, we will make the minimum PTHREAD_STACK_MIN +
> getpagesize() to account for differences between architectures.
> 
> Patch will come soon.

Here it comes.

diff --git a/include/asm-generic/stacksize.h b/include/asm-generic/stacksize.h
new file mode 100644
index 0000000..f82f390
--- /dev/null
+++ b/include/asm-generic/stacksize.h
@@ -0,0 +1,30 @@
+#ifndef STACKSIZE_H
+#define STACKSIZE_H
+
+#include <stdint.h>
+#include <pthread.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif /* __cplusplus */
+
+static inline unsigned xeno_stacksize(unsigned size)
+{
+	static const unsigned default_size = __WORDSIZE * 1024;
+	static unsigned min_size;
+	if (!min_size)
+		min_size = PTHREAD_STACK_MIN + getpagesize();
+
+	if (!size)
+		size = default_size;
+	if (size < min_size)
+		size = min_size;
+
+	return size;
+}
+
+#ifdef __cplusplus
+}
+#endif /* __cplusplus */
+
+#endif /* STACKSIZE_H */
diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index c6b5c55..1d2b70a 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -455,7 +455,7 @@ static void spawn_printer_thread(void)
 	pthread_attr_t thattr;
 
 	pthread_attr_init(&thattr);
-	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
+	pthread_attr_setstacksize(&thattr, xeno_stacksize(0));
 	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
 }
 
diff --git a/src/skins/native/task.c b/src/skins/native/task.c
index f6c2de9..341e4d8 100644
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -28,6 +28,7 @@
 #include <native/task.h>
 #include <asm-generic/bits/sigshadow.h>
 #include <asm-generic/bits/current.h>
+#include <asm-generic/stacksize.h>
 #include "wrappers.h"
 
 #ifdef HAVE___THREAD
@@ -146,10 +147,7 @@ int rt_task_create(RT_TASK *task,
 
 	pthread_attr_init(&thattr);
 
-	if (!stksize)
-		stksize = 32 * 1024;
-	if (stksize < PTHREAD_STACK_MIN)
-		stksize = PTHREAD_STACK_MIN;
+	stksize = xeno_stacksize(stksize);
 
 	pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
 	memset(&param, 0, sizeof(param));
diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
index 7a8d012..9115a58 100644
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -28,6 +28,7 @@
 #include <posix/syscall.h>
 #include <asm-generic/bits/current.h>
 #include <asm-generic/bits/sigshadow.h>
+#include <asm-generic/stacksize.h>
 
 extern int __pse51_muxid;
 
@@ -244,10 +245,11 @@ int __wrap_pthread_create(pthread_t *tid,
 			  void *(*start) (void *), void *arg)
 {
 	struct pthread_iargs iargs;
+	struct sched_param param;
 	pthread_attr_t iattr;
 	int inherit, err;
-	struct sched_param param;
 	pthread_t ltid;
+	unsigned stksz;
 
 	if (!attr)
 		attr = &default_attr;
@@ -274,6 +276,8 @@ int __wrap_pthread_create(pthread_t *tid,
 		/* Get the created thread to temporarily inherit pthread_create
 		   caller priority */
 		pthread_attr_setinheritsched(&iattr, PTHREAD_INHERIT_SCHED);
+	pthread_attr_getstacksize(&iattr, &stksz);
+	pthread_attr_setstacksize(&iattr, xeno_stacksize(stksz));
 	attr = &iattr;
 
 	/* First start a native POSIX thread, then associate a Xenomai shadow to
diff --git a/src/skins/psos+/task.c b/src/skins/psos+/task.c
index d9b0a1e..b5f36d2 100644
--- a/src/skins/psos+/task.c
+++ b/src/skins/psos+/task.c
@@ -28,6 +28,7 @@
 #include <psos+/psos.h>
 #include <asm-generic/bits/sigshadow.h>
 #include <asm-generic/bits/current.h>
+#include <asm-generic/stacksize.h>
 
 extern int __psos_muxid;
 
@@ -141,10 +142,7 @@ u_long t_create(const char *name,
 
 	ustack += sstack;
 
-	if (ustack == 0)
-		ustack = PTHREAD_STACK_MIN * 4;
-	else if (ustack < PTHREAD_STACK_MIN * 2)
-		ustack = PTHREAD_STACK_MIN * 2;
+	ustack = xeno_stacksize(ustack);
 
 	pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
 	policy = psos_task_set_posix_priority(prio, &param);
diff --git a/src/skins/uitron/task.c b/src/skins/uitron/task.c
index e7468c7..69022c2 100644
--- a/src/skins/uitron/task.c
+++ b/src/skins/uitron/task.c
@@ -127,10 +127,7 @@ ER cre_tsk(ID tskid, T_CTSK *pk_ctsk)
 
 	pthread_attr_init(&thattr);
 
-	if (pk_ctsk->stksz == 0)
-		pk_ctsk->stksz = PTHREAD_STACK_MIN * 4;
-	else if (pk_ctsk->stksz < PTHREAD_STACK_MIN * 2)
-		pk_ctsk->stksz = PTHREAD_STACK_MIN * 2;
+	pk_ctsk->stksz = xeno_stacksize(pk_ctsk->stksz);
 
 	pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
 	policy = uitron_task_set_posix_priority(pk_ctsk->itskpri, &param);
diff --git a/src/skins/vrtx/task.c b/src/skins/vrtx/task.c
index c835db0..8b9e051 100644
--- a/src/skins/vrtx/task.c
+++ b/src/skins/vrtx/task.c
@@ -31,6 +31,7 @@
 #include <vrtx/vrtx.h>
 #include <asm-generic/bits/sigshadow.h>
 #include <asm-generic/bits/current.h>
+#include <asm-generic/stacksize.h>
 #include "wrappers.h"
 
 #ifdef HAVE___THREAD
@@ -150,10 +151,7 @@ int sc_tecreate(void (*entry) (void *),
 
 	pthread_attr_init(&thattr);
 
-	if (ustacksz == 0)
-		ustacksz = PTHREAD_STACK_MIN * 4;
-	else if (ustacksz < PTHREAD_STACK_MIN * 2)
-		ustacksz = PTHREAD_STACK_MIN * 2;
+	ustacksz = xeno_stacksize(ustacksz);
 
 	pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
 	policy = vrtx_task_set_posix_priority(prio, &param);
diff --git a/src/skins/vxworks/taskLib.c b/src/skins/vxworks/taskLib.c
index 3249bfc..6b118e7 100644
--- a/src/skins/vxworks/taskLib.c
+++ b/src/skins/vxworks/taskLib.c
@@ -30,6 +30,7 @@
 #include <vxworks/vxworks.h>
 #include <asm-generic/bits/sigshadow.h>
 #include <asm-generic/bits/current.h>
+#include <asm-generic/stacksize.h>
 #include "wrappers.h"
 
 #ifdef HAVE___THREAD
@@ -184,10 +185,7 @@ STATUS taskInit(WIND_TCB *pTcb,
 
 	pthread_attr_init(&thattr);
 
-	if (stacksize == 0)
-		stacksize = PTHREAD_STACK_MIN * 4;
-	else if (stacksize < PTHREAD_STACK_MIN * 2)
-		stacksize = PTHREAD_STACK_MIN * 2;
+	stacksize = xeno_stacksize(stacksize);
 
 	pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
 	policy = wind_task_set_posix_priority(prio, &param);
diff --git a/src/testsuite/switchtest/switchtest.c b/src/testsuite/switchtest/switchtest.c
index 66d0eab..b1cb728 100644
--- a/src/testsuite/switchtest/switchtest.c
+++ b/src/testsuite/switchtest/switchtest.c
@@ -17,6 +17,7 @@
 
 #include <xeno_config.h>
 #include <asm/xenomai/fptest.h>
+#include <asm-generic/stacksize.h>
 #include <nucleus/trace.h>
 #include <rtdm/rttesting.h>
 
@@ -43,17 +44,8 @@ typedef unsigned long cpu_set_t;
 #define smp_sched_setaffinity(pid,len,mask) 0
 #endif /* !CONFIG_SMP */
 
-#if PTHREAD_STACK_MIN < 20 * 1024
-#define SMALL_STACK_MIN  20 * 1024
-#else
-#define SMALL_STACK_MIN  PTHREAD_STACK_MIN
-#endif
-
-#if PTHREAD_STACK_MIN < 50 * 1024
-#define LARGE_STACK_MIN  50 * 1024
-#else
-#define LARGE_STACK_MIN  PTHREAD_STACK_MIN
-#endif
+#define SMALL_STACK_MIN xeno_stacksize(20 * 1024)
+#define LARGE_STACK_MIN xeno_stacksize(50 * 1024)
 
 /* Thread type. */
 typedef enum {


-- 
					    Gilles.

