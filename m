From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 6/8] cobalt/dovetail: provide core-specific context extensions
Date: Sat, 20 Feb 2021 13:45:25 +0100
Message-Id: <20210220124527.401015-6-rpm@xenomai.org>
In-Reply-To: <20210220124527.401015-1-rpm@xenomai.org>
References: <20210220124527.401015-1-rpm@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Philippe Gerum <rpm@xenomai.org>

In order to intimately connect Cobalt to the kernel, Dovetail allows
us to extend the latter with data and procedures we need:

- we can embed our own context information into a set of critical
  kernel data structures. This information should be defined as a set
  of core-specific types, such as struct oob_thread_state which is
  going to be part of struct thread_info.

- we can define preparation and finalization handlers for out-of-band
  IRQ handling, which Dovetail should invoke right after entering the
  outer interrupt frame, then right before leaving it respectively.

Add the couple of interface headers we need to connect those elements
to the kernel.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/include/dovetail/irq.h         | 52 ++++++++++++++++++++
 kernel/cobalt/include/dovetail/thread_info.h | 33 +++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 kernel/cobalt/include/dovetail/irq.h
 create mode 100644 kernel/cobalt/include/dovetail/thread_info.h

diff --git a/kernel/cobalt/include/dovetail/irq.h b/kernel/cobalt/include/dovetail/irq.h
new file mode 100644
index 000000000..66d020fde
--- /dev/null
+++ b/kernel/cobalt/include/dovetail/irq.h
@@ -0,0 +1,52 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2017 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_DOVETAIL_IRQ_H
+#define _COBALT_DOVETAIL_IRQ_H
+
+#ifdef CONFIG_XENOMAI
+
+#include <cobalt/kernel/sched.h>
+
+/* hard irqs off. */
+static inline void irq_enter_pipeline(void)
+{
+	struct xnsched *sched = xnsched_current();
+
+	sched->lflags |= XNINIRQ;
+}
+
+/* hard irqs off. */
+static inline void irq_exit_pipeline(void)
+{
+	struct xnsched *sched = xnsched_current();
+
+	sched->lflags &= ~XNINIRQ;
+
+	/*
+	 * CAUTION: Switching stages as a result of rescheduling may
+	 * re-enable irqs, shut them off before returning if so.
+	 */
+	if ((sched->status|sched->lflags) & XNRESCHED) {
+		xnsched_run();
+		if (!hard_irqs_disabled())
+			hard_local_irq_disable();
+	}
+}
+
+#else  /* !CONFIG_XENOMAI */
+
+static inline void irq_enter_pipeline(void)
+{
+}
+
+static inline void irq_exit_pipeline(void)
+{
+}
+
+#endif	/* !CONFIG_XENOMAI */
+
+#endif /* !_COBALT_DOVETAIL_IRQ_H */
diff --git a/kernel/cobalt/include/dovetail/thread_info.h b/kernel/cobalt/include/dovetail/thread_info.h
new file mode 100644
index 000000000..69b89de35
--- /dev/null
+++ b/kernel/cobalt/include/dovetail/thread_info.h
@@ -0,0 +1,33 @@
+/**
+ * Copyright (C) 2012 Philippe Gerum <rpm@xenomai.org>.
+ * Copyright (c) Siemens AG, 2020
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+#ifndef _COBALT_DOVETAIL_THREAD_INFO_H
+#define _COBALT_DOVETAIL_THREAD_INFO_H
+
+struct xnthread;
+struct cobalt_process;
+
+struct oob_thread_state {
+	/* Core thread backlink. */
+	struct xnthread *thread;
+	/* User process backlink. NULL for core threads. */
+	struct cobalt_process *process;
+};
+
+#endif /* !_COBALT_DOVETAIL_THREAD_INFO_H */
-- 
2.26.2


