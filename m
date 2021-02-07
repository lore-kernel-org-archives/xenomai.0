From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 14/18] cobalt/wrapper: dovetail: add empty placeholder
Date: Sun,  7 Feb 2021 17:04:30 +0100
Message-Id: <20210207160434.2869121-14-rpm@xenomai.org>
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
 include/cobalt/kernel/dovetail/pipeline/wrappers.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/wrappers.h

diff --git a/include/cobalt/kernel/dovetail/pipeline/wrappers.h b/include/cobalt/kernel/dovetail/pipeline/wrappers.h
new file mode 100644
index 000000000..133aacac3
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/wrappers.h
@@ -0,0 +1,9 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+#ifndef _COBALT_KERNEL_DOVETAIL_WRAPPERS_H
+#define _COBALT_KERNEL_DOVETAIL_WRAPPERS_H
+
+/* No wrapper needed so far. */
+
+#endif /* !_COBALT_KERNEL_DOVETAIL_WRAPPERS_H */
-- 
2.26.2


