From: Henning Schild <henning.schild@siemens.com>
Date: Mon, 27 Aug 2018 15:28:07 +0200
Message-Id: <b213d887c6dafd679240fd9c92db81650fea9fd0.1535375976.git.henning.schild@siemens.com>
In-Reply-To: <cover.1535375976.git.henning.schild@siemens.com>
References: <cover.1535375976.git.henning.schild@siemens.com>
In-Reply-To: <cover.1535375976.git.henning.schild@siemens.com>
References: <cover.1535375976.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 3/3] cobalt/x86: add ipipe-4.14 eager fpu support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h |  4 ++++
 kernel/cobalt/arch/x86/thread.c                       | 18 +++++++++++++++---
 kernel/cobalt/include/asm-generic/xenomai/syscall.h   |  4 ++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
index 0156e86f0..4389d1202 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
@@ -35,6 +35,10 @@
     LINUX_VERSION_CODE > KERNEL_VERSION(4,4,71)
 #define IPIPE_X86_FPU_EAGER
 #endif
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
+#define IPIPE_X86_FPU_EAGER
+#endif
+
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
 #include <asm/i387.h>
diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index 54bc5c008..30dd37dab 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -42,6 +42,7 @@ static struct kmem_cache *xstate_cache;
 #define cpu_has_xsave boot_cpu_has(X86_FEATURE_XSAVE)
 #endif
 
+#ifndef IPIPE_X86_FPU_EAGER
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
 #include <asm/i387.h>
 #include <asm/fpu-internal.h>
@@ -68,11 +69,11 @@ static inline void x86_fpregs_activate(struct task_struct *t)
 	if (!x86_fpregs_active(t))
 		__fpregs_activate(&t->thread.fpu);
 }
+#endif
+#endif /* !IPIPE_X86_FPU_EAGER */
 
 #define x86_xstate_alignment		__alignof__(union fpregs_state)
 
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
 /*
  * This is obsolete context switch code uselessly duplicating
@@ -462,7 +463,9 @@ void xnarch_leave_root(struct xnthread *root)
 		return;
 
 	// the kernel never marked the task as not being the fpu owner anymore
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
 	if (&current->thread.fpu.fpstate_active)
+#endif
 		fpregs_deactivate(&current->thread.fpu);
 
 	copy_fpregs_to_fpstate(rootcb->kfpu);
@@ -526,7 +529,11 @@ void xnarch_init_shadow_tcb(struct xnthread *thread)
 
 #ifdef IPIPE_X86_FPU_EAGER
 	xnthread_set_state(thread, XNFPU);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
 	fpu__activate_fpstate_read(&p->thread.fpu);
+#else
+	fpu__prepare_read(&p->thread.fpu);
+#endif
 #endif
 }
 
@@ -535,7 +542,12 @@ int mach_x86_thread_init(void)
 	xstate_cache = kmem_cache_create("cobalt_x86_xstate",
 					 fpu_kernel_xstate_size,
 					 x86_xstate_alignment,
-					 SLAB_NOTRACK, NULL);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
+					 SLAB_NOTRACK,
+#else
+					 0,
+#endif
+					 NULL);
 	if (xstate_cache == NULL)
 		return -ENOMEM;
 
diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index f11ade8e7..9d57eaf74 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -20,7 +20,11 @@
 #define _COBALT_ASM_GENERIC_SYSCALL_H
 
 #include <linux/types.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
 #include <asm/uaccess.h>
+#else
+#include <linux/uaccess.h>
+#endif
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/wrappers.h>
 #include <asm/xenomai/machine.h>
-- 
2.16.4


