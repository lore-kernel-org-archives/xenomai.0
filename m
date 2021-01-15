From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 5/8] dovetail/kevents: dovetail: implement handle_ptrace_cont
Date: Thu, 14 Jan 2021 20:16:35 -0500
Message-Id: <20210115011639.15390-5-hongzhan.chen@intel.com>
In-Reply-To: <20210115011639.15390-1-hongzhan.chen@intel.com>
References: <20210115011639.15390-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index b5dc50ea7..378017bea 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -473,7 +473,7 @@ int handle_ptrace_resume(struct task_struct *tracee)
 	return KEVENT_PROPAGATE;
 }
 
-static void handle_ptrace_cont(void)
+static void handle_ptrace_cont(struct task_struct *next_task)
 {
 	/*
 	 * This is the place where the ptrace-related work which used
@@ -482,7 +482,77 @@ static void handle_ptrace_cont(void)
 	 * stopped state, which is what look for in
 	 * handle_schedule_event().
 	 */
-	TODO();
+	struct task_struct *prev_task;
+	struct xnthread *next;
+	sigset_t pending;
+	spl_t s;
+
+	cobalt_signal_yield();
+
+	prev_task = current;
+	next = xnthread_from_task(next_task);
+	if (next == NULL)
+		return;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	/*
+	 * Track tasks leaving the ptraced state.  Check both SIGSTOP
+	 * (NPTL) and SIGINT (LinuxThreads) to detect ptrace
+	 * continuation.
+	 */
+	if (xnthread_test_state(next, XNSSTEP)) {
+		if (signal_pending(next_task)) {
+			/*
+			 * Do not grab the sighand lock here: it's
+			 * useless, and we already own the runqueue
+			 * lock, so this would expose us to deadlock
+			 * situations on SMP.
+			 */
+			sigorsets(&pending,
+				  &next_task->pending.signal,
+				  &next_task->signal->shared_pending.signal);
+			if (sigismember(&pending, SIGSTOP) ||
+			    sigismember(&pending, SIGINT))
+				goto no_ptrace;
+		}
+
+		/*
+		 * Do not unregister before the thread migrated.
+		 * unregister_debugged_thread will then be called by our
+		 * resume_oob_task.
+		 */
+		if (!xnthread_test_info(next, XNCONTHI))
+			unregister_debugged_thread(next);
+
+		xnthread_set_localinfo(next, XNHICCUP);
+	}
+
+no_ptrace:
+	xnlock_put_irqrestore(&nklock, s);
+
+	/*
+	 * Do basic sanity checks on the incoming thread state.
+	 * NOTE: we allow ptraced threads to run shortly in order to
+	 * properly recover from a stopped state.
+	 */
+	if (!XENO_WARN(COBALT, !xnthread_test_state(next, XNRELAX),
+		       "hardened thread %s[%d] running in Linux domain?! "
+		       "(status=0x%x, sig=%d, prev=%s[%d])",
+		       next->name, task_pid_nr(next_task),
+		       xnthread_get_state(next),
+		       signal_pending(next_task),
+		       prev_task->comm, task_pid_nr(prev_task)))
+		XENO_WARN(COBALT,
+			  !(next_task->ptrace & PT_PTRACED) &&
+			   !xnthread_test_state(next, XNDORMANT)
+			  && xnthread_test_state(next, XNPEND),
+			  "blocked thread %s[%d] rescheduled?! "
+			  "(status=0x%x, sig=%d, prev=%s[%d])",
+			  next->name, task_pid_nr(next_task),
+			  xnthread_get_state(next),
+			  signal_pending(next_task), prev_task->comm,
+			  task_pid_nr(prev_task));
 }
 
 void handle_inband_event(enum inband_event_type event, void *data)
@@ -505,7 +575,7 @@ void handle_inband_event(enum inband_event_type event, void *data)
 		handle_ptrace_resume(data);
 		break;
 	case INBAND_TASK_PTCONT:
-		handle_ptrace_cont();
+		handle_ptrace_cont(data);
 		break;
 	case INBAND_TASK_PTSTOP:
 		break;
-- 
2.17.1


