Message-ID: <4C07BA95.9080402@domain.hid>
Date: Thu, 03 Jun 2010 16:22:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [RFC][PATCH 2/2] x86: Add support for
	ipipe_get_irq_regs
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

From: Jan Kiszka <jan.kiszka@domain.hid>

Implement the x86 arch bits for ipipe_get_irq_regs support. This allows
to drop __ipipe_tick_regs and use the new service instead.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/include/asm/ipipe.h    |   43 +++++++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/ipipe_32.h |    2 +-
 arch/x86/include/asm/ipipe_64.h |    2 +-
 arch/x86/kernel/ipipe.c         |   26 +++--------------------
 4 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/ipipe.h b/arch/x86/include/asm/ipipe.h
index 4d711dd..971b3f3 100644
--- a/arch/x86/include/asm/ipipe.h
+++ b/arch/x86/include/asm/ipipe.h
@@ -31,8 +31,6 @@
 #define IPIPE_PATCH_NUMBER	4
 #endif
 
-DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
-
 static inline unsigned __ipipe_get_irq_vector(int irq)
 {
 #ifdef CONFIG_X86_IO_APIC
@@ -153,4 +151,45 @@ int __ipipe_check_tickdev(const char *devname);
 #define __ipipe_move_root_irq(irq)	do { } while (0)
 #endif /* !(CONFIG_SMP && CONFIG_IPIPE) */
 
+static inline void
+__ipipe_setup_irq_regs(struct pt_regs **orig_regs, struct pt_regs *saved_regs)
+{
+	*orig_regs = ipipe_get_irq_regs();
+
+	if (*orig_regs)
+		saved_regs->orig_ax = (*orig_regs)->orig_ax;
+	else {
+		saved_regs->flags = X86_EFLAGS_IF;
+		saved_regs->cs = __KERNEL_CS;
+#ifdef CONFIG_X86_32
+		saved_regs->ss = __KERNEL_DS;
+		__asm__ __volatile__ ("here: movl $here, %0\n\t"
+				      "movl %%ebp, %1\n\t"
+				      "movl %%esp, %2\n\t"
+				      : "=m" (saved_regs->ip),
+					"=m" (saved_regs->bp),
+					"=m" (saved_regs->sp));
+#else /* CONFIG_X86_64 */
+		saved_regs->ss = 0;
+		__asm__ __volatile__ ("here: movq $here, %0\n\t"
+				      "movq %%rbp, %1\n\t"
+				      "movq %%rsp, %2\n\t"
+				      : "=m" (saved_regs->ip),
+					"=m" (saved_regs->bp),
+					"=m" (saved_regs->sp));
+#endif /* CONFIG_X86_64 */
+		__ipipe_get_cpu_var(ipipe_irq_regs) = saved_regs;
+	}
+}
+
+static inline void
+__ipipe_cleanup_irq_regs(struct pt_regs *orig_regs,
+			 struct pt_regs *saved_regs)
+{
+	if (orig_regs)
+		orig_regs->orig_ax = saved_regs->orig_ax;
+	else
+		__ipipe_get_cpu_var(ipipe_irq_regs) = NULL;
+}
+
 #endif	/* !__X86_IPIPE_H */
diff --git a/arch/x86/include/asm/ipipe_32.h b/arch/x86/include/asm/ipipe_32.h
index 8d1f4b5..ce3d417 100644
--- a/arch/x86/include/asm/ipipe_32.h
+++ b/arch/x86/include/asm/ipipe_32.h
@@ -65,7 +65,7 @@ void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);
 static inline void __ipipe_call_root_xirq_handler(unsigned irq,
 						  ipipe_irq_handler_t handler)
 {
-	struct pt_regs *regs = &__raw_get_cpu_var(__ipipe_tick_regs);
+	struct pt_regs *regs = ipipe_get_irq_regs();
 
 	regs->orig_ax = ~__ipipe_get_irq_vector(irq);
 
diff --git a/arch/x86/include/asm/ipipe_64.h b/arch/x86/include/asm/ipipe_64.h
index bc427b8..4452662 100644
--- a/arch/x86/include/asm/ipipe_64.h
+++ b/arch/x86/include/asm/ipipe_64.h
@@ -63,7 +63,7 @@ void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);
 static inline void __ipipe_call_root_xirq_handler(unsigned irq,
 						  void (*handler)(unsigned, void *))
 {
-	struct pt_regs *regs = &__raw_get_cpu_var(__ipipe_tick_regs);
+	struct pt_regs *regs = ipipe_get_irq_regs();
 
 	regs->orig_ax = ~__ipipe_get_irq_vector(irq);
 
diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 521ec53..23b6908 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -900,11 +900,14 @@ int __ipipe_syscall_root(struct pt_regs *regs)
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
@@ -976,28 +979,7 @@ int __ipipe_handle_irq(struct pt_regs *regs)
 	__ipipe_walk_pipeline(head);
 
 finalize_nosync:
-
-	/*
-	 * Given our deferred dispatching model for regular IRQs, we
-	 * only record CPU regs for the last timer interrupt, so that
-	 * the timer handler charges CPU times properly. It is assumed
-	 * that other interrupt handlers don't actually care for such
-	 * information.
-	 */
-
-	if (irq == __ipipe_tick_irq) {
-		struct pt_regs *tick_regs = &__raw_get_cpu_var(__ipipe_tick_regs);
-		tick_regs->flags = regs->flags;
-		tick_regs->cs = regs->cs;
-		tick_regs->ip = regs->ip;
-		tick_regs->bp = regs->bp;
-#ifdef CONFIG_X86_64
-		tick_regs->ss = regs->ss;
-		tick_regs->sp = regs->sp;
-#endif
-		if (!ipipe_root_domain_p)
-			tick_regs->flags &= ~X86_EFLAGS_IF;
-	}
+	__ipipe_get_cpu_var(ipipe_irq_regs) = old_regs;
 
 	if (!ipipe_root_domain_p ||
 	    test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))

