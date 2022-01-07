From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v3 1/5] xenomai: Unify stable recipes,
 add link for 3.2.x
Date: Fri, 7 Jan 2022 13:00:58 +0100
Message-ID: <cc2e2d7878311a4f953d688ca48d9dce565afb41.1641556862.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641556862.git.jan.kiszka@siemens.com>
References: <cover.1641556862.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../xenomai/xenomai_stable-3.0.x.bb           |  7 +++---
 .../xenomai/xenomai_stable-3.1.x.bb           | 22 +------------------
 .../xenomai/xenomai_stable-3.2.x.bb           |  1 +
 3 files changed, 6 insertions(+), 24 deletions(-)
 mode change 100644 => 120000 recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
 create mode 120000 recipes-xenomai/xenomai/xenomai_stable-3.2.x.bb

diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
index 758d5ea..6231e9e 100644
--- a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2020
+# Copyright (c) Siemens AG, 2018-2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,10 +12,11 @@
 
 require xenomai.inc
 
-CHANGELOG_V = "3.0.x-head"
+XENOMAI_VERSION = "${@d.getVar('PV').split('-')[1]}"
+CHANGELOG_V = "${XENOMAI_VERSION}-head"
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.0.x"
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v${XENOMAI_VERSION}"
 SRCREV = "${AUTOREV}"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
deleted file mode 100644
index d2c7a33..0000000
--- a/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require xenomai.inc
-
-CHANGELOG_V = "3.1.x-head"
-
-SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.1.x"
-SRCREV = "${AUTOREV}"
-
-S = "${WORKDIR}/git"
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
new file mode 120000
index 0000000..0914c52
--- /dev/null
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
@@ -0,0 +1 @@
+xenomai_stable-3.0.x.bb
\ No newline at end of file
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.2.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.2.x.bb
new file mode 120000
index 0000000..0914c52
--- /dev/null
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.2.x.bb
@@ -0,0 +1 @@
+xenomai_stable-3.0.x.bb
\ No newline at end of file
-- 
2.31.1


