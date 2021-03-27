From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/5] cobalt/intr: pipeline: abstract interrupt system inits
Date: Sat, 27 Mar 2021 11:35:22 +0100
Message-Id: <20210327103524.2305814-4-rpm@xenomai.org>
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
 include/cobalt/kernel/intr.h               |  7 +------
 include/cobalt/kernel/ipipe/pipeline/irq.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/irq.h

diff --git a/include/cobalt/kernel/intr.h b/include/cobalt/kernel/intr.h
index 107b16bfc..2636c2cbc 100644
--- a/include/cobalt/kernel/intr.h
+++ b/include/cobalt/kernel/intr.h
@@ -21,6 +21,7 @@
 
 #include <linux/spinlock.h>
 #include <cobalt/kernel/stat.h>
+#include <pipeline/irq.h>
 
 /**
  * @addtogroup cobalt_core_irq
@@ -99,16 +100,10 @@ struct xnintr_iterator {
     struct xnintr *prev;	/** Previously visited xnintr object (internal use). */
 };
 
-int xnintr_mount(void);
-
 void xnintr_core_clock_handler(void);
 
 void xnintr_host_tick(struct xnsched *sched);
 
-void xnintr_init_proc(void);
-
-void xnintr_cleanup_proc(void);
-
     /* Public interface. */
 
 int xnintr_init(struct xnintr *intr,
diff --git a/include/cobalt/kernel/ipipe/pipeline/irq.h b/include/cobalt/kernel/ipipe/pipeline/irq.h
new file mode 100644
index 000000000..a2db772d3
--- /dev/null
+++ b/include/cobalt/kernel/ipipe/pipeline/irq.h
@@ -0,0 +1,14 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_IPIPE_IRQ_H
+#define _COBALT_KERNEL_IPIPE_IRQ_H
+
+void xnintr_init_proc(void);
+
+void xnintr_cleanup_proc(void);
+
+int xnintr_mount(void);
+
+#endif /* !_COBALT_KERNEL_IPIPE_IRQ_H */
-- 
2.29.2


