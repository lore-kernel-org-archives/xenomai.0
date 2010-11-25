Message-ID: <4CEE9303.7050601@domain.hid>
Date: Thu, 25 Nov 2010 17:46:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CEE91CB.3060303@domain.hid>
In-Reply-To: <4CEE91CB.3060303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 1/3] ipipe: x86-32: Drop IRQ flag
 virtualization from syscall/interrupt entry/exit
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

The virtualization of the IRQ flag in entry_32.S turned out to be buggy
[1]. Instead of trying to fix it again, this patch removes the
virtualization, conceptually aligning x86-32 with x86-64. This
simplifies quite some code and should help keeping both in sync /wrt
this critical code paths.

[1] http://thread.gmane.org/gmane.linux.kernel.adeos.general/1706

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

Patch is moderately tested (both w/ and w/o IPIPE) and behaved properly
so far. Still, careful review would be welcome.

 arch/x86/include/asm/irqflags.h |   42 ++++++++++--------
 arch/x86/kernel/entry_32.S      |   52 +++++++++--------------
 arch/x86/kernel/ipipe.c         |   88 +-------------------------------------
 3 files changed, 47 insertions(+), 135 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 59c8be8..5c18214 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -213,26 +213,15 @@ static inline unsigned long __raw_local_irq_save(void)
 }
 #else
 
+#define ENABLE_INTERRUPTS(x)	sti
+#define DISABLE_INTERRUPTS(x)	cli
+
 #ifdef CONFIG_IPIPE
-#ifdef CONFIG_X86_32
-#define DISABLE_INTERRUPTS(clobbers)	PER_CPU(ipipe_percpu_darray, %eax); btsl $0,(%eax); sti
-#define ENABLE_INTERRUPTS(clobbers)	call __ipipe_unstall_root
-#else /* CONFIG_X86_64 */
-/* Not worth virtualizing in x86_64 mode. */
-#define DISABLE_INTERRUPTS(clobbers)	cli
-#define ENABLE_INTERRUPTS(clobbers)	sti
-#endif /* CONFIG_X86_64 */
 #define ENABLE_INTERRUPTS_HW_COND	sti
 #define DISABLE_INTERRUPTS_HW_COND	cli
-#define DISABLE_INTERRUPTS_HW(clobbers)	cli
-#define ENABLE_INTERRUPTS_HW(clobbers)	sti
 #else /* !CONFIG_IPIPE */
-#define ENABLE_INTERRUPTS(x)		sti
-#define DISABLE_INTERRUPTS(x)		cli
 #define ENABLE_INTERRUPTS_HW_COND
 #define DISABLE_INTERRUPTS_HW_COND
-#define DISABLE_INTERRUPTS_HW(clobbers)	DISABLE_INTERRUPTS(clobbers)
-#define ENABLE_INTERRUPTS_HW(clobbers)	ENABLE_INTERRUPTS(clobbers)
 #endif /* !CONFIG_IPIPE */
 
 #ifdef CONFIG_X86_64
@@ -323,23 +312,38 @@ static inline int raw_irqs_disabled(void)
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-# if defined(CONFIG_IPIPE) && defined(CONFIG_X86_64)
-#  define TRACE_IRQS_ON				\
+# ifdef CONFIG_IPIPE
+#  ifdef CONFIG_X86_64
+#   define TRACE_IRQS_ON			\
 	call trace_hardirqs_on_thunk;		\
 	pushq %rax;				\
 	PER_CPU(ipipe_percpu_darray, %rax);	\
 	btrl $0,(%rax);				\
 	popq %rax
-#  define TRACE_IRQS_OFF			\
+#   define TRACE_IRQS_OFF			\
 	pushq %rax;				\
 	PER_CPU(ipipe_percpu_darray, %rax);	\
 	btsl $0,(%rax);				\
 	popq %rax;				\
 	call trace_hardirqs_off_thunk
-# else /* !(CONFIG_IPIPE && CONFIG_X86_64) */
+#  else /* CONFIG_X86_32 */
+#   define TRACE_IRQS_ON			\
+	call trace_hardirqs_on_thunk;		\
+	pushl %eax;				\
+	PER_CPU(ipipe_percpu_darray, %eax);	\
+	btrl $0,(%eax);				\
+	popl %eax
+#   define TRACE_IRQS_OFF			\
+	pushl %eax;				\
+	PER_CPU(ipipe_percpu_darray, %eax);	\
+	btsl $0,(%eax);				\
+	popl %eax;				\
+	call trace_hardirqs_off_thunk
+#  endif /* CONFIG_X86_32 */
+# else /* !CONFIG_IPIPE */
 #  define TRACE_IRQS_ON		call trace_hardirqs_on_thunk;
 #  define TRACE_IRQS_OFF	call trace_hardirqs_off_thunk;
-# endif /* !(CONFIG_IPIPE && CONFIG_X86_64) */
+# endif /* !CONFIG_IPIPE */
 #else
 #  define TRACE_IRQS_ON
 #  define TRACE_IRQS_OFF
diff --git a/arch/x86/kernel/entry_32.S b/arch/x86/kernel/entry_32.S
index 4fc229b..cc382bc 100644
--- a/arch/x86/kernel/entry_32.S
+++ b/arch/x86/kernel/entry_32.S
@@ -82,25 +82,20 @@
 #define nr_syscalls ((syscall_table_size)/4)
 
 #ifdef CONFIG_IPIPE
-#define EMULATE_ROOT_IRET(bypass) \
-				call __ipipe_unstall_iret_root ; \
-				TRACE_IRQS_ON ; \
-				bypass: \
-				movl PT_EAX(%esp),%eax
-#define TEST_PREEMPTIBLE(regs)  call __ipipe_kpreempt_root ; testl %eax,%eax
-#define CATCH_ROOT_SYSCALL(bypass1,bypass2)	\
+#define CATCH_ROOT_SYSCALL(bypass_check,bypass_nocheck)	\
 				movl  %esp,%eax ; \
 				call __ipipe_syscall_root ; \
 				testl  %eax,%eax ; \
-				js    bypass1 ; \
-				jne   bypass2 ; \
+				movl PT_EAX(%esp),%eax ; \
+				js    bypass_check ; \
+				jne   bypass_nocheck ; \
 				movl PT_ORIG_EAX(%esp),%eax
 #define PUSH_XCODE(v)		pushl $ ex_ ## v
 #define PUSH_XVEC(v)		pushl $ ex_ ## v
 #define HANDLE_EXCEPTION(code)	movl %code,%ecx ; \
 				call __ipipe_handle_exception ; \
 				testl %eax,%eax	; \
-				jnz restore_ret
+				jnz restore_nocheck
 #define DIVERT_EXCEPTION(code)	movl $(__USER_DS), %ecx	; \
 				movl %ecx, %ds ; \
 				movl %ecx, %es ; \
@@ -108,7 +103,8 @@
 				movl $ex_ ## code,%edx ; \
 				call __ipipe_divert_exception ; \
 				testl %eax,%eax	; \
-				jnz restore_ret
+				jnz restore_nocheck
+#define PREEMPT_SCHEDULE_IRQ	call __ipipe_preempt_schedule_irq
 
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
 # define IPIPE_TRACE_IRQ_ENTER \
@@ -125,17 +121,16 @@
 #define IPIPE_TRACE_IRQ_EXIT
 #endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
 #else /* !CONFIG_IPIPE */
-#define EMULATE_ROOT_IRET(bypass)
-#define TEST_PREEMPTIBLE(regs)		testl $X86_EFLAGS_IF,PT_EFLAGS(regs)
-#define CATCH_ROOT_SYSCALL(bypass1,bypass2)
+#define CATCH_ROOT_SYSCALL(bypass_check,bypass_nocheck)
 #define PUSH_XCODE(v)			pushl $v
 #define PUSH_XVEC(v)			pushl v
 #define HANDLE_EXCEPTION(code)		call *%code
 #define DIVERT_EXCEPTION(code)
+#define PREEMPT_SCHEDULE_IRQ		call preempt_schedule_irq
 #endif /* CONFIG_IPIPE */
 	
 #ifdef CONFIG_PREEMPT
-#define preempt_stop(clobbers)	DISABLE_INTERRUPTS_HW(clobbers); TRACE_IRQS_OFF
+#define preempt_stop(clobbers)	DISABLE_INTERRUPTS(clobbers); TRACE_IRQS_OFF
 #else
 #define preempt_stop(clobbers)
 #define resume_kernel		restore_all
@@ -429,15 +424,16 @@ END(ret_from_exception)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
+	DISABLE_INTERRUPTS(CLBR_ANY)
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_all
 need_resched:
 	movl TI_flags(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
-   	TEST_PREEMPTIBLE(%esp)		# interrupts off (exception path) ?
+	testl $X86_EFLAGS_IF,PT_EFLAGS(%esp)	# interrupts off (exception path) ?
 	jz restore_all
-	call preempt_schedule_irq
+	PREEMPT_SCHEDULE_IRQ
 	jmp need_resched
 END(resume_kernel)
 #endif
@@ -487,7 +483,7 @@ sysenter_past_esp:
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
-	ENABLE_INTERRUPTS_HW(CLBR_NONE)
+	ENABLE_INTERRUPTS(CLBR_NONE)
 
 /*
  * Load the potential sixth argument from user stack.
@@ -503,7 +499,7 @@ sysenter_past_esp:
 .previous
 
 	GET_THREAD_INFO(%ebp)
-	CATCH_ROOT_SYSCALL(sysenter_tail,sysenter_out)
+	CATCH_ROOT_SYSCALL(sysenter_tail,sysenter_exit)
 
 	testl $_TIF_WORK_SYSCALL_ENTRY,TI_flags(%ebp)
 	jnz sysenter_audit
@@ -521,13 +517,10 @@ sysenter_tail:
 	jne sysexit_audit
 sysenter_exit:
 /* if something modifies registers it must also disable sysexit */
- 	EMULATE_ROOT_IRET(sysenter_out)
 	movl PT_EIP(%esp), %edx
 	movl PT_OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
-#ifndef CONFIG_IPIPE
-  	TRACE_IRQS_ON
-#endif
+	TRACE_IRQS_ON
 1:	mov  PT_FS(%esp), %fs
 	PTGS_TO_GS
 	ENABLE_INTERRUPTS_SYSEXIT
@@ -592,7 +585,7 @@ ENTRY(system_call)
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
- 	CATCH_ROOT_SYSCALL(syscall_exit,restore_ret)
+ 	CATCH_ROOT_SYSCALL(syscall_exit,restore_nocheck)
 					# system call tracing in operation / emulation
 	testl $_TIF_WORK_SYSCALL_ENTRY,TI_flags(%ebp)
 	jnz syscall_trace_entry
@@ -625,10 +618,6 @@ restore_all_notrace:
 	CFI_REMEMBER_STATE
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
-#ifdef CONFIG_IPIPE
-	call __ipipe_unstall_iret_root
-#endif /* CONFIG_IPIPE */
-restore_ret:
 	RESTORE_REGS 4			# skip orig_eax/error_code
 	CFI_ADJUST_CFA_OFFSET -4
 irq_return:
@@ -690,7 +679,7 @@ ldt_ss:
 	/* Disable interrupts, but do not irqtrace this section: we
 	 * will soon execute iret and the tracer was already set to
 	 * the irqstate after the iret */
-	DISABLE_INTERRUPTS_HW(CLBR_EAX)
+	DISABLE_INTERRUPTS(CLBR_EAX)
 	lss (%esp), %esp		/* switch to espfix segment */
 	CFI_ADJUST_CFA_OFFSET -8
 	jmp restore_nocheck
@@ -720,6 +709,7 @@ work_resched:
 
 work_notifysig:				# deal with pending signals and
 					# notify-resume requests
+	ENABLE_INTERRUPTS_HW_COND
 #ifdef CONFIG_VM86
 	testl $X86_EFLAGS_VM, PT_EFLAGS(%esp)
 	movl %esp, %eax
@@ -931,7 +921,7 @@ common_interrupt:
 	IPIPE_TRACE_IRQ_EXIT
 	testl %eax,%eax
 	jnz  ret_from_intr
-	jmp restore_ret
+	jmp restore_nocheck
 	CFI_ENDPROC
 
 	.pushsection .kprobes.text, "ax"
@@ -947,7 +937,7 @@ ENTRY(name)				\
 	IPIPE_TRACE_IRQ_EXIT;		\
 	testl %eax,%eax;		\
 	jnz  ret_from_intr;		\
-	jmp restore_ret;	\
+	jmp restore_nocheck;	\
 	CFI_ENDPROC
 
 #define BUILD_INTERRUPT(name, nr)	BUILD_INTERRUPT3(name, nr, smp_##name)
diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 6720ba8..c943fca 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -393,72 +393,7 @@ static inline void __fixup_if(int s, struct pt_regs *regs)
 		regs->flags |= X86_EFLAGS_IF;
 }
 
-#ifdef CONFIG_X86_32
-
-/*
- * Check the stall bit of the root domain to make sure the existing
- * preemption opportunity upon in-kernel resumption could be
- * exploited. In case a rescheduling could take place, the root stage
- * is stalled before the hw interrupts are re-enabled. This routine
- * must be called with hw interrupts off.
- */
-
-asmlinkage int __ipipe_kpreempt_root(struct pt_regs regs)
-{
-	if (test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
-		/* Root stage is stalled: rescheduling denied. */
-		return 0;
-
-	__ipipe_stall_root();
-	trace_hardirqs_off();
-	local_irq_enable_hw_notrace();
-
-	return 1;	/* Ok, may reschedule now. */
-}
-
-asmlinkage void __ipipe_unstall_iret_root(struct pt_regs regs)
-{
-	struct ipipe_percpu_domain_data *p;
-
-	/* Emulate IRET's handling of the interrupt flag. */
-
-	local_irq_disable_hw();
-
-	p = ipipe_root_cpudom_ptr();
-
-	/*
-	 * Restore the software state as it used to be on kernel
-	 * entry. CAUTION: NMIs must *not* return through this
-	 * emulation.
-	 */
-	if (raw_irqs_disabled_flags(regs.flags)) {
-		if (!__test_and_set_bit(IPIPE_STALL_FLAG, &p->status))
-			trace_hardirqs_off();
-		if (!__ipipe_pipeline_head_p(ipipe_root_domain))
-			regs.flags |= X86_EFLAGS_IF;
-	} else {
-		if (test_bit(IPIPE_STALL_FLAG, &p->status)) {
-			trace_hardirqs_on();
-			__clear_bit(IPIPE_STALL_FLAG, &p->status);
-		}
-		/*
-		 * We could have received and logged interrupts while
-		 * stalled in the syscall path: play the log now to
-		 * release any pending event. The SYNC_BIT prevents
-		 * infinite recursion in case of flooding.
-		 */
-		if (unlikely(__ipipe_ipending_p(p)))
-			__ipipe_sync_pipeline();
-	}
-#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
-	ipipe_trace_end(0x8000000D);
-#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
-}
-
-#else /* !CONFIG_X86_32 */
-
 #ifdef CONFIG_PREEMPT
-
 asmlinkage void preempt_schedule_irq(void);
 
 void __ipipe_preempt_schedule_irq(void)
@@ -492,11 +427,8 @@ void __ipipe_preempt_schedule_irq(void)
 
 	__local_irq_restore_nosync(flags);  
 }
-
 #endif	/* CONFIG_PREEMPT */
 
-#endif /* !CONFIG_X86_32 */
-
 void __ipipe_halt_root(void)
 {
 	struct ipipe_percpu_domain_data *p;
@@ -739,7 +671,6 @@ int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 
 int __ipipe_syscall_root(struct pt_regs *regs)
 {
-	struct ipipe_percpu_domain_data *p;
 	unsigned long flags;
         int ret;
 
@@ -765,30 +696,17 @@ int __ipipe_syscall_root(struct pt_regs *regs)
 		__ipipe_dispatch_event(IPIPE_EVENT_RETURN, regs);
 	}
 
-        if (!ipipe_root_domain_p) {
-#ifdef CONFIG_X86_32
-		local_irq_restore_hw(flags);
-#endif
+	if (!ipipe_root_domain_p)
 		return 1;
-	}
 
-	p = ipipe_root_cpudom_ptr();
-#ifdef CONFIG_X86_32
-	/*
-	 * Fix-up only required on 32-bit as only here the IRET return code
-	 * will evaluate the flags.
-	 */
-	__fixup_if(test_bit(IPIPE_STALL_FLAG, &p->status), regs);
-#endif
 	/*
 	 * If allowed, sync pending VIRQs before _TIF_NEED_RESCHED is
 	 * tested.
 	 */
-	if (__ipipe_ipending_p(p))
+	if (__ipipe_ipending_p(ipipe_root_cpudom_ptr()))
 		__ipipe_sync_pipeline();
-#ifdef CONFIG_X86_64
+
 	if (!ret)
-#endif
 		local_irq_restore_hw(flags);
 
 	return -ret;
-- 
1.7.1

