From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v4 2/8] ci: Refactor inclusions
Date: Fri, 7 Jan 2022 16:02:57 +0100
Message-ID: <4adc12df9ec32288792cde290f2c7cbea394030b.1641567783.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641567783.git.jan.kiszka@siemens.com>
References: <cover.1641567783.git.jan.kiszka@siemens.com>
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

This makes the inclusion structure more regular and reduces duplications
by re-using the kernel_<version>.yml files for 3.1 and next. The trick
is that we pull common variables to additional top-level 'variables:'
blocks and only set what differes in the job-specific 'variables:'.

BUILD_IDENTIFIER is now used in place of DEPLOY_DIR_EXTENSION, and the
former is derived from the XENOMAI_VERSION and KERNEL_VERSION. Only
those version variables are set at xenomai_<version>.yml and kernel-
specific job level, respectively.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml                         |  2 +-
 ..._4_19_xenomai_next.yml => kernel_4_19.yml} | 32 +++----
 ..._5_10_xenomai_next.yml => kernel_5_10.yml} | 32 +++----
 ...el_5_4_xenomai_next.yml => kernel_5_4.yml} | 32 +++----
 ci/xenomai_3_0_x.yml                          | 23 ++---
 ci/xenomai_3_1_x.yml                          | 91 ++-----------------
 ci/xenomai_next.yml                           | 13 ++-
 scripts/deploy_to_aws.sh                      |  2 +-
 scripts/run-lava-tests.sh                     |  2 +-
 9 files changed, 65 insertions(+), 164 deletions(-)
 rename ci/{kernel_4_19_xenomai_next.yml => kernel_4_19.yml} (71%)
 rename ci/{kernel_5_10_xenomai_next.yml => kernel_5_10.yml} (71%)
 rename ci/{kernel_5_4_xenomai_next.yml => kernel_5_4.yml} (71%)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 367085d..cdf20e5 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -18,10 +18,10 @@ variables:
   https_proxy: "$HTTPS_PROXY"
   ftp_proxy: "$FTP_PROXY"
   no_proxy: "$NO_PROXY"
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
   ISAR_IMAGE: demo-image
   ISAR_DISTRIBUTION: xenomai-demo
   LAVA_TESTS_ENABLED: "true"
+  BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
 
 default:
   image: ghcr.io/siemens/kas/kas-isar:2.6.3
diff --git a/ci/kernel_4_19_xenomai_next.yml b/ci/kernel_4_19.yml
similarity index 71%
rename from ci/kernel_4_19_xenomai_next.yml
rename to ci/kernel_4_19.yml
index 6ae2c35..c55b26a 100644
--- a/ci/kernel_4_19_xenomai_next.yml
+++ b/ci/kernel_4_19.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2020
+# Copyright (c) Siemens AG, 2019 - 2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,76 +13,70 @@ build-4.19:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-    DEPLOY_DIR_EXTENSION: "4.19"
+    KERNEL_VERSION: "4.19"
 
 lava-test-4.19:qemu-amd64:
   needs: [ "build-4.19:qemu-amd64" ]
   extends: .lava-test:qemu-amd64
   variables:
-    DEPLOY_DIR_EXTENSION: "4.19"
-    BUILD_IDENTIFIER: "4.19"
+    KERNEL_VERSION: "4.19"
 
 build-4.19:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-    DEPLOY_DIR_EXTENSION: "4.19"
+    KERNEL_VERSION: "4.19"
 
 lava-test-4.19:qemu-armhf:
   needs: [ "build-4.19:qemu-armhf" ]
   extends: .lava-test:qemu-armhf
   variables:
-    DEPLOY_DIR_EXTENSION: "4.19"
-    BUILD_IDENTIFIER: "4.19"
+    KERNEL_VERSION: "4.19"
 
 build-4.19:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-    DEPLOY_DIR_EXTENSION: "4.19"
+    KERNEL_VERSION: "4.19"
 
 lava-test-4.19:qemu-arm64:
   needs: [ "build-4.19:qemu-arm64" ]
   extends: .lava-test:qemu-arm64
   variables:
-    DEPLOY_DIR_EXTENSION: "4.19"
-    BUILD_IDENTIFIER: "4.19"
+    KERNEL_VERSION: "4.19"
 
 build-4.19:hikey:
   extends: .build:hikey
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-    DEPLOY_DIR_EXTENSION: "4.19"
+    KERNEL_VERSION: "4.19"
 
 lava-test-4.19:hikey:
   needs: [ "build-4.19:hikey" ]
   extends: .lava-test:hikey
   variables:
-    DEPLOY_DIR_EXTENSION: "4.19"
-    BUILD_IDENTIFIER: "4.19"
+    KERNEL_VERSION: "4.19"
 
 build-4.19:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-    DEPLOY_DIR_EXTENSION: "4.19"
+    KERNEL_VERSION: "4.19"
 
 lava-test-4.19:beagle-bone-black:
   needs: [ "build-4.19:beagle-bone-black" ]
   extends: .lava-test:beagle-bone-black
   variables:
-    DEPLOY_DIR_EXTENSION: "4.19"
-    BUILD_IDENTIFIER: "4.19"
+    KERNEL_VERSION: "4.19"
 
 build-4.19:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-    DEPLOY_DIR_EXTENSION: "4.19"
+    KERNEL_VERSION: "4.19"
 
 lava-test-4.19:x86-64-efi:
   needs: [ "build-4.19:x86-64-efi" ]
   extends: .lava-test:x86-64-efi
   variables:
-    DEPLOY_DIR_EXTENSION: "4.19"
-    BUILD_IDENTIFIER: "4.19"
+    KERNEL_VERSION: "4.19"
diff --git a/ci/kernel_5_10_xenomai_next.yml b/ci/kernel_5_10.yml
similarity index 71%
rename from ci/kernel_5_10_xenomai_next.yml
rename to ci/kernel_5_10.yml
index 80bcf87..1c30617 100644
--- a/ci/kernel_5_10_xenomai_next.yml
+++ b/ci/kernel_5_10.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2021
+# Copyright (c) Siemens AG, 2019 - 2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,76 +13,70 @@ build-5.10:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
-    DEPLOY_DIR_EXTENSION: "5.10"
+    KERNEL_VERSION: "5.10"
 
 lava-test-5.10:qemu-amd64:
   needs: [ "build-5.10:qemu-amd64" ]
   extends: .lava-test:qemu-amd64
   variables:
-    DEPLOY_DIR_EXTENSION: "5.10"
-    BUILD_IDENTIFIER: "5.10"
+    KERNEL_VERSION: "5.10"
 
 build-5.10:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
-    DEPLOY_DIR_EXTENSION: "5.10"
+    KERNEL_VERSION: "5.10"
 
 lava-test-5.10:qemu-armhf:
   needs: [ "build-5.10:qemu-armhf" ]
   extends: .lava-test:qemu-armhf
   variables:
-    DEPLOY_DIR_EXTENSION: "5.10"
-    BUILD_IDENTIFIER: "5.10"
+    KERNEL_VERSION: "5.10"
 
 build-5.10:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
-    DEPLOY_DIR_EXTENSION: "5.10"
+    KERNEL_VERSION: "5.10"
 
 lava-test-5.10:qemu-arm64:
   needs: [ "build-5.10:qemu-arm64" ]
   extends: .lava-test:qemu-arm64
   variables:
-    DEPLOY_DIR_EXTENSION: "5.10"
-    BUILD_IDENTIFIER: "5.10"
+    KERNEL_VERSION: "5.10"
 
 build-5.10:hikey:
   extends: .build:hikey
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
-    DEPLOY_DIR_EXTENSION: "5.10"
+    KERNEL_VERSION: "5.10"
 
 lava-test-5.10:hikey:
   needs: [ "build-5.10:hikey" ]
   extends: .lava-test:hikey
   variables:
-    DEPLOY_DIR_EXTENSION: "5.10"
-    BUILD_IDENTIFIER: "5.10"
+    KERNEL_VERSION: "5.10"
 
 build-5.10:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
-    DEPLOY_DIR_EXTENSION: "5.10"
+    KERNEL_VERSION: "5.10"
 
 lava-test-5.10:beagle-bone-black:
   needs: [ "build-5.10:beagle-bone-black" ]
   extends: .lava-test:beagle-bone-black
   variables:
-    DEPLOY_DIR_EXTENSION: "5.10"
-    BUILD_IDENTIFIER: "5.10"
+    KERNEL_VERSION: "5.10"
 
 build-5.10:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
-    DEPLOY_DIR_EXTENSION: "5.10"
+    KERNEL_VERSION: "5.10"
 
 lava-test-5.10:x86-64-efi:
   needs: [ "build-5.10:x86-64-efi" ]
   extends: .lava-test:x86-64-efi
   variables:
-    DEPLOY_DIR_EXTENSION: "5.10"
-    BUILD_IDENTIFIER: "5.10"
+    KERNEL_VERSION: "5.10"
diff --git a/ci/kernel_5_4_xenomai_next.yml b/ci/kernel_5_4.yml
similarity index 71%
rename from ci/kernel_5_4_xenomai_next.yml
rename to ci/kernel_5_4.yml
index 6b2708f..f80b653 100644
--- a/ci/kernel_5_4_xenomai_next.yml
+++ b/ci/kernel_5_4.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2020
+# Copyright (c) Siemens AG, 2019 - 2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,76 +13,70 @@ build-5.4:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
-    DEPLOY_DIR_EXTENSION: "5.4"
+    KERNEL_VERSION: "5.4"
 
 lava-test-5.4:qemu-amd64:
   needs: [ "build-5.4:qemu-amd64" ]
   extends: .lava-test:qemu-amd64
   variables:
-    DEPLOY_DIR_EXTENSION: "5.4"
-    BUILD_IDENTIFIER: "5.4"
+    KERNEL_VERSION: "5.4"
 
 build-5.4:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
-    DEPLOY_DIR_EXTENSION: "5.4"
+    KERNEL_VERSION: "5.4"
 
 lava-test-5.4:qemu-armhf:
   needs: [ "build-5.4:qemu-armhf" ]
   extends: .lava-test:qemu-armhf
   variables:
-    DEPLOY_DIR_EXTENSION: "5.4"
-    BUILD_IDENTIFIER: "5.4"
+    KERNEL_VERSION: "5.4"
 
 build-5.4:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
-    DEPLOY_DIR_EXTENSION: "5.4"
+    KERNEL_VERSION: "5.4"
 
 lava-test-5.4:qemu-arm64:
   needs: [ "build-5.4:qemu-arm64" ]
   extends: .lava-test:qemu-arm64
   variables:
-    DEPLOY_DIR_EXTENSION: "5.4"
-    BUILD_IDENTIFIER: "5.4"
+    KERNEL_VERSION: "5.4"
 
 build-5.4:hikey:
   extends: .build:hikey
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
-    DEPLOY_DIR_EXTENSION: "5.4"
+    KERNEL_VERSION: "5.4"
 
 lava-test-5.4:hikey:
   needs: [ "build-5.4:hikey" ]
   extends: .lava-test:hikey
   variables:
-    DEPLOY_DIR_EXTENSION: "5.4"
-    BUILD_IDENTIFIER: "5.4"
+    KERNEL_VERSION: "5.4"
 
 build-5.4:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
-    DEPLOY_DIR_EXTENSION: "5.4"
+    KERNEL_VERSION: "5.4"
 
 lava-test-5.4:beagle-bone-black:
   needs: [ "build-5.4:beagle-bone-black" ]
   extends: .lava-test:beagle-bone-black
   variables:
-    DEPLOY_DIR_EXTENSION: "5.4"
-    BUILD_IDENTIFIER: "5.4"
+    KERNEL_VERSION: "5.4"
 
 build-5.4:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
-    DEPLOY_DIR_EXTENSION: "5.4"
+    KERNEL_VERSION: "5.4"
 
 lava-test-5.4:x86-64-efi:
   needs: [ "build-5.4:x86-64-efi" ]
   extends: .lava-test:x86-64-efi
   variables:
-    DEPLOY_DIR_EXTENSION: "5.4"
-    BUILD_IDENTIFIER: "5.4"
+    KERNEL_VERSION: "5.4"
diff --git a/ci/xenomai_3_0_x.yml b/ci/xenomai_3_0_x.yml
index cedd2e0..5d3ddee 100644
--- a/ci/xenomai_3_0_x.yml
+++ b/ci/xenomai_3_0_x.yml
@@ -1,40 +1,33 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2020
+# Copyright (c) Siemens AG, 2019 - 2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
+
 include:
   - local: '/ci/gitlab-ci-base.yml'
 
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
+  LINUX_BUILD_OPTION: ":opt-linux-latest-4.4.yml"
+  XENOMAI_VERSION: "3.0.x"
+  KERNEL_VERSION: "4.4"
+
 build-4.4:beagle-bone-black:
   extends: .build:beagle-bone-black
-  variables:
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.4.yml"
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
 
 lava-test-4.4:beagle-bone-black:
   needs: [ "build-4.4:beagle-bone-black" ]
   extends: .lava-test:beagle-bone-black
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
-    BUILD_IDENTIFIER: "4.4"
 
 build-4.4:x86-64-efi:
   extends: .build:x86-64-efi
-  variables:
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.4.yml"
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
 
 lava-test-4.4:x86-64-efi:
   needs: [ "build-4.4:x86-64-efi" ]
   extends: .lava-test:x86-64-efi
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
-    BUILD_IDENTIFIER: "4.4"
diff --git a/ci/xenomai_3_1_x.yml b/ci/xenomai_3_1_x.yml
index 1e0961f..b6f0010 100644
--- a/ci/xenomai_3_1_x.yml
+++ b/ci/xenomai_3_1_x.yml
@@ -1,97 +1,18 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
+
 include:
   - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/kernel_4_19.yml'
 
-
-build-4.19:qemu-amd64:
-  extends: .build:qemu-amd64
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-
-lava-test-4.19:qemu-amd64:
-  needs: [ "build-4.19:qemu-amd64" ]
-  extends: .lava-test:qemu-amd64
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    BUILD_IDENTIFIER: "4.19"
-
-build-4.19:qemu-armhf:
-  extends: .build:qemu-armhf
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-
-lava-test-4.19:qemu-armhf:
-  needs: [ "build-4.19:qemu-armhf" ]
-  extends: .lava-test:qemu-armhf
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    BUILD_IDENTIFIER: "4.19"
-
-build-4.19:qemu-arm64:
-  extends: .build:qemu-arm64
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-
-lava-test-4.19:qemu-arm64:
-  needs: [ "build-4.19:qemu-arm64" ]
-  extends: .lava-test:qemu-arm64
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    BUILD_IDENTIFIER: "4.19"
-
-build-4.19:hikey:
-  extends: .build:hikey
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-
-lava-test-4.19:hikey:
-  needs: [ "build-4.19:hikey" ]
-  extends: .lava-test:hikey
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    BUILD_IDENTIFIER: "4.19"
-
-build-4.19:beagle-bone-black:
-  extends: .build:beagle-bone-black
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-
-lava-test-4.19:beagle-bone-black:
-  needs: [ "build-4.19:beagle-bone-black" ]
-  extends: .lava-test:beagle-bone-black
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    BUILD_IDENTIFIER: "4.19"
-
-build-4.19:x86-64-efi:
-  extends: .build:x86-64-efi
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
-
-lava-test-4.19:x86-64-efi:
-  needs: [ "build-4.19:x86-64-efi" ]
-  extends: .lava-test:x86-64-efi
-  variables:
-    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
-    BUILD_IDENTIFIER: "4.19"
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+  XENOMAI_VERSION: "3.1.x"
diff --git a/ci/xenomai_next.yml b/ci/xenomai_next.yml
index b13dfa8..91275ae 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_next.yml
@@ -1,15 +1,20 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2021
+# Copyright (c) Siemens AG, 2019 - 2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
+
 include:
   - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_4_19_xenomai_next.yml'
-  - local: '/ci/kernel_5_4_xenomai_next.yml'
-  - local: '/ci/kernel_5_10_xenomai_next.yml'
+  - local: '/ci/kernel_4_19.yml'
+  - local: '/ci/kernel_5_4.yml'
+  - local: '/ci/kernel_5_10.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
+  XENOMAI_VERSION: "next"
diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index 7d9aa89..f5aed6f 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -28,7 +28,7 @@ fi
 aws_args="--acl=public-read"
 
 isar_base_name="${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${target}"
-deploy_dir="${destination}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
+deploy_dir="${destination}/${CI_PIPELINE_ID}/${BUILD_IDENTIFIER}"
 
 kernel="${images_dir}/${target}/${isar_base_name}-vmlinuz"
 kernel_suffix="vmlinuz"
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index de63b28..c090d83 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -27,7 +27,7 @@ echo "connect to lava server: ${lava_master_uri}"
 lavacli identities add --token "${LAVA_MASTER_TOKEN}" --uri "${lava_master_uri}" --username "${LAVA_MASTER_ACCOUNT}" default
 
 #generate lava job description from template
-DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
+DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${BUILD_IDENTIFIER}"
 export DEPLOY_URL
 
 echo "Deploy artifacts from '${artifact_url}'"
-- 
2.31.1


