From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 26 Oct 2013 00:03:50 +0200
Message-Id: <1382738632-14649-5-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <526AEA7E.6030801@xenomai.org>
 <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 5/7] cobalt/fpu: change xnarch_handle_fpu_fault
	interface
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Pass the current FPU holder to allow enabling XNFPU dynamically.
Also pass the faults information for architectures which need to fiddle
with the PC register to restart the faulting instruction.
---
 kernel/cobalt/arch/arm/include/asm/xenomai/thread.h      |    4 +++-
 kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h |    4 +++-
 kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h    |    4 +++-
 kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h  |    4 +++-
 kernel/cobalt/arch/sh/include/asm/xenomai/thread.h       |    4 +++-
 kernel/cobalt/arch/x86/include/asm/xenomai/thread.h      |    7 +++++--
 kernel/cobalt/arch/x86/thread.c                          |    3 ++-
 kernel/cobalt/shadow.c                                   |    2 +-
 8 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
index 8b54b97..8c42775 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
@@ -124,7 +124,9 @@ static inline void xnarch_leave_root(struct xnthread *root) { }
 
 #endif /* !CONFIG_XENO_HW_FPU */
 
-static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
+static inline int 
+xnarch_handle_fpu_fault(struct xnthread *from, 
+			struct xnthread *to, struct ipipe_trap_data *d)
 {
 	return 0;
 }
diff --git a/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h b/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h
index 601fc4b..6c630e7 100644
--- a/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h
@@ -62,7 +62,9 @@ static inline void xnarch_enable_fpu(struct xnthread *current_thread) { }
 static inline void xnarch_save_fpu(struct xnthread *thread) { }
 static inline void xnarch_restore_fpu(struct xnthread *thread) { }
 
-static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
+static inline int 
+xnarch_handle_fpu_fault(struct xnthread *from, 
+			struct xnthread *to, struct ipipe_trap_data *d)
 {
 	return 0;
 }
diff --git a/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h b/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h
index 775b92a..05de3c2 100644
--- a/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h
@@ -57,7 +57,9 @@ static inline void xnarch_enable_fpu(struct xnthread *thread) { }
 static inline void xnarch_save_fpu(struct xnthread *thread) { }
 static inline void xnarch_restore_fpu(struct xnthread *thread) { }
 
-static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
+static inline int 
+xnarch_handle_fpu_fault(struct xnthread *from, 
+			struct xnthread *to, struct ipipe_trap_data *d)
 {
 	return 0;
 }
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
index 07a17cf..7504fba 100644
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
@@ -77,7 +77,9 @@ static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
 
 #endif  /* !CONFIG_XENO_HW_FPU */
 
-static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
+static inline int 
+xnarch_handle_fpu_fault(struct xnthread *from, 
+			struct xnthread *to, struct ipipe_trap_data *d)
 {
 	return 0;
 }
diff --git a/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h b/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h
index 2c7fe88..9a78124 100644
--- a/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h
@@ -70,7 +70,9 @@ static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
 
 #endif /* !CONFIG_XENO_HW_FPU */
 
-static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
+static inline int 
+xnarch_handle_fpu_fault(struct xnthread *from, 
+			struct xnthread *to, struct ipipe_trap_data *d)
 {
 	return 0;
 }
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index 570d9b5..938b25d 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -69,7 +69,8 @@ static inline int xnarch_shadow_p(struct xnarchtcb *tcb, struct task_struct *tas
 void xnarch_save_fpu(struct xnthread *thread);
 void xnarch_restore_fpu(struct xnthread *thread);
 void xnarch_enable_fpu(struct xnthread *thread);
-int xnarch_handle_fpu_fault(struct xnthread *thread);
+int xnarch_handle_fpu_fault(struct xnthread *from, 
+			struct xnthread *to, struct ipipe_trap_data *d);
 
 #else /* !CONFIG_XENO_HW_FPU */
 
@@ -77,7 +78,9 @@ static inline void xnarch_save_fpu(struct xnthread *thread) { }
 static inline void xnarch_restore_fpu(struct xnthread *thread) { }
 static inline void xnarch_enable_fpu(struct xnthread *thread) { }
 
-static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
+static inline int
+xnarch_handle_fpu_fault(struct xnthread *from, 
+			struct xnthread *to, struct ipipe_trap_data *d)
 {
 	return 0;
 }
diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index 4e80495..cbf3627 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -219,7 +219,8 @@ static inline void __do_restore_i387(x86_fpustate *fpup)
 #endif /* CONFIG_X86_64 */
 }
 
-int xnarch_handle_fpu_fault(struct xnthread *thread)
+int xnarch_handle_fpu_fault(struct xnthread *from, 
+			struct xnthread *to, struct ipipe_trap_data *d)
 {
 	struct xnarchtcb *tcb = xnthread_archtcb(to);
 	struct task_struct *p = tcb->core.host_task;
diff --git a/kernel/cobalt/shadow.c b/kernel/cobalt/shadow.c
index c858777..74e73d5 100644
--- a/kernel/cobalt/shadow.c
+++ b/kernel/cobalt/shadow.c
@@ -2608,7 +2608,7 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 
 	if (xnarch_fault_fpu_p(d)) {
 		/* FPU exception received in primary mode. */
-		if (xnarch_handle_fpu_fault(thread)) {
+		if (xnarch_handle_fpu_fault(sched->fpuholder, thread, d)) {
 			sched->fpuholder = thread;
 			return 1;
 		}
-- 
1.7.10.4


