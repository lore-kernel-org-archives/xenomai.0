Message-ID: <47B09475.8030602@domain.hid>
Date: Mon, 11 Feb 2008 19:31:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080300030301060102010405"
Subject: [Xenomai-core] [PATCHES] LTTng for Xenomai
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
--------------080300030301060102010405
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

[Steven, I promised you this tool earlier, and now it runs. It /may/
help to understand some of your problems, at least it should give an
overview of your schedule...]


This is an update on how to get latest LTTng running with latest Xenomai!

For those who don't know what I'm talking about: LTTng [1] is an event
tracing framework for Linux. It is fairly light-weight during runtime,
its hooks into interesting spots of the system can easily be turned to
(almost) zero-overhead stubs when disabled. When enabled, the recorded
events are written to a log file and can later be analyzed with the help
of LTTV [1], a textual or graphical trace viewer.

Xenomai 2.4 already comes with the required instrumentation, all you
additionally need is a (fitting) set of LTTng patches + some minor
adjustments for the I-pipe environment.

This is what to do in order to marry LTTng with an I-pipe 2.6.24 kernel:
 - Download patch-2.6.24-lttng-0.10-pre43.tar.bz2 from [1]
 - Unpack it, move its folder as "patches" in your Xenomai/I-pipe
   kernel source tree
 - Copy the attached files into that "patches" folder as well
 - Use quilt to apply all required patches to your kernel (if ipipe was
   already applied, comment out the first line in "series")
 - Run prepare-kernel.sh if not done yet
 - Enable LTT in your config, rebuild, install, and boot the kernel

To use LTTng, you need the control tools (currently ltt-control-0.47)
and the related viewer (lttv-0.10.0-pre10 for this combination). Build
and install both.

Now on your target, run the following to enable LTTng tracing:
 1. ltt-armall
 2. lttctl -n trace -d -l /sys/kernel/debug/ltt -t /path/to/your/trace

After running your application, stop the trace and dump it
 1. lttctl -n trace -R
 2. lttv -m textDump -t /path/to/your/trace
    (or use lttv-gui, but text dumps are IMO easier to browse at the
     moment)

I'm looking forward to feedback and hope some of you gain interesting
insights into their systems. Feel free to share your findings here and
discus them with us - we may all benefit from this. :)

Jan

[1] http://ltt.polymtl.ca/

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------080300030301060102010405
Content-Type: text/x-patch;
 name="prepare-lttng.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prepare-lttng.patch"

---
 arch/x86/kernel/Makefile_64 |    2 
 include/linux/kernel.h      |    1 
 kernel/exit.c               |    1 
 kernel/sched.c              |   63 -------------------------
 mm/memory.c                 |  108 --------------------------------------------
 5 files changed, 175 deletions(-)

Index: b/mm/memory.c
===================================================================
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -50,7 +50,6 @@
 #include <linux/delayacct.h>
 #include <linux/init.h>
 #include <linux/writeback.h>
-#include <linux/vmalloc.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -2799,110 +2798,3 @@ int access_process_vm(struct task_struct
 
 	return buf - old_buf;
 }
-
-#ifdef CONFIG_IPIPE
-
-static inline int ipipe_pin_pte_range(struct mm_struct *mm, pmd_t *pmd,
-				      struct vm_area_struct *vma,
-				      unsigned long addr, unsigned long end)
-{
-	spinlock_t *ptl;
-	pte_t *pte;
-	
-	do {
-		pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
-		if (!pte)
-			continue;
-
-		if (!pte_present(*pte)) {
-			pte_unmap_unlock(pte, ptl);
-			continue;
-		}
-
-		if (do_wp_page(mm, vma, addr, pte, pmd, ptl, *pte) == VM_FAULT_OOM)
-			return -ENOMEM;
-	} while (addr += PAGE_SIZE, addr != end);
-	return 0;
-}
-
-static inline int ipipe_pin_pmd_range(struct mm_struct *mm, pud_t *pud,
-				      struct vm_area_struct *vma,
-				      unsigned long addr, unsigned long end)
-{
-	unsigned long next;
-	pmd_t *pmd;
-
-	pmd = pmd_offset(pud, addr);
-	do {
-		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
-			continue;
-		if (ipipe_pin_pte_range(mm, pmd, vma, addr, next))
-			return -ENOMEM;
-	} while (pmd++, addr = next, addr != end);
-	return 0;
-}
-
-static inline int ipipe_pin_pud_range(struct mm_struct *mm, pgd_t *pgd,
-				      struct vm_area_struct *vma,
-				      unsigned long addr, unsigned long end)
-{
-	unsigned long next;
-	pud_t *pud;
-
-	pud = pud_offset(pgd, addr);
-	do {
-		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
-			continue;
-		if (ipipe_pin_pmd_range(mm, pud, vma, addr, next))
-			return -ENOMEM;
-	} while (pud++, addr = next, addr != end);
-	return 0;
-}
-
-int ipipe_disable_ondemand_mappings(struct task_struct *tsk)
-{
-	unsigned long addr, next, end;
-	struct vm_area_struct *vma;
-	struct mm_struct *mm;
-	int result = 0;
-	pgd_t *pgd;
-
-	mm = get_task_mm(tsk);
-	if (!mm)
-		return -EPERM;
-
-	down_write(&mm->mmap_sem);
-	if (mm->def_flags & VM_PINNED)
-		goto done_mm;
-
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (!is_cow_mapping(vma->vm_flags))
-			continue;
-
-		addr = vma->vm_start;
-		end = vma->vm_end;
-		
-		pgd = pgd_offset(mm, addr);
-		do {
-			next = pgd_addr_end(addr, end);
-			if (pgd_none_or_clear_bad(pgd))
-				continue;
-			if (ipipe_pin_pud_range(mm, pgd, vma, addr, next)) {
-				result = -ENOMEM;
-				goto done_mm;
-			}
-		} while (pgd++, addr = next, addr != end);
-	}
-	mm->def_flags |= VM_PINNED;
-
-  done_mm:
-	up_write(&mm->mmap_sem);
-	mmput(mm);
-	return result;
-}
-
-EXPORT_SYMBOL(ipipe_disable_ondemand_mappings);
-
-#endif
Index: b/arch/x86/kernel/Makefile_64
===================================================================
--- a/arch/x86/kernel/Makefile_64
+++ b/arch/x86/kernel/Makefile_64
@@ -35,8 +35,6 @@ obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer_64
 obj-$(CONFIG_X86_VSMP)		+= vsmp_64.o
 obj-$(CONFIG_K8_NB)		+= k8.o
 obj-$(CONFIG_AUDIT)		+= audit_64.o
-obj-$(CONFIG_IPIPE)		+= ipipe.o
-obj-$(CONFIG_IPIPE_TRACE_MCOUNT)	+= mcount_64.o
 
 obj-$(CONFIG_MODULES)		+= module_64.o
 obj-$(CONFIG_PCI)		+= early-quirks.o
Index: b/include/linux/kernel.h
===================================================================
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -14,7 +14,6 @@
 #include <linux/compiler.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
-#include <linux/ipipe_base.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
Index: b/kernel/exit.c
===================================================================
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -994,7 +994,6 @@ fastcall NORET_TYPE void do_exit(long co
 
 	if (group_dead)
 		acct_process();
- 	ipipe_exit_notify(tsk);
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
Index: b/kernel/sched.c
===================================================================
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -7419,66 +7419,3 @@ struct cgroup_subsys cpuacct_subsys = {
 	.subsys_id = cpuacct_subsys_id,
 };
 #endif	/* CONFIG_CGROUP_CPUACCT */
-
-#ifdef CONFIG_IPIPE
-
-int ipipe_setscheduler_root (struct task_struct *p, int policy, int prio)
-{
-	int oldprio, on_rq, running;
-	unsigned long flags;
-	struct rq *rq;
-
-	spin_lock_irqsave(&p->pi_lock, flags);
-	rq = __task_rq_lock(p);
-	update_rq_clock(rq);
-	on_rq = p->se.on_rq;
-	running = task_running(rq, p);
-
-	if (on_rq) {
-		deactivate_task(rq, p, 0);
-		if (running)
-			p->sched_class->put_prev_task(rq, p);
-	}
-
-	oldprio = p->prio;
-	__setscheduler(rq, p, policy, prio);
-	ipipe_setsched_notify(p);
-
-	if (on_rq) {
-		if (running)
-			p->sched_class->set_curr_task(rq);
-		activate_task(rq, p, 0);
-
-		if (running) {
-			if (p->prio > oldprio)
-				resched_task(rq->curr);
-		} else {
-			check_preempt_curr(rq, p);
-		}
-	}
-	__task_rq_unlock(rq);
-	spin_unlock_irqrestore(&p->pi_lock, flags);
-
-	rt_mutex_adjust_pi(p);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(ipipe_setscheduler_root);
-
-int ipipe_reenter_root (struct task_struct *prev, int policy, int prio)
-{
-	finish_task_switch(this_rq(), prev);
-
-	(void)reacquire_kernel_lock(current);
-	preempt_enable_no_resched();
-
-	if (current->policy != policy || current->rt_priority != prio)
-		return ipipe_setscheduler_root(current, policy, prio);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(ipipe_reenter_root);
-
-#endif /* CONFIG_IPIPE */

--------------080300030301060102010405
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
@@ -999,7 +999,6 @@ int __ipipe_check_tickdev(const char *de
 
 EXPORT_SYMBOL(__ipipe_tick_irq);
 
-EXPORT_SYMBOL_GPL(irq_desc);
 struct task_struct *__switch_to(struct task_struct *prev_p,
 				struct task_struct *next_p);
 EXPORT_SYMBOL_GPL(__switch_to);
@@ -1013,7 +1012,3 @@ EXPORT_PER_CPU_SYMBOL_GPL(cpu_tlbstate);
 #else /* !CONFIG_X86_32 */
 EXPORT_SYMBOL_GPL(cpu_gdt_descr);
 #endif /* !CONFIG_X86_32 */
-
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-EXPORT_SYMBOL(tasklist_lock);
-#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
Index: b/include/linux/ipipe.h
===================================================================
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -544,7 +544,8 @@ void ipipe_set_kgdb_irq(int irq, int (*h
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
 

--------------080300030301060102010405
Content-Type: text/plain;
 name="series"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="series"

adeos-ipipe-2.6.24-x86-2.0-03.patch

prepare-lttng.patch
markers-support-for-proprietary-modules.patch
fix-arm-to-play-nicely-with-generic-instrumentation-menu.patch # to test and send to mm
#folded. fix-ARMv6-oprofile-support.patch #submitted for 2.6.24
#merged by Linus fix-blackfin-oprofile-support.patch
# BEGIN SUBMITTED
#
# cmpxchg_local and cmpxchg64_local standardization
#SUBMITTED TO ANDREW
add-cmpxchg-local-to-generic-for-up.patch
i386-cmpxchg64-80386-80486-fallback.patch
add-cmpxchg64-to-alpha.patch
add-cmpxchg64-to-mips.patch
add-cmpxchg64-to-powerpc.patch
add-cmpxchg64-to-x86_64.patch
#
add-cmpxchg-local-to-arm.patch
add-cmpxchg-local-to-avr32.patch
add-cmpxchg-local-to-blackfin.patch
add-cmpxchg-local-to-cris.patch
add-cmpxchg-local-to-frv.patch
add-cmpxchg-local-to-h8300.patch
add-cmpxchg-local-to-ia64.patch
add-cmpxchg-local-to-m32r.patch
fix-m32r-__xchg.patch
fix-m32r-include-sched-h-in-smpboot.patch
local_t_m32r_optimized.patch
add-cmpxchg-local-to-m68k.patch
add-cmpxchg-local-to-m68knommu.patch
add-cmpxchg-local-to-parisc.patch
add-cmpxchg-local-to-ppc.patch
add-cmpxchg-local-to-s390.patch
add-cmpxchg-local-to-sh.patch
add-cmpxchg-local-to-sh64.patch
add-cmpxchg-local-to-sparc.patch
add-cmpxchg-local-to-sparc64.patch
add-cmpxchg-local-to-v850.patch
add-cmpxchg-local-to-xtensa.patch
#
#in -mm
markers-support-multiple-probes.patch
#in -mm
linux-kernel-markers-create-modpost-file.patch
#
# instrumentation menu removal
#From Haavard
avr32-kconfig-instr.patch
avr32-kconfig-instr2.patch
#for -mm
add-kconfig-to-arch.patch #repost after ARM fix.
add-have-oprofile.patch #repost after ARM fix.
add-have-kprobes.patch #repost after ARM fix.
move-kconfig-instrumentation-to-arch.patch #to repost
#
#Markers updates
#
## END SUBMITTED
#
### RFC
# BEGIN SUBMITTED
#Text Edit Lock
#TO REPOST for -mm
kprobes-use-mutex-for-insn-pages.patch
kprobes-dont-use-kprobes-mutex-in-arch-code.patch
kprobes-declare-kprobes-mutex-static.patch
declare-array.patch	#TO REMOVE
text-edit-lock-architecture-independent-code.patch
text-edit-lock-alternative-i386-and-x86_64.patch
text-edit-lock-kprobes-architecture-independent.patch
text-edit-lock-kprobes-i386.patch
text-edit-lock-kprobes-x86_64.patch
text-edit-lock-i386-standardize-debug-rodata.patch
text-edit-lock-x86_64-standardize-debug-rodata.patch
#
#Immediate Values
#TO REPOST for -mm
immediate-values-architecture-independent-code.patch
immediate-values-kconfig-embedded.patch
add-x86-asm-asm-h.patch
immediate-values-x86-optimization.patch
add-text-poke-to-powerpc.patch
immediate-values-powerpc-optimization.patch
immediate-values-documentation.patch
#
profiling-use-immediate-values.patch
#
#Kallsyms weak symbols fix
#To be posted by the author
kallsyms-non-weak.patch
#
immediate-values-move-kprobes-x86-restore-interrupt-to-kdebug-h.patch
add-discard-section-to-x86.patch
immediate-values-x86-optimization-nmi-mce-support.patch
immediate-values-powerpc-optimization-nmi-mce-support.patch
immediate-values-use-arch-nmi-mce-support.patch
linux-kernel-markers-immediate-values.patch
#
#NEVER submit as-is. Need to add #include <linux/marker.h> everywhere.
lttng-instrument-kernelh.patch # NOT FOR UPSTREAM
#
lttng-instrumentation-fs.patch
lttng-instrumentation-ipc.patch
lttng-instrumentation-kernel.patch
lttng-instrumentation-mm.patch
lttng-instrumentation-net.patch
add-markers-into-semaphore-primitives.patch
#
# END SUBMITTED
#
#kernel trace thread flag : required for arch-dependent syscall entry/exit
#instrumentation.
lttng-kernel-trace-thread-flag-alpha.patch
lttng-kernel-trace-thread-flag-arm.patch
lttng-kernel-trace-thread-flag-avr32.patch
lttng-kernel-trace-thread-flag-blackfin.patch
lttng-kernel-trace-thread-flag-cris.patch
lttng-kernel-trace-thread-flag-frv.patch
lttng-kernel-trace-thread-flag-h8300.patch
lttng-kernel-trace-thread-flag-i386.patch
lttng-kernel-trace-thread-flag-ia64.patch
lttng-kernel-trace-thread-flag-m32r.patch
lttng-kernel-trace-thread-flag-m68k.patch
lttng-kernel-trace-thread-flag-m68knommu.patch
lttng-kernel-trace-thread-flag-mips.patch
lttng-kernel-trace-thread-flag-parisc.patch
lttng-kernel-trace-thread-flag-powerpc.patch
lttng-kernel-trace-thread-flag-s390.patch
lttng-kernel-trace-thread-flag-sh.patch
lttng-kernel-trace-thread-flag-sh64.patch
lttng-kernel-trace-thread-flag-sparc.patch
lttng-kernel-trace-thread-flag-sparc64.patch
lttng-kernel-trace-thread-flag-um.patch
lttng-kernel-trace-thread-flag-v850.patch
lttng-kernel-trace-thread-flag-x86_64.patch
lttng-kernel-trace-thread-flag-xtensa.patch
lttng-kernel-trace-thread-flag-api.patch
#
#NEVER submit as-is. Need to add #include <linux/marker.h> everywhere.
lttng-instrumentation-arm.patch
lttng-instrumentation-i386.patch
lttng-instrumentation-mips.patch
lttng-instrumentation-powerpc.patch
lttng-instrumentation-ppc.patch
lttng-instrumentation-sh.patch
lttng-instrumentation-sh64.patch
lttng-instrumentation-sparc.patch
lttng-instrumentation-x86_64.patch
lttng-instrumentation-s390.patch
#FIXME : add missing architectures.
#
lttng-build-instrumentation-menu.patch
#
#LTTng timestamping
#
lttng-timestamp-core.patch
lttng-timestamp-generic.patch
lttng-timestamp-ppc.patch
lttng-mips-export-hpt-frequency.patch
lttng-timestamp-mips.patch
lttng-timestamp-powerpc.patch
lttng-timestamp-sh.patch
lttng-test-tsc.patch
lttng-timestamp-x86.patch
#
#LTTng tracer, architecture independent
#
lttng-relay-hotplug.patch
lttng-core-header.patch
lttng-core.patch
lttng-core-i386.patch
lttng-core-powerpc.patch
lttng-tracer-header.patch
lttng-tracer.patch
lttng-transport.patch
lttng-netlink-control.patch
lttng-serialize.patch
#
#LTTng statedump, extraction of inner kernel information at trace start.
#
lttng-export-tasklist-lock.patch
lttng-export-irq_desc.patch
lttng-statedump.patch
export-get-files-struct-symbol.patch
rcu_fd_statedump.patch
lttng-statedump-module-list.patch
#
#LTTng tracer Kconfig menu
#
lttng-menus.patch
#
#Linux Kernel Markers /proc interface
#
seq_file_sorted.patch
module.c-sort-module-list.patch
linux-kernel-markers-iterator.patch
lttng-marker-control.patch
#
#extra instrumentation
add-input-subsystem-instrumentation.patch
#
markers-multi-probes-test.patch
fix-wan-desc-offset.patch
lttng-statedump-x86.patch
#
lttng-sched-instrumentation-probe.patch
#needs work
# to be updated blktrace-port-to-lttng.patch
#linux-kernel-markers-port-blktrace-to-markers.patch
#
# Disabled for now. Need work.
#lttng-instrumentation-fs-data.patch
#lttng-instrumentation-stack-i386.patch
#lttng-instrumentation-stack-x86_64.patch
#lttng-instrumentation-stack.patch
#lttng-probes.patch
#
# Userspace tracing. Disabled for now.
#
#lttng-userspace-tracing.patch
#lttng-userspace-tracing-arm.patch
#lttng-userspace-tracing-i386.patch
#lttng-userspace-tracing-mips.patch
#lttng-userspace-tracing-powerpc.patch
#lttng-userspace-tracing-sh.patch
#lttng-userspace-tracing-x86_64.patch
#lttng-userspace-tracing-menus.patch

lttng-ipipe-2.6.24-x86-2.0-02.patch

--------------080300030301060102010405--

