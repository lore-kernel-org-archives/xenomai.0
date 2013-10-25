From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 26 Oct 2013 00:03:48 +0200
Message-Id: <1382738632-14649-3-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <526AEA7E.6030801@xenomai.org>
 <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 3/7] cobalt/fpu: replace the is_root member with
	XNROOT tests
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
 kernel/cobalt/arch/arm/include/asm/xenomai/thread.h |    4 ----
 kernel/cobalt/arch/arm/thread.c                     |    4 ++--
 kernel/cobalt/arch/x86/include/asm/xenomai/thread.h |    1 -
 kernel/cobalt/arch/x86/thread.c                     |    6 +++---
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
index fc79fc8..346e329 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
@@ -51,9 +51,7 @@ struct arm_fpustate {
 struct xnarchtcb {
 	struct xntcb core;
 #ifdef CONFIG_XENO_HW_FPU
-	struct arm_fpustate fpuenv;
 	struct arm_fpustate *fpup;
-	unsigned int is_root;
 #define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
 #else
 #define xnarch_fpu_ptr(tcb)     NULL
@@ -98,14 +96,12 @@ int xnarch_escalate(void);
 static inline void xnarch_init_root_tcb(struct xnthread *thread)
 {
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	tcb->is_root = 1;
 	tcb->fpup = NULL;
 }
 
 static inline void xnarch_init_shadow_tcb(struct xnthread *thread)
 {
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	tcb->is_root = 0;
 	tcb->fpup = (struct arm_fpustate *)
 		&task_thread_info(tcb->core.host_task)->used_cp[0];
 }
diff --git a/kernel/cobalt/arch/arm/thread.c b/kernel/cobalt/arch/arm/thread.c
index d77e59a..29a58fe 100644
--- a/kernel/cobalt/arch/arm/thread.c
+++ b/kernel/cobalt/arch/arm/thread.c
@@ -294,7 +294,7 @@ void xnarch_enable_fpu(struct xnthread *thread)
 	   newly switched thread uses the FPU, to allow the kernel handler to
 	   pick the correct FPU context.
 	*/
-	if (likely(!tcb->is_root)) {
+	if (likely(!xnthread_test_state(thread, XNROOT))) {
 		do_enable_fpu();
 		/* No exception should be pending, since it should have caused
 		   a trap earlier.
@@ -355,7 +355,7 @@ void xnarch_restore_fpu(struct xnthread *thread)
 	struct xnarchtcb *tcb = &thread->tcb;
 #ifdef CONFIG_XENO_HW_FPU
 #ifdef CONFIG_VFP
-	if (likely(!tcb->is_root)) {
+	if (likely(!xnthread_test_state(thread, XNROOT))) {
 		do_enable_fpu();
 		do_restore_fpu(tcb->fpup);
 	} else {
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index ee0f385..570d9b5 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -35,7 +35,6 @@ struct xnarchtcb {
 	unsigned long ip;
 	unsigned long *ipp;
 	x86_fpustate *fpup;
-	unsigned int is_root: 1;
 	unsigned int root_kfpu: 1;
 	unsigned int root_used_math: 1;
 	struct {
diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index 0c24e02..4ff699a 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -287,7 +287,8 @@ void xnarch_restore_fpu(struct xnthread *thread)
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct task_struct *p = tcb->core.host_task;
 
-	if (tcb->root_kfpu == 0 && (tsk_used_math(p) == 0 || tcb->is_root))
+	if (tcb->root_kfpu == 0 && 
+		(tsk_used_math(p) == 0 || xnthread_test_state(thread, XNROOT)))
 		/* Restore lazy mode */
 		return;
 
@@ -320,15 +321,14 @@ void xnarch_init_root_tcb(struct xnthread *thread)
 	tcb->sp = 0;
 	tcb->spp = &tcb->sp;
 	tcb->ipp = &tcb->ip;
-	tcb->is_root = 1;
 	tcb->fpup = NULL;
 	tcb->root_kfpu = 0;
 }
 
 void xnarch_init_shadow_tcb(struct xnthread *thread)
 {
-	struct task_struct *p = tcb->core.host_task;
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
+	struct task_struct *p = tcb->core.host_task;
 
 	tcb->sp = 0;
 	tcb->spp = &p->thread.sp;
-- 
1.7.10.4


