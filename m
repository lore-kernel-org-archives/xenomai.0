From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 2/2] ci: Introduce parent-child pipelines
Date: Fri, 18 Dec 2020 10:49:45 +0100
Message-Id: <20201218094945.6941-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201218094945.6941-1-Quirin.Gylstorff@siemens.com>
References: <20201218094945.6941-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, Jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

After adding the necessary builds for xenomai-3.1,
we have 16 jobs in each stage. This many jobs decrease
the clarity of the ci pipeline. This commit splits the
pipeline into the following child pipelines[1]:
- xenomai 3.0.x with kernel 4.4
- xenomai 3.1.x with kernel 4.19
- xenomai next with kernel 4.19 and kernel 5.4

[1]: https://docs.gitlab.com/ee/ci/parent_child_pipelines.html

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci-artifacts.yml                      |  6 +-
 .gitlab-ci.yml                                |  3 +-
 ci/artifacts.yml                              | 22 -----
 ci/child_pipelines.yml                        | 34 +++++++
 ci/default-builds.yml                         | 76 ---------------
 ci/gitlab-ci-base.yml                         | 94 +++++++++++++++++--
 ...uilds.yml => kernel_4_19_xenomai_next.yml} | 42 ++++-----
 ...builds.yml => kernel_5_4_xenomai_next.yml} | 16 ++--
 ci/no-artifacts.yml                           | 21 -----
 ci/xenomai_3_0_x.yml                          | 16 ++--
 ci/xenomai_3_1_x.yml                          | 45 +++++----
 ci/xenomai_next.yml                           | 14 +++
 12 files changed, 196 insertions(+), 193 deletions(-)
 delete mode 100644 ci/artifacts.yml
 create mode 100644 ci/child_pipelines.yml
 delete mode 100644 ci/default-builds.yml
 rename ci/{4_19_builds.yml => kernel_4_19_xenomai_next.yml} (55%)
 rename ci/{5_4_builds.yml => kernel_5_4_xenomai_next.yml} (64%)
 delete mode 100644 ci/no-artifacts.yml
 create mode 100644 ci/xenomai_next.yml

diff --git a/.gitlab-ci-artifacts.yml b/.gitlab-ci-artifacts.yml
index e6576dc..8a75eb3 100644
--- a/.gitlab-ci-artifacts.yml
+++ b/.gitlab-ci-artifacts.yml
@@ -8,5 +8,9 @@
 #
 # SPDX-License-Identifier: MIT
 #
+
+variables:
+  USE_GITLAB_ARTIFACTS: "true"
+
 include:
-  - local: '/ci/artifacts.yml'
+  - local: '/ci/child_pipelines.yml'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0e547f0..ccb5496 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -8,5 +8,6 @@
 #
 # SPDX-License-Identifier: MIT
 #
+
 include:
-  - local: '/ci/no-artifacts.yml'
+  - local: '/ci/child_pipelines.yml'
diff --git a/ci/artifacts.yml b/ci/artifacts.yml
deleted file mode 100644
index 3b88f7f..0000000
--- a/ci/artifacts.yml
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019 - 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-.build:
-  extends: .add-lava-ssh-config
-  stage: build
-  script:
-    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
-  artifacts:
-    paths:
-    - build/tmp/deploy/images/${TARGET}/
-    expire_in: 1 week
-
-include:
-  - local: '/ci/gitlab-ci-base.yml'
diff --git a/ci/child_pipelines.yml b/ci/child_pipelines.yml
new file mode 100644
index 0000000..883c8de
--- /dev/null
+++ b/ci/child_pipelines.yml
@@ -0,0 +1,34 @@
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
+stages:
+  - parent
+
+xenomai next:
+  stage: parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_next.yml'
+    strategy: depend
+
+xenomai 3.0.x:
+  stage: parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_0_x.yml'
+    strategy: depend
+
+xenomai 3.1.x:
+  stage: parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_1_x.yml'
+    strategy: depend
+
diff --git a/ci/default-builds.yml b/ci/default-builds.yml
deleted file mode 100644
index a0a2a89..0000000
--- a/ci/default-builds.yml
+++ /dev/null
@@ -1,76 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019 - 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-.build:board-qemu-amd64:
-  extends: .build
-  variables:
-    TARGET: qemu-amd64
-    BUILD_OPTIONS: ":opt-ext4-gz.yml"
-
-.lava-test:qemu-amd64:
-  extends: .test
-  variables:
-    TARGET: qemu-amd64
-
-.build:board-qemu-armhf:
-  extends: .build
-  variables:
-    TARGET: qemu-armhf
-    BUILD_OPTIONS: ":opt-ext4-gz.yml"
-
-.lava-test:qemu-armhf:
-  extends: .test
-  variables:
-    TARGET: qemu-armhf
-
-.build:board-qemu-arm64:
-  extends: .build
-  variables:
-    TARGET: qemu-arm64
-    BUILD_OPTIONS: ":opt-ext4-gz.yml"
-
-.lava-test:qemu-arm64:
-  extends: .test
-  variables:
-    TARGET: qemu-arm64
-
-.build:board-hikey:
-  extends: .build
-  variables:
-    TARGET: hikey
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-
-.lava-test:board-hikey:
-  extends: .test
-  variables:
-    TARGET: hikey
-
-.build:board-beagle-bone-black:
-  extends: .build
-  variables:
-    TARGET: beagle-bone-black
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-
-.lava-test:board-beagle-bone-black:
-  extends: .test
-  variables:
-    TARGET: beagle-bone-black
-
-.build:board-x86-64-efi:
-  extends: .build
-  variables:
-    TARGET: x86-64-efi
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-
-.lava-test:board-x86-64-efi:
-  extends: .test
-  variables:
-    TARGET: x86-64-efi
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index a93a7a0..ec25b38 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -48,9 +48,91 @@ default:
     variables:
       - $LAVA_SSH_USER
 
-include:
-  - local: '/ci/default-builds.yml'
-  - local: '/ci/4_19_builds.yml'
-  - local: '/ci/5_4_builds.yml'
-  - local: '/ci/xenomai_3_0_x.yml'
-  - local: '/ci/xenomai_3_1_x.yml'
+.build:
+  extends: .add-lava-ssh-config
+  stage: build
+  script:
+    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
+    - scripts/deploy_for_testing.sh ${TARGET}
+  except:
+    variables:
+      - $USE_GITLAB_ARTIFACTS
+
+.build:
+  extends: .add-lava-ssh-config
+  stage: build
+  script:
+    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
+  artifacts:
+    paths:
+    - build/tmp/deploy/images/${TARGET}/
+    expire_in: 1 week
+  only:
+    variables:
+      - $USE_GITLAB_ARTIFACTS
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
diff --git a/ci/4_19_builds.yml b/ci/kernel_4_19_xenomai_next.yml
similarity index 55%
rename from ci/4_19_builds.yml
rename to ci/kernel_4_19_xenomai_next.yml
index 80252af..f98edc4 100644
--- a/ci/4_19_builds.yml
+++ b/ci/kernel_4_19_xenomai_next.yml
@@ -9,80 +9,74 @@
 # SPDX-License-Identifier: MIT
 #
 
-build-4.19:board-qemu-amd64:xenomai-next:
+build-4.19:board-qemu-amd64:
   extends: .build:board-qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:qemu-amd64:xenomai-next:
-  needs: [ "build-4.19:board-qemu-amd64:xenomai-next" ]
+lava-test-4.19:qemu-amd64:
+  needs: [ "build-4.19:board-qemu-amd64" ]
   extends: .lava-test:qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-next"
 
-build-4.19:board-qemu-armhf:xenomai-next:
+build-4.19:board-qemu-armhf:
   extends: .build:board-qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:qemu-armhf:xenomai-next:
-  needs: [ "build-4.19:board-qemu-armhf:xenomai-next" ]
+lava-test-4.19:qemu-armhf:
+  needs: [ "build-4.19:board-qemu-armhf" ]
   extends: .lava-test:qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-next"
 
-build-4.19:board-qemu-arm64:xenomai-next:
+build-4.19:board-qemu-arm64:
   extends: .build:board-qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:qemu-arm64:xenomai-next:
-  needs: [ "build-4.19:board-qemu-arm64:xenomai-next" ]
+lava-test-4.19:qemu-arm64:
+  needs: [ "build-4.19:board-qemu-arm64" ]
   extends: .lava-test:qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-next"
 
-build-4.19:board-hikey:xenomai-next:
+build-4.19:board-hikey:
   extends: .build:board-hikey
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:board-hikey:xenomai-next:
-  needs: [ "build-4.19:board-hikey:xenomai-next" ]
+lava-test-4.19:board-hikey:
+  needs: [ "build-4.19:board-hikey" ]
   extends: .lava-test:board-hikey
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-next"
 
-build-4.19:board-beagle-bone-black:xenomai-next:
+build-4.19:board-beagle-bone-black:
   extends: .build:board-beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:board-beagle-bone-black:xenomai-next:
-  needs: [ "build-4.19:board-beagle-bone-black:xenomai-next" ]
+lava-test-4.19:board-beagle-bone-black:
+  needs: [ "build-4.19:board-beagle-bone-black" ]
   extends: .lava-test:board-beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-next"
 
-build-4.19:board-x86-64-efi:xenomai-next:
+build-4.19:board-x86-64-efi:
   extends: .build:board-x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
 
-lava-test-4.19:board-x86-64-efi:xenomai-next:
-  needs: [ "build-4.19:board-x86-64-efi:xenomai-next" ]
+lava-test-4.19:board-x86-64-efi:
+  needs: [ "build-4.19:board-x86-64-efi" ]
   extends: .lava-test:board-x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "4.19"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-next"
diff --git a/ci/5_4_builds.yml b/ci/kernel_5_4_xenomai_next.yml
similarity index 64%
rename from ci/5_4_builds.yml
rename to ci/kernel_5_4_xenomai_next.yml
index d7f10fa..4d366dc 100644
--- a/ci/5_4_builds.yml
+++ b/ci/kernel_5_4_xenomai_next.yml
@@ -9,32 +9,28 @@
 # SPDX-License-Identifier: MIT
 #
 
-build-5.4:board-qemu-amd64:xenomai-next:
+build-5.4:board-qemu-amd64:
   extends: .build:board-qemu-amd64
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     DEPLOY_DIR_EXTENSION: "5.4"
 
-lava-test-5.4:qemu-amd64:xenomai-next:
-  needs: [ "build-5.4:board-qemu-amd64:xenomai-next" ]
+lava-test-5.4:qemu-amd64:
+  needs: [ "build-5.4:board-qemu-amd64" ]
   extends: .lava-test:qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
-    TARGET_EXTENSION: ":xenomai-next"
 
-
-build-5.4:board-x86-64-efi:xenomai-next:
+build-5.4:board-x86-64-efi:
   extends: .build:board-x86-64-efi
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     DEPLOY_DIR_EXTENSION: "5.4"
 
-
-lava-test-5.4:board-x86-64-efi:xenomai-next:
-  needs: [ "build-5.4:board-x86-64-efi:xenomai-next" ]
+lava-test-5.4:board-x86-64-efi:
+  needs: [ "build-5.4:board-x86-64-efi" ]
   extends: .lava-test:board-x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "5.4"
     BUILD_IDENTIFIER: "5.4"
-    TARGET_EXTENSION: ":xenomai-next"
diff --git a/ci/no-artifacts.yml b/ci/no-artifacts.yml
deleted file mode 100644
index 02457de..0000000
--- a/ci/no-artifacts.yml
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019 - 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-.build:
-  extends: .add-lava-ssh-config
-  stage: build
-  script:
-    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
-    - scripts/deploy_for_testing.sh ${TARGET}
-  except:
-    variables:
-      - $USE_GITLAB_ARTIFACTS
-include:
-  - local: '/ci/gitlab-ci-base.yml'
diff --git a/ci/xenomai_3_0_x.yml b/ci/xenomai_3_0_x.yml
index 6b868a9..6a314b5 100644
--- a/ci/xenomai_3_0_x.yml
+++ b/ci/xenomai_3_0_x.yml
@@ -8,31 +8,31 @@
 #
 # SPDX-License-Identifier: MIT
 #
+include:
+  - local: '/ci/gitlab-ci-base.yml'
 
-build-4.4:board-beagle-bone-black:xenomai-3.0.x:
+build-4.4:board-beagle-bone-black:
   extends: .build:board-beagle-bone-black
   variables:
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
 
-lava-test-4.4:board-beagle-bone-black:xenomai-3.0.x:
-  needs: [ "build-4.4:board-beagle-bone-black:xenomai-3.0.x" ]
+lava-test-4.4:board-beagle-bone-black:
+  needs: [ "build-4.4:board-beagle-bone-black" ]
   extends: .lava-test:board-beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
     BUILD_IDENTIFIER: "4.4"
-    TARGET_EXTENSION: ":xenomai-3.0.x"
 
-build-4.4:board-x86-64-efi:xenomai-3.0.x:
+build-4.4:board-x86-64-efi:
   extends: .build:board-x86-64-efi
   variables:
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
 
-lava-test-4.4:board-x86-64-efi:xenomai-3.0.x:
-  needs: [ "build-4.4:board-x86-64-efi:xenomai-3.0.x" ]
+lava-test-4.4:board-x86-64-efi:
+  needs: [ "build-4.4:board-x86-64-efi" ]
   extends: .lava-test:board-x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
     BUILD_IDENTIFIER: "4.4"
-    TARGET_EXTENSION: ":xenomai-3.0.x"
diff --git a/ci/xenomai_3_1_x.yml b/ci/xenomai_3_1_x.yml
index d083461..19eaf38 100644
--- a/ci/xenomai_3_1_x.yml
+++ b/ci/xenomai_3_1_x.yml
@@ -8,87 +8,84 @@
 #
 # SPDX-License-Identifier: MIT
 #
+include:
+  - local: '/ci/gitlab-ci-base.yml'
 
-build-4.19:board-qemu-amd64:xenomai-3.1.x:
+
+build-4.19:board-qemu-amd64:
   extends: .build:board-qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
-lava-test-4.19:qemu-amd64:xenomai-3.1.x:
-  needs: [ "build-4.19:board-qemu-amd64:xenomai-3.1.x" ]
+lava-test-4.19:qemu-amd64:
+  needs: [ "build-4.19:board-qemu-amd64" ]
   extends: .lava-test:qemu-amd64
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-3.1.x"
 
-build-4.19:board-qemu-armhf:xenomai-3.1.x:
+build-4.19:board-qemu-armhf:
   extends: .build:board-qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
-lava-test-4.19:qemu-armhf:xenomai-3.1.x:
-  needs: [ "build-4.19:board-qemu-armhf:xenomai-3.1.x" ]
+lava-test-4.19:qemu-armhf:
+  needs: [ "build-4.19:board-qemu-armhf" ]
   extends: .lava-test:qemu-armhf
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-3.1.x"
 
-build-4.19:board-qemu-arm64:xenomai-3.1.x:
+build-4.19:board-qemu-arm64:
   extends: .build:board-qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
-lava-test-4.19:qemu-arm64:xenomai-3.1.x:
-  needs: [ "build-4.19:board-qemu-arm64:xenomai-3.1.x" ]
+lava-test-4.19:qemu-arm64:
+  needs: [ "build-4.19:board-qemu-arm64" ]
   extends: .lava-test:qemu-arm64
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-3.1.x"
 
-build-4.19:board-hikey:xenomai-3.1.x:
+build-4.19:board-hikey:
   extends: .build:board-hikey
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
-lava-test-4.19:board-hikey:xenomai-3.1.x:
-  needs: [ "build-4.19:board-hikey:xenomai-3.1.x" ]
+lava-test-4.19:board-hikey:
+  needs: [ "build-4.19:board-hikey" ]
   extends: .lava-test:board-hikey
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-3.1.x"
 
-build-4.19:board-beagle-bone-black:xenomai-3.1.x:
+build-4.19:board-beagle-bone-black:
   extends: .build:board-beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
-lava-test-4.19:board-beagle-bone-black:xenomai-3.1.x:
-  needs: [ "build-4.19:board-beagle-bone-black:xenomai-3.1.x" ]
+lava-test-4.19:board-beagle-bone-black:
+  needs: [ "build-4.19:board-beagle-bone-black" ]
   extends: .lava-test:board-beagle-bone-black
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-3.1.x"
 
-build-4.19:board-x86-64-efi:xenomai-3.1.x:
+build-4.19:board-x86-64-efi:
   extends: .build:board-x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
 
-lava-test-4.19:board-x86-64-efi:xenomai-3.1.x:
-  needs: [ "build-4.19:board-x86-64-efi:xenomai-3.1.x" ]
+lava-test-4.19:board-x86-64-efi:
+  needs: [ "build-4.19:board-x86-64-efi" ]
   extends: .lava-test:board-x86-64-efi
   variables:
     DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
     BUILD_IDENTIFIER: "4.19"
-    TARGET_EXTENSION: ":xenomai-3.1.x"
diff --git a/ci/xenomai_next.yml b/ci/xenomai_next.yml
new file mode 100644
index 0000000..6d964a6
--- /dev/null
+++ b/ci/xenomai_next.yml
@@ -0,0 +1,14 @@
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
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/kernel_4_19_xenomai_next.yml'
+  - local: '/ci/kernel_5_4_xenomai_next.yml'
-- 
2.20.1


