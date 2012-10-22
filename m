Message-ID: <508552A9.7020608@xenomai.org>
Date: Mon, 22 Oct 2012 16:05:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50812949.5040403@openwide.fr>
	<50814532.5090408@xenomai.org>	<5082CD5C.1040409@openwide.fr>
	<5082DED2.1050405@xenomai.org>	<50835162.5020401@openwide.fr>
	<50844242.7010107@xenomai.org>	<5084863E.7030900@openwide.fr>
	<508547AC.7020103@xenomai.org>
In-Reply-To: <508547AC.7020103@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] s3c24xx with clocksource/clockevent (kernel 3.2.21)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 10/22/2012 03:18 PM, Gilles Chanteperdrix wrote:

> Another candidate would be irq_enable in kernel/irq/chip.c, shut off the
> irqs around the whole section, or move irq_state_clk_masked before the
> call to irq_unmask with a compiler barrier.


Actually, the following patch fixes another bug I had, so, could you 
check if it fixes yours? (and thanks for the explanations, they were 
very helpful).

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index f5d8d5e..cef1e78 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -167,8 +167,10 @@ int irq_startup(struct irq_desc *desc, bool resend)
 	desc->depth = 0;
 
 	if (desc->irq_data.chip->irq_startup) {
+		unsigned long flags = hard_cond_local_irq_save();
 		ret = desc->irq_data.chip->irq_startup(&desc->irq_data);
 		irq_state_clr_masked(desc);
+		hard_cond_local_irq_restore(flags);
 	} else {
 		irq_enable(desc);
 	}
@@ -192,12 +194,14 @@ void irq_shutdown(struct irq_desc *desc)
 
 void irq_enable(struct irq_desc *desc)
 {
+	unsigned long flags = hard_cond_local_irq_save();
 	irq_state_clr_disabled(desc);
 	if (desc->irq_data.chip->irq_enable)
 		desc->irq_data.chip->irq_enable(&desc->irq_data);
 	else
 		desc->irq_data.chip->irq_unmask(&desc->irq_data);
 	irq_state_clr_masked(desc);
+	hard_cond_local_irq_restore(flags);
 }
 
 void irq_disable(struct irq_desc *desc)
@@ -211,11 +215,13 @@ void irq_disable(struct irq_desc *desc)
 
 void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu)
 {
+	unsigned long flags = hard_cond_local_irq_save();
 	if (desc->irq_data.chip->irq_enable)
 		desc->irq_data.chip->irq_enable(&desc->irq_data);
 	else
 		desc->irq_data.chip->irq_unmask(&desc->irq_data);
 	cpumask_set_cpu(cpu, desc->percpu_enabled);
+	hard_cond_local_irq_restore(flags);
 }
 
 void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu)


-- 
                                                                Gilles.

