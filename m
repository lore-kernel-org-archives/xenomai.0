From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 02/18] cobalt/sirq: dovetail: add placeholders for synthetic
 IRQ management
Date: Sun,  7 Feb 2021 17:04:18 +0100
Message-Id: <20210207160434.2869121-2-rpm@xenomai.org>
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
 .../cobalt/kernel/dovetail/pipeline/sirq.h    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/sirq.h

diff --git a/include/cobalt/kernel/dovetail/pipeline/sirq.h b/include/cobalt/kernel/dovetail/pipeline/sirq.h
new file mode 100644
index 000000000..be9dc587f
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/sirq.h
@@ -0,0 +1,47 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_KERNEL_DOVETAIL_SIRQ_H
+#define _COBALT_KERNEL_DOVETAIL_SIRQ_H
+
+#include <linux/irq_pipeline.h>
+#include <cobalt/kernel/assert.h>
+
+/*
+ * Wrappers to create "synthetic IRQs" the Dovetail way. Those
+ * interrupt channels can only be trigged by software, in order to run
+ * a handler on the in-band execution stage.
+ */
+
+static inline
+int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
+{
+	/*
+	 * Allocate an IRQ from the synthetic interrupt domain then
+	 * trap it to @handler, to be fired from the in-band stage.
+	 */
+	TODO();
+
+	return 0;
+}
+
+static inline
+void pipeline_delete_inband_sirq(int sirq)
+{
+	/*
+	 * Free the synthetic IRQ then deallocate it to its
+	 * originating domain.
+	 */
+	TODO();
+}
+
+static inline void pipeline_post_sirq(int sirq)
+{
+	/* Trigger the synthetic IRQ */
+	TODO();
+}
+
+#endif /* !_COBALT_KERNEL_IPIPE_SIRQ_H */
-- 
2.26.2


