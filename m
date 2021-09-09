From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 3/3] Provide consistent kas files for
 selecting kernels
Date: Thu,  9 Sep 2021 19:44:34 +0200
Message-Id: <36f735bf45d5539e15b9e01725760674a793ac9d.1631209474.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1631209474.git.jan.kiszka@siemens.com>
References: <cover.1631209474.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Add the missing 5.4 and 5.10 release files, provide clearly named latest
options for 4.4 and 4.19.

CI needs some refactoring as opt-linux-latest.yml is renamed. Use that
chance to make kernel selection more explicit. That should also help
moving forward.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml                           |  1 -
 ci/kernel_4_19_xenomai_next.yml                 |  6 ++++++
 ci/xenomai_3_0_x.yml                            |  2 ++
 ci/xenomai_3_1_x.yml                            |  6 ++++++
 opt-linux-5.10.yml                              | 17 +++++++++++++++++
 opt-linux-5.4.yml                               | 17 +++++++++++++++++
 ...inux-latest.yml => opt-linux-latest-4.19.yml |  0
 ...linux-latest.yml => opt-linux-latest-4.4.yml |  6 +++---
 8 files changed, 51 insertions(+), 4 deletions(-)
 create mode 100644 opt-linux-5.10.yml
 create mode 100644 opt-linux-5.4.yml
 copy opt-linux-latest.yml => opt-linux-latest-4.19.yml (100%)
 rename opt-linux-latest.yml => opt-linux-latest-4.4.yml (62%)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index ce9c800..13d37b0 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -19,7 +19,6 @@ variables:
   ftp_proxy: "$FTP_PROXY"
   no_proxy: "$NO_PROXY"
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
-  LINUX_BUILD_OPTION: ":opt-linux-latest.yml"
   ISAR_IMAGE: demo-image
   ISAR_DISTRIBUTION: xenomai-demo
   LAVA_TESTS_ENABLED: "true"
diff --git a/ci/kernel_4_19_xenomai_next.yml b/ci/kernel_4_19_xenomai_next.yml
index 765a805..6ae2c35 100644
--- a/ci/kernel_4_19_xenomai_next.yml
+++ b/ci/kernel_4_19_xenomai_next.yml
@@ -12,6 +12,7 @@
 build-4.19:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     DEPLOY_DIR_EXTENSION: "4.19"
 
 lava-test-4.19:qemu-amd64:
@@ -24,6 +25,7 @@ lava-test-4.19:qemu-amd64:
 build-4.19:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     DEPLOY_DIR_EXTENSION: "4.19"
 
 lava-test-4.19:qemu-armhf:
@@ -36,6 +38,7 @@ lava-test-4.19:qemu-armhf:
 build-4.19:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     DEPLOY_DIR_EXTENSION: "4.19"
 
 lava-test-4.19:qemu-arm64:
@@ -48,6 +51,7 @@ lava-test-4.19:qemu-arm64:
 build-4.19:hikey:
   extends: .build:hikey
   variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     DEPLOY_DIR_EXTENSION: "4.19"
 
 lava-test-4.19:hikey:
@@ -60,6 +64,7 @@ lava-test-4.19:hikey:
 build-4.19:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     DEPLOY_DIR_EXTENSION: "4.19"
 
 lava-test-4.19:beagle-bone-black:
@@ -72,6 +77,7 @@ lava-test-4.19:beagle-bone-black:
 build-4.19:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     DEPLOY_DIR_EXTENSION: "4.19"
 
 lava-test-4.19:x86-64-efi:
diff --git a/ci/xenomai_3_0_x.yml b/ci/xenomai_3_0_x.yml
index 9b8c31e..cedd2e0 100644
--- a/ci/xenomai_3_0_x.yml
+++ b/ci/xenomai_3_0_x.yml
@@ -15,6 +15,7 @@ build-4.4:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.4.yml"
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
 
 lava-test-4.4:beagle-bone-black:
@@ -28,6 +29,7 @@ build-4.4:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.4.yml"
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
 
 lava-test-4.4:x86-64-efi:
diff --git a/ci/xenomai_3_1_x.yml b/ci/xenomai_3_1_x.yml
index 11f3640..1e0961f 100644
--- a/ci/xenomai_3_1_x.yml
+++ b/ci/xenomai_3_1_x.yml
@@ -17,6 +17,7 @@ build-4.19:qemu-amd64:
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
 
 lava-test-4.19:qemu-amd64:
   needs: [ "build-4.19:qemu-amd64" ]
@@ -30,6 +31,7 @@ build-4.19:qemu-armhf:
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
 
 lava-test-4.19:qemu-armhf:
   needs: [ "build-4.19:qemu-armhf" ]
@@ -43,6 +45,7 @@ build-4.19:qemu-arm64:
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
 
 lava-test-4.19:qemu-arm64:
   needs: [ "build-4.19:qemu-arm64" ]
@@ -56,6 +59,7 @@ build-4.19:hikey:
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
 
 lava-test-4.19:hikey:
   needs: [ "build-4.19:hikey" ]
@@ -69,6 +73,7 @@ build-4.19:beagle-bone-black:
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
 
 lava-test-4.19:beagle-bone-black:
   needs: [ "build-4.19:beagle-bone-black" ]
@@ -82,6 +87,7 @@ build-4.19:x86-64-efi:
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
 
 lava-test-4.19:x86-64-efi:
   needs: [ "build-4.19:x86-64-efi" ]
diff --git a/opt-linux-5.10.yml b/opt-linux-5.10.yml
new file mode 100644
index 0000000..ae3b30d
--- /dev/null
+++ b/opt-linux-5.10.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai = "5.10%"
diff --git a/opt-linux-5.4.yml b/opt-linux-5.4.yml
new file mode 100644
index 0000000..2fb586e
--- /dev/null
+++ b/opt-linux-5.4.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai = "5.4%"
diff --git a/opt-linux-latest.yml b/opt-linux-latest-4.19.yml
similarity index 100%
copy from opt-linux-latest.yml
copy to opt-linux-latest-4.19.yml
diff --git a/opt-linux-latest.yml b/opt-linux-latest-4.4.yml
similarity index 62%
rename from opt-linux-latest.yml
rename to opt-linux-latest-4.4.yml
index 78f4a43..113ba76 100644
--- a/opt-linux-latest.yml
+++ b/opt-linux-latest-4.4.yml
@@ -1,10 +1,10 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2021
 #
 # Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
@@ -15,4 +15,4 @@ header:
 local_conf_header:
   linux-xenomai-latest: |
     PREFERRED_VERSION_linux-xenomai = "9999-%"
-    LATEST_GIT_BRANCH = "4.19"
+    LATEST_GIT_BRANCH = "4.4"
-- 
2.31.1


