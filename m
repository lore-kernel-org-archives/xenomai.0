From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/4] sched: dovetail: pass thread-info bits to
 arch_dovetail_switch_finish()
Date: Sat,  2 Apr 2022 16:21:24 +0200
Message-Id: <20220402142127.944138-1-rpm@xenomai.org>
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

The out-of-band switch tail code may need the thread-info work bits to
reinstate the current context appropriately, pass them to
arch_dovetail_switch_finish().

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/sched/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a1159a263894..75b506bb60bb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10902,6 +10902,7 @@ int dovetail_leave_inband(void)
 {
 	struct task_struct *p = current;
 	struct irq_pipeline_data *pd;
+	unsigned int ti_work;
 	unsigned long flags;
 
 	preempt_disable();
@@ -10930,7 +10931,8 @@ int dovetail_leave_inband(void)
 	 * architecture-specific fixups (e.g. fpu context reload).
 	 */
 	if (likely(__schedule(SM_NONE))) {
-		arch_dovetail_switch_finish(false);
+		ti_work = READ_ONCE(current_thread_info()->flags);
+		arch_dovetail_switch_finish(false, ti_work);
 		return 0;
 	}
 
@@ -10987,6 +10989,7 @@ bool dovetail_context_switch(struct dovetail_altsched_context *out,
 	struct task_struct *next, *prev, *last;
 	struct mm_struct *prev_mm, *next_mm;
 	bool inband_tail = false;
+	unsigned long ti_work;
 
 	WARN_ON_ONCE(dovetail_debug() && on_pipeline_entry());
 
@@ -11108,7 +11111,8 @@ bool dovetail_context_switch(struct dovetail_altsched_context *out,
 		lockdep_write_irqs_state(lockdep_irqs);
 	}
 
-	arch_dovetail_switch_finish(leave_inband);
+	ti_work = READ_ONCE(current_thread_info()->flags);
+	arch_dovetail_switch_finish(leave_inband, ti_work);
 
 	/*
 	 * inband_tail is true whenever we are finalizing a transition
-- 
2.34.1


