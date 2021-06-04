From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 02/12] cobalt/thread: pipeline: refactor thread control block
Date: Fri,  4 Jun 2021 12:05:12 +0200
Message-Id: <5aa318915b590382f478d182cee5b14bc2c8efe2.1622801122.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1622801122.git.jan.kiszka@siemens.com>
References: <cover.1622801122.git.jan.kiszka@siemens.com>
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

With Dovetail in, a thread control block is fully generic, merely
composed of an alternate scheduling control descriptor. Refactor the
definitions of the per-architecture control blocks accordingly.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/thread.h                |  6 ++---
 .../arm/ipipe/include/asm/xenomai/thread.h    |  8 ++++++-
 .../arm64/ipipe/include/asm/xenomai/thread.h  |  8 ++++++-
 .../ipipe/include/asm/xenomai/thread.h        |  8 ++++++-
 .../x86/dovetail/include/asm/xenomai/thread.h |  8 +------
 .../x86/ipipe/include/asm/xenomai/thread.h    |  8 ++++++-
 .../asm-generic/xenomai/dovetail/thread.h     | 24 +++++++++++++++++++
 .../asm-generic/xenomai/{ => ipipe}/thread.h  |  9 +++----
 8 files changed, 59 insertions(+), 20 deletions(-)
 create mode 100644 kernel/cobalt/include/asm-generic/xenomai/dovetail/thread.h
 rename kernel/cobalt/include/asm-generic/xenomai/{ => ipipe}/thread.h (87%)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index fe7390088..c92037bfe 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -268,7 +268,7 @@ static inline int xnthread_current_priority(const struct xnthread *thread)
 
 static inline struct task_struct *xnthread_host_task(struct xnthread *thread)
 {
-	return xnthread_archtcb(thread)->core.host_task;
+	return xnarch_host_task(xnthread_archtcb(thread));
 }
 
 #define xnthread_for_each_booster(__pos, __thread)		\
@@ -283,7 +283,7 @@ static inline struct task_struct *xnthread_host_task(struct xnthread *thread)
 		if ((__p__)->ops.__h)					\
 			(__p__)->ops.__h(__t, ##__a);			\
 	} while (0)
-	
+
 #define xnthread_run_handler_stack(__t, __h, __a...)			\
 	do {								\
 		struct xnthread_personality *__p__ = (__t)->personality;	\
@@ -293,7 +293,7 @@ static inline struct task_struct *xnthread_host_task(struct xnthread *thread)
 			__p__ = (__p__)->ops.__h(__t, ##__a);		\
 		} while (__p__);					\
 	} while (0)
-	
+
 static inline
 struct xnthread_wait_context *xnthread_get_wait_context(struct xnthread *thread)
 {
diff --git a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h
index c51b51a93..93346fd2e 100644
--- a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h
@@ -19,7 +19,7 @@
 #ifndef _COBALT_ARM_ASM_THREAD_H
 #define _COBALT_ARM_ASM_THREAD_H
 
-#include <asm-generic/xenomai/thread.h>
+#include <asm-generic/xenomai/ipipe/thread.h>
 
 #ifdef CONFIG_XENO_ARCH_FPU
 #ifdef CONFIG_VFP
@@ -51,6 +51,12 @@ struct xnarchtcb {
 
 #define xnarch_fault_notify(d) (!xnarch_fault_bp_p(d))
 
+static inline
+struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
+{
+	return tcb->core.host_task;
+}
+
 void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
 
 static inline void xnarch_enter_root(struct xnthread *root) { }
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h
index c81c01321..7899a49e6 100644
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h
@@ -20,7 +20,7 @@
 #define _COBALT_ARM64_ASM_THREAD_H
 
 #include <linux/version.h>
-#include <asm-generic/xenomai/thread.h>
+#include <asm-generic/xenomai/ipipe/thread.h>
 
 #if defined(CONFIG_XENO_ARCH_FPU) && LINUX_VERSION_CODE < KERNEL_VERSION(4,9,0)
 #define ARM64_XENO_OLD_SWITCH
@@ -47,6 +47,12 @@ struct xnarchtcb {
 
 #define xnarch_fault_notify(d) (!xnarch_fault_bp_p(d))
 
+static inline
+struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
+{
+	return tcb->core.host_task;
+}
+
 void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
 
 static inline void xnarch_enter_root(struct xnthread *root) { }
diff --git a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/thread.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/thread.h
index 97129f739..f91e26b36 100644
--- a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/thread.h
@@ -19,7 +19,7 @@
 #ifndef _COBALT_POWERPC_ASM_THREAD_H
 #define _COBALT_POWERPC_ASM_THREAD_H
 
-#include <asm-generic/xenomai/thread.h>
+#include <asm-generic/xenomai/ipipe/thread.h>
 
 struct xnarchtcb {
 	struct xntcb core;
@@ -44,6 +44,12 @@ struct xnarchtcb {
 				 (d)->exception == IPIPE_TRAP_DEBUG))
 #define xnarch_fault_notify(d) (xnarch_fault_bp_p(d) == 0)
 
+static inline
+struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
+{
+	return tcb->core.host_task;
+}
+
 static inline void xnarch_enter_root(struct xnthread *root) { }
 
 #ifdef CONFIG_XENO_ARCH_FPU
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h
index 73ecd945c..6eb71e2a8 100644
--- a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h
@@ -20,15 +20,9 @@
 #ifndef _COBALT_X86_ASM_THREAD_H
 #define _COBALT_X86_ASM_THREAD_H
 
-#include <linux/dovetail.h>
-#include <asm-generic/xenomai/thread.h>
+#include <asm-generic/xenomai/dovetail/thread.h>
 #include <asm/traps.h>
 
-struct xnarchtcb {
-	struct xntcb core;
-	struct dovetail_altsched_context altsched;
-};
-
 #define xnarch_fault_pc(__regs)		((__regs)->ip)
 #define xnarch_fault_pf_p(__nr)		((__nr) == X86_TRAP_PF)
 #define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED) &&	\
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h
index 10cd6ecd5..a1a79bbc0 100644
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h
@@ -20,7 +20,7 @@
 #ifndef _COBALT_X86_ASM_THREAD_H
 #define _COBALT_X86_ASM_THREAD_H
 
-#include <asm-generic/xenomai/thread.h>
+#include <asm-generic/xenomai/ipipe/thread.h>
 #include <asm/xenomai/wrappers.h>
 #include <asm/traps.h>
 
@@ -64,6 +64,12 @@ struct xnarchtcb {
 				 ((d)->exception == X86_TRAP_DB || (d)->exception == X86_TRAP_BP))
 #define xnarch_fault_notify(d)	(!xnarch_fault_bp_p(d))
 
+static inline
+struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
+{
+	return tcb->core.host_task;
+}
+
 void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to);
 
 int xnarch_handle_fpu_fault(struct xnthread *from, 
diff --git a/kernel/cobalt/include/asm-generic/xenomai/dovetail/thread.h b/kernel/cobalt/include/asm-generic/xenomai/dovetail/thread.h
new file mode 100644
index 000000000..8939e45f3
--- /dev/null
+++ b/kernel/cobalt/include/asm-generic/xenomai/dovetail/thread.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2021 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef _COBALT_ASM_GENERIC_DOVETAIL_THREAD_H
+#define _COBALT_ASM_GENERIC_DOVETAIL_THREAD_H
+
+#include <linux/dovetail.h>
+
+struct xnarchtcb {
+	struct dovetail_altsched_context altsched;
+};
+
+static inline
+struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
+{
+	return tcb->altsched.task;
+}
+
+#endif /* !_COBALT_ASM_GENERIC_DOVETAIL_THREAD_H */
diff --git a/kernel/cobalt/include/asm-generic/xenomai/thread.h b/kernel/cobalt/include/asm-generic/xenomai/ipipe/thread.h
similarity index 87%
rename from kernel/cobalt/include/asm-generic/xenomai/thread.h
rename to kernel/cobalt/include/asm-generic/xenomai/ipipe/thread.h
index cd0c6e913..fcd7275d9 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/thread.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/ipipe/thread.h
@@ -16,17 +16,14 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#ifndef _COBALT_ASM_GENERIC_THREAD_H
-#define _COBALT_ASM_GENERIC_THREAD_H
+#ifndef _COBALT_ASM_GENERIC_IPIPE_THREAD_H
+#define _COBALT_ASM_GENERIC_IPIPE_THREAD_H
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 
 struct task_struct;
 
-struct xnthread;
-struct xnarchtcb;
-
 struct xntcb {
 	struct task_struct *host_task;
 	struct thread_struct *tsp;
@@ -39,4 +36,4 @@ struct xntcb {
 #endif
 };
 
-#endif /* !_COBALT_ASM_GENERIC_THREAD_H */
+#endif /* !_COBALT_ASM_GENERIC_IPIPE_THREAD_H */
-- 
2.26.2


