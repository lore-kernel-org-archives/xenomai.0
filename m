From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 15/18] cobalt/syscall: dovetail: implement syscall hooks
Date: Sun,  7 Feb 2021 17:04:31 +0100
Message-Id: <20210207160434.2869121-15-rpm@xenomai.org>
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

Dovetail interposes on the in-band syscall entry, passing the request
on to Cobalt via different handlers depending on the calling context:

- via handle_oob_syscall() when the current thread is running
  out-of-band, and the request is not an in-band (i.e. regular Linux)
  system call, therefore shall be handled by Xenomai. This is the fast
  path.

- via handle_pipelined_syscall() in all other cases, e.g. when current
  is running in-band, and/or the system call shall be handled by the
  in-band kernel eventually (useful for relaxing the current thread in
  the process if out-of-band on entry).

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/dovetail/Makefile  |  2 +-
 kernel/cobalt/dovetail/syscall.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 kernel/cobalt/dovetail/syscall.c

diff --git a/kernel/cobalt/dovetail/Makefile b/kernel/cobalt/dovetail/Makefile
index 84788f9ce..1ecbd97a9 100644
--- a/kernel/cobalt/dovetail/Makefile
+++ b/kernel/cobalt/dovetail/Makefile
@@ -2,4 +2,4 @@ ccflags-y += -I$(srctree)/kernel
 
 obj-y +=	pipeline.o
 
-pipeline-y :=	init.o kevents.o sched.o tick.o
+pipeline-y :=	init.o kevents.o sched.o tick.o syscall.o
diff --git a/kernel/cobalt/dovetail/syscall.c b/kernel/cobalt/dovetail/syscall.c
new file mode 100644
index 000000000..cec6c0244
--- /dev/null
+++ b/kernel/cobalt/dovetail/syscall.c
@@ -0,0 +1,26 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>
+ * Copyright (C) 2005 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
+ */
+
+#include <linux/irqstage.h>
+#include <pipeline/pipeline.h>
+#include <pipeline/kevents.h>
+#include <cobalt/kernel/assert.h>
+#include <xenomai/posix/syscall.h>
+
+int handle_pipelined_syscall(struct irq_stage *stage, struct pt_regs *regs)
+{
+	if (unlikely(running_inband()))
+		return handle_root_syscall(regs);
+
+	return handle_head_syscall(stage == &inband_stage, regs);
+}
+
+void handle_oob_syscall(struct pt_regs *regs)
+{
+	int ret = handle_head_syscall(false, regs);
+	XENO_BUG_ON(COBALT, ret == KEVENT_PROPAGATE);
+}
-- 
2.26.2


