From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/5] cobalt/intr: dovetail: implement interrupt management,
 handling
Date: Sat, 27 Mar 2021 11:35:23 +0100
Message-Id: <20210327103524.2305814-5-rpm@xenomai.org>
In-Reply-To: <20210327103524.2305814-1-rpm@xenomai.org>
References: <20210327103524.2305814-1-rpm@xenomai.org>
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
 include/cobalt/kernel/dovetail/pipeline/irq.h |  24 ++++
 kernel/cobalt/dovetail/Makefile               |   2 +-
 kernel/cobalt/dovetail/intr.c                 | 133 ++++++++++++++++++
 3 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/irq.h
 create mode 100644 kernel/cobalt/dovetail/intr.c

diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
new file mode 100644
index 000000000..55d9b8ff1
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
@@ -0,0 +1,24 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
+#define _COBALT_KERNEL_DOVETAIL_IRQ_H
+
+static inline void xnintr_init_proc(void)
+{
+	/* N/A */
+}
+
+static inline void xnintr_cleanup_proc(void)
+{
+	/* N/A */
+}
+
+static inline int xnintr_mount(void)
+{
+	/* N/A */
+	return 0;
+}
+
+#endif /* !_COBALT_KERNEL_DOVETAIL_IRQ_H */
diff --git a/kernel/cobalt/dovetail/Makefile b/kernel/cobalt/dovetail/Makefile
index 1ecbd97a9..f49d3a06b 100644
--- a/kernel/cobalt/dovetail/Makefile
+++ b/kernel/cobalt/dovetail/Makefile
@@ -2,4 +2,4 @@ ccflags-y += -I$(srctree)/kernel
 
 obj-y +=	pipeline.o
 
-pipeline-y :=	init.o kevents.o sched.o tick.o syscall.o
+pipeline-y :=	init.o kevents.o sched.o tick.o syscall.o intr.o
diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
new file mode 100644
index 000000000..068dfe306
--- /dev/null
+++ b/kernel/cobalt/dovetail/intr.c
@@ -0,0 +1,133 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq_pipeline.h>
+#include <linux/tick.h>
+#include <cobalt/kernel/sched.h>
+#include <cobalt/kernel/lock.h>
+#include <cobalt/kernel/intr.h>
+
+void xnintr_host_tick(struct xnsched *sched) /* hard irqs off */
+{
+	sched->lflags &= ~XNHTICK;
+	tick_notify_proxy();
+}
+
+/*
+ * Low-level core clock irq handler. This one forwards ticks from the
+ * Xenomai platform timer to nkclock exclusively.
+ */
+void xnintr_core_clock_handler(void)
+{
+	struct xnsched *sched;
+
+	xnlock_get(&nklock);
+	xnclock_tick(&nkclock);
+	xnlock_put(&nklock);
+
+	/*
+	 * If the core clock interrupt preempted a real-time thread,
+	 * any transition to the root thread has already triggered a
+	 * host tick propagation from xnsched_run(), so at this point,
+	 * we only need to propagate the host tick in case the
+	 * interrupt preempted the root thread.
+	 */
+	sched = xnsched_current();
+	if ((sched->lflags & XNHTICK) &&
+	    xnthread_test_state(sched->curr, XNROOT))
+		xnintr_host_tick(sched);
+}
+
+static irqreturn_t xnintr_irq_handler(int irq, void *dev_id)
+{
+	struct xnintr *intr = dev_id;
+	int ret;
+
+	ret = intr->isr(intr);
+	XENO_WARN_ON_ONCE(USER, (ret & XN_IRQ_STATMASK) == 0);
+
+	if (ret & XN_IRQ_DISABLE)
+		disable_irq(irq);
+	else if (ret & XN_IRQ_PROPAGATE)
+		irq_post_inband(irq);
+
+	return ret & XN_IRQ_NONE ? IRQ_NONE : IRQ_HANDLED;
+}
+
+int xnintr_init(struct xnintr *intr, const char *name,
+		unsigned int irq, xnisr_t isr, xniack_t iack,
+		int flags)
+{
+	secondary_mode_only();
+
+	intr->irq = irq;
+	intr->isr = isr;
+	intr->iack = NULL;	/* unused */
+	intr->cookie = NULL;
+	intr->name = name ? : "<unknown>";
+	intr->flags = flags;
+	intr->status = 0;
+	intr->unhandled = 0;	/* unused */
+	raw_spin_lock_init(&intr->lock); /* unused */
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xnintr_init);
+
+void xnintr_destroy(struct xnintr *intr)
+{
+	secondary_mode_only();
+	xnintr_detach(intr);
+}
+EXPORT_SYMBOL_GPL(xnintr_destroy);
+
+int xnintr_attach(struct xnintr *intr, void *cookie)
+{
+	int ret;
+
+	secondary_mode_only();
+
+	intr->cookie = cookie;
+
+	ret = irq_set_affinity_hint(intr->irq, &xnsched_realtime_cpus);
+	if (ret)
+		return ret;
+
+	return request_irq(intr->irq, xnintr_irq_handler, IRQF_OOB,
+			intr->name, intr);
+}
+EXPORT_SYMBOL_GPL(xnintr_attach);
+
+void xnintr_detach(struct xnintr *intr)
+{
+	secondary_mode_only();
+	free_irq(intr->irq, intr);
+}
+EXPORT_SYMBOL_GPL(xnintr_detach);
+
+void xnintr_enable(struct xnintr *intr)
+{
+	secondary_mode_only();
+	enable_irq(intr->irq);
+}
+EXPORT_SYMBOL_GPL(xnintr_enable);
+
+void xnintr_disable(struct xnintr *intr)
+{
+	secondary_mode_only();
+	disable_irq(intr->irq);
+}
+EXPORT_SYMBOL_GPL(xnintr_disable);
+
+void xnintr_affinity(struct xnintr *intr, cpumask_t cpumask)
+{
+	int ret;
+
+	secondary_mode_only();
+	ret = irq_set_affinity_hint(intr->irq, &cpumask);
+
+	WARN_ON_ONCE(ret);
+}
+EXPORT_SYMBOL_GPL(xnintr_affinity);
-- 
2.29.2


