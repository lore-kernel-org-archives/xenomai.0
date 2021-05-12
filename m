From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 7/7] cobalt/x86: remove kernel support for x86_32
Date: Wed, 12 May 2021 12:05:57 +0200
Message-Id: <5bc2967d2d8981ecdc81e3b721ba349687347f57.1620813957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620813957.git.jan.kiszka@siemens.com>
References: <cover.1620813957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

The legacy x86_32 architecture is on its way out, with no support from
Dovetail. Besides, it went untested with I-pipe configurations for
many moons.

We still keep 32bit compat mode available for building the user-space
libraries and executables though, along with IA32_EMULATION support in
kernel space to cope with legacy applications.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../x86/ipipe/include/asm/xenomai/machine.h   |  4 -
 kernel/cobalt/arch/x86/ipipe/thread.c         | 91 +------------------
 2 files changed, 1 insertion(+), 94 deletions(-)

diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
index bb5ccc1178..aad700fb67 100644
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
+++ b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
@@ -23,11 +23,7 @@
 
 static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
 {
-#ifdef __i386__
-	__asm__("bsfl %1, %0":"=r,r" (ul) : "r,?m" (ul));
-#else
 	__asm__("bsfq %1, %0":"=r" (ul) : "rm" (ul));
-#endif
 	return ul;
 }
 
diff --git a/kernel/cobalt/arch/x86/ipipe/thread.c b/kernel/cobalt/arch/x86/ipipe/thread.c
index f1f81b7503..dd97a5d32c 100644
--- a/kernel/cobalt/arch/x86/ipipe/thread.c
+++ b/kernel/cobalt/arch/x86/ipipe/thread.c
@@ -82,66 +82,6 @@ static inline void x86_fpregs_activate(struct task_struct *t)
  * This is obsolete context switch code uselessly duplicating
  * mainline's.
  */
-#ifdef CONFIG_X86_32
-
-#ifdef CONFIG_CC_STACKPROTECTOR
-
-#define __CANARY_OUTPUT							\
-	, [stack_canary] "=m" (stack_canary.canary)
-
-#define __CANARY_INPUT							\
-	, [task_canary] "i" (offsetof(struct task_struct, stack_canary))
-
-#define __CANARY_SWITCH							\
-	"movl %P[task_canary](%%edx), %%ebx\n\t"			\
-	"movl %%ebx, "__percpu_arg([stack_canary])"\n\t"
-
-#else /* !CONFIG_CC_STACKPROTECTOR */
-
-#define __CANARY_OUTPUT
-#define __CANARY_INPUT
-#define __CANARY_SWITCH
-
-#endif /* !CONFIG_CC_STACKPROTECTOR */
-
-static inline void do_switch_threads(struct xnarchtcb *out_tcb,
-				     struct xnarchtcb *in_tcb,
-				     struct task_struct *outproc,
-				     struct task_struct *inproc)
-{
-	long ebx_out, ecx_out, edi_out, esi_out;
-
-	__asm__ __volatile__("pushfl\n\t"
-			     "pushl %%ebp\n\t"
-			     "movl %[spp_out_ptr],%%ecx\n\t"
-			     "movl %%esp,(%%ecx)\n\t"
-			     "movl %[ipp_out_ptr],%%ecx\n\t"
-			     "movl $1f,(%%ecx)\n\t"
-			     "movl %[spp_in_ptr],%%ecx\n\t"
-			     "movl %[ipp_in_ptr],%%edi\n\t"
-			     "movl (%%ecx),%%esp\n\t"
-			     "pushl (%%edi)\n\t"
-			     __CANARY_SWITCH
-			     "jmp  __switch_to\n\t"
-			     "1: popl %%ebp\n\t"
-			     "popfl\n\t"
-			     : "=b"(ebx_out),
-			       "=&c"(ecx_out),
-			       "=S"(esi_out),
-			       "=D"(edi_out),
-			       "+a"(outproc),
-			       "+d"(inproc)
-			       __CANARY_OUTPUT
-			     : [spp_out_ptr] "m"(out_tcb->spp),
-			       [ipp_out_ptr] "m"(out_tcb->ipp),
-			       [spp_in_ptr] "m"(in_tcb->spp),
-			       [ipp_in_ptr] "m"(in_tcb->ipp)
-			       __CANARY_INPUT
-			     : "memory");
-}
-
-#else /* CONFIG_X86_64 */
-
 #define __SWITCH_CLOBBER_LIST  , "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
 
 #ifdef CONFIG_CC_STACKPROTECTOR
@@ -192,8 +132,6 @@ static inline void do_switch_threads(struct xnarchtcb *out_tcb,
 			     : "memory", "cc" __SWITCH_CLOBBER_LIST);	\
 	})
 
-#endif /* CONFIG_X86_64 */
-
 #else /* LINUX_VERSION_CODE >= 4.8 */
 
 #include <asm/switch_to.h>
@@ -260,13 +198,9 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 	}
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
-#ifdef CONFIG_X86_32
-	do_switch_threads(out_tcb, in_tcb, prev, next);
-#else /* CONFIG_X86_64 */
 	do_switch_threads(prev, next,
 			  out_tcb->spp, in_tcb->spp,
 			  out_tcb->ipp, in_tcb->ipp);
-#endif /* CONFIG_X86_64 */
 	(void)last;
 #else /* LINUX_VERSION_CODE >= 4.8 */
 	switch_to(prev, next, last);
@@ -302,13 +236,8 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 
 #ifndef IPIPE_X86_FPU_EAGER
 
-#ifdef CONFIG_X86_64
 #define XSAVE_PREFIX	"0x48,"
 #define XSAVE_SUFFIX	"q"
-#else
-#define XSAVE_PREFIX
-#define XSAVE_SUFFIX
-#endif
 
 static inline void __do_save_fpu_state(x86_fpustate *fpup)
 {
@@ -327,12 +256,6 @@ static inline void __do_save_fpu_state(x86_fpustate *fpup)
 		return;
 	}
 #endif /* cpu_has_xsave */
-#ifdef CONFIG_X86_32
-	if (cpu_has_fxsr)
-		__asm__ __volatile__("fxsave %0; fnclex":"=m"(*fpup));
-	else
-		__asm__ __volatile__("fnsave %0; fwait":"=m"(*fpup));
-#else /* CONFIG_X86_64 */
 #ifdef CONFIG_AS_FXSAVEQ
 	__asm __volatile__("fxsaveq %0" : "=m" (fpup->fxsave));
 #else /* !CONFIG_AS_FXSAVEQ */
@@ -340,7 +263,6 @@ static inline void __do_save_fpu_state(x86_fpustate *fpup)
 		     : "=m" (fpup->fxsave)
 		     : [fx] "R" (&fpup->fxsave));
 #endif /* !CONFIG_AS_FXSAVEQ */
-#endif /* CONFIG_X86_64 */
 }
 
 static inline void __do_restore_fpu_state(x86_fpustate *fpup)
@@ -360,19 +282,12 @@ static inline void __do_restore_fpu_state(x86_fpustate *fpup)
 		return;
 	}
 #endif /* cpu_has_xsave */
-#ifdef CONFIG_X86_32
-	if (cpu_has_fxsr)
-		__asm__ __volatile__("fxrstor %0": /* no output */ :"m"(*fpup));
-	else
-		__asm__ __volatile__("frstor %0": /* no output */ :"m"(*fpup));
-#else /* CONFIG_X86_64 */
 #ifdef CONFIG_AS_FXSAVEQ
 	__asm__ __volatile__("fxrstorq %0" : : "m" (fpup->fxsave));
 #else /* !CONFIG_AS_FXSAVEQ */
 	__asm__ __volatile__("rex64/fxrstor (%0)"
 		     : : "R" (&fpup->fxsave), "m" (fpup->fxsave));
 #endif /* !CONFIG_AS_FXSAVEQ */
-#endif /* CONFIG_X86_64 */
 }
 
 int xnarch_handle_fpu_fault(struct xnthread *from, 
@@ -434,7 +349,7 @@ void xnarch_leave_root(struct xnthread *root)
 	struct task_struct *const p = current;
 	x86_fpustate *const current_task_fpup = x86_fpustate_ptr(&p->thread);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0) && defined(CONFIG_X86_64)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
 	rootcb->spp = &p->thread.sp;
 	rootcb->ipp = &p->thread.rip;
 #endif
@@ -564,12 +479,8 @@ void xnarch_init_shadow_tcb(struct xnthread *thread)
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
 	tcb->sp = 0;
 	tcb->spp = &p->thread.sp;
-#ifdef CONFIG_X86_32
-	tcb->ipp = &p->thread.ip;
-#else
 	tcb->ipp = &p->thread.rip; /* <!> raw naming intended. */
 #endif
-#endif
 #ifndef IPIPE_X86_FPU_EAGER
 	tcb->fpup = x86_fpustate_ptr(&p->thread);
 	tcb->kfpu_state = NULL;
-- 
2.26.2


