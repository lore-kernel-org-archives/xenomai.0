From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:46 +0200
Message-Id: <20180925103809.4932-10-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 09/32] x86: ipipe: share context switch code with
 head domain
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
 arch/x86/include/asm/mmu_context.h |  6 +++++-
 arch/x86/kernel/process.c          | 10 +++++++++-
 arch/x86/kernel/process_32.c       |  7 ++++---
 arch/x86/kernel/process_64.c       |  2 +-
 arch/x86/mm/tlb.c                  | 14 ++++++++++----
 5 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index ed97ef3b48a7..7c63c59165c9 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -177,7 +177,8 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 		load_mm_ldt(next);
 #endif
 
-	DEBUG_LOCKS_WARN_ON(preemptible());
+	DEBUG_LOCKS_WARN_ON(preemptible() &&
+			(!IS_ENABLED(CONFIG_IPIPE) || !hard_irqs_disabled()));
 }
 
 void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
@@ -213,6 +214,9 @@ extern void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			       struct task_struct *tsk);
 #define switch_mm_irqs_off switch_mm_irqs_off
 
+#define ipipe_switch_mm_head(prev, next, tsk) \
+	switch_mm_irqs_off(prev, next, tsk)
+
 #define activate_mm(prev, next)			\
 do {						\
 	paravirt_activate_mm((prev), (next));	\
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 705335bea02a..fab78995ba61 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -114,8 +114,16 @@ void exit_thread(struct task_struct *tsk)
 	if (bp) {
 		struct tss_struct *tss = &per_cpu(cpu_tss_rw, get_cpu());
 
-		t->io_bitmap_ptr = NULL;
+		/*
+		 * The caller may be preempted via I-pipe: to make
+		 * sure TIF_IO_BITMAP always denotes a valid I/O
+		 * bitmap when set, we clear it _before_ the I/O
+		 * bitmap pointer. No cache coherence issue ahead as
+		 * migration is currently locked (the primary domain
+		 * may never migrate either).
+		 */
 		clear_thread_flag(TIF_IO_BITMAP);
+		t->io_bitmap_ptr = NULL;
 		/*
 		 * Careful, clear this in the TSS too:
 		 */
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5224c6099184..2bada263542c 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -233,12 +233,13 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 			     *next = &next_p->thread;
 	struct fpu *prev_fpu = &prev->fpu;
 	struct fpu *next_fpu = &next->fpu;
-	int cpu = smp_processor_id();
+	int cpu = raw_smp_processor_id();
 	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
+	int slope = ipipe_get_domain_slope_hook(prev_p, next_p);
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
-	switch_fpu_prepare(prev_fpu, cpu);
+	switch_fpu_prepare(prev_fpu, cpu, slot);
 
 	/*
 	 * Save away %gs. No need to save %fs, as it was saved on the
@@ -299,7 +300,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (prev->gs | next->gs)
 		lazy_load_gs(next->gs);
 
-	switch_fpu_finish(next_fpu, cpu);
+	switch_fpu_finish(next_fpu, cpu, slope);
 
 	this_cpu_write(current_task, next_p);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index cbeecfcc66d6..934738d86deb 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -399,7 +399,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	struct thread_struct *next = &next_p->thread;
 	struct fpu *prev_fpu = &prev->fpu;
 	struct fpu *next_fpu = &next->fpu;
-	int cpu = smp_processor_id();
+	int cpu = raw_smp_processor_id();
 	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 83a3f4c935fc..6c9b4b8002f9 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -147,9 +147,9 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	switch_mm_irqs_off(prev, next, tsk);
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 static void sync_current_stack_to_mm(struct mm_struct *mm)
@@ -185,7 +185,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	unsigned cpu = smp_processor_id();
+	unsigned cpu = raw_smp_processor_id();
 	u64 next_tlb_gen;
 
 	/*
@@ -197,8 +197,11 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
 	 */
 
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_IPIPE_DEBUG_INTERNAL) &&
+		     !hard_irqs_disabled());
+
 	/* We don't want flush_tlb_func_* to run concurrently with us. */
-	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
+	if (!IS_ENABLED(CONFIG_IPIPE) && IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(!irqs_disabled());
 
 	/*
@@ -439,6 +442,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 	u64 mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
 	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	unsigned long flags;
 
 	/* This code cannot presently handle being reentered. */
 	VM_WARN_ON(!irqs_disabled());
@@ -456,7 +460,9 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * garbage into our TLB.  Since switching to init_mm is barely
 		 * slower than a minimal flush, just switch to init_mm.
 		 */
+		flags = hard_cond_local_irq_save();
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
+		hard_cond_local_irq_restore(flags);
 		return;
 	}
 
-- 
2.14.4


