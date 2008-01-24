Message-ID: <4798575B.4050604@domain.hid>
Date: Thu, 24 Jan 2008 10:16:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020302080703040302070804"
Subject: [Adeos-main] [PATCH] 2.6.24-x86: fix assembly of IRQ trampolines
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
--------------020302080703040302070804
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Only fair that this bug bit me - I introduced the regression:

As we are fiddling with the stack pointer in
__ipipe_call_root_*irq_handler, we cannot allow the compiler to fetch
arguments from memory with potentially stack-relative addresses. This
actually happened with Kyle's minimalistic x86-64 .config here, causing
a lockup early during boot. Thus we have to restrict the involved
arguments to registers and avoid C-code after the stack pointer was
modified.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------020302080703040302070804
Content-Type: text/x-patch;
 name="fix-irq-trampoline-assembly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-irq-trampoline-assembly.patch"

---
 include/asm-x86/ipipe_32.h |    4 ++--
 include/asm-x86/ipipe_64.h |    9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

Index: b/include/asm-x86/ipipe_32.h
===================================================================
--- a/include/asm-x86/ipipe_32.h
+++ b/include/asm-x86/ipipe_32.h
@@ -82,7 +82,7 @@ static inline void __ipipe_call_root_xir
 			     "jmp ret_from_intr\n\t"
 			     "__xirq_end: cli\n"
 			     : /* no output */
-			     : "a" (~irq), "rm" (handler), "rm" (regs));
+			     : "a" (~irq), "r" (handler), "rm" (regs));
 }
 
 void irq_enter(void);
@@ -112,7 +112,7 @@ static inline void __ipipe_call_root_vir
 			     "call *%1\n\t"
 			     "addl $8,%%esp\n"
 			     : /* no output */
-			     : "a" (irq), "rm" (handler), "d" (cookie));
+			     : "a" (irq), "r" (handler), "d" (cookie));
 	irq_exit();
 	__asm__ __volatile__("jmp ret_from_intr\n\t"
 			     "__virq_end: cli\n"
Index: b/include/asm-x86/ipipe_64.h
===================================================================
--- a/include/asm-x86/ipipe_64.h
+++ b/include/asm-x86/ipipe_64.h
@@ -94,7 +94,7 @@ static inline void __ipipe_call_root_xir
 			     : /* no output */
 			     : [kernel_cs] "i" (__KERNEL_CS),
 			       [vector] "rm" (regs->orig_rax),
-			       [handler] "rm" (handler), "D" (regs)
+			       [handler] "r" (handler), "D" (regs)
 			     : "rax");
 }
 
@@ -105,6 +105,7 @@ static inline void __ipipe_call_root_vir
 						  void (*handler)(unsigned, void *),
 						  void *cookie)
 {
+	irq_enter();
 	__asm__ __volatile__("movq  %%rsp, %%rax\n\t"
 			     "pushq $0\n\t"
 			     "pushq %%rax\n\t"
@@ -122,11 +123,11 @@ static inline void __ipipe_call_root_vir
 			     "movq  %%r9,2*8(%%rsp)\n\t"
 			     "movq  %%r10,1*8(%%rsp)\n\t"
 			     "movq  %%r11,(%%rsp)\n\t"
+			     "call  *%[handler]\n\t"
 			     : /* no output */
-			     : [kernel_cs] "i" (__KERNEL_CS)
+			     : [kernel_cs] "i" (__KERNEL_CS),
+			       [handler] "r" (handler), "D" (irq), "S" (cookie)
 			     : "rax");
-	irq_enter();
-	handler(irq, cookie);
 	irq_exit();
 	__asm__ __volatile__("jmp exit_intr\n\t"
 			     "__virq_end: cli\n"

--------------020302080703040302070804--

