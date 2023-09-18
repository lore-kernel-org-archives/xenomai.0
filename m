Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566B134BD
	for <xenomai@lists.linux.dev>; Mon, 18 Sep 2023 08:06:30 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25540E000A;
	Mon, 18 Sep 2023 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695024388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=btTf5XUcmCfIqU6LLSzwqVd5aI3kfQjBJJAeDpgliN4=;
	b=VIei4Yhc6++7Jtgdy6Ey/fO2/zMS73hA9ixZWf4Ko3DGzXwbcWAtF/yt0WcX6T6CwXelRv
	rsaMYoamrbEbL/M44rePPaHHdr1c6ZcGdTeLSFV8JH2QnoIDuVXd2VPDGY5GTezuSYyJMk
	zAdvzVAYGtJXqVIRXjjbaqRM/MZ1DCNpwqyfaNXDzyyUT0UAgMpDkRuiA1jT5UHlC8yz6Q
	gTdhyoNo+gBvCo8ghNzlwh5iNPoTBZVcCu6SqH4dyOO2bXJRUZQ7l9C+sKRCQk8WSq6jme
	qWnTXzfiO25uOdxAcY1SyPzoAwie1Ua0VYu4OM8PQLAqld0CvBVxqWriTGafOg==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Hongzhan Chen <hongzhan.chen@intel.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v2] genirq: irq_pipeline: fix irq flow handling with stacked irqchips
Date: Mon, 18 Sep 2023 10:06:09 +0200
Message-ID: <20230918080609.96600-1-rpm@xenomai.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rpm@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

When irqchips are stacked, a cascaded event decoded by a parent irq
which is not delivered oob won't receive any ack/eoi, which is
wrong. Failing to ack any unmasked edge event could quickly yield an
interrupt storm. E.g. on x86, with a gpio irq controller stacked on
top of the IO/APIC:

handle_irq_pipelined_prepare()
[on_pipeline_entry: true]
arch_handle_irq()
        handle_fasteoi_irq()
                handle_oob_irq()
                        mask_cond_eoi_irq()
handle_irq_pipelined_finish()
[on_pipeline_entry: false]
        synchronize_pipeline_on_irq()
                handle_fasteoi_irq() [!on_pipeline_entry]
                      intel_gpio_irq()
                           handle_edge_irq() <<< failed to ack

To solve this, we need to track the deferral status of every irq
event, running the latter through the pipeline injection code when
required, regardless of the current stage.

See https://lore.kernel.org/xenomai/MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com/.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 arch/x86/kernel/irq_pipeline.c |   3 +-
 include/linux/hardirq.h        |   5 --
 include/linux/irq.h            |   5 ++
 kernel/irq/chip.c              | 125 ++++++++++++++++++++++++++++-----
 kernel/irq/internals.h         |   4 +-
 kernel/irq/pipeline.c          |  13 +++-
 6 files changed, 130 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 831a04a2ea146..b590986d16990 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -116,6 +116,8 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
 	 * don't want to break.
 	 */
 
+	irq_clear_deferral(desc);
+
 	switch (vector) {
 #ifdef CONFIG_SMP
 	case RESCHEDULE_VECTOR:
@@ -174,7 +176,6 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
 
 static void do_irq_inband(struct pt_regs *regs, u32 irq)
 {
-
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	desc->handle_irq(desc);
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index cf633c758b1e4..ef41904b46304 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -143,11 +143,6 @@ void irq_exit_rcu(void);
 		irq_pipeline_nmi_exit();			\
 	} while (0)
 
-static inline bool start_irq_flow(void)
-{
-	return !irqs_pipelined() || in_pipeline();
-}
-
 static inline bool on_pipeline_entry(void)
 {
 	return irqs_pipelined() && in_pipeline();
diff --git a/include/linux/irq.h b/include/linux/irq.h
index d242ab0df11f0..cf7139c9059b5 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1239,11 +1239,16 @@ static inline struct irq_chip_type *irq_data_get_chip_type(struct irq_data *d)
 
 #ifdef CONFIG_IRQ_PIPELINE
 int irq_switch_oob(unsigned int irq, bool on);
+void irq_clear_deferral(struct irq_desc *desc);
 #else
 static inline int irq_switch_oob(unsigned int irq, bool on)
 {
 	return 0;
 }
+
+static inline void irq_clear_deferral(struct irq_desc *desc)
+{
+}
 #endif	/* !CONFIG_IRQ_PIPELINE */
 
 #ifdef CONFIG_SMP
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 05fb1f8d4713b..d45bbf7d06d00 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -413,6 +413,11 @@ void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu)
 	cpumask_clear_cpu(cpu, desc->percpu_enabled);
 }
 
+void irq_clear_deferral(struct irq_desc *desc)
+{
+	desc->istate &= ~IRQS_DEFERRED;
+}
+
 static inline void mask_ack_irq(struct irq_desc *desc)
 {
 	if (desc->irq_data.chip->irq_mask_ack) {
@@ -509,6 +514,75 @@ static bool irq_check_poll(struct irq_desc *desc)
 	return irq_wait_for_poll(desc);
 }
 
+enum {
+	IRQ_FLOW_START,
+	IRQ_FLOW_PILEUP,
+	IRQ_FLOW_REPLAY,
+};
+
+/*
+ * irq_starting_flow - Determine whether we are actually starting an
+ * interrupt flow.
+ *
+ * When interrupt pipelining is enabled, interrupt flow handlers may
+ * be called twice for each event, once from the pipeline entry
+ * context in an attempt to handle the hardware event from the oob
+ * stage, a second time if the event was deferred to the in-band
+ * stage. In the first case, we have to ack the hardware before
+ * feeding the pipeline. Otherwise, we should simply run the action
+ * associated to the event from the in-band stage.
+ *
+ * With stacked irqchips, handlers of parent irqs not delivered to the
+ * oob stage would decode and post the cascaded events to the in-band
+ * stage as well. The internal per-descriptor IRQS_DEFERRED flag
+ * disambiguates between the latter context and events being replayed
+ * after deferral to the in-band stage, so that we do ack the hardware
+ * for cascaded events as expected.
+ *
+ * We might also receive a subsequent unmasked edge event on the same
+ * line while a deferred one is still pending replay from the in-band
+ * stage (hard irqs are on for replay). The flow state enumeration
+ * disambiguates all cases as follows:
+ *
+ * - IRQ_FLOW_START: we are running oob on behalf of the low-level irq
+ *   entry code, no deferred event is pending replay for the same
+ *   line, we need to send ack to the hardware.
+ *
+ * - IRQ_FLOW_PILEUP: we are running in-band for synchronizing the irq
+ *   log, one or more deferred events are already pending replay for
+ *   the same line, we need to ack the subsequent event to the
+ *   hardware too.
+ *
+ * - IRQ_FLOW_REPLAY: we are (re)playing a deferred event from the
+ *   in-band stage, as a result of synchronizing the irq log.
+ */
+static inline unsigned int irq_starting_flow(struct irq_desc *desc)
+{
+	if (!irqs_pipelined() || !(desc->istate & IRQS_DEFERRED))
+		return IRQ_FLOW_START;
+
+	return in_pipeline() ? IRQ_FLOW_PILEUP : IRQ_FLOW_REPLAY;
+}
+
+/*
+ * irq_feeding_pipeline - Determine whether we should be feeding the
+ * interrupt pipeline with the incoming event.
+ *
+ * Depending on the flow state determined by irq_starting_flow(), the
+ * event is passed to the oob handler or directly replayed from the
+ * current in-band stage.
+ */
+static inline bool irq_feeding_pipeline(struct irq_desc *desc, int state)
+{
+	if (irqs_pipelined()) {
+		if (state != IRQ_FLOW_REPLAY)
+			return true;
+		irq_clear_deferral(desc);
+	}
+
+	return false;
+}
+
 static bool irq_may_run(struct irq_desc *desc)
 {
 	unsigned int mask = IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
@@ -561,12 +635,15 @@ static bool irq_may_run(struct irq_desc *desc)
  */
 void handle_simple_irq(struct irq_desc *desc)
 {
+	int flow;
+
 	raw_spin_lock(&desc->lock);
 
-	if (start_irq_flow() && !irq_may_run(desc))
+	flow = irq_starting_flow(desc);
+	if (flow != IRQ_FLOW_REPLAY && !irq_may_run(desc))
 		goto out_unlock;
 
-	if (on_pipeline_entry()) {
+	if (irq_feeding_pipeline(desc, flow)) {
 		handle_oob_irq(desc);
 		goto out_unlock;
 	}
@@ -601,12 +678,15 @@ EXPORT_SYMBOL_GPL(handle_simple_irq);
  */
 void handle_untracked_irq(struct irq_desc *desc)
 {
+	int flow;
+
 	raw_spin_lock(&desc->lock);
 
-	if (start_irq_flow() && !irq_may_run(desc))
+	flow = irq_starting_flow(desc);
+	if (flow != IRQ_FLOW_REPLAY && !irq_may_run(desc))
 		goto out_unlock;
 
-	if (on_pipeline_entry()) {
+	if (irq_feeding_pipeline(desc, flow)) {
 		handle_oob_irq(desc);
 		goto out_unlock;
 	}
@@ -675,16 +755,19 @@ static void cond_unmask_irq(struct irq_desc *desc)
  */
 void handle_level_irq(struct irq_desc *desc)
 {
+	int flow;
+
 	raw_spin_lock(&desc->lock);
 
-	if (start_irq_flow()) {
+	flow = irq_starting_flow(desc);
+	if (flow != IRQ_FLOW_REPLAY) {
 		mask_ack_irq(desc);
 
 		if (!irq_may_run(desc))
 			goto out_unlock;
 	}
 
-	if (on_pipeline_entry()) {
+	if (irq_feeding_pipeline(desc, flow)) {
 		if (handle_oob_irq(desc))
 			goto out_unmask;
 		goto out_unlock;
@@ -749,6 +832,7 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 void handle_fasteoi_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
+	int flow;
 
 	raw_spin_lock(&desc->lock);
 
@@ -757,13 +841,14 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 	 * can arrive on the new CPU before the original CPU has completed
 	 * handling the previous one - it may need to be resent.
 	 */
-	if (start_irq_flow() && !irq_may_run(desc)) {
+	flow = irq_starting_flow(desc);
+	if (flow != IRQ_FLOW_REPLAY && !irq_may_run(desc)) {
 		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
 			desc->istate |= IRQS_PENDING;
 		goto out;
 	}
 
-	if (on_pipeline_entry()) {
+	if (irq_feeding_pipeline(desc, flow)) {
 		if (handle_oob_irq(desc))
 			chip->irq_eoi(&desc->irq_data);
 		else
@@ -858,10 +943,12 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
 void handle_edge_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int flow;
 
 	raw_spin_lock(&desc->lock);
 
-	if (start_irq_flow()) {
+	flow = irq_starting_flow(desc);
+	if (flow != IRQ_FLOW_REPLAY) {
 		desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
 		if (!irq_may_run(desc)) {
@@ -881,7 +968,7 @@ void handle_edge_irq(struct irq_desc *desc)
 		}
 	}
 
-	if (on_pipeline_entry()) {
+	if (irq_feeding_pipeline(desc, flow)) {
 		chip->irq_ack(&desc->irq_data);
 		desc->istate |= IRQS_EDGE;
 		handle_oob_irq(desc);
@@ -934,10 +1021,12 @@ EXPORT_SYMBOL(handle_edge_irq);
 void handle_edge_eoi_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int flow;
 
 	raw_spin_lock(&desc->lock);
 
-	if (start_irq_flow()) {
+	flow = irq_starting_flow(desc);
+	if (flow != IRQ_FLOW_REPLAY) {
 		desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
 		if (!irq_may_run(desc)) {
@@ -946,7 +1035,7 @@ void handle_edge_eoi_irq(struct irq_desc *desc)
 		}
 	}
 
-	if (on_pipeline_entry()) {
+	if (irq_feeding_pipeline(desc, flow)) {
 		desc->istate |= IRQS_EDGE;
 		if (handle_oob_irq(desc))
 			goto out_eoi;
@@ -1341,13 +1430,15 @@ void irq_cpu_offline(void)
 void handle_fasteoi_ack_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
+	int flow;
 
 	raw_spin_lock(&desc->lock);
 
-	if (start_irq_flow() && !irq_may_run(desc))
+	flow = irq_starting_flow(desc);
+	if (flow != IRQ_FLOW_REPLAY && !irq_may_run(desc))
 		goto out;
 
-	if (on_pipeline_entry()) {
+	if (irq_feeding_pipeline(desc, flow)) {
 		chip->irq_ack(&desc->irq_data);
 		if (handle_oob_irq(desc))
 			chip->irq_eoi(&desc->irq_data);
@@ -1404,17 +1495,19 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_ack_irq);
 void handle_fasteoi_mask_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
+	int flow;
 
 	raw_spin_lock(&desc->lock);
 
-	if (start_irq_flow()) {
+	flow = irq_starting_flow(desc);
+	if (flow != IRQ_FLOW_REPLAY) {
 		mask_ack_irq(desc);
 
 		if (!irq_may_run(desc))
 			goto out;
 	}
 
-	if (on_pipeline_entry()) {
+	if (irq_feeding_pipeline(desc, flow)) {
 		if (handle_oob_irq(desc))
 			chip->irq_eoi(&desc->irq_data);
 		else
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index e4f66a7a24c2c..a3b40ce2e1dd7 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -56,7 +56,8 @@ enum {
  * IRQS_SUSPENDED		- irq is suspended
  * IRQS_NMI			- irq line is used to deliver NMIs
  * IRQS_SYSFS			- descriptor has been added to sysfs
- * IRQS_EDGE			- irq line received an edge event
+ * IRQS_EDGE			- irq line received an edge event (irq_pipeline)
+ * IRQS_DEFERRED		- irq event deferred to inband (irq_pipeline)
  */
 enum {
 	IRQS_AUTODETECT		= 0x00000001,
@@ -71,6 +72,7 @@ enum {
 	IRQS_NMI		= 0x00002000,
 	IRQS_SYSFS		= 0x00004000,
 	IRQS_EDGE		= 0x00008000,
+	IRQS_DEFERRED		= 0x00010000,
 };
 
 #include "debug.h"
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index 550bacf2cb77d..d550a37a895e9 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -144,7 +144,12 @@ static struct irq_domain_ops sirq_domain_ops = {
  *	@desc:	the interrupt description structure for this irq
  *
  *	Handles synthetic interrupts flowing down the IRQ pipeline
- *	with per-CPU semantics.
+ *	with per-CPU semantics (accessing desc needs no locking).
+ *
+ *	Since the SIPIC cannot be stacked on top of a parent irqchip,
+ * 	we can bypass most of the IRQS_DEFERRED logic, testing
+ * 	on_pipeline_entry() directly - although we should still clear
+ * 	IRQS_DEFERRED when in-band since handle_oob_irq() raises it.
  *
  *      CAUTION: synthetic IRQs may be used to map hardware-generated
  *      events (e.g. IPIs or traps), we must start handling them as
@@ -162,6 +167,8 @@ void handle_synthetic_irq(struct irq_desc *desc)
 		return;
 	}
 
+	irq_clear_deferral(desc);
+
 	action = desc->action;
 	if (action == NULL) {
 		if (printk_ratelimit())
@@ -955,7 +962,8 @@ static inline bool is_active_edge_event(struct irq_desc *desc)
 		!irqd_irq_disabled(&desc->irq_data);
 }
 
-bool handle_oob_irq(struct irq_desc *desc) /* hardirqs off */
+/* desc->lock held unless per-CPU, hardirqs off. */
+bool handle_oob_irq(struct irq_desc *desc)
 {
 	struct irq_stage_data *oobd = this_oob_staged();
 	unsigned int irq = irq_desc_get_irq(desc);
@@ -981,6 +989,7 @@ bool handle_oob_irq(struct irq_desc *desc) /* hardirqs off */
 	 * whether an out-of-band interrupt was delivered.
 	 */
 	if (!oob_stage_present() || !irq_settings_is_oob(desc)) {
+		desc->istate |= IRQS_DEFERRED;
 		irq_post_stage(&inband_stage, irq);
 		return false;
 	}
-- 
2.41.0

