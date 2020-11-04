From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 3/4] ci: Split build and add 5.4 builds
Date: Wed,  4 Nov 2020 17:11:53 +0100
Message-Id: <20201104161154.32366-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
References: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
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
 ci/4_19_builds.yml                           |  58 ++++++++++
 ci/5_4_builds.yml                            |  30 +++++
 ci/artifacts.yml                             |   4 +
 ci/default-builds.yml                        |  76 +++++++++++++
 ci/gitlab-ci-base.yml                        | 110 +------------------
 ci/no-artifacts.yml                          |   4 +
 ci/xenomai_3_0_x.yml                         |  36 ++++++
 opt-linux-4.19.yml                           |  17 +++
 opt-linux-latest.yml                         |   3 +
 recipes-kernel/linux/linux-xenomai_latest.bb |   6 +-
 scripts/get-build-id.sh                      |   2 +-
 11 files changed, 237 insertions(+), 109 deletions(-)
 create mode 100644 ci/4_19_builds.yml
 create mode 100644 ci/5_4_builds.yml
 create mode 100644 ci/default-builds.yml
 create mode 100644 ci/xenomai_3_0_x.yml
 create mode 100644 opt-linux-4.19.yml

diff --git a/ci/4_19_builds.yml b/ci/4_19_builds.yml
new file mode 100644
index 0000000..25be0c5
--- /dev/null
+++ b/ci/4_19_builds.yml
@@ -0,0 +1,58 @@
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
+variables:
+  LATEST_GIT_BRANCH: "4.19"
+  DEPLOY_DIR_EXTENSION: "4.19"
+  BUILD_IDENTIFIER: "4.19"
+
+build-4.19:board-qemu-amd64:
+  extends: .build:board-qemu-amd64
+
+lava-test-4.19:qemu-amd64:
+  needs: [ "build-4.19:board-qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+
+build-4.19:board-qemu-armhf:
+  extends: .build:board-qemu-armhf
+
+lava-test-4.19:qemu-armhf:
+  needs: [ "build-4.19:board-qemu-armhf" ]
+  extends: .lava-test:qemu-armhf
+
+build-4.19:board-qemu-arm64:
+  extends: .build:board-qemu-arm64
+
+lava-test-4.19:qemu-arm64:
+  needs: [ "build-4.19:board-qemu-arm64" ]
+  extends: .lava-test:qemu-arm64
+
+build-4.19:board-hikey:
+  extends: .build:board-hikey
+
+lava-test-4.19:board-hikey:
+  needs: [ "build-4.19:board-hikey" ]
+  extends: .lava-test:board-hikey
+
+build-4.19:board-beagle-bone-black:
+  extends: .build:board-beagle-bone-black
+
+lava-test-4.19:board-beagle-bone-black:
+  needs: [ "build-4.19:board-beagle-bone-black" ]
+  extends: .lava-test:board-beagle-bone-black
+
+build-4.19:board-x86-64-efi:
+  extends: .build:board-x86-64-efi
+
+lava-test-4.19:board-x86-64-efi:
+  needs: [ "build-4.19:board-x86-64-efi" ]
+  extends: .lava-test:board-x86-64-efi
+
+
diff --git a/ci/5_4_builds.yml b/ci/5_4_builds.yml
new file mode 100644
index 0000000..b5cfdb9
--- /dev/null
+++ b/ci/5_4_builds.yml
@@ -0,0 +1,30 @@
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
+variables:
+  LATEST_GIT_BRANCH: "5.4"
+  DEPLOY_DIR_EXTENSION: "5.4"
+  BUILD_IDENTIFIER: "5.4"
+
+build-5.4:board-qemu-amd64:
+  extends: .build:board-qemu-amd64
+
+lava-test-5.4:qemu-amd64:
+  needs: [ "build-5.4:board-qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+
+build-5.4:board-x86-64-efi:
+  extends: .build:board-x86-64-efi
+
+lava-test-5.4:board-x86-64-efi:
+  needs: [ "build-5.4:board-x86-64-efi" ]
+  extends: .lava-test:board-x86-64-efi
+
+
diff --git a/ci/artifacts.yml b/ci/artifacts.yml
index 510f903..cc42274 100644
--- a/ci/artifacts.yml
+++ b/ci/artifacts.yml
@@ -19,3 +19,7 @@
     expire_in: 1 week
 include:
   - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/default-builds.yml'
+  - local: '/ci/4_19_builds.yml'
+  - local: '/ci/5_4_builds.yml'
+  - local: '/ci/xenomai_3_0_x.yml'
diff --git a/ci/default-builds.yml b/ci/default-builds.yml
new file mode 100644
index 0000000..6979dd3
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
+
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 18419a8..a766a9e 100644
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
@@ -37,119 +37,15 @@ default:
 
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
diff --git a/ci/no-artifacts.yml b/ci/no-artifacts.yml
index 02457de..517446e 100644
--- a/ci/no-artifacts.yml
+++ b/ci/no-artifacts.yml
@@ -19,3 +19,7 @@
       - $USE_GITLAB_ARTIFACTS
 include:
   - local: '/ci/gitlab-ci-base.yml'
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
diff --git a/opt-linux-latest.yml b/opt-linux-latest.yml
index 7cf291a..735c30e 100644
--- a/opt-linux-latest.yml
+++ b/opt-linux-latest.yml
@@ -12,6 +12,9 @@
 header:
   version: 8
 
+env:
+  LATEST_GIT_BRANCH: :LATEST_GIT_BRANCH
+
 local_conf_header:
   linux-xenomai-latest: |
     PREFERRED_VERSION_linux-xenomai = "9999-%"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 9fc6a63..b99a565 100644
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
+GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe-x86-5.4.y' if is_5_4_branch(d) else 'ipipe-x86-4.19.y'}"
 
 GIT_REPO_armhf = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-arm.git'}"
 GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe/master'}"
diff --git a/scripts/get-build-id.sh b/scripts/get-build-id.sh
index ace70c6..71f4413 100755
--- a/scripts/get-build-id.sh
+++ b/scripts/get-build-id.sh
@@ -17,7 +17,7 @@ if [ -z "${name}" ]; then
     fi
 index=0
 JSON=$(curl -s --header "PRIVATE-TOKEN: ${API_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/pipelines/${CI_PIPELINE_ID}/jobs?scope[]=success"  )
-while  [ ${index} -le ${MAX_TEST:-16} ]
+while  [ ${index} -le ${MAX_TEST:-26} ]
 do
     build_name=$(echo "${JSON}"  | tr '\r\n' ' ' | jq -r ".[${index}].name")
     if [ "$build_name" = "${name}" ]; then
-- 
2.20.1


