Message-ID: <494B6A26.1040001@domain.hid>
Date: Fri, 19 Dec 2008 10:32:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [RFC][PATCH] x86-64: Enable root domain IRQ migration
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

Currently, I-pipe breaks the setting of IRQ affinities through Linux,
the root domain. This is because migrating IRQs while they are active is
a tricky business on x86, requiring special measures within the IRQ ack
path. And as this path is now used by non-root domains, the migration
code had to be deactivated.

The following patch is a proof of concept for x86-64 how to overcome
this unfortunate limitation (if you want to isolate RT from non-RT
CPUs). The approach works without adding code to critical paths. First
tests inside KVM indicate that things work as expected, but more testing
on real iron is scheduled, e.g. to check MSI IRQs which I don't have in
my KVM environment.

Feedback welcome.

Jan

---
 arch/x86/kernel/io_apic_64.c |   42 +++++++++++++++++++++++++++++++++++++-----
 include/asm-x86/ipipe_64.h   |   16 ++++++++++++++--
 include/linux/irq.h          |    3 +++
 3 files changed, 54 insertions(+), 7 deletions(-)

Index: b/arch/x86/kernel/io_apic_64.c
===================================================================
--- a/arch/x86/kernel/io_apic_64.c
+++ b/arch/x86/kernel/io_apic_64.c
@@ -174,7 +174,6 @@ static inline void io_apic_modify(unsign
 	writel(value, &io_apic->data);
 }
 
-#ifndef CONFIG_IPIPE
 static bool io_apic_level_ack_pending(unsigned int irq)
 {
 	struct irq_pin_list *entry;
@@ -203,7 +202,6 @@ static bool io_apic_level_ack_pending(un
 
 	return false;
 }
-#endif /* !CONFIG_IPIPE */
 
 /*
  * Synchronize the IO-APIC and the CPU by doing
@@ -1436,7 +1434,6 @@ unlock:
 	irq_exit();
 }
 
-#ifndef CONFIG_IPIPE
 static void irq_complete_move(unsigned int irq)
 {
 	struct irq_cfg *cfg = irq_cfg + irq;
@@ -1456,11 +1453,34 @@ static void irq_complete_move(unsigned i
 		cfg->move_in_progress = 0;
 	}
 }
-#endif
-#elif !defined(CONFIG_IPIPE)
+#else
 static inline void irq_complete_move(unsigned int irq) {}
 #endif
 
+#ifdef CONFIG_IPIPE
+static void move_apic_irq(unsigned int irq)
+{
+	struct irq_desc *desc = &irq_desc[irq];
+
+	if (desc->handle_irq == &handle_edge_irq) {
+		spin_lock(&desc->lock);
+		irq_complete_move(irq);
+		move_native_irq(irq);
+		spin_unlock(&desc->lock);
+	} else if (desc->handle_irq == &handle_fasteoi_irq) {
+		spin_lock(&desc->lock);
+		irq_complete_move(irq);
+		if (unlikely(desc->status & IRQ_MOVE_PENDING)) {
+			if (!io_apic_level_ack_pending(irq))
+				move_masked_irq(irq);
+			unmask_IO_APIC_irq(irq);
+		}
+		spin_unlock(&desc->lock);
+	} else
+		WARN_ON(1);
+}
+#endif /* CONFIG_IPIPE */
+
 static void ack_apic_edge(unsigned int irq)
 {
 #ifndef CONFIG_IPIPE
@@ -1544,6 +1564,9 @@ static struct irq_chip ioapic_chip __rea
 	.eoi 		= ack_apic_level,
 #ifdef CONFIG_SMP
 	.set_affinity 	= set_ioapic_affinity_irq,
+#ifdef CONFIG_IPIPE
+	.move		= move_apic_irq,
+#endif
 #endif
 	.retrigger	= ioapic_retrigger_irq,
 };
@@ -2087,6 +2110,9 @@ static struct irq_chip msi_chip = {
 	.ack		= ack_apic_edge,
 #ifdef CONFIG_SMP
 	.set_affinity	= set_msi_irq_affinity,
+#ifdef CONFIG_IPIPE
+	.move		= move_apic_irq,
+#endif
 #endif
 	.retrigger	= ioapic_retrigger_irq,
 };
@@ -2156,6 +2182,9 @@ struct irq_chip dmar_msi_type = {
 	.ack = ack_apic_edge,
 #ifdef CONFIG_SMP
 	.set_affinity = dmar_msi_set_affinity,
+#ifdef CONFIG_IPIPE
+	.move = move_apic_irq,
+#endif
 #endif
 	.retrigger = ioapic_retrigger_irq,
 };
@@ -2225,6 +2254,9 @@ static struct irq_chip ht_irq_chip = {
 	.ack		= ack_apic_edge,
 #ifdef CONFIG_SMP
 	.set_affinity	= set_ht_irq_affinity,
+#ifdef CONFIG_IPIPE
+	.move		= move_apic_irq,
+#endif
 #endif
 	.retrigger	= ioapic_retrigger_irq,
 };
Index: b/include/asm-x86/ipipe_64.h
===================================================================
--- a/include/asm-x86/ipipe_64.h
+++ b/include/asm-x86/ipipe_64.h
@@ -135,6 +135,17 @@ static inline void __ipipe_call_root_vir
 			     : /* no input */);
 }
 
+#ifdef CONFIG_SMP
+#define __ipipe_move_root_irq(irq)					\
+	do {								\
+		struct irq_chip *chip = irq_desc[irq].chip;		\
+		if (irq < NR_IRQS && chip->move)			\
+			chip->move(irq);				\
+	} while (0)
+#else /* !CONFIG_SMP */
+#define __ipipe_move_root_irq(irq)	do { } while (0)
+#endif /* !CONFIG_SMP */
+
 /*
  * When running handlers, enable hw interrupts for all domains but the
  * one heading the pipeline, so that IRQs can never be significantly
@@ -144,10 +155,11 @@ static inline void __ipipe_call_root_vir
 	do {								\
 		local_irq_enable_nohead(ipd);				\
 		if (ipd == ipipe_root_domain) {				\
-			if (likely(!ipipe_virtual_irq_p(irq)))		\
+			if (likely(!ipipe_virtual_irq_p(irq))) {	\
+				__ipipe_move_root_irq(irq);		\
 				__ipipe_call_root_xirq_handler(		\
 					irq, (ipd)->irqs[irq].handler);	\
-			else						\
+			} else						\
 				__ipipe_call_root_virq_handler(		\
 					irq, (ipd)->irqs[irq].handler,	\
 					(ipd)->irqs[irq].cookie);	\
Index: b/include/linux/irq.h
===================================================================
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -111,6 +111,9 @@ struct irq_chip {
 
 	void		(*end)(unsigned int irq);
 	void		(*set_affinity)(unsigned int irq, cpumask_t dest);
+#ifdef CONFIG_IPIPE
+	void		(*move)(unsigned int irq);
+#endif /* CONFIG_IPIPE */
 	int		(*retrigger)(unsigned int irq);
 	int		(*set_type)(unsigned int irq, unsigned int flow_type);
 	int		(*set_wake)(unsigned int irq, unsigned int on);
-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

