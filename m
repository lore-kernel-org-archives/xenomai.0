From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail 03/13] cobalt/trace: pipeline: abstract trace calls
Date: Sat,  2 Jan 2021 10:33:43 +0100
Message-Id: <20210102093353.3195090-4-rpm@xenomai.org>
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

Unlike the I-pipe, Dovetail comes with no specific tracer, tracepoints
can be sent to common ftrace-based tracers, with the 'function' tracer
reporting Dovetail-specific information such as the current execution
stage, and the real & virtual interrupt states (hard disabled/enabled,
stalled/unstalled) for the current context.

In other words, ftrace's 'function' tracer with Dovetail is similar to
the I-pipe specific tracer.

Since we can use ftrace through the regular kernel interface with
Dovetail, the legacy trace interface can move to the I-pipe section.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/ipipe/pipeline/trace.h | 111 +++++++++++++++++++
 include/cobalt/kernel/trace.h                | 101 +----------------
 kernel/drivers/testing/timerbench.c          |  12 +-
 3 files changed, 120 insertions(+), 104 deletions(-)
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/trace.h

diff --git a/include/cobalt/kernel/ipipe/pipeline/trace.h b/include/cobalt/kernel/ipipe/pipeline/trace.h
new file mode 100644
index 000000000..d92e57a63
--- /dev/null
+++ b/include/cobalt/kernel/ipipe/pipeline/trace.h
@@ -0,0 +1,111 @@
+/*
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@web.de>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+#ifndef _COBALT_KERNEL_IPIPE_TRACE_H
+#define _COBALT_KERNEL_IPIPE_TRACE_H
+
+#include <linux/types.h>
+#include <linux/kconfig.h>
+#include <linux/ipipe_trace.h>
+#include <cobalt/uapi/kernel/trace.h>
+
+static inline int xntrace_max_begin(unsigned long v)
+{
+	ipipe_trace_begin(v);
+	return 0;
+}
+
+static inline int xntrace_max_end(unsigned long v)
+{
+	ipipe_trace_end(v);
+	return 0;
+}
+
+static inline int xntrace_max_reset(void)
+{
+	ipipe_trace_max_reset();
+	return 0;
+}
+
+static inline int xntrace_user_start(void)
+{
+	return ipipe_trace_frozen_reset();
+}
+
+static inline int xntrace_user_stop(unsigned long v)
+{
+	ipipe_trace_freeze(v);
+	return 0;
+}
+
+static inline int xntrace_user_freeze(unsigned long v, int once)
+{
+	int ret = 0;
+
+	if (!once)
+		ret = ipipe_trace_frozen_reset();
+
+	ipipe_trace_freeze(v);
+
+	return ret;
+}
+
+static inline int xntrace_special(unsigned char id, unsigned long v)
+{
+	ipipe_trace_special(id, v);
+	return 0;
+}
+
+static inline int xntrace_special_u64(unsigned char id,
+				      unsigned long long v)
+{
+	ipipe_trace_special(id, (unsigned long)(v >> 32));
+	ipipe_trace_special(id, (unsigned long)(v & 0xFFFFFFFF));
+	return 0;
+}
+
+static inline int xntrace_pid(pid_t pid, short prio)
+{
+	ipipe_trace_pid(pid, prio);
+	return 0;
+}
+
+static inline int xntrace_tick(unsigned long delay_ticks)
+{
+	ipipe_trace_event(0, delay_ticks);
+	return 0;
+}
+
+static inline int xntrace_panic_freeze(void)
+{
+	ipipe_trace_panic_freeze();
+	return 0;
+}
+
+static inline int xntrace_panic_dump(void)
+{
+	ipipe_trace_panic_dump();
+	return 0;
+}
+
+static inline bool xntrace_enabled(void)
+{
+	return IS_ENABLED(CONFIG_IPIPE_TRACE);
+}
+
+#endif /* !_COBALT_KERNEL_IPIPE_TRACE_H */
diff --git a/include/cobalt/kernel/trace.h b/include/cobalt/kernel/trace.h
index 5f2b6ca2a..e46dd4ebd 100644
--- a/include/cobalt/kernel/trace.h
+++ b/include/cobalt/kernel/trace.h
@@ -1,105 +1,10 @@
 /*
- * Copyright (C) 2006 Jan Kiszka <jan.kiszka@web.de>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
+ * SPDX-License-Identifier: GPL-2.0
  */
+
 #ifndef _COBALT_KERNEL_TRACE_H
 #define _COBALT_KERNEL_TRACE_H
 
-#include <linux/types.h>
-#include <linux/ipipe_trace.h>
-#include <cobalt/uapi/kernel/trace.h>
-
-static inline int xntrace_max_begin(unsigned long v)
-{
-	ipipe_trace_begin(v);
-	return 0;
-}
-
-static inline int xntrace_max_end(unsigned long v)
-{
-	ipipe_trace_end(v);
-	return 0;
-}
-
-static inline int xntrace_max_reset(void)
-{
-	ipipe_trace_max_reset();
-	return 0;
-}
-
-static inline int xntrace_user_start(void)
-{
-	return ipipe_trace_frozen_reset();
-}
-
-static inline int xntrace_user_stop(unsigned long v)
-{
-	ipipe_trace_freeze(v);
-	return 0;
-}
-
-static inline int xntrace_user_freeze(unsigned long v, int once)
-{
-	int ret = 0;
-
-	if (!once)
-		ret = ipipe_trace_frozen_reset();
-
-	ipipe_trace_freeze(v);
-
-	return ret;
-}
-
-static inline int xntrace_special(unsigned char id, unsigned long v)
-{
-	ipipe_trace_special(id, v);
-	return 0;
-}
-
-static inline int xntrace_special_u64(unsigned char id,
-				      unsigned long long v)
-{
-	ipipe_trace_special(id, (unsigned long)(v >> 32));
-	ipipe_trace_special(id, (unsigned long)(v & 0xFFFFFFFF));
-	return 0;
-}
-
-static inline int xntrace_pid(pid_t pid, short prio)
-{
-	ipipe_trace_pid(pid, prio);
-	return 0;
-}
-
-static inline int xntrace_tick(unsigned long delay_ticks)
-{
-	ipipe_trace_event(0, delay_ticks);
-	return 0;
-}
-
-static inline int xntrace_panic_freeze(void)
-{
-	ipipe_trace_panic_freeze();
-	return 0;
-}
-
-static inline int xntrace_panic_dump(void)
-{
-	ipipe_trace_panic_dump();
-	return 0;
-}
+#include <pipeline/trace.h>
 
 #endif /* !_COBALT_KERNEL_TRACE_H */
diff --git a/kernel/drivers/testing/timerbench.c b/kernel/drivers/testing/timerbench.c
index 8b91bae9b..31f0bea76 100644
--- a/kernel/drivers/testing/timerbench.c
+++ b/kernel/drivers/testing/timerbench.c
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/semaphore.h>
-#include <linux/ipipe_trace.h>
+#include <cobalt/kernel/trace.h>
 #include <cobalt/kernel/arith.h>
 #include <rtdm/testing.h>
 #include <rtdm/driver.h>
@@ -78,13 +78,13 @@ static void eval_inner_loop(struct rt_tmbench_context *ctx, __s32 dt)
 		ctx->curr.min = dt;
 	ctx->curr.avg += dt;
 
-#ifdef CONFIG_IPIPE_TRACE
-	if (ctx->freeze_max && (dt > ctx->result.overall.max) && !ctx->warmup) {
-		ipipe_trace_frozen_reset();
-		ipipe_trace_freeze(dt);
+	if (xntrace_enabled() &&
+		ctx->freeze_max &&
+		(dt > ctx->result.overall.max) &&
+		!ctx->warmup) {
+		xntrace_user_freeze(dt, false);
 		ctx->result.overall.max = dt;
 	}
-#endif /* CONFIG_IPIPE_TRACE */
 
 	ctx->date += ctx->period;
 
-- 
2.26.2


