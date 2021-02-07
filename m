From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 13/18] cobalt/trace: dovetail: add placeholders for trace
 management
Date: Sun,  7 Feb 2021 17:04:29 +0100
Message-Id: <20210207160434.2869121-13-rpm@xenomai.org>
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
 .../cobalt/kernel/dovetail/pipeline/trace.h   | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/trace.h

diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
new file mode 100644
index 000000000..819b8a713
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
@@ -0,0 +1,123 @@
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
+#ifndef _COBALT_KERNEL_DOVETAIL_TRACE_H
+#define _COBALT_KERNEL_DOVETAIL_TRACE_H
+
+#include <linux/types.h>
+#include <linux/kconfig.h>
+#include <cobalt/uapi/kernel/trace.h>
+
+static inline int xntrace_max_begin(unsigned long v)
+{
+//#chz: NTD
+	//ipipe_trace_begin(v);
+	return 0;
+}
+
+static inline int xntrace_max_end(unsigned long v)
+{
+//#chz: NTD
+	//ipipe_trace_end(v);
+	return 0;
+}
+
+static inline int xntrace_max_reset(void)
+{
+//#chz: NTD
+	//ipipe_trace_max_reset();
+	return 0;
+}
+
+static inline int xntrace_user_start(void)
+{
+//#chz: NTD
+	//return ipipe_trace_frozen_reset();
+	return 0;
+}
+
+static inline int xntrace_user_stop(unsigned long v)
+{
+//#chz: NTD
+	//ipipe_trace_freeze(v);
+	return 0;
+}
+
+static inline int xntrace_user_freeze(unsigned long v, int once)
+{
+	int ret = 0;
+//#chz: NTD
+/*
+	if (!once)
+		ret = ipipe_trace_frozen_reset();
+
+	ipipe_trace_freeze(v);
+*/
+	return ret;
+}
+
+static inline int xntrace_special(unsigned char id, unsigned long v)
+{
+//#chz: NTD
+//	ipipe_trace_special(id, v);
+	return 0;
+}
+
+static inline int xntrace_special_u64(unsigned char id,
+					unsigned long long v)
+{
+//#chz: NTD
+//	ipipe_trace_special(id, (unsigned long)(v >> 32));
+//	ipipe_trace_special(id, (unsigned long)(v & 0xFFFFFFFF));
+	return 0;
+}
+
+static inline int xntrace_pid(pid_t pid, short prio)
+{
+//#chz: NTD
+//	ipipe_trace_pid(pid, prio);
+	return 0;
+}
+
+static inline int xntrace_tick(unsigned long delay_ticks)
+{
+//#chz: NTD
+//	ipipe_trace_event(0, delay_ticks);
+	return 0;
+}
+
+static inline int xntrace_panic_freeze(void)
+{
+//#chz: NTD
+//	ipipe_trace_panic_freeze();
+	return 0;
+}
+
+static inline int xntrace_panic_dump(void)
+{
+//#chz: NTD
+//	ipipe_trace_panic_dump();
+	return 0;
+}
+
+static inline bool xntrace_enabled(void)
+{
+	return IS_ENABLED(CONFIG_DOVETAIL_TRACE);
+}
+
+#endif /* !_COBALT_KERNEL_DOVETAIL_TRACE_H */
-- 
2.26.2


