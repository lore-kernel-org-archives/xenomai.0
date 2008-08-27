Message-ID: <48B566EC.1020804@domain.hid>
Date: Wed, 27 Aug 2008 16:38:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid> <48B55F7C.5030901@domain.hid>
	<48B5615C.6050704@domain.hid>
In-Reply-To: <48B5615C.6050704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 2/3] Switch to handle-based fast
	mutex owners
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> To improve robustness of the fast mutex implementation in POSIX (and
>> later on in native), it is better to track the mutex owner by handle
>> instead of kernel object pointer. Therefore, this patch changes
>> __xn_sys_current (xeno_set_current) so that it returns
>> xnthread_handle(current_thread). It furthermore converts the POSIX mutex
>> implementation to pick up and store the lock owner as handle in the
>> kernel/user-shared mutex. Finally it ensures that at least POSIX threads
>> always have an (anonymous) handle assigned.
>>
>> As the value stored in the mutex variable is now an integer, we can
>> switch over to xnarch_atomic_t, removing all atomic_intptr users.
> 
> Ok. I do not know if this should be part of this patch, or in another
> one, but we should call xeno_set_current in the trampolines of all
> skins, so that they can use the native and posix mutexes.
> 
> This is another thing that I have left in a state of flux...

Find it below (PATCH 4/3).

BTW, should we better invoke pthread_exit in xeno_set_current in case of 
a failure?

Jan

---
 src/skins/native/task.c     |    3 +++
 src/skins/psos+/task.c      |    3 +++
 src/skins/uitron/task.c     |    3 +++
 src/skins/vrtx/task.c       |    3 +++
 src/skins/vxworks/taskLib.c |    3 +++
 5 files changed, 15 insertions(+)

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

