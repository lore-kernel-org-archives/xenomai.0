Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234E1FB5
	for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 07:11:29 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202302130701198f23e9bbf83fb0de34
        for <xenomai@lists.linux.dev>;
        Mon, 13 Feb 2023 08:01:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=xgOknsZw2MFBUwROsMjgiQNjLPkcPkOe078H+8TQBmw=;
 b=h/x/3muzb2TETxFfcYXH6hAnuyr6EXDw0Uz5O6zHkyRoUO+j/SAimBaAZkR8SdlyJtp18c
 JPuejgRrbF6zgf7uNN8I7L+xPTnBvv4Q8m3+RDMOlIkQK949tQE0uBF5IicC9eYqlobOcF85
 tMNTl8FwawdbGtXFwRUZFRHuWtGME=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 7/7] Update Isar after bitbake 2 switch
Date: Mon, 13 Feb 2023 08:01:16 +0100
Message-Id: <e54837003748946e43f4c4b9f9f48015ff4a88f6.1676271676.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1676271676.git.jan.kiszka@siemens.com>
References: <cover.1676271676.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Not much effort for this layer.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/hikey.conf                      |  2 +-
 conf/machine/qemu-machine.inc                |  2 +-
 kas.yml                                      |  2 +-
 opt-ci.yml                                   |  6 +++---
 recipes-kernel/linux/linux-xenomai.inc       |  2 +-
 recipes-kernel/linux/linux-xenomai_4.19.bb   | 12 ++++++------
 recipes-kernel/linux/linux-xenomai_4.4.bb    | 10 +++++-----
 recipes-kernel/linux/linux-xenomai_5.4.bb    | 12 ++++++------
 recipes-kernel/linux/linux-xenomai_latest.bb | 10 +++++-----
 recipes-xenomai/xenomai/xenomai.inc          |  2 +-
 10 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/conf/machine/hikey.conf b/conf/machine/hikey.conf
index 344a3de..33694ed 100644
--- a/conf/machine/hikey.conf
+++ b/conf/machine/hikey.conf
@@ -14,7 +14,7 @@ DISTRO_ARCH = "arm64"
 IMAGE_FSTYPES ?= "wic"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 
-IMAGE_PREINSTALL_append = " firmware-ti-connectivity"
+IMAGE_PREINSTALL:append = " firmware-ti-connectivity"
 
 # DTB for testing
 DTB_FILES = "hi6220-hikey.dtb"
diff --git a/conf/machine/qemu-machine.inc b/conf/machine/qemu-machine.inc
index 27475eb..c50201a 100644
--- a/conf/machine/qemu-machine.inc
+++ b/conf/machine/qemu-machine.inc
@@ -11,5 +11,5 @@
 
 IMAGE_FSTYPES ?= "ext4"
 
-IMAGE_INSTALL_remove += "expand-on-first-boot"
+IMAGE_INSTALL:remove = "expand-on-first-boot"
 ROOTFS_EXTRA = "1024"
diff --git a/kas.yml b/kas.yml
index 0010deb..6020c62 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: b98f858500ebae8f9c08124e530d9e72bbdfaa23
+    refspec: 4de8b0d5d68ad46829fa1360eabcf3fc8662a39e
     layers:
       meta:
 
diff --git a/opt-ci.yml b/opt-ci.yml
index 2f551b4..32de022 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -20,7 +20,7 @@ header:
 
 local_conf_header:
   xenomai-ci: |
-    ROOTFS_POSTPROCESS_COMMAND_remove = "image_postprocess_sshd_key_regen"
-    IMAGE_INSTALL_remove += "sshd-regen-keys"
-    IMAGE_INSTALL_remove += "expand-on-first-boot"
+    ROOTFS_POSTPROCESS_COMMAND:remove = "image_postprocess_sshd_key_regen"
+    IMAGE_INSTALL:remove += "sshd-regen-keys"
+    IMAGE_INSTALL:remove += "expand-on-first-boot"
     IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 7d69519..ca63fea 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -36,7 +36,7 @@ def get_commit(d):
 
 LINUX_COMMIT ?= "${@get_commit(d)}"
 
-dpkg_runbuild_prepend() {
+dpkg_runbuild:prepend() {
     bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
                      ${PV} ${LINUX_COMMIT})
 }
diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index 8194ea5..249ffb4 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -11,13 +11,13 @@
 
 require recipes-kernel/linux/linux-xenomai.inc
 
-SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-4.19.266-cip86-x86-25"
+SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
+SRCREV:amd64 ?= "ipipe-core-4.19.266-cip86-x86-25"
 
-SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
-SRCREV_arm64 ?= "ipipe-core-4.19.229-cip67-arm64-13"
+SRC_URI:append:arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
+SRCREV:arm64 ?= "ipipe-core-4.19.229-cip67-arm64-13"
 
-SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV_armhf ?= "ipipe-core-4.19.229-cip67-arm-18"
+SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
+SRCREV:armhf ?= "ipipe-core-4.19.229-cip67-arm-18"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai_4.4.bb
index bf00fdc..2b32ae3 100644
--- a/recipes-kernel/linux/linux-xenomai_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.4.bb
@@ -11,11 +11,11 @@
 
 require recipes-kernel/linux/linux-xenomai.inc
 
-SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-4.4.302-cip71-x86-35"
+SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
+SRCREV:amd64 ?= "ipipe-core-4.4.302-cip71-x86-35"
 
-SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
-SRC_URI_append_armhf = " ${@ 'file://bbb_4.4.cfg' if d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
-SRCREV_armhf ?= "ipipe-core-4.4.302-cip71-arm-20"
+SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
+SRC_URI:append:armhf = " ${@ 'file://bbb_4.4.cfg' if d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
+SRCREV:armhf ?= "ipipe-core-4.4.302-cip71-arm-20"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai_5.4.bb b/recipes-kernel/linux/linux-xenomai_5.4.bb
index 104955f..7796cd3 100644
--- a/recipes-kernel/linux/linux-xenomai_5.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.4.bb
@@ -11,13 +11,13 @@
 
 require recipes-kernel/linux/linux-xenomai.inc
 
-SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-5.4.228-x86-12"
+SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
+SRCREV:amd64 ?= "ipipe-core-5.4.228-x86-12"
 
-SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
-SRCREV_arm64 ?= "ipipe-core-5.4.180-arm64-5"
+SRC_URI:append:arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
+SRCREV:arm64 ?= "ipipe-core-5.4.180-arm64-5"
 
-SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV_armhf ?= "ipipe-core-5.4.180-arm-5"
+SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
+SRCREV:armhf ?= "ipipe-core-5.4.180-arm-5"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 682e973..7d002f1 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -47,11 +47,11 @@ GIT_BRANCH = "${@ \
     else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
-GIT_REPO_armhf = "${@ \
+GIT_REPO:armhf = "${@ \
     'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) \
     else 'git://github.com/xenomai-ci/ipipe-arm.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
     else 'git://source.denx.de/xenomai/linux-dovetail.git' }"
-GIT_BRANCH_armhf = "${@ \
+GIT_BRANCH:armhf = "${@ \
     'ipipe-4.4.y-cip' if is_xeno_3_0(d) \
     else 'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
@@ -60,10 +60,10 @@ GIT_BRANCH_armhf = "${@ \
     else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
-GIT_REPO_arm64 = "${@ \
+GIT_REPO:arm64 = "${@ \
     'git://github.com/xenomai-ci/ipipe-arm64.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
     else 'git://source.denx.de/xenomai/linux-dovetail.git' }"
-GIT_BRANCH_arm64 = "${@ \
+GIT_BRANCH:arm64 = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
@@ -74,4 +74,4 @@ GIT_BRANCH_arm64 = "${@ \
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
 
-SRC_URI_append_armhf = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) and d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
+SRC_URI:append:armhf = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) and d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index 226eba8..bad4ff4 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -13,7 +13,7 @@ inherit dpkg
 
 PROVIDES += "xenomai-kernel-source xenomai-runtime xenomai-runtime-dbgsym libxenomai1 libxenomai-dev libxenomai1-dbgsym"
 
-PACKAGE_ARCH_compat-arch = "${COMPAT_DISTRO_ARCH}"
+PACKAGE_ARCH:compat-arch = "${COMPAT_DISTRO_ARCH}"
 
 # use bitbake get_srcrev to get the current commit id
 def get_commit(d):
-- 
2.35.3

