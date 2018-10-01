From: Philippe Gerum <rpm@xenomai.org>
Date: Mon,  1 Oct 2018 15:56:15 +0200
Message-Id: <20181001135619.24883-3-rpm@xenomai.org>
In-Reply-To: <20181001135619.24883-1-rpm@xenomai.org>
References: <20181001135619.24883-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 2/6] cobalt/thread: handle case of invalid domain
 migration over non-rt CPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Attempting to migrate to the head domain while running on a CPU which
is not in part of the real-time set is a bug, and must be detected by
the core.

Furthermore, for this detection to work, the I-pipe must not BUG()
unconditionally when failing to schedule out such thread in
__ipipe_migrate_head(), but rather let the real-time core handle the
situation (i.e. Xenomai in xnthread_harden()).

Until both changes are in place, running a thread issuing a real-time
call over a non-RT CPU would trigger a BUG() assertion, e.g.:

With kernel parameter "xenomai.supported_cpus=2", running:

$ switchtest --cpu-affinity=0

would lead to:

[   11.681486] kernel BUG at kernel/sched/core.c:5816!
[   11.686343] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
---
 kernel/cobalt/posix/process.c | 19 ++++++++++++-------
 kernel/cobalt/thread.c        |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 9a2bf83c2..a708833ef 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -856,7 +856,7 @@ static int handle_setaffinity_event(struct ipipe_cpu_migration_data *d)
 	 * take place on behalf of the target thread itself while
 	 * running in secondary mode. Therefore, that thread needs to
 	 * go through secondary mode first, then move back to primary
-	 * mode, so that check_affinity() does the fixup work.
+	 * mode, so that affinity_ok() does the fixup work.
 	 *
 	 * We force this by sending a SIGSHADOW signal to the migrated
 	 * thread, asking it to switch back to primary mode from the
@@ -873,7 +873,7 @@ static int handle_setaffinity_event(struct ipipe_cpu_migration_data *d)
 	return KEVENT_PROPAGATE;
 }
 
-static inline void check_affinity(struct task_struct *p) /* nklocked, IRQs off */
+static inline bool affinity_ok(struct task_struct *p) /* nklocked, IRQs off */
 {
 	struct xnthread *thread = xnthread_from_task(p);
 	struct xnsched *sched;
@@ -912,12 +912,12 @@ static inline void check_affinity(struct task_struct *p) /* nklocked, IRQs off *
 		 * in xnthread_harden().
 		 */
 		xnthread_set_info(thread, XNCANCELD);
-		return;
+		return false;
 	}
 
 	sched = xnsched_struct(cpu);
 	if (sched == thread->sched)
-		return;
+		return true;
 
 	/*
 	 * The current thread moved to a supported real-time CPU,
@@ -929,6 +929,8 @@ static inline void check_affinity(struct task_struct *p) /* nklocked, IRQs off *
 
 	xnthread_run_handler_stack(thread, move_thread, cpu);
 	xnthread_migrate_passive(thread, sched);
+
+	return true;
 }
 
 #else /* !CONFIG_SMP */
@@ -940,7 +942,10 @@ static int handle_setaffinity_event(struct ipipe_cpu_migration_data *d)
 	return KEVENT_PROPAGATE;
 }
 
-static inline void check_affinity(struct task_struct *p) { }
+static inline bool affinity_ok(struct task_struct *p)
+{
+	return true;
+}
 
 #endif /* CONFIG_SMP */
 
@@ -955,8 +960,8 @@ void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 	 */
 	xnlock_get(&nklock);
 	xnthread_run_handler_stack(thread, harden_thread);
-	check_affinity(p);
-	xnthread_resume(thread, XNRELAX);
+	if (affinity_ok(p))
+		xnthread_resume(thread, XNRELAX);
 	xnlock_put(&nklock);
 
 	xnsched_run();
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 2ffe1f8f0..04c0b62d3 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1945,6 +1945,7 @@ int xnthread_harden(void)
 
 	ret = __ipipe_migrate_head();
 	if (ret) {
+		xnthread_test_cancel();
 		xnthread_set_sync_window(thread, XNRELAX);
 		return ret;
 	}
-- 
2.14.4


