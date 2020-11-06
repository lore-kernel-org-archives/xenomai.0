From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 1/4] ci: Split build and add 5.4 builds
Date: Fri,  6 Nov 2020 15:56:29 +0100
Message-Id: <20201106145632.2951-2-Quirin.Gylstorff@siemens.com>
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

Split the ci build description in 4.4(xenomai-3.0.x), 4.19 and 5.4.
This allows the reuse of build descriptions and simplifies the adding
of new builds.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/4_19_builds.yml                           |  82 +++++++++++++
 ci/5_4_builds.yml                            |  38 ++++++
 ci/artifacts.yml                             |   1 +
 ci/default-builds.yml                        |  76 ++++++++++++
 ci/gitlab-ci-base.yml                        | 116 ++-----------------
 ci/xenomai_3_0_x.yml                         |  36 ++++++
 opt-linux-4.19.yml                           |  17 +++
 opt-linux-latest-5.4.yml                     |  18 +++
 opt-linux-latest.yml                         |   1 +
 recipes-kernel/linux/linux-xenomai_latest.bb |   6 +-
 10 files changed, 282 insertions(+), 109 deletions(-)
 create mode 100644 ci/4_19_builds.yml
 create mode 100644 ci/5_4_builds.yml
 create mode 100644 ci/default-builds.yml
 create mode 100644 ci/xenomai_3_0_x.yml
 create mode 100644 opt-linux-4.19.yml
 create mode 100644 opt-linux-latest-5.4.yml

diff --git a/ci/4_19_builds.yml b/ci/4_19_builds.yml
new file mode 100644
index 0000000..f98edc4
--- /dev/null
+++ b/ci/4_19_builds.yml
@@ -0,0 +1,82 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-4.19:board-qemu-amd64:
+  extends: .build:board-qemu-amd64
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+
+lava-test-4.19:qemu-amd64:
+  needs: [ "build-4.19:board-qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+    BUILD_IDENTIFIER: "4.19"
+
+build-4.19:board-qemu-armhf:
+  extends: .build:board-qemu-armhf
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+
+lava-test-4.19:qemu-armhf:
+  needs: [ "build-4.19:board-qemu-armhf" ]
+  extends: .lava-test:qemu-armhf
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+    BUILD_IDENTIFIER: "4.19"
+
+build-4.19:board-qemu-arm64:
+  extends: .build:board-qemu-arm64
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+
+lava-test-4.19:qemu-arm64:
+  needs: [ "build-4.19:board-qemu-arm64" ]
+  extends: .lava-test:qemu-arm64
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+    BUILD_IDENTIFIER: "4.19"
+
+build-4.19:board-hikey:
+  extends: .build:board-hikey
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+
+lava-test-4.19:board-hikey:
+  needs: [ "build-4.19:board-hikey" ]
+  extends: .lava-test:board-hikey
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+    BUILD_IDENTIFIER: "4.19"
+
+build-4.19:board-beagle-bone-black:
+  extends: .build:board-beagle-bone-black
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+
+lava-test-4.19:board-beagle-bone-black:
+  needs: [ "build-4.19:board-beagle-bone-black" ]
+  extends: .lava-test:board-beagle-bone-black
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+    BUILD_IDENTIFIER: "4.19"
+
+build-4.19:board-x86-64-efi:
+  extends: .build:board-x86-64-efi
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+
+lava-test-4.19:board-x86-64-efi:
+  needs: [ "build-4.19:board-x86-64-efi" ]
+  extends: .lava-test:board-x86-64-efi
+  variables:
+    DEPLOY_DIR_EXTENSION: "4.19"
+    BUILD_IDENTIFIER: "4.19"
diff --git a/ci/5_4_builds.yml b/ci/5_4_builds.yml
new file mode 100644
index 0000000..4e8ea76
--- /dev/null
+++ b/ci/5_4_builds.yml
@@ -0,0 +1,38 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-5.4:board-qemu-amd64:
+  extends: .build:board-qemu-amd64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    DEPLOY_DIR_EXTENSION: "5.4"
+
+lava-test-5.4:qemu-amd64:
+  needs: [ "build-5.4:board-qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.4"
+    BUILD_IDENTIFIER: "5.4"
+
+
+build-5.4:board-x86-64-efi:
+  extends: .build:board-x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    DEPLOY_DIR_EXTENSION: "5.4"
+
+
+lava-test-5.4:board-x86-64-efi:
+  needs: [ "build-5.4:board-x86-64-efi" ]
+  extends: .lava-test:board-x86-64-efi
+  variables:
+    DEPLOY_DIR_EXTENSION: "5.4"
+    BUILD_IDENTIFIER: "5.4"
diff --git a/ci/artifacts.yml b/ci/artifacts.yml
index 510f903..3b88f7f 100644
--- a/ci/artifacts.yml
+++ b/ci/artifacts.yml
@@ -17,5 +17,6 @@
     paths:
     - build/tmp/deploy/images/${TARGET}/
     expire_in: 1 week
+
 include:
   - local: '/ci/gitlab-ci-base.yml'
diff --git a/ci/default-builds.yml b/ci/default-builds.yml
new file mode 100644
index 0000000..a0a2a89
--- /dev/null
+++ b/ci/default-builds.yml
@@ -0,0 +1,76 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+.build:board-qemu-amd64:
+  extends: .build
+  variables:
+    TARGET: qemu-amd64
+    BUILD_OPTIONS: ":opt-ext4-gz.yml"
+
+.lava-test:qemu-amd64:
+  extends: .test
+  variables:
+    TARGET: qemu-amd64
+
+.build:board-qemu-armhf:
+  extends: .build
+  variables:
+    TARGET: qemu-armhf
+    BUILD_OPTIONS: ":opt-ext4-gz.yml"
+
+.lava-test:qemu-armhf:
+  extends: .test
+  variables:
+    TARGET: qemu-armhf
+
+.build:board-qemu-arm64:
+  extends: .build
+  variables:
+    TARGET: qemu-arm64
+    BUILD_OPTIONS: ":opt-ext4-gz.yml"
+
+.lava-test:qemu-arm64:
+  extends: .test
+  variables:
+    TARGET: qemu-arm64
+
+.build:board-hikey:
+  extends: .build
+  variables:
+    TARGET: hikey
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+
+.lava-test:board-hikey:
+  extends: .test
+  variables:
+    TARGET: hikey
+
+.build:board-beagle-bone-black:
+  extends: .build
+  variables:
+    TARGET: beagle-bone-black
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+
+.lava-test:board-beagle-bone-black:
+  extends: .test
+  variables:
+    TARGET: beagle-bone-black
+
+.build:board-x86-64-efi:
+  extends: .build
+  variables:
+    TARGET: x86-64-efi
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+
+.lava-test:board-x86-64-efi:
+  extends: .test
+  variables:
+    TARGET: x86-64-efi
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 18419a8..15fd74a 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -10,7 +10,7 @@
 #
 stages:
   - build
-  - lava-test
+  - test
 
 variables:
   GIT_STRATEGY: clone
@@ -37,119 +37,19 @@ default:
 
 .test:
   extends: .add-lava-ssh-config
-  stage: lava-test
+  stage: test
   script:
     - scripts/install-lavacli.sh
     - export BUILD_JOB_ID=$(scripts/get-build-id.sh ${BUILD_JOB_NAME})
     - scripts/run-lava-tests.sh ${TARGET}
   variables:
-    BUILD_JOB_NAME: "build:board-${TARGET}${TARGET_EXTENSION}"
+    BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:board-${TARGET}${TARGET_EXTENSION}"
   only:
     variables:
       - $LAVA_SSH_USER
 
-
-build:board-qemu-amd64:
-  extends: .build
-  variables:
-    TARGET: qemu-amd64
-    BUILD_OPTIONS: ":opt-ext4-gz.yml"
-
-lava-test:qemu-amd64:
-  needs: [ "build:board-qemu-amd64" ]
-  dependencies: [ "build:board-qemu-amd64" ]
-  extends: .test
-  variables:
-    TARGET: qemu-amd64
-
-build:board-qemu-armhf:
-  extends: .build
-  variables:
-    TARGET: qemu-armhf
-    BUILD_OPTIONS: ":opt-ext4-gz.yml"
-
-lava-test:qemu-armhf:
-  needs: [ "build:board-qemu-armhf" ]
-  extends: .test
-  variables:
-    TARGET: qemu-armhf
-
-build:board-qemu-arm64:
-  extends: .build
-  variables:
-    TARGET: qemu-arm64
-    BUILD_OPTIONS: ":opt-ext4-gz.yml"
-
-lava-test:qemu-arm64:
-  needs: [ "build:board-qemu-arm64" ]
-  extends: .test
-  variables:
-    TARGET: qemu-arm64
-
-build:board-hikey:
-  extends: .build
-  variables:
-    TARGET: hikey
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-
-lava-test:board-hikey:
-  needs: [ "build:board-hikey" ]
-  extends: .test
-  variables:
-    TARGET: hikey
-
-build:board-beagle-bone-black:
-  extends: .build
-  variables:
-    TARGET: beagle-bone-black
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-
-lava-test:board-beagle-bone-black:
-  needs: [ "build:board-beagle-bone-black" ]
-  extends: .test
-  variables:
-    TARGET: beagle-bone-black
-
-build:board-x86-64-efi:
-  extends: .build
-  variables:
-    TARGET: x86-64-efi
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-
-lava-test:board-x86-64-efi:
-  needs: [ "build:board-x86-64-efi" ]
-  extends: .test
-  variables:
-    TARGET: x86-64-efi
-
-build:board-beagle-bone-black:xenomai-3.0.x:
-  extends: .build
-  variables:
-    TARGET: beagle-bone-black
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
-
-lava-test:board-beagle-bone-black:xenomai-3.0.x:
-  needs: [ "build:board-beagle-bone-black:xenomai-3.0.x" ]
-  extends: .test
-  variables:
-    TARGET: beagle-bone-black
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
-    TARGET_EXTENSION: ":xenomai-3.0.x"
-
-build:board-x86-64-efi:xenomai-3.0.x:
-  extends: .build
-  variables:
-    TARGET: x86-64-efi
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
-
-lava-test:board-x86-64-efi:xenomai-3.0.x:
-  needs: [ "build:board-x86-64-efi:xenomai-3.0.x" ]
-  extends: .test
-  variables:
-    TARGET: x86-64-efi
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
-    TARGET_EXTENSION: ":xenomai-3.0.x"
+include:
+  - local: '/ci/default-builds.yml'
+  - local: '/ci/4_19_builds.yml'
+  - local: '/ci/5_4_builds.yml'
+  - local: '/ci/xenomai_3_0_x.yml'
diff --git a/ci/xenomai_3_0_x.yml b/ci/xenomai_3_0_x.yml
new file mode 100644
index 0000000..9dbd8d4
--- /dev/null
+++ b/ci/xenomai_3_0_x.yml
@@ -0,0 +1,36 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-4.4:board-beagle-bone-black:
+  extends: .build:board-beagle-bone-black
+  variables:
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+
+lava-test-4.4:board-beagle-bone-black:
+  needs: [ "build-4.4:board-beagle-bone-black" ]
+  extends: .lava-test:board-beagle-bone-black
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+    BUILD_IDENTIFIER: "4.4"
+
+build-4.4:board-x86-64-efi:
+  extends: .build:board-x86-64-efi
+  variables:
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+
+lava-test-4.4:board-x86-64-efi:
+  needs: [ "build-4.4:board-x86-64-efi" ]
+  extends: .lava-test:board-x86-64-efi
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+    BUILD_IDENTIFIER: "4.4"
diff --git a/opt-linux-4.19.yml b/opt-linux-4.19.yml
new file mode 100644
index 0000000..1613e1c
--- /dev/null
+++ b/opt-linux-4.19.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2020
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
+local_conf_header:
+  linux-xenomai-latest: |
+    PREFERRED_VERSION_linux-xenomai = "4.19%"
diff --git a/opt-linux-latest-5.4.yml b/opt-linux-latest-5.4.yml
new file mode 100644
index 0000000..6ce3a3b
--- /dev/null
+++ b/opt-linux-latest-5.4.yml
@@ -0,0 +1,18 @@
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
+local_conf_header:
+  linux-xenomai-latest: |
+    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    LATEST_GIT_BRANCH = "4.19"
diff --git a/opt-linux-latest.yml b/opt-linux-latest.yml
index 7cf291a..6ce3a3b 100644
--- a/opt-linux-latest.yml
+++ b/opt-linux-latest.yml
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   linux-xenomai-latest: |
     PREFERRED_VERSION_linux-xenomai = "9999-%"
+    LATEST_GIT_BRANCH = "4.19"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 9fc6a63..f7d9e1b 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -18,8 +18,12 @@ def is_xeno_3_0(d):
     xeno_ver = d.getVar('PREFERRED_VERSION_xenomai') or ''
     return xeno_ver.startswith('3.0') or xeno_ver == 'stable-3.0.x'
 
+def is_5_4_branch(d):
+    linux_ver = d.getVar('LATEST_GIT_BRANCH') or ''
+    return linux_ver.startswith('5.4')
+
 GIT_REPO_amd64 = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-x86.git'}"
-GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe-x86-5.4.y'}"
+GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe-x86-5.4.y' if is_5_4_branch(d) else 'ipipe-x86-4.19.y-cip'}"
 
 GIT_REPO_armhf = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-arm.git'}"
 GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe/master'}"
-- 
2.20.1


