From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-image 2/2] Add kas option for swithing on xenomai debug
Date: Wed, 28 Jul 2021 04:21:01 -0400
Message-Id: <20210728082101.5561-3-hongzhan.chen@intel.com>
In-Reply-To: <20210728082101.5561-1-hongzhan.chen@intel.com>
References: <20210728082101.5561-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Xenomai related debug that may influence performance is switched
off by default.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 README.md     |  5 +++++
 opt-debug.yml | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 opt-debug.yml

diff --git a/README.md b/README.md
index 004c854..2f48181 100644
--- a/README.md
+++ b/README.md
@@ -30,6 +30,11 @@ The QEMU ARM64 target is selected by `... kas.yml:board-qemu-arm64.yml` and
 started via `start-qemu.sh arm64`. Make sure to have `qemu-aarch64-system`
 installed.
 
+Xenomai related debug is switched off by default. But you still can switch it
+on like this:
+
+    kas-container build kas.yml:board-qemu-amd64.yml:opt-debug.yml
+
 ### Physical Targets
 
 This repository contains recipes for x86 (`board-x86-64-efi.yml`),
diff --git a/opt-debug.yml b/opt-debug.yml
new file mode 100644
index 0000000..d967b83
--- /dev/null
+++ b/opt-debug.yml
@@ -0,0 +1,19 @@
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
+# do not apply no debug kernel config fragment
+
+local_conf_header:
+  xenomai-debug: |
+    XENOMAI_DEBUG = "1"
-- 
2.17.1


