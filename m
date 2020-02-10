From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 03/10] Switch to Xenomai 3.1
Date: Mon, 10 Feb 2020 19:17:42 +0100
Message-Id: <82214bcd9844cbce82e35aa8afc0ede55e01cfe0.1581358669.git.jan.kiszka@siemens.com>
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

Make 3.1 our distro's default version, removing the previous "stable"
version. The latter is currently equivalent to master.

The idea of setting the default to a release is providing the user a
well-defined version, rather than stable of the day. We will introduce
a stable head kas fragment once needed.

With "stable" gone, we also need to update the kernel version selection
magic. It is only needed for "XENOMAI_3_0" now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/include/xenomai-version.inc                      | 12 ++++++------
 conf/distro/xenomai-demo.conf                                |  2 ++
 conf/machine/hikey.conf                                      |  1 -
 conf/machine/qemu-arm64.conf                                 |  1 -
 kas.yml                                                      |  4 +---
 .../xenomai/{xenomai_stable.bb => xenomai_3.1.bb}            |  9 ++++-----
 6 files changed, 13 insertions(+), 16 deletions(-)
 rename recipes-xenomai/xenomai/{xenomai_stable.bb => xenomai_3.1.bb} (59%)

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index 286d3a7..2696b5c 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -9,9 +9,9 @@
 # SPDX-License-Identifier: MIT
 #
 
-XENOMAI_NEXT_KERNEL_VERSION = "4.19%"
-XENOMAI_STABLE_VERSION_LIST = "stable 3.0 3.0% 3.0.% 3.0.10"
-XENOMAI_STABLE_KERNEL_VERSION = "4.14%"
-# if PREFERRED_VERSION_xenomai contains any item from XENOMAI_STABLE_VERSION_LIST use
-# XENOMAI_STABLE_KERNEL_VERSION
-PREFERRED_VERSION_linux-xenomai ?= "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai','${XENOMAI_STABLE_VERSION_LIST}','${XENOMAI_STABLE_KERNEL_VERSION}','${XENOMAI_NEXT_KERNEL_VERSION}',d) }"
+XENOMAI_DEFAULT_KERNEL_VERSION = "4.19%"
+XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.10"
+XENOMAI_3_0_KERNEL_VERSION = "4.14%"
+# if PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
+# XENOMAI_3_0_KERNEL_VERSION
+PREFERRED_VERSION_linux-xenomai ?= "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai','${XENOMAI_3_0_VERSION_LIST}','${XENOMAI_3_0_KERNEL_VERSION}','${XENOMAI_DEFAULT_KERNEL_VERSION}',d) }"
diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 333d532..1c9209d 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -10,6 +10,8 @@
 #
 
 require conf/distro/debian-buster.conf
+
+PREFERRED_VERSION_xenomai ?= "3.1%"
 include conf/distro/include/xenomai-version.inc
 
 HOST_DISTRO ?= "debian-buster"
diff --git a/conf/machine/hikey.conf b/conf/machine/hikey.conf
index c28c350..9c90b9d 100644
--- a/conf/machine/hikey.conf
+++ b/conf/machine/hikey.conf
@@ -16,6 +16,5 @@ IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 
 IMAGE_PREINSTALL_append = " firmware-ti-connectivity"
 
-PREFERRED_VERSION_xenomai = "next"
 # DTB for testing
 DTB_FILE = "hi6220-hikey.dtb"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 472f619..a633095 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -12,4 +12,3 @@
 require qemu-machine.inc
 
 DISTRO_ARCH = "arm64"
-PREFERRED_VERSION_xenomai = "next"
diff --git a/kas.yml b/kas.yml
index 26debc4..f4ee0e5 100644
--- a/kas.yml
+++ b/kas.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018
+# Copyright (c) Siemens AG, 2018-2020
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -35,8 +35,6 @@ local_conf_header:
     CONF_VERSION = "1"
   cross: |
     ISAR_CROSS_COMPILE = "1"
-  xenomai-version: |
-    PREFERRED_VERSION_xenomai ?= "stable"
   github-mirror: |
     PREMIRRORS_prepend = " \
         git://gitlab.denx.de/Xenomai/ git://github.com/xenomai-ci/ \n"
diff --git a/recipes-xenomai/xenomai/xenomai_stable.bb b/recipes-xenomai/xenomai/xenomai_3.1.bb
similarity index 59%
rename from recipes-xenomai/xenomai/xenomai_stable.bb
rename to recipes-xenomai/xenomai/xenomai_3.1.bb
index a0f109c..3af1d98 100644
--- a/recipes-xenomai/xenomai/xenomai_stable.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.1.bb
@@ -1,10 +1,10 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2020
 #
 # Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
@@ -12,7 +12,6 @@
 require xenomai.inc
 
 SRC_URI = " \
-    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x"
-SRCREV = "${AUTOREV}"
-PV = "stable"
+    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=master;tag=v${PV}"
+
 S = "${WORKDIR}/git"
-- 
2.16.4


