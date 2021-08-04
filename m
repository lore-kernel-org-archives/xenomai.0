From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/4] genirq: irq_pipeline: switch RCU to NMI state on pipeline
 entry
Date: Wed,  4 Aug 2021 19:47:09 +0200
Message-Id: <20210804174711.4021807-2-rpm@xenomai.org>
In-Reply-To: <20210804174711.4021807-1-rpm@xenomai.org>
References: <20210804174711.4021807-1-rpm@xenomai.org>
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

>From the standpoint of the in-band context when pipelining is in
effect, an interrupt entry is unsafe in a similar way a NMI is, since
it may preempt almost anywhere as IRQs are only virtually masked most
of the time, including inside (virtually) interrupt-free
sections.

Declare a (pseudo-)NMI entry to RCU when a hardware interrupt is fed
to the pipeline, so that we may enter RCU read sides to safely access
RCU-protected data (e.g. handle_domain_irq() needs this to resolve IRQ
mappings). Update the RCU code to extend in_nmi() checks to encompass
the pipeline entry context accordingly. Such NMI state always ends
before the companion core is allowed to reschedule, which must happen
before leaving the pipeline entry context.

In the same move, broaden the section defining a pipeline entry
(PIPELINE_MASK set in preempt count) to include the whole code path
which is traversed when feeding the pipeline, from
handle_irq_pipeline_prepare() to handle_irq_pipeline_finish().

On hardware interrupt, the execution flow is now as follows:

   <IRQ> /* hard irqs off */
	core_notify_irq_entry /* disable oob reschedule */
	<pipeline_entry>
		rcu_nmi_enter
			oob_irq_delivery
			      OR,
			inband_irq_logging
		rcu_nmi_exit
	</pipeline_entry>
	core_notify_irq_exit /* re-enable oob reschedule */
	synchronize_irq_log
		inband_irq_delivery  /* hard irqs on */
   </IRQ> /* in-band reschedule */

With such changes, we may safely assume from a pipeline entry context
that 1) we may enter RCU read sides to access protected data since RCU
is watching, 2) the virtual interrupt state (stall bit) might
legitimately be different from the hardware interrupt state - telling
lockdep about it, until these states are reconciled before the pending
interrupts are delivered to the in-band handlers.

In addition, this sanitizes the logic by denying RCU-awareness to
activities running on the out-of-band stage outside of the pipeline
entry context. In this case, we have no RCU protection against
accessing stale data.

All of the above is possible because hardware interrupts are always
disabled when running the pipeline entry code, therefore pipeline
entries are strictly serialized on a given CPU. The following
guarantees allow this:

- out-of-band handlers called from handle_oob_irq() may not re-enable
  hard interrupts.

- synchronizing the in-band log with hard interrupts enabled is done
  outside of the section marked as a pipeline entry.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/linux/irq_pipeline.h |  12 ++-
 include/linux/irqdesc.h      |   6 +-
 kernel/irq/pipeline.c        | 165 ++++++++++++++++++++---------------
 kernel/rcu/tree.c            |  38 ++++----
 4 files changed, 129 insertions(+), 92 deletions(-)

diff --git a/include/linux/irq_pipeline.h b/include/linux/irq_pipeline.h
index 157a72c00b6ae77..cbeb0109fa7ff47 100644
--- a/include/linux/irq_pipeline.h
+++ b/include/linux/irq_pipeline.h
@@ -28,6 +28,9 @@ void irq_pipeline_init(void);
 
 void arch_irq_pipeline_init(void);
 
+void generic_pipeline_irq_desc(struct irq_desc *desc,
+			       struct pt_regs *regs);
+
 int irq_inject_pipeline(unsigned int irq);
 
 void synchronize_pipeline(void);
@@ -90,7 +93,7 @@ extern struct irq_domain *synthetic_irq_domain;
 #else /* !CONFIG_IRQ_PIPELINE */
 
 #include <linux/irqstage.h>
-#include <asm/irq_pipeline.h>
+#include <linux/hardirq.h>
 
 static inline
 void irq_pipeline_init_early(void) { }
@@ -101,6 +104,13 @@ void irq_pipeline_init(void) { }
 static inline
 void irq_pipeline_oops(void) { }
 
+static inline int
+generic_pipeline_irq_desc(struct irq_desc *desc,
+			struct pt_regs *regs)
+{
+	return 0;
+}
+
 static inline bool handle_oob_irq(struct irq_desc *desc)
 {
 	return false;
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index eced0de5f4ac978..f134909335c8f76 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -154,7 +154,7 @@ static inline void generic_handle_irq_desc(struct irq_desc *desc)
 
 int generic_handle_irq(unsigned int irq);
 
-int generic_pipeline_irq(unsigned int irq, struct pt_regs *regs);
+void generic_pipeline_irq(unsigned int irq, struct pt_regs *regs);
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
 /*
@@ -175,7 +175,9 @@ static inline int handle_domain_irq(struct irq_domain *domain,
 {
 	unsigned int irq = irq_find_mapping(domain, hwirq);
 
-	return generic_pipeline_irq(irq, regs);
+	generic_pipeline_irq(irq, regs);
+
+	return 0;
 }
 #else
 static inline int handle_domain_irq(struct irq_domain *domain,
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index eefddd7730f8167..f64d731e8db18a3 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -931,7 +931,8 @@ static inline bool is_active_edge_event(struct irq_desc *desc)
 bool handle_oob_irq(struct irq_desc *desc) /* hardirqs off */
 {
 	struct irq_stage_data *oobd = this_oob_staged();
-	unsigned int irq = irq_desc_get_irq(desc), s;
+	unsigned int irq = irq_desc_get_irq(desc);
+	int stalled;
 
 	/*
 	 * Flow handlers of chained interrupts have no business
@@ -960,7 +961,7 @@ bool handle_oob_irq(struct irq_desc *desc) /* hardirqs off */
 	if (WARN_ON_ONCE(irq_pipeline_debug() && running_inband()))
 		return false;
 
-	s = test_and_stall_oob();
+	stalled = test_and_stall_oob();
 
 	if (unlikely(desc->istate & IRQS_EDGE)) {
 		do {
@@ -975,11 +976,11 @@ bool handle_oob_irq(struct irq_desc *desc) /* hardirqs off */
 	}
 
 	/*
-	 * Cascaded interrupts enter handle_oob_irq() with the
-	 * out-of-band stage stalled during the parent
-	 * invocation. Make sure to restore accordingly.
+	 * Cascaded interrupts enter handle_oob_irq() on the stalled
+	 * out-of-band stage during the parent invocation. Make sure
+	 * to restore the stall bit accordingly.
 	 */
-	if (likely(!s))
+	if (likely(!stalled))
 		unstall_oob();
 
 	/*
@@ -1050,90 +1051,94 @@ void restore_stage_on_irq(struct irq_stage_data *prevd)
 }
 
 /**
- *	generic_pipeline_irq - Pass an IRQ to the pipeline
- *	@irq:	IRQ to pass
+ *	generic_pipeline_irq_desc - Pass an IRQ to the pipeline
+ *	@desc:	Descriptor of the IRQ to pass
  *	@regs:	Register file coming from the low-level handling code
  *
  *	Inject an IRQ into the pipeline from a CPU interrupt or trap
  *	context.  A flow handler runs next for this IRQ.
  *
- *      Hard irqs must be off on entry.
+ *      Hard irqs must be off on entry. Caller should have pushed the
+ *      IRQ regs using set_irq_regs().
  */
-int generic_pipeline_irq(unsigned int irq, struct pt_regs *regs)
+void generic_pipeline_irq_desc(struct irq_desc *desc, struct pt_regs *regs)
 {
-	struct pt_regs *old_regs;
-	struct irq_desc *desc;
-	int ret = 0;
+	int irq = irq_desc_get_irq(desc);
+
+	if (irq_pipeline_debug() && !hard_irqs_disabled()) {
+		hard_local_irq_disable();
+		pr_err("IRQ pipeline: interrupts enabled on entry (IRQ%u)\n", irq);
+	}
 
 	trace_irq_pipeline_entry(irq);
+	copy_timer_regs(desc, regs);
+	generic_handle_irq_desc(desc);
+	trace_irq_pipeline_exit(irq);
+}
+
+void generic_pipeline_irq(unsigned int irq, struct pt_regs *regs)
+{
+	struct irq_desc *desc = irq_to_cached_desc(irq);
+	struct pt_regs *old_regs;
 
 	old_regs = set_irq_regs(regs);
-	desc = irq_to_cached_desc(irq);
+	generic_pipeline_irq_desc(desc, regs);
+	set_irq_regs(old_regs);
+}
 
-	if (irq_pipeline_debug()) {
-		if (!hard_irqs_disabled()) {
-			hard_local_irq_disable();
-			pr_err("IRQ pipeline: interrupts enabled on entry (IRQ%u)\n",
-			       irq);
-		}
+struct irq_stage_data *handle_irq_pipelined_prepare(struct pt_regs *regs)
+{
+	struct irq_stage_data *prevd;
 
-		/*
-		 * Running with the oob stage stalled implies hardirqs
-		 * off.  For this reason, if the oob stage is stalled
-		 * when we receive an interrupt from the hardware,
-		 * something is badly broken in our interrupt
-		 * state. Try fixing up, but without great hopes.
-		 */
-		if (!on_pipeline_entry() && test_oob_stall()) {
+	/*
+	 * Running with the oob stage stalled implies hardirqs off.
+	 * For this reason, if the oob stage is stalled when we
+	 * receive an interrupt from the hardware, something is badly
+	 * broken in our interrupt state. Try fixing up, but without
+	 * great hopes.
+	 */
+	if (irq_pipeline_debug()) {
+		if (test_oob_stall()) {
 			pr_err("IRQ pipeline: out-of-band stage stalled on IRQ entry\n");
 			unstall_oob();
 		}
-
-		if (unlikely(desc == NULL)) {
-			pr_err("IRQ pipeline: received unhandled IRQ%u\n",
-			       irq);
-			ret = -EINVAL;
-			goto out;
-		}
+		WARN_ON(on_pipeline_entry());
 	}
 
 	/*
-	 * We may re-enter this routine either legitimately due to
-	 * stacked IRQ domains, or because some chained IRQ handler is
-	 * abusing the API, and should have called
-	 * generic_handle_irq() instead of us. In any case, deal with
-	 * re-entry gracefully.
+	 * Switch early on to the out-of-band stage if present,
+	 * anticipating a companion kernel is going to handle the
+	 * incoming event. If not, never mind, we will switch back
+	 * in-band before synchronizing interrupts.
 	 */
-	if (unlikely(on_pipeline_entry())) {
-		if (WARN_ON_ONCE(irq_pipeline_debug() &&
-				 irq_settings_is_chained(desc)))
-			generic_handle_irq_desc(desc);
-		goto out;
-	}
+	prevd = switch_stage_on_irq();
+
+	/* Tell the companion core about the entry. */
+	irq_enter_pipeline();
 
 	/*
-	 * We switch eagerly to the oob stage if present, so that a
-	 * companion kernel readily runs on the right stage when we
-	 * call its out-of-band IRQ handler from handle_oob_irq(),
-	 * then irq_exit_pipeline() to unwind the interrupt context.
+	 * Invariant: IRQs may not pile up in the section covered by
+	 * the PIPELINE_OFFSET marker, because:
+	 *
+	 * - out-of-band handlers called from handle_oob_irq() may NOT
+	 * re-enable hard interrupts. Ever.
+	 *
+	 * - synchronizing the in-band log with hard interrupts
+	 * enabled is done outside of this section.
 	 */
-	copy_timer_regs(desc, regs);
 	preempt_count_add(PIPELINE_OFFSET);
-	generic_handle_irq_desc(desc);
-	preempt_count_sub(PIPELINE_OFFSET);
-out:
-	set_irq_regs(old_regs);
-	trace_irq_pipeline_exit(irq);
 
-	return ret;
-}
-
-struct irq_stage_data *handle_irq_pipelined_prepare(struct pt_regs *regs)
-{
-	struct irq_stage_data *prevd;
-
-	prevd = switch_stage_on_irq();
-	irq_enter_pipeline();
+	/*
+	 * From the standpoint of the in-band context when pipelining
+	 * is in effect, an interrupt entry is unsafe in a similar way
+	 * a NMI is, since it may preempt almost anywhere as IRQs are
+	 * only virtually masked most of the time, including inside
+	 * (virtually) interrupt-free sections. Declare a NMI entry so
+	 * that the low handling code is allowed to enter RCU read
+	 * sides (e.g. handle_domain_irq() needs this to resolve IRQ
+	 * mappings).
+	 */
+	rcu_nmi_enter();
 
 	return prevd;
 }
@@ -1141,19 +1146,37 @@ struct irq_stage_data *handle_irq_pipelined_prepare(struct pt_regs *regs)
 int handle_irq_pipelined_finish(struct irq_stage_data *prevd,
 				struct pt_regs *regs)
 {
+	/*
+	 * Leave the (pseudo-)NMI entry for RCU before the out-of-band
+	 * core might reschedule in irq_exit_pipeline(), and
+	 * interrupts are hard enabled again on this CPU as a result
+	 * of switching context.
+	 */
+	rcu_nmi_exit();
+
+	/*
+	 * Make sure to leave the pipeline entry context before
+	 * allowing the companion core to reschedule, and eventually
+	 * synchronizing interrupts.
+	 */
+	preempt_count_sub(PIPELINE_OFFSET);
+
+	/* Allow the companion core to reschedule. */
 	irq_exit_pipeline();
+
+	/* Back to the preempted stage. */
 	restore_stage_on_irq(prevd);
 
 	/*
-	 * We have to synchronize the logs because interrupts might
-	 * have been logged while we were busy handling an OOB event
-	 * coming from the hardware:
+	 * We have to synchronize interrupts because some might have
+	 * been logged while we were busy handling an out-of-band
+	 * event coming from the hardware:
 	 *
-	 * - as a result of calling an OOB handler which in turn
-	 * posted them.
+	 * - as a result of calling an out-of-band handler which in
+	 * turn posted them.
 	 *
 	 * - because we posted them directly for scheduling the
-	 * interrupt to happen from the inband stage.
+	 * interrupt to happen from the in-band stage.
 	 */
 	synchronize_pipeline_on_irq();
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2dba777d4e6de49..88e308f85f305dd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -232,6 +232,11 @@ static long rcu_get_n_cbs_cpu(int cpu)
 	return 0;
 }
 
+static inline bool rcu_in_nonmaskable(void)
+{
+	return on_pipeline_entry() || in_nmi();
+}
+
 void rcu_softirq_qs(void)
 {
 	rcu_qs();
@@ -709,9 +714,6 @@ noinstr void rcu_nmi_exit(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	if (running_oob())
-		return;
-
 	instrumentation_begin();
 
 	/*
@@ -739,7 +741,7 @@ noinstr void rcu_nmi_exit(void)
 	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
-	if (!in_nmi())
+	if (!rcu_in_nonmaskable())
 		rcu_prepare_for_idle();
 
 	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
@@ -750,7 +752,7 @@ noinstr void rcu_nmi_exit(void)
 	rcu_dynticks_eqs_enter();
 	// ... but is no longer watching here.
 
-	if (!in_nmi())
+	if (!rcu_in_nonmaskable())
 		rcu_dynticks_task_enter();
 }
 
@@ -939,7 +941,7 @@ void __rcu_irq_enter_check_tick(void)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	// If we're here from NMI there's nothing to do.
-	if (in_nmi())
+	if (rcu_in_nonmaskable())
 		return;
 
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
@@ -987,9 +989,6 @@ noinstr void rcu_nmi_enter(void)
 	long incby = 2;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	if (running_oob())
-		return;
-
 	/* Complain about underflow. */
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
 
@@ -1003,14 +1002,14 @@ noinstr void rcu_nmi_enter(void)
 	 */
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
 
-		if (!in_nmi())
+		if (!rcu_in_nonmaskable())
 			rcu_dynticks_task_exit();
 
 		// RCU is not watching here ...
 		rcu_dynticks_eqs_exit();
 		// ... but is watching here.
 
-		if (!in_nmi()) {
+		if (!rcu_in_nonmaskable()) {
 			instrumentation_begin();
 			rcu_cleanup_after_idle();
 			instrumentation_end();
@@ -1023,7 +1022,7 @@ noinstr void rcu_nmi_enter(void)
 		instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
 
 		incby = 1;
-	} else if (!in_nmi()) {
+	} else if (!rcu_in_nonmaskable()) {
 		instrumentation_begin();
 		rcu_irq_enter_check_tick();
 	} else  {
@@ -1101,10 +1100,10 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 /**
  * rcu_is_watching - see if RCU thinks that the current CPU is not idle
  *
- * Return true if RCU is watching the running CPU, which means that this
- * CPU can safely enter RCU read-side critical sections.  In other words,
- * if the current CPU is not in its idle loop or is in an interrupt or
- * NMI handler, return true.
+ * Return true if RCU is watching the running CPU, which means that
+ * this CPU can safely enter RCU read-side critical sections.  In
+ * other words, if the current CPU is not in its idle loop or is in an
+ * interrupt or NMI handler, return true.
  *
  * Make notrace because it can be called by the internal functions of
  * ftrace, and making this notrace removes unnecessary recursion calls.
@@ -1113,9 +1112,12 @@ notrace bool rcu_is_watching(void)
 {
 	bool ret;
 
-	if (running_oob())
+	if (on_pipeline_entry())
 		return true;
 
+	if (WARN_ON_ONCE(irq_pipeline_debug() && running_oob()))
+		return false;
+
 	preempt_disable_notrace();
 	ret = !rcu_dynticks_curr_cpu_in_eqs();
 	preempt_enable_notrace();
@@ -1162,7 +1164,7 @@ bool rcu_lockdep_current_cpu_online(void)
 	struct rcu_node *rnp;
 	bool ret = false;
 
-	if (in_nmi() || !rcu_scheduler_fully_active)
+	if (rcu_in_nonmaskable() || !rcu_scheduler_fully_active)
 		return true;
 	preempt_disable_notrace();
 	rdp = this_cpu_ptr(&rcu_data);
-- 
2.31.1


