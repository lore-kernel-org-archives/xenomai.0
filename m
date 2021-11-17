From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 1/4] xenomai: Add 3.2.1 and update other
 stable versions
Date: Wed, 17 Nov 2021 19:34:16 +0100
Message-Id: <61f1c50c18284eb30540658cf17879c8f0dbb2c5.1637174059.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1637174059.git.jan.kiszka@siemens.com>
References: <cover.1637174059.git.jan.kiszka@siemens.com>
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

This adds 3.2.1 as new default and bumps older stable options to 3.1.2
and 3.0.12, respectively.

Updating Xenomai releases also requires updating the mapping function in
xenomai-version.inc - which was forgotten too often. Set a link via a
comment at this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/include/xenomai-version.inc       | 21 ++++++++++++++-----
 conf/distro/xenomai-demo.conf                 |  4 ++--
 opt-xenomai-3.2.x.yml                         | 17 +++++++++++++++
 .../{xenomai_3.0.11.bb => xenomai_3.0.12.bb}  |  2 ++
 .../{xenomai_3.1.1.bb => xenomai_3.1.2.bb}    |  2 ++
 .../{xenomai_3.1.1.bb => xenomai_3.2.1.bb}    |  4 +++-
 6 files changed, 42 insertions(+), 8 deletions(-)
 create mode 100644 opt-xenomai-3.2.x.yml
 rename recipes-xenomai/xenomai/{xenomai_3.0.11.bb => xenomai_3.0.12.bb} (79%)
 copy recipes-xenomai/xenomai/{xenomai_3.1.1.bb => xenomai_3.1.2.bb} (79%)
 rename recipes-xenomai/xenomai/{xenomai_3.1.1.bb => xenomai_3.2.1.bb} (73%)

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index 24e0dd6..e8e819b 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -9,9 +9,20 @@
 # SPDX-License-Identifier: MIT
 #
 
-XENOMAI_DEFAULT_KERNEL_VERSION = "5.4%"
-XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.10"
+XENOMAI_DEFAULT_KERNEL_VERSION = "5.10%"
+
+XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.12"
 XENOMAI_3_0_KERNEL_VERSION = "4.4%"
-# if PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
-# XENOMAI_3_0_KERNEL_VERSION
-PREFERRED_VERSION_linux-xenomai ?= "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai','${XENOMAI_3_0_VERSION_LIST}','${XENOMAI_3_0_KERNEL_VERSION}','${XENOMAI_DEFAULT_KERNEL_VERSION}',d) }"
+
+XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.2"
+XENOMAI_3_1_KERNEL_VERSION = "5.4%"
+
+# If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
+# XENOMAI_3_0_KERNEL_VERSION. Same for XENOMAI_3_1_VERSION_LIST.
+PREFERRED_VERSION_linux-xenomai ?= \
+    "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
+        '${XENOMAI_3_0_VERSION_LIST}', '${XENOMAI_3_0_KERNEL_VERSION}', \
+        bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
+            '${XENOMAI_3_1_VERSION_LIST}', '${XENOMAI_3_1_KERNEL_VERSION}', \
+            '${XENOMAI_DEFAULT_KERNEL_VERSION}', d), \
+        d)}"
diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 4794584..10c37e1 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018
+# Copyright (c) Siemens AG, 2018-2021
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,7 +11,7 @@
 
 require conf/distro/debian-bullseye.conf
 
-PREFERRED_VERSION_xenomai ?= "3.1%"
+PREFERRED_VERSION_xenomai ?= "3.2%"
 include conf/distro/include/xenomai-version.inc
 
 HOST_DISTRO ?= "debian-bullseye"
diff --git a/opt-xenomai-3.2.x.yml b/opt-xenomai-3.2.x.yml
new file mode 100644
index 0000000..1abcef9
--- /dev/null
+++ b/opt-xenomai-3.2.x.yml
@@ -0,0 +1,17 @@
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
+header:
+  version: 10
+
+local_conf_header:
+  xenomai-3-2-x: |
+    PREFERRED_VERSION_xenomai = "stable-3.2.x"
diff --git a/recipes-xenomai/xenomai/xenomai_3.0.11.bb b/recipes-xenomai/xenomai/xenomai_3.0.12.bb
similarity index 79%
rename from recipes-xenomai/xenomai/xenomai_3.0.11.bb
rename to recipes-xenomai/xenomai/xenomai_3.0.12.bb
index b21b763..afc1920 100644
--- a/recipes-xenomai/xenomai/xenomai_3.0.11.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.0.12.bb
@@ -11,6 +11,8 @@
 
 require xenomai.inc
 
+# Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
+
 SRC_URI = " \
     git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV} \
     "
diff --git a/recipes-xenomai/xenomai/xenomai_3.1.1.bb b/recipes-xenomai/xenomai/xenomai_3.1.2.bb
similarity index 79%
copy from recipes-xenomai/xenomai/xenomai_3.1.1.bb
copy to recipes-xenomai/xenomai/xenomai_3.1.2.bb
index 5a3c41d..e501e41 100644
--- a/recipes-xenomai/xenomai/xenomai_3.1.1.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.1.2.bb
@@ -11,6 +11,8 @@
 
 require xenomai.inc
 
+# Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
+
 SRC_URI = " \
     git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.1.x;tag=v${PV}"
 
diff --git a/recipes-xenomai/xenomai/xenomai_3.1.1.bb b/recipes-xenomai/xenomai/xenomai_3.2.1.bb
similarity index 73%
rename from recipes-xenomai/xenomai/xenomai_3.1.1.bb
rename to recipes-xenomai/xenomai/xenomai_3.2.1.bb
index 5a3c41d..e99d7fe 100644
--- a/recipes-xenomai/xenomai/xenomai_3.1.1.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.2.1.bb
@@ -11,7 +11,9 @@
 
 require xenomai.inc
 
+# Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
+
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.1.x;tag=v${PV}"
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=master;tag=v${PV}"
 
 S = "${WORKDIR}/git"
-- 
2.31.1


