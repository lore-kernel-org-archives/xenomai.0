From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail 02/13] cobalt/apc: pipeline: abstract interface for
 deferred routine calls
Date: Sat,  2 Jan 2021 10:33:42 +0100
Message-Id: <20210102093353.3195090-3-rpm@xenomai.org>
In-Reply-To: <20210102093353.3195090-1-rpm@xenomai.org>
References: <20210102093353.3195090-1-rpm@xenomai.org>
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

Dovetail enables the regular irq_work() for submitting work from the
out-of-band stage (primary mode) to the in-band one (secondary
mode). We won't need APCs in the Dovetail case, let's move this code
to the I-pipe section.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/apc.h     | 51 ++-------------------------------
 kernel/cobalt/Makefile          |  3 +-
 kernel/cobalt/ipipe/Makefile    |  2 +-
 kernel/cobalt/{ => ipipe}/apc.c | 42 +++++++++++++++++++++++++++
 kernel/cobalt/ipipe/init.c      |  2 ++
 5 files changed, 48 insertions(+), 52 deletions(-)
 rename kernel/cobalt/{ => ipipe}/apc.c (80%)

diff --git a/include/cobalt/kernel/apc.h b/include/cobalt/kernel/apc.h
index 7075ad07a..45d70b146 100644
--- a/include/cobalt/kernel/apc.h
+++ b/include/cobalt/kernel/apc.h
@@ -19,61 +19,14 @@
 #ifndef _COBALT_KERNEL_APC_H
 #define _COBALT_KERNEL_APC_H
 
-#include <linux/ipipe.h>
-#include <asm/xenomai/machine.h>
-
-/**
- * @addtogroup cobalt_core_apc
- * @{
- */
-
 int xnapc_alloc(const char *name,
 		void (*handler)(void *cookie),
 		void *cookie);
 
 void xnapc_free(int apc);
 
-static inline void __xnapc_schedule(int apc)
-{
-	unsigned long *p = &raw_cpu_ptr(&cobalt_machine_cpudata)->apc_pending;
-
-	if (!__test_and_set_bit(apc, p))
-		ipipe_post_irq_root(cobalt_pipeline.apc_virq);
-}
-
-/**
- * @fn static inline int xnapc_schedule(int apc)
- *
- * @brief Schedule an APC invocation.
- *
- * This service marks the APC as pending for the Linux domain, so that
- * its handler will be called as soon as possible, when the Linux
- * domain gets back in control.
- *
- * When posted from the Linux domain, the APC handler is fired as soon
- * as the interrupt mask is explicitly cleared by some kernel
- * code. When posted from the Xenomai domain, the APC handler is
- * fired as soon as the Linux domain is resumed, i.e. after Xenomai has
- * completed all its pending duties.
- *
- * @param apc The APC id. to schedule.
- *
- * This service can be called from:
- *
- * - Any domain context, albeit the usual calling place is from the
- * Xenomai domain.
- */
-static inline void xnapc_schedule(int apc)
-{
-	unsigned long flags;
-
-	flags = ipipe_test_and_stall_head() & 1;
-	__xnapc_schedule(apc);
-	ipipe_restore_head(flags);
-}
-
-void apc_dispatch(unsigned int virq, void *arg);
+void __xnapc_schedule(int apc);
 
-/** @} */
+void xnapc_schedule(int apc);
 
 #endif /* !_COBALT_KERNEL_APC_H */
diff --git a/kernel/cobalt/Makefile b/kernel/cobalt/Makefile
index de3ae1bfc..129005d8f 100644
--- a/kernel/cobalt/Makefile
+++ b/kernel/cobalt/Makefile
@@ -1,7 +1,6 @@
 obj-$(CONFIG_XENOMAI) += pipeline/ xenomai.o rtdm/ posix/
 
-xenomai-y :=	apc.o		\
-		arith.o 	\
+xenomai-y :=	arith.o 	\
 		bufd.o		\
 		clock.o		\
 		heap.o		\
diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
index 5170bb32b..13186dc7f 100644
--- a/kernel/cobalt/ipipe/Makefile
+++ b/kernel/cobalt/ipipe/Makefile
@@ -2,4 +2,4 @@ ccflags-y += -Ikernel
 
 obj-y +=	pipeline.o
 
-pipeline-y :=	init.o intr.o kevents.o
+pipeline-y :=	init.o intr.o kevents.o apc.o
diff --git a/kernel/cobalt/apc.c b/kernel/cobalt/ipipe/apc.c
similarity index 80%
rename from kernel/cobalt/apc.c
rename to kernel/cobalt/ipipe/apc.c
index 97edcfc4c..715997727 100644
--- a/kernel/cobalt/apc.c
+++ b/kernel/cobalt/ipipe/apc.c
@@ -18,6 +18,7 @@
  */
 #include <linux/spinlock.h>
 #include <linux/ipipe.h>
+#include <asm/xenomai/machine.h>
 #include <cobalt/kernel/apc.h>
 
 /**
@@ -157,4 +158,45 @@ void xnapc_free(int apc)
 }
 EXPORT_SYMBOL_GPL(xnapc_free);
 
+void __xnapc_schedule(int apc)
+{
+	unsigned long *p = &raw_cpu_ptr(&cobalt_machine_cpudata)->apc_pending;
+
+	if (!__test_and_set_bit(apc, p))
+		ipipe_post_irq_root(cobalt_pipeline.apc_virq);
+}
+EXPORT_SYMBOL_GPL(__xnapc_schedule);
+
+/**
+ * @fn static inline int xnapc_schedule(int apc)
+ *
+ * @brief Schedule an APC invocation.
+ *
+ * This service marks the APC as pending for the Linux domain, so that
+ * its handler will be called as soon as possible, when the Linux
+ * domain gets back in control.
+ *
+ * When posted from the Linux domain, the APC handler is fired as soon
+ * as the interrupt mask is explicitly cleared by some kernel
+ * code. When posted from the Xenomai domain, the APC handler is
+ * fired as soon as the Linux domain is resumed, i.e. after Xenomai has
+ * completed all its pending duties.
+ *
+ * @param apc The APC id. to schedule.
+ *
+ * This service can be called from:
+ *
+ * - Any domain context, albeit the usual calling place is from the
+ * Xenomai domain.
+ */
+void xnapc_schedule(int apc)
+{
+	unsigned long flags;
+
+	flags = ipipe_test_and_stall_head() & 1;
+	__xnapc_schedule(apc);
+	ipipe_restore_head(flags);
+}
+EXPORT_SYMBOL_GPL(xnapc_schedule);
+
 /** @} */
diff --git a/kernel/cobalt/ipipe/init.c b/kernel/cobalt/ipipe/init.c
index 4d7ac04de..d901c417f 100644
--- a/kernel/cobalt/ipipe/init.c
+++ b/kernel/cobalt/ipipe/init.c
@@ -18,6 +18,8 @@ module_param_named(timerfreq, timerfreq_arg, ulong, 0444);
 static unsigned long clockfreq_arg;
 module_param_named(clockfreq, clockfreq_arg, ulong, 0444);
 
+void apc_dispatch(unsigned int virq, void *arg);
+
 int __init pipeline_init(void)
 {
 	struct ipipe_sysinfo sysinfo;
-- 
2.26.2


