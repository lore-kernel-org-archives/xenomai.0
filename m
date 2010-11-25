Message-ID: <4CEE9306.10704@domain.hid>
Date: Thu, 25 Nov 2010 17:47:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CEE91CB.3060303@domain.hid>
In-Reply-To: <4CEE91CB.3060303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 2/3] ipipe: x86: Push IF as set to stack of
	root IRQ handlers
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

Preemption check of the Linux interrupt tail verifies, among other
things, that IF set for the preempted context. If it's not, no Linux
task switch is initiated. As we fake the context on root IRQ replay, we
must ensure that IF is faked properly as well, otherwise long Linux
rescheduling latencies up to deadlocks can occur.

Based on suggestion by Philippe.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/include/asm/ipipe_32.h |    8 ++++++--
 arch/x86/include/asm/ipipe_64.h |    8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/ipipe_32.h b/arch/x86/include/asm/ipipe_32.h
index 4263a7f..61d7913 100644
--- a/arch/x86/include/asm/ipipe_32.h
+++ b/arch/x86/include/asm/ipipe_32.h
@@ -70,6 +70,7 @@ static inline void __do_root_xirq(ipipe_irq_handler_t handler,
 	regs->orig_ax = ~__ipipe_get_irq_vector(irq);
 
 	__asm__ __volatile__("pushfl\n\t"
+			     "orl %[x86if],(%%esp)\n\t"
 			     "pushl %%cs\n\t"
 			     "pushl $__xirq_end\n\t"
 			     "pushl %%eax\n\t"
@@ -89,7 +90,8 @@ static inline void __do_root_xirq(ipipe_irq_handler_t handler,
 			     "jmp ret_from_intr\n\t"
 			     "__xirq_end: cli\n"
 			     : /* no output */
-			     : "a" (~irq), "r" (handler), "rm" (regs));
+			     : "a" (~irq), "r" (handler), "rm" (regs),
+			       [x86if] "i" (X86_EFLAGS_IF));
 }
 
 #define __ipipe_do_root_xirq(ipd, irq)			\
@@ -103,6 +105,7 @@ static inline void __do_root_virq(ipipe_irq_handler_t handler,
 
 	irq_enter();
 	__asm__ __volatile__("pushfl\n\t"
+			     "orl %[x86if],(%%esp)\n\t"
 			     "pushl %%cs\n\t"
 			     "pushl $__virq_end\n\t"
 			     "pushl $-1\n\t"
@@ -122,7 +125,8 @@ static inline void __do_root_virq(ipipe_irq_handler_t handler,
 			     "call *%1\n\t"
 			     "addl $8,%%esp\n"
 			     : /* no output */
-			     : "a" (irq), "r" (handler), "d" (cookie));
+			     : "a" (irq), "r" (handler), "d" (cookie),
+			       [x86if] "i" (X86_EFLAGS_IF));
 	irq_exit();
 	__asm__ __volatile__("jmp ret_from_intr\n\t"
 			     "__virq_end: cli\n"
diff --git a/arch/x86/include/asm/ipipe_64.h b/arch/x86/include/asm/ipipe_64.h
index b9367f6..c8f2c54 100644
--- a/arch/x86/include/asm/ipipe_64.h
+++ b/arch/x86/include/asm/ipipe_64.h
@@ -71,6 +71,7 @@ static inline void __do_root_xirq(ipipe_irq_handler_t handler,
 			     "pushq $0\n\t"
 			     "pushq %%rax\n\t"
 			     "pushfq\n\t"
+			     "orq %[x86if],(%%rsp)\n\t"
 			     "pushq %[kernel_cs]\n\t"
 			     "pushq $__xirq_end\n\t"
 			     "pushq %[vector]\n\t"
@@ -91,7 +92,8 @@ static inline void __do_root_xirq(ipipe_irq_handler_t handler,
 			     : /* no output */
 			     : [kernel_cs] "i" (__KERNEL_CS),
 			       [vector] "rm" (regs->orig_ax),
-			       [handler] "r" (handler), "D" (regs)
+			       [handler] "r" (handler), "D" (regs),
+			       [x86if] "i" (X86_EFLAGS_IF)
 			     : "rax");
 }
 
@@ -109,6 +111,7 @@ static inline void __do_root_virq(ipipe_irq_handler_t handler,
 			     "pushq $0\n\t"
 			     "pushq %%rax\n\t"
 			     "pushfq\n\t"
+			     "orq %[x86if],(%%rsp)\n\t"
 			     "pushq %[kernel_cs]\n\t"
 			     "pushq $__virq_end\n\t"
 			     "pushq $-1\n\t"
@@ -125,7 +128,8 @@ static inline void __do_root_virq(ipipe_irq_handler_t handler,
 			     "call  *%[handler]\n\t"
 			     : /* no output */
 			     : [kernel_cs] "i" (__KERNEL_CS),
-			       [handler] "r" (handler), "D" (irq), "S" (cookie)
+			       [handler] "r" (handler), "D" (irq),
+			       "S" (cookie), [x86if] "i" (X86_EFLAGS_IF)
 			     : "rax");
 	irq_exit();
 	__asm__ __volatile__("cli\n\t"
-- 
1.7.1

