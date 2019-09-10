From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 3/9] machine: Allow override of the image
 type
Date: Tue, 10 Sep 2019 16:44:53 +0200
Message-Id: <20190910144459.13239-4-Quirin.Gylstorff@siemens.com>
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

For the NFS rootfs a tarball is used. This changes allows
local.conf to set the IMAGE_TYPE from wic-img to targz-img.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml               |  4 ++--
 conf/machine/hikey.conf      |  2 +-
 conf/machine/x86-64-efi.conf |  2 +-
 opt-lava-test.yml            | 20 ++++++++++++++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)
 create mode 100644 opt-lava-test.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c75a7e6..ace8862 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -92,7 +92,7 @@ build:board-beaglebone:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-beagle-bone-black.yml
+    - kas build kas.yml:board-beagle-bone-black.yml:opt-lava-test.yml
     - scripts/deploy_for_testing.sh beagle-bone-black
 
 lava-test:board-beaglebone:
@@ -109,7 +109,7 @@ build:board-x86-64-efi:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-x86-64-efi.yml
+    - kas build kas.yml:board-x86-64-efi.yml:opt-lava-test.yml
     - scripts/deploy_for_testing.sh x86-64-efi
 
 lava-test:board-x86-64-efi:
diff --git a/conf/machine/hikey.conf b/conf/machine/hikey.conf
index 465e06e..3c93507 100644
--- a/conf/machine/hikey.conf
+++ b/conf/machine/hikey.conf
@@ -11,7 +11,7 @@
 
 DISTRO_ARCH = "arm64"
 
-IMAGE_TYPE = "wic-img"
+IMAGE_TYPE ?= "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 
 PREFERRED_VERSION_linux-xenomai = "4.14.%"
diff --git a/conf/machine/x86-64-efi.conf b/conf/machine/x86-64-efi.conf
index 0fd2ef1..02846ff 100644
--- a/conf/machine/x86-64-efi.conf
+++ b/conf/machine/x86-64-efi.conf
@@ -11,5 +11,5 @@
 
 DISTRO_ARCH = "amd64"
 
-IMAGE_TYPE = "wic-img"
+IMAGE_TYPE ?= "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
diff --git a/opt-lava-test.yml b/opt-lava-test.yml
new file mode 100644
index 0000000..206aea0
--- /dev/null
+++ b/opt-lava-test.yml
@@ -0,0 +1,20 @@
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
+header:
+  version: 8
+
+# lava uses nfs to deploy the image. For this we need a tarball instead of
+# full image
+
+local_conf_header:
+  image-type: |
+    IMAGE_TYPE = "targz-img"
-- 
2.20.1


