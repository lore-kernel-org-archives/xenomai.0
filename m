From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 01/18] cobalt/init: dovetail: add placeholders for core
 init/cleanup
Date: Sun,  7 Feb 2021 17:04:17 +0100
Message-Id: <20210207160434.2869121-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../cobalt/kernel/dovetail/pipeline/machine.h | 51 ++++++++++++++++++
 kernel/cobalt/dovetail/Makefile               |  5 ++
 kernel/cobalt/dovetail/init.c                 | 52 +++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/machine.h
 create mode 100644 kernel/cobalt/dovetail/Makefile
 create mode 100644 kernel/cobalt/dovetail/init.c

diff --git a/include/cobalt/kernel/dovetail/pipeline/machine.h b/include/cobalt/kernel/dovetail/pipeline/machine.h
new file mode 100644
index 000000000..4f3dd95e0
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/machine.h
@@ -0,0 +1,51 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_KERNEL_DOVETAIL_MACHINE_H
+#define _COBALT_KERNEL_DOVETAIL_MACHINE_H
+
+#include <linux/percpu.h>
+
+#ifdef CONFIG_FTRACE
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
+	const char *const *fault_labels;
+};
+
+extern struct cobalt_machine cobalt_machine;
+
+struct cobalt_machine_cpudata {
+	unsigned int faults[32];
+};
+
+DECLARE_PER_CPU(struct cobalt_machine_cpudata, cobalt_machine_cpudata);
+
+struct cobalt_pipeline {
+#ifdef CONFIG_SMP
+	cpumask_t supported_cpus;
+#endif
+};
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
diff --git a/kernel/cobalt/dovetail/Makefile b/kernel/cobalt/dovetail/Makefile
new file mode 100644
index 000000000..0bde9dfdb
--- /dev/null
+++ b/kernel/cobalt/dovetail/Makefile
@@ -0,0 +1,5 @@
+ccflags-y += -Ikernel
+
+obj-y +=	pipeline.o
+
+pipeline-y :=	init.o
diff --git a/kernel/cobalt/dovetail/init.c b/kernel/cobalt/dovetail/init.c
new file mode 100644
index 000000000..983186abe
--- /dev/null
+++ b/kernel/cobalt/dovetail/init.c
@@ -0,0 +1,52 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#include <linux/init.h>
+#include <pipeline/machine.h>
+#include <cobalt/kernel/clock.h>
+#include <cobalt/kernel/assert.h>
+
+int __init pipeline_init(void)
+{
+	int ret;
+
+	if (cobalt_machine.init) {
+		ret = cobalt_machine.init();
+		if (ret)
+			return ret;
+	}
+
+	/* Enable the Xenomai out-of-band stage */
+	TODO();
+
+	ret = xnclock_init();
+	if (ret)
+		goto fail_clock;
+
+	return 0;
+
+fail_clock:
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
+	/* Disable the Xenomai stage */
+	TODO();
+
+	xnclock_cleanup();
+}
-- 
2.26.2


