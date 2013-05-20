From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Mon, 20 May 2013 14:28:55 +0200
Message-Id: <1369052935-19505-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH] ipipe: fix percpu irqs with fasteoi irq chip
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When percpu irqs share an irq chip with fasteoi irqs, the irq_hold
and irq_release callbacks should be used to ack and unmask the irqs.
Change __fixup_irq_handler, handle_percpu_irq and
handle_percpu_devid_irq to adapt to use them.
---
 kernel/irq/chip.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3d1ed7e..f6ec956 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -426,7 +426,7 @@ static void cond_release_fasteoi_irq(struct irq_desc *desc)
 {
 	if (desc->irq_data.chip->irq_release && 
 	    !irqd_irq_disabled(&desc->irq_data) && !desc->threads_oneshot)
-		desc->irq_data.chip->irq_release(&desc->irq_data);;
+		desc->irq_data.chip->irq_release(&desc->irq_data);
 }
 #endif /* CONFIG_IPIPE */
 
@@ -620,10 +620,14 @@ handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
 	kstat_incr_irqs_this_cpu(irq, desc);
 
 #ifdef CONFIG_IPIPE
+	(void)chip;
+
 	handle_irq_event_percpu(desc, desc->action);
 
-	if (chip->irq_eoi && !irqd_irq_masked(&desc->irq_data))
-		chip->irq_unmask(&desc->irq_data);
+	if (cpumask_test_cpu(smp_processor_id(), desc->percpu_enabled) &&
+	    !irqd_irq_masked(&desc->irq_data) &&
+	    !desc->threads_oneshot)
+		desc->ipipe_end(desc->irq_data.irq, desc);
 #else
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
@@ -671,8 +675,11 @@ void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc)
 	if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
 #else
-	if (chip->irq_eoi && !irqd_irq_masked(&desc->irq_data))
-		chip->irq_unmask(&desc->irq_data);
+	;
+	if (cpumask_test_cpu(smp_processor_id(), desc->percpu_enabled) && 
+	    !irqd_irq_masked(&desc->irq_data) &&
+	    !desc->threads_oneshot)
+		desc->ipipe_end(desc->irq_data.irq, desc);
 #endif
 }
 
@@ -756,8 +763,14 @@ __fixup_irq_handler(struct irq_desc *desc, irq_flow_handler_t handle, int is_cha
 			desc->ipipe_end = __ipipe_end_fasteoi_irq;
 		} else if (handle == handle_percpu_irq ||
 			   handle == handle_percpu_devid_irq) {
-			desc->ipipe_ack = __ipipe_ack_percpu_irq;
-			desc->ipipe_end = __ipipe_nop_irq;
+			if (irq_desc_get_chip(desc) &&
+			    irq_desc_get_chip(desc)->irq_hold) {
+				desc->ipipe_ack = __ipipe_ack_fasteoi_irq;
+				desc->ipipe_end = __ipipe_end_fasteoi_irq;
+			} else {
+				desc->ipipe_ack = __ipipe_ack_percpu_irq;
+				desc->ipipe_end = __ipipe_nop_irq;
+			}
 		} else if (irq_desc_get_chip(desc) == &no_irq_chip) {
 			desc->ipipe_ack = __ipipe_nop_irq;
 			desc->ipipe_end = __ipipe_nop_irq;
-- 
1.7.2.5


