From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/4] dovetail: core: remove misleading arg to
 dovetail_call_mayday()
Date: Wed,  4 Aug 2021 19:47:08 +0200
Message-Id: <20210804174711.4021807-1-rpm@xenomai.org>
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

A task always calls the mayday handler for itself by definition
(although such call may be scheduled by any task).

Passing the thread information pointer to dovetail_call_mayday() is
misleading, we don't get to choose which task the mayday event is
applicable to when running the handler, it has to be 'current'.

Enforce this invariant by using current_thread_info() unconditionally
in dovetail_call_mayday(), removing the corresponding argument.

Bonus: incidentally, this change also fixes an issue in the ARM entry
code which was wrongly calling dovetail_call_mayday() without passing
the thread_info argument (r0 <- @regs).

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/linux/dovetail.h | 3 +--
 kernel/dovetail.c        | 5 +++--
 kernel/irq/pipeline.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index c73ac644e1c5abd..2eed477881202fc 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -195,8 +195,7 @@ struct oob_mm_state *dovetail_mm_state(void)
 	return &current->mm->oob_state;
 }
 
-void dovetail_call_mayday(struct thread_info *ti,
-			  struct pt_regs *regs);
+void dovetail_call_mayday(struct pt_regs *regs);
 
 static inline void dovetail_send_mayday(struct task_struct *castaway)
 {
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 013d6ed160d97f5..13c140160830d03 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -86,8 +86,9 @@ void call_mayday(struct thread_info *ti, struct pt_regs *regs)
 	handle_oob_mayday(regs);
 }
 
-void dovetail_call_mayday(struct thread_info *ti, struct pt_regs *regs)
+void dovetail_call_mayday(struct pt_regs *regs)
 {
+	struct thread_info *ti = current_thread_info();
 	unsigned long flags;
 
 	flags = hard_local_irq_save();
@@ -207,7 +208,7 @@ int pipeline_syscall(unsigned int nr, struct pt_regs *regs)
 		local_flags = READ_ONCE(ti_local_flags(ti));
 		if (local_flags & _TLF_OOB) {
 			if (test_ti_thread_flag(ti, TIF_MAYDAY))
-				dovetail_call_mayday(ti, regs);
+				dovetail_call_mayday(regs);
 			return 1; /* don't pass down, no tail work. */
 		} else {
 			WARN_ON_ONCE(dovetail_debug() && irqs_disabled());
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index abc9f51c6042477..eefddd7730f8167 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1163,7 +1163,7 @@ int handle_irq_pipelined_finish(struct irq_stage_data *prevd,
 	 * then maybe clear over test_and_clear.
 	 */
 	if (user_mode(regs) && test_thread_flag(TIF_MAYDAY))
-		dovetail_call_mayday(current_thread_info(), regs);
+		dovetail_call_mayday(regs);
 #endif
 
 	return running_inband() && !irqs_disabled();
-- 
2.31.1


