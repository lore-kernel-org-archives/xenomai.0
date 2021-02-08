From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 2/2] ci: Add 5.4 kernels targets for arm and
 arm64
Message-ID: <a7e28517-505b-5b95-58ca-8a64d9310cbf@siemens.com>
Date: Mon, 8 Feb 2021 21:48:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/kernel_5_4_xenomai_next.yml | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/ci/kernel_5_4_xenomai_next.yml b/ci/kernel_5_4_xenomai_next.yml
index 4d366dc..1092aea 100644
--- a/ci/kernel_5_4_xenomai_next.yml
+++ b/ci/kernel_5_4_xenomai_next.yml
@@ -22,6 +22,58 @@ lava-test-5.4:qemu-amd64:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
 
+build-5.4:board-qemu-armhf:
+  extends: .build:board-qemu-armhf
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    DEPLOY_DIR_EXTENSION: "5.4"
+
+lava-test-5.4:qemu-armhf:
+  needs: [ "build-5.4:board-qemu-armhf" ]
+  extends: .lava-test:qemu-armhf
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.4"
+    BUILD_IDENTIFIER: "5.4"
+
+build-5.4:board-qemu-arm64:
+  extends: .build:board-qemu-arm64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    DEPLOY_DIR_EXTENSION: "5.4"
+
+lava-test-5.4:qemu-arm64:
+  needs: [ "build-5.4:board-qemu-arm64" ]
+  extends: .lava-test:qemu-arm64
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.4"
+    BUILD_IDENTIFIER: "5.4"
+
+build-5.4:board-hikey:
+  extends: .build:board-hikey
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    DEPLOY_DIR_EXTENSION: "5.4"
+
+lava-test-5.4:board-hikey:
+  needs: [ "build-5.4:board-hikey" ]
+  extends: .lava-test:board-hikey
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.4"
+    BUILD_IDENTIFIER: "5.4"
+
+build-5.4:board-beagle-bone-black:
+  extends: .build:board-beagle-bone-black
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    DEPLOY_DIR_EXTENSION: "5.4"
+
+lava-test-5.4:board-beagle-bone-black:
+  needs: [ "build-5.4:board-beagle-bone-black" ]
+  extends: .lava-test:board-beagle-bone-black
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.4"
+    BUILD_IDENTIFIER: "5.4"
+
 build-5.4:board-x86-64-efi:
   extends: .build:board-x86-64-efi
   variables:
-- 
2.26.2

