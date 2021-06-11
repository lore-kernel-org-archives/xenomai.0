From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 3/5] linux-xenomai: Add 5.4 recipe and make it
 default
Date: Fri, 11 Jun 2021 22:13:10 +0200
Message-Id: <73be0c2eba0da87a487708b29fcbf31899bbf03a.1623442392.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623442392.git.jan.kiszka@siemens.com>
References: <cover.1623442392.git.jan.kiszka@siemens.com>
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

This is currently our most recent stable kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/include/xenomai-version.inc   |  2 +-
 recipes-kernel/linux/linux-xenomai_5.4.bb | 26 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 recipes-kernel/linux/linux-xenomai_5.4.bb

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index 9bf3087..24e0dd6 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-XENOMAI_DEFAULT_KERNEL_VERSION = "4.19%"
+XENOMAI_DEFAULT_KERNEL_VERSION = "5.4%"
 XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.10"
 XENOMAI_3_0_KERNEL_VERSION = "4.4%"
 # if PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
diff --git a/recipes-kernel/linux/linux-xenomai_5.4.bb b/recipes-kernel/linux/linux-xenomai_5.4.bb
new file mode 100644
index 0000000..9f070cf
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai_5.4.bb
@@ -0,0 +1,26 @@
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
+SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
+SRCREV_amd64 ?= "ipipe-core-5.4.124-x86-5"
+PV_amd64 ?= "5.4.124+"
+
+SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
+SRCREV_arm64 ?= "ipipe-core-5.4.119-arm64-2"
+PV_arm64 ?= "5.4.119+"
+
+SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
+SRCREV_armhf ?= "ipipe-core-5.4.119-arm-2"
+PV_armhf ?= "5.4.119+"
+
+S = "${WORKDIR}/git"
-- 
2.26.2


