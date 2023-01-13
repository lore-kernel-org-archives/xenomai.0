Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D54BA41
	for <xenomai@lists.linux.dev>; Fri, 13 Jan 2023 21:26:53 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230113211642b24c78b73f0026a227
        for <xenomai@lists.linux.dev>;
        Fri, 13 Jan 2023 22:16:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Enap/SeyLWUm85yODFMuWz7stzEDqxs3tI8SP5lr1LA=;
 b=VvuSse37bFuq4yK9DZX55Nty/aPZqaeh2vZXfw2wgzWOazLzePktKU4qMkdlU93yB+avjR
 gSHaA+sgpW68lry9swdbJt/X4EDVgNCUarLok173Gd0LFQoPfe4NCWcSexAbV+j3HX5C6To1
 +MEYtbP3MPj8QP/LAWO6IQX4U4dNo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][RFC PATCH v2] Update Isar to latest next version - sbuild integration
Date: Fri, 13 Jan 2023 22:16:40 +0100
Message-Id: <20230113211640.662759-1-florian.bezdeka@siemens.com>
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

linux-xenomai: Moving the rules file provided by linux-custom.inc to
rules.isar allows us to ship our own rules file and override the
necessary steps.

Adding "rw" to the kernel cmdline for qemu based LAVA tests is a
workaround for a current Isar regression. The rootfs entry is currently
removed from /etc/fstab so the rootfs stayed in read-only mode. Upstream
discussion is already ongoing.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kas.yml                                |  4 +--
 recipes-kernel/linux/files/rules.tmpl  | 11 ++++++++
 recipes-kernel/linux/linux-xenomai.inc | 35 +++++++++-----------------
 recipes-xenomai/xenomai/xenomai.inc    |  8 ++----
 tests/jobs/xenomai-qemu-amd64.yml      |  4 +--
 tests/jobs/xenomai-qemu-arm64.yml      |  4 +--
 tests/jobs/xenomai-qemu-armhf.yml      |  4 +--
 7 files changed, 33 insertions(+), 37 deletions(-)
 create mode 100755 recipes-kernel/linux/files/rules.tmpl

diff --git a/kas.yml b/kas.yml
index f8790e5..5f41f18 100644
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
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 213b8f62fa74e87321f927fb6b4ed9db93e5cb37
+    refspec: 8530a94bdc8919fadccad13e6061832d2f2c1fcc
     layers:
       meta:
 
diff --git a/recipes-kernel/linux/files/rules.tmpl b/recipes-kernel/linux/files/rules.tmpl
new file mode 100755
index 0000000..5f1b325
--- /dev/null
+++ b/recipes-kernel/linux/files/rules.tmpl
@@ -0,0 +1,11 @@
+#!/usr/bin/make -f
+
+include debian/rules.isar
+
+prepare_kernel:
+	/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
+		--linux=$(S) \
+		--arch=${KERNEL_ARCH}
+
+override_dh_auto_configure: prepare_kernel
+
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 7dba96e..bed58cc 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2021
+# Copyright (c) Siemens AG, 2018-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -19,10 +19,13 @@ XENOMAI_DEBUG ?= "0"
 
 SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
 SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
+SRC_URI += "file://rules.tmpl"
 
 DEPENDS += "xenomai-kernel-source"
 KBUILD_DEPENDS += "xenomai-kernel-source:native"
 
+TEMPLATE_FILES += "rules.tmpl"
+
 def get_commit(d):
     try:
         return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
@@ -32,26 +35,12 @@ def get_commit(d):
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
+}
+
+do_prepare_debian_rules() {
+    mv ${WORKDIR}/debian/rules ${WORKDIR}/debian/rules.isar
+    mv ${WORKDIR}/rules ${WORKDIR}/debian/rules
 }
+addtask prepare_debian_rules after do_transform_template before do_dpkg_build
\ No newline at end of file
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index b874a4a..8ebba7c 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018
+# Copyright (c) Siemens AG, 2018-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -32,12 +32,8 @@ do_prepare_build() {
     # Remove upstream's "3.0 (native)" declaration so that we can define the
     # package version more freely.
     rm -f ${S}/debian/source/format
-}
 
-dpkg_runbuild_prepend() {
     bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
                      ${PV} ${COMMIT})
-
-    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
-        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
 }
+
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 166d472..b989576 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -46,7 +46,7 @@ actions:
     to: tmpfs
     images:
       kernel:
-        image_arg: -kernel {kernel} -append "root=/dev/disk/by-path/pci-0000:00:1f.2-ata-6 console=ttyS0,115200 console=tty0"
+        image_arg: -kernel {kernel} -append "root=/dev/disk/by-path/pci-0000:00:1f.2-ata-6 console=ttyS0,115200 console=tty0 rw"
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index a1dcc1c..5bf513e 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -50,7 +50,7 @@ actions:
     to: tmpfs
     images:
       kernel:
-        image_arg: -kernel {kernel} -append "root=/dev/vda"
+        image_arg: -kernel {kernel} -append "root=/dev/vda rw"
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
       initrd:
         image_arg: -initrd {initrd}
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 3b5bc10..1ab35bd 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -46,7 +46,7 @@ actions:
     to: tmpfs
     images:
       kernel:
-        image_arg: -kernel {kernel} -append "root=/dev/vdb"
+        image_arg: -kernel {kernel} -append "root=/dev/vdb rw"
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
-- 
2.39.0

