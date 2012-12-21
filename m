From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:11 +0100
Message-Id: <1356096375-29859-7-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 06/10] ipipe: safe thread_info access from
	non-root context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, wolfgang.mauerer@siemens.com

Provide a function that allows for safely accessing
the thread_info structure from non-root context.
Architectures that don't store the corresponding
data on the stack (x86_64) can provide machine-specific
override definitions. Also create a own header file
(including the other definitions to access foreign stacks)
so that the mechanism can be used in contexts where not
the full ipipe API is required.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 include/linux/ipipe.h               |   32 +------------------
 include/linux/ipipe_foreign_stack.h |   61 +++++++++++++++++++++++++++++++++++
 kernel/ipipe/core.c                 |    1 +
 3 files changed, 63 insertions(+), 31 deletions(-)
 create mode 100644 include/linux/ipipe_foreign_stack.h

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index bcd5d41..6f011cc 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -27,6 +27,7 @@
 #include <linux/irq.h>
 #include <linux/thread_info.h>
 #include <linux/ipipe_base.h>
+#include <linux/ipipe_foreign_stack.h>
 #include <linux/ipipe_debug.h>
 #include <asm/ptrace.h>
 #include <asm/ipipe.h>
@@ -226,36 +227,6 @@ void ipipe_critical_exit(unsigned long flags);
 
 void ipipe_prepare_panic(void);
 
-static inline void ipipe_set_foreign_stack(struct ipipe_domain *ipd)
-{
-	/* Must be called hw interrupts off. */
-	__set_bit(IPIPE_NOSTACK_FLAG, &ipipe_this_cpu_context(ipd)->status);
-}
-
-static inline void ipipe_clear_foreign_stack(struct ipipe_domain *ipd)
-{
-	/* Must be called hw interrupts off. */
-	__clear_bit(IPIPE_NOSTACK_FLAG, &ipipe_this_cpu_context(ipd)->status);
-}
-
-static inline int ipipe_test_foreign_stack(void)
-{
-	/* Must be called hw interrupts off. */
-	return test_bit(IPIPE_NOSTACK_FLAG, &__ipipe_current_context->status);
-}
-
-#ifndef ipipe_safe_current
-#define ipipe_safe_current()						\
-	({								\
-		struct task_struct *__p__;				\
-		unsigned long __flags__;				\
-		__flags__ = hard_smp_local_irq_save();			\
-		__p__ = ipipe_test_foreign_stack() ? &init_task : current; \
-		hard_smp_local_irq_restore(__flags__);			\
-		__p__;							\
-	})
-#endif
-
 #ifdef CONFIG_SMP
 void ipipe_set_irq_affinity(unsigned int irq, cpumask_t cpumask);
 void ipipe_send_ipi(unsigned int ipi, cpumask_t cpumask);
@@ -380,7 +351,6 @@ static inline void __ipipe_nmi_enter(void) { }
 
 static inline void __ipipe_nmi_exit(void) { }
 
-#define ipipe_safe_current()	current
 #define ipipe_processor_id()	smp_processor_id()
 
 static inline int ipipe_test_foreign_stack(void)
diff --git a/include/linux/ipipe_foreign_stack.h b/include/linux/ipipe_foreign_stack.h
new file mode 100644
index 0000000..4d5132a
--- /dev/null
+++ b/include/linux/ipipe_foreign_stack.h
@@ -0,0 +1,61 @@
+#ifndef IPIPE_FOREIGN_STACK_H
+#define IPIPE_FOREIGN_STACK_H
+
+#include <linux/ipipe_base.h>
+#include <linux/ipipe_domain.h>
+#include <asm/irqflags.h> // hard_smp_local_irq_safe
+#include <asm/ipipe.h>    // Possible per-arch definitions of ipipe_safe_current
+
+#ifdef CONFIG_IPIPE
+
+static inline void ipipe_set_foreign_stack(struct ipipe_domain *ipd)
+{
+	/* Must be called hw interrupts off. */
+	__set_bit(IPIPE_NOSTACK_FLAG, &ipipe_this_cpu_context(ipd)->status);
+}
+
+static inline void ipipe_clear_foreign_stack(struct ipipe_domain *ipd)
+{
+	/* Must be called hw interrupts off. */
+	__clear_bit(IPIPE_NOSTACK_FLAG, &ipipe_this_cpu_context(ipd)->status);
+}
+
+static inline int ipipe_test_foreign_stack(void)
+{
+	/* Must be called hw interrupts off. */
+	return test_bit(IPIPE_NOSTACK_FLAG, &__ipipe_current_context->status);
+}
+
+#ifndef ipipe_safe_current
+#define ipipe_safe_current()						\
+	({								\
+		struct task_struct *__p__;				\
+		unsigned long __flags__;				\
+		__flags__ = hard_smp_local_irq_save();			\
+		__p__ = ipipe_test_foreign_stack() ? &init_task : current; \
+		hard_smp_local_irq_restore(__flags__);			\
+		__p__;							\
+	})
+#endif
+
+#ifndef ipipe_safe_current_thread_info
+#define ipipe_safe_current_thread_info()				\
+	({								\
+		struct thread_info *__ti__;				\
+		unsigned long __flags__;				\
+		__flags__ = hard_smp_local_irq_save();			\
+		__ti__ = ipipe_test_foreign_stack() ?			\
+			&init_thread_info : current_thread_info();	\
+		hard_smp_local_irq_restore(__flags__);			\
+		__ti__;							\
+	})
+#endif
+
+#else /* !CONFIG_IPIPE */
+
+#define ipipe_safe_current()			current
+#define ipipe_safe_current_thread_info()	current_thread_info
+
+#endif /* CONFIG_IPIPE */
+
+#endif
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 182b61c..126953b 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -33,6 +33,7 @@
 #include <linux/seq_file.h>
 #endif	/* CONFIG_PROC_FS */
 #include <linux/ipipe_trace.h>
+#include <linux/ipipe_foreign_stack.h>
 #include <linux/ipipe.h>
 
 struct ipipe_domain ipipe_root;
-- 
1.7.1


