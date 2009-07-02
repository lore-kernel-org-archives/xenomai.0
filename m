Message-ID: <4A4CEB11.6020608@domain.hid>
Date: Thu, 02 Jul 2009 19:14:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A48FB71.6070506@domain.hid>
In-Reply-To: <4A48FB71.6070506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] x86: Endless minor faults
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Hi again,

this is now basically the patch which seems to stabilized x86 /wrt mmu
switches again:

There were 3 race windows between setting active_mm of the current task
and actually switching it (that's a noarch issue), there were several
calls into switch_mm without proper hard interrupt protection (on archs
that have no preemptible switch_mm, like x86) and there was a race in
x86's leave_mm (as Gilles already remarked earlier in this thread -
while I was looking at an old tree where smp_invalidate_interrupt took
care of this).

The patch is thought as a basis for further discussions about

 o how to solve all the issues for all archs technically (ideally
   without the need to patch noarch parts in an arch-specific way...)

 o if anyone thinks there could be more spots like these (I've checked
   the code only for x86 so far)

Jan

-------->

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index dddfb84..d261b77 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -29,12 +29,17 @@ void destroy_context(struct mm_struct *mm);
 
 #define activate_mm(prev, next)			\
 do {						\
- 	unsigned long flags;			\
 	paravirt_activate_mm((prev), (next));	\
- 	local_irq_save_hw_cond(flags);		\
-	switch_mm((prev), (next), NULL);	\
- 	local_irq_restore_hw_cond(flags);	\
+	__switch_mm((prev), (next), NULL);	\
 } while (0);
 
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+			     struct task_struct *tsk)
+{
+	unsigned long flags;
+	local_irq_save_hw_cond(flags);
+	__switch_mm(prev, next, tsk);
+	local_irq_restore_hw_cond(flags);
+}
 
 #endif /* _ASM_X86_MMU_CONTEXT_H */
diff --git a/arch/x86/include/asm/mmu_context_32.h b/arch/x86/include/asm/mmu_context_32.h
index 7e98ce1..e51cd09 100644
--- a/arch/x86/include/asm/mmu_context_32.h
+++ b/arch/x86/include/asm/mmu_context_32.h
@@ -9,12 +9,13 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 #endif
 }
 
-static inline void switch_mm(struct mm_struct *prev,
-			     struct mm_struct *next,
-			     struct task_struct *tsk)
+static inline void __switch_mm(struct mm_struct *prev,
+			       struct mm_struct *next,
+			       struct task_struct *tsk)
 {
 	int cpu = smp_processor_id();
 
+	WARN_ON_ONCE(!irqs_disabled_hw());
 	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
diff --git a/arch/x86/include/asm/mmu_context_64.h b/arch/x86/include/asm/mmu_context_64.h
index 677d36e..0118200 100644
--- a/arch/x86/include/asm/mmu_context_64.h
+++ b/arch/x86/include/asm/mmu_context_64.h
@@ -11,10 +11,12 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 #endif
 }
 
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-			     struct task_struct *tsk)
+static inline void __switch_mm(struct mm_struct *prev, struct mm_struct *next,
+			       struct task_struct *tsk)
 {
 	unsigned cpu = smp_processor_id();
+
+	WARN_ON_ONCE(!irqs_disabled_hw());
 	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
diff --git a/arch/x86/kernel/tlb_32.c b/arch/x86/kernel/tlb_32.c
index 08028a7..f68f2a6 100644
--- a/arch/x86/kernel/tlb_32.c
+++ b/arch/x86/kernel/tlb_32.c
@@ -34,9 +34,13 @@ static DEFINE_SPINLOCK(tlbstate_lock);
  */
 void leave_mm(int cpu)
 {
+	unsigned long flags;
+
 	BUG_ON(x86_read_percpu(cpu_tlbstate.state) == TLBSTATE_OK);
+	local_irq_save_hw_cond(flags);
 	cpu_clear(cpu, x86_read_percpu(cpu_tlbstate.active_mm)->cpu_vm_mask);
 	load_cr3(swapper_pg_dir);
+	local_irq_restore_hw_cond(flags);
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
diff --git a/arch/x86/kernel/tlb_64.c b/arch/x86/kernel/tlb_64.c
index ce54e12..9829990 100644
--- a/arch/x86/kernel/tlb_64.c
+++ b/arch/x86/kernel/tlb_64.c
@@ -62,10 +62,14 @@ static DEFINE_PER_CPU(union smp_flush_state, flush_state);
  */
 void leave_mm(int cpu)
 {
+	unsigned long flags;
+
 	if (read_pda(mmu_state) == TLBSTATE_OK)
 		BUG();
+	local_irq_save_hw_cond(flags);
 	cpu_clear(cpu, read_pda(active_mm)->cpu_vm_mask);
 	load_cr3(swapper_pg_dir);
+	local_irq_restore_hw_cond(flags);
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
diff --git a/fs/aio.c b/fs/aio.c
index 76da125..0286f0f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -618,13 +618,16 @@ static void use_mm(struct mm_struct *mm)
 {
 	struct mm_struct *active_mm;
 	struct task_struct *tsk = current;
+	unsigned long flags;
 
 	task_lock(tsk);
 	active_mm = tsk->active_mm;
 	atomic_inc(&mm->mm_count);
 	tsk->mm = mm;
+	local_irq_save_hw_cond(flags);
 	tsk->active_mm = mm;
-	switch_mm(active_mm, mm, tsk);
+	__switch_mm(active_mm, mm, tsk);
+	local_irq_restore_hw_cond(flags);
 	task_unlock(tsk);
 
 	mmdrop(active_mm);
diff --git a/fs/exec.c b/fs/exec.c
index 3b36c69..06591ac 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -718,6 +718,7 @@ static int exec_mmap(struct mm_struct *mm)
 {
 	struct task_struct *tsk;
 	struct mm_struct * old_mm, *active_mm;
+	unsigned long flags;
 
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
@@ -740,8 +741,10 @@ static int exec_mmap(struct mm_struct *mm)
 	task_lock(tsk);
 	active_mm = tsk->active_mm;
 	tsk->mm = mm;
+	local_irq_save_hw_cond(flags);
 	tsk->active_mm = mm;
 	activate_mm(active_mm, mm);
+	local_irq_restore_hw_cond(flags);
 	task_unlock(tsk);
 	arch_pick_mmap_layout(mm);
 	if (old_mm) {
diff --git a/kernel/fork.c b/kernel/fork.c
index 01a836b..cf3b68a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1665,11 +1665,14 @@ SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
 		}
 
 		if (new_mm) {
+			unsigned long flags;
 			mm = current->mm;
 			active_mm = current->active_mm;
 			current->mm = new_mm;
+			local_irq_save_hw_cond(flags);
 			current->active_mm = new_mm;
 			activate_mm(active_mm, new_mm);
+			local_irq_restore_hw_cond(flags);
 			new_mm = mm;
 		}
  

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

