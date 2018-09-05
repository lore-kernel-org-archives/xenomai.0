From: Philippe Gerum <rpm@xenomai.org>
Date: Wed, 5 Sep 2018 17:21:58 +0200
Message-Id: <E1fxZtS-00068V-K9@xenomai.org>
Subject: [Xenomai] [I-PIPE][PATCH 4/7] arm64: ipipe: route traps to co-kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Cc: xenomai@xenomai.org

This commit introduces the changes redirecting traps and exceptions to
the interrupt pipeline, so that the co-kernel can be made aware early
on. The co-kernel may then decide whether the fault should be
propagated to the regular kernel for actual handling.

This is typically useful for allowing the co-kernel to downgrade the
current context from the head domain to the root domain, when leaving
the burden of handling major faults to the regular kernel makes more
sense than expecting the co-kernel to reinvent such a wheel
(e.g. memory violations, illegal instructions, divide by zero etc). As
a matter of fact, optimizing latency upon such events would not make
much sense anyway.
---
 arch/arm64/include/asm/ipipe_base.h |  10 +++
 arch/arm64/kernel/ptrace.c          |   6 +-
 arch/arm64/kernel/traps.c           |   9 ++-
 arch/arm64/mm/fault.c               | 118 +++++++++++++++++++++++++++++++++---
 4 files changed, 131 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/ipipe_base.h b/arch/arm64/include/asm/ipipe_base.h
index e3f8d4f45201..a7c07a1c4271 100644
--- a/arch/arm64/include/asm/ipipe_base.h
+++ b/arch/arm64/include/asm/ipipe_base.h
@@ -80,6 +80,16 @@ unsigned __ipipe_processor_id(void);
 
 /* ARM64 traps */
 #define IPIPE_TRAP_MAYDAY        0	/* Internal recovery trap */
+#define IPIPE_TRAP_ACCESS	 1	/* Data or instruction access exception */
+#define IPIPE_TRAP_SECTION	 2	/* Section fault */
+#define IPIPE_TRAP_DABT		 3	/* Generic data abort */
+#define IPIPE_TRAP_UNKNOWN	 4	/* Unknown exception */
+#define IPIPE_TRAP_BREAK	 5	/* Instruction breakpoint */
+#define IPIPE_TRAP_FPU_ACC	 6	/* Floating point access */
+#define IPIPE_TRAP_FPU_EXC	 7	/* Floating point exception */
+#define IPIPE_TRAP_UNDEFINSTR	 8	/* Undefined instruction */
+#define IPIPE_TRAP_ALIGNMENT	 9	/* Unaligned access exception */
+#define IPIPE_NR_FAULTS         10
 
 #endif /* CONFIG_IPIPE */
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index edaf346d13d5..176860103491 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -185,10 +185,12 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 		.si_code	= TRAP_HWBKPT,
 		.si_addr	= (void __user *)(bkpt->trigger),
 	};
+	int i __maybe_unused;
 
-#ifdef CONFIG_COMPAT
-	int i;
+	if (__ipipe_report_trap(IPIPE_TRAP_BREAK, regs))
+		return;
 
+#ifdef CONFIG_COMPAT
 	if (!is_compat_task())
 		goto send_sig;
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4fc0e958770b..c109209d1611 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -294,7 +294,7 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 }
 
 static LIST_HEAD(undef_hook);
-static DEFINE_RAW_SPINLOCK(undef_lock);
+static IPIPE_DEFINE_RAW_SPINLOCK(undef_lock);
 
 void register_undef_hook(struct undef_hook *hook)
 {
@@ -418,6 +418,9 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	if (call_undef_hook(regs) == 0)
 		return;
 
+	if (__ipipe_report_trap(IPIPE_TRAP_UNDEFINSTR, regs))
+		return;
+ 
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
 }
 
@@ -646,6 +649,10 @@ asmlinkage void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr)
 {
 	siginfo_t info;
 	void __user *pc = (void __user *)instruction_pointer(regs);
+
+	if (__ipipe_report_trap(IPIPE_TRAP_UNKNOWN, regs))
+		return;
+
 	console_verbose();
 
 	pr_crit("Bad EL0 synchronous exception detected on CPU%d, code 0x%08x -- %s\n",
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5edb706aacb0..7dc5906d586f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -61,6 +61,68 @@ static inline const struct fault_info *esr_to_fault_info(unsigned int esr)
 	return fault_info + (esr & 63);
 }
 
+#ifdef CONFIG_IPIPE
+/*
+ * We need to synchronize the virtual interrupt state with the hard
+ * interrupt state we received on entry, then turn hardirqs back on to
+ * allow code which does not require strict serialization to be
+ * preempted by an out-of-band activity.
+ *
+ * TRACING: the entry code already told lockdep and tracers about the
+ * hard interrupt state on entry to fault handlers, so no need to
+ * reflect changes to that state via calls to trace_hardirqs_*
+ * helpers. From the main kernel's point of view, there is no change.
+ */
+static inline
+unsigned long fault_entry(struct pt_regs *regs)
+{
+	unsigned long flags;
+	int nosync = 1;
+
+	flags = hard_local_irq_save();
+	if (hard_irqs_disabled_flags(flags))
+		nosync = __test_and_set_bit(IPIPE_STALL_FLAG,
+					    &__ipipe_root_status);
+	hard_local_irq_enable();
+
+	return arch_mangle_irq_bits(flags, nosync);
+}
+
+static inline void fault_exit(unsigned long flags)
+{
+	int nosync;
+
+	IPIPE_WARN_ONCE(hard_irqs_disabled());
+
+	/*
+	 * '!nosync' here means that we had to turn on the stall bit
+	 * in fault_entry() to mirror the hard interrupt state,
+	 * because hard irqs were off but the stall bit was
+	 * clear. Conversely, nosync in fault_exit() means that the
+	 * stall bit state currently reflects the hard interrupt state
+	 * we received on fault_entry().
+	 */
+	nosync = arch_demangle_irq_bits(&flags);
+	if (!nosync) {
+		hard_local_irq_disable();
+		__clear_bit(IPIPE_STALL_FLAG, &__ipipe_root_status);
+		if (!hard_irqs_disabled_flags(flags))
+			hard_local_irq_enable();
+	} else if (hard_irqs_disabled_flags(flags))
+		hard_local_irq_disable();
+}
+
+#else
+
+static inline unsigned long fault_entry(struct pt_regs *regs)
+{
+	return 0;
+}
+
+static inline void fault_exit(unsigned long x) { }
+
+#endif	/* !CONFIG_IPIPE */
+
 #ifdef CONFIG_KPROBES
 static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
 {
@@ -337,6 +399,7 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 {
 	struct task_struct *tsk = current;
 	const struct fault_info *inf;
+	unsigned long irqflags;
 
 	/*
 	 * If we are in kernel mode at this point, we have no context to
@@ -344,8 +407,15 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 	 */
 	if (user_mode(regs)) {
 		inf = esr_to_fault_info(esr);
+		irqflags = fault_entry(regs);
 		__do_user_fault(tsk, addr, esr, inf->sig, inf->code, regs, 0);
+		fault_exit(irqflags);
 	} else
+		/*
+		 * I-pipe: kernel faults are either quickly
+		 * recoverable via fixup, or lethal. In both cases, we
+		 * can skip the interrupt state synchronization.
+		 */
 		__do_kernel_fault(addr, esr, regs);
 }
 
@@ -400,11 +470,13 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	int fault, sig, code, major = 0;
-	unsigned long vm_flags = VM_READ | VM_WRITE;
+	unsigned long vm_flags = VM_READ | VM_WRITE, irqflags;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
+	irqflags = fault_entry(regs);
+
 	if (notify_page_fault(regs, esr))
-		return 0;
+		goto out;
 
 	tsk = current;
 	mm  = tsk->mm;
@@ -475,7 +547,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		if (fatal_signal_pending(current)) {
 			if (!user_mode(regs))
 				goto no_context;
-			return 0;
+			goto out;
 		}
 
 		/*
@@ -511,7 +583,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 				      addr);
 		}
 
-		return 0;
+		goto out;
 	}
 
 	/*
@@ -528,7 +600,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 * oom-killed).
 		 */
 		pagefault_out_of_memory();
-		return 0;
+		goto out;
 	}
 
 	if (fault & VM_FAULT_SIGBUS) {
@@ -552,11 +624,14 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	}
 
 	__do_user_fault(tsk, addr, esr, sig, code, regs, fault);
+out:
+	fault_exit(irqflags);
+
 	return 0;
 
 no_context:
 	__do_kernel_fault(addr, esr, regs);
-	return 0;
+	goto out;
 }
 
 /*
@@ -580,6 +655,8 @@ static int __kprobes do_translation_fault(unsigned long addr,
 					  unsigned int esr,
 					  struct pt_regs *regs)
 {
+	/* I-pipe: hard irqs may be on upon el1_sync. */
+
 	if (addr < TASK_SIZE)
 		return do_page_fault(addr, esr, regs);
 
@@ -610,8 +687,11 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
 	struct siginfo info;
 	const struct fault_info *inf;
+	unsigned long irqflags;
 	int ret = 0;
 
+	irqflags = fault_entry(regs);
+
 	inf = esr_to_fault_info(esr);
 	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
 		inf->name, esr, addr);
@@ -640,6 +720,8 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		info.si_addr  = (void __user *)addr;
 	arm64_notify_die("", regs, &info, esr);
 
+	fault_exit(irqflags);
+
 	return ret;
 }
 
@@ -734,11 +816,14 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 					 struct pt_regs *regs)
 {
 	const struct fault_info *inf = esr_to_fault_info(esr);
+	unsigned long irqflags;
 	struct siginfo info;
 
 	if (!inf->fn(addr, esr, regs))
 		return;
 
+	irqflags = fault_entry(regs);
+
 	pr_alert("Unhandled fault: %s (0x%08x) at 0x%016lx\n",
 		 inf->name, esr, addr);
 
@@ -749,11 +834,17 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 	info.si_code  = inf->code;
 	info.si_addr  = (void __user *)addr;
 	arm64_notify_die("", regs, &info, esr);
+
+	fault_exit(irqflags);
 }
 
 asmlinkage void __exception do_el0_irq_bp_hardening(void)
 {
-	/* PC has already been checked in entry.S */
+	/*
+	 * PC has already been checked in entry.S
+	 * I-pipe: assume that branch predictor hardening
+	 * workarounds can safely run on any stage.
+	 */
 	arm64_apply_bp_hardening();
 }
 
@@ -769,7 +860,7 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 	if (addr > TASK_SIZE)
 		arm64_apply_bp_hardening();
 
-	local_irq_enable();
+	local_irq_enable_full();
 	do_mem_abort(addr, esr, regs);
 }
 
@@ -783,13 +874,16 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 {
 	struct siginfo info;
 	struct task_struct *tsk = current;
+	unsigned long irqflags;
 
 	if (user_mode(regs)) {
 		if (instruction_pointer(regs) > TASK_SIZE)
 			arm64_apply_bp_hardening();
-		local_irq_enable();
+		local_irq_enable_full();
 	}
 
+	irqflags = fault_entry(regs);
+
 	if (show_unhandled_signals && unhandled_signal(tsk, SIGBUS))
 		pr_info_ratelimited("%s[%d]: %s exception: pc=%p sp=%p\n",
 				    tsk->comm, task_pid_nr(tsk),
@@ -801,6 +895,8 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 	info.si_code  = BUS_ADRALN;
 	info.si_addr  = (void __user *)addr;
 	arm64_notify_die("Oops - SP/PC alignment exception", regs, &info, esr);
+
+	fault_exit(irqflags);
 }
 
 int __init early_brk64(unsigned long addr, unsigned int esr,
@@ -839,6 +935,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 					      struct pt_regs *regs)
 {
 	const struct fault_info *inf = debug_fault_info + DBG_ESR_EVT(esr);
+	unsigned long irqflags;
 	struct siginfo info;
 	int rv;
 
@@ -855,6 +952,8 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	if (!inf->fn(addr, esr, regs)) {
 		rv = 1;
 	} else {
+		irqflags = fault_entry(regs);
+
 		pr_alert("Unhandled debug exception: %s (0x%08x) at 0x%016lx\n",
 			 inf->name, esr, addr);
 
@@ -863,6 +962,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 		info.si_code  = inf->code;
 		info.si_addr  = (void __user *)addr;
 		arm64_notify_die("", regs, &info, 0);
+		fault_exit(irqflags);
 		rv = 0;
 	}
 
-- 
2.14.4


