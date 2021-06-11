From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 07/17] cobalt/sched: dovetail: prevent early scheduling on
 uninit runqueues
Date: Fri, 11 Jun 2021 20:05:33 +0200
Message-Id: <4c39001ae01a0c0bab510322e698c3cbbca24629.1623434743.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623434743.git.jan.kiszka@siemens.com>
References: <cover.1623434743.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

Make sure not to raise XNSCHED when setting up the root thread, so
that we can't start rescheduling from irq_exit_pipeline() before all
CPUs have their runqueue fully built.

At this chance, add the missing tracepoint reporting a remote
scheduling request.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/sched.c |  1 +
 kernel/cobalt/sched.c          | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
index 074bc006e..01ea4422d 100644
--- a/kernel/cobalt/dovetail/sched.c
+++ b/kernel/cobalt/dovetail/sched.c
@@ -91,6 +91,7 @@ void pipeline_clear_mayday(void) /* May solely affect current. */
 
 irqreturn_t pipeline_reschedule_ipi_handler(int irq, void *dev_id)
 {
+	trace_cobalt_schedule_remote(xnsched_current());
 
 	/* Will reschedule from irq_exit_pipeline(). */
 
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 7873fd652..222d0dd40 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -465,7 +465,15 @@ int xnsched_set_policy(struct xnthread *thread,
 	if (xnthread_test_state(thread, XNREADY))
 		xnsched_enqueue(thread);
 
-	if (!xnthread_test_state(thread, XNDORMANT))
+	/*
+	 * Make sure not to raise XNSCHED when setting up the root
+	 * thread, so that we can't start rescheduling on interrupt
+	 * exit before all CPUs have their runqueue fully
+	 * built. Filtering on XNROOT here is correct because the root
+	 * thread enters the idle class once as part of the runqueue
+	 * setup process and never leaves it afterwards.
+	 */
+	if (!xnthread_test_state(thread, XNDORMANT|XNROOT))
 		xnsched_set_resched(thread->sched);
 
 	return 0;
-- 
2.26.2


