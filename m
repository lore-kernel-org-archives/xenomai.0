From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/8] cobalt/tick: dovetail: add placeholders for tick
 management
Date: Sat, 20 Feb 2021 13:45:21 +0100
Message-Id: <20210220124527.401015-2-rpm@xenomai.org>
In-Reply-To: <20210220124527.401015-1-rpm@xenomai.org>
References: <20210220124527.401015-1-rpm@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../cobalt/kernel/dovetail/pipeline/tick.h    | 12 ++++++
 kernel/cobalt/dovetail/Makefile               |  2 +-
 kernel/cobalt/dovetail/tick.c                 | 39 +++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/tick.h
 create mode 100644 kernel/cobalt/dovetail/tick.c

diff --git a/include/cobalt/kernel/dovetail/pipeline/tick.h b/include/cobalt/kernel/dovetail/pipeline/tick.h
new file mode 100644
index 000000000..409581a3c
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/tick.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_IPIPE_TICK_H
+#define _COBALT_KERNEL_IPIPE_TICK_H
+
+int pipeline_install_tick_proxy(void);
+
+void pipeline_uninstall_tick_proxy(void);
+
+#endif /* !_COBALT_KERNEL_IPIPE_TICK_H */
diff --git a/kernel/cobalt/dovetail/Makefile b/kernel/cobalt/dovetail/Makefile
index 24320b3f2..84788f9ce 100644
--- a/kernel/cobalt/dovetail/Makefile
+++ b/kernel/cobalt/dovetail/Makefile
@@ -2,4 +2,4 @@ ccflags-y += -I$(srctree)/kernel
 
 obj-y +=	pipeline.o
 
-pipeline-y :=	init.o kevents.o sched.o
+pipeline-y :=	init.o kevents.o sched.o tick.o
diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
new file mode 100644
index 000000000..01927f708
--- /dev/null
+++ b/kernel/cobalt/dovetail/tick.c
@@ -0,0 +1,39 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2001,2002,2003,2007,2012 Philippe Gerum <rpm@xenomai.org>.
+ * Copyright (C) 2004 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
+ */
+
+#include <linux/tick.h>
+#include <cobalt/kernel/intr.h>
+#include <pipeline/tick.h>
+
+int pipeline_install_tick_proxy(void)
+{
+	int ret;
+
+	ret = pipeline_request_timer_ipi(xnintr_core_clock_handler);
+	if (ret)
+		return ret;
+
+	/* Install the proxy tick device */
+	TODO();	ret = 0;
+	if (ret)
+		goto fail_proxy;
+
+	return 0;
+
+fail_proxy:
+	pipeline_free_timer_ipi();
+
+	return ret;
+}
+
+void pipeline_uninstall_tick_proxy(void)
+{
+	/* Uninstall the proxy tick device. */
+	TODO();
+
+	pipeline_free_timer_ipi();
+}
-- 
2.26.2


