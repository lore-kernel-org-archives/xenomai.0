Message-ID: <47B1A83B.5080506@domain.hid>
Date: Tue, 12 Feb 2008 15:07:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47B09475.8030602@domain.hid>
In-Reply-To: <47B09475.8030602@domain.hid>
Content-Type: multipart/mixed; boundary="------------090209030900080801040105"
Subject: Re: [Xenomai-core] [PATCHES] LTTng for Xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090209030900080801040105
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> [Steven, I promised you this tool earlier, and now it runs. It /may/
> help to understand some of your problems, at least it should give an
> overview of your schedule...]
> 
> 
> This is an update on how to get latest LTTng running with latest Xenomai!
> 

Just realized that the final patch suffered from a dependency on some
not-yet-merged cleanup patch from my queue. Here is a refreshed version
for vanilla.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------090209030900080801040105
Content-Type: text/x-patch;
 name="lttng-ipipe-2.6.24-x86-2.0-03.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lttng-ipipe-2.6.24-x86-2.0-03.patch"

---
 arch/x86/kernel/Makefile_64 |    2 
 arch/x86/kernel/ipipe.c     |    5 --
 include/linux/ipipe.h       |    3 -
 include/linux/kernel.h      |    1 
 kernel/exit.c               |    1 
 kernel/marker.c             |   12 ++--
 kernel/sched.c              |   63 +++++++++++++++++++++++++
 ltt/ltt-relay.c             |    2 
 ltt/ltt-serialize.c         |   12 ++--
 mm/memory.c                 |  108 ++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 191 insertions(+), 18 deletions(-)

Index: b/arch/x86/kernel/Makefile_64
===================================================================
--- a/arch/x86/kernel/Makefile_64
+++ b/arch/x86/kernel/Makefile_64
@@ -36,6 +36,8 @@ obj-$(CONFIG_X86_VSMP)		+= vsmp_64.o
 obj-$(CONFIG_K8_NB)		+= k8.o
 obj-$(CONFIG_AUDIT)		+= audit_64.o
 obj-$(CONFIG_IMMEDIATE)		+= immediate.o
+obj-$(CONFIG_IPIPE)		+= ipipe.o
+obj-$(CONFIG_IPIPE_TRACE_MCOUNT)	+= mcount_64.o
 
 obj-$(CONFIG_MODULES)		+= module_64.o
 obj-$(CONFIG_PCI)		+= early-quirks.o
Index: b/arch/x86/kernel/ipipe.c
===================================================================
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -987,7 +987,6 @@ EXPORT_SYMBOL(ipipe_critical_exit);
 EXPORT_SYMBOL(ipipe_trigger_irq);
 EXPORT_SYMBOL(ipipe_get_sysinfo);
 
-EXPORT_SYMBOL_GPL(irq_desc);
 struct task_struct *__switch_to(struct task_struct *prev_p,
 				struct task_struct *next_p);
 EXPORT_SYMBOL_GPL(__switch_to);
@@ -1002,10 +1001,6 @@ EXPORT_PER_CPU_SYMBOL_GPL(cpu_tlbstate);
 EXPORT_SYMBOL_GPL(cpu_gdt_descr);
 #endif /* !CONFIG_X86_32 */
 
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-EXPORT_SYMBOL(tasklist_lock);
-#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
-
 #ifdef CONFIG_IPIPE_TRACE_MCOUNT
 void notrace mcount(void);
 EXPORT_SYMBOL(mcount);
Index: b/include/linux/ipipe.h
===================================================================
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -535,7 +535,8 @@ static inline void local_irq_restore_nos
 #define ipipe_irq_unlock(irq)		do { } while(0)
 
 #define ipipe_root_domain_p		1
-#define ipipe_safe_current		current
+#define ipipe_processor_id()		smp_processor_id()
+#define ipipe_safe_current()		current
 
 #define local_irq_disable_head()	local_irq_disable()
 
Index: b/include/linux/kernel.h
===================================================================
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/marker.h>
+#include <linux/ipipe_base.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
Index: b/kernel/exit.c
===================================================================
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1000,6 +1000,7 @@ fastcall NORET_TYPE void do_exit(long co
 		acct_process();
 	trace_mark(kernel_process_exit, "pid %d", tsk->pid);
 
+	ipipe_exit_notify(tsk);
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
Index: b/kernel/sched.c
===================================================================
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -7484,3 +7484,66 @@ end:
 	mutex_unlock(&kernel_trace_mutex);
 }
 EXPORT_SYMBOL_GPL(set_kernel_trace_flag_all_tasks);
+
+#ifdef CONFIG_IPIPE
+
+int ipipe_setscheduler_root (struct task_struct *p, int policy, int prio)
+{
+	int oldprio, on_rq, running;
+	unsigned long flags;
+	struct rq *rq;
+
+	spin_lock_irqsave(&p->pi_lock, flags);
+	rq = __task_rq_lock(p);
+	update_rq_clock(rq);
+	on_rq = p->se.on_rq;
+	running = task_running(rq, p);
+
+	if (on_rq) {
+		deactivate_task(rq, p, 0);
+		if (running)
+			p->sched_class->put_prev_task(rq, p);
+	}
+
+	oldprio = p->prio;
+	__setscheduler(rq, p, policy, prio);
+	ipipe_setsched_notify(p);
+
+	if (on_rq) {
+		if (running)
+			p->sched_class->set_curr_task(rq);
+		activate_task(rq, p, 0);
+
+		if (running) {
+			if (p->prio > oldprio)
+				resched_task(rq->curr);
+		} else {
+			check_preempt_curr(rq, p);
+		}
+	}
+	__task_rq_unlock(rq);
+	spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	rt_mutex_adjust_pi(p);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(ipipe_setscheduler_root);
+
+int ipipe_reenter_root (struct task_struct *prev, int policy, int prio)
+{
+	finish_task_switch(this_rq(), prev);
+
+	(void)reacquire_kernel_lock(current);
+	preempt_enable_no_resched();
+
+	if (current->policy != policy || current->rt_priority != prio)
+		return ipipe_setscheduler_root(current, policy, prio);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(ipipe_reenter_root);
+
+#endif /* CONFIG_IPIPE */
Index: b/ltt/ltt-relay.c
===================================================================
--- a/ltt/ltt-relay.c
+++ b/ltt/ltt-relay.c
@@ -1012,7 +1012,7 @@ static void *ltt_relay_reserve_slot(stru
 	/*
 	 * Perform retryable operations.
 	 */
-	if (ltt_nesting[smp_processor_id()] > 4) {
+	if (ltt_nesting[ipipe_processor_id()] > 4) {
 		local_inc(&ltt_buf->events_lost);
 		return NULL;
 	}
Index: b/ltt/ltt-serialize.c
===================================================================
--- a/ltt/ltt-serialize.c
+++ b/ltt/ltt-serialize.c
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/ipipe_base.h>
 #include <linux/ltt-tracer.h>
 
 enum ltt_type {
@@ -625,6 +626,7 @@ void ltt_vtrace(void *probe_data, void *
 	u32 compact_data = 0;
 	void *serialize_private = NULL;
 	int cpu;
+	unsigned long irqflags;
 
 	pdata = (struct ltt_active_marker *)probe_data;
 	if (unlikely(private_data && private_data->id < MARKER_CORE_IDS))
@@ -641,13 +643,13 @@ void ltt_vtrace(void *probe_data, void *
 		&& (!private_data || !private_data->force)))
 		return;
 
-	preempt_disable();
+	ipipe_preempt_disable(irqflags);
 	if (likely(!private_data || !private_data->force
 			|| private_data->cpu == -1))
-		cpu = smp_processor_id();
+		cpu = ipipe_processor_id();
 	else
 		cpu = private_data->cpu;
-	ltt_nesting[smp_processor_id()]++;
+	ltt_nesting[ipipe_processor_id()]++;
 
 	if (unlikely(private_data && private_data->trace))
 		dest_trace = private_data->trace;
@@ -707,8 +709,8 @@ void ltt_vtrace(void *probe_data, void *
 		/* Out-of-order commit */
 		ltt_commit_slot(channel, &transport_data, buffer, slot_size);
 	}
-	ltt_nesting[smp_processor_id()]--;
-	preempt_enable();
+	ltt_nesting[ipipe_processor_id()]--;
+	ipipe_preempt_enable(irqflags);
 }
 EXPORT_SYMBOL_GPL(ltt_vtrace);
 
Index: b/mm/memory.c
===================================================================
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -52,6 +52,7 @@
 #include <linux/writeback.h>
 #include <linux/kprobes.h>
 #include <linux/mutex.h>
+#include <linux/vmalloc.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -2852,3 +2853,110 @@ void __kprobes kernel_text_unlock(void)
 	mutex_unlock(&text_mutex);
 }
 EXPORT_SYMBOL_GPL(kernel_text_unlock);
+
+#ifdef CONFIG_IPIPE
+
+static inline int ipipe_pin_pte_range(struct mm_struct *mm, pmd_t *pmd,
+				      struct vm_area_struct *vma,
+				      unsigned long addr, unsigned long end)
+{
+	spinlock_t *ptl;
+	pte_t *pte;
+	
+	do {
+		pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+		if (!pte)
+			continue;
+
+		if (!pte_present(*pte)) {
+			pte_unmap_unlock(pte, ptl);
+			continue;
+		}
+
+		if (do_wp_page(mm, vma, addr, pte, pmd, ptl, *pte) == VM_FAULT_OOM)
+			return -ENOMEM;
+	} while (addr += PAGE_SIZE, addr != end);
+	return 0;
+}
+
+static inline int ipipe_pin_pmd_range(struct mm_struct *mm, pud_t *pud,
+				      struct vm_area_struct *vma,
+				      unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pmd_t *pmd;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		if (ipipe_pin_pte_range(mm, pmd, vma, addr, next))
+			return -ENOMEM;
+	} while (pmd++, addr = next, addr != end);
+	return 0;
+}
+
+static inline int ipipe_pin_pud_range(struct mm_struct *mm, pgd_t *pgd,
+				      struct vm_area_struct *vma,
+				      unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pud_t *pud;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		if (ipipe_pin_pmd_range(mm, pud, vma, addr, next))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr != end);
+	return 0;
+}
+
+int ipipe_disable_ondemand_mappings(struct task_struct *tsk)
+{
+	unsigned long addr, next, end;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	int result = 0;
+	pgd_t *pgd;
+
+	mm = get_task_mm(tsk);
+	if (!mm)
+		return -EPERM;
+
+	down_write(&mm->mmap_sem);
+	if (mm->def_flags & VM_PINNED)
+		goto done_mm;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		if (!is_cow_mapping(vma->vm_flags))
+			continue;
+
+		addr = vma->vm_start;
+		end = vma->vm_end;
+		
+		pgd = pgd_offset(mm, addr);
+		do {
+			next = pgd_addr_end(addr, end);
+			if (pgd_none_or_clear_bad(pgd))
+				continue;
+			if (ipipe_pin_pud_range(mm, pgd, vma, addr, next)) {
+				result = -ENOMEM;
+				goto done_mm;
+			}
+		} while (pgd++, addr = next, addr != end);
+	}
+	mm->def_flags |= VM_PINNED;
+
+  done_mm:
+	up_write(&mm->mmap_sem);
+	mmput(mm);
+	return result;
+}
+
+EXPORT_SYMBOL(ipipe_disable_ondemand_mappings);
+
+#endif
Index: b/kernel/marker.c
===================================================================
--- a/kernel/marker.c
+++ b/kernel/marker.c
@@ -103,14 +103,14 @@ void marker_probe_cb(const struct marker
 {
 	va_list args;
 	char ptype;
+	unsigned long irqflags;
 
 	/*
 	 * rcu_read_lock does two things : disabling preemption to make sure the
 	 * teardown of the callbacks can be done correctly when they are in
 	 * modules and they insure RCU read coherency.
 	 */
-	rcu_read_lock();
-	preempt_disable();
+	ipipe_preempt_disable(irqflags);
 	ptype = mdata->ptype;
 	if (likely(!ptype)) {
 		marker_probe_func *func;
@@ -143,8 +143,7 @@ void marker_probe_cb(const struct marker
 			va_end(args);
 		}
 	}
-	preempt_enable();
-	rcu_read_unlock();
+	ipipe_preempt_enable(irqflags);
 }
 EXPORT_SYMBOL_GPL(marker_probe_cb);
 
@@ -162,8 +161,9 @@ void marker_probe_cb_noarg(const struct 
 {
 	va_list args;	/* not initialized */
 	char ptype;
+	unsigned long irqflags;
 
-	preempt_disable();
+	ipipe_preempt_disable(irqflags);
 	ptype = mdata->ptype;
 	if (likely(!ptype)) {
 		marker_probe_func *func;
@@ -191,7 +191,7 @@ void marker_probe_cb_noarg(const struct 
 			multi[i].func(multi[i].probe_private, call_private, fmt,
 				&args);
 	}
-	preempt_enable();
+	ipipe_preempt_enable(irqflags);
 }
 EXPORT_SYMBOL_GPL(marker_probe_cb_noarg);
 

--------------090209030900080801040105--

