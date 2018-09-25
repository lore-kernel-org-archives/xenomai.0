From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:27:08 +0200
Message-Id: <20180925102716.4492-4-rpm@xenomai.org>
In-Reply-To: <20180925102716.4492-1-rpm@xenomai.org>
References: <20180925102716.4492-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 03/11] arm64: ipipe: share context switch code
 with the head domain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This change enable a co-kernel to change the address space of a task
using the common mm helpers. This is mainly a matter of strictly
serializing context switching code among all callers regardless of
their domain (head/root), by disabling hard irqs.
---
 arch/arm64/include/asm/mmu_context.h | 27 ++++++++++++++++++++++++++-
 arch/arm64/kernel/entry.S            | 24 +++++++++++++++++++++++-
 arch/arm64/kernel/ipipe.c            |  7 +++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 779d7a2ec5ec..8c5fcf3f4f0f 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -30,6 +30,7 @@
 #include <asm/cpufeature.h>
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
+#include <asm-generic/ipipe.h>
 #include <asm/cputype.h>
 #include <asm/pgtable.h>
 #include <asm/sysreg.h>
@@ -57,9 +58,13 @@ static inline void cpu_set_reserved_ttbr0(void)
 
 static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
 {
+	unsigned long flags;
+
 	BUG_ON(pgd == swapper_pg_dir);
+	flags = hard_cond_local_irq_save();
 	cpu_set_reserved_ttbr0();
 	cpu_do_switch_mm(virt_to_phys(pgd),mm);
+	hard_cond_local_irq_restore(flags);
 }
 
 /*
@@ -211,7 +216,7 @@ static inline void __switch_mm(struct mm_struct *next)
 }
 
 static inline void
-switch_mm(struct mm_struct *prev, struct mm_struct *next,
+do_switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	  struct task_struct *tsk)
 {
 	if (prev != next)
@@ -226,9 +231,29 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	update_saved_ttbr0(tsk, next);
 }
 
+static inline void
+switch_mm(struct mm_struct *prev, struct mm_struct *next,
+	  struct task_struct *tsk)
+{
+	unsigned long flags;
+
+	flags = hard_cond_local_irq_save();
+	do_switch_mm(prev, next, tsk);
+	hard_cond_local_irq_restore(flags);
+}
+
 #define deactivate_mm(tsk,mm)	do { } while (0)
 #define activate_mm(prev,next)	switch_mm(prev, next, current)
 
+#ifdef CONFIG_IPIPE
+static inline void
+ipipe_switch_mm_head(struct mm_struct *prev, struct mm_struct *next,
+			   struct task_struct *tsk)
+{
+	do_switch_mm(prev, next, tsk);
+}
+#endif
+
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 75e52672914a..2599926f00cd 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -372,6 +372,21 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 	.macro	irq_stack_entry
 	mov	x19, sp			// preserve the original sp
 
+#ifdef CONFIG_IPIPE
+	/*
+	 * When the pipeline is enabled, context switches over the irq
+	 * stack are allowed (for the co-kernel), and more interrupts
+	 * can be taken over sibling stack contexts. So we need a not so
+	 * subtle way of figuring out whether the irq stack was actually
+	 * exited, which cannot depend on the current task pointer.
+	 */
+	adr_this_cpu x25, irq_nesting, x26
+	ldr	w26, [x25]
+	cmp	w26, #0
+	add	w26, w26, #1
+	str	w26, [x25]
+	b.ne	9998f
+#else
 	/*
 	 * Compare sp with the base of the task stack.
 	 * If the top ~(THREAD_SIZE - 1) bits match, we are on a task stack,
@@ -381,6 +396,7 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 	eor	x25, x25, x19
 	and	x25, x25, #~(THREAD_SIZE - 1)
 	cbnz	x25, 9998f
+#endif
 
 	ldr_this_cpu x25, irq_stack_ptr, x26
 	mov	x26, #IRQ_STACK_SIZE
@@ -393,10 +409,16 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 
 	/*
 	 * x19 should be preserved between irq_stack_entry and
-	 * irq_stack_exit.
+	 * irq_stack_exit. I-pipe: have to preserve w0 too.
 	 */
 	.macro	irq_stack_exit
 	mov	sp, x19
+#ifdef CONFIG_IPIPE
+	adr_this_cpu x1, irq_nesting, x2
+	ldr	w2, [x1]
+	add	w2, w2, #-1
+	str	w2, [x1]
+#endif
 	.endm
 
 /*
diff --git a/arch/arm64/kernel/ipipe.c b/arch/arm64/kernel/ipipe.c
index 9c0e5913905f..f7d5e0ab8943 100644
--- a/arch/arm64/kernel/ipipe.c
+++ b/arch/arm64/kernel/ipipe.c
@@ -53,6 +53,9 @@
 
 static void __ipipe_do_IRQ(unsigned irq, void *cookie);
 
+/* irq_nesting tracks the interrupt nesting level for a CPU. */
+DEFINE_PER_CPU(int, irq_nesting);
+
 #ifdef CONFIG_IPIPE_DEBUG_INTERNAL
 void (*__ipipe_mach_hrtimer_debug)(unsigned irq);
 #endif
@@ -237,6 +240,10 @@ void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
 
 EXPORT_SYMBOL_GPL(do_munmap);
 EXPORT_SYMBOL_GPL(show_stack);
+EXPORT_SYMBOL_GPL(init_mm);
+#ifndef MULTI_CPU
+EXPORT_SYMBOL_GPL(cpu_do_switch_mm);
+#endif
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 EXPORT_SYMBOL_GPL(tasklist_lock);
 #endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
-- 
2.14.4


