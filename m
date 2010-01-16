From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 16 Jan 2010 21:04:59 +0100
Message-Id: <1263672300-20868-2-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1263672300-20868-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <4B521B97.7010203@domain.hid>
	<1263672300-20868-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] [PATCH 2/3] skins: fault the main thread stack when
	shadowing it.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

---
 include/asm-generic/bits/bind.h |    2 ++
 src/skins/common/bind.c         |   14 ++++++++++++++
 src/skins/native/task.c         |    2 ++
 src/skins/posix/thread.c        |    2 ++
 src/skins/psos+/task.c          |    2 ++
 src/skins/uitron/task.c         |    9 +++++++--
 6 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bits/bind.h b/include/asm-generic/bits/bind.h
index 7267e0d..f43e096 100644
--- a/include/asm-generic/bits/bind.h
+++ b/include/asm-generic/bits/bind.h
@@ -37,4 +37,6 @@ xeno_bind_skin(unsigned skin_magic, const char *skin,
 	return muxid;
 }
 
+void xeno_fault_stack(void);
+
 #endif /* _XENO_ASM_GENERIC_BITS_BIND_H */
diff --git a/src/skins/common/bind.c b/src/skins/common/bind.c
index 44017e8..0717ac1 100644
--- a/src/skins/common/bind.c
+++ b/src/skins/common/bind.c
@@ -7,8 +7,10 @@
 #include <asm/xenomai/syscall.h>
 #include <asm-generic/xenomai/bits/bind.h>
 #include <asm-generic/xenomai/bits/current.h>
+#include <asm-generic/xenomai/stacksize.h>
 #include "sem_heap.h"
 
+static pthread_t xeno_main_tid;
 static xnsighandler *xnsig_handlers[32];
 
 void __attribute__((weak)) xeno_sigill_handler(int sig)
@@ -133,5 +135,17 @@ xeno_bind_skin_opt(unsigned skin_magic, const char *skin,
 
 	xeno_featinfo = finfo;
 
+	xeno_main_tid = pthread_self();
+	
 	return muxid;
 }
+
+void xeno_fault_stack(void)
+{
+	char stk[xeno_stacksize(1)];
+
+	if (pthread_self() != xeno_main_tid)
+		return;
+
+	stk[0] = stk[sizeof(stk) - 1] = 0xA5;
+}
diff --git a/src/skins/native/task.c b/src/skins/native/task.c
index 341e4d8..e0b3bbd 100644
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -187,6 +187,8 @@ int rt_task_shadow(RT_TASK *task, const char *name, int prio, int mode)
 	RT_TASK *self;
 	int err;
 
+	xeno_fault_stack();
+
 #ifdef HAVE___THREAD
 	self = &__native_self;
 #else /* !HAVE___THREAD */
diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
index 9115a58..dcc9373 100644
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -43,6 +43,8 @@ int __wrap_pthread_setschedparam(pthread_t thread,
 	int err, promoted;
 
 	if (thread == myself) {
+		xeno_fault_stack();
+
 #ifdef HAVE___THREAD
 		mode_buf = xeno_init_current_mode();
 #else /* !HAVE___THREAD */
diff --git a/src/skins/psos+/task.c b/src/skins/psos+/task.c
index b5f36d2..4325a97 100644
--- a/src/skins/psos+/task.c
+++ b/src/skins/psos+/task.c
@@ -172,6 +172,8 @@ u_long t_shadow(const char *name, /* Xenomai extension. */
 	struct psos_arg_bulk bulk;
 	int ret;
 
+	xeno_fault_stack();
+
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 	sigshadow_install_once();
 
diff --git a/src/skins/uitron/task.c b/src/skins/uitron/task.c
index 69022c2..ed91a09 100644
--- a/src/skins/uitron/task.c
+++ b/src/skins/uitron/task.c
@@ -23,11 +23,14 @@
 #include <signal.h>
 #include <errno.h>
 #include <limits.h>
+
 #include <asm/xenomai/system.h>
 #include <asm-generic/bits/sigshadow.h>
+#include <asm-generic/bits/current.h>
+#include <asm-generic/stacksize.h>
+#include <asm-generic/bits/bind.h>
 #include <nucleus/sched.h>
 #include <uitron/uitron.h>
-#include <asm-generic/bits/current.h>
 
 extern int __uitron_muxid;
 
@@ -149,7 +152,9 @@ ER shd_tsk(ID tskid, T_CTSK *pk_ctsk) /* Xenomai extension. */
 {
 	struct sched_param param;
 	int policy, err;
-	
+
+	xeno_fault_stack();
+
 	/* Make sure the POSIX library caches the right priority. */
 	policy = uitron_task_set_posix_priority(pk_ctsk->itskpri, &param);
 	pthread_setschedparam(pthread_self(), policy, &param);
-- 
1.5.6.5


