From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 06/10] xenomai: Consolidate master and next
 recipes
Date: Mon, 10 Feb 2020 19:17:45 +0100
Message-Id: <a2bbe8d3da470dc12dde95d6f6d40a0979221e51.1581358669.git.jan.kiszka@siemens.com>
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

These can be come one, just using a link from one to the other.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-xenomai/xenomai/xenomai_master.bb |  8 ++++----
 recipes-xenomai/xenomai/xenomai_next.bb   | 22 +---------------------
 2 files changed, 5 insertions(+), 25 deletions(-)
 mode change 100644 => 120000 recipes-xenomai/xenomai/xenomai_next.bb

diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
index d95ede6..0852c0c 100644
--- a/recipes-xenomai/xenomai/xenomai_master.bb
+++ b/recipes-xenomai/xenomai/xenomai_master.bb
@@ -1,10 +1,11 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2018-2020
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
@@ -12,8 +13,7 @@
 require xenomai.inc
 
 SRC_URI = " \
-    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=master"
+    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=${PV}"
 SRCREV = "${AUTOREV}"
-PV = "master"
-S = "${WORKDIR}/git"
 
+S = "${WORKDIR}/git"
diff --git a/recipes-xenomai/xenomai/xenomai_next.bb b/recipes-xenomai/xenomai/xenomai_next.bb
deleted file mode 100644
index e216124..0000000
--- a/recipes-xenomai/xenomai/xenomai_next.bb
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2018
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require xenomai.inc
-
-SRC_URI = " \
-    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=next"
-SRCREV = "${AUTOREV}" 
-PV = "next"
-
-S = "${WORKDIR}/git"
-
-
diff --git a/recipes-xenomai/xenomai/xenomai_next.bb b/recipes-xenomai/xenomai/xenomai_next.bb
new file mode 120000
index 0000000..69b56dc
--- /dev/null
+++ b/recipes-xenomai/xenomai/xenomai_next.bb
@@ -0,0 +1 @@
+xenomai_master.bb
\ No newline at end of file
-- 
2.16.4


