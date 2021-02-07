From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 09/18] cobalt/thread: dovetail: define out-of-band state
 accessors
Date: Sun,  7 Feb 2021 17:04:25 +0100
Message-Id: <20210207160434.2869121-9-rpm@xenomai.org>
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
 .../cobalt/kernel/dovetail/pipeline/thread.h  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/thread.h

diff --git a/include/cobalt/kernel/dovetail/pipeline/thread.h b/include/cobalt/kernel/dovetail/pipeline/thread.h
new file mode 100644
index 000000000..1e6b0f091
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/thread.h
@@ -0,0 +1,27 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_KERNEL_DOVETAIL_THREAD_H
+#define _COBALT_KERNEL_DOVETAIL_THREAD_H
+
+#include <linux/dovetail.h>
+
+struct xnthread;
+
+#define cobalt_threadinfo oob_thread_state
+
+static inline struct cobalt_threadinfo *pipeline_current(void)
+{
+	return dovetail_current_state();
+}
+
+static inline
+struct xnthread *pipeline_thread_from_task(struct task_struct *p)
+{
+	return dovetail_task_state(p)->thread;
+}
+
+#endif /* !_COBALT_KERNEL_DOVETAIL_THREAD_H */
-- 
2.26.2


