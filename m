From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 1/3] linux-xenomai: Add recipe to build 5.10
 dovetail release
Date: Thu,  9 Sep 2021 19:44:32 +0200
Message-Id: <bbd239f178f2764196c71a8989aca6db9eeceb0f.1631209474.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1631209474.git.jan.kiszka@siemens.com>
References: <cover.1631209474.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Provides an option for a stable 5.10 revision, analogously to I-pipe
releases.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_5.10.bb | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 recipes-kernel/linux/linux-xenomai_5.10.bb

diff --git a/recipes-kernel/linux/linux-xenomai_5.10.bb b/recipes-kernel/linux/linux-xenomai_5.10.bb
new file mode 100644
index 0000000..afc129c
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai_5.10.bb
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai.inc
+
+SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
+SRCREV = "v5.10.61-dovetail"
+PV = "5.10.61+"
+
+S = "${WORKDIR}/git"
-- 
2.31.1


