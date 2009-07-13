Message-ID: <4A5B2553.2050705@domain.hid>
Date: Mon, 13 Jul 2009 14:15:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 3/3] 2.6.29-x86: Fix switch_mm atomicity
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Implement ipipe_mm_switch_protect via IRQ disabling and wrap further
arch-specific code path around switch_mm that require atomicity. This
patch provides __switch_mm as an unprotected alternative when it needs
to be called from already atomic contexts. Furthermore, instrument
__switch_mm so that we will detect any unprotected invocation in the
future.

This patch, together with its no-arch foundation, fixes subtle mm
corruptions seen on x86 SMP boxes under heavy RT/non-RT load.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 arch/x86/include/asm/mmu_context.h |   25 +++++++++++++++++++------
 arch/x86/mm/tlb.c                  |    4 ++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 63454a0..4b7020f 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -30,11 +30,14 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 #endif
 }
 
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-			     struct task_struct *tsk)
+static inline void __switch_mm(struct mm_struct *prev, struct mm_struct *next,
+			       struct task_struct *tsk)
 {
 	unsigned cpu = smp_processor_id();
 
+#ifdef CONFIG_IPIPE_DEBUG_INTERNAL
+	WARN_ON_ONCE(!irqs_disabled_hw());
+#endif
 	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
@@ -70,13 +73,23 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #endif
 }
 
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+			     struct task_struct *tsk)
+{
+	unsigned long flags;
+	local_irq_save_hw_cond(flags);
+	__switch_mm(prev, next, tsk);
+	local_irq_restore_hw_cond(flags);
+}
+
+#define ipipe_mm_switch_protect(flags)	local_irq_save_hw_cond(flags)
+#define ipipe_mm_switch_unprotect(flags) \
+	local_irq_restore_hw_cond(flags)
+
 #define activate_mm(prev, next)			\
 do {						\
- 	unsigned long flags;			\
 	paravirt_activate_mm((prev), (next));	\
- 	local_irq_save_hw_cond(flags);		\
-	switch_mm((prev), (next), NULL);	\
- 	local_irq_restore_hw_cond(flags);	\
+	__switch_mm((prev), (next), NULL);	\
 } while (0);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 06bd681..9294287 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -57,10 +57,14 @@ static union smp_flush_state flush_state[NUM_INVALIDATE_TLB_VECTORS];
  */
 void leave_mm(int cpu)
 {
+	unsigned long flags;
+
 	if (percpu_read(cpu_tlbstate.state) == TLBSTATE_OK)
 		BUG();
+	local_irq_save_hw_cond(flags);
 	cpu_clear(cpu, percpu_read(cpu_tlbstate.active_mm)->cpu_vm_mask);
 	load_cr3(swapper_pg_dir);
+	local_irq_restore_hw_cond(flags);
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 

