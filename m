From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 7/9] kernel: Update
Date: Tue, 10 Sep 2019 16:44:57 +0200
Message-Id: <20190910144459.13239-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
References: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
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

Update amd64 to new released kernel versions.
Remove arm64 pinning to 4.14.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/hikey.conf                    |  4 +---
 conf/machine/qemu-arm64.conf               |  1 -
 recipes-kernel/linux/files/amd64_defconfig |  2 +-
 recipes-kernel/linux/linux-xenomai_4.19.bb | 12 ++++++++----
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/conf/machine/hikey.conf b/conf/machine/hikey.conf
index 3c93507..11cf635 100644
--- a/conf/machine/hikey.conf
+++ b/conf/machine/hikey.conf
@@ -14,8 +14,6 @@ DISTRO_ARCH = "arm64"
 IMAGE_TYPE ?= "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 
-PREFERRED_VERSION_linux-xenomai = "4.14.%"
-
 IMAGE_PREINSTALL_append = " firmware-ti-connectivity"
 
-PREFERRED_VERSION_xenomai = "next"
\ No newline at end of file
+PREFERRED_VERSION_xenomai = "next"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 9e1d984..472f619 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -13,4 +13,3 @@ require qemu-machine.inc
 
 DISTRO_ARCH = "arm64"
 PREFERRED_VERSION_xenomai = "next"
-PREFERRED_VERSION_linux-xenomai = "4.14.%"
diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
index cba31a5..9faed52 100644
--- a/recipes-kernel/linux/files/amd64_defconfig
+++ b/recipes-kernel/linux/files/amd64_defconfig
@@ -3953,7 +3953,7 @@ CONFIG_TRACING_EVENTS_GPIO=y
 # CONFIG_TEST_KMOD is not set
 # CONFIG_TEST_DEBUG_VIRTUAL is not set
 # CONFIG_MEMTEST is not set
-# CONFIG_BUG_ON_DATA_CORRUPTION is not set
+CONFIG_BUG_ON_DATA_CORRUPTION=y
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 CONFIG_KGDB=y
diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index 9af5659..5137319 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -12,10 +12,14 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.19.y"
-SRCREV_amd64 = "d8ca6738bdff660d033ce755db55e7fe5210379a"
-PV_amd64 = "4.19.60+"
+SRCREV_amd64 = "f83bda3e0785ae2e0ea8ad530bc903d2b420c2c7"
+PV_amd64 = "4.19.66+"
 
-SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1;tag=ipipe-core-4.19.33-arm-2"
-PV_armhf = "4.19.33+"
+SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1;tag=ipipe-core-4.19.55-arm64-2"
+PV_arm64 = "4.19.55+"
+
+
+SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1;tag=ipipe-core-4.19.55-arm-3"
+PV_armhf = "4.19.55+"
 
 S = "${WORKDIR}/git"
-- 
2.20.1


