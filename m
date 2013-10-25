From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 26 Oct 2013 00:03:46 +0200
Message-Id: <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <526AEA7E.6030801@xenomai.org>
References: <526AEA7E.6030801@xenomai.org>
Subject: [Xenomai] [PATCH 1/7] cobalt/fpu: remove xnarch_init_fpu,
	it is no longer used
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 kernel/cobalt/arch/arm/thread.c     |   30 ------------------------------
 kernel/cobalt/arch/powerpc/thread.c |    9 ---------
 kernel/cobalt/arch/sh/thread.c      |   14 --------------
 3 files changed, 53 deletions(-)

diff --git a/kernel/cobalt/arch/arm/thread.c b/kernel/cobalt/arch/arm/thread.c
index e29c607..a73eded 100644
--- a/kernel/cobalt/arch/arm/thread.c
+++ b/kernel/cobalt/arch/arm/thread.c
@@ -33,20 +33,6 @@ asmlinkage void __asm_thread_trampoline(void);
 
 #ifdef CONFIG_XENO_HW_FPU
 
-static inline void do_init_fpu(struct arm_fpustate *fpuenv)
-{
-	fp_init(&fpuenv->fpstate);
-#if defined(CONFIG_VFP)
-	/* vfpstate has already been zeroed by xnarch_init_fpu */
-	fpuenv->vfpstate.hard.fpexc = FPEXC_EN;
-	fpuenv->vfpstate.hard.fpscr = FPSCR_ROUND_NEAREST;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 2, 0)			\
-     || defined(CONFIG_VFP_3_2_BACKPORT)) && defined(CONFIG_SMP)
-	fpuenv->vfpstate.hard.cpu = NR_CPUS;
-#endif /* linux >= 3.2.0 */
-#endif
-}
-
 #define task_fpenv(task)						\
 	((struct arm_fpustate *) &task_thread_info(task)->used_cp[0])
 
@@ -341,22 +327,6 @@ void xnarch_enable_fpu(struct xnarchtcb *tcb)
 #endif /* CONFIG_XENO_HW_FPU */
 }
 
-void xnarch_init_fpu(struct xnarchtcb *tcb)
-{
-	/*
-	 * This must run on behalf of the thread we initialize the FPU
-	 * for.
-	 */
-#ifdef CONFIG_XENO_HW_FPU
-	memset(&tcb->fpuenv, 0, sizeof(tcb->fpuenv));
-	do_init_fpu(&tcb->fpuenv);
-#ifdef CONFIG_VFP
-	do_enable_fpu();
-	do_restore_fpu(&tcb->fpuenv);
-#endif /* CONFIG_VFP */
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
 void xnarch_save_fpu(struct xnarchtcb *tcb)
 {
 #ifdef CONFIG_XENO_HW_FPU
diff --git a/kernel/cobalt/arch/powerpc/thread.c b/kernel/cobalt/arch/powerpc/thread.c
index 1ee8c57..d6f2e74 100644
--- a/kernel/cobalt/arch/powerpc/thread.c
+++ b/kernel/cobalt/arch/powerpc/thread.c
@@ -115,15 +115,6 @@ asmlinkage void __asm_restore_fpu(struct thread_struct *ts);
 })
 #endif /* CONFIG_PPC64 */
 
-void xnarch_init_fpu(struct xnarchtcb *tcb)
-{
-	/*
-	 * This must run on behalf of the thread we initialize the FPU
-	 * for. All FPU regs are guaranteed zero.
-	 */
-	__asm_init_fpu(&tcb->core.ts);
-}
-
 void xnarch_enable_fpu(struct xnarchtcb *tcb)
 {
 	struct task_struct *task = tcb->core.host_task;
diff --git a/kernel/cobalt/arch/sh/thread.c b/kernel/cobalt/arch/sh/thread.c
index 5ef75d3..e4d8414 100644
--- a/kernel/cobalt/arch/sh/thread.c
+++ b/kernel/cobalt/arch/sh/thread.c
@@ -226,20 +226,6 @@ static inline void do_restore_fpu(struct thread_struct *ts)
 		      :"memory");
 }
 
-static inline void do_init_fpu(struct thread_struct *ts)
-{
-	do_restore_fpu(ts);
-}
-
-void xnarch_init_fpu(struct xnarchtcb *tcb)
-{
-	/*
-	 * This must run on behalf of the thread we initialize the FPU
-	 * for. All FPU regs are guaranteed zero.
-	 */
-	do_init_fpu(&tcb->core.ts);
-}
-
 inline void xnarch_enable_fpu(struct xnarchtcb *tcb)
 {
 	struct task_struct *task = tcb->core.host_task;
-- 
1.7.10.4


