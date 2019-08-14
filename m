From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH] kernel/linux-xenomai: Update versions
Date: Wed, 14 Aug 2019 16:24:35 +0200
Message-Id: <20190814142435.28231-1-Quirin.Gylstorff@siemens.com>
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

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Kernel 4.14 will soon be deprecated. Add kernel 4.19 for armhf and
x86 builds. Currently there is no 4.19 for arm64 available, therefore
pin to 4.14.%.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/qemu-arm64.conf               |  1 +
 recipes-kernel/linux/linux-xenomai_4.14.bb | 10 +++++-----
 recipes-kernel/linux/linux-xenomai_4.19.bb | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 recipes-kernel/linux/linux-xenomai_4.19.bb

diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index a633095..283b3aa 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -12,3 +12,4 @@
 require qemu-machine.inc
 
 DISTRO_ARCH = "arm64"
+PREFERRED_VERSION_linux-xenomai = "4.14.%"
diff --git a/recipes-kernel/linux/linux-xenomai_4.14.bb b/recipes-kernel/linux/linux-xenomai_4.14.bb
index 49ede27..14030d6 100644
--- a/recipes-kernel/linux/linux-xenomai_4.14.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.14.bb
@@ -12,15 +12,15 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.14.y"
-SRCREV_amd64 = "eb0ab801116e0268358f1ca250251f02e82eed4a"
-PV_amd64 = "4.14.111+"
+SRCREV_amd64 = "fdfa1aff4578edf6a03e2e77ea20bf7f97863954"
+PV_amd64 = "4.14.134+"
 
 SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;branch=stable/4.14.78-arm64"
 SRCREV_arm64 = "dec5e42fd43de238df816b31cadfb83b268b7136"
 PV_arm64 = "4.14.78+"
 
-SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=stable/4.14.85-arm"
-SRCREV_armhf = "35a84af5b7e3193e90ee129a91054657c02e8248"
-PV_armhf = "4.14.85+"
+SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=stable/4.14.96-arm"
+SRCREV_armhf = "723539db0d5a1c995c9bb5524abe311a97b33e43"
+PV_armhf = "4.14.96+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
new file mode 100644
index 0000000..9af5659
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -0,0 +1,21 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai.inc
+
+SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.19.y"
+SRCREV_amd64 = "d8ca6738bdff660d033ce755db55e7fe5210379a"
+PV_amd64 = "4.19.60+"
+
+SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1;tag=ipipe-core-4.19.33-arm-2"
+PV_armhf = "4.19.33+"
+
+S = "${WORKDIR}/git"
-- 
2.20.1


