From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 07/18] cobalt/lock: dovetail: define hard lock type
Date: Sun,  7 Feb 2021 17:04:23 +0100
Message-Id: <20210207160434.2869121-7-rpm@xenomai.org>
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
 .../cobalt/kernel/dovetail/pipeline/lock.h    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/lock.h

diff --git a/include/cobalt/kernel/dovetail/pipeline/lock.h b/include/cobalt/kernel/dovetail/pipeline/lock.h
new file mode 100644
index 000000000..8866c92bf
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/lock.h
@@ -0,0 +1,28 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_DOVETAIL_LOCK_H
+#define _COBALT_KERNEL_DOVETAIL_LOCK_H
+
+#include <linux/spinlock.h>
+
+typedef hard_spinlock_t pipeline_spinlock_t;
+
+#define PIPELINE_SPIN_LOCK_UNLOCKED(__name)  __HARD_SPIN_LOCK_INITIALIZER(__name)
+
+#ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
+/* Disable UP-over-SMP kernel optimization in debug mode. */
+#define __locking_active__  1
+
+#else
+
+#ifdef CONFIG_SMP
+#define __locking_active__  1
+#else
+#define __locking_active__  IS_ENABLED(CONFIG_SMP)
+#endif
+
+#endif
+
+#endif /* !_COBALT_KERNEL_DOVETAIL_LOCK_H */
-- 
2.26.2


