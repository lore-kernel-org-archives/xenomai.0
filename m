Message-ID: <4783735F.8080201@domain.hid>
Date: Tue, 08 Jan 2008 13:58:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020502040301070503040402"
Subject: [Adeos-main] [PATCH 3/3] 2.6.24-x86: inline root irq thunks
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

This is a multi-part message in MIME format.
--------------020502040301070503040402
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This is a rebased and reordered version of [1]. Also this patch survived
testing over three different boxes (2, 4, and 8-way).

Jan

[1] https://mail.gna.org/public/adeos-main/2007-12/msg00061.html

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------020502040301070503040402
Content-Type: text/x-patch;
 name="inline-irq-thunks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inline-irq-thunks.patch"

---
 arch/x86/kernel/entry_64.S |   51 +------------------------
 include/asm-x86/ipipe_64.h |   89 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 77 insertions(+), 63 deletions(-)

Index: linux-2.6.24-rc6-xeno_64/arch/x86/kernel/entry_64.S
===================================================================
--- linux-2.6.24-rc6-xeno_64.orig/arch/x86/kernel/entry_64.S
+++ linux-2.6.24-rc6-xeno_64/arch/x86/kernel/entry_64.S
@@ -582,54 +582,8 @@ END(stub_rt_sigreturn)
 #endif
 	.endm
 
-#ifdef CONFIG_IPIPE
-
-	/* %rdi=negated _vector_ number, %rsi=handler, %rdx=regs */
-ENTRY(__ipipe_root_xirq_thunk)
-	movq %rsp, %rax
-	pushq $0
-	pushq %rax
-	pushfq
-	pushq $__KERNEL_CS
-	pushq $1f
-	pushq %rdi
-	XCPT_FRAME
-	SAVE_ARGS
-	movq %rdi, ORIG_RAX(%rdx)	# regs->orig_eax = ~irq_vector
-	movq %rdx, %rdi		     	# regs for handler
-	call *%rsi
-	jmp exit_intr
-	CFI_ENDPROC
-1:
-	cli
-        ret
-END(__ipipe_root_xirq_thunk)
-	
-	/* %rdi=virq number, %rsi=cookie, %rdx=handler */
-ENTRY(__ipipe_root_virq_thunk)
-	movq %rsp, %rax
-	pushq $0
-	pushq %rax
-	pushfq
-	pushq $__KERNEL_CS
-	pushq $1f
-	pushq $-1
-	XCPT_FRAME
-	SAVE_ARGS
-	call irq_enter
-	movq RDI-ARGOFFSET(%rsp), %rdi
-	movq RSI-ARGOFFSET(%rsp), %rsi
-	movq RDX-ARGOFFSET(%rsp), %rdx
-	call *%rdx
-	call irq_exit
-	jmp exit_intr
-	CFI_ENDPROC
-1:
-	cli
-        ret
-END(__ipipe_root_virq_thunk)
-	
 ENTRY(common_interrupt)
+#ifdef CONFIG_IPIPE
 	XCPT_FRAME
 	interrupt __ipipe_handle_irq
 	testl %eax, %eax
@@ -643,7 +597,6 @@ ENTRY(common_interrupt)
 	swapgs
 	jmp restore_args
 #else /* !CONFIG_IPIPE */
-ENTRY(common_interrupt)
 	XCPT_FRAME
 	interrupt do_IRQ
 #endif /* !CONFIG_IPIPE */	
@@ -655,7 +608,7 @@ ret_from_intr:
 	leaveq
 	CFI_DEF_CFA_REGISTER	rsp
 	CFI_ADJUST_CFA_OFFSET	-8
-exit_intr:
+ENTRY(exit_intr)
 	GET_THREAD_INFO(%rcx)
 	testl $3,CS-ARGOFFSET(%rsp)
 	je retint_kernel
Index: linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_64.h
===================================================================
--- linux-2.6.24-rc6-xeno_64.orig/include/asm-x86/ipipe_64.h
+++ linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_64.h
@@ -51,14 +51,6 @@ void __ipipe_serial_debug(const char *fm
 
 unsigned __ipipe_get_irq_vector(int irq);
 
-asmlinkage void __ipipe_root_xirq_thunk(unsigned irq,
-					void (*handler)(unsigned irq, void *cookie),
-					struct pt_regs *regs);
-
-asmlinkage void __ipipe_root_virq_thunk(unsigned irq,
-					void *cookie,
-					void (*handler)(unsigned irq, void *cookie));
-
 static inline unsigned long __ipipe_ffnz(unsigned long ul)
 {
       __asm__("bsrq %1, %0":"=r"(ul)
@@ -72,6 +64,76 @@ void __ipipe_ack_edge_irq(unsigned irq, 
 
 void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);
 
+static inline void __ipipe_call_root_xirq_handler(unsigned irq,
+						  void (*handler)(unsigned, void *))
+{
+	struct pt_regs *regs = &__raw_get_cpu_var(__ipipe_tick_regs);
+
+	regs->orig_rax = ~__ipipe_get_irq_vector(irq);
+
+	__asm__ __volatile__("movq  %%rsp, %%rax\n\t"
+			     "pushq $0\n\t"
+			     "pushq %%rax\n\t"
+			     "pushfq\n\t"
+			     "pushq %[kernel_cs]\n\t"
+			     "pushq $__xirq_end\n\t"
+			     "pushq %[vector]\n\t"
+			     "subq  $9*8,%%rsp\n\t"
+			     "movq  %%rdi,8*8(%%rsp)\n\t"
+			     "movq  %%rsi,7*8(%%rsp)\n\t"
+			     "movq  %%rdx,6*8(%%rsp)\n\t"
+			     "movq  %%rcx,5*8(%%rsp)\n\t"
+			     "movq  %%rax,4*8(%%rsp)\n\t"
+			     "movq  %%r8,3*8(%%rsp)\n\t"
+			     "movq  %%r9,2*8(%%rsp)\n\t"
+			     "movq  %%r10,1*8(%%rsp)\n\t"
+			     "movq  %%r11,(%%rsp)\n\t"
+			     "call  *%[handler]\n\t"
+			     "jmp exit_intr\n\t"
+			     "__xirq_end: cli\n"
+			     : /* no output */
+			     : [kernel_cs] "i" (__KERNEL_CS),
+			       [vector] "rm" (regs->orig_rax),
+			       [handler] "rm" (handler), "D" (regs)
+			     : "rax");
+}
+
+void irq_enter(void);
+void irq_exit(void);
+
+static inline void __ipipe_call_root_virq_handler(unsigned irq,
+						  void (*handler)(unsigned, void *),
+						  void *cookie)
+{
+	__asm__ __volatile__("movq  %%rsp, %%rax\n\t"
+			     "pushq $0\n\t"
+			     "pushq %%rax\n\t"
+			     "pushfq\n\t"
+			     "pushq %[kernel_cs]\n\t"
+			     "pushq $__virq_end\n\t"
+			     "pushq $-1\n\t"
+			     "subq  $9*8,%%rsp\n\t"
+			     "movq  %%rdi,8*8(%%rsp)\n\t"
+			     "movq  %%rsi,7*8(%%rsp)\n\t"
+			     "movq  %%rdx,6*8(%%rsp)\n\t"
+			     "movq  %%rcx,5*8(%%rsp)\n\t"
+			     "movq  %%rax,4*8(%%rsp)\n\t"
+			     "movq  %%r8,3*8(%%rsp)\n\t"
+			     "movq  %%r9,2*8(%%rsp)\n\t"
+			     "movq  %%r10,1*8(%%rsp)\n\t"
+			     "movq  %%r11,(%%rsp)\n\t"
+			     : /* no output */
+			     : [kernel_cs] "i" (__KERNEL_CS)
+			     : "rax");
+	irq_enter();
+	handler(irq, cookie);
+	irq_exit();
+	__asm__ __volatile__("jmp exit_intr\n\t"
+			     "__virq_end: cli\n"
+			     : /* no output */
+			     : /* no input */);
+}
+
 /*
  * When running handlers, enable hw interrupts for all domains but the
  * one heading the pipeline, so that IRQs can never be significantly
@@ -82,13 +144,12 @@ void __ipipe_end_edge_irq(unsigned irq, 
 		local_irq_enable_nohead(ipd);				\
 		if (ipd == ipipe_root_domain) {				\
 			if (likely(!ipipe_virtual_irq_p(irq)))		\
-				__ipipe_root_xirq_thunk(~__ipipe_get_irq_vector(irq),	\
-							(ipd)->irqs[irq].handler,	\
-							&__raw_get_cpu_var(__ipipe_tick_regs)); \
+				__ipipe_call_root_xirq_handler(		\
+					irq, (ipd)->irqs[irq].handler);	\
 			else						\
-				__ipipe_root_virq_thunk(irq, \
-							(ipd)->irqs[irq].cookie, \
-							(ipd)->irqs[irq].handler); \
+				__ipipe_call_root_virq_handler(		\
+					irq, (ipd)->irqs[irq].handler,	\
+					(ipd)->irqs[irq].cookie);	\
 		} else {						\
 			__clear_bit(IPIPE_SYNC_FLAG, &ipipe_cpudom_var(ipd, status)); \
 			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie); \

--------------020502040301070503040402--

