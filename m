From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt: Fix handling of invalid thread affinities during
 hardening
Message-ID: <54f4af80-dbe6-6ff8-84d8-a184b5221c81@siemens.com>
Date: Mon, 5 Jul 2021 12:31:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

The I-pipe implementation was lucky in its approach to not wake up the
RT thread in case the non-RT part migrated to an unsupported CPU. For
unclear reasons, the scheduled cancellation made it to the thread and
avoided any lockup. On dovetail, this fails.

So switch both implemenations to the safer pattern of actually
completing the migration, using the previous affinity of the thread. It
will still be canceled right after that, now also over dovetail.

As cobalt_affinity_ok's return value becomes irrelevant, refactor this
function to cobalt_adjust_affinity without and return code.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/kevents.c | 6 ++++--
 kernel/cobalt/ipipe/kevents.c    | 6 ++++--
 kernel/cobalt/posix/process.c    | 8 +++-----
 kernel/cobalt/posix/process.h    | 4 ++--
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 3fbb5e6d64..648929756c 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -307,8 +307,10 @@ void resume_oob_task(struct task_struct *p) /* inband, oob stage stalled */
 	 * relax_thread/harden_thread handlers.
 	 */
 	xnthread_run_handler_stack(thread, harden_thread);
-	if (cobalt_affinity_ok(p))
-		xnthread_resume(thread, XNRELAX);
+
+	cobalt_adjust_affinity(p);
+
+	xnthread_resume(thread, XNRELAX);
 
 	/*
 	 * In case we migrated independently of the user return notifier, clear
diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
index 40ad93f398..9bb0204d9f 100644
--- a/kernel/cobalt/ipipe/kevents.c
+++ b/kernel/cobalt/ipipe/kevents.c
@@ -171,8 +171,10 @@ void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 	 * relax_thread/harden_thread handlers.
 	 */
 	xnthread_run_handler_stack(thread, harden_thread);
-	if (cobalt_affinity_ok(p))
-		xnthread_resume(thread, XNRELAX);
+
+	cobalt_adjust_affinity(p);
+
+	xnthread_resume(thread, XNRELAX);
 
 	/*
 	 * In case we migrated independently of the user return notifier, clear
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index aa384155a1..1f059ad830 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -773,7 +773,7 @@ int cobalt_handle_setaffinity_event(struct task_struct *task)
 }
 
 #ifdef CONFIG_SMP
-bool cobalt_affinity_ok(struct task_struct *task) /* nklocked, IRQs off */
+void cobalt_adjust_affinity(struct task_struct *task) /* nklocked, IRQs off */
 {
 	struct xnthread *thread = xnthread_from_task(task);
 	struct xnsched *sched;
@@ -812,12 +812,12 @@ bool cobalt_affinity_ok(struct task_struct *task) /* nklocked, IRQs off */
 		 * in xnthread_harden().
 		 */
 		xnthread_set_info(thread, XNCANCELD);
-		return false;
+		return;
 	}
 
 	sched = xnsched_struct(cpu);
 	if (sched == thread->sched)
-		return true;
+		return;
 
 	/*
 	 * The current thread moved to a supported real-time CPU,
@@ -829,8 +829,6 @@ bool cobalt_affinity_ok(struct task_struct *task) /* nklocked, IRQs off */
 
 	xnthread_run_handler_stack(thread, move_thread, cpu);
 	xnthread_migrate_passive(thread, sched);
-
-	return true;
 }
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
index 45964ae57a..4661868310 100644
--- a/kernel/cobalt/posix/process.h
+++ b/kernel/cobalt/posix/process.h
@@ -164,9 +164,9 @@ extern struct xnthread_personality cobalt_personality;
 int cobalt_handle_setaffinity_event(struct task_struct *task);
 
 #ifdef CONFIG_SMP
-bool cobalt_affinity_ok(struct task_struct *task);
+void cobalt_adjust_affinity(struct task_struct *task);
 #else
-#define cobalt_affinity_ok(task)	(true)
+static inline void cobalt_affinity_ok(struct task_struct *task) { }
 #endif
 
 int cobalt_handle_taskexit_event(struct task_struct *task);
-- 
2.26.2

