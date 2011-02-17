Message-ID: <4D5D3629.5040705@domain.hid>
Date: Thu, 17 Feb 2011 15:52:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] ipipe: x86: Rework and fix vector to IRQ
	translation
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Depending on the configuration and hardware, the kernel may allocate
device IRQs in the range above our static FIRST_SYSTEM_VECTOR. This
happens quickly with a non-trivial number of MSI-X capable devices.

Fix this and also optimize the critical vector->IRQ translation by
filling the kernel's per-CPU vector_irq table also with I-pipe
translations.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/include/asm/ipipe_base.h |    6 ++++++
 arch/x86/kernel/apic/io_apic.c    |    1 +
 arch/x86/kernel/ipipe.c           |   30 +++++++++++++++++-------------
 arch/x86/kernel/irqinit.c         |    1 +
 arch/x86/platform/uv/tlb_uv.c     |    5 +++++
 5 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/ipipe_base.h b/arch/x86/include/asm/ipipe_base.h
index 44c8c73..f28ca74 100644
--- a/arch/x86/include/asm/ipipe_base.h
+++ b/arch/x86/include/asm/ipipe_base.h
@@ -211,6 +211,12 @@ void __ipipe_halt_root(void);
 
 void __ipipe_serial_debug(const char *fmt, ...);
 
+#ifdef CONFIG_IPIPE
+void ipipe_init_vector_irq(int cpu);
+#else
+static inline void ipipe_init_vector_irq(int cpu) { }
+#endif
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif	/* !__X86_IPIPE_BASE_H */
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index fa599db..8eaaadc 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1205,6 +1205,7 @@ void __setup_vector_irq(int cpu)
 		if (!cpumask_test_cpu(cpu, cfg->domain))
 			per_cpu(vector_irq, cpu)[vector] = -1;
 	}
+	ipipe_init_vector_irq(cpu);
 	raw_spin_unlock(&vector_lock);
 }
 
diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index d1d4544..4e180db 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -141,6 +141,19 @@ static void __ipipe_null_handler(unsigned irq, void *cookie)
 /* __ipipe_enable_pipeline() -- We are running on the boot CPU, hw
    interrupts are off, and secondary CPUs are still lost in space. */
 
+void ipipe_init_vector_irq(int cpu)
+{
+	unsigned int vector;
+
+	per_cpu(vector_irq, cpu)[IRQ_MOVE_CLEANUP_VECTOR] =
+		IRQ_MOVE_CLEANUP_VECTOR;
+
+	for (vector = first_system_vector; vector < NR_VECTORS; vector++)
+		if (per_cpu(vector_irq, cpu)[vector] == -1)
+			per_cpu(vector_irq, cpu)[vector] =
+				ipipe_apic_vector_irq(vector);
+}
+
 void __init __ipipe_enable_pipeline(void)
 {
 	unsigned int vector, irq;
@@ -685,23 +698,14 @@ int __ipipe_syscall_root(struct pt_regs *regs)
 int __ipipe_handle_irq(struct pt_regs *regs)
 {
 	struct ipipe_domain *this_domain, *next_domain;
-	unsigned int vector = regs->orig_ax, irq;
+	int irq, vector = regs->orig_ax;
 	struct list_head *head, *pos;
 	struct pt_regs *tick_regs;
 	int m_ack;
 
-	if ((long)regs->orig_ax < 0) {
-		vector = ~vector;
-#ifdef CONFIG_X86_LOCAL_APIC
-		if (vector >= FIRST_SYSTEM_VECTOR)
-			irq = ipipe_apic_vector_irq(vector);
-#ifdef CONFIG_SMP
-		else if (vector == IRQ_MOVE_CLEANUP_VECTOR)
-			irq = vector;
-#endif /* CONFIG_SMP */
-		else
-#endif /* CONFIG_X86_LOCAL_APIC */
-			irq = __get_cpu_var(vector_irq)[vector];
+	if (vector < 0) {
+		irq = __get_cpu_var(vector_irq)[~vector];
+		BUG_ON(irq < 0);
 		m_ack = 0;
 	} else { /* This is a self-triggered one. */
 		irq = vector;
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 699fb0e..8aff110 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -232,6 +232,7 @@ static void __init apic_intr_init(void)
 	alloc_intr_gate(IPIPE_SERVICE_VECTOR2, ipipe_ipi2);
 	alloc_intr_gate(IPIPE_SERVICE_VECTOR3, ipipe_ipi3);
 #endif
+	ipipe_init_vector_irq(0);
 #endif
 }
 
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index ba9caa8..99cef66 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -1640,6 +1640,11 @@ static int __init uv_bau_init(void)
 
 	uv_enable_timeouts();
 	alloc_intr_gate(vector, uv_bau_message_intr1);
+#ifdef CONFIG_IPIPE
+	for_each_possible_cpu(cur_cpu)
+		per_cpu(vector_irq, cur_cpu)[vector] =
+			ipipe_apic_vector_irq(vector);
+#endif
 
 	for_each_possible_blade(uvhub) {
 		if (uv_blade_nr_possible_cpus(uvhub)) {
-- 
1.7.1

