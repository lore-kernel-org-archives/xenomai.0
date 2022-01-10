From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 3/3] Update Isar revision, enabling ccache
Date: Mon, 10 Jan 2022 18:32:19 +0100
Message-ID: <91923eda0592dadafeeebaca36be949179608f34.1641835939.git.jan.kiszka@siemens.com>
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

Just requires to switch from IMAGE_TYPE to IMAGE_FSTYPES.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/beagle-bone-black.conf | 2 +-
 conf/machine/hikey.conf             | 2 +-
 conf/machine/qemu-machine.inc       | 2 +-
 conf/machine/x86-64-efi.conf        | 2 +-
 kas.yml                             | 4 +++-
 opt-ci.yml                          | 4 ++--
 6 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/conf/machine/beagle-bone-black.conf b/conf/machine/beagle-bone-black.conf
index af6e8f5..c0f85c5 100644
--- a/conf/machine/beagle-bone-black.conf
+++ b/conf/machine/beagle-bone-black.conf
@@ -13,7 +13,7 @@ DISTRO_ARCH = "armhf"
 
 IMAGE_INSTALL += "u-boot-script"
 
-IMAGE_TYPE ?= "wic-img"
+IMAGE_FSTYPES ?= "wic-img"
 DTB_FILES = "am335x-boneblack.dtb"
 IMAGER_INSTALL += "u-boot-omap"
 IMAGE_PREINSTALL += "fake-hwclock"
diff --git a/conf/machine/hikey.conf b/conf/machine/hikey.conf
index dc7bc57..6ad4611 100644
--- a/conf/machine/hikey.conf
+++ b/conf/machine/hikey.conf
@@ -11,7 +11,7 @@
 
 DISTRO_ARCH = "arm64"
 
-IMAGE_TYPE ?= "wic-img"
+IMAGE_FSTYPES ?= "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 
 IMAGE_PREINSTALL_append = " firmware-ti-connectivity"
diff --git a/conf/machine/qemu-machine.inc b/conf/machine/qemu-machine.inc
index 146fb4f..7771a11 100644
--- a/conf/machine/qemu-machine.inc
+++ b/conf/machine/qemu-machine.inc
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-IMAGE_TYPE = "ext4-img"
+IMAGE_FSTYPES = "ext4-img"
 
 IMAGE_INSTALL_remove += "expand-on-first-boot"
 ROOTFS_EXTRA = "1024"
diff --git a/conf/machine/x86-64-efi.conf b/conf/machine/x86-64-efi.conf
index 02846ff..cb3ed85 100644
--- a/conf/machine/x86-64-efi.conf
+++ b/conf/machine/x86-64-efi.conf
@@ -11,5 +11,5 @@
 
 DISTRO_ARCH = "amd64"
 
-IMAGE_TYPE ?= "wic-img"
+IMAGE_FSTYPES ?= "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
diff --git a/kas.yml b/kas.yml
index 93e9b82..62ddbb4 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 90e1fa6a80f7240109507f2f7e7ca59f50bbb2d4
+    refspec: eeefa03185e3f259d08ff94295b0981a19eddf55
     layers:
       meta:
 
@@ -37,3 +37,5 @@ local_conf_header:
     CONF_VERSION = "1"
   cross: |
     ISAR_CROSS_COMPILE = "1"
+  ccache: |
+    USE_CCACHE = "1"
diff --git a/opt-ci.yml b/opt-ci.yml
index f161ab9..2feec5c 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2022
 #
 # Authors:
 #  Florian Bezdeka <florian.bezdeka@siemens.com>
@@ -30,5 +30,5 @@ local_conf_header:
     ROOTFS_POSTPROCESS_COMMAND_remove = "image_postprocess_sshd_key_regen"
     IMAGE_INSTALL_remove += "sshd-regen-keys"
     IMAGE_INSTALL_remove += "expand-on-first-boot"
-    IMAGE_TYPE = "${@ 'ext4-img' if d.getVar('MACHINE', True).startswith('qemu') else 'targz-img' }"
+    IMAGE_FSTYPES = "${@ 'ext4-img' if d.getVar('MACHINE', True).startswith('qemu') else 'targz-img' }"
     COMPRESS = "${@ 'gz' if d.getVar('MACHINE', True).startswith('qemu') else '' }"
-- 
2.31.1


