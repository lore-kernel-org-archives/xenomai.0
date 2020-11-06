From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 3/4] ci: Add xenomai-version to build
Date: Fri,  6 Nov 2020 15:56:31 +0100
Message-Id: <20201106145632.2951-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201106145632.2951-1-Quirin.Gylstorff@siemens.com>
References: <20201106145632.2951-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To identify the used xenomai version add the Version name to
each build job.

e.g.:
build-4.19:board-qemu-amd64:xenomai-next use kernel 4.19 and
xenomai-next for testing.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/4_19_builds.yml   | 42 ++++++++++++++++++++++++------------------
 ci/5_4_builds.yml    | 14 ++++++++------
 ci/xenomai_3_0_x.yml | 14 ++++++++------
 3 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/ci/4_19_builds.yml b/ci/4_19_builds.yml
index f98edc4..80252af 100644
--- a/ci/4_19_builds.yml
+++ b/ci/4_19_builds.yml
@@ -9,74 +9,80 @@
 # SPDX-License-Identifier: MIT
 #
 
-build-4.19:board-qemu-amd64:
+build-4.19:board-qemu-amd64:xenomai-next:
   extends: .build:board-qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:qemu-amd64:
-  needs: [ "build-4.19:board-qemu-amd64" ]
+lava-test-4.19:qemu-amd64:xenomai-next:
+  needs: [ "build-4.19:board-qemu-amd64:xenomai-next" ]
   extends: .lava-test:qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-next"
 
-build-4.19:board-qemu-armhf:
+build-4.19:board-qemu-armhf:xenomai-next:
   extends: .build:board-qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:qemu-armhf:
-  needs: [ "build-4.19:board-qemu-armhf" ]
+lava-test-4.19:qemu-armhf:xenomai-next:
+  needs: [ "build-4.19:board-qemu-armhf:xenomai-next" ]
   extends: .lava-test:qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-next"
 
-build-4.19:board-qemu-arm64:
+build-4.19:board-qemu-arm64:xenomai-next:
   extends: .build:board-qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:qemu-arm64:
-  needs: [ "build-4.19:board-qemu-arm64" ]
+lava-test-4.19:qemu-arm64:xenomai-next:
+  needs: [ "build-4.19:board-qemu-arm64:xenomai-next" ]
   extends: .lava-test:qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-next"
 
-build-4.19:board-hikey:
+build-4.19:board-hikey:xenomai-next:
   extends: .build:board-hikey
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:board-hikey:
-  needs: [ "build-4.19:board-hikey" ]
+lava-test-4.19:board-hikey:xenomai-next:
+  needs: [ "build-4.19:board-hikey:xenomai-next" ]
   extends: .lava-test:board-hikey
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-next"
 
-build-4.19:board-beagle-bone-black:
+build-4.19:board-beagle-bone-black:xenomai-next:
   extends: .build:board-beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:board-beagle-bone-black:
-  needs: [ "build-4.19:board-beagle-bone-black" ]
+lava-test-4.19:board-beagle-bone-black:xenomai-next:
+  needs: [ "build-4.19:board-beagle-bone-black:xenomai-next" ]
   extends: .lava-test:board-beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-next"
 
-build-4.19:board-x86-64-efi:
+build-4.19:board-x86-64-efi:xenomai-next:
   extends: .build:board-x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:board-x86-64-efi:
-  needs: [ "build-4.19:board-x86-64-efi" ]
+lava-test-4.19:board-x86-64-efi:xenomai-next:
+  needs: [ "build-4.19:board-x86-64-efi:xenomai-next" ]
   extends: .lava-test:board-x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-next"
diff --git a/ci/5_4_builds.yml b/ci/5_4_builds.yml
index 4e8ea76..d7f10fa 100644
--- a/ci/5_4_builds.yml
+++ b/ci/5_4_builds.yml
@@ -9,30 +9,32 @@
 # SPDX-License-Identifier: MIT
 #
 
-build-5.4:board-qemu-amd64:
+build-5.4:board-qemu-amd64:xenomai-next:
   extends: .build:board-qemu-amd64
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     DEPLOY_DIR_EXTENSION: "5.4"
 
-lava-test-5.4:qemu-amd64:
-  needs: [ "build-5.4:board-qemu-amd64" ]
+lava-test-5.4:qemu-amd64:xenomai-next:
+  needs: [ "build-5.4:board-qemu-amd64:xenomai-next" ]
   extends: .lava-test:qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
+    TARGET_EXTENSION: ":xenomai-next"
 
 
-build-5.4:board-x86-64-efi:
+build-5.4:board-x86-64-efi:xenomai-next:
   extends: .build:board-x86-64-efi
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     DEPLOY_DIR_EXTENSION: "5.4"
 
 
-lava-test-5.4:board-x86-64-efi:
-  needs: [ "build-5.4:board-x86-64-efi" ]
+lava-test-5.4:board-x86-64-efi:xenomai-next:
+  needs: [ "build-5.4:board-x86-64-efi:xenomai-next" ]
   extends: .lava-test:board-x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
+    TARGET_EXTENSION: ":xenomai-next"
diff --git a/ci/xenomai_3_0_x.yml b/ci/xenomai_3_0_x.yml
index 9dbd8d4..6b868a9 100644
--- a/ci/xenomai_3_0_x.yml
+++ b/ci/xenomai_3_0_x.yml
@@ -9,28 +9,30 @@
 # SPDX-License-Identifier: MIT
 #
 
-build-4.4:board-beagle-bone-black:
+build-4.4:board-beagle-bone-black:xenomai-3.0.x:
   extends: .build:board-beagle-bone-black
   variables:
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
 
-lava-test-4.4:board-beagle-bone-black:
-  needs: [ "build-4.4:board-beagle-bone-black" ]
+lava-test-4.4:board-beagle-bone-black:xenomai-3.0.x:
+  needs: [ "build-4.4:board-beagle-bone-black:xenomai-3.0.x" ]
   extends: .lava-test:board-beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
     BUILD_IDENTIFIER: "4.4"
+    TARGET_EXTENSION: ":xenomai-3.0.x"
 
-build-4.4:board-x86-64-efi:
+build-4.4:board-x86-64-efi:xenomai-3.0.x:
   extends: .build:board-x86-64-efi
   variables:
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
 
-lava-test-4.4:board-x86-64-efi:
-  needs: [ "build-4.4:board-x86-64-efi" ]
+lava-test-4.4:board-x86-64-efi:xenomai-3.0.x:
+  needs: [ "build-4.4:board-x86-64-efi:xenomai-3.0.x" ]
   extends: .lava-test:board-x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
     BUILD_IDENTIFIER: "4.4"
+    TARGET_EXTENSION: ":xenomai-3.0.x"
-- 
2.20.1


