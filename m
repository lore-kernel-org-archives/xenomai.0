From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 1/3] linux-xenomai: Add support for 5.15 kernel
Date: Mon, 10 Jan 2022 18:32:17 +0100
Message-ID: <22bbfa2f0354dcec99e7cdcefc7a4c6f1d988458.1641835939.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641835939.git.jan.kiszka@siemens.com>
References: <cover.1641835939.git.jan.kiszka@siemens.com>
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

Add a recipe and kas option for current release and extends the latest
recipe to track the new branch.

Default kernel becomes 5.15 for xenomai-next, therefore add rules for
3.2 to xenomai-version.inc.

The Kconfig menu is updated accordingly. Limit 5.15 support to Xenomai
next because not all related issues were resolved in 3.2.

BeagleBone with 5.15 requires to refresh the defconfig, adding now
needed CONFIG_TI_CPSW_SWITCHDEV, otherwise network remains down.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                      | 10 ++++++++++
 conf/distro/include/xenomai-version.inc      | 14 ++++++++++----
 opt-linux-5.15.yml                           | 17 +++++++++++++++++
 opt-linux-latest-5.15.yml                    | 18 ++++++++++++++++++
 recipes-kernel/linux/files/armhf_defconfig   |  1 +
 recipes-kernel/linux/linux-xenomai_5.15.bb   | 18 ++++++++++++++++++
 recipes-kernel/linux/linux-xenomai_latest.bb |  9 ++++++---
 7 files changed, 80 insertions(+), 7 deletions(-)
 create mode 100644 opt-linux-5.15.yml
 create mode 100644 opt-linux-latest-5.15.yml
 create mode 100644 recipes-kernel/linux/linux-xenomai_5.15.bb

diff --git a/Kconfig b/Kconfig
index df47058..bdc67b7 100644
--- a/Kconfig
+++ b/Kconfig
@@ -89,6 +89,14 @@ choice
 	prompt "Kernel version"
 	default KERNEL_5_10
 
+config KERNEL_5_15_LATEST
+	bool "Head of 5.15 Dovetail branch"
+	depends on XENOMAI_LATEST
+
+config KERNEL_5_15
+	bool "Latest 5.15 Dovetail version"
+	depends on XENOMAI_LATEST
+
 config KERNEL_5_10_LATEST
 	bool "Head of 5.10 Dovetail branch"
 	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
@@ -125,6 +133,8 @@ endchoice
 
 config KAS_INCLUDE_KERNEL
 	string
+	default "opt-linux-latest-5.15.yml" if KERNEL_5_15_LATEST
+	default "opt-linux-5.15.yml" if KERNEL_5_15
 	default "opt-linux-latest-5.10.yml" if KERNEL_5_10_LATEST
 	default "opt-linux-5.10.yml" if KERNEL_5_10
 	default "opt-linux-latest-5.4.yml" if KERNEL_5_4_LATEST
diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index dc34415..7bd80ef 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-XENOMAI_DEFAULT_KERNEL_VERSION = "5.10%"
+XENOMAI_DEFAULT_KERNEL_VERSION = "5.15%"
 
 XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.12 stable-3.0.x"
 XENOMAI_3_0_KERNEL_VERSION = "4.4%"
@@ -17,12 +17,18 @@ XENOMAI_3_0_KERNEL_VERSION = "4.4%"
 XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.2 stable-3.1.x"
 XENOMAI_3_1_KERNEL_VERSION = "5.4%"
 
+XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.1 stable-3.2.x"
+XENOMAI_3_2_KERNEL_VERSION = "5.10%"
+
 # If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
-# XENOMAI_3_0_KERNEL_VERSION. Same for XENOMAI_3_1_VERSION_LIST.
+# XENOMAI_3_0_KERNEL_VERSION. Same for the other XENOMAI_*_VERSION_LIST.
 PREFERRED_VERSION_linux-xenomai ?= \
     "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
         '${XENOMAI_3_0_VERSION_LIST}', '${XENOMAI_3_0_KERNEL_VERSION}', \
         bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
             '${XENOMAI_3_1_VERSION_LIST}', '${XENOMAI_3_1_KERNEL_VERSION}', \
-            '${XENOMAI_DEFAULT_KERNEL_VERSION}', d), \
+            bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
+                '${XENOMAI_3_2_VERSION_LIST}', '${XENOMAI_3_2_KERNEL_VERSION}', \
+                '${XENOMAI_DEFAULT_KERNEL_VERSION}', d), \
+            d), \
         d)}"
diff --git a/opt-linux-5.15.yml b/opt-linux-5.15.yml
new file mode 100644
index 0000000..c7447e9
--- /dev/null
+++ b/opt-linux-5.15.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2022
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
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai = "5.15%"
diff --git a/opt-linux-latest-5.15.yml b/opt-linux-latest-5.15.yml
new file mode 100644
index 0000000..02e1a61
--- /dev/null
+++ b/opt-linux-latest-5.15.yml
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2022
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
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    LATEST_GIT_BRANCH = "5.15"
diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
index eda674c..b9342a5 100644
--- a/recipes-kernel/linux/files/armhf_defconfig
+++ b/recipes-kernel/linux/files/armhf_defconfig
@@ -2256,6 +2256,7 @@ CONFIG_TI_DAVINCI_CPDMA=y
 CONFIG_TI_CPSW_PHY_SEL=y
 CONFIG_TI_CPSW_ALE=y
 CONFIG_TI_CPSW=y
+CONFIG_TI_CPSW_SWITCHDEV=y
 # CONFIG_TI_CPTS is not set
 # CONFIG_TLAN is not set
 CONFIG_NET_VENDOR_VIA=y
diff --git a/recipes-kernel/linux/linux-xenomai_5.15.bb b/recipes-kernel/linux/linux-xenomai_5.15.bb
new file mode 100644
index 0000000..9a3b12e
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai_5.15.bb
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
+SRCREV = "v5.15.9-dovetail1"
+PV = "5.15.9+"
+
+S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index bc5379e..4117113 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -31,7 +31,8 @@ GIT_BRANCH = "${@ \
     'ipipe-4.4.y-cip' if is_xeno_3_0(d) \
     else 'ipipe-x86-4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') \
-    else 'v5.10.y-dovetail-rebase' }"
+    else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
+    else 'v5.15.y-dovetail-rebase' }"
 
 GIT_REPO_armhf = "${@ \
     'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) \
@@ -41,7 +42,8 @@ GIT_BRANCH_armhf = "${@ \
     'ipipe-4.4.y-cip' if is_xeno_3_0(d) \
     else 'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
-    else 'v5.10.y-dovetail-rebase' }"
+    else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
+    else 'v5.15.y-dovetail-rebase' }"
 
 GIT_REPO_arm64 = "${@ \
     'git://github.com/xenomai-ci/ipipe-arm64.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
@@ -49,7 +51,8 @@ GIT_REPO_arm64 = "${@ \
 GIT_BRANCH_arm64 = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
-    else 'v5.10.y-dovetail-rebase' }"
+    else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
+    else 'v5.15.y-dovetail-rebase' }"
 
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
-- 
2.31.1


