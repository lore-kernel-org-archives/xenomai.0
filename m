Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404D8494
	for <xenomai@lists.linux.dev>; Thu,  5 Jan 2023 13:27:47 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230105132739ae7d7edc9760701a6e
        for <xenomai@lists.linux.dev>;
        Thu, 05 Jan 2023 14:27:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=R6GSU846HQF2PI4xosaJNJeeSyJGEB2mh6FzRndKZvk=;
 b=i6fbnra1iiQiJEu8b5GqHcvMm/4qKKEOz40GAJJKeS9c6TzUCCBBByHtwn7A9cxc5Znfi4
 xEfuff/17ojcBboqW18upkUMGBvP/mhF6vYOJUgTqWlbOVR+RunsQRL8qII7e3DqztCWODwX
 jsfuEs/Xt8ZCawb1OvquOOY8uyNdM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC PATCH] Update Isar to latest next version - sbuild integration
Date: Thu,  5 Jan 2023 14:27:33 +0100
Message-Id: <20230105132733.3056171-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Updating to latest Isar will allow us to use Debian bookworm as base
distribution. Bookworm ships a recent glibc which will help to enable
y2038 testing in the CI environment.

This is the first version of Isar with sbuild enabled, so we can't use
the tricks around ${BUILDCHROOT_DIR} anymore.

xenomai: The scripts/bootstrap call is already part of the upstream
debian/rules file, so we do not have to call it again.

linux-xenomai: Moving the prepare-kernel and patch-kernel step into
debian/rules requires patching the debian/rules file deployed by the
Isar linux-custom.inc helper.

The added Isar patches can be removed on next Isar update. The problem
was that the rootfs is no longer added to /etc/fstab. As a result the
rootfs was mounted read-only failing LAVA tests. As the oe -> isar ->
xenomai-images transition will need some time the patches are added here
as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Some notes:
  - One step closer to y2038-safe builds
  - The upstraming process for necessary Isar patches started already
    Might take some time until patches hit Isar next
  - Internal CI did not report any issues
  - Comments (especially on the sbuild stuff) are welcome

 kas.yml                                       | 11 +++-
 ...age-remove-entry-from-fstab-template.patch | 28 ++++++++++
 ...2-wic-replace-existing-fstab-entries.patch | 52 +++++++++++++++++++
 recipes-kernel/linux/files/debian_rules.gdiff | 14 +++++
 recipes-kernel/linux/linux-xenomai.inc        | 35 +++++--------
 recipes-xenomai/xenomai/xenomai.inc           |  7 ---
 6 files changed, 116 insertions(+), 31 deletions(-)
 create mode 100644 patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
 create mode 100644 patches/isar/0002-wic-replace-existing-fstab-entries.patch
 create mode 100644 recipes-kernel/linux/files/debian_rules.gdiff

diff --git a/kas.yml b/kas.yml
index f8790e5..b6e5133 100644
--- a/kas.yml
+++ b/kas.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2020
+# Copyright (c) Siemens AG, 2018-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -22,7 +22,14 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 213b8f62fa74e87321f927fb6b4ed9db93e5cb37
+    refspec: 8530a94bdc8919fadccad13e6061832d2f2c1fcc
+    patches:
+      "0001":
+        repo: xenomai
+        path: patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
+      "0002":
+        repo: xenomai
+        path: patches/isar/0002-wic-replace-existing-fstab-entries.patch
     layers:
       meta:
 
diff --git a/patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch b/patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
new file mode 100644
index 0000000..4354d32
--- /dev/null
+++ b/patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
@@ -0,0 +1,28 @@
+From 5c9df8b8ac0691c2c4b11deaf763999bb7a136e6 Mon Sep 17 00:00:00 2001
+From: Felix Moessbauer <felix.moessbauer@siemens.com>
+Date: Thu, 5 Jan 2023 08:45:02 +0000
+Subject: [PATCH 1/2] Revert "image: remove / entry from fstab template"
+
+This reverts commit fc4f004eb67237d9d09b1ffad0de1a19217fa94a.
+
+Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
+Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
+---
+ meta/classes/image.bbclass | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
+index d8d605d..ccff810 100644
+--- a/meta/classes/image.bbclass
++++ b/meta/classes/image.bbclass
+@@ -327,6 +327,7 @@ image_configure_fstab[weight] = "2"
+ image_configure_fstab() {
+     sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
+ # Begin /etc/fstab
++/dev/root	/		auto		defaults		0	0
+ proc		/proc		proc		nosuid,noexec,nodev	0	0
+ sysfs		/sys		sysfs		nosuid,noexec,nodev	0	0
+ devpts		/dev/pts	devpts		gid=5,mode=620		0	0
+-- 
+2.39.0
+
diff --git a/patches/isar/0002-wic-replace-existing-fstab-entries.patch b/patches/isar/0002-wic-replace-existing-fstab-entries.patch
new file mode 100644
index 0000000..63e852b
--- /dev/null
+++ b/patches/isar/0002-wic-replace-existing-fstab-entries.patch
@@ -0,0 +1,52 @@
+From d162b4cfe3c8cce723372519bedb9d861e305135 Mon Sep 17 00:00:00 2001
+From: Felix Moessbauer <felix.moessbauer@siemens.com>
+Date: Thu, 5 Jan 2023 08:45:03 +0000
+Subject: [PATCH 2/2] wic: replace existing fstab entries
+
+This patch extend the imager direct class to check if the mountpoint of
+an to-be-added entry in the fstab is already there. If it is, the old
+entry is removed and the new entry is appended.
+
+This solves issues with duplicated entries which coming from the rootfs
+itself. One example where this happens is when generating images for
+both direct kernel boot and EFI. In this case, the rootfs mountpoint
+needs to be in the fstab of the rootfs and needs to be replaced in WIC.
+
+Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
+Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
+---
+ scripts/lib/wic/plugins/imager/direct.py | 11 ++++++++++-
+ 1 file changed, 10 insertions(+), 1 deletion(-)
+
+diff --git a/scripts/lib/wic/plugins/imager/direct.py b/scripts/lib/wic/plugins/imager/direct.py
+index c44159b..7f8733a 100644
+--- a/scripts/lib/wic/plugins/imager/direct.py
++++ b/scripts/lib/wic/plugins/imager/direct.py
+@@ -104,6 +104,14 @@ class DirectPlugin(ImagerPlugin):
+ 
+     def update_fstab(self, image_rootfs):
+         """Assume partition order same as in wks"""
++
++        # return the mountpoint from an fstab entry
++        def _get_mountpoint(line):
++            parts = line.split()
++            if line.startswith('#') or len(parts) != 6:
++                return None
++            return parts[1]
++
+         if not image_rootfs:
+             return
+ 
+@@ -141,7 +149,8 @@ class DirectPlugin(ImagerPlugin):
+             passno = part.fspassno if part.fspassno else "0"
+             line = "\t".join([device_name, part.mountpoint, part.fstype,
+                               opts, "0", passno]) + "\n"
+-
++            # if this mountpoint is already in the fstab, replace it
++            fstab_lines = [item for item in fstab_lines if _get_mountpoint(item) != part.mountpoint]
+             fstab_lines.append(line)
+             updated = True
+ 
+-- 
+2.39.0
+
diff --git a/recipes-kernel/linux/files/debian_rules.gdiff b/recipes-kernel/linux/files/debian_rules.gdiff
new file mode 100644
index 0000000..477e581
--- /dev/null
+++ b/recipes-kernel/linux/files/debian_rules.gdiff
@@ -0,0 +1,14 @@
+diff --git a/meta/recipes-kernel/linux/files/debian/rules.tmpl b/meta/recipes-kernel/linux/files/debian/rules.tmpl
+index 8063c49..5ce2c5f 100755
+--- a/meta/recipes-kernel/linux/files/debian/rules.tmpl
++++ b/meta/recipes-kernel/linux/files/debian/rules.tmpl
+@@ -24,6 +24,9 @@ override_dh_auto_clean:
+ 	$(isar_env) && bash $(deb_top_dir)/isar/clean
+ 
+ override_dh_auto_configure:
++	/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
++		--linux=$(S) \
++		--arch=${KERNEL_ARCH}
+ 	$(isar_env) && bash $(deb_top_dir)/isar/configure
+ 
+ override_dh_auto_build:
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 7dba96e..eed372d 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -19,6 +19,7 @@ XENOMAI_DEBUG ?= "0"
 
 SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
 SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
+SRC_URI += "file://debian_rules.gdiff"
 
 DEPENDS += "xenomai-kernel-source"
 KBUILD_DEPENDS += "xenomai-kernel-source:native"
@@ -32,26 +33,16 @@ def get_commit(d):
 LINUX_COMMIT ?= "${@get_commit(d)}"
 
 dpkg_runbuild_prepend() {
-	case ${DISTRO_ARCH} in
-	armhf)
-		ARCH=arm
-		;;
-	arm64)
-		ARCH=arm64
-		;;
-	amd64|i386)
-		ARCH=x86
-		;;
-	*)
-		bberror "Unsupported architecture ${DISTRO_ARCH}"
-		exit 1
-	esac
-	bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
-			 ${PV} ${LINUX_COMMIT})
-
-	${BUILDCHROOT_DIR}/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
-		--linux=${BUILDCHROOT_DIR}/${PP}/${PPS} --arch=$ARCH \
-		--outpatch=${WORKDIR}/xenomai-kernel.patch
-	patch -d ${BUILDCHROOT_DIR}/${PP}/${PPS} \
-		-p1 -i ${WORKDIR}/xenomai-kernel.patch
+    bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
+                     ${PV} ${LINUX_COMMIT})
 }
+
+do_patch_debian_rules() {
+    # debian/rules is a template deployed by the the linux-custom helper in
+    # Isar. The template needs some patching before it is processed by the
+    # templating engine. We have to feed in the xenomai specific
+    # "prepare-kernel" and "patch kernel" steps.
+    # Note: We can't use the .patch or .diff file ending here (bitbake magic)
+    patch -d ${WORKDIR} -p5 -i ${WORKDIR}/debian_rules.gdiff
+}
+addtask patch_debian_rules after do_unpack before do_transform_template
\ No newline at end of file
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index b874a4a..4994533 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -34,10 +34,3 @@ do_prepare_build() {
     rm -f ${S}/debian/source/format
 }
 
-dpkg_runbuild_prepend() {
-    bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
-                     ${PV} ${COMMIT})
-
-    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
-        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
-}
-- 
2.39.0

