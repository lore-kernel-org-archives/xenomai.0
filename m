From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 05/18] cobalt/inband_work: dovetail: provide for deferred
 in-band calls
Date: Sun,  7 Feb 2021 17:04:21 +0100
Message-Id: <20210207160434.2869121-5-rpm@xenomai.org>
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

Dovetail enables irq_work for deferring the execution of a routine
until the in-band stage is active again on the current CPU, we don't
need to provide for any additional mechanism. Therefore we just need
to wrap the pipeline interface calls to the irq_work API.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../kernel/dovetail/pipeline/inband_work.h    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/inband_work.h

diff --git a/include/cobalt/kernel/dovetail/pipeline/inband_work.h b/include/cobalt/kernel/dovetail/pipeline/inband_work.h
new file mode 100644
index 000000000..317a31de7
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/inband_work.h
@@ -0,0 +1,32 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_KERNEL_DOVETAIL_INBAND_WORK_H
+#define _COBALT_KERNEL_DOVETAIL_INBAND_WORK_H
+
+#include <linux/irq_work.h>
+
+/*
+ * This field must be named inband_work and appear first in the
+ * container work struct.
+ */
+struct pipeline_inband_work {
+	struct irq_work work;
+};
+
+#define PIPELINE_INBAND_WORK_INITIALIZER(__work, __handler)		\
+	{								\
+		.work = {						\
+			.func = (void (*)(struct irq_work *))		\
+			__handler,					\
+			.flags = ATOMIC_INIT(0),			\
+		},							\
+	}
+
+#define pipeline_post_inband_work(__work)				\
+			irq_work_queue(&(__work)->inband_work.work)
+
+#endif /* !_COBALT_KERNEL_DOVETAIL_INBAND_WORK_H */
-- 
2.26.2


