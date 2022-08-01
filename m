Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD97F
	for <xenomai@lists.linux.dev>; Mon,  1 Aug 2022 13:47:48 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 30A9E1C0005
	for <xenomai@lists.linux.dev>; Mon,  1 Aug 2022 13:47:40 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id CBE9994199C
	for <xenomai@xenomai.org>; Mon,  1 Aug 2022 13:47:39 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20220801134739d881d332779ec514d6
        for <xenomai@xenomai.org>;
        Mon, 01 Aug 2022 15:47:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=tVCUx/LY4P6hbr8MDPe/1wTG5SGRb7XOr+rPmr2329s=;
 b=KzNUnTIa78PAxCJc7RpjY2st1Hf53qWcJZ1xPEA0C9vzBgJss20HNsyOJCFlc5P5x2Ye1X
 qbvQ+1vmPRfWuwdY+SttEcHIcym8sBwl69SAai86+iLA71P4l/kuLIr5zpJyg+IxWuEPCeC3
 P7ljMq8JnkuIYbQ2D58DQFbetDOcg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [xenomai-images][PATCH 1/4] Update to Isar 0.9
Date: Mon,  1 Aug 2022 15:47:34 +0200
Message-Id: <d73c0483931887805c469c6de585cb32b75adff7.1659361657.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1659361657.git.jan.kiszka@siemens.com>
References: <cover.1659361657.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool1: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-20220801134739d881d332779ec514d6-iK6DNm@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=KzNUnTIa;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20220801134739d881d332779ec514d6-iK6DNm@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-20220801134739d881d332779ec514d6-iK6DNm@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings changes to image types that are almost easy to account for
and permit to drop our downstream patch. Also the image file name changed,
so adjust test jobs, readme and start-qemu.sh.

There was one catch: qemu-machine.inc did not weak-assign IMAGE_FSTYPES,
which is now important as opt-ci.yml must be able to overwrite it.

The Isar update itself fixes logging issues, thus helps a lot with
analyzing failing builds, specifically in CI.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md                                     |  2 +-
 conf/machine/beagle-bone-black.conf           |  2 +-
 conf/machine/hikey.conf                       |  2 +-
 conf/machine/qemu-machine.inc                 |  2 +-
 conf/machine/x86-64-efi.conf                  |  2 +-
 .../0001-classes-ext4.img-Compress.patch      | 31 -------------------
 kas.yml                                       |  2 +-
 opt-ci.yml                                    | 12 ++-----
 start-qemu.sh                                 |  2 +-
 tests/jobs/xenomai-qemu-amd64.yml             |  2 +-
 tests/jobs/xenomai-qemu-arm64.yml             |  2 +-
 tests/jobs/xenomai-qemu-armhf.yml             |  2 +-
 12 files changed, 12 insertions(+), 51 deletions(-)
 delete mode 100644 isar-patches/0001-classes-ext4.img-Compress.patch

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
diff --git a/conf/machine/beagle-bone-black.conf b/conf/machine/beagle-bone-black.conf
index c0f85c5..d454326 100644
--- a/conf/machine/beagle-bone-black.conf
+++ b/conf/machine/beagle-bone-black.conf
@@ -13,7 +13,7 @@ DISTRO_ARCH = "armhf"
 
 IMAGE_INSTALL += "u-boot-script"
 
-IMAGE_FSTYPES ?= "wic-img"
+IMAGE_FSTYPES ?= "wic"
 DTB_FILES = "am335x-boneblack.dtb"
 IMAGER_INSTALL += "u-boot-omap"
 IMAGE_PREINSTALL += "fake-hwclock"
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
index 7771a11..27475eb 100644
--- a/conf/machine/qemu-machine.inc
+++ b/conf/machine/qemu-machine.inc
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-IMAGE_FSTYPES = "ext4-img"
+IMAGE_FSTYPES ?= "ext4"
 
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
diff --git a/isar-patches/0001-classes-ext4.img-Compress.patch b/isar-patches/0001-classes-ext4.img-Compress.patch
deleted file mode 100644
index 6b67295..0000000
--- a/isar-patches/0001-classes-ext4.img-Compress.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From 915eec01cf660b160b1eab551c60fba4aac13b4b Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Fri, 17 Apr 2020 11:32:39 +0200
-Subject: [PATCH] classes/ext4.img: Compress
-
-change owner and add compress option
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- meta/classes/ext4-img.bbclass | 5 +++++
- 1 file changed, 5 insertions(+)
-
-diff --git a/meta/classes/ext4-img.bbclass b/meta/classes/ext4-img.bbclass
-index 334dc64..dc091d9 100644
---- a/meta/classes/ext4-img.bbclass
-+++ b/meta/classes/ext4-img.bbclass
-@@ -17,6 +17,11 @@ do_ext4_image() {
- 
-     sudo chroot ${BUILDCHROOT_DIR} /sbin/mke2fs ${MKE2FS_ARGS} \
-                 -F -d '${PP_ROOTFS}' '${PP_DEPLOY}/${EXT4_IMAGE_FILE}'
-+    sudo chown $(id -u):$(id -g) ${DEPLOY_DIR_IMAGE}/${EXT4_IMAGE_FILE}
-+
-+    if [ "${COMPRESS}" = "gz" ]; then
-+        gzip ${DEPLOY_DIR_IMAGE}/${EXT4_IMAGE_FILE}
-+    fi
- }
- 
- addtask ext4_image before do_image after do_image_tools
--- 
-2.20.1
-
diff --git a/kas.yml b/kas.yml
index 6b3b32d..2553c23 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: a960a4e52c50ef4a15e382768eeee5fa9cfffead
+    refspec: 213b8f62fa74e87321f927fb6b4ed9db93e5cb37
     layers:
       meta:
 
diff --git a/opt-ci.yml b/opt-ci.yml
index 2feec5c..2f551b4 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -14,21 +14,13 @@ header:
   includes:
     - opt-debug.yml
 
-repos:
-  isar:
-    patches:
-      01-compress-ext4:
-        path: isar-patches/0001-classes-ext4.img-Compress.patch
-        repo: xenomai
-
 # LAVA uses nfs to deploy the image to real boards. For this we need a tarball
 # instead of full disk/wic image
-# For qemu we need a compressed ext4-img
+# For qemu we need a compressed ext4 image
 
 local_conf_header:
   xenomai-ci: |
     ROOTFS_POSTPROCESS_COMMAND_remove = "image_postprocess_sshd_key_regen"
     IMAGE_INSTALL_remove += "sshd-regen-keys"
     IMAGE_INSTALL_remove += "expand-on-first-boot"
-    IMAGE_FSTYPES = "${@ 'ext4-img' if d.getVar('MACHINE', True).startswith('qemu') else 'targz-img' }"
-    COMPRESS = "${@ 'gz' if d.getVar('MACHINE', True).startswith('qemu') else '' }"
+    IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
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
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 921c70b..166d472 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -53,7 +53,7 @@ actions:
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.img.gz
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.gz
         compression: gz
 # BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 4907ca4..a1dcc1c 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -57,7 +57,7 @@ actions:
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.img.gz
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.gz
         compression: gz
 # BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 9507a4f..3b5bc10 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -53,7 +53,7 @@ actions:
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.img.gz
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.gz
         compression: gz
 # BOOT_BLOCK
 - boot:
-- 
2.35.3

