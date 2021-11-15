From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v3 1/8] ci/kas: Consolidate kas option files,
 introduce opt-ci.yml
Date: Mon, 15 Nov 2021 11:13:39 +0100
Message-Id: <20211115101346.3566075-2-florian.bezdeka@siemens.com>
In-Reply-To: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
References: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Integrate opt-lava-test.yml and opt-ext4-gz.yml into opt-ci.yml.

opt-ci.yml now holds all CI specific options:
  - IMAGE_TYPE adjustments to fulfill LAVA needs
  - COMPRESS for virtual qemu targets

CI configuration has been cleaned up. We only need opt-ci.yml,
all board related BUILD_OPTIONS have been removed.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 ci/gitlab-ci-base.yml | 10 ++--------
 opt-ci.yml            | 29 +++++++++++++++++++++++++++++
 opt-ext4-gz.yml       | 24 ------------------------
 opt-lava-test.yml     | 20 --------------------
 4 files changed, 31 insertions(+), 52 deletions(-)
 create mode 100644 opt-ci.yml
 delete mode 100644 opt-ext4-gz.yml
 delete mode 100644 opt-lava-test.yml

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 8a1dbfb..231b9ca 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -39,8 +39,8 @@ default:
   stage: build
   script:
     - sudo sh -c "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
-    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml"
-    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml
+    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml:opt-ci.yml"
+    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml:opt-ci.yml
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
 
 .test:
@@ -64,7 +64,6 @@ default:
   extends: .build
   variables:
     TARGET: qemu-amd64
-    BUILD_OPTIONS: ":opt-ext4-gz.yml"
 
 .lava-test:qemu-amd64:
   extends: .test
@@ -75,7 +74,6 @@ default:
   extends: .build
   variables:
     TARGET: qemu-armhf
-    BUILD_OPTIONS: ":opt-ext4-gz.yml"
 
 .lava-test:qemu-armhf:
   extends: .test
@@ -86,7 +84,6 @@ default:
   extends: .build
   variables:
     TARGET: qemu-arm64
-    BUILD_OPTIONS: ":opt-ext4-gz.yml"
 
 .lava-test:qemu-arm64:
   extends: .test
@@ -97,7 +94,6 @@ default:
   extends: .build
   variables:
     TARGET: hikey
-    BUILD_OPTIONS: ":opt-lava-test.yml"
 
 .lava-test:hikey:
   extends: .test
@@ -109,7 +105,6 @@ default:
   extends: .build
   variables:
     TARGET: beagle-bone-black
-    BUILD_OPTIONS: ":opt-lava-test.yml"
 
 .lava-test:beagle-bone-black:
   extends: .test
@@ -121,7 +116,6 @@ default:
   extends: .build
   variables:
     TARGET: x86-64-efi
-    BUILD_OPTIONS: ":opt-lava-test.yml"
 
 .lava-test:x86-64-efi:
   extends: .test
diff --git a/opt-ci.yml b/opt-ci.yml
new file mode 100644
index 0000000..7f8d715
--- /dev/null
+++ b/opt-ci.yml
@@ -0,0 +1,29 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Florian Bezdeka <florian.bezdeka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+repos:
+  isar:
+    patches:
+      01-compress-ext4:
+        path: isar-patches/0001-classes-ext4.img-Compress.patch
+        repo: xenomai
+
+# LAVA uses nfs to deploy the image to real boards. For this we need a tarball
+# instead of full disk/wic image
+# For qemu we need a compressed ext4-img
+
+local_conf_header:
+  xenomai-ci: |
+    IMAGE_TYPE = "${@ 'ext4-img' if d.getVar('MACHINE', True).startswith('qemu') else 'targz-img' }"
+    COMPRESS = "${@ 'gz' if d.getVar('MACHINE', True).startswith('qemu') else '' }"
\ No newline at end of file
diff --git a/opt-ext4-gz.yml b/opt-ext4-gz.yml
deleted file mode 100644
index 409bf62..0000000
--- a/opt-ext4-gz.yml
+++ /dev/null
@@ -1,24 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2018
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 10
-
-repos:
-  isar:
-    patches:
-      01-compress-ext4:
-        path: isar-patches/0001-classes-ext4.img-Compress.patch
-        repo: xenomai
-
-local_conf_header:
-  compress: |
-    COMPRESS = "gz"
diff --git a/opt-lava-test.yml b/opt-lava-test.yml
deleted file mode 100644
index 9c33da6..0000000
--- a/opt-lava-test.yml
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 10
-
-# lava uses nfs to deploy the image. For this we need a tarball instead of
-# full image
-
-local_conf_header:
-  image-type: |
-    IMAGE_TYPE = "targz-img"
-- 
2.30.2


