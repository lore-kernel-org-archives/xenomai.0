Resent-To: Xenomai <xenomai@xenomai.org>
Resent-Message-Id: <51522A2B.4030601@xenomai.org>
Message-ID: <515229C4.6000805@xenomai.org>
Date: Wed, 27 Mar 2013 00:05:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] one-shot fasteoi irqs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>


Hi Jan,

I seem to recall you sent patches to fix threaded irqs some time ago. I 
am having a problem here without SMP, whereas the system works with 
SMP. A fasteoi irq handler triggers repeatedly while its threaded 
counterpart never gets triggered. I believe this is because 
handle_fasteoi_irq unconditionally releases the irq line. The following 
patch seems to fix the issue though I would prefer a cleaner solution.

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 11e75d1..2ff8d3a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -463,8 +463,11 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
 
 #ifdef CONFIG_IPIPE
 	/* XXX: IRQCHIP_EOI_IF_HANDLED is ignored. */
-	if (desc->irq_data.chip->irq_release)
-		desc->irq_data.chip->irq_release(&desc->irq_data);
+	if (desc->irq_data.chip->irq_release) {
+		if ((!(desc->istate & IRQS_ONESHOT) ||
+		     !desc->threads_oneshot))
+			desc->irq_data.chip->irq_release(&desc->irq_data);
+	}
 out_eoi:
 #else  /* !CONFIG_IPIPE */
 	if (desc->istate & IRQS_ONESHOT)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e49a288..485c2c4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -715,9 +715,15 @@ again:
 
 	desc->threads_oneshot &= ~action->thread_mask;
 
-	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
-	    irqd_irq_masked(&desc->irq_data))
-		unmask_irq(desc);
+	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data)) {
+#ifdef CONFIG_IPIPE
+		if (desc->irq_data.chip->irq_release)
+			desc->irq_data.chip->irq_release(&desc->irq_data);
+		else 
+#endif
+			if (irqd_irq_masked(&desc->irq_data))
+				unmask_irq(desc);
+	}
 
 out_unlock:
 	raw_spin_unlock_irq(&desc->lock);


-- 
                                                                Gilles.

