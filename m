From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 2/3] ci: Add kernel 5.15
Date: Mon, 10 Jan 2022 18:32:18 +0100
Message-ID: <dba8bd21c29ee492f4a039621cd0d16e73de31a4.1641835939.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641835939.git.jan.kiszka@siemens.com>
References: <cover.1641835939.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Limit to xenomai-next because on this version fully supports it so far.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/kernel_5_15.yml  | 82 +++++++++++++++++++++++++++++++++++++++++++++
 ci/xenomai_next.yml |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 ci/kernel_5_15.yml

diff --git a/ci/kernel_5_15.yml b/ci/kernel_5_15.yml
new file mode 100644
index 0000000..f8c3e4b
--- /dev/null
+++ b/ci/kernel_5_15.yml
@@ -0,0 +1,82 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-5.15:qemu-amd64:
+  extends: .build:qemu-amd64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15:qemu-amd64:
+  needs: [ "build-5.15:qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+  variables:
+    KERNEL_VERSION: "5.15"
+
+build-5.15:qemu-armhf:
+  extends: .build:qemu-armhf
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15:qemu-armhf:
+  needs: [ "build-5.15:qemu-armhf" ]
+  extends: .lava-test:qemu-armhf
+  variables:
+    KERNEL_VERSION: "5.15"
+
+build-5.15:qemu-arm64:
+  extends: .build:qemu-arm64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15:qemu-arm64:
+  needs: [ "build-5.15:qemu-arm64" ]
+  extends: .lava-test:qemu-arm64
+  variables:
+    KERNEL_VERSION: "5.15"
+
+build-5.15:hikey:
+  extends: .build:hikey
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15:hikey:
+  needs: [ "build-5.15:hikey" ]
+  extends: .lava-test:hikey
+  variables:
+    KERNEL_VERSION: "5.15"
+
+build-5.15:beagle-bone-black:
+  extends: .build:beagle-bone-black
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15:beagle-bone-black:
+  needs: [ "build-5.15:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
+  variables:
+    KERNEL_VERSION: "5.15"
+
+build-5.15:x86-64-efi:
+  extends: .build:x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15:x86-64-efi:
+  needs: [ "build-5.15:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
+  variables:
+    KERNEL_VERSION: "5.15"
diff --git a/ci/xenomai_next.yml b/ci/xenomai_next.yml
index adb5990..52ac6dd 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_next.yml
@@ -12,6 +12,7 @@
 include:
   - local: '/ci/gitlab-ci-base.yml'
   - local: '/ci/kernel_5_10.yml'
+  - local: '/ci/kernel_5_15.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
-- 
2.31.1


