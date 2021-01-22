From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH V2 3/5] dovetail/kevents: dovetail: implement
 handle_ptrace_cont
Date: Thu, 21 Jan 2021 21:12:38 -0500
Message-Id: <20210122021240.18768-3-hongzhan.chen@intel.com>
In-Reply-To: <20210122021240.18768-1-hongzhan.chen@intel.com>
References: <20210122021240.18768-1-hongzhan.chen@intel.com>
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
index 6aec170d1..0528e2938 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -480,7 +480,75 @@ static void handle_ptrace_cont(void)
 	 * stopped state, which is what look for in
 	 * handle_schedule_event().
 	 */
-	TODO();
+	struct task_struct *next_task;
+	struct xnthread *next;
+	sigset_t pending;
+	spl_t s;
+
+	cobalt_signal_yield();
+
+	next_task = current;
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
+		       "(status=0x%x, sig=%d)",
+		       next->name, task_pid_nr(next_task),
+		       xnthread_get_state(next),
+		       signal_pending(next_task)))
+		XENO_WARN(COBALT,
+			  !(next_task->ptrace & PT_PTRACED) &&
+			   !xnthread_test_state(next, XNDORMANT)
+			  && xnthread_test_state(next, XNPEND),
+			  "blocked thread %s[%d] rescheduled?! "
+			  "(status=0x%x, sig=%d)",
+			  next->name, task_pid_nr(next_task),
+			  xnthread_get_state(next),
+			  signal_pending(next_task));
 }
 
 void handle_inband_event(enum inband_event_type event, void *data)
-- 
2.17.1


