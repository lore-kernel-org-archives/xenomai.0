From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 08/18] cobalt/sched: dovetail: add placeholders for context
 switching
Date: Sun,  7 Feb 2021 17:04:24 +0100
Message-Id: <20210207160434.2869121-8-rpm@xenomai.org>
In-Reply-To: <20210207160434.2869121-1-rpm@xenomai.org>
References: <20210207160434.2869121-1-rpm@xenomai.org>
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
 .../cobalt/kernel/dovetail/pipeline/sched.h   | 50 ++++++++++++
 kernel/cobalt/dovetail/Makefile               |  2 +-
 kernel/cobalt/dovetail/sched.c                | 77 +++++++++++++++++++
 3 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/sched.h
 create mode 100644 kernel/cobalt/dovetail/sched.c

diff --git a/include/cobalt/kernel/dovetail/pipeline/sched.h b/include/cobalt/kernel/dovetail/pipeline/sched.h
new file mode 100644
index 000000000..b5d6c1773
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/sched.h
@@ -0,0 +1,50 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_KERNEL_DOVETAIL_SCHED_H
+#define _COBALT_KERNEL_DOVETAIL_SCHED_H
+
+struct xnthread;
+struct xnsched;
+struct task_struct;
+
+void pipeline_init_shadow_tcb(struct xnthread *thread);
+
+void pipeline_init_root_tcb(struct xnthread *thread);
+
+int ___xnsched_run(struct xnsched *sched);
+
+static inline int pipeline_schedule(struct xnsched *sched)
+{
+	return run_oob_call((int (*)(void *))___xnsched_run, sched);
+}
+
+static inline void pipeline_prep_switch_oob(struct xnthread *root)
+{
+	/* N/A */
+}
+
+bool pipeline_switch_to(struct xnthread *prev,
+			struct xnthread *next,
+			bool leaving_inband);
+
+int pipeline_leave_inband(void);
+
+int pipeline_leave_oob_prepare(void);
+
+void pipeline_leave_oob_finish(void);
+
+static inline
+void pipeline_finalize_thread(struct xnthread *thread)
+{
+	/* N/A */
+}
+
+void pipeline_raise_mayday(struct task_struct *tsk);
+
+void pipeline_clear_mayday(void);
+
+#endif /* !_COBALT_KERNEL_DOVETAIL_SCHED_H */
diff --git a/kernel/cobalt/dovetail/Makefile b/kernel/cobalt/dovetail/Makefile
index c92227f4c..24320b3f2 100644
--- a/kernel/cobalt/dovetail/Makefile
+++ b/kernel/cobalt/dovetail/Makefile
@@ -2,4 +2,4 @@ ccflags-y += -I$(srctree)/kernel
 
 obj-y +=	pipeline.o
 
-pipeline-y :=	init.o kevents.o
+pipeline-y :=	init.o kevents.o sched.o
diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
new file mode 100644
index 000000000..71f763d39
--- /dev/null
+++ b/kernel/cobalt/dovetail/sched.c
@@ -0,0 +1,77 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2001-2020 Philippe Gerum <rpm@xenomai.org>.
+ */
+
+#include <linux/cpuidle.h>
+#include <cobalt/kernel/thread.h>
+#include <cobalt/kernel/sched.h>
+#include <pipeline/sched.h>
+#include <trace/events/cobalt-core.h>
+
+/* in-band stage, hard_irqs_disabled() */
+bool irq_cpuidle_control(struct cpuidle_device *dev,
+			struct cpuidle_state *state)
+{
+	/*
+	 * Deny entering sleep state if this entails stopping the
+	 * timer (i.e. C3STOP misfeature).
+	 */
+	if (state && (state->flags & CPUIDLE_FLAG_TIMER_STOP))
+		return false;
+
+	return true;
+}
+
+bool pipeline_switch_to(struct xnthread *prev, struct xnthread *next,
+			bool leaving_inband)
+{
+	return dovetail_context_switch(&xnthread_archtcb(prev)->altsched,
+			&xnthread_archtcb(next)->altsched, leaving_inband);
+}
+
+void pipeline_init_shadow_tcb(struct xnthread *thread)
+{
+	/*
+	 * Initialize the alternate scheduling control block.
+	 */
+	TODO();
+
+	trace_cobalt_shadow_map(thread);
+}
+
+void pipeline_init_root_tcb(struct xnthread *thread)
+{
+	/*
+	 * Initialize the alternate scheduling control block.
+	 */
+	TODO();
+}
+
+int pipeline_leave_inband(void)
+{
+	return dovetail_leave_inband();
+}
+
+int pipeline_leave_oob_prepare(void)
+{
+	dovetail_leave_oob();
+
+	return XNRELAX;
+}
+
+void pipeline_leave_oob_finish(void)
+{
+	dovetail_resume_inband();
+}
+
+void pipeline_raise_mayday(struct task_struct *tsk)
+{
+	dovetail_send_mayday(tsk);
+}
+
+void pipeline_clear_mayday(void) /* May solely affect current. */
+{
+	clear_thread_flag(TIF_MAYDAY);
+}
-- 
2.26.2


