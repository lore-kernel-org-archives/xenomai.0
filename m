From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 05/10] Provide Xenomai 3.0.x target
Date: Mon, 10 Feb 2020 19:17:44 +0100
Message-Id: <426b390b64b0fbeb6fea791c50ee77ff5e2f09d2.1581358669.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1581358669.git.jan.kiszka@siemens.com>
References: <cover.1581358669.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1581358669.git.jan.kiszka@siemens.com>
References: <cover.1581358669.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to build the latest revision from stable/v3.0.x, primarily
for testing purposes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 opt-xenomai-3.0.x.yml                           | 17 +++++++++++++++++
 recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 opt-xenomai-3.0.x.yml
 create mode 100644 recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb

diff --git a/opt-xenomai-3.0.x.yml b/opt-xenomai-3.0.x.yml
new file mode 100644
index 0000000..591f3fc
--- /dev/null
+++ b/opt-xenomai-3.0.x.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+local_conf_header:
+  xenomai-3-0-x: |
+    PREFERRED_VERSION_xenomai = "stable-3.0.x"
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
new file mode 100644
index 0000000..34cb4b1
--- /dev/null
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
@@ -0,0 +1,19 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2018-2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require xenomai.inc
+
+SRC_URI = " \
+    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x"
+SRCREV = "${AUTOREV}"
+
+S = "${WORKDIR}/git"
-- 
2.16.4


