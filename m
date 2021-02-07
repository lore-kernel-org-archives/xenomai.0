From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 03/18] cobalt/irq: dovetail: add placeholders for out-of-band
 IRQ management
Date: Sun,  7 Feb 2021 17:04:19 +0100
Message-Id: <20210207160434.2869121-3-rpm@xenomai.org>
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
 .../kernel/dovetail/pipeline/pipeline.h       | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/pipeline.h

diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
new file mode 100644
index 000000000..4b8f6b259
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -0,0 +1,84 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_DOVETAIL_PIPELINE_H
+#define _COBALT_KERNEL_DOVETAIL_PIPELINE_H
+
+#include <linux/irq_pipeline.h>
+#include <cobalt/kernel/assert.h>
+
+typedef unsigned long spl_t;
+
+/*
+ * We only keep the LSB when testing in SMP mode in order to strip off
+ * the recursion marker (0x2) the nklock may store there.
+ */
+#define splhigh(x)  ((x) = oob_irq_save() & 1)
+#ifdef CONFIG_SMP
+#define splexit(x)  oob_irq_restore(x & 1)
+#else /* !CONFIG_SMP */
+#define splexit(x)  oob_irq_restore(x)
+#endif /* !CONFIG_SMP */
+#define splmax()    oob_irq_disable()
+#define splnone()   oob_irq_enable()
+#define spltest()   oob_irqs_disabled()
+
+#define is_secondary_domain()	running_inband()
+#define is_primary_domain()	running_oob()
+
+#ifdef CONFIG_SMP
+
+static inline int pipeline_request_resched_ipi(void (*handler)(void))
+{
+	/* Trap the out-of-band rescheduling interrupt. */
+	TODO();
+
+	return 0;
+}
+
+static inline void pipeline_free_resched_ipi(void)
+{
+	/* Release the out-of-band rescheduling interrupt. */
+	TODO();
+}
+
+static inline void pipeline_send_resched_ipi(const struct cpumask *dest)
+{
+	/*
+	 * Trigger the out-of-band rescheduling interrupt on remote
+	 * CPU(s).
+	 */
+	TODO();
+}
+
+static inline int pipeline_request_timer_ipi(void (*handler)(void))
+{
+	/* Trap the out-of-band timer interrupt. */
+	TODO();
+
+	return 0;
+}
+
+static inline void pipeline_free_timer_ipi(void)
+{
+	/* Release the out-of-band timer interrupt. */
+	TODO();
+}
+
+static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
+{
+	/*
+	 * Trigger the out-of-band timer interrupt on remote CPU(s).
+	 */
+	TODO();
+}
+
+#endif
+
+static inline void pipeline_prepare_panic(void)
+{
+	/* N/A */
+}
+
+#endif /* !_COBALT_KERNEL_DOVETAIL_PIPELINE_H */
-- 
2.26.2


