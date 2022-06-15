Message-ID: <bcc20aef-69c6-6d26-4437-f672e5ce317d@siemens.com>
Date: Wed, 15 Jun 2022 18:00:29 +0200
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] Update Isar revision
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings changes to image types that are easy to account for. Also
the image file name changed, so adjust readme and start-qemu.sh.

The update fixes logging issues, thus helps a lot with analyzing failing
builds, specifically in CI.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md                                       | 2 +-
 conf/machine/hikey.conf                         | 2 +-
 conf/machine/qemu-machine.inc                   | 2 +-
 conf/machine/x86-64-efi.conf                    | 2 +-
 kas.yml                                         | 2 +-
 recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb | 2 ++
 start-qemu.sh                                   | 2 +-
 7 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/README.md b/README.md
index b38e131..5f6c4c7 100644
--- a/README.md
+++ b/README.md
@@ -41,7 +41,7 @@ armhf(`board-beagle-bone-black.yml`) and arm64(`board-hikey.yml`) targets.
 Each physical target will generate ready-to-boot images under
 `build/tmp/deploy/images/`. To flash, e.g., the HiKey image to an SD card, run
 
-    dd if=build/tmp/deploy/images/hikey/demo-image-hikey-xenomai-demo-hikey.wic.img \
+    dd if=build/tmp/deploy/images/hikey/demo-image-hikey-xenomai-demo-hikey.wic \
        of=/dev/<medium-device> bs=1M status=progress
 
 ## CI Build
diff --git a/conf/machine/hikey.conf b/conf/machine/hikey.conf
index 6ad4611..344a3de 100644
--- a/conf/machine/hikey.conf
+++ b/conf/machine/hikey.conf
@@ -11,7 +11,7 @@
 
 DISTRO_ARCH = "arm64"
 
-IMAGE_FSTYPES ?= "wic-img"
+IMAGE_FSTYPES ?= "wic"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 
 IMAGE_PREINSTALL_append = " firmware-ti-connectivity"
diff --git a/conf/machine/qemu-machine.inc b/conf/machine/qemu-machine.inc
index 7771a11..d9ee2dd 100644
--- a/conf/machine/qemu-machine.inc
+++ b/conf/machine/qemu-machine.inc
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-IMAGE_FSTYPES = "ext4-img"
+IMAGE_FSTYPES = "ext4"
 
 IMAGE_INSTALL_remove += "expand-on-first-boot"
 ROOTFS_EXTRA = "1024"
diff --git a/conf/machine/x86-64-efi.conf b/conf/machine/x86-64-efi.conf
index cb3ed85..036bdcd 100644
--- a/conf/machine/x86-64-efi.conf
+++ b/conf/machine/x86-64-efi.conf
@@ -11,5 +11,5 @@
 
 DISTRO_ARCH = "amd64"
 
-IMAGE_FSTYPES ?= "wic-img"
+IMAGE_FSTYPES ?= "wic"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
diff --git a/kas.yml b/kas.yml
index 6b3b32d..7a06aca 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: a960a4e52c50ef4a15e382768eeee5fa9cfffead
+    refspec: 660d23fe898297524628a058d6121d9e425694f9
     layers:
       meta:
 
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
index 6231e9e..00e4058 100644
--- a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
@@ -20,3 +20,5 @@ SRC_URI = " \
 SRCREV = "${AUTOREV}"
 
 S = "${WORKDIR}/git"
+
+SRC_URI += "file://stable.patch"
diff --git a/start-qemu.sh b/start-qemu.sh
index 68516cc..33b6e65 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -83,7 +83,7 @@ fi
 shift 1
 
 ${QEMU_PATH}${QEMU} \
-	-drive file=${IMAGE_PREFIX}.ext4.img,discard=unmap,if=none,id=disk,format=raw \
+	-drive file=${IMAGE_PREFIX}.ext4,discard=unmap,if=none,id=disk,format=raw \
 	-m 1G -serial mon:stdio -netdev user,id=net \
 	-kernel ${IMAGE_PREFIX}-${KERNEL_SUFFIX} -append "${KERNEL_CMDLINE}" \
 	-initrd ${IMAGE_PREFIX}-initrd.img ${QEMU_EXTRA_ARGS} "$@"
-- 
2.35.3

