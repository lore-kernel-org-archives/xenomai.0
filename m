From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-images 7/7] Add kas option for swithing off debug
Date: Thu, 22 Jul 2021 23:18:11 -0400
Message-Id: <20210723031811.19290-8-hongzhan.chen@intel.com>
In-Reply-To: <20210723031811.19290-1-hongzhan.chen@intel.com>
References: <20210723031811.19290-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

For performance or latency testing and demonstration, debug switches
should be off but it is on by default.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 opt-set-nodbg.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 opt-set-nodbg.yml

diff --git a/opt-set-nodbg.yml b/opt-set-nodbg.yml
new file mode 100644
index 0000000..16a2fec
--- /dev/null
+++ b/opt-set-nodbg.yml
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (C) 2021 Intel Corporation
+#
+# Authors:
+#  Hongzhan Chen <hongzhan.chen@intel.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+# to use kernel config fragments for disabling dbg and
+# improving performance
+
+local_conf_header:
+  distro-nodbg: |
+    DISTRO_NODBG = "YES"
-- 
2.17.1


