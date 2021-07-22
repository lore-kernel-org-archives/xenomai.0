From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/6] genirq: irq_pipeline: restore oob stall bit on chained
 IRQs
Date: Thu, 22 Jul 2021 11:48:54 +0200
Message-Id: <20210722094859.3580166-2-rpm@xenomai.org>
In-Reply-To: <20210722094859.3580166-1-rpm@xenomai.org>
References: <20210722094859.3580166-1-rpm@xenomai.org>
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

handle_oob_irq() is called recursively when handling chained
interrupts, at which point the oob stage is already stalled:

generic_handle_irq /* oob stage unstalled */
   -> <parent IRQ flow handler>
          -> handle_oob_irq  /* oob stage stalled */
	        -> <parent IRQ demultiplexer>
		       -> generic_handle_irq
			      -> <chained IRQ flow handler>
			             -> handle_oob_irq
				     /* oob stage must stay stalled */
				 ...
		          ...
	           ...

		  /*
		   * oob stage is unstalled upon leaving the outer call
		   * to handle_oob_irq
		   */

Make sure to restore the oob stall bit to its original value on entry
to this routine before leaving it, instead of clearing such bit
unconditionally.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/irq/pipeline.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index a220d9467a56ce2..090fcc8bbb6a449 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -931,7 +931,7 @@ static inline bool is_active_edge_event(struct irq_desc *desc)
 bool handle_oob_irq(struct irq_desc *desc) /* hardirqs off */
 {
 	struct irq_stage_data *oobd = this_oob_staged();
-	unsigned int irq = irq_desc_get_irq(desc);
+	unsigned int irq = irq_desc_get_irq(desc), s;
 
 	/*
 	 * Flow handlers of chained interrupts have no business
@@ -959,19 +959,8 @@ bool handle_oob_irq(struct irq_desc *desc) /* hardirqs off */
 
 	if (WARN_ON_ONCE(irq_pipeline_debug() && running_inband()))
 		return false;
-	/*
-	 * Running with the oob stage stalled implies hardirqs off, so
-	 * if the oob stage is stalled on pipeline entry, something is
-	 * badly broken in our interrupt state. Pretend the event has
-	 * been handled, which may end up with the device hammering us
-	 * with more interrupts, but there is no safe option at this
-	 * point.
-	 */
-	if (WARN_ON_ONCE(irq_pipeline_debug() &&
-			on_pipeline_entry() && test_oob_stall()))
-		return true;
 
-	stall_oob();
+	s = test_and_stall_oob();
 
 	if (unlikely(desc->istate & IRQS_EDGE)) {
 		do {
@@ -985,7 +974,13 @@ bool handle_oob_irq(struct irq_desc *desc) /* hardirqs off */
 		do_oob_irq(desc);
 	}
 
-	unstall_oob();
+	/*
+	 * Cascaded interrupts enter handle_oob_irq() with the
+	 * out-of-band stage stalled during the parent
+	 * invocation. Make sure to restore accordingly.
+	 */
+	if (likely(!s))
+		unstall_oob();
 
 	/*
 	 * CPU migration and/or stage switching over the handler are
@@ -1060,7 +1055,7 @@ void restore_stage_on_irq(struct irq_stage_data *prevd)
  *	@regs:	Register file coming from the low-level handling code
  *
  *	Inject an IRQ into the pipeline from a CPU interrupt or trap
- *	context.  A flow handler runs for this IRQ.
+ *	context.  A flow handler runs next for this IRQ.
  *
  *      Hard irqs must be off on entry.
  */
@@ -1081,6 +1076,19 @@ int generic_pipeline_irq(unsigned int irq, struct pt_regs *regs)
 			pr_err("IRQ pipeline: interrupts enabled on entry (IRQ%u)\n",
 			       irq);
 		}
+		/*
+		 * Running with the oob stage stalled implies hardirqs
+		 * off.  For this reason, if the oob stage is stalled
+		 * on pipeline entry but we still receive an interrupt
+		 * from the hardware, something is badly broken in our
+		 * interrupt state. Try fixing up, but without great
+		 * hopes.
+		 */
+		if (on_pipeline_entry() && test_oob_stall()) {
+			pr_err("IRQ pipeline: out-of-band stage stalled on IRQ entry\n");
+			unstall_oob();
+		}
+
 		if (unlikely(desc == NULL)) {
 			pr_err("IRQ pipeline: received unhandled IRQ%u\n",
 			       irq);
-- 
2.31.1


