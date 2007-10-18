Message-ID: <4717D8AC.8000900@domain.hid>
Date: Fri, 19 Oct 2007 00:05:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB3BCFB8196F9E96A98F5DD33"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] LTTng for Xenomai - next round
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3BCFB8196F9E96A98F5DD33
Content-Type: multipart/mixed;
 boundary="------------010405060606060303050908"

This is a multi-part message in MIME format.
--------------010405060606060303050908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

LTTng is becoming interesting again: Mathieu uploaded a back-port to
2.6.23.1 yesterday which is already implementing the scheme that is
intended to be submitted upstream.

What changed for us?

 - We now have a recent patch basis for the kernel again.

 - The instrumentation process was significantly simplified: No more
   facility registration, no more probe modules, no more XML file
   hacking - it's all derived from the trace points now! Some example:

   trace_mark(kernel_timer_itimer_expired, "pid %d", sig->tsk->pid);
              ^----^ ^------------------^   ^----^
             facility     trace point    argument name
               name          name          and type

I rebased the patches over I-pipe for i386 (see attached patches and
extended series description), and I also started to rework the Xenomai
patch. The diffstat of the latter is fairly telling:

 include/nucleus/ltt.h   |  111 +---------------------------
 ksrc/nucleus/Config.in  |    9 --
 ksrc/nucleus/Kconfig    |   36 ---------
 ksrc/nucleus/Makefile   |    3
 ksrc/nucleus/intr.c     |   19 ++--
 ksrc/nucleus/ltt.c      |  186 -----------------------------------------=
-------
 ksrc/nucleus/module.c   |    7 -
 ksrc/nucleus/pod.c      |  102 ++++++++++++++++----------
 ksrc/nucleus/shadow.c   |   43 +++++++----
 ksrc/nucleus/synch.c    |   19 +++-
 ksrc/nucleus/timebase.c |    6 -
 11 files changed, 125 insertions(+), 416 deletions(-)

You see, no more ltt.c, i.e. no more probe module!

At this point, we are already able to use the services of "lttv -m
textDump" or lttv-gui to display traces from Xenomai kernels as event
lists. Yes, I tried this, and it works! (Hint: Don't forget to
ltt-armall your trace points before trying to collect data...)

Yet to be done:

 - Finish the xnltt_log_event refactoring (half done, pod.c is missing
   yet - with ~30 trace point)

 - Port and update the Xenomai extension over latest lttv.

Well, I'm not looking for work, I'm looking for workers :). Anyone
interested and available to help with the open topics? Daniel...?

Jan

--------------010405060606060303050908
Content-Type: text/x-patch;
 name="ltt-ipipe-2.6.23-i386-1.10-10.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ltt-ipipe-2.6.23-i386-1.10-10.patch"

---
 arch/i386/kernel/ipipe.c |    4 -
 include/asm-i386/ipipe.h |    4 -
 include/linux/kernel.h   |    1=20
 include/linux/marker.h   |   10 ++--
 kernel/exit.c            |    1=20
 kernel/sched.c           |   52 +++++++++++++++++++++++
 ltt/ltt-relay.c          |    2=20
 ltt/ltt-serialize.c      |   12 +++--
 mm/memory.c              |  102 ++++++++++++++++++++++++++++++++++++++++=
+++++++
 9 files changed, 172 insertions(+), 16 deletions(-)

Index: linux-2.6.23-ipipe/include/linux/kernel.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/include/linux/kernel.h
+++ linux-2.6.23-ipipe/include/linux/kernel.h
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/marker.h>
+#include <linux/ipipe_base.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
=20
Index: linux-2.6.23-ipipe/kernel/exit.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/kernel/exit.c
+++ linux-2.6.23-ipipe/kernel/exit.c
@@ -975,6 +975,7 @@ fastcall NORET_TYPE void do_exit(long co
 	if (group_dead)
 		acct_process();
 	trace_mark(kernel_process_exit, "pid %d", tsk->pid);
+	ipipe_exit_notify(tsk);
=20
 	exit_sem(tsk);
 	__exit_files(tsk);
Index: linux-2.6.23-ipipe/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/kernel/sched.c
+++ linux-2.6.23-ipipe/kernel/sched.c
@@ -6809,3 +6809,55 @@ void set_kernel_trace_flag_all_tasks(voi
 	read_unlock(&tasklist_lock);
 }
 EXPORT_SYMBOL_GPL(set_kernel_trace_flag_all_tasks);
+
+#ifdef CONFIG_IPIPE
+
+int ipipe_setscheduler_root (struct task_struct *p, int policy, int prio=
)
+{
+	unsigned long flags;
+	int oldprio, on_rq;
+	struct rq *rq;
+
+	spin_lock_irqsave(&p->pi_lock, flags);
+	rq =3D __task_rq_lock(p);
+	on_rq =3D p->se.on_rq;
+	if (on_rq)
+		deactivate_task(rq, p, 0);
+	oldprio =3D p->prio;
+	__setscheduler(rq, p, policy, prio);
+	ipipe_setsched_notify(p);
+	if (on_rq) {
+		activate_task(rq, p, 0);
+		if (task_running(rq, p)) {
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
+	if (current->policy !=3D policy || current->rt_priority !=3D prio)
+		return ipipe_setscheduler_root(current, policy, prio);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(ipipe_reenter_root);
+
+#endif /* CONFIG_IPIPE */
Index: linux-2.6.23-ipipe/mm/memory.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/mm/memory.c
+++ linux-2.6.23-ipipe/mm/memory.c
@@ -52,6 +52,7 @@
 #include <linux/writeback.h>
 #include <linux/kprobes.h>
 #include <linux/mutex.h>
+#include <linux/vmalloc.h>
=20
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -2957,3 +2958,104 @@ void __kprobes kernel_text_unlock(void)
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
+		pte =3D pte_offset_map_lock(mm, pmd, addr, &ptl);
+		if (!pte)
+			continue;
+
+		if (!pte_present(*pte)) {
+			pte_unmap_unlock(pte, ptl);
+			continue;
+		}
+
+		if (do_wp_page(mm, vma, addr, pte, pmd, ptl, *pte) =3D=3D VM_FAULT_OOM=
)
+			return -ENOMEM;
+	} while (addr +=3D PAGE_SIZE, addr !=3D end);
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
+	pmd =3D pmd_offset(pud, addr);
+	do {
+		next =3D pmd_addr_end(addr, end);
+		if (ipipe_pin_pte_range(mm, pmd, vma, addr, end))
+			return -ENOMEM;
+	} while (pmd++, addr =3D next, addr !=3D end);
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
+	pud =3D pud_offset(pgd, addr);
+	do {
+		next =3D pud_addr_end(addr, end);
+		if (ipipe_pin_pmd_range(mm, pud, vma, addr, end))
+			return -ENOMEM;
+	} while (pud++, addr =3D next, addr !=3D end);
+	return 0;
+}
+
+int ipipe_disable_ondemand_mappings(struct task_struct *tsk)
+{
+	unsigned long addr, next, end;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	int result =3D 0;
+	pgd_t *pgd;
+
+	mm =3D get_task_mm(tsk);
+	if (!mm)
+		return -EPERM;
+
+	down_write(&mm->mmap_sem);
+	if (mm->def_flags & VM_PINNED)
+		goto done_mm;
+
+	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		if (!is_cow_mapping(vma->vm_flags))
+			continue;
+
+		addr =3D vma->vm_start;
+		end =3D vma->vm_end;
+
+		pgd =3D pgd_offset(mm, addr);
+		do {
+			next =3D pgd_addr_end(addr, end);
+			if (ipipe_pin_pud_range(mm, pgd, vma, addr, next)) {
+				result =3D -ENOMEM;
+				goto done_mm;
+			}
+		} while (pgd++, addr =3D next, addr !=3D end);
+	}
+	mm->def_flags |=3D VM_PINNED;
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
Index: linux-2.6.23-ipipe/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.23-ipipe/arch/i386/kernel/ipipe.c
@@ -815,13 +815,9 @@ EXPORT_SYMBOL(ipipe_critical_exit);
 EXPORT_SYMBOL(ipipe_trigger_irq);
 EXPORT_SYMBOL(ipipe_get_sysinfo);
=20
-EXPORT_SYMBOL_GPL(irq_desc);
 EXPORT_SYMBOL_GPL(__switch_to);
 EXPORT_SYMBOL_GPL(show_stack);
 EXPORT_PER_CPU_SYMBOL_GPL(init_tss);
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-EXPORT_SYMBOL(tasklist_lock);
-#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
 #ifdef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL_GPL(cpu_tlbstate);
 #endif /* CONFIG_SMP */
Index: linux-2.6.23-ipipe/include/asm-i386/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/include/asm-i386/ipipe.h
+++ linux-2.6.23-ipipe/include/asm-i386/ipipe.h
@@ -22,6 +22,8 @@
 #ifndef __I386_IPIPE_H
 #define __I386_IPIPE_H
=20
+#define ipipe_processor_id()   raw_smp_processor_id()
+
 #ifdef CONFIG_IPIPE
=20
 #define IPIPE_ARCH_STRING	"1.10-10"
@@ -37,8 +39,6 @@
 #include <linux/ipipe_percpu.h>
 #include <asm/ptrace.h>
=20
-#define ipipe_processor_id()   raw_smp_processor_id()
-
 #define prepare_arch_switch(next)		\
 do {						\
 	ipipe_schedule_notify(current, next);	\
Index: linux-2.6.23-ipipe/include/linux/marker.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/include/linux/marker.h
+++ linux-2.6.23-ipipe/include/linux/marker.h
@@ -66,19 +66,21 @@ struct marker {
 		__mark_check_format(format, ## args);			\
 		if (!generic) {						\
 			if (unlikely(immediate_read(__mark_##name.state))) { \
-				preempt_disable();			\
+				unsigned long __irqflags;		\
+				ipipe_preempt_disable(__irqflags);	\
 				(*__mark_##name.call)			\
 					(&__mark_##name, call_data,	\
 					format, ## args);		\
-				preempt_enable();			\
+				ipipe_preempt_enable(__irqflags);	\
 			}						\
 		} else {						\
 			if (unlikely(_immediate_read(__mark_##name.state))) { \
-				preempt_disable();			\
+				unsigned long __irqflags;		\
+				ipipe_preempt_disable(__irqflags);	\
 				(*__mark_##name.call)			\
 					(&__mark_##name, call_data,	\
 					format, ## args);		\
-				preempt_enable();			\
+				ipipe_preempt_enable(__irqflags);	\
 			}						\
 		}							\
 	} while (0)
Index: linux-2.6.23-ipipe/ltt/ltt-relay.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/ltt/ltt-relay.c
+++ linux-2.6.23-ipipe/ltt/ltt-relay.c
@@ -1010,7 +1010,7 @@ static void *ltt_relay_reserve_slot(stru
 	/*
 	 * Perform retryable operations.
 	 */
-	if (ltt_nesting[smp_processor_id()] > 4) {
+	if (ltt_nesting[ipipe_processor_id()] > 4) {
 		local_inc(&ltt_buf->events_lost);
 		return NULL;
 	}
Index: linux-2.6.23-ipipe/ltt/ltt-serialize.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/ltt/ltt-serialize.c
+++ linux-2.6.23-ipipe/ltt/ltt-serialize.c
@@ -10,6 +10,7 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/ipipe_base.h>
 #include <linux/ltt-tracer.h>
=20
 enum ltt_type {
@@ -943,6 +944,7 @@ void ltt_vtrace(const struct marker *mda
 	u32 compact_data =3D 0;
 	void *serialize_private =3D NULL;
 	int cpu;
+	unsigned long irqflags;
=20
 	pdata =3D (struct ltt_active_marker *)mdata->private;
 	if (unlikely(private_data && private_data->id < MARKER_CORE_IDS))
@@ -959,13 +961,13 @@ void ltt_vtrace(const struct marker *mda
 		&& (!private_data || !private_data->force)))
 		return;
=20
-	preempt_disable();
+	ipipe_preempt_disable(irqflags);
 	if (likely(!private_data || !private_data->force
 			|| private_data->cpu =3D=3D -1))
-		cpu =3D smp_processor_id();
+		cpu =3D ipipe_processor_id();
 	else
 		cpu =3D private_data->cpu;
-	ltt_nesting[smp_processor_id()]++;
+	ltt_nesting[ipipe_processor_id()]++;
=20
 	if (unlikely(private_data && private_data->trace))
 		dest_trace =3D private_data->trace;
@@ -1018,8 +1020,8 @@ void ltt_vtrace(const struct marker *mda
 		/* Out-of-order commit */
 		ltt_commit_slot(channel, &transport_data, buffer, slot_size);
 	}
-	ltt_nesting[smp_processor_id()]--;
-	preempt_enable();
+	ltt_nesting[ipipe_processor_id()]--;
+	ipipe_preempt_enable(irqflags);
 }
 EXPORT_SYMBOL_GPL(ltt_vtrace);
=20

--------------010405060606060303050908
Content-Type: text/x-patch;
 name="prepare-lttng.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="prepare-lttng.patch"

Index: linux-2.6.23-ipipe/mm/memory.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/mm/memory.c
+++ linux-2.6.23-ipipe/mm/memory.c
@@ -50,7 +50,6 @@
 #include <linux/delayacct.h>
 #include <linux/init.h>
 #include <linux/writeback.h>
-#include <linux/vmalloc.h>
=20
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -2910,104 +2909,3 @@ int access_process_vm(struct task_struct
 	return buf - old_buf;
 }
 EXPORT_SYMBOL_GPL(access_process_vm);
-
-#ifdef CONFIG_IPIPE
-
-static inline int ipipe_pin_pte_range(struct mm_struct *mm, pmd_t *pmd,
-				      struct vm_area_struct *vma,
-				      unsigned long addr, unsigned long end)
-{
-	spinlock_t *ptl;
-	pte_t *pte;
-=09
-	do {
-		pte =3D pte_offset_map_lock(mm, pmd, addr, &ptl);
-		if (!pte)
-			continue;
-
-		if (!pte_present(*pte)) {
-			pte_unmap_unlock(pte, ptl);
-			continue;
-		}
-
-		if (do_wp_page(mm, vma, addr, pte, pmd, ptl, *pte) =3D=3D VM_FAULT_OOM=
)
-			return -ENOMEM;
-	} while (addr +=3D PAGE_SIZE, addr !=3D end);
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
-	pmd =3D pmd_offset(pud, addr);
-	do {
-		next =3D pmd_addr_end(addr, end);
-		if (ipipe_pin_pte_range(mm, pmd, vma, addr, end))
-			return -ENOMEM;
-	} while (pmd++, addr =3D next, addr !=3D end);
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
-	pud =3D pud_offset(pgd, addr);
-	do {
-		next =3D pud_addr_end(addr, end);
-		if (ipipe_pin_pmd_range(mm, pud, vma, addr, end))
-			return -ENOMEM;
-	} while (pud++, addr =3D next, addr !=3D end);
-	return 0;
-}
-
-int ipipe_disable_ondemand_mappings(struct task_struct *tsk)
-{
-	unsigned long addr, next, end;
-	struct vm_area_struct *vma;
-	struct mm_struct *mm;
-	int result =3D 0;
-	pgd_t *pgd;
-
-	mm =3D get_task_mm(tsk);
-	if (!mm)
-		return -EPERM;
-
-	down_write(&mm->mmap_sem);
-	if (mm->def_flags & VM_PINNED)
-		goto done_mm;
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
-		if (!is_cow_mapping(vma->vm_flags))
-			continue;
-
-		addr =3D vma->vm_start;
-		end =3D vma->vm_end;
-	=09
-		pgd =3D pgd_offset(mm, addr);
-		do {
-			next =3D pgd_addr_end(addr, end);
-			if (ipipe_pin_pud_range(mm, pgd, vma, addr, next)) {
-				result =3D -ENOMEM;
-				goto done_mm;
-			}
-		} while (pgd++, addr =3D next, addr !=3D end);
-	}
-	mm->def_flags |=3D VM_PINNED;
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
Index: linux-2.6.23-ipipe/include/linux/kernel.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/include/linux/kernel.h
+++ linux-2.6.23-ipipe/include/linux/kernel.h
@@ -14,7 +14,6 @@
 #include <linux/compiler.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
-#include <linux/ipipe_base.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
=20
Index: linux-2.6.23-ipipe/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/kernel/sched.c
+++ linux-2.6.23-ipipe/kernel/sched.c
@@ -6756,55 +6756,3 @@ void set_curr_task(int cpu, struct task_
 }
=20
 #endif
-
-#ifdef CONFIG_IPIPE
-
-int ipipe_setscheduler_root (struct task_struct *p, int policy, int prio=
)
-{
-	unsigned long flags;
-	int oldprio, on_rq;
-	struct rq *rq;
-
-	spin_lock_irqsave(&p->pi_lock, flags);
-	rq =3D __task_rq_lock(p);
-	on_rq =3D p->se.on_rq;
-	if (on_rq)
-		deactivate_task(rq, p, 0);
-	oldprio =3D p->prio;
-	__setscheduler(rq, p, policy, prio);
-	ipipe_setsched_notify(p);
-	if (on_rq) {
-		activate_task(rq, p, 0);
-		if (task_running(rq, p)) {
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
-	if (current->policy !=3D policy || current->rt_priority !=3D prio)
-		return ipipe_setscheduler_root(current, policy, prio);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(ipipe_reenter_root);
-
-#endif /* CONFIG_IPIPE */
Index: linux-2.6.23-ipipe/kernel/exit.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-ipipe.orig/kernel/exit.c
+++ linux-2.6.23-ipipe/kernel/exit.c
@@ -973,7 +973,6 @@ fastcall NORET_TYPE void do_exit(long co
=20
 	if (group_dead)
 		acct_process();
- 	ipipe_exit_notify(tsk);
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);

--------------010405060606060303050908
Content-Type: text/plain;
 name="series"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="series"

adeos-ipipe-2.6.23-i386-1.10-10.patch
# Linux kernel markers (in 2.6.23-mm1)
prepare-lttng.patch
change-struct-marker-users.patch
combine-instrumentation-menus-in-kernel-kconfiginstrumentation.patch
linux-kernel-markers.patch
linux-kernel-markers-checkpatch-fixes.patch
linux-kernel-markers-coding-style-fixes.patch
linux-kernel-markers-alignment-fix.patch
add-samples-subdir.patch
linux-kernel-markers-samples.patch
linux-kernel-markers-samples-checkpatch-fixes.patch
linux-kernel-markers-samples-coding-style-fix.patch
linux-kernel-markers-samples-remove-asm.patch
linux-kernel-markers-documentation.patch
# LTTng patches
linux-kernel-markers-port-blktrace-to-markers.patch
#
## CH will submit. linux-kernel-markers-port-spu-to-markers.patch
#
kprobes-use-mutex-for-insn-pages.patch
kprobes-dont-use-kprobes-mutex-in-arch-code.patch
kprobes-declare-kprobes-mutex-static.patch
declare-array.patch
text-edit-lock-architecture-independent-code.patch
text-edit-lock-alternative-i386-and-x86_64.patch
text-edit-lock-kprobes-architecture-independent.patch
text-edit-lock-kprobes-i386.patch
text-edit-lock-kprobes-x86_64.patch
text-edit-lock-i386-standardize-debug-rodata.patch
text-edit-lock-x86_64-standardize-debug-rodata.patch
#
#removed-immediate-values-global-modules-list-and-mutex.patch
immediate-values-architecture-independent-code.patch
immediate-values-kconfig-embedded.patch
immediate-values-move-kprobes-i386-restore-interrupt-to-kdebug-h.patch
immediate-values-i386-optimization.patch
immediate-values-powerpc-optimization.patch
immediate-values-documentation.patch
#
# not in mainline profiling-use-immediate-values.patch
linux-kernel-markers-immediate-values.patch
#
#
# cmpxchg_local and cmpxchg64_local standardization
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
# not lttng. slub-use-cmpxchg-local.patch
#
local_t-documentation-update-2.patch
atomic_opstxt-mention-local_t.patch
local_t-update-documentation.patch
# WAIT FOR USERSPACE MARKERS IMPLEMENTATION BEFORE SENDING TO UPSTREAM
local_t-update-documentation-2.patch
lttng-instrument-kernelh.patch # NOT FOR UPSTREAM
lttng-export-irq_desc.patch
#
#kernel trace thread flag
lttng-kernel-trace-thread-flag-alpha.patch
lttng-kernel-trace-thread-flag-arm.patch
lttng-kernel-trace-thread-flag-avr32.patch
lttng-kernel-trace-thread-flag-blackfin.patch
lttng-kernel-trace-thread-flag-cris.patch
lttng-kernel-trace-thread-flag-frv.patch
lttng-kernel-trace-thread-flag-h8300.patch
lttng-kernel-trace-thread-flag-i386.patch
lttng-kernel-trace-thread-flag-ia64.patch #FIXME
lttng-kernel-trace-thread-flag-m32r.patch
lttng-kernel-trace-thread-flag-m68k.patch
lttng-kernel-trace-thread-flag-m68knommu.patch
lttng-kernel-trace-thread-flag-mips.patch
lttng-kernel-trace-thread-flag-parisc.patch
lttng-kernel-trace-thread-flag-powerpc.patch
lttng-kernel-trace-thread-flag-s390.patch #FIXME
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
lttng-build-instrumentation-menu.patch
#
lttng-timestamp-core.patch
lttng-timestamp-generic.patch
lttng-timestamp-ppc.patch
lttng-mips-export-hpt-frequency.patch
lttng-timestamp-mips.patch
lttng-timestamp-powerpc.patch
#
lttng-timestamp-sh.patch
lttng-test-tsc.patch
lttng-timestamp-i386.patch
lttng-timestamp-x86_64.patch
#
#
lttng-relay-hotplug.patch
lttng-core-header.patch
lttng-core.patch
lttng-core-i386.patch
lttng-core-powerpc.patch
lttng-tracer-header.patch
lttng-tracer.patch
lttng-transport-2.patch
lttng-netlink-control.patch
lttng-serialize.patch
#
#
lttng-instrumentation-arm.patch
lttng-instrumentation-i386.patch
lttng-instrumentation-mips.patch
lttng-instrumentation-powerpc.patch
lttng-instrumentation-ppc.patch
lttng-instrumentation-s390.patch	#FIXME: syscall trace 8 bit.
lttng-instrumentation-sh.patch
lttng-instrumentation-sh64.patch
lttng-instrumentation-sparc.patch
lttng-instrumentation-x86_64.patch
#
lttng-instrumentation.patch
lttng-instrumentation-modules.patch
lttng-export-tasklist-lock.patch
#
lttng-instrumentation-stack.patch
lttng-probes.patch
lttng-statedump.patch
lttng-menus.patch
#
#
seq_file_sorted.patch
module.c-sort-module-list.patch
linux-kernel-markers-iterator.patch
lttng-marker-control.patch
#
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
#
ltt-ipipe-2.6.23-i386-1.10-10.patch

--------------010405060606060303050908
Content-Type: text/x-patch;
 name="lttng-v4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="lttng-v4.patch"

---
 include/nucleus/ltt.h   |  111 +---------------------------
 ksrc/nucleus/Config.in  |    9 --
 ksrc/nucleus/Kconfig    |   36 ---------
 ksrc/nucleus/Makefile   |    3=20
 ksrc/nucleus/intr.c     |   19 ++--
 ksrc/nucleus/ltt.c      |  186 -----------------------------------------=
-------
 ksrc/nucleus/module.c   |    7 -
 ksrc/nucleus/pod.c      |  102 ++++++++++++++++----------
 ksrc/nucleus/shadow.c   |   43 +++++++----
 ksrc/nucleus/synch.c    |   19 +++-
 ksrc/nucleus/timebase.c |    6 -
 11 files changed, 125 insertions(+), 416 deletions(-)

Index: xenomai/include/nucleus/ltt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/ltt.h
+++ xenomai/include/nucleus/ltt.h
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2004 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
=2Enet>
  * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
+ * Copyright (C) 2007 Jan Kiszka <jan.kiszka@domain.hid>.
  *
  * Xenomai is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published
@@ -21,119 +22,17 @@
 #ifndef _XENO_NUCLEUS_LTT_H
 #define _XENO_NUCLEUS_LTT_H
=20
-#include <nucleus/types.h>
-
 #ifdef CONFIG_LTT
=20
-#include <linux/ltt-core.h>
-
-struct xnltt_evmap {
-
-    char *ltt_label;	/* !< Event label (creation time). */
-    char *ltt_format;	/* !< Event format (creation time). */
-    int ltt_evid;	/* !< LTT custom event id. */
-    int ltt_filter;	/* !< Event filter. */
-};
-
-#define xeno_ev_ienter       0
-#define xeno_ev_iexit        1
-#define xeno_ev_resched      2
-#define xeno_ev_smpsched     3
-#define xeno_ev_fastsched    4
-#define xeno_ev_switch       5
-#define xeno_ev_fault        6
-#define xeno_ev_callout      7
-#define xeno_ev_finalize     8
-#define xeno_ev_thrinit      9
-#define xeno_ev_thrstart     10
-#define xeno_ev_threstart    11
-#define xeno_ev_thrdelete    12
-#define xeno_ev_thrsuspend   13
-#define xeno_ev_thresume     14
-#define xeno_ev_thrunblock   15
-#define xeno_ev_threnice     16
-#define xeno_ev_cpumigrate   17
-#define xeno_ev_sigdispatch  18
-#define xeno_ev_thrboot      19
-#define xeno_ev_tstick       20
-#define xeno_ev_sleepon      21
-#define xeno_ev_wakeup1      22
-#define xeno_ev_wakeupx      23
-#define xeno_ev_syncflush    24
-#define xeno_ev_syncforget   25
-#define xeno_ev_lohandler    26
-#define xeno_ev_primarysw    27
-#define xeno_ev_primary      28
-#define xeno_ev_secondarysw  29
-#define xeno_ev_secondary    30
-#define xeno_ev_shadowmap    31
-#define xeno_ev_shadowunmap  32
-#define xeno_ev_shadowstart  33
-#define xeno_ev_syscall      34
-#define xeno_ev_shadowexit   35
-#define xeno_ev_thrsetmode   36
-#define xeno_ev_rdrotate     37
-#define xeno_ev_rractivate   38
-#define xeno_ev_rrdeactivate 39
-#define xeno_ev_timeset      40
-#define xeno_ev_addhook      41
-#define xeno_ev_remhook      42
-#define xeno_ev_thrperiodic  43
-#define xeno_ev_thrwait      44
-#define xeno_ev_tsenable     45
-#define xeno_ev_tsdisable    46
-#define xeno_ev_mark         47
-#define xeno_ev_watchdog     48
-
-#define xeno_evthr  0x1
-#define xeno_evirq  0x2
-#define xeno_evsys  0x4
-#define xeno_evall  0x7
-
-#define XNLTT_MAX_EVENTS 64
-
-extern struct xnltt_evmap xnltt_evtable[];
-
-extern int xnltt_filter;
-
-#define xnltt_log_event(ev, args...) \
-do { \
-  if (xnltt_evtable[ev].ltt_filter & xnltt_filter) \
-    ltt_log_std_formatted_event(xnltt_evtable[ev].ltt_evid, ##args); \
-} while(0)
-
-static inline void xnltt_set_filter (int mask)
-{
-    xnltt_filter =3D mask;
-}
-
-static inline void xnltt_stop_tracing (void)
-{
-    xnltt_set_filter(0);
-}
+#include <linux/marker.h>
=20
-void xnltt_log_mark(const char *fmt,
-		    ...);
+#define XNLTT_NOARGS				MARK_NOARGS
=20
-int xnltt_mount(void);
-
-void xnltt_umount(void);
+#define xnltt_log_event(ev, fmt, args...)	trace_mark(ev, fmt, ##args)
=20
 #else /* !CONFIG_LTT */
=20
-#define xnltt_log_event(ev, args...); /* Eat the semi-colon. */
-
-static inline void xnltt_log_mark (const char *fmt, ...)
-{
-}
-
-static inline void xnltt_set_filter (int mask)
-{
-}
-
-static inline void xnltt_stop_tracing (void)
-{
-}
+#define xnltt_log_event(ev, fmt, args...)	do { } while (0)
=20
 #endif /* CONFIG_LTT */
=20
Index: xenomai/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -98,9 +98,8 @@ void xnintr_clock_handler(void)
=20
 	xnarch_announce_tick();
=20
-	xnltt_log_event(xeno_ev_ienter, XNARCH_TIMER_IRQ);
-	xnltt_log_event(xeno_ev_tstick, nktbase.name,
-			xnpod_current_thread()->name);
+	xnltt_log_event(xn_nucleus_irq_enter, "irq %d", XNARCH_TIMER_IRQ);
+	xnltt_log_event(xn_nucleus_tbase_tick, "base %s", nktbase.name);
=20
 	++sched->inesting;
=20
@@ -124,7 +123,7 @@ void xnintr_clock_handler(void)
 		xnarch_relay_tick();
 	}
=20
-	xnltt_log_event(xeno_ev_iexit, XNARCH_TIMER_IRQ);
+	xnltt_log_event(xn_nucleus_irq_exit, "irq %d", XNARCH_TIMER_IRQ);
 	xnstat_exectime_switch(sched, prev);
 }
=20
@@ -168,7 +167,7 @@ static void xnintr_shirq_handler(unsigne
=20
 	prev  =3D xnstat_exectime_get_current(sched);
 	start =3D xnstat_exectime_now();
-	xnltt_log_event(xeno_ev_ienter, irq);
+	xnltt_log_event(xn_nucleus_irq_enter, "irq %d", irq);
=20
 	++sched->inesting;
=20
@@ -212,7 +211,7 @@ static void xnintr_shirq_handler(unsigne
 	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
 		xnpod_schedule();
=20
-	xnltt_log_event(xeno_ev_iexit, irq);
+	xnltt_log_event(xn_nucleus_irq_exit, "irq %d", irq);
 	xnstat_exectime_switch(sched, prev);
 }
=20
@@ -233,7 +232,7 @@ static void xnintr_edge_shirq_handler(un
=20
 	prev  =3D xnstat_exectime_get_current(sched);
 	start =3D xnstat_exectime_now();
-	xnltt_log_event(xeno_ev_ienter, irq);
+	xnltt_log_event(xn_nucleus_irq_enter, "irq %d", irq);
=20
 	++sched->inesting;
=20
@@ -292,7 +291,7 @@ static void xnintr_edge_shirq_handler(un
 	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
 		xnpod_schedule();
=20
-	xnltt_log_event(xeno_ev_iexit, irq);
+	xnltt_log_event(xn_nucleus_irq_exit, "irq %d", irq);
 	xnstat_exectime_switch(sched, prev);
 }
=20
@@ -443,7 +442,7 @@ static void xnintr_irq_handler(unsigned=20
=20
 	prev  =3D xnstat_exectime_get_current(sched);
 	start =3D xnstat_exectime_now();
-	xnltt_log_event(xeno_ev_ienter, irq);
+	xnltt_log_event(xn_nucleus_irq_enter, "irq %d", irq);
=20
 	++sched->inesting;
=20
@@ -490,7 +489,7 @@ static void xnintr_irq_handler(unsigned=20
 	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
 		xnpod_schedule();
=20
-	xnltt_log_event(xeno_ev_iexit, irq);
+	xnltt_log_event(xn_nucleus_irq_exit, "irq %d", irq);
 	xnstat_exectime_switch(sched, prev);
 }
=20
Index: xenomai/ksrc/nucleus/ltt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/ltt.c
+++ /dev/null
@@ -1,186 +0,0 @@
-/*
- * Copyright (C) 2004 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
=2Enet>
- * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA
- * 02139, USA; either version 2 of the License, or (at your option)
- * any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <stdarg.h>
-#include <nucleus/ltt.h>
-
-void xnltt_log_mark(const char *fmt, ...)
-{
-	char markbuf[64];	/* Don't eat too much stack space. */
-	va_list ap;
-
-	if (xnltt_evtable[xeno_ev_mark].ltt_filter & xnltt_filter) {
-		va_start(ap, fmt);
-		vsnprintf(markbuf, sizeof(markbuf), fmt, ap);
-		va_end(ap);
-		ltt_log_std_formatted_event(xnltt_evtable[xeno_ev_mark].
-					    ltt_evid, markbuf);
-	}
-}
-
-int __init xnltt_mount(void)
-{
-	int ev, evid;
-
-	/* Create all custom LTT events we need. */
-
-	for (ev =3D 0; xnltt_evtable[ev].ltt_label !=3D NULL; ev++) {
-		evid =3D ltt_create_event(xnltt_evtable[ev].ltt_label,
-					xnltt_evtable[ev].ltt_format,
-					LTT_CUSTOM_EV_FORMAT_TYPE_STR, NULL);
-		if (evid < 0) {
-			while (--ev >=3D 0) {
-				xnltt_evtable[ev].ltt_evid =3D -1;
-				ltt_destroy_event(xnltt_evtable[ev].ltt_evid);
-			}
-
-			return evid;
-		}
-
-		xnltt_evtable[ev].ltt_evid =3D evid;
-	}
-
-#ifdef CONFIG_XENO_OPT_FILTER_EVALL
-	xnltt_filter =3D ~xeno_evall;
-#else /* !CONFIG_XENO_OPT_FILTER_EVALL */
-#ifdef CONFIG_XENO_OPT_FILTER_EVIRQ
-	xnltt_filter &=3D ~xeno_evirq;
-#endif /* CONFIG_XENO_OPT_FILTER_EVIRQ */
-#ifdef CONFIG_XENO_OPT_FILTER_EVTHR
-	xnltt_filter &=3D ~xeno_evthr;
-#endif /* CONFIG_XENO_OPT_FILTER_EVTHR */
-#ifdef CONFIG_XENO_OPT_FILTER_EVSYS
-	xnltt_filter &=3D ~xeno_evthr;
-#endif /* CONFIG_XENO_OPT_FILTER_EVSYS */
-#endif /* CONFIG_XENO_OPT_FILTER_EVALL */
-
-	return 0;
-}
-
-void __exit xnltt_umount(void)
-{
-	int ev;
-
-	for (ev =3D 0; xnltt_evtable[ev].ltt_evid !=3D -1; ev++)
-		ltt_destroy_event(xnltt_evtable[ev].ltt_evid);
-}
-
-struct xnltt_evmap xnltt_evtable[] =3D {
-
-	[xeno_ev_ienter] =3D {"Xenomai i-enter", "irq=3D%d", -1, xeno_evirq},
-	[xeno_ev_iexit] =3D {"Xenomai i-exit", "irq=3D%d", -1, xeno_evirq},
-	[xeno_ev_resched] =3D {"Xenomai resched", NULL, -1, xeno_evthr},
-	[xeno_ev_smpsched] =3D {"Xenomai smpsched", NULL, -1, xeno_evthr},
-	[xeno_ev_fastsched] =3D {"Xenomai fastsched", NULL, -1, xeno_evthr},
-	[xeno_ev_switch] =3D {"Xenomai ctxsw", "%s -> %s", -1, xeno_evthr},
-	[xeno_ev_fault] =3D
-	    {"Xenomai fault", "thread=3D%s, location=3D%p, trap=3D%d", -1,
-	     xeno_evall},
-	[xeno_ev_callout] =3D
-	    {"Xenomai callout", "type=3D%s, thread=3D%s", -1, xeno_evall},
-	[xeno_ev_finalize] =3D {"Xenomai finalize", "%s -> %s", -1, xeno_evall}=
,
-	[xeno_ev_thrinit] =3D
-	    {"Xenomai thread init", "thread=3D%s, flags=3D0x%x", -1, xeno_evthr=
},
-	[xeno_ev_thrstart] =3D
-	    {"Xenomai thread start", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_threstart] =3D
-	    {"Xenomai thread restart", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_thrdelete] =3D
-	    {"Xenomai thread delete", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_thrsuspend] =3D {"Xenomai thread suspend",
-				"thread=3D%s, mask=3D0x%x, timeout=3D%Lu, wchan=3D%p",
-				-1, xeno_evthr},
-	[xeno_ev_thresume] =3D
-	    {"Xenomai thread resume", "thread=3D%s, mask=3D0x%x", -1, xeno_evth=
r},
-	[xeno_ev_thrunblock] =3D
-	    {"Xenomai thread unblock", "thread=3D%s, status=3D0x%x", -1,
-	     xeno_evthr},
-	[xeno_ev_threnice] =3D
-	    {"Xenomai thread renice", "thread=3D%s, prio=3D%d", -1, xeno_evthr}=
,
-	[xeno_ev_cpumigrate] =3D
-	    {"Xenomai CPU migrate", "thread=3D%s, cpu=3D%d", -1, xeno_evthr},
-	[xeno_ev_sigdispatch] =3D
-	    {"Xenomai sigdispatch", "thread=3D%s, sigpend=3D0x%x", -1, xeno_eva=
ll},
-	[xeno_ev_thrboot] =3D
-	    {"Xenomai thread begin", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_tstick] =3D {"Xenomai time source tick",
-			    "base=3D%s, runthread=3D%s", -1, xeno_evirq},
-	[xeno_ev_sleepon] =3D
-	    {"Xenomai sleepon", "thread=3D%s, sync=3D%p", -1, xeno_evthr},
-	[xeno_ev_wakeup1] =3D
-	    {"Xenomai wakeup1", "thread=3D%s, sync=3D%p", -1, xeno_evthr},
-	[xeno_ev_wakeupx] =3D
-	    {"Xenomai wakeupx", "thread=3D%s, sync=3D%p", -1, xeno_evthr},
-	[xeno_ev_syncflush] =3D
-	    {"Xenomai syncflush", "sync=3D%p, reason=3D0x%x", -1, xeno_evthr},
-	[xeno_ev_syncforget] =3D
-	    {"Xenomai syncforget", "thread=3D%s, sync=3D%p", -1, xeno_evthr},
-	[xeno_ev_lohandler] =3D
-	    {"Xenomai lohandler", "type=3D%d, task=3D%s, pid=3D%d", -1, xeno_ev=
all},
-	[xeno_ev_primarysw] =3D {"Xenomai modsw1", "thread=3D%s", -1, xeno_evth=
r},
-	[xeno_ev_primary] =3D {"Xenomai modex1", "thread=3D%s", -1, xeno_evthr}=
,
-	[xeno_ev_secondarysw] =3D {"Xenomai modsw2", "thread=3D%s", -1, xeno_ev=
thr},
-	[xeno_ev_secondary] =3D {"Xenomai modex2", "thread=3D%s", -1, xeno_evth=
r},
-	[xeno_ev_shadowmap] =3D
-	    {"Xenomai shadow map", "thread=3D%s, pid=3D%d, prio=3D%d", -1,
-	     xeno_evthr},
-	[xeno_ev_shadowunmap] =3D
-	    {"Xenomai shadow unmap", "thread=3D%s, pid=3D%d", -1, xeno_evthr},
-	[xeno_ev_shadowstart] =3D
-	    {"Xenomai shadow start", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_syscall] =3D
-	    {"Xenomai syscall", "thread=3D%s, skin=3D%d, call=3D%d", -1, xeno_e=
vsys},
-	[xeno_ev_shadowexit] =3D
-	    {"Xenomai shadow exit", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_thrsetmode] =3D
-	    {"Xenomai thread setmode", "thread=3D%s, clrmask=3D0x%x, setmask=3D=
0x%x",
-	     -1,
-	     xeno_evthr},
-	[xeno_ev_rdrotate] =3D
-	    {"Xenomai rotate readyq", "thread=3D%s, prio=3D%d", -1, xeno_evthr}=
,
-	[xeno_ev_rractivate] =3D {"Xenomai RR on", "quantum=3D%Lu", -1, xeno_ev=
thr},
-	[xeno_ev_rrdeactivate] =3D {"Xenomai RR off", NULL, -1, xeno_evthr},
-	[xeno_ev_timeset] =3D {"Xenomai set time", "newtime=3D%Lu", -1, xeno_ev=
all},
-	[xeno_ev_addhook] =3D
-	    {"Xenomai add hook", "type=3D%d, routine=3D%p", -1, xeno_evall},
-	[xeno_ev_remhook] =3D
-	    {"Xenomai remove hook", "type=3D%d, routine=3D%p", -1, xeno_evall},=

-	[xeno_ev_thrperiodic] =3D
-	    {"Xenomai thread speriod", "thread=3D%s, idate=3D%Lu, period=3D%Lu"=
, -1,
-	     xeno_evthr},
-	[xeno_ev_thrwait] =3D
-	    {"Xenomai thread wperiod", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_tsenable] =3D
-	    {"Xenomai enable time source", "tick=3D%u ns", -1, xeno_evall},
-	[xeno_ev_tsdisable] =3D {"Xenomai disable time source", NULL, -1, xeno_=
evall},
-	[xeno_ev_mark] =3D {"Xenomai **mark**", "%s", -1, xeno_evall},
-	[xeno_ev_watchdog] =3D
-	    {"Xenomai watchdog", "runthread=3D%s", -1, xeno_evall},
-	{NULL, NULL, -1, 0},
-};
-
-int xnltt_filter =3D xeno_evall;
-
-EXPORT_SYMBOL(xnltt_evtable);
-EXPORT_SYMBOL(xnltt_filter);
-EXPORT_SYMBOL(xnltt_log_mark);
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -167,9 +167,9 @@ void xnpod_watchdog_handler(xntimer_t *t
 	}
 	=09
 	if (unlikely(++sched->wdcount >=3D CONFIG_XENO_OPT_WATCHDOG_TIMEOUT)) {=

-		xnltt_log_event(xeno_ev_watchdog, thread->name);
+		xnltt_log_event(xeno_ev_watchdog, "%s", xnthread_name(thread));
 		xnprintf("watchdog triggered -- killing runaway thread '%s'\n",
-			 thread->name);
+			 xnthread_name(thread));
 		xnpod_delete_thread(thread);
 		xnpod_reset_watchdog(sched);
 	}
@@ -181,7 +181,7 @@ void xnpod_schedule_handler(void) /* Cal
 {
 	xnsched_t *sched =3D xnpod_current_sched();
=20
-	xnltt_log_event(xeno_ev_smpsched);
+	xnltt_log_event(xeno_ev_smpsched, XNLTT_NOARGS);
 #if defined(CONFIG_SMP) && defined(CONFIG_XENO_OPT_PRIOCPL)
 	if (testbits(sched->status, XNRPICK)) {
 		clrbits(sched->status, XNRPICK);
@@ -549,11 +549,12 @@ static inline void xnpod_switch_zombie(x
 	int shadow =3D xnthread_test_state(threadout, XNSHADOW);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
=20
-	xnltt_log_event(xeno_ev_finalize, threadout->name, threadin->name);
+	xnltt_log_event(xeno_ev_finalize, "%s %s",
+			threadout->name, threadin->name);
=20
 	if (!emptyq_p(&nkpod->tdeleteq) && !xnthread_test_state(threadout, XNRO=
OT)) {
-		xnltt_log_event(xeno_ev_callout, "SELF-DELETE",
-				threadout->name);
+		xnltt_log_event(xeno_ev_callout, "%s %s",
+				"SELF-DELETE", threadout->name);
 		xnpod_fire_callouts(&nkpod->tdeleteq, threadout);
 	}
=20
@@ -703,7 +704,8 @@ int xnpod_init_thread(xnthread_t *thread
 	if (err)
 		return err;
=20
-	xnltt_log_event(xeno_ev_thrinit, thread->name, flags);
+	xnltt_log_event(xeno_thread_init, "%s %p %lu %d",
+			xnthread_name(thread), thread, flags, prio);
=20
 	xnlock_get_irqsave(&nklock, s);
 	thread->sched =3D xnpod_current_sched();
@@ -835,7 +837,8 @@ int xnpod_start_thread(xnthread_t *threa
 	if (xnthread_test_state(thread, XNRRB))
 		thread->rrcredit =3D thread->rrperiod;
=20
-	xnltt_log_event(xeno_ev_thrstart, thread->name);
+	xnltt_log_event(xeno_thread_start, "%s %p",
+			xnthread_name(thread), thread);
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (xnthread_test_state(thread, XNSHADOW)) {
@@ -859,7 +862,8 @@ int xnpod_start_thread(xnthread_t *threa
 #endif /* __XENO_SIM__ */
=20
 	if (!emptyq_p(&nkpod->tstartq) && !xnthread_test_state(thread, XNROOT))=
 {
-		xnltt_log_event(xeno_ev_callout, "START", thread->name);
+		xnltt_log_event(xeno_ev_callout, "%s %s",
+				"START", xnthread_name(thread));
 		xnpod_fire_callouts(&nkpod->tstartq, thread);
 	}
=20
@@ -916,7 +920,8 @@ void xnpod_restart_thread(xnthread_t *th
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_threstart, thread->name);
+	xnltt_log_event(xeno_thread_restart, "%s %p",
+			xnthread_name(thread), thread);
=20
 	/* Break the thread out of any wait it is currently in. */
 	xnpod_unblock_thread(thread);
@@ -1032,7 +1037,8 @@ xnflags_t xnpod_set_thread_mode(xnthread
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thrsetmode, thread->name, clrmask, setmask);
+	xnltt_log_event(xeno_ev_thrsetmode, "%s %lu %lu",
+			xnthread_name(thread), clrmask, setmask);
=20
 #ifndef CONFIG_XENO_OPT_ISHIELD
 	setmask &=3D ~XNSHIELD;
@@ -1165,7 +1171,8 @@ void xnpod_delete_thread(xnthread_t *thr
 	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
=20
-	xnltt_log_event(xeno_ev_thrdelete, thread->name);
+	xnltt_log_event(xeno_thread_delete, "%s %p",
+			xnthread_name(thread), thread);
=20
 	removeq(&nkpod->threadq, &thread->glink);
 	nkpod->threadq_rev++;
@@ -1202,8 +1209,8 @@ void xnpod_delete_thread(xnthread_t *thr
 	} else {
 		if (!emptyq_p(&nkpod->tdeleteq)
 		    && !xnthread_test_state(thread, XNROOT)) {
-			xnltt_log_event(xeno_ev_callout, "DELETE",
-					thread->name);
+			xnltt_log_event(xeno_ev_callout, "%s %s",
+					"DELETE", xnthread_name(thread));
 			xnpod_fire_callouts(&nkpod->tdeleteq, thread);
 		}
=20
@@ -1350,7 +1357,9 @@ void xnpod_suspend_thread(xnthread_t *th
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thrsuspend, thread->name, mask, timeout, wchan)=
;
+	xnltt_log_event(xeno_thread_suspend, "%s %p %lu %Lu %d %p",
+			xnthread_name(thread), thread, mask, timeout,
+			timeout_mode, wchan);
=20
 	sched =3D thread->sched;
=20
@@ -1530,7 +1539,8 @@ void xnpod_resume_thread(xnthread_t *thr
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thresume, thread->name, mask);
+	xnltt_log_event(xeno_thread_resume, "%s %p %lu",
+			xnthread_name(thread), thread, mask);
 	xnarch_trace_pid(xnthread_user_task(thread) ?
 			 xnarch_user_pid(xnthread_archtcb(thread)) : -1,
 			 xnthread_current_priority(thread));
@@ -1671,7 +1681,9 @@ int xnpod_unblock_thread(xnthread_t *thr
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thrunblock, xnthread_name(thread), xnthread_sta=
te_flags(thread));
+	xnltt_log_event(xeno_thread_unblock, "%s %p %lu",
+			xnthread_name(thread), thread,
+			xnthread_state_flags(thread));
=20
 	if (xnthread_test_state(thread, XNDELAY))
 		xnpod_resume_thread(thread, XNDELAY);
@@ -1754,7 +1766,8 @@ void xnpod_renice_thread_inner(xnthread_
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_threnice, thread->name, prio);
+	xnltt_log_event(xeno_thread_renice, "%s %p %d",
+			xnthread_name(thread), thread, prio);
=20
 	oldprio =3D thread->cprio;
=20
@@ -1835,7 +1848,8 @@ int xnpod_migrate_thread(int cpu)
 	if (cpu =3D=3D xnarch_current_cpu())
 		goto unlock_and_exit;
=20
-	xnltt_log_event(xeno_ev_cpumigrate, thread->name, cpu);
+	xnltt_log_event(xeno_ev_cpumigrate, "%s %d",
+			xnthread_name(thread), cpu);
=20
 #ifdef CONFIG_XENO_HW_FPU
 	if (xnthread_test_state(thread, XNFPU)) {
@@ -1920,7 +1934,8 @@ void xnpod_rotate_readyq(int prio)
 	if (sched_emptypq_p(&sched->readyq))
 		goto unlock_and_exit;	/* Nobody is ready. */
=20
-	xnltt_log_event(xeno_ev_rdrotate, sched->runthread, prio);
+	xnltt_log_event(xeno_ev_rdrotate, "%s %d",
+			xnthread_name(sched->runthread), prio);
=20
 	/* There is _always_ a running thread, ultimately the root
 	   one. Use the base priority, not the priority boost. */
@@ -1974,7 +1989,7 @@ void xnpod_activate_rr(xnticks_t quantum
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_rractivate, quantum);
+	xnltt_log_event(xeno_ev_rractivate, "%Lu", quantum);
=20
 	holder =3D getheadq(&nkpod->threadq);
=20
@@ -2019,7 +2034,7 @@ void xnpod_deactivate_rr(void)
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_rrdeactivate);
+	xnltt_log_event(xeno_ev_rrdeactivate, XNLTT_NOARGS);
=20
 	holder =3D getheadq(&nkpod->threadq);
=20
@@ -2061,7 +2076,8 @@ void xnpod_dispatch_signals(void)
 	    || thread->asr =3D=3D XNTHREAD_INVALID_ASR)
 		return;
=20
-	xnltt_log_event(xeno_ev_sigdispatch, thread->name, thread->signals);
+	xnltt_log_event(xeno_ev_sigdispatch, "%s %lu",
+			xnthread_name(thread), thread->signals);
=20
 	/* Start the asynchronous service routine */
 	oldmode =3D xnthread_test_state(thread, XNTHREAD_MODE_BITS);
@@ -2102,7 +2118,7 @@ void xnpod_dispatch_signals(void)
=20
 void xnpod_welcome_thread(xnthread_t *thread, int imask)
 {
-	xnltt_log_event(xeno_ev_thrboot, thread->name);
+	xnltt_log_event(xeno_ev_thrboot, "%s", xnthread_name(thread));
=20
 	xnarch_trace_pid(-1, xnthread_current_priority(thread));
=20
@@ -2346,7 +2362,7 @@ void xnpod_schedule(void)
 	if (xnarch_escalate())
 		return;
=20
-	xnltt_log_event(xeno_ev_resched);
+	xnltt_log_event(xeno_ev_resched, XNLTT_NOARGS);
 #endif /* __KERNEL__ */
=20
 	/* No immediate rescheduling is possible if an ISR or callout
@@ -2442,7 +2458,9 @@ void xnpod_schedule(void)
 	    !xnthread_test_state(threadout, XNRESTART))
 		goto signal_unlock_and_exit;
=20
-	xnltt_log_event(xeno_ev_switch, threadout->name, threadin->name);
+	xnltt_log_event(xeno_thread_switch, "%s %p %s %p",
+			xnthread_name(threadout), threadout,
+			xnthread_name(threadin), threadin);
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	shadow =3D xnthread_test_state(threadout, XNSHADOW);
@@ -2509,7 +2527,8 @@ void xnpod_schedule(void)
 #endif /* __XENO_SIM__ */
=20
 	if (!emptyq_p(&nkpod->tswitchq) && !xnthread_test_state(runthread, XNRO=
OT)) {
-		xnltt_log_event(xeno_ev_callout, "SWITCH", runthread->name);
+		xnltt_log_event(xeno_ev_callout, "%s %s",
+				"SWITCH", xnthread_name(runthread));
 		xnpod_fire_callouts(&nkpod->tswitchq, runthread);
 	}
=20
@@ -2553,7 +2572,7 @@ void xnpod_schedule_runnable(xnthread_t=20
 	xnsched_t *sched =3D thread->sched;
 	xnthread_t *runthread =3D sched->runthread, *threadin;
=20
-	xnltt_log_event(xeno_ev_fastsched);
+	xnltt_log_event(xeno_ev_fastsched, XNLTT_NOARGS);
 	xnarch_trace_pid(xnthread_user_task(thread) ?
 			 xnarch_user_pid(xnthread_archtcb(thread)) : -1,
 			 xnthread_current_priority(thread));
@@ -2719,7 +2738,7 @@ int xnpod_add_hook(int type, void (*rout
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_addhook, type, routine);
+	xnltt_log_event(xeno_ev_addhook, "%d %p", type, routine);
=20
 	switch (type) {
 	case XNHOOK_THREAD_START:
@@ -2789,7 +2808,7 @@ int xnpod_remove_hook(int type, void (*r
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_remhook, type, routine);
+	xnltt_log_event(xeno_ev_remhook, "%d %p", type, routine);
=20
 	switch (type) {
 	case XNHOOK_THREAD_START:
@@ -2873,9 +2892,9 @@ int xnpod_trap_fault(xnarch_fltinfo_t *f
=20
 	thread =3D xnpod_current_thread();
=20
-	xnltt_log_event(xeno_ev_fault,
-			thread->name,
-			xnarch_fault_pc(fltinfo), xnarch_fault_trap(fltinfo));
+	xnltt_log_event(xeno_ev_fault, "%s %p %lu %d", xnthread_name(thread),
+			thread, xnarch_fault_pc(fltinfo),
+			xnarch_fault_trap(fltinfo));
=20
 #ifdef __KERNEL__
 	if (xnarch_fault_fpu_p(fltinfo)) {
@@ -3012,7 +3031,7 @@ int xnpod_enable_timesource(void)
 		return err;
 	}
=20
-	xnltt_log_event(xeno_ev_tsenable);
+	xnltt_log_event(xeno_ev_tsenable, XNLTT_NOARGS);
=20
 #ifdef CONFIG_XENO_OPT_STATS
 	/*
@@ -3111,7 +3130,7 @@ void xnpod_disable_timesource(void)
 	spl_t s;
 	int cpu;
=20
-	xnltt_log_event(xeno_ev_tsdisable);
+	xnltt_log_event(xeno_ev_tsdisable, XNLTT_NOARGS);
=20
 	xnlock_get_irqsave(&nklock, s);
=20
@@ -3201,7 +3220,9 @@ int xnpod_set_thread_periodic(xnthread_t
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thrperiodic, thread->name, idate, period);
+	xnltt_log_event(xeno_thread_set_periodic, "%s %p %Lu %Lu %p",
+			xnthread_name(thread), thread, idate, period,
+			&thread->ptimer);
=20
 	if (period =3D=3D XN_INFINITE) {
 		if (xntimer_running_p(&thread->ptimer))
@@ -3304,7 +3325,8 @@ int xnpod_wait_thread_period(unsigned lo
 		goto unlock_and_exit;
 	}
=20
-	xnltt_log_event(xeno_ev_thrwait, thread->name);
+	xnltt_log_event(xeno_thread_wait_period, "%s %p",
+			xnthread_name(thread), thread);
=20
 	/* Work with either TSC or periodic ticks. */
 	tbase =3D xnthread_time_base(thread);
@@ -3322,9 +3344,13 @@ int xnpod_wait_thread_period(unsigned lo
 	}
=20
 	overruns =3D xntimer_get_overruns(&thread->ptimer, now);
-	if (overruns)
+	if (overruns) {
 		err =3D -ETIMEDOUT;
=20
+		xnltt_log_event(xeno_thread_missed_period, "%s %p %lu",
+				xnthread_name(thread), thread, overruns);
+	}
+
 	if (likely(overruns_r !=3D NULL))
 		*overruns_r =3D overruns;
=20
Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -881,7 +881,9 @@ static void lostage_handler(void *cookie
 		struct task_struct *p =3D rq->req[reqnum].task;
 		rq->out =3D (reqnum + 1) & (LO_MAX_REQUESTS - 1);
=20
-		xnltt_log_event(xeno_ev_lohandler, reqnum, p->comm, p->pid);
+		xnltt_log_event(xn_nucleus_lostage_work,
+				"reqnum %d comm %s pid %d",
+				reqnum, p->comm, p->pid);
=20
 		switch (rq->req[reqnum].type) {
 		case LO_UNMAP_REQ:
@@ -1094,7 +1096,9 @@ redo:
 	   preemption and using the TASK_ATOMICSWITCH cumulative state
 	   provided by Adeos to Linux tasks. */
=20
-	xnltt_log_event(xeno_ev_primarysw, this_task->comm);
+	xnltt_log_event(xn_nucleus_shadow_go_hard,
+			"thread %p thread_name %s comm %s",
+			thread, thread->name, this_task->comm);
=20
 	gk->thread =3D thread;
 	xnthread_set_info(thread, XNATOMIC);
@@ -1141,7 +1145,8 @@ redo:
 	if (rpi_p(thread))
 		rpi_clear_remote(thread);
=20
-	xnltt_log_event(xeno_ev_primary, thread->name);
+	xnltt_log_event(xn_nucleus_shadow_hardened, "thread %p thread_name %s",=

+			thread, thread->name);
=20
 	return 0;
 }
@@ -1186,7 +1191,8 @@ void xnshadow_relax(int notify)
 	   domain to the Linux domain.  This will cause the Linux task
 	   to resume using the register state of the shadow thread. */
=20
-	xnltt_log_event(xeno_ev_secondarysw, thread->name);
+	xnltt_log_event(xn_nucleus_shadow_go_relax, "thread %p thread_name %s",=

+			thread, thread->name);
=20
 	ishield_on(thread);
=20
@@ -1231,7 +1237,9 @@ void xnshadow_relax(int notify)
 	/* "current" is now running into the Linux domain on behalf of the
 	   root thread. */
=20
-	xnltt_log_event(xeno_ev_secondary, current->comm);
+	xnltt_log_event(xn_nucleus_shadow_relaxed,
+			"thread %p thread_name %s comm %s",
+			thread, thread->name, current->comm);
 }
=20
 void xnshadow_exit(void)
@@ -1327,8 +1335,9 @@ int xnshadow_map(xnthread_t *thread, xnc
 		}
 	}
=20
-	xnltt_log_event(xeno_ev_shadowmap,
-			thread->name, current->pid,
+	xnltt_log_event(xn_nucleus_shadow_map,
+			"thread %p thread_name %s pid %d priority %d",
+			thread, thread->name, current->pid,
 			xnthread_base_priority(thread));
=20
 	/* Switch on propagation of normal kernel events for the bound
@@ -1387,7 +1396,9 @@ void xnshadow_unmap(xnthread_t *thread)
 	xnthread_clear_state(thread, XNMAPPED);
 	rpi_pop(thread);
=20
-	xnltt_log_event(xeno_ev_shadowunmap, thread->name, p ? p->pid : -1);
+	xnltt_log_event(xn_nucleus_shadow_unmap,
+			"thread %p thread_name %s pid %d",
+			thread, thread->name, p ? p->pid : -1);
=20
 	if (!p)
 		return;
@@ -1450,7 +1461,8 @@ void xnshadow_start(xnthread_t *thread)
 	struct task_struct *p =3D xnthread_archtcb(thread)->user_task;
=20
 	rpi_push(thread);	/* A shadow always starts in relaxed mode. */
-	xnltt_log_event(xeno_ev_shadowstart, thread->name);
+	xnltt_log_event(xn_nucleus_shadow_start, "thread %p thread_name %s",
+			thread, thread->name);
 	xnpod_resume_thread(thread, XNDORMANT);
=20
 	if (p->state =3D=3D TASK_INTERRUPTIBLE)
@@ -1898,7 +1910,9 @@ static inline int do_hisyscall_event(uns
 	muxid =3D __xn_mux_id(regs);
 	muxop =3D __xn_mux_op(regs);
=20
-	xnltt_log_event(xeno_ev_syscall, thread->name, muxid, muxop);
+	xnltt_log_event(xn_nucleus_syscall_histage,
+			"thread %p thread_name %s muxid %d muxop %d",
+			thread, thread ? thread->name : NULL, muxid, muxop);
=20
 	if (muxid < 0 || muxid > XENOMAI_MUX_NR ||
 	    muxop < 0 || muxop >=3D muxtable[muxid].props->nrcalls) {
@@ -2073,8 +2087,10 @@ static inline int do_losyscall_event(uns
 	muxid =3D __xn_mux_id(regs);
 	muxop =3D __xn_mux_op(regs);
=20
-	xnltt_log_event(xeno_ev_syscall,
-			xnpod_active_p() ? xnpod_current_thread()->name : "<system>",
+	xnltt_log_event(xn_nucleus_syscall_lostage,
+			"thread %p thread_name %s muxid %d muxop %d",
+			xnpod_active_p() ? xnpod_current_thread() : NULL,
+			xnpod_active_p() ? xnpod_current_thread()->name : NULL,
 			muxid, muxop);
=20
 	/* Processing a real-time skin syscall. */
@@ -2151,7 +2167,8 @@ static inline void do_taskexit_event(str
 	xnpod_schedule();
=20
 	xnshadow_dereference_skin(magic);
-	xnltt_log_event(xeno_ev_shadowexit, thread->name);
+	xnltt_log_event(xn_nucleus_shadow_exit,
+			"thread %p thread_name %s", thread, thread->name);
 }
=20
 RTHAL_DECLARE_EXIT_EVENT(taskexit_event);
Index: xenomai/ksrc/nucleus/synch.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/synch.c
+++ xenomai/ksrc/nucleus/synch.c
@@ -174,7 +174,9 @@ void xnsynch_sleep_on(xnsynch_t *synch,=20
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_sleepon, thread->name, synch);
+	xnltt_log_event(xn_nucleus_synch_sleepon,
+			"thread %p thread_name %s sync %p",
+			thread, thread->name, synch);
=20
 	if (!testbits(synch->status, XNSYNCH_PRIO)) { /* i.e. FIFO */
 		appendpq(&synch->pendq, &thread->plink);
@@ -388,7 +390,9 @@ xnthread_t *xnsynch_wakeup_one_sleeper(x
 		thread->wchan =3D NULL;
 		synch->owner =3D thread;
 		xnthread_set_info(thread, XNWAKEN);
-		xnltt_log_event(xeno_ev_wakeup1, thread->name, synch);
+		xnltt_log_event(xn_nucleus_synch_wakeup_one,
+				"thread %p thread_name %s sync %p",
+				thread, thread->name, synch);
 		xnpod_resume_thread(thread, XNPEND);
 	} else
 		synch->owner =3D NULL;
@@ -461,7 +465,9 @@ xnpholder_t *xnsynch_wakeup_this_sleeper
 	thread->wchan =3D NULL;
 	synch->owner =3D thread;
 	xnthread_set_info(thread, XNWAKEN);
-	xnltt_log_event(xeno_ev_wakeupx, thread->name, synch);
+	xnltt_log_event(xn_nucleus_synch_wakeup_all,
+			"thread %p thread_name %s synch %p",
+			thread, thread->name, synch);
 	xnpod_resume_thread(thread, XNPEND);
=20
 	if (testbits(synch->status, XNSYNCH_CLAIMED))
@@ -531,7 +537,8 @@ int xnsynch_flush(xnsynch_t *synch, xnfl
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_syncflush, synch, reason);
+	xnltt_log_event(xn_nucleus_synch_flush, "synch %p reason %lu",
+			synch, reason);
=20
 	status =3D emptypq_p(&synch->pendq) ? XNSYNCH_DONE : XNSYNCH_RESCHED;
=20
@@ -577,7 +584,9 @@ void xnsynch_forget_sleeper(xnthread_t *
 {
 	xnsynch_t *synch =3D thread->wchan;
=20
-	xnltt_log_event(xeno_ev_syncforget, thread->name, synch);
+	xnltt_log_event(xn_nucleus_synch_forget,
+			"thread %p thread_name %s synch %p",
+			thread, thread->name, synch);
=20
 	xnthread_clear_state(thread, XNPEND);
 	thread->wchan =3D NULL;
Index: xenomai/ksrc/nucleus/timebase.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timebase.c
+++ xenomai/ksrc/nucleus/timebase.c
@@ -469,8 +469,7 @@ void xntbase_tick(xntbase_t *base)
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_tstick, base->name,
-			xnpod_current_thread()->name);
+	xnltt_log_event(xn_nucleus_tbase_tick, "base %s", base->name);
=20
 	if (base =3D=3D &nktbase)
 		xntimer_tick_aperiodic();
@@ -565,7 +564,8 @@ void xntbase_adjust_time(xntbase_t *base
 	}
 #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
=20
-	/* xnltt_log_event(xeno_ev_timeadjust, base->name, delta); */
+	xnltt_log_event(xn_nucleus_tbase_adjust, "base %s delta %Lu",
+			base->name, delta);
 }
=20
 /* The master time base - the most precise one, aperiodic, always valid.=
 */
Index: xenomai/ksrc/nucleus/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/Config.in
+++ xenomai/ksrc/nucleus/Config.in
@@ -60,15 +60,6 @@ if [ "$CONFIG_XENO_OPT_NUCLEUS" !=3D "n" ]
 	fi
 	endmenu
=20
-	if [ "$CONFIG_LTT" !=3D "n" ]; then
-		mainmenu_option next_comment
-		comment 'LTT tracepoints filtering'
-			bool 'Disable IRQ-related tracepoints' CONFIG_XENO_OPT_FILTER_EVIRQ
-			bool 'Disable thread-related tracepoints' CONFIG_XENO_OPT_FILTER_EVTH=
R
-			bool 'Disable syscall-related tracepoints' CONFIG_XENO_OPT_FILTER_EVS=
YS
-			bool 'Disable all tracepoints' CONFIG_XENO_OPT_FILTER_EVALL
-		endmenu
-	fi
 	endmenu
 fi
=20
Index: xenomai/ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/Kconfig
+++ xenomai/ksrc/nucleus/Kconfig
@@ -339,40 +339,4 @@ config XENO_OPT_TIMER_WHEEL_STEP
=20
 endmenu
=20
-menu "LTT tracepoints filtering"
-
-	depends on LTT
-
-config XENO_OPT_FILTER_EVIRQ
-	bool "Disable IRQ-related tracepoints"
-	default y if XENO_OPT_FILTER_EVALL=3Dy
-	help
-
-	When LTT support is active, this option disables tracepoints
-	inside real-time interrupt handlers.
-
-config XENO_OPT_FILTER_EVTHR
-	bool "Disable thread-related tracepoints"
-	default y if XENO_OPT_FILTER_EVALL=3Dy
-	help
-
-	When LTT support is active, this option disables tracepoints
-	inside most thread-related services.
-
-config XENO_OPT_FILTER_EVSYS
-	bool "Disable syscall-related tracepoints"
-	default y if XENO_OPT_FILTER_EVALL=3Dy
-	help
-
-	When LTT support is active, this option disables tracepoints
-	inside the shadow syscall dispatcher.
-
-config XENO_OPT_FILTER_EVALL
-	bool "Disable all tracepoints"
-	help
-
-	This option disables all LTT tracepoints inside Xenomai.
-
-endmenu
-
 endif
Index: xenomai/ksrc/nucleus/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/Makefile
+++ xenomai/ksrc/nucleus/Makefile
@@ -14,8 +14,6 @@ xeno_nucleus-$(CONFIG_XENO_OPT_MAP) +=3D m
=20
 xeno_nucleus-$(CONFIG_XENO_OPT_REGISTRY) +=3D registry.o
=20
-xeno_nucleus-$(CONFIG_LTT) +=3D ltt.o
-
 EXTRA_CFLAGS +=3D -D__IN_XENOMAI__ -Iinclude/xenomai
=20
 else
@@ -35,7 +33,6 @@ opt_objs-$(CONFIG_XENO_OPT_PERVASIVE) +=3D
 opt_objs-$(CONFIG_XENO_OPT_PIPE) +=3D pipe.o
 opt_objs-$(CONFIG_XENO_OPT_MAP) +=3D map.o
 opt_objs-$(CONFIG_XENO_OPT_REGISTRY) +=3D registry.o
-opt_objs-$(CONFIG_LTT) +=3D ltt.o
=20
 xeno_nucleus-objs +=3D $(opt_objs-y)
=20
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -1156,10 +1156,6 @@ int __init __xeno_sys_init(void)
=20
 	xnintr_mount();
=20
-#ifdef CONFIG_LTT
-	xnltt_mount();
-#endif /* CONFIG_LTT */
-
 #ifdef CONFIG_XENO_OPT_PIPE
 	err =3D xnpipe_mount();
=20
@@ -1249,9 +1245,6 @@ void __exit __xeno_sys_exit(void)
 #ifdef CONFIG_XENO_OPT_PIPE
 	xnpipe_umount();
 #endif /* CONFIG_XENO_OPT_PIPE */
-#ifdef CONFIG_LTT
-	xnltt_umount();
-#endif /* CONFIG_LTT */
 #endif /* __KERNEL__ */
=20
 	if (nkmsgbuf)

--------------010405060606060303050908--

--------------enigB3BCFB8196F9E96A98F5DD33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHF9isniDOoMHTA+kRAofwAJ9uZe3PAoe9B83EI2ItqC0BOnWFcwCfcNTR
jRcAuTjBDrtrhQ4JLt4Kgi0=
=2mrT
-----END PGP SIGNATURE-----

--------------enigB3BCFB8196F9E96A98F5DD33--

