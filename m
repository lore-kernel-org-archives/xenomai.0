From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][ PATCH v2 2/4] ci: Add option to compress
 ext4-images.
Date: Mon, 24 Aug 2020 13:25:25 +0200
Message-Id: <20200824112527.4616-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200824112527.4616-1-Quirin.Gylstorff@siemens.com>
References: <20200824112527.4616-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, Jan.Kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The qemu test targets create uncompressed ext4-img around 1GB. This
increases the time to uplaod and test a image with qemu. Reduce the
time by adding a compress option to ext4-img.bbclass.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/gitlab-ci-base.yml                         |  3 ++
 .../0001-classes-ext4.img-Compress.patch      | 31 +++++++++++++++++++
 opt-ext4-gz.yml                               | 24 ++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 isar-patches/0001-classes-ext4.img-Compress.patch
 create mode 100644 opt-ext4-gz.yml

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index e8d259f..6978ae9 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -53,6 +53,7 @@ build:board-qemu-amd64:
   extends: .build
   variables:
     TARGET: qemu-amd64
+    BUILD_OPTIONS: ":opt-ext4-gz.yml"
 
 lava-test:qemu-amd64:
   needs: [ "build:board-qemu-amd64" ]
@@ -65,6 +66,7 @@ build:board-qemu-armhf:
   extends: .build
   variables:
     TARGET: qemu-armhf
+    BUILD_OPTIONS: ":opt-ext4-gz.yml"
 
 lava-test:qemu-armhf:
   needs: [ "build:board-qemu-armhf" ]
@@ -76,6 +78,7 @@ build:board-qemu-arm64:
   extends: .build
   variables:
     TARGET: qemu-arm64
+    BUILD_OPTIONS: ":opt-ext4-gz.yml"
 
 lava-test:qemu-arm64:
   needs: [ "build:board-qemu-arm64" ]
diff --git a/isar-patches/0001-classes-ext4.img-Compress.patch b/isar-patches/0001-classes-ext4.img-Compress.patch
new file mode 100644
index 0000000..6b67295
--- /dev/null
+++ b/isar-patches/0001-classes-ext4.img-Compress.patch
@@ -0,0 +1,31 @@
+From 915eec01cf660b160b1eab551c60fba4aac13b4b Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Fri, 17 Apr 2020 11:32:39 +0200
+Subject: [PATCH] classes/ext4.img: Compress
+
+change owner and add compress option
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ meta/classes/ext4-img.bbclass | 5 +++++
+ 1 file changed, 5 insertions(+)
+
+diff --git a/meta/classes/ext4-img.bbclass b/meta/classes/ext4-img.bbclass
+index 334dc64..dc091d9 100644
+--- a/meta/classes/ext4-img.bbclass
++++ b/meta/classes/ext4-img.bbclass
+@@ -17,6 +17,11 @@ do_ext4_image() {
+ 
+     sudo chroot ${BUILDCHROOT_DIR} /sbin/mke2fs ${MKE2FS_ARGS} \
+                 -F -d '${PP_ROOTFS}' '${PP_DEPLOY}/${EXT4_IMAGE_FILE}'
++    sudo chown $(id -u):$(id -g) ${DEPLOY_DIR_IMAGE}/${EXT4_IMAGE_FILE}
++
++    if [ "${COMPRESS}" = "gz" ]; then
++        gzip ${DEPLOY_DIR_IMAGE}/${EXT4_IMAGE_FILE}
++    fi
+ }
+ 
+ addtask ext4_image before do_image after do_image_tools
+-- 
+2.20.1
+
diff --git a/opt-ext4-gz.yml b/opt-ext4-gz.yml
new file mode 100644
index 0000000..1a6502f
--- /dev/null
+++ b/opt-ext4-gz.yml
@@ -0,0 +1,24 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2018
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+repos:
+  isar:
+    patches:
+      01-compress-ext4:
+        path: isar-patches/0001-classes-ext4.img-Compress.patch
+        repo: xenomai
+
+local_conf_header:
+  compress: |
+    COMPRESS = "gz"
-- 
2.20.1


