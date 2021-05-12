From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 2/9] ci: Remove "board-" from job names
Date: Wed, 12 May 2021 10:32:16 +0200
Message-Id: <c2a969b74c7173386c9877fce3ab25d69c7ebd93.1620808343.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620808343.git.jan.kiszka@siemens.com>
References: <cover.1620808343.git.jan.kiszka@siemens.com>
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

Only adds verbosity but no information. Keep it for the resource groups,
though, as they are board-related.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml           | 20 +++++++-------
 ci/kernel_4_19_xenomai_next.yml | 48 ++++++++++++++++-----------------
 ci/kernel_5_4_xenomai_next.yml  | 48 ++++++++++++++++-----------------
 ci/xenomai_3_0_x.yml            | 20 +++++++-------
 ci/xenomai_3_1_x.yml            | 48 ++++++++++++++++-----------------
 5 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 7ae2408..37811af 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -34,12 +34,12 @@ default:
     - export BUILD_JOB_ID=$(scripts/get-build-id.sh ${BUILD_JOB_NAME})
     - scripts/run-lava-tests.sh ${TARGET}
   variables:
-    BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:board-${TARGET}${TARGET_EXTENSION}"
+    BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:${TARGET}${TARGET_EXTENSION}"
   only:
     variables:
       - $LAVA_SSH_USER
 
-.build:board-qemu-amd64:
+.build:qemu-amd64:
   extends: .build
   variables:
     TARGET: qemu-amd64
@@ -51,7 +51,7 @@ default:
   variables:
     TARGET: qemu-amd64
 
-.build:board-qemu-armhf:
+.build:qemu-armhf:
   extends: .build
   variables:
     TARGET: qemu-armhf
@@ -63,7 +63,7 @@ default:
   variables:
     TARGET: qemu-armhf
 
-.build:board-qemu-arm64:
+.build:qemu-arm64:
   extends: .build
   variables:
     TARGET: qemu-arm64
@@ -75,37 +75,37 @@ default:
   variables:
     TARGET: qemu-arm64
 
-.build:board-hikey:
+.build:hikey:
   extends: .build
   variables:
     TARGET: hikey
     BUILD_OPTIONS: ":opt-lava-test.yml"
 
-.lava-test:board-hikey:
+.lava-test:hikey:
   extends: .test
   resource_group: board-hikey
   variables:
     TARGET: hikey
 
-.build:board-beagle-bone-black:
+.build:beagle-bone-black:
   extends: .build
   variables:
     TARGET: beagle-bone-black
     BUILD_OPTIONS: ":opt-lava-test.yml"
 
-.lava-test:board-beagle-bone-black:
+.lava-test:beagle-bone-black:
   extends: .test
   resource_group: board-beagle-bone-black
   variables:
     TARGET: beagle-bone-black
 
-.build:board-x86-64-efi:
+.build:x86-64-efi:
   extends: .build
   variables:
     TARGET: x86-64-efi
     BUILD_OPTIONS: ":opt-lava-test.yml"
 
-.lava-test:board-x86-64-efi:
+.lava-test:x86-64-efi:
   extends: .test
   resource_group: board-x86-64-efi
   variables:
diff --git a/ci/kernel_4_19_xenomai_next.yml b/ci/kernel_4_19_xenomai_next.yml
index f98edc4..765a805 100644
--- a/ci/kernel_4_19_xenomai_next.yml
+++ b/ci/kernel_4_19_xenomai_next.yml
@@ -9,74 +9,74 @@
 # SPDX-License-Identifier: MIT
 #
 
-build-4.19:board-qemu-amd64:
-  extends: .build:board-qemu-amd64
+build-4.19:qemu-amd64:
+  extends: .build:qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
 lava-test-4.19:qemu-amd64:
-  needs: [ "build-4.19:board-qemu-amd64" ]
+  needs: [ "build-4.19:qemu-amd64" ]
   extends: .lava-test:qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
 
-build-4.19:board-qemu-armhf:
-  extends: .build:board-qemu-armhf
+build-4.19:qemu-armhf:
+  extends: .build:qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
 lava-test-4.19:qemu-armhf:
-  needs: [ "build-4.19:board-qemu-armhf" ]
+  needs: [ "build-4.19:qemu-armhf" ]
   extends: .lava-test:qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
 
-build-4.19:board-qemu-arm64:
-  extends: .build:board-qemu-arm64
+build-4.19:qemu-arm64:
+  extends: .build:qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
 lava-test-4.19:qemu-arm64:
-  needs: [ "build-4.19:board-qemu-arm64" ]
+  needs: [ "build-4.19:qemu-arm64" ]
   extends: .lava-test:qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
 
-build-4.19:board-hikey:
-  extends: .build:board-hikey
+build-4.19:hikey:
+  extends: .build:hikey
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:board-hikey:
-  needs: [ "build-4.19:board-hikey" ]
-  extends: .lava-test:board-hikey
+lava-test-4.19:hikey:
+  needs: [ "build-4.19:hikey" ]
+  extends: .lava-test:hikey
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
 
-build-4.19:board-beagle-bone-black:
-  extends: .build:board-beagle-bone-black
+build-4.19:beagle-bone-black:
+  extends: .build:beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:board-beagle-bone-black:
-  needs: [ "build-4.19:board-beagle-bone-black" ]
-  extends: .lava-test:board-beagle-bone-black
+lava-test-4.19:beagle-bone-black:
+  needs: [ "build-4.19:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
 
-build-4.19:board-x86-64-efi:
-  extends: .build:board-x86-64-efi
+build-4.19:x86-64-efi:
+  extends: .build:x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:board-x86-64-efi:
-  needs: [ "build-4.19:board-x86-64-efi" ]
-  extends: .lava-test:board-x86-64-efi
+lava-test-4.19:x86-64-efi:
+  needs: [ "build-4.19:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
diff --git a/ci/kernel_5_4_xenomai_next.yml b/ci/kernel_5_4_xenomai_next.yml
index 1092aea..6b2708f 100644
--- a/ci/kernel_5_4_xenomai_next.yml
+++ b/ci/kernel_5_4_xenomai_next.yml
@@ -9,80 +9,80 @@
 # SPDX-License-Identifier: MIT
 #
 
-build-5.4:board-qemu-amd64:
-  extends: .build:board-qemu-amd64
+build-5.4:qemu-amd64:
+  extends: .build:qemu-amd64
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     DEPLOY_DIR_EXTENSION: "5.4"
 
 lava-test-5.4:qemu-amd64:
-  needs: [ "build-5.4:board-qemu-amd64" ]
+  needs: [ "build-5.4:qemu-amd64" ]
   extends: .lava-test:qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
 
-build-5.4:board-qemu-armhf:
-  extends: .build:board-qemu-armhf
+build-5.4:qemu-armhf:
+  extends: .build:qemu-armhf
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     DEPLOY_DIR_EXTENSION: "5.4"
 
 lava-test-5.4:qemu-armhf:
-  needs: [ "build-5.4:board-qemu-armhf" ]
+  needs: [ "build-5.4:qemu-armhf" ]
   extends: .lava-test:qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
 
-build-5.4:board-qemu-arm64:
-  extends: .build:board-qemu-arm64
+build-5.4:qemu-arm64:
+  extends: .build:qemu-arm64
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     DEPLOY_DIR_EXTENSION: "5.4"
 
 lava-test-5.4:qemu-arm64:
-  needs: [ "build-5.4:board-qemu-arm64" ]
+  needs: [ "build-5.4:qemu-arm64" ]
   extends: .lava-test:qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
 
-build-5.4:board-hikey:
-  extends: .build:board-hikey
+build-5.4:hikey:
+  extends: .build:hikey
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     DEPLOY_DIR_EXTENSION: "5.4"
 
-lava-test-5.4:board-hikey:
-  needs: [ "build-5.4:board-hikey" ]
-  extends: .lava-test:board-hikey
+lava-test-5.4:hikey:
+  needs: [ "build-5.4:hikey" ]
+  extends: .lava-test:hikey
   variables:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
 
-build-5.4:board-beagle-bone-black:
-  extends: .build:board-beagle-bone-black
+build-5.4:beagle-bone-black:
+  extends: .build:beagle-bone-black
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     DEPLOY_DIR_EXTENSION: "5.4"
 
-lava-test-5.4:board-beagle-bone-black:
-  needs: [ "build-5.4:board-beagle-bone-black" ]
-  extends: .lava-test:board-beagle-bone-black
+lava-test-5.4:beagle-bone-black:
+  needs: [ "build-5.4:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
 
-build-5.4:board-x86-64-efi:
-  extends: .build:board-x86-64-efi
+build-5.4:x86-64-efi:
+  extends: .build:x86-64-efi
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     DEPLOY_DIR_EXTENSION: "5.4"
 
-lava-test-5.4:board-x86-64-efi:
-  needs: [ "build-5.4:board-x86-64-efi" ]
-  extends: .lava-test:board-x86-64-efi
+lava-test-5.4:x86-64-efi:
+  needs: [ "build-5.4:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
diff --git a/ci/xenomai_3_0_x.yml b/ci/xenomai_3_0_x.yml
index 6a314b5..9b8c31e 100644
--- a/ci/xenomai_3_0_x.yml
+++ b/ci/xenomai_3_0_x.yml
@@ -11,28 +11,28 @@
 include:
   - local: '/ci/gitlab-ci-base.yml'
 
-build-4.4:board-beagle-bone-black:
-  extends: .build:board-beagle-bone-black
+build-4.4:beagle-bone-black:
+  extends: .build:beagle-bone-black
   variables:
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
 
-lava-test-4.4:board-beagle-bone-black:
-  needs: [ "build-4.4:board-beagle-bone-black" ]
-  extends: .lava-test:board-beagle-bone-black
+lava-test-4.4:beagle-bone-black:
+  needs: [ "build-4.4:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
     BUILD_IDENTIFIER: "4.4"
 
-build-4.4:board-x86-64-efi:
-  extends: .build:board-x86-64-efi
+build-4.4:x86-64-efi:
+  extends: .build:x86-64-efi
   variables:
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
 
-lava-test-4.4:board-x86-64-efi:
-  needs: [ "build-4.4:board-x86-64-efi" ]
-  extends: .lava-test:board-x86-64-efi
+lava-test-4.4:x86-64-efi:
+  needs: [ "build-4.4:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
     BUILD_IDENTIFIER: "4.4"
diff --git a/ci/xenomai_3_1_x.yml b/ci/xenomai_3_1_x.yml
index 19eaf38..11f3640 100644
--- a/ci/xenomai_3_1_x.yml
+++ b/ci/xenomai_3_1_x.yml
@@ -12,80 +12,80 @@ include:
   - local: '/ci/gitlab-ci-base.yml'
 
 
-build-4.19:board-qemu-amd64:
-  extends: .build:board-qemu-amd64
+build-4.19:qemu-amd64:
+  extends: .build:qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
 lava-test-4.19:qemu-amd64:
-  needs: [ "build-4.19:board-qemu-amd64" ]
+  needs: [ "build-4.19:qemu-amd64" ]
   extends: .lava-test:qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
 
-build-4.19:board-qemu-armhf:
-  extends: .build:board-qemu-armhf
+build-4.19:qemu-armhf:
+  extends: .build:qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
 lava-test-4.19:qemu-armhf:
-  needs: [ "build-4.19:board-qemu-armhf" ]
+  needs: [ "build-4.19:qemu-armhf" ]
   extends: .lava-test:qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
 
-build-4.19:board-qemu-arm64:
-  extends: .build:board-qemu-arm64
+build-4.19:qemu-arm64:
+  extends: .build:qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
 lava-test-4.19:qemu-arm64:
-  needs: [ "build-4.19:board-qemu-arm64" ]
+  needs: [ "build-4.19:qemu-arm64" ]
   extends: .lava-test:qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
 
-build-4.19:board-hikey:
-  extends: .build:board-hikey
+build-4.19:hikey:
+  extends: .build:hikey
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
-lava-test-4.19:board-hikey:
-  needs: [ "build-4.19:board-hikey" ]
-  extends: .lava-test:board-hikey
+lava-test-4.19:hikey:
+  needs: [ "build-4.19:hikey" ]
+  extends: .lava-test:hikey
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
 
-build-4.19:board-beagle-bone-black:
-  extends: .build:board-beagle-bone-black
+build-4.19:beagle-bone-black:
+  extends: .build:beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
-lava-test-4.19:board-beagle-bone-black:
-  needs: [ "build-4.19:board-beagle-bone-black" ]
-  extends: .lava-test:board-beagle-bone-black
+lava-test-4.19:beagle-bone-black:
+  needs: [ "build-4.19:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
 
-build-4.19:board-x86-64-efi:
-  extends: .build:board-x86-64-efi
+build-4.19:x86-64-efi:
+  extends: .build:x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
-lava-test-4.19:board-x86-64-efi:
-  needs: [ "build-4.19:board-x86-64-efi" ]
-  extends: .lava-test:board-x86-64-efi
+lava-test-4.19:x86-64-efi:
+  needs: [ "build-4.19:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
-- 
2.26.2


