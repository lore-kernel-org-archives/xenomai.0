Message-ID: <4C0692A9.2080806@domain.hid>
Date: Wed, 02 Jun 2010 19:19:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010408020507070109040401"
Subject: [Xenomai-core] [RFC] Break out of endless user space loops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

This is a multi-part message in MIME format.
--------------010408020507070109040401
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi all,

here is the first apparently working prototype for getting hold of
endless user space loops in RT threads. A simple test case of mine now
receive a SIGDEBUG even if it does "while (1);".

The design follows Gilles' suggestion to force a SEGV on victim thread
but restore the patched PC before migrating the thread after this fault.
The only drawback of this approach: We need to keep track of the
preempted register set at I-pipe level. I basically replicated what
Linux does these days as well and exported it as ipipe_get_irq_regs()
(the second patch).

This is an x86-64-only draft which clearly needs more love. I'm open for
suggestions of different abstractions wherever you see a need.

Jan

---
 include/asm-generic/hal.h        |    2 ++
 include/asm-x86/bits/thread_64.h |    1 +
 include/asm-x86/system_64.h      |   26 ++++++++++++++++++++++++++
 ksrc/nucleus/pod.c               |    5 +++++
 ksrc/nucleus/sched.c             |    1 +
 5 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
index 84c1a4d..be6abf0 100644
--- a/include/asm-generic/hal.h
+++ b/include/asm-generic/hal.h
@@ -96,6 +96,8 @@ typedef spinlock_t rthal_spinlock_t;
 #define rthal_irq_cookie(ipd,irq)	__ipipe_irq_cookie(ipd,irq)
 #define rthal_irq_handler(ipd,irq)	__ipipe_irq_handler(ipd,irq)
 
+#define rthal_get_irq_regs()		ipipe_get_irq_regs()
+
 #define rthal_cpudata_irq_hits(ipd,cpu,irq)	__ipipe_cpudata_irq_hits(ipd,cpu,irq)
 
 #ifndef local_irq_save_hw_smp
diff --git a/include/asm-x86/bits/thread_64.h b/include/asm-x86/bits/thread_64.h
index 91b71ed..d163c9e 100644
--- a/include/asm-x86/bits/thread_64.h
+++ b/include/asm-x86/bits/thread_64.h
@@ -33,6 +33,7 @@ static inline void xnarch_init_tcb(xnarchtcb_t * tcb)
 	tcb->ripp = &tcb->rip;
 	tcb->fpup = &tcb->i387;
 	tcb->is_root = 0;
+	tcb->forced_um_exit = 0;
 	/* Must be followed by xnarch_init_thread(). */
 }
 
diff --git a/include/asm-x86/system_64.h b/include/asm-x86/system_64.h
index 4de8693..f023dab 100644
--- a/include/asm-x86/system_64.h
+++ b/include/asm-x86/system_64.h
@@ -60,6 +60,8 @@ typedef struct xnarchtcb {      /* Per-thread arch-dependent block */
 	unsigned long ts_usedfpu: 1;
 	unsigned long cr0_ts: 1;
 
+	unsigned long forced_um_exit: 1;
+
 	unsigned stacksize;         /* Aligned size of stack (bytes) */
 	unsigned long *stackbase;   /* Stack space */
 
@@ -122,6 +124,30 @@ static inline void xnarch_free_stack_mem(void *chunk, u_long bytes)
 	kfree(chunk);
 }
 
+static inline void xnarch_force_userspace_exit(xnarchtcb_t *tcb)
+{
+	struct pt_regs *regs = rthal_get_irq_regs();
+
+	if (user_mode(regs)) {
+		tcb->rip = regs->x86reg_ip;
+		tcb->forced_um_exit = 1;
+		regs->x86reg_ip = 0;
+	}
+}
+
+static inline int
+xnarch_fixup_userspace_exit(xnarchtcb_t *tcb, xnarch_fltinfo_t *fi)
+{
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	if (tcb->forced_um_exit) {
+		fi->regs->x86reg_ip = tcb->rip;
+		tcb->forced_um_exit = 0;
+		return 1;
+	}
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+	return 0;
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 7002a73..bdb5758 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -2547,6 +2547,11 @@ int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo)
 
 	thread = xnpod_current_thread();
 
+	if (xnarch_fixup_userspace_exit(xnthread_archtcb(thread), fltinfo)) {
+		xnshadow_relax(0, 0);
+		return 1;
+	}
+
 	trace_mark(xn_nucleus, thread_fault,
 		   "thread %p thread_name %s ip %p type %d",
 		   thread, xnthread_name(thread),
diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index 0b737a3..64fa0e0 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -100,6 +100,7 @@ static void xnsched_watchdog_handler(struct xntimer *timer)
 			 "'%s'\n", xnthread_name(thread));
 		xnthread_set_info(thread, XNAMOK | XNKICKED);
 		xnshadow_send_sig(thread, SIGDEBUG, SIGDEBUG_WATCHDOG, 1);
+		xnarch_force_userspace_exit(xnthread_archtcb(thread));
 	} else
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 	{
-- 
1.6.0.2

--------------010408020507070109040401
Content-Type: text/x-patch;
 name="ipipe_irq_regs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe_irq_regs.patch"

---
 arch/x86/kernel/ipipe.c      |    4 ++++
 include/linux/ipipe.h        |    5 +++++
 include/linux/ipipe_percpu.h |    3 +++
 kernel/ipipe/core.c          |    3 +++
 4 files changed, 15 insertions(+)

Index: b/arch/x86/kernel/ipipe.c
===================================================================
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -900,11 +900,14 @@ int __ipipe_syscall_root(struct pt_regs
  */
 int __ipipe_handle_irq(struct pt_regs *regs)
 {
+	struct pt_regs *old_regs = __ipipe_get_cpu_var(ipipe_irq_regs);
 	struct ipipe_domain *this_domain, *next_domain;
 	unsigned int vector = regs->orig_ax, irq;
 	struct list_head *head, *pos;
 	int m_ack;
 
+	__ipipe_get_cpu_var(ipipe_irq_regs) = regs;
+
 	if ((long)regs->orig_ax < 0) {
 		vector = ~vector;
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -976,6 +979,7 @@ int __ipipe_handle_irq(struct pt_regs *r
 	__ipipe_walk_pipeline(head);
 
 finalize_nosync:
+	__ipipe_get_cpu_var(ipipe_irq_regs) = old_regs;
 
 	/*
 	 * Given our deferred dispatching model for regular IRQs, we
Index: b/include/linux/ipipe.h
===================================================================
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -245,6 +245,11 @@ static inline void ipipe_irq_unlock(unsi
 	__ipipe_unlock_irq(__ipipe_current_domain, irq);
 }
 
+static inline struct pt_regs *ipipe_get_irq_regs(void)
+{
+	return __ipipe_get_cpu_var(ipipe_irq_regs);
+}
+
 #ifndef __ipipe_sync_pipeline
 #define __ipipe_sync_pipeline(dovirt) __ipipe_sync_stage(dovirt)
 #endif
Index: b/include/linux/ipipe_percpu.h
===================================================================
--- a/include/linux/ipipe_percpu.h
+++ b/include/linux/ipipe_percpu.h
@@ -68,6 +68,9 @@ DECLARE_PER_CPU(struct ipipe_domain *, i
 
 DECLARE_PER_CPU(unsigned long, ipipe_nmi_saved_root);
 
+struct pt_regs;
+DECLARE_PER_CPU(struct pt_regs *, ipipe_irq_regs);
+
 #ifdef CONFIG_IPIPE_DEBUG_CONTEXT
 DECLARE_PER_CPU(int, ipipe_percpu_context_check);
 DECLARE_PER_CPU(int, ipipe_saved_context_check_state);
Index: b/kernel/ipipe/core.c
===================================================================
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -84,6 +84,8 @@ DEFINE_PER_CPU(struct ipipe_domain *, ip
 
 DEFINE_PER_CPU(unsigned long, ipipe_nmi_saved_root); /* Copy of root status during NMI */
 
+DEFINE_PER_CPU(struct pt_regs *, ipipe_irq_regs);
+
 static IPIPE_DEFINE_SPINLOCK(__ipipe_pipelock);
 
 LIST_HEAD(__ipipe_pipeline);
@@ -1940,6 +1942,7 @@ EXPORT_SYMBOL(ipipe_suspend_domain);
 EXPORT_SYMBOL(ipipe_alloc_virq);
 EXPORT_PER_CPU_SYMBOL(ipipe_percpu_domain);
 EXPORT_PER_CPU_SYMBOL(ipipe_percpu_darray);
+EXPORT_PER_CPU_SYMBOL(ipipe_irq_regs);
 EXPORT_SYMBOL(ipipe_root);
 EXPORT_SYMBOL(ipipe_stall_pipeline_from);
 EXPORT_SYMBOL(ipipe_test_and_stall_pipeline_from);

--------------010408020507070109040401--

