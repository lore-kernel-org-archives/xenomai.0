From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 04/10] Switch Xenomai 3.0 to kernel 4.4
Date: Mon, 10 Feb 2020 19:17:43 +0100
Message-Id: <8f2cd06600fede6e403f3cfd560828e9a088ab57.1581358669.git.jan.kiszka@siemens.com>
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

The reason for this is that only 4.4 is still maintained, thus should
rather be exposed to testing.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/include/xenomai-version.inc   |  2 +-
 recipes-kernel/linux/linux-xenomai_4.4.bb | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 recipes-kernel/linux/linux-xenomai_4.4.bb

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index 2696b5c..9bf3087 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -11,7 +11,7 @@
 
 XENOMAI_DEFAULT_KERNEL_VERSION = "4.19%"
 XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.10"
-XENOMAI_3_0_KERNEL_VERSION = "4.14%"
+XENOMAI_3_0_KERNEL_VERSION = "4.4%"
 # if PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
 # XENOMAI_3_0_KERNEL_VERSION
 PREFERRED_VERSION_linux-xenomai ?= "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai','${XENOMAI_3_0_VERSION_LIST}','${XENOMAI_3_0_KERNEL_VERSION}','${XENOMAI_DEFAULT_KERNEL_VERSION}',d) }"
diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai_4.4.bb
new file mode 100644
index 0000000..f76e847
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai_4.4.bb
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2018-2020
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai.inc
+
+SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe.git;protocol=https;nobranch=1;tag=ipipe-core-4.4.208-cip41-x86-21"
+PV_amd64 = "4.4.208+"
+
+SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe.git;protocol=https;nobranch=1;tag=ipipe-core-4.4.176-arm-10"
+PV_armhf = "4.4.176+"
+
+S = "${WORKDIR}/git"
-- 
2.16.4


