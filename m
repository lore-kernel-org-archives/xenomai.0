From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/4] cobalt/kernel: pipeline: add abstract synthetic IRQ API
Date: Sun, 17 Jan 2021 16:25:00 +0100
Message-Id: <20210117152503.478765-1-rpm@xenomai.org>
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

Add wrappers to create "synthetic IRQs" the I-pipe way (used to be
called "virtual IRQs" there). Those interrupt channels can only be
triggered by software, with per-CPU semantics. We use them to schedule
handlers to be run on the in-band execution stage, meaning "secondary
mode" in the Cobalt jargon.

We don't provide for executing handlers on the out-of-band stage,
because Cobalt does not need this.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/ipipe/pipeline/sirq.h | 58 +++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/sirq.h

diff --git a/include/cobalt/kernel/ipipe/pipeline/sirq.h b/include/cobalt/kernel/ipipe/pipeline/sirq.h
new file mode 100644
index 000000000..7c39244f9
--- /dev/null
+++ b/include/cobalt/kernel/ipipe/pipeline/sirq.h
@@ -0,0 +1,58 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_KERNEL_IPIPE_SIRQ_H
+#define _COBALT_KERNEL_IPIPE_SIRQ_H
+
+#include <linux/ipipe.h>
+#include <pipeline/machine.h>
+
+/*
+ * Wrappers to create "synthetic IRQs" the I-pipe way (used to be
+ * called "virtual IRQs" there). Those interrupt channels can only be
+ * triggered by software; they have per-CPU semantics. We use them to
+ * schedule handlers to be run on the in-band execution stage, meaning
+ * "secondary mode" in the Cobalt jargon.
+ */
+
+static inline
+int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
+{
+	int sirq = ipipe_alloc_virq(), ret;
+
+	if (sirq == 0)
+		return -EAGAIN;
+
+	/*
+	 * ipipe_irq_handler_t is close enough to the signature of a
+	 * regular IRQ handler: use the latter in the generic code
+	 * shared with Dovetail.  The extraneous return code will be
+	 * ignored by the I-pipe core.
+	 */
+	ret = ipipe_request_irq(ipipe_root_domain, sirq,
+				(ipipe_irq_handler_t)handler,
+				NULL, NULL);
+	if (ret) {
+		ipipe_free_virq(sirq);
+		return ret;
+	}
+
+	return sirq;
+}
+
+static inline
+void pipeline_delete_inband_sirq(int sirq)
+{
+	ipipe_free_irq(ipipe_root_domain, sirq);
+	ipipe_free_virq(sirq);
+}
+
+static inline void pipeline_post_sirq(int sirq)
+{
+	ipipe_post_irq_root(sirq);
+}
+
+#endif /* !_COBALT_KERNEL_IPIPE_SIRQ_H */
-- 
2.26.2


