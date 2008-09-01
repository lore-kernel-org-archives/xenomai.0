Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48BBB22E.7060000@domain.hid>
Message-ID: <48BBAC13.2010709@domain.hid>
Date: Mon, 01 Sep 2008 10:47:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid>
In-Reply-To: <48BBA9E6.5070400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 4/9] Spread xeno_set_current
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

Spread xeno_set_current under all user space supporting skins.

---
 src/skins/native/task.c     |   13 +++++++++++--
 src/skins/psos+/task.c      |   18 ++++++++++++++----
 src/skins/uitron/task.c     |   18 +++++++++++++-----
 src/skins/vrtx/task.c       |    3 +++
 src/skins/vxworks/taskLib.c |    3 +++
 5 files changed, 44 insertions(+), 11 deletions(-)

Index: b/src/skins/native/task.c
===================================================================
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -26,6 +26,7 @@
 #include <limits.h>
 #include <native/syscall.h>
 #include <native/task.h>
+#include <asm-generic/bits/current.h>
 #include "wrappers.h"
 
 extern pthread_key_t __native_tskey;
@@ -88,6 +89,8 @@ static void *rt_task_trampoline(void *co
 	if (err)
 		goto fail;
 
+	xeno_set_current();
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */
@@ -169,6 +172,7 @@ int rt_task_shadow(RT_TASK *task, const
 	struct sched_param param;
 	struct rt_arg_bulk bulk;
 	RT_TASK task_desc;
+	int err;
 
 	if (task == NULL)
 		task = &task_desc; /* Discarded. */
@@ -191,8 +195,13 @@ int rt_task_shadow(RT_TASK *task, const
 	bulk.a4 = (u_long)mode;
 	bulk.a5 = (u_long)pthread_self();
 
-	return XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk,
-				 NULL);
+	err = XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk,
+				NULL);
+
+	if (!err)
+		xeno_set_current();
+
+	return err;
 }
 
 int rt_task_bind(RT_TASK *task, const char *name, RTIME timeout)
Index: b/src/skins/psos+/task.c
===================================================================
--- a/src/skins/psos+/task.c
+++ b/src/skins/psos+/task.c
@@ -26,6 +26,7 @@
 #include <memory.h>
 #include <string.h>
 #include <psos+/psos.h>
+#include <asm-generic/bits/current.h>
 
 extern int __psos_muxid;
 
@@ -89,6 +90,8 @@ static void *psos_task_trampoline(void *
 	if (err)
 		goto fail;
 
+	xeno_set_current();
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */
@@ -173,14 +176,21 @@ u_long t_shadow(const char *name, /* Xen
 		u_long flags,
 		u_long *tid_r)
 {
+	int err;
+
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
 	old_sigharden_handler = signal(SIGHARDEN, &psos_task_sigharden);
 
-	return XENOMAI_SKINCALL5(__psos_muxid,
-				 __psos_t_create,
-				 name, prio, flags,
-				 tid_r, NULL);
+	err = XENOMAI_SKINCALL5(__psos_muxid,
+				__psos_t_create,
+				name, prio, flags,
+				tid_r, NULL);
+
+	if (!err)
+		xeno_set_current();
+
+	return err;
 }
 
 u_long t_start(u_long tid,
Index: b/src/skins/uitron/task.c
===================================================================
--- a/src/skins/uitron/task.c
+++ b/src/skins/uitron/task.c
@@ -25,6 +25,7 @@
 #include <limits.h>
 #include <asm/xenomai/system.h>
 #include <uitron/uitron.h>
+#include <asm-generic/bits/current.h>
 
 extern int __uitron_muxid;
 
@@ -89,6 +90,8 @@ static void *uitron_task_trampoline(void
 	if (err)
 		goto fail;
 
+	xeno_set_current();
+
 	/* iargs->pk_ctsk might not be valid anymore, after our parent
 	   was released from the completion sync, so do not
 	   dereference this pointer. */
@@ -150,7 +153,7 @@ ER cre_tsk(ID tskid, T_CTSK *pk_ctsk)
 ER shd_tsk(ID tskid, T_CTSK *pk_ctsk) /* Xenomai extension. */
 {
 	struct sched_param param;
-	int policy;
+	int policy, err;
 	
 	/* Make sure the POSIX library caches the right priority. */
 	policy = uitron_task_set_posix_priority(pk_ctsk->itskpri, &param);
@@ -160,10 +163,15 @@ ER shd_tsk(ID tskid, T_CTSK *pk_ctsk) /*
 
 	old_sigharden_handler = signal(SIGHARDEN, &uitron_task_sigharden);
 
-	return XENOMAI_SKINCALL3(__uitron_muxid,
-				 __uitron_cre_tsk,
-				 tskid, pk_ctsk,
-				 NULL);
+	err = XENOMAI_SKINCALL3(__uitron_muxid,
+				__uitron_cre_tsk,
+				tskid, pk_ctsk,
+				NULL);
+
+	if (!err)
+		xeno_set_current();
+
+	return err;
 }
 
 ER del_tsk(ID tskid)
Index: b/src/skins/vrtx/task.c
===================================================================
--- a/src/skins/vrtx/task.c
+++ b/src/skins/vrtx/task.c
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <vrtx/vrtx.h>
+#include <asm-generic/bits/current.h>
 
 extern pthread_key_t __vrtx_tskey;
 
@@ -106,6 +107,8 @@ static void *vrtx_task_trampoline(void *
 	if (err)
 		goto fail;
 
+	xeno_set_current();
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */
Index: b/src/skins/vxworks/taskLib.c
===================================================================
--- a/src/skins/vxworks/taskLib.c
+++ b/src/skins/vxworks/taskLib.c
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <vxworks/vxworks.h>
+#include <asm-generic/bits/current.h>
 #include "wrappers.h"
 
 extern pthread_key_t __vxworks_tskey;
@@ -117,6 +118,8 @@ static void *wind_task_trampoline(void *
 	if (err)
 		goto fail;
 
+	xeno_set_current();
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */


