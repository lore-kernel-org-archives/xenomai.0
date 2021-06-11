From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 5/5] ci: Add kernel 5.10 to xenomai_next build
Date: Fri, 11 Jun 2021 22:13:12 +0200
Message-Id: <cb5aeba22b094511e4ab8e082227be571ddba4ef.1623442392.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623442392.git.jan.kiszka@siemens.com>
References: <cover.1623442392.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/kernel_5_10_xenomai_next.yml | 88 +++++++++++++++++++++++++++++++++
 ci/xenomai_next.yml             |  3 +-
 2 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 ci/kernel_5_10_xenomai_next.yml

diff --git a/ci/kernel_5_10_xenomai_next.yml b/ci/kernel_5_10_xenomai_next.yml
new file mode 100644
index 0000000..80bcf87
--- /dev/null
+++ b/ci/kernel_5_10_xenomai_next.yml
@@ -0,0 +1,88 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-5.10:qemu-amd64:
+  extends: .build:qemu-amd64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    DEPLOY_DIR_EXTENSION: "5.10"
+
+lava-test-5.10:qemu-amd64:
+  needs: [ "build-5.10:qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.10"
+    BUILD_IDENTIFIER: "5.10"
+
+build-5.10:qemu-armhf:
+  extends: .build:qemu-armhf
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    DEPLOY_DIR_EXTENSION: "5.10"
+
+lava-test-5.10:qemu-armhf:
+  needs: [ "build-5.10:qemu-armhf" ]
+  extends: .lava-test:qemu-armhf
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.10"
+    BUILD_IDENTIFIER: "5.10"
+
+build-5.10:qemu-arm64:
+  extends: .build:qemu-arm64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    DEPLOY_DIR_EXTENSION: "5.10"
+
+lava-test-5.10:qemu-arm64:
+  needs: [ "build-5.10:qemu-arm64" ]
+  extends: .lava-test:qemu-arm64
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.10"
+    BUILD_IDENTIFIER: "5.10"
+
+build-5.10:hikey:
+  extends: .build:hikey
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    DEPLOY_DIR_EXTENSION: "5.10"
+
+lava-test-5.10:hikey:
+  needs: [ "build-5.10:hikey" ]
+  extends: .lava-test:hikey
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.10"
+    BUILD_IDENTIFIER: "5.10"
+
+build-5.10:beagle-bone-black:
+  extends: .build:beagle-bone-black
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    DEPLOY_DIR_EXTENSION: "5.10"
+
+lava-test-5.10:beagle-bone-black:
+  needs: [ "build-5.10:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.10"
+    BUILD_IDENTIFIER: "5.10"
+
+build-5.10:x86-64-efi:
+  extends: .build:x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    DEPLOY_DIR_EXTENSION: "5.10"
+
+lava-test-5.10:x86-64-efi:
+  needs: [ "build-5.10:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.10"
+    BUILD_IDENTIFIER: "5.10"
diff --git a/ci/xenomai_next.yml b/ci/xenomai_next.yml
index 6d964a6..b13dfa8 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_next.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2020
+# Copyright (c) Siemens AG, 2019 - 2021
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,3 +12,4 @@ include:
   - local: '/ci/gitlab-ci-base.yml'
   - local: '/ci/kernel_4_19_xenomai_next.yml'
   - local: '/ci/kernel_5_4_xenomai_next.yml'
+  - local: '/ci/kernel_5_10_xenomai_next.yml'
-- 
2.26.2


