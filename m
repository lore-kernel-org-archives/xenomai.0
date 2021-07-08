From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 2/3] cobalt: Add ptrace debugging helper interface
Date: Thu,  8 Jul 2021 22:47:44 +0200
Message-Id: <8b6c2eae39a860c84a3e3f01d7e14217bf9b55b2.1625777265.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625777265.git.jan.kiszka@siemens.com>
References: <cover.1625777265.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This introduces the concept of a debugging helper thread. It can
register itself with the cobalt core and then wait for ptrace stop and
resumption events. This can be used to bring the connected devices or
other parts of the system into a state that can tolerate the potentially
long interruption and also synchronize again with it to continue.

On stop events (breakpoints, debugger interceptions), the core will
ensure that the helper is run after all primary-mode threads were put on
hold and before the debugger will gain control over the whole process.
For that purpose, the helper will receive a notification when it was
pending on the corresponding event-wait syscall and will release the
process into debugging by invoking that syscall to wait for the
resumption event.

When the debugger resumes the whole process, the helper is resumed
first, right before all threads that will continue in primary mode are
released (threads in secondary mode may run earlier but will have to
wait when trying to enter primary mode). Again, the helper thread
decides when to continue by calling the event-wait system again, in
that case in order to wait for the next stop event.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/Makefile.am      |  1 +
 include/cobalt/ptrace.h         | 37 ++++++++++++++
 include/cobalt/uapi/Makefile.am |  1 +
 include/cobalt/uapi/ptrace.h    | 24 +++++++++
 include/cobalt/uapi/syscall.h   |  3 ++
 kernel/cobalt/posix/process.c   | 34 +++++++++++-
 kernel/cobalt/posix/process.h   |  5 ++
 kernel/cobalt/posix/syscall.c   | 86 +++++++++++++++++++++++++++++++
 lib/cobalt/Makefile.am          |  1 +
 lib/cobalt/ptrace.c             | 91 +++++++++++++++++++++++++++++++++
 10 files changed, 281 insertions(+), 2 deletions(-)
 create mode 100644 include/cobalt/ptrace.h
 create mode 100644 include/cobalt/uapi/ptrace.h
 create mode 100644 lib/cobalt/ptrace.c

diff --git a/include/cobalt/Makefile.am b/include/cobalt/Makefile.am
index 19e96112e8..e0b203193d 100644
--- a/include/cobalt/Makefile.am
+++ b/include/cobalt/Makefile.am
@@ -4,6 +4,7 @@ includesub_HEADERS =	\
 	fcntl.h		\
 	mqueue.h	\
 	pthread.h	\
+	ptrace.h	\
 	sched.h		\
 	semaphore.h	\
 	signal.h	\
diff --git a/include/cobalt/ptrace.h b/include/cobalt/ptrace.h
new file mode 100644
index 0000000000..f5bec56c9d
--- /dev/null
+++ b/include/cobalt/ptrace.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) Siemens AG, 2015-2021
+ *
+ * Authors:
+ *  Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.
+ */
+#ifndef _COBALT_PTRACE_H
+#define _COBALT_PTRACE_H
+
+#include <cobalt/uapi/ptrace.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+int cobalt_ptrace_helper_init(void);
+int cobalt_ptrace_event_wait(int event);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* !_COBALT_PTRACE_H */
diff --git a/include/cobalt/uapi/Makefile.am b/include/cobalt/uapi/Makefile.am
index d887213f8e..41076e23d9 100644
--- a/include/cobalt/uapi/Makefile.am
+++ b/include/cobalt/uapi/Makefile.am
@@ -6,6 +6,7 @@ includesub_HEADERS =	\
 	event.h		\
 	monitor.h	\
 	mutex.h		\
+	ptrace.h	\
 	sched.h		\
 	sem.h		\
 	signal.h	\
diff --git a/include/cobalt/uapi/ptrace.h b/include/cobalt/uapi/ptrace.h
new file mode 100644
index 0000000000..4e61d458c1
--- /dev/null
+++ b/include/cobalt/uapi/ptrace.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) Siemens AG, 2015-2021
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+#ifndef _COBALT_UAPI_PTRACE_H
+#define _COBALT_UAPI_PTRACE_H
+
+#define COBALT_PTRACE_EVENT_STOP	0x1
+#define COBALT_PTRACE_EVENT_RESUME	0x2
+
+#endif /* !_COBALT_UAPI_PTRACE_H */
diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index a2795a3644..8d10992284 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -128,6 +128,9 @@
 #define sc_cobalt_clock_nanosleep64		105
 #define sc_cobalt_clock_getres64		106
 #define sc_cobalt_clock_adjtime64		107
+/* 108-118 reserved for 64-bit time_t syscalls */
+#define sc_cobalt_ptrace_helper_init		119
+#define sc_cobalt_ptrace_event_wait		120
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 98b7df33fb..ad7def2f27 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -45,6 +45,7 @@
 #include <cobalt/kernel/ppd.h>
 #include <cobalt/kernel/vdso.h>
 #include <cobalt/kernel/thread.h>
+#include <cobalt/uapi/ptrace.h>
 #include <cobalt/uapi/signal.h>
 #include <cobalt/uapi/syscall.h>
 #include <pipeline/sched.h>
@@ -683,16 +684,25 @@ void cobalt_stop_debugged_process(struct xnthread *thread)
 	struct cobalt_process *process = process_from_thread(thread);
 	struct cobalt_thread *cth;
 
-	if (process->debugged_threads > 0)
+	if (process->stopped_for_ptrace)
 		return;
 
+	process->stopped_for_ptrace = true;
+
 	list_for_each_entry(cth, &process->thread_list, next) {
-		if (&cth->threadbase == thread)
+		if (&cth->threadbase == thread ||
+		    &cth->threadbase == process->ptrace_helper)
 			continue;
 
 		xnthread_suspend(&cth->threadbase, XNDBGSTOP, XN_INFINITE,
 				 XN_RELATIVE, NULL);
 	}
+
+	if (process->ptrace_helper) {
+		process->pending_ptrace_events |= COBALT_PTRACE_EVENT_STOP;
+		if (xnsynch_wakeup_one_sleeper(&process->ptrace_stop_event))
+			xnsched_run();
+	}
 }
 
 static void cobalt_resume_debugged_process(struct cobalt_process *process)
@@ -705,6 +715,8 @@ static void cobalt_resume_debugged_process(struct cobalt_process *process)
 		if (xnthread_test_state(&cth->threadbase, XNDBGSTOP))
 			xnthread_resume(&cth->threadbase, XNDBGSTOP);
 
+	process->stopped_for_ptrace = false;
+
 	xnsched_unlock();
 }
 
@@ -728,6 +740,17 @@ void cobalt_unregister_debugged_thread(struct xnthread *thread)
 {
 	struct cobalt_process *process = process_from_thread(thread);
 
+	if (process->ptrace_helper && process->debugged_threads == 1 &&
+	    !(process->pending_ptrace_events & COBALT_PTRACE_EVENT_RESUME)) {
+		process->pending_ptrace_events |= COBALT_PTRACE_EVENT_RESUME;
+		if (process->ptrace_helper != thread) {
+			xnthread_clear_state(thread, XNSSTEP);
+			xnthread_set_state(process->ptrace_helper, XNSSTEP);
+		}
+		xnthread_resume(process->ptrace_helper, XNDBGSTOP);
+		return;
+	}
+
 	process->debugged_threads--;
 	xnthread_clear_state(thread, XNSSTEP);
 
@@ -834,6 +857,7 @@ void cobalt_adjust_affinity(struct task_struct *task) /* nklocked, IRQs off */
 
 static void __handle_taskexit_event(struct task_struct *p)
 {
+	struct cobalt_process *process = cobalt_current_process();
 	struct cobalt_ppd *sys_ppd;
 	struct xnthread *thread;
 	spl_t s;
@@ -850,6 +874,11 @@ static void __handle_taskexit_event(struct task_struct *p)
 
 	xnlock_get_irqsave(&nklock, s);
 
+	if (process && process->ptrace_helper == thread) {
+		process->ptrace_helper = NULL;
+		process->pending_ptrace_events = 0;
+	}
+
 	if (xnthread_test_state(thread, XNSSTEP))
 		cobalt_unregister_debugged_thread(thread);
 
@@ -1057,6 +1086,7 @@ static void *cobalt_process_attach(void)
 	INIT_LIST_HEAD(&process->thread_list);
 	xntree_init(&process->usems);
 	bitmap_fill(process->timers_map, CONFIG_XENO_OPT_NRTIMERS);
+	xnsynch_init(&process->ptrace_stop_event, XNSYNCH_FIFO, NULL);
 	cobalt_set_process(process);
 
 	return process;
diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
index 46dff43b7a..c9bccdb361 100644
--- a/kernel/cobalt/posix/process.h
+++ b/kernel/cobalt/posix/process.h
@@ -22,6 +22,7 @@
 #include <linux/bitmap.h>
 #include <pipeline/thread.h>
 #include <cobalt/kernel/ppd.h>
+#include <cobalt/kernel/synch.h>
 
 #define NR_PERSONALITIES  4
 #if BITS_PER_LONG < NR_PERSONALITIES
@@ -55,6 +56,10 @@ struct cobalt_process {
 	void *priv[NR_PERSONALITIES];
 	int ufeatures;
 	unsigned int debugged_threads;
+	struct xnthread *ptrace_helper;
+	struct xnsynch ptrace_stop_event;
+	unsigned int pending_ptrace_events;
+	bool stopped_for_ptrace;
 };
 
 struct cobalt_resnode {
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index d46ff103de..ed1c215980 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -22,6 +22,7 @@
 #include <linux/kconfig.h>
 #include <linux/unistd.h>
 #include <cobalt/uapi/corectl.h>
+#include <cobalt/uapi/ptrace.h>
 #include <cobalt/kernel/tree.h>
 #include <cobalt/kernel/vdso.h>
 #include <cobalt/kernel/init.h>
@@ -287,6 +288,91 @@ static COBALT_SYSCALL(serialdbg, current,
 	return 0;
 }
 
+static COBALT_SYSCALL(ptrace_helper_init, current, (void))
+{
+	struct cobalt_process *process = cobalt_current_process();
+	struct xnthread *curr = xnthread_current();
+	int err = 0;
+	spl_t s;
+
+	if (curr == NULL || process == NULL)
+		return -EPERM;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (!process->ptrace_helper)
+		process->ptrace_helper = curr;
+	else
+		err = -EBUSY;
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+
+static COBALT_SYSCALL(ptrace_event_wait, primary, (int event))
+{
+	struct cobalt_process *process = cobalt_current_process();
+	struct xnthread *curr = xnthread_current();
+	int ret = 0;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (curr == NULL || process == NULL || process->ptrace_helper != curr) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	if (event == COBALT_PTRACE_EVENT_STOP) {
+		xnthread_set_state(curr, XNDBGCTRL);
+
+		if (process->debugged_threads == 1)
+			cobalt_unregister_debugged_thread(curr);
+
+		if (process->pending_ptrace_events & COBALT_PTRACE_EVENT_STOP) {
+			process->pending_ptrace_events = 0;
+			goto out;
+		}
+
+		/* Now wait for the next debugging round. */
+		if (xnsynch_sleep_on(&process->ptrace_stop_event, XN_INFINITE,
+				     XN_RELATIVE) & XNBREAK)
+			ret = -ERESTARTSYS;
+		else
+			process->pending_ptrace_events = 0;
+	} else if (event == COBALT_PTRACE_EVENT_RESUME) {
+		xnthread_clear_state(curr, XNDBGCTRL);
+
+		if (process->pending_ptrace_events & COBALT_PTRACE_EVENT_RESUME)
+			goto out;
+
+		/*
+		 * Now wait for the end of the debugging round. If there is
+		 * already SIGSTOP pending, interrupt the suspension and relax
+		 * the helper thread on return from the syscall. The syscall
+		 * will be restarted when the thread resumes, then with
+		 * COBALT_PTRACE_EVENT_RESUME pending so that we will not block
+		 * again.
+		 */
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+		} else {
+			xnthread_suspend(curr, XNDBGSTOP, XN_INFINITE, XN_RELATIVE,
+					NULL);
+			if (xnthread_test_info(curr, XNBREAK))
+				ret = -ERESTARTSYS;
+		}
+	} else {
+		ret = -EINVAL;
+	}
+
+out:
+	xnlock_put_irqrestore(&nklock, s);
+
+	return ret;
+}
+
 static void stringify_feature_set(unsigned long fset, char *buf, int size)
 {
 	unsigned long feature;
diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index b3003cd957..3f9136e84c 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -24,6 +24,7 @@ libcobalt_la_SOURCES =		\
 	mutex.c			\
 	parse_vdso.c		\
 	printf.c		\
+	ptrace.c		\
 	rtdm.c			\
 	sched.c			\
 	select.c		\
diff --git a/lib/cobalt/ptrace.c b/lib/cobalt/ptrace.c
new file mode 100644
index 0000000000..f0c305b7b0
--- /dev/null
+++ b/lib/cobalt/ptrace.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright (C) Siemens AG, 2015-2021
+ *
+ * Authors:
+ *  Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.
+ */
+#include <pthread.h>
+#include <cobalt/ptrace.h>
+#include <asm/xenomai/syscall.h>
+
+/**
+ * @ingroup cobalt_api
+ * @defgroup cobalt_ptrace Debugging extension
+ *
+ * Cobalt process debugging extensions
+ *
+ *@{
+ */
+
+/**
+ * Register thread as ptrace helper
+ *
+ * Register the calling thread as ptrace debugging helper. Only one thread in
+ * a process can take over this role which will be in effect until the thread
+ * terminates.
+ *
+ * @retval 0 on success;
+ * @retval -1 with @a errno set if:
+ * - EBUSY, another thread is already registered.
+ * - EPERM, caller is not a Cobalt thread.
+ */
+int cobalt_ptrace_helper_init(void)
+{
+	int ret;
+
+	ret = XENOMAI_SYSCALL0(sc_cobalt_ptrace_helper_init);
+	if (ret < 0) {
+		errno = -ret;
+		return -1;
+	}
+
+	return ret;
+}
+
+/**
+ * Wait on the next ptrace helper event
+ *
+ * Block the caller until the next ptrace even for the helper arrives. The
+ * caller must have been registered as ptrace helper before.
+ *
+ * @param event type of event to wait for, either @a COBALT_PTRACE_EVENT_STOP
+ * or @a COBALT_PTRACE_EVENT_RESUME
+ *
+ * @retval 0 on success;
+ * @retval -1 with @a errno set if:
+ * - EINVAL, invalid @a event.
+ * - EPERM, caller is not a Cobalt thread.
+ */
+int cobalt_ptrace_event_wait(int event)
+{
+	int ret, oldtype;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+	ret = XENOMAI_SYSCALL1(sc_cobalt_ptrace_event_wait, event);
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	if (ret < 0) {
+		errno = -ret;
+		return -1;
+	}
+
+	return ret;
+}
+
+/** @} */
-- 
2.26.2


