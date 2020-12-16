From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/3] cobalt/init: pipeline: abstract pipeline-specific inits
Date: Wed, 16 Dec 2020 17:44:54 +0100
Message-Id: <20201216164455.158920-3-rpm@xenomai.org>
In-Reply-To: <20201216164455.158920-1-rpm@xenomai.org>
References: <20201216164455.158920-1-rpm@xenomai.org>
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

This is the initial step to enabling Dovetail for the Cobalt core,
which requires to introduce an abstraction layer between such core and
the interrupt pipeline interface, either Dovetail or the legacy
I-pipe.

Eventually, the Cobalt implementation which has to interface to the
underlying pipeline should branch off at the following points:

- kernel/cobalt/{ipipe, dovetail}/arch, the arch-specific
  implementation which overwhelmingly depends on the pipeline flavour.

- kernel/cobalt/{ipipe, dovetail}, the generic Cobalt code calling
  pipeline services.

- kernel/cobalt/include/{ipipe, dovetail}, the client glue types and
  definitions pulled into some basic kernel types by the pipeline
  implementation (e.g. the thread_info extension structure).

- include/cobalt/kernel/{ipipe, dovetail}, the generic Cobalt headers
  depending on services and definitions the pipeline provides for.

We start the process by abstracting the machine-level init code which
depends on the pipeline flavour.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../cobalt/kernel/ipipe/pipeline/machine.h    |  71 ++++++++++
 kernel/cobalt/Makefile                        |   2 +-
 .../include/asm-generic/xenomai/machine.h     |  51 +-------
 kernel/cobalt/init.c                          | 121 +-----------------
 kernel/cobalt/ipipe/Makefile                  |   3 +
 kernel/cobalt/ipipe/init.c                    | 116 +++++++++++++++++
 scripts/prepare-kernel.sh                     |   2 +
 7 files changed, 199 insertions(+), 167 deletions(-)
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/machine.h
 create mode 100644 kernel/cobalt/ipipe/Makefile
 create mode 100644 kernel/cobalt/ipipe/init.c

diff --git a/include/cobalt/kernel/ipipe/pipeline/machine.h b/include/cobalt/kernel/ipipe/pipeline/machine.h
new file mode 100644
index 000000000..4a434bc4d
--- /dev/null
+++ b/include/cobalt/kernel/ipipe/pipeline/machine.h
@@ -0,0 +1,71 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_KERNEL_IPIPE_MACHINE_H
+#define _COBALT_KERNEL_IPIPE_MACHINE_H
+
+#include <linux/ipipe.h>
+#include <linux/percpu.h>
+
+#ifdef CONFIG_IPIPE_TRACE
+#define boot_lat_trace_notice "[LTRACE]"
+#else
+#define boot_lat_trace_notice ""
+#endif
+
+struct vm_area_struct;
+
+struct cobalt_machine {
+	const char *name;
+	int (*init)(void);
+	int (*late_init)(void);
+	void (*cleanup)(void);
+	void (*prefault)(struct vm_area_struct *vma);
+	unsigned long (*calibrate)(void);
+	const char *const *fault_labels;
+};
+
+extern struct cobalt_machine cobalt_machine;
+
+struct cobalt_machine_cpudata {
+	unsigned long apc_pending;
+	unsigned long apc_shots[BITS_PER_LONG];
+	unsigned int faults[IPIPE_NR_FAULTS];
+};
+
+DECLARE_PER_CPU(struct cobalt_machine_cpudata, cobalt_machine_cpudata);
+
+struct cobalt_pipeline {
+	struct ipipe_domain domain;
+	unsigned long timer_freq;
+	unsigned long clock_freq;
+	unsigned int apc_virq;
+	unsigned long apc_map;
+	unsigned int escalate_virq;
+	struct {
+		void (*handler)(void *cookie);
+		void *cookie;
+		const char *name;
+	} apc_table[BITS_PER_LONG];
+#ifdef CONFIG_SMP
+	cpumask_t supported_cpus;
+#endif
+};
+
+static inline unsigned long xnarch_timer_calibrate(void)
+{
+	return cobalt_machine.calibrate();
+}
+
+int pipeline_init(void);
+
+int pipeline_late_init(void);
+
+void pipeline_cleanup(void);
+
+extern struct cobalt_pipeline cobalt_pipeline;
+
+#endif /* !_COBALT_KERNEL_IPIPE_MACHINE_H */
diff --git a/kernel/cobalt/Makefile b/kernel/cobalt/Makefile
index 6e1cebefc..7dfcae084 100644
--- a/kernel/cobalt/Makefile
+++ b/kernel/cobalt/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_XENOMAI) += xenomai.o rtdm/ posix/
+obj-$(CONFIG_XENOMAI) += pipeline/ xenomai.o rtdm/ posix/
 
 xenomai-y :=	apc.o		\
 		arith.o 	\
diff --git a/kernel/cobalt/include/asm-generic/xenomai/machine.h b/kernel/cobalt/include/asm-generic/xenomai/machine.h
index 25764f989..f45e523df 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/machine.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/machine.h
@@ -19,56 +19,7 @@
 #ifndef _COBALT_ASM_GENERIC_MACHINE_H
 #define _COBALT_ASM_GENERIC_MACHINE_H
 
-#include <linux/ipipe.h>
-#include <linux/percpu.h>
-#include <asm/byteorder.h>
-#include <asm/xenomai/wrappers.h>
-
-struct vm_area_struct;
-
-struct cobalt_machine {
-	const char *name;
-	int (*init)(void);
-	int (*late_init)(void);
-	void (*cleanup)(void);
-	void (*prefault)(struct vm_area_struct *vma);
-	unsigned long (*calibrate)(void);
-	const char *const *fault_labels;
-};
-
-extern struct cobalt_machine cobalt_machine;
-
-struct cobalt_machine_cpudata {
-	unsigned long apc_pending;
-	unsigned long apc_shots[BITS_PER_LONG];
-	unsigned int faults[IPIPE_NR_FAULTS];
-};
-
-DECLARE_PER_CPU(struct cobalt_machine_cpudata, cobalt_machine_cpudata);
-
-struct cobalt_pipeline {
-	struct ipipe_domain domain;
-	unsigned long timer_freq;
-	unsigned long clock_freq;
-	unsigned int apc_virq;
-	unsigned long apc_map;
-	unsigned int escalate_virq;
-	struct {
-		void (*handler)(void *cookie);
-		void *cookie;
-		const char *name;
-	} apc_table[BITS_PER_LONG];
-#ifdef CONFIG_SMP
-	cpumask_t supported_cpus;
-#endif
-};
-
-extern struct cobalt_pipeline cobalt_pipeline;
-
-static inline unsigned long xnarch_timer_calibrate(void)
-{
-	return cobalt_machine.calibrate();
-}
+#include <pipeline/machine.h>
 
 #ifndef xnarch_cache_aliasing
 #define xnarch_cache_aliasing()  0
diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index dbe321c3b..94b653350 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -18,14 +18,12 @@
  */
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/ipipe_tickdev.h>
 #include <xenomai/version.h>
+#include <pipeline/machine.h>
 #include <cobalt/kernel/sched.h>
-#include <cobalt/kernel/clock.h>
 #include <cobalt/kernel/timer.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/intr.h>
-#include <cobalt/kernel/apc.h>
 #include <cobalt/kernel/ppd.h>
 #include <cobalt/kernel/pipe.h>
 #include <cobalt/kernel/select.h>
@@ -47,12 +45,6 @@
  * based on a set of generic RTOS building blocks.
  */
 
-static unsigned long timerfreq_arg;
-module_param_named(timerfreq, timerfreq_arg, ulong, 0444);
-
-static unsigned long clockfreq_arg;
-module_param_named(clockfreq, clockfreq_arg, ulong, 0444);
-
 #ifdef CONFIG_SMP
 static unsigned long supported_cpus_arg = -1;
 module_param_named(supported_cpus, supported_cpus_arg, ulong, 0444);
@@ -86,12 +78,6 @@ EXPORT_SYMBOL_GPL(cobalt_kernel_ppd);
 #define boot_debug_notice ""
 #endif
 
-#ifdef CONFIG_IPIPE_TRACE
-#define boot_lat_trace_notice "[LTRACE]"
-#else
-#define boot_lat_trace_notice ""
-#endif
-
 #ifdef CONFIG_ENABLE_DEFAULT_TRACERS
 #define boot_evt_trace_notice "[ETRACE]"
 #else
@@ -134,103 +120,6 @@ static void sys_shutdown(void)
 	xnheap_vfree(membase);
 }
 
-static int __init mach_setup(void)
-{
-	struct ipipe_sysinfo sysinfo;
-	int ret, virq;
-
-	ret = ipipe_select_timers(&xnsched_realtime_cpus);
-	if (ret < 0)
-		return ret;
-
-	ipipe_get_sysinfo(&sysinfo);
-
-	if (timerfreq_arg == 0)
-		timerfreq_arg = sysinfo.sys_hrtimer_freq;
-
-	if (clockfreq_arg == 0)
-		clockfreq_arg = sysinfo.sys_hrclock_freq;
-
-	if (clockfreq_arg == 0) {
-		printk(XENO_ERR "null clock frequency? Aborting.\n");
-		return -ENODEV;
-	}
-
-	cobalt_pipeline.timer_freq = timerfreq_arg;
-	cobalt_pipeline.clock_freq = clockfreq_arg;
-
-	if (cobalt_machine.init) {
-		ret = cobalt_machine.init();
-		if (ret)
-			return ret;
-	}
-
-	ipipe_register_head(&xnsched_realtime_domain, "Xenomai");
-
-	ret = -EBUSY;
-	virq = ipipe_alloc_virq();
-	if (virq == 0)
-		goto fail_apc;
-
-	cobalt_pipeline.apc_virq = virq;
-
-	ipipe_request_irq(ipipe_root_domain,
-			  cobalt_pipeline.apc_virq,
-			  apc_dispatch,
-			  NULL, NULL);
-
-	virq = ipipe_alloc_virq();
-	if (virq == 0)
-		goto fail_escalate;
-
-	cobalt_pipeline.escalate_virq = virq;
-
-	ipipe_request_irq(&xnsched_realtime_domain,
-			  cobalt_pipeline.escalate_virq,
-			  (ipipe_irq_handler_t)__xnsched_run_handler,
-			  NULL, NULL);
-
-	ret = xnclock_init(cobalt_pipeline.clock_freq);
-	if (ret)
-		goto fail_clock;
-
-	return 0;
-
-fail_clock:
-	ipipe_free_irq(&xnsched_realtime_domain,
-		       cobalt_pipeline.escalate_virq);
-	ipipe_free_virq(cobalt_pipeline.escalate_virq);
-fail_escalate:
-	ipipe_free_irq(ipipe_root_domain,
-		       cobalt_pipeline.apc_virq);
-	ipipe_free_virq(cobalt_pipeline.apc_virq);
-fail_apc:
-	ipipe_unregister_head(&xnsched_realtime_domain);
-
-	if (cobalt_machine.cleanup)
-		cobalt_machine.cleanup();
-
-	return ret;
-}
-
-static inline int __init mach_late_setup(void)
-{
-	if (cobalt_machine.late_init)
-		return cobalt_machine.late_init();
-
-	return 0;
-}
-
-static __init void mach_cleanup(void)
-{
-	ipipe_unregister_head(&xnsched_realtime_domain);
-	ipipe_free_irq(&xnsched_realtime_domain,
-		       cobalt_pipeline.escalate_virq);
-	ipipe_free_virq(cobalt_pipeline.escalate_virq);
-	ipipe_timers_release();
-	xnclock_cleanup();
-}
-
 static struct {
 	const char *label;
 	enum cobalt_run_states state;
@@ -239,7 +128,7 @@ static struct {
 	{ "stopped", COBALT_STATE_STOPPED },
 	{ "enabled", COBALT_STATE_WARMUP },
 };
-	
+
 static void __init setup_init_state(void)
 {
 	static char warn_bad_state[] __initdata =
@@ -321,7 +210,7 @@ static int __init xenomai_init(void)
 	if (ret)
 		goto fail;
 
-	ret = mach_setup();
+	ret = pipeline_init();
 	if (ret)
 		goto cleanup_proc;
 
@@ -339,7 +228,7 @@ static int __init xenomai_init(void)
 	if (ret)
 		goto cleanup_select;
 
-	ret = mach_late_setup();
+	ret = pipeline_late_init();
 	if (ret)
 		goto cleanup_sys;
 
@@ -371,7 +260,7 @@ cleanup_select:
 cleanup_pipe:
 	xnpipe_umount();
 cleanup_mach:
-	mach_cleanup();
+	pipeline_cleanup();
 cleanup_proc:
 	xnprocfs_cleanup_tree();
 fail:
diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
new file mode 100644
index 000000000..a395923a1
--- /dev/null
+++ b/kernel/cobalt/ipipe/Makefile
@@ -0,0 +1,3 @@
+obj-y +=	pipeline.o
+
+pipeline-y :=	init.o
diff --git a/kernel/cobalt/ipipe/init.c b/kernel/cobalt/ipipe/init.c
new file mode 100644
index 000000000..4d7ac04de
--- /dev/null
+++ b/kernel/cobalt/ipipe/init.c
@@ -0,0 +1,116 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <pipeline/machine.h>
+#include <linux/ipipe_tickdev.h>
+#include <cobalt/kernel/sched.h>
+#include <cobalt/kernel/clock.h>
+#include <cobalt/kernel/apc.h>
+
+static unsigned long timerfreq_arg;
+module_param_named(timerfreq, timerfreq_arg, ulong, 0444);
+
+static unsigned long clockfreq_arg;
+module_param_named(clockfreq, clockfreq_arg, ulong, 0444);
+
+int __init pipeline_init(void)
+{
+	struct ipipe_sysinfo sysinfo;
+	int ret, virq;
+
+	ret = ipipe_select_timers(&xnsched_realtime_cpus);
+	if (ret < 0)
+		return ret;
+
+	ipipe_get_sysinfo(&sysinfo);
+
+	if (timerfreq_arg == 0)
+		timerfreq_arg = sysinfo.sys_hrtimer_freq;
+
+	if (clockfreq_arg == 0)
+		clockfreq_arg = sysinfo.sys_hrclock_freq;
+
+	if (clockfreq_arg == 0) {
+		printk(XENO_ERR "null clock frequency? Aborting.\n");
+		return -ENODEV;
+	}
+
+	cobalt_pipeline.timer_freq = timerfreq_arg;
+	cobalt_pipeline.clock_freq = clockfreq_arg;
+
+	if (cobalt_machine.init) {
+		ret = cobalt_machine.init();
+		if (ret)
+			return ret;
+	}
+
+	ipipe_register_head(&xnsched_realtime_domain, "Xenomai");
+
+	ret = -EBUSY;
+	virq = ipipe_alloc_virq();
+	if (virq == 0)
+		goto fail_apc;
+
+	cobalt_pipeline.apc_virq = virq;
+
+	ipipe_request_irq(ipipe_root_domain,
+			  cobalt_pipeline.apc_virq,
+			  apc_dispatch,
+			  NULL, NULL);
+
+	virq = ipipe_alloc_virq();
+	if (virq == 0)
+		goto fail_escalate;
+
+	cobalt_pipeline.escalate_virq = virq;
+
+	ipipe_request_irq(&xnsched_realtime_domain,
+			  cobalt_pipeline.escalate_virq,
+			  (ipipe_irq_handler_t)__xnsched_run_handler,
+			  NULL, NULL);
+
+	ret = xnclock_init(cobalt_pipeline.clock_freq);
+	if (ret)
+		goto fail_clock;
+
+	return 0;
+
+fail_clock:
+	ipipe_free_irq(&xnsched_realtime_domain,
+		       cobalt_pipeline.escalate_virq);
+	ipipe_free_virq(cobalt_pipeline.escalate_virq);
+fail_escalate:
+	ipipe_free_irq(ipipe_root_domain,
+		       cobalt_pipeline.apc_virq);
+	ipipe_free_virq(cobalt_pipeline.apc_virq);
+fail_apc:
+	ipipe_unregister_head(&xnsched_realtime_domain);
+
+	if (cobalt_machine.cleanup)
+		cobalt_machine.cleanup();
+
+	return ret;
+}
+
+int __init pipeline_late_init(void)
+{
+	if (cobalt_machine.late_init)
+		return cobalt_machine.late_init();
+
+	return 0;
+}
+
+__init void pipeline_cleanup(void)
+{
+	ipipe_unregister_head(&xnsched_realtime_domain);
+	ipipe_free_irq(&xnsched_realtime_domain,
+		       cobalt_pipeline.escalate_virq);
+	ipipe_free_virq(cobalt_pipeline.escalate_virq);
+	ipipe_timers_release();
+	xnclock_cleanup();
+}
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 3ff9433d2..1b5fb427d 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -425,9 +425,11 @@ patch_link r n kernel/cobalt/include/asm-generic/xenomai include/asm-generic/xen
 patch_link r n kernel/cobalt/include/linux/xenomai include/linux/xenomai
 patch_link n m kernel/cobalt/posix kernel/xenomai/posix
 patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm
+patch_link n m kernel/cobalt/ipipe kernel/xenomai/pipeline
 patch_link r m kernel/drivers drivers/xenomai
 patch_link n n include/cobalt/kernel include/xenomai/cobalt/kernel
 patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
+patch_link r n include/cobalt/kernel/ipipe/pipeline include/xenomai/pipeline
 patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi
 patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
 patch_link n version.h include/xenomai include/xenomai
-- 
2.26.2


