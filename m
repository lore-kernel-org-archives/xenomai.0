From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/6] x86/ipipe: fix chained irq handling
Date: Mon,  7 Sep 2020 15:09:35 +0200
Message-Id: <20200907130938.416831-3-rpm@xenomai.org>
In-Reply-To: <20200907130938.416831-1-rpm@xenomai.org>
References: <20200907130938.416831-1-rpm@xenomai.org>
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

IRQs chained from a parent interrupt (e.g. cascaded interrupts from
chained GPIO irqchips) do not have any assigned vector. Therefore, we
cannot expect __ipipe_get_ioapic_irq_vector() to return anything
sensible for those chained IRQs.

As a result, the interrupt trampoline (__ipipe_do_IRQ()) for the root
stage cannot fix up regs->orig_ax with the proper vector number which
do_IRQ() would use in turn to fetch the corresponding interrupt
descriptor.

Since we already know the IRQ number on entry to __ipipe_do_IRQ(),
rewrite the latter as a variant of do_IRQ() which either retrieves the
descriptor using irq_to_desc() for all device interrupts in order to
fetch the flow handler, or invokes the naked handler of special APIC
vectors directly.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/x86/kernel/ipipe.c  | 13 ++-----------
 arch/x86/kernel/irq_64.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 4b0955c3ff49..3f3afcecc1b9 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -73,6 +73,8 @@ void smp_reboot_interrupt(void);
 void smp_thermal_interrupt(struct pt_regs *regs);
 void smp_threshold_interrupt(struct pt_regs *regs);
 
+void __ipipe_do_IRQ(unsigned int irq, void *cookie);
+
 DEFINE_PER_CPU(unsigned long, __ipipe_cr2);
 EXPORT_PER_CPU_SYMBOL_GPL(__ipipe_cr2);
 
@@ -88,17 +90,6 @@ int ipipe_get_sysinfo(struct ipipe_sysinfo *info)
 }
 EXPORT_SYMBOL_GPL(ipipe_get_sysinfo);
 
-static void __ipipe_do_IRQ(unsigned int irq, void *cookie)
-{
-	void (*handler)(struct pt_regs *regs);
-	struct pt_regs *regs;
-
-	regs = raw_cpu_ptr(&ipipe_percpu.tick_regs);
-	regs->orig_ax = ~__ipipe_get_irq_vector(irq);
-	handler = (typeof(handler))cookie;
-	handler(regs);
-}
-
 #ifdef CONFIG_X86_LOCAL_APIC
 
 static void __ipipe_noack_apic(struct irq_desc *desc)
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index b2b2a3f41daf..7fc8ad19940c 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -89,3 +89,32 @@ bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 	generic_handle_irq_desc(desc);
 	return true;
 }
+
+#ifdef CONFIG_IPIPE
+
+void __ipipe_do_IRQ(unsigned int irq, void *cookie)
+{
+	struct pt_regs *regs = raw_cpu_ptr(&ipipe_percpu.tick_regs);
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	unsigned int (*handler)(struct pt_regs *regs);
+	struct irq_desc *desc;
+
+	handler = (typeof(handler))cookie;
+
+	entering_irq();
+
+	stack_overflow_check(regs);
+
+	if (handler == do_IRQ) {
+		desc = irq_to_desc(irq);
+		generic_handle_irq_desc(desc);
+	} else {
+		handler(regs);
+	}
+
+	exiting_irq();
+
+	set_irq_regs(old_regs);
+}
+
+#endif
-- 
2.26.2


