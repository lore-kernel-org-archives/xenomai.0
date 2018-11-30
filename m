From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH 1/7] cobalt/kernel: Rework
 register/unregister_debugged_thread
Date: Fri, 30 Nov 2018 21:03:15 +0100
Message-Id: <6248a4a8a4a6b3fec65e8fdcda94e16a227c30e0.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
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

Given that registration can run asynchronously to deregistration, better
put testing for XNSSTEP and the latter under nklock. This is likely
overkill for task termination but it's more consistent.

While at it, move up the functions and add a cobalt_ prefix. We will
need them earlier in the file and are going to export one of them for
use in other code modules.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/process.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 10a9fb5678..f4ebf194f6 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -720,6 +720,18 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
 	return 0;
 }
 
+/* called with nklock held */
+static void cobalt_register_debugged_thread(struct xnthread *thread)
+{
+	xnthread_set_state(thread, XNSSTEP);
+}
+
+/* called with nklock held */
+static void cobalt_unregister_debugged_thread(struct xnthread *thread)
+{
+	xnthread_clear_state(thread, XNSSTEP);
+}
+
 static inline int handle_exception(struct ipipe_trap_data *d)
 {
 	struct xnthread *thread;
@@ -1016,6 +1028,7 @@ static void __handle_taskexit_event(struct task_struct *p)
 {
 	struct cobalt_ppd *sys_ppd;
 	struct xnthread *thread;
+	spl_t s;
 
 	/*
 	 * We are called for both kernel and user shadows over the
@@ -1027,6 +1040,13 @@ static void __handle_taskexit_event(struct task_struct *p)
 	XENO_BUG_ON(COBALT, thread == NULL);
 	trace_cobalt_shadow_unmap(thread);
 
+	xnlock_get_irqsave(&nklock, s);
+
+	if (xnthread_test_state(thread, XNSSTEP))
+		cobalt_unregister_debugged_thread(thread);
+
+	xnlock_put_irqrestore(&nklock, s);
+
 	xnthread_run_handler_stack(thread, exit_thread);
 	xnsched_run();
 
@@ -1084,6 +1104,8 @@ static int handle_schedule_event(struct task_struct *next_task)
 	if (next == NULL)
 		goto out;
 
+	xnlock_get_irqsave(&nklock, s);
+
 	/*
 	 * Track tasks leaving the ptraced state.  Check both SIGSTOP
 	 * (NPTL) and SIGINT (LinuxThreads) to detect ptrace
@@ -1102,15 +1124,15 @@ static int handle_schedule_event(struct task_struct *next_task)
 				  &next_task->signal->shared_pending.signal);
 			if (sigismember(&pending, SIGSTOP) ||
 			    sigismember(&pending, SIGINT))
-				goto check;
+				goto no_ptrace;
 		}
-		xnlock_get_irqsave(&nklock, s);
-		xnthread_clear_state(next, XNSSTEP);
-		xnlock_put_irqrestore(&nklock, s);
+		cobalt_unregister_debugged_thread(next);
 		xnthread_set_localinfo(next, XNHICCUP);
 	}
 
-check:
+no_ptrace:
+	xnlock_put_irqrestore(&nklock, s);
+
 	/*
 	 * Do basic sanity checks on the incoming thread state.
 	 * NOTE: we allow ptraced threads to run shortly in order to
@@ -1163,7 +1185,7 @@ static int handle_sigwake_event(struct task_struct *p)
 		if (sigismember(&pending, SIGTRAP) ||
 		    sigismember(&pending, SIGSTOP)
 		    || sigismember(&pending, SIGINT))
-			xnthread_set_state(thread, XNSSTEP);
+			cobalt_register_debugged_thread(thread);
 	}
 
 	if (xnthread_test_state(thread, XNRELAX)) {
-- 
2.16.4


