From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-image 2/3] Add kas option for swithing off debug
Date: Tue, 27 Jul 2021 22:21:23 -0400
Message-Id: <20210728022124.23466-3-hongzhan.chen@intel.com>
In-Reply-To: <20210728022124.23466-1-hongzhan.chen@intel.com>
References: <20210728022124.23466-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

For performance or latency testing and demonstration, debug can
be switched off.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 README.md         |  5 +++++
 opt-set-nodbg.yml | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 opt-set-nodbg.yml

diff --git a/README.md b/README.md
index 004c854..9eb5ad5 100644
--- a/README.md
+++ b/README.md
@@ -30,6 +30,11 @@ The QEMU ARM64 target is selected by `... kas.yml:board-qemu-arm64.yml` and
 started via `start-qemu.sh arm64`. Make sure to have `qemu-aarch64-system`
 installed.
 
+For performance or latency testing and demonstration, you may want to switch
+off xenomai and linux related debug like this:
+
+    kas-container build kas.yml:board-qemu-amd64.yml:opt-set-nodbg.yml
+
 ### Physical Targets
 
 This repository contains recipes for x86 (`board-x86-64-efi.yml`),
diff --git a/opt-set-nodbg.yml b/opt-set-nodbg.yml
new file mode 100644
index 0000000..eaa505d
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
+    DISTRO_NODBG = "1"
-- 
2.17.1


