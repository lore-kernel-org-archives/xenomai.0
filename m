From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/2] lockdep: irq_pipeline: fix ambiguous naming
Date: Sun, 13 Jun 2021 17:55:21 +0200
Message-Id: <20210613155522.1851338-1-rpm@xenomai.org>
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

lockdep_save/restore_irqs_state might convey the wrong information:
this is not about saving+disabling then conditionally re-enabling the
tracked state, but merely to read/write such state
unconditionally. Let's change this to non-equivocal names.
---
 include/linux/lockdep.h | 12 +++++-------
 kernel/sched/core.c     |  6 +++---
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index e442c89d8dcd8a4..ac5c21375b732aa 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -578,12 +578,10 @@ do {									\
 		(running_oob() || this_cpu_read(hardirqs_enabled)));	\
 } while (0)
 
-#define lockdep_save_irqs_state(__state)				\
-do {									\
-	(__state) = this_cpu_read(hardirqs_enabled);			\
-} while (0)
+#define lockdep_read_irqs_state()					\
+	({ this_cpu_read(hardirqs_enabled); })
 
-#define lockdep_restore_irqs_state(__state)				\
+#define lockdep_write_irqs_state(__state)				\
 do {									\
 	this_cpu_write(hardirqs_enabled, __state);			\
 } while (0)
@@ -616,8 +614,8 @@ do {									\
 
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
-# define lockdep_save_irqs_state(__state) do { (void)(__state); } while (0)
-# define lockdep_restore_irqs_state(__state) do { (void)(__state); } while (0)
+# define lockdep_read_irqs_state() 0
+# define lockdep_write_irqs_state(__state) do { (void)(__state); } while (0)
 # define lockdep_assert_in_irq() do { } while (0)
 
 # define lockdep_assert_preemption_enabled() do { } while (0)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 250daf5142c1fd5..03c96e146aa3847 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8671,7 +8671,7 @@ bool dovetail_context_switch(struct dovetail_altsched_context *out,
 	 * state maintained by lockdep must be preserved across
 	 * switches.
 	 */
-	lockdep_save_irqs_state(lockdep_irqs);
+	lockdep_irqs = lockdep_read_irqs_state();
 
 	switch_to(prev, next, last);
 	barrier();
@@ -8696,7 +8696,7 @@ bool dovetail_context_switch(struct dovetail_altsched_context *out,
 		else
 			preempt_count_sub(STAGE_OFFSET);
 
-		lockdep_restore_irqs_state(lockdep_irqs);
+		lockdep_write_irqs_state(lockdep_irqs);
 
 		/*
 		 * Fixup the interrupt state conversely to what
@@ -8710,7 +8710,7 @@ bool dovetail_context_switch(struct dovetail_altsched_context *out,
 		if (IS_ENABLED(CONFIG_HAVE_PERCPU_PREEMPT_COUNT))
 			preempt_count_set(pc);
 
-		lockdep_restore_irqs_state(lockdep_irqs);
+		lockdep_write_irqs_state(lockdep_irqs);
 	}
 
 	arch_dovetail_switch_finish(leave_inband);
-- 
2.31.1


